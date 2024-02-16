package kr.co.jhta.restaurants_service.security.service;

import kr.co.jhta.restaurants_service.controller.command.UserCommand;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.repository.RoleRepository;
import kr.co.jhta.restaurants_service.repository.UserRepository;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.vo.user.Role;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.jboss.logging.Logger;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserService implements UserDetailsService {

    private final Logger logger = Logger.getLogger(UserService.class);
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        User user = userRepository.findByUsername(username).orElse(null);

        // EAGER fetching on `user.roles`, so below 4 lines are done by Hibernate.
//        List<Role> roles = roleRepository.findByUserId(user.getId());
//        roles.forEach(role -> {
//            user.addRole(role);
//        });

        UserDetails userDetails = new SecurityUser(user);

        return userDetails;
    }

    public boolean existsDuplicateUsersByNickname(String nickname) {

        return userRepository.existsUserByNickname(nickname) ? true : false;
    }

    public boolean existsDuplicateUsersByUsername(String username) {

        return userRepository.existsUserByUsername(username) ? true : false;
    }

    public boolean existsDuplicateUsersByEmail(String email) {

        return userRepository.existsUserByEmail(email) ? true : false;
    }

    public boolean existsDuplicateUsersByPhone(String phone) {

        return userRepository.existsUserByPhone(phone) ? true : false;
    }

    public void insertCustomer(UserCommand userCommand) {
        User user = UserCommand.toCustomer(userCommand);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));

        Role role = new Role(user, "ROLE_CUSTOMER");
        user.addRole(role);

        userRepository.save(user);
    }

    public void insertOwner(UserCommand userCommand) {
        User user = UserCommand.toOwner(userCommand);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));

        Role role = new Role(user, "ROLE_OWNER");
        user.addRole(role);

        userRepository.save(user);
    }

    public User getUserById(int userId) {

        return userRepository.findUserById(userId).orElse(null);
    }

    public void modifyVisibility(SecurityUser securityUser) {
        User user = securityUser.getUser();
        if (user.getVisibility().equals(User.VISIBILITY.PUBLIC)) {
            user.setVisibility(User.VISIBILITY.PRIVATE);
            userRepository.save(user);
        } else { // from PRIVATE to PUBLIC
            user.setVisibility(User.VISIBILITY.PUBLIC);
            userRepository.save(user);
        }
    }
}


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22A01E5C1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfENXtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:41 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:43315 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENXtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:41 -0400
Received: by mail-qt1-f175.google.com with SMTP id i26so1186840qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KpfNuvqNu3/sVb2aStopFsd7NJVmrQALKhZUo1BvIg=;
        b=EMpSBCqmCZGjNsei+tEHj9FU9QK3JixAFJmMlBiFIs0/Z7B67CSmc6vDgzKrhPWEop
         pPQXHzs0oTVmABLb7bJfmu35EtnGTFSZ0gFOpX+DR/c7JjdtSALnckD2kdczvkU3+eQh
         87W5EHquNjBZKYMDGkTGGnqXDPBMBQCJsMfhpFqV9zq55vptdVIsvy+lZlQbenwVQC60
         UzPRRmAW+omMRtF4kIHmNbatG9gv2KDno6J52s1ccv0YF81jaWa0LXIw/5DsKHyN6Xnm
         LiSfo0mJlRSJJw7IgsTE5xnU9CwEioo/EJzYOHX1KMhlAed152dBdOymQpm1QFdJpW2H
         zMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KpfNuvqNu3/sVb2aStopFsd7NJVmrQALKhZUo1BvIg=;
        b=YL+AELjzUmtZW3KJxJOMI9ismvoPHu+s/CInOxvU2I33AFVFMy+Bpoal2qpKtgD4Fu
         +G1pNoP+4joQuBpJp6kFIejiTuQtC1VvXTs4s7oMm2YN+pEPEzqz2Bip9enNU7oXOj+G
         4IyWTQEunyZhVJnAL19sIvL6Jz6w0owoH8HAy1dTVd67R69O/drHQ5hImg68dg2esR9x
         RM11Hdn0lG1xjOc7AO2y+vJH6K6HxwOfQaIvti4oDQe1GE3Qm9utyVu508Idt0adOIlg
         fN0BZgn+hJwOYaC4OaoawHzt9n5QSdpsUYEmABuus+BpzEKQ6WLJnfILWbM5SyyPfU9o
         +UKg==
X-Gm-Message-State: APjAAAWcr8X4XYm8DF+Ce2BfJjLQhqWw+bkJ6u6FbrRSUXn5eTONFdpd
        tgjCC2ZWLoA8P1jOnaRxusWrLBDDiq8=
X-Google-Smtp-Source: APXvYqyWKAwHmP4ZnDJQsSqFCekIt1B1x2u9t/2CNZhWECCpLl0s5S6QRcvW6o8boQS6PA0TOwaYtA==
X-Received: by 2002:a0c:d1d0:: with SMTP id k16mr31039264qvh.59.1557877780025;
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 91sm224673qte.38.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001NJ-V5; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 07/20] ibdiags: Add cmake files for ibdiags components
Date:   Tue, 14 May 2019 20:49:23 -0300
Message-Id: <20190514234936.5175-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These are simple cmakefiles that emulate what the autotools stuff did.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt                          |  28 +++++-
 buildlib/check-build                    |   6 +-
 debian/rules                            |   1 +
 ibdiags/doc/rst/CMakeLists.txt          |  41 ++++++++
 ibdiags/libibmad/src/CMakeLists.txt     |  27 ++++++
 ibdiags/libibnetdisc/man/CMakeLists.txt |  14 +++
 ibdiags/libibnetdisc/src/CMakeLists.txt |  28 ++++++
 ibdiags/man/CMakeLists.txt              |  22 +++++
 ibdiags/scripts/CMakeLists.txt          | 119 ++++++++++++++++++++++++
 ibdiags/src/CMakeLists.txt              |  48 ++++++++++
 redhat/rdma-core.spec                   |   1 +
 suse/rdma-core.spec                     |   1 +
 12 files changed, 334 insertions(+), 2 deletions(-)
 create mode 100644 ibdiags/doc/rst/CMakeLists.txt
 create mode 100644 ibdiags/libibmad/src/CMakeLists.txt
 create mode 100644 ibdiags/libibnetdisc/man/CMakeLists.txt
 create mode 100644 ibdiags/libibnetdisc/src/CMakeLists.txt
 create mode 100644 ibdiags/man/CMakeLists.txt
 create mode 100644 ibdiags/scripts/CMakeLists.txt
 create mode 100644 ibdiags/src/CMakeLists.txt

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9428ce02191bc4..c54cf6606e3c0d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -45,6 +45,11 @@
 #   -DNO_PYVERBS=1 (default, build pyverbs)
 #      Invoke cython to build pyverbs. Usually you will run with this option
 #      is set, but it will be disabled for travis runs.
+#   -DWITH_IBDIAGS=False (default True)
+#      Do not build infiniband-diags components
+#   -DWITH_IBDIAGS_COMPAT=True (default False)
+#      Include obsolete scripts. These scripts are replaced by C programs with
+#      a different interface now.
 
 cmake_minimum_required(VERSION 2.8.11 FATAL_ERROR)
 project(rdma-core C)
@@ -79,6 +84,7 @@ set(IBVERBS_PROVIDER_SUFFIX "-rdmav${IBVERBS_PABI_VERSION}.so")
 if (IN_PLACE)
   set(CMAKE_INSTALL_SYSCONFDIR "${CMAKE_BINARY_DIR}/etc")
   set(CMAKE_INSTALL_BINDIR "${CMAKE_BINARY_DIR}/bin")
+  set(CMAKE_INSTALL_SBINDIR "${CMAKE_BINARY_DIR}/bin")
   set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}")
   set(CMAKE_INSTALL_LIBDIR "lib")
   set(CMAKE_INSTALL_INCLUDEDIR "include")
@@ -108,7 +114,6 @@ set(CMAKE_INSTALL_SYSTEMD_BINDIR "/lib/systemd"
 
 set(ACM_PROVIDER_DIR "${CMAKE_INSTALL_FULL_LIBDIR}/ibacm"
   CACHE PATH "Location for ibacm provider plugin shared library files.")
-
 # Location to find the provider plugin shared library files
 set(VERBS_PROVIDER_DIR "${CMAKE_INSTALL_FULL_LIBDIR}/libibverbs"
   CACHE PATH "Location for provider plugin shared library files. If set to empty the system search path is used.")
@@ -133,6 +138,15 @@ else()
   set(CMAKE_INSTALL_FULL_UDEV_RULESDIR "${CMAKE_INSTALL_UDEV_RULESDIR}")
 endif()
 
+# Allow the perl library dir to be configurable
+set(CMAKE_INSTALL_PERLDIR "share/perl5"
+  CACHE PATH "Location for system perl library, typically /usr/share/perl5")
+if(NOT IS_ABSOLUTE ${CMAKE_INSTALL_PERLDIR})
+  set(CMAKE_INSTALL_FULL_PERLDIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_PERLDIR}")
+else()
+  set(CMAKE_INSTALL_FULL_PERLDIR "${CMAKE_INSTALL_PERLDIR}")
+endif()
+
 # Location to place provider .driver files
 if (IN_PLACE)
   set(CONFIG_DIR "${BUILD_ETC}/libibverbs.d")
@@ -145,6 +159,8 @@ endif()
 set(DISTRO_FLAVOUR "None" CACHE
   STRING "Flavour of distribution to install for. This primarily impacts the init.d scripts installed.")
 
+set(WITH_IBDIAGS "True" CACHE BOOL "Build infiniband-diags stuff too")
+
 #-------------------------
 # Load CMake components
 set(BUILDLIB "${CMAKE_SOURCE_DIR}/buildlib")
@@ -604,6 +620,16 @@ add_subdirectory(providers/ipathverbs)
 add_subdirectory(providers/rxe)
 add_subdirectory(providers/rxe/man)
 
+if (WITH_IBDIAGS)
+add_subdirectory(ibdiags/libibmad/src)
+add_subdirectory(ibdiags/libibnetdisc/src)
+add_subdirectory(ibdiags/libibnetdisc/man)
+add_subdirectory(ibdiags/src)
+add_subdirectory(ibdiags/scripts)
+add_subdirectory(ibdiags/man)
+add_subdirectory(ibdiags/doc/rst)
+endif()
+
 if (CYTHON_EXECUTABLE)
   add_subdirectory(pyverbs)
 endif()
diff --git a/buildlib/check-build b/buildlib/check-build
index 348b0590f296ee..83358572b0b906 100755
--- a/buildlib/check-build
+++ b/buildlib/check-build
@@ -85,9 +85,13 @@ def check_lib_symver(args,fn):
         raise ValueError("Shared Library filename %r does not have the package version %r (%r)%"(
             fn,args.PACKAGE_VERSION,g.groups()));
 
-    # umad used the wrong symbol version name when they moved to soname 3.0
+    # umad/etc used the wrong symbol version name when they moved to soname 3.0
     if g.group(1) == "ibumad":
         newest_symver = "%s_%s.%s"%(g.group(1).upper(),'1',g.group(3));
+    elif g.group(1) == "ibmad":
+        newest_symver = "%s_%s.%s"%(g.group(1).upper(),'1',g.group(3));
+    elif g.group(1) == "ibnetdisc":
+        newest_symver = "%s_%s.%s"%(g.group(1).upper(),'1',g.group(3));
     else:
         newest_symver = "%s_%s.%s"%(g.group(1).upper(),g.group(2),g.group(3));
 
diff --git a/debian/rules b/debian/rules
index c84d9ef8f5ed54..744bf28c52f070 100755
--- a/debian/rules
+++ b/debian/rules
@@ -36,6 +36,7 @@ DH_AUTO_CONFIGURE := "--" \
 		     "-DCMAKE_INSTALL_RUNDIR:PATH=/run" \
 		     "-DCMAKE_INSTALL_UDEV_RULESDIR:PATH=/lib/udev/rules.d" \
 		     "-DENABLE_STATIC=1" \
+		     "-DWITH_IBDIAGS:BOOL=False" \
 		     $(EXTRA_CMAKE_FLAGS)
 
 override_dh_auto_configure:
diff --git a/ibdiags/doc/rst/CMakeLists.txt b/ibdiags/doc/rst/CMakeLists.txt
new file mode 100644
index 00000000000000..f0e4072306a57c
--- /dev/null
+++ b/ibdiags/doc/rst/CMakeLists.txt
@@ -0,0 +1,41 @@
+set(BUILD_DATE "2019")
+
+# rst2man has no way to set the include search path
+rdma_create_symlink("${CMAKE_CURRENT_SOURCE_DIR}/common" "${CMAKE_CURRENT_BINARY_DIR}/common")
+
+rdma_man_pages(
+  check_lft_balance.8.in.rst
+  dump_fts.8.in.rst
+  ibaddr.8.in.rst
+  ibcacheedit.8.in.rst
+  ibccconfig.8.in.rst
+  ibccquery.8.in.rst
+  ibfindnodesusing.8.in.rst
+  ibhosts.8.in.rst
+  ibidsverify.8.in.rst
+  iblinkinfo.8.in.rst
+  ibnetdiscover.8.in.rst
+  ibnodes.8.in.rst
+  ibping.8.in.rst
+  ibportstate.8.in.rst
+  ibqueryerrors.8.in.rst
+  ibroute.8.in.rst
+  ibrouters.8.in.rst
+  ibstat.8.in.rst
+  ibstatus.8.in.rst
+  ibswitches.8.in.rst
+  ibsysstat.8.in.rst
+  ibtracert.8.in.rst
+  infiniband-diags.8.in.rst
+  perfquery.8.in.rst
+  saquery.8.in.rst
+  sminfo.8.in.rst
+  smpdump.8.in.rst
+  smpquery.8.in.rst
+  vendstat.8.in.rst
+  )
+
+rdma_alias_man_pages(
+  dump_fts.8 dump_lfts.8
+  dump_fts.8 dump_mfts.8
+  )
diff --git a/ibdiags/libibmad/src/CMakeLists.txt b/ibdiags/libibmad/src/CMakeLists.txt
new file mode 100644
index 00000000000000..37da71a336324a
--- /dev/null
+++ b/ibdiags/libibmad/src/CMakeLists.txt
@@ -0,0 +1,27 @@
+publish_headers(infiniband
+  ../include/infiniband/mad.h
+  ../include/infiniband/mad_osd.h
+  )
+
+rdma_library(ibmad libibmad.map
+  # See Documentation/versioning.md
+  5 5.3.${PACKAGE_VERSION}
+  bm.c
+  cc.c
+  dump.c
+  fields.c
+  gs.c
+  mad.c
+  portid.c
+  register.c
+  resolve.c
+  rpc.c
+  sa.c
+  serv.c
+  smp.c
+  vendor.c
+  )
+target_link_libraries(ibmad LINK_PRIVATE
+  ibumad
+  )
+rdma_pkg_config("ibmad" "libibumad" "")
diff --git a/ibdiags/libibnetdisc/man/CMakeLists.txt b/ibdiags/libibnetdisc/man/CMakeLists.txt
new file mode 100644
index 00000000000000..01457ddbc86c72
--- /dev/null
+++ b/ibdiags/libibnetdisc/man/CMakeLists.txt
@@ -0,0 +1,14 @@
+rdma_man_pages(
+  ibnd_discover_fabric.3
+  ibnd_find_node_guid.3
+  ibnd_iter_nodes.3
+  )
+
+rdma_alias_man_pages(
+  ibnd_discover_fabric.3 ibnd_debug.3
+  ibnd_discover_fabric.3 ibnd_destroy_fabric.3
+  ibnd_discover_fabric.3 ibnd_set_max_smps_on_wire.3
+  ibnd_discover_fabric.3 ibnd_show_progress.3
+  ibnd_find_node_guid.3 ibnd_find_node_dr.3
+  ibnd_iter_nodes.3 ibnd_iter_nodes_type.3
+  )
diff --git a/ibdiags/libibnetdisc/src/CMakeLists.txt b/ibdiags/libibnetdisc/src/CMakeLists.txt
new file mode 100644
index 00000000000000..a71516ecc1eb60
--- /dev/null
+++ b/ibdiags/libibnetdisc/src/CMakeLists.txt
@@ -0,0 +1,28 @@
+publish_headers(infiniband
+  ../include/infiniband/ibnetdisc.h
+  ../include/infiniband/ibnetdisc_osd.h
+  )
+
+rdma_library(ibnetdisc libibnetdisc.map
+  # See Documentation/versioning.md
+  5 5.0.${PACKAGE_VERSION}
+  chassis.c
+  ibnetdisc.c
+  ibnetdisc_cache.c
+  query_smp.c
+  )
+target_link_libraries(ibnetdisc LINK_PRIVATE
+  ibmad
+  ibumad
+  osmcomp
+  )
+# FIXME for osmcomp
+target_include_directories(ibnetdisc PRIVATE "/usr/include/infiniband")
+rdma_pkg_config("ibnetdisc" "libibumad libibmad" "")
+
+rdma_test_executable(testleaks ../test/testleaks.c)
+target_link_libraries(testleaks LINK_PRIVATE
+  ibmad
+  ibnetdisc
+)
+target_include_directories(testleaks PRIVATE "/usr/include/infiniband")
diff --git a/ibdiags/man/CMakeLists.txt b/ibdiags/man/CMakeLists.txt
new file mode 100644
index 00000000000000..2446acbb522c86
--- /dev/null
+++ b/ibdiags/man/CMakeLists.txt
@@ -0,0 +1,22 @@
+if (WITH_IBDIAGS_COMPAT)
+  rdma_man_pages(
+    ibcheckerrors.8
+    ibcheckerrs.8
+    ibchecknet.8
+    ibchecknode.8
+    ibcheckport.8
+    ibcheckportstate.8
+    ibcheckportwidth.8
+    ibcheckstate.8
+    ibcheckwidth.8
+    ibclearcounters.8
+    ibclearerrors.8
+    ibdatacounters.8
+    ibdatacounts.8
+    ibdiscover.8
+    ibprintca.8
+    ibprintrt.8
+    ibprintswitch.8
+    ibswportwatch.8
+    )
+endif()
diff --git a/ibdiags/scripts/CMakeLists.txt b/ibdiags/scripts/CMakeLists.txt
new file mode 100644
index 00000000000000..3d65ed837a2d83
--- /dev/null
+++ b/ibdiags/scripts/CMakeLists.txt
@@ -0,0 +1,119 @@
+function(_rdma_sbin_interp INTERP IFN OFN)
+  configure_file("${IFN}" "${CMAKE_CURRENT_BINARY_DIR}/${OFN}" @ONLY)
+  file(WRITE "${BUILD_BIN}/${OFN}" "#!${INTERP} ${CMAKE_CURRENT_BINARY_DIR}/${OFN}")
+  execute_process(COMMAND "chmod" "a+x" "${BUILD_BIN}/${OFN}")
+
+  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${OFN}"
+    DESTINATION "${CMAKE_INSTALL_SBINDIR}"
+    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE)
+endfunction()
+
+function(_rdma_sbin_interp_link INTERP IFN OFN)
+  file(WRITE "${BUILD_BIN}/${OFN}" "#!${INTERP} ${CMAKE_CURRENT_SOURCE_DIR}/${IFN}")
+  execute_process(COMMAND "chmod" "a+x" "${BUILD_BIN}/${OFN}")
+
+  install(FILES "${IFN}"
+    DESTINATION "${CMAKE_INSTALL_SBINDIR}"
+    RENAME "${OFN}"
+    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE)
+endfunction()
+
+function(rdma_sbin_shell_program)
+  foreach(IFN ${ARGN})
+    if (IFN MATCHES "\\.sh\\.in")
+      if (DISTRO_FLAVOUR STREQUAL Debian)
+	string(REGEX REPLACE "^(.+)\\.sh\\.in$" "\\1" OFN "${IFN}")
+      else()
+	string(REGEX REPLACE "^(.+)\\.in$" "\\1" OFN "${IFN}")
+      endif()
+      _rdma_sbin_interp("/bin/bash" "${IFN}" "${OFN}")
+    elseif (IFN MATCHES "\\.in")
+      string(REGEX REPLACE "^(.+)\\.in$" "\\1" OFN "${IFN}")
+      _rdma_sbin_interp("/bin/bash" "${IFN}" "${OFN}")
+    elseif (IFN MATCHES "\\.sh")
+      if (DISTRO_FLAVOUR STREQUAL Debian)
+	string(REGEX REPLACE "^(.+)\\.sh$" "\\1" OFN "${IFN}")
+      else()
+	set(OFN "${IFN}")
+      endif()
+      _rdma_sbin_interp_link("/bin/bash" "${IFN}" "${OFN}")
+    else()
+      _rdma_sbin_interp_link("/bin/bash" "${IFN}" "${IFN}")
+    endif()
+  endforeach()
+endfunction()
+
+function(rdma_sbin_perl_program)
+  foreach(IFN ${ARGN})
+    if (IFN MATCHES "\\.pl\\.in")
+      if (DISTRO_FLAVOUR STREQUAL Debian)
+	string(REGEX REPLACE "^(.+)\\.pl\\.in$" "\\1" OFN "${IFN}")
+      else()
+	string(REGEX REPLACE "^(.+)\\.in$" "\\1" OFN "${IFN}")
+      endif()
+      _rdma_sbin_interp("/usr/bin/perl" "${IFN}" "${OFN}")
+    elseif (IFN MATCHES "\\.pl")
+      if (DISTRO_FLAVOUR STREQUAL Debian)
+	string(REGEX REPLACE "^(.+)\\.pl$" "\\1" OFN "${IFN}")
+      else()
+	set(OFN "${IFN}")
+      endif()
+      _rdma_sbin_interp_link("/usr/bin/perl" "${IFN}" "${OFN}")
+    endif()
+  endforeach()
+endfunction()
+
+set(IBSCRIPTPATH "${CMAKE_INSTALL_FULL_SBINDIR}")
+
+rdma_sbin_shell_program(
+  dump_lfts.sh.in
+  dump_mfts.sh.in
+  ibhosts.in
+  ibnodes.in
+  ibrouters.in
+  ibstatus
+  ibswitches.in
+  )
+
+rdma_sbin_perl_program(
+  check_lft_balance.pl
+  ibfindnodesusing.pl
+  ibidsverify.pl
+  )
+
+install(FILES "IBswcountlimits.pm"
+  DESTINATION "${CMAKE_INSTALL_PERLDIR}")
+
+install(FILES
+  "../etc/error_thresholds"
+  "../etc/ibdiag.conf"
+  DESTINATION "${IBDIAG_CONFIG_PATH}")
+
+if (WITH_IBDIAGS_COMPAT)
+  rdma_sbin_shell_program(
+    ibcheckerrors.in
+    ibcheckerrs.in
+    ibchecknet.in
+    ibchecknode.in
+    ibcheckport.in
+    ibcheckportstate.in
+    ibcheckportwidth.in
+    ibcheckstate.in
+    ibcheckwidth.in
+    ibclearcounters.in
+    ibclearerrors.in
+    ibdatacounters.in
+    ibdatacounts.in
+    set_nodedesc.sh
+    )
+
+  rdma_sbin_perl_program(
+    ibdiscover.pl
+    iblinkinfo.pl.in
+    ibprintca.pl
+    ibprintrt.pl
+    ibprintswitch.pl
+    ibqueryerrors.pl.in
+    ibswportwatch.pl
+    )
+endif()
diff --git a/ibdiags/src/CMakeLists.txt b/ibdiags/src/CMakeLists.txt
new file mode 100644
index 00000000000000..edce64f2106a3d
--- /dev/null
+++ b/ibdiags/src/CMakeLists.txt
@@ -0,0 +1,48 @@
+publish_internal_headers(""
+  ../include/ibdiag_common.h
+  ../include/ibdiag_sa.h
+  )
+
+add_library(ibdiags_tools STATIC
+  ibdiag_common.c
+  ibdiag_sa.c
+  )
+target_include_directories(ibdiags_tools PRIVATE "/usr/include/infiniband")
+
+function(ibdiag_programs)
+  foreach(I ${ARGN})
+    rdma_sbin_executable(${I} "${I}.c")
+    target_link_libraries(${I} PRIVATE ${RT_LIBRARIES} ibumad ibmad ibdiags_tools ibnetdisc osmcomp)
+    target_include_directories(${I} PRIVATE "/usr/include/infiniband")
+  endforeach()
+endfunction()
+
+ibdiag_programs(
+  dump_fts
+  ibaddr
+  ibcacheedit
+  ibccconfig
+  ibccquery
+  iblinkinfo
+  ibnetdiscover
+  ibping
+  ibportstate
+  ibqueryerrors
+  ibroute
+  ibstat
+  ibsysstat
+  ibtracert
+  perfquery
+  saquery
+  sminfo
+  smpdump
+  smpquery
+  vendstat
+  )
+
+rdma_test_executable(ibsendtrap "ibsendtrap.c")
+target_link_libraries(ibsendtrap PRIVATE ibumad ibmad ibdiags_tools)
+target_include_directories(ibsendtrap PRIVATE "/usr/include/infiniband")
+rdma_test_executable(mcm_rereg_test "mcm_rereg_test.c")
+target_link_libraries(mcm_rereg_test PRIVATE ibumad ibmad ibdiags_tools)
+target_include_directories(mcm_rereg_test PRIVATE "/usr/include/infiniband")
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index ea48fc4e29a36f..29bf26531c97ab 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -259,6 +259,7 @@ easy, object-oriented access to IB verbs.
          -DCMAKE_INSTALL_RUNDIR:PATH=%{_rundir} \
          -DCMAKE_INSTALL_DOCDIR:PATH=%{_docdir}/%{name}-%{version} \
          -DCMAKE_INSTALL_UDEV_RULESDIR:PATH=%{_udevrulesdir} \
+         -DWITH_IBDIAGS:BOOL=False \
 %if %{with_static}
          -DENABLE_STATIC=1 \
 %endif
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index 5ddb46aaf8f9cc..c0d4922658cb6a 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -372,6 +372,7 @@ easy, object-oriented access to IB verbs.
          -DCMAKE_INSTALL_RUNDIR:PATH=%{_rundir} \
          -DCMAKE_INSTALL_DOCDIR:PATH=%{_docdir}/%{name}-%{version} \
          -DCMAKE_INSTALL_UDEV_RULESDIR:PATH=%{_udevrulesdir} \
+         -DWITH_IBDIAGS:BOOL=False \
 %if %{with_static}
          -DENABLE_STATIC=1 \
 %endif
-- 
2.21.0


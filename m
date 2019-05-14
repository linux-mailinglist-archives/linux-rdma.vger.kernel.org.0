Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E591E5C2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfENXtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43436 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfENXtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so1186854qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL2wNBlXg9debLwIHryy/HadoDYIIpSBighsnapG9WM=;
        b=ONInj+Ce8zHbbWztyCvxbZTeN+En48v/EGz2jvTEnrv6htbnlFcJygx9iLRkjsQbZe
         TzvrIZb+JwFZoQpaBLZLYOU4wwzKrrgz6d54KIt5kHIwhBQCPQ0ixbWtqwsmsoUqw4pj
         9meJfF5X2iF6TKb68qwP/VvsXhrElKieE+Y3tWggYn1a0/jmYFG8cy+RfZcnkepmIP3J
         y0D9v/AW6NKyjAJJBUnb8c3G8wo/pSEzo9xvI3yjCPIQxyERA2x7+ziL6fe/5X/4rMpl
         XSwsKD6qpnhbjHP/unyNeXEtf5MQpOYYfwM20gVd3lKgag+wLdSoKLvvT4R5RdSmh4Uz
         w+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UL2wNBlXg9debLwIHryy/HadoDYIIpSBighsnapG9WM=;
        b=OLEtFwGsGLJ1So+caFDZ9KS+bBtHxbGwus9I8QwxY8FlJDuCVYK+ll3qANM3eTv2PJ
         eFvmJA7jwi6ChY8UYC7Q5Rj0HhzGTObKL8j7KeIYDsAa72kN/EH83pCl8m5fw8XWWlSL
         SidCUbc7/omGhX/WQwjJ+E6HkXs770tpPFJ+YIJfE/Q03m4XVm5bJmi+ggXZx8kWI5v8
         ZInh/bGjLvzlhN6AXbH6OkEusPKl46FnBdiXqDyOh8sfSwo/d+33AHoFNPpYu+J3LIdb
         8MkgQGTwHu1BtE2HiXmPeu44siiOv7YEf09XOYT3vxPKfr8VXdCwyicx+zJvslOmpWaj
         dRXw==
X-Gm-Message-State: APjAAAXkI3mCnUUpLkrof2jWdQzqC+FKJvGakLfzTzrcwq57koZULdIc
        ykhNV6Ik9OjtWz2gDlADBDf36HRxrwc=
X-Google-Smtp-Source: APXvYqyCEC9PbFL8Aal8t+KKp5ZUpy9ElB6w7Nx90gLh4S0Y8PKHs0ge5Tm7eS7EGcRUXuM2JXSZoQ==
X-Received: by 2002:aed:2a25:: with SMTP id c34mr33303643qtd.62.1557877780508;
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id u5sm128664qkk.85.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001ND-TN; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 06/20] build: Support rst as a man page option
Date:   Tue, 14 May 2019 20:49:22 -0300
Message-Id: <20190514234936.5175-7-jgg@ziepe.ca>
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

infiniband-diags uses rst as a man page preprocessor, so add it along side
pandoc in the build system.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .travis.yml                 |  1 +
 CMakeLists.txt              | 10 ++++++-
 buildlib/Findrst2man.cmake  | 21 +++++++++++++
 buildlib/cbuild             | 12 +++++++-
 buildlib/pandoc-prebuilt.py | 33 +++++++++++++++++---
 buildlib/rdma_man.cmake     | 60 ++++++++++++++++++++++++++++++-------
 debian/control              |  1 +
 redhat/rdma-core.spec       |  1 +
 suse/rdma-core.spec         |  1 +
 9 files changed, 123 insertions(+), 17 deletions(-)
 create mode 100644 buildlib/Findrst2man.cmake

diff --git a/.travis.yml b/.travis.yml
index 660b306797bf6b..1cc2c69ca8671d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -19,6 +19,7 @@ addons:
       - make
       - ninja-build
       - pandoc
+      - python-docutils
       - pkg-config
       - python
       - valgrind
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5cb3c32c318821..9428ce02191bc4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -406,8 +406,9 @@ if (CYTHON_EXECUTABLE)
   string(STRIP ${py_path} CMAKE_PYTHON_SO_SUFFIX)
 endif()
 
-# Look for pandoc
+# Look for pandoc and rst2man for making manual pages
 FIND_PACKAGE(pandoc)
+FIND_PACKAGE(rst2man)
 
 #-------------------------
 # Find libraries
@@ -668,6 +669,13 @@ if (NOT PANDOC_FOUND)
     message(STATUS " pandoc NOT found (using prebuilt man pages)")
   endif()
 endif()
+if (NOT RST2MAN_FOUND)
+  if (NOT EXISTS "${CMAKE_SOURCE_DIR}/buildlib/pandoc-prebuilt")
+    message(STATUS " rst2man NOT found and NO prebuilt man pages. 'install' disabled")
+  else()
+    message(STATUS " rst2man NOT found (using prebuilt man pages)")
+  endif()
+endif()
 if (NOT CYTHON_EXECUTABLE)
   message(STATUS " cython NOT found (disabling pyverbs)")
 endif()
diff --git a/buildlib/Findrst2man.cmake b/buildlib/Findrst2man.cmake
new file mode 100644
index 00000000000000..a7236604dfcc28
--- /dev/null
+++ b/buildlib/Findrst2man.cmake
@@ -0,0 +1,21 @@
+# COPYRIGHT (c) 2019 Mellanox Technologies Ltd
+# Licensed under BSD (MIT variant) or GPLv2. See COPYING.
+find_program(RST2MAN_EXECUTABLE NAMES rst2man)
+
+if(RST2MAN_EXECUTABLE)
+  execute_process(COMMAND "${RST2MAN_EXECUTABLE}" --version
+    OUTPUT_VARIABLE _VERSION
+    RESULT_VARIABLE _VERSION_RESULT
+    ERROR_QUIET)
+
+  if(NOT _VERSION_RESULT)
+    string(REGEX REPLACE "^rst2man \\(Docutils ([^,]+), .*" "\\1" RST2MAN_VERSION_STRING "${_VERSION}")
+  endif()
+  unset(_VERSION_RESULT)
+  unset(_VERSION)
+endif()
+
+include(FindPackageHandleStandardArgs)
+find_package_handle_standard_args(rst2man REQUIRED_VARS RST2MAN_EXECUTABLE RST2MAN_VERSION_STRING VERSION_VAR RST2MAN_VERSION_STRING)
+
+mark_as_advanced(RST2MAN_EXECUTABLE)
diff --git a/buildlib/cbuild b/buildlib/cbuild
index e012b08b5fbb76..2d0fc46a1ee913 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -104,6 +104,7 @@ class centos6(YumEnvironment):
         'pkgconfig',
         'python',
         'python-argparse',
+        'python-docutils',
         'rpm-build',
         'valgrind-devel',
     };
@@ -149,7 +150,14 @@ class centos7_epel(centos7):
 
 class fc30(Environment):
     docker_parent = "fedora:30";
-    pkgs = (centos7.pkgs - {"make", "python-argparse" }) | {"ninja-build","pandoc","perl-generators","python3-Cython","python3-devel"};
+    pkgs = (centos7.pkgs - {"make", "python-argparse" }) | {
+        "ninja-build",
+        "pandoc",
+        "perl-generators",
+        "python3-docutils",
+        "python3-Cython",
+        "python3-devel",
+    };
     name = "fc30";
     specfile = "redhat/rdma-core.spec";
     ninja_cmd = "ninja-build";
@@ -190,6 +198,7 @@ class xenial(APTEnvironment):
         'pandoc',
         'pkg-config',
         'python3',
+        "python3-docutils",
         'valgrind',
     };
     name = "ubuntu-16.04";
@@ -354,6 +363,7 @@ class leap(ZypperEnvironment):
         'valgrind-devel',
         'python3-Cython',
         'python3-devel',
+        'python3-docutils',
     };
     rpmbuild_options = [ "--without=curlmini" ];
     name = "opensuse-15.0";
diff --git a/buildlib/pandoc-prebuilt.py b/buildlib/pandoc-prebuilt.py
index c1db6a25a23bad..afba326324345b 100644
--- a/buildlib/pandoc-prebuilt.py
+++ b/buildlib/pandoc-prebuilt.py
@@ -4,19 +4,31 @@ import shutil
 import subprocess
 import sys
 import hashlib
+import re
+
+def hash_rst_includes(incdir,txt):
+    h = ""
+    for fn in re.findall(br"^..\s+include::\s+(.*)$", txt, flags=re.MULTILINE):
+        with open(os.path.join(incdir,fn.decode()),"rb") as F:
+            h = h +  hashlib.sha1(F.read()).hexdigest();
+    return h.encode();
 
 def get_id(SRC):
     """Return a unique ID for the SRC file. For simplicity and robustness we just
     content hash it"""
+    incdir = os.path.dirname(SRC)
     with open(SRC,"rb") as F:
-        return hashlib.sha1(F.read()).hexdigest();
+        txt = F.read();
+        if SRC.endswith(".rst"):
+            txt = txt + hash_rst_includes(incdir,txt);
+        return hashlib.sha1(txt).hexdigest();
 
 def do_retrieve(src_root,SRC):
     """Retrieve the file from the prebuild cache and write it to DEST"""
     prebuilt = os.path.join(src_root,"buildlib","pandoc-prebuilt",get_id(SRC))
     sys.stdout.write(prebuilt);
 
-def do_build(build_root,pandoc,SRC,DEST):
+def do_build_pandoc(build_root,pandoc,SRC,DEST):
     """Build the markdown into a man page with pandoc and then keep a copy of the
     output under build/pandoc-prebuilt"""
     try:
@@ -25,13 +37,26 @@ def do_build(build_root,pandoc,SRC,DEST):
         sys.exit(100);
     shutil.copy(DEST,os.path.join(build_root,"pandoc-prebuilt",get_id(SRC)));
 
+def do_build_rst2man(build_root,rst2man,SRC,DEST):
+    """Build the markdown into a man page with pandoc and then keep a copy of the
+    output under build/pandoc-prebuilt"""
+    try:
+        subprocess.check_call([rst2man,SRC,DEST]);
+    except subprocess.CalledProcessError:
+        sys.exit(100);
+    shutil.copy(DEST,os.path.join(build_root,"pandoc-prebuilt",get_id(SRC)));
+
 # We support python 2.6 so argparse is not available.
 if len(sys.argv) == 4:
     assert(sys.argv[1] == "--retrieve");
     do_retrieve(sys.argv[2],sys.argv[3]);
 elif len(sys.argv) == 7:
     assert(sys.argv[1] == "--build");
-    assert(sys.argv[3] == "--pandoc");
-    do_build(sys.argv[2],sys.argv[4],sys.argv[5],sys.argv[6]);
+    if sys.argv[3] == "--pandoc":
+        do_build_pandoc(sys.argv[2],sys.argv[4],sys.argv[5],sys.argv[6]);
+    elif sys.argv[3] == "--rst":
+        do_build_rst2man(sys.argv[2],sys.argv[4],sys.argv[5],sys.argv[6]);
+    else:
+        raise ValueError("Bad sys.argv[3]");
 else:
     raise ValueError("Must provide --build or --retrieve");
diff --git a/buildlib/rdma_man.cmake b/buildlib/rdma_man.cmake
index 0db455f0cc6029..f8f43c9fe55a6e 100644
--- a/buildlib/rdma_man.cmake
+++ b/buildlib/rdma_man.cmake
@@ -4,6 +4,22 @@
 rdma_make_dir("${CMAKE_BINARY_DIR}/pandoc-prebuilt")
 add_custom_target("docs" ALL DEPENDS "${OBJ}")
 
+function(rdma_man_get_prebuilt SRC OUT)
+  # If rst2man is not installed then we install the man page from the
+  # pre-built cache directory under buildlib. When the release tar file is
+  # made the man pages are pre-built and included. This is done via install
+  # so that ./build.sh never depends on pandoc, only 'ninja install'.
+  execute_process(
+    COMMAND "${PYTHON_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/buildlib/pandoc-prebuilt.py" --retrieve "${CMAKE_SOURCE_DIR}" "${SRC}"
+    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+    OUTPUT_VARIABLE OBJ
+    RESULT_VARIABLE retcode)
+  if(NOT "${retcode}" STREQUAL "0")
+    message(FATAL_ERROR "Failed to load prebuilt pandoc output")
+  endif()
+  set(${OUT} "${OBJ}" PARENT_SCOPE)
+endfunction()
+
 function(rdma_md_man_page SRC MAN_SECT MANFN)
   set(OBJ "${CMAKE_CURRENT_BINARY_DIR}/${MANFN}")
 
@@ -18,18 +34,29 @@ function(rdma_md_man_page SRC MAN_SECT MANFN)
     add_custom_target("man-${MANFN}" ALL DEPENDS "${OBJ}")
     add_dependencies("docs" "man-${MANFN}")
   else()
-    # If pandoc is not installed then we install the man page from the
-    # pre-built cache directory under buildlib. When the release tar file is
-    # made the man pages are pre-built and included. This is done via install
-    # so that ./build.sh never depends on pandoc, only 'ninja install'.
-    execute_process(
-      COMMAND "${PYTHON_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/buildlib/pandoc-prebuilt.py" --retrieve "${CMAKE_SOURCE_DIR}" "${SRC}"
+    rdma_man_get_prebuilt(${SRC} OBJ)
+  endif()
+
+  install(FILES "${OBJ}"
+    RENAME "${MANFN}"
+    DESTINATION "${CMAKE_INSTALL_MANDIR}/man${MAN_SECT}/")
+endfunction()
+
+function(rdma_rst_man_page SRC MAN_SECT MANFN)
+  set(OBJ "${CMAKE_CURRENT_BINARY_DIR}/${MANFN}")
+
+  if (RST2MAN_EXECUTABLE)
+    add_custom_command(
+      OUTPUT "${OBJ}"
+      COMMAND "${PYTHON_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/buildlib/pandoc-prebuilt.py" --build "${CMAKE_BINARY_DIR}" --rst "${RST2MAN_EXECUTABLE}" "${SRC}" "${OBJ}"
+      MAIN_DEPENDENCY "${SRC}"
       WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
-      OUTPUT_VARIABLE OBJ
-      RESULT_VARIABLE retcode)
-    if(NOT "${retcode}" STREQUAL "0")
-      message(FATAL_ERROR "Failed to load prebuilt pandoc output")
-    endif()
+      COMMENT "Creating man page ${MANFN}"
+      VERBATIM)
+    add_custom_target("man-${MANFN}" ALL DEPENDS "${OBJ}")
+    add_dependencies("docs" "man-${MANFN}")
+  else()
+    rdma_man_get_prebuilt(${SRC} OBJ)
   endif()
 
   install(FILES "${OBJ}"
@@ -50,6 +77,17 @@ function(rdma_man_pages)
 	"${I}"
 	"${MAN_SECT}"
 	"${BASE_NAME}")
+    elseif ("${I}" MATCHES "\\.in\\.rst$")
+      string(REGEX REPLACE "^.+[.](.+)\\.in\\.rst$" "\\1" MAN_SECT "${I}")
+      string(REGEX REPLACE "^(.+)\\.in\\.rst$" "\\1" BASE_NAME "${I}")
+      get_filename_component(BASE_NAME "${BASE_NAME}" NAME)
+
+      configure_file("${I}" "${CMAKE_CURRENT_BINARY_DIR}/${BASE_NAME}.rst" @ONLY)
+
+      rdma_rst_man_page(
+	"${CMAKE_CURRENT_BINARY_DIR}/${BASE_NAME}.rst"
+	"${MAN_SECT}"
+	"${BASE_NAME}")
     elseif ("${I}" MATCHES "\\.in$")
       string(REGEX REPLACE "^.+[.](.+)\\.in$" "\\1" MAN_SECT "${I}")
       string(REGEX REPLACE "^(.+)\\.in$" "\\1" BASE_NAME "${I}")
diff --git a/debian/control b/debian/control
index 9fb546ac8999cd..f4480827bf86af 100644
--- a/debian/control
+++ b/debian/control
@@ -16,6 +16,7 @@ Build-Depends: cmake (>= 2.8.11),
                ninja-build,
                pandoc,
                pkg-config,
+               python-docutils,
                python3-dev,
                valgrind [amd64 arm64 armhf i386 mips mips64el mipsel powerpc ppc64 ppc64el s390x]
 Standards-Version: 4.3.0
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index ba563a7b87fa4e..ea48fc4e29a36f 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -20,6 +20,7 @@ BuildRequires: libudev-devel
 BuildRequires: pkgconfig
 BuildRequires: pkgconfig(libnl-3.0)
 BuildRequires: pkgconfig(libnl-route-3.0)
+BuildRequires: python-docutils
 BuildRequires: valgrind-devel
 BuildRequires: systemd
 BuildRequires: systemd-devel
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index d533059603b918..5ddb46aaf8f9cc 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -62,6 +62,7 @@ BuildRequires:  pkgconfig(libsystemd)
 BuildRequires:  pkgconfig(libudev)
 BuildRequires:  pkgconfig(systemd)
 BuildRequires:  pkgconfig(udev)
+BuildRequires:  python-docutils
 %if %{with_pyverbs}
 BuildRequires:  python3-Cython
 BuildRequires:  python3-devel
-- 
2.21.0


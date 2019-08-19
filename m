Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E191D78
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53158 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:30 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNF004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the build
Date:   Mon, 19 Aug 2019 09:58:16 +0300
Message-Id: <20190819065827.26921-4-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Have the tests installed separately from pyverbs as they're not a
part of the package. They will now be placed under
/usr/share/doc/rdma-core-{version}/tests.
The tests can be executed as follows:
python3 /usr/share/doc/rdma-core-{version}/run_tests.py

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 CMakeLists.txt                       | 11 +++++++++++
 buildlib/pyverbs_functions.cmake     |  7 +++++++
 debian/python3-pyverbs.install       |  2 ++
 pyverbs/CMakeLists.txt               | 17 -----------------
 redhat/rdma-core.spec                |  2 ++
 pyverbs/run_tests.py => run_tests.py |  0
 suse/rdma-core.spec                  |  2 ++
 7 files changed, 24 insertions(+), 17 deletions(-)
 rename pyverbs/run_tests.py => run_tests.py (100%)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fc17ef36cf24..d076ab2c9d3a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -648,6 +648,7 @@ add_subdirectory(infiniband-diags/man)
 
 if (CYTHON_EXECUTABLE)
   add_subdirectory(pyverbs)
+  add_subdirectory(tests)
 endif()
 
 # Binaries
@@ -666,6 +667,16 @@ if (UDEV_FOUND)
 endif()
 add_subdirectory(srp_daemon)
 
+if (CYTHON_EXECUTABLE)
+rdma_python_test(""
+  run_tests.py
+  )
+
+rdma_internal_binary(
+  run_tests.py
+  )
+endif()
+
 ibverbs_finalize()
 rdma_finalize_libs()
 
diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.cmake
index 9d5258617035..8ea5dc0df7de 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -35,6 +35,13 @@ function(rdma_python_module PY_MODULE)
   endforeach()
 endfunction()
 
+function(rdma_python_test PY_MODULE)
+  foreach(PY_FILE ${ARGN})
+    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/${PY_FILE}
+      DESTINATION ${CMAKE_INSTALL_DOCDIR}/${PY_MODULE})
+  endforeach()
+endfunction()
+
 # Make a python script runnable from the build/bin directory with all the
 # correct paths filled in
 function(rdma_internal_binary)
diff --git a/debian/python3-pyverbs.install b/debian/python3-pyverbs.install
index 20130d8a9a03..10efb97232fd 100644
--- a/debian/python3-pyverbs.install
+++ b/debian/python3-pyverbs.install
@@ -1 +1,3 @@
 usr/lib/python3/dist-packages/pyverbs
+usr/share/doc/rdma-core/run_tests.py
+usr/share/doc/rdma-core/tests
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 328263fcc739..da49093c2cf0 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -16,22 +16,5 @@ rdma_cython_module(pyverbs
 rdma_python_module(pyverbs
   __init__.py
   pyverbs_error.py
-  run_tests.py
   utils.py
   )
-
-rdma_python_module(pyverbs/tests
-  tests/__init__.py
-  tests/addr.py
-  tests/base.py
-  tests/cq.py
-  tests/device.py
-  tests/mr.py
-  tests/pd.py
-  tests/qp.py
-  tests/utils.py
-  )
-
-rdma_internal_binary(
-  run_tests.py
-  )
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index f07919ccecd5..239c56b581e8 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -650,4 +650,6 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %if %{with_pyverbs}
 %files -n python3-pyverbs
 %{python3_sitearch}/pyverbs
+%{_docdir}/%{name}-%{version}/tests/*.py
+%{_docdir}/%{name}-%{version}/run_tests.py
 %endif
diff --git a/pyverbs/run_tests.py b/run_tests.py
similarity index 100%
rename from pyverbs/run_tests.py
rename to run_tests.py
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index 5a01327c4852..cdb6793e4f75 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -852,6 +852,8 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %if %{with_pyverbs}
 %files -n python3-pyverbs
 %{python3_sitearch}/pyverbs
+%{_docdir}/%{name}-%{version}/tests/*.py
+%{_docdir}/%{name}-%{version}/run_tests.py
 %endif
 
 %changelog
-- 
2.21.0


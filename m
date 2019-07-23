Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAD371FC5
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbfGWTBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33115 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGWTBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so31948284qkc.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwBVlFVHmUAlk0RjbeDedOf4oiOvdg+h11F4wryhtzQ=;
        b=Hz3zJjpw5A8MWnCQqxzJrHCQt7ezRIIVtx+J6mVnB4BN6WH42EZOf+P3QsO2Nzp+Fo
         0lA2shCxlEsE3CqCed2XVXh+4idA3G0o0Rit2fW2Ta39qVPXYvWH13cNgzCtfRXazW9f
         30AepX/HuIxnIGqCThZ2tw6+dxtio3Y+sfPLSBygEH2EbkR9b6hK54E0kGzMyCkuXL+K
         R4RaxBPz+sv0+dv7l7AiNFj9K2nRciTh9/wKiRZVTeAOn1/wslfqtEJnyrjkXRITlBPR
         KwA6W9sLCecXFIy1lUidK6hzFzPgq0GaZt/x6sE3WFi//5OlAJXc6PC2Y8zs1jQrpVMP
         6YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwBVlFVHmUAlk0RjbeDedOf4oiOvdg+h11F4wryhtzQ=;
        b=b5tygkxNDv3eHpoS1wsJ5kYa+B2W1Pqr/7qEksr4Pe9T4Fj17YiuZuSsJfUjrrrmUJ
         3bIXNgEadQugqHqxdPhS/ASk468ckUALGUasdywVTo46/0XEFLaPiUmeQYM/SYAkBGAX
         9rJOLhp2i1sbLtqlpILL/tVvry24qxvPnpSEeLJ0MT+nwYTVQVOVKmeGvHm1U0ZzdDJN
         Y5rXKthMlexhnPaz1pH2de+dQCwwWJVPg2nobyuvrWHdLy+NsNfo9AVEWg8zce/GCZBV
         kwaxH09HcIx0r+xx+IGLbx/glwcnHA2baoZvufUskhtlk+zouK09mFqUyKHTb+NDHgrm
         4vGQ==
X-Gm-Message-State: APjAAAU+WVWqb0o1TXQN0jOwJvkZAyeneaA+k9ZnusTLQvwINGVGnYyY
        bAfgZKCi8vGpF844lQF36+04fOwe4D+TLg==
X-Google-Smtp-Source: APXvYqyQUGQI6+/VcXFsZTy9X4Fpp28dA3PqSpDSuPxiitS43dto656hlDBron1vVTVLW+NzCgExRg==
X-Received: by 2002:ae9:eb87:: with SMTP id b129mr49031437qkg.453.1563908503207;
        Tue, 23 Jul 2019 12:01:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f14sm17998384qto.11.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00045J-TO; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 16/19] build/azp: Add centos6 to the test distributions
Date:   Tue, 23 Jul 2019 16:01:34 -0300
Message-Id: <20190723190137.15370-17-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

We keep having small defects related to these old glibc's, run a build
here too. The spec file is based on the old pre-packaging rdma-core spec
file.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml |  11 +++-
 buildlib/cbuild              |  15 +++--
 buildlib/centos6.spec        | 109 +++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 8 deletions(-)
 create mode 100644 buildlib/centos6.spec

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index e062908e23756b..6a69e940a5b19e 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -10,6 +10,9 @@ resources:
     - container: azp
       image: ucfconsort.azurecr.io/rdma-core/azure_pipelines:25.0
       endpoint: ucfconsort_registry
+    - container: centos6
+      image: ucfconsort.azurecr.io/rdma-core/centos6:25.0
+      endpoint: ucfconsort_registry
     - container: centos7
       image: ucfconsort.azurecr.io/rdma-core/centos7:25.0
       endpoint: ucfconsort_registry
@@ -150,6 +153,10 @@ stages:
           vmImage: 'Ubuntu-16.04'
         strategy:
           matrix:
+            centos6:
+              CONTAINER: centos6
+              SPEC: buildlib/centos6.spec
+              RPMBUILD_OPTS:
             centos7:
               CONTAINER: centos7
               SPEC: redhat/rdma-core.spec
@@ -175,7 +182,7 @@ stages:
               set -e
               mkdir SOURCES tmp
               tar --wildcards -xzf rdma-core*.tar.gz  */$(SPEC) --strip-components=2
-              RPM_SRC=$(rpmspec -P rdma-core.spec | awk '/^Source:/{split($0,a,"[ \t]+");print(a[2])}')
+              RPM_SRC=$((rpmspec -P *.spec || grep ^Source: *.spec) | awk '/^Source:/{split($0,a,"[ \t]+");print(a[2])}')
               (cd SOURCES && ln -sf ../rdma-core*.tar.gz "$RPM_SRC")
-              rpmbuild --define '_tmppath '$(pwd)'/tmp' --define '_topdir '$(pwd) -bb rdma-core.spec $(RPMBUILD_OPTS)
+              rpmbuild --define '_tmppath '$(pwd)'/tmp' --define '_topdir '$(pwd) -bb *.spec $(RPMBUILD_OPTS)
             displayName: Perform Package Build
diff --git a/buildlib/cbuild b/buildlib/cbuild
index cc9c7e2999a9d2..e7065e3e7d8d2d 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -131,9 +131,10 @@ class centos6(YumEnvironment):
     name = "centos6";
     use_make = True;
     pandoc = False;
-    is_rpm = False;
     build_pyverbs = False;
+    specfile = "buildlib/centos6.spec";
     python_cmd = "python";
+    to_azp = True;
 
 class centos7(YumEnvironment):
     docker_parent = "centos:7";
@@ -713,11 +714,13 @@ with open("/etc/group","a") as F:
 os.setgid({gid:d});
 os.setuid({uid:d});
 
-# Get RPM to tell us the expected tar filename.
-for ln in subprocess.check_output(["rpmspec","-P",{tspec_file!r}]).splitlines():
-   if ln.startswith(b"Source:"):
-      tarfn = ln.strip().partition(b' ')[2].strip();
-os.symlink({tarfn!r},os.path.join(b"SOURCES",tarfn));
+# For Centos6
+if "check_output" in dir(subprocess):
+    # Get RPM to tell us the expected tar filename.
+    for ln in subprocess.check_output(["rpmspec","-P",{tspec_file!r}]).splitlines():
+       if ln.startswith(b"Source:"):
+          tarfn = ln.strip().partition(b' ')[2].strip();
+    os.symlink({tarfn!r},os.path.join(b"SOURCES",tarfn));
 """.format(passwd=":".join(str(I) for I in pwd.getpwuid(os.getuid())),
            group=":".join(str(I) for I in grp.getgrgid(os.getgid())),
            uid=os.getuid(),
diff --git a/buildlib/centos6.spec b/buildlib/centos6.spec
new file mode 100644
index 00000000000000..943b5e65c7e1e5
--- /dev/null
+++ b/buildlib/centos6.spec
@@ -0,0 +1,109 @@
+Name: rdma-core
+Version: 25.0
+Release: 1%{?dist}
+Summary: RDMA core userspace libraries and daemons
+
+# Almost everything is licensed under the OFA dual GPLv2, 2 Clause BSD license
+#  providers/ipathverbs/ Dual licensed using a BSD license with an extra patent clause
+#  providers/rxe/ Incorporates code from ipathverbs and contains the patent clause
+#  providers/hfi1verbs Uses the 3 Clause BSD license
+License: (GPLv2 or BSD) and (GPLv2 or PathScale-BSD)
+Url: https://github.com/linux-rdma/rdma-core
+Source: rdma-core.tgz
+
+BuildRequires: binutils
+BuildRequires: cmake >= 2.8.11
+BuildRequires: gcc
+BuildRequires: libudev-devel
+BuildRequires: pkgconfig
+BuildRequires: pkgconfig(libnl-3.0)
+BuildRequires: pkgconfig(libnl-route-3.0)
+BuildRequires: valgrind-devel
+BuildRequires: python
+
+%define CMAKE_FLAGS %{nil}
+BuildRequires: make
+
+%description
+Temporary packaging
+
+This is a simple example without the split sub packages to get things started.
+
+%prep
+%setup
+
+%build
+
+%define my_unitdir /tmp/
+
+# New RPM defines _rundir, usually as /run
+%if 0%{?_rundir:1}
+%else
+%define _rundir /var/run
+%endif
+
+# New RPM defines _udevrulesdir, usually as /usr/lib/udev/rules.d
+%if 0%{?_udevrulesdir:1}
+%else
+# This is the old path (eg for C6)
+%define _udevrulesdir /lib/udev/rules.d
+%endif
+
+# Pass all of the rpm paths directly to GNUInstallDirs and our other defines.
+%cmake %{CMAKE_FLAGS} \
+         -DCMAKE_BUILD_TYPE=Release \
+         -DCMAKE_INSTALL_BINDIR:PATH=%{_bindir} \
+         -DCMAKE_INSTALL_SBINDIR:PATH=%{_sbindir} \
+         -DCMAKE_INSTALL_LIBDIR:PATH=%{_libdir} \
+         -DCMAKE_INSTALL_LIBEXECDIR:PATH=%{_libexecdir} \
+         -DCMAKE_INSTALL_LOCALSTATEDIR:PATH=%{_localstatedir} \
+         -DCMAKE_INSTALL_SHAREDSTATEDIR:PATH=%{_sharedstatedir} \
+         -DCMAKE_INSTALL_INCLUDEDIR:PATH=%{_includedir} \
+         -DCMAKE_INSTALL_INFODIR:PATH=%{_infodir} \
+         -DCMAKE_INSTALL_MANDIR:PATH=%{_mandir} \
+         -DCMAKE_INSTALL_SYSCONFDIR:PATH=%{_sysconfdir} \
+	 -DCMAKE_INSTALL_SYSTEMD_SERVICEDIR:PATH=%{my_unitdir} \
+	 -DCMAKE_INSTALL_INITDDIR:PATH=%{_initrddir} \
+	 -DCMAKE_INSTALL_RUNDIR:PATH=%{_rundir} \
+	 -DCMAKE_INSTALL_DOCDIR:PATH=%{_docdir}/%{name}-%{version} \
+	 -DCMAKE_INSTALL_UDEV_RULESDIR:PATH=%{_udevrulesdir} \
+         -DCMAKE_INSTALL_PERLDIR:PATH=%{perl_vendorlib}
+make -s %{?_smp_mflags}
+
+%install
+DESTDIR=%{buildroot} make install
+
+%if 0%{?_unitdir:1}
+rm -rf %{buildroot}/%{_initrddir}/
+%else
+rm -rf %{buildroot}/%{my_unitdir}/
+%endif
+
+%files
+%doc %{_mandir}/man*/*
+%{_bindir}/*
+%{_includedir}/*
+%{_libdir}/lib*.so*
+%{_libdir}/libibverbs/*
+%{_libdir}/ibacm/*
+%{_libdir}/rsocket/*
+%{_libdir}/pkgconfig/*.pc
+%{_sbindir}/*
+%{_libexecdir}/*
+%{_udevrulesdir}/*
+%{_udevrulesdir}/../rdma_rename
+%doc %{_docdir}/%{name}-%{version}/*
+%if 0%{?_unitdir:1}
+%{_unitdir}/*
+%else
+%config %{_initrddir}/*
+%endif
+%config %{_sysconfdir}/iwpmd.conf
+%config %{_sysconfdir}/srp_daemon.conf
+%config %{_sysconfdir}/libibverbs.d/*
+%config %{_sysconfdir}/rdma/modules/*
+%{perl_vendorlib}/IBswcountlimits.pm
+%config(noreplace) %{_sysconfdir}/udev/rules.d/*
+%config(noreplace) %{_sysconfdir}/infiniband-diags/error_thresholds
+%config(noreplace) %{_sysconfdir}/infiniband-diags/ibdiag.conf
+%{_sysconfdir}/modprobe.d/*
-- 
2.22.0


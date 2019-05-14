Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2983D1E5C6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfENXto (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:44 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39130 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfENXtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:43 -0400
Received: by mail-qk1-f174.google.com with SMTP id z128so398227qkb.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EbjoA80E7TwbBGI5fHJ/wmV814+rYmSj5+48yVgSYA=;
        b=Vxmql7AqsYfTJcpfG3Kl1JbqWXd1a3ZD24Z+Vb6HP48oHCKHUdPGKd7ZS37/NN79AT
         Y1HpzBm8wIN0QZCqQfMjrKUds6ftjtNx2GQXZEvRI74UvugDniwZBBsOeLk593BrS6vN
         5dzk3r0ByMTN203UAwwgm6syGpCiSpLiq1GHbcLrsvZXTEzMZRYV4O2bb69GUO5bWasR
         n5gezFyGABXNKo/6LSxJttenCEzn0qFGED6Hi2MBY5etOOYoIqf6VENXPD4YTGoOprAq
         ioknDuOq80H469ibUsZn4K2W/cnd+oV0wUo3YTS0kyJ6mY6frs6NJndXGsPHK8lINq6c
         FKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EbjoA80E7TwbBGI5fHJ/wmV814+rYmSj5+48yVgSYA=;
        b=i+66GXwBTNnA6dp0esodG47OkrLqv1NMsW/TQxkrJK16P4MGlGbwqcK7c3oQwkt/KD
         bxgaDzXoKGMAybPPv1Y0+UiDrkfOJQKf2lsro0MR04hVpoHMGsBFyxwChn1Yn9ZV3gPB
         5wJhWgyXlfdesTYq2f0Ts40728YQYGKcLB+NUK6VLqXf0bJRkt7RwZMqoJE0/ay1dx1A
         cNCJmjC58AZ4vALHlnvwAdzjOL8ZiMu9R3xicn855yjKBpuUxDdEJHTVntpHH8RmKWib
         e29x1FzBkH6NymNTREkmCp2+30+80zblUIV8AQWmUSoOJrJLpFVe1qSbURS9fo3vrij0
         uUWQ==
X-Gm-Message-State: APjAAAXkKUWp3eQAsP287lLyCs/aVbqtL9S7XTL8rEScTcDUgCzJN8Pn
        4FR4SrYvqNWtvxfcUM3+xelBAoaqANE=
X-Google-Smtp-Source: APXvYqz4qXmgIcqiKOsFQXqPeR4DEZLYKU+G8u0Qda103RHbvPXExmL2q5cF/UDVvYqKlc8vIqajjg==
X-Received: by 2002:a37:9e44:: with SMTP id h65mr17476032qke.196.1557877782430;
        Tue, 14 May 2019 16:49:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s7sm142916qkg.70.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001Nu-8Q; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 13/20] ibdiags: Add suse packaging
Date:   Tue, 14 May 2019 20:49:29 -0300
Message-Id: <20190514234936.5175-14-jgg@ziepe.ca>
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

This is copied from the Factor spec file (rev 10) with
infiniband-diags-devel rolled into rdma-core-devel.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt      |   6 ---
 suse/rdma-core.spec | 116 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e16b955991558a..fd9355787291c0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -45,8 +45,6 @@
 #   -DNO_PYVERBS=1 (default, build pyverbs)
 #      Invoke cython to build pyverbs. Usually you will run with this option
 #      is set, but it will be disabled for travis runs.
-#   -DWITH_IBDIAGS=False (default True)
-#      Do not build infiniband-diags components
 #   -DWITH_IBDIAGS_COMPAT=True (default False)
 #      Include obsolete scripts. These scripts are replaced by C programs with
 #      a different interface now.
@@ -160,8 +158,6 @@ endif()
 set(DISTRO_FLAVOUR "None" CACHE
   STRING "Flavour of distribution to install for. This primarily impacts the init.d scripts installed.")
 
-set(WITH_IBDIAGS "True" CACHE BOOL "Build infiniband-diags stuff too")
-
 #-------------------------
 # Load CMake components
 set(BUILDLIB "${CMAKE_SOURCE_DIR}/buildlib")
@@ -621,7 +617,6 @@ add_subdirectory(providers/ipathverbs)
 add_subdirectory(providers/rxe)
 add_subdirectory(providers/rxe/man)
 
-if (WITH_IBDIAGS)
 add_subdirectory(ibdiags/libibmad/src)
 add_subdirectory(ibdiags/libibnetdisc/src)
 add_subdirectory(ibdiags/libibnetdisc/man)
@@ -629,7 +624,6 @@ add_subdirectory(ibdiags/src)
 add_subdirectory(ibdiags/scripts)
 add_subdirectory(ibdiags/man)
 add_subdirectory(ibdiags/doc/rst)
-endif()
 
 if (CYTHON_EXECUTABLE)
   add_subdirectory(pyverbs)
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index c0d4922658cb6a..a4614646fb2de9 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -34,6 +34,8 @@ Group:          Productivity/Networking/Other
 %define umad_so_major   3
 %define mlx4_so_major   1
 %define mlx5_so_major   1
+%define ibnetdisc_major 5
+%define mad_major       5
 
 %define  verbs_lname  libibverbs%{verbs_so_major}
 %define  rdmacm_lname librdmacm%{rdmacm_so_major}
@@ -160,6 +162,10 @@ BuildRequires:  pkgconfig(libnl-3.0)
 BuildRequires:  pkgconfig(libnl-route-3.0)
 %endif
 
+Requires: infiniband-diags = %{version}-%{release}
+Provides: infiniband-diags-devel = %{version}-%{release}
+Obsoletes: infiniband-diags-devel < %{version}-%{release}
+
 %description devel
 RDMA core development libraries and headers.
 
@@ -232,6 +238,14 @@ Group:          System/Libraries
 %description -n %mlx5_lname
 This package contains the mlx5 runtime library.
 
+%package    -n libibnetdisc%{ibnetdisc_major}
+Summary:        Infiniband Net Discovery runtime library
+Group:          System/Libraries
+
+%description -n libibnetdisc%{ibnetdisc_major}
+This package contains the Infiniband Net Discovery runtime library needed
+mainly by infiniband-diags.
+
 %package -n     libibverbs-utils
 Summary:        Examples for the libibverbs library
 Group:          Productivity/Networking/Other
@@ -259,6 +273,23 @@ user applications need not know about this daemon as long as their app
 uses librdmacm to handle connection bring up/tear down.  The librdmacm
 library knows how to talk directly to the ibacm daemon to retrieve data.
 
+%package -n infiniband-diags
+Summary:        InfiniBand Diagnostic Tools
+Group:          Productivity/Networking/Diagnostic
+
+%description -n infiniband-diags
+diags provides IB diagnostic programs and scripts needed to diagnose an
+IB subnet.
+
+%package -n     libibmad%{mad_major}
+Summary:        Libibmad runtime library
+Group:          System/Libraries
+
+%description -n libibmad%{mad_major}
+Libibmad provides low layer IB functions for use by the IB diagnostic
+and management programs. These include MAD, SA, SMP, and other basic IB
+functions. This package contains the runtime library.
+
 %package -n iwpmd
 Summary:        Userspace iWarp Port Mapper daemon
 Group:          Development/Libraries/C and C++
@@ -372,7 +403,7 @@ easy, object-oriented access to IB verbs.
          -DCMAKE_INSTALL_RUNDIR:PATH=%{_rundir} \
          -DCMAKE_INSTALL_DOCDIR:PATH=%{_docdir}/%{name}-%{version} \
          -DCMAKE_INSTALL_UDEV_RULESDIR:PATH=%{_udevrulesdir} \
-         -DWITH_IBDIAGS:BOOL=False \
+         -DCMAKE_INSTALL_PERLDIR:PATH=%{perl_vendorlib} \
 %if %{with_static}
          -DENABLE_STATIC=1 \
 %endif
@@ -444,6 +475,12 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %post -n %rdmacm_lname -p /sbin/ldconfig
 %postun -n %rdmacm_lname -p /sbin/ldconfig
 
+%post -n libibnetdisc%{ibnetdisc_major} -p /sbin/ldconfig
+%postun -n libibnetdisc%{ibnetdisc_major} -p /sbin/ldconfig
+
+%post -n libibmad%{mad_major} -p /sbin/ldconfig
+%postun -n libibmad%{mad_major} -p /sbin/ldconfig
+
 %post
 # we ship udev rules, so trigger an update.
 /sbin/udevadm trigger --subsystem-match=infiniband --action=change || true
@@ -567,6 +604,7 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %endif
 %{_libdir}/lib*.so
 %{_libdir}/pkgconfig/*.pc
+%{_mandir}/man3/ibnd_*
 %{_mandir}/man3/ibv_*
 %{_mandir}/man3/rdma*
 %{_mandir}/man3/umad*
@@ -592,6 +630,14 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %{_mandir}/man7/rxe*
 %{_mandir}/man8/rxe*
 
+%files -n libibnetdisc%{ibnetdisc_major}
+%defattr(-, root, root)
+%{_libdir}/libibnetdisc.so.*
+
+%files -n libibmad%{mad_major}
+%defattr(-, root, root)
+%{_libdir}/libibmad.so.*
+
 %files -n %verbs_lname
 %defattr(-,root,root)
 %{_libdir}/libibverbs*.so.*
@@ -627,6 +673,74 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %{_sbindir}/rcibacm
 %doc %{_docdir}/%{name}-%{version}/ibacm.md
 
+%files -n infiniband-diags
+%defattr(-, root, root)
+%config %{_sysconfdir}/infiniband-diags/error_thresholds
+%dir %{_sysconfdir}/infiniband-diags
+%config(noreplace) %{_sysconfdir}/infiniband-diags/*
+%{_sbindir}/ibaddr
+%{_mandir}/man8/ibaddr*
+%{_sbindir}/ibnetdiscover
+%{_mandir}/man8/ibnetdiscover*
+%{_sbindir}/ibping
+%{_mandir}/man8/ibping*
+%{_sbindir}/ibportstate
+%{_mandir}/man8/ibportstate*
+%{_sbindir}/ibroute
+%{_mandir}/man8/ibroute.*
+%{_sbindir}/ibstat
+%{_mandir}/man8/ibstat.*
+%{_sbindir}/ibsysstat
+%{_mandir}/man8/ibsysstat*
+%{_sbindir}/ibtracert
+%{_mandir}/man8/ibtracert*
+%{_sbindir}/perfquery
+%{_mandir}/man8/perfquery*
+%{_sbindir}/sminfo
+%{_mandir}/man8/sminfo*
+%{_sbindir}/smpdump
+%{_mandir}/man8/smpdump*
+%{_sbindir}/smpquery
+%{_mandir}/man8/smpquery*
+%{_sbindir}/saquery
+%{_mandir}/man8/saquery*
+%{_sbindir}/vendstat
+%{_mandir}/man8/vendstat*
+%{_sbindir}/iblinkinfo
+%{_mandir}/man8/iblinkinfo*
+%{_sbindir}/ibqueryerrors
+%{_mandir}/man8/ibqueryerrors*
+%{_sbindir}/ibcacheedit
+%{_mandir}/man8/ibcacheedit*
+%{_sbindir}/ibccquery
+%{_mandir}/man8/ibccquery*
+%{_sbindir}/ibccconfig
+%{_mandir}/man8/ibccconfig*
+%{_sbindir}/dump_fts
+%{_mandir}/man8/dump_fts*
+%{_sbindir}/ibhosts
+%{_mandir}/man8/ibhosts*
+%{_sbindir}/ibswitches
+%{_mandir}/man8/ibswitches*
+%{_sbindir}/ibnodes
+%{_mandir}/man8/ibnodes*
+%{_sbindir}/ibrouters
+%{_mandir}/man8/ibrouters*
+%{_sbindir}/ibfindnodesusing.pl
+%{_mandir}/man8/ibfindnodesusing*
+%{_sbindir}/ibidsverify.pl
+%{_mandir}/man8/ibidsverify*
+%{_sbindir}/check_lft_balance.pl
+%{_mandir}/man8/check_lft_balance*
+%{_sbindir}/dump_lfts.sh
+%{_mandir}/man8/dump_lfts*
+%{_sbindir}/dump_mfts.sh
+%{_mandir}/man8/dump_mfts*
+%{_sbindir}/ibstatus
+%{_mandir}/man8/ibstatus*
+%{_mandir}/man8/infiniband-diags*
+%{perl_vendorlib}/IBswcountlimits.pm
+
 %files -n iwpmd
 %defattr(-,root,root)
 %dir %{_sysconfdir}/rdma
-- 
2.21.0


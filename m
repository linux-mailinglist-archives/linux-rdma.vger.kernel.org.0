Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E724A1E5C4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfENXtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42918 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENXtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so387249qkc.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4st1/ft9+Etz/+zCC0IqUInccA6rB4kgtjxpZOOg6w4=;
        b=SQQkpjqc5sT22460lsHOUwmM3qXsc9tybmClro0CR1JuxcbeMhron4RZIut2xg0Ocx
         v8OliJbfo8AMHGrmI2hSMFkMEge+sufnDP14H0IVAjT1vkTwkG5sO1To5IVYAVp9s2Cz
         w1YlKTagL8INRGGVKrahRq4lrGY/nRPsXRc2BUX9K0mRHXBlIiq8yu4YkyQmDpJuGX+u
         lkUWgNtV0kjMXSg1UM4leBOz6QoOsOk/GBaQ9fN9wE1yxBu6Syeu9lXbQ1hX67rG6Cyu
         +KHnhlsSUN1ZXZ7lhLKKSFI8j3sssAgzJCmPaQYzFwIgQAqdng/AM6aFehjDREHO7JVa
         9jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4st1/ft9+Etz/+zCC0IqUInccA6rB4kgtjxpZOOg6w4=;
        b=SlbrLbd7K1qjyfZWw5Jq6FnEjEa9m5n/psqlrYlYV8aMrosbFSQ62yI2IwOWKgxt9+
         Ptb/bhVR/6ysGNvCAyr4kMt49d1Vb6zLkDz5NXeCEGWTth7JtZ3E9hH0G0zzJcgoS5L3
         OQDIkBLhEHmtJwQrdqh1EsrOOlhhWxRAx+u53vO1IWko+sD6OHJNEAk2JjmsPGtAs8hz
         uoqRqf5zPema1ymNngaO3fN3CeLH7w+7YUYjSf/24ouoLKFAY345/NqqxBVclrDmOyeR
         WN//7dbcVkOPPqllyTR1busN5eCj3Wgj8XbHn2CpgSzRYIUAGQa59Js3kh9afEiYpg4l
         SwRA==
X-Gm-Message-State: APjAAAWLKDQBzhkh3ALYfayxJdpq1RbMCB0YBrZoBixj4TKDC/AgnMqb
        l2et5sCRTNlmKnrYlXGkehkJNi6WMBs=
X-Google-Smtp-Source: APXvYqzM3HplL45GhqX+FNxEzMBo1zup1vvF8QTon9r2HGATw4tBodnoxAGnz+RQoQ0x2iE3QsMMfA==
X-Received: by 2002:ae9:f70d:: with SMTP id s13mr30891683qkg.213.1557877781632;
        Tue, 14 May 2019 16:49:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n190sm118622qkb.83.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001Nn-6F; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 12/20] ibdiags: Add Fedora packaging
Date:   Tue, 14 May 2019 20:49:28 -0300
Message-Id: <20190514234936.5175-13-jgg@ziepe.ca>
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

This is copied from the FC30 spec file with infiniband-diags-devel rolled
into rdma-core-devel.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 redhat/rdma-core.spec | 143 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 29bf26531c97ab..72a05e58eda279 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -82,6 +82,11 @@ Obsoletes: librdmacm-devel < %{version}-%{release}
 Requires: ibacm = %{version}-%{release}
 Provides: ibacm-devel = %{version}-%{release}
 Obsoletes: ibacm-devel < %{version}-%{release}
+Requires: infiniband-diags = %{version}-%{release}
+Provides: infiniband-diags-devel = %{version}-%{release}
+Obsoletes: infiniband-diags-devel < %{version}-%{release}
+Provides: libibmad-devel = %{version}-%{release}
+Obsoletes: libibmad-devel < %{version}-%{release}
 %if %{with_static}
 # Since our pkg-config files include private references to these packages they
 # need to have their .pc files installed too, even for dynamic linking, or
@@ -93,6 +98,27 @@ BuildRequires: pkgconfig(libnl-route-3.0)
 %description devel
 RDMA core development libraries and headers.
 
+%package -n infiniband-diags
+Summary: InfiniBand Diagnostic Tools
+Provides: perl(IBswcountlimits)
+Provides: libibmad = %{version}-%{release}
+Obsoletes: libibmad < %{version}-%{release}
+Obsoletes: openib-diags < 1.3
+
+%description -n infiniband-diags
+This package provides IB diagnostic programs and scripts needed to diagnose an
+IB subnet.  infiniband-diags now also provides libibmad.  libibmad provides
+low layer IB functions for use by the IB diagnostic and management
+programs. These include MAD, SA, SMP, and other basic IB functions.
+
+%package -n infiniband-diags-compat
+Summary: OpenFabrics Alliance InfiniBand Diagnostic Tools
+
+%description -n infiniband-diags-compat
+Deprecated scripts and utilities which provide duplicated functionality, most
+often at a reduced performance. These are maintained for the time being for
+compatibility reasons.
+
 %package -n libibverbs
 Summary: A library and drivers for direct userspace use of RDMA (InfiniBand/iWARP/RoCE) hardware
 Requires(post): /sbin/ldconfig
@@ -259,7 +285,8 @@ easy, object-oriented access to IB verbs.
          -DCMAKE_INSTALL_RUNDIR:PATH=%{_rundir} \
          -DCMAKE_INSTALL_DOCDIR:PATH=%{_docdir}/%{name}-%{version} \
          -DCMAKE_INSTALL_UDEV_RULESDIR:PATH=%{_udevrulesdir} \
-         -DWITH_IBDIAGS:BOOL=False \
+         -DCMAKE_INSTALL_PERLDIR:PATH=%{perl_vendorlib} \
+         -DWITH_IBDIAGS_COMPAT:BOOL=True \
 %if %{with_static}
          -DENABLE_STATIC=1 \
 %endif
@@ -307,6 +334,10 @@ install -D -m0644 ibacm_opts.cfg %{buildroot}%{_sysconfdir}/rdma/
 rm -rf %{buildroot}/%{_initrddir}/
 rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 
+# infiniband-diags
+%post -n infiniband-diags -p /sbin/ldconfig
+%postun -n infiniband-diags -p /sbin/ldconfig
+
 # libibverbs
 %post -n libibverbs -p /sbin/ldconfig
 %postun -n libibverbs -p /sbin/ldconfig
@@ -407,6 +438,116 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %{_mandir}/man3/mlx4dv*
 %{_mandir}/man7/mlx5dv*
 %{_mandir}/man7/mlx4dv*
+%{_mandir}/man3/ibnd_*
+
+%files -n infiniband-diags-compat
+%{_sbindir}/ibcheckerrs
+%{_mandir}/man8/ibcheckerrs*
+%{_sbindir}/ibchecknet
+%{_mandir}/man8/ibchecknet*
+%{_sbindir}/ibchecknode
+%{_mandir}/man8/ibchecknode*
+%{_sbindir}/ibcheckport
+%{_mandir}/man8/ibcheckport.*
+%{_sbindir}/ibcheckportwidth
+%{_mandir}/man8/ibcheckportwidth*
+%{_sbindir}/ibcheckportstate
+%{_mandir}/man8/ibcheckportstate*
+%{_sbindir}/ibcheckwidth
+%{_mandir}/man8/ibcheckwidth*
+%{_sbindir}/ibcheckstate
+%{_mandir}/man8/ibcheckstate*
+%{_sbindir}/ibcheckerrors
+%{_mandir}/man8/ibcheckerrors*
+%{_sbindir}/ibdatacounts
+%{_mandir}/man8/ibdatacounts*
+%{_sbindir}/ibdatacounters
+%{_mandir}/man8/ibdatacounters*
+%{_sbindir}/ibdiscover.pl
+%{_mandir}/man8/ibdiscover*
+%{_sbindir}/ibswportwatch.pl
+%{_mandir}/man8/ibswportwatch*
+%{_sbindir}/ibqueryerrors.pl
+%{_sbindir}/iblinkinfo.pl
+%{_sbindir}/ibprintca.pl
+%{_mandir}/man8/ibprintca*
+%{_sbindir}/ibprintswitch.pl
+%{_mandir}/man8/ibprintswitch*
+%{_sbindir}/ibprintrt.pl
+%{_mandir}/man8/ibprintrt*
+%{_sbindir}/set_nodedesc.sh
+
+%files -n infiniband-diags
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
+%{_sbindir}/ibclearerrors
+%{_mandir}/man8/ibclearerrors*
+%{_sbindir}/ibclearcounters
+%{_mandir}/man8/ibclearcounters*
+%{_sbindir}/ibstatus
+%{_mandir}/man8/ibstatus*
+%{_mandir}/man8/infiniband-diags*
+%{_libdir}/libibmad*.so.*
+%{_libdir}/libibnetdisc*.so.*
+%{perl_vendorlib}/IBswcountlimits.pm
+%config(noreplace) %{_sysconfdir}/infiniband-diags/error_thresholds
+%config(noreplace) %{_sysconfdir}/infiniband-diags/ibdiag.conf
 
 %files -n libibverbs
 %dir %{_sysconfdir}/libibverbs.d
-- 
2.21.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C81E5C8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfENXtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:46 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:33102 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENXto (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:44 -0400
Received: by mail-qt1-f180.google.com with SMTP id m32so1264921qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7oSw4AKUy6PKK2e6zyJNZ6FZqtsZXo6IU+vDEIguvg=;
        b=NKKEwXZ8qOU3XFyb2v6YNUaLV6Qdty9kuh9s3qKZzADMirDFvgKR0oDtszdFD1t6eW
         9uPdHw2OlvDllCCTUYkZpSVMaT6ciwHoNjUsLJJQYXiXTBt6WLJqQLVQjLXm57Aibxr1
         CoOR+PmW2HEUhzF1AIwDNTbiiGISsA2KL6kq5PIfAVTGJV3JibnrMFtdtzpkAMsm+HVm
         hgEM1PKCfoNKDiBGMaBJtoVW3IEOxHBnjcH5LphNocXgaWKsi0QPALVZ2XSVDJV90wO3
         cnuc7hptmQGMYHMAQJ3PMPLUVrYW2z8w2CKabEqB6Zz+J8Wv060R65Gsi+66pN1X6wjQ
         E+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7oSw4AKUy6PKK2e6zyJNZ6FZqtsZXo6IU+vDEIguvg=;
        b=U0/AkqFTmX7h+vNawTmUITLXT39rlM3iLV58ELNVkCBHkinW7QfOvlyImL8b78J7xE
         LWuy7hrQSPC3+E0uzkj9iXryliHvy03a/NPIQTVUtdQFZkoJHUPh69/CGLy2hCZfBYVm
         1y0+u1shtJAbVWU3Vm94Qb79qfxPAeQAcYh61xkV2+Kky3zdxWygGA/nfsp1c9c4MNLK
         KbX3dPvA9q/Asgzxpp68+xEPlZdARS+kU4Unf6AqQaEyy14N485CjrBCIrZQXPXuGwhY
         mkTYc9Enj+rjlFqSDB1TIbPLwRat1RIqSbhZemQY57pZ7Nu/UZAYzullpOhdHrLzUUoX
         0mUA==
X-Gm-Message-State: APjAAAURBBjbjM/lEHr5P/wHTJggi8bEdSpFF6kWJUodR1xeQl5J05Wg
        NnGw6mh+moVX19g08ayOAEWD1+OH0ek=
X-Google-Smtp-Source: APXvYqxQs+ngdIsrVG6a2yLT2YBFl+VlJ+E0N8HWwR7sxhOwb/Ve3pPE1z3DZEcJEiv7u+LJMxP2jw==
X-Received: by 2002:ac8:1d02:: with SMTP id d2mr7666588qtl.148.1557877783036;
        Tue, 14 May 2019 16:49:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y13sm123420qka.82.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001Nh-4s; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 11/20] ibdiags: Add Debian packaging
Date:   Tue, 14 May 2019 20:49:27 -0300
Message-Id: <20190514234936.5175-12-jgg@ziepe.ca>
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

This is largely copied from the latest Debian/Ubuntu release.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 debian/control                  | 101 +++++++++++++++++++++
 debian/infiniband-diags.install |  64 +++++++++++++
 debian/libibmad-dev.install     |   5 ++
 debian/libibmad5.install        |   1 +
 debian/libibmad5.symbols        | 154 ++++++++++++++++++++++++++++++++
 debian/libibnetdisc-dev.install |  13 +++
 debian/libibnetdisc5.install    |   1 +
 debian/libibnetdisc5.symbols    |  20 +++++
 debian/rules                    |   4 +-
 9 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 debian/infiniband-diags.install
 create mode 100644 debian/libibmad-dev.install
 create mode 100644 debian/libibmad5.install
 create mode 100644 debian/libibmad5.symbols
 create mode 100644 debian/libibnetdisc-dev.install
 create mode 100644 debian/libibnetdisc5.install
 create mode 100644 debian/libibnetdisc5.symbols

diff --git a/debian/control b/debian/control
index f4480827bf86af..f0f43da0d641b8 100644
--- a/debian/control
+++ b/debian/control
@@ -337,3 +337,104 @@ Depends: rdma-core (>= 21),
 Provides: ${python3:Provides}
 Description: Pyverbs is a Python bindings for rdma-core
  It allows an easy development in Python language of RDMA applications.
+
+Package: infiniband-diags
+Architecture: linux-any
+Depends: libibnetdisc5 (= ${binary:Version}),
+         ${misc:Depends},
+         ${perl:Depends},
+         ${shlibs:Depends}
+Description: InfiniBand diagnostic programs
+ InfiniBand is a switched fabric communications link used in
+ high-performance computing and enterprise data centers. Its features
+ include high throughput, low latency, quality of service and
+ failover, and it is designed to be scalable.
+ .
+ This package provides diagnostic programs and scripts needed to
+ diagnose an InfiniBand subnet.
+
+Package: libibmad5
+Section: libs
+Architecture: linux-any
+Pre-Depends: ${misc:Pre-Depends}
+Depends: ${misc:Depends}, ${shlibs:Depends}
+Description: Infiniband Management Datagram (MAD) library
+ libibmad provides low layer InfiniBand functions for use by the
+ Infiniband diagnostic and management programs. These include
+ Management Datagrams (MAD), Subnet Administration (SA), Subnet
+ Management Packets (SMP) and other basic functions.
+ .
+ This package contains the shared library.
+
+Package: libibmad5-dbg
+Section: libs
+Architecture: linux-any
+Pre-Depends: ${misc:Pre-Depends}
+Depends: libibmad5 (= ${binary:Version}), ${misc:Depends}
+Description: Infiniband Management Datagram (MAD) library
+ libibmad provides low layer InfiniBand functions for use by the
+ Infiniband diagnostic and management programs. These include
+ Management Datagrams (MAD), Subnet Administration (SA), Subnet
+ Management Packets (SMP) and other basic functions.
+ .
+ This package contains the debug symbols associated with
+ libibmad5. They will automatically be used by gdb for debugging
+ libibmad-related issues.
+
+Package: libibmad-dev
+Section: libdevel
+Architecture: linux-any
+Depends: libibmad5 (= ${binary:Version}), ${misc:Depends}
+Description: Development files for libibmad
+ libibmad provides low layer Infiniband functions for use by the
+ InfiniBand diagnostic and management programs. These include
+ Management Datagrams (MAD), Subnet Administration (SA), Subnet
+ Management Packets (SMP) and other basic functions.
+ .
+ This package is needed to compile programs against libibmad5.
+ It contains the header files and static libraries (optionally)
+ needed for compiling.
+
+Package: libibnetdisc5
+Section: libs
+Architecture: linux-any
+Pre-Depends: ${misc:Pre-Depends}
+Depends: ${misc:Depends}, ${shlibs:Depends}
+Description: InfiniBand diagnostics library
+ InfiniBand is a switched fabric communications link used in
+ high-performance computing and enterprise data centers. Its features
+ include high throughput, low latency, quality of service and
+ failover, and it is designed to be scalable.
+ .
+ This package provides libraries required by the InfiniBand
+ diagnostic programs.
+
+Package: libibnetdisc5-dbg
+Section: libs
+Architecture: linux-any
+Depends: libibnetdisc5 (= ${binary:Version}), ${misc:Depends}
+Description: InfiniBand diagnostics library
+ InfiniBand is a switched fabric communications link used in
+ high-performance computing and enterprise data centers. Its features
+ include high throughput, low latency, quality of service and
+ failover, and it is designed to be scalable.
+ .
+ This package contains the debug symbols associated with
+ libibnetdisc. They will automatically be used by gdb for debugging
+ libibnetdisc-related issues.
+
+Package: libibnetdisc-dev
+Section: libdevel
+Architecture: linux-any
+Depends: libibnetdisc5 (= ${binary:Version}), ${misc:Depends}
+Breaks: infiniband-diags (<< 2.0.0)
+Replaces: infiniband-diags (<< 2.0.0)
+Description: InfiniBand diagnostics library headers
+ InfiniBand is a switched fabric communications link used in
+ high-performance computing and enterprise data centers. Its features
+ include high throughput, low latency, quality of service and
+ failover, and it is designed to be scalable.
+ .
+ This package provides development files required to build
+ applications aginast the libibnetdisc5 InfiniBand diagnostic
+ libraries.
diff --git a/debian/infiniband-diags.install b/debian/infiniband-diags.install
new file mode 100644
index 00000000000000..5cbda3ae2d34f9
--- /dev/null
+++ b/debian/infiniband-diags.install
@@ -0,0 +1,64 @@
+etc/infiniband-diags/error_thresholds
+etc/infiniband-diags/ibdiag.conf
+usr/sbin/check_lft_balance
+usr/sbin/dump_fts
+usr/sbin/dump_lfts
+usr/sbin/dump_mfts
+usr/sbin/ibaddr
+usr/sbin/ibcacheedit
+usr/sbin/ibccconfig
+usr/sbin/ibccquery
+usr/sbin/ibfindnodesusing
+usr/sbin/ibhosts
+usr/sbin/ibidsverify
+usr/sbin/iblinkinfo
+usr/sbin/ibnetdiscover
+usr/sbin/ibnodes
+usr/sbin/ibping
+usr/sbin/ibportstate
+usr/sbin/ibqueryerrors
+usr/sbin/ibroute
+usr/sbin/ibrouters
+usr/sbin/ibstat
+usr/sbin/ibstatus
+usr/sbin/ibswitches
+usr/sbin/ibsysstat
+usr/sbin/ibtracert
+usr/sbin/perfquery
+usr/sbin/saquery
+usr/sbin/sminfo
+usr/sbin/smpdump
+usr/sbin/smpquery
+usr/sbin/vendstat
+usr/share/man/man8/check_lft_balance.8
+usr/share/man/man8/dump_fts.8
+usr/share/man/man8/dump_lfts.8
+usr/share/man/man8/dump_mfts.8
+usr/share/man/man8/ibaddr.8
+usr/share/man/man8/ibcacheedit.8
+usr/share/man/man8/ibccconfig.8
+usr/share/man/man8/ibccquery.8
+usr/share/man/man8/ibfindnodesusing.8
+usr/share/man/man8/ibhosts.8
+usr/share/man/man8/ibidsverify.8
+usr/share/man/man8/iblinkinfo.8
+usr/share/man/man8/ibnetdiscover.8
+usr/share/man/man8/ibnodes.8
+usr/share/man/man8/ibping.8
+usr/share/man/man8/ibportstate.8
+usr/share/man/man8/ibqueryerrors.8
+usr/share/man/man8/ibroute.8
+usr/share/man/man8/ibrouters.8
+usr/share/man/man8/ibstat.8
+usr/share/man/man8/ibstatus.8
+usr/share/man/man8/ibswitches.8
+usr/share/man/man8/ibsysstat.8
+usr/share/man/man8/ibtracert.8
+usr/share/man/man8/infiniband-diags.8
+usr/share/man/man8/perfquery.8
+usr/share/man/man8/saquery.8
+usr/share/man/man8/sminfo.8
+usr/share/man/man8/smpdump.8
+usr/share/man/man8/smpquery.8
+usr/share/man/man8/vendstat.8
+usr/share/perl5/IBswcountlimits.pm
diff --git a/debian/libibmad-dev.install b/debian/libibmad-dev.install
new file mode 100644
index 00000000000000..008365071fc15f
--- /dev/null
+++ b/debian/libibmad-dev.install
@@ -0,0 +1,5 @@
+usr/include/infiniband/mad.h
+usr/include/infiniband/mad_osd.h
+usr/lib/*/libibmad*.a
+usr/lib/*/libibmad*.so
+usr/lib/*/pkgconfig/libibmad.pc
diff --git a/debian/libibmad5.install b/debian/libibmad5.install
new file mode 100644
index 00000000000000..d89b39373b8f79
--- /dev/null
+++ b/debian/libibmad5.install
@@ -0,0 +1 @@
+usr/lib/*/libibmad*.so.*
diff --git a/debian/libibmad5.symbols b/debian/libibmad5.symbols
new file mode 100644
index 00000000000000..c352e756edb39a
--- /dev/null
+++ b/debian/libibmad5.symbols
@@ -0,0 +1,154 @@
+libibmad.so.5 libibmad5 #MINVER#
+ IBMAD_1.3@IBMAD_1.3 1.3.11
+ bm_call_via@IBMAD_1.3 1.3.11
+ cc_config_status_via@IBMAD_1.3 1.3.11
+ cc_query_status_via@IBMAD_1.3 1.3.11
+ drpath2str@IBMAD_1.3 1.3.11
+ ib_node_query_via@IBMAD_1.3 1.3.11
+ ib_path_query@IBMAD_1.3 1.3.11
+ ib_path_query_via@IBMAD_1.3 1.3.11
+ ib_resolve_gid_via@IBMAD_1.3 1.3.11
+ ib_resolve_guid_via@IBMAD_1.3 1.3.11
+ ib_resolve_portid_str@IBMAD_1.3 1.3.11
+ ib_resolve_portid_str_via@IBMAD_1.3 1.3.11
+ ib_resolve_self@IBMAD_1.3 1.3.11
+ ib_resolve_self_via@IBMAD_1.3 1.3.11
+ ib_resolve_smlid@IBMAD_1.3 1.3.11
+ ib_resolve_smlid_via@IBMAD_1.3 1.3.11
+ ib_vendor_call@IBMAD_1.3 1.3.11
+ ib_vendor_call_via@IBMAD_1.3 1.3.11
+ ibdebug@IBMAD_1.3 1.3.11
+ mad_alloc@IBMAD_1.3 1.3.11
+ mad_build_pkt@IBMAD_1.3 1.3.11
+ mad_class_agent@IBMAD_1.3 1.3.11
+ mad_decode_field@IBMAD_1.3 1.3.11
+ mad_dump_array@IBMAD_1.3 1.3.11
+ mad_dump_bitfield@IBMAD_1.3 1.3.11
+ mad_dump_cc_cacongestionentry@IBMAD_1.3 1.3.11
+ mad_dump_cc_cacongestionsetting@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestioncontroltable@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestioncontroltableentry@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestioninfo@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionkeyinfo@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionlog@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionlogca@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionlogentryca@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionlogentryswitch@IBMAD_1.3 1.3.11
+ mad_dump_cc_congestionlogswitch@IBMAD_1.3 1.3.11
+ mad_dump_cc_switchcongestionsetting@IBMAD_1.3 1.3.11
+ mad_dump_cc_switchportcongestionsettingelement@IBMAD_1.3 1.3.11
+ mad_dump_cc_timestamp@IBMAD_1.3 1.3.11
+ mad_dump_classportinfo@IBMAD_1.3 1.3.11
+ mad_dump_field@IBMAD_1.3 1.3.11
+ mad_dump_fields@IBMAD_1.3 1.3.11
+ mad_dump_hex@IBMAD_1.3 1.3.11
+ mad_dump_int@IBMAD_1.3 1.3.11
+ mad_dump_linkdowndefstate@IBMAD_1.3 1.3.11
+ mad_dump_linkspeed@IBMAD_1.3 1.3.11
+ mad_dump_linkspeeden@IBMAD_1.3 1.3.11
+ mad_dump_linkspeedext@IBMAD_1.3 1.3.11
+ mad_dump_linkspeedexten@IBMAD_1.3 1.3.11
+ mad_dump_linkspeedextsup@IBMAD_1.3 1.3.11
+ mad_dump_linkspeedsup@IBMAD_1.3 1.3.11
+ mad_dump_linkwidth@IBMAD_1.3 1.3.11
+ mad_dump_linkwidthen@IBMAD_1.3 1.3.11
+ mad_dump_linkwidthsup@IBMAD_1.3 1.3.11
+ mad_dump_mlnx_ext_port_info@IBMAD_1.3 1.3.11
+ mad_dump_mtu@IBMAD_1.3 1.3.11
+ mad_dump_node_type@IBMAD_1.3 1.3.11
+ mad_dump_nodedesc@IBMAD_1.3 1.3.11
+ mad_dump_nodeinfo@IBMAD_1.3 1.3.11
+ mad_dump_opervls@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_ext@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_flow_ctl_counters@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_op_rcv_counters@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_vl_op_data@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_vl_op_packet@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_vl_xmit_flow_ctl_update_errors@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_port_vl_xmit_wait_counters@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_rcv_con_ctrl@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_rcv_err@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_rcv_sl@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_sl_rcv_becn@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_sl_rcv_fecn@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_sw_port_vl_congestion@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_vl_xmit_time_cong@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_xmit_con_ctrl@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_xmt_disc@IBMAD_1.3 1.3.11
+ mad_dump_perfcounters_xmt_sl@IBMAD_1.3 1.3.11
+ mad_dump_physportstate@IBMAD_1.3 1.3.11
+ mad_dump_port_ext_speeds_counters@IBMAD_1.3 1.3.11
+ mad_dump_port_ext_speeds_counters_rsfec_active@IBMAD_1.3 1.3.12
+ mad_dump_portcapmask2@IBMAD_1.3 2.1.0
+ mad_dump_portcapmask@IBMAD_1.3 1.3.11
+ mad_dump_portinfo@IBMAD_1.3 1.3.11
+ mad_dump_portinfo_ext@IBMAD_1.3 1.3.12
+ mad_dump_portsamples_control@IBMAD_1.3 1.3.11
+ mad_dump_portsamples_result@IBMAD_1.3 1.3.11
+ mad_dump_portstate@IBMAD_1.3 1.3.11
+ mad_dump_portstates@IBMAD_1.3 1.3.11
+ mad_dump_rhex@IBMAD_1.3 1.3.11
+ mad_dump_sltovl@IBMAD_1.3 1.3.11
+ mad_dump_string@IBMAD_1.3 1.3.11
+ mad_dump_switchinfo@IBMAD_1.3 1.3.11
+ mad_dump_uint@IBMAD_1.3 1.3.11
+ mad_dump_val@IBMAD_1.3 1.3.11
+ mad_dump_vlarbitration@IBMAD_1.3 1.3.11
+ mad_dump_vlcap@IBMAD_1.3 1.3.11
+ mad_encode@IBMAD_1.3 1.3.11
+ mad_encode_field@IBMAD_1.3 1.3.11
+ mad_field_name@IBMAD_1.3 1.3.11
+ mad_free@IBMAD_1.3 1.3.11
+ mad_get_array@IBMAD_1.3 1.3.11
+ mad_get_field64@IBMAD_1.3 1.3.11
+ mad_get_field@IBMAD_1.3 1.3.11
+ mad_get_retries@IBMAD_1.3 1.3.11
+ mad_get_timeout@IBMAD_1.3 1.3.11
+ mad_print_field@IBMAD_1.3 1.3.11
+ mad_receive@IBMAD_1.3 1.3.11
+ mad_receive_via@IBMAD_1.3 1.3.11
+ mad_register_client@IBMAD_1.3 1.3.11
+ mad_register_client_via@IBMAD_1.3 1.3.11
+ mad_register_server@IBMAD_1.3 1.3.11
+ mad_register_server_via@IBMAD_1.3 1.3.11
+ mad_respond@IBMAD_1.3 1.3.11
+ mad_respond_via@IBMAD_1.3 1.3.11
+ mad_rpc@IBMAD_1.3 1.3.11
+ mad_rpc_class_agent@IBMAD_1.3 1.3.11
+ mad_rpc_close_port@IBMAD_1.3 1.3.11
+ mad_rpc_open_port@IBMAD_1.3 1.3.11
+ mad_rpc_portid@IBMAD_1.3 1.3.11
+ mad_rpc_rmpp@IBMAD_1.3 1.3.11
+ mad_rpc_set_retries@IBMAD_1.3 1.3.11
+ mad_rpc_set_timeout@IBMAD_1.3 1.3.11
+ mad_send@IBMAD_1.3 1.3.11
+ mad_send_via@IBMAD_1.3 1.3.11
+ mad_set_array@IBMAD_1.3 1.3.11
+ mad_set_field64@IBMAD_1.3 1.3.11
+ mad_set_field@IBMAD_1.3 1.3.11
+ mad_trid@IBMAD_1.3 1.3.11
+ madrpc@IBMAD_1.3 1.3.11
+ madrpc_init@IBMAD_1.3 1.3.11
+ madrpc_portid@IBMAD_1.3 1.3.11
+ madrpc_rmpp@IBMAD_1.3 1.3.11
+ madrpc_save_mad@IBMAD_1.3 1.3.11
+ madrpc_set_retries@IBMAD_1.3 1.3.11
+ madrpc_set_timeout@IBMAD_1.3 1.3.11
+ madrpc_show_errors@IBMAD_1.3 1.3.11
+ performance_reset_via@IBMAD_1.3 1.3.11
+ pma_query_via@IBMAD_1.3 1.3.11
+ portid2portnum@IBMAD_1.3 1.3.11
+ portid2str@IBMAD_1.3 1.3.11
+ sa_call@IBMAD_1.3 1.3.11
+ sa_rpc_call@IBMAD_1.3 1.3.11
+ smp_mkey_get@IBMAD_1.3 1.3.11
+ smp_mkey_set@IBMAD_1.3 1.3.11
+ smp_query@IBMAD_1.3 1.3.11
+ smp_query_status_via@IBMAD_1.3 1.3.11
+ smp_query_via@IBMAD_1.3 1.3.11
+ smp_set@IBMAD_1.3 1.3.11
+ smp_set_status_via@IBMAD_1.3 1.3.11
+ smp_set_via@IBMAD_1.3 1.3.11
+ str2drpath@IBMAD_1.3 1.3.11
+ xdump@IBMAD_1.3 1.3.11
diff --git a/debian/libibnetdisc-dev.install b/debian/libibnetdisc-dev.install
new file mode 100644
index 00000000000000..bd5f4c73b4f924
--- /dev/null
+++ b/debian/libibnetdisc-dev.install
@@ -0,0 +1,13 @@
+usr/include/infiniband/ibnetdisc*
+usr/lib/*/libibnetdisc*.a
+usr/lib/*/libibnetdisc*.so
+usr/lib/*/pkgconfig/libibnetdisc.pc
+usr/share/man/man3/ibnd_debug.3
+usr/share/man/man3/ibnd_destroy_fabric.3
+usr/share/man/man3/ibnd_discover_fabric.3
+usr/share/man/man3/ibnd_find_node_dr.3
+usr/share/man/man3/ibnd_find_node_guid.3
+usr/share/man/man3/ibnd_iter_nodes.3
+usr/share/man/man3/ibnd_iter_nodes_type.3
+usr/share/man/man3/ibnd_set_max_smps_on_wire.3
+usr/share/man/man3/ibnd_show_progress.3
diff --git a/debian/libibnetdisc5.install b/debian/libibnetdisc5.install
new file mode 100644
index 00000000000000..54684fd3ccd9e3
--- /dev/null
+++ b/debian/libibnetdisc5.install
@@ -0,0 +1 @@
+usr/lib/*/libibnetdisc*.so.*
diff --git a/debian/libibnetdisc5.symbols b/debian/libibnetdisc5.symbols
new file mode 100644
index 00000000000000..ec8429c03c6b7d
--- /dev/null
+++ b/debian/libibnetdisc5.symbols
@@ -0,0 +1,20 @@
+libibnetdisc.so.5 libibnetdisc5 #MINVER#
+ IBNETDISC_1.0@IBNETDISC_1.0 1.6.1
+ ibnd_cache_fabric@IBNETDISC_1.0 1.6.1
+ ibnd_destroy_fabric@IBNETDISC_1.0 1.6.1
+ ibnd_discover_fabric@IBNETDISC_1.0 1.6.1
+ ibnd_find_node_dr@IBNETDISC_1.0 1.6.1
+ ibnd_find_node_guid@IBNETDISC_1.0 1.6.1
+ ibnd_find_port_dr@IBNETDISC_1.0 1.6.1
+ ibnd_find_port_guid@IBNETDISC_1.0 1.6.1
+ ibnd_find_port_lid@IBNETDISC_1.0 1.6.4
+ ibnd_get_chassis_guid@IBNETDISC_1.0 1.6.1
+ ibnd_get_chassis_slot_str@IBNETDISC_1.0 1.6.1
+ ibnd_get_chassis_type@IBNETDISC_1.0 1.6.1
+ ibnd_is_xsigo_guid@IBNETDISC_1.0 1.6.1
+ ibnd_is_xsigo_hca@IBNETDISC_1.0 1.6.1
+ ibnd_is_xsigo_tca@IBNETDISC_1.0 1.6.1
+ ibnd_iter_nodes@IBNETDISC_1.0 1.6.1
+ ibnd_iter_nodes_type@IBNETDISC_1.0 1.6.1
+ ibnd_iter_ports@IBNETDISC_1.0 1.6.1
+ ibnd_load_fabric@IBNETDISC_1.0 1.6.1
diff --git a/debian/rules b/debian/rules
index 744bf28c52f070..07c9c145ff090c 100755
--- a/debian/rules
+++ b/debian/rules
@@ -35,8 +35,8 @@ DH_AUTO_CONFIGURE := "--" \
 		     "-DCMAKE_INSTALL_SHAREDSTATEDIR:PATH=/var/lib" \
 		     "-DCMAKE_INSTALL_RUNDIR:PATH=/run" \
 		     "-DCMAKE_INSTALL_UDEV_RULESDIR:PATH=/lib/udev/rules.d" \
+		     "-DCMAKE_INSTALL_PERLDIR:PATH=/usr/share/perl5" \
 		     "-DENABLE_STATIC=1" \
-		     "-DWITH_IBDIAGS:BOOL=False" \
 		     $(EXTRA_CMAKE_FLAGS)
 
 override_dh_auto_configure:
@@ -99,6 +99,8 @@ override_dh_makeshlibs:
 	dh_makeshlibs $(SHLIBS_EXCLUDE)
 
 override_dh_strip:
+	dh_strip -plibibmad5 --dbg-package=libibmad5-dbg
+	dh_strip -plibibnetdisc5 --dbg-package=libibnetdisc5-dbg
 	dh_strip -plibibumad3 --dbg-package=libibumad3-dbg
 	dh_strip -plibibverbs1 --dbg-package=libibverbs1-dbg
 	dh_strip -plibrdmacm1 --dbg-package=librdmacm1-dbg
-- 
2.21.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71270655
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGVRCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 13:02:17 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:17827
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727916AbfGVRCQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 13:02:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljo7GwnsvrBpP427MU216gI/WU5zKeu8ZX2fYBJP6AqaiRA4Iz8qmOc5X8VBNWpoD66HtevwtFgaas4aRUY4z2DcdQ2tsesTLjyKLzfyeJRcJ2XrXvbGFPm/HLAfxgerKz2he386noykfUVB3czzKACbr14s2eVX22Eq8YIC5uLjnzabgfDSoUU7tLUAtJwfzFAUtT7aw8PH00w0X5IOK/aLSMblExGEDsimfGEDC4bS14GDUSXdUmxk2bhx58PwKI/WHtipM8K2YrZ9LtXui2XSSLacKY+2vhB2OfLtjth20hpd3kU0/Y+ZHaEHnA93sgnWGO0QY/nR1Vn/cEBqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3drec8ImyFwGLcWhfzd/GaDQ6zMxEzL1nnwlLxpKnQA=;
 b=UA7WJ9unMTr58otCBHtiGyxHt7kJi0GV1LoDhSaIlhT9wMV0VJH8IW5LkW+PT7tP1Pa7XquJhAVuUHxwWUCDWS/QjiHSgWmjQLH6SqvPQmzma5Qbg+Q9Yisz+2ck9iu7I7LadqCMmRXl647TCZ4TFkzKyIFirld8QgMwMUE//5fWuOFl7QUZanDAlKwWo4JXHCwlseSyz7stqA8yC7XhMUT5aqzVPvO80C7v6Q9QYDwZVyCkNwNAlFO9ZiQ2HKNwuaXs3KeQGXR/Y21X+4RTGEMeCdiilGFTZMiZvaFw/+TC0kLct8uy/cp0HJUaFrbAISpIxhjsOKOhMZyTsE0q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3drec8ImyFwGLcWhfzd/GaDQ6zMxEzL1nnwlLxpKnQA=;
 b=rMgR3c5mEAMhdF3sLejN3dN25Fmu8IHgzHwdDHPKVapDJDAVZZNn/abdVS+Yu5svdaeIIGC1sIajBqQv8SeBk6ogGvyeDO1CSPn9ScFfFI9k7bmUfATpsoP6t3Bw/O+tM4c+FgNo8mmbBCBhECfve4MFTcFU1yDQXXZhn4zDOLs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5485.eurprd05.prod.outlook.com (20.177.63.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.15; Mon, 22 Jul 2019 17:01:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 17:01:30 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH] RDMA: Make most headers compile stand alone
Thread-Topic: [PATCH] RDMA: Make most headers compile stand alone
Thread-Index: AQHVQK8bNjkekawdNkeecDoUCAURRA==
Date:   Mon, 22 Jul 2019 17:01:30 +0000
Message-ID: <20190722170126.GA16453@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2f00566-2cf7-4c4e-8e50-08d70ec63e34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5485;
x-ms-traffictypediagnostic: VI1PR05MB5485:
x-microsoft-antispam-prvs: <VI1PR05MB54856D177DE6C74C4E88A3BACFC40@VI1PR05MB5485.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(316002)(52116002)(6486002)(14454004)(25786009)(2351001)(6916009)(2501003)(54906003)(8676002)(305945005)(102836004)(99286004)(186003)(476003)(26005)(3846002)(6116002)(7736002)(386003)(6506007)(2906002)(9686003)(4326008)(81166006)(81156014)(68736007)(8936002)(53936002)(66066001)(66476007)(66946007)(66446008)(64756008)(86362001)(256004)(5660300002)(66556008)(1076003)(71190400001)(71200400001)(6436002)(5640700003)(36756003)(478600001)(33656002)(6512007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5485;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eTzlpET2DSJPWgAxC/sj41EkrNtlpOlxOeKoXKQ6RqE8o47ytSm4n6MKuncuzfo9qcfkvaaJ4zdWteCNWZi+zWu20LbrTwdgGJqtgxQfBuKo0ewlBLncnSutmMcMupo0YOED2WBRVW+5dtsR7WwFfobLG30jz/vMjQwf6oIpA+r4/t/SaSmWeBrVypdQIMKwwa2OMm7Fa/ZjAqqjnOoOmW8YB5c9EdBdEEB4jhxG4/EWcZMK4W10qKccY18VtzYKPeN3bk2W55vWkWoJfrwhmj4180ofmtJb/ucBbhpJWjUo/ChjBx6n7MOMM1rsyRdNpWqUIF/0k+dxyG4kWbCDg+GyZOmmMaTvgSKMBuwgttSWODVMDGMA+F1EINLUeWdbiOisgz3JGnitkrRdPrdQfqNKIvylFrB+ni9+qjVG3oo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E5DAE2BF8BBE34A944F7642C668AC5E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f00566-2cf7-4c4e-8e50-08d70ec63e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 17:01:30.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5485
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

So that rdma can work with CONFIG_KERNEL_HEADER_TEST and
CONFIG_HEADERS_CHECK.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/Kbuild               | 6 ------
 include/rdma/ib.h            | 2 ++
 include/rdma/iw_portmap.h    | 3 +++
 include/rdma/opa_port_info.h | 2 ++
 include/rdma/rdmavt_cq.h     | 1 +
 include/rdma/signature.h     | 2 ++
 6 files changed, 10 insertions(+), 6 deletions(-)

HFI guys: you need to fix the problems around tid_rdma_defs.h

diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267cb..fc2aa4e2065811 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -945,12 +945,6 @@ header-test-			+=3D net/xdp.h
 header-test-			+=3D net/xdp_priv.h
 header-test-			+=3D pcmcia/cistpl.h
 header-test-			+=3D pcmcia/ds.h
-header-test-			+=3D rdma/ib.h
-header-test-			+=3D rdma/iw_portmap.h
-header-test-			+=3D rdma/opa_port_info.h
-header-test-			+=3D rdma/rdmavt_cq.h
-header-test-			+=3D rdma/restrack.h
-header-test-			+=3D rdma/signature.h
 header-test-			+=3D rdma/tid_rdma_defs.h
 header-test-			+=3D scsi/fc/fc_encaps.h
 header-test-			+=3D scsi/fc/fc_fc2.h
diff --git a/include/rdma/ib.h b/include/rdma/ib.h
index 4f385ec54f80ce..fe2fc9e91588de 100644
--- a/include/rdma/ib.h
+++ b/include/rdma/ib.h
@@ -36,6 +36,8 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
=20
 struct ib_addr {
 	union {
diff --git a/include/rdma/iw_portmap.h b/include/rdma/iw_portmap.h
index b9fee7feeeb5a5..c89535047c42cd 100644
--- a/include/rdma/iw_portmap.h
+++ b/include/rdma/iw_portmap.h
@@ -33,6 +33,9 @@
 #ifndef _IW_PORTMAP_H
 #define _IW_PORTMAP_H
=20
+#include <linux/socket.h>
+#include <linux/netlink.h>
+
 #define IWPM_ULIBNAME_SIZE	32
 #define IWPM_DEVNAME_SIZE	32
 #define IWPM_IFNAME_SIZE	16
diff --git a/include/rdma/opa_port_info.h b/include/rdma/opa_port_info.h
index 7147a92630114d..bdbfe25d38548b 100644
--- a/include/rdma/opa_port_info.h
+++ b/include/rdma/opa_port_info.h
@@ -33,6 +33,8 @@
 #if !defined(OPA_PORT_INFO_H)
 #define OPA_PORT_INFO_H
=20
+#include <rdma/opa_smi.h>
+
 #define OPA_PORT_LINK_MODE_NOP	0		/* No change */
 #define OPA_PORT_LINK_MODE_OPA	4		/* Port mode is OPA */
=20
diff --git a/include/rdma/rdmavt_cq.h b/include/rdma/rdmavt_cq.h
index 04c519ef6d715b..574eb7278f468f 100644
--- a/include/rdma/rdmavt_cq.h
+++ b/include/rdma/rdmavt_cq.h
@@ -53,6 +53,7 @@
=20
 #include <linux/kthread.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/ib_verbs.h>
=20
 /*
  * Define an ib_cq_notify value that is not valid so we know when CQ
diff --git a/include/rdma/signature.h b/include/rdma/signature.h
index f24cc2a1d3c5d9..d16b0fcc8344b3 100644
--- a/include/rdma/signature.h
+++ b/include/rdma/signature.h
@@ -6,6 +6,8 @@
 #ifndef _RDMA_SIGNATURE_H_
 #define _RDMA_SIGNATURE_H_
=20
+#include <linux/types.h>
+
 enum ib_signature_prot_cap {
 	IB_PROT_T10DIF_TYPE_1 =3D 1,
 	IB_PROT_T10DIF_TYPE_2 =3D 1 << 1,
--=20
2.22.0


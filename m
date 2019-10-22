Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24ABE0CFF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfJVUFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:05:55 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:61348
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731806AbfJVUFy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJSfKlg0pTSvHzmT1W10kEcuMHg2NhTX+no47W3ayCQNzHtUgtjNjpyPNdRN7kWu53wV2qIq2Pqy2I0tZJ0P08WSwrmsIsxGGflGJ9/MGiuWDpvbDJj8uXkoiOlCTKw2dmzVlq6/JfY6nasdmLj70TUPLBpZJYVQZrh3/0tcSN2hRhVXCkG8/OmaWB5sVPD3LKf/kSvBm7Vlg/+Ax71R6YgDlA2juhzRZ2Aki6kftVeh4Agnxy6Ph8xNvYHGp56UVA3qdQ/bzjFKT8FCUFohRqDfyJsDc68PBuc31ezjr1CzZu4FMgnue/9PpUsoVe4K8l9zI1VGOCbRi5m1OuH05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5qjB1HSBrqcw4Q7i+cHIV0UF9KZp5IkgHyn6y5MO0=;
 b=PB/wbz4EK7RRRRAaXJneHtFa5GYnHCNICfhj+OQqZXUixThNn91KnmmeF87U7swajWeRDm+gwwUu8XWeE3T95ZEgV/rxfdZZnztIdPmeQxypGYa8rkDGIWSfeEcV/LknQkMuxMklyLHlQda5PqhGYrj3TtR9sEKoM2FzF+/pHTxAbElbfxPx4yOlCzFpURQ/35b6ySCpdyeAuH0/eqnxSCPPTn8+3W1roVQK89swx5kh0poNt/lhyTi1+B2lq0zMZkilprHnyTER8vIVSMxD5PWO/erfVgnhThtnCRi8yoAlTghketRdFozzYdE9vzrGkTxeuqueKlWnUF9SEoxPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5qjB1HSBrqcw4Q7i+cHIV0UF9KZp5IkgHyn6y5MO0=;
 b=ov97vAkpr1q49nc/GJFQe5prvLjBRjZRZrNqmpu3YZmWZAtRkAVdDwF5WOj13X8xCXOPFeHXHxwQPjw4oapI31dfe/KbLHVhlJapUv+BXnO81neAFYYhMMyvDmCiX7H7lwSwCvopgsRxzdtl0WKeQ6RkwAZc/fO1ollQH2l5mCE=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5173.namprd05.prod.outlook.com (20.177.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 20:05:51 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2387.016; Tue, 22 Oct 2019
 20:05:51 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v3 0/3] vmw_pvrdma: Use physical resource ids from
 device
Thread-Topic: [PATCH rdma-core v3 0/3] vmw_pvrdma: Use physical resource ids
 from device
Thread-Index: AQHViRQapfWsmKB8ukGALUJcBa9udw==
Date:   Tue, 22 Oct 2019 20:05:51 +0000
Message-ID: <cover.1571774291.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c313cd1-addb-4083-aae7-08d7572b3c91
x-ms-traffictypediagnostic: BYAPR05MB5173:|BYAPR05MB5173:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB5173536785F78E0CB34EC0C3C5680@BYAPR05MB5173.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(54534003)(199004)(189003)(71200400001)(110136005)(26005)(6116002)(7736002)(66066001)(6512007)(2501003)(71190400001)(52116002)(2906002)(102836004)(99286004)(6506007)(305945005)(386003)(3846002)(6306002)(6486002)(186003)(5660300002)(486006)(6436002)(476003)(2616005)(14444005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(81166006)(81156014)(8936002)(50226002)(316002)(256004)(36756003)(86362001)(25786009)(2201001)(478600001)(107886003)(966005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5173;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1cFew2veOfB1G/9JFHjoqg1mdidY/bHNjWjTDviaRnWG3QCWuyE0ZomTSJw3ylRG3p0OMOCLfc5n4vF7N6Hwoz83+iyU7Yeg8zRWWAgCHAQQeDukFEBdOOJJeil0w97YRzSLUyjS3/4Kdnmz2TO5eRJV16/P63PBf88Eg7WGU25s3qWUpFlO2NGvOsCSAcgIv5IJeNT+S5sR6Q5GvimsqrlGbqKshvAXHWM+VtPyYyGlfFSNzKq76PMBkv/Svk6yYia9AxKnnAtQKE7cjhMiIhd3AOPv2e3Tsy3YnIVLE/t9w57yTW9oR5V5saZ9qVS2pmeen7/O8md2IBZGrXE25SpraTHifn5QCtqw2Mh8h2aJtd+u6WXpucckY1UHaOozMYD/GYj5Z062MqHldwD8dRxjECq6VX+mW7B19txQEH6+aksuXZIyguRSbfjTXQmKpg4CJ3G7bnfJLknw3mpOSiNXvDgjA/jAYEPfI0mUmM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c313cd1-addb-4083-aae7-08d7572b3c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:05:51.2371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHq3ECMFrlsE9JbuBsiCbriSnziwhSVIqhg07+l5/KnCJrAbHmhx2aVym8bCN6jdKWxaKa+qDh3cQa3Vzie8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5173
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changelog:
v3:
 - Remove create qp flag
 - Kernel abi update after cxgb3 removal
v2:
 - Used kernel-headers/update script to generate headers commit
v1:
 - Added a separate patch for the kernel header
 - Dropped the ABI version check
 - Added a create qp flag and an in-band check to indicate support
v0:
 - https://patchwork.kernel.org/patch/10946987/

Hi,

Here is a patchset for enabling exposing physical resource ids for vmw_pvrd=
ma
userspace provider.

rdma-core PR:
 - https://github.com/linux-rdma/rdma-core/pull/581

Thanks,
Adit

Adit Ranadive (2):
  Update kernel headers
  kernel-headers: Remove cxgb3-abi.h

Bryan Tan (1):
  vmw_pvrdma: Use resource ids from physical device if available

 CMakeLists.txt                             |  1 -
 kernel-headers/CMakeLists.txt              |  3 +-
 kernel-headers/rdma/cxgb3-abi.h            | 82 ----------------------
 kernel-headers/rdma/ib_user_ioctl_verbs.h  | 22 ++++++
 kernel-headers/rdma/rdma_user_ioctl_cmds.h | 22 ------
 kernel-headers/rdma/rvt-abi.h              | 66 +++++++++++++++++
 kernel-headers/rdma/vmw_pvrdma-abi.h       |  5 ++
 providers/vmw_pvrdma/pvrdma-abi.h          |  2 +-
 providers/vmw_pvrdma/pvrdma.h              |  1 +
 providers/vmw_pvrdma/qp.c                  | 23 +++---
 10 files changed, 108 insertions(+), 119 deletions(-)
 delete mode 100644 kernel-headers/rdma/cxgb3-abi.h
 create mode 100644 kernel-headers/rdma/rvt-abi.h

--=20
2.18.1


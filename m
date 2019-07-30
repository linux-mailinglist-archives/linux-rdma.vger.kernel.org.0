Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F667A7E8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfG3MPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 08:15:04 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:6534
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfG3MPE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 08:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwIWPcBKGItE/mrFkIhJYixj5tlPSdfkTkQScoOVOc3wvzBUQWIKygU7HySnGss+xLOG1vrvRTJ3dYCQXRG1L+hSn2rzWH0HGKNuMDRaRUiTYH1+nsuZVqkdMZCOxMkDaAowgJr5ryh/DbIC3Hb6G/GgN/TXEU8cAiW4qq48kLEOFSMuLiAXK7aBEuwNhjQ3PaL+hVv9fxPvVuGc94urmBLi2b/WU9eY/INjhOUeNpNepKcG+qMJvtHRILEYssyj96pnteZ5Xjlo/s/oKD1Si2g6HwlcMkRMWKgXyzjOI+Xi6PyVDNLPQlEoKckOg5T3Sr4t4ZvzOkd96If+K2m9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lfBK9qEz9ivtZchZEoo1215jKbBrziIbL2M+Ec8fuo=;
 b=JEEThh64TU/Mq+98mNYly4hODgu5zX37RIn3otdslD3nHxRsiYiKcSR23ErTq8LnHMFgHsonS5oNcsFfkE6yfwifCCChiYqIJe+Lb3dpec+F4E1B/uX2/iiVQgS4IrfZ6g/BQ8TlBAvOwJatdhAecTlQcilOR5CLJxHsfINEnzatVwaLq33UVJ8stm4qJCPUeu/gTlkH95e4NxZu0wyEA3F/wV6JlwXQT+P71Hb+GwqxgBj8AuD2dspv3t0Vj3B0rhBa4LNZd3OFr/ByHj4zBRjbqvoeOCAlzl6aBwJCI8u76iG3JvWNfMAX+C430eqP4t1ULaLy0PhT620MJPyOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lfBK9qEz9ivtZchZEoo1215jKbBrziIbL2M+Ec8fuo=;
 b=ah7A1Emv/YSqGgel+t+qW7OcDSLSv+czSGsuGfxVRITP9dxV8RO882xzMxllFXMB3iYapk8t5AxGH4quVS4N67EHLJh/DzU39SIWVvAU6LhXhlC+w2c+IX4on8J8umMgTh2I5NGH9TJGKNVP/5LlKkK0PaFYAdPBuQ7lZKknpeI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3248.eurprd05.prod.outlook.com (10.170.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 12:15:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 12:15:01 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVRtBpX/4X/EwR7US3b7d63vE1hQ==
Date:   Tue, 30 Jul 2019 12:15:01 +0000
Message-ID: <20190730121455.GA23902@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 717b568d-9db0-44e2-df33-08d714e78ba3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3248;
x-ms-traffictypediagnostic: VI1PR05MB3248:
x-microsoft-antispam-prvs: <VI1PR05MB324850192B329C1948A9C802CFDC0@VI1PR05MB3248.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(36756003)(54906003)(71200400001)(3846002)(81156014)(110136005)(7736002)(81166006)(9686003)(66476007)(52116002)(6512007)(66946007)(66556008)(66446008)(6116002)(316002)(8676002)(102836004)(33656002)(99286004)(64756008)(305945005)(478600001)(68736007)(71190400001)(6486002)(2906002)(386003)(86362001)(14454004)(25786009)(26005)(6506007)(1076003)(8936002)(256004)(14444005)(5660300002)(53936002)(4326008)(476003)(486006)(6436002)(186003)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3248;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UtyrqN3nXxBl5AAsmJtQsYD/93pDn3BIobGJjC5W3LuSQbgcL/KW8v8XWdQnkzc6fiNXt8lcyT9c6+SlU3RxNFVy9Nd0quqEWsei96ZpKRm81INGmUxS1kJIVrJinzLOC31FBFcEELfPKypCT5WEJBWEQE3RzwgamRQHH0fmw2NYzvQQNoQWOx8RQ00kbX0166CWqqbRaZ/YEaxhCHZ7s4RcmgRtzj/2TA9+iXt/rLMhw8EZRAXyfvW0QVfNb46bP2FUegl1voE5Z/IV0gMLRvxZU1jy4163gQiR3vgCe868FSDV7TvG0GEsIB79kUNtquwTxaZ0u1gsh3ZvjTiAK6mf+M7++HwPq1+i4/kuj9anoZTQixTZFSW3Z8zQUDElWzOGO3BLbLb0G/k1y/Hl0ABmeTG1Fe6xJab3q7A5+Bs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5712D05A1E18844A6BEE90BD811008B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717b568d-9db0-44e2-df33-08d714e78ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 12:15:01.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3248
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Linus,

First rc pull request

The usual collection of driver bug fixes, and fewer siw static checker
warnings than I feared.

Thanks,
Jason

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b=
:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to b7165bd0d6cbb93732559be6ea8774653b204480:

  IB/mlx5: Fix RSS Toeplitz setup to be aligned with the HW specification (=
2019-07-25 11:45:48 -0300)

----------------------------------------------------------------
5.3 rc RDMA pull request

A few regression and bug fixes for the patches merged in the last cycle:

- hns fixes a subtle crash from the ib core SGL rework

- hfi1 fixes various error handling, oops and protocol errors

- bnxt_re fixes a regression where nvmeof doesn't work on some
  configurations

- mlx5 fixes a serious 'use after free' bug in how MR caching is handled

- Some edge case crashers in the new statistic core code

- More siw static checker fixups

----------------------------------------------------------------
Chuhong Yuan (1):
      IB/mlx5: Replace kfree with kvfree

John Fleck (1):
      IB/hfi1: Check for error on call to alloc_rsm_map_table

Kaike Wan (3):
      IB/hfi1: Unreserve a flushed OPFN request
      IB/hfi1: Field not zero-ed when allocating TID flow memory
      IB/hfi1: Drop all TID RDMA READ RESP packets after r_next_psn

Mao Wenan (1):
      RDMA/siw: Remove set but not used variables 'rv'

Moni Shoua (1):
      IB/mlx5: Prevent concurrent MR updates during invalidation

Parav Pandit (2):
      IB/core: Fix querying total rdma stats
      IB/counters: Always initialize the port counter object

Selvin Xavier (1):
      RDMA/bnxt_re: Honor vlan_id in GID entry comparison

Wei Yongjun (1):
      RDMA/siw: Fix error return code in siw_init_module()

Xi Wang (1):
      RDMA/hns: Fix sg offset non-zero issue

Yishai Hadas (5):
      IB/mlx5: Fix unreg_umr to ignore the mkey state
      IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
      IB/mlx5: Move MRs to a kernel PD when freeing them to the MR cache
      IB/mlx5: Fix clean_mr() to work in the expected order
      IB/mlx5: Fix RSS Toeplitz setup to be aligned with the HW specificati=
on

 drivers/infiniband/core/counters.c        | 11 +++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  7 +++--
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 13 +++++++---
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 14 ++++++----
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  7 ++++-
 drivers/infiniband/hw/hfi1/chip.c         | 11 ++++++--
 drivers/infiniband/hw/hfi1/rc.c           |  2 --
 drivers/infiniband/hw/hfi1/tid_rdma.c     | 43 ++-------------------------=
----
 drivers/infiniband/hw/hns/hns_roce_db.c   | 15 ++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |  1 +
 drivers/infiniband/hw/mlx5/mr.c           | 23 ++++++++++-------
 drivers/infiniband/hw/mlx5/odp.c          |  7 ++---
 drivers/infiniband/hw/mlx5/qp.c           | 13 ++++++----
 drivers/infiniband/sw/siw/siw_cm.c        |  3 +--
 drivers/infiniband/sw/siw/siw_main.c      |  1 +
 include/rdma/rdmavt_qp.h                  |  9 +++----
 17 files changed, 89 insertions(+), 93 deletions(-)

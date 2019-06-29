Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE65A80D
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2019 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF2BjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 21:39:17 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:49985
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfF2BjR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 21:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alZ9YNrNxF+GTQijBWfhISs8KyD1ZAWQadgWRZIGwt4=;
 b=MLe+tsTTpwhEmF1WaZ391j6wyR+xZQVR7mDGdG72t+biRn2/sJ6tLxAyN4tQazIvmjBhZNdb+dIV5Iuojh0RkAwWkLw8SGsNaKrRMmalncKub/iQpZaenKCT+V/eYR8hnWSDxglg6OsBf29N9d9hviezv2YnYKAbImrfi9vsSwE=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5706.eurprd05.prod.outlook.com (20.178.105.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Sat, 29 Jun 2019 01:39:13 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec%4]) with mapi id 15.20.2008.017; Sat, 29 Jun 2019
 01:39:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 0/9] IB/hfi1: hfi updates for 5.3
Thread-Topic: [PATCH for-next v2 0/9] IB/hfi1: hfi updates for 5.3
Thread-Index: AQHVLht0c+RXaH7M+Umfwe43+bxsPQ==
Date:   Sat, 29 Jun 2019 01:39:13 +0000
Message-ID: <20190629013905.GA26040@mellanox.com>
References: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::21) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [207.164.2.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56c1fad3-0885-460b-9f1a-08d6fc3296d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5706;
x-ms-traffictypediagnostic: DB7PR05MB5706:
x-microsoft-antispam-prvs: <DB7PR05MB5706EC24B6E125C05631A8DACFFF0@DB7PR05MB5706.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0083A7F08A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(25786009)(68736007)(478600001)(2616005)(86362001)(66946007)(73956011)(486006)(6916009)(4326008)(6486002)(76176011)(14454004)(476003)(52116002)(256004)(71190400001)(81156014)(6246003)(66066001)(53936002)(386003)(5660300002)(102836004)(99286004)(6506007)(36756003)(1076003)(186003)(4744005)(6116002)(3846002)(64756008)(66446008)(66476007)(66556008)(71200400001)(26005)(11346002)(6436002)(7736002)(305945005)(15650500001)(229853002)(446003)(6512007)(54906003)(33656002)(8676002)(316002)(8936002)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5706;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CnBTkV1S3ZaMvu73tyiSiEIbck9QM9H+cSrPr0RYpPgWEtVUDnAUNE+Ib3kVZZm83g9ceTH1ySIXRMCSMCP/5jUJNap61AUOMRSvqn4gDgm+Nr4XB6/voSgvkxi059yqVAoK9pswuwKhS1DO5Mszo8tZtnVHMyCQkPg75v7DadyFaYNFz1B0kCBzI6i1IuJ6tGh2tkd9xNCTy4svHE4KUMPwDj/banMWdLA14qD96d7szffKY/2nGqRagEf7MvUBY6FDk6pO23xX/WOlrNCrLi+3ymu63VX4thLgUZI+Z6A5oeDkezuJWTIFwhzLWpFcC1Jrpki8Wb/avRT4kVO7BqkgmkDmJ0JoczalVJ1SjCMKKtEwv5A2iKGOtPbBaQqPvH1yHRix2lWhigb/tJICshu8dAKgibCdNAH2ENr86IQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <452412228FDBCD4C84278815AFDB03C0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c1fad3-0885-460b-9f1a-08d6fc3296d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2019 01:39:13.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5706
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 02:21:46PM -0400, Dennis Dalessandro wrote:
> This is the first round of fixes and updates for 5.3. There are some bugs=
 but
> nothing that really warranted making its way to RC. So this can all go to
> next. Of note there is a patch for a fix Jason requested.
>=20
> Rebased to apply on top of other series sent for CQ stuff.
>=20
>=20
> Dennis Dalessandro (1):
>       IB/hfi1: No need to use try_module_get for debugfs
>=20
> Kamenee Arumugam (1):
>       IB/{hfi1,qib,rdmavt}: Put qp in error state when cq is full
>=20
> Michael J. Ruhl (4):
>       IB/rdmavt: Set QP allowed opcodes after QP allocation
>       IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs
>       IB/{rdmavt, hfi1, qib}: Add helpers to hide SWQE WR details
>       IB/hfi1: Reduce excessive aspm inlines
>=20
> Mike Marciniszyn (3):
>       IB/hfi1: Add missing INVALIDATE opcodes for trace
>       IB/rdmavt: Enhance trace information for FRWR debug
>       IB/rdmavt: Add trace for map_mr_sg

Applied to for-next, thanks

Jason

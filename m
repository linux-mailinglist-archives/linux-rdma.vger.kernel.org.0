Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3046240C6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfETTBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 15:01:24 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:14910
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfETTBX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 15:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkUTnEOTPgdjlEFvoCyRAIWUQUjTUOT5j6S6S966CGw=;
 b=kqd21rWhlUhzUsgIuSLOZVMPaBDWy+e86fOJhBtiQzmqQC0QR9VbawPtu1AG76qW13EswsWzuUC0SCGf6COpBNTZvcVEoh1dFVYOTk4UNtL358t9YqcyxpCkW0NZta34yMi5MdIYk8k1b8sRMhux6UYRRG5fhVviwtD5GrxH6GY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4736.eurprd05.prod.outlook.com (20.176.4.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 19:01:20 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 19:01:20 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Topic: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Index: AQHVDtjuQBBHO2HSKkGy9VmU4u8onqZz9GwAgABqroA=
Date:   Mon, 20 May 2019 19:01:20 +0000
Message-ID: <20190520190115.GC26206@mellanox.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
In-Reply-To: <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0018.prod.exchangelabs.com
 (2603:10b6:207:18::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f716c374-1816-4131-779c-08d6dd558b24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4736;
x-ms-traffictypediagnostic: VI1PR05MB4736:
x-microsoft-antispam-prvs: <VI1PR05MB4736F1D0673678126E7734D7CF060@VI1PR05MB4736.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(51914003)(189003)(199004)(36756003)(52116002)(66946007)(66446008)(66476007)(71200400001)(64756008)(102836004)(66556008)(486006)(76176011)(71190400001)(81166006)(8936002)(73956011)(8676002)(2616005)(476003)(3846002)(81156014)(6116002)(54906003)(7736002)(6506007)(53546011)(386003)(26005)(99286004)(186003)(256004)(6436002)(6512007)(68736007)(86362001)(229853002)(6246003)(305945005)(1076003)(2906002)(53936002)(6486002)(66066001)(33656002)(25786009)(6916009)(316002)(4326008)(5660300002)(478600001)(446003)(14454004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4736;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FCfYY3rc944kAiS/JptZCBUsINASZ+DOVBptfu2cdvOJZpAAqDr1wDwOpxaCgX5aoauiUTVgzJJYFAYT6O2YMdVp8X+5nKhE4BvSu2HMmGextF2TyqckROSfHGcIklOqR/c5RAyjBTULQn3V8PzvHFfeGfu2E480KGNFgS2FXUV64qeLmLlG7bTzNSlNfwYnF+YP9KJd+o+XDQw8PCawlY09YLoB06mu8fU0Unv8ryxXRzNh25bNxTkPhiQ4RCpEOWz1UTqVjeu9jF2Z15kpowLqoru2vvg1YFMHy5v5UeegU50ilIz/HwJzWZhepqlnYkgbzDZleRw+ta5I9kqugJBLA1MnCOwe1TeOp0pAof9Q/4rnMlnMlmZEYtuzCP8fD4R8cTrbgJK1ud4bY+rrTFIhfc79Eei0zyDbL9g3JfM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADB9238D7C3F2A42B2B3883EB3BF4D79@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f716c374-1816-4131-779c-08d6dd558b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 19:01:20.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4736
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 03:39:26PM +0300, Gal Pressman wrote:
> On 20/05/2019 9:54, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >=20
> > There are two possible execution contexts of destroy flows in EFA.
> > One is normal flow where user explicitly asked for object release
> > and another error unwinding.
> >=20
> > In normal scenario, RDMA/core will ensure that udata is supplied
> > according to KABI contract, for now it means no udata at all.
> >=20
> > In unwind flow, the EFA driver will receive uncleared udata from
> > numerous *_create_*() calls, but won't release those resources
> > due to extra checks.
>=20
> Thanks for the fix Leon, a few questions:
>=20
> Some of the unwind flows pass NULL udata and others an uncleared udata (i=
s it
> really uncleared or is it actually the create udata?), what are we consid=
ering
> as the expected behavior? Isn't passing an uncleared udata the bug here?

Passing a NULL udata to destroy a user object would be a core code
bug.

But, I thought we fixed the error case flows that were sending in
uninited udata already? It is not null, but it is initialized and
'empty'

Jason

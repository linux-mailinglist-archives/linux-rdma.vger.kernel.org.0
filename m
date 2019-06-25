Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576815561E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfFYRl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 13:41:28 -0400
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:57469
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730462AbfFYRl2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 13:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8AUJJvPeQUQP52DYM9meO4F4tYEaaW9hSaAIbu1Mog=;
 b=e1bkBGCf4CtWzCZrP1+Dj0eKLAuu0z+N3PnJXU2BPXRTLmTA2FEL/JQC2qGIttqeYQ6mIHBcZGoPLh7NHplHeTtJEWY3g5Vpt55fuGjfSy6G4hOYq/grbGe6m5EM7DxsaqwjyNsIZ/MBrTwc7gqHPxHBkvWvbguacMerid/G26Q=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4223.eurprd05.prod.outlook.com (52.133.12.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 17:41:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 17:41:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 0/9] IB/hfi1: Updates for 5.3
Thread-Topic: [PATCH for-next 0/9] IB/hfi1: Updates for 5.3
Thread-Index: AQHVK301s41RsFiw+0W9eD0iHZdcEg==
Date:   Tue, 25 Jun 2019 17:41:24 +0000
Message-ID: <20190625174121.GA22995@mellanox.com>
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:15::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83d5c3a2-88d5-4d1e-3e78-08d6f99457de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4223;
x-ms-traffictypediagnostic: VI1PR05MB4223:
x-microsoft-antispam-prvs: <VI1PR05MB422399F31FDB6DF673457554CFE30@VI1PR05MB4223.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(102836004)(71200400001)(36756003)(6916009)(1076003)(71190400001)(81166006)(186003)(81156014)(6506007)(8936002)(229853002)(26005)(6436002)(52116002)(66066001)(76176011)(86362001)(33656002)(15650500001)(11346002)(446003)(4326008)(3846002)(6116002)(486006)(14454004)(256004)(476003)(6486002)(8676002)(386003)(4744005)(6246003)(99286004)(2616005)(54906003)(7736002)(25786009)(68736007)(66946007)(73956011)(66446008)(66476007)(66556008)(53936002)(478600001)(64756008)(6512007)(5660300002)(316002)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4223;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nGzJX1NbyPmXxDSEn5UqJ5Kn7ME6IHm8JA0HTovffVgmdwtzkoC7nn3yKtRS2tDG9To5Vs1clQN+08KtOda1ZbWTJCQR/iGSaw+0T/c8DiArl115mhfZ01OmqsYdudfA+n5lLUhiuLmGAbusZT9h3NSpcgI2/p166QZUt589ZGmHiMdpoq2Yh5v7CfeHHl9u8fcodyJldtYf21QqLUq8gJKrVn/BgerexL8vLZKj0WR7wtrem71pPAGh/QtK0fwmy/wubXFu9SrZ/pAkdf40TDjUgL/VplRxO+j5cAOsf06syv6QVfNVN/ARETst0MDX+Yz92Tu6QN3O5XLjBNn5TRkGJlojTfwQR0UPxoN3iwx9pYcbG3JdMRrTuOyTMqBtiDhA5gjw1/QBJWbCPzGdnBJHpLmVDkfTQCFWkXZy4Us=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADD134265E2AF44C943AC2BC832B525F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d5c3a2-88d5-4d1e-3e78-08d6f99457de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 17:41:24.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 12:27:56PM -0400, Dennis Dalessandro wrote:
> This is the first round of fixes and updates for 5.3. There are some bugs=
 but
> nothing that really warranted making its way to RC. So this can all go to
> next. Of note there is a patch for a fix Jason requested.
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

This also has rebasing problems, please sent it on top of the prior
series, which is on top of for-testing.

Thanks,
Jason

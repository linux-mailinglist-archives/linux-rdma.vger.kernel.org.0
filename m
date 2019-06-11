Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A033CA5C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbfFKLtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 07:49:31 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:57924
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389938AbfFKLtb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 07:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lewkSU9LFhZLxzOmKshS3k5ZJ0pLErJk/QoNhiisvJQ=;
 b=OBeRFEDTNbeaXA+fc7oOV3PyczlFSewsDCl2lSL72t9jLLMdm7xHrm/08x0xysSHNGoxRG5toTD7IUw5lo5NFi6B0yYTWvgeap1cMOVTEknqbbNj7YakaalNF7cK2xNbhqe1lvQbMM1+WfBiyunFR+Pzbp9iMyFRxdPO5ry4Ozs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4431.eurprd05.prod.outlook.com (52.133.13.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Tue, 11 Jun 2019 11:49:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 11:49:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v4 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Topic: [PATCH v4 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Index: AQHVHE9dGVBySl0utkK8dObZD1pJ+aaRcMUAgAS704CAADIsgA==
Date:   Tue, 11 Jun 2019 11:49:27 +0000
Message-ID: <20190611114915.GA25673@mellanox.com>
References: <20190606100511.4489-1-yuval.shaia@oracle.com>
 <20190608083224.GS5261@mtr-leonro.mtl.com> <20190611084941.GA3499@lap1>
In-Reply-To: <20190611084941.GA3499@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d91f4d3-4d63-442a-ba83-08d6ee62dae6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4431;
x-ms-traffictypediagnostic: VI1PR05MB4431:
x-microsoft-antispam-prvs: <VI1PR05MB44316EEEFC4A82D4DE685E7BCFED0@VI1PR05MB4431.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:108;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(476003)(66446008)(11346002)(66556008)(99286004)(64756008)(6436002)(66946007)(446003)(86362001)(14454004)(54906003)(33656002)(66476007)(68736007)(486006)(73956011)(386003)(2906002)(76176011)(6506007)(7736002)(478600001)(3846002)(305945005)(52116002)(6116002)(2616005)(4326008)(6916009)(25786009)(36756003)(81166006)(102836004)(66066001)(8676002)(186003)(5660300002)(81156014)(4744005)(26005)(1076003)(6512007)(71200400001)(71190400001)(8936002)(256004)(53936002)(6486002)(316002)(229853002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4431;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9HFX7D5yfjHMPLyxhn1UsflDnfvMbQpNQH5jmZyUWJVUVPuY61hYnCS1/yz5S0+YXX3zlIimP5/0yieilMsw5tEolaeRuNBSQXUbF3XKI1fxAUa+BLmS3ZzLJXmjAodOFMz8HSSY5v1qTIMe6g2iGe61oATO9Z1vlIE9Wjh48WjPYzdTPSCuka0pgNNw182Ilpd9LqO2CAsZVTLqqcLfHDMg4gQSfIOeYDfSGxa4VlOQxC9TcrL6Pq2IBjT11Fv9/kgka/5/LNVYTNf8t6nTz75HhNbTvT2ZPQf6zzAJNNiZuQGaMRPYtGjAv9lbdeJNa5Iq05WMeXLoxg1Dcqdt//3h191ZYau96SFt2PxuTAj+jORkaB2tiwlO7r6ta+YX2EjKEwzcMd0E+d6T+HMmnQhlJ+lq3ihxQxFIlBIaRUc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDD1DB3327867E49B08F57DE8313970E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d91f4d3-4d63-442a-ba83-08d6ee62dae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 11:49:27.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4431
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 11:49:41AM +0300, Yuval Shaia wrote:

> > You need to bump PABI in main CmakeList.txt file, otherwise "old
> > providers" won't work with new libibverbs.
>=20
> The P stands for "Private" (asking so i'll know to look carefully at
> section "Private symbols in libibverbs").
>
> Just bump 22 to 23?
> How about PACKAGE_VERSION? nothing there?

Both should become set to 25

> Shall i take commit 75c65bbca as an example?

Seems OK

Jason

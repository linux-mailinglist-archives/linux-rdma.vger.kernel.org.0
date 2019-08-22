Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7E999CE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHVRDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 13:03:22 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:26190
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730824AbfHVRDW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 13:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky0LUGz3+xjC0UQ5zWndDsODeIrNiMDQUt/swj3hil8wpjcgD2es+dFwRAIrqt5POtQpLVIOXzNelkhsJ3ZdQR5Va2Sh7pZrcReNiwaJNO8Uz2TA9mdLg+BbkbUH414QTSXtJBDgCdMpDyi4AhwtL8VDh+iskaJNJcdrjjS9RHnhN2BiV2YIaqCiTUHW6Bi/bSta5xldxK19XRw6eJGZygY8fokxkhVrYk6ZbrrWYZ910yBrOxDT4SCATjJhWoexrOwaoA6Nj6ICU4eMCNWzSkcYDjHgQQ6gvyomRT2GhyLaAMLMxlyMcLzbqrTXLkwxSdIgOCzOZ7lV1J6f4p8zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fJykrPowo1FYt0oKU414SjNrZ5lQmq9WE8IlmNA2uo=;
 b=ORXGp8yKZTcQuO55Rva+U4ySUdpQO44IYEUfV7OFLn6SbIiBs3exyi7Y2Y4DEo00ug9AdFk9AbJEb51P8IsPOHRY/CGOxTFWg0lb+4Gz9+NkpCWrHiXWhdFVYr4Df93XqXIcGhPDuWiodt++nQpjr9TnZRwYuH3rECJJz31FOGAV+UFvSTrFe1w5xjhz1BLCMY7VCgG2Ehp7Of413pbnZLWkCb6kyB0u6/lz/JhALlSV5oIn7uEERARbTyMezhQdSS6yFuHTocX+Nn4MTEJ5Nq3CAdiXSaRvPuLPq5H6soqXC0fFd++9N+5wpXUZp27fTw8Np/BsZURyDHsAGpJvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fJykrPowo1FYt0oKU414SjNrZ5lQmq9WE8IlmNA2uo=;
 b=DRM9q8pdxQ/ECDin5AMMZExkr8/WyjzOVWqBivn/u9lFUVzEHNQKXdQJLQTrdkGAfYlDRBqWm+l/8ArcUldWB4XN8gohCHchaLL/CLN1bvEYO8HmHu3q8jdXn3HXZQvNIyOvx9K5NbUvpAFmFwr2W18Lt7AOObSd+0Tv5g1g5TA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4144.eurprd05.prod.outlook.com (10.171.182.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 17:03:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:03:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Yuval Shaia <yuval.shaia@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvPpKVLbk/iqEuq+9fKELazmacGQnyAgACX1YCAAIsLAIAAAT6A
Date:   Thu, 22 Aug 2019 17:03:15 +0000
Message-ID: <20190822170309.GC8325@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
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
x-ms-office365-filtering-correlation-id: 098f482d-5902-4b11-3b9f-08d727229f0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4144;
x-ms-traffictypediagnostic: VI1PR05MB4144:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4144ACB9750404BF9870C350CFA50@VI1PR05MB4144.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(6246003)(2616005)(4326008)(66446008)(25786009)(316002)(229853002)(71200400001)(14444005)(256004)(53936002)(66066001)(36756003)(6506007)(386003)(66476007)(86362001)(66946007)(66556008)(54906003)(81166006)(7416002)(1076003)(14454004)(8936002)(26005)(478600001)(5660300002)(52116002)(99286004)(64756008)(102836004)(186003)(6916009)(71190400001)(6116002)(3846002)(6436002)(6512007)(6486002)(2906002)(76176011)(8676002)(486006)(81156014)(305945005)(7736002)(33656002)(446003)(11346002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4144;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tLNoNu5Ehk5l0J3VekKwwfnaXKXFsnTlIs7VRzhEihZCTwZt77fw+GzLDeAePzN0ctYSQbB8q3h67onv3g9/YgT8fE64Vrbg6PaPkwmOnzKtgAoTmOBHu4jEzY5ZRW62V0bXH0xplDHa1wL9nEaUxUO2cfxDaDyUda7YYWbVag4yGywK2cYBPXzczJ1n1a0fcBjEd1HwvMRCcyPN3BLklAYJLxzbLAcgPCkT2LOBd25Km+ggvMwh4AUbGkQRzO7pnAmmT+H/SXp6xpmndQcUpfx/ephUDUdcEvPhf8WhwQuJLdZQxHiNRR8DV9Lm+P0bTeTlJrkpu/kBQPN3FAGne5Nukwk8qxRn61lGtythUBfE3BzzBX6ntSRE4SGfqZqnNeMUPBdOPTPap/GW5Nd9mGe8AwzH4efZ9EUEhh1VQXk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1D7D11398C2A142A8976F122884F2F4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f482d-5902-4b11-3b9f-08d727229f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:03:15.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Of/ehsXRhzxq1lYXS9zBM+zUICZI8B/hxxmsXdVY6MXAqXYQVS0Klz90mwZGwhp3j2ilO3egcVf9xkQQyXn1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4144
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:

> Add to your list "how does destruction of a MR in 1 process get communica=
ted to
> the other?"  Does the 2nd process just get failed WR's?

IHMO a object that has been shared can no longer be asynchronously
destroyed. That is the whole point. A lkey/rkey # alone is inherently
unsafe without also holding a refcount on the MR.

> I have some of the same concerns as Doug WRT memory sharing.  FWIW I'm no=
t sure
> that what SCM_RIGHTS is doing is safe or correct.
>=20
> For that work I'm really starting to think SCM_RIGHTS transfers should be
> blocked. =20

That isn't possible, SCM_RIGHTS is just some special case, fork(),
exec(), etc all cause the same situation. Any solution that blocks
those is a total non-starter.

> It just seems wrong that Process B gets references to Process A's
> mm_struct and holds the memory Process A allocated. =20

Except for ODP, a MR doesn't reference the mm_struct. It references
the pages. It is not unlike a memfd.

Jason

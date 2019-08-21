Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0619897D95
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHUOu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:50:29 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:3739
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729179AbfHUOu2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 10:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTp9Py/X1Jfa0SnuqkNiuo6/aeCAVBZqCa4CpfwcT0LEEknQVG98GwtfcojXwJhl+9Ywv1yZcdACnNpCYxyKJAOTY6TvgS2I6p9J2TXyCGcgM84kLdu2E3QrfHy3JjclBUPfd0XXH+FzoGbon7q5vlm2dG+bmM4BQRqZs9rx8y16IVPJ36t9Vzft/QtU6Zk8JMjjOGi62op+Indxv+9E1RUO6Eh+zF4S6p3D/M9DZacxwB8BG8v+wWJv/r8t8uddsrdOgavMy9RoT7bSXIYJtofFxZBSkLaRIc9EpnteaynetuAeM9VBWaaoCvM1gujClz/0JvxVm6LgYZ82Qb1g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYdu/XsD4btSYO4TcXnnvunFZ4S7TnkWYDiwnefGn1Q=;
 b=aKIdtaiT/dmh3jVjx6cNHqozqL0Lf4kLd3l3dJYQv0FFPuS1dJDNxasrQNvY9zfk9ZzEzspATrZEifNdmLp+aOIHWjIl83QYeUpW5zBv7TpPd/SkOKXxVWbUbQsCO9TkUf5BiwmsBs096ih2gY5M6BEvhCoF1kvXJXSYjoN5PvJNUHuHTVaHRlqINs29zswBeoHr646JrWM67HeXzNkgQft/PGgEXWTTyO7gTgYxCbg0D9oUUr627MEQF32FceUmGwXFzxKFKk8tWfzSJj0cLQ4XpgjbBMdv9HdzjSe/XzoPd0U/ntFhAnLxwP0VbtUl8u5mEWNvMou0y4/Dakj67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYdu/XsD4btSYO4TcXnnvunFZ4S7TnkWYDiwnefGn1Q=;
 b=Qz7o8mUZ3hI3JN/N2Uj+4OoDB97pQOqVXEdCJO68luomVMZUuCEf7Oi4RP5Le+O+1SmDIt7qc89eGUXYae/Ob8C+cJmEIRyGShJw3HTlhW0TyVPCPMpZ3bOWK42APpi4un6OAGLIPeyT3dksCT4+LXpa+F51d22Xqo8CXQ0qrPQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6030.eurprd05.prod.outlook.com (20.178.127.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 14:50:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:50:17 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
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
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Thread-Topic: [PATCH v1 00/24] Shared PD and MR
Thread-Index: AQHVWCvPpKVLbk/iqEuq+9fKELazmacFrx+A
Date:   Wed, 21 Aug 2019 14:50:16 +0000
Message-ID: <20190821145011.GA8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df4d6c12-beab-4e92-43fe-08d72646e176
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6030;
x-ms-traffictypediagnostic: VI1PR05MB6030:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6030F0F325714771D4BD7F83CFAA0@VI1PR05MB6030.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(66066001)(256004)(446003)(26005)(11346002)(8676002)(81156014)(99286004)(54906003)(81166006)(478600001)(36756003)(4744005)(25786009)(7416002)(186003)(2906002)(86362001)(486006)(476003)(2616005)(3846002)(6116002)(14454004)(386003)(8936002)(316002)(71190400001)(71200400001)(102836004)(52116002)(6506007)(76176011)(229853002)(33656002)(6436002)(64756008)(66446008)(6512007)(66946007)(66476007)(6486002)(5660300002)(7736002)(4326008)(1076003)(305945005)(66556008)(6916009)(53936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6030;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ErvChx4eHLoNs9Gx7H9Iaa/VVJvm8M/LwHKr/4ryiUlj502rq14Lq6UI9inrFzkuiIq9L4Qg8Kn4PJZ2ar1kdlZnKS8VUUGbTJKnHN2tdM+k3PbZPKtzEQNNkLUi7NZYxpcv2ExSiuqPfPDAZKwhDuuhYyJ5lmzvHfe7MJnbdtRphR2pSdPE9/kRH9YAKRCpiZ73GZvrlwR0JaU/l2yKOVgqB4wNx7Mddv+9NlGeAJaAMpCM4nDjklWKbKSu+ALuxzK5ytDC4Y/PtXX8RGDnGHZy6Vzn4px3WrEQ4KtMZpiR+VHdapYg0M8cFi9dcsKEQbnCGqqix6mNu5g+bFwIfdFO2zXIVD08jThmpX+nhWfbbFt0jvHD8rNozgnk0e5BaYyKVQJvH9Kps1xdSJc7Bln4Xid0FBqgQvKrDFhevv4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68AA71698F12614791F0DC6463C61B05@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4d6c12-beab-4e92-43fe-08d72646e176
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:50:16.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/gyFBRL/GtqoIxtmFMUV9cCBaRgJn9utyRFlJqivSHg+LBwXstdLzBYvrnSlzDgTBAkz+c8e0b56qaBB/37+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6030
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> Following patch-set introduce the shared object feature.
>=20
> A shared object feature allows one process to create HW objects (currentl=
y
> PD and MR) so that a second process can import.
>=20
> Patch-set is logically splits to 4 parts as the following:
> - patches 1 to 7 and 18 are preparation steps.
> - patches 8 to 14 are the implementation of import PD
> - patches 15 to 17 are the implementation of the verb
> - patches 19 to 24 are the implementation of import MR

This is way too big. 10-14 patches at most in a series.

Jason

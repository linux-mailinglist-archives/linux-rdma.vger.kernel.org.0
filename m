Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA9E9A9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfD2SC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 14:02:26 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:2238
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbfD2SC0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 14:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpKDsDvkhHLRhFcfCsWZ07IbSqbjG65Q1S70Zs6tTC0=;
 b=I6AvZxC3QqzpCoE6nhsg0opVxuHYprPKAmPL52QmedKgs03UR9g3XQ8/EgIiCullYExUk95TOPmixMiDaJVLp8sE2ktI/B/65lgo06wnU7wbEqKLUlkji7DGBELei8ewG1EOxvoN8CoRreZdaDngVZFhCK/+8LotU10U79P+kjA=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3156.eurprd05.prod.outlook.com (10.171.186.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 18:02:23 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::edfd:88b8:1f9e:d5b1]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::edfd:88b8:1f9e:d5b1%7]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 18:02:23 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 0/4] pyverbs: General improvements
Thread-Topic: [PATCH rdma-core 0/4] pyverbs: General improvements
Thread-Index: AQHU/qP1KI3LYUD3ukal+CdjTFRXm6ZTbheA
Date:   Mon, 29 Apr 2019 18:02:22 +0000
Message-ID: <20190429180219.GY6705@mtr-leonro.mtl.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
In-Reply-To: <20190429155513.30543-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::30) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e0149d2-3387-40c6-5f86-08d6ccccd43d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3156;
x-ms-traffictypediagnostic: AM4PR05MB3156:
x-microsoft-antispam-prvs: <AM4PR05MB31560FA1275FB710E1102AB9B0390@AM4PR05MB3156.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(81166006)(81156014)(478600001)(8936002)(6486002)(2906002)(68736007)(229853002)(97736004)(33656002)(66066001)(6116002)(14454004)(3846002)(5660300002)(8676002)(6436002)(71200400001)(7736002)(486006)(71190400001)(25786009)(305945005)(1076003)(11346002)(446003)(54906003)(476003)(6636002)(52116002)(64756008)(66556008)(66476007)(76176011)(66946007)(66446008)(6246003)(256004)(4326008)(6862004)(6512007)(9686003)(53936002)(99286004)(186003)(4744005)(6506007)(86362001)(316002)(386003)(26005)(102836004)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3156;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p+8alO8j/BAjjOEB+FgGf4l8Vx/O9XH0QhiaDES2Rj+VI+bmoN1/ugYsGhVVObHabphwRY18HiTXZjSfzI5p9uPHMsaBW8OphXxjkh1+kJjfImzwUTJNjHxDpkXpa9D5KaM3XI7KezWP2T59GbIsfvRoE1Q6xPIeegmjqKxLVxNaslnH0j3z0XfVgyCtqnaG6uC8j1o3QaqAuVFWSdn+8Pq9jcl1Br4I/q3NWZ8RKansZV8Aj/Y0Hki/j3aYFiU2z5Fg2kHzp3+rjmkKfcRWC5DKJhw2puQaW0KJveb7VDBMLLLaRhCptaN4OtwSpTFzpnPYMYne0djfCtZFWZbEU48chx/2UnsLZLGtjeIlo1M2igBw166GiwhzXI6UHQplsYoMh84sFrJNTeYYDF1HbLSfUPbFckMwoLizXZPrGVs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A82A5425C461694380BA3FB9CA0475C1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0149d2-3387-40c6-5f86-08d6ccccd43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 18:02:22.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3156
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 06:55:09PM +0300, Noa Osherovich wrote:
> This series precedes pyverbs' traffic series with some needed changes:
> - Some enums were missing.
> - Modify some of the user-visible prints for a more readable output
>   as well as to avoid an exception thrown when printing an
>   uninitialized object.
> - Tests: Coverage and performance improvements.
> - Add events support.
>
> Noa Osherovich (4):
>   pyverbs: Add missing enums
>   pyverbs: Changes to print-related functions
>   pyverbs/tests: Improvements
>   pyverbs: Add events support
>

Noa,

Please remove Change-ID trash from your commit messages and refrain from
using power point style in commit messages.

Thanks

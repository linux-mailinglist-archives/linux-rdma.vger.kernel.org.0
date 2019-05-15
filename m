Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AA1F746
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEOPSC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 11:18:02 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:3590
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbfEOPSC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 11:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZDmOSNM5WsiOKVCjqP0SZrjYvgaR9UsFSvBzSB/aKI=;
 b=lh4uoZTU+tkIWlft0RLy8c+hcyzhU4pjopGETenNm+i+3I43nPfUVkuJHqDUnu2kHhVGC8EGZ1FcNoMQPcQQJqyowCPm+kI+B12mvK0x2qX30oOQh0AYkM35QW2sTH6ZfplG0S0J2fCKHIi2ASZsAONBDCSqEhtzxLdWSJSFOzc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3200.eurprd05.prod.outlook.com (10.170.237.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Wed, 15 May 2019 15:17:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 15:17:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 2/5] cbuild: Remove ubuntu trusty
Thread-Topic: [PATCH rdma-core 2/5] cbuild: Remove ubuntu trusty
Thread-Index: AQHVCq0HzPd95r3q/UCs/KJ3Kw6836Zrp8WAgAClnIA=
Date:   Wed, 15 May 2019 15:17:58 +0000
Message-ID: <20190515151753.GJ30771@mellanox.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-3-jgg@ziepe.ca>
 <20190515052509.GE5225@mtr-leonro.mtl.com>
In-Reply-To: <20190515052509.GE5225@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae0e803-5a2f-4d7b-7342-08d6d9488323
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3200;
x-ms-traffictypediagnostic: VI1PR05MB3200:
x-microsoft-antispam-prvs: <VI1PR05MB3200B4AB79BCEF96AD16C524CF090@VI1PR05MB3200.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(68736007)(6486002)(186003)(36756003)(81156014)(33656002)(8676002)(7736002)(305945005)(6512007)(8936002)(229853002)(6436002)(81166006)(66946007)(66476007)(53936002)(66556008)(64756008)(66446008)(26005)(25786009)(6246003)(4326008)(73956011)(71200400001)(86362001)(66066001)(316002)(3846002)(6116002)(5660300002)(52116002)(476003)(6506007)(386003)(1076003)(14454004)(2616005)(6916009)(71190400001)(11346002)(508600001)(486006)(4744005)(102836004)(256004)(2906002)(99286004)(76176011)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3200;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFH1P6JMyupmmkhRZrL3bjlhlIulR7XdKxnVPGPAhLDsUUJwtpu+ycjxYq5aVOMSfVWNZX5k7nHWlXdlCV4B+zkCIW61p95i2TNszWa71t3PVRVfm/kPtwvgVmOiFV16njt0FenqFRhIQzMosdRSJNBHgnkrJ0wS4/XRaeunvzUCCqnzyPCshCucqYh8VDdKEX6fUa7RuP5Yj5F8kTFKweYVcKuXaVHrlEHKoiGGPsl0QGIhDHRFc8/E2rFiVc/whANpJUqAdrdt+vH//B8PTpUzusa4/QK3qnbGuV8DdS2SdiWi5rN4HW1xbB/cwYLOrQIbzyA1szGfiguO8GaSrrqNo0Dpi+mrGIz2/g6ICHI39xWUzuEZo/Pt8Ag1d1u+p09hzJ4aISRspc7FlPF1/Hy9OMb1Y3Nb/L9NxWky43A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1DF3F77A68613409F1983E713AB6641@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae0e803-5a2f-4d7b-7342-08d6d9488323
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 15:17:58.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3200
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:25:09AM +0300, Leon Romanovsky wrote:
> On Tue, May 14, 2019 at 08:30:25PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > We only support 2 LTSs at any given time, xenial and bionic are the one=
s
> > for Ubuntu. cythond oesn't work on xenial so remove it frmo the package
> > list as well.
>=20
> "cythond oesn't" -> "cython doesn't"
> "frmo" -> "from"

done

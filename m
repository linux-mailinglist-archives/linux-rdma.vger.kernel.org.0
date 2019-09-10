Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE27AE5BC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfIJIkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 04:40:41 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:29658
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfIJIkl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Sep 2019 04:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvB+NSgcPJ88BkjVU05pCryNFLcaZ8KcRUj65Bzn5K9jLMxvAn6eYDik9HJjgMkdclvj92Te4lxyLSWDzcFuBV7BvFca+6mT+XwyOsDGGTt4UzjWz3Pz4BgSL7yfkC1YkSb8OC54A9OwmLgKwWSQeWnC965/29DD2/MHmZQNdvOue3uv9cFQQ/dTk7IdGtDwQfCKtX+4r3RR0mdU3lsP/n99RSvL1pa+U8REp4u2+ejXhhfEFp4GgzEOY7iQx7vr4GhXLR1jK/XzelDH3YLzGMBd+xKju2IjSPBIozSRT9Qb/5fdljptHLwUixBqK1LK2enP0wbSRT5y8/sZj20TWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1QQ9djeLKJ6XYuuU005tEADhQxNoCFe597rl/FVTwA=;
 b=RH4PhRPTBz12je0bymb4Vi5DvJtL6sADD7LHq3cHcysul6V8vPz5V4+oEf5olwnf/KV/UhhWNLJ340y/ENUHaldxUjF3+RMWR8p/tAwF1cNtDBPKCDBqsChlX6B3FvikgSu/ZFbiZVnT+4AjGniyM0j4q5xrrtIyMzSW9a8MrqPFkdg/dMcfdlx5P3C7uNm6hhXKOiAqr4NOxOXXAro2YmTYSZR5VRd4f8qecZoxvZuR57Ju49ZKCfcUC+f5h9TdkRwUPM0BNHeWKF729Vht5CZIeKQBbAgFTW8hv7n+AanHZl53+5msRNOYFkdG8SzWoEx9kL946YX7ITNR7v6u7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1QQ9djeLKJ6XYuuU005tEADhQxNoCFe597rl/FVTwA=;
 b=j3cSCDADh8FuvTjwr1oqeO7CRHMfJEdRkrMU2yzWAMMjZfqBF1CAOyJC6Ka9+UzTA0QWewS+zKgqSm49nZ68UUncr9DyyKZJdsVxWpaZFMBNHpPLwksa7SSn0uhybzu3AkVkiqjlGek3OkelYYG+LYhWe2CvhC4/8/hU/kK3wmM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5581.eurprd05.prod.outlook.com (20.177.202.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 08:40:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 08:40:37 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: add dummy can_do_mlock() helper
Thread-Topic: [PATCH] mm: add dummy can_do_mlock() helper
Thread-Index: AQHVZ08q5wbucvrEOU+F8Ef7pGgfzKckfwoAgAAZK4A=
Date:   Tue, 10 Sep 2019 08:40:37 +0000
Message-ID: <20190910084035.GB2835@mellanox.com>
References: <20190909204201.931830-1-arnd@arndb.de>
 <20190910071030.GG2063@dhcp22.suse.cz>
In-Reply-To: <20190910071030.GG2063@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::32)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c104742-f0b7-4dc6-5191-08d735ca8d8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5581;
x-ms-traffictypediagnostic: VI1PR05MB5581:
x-microsoft-antispam-prvs: <VI1PR05MB55816868514870A19F39B7E1CFB60@VI1PR05MB5581.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(4326008)(102836004)(14454004)(6916009)(316002)(2906002)(478600001)(6486002)(6116002)(3846002)(7736002)(33656002)(305945005)(6436002)(81156014)(8676002)(229853002)(81166006)(66946007)(66476007)(66556008)(66446008)(36756003)(64756008)(2616005)(6512007)(5660300002)(25786009)(256004)(476003)(486006)(8936002)(66066001)(6246003)(53936002)(71190400001)(1076003)(99286004)(52116002)(71200400001)(76176011)(86362001)(6506007)(386003)(54906003)(4744005)(186003)(26005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5581;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LCm8xoH/HMTZXB9FJb0zmT+VXaZ5Ql18F7IE2Tz3wLhVAhgW/65eTmgJHHnQpY8xK8zJyvUfMlo7QXQN2P7pxWvImDK1Ek2fA+Efqb9Jov3skao1Wxm+mDhUED/Pwv1TOLO+Mycs+32VRw46A+764RJNcxyZd7qFg5WJry9dmkEnVnKlpxlwThU921sM8GgVtdj4IGIV1falRwKfmSG4e/BaVBLaB/pRiJlqJsxjPJyBgwJOJlj+F/AzQmLM4GXYQ+4y1W51HhPjb3a5CSFuT59U/GZhUAy8zqOq/aNAA8crOobjJlzkuIrYvw0aFe1Bkfw/Bihvy3FSPqcPn89MgTPXuzBh6WY3/jnTRlfUWSSko11CwP2NwYuGV5mP8p/ziXquyEjAEGtaf9E/ZiJbaDqxb7PCZ2TwXkYm1W3c1jE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDF1680DB7EDAD4FAB98E70AA6992DE0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c104742-f0b7-4dc6-5191-08d735ca8d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 08:40:37.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABT03u30wSpxo8rJjG7hFdQzUftrOO9vySf8Hho2G5oGSMU6cB64ZB5w4HrZ9CwM4phrKDiXGuC7ziBKp5redQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5581
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 10, 2019 at 09:10:30AM +0200, Michal Hocko wrote:
> On Mon 09-09-19 22:41:40, Arnd Bergmann wrote:
> > On kernels without CONFIG_MMU, we get a link error for the siw
> > driver:
> >=20
> > drivers/infiniband/sw/siw/siw_mem.o: In function `siw_umem_get':
> > siw_mem.c:(.text+0x4c8): undefined reference to `can_do_mlock'
> >=20
> > This is probably not the only driver that needs the function
> > and could otherwise build correctly without CONFIG_MMU, so
> > add a dummy variant that always returns false.
> >=20
> > Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> > Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Makes sense
> Acked-by: Michal Hocko <mhocko@suse.com>
>=20
> but IB on nonMMU? Whut? Is there any HW that actually supports this?
> Just wondering...

I've never heard of anyone doing this configuration, and I don't
really know much about nommu to comment if it could even potentially
work or not..

Jason

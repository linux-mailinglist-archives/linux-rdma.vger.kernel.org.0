Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB534720
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfFDMnV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 08:43:21 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:58750
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbfFDMnV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 08:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EScuZxlsHL3nw6OjKmK7bUXBfGp5zezNs4uHVa40t7M=;
 b=mE/8Jb91VMvcwmPMvojGF4NPqOvodIcCUVIYu25kdUQa2/lJzIeH2L9ai5vPJQ6S6rWLgPf+WVdTFHuSNQdYfT44E18EUNXsD/Z991atZgqwMl3LqnLGxIcy4CAXe+UKOvXcAvSbQQ2nZev2xQ30k5n6KGAc6jynL4G6Z2wUoZA=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.134.107.143) by
 DB7PR05MB4476.eurprd05.prod.outlook.com (52.134.109.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.20; Tue, 4 Jun 2019 12:43:17 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::599c:3c72:e7d9:e688]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::599c:3c72:e7d9:e688%7]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 12:43:17 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
Thread-Topic: [PATCH 03/20] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and
 ib_alloc_mr_integrity API
Thread-Index: AQHVFus23gCZBj65wk2CVXT8nleHhKaLIkIAgAAYgwCAAD2JgA==
Date:   Tue, 4 Jun 2019 12:43:17 +0000
Message-ID: <20190604124313.GC15534@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-4-git-send-email-maxg@mellanox.com>
 <20190604073514.GL15680@lst.de>
 <bcd4fe8a-38df-e302-b12f-4e7a99f9a77b@mellanox.com>
In-Reply-To: <bcd4fe8a-38df-e302-b12f-4e7a99f9a77b@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:18::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b05e8271-5ff2-468b-f728-08d6e8ea37ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB4476;
x-ms-traffictypediagnostic: DB7PR05MB4476:
x-microsoft-antispam-prvs: <DB7PR05MB4476E04F26DFC0C7B4AC7D84CF150@DB7PR05MB4476.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(66066001)(5660300002)(229853002)(26005)(6486002)(6436002)(486006)(36756003)(68736007)(446003)(11346002)(86362001)(71190400001)(2616005)(476003)(71200400001)(33656002)(53936002)(8936002)(99286004)(6506007)(81166006)(256004)(1076003)(52116002)(2906002)(81156014)(54906003)(186003)(107886003)(316002)(4326008)(305945005)(37006003)(6246003)(14454004)(6862004)(508600001)(64756008)(6636002)(7736002)(66476007)(66946007)(66446008)(66556008)(73956011)(386003)(6512007)(102836004)(6116002)(53546011)(25786009)(76176011)(3846002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4476;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Cum/ErTDdRavVzZ8L5AyNKNv9bqmj/oel6N1Aw9nmhDpitPVO3d2FyaAbHQ2Dx0+EUt0UGPv9xOyhNO8m3WWg0ZC9D2I8NiWHhjrlSXJvjaR0rY3ut1Dka0oyrGzi3TtNlncwhLo64DOXQT1UbymX2nSVt2pJPExTw5heHRaBerLBXMMKOZzlUkjV1VBekiQ5DYb3KK2Uttg9a5MGo2OZrbTaAFA5dw0tpCmAC+5PPKUcyUUvJNF2eVNj4GlT3oY04/H+WWWySLG+ugyTVGp8Ydy6flPMWGNTHlyd8PcxuH+1iHr2jsejw7nEVW1yJbueoR7Q83u/8RWPvFO4WGTvLLUt/lznKgvJ4nZ5L8P0bEMo3CLZeSnJM1OH4ygmje8sUF1Ypn/bb60EvFYir9SUHZSl6xUco/RUH0GGa4kbw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B238A75B110A4449B69FE5F6A79DB38@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05e8271-5ff2-468b-f728-08d6e8ea37ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 12:43:17.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4476
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 04, 2019 at 12:02:58PM +0300, Max Gurtovoy wrote:
>=20
> On 6/4/2019 10:35 AM, Christoph Hellwig wrote:
> > On Thu, May 30, 2019 at 04:25:14PM +0300, Max Gurtovoy wrote:
> > > From: Israel Rukshin <israelr@mellanox.com>
> > >=20
> > > This is a preparation for signature verbs API re-design. In the new
> > > design a single MR with IB_MR_TYPE_INTEGRITY type will be used to per=
form
> > > the needed mapping for data integrity operations.
> > >=20
> > > Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Looks good, but thinks like this that are very Linux specific really
> > should be EXPORT_SYMBOL_GPL.
>=20
> Well we used the convention of other exported functions in this .h file.
>=20
> If the maintainers are not against that, we can fix it.
>=20
> Jason/Leon/Doug ?

Since it is in a .c file that is dual licensed I have a hard time
justifying the _GPL prefix.

Although I would agree with CH that it does seem to be very Linux
specific.

Honestly, I've never seen a clear description of when to use one or
the other choice.

Jason

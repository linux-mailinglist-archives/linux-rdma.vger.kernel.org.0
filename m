Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9612191
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBSC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 14:02:29 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:14555
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfEBSC3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 14:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8DiGlcFmR8NDXCutd9hLXwH1NyWe9Uow7EZ5qmYaCk=;
 b=XeRQPYFEzatxlH3BLUZJ7Y0lIvTULwQGkcjQiPaGIpt1esra8HdGACz031jMde76csuWavzpLelxpkkBdP62RN2J46WVN+u/W1vxpk6SmzHg0RGmYUmFc+tQtNlRwn6tE6ozzrqesDp9G2u7WyZi9oPL3jHAeJEseYbcsamt6WE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4448.eurprd05.prod.outlook.com (52.133.13.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 18:02:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 18:02:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVAREut6YhcNgq2U2bxKGl+U/wYQ==
Date:   Thu, 2 May 2019 18:02:23 +0000
Message-ID: <20190502180218.GA27746@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-11-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d365dede-9eb4-4d34-38ef-08d6cf2853ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4448;
x-ms-traffictypediagnostic: VI1PR05MB4448:
x-microsoft-antispam-prvs: <VI1PR05MB4448BBFFD1EB07F4DDEF91F7CF340@VI1PR05MB4448.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(54906003)(256004)(316002)(36756003)(4744005)(68736007)(52116002)(99286004)(76176011)(2906002)(1076003)(86362001)(3846002)(6116002)(14444005)(33656002)(229853002)(6486002)(6506007)(6436002)(386003)(26005)(8676002)(7416002)(71200400001)(4326008)(305945005)(66946007)(7736002)(66476007)(66556008)(66446008)(73956011)(64756008)(486006)(8936002)(102836004)(186003)(2616005)(478600001)(81166006)(446003)(11346002)(81156014)(5660300002)(6246003)(476003)(14454004)(25786009)(6916009)(53936002)(6512007)(71190400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4448;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Noors2NdR3B46l6xJv8Bh8N8ZVPbHLR+nsFw/g496QTwjb9RJzgUIBRg0nRUy55gLQ61Aio8w1wr2oZNVM9wKq97tP5GqNjHEs8xxZoJRfk/a+81pj+CNgo0Ofjk3uhFOwEcnhhMowCQqoY6AJMbqIw4yLOcrUjFefLPuq1lxoDOnuGU7LTZEyskWEGOscicTwLbkery1a30iGojv4uIU0F+zfruiPKURw9721Mf2lfE1KoXhNzv5wtwkGhoyYg1YHCfH/sFcOXmLM1OK5A50iUrrl7w8u3mWe/KKi+5PX8gQ8ZnACtj73ZifTGlctAc2aRqcpjDXP3bLHhTwtqtfszzRvKLKX7aHzHpvk1ZQIfy2opgvGJICdiDoG8wV08XPQ9YmiHaRdYuQkiP7cARng3gTUQYce6Fmd8Kpn4/TKA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC65F75AA1112047A4CBE9138965037F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d365dede-9eb4-4d34-38ef-08d6cf2853ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 18:02:23.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4448
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> +static int mmap_entry_insert(struct efa_dev *dev,
> +			     struct efa_ucontext *ucontext,
> +			     struct efa_mmap_entry *entry,
> +			     u8 mmap_flag)
> +{
> +	u32 mmap_page;
> +	int err;
> +
> +	err =3D xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (err) {
> +		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
> +		return err;
> +	}
> +
> +	entry->key =3D (u64)mmap_page << PAGE_SHIFT;
> +	set_mmap_flag(&entry->key, mmap_flag);

This doesn't look like it is in the right order..  There is no locking
here so the xa_alloc should only be called on a fully intialized entry

And because there is no locking you also can't really have a
mmap_obj_entries_remove..

I think this needs a mutex lock also head across mmap_get to be correct..

Jason

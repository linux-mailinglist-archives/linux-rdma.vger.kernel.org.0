Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647651F028
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfEOLlY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 07:41:24 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:17382
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfEOLlY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 07:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGL/zesZeF4gWt/DGUEKggTHIWiEDye2L2h2aPS1/mo=;
 b=W6lBG2yy8+ISFkde04tuz2aoNmol1TqGd4FdEeDqG27iDg42PbHUrek05Jj96d4RhiroPrwPV7UFb1Q7RlGMPkvbxE5sdQkEugJa6A7h/OaclyfGaNkWt/kfAOaSZUrhZNpidTWpWAODVgm17rZUU0wzRzGp0Azb2s0aeyRNcvk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5550.eurprd05.prod.outlook.com (20.177.201.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 11:41:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:41:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bharat@chelsio.com" <bharat@chelsio.com>
Subject: Re: [PATCH for-next] iw_cxgb4: Fix qpid leak
Thread-Topic: [PATCH for-next] iw_cxgb4: Fix qpid leak
Thread-Index: AQHVCw2NFmxUD1pu6kCWNpUYO1/sFKZsB9MA
Date:   Wed, 15 May 2019 11:41:21 +0000
Message-ID: <20190515111138.GB30771@mellanox.com>
References: <ea84bb959151af439b4a40a029ccf0d7c2323b0f.1557917496.git.nirranjan@chelsio.com>
In-Reply-To: <ea84bb959151af439b4a40a029ccf0d7c2323b0f.1557917496.git.nirranjan@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e11bb5-c7ff-48c0-2354-08d6d92a4027
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5550;
x-ms-traffictypediagnostic: VI1PR05MB5550:
x-microsoft-antispam-prvs: <VI1PR05MB55507CF10ADCBFC5970787A8CF090@VI1PR05MB5550.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(53936002)(6486002)(7736002)(33656002)(14454004)(66446008)(66556008)(446003)(66066001)(2616005)(508600001)(2906002)(486006)(476003)(6512007)(11346002)(66946007)(64756008)(73956011)(66476007)(25786009)(4326008)(305945005)(81156014)(81166006)(6246003)(8936002)(26005)(6116002)(5660300002)(316002)(102836004)(99286004)(386003)(76176011)(6916009)(52116002)(54906003)(36756003)(68736007)(1076003)(8676002)(186003)(229853002)(6436002)(71190400001)(71200400001)(86362001)(3846002)(256004)(14444005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5550;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: buggyhefkCEo6ZpeRgJUyO/KGWLCAQ2x+7bKZnWGSCbLtyuUpvvznCnpriI4k4vsb6jz3R04/w9LsDBjJUHT1nNfxqeMr/Na2Mns3xxDNoAl8MmMrBi4elnP0kX+8CFbE6Y6S/YVg5MqanjDEaN+8lkIDEy3ByEjKO1k0oeWnQltlOVqfw64307lnfjZxqRaYURz3oQEqTsZnzOT29RibIx45nSMWIzipSlXLvxD1qUgrm2GPRi4S8os+PxW7EfEDrzBfyBgVSWNk15DO895+GSq4awDmPbHUsWYgKHqxSMXpswE9MuOQLnq2X4GLmhLSWY0KPKzuxgouu2Bb7IQu3a5qi4BmstmwWtg1KS/zGKWPxHWmjBETxdUQAD8fy8/CZNIvs6j6YawQW8AIII5n5njxHpPTlYPcDyu5jW68nY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <298289C3F2AF1B40BC88A7B4C5B035D3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e11bb5-c7ff-48c0-2354-08d6d92a4027
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:41:21.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5550
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 04:01:13AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, sometimes scheduled freeing of QPs complete after
> completion of dealloc_ucontext(). So in use qpids stored in ucontext
> gets lost, causing qpid leak. Added changes in dealloc_ucontext(),
> to wait until completion of freeing of all QPs.
>=20
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
>  drivers/infiniband/hw/cxgb4/device.c   | 3 +++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 2 ++
>  drivers/infiniband/hw/cxgb4/provider.c | 6 +++++-
>  drivers/infiniband/hw/cxgb4/resource.c | 9 +++++++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw=
/cxgb4/device.c
> index 4c0d925c5ff5..fad4ca247bc7 100644
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -775,6 +775,9 @@ void c4iw_init_dev_ucontext(struct c4iw_rdev *rdev,
>  	INIT_LIST_HEAD(&uctx->qpids);
>  	INIT_LIST_HEAD(&uctx->cqids);
>  	mutex_init(&uctx->lock);
> +	uctx->qid_count =3D 0;
> +	init_completion(&uctx->qid_rel_comp);
> +	complete(&uctx->qid_rel_comp);
>  }
> =20
>  /* Caller takes care of locking if needed */
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/=
hw/cxgb4/iw_cxgb4.h
> index 916ef982172e..768532e29538 100644
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -110,6 +110,8 @@ struct c4iw_dev_ucontext {
>  	struct list_head cqids;
>  	struct mutex lock;
>  	struct kref kref;
> +	struct completion qid_rel_comp;
> +	u32 qid_count;
>  };
> =20
>  enum c4iw_rdev_flags {
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/=
hw/cxgb4/provider.c
> index 74b795642fca..bfd541c55c31 100644
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -64,12 +64,16 @@ static void c4iw_dealloc_ucontext(struct ib_ucontext =
*context)
>  	struct c4iw_dev *rhp;
>  	struct c4iw_mm_entry *mm, *tmp;
> =20
> -	pr_debug("context %p\n", context);
> +	pr_debug("context %p\n", &ucontext->uctx);
>  	rhp =3D to_c4iw_dev(ucontext->ibucontext.device);
> =20
>  	list_for_each_entry_safe(mm, tmp, &ucontext->mmaps, entry)
>  		kfree(mm);
> +
> +	wait_for_completion(&ucontext->uctx.qid_rel_comp);
> +
>  	c4iw_release_dev_ucontext(&rhp->rdev, &ucontext->uctx);
> +	pr_debug("context %p done\n", &ucontext->uctx);
>  }
> =20
>  static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
> diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/=
hw/cxgb4/resource.c
> index 57ed26b3cc21..e9cc06f8a9ad 100644
> +++ b/drivers/infiniband/hw/cxgb4/resource.c
> @@ -224,6 +224,10 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4i=
w_dev_ucontext *uctx)
>  			list_add_tail(&entry->entry, &uctx->cqids);
>  		}
>  	}
> +	if (uctx->qid_count =3D=3D 0)
> +		reinit_completion(&uctx->qid_rel_comp);
> +	uctx->qid_count++;

This looks racy/sketchy. You should use the normal pattern and set
qid_count to 1 then -- & complete it before wait_for_completion

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1272041F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfEPLJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 07:09:55 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:1602
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPLJz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 07:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1FRKk2R/0ZClWTosCjv9kI06TzpkRHKm3kgMvN2N0=;
 b=TPty6dFtzCcVOKbqJQ+xSYiQdbzTnTNxq7JH7uIVSHUQy9yne1pX401CY3GmmZ/fMkxZL1je9XwxtbpRCM3J22h8Cqpvr+Mtg4ZD1P6XnjRnIT8qkrBOcaAWk5NxYED3xKp0dqIBOKFdOC16DjyxnhWspIC/ujE4drC6YzeC/cQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6621.eurprd05.prod.outlook.com (20.178.126.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:09:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:09:38 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bharat@chelsio.com" <bharat@chelsio.com>
Subject: Re: [PATCH for-next v2] iw_cxgb4: Fix qpid leak
Thread-Topic: [PATCH for-next v2] iw_cxgb4: Fix qpid leak
Thread-Index: AQHVC77wBgGywaBEAEm6iD6SpT6V2aZtmC4A
Date:   Thu, 16 May 2019 11:09:38 +0000
Message-ID: <20190516110932.GA22573@mellanox.com>
References: <eb1b5ff6b86ee619fa18247ca70aee81f8846038.1557987454.git.nirranjan@chelsio.com>
In-Reply-To: <eb1b5ff6b86ee619fa18247ca70aee81f8846038.1557987454.git.nirranjan@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60defaa-3e2e-480f-0787-08d6d9eefca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6621;
x-ms-traffictypediagnostic: VI1PR05MB6621:
x-microsoft-antispam-prvs: <VI1PR05MB662146D5D7218A4DDD1F27A3CF0A0@VI1PR05MB6621.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(229853002)(1076003)(6486002)(4326008)(6116002)(8936002)(5660300002)(36756003)(3846002)(7736002)(305945005)(2906002)(53936002)(478600001)(86362001)(81156014)(6246003)(6916009)(8676002)(71200400001)(71190400001)(81166006)(14444005)(256004)(33656002)(2616005)(6512007)(486006)(476003)(11346002)(14454004)(66476007)(66556008)(446003)(186003)(66446008)(386003)(76176011)(6506007)(102836004)(64756008)(54906003)(316002)(52116002)(6436002)(73956011)(25786009)(68736007)(66066001)(66946007)(26005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6621;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /foxbNB5c928pV46a5YDA0hw3Z2VYAdPEiwv0hylRe0wEN3ZLrdBGaHo522OuVEml2w9SJ1wAHeOIhgmEoYd0D2fq5yEs2XB388AGbt+Goj1AjSNeEfQVAjd/5T94jJq7TBnjaqRETE71tP2CDs7AU6fWD26j/d/qFqAIEY0Vp8V1MmUJLilhQn7HRCFiVpHsdzgq4XUEYIxHtmGrylEk7GZjPUE46tovWHtqkSGkhyhnnIIL0lv6TxFr+xJUS1kVYxIrUQqxhKpHdUIQofXg7bQHcTNv9P7JhPXJEQ58qVObUBFqoDbfe5+GbPCaPMEaLloY0hMSfTzFQi/ndoC2Sej3EtFktqBta+93hBFERagWbyCskKK1ev8+qH3YTqY0h2UkxA8io2lg5nq5Rn7ZytCdxsrKen5rGIWLaeMpQg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3156108CCB3FE7459E41C71E123DF257@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60defaa-3e2e-480f-0787-08d6d9eefca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:09:38.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6621
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 01:11:03AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, sometimes scheduled freeing of QPs complete after
> completion of dealloc_ucontext(). So in use qpids stored in ucontext
> gets lost, causing qpid leak. Added changes in dealloc_ucontext(),
> to wait until completion of freeing of all QPs.
>=20
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> v2:
> - Used kref instead of qid count.
>  drivers/infiniband/hw/cxgb4/device.c   |  2 ++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  3 +++
>  drivers/infiniband/hw/cxgb4/provider.c |  7 ++++++-
>  drivers/infiniband/hw/cxgb4/resource.c | 13 +++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw=
/cxgb4/device.c
> index 4c0d925c5ff5..3cce6c4676c8 100644
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -775,6 +775,8 @@ void c4iw_init_dev_ucontext(struct c4iw_rdev *rdev,
>  	INIT_LIST_HEAD(&uctx->qpids);
>  	INIT_LIST_HEAD(&uctx->cqids);
>  	mutex_init(&uctx->lock);
> +	kref_init(&uctx->qid_kref);
> +	init_completion(&uctx->qid_rel_comp);
>  }
> =20
>  /* Caller takes care of locking if needed */
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/=
hw/cxgb4/iw_cxgb4.h
> index 916ef982172e..28b127efd4ec 100644
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -110,6 +110,8 @@ struct c4iw_dev_ucontext {
>  	struct list_head cqids;
>  	struct mutex lock;
>  	struct kref kref;
> +	struct completion qid_rel_comp;
> +	struct kref qid_kref;
>
>  };
> =20
>  enum c4iw_rdev_flags {
> @@ -1057,5 +1059,6 @@ int c4iw_post_srq_recv(struct ib_srq *ibsrq, const =
struct ib_recv_wr *wr,
>  typedef int c4iw_restrack_func(struct sk_buff *msg,
>  			       struct rdma_restrack_entry *res);
>  extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
> +void qid_release(struct kref *kref);
> =20
>  #endif
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/=
hw/cxgb4/provider.c
> index 74b795642fca..df3b2c43c706 100644
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -64,12 +64,17 @@ static void c4iw_dealloc_ucontext(struct ib_ucontext =
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
> +	kref_put(&ucontext->uctx.qid_kref, qid_release);
> +	wait_for_completion(&ucontext->uctx.qid_rel_comp);
> +
>  	c4iw_release_dev_ucontext(&rhp->rdev, &ucontext->uctx);
> +	pr_debug("context %p done\n", &ucontext->uctx);
>  }
> =20
>  static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
> diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/=
hw/cxgb4/resource.c
> index 57ed26b3cc21..9aef7dabab62 100644
> +++ b/drivers/infiniband/hw/cxgb4/resource.c
> @@ -224,6 +224,8 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw=
_dev_ucontext *uctx)
>  			list_add_tail(&entry->entry, &uctx->cqids);
>  		}
>  	}
> +	kref_get(&uctx->qid_kref);
> +
>  out:
>  	mutex_unlock(&uctx->lock);
>  	pr_debug("qid 0x%x\n", qid);
> @@ -234,6 +236,14 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4i=
w_dev_ucontext *uctx)
>  	return qid;
>  }
> =20
> +void qid_release(struct kref *kref)
> +{
> +	struct c4iw_dev_ucontext *uctx;
> +
> +	uctx =3D container_of(kref, struct c4iw_dev_ucontext, qid_kref);
> +	complete(&uctx->qid_rel_comp);
> +}

I don't like seeing krefs used for releases that don't end in
kfree.. It is not a generic counting thingy.

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4ECA59F1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfIBO4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 10:56:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:1232 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731491AbfIBO4S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 10:56:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82EsZGn028211;
        Mon, 2 Sep 2019 07:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3PbTm6vELpUTLvTGE7FmLrr7Fy3XlAO7HiXun7IlkVM=;
 b=qGOfxa65qPrvr3YoLol1v9/ugKgzhuiMt/PQOQ/cPKnhmdyHFxl56L0DOQWnGyMxJG1h
 POWpRlOSwGPdiFVMBk07Yz5EGXOtU6NGfskbG56p4qs0RA754NA8VUuV1EcPg0vG2QwL
 ZDzkkEj+yGRSuBbViBkdgH34TaHr0ZmVd1Ohvtgkk4dU4QB7lTZ0t8jSHaCERqxMiC3X
 RkPot+onTRJ5W34xUZ7vlKGwvHTujmiM8H/YS2T6BKX7e+g0+0VmkY/OkbTOu6hT/DIy
 IEkTG39aQJUEneVlpYPIc2t3PJh1bWGSwOYVl/oDsL1i6FZ11D4s5u1S9T/Db/v9BzJJ OA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p6xjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 07:56:16 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 07:56:14 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 07:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk2AFucnGDsHVk6jt/Gp4KqPxKgnsSxAeQ+jmKUZ8PsBN7bN7/OtE/9ajdQ+pkD6gyMdMmofMeLH7SvaX/gM2KGZmb/veh9bkAWRWRiYR04VN6ytoAY+nrdCEw5eCZPgjShLxiAhmkrPjzrTVIdZZIX1j2jvTrKXT5pM7JOJczJwgYCAm7PICqKodH1ndop9o1i5ZHjR8i90qsDOSHTIXsNHSZ8YR30KU98xLaMBhIDeXZm2dN0PkuuMGieQYw/nyNdb9Qf1DyfAaJF0YtOGR99dx10kL3Epufxi/jL1MO8wRex16sZ0KG6Eqol38B8vpZdQ5wixwEYoK656vuysVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PbTm6vELpUTLvTGE7FmLrr7Fy3XlAO7HiXun7IlkVM=;
 b=aJFfs8jxS3E6MNmjaOO+NrjYfwCp1Vdb8bAMJJrO9BsHOLAbZ3Wm2IUxrcRkAQOpSnXgVipXpSxitp+69ZlMcdYHWCz/edyr3KWGSjeCySsaA8M8Oi4saHfh4tQyU5mkdLiwEeLomg4bvlr2sTt/zKap4O4+MtDbCGn0tfM0Gwdu+9f2JF69XqScawAUNXc9JxmOVxqsNegjlEY6aM8k7ney9BAU5Libvti1tugoRcBUMAF2xooLBF6cuAh2h32DBsZOAHUSuneu6z28J7fsCbyImBse57K+yPuVwLlr659IRM+Sj9f56TsuhL6sXqpdWbkZ8nJ+eqOzy8d/7i2alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PbTm6vELpUTLvTGE7FmLrr7Fy3XlAO7HiXun7IlkVM=;
 b=xL7yIVSE3plsE6LztczuimKb9ndfxbf6HpwRUTNkVahj6t3HJiQ/OV7cLrlHURHmg4/9LtSVBEO6N0k+PD+WU1jnNqvx11aDxY+KXelALRm0PDSyFEFR1Y71I+KC/kJq8FTylowE1piaS4DQchaHwO6hQ90KRnkm7s0zYpQKFnU=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3310.namprd18.prod.outlook.com (10.255.237.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 2 Sep 2019 14:56:12 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 14:56:11 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] [RFC] RDMA/siw: Fix xa_mmap helper patch
Thread-Topic: [EXT] [RFC] RDMA/siw: Fix xa_mmap helper patch
Thread-Index: AQHVYZlkXPJ266BW6Uya/F84wYAewKcYddtA
Date:   Mon, 2 Sep 2019 14:56:11 +0000
Message-ID: <MN2PR18MB31826FBE561D7D75CDEFB859A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190902141854.19822-1-bmt@zurich.ibm.com>
In-Reply-To: <20190902141854.19822-1-bmt@zurich.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed5c7870-472f-438a-f246-08d72fb5b217
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3310;
x-ms-traffictypediagnostic: MN2PR18MB3310:
x-microsoft-antispam-prvs: <MN2PR18MB331036ABD5419CFEE4724E9BA1BE0@MN2PR18MB3310.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(199004)(189003)(40764003)(53936002)(446003)(5660300002)(99286004)(6436002)(55016002)(7736002)(86362001)(3846002)(66066001)(71200400001)(6116002)(71190400001)(9686003)(14454004)(6246003)(478600001)(33656002)(2501003)(66446008)(66946007)(81156014)(81166006)(7696005)(76176011)(8676002)(256004)(14444005)(186003)(52536014)(110136005)(102836004)(26005)(316002)(8936002)(6506007)(66556008)(229853002)(476003)(76116006)(305945005)(66476007)(64756008)(25786009)(74316002)(2906002)(486006)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3310;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPqIaxK+D0vSt1svp3NSoBfDlJ/ptnhWv0M3k84iRfxkmY6ZLmomUzfYdTmQZeL6rXFuCmQAq1txVHvOeOVBSyTIrfR0xPQf7gBb1ouu0Je4cfRA0HMJXJKmTIG0c3mbyEv7eCkZ7dyqER659BzZKO/dKPKttd/RKwsdQYHCfGPaDfx/gAgsfhTLA6P6uHF5J9O/OKEcdDf93D/adHp02UqtRUVpgVJNJWi1gAbP3mvoZ9VE2LONNt/XbY2NjUxlGNpFXMOlHsBUazorD7SRfrhhVBs8HZ8EtHV7yESTMm4d4Gj2OyNkxaaSR0MONOUZgk/pd2ljPIlOCJA7Jx1Ggq3l8rnJtXIsob4NZhpzLPov2eBDKXYLqNjLPgnE8Q42UDFTxmb/uNbzzOE5JQI2UAeS+P+8KC4MGGiT0Kq4j+w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5c7870-472f-438a-f246-08d72fb5b217
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 14:56:11.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9hLBpZYXNgfTTG52L+bTA9VvRMxPEBbjI9hDnHmXuXsuk3M1P8CK9YJ8N0Qb5L/dT1Xma7L+0C/2S9olUItXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3310
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_05:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Bernard Metzler <bmt@zurich.ibm.com>
> Sent: Monday, September 2, 2019 5:19 PM
> External Email
>=20
> ----------------------------------------------------------------------
> - make the siw_user_mmap_entry.address a void *, which
>   naturally fits with remap_vmalloc_range. also avoids
>   other casting during resource address assignment.
>=20
> - do not kfree SQ/RQ/CQ/SRQ in preparation of mmap.
>   Those resources are always further needed ;)
>=20
> - Fix check for correct mmap range in siw_mmap().
>   - entry->length is the object length. We have to
>     expand to PAGE_ALIGN(entry->length), since mmap
>     comes with complete page(s) containing the
>     object.
>   - put mmap_entry if that check fails. Otherwise
>     entry object ref counting screws up, and later
>     crashes during context close.
>=20
> - simplify siw_mmap_free() - it must just free
>   the entry.
Thanks Bernard, I will incorporate this patch into the series, with some mi=
nor changes
please see=20
Some comments below
Do your tests pass with this patch below ?=20

- I also added back the places that free the memory no longer freed in mmap=
_free
And also added checks on the key on places that remove them to be closer to=
 original
Code. I have changed the length to size_t

Will send the v9 later on today.=20

Thanks for your help
Michal

> ---
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c | 59 +++++++++------------------
>  2 files changed, 20 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/siw.h
> b/drivers/infiniband/sw/siw/siw.h index d48cd42ae43e..d62f18f49ac5 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -505,7 +505,7 @@ struct iwarp_msg_info {
>=20
>  struct siw_user_mmap_entry {
>  	struct rdma_user_mmap_entry rdma_entry;
> -	u64 address;
> +	void *address;
>  	u64 length;
>  };
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> b/drivers/infiniband/sw/siw/siw_verbs.c
> index 9e049241051e..24bdf5b508e6 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -36,10 +36,7 @@ static char ib_qp_state_to_string[IB_QPS_ERR +
> 1][sizeof("RESET")] =3D {
>=20
>  void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)  {
> -	struct siw_user_mmap_entry *entry =3D
> to_siw_mmap_entry(rdma_entry);
> -
> -	vfree((void *)entry->address);
> -	kfree(entry);
> +	kfree(rdma_entry);
I think it is better practice to free the entry and not rdma_entry for the =
same reason
We use container_of and not just cast.=20
>  }
>=20
>  int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma) @@ -
> 56,29 +53,28 @@ int siw_mmap(struct ib_ucontext *ctx, struct
> vm_area_struct *vma)
>  	 */
>  	if (vma->vm_start & (PAGE_SIZE - 1)) {
>  		pr_warn("siw: mmap not page aligned\n");
> -		goto out;
> +		return -EINVAL;
>  	}
>  	rdma_entry =3D rdma_user_mmap_entry_get(&uctx->base_ucontext,
> off,
>  					      size, vma);
>  	if (!rdma_entry) {
>  		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu,
> %u\n",
>  			off, size);
> -		goto out;
> +		return -EINVAL;
>  	}
>  	entry =3D to_siw_mmap_entry(rdma_entry);
> -	if (entry->length !=3D size) {
> +	if (PAGE_ALIGN(entry->length) !=3D size) {
>  		siw_dbg(&uctx->sdev->base_dev,
>  			"key[%#lx] does not have valid length[%#x]
> expected[%#llx]\n",
>  			off, size, entry->length);
> +		rdma_user_mmap_entry_put(&uctx->base_ucontext,
> rdma_entry);
>  		return -EINVAL;
>  	}
> -
> -	rv =3D remap_vmalloc_range(vma, (void *)entry->address, 0);
> +	rv =3D remap_vmalloc_range(vma, entry->address, 0);
>  	if (rv) {
>  		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off,
> size);
>  		rdma_user_mmap_entry_put(&uctx->base_ucontext,
> rdma_entry);
>  	}
> -out:
>  	return rv;
>  }
>=20
> @@ -270,7 +266,7 @@ void siw_qp_put_ref(struct ib_qp *base_qp)  }
>=20
>  static int siw_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> -				      u64 address, u64 length,
> +				      void *address, u64 length,
>  				      u64 *key)
>  {
>  	struct siw_user_mmap_entry *entry =3D kzalloc(sizeof(*entry),
> GFP_KERNEL); @@ -461,30 +457,22 @@ struct ib_qp *siw_create_qp(struct
> ib_pd *pd,
>  		if (qp->sendq) {
>  			length =3D num_sqe * sizeof(struct siw_sqe);
>  			rv =3D siw_user_mmap_entry_insert(&uctx-
> >base_ucontext,
> -							(uintptr_t)qp-
> >sendq,
> -							length, &key);
> -			if (!rv)
> +							qp->sendq, length,
> +							&key);
> +			if (rv)
>  				goto err_out_xa;
>=20
> -			/* If entry was inserted successfully, qp->sendq
> -			 * will be freed by siw_mmap_free
> -			 */
> -			qp->sendq =3D NULL;
>  			qp->sq_key =3D key;
>  		}
>=20
>  		if (qp->recvq) {
>  			length =3D num_rqe * sizeof(struct siw_rqe);
>  			rv =3D siw_user_mmap_entry_insert(&uctx-
> >base_ucontext,
> -							(uintptr_t)qp->recvq,
> -							length, &key);
> -			if (!rv)
> +							qp->recvq, length,
> +							&key);
> +			if (rv)
>  				goto err_out_mmap_rem;
>=20
> -			/* If entry was inserted successfully, qp->recvq will
> -			 * be freed by siw_mmap_free
> -			 */
> -			qp->recvq =3D NULL;
>  			qp->rq_key =3D key;
>  		}
>=20
> @@ -1078,16 +1066,11 @@ int siw_create_cq(struct ib_cq *base_cq, const
> struct ib_cq_init_attr *attr,
>  			     sizeof(struct siw_cq_ctrl);
>=20
>  		rv =3D siw_user_mmap_entry_insert(&ctx->base_ucontext,
> -						(uintptr_t)cq->queue,
> -						length, &cq->cq_key);
> -		if (!rv)
> +						cq->queue, length,
> +						&cq->cq_key);
> +		if (rv)
>  			goto err_out;
>=20
> -		/* If entry was inserted successfully, cq->queue will be freed
> -		 * by siw_mmap_free
> -		 */
> -		cq->queue =3D NULL;
> -
>  		uresp.cq_key =3D cq->cq_key;
>  		uresp.cq_id =3D cq->id;
>  		uresp.num_cqe =3D size;
> @@ -1535,15 +1518,11 @@ int siw_create_srq(struct ib_srq *base_srq,
>  		u64 length =3D srq->num_rqe * sizeof(struct siw_rqe);
>=20
>  		rv =3D siw_user_mmap_entry_insert(&ctx->base_ucontext,
> -						(uintptr_t)srq->recvq,
> -						length, &srq->srq_key);
> -		if (!rv)
> +						srq->recvq, length,
> +						&srq->srq_key);
> +		if (rv)
>  			goto err_out;
>=20
> -		/* If entry was inserted successfully, srq->recvq will be freed
> -		 * by siw_mmap_free
> -		 */
> -		srq->recvq =3D NULL;
>  		uresp.srq_key =3D srq->srq_key;
>  		uresp.num_rqe =3D srq->num_rqe;
>=20
> --
> 2.17.2


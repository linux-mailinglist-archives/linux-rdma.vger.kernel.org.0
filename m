Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7E25AF5A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgIBPhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 11:37:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42184 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbgIBPhK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 11:37:10 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082FaOIx030608;
        Wed, 2 Sep 2020 08:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=jI/ZwPBc88geD+ZR3aXjixNnn2+TISFVr2R6KEn6hI0=;
 b=SlkqPqyncmmiHBIukHLS7rTsfp8FPZd3lbpNx3IRQjeuPHAo/PLJCEdKj3HSYXuxKxNP
 DlgtHuWTt8zStA3Qwuc5wSZg7YEi/YGJ9AxBEX++lysPLOoyhgw1r6azaXly7pGAmOGH
 2TCW51zEUgvK8GlMERHgD2FOqY1Q0evE/nRl4s76OridTEMKi3q2CZHL1/A2nFMlUkOI
 QChyxwl64aYeavBHMbcL1gk4oyp49ajbv96ABz1SXY3qeGaqk4Rk6Q76NfR6RsnJ/K6Q
 CC5yuXwMRS4wzxZOKmPw6bJxJPyYkt9FVAx0J2LfnXGJcu4pwQY6JJ8NtwQ22dlIqjZc sQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 337mcqfyjm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 08:37:02 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:37:01 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:37:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 2 Sep 2020 08:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE3eNB+/YzgylJsiYhcYP+xxJuW7D+prdUWnlReD+z8YmWaFPNUWdWLKAe+GsudBpJQT9flwlSeKytUYoKE8E/oYJ4igRzHGG7RwGVxXqFwfHxIxwmX9imZt4/57ikHl6QUFmFbi8xHCqaK3Qe/xi3eC5dj2CyqI+NclvcX6qvfT6po14U7FzGd9fSKELnv/09/9VPx5NI4cbm2FgCJY8JZhJITkAtz071mul/vQM2srrmVP3UzhXknAnmrg2shq4Rl8Mb6xnVGauzJ/87dy+mzDymKVqO/WrASDRArU6fweRKo82el/j3uxyNNgwvslEISUW6mWqN3qso5bxV2Y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI/ZwPBc88geD+ZR3aXjixNnn2+TISFVr2R6KEn6hI0=;
 b=MMGNcfOiM94ALgYSemF/0zoiL0trSD7szYbiYdI1WO5/fePVnjKhPQPP8KJ2lk4twBZFGfnALuLVn+gbuAuyBMOMn5IXFiHtacmUNzhY712PejMgYFD8Sw6tF8pF53EBAC2xu3Rl0ah/tbdAD3q8LsKF6CQ2gtJeKzlSnQvCTvVtgjdcMkOlMUvPYHnGSxJuJKQbSM10iuMvaZhAEKXT1aoVkYxp8aSRO+YP8RaVlspjAfFBCr6Gf7GLVOiVgWhslVbMq8iGANiLW+9Sfn6zCqns83Lu2qfFHgFPB9KObPVWBw+zs4Ht3HafkCPpJl1ANgfssIMwAxunwxlEHxXLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI/ZwPBc88geD+ZR3aXjixNnn2+TISFVr2R6KEn6hI0=;
 b=BlVoeZGbMhTTFPiYAr0N3cI2SLsA0QUXD4jzkAKqx9MVr11KRYJhS5ALgg2Cb5w+O+c6rZhqJBxwXpE7xE3o4+ikqqeRGp7/QzxFt7JGL17bEDx5eFU9IKD6x2zJBFS+bBd8X46DfQ+lU31N+t602qqEgGkEwpdzNbwod6KzPdE=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2116.namprd18.prod.outlook.com (2603:10b6:207:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:36:58 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 15:36:58 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: RE: [EXT] [PATCH 14/14] RDMA/umem: Rename ib_umem_offset() to
 ib_umem_dma_offset()
Thread-Topic: [EXT] [PATCH 14/14] RDMA/umem: Rename ib_umem_offset() to
 ib_umem_dma_offset()
Thread-Index: AQHWgMItVYz12sbcvEysHV5+GfEsx6lVfB5A
Date:   Wed, 2 Sep 2020 15:36:58 +0000
Message-ID: <MN2PR18MB31823B95E9B9290012AA08B1A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.57.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e41d2e-cb73-4eb1-1ec0-08d84f5607ac
x-ms-traffictypediagnostic: BL0PR18MB2116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB2116B45F9AF9493279179C06A12F0@BL0PR18MB2116.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XG/QC+ZrkVy7rpZStMhF8we7lKcoH7FBOLt/+GlbpDBW5Hri5szJXnWE+VjKbMIFmx9BBMxIQgvc0gmAkuBd/rtwH7bccG/1plYGFf3elt04SmhffMDvVmZ1otpI8qBwES0wQSzYzbfbfqc0yGV/lSfqDMAaiNoXdALGiAdSlwb63X2Zu1dQ9qulTsavVYJI7CvFRMInUboNLqAvHZ79I4n6Mckm5gnczQM1Vw58JUajH/JhJUuTO2dvTrgpOJit2BVttyvRAYobd3yepQrWyFhB/J5Pc9//XMFjc+hTjC1HILSFd1vrplQSTj46oYJ5nxIalGSCOglYV7wRjdPfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(9686003)(110136005)(76116006)(66446008)(64756008)(71200400001)(2906002)(33656002)(55016002)(66946007)(66556008)(316002)(86362001)(8936002)(66476007)(478600001)(7696005)(83380400001)(8676002)(52536014)(6506007)(26005)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CFztXkMbGSr0N8tQ44oOjVbMtB669T1qEA5ZZ5Lc/ryu05xmRyUHmu00CE+sSPIuAz9uxQxMSemW72UxVPbeOwT4wlGaSWJSQfrQ0Ihbjr8RBEOOozNHoKbrZB41M09pFjhCnyF1H2bJf+39UyLbF+47rQ9KAu/RTIpxs+Vqj2Miu3zCrXesF5ZXIwMeL88iZWz/kn8hrJrwhbl5nkW92WCuKRtSBY7bNOrxSMuRKCfL3FgKE2O+EVj3dWSH+SnZXEqVE4GziDljBd0D3Jf8Q8Bw8qjEvoOzO+5ReuNte6v39w5DOdornBVLCzT/gvrqeQM3Vrp+ejpc63cQYmVoH9MYLRnqzxByI6ZpWnRQ7DdevvOxknSBHccCMbQqwWl4tKSM3CyxrXY/j4tuYFOx9M6b8TcBkHig7J+GnX12OsgcJrvQAHiIrooAIuUxDGp7NaESFjSNoZQl0VXYPpFCsgDNmNuuCOzsjoXIEgbTt5ASSrTyT05k40XA+VCghhufETijJFIXlwL4oitiZ2GpASMh6rM1pms5oXkOxGBqbzwlK9l0FjDwzHXGnQ/KXbPTujy/9ugVBEoBsdSfIh/ggU1eewA6U5vd0aDwbMShgcqu/pOHPZbOFWhv0Okr10Q6+Oe54254Eqrgn2xA5Sx5Rg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e41d2e-cb73-4eb1-1ec0-08d84f5607ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:36:58.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r754GUFNp+FzEnVMXne+Vgxgm7hG7yTh+ljpBgyklj7nH8TwaU7KTzm2RFEQyoQxIyOJ/xZsQ9+S9nuc4v/PGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2116
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 2, 2020 3:44 AM
> This function should be used to get the offset from the first DMA block.
>=20
> The few places using this without a DMA iterator are calling it to work a=
round
> the lack of setting sgl->offset when the umem is created.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c          | 2 +-
>  drivers/infiniband/sw/rdmavt/mr.c           | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c          | 2 +-
>  include/rdma/ib_umem.h                      | 9 ++++++---
>  6 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/umem.c
> b/drivers/infiniband/core/umem.c index 49d6ddc37b6fde..c840115b8c0945
> 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -369,7 +369,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem
> *umem, size_t offset,
>  	}
>=20
>  	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->sg_nents,
> dst, length,
> -				 offset + ib_umem_offset(umem));
> +				 offset + ib_umem_dma_offset(umem,
> PAGE_SIZE));
>=20
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 1fb8da6d613674..f22532fbc364fe 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -870,7 +870,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 len,
>  		goto umem_err;
>=20
>  	mr->hwmr.pbe_size =3D PAGE_SIZE;
> -	mr->hwmr.fbo =3D ib_umem_offset(mr->umem);
> +	mr->hwmr.fbo =3D ib_umem_dma_offset(mr->umem, PAGE_SIZE);
>  	mr->hwmr.va =3D usr_addr;
>  	mr->hwmr.len =3D len;
>  	mr->hwmr.remote_wr =3D (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 278b48443aedba..daac742e71044d 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2878,7 +2878,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 len,
>  	mr->hw_mr.pbl_two_level =3D mr->info.pbl_info.two_layered;
>  	mr->hw_mr.pbl_page_size_log =3D ilog2(mr->info.pbl_info.pbl_size);
>  	mr->hw_mr.page_size_log =3D PAGE_SHIFT;
> -	mr->hw_mr.fbo =3D ib_umem_offset(mr->umem);
> +	mr->hw_mr.fbo =3D ib_umem_dma_offset(mr->umem, PAGE_SIZE);
>  	mr->hw_mr.length =3D len;
>  	mr->hw_mr.vaddr =3D usr_addr;
>  	mr->hw_mr.zbva =3D false;

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


> diff --git a/drivers/infiniband/sw/rdmavt/mr.c
> b/drivers/infiniband/sw/rdmavt/mr.c
> index 2f7c25fea44a9d..04f7dc0ce9e44d 100644
> --- a/drivers/infiniband/sw/rdmavt/mr.c
> +++ b/drivers/infiniband/sw/rdmavt/mr.c
> @@ -404,7 +404,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64
> start, u64 length,
>  	mr->mr.user_base =3D start;
>  	mr->mr.iova =3D virt_addr;
>  	mr->mr.length =3D length;
> -	mr->mr.offset =3D ib_umem_offset(umem);
> +	mr->mr.offset =3D ib_umem_dma_offset(umem, PAGE_SIZE);
>  	mr->mr.access_flags =3D mr_access_flags;
>  	mr->umem =3D umem;
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 708e2dff5eaa70..8f60dc9dee8658 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -196,7 +196,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
>  	mem->length		=3D length;
>  	mem->iova		=3D iova;
>  	mem->va			=3D start;
> -	mem->offset		=3D ib_umem_offset(umem);
> +	mem->offset		=3D ib_umem_dma_offset(umem, PAGE_SIZE);
>  	mem->state		=3D RXE_MEM_STATE_VALID;
>  	mem->type		=3D RXE_MEM_TYPE_MR;
>=20
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h index
> 4bac6e29f030c2..5e709b2c251644 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -27,10 +27,13 @@ struct ib_umem {
>  	unsigned int    sg_nents;
>  };
>=20
> -/* Returns the offset of the umem start relative to the first page. */ -=
static
> inline int ib_umem_offset(struct ib_umem *umem)
> +/*
> + * Returns the offset of the umem start relative to the first DMA block
> +returned
> + * by rdma_umem_for_each_dma_block().
> + */
> +static inline int ib_umem_dma_offset(struct ib_umem *umem, unsigned
> +long pgsz)
>  {
> -	return umem->address & ~PAGE_MASK;
> +	return umem->address & (pgsz - 1);
>  }
>=20
>  static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
> --
> 2.28.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51AB4846DD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiADRSE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 12:18:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:19534 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234471AbiADRSD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 12:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641316683; x=1672852683;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=s/+mDb0E4mlUMpEkZVw2G2gvWQwc2orKM7obr+o6awA=;
  b=PbTbD7ScuAN1MrXho3dLIsQDJWuvOQpoLsoAWyduv8v836NBE6I+LQeT
   Ah9yYr0j3nt6yclgylypTHSbwsarlqs90BONRaVlIfzR+rwcwzxZ/4M4g
   Sd3eDTxw9L5TB+6KpNT1KW6gtbgI1gbgDqFiMP483y+QnnBtMW93Ub+/j
   9ooOuw+ReHV+I4FOKrmOolxgK6+teV6v7iyRhoy0enGkE4AurEVeCpoBD
   WKCTY7N+2YX7b15eVXCbxkGmTNjOLO9GLr0xU3f/36q5Xpk4hYW6p/SDl
   7KNJxgr4eNYvUCy6x6caowd/T7/jvPY8tAyD7niOA7T9jhojDTFfJvmpf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229578890"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229578890"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 09:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488259990"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2022 09:18:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:18:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:18:01 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 4 Jan 2022 09:18:01 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHYAYH/2EIkSKjKkkWp1/PNQa3YHaxTByaQ
Date:   Tue, 4 Jan 2022 17:18:01 +0000
Message-ID: <1f6f5d2c6c3c422caa69d65e89f30d99@intel.com>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-4-yanjun.zhu@linux.dev>
In-Reply-To: <20220105080727.2143737-4-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues=
.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 8cd5f9261692..09dba7ed5ab9 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1167,6 +1167,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struc=
t
> ib_qp_attr *attr,
>=20
>  		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
>  		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> +			u32 fl =3D attr->ah_attr.grh.flow_label;
> +			u32 lqp =3D ibqp->qp_num;
> +			u32 rqp =3D roce_info->dest_qp;
> +
> +=09
Do you really need these locals?

		udp_info->src_port =3D rdma_get_udp_sport(fl, lqp, rqp);
>  			udp_info->ttl =3D attr->ah_attr.grh.hop_limit;
>  			udp_info->flow_label =3D attr->ah_attr.grh.flow_label;
>  			udp_info->tos =3D attr->ah_attr.grh.traffic_class;
> --
> 2.27.0


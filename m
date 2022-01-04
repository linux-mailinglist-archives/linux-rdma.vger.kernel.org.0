Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D460484437
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiADPHG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:07:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:34230 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbiADPHG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641308826; x=1672844826;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sDI+y01HSUpu3wqcD6U+tp8lgPza5q3gBBHt1jiq15s=;
  b=eN6uJP+U33AjfPCJKmOLgkUrnZUQK4/AK3DB1n7a4XxU0lvzkon4yrZY
   /Dkq9PzDYnCBa8aqNcXGQpNPBMbo6NKo0/wIR53nFZcuE0rM2y5jeLO6l
   zAetX2mQc8kJtkuvc3ZEv3BwyRNjmYmSSXG8GEAXT9PmUrMdeeIrgUyF0
   sAoDbFuH3fZXoyfYyJWawYE7fklpHKXNG6WXPU7NSCX1NDFstA1hVo2cf
   GpN3FiTIchuSdWANDoQodvbEv3+dYgcxjAqjond/qTK9BzyrrZttNk9uH
   bD0GD2tm7D2neLDfT2suIZxETIpUuBreleixRSvh4oMYZc2bgUfX4yDEe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242034553"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242034553"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="760459896"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 07:07:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 07:07:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 07:07:05 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 4 Jan 2022 07:07:05 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHX9ghEZvP+KpYl90Smju/LVCgLaaxTC2Ew
Date:   Tue, 4 Jan 2022 15:07:05 +0000
Message-ID: <06ce030593a4480694ee3d6d9be0ceda@intel.com>
References: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
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


> Subject: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues=
.
> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
> source port when set path") is a standard way. So it is also adopted in t=
his
> commit.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V2->V3: Move to the block of IB_QP_AV in the mask and IB_AH_GRH in
> V2->ah_flags
> V1->V2: Adopt a standard method to get udp source port.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 8cd5f9261692..31039b295206 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device *ibde=
v,
> u32 port, u16 index,
>  	return 0;
>  }
>=20
> +
> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn) {
> +	if (!fl)
> +		fl =3D rdma_calc_flow_label(lqpn, rqpn);
> +
> +	return rdma_flow_label_to_udp_sport(fl); }
> +
>  /**
>   * irdma_modify_qp_roce - modify qp request
>   * @ibqp: qp's pointer for modify
> @@ -1167,6 +1176,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struc=
t
> ib_qp_attr *attr,
>=20
>  		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
>  		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> +			u32 fl =3D udp_info->flow_label;
> +			u32 lqp =3D ibqp->qp_num;
> +			u32 rqp =3D roce_info->dest_qp;
> +
> +			udp_info->src_port =3D irdma_get_udp_sport(fl, lqp, rqp);
The flow label used in function is not right as udp_info->flow_label is onl=
y set a few lines below. Kindly fold this fix into your next revision.

>  			udp_info->ttl =3D attr->ah_attr.grh.hop_limit;
>  			udp_info->flow_label =3D attr->ah_attr.grh.flow_label;
>  			udp_info->tos =3D attr->ah_attr.grh.traffic_class;
> --
> 2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C214846DC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 18:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiADRR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 12:17:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:65007 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbiADRR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 12:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641316678; x=1672852678;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qygDq/FPffzGyYRopcjtGzVI4tSh19005u4RL71r9XQ=;
  b=F3AgMaWDnTtUOglaonxSGG2ohKHmXEElcmvW6MZuLtQHo9QOlQlDau68
   nSfRczC558AGr9tydeelKxuN5jBCerUAviRbO1rVgOi3MkDhhy4v41RBW
   o6z5my/zevMgTKfO84MMVKdz2jW7jn8aQVidOVlD2LLXxDYKXSwRIM5Ao
   4VQ/AwZ6WWHXZy8MksP/EFRsS1bT9CDNnzi0cnyuDJSLZo+aT5DbQyJlk
   c2MgDUNN+TPIaT4rk8XDWkGbkdIzw925aYZOidq8mLgup2gvcSW7tzBFw
   cgIepBIE7w3iONPfS1Q9NE4DF6SIZR+XFb6F5W0Dfqz8AodZto4QLh0BD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239803262"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="239803262"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 09:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="488259940"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2022 09:17:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:17:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 09:17:56 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 4 Jan 2022 09:17:56 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp
 source port
Thread-Topic: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp
 source port
Thread-Index: AQHYAYIB5lQ3YYfTr067WePQA0aj1KxTDjrw
Date:   Tue, 4 Jan 2022 17:17:55 +0000
Message-ID: <1ba91339fb5e46ccb294f2c529fc2adb@intel.com>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-5-yanjun.zhu@linux.dev>
In-Reply-To: <20220105080727.2143737-5-yanjun.zhu@linux.dev>
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

> Subject: [PATCH 4/4] RDMA/rxe: Use the standard method to produce udp sou=
rce
> port
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Use the standard method to produce udp source port.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 0aa0d7e52773..f30d98ad13cd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -469,6 +469,16 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,
>  	if (err)
>  		goto err1;
>=20
> +	if (mask & IB_QP_AV) {
> +		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> +			u32 fl =3D attr->ah_attr.grh.flow_label;
> +			u32 lqp =3D qp->ibqp.qp_num;
> +			u32 rqp =3D qp->attr.dest_qp_num;
> +
Isn't the randomization for src_port done in rxe_qp_init_req redundant then=
?

https://elixir.bootlin.com/linux/v5.16-rc8/source/drivers/infiniband/sw/rxe=
/rxe_qp.c#L220

Can we remove it?

> +			qp->src_port =3D rdma_get_udp_sport(fl, lqp, rqp);
> +		}
> +	}
> +
>  	return 0;
>=20
>  err1:
> --
> 2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2024782F2
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 03:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhLQCCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 21:02:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:19605 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhLQCCT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Dec 2021 21:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639706539; x=1671242539;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=M10KdwFNm91uxMBp2Sbqo8isP8lkU509NlArTrvo8CM=;
  b=nLz3/9LpLqOUx2VQnwLbCUwI6r0y4eRIKafq+jTiD+XIM7qW4lKR7MgM
   66gngpwVWBDV5AYxdxwA7cKjqqi3shbv5Ej6PSl7HFB7xx/MkSsMZlD4v
   DlKj5dJs6YS+ogMrKIJjn7iR3mwhYZjtLvLUhVZ005J14rnieMdHqt+g2
   pbXirbCHypQsoe/bID9QHfr1ExrCsN4tmnowHCQPGNVfRn7Y1Q/K6ne2z
   IbaKSrv4YlRV7PMmZtwsnheCUVaTMzTh2mo5SaQZk9xtHtXnq08504YL8
   oTIniBzl9xwI30qrj86Mmb3YpsDEM8eWUQAYnEaoAbLjq0wL2TZ7hHA/8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219672516"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219672516"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="615397030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 18:02:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 18:02:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 18:02:17 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Thu, 16 Dec 2021 18:02:17 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHX8CPt3Z0lfTx+tke/CO1HZDZJU6w16++Q
Date:   Fri, 17 Dec 2021 02:02:17 +0000
Message-ID: <d62f36375fac4a1286194bcbddcf50d4@intel.com>
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
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

> Subject: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> get the source udp port number for a QP based on the local QPN. This prov=
ides a
> better spread of traffic across NIC RX queues.  The method in the commit
> d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
> scaling") is stable. So it is also adopted in this commit.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 102dc9342f2a..2697b40a539e 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp
> *iwqp)
>  	return status ? -ENOMEM : 0;
>  }
>=20
> +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp) {
> +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff); }
> +

There are core hash function helpers based on the grh.flow_label or lqpn/rq=
rpn that RoCEv2 drivers could use the to get the UDP src port?

https://elixir.bootlin.com/linux/v5.16-rc5/source/include/rdma/ib_verbs.h#L=
4719

Why don't we use them instead to set the udp_info->src_port in irdma_modify=
_qp_roce when the path address vector is provided?

Shiraz

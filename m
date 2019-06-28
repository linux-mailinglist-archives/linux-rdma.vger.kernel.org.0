Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9059D0D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1Nh3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 28 Jun 2019 09:37:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:36896 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfF1Nh3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 09:37:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 06:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="170748730"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2019 06:37:28 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Jun 2019 06:37:28 -0700
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.123]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.152]) with mapi id 14.03.0439.000;
 Fri, 28 Jun 2019 06:37:28 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>,
        "Latif, Faisal" <faisal.latif@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/i40iw: set queue pair state when being queried
Thread-Topic: [PATCH] RDMA/i40iw: set queue pair state when being queried
Thread-Index: AQHVLXkzfVhxZ0YOG063RoN2DBXCqKaxEcRw
Date:   Fri, 28 Jun 2019 13:37:27 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A6837AC9@fmsmsx123.amr.corp.intel.com>
References: <20190628061613.GA17802@jerryopenix>
In-Reply-To: <20190628061613.GA17802@jerryopenix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzE5NDE0NWMtODIyYS00NGVmLTg4OTYtOWU5YmFlY2QzZGUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZk1hekptVHVZb0lsamJ0K3NuSXEwZFZ4RkN6U25lcHRPcGdXQUhCeGtOR2Y5Y0xvcjgxWXJ2d1Q4Z0RIMmxNdyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/i40iw: set queue pair state when being queried
> 
> 1. queue pair state should be clear when querying RDMA/i40iw state.
> attr is allocated from kmalloc with unclear value. resp.qp_state isn't clear if attr-
> >qp_state isn't set.
> 2. attr->qp_state should be set to be iwqp->ibqp_state.
> 3. attr->cur_qp_state should be set to be attr->qp_state when querying queue pair
> state.
> 
> Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>
> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 5689d742bafb..4c88d6f72574 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -772,6 +772,8 @@ static int i40iw_query_qp(struct ib_qp *ibqp,
>  	struct i40iw_qp *iwqp = to_iwqp(ibqp);
>  	struct i40iw_sc_qp *qp = &iwqp->sc_qp;
> 
> +	attr->qp_state = iwqp->ibqp_state;
> +	attr->cur_qp_state = attr->qp_state;
>  	attr->qp_access_flags = 0;
>  	attr->cap.max_send_wr = qp->qp_uk.sq_size;
>  	attr->cap.max_recv_wr = qp->qp_uk.rq_size;
> --

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

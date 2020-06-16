Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C592F1FBEDB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgFPTVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 15:21:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:8705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbgFPTVA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 15:21:00 -0400
IronPort-SDR: KgVAs35SFecEVkRkvLbTdL0iH88xTE3eDqmRr49bUU8HKYDfbu5QRy3Xu71V/8bJa7D2fBdYgD
 hGU4mt1KoW9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:20:59 -0700
IronPort-SDR: kZSGt3HvOWfGalsxmklyQHNgZyEzZK60wW8pY+Ot5Hm7acUEUh8u5nQVjjAF2HySl1B1wx2/EW
 aKiDJv8ToMVQ==
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="449954218"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.107]) ([10.254.207.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:20:58 -0700
Subject: Re: [PATCH v2] RDMA/rvt: Fix potential memory leak caused by
 rvt_alloc_rq
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200614041148.131983-1-pakki001@umn.edu>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <f2f0815a-7567-2f0a-a55b-d7684a5ce331@intel.com>
Date:   Tue, 16 Jun 2020 15:20:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200614041148.131983-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/14/2020 12:11 AM, Aditya Pakki wrote:
> In case of failure of alloc_ud_wq_attr(), the memory allocated by
> rvt_alloc_rq() is not freed. Fix it by calling rvt_free_rq() using
> the existing clean-up code.
> 
> Fixes: d310c4bf8aea ("IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs")
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> v1: Fix incorrect order of  rvt_free_rq and free_ud_wq_attr.
> Suggested by Dennis Dalessandro.
> ---
>   drivers/infiniband/sw/rdmavt/qp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 511b72809e14..7db35dd6ad74 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1204,7 +1204,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>   		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
>   		if (err) {
>   			ret = (ERR_PTR(err));
> -			goto bail_driver_priv;
> +			goto bail_rq_rvt;
>   		}
>   
>   		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
> @@ -1314,9 +1314,11 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>   	rvt_free_qpn(&rdi->qp_dev->qpn_table, qp->ibqp.qp_num);
>   
>   bail_rq_wq:
> -	rvt_free_rq(&qp->r_rq);
>   	free_ud_wq_attr(qp);
>   
> +bail_rq_rvt:
> +	rvt_free_rq(&qp->r_rq);
> +
>   bail_driver_priv:
>   	rdi->driver_f.qp_priv_free(rdi, qp);
>   
> 

Cool thanks.

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

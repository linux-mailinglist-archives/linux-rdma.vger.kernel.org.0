Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE261F846B
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2020 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFMRYz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Jun 2020 13:24:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:29564 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFMRYy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 13 Jun 2020 13:24:54 -0400
IronPort-SDR: FRsNhMB74VnO045WCbNsHPP4QxTn8jIyrodjPs3ZyurCXCHD7LaFL5mwpubbVltvZ9bugmx+3L
 v05F4hOx29Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2020 10:24:54 -0700
IronPort-SDR: sS9wkkOWP2IUuMY4gT3haiEa8VbnO9eTSK1mP/sr8WNa23DWL1nHQGbxoxvZapa5nBX+UhuSmo
 1GNSmG5BWQqg==
X-IronPort-AV: E=Sophos;i="5.73,507,1583222400"; 
   d="scan'208";a="448689216"
Received: from haqueshx-mobl2.amr.corp.intel.com (HELO [10.254.201.46]) ([10.254.201.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2020 10:24:52 -0700
Subject: Re: [PATCH] RDMA/rvt: Fix potential memory leak caused by
 rvt_alloc_rq
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200612195426.54133-1-pakki001@umn.edu>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <4db8021d-b5a8-448e-4d8d-c8ea91f19daa@intel.com>
Date:   Sat, 13 Jun 2020 13:24:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612195426.54133-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/12/2020 3:54 PM, Aditya Pakki wrote:
> In case of failure of alloc_ud_wq_attr, the memory allocated by
> rvt_alloc_rq() is not freed. The patch fixes this issue by
> calling rvt_free_rq().
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/infiniband/sw/rdmavt/qp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 511b72809e14..17ea7da73bf9 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1203,6 +1203,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>   			qp->s_flags = RVT_S_SIGNAL_REQ_WR;
>   		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
>   		if (err) {
> +			rvt_free_rq(&qp->r_rq);
>   			ret = (ERR_PTR(err));
>   			goto bail_driver_priv;
>   		}
> 

This should probably use the unwind code at the end to be consistent.

Looks like the rvt_free_rq and free_ud_wq_attr have gotten out of order 
and shouldn't be tied together, so that needs fixed up too.

I'd need to study the git log a little more to see what happened but I 
think d310c4bf8aea ("IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD 
QPs") just missed this.

-Denny

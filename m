Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29AAE301DE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3S01 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:26:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:32937 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfE3S00 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 14:26:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 11:26:25 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.228.129.69]) ([10.228.129.69])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2019 11:26:23 -0700
Subject: Re: [PATCH][next] IB/rdmavt: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190529151248.GA24080@embeddedor>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <09563aec-f6d0-f27f-4f67-1e21cebd997c@intel.com>
Date:   Thu, 30 May 2019 14:26:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529151248.GA24080@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/29/2019 11:12 AM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct rvt_sge) * init_attr->cap.max_send_sge + sizeof(struct rvt_swqe)
> 
> with:
> 
> struct_size(swq, sg_list, init_attr->cap.max_send_sge)
> 
> and so on...
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/infiniband/sw/rdmavt/qp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 31a2e65e4906..a60f5faea198 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -988,9 +988,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>   	case IB_QPT_UC:
>   	case IB_QPT_RC:
>   	case IB_QPT_UD:
> -		sz = sizeof(struct rvt_sge) *
> -			init_attr->cap.max_send_sge +
> -			sizeof(struct rvt_swqe);
> +		sz = struct_size(swq, sg_list, init_attr->cap.max_send_sge);
>   		swq = vzalloc_node(array_size(sz, sqsize), rdi->dparms.node);
>   		if (!swq)
>   			return ERR_PTR(-ENOMEM);
> 

Looks correct, I don't think this makes the code easier to read though. 
The macro name "struct_size" is misleading to me. Maybe that's just me, 
and in any case...

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>



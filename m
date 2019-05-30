Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F082301F3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE3S3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:29:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:28894 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3S3P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 14:29:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 11:29:14 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.228.129.69]) ([10.228.129.69])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2019 11:29:13 -0700
Subject: Re: [PATCH][next] IB/qib: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190529151326.GA24109@embeddedor>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a72f82a8-717c-3d5e-644c-4d7f30d3c43b@intel.com>
Date:   Thu, 30 May 2019 14:29:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529151326.GA24109@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/29/2019 11:13 AM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*pkt) + sizeof(pkt->addr[0])*n
> 
> with:
> 
> struct_size(pkt, addr, n)
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/infiniband/hw/qib/qib_user_sdma.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index 0c204776263f..97649f64e09e 100644
> --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -904,10 +904,11 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
>   		}
>   
>   		if (frag_size) {
> -			int pktsize, tidsmsize, n;
> +			int tidsmsize, n;
> +			size_t pktsize;
>   
>   			n = npages*((2*PAGE_SIZE/frag_size)+1);
> -			pktsize = sizeof(*pkt) + sizeof(pkt->addr[0])*n;
> +			pktsize = struct_size(pkt, addr, n);
>   
>   			/*
>   			 * Determine if this is tid-sdma or just sdma.
> 

Again, same minor objection but correct patch none the less.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

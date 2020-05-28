Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861CF1E624F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbgE1NcC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 09:32:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:21122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390303AbgE1NcC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 May 2020 09:32:02 -0400
IronPort-SDR: 9BvkWFpb6aHVx8DD7Cjk4B+FrP0/n5mz3jII8ScOW9CmiYHRtrVC3QgNIstjJlbij+dli1fjCR
 CNCY9IJqa8RQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:32:00 -0700
IronPort-SDR: dbsPAqdPM7hNXfSpV6dA5BCc4Or8fjAcOLgXC+Mhy9OvnkSbeZsWyH7YkkSTLdkZDOSf9nWMlo
 fDxn2BtPyZ9A==
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="267215656"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.103]) ([10.254.205.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:31:58 -0700
Subject: Re: [PATCH][next] IB/hfi1: fix spelling mistake "enought" -> "enough"
To:     Colin King <colin.king@canonical.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528110709.400935-1-colin.king@canonical.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <d60039c9-b0a5-cff5-410e-0d98f020e577@intel.com>
Date:   Thu, 28 May 2020 09:31:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528110709.400935-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2020 7:07 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/infiniband/hw/hfi1/chip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
> index 7f35b9ea158b..15f9c635f292 100644
> --- a/drivers/infiniband/hw/hfi1/chip.c
> +++ b/drivers/infiniband/hw/hfi1/chip.c
> @@ -14559,7 +14559,7 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
>   	}
>   
>   	if (hfi1_is_rmt_full(rmt_start, NUM_NETDEV_MAP_ENTRIES)) {
> -		dd_dev_err(dd, "Not enought RMT entries used = %d\n",
> +		dd_dev_err(dd, "Not enough RMT entries used = %d\n",
>   			   rmt_start);
>   		return false;
>   	}
> 

Thanks!

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

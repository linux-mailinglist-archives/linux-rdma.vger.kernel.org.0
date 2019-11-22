Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F001076C3
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 18:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVRym (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 12:54:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:55438 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfKVRyl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 12:54:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 09:54:41 -0800
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="201602208"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.196]) ([10.254.201.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 22 Nov 2019 09:54:39 -0800
Subject: Re: [PATCH] IB/hfi1: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191122154814.87257-1-colin.king@canonical.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <58bcf0a3-bd5d-66ad-ced4-9a0660f9ba4b@intel.com>
Date:   Fri, 22 Nov 2019 12:54:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122154814.87257-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/22/2019 10:48 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/infiniband/hw/hfi1/platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
> index cbf7faa5038c..36593f2efe26 100644
> --- a/drivers/infiniband/hw/hfi1/platform.c
> +++ b/drivers/infiniband/hw/hfi1/platform.c
> @@ -634,7 +634,7 @@ static void apply_tx_lanes(struct hfi1_pportdata *ppd, u8 field_id,
>   			   u32 config_data, const char *message)
>   {
>   	u8 i;
> -	int ret = HCMD_SUCCESS;
> +	int ret;
>   
>   	for (i = 0; i < 4; i++) {
>   		ret = load_8051_config(ppd->dd, field_id, i, config_data);
> 

Thanks.

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781642528F7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHZIKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 04:10:32 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:12414 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIKa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598429430; x=1629965430;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7vex4m+VcaatgqnNqA29sa4n3gM5e0/ytv2boU2ak5o=;
  b=HXidFJfmG1kbc6NzZ/AInYwEGY06h8fhwAouz4E0UUWOUGzv+zap1eG/
   zORsANtQH0YfCkIk3XmebSo8f5jfIX3TGqytzOV77p0y2txlOL1c+5MXG
   PpNdg6cptJycYK/KA+NhvFJZimRFqtZ/UBTh7pInn5xCXBwxpDEhtqdbA
   s=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="50154163"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Aug 2020 08:10:29 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 872C7A24E3;
        Wed, 26 Aug 2020 08:10:27 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.40) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 08:10:23 +0000
Subject: Re: [PATCH] RDMA/core: Trigger a WARN_ON if the driver causes
 uobjects to become leaked
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>
References: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <6cf9106a-7895-4e88-6ea4-b0292ac2c2f8@amazon.com>
Date:   Wed, 26 Aug 2020 11:10:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.40]
X-ClientProxiedBy: EX13D47UWC004.ant.amazon.com (10.43.162.74) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2020 19:35, Jason Gunthorpe wrote:
> Drivers that fail destroy can cause uverbs to leak uobjects. Drivers are
> required to always eventually destroy their ubojects, so trigger a WARN_ON
> to detect this driver bug.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 3962da54ffbf47..d2b5417a4d5170 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -895,8 +895,9 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
>  		if (__uverbs_cleanup_ufile(ufile, reason)) {
>  			/*
>  			 * No entry was cleaned-up successfully during this
> -			 * iteration
> +			 * iteration. It is a driver bug to fail destruction.
>  			 */
> +			WARN_ON(!list_empty(&ufile->uobjects));
>  			break;
>  		}
>  
> 

Looks good,
Reviewed-by: Gal Pressman <galpress@amazon.com>

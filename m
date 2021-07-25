Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F083D4D14
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jul 2021 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGYJmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Jul 2021 05:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhGYJmH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Jul 2021 05:42:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A470606A5;
        Sun, 25 Jul 2021 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627208558;
        bh=b9Q32uaI92A0JWOV2A5Hxm/bAl66EgVzXiqYx1br78g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJnXAZhVKz4ukcc6om8a5MbzQAM5AkLIxmBYFmwz+7ZKOKh8g6+s3Dp9un4FvmaDX
         7R45pQ2qstMTIJZKTLJNl+JugEOCYKuZGB81BXlLNUwgDnEX1jVDLLPB7qVqQSeozu
         8U1mjwkYTA8zn5Lhc7VKtc4GMkFA3IfiX7xyzTfqUYUGtiH9uJci8NiEKOjL/dIElI
         HafcMj5WJY+kYZeY13GrmRerbzWEks7OjrZTBIfyXxoNLN4N88VWpranYTfl+kEGiT
         GwNyKQY7Wbti472hYBiLRFMDl9v5xGC1UZ26YVS64QAXEMsthZHbgOkJ9rj5j/JBOk
         +Oxqg/SP8nIyw==
Date:   Sun, 25 Jul 2021 13:22:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix missing error code in
 irdma_modify_qp_roce()
Message-ID: <YP07ahKMIJpqlAxP@unreal>
References: <1627036373-69929-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627036373-69929-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 23, 2021 at 06:32:53PM +0800, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/infiniband/hw/irdma/verbs.c:1344 irdma_modify_qp_roce() warn:
> missing error code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 717147e..406c8b05 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1341,6 +1341,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  			break;
>  		case IB_QPS_SQD:
>  			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
> +				ret = -EINVAL;
>  				goto exit;

You are missing brackets, it can't compile.

>  
>  			if (iwqp->iwarp_state != IRDMA_QP_STATE_RTS) {
> -- 
> 1.8.3.1
> 

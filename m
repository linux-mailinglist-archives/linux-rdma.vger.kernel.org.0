Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4183D5640
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jul 2021 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhGZIdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 04:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhGZIdj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Jul 2021 04:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0976A60E09;
        Mon, 26 Jul 2021 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627290848;
        bh=SK2A0RMXQMDE08hNUNDAA/GNXlJURiu0EjV7+YhJDk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGsT/H2Ty5u4g6czs7syg9dBVryR2WqVMmTTu/hJKmbN6QFRce7RRvj9IMe+7ibC3
         3sQSW0bw4huWunPYCAV2GCtvLdy2Ju+o32SV1qiRkfEvwk3lynTkQ6T5BGC7bV6mf+
         puy6DUSWbSuG2oJelzAM/xKJkz4iFbzPzsf6SBq6MlFonPE9ue8VuXuhLCo6VWqrpa
         39L9ofNr3JuNoi5TXonC7ylrPN9L3epptQRliUT9HX3JX4LfI4NyIa2OriQ89TP684
         714aSUcEXANDL8NmPMOQUmh2I1wZ13sUUG074ATtPeliFASwCgJFJgpnwTSaX+cTjO
         eUOb7h6Rl1hEA==
Date:   Mon, 26 Jul 2021 12:14:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: Fix missing error code in
 irdma_modify_qp_roce()
Message-ID: <YP583Ks2tKi5WMVX@unreal>
References: <1627285510-20411-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627285510-20411-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 26, 2021 at 03:45:10PM +0800, Jiapeng Chong wrote:
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
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -For the follow advice: https://lore.kernel.org/patchwork/patch/1466463/
> 
>  drivers/infiniband/hw/irdma/verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 717147e..721cb0c 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1340,8 +1340,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  			}
>  			break;
>  		case IB_QPS_SQD:
> -			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
> +			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD) {
> +				ret = -EINVAL;
>  				goto exit;

It is wrong, SQD-to-SQD is a valid transition and ret should be 0, which
is already set at the beginning of that function.

Thanks

> +			}
>  
>  			if (iwqp->iwarp_state != IRDMA_QP_STATE_RTS) {
>  				ret = -EINVAL;
> -- 
> 1.8.3.1
> 

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84228EDDD9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 12:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDLpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 06:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKDLpx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 06:45:53 -0500
Received: from localhost (unknown [77.137.93.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C83821D7F;
        Mon,  4 Nov 2019 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572867953;
        bh=2u70us/Apy1Vr+V1/i/93218SmYiYazIx3I2jLgva0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRGk51rlQcXoo2j1XmLSRVk/470Y9Ajxv7JDBiSq/o6gaQx3hJaU8OFbUjUEmxze8
         5LLev0xIWbxre6qyfwEk7bwb4cLlMfEnCA6vZHC2c1lhKKQZTLlKHUMrbvK3gfopIV
         LwOhip2cc8xRRN5BMxkIRzz8ODMFr713fjlFqnk4=
Date:   Mon, 4 Nov 2019 13:45:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH rdma-core] cxgb4: free appropriate pointer in error case
Message-ID: <20191104114548.GA100753@unreal>
References: <1572866050-29952-1-git-send-email-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572866050-29952-1-git-send-email-bharat@chelsio.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 04:44:10PM +0530, Potnuri Bharat Teja wrote:
> Fixes: 9b2d3af5735e ("Query device to get the max supported stags, qps, and cqs")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---

We are not super-excited to see patches with empty commit message.
Care to send PR to rdma-core? It will be easier for us to merge it.

Thanks

>  providers/cxgb4/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
> index 7f5955449ca1..4d02c7a91892 100644
> --- a/providers/cxgb4/dev.c
> +++ b/providers/cxgb4/dev.c
> @@ -203,9 +203,9 @@ err_free:
>  	if (rhp->cqid2ptr)
>  		free(rhp->cqid2ptr);
>  	if (rhp->qpid2ptr)
> -		free(rhp->cqid2ptr);
> +		free(rhp->qpid2ptr);
>  	if (rhp->mmid2ptr)
> -		free(rhp->cqid2ptr);
> +		free(rhp->mmid2ptr);
>  	verbs_uninit_context(&context->ibv_ctx);
>  	free(context);
>  	return NULL;
> --
> 2.3.9
>

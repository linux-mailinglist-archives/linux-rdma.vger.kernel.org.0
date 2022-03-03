Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B44CC494
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCCSFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCCSF3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 13:05:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC315C18C
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 10:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3763B82666
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 18:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11908C004E1;
        Thu,  3 Mar 2022 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330680;
        bh=i3uWFHbY7TVxsrAUE9l2Uuprgg26NxrAAb4nP98ke4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktHCQpBfw3XxKTxMQG7+8jhN8wFvpnNtcdq+aj2nuCWWugJuYrX/PACPq+1IvdCOo
         M3FLVq8ul0RDJPT08CzW9q8FpFqp6OE+amQEneuAHoJILeaOyQPlKdQCgBzxj/WGHS
         KSZClEAduUyIwSh7jjNB75elvuImgUNO9LYbYM7lllEqWLCHRU0hJtzK60gLNIoHY4
         PdfnTDj1EbjcNLXaRvqnUiBxgq+CxaC9DbsBiPbsZG3Ii4N/vLKJ17d6itowS5z5v7
         4h6Ed0DFHqUSfB1fFZKmGDombpvtsW+ZSxnOIpEYMAj6Ot2KDRSaC7EpwiwRxQRcRD
         tBaJFFVeq3KzA==
Date:   Thu, 3 Mar 2022 20:04:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: change payload type to u32 from int
Message-ID: <YiEDNPT/T69Y0Vmu@unreal>
References: <20220302141054.2078616-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302141054.2078616-1-cgxu519@mykernel.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 02, 2022 at 10:10:54PM +0800, Chengguang Xu wrote:
> The type of wqe length is u32 so change variable payload
> to type u32 to avoid overflow on large wqe length.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 5eb89052dd66..e989ee3a2033 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -612,7 +612,7 @@ int rxe_requester(void *arg)
>  	struct sk_buff *skb;
>  	struct rxe_send_wqe *wqe;
>  	enum rxe_hdr_mask mask;
> -	int payload;
> +	u32 payload;

This change is not complete, functions in rxe_requester() that receive
payload as an input should be changed too.

>  	int mtu;
>  	int opcode;
>  	int ret;
> -- 
> 2.27.0
> 
> 

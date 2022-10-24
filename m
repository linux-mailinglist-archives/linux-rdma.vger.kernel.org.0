Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2160A454
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiJXMIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiJXMG3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9187E31E
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 04:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B919161257
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 11:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15A5C43470;
        Mon, 24 Oct 2022 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612300;
        bh=5K4AwVYm4+lHrKZsPJyon9OIUN48UG10z3hs1NxGzGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSg0TGssng1nJPkB8hdNqK2ObMrXi46EqhCy5IIedkk4QRnghs3C2kZKMy9LnSKNA
         kz+aAoMdDuM7HGwT6bJ8iNAb5JGnm1dla+58UYlpMYVthm3oEuAdTrMqlwjZ03yPJN
         l1jxZ4GZoEhGiZ0RHzoKmoz03uJ1vV1q5nuM7AzNldw0TXnKhU1BV4OopcJRC3kI+/
         phIUhmyC3zVmv9HtWP/wFCe8a0kF/Slr5w6qzaYQX1FKvTrSyPHagE1S7LJsO3IzV1
         o9XwMscdPE5ETpo3a4Xq1djE03gH9ciRB9qW9WBgb+OX8t4SGetK3aN37Z5wNzsZU/
         zuUSMCQPAdr9w==
Date:   Mon, 24 Oct 2022 14:51:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Message-ID: <Y1Z8R7xB1omokwZ/@unreal>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021134513.17730-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 21, 2022 at 01:45:17PM +0000, yangx.jy@fujitsu.com wrote:
> The member 'type' is included in both struct rxe_mr and struct ib_mr
> so remove the duplicate one of struct rxe_mr.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)

<...>

>  	default:
>  		pr_warn("%s: mr type (%d) not supported\n",
> -			__func__, mr->type);
> +			__func__, mr->ibmr.type);
>  		return -EFAULT;

<...>

> -	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> -		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> +	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
> +		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);

Someone needs to convert pr_*() calls to ibdev_*() prints.

Thanks

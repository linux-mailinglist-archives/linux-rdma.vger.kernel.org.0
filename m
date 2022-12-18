Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E759964FE3B
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Dec 2022 11:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiLRKAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Dec 2022 05:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLRKAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Dec 2022 05:00:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B0D2D5
        for <linux-rdma@vger.kernel.org>; Sun, 18 Dec 2022 02:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B54460A23
        for <linux-rdma@vger.kernel.org>; Sun, 18 Dec 2022 10:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02610C433D2;
        Sun, 18 Dec 2022 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671357612;
        bh=nFwUAYUQVb2q3Psz08eIr8hYVs5k8VUL4qw2UM+IxaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIhlGBC10yxs7EC9wzwLF+Clt+4gXa4amYF3HitPL8jMaN6aaxBlMav54kbPOKb5h
         HRVt6OaOjIy9YsThEsJNEfWsxE6QMn0yFxRYlzJYagu97qr8dlwn5BdFkCYJCreDtT
         vGqTedTocKV+7hOA2Q7DZvsBJpVFu60is6vEC3I8xfcUVQYsV7V6GeJREk1dTnhgLf
         S8FIc89mKLsK4m7KMfOD0uSH9y8sYTZJiur8q4eLa3pvhPWPc1ABYelrfVek4PkHDU
         jT+0+xrvgaWlVMWjcVNoVgPeymrFaLxheXdtGDPNdb0NkF/cOO7+DHOj/MK+LEX2fQ
         hZjKI0TyxOWRw==
Date:   Sun, 18 Dec 2022 12:00:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/cxgb4: remove unnecessary NULL check in
 __c4iw_poll_cq_one()
Message-ID: <Y57kqOuygsEq/03t@unreal>
References: <20221215123030.155378-1-aleksei.kodanev@bell-sw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215123030.155378-1-aleksei.kodanev@bell-sw.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 15, 2022 at 03:30:30PM +0300, Alexey Kodanev wrote:
> If 'qhp' is NULL then 'wq' is also NULL:
> 
>     struct t4_wq *wq = qhp ? &qhp->wq : NULL;
>     ...
>     ret = poll_cq(wq, ...);
>     if (ret)
>         goto out;
> 
> poll_cq(wq, ...) always returns a non-zero status if 'wq' is NULL,
> either on a t4_next_cqe() error or on a 'wq == NULL' check.
> 
> Therefore, checking 'qhp' again after poll_cq() is redundant.
> 
> BTW, there're also 'qhp' dereference cases below poll_cq() without
> any checks (c4iw_invalidate_mr(qhp->rhp,...)).
> 
> Detected using the static analysis tool - Svace.
> Fixes: 4ab39e2f98f2 ("RDMA/cxgb4: Make c4iw_poll_cq_one() easier to analyze")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  drivers/infiniband/hw/cxgb4/cq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Let's wait till merge window ends.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

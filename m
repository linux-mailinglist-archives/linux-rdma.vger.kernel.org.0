Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DB72B35D
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjFKSHz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKSHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 14:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0882E56
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 11:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7747361176
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 18:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22797C433EF;
        Sun, 11 Jun 2023 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686506872;
        bh=+pDK0AQ1KwOtwIFcfwIZWgoaB4rF0+k1i20PkDCX0RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZeTTX/ms8JNSRNBEIPFGf2l6S+Y2OwMAvipRXozQNFBFXrhjSjwB9JPFrGO4MEnf
         nmGO926JgiJoCs13WSYJzCK3OPo81I3SdSrumtYbn9LJSZZjWoEZe+AzZnenZfq4mn
         iWowmsEnaW4JU/bloe1FhjOwIUSFcy6QZFyGpc2iv8g1J7T6HF6c3BhHUhJdzabSSU
         /n+svyPJ1wWgCqK6xKI0wCG1Rfflikaz66ZZcKpSotgdKBi9WwCO3wJPBRbijJWwCc
         zvgW5E83GmA21Ot8wtQ4A65f2t2UAYXxFE6gHpWstT3pPawIEo/5BBPlYbF1KUyw7a
         GbpXcavR/LxaA==
Date:   Sun, 11 Jun 2023 21:07:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     jgg@nvidia.com, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Message-ID: <20230611180748.GI12152@unreal>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 08, 2023 at 04:07:13PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> drivers/infiniband/core/cma.c:2090:13: warning: context imbalance in 'destroy_id_handler_unlock' - wrong count at exit
> drivers/infiniband/core/cma.c:2113:6: warning: context imbalance in 'rdma_destroy_id' - unexpected unlock
> drivers/infiniband/core/cma.c:2256:17: warning: context imbalance in 'cma_ib_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:2448:17: warning: context imbalance in 'cma_ib_req_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:2571:17: warning: context imbalance in 'cma_iw_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:2616:17: warning: context imbalance in 'iw_conn_req_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:3035:17: warning: context imbalance in 'cma_work_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:3542:17: warning: context imbalance in 'addr_handler' - unexpected unlock
> drivers/infiniband/core/cma.c:4269:17: warning: context imbalance in 'cma_sidr_rep_handler' - unexpected unlock

Strange, I was under impression that we don't have sparse errors in cma.c

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/cma.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 10a1a8055e8c..35c8d67a623c 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2058,7 +2058,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>   * handlers can start running concurrently.
>   */
>  static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
> -	__releases(&idprv->handler_mutex)
> +	__must_hold(&idprv->handler_mutex)

According to the Documentation/dev-tools/sparse.rst
   64 __must_hold - The specified lock is held on function entry and exit.
   65
   66 __acquires - The specified lock is held on function exit, but not entry.
   67
   68 __releases - The specified lock is held on function entry, but not exit.

In our case, handler_mutex is unlocked while exiting from destroy_id_handler_unlock().

Thanks

>  {
>  	enum rdma_cm_state state;
>  	unsigned long flags;
> @@ -5153,7 +5153,6 @@ static void cma_netevent_work_handler(struct work_struct *_work)
>  	event.status = -ETIMEDOUT;
>  
>  	if (cma_cm_event_handler(id_priv, &event)) {
> -		__acquire(&id_priv->handler_mutex);
>  		id_priv->cm_id.ib = NULL;
>  		cma_id_put(id_priv);
>  		destroy_id_handler_unlock(id_priv);
> 
> 

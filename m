Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE17AA349
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIUVuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjIUVtw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 17:49:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C91FC2;
        Thu, 21 Sep 2023 14:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32C1C433C7;
        Thu, 21 Sep 2023 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695332613;
        bh=Y6bFPfkkO6qcZgXwuTDH+EvOgNtkp6C+OnOSAJn+fIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=capmzZ2foQYMZEhjVU0PLTsKCu1mjKJTq1wIHOtey79fmIO2FM6Yr5WKx+q4nFyHt
         X0hnnVLSC+4QyFTSZig2ptkrlbQvaNjEgyMV8f/BVL2z4RQByfrktmJj3cyatQu5rC
         VZVfWCY4FMXh60oGnD05BuVpiId3wwdyC+fL6yZiFQTl3PN55s51eb6odDw6WHXgyn
         qF5q6ZWyNYs5PVwGceQm9fN01d4JflXueiJk2hArQ5MZPkls/CMEbqBVRigFj0pDe+
         ZFMYrr5Zei9LsQUvfh66eW50UEyaLTu7cDRJqFEDqeW2CGg8jHo8DV2GaShkMx1WTR
         k+JiyT2uk4xIw==
Date:   Thu, 21 Sep 2023 22:43:25 +0100
From:   Simon Horman <horms@kernel.org>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Message-ID: <20230921214325.GS224399@kernel.org>
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 08:08:34PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Consider the following scenarios:
> 
> smc_release
> 	smc_close_active
> 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
> 		smc->clcsock->sk->sk_user_data = NULL;
> 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
> 
> smc_tcp_syn_recv_sock
> 	smc = smc_clcsock_user_data(sk);
> 	/* now */
> 	/* smc == NULL */
> 
> Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
> since we only unset sk_user_data during smc_release, it's safe to
> drop the incoming tcp reqsock.
> 
> Fixes:  ("net/smc: net/smc: Limit backlog connections"

The tag above is malformed. The correct form is:

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")

> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd97..b4acf47 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	struct sock *child;
>  
>  	smc = smc_clcsock_user_data(sk);
> +	if (unlikely(!smc))
> +		goto drop;
>  
>  	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>  				sk->sk_max_ack_backlog)
> -- 
> 1.8.3.1
> 
> 

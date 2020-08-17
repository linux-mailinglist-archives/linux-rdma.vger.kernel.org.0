Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B598246834
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHQOPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgHQOPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 10:15:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFBC061389
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 07:15:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id df16so12401978edb.9
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GU+hvhFq5FTqZEE9oONoXIkAiVxgc+Oe9aNa54OoQw=;
        b=El20VIDg2NdzHYr8IDobZ35xvin+mYvK5IfVN6E9Mz2vqJozybe5i/2Wlxsfn/Sw/y
         f0k6vhoiwuZpjkzNSH7o+/kxhGMI3IyIdKA4L1csfLFdCS6VvpM1KpyCMatdms38ockb
         vn6Q6r/gun8WRAuHZEgnHoD53UF7AoIaf1iQ4RKKUOFzHezYOMIPu4FjKKdkid1QrTsN
         XYkEGMgZuM9FY7pC3oZAX3Vg3vp1JBtMrz/WWZifbhpZStXw/b3vMHLDcnShb+UIMLC4
         o9oDwufDPJMlMN5ma80n0X1ZjkPVvlDsh9iTTR2Y6qpP13GK5L2sWymrfnPwd48VcEor
         G8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GU+hvhFq5FTqZEE9oONoXIkAiVxgc+Oe9aNa54OoQw=;
        b=feGq92duc02/H6gFl2MdhoulHjA4nLlPAXcIdKOESJDaYz3t+tfiUr6yVaMsFI7S2r
         mLg+AY7e/BtY9NSp+GLeg3tzKw2SJ7yzaF5lHqjFheTDvLgpbR1moIHphKVFkwJed5Fr
         QHsJKoo18D2W2vhM6hSnwqHTTw4MpD7KjJ7apVP7rIVNVUYoF/CBUdoqpROMXiDns7R6
         5wQ+l/mLDx7GUvNGqN9O+yuVZxvN9DHcmcySixWGq7v/Yr/+AZgWly+kjTOlNQkZZY94
         jM75hkvVAzJYZU6SJfU79rbP//XhjDwHih2CL/tjKnO0xeCviivUMMoa/2Gfl+0q6Iln
         nyKA==
X-Gm-Message-State: AOAM533vqVKwpBvNnX6opx320A35kBglOcO/5gSZ08p7M4DZL/eYMeFD
        vLMFBrg65sVS427S665p/tMDrQ==
X-Google-Smtp-Source: ABdhPJzjr9ZxRXnAgQ3pOgNu0n1L4UO5JB4hdIav5PocnLg1VrC/U2k8Jix0avX3cyR6efPTsghljQ==
X-Received: by 2002:a05:6402:3121:: with SMTP id dd1mr15268241edb.72.1597673735048;
        Mon, 17 Aug 2020 07:15:35 -0700 (PDT)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id g19sm14563399ejz.5.2020.08.17.07.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:15:34 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:15:33 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
        kda@linux-powerpc.org, dougmill@linux.ibm.com,
        cooldavid@cooldavid.org, mlindner@marvell.com, borisp@mellanox.com,
        keescook@chromium.org, linux-acenic@sunsite.dk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com, Romain Perier <romain.perier@gmail.com>
Subject: Re: [oss-drivers] [PATCH 16/20] ethernet: netronome: convert
 tasklets to use new tasklet_setup() API
Message-ID: <20200817141532.GA4130@netronome.com>
References: <20200817082434.21176-1-allen.lkml@gmail.com>
 <20200817082434.21176-18-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817082434.21176-18-allen.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 17, 2020 at 01:54:30PM +0530, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

But:

This series should be targeted at net-next, and thus have net-next in its
subject

	[PATCH net-next x/y] ...

And it should be posted when net-next is open: it is currently closed.

	http://vger.kernel.org/~davem/net-next.html

> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 39ee23e8c0bf..1dcd24d899f5 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2287,9 +2287,9 @@ static bool nfp_ctrl_rx(struct nfp_net_r_vector *r_vec)
>  	return budget;
>  }
>  
> -static void nfp_ctrl_poll(unsigned long arg)
> +static void nfp_ctrl_poll(struct tasklet_struct *t)
>  {
> -	struct nfp_net_r_vector *r_vec = (void *)arg;
> +	struct nfp_net_r_vector *r_vec = from_tasklet(r_vec, t, tasklet);
>  
>  	spin_lock(&r_vec->lock);
>  	nfp_net_tx_complete(r_vec->tx_ring, 0);
> @@ -2337,8 +2337,7 @@ static void nfp_net_vecs_init(struct nfp_net *nn)
>  
>  			__skb_queue_head_init(&r_vec->queue);
>  			spin_lock_init(&r_vec->lock);
> -			tasklet_init(&r_vec->tasklet, nfp_ctrl_poll,
> -				     (unsigned long)r_vec);
> +			tasklet_setup(&r_vec->tasklet, nfp_ctrl_poll);
>  			tasklet_disable(&r_vec->tasklet);
>  		}
>  
> -- 
> 2.17.1
> 

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160E1E109C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEYOeu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOeu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:34:50 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5FC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:34:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id er16so8126196qvb.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InWH2HCzuglQzA5wEivW/K4p8MlB+gVA3WsQLl6LuFA=;
        b=Gj5XUwhM+75VKizJURT43ag13/P/9NxMJTp3jcGABIBcTsv20wFSvFliy9EIxaPZ4o
         Gt1R+orSo7ymmcUif3GPpJDe8+abtsjrsz4InJbAk4vVVkHUAQKSM6rggGZFX9cQLpOJ
         CmlfM0lBUtv/8gZ3gFVx8FCA7YbNPsYzmGWkrFjeNs9nI7NcaMEDdnUpQLRochAEXgLT
         yAr00cS6Cz4eSBSre4z/LlIbwfAo42cMsfnCRNzrG5Wgwpy0wivN73KhHY9g69XzdlqR
         JfosKN9yt80tBFb9UN9pMB8VC4k39gePMVF64PhngflPUrGm4BxjvpjlN6wRwIW8JE2m
         N8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InWH2HCzuglQzA5wEivW/K4p8MlB+gVA3WsQLl6LuFA=;
        b=WJFhJ9Auj52rfJaiBT269BCZodhPk60x6oFnOEPHjZhCmbtcw+dHfilOOzw747Uyg4
         n7k3Dis/2dPE7QbGOjB1WS+tG28sywiIP15DCYot5amrgY8CqL0evaHBwclqNMycSy96
         5Zw7lbJ482OvIt0OB7SbBecOsHGULA7ag0bST62S2ebaO7MhG9785vWST9PLjpk1kKUb
         fIUkBv6Ljt+xsRI8QQbg89YGdaHgjdZYsu7t5uTpG0NYXg3VydDeCQrXQTW5z6+pCwvt
         FEDIL+zsgcdNW93op67qnYCAb73iykkFODHpllbnFq8XPh5cUM5G1RQHv3ESUlM+81xb
         4E4Q==
X-Gm-Message-State: AOAM533C44HB7Hy473aMq2MiSdE+PKacZ7s34qLpSHf93Q8/J1VhtIgl
        YIVpg+KixrQjNTHVcJKD8qL7Kw==
X-Google-Smtp-Source: ABdhPJyGOGVqjW5APFirRcrI06OiBXR9VKcrr3aqLQ1ZO8qFSYADOBf7wCrVQCmyH7rtZG83jq0MEg==
X-Received: by 2002:a05:6214:1334:: with SMTP id c20mr16147771qvv.183.1590417288170;
        Mon, 25 May 2020 07:34:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 79sm2352375qkf.48.2020.05.25.07.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:34:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdEBj-0005dj-7Q; Mon, 25 May 2020 11:34:47 -0300
Date:   Mon, 25 May 2020 11:34:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH rdma-next 09/14] RDMA: Add a dedicated QP resource
 tracker function
Message-ID: <20200525143447.GA21596@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-10-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-10-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:29PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> In order to avoid double multiplexing of the resource when it's QP,
> add a dedicated callback function.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/device.c       | 1 +
>  drivers/infiniband/core/nldev.c        | 2 +-
>  drivers/infiniband/core/restrack.c     | 2 ++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
>  drivers/infiniband/hw/cxgb4/restrack.c | 5 +----
>  include/rdma/ib_verbs.h                | 1 +
>  6 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 1f9f44e62e49..23af3cc27ee1 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2619,6 +2619,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
>  	SET_DEVICE_OP(dev_ops, fill_res_entry);
>  	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
> +	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
>  	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
>  	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
>  	SET_DEVICE_OP(dev_ops, get_dma_mr);
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 6207b68453a1..8c748888bf28 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -499,7 +499,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
>  
> -	return dev->ops.fill_res_entry(msg, res);
> +	return dev->ops.fill_res_qp_entry(msg, qp);
>  
>  err:	return -EMSGSIZE;
>  }
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 031a4f94400e..33d7c0888753 100644
> +++ b/drivers/infiniband/core/restrack.c
> @@ -29,11 +29,13 @@ static int fill_res_dummy(struct sk_buff *msg,
>  
>  FILL_DUMMY(mr);
>  FILL_DUMMY(cq);
> +FILL_DUMMY(qp);

Lists of things should be sorted

>  static const struct ib_device_ops restrack_dummy_ops = {
>  	.fill_res_cq_entry = fill_res_cq,
>  	.fill_res_entry = fill_res_dummy,
>  	.fill_res_mr_entry = fill_res_mr,
> +	.fill_res_qp_entry = fill_res_qp,
>  	.fill_stat_mr_entry = fill_res_mr,
>  };

Here too

I'm also not sure the FILL_DUMMY obfuscation is worthwhile for 3
functions.

> @@ -2571,6 +2571,7 @@ struct ib_device_ops {
>  			      struct rdma_restrack_entry *entry);
>  	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
>  	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
> +	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);

Sorted too

Jason

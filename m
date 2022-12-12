Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC1649F20
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiLLMvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 07:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLLMvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 07:51:22 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB293CC2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 04:51:21 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id b189so11073219vsc.10
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ky6wCuVExhCA0UdFI8/xiDmkAXz07wXInLBeIsx+tc=;
        b=dXsYSgyeCqINyUzDMnMsVW3qFET0j9+BUpmK/VAIUHp/kxOlTJz8McuWCCzJgOm6BQ
         5nJbfmmI8sN5+xeLsxA4KsIbT9O4nd2vAa48mkMr3mTvP4mea1mc0tEyQ1Y1lXdNezVx
         v5NdPoTmxzOEQpU0sghoqrECDn7IILUDhsQyI1pZ0ygFbva3Jf+aFeVmk4L2G4jrjCHl
         cfsbj9IOiIH47Yg8ZklLm1BATqrdizEMeQMnQwsbOEGXh4fJzI2Bc4aSlJz3Q+BFscp5
         o93p4VJls2WryWvHpyIk1nVl//j7vT2UImrqQBp9NcSxrcZjFbNgXjhHPI+LchT3Xr2F
         LJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ky6wCuVExhCA0UdFI8/xiDmkAXz07wXInLBeIsx+tc=;
        b=XXtW8ObOjDqAd+Pk92tsHiovRD9giU1xZRiks+/jor14Na5GhRQAov8eTggCrVB0At
         j9XBenNwiOS5r+QdRzGSO5vF61tf8IvUWVC/tDhYE60nTAjhogCpqxhY9p3x/hGXPGRt
         zQhH55PUgyhhe4aFJ1qNe9QnJ/rB3gXooyWV1XtLGlxtBGOhjJNdPEuxd7E6pgIVnMPh
         g4/o5XBsk4pTUAv2Vf7xkIzLqzDBK+lp37FAN7vfcetoV1vtfLBjmVuf7wxBzhSpPHy0
         JI3Pj7ycOxVmwroEFr2FepvfCeHwAr4GSN6TIqDHypnjUHrNQozXyECDZdI3GscQXZcD
         oYzw==
X-Gm-Message-State: ANoB5pkGqXSTBY1ETdOLpb9DEOxJK/cysLZrJMzv9nJAccx5iTs4yvuK
        MnfAhZXojjsR/tfvczeqUz0a3w==
X-Google-Smtp-Source: AA0mqf7E6q386oY4Zu2bgxie0H3t/JNd0waTO47JGyymEEyMyN6nf2mIB2+/5WdxS97Gi/+ixWj0YA==
X-Received: by 2002:a05:6102:3e0a:b0:3aa:4f63:71a1 with SMTP id j10-20020a0561023e0a00b003aa4f6371a1mr7536837vsv.23.1670849481039;
        Mon, 12 Dec 2022 04:51:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a2a0a00b006fb9bbb071fsm5850609qkp.29.2022.12.12.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:51:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p4iH9-008dDF-7a;
        Mon, 12 Dec 2022 08:51:19 -0400
Date:   Mon, 12 Dec 2022 08:51:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [for-rc] RDMA/core: Make sure the netdev is not already
 associated
Message-ID: <Y5cjx/YI/Cxbh/z0@ziepe.ca>
References: <20221212092240.21694-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212092240.21694-1-kheib@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 11:22:40AM +0200, Kamal Heib wrote:
> Make sure that the requested net_device is not already associated with
> an ib_device before trying to create a new ib_device that will be
> associated with the same net_device, this is needed to avoid creating
> siw and rxe devices that will be associated with the same net_device.
> 
> Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/core/nldev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index a981ac2f0975..376c9e158556 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1696,6 +1696,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	const struct rdma_link_ops *ops;
>  	char ndev_name[IFNAMSIZ];
>  	struct net_device *ndev;
> +	struct ib_device *ibdev;
>  	char type[IFNAMSIZ];
>  	int err;
>  
> @@ -1718,6 +1719,12 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (!ndev)
>  		return -ENODEV;
>  
> +	ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
> +	if (ibdev) {
> +		ib_device_put(ibdev);
> +		return -EINVAL;
> +	}

This is racy

What is wrong with creating two IB devices on top of the same net device?

Jason

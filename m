Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C045FCB3
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 20:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGDSHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 14:07:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38692 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGDSHS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 14:07:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so8767157qtl.5
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=edRK9RyWdDWA8yAro5UhF768SF+PQNMkLfz8Y7BOVeA=;
        b=RCTGRDZB90xEBxvN/A7efIdulfeZf512hSD10s3xvszz/X0KjXOjv15C3s78OfHAd6
         skIUc0U4aywwRoTghByjRBSm12iFktyTQxIfMME7eFhk9SGTHuM1Ru/vfjWca8/J32HE
         PwXl55oAoh/hvArgJfOx31ldXQjh2uywyaVcv8BTT1FL7gPUr6gVOSsqy/yTfpHwYJIE
         ZWUVV2OPmM8b2spUTXCAty41hM5L+e0LKA4gPPoofrdNYhDIm2IBs6t8EuAkbhWb7B85
         p9sC9771rS1Tom4rNjBAiKm5+h1VnAFchRkSZ7oQRTrNQVgZ4ycrzMQDX5frKKaZf0T8
         XpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edRK9RyWdDWA8yAro5UhF768SF+PQNMkLfz8Y7BOVeA=;
        b=ITAAbRYyL5qhkpr70U933gX2QEt9jr5Yjo2+ZRYR6j+0L30fcQ3Uoi4WZR09ZXLTvZ
         6LvQNWymJGFscKzXv9v+/aViQjsUZ6jq8z8ru4b0o9ARJ/RsywEd96H4ob0PhpsRT7G1
         I3U5JNf++4zy+KY5sX8+uaCacPDOK/3NFgS0fq0x0aLZ6yrHb7UxbsMwDoZpqUbDlEWB
         R99uv8oxDOEP/QsrwdFZ155cK8CTCfYL8bmy6qQOWm/fwJomMOd6obnQyn8npnHPNhu2
         ZtU1uYIKa7IgcPrR+4aRe+RieEZ0L7TJV2Dn8780Ox3cNaxlz89ynKzFlpaipMbnzSDm
         u1Xg==
X-Gm-Message-State: APjAAAUOpbIVuCe6qjum6s3ASqhHHTYngKlidQxmzOY8QEHayzGDip52
        Ct5P5D81hfz9/w6wAHVE7GwF2g==
X-Google-Smtp-Source: APXvYqwwVoyTUjgrRRi/Bx+hW0epBdCmfFFPtlJu5225jY9Sk0DxpV8YEkMUQEkmedrSL14rtRpM/g==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr36411053qtq.192.1562263637216;
        Thu, 04 Jul 2019 11:07:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j22sm2506688qtp.0.2019.07.04.11.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 11:07:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj68a-0000gF-83; Thu, 04 Jul 2019 15:07:16 -0300
Date:   Thu, 4 Jul 2019 15:07:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v5 11/17] RDMA/netlink: Implement counter
 dumpit calback
Message-ID: <20190704180716.GA2583@ziepe.ca>
References: <20190702100246.17382-1-leon@kernel.org>
 <20190702100246.17382-12-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702100246.17382-12-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 01:02:40PM +0300, Leon Romanovsky wrote:
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index 0cb47d23fd86..22c5bc7a82dd 100644
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -283,6 +283,8 @@ enum rdma_nldev_command {
>  
>  	RDMA_NLDEV_CMD_STAT_SET,
>  
> +	RDMA_NLDEV_CMD_STAT_GET, /* can dump */
> +
>  	RDMA_NLDEV_NUM_OPS
>  };
>  
> @@ -496,7 +498,13 @@ enum rdma_nldev_attr {
>  	RDMA_NLDEV_ATTR_STAT_MODE,		/* u32 */
>  	RDMA_NLDEV_ATTR_STAT_RES,		/* u32 */
>  	RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK,	/* u32 */
> -
> +	RDMA_NLDEV_ATTR_STAT_COUNTER,		/* nested table */
> +	RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,	/* nested table */
> +	RDMA_NLDEV_ATTR_STAT_COUNTER_ID,	/* u32 */
> +	RDMA_NLDEV_ATTR_STAT_HWCOUNTERS,	/* nested table */
> +	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY,	/* nested table */
> +	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME,	/* string */
> +	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE,	/* u64 */
>  	/*
>  	 * Information about a chardev.
>  	 * CHARDEV_TYPE is the name of the chardev ABI (ie uverbs, umad, etc)

This is in the wrong place, needs to be at the end.

Jason

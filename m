Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9A149732
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAYSbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 13:31:14 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33127 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAYSbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 13:31:14 -0500
Received: by mail-yb1-f193.google.com with SMTP id n66so2798451ybg.0
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vwgI27dUT4DqsWQuS2QCXGZ5weNqXw6qdVwyeEGnGAQ=;
        b=Ybc024znCaLlgYVwW6bk9+Zhha0Rd253Fw3iLeBhsIxYdIGPx0nMt94RGx7veCD+d9
         +Ece+cmNdAwc+8RXoYxjAWyc46cCZMcq/2V+dBLn+oGMtnJwuptmUQELLdf+2tb2eeJW
         wrZY1jeQ+kgkb0TG5ErxyrIiI3YtOUTcsCuDOwrZ4stE1yrOtvRlAZIT79nHHwXK/k/T
         g4ivgCVh5SQ+t/5Wl3oiI2dZdGwxDvEAOH1VL1KhECJqOSTB3oNeK/wZPdO359BqfA5x
         rmGwN4SNCufP0xuzBzpfEC0yjVUHsCNuDU8Ya6x11bJ7svAlcw6hCzfYbL19uC4mYrXj
         Mlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwgI27dUT4DqsWQuS2QCXGZ5weNqXw6qdVwyeEGnGAQ=;
        b=NBBNvSe5z/w0OpWPZqR2u7+YA0Pf+NsOzIgykWPAf7ZrQVKkF75bsaJ+kgsL0AdqGB
         evnf6vy4Zz4ZfVbMHetJ+QQbvXOBSeEgLrUUUNAOWnvuecVu2Tf4jKRwHN00qJ4cyXoG
         0zvuDmZ8HI5JPt/XTV+wj+W2j5fz8PxLxwR0YRz2Pfu4NaO/bm6IBOrOg3QJw73DD9aG
         yIC3WdwsVNbEn9G/UJebh6fegzb5L9lbYpwz8bxu0DsnoYcLtlYkvIcd092v9VDVLKGl
         yULXSfbHf5yvpsfwkxLCZer1NCl8QDfXMEnI73DYXCAe5rxA7Izrd8bwQe4Wf7s3p7fb
         1AhA==
X-Gm-Message-State: APjAAAUZR0CF4I1fuCl+0+zsglR+1VkQ7GzO9eLsZtycEwDJIRjKPdTY
        iTcM1fUvjRtz3B1kPnfNtJHACKpkuFmMew==
X-Google-Smtp-Source: APXvYqxTt3ne80koScBi1j/NCfrW/qf02KGNscff+dLIidL3W89jyBKPi5nuB20l7SjhxYLipm11fA==
X-Received: by 2002:a25:7649:: with SMTP id r70mr7544893ybc.125.1579977073221;
        Sat, 25 Jan 2020 10:31:13 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id g29sm4207971ywk.31.2020.01.25.10.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 10:31:12 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivQD6-000228-LT; Sat, 25 Jan 2020 14:31:08 -0400
Date:   Sat, 25 Jan 2020 14:31:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-nxt] i40iw: Do an RCU lookup in i40iw_add_ipv4_addr
Message-ID: <20200125183108.GB7345@ziepe.ca>
References: <20200117214720.1960-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117214720.1960-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 17, 2020 at 03:47:20PM -0600, Shiraz Saleem wrote:
> From: "Shiraz Saleem" <shiraz.saleem@intel.com>
> 
> The in_dev_for_each_ifa_rtnl iterator in i40iw_add_ipv4_addr
> requires that the rtnl lock be held. But the rtnl_trylock/unlock
> scheme in this function does not guarantee it.
> 
> Replace the rtnl locking with an RCU lookup since there are
> no netdev object updates in this function.
> 
> Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
> index 2386143..d7a1219 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
> @@ -1212,22 +1212,19 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
>  {
>  	struct net_device *dev;
>  	struct in_device *idev;
> -	bool got_lock = true;
>  	u32 ip_addr;
>  
> -	if (!rtnl_trylock())
> -		got_lock = false;
> -
> -	for_each_netdev(&init_net, dev) {
> +	rcu_read_lock();
> +	for_each_netdev_rcu(&init_net, dev) {
>  		if ((((rdma_vlan_dev_vlan_id(dev) < 0xFFFF) &&
>  		      (rdma_vlan_dev_real_dev(dev) == iwdev->netdev)) ||
>  		    (dev == iwdev->netdev)) && (dev->flags & IFF_UP)) {
>  			const struct in_ifaddr *ifa;

The rtnl does not just protect the pointers, but also values like
flags from changing. When using RCU any varient values of the dev
should be read with READ_ONCE, such as flags.

I'm not completely sure the vlan tests are OK under RCU either, but
netdev has historically been loose on its READ_ONCE/WRITE_ONCE
annotations..

Jason

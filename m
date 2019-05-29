Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097182E1FC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfE2QIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 12:08:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44062 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QIH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 12:08:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so1786344qkb.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fsh0TYYc8CcoupHMZiwDZqdBbvSIVmD8HEtsKuwww8s=;
        b=Alfsrw1MVw34ZMTuaGUxB/ZqEsRTzwdDj0vXoeivqbB0oyFDAIptz8nj+2u3RnZVnL
         jAkqVvr3hZEHvsxwiYYKjvuRy7L8SLIhoM+iZgtk5APZMQBzygh9x3JvHKhqPFu/GrrJ
         kqGcJ+4PNJWFHh0cl4JFydycISRCpMv5JilO8aoH2kakAl1Mi0oy29buspX8OLIcOer+
         W9VeGsHHmC2Hpz7uOpb43qDTXKM5z7HFAmmCW9GMnylg1VwbyjEkEALrhGNBr4HBgwej
         fJJLOLQjrUhhQHtbgpuLOJpQx1Rz9CupCAMAWIFCV3X3WV6h7ciLKihet+bDXWlb6XQv
         mYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fsh0TYYc8CcoupHMZiwDZqdBbvSIVmD8HEtsKuwww8s=;
        b=EedDyPvc2LqA0alffmdIkN8c1mPC4bKBvDNtBSQjInjF2+ZzhMPRg3H+PLxVUJFVy6
         1v5ULRyAjTNWB/qgCiJS5V5bdXyZDMSnda9jakxrprfV3slTcbcid1b8y/mi7Cl6gN5r
         +kmUOS/gf+AQiJjT22qSFP2bQgqeMUsdI6lv8WU3UQ0+wrn3kSfU0bcNLx3kil1MZFfB
         B65bN8uhc83dEunjdQJtMJGHTudUBRW8iF1p8JZd9wvBlvxYGxwsJ+Q8d5JA0IDIKMEK
         o7TxPrsx6s96MUK5Xv4Cw8fIHQXpecFfTjjz/Y6WPa9nEZKRB1GZEXm9rikVEXCxn+p9
         /hOA==
X-Gm-Message-State: APjAAAVVPiGW+v8X7vFP26EHknRIRAEgLq3KGgVVoIl0YqEzqRnoUi27
        lGbUAf6uxjb/odnOsYs2LDbV+Q==
X-Google-Smtp-Source: APXvYqxR4BNFqVP5+qkd0J3oYODmAEzobBbmiVkKU9yYgPMKGfDxqubNW01C3jR16936S7t0IZ85Xw==
X-Received: by 2002:a05:620a:13f9:: with SMTP id h25mr9603277qkl.283.1559146081685;
        Wed, 29 May 2019 09:08:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r186sm518843qkd.95.2019.05.29.09.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:08:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hW17Q-0001kD-Je; Wed, 29 May 2019 13:08:00 -0300
Date:   Wed, 29 May 2019 13:08:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Message-ID: <20190529160800.GA6680@ziepe.ca>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520111902.7104DE0184@unicorn.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 01:19:02PM +0200, Michal Kubecek wrote:
> Commit 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> breaks i386 build by introducing three 64-bit divisions. As the divisor
> is MLX5_SW_ICM_BLOCK_SIZE() which is always a power of 2, we can replace
> the division with bit operations.
> 
> Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cmd.c  | 9 +++++++--
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason

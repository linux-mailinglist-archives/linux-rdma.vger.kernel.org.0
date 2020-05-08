Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8061CB8B3
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHT6k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHT6k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 May 2020 15:58:40 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61805C061A0C
        for <linux-rdma@vger.kernel.org>; Fri,  8 May 2020 12:58:40 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 59so1392964qva.13
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2020 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fjdVK7f+8aigodcAGlUvVOf1RKpAaK1SR2MV0cPRHk=;
        b=SerDa9iQZ83WrkL915BvYV2YXa3azn5jCBvL+GuHfLmB+uvp5jiI9xM8ZkIqtZrAi7
         pBDK7Jzswe0it1opDQQqu6SctIHaZ+C3in+UTP1mXx0Z+JtIf8VHPCVDwGjfGJBhGExO
         HsIOwuCDDlQpa3DU5KTONkS8VgROsGsqlP2XBCwro+hwxoXejKF4dvXWtk3kxocjwgAg
         Slhr/j8T41VSBdZmOOc4ntLhjVUyQWLEzfPUfsxa+Uf9uHgBfjPKSqdSfcZ/uqDZmWum
         FgGR2k+k7PAfnz5OKKTJphYVs6pI4QiCDmJBZpKFVhlNByGshjBVdmlgrQVHSgy2jGVH
         DOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fjdVK7f+8aigodcAGlUvVOf1RKpAaK1SR2MV0cPRHk=;
        b=SefEAYBWETp3TtHDvk1kuMa41EtVTBkS+ozx3ss7TK5DcZYdZztS2vsDIjelnhlfki
         9jKUSgargo1Q94aaVI2R9uJL0NXZ/FTSGInR3Tc9JdQwKA2fzdnHi3t+dkEy/I89vaN0
         jogMStUDgT+3oiYYh9KjI8UPaTa/GdUHSgPRnYgdWh/u9asZlafWgD4bv83N4N5dOiKY
         x4KcwTn0B00WTKJhhId01DF1Cui2RbtQvEuZ4HP1i1rklap1+7z4CCgxqoY4QCEbsMeq
         5M8u425mzk76TavlZbI5VZdyYlh+jaGmDcfNOR3fL5+mhDqX8kacDMFfpc/nlAzNCz27
         D5hw==
X-Gm-Message-State: AGi0Puab3qgOG5ROa3NeEybVIF89gOe+7K/srsSOX9Oe9yt4KC72fTWV
        rsXNNqpkOIG9qmbFIIQZTml0hw==
X-Google-Smtp-Source: APiQypIV9W4VqbD706RMPBHoU3J0Rlm8JP6X6d8XroY+EFRoHlJmbkNUXElgZMdBHJXnifk4YaIgVA==
X-Received: by 2002:ad4:53a2:: with SMTP id j2mr4489976qvv.159.1588967919686;
        Fri, 08 May 2020 12:58:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 66sm1844186qtg.84.2020.05.08.12.58.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 12:58:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jX98o-0002a3-Lx; Fri, 08 May 2020 16:58:38 -0300
Date:   Fri, 8 May 2020 16:58:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>,
        Mark Zhang <markz@mellanox.com>, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH mlx5-next v1 1/4] {IB/net}/mlx5: Simplify don't trap code
Message-ID: <20200508195838.GA9696@ziepe.ca>
References: <20200504053012.270689-1-leon@kernel.org>
 <20200504053012.270689-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504053012.270689-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 08:30:09AM +0300, Leon Romanovsky wrote:
> +	flow_act->action &=
> +		~MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_PRIO;
> +	flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> +	handle = _mlx5_add_flow_rules(ft, spec, flow_act, dest, num_dest);
> +	if (IS_ERR_OR_NULL(handle))
> +		goto unlock;

I never like seeing IS_ERR_OR_NULL()..

In this case I see callers of mlx5_add_flow_rules() that crash if it
returns NULL, so this can't be right.

Also, I don't see an obvious place where _mlx5_add_flow_rules()
returns NULL, does it?

Jason

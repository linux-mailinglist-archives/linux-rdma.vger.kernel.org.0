Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A566C14AB51
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 21:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0Uw0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 15:52:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38146 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0Uw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 15:52:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so11109523qki.5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gk9lbHIbF4ruLMASy868oJiRnRFS+EC5zu3JSNgTKBU=;
        b=HD4qfGUFDpCPtpWgYlgN4Gtu03lWC0Y8WwEgRej9r/+KRC9XJ25773PFvwNYI5Q+r7
         ZsV0NvryTso2wGM7/mJI7oilWCUa/vi3S/+NLphJPiu6tZItj3dHCkD/xSo0PvznOht5
         TBYyAffaK+dMa69VRkexTLaheCTijPMG6yEC+Nnp3hjDxlXRctREDjaEJtfDst9e5ibr
         IlhZDH7s2Eb7BoRsNGZD9DgO4WCzccm95/XE12Y4xZKdOEhFyyoM/LDtxk7xf+X3DzGZ
         AE8sr9v3kVDiqoByJ964ftkQWVQ+Ff9v+tQz+HBbVXJqEe8Ntsj25SVTSoU7UprFCUjH
         MQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gk9lbHIbF4ruLMASy868oJiRnRFS+EC5zu3JSNgTKBU=;
        b=JEMFfJmemE9ept1UH62LQ11ILhDElctVh6MNsN7CDVu7U0xgXJFczLnhXGQQSiFCEp
         4TVpKacUI+gtr5Zsiw245eUKThAa9Dg6C0+IsT7Z3YrdlLcYpFOivKj1jIPm7Ss/RP/4
         XrxoYpw8TX6WKVEWdRYnzJXXnGFnVF9ifIR1WeZOamtZf/aQzqnFQ56vu93GmshBXiJ5
         2EIbmrGBUkqrR2gS//aprNH1Gps9uehbj7wqHemfNNpEhFqwXiC9CtxOcYjICFxanc32
         DuEU6Q6LFvftLb2dAPjgl6xMhn7avAXmXUdgnEX9GiFK+800CsDnittHf4wURGG8QxMg
         UipQ==
X-Gm-Message-State: APjAAAUJhB2DxjEEZuQttrdqFeiOiFrjtyK0S7BJBSMog0YwL6nUF6cO
        3F05hRhYw6ANmYjFDC2yjQ12TA==
X-Google-Smtp-Source: APXvYqzN90rWYg07u8isMWeQFY9MXk6dGm/HvN6MG87xpTwUX+yr2wRbGGXgw3H7sRooNmbokegCAw==
X-Received: by 2002:a37:2e43:: with SMTP id u64mr17288417qkh.387.1580158345417;
        Mon, 27 Jan 2020 12:52:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 65sm11200968qtf.95.2020.01.27.12.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 12:52:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwBMt-0005vF-U8; Mon, 27 Jan 2020 16:52:23 -0400
Date:   Mon, 27 Jan 2020 16:52:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] Rename variables in mmu_notifier.c
Message-ID: <20200127205223.GA22694@ziepe.ca>
References: <20200116163945.26956-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116163945.26956-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 12:39:42PM -0400, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Linus has observed that the variable names here do not make a lot of sense,
> revise them as discussed so the file has better readability.
> 
> The new names are:
> 
>   struct mmu_notifier_mm -> struct mmu_notifier_subscriptions
>   mmu_notifier_mm or mmn_mm -> subscriptions
>    The per mm_struct memory that holds all the notifier subscription list
>    heads and interval tree
> 
>   mn -> subscription (of type struct mmu_notifier)
>    A list based subscription to notifications
> 
>   mni -> interval_sub (of type struct mmu_interval_notifier)
>    A VA interval based subscription to notifications
> 
> I had originaly thought to also change the struct names, and while they are
> not ideal, it seems that the resulting tree wide churn is probably not
> worthwhile considering the size.
> 
> This is intended to have no functional change.
> 
> Jason Gunthorpe (3):
>   mm/mmu_notifier: Rename struct mmu_notifier_mm to
>     mmu_notifier_subscriptions
>   mm/mmu_notifiers: Use 'subscription' as the variable name for
>     mmu_notifier
>   mm/mmu_notifiers: Use 'interval_sub' as the variable for
>     mmu_interval_notifier

As there has been no comments, and Linus was favorable to the first
patch, I will go ahead with this during the merge window on the hmm.git
Thanks

Jason

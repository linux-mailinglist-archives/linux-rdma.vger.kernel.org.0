Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24439B50E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 10:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFDIob (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 04:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDIob (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 04:44:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01767C06174A
        for <linux-rdma@vger.kernel.org>; Fri,  4 Jun 2021 01:42:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c5so8430426wrq.9
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ME7R43Oz5qvoJp6XLHw2SaFOz7wVkh76dKe7RVe8Kk=;
        b=jGd6DqWkaAWksWxsZRh6WUWPRk3a2bZZ0wx3zTLf6N7R2y/VxNEItQtvFvN186iMzz
         nmywnenM+OUbGDr3Z8q10FpW0MbxFJIWqr0pp95rjYzFWyxHaHwbOKwstf5X+fKUowFT
         AYJwv3pkPMEHFf+veSdWRZQucvLGB5e1nQspXD2rX1C/ZBJCtLbMXEe0CS01R0uWEdq1
         DjikTt0KB948De2dwDvddMb/92zDi8WT8yDJi9fOYKKnMzuJ4uk3yYPTWgf/KdBROAwV
         Qkc+4KqoVQ4RVvlfy3syQt7OouZYgdSziPIYpt39MyoqZA/IUDJWOYoPPs0FgHpM0Xex
         Tl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ME7R43Oz5qvoJp6XLHw2SaFOz7wVkh76dKe7RVe8Kk=;
        b=jvKMHc0jlaqpl0gE0m4pdmFgU6zND9QoLwEPFC1jX7/aIinO2Q5R+O4miuvgd8zZ25
         aWuIQ9BxuXnmMdgauli285A0PDfqMllSeOvyGizBatmOY/1PH46F7Z7tyVa/6kKZDmf2
         apBASNadb+/1/xghlXp9FCE+aw39t6iIrrlVMwX+lFSYcLMHkU+zL+X3Aq02KuXOe5v1
         kzHKlgMeLQQ5a/X3lFdAWaRUuUCM6VgYI98wl0yJb03pEAJYT3QPPsmm1WbQ/MWjjie5
         UUfyVaM+pnmi7H513+t7SPf5KtYVUseqge3/URYQ3YFkxQJ+AzYaJMEaY2bPAWdxgPB9
         mT2Q==
X-Gm-Message-State: AOAM531B4oMTwrxsGAlYEFCtFssXWP+ks9r2Ry9Ymb32pqala+kRO35s
        GtRzN991TO6K7+WHZIVdOv91dg==
X-Google-Smtp-Source: ABdhPJwT0iLGy4GahWXsBrb/ZUXTrcFjw0HS6AjuXuDy33BtBTbeiZ1SKyP9A/rNEyzBpTpFBQ5Alw==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr2648602wro.37.1622796146844;
        Fri, 04 Jun 2021 01:42:26 -0700 (PDT)
Received: from iliass-mbp (ppp-2-87-186-192.home.otenet.gr. [2.87.186.192])
        by smtp.gmail.com with ESMTPSA id l16sm8290772wmj.47.2021.06.04.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:42:26 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:42:17 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Subject: Re: [PATCH net-next v6 3/5] page_pool: Allow drivers to hint on SKB
 recycling
Message-ID: <YLnnaRLMlnm+LKwX@iliass-mbp>
References: <20210521161527.34607-1-mcroce@linux.microsoft.com>
 <20210521161527.34607-4-mcroce@linux.microsoft.com>
 <badedf51-ce74-061d-732c-61d0678180b3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badedf51-ce74-061d-732c-61d0678180b3@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[...]
> > +	/* Driver set this to memory recycling info. Reset it on recycle.
> > +	 * This will *not* work for NIC using a split-page memory model.
> > +	 * The page will be returned to the pool here regardless of the
> > +	 * 'flipped' fragment being in use or not.
> > +	 */
> 
> I am not sure I understand how does the last part of comment related
> to the code below, as there is no driver using split-page memory model
> will reach here because those driver will not call skb_mark_for_recycle(),
> right?
> 

Yes the comment is there to prohibit people (mlx5 only actually) to add the
recycling bit on their driver.  Because if they do it will *probably* work
but they might get random corrupted packets which will be hard to debug.

> > +	page->pp = NULL;
> > +	page_pool_put_full_page(pp, virt_to_head_page(data), false);
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL(page_pool_return_skb_page);
> 

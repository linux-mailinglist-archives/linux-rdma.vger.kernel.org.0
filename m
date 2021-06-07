Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4C39D412
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 06:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhFGEiI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGEiI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 00:38:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E155C061766
        for <linux-rdma@vger.kernel.org>; Sun,  6 Jun 2021 21:36:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6501853wmc.1
        for <linux-rdma@vger.kernel.org>; Sun, 06 Jun 2021 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9T5pBSugoXfUpXUjZ5j/66j/njzDcDs53OE8tdEeqg=;
        b=dsbm6ZaentwbYXK1/AX02BUJNveYH454Bc8Hxkr7AuBiVrsN0BwXTGFy2clCJ3Jnaa
         GVTrl601GfVuELPA/rENvBHO99Cy1m2KaZ8VVysBjujsFon1u+rGpWWuuR4VVwcognXg
         jUSks59gR0/wnezCcElQ23S/7PPhUz0TUqPnzHreb7oT4TLB53lh5OGwuENgESqfyNk9
         5CU7WXl0wn1KyvZr8sZisHG+5yxfr5M517OOBXZfBORui+ZBnTIaPD3UV1Q6xzY+ZuLv
         WuD/vIzz5AylzaeEZmgBpvTFNQi4ZGVNTBgD+VEAaB41Pi3aX25tA3hGs7PgBHFLI4rg
         kL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9T5pBSugoXfUpXUjZ5j/66j/njzDcDs53OE8tdEeqg=;
        b=cMsNpfgLhNJjIAcgY63bKHc5la61kyYcJ0VKO84haALUvgGwpl/2k8pR6VfLr80BNJ
         WSw2DQHP7qtS0yuoPnnNjzLchxq9h7tEoLSxdd7vgvurj3tz1Vq43e6uBpDWerZt2jac
         eIc1N1hzQmUfvsAR/vuHIpdAJ+XgeQeqVIovH0wS6ma73r/H2RvBasSrT9/1VDiOLD2H
         rTRhRUZWqZs6J6oNuoeN+cMpMcS+IUvncSxZlCZ4dLCq6waF2YUxYMzDNnWbtLpBePTa
         MlkZrWLfwl5xVO8hX+i8r7DrXgKAS47U44mYWkwFd8/RCB31bmQVN45kARhczQBhP/pO
         /JUg==
X-Gm-Message-State: AOAM530iG31xeRxzbxv+0C1VpXkPdSgxLDZKMypMbXf2dmmTindPdWW7
        TEF+knH36B+cp8nH3NQ+lttuiw==
X-Google-Smtp-Source: ABdhPJznwN3/xCvknr5BYPh40gyjYOCnx/fab+dzKNlPRZ8IkCnKQnH8Vp5zlcA8IQx74ttZF0sDKw==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr15287383wme.154.1623040564231;
        Sun, 06 Jun 2021 21:36:04 -0700 (PDT)
Received: from Iliass-MBP (ppp-94-66-57-185.home.otenet.gr. [94.66.57.185])
        by smtp.gmail.com with ESMTPSA id o17sm13829115wrp.47.2021.06.06.21.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 21:36:03 -0700 (PDT)
Date:   Mon, 7 Jun 2021 07:35:58 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        Ayush Sawal <ayush.sawal@chelsio.com>,
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
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Subject: Re: [PATCH net-next v6 3/5] page_pool: Allow drivers to hint on SKB
 recycling
Message-ID: <YL2iLpEp826o81Bp@Iliass-MBP>
References: <20210521161527.34607-1-mcroce@linux.microsoft.com>
 <20210521161527.34607-4-mcroce@linux.microsoft.com>
 <badedf51-ce74-061d-732c-61d0678180b3@huawei.com>
 <YLnnaRLMlnm+LKwX@iliass-mbp>
 <722e5567-d8ee-228c-978e-9d5966257bb1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722e5567-d8ee-228c-978e-9d5966257bb1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi David,

On Sat, Jun 05, 2021 at 10:06:30AM -0600, David Ahern wrote:
> On 6/4/21 2:42 AM, Ilias Apalodimas wrote:
> > [...]
> >>> +	/* Driver set this to memory recycling info. Reset it on recycle.
> >>> +	 * This will *not* work for NIC using a split-page memory model.
> >>> +	 * The page will be returned to the pool here regardless of the
> >>> +	 * 'flipped' fragment being in use or not.
> >>> +	 */
> >>
> >> I am not sure I understand how does the last part of comment related
> >> to the code below, as there is no driver using split-page memory model
> >> will reach here because those driver will not call skb_mark_for_recycle(),
> >> right?
> >>
> > 
> > Yes the comment is there to prohibit people (mlx5 only actually) to add the
> > recycling bit on their driver.  Because if they do it will *probably* work
> > but they might get random corrupted packets which will be hard to debug.
> > 
> 
> What's the complexity for getting it to work with split page model?
> Since 1500 is the default MTU, requiring a page per packet means a lot
> of wasted memory.

It boils down to 'can we re-use the page or is someone using it'.
Yunsheng sent a patch in earlier series that implements this with
ref counters. As Matteo mentions we can also add another page pool type.

In theory none of those sound too hard, but we'll have to code it and see.

/Ilias

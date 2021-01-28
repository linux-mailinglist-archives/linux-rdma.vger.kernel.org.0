Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7333C308192
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhA1WzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 17:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhA1Wwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 17:52:45 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279CEC06121D
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 14:49:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 31so4175787plb.10
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 14:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=G+ih4TCLjMlDhHUsK2A+TR2HHdkm5AqUa1C6G/BSwSU=;
        b=MtFfpkPTsZTn0gFaHxFhSWOMva66E/lvz+hUXR3FrCHa9T0vjY+xbhdIBytnfT4hde
         0Ys5AJYDByRiNPKT0aWC33/ZwpGaEnDVdDZLHxgNhDamHGH+rUdr/YNIrHzbogxyK2ot
         0DoGbhkKgR6CODspeFMH0JINuzKgti7159D7tR9XKwR9K09g/4AR5nAIex+fNblniZwf
         nuLbHpvajXVngPXWUmYWJr62ll4sVI6GL9+9DOw2ps6euNFMlJMMKUqLwUBvfOr4+JOI
         dE/ui+K9GxRvn1sNUBZjR8TFkXXLIPq75nHYRfA916R0qHMnMt7BOLu7EI21THYWQnjm
         aX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=G+ih4TCLjMlDhHUsK2A+TR2HHdkm5AqUa1C6G/BSwSU=;
        b=gqgyD1qAvwu3SOHPSFWlMx84GEbflnyhPTAJOyOcPHudTExQoEYbpfZTSIH6ZdOk6h
         bUcjib/dsaF87pR7AvprTPnH3FVLUAlXVKMFc9k9Zo2KcvhweUX83b/vedeJFQYnyYuH
         /ZdcweX/mYgSqRG7uTky0lPTGE6KiEayGuas6jb3emnnn5TTugwMMXOEVtL9wBac4Ots
         QeNeKWxeZ+FZC7JsDoyzpYhFGRe5nIb6R1/JpCYXSAiDRwqInLNWQP/BcQtHIlbk7kl/
         pykhc6x6WR3eEzHVMt1vm7qLoXgjpXRPfM7QLqgKU+aKFyCKRLe08EAuaFhHHWiIIiNS
         /PYA==
X-Gm-Message-State: AOAM5301UnMlpIQFW1cwPkIoO6CglsT1ZRLfLBXXkYUkll3vWmRqOIO1
        kfg/PIMBypMxn68/TxCwc3wLAQ==
X-Google-Smtp-Source: ABdhPJyfRuzHyqHVdqBK8f0+yDGR+PAfYB5Dc8yFBfd7wqG+BeYIWPtIjMNVkXFepyiH+P/AGil0yA==
X-Received: by 2002:a17:90a:470f:: with SMTP id h15mr1601393pjg.179.1611874169526;
        Thu, 28 Jan 2021 14:49:29 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u126sm6508563pfu.113.2021.01.28.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:49:28 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:49:27 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Alexander Lobakin <alobakin@pm.me>
cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 net-next 4/4] net: page_pool: simplify page recycling
 condition tests
In-Reply-To: <20210127201031.98544-5-alobakin@pm.me>
Message-ID: <7ac4064-b63-b26f-10db-68b83e6d4c6@google.com>
References: <20210127201031.98544-1-alobakin@pm.me> <20210127201031.98544-5-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> pool_page_reusable() is a leftover from pre-NUMA-aware times. For now,
> this function is just a redundant wrapper over page_is_pfmemalloc(),
> so Inline it into its sole call site.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: David Rientjes <rientjes@google.com>

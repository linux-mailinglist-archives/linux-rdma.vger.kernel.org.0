Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C0308155
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhA1WqE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 17:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhA1Wpr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 17:45:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC94C061574
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 14:44:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so4981782pfk.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QyEif4VyZcju9R1mKoD/tD54DKRTJWeE0Dgl2QjUm3c=;
        b=E26b/trYarb6KK70wmR2E+OJdxnTogS0ETGiS4abIvOyQHhJ8LxMz2KTBkXLCM/Ivv
         Z38c7DceiM9rPWg4EbbGD6Ndc94tPNlIyO57WDIxZs4kdZgV97NjdGB3o5Yc6EYFHBS+
         U3hVoCrWKgtF8D8GyAEm5f79ee+yC8aG/DXgUbcf3HYHiFYYUQ5CGmnWh76CpA+C7kdh
         3v+fSEyuTVwNSc1mPIqvneBw0dEwM3GsCF44182C+FnDx+qf6IugERbk0zPFcebbc2bV
         8l3NyThctWYb7ePNlX/3tABBo7cx0nuwxSgaikbyDSHp2llydDsZu3tdNCYcUtBzOvvy
         Y1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QyEif4VyZcju9R1mKoD/tD54DKRTJWeE0Dgl2QjUm3c=;
        b=j1R9NDTTLOq0XMR9JXL1kR5i1/Fh5o2SZ96eTzIFmtaLKgB2fCwbE6vcgMQa/88mNY
         vnxFcBIJsUnZp2Rc2E0kC29R2U3NiXF1Fd56+mcVOL25cB35QUNnF0tuP62It4VQqYlx
         NqSq71EhVrrmEw+BtxwT1bfOftr5NTnqdifbPtlWoZa4uZigDi3lPr7AL/V69T94+++U
         QA9h1Nbu4lLyLIJbWuhWsCRi97FbIV02HJPnKvJbKtTKCuUDNjlsuanbXZCADhb/cNMF
         TVadzX2YGFX5VI7qbDQ7F3BbDlG5K0kTGQuY6IIIdtxkY+DWu2kj9b0BNVxGcAP9uCXL
         CNmw==
X-Gm-Message-State: AOAM531O1FqX4h5J+T8k9HWmBSBO9gHna9fYcyqhpymxls+o/LRXMDpR
        nFV1LIdNOrENLRui17AMlK/QNQ==
X-Google-Smtp-Source: ABdhPJwWaYtvgJm8E+ti9h4XRgK7o9llC19o2oBo8G1fBLSQVe7N3WjmyzApdRZlT+yP8f2GiPEGsw==
X-Received: by 2002:a63:2259:: with SMTP id t25mr1530428pgm.395.1611873898388;
        Thu, 28 Jan 2021 14:44:58 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 6sm6490348pfz.34.2021.01.28.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:44:57 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:44:56 -0800 (PST)
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
Subject: Re: [PATCH v2 net-next 1/4] mm: constify page_is_pfmemalloc()
 argument
In-Reply-To: <20210127201031.98544-2-alobakin@pm.me>
Message-ID: <cf211a78-7ce7-90e0-a589-1eb0bdc44222@google.com>
References: <20210127201031.98544-1-alobakin@pm.me> <20210127201031.98544-2-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> The function only tests for page->index, so its argument should be
> const.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: David Rientjes <rientjes@google.com>

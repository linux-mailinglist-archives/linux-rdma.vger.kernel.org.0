Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF175173C9C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 17:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1QNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 11:13:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44304 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1QNU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 11:13:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so2356565qtr.11
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R1Xp5z4IUf6G1vHLZoG1hWUevGGwXKZ9fUZ9OSwOtLM=;
        b=BgvVr+DVgB8/kFOoMR+wsj7MFWCeJMA14VgM9c4OO3APY2uziFR0rR6HQ3leYijal9
         PWB0lNnLyCW7dSUkpKjcTEdEQeHvwbceHobYQLyWLCpIjJM8TCYo6y1d46eMJQuGZt2y
         qbG2gbQqzYhULLqpu9CPDCZuSdwvx2pkp6caGbJuFeiI1aUqrX2CQu/J7LqBcvyNdwjl
         NxqT7bthYIwTmjc4V0jkAv3bVl2Y3G0mNBoswD5llB6KCCx3MM6EVnlEmWi4xG9vu0D8
         /FmdVGgUTl9ASyIGFiRkYfTz8j2WvhVO82Um2L4FPU4XQ0Fdv9f6oxyZrzNmRxbV/GmB
         qEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R1Xp5z4IUf6G1vHLZoG1hWUevGGwXKZ9fUZ9OSwOtLM=;
        b=tuU1ipER6i8NjgZ2AzQLqpskvs4BJpAEcg2MEU5wLaBB7EAraHr2if26goY1i0Cn9S
         1kctQhU7ro4XZBJuHu38iSs3Um+PScpCPT2fM3i+W2Bt2x9IUlWikft+JnwT1u7xAJAg
         59KcKuKraQfJdPWAoZavtHtxUNpZ3G5P7UWQJdP2S7siKEKTKMaf2TktjmjsxtAIL4BP
         tjORHm/XxQewIgPa+ygKxzHDpDakBGbMPBOoIlwhQTXxCEeDL7T3rmh76dhUCFOLrRgJ
         a3z+jEL0MRbbTFWt7NiDrfLo3l727WFtC6dJEZzavxUXVnvZEWFra0mjhpTCUNJQY9B6
         6xzA==
X-Gm-Message-State: APjAAAXr2EKN9wMf3ijR669SCvZrCfhbEtqdRpjJeqRrRsJEPYF5BsOL
        paf0XHzZ7xhCnY9qb71CIdrMFw==
X-Google-Smtp-Source: APXvYqzTX/9gopc4Es/bA3EHhFbXR5rPIDwNPQCQkv5818UovexOMCtnZclaMPaa/EAAwjeUaqXwIQ==
X-Received: by 2002:ac8:554b:: with SMTP id o11mr4880298qtr.36.1582906399462;
        Fri, 28 Feb 2020 08:13:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x23sm5153672qki.124.2020.02.28.08.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:13:18 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7iGM-0005T3-Ee; Fri, 28 Feb 2020 12:13:18 -0400
Date:   Fri, 28 Feb 2020 12:13:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next v2 0/3] EFA updates 2020-02-25
Message-ID: <20200228161318.GA20969@ziepe.ca>
References: <20200225114010.21790-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225114010.21790-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 01:40:07PM +0200, Gal Pressman wrote:
> This series contains various updates to the device definitions handling
> and documentation.
> 
> The last patch is based on a discussion that came up during the recent
> mmap machanism review on list:
> https://lore.kernel.org/linux-rdma/20190920133817.GB7095@ziepe.ca/
> 
> We no longer delay the free_pages_exact call of mmaped DMA pages, as the
> pages won't be freed in case they are still referenced by the vma.
> 
> Changelog -
> v1->v2: https://lore.kernel.org/linux-rdma/20200114085706.82229-1-galpress@amazon.com/
> * Use FIELD_GET and FIELD_PREP for EFA_GET/SET
> * Make sure to mask (clear) the field before ORing it with a new value
> * Clarify the commit message of the last patch
> * Reorder the cleanup in the last commit, entry removal now happens
>   first
> 
> Gal Pressman (3):
>   RDMA/efa: Unified getters/setters for device structs bitmask access
>   RDMA/efa: Properly document the interrupt mask register
>   RDMA/efa: Do not delay freeing of DMA pages

Applied to for-next, thanks

Jason

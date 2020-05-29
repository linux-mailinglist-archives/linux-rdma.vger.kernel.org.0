Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62591E8BDE
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 01:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgE2XYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 19:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2XYx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 19:24:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD7C03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 16:24:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so3854054qkn.8
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGBn/AuzNZpYdh5SlPF2DkI93ztTCm2iyZ9aPkUohiY=;
        b=IKwS+7d7WuYKZu+Q4GbtHw2D0LkjSL5A7lbo392iOd2v43Z52P0dFEEYFCiMEnQ/56
         qHXRFTF3iYnEeR12Gy6AN1N5Ko5uNF6SGa8LgjOUNf8ofjtnodQ2Wa/NwtsqJSS9TAys
         Gg2F/FQkn7AKIU6PXRK/IbsFEIAuxiMa6Q3VFGdqW0PKTMO71Ulqc96eqRatHrZT+job
         CmB7I7tKfzmPXdiHFwtNNVdIZthAMoYLj8buxmbD42FxW/NSzvPxiyagJjl2OyvsdhpD
         S5MOG5N3YQf1bbr8iJo0die/KuV0BMoW3Ysy/3VNSMrpD8wNAee0a8qz06MN/4Fpt6fO
         lZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGBn/AuzNZpYdh5SlPF2DkI93ztTCm2iyZ9aPkUohiY=;
        b=Ve09EBcUnnBOBaSgztX3MGIaFfXmLEHnhEBEGcCYt7uiCGqo0sDEpVmNnm1ei7Z2fN
         trO1tRy78Aev4opxBm9rcNj7iG9earA+vv6IyY9Kklo3+AYLoL9DrBmPp+xzm5wyerOS
         1ecU/LjjFMrpM5kFvwnsDPph5OSkfi8kSumirfWD4PgjmH/xGJhlfbZgWk6bCBIJ5Ku2
         FaNsgDaQVUlRA3v7zc6OWiRitGZ1TI9GmHY3CRgr3iJHsKRJsWP1OsviuZhkGukQu1Dm
         mOPCD8SJGb4B2c/pPn/5icOwdWCNqgG1RWF7OrQwESN/cKbX9XTmfL8Xf1NqF3T3T/k5
         3K7g==
X-Gm-Message-State: AOAM530lVmXm75+RxpPtrtFf8WQpzLNDblPr01IU7ViPonYKfm9OuqLv
        VyEU8t9XD6rapK4mbgk6hotVYg==
X-Google-Smtp-Source: ABdhPJzKrllspgHFufnfAlSPKJ28Ce9a8Ik5xQzMRPQlXECpMQP4AXzw/tDE7D+9+tIgrQIxQDZLBQ==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr10189193qkk.214.1590794691029;
        Fri, 29 May 2020 16:24:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h19sm3668912qkl.49.2020.05.29.16.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 16:24:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jeoMr-0000gH-PQ; Fri, 29 May 2020 20:24:49 -0300
Date:   Fri, 29 May 2020 20:24:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>
Subject: Re: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
Message-ID: <20200529232449.GC21651@ziepe.ca>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200525134118.GA2536@ziepe.ca>
 <4743ec6e-a5a0-16ac-a1b8-992f851515f0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4743ec6e-a5a0-16ac-a1b8-992f851515f0@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 10:32:48AM -0700, Ralph Campbell wrote:
> 
> On 5/25/20 6:41 AM, Jason Gunthorpe wrote:
> > On Fri, May 08, 2020 at 12:20:03PM -0700, Ralph Campbell wrote:
> > > hmm_range_fault() returns an array of page frame numbers and flags for
> > > how the pages are mapped in the requested process' page tables. The PFN
> > > can be used to get the struct page with hmm_pfn_to_page() and the page size
> > > order can be determined with compound_order(page) but if the page is larger
> > > than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> > > using a larger page size. To be fully general, hmm_range_fault() would need
> > > to return the mapping size to handle cases like a 1GB compound page being
> > > mapped with 2MB PMD entries. However, the most common case is the mapping
> > > size the same as the underlying compound page size.
> > > This series adds a new output flag to indicate this so that callers know it
> > > is safe to use a large device page table mapping if one is available.
> > > Nouveau and the HMM tests are updated to use the new flag.
> > > 
> > > Note that this series depends on a patch queued in Ben Skeggs' nouveau
> > > tree ("nouveau/hmm: map pages after migration") and the patches queued
> > > in Jason's HMM tree.
> > > There is also a patch outstanding ("nouveau/hmm: fix nouveau_dmem_chunk
> > > allocations") that is independent of the above and could be applied
> > > before or after.
> > 
> > Did Christoph and Matt's remarks get addressed here?
> 
> Both questioned the need to add the HMM_PFN_COMPOUND flag to the
> hmm_range_fault() output array saying that the PFN can be used to get the
> struct page pointer and the page can be examined to determine the page size.
> My response is that while is true, it is also important that the device only
> access the same parts of a large page that the process/cpu has access to.
> There are places where a large page is mapped with smaller page table entries
> when a page is shared by multiple processes.
> After I explained this, I haven't seen any further comments from Christoph
> and Matt. I'm still looking for reviews, acks, or suggested changes.

Okay, well, we reached the merge window, so since there may be some
conflicts repost again in three weeks.

It would be more compelling if there was some performance data if it
is much of a win vs the 'compute large page' algorithm something like
ODP uses.

Jason

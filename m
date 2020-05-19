Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E241DA14F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgESTum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 15:50:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81703C08C5C1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 12:50:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d7so626340qtn.11
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1V3Tgw02jIXDbVJ9iD00NVCbfLIhXJCqqu7R58D3Ic=;
        b=hyGaM1XtP9QcE4gMqttRjlKiSby43ALZhvaUIG1a8HKnQF+bmay6tolp4kdZvK+56D
         p1u1oAFduyBAF9zrTldnPdlWlY6zBI9z1PVy+50BBc1hWiSoXee3ylMEmngDCmARnEdK
         bMqVMPDifjogTsiAWgLrrma6FxDziVpivAhTydfNxU+jYDsskTwEkurXe7cti8cjv0NB
         CwtJuNl0fg+MHRx+zkm67jQvVatY6N87BEj60z2f6rzSJpC3Ay+t9RSLqnYNPER9fqP8
         qBfkgE4g4zZs6eUpreiQEwNlBErJnP+3ipDt70Mwk3WihQ4ovLCECy53ex0aWXEZalOc
         nd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1V3Tgw02jIXDbVJ9iD00NVCbfLIhXJCqqu7R58D3Ic=;
        b=gigKJzemJCuyX/XPH385uU7IWOWTDmdQUfwmSJ/2+fuFqL2in20qvkaI9siK5tX7B4
         I13k8vMnE7Mn2pC2wn/rUAlXbIznTIB1MjCAZA03eQ8P38XzFnX99oWYZJ4HgK467IgA
         6tHeVloiF5lmRi6ZtxXGMBptDlWGmNCmzXwtuixjBY4PWmnMse9EhBa3WZ0TBBhwJY0s
         F+vGKX3a4NUlQiccyszHztI8pycbioD/6TOHHiEqFRN6cvv56MMIe3JlwO3Dj0O7HoaZ
         nOzhMPMhx++ImYs+J4YR4aug1ztmUN2ckFPnmDeqS4XuOYaeQf8PQrgPyiPbq4HkPGjB
         S3pw==
X-Gm-Message-State: AOAM532gFNGx2zMbmPFfydU50WTEXv1mscCISdWHxnWPeydPx54wdpjT
        BUvoglDPIx6BDqOP16+E8uh6HQ==
X-Google-Smtp-Source: ABdhPJy6JaIffKHbVZ/MvpPZNVvqEHP/VC9PD5c8cyUebyj+n7SZYQ9s4TSklbNNVWZyIyp3I3uKAg==
X-Received: by 2002:ac8:2979:: with SMTP id z54mr1666184qtz.14.1589917841631;
        Tue, 19 May 2020 12:50:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q17sm414087qkq.111.2020.05.19.12.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 12:50:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jb8G8-0007fQ-Lk; Tue, 19 May 2020 16:50:40 -0300
Date:   Tue, 19 May 2020 16:50:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] mm/hmm/test: use xa_for_each_range instead of looping
Message-ID: <20200519195040.GA29444@ziepe.ca>
References: <20200516010424.2013-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516010424.2013-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 15, 2020 at 06:04:24PM -0700, Ralph Campbell wrote:
> The test driver uses an xa_array to store virtual to physical address
> translations for a simulated hardware device. The MMU notifier
> invalidation callback is used to keep the table consistent with the CPU
> page table and is frequently called only for a page or two. However, if
> the test process exits unexpectedly or is killed, the range can be
> [0..ULONG_MAX] in which case calling xa_erase() for every possible PFN
> results in CPU timeouts.
> Use xa_for_each_range() to efficiently erase entries in the range.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> This patch is based on Jason Gunthorpe's hmm tree and should be folded
> into the ("mm/hmm/test: add selftest driver for HMM") patch once this
> patch is reviewed, etc.
> 
> v1 -> v2:
> Use xa_for_each_range() instead of special casing [0..ULONG_MAX].
> 
>  lib/test_hmm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I squashed this in

Thanks,
Jason

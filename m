Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D5219FB7
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGIMLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgGIMLZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 08:11:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF03C08C5CE
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 05:11:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so1552208wmh.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76Pr5Imry6Y6+NQUV46pzWGDfBUpjBEUH8MLbXYDtq8=;
        b=PoAXES+V23Wh8eM1RMa1gjv7mPdB9CHvXYOhFE06xOw/lMwbG/HZ53PABoY8YaxIgs
         /ROsDCtb7CcSWl99Acc2lIZyw7vhas2ZIGL3Ki1AJDgM2rGMRUCDI/AexHfuV+OrjnL9
         topSv19nW8QIm2JsuBwLzSSpnHvj8hrxQXpLFQxSMcLqXF+fDV3ORupMLNE5TMh+r0OA
         Trg8XRN/fVokthVccXXppm7BJJEK3Jz9QMSYfIc/fW3D04yKmMZTU52iAFdp/4EmW3zi
         HGAW53jITOccHxT8InC62n+akeJnp3riy7+EacBJAzuqWSCYVf+xDufoR7bXUJg6y/oD
         z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76Pr5Imry6Y6+NQUV46pzWGDfBUpjBEUH8MLbXYDtq8=;
        b=Bqpr5zkTrSWUPF+cZuas05N3tGprEugMKZXKth5Qz3XGc4SIkGh0xg2ZRF9fVQg0Hb
         Cqgn3rd8I7WpNKdwaii0r8WceFmWaBG79XKCVR4fsZV4qeODtThmdHM0uUSBeUDd4HBJ
         X/ebZbZRwYyG0eU74uL1Glh6e8RB6RahABJ5BNHxnfe2Ju9CPIF/s1+qOrT95Sj7o+TC
         UnPg5D7DKLADJ5/h/XE5tFUQBj94axAIg+furL/yGUuKwIn+D0bMknbOFERogsXl3FiT
         +EXKKLHqDLPYioxqby+WlyLugF/gHFEZ5uCttW+79jVhzaWPZi++GtV8LghRJDCdWWxO
         DsYg==
X-Gm-Message-State: AOAM5325kOImW2XWPyy1TWdJTLDU/N9j3m9S172bzrDBHDY2IKiXxpj0
        jsjFk1dWJFgCOoOTsZjRlUA3bw3NElwlLv1At7DJBA==
X-Google-Smtp-Source: ABdhPJxv2bOOBtwBiOGYgL5OIERVoKiGIkkOEtt5HovOBMNjbTSQatsMIYv39pPFy2HfkEl1IbeCaLvATVq/PpV25+k=
X-Received: by 2002:a1c:bdc3:: with SMTP id n186mr13815672wmf.84.1594296683336;
 Thu, 09 Jul 2020 05:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch> <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
 <20200709080458.GO3278063@phenom.ffwll.local>
In-Reply-To: <20200709080458.GO3278063@phenom.ffwll.local>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 9 Jul 2020 13:11:12 +0100
Message-ID: <CAPj87rPtD04099=sBzL2jKN6NNFNnM-hH3qfOLL10nPoF==VbA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 9 Jul 2020 at 09:05, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jul 09, 2020 at 08:36:43AM +0100, Daniel Stone wrote:
> > On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > Comes up every few years, gets somewhat tedious to discuss, let's
> > > write this down once and for all.
> >
> > Thanks for writing this up! I wonder if any of the notes from my reply
> > to the previous-version thread would be helpful to more explicitly
> > encode the carrot of dma-fence's positive guarantees, rather than just
> > the stick of 'don't do this'. ;) Either way, this is:
>
> I think the carrot should go into the intro section for dma-fence, this
> section here is very much just the "don't do this" part. The previous
> patches have an attempt at encoding this a bit, maybe see whether there's
> a place for your reply (or parts of it) to fit?

Sounds good to me.

> > Acked-by: Daniel Stone <daniels@collabora.com>
> >
> > > What I'm not sure about is whether the text should be more explicit in
> > > flat out mandating the amdkfd eviction fences for long running compute
> > > workloads or workloads where userspace fencing is allowed.
> >
> > ... or whether we just say that you can never use dma-fence in
> > conjunction with userptr.
>
> Uh userptr is entirely different thing. That one is ok. It's userpsace
> fences or gpu futexes or future fences or whatever we want to call them.
> Or is there some other confusion here?.

I mean generating a dma_fence from a batch which will try to page in
userptr. Given that userptr could be backed by absolutely anything at
all, it doesn't seem smart to allow fences to rely on a pointer to an
mmap'ed NFS file. So it seems like batches should be mutually
exclusive between arbitrary SVM userptr and generating a dma-fence?

Speaking of entirely different things ... the virtio-gpu bit really
doesn't belong in this patch.

Cheers,
Daniel

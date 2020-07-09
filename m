Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF4219A6A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgGIIFD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGIIFC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 04:05:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E573C061A0B
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 01:05:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so1280794wrj.13
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AanOntssHVq3a/hYYgiJ/Jv7xDYr/XO47TZ8dJKYOfg=;
        b=QyjKYLKao++0SSyM8aZCwczNT2pFyNkKc2p4ZpEv62WkcG5eiz8JDGaPiwT0/ggzaJ
         IR6p/K6ncIihYsmMMWOKwTm0qCVQDwj5lpl4+j+HohoTFt1N0thAtJPAhqzP1GKvD0DT
         mDeEZ/WxXGFFx6EGFzPhTWq2CTko4+6fvnpQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AanOntssHVq3a/hYYgiJ/Jv7xDYr/XO47TZ8dJKYOfg=;
        b=PBRMEZKqTOYZK3pCkKXslvlaYUHDbSGEYOjcAYIy03xIQRWUN2s23Q2yfmOMIixFYs
         P4S7UmrdZ2FBEdEf5vIJuks2yrbjVNjCmEvKjixDTU0CmUmxB8d0QqUXiSTj0lwCD14O
         dAzA6NSHG3E7Ag+akWDe+ziYXA5TkVx6G8JGUWPwu762/qamjR/amubedXj2MfUvll7+
         Uk2qx20bd5inIriXZWe6R0qFf7CZmnYGuwlx48cgifM5pCtwUleQKcBQbRKSkbwZMma1
         1RpWOF5Xv39k5Le5yVl44yUzjUQ2qDCdpUDd8l94R7MsjnF1WA6pMmUXdxsgzvQFL+Wj
         HMLQ==
X-Gm-Message-State: AOAM5308A1xNv40Yam1vJMrxJgS/GPaC426t8f5sSSSv5vrmzAL/ZC5a
        WQTX7OiEZ6fUcRlXLyFx6YQIiw==
X-Google-Smtp-Source: ABdhPJxO7RoS+ijbjhDgz9IHsX93bEVBPBQ5YAnvnMKF0T6MTWfNzI57IiCMoHlxMz1reth22NnRpA==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr61603577wrt.108.1594281901314;
        Thu, 09 Jul 2020 01:05:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v12sm4179709wrt.31.2020.07.09.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 01:05:00 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:04:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-rdma@vger.kernel.org,
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
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
Message-ID: <20200709080458.GO3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 08:36:43AM +0100, Daniel Stone wrote:
> Hi,
> 
> On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > Comes up every few years, gets somewhat tedious to discuss, let's
> > write this down once and for all.
> 
> Thanks for writing this up! I wonder if any of the notes from my reply
> to the previous-version thread would be helpful to more explicitly
> encode the carrot of dma-fence's positive guarantees, rather than just
> the stick of 'don't do this'. ;) Either way, this is:

I think the carrot should go into the intro section for dma-fence, this
section here is very much just the "don't do this" part. The previous
patches have an attempt at encoding this a bit, maybe see whether there's
a place for your reply (or parts of it) to fit?

> Acked-by: Daniel Stone <daniels@collabora.com>
> 
> > What I'm not sure about is whether the text should be more explicit in
> > flat out mandating the amdkfd eviction fences for long running compute
> > workloads or workloads where userspace fencing is allowed.
> 
> ... or whether we just say that you can never use dma-fence in
> conjunction with userptr.

Uh userptr is entirely different thing. That one is ok. It's userpsace
fences or gpu futexes or future fences or whatever we want to call them.
Or is there some other confusion here?.
-Daniel


> 
> Cheers,
> Daniel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

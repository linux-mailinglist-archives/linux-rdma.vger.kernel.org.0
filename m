Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C7213AB1
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGCNOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCNOr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 09:14:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7660C08C5C1
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 06:14:47 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so14215648qvj.12
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SkKE2cHtoC6QnB7EIDlRboTvU4UZ4rc7BGA1P56tIu0=;
        b=nZ+KcpPDHexgm357/fqvU7+VQjzGKymeORvN/t8m0kH6EHfmO1djyJo00c4ua/5ZUR
         Vxi3HO97jB8Y983Qs5OAvTD84HUB2LWG8HyPpc1k/sgRad+QwjF48YQDD0RWM4vSA5OI
         3slb8JjUh9DykF6O+OIhDFNxvmIYW3jP/E2Rs8oNsWY7DBvK5cp+VQY8iRzIWtzNn47S
         ONhIqUuf8mKeVNpMAM4AK/m349/G/dL6fLVw6aNxPqc8fYvC8glZw8gt+NvxLoAODtOg
         KnW7bQHrymS6t13M3/qnbuLy5/Dj7nvEEFyN4RZdsF/M/yQTM8pwHuC22ZsIEPThSTSa
         dz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkKE2cHtoC6QnB7EIDlRboTvU4UZ4rc7BGA1P56tIu0=;
        b=YWBZFORfL1fDQjefDDR9m3KrtQrNN6g+eKoo+pdrfHLAbeIM07jqeJP/OiiOlEyeOS
         BwQuTAgJWAc3Bfjdf/OxE1j84gHCo279QAo3x0eS74+Z8M1l3rd1MNK/hgXDYui25dFe
         p5CHoULrFp2HhhcGramkLlVVSowFShKXc0qEQ1MXEG0YVF/scr/rTBmdJnWju63ApvB5
         Oa17Dp7Cp8GykGhEUe5ewDbur7a9Oi7JmMnjBsj6HJwutuGWkszK7RmI3m876pRmd8Aw
         38FfS9/MSwlGTlRVuNMLM6LgYm9bDGQXQC+EyAhh0bFVg1A9SS2omg8/l58xP1lO+f8y
         otsw==
X-Gm-Message-State: AOAM533JfxsqlAaea6pBhx/v9XcBadZjThGgMXTYn5IvbGMtO0IQJQg+
        ncwANUDsDjbuAx4TYlaSoEWm9Q==
X-Google-Smtp-Source: ABdhPJw38gG6c/7THKM9olPhRo8b++3mDeKvGE5brGFyeHdS1AWGt1vvwet3iR7jiA4ulKawpxm2Tw==
X-Received: by 2002:ad4:48cf:: with SMTP id v15mr35835161qvx.101.1593782086787;
        Fri, 03 Jul 2020 06:14:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x29sm11148829qtv.80.2020.07.03.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 06:14:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jrLWf-003aeK-KP; Fri, 03 Jul 2020 10:14:45 -0300
Date:   Fri, 3 Jul 2020 10:14:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200703131445.GU25301@ziepe.ca>
References: <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
 <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
 <20200701171524.GN25301@ziepe.ca>
 <20200702131000.GW3278063@phenom.ffwll.local>
 <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com>
 <20200702181540.GC3278063@phenom.ffwll.local>
 <20200703120335.GT25301@ziepe.ca>
 <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 03, 2020 at 02:52:03PM +0200, Daniel Vetter wrote:

> So maybe I'm just totally confused about the rdma model. I thought:
> - you bind a pile of memory for various transactions, that might
> happen whenever. Kernel driver doesn't have much if any insight into
> when memory isn't needed anymore. I think in the rdma world that's
> called registering memory, but not sure.

Sure, but once registered the memory is able to be used at any moment with
no visibilty from the kernel.

Unlike GPU the transactions that trigger memory access do not go
through the kernel - so there is no ability to interrupt a command
flow and fiddle with mappings.

Jason

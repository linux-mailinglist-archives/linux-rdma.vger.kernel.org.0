Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FCD1FB507
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgFPOxP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgFPOxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 10:53:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF0C061573
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 07:53:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e2so9591074qvw.7
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H9Q21GJcnralnv81ky+DYZCuyhzGkXe+xlvLrhcRUVI=;
        b=cDN3DzBNq5d3CrdALYsiOTFh73YRcI8lQ7uTSznJPv8dAJPnHjJPQR57lcTVwcL/Fu
         tV3NTbV5GNoBVgT5Y9FK7M+PwBjksAzlKvZZnxf+Qkd/PqTbrIdNSIbQI4xY6GgG5IkN
         2i29pdJFycDxjY2QVTv0QiEB95VIbTnGIGt0UTkJ1Csd3R+WgZXFN5sle6nrM8u0InPD
         03ylAeGN5+aJZmvaChOTyf6V/AGcN+wyw9nUErW3py9ORSzNIR2Kd+m+VbjIZ7U5Y8CF
         +bk0T6Aw1wPbeMExKzclzBgPz36VephSSjSjX1HFVeLmX9lSoGuhN4yVL+U6sHPpHMa8
         lzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9Q21GJcnralnv81ky+DYZCuyhzGkXe+xlvLrhcRUVI=;
        b=iyx4/rZ1ZG7576B5RMbDo2Nml2JRxkR0hZDvNrpRkcNvA1hl570giZuPStORqus6v3
         7dvogefcKfpm1A4fib15Wht/ye474K7mpMlwfYpWpkPmPyvvXoXREtYfj3TlAF9eFRBt
         sU7hxL/aNPYCbwUMuEbzVDB7rRtaM3nWhww5WP43p2YNCUn/ehkXOLuR+HGg16dmEI/K
         Q6tum1Tgn4EBhhgyVi9ZPxvMcL+CNCbKi3oXgDLNr3YrxF/JPLyzOyB82Ita9e410ndu
         D7Z/ULRfcgzuZW0Hz/AkDssZbX54F9NOHMAh4WAipUTs45/DzkRtWceaPYTiST1/+c2Y
         3lqA==
X-Gm-Message-State: AOAM5313hbpnQ34MrTW4ZnQQaOJAiQXTiI67mKrNJ9NIBD0yZvGhk9Kv
        /AJ8yczXzb8hRozKgRG5YF9cOg==
X-Google-Smtp-Source: ABdhPJzP5DGSQb5Sh+luEoCiwZvsmX+7FP3MYwRCXpBsltvvGKDh3l1qc0mmf+FYXhbSQFkMBoXxZQ==
X-Received: by 2002:a0c:e9cd:: with SMTP id q13mr2731630qvo.23.1592319193724;
        Tue, 16 Jun 2020 07:53:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g9sm14433034qtq.66.2020.06.16.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:53:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlCxc-0096j7-MB; Tue, 16 Jun 2020 11:53:12 -0300
Date:   Tue, 16 Jun 2020 11:53:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200616145312.GC6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616120719.GL20149@phenom.ffwll.local>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 02:07:19PM +0200, Daniel Vetter wrote:
> > > I've pinged a bunch of armsoc gpu driver people and ask them how much this
> > > hurts, so that we have a clear answer. On x86 I don't think we have much
> > > of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> > > (but nouveau I think doesn't use dma_fence in there). 
> > 
> > Right, nor will RDMA ODP. 
> 
> Hm, what's the context here? I thought RDMA side you really don't want
> dma_fence in mmu_notifiers, so not clear to me what you're agreeing on
> here.

rdma does not use dma_fence at all, and though it is hard to tell, I
didn't notice a dma_fence in the nouveau invalidation call path.

At the very least I think there should be some big warning that
dma_fence in notifiers should be avoided.

Ie it is strange that the new totally-not-a-gpu drivers use dma_fence,
they surely don't have the same constraints as the existing GPU world,
and it would be annoying to see dma_fence notifiers spring up in them

Jason

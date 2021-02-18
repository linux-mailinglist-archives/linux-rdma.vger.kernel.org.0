Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE21031F28C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBRWwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 17:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBRWwN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 17:52:13 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D32C061574
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 14:51:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id dr7so1802562qvb.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 14:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f4o2UaWR0IaBZ9I3kkpgTMwRbNwJtqHh4PFVjtr2gyI=;
        b=TAnM2mqFsfYh+QjgqIZGJwM4sOU/VBMwhtX2PbGKVVAmq73Qmo3I3H6ol+mSl3Su3j
         R+aKl2eR4DsYGvEcHR6ElvHCZnRpVx5qseWU6K3v76M2LvuvpOKYzuYPo2eXONx53Eqk
         cbmUWt0dGqfN1Ru/TgyuTBt03512o92v0v1AzcnTuB0TaeWT9cCNaasqZaG0lTiJ+LJh
         o5ObZCL1+nr5szNKUDUz7uuKHCJpou2qx+Huof6ywZYdJy0F922NIs9vcFVi1iI9CaKn
         ZUfbtu0xI+5KLiZ8n0iPKEDHYecI7lCdwTJqss1c3DSnfMOGF/qmsy5tTdiCNZBaCxvS
         gtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4o2UaWR0IaBZ9I3kkpgTMwRbNwJtqHh4PFVjtr2gyI=;
        b=WlEVxv0MEO/KpESaVFmfLXNTxHr0mo37U10om0itBgKwGusMLp08C+VRT2eqMDc9rn
         HOONyiK9q2nWbGKU4g9CDNDjcSXrPokwIkKPG3G10IWLZMc24yn48rXJsgWT2/BodzR0
         XIUT6tL9yYk2ZZ79ngePNcNVSGZ6NwpI0e0z+Bq0l6PyOtIbmBqd0RC72FlzkETCk74L
         1XokSUSAI9JIHm+7hxEWW3uWgfDZ30KFJ9tJdc4aP2FJRaMOP5gDpneyHwTKH3S9gaMM
         uTU+W9L4w5Z9VPgqsJXrCpr0O4Eim7Ykkt6iIgLS7gTJKJ0vpugmf4AbC806PrUFWzYJ
         72Ng==
X-Gm-Message-State: AOAM5301LutfhH9UxGH1LiYvRzWxryVIzY5S2K1+rn4SHbs3u5ti3Yud
        OF63AqI6Y1ekJ2cpSkAbaaHfjg==
X-Google-Smtp-Source: ABdhPJxk1+QiLVDPFFx7j2AaNZWKgMKA77nmEYDXwYTxZ9s/nFDNit48B172/0LuQVOVq4czmxMWEA==
X-Received: by 2002:a0c:e18a:: with SMTP id p10mr6869493qvl.0.1613688692807;
        Thu, 18 Feb 2021 14:51:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id t6sm4901409qkd.127.2021.02.18.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:51:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lCs8x-00BeS6-FC; Thu, 18 Feb 2021 18:51:31 -0400
Date:   Thu, 18 Feb 2021 18:51:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210218225131.GB2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 18, 2021 at 05:22:31PM -0500, Tom Talpey wrote:
> On 2/18/2021 11:23 AM, Jason Gunthorpe wrote:
> > On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
> > > On 18/02/2021 14:53, Jason Gunthorpe wrote:
> > > > On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
> > > > > I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
> > > > > "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
> > > > > added to the completion channel associated with the CQ."
> > > > > 
> > > > > What is considered a new CQE in this case?
> > > > > The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
> > > > > by the user's poll cq?
> > > > > Or any new CQE from the device's perspective?
> > > > 
> > > > new CQE from the device perspective.
> > > > 
> > > > > For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
> > > > > completions, but the user hasn't polled his CQ yet, when should he be notified?
> > > > > On the 101 completion or immediately (since there are completions waiting on the
> > > > > CQ)?
> > > > 
> > > > 101 completion
> > > > 
> > > > It is only meaningful to call it when the CQ is empty.
> > > 
> > > Thanks, so there's an inherent race between the user's CQ poll and the next arm?
> > 
> > I think the specs or man pages talk about this, the application has to
> > observe empty, do arm, then poll again then sleep on the cq if empty.
> > 
> > > Do you know what's the purpose of the consumer index in the arm doorbell that's
> > > implemented by many providers?
> > 
> > The consumer index is needed by HW to prevent CQ overflow, presumably
> > the drivers push to reduce the cases where the HW has to read it from
> > PCI
> 
> Prevent CQ overflow? There's no such requirement that I'm aware of.
> If the consumer doesn't provide a large-enough CQ, then it reaps the
> consequences. Same thing for WQ depth, although I am aware that some
> verbs implementations attempt to return a kind of EAGAIN when posting
> to a send WQ.
> 
> What can the provider do if the CQ is "full" anyway? Buffer the CQE
> and go into some type of polling loop attempting to redeliver? Ouch!

QP goes to error, CQE is discarded, IIRC.

Wrapping and overflowing the CQ is not acceptable, it would mean
reading CQEs could never be done reliably.

Jason

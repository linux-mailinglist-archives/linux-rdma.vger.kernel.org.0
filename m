Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0D31F361
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 01:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBSAqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 19:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSAqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 19:46:39 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886DC061574
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 16:45:59 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x3so2858867qti.5
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CA9cZ45f5o96grkbXXM7j7sMEb3cpyv5BYjpaHQeTwg=;
        b=Drw4ODIsQPcgLfX+1ZIfstxsNF/WlOnV8aW1SdbSMWZlfydyEzqpbfNFiU53CHJ3Qs
         fATKxbxnFVjkQoaafxkuV5LnLF88oEFosjWatYozAo5Wvywzzty0rnUf4iT45lYKWFQI
         CbsRCaRl+Sr9yJXBiw8mvwAI4bY+vd7NN1BJdeu1EiiTe6a0Y0/FDtk2GMJs67CWMUwq
         pnVEZLzQgj0BSJ9I2HB4L5cI5KG9Z+gX+dY2of2aquDeX1867Hf5EZ8F47YsANTTSnOP
         V5bl16/RgHVYqhsR5QiA7WaLwFg712WiRRUp3ArDiAaPeUs0Twe9iYXsy7SYzFnivSCE
         zA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CA9cZ45f5o96grkbXXM7j7sMEb3cpyv5BYjpaHQeTwg=;
        b=A/4D0rgpL5PPz+FpMQBZX1xoTIAkeuxgxqv8GPTcgwEwPrVJS8JZPy+3fZVOyu2rYE
         jcahI3XDjDg0p755BMZ/pyHZwD0FmPYUCpziGp/4pGZyrfDQ+EJfErWiyda38HjR7hp1
         qW+s6hzY90DbVMCn4TZD5dQ1piE7emnVXrQ1fS/XhrqVF+3U3EJvR4DMVbGemS9rUdE5
         F0DdocYkGpc2wpXlRHjUrvfXMRZZG1aUlAAcwbJwiYekC9pLc687Z7INH10fuR5mTJ4Z
         EP/ovAtgW1TF8UQCracPe2yYkjGweZjtfp31ZShnCUk5/toBeJPNCYKSvCAxuIHcDakh
         Bmrw==
X-Gm-Message-State: AOAM530WaIT2y8MxueY38rLCWh7m6vOBB+qllLvMlj3DaSOCfUiRpeb5
        EOLhMgaWkxxKAGSotD6egGgBkvJKFcf8JPSt
X-Google-Smtp-Source: ABdhPJz3XPYz9+JkitOmDLeFemEFAo6iLVf/6MyIT4DZOW2tdOqAW6tcdIPH7sX4oTE+UiPNQaMPtg==
X-Received: by 2002:ac8:5946:: with SMTP id 6mr6835565qtz.261.1613695556803;
        Thu, 18 Feb 2021 16:45:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x8sm4528697qts.14.2021.02.18.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 16:45:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lCtvf-00C6DE-HC; Thu, 18 Feb 2021 20:45:55 -0400
Date:   Thu, 18 Feb 2021 20:45:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210219004555.GC2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
 <20210218225131.GB2643399@ziepe.ca>
 <4b38c6fa-0a18-9f32-4dce-af8e3e39cb8e@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b38c6fa-0a18-9f32-4dce-af8e3e39cb8e@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 18, 2021 at 06:07:13PM -0500, Tom Talpey wrote:
> > > If the consumer doesn't provide a large-enough CQ, then it reaps the
> > > consequences. Same thing for WQ depth, although I am aware that some
> > > verbs implementations attempt to return a kind of EAGAIN when posting
> > > to a send WQ.
> > > 
> > > What can the provider do if the CQ is "full" anyway? Buffer the CQE
> > > and go into some type of polling loop attempting to redeliver? Ouch!
> > 
> > QP goes to error, CQE is discarded, IIRC.
> 
> What!? There might be many QP's all sharing the same CQ. Put them
> *all* into error? And for what, because the CQ is trash anyway. This
> sounds like optimizing the error case. Uselessly.

No, only the QPs that need to push a CQE and can't.

> > Wrapping and overflowing the CQ is not acceptable, it would mean
> > reading CQEs could never be done reliably.
> 
> But the provider never reads the CQ, only the consumer can read.
> The provider writes to head, ignoring tail. Consumer reads from
> tail, and it goes empty when tail == head. And if head overruns
> tail, that was the consumer's fault for posting too many WQEs.

Yes, but if the app makes a mistake you don't want to trash the whole
system. Resiliency says you contain the failure as much as possible
and the app at least has some chance to pick up the pieces.

If the HW corrupts the CQEs while the CPU is reading them then the
whole machine is toast, high chance the kernel will corrupt memory.

Jason

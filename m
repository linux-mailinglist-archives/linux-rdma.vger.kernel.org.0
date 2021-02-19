Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC431FB1A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhBSOmw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhBSOmo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Feb 2021 09:42:44 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE3C061574
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 06:42:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z128so1152109qkc.12
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hrp/v6wYt4l4Wh0IHkombc4JzVPMmPKli1UzuAe5yhw=;
        b=eHI+N9+t9kbz8Thu8HIUerJvbwG9Cv7h4h3jPf4ioVoIsPRev9vMQ7lLhNeYGtSbkw
         7BugfsOkVUeqiLcF0TCL8DaV35H+yU0hnNzqx4MYSr/06lz3d8zb1TDClH2Uu35Wflge
         QYEHZffO5ntOIkZpIklpy1TddiUtawVP4oHj/TrLGK/ITzAwq3QCsnCoqA118RwaOlOb
         omUkn375oDrrsCX5PlbHQJbr7M9cChN6S4o0mvY52cu5XpChQRUG9qDokDJ3HP4Fb14e
         SmekJyw38r0FB0epK206NCQtpodZzoAQmtBtFUaw3FbXXd2EfwDXnY9AgqlIc1N9/Hwa
         KFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hrp/v6wYt4l4Wh0IHkombc4JzVPMmPKli1UzuAe5yhw=;
        b=Aj1am/WFfswNFizv2BqRgqOj+8SAOxxmyn/OJW31Xk6bjTxoi5hSYZMuZVLKAumm5d
         9iAIpr5CNtriL4Sgi3U8ekBgXib1/mCTgcjjplkLwCPLePalTOkfIwdKHxmQO5NKTI4B
         aZKfO2VZWLsUIm7pBoFoAhrYCU/HKrV/qmdEO7032H0iT64d55ZAEVX5/tuNvjZ3ua/u
         20Lirb+mQGZRs8fXEQFSLfnQQDA8K24xkZt7z4d7yWezeqf/MYOa9xMRTMJUdbJEU2bh
         aSDcXY9G/xfLhTeOitp1+68dCBzhIukMHPEDu1hqBU7aluw3AoxlG1yET4frK+sPdH8A
         DbCQ==
X-Gm-Message-State: AOAM533irz63F0QD0zaobxv9b+XOwHzO4f5oC9UINxPF1RO/M6YcUEoY
        A9yA1u/BBOaN/U/SNk07KDJrv18ouct7L8+C
X-Google-Smtp-Source: ABdhPJxXn/Z5Pr6EVHvjEvywbBVdyBXTRT5eKxbapwyeU41Iz5olzlXahVRYetLiixuc89PpRyDbTA==
X-Received: by 2002:a37:a889:: with SMTP id r131mr9705365qke.410.1613745723055;
        Fri, 19 Feb 2021 06:42:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id r3sm1581305qkm.129.2021.02.19.06.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:42:02 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lD6yo-00CUE4-1C; Fri, 19 Feb 2021 10:42:02 -0400
Date:   Fri, 19 Feb 2021 10:42:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210219144202.GF2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <e0153a6f-b9d9-4cb1-a2f2-a7f1865f3719@talpey.com>
 <20210218225131.GB2643399@ziepe.ca>
 <4b38c6fa-0a18-9f32-4dce-af8e3e39cb8e@talpey.com>
 <20210219004555.GC2643399@ziepe.ca>
 <b31d6cdc-7304-d2fc-2e56-1f30f86f5dc4@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31d6cdc-7304-d2fc-2e56-1f30f86f5dc4@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 09:31:22AM -0500, Tom Talpey wrote:
> On 2/18/2021 7:45 PM, Jason Gunthorpe wrote:
> > On Thu, Feb 18, 2021 at 06:07:13PM -0500, Tom Talpey wrote:
> > > > > If the consumer doesn't provide a large-enough CQ, then it reaps the
> > > > > consequences. Same thing for WQ depth, although I am aware that some
> > > > > verbs implementations attempt to return a kind of EAGAIN when posting
> > > > > to a send WQ.
> > > > > 
> > > > > What can the provider do if the CQ is "full" anyway? Buffer the CQE
> > > > > and go into some type of polling loop attempting to redeliver? Ouch!
> > > > 
> > > > QP goes to error, CQE is discarded, IIRC.
> > > 
> > > What!? There might be many QP's all sharing the same CQ. Put them
> > > *all* into error? And for what, because the CQ is trash anyway. This
> > > sounds like optimizing the error case. Uselessly.
> > 
> > No, only the QPs that need to push a CQE and can't.
> 
> Hm. Ok, so QP's will drop unpredictably, and their outstanding WQEs
> will probably be lost as well, but I can see cases where a CQ slot
> might open up while the failed QP is flushing, and CQE's get delivered
> out of order. That might be even worse. It would seem safer to stop
> writing to the CQ altogether - all QPs.

I think the app gets an IBV_EVENT_CQ_ERR and IBV_EVENT_QP_FATAL and
has to clean it up.

> That would be a problem, but it's only true if the provider implements
> the CQ as a circular buffer. 

AFAIK there is no datastructure that allows unbounded writing from the
producer side, the only choices are to halt on overflow or corrupt on
overflow - corrupt breaks the machine, so good HW does halt.

Jason

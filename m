Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810F532195B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhBVNtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhBVNr0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 08:47:26 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99AC06178B
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 05:46:44 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b3so1701725qtj.10
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bKPb+k4C5Ig1BaSIE+7S8TGdBrucOJHoSLrM+XWa0Qw=;
        b=HFFyWhHX+ER0d7AC949YXNdrcX6W2yWqN6PFZ9qeuugSk4LpSbxPoDSLKmMyoOtqEI
         a1ZLOxZq5Az7GePfGLkfklQ6wswtDfXqxl3v3YM4Yt9xOuuDKAp2y5NA5Swru1NLiESt
         nUfKnLAJYC0e7EjyvNl8YbnzaziJkSy9ctXU5T4szWZoigye/UWarrhun/erL7JnII90
         nVEGebkq1ctmxh1XYL+tgpaaB8YhF/DylWvNZVEvqu+f+iHgG9o1ZcKzgKRlm2DD0ULg
         olAubUmlKaJce/AWxSSzPt9spSPbPEqseSYXAxcpU3zLOge+WHFQzSAPr9ziEBypLZjr
         RPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKPb+k4C5Ig1BaSIE+7S8TGdBrucOJHoSLrM+XWa0Qw=;
        b=piaFoK4PtnrvIFgCb0voyL0A3+TLkKUBSJ9RPBWJDnvXLsCW459TsvRO0QLEz6dAbh
         BqCLglUkVqmExED8CwFoVGGOhJU6q+Qh56K6qnCmMgNlAGRHMPrkoayT8dmGZpw3BDce
         3lVhIcMq0c1eGasS1vF2sDvqn7ekjGOgAmygp7Lemv148o2I4cO+ZM9Xu1Xz3IGoTM2r
         vDGNGxlGFKyOqq7VXxUsQUu3eJP6q5ttoDD/PyYJMBkh8V830osOzzOUEdtC0ErGZ6mG
         aW/YOtWqQ0pTwlY4wvoqMzPQyIzfsFJESOjcPrPTNX4UYfuxa69QQ+MPV8806y3bYaEb
         RT6Q==
X-Gm-Message-State: AOAM532YjlV4AEjtYMi58ClgadYOY9LOICl7uzM96EPPv4kbKW2wpnNg
        gKNWf5syos1EKYc/X4nqWBH7Ig==
X-Google-Smtp-Source: ABdhPJz79X5mBolsmfPvHcv2TS/1IVD1lM/9O3UEf4VKK/LfLPaWsdFFnvRqUBo49Iz3UkHZ23JQJw==
X-Received: by 2002:ac8:1115:: with SMTP id c21mr20160487qtj.389.1614001604191;
        Mon, 22 Feb 2021 05:46:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 12sm11056058qtt.88.2021.02.22.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 05:46:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEBXu-00ED8w-MH; Mon, 22 Feb 2021 09:46:42 -0400
Date:   Mon, 22 Feb 2021 09:46:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210222134642.GG2643399@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 21, 2021 at 11:25:02AM +0200, Gal Pressman wrote:
> On 18/02/2021 18:23, Jason Gunthorpe wrote:
> > On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
> >> On 18/02/2021 14:53, Jason Gunthorpe wrote:
> >>> On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
> >>>> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
> >>>> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
> >>>> added to the completion channel associated with the CQ."
> >>>>
> >>>> What is considered a new CQE in this case?
> >>>> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
> >>>> by the user's poll cq?
> >>>> Or any new CQE from the device's perspective?
> >>>
> >>> new CQE from the device perspective.
> >>>
> >>>> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
> >>>> completions, but the user hasn't polled his CQ yet, when should he be notified?
> >>>> On the 101 completion or immediately (since there are completions waiting on the
> >>>> CQ)?
> >>>
> >>> 101 completion
> >>>
> >>> It is only meaningful to call it when the CQ is empty.
> >>
> >> Thanks, so there's an inherent race between the user's CQ poll and the next arm?
> > 
> > I think the specs or man pages talk about this, the application has to
> > observe empty, do arm, then poll again then sleep on the cq if empty.
> > 
> >> Do you know what's the purpose of the consumer index in the arm doorbell that's
> >> implemented by many providers?
> > 
> > The consumer index is needed by HW to prevent CQ overflow, presumably
> > the drivers push to reduce the cases where the HW has to read it from
> > PCI
> 
> Thanks, that makes sense.
> 
> I found the following sentence in CX PRM:
> "If new CQEs are posted to the CQ after the reporting of a completion event and
> these CQEs are not yet consumed, then an event will be generated immediately
> after the request for notification is executed."
> 
> Doesn't that contradict the expected behavior?

I read it as confirming it?

Only *new* CQEs trigger an event, and new CQE's always trigger an
event regardless of the full/empty state of the queue.

This paragraph is an obtuse way of warning of the race I described.

Jason

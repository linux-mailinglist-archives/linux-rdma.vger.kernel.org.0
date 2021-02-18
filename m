Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4913031EE61
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBRSdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhBRQYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 11:24:14 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B6C061786
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 08:23:31 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id j66so1175339qkf.11
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYzyNY89k1Ap3RJeEgm46c60vaNPA7+uNZRLbvqNnV4=;
        b=SFj2tt5RHr9BuOsRY3EToz7ncTv0hsjxcrpH01IzVsc3BM2a12/7Mlc7OwiqvmrDRt
         VLY1W/DULpxtxmI8ZjF/8Eb/i7gIuZJ0o0eLUd/YGD17HUaDWo9F+bXUwnRF6/oOcCWL
         1EbBKDOsXWGaRJW66VYEApdSYVMrkMYU1m828Ndi0Q/g2i4jPYuedbSO5KdHdGgonewL
         GCGPNyp0yRYbOVxFEfiSin+DulasGbvas0Di63YKE+TTJzhLXOkpunaavyu6PJWuwwef
         t2aSI33K6oB1Mb8i/aUpzQFzBiK0hWVbcOlqfJmFEOhDMn+o+sX3zvuW5ArkasPjxYFM
         F+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYzyNY89k1Ap3RJeEgm46c60vaNPA7+uNZRLbvqNnV4=;
        b=Ngonx9faeFIzhu5GEje4Q3Yz/scGOIPF153ql1W0pxh0GMmY9rhJj/AKhDJ8D7sn9l
         Rxyqo1GQadqHL1nvWX6mVrKHnFbTXoJcgC4lFG2jSpDtLz6aZj9619aPL9EpMcGbLoaA
         4kyiewnFkYcpotiPt0+K8c1mN2uLjvv0uh4NryKTVtGyTKGXBZsBRTTylgstO/4ze0Fx
         fhq64ydS7mPpBA69Gd4+spMD4fx99P73YPkdWIgqoossnbaJw1HWFjxQ1I9fNicaSVRZ
         fbEzQXZN5Lph47Fh2qq3vndyzluBpq7J/UjkpbhCLrEjC3PaLGNNTeu57zdE9ylXfvXw
         f54g==
X-Gm-Message-State: AOAM530qth1/mb/q4yh2A3luhhCJnoW9X/U+Nj+rrrtSz37mpTampcO6
        MiQnl6YeX+8Ut/q81PqDJEjqug==
X-Google-Smtp-Source: ABdhPJxA26WzK5V5sE/UKJTJh/XKYF6bxdmU5tPeF2ZesqTSsuwSe/CRHSm7CC/7pDeY4D3FSuVGwA==
X-Received: by 2002:a37:6547:: with SMTP id z68mr5008446qkb.246.1613665410745;
        Thu, 18 Feb 2021 08:23:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m2sm3704992qtn.31.2021.02.18.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:23:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lCm5R-00B0vf-JP; Thu, 18 Feb 2021 12:23:29 -0400
Date:   Thu, 18 Feb 2021 12:23:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210218162329.GZ4718@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
 <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 18, 2021 at 05:52:16PM +0200, Gal Pressman wrote:
> On 18/02/2021 14:53, Jason Gunthorpe wrote:
> > On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
> >> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
> >> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
> >> added to the completion channel associated with the CQ."
> >>
> >> What is considered a new CQE in this case?
> >> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
> >> by the user's poll cq?
> >> Or any new CQE from the device's perspective?
> > 
> > new CQE from the device perspective.
> > 
> >> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
> >> completions, but the user hasn't polled his CQ yet, when should he be notified?
> >> On the 101 completion or immediately (since there are completions waiting on the
> >> CQ)?
> > 
> > 101 completion
> > 
> > It is only meaningful to call it when the CQ is empty.
> 
> Thanks, so there's an inherent race between the user's CQ poll and the next arm?

I think the specs or man pages talk about this, the application has to
observe empty, do arm, then poll again then sleep on the cq if empty.

> Do you know what's the purpose of the consumer index in the arm doorbell that's
> implemented by many providers?

The consumer index is needed by HW to prevent CQ overflow, presumably
the drivers push to reduce the cases where the HW has to read it from
PCI

Jason

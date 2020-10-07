Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2C285F2D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgJGM2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgJGM2c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 08:28:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B0C061755
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 05:28:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id r8so1541679qtp.13
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f1sgnDtA6Xrx/R2WXwsMCsesSFBaqVDgy/l8oO9Gqy8=;
        b=BvsiDsFc9LRs22jyuiOH8UqXvoC/SYfgy+4t7zr6YbI9aFmMjUVDpF39SN6b6tS0EA
         DGAwYdWocVIvyo4f3nb0jQPKHn1lTkXyzG2s0y0JOblLlSxUwHylukM3MZIYjTy3c0QM
         e+h4MYatPdxDBSbLpDjDGReqBPfYDaoQwLf3XjyHLvWbqwi73U8jnNcK+GV9dkVm1kYA
         3/WaFunUUxHumPXfOUnz7VhQsewC5dlBwZL4rasko0BGKVXk0h3VW5Hfz4rvvS5G2uEx
         sZtnHEQLws++3ys5dpSn6ugv9W/Z2pgnGpKgNmLtMN6B3VA6E2fUgbthC/tofHfTpaHz
         aW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1sgnDtA6Xrx/R2WXwsMCsesSFBaqVDgy/l8oO9Gqy8=;
        b=ahUw6QkrNi32oVAtNZHql0PJdFktONi4q/YWYf2aErzhEdRixzQYtXd/5+wtj/ifIv
         Y92RKbFSFAHCrTwZXWfPZGs/ao+jr0yBlCuhIi/40tkVXsODarGJGJ0I/5Do2UZjBOL3
         hkRY64neuJIcaR5VeY7LGsoMuCZycty1/Q8yDh14710857ysrkm8W2p/aT7eVabL49L0
         9mGqXEMeB0e7Q1nCxvUP5VpvuSe3tZzUOXmhbF0NW2SINJxQ/anUfE9CoSbnUD/yJRFF
         6bag6JU3GcrN3WrbZXCdBAJ9fPHFMfIX1zpk3TrIcGpaRLC+iDFziZELUv6ipdw+jejv
         dCQA==
X-Gm-Message-State: AOAM532qZ/SjnTMZMDcdZ07tlZV7eydV8HwUFFAh0WpbzV/V3B5ZJzv3
        EVzBc3acwRFhjzk6qWCZwHtYoMMc5FdPrL12
X-Google-Smtp-Source: ABdhPJxln1kFpXlLbrYly7F4aGAaokNfoyeQsZ7MdAwfwCjRrOaXdmjPs4LZ9ntNeNWyNh5gbKRm+Q==
X-Received: by 2002:aed:2986:: with SMTP id o6mr2954543qtd.269.1602073711802;
        Wed, 07 Oct 2020 05:28:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t2sm1407465qti.25.2020.10.07.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:28:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQ8YY-000tH5-Hs; Wed, 07 Oct 2020 09:28:30 -0300
Date:   Wed, 7 Oct 2020 09:28:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201007122830.GM5177@ziepe.ca>
References: <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 04:38:45PM +0800, Ka-Cheong Poon wrote:
> On 10/6/20 8:46 PM, Jason Gunthorpe wrote:
> > On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:
> > 
> > > > > > Kernel modules should not be doing networking unless commanded to by
> > > > > > userspace.
> > > > > 
> > > > > It is still not clear why this is an issue with RDMA
> > > > > connection, but not with general kernel socket.  It is
> > > > > not random networking.  There is a purpose.
> > > > 
> > > > It is a problem with sockets too, how do the socket users trigger
> > > > their socket usages? AFAIK all cases originate with userspace
> > > 
> > > A user starts a namespace.  The module is loaded for servicing
> > > requests.  The module starts a listener.  The user deletes
> > > the namespace.  This scenario will have everything cleaned up
> > > properly if the listener is a kernel socket.  This is not the
> > > case with RDMA.
> > 
> > Please point to reputable code in upstream doing this
> 
> 
> It is not clear what "reputable" here really means.  If it just
> means something in kernel, then nearly all, if not all, Internet
> protocols code in kernel create a control kernel socket for every
> network namespaces.  That socket is deleted in the per namespace
> exit function.  If it explicitly means listening socket, AFS and
> TIPC in kernel do that for every namespaces.  That socket is
> deleted in the per namespace exit function.

AFS and TIPC are not exactly well reviewed mainstream areas.

> It is very common for a network protocol to have something like
> this for protocol processing.  It is not clear why RDMA subsystem
> behaves differently and forbids this common practice.  Could you
> please elaborate the issues this practice has such that the RDMA
> subsystem cannot support it?

The kernel should not have rouge listening sockets just because a
model is loaded. Creation if listening kernel side sockets should be
triggered by userspace.

Jason

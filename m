Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48F638BF54
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhEUGa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 02:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhEUGai (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 May 2021 02:30:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 450E0613B6;
        Fri, 21 May 2021 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621578555;
        bh=OuOaLVeLKVL4MFpcuq3Eo84euhKxqBGRDkgy+5MHpLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyIjc4BUYThjwUDUvf68JEDT/V7EuMP833iA1CyCL8RA+WH6ASbVu0VKQsLPHDI3X
         4QxQC0FsAEjiOTQ4ycMtbJT4fe0J17R1Vs3GJfL5NNwj4Ao+QQD0AGpMzV1qSZNjZV
         iWIXG1KZzO6qQG7B0vdzVfEWwH/2s3tFhyGona/4byjrJab47FMrprPZJxJ8qKRKcc
         I//8wRRLeukkmELMLoSWkney6NmeoT0LVdbykHDmraPNBt8hxbcyKiv0wAjb7CNTCW
         ns9YKbOdM91PpeLT3eoSYOs4/MG5qUtGVSNoK9XJpJi3+dv9Qne4TLecLU4tRMnYLi
         duBCrbqydM9zA==
Date:   Fri, 21 May 2021 09:29:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YKdTOEeC55X+SZl+@unreal>
References: <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 06:02:09PM -0400, Dennis Dalessandro wrote:
> On 5/19/21 4:26 PM, Jason Gunthorpe wrote:
> > On Wed, May 19, 2021 at 03:49:31PM -0400, Dennis Dalessandro wrote:
> > > On 5/19/21 2:29 PM, Jason Gunthorpe wrote:
> > > > On Wed, May 19, 2021 at 07:56:32AM -0400, Dennis Dalessandro wrote:

<...>

> > Especially since for RDMA all of the above is highly situational. The
> > IRQ/WQ processing anything in RDMA should be tied to the comp_vector,
> > so without knowing that information you simply can't do anything
> > correct at allocation time.
> 
> I don't think that's true for our case. The comp_vector may in some cases be
> the right thing to dictate where memory should be, in our case I don't think
> that's true all the time.

In verbs world, the comp_vector is always the right thing to dictate
node policy. We can argue if it works correctly or not.

https://www.rdmamojo.com/2012/11/03/ibv_create_cq/
comp_vector:
 MSI-X completion vector that will be used for signaling Completion events.
 If the IRQ affinity masks of these interrupts have been configured to spread
 each MSI-X interrupt to be handled by a different core, this parameter can be
 used to spread the completion workload over multiple cores.

> 
> > The idea of allocating every to the HW's node is simply not correct
> > design. I will grant you it may have made sense ages ago before the
> > NUMA stuff was more completed, but today it does not and you'd be
> > better to remove it all and use memory policy properly than insist we
> > keep it around forever.
> 
> Not insisting anything. If the trend is to remove these sort of allocations
> and other drivers are no longer doing this "not correct design" we are
> certainly open to change. We just want to understand the impact first rather
> than being strong armed into accepting a performance regression just so Leon
> can refactor some code.

It is hard to talk without data.

Thanks

> 
> -Denny

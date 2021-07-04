Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AD3BABB1
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jul 2021 08:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhGDGgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 02:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGDGgi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Jul 2021 02:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ABFC613BD;
        Sun,  4 Jul 2021 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625380443;
        bh=wno3oUYI1yHOGawbHZ4ScbOty2mhX22sWkBa1oLvOwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aa/O34YsbC06irLFlMj8X2BY0NTIM+0pG7NqgnXpPpCfDWAAzJVz3FBZ2dLhkIpAn
         v+h7VSQMudbAVtpUhTWmbu6s02LMzaxgtIOmXG5lJy+mi3EtefKf0COGQ8us3u0eD5
         +2OvrWIXrHoFR9PzAwpSvYHXKVVf4yoxg/gEUaZiECFXSb8WSVdY5waN+IWqQXXXy2
         EdcGJsmVwSRKPd4o6RQ3Cqi+4HZjkLDK/jxdVMw/BRg8AVwBKfRFG23CuuE3qAmVNH
         IYCJpvvH4zGJaNW76VFXUEoLmfDN/tNSmqsg6xz+hG4BqWIMAc+q9+I4EuEqPzRTLO
         uc7ci62JoQ9Pw==
Date:   Sun, 4 Jul 2021 09:34:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Pine, Kevin" <kevin.pine@cornelisnetworks.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YOFWWOb7Dq92uaat@unreal>
References: <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
 <20210525142048.GZ1002214@nvidia.com>
 <CH0PR01MB7153F90EA5FAD6C18D361CC4F2039@CH0PR01MB7153.prod.exchangelabs.com>
 <20210628231934.GL4459@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628231934.GL4459@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 08:19:34PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 28, 2021 at 09:59:48PM +0000, Marciniszyn, Mike wrote:

<...>

> I certainly object to this idea that the driver assumes userspace will
> never move its IRQs off the local because it has wrongly hardwired a
> numa locality to the wrong object.

It makes me wonder how should we progress with my patch.

Thanks

> 
> Jason

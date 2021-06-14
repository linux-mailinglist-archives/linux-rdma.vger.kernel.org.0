Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B103A5DA9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhFNH1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 03:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhFNH1j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Jun 2021 03:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45D85613C3;
        Mon, 14 Jun 2021 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623655535;
        bh=6fnOGnEJwjNZCWpw7r4U37RPUuXg/sl8PL80A20gFpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3VcW2twsucfZ5JVLqWfrdl6FdDF5BezyhACYGnXM5FIJLXrc8AQhF8mki5SjLSRJ
         FPbzurCr4ah3RsNQPnd035M3MxHyy7ltauDLCkzezA8SZhA6MwaZnhJPkiWh5PTsVY
         yFWSmdxezPAD4YXFgsuQr5n18Lt2wDNvs51b/jF2Ht21DeH0MOYRLAv9A1whVIIBh8
         i3/Kgzghp39e+d7/FGfAollPDoaZ39zivMeuD23UVn3OnpIDGuGlGN0DLjscDGkYQT
         vToYT1IK8t4NSZIA6mnMVmBxZ8JzFJpwyHGhoTMEt8hQc/abUfwIx2jNBQqpQzA+IY
         XkP+6VwMordvg==
Date:   Mon, 14 Jun 2021 10:25:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Message-ID: <YMcEbBrDyDgmYEPu@unreal>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com>
 <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal>
 <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 14, 2021 at 03:32:39AM +0000, Haakon Bugge wrote:
> 
> 
> > On 9 Jun 2021, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Jun 09, 2021 at 09:26:03AM +0000, Anand Khoje wrote:
> >> Hi Leon,
> > 
> > Please don't do top-posting.
> > 
> > 
> >> 
> >> The set_bit()/clear_bit() and enum ib_port_data_flags  has been added as a device that can be used for future enhancements. 
> >> Also, usage of set_bit()/clear_bit() ensures the operations on this bit is atomic.
> > 
> > The bitfield variables are better suit this use case.
> > Let's don't overcomplicate code without the reason.
> 
> The problem is always that people tend to build on what's in there. For example, look at the bitfields in rdma_id_private, tos_set,  timeout_set, and min_rnr_timer_set.
> 
> What do you think will happen when, let's say, rdma_set_service_type() and rdma_set_ack_timeout() are called in close proximity in time? There is no locking, and the RMW will fail intermittently.

We are talking about device initialization flow that shouldn't be
performed in parallel to another initialization of same device, so the
comparison to rdma-cm is not valid here.

Thanks

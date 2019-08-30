Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B84A3575
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfH3LMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 07:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbfH3LMv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 07:12:51 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521AE21897;
        Fri, 30 Aug 2019 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567163570;
        bh=E+k/Oqexq3jHhNW1MXtAcRPZNo/Jc3DhoH9gu40e2Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoWhoBpWQlXEHLn/ddU+JrDVPNVgP1cZyyVUw66A7G/9RYVOUEQz4WQTRi+fTWc5m
         eUYdLi7I98VfpjOQ1g9ZCc8eTxFKZUgM5cs7T5y/hqKqg9xTIku9HA46FVywaNHedp
         icyg/b+5x2s6aeDZlmYLdadis9ctQ06D1UdRDGtY=
Date:   Fri, 30 Aug 2019 14:12:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Message-ID: <20190830111245.GF12611@unreal>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-4-leon@kernel.org>
 <AM0PR05MB4866C7620535722AD791DA7FD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866C7620535722AD791DA7FD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 30, 2019 at 10:18:35AM +0000, Parav Pandit wrote:
>
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > Sent: Friday, August 30, 2019 1:46 PM
> > To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> > <jgg@mellanox.com>
> > Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> > rdma@vger.kernel.org>; Erez Alfasi <ereza@mellanox.com>
> > Subject: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
> >
> > From: Erez Alfasi <ereza@mellanox.com>
> >
> > Add RDMA nldev netlink interface for dumping MR statistics information.
> >
> > Output example:
> > ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
> >   local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::
> >
> > ereza@dev~$: rdma stat show mr
> > dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
> > prefetched_pages 122071
> >
> > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---

<...>

> > struct ib_device_ops {
> >  	 */
> >  	int (*counter_update_stats)(struct rdma_counter *counter);
> >
> > +	/**
> > +	 * fill_odp_stats - Fill MR ODP stats into a given
> > +	 * ib_odp_counters struct.
> > +	 * Return value - true in case counters has been filled,
> > +	 * false otherwise (if its non-ODP registered MR for example).
> > +	 */
> > +	bool (*fill_odp_stats)(struct ib_mr *mr, struct ib_odp_counters
> > *cnt);
> > +
> Requesting ODP stats on non-ODP MR is an error.
> Instead of returning bool, please return int = -EINVAL as an error for non ODP MRs.

We don't want to add extra checks in the drivers for something that is
supposed to be checked by upper layer. If caller asks for ODP
statistics, he will check that MR is ODP backed. Especially if the need
to have ODP MR is embedded into the function name.

Thanks

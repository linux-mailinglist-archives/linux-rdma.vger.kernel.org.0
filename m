Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE60146E4F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2020 17:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWQ2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jan 2020 11:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWQ2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Jan 2020 11:28:25 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF3021734;
        Thu, 23 Jan 2020 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579796904;
        bh=TPCv0XD9RWlhtH+BUB6VP7/HBxJjQIN3ndCet5piiGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4ZakK1oWyUe/qIMIzlx///IN0fh+cJdxfQ1/Z1UI77c+TFgzDxCa2kRf0YiSi2PG
         4ZAdhx3DWNQoiCe1Kxxn9Wc7mXP6hz8kG8yerfilHWOgBpknOqPtzYv2CF+LA9XVU1
         NUSdxNPCWvOCtZVsFs9QRrQER0o0LdSW6Z0i5wfU=
Date:   Thu, 23 Jan 2020 18:28:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] IB/mlx4: Fix leak in id_map_find_del
Message-ID: <20200123162820.GQ7018@unreal>
References: <20200123155521.1212288-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123155521.1212288-1-haakon.bugge@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 23, 2020 at 04:55:21PM +0100, Håkon Bugge wrote:
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
>
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
>
> Following the RDMA Connection Manager (CM) protocol, it is clear when
> an entry has to evicted from the cache. When a DREP is sent from
> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
> when a REJ is received by the mlx4_ib_demux_cm_handler(),
> id_map_find_del() is called.
>
> This function wipes out the TID in use from the IDR or XArray and
> removes the id_map_entry from the table.
>
> In short, it does everything except the topping of the cake, which is
> to remove the entry from the list and free it. In other words, for the
> REJ case enumerated above, one id_map_entry will be leaked.
>
> For the other case above, a DREQ has been received first. The
> reception of the DREQ will trigger queuing of a delayed work to delete
> the id_map_entry, for the case where the VM doesn't send back a DREP.
>
> In the normal case, the VM _will_ send back a DREP, and
> id_map_find_del() will be called.
>
> But this scenario introduces a secondary leak. First, when the DREQ is
> received, a delayed work is queued. The VM will then return a DREP,
> which will call id_map_find_del(). As stated above, this will free the
> TID used from the XArray or IDR. Now, there is window where that
> particular TID can be re-allocated, lets say by an outgoing REQ. This
> TID will later be wiped out by the delayed work, when the function
> id_map_ent_timeout() is called. But the id_map_entry allocated by the
> outgoing REQ will not be de-allocated, and we have a leak.
>
> Both leaks are fixed by removing the id_map_find_del() function and
> only using schedule_delayed(). Of course, a check in
> schedule_delayed() to see if the work already has been queued, has
> been added.
>
> Another benefit of always using the delayed version for deleting
> entries, is that we do get a TimeWait effect; a TID no longer in use,
> will occupy the XArray or IDR for CM_CLEANUP_CACHE_TIMEOUT time,
> without any ability of being re-used for that time period.
>
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>

Thanks a lot,
I added it to our regression system for over weekend run.

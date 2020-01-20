Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACC142F95
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATQ14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 11:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATQ14 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 11:27:56 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C512087E;
        Mon, 20 Jan 2020 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579537675;
        bh=AwkSzdUX1bUUMB0pLCeBQjbfZ4On/A3AJphNLMDaB08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KuQZRhMyS7pQpVXeN/OQg1E9kGVJrj0o/grIpTxYr29OsZoyL27smIx/sCXvyyYKx
         YHHETxDdxv0doOyAAZsPaDrUQCyHkEHUQtEKFuADkSlwsN4WlMOVVM8Hk0WHAs60BL
         kkhU+wsnN7im2OFnFo2xa/FDRyXgdgEeQFF/taJ8=
Date:   Mon, 20 Jan 2020 18:27:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
Message-ID: <20200120162751.GJ51881@unreal>
References: <20200117135622.836563-1-haakon.bugge@oracle.com>
 <20200120150635.GI51881@unreal>
 <71091F31-3206-4654-854B-B751F9A96BBC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71091F31-3206-4654-854B-B751F9A96BBC@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 20, 2020 at 04:49:56PM +0100, Håkon Bugge wrote:
>
>
> > On 20 Jan 2020, at 16:06, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jan 17, 2020 at 02:56:22PM +0100, Håkon Bugge wrote:
> >> Using CX-3 virtual functions, either from a bare-metal machine or
> >> pass-through from a VM, MAD packets are proxied through the PF driver.
> >>
> >> Since the VF drivers have separate name spaces for MAD Transaction Ids
> >> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> >> in a cache.
> >>
> >> Following the RDMA Connection Manager (CM) protocol, it is clear when
> >> an entry has to evicted from the cache. When a DREP is sent from
> >> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
> >> when a REJ is received by the mlx4_ib_demux_cm_handler(),
> >> id_map_find_del() is called.
> >>
> >> This function wipes out the TID in use from the IDR or XArray and
> >> removes the id_map_entry from the table.
> >>
> >> In short, it does everything except the topping of the cake, which is
> >> to remove the entry from the list and free it. In other words, for the
> >> DREP and REJ cases enumerated above, both will leak one id_map_entry.
> >>
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> ---
> >> drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> >> index ecd6cadd529a..1df6d3ccfc62 100644
> >> --- a/drivers/infiniband/hw/mlx4/cm.c
> >> +++ b/drivers/infiniband/hw/mlx4/cm.c
> >> @@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device *ibdev, int pv_cm_id)
> >> 	if (!ent)
> >> 		goto out;
> >> 	found_ent = id_map_find_by_sl_id(ibdev, ent->slave_id, ent->sl_cm_id);
> >> -	if (found_ent && found_ent == ent)
> >> +	if (found_ent && found_ent == ent) {
> >> 		rb_erase(&found_ent->node, sl_id_map);
> >> +		if (!ent->scheduled_delete) {
> >
> > Why do we need to check scheduled_delete?
>
> 1. Node receives a DREQ and mlx4_ib_demux_cm_handler() is called, which again calls schedule_delayed(), which sets scheduled_delete.
>
> 2. DREQ is proxied over to the VM, which replies with a DREP.
>
> 3. The DREP is proxied over to the PF driver, mlx4_ib_multiplex_cm_handler() is called, id_map_find_del() is called. If it is freed now (without checking scheduled_delete), it will be a double free when the delayed work kicks in.

It will be the case if we don't cancel delayed work inside
id_map_find_del(), but it raises other question. Why do we need two
identical delete functions? Can we convert id_map_find_del() callers
to use id_map_ent_timeout() instead?

Thanks

>
> But this documents that the commit message is not accurate, it is only the REJ case that has a leak.
>
> > Isn't this to mark call to timeout cleanup (id_map_ent_timeout), which
> > can't race with id_map_find_del()? They both hold the same spinlock.
>
> No race, but it can be set as per the above.
>
> If you agree, I will send a v2 with corrected commit message.
>
>
> Thxs, Håkon
>
>
> >
> > Thanks
> >
> >> +			list_del(&ent->list);
> >> +			kfree(ent);
> >> +		}
> >> +	}
> >> out:
> >> 	spin_unlock(&sriov->id_map_lock);
> >> }
> >> --
> >> 2.20.1
> >>
>

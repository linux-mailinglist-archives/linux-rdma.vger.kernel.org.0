Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940CE142E58
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgATPGk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 10:06:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgATPGk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 10:06:40 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81192070C;
        Mon, 20 Jan 2020 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579532799;
        bh=uw2pCgS83V5/+K0HGZYh6ef/L3TABGFcvHMNHS3sclM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EN/BtEFsRmHQ1Fn2Ifq2PGi00jnkWlGmN3rHBF2y7r2EGiYcHqcwCGH5Vi7+sNA6o
         uVuPmo/sfQS2BZXInhm4LKl94ozmEV7qg29TD1Uu2Dbng8Iaalr34hgGeshisNOyl0
         yomtdWtxfz4YYynrQrLF5LD4wzio+ppw0Q1XgHpU=
Date:   Mon, 20 Jan 2020 17:06:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
Message-ID: <20200120150635.GI51881@unreal>
References: <20200117135622.836563-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117135622.836563-1-haakon.bugge@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 17, 2020 at 02:56:22PM +0100, Håkon Bugge wrote:
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
> DREP and REJ cases enumerated above, both will leak one id_map_entry.
>
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index ecd6cadd529a..1df6d3ccfc62 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device *ibdev, int pv_cm_id)
>  	if (!ent)
>  		goto out;
>  	found_ent = id_map_find_by_sl_id(ibdev, ent->slave_id, ent->sl_cm_id);
> -	if (found_ent && found_ent == ent)
> +	if (found_ent && found_ent == ent) {
>  		rb_erase(&found_ent->node, sl_id_map);
> +		if (!ent->scheduled_delete) {

Why do we need to check scheduled_delete?

Isn't this to mark call to timeout cleanup (id_map_ent_timeout), which
can't race with id_map_find_del()? They both hold the same spinlock.

Thanks

> +			list_del(&ent->list);
> +			kfree(ent);
> +		}
> +	}
>  out:
>  	spin_unlock(&sriov->id_map_lock);
>  }
> --
> 2.20.1
>

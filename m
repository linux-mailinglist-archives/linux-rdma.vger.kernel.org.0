Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C846287BEB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJHS4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHS4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 14:56:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BA0C061755
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 11:56:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z33so2145109qth.8
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GKuwdbdfDerO0oWysPpz0wBbV1H6nw7CdJXV5w2dnGw=;
        b=JED6KFkgA9w2nyfQh62rVSqIP84AoywDDhTBWf0x/6DFP7kUTJN7hdxFNAd1KHxKiE
         A5NJCFGlGzPXxGPj4tWlnVciECwt5iYh8+bi/YxJBJahr4V71tCjBt6ZiLY9GHLIIia4
         KK0ugm8Iene+tcsSHVAxOZb2AON5ZvaRoneNdK3GxXSzkDJ+1tZEXtMqnu8lAb6uF0/1
         lWVU+/IjyTu/YXLHVdikNwKJ40CvxdXQgRl+zxMfxvYhdCAfJpC3N2hO82mvaBdE3ko8
         C4hcKZb0djH0gtxcVa1Et0Aq/q+tmhWEezWFSQfRK/Uo2li8x36kn/9uEMoO7TJpGy7C
         iXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GKuwdbdfDerO0oWysPpz0wBbV1H6nw7CdJXV5w2dnGw=;
        b=FKsVpKxt1t7ZEi4apdYiqmNmsM2S+PMgGAnjhJNRpqJfEiFcywjuoZd3+GOCprMEh8
         3xfq+3IrgQo8kgRCmG5SSRsgKBn/Wiwv3PT/Pqr8PiKHO90Q+YyngB6PJmGBh7JKsvMJ
         PiiWy1mXXucK5MZoTA9WEehTJTW0LY88dddoOodiiox+p/SloL57rJyBOIY4aR0uHb5T
         /CLwVTTkF7wkW50ME94loOfbXgmPOliG9QkcAIVKNQoRP9SY9ZIKL51LX3lxRwsZQEk1
         FIsg6zWHkmsn5j0rzhEuxobvw2/5XceGz0T4/X8u7Fhv6nshgnw2oLMQy+uhuXbqJcBq
         9xfg==
X-Gm-Message-State: AOAM533lzEKaxkSlHZ3tFacsRAmjesuoeHuDUS9Q+gK2GWK7l5fBgPYt
        Gv+23T/qhOe55HLYwABvpX7MxaU1Gv9OP1ug
X-Google-Smtp-Source: ABdhPJyfqJ3aznb+6O1yRVdoCk4eSiVlT7WnVG/pWbkjgrH9G780oAWWvMN3iA2H6cEv+yam8cASRQ==
X-Received: by 2002:aed:23fc:: with SMTP id k57mr9404963qtc.216.1602183379882;
        Thu, 08 Oct 2020 11:56:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f8sm4519268qkb.123.2020.10.08.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 11:56:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQb5O-001a1n-I8; Thu, 08 Oct 2020 15:56:18 -0300
Date:   Thu, 8 Oct 2020 15:56:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] IB/mlx4: Convert rej_tmout radix-tree to XArray
Message-ID: <20201008185618.GK5177@ziepe.ca>
References: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 03:07:14PM +0200, Håkon Bugge wrote:
> Fixes: b7d8e64fa9db ("IB/mlx4: Add support for REJ due to timeout")
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>  drivers/infiniband/hw/mlx4/cm.c      | 73 +++++++++++++++---------------------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h |  4 +-
>  2 files changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index 0ce4b5a..6c7986b 100644
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -58,9 +58,7 @@ struct rej_tmout_entry {
>  	int slave;
>  	u32 rem_pv_cm_id;
>  	struct delayed_work timeout;
> -	struct radix_tree_root *rej_tmout_root;
> -	/* Points to the mutex protecting this radix-tree */
> -	struct mutex *lock;
> +	struct xarray *xa_rej_tmout;
>  };
>  
>  struct cm_generic_msg {
> @@ -350,9 +348,7 @@ static void rej_tmout_timeout(struct work_struct *work)
>  	struct rej_tmout_entry *item = container_of(delay, struct rej_tmout_entry, timeout);
>  	struct rej_tmout_entry *deleted;
>  
> -	mutex_lock(item->lock);
> -	deleted = radix_tree_delete_item(item->rej_tmout_root, item->rem_pv_cm_id, NULL);
> -	mutex_unlock(item->lock);
> +	deleted = xa_cmpxchg(item->xa_rej_tmout, item->rem_pv_cm_id, item, NULL, 0);
>  
>  	if (deleted != item)
>  		pr_debug("deleted(%p) != item(%p)\n", deleted, item);
> @@ -363,14 +359,13 @@ static void rej_tmout_timeout(struct work_struct *work)
>  static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int slave)
>  {
>  	struct rej_tmout_entry *item;
> -	int sts;
> +	struct rej_tmout_entry *old;
> +
> +	item = xa_load(&sriov->xa_rej_tmout, (unsigned long)rem_pv_cm_id);

The locking that was here looks wrong, rej_tmout_timeout() is a work
that could run at any time and kfree(item), so some kind of lock must
be held across every touch to item

Holding the xa_lock until the mod_delayed_work is done would be ok?

>  static int lookup_rej_tmout_slave(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id)
>  {
>  	struct rej_tmout_entry *item;
>  
> -	mutex_lock(&sriov->rej_tmout_lock);
> -	item = radix_tree_lookup(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id);
> -	mutex_unlock(&sriov->rej_tmout_lock);
> +	item = xa_load(&sriov->xa_rej_tmout, (unsigned long)rem_pv_cm_id);
>  
> -	if (!item || IS_ERR(item)) {
> +	if (!item || xa_err(item)) {
>  		pr_debug("Could not find slave. rem_pv_cm_id 0x%x error: %d\n",
> -			 rem_pv_cm_id, (int)PTR_ERR(item));
> -		return !item ? -ENOENT : PTR_ERR(item);
> +			 rem_pv_cm_id, xa_err(item));
> +		return !item ? -ENOENT : xa_err(item);
>  	}
>  
>  	return item->slave;

Here too

> +	xa_lock(&sriov->xa_rej_tmout);
> +	xa_for_each(&sriov->xa_rej_tmout, id, item) {
>  		if (slave < 0 || slave == item->slave) {
>  			mod_delayed_work(system_wq, &item->timeout, 0);
>  			flush_needed = true;
>  			++cnt;
>  		}
>  	}
> -	mutex_unlock(&sriov->rej_tmout_lock);
> +	xa_unlock(&sriov->xa_rej_tmout);

This is OK

Jason

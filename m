Return-Path: <linux-rdma+bounces-8776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2FA67144
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1522F3BAFA8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550F207E0F;
	Tue, 18 Mar 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNKyTDRt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7E20767B
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293724; cv=none; b=TR3vyGSkUX29Y8l2Ln3XZMuTPF/GZwK0xVjUfWdY7wne0iB89g4FLypXMJuxKCDq4pBg41EIOn3MrPovsUHLoPPs/osev9Wr3t7ljrwEOVKz0mnWaFn4FY4y/CTyrfEYUVpCrGVAUqQb97k3Qn+dNY6XtFaa1w3luVw26EgsMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293724; c=relaxed/simple;
	bh=ElucD+4LqHN6FFKbwLV16ZYRgETSZ8PgHslxVeuZ4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXbc7TihZutrzMcPrjDKFhYBLOCegDzt5kWGdhMTGql8d8ZfmotCCYlYUtcWcTwVpRcdxoQ1ZLTwUvIQvgfvH9S/MPJm/WdrAfHpFm7VJOIqT+bMTnfL5I6Fuon0y1HpTEVBDgoYt6FhuX5gt5QSjeVTRG6UO664UpyDWqPeO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNKyTDRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DFFC4CEDD;
	Tue, 18 Mar 2025 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742293723;
	bh=ElucD+4LqHN6FFKbwLV16ZYRgETSZ8PgHslxVeuZ4Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNKyTDRtSdYiWTrIzFZzGR/0+O08WL5giA24vZOZjlVETe49HyBbaA4DkmKKaQFXR
	 HSUnJ/S5sqeywlPhTdgDgacEez7sZaoFz2g3Boqn0xxRA8vPZHwN29WfEB73ndYC4Y
	 WSS8VskYcDDk7hbM/RWuTdtAByW7Di/mVgK7p2mpXHovLXTFLOCEETqAdEZ0kL95Em
	 o3z/CKE55HkmjfyXfft6kHYXvnwqNMobfsgMyOcfhAbJ3jPuSBV86ae7hBktN5tpVo
	 3TGoD/wB5XosnWsDAAu4Xx6OjAbwqk7hX/w+pXyx1aPD6jLHlOLSKQSuu5KifuZ4yK
	 Prwnjg9Jx+tHw==
Date: Tue, 18 Mar 2025 12:28:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 2/7] RDMA/mlx5: Fix cache entry update on dereg
 error
Message-ID: <20250318102839.GB1322339@unreal>
References: <cover.1741875692.git.leon@kernel.org>
 <97e979dff636f232ff4c83ce709c17c727da1fdb.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e979dff636f232ff4c83ce709c17c727da1fdb.1741875692.git.leon@kernel.org>

On Thu, Mar 13, 2025 at 04:29:49PM +0200, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> Fix double decrement of 'in_use' counter on push_mkey_locked() failure
> while deregistering an MR.
> If we fail to return an mkey to the cache in cache_ent_find_and_store()
> it'll update the 'in_use' counter. Its caller, revoke_mr(), also updates
> it, thus having double decrement.
> 
> Wrong value of 'in_use' counter will be exposed through debugfs and can
> also cause wrong resizing of the cache when users try to set cache
> entry size using the 'size' debugfs.
> 
> To address this issue, the 'in_use' counter is now decremented within
> mlx5_revoke_mr() also after a successful call to
> cache_ent_find_and_store() and not within cache_ent_find_and_store().
> Other success or failure flows remains unchanged where it was also
> decremented.
> 
> Fixes: 8c1185fef68c ("RDMA/mlx5: Change check for cacheable mkeys")
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<...>

> @@ -2042,6 +2041,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
>  		ent = mr->mmkey.cache_ent;
>  		/* upon storing to a clean temp entry - schedule its cleanup */
>  		spin_lock_irq(&ent->mkeys_queue.lock);
> +		ent->in_use--;

This needs slightly different fix, fixed it locally.
@@ -2033,6 +2032,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
        struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
        struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
        bool is_odp = is_odp_mr(mr);
+       bool from_cache = !!ent;
        int ret = 0;

        if (is_odp)
@@ -2042,6 +2042,8 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
                ent = mr->mmkey.cache_ent;
                /* upon storing to a clean temp entry - schedule its cleanup */
                spin_lock_irq(&ent->mkeys_queue.lock);
+               if (from_cache)
+                       ent->in_use--;
                if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
                        mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
                                         msecs_to_jiffies(30 * 1000));


>  		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
>  			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
>  					 msecs_to_jiffies(30 * 1000));
> -- 
> 2.48.1
> 
> 


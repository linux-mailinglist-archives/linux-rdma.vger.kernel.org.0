Return-Path: <linux-rdma+bounces-13364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE9B5741D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 11:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D7C1A21DB7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5612EFD80;
	Mon, 15 Sep 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Y3Zl9t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D31F30BB;
	Mon, 15 Sep 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927288; cv=none; b=nM9X259CtvvEhIyLPoPWmWQjW0t1YGat8ScgEkr9F1CKqbk7Nyfvv+4vQA32gttLE6FI9sYmWAvJi0BB09a66omM8PSXHU8ET9dXogwzEsLzHdQOokXxCfsfHXqP4AaCIXQUkcjkf3HhAhnxawy/cdEn3ZL7Quy+fIr1m0TcekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927288; c=relaxed/simple;
	bh=rdmU8XtIiyaAZo1ozKb8u794i2m7nr5UIQUOiAgCmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqN+V5fyY/H6TffYTwuNORQe2oiRZAr48E1rg2zc66ByBh4kOMzOHbLdg8XGSgWmfegCz1RmvVE+jKiSPMuDLzQn8xrmRf9VSKrZjAPF/ddTak81NFI3OkgzvDOxtwv/NM2QvRuvV9Ln+vgwTxXGbFWuqthdBWvcEG7/DlUqwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0Y3Zl9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBA1C4CEF9;
	Mon, 15 Sep 2025 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757927287;
	bh=rdmU8XtIiyaAZo1ozKb8u794i2m7nr5UIQUOiAgCmRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0Y3Zl9tr9rZnyayfArlslImUYTjwCENJk9uhd4VRzkWjaiQT9ZsvL8cI9EWJm13i
	 Uw1WOmMiH81G+7XM7hBEcpIfU3wYGgK0odaCKjrtVVAaFkA2dVfVBdWwpFEnJErUe8
	 SqBLnzRUOB8f+mIEs29xCV7nebv7uPx1ITX0Amtr+anDZLojMZMclCSlh9tuCOpmGR
	 gvKx0ACxc0nwqwf4+dq+Z/nfULqkW4nPBESDiec3jwt2TwvXg4jf5iY6EQg+lVzXQC
	 ZP2zz8ayFz7Kr+X1Uhh+yvJX8IrfU45AqtcmugOj8lr7rvxoRuBN+H3imiJ7Dc8WEV
	 8Xm+PJ0tF0tkQ==
Date: Mon, 15 Sep 2025 12:08:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 1/4] net/mlx5: Refactor devcom to use match
 attributes
Message-ID: <20250915090802.GC9353@unreal>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757572267-601785-2-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 09:31:04AM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Refactor the devcom interface to use a match attribute structure instead
> of passing raw keys. This change lays the groundwork for extending devcom
> matching logic with additional fields like net namespace, improving its
> flexibility and robustness.
> 
> No functional changes.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +++-
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  7 +++--
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 +++--
>  .../mellanox/mlx5/core/eswitch_offloads.c     |  5 +--
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 14 ++++++---
>  .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 31 +++++++++++++------
>  .../ethernet/mellanox/mlx5/core/lib/devcom.h  | 10 +++++-
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 ++-
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++--
>  9 files changed, 65 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 714cce595692..fe5f5ae433b7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -235,9 +235,13 @@ static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
>  
>  static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
>  {
> +	struct mlx5_devcom_match_attr attr = {
> +		.key.val = *data,
> +	};
> +
>  	priv->devcom = mlx5_devcom_register_component(priv->mdev->priv.devc,
>  						      MLX5_DEVCOM_MPV,
> -						      *data,
> +						      &attr,
>  						      mlx5e_devcom_event_mpv,
>  						      priv);
>  	if (IS_ERR(priv->devcom))
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 32c07a8b03d1..9874a15c6fba 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5387,12 +5387,13 @@ void mlx5e_tc_ht_cleanup(struct rhashtable *tc_ht)
>  int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
>  {
>  	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
> +	struct mlx5_devcom_match_attr attr = {};
>  	struct netdev_phys_item_id ppid;
>  	struct mlx5e_rep_priv *rpriv;
>  	struct mapping_ctx *mapping;
>  	struct mlx5_eswitch *esw;
>  	struct mlx5e_priv *priv;
> -	u64 mapping_id, key;
> +	u64 mapping_id;
>  	int err = 0;
>  
>  	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
> @@ -5448,8 +5449,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
>  
>  	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
>  	if (!err) {
> -		memcpy(&key, &ppid.id, sizeof(key));
> -		mlx5_esw_offloads_devcom_init(esw, key);
> +		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
> +		mlx5_esw_offloads_devcom_init(esw, &attr);
>  	}
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 4fe285ce32aa..df3756d7e52e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -433,7 +433,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
>  void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
>  void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
>  void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
> -void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key);
> +void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
> +				   const struct mlx5_devcom_match_attr *attr);
>  void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
>  bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw);
>  int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
> @@ -928,7 +929,9 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
>  static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
>  static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
>  static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
> -static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key) {}
> +static inline void
> +mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
> +			      const struct mlx5_devcom_match_attr *attr) {}
>  static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
>  static inline bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw) { return false; }
>  static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index d57f86d297ab..bc9838dc5bf8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3104,7 +3104,8 @@ static int mlx5_esw_offloads_devcom_event(int event,
>  	return err;
>  }
>  
> -void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
> +void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
> +				   const struct mlx5_devcom_match_attr *attr)
>  {
>  	int i;
>  
> @@ -3123,7 +3124,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
>  	esw->num_peers = 0;
>  	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
>  						     MLX5_DEVCOM_ESW_OFFLOADS,
> -						     key,
> +						     attr,
>  						     mlx5_esw_offloads_devcom_event,
>  						     esw);
>  	if (IS_ERR(esw->devcom))
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 7ad3baca99de..8f2ad45bec9f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -1435,14 +1435,20 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev, bool shared)
>  static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
>  {
>  	struct mlx5_core_dev *peer_dev, *next = NULL;
> +	struct mlx5_devcom_match_attr attr = {
> +		.key.val = key,
> +	};
> +	struct mlx5_devcom_comp_dev *compd;
>  	struct mlx5_devcom_comp_dev *pos;
>  
> -	mdev->clock_state->compdev = mlx5_devcom_register_component(mdev->priv.devc,
> -								    MLX5_DEVCOM_SHARED_CLOCK,
> -								    key, NULL, mdev);
> -	if (IS_ERR(mdev->clock_state->compdev))
> +	compd = mlx5_devcom_register_component(mdev->priv.devc,
> +					       MLX5_DEVCOM_SHARED_CLOCK,
> +					       &attr, NULL, mdev);
> +	if (IS_ERR(compd))
>  		return;
>  
> +	mdev->clock_state->compdev = compd;
> +
>  	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
>  	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
>  		if (peer_dev->clock) {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> index 7b0766c89f4c..1ab9de316deb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> @@ -22,11 +22,15 @@ struct mlx5_devcom_dev {
>  	struct kref ref;
>  };
>  
> +struct mlx5_devcom_key {
> +	union mlx5_devcom_match_key key;
> +};
> +
>  struct mlx5_devcom_comp {
>  	struct list_head comp_list;
>  	enum mlx5_devcom_component id;
> -	u64 key;
>  	struct list_head comp_dev_list_head;
> +	struct mlx5_devcom_key key;
>  	mlx5_devcom_event_handler_t handler;
>  	struct kref ref;
>  	bool ready;
> @@ -108,7 +112,8 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc)
>  }
>  
>  static struct mlx5_devcom_comp *
> -mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
> +mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
> +		       mlx5_devcom_event_handler_t handler)
>  {
>  	struct mlx5_devcom_comp *comp;
>  
> @@ -117,7 +122,7 @@ mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
>  		return ERR_PTR(-ENOMEM);
>  
>  	comp->id = id;
> -	comp->key = key;
> +	comp->key.key = attr->key;
>  	comp->handler = handler;
>  	init_rwsem(&comp->sem);
>  	lockdep_register_key(&comp->lock_key);
> @@ -180,21 +185,27 @@ devcom_free_comp_dev(struct mlx5_devcom_comp_dev *devcom)
>  static bool
>  devcom_component_equal(struct mlx5_devcom_comp *devcom,
>  		       enum mlx5_devcom_component id,
> -		       u64 key)
> +		       const struct mlx5_devcom_match_attr *attr)
>  {
> -	return devcom->id == id && devcom->key == key;
> +	if (devcom->id != id)
> +		return false;
> +
> +	if (memcmp(&devcom->key.key, &attr->key, sizeof(devcom->key.key)))
> +		return false;
> +
> +	return true;
>  }
>  
>  static struct mlx5_devcom_comp *
>  devcom_component_get(struct mlx5_devcom_dev *devc,
>  		     enum mlx5_devcom_component id,
> -		     u64 key,
> +		     const struct mlx5_devcom_match_attr *attr,
>  		     mlx5_devcom_event_handler_t handler)
>  {
>  	struct mlx5_devcom_comp *comp;
>  
>  	devcom_for_each_component(comp) {
> -		if (devcom_component_equal(comp, id, key)) {
> +		if (devcom_component_equal(comp, id, attr)) {
>  			if (handler == comp->handler) {
>  				kref_get(&comp->ref);
>  				return comp;
> @@ -212,7 +223,7 @@ devcom_component_get(struct mlx5_devcom_dev *devc,
>  struct mlx5_devcom_comp_dev *
>  mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
>  			       enum mlx5_devcom_component id,
> -			       u64 key,
> +			       const struct mlx5_devcom_match_attr *attr,
>  			       mlx5_devcom_event_handler_t handler,
>  			       void *data)
>  {
> @@ -223,14 +234,14 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
>  		return ERR_PTR(-EINVAL);
>  
>  	mutex_lock(&comp_list_lock);
> -	comp = devcom_component_get(devc, id, key, handler);
> +	comp = devcom_component_get(devc, id, attr, handler);
>  	if (IS_ERR(comp)) {
>  		devcom = ERR_PTR(-EINVAL);
>  		goto out_unlock;
>  	}
>  
>  	if (!comp) {
> -		comp = mlx5_devcom_comp_alloc(id, key, handler);
> +		comp = mlx5_devcom_comp_alloc(id, attr, handler);
>  		if (IS_ERR(comp)) {
>  			devcom = ERR_CAST(comp);
>  			goto out_unlock;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> index c79699b94a02..f350d2395707 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
> @@ -6,6 +6,14 @@
>  
>  #include <linux/mlx5/driver.h>
>  
> +union mlx5_devcom_match_key {
> +	u64 val;
> +};
> +
> +struct mlx5_devcom_match_attr {
> +	union mlx5_devcom_match_key key;
> +};
> +
>  enum mlx5_devcom_component {
>  	MLX5_DEVCOM_ESW_OFFLOADS,
>  	MLX5_DEVCOM_MPV,
> @@ -25,7 +33,7 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc);
>  struct mlx5_devcom_comp_dev *
>  mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
>  			       enum mlx5_devcom_component id,
> -			       u64 key,
> +			       const struct mlx5_devcom_match_attr *attr,
>  			       mlx5_devcom_event_handler_t handler,
>  			       void *data);
>  void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index eeb0b7ea05f1..d4015328ba65 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -210,13 +210,15 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
>  static int sd_register(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_devcom_comp_dev *devcom, *pos;
> +	struct mlx5_devcom_match_attr attr = {};
>  	struct mlx5_core_dev *peer, *primary;
>  	struct mlx5_sd *sd, *primary_sd;
>  	int err, i;
>  
>  	sd = mlx5_get_sd(dev);
> +	attr.key.val = sd->group_id;
>  	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
> -						sd->group_id, NULL, dev);
> +						&attr, NULL, dev);
>  	if (IS_ERR(devcom))
>  		return PTR_ERR(devcom);
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 0951c7cc1b5f..1f7942202e14 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -975,6 +975,10 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
>  
>  static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
>  {
> +	struct mlx5_devcom_match_attr attr = {
> +		.key.val = mlx5_query_nic_system_image_guid(dev),
> +	};
> +
>  	/* This component is use to sync adding core_dev to lag_dev and to sync
>  	 * changes of mlx5_adev_devices between LAG layer and other layers.
>  	 */
> @@ -983,8 +987,7 @@ static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
>  
>  	dev->priv.hca_devcom_comp =
>  		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
> -					       mlx5_query_nic_system_image_guid(dev),
> -					       NULL, dev);
> +					       &attr, NULL, dev);
>  	if (IS_ERR(dev->priv.hca_devcom_comp))

Because you are changing mlx5_devcom_register_component() signature
anyway, please do one step more and make sure that mlx5_devcom_register_component()
returns or NULL or successful devcom pointer. The thing is that devcom
pointer has error code which is stored for whole lifetime of the driver
is causing issues in mlx5_ib IPsec cleanup for multi-port devices.

Thanks

>  		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
>  }
> -- 
> 2.31.1
> 


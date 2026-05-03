Return-Path: <linux-rdma+bounces-19870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO1KKKWo9mmgXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:45:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F280C4B407B
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36400300A8D7
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF3245020;
	Sun,  3 May 2026 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JemTb5lb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B8242D7F;
	Sun,  3 May 2026 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772703; cv=none; b=nXpl4R724D1sSES07MbBt8olvlHbiajtj97A/1IHvt4e1wUA/InNwqkREbJZB3ONgTyhwcB5tLxvlnf8dPtQCFvDSDzBgI6wmJy/6X9Q3Cs3hHEe4nKJulPQ19GUU9fodk+cVin4A41mdrlPBUtOUGJACLZCs5sqwK+ZwrG2Rkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772703; c=relaxed/simple;
	bh=f5BVVl5dYTMXLvjLglm+1jEFqV3SnZBjj6+FguEdqu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9WMb/mF634/YioNza6g9CESVcrEjF9WAqwzJi36kkFCF/Zsw8i/aSB5rDW2O4EBtajDh2wWjBOEiqvBCtf+VkIruI2eYs7x867uaSjngSK6GX5zbZPAjDES1qslXBPdPgcuy/eaOgzwnSLkg+M80VmimOt6E2t/M8l7Y866rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JemTb5lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8650BC19425;
	Sun,  3 May 2026 01:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772703;
	bh=f5BVVl5dYTMXLvjLglm+1jEFqV3SnZBjj6+FguEdqu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JemTb5lbrhFpYPTc9mzUdj7fP/jy6Qgdnl4YmMEqDqssw+tWxFqmA0mI7F5DKD1Up
	 iMcttJmGK8fDXjAzIm1XG4iBSydH3qwVW7wRi59sG2dagqvfV6dxLxmpPDvp2cP1R9
	 EsGqxod/6AAOM8YAq3AKTV3WaiYzUb4t8SoYB7lI1CXxFlPgPvVPvfucvdkm6JSOzt
	 KICrbPrhfEEXm/PTQ+q2wNPu8Sy7Eh+w+cktcyYq1NGvjOCM6yg0x8MqYj7YLW0df/
	 eYXogPefSx6RT3031rrX7HoHKVlfsvnjEmlpiqa/MthNjKZdEW3vjWl4KAcafXkirR
	 PkxytWUrbCDHw==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	agoldberger@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com
Subject: Re: [PATCH net-next 3/3] net/mlx5: Add VHCA_ID page management mode support
Date: Sat,  2 May 2026 18:45:01 -0700
Message-ID: <20260503014501.4098393-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501044156.260875-4-tariqt@nvidia.com>
References: <20260501044156.260875-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F280C4B407B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-19870-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: Add VHCA_ID page management mode support

This change adds a VHCA_ID-based page management mode that uses vhca_id
instead of function_id as the effective function identifier when the
firmware advertises icm_mng_function_id_mode. Boot pages keep FUNC_ID
semantics for backward compatibility, and tracked pages are migrated to
the vhca_id key after set_hca_cap().

A few questions below on the per-type counter accounting, the boot-page
migration helper, and locking on the FW-driven page path.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index e0eafcf0c52a..d3eaefc5c0e0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -852,6 +852,48 @@ bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>  	return true;
>  }
>  
> +u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
> +{
> +	struct mlx5_eswitch *esw = dev->priv.eswitch;
> +	struct mlx5_vport *vport;
> +	unsigned long i;
> +	u16 type;
> +
> +	if (vhca_id == MLX5_CAP_GEN(dev, vhca_id))
> +		return MLX5_SELF;
> +
> +	if (!esw)
> +		return MLX5_FUNC_TYPE_NONE;
> +
> +	mutex_lock(&esw->state_lock);

This function is reached from give_pages()/reclaim_pages()/
release_all_pages() via func_vhca_id_to_type(), which in turn runs
from the pg_wq work handler triggered by firmware page-request EQE
events. Does acquiring esw->state_lock on that path introduce a new
lock dependency?

Several eswitch paths (for example mlx5_esw_vport_enable(),
mlx5_esw_vport_disable(), mlx5_eswitch_set_vport_mac()) hold
state_lock while synchronously issuing firmware commands. Before this
patch, the page path held no eswitch locks.

Would it be safer to resolve the func_type outside of state_lock, for
example by caching the vhca_id-to-type mapping separately, or by
attaching the resolved type to the fw_page at give time so reclaim
does not need to look it up again?

> +	mlx5_esw_for_each_vport(esw, i, vport) {
> +		if (vport->vhca_id != vhca_id)
> +			continue;
> +
> +		if (vport->vport == MLX5_VPORT_HOST_PF) {
> +			type = MLX5_HOST_PF;
> +			goto unlock;
> +		}
> +
> +		if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_SF)) {
> +			type = MLX5_SF;
> +			goto unlock;
> +		}
> +
> +		if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_VF)) {
> +			type = MLX5_VF;
> +			goto unlock;
> +		}
> +
> +		type = MLX5_EC_VF;
> +		goto unlock;

Can this fall-through misattribute counters?

If a matching vport is not HOST_PF and has neither the VPT_SF nor the
VPT_VF mark, it is unconditionally classified as MLX5_EC_VF. Would an
UPLINK, ECPF, manager, or adjacent-style vport whose vhca_id happens
to match end up charged to the EC_VF bucket here?

> +	}
> +	type = MLX5_FUNC_TYPE_NONE;
> +unlock:
> +	mutex_unlock(&esw->state_lock);
> +	return type;
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index a242053f3a58..52cf341ad6b3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -597,6 +597,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
>  	if (MLX5_CAP_GEN_MAX(dev, release_all_pages))
>  		MLX5_SET(cmd_hca_cap, set_hca_cap, release_all_pages, 1);
>  
> +	if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode))
> +		MLX5_SET(cmd_hca_cap, set_hca_cap, icm_mng_function_id_mode, 1);
> +

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 77ffa31cc505..7ebe88aa3b3e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c

[ ... ]

> @@ -89,12 +105,21 @@ static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_funct
>  	return MLX5_SF;
>  }
>  
> +static u16 func_vhca_id_to_type(struct mlx5_core_dev *dev, u16 func_vhca_id,
> +				bool ec_function)
> +{
> +	if (mlx5_page_mgt_mode_is_vhca_id(dev))
> +		return mlx5_esw_vhca_id_to_func_type(dev, func_vhca_id);
> +
> +	return func_id_to_type(dev, func_vhca_id, ec_function);
> +}

Can the give/reclaim accounting become asymmetric in VHCA_ID mode?

The per-type counters are only updated when the resolved type is not
MLX5_FUNC_TYPE_NONE:

	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
	if (func_type != MLX5_FUNC_TYPE_NONE)
		dev->priv.page_counters[func_type] += npages;

Since mlx5_esw_vhca_id_to_func_type() walks the eswitch vport table
dynamically on every call, can the give and the corresponding reclaim
resolve to different types?

For example, if a give runs before vport->vhca_id is populated in
mlx5_esw_vport_caps_get(), the lookup returns MLX5_FUNC_TYPE_NONE and
the counter is not incremented. Later, when the vport is fully
populated, reclaim resolves to a real type and decrements the counter
below the amount ever added, which on a u32 drives it to a very large
value.

Similarly, if a vport is removed before reclaim, the increment at
give time is recorded but the decrement at reclaim is skipped, so the
counter leaks upward.

Would caching the func_type on the fw_page at give time and reusing
it on reclaim make the accounting symmetric by construction?

[ ... ]

> @@ -658,30 +708,101 @@ static int req_pages_handler(struct notifier_block *nb,
>  	 * req->npages (and not min ()).
>  	 */
>  	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
> -	req->ec_function = ec_function;
> +	if (!mlx5_page_mgt_mode_is_vhca_id(dev))
> +		req->ec_function = ec_function;
>  	req->release_all = release_all;
>  	INIT_WORK(&req->work, pages_work_handler);
>  	queue_work(dev->priv.pg_wq, &req->work);
>  	return NOTIFY_OK;
>  }
>  
> +/*
> + * After set_hca_cap(), the second satisfy_startup_pages(dev, 0) may see
> + * VHCA_ID mode. If page_root_xa already has the PF entry from the first
> + * (boot) call under FUNC_ID keys 0 or (ec_function << 16), migrate that
> + * entry to the device vhca_id key so lookups use VHCA_ID semantics.
> + */
> +static int mlx5_pagealloc_migrate_pf_to_vhca_id(struct mlx5_core_dev *dev)
> +{
> +	u32 vhca_id_key, old_key;
> +	struct rb_root *root;
> +	struct fw_page *fwp;
> +	struct rb_node *p;
> +	bool ec_function;
> +	int err;
> +
> +	if (xa_empty(&dev->priv.page_root_xa))
> +		return 0;
> +
> +	vhca_id_key = MLX5_CAP_GEN(dev, vhca_id);
> +	ec_function = mlx5_core_is_ecpf(dev);
> +
> +	old_key = ec_function ? (1U << 16) : 0;
> +	root = xa_load(&dev->priv.page_root_xa, old_key);
> +	if (!root)
> +		return 0;

Does this assume the boot-path func_vhca_id was always 0?

The boot call to mlx5_cmd_query_pages() reads func_vhca_id directly
from the firmware output, and give_pages() then uses that value to
compute the key. The migration here instead hardcodes old_key as
ec_function ? (1U << 16) : 0.

If firmware returned a non-zero boot function_id, xa_load(old_key)
returns NULL, the function silently returns 0, the caller flips the
mode to VHCA_ID, and the original rb_root is orphaned in page_root_xa
under the old key. Subsequent free_fwp()/find_fw_page() paths would
then hit WARN_ON_ONCE(!root) and leak the DMA mappings and pages.

Would it be more robust to look up the actual key used at boot
(derived from the stored func_vhca_id), and to treat the "xa not
empty but old_key absent" case as an invariant violation rather than
silently succeeding?

> +
> +	if (old_key == vhca_id_key)
> +		return 0;
> +
> +	err = xa_insert(&dev->priv.page_root_xa, vhca_id_key, root, GFP_KERNEL);
> +	if (err) {
> +		mlx5_core_warn(dev,
> +			       "failed to migrate page root key 0x%x to vhca_id 0x%x\n",
> +			       old_key, vhca_id_key);
> +		return err;
> +	}
> +
> +	xa_erase(&dev->priv.page_root_xa, old_key);
> +
> +	for (p = rb_first(root); p; p = rb_next(p)) {
> +		fwp = rb_entry(p, struct fw_page, rb_node);
> +		fwp->function = vhca_id_key;
> +	}

Is the ordering here safe against any concurrent free_fwp()?

Between xa_erase(old_key) and the loop that updates fwp->function,
every fw_page still carries the old key while page_root_xa no longer
resolves it. If a free_fwp() were to run in that window:

	root = xa_load(&dev->priv.page_root_xa, fwp->function);
	if (WARN_ON_ONCE(!root))
		return;

it would return early, skipping dma_unmap_page(), __free_page(), and
kfree(fwp), leaking the DMA mapping and the backing page.

No concurrent free path is structurally reachable today because this
runs before the EQ notifier is registered in mlx5_pagealloc_start(),
but would it be cleaner to update the fwp->function values first,
then swap the xarray entries (or store the new value at a single key)
so the two views cannot disagree?

> +
> +	return 0;
> +}
> +
>  int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
>  {
> -	u16 func_id;
> +	bool ec_function = false;
> +	u16 func_vhca_id;
>  	s32 npages;
>  	int err;
>  
> -	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
> +	/* When boot flag is set, the icm_mng_function_id_mode capability is
> +	 * not yet set (only set after set_hca_cap()), so use FUNC_ID mode
> +	 * for backward compatibility. When boot is false, set mode from
> +	 * cap (set_hca_cap has run successfully).
> +	 */
> +	if (boot) {
> +		mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_FUNC_ID);
> +	} else {
> +		if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
> +		    MLX5_ID_MODE_FUNCTION_VHCA_ID) {

The comment just above says "set mode from cap (set_hca_cap has run
successfully)", which reads as "use the current/negotiated cap value",
but the check uses MLX5_CAP_GEN_MAX rather than MLX5_CAP_GEN. The
sibling code in drivers/net/ethernet/mellanox/mlx5/core/debugfs.c uses
MLX5_CAP_GEN(dev, icm_mng_function_id_mode) for the same semantic
check.

Could the comment and the _MAX usage be made consistent? If anyone
later adds a conditional around the MLX5_SET() in handle_hca_cap()
(for example a module parameter), the driver would start flipping to
VHCA_ID mode based on _MAX without actually having enabled the feature
in firmware.

> +			err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
> +			if (err)
> +				return err;
> +			mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
> +		}
> +	}

Once page_mgt_mode is flipped to MLX5_PAGE_MGT_MODE_VHCA_ID, it stays
set in dev->priv and is only reset on the next boot=1 call. Between
teardown and the next boot=1 path (for example during health
recovery, PCI reset, or any async flow that runs page work before
mlx5_satisfy_startup_pages(dev, 1) re-runs), would a FW page-request
EQE observe a stale mode?

The req_pages EQ notifier is registered via mlx5_pagealloc_start()
and unregistered via mlx5_pagealloc_stop(), so this is not reachable
today, but would it be worth resetting the mode explicitly on the
teardown side rather than relying on the next reinit?

[ ... ]

> @@ -751,6 +874,9 @@ int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev)
>  	WARN(dev->priv.fw_pages,
>  	     "FW pages counter is %d after reclaiming all pages\n",
>  	     dev->priv.fw_pages);
> +	if (mlx5_page_mgt_mode_is_vhca_id(dev) && !dev->priv.eswitch)
> +		return 0;
> +

Does this guard address the asymmetric-counter case raised above?

It only skips the per-type WARNs when the eswitch is entirely absent.
In the common case where the eswitch is present but a vport's
vhca_id/marks change between give and reclaim, the counters can still
drift and these WARNs would still fire on normal teardown paths.

[ ... ]


Return-Path: <linux-rdma+bounces-21162-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLMjMGKfEGpuawYAu9opvQ
	(envelope-from <linux-rdma+bounces-21162-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 20:24:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595615B8FC3
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 20:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36EA630103A7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FEC370D7C;
	Fri, 22 May 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpZMAUki"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6336C9EB;
	Fri, 22 May 2026 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473987; cv=none; b=jWa5raKcA4X19nxR7DRK8pqdRqjdeo3IIocvEa1R43zAV3TzbM3xdtJeA6qMd/b8hfXt6+VcP0R6B7BObwBDfyjGq2MtGMJ85wHI+qnqIK1kP6Yk9DZseH+vQfxIcEAortAaqYWGF/EK8U8ToDWwvoV5OpcFJt4jdLubkOv1BXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473987; c=relaxed/simple;
	bh=M9I0noxrTUL68HDfYD0HwCW/nObwsQJ0bgl9RUEqbRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCrza6FBwoxHsg8HCXxRUyFT78474NWcAVIGTY/JNW3c2JGaafH/6Y3PvVpdZc8Jv6qytTHv2cx9SoXyOuFII2KwMQZV009evTQTTrpqLsmhaSMpQx2l6PlafdNvjLt8ASeupG25I+veAMcuqjCIxKdurkEJNqmY5yUmhMt+aVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpZMAUki; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873961F000E9;
	Fri, 22 May 2026 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473985;
	bh=8SjMrL9BQuJAplU4F2qtA3QLg7Gv2hZ7w4WdFbn90pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hpZMAUkiG93ieiEyh+FqxKOBo9MNKI+CoRx5wDcscpRGAkSY+09k2REmAx9mytA9O
	 zUmc3eLybhHjZ7/KieMSjV+fdEWjMqgHhkRucPfD5FUQLyeE/xCHhTGH+ehHcv2iUa
	 bTeOmcIm0OvlWNnfQcXpg99+SzZpfNAxFtkS69+vGpSxoUY70y5PC76Kn3oJAgpxEe
	 3oaMuCgQrmqGlAzi48g5pgxoNNBB6Bl8qdgb9zQPXortnGjPQ8WPyCFv1a5DUF1Mkp
	 nS9+bYom4JihQyJXdcR2APISGF7dZU/kLhvLvghe1VspDS/fhirJ4nu24YU8BI/DG5
	 YnMmPsOwTMTMw==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	vdumitrescu@nvidia.com,
	aleksandr.loktionov@intel.com,
	daniel.zahka@gmail.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com,
	jiri@nvidia.com,
	nikolay@nvidia.com
Subject: Re: [PATCH net-next V2 2/2] net/mlx5: implement max_sfs parameter
Date: Fri, 22 May 2026 11:19:42 -0700
Message-ID: <20260522181943.1495576-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519200436.353249-3-tariqt@nvidia.com>
References: <20260519200436.353249-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21162-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 595615B8FC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: implement max_sfs parameter

This patch adds a generic devlink permanent parameter named max_sfs to
the mlx5 driver so users can cap the number of light-weight NIC
subfunctions via devlink instead of vendor tooling. The setter rewrites
non-volatile firmware fields in nv_global_pci_conf and nv_pf_pci_conf,
and a reboot is required for the change to take effect.

A few questions on the implementation below.

> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> index 4bba4d780a4a..f5e2dccafa5a 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -45,8 +45,13 @@ Parameters
>       - The range is between 1 and a device-specific max.
>       - Applies to each physical function (PF) independently, if the device
>         supports it. Otherwise, it applies symmetrically to all PFs.
> +   * - ``max_sfs``
> +     - permanent
> +     - The range is between 0 and a device-specific max.
> +     - Applies to each physical function (PF) independently.

[Medium, Medium]
The documentation states the range is "between 0 and a device-specific
max", and the entry says max_sfs "Applies to each physical function (PF)
independently" with no "if the device supports it" qualifier like
total_vfs has.

Looking at the implementation in mlx5_devlink_max_sfs_set(), there is no
read of any nv_global_pci_cap field to obtain a device-reported maximum,
and the registration uses NULL for the validate callback:

  DEVLINK_PARAM_GENERIC(MAX_SFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
                        mlx5_devlink_max_sfs_get,
                        mlx5_devlink_max_sfs_set, NULL),

Should there be a validate callback analogous to
mlx5_devlink_total_vfs_validate() that reads the cap and rejects values
above the device-reported maximum, so the documented "device-specific
max" is actually enforced?

Should the doc also include the "if the device supports it" qualifier
to match how the setter behaves on devices without the relevant
capability?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> index 19bb620b7436..eff3a67e4ca0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> @@ -68,7 +68,9 @@ struct mlx5_ifc_mnvda_reg_bits {
>  
>  struct mlx5_ifc_nv_global_pci_conf_bits {
>  	u8         sriov_valid[0x1];
> -	u8         reserved_at_1[0x10];
> +	u8         reserved_at_1[0xa];
> +	u8         per_pf_num_sf[0x1];
> +	u8         reserved_at_c[0x5];
>  	u8         per_pf_total_vf[0x1];
>  	u8         reserved_at_12[0xe];

[ ... ]

> @@ -93,9 +95,11 @@ struct mlx5_ifc_nv_global_pci_cap_bits {
>  };
>  
>  struct mlx5_ifc_nv_pf_pci_conf_bits {
> -	u8         reserved_at_0[0x9];
> +	u8         log_sf_bar_size[0x8];
> +	u8         pf_total_sf_en[0x1];
>  	u8         pf_total_vf_en[0x1];
> -	u8         reserved_at_a[0x16];
> +	u8         reserved_at_a[0x6];
> +	u8         total_sf[0x10];
>  
>  	u8         reserved_at_20[0x20];

[Medium]
The on-wire field total_sf is 16 bits wide, but the devlink parameter
is registered as DEVLINK_PARAM_TYPE_U32 (max_sfs uses
DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE, which is u32) and the setter writes
ctx->val.vu32 directly via MLX5_SET(nv_pf_pci_conf, data, total_sf,
ctx->val.vu32).

MLX5_SET masks the value with __mlx5_mask(typ, fld) before storing, so
any user-supplied value above 0xffff is silently truncated.  For
example, "devlink dev param set ... name max_sfs value 70000" would
persistently store 4464.

Without a validate callback, is there anything that prevents this
silent truncation, and should the setter or a validate hook reject
values that do not fit in 16 bits?

> @@ -755,6 +759,76 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
>  	return 0;
>  }
>  
> +static int mlx5_devlink_max_sfs_get(struct devlink *devlink, u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> +	void *data;
> +	int err;
> +
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
> +		return err;
> +	}
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_sf);
> +
> +	return 0;
> +}

[Medium]
Should max_sfs_get() mirror mlx5_devlink_total_vfs_get() and consult
nv_global_pci_conf.per_pf_num_sf before reporting nv_pf_pci_conf.total_sf?

The setter explicitly conditions the meaning of per-PF total_sf on
per_pf_num_sf:

  MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
  ...
  MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);

But the getter reads total_sf unconditionally, so on a device whose
firmware was previously configured by another tool with per_pf_num_sf=0
and a stale per-host total_sf, "devlink dev param show" would return a
non-zero value that does not represent the active SF policy.  Is that
intentional?

> +static int mlx5_devlink_max_sfs_set(struct devlink *devlink, u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> +	void *data;
> +	int err;
> +
> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Failed to read global PCI configuration");
> +		return err;
> +	}
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
> +
> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Failed to change per_pf_num_sf global PCI configuration");
> +		return err;
> +	}

[Medium]
Should this path first read nv_global_pci_cap and reject the operation
when the device does not advertise SF NV configuration, the way
mlx5_devlink_total_vfs_set() does for SR-IOV?

mlx5_devlink_total_vfs_set() rejects with -EOPNOTSUPP and an extack
"SRIOV is not per PF on this device" when sriov_support or
per_pf_total_vf_supported is clear, but no equivalent
per_pf_num_sf_supported (or any SF-related) capability bit is added to
nv_global_pci_cap_bits or queried here.  On hardware that lacks the
feature, the user only sees the generic firmware error "Failed to
change ... global PCI configuration".

[Medium]
At this point, a successful write of per_pf_num_sf has already been
committed to non-volatile firmware storage.  If the subsequent
mlx5_nv_param_read_per_host_pf_conf() or the second mlx5_nv_param_write()
fails (for example, transient firmware/PCIe issue), is there a path that
rolls back per_pf_num_sf?

Because these are permanent parameters that "require a reboot to take
effect", a half-applied state (e.g., per_pf_num_sf=1 but
pf_total_sf_en=0/total_sf=0) appears to persist across reboots until
the user issues another successful set.

> +
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
> +		return err;
> +	}
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	MLX5_SET(nv_pf_pci_conf, data, log_sf_bar_size, ctx->val.vu32 ? 12 : 0);

[Low]
What is the meaning of the literal 12 here, and why is it correct on
all supported devices?

Elsewhere in the driver, the SF BAR length is computed from a
hardware-reported capability rather than a fixed value:

  drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c:
      sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);

Should log_sf_bar_size be derived from MLX5_CAP_GEN(dev,
log_min_sf_size) (or another cap) rather than hardcoded?

The commit message says max_sfs is to "control the total light-weight
NIC subfunctions"; the BAR-size side-effect is not mentioned, and any
previously configured log_sf_bar_size is overwritten on every
max_sfs set.  Should that behavior be documented or split out from the
count knob?

> +	MLX5_SET(nv_pf_pci_conf, data, pf_total_sf_en, !!ctx->val.vu32);
> +	MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
> +
> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Failed to change PF PCI configuration");
> +		return err;
> +	}
> +	NL_SET_ERR_MSG(extack, "Modifying max_sfs requires a reboot");
> +
> +	return 0;
> +}
-- 
pw-bot: cr


Return-Path: <linux-rdma+bounces-20731-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PU4MxYgBmpDewIAu9opvQ
	(envelope-from <linux-rdma+bounces-20731-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:18:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE654639F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF798300EA81
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B939EB58;
	Thu, 14 May 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJj6jo2y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E73F4106;
	Thu, 14 May 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786320; cv=none; b=tjjyvCywmB9JuvuVaApBhBjAgYmAp0GrS7RsDgjb4IEx2lgXdLIO5e4c/S07M0qltkGg2YqfI8LhC0aCEdbbgbzYYKL5EM3uBFNYwiZK+Gfb+4sLbZs5/zKzgIZTMbhvdNqHs7ylC7d+vklfXlrPKmtAfA5CycM+AH6CUe6Zyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786320; c=relaxed/simple;
	bh=tRB0REHBcluwpLGJMm9tJkxYc5BC4DxRi6U0sNHW+P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyatFkycbfawQzcs914RDQpDKFpylnpfAfTulcTToACdFfyZoNY7iN5q5K6zKQZvQxjvVADLEokcMbTfhsGdPSlaao79gZXRoUQ1J66FFSgC3/YRRfjXFxto7JazbUsBmnRL7VoGKqcnI0QdiNYl6NM9d86uZtr1KcFmQHNrMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJj6jo2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A6BC2BCB3;
	Thu, 14 May 2026 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786320;
	bh=tRB0REHBcluwpLGJMm9tJkxYc5BC4DxRi6U0sNHW+P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJj6jo2yA7fFausmgMMJQdWzn0EHN4PsNHoHTlWumhNG8TqszwsAw9SlBZt3zuPaC
	 cvAStp2bW4WBoxi0opDEsO9fdbVXRDEpZIb/mngYPmrTDZ1iIcRizifk+9BWLoPA30
	 0flHjo/3Y3Csii4Icb64rFUX2MzujtijKi2PmvFIJ0oBv4tRHRH2S9V/JICPzPjyQM
	 uEkqvXWaNR/GnFMXHreW+6lbsjjAdQtfKhM4vTB1h3MjqQsrMO8+t1FVflq10TIqt0
	 N29V2EGI6cQ54HncLsG7Uk2cF1yfDXSVpFNg6q/cBY6YXPFSrq9nbHHZESrMmGp1Du
	 HcufHoZAJAj/Q==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: 'Simon Horman' <horms@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
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
Subject: Re: [PATCH net-next 2/8] net/mlx5: Use v1 response layout for query_esw_functions
Date: Thu, 14 May 2026 20:18:02 +0100
Message-ID: <20260514191801.12494-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510053448.326823-3-tariqt@nvidia.com>
References: <20260510053448.326823-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33AE654639F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-20731-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/mlx5: Use v1 response layout for query_esw_functions

This patch teaches mlx5_esw_query_functions() to use the v1 response
layout (MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1) when the firmware
advertises query_host_net_function_v1, allocates the output buffer
based on query_host_net_function_num_max, and adds a parser for the
new network_function_params layout in mlx5_esw_get_host_pf_info().

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 861e79ddb489..8b62dde7eb70 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c

[ ... ]

> @@ -1100,12 +1133,55 @@ mlx5_esw_host_pf_from_host_params(const void *entry)
>  	};
>  }
>  
> -struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
> +static struct mlx5_esw_pf_info
> +mlx5_esw_host_pf_from_net_func_params(const u8 *entry, int num_entries)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +		int pf_type, state;
> +
> +		pf_type = MLX5_GET(network_function_params, entry, pci_pf_type);
> +		if (pf_type != MLX5_PCI_PF_TYPE_EXTERNAL_HOST_PF) {
> +			entry += MLX5_UN_SZ_BYTES(net_function_params);
> +			continue;
> +		}
> +
> +		state = MLX5_GET(network_function_params, entry, vhca_state);
> +
> +		return (struct mlx5_esw_pf_info) {
> +			.pf_disabled = state != MLX5_VHCA_STATE_IN_USE,

[Medium]
The commit message says "this change does not introduce new
functionality," but the legacy parser reads an explicit firmware
host_pf_disabled bit while the v1 parser derives pf_disabled from a
multi-valued vhca_state enum:

  .pf_disabled = state != MLX5_VHCA_STATE_IN_USE,

Is this mapping intended to be exactly equivalent to the legacy
host_pf_disabled bit across all five vhca_state values
(INVALID/ALLOCATED/ACTIVE/IN_USE/TEARDOWN_REQUEST)?

The same vhca_state value is interpreted differently elsewhere in
mlx5 for SFs. mlx5_sf_to_devlink_opstate() in
drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c reports:

    case MLX5_VHCA_STATE_IN_USE:
    case MLX5_VHCA_STATE_TEARDOWN_REQUEST:
            return DEVLINK_PORT_FN_OPSTATE_ATTACHED;
    case MLX5_VHCA_STATE_INVALID:
    case MLX5_VHCA_STATE_ALLOCATED:
    case MLX5_VHCA_STATE_ACTIVE:
    default:
            return DEVLINK_PORT_FN_OPSTATE_DETACHED;

so SFs in TEARDOWN_REQUEST are reported as ATTACHED, while a host
PF in TEARDOWN_REQUEST would now end up as pf_disabled = true and
therefore DETACHED via mlx5_devlink_pf_port_fn_state_get():

> +			.num_of_vfs = MLX5_GET(network_function_params,
> +					       entry, pci_num_vfs),
> +			.total_vfs = MLX5_GET(network_function_params,
> +					      entry, pci_total_vfs),
> +			.host_number = MLX5_GET(network_function_params,
> +						entry, host_number),
> +		};
> +	}

[Medium]
pf_disabled also feeds esw_vfs_changed_event_handler(), which skips
VF reload when it is true:

> @@ -3716,7 +3716,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
[ ... ]
> -	host_pf_info = mlx5_esw_get_host_pf_info(out);
> +	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, out);
>  	new_num_vfs = host_pf_info.num_of_vfs;
>  
>  	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)

Could the commit message spell out the firmware/PRM mapping between
the legacy host_pf_disabled bit and the vhca_state enum so it is
clear that ACTIVE, ALLOCATED and TEARDOWN_REQUEST really should be
treated as disabled here?

Would it also be worth aligning with mlx5_sf_to_devlink_opstate()
(at least for TEARDOWN_REQUEST) so the devlink opstate reported via
mlx5_devlink_pf_port_fn_state_get() stays consistent between SFs and
host PFs on v1-capable firmware?


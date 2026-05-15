Return-Path: <linux-rdma+bounces-20773-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAUWN+hRB2qnyQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20773-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:03:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3C5545F8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40A65307373D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1C324B2C;
	Fri, 15 May 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEN3xm5Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8030569C;
	Fri, 15 May 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863123; cv=none; b=oCuwjydq7aWezryJYTiA5Mau081j3BpVSj/pbK9v42GuIyeHU7AjrNI2c0k4bg4Oc/uuhMvUOnMR57qyvXjZwjy3Mbb97WM9Snlz2u/uFOGAb/0GA+vTr+6NfHjYAMLm0o9NnyISQysck7SfPAxTko7nWCLd0G+IHHLbWHTBIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863123; c=relaxed/simple;
	bh=8E31/EpMt1b7qnI8O8UdcG39vE+gZt+Pc9d5oo8Qy2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpr81CRGZwFd6ig/5dK6cXFHcHLd9TfiKYVJkL7WnPVWAcN3BCw1qN5AygmNvb3VivO04pdajIqgM1fnvze3VI2ZIjGome1ICn2rXM91UPpIX7zNZvYw9BdVRXeXuutaVtfcSRxo/S3SI12eq1hfe8F3z76Qvywl4UUDI0vKwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEN3xm5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38F5C2BCB0;
	Fri, 15 May 2026 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863122;
	bh=8E31/EpMt1b7qnI8O8UdcG39vE+gZt+Pc9d5oo8Qy2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEN3xm5YOyn/URaQBfTcXlWwVnKlznn+HmuCr++uWJ2TGD3R9OTE4yXh7+gr0ThVw
	 H8sf/vpjJmuoC0DJg5Zgd0rT3jpIdvf2VYfwriUKPc7Rj/ZjkXOxrnyupMr2+YkAn0
	 TpjwyflL5k5Y61HlQSeZvRBQ2jItkIphNthokr4zgqCmRuw91pwIm0QUws9e1iOU8U
	 +c1HpkHF9zvccn+LSVbv1ysHt3yChlBUf1iPsm/yLA8AAOxLbOCAb7ghzwtmvodLW/
	 hWwLS+/lIDgN6xI6Qwqjgulw7vQgqToiwYOvHc4V2jfpVjKoOT7xP/6z697D2x+Ubs
	 bCTUsN/iVBqHA==
Date: Fri, 15 May 2026 17:38:37 +0100
From: Simon Horman <horms@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
	agoldberger@nvidia.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	gal@nvidia.com, dtatulea@nvidia.com
Subject: Re: [PATCH net-next 2/8] net/mlx5: Use v1 response layout for
 query_esw_functions
Message-ID: <20260515163837.GC227382@horms.kernel.org>
References: <20260510053448.326823-3-tariqt@nvidia.com>
 <20260514191801.12494-2-horms@kernel.org>
 <d287f657-1f73-4178-8f9b-190ef7e855e5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d287f657-1f73-4178-8f9b-190ef7e855e5@nvidia.com>
X-Rspamd-Queue-Id: 7AD3C5545F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20773-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:59:09PM +0300, Moshe Shemesh wrote:
> 
> 
> On 5/14/2026 10:18 PM, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > net/mlx5: Use v1 response layout for query_esw_functions
> > 
> > This patch teaches mlx5_esw_query_functions() to use the v1 response
> > layout (MLX5_QUERY_ESW_FUNC_OP_MOD_LAYOUT_V1) when the firmware
> > advertises query_host_net_function_v1, allocates the output buffer
> > based on query_host_net_function_num_max, and adds a parser for the
> > new network_function_params layout in mlx5_esw_get_host_pf_info().
> > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> > > index 861e79ddb489..8b62dde7eb70 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> > 
> > [ ... ]
> > 
> > > @@ -1100,12 +1133,55 @@ mlx5_esw_host_pf_from_host_params(const void *entry)
> > >        };
> > >   }
> > > 
> > > -struct mlx5_esw_pf_info mlx5_esw_get_host_pf_info(const u32 *out)
> > > +static struct mlx5_esw_pf_info
> > > +mlx5_esw_host_pf_from_net_func_params(const u8 *entry, int num_entries)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = 0; i < num_entries; i++) {
> > > +             int pf_type, state;
> > > +
> > > +             pf_type = MLX5_GET(network_function_params, entry, pci_pf_type);
> > > +             if (pf_type != MLX5_PCI_PF_TYPE_EXTERNAL_HOST_PF) {
> > > +                     entry += MLX5_UN_SZ_BYTES(net_function_params);
> > > +                     continue;
> > > +             }
> > > +
> > > +             state = MLX5_GET(network_function_params, entry, vhca_state);
> > > +
> > > +             return (struct mlx5_esw_pf_info) {
> > > +                     .pf_disabled = state != MLX5_VHCA_STATE_IN_USE,
> > 
> > [Medium]
> > The commit message says "this change does not introduce new
> > functionality," but the legacy parser reads an explicit firmware
> > host_pf_disabled bit while the v1 parser derives pf_disabled from a
> > multi-valued vhca_state enum:
> > 
> >    .pf_disabled = state != MLX5_VHCA_STATE_IN_USE,
> > 
> > Is this mapping intended to be exactly equivalent to the legacy
> > host_pf_disabled bit across all five vhca_state values
> > (INVALID/ALLOCATED/ACTIVE/IN_USE/TEARDOWN_REQUEST)?
> > 
> > The same vhca_state value is interpreted differently elsewhere in
> > mlx5 for SFs. mlx5_sf_to_devlink_opstate() in
> > drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c reports:
> > 
> >      case MLX5_VHCA_STATE_IN_USE:
> >      case MLX5_VHCA_STATE_TEARDOWN_REQUEST:
> >              return DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> >      case MLX5_VHCA_STATE_INVALID:
> >      case MLX5_VHCA_STATE_ALLOCATED:
> >      case MLX5_VHCA_STATE_ACTIVE:
> >      default:
> >              return DEVLINK_PORT_FN_OPSTATE_DETACHED;
> > 
> > so SFs in TEARDOWN_REQUEST are reported as ATTACHED, while a host
> > PF in TEARDOWN_REQUEST would now end up as pf_disabled = true and
> > therefore DETACHED via mlx5_devlink_pf_port_fn_state_get():
> 
> PFs do not use the state TEARDOWN_REQUEST.
> Once the ECPF sets the PF disbale_hca, it is down and can't be used till
> ECPF does PF enable_hca.
> So state != MLX5_VHCA_STATE_IN_USE is the equivalent to the legacy
> host_pf_disabled.

This was the main thing I was concerned about.
Thanks for clarifying.

> 
> > 
> > > +                     .num_of_vfs = MLX5_GET(network_function_params,
> > > +                                            entry, pci_num_vfs),
> > > +                     .total_vfs = MLX5_GET(network_function_params,
> > > +                                           entry, pci_total_vfs),
> > > +                     .host_number = MLX5_GET(network_function_params,
> > > +                                             entry, host_number),
> > > +             };
> > > +     }
> > 
> > [Medium]
> > pf_disabled also feeds esw_vfs_changed_event_handler(), which skips
> > VF reload when it is true:
> > 
> > > @@ -3716,7 +3716,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
> > [ ... ]
> > > -     host_pf_info = mlx5_esw_get_host_pf_info(out);
> > > +     host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, out);
> > >        new_num_vfs = host_pf_info.num_of_vfs;
> > > 
> > >        if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_info.pf_disabled)
> > 
> > Could the commit message spell out the firmware/PRM mapping between
> > the legacy host_pf_disabled bit and the vhca_state enum so it is
> > clear that ACTIVE, ALLOCATED and TEARDOWN_REQUEST really should be
> > treated as disabled here?
> 
> Yes, I can add explanation on that in commit message.
> 
> > 
> > Would it also be worth aligning with mlx5_sf_to_devlink_opstate()
> > (at least for TEARDOWN_REQUEST) so the devlink opstate reported via
> > mlx5_devlink_pf_port_fn_state_get() stays consistent between SFs and
> > host PFs on v1-capable firmware?
> 
> Same answer as first comment above.
> 
> 


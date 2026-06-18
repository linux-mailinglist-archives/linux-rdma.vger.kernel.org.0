Return-Path: <linux-rdma+bounces-22348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AjUDHJ/pM2ruIAYAu9opvQ
	(envelope-from <linux-rdma+bounces-22348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 14:50:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 080156A02F0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 14:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RCC+3A6r;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22348-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22348-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71738300C331
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC03F1ABF;
	Thu, 18 Jun 2026 12:50:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E138D017;
	Thu, 18 Jun 2026 12:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787033; cv=none; b=tOpoEFxVBDu5cLugQG/N8BuhOXQuXusXi2E53Do0RAHia+4mgUqx1GbO00JD4tWkLy/i5OzK0UUHScl9RDTpmbhe/zwTp2WenQsTgWGK7rXohFxtt7NzMmd9+APVxxk/VRD4ny38po9Hl+Kr15jJ3vAd26G2Fuuzz5eN+Xf8uQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787033; c=relaxed/simple;
	bh=8dJuuv53AAw2VUnQHP9LZ7dCZ3rmBIHMXZ9XxTdI+NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUdWGa0gwKy+j4Jp0XCNSLLvSSKC1ysYYuRJ8cimnr1qtVIZ26wkh6l6rBqzzzyX9WwPvQTePqph/48Qrg4XM6KvnV7l1AK0ToCv3S0OY9nTJ2vCqvPFxX+OB9vvxyYckc+c1DoNCKPcryNSuT4M4BmdhkrqnMlQN3nxstR9MPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCC+3A6r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1935A1F000E9;
	Thu, 18 Jun 2026 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787032;
	bh=2UshQf/2RdMObW9304nb/6W02fhtd1jb33bK9uRmD2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCC+3A6rBuwfjOfJHeVNvOLU9V5gB5bENgep3o3+Fkhz7bzLYvOB+RuooD1JrEMAn
	 b34ef6m+zX5vgfHED15xm1eaw7BD4H3PxpmWGe79J6Lx7WHozcmm27LPEvI3+qwgI6
	 1AUvrFLJoiTqSR4L+luuHIe3DKY3TFMR8D7FLLAZOdgZWS2GQBUL1lzfpNx4syefwL
	 qtPPkgQo0pPZClPP/aUg3UUjnGGgKzZd1gHC90RoHGL6qOk3LYXVQczyxUdrzeab1p
	 5gCP/vj7tDuYlmFj78hkWZZeF2P0ZClY36nIEWmElMK1bkqpGhFmK6CMBQtHgylOhf
	 AXjEy5TtO03DQ==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	shayd@nvidia.com,
	ohartoov@nvidia.com,
	edwards@nvidia.com,
	msanalla@nvidia.com,
	phaddad@nvidia.com,
	parav@nvidia.com,
	gbayer@linux.ibm.com,
	kees@kernel.org,
	moshe@nvidia.com,
	rongweil@nvidia.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com
Subject: Re: [PATCH net 3/3] net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable
Date: Thu, 18 Jun 2026 13:48:22 +0100
Message-ID: <20260618124820.890808-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617063204.547427-4-tariqt@nvidia.com>
References: <20260617063204.547427-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22348-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 080156A02F0

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: I think the first two issues flagged below warrant
            consideration within the context of this patch.

	    But the third and final issue flagged below as pre-existing
	    seems to be something to consider in the context of
	    possible follow-up.
---
net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable

This commit addresses a bad memory access crash by skipping peer flows when
mlx5_lag_get_dev_seq() returns an error. This occurs when the peer isn't in
the LAG or when no device is marked as master.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index a9001d1c902ff..c6e6534a5e23b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -2155,6 +2155,9 @@ static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
>  	devcom = flow->priv->mdev->priv.eswitch->devcom;
>  	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
>  		i = mlx5_lag_get_dev_seq(peer_esw->dev);
> +		if (i < 0)
> +			continue;
> +

[Severity: Critical]
Does skipping the remainder of this loop prevent the flow from being
unlinked from the doubly-linked list?

By using continue here in mlx5e_tc_del_fdb_peers_flow(), we skip calling
mlx5e_tc_del_fdb_peer_flow(), which means flow->peer[i] is never
unlinked from the esw->offloads.peer_flows[original_i] list.

If the flow is subsequently freed via mlx5e_flow_put(), will this leave a
freed list node resident in the active list and guarantee a use-after-free
list corruption during the next list traversal?

>  		mlx5e_tc_del_fdb_peer_flow(flow, i);
>  	}
>  }

[ ... ]

> @@ -5526,6 +5529,9 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
>  
>  	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
>  		i = mlx5_lag_get_dev_seq(peer_esw->dev);
> +		if (i < 0)
> +			continue;
> +

[Severity: Critical]
Similarly to the above, does this skip unlinking during flow cleanup when
the LAG sequence is unavailable?

>  		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
>  			mlx5e_tc_del_fdb_peers_flow(flow);
>  	}


[Severity: Critical]
This isn't a bug introduced by this patch, but is there a similar missing
bounds check during flow addition in mlx5e_tc_add_fdb_peer_flow() in this
same file?

If a flow is added concurrently with LAG teardown, mlx5_lag_get_dev_seq()
can return -ENOENT (-2):

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:mlx5e_tc_add_fdb_peer_flow() {
    ...
    int i = mlx5_lag_get_dev_seq(peer_esw->dev);
    ...
    list_add_tail(&flow->peer[i], &esw->offloads.peer_flows[i]);
    ...
}

Does this result in an out-of-bounds write to a negative array index?


Return-Path: <linux-rdma+bounces-20900-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGJ2B+/4CmoA+wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20900-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:33:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4256B9DE
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98333034A0D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44D3EDAC9;
	Mon, 18 May 2026 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/2sR4Qf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C381724;
	Mon, 18 May 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103672; cv=none; b=Kr/L1Gcm4E0Tkr+cN4+KJ94YFsW5mC4kACSGC+LDGgUhd8YuaxwP0vyIpcG3BW1wZxPEW0ocTvxh/6LltTNlJvlifuQYD8IEDKLbXqzRFS5LU1t0ZhsnzvRL6ARjG3fFShbrPjVa4r5bs9//gItaC2CUBsdhrHonvzb2C3QF+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103672; c=relaxed/simple;
	bh=ufPScedVUcg1u/wcH2VUyidMRTtIoULnpTLShivpSMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEXhx/WDqbjULYdHY2oAP/2sDZ9Q2EgYtINwzaU40RTo79NiVyLGlQo/NjZmd9kqqjbv77NPkGXz76Y5DAmwPfhFVtCw1CC+sZGuU89EUASjivdk8ybV866oFRObL0+IQ4AyDFHpYqgi2OPceGKptImnSwBMy5oZZT4Ky7+w4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/2sR4Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274A5C2BCB7;
	Mon, 18 May 2026 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103671;
	bh=ufPScedVUcg1u/wcH2VUyidMRTtIoULnpTLShivpSMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/2sR4QfE/QStLSQbdTEMMWu74VEG9w4vBtC8xmb1yIZoCcQZuK3yBXylkSwcolGF
	 8HAPwRjGEXG0pScQKgax6xiulPIWd85mdYKrvRczYH2S5JZTKGw/E9Chd/7kkfUfj/
	 LHIj4Y/da9Y33azXt4cUBguJu1soPMJZ5Z2oHMYwC7L/jxA1lWXP30HD5NoeCSMuVf
	 HgEFoiWLHDdM0p1UXF18bucSkzceakf8TlJGeIq/2uqqpbsHn6MEaW+hSkLuArFptD
	 KpqGrKSzvIwp2EQN80/axu2D0FLbtPL2xfjjf4ETVXXzdJwQRmw59FgGfIJM3AlKMX
	 Aud5Q/r2ztutg==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: 'Simon Horman' <horms@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	borisp@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jianbol@nvidia.com,
	cjubran@nvidia.com,
	acassen@corp.free.fr,
	kees@kernel.org,
	Jason@zx2c4.com,
	michal.swiatkowski@linux.intel.com,
	fmancera@suse.de,
	antonio@openvpn.net,
	cratiu@nvidia.com,
	ecree.xilinx@gmail.com,
	sridhar.samudrala@intel.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com,
	leonro@nvidia.com
Subject: Re: [PATCH net] net/mlx5e: Skip IPsec flow modify when MAC address is unchanged
Date: Mon, 18 May 2026 12:27:11 +0100
Message-ID: <20260518112710.510979-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513190226.335562-1-tariqt@nvidia.com>
References: <20260513190226.335562-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88B4256B9DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,nvidia.com,corp.free.fr,zx2c4.com,linux.intel.com,suse.de,openvpn.net,gmail.com,intel.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20900-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/mlx5e: Skip IPsec flow modify when MAC address is unchanged

When a netdev event fires for an IPsec SA, skip calling
mlx5e_accel_ipsec_fs_modify() if the MAC address has not changed and
the rule is not in drop mode. This avoids redundant hardware updates.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index a52e12c3c95a2..f567cd801adb3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -674,19 +674,26 @@ static void mlx5e_ipsec_handle_netdev_event(struct work_struct *_work)
>  	struct mlx5e_ipsec_sa_entry *sa_entry = work->sa_entry;
>  	struct mlx5e_ipsec_netevent_data *data = work->data;
>  	struct mlx5_accel_esp_xfrm_attrs *attrs;
[ ... ]
> +
> +	if (ether_addr_equal(mac, data->addr) && !attrs->drop)
> +		return;
> +
> +	ether_addr_copy(mac, data->addr);
>  	attrs->drop = false;
>  	mlx5e_accel_ipsec_fs_modify(sa_entry);

If mlx5e_accel_ipsec_fs_modify() fails (for example, due to a memory
allocation failure), does this early return prevent the hardware state
from recovering?

Since attrs->drop and the mac address are updated before calling
mlx5e_accel_ipsec_fs_modify(), a failure in the hardware update leaves the
software state out of sync with the hardware.

Prior to this patch, a subsequent netdev event for the same neighbor would
unconditionally retry the hardware update. With this patch, the early return
sees the optimistically updated software state, matches it, and skips the
retry, potentially leaving the hardware permanently stuck in a dropped or
failed state.

Also, can sa_entry->work and sa_entry->dwork execute concurrently?

Both sa_entry->work (which executes mlx5e_ipsec_handle_netdev_event()) and
sa_entry->dwork (which executes mlx5e_ipsec_handle_sw_limits()) are queued
to ipsec->wq. Since this is an unbound workqueue with max_active=0, works
can execute concurrently.

Neither handler appears to hold a lock when calling
mlx5e_accel_ipsec_fs_modify(sa_entry). If both handlers run concurrently,
could this happen:

Thread 1:
mlx5e_accel_ipsec_fs_modify(sa_entry)
  memcpy(&sa_entry_shadow, sa_entry, sizeof(*sa_entry));
  mlx5e_accel_ipsec_fs_add_rule(&sa_entry_shadow);

Thread 2:
mlx5e_accel_ipsec_fs_modify(sa_entry)
  memcpy(&sa_entry_shadow, sa_entry, sizeof(*sa_entry));
  mlx5e_accel_ipsec_fs_add_rule(&sa_entry_shadow);

Both threads would then call mlx5e_accel_ipsec_fs_del_rule(sa_entry),
potentially causing a double-free of the exact same ipsec_rule->rule and
ipsec_rule->fc. The subsequent memcpy(sa_entry, &sa_entry_shadow, ...)
would then cause one thread to overwrite the other's newly created rule
pointers, leaking the flow rules.

>  }


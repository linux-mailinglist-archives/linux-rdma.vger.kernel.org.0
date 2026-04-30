Return-Path: <linux-rdma+bounces-19764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K8OqKYSz8mmDtgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C349C10E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73A8830242A6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAC17D6;
	Thu, 30 Apr 2026 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Kl1HhJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8C27B35B;
	Thu, 30 Apr 2026 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513334; cv=none; b=TuiM0OjJAaPqfKS3T8AMhY9/55q8n13r/knkJtZYXj7LpJVdgFlMj5ZkEZib3WdlgHjXOHZDOTYKVR1bspHBAYBHQvG0a8U7MyqbFkKoreep7mdVZW0r8s3HLqZ1TSG+fL2F2pqrVDBcw7WS/pP3tATu1p8QTJ8tb8P7ttxxPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513334; c=relaxed/simple;
	bh=Im+1RwrIaWNXY5pBH5Qko2LxbgsRPU2X/tHmOfUgmYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAW8evnReuQv6m59VMiZXOzFNvMwA49x55RWXHMLbukjv0Btswz8d9ZH0eX109U94G7Z2AX3xfdodO9IrGXq85oe7mtjjkJzu344HU4DWsSEttELJyL+ehs2K9Ul6PZ3SMPwEGW/zC1xLcRJfGdG1eJxh6Zx2JiIfm1VpSdAlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Kl1HhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ACFC2BCC6;
	Thu, 30 Apr 2026 01:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777513333;
	bh=Im+1RwrIaWNXY5pBH5Qko2LxbgsRPU2X/tHmOfUgmYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/Kl1HhJ11ZyiK//DGGP7rtlwsLgVAOfxb5UR+AtFQR/ydHNP40yybNjL0OYiNwE+
	 TkEAsAAYW9wXLnziJPQMwxDvhIeAMeXH1lRzz7eq3FNjiizs5RFuxMCB2dm/O9XTLb
	 KAvrPWtsHs1ZHmeMxqEXecovesn37WGcqXbfXyMjCA6+tIMEN9ZmWe4d0hPBJTsZe1
	 INjRgOWviY1101MGhz+oDAJJGX2RypoFA4wSuBoMoM1oCYVzlDk5prRqPBvPBg9hok
	 PLdfG2clh57Eg0P0hWJDFasv1e9p/7OsblcvLkcD8JRjTQtTGJn2OhEixNNz2CMv8o
	 SWIRbwY+YczPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	shayd@nvidia.com,
	horms@kernel.org,
	phaddad@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	gal@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com
Subject: Re: [PATCH net V4 4/4] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Wed, 29 Apr 2026 18:42:11 -0700
Message-ID: <20260430014211.2375751-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428060111.221086-5-tariqt@nvidia.com>
References: <20260428060111.221086-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C9C349C10E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19764-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5e: SD, Fix race condition in secondary device probe/remove

This commit updates secondary devices to acquire the device lock of the
primary auxiliary device during probe, suspend, resume, and remove
operations. It introduces mlx5_sd_get_adev() and mlx5_sd_put_adev() to
manage this lock ordering and add a second devcom readiness check.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 7a1787f15320..a43ae482a679 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c

[ ... ]

> @@ -563,5 +567,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>  	if (dev == primary)
>  		return adev;
>  
> +	device_lock(&primary->priv.adev[idx]->adev.dev);

If mlx5_devcom_comp_is_ready() returned true just before this, but the
secondary thread is preempted before reaching device_lock(), could a
concurrent removal of the primary device cause primary->priv.adev[idx]
to become NULL or freed?

It looks like the removal path (such as mlx5_unregister_device) frees the
mlx5_adev memory and explicitly sets primary->priv.adev[idx] to NULL. If
the secondary thread then resumes, it might dereference a NULL or freed
pointer when attempting to acquire the lock.

Since the second readiness check happens after the device_lock() call, does
this leave a window where memory corruption or a panic can still occur?

Additionally, since the driver core already holds device_lock(&adev->dev)
for the secondary device during callbacks like probe() and remove(), will
acquiring the primary device's lock here trigger a lockdep warning for
possible recursive locking?

Both the primary and secondary auxiliary devices use the same generic lock
class assigned in device_initialize(). While the fixed secondary to primary
ordering avoids an actual deadlock, lockdep might not distinguish between
the two mutexes without explicit lockdep subclassing.

> +	/* In case primary finish removing its adev */
> +	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
> +		device_unlock(&primary->priv.adev[idx]->adev.dev);
> +		return NULL;
> +	}
>  	return &primary->priv.adev[idx]->adev;
>  }


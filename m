Return-Path: <linux-rdma+bounces-15873-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP6zF+SdcWl6KQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15873-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:47:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F1961738
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5179B50152C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55240B6E6;
	Thu, 22 Jan 2026 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRiD9eKc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840F40F8E2;
	Thu, 22 Jan 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053206; cv=none; b=BGBfgXq+NuOGarN6/gzcfRDVSXrgWIAwE0ox6f6LlerSjykn2kK46gEI0pOSG5jnpqCNDm0uLAYs/JMem0GPDtPaqDI1BZoEAa5melbqUopQly70ngDZRGhBKmSsTCgIGab2KDHp+H/dpSO6A5BXfJ+ixjy6dK+p1iQRFaNtxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053206; c=relaxed/simple;
	bh=Hv2uOjidNO7FItxrn1mbMLnYqtrmqCi7BnoOH99M+8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyM1pAGSi0pgqqfEZ2jOGqEau0K8XbEW171U8/tudm1zdpco12IqCZQ43md2ow75RIUPfce161JS/pPlqmZvtI/nJhCWEtRN9POv3k4u0ZxSF7MS0QKfAvjInVl2GUAGxqrblg1JP1ZAMeBd22rjDe+QWBh/b2y0qpwAm5yE1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRiD9eKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8999C19425;
	Thu, 22 Jan 2026 03:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053205;
	bh=Hv2uOjidNO7FItxrn1mbMLnYqtrmqCi7BnoOH99M+8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRiD9eKcgAZnjW9LD6AsjpYQzB84ojCjz6qaihSsI0GauBmqbmtM1yqN1p0tnf7O5
	 lar1kUOiKBKxBI07wKxrJhOUlgtzLwN6CX/C4pt1GRrHkjTFHMNbT37PeH3FlaYcWw
	 ovdDZXb58jbAPvDVwzeLz7ex+OyTZwwyKfm1o3lIbk2LwaXgCb6gKC68Apt/tlxYi3
	 PYf6jv1QdGACAaE5PlwGqQTYV3xVny0v/6CIQYdzwxDvbSgyYK302rRUPc/A2C6iOa
	 fhLosNqSwUsGl556DfkbO5gcToJ4kQji3/eGSE6TYFbNAZSRN0ByTsuyRTxaYKJrnL
	 zy7ZORJz79BQw==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	cratiu@nvidia.com,
	saeedm@nvidia.com,
	cjubran@nvidia.com,
	davem@davemloft.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	jiri@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	krzk@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	rdunlap@infradead.org,
	leon@kernel.org,
	corbet@lwn.net
Subject: Re: [net-next,V5,12/15] net/mlx5: Store QoS sched nodes in the sh_devlink
Date: Wed, 21 Jan 2026 19:40:03 -0800
Message-ID: <20260122034003.2579276-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <1768895878-1637182-13-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-13-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-15873-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,vger.kernel.org,google.com,lunn.ch,gmail.com,resnulli.us,redhat.com,infradead.org,lwn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 04F1961738
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/mlx5: Store QoS sched nodes in the sh_devlink

This commit moves the QoS scheduling nodes from per-eswitch storage to
the shared devlink instance. It replaces per-eswitch locking with the
shared devlink lock and removes explicit locking from devlink rate
callbacks with the expectation that devlink holds the shd lock.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index 8c3a026b8db4..0d187399d846 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

[ ... ]

> static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
> {
>-	lockdep_assert_held(&esw->qos.domain->lock);
>+	devl_assert_locked(esw->dev->shd);
> }

[ ... ]

> int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
> 					    u64 tx_share, struct netlink_ext_ack *extack)
> {
> 	struct mlx5_vport *vport = priv;
>-	struct mlx5_eswitch *esw;
> 	int err;
>
>-	esw = vport->dev->priv.eswitch;
>-	if (!mlx5_esw_allowed(esw))
>+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
> 		return -EPERM;
>
> 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
> 	if (err)
> 		return err;
>
>-	esw_qos_lock(esw);
> 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At this commit, the esw_qos_lock/unlock calls are removed with the
expectation that "all calls originating from devlink rate already have
the shd lock held" (per the commit message). However, the devlink rate
infrastructure only locks dev->shd when supported_cross_device_rate_nodes
is set in the devlink_ops, which does not happen until commit ef6db4a7f381
("net/mlx5: qos: Enable cross-device scheduling").

The call chain is:
  devlink_nl_rate_set_doit() -> devl_rate_lock() ->
  mlx5_esw_devlink_rate_leaf_tx_share_set() ->
  mlx5_esw_qos_set_vport_min_rate() -> esw_assert_qos_lock_held() ->
  devl_assert_locked(esw->dev->shd)

Since devl_rate_lock() only locks the nested-in devlink when
supported_cross_device_rate_nodes is true, and that flag is not set at
this commit, the assertion will fail with lockdep enabled, and QoS data
structures will be accessed without proper locking.

This creates a bisect window between this commit and ef6db4a7f381 where
the QoS locking is broken. Could the setting of supported_cross_device_rate_nodes
be moved into this patch to avoid the bisect issue?

>-	if (err)
>-		goto out;
>-	esw_vport_qos_prune_empty(vport);
>-out:
>-	esw_qos_unlock(esw);
>+	if (!err)
>+		esw_vport_qos_prune_empty(vport);
> 	return err;
> }

[ ... ]


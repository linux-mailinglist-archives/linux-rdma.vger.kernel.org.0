Return-Path: <linux-rdma+bounces-15870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fu9GDeccWmdKAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:40:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C620F61678
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7B14F60B2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BB03E8C71;
	Thu, 22 Jan 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjf7BFoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497C3D7D8D;
	Thu, 22 Jan 2026 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053199; cv=none; b=fT8+VcAKQ8pCLlgnBUUai36VuYxS94kzORUKnoC2qO0ra7VH9eZgiJ093/tQExxJ19EVHqVzZjityocylf4j88t0SiBk6fx0IAzbvgY4vvNELN0/L+nUsRD1B2/SGwdHJvBbcODaOPxzTxzQmr2g7IImH9pkSw7DNmrRyD7OfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053199; c=relaxed/simple;
	bh=N6sHJn1Tq8GbCXp9tT8/vfk/I88g3mmk+8HL0NEv2OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppsLdvMfnnDdGWSpisWd+LHObaG4DZLzVF8WZrn9Xr+ZC1qLGDQpX1Db4mujOvA0RRG9/LHOYUmy4+QtztBqRt7gilsM1tD5jOiqxUlWxmn42KSPqc9KZtchcuKcmSOjv2Vw+IBHrlNNkP7MybFX48QNrHGYvZCU/IqUfxm7KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jjf7BFoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD49DC116C6;
	Thu, 22 Jan 2026 03:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053198;
	bh=N6sHJn1Tq8GbCXp9tT8/vfk/I88g3mmk+8HL0NEv2OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jjf7BFoSKeRNt1Wt52b/yxNyTbyl9pX+6T+OE6Am5Wsh510EPfw63k3/9ZP/QtKwx
	 1olGqG5kU5XSyt26weZ5QKBkJZepBKy/UcxswedwEAlZig8T+bLBHRbjrmJE7ymY0O
	 +7U6T2SP70OV29VubqeZ17pz4ZBS30wdWaBjsAeMFRW1JKwUkHVhI4w7fVI8E1jIuW
	 +6ynkg6i5eZEY7VsLQIKVNXAOlH71t2paatdl3VJKzF306Hc/yOAYLvl/eLoy38pQo
	 uVVYV5GXzD6ld2ZHoJyDwhbSc7V20cbncq0KJoZ5/WPlX0iKbZg14MB+cB7Yut4gha
	 NKeEKzbm41LgQ==
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
Subject: Re: [net-next,V5,06/15] devlink: Decouple rate storage from associated devlink object
Date: Wed, 21 Jan 2026 19:39:57 -0800
Message-ID: <20260122033957.2579085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <1768895878-1637182-7-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-7-git-send-email-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-15870-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C620F61678
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
devlink: Decouple rate storage from associated devlink object

This patch introduces the concept of a "rate node devlink" to allow rates
from multiple devlink instances to be stored together. It updates all
rate node manipulation code to filter by devlink during iteration and
adds lock/unlock helpers (currently no-ops) for future locking support.

> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
> index 0d68b5c477dc..ddbd0beec4b9 100644
> --- a/net/devlink/rate.c
> +++ b/net/devlink/rate.c

[ ... ]

> @@ -209,10 +235,12 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
>  {
>  	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
>  	struct devlink_rate *devlink_rate;
> +	struct devlink *rate_devlink;
>  	int idx = 0;
>  	int err = 0;
>
> -	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
> +	rate_devlink = devl_rate_lock(devlink);
> +	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
>  		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
>  		u32 id = NETLINK_CB(cb->skb).portid;
>
> @@ -220,6 +248,9 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
>  			idx++;
>  			continue;
>  		}
> +		if (devlink_rate->devlink != devlink)
> +			continue;

When this filter skips a non-matching entry, idx is not incremented.
However, state->idx is used to track position across netlink dump
resumptions and expects idx to reflect the actual position in the list.

Once cross-device rate nodes are enabled (later in this series), the list
can contain entries from multiple devlinks. If the dump requires multiple
netlink messages and non-matching entries exist between matching ones,
the idx tracking becomes inconsistent with the list position. This can
cause entries to be reported multiple times on dump resumption.

Should this continue statement also increment idx to maintain correct
position tracking?

> +
>  		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
>  					   cb->nlh->nlmsg_seq, flags, NULL);
>  		if (err) {
> @@ -228,6 +259,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
>  		}
>  		idx++;
>  	}
> +	devl_rate_unlock(devlink);

[ ... ]
-- 
pw-bot: cr


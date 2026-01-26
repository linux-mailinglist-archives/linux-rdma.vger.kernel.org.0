Return-Path: <linux-rdma+bounces-16024-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPCKAhGpd2nrjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16024-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 18:49:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BA8BAA8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 18:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCDCA30347AB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7834D4F1;
	Mon, 26 Jan 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl5BnoZ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93734D4D2;
	Mon, 26 Jan 2026 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449699; cv=none; b=R2O7YX8Q8k+aKDSsHxCbkGcuKNSECpkkAG0cTMGL8oUxPa+Qg1HPCucfb0134o7/oRqnqCvlwabL++DsLfHfYzr5zAGmxHkslUun9tr+IJgDIqSl11xGUousTAOIQYF9A5UH/T174rFc4MdtCcbA7sjPwwLRjGm6sZdeziFge7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449699; c=relaxed/simple;
	bh=RsYSuliAGyXfu7amtjytPEnCvLsy+vVf24yR5uPC0pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcJcd5ehyCMs/aFoIzVb3vamXBETSwV4CEIzL+uEyTTqFH77n245dVBNdpxPYYssvpKCK/ZojI5S45fI8J0z5mMTVe1oDDVajXPT+Arc7P1cEq+eZcQ89wHfg0m6XotEQvMBKy4SFf5wDJw0JV9sNstfRzosOElFMyYK0TbmcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl5BnoZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF10C19425;
	Mon, 26 Jan 2026 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449699;
	bh=RsYSuliAGyXfu7amtjytPEnCvLsy+vVf24yR5uPC0pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dl5BnoZ7qaHOYO4trP9UdK5tV4uq7Y1inMJKubhuJiTUS262YQ4v6mxlWuCeLyq4d
	 PAlzmBHIdZuLO/EGWJ6lHjsKa7BINJcs8pbHMp/gAD4947UQ+OMQB/2Ct9hMvhmGQS
	 7wDAxACL+XkjP/sM1jD3fHpHXJailvIsU9i0Tg3Pw5AvX7yjZK0Zqlw08An2wlJSiL
	 Op7O/ke6q0tW/VbViZUveHmlS6hbOWjOP0eWcoph/4JO2BUtZ5Z6Jty6zRqQ6mWwrL
	 CmZxSr9Ch8yeBGGJ2bzLgO2CMRVO4SvjzjUmE/6/wSq26j+wVbg28m69INzsDaIJfq
	 d4Dn5wtw8VmUw==
From: Simon Horman <horms@kernel.org>
To: achender@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	allison.henderson@oracle.com,
	rds-devel@oss.oracle.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [net-next,v1,7/7] net/rds: Trigger rds_send_ping() more than once
Date: Mon, 26 Jan 2026 17:47:54 +0000
Message-ID: <20260126174754.1393215-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125070651.207042-8-achender@kernel.org>
References: <20260125070651.207042-8-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16024-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 674BA8BAA8
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: Trigger rds_send_ping() more than once

This commit ensures that rds_send_ping() is triggered after reconnect
to properly communicate path capabilities, especially after an RDS
module reload. It also validates source port modulo during fan-out.

> diff --git a/net/rds/send.c b/net/rds/send.c
> index ea3b57e9191b..8e7ece085ff1 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1328,6 +1328,23 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
>  		cpath = &conn->c_path[0];
>  	}
>
> +	/* c_npaths == 0 if we have not talked to this peer
> +	 * before.  Initiate a connection request to the
> +	 * peer right away.
> +	 */
> +	if (conn->c_trans->t_mp_capable &&
> +	    !rds_conn_path_up(&conn->c_path[0])) {

This isn't a bug, but the comment says "c_npaths == 0" while the code
checks "!rds_conn_path_up()". These conditions are different:
c_npaths == 0 means no paths negotiated yet, while !rds_conn_path_up()
is true for any state other than RDS_CONN_UP (DOWN, CONNECTING,
DISCONNECTING, ERROR, RESETTING).

The commit message mentions "after a re-connect to any peer" which
aligns with the code, but the comment specifically mentions c_npaths
which isn't checked. Should the comment be updated to reflect the
actual logic?

> +		/* Ensures that only one request is queued.  And
> +		 * rds_send_ping() ensures that only one ping is
> +		 * outstanding.
> +		 */

[ ... ]


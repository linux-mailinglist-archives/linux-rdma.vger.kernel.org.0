Return-Path: <linux-rdma+bounces-16176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLf6E8fqemk0/wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:06:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DFABCD6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1913302C933
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 05:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0D2D7DF5;
	Thu, 29 Jan 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDc9X+UK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4509273D8D;
	Thu, 29 Jan 2026 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663151; cv=none; b=CVDIf3ZYfOsdFqm8ZAjDgyQAryv4kRm4GAGvGWOUAAYw41UduIwjR3XFJTKbiLxuOZqHvYexv6YhQR2RIZVZLKFRVySS7oko4jFIP2Jql4nHtjfYV+dD2mMVABNv+hKNLMJNQLrU6TZUjXQVa8hllkPIhN/a9rHDooplEXgffW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663151; c=relaxed/simple;
	bh=HLNr9dI5JHOUxIcCFSOHuToW73gA4v+Td0q71Xlb1BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzUVvg1KVi+TUnhVVpvGkNGbZrblYFRMzF6nSDX9i1JkPr5RpnzINL1zlYltmjy7eTNXLXhzcc1MXwkt+Nh74AUMSGF1qNvLm5cmpCkccvL4PJ6xKB63iDnnZ7fpReeAFcORmwdE/VnvzbfN7SKFkS2PnP0xdqvhBKT1TF05mWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDc9X+UK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7908C116D0;
	Thu, 29 Jan 2026 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663150;
	bh=HLNr9dI5JHOUxIcCFSOHuToW73gA4v+Td0q71Xlb1BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDc9X+UKY33unD8TPu0rWQZXL8u4x2Pou8wK9Bng73K4/+W7XECEVoG9ldAl8Z9R5
	 Om0ohPpwM9HkYpT7eq7ntTfUCGdp8yhwvf0EKeSILinG12YWP6Vfx1SLJiPEfMj7kR
	 YMFF1TZfinKYgIYEY9alYFTnrbwoeECDZQwbh2VIwQrZAdtYoWVze2O2dp8mJ/iQiS
	 m0DyWXyqu7KEyYGVWws5ftgN2UxIJSahCEayDLvVRlnKPA1UYZnrh78bhDYPywVIzr
	 JwXlmkmAS4859EKDGcK8RRsdAAmPopIHKfYjRdcCAqAXJ5e2KiBgtFAwLFrV1q5DA1
	 qDIhfW7IQPzGA==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	allison.henderson@oracle.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	rds-devel@oss.oracle.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next,v2,7/7] net/rds: Trigger rds_send_ping() more than once
Date: Wed, 28 Jan 2026 21:05:48 -0800
Message-ID: <20260129050548.374535-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128011351.78511-8-achender@kernel.org>
References: <20260128011351.78511-8-achender@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16176-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E20DFABCD6
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: Trigger rds_send_ping() more than once

This commit ensures rds_send_ping() is triggered after reconnect to
properly communicate multipath capabilities, especially after an RDS
module reload. It also validates source port modulo during fan-out.

> diff --git a/net/rds/send.c b/net/rds/send.c
> index 599c2cfb7a1d..68f6b12c60ef 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1339,6 +1339,24 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
>  		cpath = &conn->c_path[0];
>  	}
>
> +	/* Check to see if we have talked to this peer before.
> +	 * If not, this means conn->c_npaths will be zero,
> +	 * and we should initiate a connection request to the
> +	 * peer right away.
> +	 */
> +	if (conn->c_trans->t_mp_capable &&
> +	    !rds_conn_path_up(&conn->c_path[0])) {

This isn't a bug, but the comment says "c_npaths will be zero" while
the code checks "!rds_conn_path_up()". These conditions are different:
c_npaths == 0 means no paths negotiated yet, while !rds_conn_path_up()
is true for any state other than RDS_CONN_UP (DOWN, CONNECTING,
DISCONNECTING, ERROR, RESETTING).

The commit message mentions "after a re-connect to any peer" which
aligns with the code, but the comment specifically mentions c_npaths.
Should the comment be updated to reflect the actual logic?

This was flagged in v1 review:
https://lore.kernel.org/netdev/20260126174754.1393215-1-horms@kernel.org/

[ ... ]


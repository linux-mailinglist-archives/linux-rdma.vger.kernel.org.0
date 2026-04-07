Return-Path: <linux-rdma+bounces-19070-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OlwKr9b1GlrtQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19070-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:19:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 506673A8A77
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2B49303FFC2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FCC2066DE;
	Tue,  7 Apr 2026 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE9YfnuL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC92556E;
	Tue,  7 Apr 2026 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524749; cv=none; b=MpvPBZ1fstmT7cy8qYSW7H4eAivz76KUdD9G9hhNE2OiQFXp7ZQnwyQstH1tx6ejdXj3yxjNJ3tPROXrkF1V9M+tNOBafe0sNWYzZYU6/7WEpQ5BUtRh5XqAnz7P9q4uTawAsqejCKmPAK60ncRVafWbyiYlX703OwOHrNMwPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524749; c=relaxed/simple;
	bh=PMcluwqJEHD0V02LwA7IUApMbRkg8OV8ItS4+SP44KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvD/68InnIvaCu7YKb80U/ldbuDBneCoGcBRer8IZCGuNaAVJ2usXRIm84L6qVcM9xd1PpKm+EtjjAOQ7tfL7DYYzyjjpquxHhdHBNJlXkDTodyCMAPfnd9XGmroxTPO/7aF4N+8s5OJ0VsXdkd6qw+ymoi7+3Abu2Gy/73+61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE9YfnuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6860AC4CEF7;
	Tue,  7 Apr 2026 01:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524748;
	bh=PMcluwqJEHD0V02LwA7IUApMbRkg8OV8ItS4+SP44KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NE9YfnuLIGlqYPcv7coGCJGUVlBWKPU9pM49qCftWncHvSSuiO9SCetu2kMPSnN9N
	 c93x4EZB5cks9d1sc1mHynek71CUrfTlhI5gS4YK45zz7RXA4+N0iDlLXC3ErMt+j2
	 zuSrl/Sn6RDCXGXs1ViqtSdJ5W9UzA3GV2AwPuE5+LPsF4k3qS9O6rjoLdVxBPMZN/
	 2NNAn1JhTr68koifAsGZeEVXvKX/JNPzvNGiia5hSAq6TrpWoIJ0k/O3MkhgFBijUm
	 cpzvXSof+tapUJRjn32HKcjo4ovPoMVF0Yq3prO4YwthQjYWpmn09Sm3qvjg7RpfQF
	 MlZ9k16UFwLhw==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	rds-devel@oss.oracle.com,
	edumazet@google.com,
	linux-rdma@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1 2/2] net/rds: Restrict use of RDS/IB to the initial network namespace
Date: Mon,  6 Apr 2026 18:19:07 -0700
Message-ID: <20260407011907.3596425-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405041613.309958-3-achender@kernel.org>
References: <20260405041613.309958-3-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19070-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 506673A8A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: Restrict use of RDS/IB to the initial network namespace

Prevent using RDS/IB in network namespaces other than the initial one.
The existing RDS/IB code will not work properly in non-initial network
namespaces, and there are currently no plans to support such use.

Closes: https://syzkaller.appspot.com/bug?extid=da8e060735ae02c8f3d1

> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c

[ ... ]

> @@ -373,6 +374,10 @@ static int rds_set_transport(struct net *net, struct rds_sock *rs,
>  	if (t_type < 0 || t_type >= RDS_TRANS_COUNT)
>  		return -EINVAL;
>
> +	/* Only RDS/TCP supports non-initial network namespaces */
> +	if (t_type != RDS_TRANS_TCP && !net_eq(net, &init_net))
> +		return -EPROTOTYPE;
> +

[ ... ]

> diff --git a/net/rds/ib.c b/net/rds/ib.c
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -490,8 +490,13 @@
>  static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
>  			      __u32 scope_id)
>  {
> -	struct rds_ib_device *rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
> +	struct rds_ib_device *rds_ibdev;
>
> +	/* RDS/IB is only supported in the initial network namespace */
> +	if (!net_eq(net, &init_net))
> +		return -EPROTOTYPE;
> +
                                   ^^^^
Is the wording "is only supported" in this comment precise? Looking at the
existing codebase, rds_ib_cm_handle_connect() already has a comment that
says "RDS/IB is not currently netns aware, thus init_net" with the phrase
"for now" in rds_ib_laddr_check_cm() suggesting this could change. Before
this patch, it was technically possible to attempt using RDS/IB in
non-init namespaces (though it led to the UAF bug). The comment might be
clearer if it said "RDS/IB does not work correctly in non-initial network
namespaces" or "RDS/IB is restricted to the initial network namespace" to
better distinguish between the technical limitation and the enforcement.

> +	rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
>  	if (rds_ibdev) {
>  		rds_ib_dev_put(rds_ibdev);
>

The commit message states "there are currently no plans to support such
use." While the existing code clearly does not support non-init namespaces
(with hardcoded &init_net references throughout), this statement about
future plans cannot be verified from code. The existing comments in
rds_ib_cm_handle_connect() and rds_ib_laddr_check_cm() use phrases like
"for now" and "not currently" which could suggest plans might exist or
could be placeholders. Is this policy statement necessary in the commit
message, or would it be sufficient to state the technical facts about the
current limitation?


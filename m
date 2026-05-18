Return-Path: <linux-rdma+bounces-20896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP52FfLwCmpv+AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:58:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9056B1AB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B495730C764E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F13EDACC;
	Mon, 18 May 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHVsvs+4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8703EF0C7;
	Mon, 18 May 2026 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100413; cv=none; b=N45VeZaobVbdWvJ+kf4cd+tqb22LIUsQu4nNgX/yRrr0LOr6tIleYjwdmPS3J9ofvz2XapEcp3/Doh0xZ0ntk6Gyw3jn+COtwSwOAFM+dWIwlY+L5t3IFUSxH44VfTGX9IT8VPxXXMbKTUTfqVGcqIzv02TyCdVq+mAY1Kg0Bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100413; c=relaxed/simple;
	bh=21mzB7Ds3SRyWGPHuXA4KK9wPMWdQb3wY8wzkyxvlgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDrcLXYTBR4gHnUMLavt/18cATQfKQ9HLXjId5bRi2zG8ZuIEU6SQWHWfq4zSuP0+O8T/fbC1LA6lGuegrG39v2Q2AAAeGJ6j7lMBwX8rqQVUT00HXlcJW7AFUELb3WMIRbvh33OX/mGa28l1KAKtlWyFrBy8t8kp9962lS0E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHVsvs+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726CC2BCB7;
	Mon, 18 May 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100412;
	bh=21mzB7Ds3SRyWGPHuXA4KK9wPMWdQb3wY8wzkyxvlgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHVsvs+4/zlZMlWUecu4ikRTrh3B+NNk7+gl1dTrVSK8PWTtF34hv4ZjJJnxNBBXN
	 hxY0NXdHE6FASgKj9Qrv4+R2Hx3MH1mrSUYtvKfU0xXrjFx22Pv7zYJbe6M9Kn63gQ
	 c/5+vygo0Uji6w7kXChcual63HZkk6kT0j/ULM80grdTjVrjBJkNnAYwZ1+AmTv015
	 sTm2mcJe25gPUXiRQm75z4iCyM/KwVB0+dZtgxSgSnOs3yTcRKhTNI+t8bLERCxiV8
	 gFKR86JQGr6/qPl3lNXb3vqVTWMZ3R11JtOvKRFTHUO1hLfLoMSXx7u8gZ0nApc9pM
	 eDuGEzVlWy4Cg==
From: Simon Horman <horms@kernel.org>
To: maoyixie.tju@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	praveen.kakkolangara@aumovio.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	maoyi.xie@ntu.edu.sg
Subject: Re: [PATCH net v4] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Mon, 18 May 2026 11:15:32 +0100
Message-ID: <20260518101531.473574-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513143904.2497520-1-maoyi.xie@ntu.edu.sg>
References: <20260513143904.2497520-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BFC9056B1AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20896-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rds: filter RDS_INFO_* getsockopt by caller's netns

This commit adds network namespace filtering to the RDS_INFO_* getsockopt
handlers to restrict visibility of sockets and connections. It removes global
counters and replaces them with a per-netns count gathered from a first pass
over the lists.

> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 76f625986a7f2..ace52d3ce0597 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c

[ ... ]

> @@ -806,6 +811,7 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
>  			  struct rds_info_iterator *iter,
>  			  struct rds_info_lengths *lens)
>  {
> +	struct net *net = sock_net(sock->sk);
>  	struct rds_info_socket sinfo;
>  	unsigned int cnt = 0;
>  	struct rds_sock *rs;
> @@ -814,12 +820,22 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
>  
>  	spin_lock_bh(&rds_sock_lock);
>  
> -	if (len < rds_sock_count) {
> -		cnt = rds_sock_count;
> -		goto out;
> +	/* First pass: count entries visible in the caller's netns. */
> +	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
> +		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
> +			continue;
> +		cnt++;
>  	}
>  
> +	if (len < cnt)
> +		goto out;
> +
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		/* This option only supports IPv4 sockets. */
>  		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
>  			continue;
> @@ -832,7 +848,6 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
>  		sinfo.inum = sock_i_ino(rds_rs_to_sk(rs));
>  
>  		rds_info_copy(iter, &sinfo, sizeof(sinfo));

Could a concurrent bind cause this second pass to copy more items than we
counted in the first pass?

If rds_bind() updates rs_bound_addr concurrently without holding
rds_sock_lock, an unbound socket could be skipped during the first pass but
match in the second pass.

Because the second pass does not limit the number of copied items to the
length checked after the first pass, rds_info_copy() could be called more
times than the user-supplied buffer can handle.

For example, if a caller provides a length of 0, the iter pages array may
be NULL. If the first pass computes cnt = 0, the length check (len < cnt)
evaluates to false and the second pass executes. If a socket is bound
concurrently and matches the second pass, could this lead to an out-of-bounds
read or a crash when rds_info_copy() dereferences iter->pages?


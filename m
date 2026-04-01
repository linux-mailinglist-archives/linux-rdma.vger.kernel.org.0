Return-Path: <linux-rdma+bounces-18871-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOgfMq+DzGlXTgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18871-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 04:32:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01A373E74
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 04:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFF2308B73F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4231B100;
	Wed,  1 Apr 2026 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD2OXrSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B530DD2A;
	Wed,  1 Apr 2026 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010395; cv=none; b=ZY7OsmZojnypyrgzYcQweg2k/6HPAhp9kiwfsanhF5VQgz2XrWTLID/DW37pf8mk4xAxm5ajhR/vmQw9sBKhmQobVmTQkR6sUY2uQWYEAh9qlD0Ieo+XUyozC4isa0LWXRyDVz5Tesr4rtdn29qBTRTxNyZUGPhVYj4rls81/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010395; c=relaxed/simple;
	bh=B7Loae6T1zbp4r3ZPEJAX/gcCGH4THtPBw6XHDD+Y4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdX6XUTEV3F0+DBAaunwfe8+sDOWDpntE7evnJwBP5hwrdBD0xddnA9OuZHWgXPgKFBeFFZ8rDzD2di9BWG6LrYAmanqAwCG3CrWvBPniRPVLQqELjKPaPOaE/9NXkQ41bi7IFiRCKA7EcKGLWQCUIyQwPj2T4JLxB7iPFag4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD2OXrSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45FEC19423;
	Wed,  1 Apr 2026 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010395;
	bh=B7Loae6T1zbp4r3ZPEJAX/gcCGH4THtPBw6XHDD+Y4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pD2OXrSeE3p09n7Lcs2f7m6zTN1PEke0+xYNflazARQpbQHo6Vbuys3wFjw3DbMGu
	 ZRY047Ojm9m8RfYwQdxMD3TrtpChpQ5g0JijD5To53s55zzp+feRW+bJ0V/YtmCR7e
	 UafDZjdH0q0EGWK8oQUrwmMCjtvBl0lWwZFB+EsYrcB0nBWh/jZKvE8o/FwcscUCeN
	 3TbTc4EAiMMsBMha9fMHWzi7LMjktqzaEeGzMAyM1kZhU8lyKy41MdWy6fKzI46Blw
	 7e1ZlqQvMfOpSI4HrQyYv+mIa4jR036t+1cDusZr/EEwo0Qys7/GQ3Hn8ZmBvvkxxA
	 dS2nlbs9aInGw==
Date: Tue, 31 Mar 2026 19:26:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Allison Henderson <allison.henderson@oracle.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Xiang Mei
 <xmei5@asu.edu>
Subject: Re: [PATCH net] rds: ib: reject FRMR registration before IB
 connection is established
Message-ID: <20260331192633.26144848@kernel.org>
In-Reply-To: <20260330163237.2752440-2-bestswngs@gmail.com>
References: <20260330163237.2752440-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18871-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E01A373E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 00:32:38 +0800 Weiming Shi wrote:
> rds_ib_get_mr() extracts the rds_ib_connection from conn->c_transport_data
> and passes it to rds_ib_reg_frmr() for FRWR memory registration. On a
> fresh outgoing connection, ic is allocated in rds_ib_conn_alloc() with
> i_cm_id = NULL because the connection worker has not yet called
> rds_ib_conn_path_connect() to create the rdma_cm_id. When sendmsg() with
> RDS_CMSG_RDMA_MAP is called on such a connection, the sendmsg path parses
> the control message before any connection establishment, allowing
> rds_ib_post_reg_frmr() to dereference ic->i_cm_id->qp and crash the
> kernel.

Allison?


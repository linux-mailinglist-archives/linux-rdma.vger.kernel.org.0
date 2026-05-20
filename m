Return-Path: <linux-rdma+bounces-21005-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kp1I6MUDWqotAUAu9opvQ
	(envelope-from <linux-rdma+bounces-21005-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 03:55:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4E586A69
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 03:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A71302A50F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1D2F1FC7;
	Wed, 20 May 2026 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBgiSrPd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7213B58A;
	Wed, 20 May 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242140; cv=none; b=f3HmcS5HSHbz63GoAfCU7jUGVC8YBlHd80Juj5zB+ksAJQezieYVe6OrSEFq7kCT/fCWJao2JJW+Izj4myFrkDzY7g1ksSrQxuJAKK//gBV2lV/UYWqhS1vIWzjj0uiFpZHPXItT5Bq9mV6kdNYmsIytWYROMMYpViTUVIU2Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242140; c=relaxed/simple;
	bh=CkmrZgpKxfQunIM/6TIJXwCf/UzRNYUgtGTw6zBiRJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnAu7kXQdd7uGX576wJzwiJ01h7VsDYKO/la2mK2lt2IW2rSOLYFajI23p/ezJmtsv+AT2fH7/u431tkbSbZO5+jP6DfwRl3w0kyuO0nzjmqfcWwhSltUxVmjpEnKLfTRipTxVbn9JPhA0SxJruVV0CHPuxxeTxW0Fzc2ug2s3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBgiSrPd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A61F000E9;
	Wed, 20 May 2026 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242139;
	bh=Ib4SgarWJEX4iIZYZRN1n/Zcasoz6VE7lJsKARzwePA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BBgiSrPdA8nHm/icV2+QiuLGf3xstqQ2NjGxpERaKQXTKEMS4eBHCvJdq2sV350gi
	 UdPffEE89xHyzod7uJ/Xpfbqx3i/38TxF5l+9DMBT1HY74J3zQvBIhc3bG/3S0d929
	 icPwZPUoRl//gN0hqLeY80EDIce7T1RweR3p0cpP598MYQv8fTrAGCrwHOKClyBJ9Z
	 aE+bQM1B82HjRAFeWvvLSvlX2+nGaHRr5KeYLOPgFz1+arMXe8ePO1V9EdNubBZTie
	 taWqJUJpXJmT1doIfr66YiY+UOe1cbI9ScsVrALDd9dpylYdoNnOPXBot1TZH1Edt7
	 j74fPf0Xk1EBg==
Date: Tue, 19 May 2026 18:55:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Allison Henderson <achender@kernel.org>, Praveen
 Kakkolangara <praveen.kakkolangara@aumovio.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH net v5] rds: filter RDS_INFO_* getsockopt by caller's
 netns
Message-ID: <20260519185537.772bf34c@kernel.org>
In-Reply-To: <20260518174613.1592290-1-maoyixie.tju@gmail.com>
References: <20260518174613.1592290-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21005-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,aumovio.com,gmail.com,vger.kernel.org,oss.oracle.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8B4E586A69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 01:46:13 +0800 Maoyi Xie wrote:
> The RDS_INFO_* family of getsockopt(2) options reads several
> file-scope global lists that are not per-netns:
> 
>   rds_sock_info / rds6_sock_info,
>   rds_sock_inc_info / rds6_sock_inc_info        -> rds_sock_list
>   rds_tcp_tc_info / rds6_tcp_tc_info            -> rds_tcp_tc_list
>   rds_conn_info / rds6_conn_info,
>   rds_conn_message_info_cmn (for the *_SEND_MESSAGES and
>   *_RETRANS_MESSAGES variants),
>   rds_for_each_conn_info (for RDS_INFO_IB_CONNECTIONS)
>                                                 -> rds_conn_hash[]  

Does not apply to net:

Applying: rds: filter RDS_INFO_* getsockopt by caller's netns
error: patch failed: net/rds/tcp.c:201
error: net/rds/tcp.c: patch does not apply
Patch failed at 0001 rds: filter RDS_INFO_* getsockopt by caller's netns
-- 
pw-bot: cr


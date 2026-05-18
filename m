Return-Path: <linux-rdma+bounces-20901-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEFQK5/6CmpF+wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20901-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:40:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCD56BBA4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41CD3000B2F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CC3EEAD1;
	Mon, 18 May 2026 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9K7dbQo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2C33F8C6
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104358; cv=none; b=dqdsS2o3mxd6tIOgkrHxrMdRAHNWe8Gq8boxUEbxHnaKRubtJApp3LOljpBY1c74WC+Q/k5o3F1TOr3oEWOuZ+xLyiK2N1NRu9LrutH4HdKdxFzwk44iWHF2tO4ny+9OQhw5H1jmXAgMgjdMDwSNOHd/S0LJZ6VYdIfT405ipgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104358; c=relaxed/simple;
	bh=YWb92k9MrhZuhoHYj7+mMLYh1Lb7N+Vr1/yv3NT1lZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbNhLXy6Qm7ilrtk1AaFQvErt8aqw3In/Qewi//Io+IP3c+L2tDvmnBKF6IoRmqr965XcnZd7YhPNAgetx5up/BEXKhgIgacw6qcbzpj8HHwKLnqww4L2MGbvr+HPpI8y1ZA+ekdKP4BvOY9cypAclBGLSsCVowxSIY0ncmm9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9K7dbQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A366C2BCB7;
	Mon, 18 May 2026 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104357;
	bh=YWb92k9MrhZuhoHYj7+mMLYh1Lb7N+Vr1/yv3NT1lZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9K7dbQoMzornsPeplWuPU+QGX8wGqAUKU4YjueLqELmZ9Hgxjtwm9xp+8Pop2Tpk
	 azJOSzvy6FSwaSm4hpkcduM8NdT7QeFsWbAhhWZImYquRTOj/Lbmn0PQ9RQ+ZBf5yF
	 WUoc2zdNNDrHVBnnI0IQycAV4+2J6Wsi86o8Zt8X/MLQBhQZd8F6qfFjPRy/oZl2os
	 0g8MKMUHnnkyavHI55y3scANraqXn1rGC0bcbDBF+9D8KhoitCc6Ftadlf0pKZUth3
	 DYuosgQsmW4c3vBPk8c+c/4dCJTrYgROf2ppGYKEID9SjCpe0FoWiYgQjDC7GbqfyS
	 F6ZroeS+D4H7g==
Date: Mon, 18 May 2026 14:39:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix Use-After-Free problem in rxe_net_del
Message-ID: <20260518113913.GO33515@unreal>
References: <20260517044747.475621-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517044747.475621-1-yanjun.zhu@linux.dev>
X-Rspamd-Queue-Id: 4FDCD56BBA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20901-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 06:47:47AM +0200, Zhu Yanjun wrote:
> syzbot reported a general protection fault (KASAN: null-ptr-deref) in
> kernel_sock_shutdown() called during the software RoCE (rxe) link
> deletion path (rxe_dellink -> rxe_net_del).
> 
> The root cause is a TOCTOU (Time-of-Check to Time-of-Use) race condition
> in rxe_net_del(). Previously, the function fetched the socket pointer
> via rxe_ns_pernet_sk4/6() outside the critical section, and then
> acquired the lock to release it via rxe_sock_put().
> 
> In a highly concurrent teardown environment, another thread could close
> and clear the pernet socket after it was fetched but before the lock
> was acquired. This causes rxe_sock_put() to operate on a dangling or
> already cleared socket pointer, leading to a NULL pointer dereference
> when kernel_sock_shutdown() attempts to access sock->sk.
> 
> Fix this by introducing a dedicated, per-netns mutex 'release_lock'
> and extending its scope. The socket pointers are now fetched, checked,
> and released entirely within the same locked critical section. This
> ensures the atomicity of the socket lookup and teardown sequence.
> 
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c |  4 ++++
>  drivers/infiniband/sw/rxe/rxe_ns.c  | 22 ++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h  |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..b689ba085da4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -655,6 +655,8 @@ void rxe_net_del(struct ib_device *dev)
>  
>  	net = dev_net(ndev);
>  
> +	rxe_ns_lock(net);
> +
>  	sk = rxe_ns_pernet_sk4(net);
>  	if (sk)
>  		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> @@ -663,6 +665,8 @@ void rxe_net_del(struct ib_device *dev)
>  	if (sk)
>  		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>  
> +	rxe_ns_unlock(net);
> +
>  	dev_put(ndev);
>  }
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 8b9d734229b2..799a727bc1fe 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -16,6 +16,7 @@
>  struct rxe_ns_sock {
>  	struct sock __rcu *rxe_sk4;
>  	struct sock __rcu *rxe_sk6;
> +	struct mutex	release_lock;

This change renders the existing rcu_read_lock() and rcu_read_unlock()
calls unnecessary.

Thanks


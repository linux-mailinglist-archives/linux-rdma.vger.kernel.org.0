Return-Path: <linux-rdma+bounces-16901-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJI1JqQFkmnNpQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16901-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 18:43:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA613F42A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 18:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B24C3028369
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B32F616B;
	Sun, 15 Feb 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="eLI0f5OG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EA2F4A0C
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771177290; cv=none; b=fAomfbMzUhTJMx90FsLSHSiDEMjVQalPnrnXEbUPavuBCqx0Qa0SBHHQ3S5klC9GY1gouz8wJ+EG5zBzHdUf451trBCJfNRwBW7rtLARiMyqrcL5JFA6V0Gyk21apSKMTNK0Ddx67uFvrzjErBZrnWMT1lROJcUyR07KLPgVYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771177290; c=relaxed/simple;
	bh=+7NJvjwyJ38/qxtTTNOVd3m0prOBmV/S5UkpadTa3fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jymMM717RRlzaDUaY7Hjwh10RSknWw7RwWCOAJ/41M+rmnE8jyJynVBiDbn3MEgnvB3l7DsNb/bOKQBScmwEL6T6iEjCKx+4q1c5BViIfAHnVZEsQTRTeVHJ0tSbr0XoLWAg5tA9+PJbqulRFBAMiMn2aYjH7PhUIHwMEF19DgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=eLI0f5OG; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4224C240101
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 18:41:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771177281; bh=ItME07V8SNH8MmxDWZ8PONmIn64cMiqCEnVOlsVSa8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=eLI0f5OGT3fTbQhRZ7Cb4w2p5irLOJZWo39zGC7dFLxef/AxorMkOZxGtjNzkNIJU
	 ooSd+QR79MdOpYq01NA+NgVGioetOUhYI8y3aZnwZilWfk7bA5F76zaOVbg5D6gLYv
	 OD4wpddJWK0WsQ5X0vh0uOCiEPRlivrjuA+goenXTB7AgwlOXFGAnsh0ACANmor1Dm
	 VedOx1aSiwNm2FnpKzn9HBlJZybMvnBiRHcM1wYBtb5kHVPUDWpnmpyMcCCemd19gw
	 84EoJrP3bxtIi6mtaYby5b9q9OW8u6je7VhzS1Auap3eVKT4/zDrLwAI/Q4bIMJebd
	 V12uIz69FSKjg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fDY9W0dvGz6tsb;
	Sun, 15 Feb 2026 18:41:19 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Tabrez Ahmed <tabreztalks@gmail.com>
Cc: allison.henderson@oracle.com,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-rdma@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: Re: [PATCH net] rds: tcp: fix uninit-value in __inet_bind
In-Reply-To: <20260215070951.213341-1-tabreztalks@gmail.com>
References: <20260215070951.213341-1-tabreztalks@gmail.com>
Date: Sun, 15 Feb 2026 17:41:20 +0000
Message-ID: <877bsdx5tt.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16901-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,posteo.net:mid,posteo.net:dkim]
X-Rspamd-Queue-Id: 0DEA613F42A
X-Rspamd-Action: no action

Tabrez Ahmed <tabreztalks@gmail.com> writes:

> KMSAN reported an uninit-value access in __inet_bind() when binding an RDS TCP socket.
> The uninitialized memory originates from rds_tcp_conn_alloc(), which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.
>
> The structure is not zero-initialized, leaving random data in its fields.
> When the networking stack later tries to bind the socket using these dirty values, KMSAN flags the uninitialized access.

Most fields in rds_tcp_connection are explicitly initialized after
allocation right? The only field actually read before being written is
t_client_port_group. Could the description be more specific about which
field is problematic?

>
> Fix this by using kmem_cache_zalloc() instead of kmem_cache_alloc() to ensure the structure is zeroed out upon allocation.
>
> Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
> Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")

Not sure about this, the field trigger this bug, t_client_port_group,
did not exist in 70041088e3b9. It was introduced in

  a20a6992558f ("net/rds: Encode cp_index in TCP source port")

which added both the field and the code in rds_tcp_conn_path_connect()
that reads it uninitialized:

     if (++tc->t_client_port_group >= port_groups)

Should the Fixes that reference that instead? If I'm correct ofc.

Also, nit, commit message body should not exceed 75 characters.

>
> Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
> ---
> This is my first patch. Any feedback is appreciated!

Best of luck.

>
>  net/rds/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 45484a93d75f..04f310255692 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -373,7 +373,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
>  	int ret = 0;
>  
>  	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
> -		tc = kmem_cache_alloc(rds_tcp_conn_slab, gfp);
> +		tc = kmem_cache_zalloc(rds_tcp_conn_slab, gfp);
>  		if (!tc) {
>  			ret = -ENOMEM;
>  			goto fail;


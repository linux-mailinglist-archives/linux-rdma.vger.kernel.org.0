Return-Path: <linux-rdma+bounces-17750-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN1+CNR7rmnoFAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17750-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:50:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E78235091
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB1493039F78
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E136A01D;
	Mon,  9 Mar 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIY1YApT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569E36997D
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042552; cv=none; b=YrkK1vghDTBFI8aihEJYtgi7czVnOw64o6qkqRMQsN96bK42oWeddp7zY1zHvY01uWX7AKKBxqJedqmGXhEQtp3/6zWiTHdPR//rCUsDGgxKs8ncIm0ApfdnRPVCnkA3Xur3brW3pDR0vxNhUAa6Q2k1U9naQa15uNxV995wdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042552; c=relaxed/simple;
	bh=BK4w5zW2pmkFpleQWkhZHxMFzScEqMW5tGEXIvdyQDw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LOzLljAVeWbtw2mRKzxbX2/p3OAp7m+zx91kBohdJde7QZvWf82tFeCyZvDv+HPwIVQdtqbb9JxvtdlloHXNcMegPxBYqdiiNik4ffudI3TYFkq/FbS1otOMbpxPFn1pyJ/6CM6WC8/DV0Jy77pIRSEB+uvsJRwsxgb+gDpnxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIY1YApT; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773042538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCSi7v9xxHe6xaQA7QoLIUaLr3gtY2UScb9IicHrzKY=;
	b=DIY1YApTPAmh2yqbiET3733BiWelpy9U/WwuQtXrce/3cvcg2c8zS0buSnCk62q3MvR1n6
	fapihjKpNeRvKoLWA52fRkX/W15XUINzyrnRjGaXo05xcYnVDhFkFfFA+sghZz+puu/vjE
	S+e/k2RssYQ2w4g9/oinrEIGjEhp8KM=
Date: Mon, 09 Mar 2026 07:48:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <ade7f1a6d89525cb0545ac12603edb8e448f9493@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, "Eric Dumazet"
 <edumazet@google.com>, "D. Wythe" <alibuda@linux.alibaba.com>, "Dust Li"
 <dust.li@linux.alibaba.com>, "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Wenjia Zhang" <wenjia@linux.ibm.com>, "Mahanta Jambigi"
 <mjambigi@linux.ibm.com>, "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu"
 <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260309060611.GA130186@j66a10360.sqa.eu95>
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
 <20260309060611.GA130186@j66a10360.sqa.eu95>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C8E78235091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17750-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,alibaba.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

March 9, 2026 at 14:06, "D. Wythe" <alibuda@linux.alibaba.com mailto:alib=
uda@linux.alibaba.com?to=3D%22D.%20Wythe%22%20%3Calibuda%40linux.alibaba.=
com%3E > wrote:


[...]
> >  Reproducer was verified with mdelay injection and smc_run,
> >  the issue no longer occurs with this patch applied.
> >=20=20
>=20>  [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
> >=20=20
>=20>  Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> >  Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GA=
E@google.com/T/
> >  Suggested-by: Eric Dumazet <edumazet@google.com>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  v2:
> >  - Use rcu_read_lock() + refcount_inc_not_zero() instead of
> >  read_lock_bh(sk_callback_lock) + sock_hold(), since this
> >  is the TCP handshake hot path and read_lock_bh is too
> >  expensive under SYN flood.
> >  - Set SOCK_RCU_FREE on SMC listen socket to ensure
> >  RCU-deferred freeing.
> >=20=20
>=20>  v1: https://lore.kernel.org/netdev/20260307032158.372165-1-jiayuan=
.chen@linux.dev/
> >  ---
> >  net/smc/af_smc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20=20
>=20>  diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >  index d0119afcc6a1..72ac1d8c62d4 100644
> >  --- a/net/smc/af_smc.c
> >  +++ b/net/smc/af_smc.c
> >  @@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const=
 struct sock *sk,
> >  struct smc_sock *smc;
> >  struct sock *child;
> >=20=20
>=20>  + rcu_read_lock();
> >  smc =3D smc_clcsock_user_data(sk);
> >  + if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
> >  + rcu_read_unlock();
> >  + return NULL;
> >  + }
> >  + rcu_read_unlock();
> >=20=20
>=20>  if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_h=
s) >
> >  sk->sk_max_ack_backlog)
> >  @@ -153,11 +159,13 @@ static struct sock *smc_tcp_syn_recv_sock(cons=
t struct sock *sk,
> >  if (inet_csk(child)->icsk_af_ops =3D=3D inet_csk(sk)->icsk_af_ops)
> >  inet_csk(child)->icsk_af_ops =3D smc->ori_af_ops;
> >  }
> >  + sock_put(&smc->sk);
> >  return child;
> >=20=20
>=20>  drop:
> >  dst_release(dst);
> >  tcp_listendrop(sk);
> >  + sock_put(&smc->sk);
> >  return NULL;
> >  }
> >=20=20
>=20>  @@ -2691,6 +2699,7 @@ int smc_listen(struct socket *sock, int back=
log)
> >  write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
> >  goto out;
> >  }
> >  + sock_set_flag(sk, SOCK_RCU_FREE);
> >=20
>=20This RCU approach looks good to me. Since SOCK_RCU_FREE is now enable=
d,
> other callers of smc_clcsock_user_data() should also follow this
> RCU-based pattern. It will eventually allow us to completely remove the
> annoying sk_callback_lock.
>=20
>=20D. Wythe
>=20


Hi=20D. Wythe,

Thanks for the suggestion. I agree that converting all smc_clcsock_user_d=
ata()
callers to RCU is a reasonable direction, and it would allow us to eventu=
ally
remove the sk_callback_lock dependency for sk_user_data access.

However, I'd prefer to keep this patch focused on fixing the specific bug=
 in
smc_tcp_syn_recv_sock(), since it needs to be backported to stable trees.
Mixing a bug fix with broader refactoring makes backporting harder and in=
creases
the risk of regressions.

Also, converting the other callers is not entirely trivial. For example:

- smc_fback_state_change/data_ready/write_space/error_report():
  the sk_callback_lock there protects not only sk_user_data but also the
  consistency of the saved callback pointers (e.g.,smc->clcsk_state_chang=
e).
  Switching to RCU requires careful ordering analysis against the write s=
ide
  in smc_fback_restore_callbacks(). Additionally, fallback sockets would =
also
  need SOCK_RCU_FREE.

- smc_clcsock_data_ready():
  the sock_hold() would need to become refcount_inc_not_zero() to handle =
the
  case where the refcount has already reached zero.

I'd like to address these conversions in a follow-up patch series.

What do you think?

> >=20
>=20> sk->sk_max_ack_backlog =3D backlog;
> >  sk->sk_ack_backlog =3D 0;
> >  sk->sk_state =3D SMC_LISTEN;
> >  --=20
>=20>  2.43.0
> >
>


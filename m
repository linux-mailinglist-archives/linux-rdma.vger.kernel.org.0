Return-Path: <linux-rdma+bounces-17845-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI1zE+Sxr2nrbgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17845-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 06:53:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DA245915
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 06:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 851E03053283
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 05:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA53C6A58;
	Tue, 10 Mar 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WB6SmFvI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0A2BD02A;
	Tue, 10 Mar 2026 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121886; cv=none; b=IWhUf1QxRw5us6pPYH6vWM/oHwk+YuruMQ6HVr2Tv2zKwp2aEKfB2J+P8h5161siLQ/bq8iuqYjqwT1GE/DQj41JLXu3VbUNNjMokBSKkymxcb90T4BxrO46HZw8greLCItEID1EK2NxeDrsU2E0dGROgyPizbErmWlyq1qJDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121886; c=relaxed/simple;
	bh=X8GlQBtv2iRJp4SsZ7G2UVyw+BbphQ1aA83k4nF9d6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKqyne5bNixO4MzhO12lGTxvKzLdlMnkD5lzrwzPOcQFewJs0GUwu9xA2V2F2uW8OHB5y84X9HaFcSQ5vkWqJ3rOx7Ik3/+65YVTcH1sYVZkBvfivsb1yeR5XSAL/SpOOmmPOzbegvFCyNjNyLEGhjGj48iTNiMpefT6i4Rpzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WB6SmFvI; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773121872; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=RmK1Nc9lCr9lQbUEEr8YJz/ZJtYUzCfVYaSHJv4uhls=;
	b=WB6SmFvIJeafk29YQHGaysSZvN6NpuoLIvqMIH7p+ZXqDbpO88yzpP+rB1HKYHNka5aF/iHsx1LI/TL1+c6aZ9Z2DQaSwSLgKGXV6Ka75eHfhe31JDe36fvyL4OSX1qcHxN6K1YF3saUUhWTp75hYZC7FBZp0bIs8ZOfvxXU//k=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-f-NWz_1773121871 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 13:51:11 +0800
Date: Tue, 10 Mar 2026 13:51:11 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
Message-ID: <20260310055111.GB40558@j66a10360.sqa.eu95>
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
 <20260309060611.GA130186@j66a10360.sqa.eu95>
 <ade7f1a6d89525cb0545ac12603edb8e448f9493@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade7f1a6d89525cb0545ac12603edb8e448f9493@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: 0B1DA245915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17845-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,alibaba.com:email,linux.alibaba.com:dkim,linux.dev:email,syzkaller.appspot.com:url,j66a10360.sqa.eu95:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:48:54AM +0000, Jiayuan Chen wrote:
> March 9, 2026 at 14:06, "D. Wythe" <alibuda@linux.alibaba.com mailto:alibuda@linux.alibaba.com?to=%22D.%20Wythe%22%20%3Calibuda%40linux.alibaba.com%3E > wrote:
> 
> 
> [...]
> > >  Reproducer was verified with mdelay injection and smc_run,
> > >  the issue no longer occurs with this patch applied.
> > >  
> > >  [1] https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
> > >  
> > >  Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> > >  Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> > >  Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/
> > >  Suggested-by: Eric Dumazet <edumazet@google.com>
> > >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > >  ---
> > >  v2:
> > >  - Use rcu_read_lock() + refcount_inc_not_zero() instead of
> > >  read_lock_bh(sk_callback_lock) + sock_hold(), since this
> > >  is the TCP handshake hot path and read_lock_bh is too
> > >  expensive under SYN flood.
> > >  - Set SOCK_RCU_FREE on SMC listen socket to ensure
> > >  RCU-deferred freeing.
> > >  
> > >  v1: https://lore.kernel.org/netdev/20260307032158.372165-1-jiayuan.chen@linux.dev/
> > >  ---
> > >  net/smc/af_smc.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >  
> > >  diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > >  index d0119afcc6a1..72ac1d8c62d4 100644
> > >  --- a/net/smc/af_smc.c
> > >  +++ b/net/smc/af_smc.c
> > >  @@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> > >  struct smc_sock *smc;
> > >  struct sock *child;
> > >  
> > >  + rcu_read_lock();
> > >  smc = smc_clcsock_user_data(sk);
> > >  + if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
> > >  + rcu_read_unlock();
> > >  + return NULL;
> > >  + }
> > >  + rcu_read_unlock();
> > >  
> > >  if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
> > >  sk->sk_max_ack_backlog)
> > >  @@ -153,11 +159,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> > >  if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> > >  inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
> > >  }
> > >  + sock_put(&smc->sk);
> > >  return child;
> > >  
> > >  drop:
> > >  dst_release(dst);
> > >  tcp_listendrop(sk);
> > >  + sock_put(&smc->sk);
> > >  return NULL;
> > >  }
> > >  
> > >  @@ -2691,6 +2699,7 @@ int smc_listen(struct socket *sock, int backlog)
> > >  write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
> > >  goto out;
> > >  }
> > >  + sock_set_flag(sk, SOCK_RCU_FREE);
> > > 
> > This RCU approach looks good to me. Since SOCK_RCU_FREE is now enabled,
> > other callers of smc_clcsock_user_data() should also follow this
> > RCU-based pattern. It will eventually allow us to completely remove the
> > annoying sk_callback_lock.
> > 
> > D. Wythe
> > 
> 
> 
> Hi D. Wythe,
> 
> Thanks for the suggestion. I agree that converting all smc_clcsock_user_data()
> callers to RCU is a reasonable direction, and it would allow us to eventually
> remove the sk_callback_lock dependency for sk_user_data access.
> 
> However, I'd prefer to keep this patch focused on fixing the specific bug in
> smc_tcp_syn_recv_sock(), since it needs to be backported to stable trees.
> Mixing a bug fix with broader refactoring makes backporting harder and increases
> the risk of regressions.
> 
> Also, converting the other callers is not entirely trivial. For example:
> 
> - smc_fback_state_change/data_ready/write_space/error_report():
>   the sk_callback_lock there protects not only sk_user_data but also the
>   consistency of the saved callback pointers (e.g.,smc->clcsk_state_change).
>   Switching to RCU requires careful ordering analysis against the write side
>   in smc_fback_restore_callbacks(). Additionally, fallback sockets would also
>   need SOCK_RCU_FREE.
> 
> - smc_clcsock_data_ready():
>   the sock_hold() would need to become refcount_inc_not_zero() to handle the
>   case where the refcount has already reached zero.
> 
> I'd like to address these conversions in a follow-up patch series.
> 
> What do you think?

Thanks for the detailed explanation. I agree with your plan, it's
better to keep the bug fix and the optimization separate.

> 
> > > 
> > > sk->sk_max_ack_backlog = backlog;
> > >  sk->sk_ack_backlog = 0;
> > >  sk->sk_state = SMC_LISTEN;
> > >  -- 
> > >  2.43.0
> > >
> >


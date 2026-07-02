Return-Path: <linux-rdma+bounces-22667-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zz6gIsvYRWoMGAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22667-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 05:19:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A666F3317
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 05:19:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Vmua5xOI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22667-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22667-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDC3304D753
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 03:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05030FC39;
	Thu,  2 Jul 2026 03:18:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD4181334;
	Thu,  2 Jul 2026 03:18:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962287; cv=none; b=YZG/xCK87lwHLzrRK9Qos7uPaRZ6E1m414oyo045a8VYJb3ETq2WzIVhnqUCiBh9rX2SWFoNBdKXf7ecsRpbEeUWDq0ar+6gPNpdTkPVK0rGv1pAY92NDf/LhLENR/7WmccxPEhqO2Q8D7YnVBOZNWZN1x55sweWg1hAUNPK5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962287; c=relaxed/simple;
	bh=3BcLJWhoWFgV9slK/ItxBb1txl9oDXdEKTXeS5guuzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ2+CwAPEtbqjPQwGBpfCOy56Ohcia0d5ai1B6ljg3tzaLAxROOCO88HnZgMKOAF0g31orMZFHTbmb9psoKrugnfAKdF4jAaG6MWgs+Wd47zkniFOeCsNRcksiJzE7dLnOLJWCLAv9O+1GaRYvDpEeKzpdM8ITfHkVYF25ZqKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vmua5xOI; arc=none smtp.client-ip=115.124.30.112
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782962277; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qRFiwz274BAI0tGfuVu7HAAEPreWRlpaAR/BIu4h8tk=;
	b=Vmua5xOIn0pQxAoY4HSGskLC67IkQmApMngqhYqLpCjnBtZma6lpHk1g+CyYLProUQyX1RTj1xJjQuXTN/rBkev6b24BIWJqHZvT9tRFOzDEsn0E5HKKyjpARtBpvCek+dMaZsvASyIhab+73Ub/HX6L78H/oZYERI69ft+z5DA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X6CQ0f9_1782962275;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X6CQ0f9_1782962275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 11:17:56 +0800
Date: Thu, 2 Jul 2026 11:17:55 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net/smc: fix out-of-bounds read when sk_user_data
 holds a sk_psock
Message-ID: <20260702031755.GA70283@j66a10360.sqa.eu95>
References: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
 <c222390f-96c7-4dc3-8f33-f4dd277c3639@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c222390f-96c7-4dc3-8f33-f4dd277c3639@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22667-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com,davemloft.net,google.com,kernel.org,linux.dev,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:from_mime,j66a10360.sqa.eu95:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5A666F3317

On Wed, Jul 01, 2026 at 05:27:11PM +0200, Paolo Abeni wrote:
> On 6/29/26 11:51 AM, Sechang Lim wrote:
> > A passive-open child inherits the listener's smc_clcsock_data_ready().
> > sk_clone_lock() clears its sk_user_data to NULL because the listener tagged
> > it SK_USER_DATA_NOCOPY. Until accept restores the callback, a BPF sock_ops
> > program can add the established child to a sockmap, and sk_psock_init()
> > installs a sk_psock into the NULL sk_user_data. The inherited callback then
> > reads it back through smc_clcsock_user_data(), which strips only NOCOPY,
> > takes the sk_psock for an smc_sock, and dereferences a clcsk_* field past
> > its end:
> > 
> >   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
> >   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
> >    <IRQ>
> >    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
> >    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
> >    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
> >    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
> >    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
> >    [...]
> >    </IRQ>
> > 
> >   Allocated by task 67930:
> >    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
> >    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
> >    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
> >    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
> >    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
> >    [...]
> > 
> > Resolve the conflict on the write path. Reserve the child's sk_user_data
> > with a NULL pointer tagged SK_USER_DATA_NOCOPY so sk_psock_init() returns
> > -EBUSY, and release it at accept. smc_clcsock_user_data() still strips the
> > tag to NULL, so the inherited callback stays a no-op.
> > 
> > Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> > Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> > ---
> > v3:
> >  - reserve sk_user_data on the write path instead of the read-side check (D. Wythe)
> > 
> > v2:
> >  - https://lore.kernel.org/netdev/20260619150342.3626224-1-rhkrqnwk98@gmail.com/
> > 
> > v1:
> >  - https://lore.kernel.org/netdev/20260614120931.4041687-1-rhkrqnwk98@gmail.com/
> > 
> >  net/smc/af_smc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index b5db69073e20..78f162344fe3 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -154,7 +154,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> >  					       own_req, opt_child_init);
> >  	/* child must not inherit smc or its ops */
> >  	if (child) {
> > -		rcu_assign_sk_user_data(child, NULL);
> > +		/* reserve sk_user_data so sockmap cannot claim the slot */
> > +		write_lock_bh(&child->sk_callback_lock);
> > +		__rcu_assign_sk_user_data_with_flags(child, NULL,
> > +						     SK_USER_DATA_NOCOPY);
> > +		write_unlock_bh(&child->sk_callback_lock);
> >  
> >  		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
> >  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> > @@ -1773,6 +1777,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
> >  	/* new clcsock has inherited the smc listen-specific sk_data_ready
> >  	 * function; switch it back to the original sk_data_ready function
> >  	 */
> > +	write_lock_bh(&new_clcsock->sk->sk_callback_lock);
> >  	new_clcsock->sk->sk_data_ready = lsmc->clcsk_data_ready;
> >  
> >  	/* if new clcsock has also inherited the fallback-specific callback
> > @@ -1786,6 +1791,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
> >  		if (lsmc->clcsk_error_report)
> >  			new_clcsock->sk->sk_error_report = lsmc->clcsk_error_report;
> >  	}
> > +	/* release the slot reserved in smc_tcp_syn_recv_sock() */
> > +	rcu_assign_sk_user_data(new_clcsock->sk, NULL);
> > +	write_unlock_bh(&new_clcsock->sk->sk_callback_lock);
> 
> Sashiko reports that this still cause problem on fallback.
> 
> @Wythe, I understand from previous discussion that you would prefer to
> address such issues separately (and thus you are fine with the patch in
> the current form). Could you please confirm?

No, I do not agree with this patch in any form. As I replied to it, I do
not think this is the right direction.

D. Wythe

> 
> /P
> >  
> >  	(*new_smc)->clcsock = new_clcsock;
> >  out:


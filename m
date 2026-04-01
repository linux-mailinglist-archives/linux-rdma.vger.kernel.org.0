Return-Path: <linux-rdma+bounces-18876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEwZDvvOzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:53:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17796376510
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BD4230860C5
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096338CFF3;
	Wed,  1 Apr 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ICgU3kYI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702B35E936;
	Wed,  1 Apr 2026 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029547; cv=none; b=NQ++2YkEVUvJxdfNb8+aDqCgpjoJumppJXjSj4Wzg0jIPjs4STQMz/4knnWFwcAnpp+f1spxlVZmdisID6BKOsghdFhyJh1c6MpuVZnXUzeCOrgcdWzfR+bkYm0Vgh2EOG1vAtctQWu6PaJRs2IhhL9utEX/dzuBeHV35WWcv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029547; c=relaxed/simple;
	bh=kApfysLmil/v0Oj2JmnKLBK0dorCkw228crfG1s8AD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xpes9io5/H/23AXuW3XYrkaIxb2kXso3Qv/alnLwHoAEtSUgbo8guJbFlAoQMYeV/fcc+vv3IwMdIMwr8rzMQYC54nzznCGJm85Zjy/9KwPZczQKWFvqNNGezIYE4yAkRnLIM7orkcH9CspWxkwwpOatgdUjyxrmS60zVneIe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ICgU3kYI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=TjlEaZufkIfdPkUMCDh5SD89kPYTqyaHCXw8Muwc4Dk=; b=ICgU3kYIYD7TcubUA2flzaCQ0/
	Y1xq8IIwcHVpeuRBs2Sk5bzpKgsAJH4Ach8Tt1JHYt4wh0jYcY6e+SATwyK4RcZ/7221wQ27l1y2E
	O3cgTAk/OztH7NNk72E5Bf2RwSS34DSuaYUnyizucHQyG/+WmOWj1vdkACs6nq4qlMsZGSsEfWGNS
	hXSAVX0fEOkaA99zZ9kqYN6yxmdUYCJQkEtOxNFaQ7BJhkHkfggNP9lw9mMGOfHK6IUONyvssH4Q0
	9gZpb8pHebi9BTlNi6Yopj0pLSCVCcKonmuA4rkAb/dLverJuSQ9UZS7Ic1Jul4M9LMCBmkEXo8vL
	C49g96Qw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGN-0000000HLQS-0BKX;
	Wed, 01 Apr 2026 07:45:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xeP-3Bbt;
	Wed, 01 Apr 2026 08:45:18 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	torvalds@linux-foundation.org,
	jon.maddog.hall@gmail.com
Subject: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Date: Wed,  1 Apr 2026 08:44:20 +0100
Message-ID: <20260401074509.1897527-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401074509.1897527-1-dwmw2@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18876-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.co.uk:email,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 17796376510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

There is no need to listen on AF_INET sockets; a modern application can
listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
socket.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 net/ipv4/af_inet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index dc358faa1647..3838782a8437 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
 	struct sock *sk = sock->sk;
 	int err = -EINVAL;
 
+	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
+		     current->comm, task_pid_nr(current));
+
 	lock_sock(sk);
 
 	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
-- 
2.51.0



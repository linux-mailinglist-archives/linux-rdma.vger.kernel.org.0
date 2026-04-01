Return-Path: <linux-rdma+bounces-18872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNlFC2/PzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:55:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E23765A9
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA3D3066882
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FA38B7B3;
	Wed,  1 Apr 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qppyHh4y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CC38552F;
	Wed,  1 Apr 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029545; cv=none; b=DBF5fLoR5w3vQQqHSeQ6809h2L1zGT8ZcC3U0Xi45v0QJp705Chq53nTQ0a14THwgK/1vuYIOrYiAbdqHpmoGJKAqfFF8fFnNVIGEp8cmTo2H5VXAXG5wfMIHsnIlt4SVyxTkdYHSYIfXfvAir1SWmVoOydmHy1AHqy9j0gy8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029545; c=relaxed/simple;
	bh=qN7W5IBVBu/OQTCESu4Ceo7yTOnBD6XUujV3W2X5nu8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Fo8BJRKys1ArCG1GrCKGbO7v+uajmYkwBheiMH04hY6F2ybJtbQ4xxTY5s3uq+2Tkx+duq18CS0EwERyym2YuPI07Moj8Rj/APKNcvhC3NbmTJCqr/ZZ4eMH/xOVIG91ZlIxDOR62e2RJVFHbtJIFTd7w0Q+YTBawfB9fscvhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qppyHh4y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ocYqYAcgR1+/f5z2PeObgww9KvTkVcu5upOhy12M96c=; b=qppyHh4yVyPfuZinNmzNuvUo98
	ZzIQLIAkGtEusEFCWJLH056dBP0ZGgDld2dbOncKsxuY3CdOjHfDNBojsMgurWLZKRZ2VEb3DZ6lI
	RfsN1GcZUdsyEr5B7f5wp3K35mkdWnmyVDGQZSmA2Dl6j2mZNYm0KMTuEEl/7vMAvNs4ePewrI7FM
	2O0TjqZhbd94Bc4ck74/suWRXQ1kS8kGuAZt/IXK5LxpTVyqsK5xpycHKG97uEHKkkxJzhThrDmJM
	IuvFXMEMqWQbh3URIbtzq1ou7YPYh8Z6QUyTRAgNmBChGcFHdjPbAAcsH5RXTZWoNL3MngVsfUPBL
	re9IFLlA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGN-0000000HLQO-0An7;
	Wed, 01 Apr 2026 07:45:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xe2-1Dj0;
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
Subject: [PATCH 0/6] Deprecate Legacy IP
Date: Wed,  1 Apr 2026 08:44:14 +0100
Message-ID: <20260401074509.1897527-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18872-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 882E23765A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC1883, the IPv6 standard, was published in the final decade of the 1900s.
That's closer in time to the Apollo 11 moon landing than it was to today.

Even our esteemed Maddog has worked with computers for longer in the IPv6
era, than he ever did before it.

Yet Linux still can't even be *built* with only IPv6 support and without
support for Legacy IP. This long overdue patch series fixes that, and
immediately marks Legacy IP for deprecation.

It also cleans up a few tautological "INET && IPV6" and "INET || IPV6"
checks, since IPV6 (and now LEGACY_IP) cannot be selected without the
overall CONFIG_INET option.

For now, we only add a warning when a process *listens* on a Legacy IP
socket (since you can listen on IPv6 and still accept connections which
have come through a timewarp from the 20th century. Adding warnings for
making outbound connections or *accepting* on Legacy IP can come later.

  'I would be happy if "Legacy IP" ceased to be the "industry standard"
   and IPv6 be the default, even if I had to beat IPv6 into the head of
   every single network administrator's head with a shovel.' said Jon
  'maddog' Hall, ancient supporter of Free and Open Source Software.

David Woodhouse (6):
      net: Simplify tautological CONFIG_INET/CONFIG_IPV6 guards
      net: Add CONFIG_LEGACY_IP option
      net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
      net: Make IPv4-only Kconfig options depend on LEGACY_IP
      net: Change CONFIG_INET to CONFIG_LEGACY_IP for IPv4-only code
      net: Warn when processes listen on AF_INET sockets

 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  6 ++--
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.h    |  2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  2 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |  2 +-
 include/linux/indirect_call_wrapper.h              |  4 ++-
 net/bridge/br_arp_nd_proxy.c                       |  2 +-
 net/bridge/br_private.h                            |  8 +++++
 net/core/filter.c                                  | 12 +++----
 net/core/secure_seq.c                              |  2 +-
 net/core/sock.c                                    |  2 +-
 net/ipv4/Kconfig                                   | 37 ++++++++++++++++++++++
 net/ipv4/af_inet.c                                 | 23 +++++++++++---
 net/ipv4/devinet.c                                 |  2 ++
 net/ipv4/route.c                                   |  1 -
 net/ipv4/tcp_ipv4.c                                | 30 ++++++++++--------
 net/mac80211/main.c                                | 10 +++---
 net/netfilter/nfnetlink_queue.c                    |  2 +-
 17 files changed, 105 insertions(+), 42 deletions(-)



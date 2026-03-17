Return-Path: <linux-rdma+bounces-18254-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMNOJnthuWlsCwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18254-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:13:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6A2AB914
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B4C317A2F4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAB3E51D9;
	Tue, 17 Mar 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ebz/G3R+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bY/Sxi5Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hZgmHstn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rJ/vBunS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D83E1225
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756233; cv=none; b=JEuUgS5l/Kk8768H7RCCSC3VXIPR/I3vWKCoWs81SUIfyIRWPNmwAQuA72zaZUDwqqcL6DbwIcnuYTM4s3gwK1D1+t0s9Irscpv+Xo5fAb5SbtCiWWw4zIKAVDD6PaX+ysolg+CNfbKisCKpZrPnbhMLB+EVimPIPWp7qeHPbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756233; c=relaxed/simple;
	bh=dCSQSXrKGQoAUvW5WVdilFHh88vpFe8J+SDoNANzihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSCNnDn/SMphQ7MePlxcuDv2fiYHE0icuvTP8HkZ4zGx0omifebx90nORX4SUHiyucdAE2u/VvzM3QJcAvIcYT8Bw2UD3LpepRwvt9qKDcQpl+I3xHaJF9DAPRrYQ5VBWXSvMvQNGbXx2Ctgrw6H85TcADKxd3ZW28DQGTCRBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ebz/G3R+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bY/Sxi5Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hZgmHstn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rJ/vBunS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5B055BE0D;
	Tue, 17 Mar 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjJG4+eBf234gf25TIf5S+ExqzLP/QpJradFvOgQTdE=;
	b=Ebz/G3R+uFTlL1jKI4o/k3zoo1EFr3pJws2qzVb3XsS1QrIydmD4MvCuUGhyb3f3ZFBaB5
	V77sNNbVSRwR9ICGsAe2wMZVuKMNtXT+tctFXIqFUJH9vUM9+dg35BOuh8BvnpuRAZP8Li
	Z0kADZyhbf/ifvuCW7W632cDC+/YKew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjJG4+eBf234gf25TIf5S+ExqzLP/QpJradFvOgQTdE=;
	b=bY/Sxi5Z+mgIke4KMYiPhnm1/QC0bmPykDEgY2IeO0/f9pYrDgPKPxfebx/U7r5kb2lqrf
	26+n+6ljkRad/0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjJG4+eBf234gf25TIf5S+ExqzLP/QpJradFvOgQTdE=;
	b=hZgmHstnhJWf3r2ke5rsOqUvJpVU7bbKmu3Dv/wkDOfrKGniV+C5UPLcTbe6I1PawXm0nb
	s7n1Gy3rmrUqzM/sZd7Q/GJvzdAtb7qVXqc+Y3JzX/hNygoxiM3inY6y2/Thtm7fV1Hd4+
	MEOGnWq6EMoL2J7aHtgrUQKbnzb46Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjJG4+eBf234gf25TIf5S+ExqzLP/QpJradFvOgQTdE=;
	b=rJ/vBunS9I2TjiUZSPBAuvuyUOex2M28ZCLz6lYHyP+bf2fV2pQBSogZ82OXHuCwbHf29S
	GRKrjInR9XU14aDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8344273B;
	Tue, 17 Mar 2026 14:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QK4gDzlfuWmpYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Mar 2026 14:03:37 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Oliver Neukum <oliver@neukum.org>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Alexandre Cassen <acassen@corp.free.fr>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	osmocom-net-gprs@lists.osmocom.org,
	linux-usb@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH 05/10 net-next v3] drivers: net: drop ipv6_stub usage and use direct function calls
Date: Tue, 17 Mar 2026 15:01:01 +0100
Message-ID: <20260317140141.5723-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317140141.5723-1-fmancera@suse.de>
References: <20260317140141.5723-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[suse.de,suse.com,zx2c4.com,openvpn.net,gmail.com,ziepe.ca,kernel.org,nvidia.com,lunn.ch,davemloft.net,google.com,redhat.com,netfilter.org,gnumonks.org,queasysnail.net,neukum.org,blackwall.org,corp.free.fr,fomichev.me,vger.kernel.org,corigine.com,amd.com,lists.osmocom.org,lists.zx2c4.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18254-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,openvpn.net:email,zx2c4.com:email]
X-Rspamd-Queue-Id: 01A6A2AB914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
necessary.

Convert all drivers currently utilizing ipv6_stub to make direct
function calls. The fallback functions introduced previously will
prevent linkage errors when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/infiniband/core/addr.c                  |  3 +--
 drivers/infiniband/sw/rxe/rxe_net.c             |  6 +++---
 .../ethernet/mellanox/mlx5/core/en/rep/neigh.c  | 12 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c |  3 +--
 .../mellanox/mlx5/core/en/tc_tun_encap.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c         |  1 -
 .../net/ethernet/mellanox/mlx5/core/en_rep.c    |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |  1 -
 .../ethernet/mellanox/mlxsw/spectrum_router.c   |  9 +++++----
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c |  3 ++-
 .../net/ethernet/netronome/nfp/flower/action.c  |  2 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c |  9 ++++-----
 drivers/net/ethernet/sfc/tc_counters.c          |  2 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c     |  5 ++---
 drivers/net/geneve.c                            |  1 -
 drivers/net/gtp.c                               |  2 +-
 drivers/net/ovpn/peer.c                         |  3 +--
 drivers/net/ovpn/udp.c                          |  3 +--
 drivers/net/usb/cdc_mbim.c                      | 17 +++++++++--------
 drivers/net/vrf.c                               |  3 ++-
 drivers/net/vxlan/vxlan_core.c                  | 11 +++++------
 drivers/net/vxlan/vxlan_multicast.c             |  6 ++----
 drivers/net/wireguard/socket.c                  |  3 +--
 drivers/net/wireless/intel/ipw2x00/ipw2100.c    |  2 +-
 net/bridge/br_arp_nd_proxy.c                    |  3 +--
 25 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 866746695712..48d4b06384ec 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -41,7 +41,6 @@
 #include <net/neighbour.h>
 #include <net/route.h>
 #include <net/netevent.h>
-#include <net/ipv6_stubs.h>
 #include <net/ip6_route.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
@@ -411,7 +410,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
 	fl6.saddr = src_in->sin6_addr;
 	fl6.flowi6_oif = addr->bound_dev_if;
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
+	dst = ip6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f7..cbc646a30003 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -138,9 +138,9 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
-					       NULL);
+	ndst = ip6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
+				   recv_sockets.sk6->sk, &fl6,
+				   NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		return NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index d220b045b331..56930bad94eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -10,6 +10,7 @@
 #include <linux/notifier.h>
 #include <net/netevent.h>
 #include <net/arp.h>
+#include <net/ndisc.h>
 #include "neigh.h"
 #include "tc.h"
 #include "en_rep.h"
@@ -18,8 +19,10 @@
 
 static unsigned long mlx5e_rep_ipv6_interval(void)
 {
-	if (IS_ENABLED(CONFIG_IPV6) && ipv6_stub->nd_tbl)
-		return NEIGH_VAR(&ipv6_stub->nd_tbl->parms, DELAY_PROBE_TIME);
+	struct neigh_table *tbl = ipv6_get_nd_tbl();
+
+	if (IS_ENABLED(CONFIG_IPV6) && ipv6_mod_enabled())
+		return NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME);
 
 	return ~0UL;
 }
@@ -217,7 +220,7 @@ static int mlx5e_rep_netevent_event(struct notifier_block *nb,
 	case NETEVENT_NEIGH_UPDATE:
 		n = ptr;
 #if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl != ipv6_stub->nd_tbl && n->tbl != &arp_tbl)
+		if (n->tbl != ipv6_get_nd_tbl() && n->tbl != &arp_tbl)
 #else
 		if (n->tbl != &arp_tbl)
 #endif
@@ -238,7 +241,8 @@ static int mlx5e_rep_netevent_event(struct notifier_block *nb,
 		 * done per device delay prob time parameter.
 		 */
 #if IS_ENABLED(CONFIG_IPV6)
-		if (!p->dev || (p->tbl != ipv6_stub->nd_tbl && p->tbl != &arp_tbl))
+		if (!p->dev ||
+		    (p->tbl != ipv6_get_nd_tbl() && p->tbl != &arp_tbl))
 #else
 		if (!p->dev || p->tbl != &arp_tbl)
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index a14f216048cd..de74dbfe7b20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -453,8 +453,7 @@ static int mlx5e_route_lookup_ipv6_get(struct mlx5e_priv *priv,
 
 	if (tunnel && tunnel->get_remote_ifindex)
 		attr->fl.fl6.flowi6_oif = tunnel->get_remote_ifindex(dev);
-	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(dev), NULL, &attr->fl.fl6,
-					      NULL);
+	dst = ip6_dst_lookup_flow(dev_net(dev), NULL, &attr->fl.fl6, NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index bfd401bee9e8..ce2a27124642 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -402,7 +402,7 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 		tbl = &arp_tbl;
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (m_neigh->family == AF_INET6)
-		tbl = ipv6_stub->nd_tbl;
+		tbl = ipv6_get_nd_tbl();
 #endif
 	else
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 64e13747084e..a52e12c3c95a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -36,7 +36,6 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <net/netevent.h>
-#include <net/ipv6_stubs.h>
 
 #include "en.h"
 #include "eswitch.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1db4ecb2356f..5ec5cae8d229 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -38,7 +38,6 @@
 #include <net/pkt_cls.h>
 #include <net/act_api.h>
 #include <net/devlink.h>
-#include <net/ipv6_stubs.h>
 
 #include "eswitch.h"
 #include "en.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 1434b65d4746..4e4ee1d520ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -40,7 +40,6 @@
 #include <linux/refcount.h>
 #include <linux/completion.h>
 #include <net/arp.h>
-#include <net/ipv6_stubs.h>
 #include <net/bareudp.h>
 #include <net/bonding.h>
 #include <net/dst_metadata.h>
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7bd87d0547d8..8531216f6389 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2458,7 +2458,7 @@ static void mlxsw_sp_router_neigh_ent_ipv6_process(struct mlxsw_sp *mlxsw_sp,
 	}
 
 	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
-	n = neigh_lookup(&nd_tbl, &dip, dev);
+	n = neigh_lookup(ipv6_get_nd_tbl(), &dip, dev);
 	if (!n)
 		return;
 
@@ -3022,7 +3022,8 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		goto err_arp;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	neigh_for_each(ipv6_get_nd_tbl(),
+		       mlxsw_sp_neigh_rif_made_sync_each, &rms);
 #endif
 	if (rms.err)
 		goto err_nd;
@@ -5124,7 +5125,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 	case AF_INET6:
 		memcpy(&nh->gw_addr, &nh_obj->ipv6, sizeof(nh_obj->ipv6));
 #if IS_ENABLED(CONFIG_IPV6)
-		nh->neigh_tbl = &nd_tbl;
+		nh->neigh_tbl = ipv6_get_nd_tbl();
 #endif
 		break;
 	}
@@ -6980,7 +6981,7 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 	nh->nh_weight = rt->fib6_nh->fib_nh_weight;
 	memcpy(&nh->gw_addr, &rt->fib6_nh->fib_nh_gw6, sizeof(nh->gw_addr));
 #if IS_ENABLED(CONFIG_IPV6)
-	nh->neigh_tbl = &nd_tbl;
+	nh->neigh_tbl = ipv6_get_nd_tbl();
 #endif
 
 	err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index ae63d549b542..f05ccf3db876 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -576,7 +576,8 @@ mlxsw_sp_span_entry_gretap6_parms(struct mlxsw_sp *mlxsw_sp,
 	l3edev = mlxsw_sp_span_gretap6_route(to_dev, &saddr.addr6, &gw.addr6);
 	return mlxsw_sp_span_entry_tunnel_parms_common(l3edev, saddr, daddr, gw,
 						       tparm.hop_limit,
-						       &nd_tbl, sparmsp);
+						       ipv6_get_nd_tbl(),
+						       sparmsp);
 }
 
 static int
diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index aca2a7417af3..ae2f8b31adfb 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -470,7 +470,7 @@ nfp_fl_set_tun(struct nfp_app *app, struct nfp_fl_set_tun *set_tun,
 
 		flow.daddr = ip_tun->key.u.ipv6.dst;
 		flow.flowi4_proto = IPPROTO_UDP;
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &flow, NULL);
+		dst = ip6_dst_lookup_flow(net, NULL, &flow, NULL);
 		if (!IS_ERR(dst)) {
 			set_tun->ttl = ip6_dst_hoplimit(dst);
 			dst_release(dst);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 0cef0e2b85d0..053265e135f6 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -277,7 +277,7 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, struct sk_buff *skb)
 		if (!netdev)
 			continue;
 
-		n = neigh_lookup(&nd_tbl, ipv6_add, netdev);
+		n = neigh_lookup(ipv6_get_nd_tbl(), ipv6_add, netdev);
 		if (!n)
 			continue;
 
@@ -650,7 +650,7 @@ static void nfp_tun_neigh_update(struct work_struct *work)
 		flow6.daddr = *(struct in6_addr *)n->primary_key;
 		if (!neigh_invalid) {
 			struct dst_entry *dst;
-			/* Use ipv6_dst_lookup_flow to populate flow6->saddr
+			/* Use ip6_dst_lookup_flow to populate flow6->saddr
 			 * and other fields. This information is only needed
 			 * for new entries, lookup can be skipped when an entry
 			 * gets invalidated - as only the daddr is needed for
@@ -730,7 +730,7 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 	}
 #if IS_ENABLED(CONFIG_IPV6)
-	if (n->tbl != ipv6_stub->nd_tbl && n->tbl != &arp_tbl)
+	if (n->tbl != ipv6_get_nd_tbl() && n->tbl != &arp_tbl)
 #else
 	if (n->tbl != &arp_tbl)
 #endif
@@ -815,8 +815,7 @@ void nfp_tunnel_request_route_v6(struct nfp_app *app, struct sk_buff *skb)
 	flow.flowi6_proto = IPPROTO_UDP;
 
 #if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
-	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(netdev), NULL, &flow,
-					      NULL);
+	dst = ip6_dst_lookup_flow(dev_net(netdev), NULL, &flow, NULL);
 	if (IS_ERR(dst))
 		goto fail_rcu_unlock;
 #else
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index d168282f30bf..d8a5f9fd1007 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -112,7 +112,7 @@ static void efx_tc_counter_work(struct work_struct *work)
 					 encap->neigh->egdev);
 		else
 #if IS_ENABLED(CONFIG_IPV6)
-			n = neigh_lookup(ipv6_stub->nd_tbl,
+			n = neigh_lookup(ipv6_get_nd_tbl(),
 					 &encap->neigh->dst_ip6,
 					 encap->neigh->egdev);
 #else
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index da35705cc5e1..63d8f794b869 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -149,8 +149,7 @@ static int efx_bind_neigh(struct efx_nic *efx,
 #if IS_ENABLED(CONFIG_IPV6)
 			struct dst_entry *dst;
 
-			dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &flow6,
-							      NULL);
+			dst = ip6_dst_lookup_flow(net, NULL, &flow6, NULL);
 			rc = PTR_ERR_OR_ZERO(dst);
 			if (rc) {
 				NL_SET_ERR_MSG_MOD(extack, "Failed to lookup route for IPv6 encap");
@@ -531,7 +530,7 @@ static int efx_neigh_event(struct efx_nic *efx, struct neighbour *n)
 	if (n->tbl == &arp_tbl) {
 		keysize = sizeof(keys.dst_ip);
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (n->tbl == ipv6_stub->nd_tbl) {
+	} else if (n->tbl == ipv6_get_nd_tbl()) {
 		ipv6 = true;
 		keysize = sizeof(keys.dst_ip6);
 #endif
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 01cdd06102e0..c6563367d382 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/etherdevice.h>
 #include <linux/hash.h>
-#include <net/ipv6_stubs.h>
 #include <net/dst_metadata.h>
 #include <net/gro_cells.h>
 #include <net/rtnetlink.h>
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e8949f556209..70b9e58b9b78 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -374,7 +374,7 @@ static struct rt6_info *ip6_route_output_gtp(struct net *net,
 	fl6->saddr		= *saddr;
 	fl6->flowi6_proto	= sk->sk_protocol;
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, fl6, NULL);
+	dst = ip6_dst_lookup_flow(net, sk, fl6, NULL);
 	if (IS_ERR(dst))
 		return ERR_PTR(-ENETUNREACH);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3716a1d82801..6dd11c71204b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -821,8 +821,7 @@ static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_priv *ovpn,
 		.daddr = dest,
 	};
 
-	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
-						NULL);
+	entry = ip6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl, NULL);
 	if (IS_ERR(entry)) {
 		net_dbg_ratelimited("%s: no route to host %pI6c\n",
 				    netdev_name(ovpn->dev), &dest);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 272b535ecaad..059e896b4a2f 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -14,7 +14,6 @@
 #include <net/addrconf.h>
 #include <net/dst_cache.h>
 #include <net/route.h>
-#include <net/ipv6_stubs.h>
 #include <net/transp_v6.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
@@ -251,7 +250,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		dst_cache_reset(cache);
 	}
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
 	if (IS_ERR(dst)) {
 		ret = PTR_ERR(dst);
 		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index dbf01210b0e7..877fb0ed7d3d 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -20,7 +20,6 @@
 #include <linux/usb/cdc_ncm.h>
 #include <net/ipv6.h>
 #include <net/addrconf.h>
-#include <net/ipv6_stubs.h>
 #include <net/ndisc.h>
 
 /* alternative VLAN for IP session 0 if not untagged */
@@ -302,6 +301,7 @@ static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /* Some devices are known to send Neighbor Solicitation messages and
  * require Neighbor Advertisement replies.  The IPv6 core will not
  * respond since IFF_NOARP is set, so we must handle them ourselves.
@@ -342,12 +342,11 @@ static void do_neigh_solicit(struct usbnet *dev, u8 *buf, u16 tci)
 	is_router = !!READ_ONCE(in6_dev->cnf.forwarding);
 	in6_dev_put(in6_dev);
 
-	/* ipv6_stub != NULL if in6_dev_get returned an inet6_dev */
-	ipv6_stub->ndisc_send_na(netdev, &iph->saddr, &msg->target,
-				 is_router /* router */,
-				 true /* solicited */,
-				 false /* override */,
-				 true /* inc_opt */);
+	ndisc_send_na(netdev, &iph->saddr, &msg->target,
+		      is_router /* router */,
+		      true /* solicited */,
+		      false /* override */,
+		      true /* inc_opt */);
 out:
 	dev_put(netdev);
 }
@@ -362,7 +361,7 @@ static bool is_neigh_solicit(u8 *buf, size_t len)
 		msg->icmph.icmp6_code == 0 &&
 		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
 }
-
+#endif /* IPV6 */
 
 static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
 {
@@ -378,8 +377,10 @@ static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_
 			proto = htons(ETH_P_IP);
 			break;
 		case 0x60:
+#if IS_ENABLED(CONFIG_IPV6)
 			if (is_neigh_solicit(buf, len))
 				do_neigh_solicit(dev, buf, tci);
+#endif
 			proto = htons(ETH_P_IPV6);
 			break;
 		default:
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8c009bcaa8e7..68edb47cc4eb 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -616,7 +616,8 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	nexthop = rt6_nexthop(dst_rt6_info(dst), &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(&nd_tbl, nexthop, dst->dev, false);
+		neigh = __neigh_create(ipv6_get_nd_tbl(), nexthop,
+				       dst->dev, false);
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 17c941aac32d..4ab94dfe0d12 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -19,7 +19,6 @@
 #include <net/arp.h>
 #include <net/ndisc.h>
 #include <net/gro.h>
-#include <net/ipv6_stubs.h>
 #include <net/ip.h>
 #include <net/icmp.h>
 #include <net/rtnetlink.h>
@@ -2045,7 +2044,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 	    ipv6_addr_is_multicast(&msg->target))
 		goto out;
 
-	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, dev);
+	n = neigh_lookup(ipv6_get_nd_tbl(), &msg->target, dev);
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
@@ -2130,15 +2129,15 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct ipv6hdr *pip6;
 
-		/* check if nd_tbl is not initiliazed due to
-		 * ipv6.disable=1 set during boot
+		/* check if ipv6.disable=1 set during boot was set
+		 * during booting so nd_tbl is not initialized
 		 */
-		if (!ipv6_stub->nd_tbl)
+		if (!ipv6_mod_enabled())
 			return false;
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
-		n = neigh_lookup(ipv6_stub->nd_tbl, &pip6->daddr, dev);
+		n = neigh_lookup(ipv6_get_nd_tbl(), &pip6->daddr, dev);
 		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin6.sin6_addr = pip6->daddr,
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index a7f2d67dc61b..b0e80bca855c 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -39,8 +39,7 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 
 		sk = sock6->sock->sk;
 		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
-						   &ip->sin6.sin6_addr);
+		ret = ipv6_sock_mc_join(sk, ifindex, &ip->sin6.sin6_addr);
 		release_sock(sk);
 #endif
 	}
@@ -73,8 +72,7 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 
 		sk = sock6->sock->sk;
 		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
-						   &ip->sin6.sin6_addr);
+		ret = ipv6_sock_mc_drop(sk, ifindex, &ip->sin6.sin6_addr);
 		release_sock(sk);
 #endif
 	}
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f..c362c78d908e 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -136,8 +136,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 			if (cache)
 				dst_cache_reset(cache);
 		}
-		dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sock), sock, &fl,
-						      NULL);
+		dst = ip6_dst_lookup_flow(sock_net(sock), sock, &fl, NULL);
 		if (IS_ERR(dst)) {
 			ret = PTR_ERR(dst);
 			net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 248a051da52d..c11428485dcc 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -4838,7 +4838,7 @@ static int ipw2100_system_config(struct ipw2100_priv *priv, int batch_mode)
 
 /* If IPv6 is configured in the kernel then we don't want to filter out all
  * of the multicast packets as IPv6 needs some. */
-#if !defined(CONFIG_IPV6) && !defined(CONFIG_IPV6_MODULE)
+#if !defined(CONFIG_IPV6)
 	cmd.host_command = ADD_MULTICAST;
 	cmd.host_command_sequence = 0;
 	cmd.host_command_length = 0;
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 1e2b51769eec..494bf69a3017 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -17,7 +17,6 @@
 #include <linux/if_vlan.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
-#include <net/ipv6_stubs.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_checksum.h>
 #endif
@@ -455,7 +454,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, vlandev);
+	n = neigh_lookup(ipv6_get_nd_tbl(), &msg->target, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 
-- 
2.53.0



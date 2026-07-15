Return-Path: <linux-rdma+bounces-23259-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /lRpLHpDV2o4IQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23259-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:23:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD675BD44
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SI691EE6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23259-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23259-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F75D30131FE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603633CAE94;
	Wed, 15 Jul 2026 08:23:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16A335066;
	Wed, 15 Jul 2026 08:23:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103798; cv=none; b=VEVLnjJuzZB7UbdGplgqv6z7KSIr1+EWzCU2omj63MZJFv7O3Bi+Xhk9A5pOpWEmyr0ZmNs62SExpbX+XliWHpXOf+s5wGa2LfQCxYxZyhXV1Sd89GkCyciwN9LCMC3iAK+TGrO8EPCxlZLZh2tT+nb8ngVw5eCWsPaUuFe4Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103798; c=relaxed/simple;
	bh=mWZZ4PpuWK/gCHUnVtOn48ZZ6/08S0bXCh0Bjq26z6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j1H8qY7b26s2MOac6QyxKK6vr8npjtalty5zQLsjqZMRWPaEoEGhZJ7nIpA1KKLt50wkTA/l4kIBaz64Htg0sf/aLHTra2+cMxhgc8kbNsKnstH3MbhDPwaXnKsLk2MiRZoSxF+nn9uFJ4iMGgEhk5Uuuq7zPOQpaRuC7N7rU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI691EE6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECF1F000E9;
	Wed, 15 Jul 2026 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784103796;
	bh=NipRfKR/AIhoRW+UWLaf5P68SJ3ykLb42Qy5EaWi4dE=;
	h=From:To:Cc:Subject:Date;
	b=SI691EE6pQei0NL2biLud8Uxb71KMeMWNVUjDIktSfXMKQsQbJCIVpcy+zrNXcD6l
	 L763754nXdObsj9EZ8e1KHJOTgMCcsyl+0ApwL3wUdmBmxt+aHp2Vs3UjeHDm+k23K
	 3hoDFJiY9g0M8nAqVvOT/zvyWZ6wxU29r8pXv6vnuhQYGcoNhsZPQZYdf0tCKCZSt9
	 CwG+kcHoAtvhpjnkYa14r+1qnYjR6KXJMCBJnJv5VKviNhrK55DKwy5F6WRcFq5xwx
	 6H9VLxmK9h8QjYYSPcqkT0jnI4PjjFe4ETvmZJgVfJ2qYbaXUl/8qa3sidg7eANG5u
	 PtUse90b1lEtg==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alex Vesker <valex@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH net] net/mlx5: Use unique names for software steering caches
Date: Wed, 15 Jul 2026 11:22:50 +0300
Message-ID: <20260715-kmem-dupliate-name-v1-1-85551c328155@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260715-kmem-dupliate-name-b151167f5119
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:valex@nvidia.com,m:kliteyn@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:borntraeger@linux.ibm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23259-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45BD675BD44

From: Leon Romanovsky <leonro@nvidia.com>

Each software steering domain creates its own slab caches, but all
domains use the same names. When domains for two devices are alive at
once, the second kmem_cache_create() triggers the following splat:

WARNING: mm/slab_common.c:111 at __kmem_cache_create_args+0xca/0x480, CPU#18: devlink/331372
Modules linked in: act_mirred act_skbedit cls_matchall act_gact cls_flower sch_ingress
vhost_vdpa veth nfnetlink_cttimeout openvswitch macvtap macvlan vfio_ap kvm nf_nat_tftp
nf_conntrack_tftp nsh nf_conncount vfio_pci_core irqbypass scsi_debug vhost_net tap tun
vhost_vsock vmw_vsock_virtio_transport_common vsock vhost nft_masq nft_reject_ipv4 act_csum
cls_u32 sch_htb smc_diag smc ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc loop
algif_hash af_alg nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables mlx5_vdpa vdpa mlx5_ib dm_service_time ib_uverbs_support vringh ib_core vhost_iotlb
mlx5_core s390_trng eadm_sch vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm i2c_core
dm_multipath drm_panel_orientation_quirks uvdevice diag288_wdt watchdog hmac_s390 prng aes_s390
zfcp scsi_transport_fc pkey_pckmo pkey_cca pkey_ep11 zcrypt paes_s390 phmac_s390 rng_core
scsi_dh_alua pkey scsi_dh_rdac scsi_dh_emc crypto_engine autofs4 ecdsa_generic ecc sha512 [last unloaded: openvswitch]
CPU: 18 UID: 0 PID: 331372 Comm: devlink Tainted: G        W           7.2.0-20260712.rc2.git0.e3321fa3034d.300.fc44.s390x+debug #1 PREEMPT
Tainted: [W]=WARN
Hardware name: IBM 9175 ME1 701 (LPAR)
Krnl PSW : 0704c00180000000 0000038139a6771a (__kmem_cache_create_args+0xda/0x480)
            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 0000000000000000 000003813b7de578 00000380b9eb8974
            00000276c417f690 00000380b9eb8974 0000030144623348 00000277234a1660
            0000000000000020 00000380b9eb8974 00000277234a1600 000003813b686d30
            0000000000000000 00000380b9e9a810 0000038139a6771a 0000030144623238
Krnl Code: 0000038139a6770a: c02000ebb737       larl    %r2,000003813b7de578
            0000038139a67710: b9040039           lgr     %r3,%r9
           *0000038139a67714: c0e5006e2eb2       brasl   %r14,000003813a82d478
           >0000038139a6771a: a7390020           lghi    %r3,32
            0000038139a6771e: b9040029           lgr     %r2,%r9
            0000038139a67722: c0e5006cf98f       brasl   %r14,000003813a806a40
            0000038139a67728: ec26018e007c       cgij    %r2,0,6,0000038139a67a44
            0000038139a6772e: 58d0f0a4           l       %r13,164(%r15)
Call Trace:
  [<0000038139a6771a>] __kmem_cache_create_args+0xda/0x480
([<0000038139a676a2>] __kmem_cache_create_args+0x62/0x480)
  [<00000380b9da1c70>] dr_domain_init_mem_resources+0x80/0x240 [mlx5_core]
  [<00000380b9da226e>] dr_domain_init_resources.constprop.0+0x7e/0x2c0 [mlx5_core]
  [<00000380b9da28b2>] mlx5dr_domain_create+0x132/0x250 [mlx5_core]
  [<00000380b9dc1e20>] mlx5_cmd_dr_create_ns+0x30/0x90 [mlx5_core]
  [<00000380b9cd8dbe>] mlx5_flow_namespace_set_mode+0x6e/0x130 [mlx5_core]
  [<00000380b9d846ec>] esw_create_offloads_fdb_tables+0xac/0x5a0 [mlx5_core]
  [<00000380b9d865b6>] esw_offloads_steering_init+0x1c6/0x480 [mlx5_core]
  [<00000380b9d86e8e>] esw_offloads_enable+0x13e/0x410 [mlx5_core]
  [<00000380b9d7b04a>] mlx5_eswitch_enable_locked+0x36a/0x540 [mlx5_core]
  [<00000380b9d84ff0>] esw_offloads_start+0x50/0x1d0 [mlx5_core]
  [<00000380b9d8774a>] mlx5_devlink_eswitch_mode_set+0x35a/0x3f0 [mlx5_core]
  [<000003813a791e68>] devlink_nl_eswitch_set_doit+0x88/0x120
  [<000003813a5b93ea>] genl_family_rcv_msg_doit+0xea/0x150
  [<000003813a5b95c2>] genl_family_rcv_msg+0x172/0x210
  [<000003813a5b96c2>] genl_rcv_msg+0x62/0xc0
  [<000003813a5b7cac>] netlink_rcv_skb+0x5c/0x120
  [<000003813a5b8f0c>] genl_rcv+0x3c/0x50
  [<000003813a5b74a4>] netlink_unicast+0x1f4/0x2b0
  [<000003813a5b783c>] netlink_sendmsg+0x2dc/0x460
  [<000003813a4c9764>] __sock_sendmsg+0x64/0xd0
  [<000003813a4cc878>] __sys_sendto+0x108/0x160
  [<000003813a4cdf50>] __do_sys_socketcall+0x350/0x460
  [<000003813a8184d2>] __do_syscall+0x172/0x750
  [<000003813a82d5d2>] system_call+0x72/0x90

Prefix each cache name with the device name to make it unique.

Fixes: fd785e5213f0 ("net/mlx5: DR, Allocate icm_chunks from their own slab allocator")
Fixes: fb628b71fb2a ("net/mlx5: DR, Allocate htbl from its own slab allocator")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Closes: https://lore.kernel.org/all/a3cea501-4d1f-47d5-b6d0-fcda9a0aab16@linux.ibm.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index fedefb565a21..c9f20a9033eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -98,9 +98,12 @@ int mlx5dr_domain_get_recalc_cs_ft_addr(struct mlx5dr_domain *dmn,
 
 static int dr_domain_init_mem_resources(struct mlx5dr_domain *dmn)
 {
+	char name[80];
 	int ret;
 
-	dmn->chunks_kmem_cache = kmem_cache_create("mlx5_dr_chunks",
+	snprintf(name, sizeof(name), "%s-mlx5_dr_chunks",
+		 dev_name(dmn->mdev->device));
+	dmn->chunks_kmem_cache = kmem_cache_create(name,
 						   sizeof(struct mlx5dr_icm_chunk), 0,
 						   SLAB_HWCACHE_ALIGN, NULL);
 	if (!dmn->chunks_kmem_cache) {
@@ -108,7 +111,9 @@ static int dr_domain_init_mem_resources(struct mlx5dr_domain *dmn)
 		return -ENOMEM;
 	}
 
-	dmn->htbls_kmem_cache = kmem_cache_create("mlx5_dr_htbls",
+	snprintf(name, sizeof(name), "%s-mlx5_dr_htbls",
+		 dev_name(dmn->mdev->device));
+	dmn->htbls_kmem_cache = kmem_cache_create(name,
 						  sizeof(struct mlx5dr_ste_htbl), 0,
 						  SLAB_HWCACHE_ALIGN, NULL);
 	if (!dmn->htbls_kmem_cache) {

---
base-commit: f8d04b0c74e989c515e0fa17bf779b730077f63e
change-id: 20260715-kmem-dupliate-name-b151167f5119

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>



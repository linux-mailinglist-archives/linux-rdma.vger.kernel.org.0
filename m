Return-Path: <linux-rdma+bounces-18987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MECmDCTi0Wm8PwcAu9opvQ
	(envelope-from <linux-rdma+bounces-18987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A408A39D49D
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3F4C3011C4D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 04:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9826296BCB;
	Sun,  5 Apr 2026 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KenLtEac"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2D282F21;
	Sun,  5 Apr 2026 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775362575; cv=none; b=sCJU1MXPA2XngJdFEvoGILGqhxtFCTOzrps/dXwsy9tEh9KklsKFjgaSZnnabLQc1zL8Lc+CFdRrsdA1t+Fm8QKh0cyL8sy8wAM01ia2tZNo2ChEKaCAqd/KC3KkNztLjJJcr+dL96KZ1Q5jLBVHApb4UYrxvt5fKhJcsqu72TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775362575; c=relaxed/simple;
	bh=/LuoovS+Ui0x5GXChKcy01Q9YbGN98c6sROAojj6TVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJmL04d+fACgglHh+ovMjdm+1tilApn/GmZi+dkaUgi9e8qBjj5ZokGiiVeGcJmjUXb5P5W9wTDsRDDwpFz13/TysdxQ2Au+cOYEcNcsdWmbdHSmMiLi+HaRFOu60cZm7zKxxwlX/Q4hZJQtuQ7aX4pdYr94AQVwtMvc4CuNAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KenLtEac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B8C2BCB1;
	Sun,  5 Apr 2026 04:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775362575;
	bh=/LuoovS+Ui0x5GXChKcy01Q9YbGN98c6sROAojj6TVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KenLtEac5D8B+kmxY3Ysr6OegLSl5dbgmREtSPyKeObzBH/garIKx0fVsFSpbU2ZE
	 2BIorMBplNdah62dAmnq653IGKjujCyIuEjrsq29uItJSAzA6Z/UVeES2p6oSJIMEJ
	 zcMmEsZXcE896FYBZdfFvRC69kvecxt47oF6VKL7jZ8mUZuL6pQpzpJYFITbCK/6/a
	 oMn7LU0WvSEiBueLA/33SbgCraYQ+lBScOZxJSw3K9BdAFZ1Gcr7B/5Ajnd2V6nbQs
	 MAI6UG0hwL9aac1C0mk9XAECSEJSIZhZHNMz77xozcmKX0ZyrqB2ouy+muyVNsPGkd
	 Fz7TKMIh7rWjg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v1 1/2] net/rds: Optimize rds_ib_laddr_check
Date: Sat,  4 Apr 2026 21:16:12 -0700
Message-ID: <20260405041613.309958-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405041613.309958-1-achender@kernel.org>
References: <20260405041613.309958-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18987-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A408A39D49D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Håkon Bugge <haakon.bugge@oracle.com>

rds_ib_laddr_check() creates a CM_ID and attempts to bind the address
in question to it. This in order to qualify the allegedly local
address as a usable IB/RoCE address.

In the field, ExaWatcher runs rds-ping to all ports in the fabric from
all local ports. This using all active ToS'es. In a full rack system,
we have 14 cell servers and eight db servers. Typically, 6 ToS'es are
used. This implies 528 rds-ping invocations per ExaWatcher's "RDSinfo"
interval.

Adding to this, each rds-ping invocation creates eight sockets and
binds the local address to them:

socket(AF_RDS, SOCK_SEQPACKET, 0)       = 3
bind(3, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 4
bind(4, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 5
bind(5, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 6
bind(6, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 7
bind(7, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 8
bind(8, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 9
bind(9, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0
socket(AF_RDS, SOCK_SEQPACKET, 0)       = 10
bind(10, {sa_family=AF_INET, sin_port=htons(0),
	sin_addr=inet_addr("192.168.36.2")}, 16) = 0

So, at every interval ExaWatcher executes rds-ping's, 4224 CM_IDs are
allocated, considering this full-rack system. After the a CM_ID has
been allocated, rdma_bind_addr() is called, with the port number being
zero. This implies that the CMA will attempt to search for an un-used
ephemeral port. Simplified, the algorithm is to start at a random
position in the available port space, and then if needed, iterate
until an un-used port is found.

The book-keeping of used ports uses the idr system, which again uses
slab to allocate new struct idr_layer's. The size is 2092 bytes and
slab tries to reduce the wasted space. Hence, it chooses an order:3
allocation, for which 15 idr_layer structs will fit and only 1388
bytes are wasted per the 32KiB order:3 chunk.

Although this order:3 allocation seems like a good space/speed
trade-off, it does not resonate well with how it used by the CMA. The
combination of the randomized starting point in the port space (which
has close to zero spatial locality) and the close proximity in time of
the 4224 invocations of the rds-ping's, creates a memory hog for
order:3 allocations.

These costly allocations may need reclaims and/or compaction. At
worst, they may fail and produce a stack trace such as (from uek4):

[<ffffffff811a72d5>] __inc_zone_page_state+0x35/0x40
[<ffffffff811c2e97>] page_add_file_rmap+0x57/0x60
[<ffffffffa37ca1df>] remove_migration_pte+0x3f/0x3c0 [ksplice_6cn872bt_vmlinux_new]
[<ffffffff811c3de8>] rmap_walk+0xd8/0x340
[<ffffffff811e8860>] remove_migration_ptes+0x40/0x50
[<ffffffff811ea83c>] migrate_pages+0x3ec/0x890
[<ffffffff811afa0d>] compact_zone+0x32d/0x9a0
[<ffffffff811b00ed>] compact_zone_order+0x6d/0x90
[<ffffffff811b03b2>] try_to_compact_pages+0x102/0x270
[<ffffffff81190e56>] __alloc_pages_direct_compact+0x46/0x100
[<ffffffff8119165b>] __alloc_pages_nodemask+0x74b/0xaa0
[<ffffffff811d8411>] alloc_pages_current+0x91/0x110
[<ffffffff811e3b0b>] new_slab+0x38b/0x480
[<ffffffffa41323c7>] __slab_alloc+0x3b7/0x4a0 [ksplice_s0dk66a8_vmlinux_new]
[<ffffffff811e42ab>] kmem_cache_alloc+0x1fb/0x250
[<ffffffff8131fdd6>] idr_layer_alloc+0x36/0x90
[<ffffffff8132029c>] idr_get_empty_slot+0x28c/0x3d0
[<ffffffff813204ad>] idr_alloc+0x4d/0xf0
[<ffffffffa051727d>] cma_alloc_port+0x4d/0xa0 [rdma_cm]
[<ffffffffa0517cbe>] rdma_bind_addr+0x2ae/0x5b0 [rdma_cm]
[<ffffffffa09d8083>] rds_ib_laddr_check+0x83/0x2c0 [ksplice_6l2xst5i_rds_rdma_new]
[<ffffffffa05f892b>] rds_trans_get_preferred+0x5b/0xa0 [rds]
[<ffffffffa05f09f2>] rds_bind+0x212/0x280 [rds]
[<ffffffff815b4016>] SYSC_bind+0xe6/0x120
[<ffffffff815b4d3e>] SyS_bind+0xe/0x10
[<ffffffff816b031a>] system_call_fastpath+0x18/0xd4

To avoid these excessive calls to rdma_bind_addr(), we optimize
rds_ib_laddr_check() by simply checking if the address in question has
been used before. The rds_rdma module keeps track of addresses
associated with IB devices, and the function rds_ib_get_device() is
used to determine if the address already has been qualified as a valid
local address. If not found, we call the legacy rds_ib_laddr_check(),
now renamed to rds_ib_laddr_check_cm().

Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/ib.c      | 18 ++++++++++++++++--
 net/rds/ib.h      |  1 +
 net/rds/ib_rdma.c |  2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index ac6affa33ce7..73e01984ee9a 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -401,8 +401,8 @@ static void rds6_ib_ic_info(struct socket *sock, unsigned int len,
  * allowed to influence which paths have priority.  We could call userspace
  * asserting this policy "routing".
  */
-static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
-			      __u32 scope_id)
+static int rds_ib_laddr_check_cm(struct net *net, const struct in6_addr *addr,
+				 __u32 scope_id)
 {
 	int ret;
 	struct rdma_cm_id *cm_id;
@@ -487,6 +487,20 @@ static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
 	return ret;
 }
 
+static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
+			      __u32 scope_id)
+{
+	struct rds_ib_device *rds_ibdev = rds_ib_get_device(addr->s6_addr32[3]);
+
+	if (rds_ibdev) {
+		rds_ib_dev_put(rds_ibdev);
+
+		return 0;
+	}
+
+	return rds_ib_laddr_check_cm(net, addr, scope_id);
+}
+
 static void rds_ib_unregister_client(void)
 {
 	ib_unregister_client(&rds_ib_client);
diff --git a/net/rds/ib.h b/net/rds/ib.h
index 8ef3178ed4d6..5ff346a1e8ba 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -381,6 +381,7 @@ void rds_ib_cm_connect_complete(struct rds_connection *conn,
 	__rds_ib_conn_error(conn, KERN_WARNING "RDS/IB: " fmt)
 
 /* ib_rdma.c */
+struct rds_ib_device *rds_ib_get_device(__be32 ipaddr);
 int rds_ib_update_ipaddr(struct rds_ib_device *rds_ibdev,
 			 struct in6_addr *ipaddr);
 void rds_ib_add_conn(struct rds_ib_device *rds_ibdev, struct rds_connection *conn);
diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 2cfec252eeac..9594ea245f7f 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -43,7 +43,7 @@ struct workqueue_struct *rds_ib_mr_wq;
 
 static void rds_ib_odp_mr_worker(struct work_struct *work);
 
-static struct rds_ib_device *rds_ib_get_device(__be32 ipaddr)
+struct rds_ib_device *rds_ib_get_device(__be32 ipaddr)
 {
 	struct rds_ib_device *rds_ibdev;
 	struct rds_ib_ipaddr *i_ipaddr;
-- 
2.43.0



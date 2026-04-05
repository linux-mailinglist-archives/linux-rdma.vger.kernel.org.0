Return-Path: <linux-rdma+bounces-18995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jgZVJoeD0mlLYgcAu9opvQ
	(envelope-from <linux-rdma+bounces-18995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 17:45:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E325139EDE5
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D5B3008235
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5430CD92;
	Sun,  5 Apr 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdFDT8zw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3C30C35C;
	Sun,  5 Apr 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775403904; cv=none; b=uJiPqhCo4HumPoqlvky21gcEOtRyJvq7GpmFjNBtD0Uk4q2iyJ26a/lA8GZXUd+6PGTFWxFXs/jc6xE2DMEPRAlBKWmwlKgjhLUj2tL2Si1Yy7iMz0Gw0zCIj1sidM/5AfXbDNJKFKnGKfM5g9TmbfHO/rALeLLjqPuRKfr+wsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775403904; c=relaxed/simple;
	bh=VEc5kchUdrjTQupcPPjRdL0NSXEa1++/a4O9isGQMPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mm3KxgL31xRboBvY6LSe6a8XOIgfXq4sa301jO1OhhzHEBFg8OzNyhz8oI9MpZYq6lES2VTEMVP21dCYsROkndeimkhwS1qBaNLEs7XjZ5JwJUhg7Eb+2QZFsaVcN9pc6PohwKwuglqxDtfZ6QWrmVrnbUzZbPpIc+OHR0Nh4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdFDT8zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EB1C116C6;
	Sun,  5 Apr 2026 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775403903;
	bh=VEc5kchUdrjTQupcPPjRdL0NSXEa1++/a4O9isGQMPo=;
	h=From:To:Cc:Subject:Date:From;
	b=JdFDT8zw42NtibtZGOLln0+GoCTPGRkW+l73EVX8ezjW2g5jYwArKUuUtYTB/oGP0
	 e3wWddNO9vAe5ai5AOiO05WK6vff06/glGFM4ABjGruWIDHvLeqQuL/rj8SqjlpDUK
	 KJ9oJzWXhodaGwAIYOWNJIzwTUkH2dK+yGQuRR+ZYl+Waw808MknVdHBfTW0gP0OjC
	 /AeS0v4Dxbv8ISTkKAcbk5o4vLHTi1GCP6LST7ygMm7k2mW2rOwIaZs6jI3taDTd2h
	 vKYZbal1Jc8MWsJZgBuQ3vJ0kHZDKBxuyUJk0yz096PSyUdPsUoNTpu34rTa1IdF5x
	 TL3Fv+5PObYCQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Zhao <chezhao@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next] IB/core: Fix zero dmac race in neighbor resolution
Date: Sun,  5 Apr 2026 18:44:55 +0300
Message-ID: <20260405-fix-dmac-race-v1-1-cfa1ec2ce54a@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260405-fix-dmac-race-1c57aa966d4d
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18995-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: E325139EDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Zhao <chezhao@nvidia.com>=0D
=0D
dst_fetch_ha() checks nud_state without holding the neighbor lock, then=0D
copies ha under the seqlock. A race in __neigh_update() where nud_state=0D
is set to NUD_REACHABLE before ha is written allows dst_fetch_ha() to=0D
read a zero MAC address while the seqlock reports no concurrent writer.=0D
=0D
netevent_callback amplifies this by waking ALL pending addr_req workers=0D
when ANY neighbor becomes NUD_VALID. At scale (N peers resolving ARP=0D
concurrently), the hit probability scales as N^2, making it near-certain=0D
for large RDMA workloads.=0D
=0D
N(A): neigh_update(A)                   W(A): addr_resolve(A)=0D
 |                                       [sleep]=0D
 | write_lock_bh(&A->lock)               |=0D
 | A->nud_state =3D NUD_REACHABLE          |=0D
 | // A->ha is still 0                   |=0D
 |                                       [woken by netevent_cb() of=0D
 |                                         another neighbour]=0D
 |                                       | dst_fetch_ha(A)=0D
 |                                       |   A->nud_state & NUD_VALID=0D
 |                                       |   read_seqbegin(&A->ha_lock)=0D
 |                                       |   snapshot =3D A->ha  /* 0 */=0D
 |                                       |   read_seqretry(&A->ha_lock)=0D
 |                                       |   return snapshot=0D
 | seqlock(&A->ha_lock)=0D
 | A->ha =3D mac_A     /* too late */=0D
 | sequnlock(&A->ha_lock)=0D
 | write_unlock_bh(&A->lock)=0D
=0D
The incorrect/zero mac is read and programmed in the device QP while it=0D
was not yet updated. This causes silent packet loss and eventual=0D
RETRY_EXC_ERR.=0D
=0D
Fix by holding the neighbor read lock across the nud_state check and=0D
ha copy in dst_fetch_ha(), ensuring it synchronizes with=0D
__neigh_update() which is updating while holding the write lock.=0D
=0D
Fixes: 92ebb6a0a13a ("IB/cm: Remove now useless rcu_lock in dst_fetch_ha")=
=0D
Signed-off-by: Chen Zhao <chezhao@nvidia.com>=0D
Reviewed-by: Parav Pandit <parav@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
Strictly speaking the commit in Fixes doesn't look like the one which=0D
caused the race, but it is most relevant one to put.=0D
---=0D
 drivers/infiniband/core/addr.c | 3 +++=0D
 1 file changed, 3 insertions(+)=0D
=0D
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.=
c=0D
index 866746695712a..6526fda8f9c0b 100644=0D
--- a/drivers/infiniband/core/addr.c=0D
+++ b/drivers/infiniband/core/addr.c=0D
@@ -321,11 +321,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,=
=0D
 	if (!n)=0D
 		return -ENODATA;=0D
 =0D
+	read_lock_bh(&n->lock);=0D
 	if (!(n->nud_state & NUD_VALID)) {=0D
+		read_unlock_bh(&n->lock);=0D
 		neigh_event_send(n, NULL);=0D
 		ret =3D -ENODATA;=0D
 	} else {=0D
 		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);=0D
+		read_unlock_bh(&n->lock);=0D
 	}=0D
 =0D
 	neigh_release(n);=0D
=0D
---=0D
base-commit: 69db255d5fafb5651013c79e54c1d535fc5015fb=0D
change-id: 20260405-fix-dmac-race-1c57aa966d4d=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D


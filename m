Return-Path: <linux-rdma+bounces-22479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vC8DN7Z2PWq73QgAu9opvQ
	(envelope-from <linux-rdma+bounces-22479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 20:43:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB756C844C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 20:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=email-od.com header.s=dkim header.b=HyqyinyZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22479-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22479-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781DC3046C4E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333B31F983;
	Thu, 25 Jun 2026 18:42:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5C1A0B0E
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2026 18:42:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412979; cv=none; b=NQOiP+UDF/DmUD22P75TOpgfzn4aPgFXnpS7WJUqu5JOiSSIGfZfc3vLxJEkip80ZVCdxNvvh0lFKIRLsB0ueqrTa8DheY8k3KWD8apiQb38VXRCMibVUwWZE7n+r6su4vKTSUBB2GgVVDYByw6dfMolnTsXxaGIEuSdRVIpIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412979; c=relaxed/simple;
	bh=GT8u7mWM6cT3S3Y9PxcMxX/0ui/zRmL3vJl3WUePj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlBlXrPRNvsA2MEdL1EDOcQBeULX+c8u//UFbpyaLn36fgsnV7zI1phSsq9+toKhpdEbxk+i+Rp3P7PRN5CdawGOCcq8Uz1Sfh4PZSmVE0t1XkOEgqbOIxKQ9Y4du0UKGbkECswVl3zmv1WbJ0hPkgqLmHurVmmkbLVXxDYZJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=HyqyinyZ; arc=none smtp.client-ip=142.0.186.134
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1782412978; x=1785004978;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=3C5qRbHhtN/26vwfZpMmakIFWHIGq8A0GwYGf+u29XU=;
	b=HyqyinyZMfnQ9atT0V8esk5D3Oq3XW5/nAGHRQn2gb242XaX0feUpGkW2Xm52HFYuqAtZJChk/IBXn2HXF7AYQZLIqD2yqlMptzWgYzwb0nPBPiZVruV0xMkwD3pzvmZNX75mU2UXZjItMfWO3JuAcFMH/sE06+RDWD/kni7bxg=
X-Thread-Info: NDUwNC4xMi4zNWM4MzAwMDFmNjYwMGMubGludXgtcmRtYT12Z2VyLmtlcm5lbC5vcmc=
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id BBD1E2CE01A2;
	Thu, 25 Jun 2026 13:42:31 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	dtatulea@nvidia.com
Cc: dev@nalramli.com,
	nalramli@fastly.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning on frag page release
Date: Thu, 25 Jun 2026 13:40:59 -0400
Message-ID: <20260625174059.2879717-2-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625174059.2879717-1-dev@nalramli.com>
References: <20260625174059.2879717-1-dev@nalramli.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[email-od.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22479-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nalramli.com: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:dtatulea@nvidia.com,m:dev@nalramli.com,m:nalramli@fastly.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[email-od.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,email-od.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EB756C844C

Under memory pressure, mlx5 driver has WARNING during fragmented page
release. This happens because there is a discrepency between what mlx5
thinks the page fragment counter is vs what the page_pool actually says i=
t
is.

The cause of the issue is page allocations on concurrent cpus, which
increment the non-atomic u16 page counter mlx5e_frag_page.frags, while at
the same time the page reference counter net_iov.pp_ref_count is atomical=
ly
incremented. That sometimes leads to a difference in the counts and
therefore triggers the warning in page_pool_unref_netmem:

```
	ret =3D atomic_long_sub_return(nr, pp_ref_count);
	WARN_ON(ret < 0);
```

The actual stack trace looks like this:

```
WARNING: CPU: 37 PID: 447795 at include/net/page_pool/helpers.h:277 mlx5e=
_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
Tainted: [S]=3DCPU_OUT_OF_SPEC, [O]=3DOOT_MODULE
Hardware name: *
RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
RSP: 0018:ffffc90019814d98 EFLAGS: 00010293
RAX: 000000000000003f RBX: ffff88c0993d0a10 RCX: ffffea02424592c0
RDX: 0000000000000001 RSI: ffffea02424592c0 RDI: ffff88c090e20000
RBP: 000000000000000a R08: 0000000000001409 R09: 0000000000000006
R10: 0000000000000000 R11: ffff88c095fbc040 R12: 000000000000141f
R13: 0000000000000009 R14: ffff88c090e20000 R15: 0000000000000001
FS:  00007f34149fa6c0(0000) GS:ffff89200fa40000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ed0265eb000 CR3: 0000005091cbe000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 mlx5e_free_rx_wqes+0x7b/0xa0 [mlx5_core]
 mlx5e_post_rx_wqes+0x1ac/0x5a0 [mlx5_core]
 mlx5e_napi_poll+0x5e5/0x6f0 [mlx5_core]
 __napi_poll+0x2b/0x1a0
 net_rx_action+0x30e/0x370
 ? sched_clock+0x9/0x10
 ? sched_clock_cpu+0xf/0x170
 handle_softirqs+0xe2/0x2a0
 common_interrupt+0x85/0xa0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40
RIP: 0010:page_counter_uncharge+0x34/0x90
RSP: 0018:ffffc900e728bb00 EFLAGS: 00000213
RAX: ffff88aff4762000 RBX: ffff88aff4762100 RCX: 0000000000000304
RDX: 0000000000000001 RSI: 00000000004e9e1a RDI: ffff88aff4762100
RBP: 0000000000000001 R08: ffff891ea0560048 R09: 00007ffffffff000
R10: 0000000000001000 R11: ffff891ae8061b00 R12: ffffffffffffffff
R13: ffff89107fcfd4c0 R14: ffff891ae8061b00 R15: ffff892002fe1400
 uncharge_batch+0x40/0xd0
```

The fix is to use an atomic page fragment counter, so it will always matc=
h
the number of references held in the page_pool.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through th=
e page_pool")
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 39 ++++++++++---------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
index 2270e2e550dd..c164106eb85d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -568,7 +568,7 @@ struct mlx5e_icosq {
=20
 struct mlx5e_frag_page {
 	netmem_ref netmem;
-	u16 frags;
+	atomic_long_t frags;
 };
=20
 enum mlx5e_wqe_frag_flag {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..571a0df9f604 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -400,7 +400,7 @@ static int mlx5e_rq_alloc_mpwqe_linear_info(struct ml=
x5e_rq *rq, int node,
 	rq->mpwqe.linear_info =3D li;
=20
 	/* Set to max to force allocation on first run. */
-	li->frag_page.frags =3D li->max_frags;
+	atomic_long_set(&li->frag_page.frags, li->max_frags);
=20
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
index 5b60aa47c75b..ee360fa0c316 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -284,7 +284,7 @@ static int mlx5e_page_alloc_fragmented(struct page_po=
ol *pp,
=20
 	*frag_page =3D (struct mlx5e_frag_page) {
 		.netmem	=3D netmem,
-		.frags	=3D 0,
+		.frags	=3D ATOMIC_LONG_INIT(0),
 	};
=20
 	return 0;
@@ -293,7 +293,7 @@ static int mlx5e_page_alloc_fragmented(struct page_po=
ol *pp,
 static void mlx5e_page_release_fragmented(struct page_pool *pp,
 					  struct mlx5e_frag_page *frag_page)
 {
-	u16 drain_count =3D MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
+	u16 drain_count =3D MLX5E_PAGECNT_BIAS_MAX - atomic_long_read(&frag_pag=
e->frags);
 	netmem_ref netmem =3D frag_page->netmem;
=20
 	if (page_pool_unref_netmem(netmem, drain_count) =3D=3D 0)
@@ -304,7 +304,7 @@ static int mlx5e_mpwqe_linear_page_refill(struct mlx5=
e_rq *rq)
 {
 	struct mlx5e_mpw_linear_info *li =3D rq->mpwqe.linear_info;
=20
-	if (likely(li->frag_page.frags < li->max_frags))
+	if (likely(atomic_long_read(&li->frag_page.frags) < li->max_frags))
 		return 0;
=20
 	if (likely(li->frag_page.netmem)) {
@@ -323,7 +323,8 @@ static void *mlx5e_mpwqe_get_linear_page_frag(struct =
mlx5e_rq *rq)
 	if (unlikely(mlx5e_mpwqe_linear_page_refill(rq)))
 		return NULL;
=20
-	frag_offset =3D li->frag_page.frags << MLX5E_XDP_LOG_MAX_LINEAR_SZ;
+	frag_offset =3D atomic_long_read(&li->frag_page.frags) <<
+		      MLX5E_XDP_LOG_MAX_LINEAR_SZ;
 	WARN_ON(frag_offset >=3D BIT(rq->mpwqe.page_shift));
=20
 	return netmem_address(li->frag_page.netmem) + frag_offset;
@@ -568,7 +569,7 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buf=
f *skb,
 		return;
 	}
=20
-	frag_page->frags++;
+	atomic_long_inc(&frag_page->frags);
 	skb_add_rx_frag_netmem(skb, next_frag, netmem,
 			       frag_offset, len, truesize);
 }
@@ -744,7 +745,7 @@ void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq =
*rq)
 	 * things in a good state for re-allocation.
 	 */
 	li->frag_page.netmem =3D 0;
-	li->frag_page.frags =3D li->max_frags;
+	atomic_long_set(&li->frag_page.frags, li->max_frags);
 }
=20
 INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq)
@@ -1615,7 +1616,7 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, stru=
ct mlx5e_wqe_frag_info *wi,
=20
 	/* queue up for recycling/reuse */
 	skb_mark_for_recycle(skb);
-	frag_page->frags++;
+	atomic_long_inc(&frag_page->frags);
=20
 	return skb;
 }
@@ -1683,7 +1684,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
 				struct mlx5e_wqe_frag_info *pwi;
=20
 				for (pwi =3D head_wi; pwi < wi; pwi++)
-					pwi->frag_page->frags++;
+					atomic_long_inc(&pwi->frag_page->frags);
 			}
 			return NULL; /* page/packet was consumed by XDP */
 		}
@@ -1702,7 +1703,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
 		return NULL;
=20
 	skb_mark_for_recycle(skb);
-	head_wi->frag_page->frags++;
+	atomic_long_inc(&head_wi->frag_page->frags);
=20
 	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
@@ -1711,7 +1712,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
 					  xdp_buff_get_skb_flags(&mxbuf->xdp));
=20
 		for (struct mlx5e_wqe_frag_info *pwi =3D head_wi + 1; pwi < wi; pwi++)
-			pwi->frag_page->frags++;
+			atomic_long_inc(&pwi->frag_page->frags);
 	}
=20
 	return skb;
@@ -1760,7 +1761,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq=
, struct mlx5_cqe64 *cqe)
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
-			wi->frag_page->frags++;
+			atomic_long_inc(&wi->frag_page->frags);
 		goto wq_cyc_pop;
 	}
=20
@@ -1808,7 +1809,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq=
 *rq, struct mlx5_cqe64 *cqe)
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
-			wi->frag_page->frags++;
+			atomic_long_inc(&wi->frag_page->frags);
 		goto wq_cyc_pop;
 	}
=20
@@ -2011,9 +2012,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
 				struct mlx5e_frag_page *pfp;
=20
 				for (pfp =3D head_page; pfp < frag_page; pfp++)
-					pfp->frags++;
+					atomic_long_inc(&pfp->frags);
=20
-				linear_page->frags++;
+				atomic_long_inc(&linear_page->frags);
 			}
 			return NULL; /* page/packet was consumed by XDP */
 		}
@@ -2035,7 +2036,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
 			return NULL;
=20
 		skb_mark_for_recycle(skb);
-		linear_page->frags++;
+		atomic_long_inc(&linear_page->frags);
=20
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
@@ -2048,7 +2049,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
=20
 			pagep =3D head_page;
 			do
-				pagep->frags++;
+				atomic_long_inc(&pagep->frags);
 			while (++pagep < frag_page);
=20
 			headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len,
@@ -2068,7 +2069,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
=20
 			pagep =3D frag_page - sinfo->nr_frags;
 			do
-				pagep->frags++;
+				atomic_long_inc(&pagep->frags);
 			while (++pagep < frag_page);
 		}
 		/* copy header */
@@ -2121,7 +2122,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq=
, struct mlx5e_mpw_info *wi,
 				 cqe_bcnt, mxbuf);
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
-				frag_page->frags++;
+				atomic_long_inc(&frag_page->frags);
 			return NULL; /* page/packet was consumed by XDP */
 		}
=20
@@ -2136,7 +2137,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq=
, struct mlx5e_mpw_info *wi,
=20
 	/* queue up for recycling/reuse */
 	skb_mark_for_recycle(skb);
-	frag_page->frags++;
+	atomic_long_inc(&frag_page->frags);
=20
 	return skb;
 }
--=20
2.43.0



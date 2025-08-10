Return-Path: <linux-rdma+bounces-12644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A87B1FB48
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B618977D6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E4264F8A;
	Sun, 10 Aug 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f43L8oBP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2F18E3F;
	Sun, 10 Aug 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754845952; cv=none; b=ALejgfxZ7nXQQwzXZh1ggD6UxV1DvBYTVQ42g3bLNuKdbZAWGusGQp5uUA1pS/fpjKZJi+gu9wds1VeIDEQnAVRYz7wXU/1hXI6I+GZiAtDS9gc3OOevV9fx5gP1llzhhQCtgvxnkiqlKFtW7PQJWbfdoUc+kD/o1qKN9OJFFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754845952; c=relaxed/simple;
	bh=PRGBdT4jWcQlVi5EPPpXu+7v93SwH1cs8cr9c2YjINQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJWVyavdVlOcPFmhsARn9PZo27nHNjQUdI8IUuxUWfBR8hGYxrF/vASQIq9Cw/WX5B0ogK/KRBRSdoEEdLK2Q6oy0LrIHClaH5+Fb/u7G9F7Jnf+UNa9FxPfFITIssBtV4AQAa95TxWTj/LO+idPhMKljIfJZhjhrKrINAvPxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f43L8oBP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3037654b3a.0;
        Sun, 10 Aug 2025 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754845950; x=1755450750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVQKkzyLHIEEOA054+V4MR2LVWxngvci08Npm8h9M7U=;
        b=f43L8oBPR7DeU5ROPB5Zw5MgAlCcc7ETBES3ufVapmgVkNpGwokslGOxjpOWbXG80Y
         Zj668S5lyxcQ9uuErQKT4yuroc5IO4VwdvI/RPPkJ1tL1x1KZIKrA6MyPVx6J/pjk7QR
         p54qvkqX6YpkKdywi29p+lwZgu2dvafCyrcLbhg3kITtB4T4xia6Nt20ml6WSES9E4GQ
         GStduuzJ7MifuKYY19OIELDZCGANeuGKgP+GnAOsnkTN4mDBGbD+Lhqq0SzA+b2+GcY2
         AC1DBuUXv6anYElzypXNyDenjDJC59IZv6CXiOZnA0DjoKJf/Vwqimoc4AVDsTx1h1N4
         QBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754845950; x=1755450750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVQKkzyLHIEEOA054+V4MR2LVWxngvci08Npm8h9M7U=;
        b=V/BZC8Ry2nofifbPfjhQv2bGFCbROrXy5rru6p3fQ0r1TYpUmwmQwhpcHCRG+utEWf
         bW7lHmMLPqWVxZJHdj5xFJSUn8KlhQo+pnpouLyD4y7DNG9DxjqlRJLrGxTDpPWZKABD
         /evB0beyLm2zWZOAUi6exu0Hrx3W+/DdnfD9BwB4ox86oKq9c1GULOAAKzMO+NaOEwyO
         DKZU2mVN/OW+6zPYUQdJjHtf/qLRO+XPZzJVTK/DKV8RkvTHsZgvDDVhr18CTCFEjrmr
         HnxAYvMgPcBAX4oC096xb3serDuNY0QpKfejlOOgyVbdM/AJ5Wd1JIVJ06EcCBJhmDZF
         2Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCUCiGpUjnCAIMmCiPJrjgPxKNBvRs2ICoo7EYGGg+Dto5JXQuL8s2ba9p+kip/9jIy+JIKbOv9Ok6AsWw==@vger.kernel.org, AJvYcCUOa0fNj47d7SJRz/zyXvAtysglgfKpVTObRxd1mBF/xfN5LVErT5OZuq8mmQ4c3TIMrkd8FKdx43MEH84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e9hj3FWNlwdYwzOT2a0RoPGW9pqL+bTlUTQ+K4UVN60HgwM1
	H0hkeZYi7mz/N+A4d7fsOFbO3Zvx54MNk0Sr5a2dYwnYoFuQn8sqqQs=
X-Gm-Gg: ASbGnctBWVsNeFg0KH8llwe/y5G7umrNwSCdj5W8NR4a2DC+R8akwEroFXh7VkX/NF2
	jDL/amA8yYaBWEoJz20TonlbcT+I5KzTlOQD5gt6MXW+RIiAtqqR0riH6iLwImWQC+kvuLBbXlj
	MTk/N3YZmlZr0MD+uWgL/YH5dvABFpuBZ/hUdSlvF36EIzEkKIJ8kUPx7VG/mGqwibarHwM1WcY
	zoPvi2/NBwhPfQLq3gDcgVs3HTYM5eevIv4WlBG0yIlfyx1kMQZnfmZz8U/U1SAQus6Ss6S2LgV
	9d6nEkgQdM+FfZ4y2mpWo7pU3f0VWCRWN7R8x0i0ZW9JzyBoFJo5TVxZ2HyClFLig2wyYR8GDI6
	ffbZcZdCVIoSsuG+aZPL6UatE92kVLbuzrg==
X-Google-Smtp-Source: AGHT+IF2SRKwdEygnfkLnOP8KuM8AMkiDcdk8rJPJHdwWw9CSEuqf6Z3Cu6/fqFWFEmaMyp0r/EXFw==
X-Received: by 2002:a17:902:c94a:b0:240:3913:7c84 with SMTP id d9443c01a7336-242c1ecc793mr138445745ad.4.1754845950157;
        Sun, 10 Aug 2025 10:12:30 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.129.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef674bsm252344335ad.17.2025.08.10.10.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 10:12:29 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH net] rds: Fix endian annotations across various assignments
Date: Sun, 10 Aug 2025 22:41:55 +0530
Message-Id: <20250810171155.3263-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse reports the following warnings:

net/rds/af_rds.c:245:22: warning: invalid assignment: |=
net/rds/af_rds.c:245:22: left side has type restricted __poll_t
net/rds/af_rds.c:245:22: right side has type int

__poll_t is typedef'ed to __bitwise while POLLERR is defined as 0x0008,
force conversion.

net/rds/recv.c:218:42: warning: cast to restricted __be16
net/rds/recv.c:222:44: warning: cast to restricted __be32

Replace be{16,32}_to_cpu with explicit __force to force conversion. The
value remains the same either way so not a bug.

net/rds/send.c:1050:24: warning: incorrect type in argument 1 (different base types)
net/rds/send.c:1050:24: expected unsigned int [usertype] a
net/rds/send.c:1050:24: got restricted __be16 [usertype] sin6_port
net/rds/send.c:1052:24: warning: incorrect type in argument 1 (different base types)
net/rds/send.c:1052:24: expected unsigned int [usertype] a
net/rds/send.c:1052:24: got restricted __be16 [usertype] sin6_port
net/rds/send.c:1457:30: warning: incorrect type in initializer (different base types)
net/rds/send.c:1457:30: expected unsigned short [usertype] npaths
net/rds/send.c:1457:30: got restricted __be16 [usertype]
net/rds/send.c:1458:34: warning: incorrect type in initializer (different base types)
net/rds/send.c:1458:34: expected unsigned int [usertype] my_gen_num
net/rds/send.c:1458:34: got restricted __be32 [usertype]

Use correct endianness. Replace cpu_to_be{16,32} for the same reason as
above.

net/rds/connection.c:71:31: warning: incorrect type in argument 1 (different base types)
net/rds/connection.c:71:31: expected restricted __be32 const [usertype] laddr
net/rds/connection.c:71:31: got unsigned int [assigned] [usertype] lhash
net/rds/connection.c:71:41: warning: incorrect type in argument 3 (different base types)
net/rds/connection.c:71:41: expected restricted __be32 const [usertype] faddr
net/rds/connection.c:71:41: got unsigned int [assigned] [usertype] fhash

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 net/rds/af_rds.c     | 2 +-
 net/rds/connection.c | 6 +++---
 net/rds/rdma.c       | 1 -
 net/rds/rds.h        | 2 +-
 net/rds/recv.c       | 4 ++--
 net/rds/send.c       | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 086a13170e09..9cd5905d916a 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -242,7 +242,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 	if (rs->rs_snd_bytes < rds_sk_sndbuf(rs))
 		mask |= (EPOLLOUT | EPOLLWRNORM);
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
-		mask |= POLLERR;
+		mask |= (__force __poll_t)POLLERR;
 	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
 	/* clear state any time we wake a seen-congested socket */
diff --git a/net/rds/connection.c b/net/rds/connection.c
index d62f486ab29f..0047b76c3c0b 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -62,13 +62,13 @@ static struct hlist_head *rds_conn_bucket(const struct in6_addr *laddr,
 	net_get_random_once(&rds_hash_secret, sizeof(rds_hash_secret));
 	net_get_random_once(&rds6_hash_secret, sizeof(rds6_hash_secret));
 
-	lhash = (__force u32)laddr->s6_addr32[3];
+	lhash = (__force __u32)laddr->s6_addr32[3];
 #if IS_ENABLED(CONFIG_IPV6)
 	fhash = __ipv6_addr_jhash(faddr, rds6_hash_secret);
 #else
-	fhash = (__force u32)faddr->s6_addr32[3];
+	fhash = (__force __u32)(faddr->s6_addr32[3]);
 #endif
-	hash = __inet_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
+	hash = __inet_ehashfn((__force __be32)lhash, 0, (__force __be32)fhash, 0, rds_hash_secret);
 
 	return &rds_conn_hash[hash & RDS_CONNECTION_HASH_MASK];
 }
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 00dbcd4d28e6..f9bcec8f745a 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -39,7 +39,6 @@
 
 /*
  * XXX
- *  - build with sparse
  *  - should we detect duplicate keys on a socket?  hmm.
  *  - an rdma is an mlock, apply rlimit?
  */
diff --git a/net/rds/rds.h b/net/rds/rds.h
index dc360252c515..c2fb47e1fe07 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -93,7 +93,7 @@ enum {
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
-#define	RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
+#define	RDS_MPATH_HASH(rs, n) (jhash_1word((__force __u16)(rs)->rs_bound_port, \
 			       (rs)->rs_hash_initval) & ((n) - 1))
 
 #define IS_CANONICAL(laddr, faddr) (htonl(laddr) < htonl(faddr))
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5627f80013f8..7fc7a3850a7b 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -216,10 +216,10 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
 			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
-					       be16_to_cpu(buffer.rds_npaths));
+					      (__force __u16)buffer.rds_npaths);
 			break;
 		case RDS_EXTHDR_GEN_NUM:
-			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
+			new_peer_gen_num = (__force __u32)buffer.rds_gen_num;
 			break;
 		default:
 			pr_warn_ratelimited("ignoring unknown exthdr type "
diff --git a/net/rds/send.c b/net/rds/send.c
index 42d991bc8543..0d79455c9721 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1454,8 +1454,8 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 
 	if (RDS_HS_PROBE(be16_to_cpu(sport), be16_to_cpu(dport)) &&
 	    cp->cp_conn->c_trans->t_mp_capable) {
-		u16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
-		u32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		u16 npaths = (__force __u16)RDS_MPATH_WORKERS;
+		u32 my_gen_num = (__force __u32)cp->cp_conn->c_my_gen_num;
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths,
-- 
2.30.2



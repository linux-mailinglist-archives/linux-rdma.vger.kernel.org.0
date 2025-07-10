Return-Path: <linux-rdma+bounces-12045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199CB00B59
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F78F1CA24AB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CD2F49FE;
	Thu, 10 Jul 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXWpVNoc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02351E8333;
	Thu, 10 Jul 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172075; cv=none; b=JAtQ2bC5qfpXqevV1K9DFM9O0eMsxLOQ0AqZItwGfyQc1xbFlNmRtMEVXS9S56wS3qmFOkhgkcAzM9KtnLM8UH0bOFcCO8gb+BPoAjMB0ZwId/b9RW22zhGYIkbTJeiqdP9Oe8MTU04cc8HgeGieuCQvH6b31duv7qNZ6YnbC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172075; c=relaxed/simple;
	bh=PR+No84tOw4tdZRI+3uKBmwkL10db3H965uEwwfIZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBW0NgAvqF9v4iN3U4vLE1Vw+OVzsXHkiuo9Ok03BMImNDY2PA9AVDCaJWhXidD/f5fyr9o4lysSBC/HYfqPULQsv0dd8BfQCIO+xMZZHDgQLROPSdFz96kYnD8CajnEqlAPojSoeevTav/rG/71lEEx8pb0tvaVotVheN68y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXWpVNoc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso11568775ad.3;
        Thu, 10 Jul 2025 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752172073; x=1752776873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9pkvpcRCYj5jNTlZhLe3kLxA+RKj6mC3gKL5fzlF0k=;
        b=YXWpVNoc/Xg++H2hmBky2N/XQuTZJXD1p9sw97j1HUQzhyTxscmVvnj1oBoL9/TgDt
         soz5o0c4softRqMXSIeiKqZYEU33g2gBZ0enRgRcOh0jRINrPZfLUkOQSlshCtPef8zf
         i8dGLwtMu43W4TO9de4LvznLwHJfkQoxDfctr7FLr1wFWoVS2ZmJxhTA4MJFW8qAHEDt
         zlOuxF36qs7FPV7GyfKnQfYQuemrr4lH4ZWmCV3H4OViq0sZDW/kDjjKRw8l8BDM4Qgm
         Q3Xn8i9eC0o2wokX/AlvnAaeKzKoHiD7Fk1DDthYEufhAOoc2O/h+NAz9qbdsFDSKPcQ
         vLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172073; x=1752776873;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9pkvpcRCYj5jNTlZhLe3kLxA+RKj6mC3gKL5fzlF0k=;
        b=QzSi3BlQa3fba66E0/zT3hjDmqVjYRvHMMkkzcr7GOW87tcTHgnT31aASfkDzGVM2G
         +h8mzSzkOr4HUOZEaZXubJgtmA3O35wfVJa12aGNiemNY9yV7fe1pg3PuvoDDfSJsEPQ
         HlxCnZ5yi3ZPG4E67WhPKebU6k/3jFZpa+q7uid3QiRHicSjRdxRlbhsEKm04zxPD55O
         6DQjw+BS6v1S58CjWFcMeLepoxLmd9IDZqGsZI01u3QyJZKze/+DBUrihRmEESzhIZSN
         kungeGRpkAh8DwaVcPZNnVSS5Ws7lbvfkNHg7ZYxX+avIc/rlwIc0cww73tm/xCtfXfO
         86lw==
X-Forwarded-Encrypted: i=1; AJvYcCU4tpaeAmcA4w1byE2wumb3002yZjQsYRwhzxOx309+DuaxCFgm8qB210NwZzDSpVgq/CiUhxJH@vger.kernel.org, AJvYcCVTwP60ssY61/6ZyjPethrr6a3Oa7zVhoHTYonU5VEbdWQkdmSNIO3VfKp2/QFwC6a8mcMLPzOXB8Vk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+14DziwSrBlDCsHR/LzaMS3tKqxRAFJjeEmIOAkAVsRbfcQr
	8Y6iIvlfcDpDcj/NDLV8zNxXCzpm5wkAjXgFaIKaY3W4nsE6s35YEUa4
X-Gm-Gg: ASbGncvumBn5kpv1zH2gCw/7J9MWPMuJ8OzThz4ydUDMI1uByV+Ygrqmsk4RMlihN7A
	ppnu5v/GUGPpiLzjWLCCeZsOFuD3KTjTXV4yT8bh+afE4pXDyjgG24wnjzXnm0mNCaHXmCAI91H
	upSm+ZjNSt9MqIncg4m5djqE+4WUbd/1RdaIgZHaDNEf0BYAk0Fctt2fUv7FmO1igWFlnIKFXTO
	w1AbO52W5qqxJv5whDoR0UgACfGDRIheL2HD2nxuRdYxMlV+8e3CLTAXNl1DF+3Y1pW6XRorY2h
	Q9iykMOWSzrfTrzZrrCn6+qyDt04ssf8o4VRuXipuQUxb8qvZPKVosgEAuJD2LRFC/8RkVcEM6j
	L7T9BErvIrWqkFFv6
X-Google-Smtp-Source: AGHT+IENzW1vuCfDnuUd9kZhlk0mviqWsYdNsjB1z6dA47W/5D4HaxfGgX6AsrAaScX7aZ9Bsr6sqQ==
X-Received: by 2002:a17:903:1c4:b0:234:b430:cea7 with SMTP id d9443c01a7336-23dee1d855bmr2983065ad.22.1752172072885;
        Thu, 10 Jul 2025 11:27:52 -0700 (PDT)
Received: from localhost.localdomain ([70.134.61.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c30068d50sm5908013a91.15.2025.07.10.11.27.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 11:27:52 -0700 (PDT)
From: christoph.paasch@gmail.com
X-Google-Original-From: cpaasch@openai.com
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Amir Vadai <amirv@mellanox.com>
Cc: Christoph Paasch <cpaasch@openai.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
Date: Thu, 10 Jul 2025 11:26:29 -0700
Message-ID: <20250710182629.78456-2-cpaasch@openai.com>
X-Mailer: git-send-email 2.49.0
Reply-To: cpaasch@openai.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Paasch <cpaasch@openai.com>

gso_size is expected by the networking stack to be the size of the
payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
is the full sized frame (including the headers). Dividing cqe_bcnt by
lro_num_seg will then give incorrect results.

For example, running a bpftrace higher up in the TCP-stack
(tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
though in reality the payload was only 1448 bytes.

So, we need to discount the protocol headers from cqe_bcnt so we can
actually divide the payload by lro_num_seg to get the real gso_size.

Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 84b1ab8233b8..e23bb80b0e0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1154,12 +1154,14 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
 	}
 }
 
-static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
-				 u32 cqe_bcnt)
+static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
+					 struct mlx5_cqe64 *cqe,
+					 u32 cqe_bcnt)
 {
 	struct ethhdr	*eth = (struct ethhdr *)(skb->data);
 	struct tcphdr	*tcp;
 	int network_depth = 0;
+	unsigned int hdrlen;
 	__wsum check;
 	__be16 proto;
 	u16 tot_len;
@@ -1169,11 +1171,14 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 
 	tot_len = cqe_bcnt - network_depth;
 	ip_p = skb->data + network_depth;
+	hdrlen = network_depth;
 
 	if (proto == htons(ETH_P_IP)) {
 		struct iphdr *ipv4 = ip_p;
 
 		tcp = ip_p + sizeof(struct iphdr);
+		hdrlen += sizeof(struct iphdr);
+
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
 
 		ipv4->ttl               = cqe->lro.min_ttl;
@@ -1193,6 +1198,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		struct ipv6hdr *ipv6 = ip_p;
 
 		tcp = ip_p + sizeof(struct ipv6hdr);
+		hdrlen += sizeof(struct ipv6hdr);
+
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
 
 		ipv6->hop_limit         = cqe->lro.min_ttl;
@@ -1205,6 +1212,10 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
 					  &ipv6->daddr, check);
 	}
+
+	hdrlen += tcp->doff * 4;
+
+	return hdrlen;
 }
 
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
@@ -1561,8 +1572,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
 
 	if (lro_num_seg > 1) {
-		mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
-		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt, lro_num_seg);
+		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
+
+		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
 		/* Subtract one since we already counted this as one
 		 * "regular" packet in mlx5e_complete_rx_cqe()
 		 */
-- 
2.49.0



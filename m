Return-Path: <linux-rdma+bounces-997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFC8508E3
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Feb 2024 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38987B22EFB
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Feb 2024 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3D5A79B;
	Sun, 11 Feb 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="M5fpwnBf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A51F16B;
	Sun, 11 Feb 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652763; cv=none; b=GMBXSVerEwoHJKGYGDdEe7PreD6t1ZqWl5xgzlJpGW8C17DdCWWPOP8PU8Ikyy85yvH52zM5o02KTUcMkd3yW6mzmoqs658POrR0CXa1bgu9taTg8pz56DYqB1CcdN8peWBwWf7SJGj9tbvmv6lLPjJnnC2qbqW/YNc+l1MHb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652763; c=relaxed/simple;
	bh=F/PLXTMkyVwJbChPRdvu+2gvdsQ3yhXw4Bv2uHCzTtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gN0mG0RWGZQKM1BZIb1qv1CUPQf1SQyQ+rWo2txAQJ9tQWSRTnkWIIdGQcezLkOqDKeTl6BcWCSn/x00PzG0KLu5CQzKP0+TL/LfzCPbH06yg5M1yn+s/eHFkPRLGZ1YoVlRh66kVrhUuCkI8jLy7eQ//nWHKwhiSNr01Z2kUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=M5fpwnBf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707652750; x=1708257550; i=erick.archer@gmx.com;
	bh=F/PLXTMkyVwJbChPRdvu+2gvdsQ3yhXw4Bv2uHCzTtw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=M5fpwnBfY9wIq2Eict+kpD4yuEFHT/8k3wNq5IgBWW188bW12+B/QCI7n/kzgr81
	 Hm231NYpqkldblbUaWbPJAapkzoLJFP/9ydE2+R3ualHQ3nmi2TX16+OERezacQIU
	 ev3vsyupXjOba0tNIrUf5oD+QnhbUDyLWDXdeLvNHaVuKjp6m8YaS0ydnHXcQvBMa
	 XiSg3VxPalI1QBzumivZB2pn+7vr+qSc4DyWiGtxvfStS+UO1D0Eo8V7Wy4AabtEX
	 7Zu2v5x/yhjKO3rGMhsf/FLov93ttw0TyKA8rS5Ysue9NY9wsOoCE3AFBgas98maC
	 U/cHDo9+X4MTIpOF8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MyKHc-1qlYbh3FVs-00ykWz; Sun, 11 Feb 2024 12:59:09 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: Remove flexible arrays from struct *_filter
Date: Sun, 11 Feb 2024 12:58:56 +0100
Message-Id: <20240211115856.9788-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v4KYnvSntkV7LAPS/Z4jE6jq7w2r9NC95ab9cbw5l25bk4Ynh/d
 dfxTKZSNw2Ghtt5WWL6BPIRBpNuWz7LZ1e8rd+WQjmWolSkptfXVWecvkE7ImNYL+ZZ/wfb
 1aJGloC93dSJVRfLub9Y+JlAHjMf7VYhrQttto2Y7Q4jk8kScxVu48Jid77fo4/4yktZvuf
 Ut3d69Wt106PV8aDx/VsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hxC/Z1PMUwM=;Ra6n+mlC+ErZ8rxsHfTQsZcsFCv
 1J6MyqNe+rKPWGtWQGhX2Ml0c39PyUsYyFYxXVWEDEoy7AgrlJQ1Yb7ayh/G5YIV3bqnCeSEU
 NCj9svlWG8picVtpZ1+YLPyEWTrpgaD3JEMzxyuuzvngn3eR10PaRFcA4wKc9GRs9chJEhdVf
 XcTr9zclM46WQ5OeCM3rtuLcFHMWQa7E/5S1PB+j0tGp8zEMgd14HOglfiuqD+ebj2wT+GyR3
 Pa7GaD3aYofbjx/p8fMDiB4xeGTxT/XqmRLMqBMmyvuWU6iQR2kT89Mp360kw2ecXZAbs51g2
 aRvAGz115Wc7oDlTM6/Q+jvnlc+YOcyAPWz5O7x83fr7Q+C8TtnICXXe17keYcaMaJqPUQbvR
 dThgMcoDHez4oOk6J5R8blf8ydIy3N3NTEcnLa7aV2iThyb08Kitq/pMp/e7CaekN3q8fhqzd
 oz9oOcwiWkv9XEgzY4tPUzxsU++NNbIgSu1+m5ZashgFw1bEpmyWrZTyISeQQl5bITu/xO2aU
 wkwtbS3lhqdjW/IQMrqYFL3pydJ4qdUPEmnmJdwDY9ZYs73yaFwMCgjvwj3IoJXFHL7fJMrJN
 3wy+XquX2NT9QbuDY1nKRGvFL4fr6zB8vbVMesYZeu8j51buj89VxLwfuViDZdrGWDKTBM1ri
 CnN70mAh9ab83yB5Zc13Idbg72CNistPhXdPLoNcAxA9tBbwvsBOabZxDc6tSHHmfoKEOLecI
 AoZjJR85dOop/5v0ckQToRqgl1aD5m9gj12g+VVz+wJJWQKtJVu4RAKFFctbH125GV/0viFgJ
 ak/pScHguLisa5pmwz0bQezeApOlXVXnwmh5XDOdlsF4U=

When a struct containing a flexible array is included in another struct,
and there is a member after the struct-with-flex-array, there is a
possibility of memory overlap. These cases must be audited [1]. See:

struct inner {
	...
	int flex[];
};

struct outer {
	...
	struct inner header;
	int overlap;
	...
};

This is the scenario for all the "struct *_filter" structures that are
included in the following "struct ib_flow_spec_*" structures:

struct ib_flow_spec_eth
struct ib_flow_spec_ib
struct ib_flow_spec_ipv4
struct ib_flow_spec_ipv6
struct ib_flow_spec_tcp_udp
struct ib_flow_spec_tunnel
struct ib_flow_spec_esp
struct ib_flow_spec_gre
struct ib_flow_spec_mpls

The pattern is like the one shown below:

struct *_filter {
	...
	u8 real_sz[];
};

struct ib_flow_spec_mpls {
	...
	struct *_filter val;
	struct *_filter mask;
};

In this case, the trailing flexible array "real_sz" is never allocated
and is only used to calculate the size of the structures. Here the use
of the "offsetof" helper can be changed by the "sizeof" operator because
the goal is to get the size of these structures. Therefore, the trailing
flexible arrays can also be removed.

Link: https://github.com/KSPP/linux/issues/202 [1]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Hi everyone,

This patch has not been tested. This has only been built-tested.
Regards,

Erick
=2D--
 drivers/infiniband/core/uverbs_cmd.c | 16 ++++++++--------
 include/rdma/ib_verbs.h              | 17 -----------------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/cor=
e/uverbs_cmd.c
index 6de05ade2ba9..3d3ee3eca983 100644
=2D-- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2737,7 +2737,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,

 	switch (ib_spec->type & ~IB_FLOW_SPEC_INNER) {
 	case IB_FLOW_SPEC_ETH:
-		ib_filter_sz =3D offsetof(struct ib_flow_eth_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_eth_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2748,7 +2748,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->eth.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_IPV4:
-		ib_filter_sz =3D offsetof(struct ib_flow_ipv4_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_ipv4_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2759,7 +2759,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->ipv4.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_IPV6:
-		ib_filter_sz =3D offsetof(struct ib_flow_ipv6_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_ipv6_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2775,7 +2775,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		break;
 	case IB_FLOW_SPEC_TCP:
 	case IB_FLOW_SPEC_UDP:
-		ib_filter_sz =3D offsetof(struct ib_flow_tcp_udp_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_tcp_udp_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2786,7 +2786,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->tcp_udp.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_VXLAN_TUNNEL:
-		ib_filter_sz =3D offsetof(struct ib_flow_tunnel_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_tunnel_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2801,7 +2801,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 			return -EINVAL;
 		break;
 	case IB_FLOW_SPEC_ESP:
-		ib_filter_sz =3D offsetof(struct ib_flow_esp_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_esp_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2812,7 +2812,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->esp.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_GRE:
-		ib_filter_sz =3D offsetof(struct ib_flow_gre_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_gre_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
@@ -2823,7 +2823,7 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_fl=
ow_spec_type type,
 		memcpy(&ib_spec->gre.mask, kern_spec_mask, actual_filter_sz);
 		break;
 	case IB_FLOW_SPEC_MPLS:
-		ib_filter_sz =3D offsetof(struct ib_flow_mpls_filter, real_sz);
+		ib_filter_sz =3D sizeof(struct ib_flow_mpls_filter);
 		actual_filter_sz =3D spec_filter_size(kern_spec_mask,
 						    kern_filter_sz,
 						    ib_filter_sz);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b7b6b58dd348..80e814a57034 100644
=2D-- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1910,8 +1910,6 @@ struct ib_flow_eth_filter {
 	u8	src_mac[6];
 	__be16	ether_type;
 	__be16	vlan_tag;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_eth {
@@ -1924,8 +1922,6 @@ struct ib_flow_spec_eth {
 struct ib_flow_ib_filter {
 	__be16 dlid;
 	__u8   sl;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_ib {
@@ -1949,8 +1945,6 @@ struct ib_flow_ipv4_filter {
 	u8	tos;
 	u8	ttl;
 	u8	flags;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_ipv4 {
@@ -1967,8 +1961,6 @@ struct ib_flow_ipv6_filter {
 	u8	next_hdr;
 	u8	traffic_class;
 	u8	hop_limit;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_ipv6 {
@@ -1981,8 +1973,6 @@ struct ib_flow_spec_ipv6 {
 struct ib_flow_tcp_udp_filter {
 	__be16	dst_port;
 	__be16	src_port;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_tcp_udp {
@@ -1994,7 +1984,6 @@ struct ib_flow_spec_tcp_udp {

 struct ib_flow_tunnel_filter {
 	__be32	tunnel_id;
-	u8	real_sz[];
 };

 /* ib_flow_spec_tunnel describes the Vxlan tunnel
@@ -2010,8 +1999,6 @@ struct ib_flow_spec_tunnel {
 struct ib_flow_esp_filter {
 	__be32	spi;
 	__be32  seq;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_esp {
@@ -2025,8 +2012,6 @@ struct ib_flow_gre_filter {
 	__be16 c_ks_res0_ver;
 	__be16 protocol;
 	__be32 key;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_gre {
@@ -2038,8 +2023,6 @@ struct ib_flow_spec_gre {

 struct ib_flow_mpls_filter {
 	__be32 tag;
-	/* Must be last */
-	u8	real_sz[];
 };

 struct ib_flow_spec_mpls {
=2D-
2.25.1



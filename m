Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A132B5264
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgKPUXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:18 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:12435 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730917AbgKPUXS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:18 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb40000>; Tue, 17 Nov 2020 04:23:16 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:15 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsdTGJVRjNVmAxAIZvWsugyLnFwRYr/jpvggp/JVacdcqFAMH4CAlyo4My56HgAIDJi1JNCQ68B91eDXykncFdWVS8fV5z04oqe3j5kbH42hWqTpbUvt6B58ejufrbJ31hn4HWUd1ChbnTN2LhNh1CLZcNp4DWRFHDyo5WqWu77R1Cgelz8kBYRQxues4Y51unSBw1kyQwHgTe+/qtknKUxvovjlJqjTL4NSZMNWZ2pjxZPjx+uuxEF/jTh5hTGeBnYWmR6qPy8QQI7FnMD1DHRFNAOump0OF+ZYk6c1iIEw5Gn+lgJ5+4hbYpcvKDGZwMbOSlL5asZYld/+icKWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqedE2Z0OvS+aSup+xYbDGMXx5+7UFj9IaZ+t4wbQFM=;
 b=V0n0bd1N4h1q2/G9sGQCr80eSTamKqTW26/Sh1S3y5LQrDHAdvCp7ZS02SEHpAEdN9cXf3UPDLbl3eXYM67nhhqZDFr8DhYSBaEps5s5PnYmP69BEoUofra53fiojX8z/FOiLutXgr4FrSooes3EdvpOLbsbfc1leWmOtS/V29h7k35dnHLdPMLYxz2ZkOCtgG4215q8YUJxi7FHyxCdXXCjylfhGU6DskeHzoSRWBHK/kCU8ZpHFwLd6gU5l071Lp7nVfJr4AAiFYDwFjMCf84mPUzQ47v4Y+3gWqQmfvS2tjiDd5dSqC+7zou2UZJ+ZXNP50IGxDnZWRWuBHafww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:12 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/9] verbs: Simplify query_device_ex
Date:   Mon, 16 Nov 2020 16:23:02 -0400
Message-ID: <1-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:208:178::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:208:178::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l7m-NI; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558196; bh=j3gDQ2sl+zTQuS4OknwpuI95kSSb27blfulGcSsFJGs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=VvJwY/AURFgRlnLyCQiDlA2p6xmqmDfMXQ/A4CPTYaR3s2yiio2STkc1cX46EjWBg
         gBQ9A0Kb6czs4pMtZ56W23QKBVVeZYP9yW7tMW2AT5lj9Qa9Lhmxj0s4tiYFES0F5a
         XQyWMutueMl0QDo3Mpve4FBSFqNAzHsmKpYjmHhslxANnRTcnxURVu78KkpPzoNZrh
         D5UQDOZQez6+Me1nfxRu4hYji/23qTUvjpuTVJRfJThsbGIVncIA/F/2wyls7L0diV
         2S4AlZlPon5nCJ/2dhKVyjN02evmVNLSOwf13K1D9dADXPm2ICZ9iqUNBCImBbYD5F
         MvEZQQO+92Zyw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The obtuse logic here is hard to read, simplify it with a small macro and
add offsetofend()

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/cmd.c | 146 ++++++++++++++++-------------------------------
 util/util.h      |   3 +
 2 files changed, 52 insertions(+), 97 deletions(-)

diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 25c8a971540c63..a439f8c06481dd 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -44,6 +44,7 @@
 #include <infiniband/cmd_write.h>
 #include "ibverbs.h"
 #include <ccan/minmax.h>
+#include <util/util.h>
=20
 bool verbs_allow_disassociate_destroy;
=20
@@ -144,117 +145,68 @@ int ibv_cmd_query_device_ex(struct ibv_context *cont=
ext,
 	/* Report back supported comp_mask bits. For now no comp_mask bit is
 	 * defined */
 	attr->comp_mask =3D resp->comp_mask & 0;
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, odp_caps) +
-			 sizeof(attr->odp_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, odp_caps) +
-		    sizeof(resp->odp_caps)) {
-			attr->odp_caps.general_caps =3D resp->odp_caps.general_caps;
-			attr->odp_caps.per_transport_caps.rc_odp_caps =3D
-				resp->odp_caps.per_transport_caps.rc_odp_caps;
-			attr->odp_caps.per_transport_caps.uc_odp_caps =3D
-				resp->odp_caps.per_transport_caps.uc_odp_caps;
-			attr->odp_caps.per_transport_caps.ud_odp_caps =3D
-				resp->odp_caps.per_transport_caps.ud_odp_caps;
-		}
-	}
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex,
-				  completion_timestamp_mask) +
-			 sizeof(attr->completion_timestamp_mask)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, timestamp_mask) +
-		    sizeof(resp->timestamp_mask))
-			attr->completion_timestamp_mask =3D resp->timestamp_mask;
+#define CAN_COPY(_ibv_attr, _uverbs_attr)                                 =
     \
+	(attr_size >=3D offsetofend(struct ibv_device_attr_ex, _ibv_attr) &&     =
\
+	 resp->response_length >=3D                                              =
\
+		 offsetofend(struct ib_uverbs_ex_query_device_resp,            \
+			     _uverbs_attr))
+
+	if (CAN_COPY(odp_caps, odp_caps)) {
+		attr->odp_caps.general_caps =3D resp->odp_caps.general_caps;
+		attr->odp_caps.per_transport_caps.rc_odp_caps =3D
+			resp->odp_caps.per_transport_caps.rc_odp_caps;
+		attr->odp_caps.per_transport_caps.uc_odp_caps =3D
+			resp->odp_caps.per_transport_caps.uc_odp_caps;
+		attr->odp_caps.per_transport_caps.ud_odp_caps =3D
+			resp->odp_caps.per_transport_caps.ud_odp_caps;
 	}
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, hca_core_clock) +
-			 sizeof(attr->hca_core_clock)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, hca_core_clock) +
-		    sizeof(resp->hca_core_clock))
-			attr->hca_core_clock =3D resp->hca_core_clock;
-	}
+	if (CAN_COPY(completion_timestamp_mask, timestamp_mask))
+		attr->completion_timestamp_mask =3D resp->timestamp_mask;
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, device_cap_flags_e=
x) +
-			 sizeof(attr->device_cap_flags_ex)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, device_cap_flags_ex)=
 +
-		    sizeof(resp->device_cap_flags_ex))
-			attr->device_cap_flags_ex =3D resp->device_cap_flags_ex;
-	}
+	if (CAN_COPY(hca_core_clock, hca_core_clock))
+		attr->hca_core_clock =3D resp->hca_core_clock;
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, rss_caps) +
-			 sizeof(attr->rss_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, rss_caps) +
-		    sizeof(resp->rss_caps)) {
-			attr->rss_caps.supported_qpts =3D resp->rss_caps.supported_qpts;
-			attr->rss_caps.max_rwq_indirection_tables =3D resp->rss_caps.max_rwq_in=
direction_tables;
-			attr->rss_caps.max_rwq_indirection_table_size =3D resp->rss_caps.max_rw=
q_indirection_table_size;
-		}
-	}
+	if (CAN_COPY(device_cap_flags_ex, device_cap_flags_ex))
+		attr->device_cap_flags_ex =3D resp->device_cap_flags_ex;
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, max_wq_type_rq) +
-			 sizeof(attr->max_wq_type_rq)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, max_wq_type_rq) +
-		    sizeof(resp->max_wq_type_rq))
-			attr->max_wq_type_rq =3D resp->max_wq_type_rq;
+	if (CAN_COPY(rss_caps, rss_caps)) {
+		attr->rss_caps.supported_qpts =3D resp->rss_caps.supported_qpts;
+		attr->rss_caps.max_rwq_indirection_tables =3D
+			resp->rss_caps.max_rwq_indirection_tables;
+		attr->rss_caps.max_rwq_indirection_table_size =3D
+			resp->rss_caps.max_rwq_indirection_table_size;
 	}
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, raw_packet_caps) +
-			 sizeof(attr->raw_packet_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, raw_packet_caps) +
-		    sizeof(resp->raw_packet_caps))
-			attr->raw_packet_caps =3D resp->raw_packet_caps;
-	}
+	if (CAN_COPY(max_wq_type_rq, max_wq_type_rq))
+		attr->max_wq_type_rq =3D resp->max_wq_type_rq;
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, tm_caps) +
-			 sizeof(attr->tm_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, tm_caps) +
-		    sizeof(resp->tm_caps)) {
-			attr->tm_caps.max_rndv_hdr_size =3D
-				resp->tm_caps.max_rndv_hdr_size;
-			attr->tm_caps.max_num_tags =3D
-				resp->tm_caps.max_num_tags;
-			attr->tm_caps.flags =3D resp->tm_caps.flags;
-			attr->tm_caps.max_ops =3D
-				resp->tm_caps.max_ops;
-			attr->tm_caps.max_sge =3D
-				resp->tm_caps.max_sge;
-		}
-	}
+	if (CAN_COPY(raw_packet_caps, raw_packet_caps))
+		attr->raw_packet_caps =3D resp->raw_packet_caps;
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, cq_mod_caps) +
-			 sizeof(attr->cq_mod_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, cq_moderation_caps) =
+
-		    sizeof(resp->cq_moderation_caps)) {
-			attr->cq_mod_caps.max_cq_count =3D resp->cq_moderation_caps.max_cq_mode=
ration_count;
-			attr->cq_mod_caps.max_cq_period =3D resp->cq_moderation_caps.max_cq_mod=
eration_period;
-		}
+	if (CAN_COPY(tm_caps, tm_caps)) {
+		attr->tm_caps.max_rndv_hdr_size =3D
+			resp->tm_caps.max_rndv_hdr_size;
+		attr->tm_caps.max_num_tags =3D resp->tm_caps.max_num_tags;
+		attr->tm_caps.flags =3D resp->tm_caps.flags;
+		attr->tm_caps.max_ops =3D resp->tm_caps.max_ops;
+		attr->tm_caps.max_sge =3D resp->tm_caps.max_sge;
 	}
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, max_dm_size) +
-			sizeof(attr->max_dm_size)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, max_dm_size) +
-		    sizeof(resp->max_dm_size)) {
-			attr->max_dm_size =3D resp->max_dm_size;
-		}
+	if (CAN_COPY(cq_mod_caps, cq_moderation_caps)) {
+		attr->cq_mod_caps.max_cq_count =3D
+			resp->cq_moderation_caps.max_cq_moderation_count;
+		attr->cq_mod_caps.max_cq_period =3D
+			resp->cq_moderation_caps.max_cq_moderation_period;
 	}
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, xrc_odp_caps) +
-			sizeof(attr->xrc_odp_caps)) {
-		if (resp->response_length >=3D
-		    offsetof(struct ib_uverbs_ex_query_device_resp, xrc_odp_caps) +
-		    sizeof(resp->xrc_odp_caps)) {
-			attr->xrc_odp_caps =3D resp->xrc_odp_caps;
-		}
-	}
+	if (CAN_COPY(max_dm_size, max_dm_size))
+		attr->max_dm_size =3D resp->max_dm_size;
+
+	if (CAN_COPY(xrc_odp_caps, xrc_odp_caps))
+		attr->xrc_odp_caps =3D resp->xrc_odp_caps;
+#undef CAN_COPY
=20
 	return 0;
 }
diff --git a/util/util.h b/util/util.h
index 0f2c35cd0647ce..47346ca1bf5841 100644
--- a/util/util.h
+++ b/util/util.h
@@ -23,6 +23,9 @@ static inline bool __good_snprintf(size_t len, int rc)
 	 ((a)->tv_nsec CMP (b)->tv_nsec) :	\
 	 ((a)->tv_sec CMP (b)->tv_sec))
=20
+#define offsetofend(_type, _member)                                       =
     \
+	(offsetof(_type, _member) + sizeof(((_type *)0)->_member))
+
 static inline unsigned long align(unsigned long val, unsigned long align)
 {
 	return (val + align - 1) & ~(align - 1);
--=20
2.29.2


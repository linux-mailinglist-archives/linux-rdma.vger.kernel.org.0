Return-Path: <linux-rdma+bounces-9539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949FAA93162
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1753D7B2D81
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD942686AD;
	Fri, 18 Apr 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ftubNnim"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558F254871;
	Fri, 18 Apr 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744953399; cv=none; b=IRcwis4hYFjM7RqMlX2oc+zP/70nqenK64E9y15C1mUxgbd4rtNZxOvu3l+qAH0EZtUBWvVqClsZd+lWPS+241l01uQNOOfVeM1qhnKGrx/XDGtywBq5dx1T0J3kSjFRd0xWBs4FK1CB+69LMsDfXsE0sY4KmlB0H4ca8iF1xJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744953399; c=relaxed/simple;
	bh=JPaQbiGkfB0H2Re4l0sZ4huyVLiMzmYBWls8aB0/Swk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmyK8gvNjMluGxKjC7CILzNxenNIbVi0ltjLdBHslpKCWq9BzWYhKrbK0sfURdVSGEQuaorJvOe4Dwm7FbWVSA+liKVPWxZv6RvMa2vzfRyHL8ib56uLZR9yEWfwPHggv2TnZNb1T4pUM99JyVVl2cM4uR2SuDaXe9P06mOc1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ftubNnim; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744953398; x=1776489398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPaQbiGkfB0H2Re4l0sZ4huyVLiMzmYBWls8aB0/Swk=;
  b=ftubNnim2GRrZInjZD5kvVnArIgzBWYzSDv/dvsjSX3mKcoAWs6NdwqS
   3beXOIBoKvxq/S6C6dA2Zvf2E0sJT8TyNkOQlMmJO9wqRfEGcD6YolBt9
   W7UgOfJscdiIU3cQCeafb8rrF+sQFoMyf8N84aooT2cTOIRgOoE3EdYiX
   A4HslQsJmGsw4nZo/FY0peE1zgxtqdWtkLlexZvaM+AsMoXPVoMi9V0Q0
   xNRuxEpC2MJPTGckVQrKSoRj5dvsoZrbusHEZwNe5+kk9LFg5wLASJJcI
   jVHi2IdeoG6ZSV62b+ai7aVZXCJ9paMU5qXiZ5OrDAosvoJzbAQ1tR7WF
   g==;
X-CSE-ConnectionGUID: GGDRpp7OQn2FQ6yqwgzq+Q==
X-CSE-MsgGUID: spam444rS9OuqcPcTBvFcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="197221582"
X-IronPort-AV: E=Sophos;i="6.15,221,1739804400"; 
   d="scan'208";a="197221582"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 14:15:33 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 031A7C2260;
	Fri, 18 Apr 2025 14:15:31 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C43CBBDA46;
	Fri, 18 Apr 2025 14:15:30 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 5E0712005376;
	Fri, 18 Apr 2025 14:15:30 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-kernel@vger.kernel.org,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next 1/1] RDMA/core: Move ODP capability definitions to uapi
Date: Fri, 18 Apr 2025 14:13:45 +0900
Message-Id: <20250418051345.1022339-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250418051345.1022339-1-matsuda-daisuke@fujitsu.com>
References: <20250418051345.1022339-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bits are used from both kernel space and userland, so they should be
placed in UAPI.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 include/rdma/ib_verbs.h           | 20 ++++++++++----------
 include/uapi/rdma/ib_user_verbs.h | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a7ccd08b365..b06a0ed81bdd 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -314,19 +314,19 @@ enum ib_atomic_cap {
 };
 
 enum ib_odp_general_cap_bits {
-	IB_ODP_SUPPORT		= 1 << 0,
-	IB_ODP_SUPPORT_IMPLICIT = 1 << 1,
+	IB_ODP_SUPPORT		= IB_UVERBS_ODP_SUPPORT,
+	IB_ODP_SUPPORT_IMPLICIT = IB_UVERBS_ODP_SUPPORT_IMPLICIT,
 };
 
 enum ib_odp_transport_cap_bits {
-	IB_ODP_SUPPORT_SEND	= 1 << 0,
-	IB_ODP_SUPPORT_RECV	= 1 << 1,
-	IB_ODP_SUPPORT_WRITE	= 1 << 2,
-	IB_ODP_SUPPORT_READ	= 1 << 3,
-	IB_ODP_SUPPORT_ATOMIC	= 1 << 4,
-	IB_ODP_SUPPORT_SRQ_RECV	= 1 << 5,
-	IB_ODP_SUPPORT_FLUSH	= 1 << 6,
-	IB_ODP_SUPPORT_ATOMIC_WRITE	= 1 << 7,
+	IB_ODP_SUPPORT_SEND	= IB_UVERBS_ODP_SUPPORT_SEND,
+	IB_ODP_SUPPORT_RECV	= IB_UVERBS_ODP_SUPPORT_RECV,
+	IB_ODP_SUPPORT_WRITE	= IB_UVERBS_ODP_SUPPORT_WRITE,
+	IB_ODP_SUPPORT_READ	= IB_UVERBS_ODP_SUPPORT_READ,
+	IB_ODP_SUPPORT_ATOMIC	= IB_UVERBS_ODP_SUPPORT_ATOMIC,
+	IB_ODP_SUPPORT_SRQ_RECV	= IB_UVERBS_ODP_SUPPORT_SRQ_RECV,
+	IB_ODP_SUPPORT_FLUSH	= IB_UVERBS_ODP_SUPPORT_FLUSH,
+	IB_ODP_SUPPORT_ATOMIC_WRITE	= IB_UVERBS_ODP_SUPPORT_ATOMIC_WRITE,
 };
 
 struct ib_odp_caps {
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index e16650f0c85d..3b7bd99813e9 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -233,6 +233,22 @@ struct ib_uverbs_ex_query_device {
 	__u32 reserved;
 };
 
+enum ib_uverbs_odp_general_cap_bits {
+	IB_UVERBS_ODP_SUPPORT          = 1 << 0,
+	IB_UVERBS_ODP_SUPPORT_IMPLICIT = 1 << 1,
+};
+
+enum ib_uverbs_odp_transport_cap_bits {
+	IB_UVERBS_ODP_SUPPORT_SEND     = 1 << 0,
+	IB_UVERBS_ODP_SUPPORT_RECV     = 1 << 1,
+	IB_UVERBS_ODP_SUPPORT_WRITE    = 1 << 2,
+	IB_UVERBS_ODP_SUPPORT_READ     = 1 << 3,
+	IB_UVERBS_ODP_SUPPORT_ATOMIC   = 1 << 4,
+	IB_UVERBS_ODP_SUPPORT_SRQ_RECV = 1 << 5,
+	IB_UVERBS_ODP_SUPPORT_FLUSH    = 1 << 6,
+	IB_UVERBS_ODP_SUPPORT_ATOMIC_WRITE     = 1 << 7,
+};
+
 struct ib_uverbs_odp_caps {
 	__aligned_u64 general_caps;
 	struct {
-- 
2.43.0



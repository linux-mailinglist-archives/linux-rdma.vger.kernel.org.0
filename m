Return-Path: <linux-rdma+bounces-10111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30239AAD3B1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 05:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0CF983A18
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7018B46E;
	Wed,  7 May 2025 03:04:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035E18C31;
	Wed,  7 May 2025 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587088; cv=none; b=og3bpLh6g8QPqUbIzOOc+g83pu1WtNFs7etUs5ALB5/k+rvwvG2qAB8crkJOfOrzQvCjiX7qAbWdBbFcbnXLJGm+45XmW433ZS9wl/UC8gwNhLzuiQshgVP7XbfIFEJy6c69NBHxeEHg7AmgyBQfPlnf7Dvjxsf1z4dzG8vDPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587088; c=relaxed/simple;
	bh=QwIKkKxpNb7iwHp9WW3P27A3tZtJzLdwiQneLX2HKs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VIW2KJLx+WXKpDW8Xv4fcVreocee8UjX3JMJuOxcUrRhn5fqfGTRlm0rc3zhC78kdIU0D+4htrS+BSFfBxNZk0vFi2g7Ume7cQXrnydFhJSx1S9lpdNikXzfPfxz5d2aTs/2x/tofnPWTZgNSVhev3B/27XWkFUjCjWWwDs34U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 02df348c2af011f0b29709d653e92f7d-20250507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d7deef24-acd2-4a9a-86d8-db3bb7a87288,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:eba71daf2742749ccda461fe3bf9477b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02df348c2af011f0b29709d653e92f7d-20250507
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1610368035; Wed, 07 May 2025 11:04:37 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 6E096B804EBC;
	Wed,  7 May 2025 11:04:37 +0800 (CST)
X-ns-mid: postfix-681ACDC5-199025431
Received: from localhost.localdomain (unknown [10.42.12.16])
	by node2.com.cn (NSMail) with ESMTPA id 87482B80758A;
	Wed,  7 May 2025 03:04:36 +0000 (UTC)
From: Huiwen He <hehuiwen@kylinos.cn>
To: tangchengchang@huawei.com
Cc: huangjunxian6@hisilicon.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] RDMA/hns: fix trace TRACE_INCLUDE_PATH
Date: Wed,  7 May 2025 11:04:33 +0800
Message-Id: <20250507030433.599021-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TRACE_INCLUDE_PATH should be a path relative to define_trace.h, not the
file including it. (See the comment in include/trace/define_trace.h.)

Fixes build error found with CONFIG_INFINIBAND_HNS_HIP08=3Dm:
  CC [M]  drivers/infiniband/hw/hns/hns_roce_hw_v2.o
In file included from drivers/infiniband/hw/hns/hns_roce_trace.h:213,
                 from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:53:
./include/trace/define_trace.h:110:42: fatal error: ./hns_roce_trace.h: N=
o such file or directory
  110 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 drivers/infiniband/hw/hns/hns_roce_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_trace.h b/drivers/infinib=
and/hw/hns/hns_roce_trace.h
index 23cbdbaeffaa..19bd3c0eec47 100644
--- a/drivers/infiniband/hw/hns/hns_roce_trace.h
+++ b/drivers/infiniband/hw/hns/hns_roce_trace.h
@@ -209,5 +209,5 @@ DEFINE_EVENT(cmdq, hns_cmdq_resp,
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE hns_roce_trace
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../drivers/infiniband/hw/hns
 #include <trace/define_trace.h>
--=20
2.25.1



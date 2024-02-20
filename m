Return-Path: <linux-rdma+bounces-1066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806985B38B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6381C218FF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FE5C8F6;
	Tue, 20 Feb 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UlI9b52O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A575BAE4;
	Tue, 20 Feb 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412531; cv=none; b=CbbyQFO0H2sFU7MgW5VsQ5RAcnqTLWiSHvnGoglgLbz3YLsCIV+AiClhm/d9lDwRrj1kbDgMlwlRentAUYt55ay1YqMea6OG6y7/3ShraEcJQa4+sas0Ko9asFSJVBwdA3QCAnaO2rMS4vPZQdpCQb7T1uLL72DymVUCLfoj/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412531; c=relaxed/simple;
	bh=B0jplbyeTnyGgXjKs16mHemTW9xr+/sOdoE/vhvo+Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hAJIYIwSdcOgU6bvfEoAlEmR11RQ1fwS/k/OtqXH6rjbOs3izr2ao9FpFihB1trQgrL0Lq/rv/NV1Uj+JgJRj8O1V7JU6Tq90ow4ZMhzlUeJowdAaJr7In6RG2O89+L4F67r8eSDs46DhQMPLE+nRPpJGEUinvYxR/pMO9syDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UlI9b52O; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412520; h=From:To:Subject:Date:Message-Id;
	bh=0pvz0ikn7fOS4oqX6wWIzYrHZ9s8iUGQ3pRJhSRJWas=;
	b=UlI9b52ONfSlK3wUFQR53G16Jvl8kQGfEMePcSX0N+h3ZDeparH673PsOVgGxKo8TQMPfu0l9j6HpV+Wqdwok6BoDJoKOwkGXGgBM7yl6V2y1EeCEO6H6QHx/7mqQefccHbkhvrYU2Dd+SqFFgpmJVEsNqr5Tt2RZ/gVQpWTMBw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXh3_1708412519;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXh3_1708412519)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:02:00 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 16/20] net/smc: add inet proto defination for SMC
Date: Tue, 20 Feb 2024 15:01:41 +0800
Message-Id: <1708412505-34470-17-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

To implement SMC based on INET sock, we need to be able to identify
its real sock type, So we need to apply for a unique IPPROTO_XXX
definition.

But unlike IPPROTO_TCP or other similar definitions, which values need
to be filled into IP message and transmitted in the network. In fact,
we just need make sure it is unique in the code. That is, IPPROTO_SMC
dose not exist in network, and it is only used to distinguish
actual inet sock type in code, and it's still IPPROTO_TCP that is
transmitted in the network.

In theory, we just need to define IPPROTO_SMC as value greater than 255
and unique in the code. In this patch, we pick 263, following
IPPROTO_MPTCP.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/uapi/linux/in.h       | 2 ++
 tools/include/uapi/linux/in.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab6..7f4b449 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -83,6 +83,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
+	IPPROTO_SMC = 263,		/* Shared Memory Communications */
+#define IPPROTO_SMC		IPPROTO_SMC
   IPPROTO_MAX
 };
 #endif
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index e682ab6..7f4b449 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -83,6 +83,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
+	IPPROTO_SMC = 263,		/* Shared Memory Communications */
+#define IPPROTO_SMC		IPPROTO_SMC
   IPPROTO_MAX
 };
 #endif
-- 
1.8.3.1



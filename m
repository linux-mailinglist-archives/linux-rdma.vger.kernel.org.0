Return-Path: <linux-rdma+bounces-1052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41985B361
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBE51C2179F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2135A4CD;
	Tue, 20 Feb 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fw1KNtum"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382E5A102;
	Tue, 20 Feb 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412518; cv=none; b=EiyTXgZmCE/3gJ5PUBfbA9Zzx4FTGxDaVvZ2tGWTFmOPbH5OBiXJO/wwwy8+dOj4Zz7jtmZCMZgLi5NN/nDvGa7Aj1VB8JZNQmFZrLlYspTh+3ZTKD4Nu6gCadRD6pAQiXNq1lZ47DmcXVAmYdjylb15KuFHUuMp3tll28yfnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412518; c=relaxed/simple;
	bh=qzkCICB9HoTrOvet9L/Jj6fywd5UhEGsi5l9fNtfBGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XGNjlObG9zp2yKuAOn7IvLhJSbZbXXorEc1I6VaU1Xa2K0SI85u87zDPfNfquwHPjbWbrCq0305yD6UqEefY8d78RGlh3L9yexdErujEtRb4Eql5YXXaKhaM9TlmRaaGOxMs5Nbrl4hZ6EslhB9eW+y7ui8tl/5TF7soWpmD/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fw1KNtum; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412513; h=From:To:Subject:Date:Message-Id;
	bh=rZbZxhZJSrWPib9cXdiHqcSkJQ2MvvBwgBg0dzO7QSI=;
	b=Fw1KNtum9JHSoCJ8N1CZ5CyR6z+0RZYyTU/oCAK2IvzPS1ZClWYHdrryDzsgrAW8XWnFrbNyd4eDbkCZgc2BqYbDrmcH/ObGVsKt3ZmWySv5In7G4Xk2ZdRAAaxSDKgZShX30UMjpHNGDZGy5/twKzcBpf+UNAj+XV8gsd+YGqY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXe3_1708412512;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXe3_1708412512)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:52 +0800
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
Subject: [RFC net-next 05/20] net/smc: try test to fallback when ulp set
Date: Tue, 20 Feb 2024 15:01:30 +0800
Message-Id: <1708412505-34470-6-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Currently, when the ULP option was seen, we will immediately
return a failure. Here we try to fallback first as much as possible,
rather than immediately returning.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7966d06..b7c9f5c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3048,6 +3048,7 @@ static inline bool smc_is_unsupport_tcp_sockopt(int optname)
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_ULP:
 		return true;
 	}
 	return false;
@@ -3119,9 +3120,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	struct smc_sock *smc;
 	int rc;
 
-	if (level == SOL_TCP && optname == TCP_ULP)
-		return -EOPNOTSUPP;
-	else if (level == SOL_SMC)
+	if (level == SOL_SMC)
 		return __smc_setsockopt(sock, level, optname, optval, optlen);
 
 	smc = smc_sk(sk);
-- 
1.8.3.1



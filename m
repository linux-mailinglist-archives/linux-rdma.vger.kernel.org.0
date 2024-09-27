Return-Path: <linux-rdma+bounces-5124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF48987E94
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0861C21C7E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3870176FBD;
	Fri, 27 Sep 2024 06:42:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B5158557;
	Fri, 27 Sep 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419331; cv=none; b=WndQ5jOxeBq2g+IDbx+wNm1sTS23oCiso0BS9durUnWQNYKfZiiujN9kbouhBOpNAqdGuaIqbW39hIXisl5Kc39vEkeyanVoNXGz2rPfEmS/nRyFWAv2xFXn8xDwAN2rGPeB/FK6dySCTLiAuBPqvRM2IX2Mmd5OwEs9CQr0I6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419331; c=relaxed/simple;
	bh=tzcqlhkvieSCrrhxcpgwaOhQnMapI3OL69U3gaM+KOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyLUp2KabizEMz4Kpskh438xDfVjek5ummaDSEjHcklKOMU1UPcgW+fPETq06CaTNWea8O5DTTs6wAOmztLB9ogpY2eJwpzJFFeh7lXYLZYKNJrYOr+kSnPAFEO5HwUj5e9v3l9CqkMlKD/m9+uDJ8W347x266L5MKrVyjl4aUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166f653bbf1a-6e81e;
	Fri, 27 Sep 2024 14:42:05 +0800 (CST)
X-RM-TRANSID:2ee166f653bbf1a-6e81e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166f653bd647-3595b;
	Fri, 27 Sep 2024 14:42:05 +0800 (CST)
X-RM-TRANSID:2ee166f653bd647-3595b
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests: rds: Remove include.sh when make clean
Date: Fri, 27 Sep 2024 12:49:23 +0800
Message-Id: <20240927044923.12814-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Remove include.sh when make clean

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..0b697669ea51 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -7,6 +7,6 @@ TEST_PROGS := run.sh \
 	include.sh \
 	test.py
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk
-- 
2.33.0





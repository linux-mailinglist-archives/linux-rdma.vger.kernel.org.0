Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7B7AC1F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfG3PTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 11:19:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60431 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfG3PTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 11:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564499949; x=1596035949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGgiDajZHu75XZLK1UhZrsTLx0zW7IbgZv7J0JnkrXk=;
  b=G5fF1Ed41DTzjArg1xxwAjykRI/3Ut2gcz1/qcRxrqkBs1agTvwXULfT
   wABKtvkLJI6qp6KpocSRYxcuZT94+FwZ4OIlr4fgr+8n7LbfpZAqsGyeS
   yXw58Au+FOavVuEjOkRJFmbGDfYfEuhfsvc7QeZbPOEU6GbjuQlTaoOmN
   U=;
X-IronPort-AV: E=Sophos;i="5.64,327,1559520000"; 
   d="scan'208";a="814964941"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 30 Jul 2019 15:19:07 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 4F5CFA2754;
        Tue, 30 Jul 2019 15:19:07 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 15:19:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 15:19:05 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 30 Jul 2019 15:19:04 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev printk functions
Date:   Tue, 30 Jul 2019 18:18:33 +0300
Message-ID: <20190730151834.70993-2-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730151834.70993-1-galpress@amazon.com>
References: <20190730151834.70993-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ratelimited helpers to the ibdev_* printk functions.
Implementation inspired by counterpart dev_*_ratelimited functions.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f17063..356e6a105366 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -107,6 +107,57 @@ static inline
 void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
 #endif
 
+#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
+do {                                                                    \
+	static DEFINE_RATELIMIT_STATE(_rs,                              \
+				      DEFAULT_RATELIMIT_INTERVAL,       \
+				      DEFAULT_RATELIMIT_BURST);         \
+	if (__ratelimit(&_rs))                                          \
+		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
+} while (0)
+
+#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_err_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
+#define ibdev_info_ratelimited(ibdev, fmt, ...) \
+	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+/* descriptor check is first to prevent flooding with "callbacks suppressed" */
+#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
+do {                                                                    \
+	static DEFINE_RATELIMIT_STATE(_rs,                              \
+				      DEFAULT_RATELIMIT_INTERVAL,       \
+				      DEFAULT_RATELIMIT_BURST);         \
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
+		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
+				    ##__VA_ARGS__);                     \
+} while (0)
+#elif defined(DEBUG)
+#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
+do {                                                                    \
+	static DEFINE_RATELIMIT_STATE(_rs,                              \
+				      DEFAULT_RATELIMIT_INTERVAL,       \
+				      DEFAULT_RATELIMIT_BURST);         \
+	if (__ratelimit(&_rs))                                          \
+		ibdev_printk(KERN_DEBUG, ibdev, fmt, ##__VA_ARGS__);    \
+} while (0)
+#else
+__printf(2, 3) __cold
+static inline
+void ibdev_dbg_ratelimited(const struct ib_device *ibdev, const char *format, ...) {}
+#endif
+
 union ib_gid {
 	u8	raw[16];
 	struct {
-- 
2.22.0


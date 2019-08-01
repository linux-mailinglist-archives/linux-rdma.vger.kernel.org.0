Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F067E0D6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfHARPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 13:15:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39759 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHARPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 13:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564679735; x=1596215735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VhI+lEn+tsVMv1+k4y3EQ9t+IG0GxM/17ifq2bRUJ8=;
  b=IHmTPTEvol/HXL6/Ou2uWQ3PCki4jlg7vSbYoWvkVs7wPRcW8AFDS7ky
   7hZ0u9MrZAQlRQSvt1TLSVlZwvDSAhDGgIRfw2iVvrFeSOrm0JZwOSrEQ
   Pb0e/p/4qdGjfbtmSGLVU66x+UI1s9XObKgdUqobRBOIub40MnIbUgBfy
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="815790423"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 01 Aug 2019 17:15:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 40587A25F9;
        Thu,  1 Aug 2019 17:15:17 +0000 (UTC)
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:15 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.68.21) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 1 Aug 2019 17:15:12 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 1/2] RDMA/core: Introduce ratelimited ibdev printk functions
Date:   Thu, 1 Aug 2019 20:14:46 +0300
Message-ID: <20190801171447.54440-2-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801171447.54440-1-galpress@amazon.com>
References: <20190801171447.54440-1-galpress@amazon.com>
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
 include/rdma/ib_verbs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f17063..c224b56f4cca 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -107,6 +107,48 @@ static inline
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


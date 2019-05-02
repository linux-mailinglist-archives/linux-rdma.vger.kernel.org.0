Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08111B9D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBOjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 10:39:09 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32211 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556807948; x=1588343948;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wntMH1x6DI8KhipjgyNAEjxv1mZb0UgX07kycrDZNM8=;
  b=k7bmNQUs/iH2zmFaTxN0Mm4wkBRfYEFTc0p08vA05G53QPWC9Tub6UI5
   LikMZujfYHnjBo1vGqvNrfjlAq4QDNRA/kYQWgvE0FcIfFJpCFpqy5cEu
   J1vI7R+EOZoa2Y6RusIE5G2DZT9n5Glh+9R6kQslXrQ7CDOXKfF+NnDO8
   k=;
X-IronPort-AV: E=Sophos;i="5.60,421,1549929600"; 
   d="scan'208";a="797497329"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 May 2019 14:39:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x42Ed2mr065018
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 2 May 2019 14:39:05 GMT
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 May 2019 14:39:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 May 2019 14:39:03 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 2 May 2019 14:39:01 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Yossi Leybovich <sleybo@amazon.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/core: Introduce ratelimited ibdev printk functions
Date:   Thu, 2 May 2019 17:38:43 +0300
Message-ID: <1556807923-20403-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ratelimited helpers to the ibdev_* printk functions.
Implementation inspired by counterpart dev_*_ratelimited functions.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
This is a followup patch to the addition of ibdev printk helpers to the
subsystem.

From quick grep of infiniband drivers, some of the drivers will need this
variation when starting to use ibdev printk functions. In addition, I plan to
use them in EFA as well.
---
 include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6cf8c4bf369e..e6bdea23e5d4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -104,6 +104,57 @@ static inline
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
2.7.4


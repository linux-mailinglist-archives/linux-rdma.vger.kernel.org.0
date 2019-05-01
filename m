Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D536D10724
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEAKsp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:48:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22195 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfEAKsp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707722; x=1588243722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Myyf23kIMaBCHWJcQr/GbvWgV9giIenQuT4sERS/MEg=;
  b=Pi9F7KeGPjslRpqH3K0SITiB0nz3W4yNojzjWLufvOOVPzGXC0uRTyaT
   enqSHRnCdTprqh4YoCMgO47SdXrHadQwPq/xgRXdf/JmLV9UVRI/xZiEC
   gXSJjhRvlWsvhtqNRmxz50hA00BvWtkQ+1ZI5tbG2cLy0BzauK4JMDHNE
   c=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="797274117"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:48:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x41AmYse036772
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:48:37 GMT
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:36 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB004.ant.amazon.com (10.43.166.221) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:35 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:48:31 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Jason Baron <jbaron@akamai.com>
Subject: [PATCH for-next v6 01/12] RDMA/core: Introduce RDMA subsystem ibdev_* print functions
Date:   Wed, 1 May 2019 13:48:13 +0300
Message-ID: <1556707704-11192-2-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Similarly to dev/netdev/etc printk helpers, add standard printk helpers
for the RDMA subsystem.

Example output:
efa 0000:00:06.0 efa_0: Hello World!
efa_0: Hello World! (no parent device set)
(NULL ib_device): Hello World! (ibdev is NULL)

Cc: Jason Baron <jbaron@akamai.com>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/core/device.c | 60 ++++++++++++++++++++++++++++++++++++++++
 include/linux/dynamic_debug.h    | 11 ++++++++
 include/rdma/ib_verbs.h          | 30 ++++++++++++++++++++
 lib/dynamic_debug.c              | 37 +++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fcbf2d4c865d..76088655f06e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -197,6 +197,66 @@ static int ib_security_change(struct notifier_block *nb, unsigned long event,
 static void ib_policy_change_task(struct work_struct *work);
 static DECLARE_WORK(ib_policy_change_work, ib_policy_change_task);
 
+static void __ibdev_printk(const char *level, const struct ib_device *ibdev,
+			   struct va_format *vaf)
+{
+	if (ibdev && ibdev->dev.parent)
+		dev_printk_emit(level[1] - '0',
+				ibdev->dev.parent,
+				"%s %s %s: %pV",
+				dev_driver_string(ibdev->dev.parent),
+				dev_name(ibdev->dev.parent),
+				dev_name(&ibdev->dev),
+				vaf);
+	else if (ibdev)
+		printk("%s%s: %pV",
+		       level, dev_name(&ibdev->dev), vaf);
+	else
+		printk("%s(NULL ib_device): %pV", level, vaf);
+}
+
+void ibdev_printk(const char *level, const struct ib_device *ibdev,
+		  const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	__ibdev_printk(level, ibdev, &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(ibdev_printk);
+
+#define define_ibdev_printk_level(func, level)                  \
+void func(const struct ib_device *ibdev, const char *fmt, ...)  \
+{                                                               \
+	struct va_format vaf;                                   \
+	va_list args;                                           \
+								\
+	va_start(args, fmt);                                    \
+								\
+	vaf.fmt = fmt;                                          \
+	vaf.va = &args;                                         \
+								\
+	__ibdev_printk(level, ibdev, &vaf);                     \
+								\
+	va_end(args);                                           \
+}                                                               \
+EXPORT_SYMBOL(func);
+
+define_ibdev_printk_level(ibdev_emerg, KERN_EMERG);
+define_ibdev_printk_level(ibdev_alert, KERN_ALERT);
+define_ibdev_printk_level(ibdev_crit, KERN_CRIT);
+define_ibdev_printk_level(ibdev_err, KERN_ERR);
+define_ibdev_printk_level(ibdev_warn, KERN_WARNING);
+define_ibdev_printk_level(ibdev_notice, KERN_NOTICE);
+define_ibdev_printk_level(ibdev_info, KERN_INFO);
+
 static struct notifier_block ibdev_lsm_nb = {
 	.notifier_call = ib_security_change,
 };
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c2be029b9b53..6c809440f319 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -71,6 +71,13 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev,
 			  const char *fmt, ...);
 
+struct ib_device;
+
+extern __printf(3, 4)
+void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
+			 const struct ib_device *ibdev,
+			 const char *fmt, ...);
+
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
 	__attribute__((section("__verbose"))) name = {		\
@@ -154,6 +161,10 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 	_dynamic_func_call(fmt, __dynamic_netdev_dbg,		\
 			   dev, fmt, ##__VA_ARGS__)
 
+#define dynamic_ibdev_dbg(dev, fmt, ...)			\
+	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
+			   dev, fmt, ##__VA_ARGS__)
+
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
 	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 737ef5ed3930..de8724e5a727 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -74,6 +74,36 @@ extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
 extern struct workqueue_struct *ib_comp_unbound_wq;
 
+__printf(3, 4) __cold
+void ibdev_printk(const char *level, const struct ib_device *ibdev,
+		  const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_emerg(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_alert(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_crit(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_err(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_warn(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_notice(const struct ib_device *ibdev, const char *format, ...);
+__printf(2, 3) __cold
+void ibdev_info(const struct ib_device *ibdev, const char *format, ...);
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define ibdev_dbg(__dev, format, args...)                       \
+	dynamic_ibdev_dbg(__dev, format, ##args)
+#elif defined(DEBUG)
+#define ibdev_dbg(__dev, format, args...)                       \
+	ibdev_printk(KERN_DEBUG, __dev, format, ##args)
+#else
+__printf(2, 3) __cold
+static inline
+void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
+#endif
+
 union ib_gid {
 	u8	raw[16];
 	struct {
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7bdf98c37e91..8a16c2d498e9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,8 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
+#include <rdma/ib_verbs.h>
+
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
 
@@ -636,6 +638,41 @@ EXPORT_SYMBOL(__dynamic_netdev_dbg);
 
 #endif
 
+#if IS_ENABLED(CONFIG_INFINIBAND)
+
+void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
+			 const struct ib_device *ibdev, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (ibdev && ibdev->dev.parent) {
+		char buf[PREFIX_SIZE];
+
+		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
+				"%s%s %s %s: %pV",
+				dynamic_emit_prefix(descriptor, buf),
+				dev_driver_string(ibdev->dev.parent),
+				dev_name(ibdev->dev.parent),
+				dev_name(&ibdev->dev),
+				&vaf);
+	} else if (ibdev) {
+		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
+	} else {
+		printk(KERN_DEBUG "(NULL ib_device): %pV", &vaf);
+	}
+
+	va_end(args);
+}
+EXPORT_SYMBOL(__dynamic_ibdev_dbg);
+
+#endif
+
 #define DDEBUG_STRING_SIZE 1024
 static __initdata char ddebug_setup_string[DDEBUG_STRING_SIZE];
 
-- 
2.7.4


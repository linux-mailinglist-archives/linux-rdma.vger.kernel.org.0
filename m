Return-Path: <linux-rdma+bounces-8442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B74A55A85
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F083B2D13
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28F27D776;
	Thu,  6 Mar 2025 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="JAg5nyfN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250927C167
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302242; cv=none; b=W8qYdhGvNJCmjkNLNwj9EuNZRhZlWtRtLdnIJCc0qz3tlpeugc9taTCZ0+jDE0Rcskcoev9uXOSXLYL7u8SLIBG4wyRZO2Wpm92MvjI5WnBwUSDgYphBXGvzGrYBnMfF5VKwU8MFIZvQARN8Anih0l2NNzbrM2uH1jGeUgcklHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302242; c=relaxed/simple;
	bh=A9mobOvuIeF00fIfjCqC9uNVWIrG6j7W2+rdHsW6dwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRNj4y1sanPhD2Kzg4dWmUtEzVwihXoeUZfqg6YdhFdo45RcuTq+C1mvHnl2eXMhhhaLTdSM9Iy9X/XptLW2vy8jZFMioQn45HOAWhGTiRqQHUCk1dXg1GfOCqD/2yOpRkA8mnUERgHDhF07DfhRDDv74OfGuMZTuRemrqxqJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=JAg5nyfN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fce04655so6483006d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302239; x=1741907039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdHcT+hSCoYTik958njnGQie2UZi8YbiCIJN/dVy/UQ=;
        b=JAg5nyfN5RaHuEntmBdUUTuczyCp7OYwxGwEeYFUtP4PxZRfWe4epLXmfUtpeNFrmh
         tn5nn65djzlxI93yakBkU+bvlEf1+nRy00RFlSoFP/ZtFxF1m7cnuUz4cIgQy4qruqFs
         s5I15mCxKpf8w1utGm+BrZuaCmTEJgQqQ6Wo10j4GhDjlZ35bZkunem6EI80D/TXMhGN
         fRNyJfZrzJ2+p+VcDUQmk4oEMdgaWjMXhfP3Mtg5DqhiqMH+f930EBOZeSgarB1jTVva
         zKMSCdYjnbms4JQ1WeqDE686761kovjU8tZNJZNrF1wAYqVw7r0gIpUupSxtFTTQ75zE
         865g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302239; x=1741907039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdHcT+hSCoYTik958njnGQie2UZi8YbiCIJN/dVy/UQ=;
        b=HHy4tcgO2ylbR/mtocUKo6J6LHKNMMKxzp9xJKmRdzCF4n27oyhGYBxgK6xwb9rOlY
         KRvY3AEp9TPW3id1CNI9j+ttnTnrC9wi0xWniuE5tG99BxJ3eg7cF1kuI+ycZYxjgSax
         +35GebSI05lDD/HG98tK3XVfv/R4TIZ4XkISgqq8kwEmJH9pO1c4sWvThfHnEqrC+ng+
         2KGgsP0dvaiFHD4Y7H8oMIcnkQI8G24WUTQLQ2bFDL9QPKXPGMFLV2tYlOMjfNYjVV2r
         FIu/vuYG2mnV6xIZBg0WoBbz4QeYvAydIaQomgQsRuAoTXqQU4mbUv92B6FtCPRS3aBx
         9P7w==
X-Forwarded-Encrypted: i=1; AJvYcCW9DnXjVCxClUDLFOltibUTV0AdA8oOt7IRLcix8wf/AhNxz7TZnziaD1yUJLfzPAmmy72+UsqsvzBp@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcUsoOB0Ml6ERj/yuAovAodJX8NehhLjlqakeMD5c13vh9Fan
	Qn2UZXs1DKIlM+csRlC//LndCfEnZe0YJ9WcxFmtgmNF++W8WNzd/ENrg6XRFZ8=
X-Gm-Gg: ASbGnctEe2ktoK09pbeeufRr4ykm2tXtYr1mCFZvbQVE97VsJX09D1yweL8FNTsWOGx
	MAifTI1Q7Bwjl17bNRYp7Py0GFDURc9h/kDWJIz4MWa7IqnUxq85HxwNxORdp8oKQ3RpNA7VeOA
	2g5rPzVOFFVJrfRLsPq4iMMGsdW5P83Dtj8E/3mPDyIFgcyL7JY4mkRmHzKzqbJFFR6IJF/rhJh
	qxMoW67ojR6MP4yWsw4SbfeUawKerHEiiZ2A/22khXRdTcE+l3Yu0PsHSHvPG+7hj96jf2z0dhu
	VQS7PREXs/XikMXIDyzxwAspNixJ7QcJkv4ww+feVND3iF0skN4CHR1ATnEZXMBPxb/3
X-Google-Smtp-Source: AGHT+IF1kfGspX38JaOE5QuV2pL9LaOd4NlYMWkRbiYsvXZp2jxSiWbyI1svMuCu7yxj+68lLI/tfg==
X-Received: by 2002:ad4:5d49:0:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6e9006ba2fbmr13156446d6.45.1741302239103;
        Thu, 06 Mar 2025 15:03:59 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:03:58 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 01/13] drivers: ultraeth: add initial skeleton and kconfig option
Date: Fri,  7 Mar 2025 01:01:51 +0200
Message-ID: <20250306230203.1550314-2-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create drivers/ultraeth/ for the upcoming new Ultra Ethernet driver and add
a new Kconfig option for it.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/Kconfig             |  2 ++
 drivers/Makefile            |  1 +
 drivers/ultraeth/Kconfig    | 11 +++++++++++
 drivers/ultraeth/Makefile   |  3 +++
 drivers/ultraeth/uet_main.c | 19 +++++++++++++++++++
 5 files changed, 36 insertions(+)
 create mode 100644 drivers/ultraeth/Kconfig
 create mode 100644 drivers/ultraeth/Makefile
 create mode 100644 drivers/ultraeth/uet_main.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc62..df3369781d37 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,6 @@ source "drivers/cdx/Kconfig"
 
 source "drivers/dpll/Kconfig"
 
+source "drivers/ultraeth/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 45d1c3e630f7..47848677605a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,3 +195,4 @@ obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 
 obj-$(CONFIG_S390)		+= s390/
+obj-$(CONFIG_ULTRAETH)		+= ultraeth/
diff --git a/drivers/ultraeth/Kconfig b/drivers/ultraeth/Kconfig
new file mode 100644
index 000000000000..a769c6118f2f
--- /dev/null
+++ b/drivers/ultraeth/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config ULTRAETH
+	tristate "Ultra Ethernet core"
+	depends on INET
+	depends on IPV6 || !IPV6
+	select NET_UDP_TUNNEL
+	select GRO_CELLS
+	help
+	  To compile this driver as a module, choose M here: the module
+	  will be called ultraeth.
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
new file mode 100644
index 000000000000..e30373d4b5dc
--- /dev/null
+++ b/drivers/ultraeth/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_ULTRAETH) += ultraeth.o
+
+ultraeth-objs := uet_main.o
diff --git a/drivers/ultraeth/uet_main.c b/drivers/ultraeth/uet_main.c
new file mode 100644
index 000000000000..0d74175fc047
--- /dev/null
+++ b/drivers/ultraeth/uet_main.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+static int __init uet_init(void)
+{
+	return 0;
+}
+
+static void __exit uet_exit(void)
+{
+}
+
+module_init(uet_init);
+module_exit(uet_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ultra Ethernet core");
-- 
2.48.1



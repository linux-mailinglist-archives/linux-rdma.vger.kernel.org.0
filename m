Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1A4D168
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfFTPD6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33287 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbfFTPD5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so5228328edq.0;
        Thu, 20 Jun 2019 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gr+7nXqwNxrdGkUZI7CIuQeL42Jivj1oQYYXtgnd3zs=;
        b=lKk13aGfPL3hNRNnNfuoY+M1M0d+PNFoL1TGrx+ggB23Wkmas2liMoA3ZAkJeK+GPY
         KIszIAf1gVQFg89NoytAQoX2PMP7pfe2UTGF+POF5ChgVpYxY+oMNHd2Cv6Iq9QQehov
         9HZuBu0CzrdoyU0T95BBqZIt5zLHYBYJB6zZm2so9JEx39Ko2R5BhKGJIlL54ynJhkgB
         2UptTuLuRUbdkrc8WrXuQAINPpu+8Q94Lq1PGfGCtZ8175S28X1KWSrvM25Mgj/c65xw
         L+BcsTHb9D02BSVC83XoyrYmd4kBakHuKkxXTUsXcWSdOBrUzvFmYMRg812qOOm7vfM8
         Rpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gr+7nXqwNxrdGkUZI7CIuQeL42Jivj1oQYYXtgnd3zs=;
        b=sIRGpyv7sgMu1grl8PTv7t1u0+4zHdyM2c4vH8QGs9+HXx8oKKa9ALnHEQxeR+wmcI
         scgy2H+ItCpJoONpKLlEEv8kj0X7uTF5Ggxwzn3phj+fr1l5xNmCk4Yki9Wuca7UupHJ
         rELo9CheGXwlGgi1dJue0BvUrsM4/sMOehNvowTzNhD9W8eJuWQtqPOS3YqVQJ7aMFhH
         s2ksR58CwXMn21VTBkyvQfPLOomdKGFeovFAb7dYZSMma7rpB4LjDsez94Xi1GvJqbqe
         7c0Ooh+LcgxmfalAEsRI2j/qgXxGu3eibmbPblnUe6QGSo0Khb8IB4GXEtH9mpRmi+m2
         4KJQ==
X-Gm-Message-State: APjAAAWupt1MOXglueTH7o9zvAwq1ZH2NXqMBTM5ZULo0hKaNR1LlKa5
        +x8RWsLwn6AkyREPTFHXVFJjvVbiQYc=
X-Google-Smtp-Source: APXvYqwINMnCeCqMK1Bt0R+e/68ZV6493lKJ0D+VllNkd8FrnyZc10Zes4xRVSrSDMueFNIPNjnM4w==
X-Received: by 2002:a50:b66f:: with SMTP id c44mr73435971ede.171.1561043035747;
        Thu, 20 Jun 2019 08:03:55 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:55 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 13/25] ibtrs: include client and server modules into kernel compilation
Date:   Thu, 20 Jun 2019 17:03:25 +0200
Message-Id: <20190620150337.7847-14-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

Add IBTRS Makefile, Kconfig and also corresponding lines into upper
layer infiniband/ulp files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/Kconfig            |  1 +
 drivers/infiniband/ulp/Makefile       |  1 +
 drivers/infiniband/ulp/ibtrs/Kconfig  | 22 ++++++++++++++++++++++
 drivers/infiniband/ulp/ibtrs/Makefile | 15 +++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 8ba41cbf1869..1a271ade9997 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -117,6 +117,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
 
 source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
+source "drivers/infiniband/ulp/ibtrs/Kconfig"
 
 source "drivers/infiniband/ulp/opa_vnic/Kconfig"
 
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 437813c7b481..1c4f10dc8d49 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
+obj-$(CONFIG_INFINIBAND_IBTRS)		+= ibtrs/
diff --git a/drivers/infiniband/ulp/ibtrs/Kconfig b/drivers/infiniband/ulp/ibtrs/Kconfig
new file mode 100644
index 000000000000..1f30c88783e6
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INFINIBAND_IBTRS
+	tristate
+	depends on INFINIBAND_ADDR_TRANS
+
+config INFINIBAND_IBTRS_CLIENT
+	tristate "IBTRS client module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_IBTRS
+	help
+	  IBTRS client allows for simplified data transfer and connection
+	  establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
+	  READ/WRITE semantics and provides multipath capabilities.
+
+config INFINIBAND_IBTRS_SERVER
+	tristate "IBTRS server module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_IBTRS
+	help
+	  IBTRS server module processing connection and IO requests received
+	  from the IBTRS client module.
diff --git a/drivers/infiniband/ulp/ibtrs/Makefile b/drivers/infiniband/ulp/ibtrs/Makefile
new file mode 100644
index 000000000000..d2e6cce8f94f
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ibtrs-client-y := ibtrs-clt.o \
+		  ibtrs-clt-stats.o \
+		  ibtrs-clt-sysfs.o
+
+ibtrs-server-y := ibtrs-srv.o \
+		  ibtrs-srv-stats.o \
+		  ibtrs-srv-sysfs.o
+
+ibtrs-core-y := ibtrs.o
+
+obj-$(CONFIG_INFINIBAND_IBTRS)        += ibtrs-core.o
+obj-$(CONFIG_INFINIBAND_IBTRS_CLIENT) += ibtrs-client.o
+obj-$(CONFIG_INFINIBAND_IBTRS_SERVER) += ibtrs-server.o
-- 
2.17.1


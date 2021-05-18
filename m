Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888EB387905
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbhERMmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 08:42:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:53511 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349285AbhERMmN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 08:42:13 -0400
IronPort-SDR: 4FAgMFK7rHv8c1Xxo2/7SUW9dfcyCTXPaV7rRXYpUwjF5mrqQneW3VEYZ/QbVIiLVrDAGQf9zB
 5sD/IbntMhbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="188109671"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="188109671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 05:40:54 -0700
IronPort-SDR: sgggo7ok56IsqNjKGpzCvHMUBi/XmWmxVBdqawlmROTrG0Hvs0QHaEvwXDv+HgO2oh5jBlGM7P
 zk+xuEcfUn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="544093527"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2021 05:40:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5526312F; Tue, 18 May 2021 15:41:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v1 1/1] infiniband: hf1: Use string_upper() instead of open coded variant
Date:   Tue, 18 May 2021 15:41:11 +0300
Message-Id: <20210518124111.20030-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use string_upper() from string helper module instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/efivar.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index c22ab7b5163b..197cbd620662 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -45,7 +45,8 @@
  *
  */
 
-#include <linux/ctype.h>
+#include <linux/string_helpers.h>
+
 #include "efivar.h"
 
 /* GUID for HFI1 variables in EFI */
@@ -154,7 +155,6 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 	char prefix_name[64];
 	char name[64];
 	int result;
-	int i;
 
 	/* create a common prefix */
 	snprintf(prefix_name, sizeof(prefix_name), "%04x:%02x:%02x.%x",
@@ -170,10 +170,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 	 * variable.
 	 */
 	if (result) {
-		/* Converting to uppercase */
-		for (i = 0; prefix_name[i]; i++)
-			if (isalpha(prefix_name[i]))
-				prefix_name[i] = toupper(prefix_name[i]);
+		string_upper(prefix_name, prefix_name);
 		snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
 		result = read_efi_var(name, size, return_data);
 	}
-- 
2.30.2


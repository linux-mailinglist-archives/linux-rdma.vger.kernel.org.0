Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BC41ED7F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhJAMdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 08:33:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:48178 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhJAMdj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Oct 2021 08:33:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225077858"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="225077858"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 05:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="521019943"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2021 05:31:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24FF2B8; Fri,  1 Oct 2021 15:31:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 1/1] infiniband: hf1: Use string_upper() instead of open coded variant
Date:   Fri,  1 Oct 2021 15:31:53 +0300
Message-Id: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use string_upper() from string helper module instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error (Jason)
 drivers/infiniband/hw/hfi1/efivar.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index f275dd1abed8..e8ed05516bf2 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -3,7 +3,9 @@
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
 
-#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/string_helpers.h>
+
 #include "efivar.h"
 
 /* GUID for HFI1 variables in EFI */
@@ -112,7 +114,6 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 	char prefix_name[64];
 	char name[64];
 	int result;
-	int i;
 
 	/* create a common prefix */
 	snprintf(prefix_name, sizeof(prefix_name), "%04x:%02x:%02x.%x",
@@ -128,10 +129,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
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
2.33.0


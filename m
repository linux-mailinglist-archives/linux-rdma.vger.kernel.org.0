Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34AE235225
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Aug 2020 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgHAMZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Aug 2020 08:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHAMYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Aug 2020 08:24:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA247C06179E;
        Sat,  1 Aug 2020 05:24:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c16so13635623ejx.12;
        Sat, 01 Aug 2020 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrhDN2Qf8+lE/P1EU/TJXEXFld12zPt7dPQFf412LUk=;
        b=TPXE0MeFmNEeYfTarS0h6lEu6T0txCu1b9KgvIqoPjxSgbUjX4ba/CalHwh+XNV9EE
         zlXi4oKFUnZZ5zVHu3WsUdEEvPp6L05on/HWX3VkVM77SKuj2FlpD86dH5NZ0QEzjtTg
         K6Nhr9ENw+lKNFgRQijLjk+mW5c0pk5ZeQxpTHze7A4BQdrPzxltjjv/Vjb6Z0Aox8Ed
         VEDJwMbimBqhxR0PWwCryl7i42bAF/Lj23OoFongQc7qaNfxcZ19cdJVnPclf3scGhyn
         SuPxs1q4uD+8x4GNtXQxh8OWpVwFNMLSH/5l5QbhWZdIK8bLxs9GcQ3rDUmnwv4+7V1h
         dxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrhDN2Qf8+lE/P1EU/TJXEXFld12zPt7dPQFf412LUk=;
        b=B568GJ76mBI7AaPi6AiwVC4s176YHNnwnHUjQD6HvaBRnTpC3wTJK7/c7hkD2WOecy
         mbEDrGEnW5grXQuMAEpA0Plwsymfi0+bRE+Poc9ggYyqf26N0sXAjJcJtiIvgmBEILl/
         gaFxOWLK9kIpPzrMEU7FeC14bSGpdxkH5oPb4S3sz8sJuxgo860UfhUSFuGJLxf3FDbM
         5YBUPkiqY2nrNCsryhFJioiPCOlkdkRvnkH76GiUTAnQ9bwVpbJoAwTD/yX1z4eBLv7b
         9EMJFQ+UrGJTPe0zqR5S2Zl4bNqerwlHq3TetrT6+p2tWCtVUtE7QllIHF6lr1pIm/wz
         24jA==
X-Gm-Message-State: AOAM530fqa3GVkqrzmmwwox6mX9wVLxjdLtv1VDC2rZTvhMct9/CVDyI
        8frxfd8F9BM8vmszEUdH/Pk=
X-Google-Smtp-Source: ABdhPJwCqcTSSFI7x9YZQM/IwvnR14OpHVv8jfwf8XU/U7ZA+HW+nlMkfVJ1UJTfn+AVXi9rMi5gOw==
X-Received: by 2002:a17:906:3616:: with SMTP id q22mr8872560ejb.79.1596284682629;
        Sat, 01 Aug 2020 05:24:42 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:42 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [RFC PATCH 14/17] IB: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:43 +0200
Message-Id: <20200801112446.149549-15-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/infiniband/hw/hfi1/pcie.c         | 38 +++++++++++------------
 drivers/infiniband/hw/mthca/mthca_reset.c | 19 ++++++------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 1a6268d61977..11cf7dde873d 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -392,24 +392,24 @@ int restore_pci_variables(struct hfi1_devdata *dd)
 /* Save BARs and command to rewrite after device reset */
 int save_pci_variables(struct hfi1_devdata *dd)
 {
-	int ret = 0;
+	int ret = -ENODEV;
 
-	ret = pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_0,
+	pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_0,
 				    &dd->pcibar0);
-	if (ret)
+	if (dd->pcibar0 == (u32)~0)
 		goto error;
 
-	ret = pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_1,
+	pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_1,
 				    &dd->pcibar1);
-	if (ret)
+	if (dd->pcibar1 == (u32)~0)
 		goto error;
 
-	ret = pci_read_config_dword(dd->pcidev, PCI_ROM_ADDRESS, &dd->pci_rom);
-	if (ret)
+	pci_read_config_dword(dd->pcidev, PCI_ROM_ADDRESS, &dd->pci_rom);
+	if (dd->pci_rom == (u32)~0)
 		goto error;
 
-	ret = pci_read_config_word(dd->pcidev, PCI_COMMAND, &dd->pci_command);
-	if (ret)
+	pci_read_config_word(dd->pcidev, PCI_COMMAND, &dd->pci_command);
+	if (dd->pci_command == (u16)~0)
 		goto error;
 
 	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_DEVCTL,
@@ -427,14 +427,14 @@ int save_pci_variables(struct hfi1_devdata *dd)
 	if (ret)
 		goto error;
 
-	ret = pci_read_config_dword(dd->pcidev, PCI_CFG_MSIX0, &dd->pci_msix0);
-	if (ret)
+	pci_read_config_dword(dd->pcidev, PCI_CFG_MSIX0, &dd->pci_msix0);
+	if (dd->pci_command == (u32)~0)
 		goto error;
 
 	if (pci_find_ext_capability(dd->pcidev, PCI_EXT_CAP_ID_TPH)) {
-		ret = pci_read_config_dword(dd->pcidev, PCIE_CFG_TPH2,
+		pci_read_config_dword(dd->pcidev, PCIE_CFG_TPH2,
 					    &dd->pci_tph2);
-		if (ret)
+		if (dd->pci_tph2 == (u32)~0)
 			goto error;
 	}
 	return 0;
@@ -783,9 +783,9 @@ static int load_eq_table(struct hfi1_devdata *dd, const u8 eq[11][3], u8 fs,
 		pci_write_config_dword(pdev, PCIE_CFG_REG_PL102,
 				       eq_value(c_minus1, c0, c_plus1));
 		/* check if these coefficients violate EQ rules */
-		ret = pci_read_config_dword(dd->pcidev,
+		pci_read_config_dword(dd->pcidev,
 					    PCIE_CFG_REG_PL105, &violation);
-		if (ret) {
+		if (violation == (32)~0) {
 			dd_dev_err(dd, "Unable to read from PCI config\n");
 			hit_error = 1;
 			break;
@@ -1322,8 +1322,8 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	/* step 10: decide what to do next */
 
 	/* check if we can read PCI space */
-	ret = pci_read_config_word(dd->pcidev, PCI_VENDOR_ID, &vendor);
-	if (ret) {
+	pci_read_config_word(dd->pcidev, PCI_VENDOR_ID, &vendor);
+	if (vendor == (u16)~0) {
 		dd_dev_info(dd,
 			    "%s: read of VendorID failed after SBR, err %d\n",
 			    __func__, ret);
@@ -1376,8 +1376,8 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	setextled(dd, 0);
 
 	/* check for any per-lane errors */
-	ret = pci_read_config_dword(dd->pcidev, PCIE_CFG_SPCIE2, &reg32);
-	if (ret) {
+	pci_read_config_dword(dd->pcidev, PCIE_CFG_SPCIE2, &reg32);
+	if (reg32 == (u32)~0) {
 		dd_dev_err(dd, "Unable to read from PCI config\n");
 		return_error = 1;
 		goto done;
diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
index 2a6979e4ae1c..5f09d5312472 100644
--- a/drivers/infiniband/hw/mthca/mthca_reset.c
+++ b/drivers/infiniband/hw/mthca/mthca_reset.c
@@ -102,7 +102,10 @@ int mthca_reset(struct mthca_dev *mdev)
 	for (i = 0; i < 64; ++i) {
 		if (i == 22 || i == 23)
 			continue;
-		if (pci_read_config_dword(mdev->pdev, i * 4, hca_header + i)) {
+
+		pci_read_config_dword(mdev->pdev, i * 4,
+						hca_header + i);
+		if (*(hca_header + i) == (u32)~0) {
 			err = -ENODEV;
 			mthca_err(mdev, "Couldn't save HCA "
 				  "PCI header, aborting.\n");
@@ -123,7 +126,10 @@ int mthca_reset(struct mthca_dev *mdev)
 		for (i = 0; i < 64; ++i) {
 			if (i == 22 || i == 23)
 				continue;
-			if (pci_read_config_dword(bridge, i * 4, bridge_header + i)) {
+
+			pci_read_config_dword(bridge, i * 4,
+							bridge_header + i);
+			if (*(bridge_header + i) == (u32)~0) {
 				err = -ENODEV;
 				mthca_err(mdev, "Couldn't save HCA bridge "
 					  "PCI header, aborting.\n");
@@ -164,13 +170,8 @@ int mthca_reset(struct mthca_dev *mdev)
 		int c = 0;
 
 		for (c = 0; c < 100; ++c) {
-			if (pci_read_config_dword(bridge ? bridge : mdev->pdev, 0, &v)) {
-				err = -ENODEV;
-				mthca_err(mdev, "Couldn't access HCA after reset, "
-					  "aborting.\n");
-				goto free_bh;
-			}
-
+			pci_read_config_dword(bridge ? bridge : mdev->pdev, 0,
+									&v);
 			if (v != 0xffffffff)
 				goto good;
 
-- 
2.18.4


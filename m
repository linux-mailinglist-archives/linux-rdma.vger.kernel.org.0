Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706C41F9184
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgFOIc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgFOIc0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 04:32:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AAC061A0E;
        Mon, 15 Jun 2020 01:32:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so16111718wrr.10;
        Mon, 15 Jun 2020 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3aQ/PgWjHRbwdP69pQYwDMstdmD8+pp4wlXRjxHodA=;
        b=aWZbMGLUyNSKzVZstBGG6z7eZvsz5piuZ/f5umAvnUxKhZ6nIDYzliFDXW/+/OTPeI
         2M3ceHFBb6iwy4Sy6pX/0g9ulNbfXBurcKzZnP2EzOdN1Dn/M0gl05Jwr4kfI3J+2N2k
         deCpdOEVmzl1DNjiIVxxMtdJ/kW+mTuwyMAV4FOueKp6VcLLqdPksLhluyTT/s+/LZsw
         kIRVCtVMPiyev+RINHxAAsDQn19VURIjwvOTVHxJDIEqGWHjIWUAMFigBMy37F7RtNHO
         jWhOzopPPl5yj/BSsC+uj1YQCvrEpgc9GztXPO4j48eCM5ZGmcxcUVtCZgmu6y4QQZd2
         eIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d3aQ/PgWjHRbwdP69pQYwDMstdmD8+pp4wlXRjxHodA=;
        b=icuYWSnmJI5MhiCLUPk2ZYMJpdXQLBS+iWb/w/iuJrv/BSOqyShEK5q4LTuS6cpftl
         KYXr3J/J2+guEnOxl7UIzDB9TfX7xOREmgxM6XPBg1haa4cLu/nPxm/Zucbyw5VJi0W3
         XK8UfY7M6Z29Qx0GZ/P2+txOA3QV5MHivxPM8js544TtJ5IzBl5mMuYHCIA/kJPU7ohC
         4Lk3jTLFDh7GAOi/O7OV3B4Qoddc0hdMCisvnsbxbQhnPm6wEtWhdw7GeNtqZz0921Nt
         +HLADuo4cdk2XGHoEheIfNgeCZg7eR5l/hBslLlu869JAgFmpz3MyVpXMSFIFosiL6N7
         Le1g==
X-Gm-Message-State: AOAM532L8M/62CQNn+Ja1ua1OnSEuM0Jz8tGnhzZxMyeINftUByilZMK
        ADcy7TiGlsCtSBOoFfxqbrY=
X-Google-Smtp-Source: ABdhPJw3IaYVJt7P8aT+wywoWLCu1BN+hwGNrjLmTa8ClloFJ7Il32qviKwMUw1SM4b7jQFKmJZSzw==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr27238053wrs.123.1592209945027;
        Mon, 15 Jun 2020 01:32:25 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:24 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:20 +0200
Message-Id: <20200615073225.24061-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

restore_pci_variables() and save_pci_variables() return PCIBIOS_ error
codes from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Fix redundant initialisation.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 1a6268d61977..2a45f34ac6c8 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -334,10 +334,14 @@ int pcie_speeds(struct hfi1_devdata *dd)
 	return 0;
 }
 
-/* restore command and BARs after a reset has wiped them out */
+/**
+ * Restore command and BARs after a reset has wiped them out
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
 int restore_pci_variables(struct hfi1_devdata *dd)
 {
-	int ret = 0;
+	int ret;
 
 	ret = pci_write_config_word(dd->pcidev, PCI_COMMAND, dd->pci_command);
 	if (ret)
@@ -386,13 +390,17 @@ int restore_pci_variables(struct hfi1_devdata *dd)
 
 error:
 	dd_dev_err(dd, "Unable to write to PCI config\n");
-	return ret;
+	return pcibios_err_to_errno(ret);
 }
 
-/* Save BARs and command to rewrite after device reset */
+/**
+ * Save BARs and command to rewrite after device reset
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
 int save_pci_variables(struct hfi1_devdata *dd)
 {
-	int ret = 0;
+	int ret;
 
 	ret = pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_0,
 				    &dd->pcibar0);
@@ -441,7 +449,7 @@ int save_pci_variables(struct hfi1_devdata *dd)
 
 error:
 	dd_dev_err(dd, "Unable to read from PCI config\n");
-	return ret;
+	return pcibios_err_to_errno(ret);
 }
 
 /*
-- 
2.18.2


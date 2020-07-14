Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5721ED99
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGNKEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKEf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 06:04:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E82C061755;
        Tue, 14 Jul 2020 03:04:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so728223ejj.10;
        Tue, 14 Jul 2020 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMKbSEl+TSwwECHcG9VnO2R6z/5zU0sZpPUGSBe9CVI=;
        b=VhMkyJCc+Ub0Mlz/veOdOjCD70CzW+qNp9KM0xawUl4zbqa4ZnNKGxddnev15er0ru
         Su7pl3xeo8u1djqLQfWwT+CefBtYCAyvY14CgksDgSXDqSIj/8PH4HUgqp9ViEDKF+kK
         bHYUTq+xQcdBaljJ40HNq71TKiTqJ/3GB0euhCsxmeiWFKvBy29FnZUc62aJ9+Zu3GJj
         25iqFmUnXxhK3AexMaqjMUttk9KzZKKvqUW0cB3cc/MQeN9DL3uFn0Xg5ll6xyysHm9C
         HNtvnPq4pVlVKl4bfERgc9XXMieiWWlYK1VFx08RIkVcfY1GD06438NPaqbMsKJMNMmi
         dPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMKbSEl+TSwwECHcG9VnO2R6z/5zU0sZpPUGSBe9CVI=;
        b=BwnFmXN4xhMUgxmLbz4gy4ccBK7EgDE9YpJdSl9C/XqlJs2kf2+ohmhtgn0CeYKrbB
         1cFloI/MKM5e++xoUGlXHOcu2X8l15+ERDQsa/EsneaQ2LPWIPGc9B0jpGNIUPENQ3cn
         QdE1YP6uhPRhTCB8WNaucaD/kWHgkQKArIBlvdyVrnZzDusGN3thBlfIhuQlDbS6Ufnq
         qQG6wHLKoWdJFcr1ilxo+FAuKYrXs792us1WfPV93wnMRCjlf+HE3paaKni7nn8iIpp7
         Uh47B5wEnNGXIA5PL3E3S/bZkNH4QjLiZvZRL1kYP/RUpNENFlPiPFtuKca9JpBheLtv
         Bjhw==
X-Gm-Message-State: AOAM530n+R3LID3rU3G/WvcKkSMhesfGHgqT650YBYRU7jCpSKV695e2
        dVLdqqPvmV1zEloBM1cn7iU=
X-Google-Smtp-Source: ABdhPJwucgF3GRDOzOtGpASqDtOayCAxkkAolx9Zcs/9pzfdhZ8Vr81ft8NDuUFEr7wkKLkv2Z7gJQ==
X-Received: by 2002:a17:906:38da:: with SMTP id r26mr3618268ejd.120.1594721074231;
        Tue, 14 Jul 2020 03:04:34 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id bs18sm14137672edb.38.2020.07.14.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:04:33 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-rdma@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/14 v4] IB/hfi1: Check the return value of pcie_capability_read_*()
Date:   Tue, 14 Jul 2020 13:04:43 +0200
Message-Id: <20200714110445.32605-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200714110445.32605-1-refactormyself@gmail.com>
References: <20200714110445.32605-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0. In this case dn and up will be 0, so aspm_hw_l1_supported()
will return false.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x). So with
dn and up being 0x02, a true value is return when the read has actually
failed.

This bug can be avoided if the return value of pcie_capability_read_dword
is checked to confirm success. The behaviour of the function remains
intact.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
v4 changes:
Remove unnecessary boolean conversion.

 drivers/infiniband/hw/hfi1/aspm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index a3c53be4072c..80d0b3edd983 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -24,6 +24,7 @@ static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
 {
 	struct pci_dev *parent = dd->pcidev->bus->self;
 	u32 up, dn;
+	int ret_up, ret_dn;
 
 	/*
 	 * If the driver does not have access to the upstream component,
@@ -32,14 +33,14 @@ static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
 	if (!parent)
 		return false;
 
-	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
+	ret_dn = pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
 	dn = ASPM_L1_SUPPORTED(dn);
 
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
+	ret_up = pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
 	up = ASPM_L1_SUPPORTED(up);
 
 	/* ASPM works on A-step but is reported as not supported */
-	return (!!dn || is_ax(dd)) && !!up;
+	return ret_dn && ret_up && (dn || is_ax(dd)) && up;
 }
 
 /* Set L1 entrance latency for slower entry to L1 */
-- 
2.18.2


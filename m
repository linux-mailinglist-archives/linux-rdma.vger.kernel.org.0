Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B30234516
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbgGaMCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 08:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbgGaMCT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 08:02:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E9DC061574;
        Fri, 31 Jul 2020 05:02:19 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so16336192edx.8;
        Fri, 31 Jul 2020 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amVhr7R4Tl+AZRhIhKHpLA6uHviyCSc4sbl+N98Jdpg=;
        b=JcMW1AmzuSS8oG65Inbid1bJUW/hbncZI7QS2d5UfMrtraGXnzfDKeDWUDIhuDP/6T
         a5oy1TmPN7ZBWRpPUELAvSc5ujNSi1+DihJnVMqL9vW2Zx+Gqyawvb1ZEH1Jfv3gEIrJ
         Lb33FgO9+8s5fiMLgtNRSIsBQ/8O1duwSGT7dVS7uZoRDhjo39sJfhzJWtn4xdYsjJ2u
         Ap3vuoboz/YeojnQZcGlmicmKam1fnTIigSdb5tkXlt1czDa2nbdWRmVzLSyOYzUiz0Q
         HEQsp232s4YkFDK8tN4PaxGlzYevBgaH5JeG75wkyNZjaVXbkGPtcdIWaK1VnBc5/gUK
         kRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amVhr7R4Tl+AZRhIhKHpLA6uHviyCSc4sbl+N98Jdpg=;
        b=DspcxHkPfmfOZ5+wRVzzP3+uwFaeS/X7NMqCQKlIvFR0iXTeWRTNLqloD8mB/VgNzx
         8PWCxAjXL9YmuIcaGdPLV05LAf8RrDiw19ybmO57vC6jq5Ych2Uc30oevaZJdkaXuAfA
         17n7x2rbvvUO+oniTpsaOwTPQAtfPLZozKWgux8bxTAx7LCwIUXBrmxWeRz95L7G7G7y
         rrvR2BFP89IgMl66bjc2FORjZS4Xh7r8yLezEmi/2BcxaJ43VhlEO9ni9hNyBoX9uzDQ
         bKXgpqzdL8viiNB3hOGqjXf//Oego4Gr5avNoOWLO5BgK2rIpiTB8RWUF0pRtCbRGK2T
         PMFA==
X-Gm-Message-State: AOAM533ExnG7rzIow8/Vd7aWCLHtKLo+OY15WcCo91NEUjYHTSvX50z2
        dv8RVyOxq5JsgppEs4S3pfY=
X-Google-Smtp-Source: ABdhPJxxcaYV0fL7ANNAzpxeHZXM0MM7VCpGGNBUD6uol8RNcQxADNTtg7/dBuH2xZETfFkTuu3WUQ==
X-Received: by 2002:aa7:ce90:: with SMTP id y16mr3597463edv.325.1596196938310;
        Fri, 31 Jul 2020 05:02:18 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id j5sm9091734ejk.87.2020.07.31.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:02:17 -0700 (PDT)
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
Subject: [PATCH v4 01/12] IB/hfi1: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:02:29 +0200
Message-Id: <20200731110240.98326-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731110240.98326-1-refactormyself@gmail.com>
References: <20200731110240.98326-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0. In this case dn and up will be 0, so aspm_hw_l1_supported()
will return false.
However, with Patch 12/12, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x). So
with dn and up being 0x02, a true value is return when the read has
actually failed.

Since, the value ~0 is invalid here,

Reset dn and up to 0 when a value of ~0 is read into them, this
ensures false is returned on failure in this case.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---

 drivers/infiniband/hw/hfi1/aspm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index a3c53be4072c..9605b2145d19 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -33,13 +33,13 @@ static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
 		return false;
 
 	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
-	dn = ASPM_L1_SUPPORTED(dn);
+	dn = (dn == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(dn);
 
 	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
-	up = ASPM_L1_SUPPORTED(up);
+	up = (up == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(up);
 
 	/* ASPM works on A-step but is reported as not supported */
-	return (!!dn || is_ax(dd)) && !!up;
+	return (dn || is_ax(dd)) && up;
 }
 
 /* Set L1 entrance latency for slower entry to L1 */
-- 
2.18.4


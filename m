Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F221DDFC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgGMQzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jul 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgGMQzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jul 2020 12:55:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D900C061755;
        Mon, 13 Jul 2020 09:55:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so14278600edr.5;
        Mon, 13 Jul 2020 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TkNyGhVGg6gVUCzpTd9OAFstGgg/MKOfxToRs2GSfBQ=;
        b=On/rLQmicINxtBadu57xIG7YClMaLhAuYyqGOWK0VWZeuVm3nzNHkYxBhM7+pqw2M+
         7m8Q1icCJMMhuHmHo3kSwPbHgZGXy0UiwvZD12pqIzpd2CDKU57S8LCMyEP3yURnJjfv
         myqn7MQi0idmjaLsLHcssx7seM009f8dFGz8gWyiVZqcD5qUm8elVVT7gu1QW1s/6bdk
         rm4q6KVqW3pAYu0Ss9kPbeBtHzXqspcsRxr6CuQxPyzrSlfShcDamTPe84b80t9/oIvn
         OMkyMrn+y8k4CWVQwg9NyLJXhVSIgNXPEAHc3gYjxrjtcgTYGQ0bXgJvnCKrobicfPUG
         39jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TkNyGhVGg6gVUCzpTd9OAFstGgg/MKOfxToRs2GSfBQ=;
        b=Pcxh4gt953w085I4EhztjO3sAAIW0aIRgG6hJw6EzaATRC1x2z+d+opuCDPlGxR6vx
         os/42eVgucHxsXtMJJ3lFLQT1wJ5QU1I+6tYq0YIWRAnFSeZ718cvuMvBWzfSqNZADP3
         fvGmvGx/VsmDqzu85nzH4wi0v+VdLVQjH6T4UBjgODCkV2gjeTXf8mQN+8km5qnJOG5C
         8TykKVjqmMm8krTi3UjgsCAMGXgKWpZUh1DUEmNPqKWZl58QSiwRy8d3MeXafrM0PmQD
         XgUPDdRME9+39t0nUVRTXg7kRGAkSfi3IfRnt1CS9V3GRumwAj82sNNhnFQRDFyawb+v
         3cxQ==
X-Gm-Message-State: AOAM530vE6cvyMnVHcePXAbYny3PPM094iDhdD37sHbpoo+qfbCZDwkt
        QhYHnRqlEZF6NZt7j2tqHHM=
X-Google-Smtp-Source: ABdhPJyMCnsUp9Wj1A7Ygk/lw7FDwznI2xdPP4+uz9bNiAb1owWHZffQG+VupT2yXc4MjZgCEMmQVA==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr340801edr.86.1594659310905;
        Mon, 13 Jul 2020 09:55:10 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id w3sm11838938edq.65.2020.07.13.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:55:10 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     skhan@linuxfoundation.org, linux-rdma@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Subject: [PATCH 1/14 v3] IB/hfi1: Check the return value of pcie_capability_read_*()
Date:   Mon, 13 Jul 2020 19:55:25 +0200
Message-Id: <20200713175529.29715-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
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
+	return !!ret_dn && !!ret_up && (!!dn || is_ax(dd)) && !!up;
 }
 
 /* Set L1 entrance latency for slower entry to L1 */
-- 
2.18.2


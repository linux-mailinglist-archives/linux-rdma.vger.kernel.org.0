Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582EB1F9188
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFOIcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOIcX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 04:32:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AEEC061A0E;
        Mon, 15 Jun 2020 01:32:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so16157333wrt.5;
        Mon, 15 Jun 2020 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E7c3us/Xdo7gpPBkK7+mW2slrEL0thvCYN6BbFEa5oU=;
        b=RAHhr86L5TxO7qa82JTPVxEl0mGBrpvxFjlmM+EiQBZhgH8Nw+TSXs48wV3k2C82Hh
         BczCJeydJaFzprQ/NO832n8R5X8noWsFYYXOzXlZ84QG/GqRYDEjiNT7QQ6FUq5FHWsV
         HtDu0Vioe3hbYRYGV59vkpy83ObtztOEPSk3z5f6OJjW+UJS/v4ukLWGsMKO2drC7afQ
         cVCG7WZPaeJ6p9V4NJ2xZiHwzaCkGt9C5EZu1PWjn4mZWeOP+wYD+BFoMFkt0FWIG0TT
         bkN8+cgiXoLZaG+KLmISc0zVjoAs14x8B9AKHJgTwj/sj38ohGe6QyuU4z9Ugx3Qtvy3
         Lo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E7c3us/Xdo7gpPBkK7+mW2slrEL0thvCYN6BbFEa5oU=;
        b=byHb+p2Ae/9CLZPz9pn+MUPfyhhMVRrXltbWSF9ZJvZYYP2YP7y30oFMPBCXCZ33W1
         stk8PKYQwxMXWNBoYIwKhqmBR6LvsI3Z3NLcvNOukCBxt+jOJ/OCOXT7hxFRGBda3QEB
         V6Ba3lCgCizfv5wZ3TFZNNtKrr0845pm7dBw7CIiGNx2gA0ZrRUjL9SElsEggFBocnED
         0qYCjyL+btdUoHhZ4+UO0IX/oFz81eb0NbsDSA91mRO0KmXfnIAaDnwLVNOk1JC9EPq+
         xDvBtN39Gq+Rkn54QyixzhuSoLo1pyX43iECM6vWxeGFE85EKDlOWM7gFdekY/HG3G0p
         Ec6g==
X-Gm-Message-State: AOAM531AYvbEuYDFBqUBB1E8R126CXhl630TuKvY9hn6hkbafK4t/7vH
        o4Zaakzp+o7KZFkp6D96leE=
X-Google-Smtp-Source: ABdhPJyC/eAZEu3qZ+O+V+6SdJaepuhbRuoOUAqjH0NTA1yqfiGMIBoQbTQ/8Q8bouEQaYl+z8yCpw==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr29018002wru.95.1592209941717;
        Mon, 15 Jun 2020 01:32:21 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:21 -0700 (PDT)
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
Subject: [PATCH v2 2/8] IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:19 +0200
Message-Id: <20200615073225.24061-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pcie_speeds() returns PCIBIOS_ error codes from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 1a6268d61977..eb53781d0c6a 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -306,7 +306,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
 	ret = pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &linkcap);
 	if (ret) {
 		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB) {
-- 
2.18.2


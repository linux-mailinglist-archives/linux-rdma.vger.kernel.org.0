Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852372D06FD
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Dec 2020 20:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLFTwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Dec 2020 14:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgLFTwP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Dec 2020 14:52:15 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DAC0613D0;
        Sun,  6 Dec 2020 11:51:35 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v1so6121051pjr.2;
        Sun, 06 Dec 2020 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fd5P7q0rI4oDoc+47wcHKFhpJRqmuT+fxaUAHCBA4oA=;
        b=aQEYGzFX4rTSAZVOV1fMGZBro9GuSiCt2y0iLKiTuFABXuQS+pBn5Z7SrLjJh+0Lht
         l1vCCPaPT5LssevzCOVWsiOUqJA6805amZ4sKNCV/12XNpZIhNBByyRj1Q7qPCwqRWhQ
         8xkdkbflYPLx/FdB4lciRI4inpr3DP6twb5lcngjITT5H861RcDq7RFow133gD1xwKmy
         RtQkxVpU6xJPCkCJImI25iz0BBQD+YpUbxGKgVofGR9TablVv46gLqhz3zi27NebixK5
         QwFrDldH+qV2hZgNZURgIblo9ruYtifMDcqtc9B61tg1sM03uN1MJ6MtRbMSnssU1wn1
         8r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fd5P7q0rI4oDoc+47wcHKFhpJRqmuT+fxaUAHCBA4oA=;
        b=ABQsfbK4nHBCBzLbqiDLpiN/uzYruU1IFzfJiWqwy9x0hllQsrpntRw+daLeabAM2C
         tbHo0TTnAkgmAvP7ZNvrsHEc4EN5H6uQYbl7NdPxiYR2rcO7weWC2HTqfIQY1XHpmPBb
         t+u781nWM89vkjN/AYIJw7flqNT9swGHzpT15wCWDXN+qc7ljn6IBOxbK8vvat1nkViN
         6WPaKQyE2T1dGLBq+NFncjLUVbGg3MH5GNekcSzHLsbRW3420BZx3fsmC0G6IbdoYu+z
         H8EtsbIeuSNda4UdcotOXJSYC5DUeRSkr3XHLEGcAR/7TDsWwL++0cKYrO0WGFYBvsDj
         lokQ==
X-Gm-Message-State: AOAM530pXX028KelWEiGj04IQ7c7+7ioizoKNIx0Qkb8QuSfcp6VD71t
        nikjpy+crYtwyKuFlA7zdhs=
X-Google-Smtp-Source: ABdhPJzPs6oJqrasesO4k/CwvX7Yvh8LCKDdokLNNL1brp7OQ83D7vxznagJ4YTQlnHSJ7o9NsDlCw==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr13315860pjy.64.1607284294612;
        Sun, 06 Dec 2020 11:51:34 -0800 (PST)
Received: from localhost.localdomain ([124.253.53.149])
        by smtp.googlemail.com with ESMTPSA id v22sm11244239pff.48.2020.12.06.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:51:33 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        bjorn@helgaas.com, linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH] drivers: infiniband: save return value of pci_find_capability() in u8
Date:   Mon,  7 Dec 2020 01:21:20 +0530
Message-Id: <20201206195120.18413-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callers of pci_find_capability should save the return value in u8.
change type of variables from int to u8 to match the specification.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/infiniband/hw/mthca/mthca_reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
index 2a6979e4ae1c..1b6ec870bd47 100644
--- a/drivers/infiniband/hw/mthca/mthca_reset.c
+++ b/drivers/infiniband/hw/mthca/mthca_reset.c
@@ -45,9 +45,9 @@ int mthca_reset(struct mthca_dev *mdev)
 	u32 *hca_header    = NULL;
 	u32 *bridge_header = NULL;
 	struct pci_dev *bridge = NULL;
-	int bridge_pcix_cap = 0;
+	u8 bridge_pcix_cap = 0;
 	int hca_pcie_cap = 0;
-	int hca_pcix_cap = 0;
+	u8 hca_pcix_cap = 0;
 
 	u16 devctl;
 	u16 linkctl;
-- 
2.27.0


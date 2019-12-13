Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74D611DAF3
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2019 01:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfLMALc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 19:11:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45791 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbfLMALc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 19:11:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id bc8so378477plb.12
        for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2019 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Pd7GfhuUEHJZyG7XGzIe2UpFrPycUVkSSTmNupOIeC4=;
        b=hdyXdhgs3C5VDni3JTL3oqICCy8sXPNZRcfGRPW64b6uE9svSqesYtaqTue5KPGmVX
         HS/Zo6qzuGCh0EbVkil4fz5EfC3eiURBwkVEGLnsgttb1ZkNgN4sqqFrYPTurc3BEP1K
         UJ3ZTwXjIDZ97hVCII0xkaiMlG9nmq8tPeXDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pd7GfhuUEHJZyG7XGzIe2UpFrPycUVkSSTmNupOIeC4=;
        b=cTzk+jylDDDOJFPQvZlKhU30WrhRf4IvJxDALc7WTHpLk+cyjFpPIqUlDNsRsCcE+A
         /umPaaI8UhsOn1M9eujJWd0Jcs7nWkQzpAaR+2m/s1V8uuzDT+d7fAcFqTnylCRvZ+3Y
         qrcj+lrWILDFHr9v7nuZG9CVBjD/1W9tFGvncHEFKB0+C4ldcqHLDGCihh59eVLIQGmw
         MVI8oC3hT3XPwMIj3S0PdP11jvPe5h2om6kJ28wO1PiK0v43u1Ef+mz7Rvol4vL5/pWq
         qwveguuUSbkIurrLkqGG825DBK7N4bFH/nbKtirIq89MLv2frceccXG78BgUxuMwox6S
         3wCA==
X-Gm-Message-State: APjAAAXg1RXjiT9PakFCY2Zt0nC9nwpaeTrY0hOYQ+HZVMlCsAcD/PC2
        n61U+NP7DP61lSA9VyYwGYMDRQ==
X-Google-Smtp-Source: APXvYqwgyEYZ1f9G6YcS2hIlmZ4ZtPRC3P/H4yYOBzAwxvz5JYD1jZmXNXXZMGrzei5rLzk1LWUI3Q==
X-Received: by 2002:a17:90a:ff12:: with SMTP id ce18mr13208040pjb.117.1576195891651;
        Thu, 12 Dec 2019 16:11:31 -0800 (PST)
Received: from dev-psajeepa.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id s18sm8081281pfh.47.2019.12.12.16.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Dec 2019 16:11:30 -0800 (PST)
From:   Prabhath Sajeepa <psajeepa@purestorage.com>
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roland@purestorage.com, psajeepa@purestorage.com
Subject: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
Date:   Thu, 12 Dec 2019 17:11:29 -0700
Message-Id: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP. But the
fix did not cover the case when a call to ib_post_send fails and index
to track outstanding WRs need to be updated correctly.

Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
---
 drivers/infiniband/hw/mlx5/gsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index ac4d8d1..1ae6fd9 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -507,8 +507,7 @@ int mlx5_ib_gsi_post_send(struct ib_qp *qp, const struct ib_send_wr *wr,
 		ret = ib_post_send(tx_qp, &cur_wr.wr, bad_wr);
 		if (ret) {
 			/* Undo the effect of adding the outstanding wr */
-			gsi->outstanding_pi = (gsi->outstanding_pi - 1) %
-					      gsi->cap.max_send_wr;
+			gsi->outstanding_pi--;
 			goto err;
 		}
 		spin_unlock_irqrestore(&gsi->lock, flags);
-- 
2.7.4


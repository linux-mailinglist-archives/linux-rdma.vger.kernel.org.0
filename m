Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662DD1028A5
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfKSPtX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 10:49:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39812 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfKSPtX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 10:49:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so11964371plk.6
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1ASv1uSb+2yAWLsBi9prViTqXk/F+FbyHZh9azDYUs=;
        b=KmIdMaUIOmsh/2p0FfLb2LJw2+OlcwZkj3j0hg5kPRFq7pUA+7qjK3Ifr9tGXbWb2+
         lEbxqs4jGaLwemeAKUN8MtDtG0gWP3NzKsxGB5A3Swf5u4yiRBhftJYhXvmwksSgMSVN
         8sSMZGdkOrqwheUaBnYGH72AVRmzmOf6DmY+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1ASv1uSb+2yAWLsBi9prViTqXk/F+FbyHZh9azDYUs=;
        b=Xb6ddHOP3qELhHoM0qAxxx33FQGNGTfNWGg/1J/R6SF7WQU8pZKD18NpC8gFck3jTN
         pn6OnN9dSlnqV+6pRrEJ/aEGl11Lf5Ue8kY/TKXQC0fHzosTdSukzwiyAq035e/wXTAy
         W3n+1EcIvEpcmNuVefZylR6i+Kxrb/MIeI/UI1RCWiDSbtOQCoR7KGo+dhQ0/x31omZC
         H0KcfkJ8KmAwLhAQupznQ/O7joeWZL6TAroyb+kNdNGGPbG5h+MZPUJ26m4E3eipZ06q
         tIvOBfF5GEp4xpmTTKfxRP0/hHanO/5P/c8SLDEjLuKzFO4H13sIEA8qIs2kMInrsZhc
         dPBA==
X-Gm-Message-State: APjAAAUTOloMWAwfDNUQIQEVDB9SHoJa5e5NI9fn8+leZXWG0aD60GZg
        kp8OFS83bRllE5ijymg2yBgcXw==
X-Google-Smtp-Source: APXvYqwCWgnFbtPr+WOkyXtw/lhlKpeNAJXk+LGQlqjvK15orBeEtuOLcD/iLFaWFiYSEccs8w+k0w==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr36314522pls.169.1574178562849;
        Tue, 19 Nov 2019 07:49:22 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 10sm24263620pgs.11.2019.11.19.07.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:49:22 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-rc 3/3] RDMA/bnxt_re: fix sparse warnings
Date:   Tue, 19 Nov 2019 10:48:51 -0500
Message-Id: <1574178531-15898-4-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Making a change to fix following sparse warnings
 CHECK   drivers/infiniband/hw/bnxt_re/main.c
drivers/infiniband/hw/bnxt_re/main.c:1274:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1275:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1276:18: warning: cast from restricted __le16
drivers/infiniband/hw/bnxt_re/main.c:1277:21: warning: restricted __le16 degrades to integer

Fixes: 2b827ea1926b ("RDMA/bnxt_re: Query HWRM Interface version from FW")
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 2ee2cd4..27e2df4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1271,10 +1271,10 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		return;
 	}
 	rdev->qplib_ctx.hwrm_intf_ver =
-		(u64)resp.hwrm_intf_major << 48 |
-		(u64)resp.hwrm_intf_minor << 32 |
-		(u64)resp.hwrm_intf_build << 16 |
-		resp.hwrm_intf_patch;
+		(u64)le16_to_cpu(resp.hwrm_intf_major) << 48 |
+		(u64)le16_to_cpu(resp.hwrm_intf_minor) << 32 |
+		(u64)le16_to_cpu(resp.hwrm_intf_build) << 16 |
+		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
 static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
-- 
1.8.3.1


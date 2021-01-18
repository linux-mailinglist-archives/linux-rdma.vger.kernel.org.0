Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70EF2FAD70
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbhARWlj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389254AbhARWle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D760C0617BE
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so15071332wmd.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eFdUTJI7mmEj5LtJ6jTyl1yOrcuVdEGYg6Yi6ixeZ8=;
        b=kNaajm5Jlop5jqlyD7FIYnB9+kiPHDeuU4FljyePtPzp4pU7am76kktTdXv76CafPF
         NYIrC36USQ4FsHPPJE7OBKbHgqRiZKQFVZV+4A259mc78uUWaU1all44QLdPjpsafeBV
         d/E7VgwAtCRpdu2DbPG8ZC5TydNz1QeyAxNp5C2qBIVU+11V9ZsN1MHPyhvFLHpLusrW
         Sp11I1SuIbULBbFqk1k7OIk2vmpF0Y23IMOfriu8+v8rJwQn7945emEdXYtWU/k2A6d+
         c5R9om3QR09rCp+HJll1RSUfWAJQxpB5eBBdeg6fM/ziUlVJbw2cAa+gXtH85WUJiRGv
         d4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eFdUTJI7mmEj5LtJ6jTyl1yOrcuVdEGYg6Yi6ixeZ8=;
        b=LNLQL2uBivRhdNpnoK/dnSoUKEty27UYLyoreUPdg7TAgq8P+cTDI63loKquH0sO8x
         0cDwEQa134lovYUReez6U6Z8qg9Yb2CR1RN1X/mRysr5GEDoUyqyG6cy9EKizt6BCOLq
         auewPVWrm5R0uXMPuELXRa45dNFijo6c4ZEz/AVdejlaCOi2ZIPjf3J749aQkft7Gs1Y
         cU88uoq7LZayMxJ1m6riSC2yWzah8rJ1d57TcoxVcQyEmylL2cvMJ5SdFZAZ0omCGwsa
         mYQJtN5SzSXhK7x28zFDnHTHGP96FNkMVReiPtCWL4s3MXMOZZkQhLBktK2EQAemBNjL
         0Hcw==
X-Gm-Message-State: AOAM533VXrrELJNWJ9vNIJaw5pN/8QuRwiQkQbfvRMzzSZthlKYJYg9A
        PAoAllY0GqwAR31loOEMsUThjQ==
X-Google-Smtp-Source: ABdhPJyYvVMC/kR0w10Yl2A5bJOy60xhvhQYtJD0lozRUaqnUXTIIw6QOwzEndAcIRfZSfsYoYdLXQ==
X-Received: by 2002:a1c:2009:: with SMTP id g9mr1279326wmg.7.1611009593850;
        Mon, 18 Jan 2021 14:39:53 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 19/20] RDMA/core/iwpm_util: Fix some param description misspellings
Date:   Mon, 18 Jan 2021 22:39:28 +0000
Message-Id: <20210118223929.512175-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/iwpm_util.c:138: warning: Function parameter or member 'local_sockaddr' not described in 'iwpm_create_mapinfo'
 drivers/infiniband/core/iwpm_util.c:138: warning: Function parameter or member 'mapped_sockaddr' not described in 'iwpm_create_mapinfo'
 drivers/infiniband/core/iwpm_util.c:138: warning: Excess function parameter 'local_addr' description in 'iwpm_create_mapinfo'
 drivers/infiniband/core/iwpm_util.c:138: warning: Excess function parameter 'mapped_addr' description in 'iwpm_create_mapinfo'
 drivers/infiniband/core/iwpm_util.c:185: warning: Function parameter or member 'local_sockaddr' not described in 'iwpm_remove_mapinfo'
 drivers/infiniband/core/iwpm_util.c:185: warning: Excess function parameter 'local_addr' description in 'iwpm_remove_mapinfo'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/iwpm_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 13495b43dbc11..f80e5550b51f2 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -127,8 +127,8 @@ static struct hlist_head *get_mapinfo_hash_bucket(struct sockaddr_storage *,
 /**
  * iwpm_create_mapinfo - Store local and mapped IPv4/IPv6 address
  *                       info in a hash table
- * @local_addr: Local ip/tcp address
- * @mapped_addr: Mapped local ip/tcp address
+ * @local_sockaddr: Local ip/tcp address
+ * @mapped_sockaddr: Mapped local ip/tcp address
  * @nl_client: The index of the netlink client
  * @map_flags: IWPM mapping flags
  */
@@ -174,7 +174,7 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_sockaddr,
 /**
  * iwpm_remove_mapinfo - Remove local and mapped IPv4/IPv6 address
  *                       info from the hash table
- * @local_addr: Local ip/tcp address
+ * @local_sockaddr: Local ip/tcp address
  * @mapped_local_addr: Mapped local ip/tcp address
  *
  * Returns err code if mapping info is not found in the hash table,
-- 
2.25.1


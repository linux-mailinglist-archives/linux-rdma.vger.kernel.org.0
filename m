Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877C62FE74C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbhAUKPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbhAUJru (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF9C061345
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g10so1072280wrx.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHWi4XXx2vyVztgjTgAmprH4VRWvHZdCQBx5OVlNKfY=;
        b=lgfYOvgxTbmldjCfGQVsXLWqgsor7xJTmEgRIw5q8Ks1K+0y2v4FIO6SqDa8zyLRsD
         8YID8tJA3CvEd/laqfupMqMPV8mKMaBv6DXL9iB6/R+X5sqrPK+BfwRmDsytoG7ulKVD
         X3GPNKgGxvfxRQL1o0OaAOIYeYy/kd0bAp++V56jgMjzJ6N24JxVKiCc68JqSIi1Hk/z
         RdMgpxskr2osXM9qKuCxUwBHxbTWF8c34L6P0zxlHH1rLKpK1hkQZBgvNPWaQWbY0GU1
         YaaWrdeTHGep+huyI4O0zXrq0JiuCewdu1apJ5kLtRRYKxkssPD6UWxUOdWbDJGB+x4+
         QJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHWi4XXx2vyVztgjTgAmprH4VRWvHZdCQBx5OVlNKfY=;
        b=ire4qq+4M4EFFxnDLKOe4R/HMt9IiRXPah+Cc7UNcWR+uICQpKbusiwoWzrwHGl3U8
         jlcTTjMc4Y671IGlugd8dwAP2abjPJrZeMWWkKK2ETPcaWXeDhdJjP05MCxFaECLJsO9
         qZcMa125hohLHM25cPazkKq+fiUFXRlmaH16VnUQ9X65HjEdztZHKHC45z57SHJkxTul
         a4RCSB4woUSBmIkTkCm0TSsRLDeQdJnphG+gTSVJ+xG+9ZFngYF570Mhy/ICRam3ONEH
         ynD6m5IuLGxa3sqYdKL1DEbT/EpAbMSWQnvZBWTnoJyYfSFiFQ+i2s94kVgsmS2teXo9
         k9bQ==
X-Gm-Message-State: AOAM533j0GtXJPriXUVSb8IZR+WR+16ED9lXuN0WEgIJSXMEGHnuXKY2
        Utg+2sxy30qylkDAwEnTFMT2sA==
X-Google-Smtp-Source: ABdhPJz2zDgq7vJg6Rf0Bfqtm30Oq7JlUDjRPhnw8ZGHxiWVsIkHVD2umFKM+J6YRqF3Kv0ci2cdfg==
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr1969479wrn.23.1611222358180;
        Thu, 21 Jan 2021 01:45:58 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 28/30] RDMA/hw/qib/qib_verbs: Repair some formatting problems
Date:   Thu, 21 Jan 2021 09:45:17 +0000
Message-Id: <20210121094519.2044049-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_verbs.c:1077: warning: Function parameter or member 'ppd' not described in 'qib_get_counters'
 drivers/infiniband/hw/qib/qib_verbs.c:1077: warning: Excess function parameter 'dd' description in 'qib_get_counters'
 drivers/infiniband/hw/qib/qib_verbs.c:1686: warning: Function parameter or member 'qp' not described in '_qib_schedule_send'
 drivers/infiniband/hw/qib/qib_verbs.c:1703: warning: Function parameter or member 'qp' not described in 'qib_schedule_send'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index f6c01bad5a74f..8e0de265ad578 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1067,7 +1067,7 @@ int qib_snapshot_counters(struct qib_pportdata *ppd, u64 *swords,
 
 /**
  * qib_get_counters - get various chip counters
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @cntrs: counters are placed here
  *
  * Return the counters needed by recv_pma_get_portcounters().
@@ -1675,7 +1675,7 @@ void qib_unregister_ib_device(struct qib_devdata *dd)
 
 /**
  * _qib_schedule_send - schedule progress
- * @qp - the qp
+ * @qp: the qp
  *
  * This schedules progress w/o regard to the s_flags.
  *
@@ -1694,7 +1694,7 @@ bool _qib_schedule_send(struct rvt_qp *qp)
 
 /**
  * qib_schedule_send - schedule progress
- * @qp - the qp
+ * @qp: the qp
  *
  * This schedules qp progress.  The s_lock
  * should be held.
-- 
2.25.1


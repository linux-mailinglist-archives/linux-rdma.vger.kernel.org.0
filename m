Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7A2033E6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFVJrb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgFVJra (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 05:47:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EBC061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:47:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so15922008wru.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14kl6Zj7IC4nTHaYryhW8Wvasg8SIXbad6HtyMpTXYs=;
        b=oGx53QHYFGGun5f42SJEg3++OdX/NJj49lWAX85vA9acWB4NXAwsVbkchLD1XI7HfI
         4HPQJl3mvEAq5lCuBlvisgCi4DGoVMlcCr2VXRLKJREr9pPjTAIN6SNZ1snXrTjZ/u2D
         hE5hqbt/jDynLqovSr0jR/7G72q0WMeLcArDzzpgxEvIt6DARYGKm3BbvDTm0uyZtk6Y
         nLSYvdPfhiOwuJCd00TmKF5FZVzZVyVMlb91MYTJ2uf+sy0FbJuzp1PY68Xh5XDyhEBz
         Y1DTx+cZPjFgo2qkWBuqHhYKe3A/TacwT9nPWKMBcL0Dg8Cc0n95X2gyzaT8nE07lgPR
         9gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14kl6Zj7IC4nTHaYryhW8Wvasg8SIXbad6HtyMpTXYs=;
        b=I9DilMtfsJ4Fzo5EzLOZ46T4hKSOxSjfY6iFZu4ixGK0AE4+ee0/LRJ3885Ha9vsi9
         VEqOJJX0Tjy/tKboJ/H7OrrfXend61B4vzyQUFO7K+q3cXC4+A1VGbQS2jXmHtCO9+0/
         a0qKFHe7yHNjQObw06BqaNSPztw32hTNveBaFX7v9kzWd+73ISDsMnCM2x9I1DVTtc0i
         +JiRXXbctt60OHO59C32cGrQBwZ4nrccMmxy6j3OMKYGjdFTrkf4ePlOTzPqmF3u+fPC
         0rbQ1WGi8TFDUclKxn1k2thQ7BTmbh+/PXqLfyMxiY0Rpq1H45Hw05LyBZ/wdtPDQ+ZY
         Cqxg==
X-Gm-Message-State: AOAM5314cohWcoFOugOc/Nn9ANn3Fdo+Awp2ViSC/4hs+0OSWyFKXdUZ
        QGTWXS4Enle5rHdbUIkDWk+cu5Ro
X-Google-Smtp-Source: ABdhPJyeZgfOZmVD/u81xdtpilZk9iYe5JeyRm48MCCmjqVoFBN8wqEUjx29G1T2ITXcCav2YLRVYw==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr2766634wrq.357.1592819247386;
        Mon, 22 Jun 2020 02:47:27 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r10sm615119wrm.17.2020.06.22.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:47:26 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/hfi1: Remove hfi1_create_qp declaration
Date:   Mon, 22 Jun 2020 12:47:09 +0300
Message-Id: <20200622094709.12981-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function isn't implemented - delete the declaration.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hfi1/qp.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.h b/drivers/infiniband/hw/hfi1/qp.h
index b670321365d3..b0d053d12129 100644
--- a/drivers/infiniband/hw/hfi1/qp.h
+++ b/drivers/infiniband/hw/hfi1/qp.h
@@ -112,20 +112,6 @@ static inline void clear_ahg(struct rvt_qp *qp)
 	qp->s_ahgidx = -1;
 }
 
-/**
- * hfi1_create_qp - create a queue pair for a device
- * @ibpd: the protection domain who's device we create the queue pair for
- * @init_attr: the attributes of the queue pair
- * @udata: user data for libibverbs.so
- *
- * Returns the queue pair on success, otherwise returns an errno.
- *
- * Called by the ib_create_qp() core verbs function.
- */
-struct ib_qp *hfi1_create_qp(struct ib_pd *ibpd,
-			     struct ib_qp_init_attr *init_attr,
-			     struct ib_udata *udata);
-
 /**
  * hfi1_qp_wakeup - wake up on the indicated event
  * @qp: the QP
-- 
2.25.4


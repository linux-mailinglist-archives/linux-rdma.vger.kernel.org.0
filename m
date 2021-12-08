Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510B46DA63
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhLHR4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 12:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhLHR4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 12:56:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF1C061746;
        Wed,  8 Dec 2021 09:52:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so5410277wrw.10;
        Wed, 08 Dec 2021 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qTM3hnJcrSbvPOpTa3HhLa5twzVTXNZWIy9G06uqmw=;
        b=Ci0MVrcccg5wtLWjdl7fXGwcv+N2fc04DKWsyE2Uu/bV+q2AXvAi1+E0a5BKBVuMy5
         35+EmMXIAlRs1DBSt9rvk8EP99KzWkThVE4VMAFnSJmDiklP7gdFP6utknnf9ekIVHXL
         de9dNuni0HjFucmPRNFDY+JuUTF4lB0WwvXpHBPbPM/1gVEp2gigKBIMYmNwF67oapVe
         JjphFSNkDT5W1RC4xOqRLId26E48wjEEiraPb04Uh44qzqy9iIDdapO3VoEZuDfOuqZ6
         L/fzpLOk6RMKq70t5CBjzqwkwqQCEpNJXLRBW3wlnFY7AsX0GNCam3rNeAOUZ6F4miQe
         FPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qTM3hnJcrSbvPOpTa3HhLa5twzVTXNZWIy9G06uqmw=;
        b=mxIuV/F1t/Ggzct00IL4rxsiTFPq19VWhYn79AtsS8CQLxs3vaGiyfEGdY5QGC/tIM
         IM70C7z3Ib9tag+u0TkhLj55SFWm/otSSfSxhAg3s1I5boPkzL7Gzzy23fMEsMVgiegY
         v8FPsw2hAYLSThcVn6/ajl4c6HYjwDeiHbYPyC3qN9gb3CdOtgOnH2BY62AnRXHlUw28
         2eCVNdCststvfQTJhdbgGOwGxJT7HJPXXpXdeB5RX/tJxwjg2/1qo7jKUxheWop6M3er
         eFyohCWPD/z0EpolL3hjrG9/SbdzcF0ZWOKmCl57CIAM1gt383mcFYmZ6V6LqC3AypAv
         mLiA==
X-Gm-Message-State: AOAM532eJ3Kppcg8QAiDgJRASoFX1w5jqwe06InKKqr4TXahYiRZqs/5
        hAuDVkQz0tvFldjcUorggzo=
X-Google-Smtp-Source: ABdhPJx8Jq3IdE6jOzV1ueKglw4+40SywNAuM91lYLgEStvBqX9Ekc8GdG6KeJDdSbaTkNcif3RQew==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr249724wrd.114.1638985967484;
        Wed, 08 Dec 2021 09:52:47 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id o3sm6870037wms.10.2021.12.08.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:52:47 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] IB/qib: Fix memory leak in qib_user_sdma_queue_pkts
Date:   Wed,  8 Dec 2021 18:52:38 +0100
Message-Id: <20211208175238.29983-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Addresses-Coverity-ID: 1493352 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index ac11943a5ddb..bf2f30d67949 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -941,7 +941,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 					       &addrlimit) ||
 			    addrlimit > type_max(typeof(pkt->addrlimit))) {
 				ret = -EINVAL;
-				goto free_pbc;
+				goto free_pkt;
 			}
 			pkt->addrlimit = addrlimit;
 
-- 
2.25.1


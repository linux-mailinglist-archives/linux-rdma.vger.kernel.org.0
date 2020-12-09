Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50262D4705
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgLIQq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbgLIQq3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:46:29 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A03C061793
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:48 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so2297170edm.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PQati/YK+0ufphUXyId/+gTePb410nGvKEpPs46D9c=;
        b=bnEV37hvP2Tmgk/uYrl0579uNbn8Xi6mV17v1w59jgU6Te3okmB4GRgDs3bUdRT10H
         HAmFrXsithrv5FyADXZpc1S4OSApGgaEwcW1vxoqfpLSjH5JvyOpg/lkUyH9VyKN7dNy
         9lkkxGlKAQqtdcv4r2QeGkwCy5MML7qCWDpOZzWRuOdBk7XEKFsDX9dM0PDpgMBaMOte
         C3r99nqmGklySsDDTAePqRaJhmNEtDz+Wt2oymABiTLdjDZJY34pUW68qs6JBD2DBEbE
         OISlYys6doelxtw81K6hTpL6tNILL/LySYMUKtuLYM85pq4kdZ1aZCVWucNJS7ADpHHt
         TLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PQati/YK+0ufphUXyId/+gTePb410nGvKEpPs46D9c=;
        b=A11M3kYNLZNGoVrbu3ewhS6IqNN9CA8f1X1PK5JodkG5mm1H1DSd/m6IMhVH7Buxkc
         dhA/VPSPrYdBHSSPot8u/lPzzBml+mcjj2e4eBOiBzvzfhX+/dPYgm37BbPB5lL9J4NA
         aM0zD6GEAJuC8yKP924Rj+bKLW4ailvpC2qlAPGruhYgdfQYPCTXsCVTTQVlqgbTVLGb
         DDW+JNULAksFat6BrDKkN26yp+qybUUkEM+nlCsAo8DglzpXTBSMM1s0uQzPMs5Kcd1X
         R8J9I6pPg4xdonDgoFtZx/PJs93R9Wg2YWRujOZjq9z5nq8BKVjhjpX3jERRL4HPFD+K
         tCMw==
X-Gm-Message-State: AOAM531O542Is5Hlw+QND7XqNzRbi425/2puETRhSRms6XLgMdLUSvkG
        Jjs7XJTJFUXWyvdSbEtnybkZFnIsXSMBqQ==
X-Google-Smtp-Source: ABdhPJyyTGodkpww/1ahqMgeDBzXuFzlCKIWDSiYZwaccSGP19lRgYgG72/vamEBLMApRb4AHnREeA==
X-Received: by 2002:a05:6402:2041:: with SMTP id bc1mr2782616edb.369.1607532347367;
        Wed, 09 Dec 2020 08:45:47 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:46 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing session closing
Date:   Wed,  9 Dec 2020 17:45:26 +0100
Message-Id: <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If there are many establishments/teardowns, we need to make sure
we do not consume too much system memory. Thus let on going
session closing to finish before accepting new connection.

Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ed4628f032bb..0a2202c28b54 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1791,6 +1791,10 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 		err = -ENOMEM;
 		goto reject_w_err;
 	}
+	if (!cid) {
+		/* Let inflight session teardown complete */
+		flush_workqueue(rtrs_wq);
+	}
 	mutex_lock(&srv->paths_mutex);
 	sess = __find_sess(srv, &msg->sess_uuid);
 	if (sess) {
-- 
2.25.1


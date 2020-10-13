Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9792228C983
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 09:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbgJMHnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390040AbgJMHnp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 03:43:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B32C0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 00:43:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so19844500edj.8
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0PFOcNiQY9dUr07W7c9cW5CcoNGB0a1kKmgTV1o3s6c=;
        b=QUfldP+CUMAwrJwvde/Z4wztapiEgWZxOcJYH8Kd7gwPNmZoGVM5bP/iVhm4zHoCUX
         XD+gMU8115I8oOeLk8hUC9rYpyDPP2rcHurzFP+RNw0ugMu5gKthf9HoI12mIPRNOZ8I
         SRx5f5MkroTOQe28b7JXC9VaRpCtnWJcn82Fe206t4NBHwM9xKxmvgHKaUMEsTrpOFHR
         LX6ZCg6sw0aqsWyzIN7bLOaWSzfgIy9XtdZ8WngdqHk0eYPaH33Tn1fCGarWTaag/C9o
         7sEYeUwfpQBpgJoSs+KQVWc/dSQGLEunrpjl9Hg12HWyK/s6xQIvYxpsm1+K9pts+ZEo
         cMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0PFOcNiQY9dUr07W7c9cW5CcoNGB0a1kKmgTV1o3s6c=;
        b=fo8ywkWUbKosDPqhkeMEd1oUhXCjdVYD8apw7oMmCceqXw6OAKeWeA49ouSKWeSNIa
         jB0uCNDI4qFYiurtNENdwDTI1PUH7mjdasHA1sFhU0MSkedHPW1aFt9+chcM8QJswd/2
         0mF/Xlk3KTOf4o4NhBtlhK9Qnjo+X+GphpR0GHn6jqgy+I6nVgnG52kqHKBQPgnZGF4A
         tdVjPsGAqvtBL3Gh2Qn63ixMFINMDZPvUQh70vDPR6J5eQ0ooxK76w1uljA1Z9J8XdJZ
         KeazBy0gSiY8GskTqBEeSIUB4AQTIDFJVsxwhdjPGnyRwycTtV/CFQH7Uw8E7CaxnGPa
         6Cgw==
X-Gm-Message-State: AOAM533MlS7FovO+OoUsalPeafARY6Vr2tHVU+HXMLVNtWUqFTMZ+c7R
        kFekJnY9o1KJT3A43buv9Nt1eFyYlnP6nA==
X-Google-Smtp-Source: ABdhPJzKv82EAaI4SoiPbruXMK2fBGlMCsKQPBRCoRI7J/+2Lp95QPLFZedMiP5gjGCgAWDU6nh6Ag==
X-Received: by 2002:a05:6402:16c9:: with SMTP id r9mr18146135edx.27.1602575023566;
        Tue, 13 Oct 2020 00:43:43 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4969:6200:8c9c:36cf:ff31:229e])
        by smtp.gmail.com with ESMTPSA id ba6sm11930623edb.61.2020.10.13.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:43:43 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH] RDMA/ipoib: distribute cq completion vector better
Date:   Tue, 13 Oct 2020 09:43:42 +0200
Message-Id: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently ipoib choose cq completion vector based on port number,
when HCA only have one port, all the interface recv queue completion
are bind to cq completion vector 0.

To better distribute the load, use same method as __ib_alloc_cq_any
to choose completion vector, with the change, each interface now use
different completion vectors.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 587252fd6f57..5a150a080ac2 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -158,6 +158,7 @@ int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca)
 
 	int ret, size, req_vec;
 	int i;
+	static atomic_t counter;
 
 	size = ipoib_recvq_size + 1;
 	ret = ipoib_cm_dev_init(dev);
@@ -171,8 +172,7 @@ int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca)
 		if (ret != -EOPNOTSUPP)
 			return ret;
 
-	req_vec = (priv->port - 1) * 2;
-
+	req_vec = atomic_inc_return(&counter) * 2;
 	cq_attr.cqe = size;
 	cq_attr.comp_vector = req_vec % priv->ca->num_comp_vectors;
 	priv->recv_cq = ib_create_cq(priv->ca, ipoib_ib_rx_completion, NULL,
-- 
2.25.1


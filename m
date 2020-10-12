Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5669A28B5E8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbgJLNS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNS0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F7C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so14526948edb.12
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJuZm6SZ/GzRajeoHT+29aR1kivIdc2pYCwz56Ka+Gs=;
        b=H9tpShSiTMslHkA43d6lInBCkD0gTCR1wjfWmmKGsdWFvCcASFulUhfgZ1id+e4m76
         WJauMQMmwkB7RDWp5bK2qu9DHPmGbY7muiIeIDevfKlY1snBqf+IocyrbR28KV1kFnvl
         qC5wNiMmROetWJ2NZB6CLusqoJhyNEY40I4fE9lZOfdbhcxxFE4d1h6hjwRDG3UtXOF3
         q7JyaCNbmcK/Stv33W8Y3IkReHwunOUCuEuAolikHAk/w0vB9H0gDJg2k2ADFz6kSrpt
         c7Q4Lu1dETpE4wWHLy5hqBdo+tzV1p+XOYcjee4/dwf0mMALmSpeEqatuNXySf3jzbQf
         2wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJuZm6SZ/GzRajeoHT+29aR1kivIdc2pYCwz56Ka+Gs=;
        b=aHNJ7SwLU9YFA3VOz5cTTtzkd/xWbZB2tRueiO6oI8X2P/u8G5rNKB2JnNLLMSrfWc
         efTwHjQlkpE3TjRLigNwHXyXFxxy2tVdXhsuOCUjydkIXXoFjkJpAf0+DDIiWt/5SuJ2
         /H98rgxuSXsanNaX35cxm9w9qN2kEyMpp55wrldi0JQcJtdo5WoA0P8XBkGgKxo9zbJB
         MnyT038JlV8Jmh/kqikro4+FP173BzO48COhSz/z5AcpgDX4H38qcWgA2//sPebZDVw3
         vFKeYWj3LDPi5hNh6CPLGoW+VN/0ZKS4WcExpurnmnzSf4ifIxcvc1XlXz7LU46ufw+p
         2P2Q==
X-Gm-Message-State: AOAM530HW/qIYuSCN6Ojd4BRiMoNsL1Fz3WMOdYGrqw2AkUY7zbRuPZF
        XAWa0XPP9kBzS3dseOOAom3VwlCrjQvg8A==
X-Google-Smtp-Source: ABdhPJwrEtdnkD+Ch5MI2MJRkLh9L5B2DI4aVOuZksKubawt70k+DqtvBErm58zh+VJWhkKM/tRVBA==
X-Received: by 2002:a05:6402:1615:: with SMTP id f21mr14571922edv.257.1602508704095;
        Mon, 12 Oct 2020 06:18:24 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 08/13] RDMA/ibtrs-clt: missing error from rtrs_rdma_conn_established
Date:   Mon, 12 Oct 2020 15:18:09 +0200
Message-Id: <20201012131814.121096-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When rtrs_rdma_conn_established returns error (non-zero value),
the error value is stored in con->cm_err and it cannot trigger
rtrs_rdma_error_recovery. Finally the error of rtrs_rdma_con_established
will be forgot.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7764a01185ef..f63f239bbf55 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1822,8 +1822,8 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		cm_err = rtrs_rdma_route_resolved(con);
 		break;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		con->cm_err = rtrs_rdma_conn_established(con, ev);
-		if (likely(!con->cm_err)) {
+		cm_err = rtrs_rdma_conn_established(con, ev);
+		if (likely(!cm_err)) {
 			/*
 			 * Report success and wake up. Here we abuse state_wq,
 			 * i.e. wake up without state change, but we set cm_err.
-- 
2.25.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9A2DD2D3
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLQOUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgLQOUB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A8C06138C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ce23so38100817ejb.8
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiAG3vHJfCPtvFvsfPnvqumtSywWdt9OJJe0oVLwKsU=;
        b=Y/Ve8M2wKfE7KT/GRVY3XCvd/cwrjFIjyvccvG3cBV+o/OL4iaASMv7Qu9QkTyHJuM
         RT0Cuight089c8G+1enfHlmcGbCh47qygA7l81d0Ak+ImX07vA/mPwiHRFMs9bPfLq06
         0OrJM0C0Y5vCNBhYL03Qj3hD3eWCEd0jWVviiOcJt9d9Cy0nfa2B2Eg/+znOj1LNLcqF
         bd75D0wdsS+4AqYlxDv/ZgqlV4Eztm8TKlC6D8UUp30/+ZaPLjDwLm0M/CXEwAtFn9eg
         IAGajLrhIK+K/16vqZE8eibruVf2zM/kc8E/zcm2Vs+/2llbr2wOsNHhsGaTq1iXay9s
         9blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiAG3vHJfCPtvFvsfPnvqumtSywWdt9OJJe0oVLwKsU=;
        b=quwSgpxfHYp6vAzGiDYLHxM3RlRYdeiLq5ureGW181TQ+zi85HmtdzyZOIwGPpVlK1
         QGYEQMsw2AtYR/tM60sENe7wf/CrgWdu/thh1/BdA/TiSxCRHbD00fmtpldrx+r2Fnr9
         in0g6SdIPs2ppF7ocAOd3ojvwXltrX2gLznsK1CiOUo7TabHPWqLc6Sv6Mwz37n6g9kp
         +IKV9NpoOAwumjHJplXbEWvZSMSXySZ2AsNROaskQo3W7MotBAHJ5BqAAnXv2kMT6Nzl
         LvUihse2uphqYyWYs9p5AGaQPIEVYGqyjQYXX/MPN7BjdjY4FIwASruCviUWW+Rpyh/L
         kylQ==
X-Gm-Message-State: AOAM532G44iQNRiBtUuNzNKJZ73uYluS+GLMw/qVZnXl+GpCgpVhnsXc
        EfLecRY2IMIEyzdClyzS7vP6P0bkKEuvfQ==
X-Google-Smtp-Source: ABdhPJyJ+oVfOibx3WzUY1Trlav90bngOWAUY2lrnKObSKQdhBJrss7Z/BYYDOkADcSPyXuVmdOQNQ==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr36109793ejb.354.1608214760023;
        Thu, 17 Dec 2020 06:19:20 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:19 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Release lock before call into close_sess
Date:   Thu, 17 Dec 2020 15:18:59 +0100
Message-Id: <20201217141915.56989-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In this error case, we don't need hold mutex to call close_sess.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Tested-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index eb7bb93884e7..6771fb4a1110 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1877,8 +1877,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	return rtrs_rdma_do_reject(cm_id, -ECONNRESET);
 
 close_and_return_err:
-	close_sess(sess);
 	mutex_unlock(&srv->paths_mutex);
+	close_sess(sess);
 
 	return err;
 }
-- 
2.25.1


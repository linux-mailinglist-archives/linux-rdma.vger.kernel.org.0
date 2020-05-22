Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCBE1DF14B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgEVVdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:33:55 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52721 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgEVVdy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:33:54 -0400
Received: by mail-pj1-f68.google.com with SMTP id a5so5545795pjh.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f98PTCIHfsRe/PVHZ+ofAlaoYmlI4YmDVK0u2K32q6M=;
        b=LNGasCXvsn/kpY1IyKfyY3JOneMXjrrqrRD3OnRhrsz1htcrjBGDuARIfjrNwN+GJh
         07WI0B41SD6ayvmh0iM5ZBvsaPO3xE36rDRY9EetI1lSUT0lJyEJcODN3cmR3ATh5JwQ
         fkFJWdp5HUqr7j8xy0a6gL7lsadnqLFuJXrcD5jY0Srm/c2vs1rb/HbkyHQlVEKS5jri
         TWRDR7Vi2Y+49vZ6mKhiykPYXqJ/F6x1vRCW+1MuiCcw+QRdc+DtpD+VAXEjVJ9SoDKN
         D2Kbpb+H27/Gjsr/7KMCBooLb41tJU/IP9vhycleDepE9IuzZUtVE6Iw87BZTTu3iA54
         mooA==
X-Gm-Message-State: AOAM531h59nlsNOnuh0b4nmGXDbYzTaephcX3PNanFdS6EGlOfogRMY/
        M9itzxAPUWHDvCMjdoRMbyg=
X-Google-Smtp-Source: ABdhPJzE89u5Qfv0v5w20f7SkdOnhCSUCvX5h9m2hOEHRDsRVBkeebGxkYyJqMLlsI3etrkqjnveIg==
X-Received: by 2002:a17:90a:36c9:: with SMTP id t67mr3586190pjb.17.1590183233610;
        Fri, 22 May 2020 14:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id mn19sm7480755pjb.8.2020.05.22.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:33:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH 3/4] RDMA/srpt: Reduce max_recv_sge to 1
Date:   Fri, 22 May 2020 14:33:40 -0700
Message-Id: <20200522213341.16341-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522213341.16341-1-bvanassche@acm.org>
References: <20200522213341.16341-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since srpt_post_recv() always sets num_sge to 1, reduce the max_recv_sge
parameter that is used at queue pair allocation time to 1.

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index a39ad9fc4224..1ad3cc7c553a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1818,16 +1818,12 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	qp_init->cap.max_rdma_ctxs = sq_size / 2;
 	qp_init->cap.max_send_sge = min(attrs->max_send_sge,
 					SRPT_MAX_SG_PER_WQE);
-	qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
-					SRPT_MAX_SG_PER_WQE);
+	qp_init->cap.max_recv_sge = 1;
 	qp_init->port_num = ch->sport->port;
-	if (sdev->use_srq) {
+	if (sdev->use_srq)
 		qp_init->srq = sdev->srq;
-	} else {
+	else
 		qp_init->cap.max_recv_wr = ch->rq_size;
-		qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
-						SRPT_MAX_SG_PER_WQE);
-	}
 
 	if (ch->using_rdma_cm) {
 		ret = rdma_create_qp(ch->rdma_cm.cm_id, sdev->pd, qp_init);

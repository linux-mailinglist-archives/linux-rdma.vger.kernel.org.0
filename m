Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF31E1359
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbgEYRWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:22:30 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50396 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRWa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:22:30 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu7so190533pjb.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f98PTCIHfsRe/PVHZ+ofAlaoYmlI4YmDVK0u2K32q6M=;
        b=f/c9+sWouOpMFALm3bgWYoxVZw9Go4KEKT2VbsNdVZ8r3A2iLt7IHVCRz4NwaGIz7R
         jciGnkTuI42stX+KFhpTiJajCmepbMUM/LjmBsTS0BWr06OOqe74O7MPP3Pf+u1tkLXb
         RHylNYAnDreP8rHN+8G25W/abuszlPN8HNrrzah6CVBX1TEP9cqmf3F0WfPBA+SrJC5Z
         bWVm0KKkis+2ioyabB8QjpqdtEWTQrBlyjGzTMeo1lpeVO12yqlQxFKo5TciWQ7ipshf
         VCh7n8rdvuEdaqIfnjFo5EoOBZOIW+6B8ouy9cwX8NzMjCfVBJk6QiLyyFdzO9Lwyhqv
         h6gw==
X-Gm-Message-State: AOAM5333SSO52YThW3O4Fh6Qz6s6ZXydfwPJ0GU+EeNX95FHaN452VIJ
        d7f0hOTmkPlDUa7+J/cYGyk=
X-Google-Smtp-Source: ABdhPJx/rvpm0QZHstVYZWNZvJWzOs3ZFHnealDvOLjURew7kITDNuZNiSC221TT2BsC7Sl9VsxMTA==
X-Received: by 2002:a17:90a:8a0f:: with SMTP id w15mr19958778pjn.27.1590427349177;
        Mon, 25 May 2020 10:22:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id p9sm3213238pff.71.2020.05.25.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:22:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 3/4] RDMA/srpt: Reduce max_recv_sge to 1
Date:   Mon, 25 May 2020 10:22:11 -0700
Message-Id: <20200525172212.14413-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525172212.14413-1-bvanassche@acm.org>
References: <20200525172212.14413-1-bvanassche@acm.org>
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

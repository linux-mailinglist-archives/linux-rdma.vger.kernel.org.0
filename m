Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49DF08A2
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKEVqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 16:46:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45325 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKEVqk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 16:46:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so10933936pfn.12
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 13:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvb40niAq4k170lpQ9140krkODLeOcNh2zfaZ1XExpE=;
        b=AWJTtV/W9ad7pmMCxJ5IKVrZxNb4WxVkvwZegA7jBj1IRpYw5XTWfoK5Alt2GcfpP0
         +KtMUQDXBjd7BfPQrOWfp9Vlawyu/8pAZwsyE6yI+eR4a+QaEVnUvzZnKcQLxvnD1q4/
         iNPGsHOIOpemO3XpcqDoamauXvubfCRyuC0ErrEMbH8kLdQ++y193OPZ0CyuAHe8pcgi
         3mi6PH/EUaYtgq7u3mY5TOxgtBcPfs4pxyyf+Cj5SsuU8PF/pVQMs4r6f04DPQnTEc2f
         J2ULks4x69mNS4ltdz6vV1sq+MAfC3bs7U83A7WES1IfUoHJ266g87BZhxdvFfAcMxu1
         HQZA==
X-Gm-Message-State: APjAAAXRTUpzkbu9DKBvvswNL1ITs1HyLnq+pN700GNk2EFt8LWGvuOn
        SUR1qCW++CmAIFh0bB0u+8a9C/B7
X-Google-Smtp-Source: APXvYqwazu57KVz/D6S8WiIkeNuGoFUNwjhaaDA6UaYGwy/YPW2BzFrOhYHkl/ILh8S+Z1k9AObR7Q==
X-Received: by 2002:a63:ce4a:: with SMTP id r10mr37494251pgi.82.1572990398895;
        Tue, 05 Nov 2019 13:46:38 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 3sm22372340pfh.45.2019.11.05.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:46:38 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
Date:   Tue,  5 Nov 2019 13:46:32 -0800
Message-Id: <20191105214632.183302-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The code added by this patch is similar to the code that already exists
in ibmvscsis_determine_resid(). This patch has been tested by running
the following command:

strace sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
    grep resid=

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 653de1583cf9..23c782e3d49a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1362,9 +1362,11 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch *ch,
 			      struct srpt_send_ioctx *ioctx, u64 tag,
 			      int status)
 {
+	struct se_cmd *cmd = &ioctx->cmd;
 	struct srp_rsp *srp_rsp;
 	const u8 *sense_data;
 	int sense_data_len, max_sense_len;
+	u32 resid = cmd->residual_count;
 
 	/*
 	 * The lowest bit of all SAM-3 status codes is zero (see also
@@ -1386,6 +1388,28 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch *ch,
 	srp_rsp->tag = tag;
 	srp_rsp->status = status;
 
+	if (cmd->se_cmd_flags & SCF_UNDERFLOW_BIT) {
+		if (cmd->data_direction == DMA_TO_DEVICE) {
+			/* residual data from an underflow write */
+			srp_rsp->flags = SRP_RSP_FLAG_DOUNDER;
+			srp_rsp->data_out_res_cnt = cpu_to_be32(resid);
+		} else if (cmd->data_direction == DMA_FROM_DEVICE) {
+			/* residual data from an underflow read */
+			srp_rsp->flags = SRP_RSP_FLAG_DIUNDER;
+			srp_rsp->data_in_res_cnt = cpu_to_be32(resid);
+		}
+	} else if (cmd->se_cmd_flags & SCF_OVERFLOW_BIT) {
+		if (cmd->data_direction == DMA_TO_DEVICE) {
+			/* residual data from an overflow write */
+			srp_rsp->flags = SRP_RSP_FLAG_DOOVER;
+			srp_rsp->data_out_res_cnt = cpu_to_be32(resid);
+		} else if (cmd->data_direction == DMA_FROM_DEVICE) {
+			/* residual data from an overflow read */
+			srp_rsp->flags = SRP_RSP_FLAG_DIOVER;
+			srp_rsp->data_in_res_cnt = cpu_to_be32(resid);
+		}
+	}
+
 	if (sense_data_len) {
 		BUILD_BUG_ON(MIN_MAX_RSP_SIZE <= sizeof(*srp_rsp));
 		max_sense_len = ch->max_ti_iu_len - sizeof(*srp_rsp);

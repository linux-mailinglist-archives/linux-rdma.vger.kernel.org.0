Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB783E933E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 00:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfJ2XDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 19:03:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJ2XDF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 19:03:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id 21so144493pfj.9
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 16:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+j/PgDNjRkpaKz82SJtODRU29RIKCG86ub3IDcyKQA=;
        b=ggHKW8iPDRUPxq8nU67zUwphomejCXFIXwLl2XSDEAUYvdDXwbc+hv8LLgvCBda1Ff
         4ZxN0lbvq35Hgmvip62cb01BX50dyXGDNvb5hB21/N4yjA6yDAAEjxNEmzos6zQlQgZW
         jRkf8yMYyuXUIkpHI2qEh3Z0JulTh3xORbAAHxoPRJ771xvuZTyWinhr6b+JdnlhkbZv
         gI4RNeJvnDof7zpnlMR/wJt9NXXZpJWk9aj+6TahGrj93XxACGMgvKLvm+fEErzuxs9/
         MD/4IijOhDYiaiWyUuq0rCAihL6dnf0UPS5z2gcJDAE/zi/Pw/RUmN3gWPcSzb+NijUs
         vb5w==
X-Gm-Message-State: APjAAAWVttY1/y+7n4fBeiwOmCIuJYDNnQOWVQassv8b8AMslcLM5JVY
        cKkPtdLYUdWVZrSnhBGH6MA=
X-Google-Smtp-Source: APXvYqwg8Fg+MgDH2Gw8VwmPbiwBsAftH5p5Um4tUGHIJoSs5DmxWWJsnfpo14Cf+YdieEyvFTAYlA==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr30065875pfm.74.1572390184694;
        Tue, 29 Oct 2019 16:03:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r21sm195095pfc.27.2019.10.29.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:03:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
Date:   Tue, 29 Oct 2019 16:02:57 -0700
Message-Id: <20191029230257.210897-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The code added by this patch is similar to the code that already exists
in ibmvscsis_determine_resid(). This patch has been tested by running
the following command:

strace -f sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
    grep resid=

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index a278e76b9e02..c9972b686c27 100644
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
+	int resid = cmd->residual_count;
 
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
-- 
2.24.0.rc0.303.g954a862665-goog


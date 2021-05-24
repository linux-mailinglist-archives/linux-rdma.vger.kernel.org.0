Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044BD38E00F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhEXENt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:49 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:50737 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhEXENs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:48 -0400
Received: by mail-pj1-f54.google.com with SMTP id t11so14099823pjm.0
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXfwWfiFbGhtGlr8isJimErrUggu7/moKoh3ZohK5NI=;
        b=aA+sTF1QLXS/6D4jsMjZk/w6N2Vfv71Kyy8nQrSKxmVgNBQmk/4poWBDQPTP/zlf0G
         BUmDhzQxxGjCVr6vSnEcO3NA0R7G9/kkKYc+NV0UBffJj849giBgCd+f6WANij4bY5eC
         n/srOB1mw8KNR+N26fQFA1TRCaT/LY1yXB7JRyKuTyJHchlLe7snsPfGa/ZN24mav//O
         iOww6InzCLJcqHy0FGMnFEMAdCnMnQizjqZjP3Q26ir0Jffhc4GCDAvG8FBphO/DCx4s
         /EzCvLH2zMvFELl9MW8l2E13m01Avoc2kaCMev1wzUF3rPPTScRH7Tq6HptIvnoNbYfZ
         syCw==
X-Gm-Message-State: AOAM533duJ4Z2VgalJV2AT6WS0mS0CZtlswekUa+aVpHCYhf3oxjDjyR
        qCepTinOlcAj7AH4Lr8unA4=
X-Google-Smtp-Source: ABdhPJwSSTnFbHvq5mn/3L4DvNYyhCmVxdiyAmCPRxUkSjfMn09/kk4Ixq3L7I67uDbaXBUSfObYqA==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr23019125pjq.65.1621829539276;
        Sun, 23 May 2021 21:12:19 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Don Hiatt <don.hiatt@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH v2 1/5] IB/hfi1: Move a function from a header file into a .c file
Date:   Sun, 23 May 2021 21:12:07 -0700
Message-Id: <20210524041211.9480-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
References: <20210524041211.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since ib_get_len() only has one caller, move it from a header file into a
.c file. Additionally, remove the superfluous u16 cast. That cast was
introduced by commit 7dafbab3753f ("IB/hfi1: Add functions to parse BTH/IB
headers").

Cc: Don Hiatt <don.hiatt@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/hw/hfi1/trace.c | 5 +++++
 include/rdma/ib_hdrs.h             | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/trace.c b/drivers/infiniband/hw/hfi1/trace.c
index b219ea90fd6f..715c81308b85 100644
--- a/drivers/infiniband/hw/hfi1/trace.c
+++ b/drivers/infiniband/hw/hfi1/trace.c
@@ -189,6 +189,11 @@ void hfi1_trace_parse_16b_bth(struct ib_other_headers *ohdr,
 	*qpn = ib_bth_get_qpn(ohdr);
 }
 
+static u16 ib_get_len(const struct ib_header *hdr)
+{
+	return be16_to_cpu(hdr->lrh[2]);
+}
+
 void hfi1_trace_parse_9b_hdr(struct ib_header *hdr, bool sc5,
 			     u8 *lnh, u8 *lver, u8 *sl, u8 *sc,
 			     u16 *len, u32 *dlid, u32 *slid)
diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
index 57c1ac881d08..7e542205861c 100644
--- a/include/rdma/ib_hdrs.h
+++ b/include/rdma/ib_hdrs.h
@@ -206,11 +206,6 @@ static inline u8 ib_get_lver(struct ib_header *hdr)
 		   IB_LVER_MASK);
 }
 
-static inline u16 ib_get_len(struct ib_header *hdr)
-{
-	return (u16)(be16_to_cpu(hdr->lrh[2]));
-}
-
 static inline u32 ib_get_qkey(struct ib_other_headers *ohdr)
 {
 	return be32_to_cpu(ohdr->u.ud.deth[0]);

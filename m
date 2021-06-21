Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8947D3AE2EA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUF4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUF4B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:56:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D2C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hz1so4166346ejc.1
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqUood5gYzYaoZzQLKeGJe8MYTSMVLyUFoknlreDWAY=;
        b=eNkYuXIvUcU9koS9ADoqorY/aYChjmiDliKGi+2yioWD+KyFWt91OBgdFQAQOKUyUZ
         Tcn+P7S/DON/rqjHW7sM54mgHHNSN74VrXdnfFiTMMW+oLWHsnqxct7lgX0QE6f3eM00
         JLCSXtEBtQcjpwhP2tiX+nw2QaEMLxe3vlkJpZUEnAPPMvgwW93F/t4qbPWxHaAKSlHU
         B+B0vFJTYHL0kcRf/XgvAXK8XkTJZQtUiHjDooLPOuOZKlecvxd3gwO4okw/dsaJrxzO
         iG06BpsbFOxgYWVn9y9a3T5GA9mjUTcvJsjYbrO2E4krAKxowtidPYwVgVZjB84EwseP
         /Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SqUood5gYzYaoZzQLKeGJe8MYTSMVLyUFoknlreDWAY=;
        b=Vk5sNgTy5g7wpIGp4ME0dEdYmhs8dlzuN22QvoVLUO5GqXSNAkWVrTOWR7PI/vA4TL
         usRz9+wz4CXxZVwrVo+Qb9xGQK6N94VN30wvxtXvfFMPWGZZWiAuqAIIGxu4aWmLfdKS
         jcYdY3E0mmJuRD/chFSiI1XsdhfkTZUdDfWxRprFGdJXNvmB7Fxi058fzwl+ex2Y4+M4
         lC59v1worctI+pku6MhQcYW9JjawukkUua7jgGw8TarQ1Tkfk7M0tBkt+EczPwa1t2JU
         nwTaw3zkDalyA1TPQrW9Ioihf/5lzt7mV9UD+c83fxLzGRfZgo6uE6dzk2fKvURMfTpS
         LjoQ==
X-Gm-Message-State: AOAM533os98JXCt+r6qm1Vg+v3BjpL3ODOHpQcHJ7/83M1o2YFMUar0p
        tNAzwyYi55O+Qii3REQTwgTh/XZk1tR26A==
X-Google-Smtp-Source: ABdhPJxErzBTlo+hf/ETbgV4jhqpe2XT6qeyNVsOKhjLelbJYyv1nz8QH+Y7+1/mEGDZFqyVPIhDgA==
X-Received: by 2002:a17:906:26db:: with SMTP id u27mr22938001ejc.532.1624254826446;
        Sun, 20 Jun 2021 22:53:46 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:46 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH resend for-next 3/5] RDMA/rtrs_clt: Alloc less memory with write path fast memory registration
Date:   Mon, 21 Jun 2021 07:53:38 +0200
Message-Id: <20210621055340.11789-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

With write path fast memory registration, we need less memory for
each request.

With fast memory registration, we can reduce max_send_sge to save
memory usage.

Also convert the kmalloc_array to kcalloc.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 87edcec3e9e3..3b25a375afc3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1372,8 +1372,7 @@ static int alloc_sess_reqs(struct rtrs_clt_sess *sess)
 		if (!req->iu)
 			goto out;
 
-		req->sge = kmalloc_array(clt->max_segments + 1,
-					 sizeof(*req->sge), GFP_KERNEL);
+		req->sge = kcalloc(2, sizeof(*req->sge), GFP_KERNEL);
 		if (!req->sge)
 			goto out;
 
@@ -1675,7 +1674,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 			      sess->queue_depth * 3 + 1);
 		max_recv_wr = min_t(int, wr_limit,
 			      sess->queue_depth * 3 + 1);
-		max_send_sge = sess->clt->max_segments + 1;
+		max_send_sge = 2;
 	}
 	cq_num = max_send_wr + max_recv_wr;
 	/* alloc iu to recv new rkey reply when server reports flags set */
-- 
2.25.1


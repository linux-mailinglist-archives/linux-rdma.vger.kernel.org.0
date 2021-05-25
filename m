Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D27390B9E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEYVkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhEYVkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A65C061756
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so19472087oty.7
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3nBU4nWuFXzPDNwaCUYYXL4sxtZG5/eFNOVVA6Idok=;
        b=m1+LmO3ghccciW54RzXruW+IEZL3zIoLAa74c5TiJypmE0LsBrs3qaLf5/pJxAvdpR
         3tBU31t9OeDAfbhwgWid5iopLHY41Vmsnm4QEzXxyK6QfHrWyCOWs9wLbiRGY8nwlNal
         LUCifBAkk9um9J81EheOCw3N4RLjC9LldseOhCTXh+fwdkx5zFN5EC6lG5gWqy49FYxf
         3ULaCxPhcQBciqA+aC94GsYJC6ZjRyWSi9MmQkU082XZRcukGfkU5zvsRY0d5eRRVUlU
         4Ydv2ESneQVW6oj3071kutMwt/F76cuemDUynA3w55bj4nCNV4Kwnq82UllrkqX4usXL
         iJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3nBU4nWuFXzPDNwaCUYYXL4sxtZG5/eFNOVVA6Idok=;
        b=EA5uqov8RsyxVBrhs4jL0mL8nIIa/YfmsONcLskjAyMl/Uhhn//nOYSnJE1ZlZjpsY
         dR08D2qy9iHX7O0ag2LWwHLP6pTwap/2hO3RGRjdB1PmglNw4AywVh0AiYI+Bu5lLReE
         yB2L8Zkvfif644gTZIJMTs68lx2ZTUDsMw1yclFdORuD65DlCy/jssnxduldN6KYmg3k
         55IPkB/M6uXsaNuWC5J62LWZ9+qTmARHL6zFBGED/ipJKs4WeHj95EV/morNgEx+Bwa5
         JHeMZzL4Psb21QRsjPqiFlJgK/L24YbbwxFpgDiuBcSsAQPPqfZoPvf8XLm5Vw+rvIgJ
         c9Jw==
X-Gm-Message-State: AOAM5322u5UCYmcicGCGoef4/bEq06VEfCaCSbjmjYNd6ppoQaZ0pbOI
        2hz+ey0F5Wh7k4lNNJgQn949Mqi/9P3aTw==
X-Google-Smtp-Source: ABdhPJyqEkbThG2w0KrGa8ZGrzda8UeiRRvLSsoEuxbN7olESwTHxihzL+vSMsSL2B7ByCQnDDKV5Q==
X-Received: by 2002:a9d:62d2:: with SMTP id z18mr25153740otk.78.1621978710051;
        Tue, 25 May 2021 14:38:30 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id z9sm4066724oti.37.2021.05.25.14.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH for-next v8 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Tue, 25 May 2021 16:37:43 -0500
Message-Id: <20210525213751.629017-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to support bind MW
work requests

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v8:
  Dropped the flags field in wr.mw which was no longer needed.
  The size of the mw struct broke binary compatibility because
  it extended the size of the wr union beyond 40 bytes.
Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 068433e2229d..e283c2220aba 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,16 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32		rkey;
+			__u32		access;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +117,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.30.2


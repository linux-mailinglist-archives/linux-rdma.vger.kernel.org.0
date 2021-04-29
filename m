Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1D36EFA8
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhD2St7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhD2St6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:49:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573BC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso60393488otb.13
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=ZplUMl5DPUl/hHvdNlVUhMWHNjbwuwfVWAHXiPzlVTnmv1fbuKUFIjIq+6IyHA6VTx
         atHuMwApMOvCaY93bt59dev+ZfylLz2rJ4bO4vX0nRcY/AMFKLcChRNzXidFJWw4fXch
         4cXq07f9wtcQNWdJ1gkbbRp7UELSmMJfTWWKnAFcwxQbgWIOml6ViwbHO0ekVzWcc0mu
         59zPPeY48QcQEQTGTB06Hf39+p3YnwgW+/C8uUpsq6TgfewzXsxHbs4nAWRiKO8rvpTx
         OMH5SbPEBYjpGocrFx0HnjQwzBHSUxsX0ateFjdvH7jSmvf8fhfmfsSytgsHKROUDR1D
         9Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=aQD6frP4PADSrLu/u++oxEBWLK+TKtTCdRLFf+ZgtznMXTszzEFOa/wZQfyF0WutgR
         NfP1V+kyDFfdyPl7U5gkmeqBPUIn6D7sXOsVKRiSn4JzsgVCXri9gh+S8w7/RZZjWwoQ
         wR+3IDuVu+Yq9qAYxvEIdCkjcrizT1HtOFxg+t743ZoGFBxfan3d5EZkBWVaaMVd4XN0
         juShCCDkARj8yU1hWFnYOmIntqPzZw4v7wyyFA9SsErciXxApzwW3lY8xeZMaD8lag77
         icQsAiD+WeP3Oqcu89EozMp311zzULlIZWw2D2GgBJMcQz/p/89oX7sJrFWy6vU3yCES
         49sw==
X-Gm-Message-State: AOAM53101z/UKUyjxDDyHxziuCujPdFEL4cUFH3sAK3aZDTksz2Q65CY
        JVBVBMzULNFwykY5AO1vh8Y=
X-Google-Smtp-Source: ABdhPJwEpnYCn8dgGMx1sclkCvF497Mnx0nzjyrYcK1e6ADppBP3h8Uw8DOTpzeeQzr9sWLMAUY64A==
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr663234otq.236.1619722151175;
        Thu, 29 Apr 2021 11:49:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id c1sm126795oto.20.2021.04.29.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 01/10] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Thu, 29 Apr 2021 13:48:46 -0500
Message-Id: <20210429184855.54939-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to
support bind MW work requests

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 068433e2229d..b8f408ceb1a8 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,17 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +118,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8441B3B6ACD
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhF1WIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhF1WIF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:08:05 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86225C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:05:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 11so15645630oid.3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vOTfIKKRoeshH3laf5NPh/ELv4U3+RKlX8LJi8SAoc=;
        b=mHDmP0Wc7n0ydoby+fLRikwRg7ZUIzYg2eWI7P6Ku9QpkE4nwZexJA1vqsBUcXo0nV
         OWJaKKsUXYkjX2mAOEoSx9zGiLN6D866LbOB8CuUXgfKXvk4ef7prDTorORkfLZhGD/0
         Ks4zg2A+M/65clFflGiBrc4o+iYGHNXrZYqPXcSvHtEFsU3w6Pufetrvevt6yVoeWa/1
         8Alr8RAVKEBKcG53c/MZuClyhIDA03R5dCu4lQMSL+xEbTgX663MjiyhWH4HdfGcGdCm
         +K86+kMW0JSEkzRw9Ekc/Ppmyfjdq918siY0+m3W5RjBPU5XbxFlAWHYo8vBDblpk/kE
         zEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vOTfIKKRoeshH3laf5NPh/ELv4U3+RKlX8LJi8SAoc=;
        b=GIj9dO88+n3XDUifflt4THYVQyM4y58ByYtxXPmPYFxFyRZRpths+tcJntP4h4Hzf7
         Jm19sDd3JIa97Y42AxWyAbXkTSevheKmpBReDzw4yL7yhjS6BmZ/uHsOpBygDMB8oAhM
         nDgzsyT0x5JzDI8Y1OGd2e2pFRqIMX8kstVFr+v7ilUalI7XgUAODhSayhHL0IYlTgX7
         1hriphMSRsMQ874sYs3PYY/hzuDs7MfY5/fx4X2XRSo88eg7xlhYCwYwQ2zuBV8kekcG
         6S8CxJsIxblOFDuviaVoQDTEfdxOqVPDcX7lOFydjuuWwD+XbbtL10nwj1RjsfkgjHv8
         HMrg==
X-Gm-Message-State: AOAM5314o9KvhIkelUcKp7MFfoiMSyqm7aNq2Q9h5dNVlIll1h9+Sblr
        axXnLS6MYDp9E6irWrTeW4g=
X-Google-Smtp-Source: ABdhPJwXvFS6NSbXVL2i260UMG1FEnVv5ybfl9IQJIdhS30JK2lvaCH9z7nS7nS2X5pr/UjZhlNb3w==
X-Received: by 2002:aca:b906:: with SMTP id j6mr22828975oif.40.1624917937992;
        Mon, 28 Jun 2021 15:05:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id c4sm437841ots.15.2021.06.28.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:05:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/2] Update kernel headers
Date:   Mon, 28 Jun 2021 17:05:35 -0500
Message-Id: <20210628220535.10020-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index e283c222..e544832e 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -98,6 +98,8 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +150,12 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
+	union {
+		struct rxe_av av;
+		struct {
+			__u32		reserved[0];
+		} ex;
+	};
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +175,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.30.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641438CECB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhEUUUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhEUUUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:37 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7718C061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:13 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso4848684oop.9
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u15gBJyBov1F5ELrcRq85EILKQdb02DcggRIlXJ/dPY=;
        b=EQf+mlxly89ZrpnI1G0/2nvl0NucHPAcGskaSLvSrtA1aazL1Z4GfTLndeRlE4ce1J
         AE6IA6oK13jB9Mr24KPbqXNElzJPSBZi34GiTenS2JnZ5ESkCAQ55iKlVVimueaJeAEA
         SLJOldxIOA2TbsJYkDcEQJZiRo+Fq2Epc7FnhOQKG3vNqVrtqK7wjkBdYqkUuHRCe/RV
         pJ7ou3see8yNIVFVoTxCXUmp6lbkk33FUdgXRM7sS/zu+D6L8khn/k/w9I3BbVqKEzag
         oUakNOc/o1oEWLZO9Ru3Hn+a9H8tT3lqn+zfNkZ4ndyGam2pIe6igrgelYMC8Y6zxkOM
         eQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u15gBJyBov1F5ELrcRq85EILKQdb02DcggRIlXJ/dPY=;
        b=RH5w1DW4NFzxDHAScdohJWe8Emk6BKjrOlRXkYL/PZfAuLYFISrEfIdD5NW5ngcBoS
         1RB292s80YJOxBVxCusbg5Zx7mfceu53/CQ6I/PDr6FPSp3TblD4mg6nVP8olZxDqhfG
         ZkaUiBXVtoUp9dF4vWEVmI+Z8DFIMCKFZtrwdTjOVMiObNR1GzGMI009UJSs50I4/loh
         oLVXpYUji2p4are7biqDej8nENRGON/QPM/FQ6zcWEfRx39452+Xq6WDS2M+GZP4tgJb
         HuQec/5P13UGU9RW3utwnYCm0VPEr6CK+MRYGZeoXFgCNx7wsJ+xW0SiV/5j58lQUkFm
         rSKA==
X-Gm-Message-State: AOAM530Nee7w0oRQs1DrtmhoBj9P38XU8P3jkwR/Iry99DxPzojhIMnG
        R+bMmwRFko59M4nnVX8gRzl9eBCqz1Byxw==
X-Google-Smtp-Source: ABdhPJw1scD0qykNw9ymzcXe691pqyDqt1kuVGCOP8CvhVCok83WnXZztwaqe32HgJBIV+AuNtqxfA==
X-Received: by 2002:a4a:88f2:: with SMTP id q47mr9609884ooh.30.1621628353187;
        Fri, 21 May 2021 13:19:13 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id s2sm431486otg.67.2021.05.21.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 01/10] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Fri, 21 May 2021 15:18:16 -0500
Message-Id: <20210521201824.659565-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to support bind MW
work requests

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
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
+			__u32		rkey;
+			__u32		access;
+			__u32		flags;
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
2.30.2


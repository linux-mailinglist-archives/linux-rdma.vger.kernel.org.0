Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA724C7ED
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHTWr2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgHTWrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464CC061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z18so152984otk.6
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNwXvtjb550doMAvR/MXJrTG/3/GwfTOjvf/tXFzCbA=;
        b=YoPWzvSA99suRIRi7DrQur2lf8MRuoxvnS0Ttza3KhICLEM3FbFP+fHsq2UVE2S4e5
         H7KB5qLFTarZt3SnLWN3I+U8buxzaadSPvX+5AQD06QEGxq74SV8ev5K1o/WConF+Oew
         kfXUQNhOcsnROhDWG+5T2pig3mUr/BIkwQ1P7H55+LOgvPmA75r47uI4ssM5ZniS+FBK
         cVZG4xI/107je7EO+9ksvNYI8p/cDzVMcxQ4FQePkQm64Z62LeygPuHwLiGo5OW1I1XR
         bJlGn8lJPfaqaUBsbcv8rsi/S7BamYdYdGUCdMy3J5iJVXUTv/Nau2oYtspoc8WFuOh1
         Kf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNwXvtjb550doMAvR/MXJrTG/3/GwfTOjvf/tXFzCbA=;
        b=LipX+g46xas5OuOrOxaFNU8ojW0OWJTqTQnPB6qV1RfLUkTy8+5M/imvxtKmTvOn4B
         e8roASqadAkhPMbyXswv8QRy1lrzSZpqWxzSRLi2PrOJoXCRo7Reo4qSQWfS6vEryr+Q
         e/wP1SHYmNw/fN4JojfrFjG7NgFrGkSovA4E9968ukdUYjLVqsbvKLG3lSsGd+Ic/c25
         aouOBKEepFT2kO/5vzXN7/8dWEdzvx80ThArkCvqNWzeZzlddGzGnHgTTxInu1gPBe/n
         wAysDK1B8h2arGuyErXIrMz45ymAHc37hq1NmwuLiwfK1ONQjQGMCpM1A8JnYq6tkzlW
         aKQA==
X-Gm-Message-State: AOAM530GwvrZ5Z/V0p85Oz5PVFBa6+ok3/ccDrEB2DeF2lSCGarOXeUw
        QUu2U2RMnwOJqAzFAlgBvLjkNpYZlouD4w==
X-Google-Smtp-Source: ABdhPJx2+FgO1hVomx6dmvn4h36MdGsyu8jvO1UPQ/PLSvAOfl3Py+6sevRMDIXs94nfx+F2ZUtekw==
X-Received: by 2002:a9d:19a3:: with SMTP id k32mr694600otk.273.1597963637063;
        Thu, 20 Aug 2020 15:47:17 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id z12sm8643ooh.41.2020.08.20.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 05/17] rdma_rxe: Added bind_mw parameters to rxe_send_wr
Date:   Thu, 20 Aug 2020 17:46:26 -0500
Message-Id: <20200820224638.3212-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a first prototype version of the user/kernel ABI extension
to add memory windows functionality to the rxe driver. It evolves
later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d8f2e0e46dab..dc01e5f3e31a 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -93,6 +93,14 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32	mr_index;
+			__u32	mw_index;
+			__u32	rkey;
+			__u32	access;
+		} bind_mw;
 		/* reg is only used by the kernel and is not part of the uapi */
 		struct {
 			union {
-- 
2.25.1


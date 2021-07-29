Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9B3DAF7C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhG2Wuk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhG2Wuk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893EC061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:36 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso7536306ota.4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YILWWX6mX7pY1gt8pbxFyZo8BMgZhXs3DhtrR0c7T7Y=;
        b=hR6eeARQpr2iTMzgdLO7FQ9SYsTHqLGWTakR2DN5l9NwdRb040LEkVHEEx+aDpDTts
         Xc3KczRYrO6cXNgML7FqQx1pUGNOxQQIVlOMeSG3iNZ9eIHt+aKVUgG3kK6ieGJwLJle
         qvcEBXJ0rfodQ9vidH1ROwHlP+vnuxpuY+8ccM9L8CK46l24hoElcOsGokHMrTAT0sjg
         5mD6bUCE3sxGV2lQBPiLoh0+xoIhAidi3hykqn+1cuL55Lerf3rkQXqZ6Br4XcM7410p
         dAM2IdvoFP5EJSGGqtaFPjb8f/CW7XzKtGjgVy0G6x6jBb0ABzVNCsNHM1SyVvKugctF
         oCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YILWWX6mX7pY1gt8pbxFyZo8BMgZhXs3DhtrR0c7T7Y=;
        b=uIvpUv5mOqhw0XGU//QTD//B+1cmMlRMKPKcfcmdYtKcuESb9TkFAejqm38oihzd9F
         Wq6B4tNfLEzMQTIBV7RvhRu+Ma2jy+cwALJSSM6X1IasOBgw+cvhyWVNm3yetl/kZQ/v
         QmZEpRJyymXqIqSoAR/LJQk5Q3PzKopbdtLtL8IjVsdC0LjGrzYTuKAJByLtzdca5bHb
         lGblasjFgrM0KmfgCqslU2a3DGFc3ue0ZCUJfVARwd4o78IQnRYBKU5YNfAf+WaO2c1m
         jGR9FVN00ZLHMjkAx89tvuv+jyxayv2P/tDVKTE7/+3EYh9cXnHv8mIwnkMnKYNX2c25
         9p9g==
X-Gm-Message-State: AOAM531uIyWLVnlHBlSR25xOvn2iL3fN3fNfxOQ6ovmgMtk2iC0xuL1j
        POJV7rDZHPsJtNagIICPG9o=
X-Google-Smtp-Source: ABdhPJxvpKQYFeV49/mQ2cJiE/AeofI4MvEHrQFl2tLgP/TGiUWpfuHBzkJIr7ukQpHPZ+pHhK5aVg==
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr5055206otu.212.1627599036018;
        Thu, 29 Jul 2021 15:50:36 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id 110sm779402otj.12.2021.07.29.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/13] RDMA/rxe: Extend rxe_send_wr to support xrceth
Date:   Thu, 29 Jul 2021 17:49:06 -0500
Message-Id: <20210729224915.38986-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add srq_num field aligned to lie in the space above the rdma
and atomic fields so it can be used in parallel.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index dc9f7a5e203a..1d80586c731f 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -82,6 +82,10 @@ struct rxe_send_wr {
 		__u32		invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 pad[4];
+			__u32	srq_num;
+		} xrc;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
-- 
2.30.2


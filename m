Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCED36848B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbhDVQOX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhDVQOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29532C06138B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so37561486otf.12
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=gFmFOhcXO9tDoz9knvMcFY6VV0XeUPw3Z4kkd5Nzk5pYJ1tlUQ/FjQBmWtBagJlZhH
         C4Hsayv2w2NF8/3mVcPHx5MzkqB/p0NBSH90Gr9xP9OAHd+FNB/j7BxdyUIpwWft2yTU
         sfkPKmgxSp7ynTIisTDNuFaq9uxORA+d5qmVvRgiiTjzFliYRC20DbHV8TYLWNIu2ZW6
         IXIgeBMrmi8MsG1XjTZECnLeFOK3ypk3RCsxxxd2xUlTe6SwIuzlomVrwemqsJFBpW49
         geWdq7p/d99EtMB6CBr1nbbz9TewMi7GykQishDgSBJVQqzuo2fYTFX5RM3gzODWBPUV
         QkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJeUsGrNnZQzzCLtjN2Dy6J69IfylXkxR5VCG0J4XL4=;
        b=iU4/pQXU4AFUznaNMVPOnTsT1jjSAq6RsiyudaLM0kCqiJP+XTywWWIl4MeBs8/72R
         sFVCVzHpy797A9g8YQBosN1E9iedM4vTIxDTLukJsqb/VUUMsckSXbe/Z/fhd+dNqVt9
         BwEbdtDDzszmsiMmZosLxKdVmO+bmofLng//FyB8dUZcl2qXMXemw+rDUc+UukwXY4FN
         kvdrhEDkkqj8JpuRG85KuTMe8VNHCHCPABgF9/SEPupJnEpUFo+W1EmH1gQpGE63suL3
         S9mXe33qehGDKQluaFi9Ee0cLisBvNhTjgMTM6Dq/1RQAske3oa2jgx4qCzbI2+yH0LE
         qs8g==
X-Gm-Message-State: AOAM532gytN6I7K/oJ6ouN2VsHhv9vq/IzBL0TALhFWoYjSZHg+fO5Qw
        cWrrBWJ06JrhLDRfCYB1Z1E=
X-Google-Smtp-Source: ABdhPJwdOIrLmAUrkakouM9M6o8P6wtwDp07lAY6IaaH+NHetOoY6XqgtLoZPcWVMzUxaAUCMfmVlA==
X-Received: by 2002:a9d:5a10:: with SMTP id v16mr3487579oth.187.1619108025645;
        Thu, 22 Apr 2021 09:13:45 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id m3sm730896otk.18.2021.04.22.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 01/10] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Thu, 22 Apr 2021 11:13:32 -0500
Message-Id: <20210422161341.41929-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422161341.41929-1-rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
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


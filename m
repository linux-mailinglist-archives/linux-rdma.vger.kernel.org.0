Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B72358F58
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhDHVlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDHVlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:16 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE20C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:03 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so851525oof.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaKJ9W62gXFqXqL13TVOCpJwu2mVOkvm8Y6DTgmvxvk=;
        b=nvVIzApWLRqHCC+TgS+XowvG9nBAS6V8xUFuOusVlvUoKt/OzSY7cnrCN1RazghB6Z
         I+JU3+DvEAag8qr7LwIo1Ae6AHOKYcHqweuxQNW06I1RqKXUjQwwA9Fu7SUyXtt0GGlT
         OFOTFeZFuj18BNZpLcQIx4sw0UNqFHB45S3B6eHuuGcyoEq2Q0NMTBaN/HzJOFMUm/Z4
         lHCNXelWMzxy9JIs3S2iijPn2ctQV9TseV8iYVJiS6CSWOCKLy9Jb1dzvKgidZsGpENh
         P+oJ9lvP4taWIElmG3K2k6+ScQ6sBLqSuShrnMd057sq42stBJMv7o1d84k0K2V49Znf
         RujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaKJ9W62gXFqXqL13TVOCpJwu2mVOkvm8Y6DTgmvxvk=;
        b=s4PZ3eaS1D1mRSnspeP8R+Z5fR4Lnt1FlVM3BlX+v4Ay4PPohUSeAXT/u7Fb68nRED
         PUE7NuNKal0LR6hrBSoHvRCLzB5zHQswVix+D5gOL0cw5zQoamYX5YOntt74V2Q2D5ew
         YD+bySx5J/ohJayGX3rdScSVigL/SQAcPGHkloWStWlaKRR9Wi13R+PIjqlNsPlpopL/
         XTdbSqiKbsvjwvf1BYVFFLqOBa+OMSAJuU91kNryISn2QFsTywRk9keIaLuR+M0thJbk
         zhwUfocP5iGREEvz9eq1KwShjYoWgrDQpA0hsmes5Iu4E1Mi0LKYuC0veej5RXMkR2vf
         q2ZA==
X-Gm-Message-State: AOAM531znfvfzJ7w2zDJEkL0rSXT+9AYy1xDMPD6p/zuSIu3nTiT9L+Z
        TLQFriNO/y5H8XQ57utKa2c=
X-Google-Smtp-Source: ABdhPJzjH1cOOmnsxvCcAAFKa+woehMQ8c7xH/tkp73wXZkPw93GvI/gU1XScWngGnOaTfvZ747mdw==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr9209166ooi.51.1617918063318;
        Thu, 08 Apr 2021 14:41:03 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id v136sm136057oie.15.2021.04.08.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:03 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Thu,  8 Apr 2021 16:40:33 -0500
Message-Id: <20210408214040.2956-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to
support bind MW work requests from user space and kernel.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 34 ++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 068433e2229d..b9c80ca73473 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,39 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
-		/* reg is only used by the kernel and is not part of the uapi */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				__u32		mr_lkey;
+				__aligned_u64	reserved1;
+			};
+			union {
+				__u32		mw_rkey;
+				__aligned_u64	reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} umw;
+		/* The following are only used by the kernel
+		 * and are not part of the uapi
+		 */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				struct ib_mr	*mr;
+				__aligned_u64	reserved1;
+			};
+			union {
+				struct ib_mw	*mw;
+				__aligned_u64	reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} kmw;
 		struct {
 			union {
 				struct ib_mr *mr;
-- 
2.27.0


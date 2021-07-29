Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270203DAF86
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhG2Wut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhG2Wuq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076CC0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so7487480ota.11
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/R0wIXOAOx3/OwhfrTMtZFTqyUixpX3jPEUzgt8Nf4I=;
        b=FD9IrG8v/4IEsAI7NJ4PbNnZxyw8MeCJOyJO3e2XlbR9420hvOqV5WKF0vKpDyZwQO
         dCw7ZQcYU71VR6Ly5uUqOFXOLsdnuYPxNfiE/lnemw4J6LqL+0yX9zTtL8LUXNarJMNQ
         cPJJOxIVw8ghGH0xnhOUIOBxQEMCkWArdN2+HeQo8evwB668NLUB+IcCtWHJPDejO0DI
         /+/fxpg55PAfkfo6pLgCM41ukfjQYu1GlWUpxv1MUhnGTkJo5NYCxRYCFsZaFU5SzcWc
         /yNYtOFNX7jG7UGd4ypvwZcAtHfPJD0PQIeC5WpYLjNnXPxkAcN/HpWwmsHNjEMQBlHe
         HPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/R0wIXOAOx3/OwhfrTMtZFTqyUixpX3jPEUzgt8Nf4I=;
        b=ZgJ5Kiw2oCOkkDlnJd7+x6mYr/TcY7r1GE8cFSkK1xvTrULRnR5/OWAEhF5/DOvQif
         KLMAnsICJcqHrHXHrgorI7fTactoMpJYI+u1KJ5G+UgmsYtLWsxG57E5DJAvFRVB1rdb
         G/uaaj16E9cqlw81dTJGlFsM1tkINaw+Ry8wWc15lFzdXFua1yqGHKhlBd6s/CJCg1eM
         Y+ooKLNNub/CvwP7WYrSuVqQlT3wx2YqIHSHo+yiPisG9clj5D8qNd03ZOR7UHnXwFqj
         pPjpOnynWRNun8VYnr5dVukGmYoGdvYYBuW6rFSHqum6yMphdVSIhicb6CjxaFlTEjbd
         kE+A==
X-Gm-Message-State: AOAM530WfUImlSFmcRWi6WmBz5kAPVWb+7qUjgTkgURWdafrTKVS94U8
        oyDZn9lIbzGzK2AS26wxZ9g=
X-Google-Smtp-Source: ABdhPJy4gfBcNEQD12Y5FNupCJXZ+R3rNvrGaWmxFgRevqAAzIaZWEXvWbzy9yIvQcHD2J1G1FnoTA==
X-Received: by 2002:a05:6830:11ca:: with SMTP id v10mr4967020otq.127.1627599041505;
        Thu, 29 Jul 2021 15:50:41 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id f26sm772430oto.65.2021.07.29.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/13] RDMA/rxe: Compute next opcode for XRC
Date:   Thu, 29 Jul 2021 17:49:13 -0500
Message-Id: <20210729224915.38986-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_req.c to compute next opcodes for XRC work requests.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 75 +++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3eee4d8dbe48..b6f6614a3f32 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -240,9 +240,75 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 		else
 			return fits ? IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
 				IB_OPCODE_RC_SEND_FIRST;
-	case IB_WR_REG_MR:
-	case IB_WR_LOCAL_INV:
-		return opcode;
+	}
+
+	return -EINVAL;
+}
+
+static int next_opcode_xrc(struct rxe_qp *qp, u32 opcode, int fits)
+{
+	switch (opcode) {
+	case IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_LAST :
+				IB_OPCODE_XRC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_ONLY :
+				IB_OPCODE_XRC_RDMA_WRITE_FIRST;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_RDMA_WRITE_FIRST;
+
+	case IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_SEND_LAST :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_SEND_ONLY :
+				IB_OPCODE_XRC_SEND_FIRST;
+
+	case IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_XRC_SEND_FIRST;
+
+	case IB_WR_RDMA_READ:
+		return IB_OPCODE_XRC_RDMA_READ_REQUEST;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		return IB_OPCODE_XRC_COMPARE_SWAP;
+
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		return IB_OPCODE_XRC_FETCH_ADD;
+
+	case IB_WR_SEND_WITH_INV:
+		if (qp->req.opcode == IB_OPCODE_XRC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_XRC_SEND_MIDDLE)
+			return fits ? IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE :
+				IB_OPCODE_XRC_SEND_MIDDLE;
+		else
+			return fits ? IB_OPCODE_XRC_SEND_ONLY_WITH_INVALIDATE :
+				IB_OPCODE_XRC_SEND_FIRST;
 	}
 
 	return -EINVAL;
@@ -323,6 +389,9 @@ static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 		break;
 
+	case IB_QPT_XRC_INI:
+		return next_opcode_xrc(qp, opcode, fits);
+
 	default:
 		break;
 	}
-- 
2.30.2


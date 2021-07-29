Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28F3DAF7D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhG2Wuk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhG2Wuk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1436C0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso7502415otq.6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9MjnPD/chnGGdYxbnuiVFdSjhRbZOHJIupfbQKJ8pc=;
        b=PypyLHZ5vWMZI5hCCVdwqOG75nTaWxWHpF5sogF/hWNzN2RgoA/vlZCSWxRR9Z88tk
         U63qq77KRdjKN6xkKvb/5FCKY/sM7q+nQbqq2dYVjrXOKcU6IJhbT9soNZpkBA0eypMl
         AOFcMa+ZEszT/TIJ+zEDDK61vJ0+AR84QIU35gEmU/CsqK6LX6+Li9qWh8za6ctbCQvc
         znXv+HdY6K8k37541H3eNIm3JUvji4tKbTEWbT+GCr0w3117x9D+kn9Rhu4jY0kT0OW0
         wUikBmtHJyGvyxgSkf+Sjx40roph+LCkourXgtj9NFGKj4wNEnK3N2ATwd2AMh0ebCiw
         VA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9MjnPD/chnGGdYxbnuiVFdSjhRbZOHJIupfbQKJ8pc=;
        b=Z4MEtzC9CMmoMIdGrwgfkDI0Nd7ZVlb5czDYz8hZZTZlOqFjN9UH+baDidiTj17CWm
         nbU+Bb1flFHlCctBEbq98GkgYp7mi4ih0bY3ln8Q/tsTehKDqMuO856aoKVd4auJrQ+D
         yaejy/SvVul7P+iOpL6D4RZhVjjkBFyXCW98mFp5RSIljYvqv4yNHm1DBQN5e+6gBpuh
         EH4/eBoCsAVUiFRkt0tNi4Du6A9sqgDOFo5TYOEgCv06Rvptb0jy3W3PzjKlxepiDT1V
         prbm/ykOJA1QuUV/1q7YHdBWcMt4+5u5WNXyvYmt+tlPzTCtC0iJYCGKrWjV6WLb2RnF
         A+EQ==
X-Gm-Message-State: AOAM533zx1jV8e/DczjGl40dhvBjrjhtFQN2U6e/vSDmnIk3TyMthOBe
        svASrTdPokzH2gPTzym44k0=
X-Google-Smtp-Source: ABdhPJzYnzvp0XJL3ysRE/9uTT/6E9aqYtCOa0iOqSbJIZMgK6XFJe8a2SJk/8o+0K0eFK24BEHgLQ==
X-Received: by 2002:a05:6830:10c5:: with SMTP id z5mr5002936oto.154.1627599035181;
        Thu, 29 Jul 2021 15:50:35 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id n202sm876070oig.10.2021.07.29.15.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 02/13] IB/core: Add xrc opcodes to ib_pack.h
Date:   Thu, 29 Jul 2021 17:49:05 -0500
Message-Id: <20210729224915.38986-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_pack.h defines enums for all the RDMA opcodes except for the XRC
opcodes. This patch adds those opcodes.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 include/rdma/ib_pack.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..afbf78a6669e 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -56,6 +56,7 @@ enum {
 	IB_OPCODE_UD                                = 0x60,
 	/* per IBTA 1.3 vol 1 Table 38, A10.3.2 */
 	IB_OPCODE_CNP                               = 0x80,
+	IB_OPCODE_XRC                               = 0xa0,
 	/* Manufacturer specific */
 	IB_OPCODE_MSP                               = 0xe0,
 
@@ -152,7 +153,32 @@ enum {
 
 	/* UD */
 	IB_OPCODE(UD, SEND_ONLY),
-	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE),
+
+	/* XRC */
+	IB_OPCODE(XRC, SEND_FIRST),
+	IB_OPCODE(XRC, SEND_MIDDLE),
+	IB_OPCODE(XRC, SEND_LAST),
+	IB_OPCODE(XRC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, SEND_ONLY),
+	IB_OPCODE(XRC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_WRITE_FIRST),
+	IB_OPCODE(XRC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(XRC, RDMA_WRITE_LAST),
+	IB_OPCODE(XRC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_WRITE_ONLY),
+	IB_OPCODE(XRC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_READ_REQUEST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(XRC, ACKNOWLEDGE),
+	IB_OPCODE(XRC, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(XRC, COMPARE_SWAP),
+	IB_OPCODE(XRC, FETCH_ADD),
+	IB_OPCODE(XRC, SEND_LAST_WITH_INVALIDATE),
+	IB_OPCODE(XRC, SEND_ONLY_WITH_INVALIDATE)
 };
 
 enum {
-- 
2.30.2


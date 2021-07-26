Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89943D6A0C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhGZWbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 18:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhGZWbw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 18:31:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D7C061757
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 16:12:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t14so12987508oiw.0
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9MjnPD/chnGGdYxbnuiVFdSjhRbZOHJIupfbQKJ8pc=;
        b=X2terY+7j6WcR0vYRJtU3oghni0JN6ZvdzBSh8mAlLrWOFIjmq2cZiRCRZSynal7QO
         uXC7TrPTbPhbNzX9OMcM7i/8nxdXNUaBfLF/f+whZ29WYuP+gpOZxaLDf+1uhdsNjeTr
         io0p7kbhyKm8FnPHfwkcWSWVfPsmSReLLgtsEFKAovJ9SC3zVad5yz+0QOhLUPgt1vPh
         RtrWAb4MTmMLDjxDXK7oUp3ljI1lwx1Rv7nj9/zlOTgSKL3Cf8oo06ad6RwdqydTCsFl
         Pc/y3PpWppEI6Rzq3uFEHXwGs2F2IUz0rsHW0vQI8SYp1UA7WF8Nmr1thorFkWtU1AQm
         NCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9MjnPD/chnGGdYxbnuiVFdSjhRbZOHJIupfbQKJ8pc=;
        b=XeO3zrSkwLJUTY2YjFMaD/cfPKsvzH7D/iM01x/4ZL8Ilt5h0uBKLOxNO1PIqNhQkF
         b9P6MWWNclqn10eIoaR5yxv27xPnV04x/PxpQMFd7MRqRlKCG4Dbu1WX/Gg2g6ypPpAc
         3aK+fz5/RtFWdODZ0FjlGf8CerIPpvmWdpRR0TYDGbob/dte29mKHoLGIcuzqvnCwHtc
         47782QC+nTy9iarYY9BiuzeF7hJaIpVJndsKPJKdQ13/GoudgE4hyS/w0sH/AwDyltiR
         hL1DI/rh3V0FXFndcPnvpjBReIqG13mhnX1bqIp00WSjSRq5YUVqIDD8ifl99dUf817+
         DiQg==
X-Gm-Message-State: AOAM533UXnblhRyxxUQ9NBRk3xGK/uEkmuATWlUjyPwSaZ0cHf2L5qv0
        JrPu50Sa0t7NcDbBrgM7/04=
X-Google-Smtp-Source: ABdhPJy1DMZaDFm8HKFoGeM642Sx3X+o+MzyIkh1atPezbKQ4Etlz4duJLyzzNQd7AgZ3iVObYHRjA==
X-Received: by 2002:aca:c412:: with SMTP id u18mr999775oif.10.1627341139343;
        Mon, 26 Jul 2021 16:12:19 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-f80f-33e2-d912-0c74.res6.spectrum.com. [2603:8081:140c:1a00:f80f:33e2:d912:c74])
        by smtp.gmail.com with ESMTPSA id a7sm222055ooo.9.2021.07.26.16.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:12:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] IB/core: Add xrc opcodes to ib_pack.h
Date:   Mon, 26 Jul 2021 18:10:10 -0500
Message-Id: <20210726231009.24020-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
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


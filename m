Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199BC71FCF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbfGWTBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46110 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391653AbfGWTBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so42888149qtn.13
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EqDChbKkzRP/kkIXXxca7ygw4tAja1zmZyruAsHAvU=;
        b=oTIcjnGsggk8W9LcbolM/i2hsh7PeL6D29qg93GmXDghMxUWcBN/+EnXA/uWCeGa4Y
         sVOkLlCoeIFjrqbsGiAOeSqjSN2Awo/z3+bBdViNVAy8YPEQYJmaP7RcGSeCAcqbP8uj
         //xwIIZSJl2kQm3pNDw+2EcPOxIe0NJ8z7LwmGOll1xN3AMI1cJXERrKVP/fTI+Eyzy1
         yvqwmBqH3v1U+ks3bcCn0n5c7RIaozj+KfUG9279AEx1C3sBoWtQnStZHgKr16Ahj+L+
         Vvknv7x82UqsqQmBBXduMTGgb4JT/f69KSSnUpHzWy7csF0mvehz4SLueW5bLrRDzuAW
         1n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EqDChbKkzRP/kkIXXxca7ygw4tAja1zmZyruAsHAvU=;
        b=uHXzef00uPRhysjGr7bxbaRris3RL1tsqjlFDV2U+sfb7mZdlY5sBFhpX1EcKaD8PB
         aEH4hixCHbZgFaX1IJvxHZM+y7jRISsoyw5JKzF5baaqcBOqoj7dOty3QkJMrFv7Wn7Z
         t4SET44jAqgc6qQpBGtuX0Wyhs4wr5qLBhvEEKLvFkJd04HaF8tuCfIQM9owF9b5AVAR
         ZHlfkj21Xbv0qnoZzdu1iLXQwJm/YkvyRSZI99JsuDX7HNr+F1hWUvkU5gaP/ARDzfeR
         za3KjpajDMuiBv+d63FZYtqGx75g2nbdUcYbM9N/AnWfFR7lkJ8o6oZjT7YSsyTmAZhR
         /FOA==
X-Gm-Message-State: APjAAAWN3yI4a4e/JEZiPHURoiN7EVIE+CDXNP+TIpLirArp6Ib5G8T8
        gEDPs9chSz1z2U/51x+/hCW6tBPwOEeFyQ==
X-Google-Smtp-Source: APXvYqy/LX/2E3GTLX4O9/ewRjcjD8hDJLDoIL/DfEesV3wfOQH+9QTNAnAd2HC3XKnClfka1FTpBg==
X-Received: by 2002:ac8:1750:: with SMTP id u16mr51649419qtk.90.1563908508134;
        Tue, 23 Jul 2019 12:01:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d23sm18627126qkk.46.2019.07.23.12.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00043x-AL; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 02/19] util: Enable uninitialized_var on powerpc
Date:   Tue, 23 Jul 2019 16:01:20 -0300
Message-Id: <20190723190137.15370-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

For some reason the gcc 8/3 build for powerpc behaves differently from
AMD64 and ARM64:

../providers/mlx4/qp.c: In function 'mlx4_post_send':
../providers/mlx4/qp.c:478:22: warning: 'ctrl' may be used uninitialized in this function [-Wmaybe-uninitialized]
   ctrl->owner_opcode |= htobe32((qp->sq.head & 0xffff) << 8);

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 util/compiler.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/util/compiler.h b/util/compiler.h
index 16f5ee14be2a8a..dfce82f1884149 100644
--- a/util/compiler.h
+++ b/util/compiler.h
@@ -7,9 +7,10 @@
 
    This is only enabled for old compilers. gcc 6.x and beyond have excellent
    static flow analysis. If code solicits a warning from 6.x it is almost
-   certainly too complex for a human to understand.
+   certainly too complex for a human to understand. For some reason powerpc
+   uses a different scheme than gcc for flow analysis.
 */
-#if __GNUC__ >= 6 || defined(__clang__)
+#if (__GNUC__ >= 6 && !defined(__powerpc__)) || defined(__clang__)
 #define uninitialized_var(x) x
 #else
 #define uninitialized_var(x) x = x
-- 
2.22.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A801B5990
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgDWKsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbgDWKsV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D72C035494;
        Thu, 23 Apr 2020 03:48:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so6296320wrx.4;
        Thu, 23 Apr 2020 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uuN7SEmlSjuk+Gnycj0hvsm+gRKwErsOSGKcMr+0EhQ=;
        b=CZUrI6YCFd+njEqy/2DIIl4dtBH1jKqNXw/SKMpVQS2gayA3J/aktDz5duwVPUyy7K
         4piDfz7MuxJZ6WBrTb5zhDPW+hWbY6j2ahbeq3Ytai2f0mfqQC90UzUNWnjXqyDTNmMF
         gxzdMkwSEOZM4M8tKSO1ypJ7fbVkaCpX8yM10NEs67DuhAIa14UlfuIsaLr2pEDidPfO
         15Zar997tKXzi0t+rM+VIttTsNrBvKQaxkwiowGG3/lXje7tr1hAOZv9wVGhytoP1q8I
         Rr6SbNpd7J5kV9IoPiyPzt2Zqsq+eM72HZEnCRoa/m1EOdC60lixUq1DIu4HNBR7gdkO
         Dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uuN7SEmlSjuk+Gnycj0hvsm+gRKwErsOSGKcMr+0EhQ=;
        b=pfan0yG4m9Rk9RogsBW5onH3ZpLhEHSLdSj28o8S7tTvzGxUtmo75M8vQM9Wo7ADvV
         k6Cg5SehisCHJlIuTI9w2J2BT/PW1Kw8SBUUZcGjOp4XDQboFaaeYuuZoz4lDOWmc1Ob
         1gpClLXSx+ZRCKxKG+9rv+ociRt+sXkwiiCpXLfwv7hlC/iq6YXzk9DW1szF05t+5u5u
         O/BBdkiCbafysYpBASf+EpdTdtMV6U77QI7jew4Oe194nnPlnOSYjHwHP3DHxB7EL6nz
         tKdoN/Ufum4SJ8wtsd98SZunbkQbRxJn8pCaNSHiFZz/aytE0dxpnON74X/T+0LHJ3rj
         Cw7w==
X-Gm-Message-State: AGi0Puby/MntTZ1uFt4r8zSlg/vaBNVUCTmB2toYgxOwVxN88/MUVevt
        khaD9rRMde/MArYhypKJfWE=
X-Google-Smtp-Source: APiQypK4ida8yQjISROyeOUjx9VZqo05aKQK380fTUucftS7WRI/tOewVY4IqlyW87KeC+6GZ/qExQ==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr4523790wrt.394.1587638898409;
        Thu, 23 Apr 2020 03:48:18 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id t20sm10182007wmi.2.2020.04.23.03.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 03:48:17 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] RDMA/rxe: check for error
Date:   Thu, 23 Apr 2020 11:48:13 +0100
Message-Id: <20200423104813.20484-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_create_mmap_info() returns either NULL or an error value in ERR_PTR
and we only checked for NULL after return. We should be using
IS_ERR_OR_NULL to check for both.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index ff92704de32f..ef438ce4fcfa 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -45,7 +45,7 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
 
 	if (outbuf) {
 		ip = rxe_create_mmap_info(rxe, buf_size, udata, buf);
-		if (!ip)
+		if (IS_ERR_OR_NULL(ip))
 			goto err1;
 
 		err = copy_to_user(outbuf, &ip->info, sizeof(ip->info));
-- 
2.11.0


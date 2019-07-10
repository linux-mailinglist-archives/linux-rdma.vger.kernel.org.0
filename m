Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B444564BA5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfGJRsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:48:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37551 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfGJRsh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 13:48:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so3400979wrr.4;
        Wed, 10 Jul 2019 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8fIYGOnbY2PFzbfnUK43tHMN478L4aKmgR2+ZvIFyU=;
        b=QrfRaAD2NzhyjaCy8AgC3Q460qjKsJumT+IyPq9HD6bJLGc8cR/rFR15KrTc1yGKpR
         nIQgJu/aQD+zMUsIh+l36K+BN20OGjBqcnbefTEATYWqi+3gOoGSsdMb8oCa7n79eWZW
         A6xCyISMInyBuaIYus9jjQ1N/E8FlHuJP110RQ2ZOTYFIB7AXU2xCRtg3qhHQwIeWsOz
         gLIjZrLaCOnStVswQrfIlquE3e13y05+wsIGDrw9f+Sen/uZHRBS5jlVQROyaYIzAOh/
         YnN2rzodcHzb6V2OzeQjA5FXlVXPloGSXSCb+q+l7xciqeOm0ASKaOhrYmkoIr5CYqaa
         vEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8fIYGOnbY2PFzbfnUK43tHMN478L4aKmgR2+ZvIFyU=;
        b=Wljlys2VQ84/xvKnpols6GM8+HSTTMNKbUuUGGJoFzDW5IqQgVXPwsK+c3xnMIfo3B
         csjJLs4vi+ltZ2fUZuxSLWfT3YdpfqOV+z41VQsWo5gvMyaHVLsY9jXHpezZ2BGHTD6R
         8vcjBnygPy3ay+fyFi1dTS9r8TKoanLFhqVObd/9/IW1Q9agnJE4DPXfWzqNahoPR/ky
         m8a8edTnW3+U6mga5AGhfiRg061xlFCFEwNPmDJVv7PFh8kWJVdFzrHwVG85U2spuRnz
         hQatxW41hxZAvb2FpvFQIXdcLl4NONGcUTOsct1nxC97gom8RXWyZXXpFOCR5xHZ3nI7
         xPCQ==
X-Gm-Message-State: APjAAAUvkm33CowPsZlKtqGjpNz8xJVvNDDzme/MDQbpZKOixu+R7UrD
        lhw06dZSYQireipH+WP3Pxk=
X-Google-Smtp-Source: APXvYqyYhmfI3q92p3NtWJwfqP9FVTkXjTcUvhddEfjVskY9dIeDfZmO5T3ij8BrMHQ32adyFskNdA==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr5346474wrj.256.1562780915011;
        Wed, 10 Jul 2019 10:48:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t1sm3891228wra.74.2019.07.10.10.48.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:48:34 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Date:   Wed, 10 Jul 2019 10:48:00 -0700
Message-Id: <20190710174800.34451-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

clang warns several times:

drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
from enumeration type 'enum siw_wc_status' to different enumeration type
'enum siw_opcode' [-Wenum-conversion]
        { SIW_WC_SUCCESS, IB_WC_SUCCESS },
        ~ ^~~~~~~~~~~~~~

Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
Link: https://github.com/ClangBuiltLinux/linux/issues/596
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/sw/siw/siw_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index e2a0ee40d5b5..e381ae9b7d62 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -25,7 +25,7 @@ static int map_wc_opcode[SIW_NUM_OPCODES] = {
 };
 
 static struct {
-	enum siw_opcode siw;
+	enum siw_wc_status siw;
 	enum ib_wc_status ib;
 } map_cqe_status[SIW_NUM_WC_STATUS] = {
 	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
-- 
2.22.0


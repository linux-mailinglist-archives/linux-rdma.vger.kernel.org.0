Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D31EEF83
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2020 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFECb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 22:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFECbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 22:31:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A707C08C5C0
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 19:31:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so6449003otp.8
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8MyNQtdRpGvP68sV+2z5piJL9WeVTzfS8xf3j6KzUs=;
        b=YBmZ1mZ6AZd5AdSwntcGvvdecAVc/yc8d/MAk1JWE65vOI3zmhpT6egzuU7KIZ1W1s
         rDwIXiozFUfDVfHJrLTRWGrpjc6JgJMkKqNWMQ6B9D4VnfIAwWKVsHWye3rGfn7VoitP
         qaBX78Eo8/4AbIKs7rksUNzTyuEzxzjBJ0Q4mnZgLbfcehxryjDB8m5C+RrKu37SNGz5
         TAfUQOz4T5DQJ0NLdt87CTQfopM7NbjR+1A7RZejjoopuZnLDDx7LHYoxjKUBLqR1iSA
         dZExC9H9DZkixwsVFSJZ+OC5EU087iK9BxDIEnflc8CAwEk8Ct48o4yRW2JL5HvaoWoq
         O5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8MyNQtdRpGvP68sV+2z5piJL9WeVTzfS8xf3j6KzUs=;
        b=uDjiiS11Xns+IBxEgIOcpeFgX0Qu2gl8WetzN2S+BgBYldi8+x5h/3rdYN8HfyUKGP
         De7pp4i4U2PKP4dfuB7XA0xUM0zx90TdNtIcacA3FbOZqTQCY3W2sNXMChJYR0dvFnhT
         m8/JQxdWpYV9uCTEjDvzv7EDv+jptFT9D0J+l7arLcNqNPoM+0XAInLxsggEoADtmBLn
         2RXT9FpZdhkNCgPxwYGXzlfY0vS/44m3O6b0QndujBHxii6a4fbKpoQCFyR4P2JTYNWd
         Rb7VsGqnLFnCsv3/eAfuigg1CZNQug2szyvFQOXSCOTshcj+DFDyGGMMFJiJJLag5+9Q
         PlPw==
X-Gm-Message-State: AOAM531tH9VqfQo544dQGt2Xi7+6h7KTPW8kbER5XSKK/HSc16jS9kFv
        XntA1FPX3vQDMBknnUGcpTlxc7vtktE=
X-Google-Smtp-Source: ABdhPJxj5HpJzWCSzp874/HEqTuA+tM6n3+KGkqENdEwnjbS+LS1rlKWCci4B11kEaJMpQQHa1CaiQ==
X-Received: by 2002:a9d:2de4:: with SMTP id g91mr5781327otb.90.1591324283396;
        Thu, 04 Jun 2020 19:31:23 -0700 (PDT)
Received: from proxmox.local.lan ([2605:6000:1b0c:4825:226:b9ff:fe41:ba6b])
        by smtp.googlemail.com with ESMTPSA id y23sm1656770otk.10.2020.06.04.19.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 19:31:22 -0700 (PDT)
From:   Tom Seewald <tseewald@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     tseewald@gmail.com, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] [next] RDMA/mlx5: Fix -Wformat warning in check_ucmd_data()
Date:   Thu,  4 Jun 2020 21:30:12 -0500
Message-Id: <20200605023012.9527-1-tseewald@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variables of type size_t should use %zu rather than %lu [1]. The variables
"inlen", "ucmd", "last", and "size" are all size_t, so use the correct
format specifiers.

[1] https://www.kernel.org/doc/html/latest/core-api/printk-formats.html

Signed-off-by: Tom Seewald <tseewald@gmail.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 81bf6b975e0e..e51b39632605 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2907,7 +2907,7 @@ static int check_ucmd_data(struct mlx5_ib_dev *dev,
 	if (!ret)
 		mlx5_ib_dbg(
 			dev,
-			"udata is not cleared, inlen = %lu, ucmd = %lu, last = %lu, size = %lu\n",
+			"udata is not cleared, inlen = %zu, ucmd = %zu, last = %zu, size = %zu\n",
 			udata->inlen, params->ucmd_size, last, size);
 	return ret ? 0 : -EINVAL;
 }
-- 
2.20.1


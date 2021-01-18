Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E242FAD5F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbhARWke (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbhARWkR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CDC0613C1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v184so10832042wma.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lb2XS7ZcCtCLtyoYlVUinWRuYfofz6JXw77zijmyJYg=;
        b=Ldiw4Gf0MTjFaVnLoy3BL0N2vcjdNOhGNDXm7HKgYWZRvPPxnQstMp2LQDiAGHnwgX
         Jaj9bPk6owNN9mKasD6NHZSDfeWyaYRx4gMG4PTd8Dyxy5r8OSEqODiisiHXlhdafqL9
         DVKIPa4txhh9XEBj5AMRtH+X4xk2RjjGiMsLAl03tRb/dWQ1z54l0iQnNUWi5S7O6wFx
         MCPcEqlRAyOCJaXek9qWZGK50J5nEzQYpAbY6qkcWby8h+Gs/15bfzHPt6kwRR9Spr5/
         tTCJT2bOKwVR453Ieax62/Xi868qYEXWf0s4F1akX2jTxtEseA+nX8nw/0IRAmyor8IM
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lb2XS7ZcCtCLtyoYlVUinWRuYfofz6JXw77zijmyJYg=;
        b=qVuob4CqucNBGNAa9H6QdovYGoApDdxWfCsTZZzO1kq2M8w5s6WAzmWV3Wjoh4WoI4
         JnDrgeVpzkUz6A97d0sr+gTjjRXeERLivKb5zCKTBflXxEgHb5IOwNSLEoGCZ7hT91Tj
         +lnBmdNO7svfPQYWoUOL1K9Y/CEJepOB2jN5+4u3PcTqpG1OnnGA3xytfh7V1tMU3PwE
         PNQarNJBIp9qGyKVwFuIriE07G0g7bV2ta3HYxxlqkyFYkEfSPFqn0JfD8QtInEE/zis
         viaYy1CngKBp5R1m+oNVxja1UyPh5Q1JgmhP4cDs9BKN4V0ncq/k4vDx8x090WcDDNx4
         WJXw==
X-Gm-Message-State: AOAM532NlNTKu4RpuNih4Oz9h8+YwIdXISafkAjXrfHgoISIWKhggtOY
        auqGJfB7z3TDoyUOb8cGnb6iIw==
X-Google-Smtp-Source: ABdhPJzb2OOIk7V4VE8x9T/jFz45lKgw4h05aD3bvL6OmlPKNIuUnLRRIpHwQBtKJzWQ/FxLNp0Zvw==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr1314240wmi.116.1611009575415;
        Mon, 18 Jan 2021 14:39:35 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 02/20] RDMA/core: device: Fix formatting in worthy kernel-doc header and demote another
Date:   Mon, 18 Jan 2021 22:39:11 +0000
Message-Id: <20210118223929.512175-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'ibdev' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'client_name' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:1896: warning: Function parameter or member 'res' not described in 'ib_get_client_nl_info'
 drivers/infiniband/core/device.c:2328: warning: Function parameter or member 'nldev_cb' not described in 'ib_enum_all_devs'
 drivers/infiniband/core/device.c:2328: warning: Function parameter or member 'skb' not described in 'ib_enum_all_devs'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e96f979e6d52d..3d08373c77979 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1887,9 +1887,9 @@ static int __ib_get_client_nl_info(struct ib_device *ibdev,
 
 /**
  * ib_get_client_nl_info - Fetch the nl_info from a client
- * @device - IB device
- * @client_name - Name of the client
- * @res - Result of the query
+ * @ibdev: IB device
+ * @client_name: Name of the client
+ * @res: Result of the query
  */
 int ib_get_client_nl_info(struct ib_device *ibdev, const char *client_name,
 			  struct ib_client_nl_info *res)
@@ -2317,7 +2317,7 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	up_read(&devices_rwsem);
 }
 
-/**
+/*
  * ib_enum_all_devs - enumerate all ib_devices
  * @cb: Callback to call for each found ib_device
  *
-- 
2.25.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF803FC458
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Aug 2021 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhHaIdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Aug 2021 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbhHaIdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Aug 2021 04:33:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A20C06175F
        for <linux-rdma@vger.kernel.org>; Tue, 31 Aug 2021 01:32:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e16so13940684pfc.6
        for <linux-rdma@vger.kernel.org>; Tue, 31 Aug 2021 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAQVtgUEPRr97ihKAwZy1MloqoUFALoP75cloMgBIV8=;
        b=J+h/dvbsz0USH078NzHtq5ZzuCku4ZigRjbcpFM8Yhc/mj6AhcVZ9CCS4F22/dW9OO
         zyv/oqRRkzpfPD8tUQEvKznSgu1nzr7ze2vYfwtG9sjLk1Ywi1BM86qczNLlqvHnB+LD
         v2qWyPas4fihZR4BXQGHtVr7Z5FEGZgxhuysX6YYKXaqzr6aPotV8IjabY+F0QFD3qDM
         BplIAbhb2MZ+QQccYQn6RkAFd3t+ra3zZCFq1LLX/IOB+5qPLbH+U7Hx0Q/og3SHPIW7
         /c4KP2aIdXLiLp5jtppuClNVuXurzqRdUiNuPPlqpLOQxFuOvOTl1VTmXKZicVXXkCAC
         g+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAQVtgUEPRr97ihKAwZy1MloqoUFALoP75cloMgBIV8=;
        b=Up0pUyQOZ5c4ibC6JKlVBr/+4klC8tYGrzklS6dbxGybVmS47dBB0dMC3XMlC9wY3j
         v1fiZyE39Ec46JgBYWcU6H2iYexAaTy3lovXgUl93/wdFBzoRjjDl9XvnLbWSDJjq5JS
         EP4ku04k6SlsIeiTi/5rq1e7/oU+NCQ/jtpmFt3Ogzh4IKgM3vpdnIkEfmfuTd499hSY
         TtkfSHUl9cdK6YFX/HztUSLFu+0SOiX29gTccjqHFkCG+tgegBoVifJfSFCWEwVYlzOq
         iWOI/bnFJiWo1vghsvU0K8HYH6yP42sdvm1Gg2Frq9a3I+n+GfSs83Oko4QSL+XEu0x1
         keuw==
X-Gm-Message-State: AOAM5300cwZh5J28y3xfChxwmPH4twG7FBrFWC/LAhZNUXHpMRf/ZBpu
        il570L43sJIHIxetdTeC+sAP50hYBuLmBA==
X-Google-Smtp-Source: ABdhPJy0oWfGeIngigGVRsDq/RJJvUf9qSb8umAVMAFs5+/NavCDEv/9oOQWjvUbnCnbQVQn4RrXPA==
X-Received: by 2002:aa7:8e81:0:b0:3fe:f212:f9dd with SMTP id a1-20020aa78e81000000b003fef212f9ddmr10375523pfr.46.1630398771432;
        Tue, 31 Aug 2021 01:32:51 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 192sm17545769pfz.140.2021.08.31.01.32.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:32:51 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, Junji Wei <weijunji@bytedance.com>
Subject: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
Date:   Tue, 31 Aug 2021 16:32:23 +0800
Message-Id: <20210831083223.65797-1-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The port->attr.port_cap_flags should be set to enum
ib_port_capability_mask_bits in ib_mad.h,
not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.

Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..b5a70cbe94aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -113,7 +113,7 @@ enum rxe_device_param {
 /* default/initial rxe port parameters */
 enum rxe_port_param {
 	RXE_PORT_GID_TBL_LEN		= 1024,
-	RXE_PORT_PORT_CAP_FLAGS		= RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
+	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
 	RXE_PORT_MAX_MSG_SZ		= 0x800000,
 	RXE_PORT_BAD_PKEY_CNTR		= 0,
 	RXE_PORT_QKEY_VIOL_CNTR		= 0,
-- 
2.30.1 (Apple Git-130)


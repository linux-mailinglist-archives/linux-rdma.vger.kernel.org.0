Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C0249382
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHSDl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:41:27 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17920C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:27 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so19877422oie.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=JFh/ldqdYF2306KGGvnaWXyJWYrVV4b6Io4Uw0oMAVmsMDzHxFMikOk+46zClZTAsX
         nnZ+umj3J+HiXM70Sxd8eqHVxaRoTo2ectBTucbEB8ar81+njBm3O0+pUo/4HqCcHFEt
         lfHzMpuXHpeNM+TLXz3KnNwJCqRIOSs2KMNvQGyP4H9Ouo5iZlkNszO3hyprRFMOl1cD
         pz2fZQePQVWfIVvnwG8ICbzZ7aC2Jw1qQmnlocfap8CL8fKBQG771O870BSGEVRkcumP
         HXkR4+M0UflWtRK0uDOKX6cRqZ1uzMQKsnShv0Iquxrv8r8FjMpLy/ml/+7Cra3xJv/G
         HY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opQ5PQYAFjcFf54uc0HWsHLrSgEnDQ3xUI0E2iiCI/g=;
        b=dRAATlh/rE+71LZJnJRmV/ZGCBglYezPoy7lxCuqKpq9O8YuFFrLhhikY/DE0s9oiH
         WIe45gPjKfSdKCEb4frQCTuXHYX2MNJJ5Y9nqF7G2tC//YQ1sWvAghTtniPGr0OPlGLW
         v3RrDWMZDUIv4XT3vE7PFdDRhvveB6QH4p8VXb1/EzL55+eMEEB6g8x4zbapXfscE04K
         l99J+11Xeop1/oNHIA5cxzqmX5KnV1ikhFlZBjKDAIx5AqW/LtfNYG9FZrySRvDXcx4O
         6J8XY09QSBolfYUFTMnCJQAC8yJpnEl7ZPxp0vZ4FrScRM0coJbuwwMR9W1rjg+jqJ6+
         mfEQ==
X-Gm-Message-State: AOAM533E+ZBdmSm4uHLB+Wy3QHb7+W0AkldT9vsLz8j4b6F69XGaVDVJ
        CVu6pOuVpIXWhGv6bctoCTg=
X-Google-Smtp-Source: ABdhPJwNpAyrXeEXUSH7CIkExg52qYrnw6Y+hWUypScWqjW7FNpNoeHLH36GITQb0F/Cagok98kxhQ==
X-Received: by 2002:a05:6808:ca:: with SMTP id t10mr2096696oic.71.1597808486583;
        Tue, 18 Aug 2020 20:41:26 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id n25sm4353053otf.64.2020.08.18.20.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:41:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 03/16] ib_user_verbs.h: Added ib_uverbs_wc_opcode
Date:   Tue, 18 Aug 2020 22:39:52 -0500
Message-Id: <20200819034002.8835-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This enum plays the same role as ib_uverbs_wr_opcode documenting
the opcodes in the user space API. It plays a role for software
drivers like rxe.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/ib_user_verbs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..456438c18c2c 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -457,6 +457,17 @@ struct ib_uverbs_poll_cq {
 	__u32 ne;
 };
 
+enum ib_uverbs_wc_opcode {
+	IB_UVERBS_WC_SEND = 0,
+	IB_UVERBS_WC_RDMA_WRITE = 1,
+	IB_UVERBS_WC_RDMA_READ = 2,
+	IB_UVERBS_WC_COMP_SWAP = 3,
+	IB_UVERBS_WC_FETCH_ADD = 4,
+	IB_UVERBS_WC_BIND_MW = 5,
+	IB_UVERBS_WC_LOCAL_INV = 6,
+	IB_UVERBS_WC_TSO = 7,
+};
+
 struct ib_uverbs_wc {
 	__aligned_u64 wr_id;
 	__u32 status;
-- 
2.25.1


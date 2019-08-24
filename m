Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4219BEE1
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHXQqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Aug 2019 12:46:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38929 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHXQqi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Aug 2019 12:46:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so7720822pgi.6;
        Sat, 24 Aug 2019 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ltb6VREx479pvKIqHb/++NdQYS9lzIX8qGSfLsJGfA8=;
        b=mngzlxNAHsCaCw6r4DSsj6cBqeE9vK8cHnH52g9J87buWUE2f6SvlDXzKYrTWVKSV+
         JmLPpS3DaVVlWivouAs6SyCdjhBc5nCZUmMHNlgL6mMcpdGYWd7vd4gAjnlEv0IRsvBE
         s0ANk2LfMHCeF6pEoEnAhdg4MKts5D8aUrTRQr8FOuykskQN2Sut2ZLMDAGLJ/TL9jVm
         97XAXaxyfoRsOSkgUKGvacMu6LAA9uIZ5s+vSG0x0OdaJEB03SvjerlK6duZO1NWnQL7
         6L7kurbuqrsedxagpmKfHUkVbxLRi0SwbDDv2kCaCYwdYOPip8/QkGK7Qh2GPt4IusCn
         EIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ltb6VREx479pvKIqHb/++NdQYS9lzIX8qGSfLsJGfA8=;
        b=HdPOfchkz3uj3ya/JW+X3wNB1MugrfwOC9OOAYn3F46xp8/VQjAw7xxImVDKKY/fEe
         pLqpgEtJyi7c/hNnMjILM3aWl4G3FyK4CyStO4h7NxmRu1VF1y/Iktd2px6nRjqoz74/
         IvDmkrRv2sCU9AJxVK7d4gSFzc3/jO0Zj9S15Y5r9Pbxa6Y5RLGSy+3Sc9lVfoQOHvJp
         3NlKtOw9RF4yG6pHvRU4yQmXQlstkKZyfrF4mie32+s1u0W0FQsJOcCFAjcXTLwh6JwW
         x7LW1KlbSLIVkdrPxyGtfJW6HzY1zCBxyzSUuPgQhP9qYp8mZxmItB+Nv6TB6lEXA4u4
         p8Pg==
X-Gm-Message-State: APjAAAUss97q8Mvp6KBrUjAWkz1vserJ1LPKtQVge8UE+BHXsmEfmMHU
        nAHx5tuHcGHy3G7aIw6OHEY=
X-Google-Smtp-Source: APXvYqyJnrBvt/8og29GUcn1DC2jOAl4WNe/dSEAk0y++bQsU7ttBrGARYYcKlDUlCPiAdJ/SRxdMg==
X-Received: by 2002:a17:90a:2841:: with SMTP id p1mr11253686pjf.101.1566665197514;
        Sat, 24 Aug 2019 09:46:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.17.2])
        by smtp.gmail.com with ESMTPSA id z16sm8921213pfr.136.2019.08.24.09.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 09:46:36 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] RDMA/mlx5: Merge two enums into a single one
Date:   Sat, 24 Aug 2019 22:22:26 +0530
Message-Id: <1566665546-8209-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These two enums can be merged into a single one wihtout effecting
their caller if those were created without intension.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/uapi/rdma/mlx5-abi.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 624f5b53..c89363a 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -461,13 +461,10 @@ enum mlx5_ib_mmap_cmd {
 	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
 };
 
-enum {
-	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
-};
-
 /* Bit indexes for the mlx5_alloc_ucontext_resp.clock_info_versions bitmap */
 enum {
 	MLX5_IB_CLOCK_INFO_V1              = 0,
+	MLX5_IB_CLOCK_INFO_KERNEL_UPDATING = 1,
 };
 
 struct mlx5_ib_flow_counters_desc {
-- 
1.9.1


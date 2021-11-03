Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F56443C54
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhKCFGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKCFGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC5C061205
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o4so2072745oia.10
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO0fRe8QNX2ywAC0qpeXA7zo+R0jj+fx5KipFF7q5F8=;
        b=edmM0QL+cLqMzD0Aa/LDhpQGruzRVn45T9rMWsL82RUpbpfdZyJunX+KQQLYtZfhS6
         EMSbSIzg1HY306uxasPYnh+yCTJUiALZhcakKLjVREn11Z2G/i9ubzzG4rE6XW99MoIi
         NEmHqLqLJyM7ZEeOI858FkuL6m2E4TgvxljWu6Bo9EsguNGiEsk5MtxmDh02BA49Qf9f
         OKmx3pnqG2VxwfopVpCUlN59/+GTNpU7INdS6lNWWitj61ZSR7ZUINOLQGoDnHzZU327
         jniqUzlT2ep8f14op2mybMX/O5BbldyxKyCLzYBf2UFyxykWCk5Aa9xQTmFZqiHxx0iO
         5/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO0fRe8QNX2ywAC0qpeXA7zo+R0jj+fx5KipFF7q5F8=;
        b=GT3rfH7+5EhzpHLXnDgq+MwztGm21zrxZzX5RV5VkIPnyBZypGs7hd2L9KpaXL9a9Y
         NvlCz4xyb+UMg4tT9DJ+C6EH4pV7BjN/IOyaRGOHNHHkP1no4Kxg4Cy0mBRTNzL03nMz
         oqgooXp1G3fSG9leXvSd+lqjrFYP1vZ8Cqpg4FpAOnT4PfP2hTfKJH+mbowyOA4fR6gi
         5FHIar2lx6c0mMmG3A9bVxJOzMvg/zRBPBP5JrTp6cAgpH0a3aA724M3D1J22h46bdm9
         6Em/lzLO/Zdqw4cLi5EVbPuxcTzA62OMekxzChBrN7LgfAlQRMPkcKtRctPxK+2B6b4V
         T44w==
X-Gm-Message-State: AOAM530RminB0JZfWLrsgLgyKFOYjBNFbgarpbM26lS9HMtc/DYq2MWQ
        CoSq1wlFJbdkNEkkbnZJQgwsh/m7+UM=
X-Google-Smtp-Source: ABdhPJwQIoSjjmPCdf0NJ31D8XanL5YBQOMDIK7bi65vA3YZrRCPvPfnxFq5Cm0j1GE0Q2Cxvr/wxw==
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr9308253oid.54.1635915819400;
        Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v4 for-next 07/13] RDMA/rxe: Remove some #defines from rxe_pool.h
Date:   Wed,  3 Nov 2021 00:02:36 -0500
Message-Id: <20211103050241.61293-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RXE_POOL_ALIGN is only used in rxe_pool.c so move RXE_POOL_ALIGN
to rxe_pool.c from rxe_pool.h.
RXE_POOL_CACHE_FLAGS is never used so it is deleted from rxe_pool.h

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 ++
 drivers/infiniband/sw/rxe/rxe_pool.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ff3979807872..05d56becc457 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_ALIGN		(16)
+
 static const struct rxe_type_info {
 	const char *name;
 	size_t size;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 163795d633e8..64e514189ee0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,9 +7,6 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
-#define RXE_POOL_ALIGN		(16)
-#define RXE_POOL_CACHE_FLAGS	(0)
-
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
-- 
2.30.2


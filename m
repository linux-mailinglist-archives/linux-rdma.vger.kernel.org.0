Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0530B425DBD
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhJGUn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhJGUn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:28 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A08C061760
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:34 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so9038136ota.6
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=fNn2ZisNjPf5g7UiC4S6LFZhDEpLzy7PsZuXxVZu4jC5o1QpKZ3gG5ITuD0mbUR+/C
         pjkkPZh9rI0b4Xy1vcklP7xPwIfK6E/iQYc2fzONQB8NMPOM2pI8f9hFytYrEbQAQKeg
         CHbrFDsuMOWe3lOcD9cN48PIGo1Ie8oYR1PC6sPhIJJAqEL97zZLcLmZGHCdIN1ExnLL
         xCLZFMf91pyjeR6MJQkCwEbsz55HoklpI+Y3RoZe0LAFtGkxoGqTe0FK9+IjHDDRH8lo
         J7IaT3Izdg5+cYCBtjpjrHwaDOaWTrcCQRdMbqAUk9uPJpVU01cxModdxBStXTrIAyCj
         ZCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=IpX+qhfn6jZnhvMyxPaJN64axO62wmtJ8BOUOJDfJlybOLC14foKG2BIjzcTCHmfPc
         YnG7c58OQxy9peTx/if5CaTJ+intFgOwOLFlOJ9Bl1a6LKB0pq1AceiqAltjwHk1WSDG
         MC2HHM1VB1qnzyEKPfbblqysyikGt8QDaYHuyH4+GdlWnrwsHvDNmED1nt2E93Xf7uIH
         NPiDjs08SQPA9UmcQpHU10CgWynfkKco8df1OOEEDqaVAgpUJWcozsjrYNLIMYS4kI/m
         bqWG+2cESzcE68vEtq6lFS9AWa2Qn0wbA7ZL9o2PWQg5tYgdz7OTXkcmosTWu2QSMm98
         vaWw==
X-Gm-Message-State: AOAM532IRRvYEWGK0tYnL0PtJjt78KlwD2452CuWDQqRrINrWGPvBnUB
        TQ09hFSqy/MISpjONeXvlKOp/Jt7lSI=
X-Google-Smtp-Source: ABdhPJxWaMkPHVg8VwGAP44oCsEdE9PnjCjecWkjskQ5s/DFE9sjnUsvZlj6FvtuAso3VRvYSY6ieg==
X-Received: by 2002:a9d:1b4d:: with SMTP id l71mr5439794otl.188.1633639293997;
        Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 4/6] RDMA/rxe: Replace ah->pd by ah->ibah.pd
Date:   Thu,  7 Oct 2021 15:40:50 -0500
Message-Id: <20211007204051.10086-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pd field in struct rxe_ah is redundant with the pd field in the
rdma-core's ib_ah. Eliminate the pd field in rxe_ah and add an inline
to extract the pd from the ibah field.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 9cd203f1fa22..881a5159a7d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -46,7 +46,6 @@ struct rxe_pd {
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_av		av;
 	bool			is_user;
 	int			ah_num;
@@ -471,6 +470,11 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
+static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
+{
+	return to_rpd(ah->ibah.pd);
+}
+
 static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
-- 
2.30.2


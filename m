Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8378F41D264
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbhI3E3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbhI3E26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:58 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F346C06176A
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id y16-20020a4ade10000000b002b5dd6f4c8dso1446810oot.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=Wldlagw7thHxcDgiV9GEopPWyPfoXGlvrSP2i1Wq25u4mGHoH4jhyS+jvP4u3ZjXNx
         SvkIt7Dsui2t4JgLbSUgoZOJQovZT1vaAHa75gfeu6UCi5eDh00A4Gzu0KF9E29dZ5uZ
         cRxjlg8JsBs66xyXu+y19DQUOTlcUiNKg8kpqb2cxnuBG+2TiFA3zbtb5OMulXiyoY//
         MN7afehdI6sM8oYasolJXH8EvQHBcXUSZBR+LOdWCqoNQ9ddkZECvxU9SpkGN7x3KpwV
         ya9CRD24ptQ4Nni3oo2lOTql8bhMuJMyHjdRhYM1Y28GkqRm73gHJtc6Jaymv7GrAjyd
         4s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qApN8UnhyEUIjIpM/GmsOjj23Il/VJ1qkJLR9SYk3QA=;
        b=m4fH1xkzEfwp0gPgm5LTegKN6x+Zt8P6oUW3cpCAQ4byvl7PKwl1EwncsZKvsBerEp
         qJzqBX0XTlHPHQuyWynHfEt1hg5O7+GaGhWpda7Y5astfTeT2wLpMde7kb5xV1NLrmWA
         goM/ZwLDyJDoq4x2vQmmfg3OqF4eRApZ3q9gioYYXbV/A9qLDPernFQ3uHj2d5arD5b6
         Vha/Wc1Po5xnxOo5ijgG2aVsqzb70B0aK3PZnLCbPkSfnGZEzX16MRHbn2VbKXXJu9Mp
         Y+i3MBI/Z/1ye+/17oJ+zGofxWFWcxRiFKLJ0KiydiJ9wiaXsi65for0BQKLnjWlY5jO
         uwCg==
X-Gm-Message-State: AOAM533TXdGczRG8zvCAMf8IilQpYTrpnU27T6kpIrf1jQjqIp3MM5m3
        Ii4kiIZ+tKp4xyYTu/fVV5crMfzCsz9sOg==
X-Google-Smtp-Source: ABdhPJwP8FsBlkgkGHNpggNF0UUCRI0mhEZVDcIDe8TtbIfvTpWfE2NLuZLpi1CVI4MVWs/KzjM3fw==
X-Received: by 2002:a4a:424b:: with SMTP id i11mr3038281ooj.87.1632976035945;
        Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 4/6] RDMA/rxe: Replace ah->pd by ah->ibah.pd
Date:   Wed, 29 Sep 2021 23:26:02 -0500
Message-Id: <20210930042603.4318-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
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


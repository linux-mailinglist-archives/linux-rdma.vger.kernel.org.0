Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3C303DDC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbhAZM4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404105AbhAZMuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1151C08EC28
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m13so1882934wro.12
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpZFRWRMBRyHqA4LFeJIkJ1VyU/15BjqrvkCVLk60G8=;
        b=DflQqkzq+/EGK2NRxBd+UtoUZey4O18FCOsB6PA4MWcs0g95luUnYoA6knuBlQ5/qp
         CgvuKM45GRD/OIqwCBbca5ujHMHfRJbTDzmUpXVbXYh4zY0KpMEuAbIzZ1XmYhvTwPap
         vYjczVegm3Q+G8SIyoUU8+YYzXF7fGtH8lbRsu4Uchkb/WGsFPE5/KJbYRFmt2Yk08hr
         1GWbwyXOKtbBXbLPHYjlgM8LLjC3UAglmVnuur88kLNR/8kmS4wpSMUeoGsohdeHLrDH
         u4smr8dfKBuJigXsgKOGFABXrP/IH2m2crw6/yl26Qq+8JiE703LwKdkT4jAav7es7mJ
         dh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpZFRWRMBRyHqA4LFeJIkJ1VyU/15BjqrvkCVLk60G8=;
        b=Fd/h5fH2NiFMPFHL05XAR9PCJp/1cpK4W4iJbtctzwu23nKmrzgvcLJnlQKAcf3CXq
         gDG5dEZn3VoWMvvc60IfkRLKICbgP3TNpWhV0gLHoSodpJjUo/v9TIbJ1s4SddwlZWWx
         AJMyVGcBHobOE0uH/iQCepX6PBReB4M5FlT3+9/yXvVxihe7mhy959pmVspLa/lLSjIk
         BnqF2W7eDMlWXCCPwlRfod1uvYGIKpD3HLuKncATLkN58UpJgk+yzgMlA88uvsTSTXmi
         woWHfdSnkSUNWnQv/8bH6x+JXIFhZTqLTFz+TgWbGY+FqaMXx61oeYSOSxrLItuJLdkD
         6n7w==
X-Gm-Message-State: AOAM530q2a2rlrkAODXn//A73mJsc6zg3CyfDV9D+Tz18njNaCP3mDNX
        sGd5hhwHovqIoBOIghgFrxuXRw==
X-Google-Smtp-Source: ABdhPJyVPFTqKtMzBmyMdMFKJ4bT4S7ncfaXrWgISj8V3pzak4nLhMepCV/vRlbcIr5IAY+QkkG3/w==
X-Received: by 2002:adf:e610:: with SMTP id p16mr5842178wrm.169.1611665277555;
        Tue, 26 Jan 2021 04:47:57 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 19/20] RDMA/hw/hfi1/verbs: Demote non-conforming doc header and fix a misspelling
Date:   Tue, 26 Jan 2021 12:47:31 +0000
Message-Id: <20210126124732.3320971-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/verbs.c:741: warning: Function parameter or member 'qp' not described in 'update_tx_opstats'
 drivers/infiniband/hw/hfi1/verbs.c:1160: warning: Function parameter or member 'pkey' not described in 'egress_pkey_check'
 drivers/infiniband/hw/hfi1/verbs.c:1160: warning: Excess function parameter 'bkey' description in 'egress_pkey_check'
 drivers/infiniband/hw/hfi1/verbs.c:1217: warning: Function parameter or member 'qp' not described in 'get_send_routine'
 drivers/infiniband/hw/hfi1/verbs.c:1217: warning: Function parameter or member 'ps' not described in 'get_send_routine'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 3591923abebb9..0dd4bb0a5a7e6 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -729,7 +729,7 @@ static noinline int build_verbs_ulp_payload(
 
 /**
  * update_tx_opstats - record stats by opcode
- * @qp; the qp
+ * @qp: the qp
  * @ps: transmit packet state
  * @plen: the plen in dwords
  *
@@ -1145,7 +1145,7 @@ static inline int egress_pkey_matches_entry(u16 pkey, u16 ent)
  * egress_pkey_check - check P_KEY of a packet
  * @ppd:  Physical IB port data
  * @slid: SLID for packet
- * @bkey: PKEY for header
+ * @pkey: PKEY for header
  * @sc5:  SC for packet
  * @s_pkey_index: It will be used for look up optimization for kernel contexts
  * only. If it is negative value, then it means user contexts is calling this
@@ -1206,7 +1206,7 @@ int egress_pkey_check(struct hfi1_pportdata *ppd, u32 slid, u16 pkey,
 	return 1;
 }
 
-/**
+/*
  * get_send_routine - choose an egress routine
  *
  * Choose an egress routine based on QP type
-- 
2.25.1


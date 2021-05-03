Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112FB371489
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhECLt2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhECLt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274DEC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y7so7366967ejj.9
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=N26gRAlt8MVaOMfv/FJCcJ5CwgaA/0Y/v/iikM2wAX8AeuarCC/REhFl+Cxc5/tGKK
         t0gT0NMdKkyttB8FC7xuiHWwIA8GQB0EqumoPyWY/UyUkj82zvuwfbc5X8N8DDds1+Up
         6asWVWGNbQ7qMaN6rd03gQ8N52NI8iKu7z63zSMw52RaUHeK00HYWqGpLv70DE10NmnQ
         2oREvcCUEAM4VjpGD+9dzW/byFkvdFjsFtgwFfs8j+sisBz4ad93hM9yr9wKdkLJY3E1
         wnh6wSaRhl9DlFmagQAMnhSlrWdCED9OKYRaUGZocjEeFHWnC1pv7CYi/qdxmHicIIAO
         N2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr3oGd2AXGQRTQMnzq8qo5e2Hw8gAn5xCsknsd45XjQ=;
        b=JX+t1W4na6WXA1L+MEU4YoR7i5lT5oxK1LQNDANds+tibx81brQ69i03E0/un4igTz
         qc/ihEKdCbKreKJOn9q898zd6KEX5Tgvg3x7i+0eswsR8t6Zvo2peiSV6VeCEivYClZM
         S4FvX1xfZ3Lv9AWTIaprpM2kmFjgXjXHL0ROGOABRBTjdP+xnIInLgPT9i7d1GHyTngr
         Zssq8Ady/UiE6woBVI7vatbtBW13i1BmGD1aYLLMG8Q3bN4H1VIIOlse39v/LPxtr8oB
         oaPsE45QJ794nkeR0p4QJpqHzmWuudCXWPUgFcFf7qS9BQn1qKQDfxT/2NtsVANbmtgB
         Q4/g==
X-Gm-Message-State: AOAM532YeXPQBOxtyx3a4zFCm4D7kOPW0m/L1eKsbHW1wb3lcNcfKqTY
        ZgxlyzxsSzg5aybaPms2zRIHGtSjPwZhTA==
X-Google-Smtp-Source: ABdhPJyDfSKQwbQ42I+0QSJBH5DSj3Z2wFDUOoYiwpb1/zul2PFe4A9z6svjEbcX1tBYqzU8ayWfQA==
X-Received: by 2002:a17:906:26d3:: with SMTP id u19mr16654782ejc.128.1620042511829;
        Mon, 03 May 2021 04:48:31 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:31 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 15/20] RDMA/rtrs: Do not reset hb_missed_max after re-connection
Date:   Mon,  3 May 2021 13:48:13 +0200
Message-Id: <20210503114818.288896-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When re-connecting, it resets hb_missed_max to 0.
Before the first re-connecting, client will trigger re-connection
when it gets hb-ack more than 5 times. But after the first
re-connecting, clients will do re-connection whenever it does
not get hb-ack because hb_missed_max is 0.

There is no need to reset hb_missed_max when re-connecting.
hb_missed_max should be kept until closing the session.

Fixes: c0894b3ea69d3 ("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index a7847282a2eb..4e602e40f623 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -376,7 +376,6 @@ void rtrs_stop_hb(struct rtrs_sess *sess)
 {
 	cancel_delayed_work_sync(&sess->hb_dwork);
 	sess->hb_missed_cnt = 0;
-	sess->hb_missed_max = 0;
 }
 EXPORT_SYMBOL_GPL(rtrs_stop_hb);
 
-- 
2.25.1


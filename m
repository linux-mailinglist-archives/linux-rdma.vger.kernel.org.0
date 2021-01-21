Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACF2FE753
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbhAUKQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbhAUJro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0198C06138C
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so1076499wrz.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swQmxPcitFGtHbQmdYPSgooCu5Sjk8enE4kIJ6+5AJE=;
        b=fecRIgXILzNrwrTxxAbVmd1570PYEAZKeg7sglhJhHb5QjD6XJgsfq+ZgcbmBcIofk
         g18+JJnN9SCz1IrzXVR/FeMVV1+uBdI99IpVxaHsOLMq7YnCN6uRxrr7so8LtzwtF/HL
         X0HBGbJosOpkLB9JuZgk5Q7U5ZwzLJY+aw851i5hCP2v66AWYNOlZAEXkM993jG2e3J5
         Wxj+ONHYutXHum7m/XMbUfSqYv1jpINDBMdnARGBFaWBf/7vFg69AjmLivAv8Wbd4Wex
         +bVWMukxS6h6rCXGXfBbTqx+KcLBSjvtMFTJ2ZqzsjJtUQ/qIkGj01j1RYfuaGKR7KGV
         ilrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swQmxPcitFGtHbQmdYPSgooCu5Sjk8enE4kIJ6+5AJE=;
        b=AESLMAuLGHnLGhYqysGqTbHrNSFNFx3FH7Iy5/Ad8ouNzsDYFECb0fTtlLgXhJi+P9
         75wXtP4VOQ1iUTEXUlphBSsoadcaTrSCAiPlGkOrYTg7XgY7q1Dc1ISk4z+WPmtrZuaV
         wepJ3/3gaqvPZyZQ4I11yQRIPRpPOkoLDnpd3r2QIkG5R5h2kZWXZADpa8VRtSv5RScF
         2Dkpvl8ZK2iCUTRWfW54QoR51RX3tjDzZs8zRf9P1VaQkvyJf3CN1i71TsxEAE1Hve5i
         l4SyrZV49NCXeXwyWo4TtuntX9IwvY9zl24MNIfgBnG28Y3qY8dMSogzZ8TWxiJF41WU
         ptmw==
X-Gm-Message-State: AOAM531nR/bl0DXkX8+/goKytBlm4SYVOTljhqEzmEjBpB2xd5UbAqw8
        qa2PYzFw1KCxBpPjBTFSlWN0aA==
X-Google-Smtp-Source: ABdhPJyKmEtpnLm87Yke89vIYkTU6/mngH04AoIWw1YPaoXGMMVeoDdAt2Q2NYROHYNejb0Ugj9Low==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr13127288wrq.47.1611222354435;
        Thu, 21 Jan 2021 01:45:54 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 25/30] RDMA/hw/hfi1/file_ops: Fix' manage_rcvq()'s 'arg' param
Date:   Thu, 21 Jan 2021 09:45:14 +0000
Message-Id: <20210121094519.2044049-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/file_ops.c:1533: warning: Function parameter or member 'arg' not described in 'manage_rcvq'
 drivers/infiniband/hw/hfi1/file_ops.c:1533: warning: Excess function parameter 'start_stop' description in 'manage_rcvq'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 329ee4f48d957..3b7bbc7b9d105 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1522,7 +1522,7 @@ int hfi1_set_uevent_bits(struct hfi1_pportdata *ppd, const int evtbit)
  * manage_rcvq - manage a context's receive queue
  * @uctxt: the context
  * @subctxt: the sub-context
- * @start_stop: action to carry out
+ * @arg: start/stop action to carry out
  *
  * start_stop == 0 disables receive on the context, for use in queue
  * overflow conditions.  start_stop==1 re-enables, to be used to
-- 
2.25.1


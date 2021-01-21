Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3432FE6AC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbhAUJrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbhAUJq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B1C0617AA
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so1060151wrx.4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5TP7SOW2qS+epdcMI5v0wC0XhSdnGQZ2H2fkGXdgtw=;
        b=GHgcG5XwW3b1jiCm5xGS6W9EwgGh2Ytv30roeEV7x4YCdpXWj5wk2VYAFaBBtG30iG
         cEkBNIoUlCFw0OnJXTjq45+lkursH/CjoS2fGHGeYAfF8XqY6aDuAxZH9MD1VXPR7ycs
         XletK79gfIi2IZn4t6/4aEPNmzHAHlGvyyQm4BQCsFp4r+/d92YWdkBBIk+/XrM88bud
         /NV+jJDE1VNWDU27m3wyt96ZIsoNvK8MsOWrkLhkCaamaRtOhznSDJy0ox374zwt7Ydp
         XK0HlyUwbRq5ol8VjxQmj6gDqIhkwNDwj9mSiRrhfHgDas70bhu1j6l9L6kekyUvbdYi
         FxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5TP7SOW2qS+epdcMI5v0wC0XhSdnGQZ2H2fkGXdgtw=;
        b=C3yLERrESm149y1yvzsNnZ2tznDkaWBUmp1bZjNEuoGgAvmpIO0W26rxNNwmGko1Z/
         lgH7o1rqNJxWBw8eyrqnQ0r3c4XkL0grOeoHxUpcUyvExaTJdi2JKlrBTDbNtxonY9Kj
         AHH5Tpy3sFt8HrKEdIqQ+lxkH2XTdQyQqzALP5UlCfvqgyDs3aC9hHxP/A2CFHKuMxry
         mEiOaHcLGzSzWMO0c8y1SUbO+dxPAfOPjUbYYEhUOL729AjSJcsr/WBLZnX9NMuFKTtB
         RwhlnvAb1dQtcGVkc43RKP+4D0rNYxi8BvhzO27cqMVryj7w2TcVxbVnIylxY2mo/cd5
         11Hw==
X-Gm-Message-State: AOAM5328xUiVRe2Brhxxnd2Mcck2UfXCLQjumjODzaCwraG88IsL51iK
        cvu0kHBxGyilm2cr8SXZKSlJcQ==
X-Google-Smtp-Source: ABdhPJyw5JGcIev6YI1r4Oogk+Z/zXtt6cDAcLCzW8hq8pf6WIY4/7B0GzBugt0neuEHI5VHfZpryg==
X-Received: by 2002:adf:f512:: with SMTP id q18mr1959752wro.55.1611222339429;
        Thu, 21 Jan 2021 01:45:39 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 14/30] RDMA/hw/qib/qib_rc: Fix some worthy kernel-docs demote hardly complete one
Date:   Thu, 21 Jan 2021 09:45:03 +0000
Message-Id: <20210121094519.2044049-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_rc.c:216: warning: Function parameter or member 'flags' not described in 'qib_make_rc_req'
 drivers/infiniband/hw/qib/qib_rc.c:1008: warning: Function parameter or member 'aeth' not described in 'do_rc_ack'
 drivers/infiniband/hw/qib/qib_rc.c:1008: warning: Function parameter or member 'val' not described in 'do_rc_ack'
 drivers/infiniband/hw/qib/qib_rc.c:1008: warning: Function parameter or member 'rcd' not described in 'do_rc_ack'
 drivers/infiniband/hw/qib/qib_rc.c:1274: warning: Function parameter or member 'rcd' not described in 'qib_rc_rcv_resp'
 drivers/infiniband/hw/qib/qib_rc.c:1497: warning: Function parameter or member 'rcd' not described in 'qib_rc_rcv_error'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_rc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_rc.c b/drivers/infiniband/hw/qib/qib_rc.c
index 3915e5b4a9bc1..a1c20ffb44903 100644
--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -207,6 +207,7 @@ static int qib_make_rc_ack(struct qib_ibdev *dev, struct rvt_qp *qp,
 /**
  * qib_make_rc_req - construct a request packet (SEND, RDMA r/w, ATOMIC)
  * @qp: a pointer to the QP
+ * @flags: unused
  *
  * Assumes the s_lock is held.
  *
@@ -992,7 +993,7 @@ static struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 	return wqe;
 }
 
-/**
+/*
  * do_rc_ack - process an incoming RC ACK
  * @qp: the QP the ACK came in on
  * @psn: the packet sequence number of the ACK
@@ -1259,6 +1260,7 @@ static void rdma_seq_err(struct rvt_qp *qp, struct qib_ibport *ibp, u32 psn,
  * @psn: the packet sequence number for this packet
  * @hdrsize: the header length
  * @pmtu: the path MTU
+ * @rcd: the context pointer
  *
  * This is called from qib_rc_rcv() to process an incoming RC response
  * packet for the given QP.
@@ -1480,6 +1482,7 @@ static void qib_rc_rcv_resp(struct qib_ibport *ibp,
  * @opcode: the opcode for this packet
  * @psn: the packet sequence number for this packet
  * @diff: the difference between the PSN and the expected PSN
+ * @rcd: the context pointer
  *
  * This is called from qib_rc_rcv() to process an unexpected
  * incoming RC packet for the given QP.
-- 
2.25.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499BF12359D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLQT0y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 14:26:54 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41448 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQT0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Dec 2019 14:26:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47cp6j0Zyxz9vpbX
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 19:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q_afUYr7XoXb for <linux-rdma@vger.kernel.org>;
        Tue, 17 Dec 2019 13:26:52 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47cp6h6QYxz9vpbV
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 13:26:52 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id j194so8254082ybg.7
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTtM8DgoTYeomLpAB4HP6QUtZc/12vcFjV+hqAPb2JA=;
        b=JMRMfVjdaC3RYJNHwnXub+ZSawvRo+0REws/XPzbXdE15VrnCgJHhpm2yilPHn9sRu
         zuRYmp8T+/ZKT+7RcoW0zzy+IGmNBLi9nWg/iV5w+/iyl/E/ksnxD8lQ9P9V7qoR/Pq7
         icvO6xv3kPqaptf9FBx6+BKBpP4Sm09WGi3ongTQZdqtSbICpjK/8SP6IeCpMQFAFD9V
         eOxs9CWJmHHKO9gfSA+0LwjLxX+E784sq+mm3cxIeA0US7GRxEHxKNsQlS/8SswVY7E8
         uWJaHdqJDH75PWdrLMlpaNXeMb1ljZxByamn9DVUHGqIulL+D0G0XTahjxGkYurn5Cjo
         m+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTtM8DgoTYeomLpAB4HP6QUtZc/12vcFjV+hqAPb2JA=;
        b=r18MfY8qXFG/yGLG7Dm84+ntvlfRgDZBbTK+ypFeFZHSgLfdxrITAiPI+SYMXpt+Nc
         PUTTbn5T8wiWA6VxZW2fmTyM9+tcXI0fIOQZI8T7l71yUlpbVPgI9nVRISgOrPy0p6V+
         AgCZBbDWoCaW9+g0B9zQaDi0cLRq4Q+eYIAYBmhTb/N3TgTV0NQ8lpXsfHclD21Ql3Fo
         nhADhzwtlaMfAXGy3q+PG2fUh97It577E8uQotC8NKMaXuf2AJ8PhALI17EgzVfhbayi
         gjxA8gd/LbaJUzuGf5XvHe4LX10T0apX20fXcyJywsGDp4VyiTNwmiMNpe+sE8UQmPGv
         4sJA==
X-Gm-Message-State: APjAAAXR1ilb+Nzgpkyl675ry9D9Xp4hD/z4sUZGQ9nRhw36ego1uzVZ
        74NDbuj+eWYB+Q3yvznK0d9Qq6xAe7ct1of6RgjydqIYYbrEOfw3Hg0vD186AgIFfqUG6fQfxY4
        zlCyWNIPwUpTqJ7BsMCip2nSbgA==
X-Received: by 2002:a81:8785:: with SMTP id x127mr151811ywf.455.1576610812346;
        Tue, 17 Dec 2019 11:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgHpky9NVFPlztSbQ7vnaNKGoWCoY5ZJfFY1EWtEFon5WLK7ZI2IrVnQNR9SnF12NFAuyBng==
X-Received: by 2002:a81:8785:: with SMTP id x127mr151793ywf.455.1576610812101;
        Tue, 17 Dec 2019 11:26:52 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i127sm10126017ywe.65.2019.12.17.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:26:51 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: RDMA/srpt: Fix incorrect pointer dereference
Date:   Tue, 17 Dec 2019 13:26:49 -0600
Message-Id: <20191217192649.24212-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In srpt_queue_response(), the rdma channel ch is first
dereferenced and then checked for NULL. This renders the
assertion ineffective. This patch removes the assertion and
avoids potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 23c782e3d49a..bbc6729c81c0 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2803,15 +2803,17 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	struct srpt_send_ioctx *ioctx =
 		container_of(cmd, struct srpt_send_ioctx, cmd);
 	struct srpt_rdma_ch *ch = ioctx->ch;
-	struct srpt_device *sdev = ch->sport->sdev;
 	struct ib_send_wr send_wr, *first_wr = &send_wr;
-	struct ib_sge sge;
 	enum srpt_command_state state;
+	struct srpt_device *sdev;
 	int resp_len, ret, i;
+	struct ib_sge sge;
 	u8 srp_tm_status;
 
-	BUG_ON(!ch);
+	if (WARN_ON(!ch))
+		return;
 
+	sdev = ch->sport->sdev;
 	state = ioctx->state;
 	switch (state) {
 	case SRPT_STATE_NEW:
-- 
2.20.1


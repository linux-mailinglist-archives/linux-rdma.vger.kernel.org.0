Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E9114461
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 17:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfLEQGl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 11:06:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQGl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 11:06:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so1838268pfb.0;
        Thu, 05 Dec 2019 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIaDjzjUVZua/rYrb/jl7QK530FXe/2Wn3RwlERrkCo=;
        b=d0jH72yLnpXqxHnMrTHriP3XhEHdk+f3kfafMkwUE3e3ICRC7ZWuoN/XszRzEaOwWi
         8nOv4humeBKBYOm7WkR4TDNk8gkXwiemZGVltYsZvrHKeHQq5w0xIsbJKgEgzzdL9W6W
         SFujGiFwbrtnpBLe2tY2yCR/D6eAv4haGfatOJIDDmlKujizGZZ6u/UelhIvF16XLIo7
         JZTCPOiz5CX6yQO5wmNFLLwKV9N0jyM0Ye7zocY9IS1f9XV2SyRoM+MCZV9lyEcn8jhd
         UBhBfNYSvvJeCNdAMdbtSg1EO7VHRYeX/T+ceK54Jzv6dsFhm3rS4m2Vg3uZXFWRHIf9
         iEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIaDjzjUVZua/rYrb/jl7QK530FXe/2Wn3RwlERrkCo=;
        b=esoTPGRGcEivZCDetC/x8xZl4nTdwyiutl3qGSM70BlX4HOTYkOqnsJDHATdHeIgSD
         AkfO3lJ+HWBvyd9g+jBqIvhsBosbF6dJKVIqZlJbuBfV2ND4NXIqDOt2TnWhElhPhGtd
         fHMhmCCAzV+t0sKK/j2RO+OzBTTm95VJOgOsrF32NunF2HsOCxMORB9JbRp5mIe1da2d
         hebjoqltYcU2+GZzTt4BStQXBssS+EhyOqvutZ4ariciy5CHXA/nZCs3ERaIFmOOQsZ3
         2jsHcDCwyKs94udV8oWy+2kRFO5HIkJoC9cXKaW8uo+YROhzaj7QsZWci1IKCoFgyZqd
         pjNA==
X-Gm-Message-State: APjAAAVcSHf343YhLVjfaK5VOqNh+zO9b05pQP/9Fg8/fc1zrY7DC78S
        BshoRHsJh6/mXACyB9pC96c=
X-Google-Smtp-Source: APXvYqxrFIKp1hFOwTZtgbdNanH/gWLjg60RdtE37uDZJ0yHOAVyoOK1UB4By2GgKJn9695qkNj/zg==
X-Received: by 2002:a63:214e:: with SMTP id s14mr9992681pgm.428.1575562000625;
        Thu, 05 Dec 2019 08:06:40 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id k4sm5380616pfk.11.2019.12.05.08.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:06:40 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] RDMA/cma: add missed unregister_pernet_subsys in init failure
Date:   Fri,  6 Dec 2019 00:06:32 +0800
Message-Id: <20191205160632.32132-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The driver forgets to call unregister_pernet_subsys() in the error path
of cma_init().
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 25f2b70fd8ef..43a6f07e0afe 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4763,6 +4763,7 @@ static int __init cma_init(void)
 err:
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
+	unregister_pernet_subsys(&cma_pernet_operations);
 err_wq:
 	destroy_workqueue(cma_wq);
 	return ret;
-- 
2.24.0


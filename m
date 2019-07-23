Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B747176B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfGWLtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 07:49:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37410 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 07:49:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so8574510pgd.4;
        Tue, 23 Jul 2019 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syzUAD4b6NAbqJrzy/Iszf3QeWwTBpf8xpKc8pmUJvM=;
        b=gAkjQjbGsxZAVFFI07LFZTvvr3LOWst12OhUKeU/tIiwO5vTBb6nG13uVp3icDjNxV
         tqhsAp/vTDOD4ooePcT7aDlNSFVr/3czsHpZdgvsUek8Oj4VtIRiN01Hk2ZWQ5Hi7jcw
         kwab/CHaO6tBrWPRaA7jc1/GbPCm0B+tI2/f0FiNTYfp7JuKj42c8KR43sW/ekuBB8nJ
         kX45uRn4Lb9z1dUvQYPab/w1haGvEs3+kVMyM3iDc86eTEa9wdxEpr34SpURr+2LFHgJ
         yHapWTDR54LA7P/dIrsSdAMZEk1OCSqBOAdGw/dxTpy+egedR3sURzzFRqOFzXAH07zA
         pN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syzUAD4b6NAbqJrzy/Iszf3QeWwTBpf8xpKc8pmUJvM=;
        b=bI02K5gdsF0B8HMTC4Y0VxRVZBSwncUCUDgL+XiN5FaIa6b5cQxIqB0Q2rKQE6tvMa
         jFR+4s0bQqf0wj2fC6oalcLhDIl+wm++Bg1jgP35w61nSq5XPuj7uO+UpFszPXPohsKY
         2shTxuN0oZn5mq2pqNLCMXY6bpR+qYR1BbLv49/pvrm8Cq3qF9pQvgWPjuss7R03H8Br
         95wjj8ql6c2wgG9IjpbnYxCVoMFB7j5rN1TanjUjNLqjBlxFpM2xHkGAPPwQ+PAuCf3S
         oXqds3d2rfc2Daeg/udlBHSUgtb1VRQwhW0v101T4O5lL1ZrmG2s/1trK8kyDzyIByOl
         GMKA==
X-Gm-Message-State: APjAAAVC/9Vkb9JLQZ1iadC5XmLhOX763+ba4WQYpY3vfDrmJtPz/C/H
        BkYRZWVYqPLtRWikKGsUMsE=
X-Google-Smtp-Source: APXvYqwH1P575+7W1z01EgvvIi1DBxfc38jLsMjUnO/4ANwxA6kLic4BllPlqHVSUHTl/k+cyyVwbw==
X-Received: by 2002:a63:f959:: with SMTP id q25mr75867179pgk.357.1563882580349;
        Tue, 23 Jul 2019 04:49:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id k186sm22464204pga.68.2019.07.23.04.49.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:49:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] IB/usnic: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 19:49:28 +0800
Message-Id: <20190723114928.18424-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index eeb07b245ef9..a354c7c86547 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -194,7 +194,7 @@ find_free_vf_and_create_qp_grp(struct usnic_ib_dev *us_ibdev,
 			return ERR_CAST(dev_list);
 		for (i = 0; dev_list[i]; i++) {
 			dev = dev_list[i];
-			vf = pci_get_drvdata(to_pci_dev(dev));
+			vf = dev_get_drvdata(dev);
 			spin_lock(&vf->lock);
 			vnic = vf->vnic;
 			if (!usnic_vnic_check_room(vnic, res_spec)) {
-- 
2.20.1


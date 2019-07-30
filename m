Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1D7B1BD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfG3ST6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 14:19:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbfG3SQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 14:16:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so30263509pfo.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2019 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrkRbDzr3PjCa/bkRL7w2lB6fdcpmQGt7tWtDP9dwcc=;
        b=e+WyNRNolRLQziccTpNHSyiKpyyOeUMfcGl6wn61KqLcd1VX2GVhoen80F0RJRAzk9
         NP6LMtp6ZhdmWXmYwqsWPM9LHwk7sLvWLOrtAnjvvNMRVic6I6U6aZho/X52ypCRNup0
         9UPtzjMP+tAz/2ZNbfjssbrCKjy6dAzpHPong=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrkRbDzr3PjCa/bkRL7w2lB6fdcpmQGt7tWtDP9dwcc=;
        b=jj3VWWjBwQXHTz72P2X539AyJ6RoYAOVQYf2inQeBoi5JFAMxIi4kTUM7W86BB0/j5
         WxKJy5zsPmnVLS3nOee2Hi11YTO22dD0yHUeV2fNslKYGRHfKDyClOC5aS9odOac9vq5
         LNt4HgWmBX9K/y1BpLvrykN2WuOGU/TOmsQkXoKLAg6Uk2QN7YZ08zxebnq+I+Vvoy1B
         7BW4qQIZspIv75NUVqa+/f/MEEezCn1iqJvyUUlpRtS3l2c+GQbgl0E8qzJFG2sblWBn
         tEck+remXPsWSAop73Wtr+EgTH5wk5eXOZ4dcxA1OtF9oKGQwcse6y7Z6nGxAVWGt17A
         LeeA==
X-Gm-Message-State: APjAAAVDA63UVuEEEGueIqJgXhw2mvd7wpsGjZDtth+YWtBzMu/MGRwM
        ltttmsYfkwzBS2aZXeipVVu00g==
X-Google-Smtp-Source: APXvYqxJWxieoGzyPZ24ebf1AxpIyPNcsS5Oh6md2BEapPyVdOsYCpjQyJR8ZnzfKSIADSSU+GyQyQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr117014119pje.125.1564510576096;
        Tue, 30 Jul 2019 11:16:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 20/57] infiniband: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:20 -0700
Message-Id: <20190730181557.90391-21-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 81e6dedb1e02..7541177eb648 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4637,10 +4637,8 @@ static int hns_roce_get_cfg(struct hns_roce_dev *hr_dev)
 	/* fetch the interrupt numbers */
 	for (i = 0; i < HNS_ROCE_V1_MAX_IRQ_NUM; i++) {
 		hr_dev->irq[i] = platform_get_irq(hr_dev->pdev, i);
-		if (hr_dev->irq[i] <= 0) {
-			dev_err(dev, "platform get of irq[=%d] failed!\n", i);
+		if (hr_dev->irq[i] <= 0)
 			return -EINVAL;
-		}
 	}
 
 	return 0;
-- 
Sent by a computer through tubes


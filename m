Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC413DAF7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAPM7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAPM7v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id b8so18825359edx.7;
        Thu, 16 Jan 2020 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=giMlZq8NraAi1xlH+QMTWP3Ms7ewWQBXb5wOTepuFxQ=;
        b=pazxQQCBBGhqp1sJF3PcvrOdtWpxXrlxj0Z+//kKUamtSEoHVJ+hU5D70zMbiOyLry
         NqUD9BhCy7gNLJDNKWF+ERO6lEPyl6xQD7ntmw7IZDamMSG7gLp598w6m2o2+kqCmcH7
         x9RUPafGKZQ2giMkrNBD0gfXxCCXx4RXRCkGlFtOgT4phnkaaZRWdAbk+2/JKmRAN7IW
         ZXZsQX/6t33VkK7+uke7T7u1/v05oRelSwtzY0c8r0LJhWlfbo2WmAeAzu9eRkRrmCnU
         W6QDb5cLQZjTM0V2LdhScsEx81wGusERKyMfdQ/rM3UVLHQlm6zIc/fdtuFpdYrH6caU
         q8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=giMlZq8NraAi1xlH+QMTWP3Ms7ewWQBXb5wOTepuFxQ=;
        b=ZxkR+pYfrWuHbBxrAeerZDxMg0ghd95NJMKCPSPJY+ett5BEQ3LtTan6XEc+nNnmIA
         j252MeMDZ6nrlyq4koIcZWbTfW+W+VCWJqcgAvvWPNL/mDjYTYRwBaiLx12oEGcMUj+Z
         6yFzrenNpAFeuHJsAMQelPpAUWVgS1kYTOai6H4WeHUu58C29yj/rBW+PEJ9q6KghABk
         5R2YTn9OfYs6ZMhAZ3NLXQRbmI3PJZr+OPEIx07iVU0NLjN193RRPSdaDhy8j7s1B/AS
         KCnEvzA3PvpmdcvMjHPZJ0o3yKcOienxVcMShDWKkqGhi/4jCaLB4PdJ5QCQu5VCkfyN
         78EA==
X-Gm-Message-State: APjAAAXao6QY/NN/NO2/84ghpfP2KbwSvW9lvypJAn1QifpoLKzqPMrN
        2LK6aGpeiuqLMPxTWIH8UTFmjECh
X-Google-Smtp-Source: APXvYqzOWxhPMTjrcbhmCHok0PzzegLd3CURWmrAVeHcWRkp8wG9UlhQco6n7j/lAQzOJYVR2+MSLA==
X-Received: by 2002:a17:906:f745:: with SMTP id jp5mr2771247ejb.117.1579179590216;
        Thu, 16 Jan 2020 04:59:50 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:49 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Thu, 16 Jan 2020 13:59:15 +0100
Message-Id: <20200116125915.14815-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4017e6b760be..fc8a7c3534e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14127,6 +14127,13 @@ F:	arch/riscv/
 K:	riscv
 N:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 W:	http://sourceforge.net/projects/roccat/
@@ -14262,6 +14269,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.17.1


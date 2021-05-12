Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF437B482
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 05:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELD3K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 23:29:10 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43789 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELD3J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 23:29:09 -0400
Received: by mail-pf1-f172.google.com with SMTP id b21so10442040pft.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 20:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoyNMArjDVR/sKZi2hfi9ZppuBc1G5/TZn1XgWLSKwg=;
        b=Px2ase8QE3d9ft5eRkcRmxxb9eFQ+bW5mn8d/eCKi6kJAtB81sSkfAJ21vD8Pias0v
         m9e7TC0wrlLmXMhz0/VHJbDHtQeBRpq5AlOleJzIysWO9uy6vrpsPo4qZPY6gorOHRFU
         552eSbL5eOBw1Z8huOYb2Aspa+5mbmC9X9zWDx1BtQiEclydY3w/Ju2ZCqS1X2nJGe+N
         86qZGeejgqvAoSM5cDZD1wurjBla2cTnmQzSd8BFPegJh+dir822x7JT5QeXff2TAOTi
         vmNao4h+Wjt/HaxpbqRWf41/dGkohCy/Hrv9z1Vgu5810yRPj/RCc9Olh/3xw+MFO16W
         fh0Q==
X-Gm-Message-State: AOAM532KV0euY8qADvi5EDQZ7wd9/OJb7UOJ9+vZ0TWcVZkwHuJ7yDwY
        Pqc4lRKPPtRP46w5aLyNau0=
X-Google-Smtp-Source: ABdhPJyVL1f6FNOPDk+4QyWw83TF6nB0XNkHMo2BcPYHy/EBWwJ8KZCupSc1GnyLezcwakN+VD4GaA==
X-Received: by 2002:a63:2686:: with SMTP id m128mr34316431pgm.406.1620790081965;
        Tue, 11 May 2021 20:28:01 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:76b9:3c77:17e3:3073])
        by smtp.gmail.com with ESMTPSA id q194sm15008703pfc.62.2021.05.11.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:28:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH 2/5] RDMA/srp: Add more structure size checks
Date:   Tue, 11 May 2021 20:27:49 -0700
Message-Id: <20210512032752.16611-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512032752.16611-1-bvanassche@acm.org>
References: <20210512032752.16611-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before modifying how the __packed attribute is used, add compile time
size checks for the structures that will be modified.

Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31f8aa2c40ed..0f66bf015db6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -4078,10 +4078,13 @@ static int __init srp_init_module(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct srp_aer_req) != 36);
+	BUILD_BUG_ON(sizeof(struct srp_cmd) != 48);
 	BUILD_BUG_ON(sizeof(struct srp_imm_buf) != 4);
+	BUILD_BUG_ON(sizeof(struct srp_indirect_buf) != 20);
 	BUILD_BUG_ON(sizeof(struct srp_login_req) != 64);
 	BUILD_BUG_ON(sizeof(struct srp_login_req_rdma) != 56);
-	BUILD_BUG_ON(sizeof(struct srp_cmd) != 48);
+	BUILD_BUG_ON(sizeof(struct srp_rsp) != 36);
 
 	if (srp_sg_tablesize) {
 		pr_warn("srp_sg_tablesize is deprecated, please use cmd_sg_entries\n");

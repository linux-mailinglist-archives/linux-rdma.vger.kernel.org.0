Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21338E010
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEXENu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:50 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:46606 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhEXENs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:48 -0400
Received: by mail-pl1-f182.google.com with SMTP id s20so13956134plr.13
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDxxjBHBfDrwbjpAHiE6hoHF9REhV4NABhq3WWNfXPE=;
        b=O6PIzZuWQ4gd+V+gMGQ+GEq6sueKm5195bQVDP8xnztP9qOw/BCCB5fimD2ye7IKVO
         bKuSjF1cPHl9nrH7seIwoNdJVxUPaKRg1wfbWswV6A2miWcL8c4VbFfpsiRVS/MHx1OO
         22NQHWA2d3ufzMizOn2oJ8+inrpmjan8/32QyC1FCQZYGEN9IBWXHGIMYQnLnVC3p+ct
         jgyNYll/1ZDgEFTovn98+5SS/iHmag4OaoiKIXOZ7I2aSE1qMAESdw+D6zZn2um4tzb7
         6Qn5Ou4pd8ClhBcdYBGDBQ7KSEDPUKcLRK/KYcXaHl5dwo1ExybTUxqn1+z7E//Noffz
         xtgQ==
X-Gm-Message-State: AOAM533BDNW4Zx+RffSe8a/GCwoj0qOftFdbPPpGKOScIZlxD1tYgb6r
        5oAe4gE3qsqWtk40YdCFC+U=
X-Google-Smtp-Source: ABdhPJxhf2qqbFLtJNeO7E4OBFZNzTPp+MdpfgOQNT9+2xTepZVVp64hUJmtsdxlkdioaXF298Yprw==
X-Received: by 2002:a17:90b:108e:: with SMTP id gj14mr23416896pjb.109.1621829540860;
        Sun, 23 May 2021 21:12:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH v2 2/5] RDMA/srp: Add more structure size checks
Date:   Sun, 23 May 2021 21:12:08 -0700
Message-Id: <20210524041211.9480-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
References: <20210524041211.9480-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before modifying how the __packed attribute is used, add compile time
size checks for the structures that will be modified.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DBDC2ABB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfI3XRe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfI3XRe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so8263521pgl.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGtTfGcD29RzTaSchvjdg6mH4L5jyhUU8qp7VAgaELI=;
        b=AdPfdHQ1zCNN11aq5vS3+ueLqB3vFB/hz9u2Gj+tpfxyli4NOWjsRWed9a9DMyGObd
         GVbv3CcibyMCwaO74CKTJajM+HgA3MmMRVDPD72eBGJBl88MI+4E8ioasLEL0RKendGh
         bEUbwvugL9FMWmMxhYZG0TzBNo2DPjlk/HBx9yeYrNxcntm9sahgNApgCZGCxp4HaVml
         /gEG6qqhVhoxsCk6S8pfPLtnFuuap70Flxd+uMne37gWAKVG6rLnUqKN/mReOqzV2xT1
         SO6Y99KresRbZLhqQ9oq9/AqDQpaIMICkiLvVoiQifsUiL9esZNt6zx6xeIRDqVpp2rz
         cuGg==
X-Gm-Message-State: APjAAAVvgIcO5yBAB4NaGneOu/JpJiFdUyzZDL3V1PbngOutmJ80Njdv
        fI1HXy4dz9zXV3Ug8w1y/WY=
X-Google-Smtp-Source: APXvYqwZfeNYDemKwG8xmGfA1peUGhvsys6cMFRnfnxJUOYz1D1d39mgaK8xq3vlTOVNpeGMX74Lqg==
X-Received: by 2002:aa7:8436:: with SMTP id q22mr24330861pfn.74.1569885453620;
        Mon, 30 Sep 2019 16:17:33 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 11/15] RDMA/srpt: Improve a debug message
Date:   Mon, 30 Sep 2019 16:17:03 -0700
Message-Id: <20190930231707.48259-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ib_srpt driver uses two different identifiers while registering a
session with the LIO core. Report both identifiers if the modified
pr_debug() statement is enabled.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index fbfadeedc195..dabaea301328 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2293,7 +2293,8 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 			be64_to_cpu(*(__be64 *)nexus->i_port_id),
 			be64_to_cpu(*(__be64 *)(nexus->i_port_id + 8)));
 
-	pr_debug("registering session %s\n", ch->sess_name);
+	pr_debug("registering src addr %s or i_port_id %s\n", ch->sess_name,
+		 i_port_id);
 
 	tag_num = ch->rq_size;
 	tag_size = 1; /* ib_srpt does not use se_sess->sess_cmd_map */
-- 
2.23.0.444.g18eeb5a265-goog


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5031CC2ABA
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfI3XRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34562 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfI3XRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so8263485pgl.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeCtAwbRRdyPPNVebY8Q0aEvrjvJ6tMNcrmSbGUu0bw=;
        b=c42UF1cA06hzwEGsOR6oYS3aP+tFOBki82fC+y59yb/43yBMsNB2FC4163vVVD90g7
         Iy27Hy+JyRq4c++TY6Hs2Nvt5EjvTdUACf/jzqJ8tUKak9mcmUEe3KnTRRJMQ7DfPfHA
         rvDqWz4HLx3N2HDXKQAUEuYFLclAF38yPMke3GZMsUh93dvfQHIFlUKrpSbKu+ct8Op2
         e81dEX6rhoQVHOBlOFD/d84QgTI4L49DCnteSs/wd8Un4QHKLmXuLIeWhY+C+LRM8BnW
         BW2msodSHShePGNP82LMZB/lnW4IU7TMm7X8qefUgHaDWozxFEirFKR8Whu96MlexXpq
         btOA==
X-Gm-Message-State: APjAAAU79GQBH5+z7JpnhVyjPchHS2C9ONIIR1zFvCRUn6ow1F9k2Qjf
        /GD04kfg/8jz79xNIhnYD/8=
X-Google-Smtp-Source: APXvYqxOp7KwP/KgURdTIwky+Mt00O/azIij69OyBMQ5qPiiPpgLehDHR8AR+9vF6y0qxZng6Vqx+g==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr1906599pjs.51.1569885452171;
        Mon, 30 Sep 2019 16:17:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 10/15] RDMA/srpt: Fix handling of iWARP logins
Date:   Mon, 30 Sep 2019 16:17:02 -0700
Message-Id: <20190930231707.48259-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The path_rec pointer is NULL set for IB and RoCE logins but not for iWARP
logins. Hence check the path_rec pointer before dereferencing it.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 4f99a5e040c3..fbfadeedc195 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2502,6 +2502,7 @@ static int srpt_rdma_cm_req_recv(struct rdma_cm_id *cm_id,
 	struct srpt_device *sdev;
 	struct srp_login_req req;
 	const struct srp_login_req_rdma *req_rdma;
+	struct sa_path_rec *path_rec = cm_id->route.path_rec;
 	char src_addr[40];
 
 	sdev = ib_get_client_data(cm_id->device, &srpt_client);
@@ -2527,7 +2528,7 @@ static int srpt_rdma_cm_req_recv(struct rdma_cm_id *cm_id,
 		 &cm_id->route.addr.src_addr);
 
 	return srpt_cm_req_recv(sdev, NULL, cm_id, cm_id->port_num,
-				cm_id->route.path_rec->pkey, &req, src_addr);
+				path_rec ? path_rec->pkey : 0, &req, src_addr);
 }
 
 static void srpt_cm_rej_recv(struct srpt_rdma_ch *ch,
-- 
2.23.0.444.g18eeb5a265-goog


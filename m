Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0EC2AB9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfI3XRb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46316 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfI3XRb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so8205408pgm.13
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJictFiV/NUBeu9ierblkmoLW1qMoxZQbWHlCeAkVdU=;
        b=EHDSTrxTua6ThHdLbqOwZSLhiZbKVVQxUmjAjAE1mKb8p1zxV4a4IFwxiVH1eWNlE/
         4eHIHhZJivV6/a5/MRNeksOxOC3XIb0jcKpJtv1TTAqUj2TXY2yBhZtGSMiHBBcHE8je
         DZy0wS1ywan/mnt6h15Oquc4IfxKDo+PEtpegUP5UXDXJORBaLlFU5SOgtIHSxJwBDfZ
         +PiXvdTE65SI7paPDD/Y5Sfw1MG+qutKrhsM+cQ35UGofvJybJ0xYh1Ges8DQS/qMzio
         n3exo3uO3XTFNEwjMK+r9Geoc0RKIsPSHWxNGlZQu4tNlOH5VkuIVUKFx+dN4x9UDJSn
         5sBg==
X-Gm-Message-State: APjAAAXg/NcwJntG3jk46N+6TQIz/o6c7d7X5a578ZWn/fpBa51hFW4m
        gTut0sMixzGJzKIEaVKYWRg=
X-Google-Smtp-Source: APXvYqyJDR9ZbzawqsgdO4uOLesUxB9xAHUqATIcoK75UysUoNsryCcI3jjuQWpRvalMdfH+sGT9Tg==
X-Received: by 2002:a17:90a:3450:: with SMTP id o74mr1971221pjb.5.1569885450851;
        Mon, 30 Sep 2019 16:17:30 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Date:   Mon, 30 Sep 2019 16:17:01 -0700
Message-Id: <20190930231707.48259-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Management datagrams (MADs) are not supported by SR-IOV VFs nor by iWARP
ports. Support SR-IOV VFs and iWARP ports by only logging an error message
if MAD handler registration fails.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 41 +++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index e25c70a56be6..4f99a5e040c3 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -556,24 +556,16 @@ static int srpt_refresh_port(struct srpt_port *sport)
 	struct ib_port_attr port_attr;
 	int ret;
 
-	memset(&port_modify, 0, sizeof(port_modify));
-	port_modify.set_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
-	port_modify.clr_port_cap_mask = 0;
-
-	ret = ib_modify_port(sport->sdev->device, sport->port, 0, &port_modify);
-	if (ret)
-		goto err_mod_port;
-
 	ret = ib_query_port(sport->sdev->device, sport->port, &port_attr);
 	if (ret)
-		goto err_query_port;
+		return ret;
 
 	sport->sm_lid = port_attr.sm_lid;
 	sport->lid = port_attr.lid;
 
 	ret = rdma_query_gid(sport->sdev->device, sport->port, 0, &sport->gid);
 	if (ret)
-		goto err_query_port;
+		return ret;
 
 	sport->port_guid_wwn.priv = sport;
 	srpt_format_guid(sport->port_guid, sizeof(sport->port_guid),
@@ -584,6 +576,20 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		 be64_to_cpu(sport->gid.global.subnet_prefix),
 		 be64_to_cpu(sport->gid.global.interface_id));
 
+	if (rdma_protocol_iwarp(sport->sdev->device, sport->port))
+		return 0;
+
+	memset(&port_modify, 0, sizeof(port_modify));
+	port_modify.set_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
+	port_modify.clr_port_cap_mask = 0;
+
+	ret = ib_modify_port(sport->sdev->device, sport->port, 0, &port_modify);
+	if (ret) {
+		pr_warn("%s-%d: enabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
+			dev_name(&sport->sdev->device->dev), sport->port, ret);
+		return 0;
+	}
+
 	if (!sport->mad_agent) {
 		memset(&reg_req, 0, sizeof(reg_req));
 		reg_req.mgmt_class = IB_MGMT_CLASS_DEVICE_MGMT;
@@ -599,23 +605,14 @@ static int srpt_refresh_port(struct srpt_port *sport)
 							 srpt_mad_recv_handler,
 							 sport, 0);
 		if (IS_ERR(sport->mad_agent)) {
-			ret = PTR_ERR(sport->mad_agent);
+			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
+			       dev_name(&sport->sdev->device->dev), sport->port,
+			       PTR_ERR(sport->mad_agent));
 			sport->mad_agent = NULL;
-			goto err_query_port;
 		}
 	}
 
 	return 0;
-
-err_query_port:
-
-	port_modify.set_port_cap_mask = 0;
-	port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
-	ib_modify_port(sport->sdev->device, sport->port, 0, &port_modify);
-
-err_mod_port:
-
-	return ret;
 }
 
 /**
-- 
2.23.0.444.g18eeb5a265-goog


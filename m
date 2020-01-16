Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD213F727
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgAPRAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 12:00:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34532 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbgAPRAm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so19801726qkk.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAP9aIk3c5NMaapOVqo6z/tT/AGa3MeVYb9/qNNc5SA=;
        b=MUp3rAeMzXOD77fiPB+7XRCUSS3m3sVqCyrPtKYrLeiqQDPwiSgj1fMdwtmnXYAIxo
         OVKlJhb3DErwP/N2+tfpdQ+S8Wnt8E4LjxsrAe39hR60hkwz/aX24yQ6FWxZpnFHYhgP
         cp58f07YsyIVmS6nOHO+CPmDcsb9NZDE0eVijYilH4UaTMIHFRcGkwirV2GcO2DWUsV5
         ozYF/E5Qhcbbipv9Vc2aP6y3qoAbQOgREjtsLniB8uf8XUB4SMb8e5DYUwcvpdhQiWMS
         kbFyK5sBJk4yBzoDi4D0uTPpmpgP+ia/5iX2tB4UA9sMZ0JzlKcKePaLLayoS4NRdNaD
         AGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAP9aIk3c5NMaapOVqo6z/tT/AGa3MeVYb9/qNNc5SA=;
        b=Dc7XH+aw1bsSeClvgif21AGFktVAh5swYIoUV0o5AbMzomFQKfnMj+NZbc+nDC4T4O
         ncBeyT6Ys056iH9aZUJiu/RmuZe6XVCh3u1qBz23ZZFJegmdr8ulO0RnCQASa2834qF4
         ZYMX7qrj0OnSqvnvuSoWq68k9Dhna4kKkFNg1rRzC6XFwQTsCBkHvUVmzWulB961iUGk
         HrqMu0QFQ6AuXC1etP75PAcyRH6g/6IKJJob+BPf85JgRzkLz/cxK9DU6hCZZ4iV+NAh
         4JI5Z+Lf4QE04GvQxYFX5KJRDb6Rsn67lIRJvNLEpBytItHpuOIE4BkcTdWtJR7FeyDe
         4diw==
X-Gm-Message-State: APjAAAVzZ/xkCnJT1RfkYFfCEoEU/iLfskbL/Pd7h20ZtcTRUO3rVUuF
        6HelhRKJnQkOezYaXscNoK7PTaCIOH0=
X-Google-Smtp-Source: APXvYqxq4+lPHdMhWebea4Mbynr3sHA449RYpDwdHVJHFet3toiK8e+pRehhz9Ck4rfhB6Un3+x0WQ==
X-Received: by 2002:a37:bf82:: with SMTP id p124mr33886553qkf.337.1579194040982;
        Thu, 16 Jan 2020 09:00:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i19sm10153517qki.124.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tB-04; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 1/7] RDMA/cm: Add accessors for CM_REQ transport_type
Date:   Thu, 16 Jan 2020 13:00:31 -0400
Message-Id: <20200116170037.30109-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116170037.30109-1-jgg@ziepe.ca>
References: <20200116170037.30109-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Access the two fields through wrappers, like all other fields, to make it
clearer what is happening.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm_msgs.h | 41 ++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 23e3d0c6a67c3c..9af9a321207423 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -124,14 +124,37 @@ static inline void cm_req_set_remote_resp_timeout(struct cm_req_msg *req_msg,
 					  0xFFFFFF07));
 }
 
+static inline u8 cm_req_get_transport_type(struct cm_req_msg *req_msg)
+{
+	return (u8) ((be32_to_cpu(req_msg->offset40) & 0x06) >> 1);
+}
+
+static inline void cm_req_set_transport_type(struct cm_req_msg *req_msg, u8 val)
+{
+	req_msg->offset40 =
+		cpu_to_be32((be32_to_cpu(req_msg->offset40) & 0xFFFFFFF9) |
+		(val << 1));
+}
+
+static inline u8 cm_req_get_transport_type_ex(struct cm_req_msg *req_msg)
+{
+	return req_msg->offset51 & 0x7;
+}
+
+static inline void cm_req_set_transport_type_ex(struct cm_req_msg *req_msg,
+						u8 val)
+{
+	req_msg->offset51 = (req_msg->offset51 & 0xF8) | val;
+}
+
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
-	u8 transport_type = (u8) (be32_to_cpu(req_msg->offset40) & 0x06) >> 1;
+	u8 transport_type = cm_req_get_transport_type(req_msg);
 	switch(transport_type) {
 	case 0: return IB_QPT_RC;
 	case 1: return IB_QPT_UC;
 	case 3:
-		switch (req_msg->offset51 & 0x7) {
+		switch (cm_req_get_transport_type_ex(req_msg)) {
 		case 1: return IB_QPT_XRC_TGT;
 		default: return 0;
 		}
@@ -144,20 +167,14 @@ static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
 {
 	switch(qp_type) {
 	case IB_QPT_UC:
-		req_msg->offset40 = cpu_to_be32((be32_to_cpu(
-						  req_msg->offset40) &
-						   0xFFFFFFF9) | 0x2);
+		cm_req_set_transport_type(req_msg, 1);
 		break;
 	case IB_QPT_XRC_INI:
-		req_msg->offset40 = cpu_to_be32((be32_to_cpu(
-						 req_msg->offset40) &
-						   0xFFFFFFF9) | 0x6);
-		req_msg->offset51 = (req_msg->offset51 & 0xF8) | 1;
+		cm_req_set_transport_type(req_msg, 3);
+		cm_req_set_transport_type_ex(req_msg, 1);
 		break;
 	default:
-		req_msg->offset40 = cpu_to_be32(be32_to_cpu(
-						 req_msg->offset40) &
-						  0xFFFFFFF9);
+		cm_req_set_transport_type(req_msg, 0);
 	}
 }
 
-- 
2.24.1


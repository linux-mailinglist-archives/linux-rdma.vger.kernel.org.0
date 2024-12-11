Return-Path: <linux-rdma+bounces-6423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738F9EC789
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C43D2817E5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C791D8A0B;
	Wed, 11 Dec 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ew3wy6NI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A71DC98C
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906648; cv=none; b=pgg0yNvXE5gBppSTjxA0BM/D28/d6iNKXV0vYxR0nIKPc1KaY1c+g7MQyk5V2sc3gmRlSBtiwrLYhWAoffF978bXmyUEhGfy8HeJA2tG2dEHt2JuAE+aBLT1T2NKMV3h+hs1Gy7p636swossvOBnKlnqqxZiBKA/eko6elRwmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906648; c=relaxed/simple;
	bh=NJy6FQzQpA/aBlOn7Yyou4JYL5E4RDNUgk7Ri+pWWIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY2OZcr0++7Jihjuh59PSAF5BjQnppF1y2wQ5jx1uCDiLl4CDaYDuc5HWw9Q9FYgTl2OeL6WL3Y0vwMj+0jYN2zPePT4oSey1zDOOwf1wOs19qQqX5hPLdD3yhvNr/5OUi8xHWa3nDtfaifsf/fkIhSXkdTlQYzpgNFDxjdx02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ew3wy6NI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so5014983a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906646; x=1734511446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFv+0mmmV8AKEmbdcMk/3e7lKZ8tCX1WSd4MT8kfTFQ=;
        b=ew3wy6NIO6KBGOu4S4YgI/DzfobE1pet8XSPROXwbGfXy7dfivYOk3j5wngvxUBlPd
         CCNtoC3HzgkdyooJrzfiDlKysGFK0vNB7duMALbusZzJpF0+FgxquA18zYQbuLAfplst
         QDDjNrXJIty5i+Eu/ygI+geQ79cm7sN9qpTfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906646; x=1734511446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFv+0mmmV8AKEmbdcMk/3e7lKZ8tCX1WSd4MT8kfTFQ=;
        b=PLWE/DRpzXBX6l2gcmA7v3y5qql9l6vQZlN17EY639vINjXmFlXxDl6WdgUM4BpSnH
         N7NJ3TSXIiNR9ZYRiP3cEktU0RUbQlDfc1d3uMQQHHTA6XyKnnPFwqK367rXiySPH34c
         BgRWbWI/t7l6XvmnA7+RXN4NC0LeC8iWyhqMQhQl44vErHycJmWxLszQVZlqSoBEDmfZ
         zCIeG5soxljI8vFn6ScyNPT+wL+we8hmN+LhVzyivjK2ol6j61UyNCYqA5jtZkFHl/qS
         Dvc8tDRFoGAUwDA/cH1UYnxzUF6Pr5uU86UYqccGrcHdUci5IynXqYyuaa6LgKENQ41W
         bY2g==
X-Gm-Message-State: AOJu0YyaIFbHvG7Cpxf1ViZ7IitnDGCOfEe88w31Nw6p9KeYD05jy6df
	HJsN88j6lNu/eUQTELisJSobFos4PQClWUJ7MoK12It55+JUh65uUIdFWBkcVw==
X-Gm-Gg: ASbGncu39ZiVBGu3vxIez5QAQ18oDnzXG42On++1jQm47+nh1Gm9TBaB9ON1cwvtQIb
	qdZjy0JFCmeSHe16X2IJsu2Pd/QIX2UeLsSacjwc8TlocOpTLO8MjvqOHJmQD+LKRAG9BjuQEsz
	etO5AIboipva5PZhqTwcjTtr1yDxU2EZiJ2Tm7x3nXNc4PHIh8fNS9Nz/oMlk4NsK4Xs+OYDk2n
	PCZUjELHkaCmbQFQI27wBum/TEf7lSmbVhumZfxLK7BE7b9lQuKyYw2MxZJdeD7hoSTjXCXkGFa
	eXmlsgPNHC8KvqOSgg+yPeSlQY5IJY6gge5zMA0hwYxVOParmF0AdgRa
X-Google-Smtp-Source: AGHT+IF6s6X3qi2mY7yU3Evg1fbHTuNTJxmi0arbu/Q2qkM1q80U428a29momtoh2UAdAWjsfTkUug==
X-Received: by 2002:a05:6a20:4326:b0:1e1:ae9a:6311 with SMTP id adf61e73a8af0-1e1c12459edmr3388494637.4.1733906646595;
        Wed, 11 Dec 2024 00:44:06 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:06 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 2/5] RDMA/bnxt_re: Add check for path mtu in modify_qp
Date: Wed, 11 Dec 2024 14:09:28 +0530
Message-ID: <20241211083931.968831-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

When RDMA app configures path MTU, add a check in modify_qp verb
to make sure that it doesn't go beyond interface MTU. If this
check fails, driver will fail the modify_qp verb.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 215074c0860b..a609e1635a3d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2162,18 +2162,20 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		}
 	}
 
-	if (qp_attr_mask & IB_QP_PATH_MTU) {
-		qp->qplib_qp.modify_flags |=
-				CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu = __from_ib_mtu(qp_attr->path_mtu);
-		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qp_attr->path_mtu);
-	} else if (qp_attr->qp_state == IB_QPS_RTR) {
-		qp->qplib_qp.modify_flags |=
-			CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu =
-			__from_ib_mtu(iboe_get_mtu(rdev->netdev->mtu));
-		qp->qplib_qp.mtu =
-			ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	if (qp_attr->qp_state == IB_QPS_RTR) {
+		enum ib_mtu qpmtu;
+
+		qpmtu = iboe_get_mtu(rdev->netdev->mtu);
+		if (qp_attr_mask & IB_QP_PATH_MTU) {
+			if (ib_mtu_enum_to_int(qp_attr->path_mtu) >
+			    ib_mtu_enum_to_int(qpmtu))
+				return -EINVAL;
+			qpmtu = qp_attr->path_mtu;
+		}
+
+		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
+		qp->qplib_qp.path_mtu = __from_ib_mtu(qpmtu);
+		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qpmtu);
 	}
 
 	if (qp_attr_mask & IB_QP_TIMEOUT) {
-- 
2.43.5



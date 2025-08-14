Return-Path: <linux-rdma+bounces-12755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B342CB2640E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F8817D510
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25934262FDC;
	Thu, 14 Aug 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gx+09OV8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB42318156
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170401; cv=none; b=uQ3AKnXiqtJA3F8n6DkxHAfuUNoktPnS6igTEoXhSxHdgeF3E7TpTSWuKXC/k6RJvslJAE5oo2h3EBlnlJCGUZJlC/YYvHclNHlvtpBQw1780GASHyjXJt6XhyDKrGn+6CrN8ZZFyVPwjWnsttKdc08SRmuJ8QFPj6prJa+11hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170401; c=relaxed/simple;
	bh=iby7GETcy5VmXspDbDlSrGoA8IPkmbeIddt3+LE38WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvLo6i/dJFkFzRyvYSJJGZrTUwltwD4SRHexlK92XVRXLptkTa/l8Nmnn9vhJ+gcLIBJoq1Pmo6kY7Fu7N9/Cr76gyYvUNgLSD8TMk+4mBqui4yMGzhzKsD4tPbg53DxKr4n3Zbylq6GcCKQGSyfgmbso+wictNDq0QhPmEfnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gx+09OV8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f581aeso6129285ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170400; x=1755775200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Y/GNJIhZUl882HOD/milV/U2nCPmerlQKohacsj8w=;
        b=gx+09OV8mpEjsuKILNjugnFge/MA+L2ZRjC+TaU2IZw/zVtCtMua6Yxnoiv1/aYDev
         mmYjF8zNUuYF9G9r+q+gAyoJw1DvhaEC2gMOwrQQy9T6OALgEI408Fz/TBb1+RT5KVT8
         LXymxsqnKH4SQHu7n5M7l3QMZpem3kscEL1wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170400; x=1755775200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Y/GNJIhZUl882HOD/milV/U2nCPmerlQKohacsj8w=;
        b=JE5fOnrUXQKHxbDeh4aHo1eWzsuOTB409BkpS2kqhYd14jG2+qKyHFGr8i8P+tzrie
         WxwpUfH60BaYE4UwRWgR4Aq8wi4SSZ+na446KSd5+LaQGBsw7StM9Mw/RlpH6e8BGMh+
         t0cHrfgVQXQlGbGzuepq410UuG5NYEgAd0gAxwcE4OrQBrUqSbTaELuMYfquT+IBWRZU
         AmM0xij5hm/N9xG/K6exx8/4IS936hSL029w9fQ1HigQWlYQpWazCKYvJ4AoZA2I8poF
         AnGpvd1oxUHCsX9ZxHgnbSFNoljDefX5fVorzTAUR6+ZCBGDICQs+Vf95PhU0f9NBmCq
         7OtQ==
X-Gm-Message-State: AOJu0YwNw8TlaQClUXpVRVG3MyzbGoTT7gALi0gl6KMhHkQlWzmSo7/W
	775S1sgyLDBU139qC0Vds3TYGxwrQAtuApizLSIc+0N9eQ0FpUIP4rOMlqEeSdwosQ==
X-Gm-Gg: ASbGncsUso9cNug6AJeFVdlkF3jDY+jydUnIVpkL3YD4nJ7jshFyFUBLXPkZ0ONQH9j
	z5t3sdVR1fpYGgxb5vy8d7PgLq/Wq/qSU+D/DD4GyKfkZiyue2E71ZnQhcv7Bu8x/oMNLCc4eR8
	iswY+iaSdrM8nrustJmEZ8lPPErU7o1bbEW/aY8oxIl2DWKi3CuFC6LbRccm2Wqhp5UTMiZTCuO
	9g2WvcFiyrjTO5yTYK4UvJboX6OMFnoiDvnC6ZBcLWd01zMQkXsFOvqMTV/bsgRri9RYe3RaDnL
	lQj6cuHg3hnaE8LTOzAX7axCGT+FjTY6+c9rTWzeYSJ7k18zaR3KF7SSDPU2GzxwSQ12bllnCR6
	ARFAPGogHEzAhPy2cQfxeTudBH4gEpeYJ1VEvibyIW2cUVGrWRN1FYkTm/ht7aRfFs/e/Lda4oO
	yS4Gp+1l8zxLNhrWMmai0Iu9HktsNhqw==
X-Google-Smtp-Source: AGHT+IE32TEie3PQGFesHT+pmMqQW7QFMdVNh+Vb0vhgmbq38/pJGgvX5trkdFU7jVWeAe3LDMOY2g==
X-Received: by 2002:a17:902:e88c:b0:234:c549:da0e with SMTP id d9443c01a7336-244586c50bemr44285765ad.47.1755170399791;
        Thu, 14 Aug 2025 04:19:59 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:19:59 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Chenna Arnoori <chenna.arnoori@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH rdma-next 3/9] RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM's
Date: Thu, 14 Aug 2025 16:55:49 +0530
Message-ID: <20250814112555.221665-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenna Arnoori <chenna.arnoori@broadcom.com>

Add Linux kernel dynamic debug prints to ROCE HWRM's.
Dumping request and response buffers for the ROCE HWRM's using
print_hex_dump_bytes() to be part of kernel dynmic debug.

Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 804bc773b4ef..b97e75404139 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -366,6 +366,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
 	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
+	print_hex_dump_bytes("req: ", DUMP_PREFIX_OFFSET, msg->req, msg->req_sz);
 	spin_unlock_bh(&hwq->lock);
 	/* Return the CREQ response pointer */
 	return 0;
@@ -631,6 +632,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	int rc = 0;
 
 	pdev = rcfw->pdev;
+	print_hex_dump_bytes("event: ", DUMP_PREFIX_OFFSET, qp_event, sizeof(*qp_event));
 	switch (qp_event->event) {
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
-- 
2.43.5



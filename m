Return-Path: <linux-rdma+bounces-6225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628619E34D6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2783E286335
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E11AB517;
	Wed,  4 Dec 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JO/73Rsf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B9192D86
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299103; cv=none; b=hWiQMYwE4iqgTbDiybS9Y67f3waGys4ptSZXj+D1Vb+98TauN8AlPYODN7nDcGqxc0zMdvw0vYysUyVf9cmK9bbccTQcwFiItjzhmkxH9QoCS+ksdECziYpxlDRqsf5H0cEvkgW5sT9cjUAp41pMtceFEzMtAGvWsjzpamQZa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299103; c=relaxed/simple;
	bh=OZ4wyRzHBU5rqcqF7W/lQKMHAgbC4+ZvqLu4lTxdGzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFTWELiSXzudqJKlHd2hMuCYhkf002KnDT2R+zDOyMg2gdvR9SZNiYaOjsI0okgG1V5eGreYteV8Ae3Gg7rVCyUZ5MDZndoYEr54t498hVG+5y7DH37hbB3LKCTcocFTiUfwdXjDK/VYf0nC0vAA6smLjGJplGenRIQzzVcVHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JO/73Rsf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so6083005a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299101; x=1733903901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKecRt25vJsTpHaL0ZeHZfAhYJqkh6lLNdCQ7xdxmeg=;
        b=JO/73RsfUAIza4LEAGHc5iUNB7GJMJJWh1FSLIIlakN4KsQOx0JYCvZ23zUazc4eWF
         Ox79XtZwPhPCYtW2sG27hsW2f1iETx3vwiG1r+t5xammc7tvpFxLF+qVhYh4v1jezbXS
         AI5SadXqRNzgSnMDF5qGQS427mgpV8zbSur5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299101; x=1733903901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKecRt25vJsTpHaL0ZeHZfAhYJqkh6lLNdCQ7xdxmeg=;
        b=fHhGQDDg7A6IyFoU4bpqnYenTI0lMvYpClkGH+zCT6V3VtvoN5cprMS+WG6SL5lyeg
         wCUSS8VMtIp9WxVFcXSixAcTwf87t2hRRf1uibc5Gn5VXxTjGpWp038ssjDw20xxR7NN
         +xDDPOohvYhif26JqHGp9SPD1x7zb+8/WhYAHP7C0H34bPxFarySmFOUgn1+QL2C2WLQ
         M2hcWbb/GJlI+PPCrhTaZGdNIMWw9q5hm6Umx+kpRGV2Wu9pDFIOCgomXbhm6PwdcZ6o
         K/CZUdeIdLN1G0UWGwt+fwSAnavRNS947qaQSDzB44Rxnx3AXvqF6JUyPsixrZWDbPMi
         LIPA==
X-Gm-Message-State: AOJu0Yx16yEuqnC7EO/i2VNIy9IaZL18p8vsMWcshumFx8vg0jJiBkiZ
	ISkGjkQNuUbNSuPkMbDwNCn6fJFg5mjVbbvlsgGYS1gQDm854wZjKKMrxv/zQQ==
X-Gm-Gg: ASbGnctBQu94cYGZDXby5TxrTjUC3WY2Jgo2JSt5W5rc5ZIHjmFdqSfKCdQ48ou43lg
	8gp/nFs6iXaxIeYdCLQhWRA6syVTvbyAPsdM3wBvHOjuVNf3ILj8JsoVm4s8lMf2qpzzuIV9hfr
	sgnT2HbDalXpYNVRKCDidezckCxGMqusVn9yb88X/GyrovlcMY7dl8McfvWN9YbURtqDOON0WeP
	M/gdfjTZxoXWtNh5FfURRXXuvt67bgHGnmyKKHuXXljyMbMQP19RgkulsSKP+V3k2mHfibgdK3P
	0LlaDXuD6xdKlH53v6513U0ukWuUd+1JQakkT7Une+bvfHVNoLBW
X-Google-Smtp-Source: AGHT+IHYJ1ZI23dyeyUS9wlX0ia4NwPLoK+Av3FGLpFPGLPi4reUSdkkwYq1V8f4bAjzW8LGiJ4Q/g==
X-Received: by 2002:a05:6a20:9188:b0:1db:f057:151d with SMTP id adf61e73a8af0-1e1653f2632mr7389513637.35.1733299101575;
        Tue, 03 Dec 2024 23:58:21 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:19 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc 3/5] RDMA/bnxt_re: Avoid sending the modify QP workaround for latest adapters
Date: Wed,  4 Dec 2024 13:24:14 +0530
Message-ID: <20241204075416.478431-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

The workaround to modify the UD QP from RTS to RTS is required
only for older adapters. Issuing this for latest adapters can caus
some unexpected behavior. Fix it

Fixes: 1801d87b3598 ("RDMA/bnxt_re: Support new 5760X P7 devices")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 82023394e330..5428a1408cee 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2824,7 +2824,8 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 		wr = wr->next;
 	}
 	bnxt_qplib_post_send_db(&qp->qplib_qp);
-	bnxt_ud_qp_hw_stall_workaround(qp);
+	if (!bnxt_qplib_is_chip_gen_p5_p7(qp->rdev->chip_ctx))
+		bnxt_ud_qp_hw_stall_workaround(qp);
 	spin_unlock_irqrestore(&qp->sq_lock, flags);
 	return rc;
 }
@@ -2936,7 +2937,8 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 		wr = wr->next;
 	}
 	bnxt_qplib_post_send_db(&qp->qplib_qp);
-	bnxt_ud_qp_hw_stall_workaround(qp);
+	if (!bnxt_qplib_is_chip_gen_p5_p7(qp->rdev->chip_ctx))
+		bnxt_ud_qp_hw_stall_workaround(qp);
 	spin_unlock_irqrestore(&qp->sq_lock, flags);
 
 	return rc;
-- 
2.31.1



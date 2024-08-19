Return-Path: <linux-rdma+bounces-4410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEE956305
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 07:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B1A1F22262
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 05:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBF1494A9;
	Mon, 19 Aug 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TdTunkS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2621474CE
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044134; cv=none; b=PQLFG9zpe7qYHs6KLaCou8BPg9wP9mp0UsC09VZuwNTlrAv1+wAr4S0X13DsdRk7xyHE7zcPWgnmOlbVoSIzN6pGnEMhXIqazrG8I97hh9gkD6HOUS70gAhokfe5bqBFo1PZ/ZnPcWIfyBNEgWGEho3I/3ng0zKIg5+ytn5LSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044134; c=relaxed/simple;
	bh=1/geaDc1BsrJyyrN7G8SbKsMVujIayqQAPYfTTyIitw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LJskLISGwhKPln+pKVBVeuV3spkJWBeD7HiWapnwY0bx6cprLR1MjYE2P+6+dpsmkcjziNijxgnyUc7su7+a98rMUFMiftYg1BB0QsGlO1VXQFoWeA+JrLB02dH2YTNNaBVxClkoctRIoYfTmYRyk4ilD/WJZy6MSAoeUnyhLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TdTunkS6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093f3a1af9so2453032a34.1
        for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 22:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724044132; x=1724648932; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2DSdWyXag+IfyFGtcfwPMLPYZ6uqtC0MqWW+pkBibs=;
        b=TdTunkS6XSkrfHKJMYnz1L1SvHIdi31Fp9s+Wxo6DllJG7/A0vd/uJnS5ui5VZZa4s
         tpabRwJHjceCw4fRwB/Ko2WO0ET5zHp4Ul87wWkO4FSWjy+AZr6ArHR6q9V+4LFLoWgV
         bLKalGN4GW/YphD9fXWjYodd0Xb6hc4ur6p9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044132; x=1724648932;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2DSdWyXag+IfyFGtcfwPMLPYZ6uqtC0MqWW+pkBibs=;
        b=oYb8ysiol+eJy2DI45zaTA8LsWSc9IUkrHyEapxML5cvD21wnK/er6tcZC0NZx1PCv
         UBvTNy5/EXrDeZGcL1Oqno6c9gBJi4qXsC7b3T9smsAINkP8Sr/6DDjjW2lPBAuThzgh
         X2zU2FRq2ZV5xFIVi23bYjI3UKQQZznwHLIBtpXwx1nj3BapZIwYe7Y0rU8euDIgT3d3
         g8BBVYapbZt5wi6XX+eFXW4YZXQv6qe1xSmwM2U0Slzm62Ta3fVWoWcTJxCj3QgjKz42
         2mI/JTzMZ65BBb+gSIc6Rly41JZUW4SaJ7+gHID9XNbJLaX8Rz+g9pf8MjvYy1nM247h
         vcdA==
X-Gm-Message-State: AOJu0Yx1r1YV7E3OZrwRauZS9iPg2iGY+M9qP3ECDb2wycf1i2Tc/rkO
	pgMSOWbY3MEZ7U0huIlM1wi0gQrEODVPV5ZgXuPYRaTPNLsFxMCD/f6fjtx8ea44V+684DVFqP8
	=
X-Google-Smtp-Source: AGHT+IGaQz9OEVc6gX4SZbmI8hPq7aRFVtY90MqRgS758lo0XlTkYUVlKNMN6+oFlUV4TDPsuJkM+Q==
X-Received: by 2002:a05:6830:3111:b0:709:50e6:489d with SMTP id 46e09a7af769-70cac83be49mr11472873a34.3.1724044132033;
        Sun, 18 Aug 2024 22:08:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm6908021a12.4.2024.08.18.22.08.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:08:51 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 3/5] RDMA/bnxt_re: Fix the table size for PSN/MSN entries
Date: Sun, 18 Aug 2024 21:47:25 -0700
Message-Id: <1724042847-1481-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

HW MSN table size is always a power of 2. So the pages
should be mapped accordingly.

Use the power of two calculation while get the number of
PSN/MSN entries.

Fixes: 6f6bfbc595fb ("RDMA/bnxt_re: Expose the MSN table capability for user library")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5073ab1..4dd137b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1042,6 +1042,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 			    qplib_qp->sq.max_wqe :
 			    ((qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size) /
 			      sizeof(struct bnxt_qplib_sge));
+		if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
+			psn_nume = roundup_pow_of_two(psn_nume);
 		bytes += (psn_nume * psn_sz);
 	}
 
-- 
2.5.5



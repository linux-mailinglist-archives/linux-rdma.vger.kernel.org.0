Return-Path: <linux-rdma+bounces-4996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71C97C326
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55978B210AD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826D2F28;
	Thu, 19 Sep 2024 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ke+kJanU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA912E78
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716430; cv=none; b=d0TYMc+3jjvMbMywk2ZOLF27aO79IwzCe+SkSjOI7+e7ugy1IA3Rr1ArIqosg0xjkIpyjHSTMH2KK3sduKMwCW77BTrmxtcE+sOhWpUFE2jj0X546HGYVRz516AUwLvLrPru3Fr229HMoEERpFNqyn8tR3nY2gPBngyABg+Dte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716430; c=relaxed/simple;
	bh=LEGuH4tSOoIsNwRghgKcYErGRomBiyo65BIFsSBqd1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UJEcXITJXWrjyOI0ISnuLdGMC9LvVOQiEOCkxxKPiQik4U4Jv6kflZqBPlBlkVNBjkIAGRtCx/ZTNEux2Jh9EXJkWW42+8tQwe9MaasGauciI0vJEWh99511K/RuMsCzzpFoOa+edFBPVHb+lyt5eJWzmN5rACxfiGRCtGs1nWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ke+kJanU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e285544fso262246b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716428; x=1727321228; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvs8x34GuGbqFJA8MliJr5Q8W9/ZFBbyCkYLeglcrYc=;
        b=Ke+kJanUlTGvVJt+ib2S9W7FHgou8pjGzf/v0ZqWXENZ95jrZBXMzIeNMp0bku3NHb
         9UmhhBj9mIekKdkPqqWoZeTfcCy96g0bp+P9rqHTMAUDsKDGz2oIc/5PY2YC1by6S+pH
         DTuU7uA7CzE/J5VBcxFhrKLYLovyvK8SCqXMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716428; x=1727321228;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvs8x34GuGbqFJA8MliJr5Q8W9/ZFBbyCkYLeglcrYc=;
        b=oFRBIv2nyIt5n6J7Lx6uwScuu+aPJ2E0nLNMyAXaamrjZast9R2xFWqd2SgYFMQM+P
         LNdP9eOgD4z2GDVbq0wiZCaXICyk434mSnjmLkBCd6M5HVh1E53+o7VwR5e39Eiq9Win
         9xM4H8/WSdna/q1cbQtiowsO7q2cK7oUbz+WNCEusW+NlYZvdb98OfCc49J/T++XZhBV
         UryjYjcqzVyzsa2oBUNcL0/yEnRF9UUOQAB5DdWZz/2f64F4OmzuC+nIESPHWIUjRRfy
         DnkzRjmlFlN2MD1OBTSNzcnjvWDgRcc7nw8mkd0efZlOlpZ/X5ALA1vuPJhYpe+Hb7jy
         RXQw==
X-Gm-Message-State: AOJu0Yz4CDJWVVF6TkQbnjhlN+KO+SuWXj9FLjp2Ldqaun7puVmgZC7v
	4Nu6yuUXcXukCfLTQGdf5i5snj5hlUD6iZwazi0dCGhZtO3FP7Xu7p5RJcCBUg==
X-Google-Smtp-Source: AGHT+IGovtT04LGbAYJR+tX0Ez5roL5HmGiG6YsEAWGg0o5C6OUdHdOKqnUFMo5lqiis0FVhRdhDIg==
X-Received: by 2002:a05:6a00:23c3:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-71936a4d269mr30337660b3a.8.1726716428401;
        Wed, 18 Sep 2024 20:27:08 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.27.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:27:07 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 6/6] RDMA/bnxt_re: Fix the max WQEs used in Static WQE mode
Date: Wed, 18 Sep 2024 20:06:01 -0700
Message-Id: <1726715161-18941-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

max_sw_wqe used for static wqe mode should be same as the max_wqe.
Calculate the max_sw_wqe only for the variable WQE mode.

Fixes: de1d364c3815 ("RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 460f339..e66ae9f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1307,7 +1307,11 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			0 : BNXT_QPLIB_RESERVED_QP_WRS;
 		entries = bnxt_re_init_depth(entries + diff + 1, uctx);
 		sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
-		sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
+		if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
+			sq->max_sw_wqe = bnxt_qplib_get_depth(sq, qplqp->wqe_mode, true);
+		else
+			sq->max_sw_wqe = sq->max_wqe;
+
 	}
 	sq->q_full_delta = diff + 1;
 	/*
-- 
2.5.5



Return-Path: <linux-rdma+bounces-6569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25D9F48EC
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C31890EFD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9E1E22F0;
	Tue, 17 Dec 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KUjMwX0y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3A1D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431527; cv=none; b=bxNUyIILdJN+X9JpvLsxVXRE+xWHnv6ZwoW8zqsucE4u2+tuUsJoSk5oSRRC6Iwm2tJOOjUGeZCnJ+ksDCxqlBys9y06AKpX93OVAG+Grw3Xbro5YrL8qCM91GxWxnv2UqfdxpWv1tngcA4e4MBsSBh71FXoNTPnAjzTUuhTwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431527; c=relaxed/simple;
	bh=aUd3IqFr+Mcws/PReVSP5NcENMi1dnNzFcR4/uwVqMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVEFEDOggDNRmE7rKBI2EtrZdfIcydR1Cb8TSyCExHNPnpixLi0J+8RDtrPqh+krcZrHeFB5IxzLljVx1mBCiqZIkCbMOZbuzNmomtv+HxwzA1iLfMzOgDm5WHGGn/HpufVWGrPUytOuLIMQQ3o41HFlITTlM7Ye/Pe73p0fWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KUjMwX0y; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so4589655a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431525; x=1735036325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ljCrKcn/0XeoJXBCkWUZIYp6fgvcEpme61m1/wN5EM=;
        b=KUjMwX0ylzLawj77L3xBVY/KHal+bTXmwSUuuZhX9jrgwrE+wcDTvWNZ7ywfwWBkKX
         NRw+Z6Uq6VVQDYS5wEDV1WShyj81rqilbMFUjcCmWUytv8Q2UDsXmNyS/NfhcIF1iJku
         Pe3wP8Gn2a5CYBkwnn8Y43v1A6IwlKaeYq5oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431525; x=1735036325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ljCrKcn/0XeoJXBCkWUZIYp6fgvcEpme61m1/wN5EM=;
        b=ZMNYFFvsklOA2zjefbShDWXHHt0LZ0Jl547+wqcP1pQxzKeodHeoOgCnkqSMANsn7L
         e1i+WSw7yj+vENI4MqJ9/E3K+TKQPnK+82ITHiPYZ35QFiHiySHU7GPDPbdQTmJy9IoC
         QMeA/FuHtzKejinxuFPx2GdPkOo3+3cD7i/9eDTM7VfeEWwIjZ8khIUP+L2KfZBTT8rQ
         mU+SnkJGglhULY1kAnfbWdrZTS6cEnviIv6LVm+gSgWsbxOZUdV2tNllBLmEqt+hGrJS
         VuxlRYsizo+gFZCRaYvUraT9wXDHuGihQHRtlJn7JEtz6zitLloRBEbUgi8SWO/rWrGx
         3VDA==
X-Gm-Message-State: AOJu0YzuLsgN+K6XW6FUeAvZRC8dBvb6C3fvqlySMPf5bANIaF5MPaK0
	DrX5JL1xyCGcDSpbLBvVGWkOCnmcF0f4uGCoe0pNOGJfpIMtxtNYdap3RZi8ptK8UCntLaNi6Ss
	=
X-Gm-Gg: ASbGncsiiOFt0e6Zt+1SftsNiDWkakIiOjJrk01Lh6/O/yZ4xMGbpziRmAdhFlnD5ES
	0EOPi7a2JA1Jh5n562OJXJIsoa9w4jQos18P335fOgtDU7j5oieRUpN7MNKoZ68ny+ED8X9SDN6
	5pL+g0uMJpCytqB91LMKaR7cfTB2dnOBwbYVsHdD5MsKIiOYFsNmy9Y3iQM9io0ZGgx4ofjc0BI
	gQqN+r7o4l2iqgHwUBZtY5695cYEUl8AC6i9e/fwSVKg7BseY1wMn5pX8MBjDACjjBdKdzAQaMl
	1MnV9Y2ZprntZ5SNgXJ4K7ZNKvAdZk/RzcgsUiJiGHwl8DKJYGiNaXjR/LE=
X-Google-Smtp-Source: AGHT+IHQaAMZYxufyP4jgyv9WZE58kswXVVKoFW39BpjQkkwYy0LxtdAX+cbrdcRsGzAZlIR1rHDCA==
X-Received: by 2002:a17:90b:4b01:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f28fb6effcmr25998851a91.15.1734431525137;
        Tue, 17 Dec 2024 02:32:05 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:32:04 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 2/5] RDMA/bnxt_re: Disable use of reserved wqes
Date: Tue, 17 Dec 2024 15:56:46 +0530
Message-ID: <20241217102649.1377704-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling the reserved wqes logic for Gen P5/P7 devices
because this workaround is required only for legacy devices.

Fixes: ecb53febfcad ("RDMA/bnxt_en: Enable RDMA driver support for 57500 chip")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 73c9baaebb4e..776f8f1f1432 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -130,11 +130,13 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 		sb->max_qp_init_rd_atom > BNXT_QPLIB_MAX_OUT_RD_ATOM ?
 		BNXT_QPLIB_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
 	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr) - 1;
-	/*
-	 * 128 WQEs needs to be reserved for the HW (8916). Prevent
-	 * reporting the max number
-	 */
-	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx)) {
+		/*
+		 * 128 WQEs needs to be reserved for the HW (8916). Prevent
+		 * reporting the max number on legacy devices
+		 */
+		attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
+	}
 
 	attr->max_qp_sges = cctx->modes.wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE ?
 			    min_t(u32, sb->max_sge_var_wqe, BNXT_VAR_MAX_SGE) : 6;
-- 
2.43.5



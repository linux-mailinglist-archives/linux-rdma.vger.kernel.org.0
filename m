Return-Path: <linux-rdma+bounces-8560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA3A5B894
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 06:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B82189564F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 05:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D161EB9E8;
	Tue, 11 Mar 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NOmTXSoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AC320F
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741671449; cv=none; b=rv24p/QWF0d29tyykYjfymr19jhIgHDruD9TML/NPJ9K97WgKDN3RFkqIl89G7GtghnNDvPfvMg4hwQazINpRiG5HCh82DS5jDe50WWP8Cx8X+m5powLTPiXMnadSGSiT9BkU5V0Ptl/P8+KXAGDtgnqQ/3bVL12jk/MOdSwzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741671449; c=relaxed/simple;
	bh=2Ifn2pcCAdGkbRM9dH+bPsuj9AtPa6DxWLGZZD/is14=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CWlp5viNwX+Jw9llHH57fbJtTp5XJCVvvhPtiR3ZdIaUmcvTZ60qrkCSJLfKW81R1B583AYhGOg0vZuvMXlIkQHGPglHL0orXlQCvs27prKJ/eUSg+bfaXJlMt6m/3VMV8MWKnk2ApQOGhMcGGoO296latoeZlw0Xlu0UFzb2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NOmTXSoH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22334203781so107754765ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Mar 2025 22:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741671446; x=1742276246; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy2/r9jEnUHDehhtzfddObQXYyRXnyjS5sfZ+r4Up0g=;
        b=NOmTXSoHJoS4+Evwsy8CoIcy2R8hF01MPKmbnpJAizHs47B4SCCP7cxTBRHu1QPPsv
         tdFCJKjcb366P/8fsQUHT7tTG1CjZVucbSMg8RYZR4iXV1siGrih0/WXW/qbbtSnjxwA
         PS7L7WSA0e8VNoqOeFTfXmFU7YiMjwRp1V0Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741671446; x=1742276246;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy2/r9jEnUHDehhtzfddObQXYyRXnyjS5sfZ+r4Up0g=;
        b=U4rBiPmsj4ITx2kEcTBEJfmlOeiBDekg3YSuGMubgRFCjhmhKMx60yIwW1ykq9mLZv
         OUIqCXukyIQurAfdyqYOJoCP7LMzbHMnmQkPUMjbifYg7RpOYmc8m16qp2M0dYQpGFVM
         xQBorovZBzY+QGMjBAF2607lpzNx9kTaXdPlXP/qsHTCGQbE4TE//pjCElElvawgeK3C
         XP8TCN7SFxUUIwfD0+YYUJeLKh+AM9QpSjvSQQxRsaLMrlCcFc0iHXlN5lWfXzpi649E
         QEDkabMV3kE6yR07rm9OuN+YHJgzTKKOspo83B4Qy/rhjsLmsh4fddXxCrTxYLqgYyNH
         pS7A==
X-Gm-Message-State: AOJu0YwDMZOQXnbi9S0cgkROkhtA8flXwjc6csfd36cnUDltLWBnOZR1
	mvZuHWbjcOBcQVbCYpJbQwJ1QRgeTyjeaJejfbRRsg0xcayDgXpSMIojcKtCIA==
X-Gm-Gg: ASbGncv3pBstC5/vjtkEGX1Sl8gJLA6m3/1KplP10QM9F0Bua/5A8IrmjGjT/428DWM
	dZyir8SzZg9lCiif8yigYON6QGMr/AyjndWOqu2hFKp1HTJ+FKiSGBQ3TMXUaTI52StxtMJW6sK
	EQQNw37NTHozqQBhYrAyn/1x8ATbxIadJdjCEbptk9waDUI/YvAFM6MMwgtrGEsp7k20MmN9Qfa
	aTqn25+w+ZwRWe5z2Q8dtfU2PRN/3RD+3iY4LHeOfaHWmBMytHNp1SbqDAbGibTQwsOFHiTPuve
	v6bmgaQc1De9uxNDUQcNlEhmXGCcIQQEi0H7cviwAT+HhsqiH6yPVlxjT5DRaKpr1esa6Lpk73W
	V2GsQkno+AcSmOJxb/XofMXO7
X-Google-Smtp-Source: AGHT+IGBmuGjAwU0Buk/H+yfUcP3gM7cy7xKAWJ5zA97GjfpOWfa/bRSN4ftrcKru9X+U46hD9po+w==
X-Received: by 2002:a05:6a00:638b:b0:732:57d3:f004 with SMTP id d2e1a72fcca58-736ec5f1748mr2498209b3a.6.1741671446372;
        Mon, 10 Mar 2025 22:37:26 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f6f82sm9340341b3a.115.2025.03.10.22.37.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2025 22:37:25 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path
Date: Mon, 10 Mar 2025 22:16:36 -0700
Message-Id: <1741670196-2919-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Driver is always clearing the mask that sets the VLAN ID/Service Level
in the adapter. Recent change for supporting multiple traffic class
exposed this issue.

Allow setting SL and VLAN_ID while QP is moved from INIT to RTR state.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Fixes: c64b16a37b6d ("RDMA/bnxt_re: Support different traffic class")
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 5336f74..457eecb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1217,8 +1217,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
-- 
2.5.5



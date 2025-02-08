Return-Path: <linux-rdma+bounces-7583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFCEA2D689
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A473E1679AC
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF682475C3;
	Sat,  8 Feb 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uoc/4Z7q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93151DDE9
	for <linux-rdma@vger.kernel.org>; Sat,  8 Feb 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023757; cv=none; b=cT1EpM74gVWiY6rioA4KVFumu6IEYSqRxn0UUkPxD+4D+lvcy9kj/6WEkjRkLfmGlE/VnI4cpOcUe1Kl+psHDdd5RRERftq0nBdeKjycbUepejpsFhsJvLdUbofKX3X52ZAz+PGGK4CxwSowHuz4AxgftWFwXLTB34JQBdPgB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023757; c=relaxed/simple;
	bh=2X/7P1mGcvshOKZ3V3jFjhRHA8l2rwTh1YLWb+HvlXM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JOgllCU5soKx/sDFAkkXuFhyhoKyBAXqMJAvMPjL+rePxVEBL0eaU/qXuZXumoC76waRDojiqLry+6BBJ6LBskTK3DExdpoG7kiXoXCo9cBm3QfAxv5mrSmhXqy+OZBXbnhd9cM5ojBztW1MAnUIF6gE12PFC4uALqFmvu7n89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uoc/4Z7q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so1346802a91.0
        for <linux-rdma@vger.kernel.org>; Sat, 08 Feb 2025 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739023754; x=1739628554; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6rKfKR3AqSqxmzHYj91aImsWBwAHX8CwXyQvFsisDQ=;
        b=Uoc/4Z7qEBx7FMf2sy8yKNNdKLR2+9lilyzkzMr7QCSXY/8rHpQG6nrJXeYWnsRDQy
         BAij45ursWffOR3GdS7jk9g0RsFJ4TyLbnjxpGszfEHhjOvXR7KS99osS2te626sEF+p
         67krENwy1rmx73xIh26TOF5zyJlb1/e4QxN4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023754; x=1739628554;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6rKfKR3AqSqxmzHYj91aImsWBwAHX8CwXyQvFsisDQ=;
        b=U5uCLrBQPEabJm1xOUGrfwuu/o1EB+LJS5UP19KhcDuzxdRT4IVBe1dpQP6nsVeabC
         GLcfAtadLJatifGMUSwQksSoNDVF//A30ODXBBPuGkdxOVJrdKHt+1OvuDk45keeY8+f
         ICaqd5FzoCCXWV5oyMENti6RPNWuLd69rYs0+s6takVAFev3ts1nXl114J4TBw2ZcqZ6
         gDn+8jsLBIPtIuN9k9d1stxxG/YPUZ3ct+GUf2/HTMi4/qo49OecmsVMW98wJkNHiJk0
         XHSDBaq32eNb4iqLlBfgubRaFhTwQ7nYpmFwdepuNnGmrREbCHV+Lw1sdTu5GWw3Pn5t
         01Og==
X-Gm-Message-State: AOJu0YxCvynMFDPqK5c1i5XG52sqhKbVrKvlGlHG2N3vvC8sD8sm0UrQ
	rcbhsRbB+jrznOteOOkhfFQzWKzB7JLyNKihzsDVxjkFmkLOireI0XaYrJ8lPg==
X-Gm-Gg: ASbGncut0t7zIqadGoQ3Bjr8IuZr/x6GAhRgD1/dBgONLU8qEqZGHsN4v4e3g8aVIUu
	1p9WQACXqKB/kDABDD61UkOSqKpDI2XZfj8yH73l1K/o5eN7dRHs5vDjWUWMbBtByTKGG5Vf6B1
	IFmqnJR8rqTKDR6xpjlEqKJHQI5wqSOWLxYB8yKRMiT6//GDhHn47IfNjVAPz9afC0xtkpNTmmh
	7UHfO8weXJMmi155lJlRH0hSYAFRJ56gxGc5cGR8YH3upsDkcq8cIf1yB878pH0pPDZQ3EoA+uy
	MlUze5n+D9IzcKuBuIL9+3JCiiDuNvCndXQHUJpnwxFM0b7vW4nGqKFl66pRF8nor2g5kck=
X-Google-Smtp-Source: AGHT+IFhTIatqoczr32cCuSEFoaJ+fpN1c4p2xkH4oQYdHP3Re1KS0DHnULrhY82DDeI9uJ13vaI2A==
X-Received: by 2002:a05:6a00:18a4:b0:725:9dc7:4f8b with SMTP id d2e1a72fcca58-7305d4ed609mr11055758b3a.15.1739023754145;
        Sat, 08 Feb 2025 06:09:14 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d1bbsm4667592b3a.9.2025.02.08.06.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2025 06:09:13 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Fix the condition check while programming congestion control
Date: Sat,  8 Feb 2025 05:48:26 -0800
Message-Id: <1739022506-8937-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Program the Congestion control values when the CC gen matches.
Fix the condition check for the same.

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Reported-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reported-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index f4dd2fb..03c8da90 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -265,7 +265,7 @@ static int bnxt_re_configure_cc(struct bnxt_re_dev *rdev, u32 gen_ext, u32 offse
 	struct bnxt_qplib_cc_param ccparam = { };
 
 	/* Supporting only Gen 0 now */
-	if (gen_ext != CC_CONFIG_GEN0_EXT0)
+	if (gen_ext == CC_CONFIG_GEN0_EXT0)
 		bnxt_re_fill_gen0_ext0(&ccparam, offset, val);
 	else
 		return -EINVAL;
-- 
2.5.5



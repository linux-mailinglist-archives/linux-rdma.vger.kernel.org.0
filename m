Return-Path: <linux-rdma+bounces-6798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50283A012BC
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 07:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258B33A4544
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC401494D4;
	Sat,  4 Jan 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VM9yqdUM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED85208CA
	for <linux-rdma@vger.kernel.org>; Sat,  4 Jan 2025 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735971751; cv=none; b=E0zX8CGMnCJJ8/skKUUehGrShRV+hM2t9/9S5VhSujz/+wZ8KMq6LEYbH5Lao8mtD0yvJH+F1pfh3yykP/38tpCak83jyy+ksH0T6pyltZ53e8jzOuqJY/nfOqv7OsfbwJof3HyIdju2LvdGz0i0U0XNzJA+ogT9PzILySn/R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735971751; c=relaxed/simple;
	bh=Rr/2epI10MgYSwMax3gpUWMOxfo596pH4Qql0E9E2gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uD/W10CVTxh8qhBuDaap98rPfxJyNTAxW3RGEsFN0sXuSpRq8VONNT5kuQM7TkCZDGfpsUyvfB3lylpj2B2aOrQ3RhKwihvsyCHsWEPmEtK2zZPZPkK1fLyBn9txVrEvh4/ntkAo3t0+Vk6Xo7/Sl4frhHGropYiAdoUV8IRv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VM9yqdUM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216395e151bso131511475ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2025 22:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735971749; x=1736576549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCuTd3OaG2noXiTAUtcwMMw3VDBhzMFzhle50+9dgrU=;
        b=VM9yqdUM8GlB/egpshvC9Q0e6CaeF5wSmYP/tdb5iNOesokDAv6NdEn4N8C2VPt4o4
         oXMtSIe7nOC7TFmoWGl29uynR+fMCoo6ej+puspfWPnNLuQrFP3SemiPG0g+On/tT0bQ
         CkDmfQjBQkEKUxKhcPuP5l9vT0fdglziSm7to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735971749; x=1736576549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCuTd3OaG2noXiTAUtcwMMw3VDBhzMFzhle50+9dgrU=;
        b=I7Tb2/+TxYH4PZsje2UvIuYGQwqZxaTd4mMAcQHqqYbKHrDujoPr1SaTThT1I2xKl5
         9UI9p1ERjcWtpB+g9PrtqYJozzPJ08F22fXrnixo6nFBSL4R+5DI43oa+RHTgItqDYLE
         csqlYeXGSkI1ZOv2zHuxaUxUFdMW+hRRr0qM6I1jNqGTZjyg4EIzDpg6l4xdFfevhVTl
         DkBfO+Pyd5u7UVU4RilDdTvU9Z6bSN4L/KdjSVDOcMzYDpDi8Sc1EU6RoEzBGitRXW5z
         x1FPp8Oxq/v93GfdQRItTxnGitvrhAfc61GNB9WZe9XeDvKQImrqFFcvxq6/9YcytxXN
         sqHg==
X-Gm-Message-State: AOJu0Yxia8ivz1SPlsryCg0WopmHiey5yJ7pQuKzhO2ED0PoNUDmUD1O
	HNdJRv9k1wbyOUbr5VYtKm3Qx+dFYZsu92ZCnLxeU+lK2LWyOL8kyvqikMRsyeOgvl9/nlUFhiw
	=
X-Gm-Gg: ASbGncvo+2XWDAmHnxNv3zUOkXKc13cW4HpoxGPVJe+TOjQPqVnENFYBUjH0RQqQ3QC
	Be7lEZoUSZN0B280M4/6BIf3h92Qw+c/t9XrBttB+RbgqWFtro0egWuUbDA/x275xV/wuelk+/P
	nxcQgtXEmGJPIHEpPjXsEuphQqSkZhMYNrzUmDKFVzwLYij8MgufEhQkPwYAv/3+CGCn7wqw5WU
	PI2R1ZMYm15y2HaH+x3WuSfe5MNqlxG4AGsGnD6pw9nGoSdaad4xiftHSUyl7NJM1Ro+DiSXoqs
	OM7AVMHM3luSpdCfzg90s5ZIR/Ffi4wJkkGl3Umoca1QCgVM1kn05upp2lU=
X-Google-Smtp-Source: AGHT+IGOPXOAUoEI9dj9YH9fH8TzITfe+nCx9Gt2hJR1qVdyea4pImAubDM/00UXWftPcHIHKyZbYw==
X-Received: by 2002:a17:903:98d:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-219e6ccdc98mr821156355ad.7.1735971749009;
        Fri, 03 Jan 2025 22:22:29 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb8esm254130325ad.64.2025.01.03.22.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 22:22:28 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error
Date: Sat,  4 Jan 2025 11:45:19 +0530
Message-ID: <20250104061519.2540178-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error handling path of bnxt_re_mmap(), driver should invoke
rdma_user_mmap_entry_put() to free the reference of mmap entry in case
the error happens after rdma_user_mmap_entry_get was called.

Fixes: ea2224857882 ("RDMA/bnxt_re: Update alloc_page uapi for pacing")
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e3d26bd6de05..1ff2e176b036 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4467,9 +4467,10 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 	case BNXT_RE_MMAP_TOGGLE_PAGE:
 		/* Driver doesn't expect write access for user space */
 		if (vma->vm_flags & VM_WRITE)
-			return -EFAULT;
-		ret = vm_insert_page(vma, vma->vm_start,
-				     virt_to_page((void *)bnxt_entry->mem_offset));
+			ret = -EFAULT;
+		else
+			ret = vm_insert_page(vma, vma->vm_start,
+					     virt_to_page((void *)bnxt_entry->mem_offset));
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.43.5



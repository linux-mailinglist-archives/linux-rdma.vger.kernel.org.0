Return-Path: <linux-rdma+bounces-8006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CAA4098B
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C36A703D66
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091A19E83E;
	Sat, 22 Feb 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RmXkZKyJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC13224
	for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238872; cv=none; b=lTxp8kMUWkTFo8KXP9nRNviWVMUoBQ5gxB+86PzP7RwGlu6DTVO1llHzKAP0Ato2+yzStoJsPvRQAJfmfKoQ2/NnKRRy3Y0q3FBnv4lzhUmedkmd/jciCajHB1P+5MRxhPEqUKSQ8xxSWIQQbEiEg5k3X3Ksd+1s48fYN9Q3xMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238872; c=relaxed/simple;
	bh=CxnJ+cLDrs1GWdACj/sh5n+0ega05QWaoQOM1Z7fzaI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j4exlGJrjJpBtdSaC4yisOkYRixu+UZNzNDpGumC0d2JjZt7r75GuJ+k6MUUdfldTDJ+t/7oq58b389hDYl7uWuy1KzawF8GPHoHYdbDORq666rHE2mtLE6hIoxOL6PIYM97ujCcKZtr1g0BB2kQoXdi5UW7kN6RToFN4mWygwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RmXkZKyJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220bfdfb3f4so70238295ad.2
        for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740238868; x=1740843668; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF/1GgURP63gEPCw/gqMqwGGh9udgVEoAQeBeUkEpl8=;
        b=RmXkZKyJsRRQNEIKttXDIw4ZwY0ze/438adNjZSgHTMQyieG3Ejuh2F8wiPVxAPhZg
         2UwrZPqRYZw8JKHZUd4PhQOE380hQ5wrB8qyLAtTfcDLOF+h+LXUu71uq/wqri64Wpuk
         h0WgZT7V3D0r5mFoPFTYCjefSjSuRmwGF9DU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740238868; x=1740843668;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sF/1GgURP63gEPCw/gqMqwGGh9udgVEoAQeBeUkEpl8=;
        b=jfEmpLpElMQ+XX8ZpFhGnOsVQkNoby2nyIZbCJGg9V3aTzs7U93GXtL2n2blzJ9sQo
         r5GhB8ZwDtHmSh00/b11rOVw90qjzt3FER1ETn++hWAEAh/ZnebTl3AfO9HDud1YOrDU
         6bBSDW+Z8l+YXF5wXH/66ZMr/YX+gCkfCNBHEkTLVVDIojle2qy0CX7juiurt5BhXSfZ
         u1I+aRe92N7COsz4KzhA+u0+CsgXt6FuPDaOxpjc6NZyiWBt5tUwMwcxwBcSFPMtNWWn
         XCd+RrxZgK9U1cGXnh2yqpXFN6zZz2k+hTRg5sHu8dIexHcQPDNVnBD/7Id/pUOgjYog
         PoYg==
X-Gm-Message-State: AOJu0Yy64XFUUeKKXA7XBoL02HQCvyj/ZYPXAOrx6nYbCshQDQu+1nU5
	ZgbwaYrVsnB0pEApNUBDnE/yADZZbPx+OIPNKX2dtJDsvioXtMxdDNW3ke/03Q==
X-Gm-Gg: ASbGncs8KIFNcwAxIm0grKVBRPUXu9dfepfUNSe5LP+Yic5rqILH0+TcmS18kllX/zN
	4HXQGzo0GXKMXeUOr5mbOt5vn2+Zz4I+ioI3HIXkjlyxdIx6kJTVspYrUh4ffirPEuviWSNowZT
	+FVsl7lpvGys3wCVOH1844/mHGkWWsKl/ek5NEJ7CzspGfE+DHEWAdBL4egIF6LpwtLUuJXOP1S
	zVPqUfLG8qtWnTE3XSqD1LlryudOnXblRWatyT5Cog4jFb7LXX1vUjHwFw8cDEyHUxS2NuZyA0y
	UYxlqSxFCb9Qf8Oreehle7+dFAwVzd82Er0zi+pJFbqXm9647eS9UG6ilioa/tU/H3RgGZDxGPO
	W6cbrlA==
X-Google-Smtp-Source: AGHT+IGDpeSEEtT7mfcqtsOU5yefyBhMVdmKytaGWTqDGk35NZrYUWgoAg1Z65BQpIFYI3gEvVuk5g==
X-Received: by 2002:a05:6a00:c92:b0:732:1840:8382 with SMTP id d2e1a72fcca58-73426ae9b30mr9960144b3a.0.1740238868145;
        Sat, 22 Feb 2025 07:41:08 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7340751558dsm6723327b3a.162.2025.02.22.07.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Feb 2025 07:41:07 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re : Fix the page details for the srq created by Kernel consumers
Date: Sat, 22 Feb 2025 07:20:21 -0800
Message-Id: <1740237621-29291-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

While using nvme target with use_srq on, below kernel panic is noticed.

[  549.698111] bnxt_en 0000:41:00.0 enp65s0np0: FEC autoneg off encoding: Clause 91 RS(544,514)
[  566.393619] Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
..
[  566.393799]  <TASK>
[  566.393807]  ? __die_body+0x1a/0x60
[  566.393823]  ? die+0x38/0x60
[  566.393835]  ? do_trap+0xe4/0x110
[  566.393847]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
[  566.393867]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
[  566.393881]  ? do_error_trap+0x7c/0x120
[  566.393890]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
[  566.393911]  ? exc_divide_error+0x34/0x50
[  566.393923]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
[  566.393939]  ? asm_exc_divide_error+0x16/0x20
[  566.393966]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
[  566.393997]  bnxt_qplib_create_srq+0xc9/0x340 [bnxt_re]
[  566.394040]  bnxt_re_create_srq+0x335/0x3b0 [bnxt_re]
[  566.394057]  ? srso_return_thunk+0x5/0x5f
[  566.394068]  ? __init_swait_queue_head+0x4a/0x60
[  566.394090]  ib_create_srq_user+0xa7/0x150 [ib_core]
[  566.394147]  nvmet_rdma_queue_connect+0x7d0/0xbe0 [nvmet_rdma]
[  566.394174]  ? lock_release+0x22c/0x3f0
[  566.394187]  ? srso_return_thunk+0x5/0x5f

Page size and shift info is set only for the user space SRQs.
Set page size and page shift for kernel space SRQs also.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2de101d..6f5db32 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1870,6 +1870,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
 	srq->qplib_srq.eventq_hw_ring_id = rdev->nqr->nq[0].ring_id;
+	srq->qplib_srq.sg_info.pgsize = PAGE_SIZE;
+	srq->qplib_srq.sg_info.pgshft = PAGE_SHIFT;
 	nq = &rdev->nqr->nq[0];
 
 	if (udata) {
-- 
2.5.5



Return-Path: <linux-rdma+bounces-905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9C849210
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 01:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74281C218F4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 00:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FB385;
	Mon,  5 Feb 2024 00:42:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FA7F
	for <linux-rdma@vger.kernel.org>; Mon,  5 Feb 2024 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707093751; cv=none; b=jNnXH40lt/kFXa2MfTJMVBBNYv28IsCtE6gJaTGf5CRtZp1WY3ZM0yyDbj5M1dWWwFTGiflv4oHyMcCLoiORPl2DyQWzRA122owPoe7L0hPf/QaAks+KvksZmy6DqDrBc7lOjMjjdmwsTSuVkcRYHsU9P86QSsdGVrH7Nugyhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707093751; c=relaxed/simple;
	bh=chf3sQNSwCz+fgdfIYhrhoWeEHd9NLimGM3H7x75LGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mtti+yNyjbxgU8I7PXoaNX0f0DyPM/ysg4miqdJA9I8Pk02DRj3yZvxThaqN3i2A3+FL09Mk+jOMhZc3j6f5alU/G0TGLves7uAl5ZvdCOC6UQ78Pd9HW93s5f1smzoBOAU+GM0+S6BIbHUQijzvOOy+70KWhrz/tRlOA/df9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e04aac6754so52844b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 04 Feb 2024 16:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707093749; x=1707698549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cn8NNTFDV0xsEwojdOk6BghQ0XsaSk5xBGg/q7crqzI=;
        b=UlaGVlclb3vbWmufjPhwRvioo6zCA/groreJ+fxrZ0ZnqWJnmy+eamxUeSLQf2/JSs
         dMLcoBF46ceNJSrjNui4zNNknusdCiMvPEQ2qb6hEpnZbCRUPg55udldKNqg3uQLAeiZ
         o2Q18d3Ihx9eQSax80tUT60MH4VfEaBKuQCiOHfMafH3pJeUdLHzd9BW2VG3I+WYuIL1
         HDAk6ls26ny6TIQ25dLbuogR7P+S5vajkRnIeyg7qS8T+ZI/K2fgdgJnFgVgY27lrc1A
         en+uqxnuquVNZb0y5Otsq+Z9PCy16ZWWKQlci7RToXQ5+cXUWMr9ck9/dBa9JK6CLU6i
         1K1g==
X-Gm-Message-State: AOJu0YzZOwaZ92soarjWm6Whz7wRZhw4Z06CJUT1FyFWs7El6y8AuTS5
	ufdXdNuNK8qiPuqJkZZ7ufBMS9R01knytThTs7vhrw5UfWOc26ce
X-Google-Smtp-Source: AGHT+IEwxccfZJIv5RXt5u9JDrR9lZVQ8Os1AvnoiQzWrCav8kKACbgmhOACtkH3NYB8wEE+R3IX9Q==
X-Received: by 2002:a05:6a20:9595:b0:19c:5e3f:1cd8 with SMTP id iu21-20020a056a20959500b0019c5e3f1cd8mr13899895pzb.44.1707093748815;
        Sun, 04 Feb 2024 16:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX34HSSF8kOBkVZht/9v4BnBfDr3ioucZ/i7uxLbfxOqegUfTwqu3grPIYwz4QBR7IX5VDIeyjiJ5uF5pAbd41LDYXxUzTYeR8ZNrMsh+pG2HM7TNnEcmnpoKrIR0ZMtzMiVmbCXIPWTPk=
Received: from asus.hsd1.ca.comcast.net ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a001a8700b006ddb83e5e47sm5451916pfv.90.2024.02.04.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 16:42:28 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	LiHonggang <honggangli@163.com>
Subject: [PATCH] RDMA/srpt: Support specifying the srpt_service_guid parameter
Date: Sun,  4 Feb 2024 16:42:07 -0800
Message-ID: <20240205004207.17031-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make loading ib_srpt with this parameter set work. The current behavior
is that setting that parameter while loading the ib_srpt kernel module
triggers the following kernel crash:

BUG: kernel NULL pointer dereference, address: 0000000000000000
Call Trace:
 <TASK>
 parse_one+0x18c/0x1d0
 parse_args+0xe1/0x230
 load_module+0x8de/0xa60
 init_module_from_file+0x8b/0xd0
 idempotent_init_module+0x181/0x240
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x5f/0xe0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Cc: LiHonggang <honggangli@163.com>
Reported-by: LiHonggang <honggangli@163.com>
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 58f70cfec45a..d2dce6ce30a9 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -79,12 +79,16 @@ module_param(srpt_srq_size, int, 0444);
 MODULE_PARM_DESC(srpt_srq_size,
 		 "Shared receive queue (SRQ) size.");
 
+static int srpt_set_u64_x(const char *buffer, const struct kernel_param *kp)
+{
+	return kstrtou64(buffer, 16, (u64 *)kp->arg);
+}
 static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
 {
 	return sprintf(buffer, "0x%016llx\n", *(u64 *)kp->arg);
 }
-module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
-		  0444);
+module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
+		  &srpt_service_guid, 0444);
 MODULE_PARM_DESC(srpt_service_guid,
 		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
 


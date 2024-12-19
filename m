Return-Path: <linux-rdma+bounces-6638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236A9F73AB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 05:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93DF18922D6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 04:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8088146596;
	Thu, 19 Dec 2024 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcdQFnRa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3943C0C;
	Thu, 19 Dec 2024 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582034; cv=none; b=Lrv0dpx2qHyYrUGfJad82kPs9EmCfNg/9q2wjkvyrxt97C2MWDjNsnYCvVRsrXgG5+dhzlEQxqACn3L51UoEoRHMftIKR+RXMdWZRnJk83kAJWbXP6HULbM9egUpkGbo+ZMTWpKvS1NSWm8UALPaQnObXkPWOkIPw8dvKYT5JHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582034; c=relaxed/simple;
	bh=V09QXvPUPmklUv5m1KiGgmiQZ8bVv0QaN+6xOG1gG/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o8GnOIu2I0VFTS8T45el19Blv+pJ9DSVGqtM/PJXGNgkqOFUi8rtAui+dG+VaXJ7jb6YVv+ga+vC9o9DywJIppU0Ca9KCuMdvBDC4BhamHY2iZtrsf8g9e84L/c4SnFFMT+okVqt5RUJQkDBnisr0+OkbHRHm8+nWmtSr0ce8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcdQFnRa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so4083245ad.2;
        Wed, 18 Dec 2024 20:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734582032; x=1735186832; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2H4hhEIYPdCA+poXvRGuwqAnuhjq2eKyvRcpMGHs8o=;
        b=GcdQFnRaexeRlfleWtZ+y3B35dKrFn2uClWx1FBLMaD7RLTnAP+o6vzWS3o+x0B9aY
         Hxb4vjhp8UOPiwQjLpAzlt8fiP25itlMJLpiPRBa6eZTGRUAU2ryjlh28ngPVXrFkEjr
         oqmQCQpuMJUkB6e/Q9LszYLsQL1ZhEaYrOD6ykEatqAWQwQTrYzn155tdmYxJjJr0aR0
         P3e9Tp0F8eax1s+C2AbuN0Oifu/V1DN7CpQgEqo3pf3FuZt2bDiDD5PTmDxIVLGqAty7
         iQVLMl1nkUrSpYBy1NN1N6gdSqzrgYxqUqUZwjvJ8fXbtJeaE3NVjL52IcyfOO3NPOtb
         gLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734582032; x=1735186832;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2H4hhEIYPdCA+poXvRGuwqAnuhjq2eKyvRcpMGHs8o=;
        b=SQaMXX8SC2h+09mcPvlH1ZVOgHEW7d4MkA/wz+OKAlSi6CnYuVb1beNH0wuvtXXuzC
         mDGlNLH0enJ6l40NdUA8QHV+/lG+xCBkVJvjOgZoSUSNRjFayDpgnD0FZhfYKEIrsROH
         xpNcuHmEza5hvM1BAtXHROIZ5QPzj8e1K39ypLl6YdY7lWbfJj5VWeEzdvDN7a1shk6V
         4WXqn1WNdGCA0Nkd8MNr0bKl34c68DGoWqIVFeLgpww6cNMM5wYIt7ENzj2QG6v4sTfG
         fU1/3iWa5uRtzYoeVCGc1JJdku4KWN3GEP9ayE6B69S18J2+/Aj0GjytTpB/GDfdhlCN
         9Wog==
X-Forwarded-Encrypted: i=1; AJvYcCX9HMkU/o+tFuwG33vvMra7t4qVJeLai8yQ8KaXpb8vg1GK2/DxPEv3Mit7IDkgJ1S8fzeNmLE391z/h88=@vger.kernel.org, AJvYcCXNkQST6esxp1U0fvkJ6Klg/MSazFcnIrpGSWfp1LJ5TLJuhUw+5n2rMPteJrKFOTUly6HtjJ4Nn0njdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2uZDaLKDq5x0hjGGDHawfeRSnWwrsWqLF0l6IDmXQMtWvi4w
	3Iqg1BCx+qzqd4pv22rzB7OBoH4MaGEk/YHMqFvo7dnMK1SWPC8gwnvQWYtJ
X-Gm-Gg: ASbGncvuJcQUWu1+J/XLDv7LWIZhvHWOMxNQmLlPy3a109DVirPAI2pIj2+sG3ohbcJ
	rLTsV+pIOM2rAaMLPwTK0/AzwRqfE6+Q3b43EQ6giis7DGwRlSBu0Dk2Ph7O6ml101chG1F/4LP
	Btu11LP2FJ0shcP3CM2Y4dMSPCLpMF4pd0occWS9BtupP6Ae0URgowWyjYCFMp4cFnhOhYHWXMZ
	V3RcLeGvzuInT+WyBPrefdK0kPOlV7lshEYBsOEZzirgvq861No4Z8j3qryUA==
X-Google-Smtp-Source: AGHT+IEPdBEJxlBp8bfwI03XTsGKypc95vUCFcUbwk/iGRMQ2z0eEOvdOSDnNBA17x7zJVVaxazGuw==
X-Received: by 2002:a17:902:cec3:b0:212:55c0:7e80 with SMTP id d9443c01a7336-219d9671753mr27563485ad.20.1734582032098;
        Wed, 18 Dec 2024 20:20:32 -0800 (PST)
Received: from HOME-PC ([223.185.132.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d0asm3356005ad.53.2024.12.18.20.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 20:20:31 -0800 (PST)
Date: Thu, 19 Dec 2024 09:50:28 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: chengyou@linux.alibaba.com, kaishen@linux.alibaba.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Clarification on dead code in init_send_sqe_rc Function
Message-ID: <Z2OfDPDPbpclUoaa@HOME-PC>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Maintainers,

While analyzing the init_send_sqe_rc function in the erdma driver, specifically
in the erdma_qp.c file, I noticed a static analysis issue flagged by Coverity
(CID 1602610) regarding a dead code block.

Link to Coverity issue:
https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602610

In the function, the variable op is initialized to ERDMA_OP_SEND as follows:

--> u32 op = ERDMA_OP_SEND;

The conditional block shown below is unreachable because op is never assigned
 the value IB_WR_SEND_WITH_INV after its initialization. The condition will
 always evaluate to false, rendering this block of code dead.

--> } else if (op == IB_WR_SEND_WITH_INV) {
-->     op = ERDMA_OP_SEND_WITH_INV;
-->     sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
--> }

I wanted to ask for clarification regarding the intended behavior:

	1. Should there be an additional condition in wr->opcode to set op to
	   IB_WR_SEND_WITH_INV before this block is checked?
	2. If this block is unnecessary, should it be removed to clean up the
	   code?

If the logic requires changes, I would be happy to submit a patch to address
this issue. Please let me know your thoughts on how best to proceed.

Thank you for your time.

-Dheeraj


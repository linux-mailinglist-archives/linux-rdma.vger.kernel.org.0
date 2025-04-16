Return-Path: <linux-rdma+bounces-9475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E7A8B52F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F633BFB93
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823C2356B6;
	Wed, 16 Apr 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaF1NERu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EF2356C1;
	Wed, 16 Apr 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795375; cv=none; b=nLzp7Jmc4uIdmd1kkt2Sz8OBaP1sNWh0NEAapV05n1b+Dr7X8DRloJqP6FSPXVRD6LRQ00slCa7T4PLGqjm0/w+Dd48U94mKqHPWITfOB/KSmXlTj9muKO7APUJgn1Gq/w0R8/jMSVvhg65iUzYqfH8hxzd6Y4eNqzdBJqsp9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795375; c=relaxed/simple;
	bh=w5RzLksqRnl5QxaAsPgtygvTlr1+V8VM+ufHZCm77QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iajqmhTdcOV5UeBqU2VvW6a/lNnoU9AUlGsNELuNO/z8uoiwGdfSxoP9lu17V9TqKnR5AR2/HULRXKCjnP9IXbqFkyt4TGpZaOEoVaTny1urnICr0S8nZqvGqRBuf755EP7lVTdUN3qms9d2UgUH1Hx6zlFdlqBbNcJ9dUupQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaF1NERu; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22c33677183so4526715ad.2;
        Wed, 16 Apr 2025 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744795373; x=1745400173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gc9ETUlXAwHL9WYHin7FZ0e7X2RQp7jZ6Z40mw+LncY=;
        b=jaF1NERu28nQjamxAt3pkKLMpPR6znH6AmyTtfnmd1pzjzyZvC9HZzjQCQ7pOmHa+q
         /l1A/SH4a6xSrc1374Dq595UaVLCf6JorBudKnJFoUi2gPGk7SYwAhlnIos/LXi819rM
         Z4VPlGSabX5z4idmDUnU8qn3P+u82UvnnfLGf4saO+Ui1LOOx8MNZ/0EEUMxU0y2gLBN
         nOP5ah9D/TEHOA+W1RHzCuLBr52eqYfvuqg6vCY8DgUyBzmQ17rFEIvQ1o8YibuuaXyy
         bGTPfto9ZoPcYIf9W2MX7uaUYCqF+bfEaQ3eBHoKuI34A35xp23Ak9KfMIog+ElTMhiu
         Uhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795373; x=1745400173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc9ETUlXAwHL9WYHin7FZ0e7X2RQp7jZ6Z40mw+LncY=;
        b=wGJ7Cqn0PQYWwmd87v/Ss4bv3g+i5eJTxW+enCy8oLtJc+4R7S3GCkgrNZQzdegQpT
         IDQiK7kcJicqop/CLS+s1fpovq+mRc6JKe3FOcorg9QpmHRPgmqL65dRWEiXlSyaFQJZ
         hZJ0SdJYl/ScvSgiEoBq/w0OaWvw4nxdocA0qLDtKvjFceR05tm+qjda5e2Di2xC2JiL
         rc81Va5vJb7vQakPS2TlwmO8iZ65+6m2rdE/L00dBw4/P3zcTqyxwDQ7YH6ixBPod50h
         YeD16iLAnQOG8MIq7a3Q2vuGTPdcVjH9gCDY+yWVtZYIocTPaD5YGDyNcs0ZsNTY8xxj
         yI4A==
X-Forwarded-Encrypted: i=1; AJvYcCUC9g3v9iHdGcykwYB87lFaBa73uE7fftu3hkXUyFekaZTHE0zDrTLIazFndO5N6qROEbkVG1B5AmQ08A==@vger.kernel.org, AJvYcCX1QBhwaXnFaazSjq/T4JYwb2y6k4hab8ZEW9gZbJgAh4eTWqp2phe+dfXkqaGJSsFS5ZVGFBHucq9cy4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEP3q6RGT88fnpyLgtWS8qR8XsTS9s8UDMxJZGV6fL2OIGOZt
	Wzoofr4/fLCbdMt4AUp5lM0FH9aH2YsV2BarajRv+RNnQfRvRCNe
X-Gm-Gg: ASbGncudcZQJ/IXkKpeAy1guTTSVKdXWSa66Sgslx34/e+Z5/WcaeIYAioPtl8jGxer
	Gaza2G43mbzw58DZWDnXyVcgzud+UTedf9HdfeD6NFtGEHq1ke5W9iRTSvS5UBTcWYQB1jIFpsM
	4ir4vRH2SMIapArwJj1GBYW1LtNhQZNnGYmolthNRVrMPlGTOQ5AAi/YLEMZ/pYR9TKYtSIug7o
	V/aOJ4L1DtcpU4GY6TUbqjJ0PAPHbP+Qqp1rlG3jlVNj+ryLK/ZCuf2w25GIY5DdeqIN4HyZvgz
	4r83vYhstB2iLMIu4sXDRDDRJURpkqiCEIe6OBUsnLS706nUS5PYKiSgQKLy0n8zQA==
X-Google-Smtp-Source: AGHT+IFqOfykxp4sHmxIpixGdEbhneviQ6R42REOZioYQx7ZqXCFBphO3q/lZ9BkZbR1mmD5mq6zkA==
X-Received: by 2002:a17:903:3c65:b0:224:255b:c932 with SMTP id d9443c01a7336-22c358c3f5emr19732055ad.3.1744795373339;
        Wed, 16 Apr 2025 02:22:53 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d070sm9369515ad.79.2025.04.16.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:22:52 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bsdhenrymartin@gmail.com,
	mbloch@nvidia.com,
	michal.swiatkowski@linux.intel.com,
	amirtz@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] net/mlx5: Fix NULL dereference and memory leak in ttc_table creation
Date: Wed, 16 Apr 2025 17:22:41 +0800
Message-Id: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues in the
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() functions:

1. A potential NULL pointer dereference if mlx5_get_flow_namespace()
returns NULL.

2. A memory leak in the error path when ttc_type is invalid (default:
switch case).

Henry Martin (2):
  net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
  net/mlx5: Move ttc allocation after switch case to prevent leaks

 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.34.1



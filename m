Return-Path: <linux-rdma+bounces-15364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08245D021F4
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 11:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CCB83001FF8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144B2E0910;
	Thu,  8 Jan 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cyMp/Otu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0632F74D
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868012; cv=none; b=j4IRLisDG3e//+dJOtehx/LOMgfBAg2Va2belfT/N1BNTdNK85ln76/LnM/cQFIZe8MQviT0KWi7PgSfI+rN8pdo9FD/yBG3G1jJJpi7LVADy3lRJBYsr3OcG/ZpDhvgBwbCBF719XOJNMEyz0cKtizLtD7OYvc+nKJ4akg4muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868012; c=relaxed/simple;
	bh=yDM0MYcN44C4fZWfKAiNXGBUoTkQhc/bAsbUtdLeolo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rTZok/6ggFEp/wQZ+HPE4hIcl7M9/MDp8O4ojndZpDkyzh/DHSt81qGxpWjHnncmXhv5D8yJf+Vy0wqFUn9S8nVHKCC36UKhA20DZvVSWIwVRQXSgCdqpSX3ljfWuEvpMgS9gWQlkSd5vll4m9tuvqjLGJ3teDEaw6T8sXeemcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cyMp/Otu; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-11b992954d4so2727842c88.1
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868002; x=1768472802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FCB3AHMmrGnbZZnftF4zn0nkPwbHqYdVOpZ4CrAVgE=;
        b=Y9MKRCbHVzW7wJ9mjyUxFO11qsNwXD6OOD+PjzshMS5j6ARLmzGInm5rv/GHBMj/pw
         vh0vKnw7eY40cbCCZQxDgznADdPGS4r01UDewPiHchwqeXxihs2nOAnrraLNOXNIgmdl
         I9y8qC04ffISRyKz5xF0iU+xwQgbdQ8O5GYAeSeXwO33qIN1CxOHTiNsoGrA2eWV3nvv
         syvXPUJkhd4iq3Z69UiyYi8v1mFNAvKK97YJC2PvQctt2Za5RewKRIm4j3OUYqiZH1L2
         aaqtzVEL09UtdFhfXn+l9/dZBgrEk+Zunn90nCnCwQWqf/VQFmOzkF26+/xnZ39mJK+8
         XaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKPaujgSuyLQDSUXd42kOc/9dnMo2nZ+Th9r0qkRVOw1dJTAmPgDuI51Uv7wb8HlaaBsPJluUb1Bo2@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZnpRJxo4JOLuY3Mr0ZV5ocBC7769si0iYlnrrFnjQ1pKGLqz
	2aoFQPoEOmcpyLU5YV0EUBgzlQ4cXYT8gsD+Z3ReHbrccubDw7BZv4WFLec0wAUYEmNYIbaVy8u
	4b/rwauEdIeg1HuVXUiJtB8YLbj0awP6wuvhIwHxHIv5WuSGFTvwlw4Vv138o0eOaX7XSyU37Yu
	Cp19yVs5zG4GyIE9Ipi3CqZeP7Fjq8ms+dAWCy96iwrV4p6appw/Q7l4+cbJpDInfWEcItutgtz
	hWXllt/LWA85k84lZmrcc8=
X-Gm-Gg: AY/fxX7M2d44wW7x5KP2xitkDeeIhn/cFt5fKxftAgQI6pFhghCIbb9+VwwdQt+HTe+
	+0uJyxi9+i9TS/GikC9ltrLDDoUs1jcSLHjE/wvcxsYpseECLP0iEWLPepYtFmcDxL0xdMFUfyA
	RdXOXCRHBE9pZAuT8sPvRWdAxHEclfm5oJd8jB+L+10xio+EQxS4gMiq997bZmNCrOBJytQ1+u+
	cuEAOGmOBivOsl1oHs5NMbF3iUksa2J0ItCOXuyCWCgJG7M/7wrcmHUF2cKgiSqAMCaP8g/AIXb
	FPhsNLEysgwjztDOqmYFVLzeNeEVgbQjOsN/WXy/Qtlbwi4PMUDsY3x12qh4ergAoJX1EfVHcS+
	bJcoA4E8XQ4ybFCZW51twr7iSbOo6N/bUU+IomZju3EVWem4Mv3Jk1I+fbnEtrXVu6jm0P/lAw6
	6mPz6+5cFHoIEQ463QNTq2Oin4wmYE0wBPM3+Lzwm6exOtig==
X-Google-Smtp-Source: AGHT+IGT63UPaMH1fkURACRQ1cZ5axD8FN4pN/iKuvq4dzke/qMF9umQbQ0e5H0EXMgHdxUd4Csfj8Am5ExL
X-Received: by 2002:a05:7022:30b:b0:122:2f4:b251 with SMTP id a92af1059eb24-12202f4b39amr157579c88.21.1767868001828;
        Thu, 08 Jan 2026 02:26:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f243ae71sm1736976c88.1.2026.01.08.02.26.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:26:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed79dd4a47so66750731cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767868000; x=1768472800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FCB3AHMmrGnbZZnftF4zn0nkPwbHqYdVOpZ4CrAVgE=;
        b=cyMp/OtulndFMvU9ZlD0fK3gp7IiRt2rH3FIwMwx3c6Y6cYF1MXro2Z3sFJXDOHWHD
         qjmTPmW3p1op70NtZ9Fy/ylW4tNKDMzRtIit5YQsfU8LuiLz08BxmbnjpJR7yojTG+dK
         kdd9FET5mKP8087fuImC12zPL89zBJwCXlJV0=
X-Forwarded-Encrypted: i=1; AJvYcCVv/720cF0JRQEsvOzHKrJybZbAkn8JOUOaEZy1n2s7v4Dy57R4lFFbR+npGPuVIDIOytz+qbC3KrMF@vger.kernel.org
X-Received: by 2002:ac8:58d3:0:b0:4f1:ca48:cd3 with SMTP id d75a77b69052e-4ffb4ae8c91mr75598691cf.80.1767868000503;
        Thu, 08 Jan 2026 02:26:40 -0800 (PST)
X-Received: by 2002:ac8:58d3:0:b0:4f1:ca48:cd3 with SMTP id d75a77b69052e-4ffb4ae8c91mr75598451cf.80.1767868000105;
        Thu, 08 Jan 2026 02:26:40 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e362fdsm45124721cf.21.2026.01.08.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:39 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	mbloch@nvidia.com,
	parav@nvidia.com,
	mrgolin@amazon.com,
	roman.gushchin@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	zhao.xichao@vivo.com,
	haggaie@mellanox.com,
	monis@mellanox.com,
	dledford@redhat.com,
	amirv@mellanox.com,
	kamalh@mellanox.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v6.6] Fix CVE-2024-57795
Date: Thu,  8 Jan 2026 02:05:38 -0800
Message-Id: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2024-57795, commit 8ce2eb9dfac8 is required; however,
it depends on commit 2ac5415022d1. Therefore, both patches have
been backported to v6.6.

Zhu Yanjun (2):
  RDMA/rxe: Remove the direct link to net_device
  RDMA/rxe: Fix the failure of ibv_query_device() and
    ibv_query_device_ex() tests

 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/sw/rxe/rxe.c       | 22 ++++++++++++----------
 drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 22 ++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_net.c   | 25 ++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++++---
 include/rdma/ib_verbs.h               |  2 ++
 8 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.43.7



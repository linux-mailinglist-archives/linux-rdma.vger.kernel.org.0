Return-Path: <linux-rdma+bounces-4360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38D951609
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD31C212E7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6888213AA3F;
	Wed, 14 Aug 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NvOPi3C1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EF4D8B8
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622580; cv=none; b=JC0fTDmmpOkInsA/8vOBbS/xznyUn7k93JxD0NbSs+ukFTwsJLtMRsAWcda09pV6P3rIGtxZYqCdqDweeF1+8J8K8cH2dxL6HGel7V6w6IZs9uMeyMre2wtdjg1pWKVMluY+l3FIGWGC/A28QWMGBZqAG9VPeaVz1r9s3bLTQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622580; c=relaxed/simple;
	bh=ngU8+9mOa3fXCg2JZ9IGPOa4WZElReWFz1L7oZb+mLw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=buqrbVav6U1zDLQNQwHi9TAiG9CPs+D7LErF38Liz0xWzD8QdNhuC+n7f8rdsPaK4PvFHsmq7Pf4B/ZlIGSk9PZv56BTKxYbFEw0aOLe+CWWQmEUAdKo8GnKM0x0zp2tZFhSu/Pe/z6wXc0HxPuwV5diVFLTLIAXHD45qMCs9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NvOPi3C1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d28023accso5092239b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723622578; x=1724227378; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOr17eOUAukT4ZNV4oRUTa8xjCw7HnYh6wkbvJ/pb8E=;
        b=NvOPi3C1pkhRY8/KT+qIYS3mRVv8jy6wipk1i1qZCDkeLtkSjYNIDmQqNj5kIEM4wz
         bZ3HgJ1+FHqAGPwG9O52ZuzRQFJo+u7oMGw45YthgOjhtwC5vUkg3zxeNXTodA3n56uy
         kJ3NnpZS7yEaeytlfPGwn+/CAURau8xAH2N0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622578; x=1724227378;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOr17eOUAukT4ZNV4oRUTa8xjCw7HnYh6wkbvJ/pb8E=;
        b=FC5OsRS3jPPwp//0pPtwoIkXdCte4QNiYKtu610GPr8F9ZQLkEP1jELaZ955xCDYPo
         4auySugBIj+4d26B0aWi5P0Tk3BI7DS4Z2Z/GDELxVMy0K1V1cXXuUnkYN//8wMlapkK
         G8j9CdTOBznuLuvi5FYlg3nyC3p0A/r66neiD4YHSPRpL3fBgieLftp/cZqsmLJtNfdT
         ood00YFHCuvDxBHI2lzxUbDg1bhvMXeSuH2t9fVxv/nIW8aHLghaC6HHWZ/o2QMuOxRP
         qZO3XM0C4NJln3lp3rcV4jLa0TG3N3m53m3yIhPw5YTTrH4eD6QEcOpTxaJ3IZnPe1oj
         1CCw==
X-Gm-Message-State: AOJu0YznO+gKUVTKamUjM9Q7bN7GfznbpZcCEvv/V2MzlwDIZXL31SEn
	FqxMj22xH73L9GkELp8UokgxPdh52gf8fJCbgJYkFPAJlgD9RvVrxJ/TCbzB5+Sqdt0k4w6gIBk
	=
X-Google-Smtp-Source: AGHT+IGKcQFhsUeIxp6waTUVrkhRWyd/l35+wuknoZzd+VY8jXCpXJnX5RKf1sHb1jkF8dlPZ+9KrQ==
X-Received: by 2002:a05:6a00:21c9:b0:706:6bdc:4de5 with SMTP id d2e1a72fcca58-7126710d9f2mr2518843b3a.7.1723622577589;
        Wed, 14 Aug 2024 01:02:57 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([115.110.236.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac40e0sm6782479b3a.216.2024.08.14.01.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 01:02:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/4] RDMA/bnxt_re: Use variable size Work Queue entry for Gen P7 adapters
Date: Wed, 14 Aug 2024 00:41:58 -0700
Message-Id: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Enable the Variable size Work Queue entry support for Gen P7 adapters. This would
help in the better utilization of the queue memory and pci bandwidth due to the
smaller send queue Work entries.

Please review and apply.

Thanks,
Selvin Xavier

v1 -> v2:
  Fixing the mail id of the signed-off in the commit message.
  No other functional changes


Selvin Xavier (4):
  RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
  RDMA/bnxt_re: Get the WQE index from slot index while completing the
    WQEs
  RDMA/bnxt_re: Handle variable WQE support for user applications
  RDMA/bnxt_re: Enable variable size WQEs for user space applications

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 119 +++++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  16 ++++-
 drivers/infiniband/hw/bnxt_re/main.c     |  21 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  58 ++++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  24 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |   7 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   6 ++
 include/uapi/rdma/bnxt_re-abi.h          |   7 ++
 8 files changed, 186 insertions(+), 72 deletions(-)

-- 
2.5.5



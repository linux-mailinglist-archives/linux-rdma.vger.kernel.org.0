Return-Path: <linux-rdma+bounces-6418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E49EC3DC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E51887FEF
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5E1BC07B;
	Wed, 11 Dec 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UEueqjAZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C82451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890007; cv=none; b=COFsqwMS9GRxFXDItY5Iv1VVcfvcul1owj0TCxykO8ghO3RRG0cLYQmuHx9cvVNc4RWh7La0VjN/2s9+/1VTEnHnQev8hnz85YXucvWdmfA17v2I1BP/y6Ij8XntJb30Jd6SRJdHEC+ch7PgoVHVDAJpNpuIxG5QGB/++S6IvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890007; c=relaxed/simple;
	bh=/AbQhHAGXip2gWIvELB44f0eovrmLpNX4tbXGQvqq8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ooA9ZvNsmWbCyItvEV+hs7ussWTK/dsnsyGohrB2LL9HzUyZSv9UA2P9Ecq1wRVFHwnWVyUp6PuO7VlpboZSBYSLQsEUMViboERni8c//v1kvah6LBvp+DgV8kPWRQPsSS3KE0en/hmP/bFcWdc7/JIsR8Ik2mqrOdsoIIbMNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UEueqjAZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso4545436a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733890006; x=1734494806; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHO8WIMPG+IkKbx5GL/jKU/mNV7T0FGxXoSv7ZHnF1I=;
        b=UEueqjAZc1F2lXcbDvxzPQknTrMibRaVLMF1+MuZBN0jsAhxIwgOCFb+IUstuNeVW/
         WmYiq6JxCFyz6dZMPXWhkgiQ2l0BC3hPLqgWl3TLaQ4XxXF7enx7z1PLcJ5LCJ7CZUgs
         NdMFjCg7g7/5gWpFWL+9lqf1+eY417ggSAQgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733890006; x=1734494806;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHO8WIMPG+IkKbx5GL/jKU/mNV7T0FGxXoSv7ZHnF1I=;
        b=AslNXmUG/yplxorRMf9dEle9ZqhEJIAcVl4RURSo7KgMmsLgILA6V+CBXUxDdDJaAH
         1hVpnx6AIQyxpCjjWbVWcra2eTgz6eAixl9c4kDrET2OYumG76uCZZyuNednWejqxMoV
         1LLs08Qp3sOY+hQo+HppGeAn+Q7vJUjNyRXqRc8TE+zgzutfexOXZh5f250bH4XMTKIV
         CwtUocomlU6Mmb8xpOUxToY3IDcop5SVVzGlRji9aU5fG7RzM/nLIl2iEW/WUWkpEc0H
         dcWZmNThlq6tXtBS0/X9H4wmRJTYgId573FMFKm56K+/+FoWPiH+bjd/SGHVhliQbTI2
         GyAg==
X-Gm-Message-State: AOJu0YxpnZs8CFLA/TwP3aLDUPwWGQOAZJAkWDBkrrHtkxg/JTHnA/l4
	K4UZt4dA9mJ0e1wctdUj2rCK6sAHvD+YKEZ8f4FJjhgrRF9TX4xCwsxUcmGK+BWUbJJKj17PTJX
	zNg==
X-Gm-Gg: ASbGncur/t5wIJA/vQQekzdbPhJdImHC2Qmb3ICelhLgo1udIXyI2UcQUdQNFcym3GD
	QPT20Qbl2mDAxftipZC3E7lIPXGOVn9Os472TLQLfwCHL8hiq0zyIxkkC4f5RQDdWAdj8JRVcdd
	F2wPzXjNgArp7ERIqS04DCJl74IywShl1XGvUtlzb8YCr6NINKSgWNzyI8QzzBnflRVtr0PO/Ze
	ukSnG0WMC4rBChPEq2q/fV3E2P/fY4/5ZVNTEBZ+Hwtj8tHfedPGF80Oasg1/jPkMtfBdVucND5
	r8dqCg28nxNbHa4LRYtg3HeEZn7eONF2yg==
X-Google-Smtp-Source: AGHT+IGzmkoDc4bKDf7QSZDpa+zmlAgFSJh4jOWaZm5yieRoyO+8exmSD4fPaO73JDFK6WwYZTj1Kw==
X-Received: by 2002:a17:90b:4d11:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-2f128035362mr1963951a91.28.1733890005869;
        Tue, 10 Dec 2024 20:06:45 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:45 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 5/5] RDMA/bnxt_re: Remove unnecessary header file inclusion
Date: Tue, 10 Dec 2024 19:45:45 -0800
Message-Id: <1733888745-30939-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

There is no need to include bnxt_ulp.h in ib_verbs.c.
Remove it. Also, fixed hw_counters.c to remove unwanted
header file inclusions.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 9 ---------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 1e63f80..77ec2ed 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -37,18 +37,9 @@
  *
  */
 
-#include <linux/interrupt.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/prefetch.h>
-#include <linux/delay.h>
 
-#include <rdma/ib_addr.h>
-
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 8202339..129178b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -52,8 +52,6 @@
 #include <rdma/uverbs_ioctl.h>
 #include <linux/hashtable.h>
 
-#include "bnxt_ulp.h"
-
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
-- 
2.5.5



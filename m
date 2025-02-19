Return-Path: <linux-rdma+bounces-7867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA60A3CBA2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 22:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F93F3B72AF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C062580EE;
	Wed, 19 Feb 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O/X3ZfTS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C12580D3;
	Wed, 19 Feb 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001006; cv=none; b=J5yM33S/WhbwyP7EREIoTvI/4Gc/CLZiSmgWNsWMc7iCNfoPJ7W5BE9JlbjAqvR+SCaEcMmWOCVcdyxrxYXvib1oyOT9eHTaZgX50dMchnS1Vcanf5csDIEGnjXx0oBPkr8c6ZJ56vxnraUT0t017o0a56exUbgEU46wAja0fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001006; c=relaxed/simple;
	bh=eOIIOKhiW1Xu7b9qMPmsnDL7HrgT8rqstOwTWW9wsag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SzJXf1Zdk3qVuYMRG0RZR3d7tvo4zPfGVkR4imi1qeVKQJR3+lU8DvResFPfJK0aSjmoD5rx+LEMutvyM6zqF5foLEScOmvbfvHRJjgt4UfTrAsBZTqYk0cW/qBmmryTw0uYGkk/odQb1Sasav9wHlmerDQKRx09Fll/VwBmhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O/X3ZfTS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 05EE22043DEB;
	Wed, 19 Feb 2025 13:36:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05EE22043DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740001005;
	bh=Yd7cXuhx3A67eG4TqzBUquDu4YnydVpvFJBPeMbis+g=;
	h=From:Subject:Date:To:Cc:From;
	b=O/X3ZfTSBFy3WXcpAdkLH/U0NQDg25LPLP8fXLuami4zHVXonCtT40a7iiMy3z4+3
	 KfExHbnika6Eo+zPkPw34mWtQ34gJqWtemv1yzBBRty4ICZwy23RhAyrBi1Ga02vpM
	 eG4WOsL2tyMdCiC4qvzXSn9q4x/WQWW+ApQTKP+0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 0/2] rdma: Converge on using secs_to_jiffies()
Date: Wed, 19 Feb 2025 21:36:38 +0000
Message-Id: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOZOtmcC/x3MMQqAMAxA0atIZgNtxUGvIg7VJhrBVhoRQby7x
 fEP7z+glIUU+uqBTJeopFjC1hXMq48LoYTS4IxrjbMd5rB7VJoVz4SbMBeNzvLUGTNRwwSFHpl
 Y7n87jO/7AVeXZJpmAAAA
X-Change-ID: 20250219-rdma-secs-to-jiffies-21fb900be3fe
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

This series converts users of msecs_to_jiffies() that either use the
multiply pattern of either of:
- msecs_to_jiffies(N*1000) or
- msecs_to_jiffies(N*MSEC_PER_SEC)

where N is a constant or an expression, to avoid the multiplication.

The conversion is made with Coccinelle with the secs_to_jiffies() script
in scripts/coccinelle/misc. Attention is paid to what the best change
can be rather than restricting to what the tool provides.

This series is based on next-20250219

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
Easwar Hariharan (2):
      RDMA/mlx4: convert timeouts to secs_to_jiffies()
      RDMA/mlx5: convert timeouts to secs_to_jiffies()

 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 drivers/infiniband/hw/mlx5/mr.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250219-rdma-secs-to-jiffies-21fb900be3fe

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>



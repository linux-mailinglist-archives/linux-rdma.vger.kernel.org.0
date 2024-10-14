Return-Path: <linux-rdma+bounces-5396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65899CC08
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC58A281DA8
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FD1AA790;
	Mon, 14 Oct 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M/lX4d1T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297D1A76DE
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914228; cv=none; b=CEWIQPvb5UzMNkqIw2s3O97pL2SOdHjYQ6B9YwuBKKcBrDUtAaoFaBp9BNkHZWg4lZrIfKW/T8J//GDmdYRUwJ5DPTP+bV1URyrenKanVs6PoFk4rMN4qNLts9t6EmRWFNLjKvu8PhDQsi7P6CgT6tpZB6MCTI82vBXCdkVXmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914228; c=relaxed/simple;
	bh=eztfrw0N7Lkc4CcWSsk05JQ/s0AaiF6PceRMSpt9ThM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JGqmOz8KbeMQqCDf+dznjZnoPj5XrxN3Wss1vXWQ5ylt2wLH6hGAex0RCClxDJoOh9Wo1bLBxY4L9cix2r+QlazBytiypqPri1qPRAPNY+B79zFGO6VjgII+f9f1t9c3fLnYEgQ8LBf2MIwiGnYvRR1kWUBBoD/wKh7o+oz7PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M/lX4d1T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso30287795ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728914226; x=1729519026; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AooOOvFG2HMm91J6cvEGxzfwagaRtw8HMA2OdNTInzI=;
        b=M/lX4d1TqxiWlWnubGHIDnLRs7qBwsno+X/ZtKy0l4u0E1GWnnVcb5mPJmWYOOlNy/
         lcIsh0nBBcJguDHw6vR5M21rWuP6O0vchRlGUbnXqTqYrRFZLTBArVekNtj3t+Ft2oNA
         sL/rxCnwj56nR6aYcoxAhYJDjhDiQ1lwnbGMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914226; x=1729519026;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AooOOvFG2HMm91J6cvEGxzfwagaRtw8HMA2OdNTInzI=;
        b=fX8Fn+6ZtW6ptv4o1+A9DpVK2OcZmeBzu1EVhbf9iJ+aGiY1722Hpau9k5Yiu/PKY3
         LhcISrFmdgKokP58eCCQ5wExGxh+wBgI2Oy+QOeonmDNq57E3BYkHtFeZrkaojqBinmk
         t/rko6HZZml+qDxYWgnCnxG47TWmREXBCQhTx2CSWhIRyrTaCzvelhQHBz5sMsY09Vxm
         xdCXT7N3dIPUiLeg3/f9dHnvVKWzxmXY1tLgU7ogvPtM9JE1oas1Hfxu/GTlMP6T9iFv
         P/S+jhQ6CplxqyMMWK9DMVfCINnGreAvE0en9qJTkxzjCjuapYKmQw2fWW7Qz8xaegLp
         9GGA==
X-Gm-Message-State: AOJu0Ywcu7Ppglc8d3Dzq2MLqaGNs9tBqJy92C5Nm/eharaF2tyHVQ00
	aOI6Dsc5uU3KRc9bScPp1QE8ktFFqaBwgLKnDcxKET7Rvj1F9LqaajxuevjeKA==
X-Google-Smtp-Source: AGHT+IEsrTMUtaQnLTMEuRXNLUZBRObsAnZAxbyylR7SdwxqQ6uZPZgwfOVGl6UvmF7pw6apYFofnQ==
X-Received: by 2002:a17:903:22ca:b0:20c:dbff:b9d8 with SMTP id d9443c01a7336-20cdbffc480mr64178765ad.37.1728914226374;
        Mon, 14 Oct 2024 06:57:06 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c35697dsm66129525ad.297.2024.10.14.06.57.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:57:05 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc v3 0/2] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Date: Mon, 14 Oct 2024 06:36:13 -0700
Message-Id: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Hi,
 Posting the v3 series for the 2 patches that was not merged from
 the series. Please review and apply if it is okay to be merged.

Thanks,
Selvin Xavier

v2 - v3:
	- Only the patches that got deferred from the previous posting of
	  this series
	- Addressing Jason's comment to avoid using the lockdep
	  annotation for the new spin_lock, as this is not a nested
	  lock.

v1 - v2:
        - Add a patch that removes irq variant of spinlock and use
          spin_lock_bh as the control path processing happens from
          tasklet context
        - Address the comments from Zhu Yanjun by initializing the
          newly added spin lock.
        - One more fix included in the series

Selvin Xavier (2):
  RDMA/bnxt_re: Fix the usage of control path spin locks
  RDMA/bnxt_re: synchronize the qp-handle table array

 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 38 +++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 3 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.5.5



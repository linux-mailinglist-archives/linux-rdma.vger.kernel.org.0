Return-Path: <linux-rdma+bounces-4297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DF94DE4A
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E991F21790
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6C13B79F;
	Sat, 10 Aug 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ARv78ZXL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4A4644E
	for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318807; cv=none; b=M7u+poPRpQxE3Pnb5qGGN8gP8whIpNk+Vn360ubbQA+P16RbgQjs5QH+4olepgw5TTDK1pjx6eFolVePN/pPu0BUwGFY9KqcArWQjcrFU1Kk+o2/THveb+IFO9QOru2hMwL7cJOS1SWymTTEEU/cGjfUnGvrka9HcE0Amy8p7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318807; c=relaxed/simple;
	bh=hK5HfTQWxJzJjafWM0CQ4622DUf8FekyWgivpOCEijM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ld5Tr8TxDoZYDQj0HrtnLEBBw5NPGvz+j9kIqH0o2h1GzKV/okdbF1FDY2sdLTOS1fOq4HIZOMstqKRCrefAHaXmSVb+TKtlferoZR/e0vaeOgaTRr8sWs4wTCPVN45OsjZvDzgTklfh2fZyzZKm9JKWRtgyWX7Xfs4AygBlqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ARv78ZXL; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db51133978so2215892b6e.3
        for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723318805; x=1723923605; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msnB0ziZknUzvFY/eEMXgr1WYBRw/SR8BRZg4TDMcww=;
        b=ARv78ZXLVYD0zlSqdsTQCP92IXjQcQdj/UO5GkIdo4SBtTetcv+5lX0p+DX2zMZ5y7
         6uJGctVkBKFIrdXf2u00/NtRagJTuTAtwC5U6QVgvKWowWvpXIY4QbJkPAyx+Z2WNlcv
         atDYK9bjXjnWhnxqUJxh/m9LMo36WdY8ep90I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723318805; x=1723923605;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msnB0ziZknUzvFY/eEMXgr1WYBRw/SR8BRZg4TDMcww=;
        b=MWmuFzcsd3TpeO9IBM7T3uK64I2M+MJePehY8yJ78NzXlkOMY/SRyVuPoJ3P5WIZjI
         NZ7yp4SVJdhM9H3vBoCCex0bBe47EAM9dVAK7DUofWxMWJQqGgEOGqht2OxROACu6Pqq
         l8wgVkFFzolq4yRMUB60R3lsUjbfFLXU4Pn0d7R8IOaidrPFE6rVwh2XeVeTyAayVATM
         yRF27oomyUbmDqpVjsWlkTUqXo3b1YmBofJ+m39Pqs/uopXVMdRxbT/P8q5THlfdk15z
         AAZb+dLdP74AhO5ADbVyRVQFvFrvWyNrb35DC88TA1idqq3IyQJy8ak6n3+SAnrTRLDJ
         Qacw==
X-Gm-Message-State: AOJu0YyJ12Qz1T2jMcP/F5UCXO2G9QP1yI+807Sfqnar0qIbsQPBFK7e
	i7PecJlz9bsxZCbcK3uoJ3Y1uR+GhMQ0xOc47BzuEl8ZB76vM61+iTn3ofJZWg==
X-Google-Smtp-Source: AGHT+IGmn/JmuDcHvvvZtq9axk69M8e0snJk++vNnvbQIvv86kNII/COKKV95azHHgBZzvok8EWutw==
X-Received: by 2002:a05:6808:211f:b0:3db:5571:a44d with SMTP id 5614622812f47-3dc4168b172mr6977040b6e.26.1723318804971;
        Sat, 10 Aug 2024 12:40:04 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a437b7sm1541513b3a.128.2024.08.10.12.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 12:40:03 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: Use variable size Work Queue entry for Gen P7 adapters
Date: Sat, 10 Aug 2024 12:19:09 -0700
Message-Id: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
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



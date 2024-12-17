Return-Path: <linux-rdma+bounces-6567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0C9F48EA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D57169FBA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC41DDA09;
	Tue, 17 Dec 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MEBuTK5D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B41D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431521; cv=none; b=ibthFDAuobbYCL5TPMN5WMLw8MO7MOZORHDXZ/1hZT3yF90z6k7alfQNW4jUeUm8C+MSHuCk9Ye1hQatqO+hJmKGujVh3Zl5zV0whWUCFl9hL1frxvJPYyhWiw9eCZHnhIzW7IG00QaEuqcpj/a010K89V4fxa8bn983Tt2xkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431521; c=relaxed/simple;
	bh=65Bp9nU1RW6WkK951b+OPm+YqdGpVoVmxBFsp5EXcRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eslz3HQHJuZIA8xlb9iNVi8ihvAGRjyTVEj63pWwm/O6Midrd10R4Bprqxsy/xzxX69iUKiGD2VME3JREXOH1JL/GnKYLQKRJK+zHLzGcsyA8Z6GSaPQ8K8+X8f8fmUUvwwf0bL468RoTZ6SlAqoO+9Px2PDC+Aj7RsCAQUl7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MEBuTK5D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so4774340a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431519; x=1735036319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VF609YveT9rnh5YDgQzMClVu8X+dSZd0xitA22PUQfo=;
        b=MEBuTK5DKLNUvTfnVUbXv1ApoOUxCfOBBanBMjobqNzAbh25jt4bVnUMhx0d1G++mG
         TEP6fxosCwMMFqieaRAUvHR1U7WtX/J9u2XhLsX+JOmrTUMeuCK/7NNQCE9XU1gATNTq
         41/DqjZO1LyGyiQsMAxxLZ+EM1MsSlgqjJxYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431519; x=1735036319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF609YveT9rnh5YDgQzMClVu8X+dSZd0xitA22PUQfo=;
        b=UXlwj2hKsXpcWChUG8BMTop/I2CwS43fKOkciaVv2SNKUBxJ7RBuB5Wsf8/fJE8lcc
         uHhT6IAC/Ottd1suaI6QDtmEeC6ooPgfOnv5sDzfm6+DOsviiXM5RiOhFIMR4g317bFl
         VA13om4G7HnZjmV9nmadxi1Xth40KSMW94CALmryC12v6wo4zYqM7jdFYmMukjvlvU5L
         tLo09ANn62rYANqgySmxlicDFKNVqun3xZnm8sLd/3jBGh7oRURrjwzivMI7EEWGF5WC
         aBXfU4xLBv8szq0jjj3MCKENF/VbGnlmsEdAFIvlnRoUyiTkZ1TyANt0CxJtYWQ8B11V
         i+Hw==
X-Gm-Message-State: AOJu0YzCxYCAR/M+JZdRZhlI5Y5pGIKGfIzbisFL73kyhNw7X0uXMhph
	R1jnALsOaXqyv5+k6itzpA2FdUfiYDh1wSggrdw/ZVj7ypfUdMXoI8dUrono7w==
X-Gm-Gg: ASbGncuPu5S5ti6AfNtyI2qg0U6kdNGDwC1crgaatqSRA9gtJ/IxYogWmL4BQcyzLLF
	WiR4qzn3rieCYgYLjDynRICikW/o7PXgm++EeR5R9Wil0MF+1mbEigiP0ziWNTlxjykgFS0VGqY
	ViMV2OrCjVMEAf910o+JAA449NkJ1ZmYn+TX9s1H52MFdNwyLJwA8DRUDCUEE5KS3He6AwA8B8h
	XL26QH0nLxIKOWTWmfJsvJuW+lrFel25B/QXrSDzyAk967NwcvsR6TcB19oQPG99whGnf97FlKq
	kYUheRz8FdrnYBynJGhZsEVJxiWwtzjlnZkDgwrx0fH2H+SxIeeEwI6FJtQ=
X-Google-Smtp-Source: AGHT+IF+IY3xyd4kaohpwGSDzpkTURsR3gBgumIcVyB7KLGMsZg7w9C7ZOYx15C6UNRjZWlBicObMg==
X-Received: by 2002:a17:90b:1646:b0:2ef:ad27:7c1a with SMTP id 98e67ed59e1d1-2f2d8798ce3mr3961800a91.2.1734431519544;
        Tue, 17 Dec 2024 02:31:59 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:31:58 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 0/5] bnxt_re bug fixes
Date: Tue, 17 Dec 2024 15:56:44 +0530
Message-ID: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains bug fixes related to variable WQE
support in the driver. One fix is for adding a missing
synchronization in the QP create path.

Please review and apply.

Regards,
Kalesh AP

Damodharam Ammepalli (2):
  RDMA/bnxt_re: Add send queue size check for variable wqe
  RDMA/bnxt_re: Fix MSN table size for variable wqe mode

Kalesh AP (1):
  RDMA/bnxt_re: Disable use of reserved wqes

Selvin Xavier (2):
  RDMA/bnxt_re: Fix max_qp_wrs reported
  RDMA/bnxt_re: Fix the locking while accessing the QP table

 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  9 ++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.43.5



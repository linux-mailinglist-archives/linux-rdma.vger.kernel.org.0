Return-Path: <linux-rdma+bounces-7904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2DA3E44F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6FA19C18C3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC22641FF;
	Thu, 20 Feb 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cdrtRhEN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7992641CF
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077750; cv=none; b=n6+ESbNc3aT/x2Ad1qeAj0B+MPGkgwyylPfK5T/srIBK+qL6sGFDdydEK0j3L72L2t1dBc4lONi68L/wk4ecMtl4UPXXmvjvNyi9nYWxMO3VglXSlhSjdceMNTWu9h6eGnqbEMaqDVLljH5fAyTsnjbW0yagZF9fpwrrwGk8+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077750; c=relaxed/simple;
	bh=9Bj9uqXypgOJd0cHscsgOY3mLS2KLp0S7RtmxO/wOlc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=f/ilrCyvJPn9O4Aw8HOKdJrQFbZTKe/AzC6QoIoNV1yFJ28OCOwOJgP8wtksMJzAgc1kw6Bjq5RWUr6CuVBYfUMezv9aKwi1+tA1Q2szox/QamlGYhBeu+AwiS/J3C0FAjfEDDIXynQ4Qie7VaGTyqxYjtetFb2/PI3sqx18R1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cdrtRhEN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220dc3831e3so37834065ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077748; x=1740682548; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f92D9Bp7dswk3WBnmkTJtsvGHyTOEvoeTw7+FJkgs38=;
        b=cdrtRhENvyGC7MgVZ26lyxQZhvxb7EBM5EhMJFVz8U0uN5lee4H7448j1RTgeO5CnF
         MREmG/IPxd2rhupUQQwzI7pG14mtkUMwixbXOJbDnviL+F1+cx4A/q7f39ZkiJLGL2bY
         G4PdOVUCblaTppt3BaBowiDtClsACy7SVoqUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077748; x=1740682548;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f92D9Bp7dswk3WBnmkTJtsvGHyTOEvoeTw7+FJkgs38=;
        b=V5MQkh+fleXfeDprmupww0UG7eHczkhOXxCHSN4n6xgm72LvMmX/JhZjFN3jRcVf3D
         +m0q7PXZxRSeNX+1NEUzO94cqdz6owKvfEYzPKf78eiaMt8NUgss20zAzS0VAI2EztL7
         jKotQTAA3s2GgT8AIFF+ipd5beq2Y3x9USQ7wablyIgSz4FcRirZ+zHDFL/XcOyK15+e
         +3OS8gO10bgdv9dJfUkr02ThPxfqk7cKpf9L3O2d2DSM9AMvBurr0EI9v8wulooARONB
         VW3oj/AOY29Nak4Nz0aGOwgVjBE08Ej38m63NqoPnZejV8uka9/s5V4yArwVZEgIeZxq
         X8tg==
X-Gm-Message-State: AOJu0YylAm6RgNM5kqsNff6kLejP/e98Uf2ZfP+Zzdn+2HaBG1kffsDA
	jwaaIFdMuRMH4eiFQNJd9GNlJMwe+qXF0yY78w56q87+5d+sRwe+g3xupwf+XA==
X-Gm-Gg: ASbGncuIjDzRL+94gi6bOqHm4SC0o3faqlxV9FQ1h4FmudxIuEOVB7sAzznWI+d2EPZ
	PIcww/oqBR7aVpvtP17a/wLsxb9pXpYr5oHOuwziWTsLqd5mhGdfHQnZCFpbXZ0K9FG+sTm1EGe
	CsJACRhMjcjAqLV/Yu050+T2C8J6J5tuO1OJGgu0iTRXTbYHmbo04rmaWuywckkDwLikp6T8BKG
	6HA1l7sSpn6VXq5TRzThIZMnJh+/+GLGaxANhEexf+qD8iX4pCbRGI4OG0NVHyNyYviRKSUEMda
	r1d29OLrxUPKiO1FZ5Jc/pTxDZW44hmMn/TZuzjm7/K1tqIlr18dnhDQhpWbrih5SxTah6E=
X-Google-Smtp-Source: AGHT+IF/h0xEooRJrYsZEdPOYzl1oRl1flDvVGD523LE3lC0wNMyvhPk2PGjcUsXl8o2zI5sDdefzg==
X-Received: by 2002:a05:6a21:a46:b0:1ee:69b4:9e5f with SMTP id adf61e73a8af0-1eee2dcb51fmr6448970637.4.1740077747928;
        Thu, 20 Feb 2025 10:55:47 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:55:47 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
Date: Thu, 20 Feb 2025 10:34:47 -0800
Message-Id: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

For debugging issues in the field, we need to track some of
the resources destroyed in the past. This is primarily required
for tracking certain QPs that encountered errors, leading to
application exits. A framework has been implemented to
save this information and retrieve it during coredump collection.

The Broadcom bnxt L2 driver supports collecting driver dumps
using the ethtool -w option. This feature now also supports
collecting coredump information from the bnxt_re auxiliary driver.
Two new callbacks have been implemented to exchange dump
information supported by the auxbus bnxt_re driver.

The bnxt_re driver caches certain hardware information before
resources are destroyed in the HW. Additionally,
some resource information from the host is necessary
for gathering meaningful debug information. Both types
of information are cached by the driver for a finite (1024 for now)
 number of resources. 

Please review and apply.

Thanks,
Selvin Xavier


Kashyap Desai (3):
  RDMA/bnxt_re : Initialize the HW context dump collection
  RDMA/bnxt_re: Get the resource contexts from the HW
  RDMA/bnxt_re: Dump the HW context information

Michael Chan (2):
  bnxt_en: Introduce ULP coredump callbacks
  RDMA/bnxt_re: Support the dump infrastructure

Saravanan Vajravel (3):
  RDMA/bnxt_re: Add support for collecting the Queue dumps
  RDMA/bnxt_re: Cache the QP information
  RDMA/bnxt_re: Dump the debug information in snapdump

Selvin Xavier (1):
  RDMA/bnxt_re: Add support for changing the snap dump level

 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  75 ++++++
 drivers/infiniband/hw/bnxt_re/debugfs.c            |  49 ++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           | 185 ++++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |  42 +++
 drivers/infiniband/hw/bnxt_re/main.c               | 290 ++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  47 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |  16 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |  12 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  14 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  15 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   3 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |  12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  57 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |  22 ++
 16 files changed, 817 insertions(+), 26 deletions(-)

-- 
2.5.5



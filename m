Return-Path: <linux-rdma+bounces-5372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF8999C15
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 07:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC119B21D3A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6E1F4FC7;
	Fri, 11 Oct 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RONpdbfX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB131CC174
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624287; cv=none; b=ZeCwFrg296Xd72PCxyIIdG8n/0pz8Xn/YdmBTLzjlBH+gDwC0lAqEG78A1mZhtmfAwSPeFO8ylWvYij8kf+4EnV8hPQOu5fO2HEsWPyKwK/g3jfIf6z9d0q9ZfIKbu6AM54JTT8Q3YxVL+CzGGDsDph6+UG0XeWBZIm3sEw5v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624287; c=relaxed/simple;
	bh=XgbpayjQiBdJQE3pdMDSaiGbAAgZWyKaPpGREKHSZuQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b7MnW+uUgS8OBDZJOMC6FUqqMyJDXEyAVmSItf63r1p2iraHYIImgXlL3rtr0b6iuqwyngv//6F8GR12EN6YuTFBRzKRw+1u1qKVJgz0nCwdibKdEyNudTN0nA1lHCChL6VtQIGLgwJEGV/2PVFJTkXfu58liZlpsTrJF8eu8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RONpdbfX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so1359748a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728624286; x=1729229086; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKoqRdRewPTaL0NwN11z8DdACYXv6ShxaqcAUetur4o=;
        b=RONpdbfXP3puiBVqd7dtQ0ksKlkwiEWmu1BzDLS5JRa35XLHyQXsQqHn2edYr6lIsn
         qLD8dyvPBL0naChllbN7Xn9ed+7fDmXCCXaqF603FvdunFOGF7nM9s7gxK8RyeD00fwV
         b67f9ZlxD9/owhAPMg5BuuniEnIoFkOK6hHBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624286; x=1729229086;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKoqRdRewPTaL0NwN11z8DdACYXv6ShxaqcAUetur4o=;
        b=YTgZep1DqM9Y60YIihBo6+F2QdkeJ3LF8EgUB+EX7GMEssHAtzEr81IneEL5h0umGO
         /CeXvpkZsPKJ/FJiyWGXjMQi+fmaDQhdjSJG7kktowviaHdm5phMd3kQigx/nuyy5ghj
         um6q4UsSieH7AzfOchIVAOrJGzp7q0jPrCSTQ+P6uiLOPzABOVCm6ijEo5eefidwLZb0
         TJIUeK3n8Qo5AqdW+AGSZTsWodYW22obiBiMveZT9EBXbrREz4lMo4SsLTdVSX4gYnDG
         qdJRAF9R8RZsrTfwlzBLt1HC4VWW4HohovYBLlGy97n+yNZlQI7cffy3uZSH5DMv9kFb
         ndNQ==
X-Gm-Message-State: AOJu0Yzzyvpwy61P/wHEXJCnpeY9mdBQaaOwyge0S1NZ1/X0mK1ERI99
	tPDR51OhEzb315OHdZSdjnMRgL5UkAVr520VOlhkAYS0COFdUYoBmw2pe40ggw==
X-Google-Smtp-Source: AGHT+IEY8+1OEDOCOkZtHLmozbVMb8FuoVPL2bWGQArFYCcYiZevkTF0/5AFI/s/wjVW3ebfre4n/A==
X-Received: by 2002:a17:90a:98e:b0:2e2:ad11:bd36 with SMTP id 98e67ed59e1d1-2e2f0d99521mr1988050a91.37.1728624285622;
        Thu, 10 Oct 2024 22:24:45 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f09ff1sm2377069a91.26.2024.10.10.22.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 22:24:44 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: driver update
Date: Thu, 10 Oct 2024 22:03:51 -0700
Message-Id: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Includes some generic driver updates.
Please review and apply.

Thanks,
Selvin Xavier

Chandramohan Akula (1):
  RDMA/bnxt_re: Add support for CQ rx coalescing

Hongguang Gao (1):
  RDMA/ bnxt_re: Fix access flags for MR and QP modify

Kalesh AP (2):
  RDMA/bnxt_re: Add support for optimized modify QP
  RDMA/bnxt_re: Add support for modify_device hook

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  8 ++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 76 ++++++++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  3 ++
 drivers/infiniband/hw/bnxt_re/main.c       | 10 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 60 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   | 20 ++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 10 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 17 ++++++-
 9 files changed, 199 insertions(+), 11 deletions(-)

-- 
2.5.5



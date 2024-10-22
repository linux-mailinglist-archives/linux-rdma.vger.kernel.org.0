Return-Path: <linux-rdma+bounces-5468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F069AA01E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3A0B21140
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286B198842;
	Tue, 22 Oct 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PW2JoZnC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF7146A63
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593173; cv=none; b=Rm0JsKB+CFAFky2ojqeB+X1UpuzLjw3O8tF1Mt+uFlcQ8zxG7Vi3vbbo6GnJIKa+qFE8P6fVesK3chAV5jPD53uC03P6XyRCMmiezS42754Nq/L9rocIJzjy4wYr2ZlgSFAPcK8Q98Bke2AtBp79umiPBOVG3Xa9rShW7U+0vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593173; c=relaxed/simple;
	bh=PMdMKewde0s2C+FA0/WcU2143/j8NeLfz6o+2PCRMKk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U2kGL+btGo3rpoGtFpPnRXpD2eIPsaO3ZJF66n2uX8od6J1x1K7LmdXYGxeYaTM53VoWrFfS6eu+rtg0AZJCnXefox1cs6pfR3qz3Azx7rXQmn8exatEDXQNobPJkogh5lC28uVFzuY4XO26nYf15GYkb0srZT75zHZ9zuzXtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PW2JoZnC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso3864696b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729593171; x=1730197971; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdiczywgGzGmZ1G17oPx7BS1Rv+/u9eOtnnFfPotXQg=;
        b=PW2JoZnCTO9WEVWHHfVemk2r6j2uG8DgKM3C6DQ23kfTWZiKVa4GZ7eyINcF2nRWBE
         Yh6wJnTBr5I4sgPOILXMX60cVQ1vTw0xRT6G9s1bHxHHy6totWYUeayd/j7dvGYBSAIm
         21IzmVgJjJp2pGvdci24MZg92CY4xDdvhmJiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593171; x=1730197971;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdiczywgGzGmZ1G17oPx7BS1Rv+/u9eOtnnFfPotXQg=;
        b=V0AwXzNP2995BVsXavHWIuVfbFtmRN2kfkswR2QvUe7WM/ukDa6gFutI5ym0F1bFyV
         /VjYI3O5ZfPHeCjaKHQpiYHbga3oWh/vJd5CO2QSRMeh80mJEE9ErbwmAX1KuApwJjNn
         a4UMhFiA67m3hNCiXDKunewhLsaDW76RlAUJIgeMzFQWvAojSse634VPPCfsoecQcYyB
         p+HgX60U3Yg2JnVInWhUkUb0pxZK7j04yhD3EUGoHmGh8F+EaL+80PDe08Zm/4K6g6fS
         A7DHS74n+WFLGUSDoMPAmK9zxyesEgZFOXj1TKyIBgF77/IB0BLeb4RZ99eYDRKPxUFI
         CZ5A==
X-Gm-Message-State: AOJu0Yyf69YMMVU/aR2YdS9wG8ehE3qhx8zJw8i8KtRwv/ZcZ7NKGXNs
	rQz3J7ASiDnl9PK0rk7mmX39VGW3ev22d/BC9+gZKBbQVHvlg4BHO36uhGq7Sw==
X-Google-Smtp-Source: AGHT+IEJzfiYTEBR4RE8GJeY+r1M2UBJLPsII/snr6aJKJngnadLBFnKrQaiDF+ExVsn0YxtihaY+A==
X-Received: by 2002:a05:6a00:22d6:b0:71e:50ef:20f3 with SMTP id d2e1a72fcca58-71edbcc104cmr3503094b3a.28.1729593171468;
        Tue, 22 Oct 2024 03:32:51 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131393dsm4414572b3a.37.2024.10.22.03.32.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:32:50 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: Debug enhancements for bnxt_re driver
Date: Tue, 22 Oct 2024 03:11:52 -0700
Message-Id: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This series is the first set that enables few debug
options in bnxt_re driver. Implements the basic driver
data collection using the rdma tool. Also, implements
raw data query option to get some of the Hardware specific
information for analysis. Added a debugfs folder for bnxt_re
corresponding to each PCI device to display some of the
driver specific information. This will be enhanced in future
series.

Please review and apply.

Thanks,
Selvin Xavier


Kalesh AP (1):
  RDMA/bnxt_re: Add debugfs hook in the driver

Kashyap Desai (3):
  RDMA/bnxt_re: Support driver specific data collection using rdma tool
  RDMA/bnxt_re: Add support for querying HW contexts
  RDMA/bnxt_re: Support raw data query for each resources

 drivers/infiniband/hw/bnxt_re/Makefile     |   3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  21 +++
 drivers/infiniband/hw/bnxt_re/debugfs.c    | 141 +++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h    |  21 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |   4 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |   1 +
 drivers/infiniband/hw/bnxt_re/main.c       | 279 ++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  35 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   2 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  40 +++++
 11 files changed, 547 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h

-- 
2.5.5



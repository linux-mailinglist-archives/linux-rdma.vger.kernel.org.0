Return-Path: <linux-rdma+bounces-13151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF17B488AC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39CF188C8D0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB442EC55F;
	Mon,  8 Sep 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="blKM3LzD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609A27F4F5
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324337; cv=none; b=XC0/vCwsN4PlGq6/5or5hPVl8tbZ5wf6MzsIeTgseeieaSNSCoIoA7CRZuL/49fwR7T39KualgpfP4/oT62COWe10qkJC9Dz6o9mC4wKCa+dzwxG9QTW7TLk/qsU4ZB5vS5ngHY8FuhJ5fnQdlMdJPAxddUz4Qa7yzWMq/qfkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324337; c=relaxed/simple;
	bh=npes6HWow+jXIVtU0oBA0CJaCPj7uf+6MDz0feLmdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZjKKia5iZcRQjeLueS84f2y4kb4mM8sOVdTKkOhHA9D8PaJhWjamIhtOpaGisnBgTH6OwSassr5qDbpZXSDQs6L7xxz69mtN9WTatX6DTNKiU6bdSVQNYVLq5Mwhl20rma6x5XY+UT/vs3AUaSp8J1/O22vfacyK60CSx9EbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=blKM3LzD; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-407240934c9so8801095ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324335; x=1757929135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDNjwtxRSSh4w9yOPHx1FkZ6q2s9GelhhaRRwVvJNRA=;
        b=qjsNa5Xyv5octHfcFy/h/h8Z7FFT6zQ7V5PWD2UQlIIeuagw1tCsGA2ocUNzxS+MM0
         iVrWbBdZjJTEF+4gr2r3h/JAjZVVG4YhOnqgPDtfpce5KCAty0F+UbjJZlVbpeqNPQB3
         IGxBYBgo+64Zzp9eEJGB5gwSPmJCAo48sfihQ7+QDipY6Zgur1yhbkJx896ABvNCNbJV
         h3layfPWuwooHMZnrwtLTuE8RImhRJbKaCLFQ422nQW7GAy/GcnihdVFEKuMxhzQFDf2
         krVBDCrxARkzCphC3iGR+GKQ8PTF2E3wIJjcE8mwWi+zWvBSdGtY/CP3HKsJnK49R35h
         O27A==
X-Gm-Message-State: AOJu0Yy1yho8eZuaD9/FueShrdmysUeU/vYqhx/J1J9UyMcb+JEAqD4a
	iZWcvihGZ2pLpIooPR0K/ilwysDr64/3AcW/rulQbd3nIXkDudySskxUHKMtpxtcQk63nJpZOuA
	Asm96OTxLDksgWhtcfeupolp9NcsIsQYvgCLkIQSH9JgtMug0EgrzvT3wkQj6QH1HB0H8RMRz9k
	f+rTcjtDxYBbPFJXIoxBSp0XCV9c5jaa+7diMf4kBIcnA5dVCUkU8Ucxgchl8MjnzFdFuDpgUuT
	mSnnT8Wl6PeNFckgwt6l2/Z+JKZOg==
X-Gm-Gg: ASbGncu9fG+y7A3qLeXw7UDilyhOK3ojjBz/ubVB2i1AQDkW3F0GyTRq+oDFpKmVzdh
	5oWDGf6mASPNdsAbvSJ5KOKTLvMfuHGmIk11Z9e4iI2B+Rvfo0NRSAtNsSmfOPIo7vEkZsK7c2B
	eup/ysBUOC0IX+bXWY/7KyhND1trjT7cC3DctKpCmFMawcLrHDwPHuyibgTfnbFDr/HAjqaUuhT
	m8Lpr2zltAHbv2i37rBRsTATlA4uaP5aFfoZUyP+VsgBsq04lbmj1gyPDVG+RMHTAw1O0OVc+ST
	jkdGcHUzGWGANjZ6wBzuua7LXfHUNQ3+b9WJ74EWnDyeg8fvyeJpkCUSUeZgUqwrf+FXck90YNE
	s967ZmWhSUTcdtoVDSbhslGQH8PSHzHIkEde378nBgGCjo+82MVTdRqrdHTfYvIOU83mU7z4p1a
	o8vuG+a9HkSuKZ
X-Google-Smtp-Source: AGHT+IFQ9NvALnuUKeGmxk5jLapdtggPusxezZ58zWQp/RSpYnbsLlkPlIRQf6j456JyagzuO5aKxTr5YToo
X-Received: by 2002:a05:6e02:12c3:b0:409:5da6:c72b with SMTP id e9e14a558f8ab-4095da6c7cfmr23161125ab.4.1757324335536;
        Mon, 08 Sep 2025 02:38:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f3deed0539sm20041555ab.29.2025.09.08.02.38.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:38:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32972a6db98so7389905a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757324334; x=1757929134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDNjwtxRSSh4w9yOPHx1FkZ6q2s9GelhhaRRwVvJNRA=;
        b=blKM3LzDyRPaT7pSs2aYfbkpYhirj/fXjQqPj6qmhqt5xfhZl0Ebp97LVxiiwWXt8H
         o1gF3geIJTzfWpUS+kyObYaOnTBG1Jo9mgRwlrS9OSZHSNanO5HZ6TLdGzeCjOshdpZJ
         WiKx6xSdlxPN+agc2FcgLpjZqP1+hG9LdoOMI=
X-Received: by 2002:a17:90b:3d89:b0:32b:5f18:f893 with SMTP id 98e67ed59e1d1-32d43fc57c4mr10893692a91.33.1757324334027;
        Mon, 08 Sep 2025 02:38:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:32b:5f18:f893 with SMTP id 98e67ed59e1d1-32d43fc57c4mr10893670a91.33.1757324333491;
        Mon, 08 Sep 2025 02:38:53 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d8ead7bbbsm1629283a91.16.2025.09.08.02.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:38:53 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 0/2] RDMA/bnxt_re: bnxt_re enhancements
Date: Mon,  8 Sep 2025 15:15:14 +0530
Message-ID: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi Leon,

These 2 patches were part of an earlier patchset.
Since the patchset got merged already, resending them
with the comments incorporated.

Please review and apply.

V1->V2:
Patch#1:
Fixed to use sysfs_emit() instead of scnprintf()
V1: https://patchwork.kernel.org/project/linux-rdma/patch/20250814112555.221665-2-kalesh-anakkur.purayil@broadcom.com/

Patch#2:
Fixed to remove unused members from "struct bnxt_re_dev"
V1: https://patchwork.kernel.org/project/linux-rdma/patch/20250814112555.221665-5-kalesh-anakkur.purayil@broadcom.com/

Anantha Prabhu (1):
  RDMA/bnxt_re: Update sysfs entries with appropriate data

Shravya KN (1):
  RDMA/bnxt_re: Avoid GID level QoS update from the driver

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   6 +-
 drivers/infiniband/hw/bnxt_re/main.c     | 143 ++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  40 -------
 3 files changed, 49 insertions(+), 140 deletions(-)

-- 
2.43.5



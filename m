Return-Path: <linux-rdma+bounces-5415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D322A99F44A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8824E1F24837
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C1FAEF4;
	Tue, 15 Oct 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OOBt2fhW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC71FAEE2
	for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014176; cv=none; b=KfgE1xzcjzH+TTPvHHXgzuQEbs7AwRHcaf2PB4FGFDzHp/PkTpGeCUFFfAdGpE1DYDxffQYP3Ha+kb/D4EJWwPY01qMjzyYlgBKT0wQNimsM+AvwfWAzwVRIC5DCtMCFJCUkGvms7EBfdOv2LVdp0ch0RxVlqpBP2r+PUHSgr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014176; c=relaxed/simple;
	bh=/bUWOOKuDqKLEkJDdLdYh+IpBQwrMyzMGYfDIWa+v3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLfCygMjG6+WbhAwwStWTX+jRqx189I8iVGIbAwcf3KWiPqK4G0++/FJzAmxbccrMLJSI97BctenPB83dW76xGb9VpjXZIOq+1QsHyYA/OQe3ZNXSNQMQSOUX19awd5kE0z1sSPp5iOYR9cw12Pl1H4Zpemiui1G4W5GqxelxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OOBt2fhW; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729014172; x=1760550172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANYGaZAUeMHItzWha//WTvTtB2XHPMeyjGtP6uPLT2I=;
  b=OOBt2fhWQEMY/UxGPgzLqRa9l/FO3EOgVvkqaYC6yEn93eAsxA1qRRZi
   JCL+H6SMp8Z//cnEwkIpm1j6vIZlTBuW1Hw+8q+EGcGW+/ttJ8/HjLUsw
   u3M/W9ge5ivUX8gnXH8cQkkd+66LkRmJueaLNcni1dgxqaw9ock2ufWEd
   g=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="441017506"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:42:49 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:17375]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.130:2525] with esmtp (Farcaster)
 id 5a17e201-6e8b-4d62-806e-2b8089eb5828; Tue, 15 Oct 2024 17:42:46 +0000 (UTC)
X-Farcaster-Flow-ID: 5a17e201-6e8b-4d62-806e-2b8089eb5828
Received: from EX19D002EUA003.ant.amazon.com (10.252.50.18) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:42:44 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 17:42:44 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 15 Oct 2024 17:42:43 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTP id 2F42C40420;
	Tue, 15 Oct 2024 17:42:43 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next 0/2] RDMA/efa: Support QP service level
Date: Tue, 15 Oct 2024 17:42:40 +0000
Message-ID: <20241015174242.3490-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align the device interface and add an option to pass QP service level
from user to the device.

Michael Margolin (2):
  RDMA/efa: Update device interface
  RDMA/efa: Add option to set QP service level on create

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  54 +++++++--
 drivers/infiniband/hw/efa/efa_admin_defs.h    |   4 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c       |   5 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h       |   3 +-
 drivers/infiniband/hw/efa/efa_io_defs.h       | 106 ++++++++++++++++--
 drivers/infiniband/hw/efa/efa_verbs.c         |   6 +-
 include/uapi/rdma/efa-abi.h                   |   3 +-
 7 files changed, 156 insertions(+), 25 deletions(-)

-- 
2.40.1



Return-Path: <linux-rdma+bounces-13887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F016BE31F4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01D32357CF6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90831B105;
	Thu, 16 Oct 2025 11:41:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16931A815
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614864; cv=none; b=lfdSwpP8Iiv8CnWftxywxl9co82yZnCqWzPVrJbFCmcQv9l7hY+VN8S5Nzam9JoHIBXnPfaRmsrVbRNrBj3/2FXpIpXG91O4d3H5GV9p4fVEn1+kNvTXBVkn1ebu1XhPsa4FrHYcWg4hJntqNckI31JTkuZccjq2TYphcf6ZUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614864; c=relaxed/simple;
	bh=+ckRVvPMdU6Vsxv0z9mnzb74S4C1it3rid9iDtLkfes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2tCK4IxQhztDGtka8oKrzWT4rNGnLT6qJqhm4qZeepp+DqDdxf750xQN0BM+MAivM+Rg9anI2YnxAHghp+OAqcEv9ma6rgorX/Heg7jfZgPvBavd/6UcWDXuY7YQRTBHyhYqAYZeNuCKffKrimQD7L5zX7Mlpbf8s3kaNNS5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cnQxX0F2yzKm5G;
	Thu, 16 Oct 2025 19:40:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id D88D7180043;
	Thu, 16 Oct 2025 19:40:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 19:40:52 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/4] RDMA/hns: Bugfixes and cleanup
Date: Thu, 16 Oct 2025 19:40:47 +0800
Message-ID: <20251016114051.1963197-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

This patchset contains three fixes and one blank line cleanup.

Chengchang Tang (1):
  RDMA/hns: Fix recv CQ and QP cache affinity

Guofeng Yue (1):
  RDMA/hns: Remove an extra blank line

Junxian Huang (1):
  RDMA/hns: Fix wrong WQE data when QP wraps around

wenglianfa (1):
  RDMA/hns: Fix the modification of max_send_sge

 drivers/infiniband/hw/hns/hns_roce_cq.c     | 58 +++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 12 +++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  4 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 -
 5 files changed, 71 insertions(+), 9 deletions(-)

--
2.33.0



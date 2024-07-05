Return-Path: <linux-rdma+bounces-3667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDC9284A7
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DDA1C24B02
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60C146A9A;
	Fri,  5 Jul 2024 09:05:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148D146D55;
	Fri,  5 Jul 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170315; cv=none; b=mxjnxLtcZMvkETlq5r3pB7PCCagvExzXqqdyvd2v98ZxPe8fenKlF6J+zIdPpGRlQc1TeqPb+Z8OIN60IsuEYdGVmr9F9Fs8mStcbYsUK6hYVYPmM1z3qCL5/uc4ZLpNe/sOjenfmKfgMtisl3xblT0dGAlyLxo1BMfrIEMlHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170315; c=relaxed/simple;
	bh=CMRb6se6WXLyGUIXekn1XnTi7HSlQZnyhkQQc7GAtxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=We/JnbX770gvtpbFnhzKemGRjgND6Ovx//xt880PMptowzS89QOoR9bAOWeQv8mm7RraKrrzX2NZSveQvoEPeB/vK5f6j2yieVBz5frhhFLWIQc33W11iPeXE61I+ko08oUPapiwmQmrQjblKYQ0XSrRbiCWKE8GokKoDu39XhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WFnXk4t04zxV9h;
	Fri,  5 Jul 2024 17:00:22 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D2C3180AA6;
	Fri,  5 Jul 2024 17:04:52 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:51 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 0/9] RDMA/hns: Bugfixes
Date: Fri, 5 Jul 2024 16:59:28 +0800
Message-ID: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Here are some bugfixes for hns driver.

Chengchang Tang (5):
  RDMA/hns: Fix missing pagesize and alignment check in FRMR
  RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
  RDMA/hns: Fix undifined behavior caused by invalid max_sge
  RDMA/hns: Fix insufficient extend DB for VFs.
  RDMA/hns: Fix mbx timing out before CMD execution is completed

Junxian Huang (3):
  RDMA/hns: Check atomic wr length
  RDMA/hns: Fix soft lockup under heavy CEQE load
  RDMA/hns: Fix unmatch exception handling when init eq table fails

wenglianfa (1):
  RDMA/hns: Fix a long wait for cmdq event during reset

 drivers/infiniband/hw/hns/hns_roce_device.h |   7 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 191 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   5 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 +-
 6 files changed, 152 insertions(+), 63 deletions(-)

--
2.33.0



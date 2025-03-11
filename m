Return-Path: <linux-rdma+bounces-8566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730FEA5BB41
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3715171853
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778722D4FF;
	Tue, 11 Mar 2025 08:56:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C722A800
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683397; cv=none; b=V3HQp9CR/pkfBcIMOEiHShitQm8qqjSYN14RLzTFY3H0WyKoS1h7RPECMhXE4BaVvetCaeDIKnwpji47u535oTCFXFwowDL0ckAP+nLJpkqldnL+LTh7Jbbj9rVpKLctKfrXkZFXlv1PbR0rLfxe+NCuqfgv463H0o12w7JLhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683397; c=relaxed/simple;
	bh=UbFoMlw3lLmIf4ZN/ytPjUC87zEs039PnNQS7zr/vU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eNcSGCXGsDSG6U59EEFFBi7UmWGHbqk0djlprayrjhspEEoRlWJSbj2iSqU3NpfDukdSc0CJS+dWQqbEmsU1c2lVl1Vb90diuHvZQWp+ZJvvonB55X3wp6zTSS1kVQEMB56xEo0sBJrMdG23jj8ivrEu/OdcLUhCs/o905y6qj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZBngJ4k3dzyRqH;
	Tue, 11 Mar 2025 16:56:28 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DF8D41800EC;
	Tue, 11 Mar 2025 16:56:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/7] RDMA/hns: Cleanup and Bugfixes
Date: Tue, 11 Mar 2025 16:48:50 +0800
Message-ID: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

This series contains some recent cleanup and bugfixes for hns.

Guofeng Yue (1):
  RDMA/hns: Inappropriate format characters cleanup

Junxian Huang (6):
  RDMA/hns: Fix soft lockup during bt pages loop
  RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
  RDMA/hns: Fix invalid sq params not being blocked
  RDMA/hns: Fix a missing rollback in error path of
    hns_roce_create_qp_common()
  RDMA/hns: Fix missing xa_destroy()
  RDMA/hns: Fix wrong value of max_sge_rd

 drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  1 +
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 16 +++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 22 ++++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 7 files changed, 34 insertions(+), 15 deletions(-)

--
2.33.0



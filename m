Return-Path: <linux-rdma+bounces-3798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B192D32C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DA81F242E4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58F1946A8;
	Wed, 10 Jul 2024 13:42:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248219412D;
	Wed, 10 Jul 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618954; cv=none; b=vBY2PLNkXjo4ylWPlG+PCZvqnXPu+XijH3csrfGd+eYSothp7QCqVTd8KlDF87k81kCGY94AYfSihSrJUh+cBotJjwbZlLZcwy+Iy0JxTM3/P5/Qh6Y0w7kZxHmsN+mrdV80eSx8PDW/q1fZ7BGhyn/5nXvFTQ4sPueBMSCeJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618954; c=relaxed/simple;
	bh=P6dMXAa4aK7kznempixsatXqdLe6ioCSMbTLC/ydCyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfDBEhHyCW2VFRTFRFi2a47zAUHFwYQyGwJjn+y1WxBFH5Gnx6wQAZHNlc01KMaTn6ZqwAxEZTjkuUVZ1fzVLajqR/QxnXNat2Z5sT1p6/660EhUhUNQDqBgqbgazWPGwGTHcuPc2z5o1ymZzmnhSWj7LV6mkem5LvuhX1QShfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WJzSQ01nPz1T63R;
	Wed, 10 Jul 2024 21:37:42 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AAFDE18009B;
	Wed, 10 Jul 2024 21:42:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 5/8] RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
Date: Wed, 10 Jul 2024 21:37:02 +0800
Message-ID: <20240710133705.896445-6-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

A shift-out-bounds may occur, if the max_inline_data has not been set.

The related log:
UBSAN: shift-out-of-bounds in kernel/include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
Call trace:
 dump_backtrace+0xb0/0x118
 show_stack+0x20/0x38
 dump_stack_lvl+0xbc/0x120
 dump_stack+0x1c/0x28
 __ubsan_handle_shift_out_of_bounds+0x104/0x240
 set_ext_sge_param+0x40c/0x420 [hns_roce_hw_v2]
 hns_roce_create_qp+0xf48/0x1c40 [hns_roce_hw_v2]
 create_qp.part.0+0x294/0x3c0
 ib_create_qp_kernel+0x7c/0x150
 create_mad_qp+0x11c/0x1e0
 ib_mad_init_device+0x834/0xc88
 add_client_context+0x248/0x318
 enable_device_and_get+0x158/0x280
 ib_register_device+0x4ac/0x610
 hns_roce_init+0x890/0xf98 [hns_roce_hw_v2]
 __hns_roce_hw_v2_init_instance+0x398/0x720 [hns_roce_hw_v2]
 hns_roce_hw_v2_init_instance+0x108/0x1e0 [hns_roce_hw_v2]
 hclge_init_roce_client_instance+0x1a0/0x358 [hclge]
 hclge_init_client_instance+0xa0/0x508 [hclge]
 hnae3_register_client+0x18c/0x210 [hnae3]
 hns_roce_hw_v2_init+0x28/0xff8 [hns_roce_hw_v2]
 do_one_initcall+0xe0/0x510
 do_init_module+0x110/0x370
 load_module+0x2c6c/0x2f20
 init_module_from_file+0xe0/0x140
 idempotent_init_module+0x24c/0x350
 __arm64_sys_finit_module+0x88/0xf8
 invoke_syscall+0x68/0x1a0
 el0_svc_common.constprop.0+0x11c/0x150
 do_el0_svc+0x38/0x50
 el0_svc+0x50/0xa0
 el0t_64_sync_handler+0xc0/0xc8
 el0t_64_sync+0x1a4/0x1a8

Fixes: 0c5e259b06a8 ("RDMA/hns: Fix incorrect sge nums calculation")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index db34665d1dfb..1de384ce4d0e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -532,13 +532,15 @@ static unsigned int get_sge_num_from_max_inl_data(bool is_ud_or_gsi,
 {
 	unsigned int inline_sge;
 
-	inline_sge = roundup_pow_of_two(max_inline_data) / HNS_ROCE_SGE_SIZE;
+	if (!max_inline_data)
+		return 0;
 
 	/*
 	 * if max_inline_data less than
 	 * HNS_ROCE_SGE_IN_WQE * HNS_ROCE_SGE_SIZE,
 	 * In addition to ud's mode, no need to extend sge.
 	 */
+	inline_sge = roundup_pow_of_two(max_inline_data) / HNS_ROCE_SGE_SIZE;
 	if (!is_ud_or_gsi && inline_sge <= HNS_ROCE_SGE_IN_WQE)
 		inline_sge = 0;
 
-- 
2.33.0



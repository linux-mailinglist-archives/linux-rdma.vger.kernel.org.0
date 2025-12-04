Return-Path: <linux-rdma+bounces-14881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06959CA2FD7
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D897F30C44D7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BF304BC2;
	Thu,  4 Dec 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ovgrYU1+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73019194C96;
	Thu,  4 Dec 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840303; cv=none; b=jtQMPcBkNSzR7kYw4AgOhpHXAQv5ClsZakaQowUTHDVJtSIOttW+HWUX4hoOOPv2K2n3rdJZy9ZncSFRzQA+aWvTRn7MYtlUEqbhDaJR9lqye15EiGCO9O6TQp21kF8WMmbJPZreVipt13zktTZVkU3xdRXl5SKw7kArnSy3s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840303; c=relaxed/simple;
	bh=LqHQe+rJJK1A8yDgxqYeC/IQ/xnArT3FtbUoNFgBNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3jA38qnACUpMeCfCIPj5Z60ZpgkZpcSZae/CQ9ObP9bmcbelFvwSjCvCsDxJG740UMv3h511E1aDlZq8sYpIcgBKNpS5encEiNpjIKzsEWbYdsPxqFOt+XvtMh7FFcvuswnram1ydFgZOI1J06H3dw3wJYM0nBea03w93qDZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ovgrYU1+; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764840291; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=17BuGrlyv4sjueTH40Jg6dH2V+v4ihkeTMLYw6rKz8I=;
	b=ovgrYU1+TqkjYipWKcg/zpVyOXi0/MmHAT3P7hNSeHBunIoAY3ObGuz8IwmSuHBn2vmgXGxKx7dptY8c5kbvI6WxIfdzPTG8bxhcQ4AxlU677NjpeNcj0T2SRkX9xJlnVqavx+ldTl1dBybJ1dhUrxgRZ0vIB8B9jvHCbBUaxhk=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wu3q5Lz_1764840255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Dec 2025 17:24:51 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: krzysztof.czurylo@intel.com
Cc: tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] RDMA/irdma: Simplify bool conversion
Date: Thu,  4 Dec 2025 17:24:13 +0800
Message-ID: <20251204092414.1261795-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/infiniband/hw/irdma/ctrl.c:5792:10-15: WARNING: conversion to bool not needed here.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=27521
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ce5cf89c463c..081551da763a 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -5788,8 +5788,7 @@ static int cfg_fpm_value_gen_3(struct irdma_sc_dev *dev,
 	bool is_mrte_loc_mem;
 
 	loc_mem_pages = hmc_fpm_misc->loc_mem_pages;
-	is_mrte_loc_mem = hmc_fpm_misc->loc_mem_pages == hmc_fpm_misc->max_sds ?
-			true : false;
+	is_mrte_loc_mem = hmc_fpm_misc->loc_mem_pages == hmc_fpm_misc->max_sds;
 
 	irdma_get_rsrc_mem_config(dev, is_mrte_loc_mem);
 	mrte_loc = hmc_info->hmc_obj[IRDMA_HMC_IW_MR].mem_loc;
-- 
2.43.7



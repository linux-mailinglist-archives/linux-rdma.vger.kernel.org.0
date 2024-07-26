Return-Path: <linux-rdma+bounces-4000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF793CECA
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 09:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877B01F22311
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11B17623E;
	Fri, 26 Jul 2024 07:24:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E623A8;
	Fri, 26 Jul 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978687; cv=none; b=F6xf2wVB7dL702NlSvl21gDbOliv9ME8KK5cEzLJ6c+jVQYwiqEfjjLPsGQoUlBqKti5JqbieLfRgSuUyVrxrBIbTPtjmuvr0Y8y+3cfyDOax8qfK6rlYZF5ulRxcHbJr02nLnk+HcrFBuN6cJ+HfBVGEj2dFjvMTvx1wMGs0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978687; c=relaxed/simple;
	bh=tcaA7MCrQA4eCIh9Kf53KD7yAD0bdhQ/fgHFWp8ia/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WX8CAuvFF0sC62++Psi2fhDYJQzIHlvRlpLKVpcz1OpfTkN3LUGU249JFhomL13AJ/wnUdD5OVH6z4Wtm7EujgjFZzdmxIXs/XSZP37PWn4GDF5mRUbe4CsHRke8UkAHWMp2ZhPliILiRhIXFlHmLPpJ48XvZGAwcniQpXn2Qt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WVfNZ14vHz17Mw3;
	Fri, 26 Jul 2024 15:22:54 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 028B91A0188;
	Fri, 26 Jul 2024 15:24:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jul 2024 15:24:36 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/3] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Fri, 26 Jul 2024 15:19:07 +0800
Message-ID: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

Chengchang Tang (3):
  RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap
    pages
  RDMA/hns: Link all uctx to uctx_list on a device
  RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

 drivers/infiniband/core/ib_core_uverbs.c    | 85 +++++++++++++++++++++
 drivers/infiniband/core/rdma_core.h         |  1 -
 drivers/infiniband/core/uverbs_main.c       | 64 ----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 15 ++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 13 ++++
 include/rdma/ib_verbs.h                     |  3 +
 7 files changed, 120 insertions(+), 65 deletions(-)

--
2.33.0



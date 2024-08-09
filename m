Return-Path: <linux-rdma+bounces-4262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45E94CC3F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB8B285C43
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418FF18DF90;
	Fri,  9 Aug 2024 08:34:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8D1741C8;
	Fri,  9 Aug 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192444; cv=none; b=KRu21+T1IlgHOAJN7+3knA4RNk+ds/sMufVNYEXV39T7y+6blQzrxtikfuihWzGS6NJc5CqNtrovFxPglb70Yg4tRJ/vDSanqpmO5cZ0iR1ibgooD/9c2FA/WMTKZ4t36sE5cdZhF6MgeoWyHWTGLq+UZhEcAevmg0sT9wXf8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192444; c=relaxed/simple;
	bh=4UjZgx83/dHQRwrIYs7m4JPiwrLPoLPNz0Ac1MN4lHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3rVr0PuzeIi1qa3YMpeLdGjsZYLtivMGbMeD+7ciLk/HjM/ZaE5E4IX0CyciKXcbKo/Ya6pnvES1QGBbmJH9/h5d1D8910jwM+700hhVPKYTfeZlY4uzaZO1XRh8/UiF4w4yQQA/xxeZeJKWQzKLC8ZkkWbq6aw1+9KvfGmKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WgHHg2zSCzyNtm;
	Fri,  9 Aug 2024 16:33:35 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id B615014022D;
	Fri,  9 Aug 2024 16:33:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 16:33:57 +0800
From: Liu Jian <liujian56@huawei.com>
To: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liujian56@huawei.com>
Subject: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
Date: Fri, 9 Aug 2024 16:31:44 +0800
Message-ID: <20240809083148.1989912-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Make SMC-R can work with rxe devices. This allows us to easily test and
learn the SMC-R protocol without relying on a physical RoCE NIC.

Liu Jian (4):
  rdma/device: export ib_device_get_netdev()
  net/smc: use ib_device_get_netdev() helper to get netdev info
  net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
  RDMA/rxe: Set queue pair cur_qp_state when being queried

 drivers/infiniband/core/core_priv.h   |  3 ---
 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
 include/rdma/ib_verbs.h               |  2 ++
 net/smc/smc_ib.c                      | 10 +++++-----
 net/smc/smc_pnet.c                    |  6 +-----
 6 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.34.1



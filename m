Return-Path: <linux-rdma+bounces-503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010A81FD5E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 07:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D0A1C20CC1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8923B8;
	Fri, 29 Dec 2023 06:56:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809288BE7;
	Fri, 29 Dec 2023 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T1bkN27M8zWl9c;
	Fri, 29 Dec 2023 14:55:56 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 36855140485;
	Fri, 29 Dec 2023 14:56:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 14:56:28 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH iproute2-rc 0/2] Bugfixes for rdmatool
Date: Fri, 29 Dec 2023 14:52:39 +0800
Message-ID: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500006.china.huawei.com (7.221.188.68)

Here are 2 bugfixes for rdmatool.

Chengchang Tang (1):
  rdma: Fix core dump when pretty is used

wenglianfa (1):
  rdma: Fix the error of accessing string variable outside the lifecycle

 rdma/res-cmid.c | 3 +--
 rdma/res-cq.c   | 3 +--
 rdma/res-ctx.c  | 3 +--
 rdma/res-mr.c   | 3 +--
 rdma/res-pd.c   | 3 +--
 rdma/res-qp.c   | 3 +--
 rdma/res-srq.c  | 3 +--
 rdma/stat.c     | 3 +--
 rdma/utils.c    | 6 +++++-
 9 files changed, 13 insertions(+), 17 deletions(-)

--
2.30.0



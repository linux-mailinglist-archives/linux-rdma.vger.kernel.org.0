Return-Path: <linux-rdma+bounces-4829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B652971949
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD42281A24
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE81B7900;
	Mon,  9 Sep 2024 12:27:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9E1B81A2
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884878; cv=none; b=ScXQkqe9LZhDKXIC2HETizMlSTXqQv0qxHW9bzSLKcgXdeDoaaNM39SR4632XfkTV3ABeEE3sCCvI5EtzSQ7KaFp+3E7U5lTy0FPB2pzOatOAi+rPFF76NouDLsi9tCyqK9aBnVipx4OnAScjVS1Z4zaJLCz5d7udbirl7NbmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884878; c=relaxed/simple;
	bh=GkqISCkdt6BghoqOg1UGRchIw7n5D7WpJYI239qj3II=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NyD0kIPTa+DtFFxYubJGEidpMeaWfWzyhYLILloGEd3pzKsdQKRffwz519cHGjHYSDYsC+DLPCkVjzm1Hy968fVXCt557g5MJyDHUqQ7NnaXJBvUKdskVF90hBYzvSJQoi/v1KkUcEUkvzF3jq8CNsbVBYmdqyZhvAT3eZdq38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2R1B1Dtvz1j8Mm;
	Mon,  9 Sep 2024 20:27:26 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id BF6791400DC;
	Mon,  9 Sep 2024 20:27:52 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 20:27:51 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v2 0/2] Remove unused declarations in header files
Date: Mon, 9 Sep 2024 20:14:06 +0800
Message-ID: <20240909121408.80079-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

There are some unused declarations in the header files,
let's remove them.

v2: Fix the spelling error in patch subject of patch [1/2]

Zhang Zekun (2):
  IB/iser: Remove unused declaration in header file
  IB/qib: Remove unused declarations in header file

 drivers/infiniband/hw/qib/qib_verbs.h    | 4 ----
 drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ----
 2 files changed, 8 deletions(-)

-- 
2.17.1



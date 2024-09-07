Return-Path: <linux-rdma+bounces-4805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFC970107
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 10:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF4D1C21C7C
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17E14A0A8;
	Sat,  7 Sep 2024 08:52:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627B17753
	for <linux-rdma@vger.kernel.org>; Sat,  7 Sep 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699128; cv=none; b=CoLUfenLjiWOg8djksMgs3suASDwRfLo50J8Fq1oJa3F1G5lLovtOL7RLzL8nCIEQ2sbarZMq3ewDBGZSnvNGPbshMdnE52iaXGOSHleK88sAocw+WkMUBb/yKboijRgUxZJGaMhjPifN0wWu5/zn3JEHmK0Yf2l1P8ZjUi+5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699128; c=relaxed/simple;
	bh=F9pfAdv0g3CEg3Y5W7ZF7LIqSZt+47c6RwXUbNlGc+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVXiWznEbuNo9kHuQ6pfTqM8/Z2Gj9G8BEpB813M/XpwAh8j7bWQ9a9YyXvAUbCIK8588u9JN3X3TTf4FNxZMwO5paUMjdFSSIwMdY5oecwribNxZ6XNml2gqTL5N1jGj+XwYFdWHeRvs62pfQngEuGqpRH8wEwOwGqZPOd6NnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X16KY0WH4z69PD;
	Sat,  7 Sep 2024 16:52:01 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B2FA01800FE;
	Sat,  7 Sep 2024 16:52:02 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Sep
 2024 16:52:01 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH 0/2] Remove unused declarations in header files
Date: Sat, 7 Sep 2024 16:38:20 +0800
Message-ID: <20240907083822.100942-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

There are some unused declarations in the header files,
let's remove them.

Zhang Zekun (2):
  IB/iser: Remove unused declaration in heder file
  IB/qib: Remove unused declarations in header file

 drivers/infiniband/hw/qib/qib_verbs.h    | 4 ----
 drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ----
 2 files changed, 8 deletions(-)

-- 
2.17.1



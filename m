Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B531D3672
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgENQ0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 12:26:53 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:53519 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgENQ0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 12:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589473611; x=1621009611;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EVvsHX524Q1IlYKwchz7QbXv0VmhYNzShJbCERHze34=;
  b=fnyZ6B9X5d0EljGQ5D9f4wqCcLGdwkI1MxcXT9+3TqGW/ZjcbKyW4cVJ
   /L/3Zw1IRsFhztBIzKnQuyQafnWn/Va6LcFKV0CAKxY8oRz+HxQWeQCvL
   HD614RAQiLRj7VJV+5QYUEVSGkAJgYAtLBDmnnbwAJh2KuH5WA99pPHm5
   c=;
IronPort-SDR: Nl5YZXiZr1PrxOVbNlPhLLIkRNf082RcLHolFM1exXpw2dIzR493IjfP/QiMpJUsbwImZjsDyi
 LHr1kwHxbT1Q==
X-IronPort-AV: E=Sophos;i="5.73,392,1583193600"; 
   d="scan'208";a="30367432"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 14 May 2020 16:00:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 1F1DBA2174;
        Thu, 14 May 2020 16:00:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 16:00:21 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.90) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 16:00:15 +0000
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Max Gurtovoy <maxg@mellanox.com>, <bvanassche@acm.org>,
        <jgg@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <dledford@redhat.com>, <leon@kernel.org>
CC:     <sagi@grimberg.me>, <israelr@mellanox.com>, <shlomin@mellanox.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <995f4a0d-4026-de1e-c604-ca56801e5193@amazon.com>
Date:   Thu, 14 May 2020 19:00:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514120305.189738-1-maxg@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D22UWC001.ant.amazon.com (10.43.162.192) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 14/05/2020 15:02, Max Gurtovoy wrote:
> This series removes the support for FMR mode to register memory. This ancient
> mode is unsafe and not maintained/tested in the last few years. It also doesn't
> have any reasonable advantage over other memory registration methods such as
> FRWR (that is implemented in all the recent RDMA adapters). This series should
> be reviewed and approved by the maintainer of the effected drivers and I
> suggest to test it as well.
> 
> The tests that I made for this series (fio benchmarks and fio verify data):
> 1. iSER initiator on ConnectX-4
> 2. iSER initiator on ConnectX-3
> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> 4. SRP initiator on ConnectX-3
> 
> Not tested:
> 1. RDS
> 2. mthca
> 3. rdmavt

I think there are a few leftovers:

From f289a67b47e03d268469211065bf114cbb1c7125 Mon Sep 17 00:00:00 2001
From: Gal Pressman <galpress@amazon.com>
Date: Wed, 13 May 2020 10:49:09 +0300
Subject: [PATCH] RDMA/mlx5: Remove FMR leftovers

Remove a few leftovers from FMR functionality which are no longer used.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 482b54eb9764..40c461017763 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -675,12 +675,6 @@ struct umr_common {
 	struct semaphore	sem;
 };
 
-enum {
-	MLX5_FMR_INVALID,
-	MLX5_FMR_VALID,
-	MLX5_FMR_BUSY,
-};
-
 struct mlx5_cache_ent {
 	struct list_head	head;
 	/* sync access to the cahce entry
@@ -1253,8 +1247,6 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
 			    struct ib_port_attr *props);
 int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 		       struct ib_port_attr *props);
-int mlx5_ib_init_fmr(struct mlx5_ib_dev *dev);
-void mlx5_ib_cleanup_fmr(struct mlx5_ib_dev *dev);
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
 			int *count, int *shift,
-- 
2.26.2

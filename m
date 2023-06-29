Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068A6741E65
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjF2CkU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 22:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjF2CkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 22:40:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E59268F;
        Wed, 28 Jun 2023 19:40:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qs2hn1JlRzTlXQ;
        Thu, 29 Jun 2023 10:39:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 10:40:13 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
CC:     <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
        <tariqt@nvidia.com>, <gal@nvidia.com>, <rrameshbabu@nvidia.com>,
        <vadfed@meta.com>, <ayal@nvidia.com>, <eranbe@nvidia.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net 0/2] fix two memory leak issues for mlx5en driver
Date:   Thu, 29 Jun 2023 10:46:40 +0800
Message-ID: <20230629024642.2228767-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix two memory leak issues for mlx5en driver:
1. fix memory leak in mlx5e_fs_tt_redirect_any_create
2. fix memory leak in mlx5e_ptp_open

Zhengchao Shao (2):
  net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
  net/mlx5e: fix memory leak in mlx5e_ptp_open

 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3442C497420
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiAWSEI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiAWSDx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C5C06173B;
        Sun, 23 Jan 2022 10:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAEEBB80DE3;
        Sun, 23 Jan 2022 18:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F52C340E2;
        Sun, 23 Jan 2022 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961030;
        bh=ts2goDt9Cb1fJa1SrCDEzzgOvaO1XlVCxltTAtneuPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvs+Slj6Hd3A/T6MNx780kv4NV7f0n1jFLY1D18KqZOvin1u8oCfe07nQMno5c41k
         QFbYznZaEBx53mV/dtqhMIB3fgpg1pNVyOWAD2BztNW9UGr1Y0YqBIceQalUMfqQBs
         JudhUmWlTdT3b1k4/HYsvP01Bfpg3ce2Xve+BLfGjdE9yH/aFZ6CQ1HCQHxvLM3hPM
         KM7SybDxsRNYAdCeSjYSHLue/jc7Rg48Jqt5VTDnFqnhMzdvYbiVbP0sL9lVbaNpOf
         0eNTb2ErCxfUL5iIPEkVi8Fz3LBCdXNrP6LznEdRfwsU9s1bVLCYVORePvjxvEHsN7
         uVDaod+2RSelQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 11/11] RDMA/opa: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:03:00 +0200
Message-Id: <9384bc21bc3b60b340e04746568746dd4cdfa468.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following file.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
index aeff68f582d3..071f35711468 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
@@ -50,7 +50,6 @@
  * netdev functionality.
  */
 
-#include <linux/module.h>
 #include <linux/if_vlan.h>
 #include <linux/crc32.h>
 
-- 
2.34.1


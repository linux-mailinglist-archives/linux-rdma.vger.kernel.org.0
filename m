Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445852CB35
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiESEli (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 00:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiESElh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 00:41:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38B60042;
        Wed, 18 May 2022 21:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C718BB822BF;
        Thu, 19 May 2022 04:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10384C385B8;
        Thu, 19 May 2022 04:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652935293;
        bh=MNXiJdMyPXBvGfEmIk8Ms7ae57/nY6VPzmK+0TnBSI0=;
        h=From:To:Cc:Subject:Date:From;
        b=fbGuHBRLb6LxAJqtP1XUdNdZBg6ThuU7zGlUY1wRApr8g5CGYk4SKk72pBqv95Az6
         pzGwRuoenC5S9PItgos97THKYPbazI93felMIhFZS6KB9J1+9H8/Pjpsj243temr38
         DiD847kG1IUMPBL0+F3ZE08VLBJGs0u6POic/x/P4e8zqE7w9zQ8fd14JQQQFhgfqQ
         Fc7NsnmZtq0PqL9S5XIBhD/kF1wpeTJ1l9NPbOUu+RPvENB9/Pi41WMkHmO2lKpUZ4
         La9rJzokPQMztfZcCBXgTDuUbOCMXh3bAhIIZOtUpL4s0e0db/2lbitmbLtm32dy/2
         82dfTa4IB/k3A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next v1 0/2] Add gratuitous ARP support to RDMA-CM
Date:   Thu, 19 May 2022 07:41:21 +0300
Message-Id: <cover.1652935014.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1: 
 * Removed special workqueue
 * Rewrote compare_netdev_and_ip()
v0: https://lore.kernel.org/all/cover.1649075034.git.leonro@nvidia.com

In this series, Patrisious adds gratuitous ARP support to RDMA-CM, in
order to speed up migration failover from one node to another.

Thanks

Patrisious Haddad (2):
  RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and
    remote IP
  RDMA/core: Add a netevent notifier to cma

 drivers/infiniband/core/cma.c      | 234 +++++++++++++++++++++++++++--
 drivers/infiniband/core/cma_priv.h |   1 +
 include/rdma/rdma_cm.h             |   6 +
 3 files changed, 229 insertions(+), 12 deletions(-)

-- 
2.36.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CA53FD86
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiFGLcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiFGLcx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 07:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C8212D0E;
        Tue,  7 Jun 2022 04:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4374B81F67;
        Tue,  7 Jun 2022 11:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21908C34119;
        Tue,  7 Jun 2022 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654601569;
        bh=G1xOJRnrI7vWtg0lqwYe4nydLW/5JEjU7wyBFucTG98=;
        h=From:To:Cc:Subject:Date:From;
        b=PEPVLtpoBVfqNYb2PIg3Rbb4l/muH7WKkloSjxqBn9eFHqq1ttDjvcNdfEyzAqwWH
         CmfBPrhfhyJ/Sf52TuldOIqnrzcLZcjwpVHG/uX4DnPOa66yP3UDtT0preLETElFIO
         yetDlVdK1+xb6byn+m+Fqcw4SzwPaYhOGHLgkcrGlol/XcpCphFuSphoac5dqZalc/
         ANLvy/WMjv+O8icr/q46XuCWKuR4OtIICvcTE3YlbcPlhkfN/EevYwH2zb9b5WBrQB
         fRqRLYvtJbYjNfftXdx2cjVlXLUA0Puek3TRuRoGJArU0TmQGyywnRNhPGUqcfDU9b
         4RKF0Q6XVoKbg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next v2 0/2] Add gratuitous ARP support to RDMA-CM
Date:   Tue,  7 Jun 2022 14:32:42 +0300
Message-Id: <cover.1654601342.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v2:
 * Patch 1: used memcp and ipv6_addr_cmp
 * Patch 2: removed cma_netevent_work
v1: https://lore.kernel.org/linux-rdma/cover.1652935014.git.leonro@nvidia.com/
 * Removed special workqueue
 * Rewrote compare_netdev_and_ip()
v0: https://lore.kernel.org/all/cover.1649075034.git.leonro@nvidia.com

----------------------------------------------------------------------------

In this series, Patrisious adds gratuitous ARP support to RDMA-CM, in
order to speed up migration failover from one node to another.

Thanks


Patrisious Haddad (2):
  RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and
    remote IP
  RDMA/core: Add a netevent notifier to cma

 drivers/infiniband/core/cma.c      | 230 +++++++++++++++++++++++++++--
 drivers/infiniband/core/cma_priv.h |   1 +
 include/rdma/rdma_cm.h             |   1 +
 3 files changed, 220 insertions(+), 12 deletions(-)

-- 
2.36.1


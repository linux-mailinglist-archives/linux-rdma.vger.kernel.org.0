Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6511EC5B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEOKtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 06:49:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34514 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726347AbfEOKtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:49:35 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 May 2019 13:49:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4FAnVKL025252;
        Wed, 15 May 2019 13:49:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com,
        dledford@redhat.com
Cc:     hch@lst.de, sagi@grimberg.me, maxg@mellanox.com,
        israelr@mellanox.com
Subject: [PATCH 0/7] iser/isert/rw-api cleanups
Date:   Wed, 15 May 2019 13:49:24 +0300
Message-Id: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series include small fixes/cleanups that were discovered during
signature handover new API development.

Israel Rukshin (6):
  IB/iser: Refactor iscsi_iser_check_protection function
  IB/iser: Remove unused sig_attrs argument
  IB/isert: Remove unused sig_attrs argument
  RDMA/rw: Fix doc typo
  RDMA/rw: Print the correct number of sig MRs
  RDMA/core: Fix doc typo

Max Gurtovoy (1):
  RDMA/rw: Add info regarding SG count failure

 drivers/infiniband/core/cq.c              |  4 ++--
 drivers/infiniband/core/rw.c              |  7 ++++---
 drivers/infiniband/core/verbs.c           |  4 ++--
 drivers/infiniband/ulp/iser/iscsi_iser.c  |  9 +++------
 drivers/infiniband/ulp/iser/iser_memory.c | 11 +++++------
 drivers/infiniband/ulp/isert/ib_isert.c   | 11 +++++------
 6 files changed, 21 insertions(+), 25 deletions(-)

-- 
2.16.3


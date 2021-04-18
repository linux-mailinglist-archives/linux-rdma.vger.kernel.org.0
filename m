Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC536359B
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDRNmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDRNmD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:42:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D5E61057;
        Sun, 18 Apr 2021 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753291;
        bh=jSlZWhl+e1+11D+/Qf9IttSq6OQqNHjZt6OLaVYeURM=;
        h=From:To:Cc:Subject:Date:From;
        b=IWdNH+NQ861QHg2Zzr5x1qi2ligNdbxhsqtY3SvjVz9fIdM67AwU4iazdQYV8Gwjr
         jd1yVnmM6rggCDqBJgynwNiSx0LGvtsh9Tvj7k5PUaSbrWMeISasT6MoXaix6QdiIS
         R/n0oc6/Vk1uB1l2eT3hDLofcAs4ZxHPV3GWVvJ8qjtP01vMo8vnB0mxaGppSa00uX
         oS4v+APLS3lYdoVEvx00UgbAaIVwkFTCQ8KYJ0Fvx+GEvJRYYfRF6C94h97mC6dlKn
         Do+CfxrYeuBykOcmObbqW6xppysu2tiXoejsOIOzV3+589eZOjdBysQfadGQYzwcMh
         x6bD7r8h4pnjg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Neta Ostrovsky <netao@nvidia.com>
Subject: [PATCH rdma-next 0/4] Extend nldev interface with contexts and SRQ
Date:   Sun, 18 Apr 2021 16:41:22 +0300
Message-Id: <cover.1618753110.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

This series from Neta extends nldev and restrack to provide an
information about contexts and SRQs.

Thanks

Neta Ostrovsky (4):
  RDMA/nldev: Return context information
  RDMA/restrack: Add support to get resource tracking for SRQ
  RDMA/nldev: Return SRQ information
  RDMA/nldev: Add QP numbers to SRQ information

 drivers/infiniband/core/nldev.c    | 160 +++++++++++++++++++++++++++++
 drivers/infiniband/core/restrack.c |   3 +
 drivers/infiniband/core/verbs.c    |   7 ++
 include/rdma/ib_verbs.h            |   5 +
 include/rdma/restrack.h            |   4 +
 include/uapi/rdma/rdma_netlink.h   |  13 +++
 6 files changed, 192 insertions(+)

-- 
2.30.2


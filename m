Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC33D3B9C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhGWN23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 09:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhGWN23 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 09:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAEA9608FE;
        Fri, 23 Jul 2021 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049342;
        bh=OmOgV2LxwmEpY2a85t9MhbJvDr97ZQPfEs4J2RiaCoU=;
        h=From:To:Cc:Subject:Date:From;
        b=MDDhQRFwI98qGG5rlNYqangP/uDfIZiDKpAfqumai5SBxIUqR4O8hW9zdBpl5T7kd
         mxiwjbghp1opcRewmXfzbVl8nCwgXNokIMGfIDO4IYVSv8Ag0Qw1K6hUziAq6lEDeH
         E/r1myShgzv6PKx9a88HxayWRAxqf0HIka8QZ5Kzv/Vtdk5C8An65qcDiOblIf3u7z
         zjy+iz8flwMmkoj2uXXWsyw1W8Eg2cJm5ynDV6qdJGicKW0uYc71WbkAsUWg9gdm/O
         FBeSAC797RPgglmC0B7B6Jc7RkA7arHhCeYD7dH6qGD1TXUX6dplDpxJOYGEvmEZVQ
         uoyLdOcZdm58g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Tatyana E. Nikolova" <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 0/3] Remove not possible checks
Date:   Fri, 23 Jul 2021 17:08:54 +0300
Message-Id: <cover.1627048781.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The iwpm is part of iw_cm module load, it ensures that iwpm is valid
prior to execution of any commands.

This series deletes such checks.

Thanks

Leon Romanovsky (3):
  RDMA/iwcm: Release resources if iw_cm module initialization fails
  RDMA/iwpm: Remove not-needed reference counting
  RDMA/iwpm: Rely on the upper to ensure that requests are valid

 drivers/infiniband/core/iwcm.c      | 19 ++++---
 drivers/infiniband/core/iwpm_msg.c  | 34 +------------
 drivers/infiniband/core/iwpm_util.c | 78 ++++++-----------------------
 drivers/infiniband/core/iwpm_util.h | 18 -------
 4 files changed, 28 insertions(+), 121 deletions(-)

-- 
2.31.1


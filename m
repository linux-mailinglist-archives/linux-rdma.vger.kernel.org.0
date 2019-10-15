Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DFD7086
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfJOHyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 03:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfJOHyX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 03:54:23 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B82B2089C;
        Tue, 15 Oct 2019 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571126063;
        bh=HHIhJEyA/dch6LecUyx3c+lG4mnKCKwQNypRKbiMHUM=;
        h=From:To:Cc:Subject:Date:From;
        b=DSeWqloix3LL/xzAg2Ly9O1OzSjPJWV/CoPx9ZylKFFQnmcyhpfzedLXyY9skODRD
         /5OgL3gc7KnAHSNxaLe9Q6+T1jZBU7ZVf0ZbmOFa7grN1rExRJWV7v5BW4j34gJ1zf
         YB5ND8YEBizTKbXTFHGvv4P6oEzutpVnZYuoA+tI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 0/2] UAPI cleanup and fix to cxgb3 removal
Date:   Tue, 15 Oct 2019 10:54:17 +0300
Message-Id: <20191015075419.18185-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Chagelog:
 v0->v1: https://lore.kernel.org/linux-rdma/20191010192053.GD11569@mellanox.com
 * Split one patch to two.
 * Added RDMA_DRIVER_CXGB3 back instead of mangling with rdma_driver_id.

Thanks

Yishai Hadas (2):
  RDMA/uapi: Fix and re-organize the usage of rdma_driver_id
  RDMA/uapi: Drop the dependency of ib_user_ioctl_verbs.h on
    ib_user_verbs.h

 include/uapi/rdma/ib_user_ioctl_verbs.h  | 48 +++++++++++++++++++++++-
 include/uapi/rdma/ib_user_verbs.h        | 25 ------------
 include/uapi/rdma/rdma_user_ioctl_cmds.h | 21 -----------
 3 files changed, 47 insertions(+), 47 deletions(-)

--
2.20.1


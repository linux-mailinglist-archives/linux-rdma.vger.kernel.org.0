Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7EF1C6A50
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEFHrG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgEFHrG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCAA206D5;
        Wed,  6 May 2020 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751226;
        bh=Gy838ztyqCG5xOQTV55+0XD3VL4icmY3tcw8oDEYSe8=;
        h=From:To:Cc:Subject:Date:From;
        b=TJzSurVFZBHYjYPslkAFJl8bZoHDihSXjN5If4Wyh1L3BM4s/Aihe7fxiG6U30NvW
         4Mfjx64/at/+615BiVDDJCdCvTZBi1zdnDdnz5FHOJMpel0pZ5/CQfLz0lVuZ1q7zg
         WAMAM8Vye2aLljQt9M/rCPc5vYdFuifml9MGfJH8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 00/10] Various clean ups to ib_cm
Date:   Wed,  6 May 2020 10:46:51 +0300
Message-Id: <20200506074701.9775-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

From Jason,

These are intended to be no-functional change edits that tidy up the
code flow or coding style.

Thanks

Danit Goldberg (1):
  RDMA/cm: Remove unused store to ret in cm_rej_handler

Jason Gunthorpe (9):
  RDMA/addr: Mark addr_resolve as might_sleep()
  RDMA/cm: Remove return code from add_cm_id_to_port_list
  RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
  RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
  RDMA/cm: Add a note explaining how the timewait is eventually freed
  RDMA/cm: Make find_remote_id() return a cm_id_private
  RDMA/cm: Remove the cm_free_id() wrapper function
  RDMA/cm: Remove needless cm_id variable
  RDMA/cm: Increment the refcount inside cm_find_listen()

 drivers/infiniband/core/addr.c |   4 +
 drivers/infiniband/core/cm.c   | 239 +++++++++++----------------------
 2 files changed, 85 insertions(+), 158 deletions(-)

--
2.26.2


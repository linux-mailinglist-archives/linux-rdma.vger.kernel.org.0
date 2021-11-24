Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA845CE39
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhKXUnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 15:43:49 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:51331 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbhKXUns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 15:43:48 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pz3rmRlHqBazopz3umFJDx; Wed, 24 Nov 2021 21:40:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 21:40:33 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] IB/mthca: Cleanup and optimize a few bitmap operation
Date:   Wed, 24 Nov 2021 21:40:09 +0100
Message-Id: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Patch 1 and 2 are just cleanups that uses 'bitmap_zalloc()' and 'bitmap_set()'
instead of hand-writing these functions.

Patch 3 and 4 are more questionable. They replace calls to '[set|clear]_bit()'
by their non-atomic '__[set|clear]_bit()' alternatives.
In both files, it looks safe to do so because accesses to the corresponding
bitmaps are protected by spinlocks.
However, these patches are compile tested only. It not sure it worth changing the
code just for saving a few atomic operations.
So review, test and apply only if it make sense.

Christophe JAILLET (4):
  IB/mthca: Use bitmap_zalloc() when applicable
  IB/mthca: Use bitmap_set() when applicable
  IB/mthca: Use non-atomic bitmap functions when possible in
    'mthca_allocator.c'
  IB/mthca: Use non-atomic bitmap functions when possible in
    'mthca_mr.c'

 drivers/infiniband/hw/mthca/mthca_allocator.c | 15 +++++--------
 drivers/infiniband/hw/mthca/mthca_mr.c        | 22 +++++++++----------
 2 files changed, 15 insertions(+), 22 deletions(-)

-- 
2.30.2


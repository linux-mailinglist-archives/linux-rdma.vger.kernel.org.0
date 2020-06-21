Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED04202A1C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgFUKrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKrn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:47:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBCA248CA;
        Sun, 21 Jun 2020 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736462;
        bh=FfQduBlD0OBzrt9hxsHRl2mmRwsowXdcvSsPszx+CM8=;
        h=From:To:Cc:Subject:Date:From;
        b=qI17qkhJmoculqv9X+fWXHpDdSfzVnphKAnwqrwp2iS/TLjR1+0IiWyba8szmi/WV
         lrdeVGAhrE03DbfJeCMJOqyKivOItkY3G3mTInX3TDBJFVw1i95fYIvdlxntcHNn1Q
         SoWlGO8J4hFYjSxASsIFy052dDrm2VUE0ERCoYHI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Shay Drory <shayd@mellanox.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: [PATCH rdma-next 0/4] Bag of fixes and refactoring in MAD layer
Date:   Sun, 21 Jun 2020 13:47:34 +0300
Message-Id: <20200621104738.54850-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is combination of fixes and refactoring in MAD layer. Because
everything here is "old", I'm sending it to rdma-next and not "wasting"
our time in attempt to separate fix patches from refactoring ones.

Thanks

Shay Drory (4):
  IB/mad: Fix use after free when destroying MAD agent
  IB/mad: Issue complete whenever decrements agent refcount
  IB/mad: Refactor atomics API to refcount API
  IB/mad: Delete RMPP_STATE_CANCELING state

 drivers/infiniband/core/mad.c      | 32 +++++++++++++++---------------
 drivers/infiniband/core/mad_priv.h |  2 +-
 drivers/infiniband/core/mad_rmpp.c | 27 +++++++++----------------
 3 files changed, 26 insertions(+), 35 deletions(-)

--
2.26.2


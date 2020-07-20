Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C638226DB1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgGTR4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgGTR4c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 13:56:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888EF20709;
        Mon, 20 Jul 2020 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595267792;
        bh=3vzlXSdpUDpQCr/J2aKATys7J/5IWPSAhG03kFZ7Z7A=;
        h=From:To:Cc:Subject:Date:From;
        b=cb2G80aN02Q22RZJ7HZyxA7cthcXVY0qoOO32qttK0WptMWMsKYvsFuZ96o9zTPEl
         paxveYoYmbhzuv4B+eQI+WgihcwhBMUHUMHPXNd3t/YOPCN3DZZa+OOtVjOkynAO5z
         60tiDayi0P9HLTAvAeZRXWld6Lihh/X8mTSDBAk8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 0/2] Fix warnings reported by kbuild
Date:   Mon, 20 Jul 2020 20:56:25 +0300
Message-Id: <20200720175627.1273096-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog
v1:
 * Delete "pd" cleanup line
 * Moved all cleaned feilds to be last in declaration list to improve
  readability.
v0:
https://lore.kernel.org/lkml/20200719060319.77603-1-leon@kernel.org
------------------------------------------------------------------
Hi,

There are two change as were reported by kbuild. They are not important
enough to have Fixes line.

Thanks

Leon Romanovsky (2):
  RDMA/uverbs: Remove redundant assignments
  RDMA/uverbs: Silence shiftTooManyBitsSigned warning

 drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--
2.26.2


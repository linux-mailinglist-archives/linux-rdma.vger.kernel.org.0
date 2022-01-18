Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF7492060
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiARHfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 02:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiARHfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 02:35:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD486C06161C;
        Mon, 17 Jan 2022 23:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 688EECE180A;
        Tue, 18 Jan 2022 07:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921AAC00446;
        Tue, 18 Jan 2022 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491309;
        bh=UsbtlUVnZcAQyyfxWjiE6aYMk/ANQVQHATeKT7H2sqs=;
        h=From:To:Cc:Subject:Date:From;
        b=irU+RiFoUC/G4iXxDGK4iaQipgaTgK8cfdAfn/aRIghn2sCuZ8mBkEzWbNm/jFEbh
         GWODk53LV541cx/Cq7LZ2WLYHsVE9PCFgJ7kCI0JYgdxu/14A1Tcb4FYBThSXvy33A
         hXP9exaNvd7QU0snDO4ebeV8DjrvqYtsb69YtwTtQnyeg2Uo5MtqpAzYUySP4E/5KP
         7NHrxjAaNYcj7HQShos2h6jjI4A2RbeGVdBdWYnhwunJLEXRRE+v9P9aaHblDHbQZi
         orT7HmNkkk4VnT80q2krd/pH67OhgLAVNbC5skoEZMzRmjV6AWa7am+Sl/rPbQBSID
         A/RSk/+0lDteA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 0/3] Various fixes in RDMA/core
Date:   Tue, 18 Jan 2022 09:34:59 +0200
Message-Id: <cover.1642491047.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This is compilation of unrelated fixes, one is an outcome of syzkaller
report and other two were found in our regression.

Thanks

Leon Romanovsky (1):
  RDMA/ucma: Protect mc during concurrent multicast leaves

Maor Gottlieb (2):
  RDMA/cma: Use correct address when leaving multicast group
  RDMA/core: Set MR type in ib_reg_user_mr

 drivers/infiniband/core/cma.c   | 61 ++++++++++++++++-----------------
 drivers/infiniband/core/ucma.c  | 34 ++++++++++++------
 drivers/infiniband/core/verbs.c |  1 +
 3 files changed, 54 insertions(+), 42 deletions(-)

-- 
2.34.1


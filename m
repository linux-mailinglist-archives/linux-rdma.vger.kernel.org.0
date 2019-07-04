Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0F5F8DF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGDNJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGDNJm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 09:09:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7228421852;
        Thu,  4 Jul 2019 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245781;
        bh=oGMrApK+0qtwjUv9iwjhOK/1fGZRu9APeJaxmBKvLgs=;
        h=From:To:Cc:Subject:Date:From;
        b=VnJl2r8dvfogzs4NnliuuLzyrtVmSCugSRrNycv8A69Mt+voIFvQGzoSHEhPb/UAP
         g/2vMnKSzDpcNbTtP+WutKFnq7zMcXp+4MxJdOXXfymohQymXuUqPlUI+TnisEhbiG
         DnfcfQRZDvxElKSBuRcCuBD1ce3Tdtayc+EQpbl4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 0/2] Initial code to cleanup RWQ
Date:   Thu,  4 Jul 2019 16:09:34 +0300
Message-Id: <20190704130936.8705-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Inside mlx4 RWQ is integrated into QP, this complicates my deallocation
patches. This is small set of patches which I carried for whole cycle.

Thanks

Leon Romanovsky (2):
  RDMA/mlx4: Separate creation of RWQ and QP
  RDMA/mlx4: Annotate boolean arguments as bool and not int

 drivers/infiniband/hw/mlx4/qp.c | 242 +++++++++++++++++++++-----------
 1 file changed, 157 insertions(+), 85 deletions(-)

--
2.20.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F731EBC24
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFBMzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 08:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBMzz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 08:55:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408E320663;
        Tue,  2 Jun 2020 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591102554;
        bh=h1VSlMeDOSB2oJ5fRPHYFLgzuYatrYBFJIKuKideGPg=;
        h=From:To:Cc:Subject:Date:From;
        b=pQ0CQTSdiF9azd9rWMjMKIYNKkv6P0O5AjEEpa5DPmE5TXQvQu4Zk8fZnUR8ZHw5j
         WB8f+fjx3Z36emNlrurXTuVJFl7yKtr6/ZAFnqUNzrh4Evwuxd6wNdFNTcEDxv+Jz4
         LSJWg0Roj+P/EDQC21zPktVe3bBNNjMnP/TTtlmI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 0/3] mlx5 ECE fixes DC ECE code
Date:   Tue,  2 Jun 2020 15:55:45 +0300
Message-Id: <20200602125548.172654-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This are three patches which I would ask to consider for current PR
to Linus.

First two patches are fixing corner cases that are not possible
in the real life and the third patch is needed to ensure that API
toward user space is feature complete and won't need any extra
ucontext flags.

The code of third patch was already presented in v0 and v1,
but was dropped later.

Leon Romanovsky (3):
  RDMA/mlx5: Return an error if copy_to_user fails
  RDMA/mlx5: Don't rely on FW to set zeros in ECE response
  RDMA/mlx5: Return ECE DC support

 drivers/infiniband/hw/mlx5/qp.c | 59 +++++++++++++++++++++------------
 include/linux/mlx5/mlx5_ifc.h   |  5 +--
 2 files changed, 40 insertions(+), 24 deletions(-)

--
2.26.2


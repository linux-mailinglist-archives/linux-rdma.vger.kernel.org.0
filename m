Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B709298E25
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775617AbgJZNhs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775664AbgJZNhp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:37:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC15721BE5;
        Mon, 26 Oct 2020 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603719465;
        bh=VQ0xbSDsfaAls4Omj+iq9zMdOqUd4hFDkWyt+Qc7+tU=;
        h=From:To:Cc:Subject:Date:From;
        b=KlE2KY5LEfsrDIyFKphBQngRVImK0ydDGKK6UB4cmneh9jfUpD5RGDNomdlzv70lc
         wYeW94vOh7WFS3BePiqYNNcR2H4qTHjJB+62PsDX6zkkt6XBLayXztwLukfgOEH5Fr
         RdHmNomiNrHzeBjwK7XuFBuY5kVvBYWdMMBQrHCA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Meir Lichtinger <meirl@mellanox.com>
Subject: [PATCH rdma-next 0/2] Extra patches with NDR support
Date:   Mon, 26 Oct 2020 15:37:36 +0200
Message-Id: <20201026133738.1340432-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Addition to the IPoIB patches https://lore.kernel.org/linux-rdma/20201026132904.1338526-1-leon@kernel.org/T/#u

Thanks

Meir Lichtinger (2):
  IB/core: Add support for NDR link speed
  IB/mlx5: Add support for NDR link speed

 drivers/infiniband/core/sysfs.c   |  4 ++++
 drivers/infiniband/hw/mlx5/main.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

--
2.26.2


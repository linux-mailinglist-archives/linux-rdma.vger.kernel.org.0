Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9E2A60F0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgKDJxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 04:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgKDJxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 04:53:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC42C0613D3;
        Wed,  4 Nov 2020 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=10NYNDvXK47Xx4pemLtAWVco029+HRxpmX00NcH63GE=; b=NGo9ostWCiYg6sDnjnfEcDzzIu
        bw1JEU/3J8uJGjIQtQ3FGZ9lzz5hIabozqpexq5IduLABu5XJ2D0ympH0erezuMJAke3Q+N9+2j6y
        CQZarVzZ/0rhSi4bUrotHZGNaoSczpDABKXioE9c65Nxmn1Ccoe0A8LOAmfcZ2cUH8twiu62GDa/L
        l5fhVcQKYIfQKjkufFFoYGjsvK2Ox2oFBUmuutOyqSjOR3KNxhsbBO09mBu27EycME4Vq/ONGvnJp
        Ce2DQNYH/udzwjJIRM1gpsiIoXqJH24M/o6dZHhkX4lZ79dU0Es+bWJROyRq5sliVITz95pPA4/5A
        KK0kP2ww==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaFTT-0001yT-E1; Wed, 04 Nov 2020 09:53:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: remove dma_virt_ops
Date:   Wed,  4 Nov 2020 10:50:47 +0100
Message-Id: <20201104095052.1222754-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

this series switches the RDMA core to opencode the special case of
devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
have caused a bit of trouble due to the P2P code node working with
them due to the fact that we'd do two dma mapping iterations for a
single I/O, but also are a bit of layering violation and lead to
more code than necessary.

Tested with nvme-rdma over rxe.

Diffstat:
 b/drivers/infiniband/core/device.c      |   41 +++++++-------
 b/drivers/infiniband/core/rw.c          |    2 
 b/drivers/infiniband/sw/rdmavt/Kconfig  |    3 -
 b/drivers/infiniband/sw/rdmavt/mr.c     |    6 --
 b/drivers/infiniband/sw/rdmavt/vt.c     |    8 --
 b/drivers/infiniband/sw/rxe/Kconfig     |    2 
 b/drivers/infiniband/sw/rxe/rxe_verbs.c |    7 --
 b/drivers/infiniband/sw/rxe/rxe_verbs.h |    1 
 b/drivers/infiniband/sw/siw/Kconfig     |    1 
 b/drivers/infiniband/sw/siw/siw.h       |    1 
 b/drivers/infiniband/sw/siw/siw_main.c  |    7 --
 b/drivers/pci/p2pdma.c                  |   25 ---------
 b/include/linux/dma-mapping.h           |    2 
 b/include/rdma/ib_verbs.h               |   88 ++++++++++++++------------------
 b/kernel/dma/Kconfig                    |    5 -
 b/kernel/dma/Makefile                   |    1 
 kernel/dma/virt.c                       |   61 ----------------------
 17 files changed, 66 insertions(+), 195 deletions(-)

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA92A782A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 08:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgKEHoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 02:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHoa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 02:44:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9150C0613CF;
        Wed,  4 Nov 2020 23:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sdDqJs+tyRqodiImj9cA2noijaJPm3lpR9cgqXfZnTc=; b=ZY41Diy6e0toQAP1LxcHY6dYBZ
        15YTUisplwNmkjfn3i8MJ1+CORNnL8XaNBpvaiOJnWiwIy6gRte5nTHGj1nT5ipDuV+I8GEQJfYSq
        MqbY40NYK66JCTYO84IGJH71Jlh5fdlKwOWKRTBi6KonLRKvfAhPV6Jj9Q3bbmB3vrN3BtNski31P
        81UvbgNgpEOHx4qAwuD5V+zfS7qJizXcOT1k3QKf2Hz0jTZZhsEn0oAJp3MTaHgMxGetRNOccmOI+
        HZI98W3p5DNY1ryVfwFdvLovBJ3VIpcVY+DIf+/UxBwdS3fV63FKXOsSubiivoNCrLHF3I/SWxQ5m
        q6oIQpwQ==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaZwP-0004Ud-Jn; Thu, 05 Nov 2020 07:44:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: remove dma_virt_ops v2
Date:   Thu,  5 Nov 2020 08:41:59 +0100
Message-Id: <20201105074205.1690638-1-hch@lst.de>
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

Changes since v1:
 - disable software RDMA drivers for highmem configs
 - update the PCI commit logs

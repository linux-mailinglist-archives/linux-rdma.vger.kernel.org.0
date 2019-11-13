Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4296FAB00
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfKMHcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 02:32:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHcT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 02:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6DH1QSowvu6LETtPO1B1oHlFjT7uBOtz6fVqlVLip0=; b=RsudJmSmKim0oEYcXcZOUcyhj
        SV3uKDell/ryfxj25r7DQiv8uTeNLQCR6F0ohKS9BCDSwCaH0y3q/z9IOReMlZD+lWHwFy5o9sW53
        0YJSm/VzWwMoTG68nRjiEmMdXGcixFFUQX//Q3kGrgr8N+COGzma7SimVMUIIBnBhTADVkapCD6BX
        GJTtoPdECIAMp/6Qf76tnHRe8Q+rPAcH5U9/ER3sagqqDc885GfUosDC5rQnIbY70O0y13h6Hoc6v
        uOmF4zVa+MhrxPcaxGNIS8e66BEW+8G+6AFwoP6e0xSiOpotQVzq+hGLMmE6zNdlPWlukbSYPsHOd
        yAH70Irqg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUn8R-0006qp-UU; Wed, 13 Nov 2019 07:32:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-rdma@vger.kernel.org
Subject: remove DMA_ATTR_WRITE_BARRIER
Date:   Wed, 13 Nov 2019 08:32:12 +0100
Message-Id: <20191113073214.9514-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
now that the ia64 sn2 code has been removed.  Drop the flag and
the calling convention to set it in the RDMA code.

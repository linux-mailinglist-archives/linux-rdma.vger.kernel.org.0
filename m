Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40B96C247
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGQUpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 16:45:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQUpP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tzGolXl3Y0XjxtKZcsiJxhjFhDqoAVtAwsubLFO8WBo=; b=f08aTSOL2cAJaesMvB06pJjy9
        QDJwoVWms/O4V9aYtTIIPeEYt6yBDh8iamaIgo1lERFE6AsBhNpM9ZWZDCeNQVSivRP1Hey+2KwqD
        ZHSCt8M67DWkGmvp03LDbeenv4pdd9zIeZkRXR+Ey7MS9LiZmI+l6RCVHi2bP1l+/S9TnqgVu6cBW
        Is+qIftxpiZIC/h6Wu5W4ZARae+ZIdPdxgZ471IvQgzWVrpdGmx8uUAKSN1kJYKQxo2HuxwzudfWk
        ZQhW2ytFI6t6ggSjbn2WbXxLiqKJMutJdMVymJlN+0oV+lMZGUz5duv0AVtBID8ppMttkYQRNLC+I
        cdD8XEwOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnqnR-0007qz-Rk; Wed, 17 Jul 2019 20:45:05 +0000
Date:   Wed, 17 Jul 2019 13:45:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717204505.GD32320@bombadil.infradead.org>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717203112.GA7307@lap1>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > Like I said, drivers that require the creating ucontext as part of the
> > PD and MR cannot support sharing.
> 
> Even if we can make sure the process that creates the MR stays alive until
> all reference to this MR completes?

The kernel can't rely on userspace to do that.

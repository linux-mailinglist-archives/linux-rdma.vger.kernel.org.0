Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0389611CEB0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfLLNr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 08:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbfLLNr1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 08:47:27 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127752077B;
        Thu, 12 Dec 2019 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576158446;
        bh=8jARIPs48uIHQQNiDuuXoNKYzXnmQvXLMeBWkTsS+aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVao0AXbwUkQNQu4RTlpR503jiNJk+fM6aUCVbOfhGX9LP+ZemWOvd4GKXFf5UaVT
         dTj1Lz1JDN6J6JILOBXQm4eYrRgF7s3SbqhVHeoUau/y2+jxEQdVnp+JJKkywbf01F
         R1TOS1jlWNrCE1A4hk6tgCA9//ehihVdybHCHgeY=
Date:   Thu, 12 Dec 2019 15:47:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Hirsch <max.hirsch@gmail.com>
Cc:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191212134723.GC67461@unreal>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca>
 <20191212084907.GU67461@unreal>
 <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
 <CADgTo8_mD6Z7WuA7wdEwh+7AR8YOy8nfJeaa2RbEAeftLGod7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgTo8_mD6Z7WuA7wdEwh+7AR8YOy8nfJeaa2RbEAeftLGod7g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 07:28:19AM -0500, Max Hirsch wrote:
> I am happy to make a larger/functional change. From what I read,
> desired patch scope is proportional to linux community involvement but
> if that not how you guys do the infiniband driver that fine. Whats a
> feature you guys want but no one is working on yet, or rather where is
> such a list kept?

I'm assuming that you don't have RDMA HW, so let's start from
compilation only task.

You can start from fixing smatch and sparse compilation warnings.

Smatch:
make -j 32 CHECK=smatch -p=kernel drivers/infiniband
Sparse:
make -j 32 CHECK=sparse C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' -p=kernel drivers/infiniband

And we will be thrilled to see your patches merged.

Thanks

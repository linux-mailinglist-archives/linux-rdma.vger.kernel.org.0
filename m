Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734E87DB0E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfHAMM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 08:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfHAMM6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 08:12:58 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0594720838;
        Thu,  1 Aug 2019 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564661577;
        bh=9WAVVeay9xqRfgYc37iFiKNjitU7N+Pk8Tl5+DRed4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlbXxWgEDmq7arPy+xLcBym0vJagCWEnXTWkhguwPZFCLz0tKbpyp3HAKRjjaXGlS
         /jMBJW9EE98s+smCwioiekM9L89OCsDjDVXVzg6QcmKUw+2eaek0Pcd+V7QLzQBTvc
         +jc/LsdJdGGI6Pro9DcP/qbte6Il3Lc0bPJCQTf0=
Date:   Thu, 1 Aug 2019 15:12:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v3] RDMA/restrack: Track driver QP types in
 resource tracker
Message-ID: <20190801121254.GL4832@mtr-leonro.mtl.com>
References: <20190801104354.11417-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801104354.11417-1-galpress@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 01:43:54PM +0300, Gal Pressman wrote:
> The check for QP type different than XRC has excluded driver QP
> types from the resource tracker.
> As a result, "rdma resource show" user command would not show opened
> driver QPs which does not reflect the real state of the system.
>
> Check QP type explicitly instead of assuming enum values/ordering.
>
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> v3:
> * Reword commit message
> * Change the commit in Fixes: line
>
> v2:
> * Improve commit message
> ---
>  drivers/infiniband/core/core_priv.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Please don't forget rdmatool patch.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F976388A11
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbhESJC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 05:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232558AbhESJCz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 05:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D06610E9;
        Wed, 19 May 2021 09:01:35 +0000 (UTC)
Date:   Wed, 19 May 2021 12:01:33 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH 2/5] RDMA/srp: Add more structure size checks
Message-ID: <YKTT7UfdQqMloYcp@unreal>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512032752.16611-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:27:49PM -0700, Bart Van Assche wrote:
> Before modifying how the __packed attribute is used, add compile time
> size checks for the structures that will be modified.
> 
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

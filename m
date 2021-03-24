Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586F34746F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCXJVi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 05:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231992AbhCXJVf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 05:21:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06DB961A01;
        Wed, 24 Mar 2021 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616577694;
        bh=Z8Xi7Q8XrtT4F7FmogpqExj0J3gLxfayNYnPLUO4ciw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX8HIiJcOggHfRNa7iDGiJ00dV3Dhn50tyxXMh6sG9pKDdFrygcQGGTXaYgrj14LD
         TRihOGZHrFKSV0NYKKlnMJUbzKzp/NkHIc02qgB8f8X1xUBrCYWpN195h85QgPzbxp
         9DJbFxGTPsFk2YTzXVyIIKamwwJK4xgp/R3omLKfXCTkA566OvtEjE3nfcYFqT2GtB
         46zH5pnRi2J169CxexKsMg+/2vj/pesvX0N9iZpz/4EhA4e/xbNdgqMom01x0l67L7
         6AE8Pii5l4t7gLcnhrsDnITah7aIYIruTqgyurLdBArHGcFXsKjk/v1HnWu0JW8wuB
         MWc65FGkOBW7w==
Date:   Wed, 24 Mar 2021 11:21:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] infiniband: Fix a use after free in
 isert_connect_request
Message-ID: <YFsEmqAdFNxEYK7J@unreal>
References: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 09:13:25AM -0700, Lv Yunlong wrote:
> The device is got by isert_device_get() with refcount is 1,
> and is assigned to isert_conn by isert_conn->device = device.
> When isert_create_qp() failed, device will be freed with
> isert_device_put().
> 
> Later, the device is used in isert_free_login_buf(isert_conn)
> by the isert_conn->device->ib_device statement. This patch
> free the device in the correct order.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

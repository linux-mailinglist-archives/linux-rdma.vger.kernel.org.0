Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E054915AF29
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 18:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLRzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 12:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRzD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 12:55:03 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12F520714;
        Wed, 12 Feb 2020 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581530102;
        bh=OCduSffiQi6dj7HxlSi7a5noKg3YLQrxKSmSZIJNmvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDsvwRN03u4BS/lMCbbXAyD1iuywsI37/rFegA+v3Qp3EQbMslku1mbtgh8m+yfc0
         56fXDDe38fLrIboAghGKZ209N59Z9ec/KazWXw+pV30ZYJAu6knAx2aKs0PTsamBAN
         n0xhlwXw1YXO6UOotAjDig3EtQgs0ZvHvmTHLgMg=
Date:   Wed, 12 Feb 2020 19:54:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v8] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200212175458.GE679970@unreal>
References: <1581355065-763-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581355065-763-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 12:17:45PM -0500, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
>
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
>
> The output would look something like below:
> $ ibv_devinfo -v -d bnxt_re2
> hca_id: bnxt_re2
>  transport:             InfiniBand (0)
>  fw_ver:                216.0.220.0
>  node_guid:             b226:28ff:fed3:b0f0
>  sys_image_guid:        b226:28ff:fed3:b0f0
>   .
>   .
>   .
>   .
> 	phys_state:     LINK_UP (5)
> 	GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v1
> 	GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
> 	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v1
> 	GID[  3]:       ::ffff:192.170.1.101, RoCE v2
> $
> $
> $
>
> Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 61 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 12 deletions(-)
>

Devesh,

I see that everyone is happy now, can you please refresh PR so I will
merge it?

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

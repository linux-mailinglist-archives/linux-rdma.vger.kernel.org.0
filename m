Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6F2D242A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgLHHQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgLHHQD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:16:03 -0500
Date:   Tue, 8 Dec 2020 09:15:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607411722;
        bh=JyUtaj5Qbk6CIHZubXUlWVSbjf3SZBEnZ3kd6IWCKko=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GT89sFC/vmEZNUb87GI7AXuj+RmckLUp+EjZq60hqgGjbycwS8nx6l/NMCdtW5lSN
         m8qBwWqZwVGhiv7vescdlniX0mqr27FIv0wcy5oZjF/LWVQHGjfJj6ccQdFj2WnvfT
         MmUSUw3PhNX987YQQX7Pbl0Dqii+3fMywKB9+WBEDhT0LvMlsz8Wve4aaFRChPN68P
         EixwkflRNuQKj56zonKLzJn+1YWAYJo5KQWbIZ72Pk/R79jPWBMlG1OxeIm+GyfMJP
         7ShN+WkwPYOldPE0nqCkR1A0/2eSwwLs1MQGGqur0tfe1CChp87HCO6AJ72pzroOSr
         xvlBEX6pceTFQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v13 3/4] RDMA/uverbs: Add uverbs command for dma-buf
 based MR registration
Message-ID: <20201208071516.GG4430@unreal>
References: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
 <1607379353-116215-4-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607379353-116215-4-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 02:15:52PM -0800, Jianxin Xiong wrote:
> Implement a new uverbs ioctl method for memory registration with file
> descriptor as an extra parameter.
>
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Acked-by: Christian Koenig <christian.koenig@amd.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/infiniband/core/uverbs_std_types_mr.c | 117 +++++++++++++++++++++++++-
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  14 +++
>  2 files changed, 129 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

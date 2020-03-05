Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBD179FF7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 07:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEG1N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 01:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEG1N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 01:27:13 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18B1207FD;
        Thu,  5 Mar 2020 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583389633;
        bh=Jv6fKBzy91As/sT4d9Gnu8mJfL4M2S0GdZ1JQ78EcGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBSi/ctAiAL8aHQYc3x7TYrYTrmjRv0HaIRg42TeoD7xHg+aFW1O9ZJOG7Aee3baj
         geaJ3rUcdE/lFSw+QdlNh+GCQohE6/t7qvLfTmLuT8W1BYQ+0HyuDEQHGdxQb++5gP
         3EDvO0M2WziaIYGNyYPLXgL633bI9ELcKGadc8cY=
Date:   Thu, 5 Mar 2020 08:27:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/5] RDMA/hns: Rename wqe buffer related
 functions
Message-ID: <20200305062710.GR121803@unreal>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583151093-30402-2-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 08:11:29PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
>
> There are serval global functions related to wqe buffer in the hns driver
> and are called in different files. These symbols cannot directly represent
> the namespace they belong to. So add prefix 'hns_roce_' to 3 wqe buffer
> related global functions: get_recv_wqe(), get_send_wqe(), and
> get_send_extend_sge().
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  9 +++++----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  6 +++---
>  4 files changed, 16 insertions(+), 15 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

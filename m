Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D253987C8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFBLRt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 07:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhFBLRt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 07:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABAC261159;
        Wed,  2 Jun 2021 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622632566;
        bh=7YbND9185SS7Z0U8heiIxr2afa3XOL/2hAb0Dxg6Qdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCmZPUhg5MwxDLAJhBgbmJhBVdDMocEgRv+OpLs1pGM2XX7icay1kMhBLTZuXokJx
         i8GG59WJKxOfF8ygEHPwQsnu09pCkOqbuGTDtcrFEvmiiMudq2jlfev9g+Jk3Mkghk
         NTh/QnbT4r0wji1s+LCv+9NfhSdO+QqAVCdLdqQyFgzd2RXaIPQKxm6kMLP8VwqrdI
         gviYSnOJ/kumukR7sfxwpLozEq5lt1eZkiS/9tAlavFkeVK6Ifm0CE39rYApt49ki7
         ZTPqz0zYTDHtm9dNnhMtmb9Eg9hqjPkA2Q2H0pJYyrS/jAUfx9K3ueMVO3Va5+/oX+
         B4Y4FrpbOwKHg==
Date:   Wed, 2 Jun 2021 14:16:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Message-ID: <YLdocig+JjG+nLF+@unreal>
References: <1622193545-3281-1-git-send-email-liweihang@huawei.com>
 <1622193545-3281-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622193545-3281-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:19:04PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Classify the uar address by wrapping the uar type and start page as offset
> for hns rdma io mmap.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 27 ++++++++++++++++++++++++---
>  include/uapi/rdma/hns-abi.h               |  4 ++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 6c6e82b..00dbbf1 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -338,12 +338,23 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
>  	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
>  }
>  
> -static int hns_roce_mmap(struct ib_ucontext *context,
> -			 struct vm_area_struct *vma)
> +/* command value is offset[15:8] */
> +static inline int hns_roce_mmap_get_command(unsigned long offset)
> +{
> +	return (offset >> 8) & 0xff;
> +}
> +
> +/* index value is offset[63:16] | offset[7:0] */
> +static inline unsigned long hns_roce_mmap_get_index(unsigned long offset)
> +{
> +	return ((offset >> 16) << 8) | (offset & 0xff);
> +}

Let's follow the common practice and don't introduce inline functions in .c files.

Thanks

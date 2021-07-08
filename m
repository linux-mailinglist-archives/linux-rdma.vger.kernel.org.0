Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060693C1532
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhGHOdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 10:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHOdk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Jul 2021 10:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3499B61435;
        Thu,  8 Jul 2021 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625754658;
        bh=HEYk/QiJI91wYz8G7ZmN5OLxls4Jr+zuyhDUNu6+blc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qmj//imX/4Dk6Wef4NOV56RhJKHeoO8tmuVPZKCKFFjWAL5ots2+bqkkCjJvC+gn9
         XdCR8WWv/54QH5Y9kKxb+VC9wb354ab6zvHGjiZkJhs/zXnOz2F4zyRvwyrx6awJv2
         l9pt0v6GoeOvvtO1GHufOYNqSNMBQ+O7mne3ulcs4i71YKOkjXKuSn5t53ZFvMS9y9
         O4zy7mnOugiDfgf7lNlPhusFSBItGcgUKxUOFEkn/TIxh8e3rrUvCbkg6t7k6UuLO3
         pqk2AZFkQ+uD/YsuBrURIK2IU7n+wusiy5Qh+fkE5895PhJu6otx3TyYHS0lI/VVSI
         QHJi64UCckkMA==
Date:   Thu, 8 Jul 2021 17:30:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rdma-next] irdma: Fix unused variable total_size warning
Message-ID: <YOcMH3sQwQJ8+dWX@unreal>
References: <20210707211455.2076-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707211455.2076-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 07, 2021 at 02:14:55PM -0700, Tatyana Nikolova wrote:
> Fix the following unused variable warning:
> >> drivers/infiniband/hw/irdma/uk.c:934:6: warning: variable 'total_size'
> set but not used [-Wunused-but-set-variable]
>            u32 total_size = 0, wqe_idx, i, byte_off;
> 
> Link: https://lkml.org/lkml/2021/7/1/726
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

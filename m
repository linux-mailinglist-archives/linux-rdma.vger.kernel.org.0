Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6A3AE3E8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUHMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 03:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhFUHMr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 03:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6235A6008E;
        Mon, 21 Jun 2021 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624259434;
        bh=60zyZKkeS4PheN+CLhNG3jyMRVLtqrW3EFK4648okEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS0DJmOVenc0SNqrnmBO9PjTZzDvoUso/fl2nUofp9n74OkHW1dKuiQzci/uYoWpL
         KA0iYjNGVnCe4BeXTHk3Qi39nvMFf3T7SLzSITjGT5hfMBHdqv6LU4FmCMC6AKQcDI
         GPRF+6mMNaULJVDkz3zwEWO2fsO3EfR/OmaoPNtz6V+adGBcCLF972GuDaM39NWK5i
         k6kx7jDcrmFpeqsqrjAuR6iftwdvt7KPeo3kfjmslh0TbaV8Y8ns85Jwffiar+zmnv
         /mva6Mx2pYRBcjHHAg12Ku/RkMqXcSsrRFoGhMVGm71Ao9czjYIXKndoyPLf3mUjAJ
         ksWJw8cUMEgPw==
Date:   Mon, 21 Jun 2021 10:10:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <YNA7ZnKIKC217pCw@unreal>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 02:59:25PM +0200, Håkon Bugge wrote:
> The struct rdma_id_private contains three bit-fields, tos_set,
> timeout_set, and min_rnr_timer_set. These are set by accessor
> functions without any synchronization. If two or all accessor
> functions are invoked in close proximity in time, there will be
> Read-Modify-Write from several contexts to the same variable, and the
> result will be intermittent.
> 
> Replace with a flag variable and an inline function for set with
> appropriate memory barriers and the use of test_bit().
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Hans Westgaard Ry<hans.westgaard.ry@oracle.com>
> 
> ---
> 	v1 -> v2:
> 	   * Removed define wizardry and replaced with a set function
>              with memory barriers. Suggested by Leon.
> 	   * Removed zero-initialization of flags, due to kzalloc(),
>              as suggested by Leon
> 	   * Review comments from Stefan implicitly adapted due to
>              first bullet above
> 	   * Moved defines and inline function from header file to
>              cma.c, as suggested by the undersigned
> 	   * Renamed enum to cm_id_priv_flag_bits as suggested by the
>              undersigned
> ---
>  drivers/infiniband/core/cma.c      | 38 +++++++++++++++++++++++++-------------
>  drivers/infiniband/core/cma_priv.h |  4 +---
>  2 files changed, 26 insertions(+), 16 deletions(-)

This patch generates checkpatch warnings.

➜  kernel git:(rdma-next) git checkpatch
WARNING: line length of 86 exceeds 80 columns
#69: FILE: drivers/infiniband/core/cma.c:1149:
+	if ((*qp_attr_mask & IB_QP_TIMEOUT) && test_bit(TIMEOUT_SET, &id_priv->flags))

WARNING: line length of 98 exceeds 80 columns
#73: FILE: drivers/infiniband/core/cma.c:1152:
+	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && test_bit(MIN_RNR_TIMER_SET, &id_priv->flags))

WARNING: line length of 86 exceeds 80 columns
#127: FILE: drivers/infiniband/core/cma.c:3048:
+	u8 tos = test_bit(TOS_SET, &id_priv->flags) ? id_priv->tos : default_roce_tos;

WARNING: line length of 84 exceeds 80 columns
#136: FILE: drivers/infiniband/core/cma.c:3096:
+	route->path_rec->packet_life_time = test_bit(TIMEOUT_SET, &id_priv->flags) ?

0001-RDMA-cma-Replace-RMW-with-atomic-bit-ops.patch total: 0 errors, 4 warnings, 118 lines checked

Thanks

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C081CF36C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 13:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELLfQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 07:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgELLfQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 07:35:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9720E20675;
        Tue, 12 May 2020 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589283316;
        bh=P7eMbrUq15vQdiM1bNI481V7lujoIsI5a1ns2Jp/lDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1awXp2Qut9kNHUWHLs9CF7AX8Oe3V+Ii5wLgq3yoTejTXo5yZTI1nBRv+YwEEpNW
         BWkG+0YvxGiEujJTaLUKEAb+//OIVQtpcGlGm/gGRO8aXdTxQWFqxnUapGZqS6qrJP
         oMXR8Sp64D2pzIKDJEl8SQDa1caKjSQ9GYBZjTjo=
Date:   Tue, 12 May 2020 14:35:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Questions about masked atomic
Message-ID: <20200512113512.GK4814@unreal>
References: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 01:54:48PM +0000, liweihang wrote:
> Hi All,
>
> I have two questions about masked atomic (Masked Compare and Swap & MFetchAdd):
>
> 1. The kernel now supports masked atomic, but the it does not support atomic
>    operation. Is the masked atomic valid in kernel currently?

Yes, it is valid, but probably has a very little real value for the kernel ULPs.
I see code in the RDS that uses atomics, but it says nothing to me, because
upstream RDS and version in-real-use are completely different.

> 2. In the userspace, ofed does not have the corresponding opcode for the masked
>    atomic (IB_WR_MASKED_ATOMIC_CMP_AND_SWP, IB_WR_MASKED_ATOMIC_FETCH_AND_ADD),
>    and ibv_send_wr also has no related data segment for it. How to support it in
>    userspace?

ibv_send_wr is not extensible, so the real solution will need to extend ibv_wr_post() [1]
with specific and new post builders.

Thanks

[1] https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_wr_post.3.md

>
> Thanks
> Weihang

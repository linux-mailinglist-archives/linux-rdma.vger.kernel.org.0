Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8403FC6E1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Aug 2021 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhHaLzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Aug 2021 07:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhHaLzp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Aug 2021 07:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAB4C6101B;
        Tue, 31 Aug 2021 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630410890;
        bh=Ox0lhZCByUP4QsMjn41XmjOtaZGdBI7+jmZMUNxd1Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+8AjalRMjshTjba6XLqfVoBwFC7mw5twndfVHD9xTm2H6KTDrHRzwzWGkLr/qFu9
         8RneQhk/EWBnFAuDLC0zFbR02AXHGY2KZnp2oEonOyb5F7bVGpLIo28W6FN/VbUoYf
         mhFjeksqOQ/b7dCyd1V+nw4/tkSy7vICxB3FLwGElLEihO6uNaUgrnK7pfsi1vcmvh
         tiEJAtCJ81ziiofl3BaRdpE45y8DQjkPL3iXkzl0ubkSHRF23LjCvp8sIlzO6oy4E/
         WFPIzTa4xeiWewrDcMqAzCqoU9vdEj27iX2YuMQOw2Zd0nLR2kaFq5EdYr/zYcJBpb
         mg0ExdK2VcD9g==
Date:   Tue, 31 Aug 2021 14:54:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junji Wei <weijunji@bytedance.com>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com
Subject: Re: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
Message-ID: <YS4YhjUvveSsf7iG@unreal>
References: <20210831083223.65797-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831083223.65797-1-weijunji@bytedance.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 31, 2021 at 04:32:23PM +0800, Junji Wei wrote:
> The port->attr.port_cap_flags should be set to enum
> ib_port_capability_mask_bits in ib_mad.h,
> not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.
> 
> Signed-off-by: Junji Wei <weijunji@bytedance.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

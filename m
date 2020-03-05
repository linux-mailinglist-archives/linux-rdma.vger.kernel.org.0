Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D93179FFF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 07:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCEGck (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 01:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEGck (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 01:32:40 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C3D207FD;
        Thu,  5 Mar 2020 06:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583389959;
        bh=TvswHJxU+L1YVWZ27DhgclicHorHIUMUMMNNf77QPPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWxWEiBYH5PeErT1qljFsDs8kEafYUyUUa3GCWaiEsS7u6Hukmtab3Vr4DOlTbkj5
         18SetS7l+tfHXDAWxwpeom0V8VKW4yOF6uYMYt9vc6VDMrSP+uYVIBpgJfepezABOq
         KD0ckuG2n901Fumwb2400fOtaDf+kV0ssmAedMr0=
Date:   Thu, 5 Mar 2020 08:32:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/5] RDMA/hns: Optimize wqe buffer filling
 process for post send
Message-ID: <20200305063236.GS121803@unreal>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583151093-30402-3-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 08:11:30PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
>
> Encapsulates the wqe buffer process details for datagram seg, fast mr seg
> and atomic seg.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 63 +++++++++++++++---------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

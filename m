Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8021B348BBD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYImh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 04:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhCYImQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 04:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2A4661554;
        Thu, 25 Mar 2021 08:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616661735;
        bh=8BmTA3ub1pYlhQEcXFfrSDTG7Y2GKEZiM0u4f6noAXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4lhCA6tikTPB6kAtU0Ubhg6iFGSo9RV8sqNvYGgrvHFxurxo+6ZkMTCZUDDuLkan
         wa5mrrxRMWc33AnYoKxv60bXXsjZi03XdnC+EMJo2nC416h9K0I81z9O7KvWnKE56D
         rccHWOgzywpHCaGLji0p0JPykFpN0zVs41ZwPFoMQg/1SEOZR60fToweGV+bbALGeD
         oADFafpVYkv4xqjKQEeuA0H2VkeVfIehtfuqIIsV8Td49Uiuu3Z9Rx3IbIY1l6L9fV
         k0ecOY2wwdWTpIlZRNTlxiBZURkY0/zsV8KE1d0Qy3ODe6eVGNCRzF48fKBFQ7TKQc
         uZgcVkdvmrc2A==
Date:   Thu, 25 Mar 2021 10:42:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-rc] RDMA/cxgb4: Fix adapter LE hash errors while
 destroying ipv6 listening server
Message-ID: <YFxM5IUaYiTl2gN2@unreal>
References: <20210324190453.8171-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324190453.8171-1-bharat@chelsio.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 12:34:53AM +0530, Potnuri Bharat Teja wrote:
> Not setting ipv6 bit while destroying ipv6 listening servers may result in
> potential fatal adapter errors due to lookup engine memory hash errors.
> Therefore always set ipv6 field while destroying ipv6 listening servers.
> 
> Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v0:
> - modified commit description to inform the severity of patch.
> Changes since v1:
> - removed extra variable as per Leon.
> ---
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE8375306
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhEFL3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 07:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhEFL3A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 May 2021 07:29:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77247613DD;
        Thu,  6 May 2021 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620300482;
        bh=iAvCLI0QgrSKRIHtueO+lDVrsdRyE4/p0ECjyc/xNVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9oDDof4EuZhuXygVwaCBMXPEENGf8UZQHIzz34XhJT63dVIScuCTJwVUokXcl/B0
         5U6PbmmYY9WD2RQsgGHiaPRpVy6ZdnATUzyS9wvowx+XT5ohrFRsa0+ehC2HdDVVhC
         I9G2EhB2dr9Radg7a2oVJVKXcZkVeoNil6cTruLatFwOkRalT6OtlBuHnhn85VXOmR
         aUBdQSMew9R/n0N/EjA1Z5gyu//nGZwxp2996Z7TPdbH/yK7hnrCcCNbkbDWJ+MKTf
         4TTJu73nVO3IV92phdJleacVRPY3PZAUjkqdPuK0E3nDvwMp5sGRR5UZ8fI/YUhuC4
         zW22EfqNyEqpA==
Date:   Thu, 6 May 2021 14:27:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Message-ID: <YJPSvu5c8K5ACSI+@unreal>
References: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 10:31:44AM +0200, Håkon Bugge wrote:
> Both the PKEY and GID tables in an HCA can hold in the order of
> hundreds entries. Reading them are expensive. Partly because the API
> for retrieving them only returns a single entry at a time. Further, on
> certain implementations, e.g., CX-3, the VFs are paravirtualized in
> this respect and have to rely on the PF driver to perform the
> read. This again demands VF to PF communication.
> 
> IB Core's cache is refreshed on all events. Hence, filter the refresh
> of the PKEY and GID caches based on the event received being
> IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> v1 -> v2:
>    * Changed signature of ib_cache_update() as per Leon's suggestion
>    * Added Fixes tag as per Zhu Yanjun' suggestion
> ---
>  drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 5c9fac7..1493a60 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1472,10 +1472,12 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  }
>  
>  static int
> -ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
> +ib_cache_update(struct ib_device *device, u8 port, bool update_gids,
> +		bool update_pkeys, bool enforce_security)
>  {
>  	struct ib_port_attr       *tprops = NULL;
> -	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
> +	struct ib_pkey_cache      *pkey_cache = NULL;
> +	struct ib_pkey_cache      *old_pkey_cache = NULL;
>  	int                        i;
>  	int                        ret;
>  
> @@ -1492,14 +1494,16 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  		goto err;
>  	}
>  
> -	if (!rdma_protocol_roce(device, port)) {
> +	if (!rdma_protocol_roce(device, port) && update_gids) {

Can you please elaborate why it is safe to do for IB_EVENT_GID_CHANGE only?
What about IB_EVENT_CLIENT_REREGISTER?

Thanks

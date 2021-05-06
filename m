Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24437502B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhEFHaS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 03:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232271AbhEFHaS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 May 2021 03:30:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC06E61168;
        Thu,  6 May 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620286160;
        bh=qH9/1zy4/HPvGOYuu/Wqa4rqzmfEtgUbAqORQ4vEWqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qt4n2qmoa/t/xJTZhMNZaJOj4dVbrTD7+0pviGPSwXgSYVRVwSY61JIez9kOqzi1b
         jB+hrYSj8q75PGc/dB0bkZxrN/hKjq9Cq/UuwKBxAyXmi7kz/vIr3z+cucW/fQYkgP
         fwS3kqxxRD+sbBx+TURAErw0CMHRvUkYAch+d+CazzJfdhI4DR7BQ2FlIT0O9n9sno
         gcHERilkBXFzNYz92JezO0ONUQFbeSBo1UwhzKmU44Yt6nVf9/G60AH4Gj9VYbUETO
         raf6N3ZTM3/x4t+ITAo1iyZ8lVx3tlmdh0FN3fy9SvDF6AfkPZX3ZNrlNalYDNZ4/0
         cSWOx3ztrUK2w==
Date:   Thu, 6 May 2021 10:29:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
Message-ID: <YJOazOU65fI/WMwN@unreal>
References: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 04, 2021 at 01:46:24PM +0200, Håkon Bugge wrote:
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
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 5c9fac7..531ae6b 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1472,10 +1472,14 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  }
>  
>  static int
> -ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
> +ib_cache_update(struct ib_device *device, u8 port, enum ib_event_type event,
> +		bool reg_dev, bool enforce_security)
>  {
>  	struct ib_port_attr       *tprops = NULL;
> -	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
> +	struct ib_pkey_cache      *pkey_cache = NULL;
> +	struct ib_pkey_cache      *old_pkey_cache = NULL;
> +	bool			   update_pkey_cache = (reg_dev || event == IB_EVENT_PKEY_CHANGE);
> +	bool			   update_gid_cache = (reg_dev || event == IB_EVENT_GID_CHANGE);

I'm not super excited to see "events" in this function and would be more
happy to see it is handled in ib_cache_event_task() while the function
signature will be:
ib_cache_update(struct ib_device *device, u8 port, bool all_gids, bool
all_pkeys, bool enforce_security)

Thanks

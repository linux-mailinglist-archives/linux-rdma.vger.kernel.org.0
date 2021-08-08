Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8D3E3991
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Aug 2021 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhHHIfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Aug 2021 04:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhHHIfA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Aug 2021 04:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 430BC604DC;
        Sun,  8 Aug 2021 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628411682;
        bh=k2wjbETkNtMg28D7+B6BxIWnqmG2EWrUgRKdVK3vb/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsgdJD1mbuYrilm2V6TRcsbefxwZTyGjAfpMOEoy/TRcWNg9pwvNn5FEGdeQBkwtc
         oFCgZuKv7YxuruUGWzhU/9LHeBVJ0WskNi5XR+w14GrqYNvGzVzUDcrD3M1rN8aKkC
         e53gsCQljmA1gnkbpxymPav5GYq1xnaLvy41EA3sO8XnImDfvXUK1s2HsAI2YUrH7I
         i04fXyAVSjWbq0oB2tJgI2X/ebu6B1gtQaNB5gDVzP1ZEG5PGySK6aLP56adpFrYQf
         FBYQLHg64CzHO7WgexPWggD1CvvqE3UqXLq2OEstfA12R3Z6Jk1eUnBgexW8rPmetu
         CGQ5g6HzNyrNA==
Date:   Sun, 8 Aug 2021 11:34:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, jinpu.wang@ionos.com
Subject: Re: [PATCH v2 for-next 1/6] RDMA/rtrs-clt: During add_path change
 for_new_clt according to path_num
Message-ID: <YQ+XHe4yvcBq0t3q@unreal>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
 <20210806112112.124313-2-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806112112.124313-2-haris.iqbal@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 01:21:07PM +0200, Md Haris Iqbal wrote:
> When all the paths are removed for a session, the addition of the first
> path is like a new session for the storage server.
> 
> Hence, for_new_clt has to be set to 1.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index ece3205531b8..a7b450715eaf 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -3083,6 +3083,18 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
>  	if (IS_ERR(sess))
>  		return PTR_ERR(sess);
>  
> +	mutex_lock(&clt->paths_mutex);
> +	if (clt->paths_num == 0) {
> +		/*
> +		 * When all the paths are removed for a session,
> +		 * the addition of the first path is like a new session for
> +		 * the storage server
> +		 */
> +		sess->for_new_clt = 1;
> +	}

I don't like the sysfs mix in connection establishment flow, but at
least it is locked now.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1781C3DD0B5
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhHBGkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 02:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGka (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 02:40:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D85660F39;
        Mon,  2 Aug 2021 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627886420;
        bh=Col9JMMWe4S8DpI2otNkcY1Yr6S0x+VV8AcISm18DN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGH3uvFYIwyPUlOhKwJmPxZiSOIqpE7l1FxsCKRWeRqgWOO6Mb0uHDLDsdeEpi8O5
         CjK3CgDXFn2kY2wc0t2Q2AhNMnYALFpR0+/0gD7OEnwPC3wcI7a60jG0c9HsGwT9vA
         0sWyOKbWgo2nDSDW+BqNJF5Bo12FYqMdiC3UUduHID1Wjs4DQVygYJFn2TZ+KSNGQD
         1KlWgV7LjK19CEzYeC/jerdQA/MXzHBVjkoAEdDsAx7GYKiNfRqeOq73kuGNcDfOP4
         YpNt2ag90DFu6uweXUrHT04yQYqxzjmcw97WlruYgNQJ0cWtrRL2oVz4NEoghHKV+6
         3d/cUYi5jtd4A==
Date:   Mon, 2 Aug 2021 09:40:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com
Subject: Re: [PATCH for-next 01/10] RDMA/rtrs-clt: During add_path change
 for_new_clt according to path_num
Message-ID: <YQeTUUMJNpyohHX/@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-2-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-2-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:23PM +0200, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
> When all the paths are removed for a session, the addition of the first
> path is like a new session for the storage server.
> 
> Hence, for_new_clt has to be set to 1.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index ece3205531b8..e048bfa12755 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -3083,6 +3083,15 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
>  	if (IS_ERR(sess))
>  		return PTR_ERR(sess);
>  
> +	if (clt->paths_num == 0) {

Don't you need some protection to read paths_num?
rcu_read_lock() or mutex_lock?

Thanks

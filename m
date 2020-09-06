Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29E25ED42
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 09:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIFHqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 03:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgIFHqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 03:46:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6533A2083E;
        Sun,  6 Sep 2020 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599378411;
        bh=cY00kCQqt2uV1GPssRj4mqjo7+DaMW8Vqep3PDF1zwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUJhBHbUEuYUldKS8C6mqbulcA8/G+tjOFrt9dsvOokdb2QxFyLqXtxUKkjx3W248
         KZfMPVHECE1sED9DftxWsJ70WNBbWKJufMjqNvc1wyq1W1EfBwtquIItYFxyd6Qp0D
         QArbzzv3jWeseOTubQN175VzNZBBLl/nRg1IsuOQ=
Date:   Sun, 6 Sep 2020 10:46:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH] RDMA/rtrs-srv: Set .release function for rtrs srv device
 during device init
Message-ID: <20200906074647.GF55261@unreal>
References: <20200904133038.335680-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904133038.335680-1-haris.iqbal@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 07:00:38PM +0530, Md Haris Iqbal wrote:
> The device .release function was not being set during the device
> initialization. This was leading to the below warning, in error cases when
> put_srv was called before device_add was called.
>
> Warning:
>
> Device '(null)' does not have a release() function, it is broken and must
> be fixed. See Documentation/kobject.txt.
>
> So, set the device .release function during device initialization in the
> __alloc_srv() function.
>
> Fixes: baa5b28b7a474 ("RDMA/rtrs-srv: Replace device_register with..")

Please don't truncate Fixes line, many of us rely on full line for automation.

Thanks

> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 --------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 2f981ae97076..cf6a2be61695 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -152,13 +152,6 @@ static struct attribute_group rtrs_srv_stats_attr_group = {
>  	.attrs = rtrs_srv_stats_attrs,
>  };
>
> -static void rtrs_srv_dev_release(struct device *dev)
> -{
> -	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> -
> -	kfree(srv);
> -}
> -
>  static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>  {
>  	struct rtrs_srv *srv = sess->srv;
> @@ -172,7 +165,6 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
>  		goto unlock;
>  	}
>  	srv->dev.class = rtrs_dev_class;
> -	srv->dev.release = rtrs_srv_dev_release;
>  	err = dev_set_name(&srv->dev, "%s", sess->s.sessname);
>  	if (err)
>  		goto unlock;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index b61a18e57aeb..28f6414dfa3d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1319,6 +1319,13 @@ static int rtrs_srv_get_next_cq_vector(struct rtrs_srv_sess *sess)
>  	return sess->cur_cq_vector;
>  }
>
> +static void rtrs_srv_dev_release(struct device *dev)
> +{
> +	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
> +
> +	kfree(srv);
> +}
> +
>  static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
>  				     const uuid_t *paths_uuid)
>  {
> @@ -1337,6 +1344,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
>  	srv->queue_depth = sess_queue_depth;
>  	srv->ctx = ctx;
>  	device_initialize(&srv->dev);
> +	srv->dev.release = rtrs_srv_dev_release;
>
>  	srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
>  			      GFP_KERNEL);
> --
> 2.25.1
>

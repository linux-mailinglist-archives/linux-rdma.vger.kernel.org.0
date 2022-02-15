Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BF4B76B6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiBOSpH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:45:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiBOSpG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:45:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F3DB493
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08408B8124E
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 18:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A78C340EB;
        Tue, 15 Feb 2022 18:44:52 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:44:49 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 2/3] ib_srp: Protect the target list with a mutex instead
 of a spinlock
Message-ID: <Ygv0od2d8wXdBLj/@unreal>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215182650.19839-3-bvanassche@acm.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 10:26:49AM -0800, Bart Van Assche wrote:
> This patch makes the next patch in this series easier to read.

It is not readability change, but move to lock that can sleep (mutex),
which is always good thing.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 18 +++++++++---------
>  drivers/infiniband/ulp/srp/ib_srp.h |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index e174e853f8a4..2db7429b42e1 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1062,9 +1062,9 @@ static void srp_remove_target(struct srp_target_port *target)
>  	kfree(target->ch);
>  	target->ch = NULL;
>  
> -	spin_lock(&target->srp_host->target_lock);
> +	mutex_lock(&target->srp_host->target_mutex);
>  	list_del(&target->list);
> -	spin_unlock(&target->srp_host->target_lock);
> +	mutex_unlock(&target->srp_host->target_mutex);
>  
>  	scsi_host_put(target->scsi_host);
>  }
> @@ -3146,9 +3146,9 @@ static int srp_add_target(struct srp_host *host, struct srp_target_port *target)
>  	rport->lld_data = target;
>  	target->rport = rport;
>  
> -	spin_lock(&host->target_lock);
> +	mutex_lock(&host->target_mutex);
>  	list_add_tail(&target->list, &host->target_list);
> -	spin_unlock(&host->target_lock);
> +	mutex_unlock(&host->target_mutex);
>  
>  	scsi_scan_target(&target->scsi_host->shost_gendev,
>  			 0, target->scsi_id, SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
> @@ -3203,7 +3203,7 @@ static bool srp_conn_unique(struct srp_host *host,
>  
>  	ret = true;
>  
> -	spin_lock(&host->target_lock);
> +	mutex_lock(&host->target_mutex);
>  	list_for_each_entry(t, &host->target_list, list) {
>  		if (t != target &&
>  		    target->id_ext == t->id_ext &&
> @@ -3213,7 +3213,7 @@ static bool srp_conn_unique(struct srp_host *host,
>  			break;
>  		}
>  	}
> -	spin_unlock(&host->target_lock);
> +	mutex_unlock(&host->target_mutex);
>  
>  out:
>  	return ret;
> @@ -3898,7 +3898,7 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&host->target_list);
> -	spin_lock_init(&host->target_lock);
> +	mutex_init(&host->target_mutex);
>  	init_completion(&host->released);
>  	mutex_init(&host->add_target_mutex);
>  	host->srp_dev = device;
> @@ -4041,10 +4041,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
>  		/*
>  		 * Remove all target ports.
>  		 */
> -		spin_lock(&host->target_lock);
> +		mutex_lock(&host->target_mutex);
>  		list_for_each_entry(target, &host->target_list, list)
>  			srp_queue_remove_work(target);
> -		spin_unlock(&host->target_lock);
> +		mutex_unlock(&host->target_mutex);
>  
>  		/*
>  		 * Wait for tl_err and target port removal tasks.
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
> index 55a575e2cace..2af968277994 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.h
> +++ b/drivers/infiniband/ulp/srp/ib_srp.h
> @@ -116,14 +116,14 @@ struct srp_device {
>   * One port of an RDMA adapter in the initiator system.
>   *
>   * @target_list: List of connected target ports (struct srp_target_port).
> - * @target_lock: Protects @target_list.
> + * @target_mutex: Protects @target_list.
>   */
>  struct srp_host {
>  	struct srp_device      *srp_dev;
>  	u8			port;
>  	struct device		dev;
>  	struct list_head	target_list;
> -	spinlock_t		target_lock;
> +	struct mutex		target_mutex;
>  	struct completion	released;
>  	struct list_head	list;
>  	struct mutex		add_target_mutex;

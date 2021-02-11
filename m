Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA804318690
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBKIzl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 03:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBKIzc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Feb 2021 03:55:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDAB664E16;
        Thu, 11 Feb 2021 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613032984;
        bh=YmQzhsxYoZpIL6rh9TIiXZaq/b9ot/tXAc1IfxpKIi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMJLxG1HKfUfBszfmarkuVIh9GinrqMdaDtSzwbOSCbuE4YaWGRdOYk/P7oCXrKta
         yxUngjDdsb7RabrA8wzGnG6dznnTblGVJi7dxip4xx5A8YW4Ww7HlNv56395sRRyvq
         4PAphi5VyMUCHpal9HyUfZgQ8u/RrnI96ILGgxKwdnQjPLf7cno495XaeNnUooTZvH
         kJZ/tY0QSL3UjQv/+FGD+T3SyBqBh0MIkZE2hj2SLiJI6pyWf6PwKrDQexuhobubp6
         t7VFyY/uJewNQj4uz5zee+NGjraga5/lcwoO+iw/jKeySUBkIf5NMgmSodI+QrGb0J
         bMFueDIxJRhVQ==
Date:   Thu, 11 Feb 2021 10:43:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: Re: [PATCH for-next 2/4] RDMA/rtrs: Only allow addition of path to
 an already established session
Message-ID: <20210211084300.GB1275163@unreal>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-3-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211065526.7510-3-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 07:55:24AM +0100, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
>
> While adding a path from the client side to an already established
> session, it was possible to provide the destination IP to a different
> server. This is dangerous.
>
> This commit adds an extra member to the rtrs_msg_conn_req structure, named
> first_conn; which is supposed to notify if the connection request is the
> first for that session or not.
>
> On the server side, if a session does not exist but the first_conn
> received inside the rtrs_msg_conn_req structure is 1, the connection
> request is failed. This signifies that the connection request is for an
> already existing session, and since the server did not find one, it is an
> wrong connection request.
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  5 +++++
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 ++++++++++++++++-----
>  4 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 7644c3f627ca..a110e520b0a4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -31,6 +31,8 @@
>   */
>  #define RTRS_RECONNECT_SEED 8
>
> +#define FIRST_CONN 0x01
> +
>  MODULE_DESCRIPTION("RDMA Transport Client");
>  MODULE_LICENSE("GPL");
>
> @@ -1660,6 +1662,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
>  		.cid_num = cpu_to_le16(sess->s.con_num),
>  		.recon_cnt = cpu_to_le16(sess->s.recon_cnt),
>  	};
> +	msg.first_conn = sess->for_new_clt ? (FIRST_CONN & 0xff) : 0;

Why do you need this "&"? You can directly set FIRST_CONN.

>  	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
>  	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
>
> @@ -2662,6 +2665,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
>  			err = PTR_ERR(sess);
>  			goto close_all_sess;
>  		}
> +		sess->for_new_clt = true;
>  		list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
>
>  		err = init_sess(sess);
> @@ -2913,6 +2917,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
>  	if (IS_ERR(sess))
>  		return PTR_ERR(sess);
>
> +	sess->for_new_clt = false;
>  	/*
>  	 * It is totally safe to add path in CONNECTING state: coming
>  	 * IO will never grab it.  Also it is very important to add
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> index a97a068c4c28..3f1a05373470 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> @@ -143,6 +143,7 @@ struct rtrs_clt_sess {
>  	int			max_send_sge;
>  	u32			flags;
>  	struct kobject		kobj;
> +	bool			for_new_clt;

Let's not add bool to structs.

>  	struct rtrs_clt_stats	*stats;
>  	/* cache hca_port and hca_name to display in sysfs */
>  	u8			hca_port;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index d5621e6fad1b..8caad0a2322b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -188,7 +188,9 @@ struct rtrs_msg_conn_req {
>  	__le16		recon_cnt;
>  	uuid_t		sess_uuid;
>  	uuid_t		paths_uuid;
> -	u8		reserved[12];
> +	u8		first_conn : 1;
> +	u8		reserved_bits : 7;
> +	u8		reserved[11];
>  };
>
>  /**
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index e13e91c2a44a..2538a84fe5fc 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1333,10 +1333,12 @@ static void free_srv(struct rtrs_srv *srv)
>  }
>
>  static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> -					   const uuid_t *paths_uuid)
> +					  const uuid_t *paths_uuid,
> +					  bool first_conn)
>  {
>  	struct rtrs_srv *srv;
>  	int i;
> +	int err = -ENOMEM;

You can avoid this "err" thing and return ERR or NULL directly and check
IS_ERR_OR_NULL() later. Or you shouldn't overwrite an error after
get_or_create_srv() call.

>
>  	mutex_lock(&ctx->srv_mutex);
>  	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
> @@ -1346,12 +1348,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
>  			return srv;
>  		}
>  	}
> +	/*
> +	 * If this request is not the first connection request from the
> +	 * client for this session then fail and return error.
> +	 */
> +	if (!first_conn) {
> +		err = -ENXIO;
> +		goto err;
> +	}

Are you sure that this check not racy?

Thanks

>
>  	/* need to allocate a new srv */
>  	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
>  	if  (!srv) {
>  		mutex_unlock(&ctx->srv_mutex);
> -		return NULL;
> +		goto err;
>  	}
>
>  	INIT_LIST_HEAD(&srv->paths_list);
> @@ -1386,7 +1396,8 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
>
>  err_free_srv:
>  	kfree(srv);
> -	return NULL;
> +err:
> +	return ERR_PTR(err);
>  }
>
>  static void put_srv(struct rtrs_srv *srv)
> @@ -1787,12 +1798,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  		goto reject_w_econnreset;
>  	}
>  	recon_cnt = le16_to_cpu(msg->recon_cnt);
> -	srv = get_or_create_srv(ctx, &msg->paths_uuid);
> +	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
>  	/*
>  	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
>  	 * allocate srv, but chunks of srv are not allocated yet.
>  	 */
> -	if (!srv || refcount_read(&srv->refcount) == 0) {
> +	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
>  		err = -ENOMEM;
>  		goto reject_w_err;
>  	}
> --
> 2.25.1
>

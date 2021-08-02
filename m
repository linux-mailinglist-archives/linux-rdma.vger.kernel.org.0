Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2453DD124
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHBHaI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhHBHaH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 03:30:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D48660EFF;
        Mon,  2 Aug 2021 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627889398;
        bh=UD/+xAtE30wIhwOMYSK3AgA3kbfPNrbgUq/zlF21ESw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPn4fqGgzlYFrA4Tam9blvDgq4GU+CoBrMJfFlvdiz8gMR6eiJeuoTUj/tKczbLr+
         +gFpsAVnnaZAv/CxNSp1VzKBFrCZfiFPebg3JxMaOTuv55P++4v3nzvQiG02zhEzqD
         tSqYfenFw+q4Wk2C9xlrFgzTRPHWntUPRgMXGq2oZeB5nB65Z/MGTGtmtuec5z6ZPT
         RjXksaFGduO2d7rmgY+b05lV/yu7aiDYTDgD+0IyZJdZswnA9rviWotAhLSvHTVY8m
         c8PxFugFW+kOl31oQVcglmEZvZY7MxRlOH3Kl8LdutkkEESOmsumXlVKYfxi+eTEvr
         kYzlbwOcgLRAg==
Date:   Mon, 2 Aug 2021 10:29:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB
 port on the storage side
Message-ID: <YQee8091rXaXU4vL@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-10-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-10-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:31PM +0200, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> This commit adds support to reject connection on a specific IB port which
> can be specified in the added sysfs entry for the rtrs-server module.
> 
> Example,
> 
> $ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port
> 
> When a connection request is received on the above IB port, rtrs_srv
> rejects the connection and notifies the client to disable reconnection
> attempts. A manual reconnect has to be triggerred in such a case.
> 
> A manual reconnect can be triggered by doing the following,
> 
> echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 ++++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 82 +++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 5cce727abca0..21001818e607 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1898,6 +1898,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
>  				    struct rdma_cm_event *ev)
>  {
>  	struct rtrs_sess *s = con->c.sess;
> +	struct rtrs_clt_sess *sess = to_clt_sess(s);
>  	const struct rtrs_msg_conn_rsp *msg;
>  	const char *rej_msg;
>  	int status, errno;
> @@ -1916,6 +1917,15 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
>  			rtrs_err(s,
>  				  "Connect rejected: status %d (%s), rtrs errno %d\n",
>  				  status, rej_msg, errno);
> +
> +		if (errno == -ENETDOWN) {
> +			/*
> +			 * Stop reconnection attempts
> +			 */
> +			sess->reconnect_attempts = -1;
> +			rtrs_err(s,
> +				"Disabling auto-reconnect. Trigger a manual reconnect after issue is resolved\n");
> +		}
>  	} else {
>  		rtrs_err(s,
>  			  "Connect rejected but with malformed message: status %d (%s)\n",
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index cc65cffdc65a..90d833041ccf 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -32,7 +32,9 @@ MODULE_LICENSE("GPL");
>  static struct rtrs_rdma_dev_pd dev_pd;
>  static mempool_t *chunk_pool;
>  struct class *rtrs_dev_class;
> +static struct device *rtrs_dev;
>  static struct rtrs_srv_ib_ctx ib_ctx;
> +static char disabled_port[NAME_MAX];
>  
>  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
>  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> @@ -1826,6 +1828,20 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  	u16 recon_cnt;
>  	int err = -ECONNRESET;
>  
> +	if (strnlen(disabled_port, NAME_MAX) > 0) {
> +		char ib_device[NAME_MAX];
> +
> +		snprintf(ib_device, NAME_MAX, "%s %u", cm_id->device->name, cm_id->port_num);
> +		if (strncmp(disabled_port, ib_device, NAME_MAX) == 0) {
> +			/*
> +			 * Reject connection attempt on disabled port
> +			 */
> +			pr_err("Error: Connection request on a disabled port");
> +			err = -ENETDOWN;
> +			goto reject_w_err;
> +		}
> +	}
> +
>  	if (len < sizeof(*msg)) {
>  		pr_err("Invalid RTRS connection request\n");
>  		goto reject_w_err;
> @@ -2242,6 +2258,56 @@ static int check_module_params(void)
>  	return 0;
>  }
>  
> +static ssize_t disable_port_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr,
> +				 char *page)
> +{
> +	return sysfs_emit(page, "%s\n", disabled_port);
> +}
> +
> +static ssize_t disable_port_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	int ret, len;
> +
> +	if (count > 1 && strnlen(disabled_port, NAME_MAX) > 0) {
> +		pr_err("A disabled port already exists.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = strscpy(disabled_port, buf, NAME_MAX);
> +	if (ret == -E2BIG) {
> +		pr_err("String too big.\n");
> +		disabled_port[0] = '\0';
> +		return ret;
> +	}
> +
> +	len = strlen(disabled_port);
> +	if (len > 0 && disabled_port[len-1] == '\n')

All the "\n" checks in rtrs sysfs looks like cargo cult. You don't need
them.

And maybe Jason thinks differently, but I don't feel comfortable with
such new sysfs file at all.

Thanks

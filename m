Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C97377651
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 13:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhEILZl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 07:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhEILZk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 07:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA7D6103E;
        Sun,  9 May 2021 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620559477;
        bh=auwZhnyW/M77uakxaR1YDYa/QNiaOQiNwDwCLPqSzXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sC3aaTVwqrkg+uYFsX7b75wPttWmPMN14BHVbVKKrJTdhsDHjy7+BjKLF/MFDP3su
         z8pL1ZOxG6pjDx8yYlQnX5UykOZ5lPjwkNqlvnfafwljr1+YAOs8J7SSEVY8SPRh+H
         BVpOP5sj1KcHk4BvO3XaQ+bVxTOUDBjavwZsyTMinIBZiHVQum2++oQM4LbDMs1Ojb
         LW7BClsQUfKG+acGp+HEvNe3TPPuCuRA5aplrJWq239KBRqlMLSxsmx2L+baxRWEU0
         wVXQQeoVlYFbN0FF9gwpMGkKTxybnGmlHUSyi34KH97vXaiqy7ZyT+AxtAO710QyQ8
         oyIbg24werSuw==
Date:   Sun, 9 May 2021 14:24:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
Message-ID: <YJfGcFlJCHrf2quT@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-4-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503114818.288896-4-gi-oh.kim@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> The queue_depth size is sent from server and
> server already checks validity of the value.

Do you trust server? What will be if server is not reliable and sends
garbage?

Thanks

> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 930a1b496f84..0c828ea0f500 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1772,12 +1772,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
>  	}
>  	if (con->c.cid == 0) {
>  		queue_depth = le16_to_cpu(msg->queue_depth);
> -
> -		if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
> -			rtrs_err(clt, "Invalid RTRS message: queue=%d\n",
> -				  queue_depth);
> -			return -ECONNRESET;
> -		}
>  		if (!sess->rbufs || sess->queue_depth < queue_depth) {
>  			kfree(sess->rbufs);
>  			sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
> -- 
> 2.25.1
> 

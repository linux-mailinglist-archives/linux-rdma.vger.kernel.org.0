Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA812119A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLPRUG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 12:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRUG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Dec 2019 12:20:06 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6903206D3;
        Mon, 16 Dec 2019 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576516805;
        bh=uhkK0kjjspF+7fIgNOsOoqK9HjWXXtd5A4jX5WhTyGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXBHhZAtC5FX1NVOMMWpgnGLc2gje4r2jFI7fUm5sZgva09UO74TLc83IybXJVIVD
         xcnNKVZ1eYL2+yN1KBTakOu/6i1hMuM4Gl/l/H64Ch14thYml65lxzMwBAPKgcDtW/
         MHX6LGihhnPoh5gvQL80G5aX5FvEMN9QNoMc1gGk=
Date:   Mon, 16 Dec 2019 19:20:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: [PATCH RDMA/netlink v2] RDMA/netlink: Adhere to returning zero
 on success
Message-ID: <20191216172002.GB66555@unreal>
References: <20191216120436.3204814-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216120436.3204814-1-haakon.bugge@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 16, 2019 at 01:04:36PM +0100, Håkon Bugge wrote:
> In rdma_nl_rcv_skb(), the local variable err is assigned the return
> value of the supplied callback function, which could be one of
> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
> ib_nl_handle_ip_res_resp(). These three functions all return skb->len
> on success.
>
> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
> functions used by the latter have the convention: "Returns 0 on
> success or a negative error code".
>
> In particular, the statement (equal for both functions):
>
>    if (nlh->nlmsg_flags & NLM_F_ACK || err)
>
> implies that rdma_nl_rcv_skb() always will ack a message, independent
> of the NLM_F_ACK being set in nlmsg_flags or not.
>
> The fix could be to change the above statement, but it is better to
> keep the two *_rcv_skb() functions equal in this respect and instead
> change the callback functions in the rdma subsystem to the correct
> convention.
>
> Suggested-by: Mark Haywood <mark.haywood@oracle.com>
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Tested-by: Mark Haywood <mark.haywood@oracle.com>
> Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
>
> ---
>     v1 -> v2:
>        * Realized sk_buff::len is unsigned, hence simply returning
>          zero in the good case
> ---
>  drivers/infiniband/core/addr.c     | 2 +-
>  drivers/infiniband/core/sa_query.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Better to put Fixes above *-by tags.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

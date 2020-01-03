Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D312FD83
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 21:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgACUSU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 15:18:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40492 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACUSU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 15:18:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so34724534qkg.7
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/SuMkHj7+ThlVsdmv0RHwqpRTcGZVz19UjyYDmvGlZg=;
        b=Kt2ACKby1vQQzWvNU6nyh7PaIPULNuiPXpeiJtXNc44W8+PyQVbzyOG//QTnlNniYk
         cQxv4GFKA4fzJxIMRha6UWO3tK9GZKFuX/QiC468WCwYBwUso4NT1cvukLbqOfrRzmkt
         Tcw12xCxY8Xa/ZJja4TwEowEeZXcm7vaU2mksvLMt0IdLtP6fNE+IkbVhkXB+R74azQy
         q1XorcdF+C/kHTw85Zp6QLvCleOAm1u1KVoY43pl7Znr9lbbIDWeOr7TgPSP/9olkXw9
         vjdVxT3ffQBnBlPTBiwqucYjZuyzSK55XArPxHhi/o3ik9cvK1hiKaEuK6z58zzJM36g
         KV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/SuMkHj7+ThlVsdmv0RHwqpRTcGZVz19UjyYDmvGlZg=;
        b=naVUiEEfOSqVRQ6zezIKc6pTKzot3Xz3iqKNPTBrjwOgqzCHPye5vkl5/dX9WlUyZI
         Vo+IhbIVR+yHHxv/N/kDm0vRQ9rQWMt0uoSpHygm60g3wQAW40un84yAV9x7eXE76E6Z
         epopEFBWE9GRWKRzHtWn/rLPBqM0UM3zfkhTZmfaP1wmvjSKwNBv6yBmR3isgMy7AAwi
         7PAJ4tt5F73Q2IBjCxpW1Mu6yxxbGrEZzBXx7/9Ye7rt1jhNuuKuXnCWSEDtXAYC7ow/
         USOYIn9XiSRKVG6isWg4BKhccxqKUj/Sbu7mNiWpRJWftNuiqghjn+fz/Kyozve/xBon
         uxTw==
X-Gm-Message-State: APjAAAX8JQbgkZQIuw0JJdr91mn4wjnEAkHy09bqhRk5OMsrCVNvNSd6
        1PzlSaXGMczs1Qcu7Md5fnZHFLxUm8Y=
X-Google-Smtp-Source: APXvYqzIciOXmDJz/atH2y8JfHvAGNsqTnk9qIQJGU657CBZQXyYMrbcZvVbeQiItB82q/2tpDjUKw==
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr73503848qko.379.1578082228523;
        Fri, 03 Jan 2020 12:10:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e3sm17485353qtj.30.2020.01.03.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:10:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTH9-00031e-Cl; Fri, 03 Jan 2020 16:10:27 -0400
Date:   Fri, 3 Jan 2020 16:10:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: [PATCH RDMA/netlink v2] RDMA/netlink: Adhere to returning zero
 on success
Message-ID: <20200103201027.GA11554@ziepe.ca>
References: <20191216120436.3204814-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216120436.3204814-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> ---
>     v1 -> v2:
>        * Realized sk_buff::len is unsigned, hence simply returning
>          zero in the good case
> ---
>  drivers/infiniband/core/addr.c     | 2 +-
>  drivers/infiniband/core/sa_query.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason

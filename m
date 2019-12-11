Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18D11AB16
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 13:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfLKMj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 07:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfLKMj7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Dec 2019 07:39:59 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D0F208C3;
        Wed, 11 Dec 2019 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576067998;
        bh=csSGn3PoUnO/r+IBGg1YuxZ0hmkWF1NmuAiyHhY0vpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YJJPwsMWnFNDnXdP1lXwPnNbiamOvsTJ+TJmD7vYR8usM0gVbAkMcv2mocBIjsOX
         gk8AatOqTJ9fB8QPtIsMBAdrEZH9aQvxJ7V53Jaer1xtO1Q69ILXam5i6DCwpZVjTk
         Cg6w/UV/WT5EWP3ilGD9dM0duLwaLI4nnxHDlOxY=
Date:   Wed, 11 Dec 2019 14:39:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
Message-ID: <20191211123955.GS67461@unreal>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211103400.2949140-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 11:34:00AM +0100, Håkon Bugge wrote:
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

The more accurate description is that rdma_nl_rcv_skb() always generates
NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK flag is
requested to get acknowledges for the success.

>
> The fix could be to change the above statement, but it is better to
> keep the two *_rcv_skb() functions equal in this respect and instead
> change the callback functions in the rdma subsystem to the correct
> convention.

AFAIR, RTNETLINK has the same implementation as RDMA netlink.

Thanks

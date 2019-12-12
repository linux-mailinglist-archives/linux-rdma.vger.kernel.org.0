Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4111CC68
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfLLLkm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfLLLkl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:40:41 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B5720663;
        Thu, 12 Dec 2019 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150841;
        bh=pEu+Cc1QNs0QUWXgdqZjPhTXKBGcvxYkhrWHAllck8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySfmO0XaN6to3xCbTNWSJaLodUSRvO4NQqzJwuIJtzDNuVMIP3E336aLngSdWPLXr
         8xcZGMxMQ7mZZBcVojYV8Lr4UiWgIqmrQaNu+pPnRaRa6OcJi1RKoKDGZ6joIikSYl
         N1Q9CUzsMRYxsZkq6jRnIsABvoUDwXHpPZRWUAJs=
Date:   Thu, 12 Dec 2019 13:40:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
Message-ID: <20191212114038.GX67461@unreal>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
 <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 08:31:18PM +0100, Håkon Bugge wrote:
>
>
> > On 11 Dec 2019, at 14:13, Håkon Bugge <haakon.bugge@oracle.com> wrote:
> >
> >
> >
> >> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> wrote:
> >>
> >> On Wed, Dec 11, 2019 at 11:34:00AM +0100, Håkon Bugge wrote:
> >>> In rdma_nl_rcv_skb(), the local variable err is assigned the return
> >>> value of the supplied callback function, which could be one of
> >>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
> >>> ib_nl_handle_ip_res_resp(). These three functions all return skb->len
> >>> on success.
> >>>
> >>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
> >>> functions used by the latter have the convention: "Returns 0 on
> >>> success or a negative error code".
> >>>
> >>> In particular, the statement (equal for both functions):
> >>>
> >>>  if (nlh->nlmsg_flags & NLM_F_ACK || err)
> >>>
> >>> implies that rdma_nl_rcv_skb() always will ack a message, independent
> >>> of the NLM_F_ACK being set in nlmsg_flags or not.
> >>
> >> The more accurate description is that rdma_nl_rcv_skb() always generates
> >> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK flag is
> >> requested to get acknowledges for the success.
>
>
> Yes. And when, lets say a legitimate path record response, containing N positive bytes, is sent back from ibacm to the kernel, rdma_nl_rcv_skb() think this is an error, due to "if (nlh->nlmsg_flags & NLM_F_ACK || err)" _and_ ib_nl_handle_resolve_resp() returning N.

How did you test this patch?
Do we have open-source applications which don't set NLM_F_ACK for
ib_nl_*() calls?

Thanks

>
> Thxs, Håkon
>
>
> >>
> >>>
> >>> The fix could be to change the above statement, but it is better to
> >>> keep the two *_rcv_skb() functions equal in this respect and instead
> >>> change the callback functions in the rdma subsystem to the correct
> >>> convention.
> >>
> >> AFAIR, RTNETLINK has the same implementation as RDMA netlink.
> >
> > With the exception of the callback functions, as noted above.
> >
> >
> > Thxs, Håkon
> >
> >>
> >> Thanks
> >
>

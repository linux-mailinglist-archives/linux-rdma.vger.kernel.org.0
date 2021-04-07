Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78ED356D3A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhDGNYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 09:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhDGNYA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 09:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5A89610F9;
        Wed,  7 Apr 2021 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617801831;
        bh=glDTpFWsjXaPAX5cDsVGzFOhXcu7CKth3Uatim+bGRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1d+nHkpWF41Srq1g2hnlxFWfvGkBPXxYFwGVCFJua/i05YCQTLuBQr4hrzXJuanF
         bREahJc7JKxfmz7vyEUN1kz7epXGD/ZGOclGg/4PS2ahocQ1kWxrElbNwpTo2Zdyj4
         0+VX5eeelUMSpGdbUk6WXkaHNkedsWWOAV/M0bML8WhT/mJe5n8PVh+4HPeJh8rp8h
         NKAQSiWULe9VyHWy6jM2Svb7LskkbuDvTteHfXq+QfM6NvpBggAEPXy7i6CEfqGDLy
         9TmtFrn0V9HoFJ9iSN95XpEEM65qQ0Cdue0TthrMKF/+GPqndyWK7p6gHuYtiim8l9
         AZ6WsGj7dLyZg==
Date:   Wed, 7 Apr 2021 16:23:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH for-next v2] RDMA/nldev: Add copy-on-fork attribute to
 get sys command
Message-ID: <YG2yY2PW2AJgA02J@unreal>
References: <20210407101606.80737-1-galpress@amazon.com>
 <YG2n/nDhhQEGefFq@unreal>
 <6d62496e-6bc7-4981-d3ef-5035c6fee93b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d62496e-6bc7-4981-d3ef-5035c6fee93b@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 04:14:46PM +0300, Gal Pressman wrote:
> On 07/04/2021 15:39, Leon Romanovsky wrote:
> >> @@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >>
> >>       err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
> >>                         nldev_policy, extack);
> >> -     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
> >> +     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
> >> +         tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
> > 
> > Why do we fail if user supplies RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK?
> 
> It's a read-only attribute, if someone tries to set its value I assume it's best
> to return an error.

Not in netlink world, you need to ignore the parameters that
you don't "know how to handle" and check for must-to-be input only.

Thanks

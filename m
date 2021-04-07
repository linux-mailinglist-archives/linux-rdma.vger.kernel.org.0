Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98855356D86
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbhDGNki (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 09:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhDGNkg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 09:40:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6C7A61246;
        Wed,  7 Apr 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617802826;
        bh=KlbN04+cEFA5CF9X9b1TdNQ4x82GwVP8XKUOWLwXhZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iy3RQWo4wxekEI4EKZBMQ8WKLID3GOJGCVDzLGv9y01GLGsmjPrAdA4SSLcYYt6Xq
         4VrxY7giUM+uwLVKde/4aOUqgGxXYxYj4+Iy6Poi0mSZnuzQZfra15EH1Nhng35FOl
         MwSvWi9Fg+5Un83Alhwi8jnaXXCGjNZKEVAl71dDJtrhhEqIzeR0bYunYcpWtJjt3z
         /4LrYo4inzRAuz/yuGprs59r+SE3vfn/3Eoz4KhnGxVqu/8AI9AGPOA6bmGPni4h/v
         xgkc8/S6BF3M3U8rQ4OOpv69D/MLeWiTLqFFsPks2/Bqak+5+5FMEK+0etXFWvWZbQ
         F2p/2ev59WstA==
Date:   Wed, 7 Apr 2021 16:40:22 +0300
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
Message-ID: <YG22Rm1jcYcKWXdT@unreal>
References: <20210407101606.80737-1-galpress@amazon.com>
 <YG2n/nDhhQEGefFq@unreal>
 <6d62496e-6bc7-4981-d3ef-5035c6fee93b@amazon.com>
 <YG2yY2PW2AJgA02J@unreal>
 <010c6b45-a9b0-67c7-82e3-78533a532225@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010c6b45-a9b0-67c7-82e3-78533a532225@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 04:30:50PM +0300, Gal Pressman wrote:
> On 07/04/2021 16:23, Leon Romanovsky wrote:
> > On Wed, Apr 07, 2021 at 04:14:46PM +0300, Gal Pressman wrote:
> >> On 07/04/2021 15:39, Leon Romanovsky wrote:
> >>>> @@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >>>>
> >>>>       err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
> >>>>                         nldev_policy, extack);
> >>>> -     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
> >>>> +     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
> >>>> +         tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
> >>>
> >>> Why do we fail if user supplies RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK?
> >>
> >> It's a read-only attribute, if someone tries to set its value I assume it's best
> >> to return an error.
> > 
> > Not in netlink world, you need to ignore the parameters that
> > you don't "know how to handle" and check for must-to-be input only.
> 
> Not sure I understand.
> So you expect the set function to remain unchanged in this patch? Isn't it bad
> that a user can request to change the copy on fork value and get a success
> return value although nothing happened?

The same goes for all netlink attributes, user can send some *_RES_*
attribute to _set_ and we won't fail. The same goes for rtnetlink too.

Thanks

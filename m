Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B152FBE0E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbhASO7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 09:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394218AbhASNfn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 08:35:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A320D21D7F;
        Tue, 19 Jan 2021 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611063302;
        bh=Zmdb06aKMXvtXcbO2kaNUiTEoQr6daIVyTpw3LAIf4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6723nCzYhHeDXDjG+ytGihFuAy5PJoWv/Zi2ce6Wl7HCNzYT+Zkgobqq30SYH/yw
         tgm5LcYoTmxHVuB3PEX3dpXJK5Dd/cFq2Au9zgIVmZlqmeZ+HixGGXQkcMVKIsDP9h
         xXSfBPIc4lFb2UugO99T+/FAE6TFOzlscH3CQQmF5A5Nwrym9d0X2JBIgjRt7bSLE1
         T8t9NuDkP1113RCT9OciQOhO9kEzfbnfQ6V34X3I5YzlhtQddZMB5M2fvqgqy/6kvm
         iV78XMxyxn9eJCJcx8dO2NJaysOM1OFejfi5ufHkmy6hhcoGEF7EFc7Sf4C9b2OmPg
         quCeIQZSkgmqw==
Date:   Tue, 19 Jan 2021 15:34:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210119133458.GK21258@unreal>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210119084632.GI21258@unreal>
 <91c354f0-ada7-85d5-8496-122a3a54354a@amazon.com>
 <20210119115808.GJ21258@unreal>
 <1cb7058a-0bde-943b-64b7-d2a39337a085@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb7058a-0bde-943b-64b7-d2a39337a085@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 03:19:15PM +0200, Gal Pressman wrote:
> On 19/01/2021 13:58, Leon Romanovsky wrote:
> > On Tue, Jan 19, 2021 at 11:10:59AM +0200, Gal Pressman wrote:
> >> On 19/01/2021 10:46, Leon Romanovsky wrote:
> >>> On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> >>>> On 05/01/2021 12:43, Gal Pressman wrote:
> >>>>> The following two patches add the userspace version to the host
> >>>>> information struct reported to the device, used for debugging and
> >>>>> troubleshooting purposes.
> >>>>>
> >>>>> PR was sent:
> >>>>> https://github.com/linux-rdma/rdma-core/pull/918
> >>>>>
> >>>>> Thanks,
> >>>>> Gal
> >>>>
> >>>> Anything stopping this series from being merged?
> >>>
> >>> It is unclear when this forwarding of non-verbs data to the FW will stop.
> >>
> >> This was already discussed in the PR. Not everything should be passed through
> >> this interface, there should be a limit and it should be examined per case.
> >> rdma-core version is clearly related to an RDMA device.
> >
> > "Clearly or not" - it depends on the observer.
> >
> >>
> >> BTW, if you have any concerns about a patch you can state them, you don't have
> >> to ignore it and wait for the submitter to ask what's wrong..
> >
> > Didn't you mistake me with anyone else?
>
> No, you decided to answer my original question :).
>
> > I'm reviewer in the kernel exactly like you and it gives me nice thing - ignore patches.
>
> Don't get me wrong, your review is very appreciated, but this series is 20 LOC
> which you already reviewed two weeks ago, and I replied to all comments.
> Ignoring patches is fine, but please don't review, ignore and wait for the last
> minute to say they shouldn't be merged.

Sorry, but it is impossible to get it right.

I gave you hint WHY it takes so long, it is not review/ack/nack or
anything like this.

Thanks

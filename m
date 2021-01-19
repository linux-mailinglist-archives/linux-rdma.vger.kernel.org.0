Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B42FB897
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbhASNQp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392145AbhASL6x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 06:58:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44D1623104;
        Tue, 19 Jan 2021 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611057493;
        bh=JweHzevrolWM5kXjB9Lfgw0EaAsgBY/Yh8gSFboi1Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3ddP+TecdXoO8ax32O8z43fb+iJz9/0v4At8+0q4RDS5NVmofoMEOBdffoettUXb
         GFwpeROzdGBZ4RMT0PzKgA44PeJdfqT2jFHjHwmuQ2qle2dRSvwXTmUpfTW3+uOauk
         87XTiOjJnTFC7xTbN5lPR/O43W7TxCV5Nl2f6P/ZRZ64UizEdLVZjwB7W18lwNHruc
         4wP/+DmpocvjwrKFPAvL1LqSSLhg9WHgYWcrWNRWzri6p68Ccj8Q1nB4K1dTtpYibj
         EzMXxDVVFuWYL53iVbZmsN/0/a90vCpGF69P11qveNXUb8AnE3Dbgdy+6TE563vNMW
         BCfxD5IrpYNFA==
Date:   Tue, 19 Jan 2021 13:58:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210119115808.GJ21258@unreal>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210119084632.GI21258@unreal>
 <91c354f0-ada7-85d5-8496-122a3a54354a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c354f0-ada7-85d5-8496-122a3a54354a@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 11:10:59AM +0200, Gal Pressman wrote:
> On 19/01/2021 10:46, Leon Romanovsky wrote:
> > On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> >> On 05/01/2021 12:43, Gal Pressman wrote:
> >>> The following two patches add the userspace version to the host
> >>> information struct reported to the device, used for debugging and
> >>> troubleshooting purposes.
> >>>
> >>> PR was sent:
> >>> https://github.com/linux-rdma/rdma-core/pull/918
> >>>
> >>> Thanks,
> >>> Gal
> >>
> >> Anything stopping this series from being merged?
> >
> > It is unclear when this forwarding of non-verbs data to the FW will stop.
>
> This was already discussed in the PR. Not everything should be passed through
> this interface, there should be a limit and it should be examined per case.
> rdma-core version is clearly related to an RDMA device.

"Clearly or not" - it depends on the observer.

>
> BTW, if you have any concerns about a patch you can state them, you don't have
> to ignore it and wait for the submitter to ask what's wrong..

Didn't you mistake me with anyone else?

I'm reviewer in the kernel exactly like you and it gives me nice thing - ignore patches.

Thanks

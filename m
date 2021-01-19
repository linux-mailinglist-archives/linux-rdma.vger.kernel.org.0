Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A932FB482
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbhASIr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 03:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbhASIrR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 03:47:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EDBF23131;
        Tue, 19 Jan 2021 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611045996;
        bh=2PthgBGLyULhCkRl0w1L3yM0V1PJI79M2pvURZ8BEUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoxOwJpEdE8lggDK3vZikLkXwvClJ3YR79HAu3osn2HXsbAh11g6vl5bIMic5NjFo
         tkQjakWsUbZbf8mINLkIkRbnPjkuh9CCIY3W8qpggJL7uOOThD65N+EVXn2gSxcS1t
         HzBFLJpGLWk9cSf+L0ZjpdSpHHe7dctdeoG+Xm8LzjvFCZJUnfWtCXUjx005CV1kKM
         oMQQLAmumYtJ/Nc5DLOMipwZHdwPjRkosT0gFAUKzE+dyYVbt5gE1E8FMwxMDqkucC
         PNSWY8n8BDQRRCP5zmqIuWtjVEIK0/ca6ZNnftxdsu9TI9eXL+WIQOHjqGQTgWHHfs
         5x2C8sCnjHmYg==
Date:   Tue, 19 Jan 2021 10:46:32 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210119084632.GI21258@unreal>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> On 05/01/2021 12:43, Gal Pressman wrote:
> > The following two patches add the userspace version to the host
> > information struct reported to the device, used for debugging and
> > troubleshooting purposes.
> >
> > PR was sent:
> > https://github.com/linux-rdma/rdma-core/pull/918
> >
> > Thanks,
> > Gal
>
> Anything stopping this series from being merged?

It is unclear when this forwarding of non-verbs data to the FW will stop.

Thanks

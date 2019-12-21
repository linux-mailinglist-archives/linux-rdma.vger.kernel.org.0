Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECB5128871
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2019 11:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLUKDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Dec 2019 05:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfLUKDv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 21 Dec 2019 05:03:51 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0BFE21655;
        Sat, 21 Dec 2019 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576922630;
        bh=OJKVmOzGS0dRkw63VB5sXhHxpo5CLU19L+wUpn5sJ1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqaevg3VQNlv1dZ6Wk8wlXvI0urRLeYeTlCknYS9LRod69UoxuLgNXap7PNSzF+Gj
         vghRZt/rviehQDKqIDl5rKs+a5RZMd09Qy3hqjoGzQyWxQCid8xRfXOT39msqRch3R
         yeDz1jrK7eBYNc4eDw16I7n3j8xwaO0FCYjDz1DA=
Date:   Sat, 21 Dec 2019 12:03:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Noa Osherovich <noaos@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/1] pyverbs: fix speed_to_str(), to handle disabled links
Message-ID: <20191221100346.GA13335@unreal>
References: <20191221013256.100409-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221013256.100409-1-jhubbard@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 05:32:55PM -0800, John Hubbard wrote:
> Hi,
>
> This came up when I was running rdma-core tests on a two-machine setup,
> where each card had two ports, but there was only one cable. So only
> one port on each end was connected.
>
> The main thing I expect to be up for debate is, what string to return
> for speed, when a port is disabled or down? I initially thought about
> returning  '(Disabled/down)', but it seems more accurate to just report
> '0.0 Gbps', so that's what I settled on.
>
> Background: here's what I wrote when discussing this over on linux-mm
> with Leon [1]:
>
> It looks like this test suite assumes that every link is connected!
> (Probably in most test systems, they are.)

I don't remember whenever the expectation of connection is by design or outcome
of mine and Jason's setups, where our cards are being connected in loopback mode
(port 0 to port 1 of the same card).

The loopback mode simplifies our kernel testing and development.

Thanks

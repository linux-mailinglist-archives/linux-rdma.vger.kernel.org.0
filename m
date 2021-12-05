Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197B4468B0D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhLEN3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Dec 2021 08:29:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33214 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhLEN3u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Dec 2021 08:29:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC504B80E59
        for <linux-rdma@vger.kernel.org>; Sun,  5 Dec 2021 13:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8992DC341C5;
        Sun,  5 Dec 2021 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638710781;
        bh=Lcy+IB56y5y0ggaNWJcF+WgoDISU1MO6mQlMFgJ0TNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=merX2JHg88UZH0hc7cBiDWT7JAEpokAWpqUZk0BM9+HhiQ9aH6GH+gUBS/88fNDrB
         /fkfb5EEyPfJQR3/lNaVOw6CFxjhHu7CSTcTk7k2wnE+iKTJnKkpHKxCNgSonqd131
         xTET3FFS50npL1JN59yH8TALjT5KnwI332UoPNFu42o8ZX4nZ52g3JiKHdHy17jyHZ
         SFUJFRgNznfuyzD9M0okSUsyGs6E+l9chATFyh9gZdHQQfBIKr2rZp9aUm6C+J6F9U
         +yn6QsGXWKntN6YJ/cPgynrhiIrsoIDMrp0RPRuvEnzsz0NySTUKjF9OE5hWmPRQap
         ssuxb/yPV3jOA==
Date:   Sun, 5 Dec 2021 15:26:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to mckey
Message-ID: <Yay9+MyBBpE4A7he@unreal>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 02, 2021 at 02:36:48PM +0100, Christoph Lameter wrote:
> The rdma_create_qp createflags option IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
> should prevent multicast loopback. However, this feature seems to be
> broken on a lot of RDMA NICs and there is no way to test this with the
> existing RDMA tools. So add an option to mckey in order to allow to send
> multicast messages without loopback. mckey's default has been and will
> continue to be to loopback all multicast messages.
> 
> Loopback of multicast messages can have surprising effects because all
> messages sent out also have to be processed locally by all members of
> the multicast group. This usually also includes the sender.
> 
> In order to test multicast loop execute the following in two windows
> on a host connected to an RDMA fabric.
> 
> First session (Receiver)
> 
> 	mckey -b <RDMA IP address> -m239.1.2.1
> 
> Second session (Sender)
> 
> 	mckey -b <RDMA IP address> -m239.1.2.2 -s -l
> 
> 
> The sender will send 10 messages and the receiver will terminate
> after 10 messages have been received.
> 
> If loopback prevention would work then the receiver should only
> terminate on its own when the -l option has not been specified.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>

Christoph,

How can I apply your patch? Can you send it as a PR to rdma-core github?

Thanks

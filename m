Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE53F3F0E
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Aug 2021 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhHVLct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 07:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhHVLcs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 07:32:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48DD6126A;
        Sun, 22 Aug 2021 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629631927;
        bh=kfySvA3N3SQlPWzh0DLRxLBNQdndxRT8k2GH9axYWpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvuBxuEza+QmIJL7kbVLhbHnkl76GknHTgQCnS2Is2yWgSXP3758pGPRVbN3j7uyD
         hDvEgV+2wQGLiqj1ndQvS9GngYHX5bdZnmwZssQZr5Eg29mKEWYEIZ5IrWEUVGfXTe
         DWXmAP39leP5wEqdypYhoWNBPU2Uu6f9YBm/ow1H1qNHxR+RSTIoQokTwzn5XpQ1In
         9AbP/OceuSVcGK+kdFKWjCEjuJoAT7y8Q2zVGmmjQmNvC//dtwXItI79w8jSFxfwZx
         a/1RoDVt4Te4QvkmVfyGCT4YKljPV9C+O3srvQzWXzmE8limc6TtuRAo9XaDEndq4Z
         46Ne/qSRshWew==
Date:   Sun, 22 Aug 2021 14:32:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <YSI1s7JEXRaI2zdO@unreal>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 22, 2021 at 12:40:26PM +0300, Oded Gabbay wrote:
> Hi Jason,
> 
> I think that about a year ago we talked about the custom RDMA code of
> habanalabs. I tried to upstream it and you, rightfully, rejected that.
> 
> Now that I have enough b/w to do this work, I want to start writing a
> proper RDMA driver for the habanalabs Gaudi device, which I will be
> able to upstream to the infiniband subsystem.
> 
> I don't know if you remember but the Gaudi h/w is somewhat limited in
> its RDMA capabilities. We are not selling a stand-alone NIC :) We just
> use RDMA (or more precisely, ROCEv2) to connect between Gaudi devices.
> 
> I'm sure I will have more specific questions down the line, but I had
> hoped you could point me to a basic/not-too-complex existing driver
> that I can use as a modern template. I'm also aware that I will need
> to write matching code in rdma-core.

drivers/infiniband/hw/efa can be seen as a good example.

> 
> Also, I would like to add we will use the auxiliary bus feature to
> connect between this driver, the main (compute) driver and the
> Ethernet driver (which we are going to publish soon I hope).
> 
> Thanks,
> Oded

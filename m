Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B692B349A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKOLYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgKOLYa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:24:30 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8FE223C7;
        Sun, 15 Nov 2020 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605439469;
        bh=ZwxMi2PMAK2F2W5ObkiFvDQGGAku0poaFKie8gvuLlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqhoK5wPh22lqu17h8xntG8wZvd0v4DZDOc2zSM2f2Lfg5sO/1a90HuZRkknB4jMP
         tMCL/qwQcwZkLVp7Ng1E65qoeT4xhKgJsTy5qSmfl9nEzi0lrjqE1MDr2G2UCHcIWU
         DchthfCbiwLciP2uIqHdujKp4gat7aXIFp5Cjhcs=
Date:   Sun, 15 Nov 2020 13:24:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Manikarnike, Vasuki" <vasuki-ramanujapuram.manikarnike@hpe.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: librdmacm: cleanup/reinit API?
Message-ID: <20201115112425.GE47002@unreal>
References: <CS1PR8401MB0614C667E371DC6F8326CE4BD6070@CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0614C667E371DC6F8326CE4BD6070@CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 10:38:50PM +0000, Manikarnike, Vasuki wrote:
> Hello,
>
> I notice that librdmacm does not have a reinit/deinit/cleanup API.
> I'm looking for ucma_cleanup(), sort of the opposite of ucma_init().
>
> The first call to rdma_get_devices() from the application calls ucma_init() if required.
> ucma_init() builds the  list of devices, and subsequent library calls use this list.
>
> We'd like to issue a full chip reset on a Mellanox CX-5 adapter by using the 'mlxfwreset' tool,
> and we'd like to do this without requiring our application to be restarted.

It is supported with this already merged PR.
https://github.com/linux-rdma/rdma-core/pull/750

Thanks

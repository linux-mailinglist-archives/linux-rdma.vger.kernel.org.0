Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD945311C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 12:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhKPLrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 06:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhKPLrd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 06:47:33 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F0C061766
        for <linux-rdma@vger.kernel.org>; Tue, 16 Nov 2021 03:44:35 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id C92C7B00278; Tue, 16 Nov 2021 12:44:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C5D73B00192;
        Tue, 16 Nov 2021 12:44:32 +0100 (CET)
Date:   Tue, 16 Nov 2021 12:44:32 +0100 (CET)
From:   Christoph Lameter <cl@vmi485042.contaboserver.net>
To:     Leon Romanovsky <leon@kernel.org>
cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        rpearson@gmail.com, Doug Ledford <dledford@redhat.com>
Subject: Re: [RFC] RDMA bridge for ROCE and Infiniband
In-Reply-To: <YZDSMCSmixPdS8hf@unreal>
Message-ID: <alpine.DEB.2.22.394.2111161241100.78545@vmi485042.contaboserver.net>
References: <alpine.DEB.2.22.394.2111121300290.380553@vmi485042.contaboserver.net> <YZDSMCSmixPdS8hf@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 14 Nov 2021, Leon Romanovsky wrote:

> > Any tips and suggestions on how to approach this problem would be appreciated.
>
> Mellanox has Skyway product, which is IB to ETH gateway.
> https://www.nvidia.com/en-us/networking/infiniband/skyway/
>
> I imagine that it can be extended to perform IB to RoCE too,
> because it uses steering to perform IB to ETH translation.

The Mellanox Gateways (4036E, 6036G and Skyway) are only for IP
traffic and do not support ROCE or Native IB across the bridge. The newest
version of it "Skyways" does not even support Multicast.

And these are appliance so they cannot be modified. If Mellanox would
commit to do this then great but I guess that would need to be some high
level decision and if a product comes out of it at all then it will take a
couple of years.

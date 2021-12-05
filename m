Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACC468AA4
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhLELuk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Dec 2021 06:50:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44702 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhLELuk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Dec 2021 06:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFDB60FAD
        for <linux-rdma@vger.kernel.org>; Sun,  5 Dec 2021 11:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD39C341C1;
        Sun,  5 Dec 2021 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638704832;
        bh=f/VHGvst3rUWmisbheTm9u4o8yiSpWJ44nkJ0wiog+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moC5yIs7lcl68a5IrbWr4+Q1eIeyrzoL+g4nPLOFPirPKBUlgeZfFO+isaNoEKNdl
         hNwWK1a1NDlsBJPdSixFO2TzabGYtwLH1Fv6rTt+xBtm7XEbgG6rbrh+heQovTFdKT
         cZCpcDQGp14de0yHeMoYMYgc1I83XS5wLOGW8jrCde6t1XVlfwbbGe6tlLc9i7KP8z
         6XLgAlj4zFV6rPPMP3k2pO+Jxey+0EtmWAazqcyE9O1KYaBkoZV1TW+7Ep9ZsBFoHM
         3r+bQHxlxJ+He71nIQD03lB2hXHd1MzCnJ/7Fbwf0dxq2n2O0yNLZSvQpld62Sfn7f
         pc8B30iZvpXRA==
Date:   Sun, 5 Dec 2021 13:47:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [bug report]concurrent blktests nvme-rdma execution lead kernel
 null pointer
Message-ID: <YaymumNuphhWiCc2@unreal>
References: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
 <OF74AE32F7.7A787A6C-ON002587A0.003CDEF3-002587A0.003EEE89@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF74AE32F7.7A787A6C-ON002587A0.003CDEF3-002587A0.003EEE89@ibm.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 03, 2021 at 11:27:22AM +0000, Bernard Metzler wrote:
> -----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----
> 
> >To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
> >From: "Yi Zhang" <yi.zhang@redhat.com>
> >Date: 12/03/2021 03:20AM
> >Subject: [EXTERNAL] [bug report]concurrent blktests nvme-rdma
> >execution lead kernel null pointer
> >
> >Hello
> >With the concurrent blktests nvme-rdma execution with both rdma_rxe
> >and siw lead kernel BUG on 5.16.0-rc3, pls help check it, thanks.
> >
> 
> The RDMA core currently does not prevent us from
> assigning  both siw and rxe to the same netdev. I think this
> is what is happening here. This setting is of no sense, but
> obviously not prohibited by the RDMA infrastructure. Behavior
> is undefined and a kernel panic not unexpected. Shall we
> prevent the privileged user from doing this type of
> experiments?
> 
> A related question: should we also explicitly refuse to
> add software RDMA drivers to netdevs with RDMA hardware active?
> This is, while stupid and resulting behavior undefined, currently
> possible as well.

In old soft-RoCE manuals, I saw a request to unload mlx4_ib/mlx5_ib
modules before configuring RXE. This effectively "prevented" from
running with "RDMA hardware active". 

So I'm not surprised that it doesn't work, but why do you think that
this behavior is stupid? RXE/SIW can be seen as ULP and as such it
is ok to run many ULPs on same netdev.

Thanks

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAE165F68
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBTOFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 09:05:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBTOFx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 09:05:53 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 054BF20656;
        Thu, 20 Feb 2020 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582207552;
        bh=n56mt7L8N0XSy9L5ZmBsA7GK24hIPPF6hAKz9d6mXEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PA/9l44fSJwZiC4j4lrNeWjs6xVSflTL3myx4ruxasOG4wtZX6KMok4BxUPhrOZFW
         8gPFYHF+AEVA5nWR6EHDbWYclo64lKCzk4O1mlOP7QRKJuF5akhCOpe2JEHDRGyxFK
         6jTOQzuePQuRZjABiAsWogiahReRRcbRNY+xNrcA=
Date:   Thu, 20 Feb 2020 16:05:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: a bug(BUG: kernel NULL pointer dereference) of ib or mlx
 happened in 5.4.21 but not in 5.4.20
Message-ID: <20200220140547.GE209126@unreal>
References: <20200220112231.34FB.409509F4@e16-tech.com>
 <FD4E1E87-28CF-4F4C-BBF4-2BD945142A14@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD4E1E87-28CF-4F4C-BBF4-2BD945142A14@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 08:57:29AM -0500, Chuck Lever wrote:
> Hello!
>
> Thanks for your bug report.
>
>
> > On Feb 19, 2020, at 10:22 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi, chuck.lever
> >
> > a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20.
> >
> > maybe some releationship to xprtrdma-fix-dma-scatter-gather-list-mapping-imbalance.patch
>
> I don't see an obvious connection to fix-dma-scatter-gather-list-mapping-imbalance.
> The backtrace below is through IPoIB code paths. Those have nothing to do with
> NFS/RDMA, which is the only ULP code that is changed by my commit.
>
>
> > maybe the info is useful.
>
> I'm copying linux-rdma for a bigger set of eyeballs.
>
> My knee-jerk recommendation is that if you have a reliable reproducer, try "git bisect"
> between .20 and .21 to nail down a specific commit where the BUG starts to occur.

No need to bisect, it is me who broke.
The fix is already accepted, but not yet merged.
https://patchwork.kernel.org/patch/11387567/

Thanks

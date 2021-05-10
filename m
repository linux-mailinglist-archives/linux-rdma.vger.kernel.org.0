Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52326377B98
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEJFmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 01:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhEJFmN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 01:42:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB4A613EE;
        Mon, 10 May 2021 05:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620625269;
        bh=jP8LSLZS8zDytKhrOaxXZp66+2jkjA+cruNq8XS/Fxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2XAE0aMeeAws2unSAbaLxi+yd56+o4/R3xFGZ/7hc0xqLoFpelnZY5EtUMN9pg+r
         UPT96W1GrsGrPGtXXtgnkby6fNHNe+I3RqBE8w5LGODO+x4kIEgfbPLl5tZjbvSKTP
         CXY4X5ELEDfCPKLqkfTaurCaRBBr8/MnsbIQHmoX5fJIKFa0QBnn9Uj59/NrTwbH1B
         1y1Zp1JPgzgwpV54vnBRiqXqZJY0wDaSWECjOvKV8Ka60/mc/opURQwQChyKTWY6Rq
         2b7wVIYb7gZVjH5eEK2c+QbNb6tzqkyFQ0nM4gIARGtZLVUVoxczT/7uU8JiPNEyZv
         K9JX6Fv609xng==
Date:   Mon, 10 May 2021 08:41:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [V2 rdma-core 0/4] Broadcom's rdma provider lib update
Message-ID: <YJjHcUYLhMQGwoD1@unreal>
References: <20210505171056.514204-1-devesh.sharma@broadcom.com>
 <CANjDDBhyp_YzPE2s6S2HZx20vyrMOEdxhjx4kprtEQWxw+Aoyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBhyp_YzPE2s6S2HZx20vyrMOEdxhjx4kprtEQWxw+Aoyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 10:33:48AM +0530, Devesh Sharma wrote:
> On Wed, May 5, 2021 at 10:41 PM Devesh Sharma
> <devesh.sharma@broadcom.com> wrote:
> >
> > This patch series is a part of bigger feature submission which
> > changes the wqe posting logic. The current series adds the
> > ground work in the direction to change the wqe posting algorithm.
> >
> > v1->v2
> > - added Fixes tag
> > - updated patch description
> > - dropped if() check before free.
> >
> > Devesh Sharma (4):
> >   bnxt_re/lib: Check AH handler validity before use
> >   bnxt_re/lib: align base sq entry structure to 16B boundary
> >   bnxt_re/lib: consolidate hwque and swque in common structure
> >   bnxt_re/lib: query device attributes only once and store
> >
> >  providers/bnxt_re/bnxt_re-abi.h |  24 ++---
> >  providers/bnxt_re/db.c          |   6 +-
> >  providers/bnxt_re/main.c        |  31 +++---
> >  providers/bnxt_re/main.h        |  15 ++-
> >  providers/bnxt_re/verbs.c       | 182 +++++++++++++++++---------------
> >  5 files changed, 138 insertions(+), 120 deletions(-)
> >
> > --
> > 2.25.1
> >
> Hello Maintainers, Could you bless the V2 if there are no more
> comments/suggestions...

I planned to take it after rdma-core release (today/tomorrow).

Thanks

> 
> -- 
> -Regards
> Devesh



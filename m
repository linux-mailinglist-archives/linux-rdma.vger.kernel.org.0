Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D141B86
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfFLFUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 01:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFLFUj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 01:20:39 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14962086A;
        Wed, 12 Jun 2019 05:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560316838;
        bh=C9uhniIAchLHG+tIuO9Wx3cccosi/8NXKHPKkf+6WV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byimGC9sl5OSbBfhMt7QKWm2tkAnoP2+KY3Utwt3Tcp9gF/05km3MRZ7Z+B180sqN
         RZoKRubAxRAqwDmW/be4q5GLkhEN7deb7xYS2r91Lc50vLT07r14qu2RcmFgR3KGyf
         j7BmnG91ByX3W5FZD4tWeMJPLNXVQSlIVerRBn1I=
Date:   Wed, 12 Jun 2019 08:20:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 0/3] Convert CQ allocations
Message-ID: <20190612052034.GM6369@mtr-leonro.mtl.com>
References: <20190528113729.13314-1-leon@kernel.org>
 <08ce5b4ed985b885e33054cae6426018b46f67ff.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ce5b4ed985b885e33054cae6426018b46f67ff.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 04:53:22PM -0400, Doug Ledford wrote:
> On Tue, 2019-05-28 at 14:37 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This is second version of my CQ allocation patches, rebased to latest
> > rdma/wip/for-next branch with changes requested by Gal.
> >
> > Thanks
> >
> > Leon Romanovsky (3):
> >   RDMA/nes: Avoid memory allocation during CQ destroy
> >   RDMA: Clean destroy CQ in drivers do not return errors
> >   RDMA: Convert CQ allocations to be under core responsibility
>
> Series, minus the one hunk in 3/3 that Gal objected to, applied to for-
> next.  Thanks.

Thanks Doug for taking care.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD



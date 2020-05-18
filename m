Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBC1D70C2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgERGR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 02:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgERGR1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 02:17:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744D520657;
        Mon, 18 May 2020 06:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589782647;
        bh=mMVK8O15D2yC9R88JfE4ZWT1oH/SPci4NILiZTUIhyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFsubk8KHe0iZS2oUrWQTQZR2LSm7JmHnXm8/94Y7cNtkbHlVADQhgaABZzF98D4M
         GhwSFzYuzRyfS7Mt6gSkSMQNDvqmY2Sp/vyjVQ7VuSQI7VcNlXeg5jvzVfo0vB6I1T
         C/YfLJZxfVFmz4cLfBLGdxNHpCIZfmxd3U4iSq6o=
Date:   Mon, 18 May 2020 09:17:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@rimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/10] Enable asynchronous event FD per
 object
Message-ID: <20200518061723.GE60005@unreal>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200517233713.GA20969@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517233713.GA20969@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 17, 2020 at 08:37:13PM -0300, Jason Gunthorpe wrote:
> On Wed, May 06, 2020 at 11:24:34AM +0300, Leon Romanovsky wrote:
>
> >   RDMA/core: Consolidate ib_create_srq flows
> >   IB/uverbs: Cleanup wq/srq context usage from uverbs layer
> >   IB/uverbs: Fix create WQ to use the given user handle
>
> I took these small fixed to for-next, the others need some minor
> adjusting

Thanks, I saw your comments and agree with all of them, we will fix.

Thanks

>
> Thanks,
> Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE1E728A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJ1NUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfJ1NUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 09:20:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5035520650;
        Mon, 28 Oct 2019 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572268841;
        bh=Ja1bLBlR7dkJmbzmrQp07DXyS0ZYEP7jpTyzGLAagkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmJ5SZqHXd8Hi/7T5U8awm+rymo/1guCQ1HdD6G5C0kus4k65R/iTYm6XM1lQ7XF/
         ZNuVzr1u02gUWcPWMgO/+z1p7+0D0h6uqMVBQ8pMIGrMZZtAs8UMvkINQDCHx20j5w
         tjneHtcXmCApCiF4xI0Py2dqP8GpGdON+Z2Ol9Hc=
Date:   Mon, 28 Oct 2019 15:20:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 0/6] CM cleanup
Message-ID: <20191028132037.GF5146@unreal>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191028131725.GA30331@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028131725.GA30331@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 10:17:25AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 20, 2019 at 10:15:53AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This is first part of CM cleanup series needed to effectively
> > add IBTA Enhanced Connection Establishment (ECE) spec changes.
> >
> > In this series, we don't do anything major, just small code cleanup
> > with small change in srpt. This change will allow us to provide
> > general getter and setter for all CM structures.
> >
> > Thanks
> >
> > Leon Romanovsky (6):
> >   RDMA/cm: Delete unused cm_is_active_peer function
> >   RDMA/cm: Use specific keyword to check define
> >   RDMA/cm: Update copyright together with SPDX tag
>
> Applied to for-next

Thanks

>
> >   RDMA/cm: Delete useless QPN masking
> >   RDMA/cm: Provide private data size to CM users
> >   RDMA/srpt: Use private_data_len instead of hardcoded value
>
> These ones probably need a bit more work

I disagree about that last patch, we don't want to make private_data_len dynamic.

Thanks

>
> Thanks,
> Jason

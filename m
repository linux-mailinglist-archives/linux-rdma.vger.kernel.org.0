Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8301627A1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 15:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBROEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 09:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgBROEr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Feb 2020 09:04:47 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD9020801;
        Tue, 18 Feb 2020 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582034687;
        bh=BuyuIe3cfyc0HhO1UYMWZGS9om0BympY3eshYjW+/DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwJIUn3ZVVR79sQQJF2M/Z9TWvEKhO+3SQh26fs+UyilmW2FbgdliFWDtDkdrDD/v
         K290r7NohAgB5p521HehhbuODilr8d2LK1O7EYcYKwDylSz6TBqh4eJ3XNDId4yAAm
         Iaqq3Ij5xPXdUcDjkDdYEYLmDaDcAZRk391C70vg=
Date:   Tue, 18 Feb 2020 16:04:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200218140444.GB8816@unreal>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
> Was there any discussion on the upgrade scenario for existing deployments as
> far as device-rename changing node descriptions?
>
> If someone is running an older version of rdma-core they are going to have a
> certain set of node descriptions for each node. This could be in logs, or
> configuration databases, who knows what. Now if they upgrade to a new
> version of rdma-core their node descriptions all automatically change out
> from under them by default.
>
> Of course the admin could disable the rename prior to upgrade and as Leon
> pointed out previously the upgrade won't remove the disablement file. The
> problem is they would have to know to do that ahead of time.

Dennis,

It was discussed and the conclusion was that most if not all users are
using one of two upgrade and strategy.

First option is to rely on distro and every distro behaves differently
in such cases, some of them won't change anything till their last user
dies :) and others more dynamic with more up-to-date packages already
adopted our default.

Second option is to use numerous OFED stacks, which are expected to
provide full upgrade to all components which will work smoothly.

Users who upgrade their system from live upstream repo are expected to
be proficient enough to be deal with change of defaults.

Thanks

>
> -Denny

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379C41F822
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOQF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 12:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEOQFZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 12:05:25 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A704520873;
        Wed, 15 May 2019 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557936325;
        bh=59Oml6NvCxZSVAcL2gmKx8DHsvdNFJiCW7/MnS0YYs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJQkE19f8SFcz0MQiod8MgQihvWjtx58Sk3XoFo4uqZkxjsXvEdGZO7dJOGZvK3Y1
         cbJKVlqHZqZD2eMBCEuAJwEXBGk3jTOQlmZQYz7+7eKj/i2a5ByRjwg0SU6Z6XeevA
         oAJU+ITEAj1KiHsace4/TEfgySgXY66OZUiiOM/w=
Date:   Wed, 15 May 2019 19:05:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 0/5] Build system updates
Message-ID: <20190515160521.GM5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-1-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:23PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Ran through all the build targets and tidied up a few things that were
> failing.
>
> This is a PR:
>
> https://github.com/linux-rdma/rdma-core/pull/528

FYI, I tested it locally and everything worked for me, so feel free to merge.

Thanks

>
> Jason Gunthorpe (5):
>   cbuild: Make pyverbs build with epel
>   cbuild: Remove ubuntu trusty
>   cbuild: Use gcc-9 for debian experimental
>   cbuild: Do not use the http proxy for tumbleweed
>   build: Enable more warnings
>
>  CMakeLists.txt  |  4 ++++
>  buildlib/cbuild | 46 +++++++++++++++++++++++-----------------------
>  2 files changed, 27 insertions(+), 23 deletions(-)
>
> --
> 2.21.0
>

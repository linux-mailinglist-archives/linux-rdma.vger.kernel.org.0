Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8EE612AB2B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfLZJNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Dec 2019 04:13:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfLZJNB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Dec 2019 04:13:01 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5931B2080D;
        Thu, 26 Dec 2019 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577351580;
        bh=4ZG+ipKGXcQTkaIlUYmYOo4OAub7wNbnMBi4XQbH118=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Alh3ICj6m3QIsQUDrZ9H9qrjqh1KK8Ypr+GUxz3VjTPk6WzY57++0iIdd0b6TY+bR
         O6mXw0Jmvct1UgUTVVjnqMOzjd5OC3W1mLR/o6+s00MIIlJHOK8sL7IiQ8UXqQwJZQ
         eCZ/mcspVNej4/nwgyBcOanvtB0ii3jwihH7tqkk=
Date:   Thu, 26 Dec 2019 11:12:57 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Noa Osherovich <noaos@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] pyverbs: fix speed_to_str(), to handle disabled links
Message-ID: <20191226091257.GC6285@unreal>
References: <20191221013256.100409-1-jhubbard@nvidia.com>
 <20191221013256.100409-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221013256.100409-2-jhubbard@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 05:32:56PM -0800, John Hubbard wrote:
> For disabled links, the raw speed token is 0. However, speed_to_str()
> doesn't have that in the list. This leads to an assertion when running
> tests (test_query_port) when one link is down and other link(s) are up.
>
> Fix this by returning '0.0 Gbps' for the zero speed case.
>
> Cc: Noa Osherovich <noaos@mellanox.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  pyverbs/device.pyx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks, applied

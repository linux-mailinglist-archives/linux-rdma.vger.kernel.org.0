Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3A3DD0F7
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 09:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhHBHJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBHJI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 03:09:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3E660E76;
        Mon,  2 Aug 2021 07:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627888139;
        bh=MErhuZBVkwpLFS5lV1RYZZoSBLEyyBJNSj54HQL02XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U87hhq2P8ueHQuNPFGdrptBDyzUBh58S5Zbftid1XiVya7+8Mlnou1DB0vkdT+oEQ
         JWJQmF1RAc8hJzFqNn+3wS56ZTCDrxmQhxL55Bod+tZ5n7BYCEh6wt9xtTyACNW4RF
         YNK28EkobRwJBZ0BUX9Sj0gGHJAwqkhV9LSvZx+Drj/nmHigX+DTlmZd0MygTP2F0n
         1vXQ2ztNrZcDe0iidAxVkX/T7sb36jfK1VfdzV+vHkKRrm/xTzjsEJLQ6Kf3bZ51TT
         DL4pXg7FaOVGmoRMiEmlMQMJ+iNFvmv+m77lTx+hlWwInkjwAn8wNvPeLSV4oHreSU
         FguygDYFss8dA==
Date:   Mon, 2 Aug 2021 10:08:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com
Subject: Re: [PATCH for-next 06/10] RDMA/rtrs: Remove len parameter from
 helper print functions of sysfs
Message-ID: <YQeaCMYGAqDHzsi5@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-7-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-7-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:28PM +0200, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
> Since we have changed all sysfs show functions to use sysfs_emit, we do
> not require the len (PAGE_SIZE) in our helper print functions. So remove
> it from the function parameter.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 12 ++++--------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 12 +++++-------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  3 +--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  3 +--
>  5 files changed, 12 insertions(+), 20 deletions(-)

I suggest to squash this patch to the one mentioned in the commit message.

Thanks

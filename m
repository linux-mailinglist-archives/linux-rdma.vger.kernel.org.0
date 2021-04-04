Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261D13537C9
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhDDKdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 06:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhDDKdv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 06:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4833D61350;
        Sun,  4 Apr 2021 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617532427;
        bh=/pslLDMEifIhDTuDQfSd6iPM/XLOWHSaWiw1i09FpeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NG0CeWleRlSf2LKg1lZ85FlqYf/JEyvvyhqMKfsbCZxITPGT+mEEsJOJCOVOnpwkn
         CZ0JqN5JFtkiyPgDWzOERdNMCEGteQZtZ0QYf6+i72ZogMbKaJUGQpM8IUXuffNxab
         AKN/u+NY3uHqUy62aNXVLV+IE085KJ9bQpqN01V4Yc71toBoYxrXqBpdip0tLngy46
         VKYX3b6GmASvxIeRUtaM6OUz88G8Wh+tC+zUS9lp6K6lSkER8KCSl5bRde63ZVsUO8
         pe7FE5g/MEJ42zUj9R0YnR/yfh5ddRAxiyEKSxLgEMMLq/ar5vX4nCJkUOafcp9iHk
         flj5Zdltjd+fA==
Date:   Sun, 4 Apr 2021 13:33:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/addr: potential uninitialized variable in
 ib_nl_process_good_ip_rsep()
Message-ID: <YGmWB4fT/8IFeiZf@unreal>
References: <YGcES6MsXGnh83qi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGcES6MsXGnh83qi@mwanda>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 02:47:23PM +0300, Dan Carpenter wrote:
> The nla_len() is less than or equal to 16.  If it's less than 16 then
> end of the "gid" buffer is uninitialized.
> 
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I just spotted this in review.  I think it's a bug but I'm not 100%.

I tend to agree with you, that it is a bug.

LS_NLA_TYPE_DGID is declared as NLA_BINARY which doesn't complain if
data is less than declared ".len". However, the fix needs to be in
ib_nl_is_good_ip_resp(), it shouldn't return "true" if length not equal
to 16.

Thanks

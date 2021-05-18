Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C13872D4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhERHHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 03:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239487AbhERHHI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 03:07:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E64B611BD;
        Tue, 18 May 2021 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621321551;
        bh=0w3PtxZoe7et+9vhv9kCZI+gY36ORdXZtA8MtELkPpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZZBhfx55bP0k5mnmmlWanzo+XxqgQOZhk5jsrlnevOFc9dWJ7iskoTEwozt8ZU+E
         httabZ/AKCZZQS7vU8Y0pcwKPzzY5kqDwg8v7UuI5624ogA1aM7P8ubaishAMj9rQH
         br4iRIVcu09ki6xyX1Gw2zc0vBut2+En1fycIRg83Hejv0KLP+jDZSw99kXaSWXYdQ
         b8bNu5mmoVnP91aVkjjN0ppDcXFsfWHM/F5pHkjJllhzbK1NTAX0A7TTuM7ZFwsbUx
         GH4MBCmhU9SZ9WdEMGIErmwcGXgS/3z7bejunVynHogWe0Tg75ajHmUNB00xa/TwdU
         noRCpmKhbT3Yw==
Date:   Tue, 18 May 2021 10:05:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        yishaih@nvidia.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Remove unnessesary check in
 mlx4_ib_modify_wq()
Message-ID: <YKNnSvn+42uZwEJZ@unreal>
References: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210511174302.GA1291834@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511174302.GA1291834@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 02:43:02PM -0300, Jason Gunthorpe wrote:
> On Fri, May 07, 2021 at 06:22:41PM +0800, Jiapeng Chong wrote:
> > cur_state and new_state are enums and when GCC considers
> > them as unsigned, the conditions are never met.
> 
> But doesn't gcc consider enums to be 'int' as the standard requires?

Ohh, I missed that.

> 
> This change looks really sketchy to me, cur_state and new_state are
> both userspace controlled data. We should not make assumptions about
> the underlying signedness of an enum when validating user data.

I still think that the right change should be in
ib_uverbs_ex_modify_wq(), so both mlx4 and mlx5 will be protected.

Thanks

> 
> Jason

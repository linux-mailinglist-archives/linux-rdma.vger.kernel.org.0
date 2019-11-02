Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9BECDE0
	for <lists+linux-rdma@lfdr.de>; Sat,  2 Nov 2019 10:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfKBJrR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 2 Nov 2019 05:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfKBJrR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 2 Nov 2019 05:47:17 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3369620679;
        Sat,  2 Nov 2019 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572688036;
        bh=uqeMAHLTrkJ2kB3Cc8zJusDKIFROJtU3fg5KAGezERQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzTlUJ9QZVkgJRmhiw3S+5ha60GSxNxdO3Dd68V08N3whLb/6CwnZ+iQAqyuWnDh+
         ccyPeq85l0k0Lu7kNLZCYPDsri0U03RMJOl4dUIutj/HJmM1hnZVTOc+5EfmG3mDDq
         s3Z7upGouzbkdtwr3sRWOCwcZajAQUxphsIM6Qzw=
Date:   Sat, 2 Nov 2019 11:47:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH rdma-core] libhns: Use syslog for debugging while no
 print by default
Message-ID: <20191102094713.GH8713@unreal>
References: <1572574425-41927-1-git-send-email-liweihang@hisilicon.com>
 <20191101094444.GF8713@unreal>
 <c38ec00b-2d39-afe4-cbd8-c6d1f9c315fd@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38ec00b-2d39-afe4-cbd8-c6d1f9c315fd@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 02, 2019 at 10:37:50AM +0800, Weihang Li wrote:
>
>
> On 2019/11/1 17:44, Leon Romanovsky wrote:
> > On Fri, Nov 01, 2019 at 10:13:45AM +0800, Weihang Li wrote:
> >> From: Lang Cheng <chenglang@huawei.com>
> >>
> >> There should be no fprintf/printf in libraries by default unless
> >> debugging. So replace all fprintf/printf in libhns with a macro that is
> >> controlled by HNS_ROCE_DEBUG.
> >> This patch also standardizes all printtings to maintain a uniform style.
> >>
> >> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> >> ---
> >>  providers/hns/hns_roce_u.c       | 12 +++++++-----
> >>  providers/hns/hns_roce_u.h       | 13 +++++++++++--
> >>  providers/hns/hns_roce_u_hw_v1.c | 28 ++++++++++++++--------------
> >>  providers/hns/hns_roce_u_hw_v2.c | 18 +++++++++---------
> >>  providers/hns/hns_roce_u_verbs.c | 36 ++++++++++++++++++------------------
> >>  5 files changed, 59 insertions(+), 48 deletions(-)
> >
> > Thank you for pointing our attention that there are printf() in the library code.
> > Yes, to removal all fprintf/printf.
> > No, to introducing not-unified way to see debug messages.
> > Any solution should be applicable to all providers at least.
> >
> > Thanks
> >
> > .
>
> Hi Leon,
> Thanks for your advice, I will use debug file for printings like other providers and send a new PR.

The solution shouldn't be copy/paste of other provides, but unified approach to see debug messages
from rdma-core.

Thanks

>
> Weihang
>
>
>

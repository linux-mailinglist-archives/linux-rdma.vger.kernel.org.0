Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE23438C7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhCVFr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 01:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhCVFrk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 01:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EEB161606;
        Mon, 22 Mar 2021 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616392059;
        bh=VftEAF3EhOAQlNGOgXijWoWFIxvH/3WKO/Tb7uTI5zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+UHQfwkKwpRs0BFeIAvqpRGpyLmSHsBAdnCRolTr4eVQws1ZO3hc/ZA27KcY343D
         UfgdNuacw/HN+vvBuf+Vk04kiEe2wB69TSx/eiTU/9T14ph5GWfgnoG0E0y2Fz2ikd
         y/LbNx4XuF1C4dDHftOwLRouJpO551SvDAiy4f1ry/5qfeP4cz0jfgfj1gjju4VhfT
         /fdp7Q5Qkg5FQ/T5c01OSv9T3+8/viCp41jLD74G1Qceyvw4ieph562dItHh4W98+o
         pwWgqZ4is+79cCJAQyL+MSSf6MabJQNA5hmOQRuhoh1ssQBzTuBVaIop2aa3NjdpcO
         n2+/rNDxUIHEg==
Date:   Mon, 22 Mar 2021 07:47:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Message-ID: <YFgveGZ+fnDKPB81@unreal>
References: <1616144545-18159-1-git-send-email-liweihang@huawei.com>
 <YFXBprYFmFgHu9Z8@unreal>
 <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 03:29:09AM +0000, liweihang wrote:
> On 2021/3/20 17:34, Leon Romanovsky wrote:
> > On Fri, Mar 19, 2021 at 05:02:25PM +0800, Weihang Li wrote:
> >> From: Xi Wang <wangxi11@huawei.com>
> >>
> >> Out-of-bounds may occur in 'qp_state_table' when the caller passing wrong
> >> QP state value.
> > 
> > How is it possible? Do you have call stack to support it?
> > 
> > Thanks
> > 
> 
> ib_modify_qp_is_ok() is exported, I think any kernel modules can pass in
> invalid QP state. Should we check it in such case?

No, it is caller responsibility to supply valid input.
In general case, for the kernel code, it can be seen as anti-pattern
if in-kernel API performs input sanity check.

You can add WARN_ON() if you want to catch programmers errors earlier.
However, I'm skeptical if it is really needed here. 

Thanks

> 
> Thanks
> Weihang
> 
> >>
> >> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> ---
> >>  drivers/infiniband/core/verbs.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> >> index 28464c5..66ba4e6 100644
> >> --- a/drivers/infiniband/core/verbs.c
> >> +++ b/drivers/infiniband/core/verbs.c
> >> @@ -1613,6 +1613,10 @@ bool ib_modify_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state next_state,
> >>  	    cur_state != IB_QPS_SQD && cur_state != IB_QPS_SQE)
> >>  		return false;
> >>  
> >> +	if (cur_state >= ARRAY_SIZE(qp_state_table) ||
> >> +	    next_state >= ARRAY_SIZE(qp_state_table[0]))
> >> +		return false;
> >> +
> >>  	if (!qp_state_table[cur_state][next_state].valid)
> >>  		return false;
> >>  
> >> -- 
> >> 2.8.1
> >>
> 

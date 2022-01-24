Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2743B497F9A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiAXMd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:33:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54310 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiAXMd5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:33:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED22461014
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jan 2022 12:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D7C340E1;
        Mon, 24 Jan 2022 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643027636;
        bh=NWHYwyWvvPvY4Z9mr6ElxIpWzZ5GAw5zZ3/Bl/M9dG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfkCiE/pZChanFeV4KYr+zJJ4LADEQOo5Yac+lC/ePoB93yVdMZHMrNQT3KWoQYs5
         GeeTVG83UgPNo8nF0iB/f/QMwBANa34i2oq0bBYErjpwOmLoTYzbcKX5IMoKvtp7tS
         PcTH6RjNEmyOFdV0ukK3Z08YEiqaX1XbECZGdHPbNi1nn5sOgdDWsa+euzpU7u8AL3
         QCAQONwy9LhhGnyKA862S1091KGJ48uUGp9Ur2IMZO9kYV0W763dANO0E/cP0v9TgK
         WVpTU88Fkv2OFpBX7CAY0S7I1l4IEKcPqp3zdr9m7jtCtsMhWgqZJCMzDUlEI/l+u5
         8tZvxXyR9iI1Q==
Date:   Mon, 24 Jan 2022 14:33:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     "mike.marciniszyn@cornelisnetworks.com" 
        <mike.marciniszyn@cornelisnetworks.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Message-ID: <Ye6cry944qSVHi6z@unreal>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <Ye0vPMAF6NdF0pMu@unreal>
 <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 12:25:32PM +0000, Haakon Bugge wrote:
> 
> 
> > On 23 Jan 2022, at 11:34, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Jan 19, 2022 at 04:28:09AM -0500, mike.marciniszyn@cornelisnetworks.com wrote:
> >> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> >> 
> >> The rdma-core test suite sends an unaligned remote address
> >> and expects a failure.
> >> 
> >> ERROR: test_atomic_non_aligned_addr (tests.test_atomic.AtomicTest)
> >> 
> >> The qib/hfi1 rc handling validates properly, but the test has the
> >> client and server on the same system.
> >> 
> >> The loopback of these operations is a distinct code path.
> >> 
> >> Fix by syntaxing the proposed remote address in the loopback
> >> code path.
> >> 
> >> Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
> >> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> >> ---
> >> drivers/infiniband/sw/rdmavt/qp.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> >> index 3305f27..ae50b56 100644
> >> --- a/drivers/infiniband/sw/rdmavt/qp.c
> >> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> >> @@ -3073,6 +3073,8 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
> >> 	case IB_WR_ATOMIC_FETCH_AND_ADD:
> >> 		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)))
> >> 			goto inv_err;
> >> +		if (unlikely(wqe->atomic_wr.remote_addr & (sizeof(u64) - 1)))
> > 
> > Isn't this "!PAGE_ALIGNED(wqe->atomic_wr.remote_addr)" check?
> 
> No, it checks that the address is natural aligned, in this case the three LSBs must be zero. As per IBTA:
> 
> <quote>
> The virtual address in the ATOMIC Command Request packet shall be naturally aligned to an 8 byte boundary.
> </quote>

And is IBTA restriction applicable to hfi1?

Thanks
> 
> 
> Thxs, Håkon
> 
> > 
> > Thanks
> > 
> >> +			goto inv_err;
> >> 		if (unlikely(!rvt_rkey_ok(qp, &qp->r_sge.sge, sizeof(u64),
> >> 					  wqe->atomic_wr.remote_addr,
> >> 					  wqe->atomic_wr.rkey,
> >> -- 
> >> 1.8.3.1
> 

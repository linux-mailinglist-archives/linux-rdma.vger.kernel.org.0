Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8814F28571E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 05:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJGDgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 23:36:47 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:56409 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJGDgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 23:36:47 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0973aLTN019828;
        Tue, 6 Oct 2020 20:36:22 -0700
Date:   Wed, 7 Oct 2020 09:06:21 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: reduce iSERT Max IO size
Message-ID: <20201007033619.GA11425@chelsio.com>
References: <20200922104424.GA18887@chelsio.com>
 <07e53835-8389-3e07-6976-505edbd94f2a@grimberg.me>
 <20201002171007.GA16636@chelsio.com>
 <4d0b1a3f-2980-c7ed-ef9a-0ed6a9c87a69@grimberg.me>
 <20201003033644.GA19516@chelsio.com>
 <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4391e240-5d6d-fb59-e6fb-e7818d1d0bd2@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sunday, October 10/04/20, 2020 at 00:45:26 +0300, Max Gurtovoy wrote:
> 
> On 10/3/2020 6:36 AM, Krishnamraju Eraparaju wrote:
> >On Friday, October 10/02/20, 2020 at 13:29:30 -0700, Sagi Grimberg wrote:
> >>>Hi Sagi & Max,
> >>>
> >>>Any update on this?
> >>>Please change the max IO size to 1MiB(256 pages).
> >>I think that the reason why this was changed to handle the worst case
> >>was in case there are different capabilities on the initiator and the
> >>target with respect to number of pages per MR. There is no handshake
> >>that aligns expectations.
> >But, the max pages per MR supported by most adapters is around 256 pages
> >only.
> >And I think only those iSER initiators, whose max pages per MR is 4096,
> >could send 16MiB sized IOs, am I correct?
> 
> If the initiator can send 16MiB, we must make sure the target is
> capable to receive it.
I think max IO size, at iSER initiator, depends on
"max_fast_reg_page_list_len".
currently, below are the supported "max_fast_reg_page_list_len" of
various iwarp drivers:

iw_cxgb4: 128 pages
Softiwarp: 256 pages
i40iw: 512 pages
qedr: couldn't find.

For iwarp case, if 512 is the max pages supported by all iwarp drivers,
then provisioning a gigantic MR pool at target(to accommodate never used
16MiB IO) wouldn't be a overkill?
> 
> >
> >>If we revert that it would restore the issue that you reported in the
> >>first place:
> >>
> >>--
> >>IB/isert: allocate RW ctxs according to max IO size
> >I don't see the reported issue after reducing the IO size to 256
> >pages(keeping all other changes of this patch intact).
> >That is, "attr.cap.max_rdma_ctxs" is now getting filled properly with
> >"rdma_rw_mr_factor()" related changes, I think.
> >
> >Before this change "attr.cap.max_rdma_ctxs" was hardcoded with
> >128(ISCSI_DEF_XMIT_CMDS_MAX) pages, which is very low for single target
> >and muli-luns case.
> >
> >So reverting only ISCSI_ISER_MAX_SG_TABLESIZE macro to 256 doesn't cause the
> >reported issue.
> >
> >Thanks,
> >Krishnam Raju.
> >>Current iSER target code allocates MR pool budget based on queue size.
> >>Since there is no handshake between iSER initiator and target on max IO
> >>size, we'll set the iSER target to support upto 16MiB IO operations and
> >>allocate the correct number of RDMA ctxs according to the factor of MR's
> >>per IO operation. This would guaranty sufficient size of the MR pool for
> >>the required IO queue depth and IO size.
> >>
> >>Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >>Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >>Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> >>--
> >>
> >>>
> >>>Thanks,
> >>>Krishnam Raju.
> >>>On Wednesday, September 09/23/20, 2020 at 01:57:47 -0700, Sagi Grimberg wrote:
> >>>>>Hi,
> >>>>>
> >>>>>Please reduce the Max IO size to 1MiB(256 pages), at iSER Target.
> >>>>>The PBL memory consumption has increased significantly after increasing
> >>>>>the Max IO size to 16MiB(with commit:317000b926b07c).
> >>>>>Due to the large MR pool, the max no.of iSER connections(On one variant
> >>>>>of Chelsio cards) came down to 9, before it was 250.
> >>>>>NVMe-RDMA target also uses 1MiB max IO size.
> >>>>Max, remind me what was the point to support 16M? Did this resolve
> >>>>an issue?

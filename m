Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C4483E6C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiADIom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 03:44:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47618 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADIom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 03:44:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48773B8115C
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 08:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314B1C36AE9;
        Tue,  4 Jan 2022 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641285880;
        bh=VLhSZpW7YErBhu7g3sPzq2mx60HS3DFceRdD3QR5imc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ef2blNTjjjanqQ7U9xPJ9YLc3L19IQqnraNwjxK/urDLRBtdEB4Q3ID6p+n78NkYv
         uprba7J2uu3XG+yDTYuJ0ZEvczxFLf8bYSozV/U9yePXoMoW/z6yG0iZsFxcf8DfWS
         pRrHDm9bJbVwlV+Vau7IKHC2DWmRPlssB3xjcwn/vI0AtkqdNwQDH8+0mXSD6MmbtL
         jS0Sv4ru9i4z6s7xHyYAKsA8AH4mVakJX0QIBYVeaGINVY6kaC++0h90IoAZOJStZR
         3VH1WDFPzythmYuOGYaCb340Q6PRwkzi/6+RCPiuANTrCuojxMY4oAYLkwq5xuG9SE
         wsXj6MI00ogsQ==
Date:   Tue, 4 Jan 2022 10:44:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Message-ID: <YdQI86Ohu/zH0Qw0@unreal>
References: <YdLGIs6LQLIooiIn@unreal>
 <20211221173913.1386261-1-yanjun.zhu@linux.dev>
 <b5c7448edd6e87faa448236fcf99d650@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c7448edd6e87faa448236fcf99d650@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 04, 2022 at 07:51:54AM +0000, yanjun.zhu@linux.dev wrote:
> January 3, 2022 5:47 PM, "Leon Romanovsky" <leon@kernel.org> wrote:
> 
> > On Tue, Dec 21, 2021 at 12:39:13PM -0500, yanjun.zhu@linux.dev wrote:
> > 
> >> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> 
> >> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> > 
> > Please use lore.kernel.org links. They have all chances to outlive spinics.
> > 
> >> get the source udp port number for a QP based on the grh.flow_label or
> >> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
> >> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
> >> source port when set path") is a standard way. So it is also adopted in
> >> this commit.
> >> 
> >> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> ---
> >> V2->V3: Move to the block of IB_QP_AV in the mask and IB_AH_GRH in ah_flags
> >> V1->V2: Adopt a standard method to get udp source port.
> >> ---
> >> drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++++++
> >> 1 file changed, 14 insertions(+)
> >> 
> >> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> >> index 8cd5f9261692..31039b295206 100644
> >> --- a/drivers/infiniband/hw/irdma/verbs.c
> >> +++ b/drivers/infiniband/hw/irdma/verbs.c
> >> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
> >> return 0;
> >> }
> >> 
> >> +
> >> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> >> +{
> >> + if (!fl)
> >> + fl = rdma_calc_flow_label(lqpn, rqpn);
> >> +
> >> + return rdma_flow_label_to_udp_sport(fl);
> >> +}
> >> +
> >> /**
> >> * irdma_modify_qp_roce - modify qp request
> >> * @ibqp: qp's pointer for modify
> >> @@ -1167,6 +1176,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> >> 
> >> memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
> >> if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> >> + u32 fl = udp_info->flow_label;
> >> + u32 lqp = ibqp->qp_num;
> >> + u32 rqp = roce_info->dest_qp;
> >> +
> > 
> > I don't see too much value in these extra variables and extra function
> > that is the same as get_udp_sport() from hns.
> > 
> > It is worth to add new function to ib_verbs.h and reuse in both drivers.
> 
> Do you mean the following function should be added into ib_verbs.h?
> 
> "
> static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> {
>         if (!fl)
>                 fl = rdma_calc_flow_label(lqpn, rqpn);
> 
>         return rdma_flow_label_to_udp_sport(fl);
> }
> "
> Then in hns, rxe and irdma, this function is called to get udp source port?
> If so, I will send new patches.

Yes and group all these patches in one series, please.

Thanks

> 
> Thanks.
> Zhu Yanjun
> 
> > 
> > Thanks
> > 
> >> + udp_info->src_port = irdma_get_udp_sport(fl, lqp, rqp);
> >> udp_info->ttl = attr->ah_attr.grh.hop_limit;
> >> udp_info->flow_label = attr->ah_attr.grh.flow_label;
> >> udp_info->tos = attr->ah_attr.grh.traffic_class;
> >> --
> >> 2.27.0

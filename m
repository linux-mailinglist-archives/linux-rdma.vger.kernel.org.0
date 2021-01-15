Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2E2F8556
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbhAOTYW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 14:24:22 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13908 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbhAOTYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 14:24:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6001ebbd0000>; Fri, 15 Jan 2021 11:23:41 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 19:23:40 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 15 Jan 2021 19:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biA28dtwf00hhHpDO74mG8HqjmPDGQCSTM9dveiECntQKXGJi69nmbXsboEZoYXDohGtvot0zrOAwtJ10qmA2rueoo43+nx1t66z6uEFDpEreSDr/9p/KhsoBLHuD9qf9MSNRTCF1YguZ7DcxUgH0HevSJS1CZ2pKUk4a767aem47nSL2ltqlNCtCKIsoJkFhtZPTDOVD5rqs+X2DSGFGlLcn7ljpY4OSq0KWQfCQ8Uc8yCq4R1cawlq1IKUYZlZoQb8277ru1qnngjz7C3LVrflllbteqquC9i7b90jUnbegf30kTy6LUTaT4vpcL0n79n5G+Ai5A/049aJ/OLcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytRVIqZEn8AhuYHu256myxPvkeAlpbtC3NXH9IPfjzE=;
 b=ePAN86IXP75gTvVfHSm1omhO9pc+ZCMy8CqlpUzvrrPXCd2WlUMHDt6LLhHJao7EDTR9fkJ8uwv3RtEbWBNKVbOZWxPlcoDB8+MD+aLDGbw4ndfyHbtvlucAslmZGkH94Iqk+WZv7658anydkAQFJFMUWAl1RTLkFemV83MJWQ2TEHX1UGeBTb6ZQc1lXdSu2tMokRI31tx22aG53uPoPPSi4O5tvNhFB1glAjjXvFu0C1GKv/uuTfTUnN/2SM9KjU5uhzPfN3abDv0Q+DwUHv6ZNFqnzZ8QsVKDrYy7gJhscPaoRG+qR9nwbvPb5eAG0tcrudr0Jho6LTRLWzeDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 19:23:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 19:23:38 +0000
Date:   Fri, 15 Jan 2021 15:23:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <leon@kernel.org>
Subject: Re: [PATCH 1/2] RDMA/uverbs: Don't set rcq if qp_type is
 IB_QPT_XRC_INI
Message-ID: <20210115192337.GA456993@nvidia.com>
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
 <20210112200925.GA20208@nvidia.com> <600007B6.1070606@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <600007B6.1070606@cn.fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0358.namprd13.prod.outlook.com (2603:10b6:208:2c6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend Transport; Fri, 15 Jan 2021 19:23:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l0Uh7-001uuN-4A; Fri, 15 Jan 2021 15:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610738621; bh=ytRVIqZEn8AhuYHu256myxPvkeAlpbtC3NXH9IPfjzE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=iMrIygZjP0gmiYmjERQZhEp9jxl58oBHDSl/ZGO/bnN3AdtAUMxGN+2tGanCT/5Te
         znM3cUsrQcEn7ogI1usRhhvTFTBZZknsrFy8HEYd+WR7Xna2jZD4NjbStEtLADjp+x
         2EPDASYK19lEYjqoABTTO1nSA95VcbNK7jcoPUui52wjj8wSsTajctynpJuYEdqBnl
         +8dYGXClbFc+cvQgBsnZIICRKb6rDVNMOKYij61SpM+tlUAQui006g27zswMsporU2
         eyryJoHBIipXTVMRfhJTcXnLZXVocqHuq46qsDQq4kT5dZQznNT6T8GgU0mseKmsFh
         UcXI3BjHLHb1Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 04:58:30PM +0800, Xiao Yang wrote:
> On 2021/1/13 4:09, Jason Gunthorpe wrote:
> > On Wed, Dec 16, 2020 at 03:17:54PM +0800, Xiao Yang wrote:
> > > INI QP doesn't require receive CQ.
> > > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > >   drivers/infiniband/core/uverbs_cmd.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > index 418d133a8fb0..d8bc8ea3ad1e 100644
> > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > @@ -1345,7 +1345,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
> > >   		if (has_sq)
> > >   			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
> > >   						cmd->send_cq_handle, attrs);
> > > -		if (!ind_tbl)
> > > +		if (!ind_tbl&&  cmd->qp_type != IB_QPT_XRC_INI)
> > >   			rcq = rcq ?: scq;
> > Hmm, this does make it consistent with the UVERBS_METHOD_QP_CREATE
> > flow which does set attr.recv_cq to NULL if the user didn't specify one.
> > 
> > However this has been like this since the beginning - what are you
> > doing that this detail matters?
> Hi Jason,
> 
> Thanks for your comment.
> 1) I didn't get any issue for now.
> 2) I think it is not meaningful to set rcq for XRC INITIATOR QP, current
> code has ignores rcq as below:
> static int create_qp(struct uverbs_attr_bundle *attrs,
>                     struct ib_uverbs_ex_create_qp *cmd)
> ...
>                 if (cmd->qp_type == IB_QPT_XRC_INI) {
>                         cmd->max_recv_wr = 0;
>                         cmd->max_recv_sge = 0;
> ...
> 
> By the way, I have a question:
> Why do we need two kinds of uverbs API?(a: read & write, b: ioctl)

The write APIs can't be modified due to how they were
designed. Whenever someone needs to change something they have to move
things to ioctl

Jason

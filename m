Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C342B8626
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgKRU70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 15:59:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:39742 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgKRU7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:25 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb58b2b0000>; Thu, 19 Nov 2020 04:59:23 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 20:59:22 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Nov 2020 20:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARvURhL6H/g+LBmDfArhccJlX7CeaibBYfPShy0nkON7gpDtJ4M8tIHkYVHkoXPbPRnekL3eMLO1fryjUSrqkBja0Uw3KuG8CKMIWRfAshifHGoCOWd51ODHFroN/9sX7wNlj7qefNhN1iFZOp5at34HB9XTIdy2rJzkJc/+2p6uxY6+AdmePBu8NITk1E3/Ss1yCWQyx3LMKM4RtjUV0PgrJ2n3iJKhfqLemEC9/5C611WWGnrS8MiPFyUAkhrRC+n3q87pn1CqmUsfoNLABbO8KUWHUz2hx3uuIA5MJJr4JBFA+RenTEJW5Ij7k2nRveKkl178J+pH+YF714tyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZYLc8AofvvualEzy2PXnRAwiDq0ST9/uqqG4KOSTkQ=;
 b=hr3DqDTLe65qC8Vh4+THUFXycUxs90Pdsdz8Oobac80pDGa0uH1kV/w2prnm95TUGRLkXpOGqBhfWe6D0OQ1Z2TRAPcuZSR932Mbz1qq9N19TRc1Il7fsBsV00DUhXf6f7H9HpU07ZXFu2Uipm6JvhCp9O+hTWq27vYBITgA0z7GhW1aZkBp68DpnobjJri4c8AQKhfATdRq33/rmGpRM6RlhE28PijsuqOpBEquivExGvQgDp+BamtMmFVZFZxmc/L1zbGDeM2yNulhUitbSJSeJjoXyMxDiTrZGorsrJQQiqpfmOuMf8ICKJc4OqFHm0/buPO6OeZr5XEwffYsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 20:59:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 20:59:19 +0000
Date:   Wed, 18 Nov 2020 16:59:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 4/9] efa: Move the context intialization out of
 efa_query_device_ex()
Message-ID: <20201118205917.GC917484@nvidia.com>
References: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
 <3ef1c929-5a36-9d55-091c-2a983c450f38@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ef1c929-5a36-9d55-091c-2a983c450f38@amazon.com>
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0204.namprd13.prod.outlook.com (2603:10b6:208:2be::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Wed, 18 Nov 2020 20:59:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfUXt-007sSd-HO; Wed, 18 Nov 2020 16:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605733163; bh=tZYLc8AofvvualEzy2PXnRAwiDq0ST9/uqqG4KOSTkQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MrVSj7GmClltkPlC9XMJygGRleqZwHoxZnSIqnzI+X9RUr6QnGkJJKXkoertmSajz
         zit5xzsqxAahS2+QFqYKb5yZGG4SLfO1ZdbW9pxO7rcEj0KaUpa0mOLyBbshW92Gyl
         TRJ59N0ZDLIGTejLk5cykB3V3qLjR9sImqYZXu6SdHJczpGeYcdzFLabs43UsxjGnR
         ugXrp7eqkFibwA8GRppywKslUjcH0aye+TVMhnFiXbq9WZi5D4x7eyEoyC+HJN1iAT
         +w1cajwMQU4NyTZGX95HYaW4JimjbD5IagJIdBs9Z45YxDksmmvDYAFBpdNgau+USl
         Kqhjn1ciiKF7A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 02:45:42PM +0200, Gal Pressman wrote:

> > +	size_t resp_size = sizeof(resp);
> > +	unsigned int qp_table_sz;
> > +	int err;
> > +
> > +	if (ctx->cmds_supp_udata_mask & EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE) {
> > +		err = ibv_cmd_query_device_any(&ctx->ibvctx.context, NULL,
> > +					       &attr, sizeof(attr),
> > +					       &resp.ibv_resp, &resp_size);
> > +		if (err)
> > +			return err;
> > +
> > +		ctx->device_caps = resp.device_caps;
> > +		ctx->max_sq_wr = resp.max_sq_wr;
> > +		ctx->max_rq_wr = resp.max_rq_wr;
> > +		ctx->max_sq_sge = resp.max_sq_sge;
> > +		ctx->max_rq_sge = resp.max_rq_sge;
> > +		ctx->max_rdma_size = resp.max_rdma_size;
> > +		ctx->max_wr_rdma_sge = attr.orig_attr.max_sge_rd;
> 
> max_wr_rdma_sge assignment can be done in the else clause as well.

Yes, it is the same mistake as I did in mlx5

I updated everything, thanks

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9125EE2C
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgIFO3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 10:29:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55417 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgIFO3L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 10:29:11 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f54f2070000>; Sun, 06 Sep 2020 22:28:23 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Sun, 06 Sep 2020 07:28:23 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Sun, 06 Sep 2020 07:28:23 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 6 Sep
 2020 14:28:23 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 6 Sep 2020 14:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWOm3PeUov5kGc3QN06nnqEutpjoCY8fDukq3IotEk2P0G0HaoplfzfUQFNG1UrPEGvly/O7yxbCKekHRpdptNUY2NDfffdOMiY82+B4QWnN2jVB8o6ReS5Iwu16s4tmxa9VgNxhhf54hCrmqGk3dkzgYr5YeO92TPukUJvQTxs3vXwdHrVbu2RwmwDapx65CLXRudsM64MXfJskc1tiafnXT9u/vptpjP0K9TAK3YiN+JN5v2XsAmkRSPjh/smFaqYNm2Zad81TxQ0+mxCxvIejuduo9zO84KOS5KfAkM3fXYk9PN/zIUdoMhOVMER3gNouUsVWlDIp8Ompxdl0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srzsinx3w+UHdTbepVPnItOh9PHWZZuOU1WFq3EzwlA=;
 b=mXy5srMSMJch0IMcfF4ZUlJGuozqRYs+5Cll5QUaB2cJFO/DUOyiQaakOjfBBYNDEWCGlIZPPJQQyBtA6Pbxbe20LUd/BLXiL6TLOOJFYL/eCyutxCU+aG0fOjNy2kJ4AXxaYyt1g9Tf1ztkNmokV/rJw7TER2vRnxXR1vz5Lw780OybpTwZI8DwpUpmeeOsoLES+b4ZqAP5IPhebIBxYpPkV7pKC1mrLRbVuKwusQFOH8EWwaIijIagW2F1s74xjY0hXQcvs8hld62qL8kIt1ppyTQxG90zh2N+QvQu6udZnSAgcm9vCUaZIY8WaXRieUSweG7tsTbVJseK3H/1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sun, 6 Sep
 2020 14:28:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3348.018; Sun, 6 Sep 2020
 14:28:17 +0000
Date:   Sun, 6 Sep 2020 11:28:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 13/13] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20200906142815.GC9166@nvidia.com>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-14-leon@kernel.org>
 <20200903162148.GA1552408@nvidia.com> <20200906142400.GG55261@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200906142400.GG55261@unreal>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Sun, 6 Sep 2020 14:28:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEveR-002NL9-RA; Sun, 06 Sep 2020 11:28:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb24449-008d-40d6-4c69-08d8527118c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB359457EC8912D949B20EECAEC22B0@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xk27xMSlkmPHiOPfFK88PHlym9v0ERDVHxqaDojhxYNtukUXPWBDiA8/i5/uMi/qqv3AVppcBumtLemerrQa47SIZ3PsKGQlaczoyTEcqyBLR5PMXSmU27atumVt92zZrufH5qR/Mlh5fw2p1JWtwUMcGHfnIVSdPrXo92WMwj4gm98ne6K53IgA23EsIvgtvlv69ifAryMAOPzrj3T3BbZn8xEbs96S9KfuEbx5Ceky/3ap55bXRA5jKqbe2hHvPxAJ3nQ7tpKcDKTSUBXMxRTEJTmLyxcnbkI3LF8vFtin3wMSUJxDjJwLlb4g+3AUiUsf5ir+z9CPU/4yA/ipmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(66476007)(426003)(478600001)(2616005)(86362001)(83380400001)(316002)(1076003)(36756003)(4326008)(186003)(6916009)(66946007)(9786002)(9746002)(66556008)(2906002)(33656002)(8676002)(26005)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8ne5U17T8utIsCkS0qLqNLgWEAfb9gcTOWQsPNV0eb51jZe4Cez/i+QGHiEPGXZ67kWiw7YB9v2QhJuNPdK6caB01UqY1Vgke9U7QH9eaINpY6lAkADQGf/yswnz9jch5Sp0lB9kDhRYIC012pUP9Z1eZzVg2AQai5xVSY9qrriwHGNAnMbiufDhbSGa6YV1So4nzrVNb8uC7GCBmlspLnf9H1KAS7zMyk+Z3WTiW/xaUhIPnRAiXHIHoGs4NgpjEDyMrUBTACoqRo276FUokES+WqfkN57WEiUARTK2HVYVukuEN2DGEK1LeF48BM3UZPj/uRFeb/lyoVMUt6sBgO3RzG9vUoIStnEvqm2IuRNxLS6LXvrvGnMmMHEouM2vzED5QUUmBq0RsA5cwG9fEcY3hthhgMyfrmyZsq55lGrusmgtM47ZL0zrYNi8WHPBeXDZrlyxv4k/eTp4keI5k8aTZFx9zSvAb46o7FGUMHr2z0ojKuzp6C6zAduCGdVltmTcVQvxiHoprVY5zongp1gq2lk2zl4kGm4ODENk5HHIoCtshClMyifQZkdFXVxfx1ftTPZ9149V2HrpoqTzYu5000BEQVQnM+CqfFU2Mh1STf7z77t8Dbz2rhGJBrBFUT4L6Qhp+ykokKuYp6T/yQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb24449-008d-40d6-4c69-08d8527118c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2020 14:28:17.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0hXOC1G+UecCLNW1UsZBHgfOIkE0URe1D0fZAzuj3J9tmvKDcnCLLMfLwsW0ods
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599402503; bh=Srzsinx3w+UHdTbepVPnItOh9PHWZZuOU1WFq3EzwlA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=LWx5TijqzJ6YMaQcK+t9M39/iOLAB96hrNjAnKy6sP3cuTk7EsFTOjtAIYAYk2X7c
         gSnmtfI4/Ia8RMyVOjjfS6lpJkppyPO1EfLCPmFnveoDp/OkfvJxXu7m5Zob6HkVD1
         IJkUX8Bck7MZTihcYkS7JlZ1f0MuIu28suodfHH98tOi+CYN18i1emP1FK+9sieJwR
         eoEYG1wDne9iu0UZwr+zKk45GKYOe/ln7L3V6lmnau1Nm+n94Yu9Rgdh5DmnA+NJw6
         XGthx/0RXIoxx0wDLKtappQg5ADDl5B3t4ZVgewJ8T3Tmfy4BNteRbSpYlk+lrtmKY
         aqlLTjzVSfD1Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 06, 2020 at 05:24:00PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 03, 2020 at 01:21:48PM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 30, 2020 at 01:14:36PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > The valid field was needed to distinguish between supported/not
> > > supported QPs, after the create_qp was changed to support all types,
> > > that field can be dropped and the code simplified a little bit.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
> > >  include/rdma/restrack.h            |  9 ---------
> > >  2 files changed, 8 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > index 4caaa6312105..fb5345c8bd89 100644
> > > +++ b/drivers/infiniband/core/restrack.c
> > > @@ -143,7 +143,7 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
> > >  		return container_of(res, struct rdma_counter, res)->device;
> > >  	default:
> > >  		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
> > > -		return NULL;
> > > +		return ERR_PTR(-EINVAL);
> > >  	}
> > >  }
> > >
> > > @@ -223,7 +223,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> > >  	struct rdma_restrack_root *rt;
> > >  	int ret = 0;
> > >
> > > -	if (!dev)
> > > +	if (IS_ERR_OR_NULL(dev))
> > >  		return -ENODEV;
> > >
> > >  	if (res->no_track)
> > > @@ -261,10 +261,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> > >  	}
> > >
> > >  out:
> > > -	if (ret)
> > > -		return ret;
> > > -	res->valid = true;
> > > -	return 0;
> > > +	return ret;
> > >  }
> > >  EXPORT_SYMBOL(rdma_restrack_add);
> > >
> > > @@ -323,25 +320,16 @@ EXPORT_SYMBOL(rdma_restrack_put);
> > >   */
> > >  void rdma_restrack_del(struct rdma_restrack_entry *res)
> > >  {
> > > +	struct ib_device *dev = res_to_dev(res);
> > >  	struct rdma_restrack_entry *old;
> > >  	struct rdma_restrack_root *rt;
> > > -	struct ib_device *dev;
> > >
> > > -	if (!res->valid) {
> > > -		if (res->task) {
> > > -			put_task_struct(res->task);
> > > -			res->task = NULL;
> > > -		}
> > > -		return;
> > > -	}
> > > -
> > > -	if (res->no_track)
> > > +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> > > +		  "IB device should be set for restrack type %s",
> > > +		  type2str(res->type));
> > > +	if (res->no_track || IS_ERR_OR_NULL(dev))
> > >  		goto out;
> > >
> > > -	dev = res_to_dev(res);
> > > -	if (WARN_ON(!dev))
> > > -		return;
> > > -
> > >  	rt = &dev->res[res->type];
> > >  	old = xa_erase(&rt->xa, res->id);
> >
> > How does this work without valid?
> >
> > xa_alloc is called in rdma_restrack_add() and previously it was safe
> > to call res_track_del() on unadded things.
> >
> > Now there are problems, like __ib_alloc_cq_user() does calls
> > restrack_del without doing restrack_ad()
> 
> Maybe I missed it, but I don't see it in the code.

Look at the error unwinding

Jason

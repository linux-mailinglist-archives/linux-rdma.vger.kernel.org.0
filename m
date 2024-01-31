Return-Path: <linux-rdma+bounces-839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A98442F2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA571C21BF2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F684A58;
	Wed, 31 Jan 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ng2mHBEX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1584A57
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714617; cv=fail; b=tAtR61j6iqn9ocKmA93/0JMo04Rin8dRDJ77VxbvReLBC0H2E5XkOEGNkrtzIfHx+xlofKqSgePH1YcFQfgob+g4eTqzTXQlsRGaoICvkxMtkY8VzRDMBalsKlC7gqa3VMTs4rz7i5o+64GUoXRy8t/HCufbSh0mIoNRSzqEwSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714617; c=relaxed/simple;
	bh=tPh15yge26ep2GODyORFaWBlYW0chZseR4ZYG2KppvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjKisACaxGUJvFUJBwdbLcTcwPHon9QTpDPuLVc30O+AmhMLJjtv3Zl6hS0l6KHM49xGrrclzB0g624YpNEVrq1XLDJUwzXy7IHIWK1S4i8O5E18Viq0f02RX6FEHGP3f7or2bsCVQMfwaoiYfsk1tcfNgSVOTKegFb3N4gjquw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ng2mHBEX; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1r6c1TAoNKPs6AyT7Tnkhk4dht9QkG/7gGCN6mlAEuTjcR1pk9QVqnNsQ+z3alo7rAKbSh46nJAfuWRikXSILDGRNXhi8QZ5Bt/G+qvowiQZNwJILqqO3s2dubAEMAxwn0xhnndxXofEvM9oDVjX5jjeXMUtxqDG2Zkk/EucgKdhG9Ipyr9hv7S3AmW0kWykiavsACBtk85lugjU31lwPpO+MZGDewBArql13LFk0caOPO7mxSZi7ynYJtYFzGvAIK+R/CHkH3MxQzBm5VSn1xmfRaOCrf26WG7LwupceduI8A6laSi2kPb5zHZdQqHVSNlTLYKslbPD/++QJhIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNS90gkMOu5YjMWSvvY0ZvFGWMzMAxqh6CSlAeFX5Is=;
 b=SyzHHVUDdAMb7GwOql+kp/4Jtpjr6kiU+tm+2Zt+9c5h5Eyj76wL+Fd70eQsPMBEBlQBQ08Z0ehn1ZESDS5dOYhOxV6ePdDoBfBRqviovPqdhlpFju+oeIoj4xVCsUTK/0MIiYacKXdhkUzZab/c6gKuSu59C55Y6tl1OCdT/Gg040GofkjiqYWlZkiuGlxLPn/fIthPMbOr/E0gWDdaOrBwQ5A8ppudIdHaXxUeLhqRK7qRGIxxj4szWSRA/LjIE3JbBAmKWxitX3ywrL4pKGtklLmMMv4caOAW36CovkMzr8bYeV8nKn65xYYL+oalqyvauXU4tTYyKaF0Gf3UdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNS90gkMOu5YjMWSvvY0ZvFGWMzMAxqh6CSlAeFX5Is=;
 b=ng2mHBEXm+0c5oBcR+npUuQtTkm7rVdLaxhLQS2nxcWO53ZuYTus77HoXGKwuYgNsIWKOpc0biMJGw7AmVxzXJ70Sc4+4i8W0vI5FJ7L2hsrg0HMu+D4mJO6mNNoGSL1rMcjscp+p6tEYeVqH/aNGihonkyT2A4XNKxh4KS6auDzlcZl6LG6zyskZlfk8z/HVxIdwAEcce4dG4hsl1eEu9exEhL0WzQDdJwiwPy0zvscGxgIK+k7oB6SiCW7Pr/bV4oGsBeuYlffwb74yl/P7GrDsFt0DAfdJvTFxdpwnwat0dOvGZ4zSCPAfclyubbXF1ok4atg9/5wbXOhdWRzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 15:23:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:23:32 +0000
Date: Wed, 31 Jan 2024 11:23:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Message-ID: <20240131152331.GL1455070@nvidia.com>
References: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
 <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
 <20240131141810.GH1455070@nvidia.com>
 <25276919-9544-5af0-51ed-7ce5e6b8edad@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25276919-9544-5af0-51ed-7ce5e6b8edad@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: f9196ec0-dedd-4437-df5e-08dc227095a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z2q7nsl1iWvq8moN4Tqmnn/J4/V7iQnLBO7suJdj0l89lin+TiNwqT9HOFKk+JC1q3Z5r8qmsfliwciw5tJEdQ1YuT1J+2x5U9dchDKky9KDzMrNpNg7IJAnBrlp41GNA/S/KLgPIVAQMB7nW+oiN4y7OH3xlEQ295m6IfMNRUljEfnbhxS3cRivyeqqLoDnahoDZ8VUwwtsy4RWy9M0pkgUswRTEguQ5rvWCNE5UHtoniSeOxuJVV1hmQwUu/AryzLKnHr2ecUgvstEAN0jKCRuSW6fKwA9SK8M3wnNfBKBXamXIzDHrHmBav8JZOPceHFffTPXbb0LRcSnvIMycvLpmQkfwfAdGURMiEuPU7HtalJ0GeOrkvYVI0kZdICtppAZ4fU2Nfi1xyCTuOrX0Wv4J9AbHUdArrRNvkK5JZTcYBSE08v/VLygXuYeHm2w9s69BTfMcVsJp9aRdMXg36L2az0dFE8pwOrXQ/ASPI+hUJWV9w+RgbHrDqMkco24mcJ1mLEmQJZwD+VUIEVA3OA3mqr+32E4ZBbm13g5htsyJtqlevAkrpLhjizrMjXL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(2616005)(1076003)(107886003)(478600001)(53546011)(6486002)(41300700001)(6506007)(66899024)(6862004)(6512007)(8936002)(36756003)(4326008)(8676002)(316002)(66476007)(66556008)(6636002)(66946007)(54906003)(37006003)(2906002)(5660300002)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPipZDkdClKt5eXUC9MYEuPj7YT5tbF6NGw2Z6o+fHGVPZlYlI38I8WNbMcc?=
 =?us-ascii?Q?ZgXMRqYK1AsYrw/zgM9zccd87MVeot4BnFRnKmoqzYtGyllarkSnp0bJYaMC?=
 =?us-ascii?Q?vCFdFlgqnZ8PurL4Q9DaelTqNMXYOg+aExoWcWyp2b0jmd/keWYLnRjmsall?=
 =?us-ascii?Q?SVyaWpW5pcCbLRLWuzNPxyuC64plOA1p5Z10RvYWHq/uhfPX/XOBHH9DofEf?=
 =?us-ascii?Q?pv+zeNuZLt79lZfFbU+LzB1tHan3EudzqCBymFpkmiNST0QK67FYjqb9bCGQ?=
 =?us-ascii?Q?ToDTeLpUcN1HD8x3WrGSe+MhrNvvjxYkoqxd1vzStbAUMgBj6ff4H+4wl7/e?=
 =?us-ascii?Q?MDZj4/pPl5M+4IGxP3ql0ILIhgZ6xnhKqHzg0bT2SUn5gOQqiBnzKaWYs/dw?=
 =?us-ascii?Q?ySRl1q6Z712zJnx1Wn8UP+ix6KAeZyyaSLvgbaVV0BAc6O81+9EVaPjvUYDd?=
 =?us-ascii?Q?GMT3LaIJeGfjgmMpMB5ZAaZRdHwaA4Jez8w7Otre/jZP8XDXBbeo71jYbh9K?=
 =?us-ascii?Q?rluiE7itGmiv5Lr1UmoOBxVbMt6tAd4EDqeusxZN9U/O4FKsL+y3ZviJl5ot?=
 =?us-ascii?Q?5QHs1pvuU6NSU6B+KJ14wm8MvwBFgc9UyJrUIIautXd6eLSfwWenD4NUjh7U?=
 =?us-ascii?Q?mZrK1ELZem7MYGn3mOfP+zajKMRmUWFZRYpJvgrsxUgull3dvmFdv8uLuwD3?=
 =?us-ascii?Q?7mSIgYZWZgR3vtvBURKWFovWkP9CVewzDlg2t1CGEbUulg/R5nkma3BrKlg4?=
 =?us-ascii?Q?M9urLqHXfEjjGcRgfKi8VJO225TnkilRUnos7aldvr/qQx84iitHOdBZs7Hz?=
 =?us-ascii?Q?rP4PyULJ7TN0PCKydIeG1cL3IO9jnSAwL+aoMNHH11sJ96dE5Z0zlisWFmmN?=
 =?us-ascii?Q?KtHXctDe8UkRtN3fq6L2IwGBgBUtgFQpYNw++K76r+/L+cqyMPZJ3Gtg4CZ1?=
 =?us-ascii?Q?Cs3P+HIX9pt6pZboMPQz/ayqWo9xSD15XnBhdiE2qwKaJ89h7gkipxTKPVFW?=
 =?us-ascii?Q?Wby/Dm3STPATN9HWeole6jJE9ZfICvsyDDQDq1eRJ6q/mH/IYng0D2FGXWLg?=
 =?us-ascii?Q?d8qjRnwJ9iNx3aBzwYH6k2FI6oqCV1KohDWz4g+yvavZQZG/sEYkxVvJl0Qg?=
 =?us-ascii?Q?h7+HURDqON+F0hns/Y1ZKDpuPsG7guO+3H90HCUEQplFvaG9l35lnq/BCqDS?=
 =?us-ascii?Q?7812PUmMbL5hO4cCuViW3Ic88YAzuuY2lRGpJdSg1luyNmCsXszdD4QM5Xvb?=
 =?us-ascii?Q?ODB8fz8T3OP2HgGQay/+NiyeVWWb/ySMBOArxxJogxnHKXLesQvtcxfBCt1j?=
 =?us-ascii?Q?z9ulzqpO8qco1DK5CkhNqlsiBEpNAWlbsJZKQ6BPHn/eDUHgSMAHX+ilQQAj?=
 =?us-ascii?Q?se0eOrOTr6em/fBpK+yE+2U0bWAxywFF1dGSR2g+GlFlcqohtIQVH2DCIyOm?=
 =?us-ascii?Q?a8z9EHtFB7YLaJpfrZtaW8ThdnPb0iWWT5179u7E8/b27Gzr8ETxJDBb+AHk?=
 =?us-ascii?Q?b9UsxTMiW76kL0odlyozTbrPuLhFHSBMmvS5E3RI3+eO12ZfndOhtEVzEWwk?=
 =?us-ascii?Q?dsy2MFWSmOFZMdGmQjrao0D6Hz5epulXnVTt/E2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9196ec0-dedd-4437-df5e-08dc227095a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:23:32.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcZJiDD3mphcRL/sqomGZxT/b+MTo9Hi6pYzEpwIHZdn2FY1cU1S7EVmC5SgXnEh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313

On Wed, Jan 31, 2024 at 04:35:17PM +0200, Michael Guralnik wrote:
> 
> On 31/01/2024 16:18, Jason Gunthorpe wrote:
> > On Wed, Jan 31, 2024 at 02:50:03PM +0200, Michael Guralnik wrote:
> > > On 29/01/2024 19:52, Jason Gunthorpe wrote:
> > > > On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
> > > > > From: Or Har-Toov <ohartoov@nvidia.com>
> > > > > 
> > > > > In the dereg flow, UMEM is not a good enough indication whether an MR
> > > > > is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> > > > > when a new MR is created and the UMEM of the old MR is set to NULL.
> > > > Why is this a problem though? The only thing the umem has to do is to
> > > > trigger the UMR optimization. If UMR is not triggered then the mkey is
> > > > destroyed and it shouldn't be part of the cache at all.
> > > The problem is that it doesn't trigger the UMR on mkeys that are dereged
> > > from the rereg flow.
> > > Optimally, we'd want them to return to the cache, if possible.
> > Right, so you suggest changing the umem and umr_can_load into
> > is_cacheable_mkey() and carefully ensuring the rb_key.ndescs is
> > zero for non-umrable?
> 
> Yes. The code is already written trying to ensure this and we've rephrased
> a comment in the previous patch to describe this more accurately.

But then I wonder why does cache_ent become NULL but the rb_key.ndesc
is set? That seems pretty confusing.

> > > We can keep relying on the UMEM to decide whether we want to try to return
> > > them to cache, as you suggested in the revoke_mr() below, but that way those
> > > mkeys will not return to the cache and we have to deal with the in_use in
> > > the revoke flow.
> > I don't know what this in_use means? in_use should be only an issue if
> > the cache_ent is set? Are we really having in_use be set and cache_ent
> > bet NULL? That seems like a different bug that should be fixed by
> > keeping cache_ent and in_use consistent.
> 
> in_use should be handled only if mkey has a cache_ent.
> 
> I take back what I wrote previously, in_use should be handled in revoke_mr
> no matter how we choose to implement this, since we're not guaranteed to
> succeed in UMR and might end up dereging mkeys from the cache.

That makes the most sense, yes.

Jason


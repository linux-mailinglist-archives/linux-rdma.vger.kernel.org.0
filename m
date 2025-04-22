Return-Path: <linux-rdma+bounces-9672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DBA96AC2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59793B4065
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9D27D76E;
	Tue, 22 Apr 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A6L4bzg3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB419B5B8;
	Tue, 22 Apr 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326010; cv=fail; b=rH8782ay23T6wBEL2czVoA4wV23o2wl/j2vrsYPn3zuYdvQAWhzdo187q5+k1cDAYe1PxlMfj0U/I6LE3rKHgLO3/sE2kJDPIysapf+dsf2TiviFDEtBUAFU9bDdQbTrb90pK1jIB1t7iPTZhUYYU60LN04txQjpvpZeh+Coits=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326010; c=relaxed/simple;
	bh=mkEhkIxub/9fMNP6F54EScvaHVj74XTeuGat5UyFOIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=koc46cqh4jlxha9yEyAgk1Mh1n1UW020g+uPNyTGEBTbs+aVIebUbjlv3UYrZrVwUGS8yqp34kwLE2pnuZaWvwIeTRJGCNh0DyJkq5xGw+gNFDCe0aMHhUXHim3h9GlvbhQKCCn1l7t5ZxTVG9b6dKJJ+B3l8C0goySSCqGyx7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A6L4bzg3; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZzRpLvSpL0WNfA5uyNEEGRqg5YOElgIpVTdovrmZkugYRcYVvnfGMtFseI3Jh51KDdLoNjULxv3idgz+h7PuQGQ5ZW9pANYEZVQqKlcRv0EyBpschXyRzMVBDIXhDXzxv0msY0A5ztfnqQLk3+5VB/ytTypwNa8cdb2+fxmBHTbkJ6UoxmmiYrr6XphoUJNe3aMFOKJW28iSKMYx3/I48mSPyQBiAc/M8aRl88bLzPa+iP9Kqrw5CXSm1A+3kzcM49GOQRHmB3v8GVyIyEkrKDGlVy/GLjJTuT0/SbifH1ZFL55Qu21g1idmFts045u1RWjaf+QkS1JpJjobDE9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXItHW0Iwc/MCy27QtDHtKZhs5++gUXT0YiniZU8BlU=;
 b=LqEJfwVezyRl+ewuRbqmiaDoWJGVQ3zNy2B3w0OpTSvxwqhKkdy7TUlxcPU4GFsJwdrL7fxokSItWRsRqdEVXY1WzKy/P/YKB22jcZA6oS2181FDhNa3XAhclvFj9eXJNYtQoF8Yd+UYLw5W2Wot1tD/R3ZDSezdhdi1KoaIWenNbOXaISDqWzvPC1aViaTR4Odn2Wmez6UIMmSTIoR5jDMzqyDl0sp55mFvf/4S3nj5a66SXbRFB01m0AnwrBgbjxQZAvH/lailSxZy6fNianHnP/Ogcuv7bijTOo9oL9cQL9js9o9vIjrL9ZRGRYSBeVO1PQ37FwsUhqg8w3bhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXItHW0Iwc/MCy27QtDHtKZhs5++gUXT0YiniZU8BlU=;
 b=A6L4bzg3Q+blvueZW1XVwh/ieI1hpN18OhpghyrOI2xALMxTY/GTD8/1cg6+GJNkDMWHDItstZZYgVvQ/1RPfrFY5p3GMDbQ1LNmaq0GWWtW8Q0A0k9NQTWTUQeAGg0sWXO7aMxd+KTEV3bO8IAJ1Mhvc8g1xXsD9zV8LjJfKMx7okfBriTONf6+ra6wBNAmtiMvzxYJZ+DbIY0cMtiniup20ctCYHMw3dfM4mKx99hGyb4TAPnSRQHNqxhDNB+OTn0QQ+BsfWZHz9TUvDIbinLSCB4bz8T82TiJGFNMRfG4TcdpycXOrq26I3deZZFsDxrQ4ME97LKbTkupTPW78w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 12:46:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 22 Apr 2025
 12:46:41 +0000
Date: Tue, 22 Apr 2025 09:46:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250422124640.GI823903@nvidia.com>
References: <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421172236.GA583385@mail.hallyn.com>
X-ClientProxiedBy: MN2PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:23a::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c1ff05-a213-4d74-76d5-08dd819bbb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NM4BktkM+I6uaecE3cwVdTllG7xfcv4FK37ERE4l4DcRWhM2jkta8xKGFSsK?=
 =?us-ascii?Q?DxIJzKiALnwcpClI7ge32xKTr2yA/BQ1uAmDIDhF/oJMCBp/unnHfmOKgFrU?=
 =?us-ascii?Q?12mrzbCEnhPKZ90854Z+CPNlFTDdY1yLxS2qhezjJyfoKMtGh3GVys0oBPpW?=
 =?us-ascii?Q?trIGVdF11YLYaYet9FidfFA3B16CkK95meilJjdkp19khHC65gRySmdjkuNu?=
 =?us-ascii?Q?RK37BNWIP584wgXGbA16toOuEchaIEvErMvY+WBOWD9EBDEphRd4Mw/S1b+Z?=
 =?us-ascii?Q?z5kPji8oFp88RFONtWA7tLe78bc5lrYWiHMkxlHfe8UQAbPJW44j3tx8jEpG?=
 =?us-ascii?Q?k161FR9G6zB6T6IPK9NvWWVfL3g/P0jhgDpt+LV1tuV+zzxqOu4SqRO9RRHg?=
 =?us-ascii?Q?d9PAQrTV9SrotAcliZWCWe+uGUD3OAUSTkVrRrs4hM6u149N98HtYzmbcTBr?=
 =?us-ascii?Q?x6nH1x4AjtVMumAZxMTUjuMZSnYjZ4V0tKD8wD4fbxSmL7oIb52JIGnPVJYu?=
 =?us-ascii?Q?PWEJLBWjy1VANnRMJUvU7Bh4KGdl8eJeac6XnzEPjIZR12LNacs5Zz6eAFu6?=
 =?us-ascii?Q?410NFtiDf8LVStokG/3I+vKvu0eE44nP0DVLu05QddJW3CJ+rVaTTa7BljTi?=
 =?us-ascii?Q?ur7wH6piYLUS9kYqqJtIyE29+mPTxjz5Pioc1P3hguy/8tN6ptu4pdtTGuYD?=
 =?us-ascii?Q?ZoEQUVro+l3BevdC9IiD+en3pskmrzzJeWiXHNuZDNHTXc7SiLa726ssFIh+?=
 =?us-ascii?Q?c3DL5vCjFZRW01FzOunEz6QwTuG2kzQ5wpgskNHgvKfEnAAqwQrTnNfXWJ9F?=
 =?us-ascii?Q?6FjaepFkAE15xesY6dzox7Ra7UcXwy3C7LQot1c1ct5XuFwXAt+7Mi6Ak4Vr?=
 =?us-ascii?Q?bCCbkl1/CloBjB2t/Dhu9rUkrieJw7nBOlnuJq6gzS40vvXPfSoVZv6WOrtz?=
 =?us-ascii?Q?J2+3O5sxtdXWxYcyiTx5U/+gYrPThUUtXM07Xw75oJNtn3wLSJKo7YDhVjP3?=
 =?us-ascii?Q?UFR7Qnqc5yEja53ThgyIywM5/vavzekNLUg9gF6FKKXi0JL5NPGgrWS6c9zg?=
 =?us-ascii?Q?RAtjTb/bKMp265opoAaaAp4lekwweN0i/dF8BG+YVe8PlCEij6qXzjOAkKM9?=
 =?us-ascii?Q?bZt4kumwRaYumUiKyUHQqTJ+X9/iVThI0X8VKHliBb+rmHOSTjMzhseLrj/q?=
 =?us-ascii?Q?dcF3p6orUyYqYC6JC7sIWVxdIbVYKf5RgZKBK0M/2+QODRjThodRKjYTl0h8?=
 =?us-ascii?Q?RC2ucJlT/MUnGJo5pcBKaK0dZ4N6WzaJNPY9F5G3XlvCAUSzHv/QpR7U2jK0?=
 =?us-ascii?Q?p4KEdLKlykeLDVZHeo6imoUqvxzsacIicJ4TRCj7J/cJDNcytch9m4NWH51o?=
 =?us-ascii?Q?F/KfvJnyLUmDmQyQ+Nk7risPIHDRAu/aKSyeTlZb+IZ4M4AT6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkRCF8BKksVjNW2zHTS67tht5icp1vr2mmzi7w/oD1xlkDhyylsrvu48VR3s?=
 =?us-ascii?Q?+kdRuIJtT7iYogFVX3XByhBVrf0pNWF1XLW0e83pDon3TssmhN8C9OM9Vhwv?=
 =?us-ascii?Q?ypSI/b+y8z6kA7LRqS60fHdPD4k5CuL9a0QNyKtVhKwzuvwPDJYw3zFxY4F5?=
 =?us-ascii?Q?PhIKuhowQALwjM7ZJ6psd/XdaHW9a+MH81taMGAUVL8lEQsEnp7RwZ7twDzj?=
 =?us-ascii?Q?D1L0iPCAvhoMjKmFHuYYZ8+mXWk26g5ZLXfKFe4uQ/BI+OIaByhyi94jY6Qu?=
 =?us-ascii?Q?df9+OcVFtHQaoz+lJ4ecHDqxI+x6dqSAoDlbFXnQ0UoFzcq04VvgNsqQFn78?=
 =?us-ascii?Q?Owsoh0krkUeDEgWo+KXbQA/ViK8oC1IbFs96GOT0hL/wu66mWQlvicJbVpZM?=
 =?us-ascii?Q?GTH1aEwJWAvJJT8tNTi96gEyje5ZfTA4wSQMtcc/cfVdUHwDDyacxFrLpuQE?=
 =?us-ascii?Q?QLu4XqXLSzpyzBl3k1G939Q3KOdEhxBwhefQoPlo/Wp+etAUjHyhL06oaXNy?=
 =?us-ascii?Q?CKP0TkEK1X3L+HnDzAOewVsRVSCsRW2kn1leVbWHLuCUoxCN2OAEYgSvo3LO?=
 =?us-ascii?Q?lS9u9eL1SfSQXsR700+Afjzh/15HLT2oyF5uxNLAsOpiTK9PfW0eDRVWnSNq?=
 =?us-ascii?Q?zU/MklbpmuuZJR6tKghXrdrdEEOOvzjnvnGqHqy2PJwJ/eKW1114hbDmPNiZ?=
 =?us-ascii?Q?cndFxx8G8ueNk1hEMA95r3pfZXRJECSQXsnCqYYIpGLiqraFcsiun/nDvLci?=
 =?us-ascii?Q?g7ZrFuyeK3VDHmgdIXVJMsceHOO+eeLzU5tIjYlrt7G48Nri22UqsVynYYIb?=
 =?us-ascii?Q?Jjk6n2mFVH1XC2Cle7KkCj97aCRsF8t99Ne2Xyz89430Tq9jcao2glGBmOBL?=
 =?us-ascii?Q?vgJygi2vvKpC4HRQGd09LKD4QD1nwFuIfCTdHmwSLL9+PSli0B3p+xAaN7BW?=
 =?us-ascii?Q?zz5Y0yDmWntwiW8pSm3aVmGPire+gEKaN6k/bw0zODJNaMNPptPlB20yjVug?=
 =?us-ascii?Q?zIWKMZjuU7q8n7fWmTBSWM4aTtmH7mYWSQOl6cEF0EPuyCOjInAy/YRVNAy/?=
 =?us-ascii?Q?csi+X0IDDOlVO8vZuLkcqSB44ceLZUQgNaTpoWNdpJxbO015uS2dwE9BK4sN?=
 =?us-ascii?Q?6Q02XvFSkaLgh5EJ5YDvUTaMkcC4TGJ1sPFf1eccA/kx4ql+vX6vLbLLzvXN?=
 =?us-ascii?Q?S+8E7oo2sLqC9K1gvyd+oWZVHT4AXs19poPhY6hLspCOIGTEBKpIb/rAlQDN?=
 =?us-ascii?Q?f2S/SzjMSf/CBIhKzACY/oa08hsgpGuX32As+RAaIiJGVAse3ksLXfGfIDCQ?=
 =?us-ascii?Q?qN5xCxRvwrWUpI6FtD2LDcdjgF+65reg7NRAWxuOaLs2tSzpbQPgB74ouMko?=
 =?us-ascii?Q?mPeT9Gv10Lk1z0SAi2rHANSonxlP6gSjIkJ8yhWOfk/kLReRRccKpf7JoY/I?=
 =?us-ascii?Q?EIPu0Lg2EN6jul4DDHTwrM54MVaVJ67CtwCyqmUKK/A1GEsAMVE/GNMDnlTB?=
 =?us-ascii?Q?Z7khkcOhAjmaSvdzNCvJkPffh3E7gYrgwhFESx0v6JSr27SFOqEtqzhXeXda?=
 =?us-ascii?Q?+ruuSTWaoHquhyLOVh5/PgRyDiyXCHCefuFWyBmq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1ff05-a213-4d74-76d5-08dd819bbb03
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:46:41.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLB6JpzhRgf+pzU9n/uJBgT6bl0WmfGGNKzpuNlSHDPXYhTD9TwaAf80CAv6i0sn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> > > CAP_NET_RAW) 
> > I believe this is sufficient as this create call happens through the ioctl().
> > But more question on #3.

I think this is the right one to use everywhere.

> > > 3. the ioctl should check file_ns_capable(attrs->ufile->filp->f_cred->user_ns,
> > > CAP_NET_RAW)
> > > 
> > > Two notes about (3).  First, note that it's different from what you had.
> > > It explicitly checks that the caller has CAP_NET_RAW against the net
> > > namespace that was used to open the file.  
> > How is the net namespace linked in #3?
> > Is it because when file was opened, the rdma device was accessible in a given net ns?
> > But again the net ns explicitly not accessed in #3.
> 
> I'll have to look around and see if we can deduce the netns from elsewhere,
> the device perhaps.  But IIUC the file's user_ns should be the one for
> which we checked that it has CAP_NET_RAW over the actual net->user_ns,
> so if you have CAP_NET_RAW in that user_ns, then you're good.  Where it
> *could* get wonky is if the opener was in a parent userns of the net->userns.
> In that case the file's userns will be sufficient to access the net, but
> we could end up denying access from a privileged process in its child
> user_ns, that is, potentially, the net->userns.

We should never be taking any security check from the struct file.

All security checks are only done on current in rdma, the context of
the file opener must contribute nothing. The file opener could have
had more privilege than the child process somehow, and that extra
privilege should not leak into the child.

Even in goofy cases like passing a FD between processes with different
net namespaces, the expectation is that objects can be created
relative to net namespace of the process calling the ioctl, and then
accessed by the other process in the other namespace.

Objects should and do become bound to the net namespaces that created
them, just not the FD.

Jason


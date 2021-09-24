Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3541711C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhIXLrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 07:47:25 -0400
Received: from mail-bn8nam08on2077.outbound.protection.outlook.com ([40.107.100.77]:38453
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343604AbhIXLrY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 07:47:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJDg6L+1dBVmMItdpwNyVT0Bqn1g0XzK1PaauKlcvyMJYMgFqwy/FGc7LDaWFw8vytvlsruUyRYKYPp0judQasxNjoc79TVf04OsH23BXsOU1p+T4ha9DFRl4RfPIC0y6h5brjcmhNYy3hDdyGKKi3WAVMBSsv9QpqafSiabTUmueJHYC3gxo1z1B2xnJq9xxGzrhWfkKWeI2HXCFlt3joywvNtYdxW4a3/bRnfI4Oy3syw6Rlg1oh0Bv4YACzK1BDg9znTjNHtT9/RJGHWeQAyPpkY+/2PcPO7s4tyu9OqVe6TOLXpGk+QN0m2HU92JoQo1Vid/oCwuzWJNMrjj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6hCC8f+frD+vtSz95CHLXIkwP6v+N50uSR5aT7gFcAo=;
 b=gDtGYiHkpK0hqO4V/THLVafLsIkfF6+pZGclImyzjTGlMBPgSwHtJHKl9AjRQokyUQntO52BGf96KFoOLzUPbjb0Dnttu5b5zHmFd+ZQHLXXattNfjrcxfyfr6yxy8mIpgsBQM8a/odvNIJNJXjtoBSebd6dve/h1CSxd7lGvqndIWTArP3m4VDdv0z6a5GRCMeYYMAXvs0Kgq/RtjFeRQBcX+xoTnDqxrRUMFjU6x7hd8QtnMn2piMIS1PEc1bIMjfKtfHhqqizVy6AWTpJdivmcdBQwzkDcoIG+Pyjj78DWSOEw38AuM8UCmZ6wpQBkxwUoXfmQsy+qk3V/YLrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hCC8f+frD+vtSz95CHLXIkwP6v+N50uSR5aT7gFcAo=;
 b=ao/PXvyIUMEwwx5aCPxG3RbVAxodRmgJ18rZDGNQ0qs5CthnL/pk6t/UDEhQH/TpYeiDNYT+rrEueoLBmiNmAmD53GPPp5vSpXeEnP1uKVPaBpGnGl4UCHZyx2mFetJS5nvlG8cHae9hQjLOaYgjQOM7r04ILVV3ZQBXzCA1jj+XEXb2I4S/ywPeUUDfkRO1Fu5nbTNnlOPIeK9Ee70l9NtwFg0LjkJpTRCNtX1vNhC8fU7wyr+/y/5lM056oMzsYxq7eT5/vDMaIWfeChj/nY9EHL+DrOB9IRj7tBpcxb5kYiFjOI1NIsx4Ih/Ro13/Avj7TBh2jJpS3yhxRgYhbg==
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 11:45:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 11:45:50 +0000
Date:   Fri, 24 Sep 2021 08:45:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: rdma-core and travis CI
Message-ID: <20210924114549.GU964074@nvidia.com>
References: <20210923215746.GS964074@nvidia.com>
 <cab3a248-717c-9b6c-28b7-c767d7fe5f15@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab3a248-717c-9b6c-28b7-c767d7fe5f15@suse.com>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 11:45:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTjeH-004s5A-8u; Fri, 24 Sep 2021 08:45:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22496647-ee9c-430f-2472-08d97f50db45
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52877074E0908A854CBE4C98C2A49@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJKh7Bvq7IHz6AukaO4Ca22Ki/5UCEdWgbbEQpoFvFETrsYC+4pYOU/31bs0b77uJ7mkSHyOJinPo/JAsBjHXRrm7l2gPdXoD0NA0sdt/qI1SBWd3cVFaUnz5c3pn7GVJ4wyVlV2Ecz10j9W2z0053TmdSbyoq/FQbBOJ/86qlXuFcN7Y1rBf7CGrlT1uZ3ubx6J43y9iBiDKr5uDHpfjhgTQjhspl2Dq6DCGP0CZaXGig3ecKeL2JuAs8NGYrzCqcFcEssDtpgORNRlRWZmaQtU/QCsGn1zV2EZWu+8lwUtNPDDexJrpgbc2HDigHTej30oKvRPeBC19ZmhOco73zsnHSK1s3aLdweXU4AmMtfkvbdshp4yb5Y9FzYw/8+5C+EHT6SO3Grd5eTNkpx/O7n+8BmW3+yt2sSvVIOgUYaI8WT5eGdVSrbUBljzGm7mE/dLTw0vupoo8QARNliT2FP0YlpOxvYdp9LZAd/QE0344KWzFdMR2jsOs3NymX89ZwtrgD3CEbFhSocg969x4YdgQ+WjrNiZ4WJ78Dpi5MQ9plZCnBPJaWGDS8TqCFlSGT5xiZF9QEM1Yn7fjQ1d/S2nGeuqBdI4xJWklMuaudCqkwdErRDn7EvEBJii8buqnRkZUrRxz8me8abNKgvDIe+8ibz7EC9J9qpVW8rUIVvdyeAVEH2uxTqtMlhfMGEoKkYs5TRkbfMpRIBGjQfS1Eef06/bQ2cH7HZ4pDkqkkaUeUUHy8Kmt2Je6EQ8YyAjfmLWZyz/jY/nvbPy1ZRRPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(1076003)(426003)(38100700002)(186003)(33656002)(86362001)(3480700007)(36756003)(2616005)(508600001)(966005)(53546011)(6916009)(9746002)(4326008)(66476007)(8936002)(2906002)(5660300002)(316002)(66556008)(8676002)(66946007)(4744005)(9786002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yVxlKSqf4r57q2ID9D/oH97lzskKZRsdCwOWOSGCU/sUf9+rTWO8AGO7CJIM?=
 =?us-ascii?Q?jdeWhxvdZBGJSq/ljsQaChK2Gx3BEecfaYmH63cIERTezwPDm4lkyrWF5oyC?=
 =?us-ascii?Q?RZIx3Xe74a9m0BGA3L+C0htVxoGJQbdTrJz0yV4uxH0QFsTeIBCMjTUhG4Is?=
 =?us-ascii?Q?wVa06L4Z6bOCqaK2DLcYxePLMYAFc5t3U5H2cLsmdlhbeAPSgQLW0ezfl7/w?=
 =?us-ascii?Q?nSWfkUw08gi7fJJ2mQezQ07uxrQEy+70cAUmW1xFeIwN93/LZKqs8Pmyjft/?=
 =?us-ascii?Q?qfNasrnB25TFwi6w9LWqacGdb6EInxqeeRFORRkMe/BgS2wLJRAkGHKIC4F5?=
 =?us-ascii?Q?MNFKzPfMZHTTJanXz+hI41bFFhLluS3Lui0mvPhDSfjjurZf+75pi/KVUlS3?=
 =?us-ascii?Q?DG6aDJ1YZxiDy9Bz2evpLYmtxGhGAk44YTtI59f6ditjgFEFDyu9LtnfA746?=
 =?us-ascii?Q?wLABWAbrL0b05EgfBXveiYQ4NtYkMgzfzIq315tBtGTrW3HuCBB2P7EtO1bo?=
 =?us-ascii?Q?Fj/W7TKg6QlLnGe/4+PaxhdN8cyxfapvBKZfr8rNwyp1jUPCfM9aGmnEfNae?=
 =?us-ascii?Q?9prRrjnIiphsXt5M2aicNcDyJ2iwfT/ltXeweqJMorxWZZTiw2rWX8iftMNf?=
 =?us-ascii?Q?PyFh9x9nbYBHR02qd8M3geHCdj800FL3z1Ul4dNeHq/09mT+Ow9PtdEAtpzT?=
 =?us-ascii?Q?w0UA4lk8p2aMbpYcvw2bF2wQWCJethP7otz+CifqRnnvGNleDWeizCIB542H?=
 =?us-ascii?Q?wU6CqHnXQ1ZLfIqAsSGJQ/8Ms1R2wEZRYeAfBdQG340bvaylHDY4oWlprEBS?=
 =?us-ascii?Q?ZZAWhbYNI4c/LeXdRB05hZ+KYZO0vcLAPRb1rYfMhe8VLt3rMG6ARaBtYL7E?=
 =?us-ascii?Q?B5y8wuuJBXRv4jF7QUmH5r9BuT3Z9s9J3OWgK660dZoWm+24lAWtjLR9o/4s?=
 =?us-ascii?Q?aiVXc9/9wt9jQXKdkXi0bhbtQ957/GKL4iwpEaWm47gFLt+TvV4Pt9x9XH31?=
 =?us-ascii?Q?uJbK0iBQAQG4nOi/MHj6bIdoTwwAOP8/QdNLPlQbkgK3tHhJHDKy8ut7dVlf?=
 =?us-ascii?Q?wA4r9FimCYijxwLOkKDUBL70HjNVsqaOXyhWfGATWGl17f8fiaCbCRxmez1P?=
 =?us-ascii?Q?ydv618bYlU4KupPXraRd+JIjOkShv39FHscwrDtf8umsgQD5T/M8/VroZjjS?=
 =?us-ascii?Q?EMNH0yQgfDc9yNQHjkwgjAHmbbh97t9MP4Pbj5T3kdQPVHCsV8v4WDj2G8Gv?=
 =?us-ascii?Q?wTKo9dvdyUbNVst+a0EGmBmV7vnuaMaK+WJQeaYvhavlUpUs/maqTElkrWGR?=
 =?us-ascii?Q?WbLgNQV7TBhraAQo2LTpLIAI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22496647-ee9c-430f-2472-08d97f50db45
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 11:45:50.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtYY9e4vYKohRHxuvkFFDPcyI+Mbhh2Qo+jJSI5aUtBxIANcBLI+PmDGckT389Dx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 24, 2021 at 08:02:51AM +0200, Nicolas Morey-Chaisemartin wrote:
> 
> 
> On 9/23/21 11:57 PM, Jason Gunthorpe wrote:
> > Due to the security issue with travis, and the general fact I no
> > longer have any idea what we had/have configured there, I would like
> > to permanently switch travis off and revoke all its tokens for
> > github/etc
> > 
> > The only thing still using it is the CI for stable branches
> > v17,v16,v15 this all all 2018 vintange stuff and I think it is
> > probably OK to let them go at this point.
> > 
> 
> All these branches were retired at their last releases:
> https://lore.kernel.org/linux-rdma/046b9cdc-881c-c02f-57ad-f929a5b8803f@suse.com/
> 
> So yes everything is on Azure nowadays. Feel free to drop travis completely.

OK, Leon can you cancel the travis accounts? I think you have the
login..

Jason

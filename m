Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB4219446
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGHX2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 19:28:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:60296 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHX2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 19:28:25 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0656930000>; Thu, 09 Jul 2020 07:28:22 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jul 2020 16:28:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 08 Jul 2020 16:28:22 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 23:28:19 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 8 Jul 2020 23:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbynFUGSDHkK1ZIwJ8qbtupNIna1lobTeC66hEj7vBByuHm1Ng0Hag54OItyoITqsHshIU7ApNHJyPhsmR8WKRhkOfDlhXcfPcNllPAQRB4iFTFMqweVg6h0GDUS59xjR3DrRAtkvGOaBwlwMq7eKZ0cQ2ATFsEpiSN2nURsNkSyjOYp0UegG2U/GK39CJtaxz0iAsWFgfPwthzI7IJj7LHC1Hepr4n5RjPEuJCGGAj8VF8VvM+C4BVWICEmz/cfTyEo+9g4N82cEJsppMHavaV1mw7GO8N1lcBIWprGmnluWMfxGDd/DAlKlNSRqlnecQeBxWFX8LZcndtxp1bfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pHc3oyV1GMrF7NQimtuu/BuJzuLsIpw+UT5/ieaZGs=;
 b=eBFupWQi2/DTZwaNiFEVy0unC/OOSq8nsKSdunPgmLqNFd5muppj+SfdeafVHydKesb8QkDPmF2zjgGsUMNfiLOOgAZarjb1KTtvLV2P0i8M8wLI3mZWd1t6Wt+8+bvgqym3deNlltEAofVmfWK5EAw3Ta6lcflxBLv2yG1fuNCCyvETnLqd1szoWKSyQIg3GqHP4CLLx+gWeV3JWeF5sA2uFsBmriSwH1rVlC6xHcCkfY8KGKyVNF1Wgw6VJmL/kzWKh1al0HIR/BOtHjtDJvtWsqVsHKL1ImOu8wuSpye3BLaVgLWjgRiv5RDnKlHdWyUOaYOsmhus3zZyC/h7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 23:28:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 23:28:17 +0000
Date:   Wed, 8 Jul 2020 20:28:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v1 0/4] RDMA/providers: Set max_pkey attribute
Message-ID: <20200708232815.GP23676@nvidia.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
 <20200707161247.GA1375440@nvidia.com>
 <20200707191324.GA463589@kheib-workstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707191324.GA463589@kheib-workstation>
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 23:28:16 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtJU7-007MWd-Hu; Wed, 08 Jul 2020 20:28:15 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a623a2ea-ecaa-4169-cc69-08d823969788
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2583D2CDC3865188AD21A547C2670@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LArpajxjn4Pz7pkt6n1Q2Evzl8gtXcqvMCB6aQgn/hUabHKCWhwmnn1LbKEC3NxT4IX61n32nLhu2Qa9+EviF3eMuXM4rFVNk5XxZ2pqt2H+HosxhMIU9EQUwNjd/wB9t/QfjIRoBk4oVo0iecEpfO7sIjdN7gbGjrFstKMkUu+thxduJet8g6dX84JglZ3FC4F9XcKHk06t+7IbBdgPV1+RKSQYr6v+owjUgpHXg5WjsutOw2uusK8UjFiutCgN2W5eAAD4M8QKkOlO3akRMaUns6uuvXPaOEAhZGyCjb7q6vme44N7HGwWA2nWb2JztFFs8RKXKqLu9geT4d1QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6916009)(186003)(86362001)(83380400001)(5660300002)(66946007)(66476007)(66556008)(4326008)(2906002)(36756003)(33656002)(478600001)(426003)(2616005)(26005)(9786002)(8676002)(1076003)(8936002)(9746002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4jzc6NXnuI8uq2WXxPR0+FcIpVfVKnmfVAEN1beY4qTDDGs2WTYpDg3g3WGTI00GLGRce9d0KtbC5PkyF3etJrY4Q100kYBCFPg5p6Lk0C/VMEkztmftEBxUnwWRsMoEskv1Euwd05hjKIcJr4UAN5HCQ3Y//8ph6qiWTZArukr5hnlCrabFVlERDN38Pw74LC7hCIKB0/Gu03jQ2AxcJoQdm15dWymVEQXJQmGXDlwGdGlCqfHuX0bhptL3NNk5hoQK9k2oUW1pJrp6RpLTNYX85L2OXn58ClmJ3WgglfeXAQwxhRA9kzeO5YnvzovVedzklxR6xEmB8gT5JozbYc++AGz1L19ZTcZY1fmrgXYtukI/z/LQJBj7QQOxBjVNK1iwCkvtGxv5VD6h4C53U2Wky77+pv3QN8fvCklnLwUWIxMkTm55e54cZb2glDfbpgXfqYujkbuEdacxVs2OsxGILQ0HL1OOQeXhBqAG0ZMihs1VXxrY2CPZYtV1OFbC
X-MS-Exchange-CrossTenant-Network-Message-Id: a623a2ea-ecaa-4169-cc69-08d823969788
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 23:28:16.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7Uu9Ny1RXJyvCtiMm/NuKWGSOoCVGZ+T7DgnK3PIRRhgN8+/fHX/NZv4bNCRgt+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594250902; bh=3pHc3oyV1GMrF7NQimtuu/BuJzuLsIpw+UT5/ieaZGs=;
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
        b=PdY6Hm+u6HKNZgA0w+ENTha0C0WNQyiAOYTXBxWS7ENMI/4I8Yz8R3KXG7cZ3sG7M
         kXBxsJMD8Td00v6aP8ewnvrmRIpaF6BXtjJEAdGwBHQlBtAXehf29vFQ9naaLWOQvd
         K9F2A0BpgBpA3dJY5LppL7xHUN0iU4wcXa4B1/JuE7iCydlXpiFJSfvCsSPqVYJ7iZ
         +rl4ZAcKYJWCBom2aInGYYKl3EcwZA52xNIkfrNVACVZ5GECLKbh7rB9wxgF9jS2MG
         CtWToW5ly/7zYm35j0H/KW19Pw87gXwt0IWQUZSthqKWz4LVlePr6rdM3ZBpBJYr3u
         +ZUP64csytleA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 10:13:24PM +0300, Kamal Heib wrote:
> On Tue, Jul 07, 2020 at 01:12:47PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 06, 2020 at 12:11:15PM +0300, Kamal Heib wrote:
> > > This patch set makes sure to set the max_pkeys attribute to the providers
> > > that aren't setting it or not setting it correctly.
> > > 
> > > v1: Drop the efa patch and target for-rc.
> > > 
> > > Kamal Heib (4):
> > >   RDMA/siw: Set max_pkeys attribute
> > >   RDMA/cxgb4: Set max_pkeys attribute
> > >   RDMA/i40iw: Set max_pkeys attribute
> > >   RDMA/usnic: Fix reported max_pkeys attribute
> > 
> > Why should iwarp have a 1 pkey value?
> > 
> > Jason
> 
> That is a good question :-)
> 
> My Idea in this patchset was to match between the reported pkey_tbl_len and
> the max_pkeys attribute that the providers expose.
> 
> But after taking a deeper look now, I see that the RDMA core requires
> from all providers to implement the query_pkey() callback, which before
> [1] commit that will cause the provider driver not to load. For IB
> providers the requirement make sense, also for RoCE providers, because
> there is a requirement by the RoCE Spec to support the default PKey, For
> iwarp providers, This doesn't make sense and I think that they decided to
> do the same as RoCE and to avoid the driver load failure.
> 
> Probably, The requirement from the RDMA core needs to be changed and
> the query_pkey() callback needs to be removed from the iwarp providers,
> Thoughts?

Sure

But then the pkey table size is 0 right?

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0120337FDF2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhEMTRF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 15:17:05 -0400
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:4353
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230394AbhEMTRE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 May 2021 15:17:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt3wE+zjAd72l8xeCHxJg0NUJDII0REtDEA3kKFIee4CYF7KEOUBf4s28Q03t8lDhZMY1H2FhXxNH8Rf9MdabQ0I6uwm0jFYm0iTMZbsgldYePV7HAclb9l9SYros5m+aXH2Kh0mO1MZqBOeDzLDAPBghCjQ6fJuRUsXaMF+b5tLrhLsBoX5qexfJQgyPzHY+L7zcJDk8zIqxrAOOUfzIMFYPQoeZy5dJpw5vR2X41SQd3aGQNY3XM1SqV7g4da5Ua7L4SLxvxYMkSE8Vq7zd/SWvt4AN94i1XBOaFIwf/9muLdKD7nemhaSp/nUtORn0Yf6Nw+DQ8507PRKKhnmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/DPnEWXmsCfFcqUipVhfULyGNrAL6/eIIOdn48ZHPg=;
 b=QLEQAdJ0jz9NgVOXEy9sO2srAEzFnRaWHaq455X/lfNrBWUxLLMlHWla4nxdHGTOaql/7pX36PHnA27yfeWs4VfnBgQ9bpiCtCqtq++QFpRO8SedqCOKiDiVaaqyhRD4bafNBCy7W94yp+9oIeLBzn+dRC4zzBv1O2O2E9aLj8/M14mpD95k20zViJOau/FK7zRz2I47N+yOI6tpDp/GxoF8FnUDsaUw6seQ1a+6D9MlP1AZMZ5SCZyNFZVpKmtWHhAvnDGqPu039dKYgM/jsBsGMlOIESgmVxaev4i1zWrAqY/ffHP9RMAveYNNZRcRqigQuITku2x4Ltfkiym+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/DPnEWXmsCfFcqUipVhfULyGNrAL6/eIIOdn48ZHPg=;
 b=N1zeEa5U6DzBjxOSZAMnm3NMkl5DzbDc+2k7xi2rQMk/rqR5/hrRrO+EyNiLIDHsmC0eNxjzT1OlbqsUl0q4fTKYZuyRhrvaZpbF38RBb4Lw5KW48LlBDdzi6HM8LBjuXB9IHwMLE/08IKmoqpT2XoTGCV0x9FzcYKA3ff0NQeF7FIqu0RIC9V8pz2CELEE+KmgiRsHoc9rUFsvWqkggymsoEh7PR9CzlAdet1bqmsid19lyoH1a7DREL0LqYxlJxNJac3tKQrtgMX1khYJ9Evgmx0fs3K8LI7Y6c1TfUFDAe5qIh8/TbSB1GZH+hgc7pyYqhrIEc4n3EOYnbMBMFA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Thu, 13 May
 2021 19:15:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 19:15:53 +0000
Date:   Thu, 13 May 2021 16:15:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210513191551.GT1002214@nvidia.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.50 via Frontend Transport; Thu, 13 May 2021 19:15:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhGoJ-0079yf-TM; Thu, 13 May 2021 16:15:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f66d43f-e924-40c0-caa8-08d91643871c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041EA68CA6C6E399B47834BC2519@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCaPfEOj+jW7pwmcvrP/OxytiuQj/VFBJreIaNX5eZ9A52yVOwD4DMdLl/LNzDlc/EWUA1tiuR7VJ1b7lqctgsld5ZI4afRjsv8tk2Xq4+kURNsA3aeYLhgFEHeFb2Hphv2AB3CI7rsz4Q1N/xKX2O9QDlntJnj5uCfaUBNzoOykJ8Cnc6ba99DWcvMO5nekOYXjGRAXWYftywaSALow+VI/Bbv0tuXgyxrrkadIK/CSgjX1646XbIWiOtPiWePYRulrhgn1mWeviPJK3BAzDQ8oiZh/Zy7RpQZQMdghbXggIf+CSmKs94zuVc3cy6gFG9a4fOw7ht/qcqQXdrJoWwkn3lnUVhuBtbsjgwQ5UFTQaDkSsIM7KAEsQx7d/OAqaBk1QFqmQD4y5OX3kjkE7kinPGNYcV/dHPBE8N3o1u8oTEzkqlYcDPJBD1AIL0nPkPXS5dEvcWmO4vYNDqXytnYVnS5FEgdzCxFVgMtqQx62dPcQls9BPj+zoMij6RjXomyOKJEFPnhAsU7QE6S8NGoe09C9VNCFdshQZRbu52dHL6zkhWg25YzNx5dV4OdBxCdl5OwQ7h7cZeS8r9HZXNKScrffMPajqDO0VcQYKjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(316002)(54906003)(426003)(2616005)(4744005)(8676002)(8936002)(478600001)(86362001)(1076003)(5660300002)(66556008)(66946007)(66476007)(4326008)(33656002)(53546011)(9746002)(9786002)(6916009)(2906002)(36756003)(38100700002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yAcLReC99RN9rj05jI9CGuulSdXsfxbJnNQSIYc74rffoJF21CI7LIs8rDyr?=
 =?us-ascii?Q?7C7gFwSagXVbdqaS4RtYaAGFWP2N1v3+wJnYh3WufKHXV8hrhFnfdiWlaOpj?=
 =?us-ascii?Q?DdDH3otClFdZQ832HFN/kM1Zs+HBpPq4OdW07MWtXJRHd3p0gKKQELLdjJbN?=
 =?us-ascii?Q?f5ifFCAzIOEIr4BCmiZjoIUPtJ0bfOY+Zsv2pQG5zntWI7UWrpfvGX8AbdbR?=
 =?us-ascii?Q?off/m6Bk4pVvLZceZSuv9Xb9VYGjr2LNGvIL2bcbpfOzHPxte6LWpDr1Og6N?=
 =?us-ascii?Q?XO+JyLEt4OndYtDBWWlGlyscL39iB6oHAraVj/i23cLDGxt41U+4Hjg2hvBy?=
 =?us-ascii?Q?A1dkBbKnO6R8uuU0TVLrZw+dIMBHID59E7bwzKuxKUCsKX1vBz/tfRLEQ5IK?=
 =?us-ascii?Q?1ljlryv6/zQrsXumWrf/B6wNdqj4fBHWjBgOYf9O6KgFdBShQEWmAge+8gA7?=
 =?us-ascii?Q?eOwprnBA68MN5RuDvv00s3clIRu9sQi+cZcyyG5dfX7anMuJkqEnVIlg3F/b?=
 =?us-ascii?Q?2Vw0QQEbpbGXWWR5J9wOeUMMJD/Kun9M12VbHLP/duntX5yUSAB3PXDIw3eq?=
 =?us-ascii?Q?IRBppWdvvqllItTMXa2qpyPCyPHbN2qEXQZg+P5xlIoMLe1UX92nP3U9quT7?=
 =?us-ascii?Q?aPTJPDsXeMpN0ckPCkFsHp33mojsC8P9b6cg1KYfyMr8pCP43nT0detFOxgK?=
 =?us-ascii?Q?1guelOvJMNzuoVSevPWJb7ytzJhmXw84L8Sh2nCxDw6hXb4GkbuQCQVpJMSh?=
 =?us-ascii?Q?ARwQfFwNcVOYSq+xAKgzksknlzz63AK49Vn00XsHrVOJmYVLfUBCeOodiCxe?=
 =?us-ascii?Q?7hi17dsi/hFDvbsisc5bOWrs6S1SnaHKtLx0uN6O2ong9DBPL5Ink7J1Ji6t?=
 =?us-ascii?Q?9iYqnoXMZGc73lp81OhnLqILhvFhFvQC7bu3bi6ubamFeGqxxHEUh5enjHDF?=
 =?us-ascii?Q?TrakO3l7usPm3SJutUFztc7zSybhyc3Wc4LYkP76IL0/Zsibq5qXvqxM4Lav?=
 =?us-ascii?Q?yBwGiDMcqiVHx49roBZRGefI4l8x/f70CyzKfVFQJQd2F6Prtxp1Z7rxsotk?=
 =?us-ascii?Q?zICXsS/+Ic8gWYeEneQKYMkkLfyXu+MYQ/ybfItsjLbofxHDecyrJkQvH6aE?=
 =?us-ascii?Q?QuvucIPmKhTqsqw9tJjLjbEcXbH0V/pKmaiDfrzup3NYT8hGjTc3Gi2tHkhO?=
 =?us-ascii?Q?xQEWVpURbzLEkivrIr44fxdsqJzbwbJEGyMlJoBdNRFkmExVH6zhqm/cAiCn?=
 =?us-ascii?Q?dbk94zm1jC78QK5AMfsTV2jt5/99zk8QOb/1h8sDuwBgsm8gMijmd730OJEf?=
 =?us-ascii?Q?wdKclqhMVro1nwMkLl9Y3glO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66d43f-e924-40c0-caa8-08d91643871c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:15:53.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W4Q8BCSpfa/DKnhZNfpVmjFWE6xhpDZ/j3L1ktRkJGS/B/kC+/6NW+nuYi+VnRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 13, 2021 at 03:03:43PM -0400, Dennis Dalessandro wrote:
> On 5/12/21 8:50 AM, Leon Romanovsky wrote:
> > On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
> > > > > Thanks Leon, we'll get this put through our testing.
> > > > 
> > > > Thanks a lot.
> > > > 
> > > > > 
> > > 
> > > The patch as is passed all our functional testing.
> > 
> > Thanks Mike,
> > 
> > Can I ask you to perform a performance comparison between this patch and
> > the following?
> 
> We have years of performance data with the code the way it is. Please
> maintain the original functionality of the code when moving things into the
> core unless there is a compelling reason to change. That is not the case
> here.

Well, making the core do node allocations for metadata on every driver
is a pretty big thing to ask for with no data.

Jason

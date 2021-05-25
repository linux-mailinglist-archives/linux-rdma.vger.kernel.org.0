Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A173901F0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhEYNPc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 09:15:32 -0400
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:3329
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233039AbhEYNPb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 09:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3/iirh6s3MeOVChN/bu3RUdZiX97j7OU7D0oVuo7wMnVu+9S7QrLSw9s2w1g9+SvGBGlgM8HGBjRUqKPy5z5hY+WGSxSyC8WDnFqP9phcBAEg4obGVzTLMDAXTW9XOPTieazO8Mx+FwDZJejuUljfxG95g+a0Mtu8pky7Du/40ToL76BUrPOJ5YPyqb927bGSZcQ/jg7HjRTw22wymsz96IOZFuqN0RpG0sJJ1vdLP5tnfqfA3naj26XCjmAzYce502402rik9JImrnn+5seBoRtgVqdrVVRUIPoXMR+mzJtbjEyW/uNREBISz4Jh+Elegh+pVrBcEH7XkuW39arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=065V6Fw/G0niUhR5tIzh0GbC1AuYD5Q9lEJWuSZpRw8=;
 b=PWwMCmX5D3mIc7spfm5G/5gTeE93DlFVs1uB2nSAL/2SxcUGtJ2ABEwfRW6s2Br038nbCJgB+bmihdEdzuiUWUgNRsyXqbMPF7VJI1Le5vGoADTUN9ml1z3JEKAUG/3L0Uudg+sJkM1/m4rTB0hGHFamMfghESMhWZXjPYv2kMNEuF84pqEF9bDD0nwPZIJkojpiOxAxiva33o9PgKs1bdRxt/LFc354qhcin7NtfOamBrmJQAzMm4/p9X4jjkxGZsmhVZLF1xBaeSKtSQXMHpepNmPKeh0hljDi85q8QDERd1zieMTxytoOR0n9NtvZo1UrYws1ILNg/8/4YCP+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=065V6Fw/G0niUhR5tIzh0GbC1AuYD5Q9lEJWuSZpRw8=;
 b=MLJip/1DoXSoftpPMV9R4414ybY0lCC27oyTpDIBPSy2b8biv57KvVJVtm+SXE0TgoM8x8gBAP0Hy6xxWwQHlfnXWmxNqwiRu8834NZ1QnmyBxr41LwGlJRN4KunFUy4mPDpGlgM49bxRlkMQoSNUdRLV5IaIvjxWPULagun4SEzw/4ug969EXZRjDlJg3KIDoyDBc39DtFlATeS855W8SDD8oSWDanzEo3Uw8GXn+JCNlcvJutOCk6lU3XsYvKChe+fbeG4cuFm67I9y4Tvlhkbt24uKSudbnd7YveTPjDjHzD4LU+2LSAOcuQzaBlPORzdP71QSpVlOmuyTNaLmg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 13:14:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 13:14:00 +0000
Date:   Tue, 25 May 2021 10:13:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210525131358.GU1002214@nvidia.com>
References: <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 13:14:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llWsg-00ECph-Q6; Tue, 25 May 2021 10:13:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69cfefc8-1ec7-4f72-992c-08d91f7ef5d7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364BEECAFC084150F460FF2C2259@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YyBeni8qXZ4ZS64WUl8yhahWfUIx3GfnhB+VECq3LxG6yJYHQckEsAzXwQjvwyp0Qel+Wy5JbhQOejRfdL/mq+V4VPSyX7PWQPEKL3kvfIr5te9XRQBvtk7cAwjgmaG+7FeVkovD2YVWK7bA+9zzQvgp/jB8kQ7g64jH+LFn2oQtV2RncomAHHiscMUPXBF7AYi/Simbjr2WWmcdI9CDTDsA8IbS44GOSECJ0RFeEmrOraj2ZCSXcHCgxsJvib9xfF7PlKrc5MeP0yfOQF8WUi1O8uARCRMuDiMTXm/CIqLZd1G7fdNJJ7v3Sg1ThP7h78HMr78+A/2FGdP/0HBoPMD3jfGJWaB9emVUkMdSXhmoj0Fu53tMIv8leaTnHpITHhSR8KlwwahSYOUNIdSKCLXrId79faTy/MdYaMB4YQZMt0aeUd1cuORhEcyfnT6pSin9f3unIIxvrtx58Wy8M1E7iZSP1vm/epikyHBULtTmOlSM6/S9tA6TYPTa1KUSb7CADzOnV5mYafl+6b9Z3cIBNTj5D1FouzFuJjGObySUQiTmYatqXGSxVo7u7lRs3C2t9rpbqZwq9+hffVktrseruo2w5tgoWgVjjmBLcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(36756003)(54906003)(9786002)(5660300002)(83380400001)(9746002)(86362001)(38100700002)(8676002)(8936002)(1076003)(316002)(66556008)(6916009)(33656002)(66476007)(2906002)(186003)(426003)(4326008)(478600001)(66946007)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dvzvu58N7ec8JNSRFGP37GCGzSXldir9De2pZKmEHXdKtQj9pHzt+uEiCxYP?=
 =?us-ascii?Q?rADK6lC9cpI2pOji5Yr+46DHle6KSt9uVaUwsYxsaXbt6K+BJQwtiZ2CuwhY?=
 =?us-ascii?Q?aUJs40S7kNnGfA6PPjnLkA7gxiKxAM+quD9f3U/r0YfPVAItGVeNBRG2nIO+?=
 =?us-ascii?Q?+UloGMvNb111UERx8f6DCxWAw/C/xQ3x0cf2cwATFHgEEEGULKWDRMQ2Z+7h?=
 =?us-ascii?Q?NJFhVMDe4jfD7yPQNt6FfTdID/j7ki8AE6SCKIfDiWc4Ks+53jvb+9kHFt4C?=
 =?us-ascii?Q?VtZIWzgrMAg3bEuFMNQErVLcHjux1qX8hYJU2osxbMLeeS0XfwkLBtfo/uLH?=
 =?us-ascii?Q?YlFZ1/odL4IHcRooimz6G12qh+Wbjfep6xTJhy6HV2X/UUsWYkibQTNjFxHq?=
 =?us-ascii?Q?A5Ku7GasKWAPGmD+gPNKK6AJI+Uqxtd4fRkla/2yS7dchI58A3HFhyVVJGA8?=
 =?us-ascii?Q?ggO2yUF4SoBptqLiTGb+lY+4sTrfQpxSIfopC8Xguncz1YDiI5rmkR7fdfIt?=
 =?us-ascii?Q?ARnjHfyyJ3/8iWA++pTDaRhPjNCK5odtaQ3bX5bYO0fCsobefMg8EDiFjJPf?=
 =?us-ascii?Q?Qz8+w+VmBsxdkji2niYGCJE9on34KF4J6KC54Ypr4YaFFNRno9wBv8KYWEau?=
 =?us-ascii?Q?nD+xElKkrijfxJM5vThNEIhd0GNKJf8BJw0fGotylZdruayeMXns6ocQRL0R?=
 =?us-ascii?Q?os4NS7Rjlm3Wh8LqIeMpgc+LERw9PEAR+viiZsQCbFPOCJPqOqIXp9ULbhUL?=
 =?us-ascii?Q?t0ZfZKrm5pXXdAxGn8uem88t7iQQVOoAuP7NJvi69aOdBZ30R6cOZ1wW6Ee8?=
 =?us-ascii?Q?iXiICO52EUJEcIpBilHb6pVkd5ooPTM0QeTQ6qjCNO0B+Tf1wnD5APGxOJ7L?=
 =?us-ascii?Q?j14lhKaKozBlC/U7CmtPEzHPGO7Yr/CkgoU/ibpvhBC5+mgT+b45lrpZtAjC?=
 =?us-ascii?Q?7Yuljcmndkmx+jx/30UvRjUymAky6TFokftqG9j2lHZcsopfJDj+RNCh3Dv4?=
 =?us-ascii?Q?ui+ekowedaSZFwVBQ9JjX50n62WpX9+CHgjnXws3SEbtzlduoyHW9npJiOHw?=
 =?us-ascii?Q?Pj5sNYEiOPkqkVjd+OKwc+OwW529AfXyuNgIstUISSVGoxHcAWxeHgSd4jd6?=
 =?us-ascii?Q?B0+ssqShJpnZyYIke9+FezHWi0DrERCZh4y28AYuuU8LKF4PzqRRCFCA7+hu?=
 =?us-ascii?Q?S4Dz5Dc0uzQlZqxq2OAN96nYGqy+/h/L5UAd4bMVtIy6E0fH7hMeBngG4njC?=
 =?us-ascii?Q?sZLSIBX3zKL0ZPjDgereXXftaCI8512GbUQmz0W/w6atxBSjdP9H99wgypV6?=
 =?us-ascii?Q?6SamzgsU9fY9nDZZqogJZpC3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cfefc8-1ec7-4f72-992c-08d91f7ef5d7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 13:14:00.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ2P/cMISs4CH0NeSXdqsCQgRmS8qztKvL6N/Q/7CGZ9TRRz5veyJ6cq2h7gUMcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 06:02:09PM -0400, Dennis Dalessandro wrote:

> > I don't want to encourage other drivers to do the same thing.
> 
> I would imagine they would get the same push back we are getting here. I
> don't think this would encourage anyone honestly.

Then we are back to making infrastructure that is only useful for one,
arguably wrong, driver.
 
> > The correct thing to do today in 2021 is to use the standard NUMA
> > memory policy on already node-affine threads. The memory policy goes
> > into the kernel and normal non-_node allocations will obey it. When
> > combined with an appropriate node-affine HCA this will work as you are
> > expecting right now.
> 
> So we shouldn't see any issue in the normal case is what you are
> saying. I'd like to believe that, proving it is not easy though.

Well, I said you have to setup the userspace properly, I'm not sure it
just works out of the box.

> > However you can't do anything like that while the kernel has the _node
> > annotations, that overrides the NUMA memory policy and breaks the
> > policy system!
> 
> Does our driver doing this break the entire system? I'm not sure how that's
> possible. 

It breaks your driver part of it, and if we lift it to the core code
then it breaks all drivers, so it is a hard no-go.

> Is there an effort to get rid of these per node allocations so
> ultimately we won't have a choice at some point?

Unlikely, subtle stuff like this will just be left broken in drivers
nobody cares about..

Jason

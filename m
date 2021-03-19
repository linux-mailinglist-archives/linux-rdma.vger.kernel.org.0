Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0753428BC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 23:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSWfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 18:35:18 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:6560
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230461AbhCSWfG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 18:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kie0hTr8+AsBNgNBXiTZiSY/TkznBgX2vAUuSegj8LnmB96LdKyqa2ld9nXY9Jv9TDkwR3ukwaDuLjnK550I9K5+GMKC4AHj5q0NLbkpScDpzzosoXJ/ObLoOlFtfV9919fK5Te+1Nd2zzTD62TEs2584NlvAIXwqxKLMf14eLla7Kd6yMZI0hJaVyeDelNyqgyCj2qGKdNKLYRj37dEJ4RAh59cGy6Li9wEv88oEVvKY/rWKUudzKhaOf14kcmAGoldM/DeS2OjaVHsNWn5URjoU/JDvEduegXheL7khVdfMFQYXMncjD3AYhrrwJ5Fm+fyzXWpXAlKMnK8y5h6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2t+n2DNPLQuRXkcay9cbA86oewCkcLBX0DWITUFALM=;
 b=Gm0Of7h2YaFeOIUnx4Hhx9hrhW7YxDNvZZjB6OpEH297RfmJqymgqbxLFsPftbLTqOnBq9CY+QijuKV9vjTDRay0GsoLoNuO3mDxhZiWHnBpR1lXjbYqizqk/3s3WwsTrQxv65pMr+8dZZr0nRPfk3MjJW8QsOjvwdOHvgYgPFlzYL74kKY+xmmF6MdJogg/fcs+qbPnCo/Qn1G8w+9v8WkktK34b/McuNFaDuLA7bym2HLTfLTu36rqkPisdTV0/+roVZ2K1UQYr/fjtvyBfGSaapoEmTr4AAUW+huSDoufTfbN6jHEf2EMkctsRrb6xt6T0n++HyNJprZlaYXaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2t+n2DNPLQuRXkcay9cbA86oewCkcLBX0DWITUFALM=;
 b=sQwqdTyr0EsJSqSOcELX3RCTflKunjHcbN6NFSjFk/6yjigZLE8ELvd4XOp+TrZ0MLe42Sfajvu4QqdGekZBxr0jvfhUYBlLd48clgzsuf7DAuYdbHBR0JH49ZtG1GTWeIUrH6N9IRaAzbl9/IGigSu8JLMHj6XIYDWfg2oDgwai0sEMaN6xrhykLoSBbOOOQRF42L+mu6tYrgBTSVVuw0ucb5Tqabex37/lmmrjpZ+qnXYleicAOlW3nG8oy+65yqNevzIOdw+bb5DHOGZY1+3nc7z806rNLZEvcydAPV0tEFB+4EHAniOWb0B2WlxpvB5ENJ5St8u0Tn4W+jb0bA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 22:35:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 22:35:05 +0000
Date:   Fri, 19 Mar 2021 19:35:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319223504.GG2356281@nvidia.com>
References: <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <SN6PR11MB3311140D3CC934C5AF334E0CF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB3311140D3CC934C5AF334E0CF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 22:35:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNNhw-00HUDX-9y; Fri, 19 Mar 2021 19:35:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c6424b-9180-412b-81b4-08d8eb273e66
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42650442CF22C95CF513979EC2689@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uEl2Pb7w3g0Jfyn1VSsBeoV58XlurcPTEDuoQgLLU57E0x/ivhO727z4arRkcT0lhvaWTheitBXXGBVN8fYfk6Ptiisms5UhzJI7xWupcq/MYxv8rPzOjwcRMLwhNJxQ/pXrb1VZg6MzlZfjtOy7m1NDS1hpcEEmJsuWVo1FnIR+LPPG6rF8f40rxrpBPiL9I5BimFDAvEGPuhE0BLcTBLgiPtwt8hRo2GadgE/VU1v/ERo+Ca2h7Ey5vAXt1DEMxP5z0Hip9FtHhDqpt8JFQdDIiaAw33HsN2tEEuADLAxlnDOMfr5C/FjcAp/ndd7ADE0pO2r0laGnmv60J7Ppg0FljILvrwR0RS6WQEXV2r6HYIkfWsJ2mgmfOPAFKkSctthmhyKaUunHd3OaF1lXZlJsFmrI6mMR+iFDKjYmSHAdV3geaHKLLyEx/kludOaf/EPcF/66OX1Es558AZ8d75rqQOT7Jk1COFkG1GjCJVsjOZB8CR0q5f2TxAcFFrpaoeNA+wNaUb7bK5ah4bSlOH4M6RoveXYF0s5gd5tpYFrGPKPPLkix2uidvJD0/xl/L8KkNdMJJrFSGUoK336nzthgUFH4zlnAH5NBBNz2VzJ9gl5nVEYSCgjzd4IULsIdrH/Pyw+g7gQnsidYfFiansfvHTMpPklofgxz2Wka54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(38100700001)(4326008)(2906002)(86362001)(2616005)(478600001)(9746002)(9786002)(8936002)(66946007)(8676002)(83380400001)(186003)(1076003)(66556008)(33656002)(66476007)(316002)(53546011)(5660300002)(426003)(54906003)(26005)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ayiqBH4TSYkTOLFBGLR4i3kOqxkDKn39Uvfqgf5mq3YUK1Ky7xRujxR3iZiA?=
 =?us-ascii?Q?GxKryJgs4WtZX9YJAQDNSA+YQru2Jw2AXcZSNxmaYIX2BFoEt0RV+FDkoWDe?=
 =?us-ascii?Q?MPnUe4o9fT6YxPQhoAvjVLcrKBM6E31BP3dSO8+HSLvnajePT6GSfjasN5rP?=
 =?us-ascii?Q?fiTHbwmg7BxtkmbQhi8QJuoW9xbTmyoqOAvr0g/Tx4uwn1YXrP4f7krAmrvS?=
 =?us-ascii?Q?zF1RLEYVzzelFPSCYAWMvF6m56yjTqy4zq9ChGLYH8OKoeCEuvLycjCmJtw0?=
 =?us-ascii?Q?pd8QEUoCMRtFAa5xsizBJUcyZlEk+sQCqggI5O1avay8qsUAx+fqzSM4MOy2?=
 =?us-ascii?Q?H0suE+FZCdJ1/of//A9EOOco/SLxezq08mTZ4810Tjt83P6ywvJaBbTydrm2?=
 =?us-ascii?Q?hRvEAJhg+/YXqhA/CNaAmzzqCEe0G6gpMCrdi6ckr9Q438PFffIWmUnWP8P2?=
 =?us-ascii?Q?CN5YvAe5fMlsblhfFv/otGbEWvhpRb1TfPt7Ns4t2flF1HEjLgZn9xzj5nGA?=
 =?us-ascii?Q?kJoXfvhh9qL4XM4ACXS81ddAr08/qnuSQqBYwAfXcAOYlPE6hINwmdeTvoEn?=
 =?us-ascii?Q?NDwjY49CWg7fvOSS3K5VOTh1gxFA03e/RORsUN2aghZh0FsV5C6BTsKqqyXJ?=
 =?us-ascii?Q?pshsj4WmyMS1wEEgIT93JYyBDU+ubR8BYabiJX+ZBdJp/bm6dTWnjzSZZhq/?=
 =?us-ascii?Q?yY7uB04QBOeE9yGGkcgWdG9rui0jZRUvb87Cw576QcyDmK7e3pAjXI8VwGEH?=
 =?us-ascii?Q?6kVu8SM26g60/mTdy83gYhDHIP88ESAd8+RsqFhdtQUhh1R4dxv/oW35nBKp?=
 =?us-ascii?Q?wJ8Oqz6s7hDkPolePhKV+U/a3paWHLCO5cDt4X9stVo9GW0XpfGQyx1Fesjp?=
 =?us-ascii?Q?O2OivCc/jziGp36mc5cRbVISGBLq+qy8R5NObY+/+hkSj8C7fkgEZKFjxaub?=
 =?us-ascii?Q?Mz+KDhzR8aUDp8zRWkzMWGM9kk69omIssykR7SvLjHuLd/GleEg5izMD7WFx?=
 =?us-ascii?Q?YjgoXLw8HQDuahRq1p6aMQAMqH13vcg9Sc+FjJA9yficmv81QTdap44k8HH0?=
 =?us-ascii?Q?5/jJ8knUmlrsDTZWN4moI9zo3Dg2zh3JRgLqYQxbnEmwlrV0z3feY/sXCdJB?=
 =?us-ascii?Q?RT+ACzZqROhFdjGWQAj0H3cCM4slQBdJ0FrdzpPve5FiGepvmr+qXQh5TAyW?=
 =?us-ascii?Q?aclfzrHOyLJZggFqBOlo7riB/L+MgLZAT1GFgHPakFjuQrzV8NJTVOnFm4Ra?=
 =?us-ascii?Q?xFdUGp0B3wYsLaho4UVstZ9Oi4TwWdCQSAKmpjX4bbPr0imr6jfq9z8OvV4h?=
 =?us-ascii?Q?iJP7vF9psGIcQC3YxqfixTrF9KuYl7V/uZjykDO++jpYoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6424b-9180-412b-81b4-08d8eb273e66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 22:35:05.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GO5FVKrF3juVlfqWhvJxs/jz5UMDB2ltzkF9FWwhCcPz3zPi7uSfz7h1x4voyGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 09:58:21PM +0000, Wan, Kaike wrote:

> > On 3/19/2021 4:59 PM, Wan, Kaike wrote:
> > >> From: Jason Gunthorpe <jgg@nvidia.com>
> > >> Sent: Friday, March 19, 2021 4:55 PM
> > >> To: Rimmer, Todd <todd.rimmer@intel.com>
> > >> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>;
> > >> Wan, Oh, there is lots of stuff in UCX, I'm not surprised you
> > >> similarities to what PSM did since psm/libfabric/ucx are all solving the
> > same problems.
> > >>
> > >>>> rv seems to completely destroy alot of the HPC performance offloads
> > >>>> that vendors are layering on RC QPs
> > >>
> > >>> Different vendors have different approaches to performance and chose
> > >>> different design trade-offs.
> > >>
> > >> That isn't my point, by limiting the usability you also restrict the
> > >> drivers where this would meaningfully be useful.
> > >>
> > >> So far we now know that it is not useful for mlx5 or hfi1, that
> > >> leaves only hns unknown and still in the HPC arena.
> > > [Wan, Kaike] Incorrect. The rv module works with hfi1.
> > 
> > Interesting. I was thinking the opposite. So what's the benefit? When would
> > someone want to do that?

> [Wan, Kaike] This is only because rv works with the generic Verbs
> interface and hfi1 happens to be one of the devices that implements
> the Verbs interface.

Well, it works with everything (except EFA), but that is not my point.

I said it is not useful.

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC776A077
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGaScK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGaScJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:32:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0AE1735
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QueJf0NjrssywaMxFYIbCuRXiA8WzGwPfyD3pEueDHh2FgdacYyqBj6P/xN3wx1Qph7kamND+dCGrsYp/iYwnSkAkKYwwxzMWuCvM1jSja3xoBPtKgKUjqJ3qAoX/plO+LRfbvvg2WRimV/gqoZOsvN2ugXVbbkkAGomZdRsVY96bsr9ZK5ggxMSuYwsJZ22zLi8QwckPHivDpMw6I5dzWaqSSsJBiTNHkqSSMC1TUEMNWukE3hV28tO4I06Yand820OtPjpboc/MAGS39DcoZC8M78mLulNHnt96OMsEajfOUPfTMtCMmojsuwtDNwUkNozlH8fTqR2Bp2qTQRO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBHf4vA5xAkV7XpTGSJiMgij+aJj4KJn20D6Ik01e+w=;
 b=SkVmoA7tmXWURHkR3hKiCHYtbFgSmcAWcjD5qVqIbvPnZSnwU32VBc18HZ/aERwWCbZo9VRwPEWWXOAM2YdjfP55nKOuTZnJGzp6n5XP2PFVBlUFmwKC6jak8HD36pTxjD3T30RCWq8HxrPcstK8AuqZ9ihhTbcBJc+xKPfNnFv3sEOsqM5RJJbwB9hURG1C4GC6Qndvi9zpVghzzyicGbf/EoTafrKVNRPqH6xiPC7h8rPQidPJlt31OkdNOllgERAlqrLA6u0lwNrDQpfYUZ6HY+B1tpeGlZziT5a9a9BxJhDDetKZ0JSKZ/K8IxAT3EHDHZxY644ECHOgwO3DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBHf4vA5xAkV7XpTGSJiMgij+aJj4KJn20D6Ik01e+w=;
 b=U4LJ3SwvQa2xipasElCoh5LPsQ75AcxE3V4C4QW/EpvbFvnbHHAMFcyw9uRjLJhrj7YEvSkqxxaBoH3WZrLJc8r5YLD2RXmg1qHrcxO4hTJCCHzTmmExn8HdM3KCJV8C4/bsuaiJkoGWReoB2K8kbniShnZsta8ovbHCLS3hLZoe9p7T3tkSl3LntoUgsblneC78JsoOOF4Co1AV4eHzm4rEWOKJCtOH4Ct4q3eSND3lKjDw2nfYP92VBImikf2fJt1qnxX81dQA5wd5et+ZO7vGXL+xVeLfCXQVDx+4GbwIMpKCUYjnOGyeugBEOw+PYi9UcMvsw/R9W5gNDObYcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:32:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:32:03 +0000
Date:   Mon, 31 Jul 2023 15:32:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Message-ID: <ZMf+ILKLjW+09Hhm@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com>
 <ZMf6xkpicBpXr/B9@nvidia.com>
 <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 84918ae1-88d8-4f22-8b7c-08db91f46fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOm4A3ZSAlCqG+/66PJpzKSPbx+h8/FjkUq1nQ85ihi7ybyDyaAdlq7kUO3kC7brFxscg8a26VKuSQsWOiA1gIWAHUzCnpewvv0JWqbIpt7iOBztWofXwDAN09KmEf1EosfGkxPE6z4cwNhP+EVkUhMPiurr0veVCCn0Sg4SqYQf3qpu/gryL7Xqk141r69e6z9j5pt0RIzWNzlHMHhqmyHxS+/0ldxlxt1N36v9fB/aLWiXGD/0AheOjq1XtBu0YjFT6VVEuizKg7TMWbm+f9qjH7+3ZUjEA3V6Ta8cEGVvjb0ApD89JUjPiC1kfrg7epYnThdphBRPo78eQ9lsUlsw4O/XMj81nn+LJThSPUdaJGzaBmIcb9uZprlvYTd5xQDrln78Ol6206OcuLkVs+U4nh6ND+RVM4C52HokiyeckAAxblFnJGgwU9j5CX7MPJo79LSoazwmD7fcReSgzRscuWmfnyGNEIpoX6KAdJE3joH7kA8Rwf72CParKOStyaBLN67jxYtrAsjHX6uOcB8SyH5/jWmOaF80vocFZgLqnY3N6zlXfw7Ff3BQ0epm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(186003)(66946007)(66556008)(41300700001)(38100700002)(66476007)(86362001)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(2906002)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skhGqnWzlZVVg5OcfQrJtujZnhDApJNzQ6DAB/VW1FdbAAk3E1Cugp1mA9+J?=
 =?us-ascii?Q?BlUJXNcO2RYdUzG80G0vRf2EoOaPlmXx14ICuYlqI1dcAkV3kAg1maVU8HcD?=
 =?us-ascii?Q?IAOelsZWJbfpfBbRBPWP3P8UO/LgyjvYJIXaTu2EU38DYJ+B2R2N2X2HFRSN?=
 =?us-ascii?Q?fx/p8mJUvlFT27dzbmaf45V/J+pWWz6MZrchAPL08mj8hF8KtPquwwRl+Luo?=
 =?us-ascii?Q?FQAyLHJIJ5WjvsPchRtRrzY5FaA43mUtYrIBk3h24hxa6HNuUYSzHtY/djg5?=
 =?us-ascii?Q?G3xaKizZ6h1cNeI3mEs2+Z3+vXGU98YtfIdgO9y86cBI9oUJOlKd9Je1qu6Z?=
 =?us-ascii?Q?E8O95yXy2pV84bAo4xLspKrQS4PzlCgSQM3tL/bx9KIuDDP9QOlIkCD498qF?=
 =?us-ascii?Q?aMcSqXIgufEZWwj86x26oHJgOShnZbeZ6VeFqgoysI5sEklRvROfu+9iqiY7?=
 =?us-ascii?Q?vUxzKNyfuAtE7A8E1ipFQmm7/Ay6lpaxAoaTm17gA8pMN7hIO0W3URvUMqcv?=
 =?us-ascii?Q?w2az0ULdPD01XeAMabExtP87e+YEdQfoAiNODaWjmjpAWbxIxUMLSpoe3R/A?=
 =?us-ascii?Q?JjaeB9WQc8paxSYRwpvpTxJvBk4pC5KXLSMnyHIC6P8z+itRqqBr+KNnyy6n?=
 =?us-ascii?Q?omJTtznrYbBWselSfICa2JBz5hbEwv57DlGaCNwgRc6gD0igHgutmr+ed0ep?=
 =?us-ascii?Q?XJH3ImFCD633fVpxmTW39BkAe14DBOCJkv3DSuQ61QA5ta64kwsHKuRA3gfl?=
 =?us-ascii?Q?TtvZ7oIkuJdhmcsn+zQj6w5EteJ/IJjEqtqL9mT691uEukJLDMtupYvpyJbj?=
 =?us-ascii?Q?hj0QAuAdc4tSuMncytVFeTBpTA8yZeSLYLiWonLzNDL38hpMuKEaWzUI+2Or?=
 =?us-ascii?Q?VCjayjENSReDEMxH7u+nmCdZo5WeoXxZcGaJQ5gKrAgONZlhp8K7wN+uq7v1?=
 =?us-ascii?Q?w/mgFguSY3MZta3+90mtyj2azS89QcQCQsjSmVHfyTMEa2CTSNx39DTtfh1l?=
 =?us-ascii?Q?akTbC38UIzo68zviDbQ7mBURih89iXtSYLt+T9duCRVfdisdVM+uEGlElaTT?=
 =?us-ascii?Q?3gs15qWuceth6tkOjNS26R+/TVYhBIBLOsFXaJCK9LLUQUNnNo5XCOgQoUIo?=
 =?us-ascii?Q?V8anp4SQCs8GgN+wcciKKijhDPPHhOe0+4u0ch81GD1T6Cv6Q595BdtotDp+?=
 =?us-ascii?Q?pdt26ztxai5qccJH6pHeHNnt7Php45leApBoV/TmD8NVVuwbo9aJiYKOL1Wn?=
 =?us-ascii?Q?Xq1JnhRBEUN/pwDmn8SvVJ80IqWHtJKEJEmof+Vxw6D0UWTjtyaSOmx+wj5t?=
 =?us-ascii?Q?WMP/K7XMyemxRjlbCFtPLlgMUDS/svsvulrXYS6+aoglv3sKXC1L/foebnPE?=
 =?us-ascii?Q?RtE7ywegzVnXMmBNPIhKkL+quZp4BQBjYUvio7ddp1Mzzh1TjtoOFYqFj4fC?=
 =?us-ascii?Q?/mtTBWDwoiN7lLLlsMgOaoeiqIsxBJYFXOhd0dG2wYczaHqpbq7Wd4iof4cN?=
 =?us-ascii?Q?I66QPMeuhmLgOjxhSorIMmkjmRDTMY0Jtl7h8CXcr5etKuuKnoEnRviFTpH8?=
 =?us-ascii?Q?sXeBvkWtpJm9DWfXL+/JYilAh+1naoH/my/oEV0h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84918ae1-88d8-4f22-8b7c-08db91f46fc6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:32:03.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDQqJ5on47EtZLOYdDmRbno9VqeLGAzJHujgX1EI8enTL3KkO7wN8JuEamPNnnfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:26:23PM -0500, Bob Pearson wrote:
> On 7/31/23 13:17, Jason Gunthorpe wrote:
> > On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
> >> Network interruptions may cause long delays in the processing of
> >> send packets during which time the rxe driver may be unloaded.
> >> This will cause seg faults when the packet is ultimately freed as
> >> it calls the destructor function in the rxe driver. This has been
> >> observed in cable pull fail over fail back testing.
> > 
> > No, module reference counts are only for code that is touching
> > function pointers.
> 
> this is exactly the case here. it is the skb destructor function that
> is carried by the skb.

It can't possibly call it correctly without also having the rxe
ib_device reference too though??

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECB4B7673
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiBORB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:01:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiBORB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:01:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099FF115952
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 09:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fozFh9U8nCM46tXfPp6dZPIXUqH/5G1/CV1DvXG7xMMUeAvmS6H3ZyzPHrat7hhppH+n4G1FfAAL7bBARFmUKmXep9sjLxvfghjrM3hZCF2URlM3gKCYP5ixtdmo7PWLGv+O00mB5o1ne+bHJBqbILlTy+vm+AvQzoIusA2H9R7rLGqNBD8EK4vKKcEEqkKHYmUhSsMBtbrSvR2vfSlRleF/RnJL+iulArV2JrJVM3jzPNQNoIUS46i49Vw8YP3RLDBdCUcecPhVdNGq3ps83eJyj1rAuxCgvE13dKvXRE314NIYjp/bibea9elTvjZI8AboTWQ4Pko6pBJCeDhMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6co3v6cBHsU1ZNQdpWlKBAlva/Gc266LGFNAiV7P7Sw=;
 b=ehUk4oIBTmYOWUZRyQkj6vO2j3h5omu8Ym06P8M8O4vgEtmTK+wcxoJT6MN8KSPYRgALIiORHOnjF6JwZWxKeOKGh051P8CZLxPUQc2Ypn0k9SqFaQ820DkP/r5ch07FOsZVShnHMhIEXFULgvccLMEXTRM9MNWiu4ADwg1Kqhot3R7/BNoZNmO3PTWLCfJCEwQC63j8of2Qf88NC1Q/28rHzMdv2veLA9bVJLvSpDmkrwumiIXjQRu8udsNul414DDmIWH7i+vZ+qeCuKXvzZjL6CFbqH8IE92lObuH1Z+DZkMwpQp3UpGEwnqsTuglByAcLyCQxU5kqwkenYaBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6co3v6cBHsU1ZNQdpWlKBAlva/Gc266LGFNAiV7P7Sw=;
 b=DQ0rNYrYXB1QRNCSrpoHIchOwNTTQ3TY6ppCJOix1q+PA3Uc3Evq9WvEOMx/inUwSjWvuFs5qqSXDOO9Qdkcgo0VQUj5WR7k5wWdArt7mFWzQT4WnQJ8I4H2JgT3SEEAzHlPoaER2IEqKPt3hPkgNtphxNrHDGa2ATOTdqANWhR2wU4Y0b6qxFD9vEhgSjQUZQk8x/Yi0Z2OT9nDGFOctVWCcyYDqS/mxJXv6Q0uHsfHPpXYXom7FlOee7WMhFVHW3tA9iDYW/2FFbgmxIyKQMuabKsPO26EiC/GullPB1vdBh8BFFDHLExpjOJCGQoiUrtg6Eubf+ia3DVv3ZzjdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 17:01:40 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 17:01:40 +0000
Date:   Tue, 15 Feb 2022 13:01:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Message-ID: <20220215170138.GX4160@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
 <20220215144159.GQ4160@nvidia.com>
 <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220215164810.GW4160@nvidia.com>
 <PH7PR84MB14882185ED3BA2DEC460D894BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR84MB14882185ED3BA2DEC460D894BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:160::39) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0983acf5-d325-4bc2-c264-08d9f0a4d592
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199CEA84B009C1113FE6193C2349@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HS2dp6idi2mQsQfjheE8YVKaZtOYaDpMeUGZ+vGaSnNUjm3f23WCPG3jObWmLcTCSmYnim0QKb28NJYcAmHQPIue+N0ewz1TyT3E0rRdrUyLrgXSWw1K6rQObfC4nJzRKyUPJPhpsLWSPPGhLhwEUsRR5phITvNAOS0QvoJa41i0GLmHwmcNEnZxCByGkpailfF+bvgo1BG4F1cPjyQBVyVewvDAyxRKF0kdTWfQH247mgr0JhpdYp9dTIO4oMrp+bDzpe/AMdzkj344AOAuOpHmQgTQrqxeGsPgxHKbMbnGcyUSrGmGZdAtSFFK2LLUPVDum0f9ZgcnBaf5D1OwsWC7WXQuvsXQv3Yb6K8lDOLMpXXbB+8xnrCw6rlIL9i9hORABaDRT1jC2WVJYFGFRzaDAr4dDiBEOQ5UZVoTL5W+ZtwLq2/A8T30/Rh0zCvy/AI471bXV5Z0h/S2YlRkCsI70dufJuVpElrkxyntf9wyjDRLnFVS8M6ovhHefXD83EMYah4+yQ4Qy7IO/r3/7phbxMKin7Jc0rS6IKJQ3mORSHS07By2HtO/gOsrb+thEhmY+oqS+24EGWmKu9fm3ODLDuvdxlA/d9MFnEzyJE2AWwe7icUtlu03fWPVZsH1Ur461p3/fv1dgCfJ5BQZkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(8676002)(4744005)(66946007)(86362001)(38100700002)(8936002)(2906002)(66476007)(186003)(26005)(1076003)(4326008)(2616005)(6916009)(6506007)(6512007)(36756003)(508600001)(83380400001)(6486002)(296002)(316002)(54906003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FOtA303mSaln6/C+yFtjHW5k7eaocbfHwRHoJm7lmEM9yFB43z+4YlxxTJa?=
 =?us-ascii?Q?wiebhxKuo1ERS4GnoLogXTy9JTY829abIz+3lxKuwluXclNuZFOgJV/Ebjch?=
 =?us-ascii?Q?vXLoH7AXtrn6x9CJNWwX90u/mrQNuJLOzlSNc8NSTd+Dhcpc+Ieug8jD303b?=
 =?us-ascii?Q?RjUOqftVBs/20QMubwNCD7s0wElpdlyCJ0CDU/cwBZIgWdGHwptoWFPW8NYb?=
 =?us-ascii?Q?07MI6ClRAO9DGBb8iSYFSupJf7wU4ddkXOMLjwQTEm3GIKESIWHaHutSk4P9?=
 =?us-ascii?Q?iCq/LmJUxacsQxm/jWNezGxHWcwyzviqKAcwNdWrM3gdtu0EnvQEB8g3g7GH?=
 =?us-ascii?Q?6VxklAUvGT3exonyILuspkretWEiSd7wJTf85OKr6VE715QTsLn40I57evwJ?=
 =?us-ascii?Q?F0ku24dbP+gJy56+Dg3Tjwsmb9kD3MjxOlc/cG/l8yYb4i0fHtD6DncqYQNO?=
 =?us-ascii?Q?0Iyt0G1748nxEbAzEB3JdNMCsj1kDih6Av0qK9pvkjL1M+7yUwqmvylNmFfe?=
 =?us-ascii?Q?e+RL4dUejeHN9xLOyGGpntivtLvbI6jVo7Apm32LDml8JeFBIYssoluAuvI8?=
 =?us-ascii?Q?c5kZqILf4eyATrPIPzPnn84NQaJSrbA0uRxcBSxrkmgNQqzMoxVxDXr/rZNe?=
 =?us-ascii?Q?3E93vnbYvBK9k85wKWAuYzWIsweVqz+eaos02Ek1TTIfVVO7RbDAVphvAh2I?=
 =?us-ascii?Q?Jr/935GPiAG3iNSAdWYPqgW4uPfF4ddhaFGzclpSn/AQme8WarlMRADpPhaF?=
 =?us-ascii?Q?qvDpaHJQERWiBzVmnwKI0u6iKlM0hFwKBLXV2w4Lk5AcbxWRo193E3vZiKMu?=
 =?us-ascii?Q?C2SiYIqzLvKY7VXdIzvrsEU0mOaAcUa9H7qR1WrAIupFmKEPxDqT9p8o5KVA?=
 =?us-ascii?Q?lzAbxK0Q2y1rF17qOWDIvCUe6GUiwkZgZ12MwpUJbxWdhpjaRabvWpmABzA5?=
 =?us-ascii?Q?an+iKDslmCdRjKsKKdb8NeQoig4f4NjcHaO/QfPyTWZnShcWHlOC6Uj8mCyU?=
 =?us-ascii?Q?62ZYYhgqWTA0n+AWtU1GCBmD+am4IcHH6Ckkt4NCMJ+mW5Dx28ygnPZuVfuv?=
 =?us-ascii?Q?Qzh1QCn2ChS1TgYMHBX4flkci29dva3P/LupzjqLgc6SK4FeRH5UHNimiNAv?=
 =?us-ascii?Q?LbbqirZ3yxoa54/82Rg2JjJoiiIlB59ARqVFL1OYdN+TzLYtoRW3N0yRaqDi?=
 =?us-ascii?Q?l3xP2HfyEyvOrWJcPvrka5pfP18QfUaMP62m1wKG9T+LRwy49fQJx0QMyVur?=
 =?us-ascii?Q?M09UFpvXjNYWkjzGK9tf9axvp/BBYVNaFZWh3mCxRGYVcoVoWrIiizEbTtX/?=
 =?us-ascii?Q?7C9oAIDnC/zyQFj6JAGDVk6wktTQBg7M9T7Fn1JODTOcjZckdqvy/H/flEUf?=
 =?us-ascii?Q?FX4dBLxvBwV2BThYvxK1Mp4qGdx2mdEfF43jjAi1MAebb3DMH+PQ4aqcLYb8?=
 =?us-ascii?Q?Ov/rZOkpjjMQTjh6H7IS0SoIf6EOWdo6a8L+iRiDp7HP4jWHO8h/9eUwcYeE?=
 =?us-ascii?Q?Ol9Z6MYRyhSkneeoWvthsW2q5D/pkFkIiH69/5vIfA4UNbvmRaX7MnIP+okB?=
 =?us-ascii?Q?wdOgMaxlcg+sqQB758k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0983acf5-d325-4bc2-c264-08d9f0a4d592
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 17:01:39.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/LfaJlwc6lBeW7oOvkHIlbz4ADBidRCIEMBMxmWs2ZPW/sowb+6FY8/nPDVUwvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 04:53:25PM +0000, Pearson, Robert B wrote:
> > >   spinlock_irqsave()
> > >   write_lock_bh()
> > >   write_unlock_bh()
> > >   spinunlock_irqrestore()
> > 
> > > Which is illegal locking.
> > 
> > > Jason
> > 
> Jason, can you tell me what the problem is with this. I'm not fighting it just want to know.

I don't know the exact reason, judging from the code it looks like the
implementation of unlock_bh is allowed to assume hard irqs were not
blocked and unblock them - probably some micro-optimization.

I don't think there is a deadlock issue with the above because irqsave
is a superset of the _bh varient.

Jason

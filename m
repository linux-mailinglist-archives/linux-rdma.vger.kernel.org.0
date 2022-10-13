Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279915FDA88
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJMNVQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJMNVM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 09:21:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27AE6F5D
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 06:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekKZGQNt6vNe9eFDg09MxiP9y6Gnc19gXdOVOxEfWIByi7R4dZRAs1NwCcPzt7ZG7yVxNLTe7MEJ6Dh/kQViTABHZlsbQ2qCpJPXhamtYk71fHUgUd6tnEljSBNSsmLq6EcRJnEsu+9kPcFNQH1WryecQ57nkIomxgZRcg/VAfKDtZP0Vask7gEBNoK6aLYcgjEOW26QCLmdTSgN4dytyL7sfGIBELQlDfuTvhHW+TX+2toGKj0DpXqLAJztopOMoDLTYjQ2ydaEQqUYRg+BDciGGDwHVSWAooMCxO5dBMkI5hwb63VlQ1K8L5cQldMBlRDnM8jbolL+pdLbditUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oSh2B9j14typ5ErJG/tJQEpWze8C9SFwW4J4m7Ls/g=;
 b=fFogFnBtKVfSqTNU8CsTTWOQ92gZ7HucJg1NmaDg9bAklux7FA9stdukhkbfOWX5y6QRQn8dxsWeNRm38Eu7TwdEQIpsuj2RF5EVI9XjxNcJm9idW7bAxlj4xJjGmN6xqqqp42+7tgn96skEVLy7ti2U9NLdkKqKXcs92d1QkAFcGDku9Jv0C1A5b2WnruIyoD0JhxrdOFD2ufZK8QMtZ6EEspw3iJRFRYdXj+CI4zcuAsSBZfDhGrObG4ww35ptcGrYcGXWWeA41cu7P0XBhyWki3vKKIYedGK+VjuXT4IN3JS9DbbzafWrYKkvHzF9oyuSY87iEy8iHucP4Dhcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oSh2B9j14typ5ErJG/tJQEpWze8C9SFwW4J4m7Ls/g=;
 b=Lp0yjxQGswyAh8kx3eq1IJ+1s00eEtUWhl2cG1aFSHigHK+VfT0GTrgUH/XvyZnKSjo65i/RcfbRsH4DBZX+nz2YLEMx3jre00meCMYbH6J5OmvN5k2poXDYgaVg8ZxRxCYrNpWbXKmJHVMwT7hjXFaES8WZwVXcas0fA5w/fDtUKpaGxxlsfF9dbRbb2E04fiVvsugTIrtRi4CRvzMspzJ9bILkhbKtSE+W4XYuN0v90mORlfMRrIgtb0Qxs/mBUe0YaSuq1RvbsVfIH1AF05ast3Z+adQZTX7UCm6MqNccmHNEQsfPvxFWIPMBdZbxo1sPcY4dH8SgbQSZ6q1X7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:21:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 13 Oct 2022
 13:21:08 +0000
Date:   Thu, 13 Oct 2022 10:21:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: FIXME in hfi1/user_exp_rcv.c
Message-ID: <Y0gQwwaHGq2Uj5f/@nvidia.com>
References: <c56dbce1-7d63-df20-fd2c-577ca103d8de@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56dbce1-7d63-df20-fd2c-577ca103d8de@cornelisnetworks.com>
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a8204d-796d-4bf1-6323-08daad1dca5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR6ChAlU4p+lIXh0fKSBt52YoqT2B0LzeowYAnYD+lCZwI5TlWpgdvyG2EK58DU+NQJBKEMRTnsMaOw/wmp5NIx7tpJNaQI2oW02zRs1yNcYcc/VbdWuSD1jQqwlwtJQg2XeuPFrbzLW7EtJ3jBkEnWggcVQXWtKtptAg94MEifxsYDlqoOdHWTk5Lr8eqUDY7CW2zQjVTOm2vbMuwrSGxmt1r4Ra0pQ/ByD34pPQCH5U86huhRHP8pKXJIIxKhlXPK6T2PHu6MMfD/NCIVeKbAoqDxoUMs4oZB5rltZysQNKqR6C4Ac2b9Bvu2J2AkfvAz3qm+MX8tf54sD+1YJp4Xo7Bmg0AD0SgD04I5M2disKTchy9ZoSBG5x2majod5b9Sdowd56C46h/RsLHJFKdjnVMiYL+9tNxlZBovLVip2aFTk36iIAdXm531ofIwZyqeW/G/AHS4UJ3EBavolbzQQxgUAKZVftEYO6WECN5GOaou3GB9nKXAKOanibuGcJiTramiLx4+TwQ4n8BK8dKbcmCILdDRITTkm6/tg1j5zt88NxhjZGKX69OgWmeM+4QaOkpW8p5j6DBk8bCekgoE79XcyZSTadWiou+MG/+Kx9FNs+ApbUlRtvOHhQdwk021NKhCQjxtJ7D4DPR/NwUCt9s6Iked/+BDttco8ZjCrKyWMrkhek9e5vIxYgzPxL08tPOgeYuhz4rE0TFpmo1b4MvKUxK02/r9Q9YUYumhkMgej0p/76vly1kD0UgBx8GS6xvHE4uQGwtYo9nMHTWO1jft7zmieGODxxTpo9b8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(478600001)(966005)(6486002)(86362001)(41300700001)(38100700002)(6916009)(83380400001)(36756003)(66476007)(66556008)(66946007)(8676002)(4744005)(4326008)(6506007)(26005)(316002)(186003)(2616005)(2906002)(8936002)(6512007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wAJfbyk4ASbGVGZUhaYvD9wo5ru0Qk9kZJql6UDV5BwkiOI1TCFG4wXbWD9?=
 =?us-ascii?Q?iFvkzgB8Te7vtIDvIkg60G0MFL5ipNSZqubjSJilGv6hFVE95pJzlEb327Qh?=
 =?us-ascii?Q?lJNpJ1SeluAE72CfHkW6KyumGTu480FA67xdiTZgpxo+ozUL88Fx1dTN+w57?=
 =?us-ascii?Q?S3d1zRGivVpMwtgK4ZPQ9jsV2oZ5pLC8mduZTOITWFIq6MChrT9e337kUjnO?=
 =?us-ascii?Q?omgzwE+Rq8oUqmYCSpZmI7P2CJMTpqF1SNmXC3r7s7v2WDmlGGRLq4WblM5/?=
 =?us-ascii?Q?Jr9ugsjxgm3sV0dKlG1OaP85KvAO/wWCD14C/difVlUj/41sjxEVx1ChNXd2?=
 =?us-ascii?Q?kxLoXQi21OZTxo2Lt8x8BxVWo7eMnOCxnqd+okvivzz6miFx8uwgXC/lRiL+?=
 =?us-ascii?Q?LN2tAokQe4m4wG/qBqzoyG9E5lehytrHRx/gKs5XetXs1iWFHnuzFma82IjM?=
 =?us-ascii?Q?TmjKmyXaKMCF6Zq3cIylR0bjBjNm4ii42Y6uQxi9xVTQ3g8j1PMomRYC8D5R?=
 =?us-ascii?Q?gho8gmWwFKCPelrixs7L9JshHVJEwNgOLO0GRvdLe+2TteLDccIr6UiEKbTi?=
 =?us-ascii?Q?OU0YGP+626kAW0mUj5wxBYZsgvic9QJ07IzUclwOdnC/txszPUg0czIN+UFw?=
 =?us-ascii?Q?kLqGF2fypNWrNvwbrsptp3bpM+0GkyDwNwzW/eHdg1ufafYzRYWBHzrG/v4T?=
 =?us-ascii?Q?cvIQ0JrEPwSRjw+R7IgiRnggNTUHUdkgbeq9mB9lQa0vXFhhhcBoJBwCmDYM?=
 =?us-ascii?Q?4zu57hZ5YUMHGqdnjXcxAjtCo151IdXWbvPjlnNIJTZf33z3djELbXSQJAAn?=
 =?us-ascii?Q?g1NWi24QFBtmhR2ZxO+CFMJwiIcm5yq2zfL4Si7ztG5L4e/MhHwrwD5rkACB?=
 =?us-ascii?Q?X+XAeFrMjqDSF6le+Rb7b3LWKrcZgSDUp2lU7CpaxZBKTtc1PcfsQ7t/DzIY?=
 =?us-ascii?Q?PB71NNq5XVjQ7QdyswmvcLhXIrkOcomkugseDxcxj15BIIWWr2E6cL2xjKmC?=
 =?us-ascii?Q?5dWdM2GVISgkpRC3dTI5sy9TcDaickD5v8RXciz82nY1IF0S3QkEjFUxESlJ?=
 =?us-ascii?Q?dKWIYLnsjlRijTjm2P/wa3Y3WP724qbHzd5vfJ5J7m+1mLCcwFbUCoPed+YC?=
 =?us-ascii?Q?4Xb8JdQrHBol73uaJGSddwGuBognxhTlj9rGksVkoPAHFx1lCZ3h7ouSDdDi?=
 =?us-ascii?Q?FhOK5nL/3oOn8yzu4lP/yeKx2SCBStd3eK1v2jAugRv37KYscqmLBvwxGgJV?=
 =?us-ascii?Q?2yCJFgv7u0pU59HM6lcqIfiAgar8L4gowU9dC4ure3+tR7mcMeobMJ1ZQG6E?=
 =?us-ascii?Q?1eVRKl7wH/vOKzYlUfWhJDyQGzqKg+857RCR4awA5dFw4JDiPulzO2UhYs7x?=
 =?us-ascii?Q?mS80iWGijMH/FMrjxxw3XOZekcMnO9OMAasnYTCjq0C8+3xFjtkMJUdP7asH?=
 =?us-ascii?Q?vv0LD+RYZjTyB04F7unROU28sqCZXe6958oWBARLLhE0wYCZWJFngNFB/Fxo?=
 =?us-ascii?Q?SOWMbde5xChPZ51r4Ijd9BUTCddBTs5R8a7U0mzFWJh7ZoxaXjpTUgu8KKzs?=
 =?us-ascii?Q?X6C/fW1mBn3c0MrndFk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8204d-796d-4bf1-6323-08daad1dca5d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:21:08.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOwk7Ypzc6uk9hU1LGOFnMtgEogxM83NFS6F/u0kdNbaq0w19O1aK/qsXW6YtI6T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 13, 2022 at 07:59:52AM -0500, Dean Luick wrote:
> Hi Jason,
> 
> I am looking at the FIXME you left in hfi1/user_exp_rcv.c with git commit 3889551db212
> 
> Link: https://lore.kernel.org/r/20191112202231.3856-7-jgg@ziepe.ca
> 
> Can you please explain in more detail what made you add the FIXME and what may be "racy"?

The comment seems self explanatory, the ordering is upposed to have
mmu_interval_read_begin() done before the page tables are read, not
after - since we already have a page list at this point it can't be
right.

Jason

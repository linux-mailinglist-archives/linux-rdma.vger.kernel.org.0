Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B471F636
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFAWqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 18:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFAWqH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 18:46:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17B136
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 15:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z77azc9ARTLDC5rUQP0GyHg2o6jcShDhwmflGSTD4MMG785TXkh6JfgmT0IRs3JJ2VHjZutzx8+wZJf6tQeeXdPEhCI72EZZxvwG1ghMxtu8IxQQrZMmC51Mdp3NRskKM40DtZOdUN63hKrFBX9smOvmFHY/yOWhAns5X1KrjyGkpIVAVvcZ3sTxFXiViuim5BMcr00QtL4A0U9BHXwVZuwCGZC+uc6mwdWbGFORBtHudf7COIE19tMKH3P8pxaUhB+Z8tDYYnthLbmSSmviVJpGVVw1KPGN9YzcH6mtxMCY3ImCTg8Vf746CqtCVS8NDZu7E6W5yHsZpakFLkU/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWdihLM1JsSS0LYjHXdCZTHb/J4IghBGgIRu1Zh6oJg=;
 b=jMhwoP3CJiw7Nc+/MMUfonVKFhtXwzABu9b31pP8I5Dt05WLIjpga1T2QRAYcBbMkCsGLKLXWQaTj4zSIvX/3Qk5okVp7xL4ni5oGqglZOpDoPpxXr7zEjcuUq3nYNuxTx1c21tBOlivAkqA4m8iUUl+oFwsOgHhvThJaMCpgDPy4eKwEv+bVpW04bNCgLA+Wm68mI5AI97AhLVJVqElM4qfkKCWc7yto4AzSLfYJcGvhtaWa7g+1uwoSzmn1+jWWQl3I+i6MnHBmCYmTfnNTWW38r9HIueWsTJM8dkLoGW/a57i6jP6o/BbeNi1wnd4wAQeAiwhJLqNoR8KbMyBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWdihLM1JsSS0LYjHXdCZTHb/J4IghBGgIRu1Zh6oJg=;
 b=mpJQIAClJIXCq993s0o7zLcIJiyo0jgmXpXL6+LhmGDElIeWy3+tNscFveLVTzfORDE2jP2KkX5gFxD5kQQ52hDliQz5Tbx+2ZdzhF919z8n/Sue3Lj+wjWRjP5Vu+/Spfds8hVoQzBUN6Njqd7O0j1J06DJssUdTYdHcP+/yZur6c0Homps8JlhBAAQPJ/tZRS6Y5/C0BvgklJzoqDw1iK/NKhvZLndrZdm3TctRZP3808RWheiz7usb3eUONrzTlIoH0+kM3PD6d4/OwRUKzVbDEtGx9wSNs/7sbJhXitpJEX0ioJRr8FcZg+bMXuueRn/dB9HaxBEAnoX4aCamA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 22:46:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 22:46:04 +0000
Date:   Thu, 1 Jun 2023 19:46:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Message-ID: <ZHkfqWWzaaUhMbZP@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
 <ZHjZQOYgNW9tllNx@nvidia.com>
 <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
 <ZHjqacc3eKiJ0Kt0@nvidia.com>
 <5f17fa1c-57ec-2d0a-a14f-507c656d5828@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f17fa1c-57ec-2d0a-a14f-507c656d5828@cornelisnetworks.com>
X-ClientProxiedBy: BY5PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: f8950c9b-4897-49a5-6375-08db62f1fb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARwUzf0SCurf5t0ErywwXS+RzL0YrcHDI79mrIn5SQP9YkqjCR3DTmU0ZoJtLXdSBkoTsJ61gMlzMGwr8MnV9scOY8NKEyS4ZlV3j3AsmD6bXKX8ArqaOTSDLXIok5TxwjFa4v+rvrpQS5DzMxS3Mb304NE7gAWxZzO40exsMtlyr9fNxyF/dnVxySiadurHDECHLCq2/XDcVgI0qqAf5+yj6+KlJn02FXdUb/id1DctD/89pA4YtIsFLNgyC1RafOnLY1nc+cHS6FzOzeildBBITL6eq1LhewzXhE5Cbf78AOKdfJmIEL72Uez2Hr5ybS68pp3tvXhJSyPjgtySNjcyRCHJKFwxGoUVv38N2ukSp5CEZOyy7BXuuU9mgR0ZysugvfbYPSs75vk80sYYR4uO6AYSyE1TchgZdcApN5sm6bsyfGOHbmmjcMVZ7uHO9VXIK4VzDoNvVtWVYjG6u1bPtcns7BMF7jsOzeKAWRBoGJOX0APCq5G+K9setF/NlHWauw65TbIMow16L1Cy11CJB9kStQSm4U/SLFHaAMrenTTBM/TbLkYboWgjFd1S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66556008)(6916009)(66476007)(26005)(6666004)(6506007)(6486002)(53546011)(6512007)(478600001)(2616005)(186003)(86362001)(66946007)(2906002)(5660300002)(8676002)(8936002)(36756003)(41300700001)(4326008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTGx0vtLJaROBC47zRJnw08it7zIIoQZ7G3IsOH5SfuACgCiPCcJWY+/haPg?=
 =?us-ascii?Q?jE3gN0AjAgNPZJOMZyjjYczibei6fjSRKuaTpvfpA0UIqOb15A7H/ICrG9Pf?=
 =?us-ascii?Q?PZM/nq7ALwUOPLmRwzy7ee/4ZbDVFKY6G3r5AvJ5tTfRMrhq/cDYP60lJprP?=
 =?us-ascii?Q?8fj7UpbpUdl1f3gr2OvZXiMj1Nn+/39IAkimwfQ7L/4Pj9bOv4wDkkFvoJwX?=
 =?us-ascii?Q?+Z38OComNwivF86UOeXc3ecejI+K1sh9r3azBcg6NUA8wpoY4/O7K7XlhoDK?=
 =?us-ascii?Q?e0Ue0TMvQ2gs8oF9KYWALcUVRn74CfxpgJX3z4luHaEnMLFzaWH57aZVx3V5?=
 =?us-ascii?Q?f2u3fuH6al0xL7hr22+NwW7CGNxbPH3EWaL09k630wSvBq6D0EKIHx11s54l?=
 =?us-ascii?Q?ZImaeDYyBdnm8kl6WfGs0l5mIudDrVYhXoGwNnK5bFZjzLoZ+KJ+tnzlbuFS?=
 =?us-ascii?Q?KTK69Gu+mBdGxexQfo1TrkP8cE8ttrWXBH4V4iTr5t1NJfB6r1HscTGF5hR2?=
 =?us-ascii?Q?X/ztA1eAobwJuSC+Azw/K5PMc5JQiJxPV4OTAtgHLNomO9vqvKqcnYSBbuBO?=
 =?us-ascii?Q?9NWUHdMuSR1CgUKbQRlOvjX3SjlAaqX6MvitS3sdOMoi6ma0me/naM/Ehul7?=
 =?us-ascii?Q?57Fi99FdvDD43Qb9zjw+etxOhyWLiER0ZWdap1wnA7BeUIFLlQNxp4C3CasE?=
 =?us-ascii?Q?/xUNVkZWEDSwl/kK0tjZvOrsX8Z2COPTjirvMzMrGE9hhMLE2jARs0OUOyky?=
 =?us-ascii?Q?HAajEPlj/Sjh/BohtpaYjIrfyEHEL4TyV4NI46DbeSKgX7ErzJ+kl1MGiyFi?=
 =?us-ascii?Q?tHznHQbjiYr4BL97wwWm6/jgWyTxSikRhvgjommt4xMqaB69fcn4iMXhN1dx?=
 =?us-ascii?Q?HRnwJB0ey0NVgVkrtw36RdgiSdc9LrQEMGsSgJLs87NE3vUjlA6bPvAjsBoT?=
 =?us-ascii?Q?QmkSVsMdOACB2HA8gP1Kkdgzy2I/eir/4OVSEIkkdQduFTBAfXOMq7BOiOx1?=
 =?us-ascii?Q?79i9z+pBKp6uQWfF8hbouBqzb7OHvGkSHbR3CyR3xFjShTLSdB+63FBRMOHi?=
 =?us-ascii?Q?hqp0RenokAbv28TKpNet1NRp0mNJz2PBww5sId4qUIbU5cvMEK8x/oQSG4+d?=
 =?us-ascii?Q?b2s8089L7+pRRBsUN69UURSIDqz3PRy8h9vnFYK9NY7cSXK+NV0G87QsSADI?=
 =?us-ascii?Q?T61CPNuC+tfI6v8W2dOF+0801qoZ+m48R2UlTDf9xPG0Vi//ILjWSkPhx4BZ?=
 =?us-ascii?Q?6RXc0p8eaSOKrVwNg4Q5XqzYNqn/4vY0UrD1Rro6wvbBGDTdqFYWzHqVYpM2?=
 =?us-ascii?Q?ggPukipfC/MPkZYrT8INRC4dOcD06iqABOO9AmhA0PlGSNbBF/mF0UeJRRrq?=
 =?us-ascii?Q?1/yWrY7USqsBwLBgF4t+uxVxpoVqfMTMETxSt9+cdJEeakjZmyUQRqlR0Dj/?=
 =?us-ascii?Q?syzUH0BgKAMMqggRLhc7RmyK7pgRBoWfVJHSeGb5sQmWiq+4ivTVTcHx0IEd?=
 =?us-ascii?Q?uNkJuItC1/jbsp6DAg+oK/Gv+Vr5M1NXDePHXKDX6VExIqPj1tUU54zrORyO?=
 =?us-ascii?Q?7G8BiBn1fUlJlpjB9IfkeltsHQvi7/6GYPd2iDaQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8950c9b-4897-49a5-6375-08db62f1fb2a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:46:04.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFw8wFPif+j2WxrghVkNphlePHXrCOkSVJkESSsdj2wmIp1JvwVsIThsjoz8MvKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 01, 2023 at 03:11:44PM -0400, Dennis Dalessandro wrote:
> On 6/1/23 2:58 PM, Jason Gunthorpe wrote:
> > On Thu, Jun 01, 2023 at 02:15:59PM -0400, Dennis Dalessandro wrote:
> >> On 6/1/23 1:45 PM, Jason Gunthorpe wrote:
> >>> On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
> >>>> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
> >>>>
> >>>> In order to handle user SDMA requests where the packet payload is to be
> >>>> constructed from memory other than system memory, do user SDMA
> >>>> page-pinning through the page-pinning interface. The page-pinning
> >>>> interface lets the user SDMA code operate on user_sdma_iovec objects
> >>>> without caring which type of memory that iovec's iov.iov_base points to.
> >>>
> >>> What is "other than system memory" memory??
> >>
> >> For instance dmabuff, or something new in the future. This is pre-req work to
> >> make it more abstract and general purpose and design it in a way it probably
> >> should have been in the first place.
> > 
> > But why is there uapi components to this?
> 
> We added a new sdma req opcode and associated meminfo structure for the sdma
> request.
> 
> > And HFI doesn't support DMABUF?
> 
> It will through the psm2/libfabric interface soon.

I don't want to add uapi stuff that has no use..

Jason

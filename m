Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034963F6F9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 19:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLASAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLASAk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 13:00:40 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1782B2769
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 10:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnIgWuui4dOSFU53Q3GoqNW/Ac6FJtq+rJBoeq8IpYz7gKZid4Ab+Z2dSib7RUT4tlIPIcb/djhqyYBpCgffr2gjSUOO3pF7AvsLHvY8oocP7+d+OqClBK93tGVL3acGZsiKb5ZY6RJai7/Z2FJVjkc3faz30mUNXio/RuGsTQH+BdWG4Wt0VsrmZP48PiRVkLfXSkPCHB1pshkuP5qpINkI//t+f3vVOHDQMh+MdHojBwbntZtDs1WS84P6Zv2nhWY+VdsUW2jO4HFnr7poR5MMyhVpqdGvukoKWihhrdzgCgNkHuMxbuKU3F6EKlvHL2khOL4PFhqF8ufg7d1Bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg0wPPW6UcvmG9FyPVt7caub+ETs/vUKcroQSwBQhlM=;
 b=Eu4Pczdmu0LFw3DshoN2WDAs2TFHCu/uKI7FObUf78AqgwIqSz1onii8kOpjSauAOcHhKRRU7owMKrxEQBxA6ppxQ1xmNEk7BdfSuD/4y49npIOuVIVptcn5vByYi+DM/Nu22Jn8rvO5i5gYFoIz1Mxsgqq3UfwWEgUrR+XBwpq7fJnJS9EPWrfU7vAQRug4soERLeii44MGVlwJ4lI3lnZuuUqu1OAosLJYU2Kr7bZBYcvgPtdPce513imkuOSm5dBN1dd0b89EXcU3NS5xgQ4y+9H0AHIjZwMdkVi43j88IOpM3ZfrcB4RtKUGb51mTqfBZki8TSgykM7I4VB0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg0wPPW6UcvmG9FyPVt7caub+ETs/vUKcroQSwBQhlM=;
 b=uahkc2MOO45AufFf5pyskpZq/n8eulqHV85pCZiNv1DdLR65ixIkmVwiyPmZTgf8JGXt/RD4yT0O3KdUZcHAvfwpUYr2IwawWNWR1gHNP8HRuy1LQJyW1f33P3bfjYirA59YeoRXDg7XYstdhgS+ti1IaeL7a9OtK8/HmUXHf3fszduLqI95s6veg45AK7v47u9u/aS0D/EGbt9GNrBzG3QZS3OO9zejC016joNN/8tvvCs2rK3etX8SJI7ID/sBM4UEiOEWZU/VGvjSOaaMB4WGRqlS2RImpxldBw9ZksOxMQ7B7mrufYNXUN7hkm+ND5Nc7YdSsY0vHLPmtmpD/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 18:00:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 18:00:37 +0000
Date:   Thu, 1 Dec 2022 14:00:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4jrwwjzgj/AUg9n@nvidia.com>
References: <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
 <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
 <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
 <443943ee-6f79-b6df-4533-723953173a5e@gmail.com>
 <Y4jKyHYosuveRQrj@nvidia.com>
 <24f77b1b-b2e0-17f7-06b3-7ac17a247efc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f77b1b-b2e0-17f7-06b3-7ac17a247efc@gmail.com>
X-ClientProxiedBy: BLAPR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:208:32a::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 662a849d-c35c-4646-9967-08dad3c5f37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SUfxFzMjJaj5stZUB1yMG1fFUM1DnxY0gYh89LuGSljMEoRKdMT7HcYuN+mXApWbo0a/9lZgHiCQ+F8UUXNsufdhMMVAWSyE5F8KlMY25yCdG4dmhJOxI/BZqIoemj/LQOCVFupvLi8UFZl3hdFKaRMxdrfMjW5m+eAKkooqDL9zgTOARlODuiDYFmL5B1VowaED4iPiHnO4pbWjDJj/uWKpFZShhlIJJnCilTWiVLbXZrXYvuTYLuRAtlNHPF0dQePllauGnuUVlIHK+uJYXc0LTtRsqVgo2/NUOe6HdBTMS//v9H4fCiMACXlaZ5805ZGEip32PLrlm2CdErije9DLEHQXEbFJNNisO6gJ9JNhyaFSxLonf39YX/pHtVCLONCNnbyFBOd0nzqmnsmCz1czhVYFUNQAXdQZ5h+/lgGlm/wvng9DCB8JTWt6vTXNDhFe6IFE/49NevMJ1ga3wNgm3N1JYL/Itw8MpFWhKC6rgLW62MKN9xeou4wRPXBJNSqBM3G8dQcimJkpCkOV7jwbKfCVK2sN+uoiANTBCfT6FB5fK4h2zXByAplr4+U1Xp6y6SaYV3Fsc0RSgKSx3Q62k5CzHDJJzZOuEwjmBuU3tSa8jBmQm5rw7SCf2NMzRTFMf1+jcQU+w8wahD1EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(66556008)(38100700002)(5660300002)(8936002)(316002)(86362001)(83380400001)(6916009)(8676002)(4326008)(36756003)(6506007)(6512007)(186003)(2616005)(66476007)(66946007)(53546011)(6486002)(478600001)(2906002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gstUdbISQFoClunJqDWeK8WAunfo13MgOW3FjTts1HqHrSnUysfr2gd4F1Y?=
 =?us-ascii?Q?Am3CwpzrnDotgS8hUqjZKHD4T8evnov3dCYOGojG3XpYzVlRCUny45M8Oe/o?=
 =?us-ascii?Q?R1ioNNjUFMs1u3J7MCWUUwn+MJDBH2Pp7qQ/ZNtZqzk/xmN013zj0DGe4M+T?=
 =?us-ascii?Q?YmBTiYhvXXawxEV9Xa3DBoGjZh2eza2jOf0WuIu8Qb2dzPXvGjb0/BGVDdsl?=
 =?us-ascii?Q?O695gZZY6bJUJxwkWceUtQyHU50fPd/zMX1qJQkitr9618IwAc5TtTpuPfXY?=
 =?us-ascii?Q?c6FCSDouA1fAoe+U13sjCJQ1kOxPTGINS0kNNVJu+kAzfHekmaK2mjqYDv8Y?=
 =?us-ascii?Q?/agYMbcOzrVvffADlMDhzZ31Ern/PRj3snACOROY/I8B40FENtv2wNcgFaQ+?=
 =?us-ascii?Q?Tnxd/itbZoJPS6aOnYE469I8xFHGMTTAFzmDRI/+7A9iH4ul/vSSUhFS3lWL?=
 =?us-ascii?Q?+cLJ9LX1aWRrvoeTdtBCzY4MFsg3iT0j17Uq9hbTqMRbZ6Xrq6eZs8nJgnm4?=
 =?us-ascii?Q?fOlrRW1DAqAOTRp8N57xN8hBwwXc1oc1eHKANDUi99bxfnIEg+AtD/a8ysj+?=
 =?us-ascii?Q?jSfx+ObtkXe2WmFRohTSgoAHiUGjFqhoLWemOib9i7hpv7Q4VqmpOokRM3Bn?=
 =?us-ascii?Q?/3xuMLMi1zBqCH9z2Hjtu+qpifGG7vQFEg94j3STmK8yhOflqujYXtN4idpL?=
 =?us-ascii?Q?RWbF7mFWG7BWtcrjkE7u+0c15LwxR0uk4Ml7aW7GIyFk4gPeLEYpznzB1wm4?=
 =?us-ascii?Q?AQLHTd8qVFvR6Nr0e9UDjSGrLrAPMCw9WVA1ozf6dutx/XvolAwuSofxEcgW?=
 =?us-ascii?Q?pJaW/P24AKAUCNG4hfzr2AiMi+3NBo1dh1W5hcot6vD8+jS1I+vlO2JHE0Dj?=
 =?us-ascii?Q?yIdAdzbrpIFhiRJ0FR4OikGHn5WlWUjYX+uFABrO1dJvXrAclhysNc9fD+jY?=
 =?us-ascii?Q?OXwrH7+e36Pp9XHAhyLtqQ/Sr7NMG4b30kIh8CR5I8sZYwHQH3wq9zhjFaaN?=
 =?us-ascii?Q?EATVjClYhVSjOWd++ncsaJ52/QjogfM3/kN7T+lXmvr/hHsMGgJ65LlHBtH2?=
 =?us-ascii?Q?DfZ2PHLnKvJ5R5EZ6sLP0NbrxTPgeic4FL036pcpI+1Ycc2zhwlckNVarkfh?=
 =?us-ascii?Q?6F4CEMG1hR4kl+yp1551J/0qmXxXAakMSGcfKtYR1xUSK/4CBm06xwy7E6fj?=
 =?us-ascii?Q?29eVX2hPuyPF8d3gpHQvMDmJkXexbCh9EDcOsGrp5oBIPihduMvroSiyQeGQ?=
 =?us-ascii?Q?STlSfikNh3NDUGB4ax31MkCiUrwTl2EBCOkJriY5qQs0jTdpugToaYF0Ez77?=
 =?us-ascii?Q?brS4zl8Lhtj9/IRQgAE856chZ7YQdp9zBSbeJhR51iANpBIcQI93C6Eq4Nhp?=
 =?us-ascii?Q?VVnKjhsiUruO+hmzbgfuPrFafVmgcX1VOIJEmNkyhGdDHSJTz1dyKCoOhnzY?=
 =?us-ascii?Q?hhN1wV7S2OK/Omi7DoZUQAsHsY4JneMxMFtsUQfmVBWBYJgyeZcn34iv94BR?=
 =?us-ascii?Q?bynhxKWdRTL0KiQoDl5etvu7BSlMTXou6yYTJkNmYjjV3oRtUrCGBPcDo9IO?=
 =?us-ascii?Q?ZSOQ6tQfoBWmVxcVeTE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662a849d-c35c-4646-9967-08dad3c5f37e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 18:00:37.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3acbe2NQKPSmx6an0osChVHNPYw7/GTwzC6JTl0j+a08YHORj65AbmLuMieVibyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 11:11:10AM -0600, Bob Pearson wrote:
> On 12/1/22 09:39, Jason Gunthorpe wrote:
> > On Thu, Dec 01, 2022 at 09:38:10AM -0600, Bob Pearson wrote:
> > 
> >> Further, looking at ipoib as an example, it builds sge lists using the lkey from get_dma_mr()
> >> and sets the sge->addr to a kernel virtual memory address after previously calling
> >> ib_dma_map_single() so the addresses are mapped for dma access and visible before use.
> >> They are unmapped after the read/write operation completes. What is the point of kmapping
> >> the address after dma mapping them?
> > 
> > Because not everything is ipoib, and things like block will map sgls
> > with struct pages, not kva.
> > 
> > Jason
> 
> OK it's working now but there is a bug in your rxe_mr_fill_pages_from_sgt() routine.
> You have a
> 
> 	if (xas_xa_index && WARN_ON(sg_iter.sg_pgoffset % PAGE_SIZE)) {...}
> 
> which seems to assume that sg_pgoffset contains the byte offset in the current page.
> But looking at __sg_page_iter_next() it appears that it is the number of pages offset
> in the current sg entry which results in a splat when I run
> ib_send_bw.

The pgoffset depends on the creator of the SGL, I guess something must
be pointing the SGL ad a folio and using the sg_pgoffset as a sub
folio index?

If so then the calculation of the kmap has to be adjusted to extract
the number of pages from the sg_pgoffset

Jason

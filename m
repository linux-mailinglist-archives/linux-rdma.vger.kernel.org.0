Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAE68C140
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBFPZg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBFPZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 10:25:34 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B32943A
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 07:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBP8Ki19iGllLMjEDRxtKA9UD8nr1ptjpQVkShjDjk6dJUqeEwiimuihpEP0wPuXlEC8H7t5WRPRi5fKKS9wqL3F8PM+th0C5y01nNp+GaFCRD7d4KMLh/0vlycs5DTPEkgHWxbZTrtLbbDbo1esJaM4VQUya3jxtF/3PDkWYe5neSOp5PeD0aOT1op8PaAyfdI4JOf7gTl0v9D9h4Y8CmjP1rJnbniLme8gEY3i/t6DUTCNhV6NI3yr+wx4Zwfg0DKq6d0luEp3lxCxp9kV8nMqdJhqPFVAkXbHWgPFpFUguDg4XNG6poYLiKn5OEYnLpnGZkfkl/FPlC0HR8zkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oehdH5Vhly0oMI8UTPWxIaKxcIYYrAkGcvLrQFxAlAE=;
 b=Q/jM95T5ZZUc9HQqYLch6lTA0uIc3lgzHIiy1YWjW98zE2QbojWG0JBxXU03z8ZkKxE5CN+VghjVOTy+0Jv777D8U6zboGQ++yn22u2T2SCi9dFTwT0MHalqfqoJQBK2gBYOmJko1JVgD87BEEz+IaMDM+FGLFDosUV/R96THdErHaqlJHFtBICtqaS/ln88n29Y+rl/bXmVgbpq8kzMcjSlP//+u/IRDEAYI5yDDBqSYNxn8RhQqgfoa3iIrJsRHFJb8yjci4azgX15DegESR9tvo1TX8ayqOfGYz1BptAsyZGEOeadB+7jIyDZqDH5y9v50+6TFtDrbwkXEbRcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oehdH5Vhly0oMI8UTPWxIaKxcIYYrAkGcvLrQFxAlAE=;
 b=OI3R3i3I9HZn1saW+e4qZ7K3MjZrmv6khHt89JIr8SxqwFVZFa7XS9mvSj0Ad1GAwSnR20XW7BMOKyK5HC0vgYJ8ys/HbLHNHtgTOWP9NfqZeR1CB+1j7Kz/QRMb/H03CW3tHF/N1Jo/ailq+jp3kd2+HqKazDSKDYehMrdU6kGGPn68KkVW/ZfvJRj6iIO07ggG1CGAP/xV714GtkExH1JfjEGIwxneT1a6m0ekaZ1NNiJfL25IZKrfLkhHpSmP9OvrtjxDV6RkMZRVCc9BIonJkyQJWUFzdHxQY9ed6OV98njDeMt/IjX5k8mFSyw0S4MJyj7zRnEOm2A4vGRlBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 15:24:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 15:24:58 +0000
Date:   Mon, 6 Feb 2023 11:24:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/3] Rework system pinning
Message-ID: <Y+EbyU4HkGyzPoFO@nvidia.com>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
 <Y+DemENJaLcGW9ki@unreal>
 <9367eec2-f4dc-ac18-6bd0-a184660d0fa4@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9367eec2-f4dc-ac18-6bd0-a184660d0fa4@cornelisnetworks.com>
X-ClientProxiedBy: BLAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:32b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aba1958-140e-4dd1-ef45-08db08564ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPtEn6sdXLfCSwu9XqrUjrf6RhlAPR7Sx5cX69078HRcDXqiDDThpRQYJU3oxzatjAoLoAfzFTm/6HIEQ+wJdZdLPDmx1CMicENkdFOa9lR1Eyj/8x8bNpwOzu/tZft619Dh2psl3ePmqMLPmqkRNftq3Fo/3tkdGnUZ8npRM8LRKabtayfipyYimRqpkHu982kRDXqlH0RnkcswaBq24u5X7tkaWUhEKROPgmig8nR54AZccTbOguUVp/sWfHn/2IuYFPLXXDNsKb70rN02qqVIDuB4aLmDFwZMP325ueAPtD5c888cl/AbHdAVhSR6s7PKLVrYg/Olxk+bx+sYLLHVqfiM+YVvbg59ZFMHTG7ql0VYXqGq0EaksHytB1GuNrX8E9Q6B04He0dI9//DL/+hWtOJ9nv7hpvpPqrjklsWwfF07sABljLDkdbc4eDdbBAALhkVIYBssXHmCCE+Albzo74ZS1TYBE8hz8WYFNoWxdw2Dzi671W2fvFj2gqFEsaerP8nyt/XoaupGNY1VpMViBM0P0j94xMOrtyPO7xREuy+9iWGFgfyalL30Rg9Wgbel0FugZGrdvandqqibLWZVTmLJbTF5NiEvl+HejgLj2e/nb15eXV8D2sOocMQFwNGvm+8MlC96XdZrhZamh63sTnCLmASr7x928NfzFevm6pscIGWb3dFYBkxUV4+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(54906003)(316002)(8676002)(6916009)(66476007)(66556008)(4326008)(66946007)(41300700001)(8936002)(38100700002)(86362001)(36756003)(53546011)(6512007)(6486002)(26005)(186003)(6506007)(2906002)(5660300002)(478600001)(83380400001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VjbZgWBbQq/joBnRiAQakq1pJZ5keJuHzsmofRHgfCEDDLxhgwfrodw305Q?=
 =?us-ascii?Q?l+LWTs8NVdY226Kiaj+4YyasBndk0edRB3bwxZNDjCeHDFXkYH2y91MJhmLs?=
 =?us-ascii?Q?TMJ66rJ4UxsdlJOJsTgkMDthXIhovc19IRlpdudBAW7NNQcwDnwJZRVDZsoD?=
 =?us-ascii?Q?CCjgKym4tPq590Wf2UsrjdBWw+rN1ZESTu+EZJguGmrX/3KfQrZEZ31JpdUp?=
 =?us-ascii?Q?Se4+5W0plHCUQG3P5jiMFDgId1352TRwZFc1vt4dWy6p549MZhIBLk3mAIuQ?=
 =?us-ascii?Q?dZWzihWHFZDhnIXhQzlVuJ1ZZDEHdB8U1ciWBOUbFXTLvNdbxhuhbFW/FAvH?=
 =?us-ascii?Q?Qap+L2EE9PT4kMUDbJI1t4BtVy+bqPdFzaoKZ9U+1kGBTwxAmUqfukozvzHh?=
 =?us-ascii?Q?8XnCH5WoQru1T+SrrlRKrgBAyRI1fjC3YvA5TKpK1NYBV56uOHtG/jw030Rg?=
 =?us-ascii?Q?kiEdpmu6vDPbsOernyQ9W9/sqd/mSodrSKo2p2s9mFp6O57aqAOnr6U+U0FL?=
 =?us-ascii?Q?rnaBMBMS8fTiFUp6SABCFV/q9YDlKjNFKFvz8sHtDhhuRFxFBQABlzSfwTiR?=
 =?us-ascii?Q?tAlyqr1EG9j3Euw8AHowlys9a4bXDqvvuBGFeAKqS8RgBxXLuZoQ4LZMsnJK?=
 =?us-ascii?Q?ayjHRehETIDKBMN4tgcKpTQ1F09s9QM/xDYWiW6gDlsDYJ4nnFCbYdgLmirp?=
 =?us-ascii?Q?Qkh9ElSXEVWRk3KBaBSJbDtcBbqC/R1laj6aUavBAsWISLT+t3P4CiueMA4B?=
 =?us-ascii?Q?MEqX5CxSnZHYoJ9L4pnnxZkjKTZlrSHWb4OGWWD59VbHqIWqF8Ha5R+9DYJe?=
 =?us-ascii?Q?LVx3WsQ/Du89iTxOxEIMCmwEhhfcsBbhWGQqBOyBVzZYdEQA/Km+Fu58GbC0?=
 =?us-ascii?Q?4mD9sU2g6t1gs9Bkae0cPDIk0cKX0ozHsx+n7cxtimNFrOIt0EYcGwMtNLxb?=
 =?us-ascii?Q?vhpg2xPbfhP3Jv7kuKV+cthBtdkXPHPiQCAJ1IXp8r3ZSeKjeERexVDg8G1M?=
 =?us-ascii?Q?3AHsFnPuZnaqRWZFdaf8uglhbvpHj/UfTi8oSfjfRpOrPgFhRLl3dtecLi60?=
 =?us-ascii?Q?hRTm4L4Fx7pGfPs4QlTSQGKRWtNNddkqGTV0tZF+8+Bll+biS07VkEoRyYEi?=
 =?us-ascii?Q?sDlGfKOrgD8USDACcHxOeICotmc08RLHD7GGgNOrnWAMFPPG2L/q8wV0cXn/?=
 =?us-ascii?Q?CGZNizKrt8geqY0c53eJ1fdH2P6dSucegi5ui+a0z1PEmCB1/U791fC/v2WE?=
 =?us-ascii?Q?YRykNL5Atj8pjKOocfJzxPWpaG0L/qqv4ZAMEjrSHByjnqwK9itE4fmgtUFc?=
 =?us-ascii?Q?0w3EcF5ck6D3hyG7jPW8Hwe8kapZ7iA/peHDPeNH/CYQ1oYR5HGlnBK95Vma?=
 =?us-ascii?Q?0h+pcFcbkeCr2R4fJl0OGoTfvccWYigN8+K4u+wcoDeYNyw4udeYSN+Wggq+?=
 =?us-ascii?Q?4raOTrdjTqtZRTu/qU+MO8k9JI6ndlI4bwfUnBVPd521ycfv0gglfekZbO8I?=
 =?us-ascii?Q?Jp+ahZT6ORNRolqJcZSMjzm4x/13JAZYftptWMxWCGc7S+zEyBBkee4Tmhk7?=
 =?us-ascii?Q?wqsEyk0cQLfokk6kkl6swfiyNmiQydTKMB2wzxbZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aba1958-140e-4dd1-ef45-08db08564ee7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 15:24:58.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KozUvD0P8m80v/bbHZw20UBzs+4Z68+VCCnFWrDJ3Ww9vgyxpJoXe+W++69C57w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 06, 2023 at 09:17:56AM -0500, Dennis Dalessandro wrote:
> On 2/6/23 6:03 AM, Leon Romanovsky wrote:
> > On Wed, Jan 25, 2023 at 03:01:33PM -0500, Dennis Dalessandro wrote:
> >> This series from Pat & Brendan reworks the system memory pinning in our driver
> >> to better handle different types of memory buffers that are passed into. 
> >>
> >> Changes Since v1:
> >> ----------------
> >> Added missing commit messages to patches 1 and 2.
> >>
> >> ---
> >>
> >> Patrick Kelsey (3):
> >>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
> >>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
> >>       IB/hfi1: Do all memory-pinning through hfi1's pinning interface
> >>
> > 
> > <...>
> > 
> >>  include/uapi/rdma/hfi/hfi1_ioctl.h      |  18 +
> >>  include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
> >>  include/uapi/rdma/rdma_user_ioctl.h     |   3 +
> > 
> > Where can we see user-space part of these changes?
> 
> These don't effect anything in rdma core if that's the concern.
> 
> Pat and Brendan added an IOCTL to get some additional stat information about the
> pinned buffers to aid in testing and debugging. The thought was OPX, our
> libfabric provider for OPA may want to take advantage of the stats here as well.

I would prefer you save the uapi bits until you are ready to make an
official PR for libfabric

Jason

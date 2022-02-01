Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E14A5E68
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiBAOgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 09:36:53 -0500
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:65377
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239387AbiBAOgw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 09:36:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6JIwNgVWG8DaAEl+Jc5qppyZBfuDxBrFQFbjHlcbu/LVHbBSxG7EgX66lJ7jjDrC+UIe8xJCoFPC840OlJYKaNJqp+dVq7NCsnGVh1Cr4+QSyhAMi19m4A5GFXQ4g4qWv84Q8praSa0J+6F2t1EFJTkCxI7Mqs/m6176HDpAGzSQ6N77kOc7W0BiG8egyefQy4raAv8mIcNwHhUwi8RSAryUlcIUrYR+vHcRzsrjxsqkCeaRUSJctjKdaHmNMy/hcO7ifpi+gZPssmwy6KV339CdJbRvgwO61FXYdmhIFQ7+d5i9rFCfHL+0bSH3KrN+MmyWNm6r8bAX0nuQrcvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NNlkA2bkzFzEr4Fv+FUYlM8blX/EYPqrcsYywn1zpY=;
 b=RVcuIRv13D43exKdWocVAWlJ57uByNhBkKpVVOPha8YXwgADTmEty1dzpph1hvHfMPAg3AgnYToK7CiTcOKtTavQeRZd348ArTzHV+Z7gol5awA8wEKYrmhw7gku+Eyq+XvP4adBVqZER899Uy2ljPfc59TamoOSmOTaDtQosNkyBIhMMDps2CV6vZ62SYVkLo8p1ZLh4VgAZXyeg7YVG4H/vZGSvXO5DSaBj/LIjgAXh17WIhjwogGK2BudyUA05vUDajx0MNtOQJhcrZtWMApq7Kul/bDHtFRWR0RC1gTAqXIls12LVoGx3yOhGn0xInt6ySHUGvyEsjiBYgaZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NNlkA2bkzFzEr4Fv+FUYlM8blX/EYPqrcsYywn1zpY=;
 b=fK+eULvslBfVkM6LiHeR8fxmQBNEAChK2kB4umOt9yYPf+Oc3++NGkpezyfdVz7w9l9j2fKQKYk66IB2hJAbEEnXMdnZ7/z42ZAfOHNE/vAKlG5EC02MmU8Roly7p1P/hVvOoBT+zgpdIwVAh7tsuBBYD96zBxbeb5G29uSpxTu2RTfPISjEDmie1fXOgtE1zeXbSBuvVpsvHEopCXDBs/EKmQ0g0XRvYkfU2CmfQOibxFuUPufWfyKtVhNbZ2I/NFmV52knoXYgtxem1cipRHsu0EkS0ocsCgZCHeD3IJq0DZwltDXaIWdNXA+XLIIUR+AZSsYMe+qqKHrCxU4LQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 14:36:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 14:36:51 +0000
Date:   Tue, 1 Feb 2022 10:36:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 00/17] Move two object pools to rxe_mcast.c
Message-ID: <20220201143649.GH1786498@nvidia.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0044.prod.exchangelabs.com
 (2603:10b6:208:25::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d9077ef-cd87-4d63-a671-08d9e59048c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3769BD7D63EBE442B1FB0C7CC2269@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lnWm+lWSWb0LwLWpvoHqbGpnz4hYZEr/o+mjMDIAZMIymK4omwiQsBug3GvsuvrFiBay9eopaAMSy9tywcVW7uvi6MvE+2LS5Ghdn73nLrfDtBIS/pcCObnR4zEiSyxSoITgwJ0ARx8XQ4Yk17PbZ+Jjhhra/hsTArY1cPjN12IK8nmlRb88BdmHW4u7eQeXSto+y29/3191nTqzuxeKY4BFYMfUBX2ftCEiEsV9IhfTpGLp5jr6hx+LERcBLVK+cg6xuUqU431k6T/5/ElP4Qc+NwoxqHdNb3jseo7vQ3kAY6LHP/FypZTf2+qy2aIVfS7zxosGDbKhYcceuWp9er2/Nzhou2L653Mi4CywMorahm+3+S7On5PcdrvEG1ZJKox9wR9ryD2mdzWdiVrTcbCfQNgtDa6U4yeYvjIr71xCMPwwXclvjhV+mp8hLVtEzWutWdWlYebMsinwiKWfRRLximIE4sTNQpylfJ1OCirWOJUBB1Ok9Qu0/X1D9libryCK0QEySRL1DoNhq5MczBrRn+W3/2jofB5oIeVohCy4E907aWBSGmuGzxmZn87DPcwb5Dt8zIO+SmYTyNptfqawRGCbBM72obPg7WEzSFjZSbW+M1Ngf8jGz4t2P88JFK97qDTTLeaNcYODF3Jqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6486002)(508600001)(4326008)(6512007)(36756003)(2906002)(8676002)(316002)(6916009)(86362001)(38100700002)(5660300002)(8936002)(66556008)(33656002)(66946007)(186003)(26005)(1076003)(2616005)(66476007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xF0GpE0iZdq6tYe48zMyKn01XuT56CWzUteMM/QN2dmWMcqXq8Tw0Iq7VUi?=
 =?us-ascii?Q?q0zjZf5EAZEFyzZfrDpZmRtV2WHbkTUU0RUQ1R4SB8BsbRfKoDHR+Acyo7B2?=
 =?us-ascii?Q?7cXUdkqh+5cRZRfehPN0OwUwszHAZ6qOIyJQv0g7M3UIKct0CLpCLyoIcqrg?=
 =?us-ascii?Q?sEOKsEouFFMvMYh+yX2Ft2f4BJ/D2zZpdDualWE/dN5ydrIlOMS45egJkEbD?=
 =?us-ascii?Q?negBmxGyBNgA5wouFM65DlClC6TPXQg6PK1EBL3GxdsMRv13fxhR42ADY+q7?=
 =?us-ascii?Q?yw9DNY391BwCAvodUp64SUilu1rN4YYtN+pvJZhYiaEXsF1G+b/lA0ckzAGO?=
 =?us-ascii?Q?9hCSmP4FufTToAA+4YdYGodujiBXdkXqJHmtjmZXReg9eYXIechDr6DrdDqf?=
 =?us-ascii?Q?/hnuprYZyNYALmp5j5SVUgs6BdjtpUfPXYzDvFuWOsPUPbCQIABS0D4YTAQr?=
 =?us-ascii?Q?TUqQFJR5SCXsspwP7J6CRzvNLDoi4rhfllNrhJvUzdyKrNAs4xoA+Ye4vC8Y?=
 =?us-ascii?Q?zeskQvfVmbL7RWD6JYJTokGMm5fflFkWBDJ9NHZxj1EgcfWiUc/l0bmvNvmX?=
 =?us-ascii?Q?K4FwK9MpYlQ+dVHCIMsh9kYQruNM9PAR06wOND8J0SR28mVcogjCT3yNUGJm?=
 =?us-ascii?Q?Y5SUSIt5guhPhGq/rM7s9rwWJQZf+I+w5tdSC8A555BaWIL7Sp8XLOCkejvw?=
 =?us-ascii?Q?FDCVGR7thPX7gI1fUs7vYJF2xkTMZi5ERmUnugxydHBqDVAszmXwKXeEKPYl?=
 =?us-ascii?Q?92HNDHRIxgL69BxweEtfaCUG1sLOu3JndmFZwONhjw6cULbmv6soQiFFWfP2?=
 =?us-ascii?Q?CtOJX0F1Ar80EZRuXdf4z6A+++7nEostAjhKatNY8DfYaJO+DMeJopCFUnoJ?=
 =?us-ascii?Q?XRVPhyRNyrUA2m1kLPoyzAnXvFd41LFWZ3Zb/5YBjUxMhDnk0mjrP0jXQZFB?=
 =?us-ascii?Q?f+ZjAssY/Y0Kho2Fi6pJTZFn0I7G6aQpwfH8h/VujwFW2jLgB0LcPsITuR5k?=
 =?us-ascii?Q?6fz3dM8W+BEIjnVkzNaEbS0W8Qb32SLGKp7Tkd1ESGCChaHWdQdLGLk10fAN?=
 =?us-ascii?Q?3+B8xbeEX0FTIUY54Mvqv25Ia6yv645Silaoa39BC1gr+yi75wcZRitjaN5v?=
 =?us-ascii?Q?9m8O+MPEaT7F/smAHlp7W6vvmsYz8j/YfrbdhvC/O3TAk6w05XfmvG+wY6Kr?=
 =?us-ascii?Q?ibfCYyO3SCblcFLNCYyCCfl3SffddvETQz/S0YqXEkhn1MA4cvtL5lmqqo4d?=
 =?us-ascii?Q?fLePtOBmkKeG0pEu90tN9iYsMWjziQTEJEdwZPsk5XpRMghGHorogdR4Y+O0?=
 =?us-ascii?Q?syZjwosL9+DHMkoWci6Q1PdFodVSTx7kG69Iu3qahgzz4yo6Bq45YEoUZxPw?=
 =?us-ascii?Q?XEdqSq9NkIM68efk9HCzRWE/Hxz4v9t7eVcIzkDB75mcc1tDOijhAOm2Pwvy?=
 =?us-ascii?Q?ClaR2ujNJJ7sajPfGyZg5ftiqG4uz0OtvmXP7/kbALxXN+SyMoG2lClNuqPF?=
 =?us-ascii?Q?dteUjMC7hCIrp/rjJYNvY0pjKLt6K7Z/AfEPeQKOBaDN0bL2oGE/bRLbSqON?=
 =?us-ascii?Q?DKhoXUegbZUzBI4nmEM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9077ef-cd87-4d63-a671-08d9e59048c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:36:50.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ru7H8vNYx8wF5xuQq/2zW4qOLPWZwZBdbEnXJul1k3r8NsIgP7fCUZkrLuKFmgs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 31, 2022 at 04:08:33PM -0600, Bob Pearson wrote:
> This patch series separates the mc_grp and mc_elem object pools from
> rxe_pools.c and moves their code to rxe_mcast.c. This makes sense because
> these two pools are different from the other pools as the only ones that
> do not share objects with rdma-core and that use key's instead of
> indices to enable looking up objects. This change will enable a significant
> simplification of the normal object pools.
> 
> Note: the independent implementation takes references to multicast groups
> and also to pointers stored in the red-black trees holding the keys. The
> reference handling code is moved to be adjacent to the code that manages
> the pointers.
> 
> This patch series applies cleanly to current for-next.
> commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07 (tag: v5.17-rc1,
> 		origin/wip/jgg-for-rc, origin/wip/jgg-for-next,
> 		origin/wip/for-testing, origin/for-rc,
> 		origin/for-next, origin/HEAD, for-next)

This is old, by the time I sent you the previos notes the branches
moved ahead to d3f6899b0b5617e8900d6b1ae60414e611b1a0f1 - and as I
said I already too many of these patches

Jason

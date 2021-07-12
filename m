Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758773C621A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhGLRpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 13:45:06 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:61408
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhGLRpG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 13:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+W96Kf2GJINTAFPZnmusEGdnvy8MDph48LcZS8wLUqhPGbR0Nt8OagSF7FHr0tZsGQYG9ojMsoxZd/FNk/o9jae2RyW7BLH7I+DCBP9RI8L6k0WUjaCD/K27rmk4dprcw1I5bKb/XpXTbVxKpv6oG38mrDM5p8cihE5XrA2FgmHUrVbxxOVpx3Nk4HkLVLjh1y8jPHH0PEt2e6bSteWQB+KqlatxPvWmobpIlGKqlP0mou7xAy5hHwzcbLB1XOw1r8isX6u584CTkZdw2Wkbq426VTkjv7XW0MZG/VljRPFZpfeVVZ/8wUGW1WYEkrRiUQlWsZhzMRjEgauCXtJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ruy6zcu/g3iCPNobFZS5/BtzaRbBhEFwCybZEnwu8s=;
 b=V4oFumJXspvPKoaci8KlreqDVlWmparh8x6vR+r8JCvj8QFlQs4p5ktvLrPJRkG+IJQHWS7apvrya/kJHUGl0gHoMNMCv27GxnUKaNo13DFFEsGy+hAI6TNpgOt67nLdev+e6KuSI/thhb7VgMNoC9akAGM7WJhtC+Gdnoyak6C3wRJCOaBVgZiDiKOqM/2axUiq1R97NhKyuv6Ttb1cJU4gY2mG6FntJWdFw9nv+jC/6UR31UXT7xTATxLYP80nwGqh0gH4FKXCnhYC5pm7xDFCxQsdxstPDMJw6jJtu/FtPbJ+4iWPhCx0DJ5JoHKdHlG4TGSAXKYKGuPzfAU2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ruy6zcu/g3iCPNobFZS5/BtzaRbBhEFwCybZEnwu8s=;
 b=ZPzpbHRyFC/4i+4fSR51OyYEyLPQEaUirJLsA7yVl4mkY0eJJWSl3T3sBy4OgIdMUClXFWXxMJIPv8XupmdjzltufG+Bvu0/uvAZLhBJAfZEDRSYTErRM0M4OMmer7sdg+3u7HQeaOFc7ncP6dpYrYnuBIne1azpJYSpzGDQnlFlWNO6NPBymbjMcJXOgtQv05uX8gdv2zskh5PFEbn9pZNj321zC++z4+ZGoDPqFCE9+vYvnthckYLbpW6tysori2MOM0M4SQ4NZQAkPPLK75EHOyHbHBU8kDf5eNBIzdfX7hfdceImI1sm2CG3M4yHptmsy92XyAMMB1N/qrXEBw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 17:42:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:42:16 +0000
Date:   Mon, 12 Jul 2021 14:42:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq
 is queued for wakeup
Message-ID: <20210712174214.GA259846@nvidia.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
 <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: CH0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:610:e6::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:610:e6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 17:42:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m2zwc-0015c1-Tx; Mon, 12 Jul 2021 14:42:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99b0e5de-f6bc-4f39-66d9-08d9455c63c7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53647BE5883FCD61962C54D9C2159@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwPGiH8vLc0By0N2mhmimf+G4rDgz6rBo5vYOyeIT2eLfOVE/433CexMH0bEXoSwXOneT1HQeKuKEDy0CyumKE7DtJRzDDzBPg42I93S78UZmApd0nnye2tuhB2L8NzTXbWwJqaVMaPKRtWi85bf1g+Bl+ab6LBU9vMTcg+LqyF94sBEWMfWZv+mzaxqJJB91Iafg41M8xVr+Da0XV5L4Any7Q98+h8DAgQRLL0SWGE/hPsEmZcsxyEJIuatQfSou6AqgLmCx7Ego+27QJEjib55/2r48hcR3rdWch66R3afIvNhO4ql1gYlCLQu4EOIh7v7ucCqYdhjAsSlniRnQoxgv+0hMB+taKfmgByMzKUc7gulSPEoFXmFAcZrJJNfTZQIlYZFfN4hcGDT/kls7Pw+EEB5BHyyLucvuUe9qQQPRXhPchpwxDHNJKxJ5mJdZ+RY459mG61s7qDskl/N4Hknir7FNH3R8ubgN8ldiyyHF7HWVPW5gFCQ3lXWtieGn65exZyJ+w4lqJNzN/t64nYwmOolcTgdCNEz3+OF9BBaVZiJrBqqcpaHl0ZFnYFqYBm/g6JRvW2d6MT8p53joYiglcEqV1Xy0fmHHyWpexlRf+vNZxehReTuS8RLfbOcubwkdG588ooLTujhpfTRQbEFNPvdV/zVW2vQtNOHmhmk70RbciJHJbMA7+VVy00GPJ0I5LkOuzLg9CaymhsJWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(83380400001)(2906002)(1076003)(478600001)(2616005)(66946007)(66556008)(66476007)(36756003)(38100700002)(426003)(4326008)(4744005)(86362001)(8676002)(9746002)(9786002)(26005)(8936002)(186003)(6916009)(33656002)(5660300002)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2F7RDXjgQdRvH7xbtA0V8bf82PuT12uvK8c2jcAZwDEIpwYCFh6nhBu+BpPG?=
 =?us-ascii?Q?oe74bYyJo6WE63AsdIA9GC0Ndopn6T+E7mDxmEKIuNEte2J5SaL7Rt0QelRm?=
 =?us-ascii?Q?7lUNCMCrUCkjpKLLPUtQcF+fhxy3X2whFZyvgKcs9m8yl3ebZmdjTt9nbwOc?=
 =?us-ascii?Q?T5Zb1mvKNgkXgQojPXoL/d8tskCcf6/iIe5C4nbMQ9mSWfeo4d2JmbIdM+5U?=
 =?us-ascii?Q?lFCCecOrLH45MHSZZVMjU6eRGh9zj2OPVw+En6f9bnvUFo0viIqHgVyCKt8j?=
 =?us-ascii?Q?sqkDOMLXJOuWBaZCtSbaTAx/1PueG3P+kqzS0TspJ8adSa7SIWbb49c7DInw?=
 =?us-ascii?Q?0wj4Xpt6Ie9B3cetaO6WnqebDjRnD+gYAGy6NcihovIofb20ZfsJ35PF57JX?=
 =?us-ascii?Q?5BVTcURygUTx0WnMdGdqTeZD/tqJloF/g689PUyFWcsnHcd0CTumm8wZcUJX?=
 =?us-ascii?Q?laPvOqYeM/QSKWj54g3a75bGxASq7r1y9vvap9dpkt42p5esXhgAH441eOGl?=
 =?us-ascii?Q?yg7Tnj04envwdo6mYjAmVHBcyp6EMtlfbz8Os9rJDS8qHOKO61VH1qMpu2Gi?=
 =?us-ascii?Q?JN39Vfvk0y7WeaiQRtZRsqt55UW61xH9hn+RJzLzveBEJJFzY7eTyRaoj3Bb?=
 =?us-ascii?Q?Gb9QpojGUimYa+caCvsmBozHJDUtXQYMIAT0pgZ6/NdttRZuGLhWkUWu+s+I?=
 =?us-ascii?Q?auPSmzz5LucyU8eVQiHJjItF43G7hiqtyZLZxKzY1wVT/kNTGIJqRCBrDtyP?=
 =?us-ascii?Q?BKcUsa/kGCuW37q/kesoJWwTCfIiYfx/xHCU8SB0mG5Os6gNaLqrvMRZ8iaX?=
 =?us-ascii?Q?pA9A0LBHGw4CR21W2xWsWCghaFKJkNsSljVFzj3hfdX72aMDYWkv5R4OauAM?=
 =?us-ascii?Q?H2oIP9j1RhNoH9AszFPt63EBXrpq0rYM39SJlf/ZebeHYiwgCzKwL5z66zG3?=
 =?us-ascii?Q?WlcObZS9TnALwSmYx+S9FbKcJfYlCQfwGYj2sNZ9nBr3Ay7v9pDY09Nz4+e+?=
 =?us-ascii?Q?U89u4Q9t9yU9aJSKOLksrjjaA8tgYNIyVMmWqThFItUfXKpkNW34l9ir50ST?=
 =?us-ascii?Q?g/H2XvevAm76ExtOOu9+Ve3Uf7xBNn2xnAzaP1ny80Ol0C0CxRov1inqiOPN?=
 =?us-ascii?Q?kXmf4Rmx3/8a3FmPRAN/fi6wk5MRSh+XH3qKnGVtI0rpJBYJCAZOhQgz+16v?=
 =?us-ascii?Q?yhN5GmNcdSTGLuA3WjqeKP8EZUl5TZefUBP/soex72A8E7HPqUih5KOsaLk7?=
 =?us-ascii?Q?A/o9OOV+MENqBTsEJjDWZBfBFLxQ0Pnts5qpDvIGIEVxB5LTaz/CAJgMTxzY?=
 =?us-ascii?Q?3B2nHdMhDpAPgbn8eX/y6J9m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b0e5de-f6bc-4f39-66d9-08d9455c63c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 17:42:16.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vovMwqMKJMe3Nfw7LnCXzWdrIRZPxSxD96L7TbPh54wccbxCNzQBCp127AjeMJwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 01:23:45PM -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> There is no counter for dmawait in AIP, which hampers debugging
> performance issues.
> 
> Add the counter increment when the txq is queued.
> 
> Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
> Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued for wakeup")

Neither of these fixes lines are correct, please resend it with
correct fixes lines.

This commit message is not quite good enough to justfy adding a
counter increment to rc, can you explain how this is an existing
counter and it is a bug that this single case was not incremented?

Jason

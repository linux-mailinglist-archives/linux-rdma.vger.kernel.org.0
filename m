Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA83DBA19
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhG3OJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:09:49 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:44129
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238948AbhG3OJs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKi45+PS17LcXLIVJDCFxuGaXq6JUtgryZXH6SK511fqMj5GqAcPOSRvtvrm3KTgU4yihUIot2TzRnfEOkhoRbZE6OIsZdaXpqu3shNfQCPq4ucWa/Q5pt/EvvRSaf37MXJ3ZXRWSi+sA8m1J01Mh88mtWTuZfxqgu/mvwUXkDH+E1fDNvTl4/mOwKlgBJv0VEPMgw9AS+YGCiwmwRXd7TsszBPpGmqJAZI2BveLfaSPzHwWRv55kGMCAm327LMUJoHwH9eacvWsGJXBSuUIxNLTpn4GecKQhk8oRUMQvFsCbLA+XQNsbqVIhyz+Q3TBma8MJS6+X+R9WVpM4qhFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvHUlX4ZsgQwd8ko0nb3D52Kvs8Wf7q7HQ25GcAdosI=;
 b=oM+PY7eoIkeLZbCXln3KMXMK7G/dr6HujjfzLecB4VdpuzNP2G0VYy4SlD2H4NLP6Rc1Bn8ujygXJ60zZecYJTgc/DNBrxZPCj8dT4VICqK53UdW55yih/pfgLX9JZ+daDBEOKt6CQysyqfEByaGlXl++S+xINgmXI3JNTzpQuBxV0+FtENsYAlAo1R4wb0T/x50YeS4eGxevkCHisAVZkh8wqqd7r/y7NzyRmax6zX0BMJQBzSBCU2bvFqnDV4c/2R5cLzAjsdck/kc2SI7cwa6n59HYLHD1ui0SoQrE53QATIsyHY52NcvAmsCo39ynfo423kxHbhnYpn3udT/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvHUlX4ZsgQwd8ko0nb3D52Kvs8Wf7q7HQ25GcAdosI=;
 b=D7qOXD82owVISPDVveBF7qQGPDdwksIeZ9ZaBvIPmv3T8xZCtyprvTNryJlIubgQWsGllkl94qrRXHkOUl/+BpWREn2NNy/9t3x1yGBklyUVcfm613rGwY9McMdbAG0K4GBx4j0gaEvpbZVOYz3mkpFRxizbf6Yn4I5DhSiyd0j0EexJ3geJxpBK2CQCohnkgE2AKZbgkN/UUGzoNMgJ+tOqcfiI8tLjp6XbBGxzA48bLaa5GFPJlZKEoApBFqUKusFaryfHq5EPu0LEScokteJcDZG4aVx21gK7+k8vyUpYOCQZWDu4TGGRWXu0uLNjM+QWSjQf18U5drZfdOAQDA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 14:09:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:09:42 +0000
Date:   Fri, 30 Jul 2021 11:09:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next RESEND] docs: Fix infiniband uverbs minor number
Message-ID: <20210730140941.GD2559559@nvidia.com>
References: <bad03e6bcde45550c01e12908a6fe7dfa4770703.1627477347.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad03e6bcde45550c01e12908a6fe7dfa4770703.1627477347.git.leonro@nvidia.com>
X-ClientProxiedBy: CH0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:b0::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:b0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 14:09:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9TCn-00Ajw4-FV; Fri, 30 Jul 2021 11:09:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d93a720-ae18-410d-b8ef-08d95363ad60
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128E7348C28DB22D1FF7EE8C2EC9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXaqLKa6HxIl1S3wPkOiqb0B3JQZp3GrGbQSEZvWCP2Ser6ywbEYLtZpcYd0R4bf/tSrv3+pM2/CbxC3+vdFTERuU5k49fN4Q80QrZPWohcpGuRG3KgAEj8uTqyj+VTvlxwInlfvynP6Fcoo4/x4XT38bw+wYUCgfWzevmP7FkEZZlZb8rnkaEXs5b86lwBfhb+sgI+W2IkcIjEBp1PXTPCG5AJ0qsWAa847TVsG/ZVH+OjLo/4j3rMd6CbkAj37s3RusyN2WZCm86QMMZ4pUhUyK6lz4ZTn+Y6IAMKlrhPwmv2p0OT9RnHvhrnsPOccQrhzFQjpRZ4MuY7kcz0v4lTEJ8Hwv3yx5Il86Q5fzEJCtvSlaEtn5fMByuDPNIth10THEsQD0AfduKOMnVoxafa/gVFuOX/kYZK+9H/ROOYAoicf+ZGomlBhTrOHuedmudcLRCSFQW2YCmyiTOkz1lbC/+Tr7AMwsiOuQXLcr2xhRh2ANrTMfyg/SqTcwMB0c8D+OfzM/ydDpOKoG8W1lzsgfJlg8GS/KHK+YQoUCGvNUCe60v1pdK33mco6N07w+jGHKbp1TyTjHWyw0tUgKVQf4sFUMUAwM9w9Gd9ynavkT7UpTfoX1vwgBWfD+56RYcOZODCElszWX6JhxgnFpp3M3lljlSrlcOzBEkjglI8xtUmzFyCEW64AIfofUxD262z7Hv/3IHT6OlKWmw8/5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(186003)(4744005)(54906003)(36756003)(33656002)(316002)(8936002)(66946007)(426003)(26005)(66476007)(66556008)(2906002)(4326008)(83380400001)(6916009)(966005)(38100700002)(86362001)(9786002)(5660300002)(8676002)(478600001)(1076003)(2616005)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ihjhp3iaJ4XHLYgPwAAwOHJlE3Fbs6rOcYGSKBzDXvybCYplPLMmlYwm9Gy?=
 =?us-ascii?Q?CE1H50xEawOWTEsitZORX15CxW7TcbooLwvr7Gu8PGJbdq5rrLkQoQVmtRNb?=
 =?us-ascii?Q?HHJc/KjR2Cw/H3Wl5fABZBtG6HReUuxKAo7NEDqxsWUnoJ4IaEIVUIrxnQhE?=
 =?us-ascii?Q?lIrCQoIujfYYZK1CVW7ii1J1c8D2v0KZb49e3LmcSxESl9pjx87SkAY4JkT1?=
 =?us-ascii?Q?VT36q/UOYJjA7FxOOtKUmlMJKOdOrtjoKeCXVA4ogNc7X7UmcF/M0QmOnkPc?=
 =?us-ascii?Q?qTGss3T6fyoRUTB2rMemaMzsWPOYqMlldyDrU7uVZvvhJcLkz39P2sRe0XcK?=
 =?us-ascii?Q?DoX3xDEz3e2/tv9PmazCMT4eHZWdyNBHhAiOx1vd5tXeQyLSbyQW3A+GMG1z?=
 =?us-ascii?Q?/sw68klX3SoBHNsQoWN6fymmgtQyxWZEnkixuyvn8yjo+QG627lu5FlyuHHB?=
 =?us-ascii?Q?X4Tqkx3ToYlvfOgmsusZWsFCrWtOKVqdqyWg3Tj/7rEDTGjSA1fNHEHCE3E1?=
 =?us-ascii?Q?BgHZZ1OXiGwrX9SHiSX9EKQbpupLXpG620gUe6MP3AKfmkr3Zv+Hr8hfSkV4?=
 =?us-ascii?Q?ZmkpYL70gFm4+TIaZsK3fFLjYXHH5LG8JPrhKuXya6LjDOJ4K/e7lOz2/y9c?=
 =?us-ascii?Q?ilND9cFqtLHNAxI1KkyRWCbKjBiu5bLNBU9NCGg8seZIcDuM0+J5Bo+LhKl7?=
 =?us-ascii?Q?/uimNEDC9rIp0bjIMFl+cW9Mupmumet/vUiJE/AEJKMu5wOx08RdE9lPzbbj?=
 =?us-ascii?Q?PNmU11XKm+PAeV76vSlMF79B+2SbHR6905ZxUgyrtKnv6zlGl6hJCDi4dgw1?=
 =?us-ascii?Q?Lg79mC+DREM+7PSGJPQyp/+L4RAgL7MUC/3ch7iAS0Hys+VBGxKOcLXiHMYy?=
 =?us-ascii?Q?Obv3hMGS+Ck3tWSfDbyIAA1YPkQGe4psBTnZYtlNS3qMoL63wgZ2+hDhGR/A?=
 =?us-ascii?Q?H0PZ4M1akMWiqf6M/ov+gYzC2q8U6YnaWttVcgjoPi+nus88k9blnyVtYJt+?=
 =?us-ascii?Q?oPfXqpxmHIH9k1tNSf9nrhNrjp39Sun/DAEqMcZMqnS5UcfcAEizljfxxUxa?=
 =?us-ascii?Q?lJMMZ+l1SLDOk/uafFT56TP3LCLRwWbeDM1wnieQx+qqFaS+4ie6OltFF+7Z?=
 =?us-ascii?Q?9wRqGgzwa/dgReGF8crpPso6+laS/yp3bf4/7gy2kPQFGCs2RSmxg5zmEII/?=
 =?us-ascii?Q?1hzmNEMS633YTXMkVO4YnB2uoGZbIBxbvMVzLGzqmuciCoTobDKQ9ektgme/?=
 =?us-ascii?Q?uoop/I5QKXhvdmtRIQHz8OU+YXRD8I+xKWwGJc5Zrc0fYZHqJuc1bilxmjWG?=
 =?us-ascii?Q?NeWvc5v3cbFzX3r3OO3zYo2O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d93a720-ae18-410d-b8ef-08d95363ad60
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:09:42.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiZlIKKd7P2+cAhrm9nLYDYPgb/VXyxhxg/nGKwzCC2tLcMDXESriBK3xofy9gUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 28, 2021 at 04:04:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Starting from the beginning of infiniband subsystem, the uverbs
> char devices start from 192 as a minor number, see commit
>  bc38a6abdd5a ("[PATCH] IB uverbs: core implementation").
> 
> This patch updates the admin guide documentation to reflect it.
> 
> Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> RESEND: https://lore.kernel.org/lkml/YPrJorr7r9Kd2IzA@unreal
> ---
>  Documentation/admin-guide/devices.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason

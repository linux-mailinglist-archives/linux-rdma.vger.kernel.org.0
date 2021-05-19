Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282C738956C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhESSeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 14:34:00 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:6177
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230429AbhESSd7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 14:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RplDCChiVa8z13iB3Mb/n5XiAJh1zuwdaMun9BsbMTOJgs+MlzPODS1mVotPcSphwhx4ayiW/W7bKRekhi0Ht0WoUlvFiGwEoG79DAXTox2EKzDPNzYzdnUUV8dXldKp1Pl4DTlXHUSgbscg3QlXkO1c9OLv3n0KpLyyoQ3bl/D928rGxBNlwOcU9MRYMcr9P6o62bQQ9B7Y6VQ2Mdi7sjigeyhKdTxAvqQsPG52uDrB8Nd9/fnJeio68wJ2PdNhpTTXNu2hDpgYQqzJVj4rA23IXbQhcecOmmJ6Gbt/f8WNIpOSxFuc+yLvf5wia2617xG9dQFbJRRRd+LcJ84ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI4bgTQkR07PfHdoybW/nqHCMGmcLg9hdX6hwplz7Bw=;
 b=bzXxKhZvIo4wausq4wByRjvyQlmq3CyZWaJYdUm8xv1nxyrgT++G2SvBNl++kiO17q0fleCCp72NYb5H5KSjPHXuprrwZNHIsFFCa/QjmsbBxmMzqIqYLvwYCotrZTph374tJZgKstNFzy8CFN/JJmf6C9v1ANWOOv2Vs3VxojQSBCcCgsqwVjOaqEoWDC5so02fXLwOSn8gAvDxdFKYEozuinV53YXV1cXShHzFsB5RX6lsu05MXZ3q7GR2E5C1YIr0vg4eXau7+OYilyOMK4g2eCOdnE4sOyRfeB7O6PPAbY4y/IuUeOh7y5AnRfP+PMFXFhjfwUVva0s4C2PsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI4bgTQkR07PfHdoybW/nqHCMGmcLg9hdX6hwplz7Bw=;
 b=oReJbKI8Bk27BYlkpCywG+cJtWdL4+znJz5iyR8qieE1d3fPrv8C3xq7QG+qwguEn3IQDwTnIUzEKaVM9MJisQZKyL2bAjWMHmyCqRQcJ0G07kee5alaAisWOe3x0d5GgVC8fEg09/NPHL6rSE5EZ1nQU/OaBRmoeLa3HsNpcoCW8VjAxyvDPq6BJCWuasPicTq9zKLVtE91LGN/LYjzrpzJym0//8PtJ+OcecT3YMWQUjE8GwAuBeDpb+Mpdr5oURcIwRaV19f9vUesdQTuUxtlnykkeLJ8TgMyj7D/vZORQIjNM4rZV2/GEtyRn+O68m25Oo/xvvnRBzglrn94yA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 18:32:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 18:32:37 +0000
Date:   Wed, 19 May 2021 15:32:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v6 00/10] RDMA/rxe: Implement memory windows
Message-ID: <20210519183235.GA2555569@nvidia.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 18:32:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljQzj-00Aohr-KB; Wed, 19 May 2021 15:32:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53283359-c686-4d65-2546-08d91af47a33
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37370672DF85889D04AF5B97C22B9@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zAaQ4uOHFP734YEEk7PUtMJK/rxm4LMPetrSCylQb7w1RP3PFstwdQ8UfTrNB/bCcirG7hS8iWT7mrBvg0ZXwXnA/XJS8d+TmjSeiUyd2CfZhjfh06WsDGNwgxDxkEt9WmTZvRJsnQ0/YI8wMNdmIX1KemLBV7rzoo3dXilzY5BSXlzDGnqarntZDnse+FRxHTwUPhffg3P5rckLmofrjyZzXhu2dXTwK2bDzoGNIYYz8Rh/WPDrrZkER3DyVmU9VbXKIeyJC2X4Va8x56ShCG8h4xaYsYaHN1JKDD49zkFvDX8dwXOfFYoreEiRA2ByOzDQO9qzniZRxICpqyk+kSG9CPi+ZsubmMRQrl0QxOIAyit8frhbUYiJk7AUf4IqwtQKBXwGfeUQuwyUUM2Y231kjM40V4zLbr5ZXC3XpHwpPIOrXnMjXQd1g3nUSIXjvQsu7aTohIYPWAy19je7kLg4LBzb6Jb7mgC2runjXiZA5h6442k9e/9Qwo6vdya6xTdzh7JOodvefFfdRvogTRk/BGAEXdCpNgYnhtDofMkoJzP6LwvKg6M2ccYk6ae9bzbWv32WY7EdOBQ4B59/QgVy84vQWGBawCWDc1VWy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(86362001)(66946007)(66476007)(2906002)(6916009)(186003)(36756003)(66556008)(4744005)(33656002)(316002)(478600001)(1076003)(38100700002)(9786002)(8676002)(2616005)(4326008)(83380400001)(426003)(9746002)(8936002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NxSiO4hyXHkqPajWo1pgrR0pU16tzxnHwZpNy6ZXFHUckCA5wrUFLHtPJ4yB?=
 =?us-ascii?Q?mk7KQylKxIteU3NjHFnHQNNvCLhV4vRI94xmxoPuXJhiYl8fLL9VX1qN7llS?=
 =?us-ascii?Q?v78lr8IQYnp7GF9gZonMyfqSrmAhYruQxJd/fMkVXQekMX1L4bXEI/qCl0vr?=
 =?us-ascii?Q?kAS+1ts6gEmaAn9hf7wpuM8a6Qntlbbad9yrwZoZ8zMhDKCIFqecavvW65aI?=
 =?us-ascii?Q?dFg6OaiPEykhTlfU1jc3UMPo9xzFRUGPkf3+xsoRwaSC72xf0WKFeFiLkhTo?=
 =?us-ascii?Q?1Y6xoE9QGgvEVmJL7i/a6MeGaewVSABoEzHYYf8AWE5gKhzJKtLx1m/A1YkN?=
 =?us-ascii?Q?uvDgfhWp/UKm/nSZYxO4lRggNZOcn0nLd+VoGOcB5je1HqsODK+sS/RWhO4s?=
 =?us-ascii?Q?G0ZXVT15T5AR1iWaV1MFErfwZkZ3w2ZUHoikjcddAoWVvHS7PkWPg4xb3Wp4?=
 =?us-ascii?Q?r8tTw4Y/DCi0N+JzWg4egmg3OGWTMI+nNCeO0uHNa/63x9aFVs3ODg+8YKWz?=
 =?us-ascii?Q?OCam4UCp4Pb5rNKVrf6SIrcOpqDSsFJoT6fiHmh0L3R5ongoMYReS4fjgvdz?=
 =?us-ascii?Q?cXpMcb+iI5X6KIkjc8OtP4dAVg0H1T7VFmUixcT+9GyqgoLZc3uIqnol7bYI?=
 =?us-ascii?Q?BeUmyT/sn+6M53fsKf9PjCxgTwkV8IEaYfCEr6jnX0IdmTzefAOVbH68oChs?=
 =?us-ascii?Q?ju28TLhB19qq4AzpHWdJCFlmjypvjxhSD1cM7tTKods30vW+I33PNmg/obC7?=
 =?us-ascii?Q?1rtQsXPZtILJXFAejQTR9w/VyxXpWudREHKcCpOObHQncdxeOS8h0t7bTxr9?=
 =?us-ascii?Q?0oN9Vy5NYOm842KztjNWU2FOPIBzjOvxXl5LOlaoGXHF/RHfBvmmwI4IBMcX?=
 =?us-ascii?Q?66i6f4eW1fjw22RhLGAHOPauPJfJztXL9tFNh+JtTBXUJPm7gjbqq0qmTDI2?=
 =?us-ascii?Q?oyFKzfZTLphVCWFmY4tkW/wZbTQUU4HMxXhMbR3MtH0i9EcIyF/x+lCarZ6s?=
 =?us-ascii?Q?RkJvSuYllVFiQNP3h8311fwicRtRuTEDIpauEWT7f1MJoRF9cXOz6lilc+V8?=
 =?us-ascii?Q?0EeOnCmkRowsg910ZC/Rd624xDYQELO2h8LGisIffEO3NItRfEa3L3NzgMml?=
 =?us-ascii?Q?eanZ0njOsKchfyce7d18Z5FuEAmvU/lJT60W+MT8QZGp30LIlXJ4I6ODIc/A?=
 =?us-ascii?Q?98Kq4zjDN7KtBrm6sIiTLnrXgO7panN+iFivMWA4xjMpMRoFikBUx8J5xwAV?=
 =?us-ascii?Q?fIERr9PbKBxV00Dx4cqUYSiOqC86mFZN4Jd4MvWAVeBTH/Z4bDEW2kqJp1rc?=
 =?us-ascii?Q?IGbW5RKTyPE396QnXOJnCl/A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53283359-c686-4d65-2546-08d91af47a33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 18:32:37.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTEzqJw424pANxu9fL0rQOuFMlQfkT1HvFIW8L+UkCOZdST4xSE0u7WM0hMvhezq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 29, 2021 at 01:48:45PM -0500, Bob Pearson wrote:
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch
> set. They apply to and depend on the current for-next linux rdma
> tree.

I suppose this has to be resent since Zhu says run_tests doesn't
pass after this???

Can you please take care of a few other things:

 - Make sure you send with a consistent email address, if you
   sign-off-by with the HPE one then make sure the patches have a
   comitter that says HPE and that git-send-email includes the 'From
   <hpe>' sub header so everything works right for me.
 
 - Word wrap the commit messages to the standard 74 cols please, not
   lots less

Thanks,
Jason

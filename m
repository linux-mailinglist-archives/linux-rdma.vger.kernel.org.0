Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3524347EE1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhCXRJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 13:09:37 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:60993
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237066AbhCXRHZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 13:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abEaG1O36lWbxsmZdkLzk51ffQpjPNAEKneOr1pH++34OXAIpcLYaW9mekyhEjR/5TOJESXeir0RKjfFPV+grN/e1zpq9O0CFoukItxh0qZMLBHTn5TzmUKXsCRP6Wcq1O8MaBfJkrP6950l85YbAiZTwvczTDC7Kgxps2i+tpXqcCsSqa/v+FGhjqrn5W+hYreqBzbWoyqInLoJfNqP5NzMDYqbOJdrN9ZcVFVDngkBBh0hLcR1I09ARrnxbgLhGWt+I14qEieCtyFRH+K1kWhMLtl0q3v4es+vz8ArUurIldy3qJCx0msvnHQbfQZ2NrHh4cycfpS9EGAnYu42Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00ak22GNWp8Tq2w458jCKAU190tOiSQMJW+R8PoT+1g=;
 b=OIBgfMbnt6DX2g+0lqwormjR9kV+3GvOBhHrEUtkfow3AehOujm5n7vwoY3a0niDuEAs3H+g5uuj0IAdW5XpNtIMYjxlo5n1yOVaT1uoKSRUuO8yfN+OaOp5fdigonvcWDYjdE+1ciGlbf109s1OvQoLafLlbgC1l5rLq+NDb29U2e464luvLgoRFFddsyuasTfnV+Xb3nrl7bb20szcbzfgq0YaJIEdqph2M394/FgD7B/LfTgO/KnXp1TnTvDSLnSCfPH3mLMSvKVAbhu57WnYRVrP61oUcL5tJiGR1AuwG0N1JNr6/pjOh6dMUH2qCfwF5IiolIT6RFiW3HPi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00ak22GNWp8Tq2w458jCKAU190tOiSQMJW+R8PoT+1g=;
 b=FxNaXVAaKnfmwiylHUl8eyCVTIxPeq2kgSHQLvjlFPJ+KbF7IMSXt+ZglK5SrhLjTaCgq6SeCND/VOOMbSTj0v52RSvSRl44TqjSoaavm3hnguK4JbnZRhoJEqDb9VM6+Pm5kqHVZPI/6RjJ6Uj30uXxNZqMLK21TWtaBbXEKTUSu/oTGSECLmpGkqUdr5Y4vc6kiY2bPJSN9U29nQyIBUQVsk8FpmJVHzoJ+k29/F89uS7/e/F/SZKQYwFxxnqBYPAXMNheGEbG+IX7ayXDaw4jkT/CHGOVknKVF6e/fqVg0BXRBFNnpA1wrr9P6lAT1apZQam7bGNUdaHa5inDAw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 17:07:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 17:07:24 +0000
Date:   Wed, 24 Mar 2021 14:07:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Split MEM into MR and MW
Message-ID: <20210324170721.GN2356281@nvidia.com>
References: <20210314222612.44728-1-rpearson@hpe.com>
 <CAD=hENdyLYLYAyS0Mq_jUb-Vm3P102hiw2Lzmz=hjvgcBn1t-g@mail.gmail.com>
 <c7fd30e5-dfd8-cd95-3b69-ea94432953fd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fd30e5-dfd8-cd95-3b69-ea94432953fd@gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 17:07:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP6yX-0025DB-RN; Wed, 24 Mar 2021 14:07:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c54cfa-e3bf-42e4-8ff5-08d8eee74b33
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811C5858EBE3520A3AA7964C2639@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xCFySa0pAk6W28aCDZ/rIHKvgklJw/HeZnCLbQewP5PJXtKRnwlP6CmAaFAGqJ0ptq2EXh1TxrwLQinVQk0yTpS8kf/YYw9KW27QFcW5KouU5QnEcWbfy5qWl5ZI2okoXLrndthqMh6BdPQXCDyR7qek2QemNDgz1lazScrgcRp9mQcHNhg6AYuZkAbf65p7biPRSdZrZmwo0AVXmMSp7pBnOl2qsMMTxp94CR/tUnXDXgXXEDk0jRlPLu1bgJ9umllVGAZOdaXTZROqe1jE091orKGiWy3rVN1sJu89o7NDRlr/1yYQWOhWMXofyVVzXsClZFsADnLnCPsNBApL9xqzH7qx1EAE+hNbSY/HAaJZYv6c093JwezWkGWwVwsYE40Q3hozvHEqEO1i4VyeXzJCjYfEQG9NsLV8q7f0oiXHOs1V2U4fOafEMJ916QHNzI0Qu6WYpZiJmJ+NegVQNI4LbEvEU6AcIgZnV0Mmu/b9gYtPzorFcJoxnrgl9BC+V0SIJkvLwakqaTIDe99BuR/5hh6Li3wSQ/XiYnQWmTGSDuoioYHw1fN1etl50yXyF4RStowY7b+ZLv6tX7s4/HSUeN+n5mEw/4FX+NxjHLhFvchA/BxfTL7Qgn8Qh3VA9ptPLNe9SgoJT+WeSqqRdglSUCMPYwg0g/63JDUuhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(8936002)(478600001)(9786002)(33656002)(9746002)(26005)(86362001)(5660300002)(4326008)(1076003)(66476007)(66556008)(186003)(54906003)(83380400001)(4744005)(2906002)(316002)(2616005)(38100700001)(426003)(8676002)(6916009)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FAFP6ScU4KgMJLXaUlmqw70Begw+Mp3RaojJ8/MTCvsi7+jGFHKL66drAZAV?=
 =?us-ascii?Q?fBrn+X2Aesjy/FdeHCGoTkDalAYDHB6XtvVFJRHu5a7+2h2Ysk39nJPKg5VU?=
 =?us-ascii?Q?QUq7kb7f/Off5d20b2vWPUFtQh296Fd2Mt1pY4OVPQxVkGPW2MeDZQI1ffqU?=
 =?us-ascii?Q?jptZ//szlwm2bGCUFxFA1TqR6q0O54JT1GBAq69rT1H8IMt0DB4v75Unm0fE?=
 =?us-ascii?Q?nZj3cOFlBR7hQyaAepSvTjEGP6Vt9zUmEq9OlGr9fHwZYSq27FfhA8LY2e58?=
 =?us-ascii?Q?UfGvK7/rqB72FfmLenl+u+YU7Ov+A0yKehIBbTXKKDKhctH5KCUye7uyxWT/?=
 =?us-ascii?Q?ncRMGO6lwtKebkqCirUAksiZBnscYJD5T58wi/yXaRjZOdTOrOv5Sxe+bsVQ?=
 =?us-ascii?Q?mYJI7wXA9hPzkG55sxiUUDrqsf2l11TCgO89+LCo88l+0OzKHVb/nQqnm9E3?=
 =?us-ascii?Q?p1x28vOxHVIm7P06yw+Wyue2h+SrjAG46SYakbv2bf6GYeTs3ifv73HDHCdS?=
 =?us-ascii?Q?VOahqyxQFz16mGmdC5muFCSQXYGbPcoaQ2Y+lCwq+hwgdq/7NkuNrTa/LMCQ?=
 =?us-ascii?Q?vVcu5rldB3jclskGs/AnlM684JdNsRzz9z+58LssT2WQx27clEL/005t8Dte?=
 =?us-ascii?Q?TJySeV3yDYtpEtPQduY4JHC4ZGCH1maP4ZznvbW4BSHxBTkuWMZDcUDmVBLN?=
 =?us-ascii?Q?h4t7rP8g9CApMyJGpt2cU8JJll9zKRDcFemsqQap+bjwvcbaGr1NMHuhZieL?=
 =?us-ascii?Q?7dAS4Om/FpaAlW+6zAgk6MFFpAUPk0lpMY27Q63cbciKEa0ZHNMNhmj4+46a?=
 =?us-ascii?Q?d7N7DMGO5aiCPJg+bHcH3GHOassXqpc/vOQs3q3NJ4MXsj7fPVoowMmONQjk?=
 =?us-ascii?Q?iuSKeewpZZH5l1iZfJ6XdRZj35/eDwuwDPPGnTVfXorB0S0hc9Wjqj1BDaph?=
 =?us-ascii?Q?rJ7obeEYcplDI2cxdOMhLDhrcZ38qp05HzlmFdpKaQ8ZKg0qsnt3W/p3aNcQ?=
 =?us-ascii?Q?AU7F4ttb/WEuh0VTLsNBO6J5AJ6TIAFhm+f9orgUYu2llrq4JjHjxvbM8do3?=
 =?us-ascii?Q?kUk6cIXDyZlh2SA7HWZA7vPe8VPvSg73auzquUtkJjXXLnmzgSGTuwqfDfmz?=
 =?us-ascii?Q?9WVEZuqGoJXgjzhGDpNGt7pjHYmoMIweb40GdBEnqD4qVRI96oWplRgKQrLp?=
 =?us-ascii?Q?ChH5rW968wOexdr1Ezl0p2x8LEBLch+y4g/f1BqcCJoMQduGsow514VWdZYl?=
 =?us-ascii?Q?dmSQwgWnf2UBkwctzbOjIK+zVy7uQ+Zbe+X1pI1QznYb+gil19WfwzBTtZmv?=
 =?us-ascii?Q?xTD7vvLadjxSgU5AnI7xp3E+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c54cfa-e3bf-42e4-8ff5-08d8eee74b33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 17:07:24.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8oJaiMjgghRE7zzFX1NVO/Z9yWcWXfGZElE64IihYsyv9p7UXrX/mgOy/VWkcvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 11:52:19AM -0500, Bob Pearson wrote:
> >> +struct rxe_mw {
> >> +       struct rxe_pool_entry   pelem;
> >> +       struct ib_mw            ibmw;
> >> +       struct rxe_qp           *qp;    /* type 2B only */
> >> +       struct rxe_mr           *mr;
> >> +       spinlock_t              lock;
> >> +       enum rxe_mw_state       state;
> >> +       u32                     access;
> >> +       u64                     addr;
> >> +       u64                     length;
> >> +};
> > 
> >  struct rxe_qp           *qp;    /* type 2B only */
> >  struct rxe_mr           *mr;
> >  spinlock_t              lock;
> >  enum rxe_mw_state       state;
> >  u32                     access;
> >  u64                     addr;
> >  u64                     length;
> > 
> > The above member variables are not used in your commit. Why keep them
> > in this struct rxe_mw?
> > 
> > Zhu Yanjun
> > 
> 
> There is more to come. The goal here is to implement MW and peeking ahead
> MWs need each of those fields. As soon as this change gets accepted I will start
> adding code to implement the MW verbs APIs.

The requirement is to add things when you need them, so if these are
unused here they should move to the patch that requires them

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9759359FF7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDINhn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 09:37:43 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:44257
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231402AbhDINhn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Apr 2021 09:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrNYoW3bwE+VjXhkZMfZ5hkECFNFqodLk4K5y6UeJ5F2odkPYtepbjXR8NO8vKq1LLXrkDLFOZzdYcKxmPy2hOjp6mMRRBwVcYjd1g8zG8zZjRVKAo8/EPka7Dw48f8SBHJzTFi37icdbnKj5eTxD/hBlAd1j3HhLj0UPC5uZ/uKB+kfSu9bRN1fBbpwAveDrsKr+7tmjY8QZ5rSzHQY0yyWxKNm3pMqEikBBwU639JXitqRsmliWEtaxam7LhvuwFoEVApXuj9p2k/9+g2q3s0YsYMu0vDIBc0G+H4fxHIqPwsZZYcD40oWrV+udt+1cPns/EA94K0USv6MD3fLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+0jXaiKPZ0IhGEeMMVQySlW06RW99egR1dqgrO827I=;
 b=cIrZtQx5/eI5kEsnvXdRn+MI1rr4ST7lqT+KTTNHGQMf8cFVKRU7557gfuacBwFYy62r1kZNHduOoHljMIyKA2FOfB1Rc0FrEHeAC29GfR1JGrmyu5/g2ZaWwRRET0qPsfZ7FBtBi4xGSe0yleGLlWaSfx6/3oClx+PzF8Wn7OaG+j7wb896g1ZBiM8v497gli6oF6FUJHvTKIDltKllHy+gWW/RE+yVDJY9tosYIwJigmLXOULIHxOHjYuChf7KaCiyj/WLRWRqoHVyH9Uu/8t7/0buArDSRUX7N2a1yXJW4cpmnNhk3VzAxBQKgBgn6l2HfActZZUyjGTmORa1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+0jXaiKPZ0IhGEeMMVQySlW06RW99egR1dqgrO827I=;
 b=I/63P7drTZfZKApL9wn34WLA1dg3gw/3opGMg+4EshS6fj2vGs0KBf5wPT2DQKGqLQqAvG/bJzExLSy3NINQ7fBRbzKM9abLVrDrqmSxRNnpNhzLq3P4hqhS8rIN2r3FCA+oKKFCpMLfMUuz+VyxCTkGxdglJD4fki+JTCB8i04j/A7dqwDGuhz+97oz7m5R/HBXWXz5EE3BUniGgwNPOrWakkdCY6yPKF5K+l9loS49o5dtyGEk26l75w6oN5lh3CU35seTe2PDchT5t/nEnIL0Wq0Z3Ty4J3gmDLixjCpAKkUZErEpGBv3JpZgvBrme4J+TIjMuo/Y5AlNsj+B3g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 13:37:29 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 13:37:29 +0000
Date:   Fri, 9 Apr 2021 10:37:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable set in cmdline
Message-ID: <20210409133727.GX7405@nvidia.com>
References: <20210326012723.41769-1-yanjun.zhu@intel.com>
 <20210408183359.GA676678@nvidia.com>
 <CAD=hENehGzGn=nxNO0B8u=nevFx1CGsiovxtir3OCZ2ffVB1gQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENehGzGn=nxNO0B8u=nevFx1CGsiovxtir3OCZ2ffVB1gQ@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::31) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0116.namprd13.prod.outlook.com (2603:10b6:208:2b9::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Fri, 9 Apr 2021 13:37:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUrKB-003L9H-1t; Fri, 09 Apr 2021 10:37:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f722e4-1068-42ae-bcdf-08d8fb5c9ea6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB352852CF73C141FC01206ADAC2739@BYAPR12MB3528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCaSXJcADPmvM021eWUgGIDOlG4LygkN+WPV//P3/3oCqTvNpqnh3g6MJpJ5y3ALm88T9R9IQIX3Kbm1q3gZP/Lz87ekvvaQh+GDe5+O8LplBZSBeBiJMMmQHBQotYpcsoZtwGLSSvrTUwqW806ZJtpvVCBIu48M+2DnTym9T2rj+k3WsbsXUUq8c+Gjc536TCSbnkcHhz8y5XwTg/ZkeCLGjiG4TsmEyIs1YS0N5/DcObFoBjoxYkRB3dMcvzxAuEjYSRJCsx3ja+PvtT+Fn+rdS9gZ0XXg545rgmAVoP9JQMw3JbPrTIPXuMwJvWSjT4pIt+1UyRH7hRdXezQU73FqLmO8q5uJskMpT5HIuxbl86aQeow5tkoShqDA5LpQhu+Bns4NtMkLTZPR/7uZA3KDILKonjZBN7+qiGztm7/hHlyetU5s6B3fVcmoBz0NDCo0jrorgQLu7jk7WEHokgjtvtFmuVO+DZOJMM+QlSTGWpAJDBx4VhBOttsqh7cfrk0wUjSKn/hezAX1Rse1wAtUkSbzZiF3sG43uaqtxa58bdTNzdcmeLvghc3+zEGTbkETS1+rqqoA1M/K9/7ikwUpXBRA3sFX0RxKbiF3cfPCaPQngOAVSLlhbH7UmOW+meqprchF54509WNgnByzkloG6vLsPcpV2oXCTSxuCbUzCpRh31naIA6zfmWxhr++wwpcTxa2s46cS78NYJs8sOiWRYwxvoYopb4IriumKxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(33656002)(1076003)(478600001)(9746002)(9786002)(2906002)(4744005)(316002)(54906003)(86362001)(6916009)(2616005)(26005)(38100700001)(66946007)(4326008)(426003)(5660300002)(36756003)(107886003)(66476007)(66556008)(8676002)(966005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EMBkmx02omR1Uxh9fZjvvYNVI/UjsuFEzlJTg/qwmBFUvqIs6jw0p7sVDYug?=
 =?us-ascii?Q?46b3fu01lD26qoZQgIEfeFdbKMGnPqfBNw0exqlpAcXL1Jtg63cNkrPL+UH4?=
 =?us-ascii?Q?EcAX/FapOPT8uR9ns3DuCspvRsi/phPOcHbTIUN7U51hbJ0A6kU6p/kAbAFl?=
 =?us-ascii?Q?NkLUGg4VAQ/072Ox4K+Td9Qr+9IgCcUJN4wauFPCQzxcdIdLuLLtIL2jRnGE?=
 =?us-ascii?Q?5imSpPqNjrDWmhVw8aQBdKrOt8S3ZTlO6M4Iykrjey2YSXMJ/e64cmeqMyd6?=
 =?us-ascii?Q?t0hlSNEhb2gi1PBFb4dUvjkJuVZUbNzU/xFOzsvdmwl3VnVsQUQPGZbDhMIY?=
 =?us-ascii?Q?4HxLJCz3X3KzxOxuA7xN2Y85U41QXokgSA4EbqlTfqFSZwL7e2ketsE0ci/V?=
 =?us-ascii?Q?GNW7D9fxKuFWmB6XSVLneTEtU22Y2cBNBHF/Zb5JE5GCF1ubHbgsJqwsOug9?=
 =?us-ascii?Q?6bkaMiPniMrl3qR32QHf3HsqvHEOUefBK+nXobVYx1rYRP7z6l+hoEyEA8xc?=
 =?us-ascii?Q?yO5dAHEoFNqlgwIqlLx3uZmqEBtzXWcuPxS0RLcZpY80TFMn37GnizFWjQxB?=
 =?us-ascii?Q?xvV1K+RrtzBzoJ3o8BMkwbzkTqllAG3uKYiSwcqD+EonZvwBk7VZ1zWc14kD?=
 =?us-ascii?Q?ReHLWvJl5m2DP295zb9i3CalsddGP7QFaYSk5MmDaxjBPrdY7i4yrhZ6cTGM?=
 =?us-ascii?Q?52dQFczoLJtJl0BgRe39DDozpH2xVdAN63BNTIhsH5NCJSjLa2R12upELffz?=
 =?us-ascii?Q?Bv2jXCKm/3nWDy8b/z9flgzckSQRO9RdFMr2oG7f4/viHwhj96epyTh8ZiKO?=
 =?us-ascii?Q?kE9rrzxTZ6J/IY49AgxmRA94zkLvjvSsnSYenTuHC7JfLdQYbyNT6oLUE4Su?=
 =?us-ascii?Q?E5tsBjAkCMsYNVwC/Rs1z+sXWCMOKlLknnhT/rX7gYh9FvrSOIyPsGbhX7na?=
 =?us-ascii?Q?uHo87skCxjAzaObAd783lanj7XinxAOozIMRiSucQ+VJ5C4M946ku1FkYcXR?=
 =?us-ascii?Q?yYp9C7dyddEZj1slUAmj1ZwB8JYpvO+wZQCoJjfrXCMV6VOJ9th/9r78pRxq?=
 =?us-ascii?Q?8X0vCqPcyz/rJre7/Mt1Bmzd/lNNJMuDHuiDPxx8s0F6KSp02DRIcp2LDPnm?=
 =?us-ascii?Q?8LMqfqq45t56ZPrVKRfwrAu1YggajieDTDQ3HTbPncBx22esz+nlbZceNoe5?=
 =?us-ascii?Q?7oB6G1v8HzJmcEwX4++85CYyXhrKMtZb8Gdy96pTFKSMPRlRcrhHe4MaOJA2?=
 =?us-ascii?Q?Nxqvp8LYyHcI8EhhDMVxP3978jMtRQyKxkQu8p71G1ygyK1iPScFKRDs+FRx?=
 =?us-ascii?Q?i8Ci3geOZrqX+MOX+r/2HEgp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f722e4-1068-42ae-bcdf-08d8fb5c9ea6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 13:37:29.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii3uaLaOoEgY9Z5KY43e9TF9vdUJDTmTPvHTEv738JOoHCP16hZXxcgpHTI3I2+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 09, 2021 at 10:36:42PM -0400, Zhu Yanjun wrote:

> > What is the actual symptom this patch is trying to address?
> 
> This patch is try to fix the problem in the link
> https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t

you should ignore the -97 return code when creating the UDP v6 socket

Jason

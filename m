Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99F03B45EA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFYOlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 10:41:49 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:50016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhFYOlr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 10:41:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/AAfCxqdWP+YER+a8fzxLpGdbgZwi0YxuoPIzGxAkSaMsG76UHdH9cEEsQQHkORsmEQE+BRigiu4uEdCBEe8YvuiPO1UKmkAWUJrDtMYcy19hnN/oWGiSV5Fi9U2q3vITersl3sdyhWF3YCvs2UckF19526ro4FGc6CQaCh7SqHfyTObbzM22GETsxioqrP1xobaXDeW6g3YfFpKK0WVmVRH7NNeoAxPfKYHOWl8xuyLpikJuXG3pWOMbgz+5m+NP8Lc39OC/bSIIfKswxloz1T7P1hm3C05NMduUGSLEF+AEiVfwggtge8NtAUpalMFJF502aDg/pQt03CIoQHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyEcjFnrbz+Oc4BYYEHk399MuQAPbboZddaU2pMD3v4=;
 b=HnT9wempmvtJoRV16r/qncJ7CfSvjDDGhc0FSCrPadZndr0owYJeFtnSmnYVMA5aG4r404QKrS4VlYp6GpgzIOQCsWuB3CX/LFN02fvGEXSduav/AOSydpx1OId++GaDlgXmx6E0Iom6WaqxHUUWFE1kbKk8e5vbGMX2nkTf4kb1SW/6J+w5V4f/4zJ2/H8iafv4goqTH3Xg5p0KzhaOvV6zuMsxdyhReJdGRoHoILR1ruIG18/9Z7T2dKsSOPJKiEZg+7QaNoq33B+PO5/41mdMb5RMzprRChYee/DTTWEUYlg9nwmcArHHOlzaBdkypr0PIiu3txDxJ/OJRQp2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyEcjFnrbz+Oc4BYYEHk399MuQAPbboZddaU2pMD3v4=;
 b=R3TmLWRCzhRpO3mIM7dzp4iaHEt/02JgYQByIwE8/Hgy9HAsdhehsiCQ4hnBPyzo5c3NlYTNvfSAT5CZfMhCCc5FcMdA8l4tLHf9cY5S3wUHnUFjcyb4wUc9h4GRvbb3M4Tp1FeFNyacVbi8CBDLEOQLIp0ydInUeRMjjFxj+6m5szgWJLjuJcrxgfWuk+xt+WX/6MPgrFgkeTGqRO9vbCWn4cHSlKM7IlEFYHA7efjTqxXyQZubeQAELHW3QCe5CcmFaT9JbRfr08YqRtqKvGpaXwPVMaz3ceyDu3VVYGc0uct0GpVBRqR+kMOnP/MkDbskmgt28jsCmrb3lBECgg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 14:39:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 14:39:25 +0000
Date:   Fri, 25 Jun 2021 11:39:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rxe MW PR for rdma-core
Message-ID: <20210625143924.GU2371267@nvidia.com>
References: <29c7ec8a-3190-cb75-855d-f8c9b483d896@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c7ec8a-3190-cb75-855d-f8c9b483d896@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:256::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.11 via Frontend Transport; Fri, 25 Jun 2021 14:39:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwmzM-00CZvp-M6; Fri, 25 Jun 2021 11:39:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71df2aa-7f57-4904-5638-08d937e70794
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5554EE36A31B73B933B9EE8CC2069@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohwwdGtbS4DZoLgECcTlh8vYv95K4ezeWuY8CEAbEbh2V5JcYs4sjmItfrvzkj/19tf9VJNSzHmb17f+CtNRSKEelryHxOLTdwGFOENglLRU4als8hOVw3nE7MVC7QIlo13as3l9hPWJ6b2hLk1NIE+ARiAynec+19khuK4AeKw4R3k9b9a1zp9YciBhm4+kCt5QoljkHTMQtijJqRVn7r0LE6HjOO34qFKPtW8tusUIQsMVLqZvNbCVQkx4D4Vm+ybA1BkGADDhYM04NZzlG8iSMnWUYdkb2BsNe2INb+vY1vSYtbdaDzk/jaY/x8ijuUvjBIxp9Si7Zw75ox1wBi89KhCVKtPx3k4dTuouNVyUgPnfURW1wakYJFEcX+qoK/M5tahWI4qNqPw9JhWiCJrqHTk+5v1cex1CS03/L2STlw5pIWkoouy6QZkhav++OmMs4PxVCDFQ/a4rbFvZ4LmCzQtcsw9WRQ3ckn+G4o24EUP8P7X7o4bjqmqIHsIWjTMSUjO4QP2J65Iy0NEhDwPSQfp2Gb3NKOSigkJXkg9NNM6gde/A0i7S8poxu/UDXlBWcY865q3E7kzSietgzoAkTL0KEgzytFcsY2uwdh7tvchV1pm5pVctYdaYGTQJO59kSts1HQe+QHG6uPfi3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(8936002)(66556008)(4744005)(54906003)(8676002)(1076003)(4326008)(5660300002)(6916009)(66476007)(38100700002)(478600001)(2616005)(2906002)(186003)(83380400001)(66946007)(86362001)(9746002)(9786002)(26005)(36756003)(33656002)(426003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/fm/Eh1FV9HJh550W6ehla5bCV+52oGCyNUldWOnzo4jafqLZEOyBtGAHqq?=
 =?us-ascii?Q?evmzJfr9GlIUtiVpEbQpfOMdisbC4nyxLBrcOdTCiIrH6aEcmLXNnJ8TiND/?=
 =?us-ascii?Q?+8hGB2M4sph7g38BGt3oiI+THLcfHzFHmdrynbzpifqnffSFMWiOe2Yrbc8/?=
 =?us-ascii?Q?B3Lqhv4x5GPrGSTshturjMb8rj5drkxCslJ7B6vfWTJaXa+J6EQofd2a/KtK?=
 =?us-ascii?Q?Z3QezeYidXyDYokS4axK12jj/j2dO3kXsc0r8EmVzhvu8BphtwZa6QoWjd0Q?=
 =?us-ascii?Q?dqjPq+YEjBJSwrFj/pRwBGe8wwp3/wZFYAPCeswDxF1voZiywSBGHb9JIOFP?=
 =?us-ascii?Q?21TNaRtFsdE/J7t78islb4+91bj1HshVCdmw0r3f2yQ4vjvjRCJhj9yPVpTs?=
 =?us-ascii?Q?EiloK1ZR1mDfotQEs25eIcgEQLWBumztR5AY9Oq8EoQbQYf/0K+nDtpqc/uM?=
 =?us-ascii?Q?J78r3Wc/Ws24JpMiTg6fDIu0u180gMZQ3t98wiUe0PtyeTewH2+JKGT8IGt0?=
 =?us-ascii?Q?ZooIX26k+/zub2Prf0b9tMkMluvEneilG5iICIxMBPnjpofPWLUvlvkvJ3dz?=
 =?us-ascii?Q?WpIBVfaJMJdwr6Oix14qMgSWL+fA/THG2M81OFxPSnxbq7QVHAlxl+5cQspz?=
 =?us-ascii?Q?ddtU9TQeLQZxUeuWNlaLko8G+P2ud3RlMlzWk7xFbFD9TBeppvNjuJkgQk5S?=
 =?us-ascii?Q?1CBEEBmXn3iTo9HQO/lacHHXKM//Xd3SENvjUfZcJLHVI+V5Ibd+AJpSGH7W?=
 =?us-ascii?Q?KVhv9c+awV5aSmXJvLkH99nMylBD2muE4ltTTvy/grebnWl3JsdXASJrPplj?=
 =?us-ascii?Q?Jsm9qXs0aNFf7cbJa1Nd5RG6m3zFknzMLRJ5FIA+TItgQSmD/bLhQ5F7JnSy?=
 =?us-ascii?Q?kEtnMyTM/o9Epxy1kfBDTD4ZXL1nY0Zsh8IBOLriouXzdaNKgt7wjouqJB5n?=
 =?us-ascii?Q?pRae84ux7QMNog1LMS9vxzTKuwJsQ15Qf9/JB6Hm8J3zAjSfkjRf3reX1x+w?=
 =?us-ascii?Q?OVJTI/iXCzJ0Q0kuRLPCnWGQOGwkOu7f0zcj+Ul3PKnR1rnLre190q9I6Fi+?=
 =?us-ascii?Q?cgdj5mydA8T2L6HsSgkc+AVVDwCiIDn+bJKLBZX6eH86obUpRr3u+/465vpu?=
 =?us-ascii?Q?QN0vLvnmEn/3pR9ZR/7m21acg/4HeBvky2BbpQNgRxRYNTfSxz0xURJ7CMdr?=
 =?us-ascii?Q?XpzLujT50szSvlWC7Q2FyhvE8Zbhv8GWuvreA8ZM7KBfXXSgOinlk8rAqlvE?=
 =?us-ascii?Q?z1DBepNLuA9Mziii6v7YvojThVu8zZnzW4mRjgjH3/d94INwectrA/IkQ4JK?=
 =?us-ascii?Q?Z6GQ/TmdwTb6UisPYoqe4CDF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71df2aa-7f57-4904-5638-08d937e70794
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 14:39:25.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArWsNaYTfPnLKn0fy5TY87sLvyAOuamcg9xafl7dhacuFEVBPI5qWygmZdOnvuxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 11:59:14PM -0500, Bob Pearson wrote:

> It took a few hours but I finally managed to get rid of the merge
> commits in the rxe MW PR. It's back out there at github. I lost the
> name change Jason had made when I deleted and reforked my repo. I
> remade the update kernel headers commit without the ??. It still
> passes all the screening tests.

You should never have to delete and refork with git.

Force push fixes all mistakes.

The sequence to fix your situation is

1) Starting at the bad branch merge to latest rdma-core
2) Create a new branch on latest rdma-core
3) Use 'git cherry-pick' on each non-merge commit from the
   bad branch
4) Diff the bad/good branch to make sure nothing got missed in the
   merges
5) Reset the bad branch to the new branch's commit ID.
6) Force push the fixed branch to github.

In future use 'git rebase' instead of 'git merge'

Jason

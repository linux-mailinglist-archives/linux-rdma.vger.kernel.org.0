Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8C3B44DC
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhFYNy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 09:54:29 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:61566
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229700AbhFYNy2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 09:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfCRUYc0/9KGnFAPjrjxlF4QYlFvPCNEUddi4wp1IW4i3c8OeHwGLiWhjLH2jnwroHqU9xLrMykc+frSSMy0lsr7WeHW0mO8QzZtsxlEENbpO4rSwiF7Sg3e2zmR/OnFl+x6E5ulWA6pbRLROHhAFxrvoygrwpAwtTxIXlz3asJkWc4lalSjTZW5cET9YW3jbAZGjHVsAdPAsLjKcECNZu06bp7MzvVqscQy9kifgdcW8GtHji/6LFeF6e4v3szXTqcSdAjvNQgrrKT8dsNSdtTD6Hccu4YcsyWCmCdkGx5YiqrEAJ4aSWOgFWgizRyyQQNT/ts0pLHhhAsIxESNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pc3+YgKJimDVL1dk2Wbr3hUgnepfxYv2XfOOaMOqzc=;
 b=ImVkGKn2DcitoJvyIcXavWOzmQQTyTo4Nggqp0Y9pJMk11c+Lb/pL9hlcAReQ9AGo1zovNCwfWs4TxgX956LiuqhmTsbpppzRugpgOlx/Tt4vz1gdTv3ryE7RxImAGj/vc+B0ZTrUn8xFsrlmVmAuHYdJQ56SnFjajsBPTIMRi0AMHNmp/hWjSs2da7trFM+qbPsHlKBEtjruQtMEVdbKDZh623V6c574HhqRBK+8mxSX/GtyBkoJ/pE7TzrGlEwKSRQhchq/qNwiLY0t43VsQUmzJLwkaPFRf/foIH6Sfi8M4BjsjLANB8biG/hcSyo7NWQ3ogWVen9iKZ9iS1BaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pc3+YgKJimDVL1dk2Wbr3hUgnepfxYv2XfOOaMOqzc=;
 b=CkEyOdlUwEa12woSPZ/FVkU/zczqITjWiAxsXUPiRzSpHbYASikW64fuShrZgSZw5XmWx9eZuZEAOIkCEg/ruyOTSKDb8zHRQVFUZtRXu62g6ZkxpHvRrIivUVcxXA1dYAxPVNTW4QGDI9rU1VZSh9QVGbkrp1vjSGOzlXVThifKc5BNj5rd5JT3AGzjgQKMAc6276pJIgbTkOxSkcsG66NDOywQekGPeKlAcCX+NrEa7f7mDCG9zxOAR0Jvf6LG5At8DjCEqgdrjKesGAprxfzh3rX5ywVphsRv80KJ3xVPK+eDnc3eADzfivlZ8+wMLCyeSzDCHC7CxYmpUbkRcA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 13:52:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 13:52:06 +0000
Date:   Fri, 25 Jun 2021 10:52:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next v2 0/2] Fix RMW to bit-fields and remove one
 superfluous ib_modify_qp
Message-ID: <20210625135205.GA2991332@nvidia.com>
References: <1624369197-24578-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624369197-24578-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Fri, 25 Jun 2021 13:52:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwmFZ-00CYC7-5A; Fri, 25 Jun 2021 10:52:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08e2658d-8102-48fe-36f1-08d937e06b21
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255B25D928CE2CA35D9EDB3C2069@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bB/6H9qpufZk4RikzcUBPnHLP62h8Hj7f6AmctYwOa+yoeiMVvONWeUC5NeUjEIrHzEgJc6eTGe508sYvJtphUzSb5oXBn/F/vs1FLG3HSPrVaD3sfPEQxx4EX5thbTQqP/CG/n9ubgZZ+OOp2+ZRZQV6UOjoYGa+HhhZWg4OoN231msDDmcYRagQ5oavObLUNICC7/zMscMgCXQyZRR8YRtW0VYl9f13yf9gewYu9vAEbGUJKpg9oYMj4/CpF8g1aN5MXboS555U+szT24NG7X360A0OXNWcE8roz+92dKSXckQFpGU381oDh3Av0+trWa2iMVFuIb018mZK6inhUIfSyYtSJ0glv6KAExJp0HDKkksc9RfFLGEv0Gcw8NLqzFGlQbYEodoKRxQswq6W8r2rNZztNbpQyj0ZCT+bTv4odbw58Tpe8fX1+OLdPOpA184FSOZfC4zd3xB4kJVEZcXILUoepqZOlkKGsVfYRgD5Ie/HD3KJNoX6YgU1BThnZqORtMlthDxDx8I9tWPktv67flrQhghOcRTOxGK5bn4h2SzGyWOq4LuvqL4SoVJD1mAEsiiZinsSbz9+AqfDDugd0MKn/5a7AU64PswGLpZHIDCKqRuonKvW9RDzdwOznw2bAoDkJxD1GVNDThuqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(1076003)(8676002)(36756003)(2616005)(6916009)(8936002)(4326008)(107886003)(426003)(2906002)(54906003)(38100700002)(66574015)(33656002)(26005)(186003)(83380400001)(4744005)(86362001)(9786002)(66946007)(5660300002)(66476007)(478600001)(316002)(9746002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Y0QWhmUVkxV1RVa0JLSnBlQWQveStxT1RvTm5LdUxtVC82Y2JBVkxYN0d6?=
 =?utf-8?B?Skl0dkpsY05NbTRCMjJsYWdmOTF2TWI3OXVreHJlYURJelZzcnJvTDVTajlL?=
 =?utf-8?B?TGYzTy9xWThtQThSSVJJTE5nYzllMzcyVlgydTZFOVE0YVg4N3N4VUFrbW1I?=
 =?utf-8?B?VWhDNTJNdmlIT3BMTG5XOXMra01hbWJmQ1JZeUtBa0QxcGlsZ01MVTR3YkZN?=
 =?utf-8?B?aHozWTJJZTBDNE5CZ3JZTlkrNEVNNEllRklMK2NzVitmK3JkdUM5YlNjSmto?=
 =?utf-8?B?cWZNekFBWmdUa0dnd3JiV0REWnpobEo3M2cydHNEQ01iVzNNcW05dVhJUTUw?=
 =?utf-8?B?c0t6SXVUdVBJcUhKVU9WbkM2bTkrTjdkNjBQaFlsTHU5YkkvQ05udi9IMWI3?=
 =?utf-8?B?ZlFxV2NzNXh4dUhyMVA0SEpKT2h0WDBRbG5Cd1RHcUkvYlRWR2hvYlNRWTlt?=
 =?utf-8?B?TDF2dG5KNFllbnpMb2tYcnF0cWxGVFZyV0tzN3N0SGVjeVRWQVYyYnZsMlVG?=
 =?utf-8?B?Q1dLTlRDWUk1d2E4WStIMmlZbHJycmM0UElkOUh3aTM0OEVoWjI2anRvMkxG?=
 =?utf-8?B?dUJjcUxpWFlUWmJkYVI5Y1MrNWdxSE9FME1MNU1RVkxGRHRzaWhBUCtTcUN3?=
 =?utf-8?B?dmJKNVRCSHZTOUcyZmZyT2cvcWZ6eWFIU2IzK0hMUGx6MS8rSHhVTmR4Z1Ji?=
 =?utf-8?B?RWtRWXFjd3EyQi81UjZjQ01YWXlOY1o4RWtXYW1ESHdsQXA1NExseVNjQlQ3?=
 =?utf-8?B?WVRLVzNlMDloemNNNGRBNk0xYWpFT2M2OWIzdjFqY0NIK2JuRGp0d0syNlBV?=
 =?utf-8?B?NGxIamtOR0t2RE84Y1A3eEloaittR0lCbTJZZnhaTFJ3WlVaSHhTZVd5MTVi?=
 =?utf-8?B?MDMyMkdPSWJweTlkV2JWcmdmZTBKYktSRmRGVjkvV0I2aXFtaTM1YkdMdnA0?=
 =?utf-8?B?UGFKWjd4eGI3K2E4dThmT0VZYzJWTmg2cytIM09JQ2x3K3VyYWxqS2pJaVA5?=
 =?utf-8?B?TWRSQlBZRlBUV3c1RWJjZWxtNUd3UEc5dFBoUzcxb0U4UXFER0ttUUg3bG5J?=
 =?utf-8?B?dE9pMlYvenUwYTJ2RGFMK0Y2NU5GTndjR3ZJS1pMTUlPTWFlV2JQNkdkaFE5?=
 =?utf-8?B?eGF4VGQxWVM1ZitnL0trT1ZmZno2eFdOb1dTbldoZVpubW03cFZUOHZHbUFR?=
 =?utf-8?B?R1BmT2h2Q2hnYmZrbitBdG9TZ0ExYmRVT2FLbEcrNjFxYXlFYno0WDYzbjZN?=
 =?utf-8?B?SXRoOW9EdmxaMnRMTkhBMEF0Qzd0SlU2K2hBTHMzZHhtaGVTSFp2VWlSTWxr?=
 =?utf-8?B?Q2d6dGpZZkliNi90b1grQy9idk1DcHpSS25rY3JUTmw5Ym5zdmZFOXFjYTBW?=
 =?utf-8?B?SjFMV3RyUlN3cSsrK21uT1JsM1FuRm5iTUtOaU5xRzE1VUYrM3NrM2wvMW5M?=
 =?utf-8?B?QXZiUHk4QTl2R0o0bkI4WHUyMGdybmlNdU5oYkV3M2w4enE5ZFVUcXlNc043?=
 =?utf-8?B?T1drZXRGWEF3Q1FTcktTV1pMbWxMeUU2d3psWUcrQTFVRDZiVTZOT09TMDEy?=
 =?utf-8?B?RFJ2NzRmMy9PU3U3b2FwMWVpdVVRZUdZcWxPdmpiT2lPRnZnWDU4SzQwWXlk?=
 =?utf-8?B?Rm5udS9xTFFPU2FkaDBEbDVaaWRaQWwvQXJCN3N3cGFxdlVJK2NhU2g1WlJk?=
 =?utf-8?B?djhlK1BpeXpkY2xtM1c0RkliZWNUcXZUdlJwWUh0KzRYc3h2RTlaa2MvNXFB?=
 =?utf-8?Q?ocekczharGZsITL5vgE2V1i5R7ATijACIrKiUW9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e2658d-8102-48fe-36f1-08d937e06b21
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 13:52:06.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiRT+3BcIOlFhbF2A0uUIyFUeR4DZNRGWleTJP4t5PG41+87HIn5ApzVxBftiTGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 03:39:55PM +0200, Håkon Bugge wrote:
> This series removes one superfluous ib_modify_qp() when a connected QP
> is created through rdma_create_qp(). This commit removes a call to
> rdma_init_qp_attr() for connected QPs without holding the qp_mutex.
> 
> The second commit tightens the access to bit-fields and synchronizes
> the access to them by means of mutex exclusion.
> 
> v1 -> v2:
>    * Added mutex protection in cma_resolve_iboe_route() for
>      timeout/timeout_set in commit ("RDMA/cma: Protect RMW with
>      qp_mutex")
> 
> Håkon Bugge (2):
>   RDMA/cma: Remove unnecessary INIT->INIT transition
>   RDMA/cma: Protect RMW with qp_mutex

Applied to for-next, thanks

Jason

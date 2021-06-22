Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590873B0B2A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhFVRLx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 13:11:53 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:29249
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230076AbhFVRLx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 13:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdKkB7Z7wfONpHXxGW66msbxAxhx4eK7/DIviA0Redsg4FKD332hLOXFrkRDbUDRz5zE5//dMa38oOHa1wfIOXYSGOIoNDuRUG4cpkYdzNch+B0ms/YXFGe1vpaQoyZ1mpaHfNPhiqtbAfVtugrA7LTp9OjVI6LIqeM6avY4scbZtAF5jf7nFatZW2RFcBi3QAmBExTNk/oJ/MnHaETKKJo4Xkpsm+QTyB0vfsUrZaZypnvFu3U2d2McgX+GR943YgMjd+4lZIkY7uuPh1GUAweYFjflEZct/B22SkE6uOuj3keNCe0JcweHS8FcYNlxXYA+2nh6twrW0jEd3Wd6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJiImV3UaEqqqCFFaOmIjHlmxp1kabmyVSy+GTs2BzA=;
 b=LYUyfRBws4rUEYN02i5VhMIQ1v0lHTsX+YYXphZ+uPH95wdtGb+j0LEnqfOOe2MQo/29wllUYOCFYWeXVqYJ2QcYU89YAZ2FEhjVnhepSW5UBnXnLKO+tyMaBj73GBIcoRO/UFUjJ4bRhdIOSzPxv6FC4tAe+ggHpni1P3z97JA8t72oYo877gKVdYEjrkwPIPheLTJdap+2eShUG2qI6ZgQ4S0JlpBOjLL362alNMFbzpeGwW92pq2MF40GANy08mFmTmfqvquCngXj2LAaroQMPbGWuE+dXohCUssbxS51knbf8M39nvkhht4aNAzN5jzWLpMB3VWNiVF/CSotcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJiImV3UaEqqqCFFaOmIjHlmxp1kabmyVSy+GTs2BzA=;
 b=ZDkU/ugxuP8M9VRsoIBtOZBzVFJVCduLGebcxPr5/FXoLqekyvnsQz8QGB/lJVTCTO2icSy0a46jzJGVfzu9FcnPJ6ke6L5/Ce4QE1AopntdNfcrgL9p/OFS+iJDOQDCHEzxPy4R3ur6kp4ceX67zdcaFvDF9+5qfA9UuMJceNJ+UKoOlln/RIZ5jExKgNQnln/9cgiLkJhAtmYq+uuKFl8AoSCxzcNzedoL+k3SEjf1Gk9VokkG+ykmQJs4gyD1aY4BaVYLMNsLc8xTpDXOWjWGqutdX3R99GnJ6cn0qskYakqbStc6m0IktZrj7kL7hyhE/6kCTZvA8VxJJEN+ZA==
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 17:09:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 17:09:35 +0000
Date:   Tue, 22 Jun 2021 14:09:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Use flexible array for mad data
Message-ID: <20210622170933.GA2449789@nvidia.com>
References: <20210616202615.1247242-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616202615.1247242-1-keescook@chromium.org>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Tue, 22 Jun 2021 17:09:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvju1-00AHJF-Q0; Tue, 22 Jun 2021 14:09:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17838333-05dc-4892-03bb-08d935a08288
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269554D482175DA80FCDC65C2099@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k2+xCQBjBm5G7m/ZJu0ZZr1NLHOLg+bB6cW5tMbJdiybD8/rU/9SMjV6/Pet8U8Q0HkpTguHa1DxKQ2m5D88qNorlCRlh6IAt6ShNEvcz8fRnDHMgwVbequpG5i0fNCxY0oVMF08af8qYH0UorLoA6WVTSCMup4TVxtCqBmALP7R7JSISos+o4fZ5h6f6dH/1PSPX5wNNFSFTan1Qzr9LrQL1qAugn9HJ1/F/j3fU/13BkSlFR2CsYqgUl/ge9SfYVnSxXJctZSyP1vfL+j41h9BEXZtsxfrQIAqmZVetsdWqNInaVDPTe012FIckBRD18t8zTjZoMVYEqHduxQNNroBGpNJojkH6PWrgeUAStQDrAmPbkLJsrOC+AuP/LhjM37ptJrIh8Kdlo9etPXH1DmGLUpbBdch5quJ1fWh0K58AONY9CcShQaEsVppBHHH8yFi1ZQIPgferEuoW581lTl2I6dFp/sjCZ1ee7mK9mAQQ8bibex2Hdjp5QrbWRHweGTAXA6byHHubbB3d48kukdBZKpq71IB4GRhu/I6z/rvKw341OzdcFzngIaF4xlwCAj9p4WWCSeunM7E2ftmHSha/PLlbVwXzHFozU179Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(8676002)(86362001)(316002)(33656002)(8936002)(6916009)(9786002)(38100700002)(36756003)(2616005)(426003)(4326008)(9746002)(4744005)(2906002)(5660300002)(66946007)(186003)(83380400001)(66476007)(66556008)(1076003)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lROuH/FSwB4KgmJtcts4SwqFHAhZ0eVy8gKofPlpEl4Z7VIn7iijUYj1u7oT?=
 =?us-ascii?Q?suRPRZgsEdCAJC/aRGW5hE/1vDGlGHXZJTswnwXwuJiD621C0KrHU/nSJjGx?=
 =?us-ascii?Q?uhioxY6bDsLF+w0qfPmGJQDHbybvAq9V050js2azbrfQCas7Lebb3Q84oEZR?=
 =?us-ascii?Q?x8UZONhj73Kk6L3+jviQ5pOcb1/WTSsbLOdusYt8jTyJcAYqWxQYrUvhx2D9?=
 =?us-ascii?Q?SyN9sX328AjkgcGDTLHyAH8QOmIuYpP7+j0QhxupqxAArvFa6wNe294llEcL?=
 =?us-ascii?Q?y6FHFevryRnr1pfmfgm96YVNMFeQ6o2K2CZEbmM5a0CdwwF3MdCSaCa8WzVx?=
 =?us-ascii?Q?AHmU7/88SPr7tS6I4HG0cR+YQAzQWhzqFkFzWJcNuLyD9jtT+kO0ARfMf3mg?=
 =?us-ascii?Q?+c4Xq883uY/IQDKrmsVJqmAWuUhrULZ7xU1V2YirEjN4PrBTrjAJmugQeuvN?=
 =?us-ascii?Q?uwg3wN5DNB6VISa6GUXrSx5mhJ/wGMJNDhLgZDZdQ/ZBLweJjUZLDKF5AGO+?=
 =?us-ascii?Q?s/oad3i4WJeX01TjsN2mN027UAiCIWg0dpKJBcUlbIA80rB4jeJlhKn/Yssm?=
 =?us-ascii?Q?8Rl6QNWhx1AbFmpQPJnFFoE+6lJZRHyoa+kj4Wt0yQLyd2CTImXQWeIy8Er5?=
 =?us-ascii?Q?U0TfFLNzys74/ybkLV7UeUMrZeevd+OXyJESp0E2MbzAfUeeScgJ5V/kQ5uO?=
 =?us-ascii?Q?ZJfRsp8WzZCP/FGHLLUje8zjFDI47RTJuqdbNslD6l82Iqo3HMLY+MaTLYXE?=
 =?us-ascii?Q?r1nIwCqWUPYIEC8dV36DZzHUCRBc5VVrLYkSJgKw3iHhIDJFCpGhfimNKxHq?=
 =?us-ascii?Q?WuHFkbMuU46/woCiNLhA325CNYweO0sT7YupMb90t1MebjuHq1g5k+1NcaBc?=
 =?us-ascii?Q?yiw8vKp5rHIaAIWU1sGIg+dgRh6eGrLdHLIwymMUIF0YDyQmMk07qzxOoYdy?=
 =?us-ascii?Q?wKWMcJPA/3v1h7293p2e4joHenYdCUXjjesattWwAiNBJvrIFVBBpZmhR4A2?=
 =?us-ascii?Q?gT17k1T3dLi54JouOb5dWTyVcMTdx3pgxS4uMUpGvUDMMCdrArjYhlHgzUjR?=
 =?us-ascii?Q?gcURncM2EDS6oMBUBsTsUbYRi3ik702R7Yo1uNSas7KfyN21jy2OB3O+Z5Gj?=
 =?us-ascii?Q?V+P0Y7TEBMU6xClebg+uec9IvJnfOEbAM48M4gyJCN7J2Wmtd+z0Kvrn1ppa?=
 =?us-ascii?Q?ywQTxg7D6hj9LY3m/gsnGJxIvnizrFXvxy+NBF0xeuwzBmK1Vkt/SmsB6XRj?=
 =?us-ascii?Q?BNX8Sb4QRUi552/ssywn3Xjv/qlBlu1zhZ/pfKYkh2fdvpkRDE/FGKbDmg3+?=
 =?us-ascii?Q?gq0wC1q50ZHyn5b0MQyuSsEd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17838333-05dc-4892-03bb-08d935a08288
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 17:09:35.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRtsyNplm3wrdNbbN5T4pu7xuQkC51S4mpbMPtqzAAZUMz6JstFPWDMOucvRlipc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 01:26:15PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally read across neighboring array fields.
> 
> Without a flexible array, this looks like an attempt to perform a
> memcpy() read beyond the end of the packet->mad.data array:
> 
> drivers/infiniband/core/user_mad.c:
> 	memcpy(packet->msg->mad, packet->mad.data, IB_MGMT_MAD_HDR);
> 
> Switch from [0] to [] to use the appropriately handled type for trailing
> bytes.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/rdma/ib_user_mad.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

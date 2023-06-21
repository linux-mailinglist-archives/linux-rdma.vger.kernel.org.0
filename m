Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77A738C73
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjFUQ6a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFUQ63 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 12:58:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C9E9
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 09:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfckUAn6BARSPkK4WyuBMb4JU8jyPlxQ6ok+X2j/5NBK1LfQn52f49cgI7VpEELzoTjyhXujb5wdvuu4ou7zYnalwOQpwuj/Wg7mq4PJsk5KyuIO00wneM5wpOaedPBNEYK6N+GBvSga3o6IYUd8FqLa2xQc6rEeQVAgMxk/MwamimTSEcx9vygGYMTSQuIVzCGpAWi2i9SoGL74YhCESy5yVSL6MKZblqCAkLZMCuACA9OBPJu9Gmw25kJ5k4JABu2x4gXO8hXyZoOp94zX0pwLf/TEil1VHpCDMRRox6KsVsdfyVRNHj0mbGawvX6XakG+nL4sIP9BuiOV0rNTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdyZyEzzCdQqAxXHBrOMgrwXnqCNa/KuCerSCEUVY70=;
 b=CpNyS94+5AixNqSNRxoKMEPr6+aFztbku6Sj52OEkAQzA0vCt81DOouIhKEAQqgq1s3WCSD5XJTNmvHQKBVgqcmXR0rtEWnLFvH/dXEoi4IdYMysHgTsVGBpbQeDrjXw+0LBoWHYuH2Zd53zHNLuIIBXb+XMb6bTFUDH4664XWGen5DsJKjpQKmEKQGmitO/FhCKHVzJPTY0Iryp1cmZYQ/AsxCGrwFhweyOGYnyGk3JczZIL9KmNbV35aCSSncbQGXNDGDiGvRBqeu1j5jJlM94Tr88gksp77d7uJZyw0dvBkS7RWchKYYfEcFkT2vbOo2+HMmVBAxFB60zQGJPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdyZyEzzCdQqAxXHBrOMgrwXnqCNa/KuCerSCEUVY70=;
 b=L897dOV5ASQIQLOZdX2mzsIOFu/KjZZhQo2E5MuYkl8hrV08PUeEsA33JJ1tUAUJQtccexoeD3XqwJ0TtM6Wq/HJGjDXuqBZoutKAG2h6zDDpHc5cFfNgH4QD2BVIcFTwxj5QxY5vZJmoY3la6YK+XT1BARMzhLqLZt1URYHDLpzwvJU6cR/JiwcmFtpiEmjJQBPNdzIhoBid1M9oWcdOoZKkXNJy6Dv+V3EgugPMYQUKJZkBtxL1QohAwJvHXJmSDVV5NTAxCOviZ3YQq3Tk9RAwE/e/JHtSpR0XDHxXZcHxgwvFm3Km5jb9NXjtfbYoZXL+6IcZY+E/IEGbEjtsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:58:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 16:58:25 +0000
Date:   Wed, 21 Jun 2023 13:58:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v6 for-next 0/7] RDMA/bnxt_re: driver update for
 supporting low latency push
Message-ID: <ZJMsLUfPFUZ97hfq@nvidia.com>
References: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 471a20b1-922d-4046-1dde-08db7278ba81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTlaw2+8IEi43a4CYhFLx+UxMe1JpNnSivwVncE+PH22nz0rutujIeZNEg7LbGQEdjP40FNAPqsJ46nAyUVjabdohACrek7B1/bX0bkH/HHF9gcxR1+iTjnpSpd+q5n5gvAmXxKjxUuYjzVdJuUsNVSLLUWEji24/PbBFKKtSAv0TR0PiKI1qk3cxJz7nfPRvqBJ/wC1l+695zeVmmfCWnxsQhTS2Y7dLumgG6wXhU77lx8b7nWlwnfAEnczVeOD9/y32nn4h4fGs7frkJEplTLal7SdU84uAIpwIFtThUtS1zjOxJVXSw+hVtZl8xR9ybYaeAog1wTfdWJmivhT369uoM9c8foSBe1joKmglsGJo9VKM+BRFYiv60RHo9cM2tHGqp2R3E9r3Wtr39nR33xnIXFsuC3g6xVhAxBXUfMrhcVIKCm6xR0IqQ5tCeNuWMzQoO9kEKK54S/J/eqFEKpToqaAbku85MwWRWoIqfgMTS2IBLIuyPWYMARbj3/gR9Cwb0zCPOtjmRdAKIzBFn3xDJBh1gHWuJNDsV5NWpuhLsUvZXFSY5pwFkz0po0EbkbtA3eyWHA/2HiUf95d8dcfAG/hT43r3wJ7g0z9l1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(6486002)(478600001)(6666004)(83380400001)(2616005)(86362001)(36756003)(4744005)(2906002)(66946007)(186003)(6512007)(6506007)(26005)(966005)(38100700002)(316002)(66476007)(6916009)(4326008)(41300700001)(66556008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDhR/D3dH3PmqmA2m5HtU/mUaF/gkHBzFP6NNWlP0SAypkMgMQ960H5yXp/L?=
 =?us-ascii?Q?AULedTwRAAOo+RhySZH5yZiZH14pvYOTLfqVjcZoOqk2f8fcjLweygacJX+G?=
 =?us-ascii?Q?8nxdLYzgHWf86v8h8/Dp3RBFpDYgh7rfAXLRubRsSD0K6Ava9+44bh/w/35p?=
 =?us-ascii?Q?J9vSCG3XoGkaL7pIfGbKQhiCjhiyfFbi+ex5J+gCMVslCg6KiKUjTCmDCoKQ?=
 =?us-ascii?Q?nzdQ6iUx/kY/+ti42gTutnuWVAJle6R3zIjAViztH1MVykB8YflwA6jtTPuS?=
 =?us-ascii?Q?/TKjQjjkVpHRSlouyVj4roBL12U2XF2PHDCI7G6U5F8k/gzu53rbO2me7Jvf?=
 =?us-ascii?Q?HaDaKcwyGF4XICOl3zdS//HP4GJBfzf35dSdp4W5k52ktHI12NVfNh5hofkG?=
 =?us-ascii?Q?ZTcPweZG21rowYJlYls4kZZXOHoxDDTjRvXuJUXQ/9J8Z/7+zNlKmA3VAIjD?=
 =?us-ascii?Q?Dn6yCRe12qoidqrCT7ZzTSEUNDsBpQDCxfESeUCHDNsskAxXMvS/7XLyr1XY?=
 =?us-ascii?Q?1TG7OWn2obcnmENbow2V+6GwEZLts209LvDwHrSbqhAsCUEf+lis9Y71MTQy?=
 =?us-ascii?Q?Hg+di591w4vudvdU03GsATGzoduABLv0sCxJ6hh5JzQny/v96zTlYO6tjFp1?=
 =?us-ascii?Q?R/EDURKnL0huIcrcP5Yu2/YEC/Xl2MujqzHcDMmlH4pNX6nlcZRyBEyJZXWN?=
 =?us-ascii?Q?d9tfNeRx9csqVVBHlhBwv1p0t7FOP8hZ/QRvh5FEt7Vr/vLXPupSkKl8ILBu?=
 =?us-ascii?Q?QFLGlIe8hO9C0/hNzuynHXPvwY+2Z50xj1vc3ibolxz7PNUOD5nCj9YM3gMI?=
 =?us-ascii?Q?6i9wYZRi+sLr4czfwF40fMyiGEe8klBBTCI2qxot5mYYYNG7BzqY50IfBmfz?=
 =?us-ascii?Q?IXx4yuAQKNntlbxa4409v03Kg2BngSMbrereuTYWG91S7ZorfkWc1InXe/sJ?=
 =?us-ascii?Q?Bi0FMKK4jEoOlHmxgj9bLD9ckmLF0GlY2WcanmOokqngcJeOxTKqRV6m4yO/?=
 =?us-ascii?Q?DQZ/C7qdcCCUHKxdHt068J8a7yE1ciP+JsgjmtX/i6P7nLZCML0/GqfeU+6N?=
 =?us-ascii?Q?/9E27N1vSo96bf+htLb5nhcQcamRkUy69ybvBVN8HAmBCnQWlCPyjot8y5su?=
 =?us-ascii?Q?caUtk4pbT/VRr5bQ3rjdj91ImqVUDgQv9urShu0/3XGS6EIwBPN8v3L1hViB?=
 =?us-ascii?Q?4CBvFsHrEYgvQyNV+Q2MAWeOEBz4mU4ilJxNzme2HX72dVv0QGCdZhOM+OUU?=
 =?us-ascii?Q?PgIbkodBXhqsUD7Z4GumX9HsYA/+N4SiMK5JC+/adT0u07sDVzuwUdnOGQM4?=
 =?us-ascii?Q?opLuIam0WT8X0dm3CQsrswnYtGVpnnpHyswpWRYNxJ3FWIIsq360FcYKT0LJ?=
 =?us-ascii?Q?9DoT1Ky6uWMBUyy5FVzjW3v7l7n+/6PUf7t+3PR/6LUTtrZnXsnOfAPww8iQ?=
 =?us-ascii?Q?g5V9S1TQ//OBP1HB/KNqpWdsTT0grx3799K4rjV5gbUp/YRHzy1hfuvICNg0?=
 =?us-ascii?Q?PfEw2dg1JXtH4uqreSo30QgCET5Vf4kx8+f0J+liJlr5m+EWO24PQz2P7ADA?=
 =?us-ascii?Q?td/UkCk1OLQ3fIaq/bol0U3ymA2VWsRGdu4du4El?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a20b1-922d-4046-1dde-08db7278ba81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:58:25.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTkLm8+v10PTuXmH9mL8PydcYh1qEt5KW709XjbrO0OjmQm6roJ0c4CBtKW6grV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 13, 2023 at 11:12:16AM -0700, Selvin Xavier wrote:
> The series aims to add support for Low latency push path in
> some of the bnxt devices. The low latency implementation is
> supported only for the user applications. Also, the code
> is modified to use  common mmap helper functions exported
> by IB core. 
> 
> User library changes are in the pull request
> https://github.com/linux-rdma/rdma-core/pull/1321
> 
> Please review and apply

It gets compile warnings:

../drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:322:18: warning: variable 'opcode' is uninitialized when used here [-Wuninitialized]
        crsqe->opcode = opcode;
                        ^~~~~~
../drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:288:11: note: initialize the variable 'opcode' to silence this warning
        u8 opcode;
                 ^
                  = '\0'

Jason

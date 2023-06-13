Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085B372E8D4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFMQwP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFMQwP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:52:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A6123
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvJznifgSJ+1VHjZecAGQACbIqbhRRO7KxxmoWhkpolr8GS19m+SZHg+cU4vT1C79rKUZTIIK7ceieV5S+otKz2Pg+NoXYiSggdFmIhvtzZaMq4ibUQ05QNAKGYFMzaAlUtl35QqNDwvGgAfA4t4heXXcBOXYfW8612w/N0Hq1uVLFyDWKPg2KjR5LhI57ZYMfJI9S/lcSH8bMRE7urjM1uWCx7GQGvFHwQKf9LmAQGkG8Yonhc7v9NVOHXJ3IVHbtdgNTHcy6KZhRNueFDAXP5xGnjbOvhvHdibmM9DIu/AD+WrDhkODbrx56vQPnIFmK1RsJhpAeVYBCJtZl+VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlCj0GAozp0s+R860eKlyFMgN/EU//CWSC4Zulyu+FM=;
 b=C116HORYtl31IS7RwydqnOOowwFqFmHqZx6/0IhLgDNnI6pXOJvyH95AU5j3x6NanJ2xwHSWFmHwaCAVWzMvURApDDr3n8lz2o9qyucV6nl/Fd45qQnRT51sN6yVNCerRj9Jj3LXai96PdVtQVjaF0hUqLtXwmJGrU8JnA3NAXslqRQsa1u4XjRedjyaQBWhtDvNoDnsX1cBkbGULP93tGGTxkR8YZvhu6ENK26ubBaN/5y6YyLcKMbFl+bPnCNnGgk4X3RD5D+2BnzJ1iRts5v8HiZuSUKMmeBWWomnQYsW3Eam+/LkOYScQMnACKhT0bjjufzkORKqkd05TWnq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlCj0GAozp0s+R860eKlyFMgN/EU//CWSC4Zulyu+FM=;
 b=k6HXbo0NXDNCJ7XQyIlZB78b9xf2Dr3H5RgemZ1PkQYTi3xwewD3zlgJLjSVtnFbrH0IOP5yhSEXIiqTa5NbUPe/ba2Ge86AcfzDdSheLvbYYuHu/uXL6EQlQqu1WzdQA72sGp1++sJxuERjVdNrIOBIvQH0LSuRWLYYW+saI9OJr6akJq88MFEWmJ1kU/qzZCdVQxWqGHa1nhtadGYeJdC0Zel2CkeG5DsvhQGPufWSzIsBRqLVE7Aw4sV8L8QLybpmcS5WEofthRjaLL1cxfKD7AYkGvMdTosoIqwR0UBkFUpvlLIrHsrIp7153onkbAjw3605R8UmT2bwRNPn7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 13 Jun
 2023 16:52:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:52:11 +0000
Date:   Tue, 13 Jun 2023 13:52:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Bug report in reg_user_mr in exe
Message-ID: <ZIieuVnhnGP8RGQw@nvidia.com>
References: <80328b20-9c5d-afe8-0ff4-a7eb05c8fb4f@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80328b20-9c5d-afe8-0ff4-a7eb05c8fb4f@gmail.com>
X-ClientProxiedBy: YQBP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa3211c-6c69-486d-5534-08db6c2e8854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjmdDstLO+K0N+BqeQaJjD1zKQOpXbOIKmt029/rODA5y5Im2Wgt0BqXnRgeJ6TVE/1UtX+/zduWdEO+Gl9ScRJtrPOtTroCmLj9Sl4SwL0VyNTnqLuI9xMlTA3e+bVADbNRlAB7kKgQMu86RcWzRiFXoLzagu1dvjKdddqLeKI4dUwXnhf+y0Lgv4qigVVrSdOfo5F9rq58P4zTxRSwPUIaA+sELmc6PA2muqjR5nNeZGcgSDB9XoScvANgJXZoPwZTX7pETx4Y4pALnmckyVBoaRUIXwXuQ5oW7e6XROfUMgamsQZO0ANAKwXbmrwCZ/KGI02u3bKtLFU+Do7HsWFXKyRdrI0sdEeeEZjAjrFKGeTgcrZLlNCwFM+WZAvaYKhR+uqU8K7eOiFXcKQT6cQscfu38htOWe+KJG9SXoaMZVNmb06NWfSU2N1vgQJzBY+QT9AjMgadP2VBzifKfj4mS+4FAI0sZGJRUbNwxMuFTW3auRG4r0Vafy+SDxXfUrjpZ7TSxo2Q8kPQnkL/aISZuSz/XAIzSAtYstZDQQUFYMSyvrmuRRI0xchicFFM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(478600001)(5660300002)(36756003)(8676002)(8936002)(316002)(66946007)(66556008)(4326008)(66476007)(6916009)(41300700001)(4744005)(38100700002)(2906002)(26005)(186003)(6512007)(86362001)(6486002)(2616005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psjIH4wSAH8FOY95q6dgXh8lSE46XjYXDSEesix2dbdpyvR5gvsu2o4Bbb0f?=
 =?us-ascii?Q?jJDs3m4eE+60deJlavZYPb/RnCHX4fo0SsiU7nhTob4xaJafLIupw+hQnHnl?=
 =?us-ascii?Q?VPLjD1S+Bx2b92PI5aHk6gESSx47aFLbIPrVDucqbrPDkEOq+Ns+/yMckkaM?=
 =?us-ascii?Q?lF6HI2psbn3lFe732Qz30ZNq1GuMS6oxChY1FHcw0OLN88bJlE/N61NoT0Xw?=
 =?us-ascii?Q?sJk+gseqmWGv5YNtB2hKvxI6Xex+NM/ke1pl15bF+5eP9YNAUZFhtpXsgUaV?=
 =?us-ascii?Q?6TrRMvVgavHNqVxWSablLlHGoadFQm735SRvBSmW2p3xOof/IJa8v4SN0DpW?=
 =?us-ascii?Q?+M2rD523gySLRxKA7JRn+4pUqWHxBzKJgSPhdQ+GK5UX/zPF+dqgMXMCGKwk?=
 =?us-ascii?Q?6/y1GzwIqPAcDK4uUEAWgu/v5oG91Z/9G1F15ogoqnmYTvN3Dw/Lj6CEPDfh?=
 =?us-ascii?Q?Skv+VvT9LzFzhQJ7wwiZSpFeNiyon2uoQ8PqK/3nY4OCnh9V+NXhmqJmzrGG?=
 =?us-ascii?Q?q0jcSHikretBrCULzMXZfDJeAjZr1MUN47G29Elo+0aiNdhBtQ/5x5S9Hsgy?=
 =?us-ascii?Q?MXzA6l63XjXW/BEHDmVCb2tjw6RhcYKhrUBHg+e4mrigzM23S7i0VYMasgGt?=
 =?us-ascii?Q?MmOPtbj1YfVBPbIzJnB4cEamjK5R7NrLN8BKMX44hojUiY2ooHhlGP5nKdAj?=
 =?us-ascii?Q?tRAs640vNxzQWp+4EF38do1p/CcULzdW6VARToXGjwN3+Ag87ax9/pXehopE?=
 =?us-ascii?Q?h5WWtgc3gKanc3XSdB6/yBvZuU0KRhSiHB6U6Lq7MwKs09Rb7TP0pxs40dpx?=
 =?us-ascii?Q?XsysBc5wF7p5SHg1HIl7fuCUEDSYpx826/mD4QFYq6KUuRTsk4ZEj+1qNBdk?=
 =?us-ascii?Q?2irrPuehivWKAfJLs8Hk6zBhd4tOFDTu3gmIqlvydN67Zv9rf3nGdX/AdzSN?=
 =?us-ascii?Q?xziXzBENuxb1rxNGaxWwJJpJWBSLjwHOjgP2GTfdkWfLdGL0Wgda8c9rWHwc?=
 =?us-ascii?Q?lcYliA3wPzbul3X37FoYq5ktxokieyc94rU3f7hus+akGXT/OVFO6DwZjWXI?=
 =?us-ascii?Q?QfMexlj4NtB0POxqEIZ+HyJ8SVQtYP0Lg2O2746TieX89HDe9r+HuY+qcIby?=
 =?us-ascii?Q?0JoAGrHIRMIX3xJG7Rtn4isfxFOJBOX2BRMofl0FkPDFS9Dx3Nnkh9C1gQjl?=
 =?us-ascii?Q?r9KUGReq4LhrN0/b8A60h3rv3gYTM2FBTU4SLfiew+qcrO9G3Hkf3iT7zkNq?=
 =?us-ascii?Q?d1IOZ3obnfSRigV93ev0T0OGfR4bRBknu2NfSO+Fk24Gn1wwAwAUvSct1FYf?=
 =?us-ascii?Q?rXV1AiKeGZPqCBl7wMTGnT+kpj3Wk4N654XWKccVn0fJd+b4TLf6gL7NhouH?=
 =?us-ascii?Q?ervuKgywd3Pz2M/qzBu1Nnrq8K/Mge8z/pbcB2c4p0psP+l/cXwlNSjUtlnI?=
 =?us-ascii?Q?VJ4t5cnIPXgGPf3ivveKOrYso5jp6T7nVid2x4Br2lPHrW7w18QjOWZK+Kak?=
 =?us-ascii?Q?yH+yXHszCqv8Rv/662cjrr3ODJQ8IrEcWvgDZWNTC4FSOFN6a17/l6fbPYFw?=
 =?us-ascii?Q?CPrRlJMZF9SExu49KIXIzIAMMUJ5xi+Qc0dhjP36?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa3211c-6c69-486d-5534-08db6c2e8854
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:52:11.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0/IfLWPc9EReW24dJ+ilyfrP5DsG/4iNGVcVE0JQZD4rlIv7Yb2etPYmoD7y43g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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

On Tue, Jun 13, 2023 at 11:26:55AM -0500, Bob Pearson wrote:
> Jason,
> 
> Recently the code in rxe_reg_user_mr was changed to check if the driver supported the
> access flags. Since the rxe driver does nothing about relaxed ordering. I assumed that the
> driver didn't support that option but it turns out that this breaks the perf tests which
> request relaxed ordering by default.

Sounds like rxe is checking the flags wrong, there is a set of
optional access flags that should be ignored by the driver.

Jason

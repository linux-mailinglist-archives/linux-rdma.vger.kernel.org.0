Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715A707198
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQTL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjEQTLw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 15:11:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7F5FDB;
        Wed, 17 May 2023 12:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byhDdITCoqK7TWO1xuxfxfAG4kCrh9yA9noTTWIQCKfUB/8mU5i7CAv8+nkUCz9QzFlk8YUN42ciQ826zOOrKZF7fuKTSs52E2ukPd1yGeK0pzlFiVj9Wu8ex6SOOeooOyFlKEPfCy6QMrqYxRxuIAsafI4gUMA0SjovB4ZBqVarflBPawNu8WeZ3X7i3DV+gAkvFAWk6b5Z9NJuQ0BwN9VEy/OA/AuzQy1Q5QYK+GK+v58XOrTsT6xjR5IuuI+5S32OX82y6Aaz9IZcmiUMjZf+5NCJxhXS3oD6XVTeaDFFvpJhIT4l7IagIERnOyYj61RFqKlAkiBaZhQRZcWu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPZYhfDpg5scw9FSi89yd9uRu8JsjSbM3EdGCdgUTT0=;
 b=elHBJ5D/U6yMMP2gwopiXnehnsz9SoYzxdKzl3WlD6ULiAsgxWfVovRK2bTzQ7fveP/059PN9DuVdRl1fLZanImTejwIGbZT0OLMTrVm8cITkKtTHUvTHNg74QX01QiTCH/S6U+nFQC8ATwWsbtrZiXNew5t3DzB5trr3a98vUhv3KaWQ000awaFfiN07xt+BMgRXuW04yuBXY8v3uDazUxS5PibXJu9G4IiBgcw9Cfv4PPAIO1+cC1Ea3vNcbOtF4l8TsmFxAZ7S4oK5XELa3nVqV4ffwAjr1Ap8LvpvMg5CzhLKnIQgxuwfmfGTqxLFr4+O4+q70x1yeItblBYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPZYhfDpg5scw9FSi89yd9uRu8JsjSbM3EdGCdgUTT0=;
 b=o7d+MTp2hui2qsKoGJuyTTY/ceOh8TMBvSdfgPZ39MY9NsKQlkWv+8qUPwR/0dsiDa1QC4sb5LSTKq7OFi0HkcySuWMEk9esJ6IuQqjmcGEx0ddbFSOs8xRJwImxEWc5C/VtVa8HhvWYNzeA7a04Folphodx19JQLe24aibhAPsoda8DJoS4kPC7GUgug2dinXerq7Kicp6gGYYDTM5LG8YVGIRbaIclnhrMmp7lA8n/p7GcKTBxWa0AZECjvMP1u4i4VdTK7OQXYRRBM/se4RwuvV2RLzJi2oTiED+Ab4A9SSOUb3zsIbX6mREtQqIDucrL0doC8NQD3swcWjkITQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 19:11:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:11:46 +0000
Date:   Wed, 17 May 2023 16:11:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] Bugfixes for HNS RoCE
Message-ID: <ZGUm8YPoyowIWGXY@nvidia.com>
References: <20230512092245.344442-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512092245.344442-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7708be5c-cf52-469a-3124-08db570a8ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0OUI8HXhiMW62LY9fZc/F0JTkvBN5rFU6TE+umF6HRSRKzYvwPC3TVxf8pbNerCN3NB+rrnFTC1z9/STgAD/yqPJb2Rm8VPMNZmw6B3RLwhw+/D7ffGJUwy2IRCUvCNS3T0sBgl6EZUAPWkeZh51sIFthIeAjMpTEaSqEwaXeo7DUDCIrSgnvxRY8GDh3l/E+SD7nHictwbYmqGVJur8MWTgSahW1Np095YKIR6z2SMlvmoTzLl0KGNytSqXcmROd6zfdYKska6WBQGrh5MWJFyvCeTVIqPPmMVyE0fIfI4I01GiVz98c5/yOmhJPC5wNP3+pGDwdY3PW1Ze1hWUUt4etQF0rSTyVeWvxu/uSScU16qiNwNFwGDM8tqHJTNUOo8evzxZKgcDIya2cOcUuJ8pXUvOfAcekF/cwHGOIhNI794ejPnjE7+B676BtGkS6aikXko8WMxvVRHuesIcwFFCT5l4tBEmAY680w6bRBQuDVO1cfbxkfkmY4LdeoB4BC/6pZcMXUwhNnyZLxsTAz7Fhg7esKuhEcd81NuEs70vJ+I6LpYXuyR8MoYvcUc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(83380400001)(6486002)(478600001)(2616005)(26005)(186003)(6506007)(6512007)(8936002)(5660300002)(8676002)(36756003)(41300700001)(6916009)(66556008)(4326008)(38100700002)(66476007)(2906002)(66946007)(86362001)(316002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KG0sndcRNoTZwQl0gMa6B+qtRxh1aXgziBeDpvCDgrQT2SsUJ0NS/IwFpFDW?=
 =?us-ascii?Q?f8ACyscPaeIJJo2RWSDOkAs2Grfop3H4iOTVcGT94OYODZiZVIHfZEl0gXTo?=
 =?us-ascii?Q?z+uAHQrK0A+I/ek4th73jkpuWseyez5RrFE1UeWZrZkwxCL6Iliq9pOMLeWV?=
 =?us-ascii?Q?0fxJ06FWTRbz4/K+Vhjf6jzRH+PDLgxKcoPRQPXsD5Scv0LPMxXV1vpVRrR3?=
 =?us-ascii?Q?H1GsN2WXyAKUkDR6j+HLu5fQzF+Aghq4ydtdvt7fOn/A/XwB1rLDqcl5Croj?=
 =?us-ascii?Q?OB78F0fFjMUkK9qREffaSFvwn4Q8RbkLupYRo7VMJ3WttUkfmcLsMvD6t87Z?=
 =?us-ascii?Q?fdI4z3Ost3+olDMB5MwChWdon1LfBJWZMMu2MD5ir0aP1hkD1amYy7AvcrjT?=
 =?us-ascii?Q?k4+KPVGjOkNRJJppvBCBV/kGqMtPMQD4Xf93XeXfzAaXXx6xT5mJa7k+7xRf?=
 =?us-ascii?Q?p3z+WYddaCKxhgxvfBFRn+wf3f2EHEvRu5+RnA7SRf3SqfZJ1BRmLAYpXqef?=
 =?us-ascii?Q?n8Mlbmcgdntjp5XZHFCy2WBM5aszXBayTEB7oBdnrxXx0VgSnLflepBnrUAh?=
 =?us-ascii?Q?ODQhIymiqQnFpX+QTFtp3t9tNOwENtDGgXTAbCfPDpVdoLT099Tc+e6aNi0f?=
 =?us-ascii?Q?T0eBxHcrGewKD9S118zrTCwBHyezqJvWuwQEymTy/nevbVztITTMArytoxaY?=
 =?us-ascii?Q?4aRrsapngRAuLcm6Z22s/V71CvlNImwI5uEAOpdFWGHloFlFdjgMX34Hv/Sa?=
 =?us-ascii?Q?W+Yn4ZZR5EQRdSDLKciXcRYLW1kcUYsfAoO/7rdaP6iRLziz2eHv4hUO90Oe?=
 =?us-ascii?Q?5nTzbrCnkmJ4ORb7St5yeFo5ZnHd8T1V2yQajaLHuf0D6h/4M5n+ii+Ks9g9?=
 =?us-ascii?Q?6Pq/4iriADbu6sWuoz6p70GTaiM03jUOFxJuesY3nTz1TmWsFG5pLC6WjbOa?=
 =?us-ascii?Q?tkCerNbTWMq6SPp0xrVYmeBJ8snrh2aI18jFjrrKTJNGe5k0yJSXvYGx9moy?=
 =?us-ascii?Q?h+CyrlM+yfRZa9WlPcLzKs7Psn++seADiJEnv+niHutd93/Sz43CedrjJ7Jk?=
 =?us-ascii?Q?iP2kUyJkfB5BC0RVlckVkC4l6VH6Rb6JFVwSWhVez8XzWEomdl+rYbcQ6ffS?=
 =?us-ascii?Q?/GGAPMaJtpZ1IXmqeJSJ/HMfaFjMiqWUwERGP59xBMfMwraIyvF1RscYJkxX?=
 =?us-ascii?Q?qZkjtJCcEPWUPJxNvnFbxQiy/6HZbaFJHYLO6cr0TBut/XEWPLyrKa2tbYXM?=
 =?us-ascii?Q?m0+rBs9LCjqAsEbph6p43dHDO5CIsGhs+jVI2x0UwSuUzRVNGhJYyyzmvGin?=
 =?us-ascii?Q?XacAfM8nyp4GTyAspzR7SFungCjyPJ3kJ4+KrghwtZh9foxAEVamawr9x/hl?=
 =?us-ascii?Q?+EqyVjCM5JQJILARv3aLIeS8f0GAWSZbZHqf+D+fqiYPcdgT2rzEi1t8Mwv9?=
 =?us-ascii?Q?wJcYQQvhS/YVJpEkV0y1K43Xr0Eg1jkEq93YppKWf7OBRQ8/fXSc/Ej+mx1u?=
 =?us-ascii?Q?zuurxYkIHqgExfnTTBGHJxTH7QKy8SsH/xzvN7fq6wntGgtspXMmczeSvBtj?=
 =?us-ascii?Q?aCCQOQTR9eU0n3PyKHVQvwnSQeXSvomfxZUttmkf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7708be5c-cf52-469a-3124-08db570a8ef3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:11:46.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/N4+EnhbqTvw0EiUPouhV6S81nX8eE8buPzOPiCVV0ApCR4oYfWKtjxK1Hw1JZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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

On Fri, May 12, 2023 at 05:22:42PM +0800, Junxian Huang wrote:
> 1.#1: The first patch fixes an error of queried timeout attr on HIP08.
> 
> 2.#2: The second patch checks and adjusts the BT page size to ensure
>       successful resource allocation.
> 
> 3.#3: The third patch modifies the value of long message loopback slice
>       to improve traffic balance.
> 
> Chengchang Tang (2):
>   RDMA/hns: Fix timeout attr in query qp for HIP08
>   RDMA/hns: Fix base address table allocation
> 
> Yangyang Li (1):
>   RDMA/hns: Modify the value of long message loopback slice

Applied to for-rc, thanks

Jason

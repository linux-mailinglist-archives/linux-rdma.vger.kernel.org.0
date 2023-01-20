Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED0675C5C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjATSCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATSCd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 13:02:33 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098F44A2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 10:02:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJaKqkCB5/Q3jCcIIa3rDx40b+1VszKlMjQHbWVozWAzmRU91sGfT17/MizMRFPzYXoKx2SB8dRaP6r88rIurmNzNpyaM4GK6ce1bLOKS0W3NCzk2lnZm+B97MFztCczosyTfb8DPYHGmZCxcX/+232SMTqxUdXFn5hZw0D3Z7kSUV04EOWff5WyXrz3h8/0Z6btcte9rCHV9hp6TgTO7ZqGtaBcd0zMriqCKEHBQ4iYH8kfTLWb1uXQI9YInhnj3J38/v6ayQD5YZtGLFBnAfIj/RpsF9Jz0aRl0xvhfkZbfDigSCzLZu0OniS6LX2KTO1b2wqoSXwYMQpaXkYf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdIoQADGUYZK4bieduhnXMw1zeAH3eEmK4/IIDbUCKs=;
 b=jH023zf9ORiLRfM9JlWk2huRM2uq6EAZXco8+EO4vnxKESoG5PE5pNgBIszLBTWriZqeiVGmm1qyZPDR32TIgY427891LVMQUJVEVk5GoorCf8kTZD1tHVKP4F5TX1qkqaJwJz65XcgWyn6Q2HhC+GTnodSAdIywcrLrWLD1J1Qci/ROH0Cm3MDVp+zMyUeoTp2OMqOs+gURYSx0xtCCtu+ei3kB3+bCaUje2x4r/J0u4ZTQ1id4NZw1ne73sbbAk3dUrk3o/yVx25bwMtl8xDew1ChO2uqboeY8GE8lM3cNz+QDfl76cZ7TzeKD68cL5u6OXZApycn/QydIKnYRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdIoQADGUYZK4bieduhnXMw1zeAH3eEmK4/IIDbUCKs=;
 b=hbtsWseE2LgOzjS+yUMue8n8khuIUU9FF1n57pIF9FDPt7KITAJl9B5mKnPj31lI51BXFikgXV1KXR1pYWodolvkmOywLIvCEVXp/NBfHf7h1ZjhBAuQBOuy5O7tHyM4BVxwPEutVsNfnVxvL1c4PQIktaXxKJxGt23S1XWkq/RXCbT7AloSpYVQzPZ/Hjt9my6FnI86srVxELcf9TL0MyRfuB3QcvXPd/pC+QVDl7Nki9834puhkjp17csqdAKr1/CBcWUn8ylqVND9gNS9aRv/LTjgd3aNdU/phyNu0Rz4y1W0L7oPpvVeDyS8X2JqNaa52i4+m5nGKLy/zX26nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 18:02:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 18:02:30 +0000
Date:   Fri, 20 Jan 2023 14:02:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <Y8rXNXhKlTU8/Fgx@nvidia.com>
References: <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
 <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
 <Y2uu4HfKADHiCzGx@nvidia.com>
 <MWHPR11MB002952D469591FEF43EBC6F6E9C29@MWHPR11MB0029.namprd11.prod.outlook.com>
 <Y8HwxFUb3/NWE1xE@nvidia.com>
 <MWHPR11MB0029A8CA81DAB3E79F393FC1E9C69@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0029A8CA81DAB3E79F393FC1E9C69@MWHPR11MB0029.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bc345d-2d23-434e-17e4-08dafb107f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95M7i4S79jQQCd5Bgq2V2cxriyBNYDLzjfz3yBZG7RFxOwSkBwedx4MBynZCJ5vI5GVRWZgny2mrVxd+R4j7yfkAcI7zDfffR8LAupFdyHjWfcPctNsFJtviKXbFURb5ny+F1817wpS5WDpy8XEFkoczxi+opdM0tXCJJ4wOlhbQ44jwJ6EBrPAn9fDrnTzilPaYhMpOrfQttSDTY2QoiGm+N9SVaswcY77TCC9BknJJDvjWRy0HlByZP6T9Eg55GaDFxvp14XlbqBnyMKIbe03tq6dyXkdie/6XUujY5txYkDaG6iRNpvXfXfjAfJ4bU/rGM+ebUZa6o5/yVB+5Vu1QTCwY/n4I1xShfNKz1aeG3V54tG/xnfZ2OsrMUlGBHw+0bj4nh6As/VwZityNH0EErx+CZoVPEv8HS6fU9X4z9C4Dsyi0vPsBU4kDuWHKRc6ynuD+0UcBPqZyVp/XDWvjlk413mun2b0Nw8/l9oGdfiAqlIPjpBa8TMat2f7QqdsXcxPBrcGCqkvlgEf7p42ac7gKqtKwSQW8ShWKUmEQWHqTmLkRok1SX6akDh1Y4TCjFORO7DCPrJURtc7ScrkFeAWtwqmSM9Ud3cOeN5SF5/RWejMpfdJRP2DbbVXWTtUDLs4dQfemB7PjzFGZsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(186003)(26005)(6512007)(4744005)(38100700002)(86362001)(2906002)(83380400001)(478600001)(66946007)(6486002)(316002)(66556008)(5660300002)(6916009)(66476007)(4326008)(8676002)(54906003)(8936002)(41300700001)(2616005)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPGu3TWMhPkMNZINHU7vThvNNesU4msq/cxF++EwVWVjyif1s1jeNghRZNrd?=
 =?us-ascii?Q?4h9AtxqG9JvxSwEsKrLebsLB8S78G+FiK+fK6xsuddCX7YyRxx6QsyRaxkn3?=
 =?us-ascii?Q?tQVLJy8li1yvb3jI989PdTWPiwwwsbKAYq29+U8cIQPIB/HN7xARyMv9pyRb?=
 =?us-ascii?Q?wuCUSbajfQ0W8UexEhijcWiPmoiJplgNDp18WBEHqT2cJjNa7v3QxzRMYJcX?=
 =?us-ascii?Q?XnjGYktHH4frZj1W5UgUoNriko8Do+Q2jbS1VK1X/NeO+FfNCNs4pu66qGXh?=
 =?us-ascii?Q?dbNyIKYHHzW7hCiz+vw6IiCHBmFuBvUUMHW7fs5NT/YsKRP/5VGW90Ud2jom?=
 =?us-ascii?Q?rksZjsRLmuW2CV24p6rrbbJOb7Fyk5ny8ZG4EeFzz3GSkjgiin+H5JLFZ8g+?=
 =?us-ascii?Q?lbL6gPDLItgX3xTy6NdojbDFwLBomI1uAG+TcY0+Y9NxI02a7ShM+tCjk1ia?=
 =?us-ascii?Q?sAexEIQnLgT5/XX6zAlA0C4lafjXviBXqe5CbJGxPGIy8EXbsRnhccD/wcN0?=
 =?us-ascii?Q?JFGAM/QZ16N4g5KTY6eF943kVzg4UlhGOL9YsPOwTNTdMdghT83yDPXa6q/8?=
 =?us-ascii?Q?9mBktj2ZGIT8NZZ6taygByOxjYh+uXJnRxPwKX2WsuSE0+vytDbqIOQLI/H1?=
 =?us-ascii?Q?Imp69s1MMnBFPn20Ly4of91+WQKl07Y22N7pxGCuJ4KDbPJx9jyci4vMyHc7?=
 =?us-ascii?Q?2lnF+pzGZaz7O7nRNONCupr1Baybf8O0APWJs4ZfTXmdLzQ/+JCvVg9mxJWs?=
 =?us-ascii?Q?mkvbdqIahajxfnGiMr3obGWJXoNF9gYbKQrVxEqIHd/8qAhFYn6LFxqZmfu/?=
 =?us-ascii?Q?X5/sR582ktkb6SVXXp5VmjpMV5/dGlWXURZbWB/T1K2T3kNnlKBIj67o04pH?=
 =?us-ascii?Q?a+HktnV8FCdd2DJWL/9x5m85rD55GL5c+oA4kupwm1gKp+jZ7/o6NRJG7yv6?=
 =?us-ascii?Q?ZrK0di4KV3/M9gR5hU109DAzVuzLUW3ryZq+7Y2mZsfnhSU788vxGmPOaUmn?=
 =?us-ascii?Q?QMozGp2ww6QwaWb9t70Xs+sMaP7h8/p5nUByVlQa+9d1qq3FPgWPidemw9kp?=
 =?us-ascii?Q?XVoC2ma3HyP5vYEzOSh3eeTuqbR4PBoCnQ8t8VHyTH9BdE+If7mouw8r1otp?=
 =?us-ascii?Q?17Pk4uT78KbtJnBAmuWS+8720H+DhUIBf4P1UsZXSWrP8/aqhJUss1JRzO8B?=
 =?us-ascii?Q?fjJIO8J76REZ2wlLhQDfUqTBHd3RRKJo2+5tBigkxX72+HanNAqjVSxnPt5I?=
 =?us-ascii?Q?35RBD0+CaZRNUUzJg8DgtHpeUEE8ofVZ+FywJl80hvWDZcQZdpSrFcu1QGiW?=
 =?us-ascii?Q?Dun1x//771s0P8J1eo8JXdI5v9/wHpCbMiQYev0yM8aUMeD6BLrm1ffsaNNm?=
 =?us-ascii?Q?38V+EJ8vax42JZskyN9lIBwKhUSmZnnaUyKdmHmsuy4UV9hR5aJmg080iA9J?=
 =?us-ascii?Q?cuMcpR5+flY12nEKq+Uo28UqK5573sagVjULqq4Z3mKOV8JYmwWc/6w775e5?=
 =?us-ascii?Q?EeDeFTvppU5AWIM087uKsuh1tKcVzksdJvBJFKcM5GNn0KI8p6swulAYZnLB?=
 =?us-ascii?Q?1iUoSZ9Q+iiTGdOhIxP4fOPQINxTmwC6qY8CphLu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bc345d-2d23-434e-17e4-08dafb107f79
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 18:02:30.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuXY6b2Kv6ns8v2iAZdwxE5QUc/FWGQt7ivPoIo2Bmyz7q4PtrzTFPrEAXxK0jvg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 08:27:49PM +0000, Saleem, Shiraz wrote:

> irdma replaces i40iw (to support x722) which has been there for many
> years. irdma has been in the kernel since 5.14.  So we have similar
> concerns about compatibility.

Well, I did caution you about wholesale replacing the driver...

> If we are going with such a sysfs update for the ib_device, is it
> not better it is done across all vendor drivers using auxiliary bus
> similar to the restructuring for sysfs HW counters?

I think if the ecosystem issues are fixed then we could talk about
this.

Jason

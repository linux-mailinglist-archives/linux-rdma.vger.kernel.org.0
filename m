Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79C4E2C59
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350294AbiCUPd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348887AbiCUPd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 11:33:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910E16D8F5
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 08:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3ekX4u+HXMsALDry5QW18PC4paEtJ3v9AWrTqH/AXQ3qnhjVqLBSUuAF/taM89K/pOdNf8/CuWRZ2XJ//JbBoai5OqhvlFyHU6woCHgSmqJp5++1Mq9JDfQYSP6k2G66xWN5qzS3DSK9BZigmzjxEgm3c0b7vuzKGTumHCXSd6WzFAjGZmTIWYELfHNEUMrwcXdwRWXr6vGIyjWt3wA0NTpew74s+fksK7+EcZhyXSLnZcacxBa47agBdZD/YKS5yTTXLcB2mi2oa4/8yn9MM+x4I9jXz+ti3tgQvQTh7F6Qne84XSNfBfZdDONeu6UQpdLDFwxXkaMScx3H9WWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzo4jWWVA7tPXs6ZGKTCVbf6bMD2hBc3tpCA/369rMc=;
 b=KNzbvSbYhDoslI6VA2nZwgCDLFUaZomEQZygsMYHywZG4YaB51bJ0RSiMgrxBKUO9drEBT1oqZPZef8VzY+l70TqMrxKsJooyAEI6ICE/51BtLznGfhGnblDN96SoPBl4T37j9DR5xIGWmFZe4ZQvfsuCYQCOtu+fGhg2NytnaeKy9VbetqoBj9JenCTVbcYkBWq56fiMT8tHO+zXNiBEre+DSpfQe9XqAaGc4sEq8b9wKLJWGUfeWAeb8DXYRiNKro+Rybc/uy1Hq4RFacSe1JSjQ8T5Qtqetpo050MPGJ5mFqT3CgT5Z1SfNLdn4U4i0MPcjxIUl6eaidQ2CwRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzo4jWWVA7tPXs6ZGKTCVbf6bMD2hBc3tpCA/369rMc=;
 b=YgdHWcQGEwbk5PCLKw5wtWw8bvsJTtlD3FpZQI2Hj7oX6agxBdWE/JqXYZQHgw/J8nEV8OKxiXiDm9jSfoxaI3BxPhU+vW9uQoReeKzsWU2nsVXfKNnl/aL1J0ZqO9DY4Z/FZT6STaOkxZRXO+AdlanORmU6IegjTox8ZL6306U2aO3q5j2V1yBumYQ1NkrmhMPX6EU2IUtZGKw3PeLYUU7G1F8y+j73tn3r6/reb17c4tNCX4a/5D6ZB72+0xy+OD1Dhv6M48MSRV6TtL7uzmKuRwQxkib7AR0cpuscKsVmzXkYhSBUwQh8DCeOrNf2FizPcgdkWkgZoQbXdAvuRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 15:32:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 15:32:26 +0000
Date:   Mon, 21 Mar 2022 12:32:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Message-ID: <20220321153225.GX11336@nvidia.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b489752-beca-4825-2524-08da0b5000df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13238A8027A98047D6952615C2169@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xvk0S3OpoK+5k71uEegdLewBvolmMJEwMoQCqk+1hT19wnxeiJW/vtP7Dz55+PqTSsgOFc0bU6Wj5vgROUJhkyIRz4eJocmsDSAVB9/yH52LYfwqEeFICab5QT13ckFsKhF4LZWbnrt3/j7KTNbr1ZOW40ctZisg1MTLHx/dHkIX7I8Lum26kzVsx6rOaTzFKPOPRVW8RCymcnbSqX04U52QWkXeObJ6yC1DbyKh8EUH+ygq3rUZmTTxmNC7jzut95ieZCTRldI0fnvqO2M9mxMe5MD00Kir6tHdG0CcajXWmH7q5d6ecompMjYAsYOIO9yZpx5TpaZK6s0uTEALJqDWbKdZiIpohQl0yhBlQtogXYZ9gFA9oKzjSWRHWKNOQ+hxB/LuECEjTObLMLUnAkvsWat9Y1W+weUAhmAJRZk1gXErvxtw5ul9QOU1oXVWZdqhROUYgeoRzmXfYmEOX0zcH7sFkGiKxxzCHf6p7Ng+j1assxuUQOwgcpnaDUrPZEdsJyzsczRvow+Se4LsFD+v/RLmZqGrUHnPBipUUgAYK0COzeguXSZ9/3YB0rcT2JyryEhC7y9MyXzWLHNTFn/YtmttjRC1DsPLECrw2zxEh3oX9Rrgai9erGVJIWLU8o3ACMJ9A2HGIln4bU6eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(6916009)(66946007)(4326008)(83380400001)(186003)(316002)(6486002)(53546011)(8676002)(6512007)(508600001)(6506007)(38100700002)(1076003)(26005)(54906003)(2616005)(86362001)(33656002)(2906002)(36756003)(5660300002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBdU1/jKZAZHiuwIq6uq9P/2ZM0lKdFKEgxj/QOIqLFo7EBpD9t9N7rG66BR?=
 =?us-ascii?Q?ILyWvEL35bILiw6g2HQM34a8EU9fWusNtXaY35SVZC4oDeGwd+2eH8LJ0oh7?=
 =?us-ascii?Q?fd/6P17mCvGKzObaRTWYcHUpuoGPmGXFH3Xuv5ia2pdHRuVlVv8vUCZlDcZn?=
 =?us-ascii?Q?vzBMpF47aBqmry2u4/qjzHv5V3g0nFRoW0pOyPqvNZnis/SjXk+OuM+Zafx0?=
 =?us-ascii?Q?D3ac11zOjUqw1yebI8DWkn1loM/HEiGbhw/37DZOqjwFm3mKgjecxqzuNYqe?=
 =?us-ascii?Q?Nr76NMPa6z/UQ/z9yusx89jmo/fyJXrex0rDGlJV0t5ALSInKuVdnSsLAeUH?=
 =?us-ascii?Q?quziux7wTrlTZm/9LIdUWkW45Np2QyICSwSGmpg7sFqPX7c28rl26GMNTz2Q?=
 =?us-ascii?Q?KDI868JZ0fPxZQFZJi4s4xAf061/zn9djJs+w+oMhtE17tt/gnr50tCLE/5u?=
 =?us-ascii?Q?gvE4vy+ayc/cmoVI/tg3uv2uvwQMB3Yxn4umLwTI4mqvPQCrsm/chrAGAY3/?=
 =?us-ascii?Q?ZXBp8zOA2nyG/vXWMgUD18sOyG3L/lON9Am0sSC1X/LJjrlw+tde/mFDKehz?=
 =?us-ascii?Q?9HwOIvZlSn9HZVlQSBtELz2qB3t8LgKG/4GdeT02nuCseXUAYOybdGT+xewh?=
 =?us-ascii?Q?8hRfa4oNT8iB5CyAz4MX15ra+SiR1qn6G+A8nPi6HvIjuSKgaZC3jWS190g+?=
 =?us-ascii?Q?Q2t1ppdjSOLF5+NUCjVx0nElfKeCNm4xGQZFCCfcbiQPoom+Sj8DdIj9cFjE?=
 =?us-ascii?Q?fbPFix26KQMq7BoxjevUMow1PUA4SOZ/2jgXJKybbP9F+08OWyoFfIyxhrSV?=
 =?us-ascii?Q?sP+zRJY+Ph8ax2J7jHMJQS1eI5Z8xOnqrgTJzIyOVbdk/JNwJ5b3df9SCDv1?=
 =?us-ascii?Q?WP26XCBwFEAJCWwHLwrpwFEJlWl3Hd/vvJm9d2riveiUOGrrz1VH8y4ozrOZ?=
 =?us-ascii?Q?FnluDZdA5Ksdoeq4d6hTNqOZnsGLrl4Kxw1CUS84pZC9SLKZ5q0nrVbETjlV?=
 =?us-ascii?Q?4SUo+d7JcJN5aaE/x9sQ4K2nTDAgr2pJ25FNvzzTNor0l4190hhw3lRPdtlt?=
 =?us-ascii?Q?Dz0V+exhxoDZM09S0Zz2/OFlkCsTMgSPEVtvHldFLesSjTPJ5pDAYJsJuFvi?=
 =?us-ascii?Q?SyqAzkHIkDm/xwxaQ1uVLVvTdi45FtYh0QUOiiaEmwA6wcGlE+3oA331dio4?=
 =?us-ascii?Q?cnknO5dzwd9vgRUBjINqkrt2iZHpJm82ok7GN4swm3NYq4OeHJ+yufuuI2+l?=
 =?us-ascii?Q?gx++jjITvQg8ZrYkBiZ/ERoQOQNEHwn+MnYaxP5gBubUbZoUfNHW33LtxcwB?=
 =?us-ascii?Q?et1unGtIaFxvYKeJjFl5DnfpaWm5yG67ZB/xd5srE6VBKLDQnk/TKAf0+0jP?=
 =?us-ascii?Q?NtYRnYyA/4KTVw8wqO+idLt2D1WnDXzGRC06BgYnZ+kaUDh3mD/enfggmM0l?=
 =?us-ascii?Q?zvOtNty/PNmuAUHeWER6tmJsFsvh91Nb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b489752-beca-4825-2524-08da0b5000df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 15:32:26.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZOu176uGwGj1sHph7kb6Xngfwmbr7gDTKufrKM7JGT8eb9MA11thOVy+NbmiS6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 21, 2022 at 03:55:01AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/3/16 2:53, Jason Gunthorpe wrote:
> > You'll also need to do something about the 32 bit compatability that
> > kbuild detected - I suppose this can't work on 32 bit platforms? So
> > IS_ENABLED() it off or something?
> Hi Jason,
> 
> Is it possible to fix the issue by atomic64_set_release()?

No

> If not, we may need to add a check for __native_word(*dst) and return an 
> unsupported error when __native_word(*dst) is false.

The whole feature, including the cap bits should be turned off for 32
bit builds because it cannot possibly work

Jason

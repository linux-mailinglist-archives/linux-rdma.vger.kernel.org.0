Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A14DA2BB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbiCOSyr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbiCOSyr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 14:54:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5C2AE29
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 11:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOthyRzr3kiLyzJCKucE//ISC9aChtJz/JiwD2Q5idh2KoRt7W3Cgpxxlr/mrysR9aEQQFv3Z8nzEgEoMBLpHt4naqPg9OGWpGslUJxOKUGizYKGXeIcaweFSDqhNEK2OttEi6bLF6o7vaR3suYw2bVz3Pl32sTTML96aRxa0UzUQ8EIPeUu0uB2CoMBbNcBmVJVtpPH1HNn+xekAKCxdHuyBfTxaIEiFiRArnyP/4Awy3t1SQjEGP03QcZ1dWPvSsifOHeBhjRkyrXYHe7bKYM81mNhxVADs0NFdQiFC8VtMwGDeqy1UT9Mex9HdpXucYtFm8P0ghY9zGPOeBsZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tsoF7IAOaWp0kaIhRtNhOoC+CLCWhufybkCyetRANo=;
 b=AJd1p65u3G+nm3OVnwq6NBDbUGgcgM61I/vHLUfk/iD/8XD6QEBcyOBiuORxCUNdH+dCc0hpNv4PZ2QQ9c9PhCabj7zagOoV9oprpRkf3Vx0f3lDRgKhTc6LhYRbRK7joOAEZM04TqWfUtmew2NYisch9HUPbduu5QXWkRmiKl63x1WY3zNta0p3zldoABsSR1FqaZSgS13H8HhxRMjAEYhpm2EcqcOvadcmZd0cp3zTy4JdG5R/KmUdRA55DZGZcsMv82vHStRYDp9aoO5Vsp2vaYLEhftsNvK8svj8iFa1ciAFu0rneY0JSpI42rv4nHXy8uLCHk6ZBV/N6fCo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tsoF7IAOaWp0kaIhRtNhOoC+CLCWhufybkCyetRANo=;
 b=jIU2PjhFfYfo9WBMUZqrcmuKcFM7D+bjSsLlf2II5ZHLCJpuf6bg3p+rMpk4mJKZgutqM3lW/NWv2qCUHzk2V8bG+8+IDc7u3XZg3yfmyCnd+yAPDXXLmz17pQbn4EoppzOuMwL45m4VkBzJcL3mlSsKluLpaAQBMZL8A6B3S6jAlcyFCMwHKRbKAbtj3OXABhT5BQB23bRbi9f+ie3415Dxj2B/BvLzoooxdn6sDAS6GfWcAE0eCKGYTNHPBK861XFmx9We2oAdIkDt4PKMR2sdu+QVFbp0mYTQuvPAw6bTyszDOGwqjJx82F5Ctc+/GAJfn3YRRbiAzB8ESH24vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0066.namprd12.prod.outlook.com (2603:10b6:405:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 18:53:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 18:53:31 +0000
Date:   Tue, 15 Mar 2022 15:53:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, y-goto@fujitsu.com, lizhijian@fujitsu.com,
        tomasz.gromadzki@intel.com, tom@talpey.com, ira.weiny@intel.com
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Message-ID: <20220315185330.GA241071@nvidia.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311115247.23521-4-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353faacf-3ce2-4f96-0098-08da06b51978
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0066:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0066553EA76BB4F140ABEF4AC2109@BN6PR1201MB0066.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akxZwU0eRbCU++uOiGv9MgnrBuynZLrXN+XjkC6xK4EBZXB623dNkc4O19zZWWj/vKUayW4GT/gqcnpkGB7d/HAhmtHV2GRZIbz1NNjosNfUXPUO7y3aoXL3bUJfETb1wxQmY0y3kBVSxPoeVXToOWRitHwm+3jHkmHuNrlBPmFUPNrZKeut4Pym4uB1WqPDmE6TIoqIOn7GvomxDMUvOg9WlRz/2JXOnmHJBnOtxH5tdYJwM0+wxgCAg2xSErolHGMyBTX11eJoh5dyflBHn8R5pezuJe/t5HPD5DEFestGKK3zlKPE7lHxBQ4Rtz5r4mKjQQcqU2PHIPg70drs7iIWH0Mw4XgKFt8PHtwAPQ6/vL4b9vlVY7MjD5Z3Sxq8LK/Ur1mBFS8wSN/L4Mdt3rxYa/OAPTMEMm920FzzEyg++emRJOhtxvrzVUsAYZpmc0s78Xyuf1tMMtnjeMyeZcL+GnDo9gJfOKmSks3dkJIyl3JnW5NNLOocjBU2gJ6nYkDC0wTV0mGtBeUH6Pt5P6thtSapeFNYzEK1qCZnSqk9HGlYUp/QKE0pVjBsMylsi2y0j7bTJkYWT8RiEdDfhJNTMG6TdCmEScjKjRZg26QfvqRcADc/A5PDFzWEXn/LkZ7XdkcH39GhWQBJhDUFRzOtxy4IJsi9IV5jNt7q2XESwiQ+vKnmcjyaw8Czq5Ql
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(8676002)(66556008)(66476007)(66946007)(33656002)(4744005)(8936002)(6486002)(6916009)(316002)(36756003)(6512007)(6506007)(38100700002)(1076003)(2616005)(508600001)(2906002)(83380400001)(186003)(26005)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G5eY4sUDqwDbMP26D0gWB3dCvsCenui5sptEp+uV88dVhnT4n/W+fggzcPYc?=
 =?us-ascii?Q?aD1zTbtCaVMG/n/Myied5oTmyiUKNzxi1aT1r9wbh1v6l/+uTbbbFM8Qijcw?=
 =?us-ascii?Q?JxDc0hrNvVE4+W+8Lx8BnS42bJe5kQiH7zFtD5Fp2d4yfwkutBE7uBVqnKBr?=
 =?us-ascii?Q?okinPOuql6z1w7Zvc4GsIq+4t14Scbyx3sx87iYD+yeb1/mroSWnG/wHtLen?=
 =?us-ascii?Q?ltqLH8XKQgFu9Y3Ys/cfU35JPUj2GJ9SsZvnX1OnmO0kdKo8WTr0dRk/1IPZ?=
 =?us-ascii?Q?rv0c6bQzhXGk+Oirk3vMFSyNLiZ/O7eSCxLP2FE7fZXXn6dPRJ9Oa6ZazGJj?=
 =?us-ascii?Q?5TY6/8fpT4pLp/loy1PNeN8j/k6j2TrT956i8GHL5uE4/5CiyNizfFUFYs6n?=
 =?us-ascii?Q?BMeTrOvG76z96lcDStDpziG7lArN3CyuXkIVOtbF5LyFGyboeBR9YoGpNX2c?=
 =?us-ascii?Q?/1tcUaj28Y1RGf2bvF7gxATX6FVd+Xzhl975pl3toTiLBWV1GzKYt+oxh+9m?=
 =?us-ascii?Q?pbkTigRWesyFskV6sTvyLGPbt1ZgavTbnnfijpt890s9QfEC458dtAniQex2?=
 =?us-ascii?Q?bxjZTzd7FUtXv2FxPy/qzlnfhzbl/y/ZBcRvZfGGPKiyIGfSLhFYIdKNbUH9?=
 =?us-ascii?Q?6eaBDWhs6oBRZ1F/iyn4pQP6duuNAMvJgmlM2EySz+ev34guWREylN5x/7O2?=
 =?us-ascii?Q?q3asaUH9hX0p1GEV4WqhnHwsDL41DZbzQBGIqZXDY5S3MHM99bWfPrxWLZOs?=
 =?us-ascii?Q?FIi909eHYgOYDDB+f2TR2apzD11TWgsoiztwvP8QjxN3NoZFUpgrnnBbZrQc?=
 =?us-ascii?Q?ujSOmtQxjI25SRLB0DCHrx2kw1h2F6+bxK3PZif7A1xYELHvCxd7oeqVY/ux?=
 =?us-ascii?Q?FFKnU3RFa61n4xbVItkj+9kIUYvYkErPCs2TKhhWColCHyvSQ0w48ZWReDCm?=
 =?us-ascii?Q?/tdNRrrui6mS1IJQ09g8kAHJf5E1MnglPdbT1PVXLBf50d1WIZ3Ac0Pp68v/?=
 =?us-ascii?Q?gs19Ke6RrzYxf7Qi70s3lpmDSGIai8SFKcGWIq6Z1khQOLS/mLey8+FEwjIx?=
 =?us-ascii?Q?1EH6kAcYgQsr65VFPFrSl+1gr9INgugEVu2GprthFS9Vm7PotncBOc2QjoNi?=
 =?us-ascii?Q?AN5LHNaPLSAAvf/SanLBax6erA6Uw7+sq5/kA2LC/+J8hGU27+/t2XqP7uon?=
 =?us-ascii?Q?MwhxpiS0kqU2+prymPiN+s4JqCQ7BYl4E7e3X7qSERKeotlzSRbaHEFCoFwr?=
 =?us-ascii?Q?T62zjBImam6l4DN8z4JEW0ZLzmRORrxBn+z9eZVyJ9NsDBkQYQ25AqY89Zcx?=
 =?us-ascii?Q?2v3pmu53v1P0g3YPNfUU1wO5usKHfnkZlUL3eI0dRUkVOxmN9Ve8FQ5klPIV?=
 =?us-ascii?Q?Z19DHOif3mRPOMQPdE8IkKPb4SsvYAVLnxCGeRah1SA0XNvp3yI6e1S8fL7i?=
 =?us-ascii?Q?msNvOp6ZGXKcp9lY4bk/ZRFCZAfvK6JH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353faacf-3ce2-4f96-0098-08da06b51978
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:53:31.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gkz4TxiQzKcjohEaN7OJdGQkVEayCkvZxJLNDs3obCDXZvfQO/ezTpo1eu9DrBOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0066
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 11, 2022 at 07:52:47PM +0800, Xiao Yang wrote:

> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index abd1c5d3dc66..580b5cacec09 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -291,6 +291,8 @@ enum ib_device_cap_flags {
>  	/* The device supports padding incoming writes to cacheline. */
>  	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
>  	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
> +	/* Atomic write attributes */
> +	IB_DEVICE_ATOMIC_WRITE			= (1ULL << 40),
>  };

Can you make a patch to clean this up too? The right parts of it need
to get moved to the uapi header and it should work similarly to the
ib_uverbs_wr_opcode / ib_wr_opcode thing.

You'll also need to do something about the 32 bit compatability that
kbuild detected - I suppose this can't work on 32 bit platforms? So
IS_ENABLED() it off or something?

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305A69996F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 17:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBPQFL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 11:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBPQFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 11:05:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1258E6E81;
        Thu, 16 Feb 2023 08:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhBn4aJPuQ9d4UAfmm5V0/0He2JYALyH61WvZzR6rXSPJdWVq3An59sDVMvnePjvS8azEfdgIu9feW558BT0riNEjz9GwivTZKYODnFmCYjxy6bsKrNz+OYSQLvvQq/BGbRrTfe333dnWaBY5B+iWlZDmpxhsuX4dd1DRFaMx5+7XknnhTdLgy4xf0GKy3a2GHXy3h7QYiKmRMf6F/DVoOnSO/Mq50bqwPoGSchHNf4ibXfVzVoc7cbLJc3V6fUup+G3kopfkrC4MYm0z/ElsE+oWGxe13iOH1t+hB4WH0uKfQLBNvg9UVpA4XgWH1yuQKi9JUYW/RpW81IfWTCPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8jpY1aYrBSw5lu24FEns3NAalZJ3S5032hVNIk9y/c=;
 b=R0vggWVIf0WAO3Ak4lotf8za9u2bqYqanp7n888QRJsBfiI5oZOHkT0NWFUxqSQFUjFqGUc3FwTPoO+EPOAV6+K2D0+1LaMjEXnfCzFqb/2xjTFa/hbISlZrOsRzVeot91rwr6NvvA6+LpawvJQR26u4s7mEjaM6KO1lPa2MTtj78CdWqx12WXrJUZzmqnaMsWWOb3lVJ3ZG4QcifxCuLf4e1HxA709cOw3hhSwHFiD561X7OkoQQAbWr7wAlLal/UfIzzbQ9mm9zVwwlKQZhzlX7MTAZ/X4JcqhV2L0RIwbpt8YBPlMccO+5XI20OPcVRuozaEgx74aAHxzg2a4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8jpY1aYrBSw5lu24FEns3NAalZJ3S5032hVNIk9y/c=;
 b=Z1uF+uHUdjnhL6UDhADpt8rRrrVpKwX6UK30O6KRDHN4rqhkrZj5WTkAgj7zJU6xECi/ESlWI6Vuxo03u7thQyT4c4cyuNp7mxlNYO45Q72xhYIDlAOF0c3PX2QxeJw5qOn9e9oGW8gM2e7DSS8AlAKD9ikdFUL3ssS9HzA1tuDjKVfTmOhKgNUrsYJz0TStN+ZwuC/Gh6807H5ObolF0P0c1FyIrx6am6gErdsTXMC+aYuGz6BBwrHxxVElCgHBgIQrKQaXsobYm9q10Y8iaglMZDvpyQy6F0P2ezDq2brzYau8UOAVulFQ0ccP8dwEK5d/0MBwnEWp0s6Tf5NQPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 16:05:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 16:05:04 +0000
Date:   Thu, 16 Feb 2023 12:05:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     longli@microsoft.com
Cc:     Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: Fix a bug when the PF indicates more
 entries for registering memory on first packet
Message-ID: <Y+5ULiTnEAYCAWOD@nvidia.com>
References: <1676507522-21018-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676507522-21018-1-git-send-email-longli@linuxonhyperv.com>
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: b9da5d31-d05a-4ca8-c5f3-08db103790c8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ya9kQddvYwkhRTaJ/S9UE11sQTxs59l3ZX9VdUShg6++ZHgvgWdv7rWaBSSoWuIJmizwIQ8lz6haurc/DRi4PaIS0uMyHvxgzxRzUvL0usmKwYJmeoJjHc/MouqyexC93EIPnUlc7k6rR0b4Qs2se8RqwE2A7mfz3/SLCTcROQ+wqoTuigDCNsM5HwoN6usn1hz9wYDO0gowLQWoL+gwiQsFYsBX21f93JL2rnkB2wQlpqptmdbYAQccXvYRaybjIpbNaoofyEP4NUxAjIp2aboCy3ikp57bbwTvO4SWa5dDeNg6Pn58SOj6lNSyuVQm4Iz6/pswx8O6flRKoqKi9GGi1LOYh76EXUAnsBRureacOKeYR8bTcpenXOk18LBBreJiLnlcviLw3cKdD/DNgydwzj7xmantL2gPW8y1yaMlPCkEkiXNmsK2Yfs/ReUp+U6UD8BKyDHlmLzvi73aP1Z/wjIq+oTKWO0BkpsiSePeS3ivYHj0F3sHUBCAOoF7zLZLTSPlWW3YByA3FeC2e9BqkutGKwMlkgiGxtBTr3BDY6MuDhcHVngM6Ah7d3uIYk3Oc6ubQ2+44i6Zbslwa04NpEJjhGKeltnxJO0qA9iFD6vHhgMRtHuv9b8cKwGjXYVi6OF4brziVaY4KEiYWX5p7BBPpfKaNyKcoapbfyIm5Z9CbLhgozmlBrTIOQo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199018)(38100700002)(8936002)(6486002)(5660300002)(4744005)(478600001)(36756003)(41300700001)(6512007)(2906002)(26005)(186003)(2616005)(6506007)(86362001)(6916009)(66556008)(4326008)(45080400002)(54906003)(8676002)(66946007)(316002)(66476007)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8QDpApz6rYhNxm3ph5qG16gw8xmcR2yawb0RiAJ9zCeAxX3Gzd+bdgAqsG1?=
 =?us-ascii?Q?ItdIr2K71/0eKt/8ZDuONGk5M43CLkvxjRpVm6FMRlQ01eBEHwzsE5fi6jXO?=
 =?us-ascii?Q?w2FuVC2dsTqHaI1YEhc2nJJrZ4+fEO9Ti5j538ciuCihFoDztExGZn+MfMlQ?=
 =?us-ascii?Q?S4FPt1myr95SkNHGVhv73Btv3BqHcd2oBt8/cSJn+m9k9Ele1hcP2ct1E6Ar?=
 =?us-ascii?Q?g7PzxYZOH4sY/DgApsSgTH4FiRwQWmJZQb1XgUSFfa0YNQ4H6ZjBTbGGKRBa?=
 =?us-ascii?Q?d1hrelydVnMRPBIwpEA6t/oyi+Hn2940S8+Aq9w8VEIHZ7iUtUZsx/9LRA7U?=
 =?us-ascii?Q?kYqRNDfZ4MCZgIl/7Kv4/wtVvPxzy7/u1O6G2WJrGNSdSko3ySU8ioofEcI9?=
 =?us-ascii?Q?cM6y3vyG2nPFtSBBnLDRuezV4DFa8wdzil4cCSVmgm4w/y/YlMugDREEDK53?=
 =?us-ascii?Q?i5Y9yiaQLOEWSoBaEKzewyJ2cE0mFUzYLQZ0zcEXsd0IX/6kaQVkwBDhbWMH?=
 =?us-ascii?Q?usWzfggtZyMdnHCwsgLGRMn/gE5diQraTh/oSRBZ0flar6D5oqkPAP8ZbbjW?=
 =?us-ascii?Q?wObfcnxfOIeExbvf+6/rvHvTrANTh1XKnSIz1YnLI4UwtlhMo43SsBgvRJ0m?=
 =?us-ascii?Q?vTY1MIpqUb8xcL6+76LQeJu7Udio24AqlYfa/A91C/T1IlT+tdPRzow+IBmO?=
 =?us-ascii?Q?6L7Ex18r8SYKbOu/2coBXiuTUbn33e9YHx3O/PasE/KZGnSFgvICCY0ff5xI?=
 =?us-ascii?Q?a2wwSrCeT1SxVKpcqax/dPF+pj6x8wvnUxAwro4ezby0M9UfUz98OH8cqshd?=
 =?us-ascii?Q?L3E1Aa0t0HAxN2iFfMA9fEEw3PGC8kRGanoS4PWpQgVPTVUN9ljbnpfc6gOh?=
 =?us-ascii?Q?tId9FpL3Vx1XbFNYlSpISSmVLLK9HHywTuH0CaWQ1cWmIPc0t9N+4rPAa4ly?=
 =?us-ascii?Q?7lc7aNKhzRHfqyPrf421EYrRBCK9f4Hfny7B/rC6/MWIeo6UyV3q8sj9yzPr?=
 =?us-ascii?Q?X0q2Vjc8i6Ug/6QEatej+JlfOEwXSRDAdJ5alnv30qmaGIuHKqxNVmob4bmf?=
 =?us-ascii?Q?11blWP2bcRw0LdJof5Bma6QhLNJI6chF65jS7XqoRgv0eagUFJ+8ArWB43jj?=
 =?us-ascii?Q?JuZIfI6jyWD2cebTlgwkRu49AafLR/4Rz3BmKt8dlgL7mGVbVMiM+J0HXWQf?=
 =?us-ascii?Q?D5EFS1JxorDDGmsnfVduiZvpL7d8y9EN789F03hxHV3QCKPjA79Av369CDQN?=
 =?us-ascii?Q?5nFbmXTxP6sx52zSZlEPcMi1MKmvE5l2RiYXMj+yvFQDy+WLp7uOdFnaQ3qt?=
 =?us-ascii?Q?YMwO9BqPP3Z1w/ejNQnSwPsr7hZBSptK5qCDze7WzX9uMrE48S18efq/O10V?=
 =?us-ascii?Q?bx4OFGBS1BwIjdmLG71AtrRm6ItyHgV74QSM9EbMeJ/7GAiH9z0p+1qtyWNs?=
 =?us-ascii?Q?otlxscuOGIjPmeOSeastx3pX+IvrdKZEYQO1NX3gX039c5N52emxq3SAgiEQ?=
 =?us-ascii?Q?aHs1PmKmpMzgbDROSogQM1KgEQqz5uh+MdafvLj+nIX/svsQykYy/fdfqmMc?=
 =?us-ascii?Q?CvWaZ4jrqbgBGzryFTTTQI6ye68HXTmThLN0ITRJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9da5d31-d05a-4ca8-c5f3-08db103790c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:05:04.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StVOFpv9UsHkXosaQPOAha2yQfTHwEGupDkfz87HPUL20SvTxVdHoQ2bBbQsDq/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 15, 2023 at 04:32:02PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When registering memory in a large chunk that doesn't fit into a single PF
> message, the PF may return GDMA_STATUS_MORE_ENTRIES on the first message if
> there are more messages needed for registering more chunks.
> 
> Fix the VF to make it process the correct return code.
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason

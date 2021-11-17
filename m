Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7847454ED0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhKQU5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 15:57:19 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:15462
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238891AbhKQU5S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 15:57:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynv363P3SsDnS42WlX+CuDIBdImv5dYYPdnvBd7T3aUm5H8+ohuKC3NyczqKgPcElGqJYdqV352ftoKiAJFhCckVBY4+8e+5pMublAVNw5argmtYHc3FK2NlN8vUw4dRtpBXV0Bd7j4o25L3AlzTt9fLa8OGWb9JAKQX9CWDRiUyG/5szXrJooaKy1A+Qnq0mydC6x5W/drvLRN8lLlN/Eo7UYq0b+F5Hg+yWGQHQ3MFnqhyuVcBqLHIaE3y2m37xXdDGQjJkDIIXjcC+34sXcM5yo6BqquBNLnd/lFNOoxBiZWP1vcpTLlMZ4SyeebKp1jEsWBFroJZZ5/M5+N/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv72dfI18eXR9s2PfBAqZJiKSv4nWQhPN0nSrJFp5k8=;
 b=KhULQFyz11UkBAyQu0bIpqorTH1xWdeecq1bmj5tESC7W+J6fpU849pWCiozKDs1USuDbD8DfuuKZwDyzmL147LCt83pWdaTEgzb4CL44ucSJK9vmwe+b6RxXwtO3d1Sw3BTtQCgXg1oH/FRTqYs6fvJsgV5unbmtA1Ys0hhEm10gRIlbxZ23HtDAMlhiMW/VShv6+xJYu6YSKBaRfYryof0U2LkqEINdkEBin59HkTXEC6wjE3H2q3CWx+CwwBBBiwN7xb+bqpD0kmxKbCZ7A7wHGpKTHAp2aMoqHg8zhN6IgIxfbwTAx7+5WtzrGuKepITuYnayJ/KIVGh6ZYcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv72dfI18eXR9s2PfBAqZJiKSv4nWQhPN0nSrJFp5k8=;
 b=ufM0rvk8IBsb+U8xe5GTd3PoVLlEAwqM/10iiDwjc8i94Hko27SVgLS8WmrD/KlFRnwqNKgFONLPoVW5mbKfGNUhL6HB96zqyFouksgY4rw91NxOnWx7jA43/mpCYH7aNCJje2F+5zop2gEytlsSwTPhBpPzmYW0NZHNBH3Nw83nvQ+lDJS06d8k529bLY7dJlLHWqPpJ6zVsMSerL1pY4cLDaUE0maKJ5+U2fI5v3N8esSV+hyS2WYI9RPn3vNoFbuYaQEwVlInSrrZs9m0kAzjZgWtGKstybxcURc8x0ZhB61MJt4B0DaCNb/CaQXu5TGVlqf3jvu6X0RXu6deLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 20:54:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 20:54:16 +0000
Date:   Wed, 17 Nov 2021 16:54:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v2 for-rc] RDMA/hns: Validate the pkey index
Message-ID: <20211117205414.GA2762920@nvidia.com>
References: <20211117145954.123893-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117145954.123893-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17 via Frontend Transport; Wed, 17 Nov 2021 20:54:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mnRwc-00Balt-Rx; Wed, 17 Nov 2021 16:54:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8170b709-29b9-4f5b-c236-08d9aa0c6ad6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53633474D7EF1DDB93996BFEC29A9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeyZocO6RTRpHXU9M+2sNO0NEUcgRmqRhR3sU5zg4GJI3T3EXD1hC5EMGtiMn3U8MB8oI4RsXxhoS4l9qzefmeRbon1VnlqddKeG7EGsrlvekgiYDui7xjYtaqIsrCNMGhkHAkm/v/lrqE2Q1Mc0Te3cE5B429Psrdol2A6oAHb7vqN37hT18H5LSBzHjLMsiMUFuuWRW86Y+gOAOLO24n9EB4mjMgRHlJtkRRqzu6mcuW4tTjfoyOL3de2whx4HlXNjCOveHzKic56A/cy2x9czcFB6x9jhY+mz9IPPQujzO6aBrkYCf4f9Qx7oPtjim473dmTYIq94TnXgm95J8itf4Bjs8kXekc989FmcadBRMAkdEPQWM+bm+ZasMMWARITmEhbTYfSrnM5K7SMZjQZYyXPdpKQSMcTMFEqlWAjj1T1KVyO6TttTPrpGQVXKfWL1q1D+Qn0ND5XxXW34RtU0qoJYjuT+gfChdu+1NKr1yEdOBjw3//Og10UseEy7Z/MPDXBuDaZxirD6ib6RQ4Q/OxmFhD3RVTNFDCgiEhLVTpVpeACAl9rhs/Ahj64BfkiuMaVgLmIuL1DmNZys9p1zo0WfxjK3dp5Oqbd/XL18/XaKorXFs26LDt1cEFw6Nq7HiRj++GbIGMXxEi2ryw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(54906003)(5660300002)(426003)(2906002)(1076003)(66476007)(33656002)(316002)(26005)(83380400001)(508600001)(38100700002)(86362001)(8676002)(4744005)(66946007)(8936002)(36756003)(15650500001)(9786002)(4326008)(186003)(9746002)(6916009)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yP7gsOwk46VqbUEcgvl/U/apnzma9vqwSdn1hTGcOTlxXpfUMHvN8cVp2H97?=
 =?us-ascii?Q?fvm1bPNKgNan2TThXFE7k6Lv8YiVOteBWWNAVGKvKdxpIDet6zJDZ/WVZYts?=
 =?us-ascii?Q?ES0X5hHASfSNkCI7fmYzLGUrRjRehbspDCh9m7ngDDu4z18rC71bnmVukm8W?=
 =?us-ascii?Q?vGqU7Dyy50AzJlh5j7rR/ANJAKaHuK7upV76merg2vW0jup79XcDyX0rRLK0?=
 =?us-ascii?Q?1bq2fSKS2Tsqd5hiIXEInfWDri7XMQo6lieT23A2WHLyJWCG2wp8tUBXNrca?=
 =?us-ascii?Q?rEl393WcMjxBvIY1k8AhsFaX3LMHyTDTCriTlmuuzpSRJYD5HSKDvt9cDZRf?=
 =?us-ascii?Q?cXbmHcevrryCg0tMr2/w+3tSFh7x+Y7YTxxJV/ubc03GH42Re4BcjGKNIe4C?=
 =?us-ascii?Q?NZPR79K6tBh40Lm8rZdDWHm2XK3F6U2izrLrcRNOpim9s+syRUG/OxSByk09?=
 =?us-ascii?Q?NH0ceQ5/VL40B920QqJ9YKabvQoxfI1OD7EH49TYRAP9G9wWcJYc4vwM6R/j?=
 =?us-ascii?Q?Rxo0LXhKJHGDeuRhBN//+Yi79FefztUiaA9g9QHduSxRghweTD8hd84Mn4Cb?=
 =?us-ascii?Q?BWnRVUb5vYeZnqHtOwHfH/ZJdv6m+17RtYN30JFAVKunc7iB1WFBdCLHR4ec?=
 =?us-ascii?Q?9xC8batCN1sotk+YZl3+CWQDfWRlTyyifE3os9bj3+wWwMsReywViMBQ10FK?=
 =?us-ascii?Q?ljp8EgUES0SOOU4G6RImwdvk8jom7o+z1uQKEEIuQbjJkD1xQN1U2Heef5wR?=
 =?us-ascii?Q?MYDVgY6GqBZSgxQ9oMIRgMWcx4mznUS4qChLaWpxeBA0GA8rHj5ffiMQ2BIM?=
 =?us-ascii?Q?fKdm8H2tYaGnGt4YogHEeZf+xm3ITl9rlKj0pdH4kCiHsY2wpv6QoxJF13eK?=
 =?us-ascii?Q?JXDRVUxxDIcNkWQ2WhBwR4CZBC1xUozIb4Y+OemncgpKCO7mCr5SXe8PT9bR?=
 =?us-ascii?Q?g5dcVYpXCi8hk2La8oG8HWem0IyENigMTgUO4Hd+oMoR+wskMOBlloEgLmHO?=
 =?us-ascii?Q?ePz7zdqKegEWLDNM4a8bZjcn8yzI8wjgh+YNndCXwnvC9aMVBp72R5XpzUXf?=
 =?us-ascii?Q?z1dT5gHwYOCLDs+LfRP/4lZwMgqJrKKNbR5rNxMTozqTs3CP3WCSZSluegdT?=
 =?us-ascii?Q?T1u8vTsp1ztQtDEEYd520OWspqPkCCq6TEJ9j68cuo8SLySgtZmX8vpLZgYI?=
 =?us-ascii?Q?Il3TZ2aqvuuqA9G8Ly/btxDHy5V8ZbEMDhmmRIod1jDlwIO9r+grwp7z7i8Q?=
 =?us-ascii?Q?x/xxlABTCCyK9M7W4tMn3aZxOEOtQMjxJxuAjRq4VFiNzVvKUrkOGsUJsKb8?=
 =?us-ascii?Q?Ftc2rExs5o6FprnE3UjLbtfXygjKYBCVLzmL+9n+34JlgwLLnIL3hZxU7Miu?=
 =?us-ascii?Q?bDuJzqZDAX2LO3IMsN4aCjAd27+065kM8u04/CrRC5uG9Peutu3omcij3Zji?=
 =?us-ascii?Q?CFTuKjUcLZKg/uNTwFhCL8OeIFRUCAfJbB35lz+NGiVdehJq5gHaOwNZrgN8?=
 =?us-ascii?Q?P3mKofgEcNQUF5dKm7awrizud7GkOdknV1rTysLGt0pdfjMPEfNQ7azJaFWe?=
 =?us-ascii?Q?E9sw4JwSpdf3RuEBXKI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8170b709-29b9-4f5b-c236-08d9aa0c6ad6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:54:15.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm+nI8/olemWpQt155eb89TP+aNfUa6KrFDWSRdzaT0aAselNaL5BMEnCAImQUFi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 04:59:54PM +0200, Kamal Heib wrote:
> Before query pkey, make sure that the queried index is valid.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> v2: Fix commit message.
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-next, thanks

Jason

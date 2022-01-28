Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105D549FC35
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 15:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiA1OzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 09:55:13 -0500
Received: from mail-mw2nam08on2047.outbound.protection.outlook.com ([40.107.101.47]:18784
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231773AbiA1OzN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 09:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlyaaGKRWfcFeqnXb0x7zMJU2BSsJINvczuobF/FIrnVsH2utJ4gWCPeBljP/SZpe3+GyfuGEDi7XSPKpZmA6ws4jzEtQVBhRop99vb8s9DmVlX2HtjtP1RfEZEqq0AqEPNpdXvYyU6uwBR4Q2f/kLq9HMf0Lo6eSgBmz3G+TQx36aFL9ZHI/jjUZ3Dagbkf8+xbTuptOqp25yuCFolTHFLy6TK7qCz1ubGMt4HhLik/ENKtamVeu4gaumAZ19vH+OKKxv3HIejO5y/qK2Y/iOyBzYpWV1RCaNRfo4JeJYaULL0Lp0tS8nUhNSPlOxQmFrflzmHpvzUiBJkQC2M/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JA17DC66SXQjDwkyWXynn7+4mfMW/tgjs07C5bUfzw=;
 b=PQ3yaBvapcz/m/DHhdjlJMFmQSqjr03Zi2FMvyGbtyH4YzuZ/457SCbOvDDzQVLWnD1ij2RkhLlx6Kfenv7bh5JX4eHEP60mSBASGc2Rxjh+1NnaShZjVSfv4BSfyWZWYkPasffDExXckRASO8s4h+VMqthHvxmApHGoPraMbmF+yZ18q9WkpoR176z8wgmzTA9HzWIv/rLgEYBDe9GfYr5S2PZkLhR8j6SpY2TUH8u4Wg7rW0JgNtSZGXSJqfvmRbQv5NnVIqkBnC3D+iW+PtxUXA6TNLvxNdbXhbx16TvOOrl3hY+fZwVF6tcKa5c6+uQWuvaZG9ME8t84e981IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JA17DC66SXQjDwkyWXynn7+4mfMW/tgjs07C5bUfzw=;
 b=rypWbcd7MtdHbiBgRUnTDmSDl4OB79uKj+ARJoE6spRoenyhJkOkAeJDulJl/iq8AYjLr8L3A4hpIltjmCPG+iMoiHX53UJuAmTGWNr8kxavMtxVnpCzq44N3IbeOCzUeU5p2LmUApIWyAx8Isx71UnqH+ssurw8uYWFjWtcCViswQ+HTulKkG4bbvLKZBf5XbMRkfGGLh+41D8g3vnA72E5trqtDlgSjAfMuR4vVBeG+Oy7cBCOAaasodouwvUoDczr3M6iMuLXMAjeSEnry7+W5mYCNG5+DbYwsLywJCgVERQY5IeXWPuuGXl2uKRg/lEJl1pYhcD++yJyYDG44A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:55:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 14:55:11 +0000
Date:   Fri, 28 Jan 2022 10:55:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rtrs-clt: fix CHECK type warnings
Message-ID: <20220128145510.GA1792599@nvidia.com>
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
 <20220114154753.983568-3-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114154753.983568-3-haris.iqbal@ionos.com>
X-ClientProxiedBy: BL0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:91::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a4db46-4ada-4838-8c43-08d9e26e2f35
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5454:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54540B70017B3A6A6983EB5FC2229@SJ0PR12MB5454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUKKGrSXNwDTte5IJgy3gmh1otgvx0K4Hk9NYxBfYiZ+ovwnARmeeswMY8XDsOrgWTNkLV5WXHabwl27k8pPlVZYUe82zs3UP7uBTT4u4G00EkaNYQ6tACGjMXxNHyLjRxKLFXbGdeBhplsYMaX3fN4cn9UjGJh2aaxC1yJH0Woev5Ogwrd7P/9tAFt5WpvJx2IP0rzSQ/31dJYYZWVxdfkNW/wcAhU7dbsAD9MSiGcv4Fwsjmj84elC7Ig7qLkL5unMQRXFB+RXfcN2qGUsakg38+VToNnZv9KePf3+1k7VVJVoGckB6LO/xeh2MlAgsOYE5w2zLWIqtULO//yj8NKa+sWCbL+JQgj/UGtvku3XeOuTVweXtJMJC6p4CBMp5mZ7iqw2akVTm5G3aDVUtnKlAGuD/w72w9U2Z8cC5xmZMz4L07j5SziByGaoJzDR17Gsm7ixXGKdTUTkHKs/diIzKCv8zLVXJHv/pmzUw6OHyH5ZbSctjOxF0oxJ+SylmExYt78+5n5XhKvfhY6yfSZo4eqoMKk7OPbnlxZJXZFjP6P3iXeoO9vFyc2H6oYkDGIKTignEYlddSc4JmSr97hkr8zYO6thLz1C7/ZQIDy8lv3IghfFsHeKAj1XTd9Q5j5wDNzdtanvWt+bUNFNxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(66556008)(8936002)(66476007)(5660300002)(86362001)(36756003)(66946007)(4326008)(6916009)(316002)(33656002)(6486002)(6506007)(2616005)(2906002)(508600001)(6512007)(186003)(1076003)(26005)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ss0bA/OamJA8gwJv4IwJrCX4PkntkubQzOA0frNhEHPqh3tcrI9k5sC20hx4?=
 =?us-ascii?Q?b1bH2XUhJ94bjO7KQscO+N/CPSPALtTXqlPhmyZCKCMf+3Fdu3He3+/5ZEhy?=
 =?us-ascii?Q?RKQflu1LO1F9itlAUTnDQuiPPmySDmeccTZyW6cNDoT3hOfMPx/Z2lVr9/yW?=
 =?us-ascii?Q?5ApOR0+HDGPTanQO/fsNAFdJ+Y6dyJsRsse4XkA2rCqbJhoQoRk2VcdJ0M3h?=
 =?us-ascii?Q?iAFaB1eXuSzsDkaz7JXDA38G6qLeQeCs/VTpsydNyYtwrhP3Ck5HC8p8OOKG?=
 =?us-ascii?Q?DUmxlI85xsTdi8lUSQv7S6bQLCM1lWdc4aKtu8jZG4ykGjTXL1oPVFe0X6hS?=
 =?us-ascii?Q?OnexDYW7r8h/2TKF+PXrmlT9UHPJFnqC7waAdFYg5dwR61ONPIUKCrCBgiBT?=
 =?us-ascii?Q?fB2lYIpxWZ2PljWcwTXQFRVECR8tV1gaYi0P3BSJ2m2a1eERXHf6haLll703?=
 =?us-ascii?Q?5/g7N/a+0gw+sHrkqPqXNkNH37Lyx/CWxoBceSmsxqfB85e601CXLCFizLer?=
 =?us-ascii?Q?C9N3ChpEUXY9zWOWPnhVQ9p3L+SIuvQSUTACugcgj1KPJDVfuy1KMq8A3OEA?=
 =?us-ascii?Q?8vV6pM8YmfD79ARLj1pX4Z/8BpjNAqBlbXShl2o4j0elqSDm4GXQbfSxr+Ii?=
 =?us-ascii?Q?+u9qakpfxjsaibg5GSl4RNZfLNuDnUNn81kRIrLZe+liAUfq/2gXxcYQXDAt?=
 =?us-ascii?Q?KnIKjdD9PM6bs3QA8dtS5/CBuKtdCZwKMeWGxTjonmWK4WwTrrmDxDYTvyQo?=
 =?us-ascii?Q?twvknmeujLrfoaaa3jh1S64esCPZKk5ltGdEZUCKSqbHIG/o00IkyZdazvob?=
 =?us-ascii?Q?rMP8jueDrA9GhoiZrgjidYqqCU03lvTgPbL9I/+j6oNZ5bnNOQ9SZTD6QNo4?=
 =?us-ascii?Q?gCCvUoI8tk0aOFzhS+sFldGsoI6eoMsIwqcrPiTfTje+VOcQHyU4C1UHH6Xn?=
 =?us-ascii?Q?0xMA6vH+mDbBGtl9+Na9Y8rUP8Lort028kOoP9rLGpPRsYw2AVlKNBQACuhY?=
 =?us-ascii?Q?PIBgKWRGht7mxt17pXWZb+1Yh1jfLg4/1ZE8oACM76h2vOhBY8L+Mu3E6tXP?=
 =?us-ascii?Q?LNc3JEjAgiwfDLUgeFEtHKA+LsJwrVP90lQGJWLYK43Pi2eY/vzL45jyFVJd?=
 =?us-ascii?Q?7uEWHvLSHGit3OsryG8FQOw5W3KkuuU8YZtO9xlrggLMZ4psCluDsb2Vg5Nn?=
 =?us-ascii?Q?A1JiNhmyKPBbrxuh0A3Npveav6GtZ+8m9vBFtpfOq+ga9AhFT3kccxQshHlW?=
 =?us-ascii?Q?9oqgLYjzmwQUVQpc/HP6KBim4c8vgDN0jo7UNBi/8LJL03qK88QIRcfva+Rn?=
 =?us-ascii?Q?J8kF58mPrA2uJ5NsYtM4Q3qo4an79QNbsqzAIjh7g94vEfHHlbL+F6+4nFdq?=
 =?us-ascii?Q?kuQXO+jzgYzL0LASVJTZV9MrGkfQrEsJqiIG6vMkpG1q4N68TONp1OFMl/Zp?=
 =?us-ascii?Q?j316SX+PgxRvOOkJ8IC0o5BTvvolvpEB3FI5J7RDIjkjhovQQHLoJMJdJmBF?=
 =?us-ascii?Q?UMWE+CMtU21oCqNk8AcAjhvsvgGYSphD8KtVJU1ZL+KY2C4WuDqPZAh+yb1D?=
 =?us-ascii?Q?s6iGUv0eKgrWcSRUhSg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a4db46-4ada-4838-8c43-08d9e26e2f35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:55:11.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyA2+zf3EsAyMcrF6nw5oHzB7dQ4Xl4n4j7j5kP3oNfFlPAk8uDIRZepOmqrhsXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 14, 2022 at 04:47:50PM +0100, Md Haris Iqbal wrote:

> -/**
> - * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
> - * @head:	the head for the list.
> - * @ptr:        the list head to take the next element from.
> - * @type:       the type of the struct this is embedded in.
> - * @memb:       the name of the list_head within the struct.
> - *
> - * Next element returned in round-robin fashion, i.e. head will be skipped,
> - * but if list is observed as empty, NULL will be returned.
> - *
> - * This primitive may safely run concurrently with the _rcu list-mutation
> - * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> - */
> -#define list_next_or_null_rr_rcu(head, ptr, type, memb) \
> -({ \
> -	list_next_or_null_rcu(head, ptr, type, memb) ?: \
> -		list_next_or_null_rcu(head, READ_ONCE((ptr)->next), \
> -				      type, memb); \
> -})

Why not put this in a static inline instead of open coding it? Type is
always the same for both usages, right?

Jason

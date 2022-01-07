Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50332487937
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 15:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbiAGOso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 09:48:44 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:58113
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239157AbiAGOsn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 09:48:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIKEPCfoObnXLBIA6aQw+dQaV5m80uaVootF0VLWD98swQDqj8QOGPIqCwo6bHJ9pl5Q9d/tsPdKl6/K+RxzVmXELcHQameht6hqX2shVHrVcMLlAOSZq6BILtjJW+PXCvDFqjDVE8vDKTdaWNgwFgfAq843uZW9uAdgVDprDAPw+9hdlBhWl0rsWAX2BI9Re2glO3KoJr4NX8eAlD8MBI5dvGeYM7W8Dab1WT51RjxpOeUrgbQrZVAAmRkMhZCoEIMPCgMw/6BU0vq3k0iJ00dDdnhMf1IK4/t3x9dibQT0mfXvQo8f5yEeXX+dEgWXjgHsKJ9QZwBm+hVTFZJx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdaipflTidPLBLBjNL0L1vc6fT3j/NBeBEhJdms59vg=;
 b=QPTxdHif6o/ZsGeURbsv/Q6koK1B6BRQfYqv9QLXCJydm1MfQK42rWhMUYHmSY4wqJP9ClsTu3vlen/r4cJeItP5cPpKJF7gBfQsZ9qoqEKsLeYbruSliUM7yiFJ7NENkxnf8ZzWMWLt9Cwasw32178YZT/97+Zne0zFWjd4YmkzvlhHO1S9FiXahD+ZicfSBEgqijKwjdthlrRqoKpOFk25tB66uyR1ZIaMkzMrTSZbGxDVcudndVM3UHaz6+36m2bCzodq/TpEWsXpzzXZq0kbxUj8aBzKL4ddX9pgk1t0Ecd2V5dd3z0ym9tAYFr/fU121UWJ0RUeicfAdfdxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdaipflTidPLBLBjNL0L1vc6fT3j/NBeBEhJdms59vg=;
 b=lEoz6Y12eNE0ISuCoRBR0tFTgZ/cXAB4ryzYqw/fIeG6xmHLUv5CuRP25IyfuwBhW8wKKTSCpkOSSM/Yqi5XPcofguKrPGxrMGc1Dqo9GjRfsKu3mdMdF8Byzd/CejQD90+s+Wj0G98X1OERPohkESSigtJOxf/i4eT97+U57/6s7bQF8CcY0qmmw42xd5sn6SOkW/aM6fvofUvzNTSGBCUQHS5IAYSUP2x3szepLh86rRE/1u/aZ7JjtIL0uyu+SQbfBks1pQvv6ENgdIG7j9toZNRKJKtoNsJnt9OqwbPLWHYbX+xuHju7iC8CL3/XfSD0swXqZ0Ve8/NxW45EsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 14:48:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 14:48:41 +0000
Date:   Fri, 7 Jan 2022 10:48:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        vaishali.thakkar@ionos.com, haris.iqbal@ionos.com
Subject: Re: [PATCHv3 for-next 0/5] RTRS renaming
Message-ID: <20220107144839.GA3082678@nvidia.com>
References: <20220105180708.7774-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105180708.7774-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: BL1PR13CA0343.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc01e34-b56e-4d90-ebbd-08d9d1eccbd1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51920702498513057D6B2C00C24D9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHh06qUmz8mCP1vWwWU2KVROqPlBeH/C/B1EIuJsu0iQVzernWy9+EgKg1P9Id6yNCUSpXmYHT4cklpRW6mUO5hlVRi3zzSM7+A+fFybU+5pY4yMJfwPn/10xL2LC+hZdegIWIzUlu0C46uda0mH1fjBvMbmRGY1Uw8+q+jpbOKyOHHxZOeZhv+Iw2VgZY55xvkEY/fi3hz3vupi+K45sygef49EydcXeKV36SNiY9uIUEM7nweEdFqB+01bbNpEDcnYq/bL211xAVy16XeNTklyQCydFVPKRe4XfxbkzftStUAPrIgQTXxBofAJqAEA27reEFbMef2WfSwfPafGTu02LpzZTTIbuzR1FaH1B/+QbhgkM7ZEbLtoq8ZS/c6uLXmdm10XocEd5y8cBVpHTq5dTZ7UmCFn1Dv2Fak/9xM3zMIQVC6XcStN5L5ufx9L57MVi8f1peI/yupzakZdwDoVRvVTvur/Mz/l1/0SuPOj3fE11sC8cg9/3+VAAtXfMXgH5xYZJ3CbMKFkqYpWqFaajo4gjXwsOullPZC9KhCNs8wo3cjviDRp5ZR6HTuXhiDPRS7q1OXbq24Q2OXkHQTPSKGk3TRxYofoN6vsfnSyomdjcvScA/Pf2lvcZJ5qGeO3y3VV7ZZYlMtZn/lrRb5OQAYYBC/APjUrvRi28iH02BbfsjSLzY1tppxAS+CCa60lINzgnAZADhB/Z54iNCi3zeZVh1hux28i+iuxq4cNz8iSHHrXrmBaPxmHeJN6dCr5wZfGShg1Z+Pofy2JLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(316002)(4326008)(83380400001)(186003)(5660300002)(6506007)(6512007)(26005)(6916009)(33656002)(38100700002)(508600001)(86362001)(1076003)(966005)(66476007)(8936002)(8676002)(66556008)(6486002)(2906002)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVbFx0kYY7yAahH30pAmM6u3llNa0rBQI66vEkrFzRGcUqrTUk6gIIwLmFYm?=
 =?us-ascii?Q?oUGvp65cR/CDp5fdlyVIydRPpXIPXOmTwfJgzAUXttZ9x9i9czglI0YwUkp6?=
 =?us-ascii?Q?6m8WKyepWiCrKtkckc4G6rMJaJ6vOmD46Q9faD14eQmqBqKtnIqQ64I2DRs5?=
 =?us-ascii?Q?smhO/PdyBeh2960/gxzwhBGZvkmDF+MhOYWKhb0spbsZaicyvzYr49trLlis?=
 =?us-ascii?Q?tq+LEkMqqynIZsJiN7ve8qBKpruZAt3Th8Q1pTmlWbxPQWOztFNPHSDKPh+U?=
 =?us-ascii?Q?Rg/x4bZNGjbR9HfasaYPj2RNYmywS1J5N6svp//e7f1+MMgmbLhhcuCmEVGK?=
 =?us-ascii?Q?qMUm1b8BMgNALdxpkacpHiql1ElXcMLhV/++HVXbE5GWIaY1e45WnXdxo4LM?=
 =?us-ascii?Q?rDN8/ndzAtX4uZ9S4/RcpXINNUdsj88mUTaJZeb87htYkZy0i4becKes0lAX?=
 =?us-ascii?Q?yn6JB4yczn9TBA19QEZhwVwBHLay6TQbstw3P3meESNR4ASn5ppuBlxkZ/WV?=
 =?us-ascii?Q?AxBHagtT/ylCT7ItbKi2E9rZbnI0Xs6gXhKC8ZkVtj9n8AzoFp1zuSDAQhu6?=
 =?us-ascii?Q?8X02cTuZhgt0erv+c2Tic83ldjJOMfHcK50W/KrPbGw3OAkRxSJWJw17381n?=
 =?us-ascii?Q?P3+IFwtICOJNwQw8C+qJQRrccIV8nOq1s09SdHtwQTk0m8MRsNsNX579sCd1?=
 =?us-ascii?Q?MZspH0cjIVhH8wXGTJBBhpNz/mwKsfdIpzo6RZSqQFbiV6ydqrs2DhXXxYsQ?=
 =?us-ascii?Q?OUBaHZP3m4ur3A/6X0MTffMEVjpbH/65BYInkXIHsEB24tS1+pohLiNg5wnY?=
 =?us-ascii?Q?LQP4IA8ImoWJbZhR+UWhcf6N/F4IvElIgp6PTz6uB8ab+McEJle9WAhTGWzH?=
 =?us-ascii?Q?c3hYarraSq3l7VK8A2xEUqQkeQAxiKJusbNSCBdHM33qCrUn1mUM1WYr37ZU?=
 =?us-ascii?Q?5fUehPCg1pIUD1YelAA6Bqp4i1IOcv4IH+fUYb/g+dlZZX1JWsO883+kDDNc?=
 =?us-ascii?Q?XBQIGUeGig/50dchEnoSBHSKaDBU+LFLPy+K0Hmi+O5hhtPdPa+0e5Fh2rt3?=
 =?us-ascii?Q?ogPJBhMdPc/nd/SaAtyPhsPDyakzdt2XJ/nQygZuG0dQsq6WT89Pa2meibrL?=
 =?us-ascii?Q?BvyGabYaj+bnjheqjMZ8fLpItqBhedAlOPhO6EzErStqJLtlXwtM1k9uLBVo?=
 =?us-ascii?Q?4Xco/huAuEsnuO8wDoT1P51cRFDbuzKzWGeYmEtYupsSvHcUTC2xMqS/S28H?=
 =?us-ascii?Q?T241cpq0S6hLEU7WoeM3P2WxQU6nu/Q5YPrNhKBpkkBlfdvjk2ApGATSIDw1?=
 =?us-ascii?Q?mCFVIospRCEtnON4uJo8j28Q7lVnKKQvRghRCrPsnFcUigAjcDKy3k0kRt+T?=
 =?us-ascii?Q?KHl0X0oP2jW9EuOL32XeAbebzkS4jmm0AeDDYD5/mr3mSX2YU1dFVnpajrI8?=
 =?us-ascii?Q?PLEjNk3LzPgmPvNcnbNCz6YJhU0gXKHUv5wi6fcBfnyXyRRKzTWruhPjHcX8?=
 =?us-ascii?Q?31C5lOTmtcnraKQ6ziqpAxIGt/QRYiX1ZuPrkb6vI6IMBe8VL+1x5A5FztJv?=
 =?us-ascii?Q?f897rGk3G8P8QSD3ViI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc01e34-b56e-4d90-ebbd-08d9d1eccbd1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 14:48:41.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMRIU9S8Nt7wMSxaE8VGkMwU1EXiovdDOn9FfpdjC/vzjK/KUF2KzNPEfb8qa4Xq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 07:07:03PM +0100, Jack Wang wrote:
> Hi Jason, hi Leon,
> 
> This patchset from Vaishali, renames a few internal structures to make
> the code easier to understand.
> 
> rtrs_sess is in fact a path. rtrs_clt/_srv is in fact a session.
> This is a mess and makes it difficult to get into the code.
> 
> The patchset is based on rdma/for-next:
> c8f476da84ad ("Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux")
> 
> v3: rename a few more variables in log/comments. (Thanks Guoqing)
> more detailed changelog in patch 2/3/5
> 
> v2: merge first 3 patches to one to be bisectable. (Thanks Guoqing)
> https://lore.kernel.org/linux-rdma/20220103133339.9483-1-jinpu.wang@ionos.com/T/#t
> 
> v1: https://lore.kernel.org/linux-rdma/aac5544b-279d-35f5-6f19-eb0301294122@linux.dev/T/#md5be427877cbfcb1741cccea4d081df09ae18561
> 
> 
> Thanks!
> 
> Vaishali Thakkar (5):
>   RDMA/rtrs: Rename rtrs_sess to rtrs_path
>   RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
>   RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
>   RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
>   RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess

Applied to for-next, thanks

Jason

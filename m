Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE3F7B86
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhHYR1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:27:18 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:31712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233612AbhHYR1S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:27:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lns4/46jsx3aT4/T0LUVko2wFuzlly/ICfPs2msSFpJ7S+I543/pHhtKEAZhzidLTLfXNL5S3hiQFV6vORJTwWyO27zD0cdxdcRWmhKuzW6b8szlAZQHuw56Y3+rd2TbjQC08LiB0gJmuq2LqsoRC4WnTHQWKE9qgZOTrQ2q7MSCnS8Xbi0CS8ljojBEhCopiBhvKf/foEtzo+/Vzhy63WqkwjF9CS/oHyEkqBa3sDfA1luTQTrtcTMGc0YawVflODCVpcTupkInJlqhd+PiPrf3y6P6YmiyyPGlgSK7+pERVi2p+SDn5mGYQUq5CswZUUgs+OT73A7xBZlDJBiyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39s6GmlAeaGF6lZtMqYvb88eQyCTN1HOL54RRwsmIg0=;
 b=O1I4dF2L1NypahM7r76NuoslKxbx7mFT4cT1P2MXFRw75V4UlvSo6HtUx+Z8SU2z6EIBeBxIfA58jcc2wMSc2YxN8klkf4ADVkIYnkoccVe5bFRtOcrmumCo6zhRXrFXk25XB5Uzj35/hCLEDYjjEWO48VfvDD9N8n9Vs61yqcc+jb/VEgqBwjxeRrXaspWZPblRAhOHaJAVr14tiP1X46gq0SCcPyvUDCmLwbs4pueWgZ7zDNK+94rhyWNeMb7mtFQACPppm9YMcd4orVRANMe5j+coiADApAfuRbHWujs6Ke6ApPu1TxK5aw24aslVE9Ydu1NiAX5+zPYiFek53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39s6GmlAeaGF6lZtMqYvb88eQyCTN1HOL54RRwsmIg0=;
 b=qLAnjrvLu0CdFic+sXs1y+vljs7+bT9lrY4JKM39n7k0DF1u0ulvVND1OfC2GX2qT1QCmhHOvteb8E4LK0VdBQmMiMgqSrP9G4sejm/rCPJsdUBn25qQDOodZSzqjnzFEClvNvuSFaKHhSfrm7gQeKPgN78WqDydFNItF3P6lG9WXrpVxM6tuRsKJgaX/7peAYvCdTSPE78i7tefMQ5lC2xgW9omJL9HldbiK6uHSoh5Jt8aSpunHOb+pXFOfWlAuzxh4030bqmgjHj8piDe4jlmxXF60XskXIbwOGrTl3qgGT4nHyvBIUcpgBCm+jg+0SjOm47QisGJlEj+TyVpVg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:26:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:26:30 +0000
Date:   Wed, 25 Aug 2021 14:26:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Divya Indi <divya.indi@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20210825172629.GJ1721383@nvidia.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200702190738.GA759483@nvidia.com>
 <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
 <20200708011227.GM23676@nvidia.com>
 <842DBB6A-9563-4629-B829-329DD344284E@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842DBB6A-9563-4629-B829-329DD344284E@oracle.com>
X-ClientProxiedBy: MN2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:208:178::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:208:178::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 17:26:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIwfV-0051id-Q2; Wed, 25 Aug 2021 14:26:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3abce2-39d8-41c5-c809-08d967ed7a4c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301A98A0F2CCE374CBC0F4DC2C69@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNA3p4CGerReErEBf0vP9aysp4nQJVSm2D/4DRoWMYSqVghSK0ac0b8Lon/vyvmKurEEbHezaFlZqnAXXwVZdwy2tnFaKo2inN6eDuJU51DYM+DQS4NWDDdckAqAdsTOKL+OM9+0KxsKxvIMV0J9Q/GB7Hq1KgLVCcosnWQukpyS9xj3GSsttMQnBQJGUM6zjURq811cwT/NwwVuW5WGqh1WGGSZsR5QzSaaHo92qNz4uN7OZF3z1y/XZWc9nX4K99j+JXvlf+bgRDjbiUm0kTvNM5B1ybKOyBi8oHBCYnBUQZYwchtc8c0qwjdmH2eIkhiSSDhFh0cad+ov3qtRI6Ze+IK4JTa9ECs1KTUuCSR1wK3nJCN/DcPooD7ZTKQR4PM34Chc+3BAixx3KUMtOwxF2Ei4XqXDGc2Y5SA39EkeydYDzsuOO9Q6REvQZlLFl45XL2xtyV8ySeuP+/RUDyIFREPl2LCv/xzSUsR/2H9Dw0ae7m1S7NlH8ldwo12mdxeflC/wpfyQN0PXdB5GLMUjZPi2gO6rXReG4fXoA2/TAJ3lfAQr6AjzWXcIW7PO+sc1JRC5C5Nalqx6uJMOa5z5icjRnus5VdsHWcml8WoZ9HxPub1CCqf/KkhtpkauKRD952SMM0cKLNlfsBn5mSlv36MnHHEg/CosinKq7zYj9dodtlNG/LZb3uRzb3u0ZgEHoUoc23n30bzQTyvHgCxFNeP4gQ903CWvxNxBL1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(2616005)(426003)(186003)(83380400001)(1076003)(478600001)(86362001)(8676002)(54906003)(33656002)(26005)(38100700002)(966005)(53546011)(66476007)(316002)(9746002)(6916009)(9786002)(36756003)(2906002)(7416002)(8936002)(5660300002)(4326008)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmLETMsr9P65sditlXWYXRHxGJUzJc2qOmcvyKkrKNbXhxmQkl1efXPNBVI6?=
 =?us-ascii?Q?Nl3YgjYdDtcNQ3ita8rLe2VfGnPz/0LcfGZpdMi8ymKC7nAUVtd+iH7wUb68?=
 =?us-ascii?Q?0p2EZG2opG4NU3yeZdk8FbpKXV1s60npmNQhgSFavHWh42hvLzzclVt4TPjq?=
 =?us-ascii?Q?vgvAipxb+oh4jcrQ44ak74hCA/OZkWBYQS+maJLh8qTeUQiG/vVxaOpoTabF?=
 =?us-ascii?Q?kTlNj0BbbPYEqmM+nv+wN0ZzCdoLHRXQR133eQ+BF52Vsb4BsJmtIVtcmmRL?=
 =?us-ascii?Q?AkIk2hoIobF1SpzWMjNuORAwqKbcQbpjMe41oiOxbrOU0kp2IulRcAkOuYTe?=
 =?us-ascii?Q?+PDg3NtPUYczIWJTTbD6VPMdIjGz0Kwj7KfdMABdu2woElHG4k9UewfLX7j0?=
 =?us-ascii?Q?qkxblEx4l/HWG9YL0XUcj1a2nSrzNmA1maO40OzxFyYj6XgHAVPcZAGRJifY?=
 =?us-ascii?Q?SAv3OoDHZeu76CZsWt+AmsSf97XFxXanYDn74j2+UDqImEe+GmaGQUUObswS?=
 =?us-ascii?Q?t2nyVGdiR1XiFvkBfDkxo8YWetxe3rCX4QBwZx3v55AibvJbq9J58+LoVsGN?=
 =?us-ascii?Q?f2uUSEj+iclIcgX2ZWHvSzGtTw2c1aGrbS8tqdMFIStMXXPSKpCTFOVUFmbe?=
 =?us-ascii?Q?t0bv4J9D6tSEXJr9aVl5MgwV9YK2fJuOgnDs97+G7GOQNKADhUaX4+Q4m2HC?=
 =?us-ascii?Q?3qsGOHJRP8wZBffR4Vkz8F+Ri4+PwCB/o++3yHA8qyz78pkusqkM7f64+OMr?=
 =?us-ascii?Q?02Srs+8Dy39r8LN0f/kQrMQFjtRoAi6mtZbvGxrKNKFDYMsn51PsbFpu22D8?=
 =?us-ascii?Q?N8ZU2XYxP+8R7BoddjZq7Gq/eCFNEk61HDrdnLseiqXaiL8u4Run9JMTYoIe?=
 =?us-ascii?Q?xmcWtXf7IXzQ8oWMaiYEGo4n1oyoNlWzh3OtVXMORiGuWJEmyrSV+ZcBws+7?=
 =?us-ascii?Q?lPozcMJCrQpShBiiQW7OF5PUJPRxPdpwtIk1i53pPadCHM1lAFI0Lyp++kbV?=
 =?us-ascii?Q?9Ir3kyI4Hb81VkQUxtiq4MnR6DBHqkTH+Hll7nn0iCewDYm4CCG6Q9Lt0gPf?=
 =?us-ascii?Q?2cJgrWuZjdviAYufSHziDYtLYziDwiAqVhWNOXr+d/MGoe0Tq+3E8kzRYjFc?=
 =?us-ascii?Q?ZpOWxIdnG1K1DE0FD5jqbrPr9hr0VxzQd06i1LMQutlyqDZ/PSgU78pLF7NP?=
 =?us-ascii?Q?Qfqkz35pR7FZ7K12ORwFTs13snc8qajF88vU63zNfn3mJ7N4+EL4R5YNgAJz?=
 =?us-ascii?Q?18fm1zR8/ifEzHj6uLj1U98oDSFBRACVVS7cP8Bj185nbsWE2rWnLjRKPhY1?=
 =?us-ascii?Q?4o3Yjuyb03p6obgRFD/eUD3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3abce2-39d8-41c5-c809-08d967ed7a4c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:26:30.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsGMZzhB3iHJtfeSqdNN+YZzk0tlaVWc1i5NTTz9VHivcaH5cpWwb/ZV+z44nzIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 04:54:16PM +0000, Haakon Bugge wrote:
> 
> 
> > On 8 Jul 2020, at 03:12, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Tue, Jul 07, 2020 at 06:05:02PM -0700, Divya Indi wrote:
> >> Thanks Jason.
> >> 
> >> Appreciate your help and feedback for fixing this issue.
> >> 
> >> Would it be possible to access the edited version of the patch?
> >> If yes, please share a pointer to the same.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=f427f4d6214c183c474eeb46212d38e6c7223d6a
> 
> Hi Jason,
> 
> 
> At first glanse, this commit calls rdma_nl_multicast() whilst
> holding a spinlock. Since rdma_nl_multicast() is called with a
> gfp_flag parameter, one could assume it supports an atomic
> context. rdma_nl_multicast() ends up in
> netlink_broadcast_filtered(). This function calls
> netlink_lock_table(), which calls read_unlock_irqrestore(), which
> ends up calling _raw_read_unlock_irqrestore(). And here
> preempt_enable() is called :-(

I don't understand. This:

	unsigned long flags;

	read_lock_irqsave(&nl_table_lock, flags);
	atomic_inc(&nl_table_users);
	read_unlock_irqrestore(&nl_table_lock, flags);

Is perfectly fine in an atomic context.

preempt_enable is implemented as a nesting counter, so it is fine to
call it from inside an atomic region so long as it is balanced.

Jason

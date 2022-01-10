Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0D489C49
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiAJPgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 10:36:24 -0500
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:32032
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236259AbiAJPgW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 10:36:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwyaCqgmXo40wO7A0ToT3B4cwVGjygWLElZuIFUmqrMXN12g0nTxd42NaM8tcEFNr9dg7CbPUXPRMspTBw3BlGQJpqqA8xzVyBKQRIReAS+9nwbPQh4yQP68+03ztl6H2HIcy5cevp70ewKLG06Iz3SHkQ+G8P7GHWWcOLpwateCk/OpQCXYGbXoo877nCC+6RC+6eLgDGhJqhyKourG7z21S8gEO7LsESBWpNRErHUE2hWsK0nS8mIScNmc/OII6yjQ1igXgAJWU0o+IjVW3cDcyCzg9NUBooJcvuZEL0AUwz8wx8IG42s2BLmaX1hMiL/3VBrr6f7ZXLx9H0m6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mryT8EBWbR8gsfQ5vsoBKHooHzoQGX167dKhrIDf+so=;
 b=SZWkaeIqSIveZrGcmDZWn8O4eEVxR842O2WKUIp9OUdqgZiGvKzSQZwnI10U1frDD23e0Wd04MhzmUauU5Mgb7oItBM4NE/VwjQZLGa26o6BuViP7IYP0hPaIMucL4RZTKoV1+wXN1RI91C4WJhXMpB30t/bk15rjl1/LEBQeqnMs7YKC2tCRT2+AOz9iImd9EUYg2/zD0Ib8qDR8icKOAPuYIdDmOpxJm0wwoZrx9Gd5+HrjjzInZC7V+junGxmVrhuG9/yBKmzfkVq1xtWjqm8mFhzpcmRP0s2WW+I2qQ8hxmVNKDBhw3iJFf67Ndiic7Pzr5WYybyBnUvXg+44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mryT8EBWbR8gsfQ5vsoBKHooHzoQGX167dKhrIDf+so=;
 b=QhX3xLdqNkcEnu0p4wT4BIxDDISBgiOSrW/W2inH5Oq3DguWJoqxwnPAvhoqsSSBIco6RwRzSICL5wiNLI1PauA0ZGsLksx6CPYNjcLWkn2fzTVC/7NdkNye+41MUv9TUKXwA//eC7+Eod8oD0KUQ2DLsVRm+aYe6ciAU0pR2/2IHQbFQ6lL+iFWjkcy4vWE6DpILcZPaawsV/ihmFzQ9vFtH+jvwMy/6gfYn7/wXaDQpzaE+snxAkubdTocmhfxpyi41WiP2pChFKmOWYRKGhDo4qVHBC7R1ra7t1Wc4xpP+SA2UuXqpAc+BOtMCR5j0dun8Kd/lQE0Luw3rZEMtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 15:36:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:36:20 +0000
Date:   Mon, 10 Jan 2022 11:36:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Clear all multicast request fields
Message-ID: <20220110153619.GC2328285@nvidia.com>
References: <1876bacbbcb6f82af3948e5c37a09da6ea3fcae5.1641474841.git.leonro@nvidia.com>
 <20220106173941.GA2963550@nvidia.com>
 <YdrTbNDTg7VdR2iu@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdrTbNDTg7VdR2iu@unreal>
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415c4041-f9e9-4cb6-865a-08d9d44ef369
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB515923D56D8202663BB8BFC2C2509@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLU7ST0XVsEHo0oEOohVUQpLGrLLN9+aGbevA8uGFFHiCTPZq9lkSlAaBsIa2j4QpiFJFmTUPbk0XMQ4eJKYUC8g4urqRVuQc4Xx2BSSzUDZMnCcUYI+CY2jf77CEgptUdfUF/s+lK/5HU51ejumamySnQMH9CWQXsDUXVxGAIafJcTfWWNuRmH4MZhlC7PFRs06DceA/Zn0rD3sg9xSyk16hhzAvjWtu4//rQpAMWiFRy78pT8tivkmxNr8ume7ggPfuT3e0zP1xmENWJ+oJhx9xVNxUWFWqPYU4gMGdgNfAu9wv2EHW4A2qpNr3U/6s1yx7RqZbqcGv5XBFQyETYil4lqSPJV4IGbdAPAnHr2OnM8r/+LAksWQvSz43D0ejZwpu4uPBoo5w94bXTzRnBvcLzqpxmcWGsYSEjTea7wdcU0h1Tkd+TQSi83JLpXM3NL7uRI2lcgoO6O+/JLFReTJcFLq1YeyOk4Hk+ltnmIMCSiBnRMAZEkrPgsqwSiidtGJFQFh62xTDNQqruLXPqPRmsGEaS/JWeT1AXZGeEOAci96UE2COysgMmsfa2KhGa+GMDAuIZ1WYw3IV4V3PsR+5D9SRfBTKBm+aRvZWp6CDoTPV3rD8mqWtR8pCh4zypKwAaqHkl3GA0SU+oaaLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66946007)(66556008)(66476007)(6916009)(38100700002)(83380400001)(86362001)(1076003)(2906002)(2616005)(4326008)(5660300002)(6512007)(36756003)(316002)(26005)(508600001)(8676002)(33656002)(6506007)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJZsigCEOHRO/wdYMB58s0pSDsAajJXLioAws1MCXYuzd48TMvIHy17tbvkT?=
 =?us-ascii?Q?IP5iIDwIZw6rI/3s/aEymb9c7TBPfIMYdx7EMcCIcZtlfIwlWSsvBmFfVdQP?=
 =?us-ascii?Q?wGxBhYWp5qIsXY96/HZK9vxR+AjtO/Kt6OuAfycjRq3PdghrPhVyZH732/US?=
 =?us-ascii?Q?6JCvbXUKfP/vq2j1xhZmo2aYTBC3PhOorlh3gQWbLgOfOZI7afrikLQT5/ZV?=
 =?us-ascii?Q?2fT6Yce56Og9AQowZHol1MpBTSMIFnbcfVIwkgQZCkE8DYU8Fy6IrhNP1lVR?=
 =?us-ascii?Q?+amtdRO8UJ3IBx1ECnWHv9o3PXSiBKGkhwa4icvPOGMM1tKSb2lm5v4J1h2l?=
 =?us-ascii?Q?6TZ4tm/KO8j1Twp65OT+PDGL0KY5ljbnjt1vEYzlMzJ+yU4y4vD9QC7JGyQr?=
 =?us-ascii?Q?G3/SiMEHhuDITjBuJRFFBkUkUON7jSL43jkP1xxO978I5FB+vBTu4yigsAw4?=
 =?us-ascii?Q?Zd7L7+UxkIPidugDFEbjJFXQwm+ECjXt2xPVVuYWnSCKbYcT6lZxupEjFxs+?=
 =?us-ascii?Q?ci75z4GM1hzmWOSHca1Ap0DKyyDTZrclfMQgVFLv5ec2Yduyz32FqoYJY0UD?=
 =?us-ascii?Q?lEhOGw1gZoOYDcx29UIFMAoi/Al063zCpNHvRiwBHokpzAdeMznkEn2lT3Xe?=
 =?us-ascii?Q?Jnz3eYcufpxEAOufWCDcdMKBbhb4xox0Jmt4OJUpnINJMkAH9oC5aEv7SRkK?=
 =?us-ascii?Q?Ik+D0YMoqqkrf1I57gZmjqiiG+/CvHn4sdFqt0CLJYVN7I00alrM8VXlSQoD?=
 =?us-ascii?Q?a+8tD2F+tGtrudKEXpKuYD3gu8iyecDSFqWZvzze3g70ddm8SgBvZiHpEpd5?=
 =?us-ascii?Q?ReT5aujimr1QaODPr9pQEvWCgmmOiJMLX7fOPZT8Ac0JJmw140dGuQDFthB3?=
 =?us-ascii?Q?Bdlz3GhDk7FGlV/PjLtjwaN2CzY5oA01SGktX/cNx8S/zfPciwZ+Gty7PGR0?=
 =?us-ascii?Q?h/u/oPMscUMY3dLrRU9volTGfmEoZQsZeeEbvejCkCyJ2BLMl+t1s2NmScOL?=
 =?us-ascii?Q?lVTIN5pjnpuRZTVupViMLZiPVez2N33w8ciB5ZmXHSBGjHi4hTJ5xZpDLWZB?=
 =?us-ascii?Q?FoAxXXOmAc8JFktqg5UjEYny8R2oQKf79E7ShxALjtsJ7pVWGP53wjvdTPKK?=
 =?us-ascii?Q?bi5sZdvPjcEH8V90Or765JFrq8aJkx0E1NX7WlbF1IZBfCcEgy2tu6E3Oysa?=
 =?us-ascii?Q?rbR6qLwHlqVPtGcCaLKqPkUaLmzlA4AcT0KtjLCZN25w5Su3fM3Cfb6Ts0Bx?=
 =?us-ascii?Q?dlczmhgyt/IopvBJlDnszYg8ynlyGtq06YQsalKSlcQiWHDSC2rnpp+pgDil?=
 =?us-ascii?Q?e1J30iQ2E0w63REEIlWX+tPkfOWGBDFpVy0s6qwA+0NP0AZTngg55u2Ip8iN?=
 =?us-ascii?Q?lL53cTTX3Ux6HqqF9M7poAx5EodSzt91mbDMenqZIWA4x7tOmWpTaCPD4dwI?=
 =?us-ascii?Q?+4X8znJUmKmdnLTjJ6HMQKOzGD9pI0bqoN+NatuloAsn24W8jrqQnN7ERqEB?=
 =?us-ascii?Q?J/JorUDDQwXYkum7NKmgkBnk3GXYLyX9HgeX7Q4I7ndArEIH3KchOav09zBn?=
 =?us-ascii?Q?Mc4WydIpkWD8VLWqZ+I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c4041-f9e9-4cb6-865a-08d9d44ef369
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:36:20.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h3hOcyv0D02XiQK0Vcd0hpBnT85HqJpRxuFEqdF2lwyq/DjUYldNYZXV//40FOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 09, 2022 at 02:22:04PM +0200, Leon Romanovsky wrote:
> On Thu, Jan 06, 2022 at 01:39:41PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 06, 2022 at 03:15:07PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The ib->rec.qkey field is accessed without being initialized.
> > > Clear the ib_sa_multicast struct to fix the following syzkaller error/.
> > > 
> > > =====================================================
> > > BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> > > BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> > >  cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
> > >  cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
> > >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
> > >  rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
> > >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> > >  ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
> > >  ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
> > >  vfs_write+0x8ce/0x2030 fs/read_write.c:588
> > >  ksys_write+0x28c/0x520 fs/read_write.c:643
> > >  __do_sys_write fs/read_write.c:655 [inline]
> > >  __se_sys_write fs/read_write.c:652 [inline]
> > >  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
> > >  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
> > >  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
> > >  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
> > >  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
> > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > 
> > > Local variable ib.i created at:
> > >  cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
> > >  rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
> > >  ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
> > > 
> > > CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > =====================================================
> > > 
> > > Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> > > Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/core/cma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 69c9a12dd14e..9c53e1e7de50 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -4737,7 +4737,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > >  	int err = 0;
> > >  	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
> > >  	struct net_device *ndev = NULL;
> > > -	struct ib_sa_multicast ib;
> > > +	struct ib_sa_multicast ib = {};
> > >  	enum ib_gid_type gid_type;
> > >  	bool send_only;
> > 
> > We shouldn't be able to join anything except a RDMA_PS_UDP to a
> > multicast in the first place:
> > 
> > 	if (id_priv->id.ps == RDMA_PS_UDP)
> > 		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> > 
> > Multicast RC/etc is meaningless. So I guess it should be like this:
> 
> I don't know, I used 0 exactly like we have for cma_join_ib_multicast().
> 
> Where can I read about this PS limitation? I didn't find anything
> relevant in the IBTA spec.

It is a Linux thing

We should probably check the PS even earlier to prevent the IB side
from having the same issue.

multicast should never be used in any place that can omit a qkey,
IIRC..

Jason

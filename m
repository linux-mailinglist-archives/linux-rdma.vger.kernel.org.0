Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8A67651C
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jan 2023 09:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAUIkz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Jan 2023 03:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUIkz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Jan 2023 03:40:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6C6AC9B
        for <linux-rdma@vger.kernel.org>; Sat, 21 Jan 2023 00:40:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSyCZjC1wlb5BT/IuAQ5EBvXaLn9DwZPMDAhjG95ZVSBBhTNbZGIQ0iS+dkfjeG9tJrn1CT0SXAl0AkLUkAqu95fFN1gduq2u+1exy0KCp5UnQXkvHkq9/RlSXABWvufR4AgyvGcKC5cXcJhmmiIjl7lNh5cqGl2MusokQAEB8ALz6U+cUbKBOKIOU5BEuUYXdA/SuhFC1HaEQFXq2ntwQc9RIQxDdspauWX4hSaZiFE4hLKrpLo3V/LEghRDgegbKn8EOy9HpjMsNMGI8mLoGXHXSS3ENmAGpP8Io7pzl315rUG7wY1haE71FUhnVD9mpo6/sQ3tkaMk797oPzH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHBCbMchwp9x4tL98FID/C6dQw7NARgj6jutsQN3hTs=;
 b=bUMKME7ekravWbItuQYV+gmf6kDPsWOkWiO8gLOvzXEpizBZdQnjRa50jT49bMvJPrXSCHs+mu58XlLDubS441IdP67nABXHFZ1zFnDbCDwr4JTlZ+YsUPDyz5822j8JXI/xhenog0CpaV/eBHuAZyUayk+MeurWGaKLglNjnyPw5+O1OpZxJG6SiIW6CRQ8Jz2qrt77Nuw7Mycsc11tgy5yzDp53PI+RcrOKvZFvW2lqTFLYd7caVPEFcZb2lhgWFmIfq+LoBKQGY+ryJj+sLgbfFF/WblNJyp3dV0K+7qjxmQvqaugpU2yREVPQf4EwgQTQn9koCZUHSJs7cZKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHBCbMchwp9x4tL98FID/C6dQw7NARgj6jutsQN3hTs=;
 b=F+Rr964xTE2ljUSlz6zd5EK7KPQtbYIKD9NQwp0giBlKHAHkQT7N/wfc5xkAOKsPnbS+eEqn3Q+PdBl3of+KSk55H9BiIfWAZYC7SNES+XlAa10/bpduj6t23Nkzvq5CRBftYNcTQ68f4A9srdx2YRtU2Bd18fK26jEafzaNM4TeNcNDewCTIE6K3RylkUc/YLCpLK8H4li15lo/sCTe0Z61uXllpDzyP0RaXDAVUX4LixcXgAw6yFGKLme+LgW2Bff16HsBYSR8btSz5nJc2i2YyGdDbCUJXHttHwvRd8cM65nQ1DytH32qaGVnSBEOdFjSz90zNnYi8XJwMtx6hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sat, 21 Jan
 2023 08:40:49 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::37c6:70c5:2b29:befd]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::37c6:70c5:2b29:befd%3]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 08:40:49 +0000
Date:   Sat, 21 Jan 2023 09:40:43 +0100
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y8ulCzN2U6cKN0T1@goatcheese>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
 <Y8r/BUdb7XMxwVN+@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8r/BUdb7XMxwVN+@nvidia.com>
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To DM6PR12MB5565.namprd12.prod.outlook.com
 (2603:10b6:5:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3162af-5f9c-404f-36b3-08dafb8b3228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvXV6HCT70tj7WdpDT69yF4+RqIIsTduR8PznhbnJkZYEG3FIvyXYsYT8GwMqvLM178xMwl+jPz2LEGYN9sqxMvITuhK6lrvVTMU/BAdpLZ4ApSxS/C7qyKEB/pnZPWIkMCvcEKEXvHa25+25GpCrrjBbjF6w8EjjZiq/S+5GlsgrvW6iaYDQEY4no/QdAYWvRhFCeSgwK+CX5fKBPvcHGKSBX/xwbLb6WHtHlbUE9pJFuv9jT4veC2QvOAX20qde5W1UokBJHJxy6UX6aJOypY3YcOfYDPwVhuTXvtMXlaYFtf7M7DxKP7me0CiGIrXocbbqzrtpub1cf1SG3jLw0xEK/liiOPsRiC+avlcTUVSRj/MHIT/BLMj9JfDUw4uOAw0GKBF5TTKBe8lHLD49kx+f5TLZKzmLyOyvGmhQNmUW3AOnrnFDcmy0U9YZDBesU2KYxE6WIIJGSpYkb/UUgd2JTCpB6awSmOLngDKUUtP7U7DBsLoy5xzbGrTCVfkroG5QGOYoWSl56QqGhZY0yCAAZbfp7OG+zJqQNiIYOEehCgxoSpELrzrQQk6D/QMKi/z07CUGrIrvjxgboRvf88mRQjJV6L63LO2Yzy8ZoYOupjx3ceEE/GKubzkpLOBhKAAuqenwc+uUDQ/Bt7U32TIEZrJqflSgKkAEmf2mjIp1aSNBfUP34BCWwfKmDOrRxsQf0leSsJxRaI0hR+3aPNUYvQVgrxCstMiaWU6re4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(66946007)(478600001)(8676002)(86362001)(66556008)(2906002)(4326008)(8936002)(5660300002)(6862004)(83380400001)(66476007)(316002)(41300700001)(33716001)(9686003)(107886003)(966005)(6506007)(186003)(6512007)(6486002)(6636002)(6666004)(38100700002)(54906003)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47pAAaPZO/i+DGThWT/8HPEV7ApI6IhnbHsu6hJn8DMTMgO/BGyySV7bvFdS?=
 =?us-ascii?Q?gpyyiA0ATslX/dRzufJteJWbkxPzTZ10UYjPcBx029ZuLWFNtJ4whpgKcIbI?=
 =?us-ascii?Q?7wFniPOqLc5qXEvpGkuYedO1L6DrFK5XlV52sKurNUiHiU5QjZBwTwSu3KCw?=
 =?us-ascii?Q?MHNbgOr226Czc4QPiVe42XTomZ/kg0ah/gcYhD9nbekG/1uabMgwK8DiRgEy?=
 =?us-ascii?Q?t+i46iQyEd+8idmtU0f6+trTXfdPOPMmfl6YIAp0Bcc8WB/6I6UW2DcLgoMA?=
 =?us-ascii?Q?dih96s4vndQT44CevRCU2ZKTjlOVTu+Dp9ea9NoAK3WHfuJps2F1U4lE4oJN?=
 =?us-ascii?Q?ZQkc/YWmJG6Ep606w5/iZHnjHK+KLvKyD3Zs8O+01L3T+kiCd1H9QLVpldfL?=
 =?us-ascii?Q?/+E0FF5rZoDb4Q8UlIl+YydB3W6v9M1/qs8IqD1GlqWgo40bFxN9kt/BkhcO?=
 =?us-ascii?Q?0pAtpBtkrq8tJCDkv5jhPE3g2Nwu3JRO8PKjpPPpBNjXpoawym3kv0dVI8o/?=
 =?us-ascii?Q?ywkhVQBDw6oGsF1DHGd6UYUWVVToJy1nbCg9pQeTQQEO4gs7M4YNRnsSkRdS?=
 =?us-ascii?Q?4liAezIFcm90gct5hu4gk3b2MOv9jCS8+P3KDwypEXykMpSRLbB/jXhJtVe+?=
 =?us-ascii?Q?/0aEshxT3+FYwz3ZE3wLiDBOrpdth+bbv6J4RMoPq45nwZoovnCHKKQDy8tU?=
 =?us-ascii?Q?w0RVaCTQR780uFBD4K6NF+DaWodulPoOiCYqiyPB4elpKvp1SwuF0Ipbvcud?=
 =?us-ascii?Q?xCCz/K1ji4ZjKyW4GljAw3+NZf/WpesLvD1P+h3ErFUQsmwE0B4eYyMIOdA9?=
 =?us-ascii?Q?5i8DuLO+nLMtaOrV+nPI07iRJtrsSekkNGjhH7FLg42qGyUmJUloKJsv9fzi?=
 =?us-ascii?Q?OKpXrYh3aV5q0EOWrZSalsdPgg8E6DYeECayrqEGSRt60W+epGh7SxwsE5wj?=
 =?us-ascii?Q?vAqDlfL6FeCu/caYtvMfCDUEywInsj9/dOjysYYPcwYy/zrJy0q8yQVcGbzU?=
 =?us-ascii?Q?gWFFNWyjVIVFjT9Lz7lQLbSDb6puRtAa2WFhApYJEKSJRUeV2BXcvD4NJT16?=
 =?us-ascii?Q?M/28uk3Wt4EqUaBrzVXArhJHVXRCSZjkiY98xbGjA+p7lsOtBdbbkNE30z8j?=
 =?us-ascii?Q?BsDUR1XLwT8O3vbXxBpghTzB9WUclVDU6Iag+ooHyPQRWOatYlkAzUd4vFX7?=
 =?us-ascii?Q?zGFvdxjsNU5ssmRYSPqCur6RWLzOHCswijrkBGEzJeRrRF/TdR+Fe3RSnB/a?=
 =?us-ascii?Q?EZ2uOb6mtvWmtAI8TOs9I28MkIF3Svf+KfhNpK6ldb3YtqxYuYvAus2YqHY/?=
 =?us-ascii?Q?N4he1+BIqTnd7gRGuwI97pXEyKxb52xQMWTwGuj1EGMXY5c3tWqr5joo8yLA?=
 =?us-ascii?Q?0YOuYt+0geSHfEjKz77HW+8BooUg1fzeU0ahRIxWgJcSCLreIS81jmcF5ZLY?=
 =?us-ascii?Q?5tUMj2X4zhMx+jw+oDEYm8/0Zb4Tm69asHTo0N7/4G/BqDv0D5Kcj61kAz+v?=
 =?us-ascii?Q?ICyPjbAaPNSqnCv4CETx420ulEzK+AOx46BXNI591hOB4Ttq+QrYGf3A8eYw?=
 =?us-ascii?Q?mwiFuM1gyUn4k+MERcZncRRRsC8rSXfs0wAu31A7oYsrxs/z88L7twK7p+QL?=
 =?us-ascii?Q?dX21ShTsCukosb5rERhTEHAHluf6yHXvq5rWu3lVJmFL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3162af-5f9c-404f-36b3-08dafb8b3228
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 08:40:49.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZxUTghxqF78os9OfdqiMfTX/LL30pLz0LoFvQ4s2sFCeXMql5bJOKcM3EujE5z8Mp9mE7RNyVpozAdiVDOzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01/20, Jason Gunthorpe wrote:
> On Fri, Jan 20, 2023 at 07:02:48PM +0200, Leon Romanovsky wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > The cited commit creates child PKEY interfaces over netlink will multiple
> > tx and rx queues, but some devices doesn't support more than 1 tx and 1 rx
> > queues. This causes to a crash when traffic is sent over the PKEY interface
> > due to the parent having a single queue but the child having multiple queues.
> > 
> > This patch inherits the real_num_tx/rx_queues from the parent netdev.
> > 
> > BUG: kernel NULL pointer dereference, address: 000000000000036b
> > PGD 0 P4D 0
> > Oops: 0000 [#1] SMP
> > CPU: 4 PID: 209665 Comm: python3 Not tainted 6.1.0_for_upstream_min_debug_2022_12_12_17_02 #1
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:kmem_cache_alloc+0xcb/0x450
> > Code: ce 7e 49 8b 50 08 49 83 78 10 00 4d 8b 28 0f 84 cb 02 00 00 4d 85 ed 0f 84 c2 02 00 00 41 8b 44 24 28 48 8d 4a 01 49 8b 3c 24 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 b8 41 8b
> > RSP: 0018:ffff88822acbbab8 EFLAGS: 00010202
> > RAX: 0000000000000070 RBX: ffff8881c28e3e00 RCX: 00000000064f8dae
> > RDX: 00000000064f8dad RSI: 0000000000000a20 RDI: 0000000000030d00
> > RBP: 0000000000000a20 R08: ffff8882f5d30d00 R09: ffff888104032f40
> > R10: ffff88810fade828 R11: 736f6d6570736575 R12: ffff88810081c000
> > R13: 00000000000002fb R14: ffffffff817fc865 R15: 0000000000000000
> > FS:  00007f9324ff9700(0000) GS:ffff8882f5d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000000036b CR3: 00000001125af004 CR4: 0000000000370ea0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  skb_clone+0x55/0xd0
> >  ip6_finish_output2+0x3fe/0x690
> >  ip6_finish_output+0xfa/0x310
> >  ip6_send_skb+0x1e/0x60
> >  udp_v6_send_skb+0x1e5/0x420
> >  udpv6_sendmsg+0xb3c/0xe60
> >  ? ip_mc_finish_output+0x180/0x180
> >  ? __switch_to_asm+0x3a/0x60
> >  ? __switch_to_asm+0x34/0x60
> >  sock_sendmsg+0x33/0x40
> >  __sys_sendto+0x103/0x160
> >  ? _copy_to_user+0x21/0x30
> >  ? kvm_clock_get_cycles+0xd/0x10
> >  ? ktime_get_ts64+0x49/0xe0
> >  __x64_sys_sendto+0x25/0x30
> >  do_syscall_64+0x3d/0x90
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f9374f1ed14
> > Code: 42 41 f8 ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 68 41 f8 ff 48 8b
> > RSP: 002b:00007f9324ff7bd0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00007f9324ff7cc8 RCX: 00007f9374f1ed14
> > RDX: 00000000000002fb RSI: 00007f93000052f0 RDI: 0000000000000030
> > RBP: 0000000000000000 R08: 00007f9324ff7d40 R09: 000000000000001c
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > R13: 000000012a05f200 R14: 0000000000000001 R15: 00007f9374d57bdc
> >  </TASK>
> > 
> > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v1:
> >  * Fixed typo in warning print.
> > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > index 9ad8d9856275..0548735a15b5 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > @@ -126,6 +126,18 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
> >  	} else
> >  		child_pkey  = nla_get_u16(data[IFLA_IPOIB_PKEY]);
> >  
> > +	err = netif_set_real_num_tx_queues(dev, pdev->real_num_tx_queues);
> > +	if (err) {
> > +		ipoib_warn(ppriv, "failed setting the child tx queue count based on parent\n");
> > +		return err;
> > +	}
> > +
> > +	err = netif_set_real_num_rx_queues(dev, pdev->real_num_rx_queues);
> > +	if (err) {
> > +		ipoib_warn(ppriv, "failed setting the child rx queue count based on parent\n");
> > +		return err;
> > +	}
> 
> This still seems flawed.. Netlink does this:
> 
> 	unsigned int num_rx_queues = 1;
> 
> 	if (tb[IFLA_NUM_RX_QUEUES])
> 		num_rx_queues = nla_get_u32(tb[IFLA_NUM_RX_QUEUES]);
> 	else if (ops->get_num_rx_queues)
> 		num_rx_queues = ops->get_num_rx_queues();
> 
> So num_rx_queues can really be any value that userspaces cares to
> provide.
> 
> If pdev->real_num_rx_queues is > the user provided value then
> netif_set_real_num_rx_queues() just fails.
> 
> So at a minimum this should min the actual number of queues requested
> against the maximum number of queues the driver can provide and use
> that to set the real queues.
>
Hmmm, this patch does indeed introduce more room for confusion for the general
case.

What we want to avoid is to have legacy IPoIB interfaces use more than one
queue. That's  when we encounter the mentioned issue. So maybe the code should
explicitly do just that: set the numer of queues to 1 when legacy IPoIB is
detected in ipoib_intf_init():

	rc = rdma_init_netdev(hca, port, RDMA_NETDEV_IPOIB, name,
			      NET_NAME_UNKNOWN, ipoib_setup_common, dev);
	if (rc) {
		if (rc != -EOPNOTSUPP)
			goto out;

+		netif_set_real_num_tx_queues(dev, 1);
+		netif_set_real_num_rx_queues(dev, 1);
		
		...
	}

> And the return of a really big number from ops->get_num_rx_queues is
> pretty ugly too, ideally that would be fixed to pass in some function
> arguments and obtain the ppriv so it can return the actual maximum
> number of queues and we don't waste a bunch of memory..
> 
Right. This would make things easier.

Thanks,
Dragos

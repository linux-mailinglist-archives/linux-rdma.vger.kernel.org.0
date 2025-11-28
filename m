Return-Path: <linux-rdma+bounces-14819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A789CC92CE8
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE313A77F6
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AE332EC9;
	Fri, 28 Nov 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgu/Fbfm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378C29D291;
	Fri, 28 Nov 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351457; cv=fail; b=brnEn8WQyDWLkNcq6AujbRaozx57v4inlfW/YJM3mcwSgZ6H5+fSbt5m7sWh202AA8yZz2FW9k/dIaQZNkP0QdsNpbbi+yLPJ8kvKSSD6gP2a+cM6pduJyTJu7gt4CpXHq46TT/W2Zd7vPv2WvSeXyllKgZ4NiX3BwxKBhnPIos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351457; c=relaxed/simple;
	bh=1DPh2fXI7J7WbPpLqHskFPo+GG0XWWRxMR7/LzWjG6o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IYdgasf/JQAFHQsE+L5MvYw7BwJdmBfjbAOkJnLHYnwa4DK6/4dG0I0E+CEReJ2MlcaNq3rWmY2BYt5Cswqxj7oraFHYRLD62MsG5M6kP4wPkuyRPDZay9SbWTuJUwpU+rpL8s+SYomOirJ7pw7eNXI4wWs/fc7G50nmMDWwqxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgu/Fbfm; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZwAzvtIr/mb3Halp0DnImfHXf8YPZG0MvtuSajHP6HrBbbhOCI1kxxWtl7knWYZyRQgbWENPEVeSd+3Ua0tNXN6nyW5rfs5e1CmqKotQH9kr+bm6nIDKhcSllDYvKHd+r7JxIg6nKUKxzva3M4aQPGm5d6DnvSVYi8y7sGO8zN0xLq7NfTzMKzEkKG50UIw+yLf4x1/Zud2JboZcIkUUACAqZKV4HPVSqBPOiBnLX+xzLEeugWAckgPDKCDctBcdDoETqzS2lH84aCMfHuqOjrAwZKIPCiQJeA9LZwV0gJPxc3O1DtsfQjA63kzwqMYsUYai/agU0VbuKvMpw91QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttU2uL8pJ0PEPH1nwT0eXc9Ls4Gl3MSVyg7C7GfMKCY=;
 b=tA37dp5OO1mVxU2lMQeyZiJcMtgEsk/a/xK5ZSAqFe94ArCtNHa/u9F0T7GNwndqxYSKA5O0Heq88IAZvG1N17FYBZBP6ws0lsZRn5xF2W9jVRt8+5SVUpWIqZhdIEDYZaY7UZJH9DazmMdo7J4V4FMZV3HLPBaDvIV/zbn4vsdOSWChFdEDhGZO2mt251rWTA7Sqk148gATz22KlJyNAAQzs/JHxilHSgTTSF942+IK8s6+/19lRR38kYnwOD308hHWCgqfaFzzV8nquTJXvOU+bZTG8iJA3y6Fbw5tZw7j7rd1EzB8RWzA1tIb+rbxO9KRW/mmUI2MGnl9f0SO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttU2uL8pJ0PEPH1nwT0eXc9Ls4Gl3MSVyg7C7GfMKCY=;
 b=cgu/Fbfm6L6KTDLFIBqE1Zh5B1xi9bWJUxu8NRwJvlVs2Z2Q0/gT7Op13JnfTitPOaCYl6u/jtiIWqyS/+am5Y7K3ZnofIdk4DghumkvkC1+lZmZ4sCT5iHJblPjvX1heL1i0YEN4kpbRkDXDGmJLQljUdBGsIh+4YPsZlEAdd80maShptP24neDXV4VHP4LL7/nfGG1VNKHPZC1OU69CVzwJJb0ue5pDdJVBfEF5vDMIZzOQ/Q1UvzF2kKnZWdstRWzZEqjuK0uKXqUPKVxiWZZMNnfyshq4ddzn5b+4xOb11IFiH54s2dA53jCdEXWah6G2/Cafwmju5e/NZVkTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 17:37:29 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 17:37:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Mark Bloch <markb@mellanox.com>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
Date: Fri, 28 Nov 2025 13:37:28 -0400
Message-ID: <0-v1-3fbaef094271+2cf-rdma_op_ip_rslv_syz_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:208:239::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: adc36f7d-c6d2-41cd-3b33-08de2ea4cd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWOvmayDycebI3JiNFer3EglV7EehYAOYMDi3Y12eVW+JPVXotHW3g4K3jmf?=
 =?us-ascii?Q?fXpYubdOcjN4G43/LFPrY+BK+szlved8FDwNYFmO6WB2EJR1yYpyOKUmLJFA?=
 =?us-ascii?Q?IbuF68n/KCN0nwvHE7R4U4c0tvfobAw8ZT2hN9RqbPHBq7MCsY2EmQ/i6deO?=
 =?us-ascii?Q?xVmtefs1UJVBP0aY3YcLvGSCClh7hKjvyL+FSZrvILWk6XDz4OOx+chUkpm3?=
 =?us-ascii?Q?eQ9mqvVFTPe3H6y1e+2kS/6bb24TjnpRthv6ItrqMn1TD6sQqiTY8e+LBPub?=
 =?us-ascii?Q?KQw6QYdYCy3liVAl8MyTRUlIlvceG+sGOhjONeWWtYZG6tb6sLZwsbAQX630?=
 =?us-ascii?Q?j1tRnQhR+j60/716kLENhiKjohDHmZfBraOZY/D+MWztLq6k6VpXxh8Y4hkl?=
 =?us-ascii?Q?4yQzx4+pCRf3Rfk55r8uUSDVN6/SmDaui22SDAqczLBPiCiJa4MgaQNap4XT?=
 =?us-ascii?Q?bapbEQtJhCaliKwHljlGzFfoc3r4/R9zZbuh82RjWU9EfPOwx1vM56AGkKDd?=
 =?us-ascii?Q?qIM8Xk4HocYYrquLyGVteWZ3Kd9deemALKVDfUvQxsMRCdL/mDer1EzWbLbX?=
 =?us-ascii?Q?jrdV2W2Wtno6lJyjh1kY002oXSZ7N7rOownovuih+O1vewhSoksx3BP8DD7P?=
 =?us-ascii?Q?dBWR7VNTHLlkBRu1D7xZPes1C+K1vGJiGeaKNK6Np0b07a98GYX+JnULld0W?=
 =?us-ascii?Q?ALwhyvR1GBK64xw4zomyaHCEjT5GVR98MMh2may2hs+Das+Ad6NDTGBRish2?=
 =?us-ascii?Q?vZaJw4KmgDS4Tw9CpF66k+4DVfraG2qvPLSRdJ8gxr0SeEAo569QQsMat4tu?=
 =?us-ascii?Q?xbo+mE88UTYuri2fFlZSwHysxieUCVhd2penMBv9o+f2SbdyAan5aIDMVWFo?=
 =?us-ascii?Q?GQutHoToJPDGKlyVtRxm2kynit39LYr+ulvlrnNG/yYR7nqyCmW+wqiQd7Od?=
 =?us-ascii?Q?xOqsykdNt7gr6w7w75IePWkYqgIMInJnuT0rsls+R90QDslu/2ARdtQTc3Y3?=
 =?us-ascii?Q?4RH28w0FZHTCsWFDAE51SM7lFDQwTgYVSZcPY7tfWfUXKLnpCqrLbQzRTU1J?=
 =?us-ascii?Q?C63j+hQQ7lF0edvVglJPAiaVAPnMHl2e3kzitu6rpHvn3/kDqXMRSo8S2nOH?=
 =?us-ascii?Q?tPKwTZ2nDeIvHjYdzgwovxRLnAZAc7H1o2peSTpRx/GwEcvd04ywVdcGbDvL?=
 =?us-ascii?Q?L/KWkZ+BbC0hZfWXI1W62FqMlUUQnq4vm4a08WzahsvS7oOF39tH4cUq/QAE?=
 =?us-ascii?Q?RvAyNRS9QyY+Vi/vY56RFmCwMj6egTK2gF0d31olxCIEgBkclr5S/+kO6qFD?=
 =?us-ascii?Q?ktEGJcmFWsmY7iF6l7ap0qvkVmhgq2sLX+mJc3LlSRtooCXXcvqOM30iSZMc?=
 =?us-ascii?Q?iG/OVyc7jbXlJQrCWS2iH3sHdoBuhqLq1gkvSQH+388M5of9rhgCavqx9dV7?=
 =?us-ascii?Q?FYu2gk5znGch3spVL2EgtlBsI1DsPlJRecrJlYKWuGcK63D1qdHzPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1dx3x3iCddfzbcy2Hz6PyR2v4wfS4tqY+7Y7U+FUHERyqe7CRO8P9KeNerd?=
 =?us-ascii?Q?qf4md3FSHDU7C0ZyZXJ+VER/dEvKgmDRHoGSxGMsNG9FP0PC9Dnj8etMGNtd?=
 =?us-ascii?Q?lAYBWNj2cHTvEzz24BEiF54RJ6CyDIBQg3cTgs94uYuTQ2qk2vx3EaKIh+Q9?=
 =?us-ascii?Q?G76+xPvxE+bvKRbvlzf6+gzGkic3EWelR8QAo/wfNmPMiYdj9Bnt7okRvqzm?=
 =?us-ascii?Q?0A095WuMJY9TY2QdyXf8HBMUDyrk/puAHgxfvtnTEEuzJoFp3jCjJaTfJLX+?=
 =?us-ascii?Q?W4E5Rii6WZvcqyuwDnGzDLCXgH7I22J47OsKgZsIuyK+urvGWwqSo4ZKML+c?=
 =?us-ascii?Q?DjQECn1sib/KuBLpyrq3k1W3jJFNcjEad5LXIzQgp7kWZpZnWS2G51uqZK/Y?=
 =?us-ascii?Q?fYAJucbKOtFBgG8ZBFqKbNIQK2v5ZvoKpYv+BUAL+lUuEQFXDxzJV+HPye2y?=
 =?us-ascii?Q?LMq9ElwrUXMmbiKTUVSmE92btwihZMwryPty3l+iw+6pqZG4Fyqk+KBjrOcv?=
 =?us-ascii?Q?l7kAYLjVFD3jnbqpSOB4PBkGzFWOmCkaAVuKu40EfQnJYxRclOFtF6LrTeHN?=
 =?us-ascii?Q?iGxJIHWtWmhwt5ASaIDdcJnM7TGD5JKwGBtRY30GzhlPgosSaaNryuYqcjGB?=
 =?us-ascii?Q?VLWenJKYBeaLrFfPJdn1R6O1zVdUyNH6YKtyzy5fXuAdA6Z34YK7fcBl3pQN?=
 =?us-ascii?Q?QCuHafMWCbepzX3rEiYXUks1Sg25MmXWHJqgaqvAF+Ir902mBaBCUCcnPOcx?=
 =?us-ascii?Q?gVCAAhBb2vkA/A7HMueZDfjN8HV4CnqpMWUZAFiSL3DigdqZBF5oQF2+rQi9?=
 =?us-ascii?Q?Uqg5uIqC7VEDWBh39NOv25hE667ETNuGdOw4+qrE/ev+c1hy1AaW3Oxrru5v?=
 =?us-ascii?Q?09ev+ZISgcdsUKF53TgEB3MeHuPNjCMgzLQLX60NF5xZ7oxrAyLuq9rD7Yvc?=
 =?us-ascii?Q?NwOiQHj4VyE9e0PdJtGg9pagsx2e7hX34ngx4DEY5iYBTGvi6jDTz5CyzCeB?=
 =?us-ascii?Q?Z3x/2XXLr3vZZA1EaHyV+9DJbK5++MZCW3iE9WXdpd3h/KJS1TOL4U8ZCyPs?=
 =?us-ascii?Q?ypNTLkaUjCkt14zctJvR83evMsOidN+0dhQVCWORyO7qlFREmZo3Y3I91BIU?=
 =?us-ascii?Q?mFtzw0Vw7sXuaR6h6TSH4SMpRMIYumuZPlL9/Ql0IKX5l/95b5+dxZIiujfc?=
 =?us-ascii?Q?KEv8CnBRJGqfEqZpLuJ7VagKd+4CzAc+RiiS7o4ooKTMR1HN4QaY07FLURRR?=
 =?us-ascii?Q?zlunVfQ7ci35h7UNba5+/u6sD9e4fIQbQmLFpZPYt607OWorNi/xOhcslMlV?=
 =?us-ascii?Q?zBqn5UgKeinuI3i/DjD7UiEb8bQt+jswomxDyoZcHxesllb3dNj/HNyfzPyw?=
 =?us-ascii?Q?Ywy/73Su6JAIDaCex22HdCPIMU9q5JaYscUvqw4iBOFlnO+9JWhy46wvWKSP?=
 =?us-ascii?Q?htM6n3qoAsBeST/ZRsYVQTgvLH8D9F9gC12rj0Nv3T+UTmWWtkO7E1CD+Hpq?=
 =?us-ascii?Q?Gbb+UBxjKs1CVyHfM76Bc0JKgfQ9All7o73GsRIC/pN0CDwAqlXFPA7pQrZO?=
 =?us-ascii?Q?/D46MlIzry0r7Bc0um8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc36f7d-c6d2-41cd-3b33-08de2ea4cd7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 17:37:29.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVnaXMh/Hl7n2jUysGchfHr+7SUdCNaXQG59ySY5R7Zb0svL9MYbtXaF4xye0th7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

The netlink response for RDMA_NL_LS_OP_IP_RESOLVE should always have a
LS_NLA_TYPE_DGID attribute, it is invalid if it does not.

Use the nl parsing logic properly and call nla_parse_deprecated() to fill
the nlattrs array and then directly index that array to get the data for
the DGID. Just fail if it is NULL.

Remove the for loop searching for the nla, and squash the validation and
parsing into one function.

Fixes an uninitialized read from the stack triggered by userspace if it
does not provide the DGID to a kernel initiated RDMA_NL_LS_OP_IP_RESOLVE
query.

    BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
    BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
     hex_byte_pack include/linux/hex.h:13 [inline]
     ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
     ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
     ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
     pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
     vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
     vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2279
     vprintk_emit+0x307/0xcd0 kernel/printk/printk.c:2426
     vprintk_default+0x3f/0x50 kernel/printk/printk.c:2465
     vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
     _printk+0x17e/0x1b0 kernel/printk/printk.c:2475
     ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
     ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
     rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
     rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
     rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
     netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
     netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
     netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
     sock_sendmsg_nosec net/socket.c:714 [inline]
     __sock_sendmsg+0x333/0x3d0 net/socket.c:729
     ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2617
     ___sys_sendmsg+0x271/0x3b0 net/socket.c:2671
     __sys_sendmsg+0x1aa/0x300 net/socket.c:2703
     __compat_sys_sendmsg net/compat.c:346 [inline]
     __do_compat_sys_sendmsg net/compat.c:353 [inline]
     __se_compat_sys_sendmsg net/compat.c:350 [inline]
     __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
     ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
     do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
     __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
     do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
     do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:3

Cc: stable@vger.kernel.org
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68dc3dac.a00a0220.102ee.004f.GAE@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/addr.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65f3..35ba852a172aad 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -80,37 +80,25 @@ static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
 		.min = sizeof(struct rdma_nla_ls_gid)},
 };
 
-static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
+static void ib_nl_process_ip_rsep(const struct nlmsghdr *nlh)
 {
 	struct nlattr *tb[LS_NLA_TYPE_MAX] = {};
+	union ib_gid gid;
+	struct addr_req *req;
+	int found = 0;
 	int ret;
 
 	if (nlh->nlmsg_flags & RDMA_NL_LS_F_ERR)
-		return false;
+		return;
 
 	ret = nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(nlh),
 				   nlmsg_len(nlh), ib_nl_addr_policy, NULL);
 	if (ret)
-		return false;
+		return;
 
-	return true;
-}
-
-static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
-{
-	const struct nlattr *head, *curr;
-	union ib_gid gid;
-	struct addr_req *req;
-	int len, rem;
-	int found = 0;
-
-	head = (const struct nlattr *)nlmsg_data(nlh);
-	len = nlmsg_len(nlh);
-
-	nla_for_each_attr(curr, head, len, rem) {
-		if (curr->nla_type == LS_NLA_TYPE_DGID)
-			memcpy(&gid, nla_data(curr), nla_len(curr));
-	}
+	if (!tb[LS_NLA_TYPE_DGID])
+		return;
+	memcpy(&gid, nla_data(tb[LS_NLA_TYPE_DGID]), sizeof(gid));
 
 	spin_lock_bh(&lock);
 	list_for_each_entry(req, &req_list, list) {
@@ -137,8 +125,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 	    !(NETLINK_CB(skb).sk))
 		return -EPERM;
 
-	if (ib_nl_is_good_ip_resp(nlh))
-		ib_nl_process_good_ip_rsep(nlh);
+	ib_nl_process_ip_rsep(nlh);
 
 	return 0;
 }

base-commit: 80a85a771deb113cfe2e295fb9e84467a43ebfe4
-- 
2.43.0



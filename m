Return-Path: <linux-rdma+bounces-15268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E86DDCEF2B4
	for <lists+linux-rdma@lfdr.de>; Fri, 02 Jan 2026 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7CEF301CE82
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jan 2026 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1E3191CD;
	Fri,  2 Jan 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jlIoaKpu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156A3191A2;
	Fri,  2 Jan 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377780; cv=fail; b=oxBAXPzwK3sCBTvf6x3dLmo0K9UJvyjqwk5Il54fPvjXGsAUrNC/PUGXClh3X4wuo1oO6OoopO8vCyx/CVKPC7eZLXqPbWe6GrdRFWw+oBibJgsMSBI0PvO+F4j2/0Y3tQ6pYknLtzIz+DrluSbOR02N0D+qWki5sW+DzXrY0NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377780; c=relaxed/simple;
	bh=WK+cMBcvGpBGqr7GJjSCiDhLEb8kckGfY16vhib7xP0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pT/43cNoXOah955GU1eaGgR9+1jUsVOB4uc+UO0JoL2H+xrW7GxpVWW6PocLoHbg8c/SOLxCoiI1HD4oyxCz3tIUnyNnvlHz4zF9jpasUdLPCKqZmYeUTLJpN5kzx8V/tY0PPBCbY+htTsNwtGrPLygKF/l2GBCmodzYfeuH63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlIoaKpu; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK2pXEXaJ54FSC3kVaeUGx33NVQwsAAHiXTPjYYj4S/sWFImOXl2KAK9dwKtDvokUPwjN/Pd/U/0+/Apfyy5IjBv7FNArFrKNhoAYLpei3uYG9cq1+S+YJaTfTo7QeoUhq2KxsH6CnY3X04pN5ZFlmZV3DZtR08XOKL5JiKy2Ad5Qi/B0BumQZOFXL7mE/kxBT/TAzbgP+l3xJ6heYvfVvYPkXmaIlcyke7KRTweW29S3RahaB6s+7ONo9WGVWtcI8S+NjAzEwJgtsONp1vDVW7sxFALtuCpZJUGeifTbjUmvqy+2PulBrukt/eT4/iuwXeO7GJX2F23NkUffbbVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiSPKsyxJeuD1aYDA6CxaMDE6VwbP5XGQAofYOouT4A=;
 b=B1F5I5fJawm++1e116lI2NIumXuuxLAD+qxZo4dXxgDlBzK6nhZ6+S5D1kNCKGfe3ROFCgMtsHQT9lw6TTqbaUj6KnAPJeynKmdJl1GUuHZ8X8WC9sdcHcJ7FVLHYFHlNRyFJhLnbUUtUfv0Cc4ARHR9ZURvGCuTpvMHIxr3iagM3Gi5OIZpATDZT5T0dq9wC3iW7MxUmK98PzSN9bu2DO9dkIo5IwNOLjDzt5j0RvUGGdz/LBM/eKcIRPUXIoItJ3ZxmSZHz3vxgaGePwspBtsuFUP2gRXmocfvIbPDSssaBNekSIzhUAO15u2La9kYd3rQHfLk9eUhUevuM4lfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiSPKsyxJeuD1aYDA6CxaMDE6VwbP5XGQAofYOouT4A=;
 b=jlIoaKputJGhq5+eQez8pJpCkZM5Bcyfuu1iFtWQRPd6Ux/mek4/Iqcjutx3tTN4LtMXDDr4Rf/2AzdJ2clMSVs62qX3FKdkKj/FAJr8IFT+YSFCFzBfMYVftuoGjK2m0j22Qm8VRPlp3435e91641BRd4r/d7PQ5PnFo+TzmBOF1Lktu50GzEBcpO9XwmRmQKr7nE7vWH0KwX/EyQpH7jOSgLrlPOKHJAlj8mwJu1uFJb7UWfc1jOx7MiPL7jx4HUHLOFH6tXjaiXVkfrYekUy6us6/ChCW7bnwMGNTLQw9mjYS++TG5Cfxzoxkl4d8P8Fk2OPx6wm5ZWmWEISa8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:16:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:16:13 +0000
Date: Fri, 2 Jan 2026 14:16:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260102181612.GA188355@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BNoAdkJcrBcx9+ER"
Content-Disposition: inline
X-ClientProxiedBy: MN0P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d71dab4-61aa-40c9-a69b-08de4a2b032a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a3lofcfYCzPNZeCIGMWWzSuv/XuB5Gf4lYUKbUl3rzyqUAOhYileuek8J2ko?=
 =?us-ascii?Q?KpNGePZ0bCR83vFKGdwKNFbwwfCsSgHux814u6kuRxGulZPSqc6CRB5n+qOW?=
 =?us-ascii?Q?mp8aypHe2wEfvX5Jjo0LCAwbWw76014mWJrtfb2GWPxS0bRgT2HdBrZCumn+?=
 =?us-ascii?Q?ukX6vEoAf1RzTPz70lsIsB0eZVeJiXBGSn3OFazFNhoV+1sN29bBtlY+Lp2K?=
 =?us-ascii?Q?x4EvHy5tGfKlpq+KzADNT6rveGv44SIzmsJA6BSeI9ESFcKMOmZFDL3Db402?=
 =?us-ascii?Q?q6+34YwXHbWxxVb5sUJOtWQbNK3GLluTk8W1kyLOQH7mEwwlo7436oMD5D7d?=
 =?us-ascii?Q?8NFrzqhuRqzQpuGXTX2rbaS6ArORx4uZXOswGt3/HwblDs+uFhh6jHwh+KDS?=
 =?us-ascii?Q?E6QjVOpxH3AZOl89mRRWXEkI7+fLGYeXOtDY+acITUmreBrLj57o1NHbBels?=
 =?us-ascii?Q?7NCDtlmAttaQOW3l9kQx82WpGUZ29/h/NGCcF+C2W67h5J1eE023OkHThrgM?=
 =?us-ascii?Q?fYPSial6YtykiWsMEnpnlmsUJElGBGaPpfELIvk14qPpkm5z/h6ZiUY64BFf?=
 =?us-ascii?Q?/thNWbExI+Bw1kQjgWglspuCLW1cjooKJsWEBq5Q8Xfaz8jsNGMMCXRxYHx3?=
 =?us-ascii?Q?o1k6idAYuah2rTovplJB2mWg7vZWWuCXB9TBhTFhITlUfQA3bVRt6wFI9ykh?=
 =?us-ascii?Q?gY89nXpqFHThoyGvcw3j4kcEvB1h8X6a47B/+fbWtodwyelLsFsHb0Or5AyM?=
 =?us-ascii?Q?vksY2d8tte33LOREeaNpzWAvM0h9zcte4K5v5RyAbfbBCA0feEgDe18/UZnA?=
 =?us-ascii?Q?hZGOmgnIughBMtgwdQ2/wVQ3HnQ2dRQQyiKvJCAhJ7K0x8umnUHiqcQZHSe7?=
 =?us-ascii?Q?vxy2zz9uY5tqBo0BRTt8/OKYil9AUdDVbYo29y5/WXI5YnZDAslo9FVLpBFe?=
 =?us-ascii?Q?wTHuboPS+YFvwkKlMsKH9WpkgdP7afd/6lYkM/ZYAkVzdjQIGda7ftdQi40+?=
 =?us-ascii?Q?SiKD0mzl4f2EOrJ1FGU5BIUTLta9n2GFSiSrvrrZ2HrP8yUckPicBPEWChnn?=
 =?us-ascii?Q?OLqSsWbMVuoxb71yLOLefHfXOaCm2qZZoRNOv0b68KyZa9ewpKP0m5sS4DfI?=
 =?us-ascii?Q?pJuN04kllHwjTXfIR4EvoAkCfvzwNoNtFyk1yIq1sWaNLLypzE2Yn9UTasxX?=
 =?us-ascii?Q?Mrlh4xDFCphBkTBXp8I+MB/3LTYFlPxcjSc04TrJzY83xKO9ar0wL9Seefmh?=
 =?us-ascii?Q?HS7+ftLeXY3J9oM8SYgBsq9fBmp8pn83a7chCtoX4WNmyPm155YpFn6RNgmA?=
 =?us-ascii?Q?2HkaA8S3WE83CsAiVlUVls9QbYkzsfALbUVs8go8CvYO86n7FRXtyEICKkpo?=
 =?us-ascii?Q?OF1TkUjtqjp5nmJJJmzMRgb1+RV5QKNMF5O5R9wP7eJwWkmZDrKOLFhMNxiD?=
 =?us-ascii?Q?uKLB3XMmv1QI8pgTbquPGVxGfSRSsfQF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQqslLB2UuQZznX8K++br2Ugih5uSG1MMOorV8IunuE9yL72dvp0Xx3ms1sq?=
 =?us-ascii?Q?mH7zgprMlE2ILyNFGAhiBVU7IjSnqY9ts+ayPBv/DOUaZ3aSMw5Y3jDsy2ji?=
 =?us-ascii?Q?fwjlewJbwygK1pDgSQERT4qUDBKFgZMa0SCmKJZOd/m5tpk7Lbl6vbSLH/5s?=
 =?us-ascii?Q?C0YJ74gRpXGdTjRn+Hp/sKFk5lqBpK1aVvva6rcxgE8nx52ZB0CKHEPlW5UB?=
 =?us-ascii?Q?qM6kAN4TPmnJtDViLmcSVQk2GC+paEcqLvXxCRBMgix5z+pfTiHyZp5Fdroc?=
 =?us-ascii?Q?+gnvqoYXyZW0RdTCqRz6RlMqhSTffVP2i7EPU8sSmHiphJEDOUywmbKZ5i22?=
 =?us-ascii?Q?Nxw6KBYpcwSS4ud6JeYY8JAQDVtCzdAoMrNiVKimpaWsuW4IvzumsE/Nla50?=
 =?us-ascii?Q?Mvv5iw8T8Cf39ym69zXLI4YvO4i1KXWE+ouj+853rKaucNEs5piG8uPaBYEG?=
 =?us-ascii?Q?5ao45aTk8bvmWjmIhzqWpG5ezzj89WmquxRZ1uNvHQM7PXIcS9VTlcFtLT1K?=
 =?us-ascii?Q?smDB0tmm9apbRFg9kaIoRdcS+KbP4MPtT4MFGeiYnd9n+FIAtezIX+3T7e9/?=
 =?us-ascii?Q?yQglJt72nfyAVW+B1oIk/8MKxZLsDa8/x8YKlJjBiFDHrWVZ6wKsEw+9si/o?=
 =?us-ascii?Q?g5iJrEciQs06BRfbVeIdZIah7cOpBLHANju07LyBZAC9OuayLl6womb2RavJ?=
 =?us-ascii?Q?3wFn3CUqvm0vYDpduVrETobSl3xLE9HlKrZmeLjqFxr+jCC+7iT1L6EFIfW+?=
 =?us-ascii?Q?jQOx6lnIBaSMV2TaSm3/JjQFqG6N+xAvawYtCoLVPB/JgDV0L0LSNVsb7YYR?=
 =?us-ascii?Q?/lwT9AhpQM2jvSZgVIgnkFR8ZgGJyxfKV+vUJZ/m1kVbqNT78kzUMtaXIYwc?=
 =?us-ascii?Q?CH/GKQlAqM/3ZyFFPp7bBnPE3LsoWtyBEO0TzkM7zcgwxceuJL4vR3Vmkssb?=
 =?us-ascii?Q?vtFBfiO0n1fGY/j7i9RgqAWPtCUcY3Sr1BE8SXybx9hk3mSpwE4kA21uBzQV?=
 =?us-ascii?Q?Go2k8rYhPt3hst9lvdANiw2b0zdp3RXP7Epvxr9q4KasnphG+xEhHo+5mKW5?=
 =?us-ascii?Q?kkrtZ5H7DA7HNd/d2qUEUzLoFTu7bLW1mPnxJZMKyw13mHBjJCom6EFmOmjY?=
 =?us-ascii?Q?32JnxNt0eznwejHiMfUpbdeSYiTSo4hJ+h3PEFPL+dThbo6H3cmSepn2l2XJ?=
 =?us-ascii?Q?GrV+rJ4kgRvaoMPVraALrbh3QBmFzxZHrCXtW92gGl4yOutaU+/c9g3nZ7V5?=
 =?us-ascii?Q?SG/ya3yCA7ypA/pnuw3eWv5DlLclkBdnkGqgW+tmTRJFrUgdSM8mx5zBJhCG?=
 =?us-ascii?Q?OjTqrwWcsCNBpGt3m/lysVSRncFLvspQXhDbl5bLsdW1VUuD0IGqhiVA33YN?=
 =?us-ascii?Q?gMGr0b9sotaVuBpgvTnD7XKoM/vo+bO4hRoKrOky/d/3fT+vALffNfneq/Et?=
 =?us-ascii?Q?DEvlMeY/54TDSEzQfZ543vb0tVQCS1+O5jV4m04/KyNyXarLPd7fIMBwxIaE?=
 =?us-ascii?Q?u74o9pVcS3oH8QUoOTa0In9AhUiLJBO0c+oGkZ7/msWPdkCRRTIbewglOA62?=
 =?us-ascii?Q?Kfm3yuRPGfNpu9xw1uwEYR4Mh/XqvPlA1OJgP4fKT2GIdZGjabDqv3WhCpa9?=
 =?us-ascii?Q?p3i/xcsC3CJpd8bCIUe1ayhx1Jr4hB4+OXNH3kL7IlwJns0fWiaZrBUBjZWo?=
 =?us-ascii?Q?OuRRwQMsb4dFPCbqoRvRP09Xa690Zv9165j2JQjTCQ8BP9U3r2v55LZGygVY?=
 =?us-ascii?Q?u2etcYyTcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d71dab4-61aa-40c9-a69b-08de4a2b032a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 18:16:13.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bj8MwpRqrM2nFMbRtETmo0VdetwyjA8DXsr27ZAXN8rjMrxnYqTSXtSpj5M05Vm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

--BNoAdkJcrBcx9+ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Collected fixes over the break. We made a bunch of progress on some of
the difficult syzkaller bugs. Otherwise lots of little driver bug fixes.

Thanks,
Jason

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to fcd431a9627f272b4c0bec445eba365fe2232a94:

  RDMA/bnxt_re: fix dma_free_coherent() pointer (2025-12-30 06:45:51 -0500)

----------------------------------------------------------------
RDMA v6.19 first rc request

- Fix several syzkaller found bugs:
 * Poor parsing of the RDMA_NL_LS_OP_IP_RESOLVE netlink
 * GID entry refcount leaking when CM destruction races with multicast
   establishment
 * Missing refcount put in ib_del_sub_device_and_put()

- Fixup recently introduced uABI padding for 32 bit consistency

- Avoid user triggered math overflow in MANA and AFA

- Reading invalid netdev data during an event

- kdoc fixes

- Fix never-working gid copying in ib_get_gids_from_rdma_hdr

- Typo in bnxt when validating the BAR

- bnxt mis-parsed IB_SEND_IP_CSUM so it didn't work always

- bnxt out of bounds access in bnxt related to the counters on new devices

- Allocate the bnxt PDE table with the right sizing

- Use dma_free_coherent() correctly in bnxt

- Allow rxe to be unloadable when CONFIG_PROVE_LOCKING by adjusting the
  tracking of the global sockets it uses

- Missing unlocking on error path in rxe

- Compute the right number of pages in a MR in rtrs

----------------------------------------------------------------
Alok Tiwari (2):
      RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send

Arnd Bergmann (2):
      RDMA/ucma: Fix rdma_ucm_query_ib_service_resp struct padding
      RDMA/irdma: Fix irdma_alloc_ucontext_resp padding

Ding Hui (1):
      RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()

Honggang LI (1):
      RDMA/rtrs: Fix clt_path::max_pages_per_mr calculation

Jang Ingyu (1):
      RDMA/core: Fix logic error in ib_get_gids_from_rdma_hdr()

Jason Gunthorpe (2):
      RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      RDMA/cm: Fix leaking the multicast GID table reference

Kalesh AP (1):
      RDMA/bnxt_re: Fix to use correct page size for PDE table

Konstantin Taranov (1):
      RDMA/mana_ib: check cqe length for kernel CQs

Li Zhijian (1):
      IB/rxe: Fix missing umem_odp->umem_mutex unlock on error path

Michael Margolin (1):
      RDMA/efa: Remove possible negative shift

Michal Schmidt (1):
      RDMA/irdma: avoid invalid read in irdma_net_event

Randy Dunlap (1):
      RTRS/rtrs: clean up rtrs headers kernel-doc

Stefan Metzmacher (1):
      RDMA/rxe: let rxe_reclassify_recv_socket() call sk_owner_put()

Tetsuo Handa (1):
      RDMA/core: always drop device refcount in ib_del_sub_device_and_put()

Thomas Fourier (1):
      RDMA/bnxt_re: fix dma_free_coherent() pointer

 drivers/infiniband/core/addr.c              | 33 +++++++++--------------------
 drivers/infiniband/core/cma.c               |  3 +++
 drivers/infiniband/core/device.c            |  4 +++-
 drivers/infiniband/core/verbs.c             |  2 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  6 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  7 +-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  8 +++----
 drivers/infiniband/hw/efa/efa_verbs.c       |  4 ----
 drivers/infiniband/hw/irdma/utils.c         |  3 ++-
 drivers/infiniband/hw/mana/cq.c             |  4 ++++
 drivers/infiniband/sw/rxe/rxe_net.c         | 32 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_odp.c         |  4 +++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c      |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h      | 32 ++++++++++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs.h          | 24 +++++++++++++--------
 include/uapi/rdma/irdma-abi.h               |  2 +-
 include/uapi/rdma/rdma_user_cm.h            |  4 +++-
 18 files changed, 107 insertions(+), 68 deletions(-)

--BNoAdkJcrBcx9+ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaVgLaAAKCRCFwuHvBreF
YWxlAQCPjOYw33Lgql4DldOK0lDkDvn4eJNMPb/ur+xLnMGoCgEA3Uf/s8yuZNcZ
HlEWtJFOlaxWHNS424+dfJ/huzXqawc=
=gVAc
-----END PGP SIGNATURE-----

--BNoAdkJcrBcx9+ER--


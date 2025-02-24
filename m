Return-Path: <linux-rdma+bounces-8049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD6A430E1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 00:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C343A761D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808161DDA35;
	Mon, 24 Feb 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ScFs0DGh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E7433CE;
	Mon, 24 Feb 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439814; cv=fail; b=HUk+dHZgaOJXq52R0ycWklpal5BL7CSjRYyKQJ/sCwoe2QCeDU7Lji8lSQvvXZfZQJR6gQgCiPfmtvMcMWUWQS9ZGPhqfM8RKkkQqLzO8L0iFXLEDu8tFHOXl5GtmBIXkfSgnv8SidK7IKtDlWG4fpL1u5UnsbtC43u3CQd15nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439814; c=relaxed/simple;
	bh=jIGwvrFumNya11atG7f6bJ3q1khYzd3ZFsX0Kcol55g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KZJ2g0H3oZwOjUeqfUSstznogL1oRA4Eya+148YQMJXs+hBu6kB7tH78D+gy0WIeCmaw5IrQZhTdQurib/mRwwntvCqFJcPEgdozD6G6GWJgvIBodOf0bClyGKBf+BBqHeTg5gbuACrieNRsF1EuDoUCu0heJ0uCokXOgEb5ydk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ScFs0DGh; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InmB0uSzZhnhST4PqX2DK/iv12t8l5e7G+QR+1Dm5BpQpaMeh9N6f1CTVi8vXKZl+DxedbTyUC2PqiDvjLOohmo+qXTfGreOgmjzSf+w9e3gTGiBIWNXWaHzCIKzBcVGR7r9GZFyPyrxtBFxQsSpPj4hD1C0UIcG5tySOAwEU/ORLSESad3P2+wyGkU4R3KzGPgPgH2V23Yxvb4lh3EAGroIp31PANPG6Cfd7rO1JDLteQf+qwPN9k73hH3EkpHhhQXVJa1IbkPjKxrPbR8u5kEpOZid9XP8+Umh0Qw30N7T264MmbQIQ3tDI5HxHcj/aLEu2ghYNJhdB5IEbVTCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0F4Y/DxPgUNAL/f3/B9KkeGnLELYs2fGwKTTEFmbpQ=;
 b=lGEY1oGuuFRkZMo4Vj0chLqLh/cFqButGBmXQVEZ/tsfLrSGF4H0+ch+HcORhTh60mroO8GMGnnNTpKcDYv2b5YmU+WiyPg3yZONA0PtyTSCFbh/58pjORKLgNa5maa8GVpC/L/qbsydce4U2M5lRIICVUJot2fFKKokRp7ANuRJr1UM8aulYLox2XywcMdrJegGvNdcqFZCwOCl/btXRwTdrSfHvrX6vaZtBtAMJGh9VOtdSShKsR3V/UoBJhOkNmtBTrHudpFvzFUZUPdZcehsrrd5S7DA0S9J9TKesFuIuvxEgzZgLz3xk+HovweO+uoJNvrGov3HNJczC+i6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0F4Y/DxPgUNAL/f3/B9KkeGnLELYs2fGwKTTEFmbpQ=;
 b=ScFs0DGhBPfP4puI6AR1et4LnlnwnUic4hnjn93Co1CQ+u8a640ij2GNeWqC6cuPcZLL/bCSUSNA2RutRJ7afqAzmawJKSuVK5eHMDD2OAhEyCbxauLdS4bPFHsk+Y04TPmaRujtLsd7LsxLBz6vCKTzQ8Do8mrclFCZjQgVbKu8J2EuoCDPSU097En6Up+3BgiKSFAh0AvyGPvd9eC/O7IrvKYU1Q+aRfapSVb9ugF7yPKE9hHL30Shz391wup1Ejia+1nZYYPUy4+rl0KBuDcpXFN6dOpBKdsQqUDcLVPnir/WgLfN4CVGGWTsmKQfsEyJ45wQyw6BQtMkBlt8LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 23:30:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 23:30:06 +0000
Date: Mon, 24 Feb 2025 19:30:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <20250224233004.GD520155@nvidia.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7z_NcGWIr3_Dxtt@google.com>
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: ebed96ac-f10c-4ced-d4f2-08dd552b2b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wW2mPyrQOeOX5KSZV4v1M6xw07FBM+5iaaM1rn5wlW5KMgw47quMAL9UbrGh?=
 =?us-ascii?Q?0v/tb04gLvaRgRFFVo/nU8LLrFyLm/VExz7/R4ZjPT7qmtZL+E1tNZJAvPDo?=
 =?us-ascii?Q?0geJ+nebkqmES0PbyivRaKbaidvTWwQKP+ki5EHMZf1mIOxkKdfjMGwnxYsX?=
 =?us-ascii?Q?fFv8VnI870CAVxt1W9acs/79eo68gJxG1lKnRl8ysQf79dVU0A4kOBlJ2yxM?=
 =?us-ascii?Q?LD65lYIYiOvVLc49yoUSVC1TWAIlQXbO1h5bRVK8OzqpvZnVw/TZACPVawsK?=
 =?us-ascii?Q?uUxTAwHhkqFf6+4hbcyDldt+xp4e3tDvpBMoLUsEjjAzBoBEGvkyoEooPc1J?=
 =?us-ascii?Q?VT+qTtecr5R7qAQMdaJAzVmzoTFRbZ0TTmy0ifiOO0OVTs6W1X/y+6wAt5Lj?=
 =?us-ascii?Q?dvQ22j0radY9KZUcVNrDz5wj11E2bKC2rlZU8L54KJ/5IzjLFkBc5E/3dTAq?=
 =?us-ascii?Q?ISbUgx5XCoB4KL/E12qQpG7T1yvyI7ApUMqgjl8Z5Szf/yd8Fc51vekhdEA4?=
 =?us-ascii?Q?Gl/S0iXHlhVC8yzFp8SfTHSJhmcCXcN4bXW+H1RcMMg28YE0H3tPQuYaf+wP?=
 =?us-ascii?Q?lB+j5DvSa+6ClCEl4bVMZDQaZWKuiNNjQRgya9GUnOgZi+DTo/G1XF0vsngw?=
 =?us-ascii?Q?gNNkCulHyTYcUeNAt4fW92IiAnyBJds/khrZCF0Ra7zZ13HpLjaep+t5wA6R?=
 =?us-ascii?Q?F1lwdqQLqJahOLbvbHd7tYhi59sWyEqB7DEHjv+x43RIvCTBrC0NmrZoohOZ?=
 =?us-ascii?Q?ihOMGfoSKbqQMNo3VfB+obu7s+SZw9+QLZKSkhyGvRtX1fWEQiUAiZlyn+Q3?=
 =?us-ascii?Q?H8OhmDmFsCxXge/jL/LUcnuDyqOh4RrOpPE9ocUoqteEfc94v78KyA6Fi0qQ?=
 =?us-ascii?Q?udAzBISKtuTVtn35798L6ANidsVJQqDfba2eJ7ISLOyjigjsbh1yNqw9SjVd?=
 =?us-ascii?Q?0UYXJO7xr4TYfVsT046iwahpofZjuRl73rNzUtxyHqh3lj2wpEDuHrj2UN5M?=
 =?us-ascii?Q?EhZfiKcQzmxCzuSBy7l2Tg9Tg7NhG33AVeqfEdR8YmrPxppO1MEMTXE53A4Z?=
 =?us-ascii?Q?gmfFQQa1WJk3FMCKMel+vI9yNq39IS7mbARspD2TFGih9fw4il+qUb3yikJ8?=
 =?us-ascii?Q?Sua1XxHGkfyjS1pz9oYS6RwNXo17n2nLeTc5Fp2YHmibN6IG6UP85Fy8K1gb?=
 =?us-ascii?Q?qvGw1nMkyGxiF1UomGOsrhWM5vL8k/h4lLnbkeeHCXeKg7CDedyqq2Ty4K5f?=
 =?us-ascii?Q?yteDPyQPdmapnRLBMJTWVzwkq/CH2+8Dv78WY/oI9Jc9Pa/RyCn5QMmCylie?=
 =?us-ascii?Q?FY6DisFfomgAUaxHplXKx6qbiGFI/+XAhj7W8UXkDvMarKcDEtUATAw+v3pJ?=
 =?us-ascii?Q?y4zyOd7gTkqF+rkkjRR4a30aF3Qb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLwr5+rFR+ktbzHuCI9EAPYksWUIopwaheubiUkv3ffDgrqS5aRkJB9EOaH5?=
 =?us-ascii?Q?fRzU9sJhnp54iABhSl2BFus0R1xnrxf8sjdri5XqPg6Bzaxg54QB4m3BY5eH?=
 =?us-ascii?Q?sF8sMXAa5qHa9W80NERHK14QjRD1sMgXICwe9LrdTE6PcRni+NijiDpCtsWJ?=
 =?us-ascii?Q?4ByrCeHSKLwOxECMqEJQD/gSfopTbumzvU4fa8XdookWg4TIwCiwq6KrUP+C?=
 =?us-ascii?Q?uLX9vzV8RASeofAEuP50jPQVQpxH7DfzeYesyykZqK5grLzjK2qzg0ck+WfP?=
 =?us-ascii?Q?gpsDO/1jvemauv7TnkLiUqxf1ThNOBMhjs4ytjlJMIrvHASHkbo9w5wk6nCs?=
 =?us-ascii?Q?JhtDXFG/9Q315BkhfKIOwqg++IORBEUEvbQi2RJY6OPCMADqx98AzuLVYSac?=
 =?us-ascii?Q?sgJkquPTwdukd8zgWr2boj2yUX9BAkUUZVAhAtCpzmjGwhiDQAgkRmORrWJ9?=
 =?us-ascii?Q?IOfaHyMvg8E7ySHXxC8icI7pCUfE8nm6TB8qYm0+Z/TozZrUIovbg2AMyy5r?=
 =?us-ascii?Q?BkMoiaCpTQBwrdttXJzHbNhEsicBnhLP6PuzrxrK2520DGIsFCIjXylmnTAa?=
 =?us-ascii?Q?LKoasY90UPhA4vZ23UbtcBv0kBZ8+yOT9IKjkHscYvAwNPCsFP2ybNt6XGpH?=
 =?us-ascii?Q?Q03L3baJEzoHw7uqyUy/tlCGhhBQhuQtxMJLbxEW7VXK89LdUeRlroxvJEHs?=
 =?us-ascii?Q?UVTD5T8pqyy5nZsfb98ZIT6rycoGbGBb15yPsmEhjYid/UtornO3iIY2DsB7?=
 =?us-ascii?Q?YIN7bHceWswJwvEGWHo8XuBP8nbWiFAGY8HCFF7mckn0X/xF/uyfTbUkLqc9?=
 =?us-ascii?Q?esCfLbCQxnnDrUW46/ip3q9jiHsWRuX4FPr8hNpDWB+V2ddT5xSM/SRIAimS?=
 =?us-ascii?Q?mpdomYhGFbv00kW2XrDW7IX6VfW8WpQViYwAsfG7rQM3cSg5yh2Lgf/MVwel?=
 =?us-ascii?Q?vD9YpLxsSMUx/Y01QX1n6bDs4gIYmb/0QI7c2V4YFQCM8NkR05prSNAistdE?=
 =?us-ascii?Q?RtkjqfkzNaNWe9redZWQh0juiCASiWQGzkc2UHB5zf8KjpQrfz13aC6NTSnt?=
 =?us-ascii?Q?ChCuUkEDtU/RpIv3utamz/Ur8I197t048SXAccdNEJ4GVU2lyt1FjFnYyFb6?=
 =?us-ascii?Q?SkYG4lHpLvmghh3bM53fq0b+ywHXbpt7cCnTf+NRzUlm3yRijYG90vgNU7SE?=
 =?us-ascii?Q?69aU+CHjacVAgzF23Gwo4/V4ZLSxzCqFQvLroor941VueSC1aB3n9zEg6Xbl?=
 =?us-ascii?Q?4dbSFSVO1sRAOQ1wplZAKyZOuOPPmvpXMHDcp2cVxJZVDrwOUosjyJ8OL2ID?=
 =?us-ascii?Q?uObJi+iR9Xx7VwHANJtT5rL+/0BZNlyBMg4EyNG6ajDi9u4mNmSOHtw597zl?=
 =?us-ascii?Q?j4TWIxC9B65GSIjWpGo0AsEByszI55RAy0ILJHozALxbqkUU3d9tBMfnA2pZ?=
 =?us-ascii?Q?xb0SES1kiqkcH2vS0QQtgFnUKrKbSa1JoyRQKiOPkrIylaw72NcZFh8uS/Ye?=
 =?us-ascii?Q?8xSwbyQ2/bWpNBY4IEH8MDHutOOwr3D9aV7xRX3kN/hY9dW8Fsbz05iSjFM4?=
 =?us-ascii?Q?D1wKNnalnIBFAqFImcC0kqNUhk4J3XhQtKNLHVa1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebed96ac-f10c-4ced-d4f2-08dd552b2b80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 23:30:05.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1bCJqD37HWpix2wVMMGGLGrXGEwG/bRILqw8pcYfmkDqV6EscTYHeGLOLc8SGgW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Mon, Feb 24, 2025 at 11:22:29PM +0000, Roman Gushchin wrote:
> On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> > 
> > 
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, February 24, 2025 8:41 PM
> > > 
> > > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > > ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> > > > renaming ib_setup_port_attrs() to be generic.  To utilize the group
> > > > initialization ib_setup_port_attrs() needs to move up before
> > > > device_add().
> > > 
> > > It needs more than that, somehow you have to maintain two groups list or
> > > somehow remove the coredev->dev.groups assignment..
> > > 
> > I was thinking that if both device and port attr setup is done in
> > same function, there is knowledge of is_full_dev that can be used
> > for device level hw_stats setup. (similar to how its done at port
> > level).
> 
> Given that there is a bit of discussion on how to move forward with this,
> can we please merge the trivial fix in the mean time? (Just sent out v2 with
> the fixed commit log).

Well, the issue now is the ABI break

If the right answer is to remove the sysfs entirely then it doesn't
make sense to make it work in the stable and LTS kernels since that
would create users. Currently it is fully broken so there are no
users. Can we say that so certainly after it is fixed?

Jason


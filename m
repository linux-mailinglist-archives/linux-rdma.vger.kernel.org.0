Return-Path: <linux-rdma+bounces-15030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86079CC374D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B04D43033A91
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE433D4E6;
	Tue, 16 Dec 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JkqPXz3t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3728CF5E;
	Tue, 16 Dec 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893923; cv=fail; b=CmB3Z7KV26TtVJ9CzDjJXyNlsdjACqPH9bkGU2uodrct8wPsO0ICZ3b229duApYJdQvRr6CfK27TdWuni+q4nJTb3kFW7xJIpYO0mGEFFDxQ6A/FjMVlyQj+gRYUPUrd4e4cBUtnN3WlAJZZm1ADziWU8ViXtc6HpaOKhQttfdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893923; c=relaxed/simple;
	bh=Z6AYX2v7JZp9vYjl07DZbf4xfNBufntR4tQll8SaEZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b04fR85UV6tlxlVAN5YygbHTK64n4aS2ccQRhYKqh1qlvjoO064yGMFr0t5lBU7JQnS6/Sw00jrdwW+b8zEYZr3pL+pv3HwWHeXNo12AdjVmwfxpsakOjUnoxgB0yCwmDvKd2nke03X5Lwehpac0CFt3MVmVCDdG13kwCnUKTNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JkqPXz3t; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYPdBKIxeTnwxSRIzh2ICYK3VzViNjEbcfTzCQ6b6uC3+VYk8i/scTGhQeKsZ7R0Wl6vT49LMz81utyZx+0WcYHoJpQDrHk30TxqP1fzhe+WjrBgu78qjUm9Ni4a82DSLSyAkGMcEfcdw4eyk8pOkp2dP0BW/HSeFsQvWpEM1jDnbBtAacuCdkTAmX7T8jJCgShfueKMzsYpxJpNEaQH7RmyFG6JCjyIdlKWOwVKPW8yB6ucDmmxQIoJQTnfmhDu4FpGCOch6J6C5TldvGy/bpKf3YvsfiXSYAyV8Xb2MqJCEb+siohz0AU/vWbJIJN2SMs4XnIyw574jY68WNwx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/0tlSGDuSaMTagT6K3ta01ZJXilKQfGqPsnUPVfNsI=;
 b=Lk4RXTjLnvOalX1QLykX7lhOLsv6qbc657hwCthWXOzye7/24GswP2FguErWoXIT9yBVSwwKWoDHsgkEuIVGB/Rvy9dNomuLOVAlaSx0JVCmwZuNeGpIEaKhNEc8bDBGLDRgqFGmhZATM0iKB7u/m8r8kZQ/1Nn7wyLZ3kFZB69pVl7WFQgjqKFY4EV540GiCT3ChSY/apxGoSciSRb8iMQFTUMV+i332G1vpTkzgIkSaldAoyV/zjqbQSXTy7dYwrXPhyJRK7XKksi3WRpCDVTCOAci2Mk6xS8rtZNoq64MgoNgojVS/k9p577ORgFvjYMw5T7pdVLEmOg3b0ANiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/0tlSGDuSaMTagT6K3ta01ZJXilKQfGqPsnUPVfNsI=;
 b=JkqPXz3tIVsvJZEWDhZiCMCGt7wDnUt1TsIPhl/oFEzeLdZFgmAzO0n1dGmd1bN+f0zFEX39DwoqwHwG21rtLL3c8Vgk7903K5r+qs8WREXMSQPSkw1Z3yRlkoHtcttUlVC+4N+WnkrOpmO6hJaSb/tmUOZPRnruzaS6qRw11+X3Y+m+A69lAQcaWm7gv/bBjzzQMnrDYBfGWn/v0wG/Ep7Mcvl4YHhKFMFsBLpwSo5Ososs9mubgLblHu+cBDA8mw2q89HfNDxi9exmhN9XPzXgfLxNKFOZrU+afa8anbbksDXZNU+0M71fzG1QZvhlcD+Aaf1HjsXlregYRxZebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:05:14 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:05:14 +0000
Date: Tue, 16 Dec 2025 10:05:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Yuval Shaia <yshaia@marvell.com>, Matan Barak <matanb@mellanox.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [not-yet-signed PATCH] RDMA/core: flush gid_cache_wq WQ from
 disable_device()
Message-ID: <20251216140512.GC6079@nvidia.com>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: MN0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:52c::27) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: c8471fb8-41fc-4d53-f424-08de3cac2249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M27DLyo7Fq8hcXX0QYlyycPMK7ydhXh5gwTvR8qayGnh0PWARhlm6UZ6nzjJ?=
 =?us-ascii?Q?Fja0/gexx9z/G4I+dqeI2v/g57zwKPkM4mQn/PDdYhvRl5ouPTEB/je+TLss?=
 =?us-ascii?Q?LbaRxEAXPOKjFFEBIm2iD0LpgbTebmk4QrkY6Mqh0qWb7iuI+WoRsIocGlGc?=
 =?us-ascii?Q?z0Jr6+8w7B7lzCbOuGzJJDhtCwcuN4rRBM1tJSutUJvSZts4MTfq8pgGp8Ol?=
 =?us-ascii?Q?sCr8qzegDl0NiRN7jqr4MPkRaCTK5Bytl/UViBtGwXUv3Z77xv1Q67njrEv1?=
 =?us-ascii?Q?Bi1a+0GriZuFC1WnftbBLBKB6UPQLO5yxDQVBgz5Q++00dIPvmhhRZXjYN2k?=
 =?us-ascii?Q?sxW/tY1MC1ZxGmUs76d9KNX3/BxXVDW6+c9ZmnKjZHS6sd+BjLd1fPuOWVTU?=
 =?us-ascii?Q?rBxF28xBeAXkSa2wi0urXa3US14YulIF4JnGdObKLwi8OX/npnrT1yZTvDre?=
 =?us-ascii?Q?7F2sUcSKyxoJ52/pRoiep0aR3Fvd+q+RqO082A7ufwle2nyGf6U0q/gW6z+g?=
 =?us-ascii?Q?thsy37RqCF01p6D7cMXHZ4r5iOskh7F4AFJhih54Rg+jkcmc33zQ9xfjPeO1?=
 =?us-ascii?Q?qNg083QtGyS+qN0embEqRWD0C/yc8ANPn98fNEZ9W+SpOUc/7O5hsnYJWDmn?=
 =?us-ascii?Q?i2QDJRBk0vyE0cmRwrdRtyTPGmsv00OHwQJWEUdJVSh1ypziS/WdVKCKA9rz?=
 =?us-ascii?Q?mrP/P3USL+smhbcCf4ODA+9p+MMg9cYXlRa0MsnDpx0lpy9FBiqEz62r04MS?=
 =?us-ascii?Q?pPgeQOGx70MNkmcvmmvufftLDv4+t6W3s/NI5+BZoTbJiUSHwu4Xh5QP21ai?=
 =?us-ascii?Q?vhvcPfbEskBV/jPpZPnkvi/kdLFeBL0oZOkqSQCxm6bAQPakwK8KHTtN2cz8?=
 =?us-ascii?Q?NV7BFs/ZabW8Oftx3G67tx6Vdd9xobw9lBo64LOzCGkphzzhuSS06Y1LGwIg?=
 =?us-ascii?Q?PQRxWQOJ8pislHpump/6T6DTz4c7A7tK6s0Ezqxx3PdZk/XYjoz5A7f2vpQ3?=
 =?us-ascii?Q?fDY/fNHxErvyfRsdMb9qV8EBF+cZPYD6kA/cyuHkx0lENDWBS+xN/cfl+tI/?=
 =?us-ascii?Q?TDnD0MIE1CrELIuFaD4AnaD/wl4KH3879KKdljEEq+pzhklXmofBUNiZWZoW?=
 =?us-ascii?Q?zxBMOIW2iKCc9k3IXf0nCIgNoaCdwxB7cDejAHyhFuFHkZrtwodZ88GwofxC?=
 =?us-ascii?Q?rl1k/gN2zBJqKdZ9dL8yyZiQi1E3UJ0U07Hr2lbGzq1KGe20oAl82Tv1jkOk?=
 =?us-ascii?Q?W9D/6RQeRbzyZv2KPDnZZq3UkgPjiOgNoEP80D8d3pAth/4yiDeUTpLY8gWe?=
 =?us-ascii?Q?yZI9s9RT3WtUSr/FLwi3KeVpjszN6UraUpAowyYcbkW2XGXaiCJUwydNOhoi?=
 =?us-ascii?Q?BeWjK9jt2JGetD32zPa5dYVusD3Q01Z2NpwACUPZh+La1B0aIzoeI6umg1xj?=
 =?us-ascii?Q?guXuxv1TpDEGjctU/Aa05xQ4J7uBbeMo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FltosFGUfsSbPNstd+VzRtL8Lsfa+WD/5Uiyl8X+qRd95a8cIP6cjsMxw/xm?=
 =?us-ascii?Q?O4TVnJF3nbtSHmmeu6TJgcG3LNpOOZR8Gk+Wf5m0Y+prSsNAoAU5U9Zb/9mc?=
 =?us-ascii?Q?3rHzc9doHHddM8vYAWeQkiKvqEoggSIWChj9llRzLTUB+qA/JE/e7cxRZfYZ?=
 =?us-ascii?Q?S6ckAH5W+jfdPxr2vIZ/KgDJ3f/oRiad2u1E9Q+Sgn8tsoLUQLxrKhBmG8fy?=
 =?us-ascii?Q?aW0zAbMHz6N1ISgC3+thzFMNmvOmHpjC/QU08UFHquXq51FL3zTRzpjROqMi?=
 =?us-ascii?Q?D2NX5LELRgc7g57xtB7xochCUmsbil5U5Hx/OWCqTX/FHcK3c1hmqV22UX5i?=
 =?us-ascii?Q?D0NZ4BLn3MTwrSoSXqSZ+pIIn+pAO0ZMlYMbwIttcJRXcCm+Nds91FB5cXSR?=
 =?us-ascii?Q?sSdpezHAuTVGBdJwrYfLmdXcXbb3ciNpPVWc3Cc0a6MhVKMd6Ws4Sbx4q3KV?=
 =?us-ascii?Q?jAyvqUzoqj8Bg/NbzmNOz3gFWuHSdmOWc7C3fyx5prWyxFn+3od5+I3TAgXw?=
 =?us-ascii?Q?NfKpatK4DJwf7xwtFHkNVa8WBlDqJtjpuvNFLW4umoTJDdvV/ufXL+LbsUKn?=
 =?us-ascii?Q?xOgJuYyQ4lwpHQYTrT4jFU0bqseb6YutAVkDkHQxwfXW4m71YnISM/mgz/Jp?=
 =?us-ascii?Q?z8B8j87GUmwKozyu5ITRyJD1JLODV3wKUcV0U0p9usA93wwjxBYp0AUsCpQr?=
 =?us-ascii?Q?/5wKK+JTMpELUgBeK+Fd2NY/xzHDhf5c5YPxpF6/mn+PUGv3nmuPaVTg7Ef5?=
 =?us-ascii?Q?gbwg+iBdv1sf7hR9PyWVnZ2nKNhYBJwydJoEZ6n6wiZktJkJwyKHUaTMeBTH?=
 =?us-ascii?Q?gabbHONYFy70sQMlLk6K9X5ntqoingLqArYQxoGEFHyTRTE1p65CCxwyo26R?=
 =?us-ascii?Q?fFpDn7wCUQ5c/dwtWyl3JBABvDQo9WTe0fq+wi9wFaJgASfI6GeSwiPuhHtL?=
 =?us-ascii?Q?X3Ym1Q9Yz1N+4S0fIULTHJz0OjwdyZSiWhf8e0ZNCsJImnu5s63gk5OFZTyL?=
 =?us-ascii?Q?2F3414E0/dBIpVAFN7nvlsWXHTvzLJmvnZmGGbOdau9jLE42j0P3dONFeLi4?=
 =?us-ascii?Q?B7zp+8tkrtjXZSYxvzASSb6j2mLms7oHs53+nr4IvPjWbxMfnGI093Bu/jdz?=
 =?us-ascii?Q?Cdu1dG4JQgC6z6Vt2ILBm4sb4ERJrv3fRXoSpD4V545JcwTHaQ/GgoojfOmP?=
 =?us-ascii?Q?cWnJdJ8ESpE5VQEIYWi0Rpz09cM8d8tYbAoXuSsoX2wjgbr/15Xh3HjAOtDl?=
 =?us-ascii?Q?/uI35Qhs71Q9Su9HyAfRuJA258qVIxW2215cQUIhMfJWNltGXmrd+CoQ9vuX?=
 =?us-ascii?Q?DC4jkH020FnFCpTxwtHyYWaw9IeZ5KYPQHMHWzBHvGCN8oqP0K7MhkBGfBjK?=
 =?us-ascii?Q?5PLrAGchgMwuEaHxdZ2/Q1mNW7ju4K1YLv8hqniJrGx9NWQSmrJFANixVt6S?=
 =?us-ascii?Q?QQfB0ePlUVFQk0Fbg7MuSjbT7aaUl4TGcuXTIts+dMiwHil/Xw9SEWg5GypB?=
 =?us-ascii?Q?lvMCi+m3SxbYDtF41PlTHhqy1iAuvXfs9QKWDgvQeGmP6yybGTdcxdBvqqLB?=
 =?us-ascii?Q?puWZfRBbrbsh19qQCRY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8471fb8-41fc-4d53-f424-08de3cac2249
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:05:14.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMItQyeGo81IkMpTGhnsjznqYyQgk1Cty35vhkqGtxK7eIU9P+jr7jd5sdWtvTZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

On Tue, Dec 16, 2025 at 10:29:29PM +0900, Tetsuo Handa wrote:
> Hmm, I misinterpreted that commit. Since ib_register_device() was doing
> 
> 	down_write(&lists_rwsem);
> 	list_add_tail(&device->core_list, &device_list);
> 	up_write(&lists_rwsem);
> 
> , it was
> 
> 	down_write(&lists_rwsem);
> 	list_del(&device->core_list);
> 
> in ib_unregister_device() that makes ib_enum_all_roce_netdevs() no longer
> call ib_enum_roce_netdev().
> 
> Then, calling ib_enum_all_roce_netdevs() asynchronously was always racy
> since commit 03db3a2d81e6 ("IB/core: Add RoCE GID table management") was added?

Yes, probably, it may need to grab the registration lock in the WQ.

Jason


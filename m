Return-Path: <linux-rdma+bounces-11905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A79AF9ABF
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DCC485952
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFDE1EF38C;
	Fri,  4 Jul 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lXtZ6qoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557F2E3708
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653691; cv=fail; b=NgxPCQ68TtP8fvzcD/xooQ8V/9KGKYpMhI8XosFT1j44oe7B8+bBt5HGR3h3r+WFwd9L+rTT7vLEQNdwjJGaIaW4HmnJ1UqNc98ux0caRi1YWwUwpE6Xj33RuwhETWXrIyWauWXj/KCMYYE64Dc4S+chvcz3vi2IwJDwV0sGul0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653691; c=relaxed/simple;
	bh=Y8xCIMtIv4JjVMEtfoztl98wO6uRn4DRvRHiDTni94s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta/WvgAs9u7VSPE6Hwx7NQCifzJuiIYFb71x9sTVYL5EkUT0wOKdEDDKf85V3ogAVA+0WbRm81GCsrv4Y/gE0fz8omOJStkmtEEoKjmrAWXTvWUeyXPbrH1hn9iXdfuB+HtIt4vhCp/FDX16cIcf0nfAHdtSWkL5DgZia+y84J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lXtZ6qoH; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+5gaYE9uWCP6/oLcQ9z4g5BURt86hiEXQWVSokaherc7rNI87+1zm1RQGu6BtF3QNZbjj2OEVuaZSh3yQZeU7Vxsqigb8VJV6JBqts38gTGupsCS9JdZELWNV7cLoIQ7xMYVKx+3kUkU/L2F59IyvpK1A1/leZuLugAdTnVIPmPPc/LIwNXmerb33V76/jASqWAlwizD9l9NJeqx8ykvSm7K6NXhubSHK07ZZTaGpAwoluYMszH+EEFJx0OBAbW725QdoGOVwAVv86lfhCNFqhVzzuukFZJ8nX/bv2z2wOrvJm1GlcUIWMaYyQOzz2rWpnmiHh6BN1jRz7KfIpHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya8J25xk4KEGmqMZPT+QQCE5RIM1g9DauuHb+9YPT+0=;
 b=HMQQa2a1XYJVU/YmBx/J6zYs6N4JNUYaKmrqtub/lsn5LbfTdhqPvuik4YCBl1avbUbH9D6jad3/k77maJdTK6Z/Gvy0XTESwazlMjpX+DzWmHc2qcMrcyvdjY7O7DP05ldC7R2zLmirxqo2VNtWcTnWCroCnrTErt4m6uCOvPm1tbqo9OqJ8EP7qNBy5VU/jyIulaxFWgiupFKPIvrhrDs2PpS6DHOKtiOuk5dEBVkenDPbpEllt2rywdtT3gkZEvViLHPZkWUTirsdK5DX8QXVj12+UAjTl7xFJHrbReK/Vl5UJTwZJz1U0cPpGw6DJeg4taeF2TXa3yir6n3YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya8J25xk4KEGmqMZPT+QQCE5RIM1g9DauuHb+9YPT+0=;
 b=lXtZ6qoHuTvc6UNzPZ+AG57vMsyoezizreRBgEpvAe2ADVwy2MkYA4BzU7LNkf6qubxNoo1ZJaqM5IZ+Uk231nXYZwaaSiiv4gZ8H1PcBuUKRHlsuVfN3F7fhdtJLePWnWL9zPhhuRhKZ6mlYMCOI50N51K0KOPYyoSwdt73DWsFRg973V0SyRSuXwsjBzeHqnQVEeeOkOQoIha/AoE65GnOArCYwaxzsdlZn12Zme04hSWQqNhNZSRKXf9CD9qaaOOM/IITlbG8wypiwK6hYYFtoyFL9gB3/cUOGY29AjbL269VPpeWsopfDwcG88FsdR2I29grtUPwPO95EKWlkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 18:28:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 18:28:07 +0000
Date: Fri, 4 Jul 2025 15:28:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Add CQ with external memory
 support
Message-ID: <20250704182804.GR1410929@nvidia.com>
References: <20250701231545.14282-1-mrgolin@amazon.com>
 <20250701231545.14282-3-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701231545.14282-3-mrgolin@amazon.com>
X-ClientProxiedBy: SN7P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acc77d3-05d0-477d-6125-08ddbb288551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsrGEp17ka/EwnW6UBLs6A5yVvEFG4c36G5LsxTgtXmcFb93FqQnKG+h2mt7?=
 =?us-ascii?Q?rd78KESeEnpCqa6sVsbp9e2wqhPEt8RS72PnhdVs8khtTzH9Jbb+Gn1CqeXk?=
 =?us-ascii?Q?6HHOy0EdJR0lZcwYBEZ+NT7/DbIgNnScCCdVPR17lOH+SPqrK6wj7P883MQr?=
 =?us-ascii?Q?sL39PXrN2eSz6QcLOyAu85Bs66onf/dEOPSTHvyBWrNCwcKxUikm8gy8wkmg?=
 =?us-ascii?Q?0y07bL2Zl1TPEL8pPDR6FhG33Qputa3xJXd0rFluEQxStIo/ckC+qZHf1NZj?=
 =?us-ascii?Q?AEQIuS1hd28+0d851odI2lhiD3peBHG6N5ToRnE8OKSxDNgJyzAjLR5lpwm/?=
 =?us-ascii?Q?YQRuzSrXu2GDuldKgUsjz8jnJADhRXjwWXIU98rsY8gOwmZv6t6Y5y7mHUhp?=
 =?us-ascii?Q?O5RVZwOn4h+qDPYpXX9qc9igS8kMB4yRRg6gLXvfiYgUco/TfBkDu3dhpevT?=
 =?us-ascii?Q?oxkPZ/ZafDel8kY73YnFwZmJDuFMsK9pYRLJw93agHgyibeypUL5iv/OJ7ft?=
 =?us-ascii?Q?L352JtmhwAqB7xzwmdmYTTsTvIDTv305TUjP1P//hEF50VphjAQJr+mq5CCQ?=
 =?us-ascii?Q?LKzBetaRdgMCRIDJMc6rZmPQkPP35G4KIf1wIOL3Sgdl5Zc2tkHWODI4Fn4M?=
 =?us-ascii?Q?vjO3SF5a+fbcuiAtQFO7Zyy4O+DqNcbRsEVNL9GAx1xbFVyTlhPE9h9NWjIl?=
 =?us-ascii?Q?rTbTqfp6vxP9vw7dVYoi38ZmU1rvL0gPSVGMV4rCCYibXDNg6/lARWGixzzz?=
 =?us-ascii?Q?Ok214uklgmsEeNBnrYbwlfIq4W13IhEjTXKQLafVer9YA4e/MFAlI3xsiDTL?=
 =?us-ascii?Q?bvikHaXeS2Zk+Zo/kN7sxk1d7M1rH2kk39pg6PQhLLZ4T3dc6J7ijXf3XxsD?=
 =?us-ascii?Q?HnsX8dqe73u5FEyOXoc+eJq2eZZ0nWGIFaX/6M2wOQnF9pL+/1kYG/amL5XN?=
 =?us-ascii?Q?7tlquMi3vujL2A/yz+mWobzF/1tfP1h9VdI+i1xOL9ewjFpdZD7mkdBTqzox?=
 =?us-ascii?Q?tejlSiSMS/w0/MW+NgnZEeOT+BVmpUt4Vz6i81IUHhVZa4w7ti4Bh+5hFFwp?=
 =?us-ascii?Q?0sE6ZDEM4JX7RaY2tKr4mp2qvGhWvshi79QhNAkSv/vkWJG3NE1kzYXhOcJe?=
 =?us-ascii?Q?cWUnU67OmoBnob4mMzpwb8a2CGAX6SS/6Z5iQV1fWtfTU+l9Fzmd1tN0OPp/?=
 =?us-ascii?Q?wC2ISKOBV3y01aTMCA9Dp3oXJUfDjb77Tj5/8kX+EpowB4qPSXnk5RAgbj+v?=
 =?us-ascii?Q?WEPkXqxbUVvWCeqHer9DoFPE3derHIZ3vZkrNRTrxftor6CLy9N1mKnw4Opw?=
 =?us-ascii?Q?dRSgHRfg/i8hBifazTYiKTVsC/8WDsvK4BOv7tW1YXeGCqdGdSeiuKEL71oa?=
 =?us-ascii?Q?P6EMQqMC1yDjDzZ4jMFTQVihHRImOP0N11bf0bEYmD8NhO3t9PzqtXdfqo2n?=
 =?us-ascii?Q?MLF10pe1Du0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+lN329S1/1ZDnDFvwvWVUij+kl8oVcT2tivDYGj1Yl54X3v0cMJJNepAwiz?=
 =?us-ascii?Q?OpvE4TQlZX1yWLpT1mTOXcw66gt6t2xhCTokHmQBRVU8NnmVIcFD3VIs5Ymq?=
 =?us-ascii?Q?3cVV0BIbt5q+s1osfoPgLBrPuSeAT3CYlKHn4WuaklF/K56IhAEyj7F/MERq?=
 =?us-ascii?Q?8fUxiDZb9bvkaxEpow3WhCfdf2mccI39lb4WFZlX+uXbDjdpUCL38qeWNCwV?=
 =?us-ascii?Q?rPJvOmwxlI/XYru2cCiqkrYaHtW1noHgwCS3ijUr4canvye9qrs+3UFrq90c?=
 =?us-ascii?Q?8FNxIZMPbGwSiqvXbVxQmMT3UDOoFUlb9gkqLC7/wbVuK7YTRAzU3WtOt1Cj?=
 =?us-ascii?Q?ryEBgVckkanuqLGxYC6GAdm6fW1mPb1Bo4Mio0BxYUQHkBWiA6YTBO6yFRR5?=
 =?us-ascii?Q?sdDU+UCXYRkCxGFll0NDWY/mQUrgdRVGdybzwlhgX40s38xRplAQRtCE3TUL?=
 =?us-ascii?Q?iQNkihD08zJO+tIKeDSLLH5rUqWQskjBkzI7K5ctHohfoBvxzSKbiZEefkms?=
 =?us-ascii?Q?afQhQLWsbjQ9Jbolz+rtyy2MDfEWWqn0umqZEfwN3fi8YRr0gwcw31cnHkPx?=
 =?us-ascii?Q?A91EuGODQvjYNhYtz94fgTsEpk5FJkM860k5LKrGbV56J6poqz5iYs4IeutF?=
 =?us-ascii?Q?58oJ9FCn8Bdwj5qaKLkJNBU5tdvvNI+9vSnHc6Pc5A8A9NbY5l0c86IdhIH6?=
 =?us-ascii?Q?tiTTqYMXL3cJGkBL+i1or179sMku2xsLYgCsvDPEk1oDw1pkRf1/iCICOn19?=
 =?us-ascii?Q?IDOZ65XBMyVLL1wbXkhfawcIdoC78l7fpxFDiHEGzTmReWHLTp8mt0SqDu1u?=
 =?us-ascii?Q?k/zEjU9ri99VOseRGA0zlOBP9JTSHjYVN1gEDFu47aYVXQesPQU4srKUIq6B?=
 =?us-ascii?Q?QCJKtWVKnKFoGF2B9/6+BrdORe7WteS7SIJT/SfJgX93zk3FBai3dAJVyedz?=
 =?us-ascii?Q?EZeVoOzH6CiW9fJiqauJDVcV+3Z3yQKlxOqvKMaXoYQfOjeMLVrdOlUn+NSy?=
 =?us-ascii?Q?Uav0b7UWGS0GIpf6rA8zCiytCGJ7Tx4oO+V7fUwC4DLlQOzkuWlsg0j5BWsk?=
 =?us-ascii?Q?vz0LaTYVfw8Y2HSS9zMUwWe5zH857o0j2t11WK+0Ltjv1kj1msvEdC0CazQf?=
 =?us-ascii?Q?55DbOlS8jCkuTjzxcoHNSe0AN3lzFcKyQ3OgX6aP5wJlEOz7ax2WLwUHq5O5?=
 =?us-ascii?Q?tx8RXQsyjONrjimUa/Elct0XS9CxKkjcOo47ZU2EVmOPV3Ku+z7rDDLP9NgI?=
 =?us-ascii?Q?Rx4R6HGUFXobTxJ1RSeaLMB2iddQiIXWO0/KIKMtduSBPjL27MFF20EMCP1d?=
 =?us-ascii?Q?87qB/fBppZb72LKSZaoJkHpLRf+Q5zL5sOIU713o/zq+OxpJ3Aw1CUc/A7n9?=
 =?us-ascii?Q?JZ1QjH0M16HRhAH7qfviplCnEBqe5O9FZpJ+GsHtZxkiMoHW/PgGproKrFCk?=
 =?us-ascii?Q?e/B4reP1Owx1/dkJx+O6k8B8o9ZAPG1fhs1Z2OupFa6cMVSBzU26EgLjouqA?=
 =?us-ascii?Q?foLhmm7Es7Zs4KMaL2/a3PYTD6R2CtT7jd3WVSzTtW3rMZhZLVlcF4HHcuRl?=
 =?us-ascii?Q?w4K4yLC1k5bxDNdfX9z1oxwLRSENnmg5S8XUNWYE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acc77d3-05d0-477d-6125-08ddbb288551
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 18:28:06.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3Q+WFzgds5Is0J4FPCUwRbLPt701z3n1zEyGsLOlCjfmYIxc1nC0ZpxZzNzAkh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

On Tue, Jul 01, 2025 at 11:15:45PM +0000, Michael Margolin wrote:
> +	if (umem) {
> +		umem_sgl = ibcq->umem->sgt_append.sgt.sgl;
> +		if (sg_dma_len(umem_sgl) < ib_umem_offset(umem) + cq->size) {
> +			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
> +			err = -EINVAL;
> +			goto err_free_mem;
> +		}

I'd rather see this call ib_umem_find_best_pgsz()

Maybe like:
  len = ib_umem_offset(umem) + cq->size
  pgsz = roundup_pow_of_two(len);
  ib_umem_find_best_pgoff(umem, pgsz, U64_MAX);
  rdma_umem_for_each_dma_block(umem, biter, pgsz) {
       dma = rdma_block_iter_dma_address(&biter) +  ib_umem_dma_offset(umem, pgsz);
       break;
  }

It turns out the scatterlists can be irregular in some cases so this
will handle that properly while the little test above cannot.

And maybe the above thing could be a little helper:

bool ib_umem_get_contiguous_dma(umem, &dma_addr)

Also I am trying hard to keep scatterlist APIS out of the drivers.

Jason


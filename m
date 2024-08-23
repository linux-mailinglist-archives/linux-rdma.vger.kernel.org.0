Return-Path: <linux-rdma+bounces-4523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F195D054
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FF11F231A2
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326C188585;
	Fri, 23 Aug 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKnTXKUr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDA1865ED
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424442; cv=fail; b=Pg77iIE81riTVcQG9B+vzmpBQZpwkujxqcEqVUumGXo6iZeg7zVDhhbF0JVzMrS4sT7aUaWqf1jxm1wSx0b+R5kt4+xPMbUlXd/D23ToMpKkO8hj8stehv/+Zzyl5gDk01QlIXIyQY4NJ3aLDTaUBpUjhXSALePOGOzHCQU1WDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424442; c=relaxed/simple;
	bh=aNeW31n3sswSSRygCHSRd+Jkk05iJWx2lKI2vKu1dNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtW2oXoFX5TMN3SwRanGq/6NWXqkJhldF/ZFCp7BFhp2xF3hRdYj2Ji//dRQJnDIHGEB+HWQMKVbMfMio6ZrLwryB7UdAEqQITsqJGQgEFl03gyXgRUDSDG36cK7PtOKdDCAnQTw4mMp3LHDXVA0dPKKBaqVdwWzNyCe58EyFHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKnTXKUr; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKVh57aIfbd6RWMO+3gbAJJ0a24sUIITgSWg/PhdJTe4izv65JymyW7PESyPRMR1+0Jw0MJ0DMpVz6/5/jRrnpHy9IW244isOgO+ldplGSwq8QNTe4ZxpF+2XsqigeGr56foEo/QjXoJNg6qqRBe+moWygEkGBHbP2FatHblXNSRHvxqOe2x9fCmGI/InYXwNbCfl+QtqhabUZr+PuJXmolXi2ukMobsfAxpguEBfb7mwA5vMj76lb6GQ2fden/n4uppo0fsnAw/ONwRKCT5TrBoHnBRTm+ds9NEY1SttRr/BrdSwYpVxG2SWDxTvCLooAOZSihxJf91m3G2G7gfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar4vKmPAl/vNCMtYXeEqAjuscpt+G350xnx7hEShsSw=;
 b=RGWsvM2vkyhCj+UgndbEyjf3MPoArtxw5ZZYOVQVxzEnq51QKeYKgRCL/Q9Qp8S88O44vLe40qTE26nezYWEjK/c1u/CgAkb7wgLcpPLr73JEpjEPjdZaY7Wo1oqgb4vGL9w94umPKMuAJze2EpjvK2KeF45nZWy0Ye9/u6Txu27Ef/K5qmrb54FiiDjoh0uUmTb30bHdIfE9LER1HyKITXbNRPOAVPQx8Jg4nHRZSzi9QQYH/HxNNVGoFNE1HIlcL655nh4ME/acEt42ZjiRPgy71SwNYBwaxzV+KJZ0oOmR0KTiFpmNe4hKmAwoOmBG5yI8pnvSSECprFmyrHWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar4vKmPAl/vNCMtYXeEqAjuscpt+G350xnx7hEShsSw=;
 b=aKnTXKUrWSp6xsK2RHXBV3SDE1wIALCY9qdUdRZbDegSEHISa5dSslY95kLnc1hMUUWe3LheGQMabXvPwfFiqQdGfHkFBI8VQS8FKeQWDnURhM7NE9mjgwsUH/a3dapB87cuTl2JT+45cxjQZq14/bYL+9eeOGt51kX0x6R6ul/Z1GsfO27RkfhUpoQmjJB8EDSrgvn7CbFEVVi79S3oKNW1gI9lF0IJxl4GTPo4RcIgG2WacJmNW6G35ojuojw9zWVWZoK174hXprEIv5ZP69O0mRzt032o38U2wI0+RcR5ZouThvhbckl1iMQmMfvXj+CSZc5aArP5Wx94w89ofA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:47:19 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:47:18 +0000
Date: Fri, 23 Aug 2024 11:47:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: bvanassche@acm.org, leon@kernel.org, linux-rdma@vger.kernel.org,
	shinichiro.kawasaki@wdc.com, oliver.sang@intel.com
Subject: Re: [PATCH v2 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <20240823144717.GA2299389@nvidia.com>
References: <20240820113336.19860-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820113336.19860-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BN0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:408:141::24) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: bafb1974-b1c5-45a4-662f-08dcc3827cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axWojFAjbuQ9UxedE02cYPvJQIXNN30iRVpRoh8xG2Wb0Zi3+fmyfdyG6cry?=
 =?us-ascii?Q?ptJ/JLvlHz+N8asXtHh1UXG7vmyXuJGnWs4FbclGimt371kWRQAqxNBCr7in?=
 =?us-ascii?Q?NDZTQau/oyFujrjnRHml15h5URGlSPXgNmmVZpSLC33iflAuEu60x7LGyBvl?=
 =?us-ascii?Q?bBLuh31b6Sqxmz7V7yvobtssjKecK49Okfi+Z/MTDAwGKOrtVXQhPgYbq8Qk?=
 =?us-ascii?Q?zwtraJiT8K7Yx0W+kmXjZnsCGinFU2Z+klKpTsrOjSooiaID+NDCTykki98/?=
 =?us-ascii?Q?zGRGdMzhT6L7LL/1+TAbA48ypzAIv/E6WXBpgenGoc1nAfa6qvJQn4aEJC1a?=
 =?us-ascii?Q?+levTNWpx6JV8pkEyag6Zv8QngIEP4HoSurKz7JqK5MybhcNLxE1kYFSVYZp?=
 =?us-ascii?Q?R/8Trk2Oj777hrLPT4nPIR90VgdT+CLofzAm4qbURB7auDm7NVM0GsYdA4Dz?=
 =?us-ascii?Q?WJrKtHcSvtiqmjx1E7NFDhUkRI97ECLWJ9sj/LgJDBPvDcjTWxpxMJHYQS20?=
 =?us-ascii?Q?wwA2cJczRtOYwRDjbUCAbwWRRm5+Vgl+crpOONFi7MUEoSuJapa0pFDaorMe?=
 =?us-ascii?Q?XrhfEemTMnNudJelq0ZTzdv8+ANIxuyJjJ+eTG9b0FersNrjCDElJx8RBZwI?=
 =?us-ascii?Q?gTJbqI2pByLezui4EedBSK0xyBN19Zwy5BQ7F+E/tireS2oJkHwpuO4R7Ckh?=
 =?us-ascii?Q?fkKSAOTN8T0rmaMJ9Vrs/52rsOkwEUrCvrFTpWWr5tPflxdoSpE8oH7A6lEw?=
 =?us-ascii?Q?UEKCieoHaNkO9/Y2FbQJkOSez6qLqxPq88N4B7lToDYNvjB78aeeDZ/qCJgJ?=
 =?us-ascii?Q?3RaGcyPGpTKXVaYYv3JCP2h9b59yBQSW14RUl1Wgxi2MhntT6Q+sxxULaviB?=
 =?us-ascii?Q?VOV2FScQltDVdN/wztv+jv2EzbAu7HbFr2nAqYtfFzLJrGoqHdqPp6hQZ0FX?=
 =?us-ascii?Q?TGkVj864DC/O6/0tJN9RiuHYgBHXaL9z+uyBRVyehkzGNbiHW6XRvgTWgiRL?=
 =?us-ascii?Q?MFbeZtqU0AmI5YODcrt7qnib7OGAPm3NW0wqfECNSNLqSednz/n8ZgRQWtLd?=
 =?us-ascii?Q?Sl/pcV5NFG4Z69fVQawt531fVgf38G2ee7zzqnRtKC3wsZSodnZIQzaF5cE6?=
 =?us-ascii?Q?tTFTrUGyKJ2qlyrabry89OfjCV1dbVIeHur4VS4Ant/lYPc8dTWA/b8SSZOq?=
 =?us-ascii?Q?UAs3qSKCzgu82V/9HRK9i3zaMD5CDQRUoDiLuFfMJf0nqAiaiqUYdAW1hiiK?=
 =?us-ascii?Q?yyE16/zo9eCIQhDtQSqmiaRLzC1z3MSa6Z3oOGvrfo8dZQcslR+5CuT8PS1n?=
 =?us-ascii?Q?r/m/CsRdGWbFppt0HYlU4BXioo6pwq8GDMBH1HEdcwsUsQBDa69pn3/VQ+yy?=
 =?us-ascii?Q?rnF/DJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNeYxLeiqZcl1s1Y41D3hd43gIaVsYXLVfJCtX7AV4HKWgrcDJdMtWs+Iub5?=
 =?us-ascii?Q?d8dM+tGShu/KDE1bhweDwWLvoFUSUgvXP7u85qm4qiDAQBeNnQmlJQxiHnpT?=
 =?us-ascii?Q?N6UxuFUdVxGAMO7CgYKATY7OSIgMP3z0PyklRZBXSxbAkYK9zD9OpKLbfTba?=
 =?us-ascii?Q?ekW8FIU9NOpb0ckOf0ujz146cwsXWZlmM9s9/tLmhErfkIIejz/jAREiPY0Q?=
 =?us-ascii?Q?LwR/2WSk56EFxJrRGFszLdv0pFtjF1ElLBJyx7y3Z3fkBhUeuutSYmFYLugX?=
 =?us-ascii?Q?NN9J1Yh9GcMCy0+Y/BpCWfZJvaxePy+hr5SUZ/A8bpRlir/KL/RvInxmblQx?=
 =?us-ascii?Q?gYZrjySVXcn4Xj51WDhcozOzCGN1bpxeQM7PgAEBm3rLnn5phZ3yG+PWn4BM?=
 =?us-ascii?Q?2ITm1Lf0sWLSpQMf3+1Q0ulkvW6qyL3tccvKDCfDJp2yr4fuRaZXBtu4ygJw?=
 =?us-ascii?Q?GrMhgPDgB+qaUFGUKhQbyH/UR7IvClSihKmjgsC+cfiFisWAPObFAhktVBhL?=
 =?us-ascii?Q?K9VWkhJrC1XDsz3YoUHQBCitDW5EFsfikvTZPjqHyIWIGSAChO64BISpOP/N?=
 =?us-ascii?Q?0ZA/sGm1iHtNzWfNFSezKSEgq02Phj+cyZK1z1TJxASv+M/ddVhsHhcGBnJR?=
 =?us-ascii?Q?4jaGQlDSnU7jOp6HvccG8mwHLV43tnhkwCIy3I1P+NiNFhUOIQrM2GGLIQsE?=
 =?us-ascii?Q?ScC5JGfCpeglMUseW/ihzYOxfHLXoE+GDRvbLsH+9wTNu8SHrhNCeDY9dwS7?=
 =?us-ascii?Q?yYMLhoC56Y4MSMkPD6xu6e5DlwnkdgQODfrMo5mis7AufNlySkyQkLkMidpY?=
 =?us-ascii?Q?tvmZtdYRVRy9/9aLLUvQXK3FQIJykFWR05CGaSYfUM39lkxIOyWpCNe9saCN?=
 =?us-ascii?Q?d8vYSqFQqld6ZX+EzNxg1bnEgh1HJY04gPpkYCdziBigL/TvG/Zy2Vsmc+zd?=
 =?us-ascii?Q?EucOv9ekj0n4kffvoA2/6k6ltD049Pg+0Uy1ibh0Tpc94TMFNcs4Vw6UBAQ8?=
 =?us-ascii?Q?FQIOJlOGiRV+aRM+Iy9rt4Frb4B39JNKULRRGOujRR1Vg1G3lU7elYNXXd0e?=
 =?us-ascii?Q?LSLXUWp2Y8DUQpF9E0uF7/Y0J8RIPVzskjKBWlOo4FMT5jVFbhgamFJg093E?=
 =?us-ascii?Q?iKrZp6mYnBhiQhYYZBPYNMQ1wuVBlZSJ/GCnoxUJ/Gads0/VjvBaXptxY29l?=
 =?us-ascii?Q?w69gd89drz19xrOP5VOOn5+Qnrk37LScvAZLrRkBXa/DwE5n/tVjDyVgRztT?=
 =?us-ascii?Q?OuGemi9SdtOxap08iLX7OZtKKm6/pafoGZ1Wz+hc9ZKgYwWSOoHL+Ysxunck?=
 =?us-ascii?Q?ergFFk83USoq3xIZ/V/Xu8rxToZljpTTWs+YMJQFeIZ8+DMC76jysyVSCZ4s?=
 =?us-ascii?Q?/9I0xT1IrlqBA282AO+9KdGPej4/624bnEOjNTQII8z/vDHMvoqvDCmbCQkd?=
 =?us-ascii?Q?JhFNX/OKoTmSPZVVI8IyFcW3nMFq9ZD2l9UpxowVf7K7mFTQp24SKj4LCXGV?=
 =?us-ascii?Q?jPil7fS+BA3U7Ugc1xWCtsoNxbBEA/FCBIEqjQibDNw4mC5V/B/r5LvCXHi3?=
 =?us-ascii?Q?6/n/gydU1wOFGIS1IOMrrxNbIXFaIx1DzRwDv1Dt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb1974-b1c5-45a4-662f-08dcc3827cc5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:47:18.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/pYdHHkyzq7OjsyYHO/BS8QpSxNO0N/0L5Y1gF60lf6pwzUmovK1a7lNm8H9wtp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Tue, Aug 20, 2024 at 01:33:36PM +0200, Zhu Yanjun wrote:
> In the commit aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to
> destroying CM IDs"), the function flush_workqueue is invoked to flush
> the work queue iwcm_wq.

..
 
> Fixes: aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to destroying CM IDs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> V1 -> V2: Modify commit logs based on Bart and Jason' suggestions
> ---
>  drivers/infiniband/core/iwcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason


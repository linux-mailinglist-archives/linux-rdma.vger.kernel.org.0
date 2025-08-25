Return-Path: <linux-rdma+bounces-12910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C21B349AA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A97F3BC2CF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF07306D35;
	Mon, 25 Aug 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrbWJCMd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563B35965
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145058; cv=fail; b=m3GTAbyAd2TUpdg4mYdVJ0ssHNpMGvROuX6IkE+59ygX+iBcJNDT/AjPasR0TUeG3l5ny6o7OmBOI05gBf08v00jMJt5dKRHc1h605HzSsj4C7UJiVyd6YegsBXL4DMl9X5ubirvyzOqiyHOtoG5wuETiRIGljRyE2R3EqsI0wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145058; c=relaxed/simple;
	bh=vOJ+bwLyW77QcmMZRLWqWd4QU9A9bT6bfESgnyxFz1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aWe2Cqe6FJmECcLzRErq03Sc1if81YmHfS2Uy/g2goDnVIRbCZjNxmz91lCtLO2Eo4e4eSY41wJq7pPawOyRMeOE9a1smt0EvlbAI+9NQpK6FsqEohtGZ38JFnFqGn2iAiW44DZSytHh89e8XSNf51SaAI5cTWreN5WWMyWORCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrbWJCMd; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQQmFBmdYw55bGJn+jp1Dxv3R9nul3fQhh+BBJpGiHgKJDpcxuUb+3ZTP2JRz+mbzg367fPu0zT/S30PO2cF8kWE9yMOa80n6d+C5EeO4u6RY/iGi9vf9j0nvDt3mWcOx0VMkdcysvZpbqzgGgDZXEXR3aEZqzKEBwW6wYVkdzycgn9h5+6Hg952geu/Jmxr3ou88pPybQKg9VRqWg170Il/cOQU+xG1PGD/F54sqgisNYPlCc4K3KGm/iYfwcfjCI6PRs7sZuCrHfaT4vjEP3uvAP6NzTjuUT7TBi2YmFiUIoiRfpx/Ubvcwi3NCIFor7hCX955lH/PvBP+3FNq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9wVTA6lHUFHHUdqanpYl+du3s4Xnhr2qiJRrfknvXs=;
 b=ns6hoxi614XqeG6cOFoh/S90i4I1qhz22I8VuV05tgcjj8vlk+NdU9P8q/bnC1vzkTpguLscHeptKoHoThij8g99P5x1FVb0t1VIX2pSAttlgJM/FTGc6w5rCTm+sl6wkqOHht35mEaFPTph4V5NtliP4Afxk2jPSUlbFEPYjTjTvJLqVrCJUOu/ug4LvPhr7bPNw2X41H3wd4PpI67W2+EZckXmwcEiGdm0hSoDhV4yIUMGwNtT04qHpu/9ed1BQ87Sgq+0P1QhjZOnuX1fVqfuLDF4l23hlIAsdfFF+rBLkndrPIZkr2vPd+N7nvHLND7k9t/ly1mpXgFPZarLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9wVTA6lHUFHHUdqanpYl+du3s4Xnhr2qiJRrfknvXs=;
 b=MrbWJCMdvCjSLs+C1cvLa7cj+8iXj7IRU8UWQy9KSyHPpmUf99aFz/Hjpziy4SoLJP/Ps+tCN2Yp+7lRMq63pFRPuA0IJietCx5aiwFVAmxnDztVS098CTao+Lxmyu/DjpaRal1xQLjUSSNccW7qPm5ozlqUADP0cVVWs6zxvBM1ZWV2daUeM9ClNZWY8809CAmrMg4byXBW306v617jRjskkqw2DoeKBEx3CJROp522KCLZVp1VvajUBAE/03brp4eOPfecy7awLibJzycHpTL/yOhZ3CUybn2RXnFGyqG4Dc9u7vWi+PYe497IDHljgrySbF2vJqWoI/36bne6ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:04:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:04:14 +0000
Date: Mon, 25 Aug 2025 15:04:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Chuck Lever <cel@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Better estimate max_qp_wr to
 reflect WQE count
Message-ID: <20250825180413.GB2083903@nvidia.com>
References: <7d992c9831c997ed5c33d30973406dc2dcaf5e89.1755088725.git.leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d992c9831c997ed5c33d30973406dc2dcaf5e89.1755088725.git.leon@kernel.org>
X-ClientProxiedBy: YTBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: acfe83b8-3c39-496d-4047-08dde401cd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGRya0wzNTk2Qy9WbVhoQkVnL2ZNazVITVVCbDcrc3prSGpkR0hMRnZ5ZWRR?=
 =?utf-8?B?enNwN2IzSmN1eHFzam9HQWZGNVVjNUhGZWhOVnMxeVhuQWRPcEdUTkVvcUlI?=
 =?utf-8?B?S2l5U2s4OWlXZnhwR054QUpTYXFjU21WT3NkbGwwRm14OFVxMTRVdDFnVmN4?=
 =?utf-8?B?VDBkM1pyWFY4UzZGbUlSTmw0YytzWWRlREluWjMzb1NxdjM5dDVlVnZKNnFS?=
 =?utf-8?B?NUJESzNUbUZSSXZsbVV3NDM2TzN4R2JnK2w5cEF5TnowRFZ5VGcybDZjYzVm?=
 =?utf-8?B?bjY2SFVtakkvNzhYRmlrdGZRU2VBTU9hMXFZNU9oNTBrT25jb05pN2M4MWJS?=
 =?utf-8?B?VzM1KzhmY0E4MXl0UXhOL1JkeHNhczJid1B1c1dhSG5CQTZKYkVUM2lza0pT?=
 =?utf-8?B?VGpRRCsvQU1wcXJvTWFuUzY2TEg2cEFmRWFPY1cvblZHVURDNkQxeWdLOVJq?=
 =?utf-8?B?YnFsbi9VOGVEZXBNbGVlMHpVbkQ0U0RsWXBLRXIwVmFJNENoOHptVlNrZ1RI?=
 =?utf-8?B?VjljRDN2Z2tXdU0rakNlenZORlM3SnJoSkRkRzl5ZE9XbEI0Tk1xanltRjRs?=
 =?utf-8?B?VEk2d2ZYS1NiUHhIMXVmZFBKKzV1dnorRjdkbGxpemc3ZXU0bHY1TU1lUXMv?=
 =?utf-8?B?SHZqN3ZvK0FZOWV2dUZPZ00vUERIK0NSOWwxbjNRT2d0djZsdEd0c0ZFWW50?=
 =?utf-8?B?Y2Y3L2ZRSWo5SmlxSkxzS24yN1piS0RGcTRsZWp6M3JUUUowVVFPUG5tSzY2?=
 =?utf-8?B?RDJPSjBVenRJckdoQjRtM2J5eUk5d3hEVExpT2x5NHBOSDh6Z3dwTWQxWE51?=
 =?utf-8?B?WG9mQ2wvZDY5WDFSRGMyY3FCSGJBa3pEMzFnc3l4ZUIvcWpIS2JnelhkNmlk?=
 =?utf-8?B?RjFIMHZxNDVYcU1qRHpKb0k2LzhwRXpZd0VWcDVTclZ3TVBJMnJQTEtVYUNX?=
 =?utf-8?B?OHFlWVcrSXJHM0JQQkM1ZmQxaW5VK2o2ajZ3UTRNUGhQSEU5UFN6N0VjN3Iw?=
 =?utf-8?B?NENlM0VRRU1IMUdQTkNFWHRWdWlYNndCRyt6ZWsyUDdlQ2dCQ0lNUlZEdWs4?=
 =?utf-8?B?K0RMR3lZaUNnYVV1dExvcHlLL2F3eTU4WW02TzlBSlFhRXVaa2EvS1JzQUha?=
 =?utf-8?B?NEZ2eDViMU5obndrV1U4OUFQTDFEUHNYWUFaMEJlRzRhb25RNDZIN2tXNFdn?=
 =?utf-8?B?NlV0RThmUEZUVUx4TXowNzFLWVBoUEw4N0JkYnRSM2VJa0VnN1Z4Q1lQU2tQ?=
 =?utf-8?B?REFiR1cxTDlOWmtpMWtUcFNSWWxUdEI4bFh2amxLWEk5MklIVWNnUjQ2RjdK?=
 =?utf-8?B?Q1Z5Z0ZkWWFORG1EazRlbHFrQTRTR3p4R3pMd1V3Q1ZOWDRUSTF3b3phWlJy?=
 =?utf-8?B?YlJoZWtmOVc2U3ViZ0VZUGNnYXVRNU5SbkhCcjVMNmdXZ1RaU3pjWGpjY0NR?=
 =?utf-8?B?L0ZJT2VZYUlEaWxvV055bG41b1o0YlordFFFakpxVVFTTnMwcE1xVVJiclhk?=
 =?utf-8?B?Y3NhSTE3Vjh5UDZwS1VEOUlMUGVSenhmZXdJdVE5eVRKK2w0OWxuZ21MTEtv?=
 =?utf-8?B?ck5kanJjcW8weGN0VE5ZeURYUmZta21GMG56dTl3R0N6RTdyQUdoM0tXOW5k?=
 =?utf-8?B?ZkdpTWhWOXdRSWJ1UVM5RkZMSjFRb3l0VFF2RWlQUkNOMnUxRHRTcnlUUUJS?=
 =?utf-8?B?S3Vzc1hyS1o3NStoekN2cHdEZDhqNW1qODdNOTlEa3ZUdWJEbmVxNUFESVAy?=
 =?utf-8?B?VUVjbUhjUDZnbytiZnpyK0Eyb3ZhbFdKUGRTNzI4eDQxUWJFTjF4T0h0Y21i?=
 =?utf-8?B?ZUV5d1hnSFk2ZGhFZE5acGQvYUhtMVdvUXVYSEU4eHV4RW5meDg5RmRmVysx?=
 =?utf-8?B?SXZKRkVhNnliQW5YVVBGZmRFTTg1WndQcXBxcWEwL2x6VHEyUWdkV0FIVEJI?=
 =?utf-8?Q?6uTskou/WuM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3N5OXpnNmNza2RnRzRrRVR6bElyV04vUU8rbGhvQVNic2lZeXJDT0RnejRu?=
 =?utf-8?B?YU5JQTB3Z1hVMzhvZUtBNFVZOWZZS1FoOGJNR2Y3UW42dkNzRGVyTXhiU0xv?=
 =?utf-8?B?dXI3eEowaUNkdE0ydnBOTldVazFSbUlMVjRmNXdpZFQ2dXFsY2J1NE1zaUYr?=
 =?utf-8?B?N3loaGpyUHhhckxILzEvc3ZRT1pycU9yTmRDU1F2dFJqVmczQW9RdjA3aStm?=
 =?utf-8?B?QTRDQXFRc0d3OEZjNktZSFRiWnhOdDJickFkSkJmMmk2ejRoRXptNFMvZlE5?=
 =?utf-8?B?WnlwbFVYYVVHeUZCeDNtNG0wWHlXZ3FuZmtLVE56SVZOY0grR3ZPVEF6ZDJn?=
 =?utf-8?B?YW43djlrd2VKTEZqMmtaN1pYVlV2eFV1S3hFN201Q2taYUlWWDVlVXJRbUEx?=
 =?utf-8?B?dU55MVZIWk04cGVIWGNYVlU5LzBoSEt3dDEzcmJSVTA3c2J5STJmQjE5SklL?=
 =?utf-8?B?SGExMzJSN1NOMUR0MEtkODkxRm9NQWd6WWJOQzkzVFZxdFovblRmL2puUXBz?=
 =?utf-8?B?VDdCalpKQk9wZlpEc29qR0ZBdjYzcWdiT2p0bktGWEJsRFVRZGMrUzBJdjgr?=
 =?utf-8?B?dEZvTDZjYy9MS0VBSGJiYjF4N2piNmJwWUJTdmI4dkFaVE96ZERqbSsvWlYx?=
 =?utf-8?B?TWh1Uythcnlya01nUUREcTA3N2tBYkplS1JZTTBXNm8vS25wMEFWbGFhY3dV?=
 =?utf-8?B?S3RLaUNLTExBc3NjeUdQcW9qWFVhSTdDdWIvTlcyZ2MwTnRkVmhza2cyblRq?=
 =?utf-8?B?Y0dhL2VvdkY5Ui9vYlJSZ1UwaEgxNWlhRG9nS2wycW94SkZOY1c4c1Q0RzNM?=
 =?utf-8?B?OUVxQnRIVVhsTVlDWlVZTTVDNmlFT0daV1BxTThMUE9kbjZHTy9obkdmb1pI?=
 =?utf-8?B?cEt2QlZUcGxOZFo3anVaZVVydGkvNUN3RTdsNkhTL2E2VExJaHZHU1pua3Jy?=
 =?utf-8?B?RnRQWGFjaThYZnhvYVFWV0Q5ajNJb1hTb0tSOW45NWhtZ2tWS1o3a1F6THVq?=
 =?utf-8?B?QlFtWEIxSnpqQm93Y3l6cmpjOTZzb1VMRlFZMGJBSnNnUmNDUnI5Ulg5TU4v?=
 =?utf-8?B?Mm5xRC9mYXg3bnI0Mmh2YnIvakVWYlFwS29FMjk2eDgyNlplV3U2K1hmOEVV?=
 =?utf-8?B?VktlUDdIM1RvTDJ4NDFrZjlRUWFSVzZWekhhN08wajlGdnNSMTBmRDIraTFE?=
 =?utf-8?B?a0l6dkVYK0ZyN2dQRzhuTmFsNGZTbjJJeWYyTGZ6NG5hWUlrd1lERlNicVFs?=
 =?utf-8?B?OWNZS2VNcktWeHVzdk9YaVZQdjlhb1ErcEhIUTZlMmhUdnNxRmd1RklGUHFi?=
 =?utf-8?B?VGFnQVB5N21UejdXSmpKVlZ4MDY4VXhtWThsNCtjS2liSHhnSFdWbzkxa1lq?=
 =?utf-8?B?c3NkcVY5M1htdmRNMW44bDdEamR2NkVlbm9OcEpIS1dsaFJ3N3cxK2doVG1Y?=
 =?utf-8?B?NzRaci8vZDJYRDJpeHhxTlVuVER3VDBiU0dnSUIvQ0ZSTU5ublpSZlFSNzRa?=
 =?utf-8?B?U21LOWN6K1d6cVNUWDFhdE13MzNJcGhsV0NJeFc1aG1CaFlGbnFMZXBGbnRa?=
 =?utf-8?B?cHVmaDZybnJ5aDBJKzAwYlAyUTV4NGpqYmF0MmU0bkowM3RwRjBOV3V6Vm0y?=
 =?utf-8?B?aFhJZ2VaTnZ5aWFZVzJXZjhVWWFUdVlYTjdRRXhuZjByWW04dnZHQWw3S2o4?=
 =?utf-8?B?TnljWjFEd3ZYWHVPOFhWRzBIakVIV3JZRlZqRmx1dFpPYlR5Q0hOamI0UW9H?=
 =?utf-8?B?a1hNUTZ2aHVWWDNaRXY0RmdGNXdZUVhFNWtaNGRSQ1FCSFo1S0lJdHJWR1E5?=
 =?utf-8?B?Y2MzL0kyMXpneW1DOENPVUpjbXRFZENLOG1YclZuVzdnNVFMSDZBelI0T2dp?=
 =?utf-8?B?b2tNK2NGSnN6ZkUzaEFta1luREVPR0lLeStLUzdLdTJ2bnlHNGFHUkVUMytO?=
 =?utf-8?B?QytlenNGbGJlSTkwTTR2clQ2K0t0WWloYmZaVHJTQU9xNW9BM1A0aVRuNGc0?=
 =?utf-8?B?YlVRbktxL0dKL29MejFlS2p2eVNUK0EveDgvV25lL3lFK0cvRFhCa3oxWjJQ?=
 =?utf-8?B?b2s5MTl5Z0Q1NVVqYk4va0xuYmM2d2NQL3pubWVySkg5QTR0N2lTZE5sWks0?=
 =?utf-8?Q?s/qI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfe83b8-3c39-496d-4047-08dde401cd2d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:04:14.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7hUVmMDWzCtqpCLd5ueX9oI7fK9Oou98HjSa15z5H8GDRUmW9M/lvcStvlxS5bT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766

On Wed, Aug 13, 2025 at 03:39:56PM +0300, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> The mlx5 driver currently derives max_qp_wr directly from the
> log_max_qp_sz HCA capability:
> 
>     props->max_qp_wr = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
> 
> However, this value represents the number of WQEs in units of
> Basic Blocks (see MLX5_SEND_WQE_BB), not actual number of WQEs.
> Since the size of a WQE can vary depending on transport type and
> features (e.g., atomic operations, UMR, LSO), the actual number of
> WQEs can be significantly smaller than the WQEBB count suggests.
> 
> This patch introduces a conservative estimation of the worst-case WQE
> size — considering largest segments possible with 1 SGE and no inline
> data or special features. It uses this to derive a more accurate
> max_qp_wr value.
> 
> Fixes: 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
> Reported-by: Chuck Lever <cel@kernel.org>
> Closes: https://lore.kernel.org/all/20250506142202.GJ2260621@ziepe.ca/
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 48 ++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason


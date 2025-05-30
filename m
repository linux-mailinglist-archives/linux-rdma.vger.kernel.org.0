Return-Path: <linux-rdma+bounces-10920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED6AC91BB
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2949717ADC4
	for <lists+linux-rdma@lfdr.de>; Fri, 30 May 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF223371E;
	Fri, 30 May 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlXD5yvl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDD230BE8;
	Fri, 30 May 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616142; cv=fail; b=dWJMifePS9XA4FZNUhT6rxxmC7si4Qtp5Nv2LQipSb7Ev/m+9NRNLcL2fMOzPm6SUpduv4mhuJKllIMZ7VfH+bx9UdLMAzeSxnQhJ8/V6ulzyt1EejP08t+Wlu8YLucZsVK/2jPELp+/t73V5vWb7WEz2luGQXcCZaB3Tgp4Cmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616142; c=relaxed/simple;
	bh=z/PgwJ2TsHXWMddWOVo7eG89g8gy5Q/DqxNNDWsnwe8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=p2dZCG93yn89JOdSgMvbpKOHtPebyllfhqsML6FyCkMM1Prlq0l+OzTXDTk6nM6CPOFUheL/EhwIOZh0XzSCn8Xxc53RrYRuFfiUlQ1BM5le+LJR7n3EGIRu8oy+lktwu+axjD9NYYmNuRkiqMjQ3j9ZZL/ocxsmuXd2GMnZQDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlXD5yvl; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLJGCo68/pW09/Yp/tQBu4rL0/qwnha0cGnCp6HOit0I8rkpEAR5FGT8/zg9QUzVtKoPE5C7dl8hxi96Hyc9LSnUSfROj/TNYL/TBE41MGCMCvDsNPOeaj3zcfBVsvMnAR/np1a/UbdDCFE56Qb++Z+Bmn6KwAb8pko/dHjpRDlDU/YvibXnoRfsvO8qNUFlWxFS0tfs2mmuiBZCAUHIlLACdLh706jeDFldq1pHftoTECLQ+PYix3uoLznYp/Di55ZqPK7QFdxA1a6u9VRA+aQnBxELsMGdav/xZ9Qu1sslms6XlDqJ+NNeZ0dDVYdbO6jIGZhA8PIYrSBAhpOv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwTKOb8nBhM4nOro6YjTc4OcCz2fnHI72oihtmz+FzM=;
 b=xdOxrKZJ5gQ/nUq33wiDlNSPFmSvdKgFvBBfWQjTi31dxIrjmm+qK22ReGoZS4pvUcCJHq066mTmfXac0pB3R5AlY+b/trz/8LaAcDriZwsgIRXtrHo/YBoPjw4BaX5J3Y37EbeJnEIcsski2PWSoxTJ4dONsTUpnzAf7f5NQ0EuV/f/yfOUBzkoqlmjsLBQ8IA2u5o5qVcIyAs4bKd0oNxT5rD/QWmYzoiHcymcRQfy5MRWKD08WiMdxKTpiJgNkE9XLYJ42nfkLToMlcc3huAhb0gmIRN4qfOPm5NjV3LRQeR6mMBGjrKBg61ABahRfDRCZc8d3IC38lHSDz2NkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwTKOb8nBhM4nOro6YjTc4OcCz2fnHI72oihtmz+FzM=;
 b=SlXD5yvlItloA0/J5+UgyxvLcI8SMJGK9ue+rRmAvKIyY8jYn1eQKWKgjIYA/+1j9DFQMGdOWTXM12FTm7C0Bs0pd8CGK2jRXARpGglFoE0LmYIX0dGfCedS2RO9qx/lxn9gDarSA3tmi7ynpwzoELCi3QeAg6SjAXFqTXkkeR4m5WPguT4rT1ghTEFkgcPRCzQ7EjCFDd2YFTPtmEEj4S+kOH1yMHTpmvnKX4qV9BkA5o8Bcjnof/2ai95JbypsOBMmrscgj2FlSknm30xKm1Zd23RwwGI+7j0wkSX8ArNfhNSa0Nqoe2tog6A1eN0wUkIXHrQ4aYSQLxYdJDtW5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 14:42:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 14:42:14 +0000
Date: Fri, 30 May 2025 11:42:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250530144213.GA294859@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q66PIBkcg4/0OUjG"
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:408:f8::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1ea20b-40a0-4165-5891-08dd9f882b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1FPUVNVQWc1cUY0T2IwL05wOU1rblJ2eXhNeHVhRUtOMDR1MVVndFU1MlVN?=
 =?utf-8?B?WUZzRlBsMm82Z2M0eHlkUkgvdUlrQXZHaHFwUjZteWhkRHdCMU05bXJ0WE95?=
 =?utf-8?B?dWxxM1VhR05CN2dwVWFQU0EvQnBEdEw5Nm5MUXlWL1JTa0FmZ2kyTlQ1M1hM?=
 =?utf-8?B?b0QxYit1SHMxZGJ4RkVjZnZ1OGhQMjlJMTR5dS9yem1tby96bHgzajVDRFhN?=
 =?utf-8?B?MUFLSUMyY2pUdFV2dC92ZXBDVTJqa29pU1plMXJjSGt6Q3Bnc0Myb3g1ZDR1?=
 =?utf-8?B?WjhHYysrTENJOENDS0pnSTM4NDVoQ2NLUjZXVEtFV3E2ZWNtS09uQy9CYVpn?=
 =?utf-8?B?VGxXbjVMQ0lDSWszVUExLy8rSG5EOUNDWlFJSmlOazZCbDA2OE5XbklaVElW?=
 =?utf-8?B?ZlpLN3lmU0hTTW1ob0YvMHhrYnM2dmlTT3RlSmliT0lIVlZ6MDNnSHpFOEdJ?=
 =?utf-8?B?VnVpSmwwblo2WEh1bHpkR1dIWVR0dXdtZFBVVU5halptclQ3ZUFuWkhxQWY1?=
 =?utf-8?B?elFrS2tPNXpyR2VIazljZkxZajhQQ1QzUUNjbC83WjJsSS9tWmNEY3BVU21a?=
 =?utf-8?B?UUJDbGxacVJSNzB3V016bmhPdVIrT1hmdThNWmxDSFRzUE5kcFJvZXRoeVRw?=
 =?utf-8?B?NFd5a0ZRa2EzU25NcmlUU2JmRkptQWNKMFg1cUJJS1doaHowQ254VUVEb1BS?=
 =?utf-8?B?TXBJR1hBQ3BQa1p4SThWTVNPNXdhQ2F5c0hNWkZmeHVPSEU1U2VsRGFRZ0NQ?=
 =?utf-8?B?ZDk4Z3A1RlpaTlIxUDkxYXMwcTVVMmErZ21YWCtPcHhLcjNUemt2Z1hhdnRu?=
 =?utf-8?B?cjRqWEVRMUpsM09Cdjk0UFg5aVZ5dXF6YXlJTGI2OUNvWGdJeUcvQUhaZDlr?=
 =?utf-8?B?eXNZSm5naVNhSFhJazg4bEE0clVEdVJwVGZUMXlqMU5ZajE0TWRZNUY2VWU3?=
 =?utf-8?B?TVpKeXVVeVd3MExwU3BtMG1LQzRCSWJIeDk2emY0b0lSZGM1R0hHMHJZZENi?=
 =?utf-8?B?UmNMaytMRGdvRkxEYkowWGtuUFlWbHViVDljQWdLbFR2ck4yVWw3ZFVyN3FE?=
 =?utf-8?B?M0hUSDRNU2FxMU9qVmFNclhoRW5rbVNYUW5keCthUW0zRUdPeUNvTE9sVFJE?=
 =?utf-8?B?OVhWZzZ0SXZBc1FGUnl2L282NFNPMHV4L1BSbzFsQitBVWNNaDNPRzhMbUhD?=
 =?utf-8?B?UnROZmNqYTlBQUJxd3RCdFNtZ2RJc2tUNmhDOG5YMWlQZnpHbWdVS3UvcEVM?=
 =?utf-8?B?TmEwUE01NDJrd2EyZUV4ZDRESnljUGR1USs4N242K3kxdG9wY3FSb3Z3M1Yw?=
 =?utf-8?B?Ri9vM2o0NysySWs2WEpDMTd2ZU0zQW1zc1I1RUs2NEJZYkNVNWRsa2hBTXlp?=
 =?utf-8?B?OCtKRlU5SDhjekkwcllYOGt4ZjVrUU1sWWRPOU5sZ1hrVFF6Rk5KTVNCem55?=
 =?utf-8?B?MXhQWDlpV3ZvQkZLbCtUUWJuRmt6Q1o0UzNyUytadXJGLytWNGhMcTdPc21p?=
 =?utf-8?B?cW4yR21IMFBBYm5OeUpFNHVZMlpUZTRqaHFyOWVaRTZ4UFRXS1doNHdaanRZ?=
 =?utf-8?B?Rms3TnNtMHcxaCs3V0cvWlp2U3MrRFV6RWR3Snp5cnovR2tYclNYVEVkNytz?=
 =?utf-8?B?cS9BQy9seElScnhNb2I3V2NhUHEyTEVwNG5hRk5lbTRJNEZ5Q1lVczZvNzZM?=
 =?utf-8?B?ZmN4NTlsdTdkSjJJVUZhaVpRVXVJZ3JackxZNzEycUFHdDh3WW1sNThsZWJo?=
 =?utf-8?B?UGFXUmVqaHI0eXdwc1NZR0ttbCs5ZTlCekVFaDJxRHR3UWFaZHpvQmR3OG9z?=
 =?utf-8?B?dDRzeDNVays3M2VUeDRBWHlMN3RZeTFrVFJUb3V0d0VFODdScnlNVzljR282?=
 =?utf-8?B?MCtXMVkzMUxyU3B0RCtjRG1lOXpXK0RURTVWcFF1RGJ3ODdpQWJoQ01KWTRv?=
 =?utf-8?Q?HNAKWjZNPno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFYrVE02RlZTYzBKRk85M25NOFZ4a1h4MEVkVlhhcDl1LzMzRDE5Z3VTNnlF?=
 =?utf-8?B?VVBFd1BlZ2t1OU5odDhzb1N2dlBMMW5Ccko2d3RDY0RBcXdJa2luQjlDeVNV?=
 =?utf-8?B?dko2SVdvNjJuZ3Z6eWt1S21RbHR3alZpTzdGamt0L1VJVVJVb1J5azNaekVi?=
 =?utf-8?B?Nm5jRGwwWDhEODhZYU1qbVA1YnFYWXlkS3daYnNEWHo3MEdGTzRhamxwdkpk?=
 =?utf-8?B?aWk3bkQxeThXeHo5Z0c4dFQ4eDJNMXh0SjBKdWN4TFROU2VZNmlQTG1kQmh6?=
 =?utf-8?B?RXc2OXRSd0hUbTVrUU1WTE96V1VMbUlkVTgwSWdza3JhdGduMmdFL28zRElQ?=
 =?utf-8?B?RzVnVWpQbWNoUEtLSjNlU1ZRNG9ZYWlJb0lZbVRZOE5lNWMvanRKSll5aVZU?=
 =?utf-8?B?c2plNHdZaVVDcDFqT3VGeThuNkczNDM1VkdCTnBWYlBBL1NtSlc4Sk5WY3ZZ?=
 =?utf-8?B?Nk0vVENVYi9QeUpYa1ZpanZkTWdScmpKMjluUmpWamJtc002VGt4eXd3L0Fu?=
 =?utf-8?B?eWVVTVJ4ajJsUFlXYXRVZ0NnVkJzdG4zQzRoTHNwUDBUOTE1SXJ2YTdMc05S?=
 =?utf-8?B?cXBLRlFJNXhrTFQzVHYxdnhYdjZxY2VYRURuZ21qbGZsYllpZGo5RHZtZC9R?=
 =?utf-8?B?b01ZSVNGdHdPak9lRFVCcjBVN2NRdEhpL1YrWnJVUnhFbjZ5a2NvMDVFYXJs?=
 =?utf-8?B?NnptUytZMjlhRDlxM3BqWEhtN2NqTjlXVVlhaG80Z2M3WXBKR3dxazkyZ3Av?=
 =?utf-8?B?SzN4Sy9WR0Jtbzd2OFZhd1RpMWVTMkxscmxrbFI5aGk0Wm90SUJsbFV2VTdl?=
 =?utf-8?B?SllIUWNoSzNVQXNUUUdJVW5UbFlVNVVZcEwxSUhWNmxmMEhXa29VUVVsVWc3?=
 =?utf-8?B?cFB6LzFIOU1INDdVRWczNitQOU1KdDNXMWZ4aVRWMEhDMjRNekZpdEU0UDNm?=
 =?utf-8?B?dExMcFllSXlsOVBpT0hBWGwxNitZWnVvL2JIUUFBd3lzNlhwUnVzcFVNWGZ4?=
 =?utf-8?B?alpTSHVVVHBiSTRSLzFCQWdESUdhTnd4VzVMazdlSXY2K0xPM3lRczVCemZ1?=
 =?utf-8?B?S1lUNDVxRlo0TVB3cUhBclVyMU4za0VpSWtZeUZpaEQyMU1pZnhubVBKdWYz?=
 =?utf-8?B?TmxvbVFYcCtuM3NoY21UbmdrVDNUQ3RtQk9KV1draHlXREpMTTgzNDVZcjFi?=
 =?utf-8?B?ZE5QVkhxeUhtbU4wUUN5VStubVBDS1NGdk1xV3A5Y0syT0dFRzhCTnZNNEN4?=
 =?utf-8?B?eXNJL2ExVWNBSkhhOENBa1h5Qy9mU0tNUi95VXdTdStFTkNUMFNZWWxOaW9o?=
 =?utf-8?B?K3dkODl5VnhMNXpxYkkxZDlXRnlPVHEyMEZqeEQ2eFFMYUIyZFlmcmNkb1R4?=
 =?utf-8?B?RjJVdnpIbm0yRDJLZncyOEFtbkd6TTNScFQwZUd3VVZxK1dBdGtoclhLRDhK?=
 =?utf-8?B?bmxtMDcvZm51WDRKZmZxRGZIWndlSFVib0g3UlR3V2ZieWM5STRsWVlSZ3Uw?=
 =?utf-8?B?aG54VUtpb2JSVUNYOU1JZVcxcS9vaWNzbzk3V1hLeXJsQk45ZFdTWlJXdWNJ?=
 =?utf-8?B?ZStHTllUME5JR0tvVmcrTnltR05LbXByQ3dBV1Q0bmtiWlRZSFJZcFlmWmwy?=
 =?utf-8?B?NEoyekIzQVNxQjExR1BpRzVGVWhaTmNURUFmcUU4ZW5iNm1YVSt3WWFxMzFz?=
 =?utf-8?B?b2gyRzFCY0gwK3hrMGZTaWRWYjZPMnJPV3JWRTdnU3JTV014OVZnOHJPT29n?=
 =?utf-8?B?NHFmQ2VqdERNQk5aUmhmbmZtMzh6Z1c3eUZxSHBlOStYUUJaYmpKbzhuK1gv?=
 =?utf-8?B?WlR1RWYyS24vMS8xMDREQnlVVkgxRFd6ZHpRWDJwSVVRckRsdkp0c1k5UEc0?=
 =?utf-8?B?NDZJejN1M3NqM2tzc21hUXRXWXVoQS9INUVkZ0JPcTB0V1kxOG5lMmRjWG50?=
 =?utf-8?B?SmthVk4ya01nY2FoMlJhaitCbVR5ZXNvSDNZTm5hUFNwZUg2NXpualZrTTIr?=
 =?utf-8?B?VUx6STMxME1HMlUwRXI5Y2FjR2lNbFZDYVp5c3hNbC91UU9YUFFjbXY4ZmU2?=
 =?utf-8?B?VFNoYVd3NEthakY1NS9MbnIydlJwWGU0eWpPMjRIemNxVG1pekZzeEx0U2JU?=
 =?utf-8?Q?/JudXjcnQ//LkV+WLwPRFDcBW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1ea20b-40a0-4165-5891-08dd9f882b04
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:42:14.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlGrvGo8u/0DqdY/rerCL8SmGMTYjUbkeuoE9X/NsrPrqQvjXatVT/MTQwyCmC3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

--Q66PIBkcg4/0OUjG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The PR has a couple of branches you've already merged, irdma updates
went through netdev, the DMA API core changes went through the DMA
tree and there is a merge of v6.15 because of dependencies in a
last-minute bug fix.

This includes one of three launch users for the new two step DMA API,
the ODP hmm conversion and hmm helpers.

Otherwise fairly typical driver updates.

Thanks,
Jason

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 92a251c3df8ea1991cd9fe00f1ab0cfce18d7711:

  RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work (2025-0=
5-26 15:36:46 -0300)

----------------------------------------------------------------
RDMA v6.16 merge window pull request

Usual collection of driver fixes:

- Small bug fixes and cleansup in hfi, hns, rxe, mlx5, mana siw

- Further ODP functionality in rxe

- Remote access MRs in mana, along with more page sizes

- Improve CM scalability with a rwlock around the agent

- More trace points for hns

- ODP hmm conversion to the new two step dma API

- Support the ethernet HW device in mana as well as the RNIC

- Cleanups:
 * Use secs_to_jiffies() when appropriate
 * Use ERR_CAST() instead of naked casts
 * Don't use %pK in printk
 * Unusued functions removed
 * Allocation type matching

----------------------------------------------------------------
Ajit Khaparde (1):
      RDMA/bnxt_re: Support extended stats for Thor2 VF

Chen Linxuan (1):
      RDMA/hns: initialize db in update_srq_db()

Chengchang Tang (1):
      RDMA/hns: Remove unused parameters

Colin Ian King (1):
      RDMA/siw: replace redundant ternary operator with just rv

Daisuke Matsuda (6):
      RDMA/rxe: Enable ODP in RDMA FLUSH operation
      RDMA/rxe: Enable ODP in ATOMIC WRITE operation
      RDMA/rxe: Fix mismatched type declarations
      RDMA/rxe: Remove 32-bit architecture support
      RDMA/core: Move ODP capability definitions to uapi
      RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices

Dr. David Alan Gilbert (4):
      RDMA/cma: Remove unused rdma_res_to_id
      RDMA/rxe: Remove unused rxe_run_task
      IB/hfi1: Remove unused sc_drop and sdma_all_idle
      RDMA/siw: Remove unused siw_mem_add

Easwar Hariharan (1):
      RDMA/mlx5: convert timeouts to secs_to_jiffies()

Gautam R A (2):
      RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
      RDMA/bnxt_re: Fix missing error handling for tx_queue

Gustavo A. R. Silva (1):
      IB/hfi1: Avoid -Wflex-array-member-not-at-end warning

Jack Morgenstein (1):
      RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work

Jacob Moroni (1):
      IB/cm: use rwlock for MAD agent lock

Jason Gunthorpe (1):
      Merge tag 'v6.15' into rdma.git for-next

Junxian Huang (8):
      RDMA/hns: Add trace for flush CQE
      RDMA/hns: Add trace for WQE dumping
      RDMA/hns: Add trace for AEQE dumping
      RDMA/hns: Add trace for MR/MTR attribute dumping
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
      RDMA/hns: Add trace for CMDQ dumping
      RDMA/hns: Fix build error of hns_roce_trace
      RDMA/hns: Fix endian issue in trace events

Kalesh AP (1):
      RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc

Kees Cook (2):
      IB/mthca: Adjust buddy->bits allocation type
      IB/hfi1: Adjust fd->entry_to_rb allocation type

Konstantin Taranov (6):
      RDMA/mana_ib: Access remote atomic for MRs
      RDMA/mana_ib: support of the zero based MRs
      RDMA/mana_ib: Add support of 4M, 1G, and 2G pages
      net: mana: Probe rdma device in mana driver
      RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
      RDMA/mana_ib: unify mana_ib functions to support any gdma device

Leon Romanovsky (9):
      Provide a new two step DMA mapping API
      mm/hmm: let users to tag specific PFN with DMA mapped bit
      mm/hmm: provide generic DMA managing logic
      RDMA/umem: Store ODP access mask information in PFN
      RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page link=
age
      RDMA/umem: Separate implicit ODP initialization from explicit ODP
      Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kerne=
l/git/tnguy/linux into wip/leon-for-next
      RDMA/rxe: Break endless pagefault loop for RO pages
      RDMA/mlx5: Avoid flexible array warning

Li Haoran (3):
      RDMA/core: Convert to use ERR_CAST()
      RDMA/uverbs: Convert to use ERR_CAST()
      RDMA/core: Convert to use ERR_CAST()

Patrisious Haddad (2):
      RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      RDMA/mlx5: Add support for 200Gbps per lane speeds

Peng Jiang (1):
      RDMA: Replace msecs_to_jiffies with secs_to_jiffies for=C2=A0timeout

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shiraz Saleem (1):
      net: mana: Add support for auxiliary device servicing events

Thomas Wei=C3=9Fschuh (1):
      RDMA: Don't use %pK through printk

Vlad Dumitrescu (2):
      IB/cm: Drop lockdep assert and WARN when freeing old msg
      IB/cm: Remove dead code and adjust naming

Yishai Hadas (1):
      RDMA/mlx5: Remove the redundant MLX5_IB_STAGE_UAR stage

Zhu Yanjun (1):
      RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup=
" bug

 Documentation/core-api/dma-api.rst               |  71 ++++
 MAINTAINERS                                      |   2 +-
 drivers/infiniband/core/cm.c                     |  78 +---
 drivers/infiniband/core/cm_trace.h               |   2 +-
 drivers/infiniband/core/cma.c                    |  25 +-
 drivers/infiniband/core/cma_trace.h              |   2 +-
 drivers/infiniband/core/iwcm.c                   |  29 +-
 drivers/infiniband/core/mad_rmpp.c               |   2 +-
 drivers/infiniband/core/umem_odp.c               | 271 +++++--------
 drivers/infiniband/core/uverbs_cmd.c             |   2 +-
 drivers/infiniband/core/verbs.c                  |   2 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c          |  20 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c         |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c         |   7 +-
 drivers/infiniband/hw/hfi1/mad.h                 |   1 -
 drivers/infiniband/hw/hfi1/pio.c                 |  10 -
 drivers/infiniband/hw/hfi1/pio.h                 |   1 -
 drivers/infiniband/hw/hfi1/sdma.c                |  18 -
 drivers/infiniband/hw/hfi1/sdma.h                |   1 -
 drivers/infiniband/hw/hfi1/user_exp_rcv.c        |   2 +-
 drivers/infiniband/hw/hns/Makefile               |   1 +
 drivers/infiniband/hw/hns/hns_roce_ah.c          |   1 -
 drivers/infiniband/hw/hns/hns_roce_device.h      |  20 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c       |  26 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h       |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c        |   1 -
 drivers/infiniband/hw/hns/hns_roce_mr.c          |   3 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c    |   1 -
 drivers/infiniband/hw/hns/hns_roce_trace.h       | 216 ++++++++++
 drivers/infiniband/hw/irdma/ctrl.c               |   2 +-
 drivers/infiniband/hw/irdma/main.c               | 125 +++---
 drivers/infiniband/hw/irdma/main.h               |   3 +-
 drivers/infiniband/hw/irdma/osdep.h              |   2 +-
 drivers/infiniband/hw/irdma/pble.c               |   2 +-
 drivers/infiniband/hw/irdma/type.h               |   4 +-
 drivers/infiniband/hw/mana/cq.c                  |   4 +-
 drivers/infiniband/hw/mana/device.c              | 174 ++++----
 drivers/infiniband/hw/mana/main.c                |  92 +++--
 drivers/infiniband/hw/mana/mana_ib.h             |   7 +
 drivers/infiniband/hw/mana/mr.c                  |  29 +-
 drivers/infiniband/hw/mana/qp.c                  |   5 +-
 drivers/infiniband/hw/mlx4/mcg.c                 |   8 +-
 drivers/infiniband/hw/mlx5/fs.c                  |  58 +--
 drivers/infiniband/hw/mlx5/main.c                |  29 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h             |  13 +-
 drivers/infiniband/hw/mlx5/mr.c                  |   6 +-
 drivers/infiniband/hw/mlx5/odp.c                 |  65 +--
 drivers/infiniband/hw/mlx5/qpc.c                 |  30 +-
 drivers/infiniband/hw/mlx5/umr.c                 |  12 +-
 drivers/infiniband/hw/mthca/mthca_mr.c           |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c         |   2 +-
 drivers/infiniband/sw/rxe/Kconfig                |   2 +-
 drivers/infiniband/sw/rxe/rxe.c                  |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h              |  29 +-
 drivers/infiniband/sw/rxe/rxe_mr.c               |  66 ++--
 drivers/infiniband/sw/rxe/rxe_odp.c              | 144 +++++--
 drivers/infiniband/sw/rxe/rxe_param.h            |   5 +-
 drivers/infiniband/sw/rxe/rxe_qp.c               |   7 +-
 drivers/infiniband/sw/rxe/rxe_resp.c             |  15 +-
 drivers/infiniband/sw/rxe/rxe_task.c             |  40 +-
 drivers/infiniband/sw/rxe/rxe_task.h             |   2 -
 drivers/infiniband/sw/siw/siw.h                  |   2 +-
 drivers/infiniband/sw/siw/siw_cq.c               |   2 +-
 drivers/infiniband/sw/siw/siw_mem.c              |  28 +-
 drivers/infiniband/sw/siw/siw_mem.h              |   1 -
 drivers/infiniband/sw/siw/siw_qp_rx.c            |   8 +-
 drivers/infiniband/sw/siw/siw_verbs.c            |   8 +-
 drivers/iommu/dma-iommu.c                        | 482 +++++++++++++++++++=
+---
 drivers/iommu/iommu.c                            |  84 ++--
 drivers/net/ethernet/intel/ice/devlink/devlink.c |  45 ++-
 drivers/net/ethernet/intel/ice/ice.h             |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c         |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c     |  47 ++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h     |   9 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c         | 207 ++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h     |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c        |  18 +-
 drivers/net/ethernet/intel/ice/ice_type.h        |   6 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c  |  27 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  19 +
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 108 ++++-
 drivers/pci/p2pdma.c                             |  38 +-
 include/linux/dma-map-ops.h                      |  54 ---
 include/linux/dma-mapping.h                      |  85 ++++
 include/linux/hmm-dma.h                          |  33 ++
 include/linux/hmm.h                              |  24 +-
 include/linux/iommu.h                            |   4 +
 include/linux/mlx5/driver.h                      |   1 +
 include/linux/net/intel/iidc.h                   | 109 -----
 include/linux/net/intel/iidc_rdma.h              |  68 ++++
 include/linux/net/intel/iidc_rdma_ice.h          |  70 ++++
 include/linux/pci-p2pdma.h                       |  85 ++++
 include/net/mana/gdma.h                          |  47 ++-
 include/net/mana/hw_channel.h                    |   9 +
 include/net/mana/mana.h                          |   3 +
 include/rdma/ib_cm.h                             |  17 +-
 include/rdma/ib_umem_odp.h                       |  25 +-
 include/rdma/ib_verbs.h                          |  18 +-
 include/rdma/rdma_cm.h                           |   1 -
 include/uapi/rdma/ib_user_verbs.h                |  16 +
 kernel/dma/direct.c                              |  44 +--
 kernel/dma/mapping.c                             |  18 +
 mm/hmm.c                                         | 262 +++++++++++-
 105 files changed, 2700 insertions(+), 1261 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_trace.h
 create mode 100644 include/linux/hmm-dma.h
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h

--Q66PIBkcg4/0OUjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaDnDwwAKCRCFwuHvBreF
YVZxAP4z5WdWSllrKXJS6Rri3XLHZZcYv7ZwZdGo3+bSYdhknwD5ATKAABHmi37L
mwFSLhEZuJ6k46dv2wZ8Kb3CN/gztgI=
=fVe2
-----END PGP SIGNATURE-----

--Q66PIBkcg4/0OUjG--


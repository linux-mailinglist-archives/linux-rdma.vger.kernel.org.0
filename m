Return-Path: <linux-rdma+bounces-12039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997DB008D1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8FB7607A7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA70C2F0C62;
	Thu, 10 Jul 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wg2XYe1f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE72F0C5C;
	Thu, 10 Jul 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165173; cv=fail; b=b3Q2G1b0tpy5K7lbJFf9VRZyRKBCyyMMLNcotip6/dypFr3+BPwKmKhzvODo9OqyTAxQQ0RctABqEoQiNhrhlQRlzeU22PRzUAyBiugJI1FvAqY/+VCWSsSHMaldxU+gI2++noi5f3jASozTAoX3oXhwm6WkkaHklJHtC1SiOuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165173; c=relaxed/simple;
	bh=NeydbvkfKfUMqp4xi29Vv+xGfUwS5EDvN47m9vOYELk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vpi6gXVFtexsIk5kRE0gZejX8YCmdFXRD5mCzX8sh6xvavy6pCUAEjfUCATqlTewDfEh9yxbmL+gC8alQBPqMDG19FzwvQqKpjY9YoTcFdlQ4cvJPqe8gLFNy9vOFJ4KkdF9ZI6jY5Wz9EMxcB/JdXw7jJlJ9pusv60bqOIMghw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wg2XYe1f; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752165173; x=1783701173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=NeydbvkfKfUMqp4xi29Vv+xGfUwS5EDvN47m9vOYELk=;
  b=Wg2XYe1flWRKVgoYxyK+WPvvkKvhLxq/DtJnKFRWa7I96GKY2DJc9hOC
   JdYrxDHEO1/oZUgxZz+9W0vsovq5g5RaeJJc9AQUriqvPiAqbMp0GNT2W
   BeGOUK5C8gdj/5BPPES+Jc2ANRWuesJGRQZOWkoQNywJAWBRWqDr70gLl
   UmKTVFvxVEx6mHn7mZc598bFOtxGlSPUCQBVEBUD3BqCSmGTLXKLT7Bqm
   4N4FZuyZI3H/0DlCcnxBZuw4Y1hVtAdJbid9AfIX9M40p4Y0xA9HC1y77
   OANSogMXUpQz2n4EFW0nnB8AgHZMpgG0/QlHeTPvT9hv0RmFc1+YLZiCK
   A==;
X-CSE-ConnectionGUID: WfkhMTC8Sr6IuVQrbBeh7g==
X-CSE-MsgGUID: v4xJv9UkTC6uJuyNnjkp1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54581305"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="asc'?scan'208";a="54581305"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:32:52 -0700
X-CSE-ConnectionGUID: gvxsel4xTTSLDjoMp1ANnw==
X-CSE-MsgGUID: 1cXCs1yDSGaduXVDZQE2BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="asc'?scan'208";a="155771167"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:32:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:32:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 09:32:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH/9ijHxgJIg9uWST6yJk1V8IDJH3dsrwSYI5xToiRVO1SWe3pX7CLKILWwVNuqN5fTD938M8TsO0cUMv5cOzB7ysBOvd+poc3DZIkvexOz/NtoqX2/7FXi++E6jIEdLv9grQuEayxPJUxp8wRSzF8R201ieLxT7/S+tmJ+09H3CFTgnqSYSIMRnnsExLz95oXuBCCLp3ZHmBlRVhAJ70Hh9T3Y+RmoXfSyzd27mI1hqdqp2YHup9sRANq929+GG4kCkbEze/zwROIWw2gbB5AlQXeHpUPT8odaa0ixxlV3WS36zqbVrajI7AsIXxPeRxYfCSNHrkho9GHUxIEaenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeydbvkfKfUMqp4xi29Vv+xGfUwS5EDvN47m9vOYELk=;
 b=hwRHpXi/2w0Ytl2zZ3Uy14dM1Mgtrc+peuprZAm03jn0q5a4X61e9driAfEEsL2s3jj6H8pzhI0XvuhRhzgmOK0g3oNe1cLsmwQG7tXgQ4ryiGPWYVi3nm5AXFXlrLL3bTAN6YbFcdPIzwBvQubwscpRxQ67YsGAndL/t8tRi+gmpcMDe/lfrcPvloe4nEmBrRRnxv2UxkmT31fD6bcy/LsNuAxbmfITKfCMEWWbzUHwCRq9xbgpbOVjuxvxqBJpryp6fyFKwmc0fjbQ/y4QlIt18h8VT25GQ8kKLMdQEtyrz4eCT5hF08j0j8O5CXtOQIGebgDahAHPzfILUXmmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 16:32:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:32:41 +0000
Message-ID: <4756f803-6794-4f62-9694-779ab3b97992@intel.com>
Date: Thu, 10 Jul 2025 09:32:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net/mlx5e: Add new prio for promiscuous mode
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1752155624-24095-4-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7khk9Hn6ScvdIqFJ29EL2k9Y"
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6cc972-b102-49cb-72c4-08ddbfcf644a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlZpb0hiWnlMZTFDYWh1S0p1UW1uWTllQyt0RjB4RlZhRElzdkV3dzhoZ2ZJ?=
 =?utf-8?B?MG41QUU5OXNTdTgrWDhwM2lHdjFrOStBNUJNandwQ0k5UmFJUWpaY0JjcThB?=
 =?utf-8?B?bkExakQ1Ym9lUk5uWndmOGkzeThXc25oVEcvdGNNczlqVGZ0cjVOSFcxOVFC?=
 =?utf-8?B?SVdhT0cxQW9zT0U2SGtyVXgxdU81MW96SVhMZUNTVy9BRElUektWa1ZSYTdY?=
 =?utf-8?B?b3VqaHdFcjFmbVowWDV1WElxbGxTUGNkQmRWbS8yQ0h5YURpa2ZkVEpKSTI4?=
 =?utf-8?B?YisyZVRqekc2bDBrRHh3dVVvL2RYaHRSTE1tZVJFUjgwbnJpM0MzNmNuejhv?=
 =?utf-8?B?cFpDMlNiaG1WQkJkQUYvcnRSNlNBdmRsSUQ1VUpwcmtMMFd0dGFzR3g4M1Yx?=
 =?utf-8?B?UUR6RTZjRjVGbFpDNlhpVlpWbGp1YjBKRE9mRXVkVUx4V2FSdVhyRldlRTNE?=
 =?utf-8?B?NlBrWXBLb0N5cWFtUFNVYUtZRDhIaFNxT09SQUxFSmJZeDlYWFdjWWJ3enZG?=
 =?utf-8?B?cUJTcjYzaE44aURraytSZ01WT0doS1luQWRHVG5VdE9USlA3TGhXdllpWnVQ?=
 =?utf-8?B?a3pSNVZRaU4za09xOE5YSmI2bzFnamgrVTFlQ3F4MFVhMWlVanVaS2xaWTlX?=
 =?utf-8?B?UEFmdE02UGFvQ01NM1VtL1dvVkJIYkNPQi9GSURnakFLdzVUVjZydkhBeS9H?=
 =?utf-8?B?ang1d2RIVVYvZVVVdFdiR2hnbUEyWjJ0TytQaE9wa1gzSi84WTRlZCt2cUNK?=
 =?utf-8?B?eTZGdUkzSHdsOEhXcTVZdE1DNUYzcFpGM0s4NVo3Zkt5Nm1TK2JpU1ZuWEhk?=
 =?utf-8?B?RU9NZitRaVZ1MkUwdE0xaXJkKzcrNk9YN29DQURobmVENHBWQmozR0gxSnZj?=
 =?utf-8?B?dTJvMzhPMkZxYXN0OGtaWmFEUGowS1hkUGFMbGN2MStHNGtvaFcvVjl3T3BS?=
 =?utf-8?B?dWFHdk1mTlJhWHl3emxyWGh1cURqWSsxU2pTUGdpdzVzcDBYbkdnRUYzYThy?=
 =?utf-8?B?TFR6ZmN4cXhkMTNiREYyWlJSYUM0eTROZU9yNnl2RUptYTNTSHRORWtsRWdY?=
 =?utf-8?B?bGVDRUJwcFRFSlppU3RkcXc0Q1E2RzJCeXNoVUNRMXIvRkU5UWxZdjh2cmoz?=
 =?utf-8?B?VHd1QU1Ea3JJOGl0K3lGYnQxNVA5VXg4cFExT01MSUhXeW9LUEl5cjEwN0hE?=
 =?utf-8?B?bDdOMG03OXVTQVp3OTIrZTUyaHlsWUdVcTh2WlF4QWJiMFpzSnRpZnhtRGZz?=
 =?utf-8?B?VjUvclRDdFB2NldPSFczejVFTzR5d3RoU29lYWRzMDREOEdjZ2VkeERCenVD?=
 =?utf-8?B?SllJTFJzc0tCajRGVE40QXhxSmxidmo2c21EYmpHVHpvNHl5UUF0UGFQK0lk?=
 =?utf-8?B?bkkvcVUzdm96a3g3ZW1TOWRMa0pKNXJrYWNRQ0w1YVoxRGYyTmFlM1BLTnlC?=
 =?utf-8?B?TUh4aVVZelpQN0wrNDNUbTJoZktuQzBHS21yQ0NyWERYMHloTXhxbm9IQlkx?=
 =?utf-8?B?Qy9sa1F3L1BEMFE4ZTVwMVpnaWxFUXBWN0IrVTlEVG1rWWtMWU00MVZ4N2pW?=
 =?utf-8?B?ZitUQ3ZIaUlmdjdyK3BCZDlkaXd1cldJbDkyakZxcTc0NWZSVE5ERjFQS3M5?=
 =?utf-8?B?dVYwWHJudW9YTEp3N2svK1R1Yk9NOFE5NTQ0b2FpcTl4dTFhUGt4dUk1NG1m?=
 =?utf-8?B?ZDQ2YWEvYlBkSGw2eWliWTBXbWcrWDI1MjlRUWVPNzdVZTVvSFBQVXZ1Vmhz?=
 =?utf-8?B?QlFMZDVsQm9HTVh5TUJFalV6T3lQVWw0RjRmc1FyTzF0QmpTWm1Yb2k2NjlG?=
 =?utf-8?B?TSszWUxuTURKRFByTVVMdUM4MHRyaHlIRml5MXgwZDNoVms4eE9pTUlWaGNU?=
 =?utf-8?B?dmExYUNYYUlaYjZaOWJoT1Z6allFNnFNQmlHVy9QVTdtcTlJdlpLNVJxQ1JW?=
 =?utf-8?Q?DNCijmZFhDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdTSExPVSthWmtzblc3WFhDcm1XbTBIVnB0WFFPeElPTFdvbm43UmZHcTNw?=
 =?utf-8?B?bytqQUNkN3BWck5RdFpaWVZSYmJkZDBDcVdwQ3p4NEdyUXd0eEF4R3NFYWkz?=
 =?utf-8?B?YUdKSTZ2dk1SN1F2bWkxQmt0dlZRcmpXeHJsYm5WbVV5VGlUYXRpNDZia3Jh?=
 =?utf-8?B?K1R2NE1OT21LSWVITWE3aXdXRHZ4eGlDY0RPODdvWlFEY2pSUVE4enlOR3lY?=
 =?utf-8?B?b2VpVGEwbHAzM0UwaWdFbTMwUjRkQzdMOVB4R1llNnU0WURsNnVIbFVyUkFS?=
 =?utf-8?B?MHA2VnFFWUJpNlZUSWM4cVZNS2wxeUx0WVFsRUFRajJyb0c4dW1CVEVJYTRn?=
 =?utf-8?B?UzkrTUVGRHNSd2EzU2FIbU1HZ0NrRG00TlpNRzdLNEIzbXlqZXVEVjJmRzlo?=
 =?utf-8?B?eXQxdENIdGx6MVQ4YWJVOUk2a2Nwa1F4bUtGSUY5NlRnVWZpUEFWcmFscC90?=
 =?utf-8?B?VGNDTWxucmFtc0tQcjNNeHBYU0dKdUc4V1RNVTVmNTBzMWxsY2o2UnNzdFF5?=
 =?utf-8?B?bmNtYjF6dmdoYmw4dHcrWHUyQ3o4bUp6QnRVZEJQVFYvQkRwNXE3QXVWeWxC?=
 =?utf-8?B?eFFyV1N0WERyZThtRk1pL21wMkhWOXI3emptUjcyWnRHcERGRCs0akRlZHE5?=
 =?utf-8?B?eXJEb2luVVFrTUkwOFJIZlRlMDF5STlML29jMzZVVExSVDZTd0NrdGI3SjF2?=
 =?utf-8?B?K1V2cE5weWZHSXFSRzF3UHlnckMwOTlZUkNrZDhnN2VBMzQzd1JCRWwzOEgw?=
 =?utf-8?B?Z3ZHZXlvUndnWkJkNkVBU0ZPV2FZeHpEL1RIdFRrNFAzSkl3bXF4UmlYeTlZ?=
 =?utf-8?B?dE5nM3pqbUY4cjk2TWVqVXpVdnQ4bTlsajRmK3lDeWc0bEhzTThtWXBrVHNS?=
 =?utf-8?B?eVhPQXJUY3N6R3JQd3c2S21QdWdvaktLMDd1V2JURDZWWFEveXVKbFVVS25s?=
 =?utf-8?B?Q2xielVoYkt2SWNiOW13dXJualJ3ZGN1U244Wmk0UkhPUU03MXF5b2E0N09X?=
 =?utf-8?B?QzlSWnpvU2luOFJBUHZUZ2E5RlNyOWE0cHdOOUhmelpSc2N2cThIMGY1OWtE?=
 =?utf-8?B?RnNLSFQxMUdLc2sxVkVXdGhrSzRxWGhrUVZhT2V3WGZHMUt6VnowUlhsK3px?=
 =?utf-8?B?VkR4dHJ0ODdqWHFzOExrWFZSSDJlWFBSUGVGQ21RS2RDYXNPSWFIWEZJNU03?=
 =?utf-8?B?eHJacXgxd0xiM3JCOFN3MW81cnFBTy8zWm14T0lWY1hxL05EcE83b2QwT1pS?=
 =?utf-8?B?clFJRlNWbnI4MWhHVkM1NEZFbHNCSWpTWHhCRlZraG5hbkdyZng0QVVFZ2hL?=
 =?utf-8?B?QXN4U3FoWEhxWlUzMUZ6Rlc1TWhka2xFbzQxUHNMTVhBd1J6QncwSFkzZmRH?=
 =?utf-8?B?dGN1ZzFERE8xa1J4dS9POGtWLzVUNlhET054eEFMY244WkNRMGpjbWZwdjUx?=
 =?utf-8?B?dkpBOFVSa1FjN25TVzBqc0d6T0NuNklkdEl2ZE9hdzJHZWFYVldGQzJuMzJO?=
 =?utf-8?B?T3NycE52WUozM0M3NUhMa0l3Z0dJM0hqU0R0Nm9lMmRXZEcvdm1aWUk5aUNY?=
 =?utf-8?B?U1VXeXR5ejgrTTlZdnFnYjY5V1lPZEw1QTJyYzhYWE1sbmtVVWdDSHR3OFBn?=
 =?utf-8?B?MlhQVTlpWlM4WXdFNW5DZ29zdXI0emdJRkJDRGhaSHdxY3h6YXRtMnZRL0p4?=
 =?utf-8?B?eEp5TXJFaUdQVVo2aXRFSE5iNmFxaCtZZGh1bjdTWTR3UVc0K0FTalFLVWRu?=
 =?utf-8?B?TTdxdExJSjF1ZXFUNGJiVGNnZ2t4VGNDV3lXYUdVVzNiUFhzZ0RkdWsyd3ZU?=
 =?utf-8?B?TzJHakRPMTdJZm1TcTZKZWtQT2Zvd1dXMFpLRTI0OC8wSitsTTd5WkZqdkhu?=
 =?utf-8?B?OHN6NWdHc2psb2M2Z1NldmoxL0hPeWZYS2Nzb3AyWVplZ2JVRE96N3Z1OVgy?=
 =?utf-8?B?S0VWb1pvODVlSjd0Zzl6SW1oeTlPN1ZValA4S3QvR09GVlN3NDVSNElkOWk2?=
 =?utf-8?B?Sk1MYm1TV0NRZnkrdkR0NE5KSWIzNExxdG1JbE5GbmxXVlFZdUFEZHNhK1VS?=
 =?utf-8?B?NklmcDdGclN0NzV6V3RSUVRTemdoejUrRzMrOS9iamlHWnFEc2pwT2JJTnYz?=
 =?utf-8?B?Lzdkc2w1bUErQWc0NHgzRlpxeW50ZGJJTzg4QjB4K2dvMExKV0JXa3doeTlk?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6cc972-b102-49cb-72c4-08ddbfcf644a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:32:41.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCvVtcrIAxeK4ZC7rmTUMjOLeJ3V+5yOc3s1WcJUMvfA/DQ6dGXS7BXmqdqZEVXlo9QBjjOQ60uC0GF4JShQNtuqISQw4NQ4SOIRM4Z7IoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com

--------------7khk9Hn6ScvdIqFJ29EL2k9Y
Content-Type: multipart/mixed; boundary="------------H2JRCHIsEhfNcLnixvnhBAUg";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jianbo Liu <jianbol@nvidia.com>
Message-ID: <4756f803-6794-4f62-9694-779ab3b97992@intel.com>
Subject: Re: [PATCH net 3/3] net/mlx5e: Add new prio for promiscuous mode
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-4-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752155624-24095-4-git-send-email-tariqt@nvidia.com>

--------------H2JRCHIsEhfNcLnixvnhBAUg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/10/2025 6:53 AM, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
>=20
> An optimization for promiscuous mode adds a high-priority steering
> table with a single catch-all rule to steer all traffic directly to
> the TTC table.
>=20
> However, a gap exists between the creation of this table and the
> insertion of the catch-all rule. Packets arriving in this brief window
> would miss as no rule was inserted yet, unnecessarily incrementing the
> 'rx_steer_missed_packets' counter and dropped.
>=20
> This patch resolves the issue by introducing a new prio for this
> table, placing it between MLX5E_TC_PRIO and MLX5E_NIC_PRIO. By doing
> so, packets arriving during the window now fall through to the next
> prio (at MLX5E_NIC_PRIO) instead of being dropped.
>=20
> Fixes: 1c46d7409f30 ("net/mlx5e: Optimize promiscuous mode")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------H2JRCHIsEhfNcLnixvnhBAUg--

--------------7khk9Hn6ScvdIqFJ29EL2k9Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG/rKAUDAAAAAAAKCRBqll0+bw8o6GjG
AQCh9JmbuQ25I6vv/PvukweVe1pMPMuYQEGIp/bBeHMFpQD/Xq1WqoniZx36OSk92tTpWreojZqR
lxIgT0I2B5qrjwQ=
=u6WU
-----END PGP SIGNATURE-----

--------------7khk9Hn6ScvdIqFJ29EL2k9Y--


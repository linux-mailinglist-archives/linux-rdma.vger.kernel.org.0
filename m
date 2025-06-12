Return-Path: <linux-rdma+bounces-11249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A2AD6B45
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FEB18853E9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B181F237E;
	Thu, 12 Jun 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzCsso4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E2522F;
	Thu, 12 Jun 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718015; cv=fail; b=o/lKu+S1X2kjoMRWEu/ydRUcboPXMtpWRc3kloJLQ0I6K9pYT5n4iYw/VrgvglNunNx+1RnAC599NkY5vbxzASRiG5Svxx70Cq8/ivpQAHqf1IFNfJ1kXQXN3aoXKbViLPXRXCBjIn5+q+jmBNxSmLJZhsNkUEjL5wunx8zzGAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718015; c=relaxed/simple;
	bh=CbETtX8epUcUjJLNJjHzAbTTzZ8iLzi4yl/6iLh+QHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSKScovHwrKz1jJEzP96nEh7EofQo0/6YR38OJrN1da7JEGUWqRdGVnL1+Qg/eNUpw/hTwfBPwkuzZ3B8xi0Co547yP9imoVN5y8CMbfIcGxJIuVO5MfZYSiZH+qCnjyO89EZZsWyzhaQPU0fHec9tKfphoMlxZksYRwNsGDy7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzCsso4v; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC9f5+ehMM0sF8XoNrP/6D/5gyfKi1Q5SffPcSihW6prrcPDYWfwsGCmHoS5boVkiRYTTQd4EAiev7gx6E2bccqyUvF4t1Lqdk0il7o/n7ff4Q/2SlQXE9kg3jWkdEaeSAijnbfnnKVhV/2Wavl0+/7IHUBeOHhp+XPuDQbOASc1WGMZNZ86dBiBqswVDnpB0KRITrBDGdRQGidMukKW/w4A/MUKV5Hb6tFmXaRRQBuIge9PtN+Oa6c+ouT1nRg/3meE7rp90HCOqH8tKBHTQFSRlhC66QKPJ7jkdyqHHoKcHM2KGXl7YXcs+4TKM5ABqo4b1rFZQsWdU2PYrfgCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b79nIiR3wgbW5B8iGbzR8S2bEAmXFwsGW1ukOLH5RM8=;
 b=E+5ClBXPoA4CV80UTSBQbWz0+MyGA/wQgvBkgkkrT8zqXg5R203A7DKdODK3LP5ARlIhzZ7Q4MkX2SjOkpDG42FCVEnBmoVikHwCiJKKJc7N/KoG1H0yauymtGFKU6cC9mhiXlF0LKg2Oe01oXls76QeI8DIoEmu/xXAIAAtf69icQVwO6VE0A8bESbDqxevseeI+uhxa+HRCtRxdTzK1lBn2kLsoT7z7DKPjfh1bPAMiYtFmhVnbB5e/pq9KZc7oINSgFqfONr+WVsfCRSlnc5ZNcnEx0vn+fgneC4SzFtxW3onQlWxIXr1HIO4Ukp/m7G7stXfivsHBI36aKVERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b79nIiR3wgbW5B8iGbzR8S2bEAmXFwsGW1ukOLH5RM8=;
 b=gzCsso4v2iiehxeLct+3VyeCff4ptopjy5fMKpl59jq7T5fxHpJsW4Vv5QnwYHlRixgX6BcAuMO1pHgMs47hAhCVatjV0h9wwNg6Kh+fvF1eqEiZdeEBNPyPjdF2rKfVjCrk6p0k/UVkOzU7AeZIB8aOmIb7TMPyOGmxR95IfAEjFAa4ibyKlvehw4SS5521oAbRN1sY2/eWrByohr3zzndFiwe38bxlSLsVplk7lWtJzBeCo28VKTdekd8jwbSRDEX+VNY2JNnojMCH353QMZkTiL5dzYJTwOe3fG5UIe6YEySfVu1Wax3anfFrvLaGxDOMjBFtZEQka26pLWquGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Thu, 12 Jun
 2025 08:46:49 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 08:46:49 +0000
Date: Thu, 12 Jun 2025 08:46:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 08/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
Message-ID: <6nd3d7z5dmpzpegbwfkhszmtjqmsb4af5ts36mpv5m6jfavo23@lwijppu24jjf>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
 <20250610150950.1094376-9-mbloch@nvidia.com>
 <CAHS8izOEn+C5QexSPZT3_ekUr2zR1dm9R6OsoGBPaqg5MFvBRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOEn+C5QexSPZT3_ekUr2zR1dm9R6OsoGBPaqg5MFvBRQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: cf58c311-1919-4ed8-93c4-08dda98dabcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdTQmh3NEJkMzdPY05YeERvZWpyUXNOVGRaOHJaaGJJcGFwVEhSUUJKZ09M?=
 =?utf-8?B?eklDcGEzQTZFd0dSMmIwQ21Zd1V0RlVEQ1hab0o1N2xMaVI4UlR4TFdLMWNs?=
 =?utf-8?B?UzljQWRSdTRLSmU3cVNhOCtSNXdOcEVWQW41cEprWU56ZS96MHBOeFlxUG5U?=
 =?utf-8?B?MkQ0UUpORmVWL3BTbk1KV0EwL2hXcEUvSWpSckkzSEcyMUlQN3VWcGJ4NEwr?=
 =?utf-8?B?K21oUUY1Zjh6NC9DNlFKRzlEN0VQMElYTWNObVRDZkZPV3dHZ21XaUprZzF2?=
 =?utf-8?B?RVhiVXdiWE5aWkFBREhWZXhsQUJYZ3c2ODUxQnZBMjJwbmlNUVFmbTJkRUNF?=
 =?utf-8?B?VW90SFIwVHYyV3QxZnpoYVVBYndjU3ZSN1VTR1laNzhiSEY4QXFiSGw3VVVT?=
 =?utf-8?B?SkgrQVZGRzZFclY5a1laN1RGOVA1V0UxWGtrVG1PMEgzL010U1g2MlVWUzE1?=
 =?utf-8?B?Rm53KzJLbEhkKzVRZ2JxOHdBOVlyaU4zMENnZmNKNlVveWZWSmdUV08wSDM0?=
 =?utf-8?B?Z21qZjRhTmVwbXhPSW9KQnQxdmdMR3I0SGlBMUZFcEtZSXNmTlM3SDlNY09B?=
 =?utf-8?B?THF3Zm83cHM3eXBzanZUVWJJNHRqSnFLbkVmUXQyMzZxc1FoNzU3aUhZWnVX?=
 =?utf-8?B?NFhNeWpVdy9SbnNkUGR5NU9iMnc4dEgxaHpacjhNdEQ4WmFNZ3B4cHJIcm9k?=
 =?utf-8?B?eUxCaXM2akNDNUUwMkNoVmVZNU4zMC9PeGVSM3pURU1VUXU5Ym85RW1QYmlU?=
 =?utf-8?B?VjI5UlhMNzFIcEdGU2wxUkd1NnlUOHRhTWpONWp3NnRmU1ZuK1NsM0gvNk9n?=
 =?utf-8?B?c0xkcExNNzBlYzZNcVhxVFhZWEhBNGVRaW5qaHdmb3RJT2V2SjZsUnlYMjFM?=
 =?utf-8?B?QnIrUHdIbzZnVlAvWnAwVjZNS0hxNFlSbFhpSWhBMllQTEE2ZS9Ieis4Q1dQ?=
 =?utf-8?B?MjJtajRqZUFEeHFMK2t3bnp1Zkd1ZzlROGtYd3FheDRrVW1BSlVPSXErYmM1?=
 =?utf-8?B?UkNDYVlZMmsyUUFCRVUwWmgxd3B5cW9OYzdMTTdaSDVGdXEwb2VydHpPczRm?=
 =?utf-8?B?dnQrc0NhbG5RelRrWGpIQmNFRlFYeU1VaE8ycEQ3S1BlMktXanptekQ5Vy8z?=
 =?utf-8?B?RmZkclVBTnYrRWxoa1hjTytyUFhlc1FvczVDdjVVSC82ZDdicDduWW1waDZ3?=
 =?utf-8?B?MVl3aXUrVXpwUXhnMk9Xem9MNmVXVHB6UnZOSUUzV2dIcTRqLzJJTDJ0bTZq?=
 =?utf-8?B?TnVjNDM4RlY2VDU5eHI1OGViRGw5QksvamQzUUY4Wno3MTZoNFpNVEpqU1Fk?=
 =?utf-8?B?OGpSdEdIQXdTWXlvVFAxdDFEdE1zQ0pzYmlxZTA4aU9FVk01VmNGZlJQaDRI?=
 =?utf-8?B?WXVUaUEzMktnR1R2emFXMDd5OVovTWllRGdxalpSWXdDL0tyZW1acWNOaDdU?=
 =?utf-8?B?Vkg1ekwwdWdjM0VpMUxqUFpWblpweENBSk1mT2x1MzdZdTBseUhzZkNxWlRF?=
 =?utf-8?B?S2t3OE5UM1FNQTk5RXJOdUFGMUZmRzJGRTBEeXRsZWhxU042RjNPci8wNmgz?=
 =?utf-8?B?WmEvbktxN1RVNWJFSUlnVW9telNlV1Y3YUxJUytKOC9kMDNMRXVseENnQWJM?=
 =?utf-8?B?cWdMZ0tXWWxBYnNrSGMzMGlJZ1pxM3paZG5Ea2pBT0p0WUJjVXJUc2hVRmRK?=
 =?utf-8?B?RGJobTN0czJqRFVpY2UxN3NWRXg5Y0dUSFNYNEM3QnpLMlBoR0oyaldMTk9R?=
 =?utf-8?B?d0lvN05RSTZ5QTFVM2kzMForOW04L1cwZnJqRVUrajBUbmtLUlpmUGVxT0lO?=
 =?utf-8?B?djhSVTFBWXBjZWZtSFBtanVsZFIvcWJ6TVFScWhmcW1mTW80cHVJbDhGRDdI?=
 =?utf-8?B?YjBubHBCaE1vSHRHSXIvK2NzU3AxWk5PZktabUFUdnM2Q0lJb0xPYVlRUllZ?=
 =?utf-8?Q?4HzuBgJLOmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGxISmtIRGhuNGtsNmVPY3JKZE1xUDNuNW5ndkpEaHhTWGVkSGZvREpWbGY2?=
 =?utf-8?B?Qkw4OVVseGx1WGszSGdNblJjTHg0N2cyM012SGhHTWE1Q1BJZTVqRXVWWnVK?=
 =?utf-8?B?MU5OakxMZStaUFNGbjVheVJyRlNvYmMvU0QrQ0RtZ0FSTDQ1N3IxT01CaXdC?=
 =?utf-8?B?eTVvV25tQ0liY0VleW9VcFVmeE5JVWg0dm1VWFFyRUxUejVvUjdPNkkzL1ZK?=
 =?utf-8?B?Wk5TeTdyVXBoeVlDQUxDK0ZYRGYyZGo4Uyt4a0l1aTJxTEtkWndmTkptYVBp?=
 =?utf-8?B?ZzE3djB6M1FyMzJFMThNM0FPQ0cvc0c5SXlZVkExcVlwZ00weWoxUmtCMGlh?=
 =?utf-8?B?THREZmFUSVJrZ0RzVDR1akplV2hUcDBiZ2cweDA3MEFmVUNMR2l2eG16b09T?=
 =?utf-8?B?anZKdWVzUElVcUVtZmY3NFFIQXBmZUpHa1dMV0o2cGFwbnY2NUx4bTA5VVMy?=
 =?utf-8?B?Y3dmYUYzZHZjWVJwMVZ2T21zYWgxZWlKeDdsQXJzd0ZyMExpVzMyMWR5TzRU?=
 =?utf-8?B?MVZUcStmM20zUmlLOGpYSmdrYWFoa0tpVldMZVRHNUxCOHA2RkZhM3VDRWVt?=
 =?utf-8?B?UE1DMGRacW5KRS9xTHJ3VGVTVzNsSDlrSlcxYzhyeHFMVEw5SFFETUIxNjF0?=
 =?utf-8?B?ckMvMGVLa29DT0t2WlhZSUlCTmkwdWE1ZDZEYXBVTGo0Q05CdC96U0xuTUlC?=
 =?utf-8?B?VC9TSjdCaiszUEQzREVrbmdrL3c4RWE1RE00czR6ZDk5WU54Q1BoWUV0aDlk?=
 =?utf-8?B?bSs0S0hDRXJCaGpaMVFHZDczWmFKOWpQb2Z5S2ZkVnc4M1ZTY1BGbExkNGhN?=
 =?utf-8?B?alJVVS91WXduTnY2SktacEoyU1JpMWZKS3ZKQ0F3akVQVE54RUlLQ0cybW43?=
 =?utf-8?B?dGQxOFZQMmlGUFlEYkhQdGJyTTdFSUdyWVJrZTV5Y1JoRFFRZUgxaWtIdUQw?=
 =?utf-8?B?b0ZPYzZGbWc3dlpuRU9HM1ZtSlhIMUdKbGRmRllRL2pEZThtYVJ0cjJ6d2tz?=
 =?utf-8?B?NWlsVzFGNGl2dnNwZ1gyRERYQmd0WWVReEhyUDl6a1BwQkdYNzVaVXpwcDcr?=
 =?utf-8?B?QTVsdUN4eXJDY1FVbGIyMFF5cjVuTHcrcXo3a2g3RnVLeFhJeWdjakVrdFhw?=
 =?utf-8?B?QkhGNStOTnY5bEVQY2ZkTVZTNDYxNHhZdGQ1WHM1Q2lTQWhOOEpFTTY4Z3RD?=
 =?utf-8?B?MmI4azNyTFFZbGF4RkpSVWxRa0hrNDl4Y0Z3UW5GZWR4dFlNRjhUMUZmdFBa?=
 =?utf-8?B?WlFoamNQNWhWblo4YnNDRk56NDA3dXNEaktmZFN4L1dRN2x3RXJQcGdZelF6?=
 =?utf-8?B?M0Z5cFVvYXlNR1JjS0gyQ1VHQXJkRlh5K3hXUGh3M2k1TGhXYXdNa2xZZEM5?=
 =?utf-8?B?dzFxYVRENGIyaFFqMjJIdTVJKzNqbVJzdGdUUTk4MkpXejBLTWUwZWNxSE5E?=
 =?utf-8?B?eCs5US9YUFQ5Um5wdjNCK3lMNnB6Z1Y5RElVSXFITmtySmljS2lvNE9rQUJH?=
 =?utf-8?B?WVNlSzk1NlRWNVlGQUxueTFCb1BsczFuSGc2eHFjQnlwL2dCM3ZWeHRBdVcy?=
 =?utf-8?B?MzNvdVBOa2xrWGFVamgvcVhtajhsRlNibHp6dk9LdWc1MEtyVHNiRnFjVkNn?=
 =?utf-8?B?RTdPWldGK3grSElaRE40WStyRFRlSy9nbXRhV0JmbkxsRkQzVW1HSlQ4SmZI?=
 =?utf-8?B?TTg2TEdDRzZCZEZaVjN3L0pMMTF5VktSUitjOW9hYndVMUNCU29HSTk1Rmdx?=
 =?utf-8?B?NGs5UlU1TGkvU3RSWlowUDFtdnZnRSt1QkJienorUEszYUVXb091NjFmRVNo?=
 =?utf-8?B?OVpudlY5L1lGbURObzhTZ0dNcCs2alpYVWt2WEUrWitYODArc1JxZWxmdXFw?=
 =?utf-8?B?eEVQcDROaThFSVh2cFhCTGtDQkZNOFE5SDhvSmFHelRUbXRCbTNtWEkyU1Nv?=
 =?utf-8?B?QlRtWmlqV2JwNUY5dS9Eejk4N042K3pKNmhrM2o5SEZicW1zUXdJazIzSDE0?=
 =?utf-8?B?dWMyTTNTTDExVW5vZFRaQWo2aDZ6NnJUL25WSTNubEs0akdnWUFIa1R3N0tJ?=
 =?utf-8?B?Mk9ZVHdWMmNqcjBZVWl2KzcxREpud05jOThvNGhNQjZvMzl1TkM2akNaZVZH?=
 =?utf-8?Q?D7sMAfNrNQvjWYukUboxpeb7G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf58c311-1919-4ed8-93c4-08dda98dabcf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:46:49.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUFpCM7phR4IlyFARTRqbtwvxpHJnDwIikMvMFfngW//vzZAoQeGwNGXetsRq3ndVoRcwAbL2KjITkeF1hg0cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

On Wed, Jun 11, 2025 at 10:16:18PM -0700, Mina Almasry wrote:
> On Tue, Jun 10, 2025 at 8:20 AM Mark Bloch <mbloch@nvidia.com> wrote:
> >
> > From: Saeed Mahameed <saeedm@nvidia.com>
> >
> > On netdev_rx_queue_restart, a special type of page pool maybe expected.
> >
> > In this patch declare support for UNREADABLE netmem iov pages in the
> > pool params only when header data split shampo RQ mode is enabled, also
> > set the queue index in the page pool params struct.
> >
> > Shampo mode requirement: Without header split rx needs to peek at the data,
> > we can't do UNREADABLE_NETMEM.
> >
> > The patch also enables the use of a separate page pool for headers when
> > a memory provider is installed for the queue, otherwise the same common
> > page pool continues to be used.
> >
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 5e649705e35f..a51e204bd364 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
> >
> >  static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
> >  {
> > -       return false;
> > +       struct netdev_rx_queue *rxq = __netif_get_rx_queue(rq->netdev, rq->ix);
> > +
> > +       return !!rxq->mp_params.mp_ops;
> 
> This is kinda assuming that all future memory providers will return
> unreadable memory, which is not a restriction I have in mind... in
> theory there is nothing wrong with memory providers that feed readable
> pages. Technically the right thing to do here is to define a new
> helper page_pool_is_readable() and have the mp report to the pp if
> it's all readable or not.
>
The API is already there: page_pool_is_unreadable(). But it uses the
same logic...

However, having a pp level API is a bit limiting: as Cosmin pointed out,
mlx5 can't use it because it needs to know in advance if this page_pool
is for unreadable memory to correctly size the data page_pool (with or
without headers).

> But all this sounds like a huge hassle for an unnecessary amount of
> future proofing, so I guess this is fine.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
Thanks!
Dragos


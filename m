Return-Path: <linux-rdma+bounces-4246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B294BD4F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 14:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234F31F237BA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1718C937;
	Thu,  8 Aug 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDIgWcnX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF718C906;
	Thu,  8 Aug 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119862; cv=fail; b=pIYwZ0IsGSHjTy1b2zwuhGoWVNZIL+CaWeGNdbOdClOG4tXX6o3R6UNcJuEp8j21LatxqvOW/Yofgk37jcAZAg/apfycFjNKkuPtmgGYeRzda94uKQwSTn9Hcq1XZGcqbPBuJDoBRbxNwxSkjMcZUSAnZiqw0tdEjiKWu8gdl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119862; c=relaxed/simple;
	bh=3CH+kqNQIoZ5b4AIcTiZ1xiDlc/lzUVHlUuHHd1zzjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=engjXRmUn7ZIuKnkPBa9ay8mRjuYg9xUpEQXL/Tt503RfCVzeIK1S/SjlOAPCleK2z8aZ61xPpsJfl8fg86QrJTbnMkchAijGJU3Fni4Pyztu/VHfYTkRMKajrxOK6KhhuXE9sWWqtQgrIMJJmt1bn9J67g1f+kpE/QihnlODyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDIgWcnX; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geMYH2S/RweBeDUKccML2KtSan7YC8MOKVy677j52T2YpYn0cW3qR93+E2thHbFUIPukvm25lxd4mKJPWquy6E/Ou+u7kZhjRs8AAPNk6TvAnf1mCrLC6c4kYqtclB/hgdKOq5PYHIDy8N80PNya73qm29qyMgG7ARzvOQqHptNLYlNbDKhMTcC3yLMHfK4mNmq/VylILQM7CcivCXTzp/TBB5Lw0wnwLClGbWXEuJzynuqWhC6NxRKUY+lzM9HuL7LzDOfTQCrtGoey1/DDdasIwLjrXuliQDGGb8AkoZlIg+aDmqYNNNs9ATqJ9AIlYl5x90PVRFIxL3WW82y/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkcKKZlatllHzkTUcIPlRn0/OGI98Ww0dsnRoPSAH5w=;
 b=AQepOapBge4NHzizjc2/CokJJusuQsZc9TxYx2LBjyhrjJzwICdNLGXx7whV6oIPiDVnhc9FUJ7HfBvaJ9jx0+MCbRoim+kixsmyU8x2Z0n3zUYkHUztDIB7ZUFqo1slShHPzlYx0VK7tx2G7sH57/tllE2xQJtl1S4TOBb+6r+UPXzvFJmUqxjatqT6U2gMesiqoQUzIIJqCzoQC0ZP+EDj/MajxVHpo7s12DhlEHtNHip+efZMb8L0gmMG9lbraHYpJEcU9opRCyI8iUzvvlKFvL5hExax7OU3gaqU1ziVp+JsFJBuI2BZAOHBxMMWBmzjJeVSVuwOQbgaSJ5rkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkcKKZlatllHzkTUcIPlRn0/OGI98Ww0dsnRoPSAH5w=;
 b=LDIgWcnXtuJzN3zWN+gyvzO+DZt/QfiXUGNwZcwgnqHU8ndW9OKIWOS5bjviUaG9+YNt5rLL3YsbBBYOVmDUA6j5Ku9LrFba5cebRLVGvNRl7DcXqmypOTaWKVtMWAg0FPcgdn69C+kfwR5ZAHunwhAxOzeKrVvEfJBtP8yfNftHKhbU6dhloE/ES1C1KDDu3NlH+edbO6J7t6jqtm0ND40KXzXzycseOd58velUxroXj/s2GFK3FfBWNVT9cvtgUmyn8eQM+DExprlTzb1vr5+44EVTpY/g8miepmgoCKCt72XaEMkN3eH/UccI8AXQBPvNzOdruqU4Bu49tNzm5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 12:24:16 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 12:24:16 +0000
Date: Thu, 8 Aug 2024 09:24:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
Message-ID: <20240808122413.GB8378@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <ZrHY2Bds7oF7KRGz@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrHY2Bds7oF7KRGz@phenom.ffwll.local>
X-ClientProxiedBy: MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::27) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3954f591-e9bb-4b2e-2540-08dcb7a504f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFNvekZZWHpaMzZBMjNjTk5NUlh6eDNKaTZJNys0Y0FEc0pNQjRrZkNrUCtz?=
 =?utf-8?B?ZmQ3NytDTjNUTVJmSi83eEJFMjFUUjRWS0lINmM1Tk5mUlkrN0JnRnFUZ3FR?=
 =?utf-8?B?SnlSRC82aktoNHFvL2Q4elVoRnQvNWdxVnNjODZteG1lZlFCYUp1cVJ0d0ZW?=
 =?utf-8?B?cm1QVjBWT0czSVZBaVoycU04U2V4dWFxVnk0aXdRbVRhNW1IMXN5Y3pZd0N5?=
 =?utf-8?B?ODZ0OE0yYUllUkVIY01CZjVUMEZDSXI0ekJvN1A2NkRSZ2R4NU9FQWFFdnNh?=
 =?utf-8?B?VWpCeWpNVFg1UDFPTWNUang4VlhQbnBBR2doUVMrWTlMbGQzVDlONHh6NDRi?=
 =?utf-8?B?UUJCeHhFcUdlaXZZZDhLaXFKaVVhQ1YvZ1hiWEo4OHg3M1BZVVFnNkVFQ0NK?=
 =?utf-8?B?MjlaOGVsRm9zNXdCSmxuM2hjT01qRExBUFh2bU5rUDdJRHBrOStSQ3FCM0da?=
 =?utf-8?B?TXJvZWpjakhvSzkydjNnNG1ONUJzL3BGTDdFMnUvZUxFUXhEM29hNG5nK2JF?=
 =?utf-8?B?RmNIQ0dmbW5MSTNnTUxjRVRuYkpoOTUxdGoraSt4L0kwOXZTRkRMWGdkOThG?=
 =?utf-8?B?OVBkMjB0VTdKS0MyN1RMd1FTb1c3VG52dVIrRzB2ekN0WWxIZG5hNFdWMVVF?=
 =?utf-8?B?dzRQME04QnVwODVaODk2bVZUTEZWSTB4b2tuZTl5Mldha2U0UzNLVkpCTkFu?=
 =?utf-8?B?NCs3eFF0NkJFWmdrMWZiTnNKeDZxak9UU3Y5YkFmZ1FOaVBXaTk5aVpEdUpJ?=
 =?utf-8?B?QVBhNkZLa2Vrc3d4dFdZUzBBRWljU00vN1NScnorZ3FLaVREMkpucjFtZFRK?=
 =?utf-8?B?bTRXVkFXbmtMRERCWFUzV0JtcVFkOGM2RjhUT3lQc29LWU1aeGhGNnk1RVlG?=
 =?utf-8?B?eThiZjRxQ1Y0ZUNqVFQrRlhtQUwvOGoyczQ2YUkrcVljd3dWVkgyMnArWXJ0?=
 =?utf-8?B?NXgyRS81dmtwY21zR1ZKNWVOS1RaRGFmRVh2ajNaYzlWbGdjS3ZodWlNKzB0?=
 =?utf-8?B?aktSY3pUQk5ZWW5RTEw1MmR5N2h6ditkREQrMWhGRTFkVEs3MFNCc3VGa3R1?=
 =?utf-8?B?NldMNUE0VEVWdjFKQ3ZVRVh6dXBCWjBsV3FNeUVZbDh3a2x1WmQ3VlBiQjZt?=
 =?utf-8?B?YXduOFFLQ3VZaVZlZGgvSHNuZnVNem1XSE1EYzNNc2phdE5BaC9mVCs1S0dS?=
 =?utf-8?B?UHlQYzZqRGVpNGJwTGVPdzZncHdHeXdLWG5KZG5RRDduazg0dElYbUprUlRp?=
 =?utf-8?B?Mml2VXU0S1FYOGNWNVNPYURDRjBjSC9IZk5IbzdDSmtNY0cwQTBtTjNmS2ti?=
 =?utf-8?B?WlZ3cUZOTmp1RFZWUHI3RGtIWDZPK1pHdm1KSkVXYmtCaWVqQXRWV2VtWStl?=
 =?utf-8?B?anVyMlVldVRROCtQdFhuN0xHc0thNFplYkFxMHZtSjArWXNnWGFKSEI5aUFt?=
 =?utf-8?B?bGsvTTRGdjVYOVNpdUE3SjJmV3ljbWR5c0IvUENHMlNTTlhqUmw2elV2c01R?=
 =?utf-8?B?SjZRbGVDaW96bzZVNTM2ZHZINHFEZ0FDMFc4Uk9OWGtxNWZGc3NtTXlxTkps?=
 =?utf-8?B?M1RTQnhJTWhJeldQTFlINmVqcE9zWlFHT0V1SUFNMlBkWlVnUTFORFE2T1lq?=
 =?utf-8?B?TzZLME85V2RPeU0xRXk1WU1oaE1iL2xtcVIrS2J5d1dMdWZrM0M4VGRoRnlQ?=
 =?utf-8?B?VDV3SVltMVJHd040ejhZQVpuaS91RUFoSG1hWVIxOUIzdm1KcmIyS0RYSlZj?=
 =?utf-8?B?RDdLMGZOWDg0SHoyaFMybkdmZnJkK0tVdGFkYUp1RE9JVTRqajM5b1BMLzlH?=
 =?utf-8?Q?Zv5Ah/6E1MetRKbbim2yJ3H1hzOIYb185MRPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFExY2x6bmlVa3BMeUU2aXZSTTZ5Njg0OW5ha1l1eHhid3BZWUUxeUxnanQw?=
 =?utf-8?B?N2YrQnA0L3c3aVA1eHZxMEw1YU90ZDJ3Y2hWTThMY1M0L1NweWpRNWM3UFI0?=
 =?utf-8?B?d1pHV3lURWx2Q0JSM3QyWUlhQ0YrNHZURDRUS1hIb1pPSVBSQ3FZeUl5TUhk?=
 =?utf-8?B?dVF6UE5wOTJsUzdPNSthNGp4d1cvZzk3bENOVXkyMzZSN243dmgzWmsxOEpR?=
 =?utf-8?B?OUJTekhhNWhxdFVRc0E3bmpaNk9HMEVlc29DRnFkd1NlQUhnOUs2OSs2ZjJh?=
 =?utf-8?B?aWhJQVFnL1pteEVsNkhESnZnWGwwb3R3T1ZkVkV1NUx6SEUwU1h3S1ZleG03?=
 =?utf-8?B?WURkd2ZjOWlHdHJueXJlZCtmcWVyaDZGWkRyd0dPaFRZOWdZV1Zna3BvWFdI?=
 =?utf-8?B?WlFKZmpoVGoxVktMVWV5dFVzYTVONlpGZ3RESmpzQndVa1lhVHBMOUFwOUZX?=
 =?utf-8?B?SkRYVFc3MjNLWXZPdmhHWXBUWHdYTE5YSE9oMGZ0QjRxUDdNeHZHeTBXUC9U?=
 =?utf-8?B?M0F3ZXJiUTU5VG5iMXUxYjhlRmdlUVZNTVh4djlraDMzODFuSURwaVVSVUZO?=
 =?utf-8?B?V01LMHlQOWpnMlJaTTU0VTA0MERTaUU5WUl1R3EyRmRKSytvMElTMjRpYlBn?=
 =?utf-8?B?bS91TVc0cm9EYWVZRFVpRUR4aERtUUZUTlpvWlRhWEpXRE54YnV1NEI2azRp?=
 =?utf-8?B?YlVWaGdVRm1NYXRPQWY0N1lyMGh2UDRBcGlpQmJ1M003NWtDRWhRejY0RExY?=
 =?utf-8?B?ZXdCMmFPaytOWHFlVWVzL2VEU2pzY2VwVVhQTlZWMlgzSGVxL3lWdVZ5SjZW?=
 =?utf-8?B?VjBWaUFMYlFPZ2kwTkJmUnNpMHFaK2dOUnYyS2NsV2xGYitGZ3dST2RHeXJP?=
 =?utf-8?B?RVBYbkRub3EvWm4rOWxKZHR1bnZ0LzFjZW9QczBOSmZwb0Y1cjh3QzcwcTRD?=
 =?utf-8?B?UVpxb2FRWFJ4WG1FMDNQYTZzZzJERjRlV3duanJQMUFEVXVGTDdRbUhub1Fh?=
 =?utf-8?B?WjRWdWk1Y2JsT1RtZEMrMHR2ZFUyM2JCR1NObE10cnY4TDY5cFY2SWZBQnFn?=
 =?utf-8?B?VkFkb0lqNHVNRHRXc2h4bjArcmpQS1VHTDNqMnh4NnR2VFA1K0JrTDJ1c0Qw?=
 =?utf-8?B?aWFhVk5nUXhwMmVQZlA1YmlLS2ZxNExuMURXUGFMWkJFWEtOU1VpWXViWWI2?=
 =?utf-8?B?RVhkRTRwNUE5R2p3WmxnVjUwNVFvbDhHNUNML29zUEhXVDFQMHZDUCtmc1ZJ?=
 =?utf-8?B?ck9sRUhiY2VZa01pT21oSE9oc1dYaU1LcDRwa2ZvT0IzZ2orZUM1NEY0N1M4?=
 =?utf-8?B?WDg1ZjFZVUNNVTk3TTJvMTJhUHF1YjBDN2dFTVVlSk9VVDZNME5NMVBSRS9n?=
 =?utf-8?B?RkN2QUVBWVdIcFRTSEl5SUhHUlNFd05WU0xMNHEvTkU5N0xrYk5GM3RIUlE4?=
 =?utf-8?B?TFRqdktpbmpZV080VE5CTFltSFFYdHd3WFFPSWluREpTSXRxdXJaTkxaSWxF?=
 =?utf-8?B?aExUM2VEMlZ4TjdhVVRxS2cxM2xWZjl6aUpnWVZUUnNEMFJaMFJRd2N4emR6?=
 =?utf-8?B?QjhTYTRvOFM0Vk9tL1VhUzRvaUkvUnpKQmtodCt1aGl0L25JWlY5VGIzUjhs?=
 =?utf-8?B?eG5SWGQ2ZVBMcGgyRUFZZXZYTFA5UDdwK0lTMENFdmljOEY4NHdFRVVEOTNr?=
 =?utf-8?B?dExvTFNJWVpkTnBIdVMwekpuRUpwWkJsSDIyWUJGL3pHTHNQQ1JEaHNFLzNM?=
 =?utf-8?B?L3lqS3pLc0MvYmxEelhSMWxPc2RoZVRJU1IzYzhCd2txTmZVTG9QSVdUYVg2?=
 =?utf-8?B?ay95SkYyUit4QnkvR0Y5UzdJM2p2MFpSKzA4R2tRd21wVUozVE1Jb2FyV2tC?=
 =?utf-8?B?bjB2YTlUVUs2L2ZzV2xwampHQWZRVXE2M2x3dS8wYXZRZktvZ25mQU94bEhE?=
 =?utf-8?B?RDBrSmxnL1EzcGVqc1R2K3hobmMrd0V1K05YYUJjNDlmdEl0cDM3bThNcVA2?=
 =?utf-8?B?MU80MkZwSjAxb0NiT21iS1NFM1FOQkRxYXJ4YzREUFo0OWZxbWQxWE9reTdZ?=
 =?utf-8?B?dWM3N290OUsyWkthaW5RU2RibVJiSFpiYTJXQW9TcmFVeExzUmZKTmpSVzRK?=
 =?utf-8?Q?8ZSQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954f591-e9bb-4b2e-2540-08dcb7a504f3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:24:16.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk8vo4kMSbB0pIbm9aax+sR6/Rn7cwusaWskeZDX/baUiVvlWcB2APWrn0efiUUX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

On Tue, Aug 06, 2024 at 10:03:36AM +0200, Daniel Vetter wrote:
> On Mon, Jun 24, 2024 at 07:47:30PM -0300, Jason Gunthorpe wrote:
> > Document the purpose and rules for the fwctl subsystem.
> > 
> > Link in kdocs to the doc tree.
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> I think we'll need something like fwctl rather sooner than later for gpus
> too, so for all the fwctl patches up to this one:

Yes, I think so as well. You can see it already in the various GPU out
of tree stuff where there is usually some expansive
monitoring/debug/provisioning tool there too.

> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks!
 
> I both really liked the approach to fwctl_unregister and
> copy_struct_from_user, and didn't spot anything offensive in the code.

It is copied from iommufd which copied concepts from the fixedup modern
rdma :) Proven over a few years now.

> > +Further, within the function, devices often have RPC commands that fall within
> > +some general scopes of action:
> 
> In your fwctl_rpc_scope you only have 4, not 5, and I think that's
> clearer. Might also be good to put a kerneldoc link to the enum in here
> for the details.

I bundled these two together in the enum FWCTL_RPC_CONFIGURATION:

> > + 1. Access to function & child configuration, FLASH, etc/ that becomes live at a
> > +    function reset.
> > +
> > + 2. Access to function & child runtime configuration that kernel drivers can
> > +    discover at runtime.
> 
> This one worries me, since it has potential for people to get it very
> wrong and e.g. expose configuration where it's only safe if the driver
> isn't bound, or at least no userspace is using it. 

The notion was "at runtime" meaning any active user of the device
would either not be aware of whatever change or already have some way
to learn about it.

Especially when we think about child configuration - ie configuration
of a VF from the hypervisor while a VM is running - there can be
useful things that fit under this category. For instance you might
throttle the device to support live migration.

Throttling is a really complex topic for an autonomous device like
GPU/RDMA.

> I'd drop this and just
> leave the one configuration rpc, with maybe more detail what exactly "When
> configuration is written to the device remains in a fully supported
> state." 

Ah, this language is incorporating the distro feedback around loosing
the ability to support the system.

> from the kerneldoc means. I think only safe options woulb be a)
> applied on function reset b) transparent to both kernel and userspace
> (beyond maybe device performance).

Let's lean into transparent more:

 1. Access to function & child configuration, FLASH, etc. that becomes live at a
    function reset. Access to function & child runtime configuration that is
    transparent or non-disruptive to any driver or VM.

> That might not cut all configuration items, but for those I think it'd be
> best if fwctl guarantees through the driver model that there's no driver
> bound to that function (or used by vfio/kvm), to guarantee safety. So
> explicitly split them out as runtime configuration with a distinct rpc
> scope. Maybe an addition for later.

No driver bound is too strong. VFIO and even mlx5_core can trigger a
FLR while still bound in a controlled way. Taking effect at FLR time
is a reasonable restriction.

Like if you reconfigure a child VF and then start a VM there will be
an automatic FLR in that process that can make the updated VF
configuration active.

> > + 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
> > +    driver can react to the device configuration at function reset/driver load
> > +    time, but otherwise should not be coupled to fwctl.
> 
> Kinda the same worry as above, I think this should be "... but otherwise
> _must_ not be coupled to fwctl".

Yep

> > + 4. Operate the HW in a way that overlaps with the core purpose of another
> > +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> > +    network packets, or operate an accelerator's data plane.
> 
> I still think some words about what to do when fwctl exposes some
> functional which later on is covered by a newly added subsystem that
> didn't yet exist. Also maybe adding some more examples from the RAS side
> of things, since that's come up a few time in the ksummit-discuss thread,
> plus I think it's where we'll most likely have a new subsystem or extended
> functionality of an existing one pop up and cause conflicts with fwctl
> rpcs that have landed earlier.

How about:

Operations exposed through fwctl's non-taining interfaces should be fully
sharable with other users of the device. For instance exposing a RPC through
fwctl should never prevent a kernel subsystem from also concurrently using that
same RPC or hardware unit down the road. In such cases fwctl will be less
important than proper kernel subsystems that eventually emerge. Mistakes in this
area resulting in clashes will be resolved in favour of a kernel implementation.

> > +fwctl Driver design
> > +-------------------
> > +
> > +In many cases a fwctl driver is going to be part of a larger cross-subsystem
> > +device possibly using the auxiliary_device mechanism. In that case several
> > +subsystems are going to be sharing the same device and FW interface layer so the
> > +device design must already provide for isolation and cooperation between kernel
> > +subsystems. fwctl should fit into that same model.
> > +
> > +Part of the driver should include a description of how its scope restrictions
> > +and security model work. The driver and FW together must ensure that RPCs
> > +provided by user space are mapped to the appropriate scope. If the validation is
> > +done in the driver then the validation can read a 'command effects' report from
> > +the device, or hardwire the enforcement. If the validation is done in the FW,
> > +then the driver should pass the fwctl_rpc_scope to the FW along with the command.
> > +
> > +The driver and FW must cooperate to ensure that either fwctl cannot allocate
> > +any FW resources, or any resources it does allocate are freed on FD closure.  A
> > +driver primarily constructed around FW RPCs may find that its core PCI function
> > +and RPC layer belongs under fwctl with auxiliary devices connecting to other
> > +subsystems.
> > +
> > +Each device type must represent a stable FW ABI, such that the userspace
> > +components have the same general stability we expect from the kernel. FW upgrade
> > +should not break the userspace tools.
> 
> I think an exception for the debug rpcs (or maybe only
> FWCTL_DEBUG_WRITE_FULL if we're super strict) could really help the case
> for fwctl. Still not allowing to break individual rpcs, but maybe allow fw
> to remove outdated ones. 

I'm definitely mindful of Linus's pragmatic view of ABI stability, where
existing tools that *people actually use* shouldn't break. You
shouldn't have to upgrade your tools when you upgrade your FW.

I think it is important to convey that as a the gold standard here
too.

> And especially for field and even more in-house debug tooling, you really
> want the userspace version matching your fw anyway.

Yes, this is definately the case. But those tools are also private and
I think fall under the *people actually use* exception.

So, lets try again:

Each device type must be mindful of Linux's philosophy for stable ABI. The FW
RPC interface does not have to meet a strictly stable ABI, but it does need to
meet an expectation that userspace tools that are deployed and in significant
use don't needlessly break. FW upgrade and kernel upgrade should keep widely
deployed tooling working.

Development and debugging focused RPCs under more permissive scopes can have
less stablitiy if the tools using them are only run under exceptional
circumstances and not for every day use of the device. Debugging tools may even
require exact version matching as they may require something similar to DWARF
debug information from the FW binary.

> Currently that mess tends to leave in debugfs and/or out-of-tree, so
> there's no stable uapi guarantee anyway. And I don't see the point in
> requiring it - if there is a need for stabling tooling, maybe that
> indicates more the need for a new subsystem that standardized things
> across devices/vendors.

Yes, fwctl needs to have both. I would expect things like the
configuration to have a fairly stable ABI. Maybe the list of
configurables will change but access to them should be ABI stable.

> > +Some examples:
> > +
> > + - HW RAID controllers. This includes RPCs to do things like compose drives into
> > +   a RAID volume, configure RAID parameters, monitor the HW and more.
> > +
> > + - Baseboard managers. RPCs for configuring settings in the device and more
> > +
> > + - NVMe vendor command capsules. nvme-cli provides access to some monitoring
> > +   functions that different products have defined, but more exists.
> > +
> > + - CXL also has a NVMe-like vendor command system.
> > +
> > + - DRM allows user space drivers to send commands to the device via kernel
> > +   mediation
> > +
> > + - RDMA allows user space drivers to directly push commands to the device
> > +   without kernel involvement
> > +
> > + - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
> > +
> > +The first 4 are examples of areas that fwctl intends to cover.
> 
> Maybe add a sentence here why the latter 3 aren't, just to strengthen that
> point?

How about:

The first 4 are examples of areas that fwctl intends to cover. The latter three
are examples of denied behavior as they fully overlap with the primary purpose
of a kernel subsystem.

Thanks
Jason


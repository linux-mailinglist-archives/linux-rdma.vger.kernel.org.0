Return-Path: <linux-rdma+bounces-4812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53997053D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 08:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96801F2175C
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69154D8AE;
	Sun,  8 Sep 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNL5PzG2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6543EA98
	for <linux-rdma@vger.kernel.org>; Sun,  8 Sep 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776351; cv=fail; b=T2N7jIVsTyDqZ58mPLGBh0n3OqMKSGnMS5DR4w8VuIuGP+yu6Ea3QJB5VHRZu9bgKkvbDxrIX8qH3J/nM+TYY9h/iVoJnmzCERmIStBSnpclpHbF7TIWuOxJyo6eO23YsRiSjvGpEpeWC0AfugkpDcoTdNpBdn9I3zT3r5ENL9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776351; c=relaxed/simple;
	bh=o9v5yRN1Itjp0rixv+AWSCawlyuLEqBLd3K7nfHKAJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UwYFQ4+G6RvZ/y2ewpbxhEFqtH9BK0tFy4niz3egaGHuaNyBeInN7LMyZXoencH9Hsl26piA0YIShurXQD6zEhnyeaCvX8gT5fPfR9jh2bs8aFu+oFc0VkMOhERvSz93sETtrXFAKRc6SLp1848MeGQB6+C8LPNoSA4OeFdGSGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNL5PzG2; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktA2BSQUur3nAy24gEnXgdHT0O2Nqkg8j9HPJoghBXx5SkM7AbPHvdpoDUWFXVDA7rKcgK+xJI+ESu320K+LyKdHSb8YSL2Yy0yzN6Fbp7XQCdJha5RH9Rn+EwYsblENj33+ywqxXDlHxdv8FKUk7n8VI374My/aaeqlMumqCTT9JMEna8oZZjzwnwoor7UlaFrHP7EGbPbNiiKbieLjiZXHnkByX8hpda1478GB22sizJ75k4oRNDYhScJx2wZrKOq8EKaUlFQQYuYsnOy1lHAz3KC9YLgQYqwLNO4W/379fUKQ5m9OFxmma2ckk0mdTnrMQNwLbvXPeVDkStN7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua130uTl+lWYgIaa7Q6AtoAwNDRVzs+Pm0w6ILHoC6I=;
 b=YdWuqfDieqr2fLV6lASfKVw9xPtV4zvIEvBN5nOkocVWGH8Yx9YEw2nBX6P8bMvBgheyKHX5lsG7jmHym54sUXF9EQphlObn7ROYeb554bNfHVpaWNdVh5RnFmaBP4KGXT39/uH9M3KhZXRd54jolYX/WBuxcWZn7I+EmQr4SxozEMikNG5SFnwoJ7aL2wB1lK/1zVh+Y6CSl7I5oOOZOSmd0B6y/xYFY4cQnTB2hnTFOYF8FvKbWkDcMyvSJ4p/c5pBK+7CRVpBMiNstr6R5JpnwEWd/Nzd+Cf13g2V0SraLWihrTButUFr6M+aRNOVTPKx7IEvDDkCeoWCMx9hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua130uTl+lWYgIaa7Q6AtoAwNDRVzs+Pm0w6ILHoC6I=;
 b=ZNL5PzG2kV7slYWEXFDwNPuh4NSFaJg2+tVK9ZMHQvsMSQY5xCZbmhsCj64E8Pzjc3eejyV4xQv5TSsPbTF9CsJnc+1toZ/qgvanXN0FIfR6DlYLwvU8RYmWuykiYDMxfDgBTH5KC/6AOSiqIhCXSo+8oANzZxS0OigXNZuynKg+F6PGXZiXpaU2i2CFVvNrKwOPaJPPuBfSa3haw9UiZTuuQvId2eErlgLtiN43MHAIQQNwACl6izhn2NtRQnER3fqvsqRyFo/SwOX0otslYFNIU3xjzk5OMotGi8Eegg5u01ODE2Qm5SjOKhRNkkhcAtvxuVOt2nBt/Q9rpemHlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 8 Sep
 2024 06:19:04 +0000
Received: from SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c]) by SJ2PR12MB9086.namprd12.prod.outlook.com
 ([fe80::d1f8:1abb:a524:9a5c%5]) with mapi id 15.20.7918.024; Sun, 8 Sep 2024
 06:19:03 +0000
Message-ID: <d0f1e3c2-ac81-4126-bccd-615cd6ed3453@nvidia.com>
Date: Sun, 8 Sep 2024 09:18:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
To: Zhu Yanjun <yanjun.zhu@linux.dev>, leonro@nvidia.com, jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com
References: <20240904153038.23054-1-michaelgur@nvidia.com>
 <4e8e01d1-359d-4877-ac6c-29f4fc512fb7@linux.dev>
From: Michael Guralnik <michaelgur@nvidia.com>
Content-Language: en-US
In-Reply-To: <4e8e01d1-359d-4877-ac6c-29f4fc512fb7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To SJ2PR12MB9086.namprd12.prod.outlook.com
 (2603:10b6:a03:55f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9086:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: d27c9b7d-2328-49a2-099e-08dccfce22f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0xRa25sWUNPcDE4bUUxd3Z4VlM3dFBkOXFaZlpPWEtFYktVcVMxaG8vbXU0?=
 =?utf-8?B?Zlh2bERsN05wRUYrcnhJNDcrL2YzTkozdU8zbjYwcDlXUC9RUDhCdHVNS2ps?=
 =?utf-8?B?STNteHFMNFB2U2Znc3oxY1JXQmtocCtNQUR0MWpDZmRWVXcwQVdPRCtldis5?=
 =?utf-8?B?cG1uNlhDTk9NUVE2SnRwdFJ4MVA0TC80VHViU3MySitXQ1JjOVFtQnAxMFRW?=
 =?utf-8?B?VGpTRGE5a0thWis4MkJEUVkrR1RUdXlrSlRzYWY4KzNBd1NGSnJDQzdrK1lZ?=
 =?utf-8?B?dWh1QWhMc3JlRHMwcU9MRGk5N3RrZENzam1tQ2E4d1JvdEY2dzlJV2lYOFdx?=
 =?utf-8?B?ZWFRelZZaFJzVjFXeXBmTStlVFNvbHJ5d3FXWk05Z2hCRlhMVFdncGtvYksv?=
 =?utf-8?B?b2pBV3BON3JxSWgzWGlNODV4bE9pU2VpaHhVdmZubW9nY0lkYUZpU0hnS1Zi?=
 =?utf-8?B?OTJvZHFuM1FzakVTVmozSEFKa3Y4a09YUzZmdWR1OEloOFg1YWlKcUFrUU1j?=
 =?utf-8?B?VjY5NVFkUlNmejZjVC9BVEVpNkNOeEV1WlVLeFFDVnJMZ1dLZEF5ZWtaR1Vt?=
 =?utf-8?B?WFBiMlR5WnNta2RWd0VpSDNhc1ZPMVF5aW5JWnJrZ1N0WE1YMlVSb1RGN3dn?=
 =?utf-8?B?YzhtL1puRVhIOHRTcW5zN3FweGhMMlU2U2YybityNVJnaHhXWlJKWFRxZ1hF?=
 =?utf-8?B?VmNuU2gvRml5d0crWlpDZ0t3dklZTWJXSGpqbDZnWWhycmxRaXRCcXZrUSto?=
 =?utf-8?B?TmowK0hhQVJLL3FQZHhxSWZDU1pGS0RHT2VLT1NQREpIeGc3ZmZrM0piR0VG?=
 =?utf-8?B?ZmgveEk4QTUyUkFHS0xUTWFSUGl2TWJJNHRDZ1cvc1p1d1dIMm01K2hEOG1I?=
 =?utf-8?B?Nk1WYzhScEtjOVNWYTFhZWdkc3krcXA5c3M3TzF5KzZ4ckxCdlpHZkxHWmk5?=
 =?utf-8?B?YmNzWU0vekZtak1Sa3MzdEs2TXBOcmcrS01uREovVWZwOEdEM2hGQjhnMGU2?=
 =?utf-8?B?Qk9XZEdiNXR4NlByVTZUTzdIdHNFYldLamRmVWR3b21wd2k3djIyZmRpTFFW?=
 =?utf-8?B?dmdONnd0NFp6bFJOM3M2RTBCUzVWVElCTXpOOTV6T3VsREZ6WTJ1Z05NYnMz?=
 =?utf-8?B?SzlsWTdFK3EzNDlXUVNHcjhZd25UMERSOEZuWlBlOERIM1lTS2x5ZkxiQWNQ?=
 =?utf-8?B?NFZiRzliL3cvbk1OQWRyVk9wZXBxRDg1aGFBcllEY2o1RVcyc1pvYVdXN29W?=
 =?utf-8?B?bTNxUjNqVkFSL1ZJa3FuTEpYVG8rSFA3Z1B1SEErVEJYYVZHdHRUZ2ZkRnZx?=
 =?utf-8?B?TnVNREd1WFRWODBjUk9qYklFRHJlWGxYUG5TeFlHdmtMU1ZORlp1b2lReXZw?=
 =?utf-8?B?NWxLWmRFMG9uUmlyTHEraVcrQ2xoYXIzZmd5aVJ0dk9GeFBYeU9NWVZwc3Fv?=
 =?utf-8?B?OVhhTkdwMU41SDFacVg5WjVzaUZWVEZnYUo4ZXpxWEZDbzk0c1gvWVpZai9w?=
 =?utf-8?B?NFQvT2h6dE03cHZEcUVGNzk4TzVmcWZMRmhVVG5CWjd1dTA5Vk9sTjQ3aHZM?=
 =?utf-8?B?RDErNmo4N2ppdDlscHA0SjZ0RWp4V01CU1VPclNvTWhKTzg1cFdKT1lneFpL?=
 =?utf-8?B?c2lGZVBnUVU3SXFoL20rSWNSQmhkRG9JbHhzTmp5dnduTkxIMDA0bWdseGtj?=
 =?utf-8?B?QklxdzdlaFYvL3JxU1pCNjRkd3l4dHl6d0llUHFIbmNtWXVneDJnMUIvUkk2?=
 =?utf-8?B?amlTSTFwYUYxSmJpMFZXZkJpYjhxZ2t0NWZDM0VYU3ZFOUloVTFwZ080bUFy?=
 =?utf-8?B?MlJTZm1icm5ac2hnZVV4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpwcXM4TEo2UzMyYjJ4MEFibVMwbmtYcnM0L2pzazJZNXgreUlUQ0ZvL3Y4?=
 =?utf-8?B?SGI1Q0dOQUpXWnlYb0EraXNtL1dDaTRGcFZiZFBZWjlqOWc1T1NaMXpnMlgv?=
 =?utf-8?B?Rjk0TXhyclRNemZod1JLeFc0ckNFSG1ac1l6bk5RdnRaNG9ML1N1WEZVQ3Vx?=
 =?utf-8?B?RW4vYmFWdElIOHVHNkNJeUxoQUpFckhMbGF3NHFudmV5WUVYVnd6SEFlL25V?=
 =?utf-8?B?MStUZll5Y1l3dTQrVldGbjkrcVhjeEJOOGUvNDFNeWtiZkVDdUEwdTRldlRw?=
 =?utf-8?B?bTl5OFZtdDJIZzZjeTFRbVlMclVCem5wa0hsYkNOSXpzWCtWWnVYcWVTenVE?=
 =?utf-8?B?Um9UTk9lSExYekU0ODBZOTZxL3dRUjZEVWN2MDBFRG5QZHBWSmxyQ1A1Z0ZL?=
 =?utf-8?B?TWkxcStsNXJrTjZlajJZSVlWNldKUzE3NGFSa1JRNjZKMnRNTjlDbmpqdCtn?=
 =?utf-8?B?T2gwZHhSV0MvRnl5cWlSWXB0dHpMd2ZzalZHTkRmVTFRVVV4VXRqYXpwOUY5?=
 =?utf-8?B?aVVEZ0NtVWF3T3IraTdtUW5EakVka0pLSnMvVE1QOXVSQXljL0lBZk1lUExk?=
 =?utf-8?B?VUhNSW1id2R4cWllWmlYZzhrV2N2bkhjOTlJY2FBZ0FpYXBITEhTUHB5bXNj?=
 =?utf-8?B?NHRkOXYzb3piQjNjNmttK3lGbTBBUmphRXB0OXhxMXhzM2tQZDN6ZXROdW1G?=
 =?utf-8?B?SlVEdFYzSkhacFdQcXZPNnY5S3hDcEJMcU51ck5TUWlodFMyUXpEa3Nxb1dR?=
 =?utf-8?B?VTNRM2o4U1EyR0JyZUlRYTdMRVJ1OWk5dUZFWkJPNGw0YkkyRXBJREFpVnND?=
 =?utf-8?B?MnJjeUNqTVA3YWFBOG5hZWdZMERETDJ0cTBWb3BHRGxSV045MjJGVDZaQUYw?=
 =?utf-8?B?M21TbnVvSjNXOVlDeVZ4Vit3VzFBNU9kTDU4NUhpMzh3TmNjM2k5c21lWFNM?=
 =?utf-8?B?b2RkUDIzcTlncjlrNEpFNVN6Q3JkclVLZTFTdmZJOERFSkRJenNFUEI2dXB3?=
 =?utf-8?B?UDh4RUhUa000V2JYZU0vcW52U3lucWs0SzVnK0k1MXdVbk5xRGdZTDVNM2hz?=
 =?utf-8?B?S0V2NGxPcmZhVnM3b3FZV1ZnWjlCUHNsOHJQeW9KY0RSejhFT2tpSFJjcUpS?=
 =?utf-8?B?OWFtM1pvMGRRUGxJRmtRNFc5Ui96Z21yaWg2cVdSdUdxYTR4MVYxc1FneXR3?=
 =?utf-8?B?cllWcy94MnlpcnFMMXl6VnVMamh5SDRnZHZoVXFEUFRzdGVSUVZ1VFgzdThp?=
 =?utf-8?B?OUs1bVhPUzA2bk5WeUw5bDBwMGY1bFJSaklDdzh4UEg3VHB5cUVYZm4zeUJ5?=
 =?utf-8?B?K3M5bTlBM3dHTkFUMk0ycklFZGtvMGNEQ2hIMEJPOTIvKzZHa3pLbk1OT1g5?=
 =?utf-8?B?ZkJBSzg4TTBFTm5yWTJjSzE4SDZBWGFraEhjb25LbTFPRlZlYkVEZXFaTmM4?=
 =?utf-8?B?MGNaVlN1dHZGanNROHlOeUhoZTJYbkVZTlFNVitHb1F3ZmRTK3U4ZkxmYVhX?=
 =?utf-8?B?ZC9qTDRMUC8wOUVlejZySXp2MUFJd21Wa0l1ZDV6Q0ppeDhGcDRzZVFvYVR2?=
 =?utf-8?B?V1QyZ3BkNkFBcnBVa0lQeDhyZ24zRWE5MmZIQmMrWUpuMkFRQ20zcVV1SW9t?=
 =?utf-8?B?MnZLU3pOdnNnQ0JzNXZmQ1R2QzVhZUxLUWxhYUE2NXM3K0QzZEg5OWMzeDdp?=
 =?utf-8?B?enJwWWE0YlUxcCtmY0NvT3Z2a1JHYlBBUWFwWG5JZm5WM1ZieXQzYlF0VVNE?=
 =?utf-8?B?TFpzUXYybDN0UzhQQ3c0RVhlTThLVjNCZHYxOXBsL01SU3VhTUtkdHgwbWNJ?=
 =?utf-8?B?SnNQK1V3M05FQjZMZ3JHWUU1bURDV0EzN2NzMElUeXd5RjM1MUJZK0NueUZN?=
 =?utf-8?B?RVYvelllZFRmV2lQalFJNVkvYnNTUkpwV2NETEMvTm1ScFFSSG9BQ0t0cW53?=
 =?utf-8?B?cVJIK0R5L0pVMjdjd2VIRW9VeWRacEwxa1NWOHJUUjF5K202WkFyRG43RmNI?=
 =?utf-8?B?ZUFKYWZQT01VeW5rR3psUU1vZ0VQVnVnR3hDWUNrUnp1ZG4wa2h0YTFlS1Yv?=
 =?utf-8?B?cnJ1UURYb3gyUUpVaExiWk1YZXJPQk56YytPRDRiaGdiZTdaVUxCd1h0STFK?=
 =?utf-8?B?R0FjVGJCZEdHZDFEMGFGd2ZVTkRkZlRHdnFPcDZ2TjBrNjdiWjBlaHFCOEd4?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c9b7d-2328-49a2-099e-08dccfce22f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 06:19:03.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM7+bsV2YbCTv0Uj4bt6687UqjN94XJuTQyVzzDCBNHOqmrCoywcPDaWQON2mY4tQTBXI51/1rcogeM/X8miJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353


On 06/09/2024 08:35, Zhu Yanjun wrote:
>
> As such, it seems that it can save memory via not pinning down the
> underlying physical pages of the address space, and track the validity
> of the mappings.
>
> What is the difference on the performance with/without ODP enabled? And
> about memory usage, is there any test result about this?
>
> And ODP can be used mlx5 IB device? Or ODP can only be used in mlx5
> RoCEv2 device?
>
The performance while using ODP is highly dependent on many factors that 
dictate how many page faults the kernel will have to deal with.
Each page fault will introduce a latency hit.

Both the examples in rdma_core (e.g ibv_rc_pingpong) and the perftest 
(e.g. ib_write_bw) support running with ODP to test this.

ODP can be used in both IB and RoCE.


Michael


> Thanks,
> Zhu Yanjun
>


Return-Path: <linux-rdma+bounces-13082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE4B43B19
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569867AEE98
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C62D0C9A;
	Thu,  4 Sep 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l4WSPTU8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC872C1595;
	Thu,  4 Sep 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987777; cv=fail; b=nIMa/Lfw8kbIzQjoOP0g/WZjy5G32g9ljshV7O2AmgzWRCVTjk4cpBb0x/B1tQETpHE3duORXM03D9pxRFBTFlSF95lUWIZ1zLaxeXaBadySL7f3txqLw/D9ZL6jLrXiuWxhZFWsZCZLTqz7V2WP+0hEeu0yx7uR4C+lcpOgkoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987777; c=relaxed/simple;
	bh=19TFt1DbL5+gQ1ny7GWxpKaGhroP9Fjv1TlNyUKrBzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Mn3174OZfeNe72WHWEl9cJNoTaRf5HBeHj9V/pFgt0i3HR27R2hIvnYSasBqtxC93JbQyHhIYadT3Nd1nZi3EkcVg8UcnVlRTSCyVoi28P2dDo8/RkYrQs+SQ62PT7P5ykk7FvGg31mXOsVQUbXdfUXXDnfIWNEIFMuDcYJ14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l4WSPTU8; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqkHLrPh+d+VqhtTfZQxUGRNmeoQHdfL6dM7MLWTF7XUHtAExy9VP/aPrEkrAHmPz/fn/qyZPuuXGRXd1An4xbVKhqHQaiR9cYl9r5iJDSFZQSeeIE5OFQfIh3x460+5bn1Gi7pyh8KFZDJ/ppRSS1Vw3vjXZtMWX/GFwHhq/NaKRjm1zyUpLNTjRPT12Y4Qkl43aldMHD8FvI+jErARd5d74eyYVPk4Nn5M+rXZ1/A9QRX0f0MFJ3BO0lbAkV4azLDIcAIveIBE93LFkVHyUO9XopTM9IN9j43Z3mKfA+j0W2P6l4W2vuxvIZI90r+04+5bPFhQx2QNt0kV2WZCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svswUk2PMpSy3i6OvgBSeqKzFlj7JFAgpEaQ+LizMDE=;
 b=Ip8sYjHGJB48ga5492fvfRvD8l0ifH1Bw3DMi8vR+NVkYR6ph0kqhUfg0VTQI05Xt6Y9EJQ8L4frqGpbQEfnM9WXFBXj8NixLpQtaMldEOsUf+lKsRFGw0PGUQp1F0oLXmfOyG2v7f5Cp51TiTjpGed7IPfd6MIPpIrnXMK8nXXfE/+8lioNCyvHkNrkjqQ7w+u1BKg14oeJHplTG9v8KWwjc0YXtU5/T/DVpXMUAd0zuxtnaGl2/7/ydhnAl2q7VSEZzrzMAlexCZeelL0N5bzj0univyyxtEuo3meHDrr/4kBNh3WCfVc8Y/vmIRQ4Pb1hPboFR0JVnnyF972gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svswUk2PMpSy3i6OvgBSeqKzFlj7JFAgpEaQ+LizMDE=;
 b=l4WSPTU8wK8JdZuTxLWOKWiscn0lMLm1J1iWMWI1EJPa7UUOYa6PcNw1MeF/48SlZZ/m5qPfBBD6lrom69+k4AzOGqaqMDl2lJIK95nWWix3zLa6YA/053ZuVN+qnNxK40yAr57dn5U7UopRO5mKjcaXfQSCRhknAj5e4FXmW+9tV0Ur6NkTjTOuu8befz123Ld5+mAoYTOTWoCBnHpa0PpRHGeFzCJcqw8i3tYoznmQQp9SMXaVMbXylDgwL76A9lzCyJvmsUoLgDg3zGsrWMePdfWCHZlz5Wb/gj8EyO4Y+JPB4J8MowjMie9m+3YOb1bNXyBBQsmOAYvOJ/aoKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 12:09:32 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 12:09:32 +0000
Message-ID: <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>
Date: Thu, 4 Sep 2025 15:09:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Richard Cochran <richardcochran@gmail.com>, Mark Bloch <mbloch@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
 <aLAouocTPQJezuzq@hoboy.vegasvil.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <aLAouocTPQJezuzq@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a405d7-613a-4154-36ef-08ddebabe807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1JZblZpR29QaVJ6dG1DeDZxTVBqMjlJNVE2Z0xwRWQ1RE1majQxNkY1U2hh?=
 =?utf-8?B?UmNPZWJqdjVmOEJUbzc3ZGVpNGE5dzU3VXU0TUdiV1hPMHROTFZIOFN3L0Na?=
 =?utf-8?B?WE5PQ3JzaEdXVTRHSmFqc0JCMUFGV1pxYWllRStNSkRNUkxRTng3NEhiQWJo?=
 =?utf-8?B?U3B4K2xzUmZoSjZlZHBJemI2WkVqYVlpczFrdGRzWlhsbXRqM252MENCMkll?=
 =?utf-8?B?REllUnNIN3lrNlhSNUtFMVlnM01RVXRnZDY0OU5NcEpFSlZyUURRakhlZU5N?=
 =?utf-8?B?VVVoVXFZdVMzcGFuaFdwWVpKOVdKaHZkeVhGTWJhOEc5eUsrNG0zQTVucXow?=
 =?utf-8?B?Ui9VazdaL3hzQ2lEeFFrbHVvNklrb0l3TEZGWVM1SmZBYlowZWtPdzVLYmNy?=
 =?utf-8?B?S1hSbnNiMjJORWJBako4RjI1UUNZWDU3dU55SDZsZFZJR29KK21oaG5wVHhY?=
 =?utf-8?B?NzVSMjUrYS9IeU9aU3ZRb1NXTjFtVVRyZ3h6OG1xZFFKb05FRUlNK0Rza2ZE?=
 =?utf-8?B?RGlTVWpYdFFNanAxaFNEdTdhSVZXbWgzYTFya00vQis5SHlzdXZiUkhFaldt?=
 =?utf-8?B?ZVRWM0c1NVRCZE00TEZBZHE4azZSdlNmSi9QSmRoS2lrV3psYjJpQThiQ1J0?=
 =?utf-8?B?UC9JWkRDOFp4aHpjaGJ0RFlSNGhQb0ptb2xzdjgxaGVVWnlQS0NRSFAvNExV?=
 =?utf-8?B?b1Fab3BKb3Rzb2FDM1VFeUVZR3FLQmdUQ0pHS1YxODhGNk9Ham1zaGdvY1JN?=
 =?utf-8?B?a3MrbTk0ZXBCZE5TcTYvSGRna2Q4bWNjbjVTSUk3NTB1Zk1RVmhERVA5VlFD?=
 =?utf-8?B?OHI1MUtSTWN2cmFuY3hsZXRsaE0xM29xV1ZvMVRQWjlNQmdOek9OV21tRTdS?=
 =?utf-8?B?d1lRQUJ6Q3Njb1ZrWVlYeUVVRU01dkJWVTV6SGE0eFIrYmd4cWFzWElWUUJZ?=
 =?utf-8?B?M1VCNTFUL05lTVdpalhNWGxpSWpXYUNoQWlIZHZ5OG5YMG92ZmJkUFhhanJs?=
 =?utf-8?B?SitoQUR3cUhGL1RSYUFPQlJnbVdxVm5JcTBLeThobGZFMXJXZVRFb0dBQVBF?=
 =?utf-8?B?T1ZDZlVwc2JzaGk4eGtqSDEwdldIRnB3NnhndmMvSHN6d1NiMnZ4aXlidEF3?=
 =?utf-8?B?MFdaellGWDY4ZHFoeksyRm1XZ1JqdGNIL08rUjFvZEFtTlVHQ2MyU25Mc2VC?=
 =?utf-8?B?UytzcXpSTWxjMTdUSjhtS0tlWlQrdk02L0NLTktuM2JKM2xqbytFTkR5cDNZ?=
 =?utf-8?B?MngrOHpnMEhnZGx5aGZWMGpEa2VuMnJzc2NSR0ZmWmYrTUt1Ui82QlZwb0RY?=
 =?utf-8?B?VitRendmQVpydEk2ckdXNDJFNmRmMzlGRldQZHI5bDlXQ3gyRGMyVEtOTHd2?=
 =?utf-8?B?RGVybk5KV3IrS1lZVWxuYkhtWkdmdERwMFh4Vzg5V2VpaG9uTEt2eVdPdUlY?=
 =?utf-8?B?MXN4cWFiV0JIQXJVQkp0eTRDcDdxM09mS3ZCYXZCajdQWk5kZGt2MjU2dkQ0?=
 =?utf-8?B?K0R3TGJ6c1pITVB6T0c4V3JHd3RnQUNVN0Vrc1l3V3pBVlJldmJwajd1OXp2?=
 =?utf-8?B?VE93QWlhbXNZSjF2NWErOXo2OFUweE9HY2FBOEFyczdlaVhzcDlXc1hYVm1C?=
 =?utf-8?B?b0pqcjhCVTg5RW1LOHVTSmVleHcvUmNsY3JKdEhMY0pvb3p2akMzU0Z1bFo1?=
 =?utf-8?B?NkVNeWdrNVVXRnNuS1M5dVVRcGdIaTNYL2ljczEzck5zQ21KbVBJOHNqYkFa?=
 =?utf-8?B?SEY2YUxaV3p6STBJbGRmZkR2NEN0ZUNTRHR3WXFJSnNnbEQxTHBjYzhNbXVu?=
 =?utf-8?B?TGNOam5uRjhBQnkrUEhwVUZ6WEplNTJOdlAzZ3FsRURTZ0phajVFNWJSR3hQ?=
 =?utf-8?B?NlZTcGlaL0tDVVBhUG5rb2Y4NEt2a2MxNkNMRTVHVW8wcVl4M3hCTmorcUh4?=
 =?utf-8?Q?cu9zutNyDi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um8wejN5aTB1YkhyZVZZQnZNSGg3Sis3Z3ZaOTZLUXd5c25DTUJzTGpadnph?=
 =?utf-8?B?Qmw0WTZwK21Mc2JFR0lKbytQN0owVjcvc1YyQzBzTzNYUERtNlhWcW5qUjhL?=
 =?utf-8?B?SWJDQkhvdlNtLzVZNWZNdkRpblZzVS9BUTEvSU9zb3Q1NE4vMGJWa0pxMGp2?=
 =?utf-8?B?ZUI4RXZHeWZQcDJTcFNhVjI5SUU2MUpCL2ZQV0V0SFFZcjRXY0VnVWZxSUhD?=
 =?utf-8?B?Q3hYNlFEeE9uMEZZelZWTllsUU8zdEJLM21ZemRmZ2hiTHpUNXUyVWhkMWVI?=
 =?utf-8?B?bVdaWFYzY05iTTBOR2IzaklnWGRIbTg4UkxCajVtcXpSVExrTjVvVE91dmg0?=
 =?utf-8?B?bHJ2N25EYlErRXhSNVEwYkJjWHBmbmR5L1NIN1JRaW5aK2hZa0RRS3hPdzls?=
 =?utf-8?B?UmRvVldSS3dMZmdBSnU3dXYxK2ZEcU11bS9ldTZIdGNMeTNZR2F6dk5NaXNV?=
 =?utf-8?B?dVZsaFpiL1hKY09IbzJzUnJXN29DZ0Y1VzZKNW9OcXJFcnBiZ0hid1Mwam0x?=
 =?utf-8?B?VGlTdm5vbkRLb20vdnVjbjk5RVNpZUFzR3J5U2wrZHVwVkJaRUc5V0ViR2Ix?=
 =?utf-8?B?cGkrai9uRW10MnBwU0RpYXFBejFTT1JtZFZ3NXI2SStmSUM1SmFDL25lZlJU?=
 =?utf-8?B?UU5sSUpxM3Q5VmRYN2U4THJJSmlKQ0RuakNDMlhKR1lHQ3JCdm9EMFg5QzJ1?=
 =?utf-8?B?blp0dWpUS05wWUJmeUlxTWVKdFZXWWgxYVJjUkQwQm1zbXVXa3FHYi9NT0hp?=
 =?utf-8?B?Vk4yZDFXNUFlYVVhVm41SzNBcCtkdUZSWTZ6cVJoaWFpTGVHcjBOa2oyZ200?=
 =?utf-8?B?SkRVTFNZcnU2UG94VHhjOCtUTG5QZUNaeHQ4RTBCZHAvMnJZRGZ6SGxCWGRK?=
 =?utf-8?B?R0w4NmFuSllCZExzZnFVWUtiZVZFWkh5ZWtyYVJsdmlWcmhFeXpoeTlXV2dR?=
 =?utf-8?B?blNRUFpkRU14Sy9XOXZadmVBRldpQXZxa2pmRzBkcDRqY20raE5qUlhjNVlV?=
 =?utf-8?B?Ukw0RGFqRGRCMTJrM3QydzVNeWw2K05qS3NScFhBNzJIYmpVVndMSEdnNmtK?=
 =?utf-8?B?cHhucGY1blNUeUx6TUVlQVNBelJzd0FFeCtkdGF6OXVGbi8zQ1RWanFyUWYy?=
 =?utf-8?B?M3dmQ1pDdFhFN3J6ZXNBSWluSUpBejN4SVNDb3VLakdiaVJpUCtGZm5ZVG1S?=
 =?utf-8?B?VHYvVWV3NUVlN2tScHFXeEpiUTVOWTlUR25lZFoyN2k4aTFhQXFybUR5YXZx?=
 =?utf-8?B?Slk4azN0RVhzdThEak0rZE5RYmp5c0l6UEg5R1hGOGlGejJod2d4WmNSYmN5?=
 =?utf-8?B?bS9BZGlPVy9KaHFpc3NIM3hlRVlCeWJEWFZYalpUSExtU3ViWWpIMUo0bmRx?=
 =?utf-8?B?ZzNHckNFNURJZWlLWFEvSkZkbVJSOWMvM2hHRU1pNGVpMzh3L3doU2F6Nmcx?=
 =?utf-8?B?bm9wWGZ6RFN2QU1PVi81SzBRbGtmbkc5MjVPbW92eXVlQ2xTS3dIeXdRd2lL?=
 =?utf-8?B?UmNUcVVTN0U2YXJXOTRYVnNvMituUFhOU3BvM05jZGY1L1pzK2Q5Mko5Z1hq?=
 =?utf-8?B?bkprUUxYelVZQVlLbmVybFpxcHgybStiV05TQTYxSUk1Ulk1WTBUaktQM1VS?=
 =?utf-8?B?UXpBTjdQY0NCbGZQVHlRVUtXU2lYdzZrdFF5dFZUamhFOW9uVFcyeVlhOS9D?=
 =?utf-8?B?NmR4WFVWUkVQY2dTSXV3dXhBUzc1d2VNWUFwTEw4OGNQWU1Yb1dHMG5LV3RO?=
 =?utf-8?B?VVlSOS8wTFdqdTNYRHNLdHhabGpob0hlUVlMTXlGaEl6UWYrT1VXaElzUk1Y?=
 =?utf-8?B?TnN0OHlGYVJadkR5VjNZS2ZRVUkwZlVTaU9CK0szMGtWdzJhOWJiYU02OHpj?=
 =?utf-8?B?S05lcnkraVY2cXkvc1U3L011eTEwVnB5aFppaVZjYTFEdEROQjh6MTBLY1kr?=
 =?utf-8?B?Nmc5UlRiQ2JSeXBnMzBqWGRZVFMwdllPS2RRbU9pR05hcGV5OENmcGtYd002?=
 =?utf-8?B?UHY3S3hnbTdqSmw5RTU5SVR6Mk11WUxKcWNmMm4xOEpNQjVlczgyM3M4QWtX?=
 =?utf-8?B?QmJjUWZiTE5uanNRaXVkUjlqeDM1ZHA5NEg4OVpjTFd1ZUsrMVZsaWxyTmtM?=
 =?utf-8?Q?zAsZZvpGhkn0gWCg8Ec69Pn3Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a405d7-613a-4154-36ef-08ddebabe807
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:09:32.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvy10DXKjj0nClLwp/g9SquyDWAFGU8Nba14cTmOY2xU1oZ7IpPvfT7Mc3UEPCm6rkCy8hOU03FcnpkGc/Cwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242


On 28/08/2025 13:00, Richard Cochran wrote:
> On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
>>
>> On 19/08/2025 11:43, Paolo Abeni wrote:
>>> can we have a formal ack here?
>> Gentle reminder.
> I'm travelling ATM.  Please ping again next week.
>
> Thanks,
> Richard

Hi Richard,

Just a kind reminder.

Thanks!

Carolina



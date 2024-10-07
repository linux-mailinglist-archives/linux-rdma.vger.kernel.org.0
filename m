Return-Path: <linux-rdma+bounces-5265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03627992BBD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCF1C21D18
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC591D222B;
	Mon,  7 Oct 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WY3Yt5Ed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E01547D4
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304124; cv=fail; b=f31hl3lrGYOi6NzNubJ4y85nLpc1oaorJMJ+bV2QKO+AA9IlSdT3YIBxsxTXqjVmGJyLxsExQvBhJkpJ2XF+b8o1O47sN8/xThD9CyaMhu9kI3vw237F1B7pxVnKpWQSSPkYeTB8kKvNUgQRxIhzyVk7siFPCr+m/+oxG0mWf2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304124; c=relaxed/simple;
	bh=nruJ5CbL0tSyWSwxc8vB17YtEOw/zO0TPEAGSHWBSlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5xFVUuCQFagJzX1YN7qeWU7K2gdHFyzaai2opwlKgfD+XQ0pJ2kPLtiUeFpHxd1lIGs40gWEEt/r0qAXd1e5ho97y6CE+TBmmqSDrKgsn7xAuG06CexoIHbLMY8G4ZW6L3xDAE4U6jHqAQtRZtt0bcblIM8phasv/HI0gd3OfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WY3Yt5Ed; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUzSopzsed5BjLkZYVzWI8jBh1piFoV4tEYNKF5l84DTy4nXjFF/vXhZa3y0ZbFh3+DApc4TVdIaWtOGzP90ktc6DJgu95MkAOsu0UApBhSrzyDrS31/HgNf2m8jLAaAcJD6qvoF89uvtno3mBwgloeGB+Uz6jvS8WQ9igjis+uKyzCxzY/99/G0g9EQnWbonT11s2aKBa5YYGS37KWBSQ2XzNLo0QvAdRyPRzZxbt3vgVOO6h93YH1CCm/QWC2NgfLrxDyit9WFS5JrECCN9HTyXCCx7PyNg+Pr2gHEYJLQnbWWU0PV/PlJGqijIXmzk4kfwd3xhpKZyjOtnmlByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKvQwUThJAJT05Q4HH4BjzCCNG8OidHY6B8t2XEjG1U=;
 b=I6+gbFqq+V7hSMm6ANmcGuudIR7JTCd5NLIP7T2KYG9o4rO7FNMBD8ipfJR7p+562HaLLgaC42Cp79I2Qxa9qlbxaluFVwSJTND6XthpXEV2WfIp7J94PxyGY52hxtxrIT87L8AHINNnVErjeBhn8OwEVnTw9QizfdZywIl/BwV91nrcygKqFtrPUg8192HepjjLXiWhN0IIN4wq5cDT6S4zWBnZZH5liRBwMD5ZKZ1kMgEnSXagrq0iNddn3uNTPrbrxh4IXGM0qujU4Is3K+Lf8lcWn0nQRMPcpm671UHsAx3eoC7eiHJmfFe+5MtbK8YE2I+DcF/xJw4eMdLZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKvQwUThJAJT05Q4HH4BjzCCNG8OidHY6B8t2XEjG1U=;
 b=WY3Yt5Edzq5fMmPJSKuqGkSy6pcjZuH/QsrxrBYKzXKEQcKdwyrzRh1OcQTa0Bthl+FpPU2s///jlFvuVM58U/k7b622VFudt0QgruyCvTVlpMpmnzSlZiaiqqRTBDxWgsO/NdZ2/o+aVPpmxwN0z0IXFxpFX3ZufaG0daYNTFhAnvlZqkxtTcioVDsaPnV0DTgC0IfoKpsXFkZZEJf9C9xVNlaqN0OtIIDnQbZlIOas7oE4wIqhM45m1qtnmDdDwctnQfDfyBO5jYIzKAhdCB3DK9+U4pZ2EmIWvaguTzKQDmC5t3DXEvRj/4tCPE0vgS5M2hj1qZwTz1v6C6zMGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Mon, 7 Oct 2024 12:28:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 12:28:40 +0000
Date: Mon, 7 Oct 2024 09:28:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH v2 for-rc 5/6] RDMA/bnxt_re: synchronize the qp-handle
 table array
Message-ID: <20241007122838.GN1365916@nvidia.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
 <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
 <20241004192730.GA3284463@nvidia.com>
 <CA+sbYW3C_aQmTpguYahHRoy46AEo8r35Ca4RVhRKGcQ34qtDjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW3C_aQmTpguYahHRoy46AEo8r35Ca4RVhRKGcQ34qtDjA@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0533.namprd03.prod.outlook.com
 (2603:10b6:408:131::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: eb081ee8-472e-4df6-c130-08dce6cb9316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ni9iaHJZM0ZiVUJaRGdTU1QzL1ZxTVovU3FJNE5jLytsU3czcytPU3FxK0Zu?=
 =?utf-8?B?cW9QaUxYMDZVb2lvdUlGNm1JbUNubDdRVFVQMnlaMjl5NmpaWHVwQnhQUHZY?=
 =?utf-8?B?c1FDSTBpY2tteXM0UndzY2tzS1NKV3pEYlJXbFF2VzM0ZGJhb2ZEcmFZeEhW?=
 =?utf-8?B?bXJKMDVGT0ZFcVVQWUNaelZpc3VjS21CbWN4d29zOXRkOEpCNjg2OENuYWxF?=
 =?utf-8?B?aTlvbkhvOHZJUDdHaElGb2l6VVhaR1M4NmlGTGt5dzhKaURpQkQrMVcwcGhS?=
 =?utf-8?B?VnVFTW1yVU5QNVdsT2hwcjFoSzRPd3RWb1lVWlk5eTdGL1ZsQWVOZ2JiTDdR?=
 =?utf-8?B?U0tISTlwcmttM1hlQjlHWktXRkRyT1BjQnFzVGNPS3pndUc5R2Jram9BRGRr?=
 =?utf-8?B?NjFjSy9IVHNLWDF6aU5hRHpQNzA4S0pBVGY4L2xway9maFVwTWthcS9DS0Yr?=
 =?utf-8?B?dFFXVUtseHFuVmJQYmY0bkw4eHpIU3gyWHJ4NGZnQkNtSEFEa2xNdUYxRHVC?=
 =?utf-8?B?UnFXUXZaVm1IdjZIYmVTT0FKekdNalF2c25CWDZGSW1Gb3NQRC9qNlhIT3pv?=
 =?utf-8?B?YVR2N2NJRkN1MzRhZUVENlpESXFDVlJPQXllaGhoS1I3UVF3TzQwclo2Yk1w?=
 =?utf-8?B?azlOODBqYVdZa1pGMnpleGpUUi9XMHV1RXFTQ1Uranlva24vMUtmL3lHdUlv?=
 =?utf-8?B?eExkYUU5YTUzcVRxMW5CN3ZuYVRmS1lTQjlnWUUwSTlsSkVkMXFHQ2o0MU04?=
 =?utf-8?B?UHZqUi9iTktob0hkSmRqTmtwaFh5dzlpZGpVNjBKTEF3OWxtazY4ZEtUNXVr?=
 =?utf-8?B?QXJHbXpIQXAxSW9xaU5LaDUzNll0NDhZWE9kSnByMExpb3dVMklQc3lFclQv?=
 =?utf-8?B?TkJHK2ZMS3l6eklYNVQ4YWVqS0dzMUpORkE2bHFnQXJ5TVladUtRYzJWbDVL?=
 =?utf-8?B?WU1VNlBNYlozR0wwc3p3RzMrQktXUGo3bWszTTg2UjVmMi80VWk0OUVkcDRK?=
 =?utf-8?B?c1VaNS9IZmg1Yk5oSWxMTG9HcCtqMlpPaHVuWHVYakxIeWJvbkNoVEFWTmxs?=
 =?utf-8?B?amU4UFQrdUF3bHplb0F4ZnZrVFBrVGhQQThnNFd5UWxlazZrOEJaaTljOUJa?=
 =?utf-8?B?bXV5b1ZySmEvUVRGREFKWnJuN1R1NGQ5K2s0YmRFazlIRU1GcDQ4S1JyZjdS?=
 =?utf-8?B?VEtPK1hFZjdiMGlKTGdOM0NYNko1bFZCVXhUTlZvemQ4UzBWNU1leEZ0NVpK?=
 =?utf-8?B?bUpnbHEzUitGb3FwSk1pRHVONEp1SlRta201NkZzcXQxeERnMlRUeDhuSERN?=
 =?utf-8?B?am93U2RSZ0ZZNjkxQkE1VWs3QTRyS2I5b2VYWTVycEJqdnVKUm8xUFpOYWgv?=
 =?utf-8?B?N3FuZXN6U2w3clp5elpvREJTNEIrSDh6SDlHVkkrVVJBemJ0bU9xa2RJcEta?=
 =?utf-8?B?QnVrTzZrNllDa3pXNTJQMlo1N01DdkNoMU1tbUpxMGU1R1UweWdQdjRPNUdI?=
 =?utf-8?B?Tit0YUJpWTNCMndzajhQcTJ0SElpdTRzVjVzVUJZb0hveVNLRFVlcllEY2gr?=
 =?utf-8?B?eStJd29kaGJYSVJSWG1QaDB6MktoZ2VGdk9NSEFtaUFtVC9wSGx6M2dqWnhP?=
 =?utf-8?B?dThjTzl1RVg4Zk5MUWpzd2pZS1M0ajJyWnRUOTRIbFE4L1BhaWM3dkcvWTFD?=
 =?utf-8?B?aUlsZ0hJTk9ZK1BITDBLTmtacXFNK1UxMDRmZ2VBTWRQbUpqNjdKbEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9NdVFUY3pyMXlORlJJNnF2OUtyendzZ3pnME0zUmJXS1dBUFVNQzl4eUxi?=
 =?utf-8?B?akxWd2Z0RktJYnJZSkFQUVJnYU9zS1VTNDdFY0k4OSt1STJJMSttTC9kVklx?=
 =?utf-8?B?NkEzRGEvUGkwaUhqblUveWdERCsxQ2luVnBubHdTZWlPYVZ4WU5jZVZRSHNX?=
 =?utf-8?B?N1JCN1NBVlRNbFJKZGdCNS9WZHhUM29mQ2x0UXp2bUlCTkYvRVRiZ3VxQTlE?=
 =?utf-8?B?QUpJdWlCeHFiQ25vQjdJWE5kQnhVc3hHMHJWK0J1d1BBdWwwYjZtd2loL2xa?=
 =?utf-8?B?YTB6SlFsc3Y2S2xiTUtLaVFqZjRKcmw4WjZpc282ZjZOSzBrRDFpOTRPbUJP?=
 =?utf-8?B?bUg0dVMyZkR2SVczOU9hRE5Rb21ZSnVpWXJCTzJsMEV2cWxyYWVodkNqSldu?=
 =?utf-8?B?ZS9wL0ZjZU9SNE5CbTgxVW10MEVTNG9rR3pUV0lldDVXa3ZRS1lveXV5YTlW?=
 =?utf-8?B?SDUzdEVhZkFBWjMrMVV6MjZLYzVYd1FRRG8yTFFJdmtOdTNwLzhJMVF3SXJo?=
 =?utf-8?B?YndDTHZKZy8yVlpqYkFIeUJIVDJpQ1k5TjN6LzR1LzFQOWYzWlBxSDNzbGJu?=
 =?utf-8?B?L1MvcElPWHk4Y29XUUswcy9HTXdnYTZLbSt4WVlhcDk3Z0gzN1o2ckJ3T2dZ?=
 =?utf-8?B?VVlIdk5zZ0JYK0xzMzFxS1VINzRLcmQ1ekJoSmkxRmhkYVZNWGtJWWs2bU44?=
 =?utf-8?B?Rnl3UlIyeDlUMGR1c1Q5aUhLR1VZbFFwQUUwN2ZUMWFBZUdheklDZzN3RHJo?=
 =?utf-8?B?a051dUNMUUVLNEIzdG8xZGw3UDZsaFB3ZmhRYUJ1ZFhWakM0c1JGN09NcVMv?=
 =?utf-8?B?ZENwbUFIc1pTNXZmdzQ4emJIaGRCZzNQSmdUS3NNdnA1aDlrL0ovTGs5VWZ3?=
 =?utf-8?B?ZjRSeXZRYUFzbi9qdnE3bTU5Z212a3ZtakZyd0VwQXhZN0xMWUxUSWkwQVNj?=
 =?utf-8?B?VDMxNjV1YUhITU1EZ1hTdmRPUnRBa3NPLzUyVkZQTTlJQ2lMdnBLaFdMbXlw?=
 =?utf-8?B?ZVBPNi90ekhGQ1NXZGRlOXRpazVsREJOc0xDQnArd2gyYTg0clFnK1YxbXdG?=
 =?utf-8?B?QzBxa0c4NnJ6eVBJNFBFZmlPOGd2YVhUcThjczBncExLYW50cXkyaHQyL0lX?=
 =?utf-8?B?cUpZNVNQZkEzVm1VdEwvVmgwWFNkYUNWaEp6cStjckYrbFRIcU13dTBGTXYw?=
 =?utf-8?B?eE84L0tMVU9odGhwWmREbUVPamxXa0dSelN2UlJESk9Tb0hvdGgzR2RxTnFF?=
 =?utf-8?B?M3Qycms0cVlneEVRSmlJdjFsMkpsVnB3aHFMTzhiVVYrOHUrSUlFaEF4eXpi?=
 =?utf-8?B?eVdYYUdPcWpZUCtIaXhxQzVOUStPTDAyNkJFRWdocFR0QTRGNFhLSmZ1eFlm?=
 =?utf-8?B?RGR2d2MzcG4yanZVTHAxTy9Dd0JSVGFpa09lT0IwUHlGbEk5UTIvMHF4c2Zm?=
 =?utf-8?B?T1RCYzg4Y2Q5cjdMQ0Vla2Zrd0xXQU14OWFmekhKUm5od2ZGaGxFaHkxVFZS?=
 =?utf-8?B?cEVsWEUyb1V5SWNrU3VXcjBKSEczSGhjZXgvWUtSQmxFY3RzYnJya0VtUDl2?=
 =?utf-8?B?UXNzakEwTUpZTmdSL1lrNkd0WHpJck14clJ3R3Q4bkdpVXFyaE50cEh5SjhY?=
 =?utf-8?B?ejRBbG1IVWhqamMxc2ExdXUvaEc5UnpDN0Q2dnF4RVhjdk05eFVVK3ZRdFY5?=
 =?utf-8?B?TGloSFpFUnBwMjlGa0Jja0o0blo2VDFwZ2dlSHJESk04cmN5UXYxODdJNUdw?=
 =?utf-8?B?WlBqTFN0MGE5R0QvbWxkWVFQcXJYZ3ZNOUN6TFZKbHpaZURhd2VVZzlPeXJO?=
 =?utf-8?B?c1JtNkZSbmc0ZGtZcGtoTzFPbFR5bUE0WmdCN2NBaEwxWnJFOVpzUW92UjFp?=
 =?utf-8?B?SEFYL04wRGJHOG9kM0srNEJSU1BITkpCSVFtY2diZis3bFRXMFJUTUhBdG9x?=
 =?utf-8?B?eVZ4d3hiMEd0NDNaeDRxazI1R2hFZ0djelVvMkZHWURnNkZtaWg0YUR0bS9j?=
 =?utf-8?B?M2NHTHZ4cTY5NlFoWlRiR09oaXdwd2puYmE0VHJmNE4zTWxiT2JNblV3Rjl2?=
 =?utf-8?B?Z21naHJzY05HeHROSi8yVDJxdmxLNG0rUTJSMENHSjhoNHlNM1d3M2VYUW5p?=
 =?utf-8?Q?WSiQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb081ee8-472e-4df6-c130-08dce6cb9316
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 12:28:40.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGw8vwQKzQi2OMZwawnyqfEv4NRJBdmjfBQK2b4OqhPVIqQrj2YA7VI4kR2pTAnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

On Mon, Oct 07, 2024 at 11:20:24AM +0530, Selvin Xavier wrote:
> On Sat, Oct 5, 2024 at 12:57 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Sep 18, 2024 at 08:06:00PM -0700, Selvin Xavier wrote:
> >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > index 5bef9b4..85bfedc 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > @@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
> > >       case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
> > >               err_event = (struct creq_qp_error_notification *)qp_event;
> > >               qp_id = le32_to_cpu(err_event->xid);
> > > +             spin_lock_nested(&rcfw->tbl_lock, SINGLE_DEPTH_NESTING);
> >
> > Why would you need this lockdep annotation? tbl_lock doesn't look
> > nested into itself to me.
> bnxt_qplib_process_qp_event is always called with a spinlock
> (hwq->lock ) in the caller. i.e. bnxt_qplib_service_creq. I have used
> the nested variant because of this.

That is not what nested is for. Nested different locks are fine, you
only need nested if you are nesting the same lock

Jason


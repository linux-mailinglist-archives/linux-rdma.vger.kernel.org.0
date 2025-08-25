Return-Path: <linux-rdma+bounces-12908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C756FB3495B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757372A5BF6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20A3054C8;
	Mon, 25 Aug 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjuMoX5z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251C303CA1;
	Mon, 25 Aug 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144380; cv=fail; b=N4dgb3rRlOkyzuFr0thiL6aMwpGYHmks2vISGwdyaSoPdsaEaj31/3Do0XDnpwG31QgK+84Wv7pqyOw+FQpxY0h5vHTx2Vu6hiH95XGjYDWwP0jwj8CnZZANtS8quH58ZOV0/ri3/FJhGMlOIksnj6f7ROksOywkc6GVOxdJJIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144380; c=relaxed/simple;
	bh=qxAauBPbp3zv4hTuw8ikyZQkR054Ysa5MADNFmaiIww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uanW2U3ocBNwoq8lOieirKkTaN8DuoPS3mM3uAnUkJBpsjLDWwSHXasQ7/iMcdlQxVdieCMslaPuxOhmw6VmBiK/ny5MwaQBOVUDhUcw0rnXEdl69UyKoSlPKkmN6gJ/HggX7FtfzhfUSy+gsalL4iuPQEpBFIxC7Fofq9NjZUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjuMoX5z; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRlritKAxMINczglv/xJyihmJU5/svFWwa3KlH5ydJY4SI2OxzBNaMa3I1sMSq7swe+AhscVUx4XLcAXtWvXN6IdxXKPmRMxmxNIM5p+qagxxhwpWWkXiMjE/WtVqOjXZXxgK8EhOq2rL6upcMEhJ1ltKxK7Yl240n8zScXYZQ5PeoNoia6mILPgTkl8IaiTl+9hJqtSMotjrWQeor1UjrE3fdBz2tOTX2XZwK7claTIUWtuGZtHyRk2PtSjNt9R+CAemTbouDOkARreayVfAUd4YF4n9xCxBQfoFXIU9/TG7cS4UNmexKg00RfhkqDcg58Phz55RYGi+BdVu+ADyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3SASJLYtC9B8XO7MXF4ZhsO1e0Q14KqpqbAdqknA9Y=;
 b=S8/zyT4MEt7WCLhd3ZGFFedXUBb4zHkDb4qTaxBKt++aP+uG6evwECqb+YSNp2ibUPBTdbPEAXfZd/Q7/1zpIiqzAvwvd3s/dd6ts8s3WldnmP72WylsttuCD/KZM7f8OHuE1vuAD3BFUNS5oC1JvpF8H2IxVuLEMt2qDuSBdHSQ+HpnpY9Lu2r7l8/39rSI7p176h4FHvoom9WRw6gEMWOvlsZQGdGyLj9fySlGp8r/vTN7DB/eEX8Lx5+e9+mc4Bv6mZIgmu0exKS2GVLk4FGsaU2w1ZuiKwATRUv2UUvv9QvJIjjpcUwdt5HzlHqeca3aWfoJFrkl801NuszV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3SASJLYtC9B8XO7MXF4ZhsO1e0Q14KqpqbAdqknA9Y=;
 b=mjuMoX5z8I8KhlngQsWV0RXSbMpbpT/KIhFlyiab9MMna0im/TreSj5TDL04I5VVn1J1kxZRjjHQareJTyTR/xzPV2S3krgKmdJdYMI3sOv1tcmsj5Uzz+Kyto2+2EHF36aHdReFvdNJrSsCBOorPaW5IT30UoSba+tWoDmecjdvTe574cTnB+mYKG+FcOM7cAUUvFhOnhCZzUhG264d2ZJnbKEveI21PktQKWmEm7GCOXOIEnPmisAU3vJGccrNMi9WJPyu3e1ld66ekZuTE/ijWjUw0px9wt++6X+2tfAHVtRyPLVJKi/MfG9hdgYWKDZ3ENdzrU3xKGGvHIGg8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:52:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 17:52:56 +0000
Message-ID: <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
Date: Mon, 25 Aug 2025 20:52:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Carolina Jubran <cjubran@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: fc154a48-550b-49b1-8937-08dde40038b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFJR0xlS05vcXVyOGYvRVhEVVBDUHhMQXVyU3R5dkg0Q0tLZGhvdnMyb1hO?=
 =?utf-8?B?cE5IVmVPQUdvSnZGRzd0ajJjdWFRb2dqSWpUOExjd2ZtK0NuQmtrUTBEc2Jh?=
 =?utf-8?B?WGJQT1Y0WUtmOFpvejR4c3FTL0E2T1dpTDk3N01UZGVOVUhZc25qVEgxeHhK?=
 =?utf-8?B?bkJlMjhNZlBUdFl4UlNxa0R4YUZpdW5IWlArNUxycElxZ25UaXN6eEl4TGpP?=
 =?utf-8?B?L1kvNWJnckkraENBanNVMzF6STVmUVFBS0traHFvUlg4UG0wWWU4amxXWkQv?=
 =?utf-8?B?SlhPdzNOcjZRMlhha2VzSXB4dnBlNkFLZU9mdy9WbUFXRC9zZ1NRSGd6d3Vo?=
 =?utf-8?B?SnNYb0FRdldJVUFZQjBPYmxZL01RTFRxUGtuM29EeGZ4N0x4S0lnZnJaeitB?=
 =?utf-8?B?K1I3aWpPVW9xVTdOaGVGN3RkbmNJWFNFdG5ZemRFazRzY2VlUTB1UDlRRFlT?=
 =?utf-8?B?ZkJqb0srNnN1enlqdUQrNk1URkdnZncrSWdCekVIdHFaNkRzUyszalFkbDd3?=
 =?utf-8?B?ck5EeXZaNUZ3eUhhRHFPNVBRcU43eTlWdjBPNThiem9JUCtvanhSTFFjNHQv?=
 =?utf-8?B?VEtTczJDc2JabGJmSEpmbTNUV1RNMXd4SmFIdHk3dk5ZclRnWThhYjRBOG00?=
 =?utf-8?B?UWU2WER6RUpXcXoyN1dEZVN2QVBENkpGWEZDT1F5LzBwdkk1WHZGdURMS0RZ?=
 =?utf-8?B?MTN6b0c1aXZzRko2VXhka3BlSVhiblA2QlBXWXFyeC9LT0xPcnZOam5YOUtK?=
 =?utf-8?B?bEZ0U05xQkVmN0dJZ3hiejl1aE84c3ZGOC9BT1FDNDUzMnRiL2dUUTErayt3?=
 =?utf-8?B?dlF5VEtUeU1RQVdBb0pVV05BSGtWMm41ZVJPT0VpZ3dLeTZ5RGpvYThRNk1p?=
 =?utf-8?B?bnlBQm1IWHJkeFVVQzU4eUFLcmF3cG54K2V3OFJTS2JFbFgzYkFxZlJ2bXJa?=
 =?utf-8?B?Q1JZY1pnYlluWmNjK3pQb3ZObmd4NmhpZTdhWW04MVBBN2ZPVDMrTVB4UVl3?=
 =?utf-8?B?bnVMUE9DQ1U4bkZUV0JNRWxSTHlodmkzbWsrL0kzbXQ5cElvRG44YWlkVWlr?=
 =?utf-8?B?enhWYVdsdXA2aVBWTlVOZkV2aXZRSnN6Sy9QYjlzTDBnNjM2WDJ1WE03WmlW?=
 =?utf-8?B?U0tYYkduVUVIcjl1TERNeEVlekEvclR2MHErUm91V1V1cnFQSjBXSTV5MFRH?=
 =?utf-8?B?bnpNYUNMVWNIOWRWb2FTOGNhOG5qMm55N3N3dE5INUFTRXFXeHhRQndvaWgv?=
 =?utf-8?B?RjFXMXE2OGdmb3l1dU5FbHY2dTNXbWx3dE12MGsrY1owVEdaTzkyS2dETkhr?=
 =?utf-8?B?UWc2TDlKTm0xdmpST3Z4QUx2K3hPTEZkVnZzT3FiUnRNRW5zOTNwaHg4THpu?=
 =?utf-8?B?ZXBtbExGVmVXcSs5ZDlPam5DeVl6TWRBakFSRWQ5UHNnRlVuZktNNDJvL2lQ?=
 =?utf-8?B?WGpBV2h1Vkp4QlJjZ3RDUWJXS1BYUFpWaDB2Z3pyUElDNzVNRGM4NlBaY292?=
 =?utf-8?B?SDNMNjdUNnovLzUzRVdGUFlLb2JVTXlSYTE2Y09wbVp5dTFmLzRJZ3UyY2N4?=
 =?utf-8?B?b05LY2E3d0ZEaFdDT0lxK0JOQ1VDblB1SVFrNGZoUnZqWkRIdHI5R1FZVHZz?=
 =?utf-8?B?emRzY3BQRXdnd3hLZDhIdGE5NktTaDhKMkFrOHRwWFhNVlIrRU1RbHVaNzRN?=
 =?utf-8?B?d1NlTlNuK01QWG9UMnZRRWdqU3ZkeUxhYXcyTm5jaTdRaVlXUmNZTE9ieFAx?=
 =?utf-8?B?UDIrTlV4ZmY3VmI0NUhiL0p2UU01WWZFcjZJRktQNE9nemFWcjhJdURFQ1lI?=
 =?utf-8?B?SUUvYWVsVUZBMHU2VGlDUUQ4ckhNbHFVaEtwTXRoekNocmNwNWNBRlA4bERU?=
 =?utf-8?B?ek9ZK2UxN2xrWkxFWTdNVnJna1lOU0hza2h2bFVtMWR6SFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlR1UUphcjJVMDdjcFFoclFVKzZidXBZa0V1NXpiY3FjUjJTMFdkYmJtdjVw?=
 =?utf-8?B?MGJSb1VvSWJRV0xCdXlPZGZmdEQ0eDhucXRGZVN3KzY1WWZCV3JXQzcya2xG?=
 =?utf-8?B?a240OFprNFI4VHE3N3BhVGF4M1NHRWlGQ2dRMnBxZ1hLbXE4R25pbzA2Ylln?=
 =?utf-8?B?Wm1BUXc1cTVuOG1Qa2Q0dk41UFBXc1N0azJOcmFGRFlSa2owRk5qN3NiOS9i?=
 =?utf-8?B?Y3hDbEZUTGRzQXVMcnhOMVRwWnU5bkM2cS94S2ZRN2l6aEtsY01UenNnNGQz?=
 =?utf-8?B?Y1FudktSY3RPOC9jTFVLNVVTdEtlQ0thWktoRnRoL1FuckNUWStHKzVXYkMx?=
 =?utf-8?B?a0RscEVtbFBFR1hFNS9yQzRDUVBPa1NZUVRPVzVvNm1BVWU0TnYxTTd5Mmcz?=
 =?utf-8?B?S09OSStrNm1VVjFpQmU3RDUyKzJYbkFmYTQ2TWlDNEZaVFlsTEJzb29kelVn?=
 =?utf-8?B?RFVoVmtTNWhPQ0k4N0RuRUZMbjIxUEdEMnJ5VEdNOXdQdUFCdDVieXEwTW9C?=
 =?utf-8?B?UkhmWDNGVnh5cEZqZU50K2ZWTEN0QTBzM0xVZEpNUTZqQVRLWXh6WVRnVnds?=
 =?utf-8?B?NXM2UEhnczBBOU1hSGF6VitiS3A3TGJnMFR5VndVbUhzVFRvREFSczVwWEZ3?=
 =?utf-8?B?d3gvMGRnN0s2aEUxUFJ3U1Y2MUtBYzVNYVhPQnNaMlRscWY2bUNHaE1vOFdh?=
 =?utf-8?B?WW94SGFzQ1YxMHd4QW1TQUs0TXR6dEZmd0I0dVVUUnBxYUV1TVdySFIyOFBw?=
 =?utf-8?B?V0hpejFSRkYzS3FnMGJ6KzVkMmh5bmkwRlpYWVJ5UTFtdU4xRFY1bUNxamkz?=
 =?utf-8?B?bWNPVVVWU2IxTlZ4amRhVjNKcWFJQlVZdmdxTGNrTnFPSXdZOEVuU2h1Yytn?=
 =?utf-8?B?THZOMGpIN3lMenczLzdadzB1cTErWk1BeEtBVkxsY0JjOGZiRkF4bHc2TVhY?=
 =?utf-8?B?QjJCYlBkTmx2Si9VM09zckJES1htVjhkVzJSVmFwUUxBVDJSdTBpUFEwMlJz?=
 =?utf-8?B?aHhHaUJ4OTVLRXBJUEJUOVRIai9qS0tQbElKSHN0UzlLMERUR09uUnZyUTg3?=
 =?utf-8?B?OWgvUThWNVhvaWRlSmp4dWFDdXZ6UDlSRy9BeG5mU0lWbVg2QVpROUlDTDNT?=
 =?utf-8?B?MGxaeWtMUlNkYlF2Vm5pdCtQZDhXK1VrU3gyVUw2VmxvNC8zOWR6RkpjWXpw?=
 =?utf-8?B?d29hcC9WclpHOVJ3eXdJckM2R0dmU01id1RHUklneUNsemE5QWZtTmhDTnl2?=
 =?utf-8?B?aVZDWHRvcVlMVFZuYXN4NzVWcEt2RUpkeHZhTUc1RkF0Y2R0V3lQVnZLZkdk?=
 =?utf-8?B?Mm56ZFZoa1VBMzVZbXFZc2ZBTG9vOHlMWlBWcktiQlkxZ3JsWW5HT2tiOE5M?=
 =?utf-8?B?MTRwOW5LV0RxNFNtaUErYmc4WEdCb2ZRMWRMUjdKNEozUDNNMVpvU3BhSGRE?=
 =?utf-8?B?Q3RpTkdsWnF3UDByRVlCMXFkTmJuMTUzZ3E0U3lNZlhyYXN5czdYa3BPbmQw?=
 =?utf-8?B?aXZPZ09oQUxSMVZGLzhUbkttMlZUKzF3b3NEZDV5dUN4MkhqcjJBNW1OeHRw?=
 =?utf-8?B?YzIvcytvTDVkVWswY1RwRElFWEFhVitTd2NoeXJCSjRXMFliUHNqQzJ3WVQ1?=
 =?utf-8?B?aWE1Q1NaNmR6NkVqc29ZRVNOeERTQWpWSXFvV0YwWGxaOWpXQ0VRU1Y2UWcr?=
 =?utf-8?B?OUoxNC9LdkNXZTI1eFdhVlhqL2ZNR0Q1Nmk2dUNoS1d0cXpDMVlFUXVxZnZM?=
 =?utf-8?B?dTk3a0Vkdlo3VURDZTBTclA5T3dXaTJ2ZXRybFhZR2hKYXRRcTBVVytDN3J4?=
 =?utf-8?B?a205dDAyRjk5VFRIT2JVUTcvQWFaaU9vM0haNmlQTFZERG84Uk95azRHejBr?=
 =?utf-8?B?UEt1dVNSNXI5MWdmMUZOT2dRanM5YkVSa0dSb0sybHhpSVZINTZyQ25UazN6?=
 =?utf-8?B?c29TTDg0TUMvVjBRR2ZJdEt0a2tFV0M2RDRUMlNvb2NEU0t0WHdjU2FJaENw?=
 =?utf-8?B?eFkzdzdMVGZDZzFuLzlnNFJGYTJKVmgxRHNQWVRqVDZ0VFJPTFI2L1pqQzFC?=
 =?utf-8?B?eDFENFJjeHh6eGlnejBjMW5GdHBUMHp4YzMvU0hEWXQzUlM4a2drZlhTSE4z?=
 =?utf-8?Q?Iu373rp2s54NfmYVP9hQQMesv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc154a48-550b-49b1-8937-08dde40038b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:52:56.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cdthhdnMmxUVuFfhtCrDzpOiq4u8EzNIUcVwbgWZQVwhlnkFtK3W/GUeEIhAr4Cf0EB8x1jhGJtX4z1PVYM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933



On 19/08/2025 11:43, Paolo Abeni wrote:
> On 8/12/25 4:17 PM, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce two new ioctl commands, PTP_SYS_OFFSET_PRECISE_CYCLES and
>> PTP_SYS_OFFSET_EXTENDED_CYCLES, to allow user space to access the
>> raw free-running cycle counter from PTP devices.
>>
>> These ioctls are variants of the existing PRECISE and EXTENDED
>> offset queries, but instead of returning device time in realtime,
>> they return the raw cycle counter value.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> Hi Richard,
> 
> can we have a formal ack here?

Gentle reminder.

Mark
> 
> Thanks,
> 
> Paolo
> 



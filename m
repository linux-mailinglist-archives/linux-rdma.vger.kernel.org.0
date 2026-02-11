Return-Path: <linux-rdma+bounces-16768-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMOnGXy4jGnlsQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16768-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 18:12:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6641267EC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A255930078AE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03634888F;
	Wed, 11 Feb 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXmAGAy5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF8346FC4;
	Wed, 11 Feb 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829943; cv=fail; b=kp9mAuO4vgsgiTNHImrDQdfcEuJy3UsH1XXZ5lXIiLPLMioAmw7CqiYjf2SjCluDkda0JsI8WfY2kfqg1J3RsJ8m3O3NvCqPDR7bXMh8gL63BH47dcz2LoENuSouJng4Gpqxfr47II1PcPLpzGl+YYlMWcZw9huPf2rU0hDwxN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829943; c=relaxed/simple;
	bh=WHStHbx5v4VVfrfxadxLVJsGPVDpjvjr5UTlaHj1yCY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RKF4Q4lc6EbWbQVUQaaJ2jU1uKYEudxtqboTsT8XH4NWVyI9qZ0KlS4tyZnRqfqbiwnJPHzb7ZCI+3btfc2B5z/mVHlEb9imUhMj2LQPJw7sy8GTNghMGuGzC2jZBFmWlKPE70prJKg27i4hBUbQxwdgzp6Ryba1g7OoiHuSCv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXmAGAy5; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td6LwufFhXBvOnTsYGp+PuhoSfoBq2ea85rcdspZc3ZbV4GmBQmqpijFpE9oLpclrylSE7slLTuOreo/Aqf6G7GRn0t3xu3BztJ6zEgmBOzPiVp+bGGQSfn2VvEi5A8d0VpijdeDVPlT/JflQqd48SDvtwDGspN8X73zqgTepv9pTqh6qlF0VymMd1Qy15seLKtujyzyI11SQomOzTob8IJA0ckfDra109apoEuhH9y0/whkbC0Qk18cb10F9NpGbySF7w3PEUZ1JGxgQfgOwM0xLHVS0r/X3SccQO28nzfkc6NI9Yyfc38Sa5gmhbw17Ho+qA/ZXta7kkPpYrGQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiLlWPIQpTUacoPJvYaMoO/wqhfpdX6uxgVxakBrKzw=;
 b=i1ymQnLcuM9rUJlTPaVOQyXcL0P7FEp4/1educPsUfCHNtPxq+Hi0Ehum4uhRhTVwmMuJx7vPZDr33OasdaGI9B62Lk61cmQmXM3V1KT+qYUl0CLaQuwuh+6F8K1U2hp9IXImfXQKuV6tQb5XCrB0etTXXXAbOooxOeHw/YI/qZnmHOZZ0aDE+lVs9WAU4UQ9aA9gRFR8aX2hEwrJbQNRYoWJV6a+l0Ja8V98JsBy92Si7U+hT/UXQKYSentpJYCiJjOuGGW7NhPgyCwRfVLIaPtGx1QfFi7jI/vO9q1WSkgapByB8FyqnDD+uKjY/Iw1RTbbbR0yc5GCFLP/oZGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiLlWPIQpTUacoPJvYaMoO/wqhfpdX6uxgVxakBrKzw=;
 b=EXmAGAy5UkVoSMRZsYJuSZKfZES09Mg7qZ0NrW0PC96nH2oWS3czfeCxe6lS8IYDJhkCVfTgfQN9aa5c8wJpTzOHSXxjlwqPZeiwD4HorZGAXUOrYEy4mcmQ0KSd7vYGxSAEWX/j164MCf8HKW4RlfvRx/F7gWa68GDgGETG2p6tXErzkBC6X2WABf4LCtnV5yHZ3tMGNrF8fMG9dXSlArtn/Jg5F/qYwlmovL2wpqQ5QDE4oWaxGVOH0dTf2HNI/jQ/vVj+KWVN4EJo+9bvaclCIdwlYGkK2bItNBxBcLTRu2PEsdjQ2+q1VU/i0Bew8fEtCOsBUoImc03E3Qe/9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:12:15 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:12:12 +0000
Message-ID: <adb592ee-2f2f-4208-bd4d-0c41bb319ff1@nvidia.com>
Date: Wed, 11 Feb 2026 18:12:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>, Christoph Paasch <cpaasch@openai.com>
Cc: Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
 <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
 <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com>
 <CAMB2axO3d9Wr64RRxYQd8rg5QVxt5MO=ZzRtJG8njeDYNBW-tw@mail.gmail.com>
 <CADg4-L8a-FbB4A_dttfQXYuvOdnEcrYOYi4fG_7KBBWfaLL_ag@mail.gmail.com>
 <CAMB2axOa91igEKpt414YL7aMZ2yU_SDwVcG1xdTApfQYXzQk0g@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axOa91igEKpt414YL7aMZ2yU_SDwVcG1xdTApfQYXzQk0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 260796d1-91bd-4560-d9ab-08de6990b21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFlQWxVSUtjblhFeFFITm90NStRMG1iQzNDQVFHOGozMlpKK3NNOUp3VjVX?=
 =?utf-8?B?d1A0NjV0MU5ISFY1aUJnV1NOUW5aSVE3QmNEYnZnbjF2MDRKZzZwS0RHQnZI?=
 =?utf-8?B?enAwU1k3Z3VrU1p1Y1E2blcyOUFpa2diV3BpdEdjZnl3aFRGNUNPSDFyc3hu?=
 =?utf-8?B?aEFtQjB1TWhRNng4MEpOaW96L2ZIZkJMcFlLYklybFdPWFdYNUkxakExVWJS?=
 =?utf-8?B?K3FlREYxb3E3NWN1Mno1RWk5OEl6LzhBNDk4UVJtOTNEbzAzcnZpOVJMcnpx?=
 =?utf-8?B?VWdwdStMcmRVUURma0xQMlBHbmNQYUNhUTVjSHJtWEVHVERGRWl0c0hNdy9Z?=
 =?utf-8?B?NE82V0hYYk5yN2NoQkNmOHJabkdyUmdETWV3VzFmUGpIU0daMHZ4VG5MTUxm?=
 =?utf-8?B?NWY4QlNnVVpnNkdPQVd1TDdyZThJdFBEaXMxWTVRbDYvcnM2WmxKUXQvQzNk?=
 =?utf-8?B?QlRBQ1dpa09mYzR3Y1NaamprS3VXZG9JVC9SSjc2S3hHN0NWQ0pxWGt3djRp?=
 =?utf-8?B?Vys5aUVUbjQ5TjVJaVM1cE5CZ2k0U2RKdmtUUWcyTGlsd3BTWUVTYWZTbXZP?=
 =?utf-8?B?VlgwcU44ZXYrNFV3d0l2cWZrNnRpZlN2OVMwRW9DcTBFbVd3L0FWb25MT08r?=
 =?utf-8?B?R0EzdmVKR0k1QThqNnNrZ25LeXU1elRybDRZWUw5Rno4bnVDNFNXQlBGdDRP?=
 =?utf-8?B?dFZmaGo1Z05YNU5CSDVNZHN4ZGxqVHRDM2tWS3RLa25GVmpwd2tacE5VZHA2?=
 =?utf-8?B?cnNGS2ZIcUpRMnZJa2JGNWU4cXBVTTdwanhzKzYzVXFHNW5NaXZaUyswSE9B?=
 =?utf-8?B?aVplMW03MElQeXZtL2NWRUpGTVdSZkVsUUVWSmxtN2FMRmdGdzJsUlBScys4?=
 =?utf-8?B?TE12OU84MFBwVm5JRGVWbFl1Y1NMeWxXenloTE44Z1BzVksyWWNoblhQcDlE?=
 =?utf-8?B?K2lTOEZuRXdmdTNKclRqbExaak43NkI2YVlHNXgwZjU3N0tSVUFjUlAzV1dH?=
 =?utf-8?B?cVJlTjJ0WG5HcUh5VzVsK1U3YStUMkFLbmJhWGZFWUdlcW1uWnY3ZEpibXAv?=
 =?utf-8?B?S01HVUFWNG5Kd1FQcHhXY0RzOUUreE85YUluc3lXdk9FVjA4S0NOQzJROWdI?=
 =?utf-8?B?R3FmYm1QLzFvVVFKTm83TnlsWkVBMy9UOS9BRHVBVzFHTEdRV0dmK2o5c0sv?=
 =?utf-8?B?d2YxNXhzR0haYzArUTJkSEtJTWlGci9NcFlUbjU2ay9MYkhzeHZla3JJSjVR?=
 =?utf-8?B?SEg2WEtSdkwrUHdEV2kxLzA5WFFYVmhzOGZwQ2VsakdFeU1VVzQrR0FTbWVF?=
 =?utf-8?B?NFNvQ2U5eUpHODFYZ01GdUs0b0swV3RPcmtnb3BPeGVEYWZkRFY5azl3UDZO?=
 =?utf-8?B?ZVVOUzVhUjJTTi9pbEk1TlpvWW5aN3lYalRxT3VxWU40SVh0ZTREb0ZGTE9M?=
 =?utf-8?B?SmlBRjlWMnNLd2VhL2NYOUZBeWVDdW1NeGI3dXZ6cSs5VXBTckRBbEM1YVcr?=
 =?utf-8?B?SjAxcWdMNHBTMmg0T0U3a1FCMzY2VFhyazNIZFU3UGdUYjFsTFNEamYvL1Ru?=
 =?utf-8?B?T0E4VzhKWmNteE1udTBzVGJ4RlFLQXUrSitNZllMbGpOUXRuYkdCZkJmSzFP?=
 =?utf-8?B?MUI1ZDI1TE1HTGtJak1obCtNRVVBc1BXa3JVYmNxUTkzWnVOZWo1d3UzNUs5?=
 =?utf-8?B?cjVEUEw4OUh6WlJzTy9tZlQxK1FqWWxJQnZOK2FseDMrRm96K25UKzJOUmdx?=
 =?utf-8?B?RTlpbFJEaHlQRTRVOE5hbGRha1VYVXNjMjlJKzFlRjJEQVEwT1hpVTJsenBD?=
 =?utf-8?B?RE53SXYvQysrNEdPdG9sdTZoVGZNVy9IeldNb1MyRmt6di9SS1A4STZTbU1E?=
 =?utf-8?B?ZWZXSFovZVVMY3FqdUYrelhweE9HamIrWVNkdzRSbmpLeVFLa1pjRzBaai90?=
 =?utf-8?B?QnRKTXZZT3lRRDh6Q3ZsY3FMVDN3bmE4K3crNmpHZVE0K1BlcGQwc0ZsVEJB?=
 =?utf-8?B?M1BGcFFsaG9tNTlINjgzdFVMWWlnL1EzcG5QMWxLMmdCeHVmUndidnVvdm95?=
 =?utf-8?B?QnY5RWNIbEVlaDF3UEkvWEFBMjRwQWY3WVFZcEp6Q1hEelQ2bVFwU09MV0or?=
 =?utf-8?Q?3998=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtnUVhjUFY0dktqMEIrRHJNSUh3RmZ6R1hIVzRzWTBVcEkxa29mWG50VHpS?=
 =?utf-8?B?N0g5clNmRVNLTkJlNVlUNEtoMEZkWmhVWnJiUzNyeWJRdTd1UTJzOXhEeGh3?=
 =?utf-8?B?bzNKN1d1bVh6L3FockpTd2o1cCtqNGptMTI0SnYxS21ZRTlNOXFpYWlsdlBk?=
 =?utf-8?B?SkVmRXdsbHVwNFFsVXl4NFkveU1TTVBQUnAvYnBoWDBrU2JlaFRNWklFZm80?=
 =?utf-8?B?RWtzTWw1MVFKRi9TRUN3MDZQcjRZZkVVODI5QkhCdFBoazdLN3VlMDMzRURN?=
 =?utf-8?B?clFxS0pFVW5maXY3NUVLWEl5ZFU4U3FkaEIzTTJ3QU9laDB1dkF0djdIWExF?=
 =?utf-8?B?VlBQMTBwclNIaWtSUXU1WTIzNDJ5SG1HeHZTclplb29ycE9jYit1b1l5cVZx?=
 =?utf-8?B?YjQyblRrVDB5SldMRjN4MmJjYTZUc0hPbGxmeDIxQ0NiUkpVWW52WDc2NnhK?=
 =?utf-8?B?Njl3N09wNHlYc1F5cHZJY2VWK3J3dUpOYjdzRVJHVVRrTSt5UnNNU0NoVHh0?=
 =?utf-8?B?WlhSSTZWaStxTHFJeHoyalpJZ3NGbjF4aHZtbTQzRlA3dlI4M2ZWdEp3RHNz?=
 =?utf-8?B?c2FZN1d1aTYwano4WVdZVG4wVGRybStrTThMWEZWdmNFQnpaamR3Q1Z3bDZX?=
 =?utf-8?B?SHZlaXM4KzBwRmlGdVBQRTkxbDdjbFJPRTJ2bmpZbjE3SzdiU3VPOGVGWTlQ?=
 =?utf-8?B?RFplV05KV29lL1dxVXUvVFd4U2ZHamN4Vk5BYU1yM0VoNXByUnZmUHJOVThK?=
 =?utf-8?B?T0k0TCtMTjduMTlhZVRjbHBIRW84VUlQSmxiT2luSXVUbFVIUEtTV3NTcDVv?=
 =?utf-8?B?OTVUQ2thamtLVnFwU3RBL3FGVjVVODNWeVVUMDY4TWRRelRwRDZlR3VGdkpD?=
 =?utf-8?B?WDZ1VUlMeTh6R1EvTTN3ZHhqSUNSbDYxOVIyZlZqWm1KM0FQd0pLMWRVRDFt?=
 =?utf-8?B?MjhCRUd3TGlob2N4OFB5MHZYTzdFMERzZWNOaHNzN2NmNmFhcndkWTI1SVRC?=
 =?utf-8?B?Qmd4T29Vbjk2bkdndXRKVVRhUGdlZU1wdHliUTJOMyt3U3pSTnNab29qTUc5?=
 =?utf-8?B?SkZLVVIrMEk4eldFR1JQQnJqY2dtaHNwMjNqbWdWTFJObnNlbDRXOGFwK2hy?=
 =?utf-8?B?dWJvSlNQNnMrU3paeDZ1aWtMcTF2anVwbS9BdUM4aWJPTEoxaFp0amJUb0Vt?=
 =?utf-8?B?RGswellTcmRTY3hTdElHeEVRUkNtRWVIbFphejIvS1NxYnEybmxNM2E2Wi93?=
 =?utf-8?B?UVJPZTVIUVgrNkhNL3RzZU5lYTFhMHlvL0Z3d1lQQlorSFhXRVlnRndTZmQv?=
 =?utf-8?B?UlBOOW9DUitCTnB1RTRyNlpmUnhRdGg2QlEvQ0I0QkxBa1NsV1gxTy9SeEJC?=
 =?utf-8?B?RHFNNUkrWGptQXFtTnlreWl2dmNHVG05cDNPSU9zbys2a2htRktqWmgwWDY1?=
 =?utf-8?B?N2hzdXhjSHRpZjVEOTNUN1ZPOUZka1h0UFUyVXR4WlIzNW1LL1Z3RGdXSk9k?=
 =?utf-8?B?WEJVM3NWSGVsZDhud2RrV2dUNXg0YndDNVJnM0M3VEsyQjY5cE5oZzJuV2dZ?=
 =?utf-8?B?UFdIMkk3VjlnRFp2cjlINGRWZ09vTWVaYW9qYkdYdFFEMGswdFZ6ZzQzZU4r?=
 =?utf-8?B?STBrS2VzOUJEMTBlNHkyMnB5NktET292M21DZXBubHpRcW8yaXRFQ3U0YUVH?=
 =?utf-8?B?UmVDRXg3SkpUTFhaU3I3d1JZL1k0TE5lZWJlQmw1aHpPQVpia3gyYzRYK1Nr?=
 =?utf-8?B?UW9OdGdxd1ZweUhHeFVwbll1QmQ0ZDhQVWszazhiZnNpbkJhK2F5a29NcVlu?=
 =?utf-8?B?Nnp0cVFyRHlBY0pQRWtjUlhwMDArUzkzZUQyeVFmZHZMZWhiVVV0cDdGbFlj?=
 =?utf-8?B?VjRiRnhWNjEvRFVra0dMV3ovd3MrVEl6YW1hV0NkampnR3RsL1djSittN2dj?=
 =?utf-8?B?ZVludE9ZNHVncjRTWGljMUsrK1M3ZWpRekVROVBlb0k0eEdpWmtxV3d1b1lC?=
 =?utf-8?B?VkgwalZjUk8zQmp6NFhqcWFEaFp1UGJ1MlRoeVNtMzk0RjF2K3pXL3k0WGlB?=
 =?utf-8?B?bFNYWmcrZnU2L3d0c1p4RUhSQWd1Nm9wMi9kaG0ydFlFdkx2TEduVUFUV2tk?=
 =?utf-8?B?L3VEZDd5R0hzYk5iUGZMUFlMVGdKK1plMFM4dHlHd0h4SC9ybHY2aFp4bGcy?=
 =?utf-8?B?Q0NKRmNQditod0FOS2lCQWRBZDR1dVE4VWxYRXJMYy9sMlc1Q3pNZ202Zzlo?=
 =?utf-8?B?QWU4R3R2azcvSXJHK0JNSTFPbUloUVl4b1QxenhWdkFhMURYSUo2MDRoQUhm?=
 =?utf-8?B?amJQajBocWF1bFloanV1RjRUczEyUE5zajUwUHphWEtFbGx6YjVlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260796d1-91bd-4560-d9ab-08de6990b21d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:12:12.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP29SrkNIpqPQyc8NvAMm+Q59e/5l/8B6fIU7aQH9HfBmMP22H0hPzZO+mV83cbAKERzHnZhM1Vmo0rke0eSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16768-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,openai.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openai.com:email]
X-Rspamd-Queue-Id: 4A6641267EC
X-Rspamd-Action: no action

Hi Christoph,

On 10.09.25 21:09, Amery Hung wrote:
> On Wed, Sep 10, 2025 at 1:36 PM Christoph Paasch <cpaasch@openai.com> wrote:

[...]

>>>>>>> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
>>>>>>> LRO enabled):
>>>>>>>
>>>>>>> BEFORE:
>>>>>>> =======
>>>>>>> (netserver pinned to core receiving interrupts)
>>>>>>> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>>>>>>>  87380  16384 262144    60.01    32547.82
>>>>>>>
>>>>>>> (netserver pinned to adjacent core receiving interrupts)
>>>>>>> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>>>>>>>  87380  16384 262144    60.00    52531.67
>>>>>>>
>>>>>>> AFTER:
>>>>>>> ======
>>>>>>> (netserver pinned to core receiving interrupts)
>>>>>>> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>>>>>>>  87380  16384 262144    60.00    52896.06
>>>>>>>
>>>>>>> (netserver pinned to adjacent core receiving interrupts)
>>>>>>>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>>>>>>>  87380  16384 262144    60.00    85094.90
>>>>>>>
We still want this nice optimization. Seems like last discussion was
stuck on reading the header length for XDP. See below for sugession.

[...]
>>>>>>> @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>>>>>>                                 pagep->frags++;
>>>>>>>                         while (++pagep < frag_page);
>>>>>>>                 }
>>>>>>> +
>>>>>>> +               headlen = eth_get_headlen(rq->netdev, mxbuf->xdp.data, headlen);
>>>>>>> +
>>>>>>
>>>>>> The size of mxbuf->xdp.data is most likely not headlen here.
>>>>>>
>>>>>> The driver currently generates a xdp_buff with empty linear data, pass
>>>>>> it to the xdp program and assumes the layout If the xdp program does
>>>>>> not change the layout of the xdp_buff through bpf_xdp_adjust_head() or
>>>>>> bpf_xdp_adjust_tail(). The assumption is not correct and I am working
>>>>>> on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
>>>>>> will not contain any headers or payload. The thing that you try to do
>>>>>> probably should be:
>>>>>>
>>>>>>         skb_frag_t *frag = &sinfo->frags[0];
>>>>>>
>>>>>>         headlen = eth_get_headlen(rq->netdev, skb_frag_address(frag),
>>>>>> skb_frag_size(frag));
>>>>
>>>> So, when I look at the headlen I get, it is correct (even with my old
>>>> code using mxbuf->xdp.data).
>>>>
>>>> To make sure I test the right thing, which scenario would
>>>> mxbuf->xdp.data not contain any headers or payload ? What do I need to
>>>> do to reproduce that ?
>>>
>>> A quick look at the code, could it be that
>>> skb_flow_dissect_flow_keys_basic() returns false so that
>>> eth_get_headlen() always returns sizeof(*eth)?
>>
>> No, the headlen values were correct (meaning, it was the actual length
>> of the headers):
>>
> 
> Another possibility is that mxbuf->xdp is reused and not zeroed
> between calls to mlx5e_skb_from_cqe_mpwrq_nonlinear(). The stale
> headers might have been written to mxbuf->xdp.data before the XDP is
> attached.
> 
> I am not sure what exactly happens, but my main question remains. when
> the XDP program is attached and does nothing, the linear data will be
> empty, so what is eth_get_headlen() parsing here...?
> 

AFAIU there could be 2 cases here:

1) XDP program doesn't modify the XDP buffer so the header is in the
  first frag,
2) XDP program modifies the XDP buffer and pulls some len bytes into the
  linear part.

So how about always reading headlen from first frag *before* the XDP
program execution. And afterwards calculate the new headlen for
__pskb_pull_tail() based on previous headlen - len? Like this (untested):

```
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2159,8 +2159,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
        if (prog) {
                u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+               skb_frag_t *frag = &sinfo->frags[0];
                u32 len;
 
+               headlen = eth_get_headlen(rq->netdev, skb_frag_address(frag),
+                                         skb_frag_size(frag));
+
                if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
                        if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
                                                 rq->flags)) {
@@ -2208,8 +2212,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
                                pagep->frags++;
                        while (++pagep < frag_page);
 
-                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
-                                       skb->data_len);
+                       headlen = min_t(u16, headlen - len, skb->data_len);
                        __pskb_pull_tail(skb, headlen);
                }
        } else {
```

Amery, do you agree?

Would you like to re-send the patch after the merge window closes?
If you are busy we can also pick it up ourselves, do the required
modifications and send it keeping your authorship and the existing tags.

Thanks,
Dragos




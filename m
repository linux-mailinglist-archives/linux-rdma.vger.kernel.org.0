Return-Path: <linux-rdma+bounces-12542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C86B15F15
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45B5566220
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD02951DD;
	Wed, 30 Jul 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfK81xL7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE7298CDC;
	Wed, 30 Jul 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873594; cv=fail; b=JChM9nOqpdmAhOVKCGq5o6/LuDDPVievJe84JkA3xhAJ8qVviQ4QHZywep5OMMsFsqeFkJOMSWiFq5WVzxvSpYCpUgjSWNUuCOLo6ZwlU9D8EjjLqbWFU92xqeTqmoIdN1AWxmOXsILqcs/RRWcpRn5c0BvohX8pfO1awOHAUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873594; c=relaxed/simple;
	bh=50IvEomL3sYZY3O5QPc8fBWjgY9pBRlqZu4CWm8HhvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vC6Oy5yaI/w+I1QfzKu7bzMB4IhEGArkD3Fu2pWFY5lr17V9CpwxSYC0xh2VV/76XtrLCO6XdCbEHYGmlfwVrZ/bL/P/+VEwMyAeG0Xev5pmv6tFFn9sDPwmwPUeGD/MWFT51NmOzKBFCUWWr2MqJWZeMNaM7I40OsE+mHNydTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfK81xL7; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX243uKLZTpK7u6+1wlhIOvq+yKChnfB7YL8J8DGdoAr0dt4Et7KcbpRdXQtElbTWnlE+YyoC1VK6vJJz0C/nls7wWHhJCAhWzdmQwkjjWGefsM9h0CsfVhIyYOFn2jPy2Yydexcg/zgEyH+tuEswqrgcF6Ivzs2Kuu6vhvNjRAZNwMXQrbUbNKJQk/VodMjP71QQz1C75Ky/ejogLk3k+bM+VcEJFQOvVEov7YCUiX7LRvZszrwDRGOvNmK+fVL+6m/wbgmUB7MjYaA/aVeK42mbMb5PHy8Yl2jaoCP4XFA+GxHCogu14bRj/pTURW058MDppkM8n5Cu/wjl3jsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQgf0SYu1syljYJiLuiOXOWeKyNRnGfbTknJiMXWnKY=;
 b=wsSxw3ZOmANig8UrcobExnCRgCY741XpMIcqtA/C8jblI/MBNitXL/oo2DJaGBIUo6dx9FrEsF0xSXQngShRnTY9hkZosHzD5edx2EYAE7qmVPOeynK6d2gt1Ve4kh5kdAPj1CX/GRSO3ct6HjMDhlTxJgjzh3jyVCtmW7G5IfOQYSg3Oe7inidFYPZfQoSdrx3sIKIAx4oMq891t//EMCOEIrmZIMw/MDN9GR4mUmVWiadFY+GbIOPaEMn2tOOuWBCfX1NJxOt0Fo44WImx+bbgU6lnMiQE6zVQ99mBzcFZrs+bVinC5+fN2EocCx9EMfYTTJFDJOzej++Vg3ar0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQgf0SYu1syljYJiLuiOXOWeKyNRnGfbTknJiMXWnKY=;
 b=jfK81xL7MDrQy7MEvRocStwLpRMhbBAsive4FbEPn+0WNr6In2F98oDqR9LPudB3ZcfBIEzHTb0UYmsz8sv2tMUf55+iE+ZhDZSnhphVe0hAVPSXqlauMo6mURBEWoNqZAHbAA1XZbwmfNBplhcvp1dslaIu2MNFzioCot1zn+dCts/lMbGkr8HdMddHSoeCfZgn+/hVVSYnHIoCyUTvkJ2yYyLbnO1e4yewp9XQAOMclvJCPT/n+mGQ1l6FUhANhq3CSW8Sv/jmogOPmCV0yQsrvQedsg1jxwt3ONTJPTv5jFU2lPusjBUAi1wkeABiYkJhpPb+m5og3a8vjeQ6Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 11:06:29 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 11:06:29 +0000
Message-ID: <195d0388-57ca-4a1a-bc92-65da899443ab@nvidia.com>
Date: Wed, 30 Jul 2025 14:06:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: fffa3aec-fc69-49d9-2396-08ddcf592208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0VST0dseXlHLzdTMWFmYUpCdzRpWFdGUDdtZ29mVVBMVEFpZjRBY1JRKzZI?=
 =?utf-8?B?N0hkMTVQT2VCSjAwM2hXeHJJSHNlTUNTcGh2SldMR0hmOFpNVzFZbTFKMVpI?=
 =?utf-8?B?d05sU1YvbFFEU0h6Wm5PeHE4SCs1UTRPalRSUzE0YU9xRXBUMW9MWHRiTlQ0?=
 =?utf-8?B?TzhoU05JdjFDKzRBM2lwKzhyMEtQSXNtN3BVWXpuZXNFVmp1d216QkphTEpu?=
 =?utf-8?B?YU5GbENYbDNYVDhtanNOTWRIWVFtdW9OZ1RIZ2VFMzQ5OE9CM3hsQlIwOGdp?=
 =?utf-8?B?aEpBQ2pNYlJyRlRGb1FmWGVPNlpmWDRtZWloWXY3RFNxTXM5KythSmpnUG9j?=
 =?utf-8?B?MHV2VU5rZHZVdjNLd0ZBMml5aWk5RFh4QXkrVVUwMXlqc0RsYTZxais0VjR2?=
 =?utf-8?B?TmszVmwvWUpSSDhRdEplUFZnMmhqcmhxeEJGWGNMM2Q1TXh1WmFpUXhvMkt4?=
 =?utf-8?B?MXdCQWJLRFNMOUJVeC9RZE1nekI1eHBLSWxDbG16N0VOckc5aGdnMm04b3d1?=
 =?utf-8?B?S0dQRkNvUFc2b2YzUyt3OXJwL1ZJNGhMTHRlSEFTTFpmeVk3U2JXZTNXNXdX?=
 =?utf-8?B?enJzRXJSb1VTWVN0MEtIUXp4SWpSV01KVGZxbU9IK2ZuQjBHWmFlcVQ4M3Jv?=
 =?utf-8?B?VWtMbGVPT3k2UDFlT3hqamtwTkhzS3F5aEdXZTgwaTFDajVsalYrVGF5TmVV?=
 =?utf-8?B?dWs2Z2ZHUU9lWDU2ZFVkOXd6Y2hCb3NRVWoyS2hKM0pRTnFwcGlMSzZGbktx?=
 =?utf-8?B?WGtPQnBkeXVYYkZQbTNGY3VxZS9RaHZWN2tTU2hTVjBLc0xHRElvQmx0UzlF?=
 =?utf-8?B?WkN2S3JOdzVzOWk2V2FLakxOMDVhR3l4aVA1UFE5c0Z2UlNRRUUwZkJPbFFB?=
 =?utf-8?B?Z2o1YnVMejNJM0hGb0hmOEg3ZjVMQlowVm43a0c3WXlEZkFzRGIrQ3hFK1hL?=
 =?utf-8?B?cTRhR0FYd0hYNFA2UVFyYXY2cHg5Sm1zK2FmUVo2dlBuOWIzbnFPa0hpMlpE?=
 =?utf-8?B?NHBVeUlxd3JoVXoyL04yVjRsdlhkZkJ2L3BjSkxvTFVjQ0FYVk9TVVFzTWhM?=
 =?utf-8?B?Nk9lREZFOXVUNmE4cWFFc1Y0VFJEeFpKRHRtRkI3WndoV1g0THZDWGJtUHN0?=
 =?utf-8?B?UlJoeXdMQmhMajVYYVFGTC94UmI2SWNZS3hRNWpoNE5KcEd1ZEZKNFN4ZzhD?=
 =?utf-8?B?bGdWZnlxNEhSR1RONWY5Z1BEZEg4VUZuS2lML0d6c2dKcXF0OHEzdFk2Ymly?=
 =?utf-8?B?clAvQlBZaldMRDRiNDFsRXlndVNTelJGaHRyVHBvay81WkZEV2VtR0FpZzJL?=
 =?utf-8?B?amZkVUVjbVZ1VWtBcjFUQVN2OEZkSEswUUlSTFNGU2RwdW5UQWRqdFBnM1Fn?=
 =?utf-8?B?L3p4azdjZFZyQVE2QkRwY3VxendyTjJDa1o2WFBYNTBqQk1abUJBV2ErQk9W?=
 =?utf-8?B?ZlBLRmR3czJnckQrR3h0UVJCK1hlZ2hzaXFZblZDdEdjclZFc3ZwdnBSei9J?=
 =?utf-8?B?dWc2RXpYcTVGOWduTkVqQ1Z6dENyRFJDSWw3QjBQa2Z1M1RFOTNPc0Fkck02?=
 =?utf-8?B?U2JkSkpKQ1hReWwrclQ5TXhLSXA4M0NXd1VCbWt6dERjQ1hvWW5sSlNNMUJX?=
 =?utf-8?B?S2tRWFN2Q0ZCdlFnYlJEQ2dlWjl1Wi9vbFJtay9CNENvVUpZd2FCWDlKeUlB?=
 =?utf-8?B?WHpVeGFtc05zRzJNc01zcVlwRjhvZjh1TkorS1JrdkxhdzJWTDNtR3AvMFhU?=
 =?utf-8?B?bmdHSnJWa0twMjkyZWR5cWozOTRrZWhhbGZCRFA2cHVZeXF4bmtFU0lSY1lY?=
 =?utf-8?B?Qm9FRHVjTXE5TDVQRlFObEFkQUQ0QkUxN0dCOGVOK2VpYUJQZnlQQ29pTDhE?=
 =?utf-8?B?ZUVPbUUyK3ZITVVFQmJ1bkt6N2IwUVpnZlQ1NEg5TnlWczkwL2pjM2xRS0RO?=
 =?utf-8?B?L2tybG53eFJJdkROYStwdjZ5RUpHTDhDZ2c5bmZ4QXoyZ0Y0OHhJcUR2VXJt?=
 =?utf-8?B?TTVoRzFBRVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ZaaE9TczA5TWVNc1hLbmVPSC9YYWgwNjh0UWsvblNsb0VIYmJMN2M4OXVJ?=
 =?utf-8?B?WUl5YklNOHl5blpRSXBIUG9oUFJDTWNGditWSXJ4ZEkwYzhXK1VNdlMxQzVY?=
 =?utf-8?B?OG1JTEJCKy81bi9tYUkrNjVQQjgyODJlNWlOUXY2SjRIaWV5M09lRWhHNVNn?=
 =?utf-8?B?aGlpd2ZiNXN4U3F0OVh3c2VCd3VDMjkvT3orZFJ2dVFLcWxETFEyRkFVdE04?=
 =?utf-8?B?cjg2REhCeGMzVE1vODNqY3U1RDhmTitDbWh1QStrVTlwZU5nS0d0S0xnT3RW?=
 =?utf-8?B?ZkhjRmdBUXdVZXRVRHVSYnRpbUpiZlZIR3BONGRPTFBwUVdnYzRnRXhTUE95?=
 =?utf-8?B?dTlzd3VodlNNN0ZIN3lCbUEzZWdmb01rS2pzZWw5VmUvN1dvcU53eHB4eWQx?=
 =?utf-8?B?Y2s0TVpENFU5ditROHdKQTJSWWswcjlMV1krbUMwNUVqZ0xZZjE4ZHFERDNh?=
 =?utf-8?B?cmhLOFdldG1qZllrUG45R0JQWlBycDVsUWNmSU44UzFLYmRlTjdXaXprNXpM?=
 =?utf-8?B?VUV3NmNHYjBObS9aZVo5U0ovUnNNYldrSXRvUnMzT1NiT2lmajlYMzh5SWVS?=
 =?utf-8?B?Q3RvbFV2NmdMVVV2TDlIbjRzME9oeUp5eWpQMEFJTWV3RG4wRjh6R2c1YmFX?=
 =?utf-8?B?R1FqU0p3ZFdtU0k5dlU1VjEwTzZaSGpoYnJoSGdpb0hRU1gweTB6YlVZcVpj?=
 =?utf-8?B?WHV1QnFUWmNyUXZ3VjhCcDJSRGhjZVpZU29PS1ppSnEvTFNGcWY3YnBydk1M?=
 =?utf-8?B?U25DcWo0c09NRlM5cWtDV2RhTDIrRTRIRnAxYW1KMEEwR2FsT1ZITDl5bjhM?=
 =?utf-8?B?UWNKMm9hby9TbGd2T01aejNXLzFyVGFMUUxzNUtEcHVlOTYyc3JDVGVqSk0r?=
 =?utf-8?B?NU4rMDdmM2FWbEl6Um9rTFc5VjB5MFZyMXFCWk9sS0RNeUtMWDFGQlZhREN4?=
 =?utf-8?B?Qml3MDk5aTl1M1JDYVVLTTBwWU9oeE8vL1h0OEtpdkluK1VjcVRoMXMrVE5r?=
 =?utf-8?B?Y0h1NU04d1pqTC9QRVJFMXF0Z1NUZ0FpYWMrd24xY2xsQll5NHFPSGVMdTdt?=
 =?utf-8?B?N2RwbldOMVhMdjlzSXo1MHUxbEI4YnRreTd5WEFzRFEyNjlwNXlqeUlLUlJR?=
 =?utf-8?B?cmRvdldjVDNrNFJ3K2N6QitUdUUzMEtyS3FVSjdXNFk5SmVGY2tvSEYvYy90?=
 =?utf-8?B?YkZYUUhZMkR4UzFZYWRiQmZ0R09ZcGF0T0pIWEFyT3U3MGhmbGcwSEhEdXVa?=
 =?utf-8?B?UkFGU3pEZEo5MmFueUk3Q1JXR2djT1lKcVBmTUo5QXVWUzdyRC80UmcyR0dE?=
 =?utf-8?B?Umt4RlRvK2JkWTZ4b3dOeURzL3Y1MW5BY2FZVkI1Ry9FV2lhV2h2TlBhV0V5?=
 =?utf-8?B?K3U3bVpzNGk3YUdudjEzUHFwSGVtdk01Yy85a3ZwSmc5TVowQldaczVrWm51?=
 =?utf-8?B?N3FDazl2aSsrYWlRNzkvOUczT2pXWjdXRU9vVU1BN0ZoS2IxNDhEQ3J4bXZy?=
 =?utf-8?B?OFJNajQzd05Uek1BeHFVLzRQMkwxZjY3MjRoU1Vpc3NzaGJvckx1RDJuY2c3?=
 =?utf-8?B?ZUE2d0RFT3N6VkxZOFl1Wkdrak0ySml5TXdNS0o3ckxDWTk0ajVGV2xrck1K?=
 =?utf-8?B?Y3hYcVJHWmJocm9sL0psT2Y5cmhBZTc0RkFaV2hwL2c2dU1vSlE3RENycnNq?=
 =?utf-8?B?YTRsQ1FJQ3JSa25UcUVuMkhlV1J0TTRYRFRwWkkrSkNDc0U1N3M2OWFNWXpL?=
 =?utf-8?B?TkNMWWVlMHA0WlNsSHZYZU1oTHdCcHMzUFZQdC91T3F1eWZRMEdmZHRzeVJ0?=
 =?utf-8?B?UG9yRngyeHJsaS9zbGMvR2JPcnVKUlpPd2twOGVSRnVrd2ZvYUpMMEc0ZzE5?=
 =?utf-8?B?MDdCSC9MaVBUa0NvRStKc0VlMHdObU51czFSUjlXN0lTVkdGTlVyU05NQzRG?=
 =?utf-8?B?R0tySEFCZGsrRnBVSEdvZkVDRW1PSlM5ai80NW16L1ljb0tnbGltN0czQUcy?=
 =?utf-8?B?Yktmcmg2NWlqOXpSTWxwU1RRbGpCS1RTNHIrbkg3UGhKd2pYa082SXlQQThG?=
 =?utf-8?B?c2tPWVVxSHRRQndLQzVnVklITk4rM3A0emZVZkZRM1I1U2haTUxBbkQxZEZr?=
 =?utf-8?Q?ZruAc35UOBK7t+LRPFRbkPFLm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa3aec-fc69-49d9-2396-08ddcf592208
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 11:06:29.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkTJ9GD+Gz32Rn4wXTlxDNsN7iWQXG+Dp2PZ3oRFVXrt3Z5po4nAcFALTD2nRGp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

On 29/07/2025 21:34, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When gso_segs is left at 0, a number of assumptions will end up being
> incorrect throughout the stack.
> 
> For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_segs.
> So, if a non-LRO'ed packet followed by an LRO'ed packet is being
> processed in GRO, the first one will have NAPI_GRO_CB()->count set to 1 and
> the next one to 0 (in dev_gro_receive()).
> Since commit 531d0d32de3e
> ("net/mlx5: Correctly set gso_size when LRO is used")
> these packets will get merged (as their gso_size now matches).
> So, we end up in gro_complete() with NAPI_GRO_CB()->count == 1 and thus
> don't call inet_gro_complete(). Meaning, checksum-validation in
> tcp_checksum_complete() will fail with a "hw csum failure".
> 
> Even before the above mentioned commit, incorrect gso_segs means that other
> things like TCP's accounting of incoming packets (tp->segs_in,
> data_segs_in, rcv_ooopack) will be incorrect. Which means that if one
> does bytes_received/data_segs_in, the result will be bigger than the
> MTU.
> 
> Fix this by initializing gso_segs correctly when LRO is used.
> 
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")

Maybe we should put an additional Fixes line for the gso_size patch?
It doesn't directly fix it, but it will clearly emphasize the importance
of picking up this patch together with the other one.

> Reported-by: Gal Pressman <gal@nvidia.com>
> Closes: https://lore.kernel.org/netdev/6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com/
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Thanks Christoph,
Reviewed-by: Gal Pressman <gal@nvidia.com>


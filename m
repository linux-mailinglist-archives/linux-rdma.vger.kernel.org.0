Return-Path: <linux-rdma+bounces-20695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE+3EYbBBWrXawIAu9opvQ
	(envelope-from <linux-rdma+bounces-20695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:35:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D929F541B1A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D08302C0CF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2C2F4A05;
	Thu, 14 May 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmZyy+dc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94E2D061D;
	Thu, 14 May 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762078; cv=fail; b=iGa4YEGeyoqtCn7XujRfrS3CluVWQQEBTjmjM+tk+9SCemKpA7VZDpJLXpnRYV9jMQDZ9ne9HukAlXlcK1Bf8t6k2fODjoD/l4AE7oKjVpq3YIcjIH1aEd8XaJTr08UJJzio5nxDPAwcLV8bVZPPSjj/myoF3nkkytDnRYqR7IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762078; c=relaxed/simple;
	bh=wGfgg2gTNgAj4/5F0CxDMybPLF77Kpp0cPchapolvYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4vP11n7gh75w4VnU6ShykmL6QGCuifPhnuXmfTOTZJN86kpjPQ5S2b46Pdeq9mUu/EkQUdnnRjTM/YZJZfYDy8wOds9uUfxg/+XAJNSuNTjf0wYwNPO3ZVQdHo1WXpHkp3p3Lv0gWr0kfFRcrKWjoiHGoTfTw986Tv8lwK57Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmZyy+dc; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpwsQJ1iLtNYy00WeEkQprKOHYxArO7xmN38ZEV2VJsR4ybk0I/NtEMYV0+nNisAvwPwPR2sMo70VY9u9wURuTTv6/e4SuDRt0WGzEClwqhqEEXh/KLck3JFwD3ecstc5rnPS1l2WPMbeL6EHbuYDf4S40TcysUCPrG/0BUzVgeO2HzwFYAryPSVkv865I1RnMtYKmK8w8jtabOZy9s8dMO4FpND5yhARJzhXTdjJqQHpiQpRXdJ2UzbLpcQr3CI+l6HYYdEpvG90PEsisoSaRqYJTGwe3tz+pEdH6HY+SyEdAmhmVm1uUSgSoQO6PmcUpaEEXIwqhT4AmqEO8CTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5sfSXPLcQ1ANbDo8QSA91us3WFSj4WsceAmLCnFtkY=;
 b=itjb6LBaxj7TaK3W8Rqx+HXKhsMDzPtPY3H+qA4P4YoxK4dLI78OwXWoIZ9UygTJsXbroMXcntd2qYeODSYrKTxkIbQ8rjeCR6sFiBdj7VEK3NR7HKuuvJgO4Eb/cWtmlZwMe+6MNJ3/fSg2lBT+b4amGzfAJ06KiaCITyn0hcpFYQVH2oi+4KTeAWQruq76dExzyLumBgIyq4jgjJ0BucfACXDall5UoxzoOpVItgWW2khiskNw8L0FEzkSKFsqKVnun9HQiblAwYvAOy4FOc3ixaMv2TVY9jXYO6UOlPpgUBotozQGifqyS9bjGbLJN+8KoxY0N6G9Hk9js0bIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5sfSXPLcQ1ANbDo8QSA91us3WFSj4WsceAmLCnFtkY=;
 b=AmZyy+dc4n+W3TSfe6QlNISGgajpuL5LzWKgPT+tqNTpBSypges13DEePZfNp85X3xoeEFz+4pr5xYNA/W3vEx/ewC7eHFuqiKyh5bO0u5L5MyDBpeyxhx0EYRwOLqRCY1+ojjTgGSotgDEWQR4uZgrrXZov9UMoRzMrRJGLnvjVzEeNqBWeP3DByHk0uzRbUu95okH+YGLvLl8AYrXmq2F6yAx3vhivHe44CJJz4CJYVOzGb2InLusTYaSNGWhxaLLskvp5jApjniRWjSUz2pbsek2NFcuiQlmRpPtKfycxIi7aQrnB+4+IKaNRvPO+Hxsw9KR/K4kWhXJcmYJ64A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 12:34:33 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 12:34:33 +0000
Message-ID: <142134d1-5a69-4186-8f30-5b47c1b464ff@nvidia.com>
Date: Thu, 14 May 2026 15:34:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap
 <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20260508175213.1952097f@kernel.org> <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agNy3RF9WCHBPev5@FV6GYCPJ69>
 <29868c1b-5751-421a-9f2b-2ac0f3324904@nvidia.com>
 <agRcYDkjsQuS7ArD@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <agRcYDkjsQuS7ArD@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1ea837-93ed-4d89-d609-08deb1b5266c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4143699003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bs6kqHDx1DmtVnn5IeMjdaa2XhyonxT4I3b/9/SGTUfqPX4nCVkoaqIYXN3G7Y0/+QShDPmiBTz2ZUc92VPqAsVE48hce1FdDLjkTiF9dVNJzVP9S7OkXUJGNgL/NT6Iut1dd9tBap+Xhge6n6CpaA+4ttvoPtIHRvDVIeRd0JFYWrBK7BOMVW7fpt3b43t8UU6v2udPQtLLHrjuPuLFzDQRWJbEEpakIV5H3PRo/9V6zvaB8B34sYnJw/2tUXFELRMns+RkWa9r1STMrFZ43oZnfK+TqeZJV7GlwJaCeC0U+56n4vcHuhEyavtJ/uj9OtP+m5TQRAaCjobp9MnA/6jUwCYhrs+KGZoJOCoy0bQB40UgrXI3rnLh+CIcGaNvY7dzpOv1tOPQJIzKZZR/4LkLT7cucQo0duas8hNJjJzb4OKIT3k770oc3xijMSznzHncjPjXbYF/X4IyMF3lnlwT0sdjbjnLVRZTjxLvnsVZ48wtb6rYT3ya/NICKAswGAyycmVc/tb5d3C3IUHnyf5oA4FWsMF5iN9+LdBmgPbCp4BOA/oaoK0xEJPRnOyyYzsjwpvWofuXsDKlSibgbidEJIYYFB79QGchepHWF8Z3ZI/G8/WwLycI2nhjb6CUapKbXO/tphVKeUuRIRkZyKfb1uMwHub293SANPfzaTWTohCtPfENxPvuds31jD/F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4143699003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejdOQURJVkF3UEVjTXJDaHZQNVA0c3lGOEFCaVdncno4VFJLc2l6cGh3V1hP?=
 =?utf-8?B?a2hteVhHVVpaTEhqeTF3OEszdzZvK1U5R3gycjVURWh4dGxDSkEzeUk2VWRk?=
 =?utf-8?B?K2V1R2RCMm5YUy9FQkYxNFp2WXR6SFduZkNUVGh4VjJxaThTRzd2YURtbVE2?=
 =?utf-8?B?aFhlUjRiU1RMRE9aQndzZzlmcEVyYUpoREpOYlc0SlJMbVhtZXVDYXdWRS9K?=
 =?utf-8?B?YzFLTThSVWdhR2E4V1ZiRnpmUVFkQVpXRnRWMHc0YUxSVUUyUUkvN0x0M01I?=
 =?utf-8?B?UUY2VkszbHRnYkdPRnoyV1lvb09PdXAzK1dQaXBnKzZKc0VqK2g4eVlBNzk0?=
 =?utf-8?B?QUVtZGt5Qk9VTUtvQlRrVS85b3liR3QzUUo1NCtFSWkweWUyRm9xOUw5NGJY?=
 =?utf-8?B?aDkvS3hQTXFBUDBoREt2dE80OHBCQksyeC9wNjl6bmE3Mm9RbzVqbUZLa3lp?=
 =?utf-8?B?V1pzTWpkR2k1S1NYQzZuU0VnVk92b0x3bnI2K0RpcW81UFg1KzYzOUtKaXB3?=
 =?utf-8?B?MG9GK292MXAxNW10WTd1Z2d5Z2NhRUU1VkdTSUlFTGZXMWM1ZkE1MUxnVngv?=
 =?utf-8?B?NjR1MzB3ai92aUNteVh3ZTErZ1huRWVOT3NDM0ZKMHNjeGlrRWdwUTZNSGh3?=
 =?utf-8?B?SnJOSjh6OUJmdGdrdGRJQkUrTWtDZ1hzL3BsOEo0U2hqSWszaDIya1Q0dXJi?=
 =?utf-8?B?Wk42cUsxYys5bXp3c2xNOExoZUZZYk53eDQ5dDhkcVEvNXVubkdwb1RDRzJr?=
 =?utf-8?B?U2M3d2pUWTQwODBORmJ1UWFRZzhjd2hkbDZpNVhPYmFLdVZPWVA4MGx5TEpR?=
 =?utf-8?B?eUdCZHA4V3NtWGpORFFBcjg3NHc3TVVmNE5ScElVSkRDUForTXJXbDVqd0s0?=
 =?utf-8?B?aGkrbE1YWDE3UFNiZ2xwVnFick9KcUV1MVhmZ1BueGhCbTdOWjRkUmtPWkVq?=
 =?utf-8?B?S0JqdVcvZGFBQ0p5SmJrWHBmMjRsczFMajJIZzJreUYrYkxFeldvVWxkZFRP?=
 =?utf-8?B?aUN0SVFjR21jT3NSYmhQeWN6WnpIVXQ1ZUt1dGQ2OUJKaFFITWdnb2tYdkxU?=
 =?utf-8?B?RTVCQnVLQ0RZMG9MRTNoSTRlRUpud0E5bFBqdEVEL25sVFlaM2VGdTlLQkFQ?=
 =?utf-8?B?aTNwTHdQVmozNkRxWHNiY0VXc3h5bWdCRERiZzRQeUVTR2kvOGFXNzFxY2dV?=
 =?utf-8?B?L01LZDRtS0x5c2VmQ1ZvUXJObEw1RjJzSU5sMWxpcmpuMWY4QktkS0ExTnpo?=
 =?utf-8?B?ZVI0NzFPQ0lTb0hBRHdoQm9JbmJuZk1taXdRdS8rY0s3Zlk1RWlCN0xpazZi?=
 =?utf-8?B?RG5EUWxFbllxZTRJT3hmU250K0pKZmQyVkNxRjRmdGpvUC9Kelg2K1YrL1ZR?=
 =?utf-8?B?UU5IQzJjSysrMDB0SEdKTHJUUkFRRGs3YTZ4STR1UDJPT0F6d0FScm95ZnJ5?=
 =?utf-8?B?bDRXOStOK2lhRTdWR1pGVjd0TUdFWWIrNEd4VE11R082aUVMSlRjUjFaN2Ry?=
 =?utf-8?B?WGpubzZzMzhTeEh2NFBIa1JDaUtxcDVJUWZELzFzbFJQbi9kSlA4NWVldXQv?=
 =?utf-8?B?OEtGYjVPZmNTMzhmSm9UamlpYzNEeHNpYnJRWDNYZVBtQ2ROMUlIMDl1WnRG?=
 =?utf-8?B?Qkw0eXBpWnJkZXg3bDNOMjJhbVNwUldwOGpHMjUxZWo2WlVSSnV0MnVSR3lR?=
 =?utf-8?B?ZVdiWXZGcm5ybm8yZk01cjVEV0F2TWprTzJuNitHek4wNGM0ZmxMamt0S0Z1?=
 =?utf-8?B?UXVlK0hZa1ZpTGZ1OWQ3dUpzZHVQSjN2TmlBMDJvbktyc25rUUZIYXcyMnVU?=
 =?utf-8?B?dVdpS2NEbVZucHF1WnU2dFdDYlNRV3plMHliZWwwc0pGV2l2aVV4M3pIUDRp?=
 =?utf-8?B?djJPMlNyYWd2TnMwS0VkSmo3aE5GNHJVWEV4Yzcwd3VZcWpqSjNhNVQ3bW9a?=
 =?utf-8?B?RHRtMjl5RGpKUjJWeFE4M3JKQVNKTE55dDJ4UkFVSU5hYUpXZmlsQjBzM2lM?=
 =?utf-8?B?c3hnR1J5ZjNXWUpsWHlvcTAwYzQzTjBZZksvWlR1bVFmQUU1SGNDeUs2M2Fl?=
 =?utf-8?B?WGpLb2NzZ29qVVVONEl3WnF3RDRoY3hZY0JVbG9pYmV2QjF3LzQwVmFwTmZZ?=
 =?utf-8?B?aEZoZ1VDa0tNdTFSVVJUN0xTRmdjR0gzV2R3NzhMUTQ0amIxQW9vdkJiTVZV?=
 =?utf-8?B?dkl5UHNrMlJDeFRwVnRyamNYZmxEOXJWTTV2aUJyNXpXSVBIOFljRkFuOVZa?=
 =?utf-8?B?c3phSmJZUWtHYTRscWJNbnBJN2J4eFN2NDdTaFFDNnpSRW9ubTQzOElITDhH?=
 =?utf-8?B?Y1lwM2JsMkJJeXBpcUUyQXZMcmJlTGxrQlFaK2ExL2w0TmhFTmVYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1ea837-93ed-4d89-d609-08deb1b5266c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:34:32.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pqO+5NZtGEj/evGdgNKZu5u1P5qaNvz0Bbea0MPuWcNyqyEyexgxSgmyAjeMAdqPOyii2LvlOf0rSuPwAAd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
X-Rspamd-Queue-Id: D929F541B1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20695-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,resnulli.us:email,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action



On 13/05/2026 14:11, Jiri Pirko wrote:
> Wed, May 13, 2026 at 07:53:05AM CEST, mbloch@nvidia.com wrote:
>>
>>
>> On 12/05/2026 21:35, Jiri Pirko wrote:
>>> Tue, May 12, 2026 at 05:25:21PM CEST, parav@nvidia.com wrote:
>>>>
>>>>
>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>> Sent: 12 May 2026 07:37 PM
>>>>>
>>>>> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>>>>>>
>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>> Sent: 12 May 2026 02:16 PM
>>>>>>>
>>>>>>> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>>>>>>>>
>>>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>> Sent: 10 May 2026 06:02 PM
>>>>>>>>>
>>>>>>>>
>>>>>>>> [..]
>>>>>>>>
>>>>>>>>>> I look at it from the perspective that from some CX generation,
>>>>>>>>>> switchdev mode should be default. So that is a device-based decision.
>>>>>>>>>> I believe as such it can optionally be permanenty configured (nv config)
>>>>>>>>>> on older device. Why not?
>>>>>>>>>
>>>>>>>> Because sometimes switchdev_inactive is needed and sometimes not.
>>>>>>>> Such knob is not device decision.
>>>>>>>
>>>>>>> That is what I would call corner case. In that, user can use userspace
>>>>>>> configuration to change the mode in runtime.
>>>>>>>
>>>>>> Corner vs common depends on users one talks to. :)
>>>>>> If fw has switchdev(active) as default, and then
>>>>>> And user needs to run switchdev_inactive, it will actually break their switching applications.
>>>>>
>>>>> Can you describe the actutal breakage please?
>>>>>
>>>> Driver default was switchdev so all the traffic is forwarded to the switch,
>>>> and user didn't have chance to setup the fdb rules.
>>>> So packets are dropped but user didn't expect the traffic to be forwarded.
>>>
>>> User may switch mode to switchdev_inactive early on, before any of the
>>> representors are created. What's the issue then?
>>
>> That is the ordering problem I am trying to solve.
>>
>> On a DPU, the host PF cannot finish loading until the ECPF moves the eswitch to
>> switchdev/switchdev_inactive. So we need to do that transition during ECPF
>> driver init, as early as possible. Waiting for userspace means the host PF stays
>> blocked until userspace is up and has the right logic.
>>
>> That is not always true in practice, the driver may be built in, loaded from an
>> initramfs, or the initramfs may simply not contain the devlink policy we need.
>>
>> Also, after talking with Parav, my understanding is that we need to support both
>> switchdev and switchdev_inactive, since different customers want different boot
>> behavior. Once we do the transition, the host PF can load and may start sending
>> packets. At that point the initial mode already matters: in switchdev_inactive
>> packets are dropped until userspace programs the pipeline; in switchdev they may
>> reach the FDB before the pipeline is ready.
>>
>> So I do not think an early userspace transition is equivalent here. The initial
>> mode needs to be known by the kernel before userspace runs, which is why I am
>> proposing the devlink= command line default.
> 
> Okay fair enough. Could you please at least make sure this is mode only
> config and noone would ever think about abusing this for any other
> configuration? Perhaps call it "devlink_eswitch_mode=" to remove
> the "devlink=" namespace flexibility?

Sure, something along these lines:
devlink_eswitch_mode=[*]:switchdev
devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:switchdev_inactive

The proper (not RFC) series will have 3 patches:

- devlink: add the command-line default eswitch mode handling
- mlx5: cleanup/prep patch
- mlx5: use the devlink API to apply the early eswitch mode

Since the mlx5 changes are part of the series, I suspect this will need to
go through Tariq. The patches are ready, but are currently in
our submission queue.

Mark


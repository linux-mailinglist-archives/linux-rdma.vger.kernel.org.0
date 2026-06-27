Return-Path: <linux-rdma+bounces-22507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THMrEW2AP2rGTwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 09:49:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EF6D16B3
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 09:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Aukdy4cF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22507-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22507-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55184302C6D7
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029242773CA;
	Sat, 27 Jun 2026 07:48:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A91E555;
	Sat, 27 Jun 2026 07:48:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782546532; cv=fail; b=giENZ5J6dIU1F6zKnQwLWGjbZNiwIBkGQK5r+hutDT0jXG29IjJgxHAYXr5NmDAQZ0aThElot7kHos7XMPK7DZyN/SSP3XRYdfNsHK5Uv6eNIOMqTmqXbLXYY5a65xSDZ4kbh1TYLn0ASfcb+z9b8uYtaxwa7UIgCpQzIH36oKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782546532; c=relaxed/simple;
	bh=MlKldxnfk6fdOj9oXzt/gjayTGmwrw6wPbudAqt+9Lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BsJAXjjz/fp2BdoLu5WnRKdS/htp1K9vjfegp5+pBFyhLjoJTmKQexsYLIjzKCY7eJL2g1Y+Khf7frXJ9nt55vSDXSL0OIfifHkUEOhxjR/Dsuj22qln5/Nv9WogJfLkkeqxQxk9UGvqBQz0GxuBFgdTHolog+e2/mMMWkMgvfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aukdy4cF; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTHgLE181YRuzC6x6v7WE73d1kEnX6K4Jft/ElPyVTdlroJeWdpbtMMSs76p4Lvk28DraWtEgy1oLtQHHyqndnG6ndd70WBhIaceI9pbDkCzcjnLpPl3WZNCtPYJZEOXAhuqb6C9rNmug28vCnf4D/FEhGkeYZCQKoVDjYnN8PpQNElbvKD6qlj3YPNIig2/bpvMcmC0pUs9SJiVnjO9XsuXOf40FxTCPfbf1WRGfPpZ6klUI4mHBovWCJ5NA+Jb1Uz53+D25Zl68KRIhehD0KX85Y1Xvuqn8p2WO9Pvb0jaMfyfUsXDkkHEXRzDA39T7wICrbx98E4DqIcZ8UhGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMysTsTvUdKvEjtppI5qVt/r2CO5NlVfb6CQYAcZNBM=;
 b=PQcCzIl8RCcWnwerYAKLWaDlbmKlB4CmXyQ+HyKg0PymfPXcnyZsFsZKFD5yloq8gLGYFxshdM9nrZ+bQPy1BE1Bvgfm3RKXT9OgGkGaZzQKNRbMm6W6nss9qbls5853A639bZi6MQm5aQBHKqtTu9xy3uZ4ThqwKP6yF8UHiKFO7H1HRY+dXousX53yO0g0fViWElME+gdYq5VU7SjqjmOFKBhmy9zsJMor9kuogbHHEW/2xEotQ43TM2fL3g4sCVR7vVdgivxy81K3/GNKgQz3MG82BscJaXa5xZRRekNuFH+cl9JkDvgWoSoFkORzZzWm846ycym//R84QDtzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMysTsTvUdKvEjtppI5qVt/r2CO5NlVfb6CQYAcZNBM=;
 b=Aukdy4cFJ3K6D6k26VF6il6STqM8dpYXDCh0cM4rbgBPd25I+Bb36raFvAnDSMNUcWZXASsg5zKYAUpwG/PLH0/U+YD+QKx51cqCrfQe4h9GRIGWmbUUI4z0FD/TG51NCc5ejK7+/HF2ECGkTiioyqxb3ZbyLhg7EcTWz24xZ9yJ2uYTHRqVfqhSme6KSUi39JDLss1c8TpyHEL93ovcC100xdwDBQF+d1CxpwT7AGtuvBNt9znfhVJq0YwKb13Fzh1/W4e9IrvhzS4yTou0W3e1sQmpXFG3mixx1SHXrdO6vUV9UlmRC4vIW5yRtjW993YvogLQiY54Bq2BAC4RTw==
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 07:48:48 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 07:48:48 +0000
Message-ID: <6d6243a1-41d8-495a-97cf-d67022a1f4c9@nvidia.com>
Date: Sat, 27 Jun 2026 09:48:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning
 on frag page release
To: "Nabil S. Alramli" <dev@nalramli.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com
Cc: nalramli@fastly.com, leon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260625174059.2879717-1-dev@nalramli.com>
 <20260625174059.2879717-2-dev@nalramli.com>
 <9f150145-d95c-4a90-a358-5b33ab78a8ef@nvidia.com>
 <aa190e99-2ebf-4d59-a6c9-755ca181e16d@nalramli.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <aa190e99-2ebf-4d59-a6c9-755ca181e16d@nalramli.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 534103e4-1347-4531-b0a0-08ded420859d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	f5Gk9UUpYSUxw2Mh6RjlRvWeqMEmrk+05ygZHOyWSCFZZnZkkwYgcSDyK2PgZjxKu9phuQdHwsxHQksuK8RkaReWFetJGB0jMA9Y4vFNFIjmoWbRa8IKBHDZ335qhNevfY67v0iOtVXx1RbxFYkGfPJOedHtNYqPpiA09S2gJzQkjnZ7FBnNPRezyd/72uHG3EcH9YPtVYfiQE5CNgMSg5VEF0pK5f3OR3Y7eV5aPAXbdAkz7oMOM5pPeEKYE99pNdIAAbsxt8rCurPJ6TtLuh44cGhGgKu2g19pLWlhhJZudpIBC5UlGaQykm4x52LI9aj95n/ONervaJKwB1eooh4gWsxWtc/OFA1MHtvm7fawM+b190wU0ohGkoMXIvtLdz/ftbFESc0XkRkCdM5w9pSFYtXspzpn6vVx29TUpDA0NhVXqifd7p7s97vTWCuFJEOVK3IUp+YY8gu8Lng9f0I3HZcS9/8Fk+DeaQI9DtD6bA4xclQ4HDAYSwfPpEg8+L76LFzReObwD6YFxF+RadyrWrfy/8Th8onuIMRyk0x4kHRPWLUubuMQQBuM/62a4os0RsgjWqK1rv3GaaTrqjWi6jkVkzFbbrlH5KzGLRKc7du+kQALsC+vDqiMdeW4S6D/wzD5A5UeTHEDmBBNPV+Yma/vObbL+8CJ9s9jC28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2EzYmtwYmVJTnF4ek5Ub2VpcHBFYWxZQXJ1ZlBrM3BWaUIzQmJVYWFUclZD?=
 =?utf-8?B?S21iMEhKaUJ2ZDRGamg0ZTFkMjR5K091WEN5SEp0ZlFlUENFVlZZYnJ0Rkh0?=
 =?utf-8?B?K3ZnTTlTYTcrSGdzRkhnQmVlaWpTSDE3clFYcHgzdkk3dVZQUzBaYXJTZ2Qx?=
 =?utf-8?B?WTFWMjBSUERLTWZGZnkxdjlHOGhKZGRIbUo0ZHB2cTViY2R3Zm1nWjhXclZW?=
 =?utf-8?B?R09IQ3ZEUDRSejh0NFlEMkVFTC9DZDdsUk5vMmNiVnFoT2ZBSlVST2tFU2tz?=
 =?utf-8?B?OU9Ib0lFWGMxanNOTHZTNzh2bFpqY0lWVHg1UXUwTWgwdDlXeHNtMUsvckxQ?=
 =?utf-8?B?RC85Sjh0UVRXZ3NLSHlQRytnWG9TdVVTbS94cmJWTHRISll1em1wcm5tMDI1?=
 =?utf-8?B?OGt2OGpoazJhUmw0WUx4RENweWJRSmVnaFNnbWJYcXhldGg5SFU0aEdDMnBI?=
 =?utf-8?B?T08zQlZTRWtLYXlYUWpSbVJUY3gweHJqTzNUN3F3aWpWakNWeEZMeThNbEtQ?=
 =?utf-8?B?aHpaTk1kOHczTDZiMzFpZ0htTjcvdUlSZlhQZjNhWFpUa09ScEc0aHNrd1hk?=
 =?utf-8?B?aW9PVWNoQmpPc3NNcFFvbWxnay9TcUtxRUE3OUZJWkFPakNFYVNxRGFqT241?=
 =?utf-8?B?dWdpSktrYVpiWnZaZXU1SnEvSnZGNzZNZnpaeTIvVVM1VCsrTW5RUHJFRGdN?=
 =?utf-8?B?bVpLV0puL3ZQSVF2Z1RYRjJKUldpZ25RZHBzL3JLVU94QnZYQndieXY2aEhr?=
 =?utf-8?B?WjFZSGpaU2hHNDJVcTRNK3pwV0tnNnBabnBON2swRjluRlpsaUt0eitMT2Vi?=
 =?utf-8?B?ajNybkk5Mml6OEFhVkQ0ZW16SnpyNVRLZ2laaVdwaDN0cnZKRVVMczRQZ3RC?=
 =?utf-8?B?a1dwL1hsUk1PQUEvTFZPakc3eXFFU3c1cWN3RWZCSTVwNFk1UDRrMFg5V0xu?=
 =?utf-8?B?UWR0bXJpMG10M1hQZGg4Y2dReXZrbnhkaG53NXEwbVZMK3hGdEt1VDFrYlQ1?=
 =?utf-8?B?OCt1M0NpWDVLT21xeXRRSm1Ec3JqTk0rL3ZuWDBYejVJOERZaXNwZTZscEgr?=
 =?utf-8?B?V2tPUVZaMWhzL3RuNi9tR3cydGwrZ0JORFZaWVBwR2w1djBJK093Q2FEdm5m?=
 =?utf-8?B?OGhpMDc4MkJyM1BMSm51d2hYekk4M3JuZTVPMDhZTmhuTWJ4OFZGb3ZLUXJo?=
 =?utf-8?B?cXNucXhkZ1FuVldQd0dydXVseVBCRkxxUGJmK1liSlZZZCtvdzliRTEwMFRn?=
 =?utf-8?B?MzB6ZkFlTEZmRFlBUUVuV0NOZnFOY0JZTUhWMUxOMURiNjMrNWczRHBZOFEv?=
 =?utf-8?B?dm5pcTRLd3N1WnFzWjR0YkpMZDBrNmNuNkNHVkRVVjF3TVZFRjlnbStjWWEx?=
 =?utf-8?B?Qjk2aVRtakZpcEJyVUFvN0FnWVpsV0l0N2c2RnJ6MEUreTYrd3lCWHhnM2VQ?=
 =?utf-8?B?VXlJenhwTVMrNXErOUJvTlRsbEZsaTlJZnNLMkpvOERzbUYrZWl1bW5hQlU4?=
 =?utf-8?B?NFdXd3M0eURISEJjc3hONTE4TXg2U0ZKOVN3MWNPUEErYXM4S2V2SUlFTFBC?=
 =?utf-8?B?Nmord1Z1aWE4RXJNZEdtRW54ZWh4TkJyOW41NTVhNzVxblQ2bElXdHFua1Aw?=
 =?utf-8?B?NGkyT0FaZEszcU5Ib2hTd0NEdWxjS3RmWlpjb3VTVm9wK0p1T3BRNnNkamta?=
 =?utf-8?B?TngzdWZuZlpuMUJpUlVSYWJ2TEtobXRzOXpmcUVJN3hJMVBYai9TZU5TeUwr?=
 =?utf-8?B?aDcrWlpRNGJwcTA1R3IrYVhHVWVLbVhkVXFaTVlTd2ExaGtVRkhTU1NwWjdY?=
 =?utf-8?B?Tk5lR0xOQ3o1R2NJazZaN2lYUGJ0WisxNmZYMHlUdjVGOWVSNkl0TEZOd2Q4?=
 =?utf-8?B?VjlhMjFvUjVxcndhRjFRMW8wR21ha3lzRzF4ZFF6dnJ4dTBhbTlPVDJOT3E4?=
 =?utf-8?B?NUtZVmJmRHdCbUlzMW54RzVYM2hwMVBCaFRVaHRQemxqQ3VWMmthYm5QUnB4?=
 =?utf-8?B?Z0x0b1dQd0pMQ09KVGt1SWhQL1RoaEp2MEJWSlJoeHhIWGpuZ3lsL1Qwa292?=
 =?utf-8?B?aVpUV3pyNi9hZzlFL2tNU0phamJEY0NLZUlwNzk5d3JxcHNHQVhLeDlSSElj?=
 =?utf-8?B?Q2R0a1o4QmlvWDUxSFF4aGlvSUwwZEc4cVkwb1NqQWVRc3Vpb1p1UzAvcmM3?=
 =?utf-8?B?YkNDV0draURhNTUwN3V5bmNrd0RwT3JIMjdQV2RCdU5rc0d6QmhrS2Z6N051?=
 =?utf-8?B?cUlMZkFibGUyTjlncExYekRqKzdSQkFKYjlJWGFqelh3S051N2lCY1ZldWpp?=
 =?utf-8?B?ZDhYVWRYeVJTaGxvQmdnUTNhbTVpL3IySnJqWlRhWnorUi9KZmV0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534103e4-1347-4531-b0a0-08ded420859d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 07:48:48.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWjzc4w/ofnKJ9wE+L3y+4dbPKPr9Ov37GZFvZ6RjlBisV89kcuwDm8SPf2BWR9M1lMD8jzGdjDDsYTNQgJ+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22507-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dev@nalramli.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:nalramli@fastly.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C9EF6D16B3



On 26.06.26 20:02, Nabil S. Alramli wrote:
> On 6/26/26 09:12, Dragos Tatulea wrote:
>>
>>
>> [...]
>>> ```
>>> 	ret = atomic_long_sub_return(nr, pp_ref_count);
>>> 	WARN_ON(ret < 0);
>>> ```
>>>
>>> The actual stack trace looks like this:
>>>
>>> ```
>>> WARNING: CPU: 37 PID: 447795 at include/net/page_pool/helpers.h:277 mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
>>> Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
>>> Hardware name: *
>>> RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
>>> RSP: 0018:ffffc90019814d98 EFLAGS: 00010293
>>> RAX: 000000000000003f RBX: ffff88c0993d0a10 RCX: ffffea02424592c0
>>> RDX: 0000000000000001 RSI: ffffea02424592c0 RDI: ffff88c090e20000
>>> RBP: 000000000000000a R08: 0000000000001409 R09: 0000000000000006
>>> R10: 0000000000000000 R11: ffff88c095fbc040 R12: 000000000000141f
>>> R13: 0000000000000009 R14: ffff88c090e20000 R15: 0000000000000001
>>> FS:  00007f34149fa6c0(0000) GS:ffff89200fa40000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007ed0265eb000 CR3: 0000005091cbe000 CR4: 0000000000350ef0
>>> Call Trace:
>>>  <IRQ>
>>>  mlx5e_free_rx_wqes+0x7b/0xa0 [mlx5_core]
>>>  mlx5e_post_rx_wqes+0x1ac/0x5a0 [mlx5_core]
>>>  mlx5e_napi_poll+0x5e5/0x6f0 [mlx5_core]
>>>  __napi_poll+0x2b/0x1a0
>>>  net_rx_action+0x30e/0x370
>>>  ? sched_clock+0x9/0x10
>>>  ? sched_clock_cpu+0xf/0x170
>>>  handle_softirqs+0xe2/0x2a0
>>>  common_interrupt+0x85/0xa0
>>>  </IRQ>
>>>  <TASK>
>>>  asm_common_interrupt+0x26/0x40
>>> RIP: 0010:page_counter_uncharge+0x34/0x90
>>> RSP: 0018:ffffc900e728bb00 EFLAGS: 00000213
>>> RAX: ffff88aff4762000 RBX: ffff88aff4762100 RCX: 0000000000000304
>>> RDX: 0000000000000001 RSI: 00000000004e9e1a RDI: ffff88aff4762100
>>> RBP: 0000000000000001 R08: ffff891ea0560048 R09: 00007ffffffff000
>>> R10: 0000000000001000 R11: ffff891ae8061b00 R12: ffffffffffffffff
>>> R13: ffff89107fcfd4c0 R14: ffff891ae8061b00 R15: ffff892002fe1400
>>>  uncharge_batch+0x40/0xd0
>>> ```
>>>
>> Can you provide more data on how you reproduced this? This helps to
>> narrow down the bug. Reproduction steps would be ideal.
>>
> 
> I don't have clear steps to reproduce it, we just have seen it randomly on
> some servers that were under memory pressure. I will try to look into it more
> and find a way to reliably reproduce it. I agree that would be ideal to find a
> proper fix.
> 
What NIC is this?
What MTU is being used?
Is strided rq enabled (ethtool --show-priv-flags).
Is XDP/AF_XDP used? If yes, can you provide more details?
Is HW-GRO on?

Based on those answers we can review the code path and see if there
is a case where the accounting for the fragments is not done correctly

Also, is buf_alloc_err growing during these memory pressure?

>>> The fix is to use an atomic page fragment counter, so it will always match
>>> the number of references held in the page_pool.
>>>
>> This is not the right fix. The mlx5 page frag counter is not atomic
>> on purpose because all changes to it happen only within the NAPI
>> context.
>>
> 
> That was a question that I had, is it ever possible for frag_page->frags to be
> incremented / set outside of NAPI context? I tried to answer that by looking
> at code and by tracing it but could not get a clear picture. If it's not
> possible then I agree, this is not the right fix.
> 
If that happens it is probably a bug.

Thanks,
Dragos


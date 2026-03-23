Return-Path: <linux-rdma+bounces-18542-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMU2Hha1wWnlUgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18542-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 22:48:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C82FDECB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8EE302E926
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A51304BDC;
	Mon, 23 Mar 2026 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="BO14HUyS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020106.outbound.protection.outlook.com [52.101.193.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13337F007;
	Mon, 23 Mar 2026 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302470; cv=fail; b=BkfTBvYmH9R1TJG1w3jrnXctagywtYrCg5YhWvj+bjhfM4ZqxEclfps4mdNjjBu/Awy2ezX9GsyHpG/dP9XLIcRfHAKQ1/A1aDr11GW3fzPf9PKoiA2UwKlOQOMrj58nDRcgrgwOwUL+q/wqT47Ah/yqflUPv0a6G2VGa012hg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302470; c=relaxed/simple;
	bh=9VGMK3E2uSZ/rAgz7xsHyvYN8VBx4qskd944WZUwmI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NRsIRsEILPVHnycnzcZUNHsr3EStSrhfwl49JaVlxv1phMCP1rMl0oChpLgwg85XhJk80ltl80PRF6ymwPLoZWwOY0B0WZxz1ENZZcd1iJHVZ6Qqk9eZfn5r+uUsJK/dJ7g+gVs1xT8vh+OW7Iggs3iqMHOI/YNlN9xqf/LPbGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=BO14HUyS; arc=fail smtp.client-ip=52.101.193.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOIE9mrzx1sQ/66/9YfpD+yiyc3KA6qKcei2vtjPirScBF60U1gYDaBTExPrq0Lx5aQvoH+zZvLagZVHx77oA8kaAaJRkzjkDKn2S1F8TR0Ju8sNpQ4+kFkjMaaWYYoDaIfe2RpFwlW8eiighrQL4CsJXd8KxpMt47QdhnNQke5YQeD4x02Kq4AXISdtKA5VBWy1RbYCspF+3L6AnOwXVq0VLDxJn+PFKShhtXRgtRVgt5Wj7esONJ+ZkWtld++TUMOdQlyo4evYMKIxdOixpVw7ul0NwMjClzajM9MoxAZVKuSaowzKY4n5boOHX7xT0xNoBy+EchXgXe3Mb4WrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wJE+Nlhowl0Em8pJLURaNlNqslB/HgyHW0/eYd3MZs=;
 b=xhqKEqEuK8P9vXnJoPK9EalANyMfeKrUyIPivD1haXrQmQFO/uC6VWqDZUnM4Yagd5q71hKbS4s69yF3MBI3Kk5xfKhAyHzMnaYhrkifWGQ8DicbpQOjDwd4Lakcuz8Ua3uFATAxfBp3GsJO+8AqIN7CmJZTb2Y5Tx71qwZjCr6LnSWVmm+9QOwh5/41nLJQ559582Bs3+A80Wm0jVjIB6SiUmjMYjBpaQ2nwW1JibEWPj88Mn2A5VKv2lPy/xLiN3pFTVhMrDUNX7hNsbE9E9IHhBv0yVhh25WmLoojORGMVvXZy1tZUXykrwUJ0BoRZuZFYfHfnYN5jr0iUUtqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wJE+Nlhowl0Em8pJLURaNlNqslB/HgyHW0/eYd3MZs=;
 b=BO14HUyS/EZ9yT5lFKsQdhK/ejvvYSY4ZZHrahaJI6ArNiFz9/5fd+hnupFKaPzOah18jh5Qe5hClbEhz9Fz9wWiVZC0Mp/dIFGy0ecG40jSSoSDcFGhHVxDAtg6e4zqc8n7rZc6Ig0Yjhohf3aOlokGoD7fuH2vl8GiJUX7MB+lW0/5wNFROIWc67Qm2xbCX365YYQjIB3OftuOjayOUuONP0ZGb2ivXevEfWM3C1PVKTFYhM2gAhx7+tvRff6OwjyjpK2ndmf0zdK1le9vPooRHkjrjwAlUxKRZdF+Urm6Mp+9DdTb4JPI0+S6IgJ2rbOG+P3V83poR1aadssLgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 SA0PR01MB6268.prod.exchangelabs.com (2603:10b6:806:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 21:47:36 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 21:47:31 +0000
Message-ID: <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
Date: Mon, 23 Mar 2026 17:47:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
To: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nathan Chancellor <nathan@kernel.org>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 Doug Ledford <dledford@redhat.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Ingo Molnar
 <mingo@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
 <20260323110144.GG814676@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260323110144.GG814676@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::22) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|SA0PR01MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 1306f491-3f82-425c-8027-08de8925c8ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UAtxKYdAxaPoZEqA6TIbShL9UWAPDU29W6kJVQAl7N4RG/Nqw1OXVjIWxAReREeVXzaOTT314WU8t8Ekb9gME8PypbzSL5d/kxEtiSQxDbMAPKJKEg/TjSy/OYaqF/+CRdVQXBPSxX9h+sy189G4an2zvtukOQW6qTkcFKqnxeoeCbTXhb1LvnpDeVtdwgyXUeYQwXPpr7yorAPjHTXYK+cQCfPuBRngvT4/L1/G5H8UDNPkxyBwHem5bEbXpAU1pZSV26xKt1KAyu2KFpnchuHcZmK1rNaWb7yTbcy4uWQBGvhN+/wsaKrzb/fFKzZNBiKYqM2yK8Laa6fGeaUaLQ9U1uvdgP6HAuGhcJlnXEnq5PxM5B4ZglZftdwFcv84oIiLH7aJVMDYlqBuHAjU0Lquqoap54WIhhVoH5r6DpSsRpGYq9EdQNau3URNLwPZihU4cYpL+fReT6OD5hEKU4AYrVsOYU6jw8h+oOH1e5CN3QWt5ML9PaOyNhj8ihsNXdJwv2tAhFmVWdy7w2MqnRX02d6RgGw2Bx7CV64Pd+y1F3R5oRbdcVdI5/AqcAgyH+vdRZ8Wpj8Aj6mhoT7DOJ6wmEZ/alSuAsvoiXpcloFWNKoQFb2P/flvzlO3htbd6lYqdxoYEuvNLHgTXnWjkDxyMNH3lmQovCsjco+L2QaaEt+GlWL3ntbhnZdEuXvFoCZQg6SVzcpumMrMJ/s0o3bcsLFUi4Qr4LgRN4orrrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmU0ak9TZkg3K1J4NEkyUEZEczNnOUlaN3FFYXV6NkxnWldxZWQwdXZlSE9G?=
 =?utf-8?B?aTJCMUdGZzVkQk9ueEF5RkNQcWJJRUREalk3TGFOL1hGRVppNFRFMkt6VzNN?=
 =?utf-8?B?UHliNDN4bWtSZHYrUGU1aFEybGw0Q0dpWjJQZzM5cU9YTzRZTzZNYmgwQ3Vk?=
 =?utf-8?B?TnRFaU0vellGQ1JxUVA4cldQdHIrTG8zT1gxbHkvRE1LZ1VOMDZkVG5qZUhn?=
 =?utf-8?B?YUJ5RnIzN0wvOC9jM2tHaldqMmRLbDFJeHYvTFk1SmZTdlkyNERkRFNLZS9L?=
 =?utf-8?B?OUd0RjltdmhWb1M5MzN4ZWRndGlSWTgrL3hVMnVTVGV3aTRPQWNOQ0JFSlpw?=
 =?utf-8?B?YkhvckdxMVRieXcwSkZEQXhVN0FKYlJRQWtlZDB2QVZQYU9xYXJ6OGV4R083?=
 =?utf-8?B?ZVNWYWZSZ21nUjc3NEx0TndlejlHN3k0UmIvenAyY1RQbzhYSE1IUFhKY3hX?=
 =?utf-8?B?Unh6cG0vOFEvUm5pZnVENERLTVNsLzg0b3Z0Z1RDUEc3MlRmWlhWUzZHdkhV?=
 =?utf-8?B?ZHYwL2NvSkN1b2pSV1BOT1MvdjZtaEpSYnZqUFpoNHhSNXZDYXkrZC8zMEFy?=
 =?utf-8?B?eGJpU0M0cDFoZi8zdEVidjNRVkpqaUU5YVN1ajduaEZjQTJRSzVGRWEyYzFk?=
 =?utf-8?B?TExQU25LcWtpeFNGeVJqcUh5NFJ0T0J6c2ZFenRRaVR5eitPZHhFWDRpKy9w?=
 =?utf-8?B?czJ0VnlCaFAxTUpNUFlGZzVxVDJxRVVZV0xNemF0L1gzSTdhZHp6SGZIUE5G?=
 =?utf-8?B?WTlWdFVmUzJTd0g2STZ1N0NmMVVmQVRzZzNiNXJJMjZCZklkdWM5TmtTY0tS?=
 =?utf-8?B?UFVQUnU2WmFJQWxNa3Fkd2ZHOEpkRVg4MUorcWNLRzJOcXVzdjdMUjcxQ3Bj?=
 =?utf-8?B?K1ZKQkp4K1c4eDRNeEpuU0tZOHpLQ0dnVDBIb3ZIQWp4dVZuZjd4T0V0bnpN?=
 =?utf-8?B?ZmhKT292bmQ1Vm1WeUd5UVNKb3RkZGgrdTB0RHZPY0NMNHZWSXNZaThjWmdC?=
 =?utf-8?B?NUNXZ2NwLzAxSDIyRXNKbTNzTXJyYkNnNXR2ZVpvMkR2Y0g3S0E5R2ZTcS9L?=
 =?utf-8?B?ck5tWmdwZ3lubUJUSlpPTnJPc0YxSTlFWEd2WFNzbldEV3huazhSakZDVVpS?=
 =?utf-8?B?dndEcGZBektjSWpPaHdWODJNTmIrRGVKQWpBektVcXNjS2ZxYmRQeFV1Ylgy?=
 =?utf-8?B?K2JTbzdnRk9QRWdpR3ZQOFAzZmRTNDQ4MCtLMUdkeCthVWtnS3hLN1l0eHhM?=
 =?utf-8?B?VU4xa1kwM3Z5d1haU3diWklGZmNES0w5OSs5bmZDQXZodE8zQVl6NnB3Vmow?=
 =?utf-8?B?WWVRa2JaU2N0dEl2S2xueFZiVWJ3bmdZQ29UR0xPK3ZLZnhtODc3b3RnZThO?=
 =?utf-8?B?bGNpZ3ZwN3dGTEpURmE2dW91M3VmME1mZHZ6NFF5TFQrV1loLzk1RjVVb0tn?=
 =?utf-8?B?NHlTSkxvNDg5Wmk2T3B3enlHaUwxMWJxRHM5dytOdVBGSHo2WiszbStDalQ5?=
 =?utf-8?B?eEU4eS9DUzJENVRoMzZaNzBzZ0ZGVVNibXdvNnZGdGRCRHFudDQ0dnAzNWJR?=
 =?utf-8?B?cCsxRlhMS2xuNy9ZQ0pZbm9tNlVqM3IwZUZiRlJqay94R3ExekxJMk5nS0Q2?=
 =?utf-8?B?R2Z3bW0wYUpremc1NXBpdnR4azZ5Nzd3SE52N1QyQU0yQVZaekpVK0tqVVp0?=
 =?utf-8?B?Y3RmMXR4dnZWemYzMFFBVktZQWtJMjZQVUhaQUJ2K1ZBaTZpdVFvdFJxTGd3?=
 =?utf-8?B?OEQrQVpWeVJTT0c5SUlUTm9DZTVCQ1ZyVEJhMHdiQmhTNlY0a2pSTFhsZXhL?=
 =?utf-8?B?RTQyT0hnYUJCOWJENDNtMkp4Yi9zV3Rua0hESzc3TmY0VkJNb3hEVlRFWTJS?=
 =?utf-8?B?ZG5ialc1NDdTN2g5TGNPZkVIdThZYzNudDFVNHpseHlOdXF3d3piby9pc1Vw?=
 =?utf-8?B?amd3dkVEQnRGdWtsTjdiQUNQZzF0cUs3dE0vYVFiUXhNejRFKy9uYkJGT0xs?=
 =?utf-8?B?UzV3cnVDdW9tbDRJYTY1YjFqV3pCWW9mV0hpV0dHTGt5amQxa3F2ZUdseGpr?=
 =?utf-8?B?eFJ4UHIxNk9EV1Y4RHcvWitqZjFGb3dsN25IcmpydVdtNHJ2endxM0tiV1pR?=
 =?utf-8?B?RGJCbTBJeVFkNWtGcklhVkU5bThXRWUrempjck1vMHB2VG1nTEsvZllZU1gy?=
 =?utf-8?B?YlJYMTV4d1lpQUY1KzdrTGJzeFAyZnFlbzlXSjUxMXFkdSs5VW9vMkVVUm41?=
 =?utf-8?B?aHBML1RvSVRFQ0dCYUFHeW5KbEF0QzRCUXVvV0N1bWFiSGtkQ1JpYW9qRU9l?=
 =?utf-8?B?V3BuaXFtM3FKaXlxNXVnMWtZejdYZnl2dFVlUEI2LzNIaXVFVFZHeDV3UFpr?=
 =?utf-8?Q?NyXQrc4p3bkeqdOV/vV/Eg3qrSuX/mOm9fEyd?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1306f491-3f82-425c-8027-08de8925c8ff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 21:47:31.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McpHKj/97lw1O5Izysxq4TXQvZLHRXY+jf7VybuHWuOC+g3QPamZTJ6UmqLtDgXsSfg3T1EvyYmJOS+FNJYjxchJxuPDjOGPtZETRlALZl35gHvgD0hRdFqwUdSf8+o9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6268
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18542-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:mid]
X-Rspamd-Queue-Id: CD4C82FDECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 7:01 AM, Leon Romanovsky wrote:
> On Mon, Mar 23, 2026 at 09:48:59AM +0100, Arnd Bergmann wrote:
>> On Mon, Mar 23, 2026, at 09:08, Leon Romanovsky wrote:
>>> On Fri, Mar 20, 2026 at 04:53:04PM +0100, Arnd Bergmann wrote:
>>>> On Fri, Mar 20, 2026, at 16:12, Arnd Bergmann wrote:
>>>>
>>>>> +	 */
>>>>> +	ibdev = &dd->verbs_dev.rdi.ibdev;
>>>>> +	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
>>>>> +	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
>>>>> +
>>>>
>>>> I messed this up during a rebase, that should have been
>>>>
>>>>         strscpy(ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
>>>>
>>>> (without the extra &). I'll wait for comments before resending.
>>>
>>> The hfi1 driver is scheduled for removal. Dennis has already posted the
>>> hfi2 driver, which serves as its replacement.
>>
>> Ok, that does sound like a sensible decision, and I'll just drop
>> patches 1 and 3 then, which are just cleanups.
>>
>> The cover letter at [1] suggests that the two drivers will still
>> coexist for a bit though, so I think we'd still want patch 2/3
>> in order to get a clean 'allmodconfig' build when the
>> -Wmissing-format-attribute is enabled by defaultt. I have a couple
>> of patches in flight.
> 
> Sure, builds need to be fixed.
> 
>>
>> I took a quick look at the hfi2 driver, and noticed a few things
>> that that may be worth addressing before it gets merged, mostly
>> stuff copied from hfi1:
>>
>> - A few global functions with questionable namespacing:
>>    user_event_ack, ctxt_reset, iowait_init, register_pinning_interface,
>>    sc_{alloc,free,enable,disable}, pio_copy, acquire_hw_mutex,
>>    load_firmware, cap_mask.
>>    It would make sense to prefix all global identifiers with 'hfi2_',
>>    both out of principle, and to allow building hfi1 and hfi2 into
>>    an allyesconfig kernel without link failures.
>>
>> - The use of INFINIBAND_RDMAVT seems unnecessary: right now
>>    this is only used by hfi1, now shared with hfi2 but later to
>>    be exclusive to the latter. Since it is unlikely to ever
>>    be used by another driver again, this may be a good time
>>    to drop the abstraction again and integrate it all into
>>    hfi2, with the old version getting dropped along with hfi1.
> 
> The best approach is to drop rdmavt as well, since hfi2 is expected to
> align with the other drivers in drivers/infiniband/hw.
> 
> Dennis, is this feasible?

Feasible yes. I'd like to get hfi2 crossed off the list and in the tree 
first though. Then come back and do that. I'd like to do more than just 
plop rdmavt inside hfi2 and call it a day. There is a lot of code 
cleanup/simplification that we can do.

-Denny


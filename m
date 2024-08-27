Return-Path: <linux-rdma+bounces-4589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098F960FA4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109E61C23417
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCFE1C68BE;
	Tue, 27 Aug 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="DhRN034v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2130.outbound.protection.outlook.com [40.107.92.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02FDDC1;
	Tue, 27 Aug 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770822; cv=fail; b=NpXoEnmlIcOt6+r77vZoZQNV+iK0rJRBSeYt8Ufe/lDZafgkOyx4hgV1mMgx6PThWqVOkk36KGplGqeI9imPbsmMTK4fstF0yDF8g93ylbz2mHTeEKKkK7Mf9OFQmGODYo0zUU0c9pcoVFl9uQhwFAekybQPDixRzUou3nLeuDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770822; c=relaxed/simple;
	bh=UuUlion1ApaQtE1/a3frhFdPNvm2jFmPf7mavIZ+DYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAeGlAI4oOIW5zjDmqtmYFThKmI8riCIm4fSqUR9QePZhglPfgsKBoYsJvm82FUfOy5rabifGGqKuw/8TDLJVicDs61xr0gwwyFsVzv+4/KIvU58pcCyCAk1B5R8BaN6yITmyDIsogogVDtBhkSCtwssXobKTNSDksMnmshKGa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=DhRN034v; arc=fail smtp.client-ip=40.107.92.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjIZZuhQ1+sOq7BV/Dj9pt67SzCOEcWQ65c7B0ExKuQp/FS/Qqj22QLPnAbwsv7sZiehQsFrX6jWkICS6Zh0weS1T5tE25U1wBBFjXef3eZPs9z+t8Gr996/EJlM8cUmqMWZrvL6f7RVdUJ4+MUnm6wY6UNqUCJXI7xGRmgv4Y+EUhycfGXr5N0MawYi96gix4Jczuyjv0LrwqMt7pAH+Bw4zCnkOpGLb4r1J+eOXcM+D+Hw1Dpa8CAd+mBuGFKRGxuAfSbjPXQgEci/OtChoCxOc9yxBEWzHBropMtZsFdb1NpHb6EBX/OQdBgojRQZV7xDHP7uUqE5zZeTbcmnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lg9fEI+PUCku+Ich2rFW9842/Ef3clG3pxetYxveOo=;
 b=R3J0b/H72Bbm59MGqhmPHnVsXyISe01p0dOd1cV5kkLMykgUZVrEV5+CmcncIev4tQTq595e7w5B233rKBuCalR9NauNA0gwqNcl5IzAKH7fuCrKkbzK370ie/IHrrUfHYjKC9MGarB7ihQuOgQEM9VKK8q7zosuf0Dw4AdNUvrG8UBJmGt590NHdF/Xi6pPgbd6h/s+ZOrvm/nxz4mXOMH8qG2DavDw0svTKibalw7JJLKeihtFfGF+Rge+Dzvvf7dupcrq3UDWVIc3swblf8sYI7ih2XYk/tlJVCiFw/3wkxYANFr/Myloask/YvL2IiYQQVhPNApDM1/oOB9YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lg9fEI+PUCku+Ich2rFW9842/Ef3clG3pxetYxveOo=;
 b=DhRN034vkSuy127nXRLM4rgJy/X3XSYm9d+rIvfl95FD8YRsXyjlKKW7+QLiOwKhhTQTm8IOBPc0sMQkjwZqhZID/E0pUWtoBCGUrFy8nOUXrD/YRPZdFQ23Og0Pdz1AeoL2k9sQtVAlfb41ZDce5hQNa2d1L1U+3We35MV0nqM1ODPvmS6/O+iAGRfUEYuE/IebxX7vRuKI1aHvQHMg55TReWWNTtNjmn5FsvadmYDnNdnlyMpLOV1bbCC0JsmucoezSXlMXN6IswY3bVb/v9huIVSCrp1l0KXO8iP+K1YayNHPxb5O7SnvA2gH0kA7wqDbUFaqvvfxW3uYqSiIGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 SJ0PR01MB7509.prod.exchangelabs.com (2603:10b6:a03:3dd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 15:00:15 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:00:15 +0000
Message-ID: <8a113fab-d58b-42e2-9c7c-e84dd2f27d99@cornelisnetworks.com>
Date: Tue, 27 Aug 2024 11:00:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] IB/qib: Use max() macro
To: Shen Lichuan <shenlichuan@vivo.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240827082254.72321-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240827082254.72321-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:408:ff::23) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|SJ0PR01MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7d0a80-1aac-43d1-82b5-08dcc6a8f565
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS96MjJsVzhFdlVzQ211WTNxNzhuT0p3b0FhM1NKSGk2enJDd29VUVhkdGJO?=
 =?utf-8?B?VnNSR2RwNmMyMzl0Zmc4aFZXeW5ub056eThtZ25ROVJLWDVJNjZycG1EZ3h4?=
 =?utf-8?B?Z3NxYVplSlloMkxRd2YxU3VnSjZRNVd6VVRWZzJlMjlpSWF2dDdEMW1HbTln?=
 =?utf-8?B?YllRUEhXR1lHMlJKb0lBN3MvanBtNkd5L0pNOXB2NmRLd1V1Z21Oa1pvU3JO?=
 =?utf-8?B?SWIxS1hXdTJjSW9qWjRPanBEK25iaFJCNEVNN3ZNYnRTVXg1ZStoSXRGaWxR?=
 =?utf-8?B?UnByNERMY2VRTFV5NEJsSCsvazdxTC9TVVdvQUFvN3RzYU1NWGJNMFlORFd0?=
 =?utf-8?B?b3EzQStxK001UnF2TTd4QlZGOE9xMzZ1TlM4NGpaL042bzNvMGkrb0RoNHM1?=
 =?utf-8?B?enRFaFgwVW1pVncwYStaanFxMXNKTUVWLzFKU0tSRmQrc0ZvQldDVjUrelJ6?=
 =?utf-8?B?M1NMOHlmZ042NDQ0c05XdVhhTzFkazlPVEJyUi8waVgzL1czZnhGeVJxMFBG?=
 =?utf-8?B?UjhOU3R6VFlZZ01relVCYXVIWEhRNFRMSnBCOWsrNlltY1dwTW03L2FWcDF6?=
 =?utf-8?B?UmpJbFRUbWo3WWpaVkhXclB2dUpTRTVpTThjUHNQeGc1Zzk3bzZRSDJHUHhX?=
 =?utf-8?B?dHlNaHhCSFR3djQ2RW5rdDNCdVdSNU8vN2FWK001a2tJeGtubE40RTJ5ZVhD?=
 =?utf-8?B?YVBrN3ZQYSs1MnRiNVVIMEtYTlM2c3FyWnZGSE1KNXFMNkYwc1gxWXZSUnlp?=
 =?utf-8?B?TjZmZ1p6QmdjSG9Hclg2R3lwbzU3bFBuRUsrY2xxYlZMT1BUZU93UHY5YXll?=
 =?utf-8?B?T0d5Qy9KY3hCQ0xWaDJLdUEvenRPbHVZS2JNVEFKL3VSYnNIWWN5OTZXdldt?=
 =?utf-8?B?d1hsZUFMQ1dWNmxMVWp4VkEzYlVqWEx0blhKSmZKSU5kRkkvSzNSc0haTXFY?=
 =?utf-8?B?TWE2SjUzWlo4dWhuYWNPN0hvaEJSMmRhcGI0dG9LRUhieEhqcmZBMlhDNDNh?=
 =?utf-8?B?TjhMNGtLQkFBWVlON2p3SEZwTFJWNWhqNjBJZkR1VStwY1h0enpMY2x0THlE?=
 =?utf-8?B?L083ZS9Od0p5TjQyY2p4bzBVRUQ2UE1jdTE3V1NLT0drS3Y1dTNiTEEwSnNn?=
 =?utf-8?B?RXZRc0EzbmxnZ2MrWHpSb1NHcE4wUklJYnpsV3FhYjdlVEpFVzY2LzNlS3A4?=
 =?utf-8?B?aXdJdlU0c1hVREFvdFcyMVJMSTJXUEhhWXlZclBCenJ0SzJHbWNQUTB3cDRE?=
 =?utf-8?B?dEs0Sis1OTc5cFYvYkpSU2tEYS83bnhybWVpczJtc1UvMGExYzd0eFJGTjEw?=
 =?utf-8?B?d0laemVhMnJCR21Eb1EyOEVLbHZ6WHh2d0FlSUl5YTZvdmJtb0IrTGNoTTJR?=
 =?utf-8?B?RHlvVi9uYjg0Mm1HcHBWaEEvbE9aVnArdmQyL0pYMHB5aVhrZ3h3L3VTRVNQ?=
 =?utf-8?B?OUlNQmxveGNOWVNUQjR1aHdPVVEvUjdaU2ZWZ1NZcVlhNUVJTlhNdUdiQVAw?=
 =?utf-8?B?NjVwNWxsaDdEQVFnMHVDejVnLzFoK0dDSVNybGRtMTMwLzdndXNVSnZhQTRt?=
 =?utf-8?B?VjJDWlBjWExHTjFhSysybFlKNFB0OXR4NE9zbEYzakExTHNQSE9WYTJyZ1N0?=
 =?utf-8?B?dU1DUDRvQUp0NCs0QXJqa2lyN0VNbmwxSThTdndIZnd6MDRrREdvZGhEZlFE?=
 =?utf-8?B?dEVBUkpiWGRwOVdNTUt0Q3pVT1RZeFdCZnNtSnh2Z05jWmU3bkhYbkdOVmJi?=
 =?utf-8?B?L2RkRjRKb0VFV0R6cVhNQXExVkZhMWlvYlBaMW16dVVJNElzUEZVc2E4bEdH?=
 =?utf-8?B?b3ZEUGM1RmFjdXhGYTVZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDFRcmZpTFdNUEZ6Z3Mya25ZTS9sdXpFWXk0WVMzMTdvbHlnKzE2cURYcnJp?=
 =?utf-8?B?cEExRjYzWVdNV05MbHFVcDVQUkNHRUs0QU5PaUM0dGZPUXZrcFo2dC9NWW1x?=
 =?utf-8?B?UnZsU2VMNnNqTmZHWmJYRGF6NVI2dVI0ZmNjdThMM3YxTVBLN1l5Zjk0YnJh?=
 =?utf-8?B?V0ZTNFBnWGZVc3Q4dWlzTXdIVlZqRTJaODJZQ2JNNlhFN08vWmVMVXdNNGJP?=
 =?utf-8?B?ZU85NitDY3doVlJBNHh3a0oxb0xKcmxaSzFLY1FLUXJVUFl6M1ZmR0UzOGZm?=
 =?utf-8?B?TllqVlQvYmJCNnZGY0ZuN3BMWVB0Zjc0K05oV0RoUEVZeFJ3bmlTK1hQQjVO?=
 =?utf-8?B?dlZWZk1YK3FEYzF6OVIxSGhEdlJ3SnlCTm9JazE1Wkp5Q0RaaFFDWDhxaTU1?=
 =?utf-8?B?Z1ROek9DOFhweTFvSmdxVkFRdzJsMUFPck5SeitWRjFpV0k2VWdqRmlSUWd4?=
 =?utf-8?B?WkQzaGdlR3FSWkE5NkRoRHBudUdqTkZkTExvQ1ZDRU1lV3U1RzhjWUlYYW9s?=
 =?utf-8?B?WXp0SUJxa1BrTkxWR1N0YjZEbUxSdUx6ZTZhVEk3TndZNVM4MU1QaW91TDNW?=
 =?utf-8?B?Yk0rR0hMVi9Obkx6dWFSREhxNzBSSElhUk5LYW5wSTFwa0RvbDFyVG5GZ01Y?=
 =?utf-8?B?QmUySFpiZW9CZC9YOHpTd3lVVnF3Zlo3S0dCbzZaRlgzSGJqNk9BUmpDZjhK?=
 =?utf-8?B?ZFkrVE51ZkU3MitNM1FsR2VINDl4cDk5RW8wWU1lbzBnVFF6SFh6R21aaHpi?=
 =?utf-8?B?YzQxRkgxQnNiSXN4WXViU0YwVmxqaStqWTBlKzFPZHgxc1ZCSzNBeUJaZ3NR?=
 =?utf-8?B?dThEb29zSzQ4b2dtNlROa1djTWJmODNnaTUvaTN2NUR1Q24vSzlXNnpqSmhW?=
 =?utf-8?B?QVU4RFV1VkFXNjBvRHd4TnV2ckg3OGg1a0gzZ0k0OXMxT2NIOXlhSGxhVVgy?=
 =?utf-8?B?aGIzbVpoU1lWOFhmUzNBT01Yd2Rzd1NnL2VrMVg2WnBNZmZBN0I0eE5WZWl2?=
 =?utf-8?B?YmdLMUk0Y3lpdjZRMXpXMjVhSVFKQ0hWTEg3R3N5QlVGZFNSKzBGMUdVOHBv?=
 =?utf-8?B?dTg5TzFJbnZXdUw4T01DVVFZdDhPdEdDbXVZL2Jqc0tCWVNWbVlUTno4TEIy?=
 =?utf-8?B?ODVRZHhXWTZjVTZjNFZMYVZENU1neWVsVkNSb1plSERZQ0hHZHJNNlVoMUI3?=
 =?utf-8?B?TTk2cEhpUUd6WUNIeDdIVW9RNlNJQTBaR2dZZ0JHTWFrNktKOEtuM2wzalIw?=
 =?utf-8?B?VzhmOVZTYzdTZGIzLzd3QW1McDJnNW81cE9GMXpTeG9DOEV0RkxiYm0rVkFm?=
 =?utf-8?B?SlNvNkl5Y2tWOGZZbFA4bFVZbTlGUFE2WVFPRzI3dVJJMUxkNXBiZG81VjZV?=
 =?utf-8?B?TklpTTN4Ry81MHJKaW05dStLY3FmV0l3anFoWlVBVjM3QTNoV2tObll3UDE0?=
 =?utf-8?B?S3lxKyswNkU4N21LS1ZFeDhmT2c1V21PU01keTYyUFRRbXpabWFzZHJWa3Ev?=
 =?utf-8?B?SEZJM1pPck1QS1VWSW12Ry93RW1scFZhUGcycndVd0hvdWw2NkllNG45RTB2?=
 =?utf-8?B?YW9LKzdSTllacXI2K005Y3ZSekIydlQzRzRZRmRIT3REcU5zbkxNNTNITVgv?=
 =?utf-8?B?TGJBbjBHVFRwbUgvY29VQzQ4Uys1OER4SFl1Rk9SYnZNM3hXS1hCeU4ra0hE?=
 =?utf-8?B?eUxyQkNDa05hbUpHa0NCYlBwUmswOXVIdkxRWXRzR1pnbDRzT2hwOWRBTHRV?=
 =?utf-8?B?YUZDOTUwNHVBSGIvMlNIRlRxWlNhajBlSGJXd2F4TGk1aDIzTmV4UURXdlFW?=
 =?utf-8?B?UkV2Vy9CbzcrZTdZY3oyZHlERHkwUXJnd1RKTHA3Z1dIV1BybS9XYUtzUFJS?=
 =?utf-8?B?cGtPdUZaZUhoL2ZXclJQZWhweHp2MXFUaFlkM2ZHLzNKVXVKYjNGOFBUeXdx?=
 =?utf-8?B?SlN6Q2FPTEMxaFI0S2svbjVNLytqUmRFYWYzZmxYUENUSm5COW42dUhqZHBj?=
 =?utf-8?B?eTZuem1vWHo4UWxhT1o1a0NKSVFpdDVFOVJ5dURUSWlRTGRvZHhkVk1NU1ZE?=
 =?utf-8?B?ZGd5VGJTb3ZMVnFJK1F5NXlrajhWRERrMlhkMHk3VjVzVXlLeWRVOTJpY0p6?=
 =?utf-8?B?NXBIUkJJejkrSEFRcmhlNndJTVNIazB2M2R0ek5RWjJQS0c0eCtwTXhCQnp4?=
 =?utf-8?Q?EhOjy+Kkrn4apU3Fx+NHlAY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7d0a80-1aac-43d1-82b5-08dcc6a8f565
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:00:15.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sCCnaPHQnX7JbLf7ka3DnfTSFWD5nUh77DgjOO0meBt45gOs3h8ZKS1UfzLXANZ31Z2SmqWiA6wWr4FrzkgYOUpxGr4TOiO1bjKI0CKdVaypUf4kj3C0Yrk2/EKgW6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7509

On 8/27/24 4:22 AM, Shen Lichuan wrote:
> Use the max() macro to simplify the function and improve
> its readability.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
>  drivers/infiniband/hw/qib/qib_iba7322.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
> index 78dfe98ebcf7..4c96b66a93b5 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7220.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7220.c
> @@ -4094,7 +4094,7 @@ static int qib_init_7220_variables(struct qib_devdata *dd)
>  	updthresh = 8U; /* update threshold */
>  	if (dd->flags & QIB_HAS_SEND_DMA) {
>  		dd->cspec->sdmabufcnt =  dd->piobcnt4k;
> -		sbufs = updthresh > 3 ? updthresh : 3;
> +		sbufs = max(updthresh, 3);
>  	} else {
>  		dd->cspec->sdmabufcnt = 0;
>  		sbufs = dd->piobcnt4k;
> diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
> index 9db29916e35a..5a059ec08780 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7322.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7322.c
> @@ -6633,7 +6633,7 @@ static int qib_init_7322_variables(struct qib_devdata *dd)
>  	 */
>  	if (dd->flags & QIB_HAS_SEND_DMA) {
>  		dd->cspec->sdmabufcnt = dd->piobcnt4k;
> -		sbufs = updthresh > 3 ? updthresh : 3;
> +		sbufs = max(updthresh, 3);
>  	} else {
>  		dd->cspec->sdmabufcnt = 0;
>  		sbufs = dd->piobcnt4k;

I don't see how this improves readability or makes the function simpler. I'm not
opposed to it, just don't see it as an improvement.

-Denny


Return-Path: <linux-rdma+bounces-1428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED887B90D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 09:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E0E1F2223C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6E5D463;
	Thu, 14 Mar 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Vp+y6p+D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE63209
	for <linux-rdma@vger.kernel.org>; Thu, 14 Mar 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403499; cv=fail; b=mt7GfLR2NSqKn5UB6WWa97QTZsGXt3XwkjlGBpKMBEiCZaoNM2gDiX9h+nbJ0DasOsUG+yo34pJuid/Cht0RWBt4J9Nl2OfHXVXUPerdxDHHQYK5teDooCaL1dSsU0O6SfqbKgJ54vKhnXFdnKKuySPjMI85t4bO3c7xAMVjx7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403499; c=relaxed/simple;
	bh=aNHlczOIa4Zz1nBj29BuG5jSLVSgsDB3EYAhC+X0i40=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l36thkslmGi/v5BzdZxhAJzV/cUVZyFao+vUzc8t5dQRGRt0TrlM3inyVMuZhfkdQEcp3X5gBykkOmKpjypF6XzgLDzedQA8q6Wa1dnMV+OX16LJCDNvjrkierPtiiycG49LKYzeT42FclYF2wugrx7G5SlhjHPLdjdQnYqXwU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Vp+y6p+D; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710403496; x=1741939496;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aNHlczOIa4Zz1nBj29BuG5jSLVSgsDB3EYAhC+X0i40=;
  b=Vp+y6p+DFHfLKYW9LwxJHE2RN77hv04Z4IQIpallI8n6R8hfkTVVkJJ4
   VmLEAsjJl1eNFI0k8Kzec9x3YkFIpe7ChAsqsfxDbwu5ufLFodP3W1C3z
   b9jGCh5ga2YdRvnsI/FqasMfJ6FFn6hQTe1oa1Tj4ofWwK5YvogLOax2M
   84cBd0ew1gSjPMXpdu5LUGvsB2Ao0fa4meqz97mZ1bTfGzAzPbJ5z1fFA
   1uDfI+JRtJ2U5OvzAvSErVnhVvi81cSkBULW5FDRGtmApfKuXweC+61D6
   XHvl2A797LtA7AcYyfui79wtB94n6j/yK7MLExGgDdFuVHxUiNSdnW2lg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="114777038"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="114777038"
Received: from mail-japaneastazlp17011005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:03:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOWM1H/JHJwLUXUl7ozb28YmxMR8vyFgIkTK1Ad3fJb1ggDSBXJHmsIH7OoPu4Rry7xAdmBD74sK9rNQJwAMFmbG+yFfv5S/f8RjTCkVMkgqQbQYdx4heYkil1ocIgd3sOrq8iuDPQgAHWtpFsLplOanubHeNn+NdsyF/31oTq7r2T6ngcNkFRydGiZ9MWpOdWAUd+3Wqtqiva5b3BPhe4VkoT3GsS5Kd8B5qApOi8bFX593DmaepVr45p8R81sdzlOsnyXx99DxbJvlV1igZPcN8V4GvkeNBwyWTG0cCRh11DSIabO9hZSqBQ5ms67zUqVq5cucT9KWL+qKVXOqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iukMSr2puvumN0pQNCjBkhhjMnfh1Oe9jiujeiRz40Y=;
 b=VmEnLLB9I76ejREk0HNThWWUOMi6OWJaF+KvGQR3qF2+9eun9+UHfTfYNlqtv+EnXJWPajk6nsChsF84xKHBBW72buY1Fddl0NEl5iSFvA5sy47zrUZaDcJYhYp2WznHHkwPh44L4Q9D9rsZcnWOl4DGcoi8YzVnAksnomcCeRxGBmUOAWdXaTmE40Cu/rB55jNF2YdpjbnTg8GlQIGHyjyFY0gx8mC/33nPpxTTa2FkmbMbazFLnPuRNheUKliRYdRKfAVCs3WslWwxEvkrGYi4ajr5k0H5YYW1LZxf+VlvsJ/T99HpVklH9XhTpilW8slW84ELsJQOYMTrR2pafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYCPR01MB9554.jpnprd01.prod.outlook.com (2603:1096:400:192::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 08:03:41 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6910:f082:bc21:75fc]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6910:f082:bc21:75fc%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 08:03:41 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Yanjun.Zhu' <yanjun.zhu@linux.dev>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/1] RDMA/rxe: Fix the problem "mutex_destroy missing"
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix the problem "mutex_destroy missing"
Thread-Index: AQHaddwfOQFe81bzmUy8oCeiFk6qDLE236OQ
Date: Thu, 14 Mar 2024 08:03:41 +0000
Message-ID:
 <OS3PR01MB98655BF56D1442662955C53BE5292@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20240314065140.27468-1-yanjun.zhu@linux.dev>
In-Reply-To: <20240314065140.27468-1-yanjun.zhu@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=8a3037cb-85fb-4d0f-a3d2-5dadf8583b28;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-03-14T08:00:28Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYCPR01MB9554:EE_
x-ms-office365-filtering-correlation-id: 3a3bc1a4-3fbc-4595-d026-08dc43fd4316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ngkzy9yfcC7FPrj10gLSTob9vELE0uOZ7GYNCziD3XYe5w2CXGtT7tqVx97pDJGQdF0AwHEw3095IXzzVg4skPZn4nvwE0QXdY9Kcxlz+wS1KJ7zyiIUH++LA2YMcL+wwsj+ZugoUW4rPKVYGfkKndVFSHyjIzExGy6A3dTyFjNfS5Qef3l0LuvE85J+6jDT9OV1WcWDSDeuVsCO/ndgs5e86j6L8/Hm2NlTZU31/2rXT3bs983puoNx/B91eeYdDDAx8XCV3hYdGUyiG9MrzV+5tDnBUb8T/dsBmrGZjxYWcesxjyliSGLxoQhmQmebFup5rdT+z0fgXRMCJAfzAkp5WHE6IQRRiXwZfJ9a8BwcMo/mPEg3CCg+bGeBJOKIWK72m0sMB6V8OguFm/SJfcDxx0sBLRqjfp0uAlNXaxJU1DiZBiiadGx9DsuPTCyo2LymAbCdxlJWryl4kncPJXglhuAaszz7FbyOji/XvCZzGgqVWfGSftcSp2eEMEadd72hbqyI5xEu8yNLcpqfh5T7ynZPaHpdWZiET7x2hNLpXKmx/0QJcknbFYs/7EJgmWxdRrq4hdvflW2+SnRvC76w8Dj8GNamef3gjxXdIoHyyKBGplyMWAoTMn+JshCXdzlwudB+14+BSy2zwsrkLcX1AfnAJLyII+uqkf4fMRaTVsgfwwKwTzro9ZNqmibBOkuLdJRKTTlf+uGSJNlqz1G21H1BvvQ0yhe6mVztPBCbTVgnlFgVmADkoEuMkSxU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Nk1rUExsZ3hZQzdWNmh0MFdUcll2dk16R2xZRnpqWUs3elJ1eFFQUE13?=
 =?iso-2022-jp?B?UHBjcm9lZWlTczFiTUZZclZKZ2ZXNmkwdllia1Nrdk5QWFdpWTV3Y3Vl?=
 =?iso-2022-jp?B?OXg3VUplaFNpelUrYnNDVFhMSGx6WHRaQlhKdmhHRmVOaTNEQVJQUkJF?=
 =?iso-2022-jp?B?dnJqWFZGUUNNb0FOU0o4SmNlMUdoblM2ZVNHTGNhckNNZHNrQXVQYTJv?=
 =?iso-2022-jp?B?cllpV0d1V2E0aWNTdTJUQUNJV0NHK2RGUjRqbkNVZzN1d1cvcHFobmpj?=
 =?iso-2022-jp?B?NE1qb3FXTmV6ZWFRdkNQQ1A2cmhQankwUTlRL1g0eWdCMEZkWFFVdlhR?=
 =?iso-2022-jp?B?RnhZR1o0S3QvRm1EYnBEdWpIRXArWDhtMGpkQ2NyNk9Cd1VCbEJJZHRv?=
 =?iso-2022-jp?B?WUNneEdDQzVHQmo5R2JJWUJHaXArM1pXS3NzWWdXS0cyVHRoc0p3YVo3?=
 =?iso-2022-jp?B?UzlDVjlSMnRPWGNxcHo3ODVPR05QOFFZcmgveTBRRC9la0lEbDlnQjJm?=
 =?iso-2022-jp?B?RHFkTmNMVUliQ2U3YzlRbkF5TlVweTBrS3ZORklMekZHM3RMNnYzTVA3?=
 =?iso-2022-jp?B?cHMzQkVYdXdGRy9JRFlweVVTZFBJTk9vVzhxZng0alU0V0xMQjFmTkdy?=
 =?iso-2022-jp?B?UEE4S0NrOTdZZjJkY2FxZHR4cGVveVJmaHZyZEtyRlBNemdsM0FEV0dM?=
 =?iso-2022-jp?B?cVFTa2s5b0oxMU02UC83aEx1SktDaXJHMEZiSVlLQjJxSzB6NHE1TEly?=
 =?iso-2022-jp?B?OTRDUDJGWkNzV3ZDUW5CajVLV042T0l5b014cVh0d0ZKeHhnQ2NVMWE0?=
 =?iso-2022-jp?B?c3dFcnlHRnk3NmF5SnBnTVY2ZCthUmFFUU1xdUVwRm1EeG5ybGl4TEZU?=
 =?iso-2022-jp?B?ekNkWUtqNjBVc0xVNkd2NktJd3o0YVg2bUowejNwY05QbWdmc1J5NUdQ?=
 =?iso-2022-jp?B?NjE1S25RNTlxc1dGMTNkNFhubzhMRlBlNXc4SmgrRUk0V3hDQ2JmNXdU?=
 =?iso-2022-jp?B?UWh4ME1tZGJCb0tvVzZGQjNva0I5Y1RoRm5WenVneENUZGgyZGwrT25E?=
 =?iso-2022-jp?B?S3ZuYWpwVDdkTC9RR3p3bmw1RXFzUG5EaW52bnpqeEpsOUlpdXNXTmdw?=
 =?iso-2022-jp?B?TGZoc2cyYXJSaDlHaU1ab25xVXZNOTV2Zm5UV3dYSnhUY09HWGoydlo2?=
 =?iso-2022-jp?B?NWJvRzByeTlUQ3JSa2hGdUk2ckFLVGV0ejFDem9GTDVId1FWaGRLV25p?=
 =?iso-2022-jp?B?QXcwMnJoelZMb251SkE0UVRxbG9YOG4xa3RSQ1Jqcml4d3FJZWQwL1Zt?=
 =?iso-2022-jp?B?SHVzV1RKUWVxZWNpdkJRbkpmL2ViRnBlbzdaSUIxZmxRY3VWaVNXUjdx?=
 =?iso-2022-jp?B?MmRpd1N1c0xMT2tuaHZiSFNkRkVIaEVzRzJ0emU3MDd1VjRCSjlEWGxR?=
 =?iso-2022-jp?B?dE1TczNkLzBjbzlHRSttYmZFRGxjQjFiMlB3ZG9hMGpybnp0NE9yWWNG?=
 =?iso-2022-jp?B?SGVrZWlKU2dBZHZ5d01jVEljVUdrU3h0dmo2aFJDNzZIaEM5bXMrUHdL?=
 =?iso-2022-jp?B?K09iQ2hpTlA2Mm1QK0Q2TzZQTG5UTDBzaklPazBJajhlY2dtbVVOVTlK?=
 =?iso-2022-jp?B?YzFYTmtQcm9iNHpvaEp3OXF2Nm9JMGdFaHBtN3YxZ0s2TWJMcW5ZRWs2?=
 =?iso-2022-jp?B?WTA0dWs3WElBeXhzRHlmUGxNRGZnQ1l2dTFZOWFmdFBIdjlwemc5UXg4?=
 =?iso-2022-jp?B?SzRWd29zaHllWGJnUU0zdDNUWFlRWVZvRDNLNXd1aHllaytvQkIxUjVx?=
 =?iso-2022-jp?B?WUp5TVp2cDVnL1oxSnVxQW1icDltVFc2YXZ2ODhxR09uaVJIZUVrVldR?=
 =?iso-2022-jp?B?RHZzZTNMV3cxYnhFeW1QNFdNYklycnNBY3g5UVhLK2YwdnFJZmFZdk9H?=
 =?iso-2022-jp?B?T3dTZjZOWTk5TzZaRWhMOUw4QXpYcE1LRnM4cHVSVW1uZkk2V2EvcFpQ?=
 =?iso-2022-jp?B?RDNKSE9VVm1XaGh3RnBPWTFKZnQ2TVd6TjlzYStyNTZVbFAzRTBqVDBh?=
 =?iso-2022-jp?B?cThPZ0dFdDA2elMwUDUxOTh3dmhwMnRBVjFrQk5LYWV2UnlrYnNORS9R?=
 =?iso-2022-jp?B?T2ZGMEVBK1dwMFd6R3I1L3h0NnRaZ2o5SnNmTWdZS1Y4cHNJTmVxUzFZ?=
 =?iso-2022-jp?B?b2JjOXE0ZFpaL1FYTjJnWUdhUWgvUitVMU1hZkFaYjIyd0w5YzE4WnJa?=
 =?iso-2022-jp?B?VE05VkRwWm5XMXRvalVYb1JUenFwYmEvRENKaFlob09UdURnY3FxZ3lK?=
 =?iso-2022-jp?B?U0JXSUtuZXQwaVpzR3hqaGx6c3VJeGsxWEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y9BEOhewtHs4xL6C+L6DvJ+bvVTA7nWxUdopx6BVfjdETQFKTrKBr/khR9d6qqcJx+fCM9cM/uBmsS4X5MfV3Br8fGy3R/dKzs6qq5pnwLRyHO/NlqaaqvJC6NIlATncRYQPeoQB9NYHGYwctP0nleayVCd/pduUk5CfkM79ZUa8H0S1GsXNp/v7DfAL95A9FVM377vSMV+sBlPZKrndUFIilhEVroacsiuQlreDkyd62eGW3iEQ16RwlKoiN+YOEkobfLGIYFe0jftLjR62xITFqZPwaQXCIhD9CEXpsrnyELW5yA3hJQAE3CUjFvNv31iIqgNoNJ5zXsxwgEPTF0ZCXEotJmIfj6TBD2aTj2k8zgM4SUsDFbuBdUsG4sccgUwLUkTnIRfbjnDy5opp9kMb4QOMlrwjIwqs8KdzYHZ7ntGBV4t90LDFHkyJWbaKtFjJHDFVbf2EvCUD0p1ZYjM17Kpr3pPIME0T9Amk8hwuhPuBXKH7yQ4avG72c/g8VZwvYIJ65QwqESGpemvWCewZP1WHiv/0K9NV+ySIMsecQiHqC6FUIg1s9YShS7SreJjjLveNIP86VPn6wy4+pdfYHhayaO9OPDD8Klr6pBG+BURCmvF2ZvcNJfZqztj3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3bc1a4-3fbc-4595-d026-08dc43fd4316
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 08:03:41.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8jLfuepbUYM7iCdR46IyPHQCGjnBXpyIb1brBUbx+4LPb5it43SSi3sK6qUCAkmsMjWxJ8xzvt4vOGasqwrTFcFeBRD+ODVqrXaMbeW8sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9554

On Thu, March 14, 2024 3:52 PM Yanjun.Zhu wrote:
>=20
> When a mutex lock is not used any more, the function mutex_destroy
> should be called to mark the mutex lock uninitialized.
>=20
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Yanjun.Zhu <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index 54c723a6edda..6f9ec8db014c 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -33,6 +33,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
>=20
>  	if (rxe->tfm)
>  		crypto_free_shash(rxe->tfm);
> +
> +	mutex_destroy(&rxe->usdev_lock);
>  }
>=20
>  /* initialize rxe device parameters */
> --
> 2.34.1
>=20

That's right.
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

Daisuke



Return-Path: <linux-rdma+bounces-11856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94118AF6AFB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 09:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF144A4296
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A9295D96;
	Thu,  3 Jul 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hiKbjBkM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D56227574;
	Thu,  3 Jul 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526044; cv=fail; b=ShuSi/lFxVOdqaqKWoOjwNyOpkDOUSqycrvvXKVbWmfEwBbBG2gtZtKRdg1odT86oVkaH0VKFNXJwNnqJeUeG/UumStrT9gPkXguHd0EJYoquM+9mtyuNOywMBpfdkkIbD7dhLoJHaP4a9azrZ3U1SenN+uNpNSC8kupChtcXIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526044; c=relaxed/simple;
	bh=uKvotf3sPCQc+ihGg3FQQOZXVvIbeP7g/0VCws1N2Ck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjMR+TGzrsFLckTwyQsg8YC4ONwJFB6oO0zAQjy4vFo95DEqhOtmoldAsNoM8RILEsfrqVEWdWeJr2ZX4NANzkjnuZKcmb/NAhbpKfZ9u54xB3B2fzUi+q8uywsP6J/3+ZI5yGafnlRDuyCYOwnZZGNyHxqj12ajaaVzwL8jRpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hiKbjBkM; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH1YiWsZ9acldT+t0Y9bx+Os9cMXT9NLVsyBIVFFzteO+Eo2Bl20GFVvUk0Gpcvr1ZByYlYSmeebFMu51wqgYIH9UrgyTX3jGrPM0znJ6ah7S4fb2OadgkNM5x87GJPu6huXXPRX7iVUraxPbw5wo3zq6F9ooZoPuLUwAHwzNrDuexirSf57RxsuMp6Jj8dUXSY2cTX5p3lEIxpMSHSSzHFmSeIz3EuBDTOZPuTYEmiUMeSA8fonkMYyNo+BiJ+2DDyb22p8/g2QgDeJz8nN+IBG98o3yxqUedEhXeqmmkrd8lWzaPks8OHMCU2CxV6M33se6mVOF/+HdJps2XpflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/W3ya9FW7/sxVqC7hFyi0zTf2PMEx4bdBXh+K7Nhtw=;
 b=N/SXr5wRjESYj8/q4RjdBkq8GEoNwfGxCV8Uekf/67CYOvNSwDIzzjSJvxopxxZ4JTahDpARXS0IgOtfn/8Pl+X0ezYNA5HgDUQ6pJowa5En3vo8hjdL6LDCv6DiHIdN6nfuF8lbAjGb7J6lh6avA6ylDNoZ1PcOuZDDYjkjR42R6xvek+7NrW2CxDc18ZLGp3rC5qVambX64k6L3mhY4mjiyUWznDbtn0HCuRG6Xl22m/9Tf88qkTCYQlcO1pN9cDxBg86qm9ZXvEm56VJDwIopur7hpMAGQliiVgI+TJu4D34Rousjrd2MPPnwk/dfQov9FRyNo8IvCl78pdXxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/W3ya9FW7/sxVqC7hFyi0zTf2PMEx4bdBXh+K7Nhtw=;
 b=hiKbjBkMYkX5NWwjbbrp5Yag3l1aKZT5Oz7nQa2meSlNFBTLKXoDmKfhrT2n38XKZHdkWYjRaYI1qkTemX51Wcnm9YJikwrMQ5qk/7F7fIrCKfh65Ej6o56jzZ8o3lnwdXM0kXtEyQ+CuNwMZUipxp2pzBkbrCZP0EF45tsoayk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 3 Jul
 2025 07:00:40 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 07:00:39 +0000
Message-ID: <e2347f7c-a1a4-f012-0b24-cf3bb4f3cb8a@amd.com>
Date: Thu, 3 Jul 2025 12:30:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250701103844.GB118736@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d678e4-f3d5-467d-eb06-08ddb9ff51b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVp5UE5jTVlvL1ZzV3d2R2pzZ2pEZ0ZpTFZZM3E5eDk3aXQ2RzZDbHBVM3J3?=
 =?utf-8?B?ZmtYc3J4QWdpV2RzTGlVMlhoZUZUSVhwdGpaU0JZWG5vaHdXUk5tTk9sNmRl?=
 =?utf-8?B?M0N5MWtoZk9Sb3hlWVl6YmVCUDVkT2ZwMXlIQnRpcURUMVlPemVvOW11V2dR?=
 =?utf-8?B?bFdvQUxZaVNKdEFOVk1jOERmK3NqeHZ5MmM3R0hTOGVvdFo0N1FCRVlOUmNh?=
 =?utf-8?B?cDFyYW4wK1JaTTZ4Q3BJQXNDZjd1MnpIZW5yTVRZZzEvSnpFcnQvY1luT21i?=
 =?utf-8?B?MlVPcXhVRnVzRHRVNkRVN0lJRXFUTEVXM2ZmbDg4NlFPTXZrOEkvYlFXTzNn?=
 =?utf-8?B?MnA0MFZUUjZZdm5ndnYyTUphZkxWQTd5TVVxWG5yL3o5b3haZGg1ekNabnNn?=
 =?utf-8?B?SHpOekdJT0NoMGxjTTdmcXgrb0FmVUdPQlh5MXFpMzJpY1c4TWR5RS94WlNL?=
 =?utf-8?B?ak81Z3FNTi9zbjQ0SGtPZ0NpNzUrNnBJOHEvc1B6NWc3anZtSlZRU3RjblFh?=
 =?utf-8?B?UnUva0FhanFuWHQ3QXR1dnNZOHorYnliNStxT01Mekg3YUFEdStqM1hUK3Zk?=
 =?utf-8?B?eHRiU09rU2FHMDVWd0VwaitCOW1FYm9FN2c1c1FvQ2NkUFZtQU1paGZ1QlNT?=
 =?utf-8?B?RGF6VXQ2ajdVS2tPVm5TZWI3Rmo1MnlDTDJjbFVFeGZmQ2Uwb0JsSTRQTmk0?=
 =?utf-8?B?UU1WaElnVkIyeVFXbURjQ0hNSDBpY1NzSW1WVUhtNmc5NlVrbEhmY1pxTG15?=
 =?utf-8?B?d2pqY3hKM3dPMzB0ZmcyVEpnQTNQMGtKTHFOa1RjaERscC91Q1JQem1kaFJM?=
 =?utf-8?B?QU5SRUNZMGF3TzhaSlhvaFRRbFEzOFRyMEdsdWZYRFFzTGtESVhrL1NiNlVJ?=
 =?utf-8?B?cFRSMllkbklhUzZPS1lRWFVCVjRra1ZvRml6T1ErUlZVTWJWZFArbnNRcG9I?=
 =?utf-8?B?WnRmZG9rRjcrczlDWEc5UERxWmxkcjExck9UYjRTMHFZZm9mY1IrcXFEeGI4?=
 =?utf-8?B?aURXQktrZ282Q2dvU3hOQ3d3cnRCaTFleVdrTmNablh3bklHU0M3eHRualFZ?=
 =?utf-8?B?c3RkYTFvOThUTzhzUFVsQ1N0STJOSUJnbGRHWTdzTXM1a2djSGZDbXpiamFQ?=
 =?utf-8?B?RFVISGIzSkl6bXI1OXYvZTJ4dHRlMHlaZ3hYSlR3N01Fb1U1V0tUdUdBN09h?=
 =?utf-8?B?MkM2VlVXRVRtZjdEZ1lDY2dTL3Y1L3ZNN3UrSXNobVphSmNtdklWbzJpb3JJ?=
 =?utf-8?B?akhkMlcyTXZWN1NFV2ovNDk3d0RVYUsrOHI1Z0JJUFJMRFdSR3grS1J0aFND?=
 =?utf-8?B?bDN0RWErenJ3cEtJOWtYUlloZHJBYTd5ditxa2dDaHlsRnRBRG1RaXU3TG5H?=
 =?utf-8?B?cUFHSWx3RnlpV2I5S1N0WVA3ZGpZdUlURjlzNXdLSUY4L0FyOGZzS2xFa3dv?=
 =?utf-8?B?ZGJaNXVIWVNaMTZZYzNDVnNQeHdvQUx1dnlmVHpVL1Nta2JhSVBuM0dleVZt?=
 =?utf-8?B?SXJQWGhmcGxQaURyeFZkTWxPTkJEL0VYM0dQbEZ3ek9QQTNPbEZnTlRuUnFD?=
 =?utf-8?B?d2JtaS9pN3NiTTVnQ0RmL3B3b0lDcldGN2tTR053RzArdDROdGtVTGRkNWh3?=
 =?utf-8?B?aTVIMERXaFltbHk3dXhTclBBUjZDV2luc0JleThJVGhQUzJ0SjI5UkdGbytI?=
 =?utf-8?B?WDNROHB5eW53V1M1VFh6bXhSdWFiM0hsUktocGwvMUNOR2V3TGVEcHZsVzYr?=
 =?utf-8?B?ZnhBM0p0eUh1U2FmSXV5NVJNTytyVUF0YWdHTFN5Y1JlK2k3OTMyeGJkY1Rv?=
 =?utf-8?B?biswMERiYnNTVEg0OXlIS0JCbWt6NGgzT3pJK2xrb0JLOG13ZVp0ZUJqZFpV?=
 =?utf-8?B?MVlMaFBPd2JBMlVpNmZBZDRmWE54eHNyendyTlFoWEJiUWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFOOHlWQ2VVQVhqMzBVWWZwS2xZNVJSZ1NSNE45S3Ywanh2RG5wM2pRbHo0?=
 =?utf-8?B?em42NHNQeklWcWRJcGxmRzlVc1krV091Nkh6TWdhbnVkSXRYaHFRLzN0aHgv?=
 =?utf-8?B?ZWJhSDJSQndjcnVMOUNwelJSOXBYdTlrWVpUNGFkY3R2WDJuNWVJQXZrRTJx?=
 =?utf-8?B?clBRbTdVQmlydGt1Q29QSmk0NThEcWt4UFlBL28raFdwYnZVUG0vL29DWnlZ?=
 =?utf-8?B?bVNUdDRpbWFFWSticksvWngwT0JmSTFoY2F4WXdTekU3cllhODJnOG5rY3RQ?=
 =?utf-8?B?ZUhIbVRCdzNBTXVSdDF0Wk9tS1RmNEMrT1lsVExobWs5NUFQenVZV1dhTWpw?=
 =?utf-8?B?Q0YzVDJMUzEyZlNKZG5rVzhzUm1LRldFSlFNKzYxVUpKL2pEWDJCVW10WlFM?=
 =?utf-8?B?ay9ZeDl2SFRmWGJGSU5OVk9YWWsyeUpZZElHLzZiL1N2OTQyVW5RUnhDbnZP?=
 =?utf-8?B?cHJYLzh2bjRDR3dkeFduSlh0ODMzMEg1ZlNXT2t1NytTR0hGSFBxNW9lSnBy?=
 =?utf-8?B?QXU5ejZZajYvaHpBOFVtNWpXYXJZRFhOMFpYbWRHTFVQVDRCakxwS0xEOTk3?=
 =?utf-8?B?azZLcU5Jd1dFSWgwQ1h0ZFpVUFY5WnhVMUdIMVJvZTZGRGNkNFY5dno4d3Ux?=
 =?utf-8?B?SlN2cnNCWllPRXI0ajNnVXMyWk5JcTgzOGdYRHZtUTlLczBDVStkNUMvdjVh?=
 =?utf-8?B?V0Vzbm9Vcm1HNkxFbnV4NThnSWVMTVU2bTB4S1BqRlQxZGk4ckZUaG1xN2Jx?=
 =?utf-8?B?cjloWkV4LzFWcG1NRzRhVHhGQlA5TjFYWjljem1JcUpkWEFjRkQwb0ZyYlgw?=
 =?utf-8?B?TTRmZkRMbUpjcVZhTUJldDNsanBqRHRGN0k5T0hSa3M4dk9VWHV2Qnk0cmxw?=
 =?utf-8?B?T3g4b25Cb0d2Nndha1piOXhmblRvS3ZVY1FpaWZEcUtKTm11dzVjOVJhbUF4?=
 =?utf-8?B?QVhMblZVS3p0OG9weTVFb294aW45RXVMUUwyc1ErT0U1WjhTVy8vRTRpWS9h?=
 =?utf-8?B?U1doUVROOGZzWXFVam1sak95bUFSaWU5NlBkeVYvV25aWVpjdmN4WnVySGlh?=
 =?utf-8?B?MTBDblFObE9mMm1Ra254b21VOUE2ZFdlZHhZWXVsQXVFT2ZXcVRtR1RkcWJ1?=
 =?utf-8?B?UDQyU0hKdE13dFZ2NjRFLzVQQy8vdXppV3dwVkFwU3h1Q0ZkcEp3Q2JVN0pi?=
 =?utf-8?B?Nm02UXJQbTNPT0VYdTVKNWNpSmtNeVNya2ZkYTlwVDFRb01jc0pGZGJ4MWtt?=
 =?utf-8?B?bGF3U1F2V0tLWU5MK1hXcllUQXNXTGZUVVQ2QXpWMlphVkNjTEF3Z1g3bSsw?=
 =?utf-8?B?NUM1VHhoTmZWZmJOaEl5allvTU5WQUZqak9ud0hhZFRTaXZqTVh6NXkrOHVT?=
 =?utf-8?B?MGY3NUM4VnNsQmF6SWtTR2c0V1Z5Q3Zta242RTJxSU91K2cyRUNPSUpWcExO?=
 =?utf-8?B?dXhhakt0dHIxL251K2ZkVVY5VlhNMnFNdW9wN3JYTlNXVkY3b1p5VFcxQlVp?=
 =?utf-8?B?OU4xbHc4Um1nbHRYSVFFRjErbVpkdlJUd0h6QlJFQ0JuUU9WL3Z0WmJ4N2tK?=
 =?utf-8?B?SnF5a3NibDl1N3FBSTF0Z3ZvdDhEYlphZnpiNG5scy9kRUV4Uk1xOVQzZXZI?=
 =?utf-8?B?aDlISnEwOGRNMkwzb2g4Z1ZXRHl3TGxNNFE2RkdFOWpZc3IyTmMzWWtHUWsv?=
 =?utf-8?B?ZTRlKzltdkpuY25qRk0yRmVHQVFMTUtVWnZNejZiV0x2clZBTDRJb2pBS2Ux?=
 =?utf-8?B?M2krNGxFVG5pbXlYL2pEWEw4ei9hNjVMU2JEN29UbkQyNE1VcmdCWEJkcnBq?=
 =?utf-8?B?cW4wSGEyNjJKT3lYOHZDUTBVandKNFFyMitUK0I4Ym1MbW5Lbmt2SXNxb3dU?=
 =?utf-8?B?RGFCTFFrWjhzZWExN0xFZDFXeFRHRnZSODdZWW00bU1GSnZIWGdab2xGVjhZ?=
 =?utf-8?B?czVTd1NkcldreTM0Qm9PSnhFZEpTUTFBbTB0QnRvb1FrVVQ5STBuVk9IV2w0?=
 =?utf-8?B?cmM2Nm5COGNuby9hbnkrUFQxNGJxdW9LaDE5NjJCRnl6NjJFNlZMeEhuNTI5?=
 =?utf-8?B?Tjc2czA4cVJQRG5MbWoxOHZPQkE0NnJJRTd2Zmd6cFNjUXFUMHBYNklYUmFS?=
 =?utf-8?Q?Of35LnMC0LmqillbrrjjmspNQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d678e4-f3d5-467d-eb06-08ddb9ff51b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:00:39.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgLwdX4QDosUjm1K0D1TXY90G0eZ0nC1ZH68oBAbGwgP//zU/TIX0nyVcAYeNtlAtubY2eZGZ904BTF63jx7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442


On 7/1/25 16:08, Leon Romanovsky wrote:
> On Tue, Jun 24, 2025 at 05:43:11PM +0530, Abhijit Gangurde wrote:
>> Implement device supported verb APIs for control path.
>>
>> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
>> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v2->v3
>>    - Registered main ib ops at once
>>    - Removed uverbs_cmd_mask
>>    - Removed uverbs_cmd_mask
>>    - Used rdma_user_mmap_* APIs for mappings
>>    - Removed rw locks around xarrays
>>    - Fixed sparse checks
>>
>>   drivers/infiniband/hw/ionic/ionic_admin.c     |  101 +
>>   .../infiniband/hw/ionic/ionic_controlpath.c   | 2530 +++++++++++++++++
>>   drivers/infiniband/hw/ionic/ionic_fw.h        |  717 +++++
>>   drivers/infiniband/hw/ionic/ionic_ibdev.c     |   44 +
>>   drivers/infiniband/hw/ionic/ionic_ibdev.h     |  249 +-
>>   drivers/infiniband/hw/ionic/ionic_pgtbl.c     |   19 +
>>   include/uapi/rdma/ionic-abi.h                 |  115 +
>>   7 files changed, 3767 insertions(+), 8 deletions(-)
>>   create mode 100644 include/uapi/rdma/ionic-abi.h
> <...>
>
>> +static void ionic_flush_qs(struct ionic_ibdev *dev)
>> +{
>> +	struct ionic_qp *qp, *qp_tmp;
>> +	struct ionic_cq *cq, *cq_tmp;
>> +	LIST_HEAD(flush_list);
>> +	unsigned long index;
>> +
>> +	/* Flush qp send and recv */
>> +	rcu_read_lock();
>> +	xa_for_each(&dev->qp_tbl, index, qp) {
>> +		kref_get(&qp->qp_kref);
>> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
>> +	}
>> +	rcu_read_unlock();
> Same question as for CQ. What does RCU lock protect here?
>
>> +
>> +	list_for_each_entry_safe(qp, qp_tmp, &flush_list, ibkill_flush_ent) {
>> +		ionic_flush_qp(dev, qp);
>> +		kref_put(&qp->qp_kref, ionic_qp_complete);
>> +		list_del(&qp->ibkill_flush_ent);
>> +	}
> <...>
>
>> +err_buf:
>> +err_hdr:
> Please don't use empty goto labels.

I will correct this.

>
>> +	return rc;
>> +}
> <...>
>
>> +#define IONIC_ABI_VERSION	4
> For us it is 1.
>
> Thanks

I will correct this and others in next spin.

Thanks,
Abhijit




Return-Path: <linux-rdma+bounces-2963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E58FF6E9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 23:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB1D1C26131
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60114F5EC;
	Thu,  6 Jun 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Fub/MEZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCBFC02;
	Thu,  6 Jun 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709551; cv=fail; b=eirBuDnObqMZfb2af4J+YQ9zji+trA+HBGwP7Fx1FXk2w3qk6JyNACVBiFN+EMs59phDnSupU2phGD/gpaztdoQbdqnonSz+MaamauIEtHylWaAHlgqJXMOKwQBCLPjH9a4uLW9Q+b+Ssl5nMZpDxgUzUF6hGeWcSw7AVl0KgJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709551; c=relaxed/simple;
	bh=WW+V09E3LEd/zPC1PdF8eSblD638noU0rSFm0LeaUZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oLwiiRVow9JMNfE1vkLYUn2+hD6s93bmW08/uWDMmZ5Lur70oPtJAtAzbe5StN0xa2jgTctggNaEQsDwjYUNtR0NqcOaGXhd9mC+Ix4wOC0tHiEevkuYIZ5POFNrvGFNpt5ZHDtYmClL8cmMzrCWfNM3i89LkpMsV13jwtFM/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Fub/MEZ/; arc=fail smtp.client-ip=40.107.237.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0Gw0d474E6NPWyHR/4iJMwl0ZoY2e9UZFHpJGT7+JQocjTuUJgsX92hroy8veN0AQnDicvuwm+Imx1wQtgL6X/ygunU54AqrDe/bA1cBpYyizS4GBtvVHujPLL1Pbw26tzd8RRsJXTHhVQLLAXxEw320WMI6ZXGl9Jh/o//EZC+dxQUypCs/PVxjjWKe7qM41yEZg2qHr8xsUhLd46MdwQ8WaBo9wifjm39Bjv4st51SFgx48QTYSqjxqE6nVEZ1ghM5Wx6RZ76TdVQaokO2h81yo0rgY+8JS0sXIbZj0zA0RWoswGrZiYSH67vOi4dpsm9/9TJloZvkFuOJ/C1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud0SQ5VnLGbuClqg4MfLJFhgyNDcECCb59euoOAV/Lc=;
 b=CywDnKbEZP627z5dIV5saWUgWxi8bVob2TGC01p2P7rWUb7l5wXrw0RVROTlHHCwIIW5ZLKcpnVL7tDxJg6fVIO0vmEIwxrTFyqsx9yrzO/O3IWXy7gK46MuG7x03eUtddrchF58LHGaPf8vVKGeV6QHpDzCdp1GaWj+VmCIKY+ByKbnvX64YwkTZgIfPbgX3sAkY6DweLMVeJ7Nzt57RtG5HVkzAPn53EGg/KVVpWWF6Lz5XUe+EFOQ2D+x4hVu6Lv5HAlBm+gMkhfkqmfwsiKqBYoKh3W7UjT7w7diUjmlChLYsVEv9EZ+vDMAzMfUqCmTJxGgbHxZgnHcuqJi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud0SQ5VnLGbuClqg4MfLJFhgyNDcECCb59euoOAV/Lc=;
 b=Fub/MEZ/kI5CCgmzVhNBsBNQdVVBUETaj9KUYdehL4s5GnEfXxnKkhOrS6Ix1HBbUNF3tEq77ht5Y1sNwZ+RJ5e2mYMCIdPXo3PbzRsHw1/8XkbEXALu80tfMJ5va4dZpD5hCZ/rs85IioQw0M5sz+NmJ1YrFpJ7puVoA+jG3cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by SJ0PR19MB4574.namprd19.prod.outlook.com (2603:10b6:a03:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:32:24 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 21:32:24 +0000
Message-ID: <0efcd0a4-569b-44d0-932f-5f81cf07b916@eideticom.com>
Date: Thu, 6 Jun 2024 15:32:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Enable P2PDMA in Userspace RDMA
To: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Valentine Sinitsyn <valesini@yandex-team.ru>, Lukas Wunner <lukas@wunner.de>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <285e6cdb-f765-4969-ab16-abc53ad66a95@linux.dev>
Content-Language: en-US
From: Martin Oliveira <martin.oliveira@eideticom.com>
In-Reply-To: <285e6cdb-f765-4969-ab16-abc53ad66a95@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D14.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1c) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|SJ0PR19MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 51be555c-1565-4ec7-8022-08dc8670280b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHZCSGpWU1ZmQlNhdHI2QWpMekFUQ0o5ZTdVczk2VGxPVUdhMTNDSWQwQ1Zq?=
 =?utf-8?B?clNBa1pyT1FXdnN6dzRPdFRJellTaitRaEs3cmVZczg2RkdwbUc0K1B5OFlU?=
 =?utf-8?B?cFNkYzRGS2MxU1BaczJyQ1p6VTlza2dhNjNhbWVUbVZTZnNxeXNmSVhRNlY5?=
 =?utf-8?B?TEw0eldCeHN4L3NHdERGMVBhTUVTUVRUZzZzMzBtSjZ0cnZIOGlYRWJ6MDFu?=
 =?utf-8?B?NGVTcGlONmRlRWZwN2NnT1YyN0pPUUhLcUxhRHpDRUcwMUVsbkZkMGVqU0ZO?=
 =?utf-8?B?Y2NKcFN4QkNHSUxJcis0RENpcTZFbi9OeTZNNUVmMWMzbW05VXAwOWJnOXRz?=
 =?utf-8?B?cDN5eU9Zam5qcXRIM01Ya0g2UnRrUHVxSGlwTVgyNTVDd09WeUNhZDNBK0Fy?=
 =?utf-8?B?blN2N1lqSTFONVl4OUxpVTRieWQrOVBaazVNaS9melhlb21oQjJ4K1B2U0x5?=
 =?utf-8?B?VkpFMWdGSHgxRWJsVTJ6MDFNNVBxSURxWXBadWRuanZWVWdBR3VxWDZmYUZN?=
 =?utf-8?B?UlpIL1REVDdmbTY0OFMxTkFSQ2FkLy9pK3ZWdm1JUzhTbW5FeHlNeGdRMWRl?=
 =?utf-8?B?ZGhNUEFsdG14d2hBTnE2bGxna3N2aEhLdkFYT2x5bTdZTm5jaHJEZkRGbTc1?=
 =?utf-8?B?MUs1Yk1kZlpPcm1RWUU2Ty91Vjd2cXhkSUFGN2ZVdFI1alFqcFF0SC9aNTFQ?=
 =?utf-8?B?MHlwam5JQlJIMkoyMkRkdy9Fb0RhbUIvNHYwWGVlYVljWW9UZkh0aldvcURG?=
 =?utf-8?B?TnNza2diRVRJaDIzTHlUU3liMUUwOFhpYmVaU2ovK3pCYmtXSVUyRm5Qcklz?=
 =?utf-8?B?cXVqUlo5bDZWSGV3SGFLZzR5WjV3OVNzT1ZMU1B2TngzeDFnTHlMY1dKU0dh?=
 =?utf-8?B?U2dhMnlnQW5nSkRKUTEydml0czJjSTFYMWhkUTNzbGNpcUlJblg3TDNtZjVx?=
 =?utf-8?B?M054OEJZM05INGNNRkpkSGEwSm5IMTUxVVptUGhYVEE4b25lSnVJNTBKQ2ZV?=
 =?utf-8?B?a3NOYytTK1IySHpqMnVjc2E3bzNrTTIxYi8xdXpYdHFaWjhoc0J0MjcwU1Zy?=
 =?utf-8?B?RXIxMmc2Mm9CWWtrMUx0R2pWY0hYVVdXSHJDMnlIeVJ6Yk84aDNmNWp5anht?=
 =?utf-8?B?MnE1ekVaNUJJOEJwN2NvcW1XM3Izd005bUpXdlVIRWN0TFZGZmtRMzF1UVp5?=
 =?utf-8?B?TnJBQTZlNGJ4VWdMcHY1Wk5HbS92MmpaVjgzV3ErbnBmcUhYM295OFlwS0tk?=
 =?utf-8?B?RWgwNUpZc1pyUExuSzBORnRoTjRJRFh0TGE0ZUJPWk40RUhnNXBjcDBmOVkv?=
 =?utf-8?B?Sm5DODlaeTZyTGpZUEpUL2VpMGhoeXhkSmNRQ3AwK1YweUdLdVVBVW85RnQ4?=
 =?utf-8?B?ektyVXBYaFl4V0tSdDRvUWwxcHJaTW1hQncvTEwvMWFWMEVpZmNsSTFob3FH?=
 =?utf-8?B?UkNRNi9xNzl3WDdNTDkxYkQ0VWJLZ1VnbVMvVGt5SGRlbzhVSUhjaUw0MFlT?=
 =?utf-8?B?OXlpeldJdXJTNGRlODZycXdxR0h5SUxsNkNRL2ErRXFvRERpWVhjZHNMbTIy?=
 =?utf-8?B?Y1VsTDJ2c2VScTJPNGpPelc5VFRIcnlxdUpHYjNOb1NQejRFWURybjBOTmNN?=
 =?utf-8?B?NDE3dlp0VzVmTE8yNXZsdFRoR1BGaUdscmtydlBRVlNKZ0graEFzMVo3YTlr?=
 =?utf-8?B?Y3B0aDJZZ0k1VzRhYkNPZkFlTy9kQ1lUVk1OdDA5ZFpLZkxhUVhiOVVQaEI3?=
 =?utf-8?Q?wnBU2s6J7zm23qxSgickv6IxBJyZCAqoOQwYD9C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNmQklGdFA3Wm9tZnR2TkswS0xrTUtLa2FjTzV6emRvVjFHSzhNT2hxeGx0?=
 =?utf-8?B?NVFCdGYyT2ZaQ3R0SUsvTyticHFCMWgvQlEzUjAzcm9lc2xORkFoZ3FVN0Nn?=
 =?utf-8?B?Lzd1Q3BZdkNvbmVoZ05rRjhtQ1hmYlVYZ2pIV1UraW1jQy9HMkJCSEhVaVI5?=
 =?utf-8?B?UmZYWmxpR1c2UXJBN2tEUnVnUG42S3BqTy9SQ1V1bC9ta1pMcloxZkpMY1h0?=
 =?utf-8?B?VkZqSHRKUjlpb25nY0Z2aXJwNHJGTUVVajltZUdlMDVweFhIU01TTVNsb3Mv?=
 =?utf-8?B?MHZFYklBcEgrbDhqajlUWElwdkNYYmhXM3FzVDFqRUJDd3F0WWlkV0pSMVRm?=
 =?utf-8?B?emZEVlpHRWxrYWFtNzh2YThjT3FQUnk4VTJBNFpEcXBlbllUN1JqNklPWGtZ?=
 =?utf-8?B?NW14YWYzdVowKzI3VjY2ZklhMnJaNElEa1VMT1FJbHFMQXhXbVJ3UjVMbFBD?=
 =?utf-8?B?c09tZ09JTTRFNy9hUWNkT3RyQ1QxYUNEbnpsQUJlaG1DVlYvTXpVcjloRjZj?=
 =?utf-8?B?cG5NcDhuVlJaRzRSZnNub3lEbVB2V0hlRHhUMUVQWVF0MkVYUmx6RFFucmo3?=
 =?utf-8?B?NEg3ZUpaNDRqQTJXcWRLWS9QS0VKSXJhbGIxZGtwdnlXMHdsRlNLeDdwcDJl?=
 =?utf-8?B?dlljYkFSbTA4ancwaDFQNVFKWHJBU1k5WGpLYVZsRkNkeEVuY2YzYlFLNEtK?=
 =?utf-8?B?bkVjWDdLcXZJdEVLeHdjeDBGeXZSNjVRNlUrQ21QQzJ3VmdtTitabUIxazA5?=
 =?utf-8?B?ZlVJd01XSkNXMHZtdmt6Q2ViOHVSVE9rbklQNmtuZGs3UWR2OWt2TUszS0xv?=
 =?utf-8?B?L1pzVHN4d29MY2prdWVOTDFhVlA3Nmw1SUdTKzJNRUJyRlBUTGZIT2tUTjA2?=
 =?utf-8?B?YWpBOTJkRGxIU0JyZXM4TU9maHVDZkVBanJkTkJ2bGViOGZwYVk2b0MwdGlC?=
 =?utf-8?B?T0JqeWZGVmZBRUM0NU5PZkppRmUwZ0owSkM2SmxURW1CMmQ4MFk0ZjJrdlEr?=
 =?utf-8?B?Vjh4bnROZDFMZjV5TkpuMnp5eXlUZ3FBT1NSaTkzTUh1NE1GSS9sMlVtS1NP?=
 =?utf-8?B?NjlXTmlaSGFUMUs0ZWlwWkdJc01sOHIyMmpUOXF3RDVPMXdsMC9oUGVkM3U2?=
 =?utf-8?B?SUVtKzJSaS90YVQvTS82a0ltUGN3ZWxteFZoWVUxTlJReEF3OFlQYlhiMy9u?=
 =?utf-8?B?eXNQWUF6REtQY0dTL09pV0o1SThtdmp3K24yZFI0T3B1MXlvTlkyekp0ZmpT?=
 =?utf-8?B?U2w1MDFlblp5amxDcCtwUWhuczM5NEJENWZLSmZWa2FVN01RMkY5UERmRVdF?=
 =?utf-8?B?Qm95N2E1WmR1KzlpdzBVN29ETVpBaUNQQ3JKWTN4eVBuMGZuS2h4Rnd4MG5Y?=
 =?utf-8?B?ZGk5MnhTWjBSZG84VjRheW1ZZnI3S1VyREZjRi8yenpwR3lGYVE5dFo1Rkts?=
 =?utf-8?B?YVVQeGNQeHFOSDUwbVE1NWFDWWZnMjE1VjA2eWtBUE0vRStxNjdMZTJjcENB?=
 =?utf-8?B?NkVHTUZQS0ZzN29oUUFLdDBvaXB5T3ZiczdldGFQRHpiNnpDMWF6TzNYMzli?=
 =?utf-8?B?Y1llN2JKaUdCdkFBMFZ0d1RqaFlTMEdOdktvcG5SV0RNVERqdXhRakxnS3p5?=
 =?utf-8?B?WTcvbUNIV3I2ZEh3K0pXMElJSjJma1FVZFcvK2hzMGp2TzJoMnNZU2s2VXNJ?=
 =?utf-8?B?aUM3cXp3RS9LT2phNTNOc25uZzQ3cEJBazJ0NUxBbFA5TWVLM1h1clVKVHkv?=
 =?utf-8?B?RlNqOStzRlFta1JJa2pEalNnVEwrYUYxUXpkM1lSRUY0THdJSE4wVlN5MURz?=
 =?utf-8?B?WXpzb2lpMmlXTFZBMDlNQU1nOGt4ZTZqRTg0R3hnQlBoYXBKREtCa3A0b3R6?=
 =?utf-8?B?S09Uck8rT2VWNHM4MVVxR3MxWHdzbHhrM2NTNVZqU014ODFHcDNtSHVPbjJJ?=
 =?utf-8?B?VVVlNzRvYWwzbStodXNaR1p2bnoxYkVVTHBxcGwrd2RReDFPdGtxc09Jam5J?=
 =?utf-8?B?QnRJdm96bDM2UXlDbW9BM2VXYnJvM3R3S1pJUFFSQlgrNU1wNVpZWXNSN2Z1?=
 =?utf-8?B?T3AzYlZUOVg2c1RudmZWNjBldmEzdU1saVR3dGgyRFZJdWlPVDV6d25FU3Vn?=
 =?utf-8?B?aHhwU2UvVkRWREZEQ0t5RjE2SUduYjJxWXhjelJHeS8zRXRKTzFQWndkb0s2?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be555c-1565-4ec7-8022-08dc8670280b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:32:24.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FJXVO/aRG9m3anZcbY2dXfT20WZMvnzcKZaQSmSgt8PpY8KxWsde4osPC6Z7YLIKpihsvCCSf2WrfptX4V55oyaHJTGtE/g6uPcWUjNAg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4574

On 2024-06-06 02:53, Zhu Yanjun wrote:
> On 05.06.24 21:29, Martin Oliveira wrote:
>> This patch series enables P2PDMA memory to be used in userspace RDMA
>> transfers. With this series, P2PDMA memory mmaped into userspace (ie.
>> only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
>> similar) interfaces. This can be tested by passing a sysfs p2pmem
>> allocator to the --mmap flag of the perftest tools.
> 
> Do you mean the following --mmap flag?
> "
> --mmap=file  Use an mmap'd file as the buffer for testing P2P transfers.
> "

Yes

> I am interested in this. Can you provide the full steps to make tests
> with this patch series
First start the server with:

ib_read_bw

Then run a client with something like this:

ib_read_bw --mmap /sys/bus/pci/devices/0000\:c5\:00.0/p2pmem/allocate <host>

Martin


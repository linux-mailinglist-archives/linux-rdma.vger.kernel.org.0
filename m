Return-Path: <linux-rdma+bounces-6854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6630EA036D0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 05:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE73161B2E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06E13BAF1;
	Tue,  7 Jan 2025 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FwrkusWX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2923A6;
	Tue,  7 Jan 2025 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222663; cv=fail; b=G5AAXTKR+tPfTD35SFXymZfZsSYHynQanmQlf+FYXycxv0KYP1mhsoTFc1FGThVamCfVI2Wqq1LgGX/o2qxxVlTJZ6Jbr6Ruwi+Xj722icEGypLUWyLY/bKMhEVQ3j8t66L6K/pItJ5OlU07n/0ntY3xDReRwNukdezrloeXviM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222663; c=relaxed/simple;
	bh=UW3hrGCOTiqRuP/iQwQjTLzYM3Y8O/IwbreicfSxULw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCRJhTR1+mcKS+MqMpipxyq54+ZUngdeUH+chkR3S8FSinDpshueU93/SpHyUFaf0HbYIxfv9onAdFBBAvjqa5jF/w9GcIVWPsm9EK5kRzupu0mvetWKjCLbPR9WmdW3/3+AVw5lk3Fsu3/6hUs29p6piVINFD93UHCL8K9gxgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FwrkusWX; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736222660; x=1767758660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UW3hrGCOTiqRuP/iQwQjTLzYM3Y8O/IwbreicfSxULw=;
  b=FwrkusWX1Jeu//yADYY6iNCOsihNwBNdh5R9kNg5tfTdeSVEoFSXHhSZ
   XbWWb7MFH/AX0kzXPMF15VXijn+zrB89ZcQRZvOE/St95vHBj3vZMSZ5w
   vVXkW5LDEXuOwygltRitPII9twNNYJsrRLGizTUYktjV1BwrXWH+G59vh
   ecgFbTgid1gIauUAbTe4Q6y8qpQjY6uEWo2Iv+2xpX+zbIHjpTR2q7UTG
   WppfRlKbzIM13TY5xGw1OnMw9JwwWBgFj5mi3ddnmo+6G01FuHckAjp1P
   uGXcUAeM6VHUmfrTkO5gWemhS3pvTI7BDnPy0Oz1QK2YfavfXBho2tKTZ
   Q==;
X-CSE-ConnectionGUID: zLQRRU1nTdCQSRurxpgSlg==
X-CSE-MsgGUID: c8MLHY5JSlaPK/boW588lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="148005519"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="148005519"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 13:03:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF8L+JAkyJW3Ve83JCKVxUOEVbzdRlRSg1Z30wtOWVvzXggagUl8LsfYJZtyljeNlzHY8EcMg/X4a7RYiMb/E0IaD4mpRO7FxAzcJRD5OfXWWOKnHfi44bPL15534DdhpNQD/f7DZK0SenIMJrL+oS/ihTRJMiF/Bz9YeCKy35eeWt2K6nCU3OqFs78qct3fHtwZukJlHHRrJLWP9IRHacLQxiqTcxb71hEmX+7nUQAmGwQ7YMqzjcC8WmY4s0xmfcERwURC0h6d8cRs6D4S7N4nsaSRREBc1wxQIjCNMW0rWhf5Mn57pCC8O/nJ5iPH7zb34kEsSlV5FKnwVlZUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW3hrGCOTiqRuP/iQwQjTLzYM3Y8O/IwbreicfSxULw=;
 b=l+lEVjHRBM3PEDMhVihAs8rF94wW5mhCMTYylz6xfFlQfYko9HazUDtC6nLTyOnfzDL5yMaQnYLM44zdwfXzRrDL7+y35Olozz25UfYITV8kA58coMpllz7woY9VnMm1CNtS+oGUza3syaq5q+Yr5KXBfeCAt+or/T9GYW2ji1KLo4d0+6PpFTEjLD7eNVZayFdgsUl9WHF/cyDjyNgps9rAnnYBtpbJZPsP8smp1idi1ecpgPlFGWzRTExqHvvSUebSzBb3ottcx6L7lJl8NUm/IRYy4G9AwJrKFjSbDaOREkxSMK9PhXwtZmcCkvW6LTJMvgnYfpZY4rZfuFWzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS0PR01MB5441.jpnprd01.prod.outlook.com (2603:1096:604:a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 04:03:04 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 04:03:03 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests v3 2/2] tests/rnbd: Implement RNBD regression
 test
Thread-Topic: [PATCH blktests v3 2/2] tests/rnbd: Implement RNBD regression
 test
Thread-Index: AQHbXY5SUgHQZ5Cws0qitbu3Lpn58bMKnduAgAAZHwA=
Date: Tue, 7 Jan 2025 04:03:03 +0000
Message-ID: <700c02ba-9ee5-4d1d-a315-60d00c242172@fujitsu.com>
References: <20250103031920.2868-1-lizhijian@fujitsu.com>
 <20250103031920.2868-2-lizhijian@fujitsu.com>
 <5ke3i3tbqiddjkihtv6whzvmq55uxftweqfbby5ks4qrtb3dq6@g6gkfg2ouxwh>
In-Reply-To: <5ke3i3tbqiddjkihtv6whzvmq55uxftweqfbby5ks4qrtb3dq6@g6gkfg2ouxwh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS0PR01MB5441:EE_
x-ms-office365-filtering-correlation-id: 7f67249a-3508-42d8-8f71-08dd2ed02f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWdIV0xCZUVCdUZFajNuSitGVWVJd2RQNGE1dW5FS0hmekQ2enBhWU9OWlBq?=
 =?utf-8?B?Q0UreDVWei85VE14WGpBenNZSTJJcVZNZjZOT2NqSFV5b1laMEdtcFVrOTBX?=
 =?utf-8?B?a1NEbHlCbHJqMnhXQ2NydENWYkIxY0Z3TWJqcU91NWNDdXhjRVZVWUZKVDBr?=
 =?utf-8?B?L2RTbWtHSnNkWjJYVkhVVjV1eWxPMldUb0FwQlNya3N2dDlVYTQ3OVM3dE9h?=
 =?utf-8?B?WWVxemEwU3BkQWpzSTltNjJTYnZtclJ5U1VDbHkvOXNkYW9VR3RTSUtUVDNh?=
 =?utf-8?B?M1pDSHZ6MlhTU0h0Um9lVkQ5UWJ2dEZkRHBYemVhQnNCcEVBdEhBRTdMWlZQ?=
 =?utf-8?B?TmVQZmFSOWxpUWNQbW1YVjRFN2hMd3JVaGJPbWg4dHZQYVJsbW4yNkExMzRi?=
 =?utf-8?B?MDBtVFV2bStacFV3YU5JUzFqNzIwb0NqbVU0ampXOFF3TjBMdGRHNUdxZkZJ?=
 =?utf-8?B?R01zQ1ZnMFRQNmFhTU5nRy9FVUhzUS93T3RiZ3VFYk1GaUtkci9xbFZ5VmxV?=
 =?utf-8?B?VVV3dWIweTVhNW5sdTJGS1pGZGFiL1p1aE90Z0xqMWVQcXZTZFNhOFV2a25N?=
 =?utf-8?B?ek5ORFcrQ1IwbFcyTGlmeHhyaGNoVFpQY0VaTWpldjBxcjhHNEdObFVhVEJ6?=
 =?utf-8?B?TmR6TnNEOVZiRll2MDdlbUFoTjgwaWpmQ3FtblRwcFM0MHlXZzJWMDBFRVJI?=
 =?utf-8?B?Mm5VeTlHQ0lUbEs2REJYdWFmYWlwYml5ZkdUOVNodXV0aVdYMm5UUGlremRj?=
 =?utf-8?B?ajY5cmNCVXhkeVNkbTBsZld4WVZiYkdLZGxybVVobHJwOThyakZwTklIZE8r?=
 =?utf-8?B?OVZ3U2hpT0ZRQVd5Tlo0SGFkL2VFb0dpem0vNXFkYnpLSm9jK1hRZzVBcU9J?=
 =?utf-8?B?UFNDaFk2NlJ1aUlXR1VqSlV5OGZkTXUzRW1qMk4yZEs2NVRaSkpsTUU3Skps?=
 =?utf-8?B?QUhLaUFjMG5VMFcvNEZVR0hpcm5kSm0rUlJwZm1lREh6VTBBUllqcGpLOTNG?=
 =?utf-8?B?dWNET2d5Q28xRjBSTFBKRUxJWkxhK1JIeXBBcW9sclZOMytlN1M0ZWhDSjVC?=
 =?utf-8?B?RnpZSjZodVRKTitMMXBxYVZJZEM0VGRnRjdJVWZEYURZU2lxRE9XRjRhWU1B?=
 =?utf-8?B?bUhvZ1JLNEgveXkwQ3RSMHZjaUpydmRHSXhFbHBkT3g2THNTSEd0d1BVM3l4?=
 =?utf-8?B?NkVnbGNPaEYzVGVpRnJpNUpia1phYUZWOEhMWWNoVXlEaE5ublF6Zy91WXpq?=
 =?utf-8?B?LzBJRGlxNWRTVjFJakh5MlErUU9UMkpPSnZsbG9oTjFKWnlqdzNVZXhESFJV?=
 =?utf-8?B?YW1kVmZwM3FEdlQvaWhUbWVJcVFrU3MyaWp0THdUTTlJbmw5VjQvYU4xaU1L?=
 =?utf-8?B?UGtiaE15dnN3aENwcFlBMU01Qlc3Z1Y0U1Z0eDNjUWp2RzBiZW55Q0FJbDFN?=
 =?utf-8?B?K1dWQ1lHY2tYUG9oR2Y3c1ZreU9jbVpoaW92R1dQbFZiZUFZUFNXcjdzbU1Q?=
 =?utf-8?B?TkRJMlBYUkVLNGs2cENNblVaYVd1UHRQcE9zcDlqOGFRQ01TbmlUVmEvWlkv?=
 =?utf-8?B?OUhkcWlvWXZIYlg0U1ozalZPMHdwY21VS280Ny9kNytUSGJDeURhbEV0QXBx?=
 =?utf-8?B?bUMzNEdHSjNOOGdLYXFCeFZSM2ZhTFZWbEtQcHRsVG9PMHZkY3YzaVZqcTZ4?=
 =?utf-8?B?NlVwajc0SURQQ1YzUXRpR0p6TFUxd0R0MmtERnRwQTIvRHBlVks2K1lMOFlS?=
 =?utf-8?B?bDIwL0dEMzBpM21uYzhUV2JoUmVZcElIRHg0cDdPamxPR2h1R0JSaHJSMVVI?=
 =?utf-8?B?UVl6K3lvandMYkpuNk9yMmpZTHhGbVl0M2thbWs3N3pWdlI4Z3ZKMFZQN3pS?=
 =?utf-8?B?ZUZHL2JoZFRyc00vUFdUK1N3OUJ5OFVVYmd0c1VDNUx6MzZ5bHZxY0d0SmR0?=
 =?utf-8?B?MzNqQUNyaDJRaXVzc0g1eThIWGVuVTFGTHlBVGJrYmp5Y2tJOC9hRVd0RUVU?=
 =?utf-8?Q?Ilk07ZO5TWAYxe6ZGGwE4dcXGQXvys=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXR1bDkxZldwNDE1Z3ZQS3lBREo0azBVaFZBSGhVQUVTVDllR2NGOWZMYUV2?=
 =?utf-8?B?cHNIamhINHJsdkFha1lRSGczT1ZOWm5RcE5kNUV4OWlUUzV2TjdtVUlCK3B5?=
 =?utf-8?B?SnQ0aThmWU1uMzJGclhMbG0rbm0yLzNzSnc5Rmc2aEErZ1BiVEl6ZEowVG1G?=
 =?utf-8?B?MWVWc3NEZmpac0UxL3A1L3JGRXVlWXZmSlAwZkpoTm5EWEZhVkd1YTVjQjNM?=
 =?utf-8?B?K1JHWVF2M3lUQWg4R2V6R3MrSGhiY2M5OHh0eU5vdzVVZVd3Z2xZc2svNGVm?=
 =?utf-8?B?Um9yRFkvK3YwNWEzSUp5VmxCcUQ2R3oySWppbk1ZMFZ6K1I2NzEvM1RmN1c5?=
 =?utf-8?B?WXEvTEFiY0hDVHJoOUVKRnJYc09NWWlGZ1dXS1B5U3JBTExwWW1DWFBheVkv?=
 =?utf-8?B?V1NIWmcvanN3U1JDdzdreEwvdXNSUDZUUStoTFR1VTdVRzhQMGsvYWgzUlJa?=
 =?utf-8?B?cXVoU21FY3U4VG8rU2FqMkVBVytaUE5MYWx0eHRIU0JqL2dkRXoycG5OcUpz?=
 =?utf-8?B?bER1R1NGSm5LU1FhU1o3UWZTUVZieDRGeXVVbWRaSjNvYmVsT3AwczVzOEg1?=
 =?utf-8?B?UzNuM3FWaWtZQnRMajlWVVV5NlFERTI5eEh0c1FkVk5XYUY1Rm1tb3J0aHJ5?=
 =?utf-8?B?YnFZTEtvVnpHNVc2akY2YVkzblVVWngvQjBaZDFUOWZ0eWlCWEdYdS82OURJ?=
 =?utf-8?B?ZVJnTHBaUWlqdnB0K0ZXalFEZVEyYlFjY0lvU0JwTzhlUUNvU2lNNE9LY2lk?=
 =?utf-8?B?ZmRSYnpsamZxMEhYc3BsYlFrTWFxZ2pXTFBUMkphRmIrNlFGL1YzdnZpSUFj?=
 =?utf-8?B?eGZGUHAvamt5TWpGT3p6REFROFRSSzZFS2FGVVNoc01ZaTVDVndKWUZXWFlB?=
 =?utf-8?B?UW8zckZRSXA0cmduRUtxQUdNZnp1MEdJdmxXcTBNdFpSWDNzTDNsNEIyQ0JT?=
 =?utf-8?B?RkRDdGo0MGtZOEhQb3JGdjJKdng1bjhjb0dQbzFoZy9mYStwWk5lVEpCak9L?=
 =?utf-8?B?WHdKZFV2MHozS3JTWktsT0RXNlNROUNqSXBkNUpWbzNBTDg5dzlhcTZBeC9q?=
 =?utf-8?B?dHJ1dEp1UHNyaU9Bd3o1TXQvWjdsNnlFM2M3Zkk2ZjhUeE5tblkxTkZ4TjU2?=
 =?utf-8?B?MGFpS2lMWGUrUTJJcWJNNnJnQVNxTDFmT2xEandiUUtBU2NYZitVb0tmV0d0?=
 =?utf-8?B?R2hzek80RmpOYStITmU1a3U5cUZGU2svNmJmSWJzZ292azFyUVU1MFkwcjR0?=
 =?utf-8?B?Smd3VU0vUHJwbGVESDFLQVM4S1VxYmdNQ2tGR201SlNLK3VBK09KN2xhYVk5?=
 =?utf-8?B?OUNWRWNPRmtpaEJVd1JITjJFeGtFVzNPS0VQTHJ6SzduNEdKblRXSVV3WjNS?=
 =?utf-8?B?UGkyZXp3TEVHbVNwUSsrSHNLeVJWdDZlb3I0OHNPcTc2UkpZbThBdmpCY1k1?=
 =?utf-8?B?ekVjRHRBUUI5d0lkajNPVXI1c3dwZkV1UWIwTm0zRDZ4YlVCWEhIbStrdXVt?=
 =?utf-8?B?anRFVjJzeGZrL0QzUjREdmt4TmltNHJKbzRwWEU0STl5bXJXZEk5N1NDd1dP?=
 =?utf-8?B?UkwyREtIdjdaYmNleU1yWEQrajVSYnlVOUttcElybkFjMEpHRTFBVG95a2Jr?=
 =?utf-8?B?R1B5ZHZEWGh0eWg1aHZaam0yd3F0STJhRUJFeXVOT3RpWVVKeDJkcDFnVUdF?=
 =?utf-8?B?d3VLLzNXTWM2Vzd6dGwwSTFsZndCZEJQRStSVDBlZDNtMllJSURFZVBJSUxO?=
 =?utf-8?B?LzNjMFdwR281L1J1TnZkdlhlUkFzakhrTGt4SXpCSkN0V1E1UVVDSEt1eGcz?=
 =?utf-8?B?TUMrQ1ZWY1NIQVFySHlSOCsyK3NEaWFuYmRmVTNmTWU4U21nZ1lKR3dpUzh0?=
 =?utf-8?B?NGVDUmh2RTBBcThTNFRUemJKZnlpRWdQK0h3d0NPTHZRb09vSnBTVjVUbkJC?=
 =?utf-8?B?ZFl4QWE3MVIybVJwdUJRTXZZYWdxOVlaVkpVbjhkYTlLb3doQUNqMVErQ1VP?=
 =?utf-8?B?Z0FIMCtCUVd1WHcyS0NQaXA4b0pXM05tMjd3YjV3QWF5RCtody95Z2tNbEhq?=
 =?utf-8?B?N1dmcFdJUk5JejlzY00zM2xoWWwxL0swYXpmUWlUSk9nZ2JWNzNFY05FYU56?=
 =?utf-8?B?U2pqUy9EZ0VLVjBFd3Blay9NWllnbnJQeFZWUXJwbG93N0pvVE1vUWxwYkln?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <386030D71F6A12419D7BA8F6B61F86E7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y2iiM8wLVWBP6xWmbvSLTUIdXBCk80LDVZ9+QFe5+qOfKMwe1E8aKMbheiJjAZ+sCoJjGKlUco0Q6sECm1qhZDauEgKf7NgIyxx+NsqFxFf56z+ZTQy+d7ky7mK/wzP2s3rTPSRsZ4z5cZpIgp0be+nDvwgwWFpNIOpAZ1zKA1n5b6YFJNsDiGWgEv46FcZWVxWlSel7AtFbJs1kKdTuaVSYZl3K9T84vGZEeshoAK2OMM/i0FjpjEPEeTVLf67auEGkrJBTNX8y0e3uDITfYZyzDQbgjScM48qB6HeroeKW+CtuaPy9R7C0wynfWHTYgLAnXVFrR62jXDDg3HFanof/yFBRTYN9YGqdOCU+yfPoh4fVbd01KLq9FD2IK/fn7dPIWqdw7h55PJI4OdFL9oNWbneE5WWtwoAiojsGArgwjgMcfjXzErsWdeQnqF5GnPaeyqtSVDbaQWocEYtPsAnn49JWLdw8FIpiW73lMj/sXnpLDVUeOqXgDw9o3TDL4bBBTIAURs23Z0p8suaL4TQPKpxEp+2ZG3u8TSpDHGeZF1OvZ/k2mERxTCXrT+8WrB+wMuQJ5zjbvbWNL6JcJabLlyP6C+uj2jnGxStjDc8eLfFgl1qXfUdueT7vdlTj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f67249a-3508-42d8-8f71-08dd2ed02f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 04:03:03.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTnDq/DKJqNwDLAVHeldp3t8/ZM5tte32P0Fxbp51Aqx93haSlHXJX7rlknByYBM8Dqh9f1KY0Mv/z5+RKJTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5441

DQoNCk9uIDA3LzAxLzIwMjUgMTA6MzMsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IEphbiAwMywgMjAyNSAvIDExOjE5LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gVGhpcyB0ZXN0IGNh
c2UgaGFzIGJlZW4gaW4gbXkgcG9zc2Vzc2lvbiBmb3IgcXVpdGUgc29tZSB0aW1lLg0KPj4gSSBh
bSB1cHN0cmVhbWluZyBpdCBub3cgYmVjYXVzZSBpdCBoYXMgb25jZSBhZ2FpbiBkZXRlY3RlZCBh
IHJlZ3Jlc3Npb24gaW4NCj4+IGEgcmVjZW50IGtlcm5lbCByZWxlYXNlWzBdLg0KPj4NCj4+IEl0
J3MganVzdCBzdHVwaWQgdG8gY29ubmVjdCBhbmQgZGlzY29ubmVjdCBSTkJEIG9uIGxvY2FsaG9z
dCBhbmQgZXhwZWN0DQo+PiBubyBkbWVzZyBleGNlcHRpb25zLCB3aXRoIHNvbWUgYXR0ZW1wdHMg
YWN0dWFsbHkgc3VjY2VlZGluZy4NCj4+DQo+PiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcmRtYS8yMDI0MTIyMzAyNTcwMC4yOTI1MzYtMS1saXpoaWppYW5AZnVqaXRzdS5jb20v
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPj4gLS0tDQo+PiBWMzoNCj4+ICAgIC0gQWx3YXlzIHN0b3AgdGhlIHJuYmQgcmVnYXJkbGVz
cyBvZiB0aGUgcmVzdWx0IG9mIHN0YXJ0DQo+IA0KPiBUaGFua3MgZm9yIHRoaXMgVjMuIEluIG15
IGVudmlyb25tZW50LCB0aGlzIHRlc3QgY2FzZSBzb21ldGltZXMgcGFzc2VzLCBidXQNCj4gaXQg
c3RpbGwgZmFpbHMuIFdpdGggVjIsIGl0IGZhaWxlZCBhbHdheXMsIGFuZCB0aGUgaiBjb3VudGVy
IGhhZCB2YWx1ZSAwIG9yIDENCj4gaW4gbW9zdCBjYXNlcy4gV2l0aCB0aGlzIFYzLCB0aGUgaiBj
b3VudGVyIGhhcyB2YWx1ZXMgNSBvciBsYXJnZXIuIFdoZW4gSSByZXBlYXQNCj4gdGhlIHRlc3Qg
Y2FzZSwgdGhlIHBhc3MgcmF0aW8gbG9va3MgbGlrZSBhcm91bmQgNTAlLiBJdCB3YXMgaW1wcm92
ZWQsIGJ1dCBzdGlsbA0KPiBub3QgZW5vdWdoLiBJTU8sIHRoZSBqID4gMTAgY2hlY2sgaXMgZGVw
ZW5kZW50IG9uIHRoZSB0ZXN0IGVudmlyb25tZW50IHRvbyBtdWNoDQo+IGFuZCBvdGhlciBibGt0
ZXN0cyB1c2VycyB3aWxsIGxpa2VseSB0byBzZWUgdGhlIGZhaWx1cmUuIFNvIEkgc3RpbGwgc3Vn
Z2VzdCB0bw0KPiByZW1vdmUgdGhlIGNoZWNrLiBJbnN0ZWFkLCBob3cgYWJvdXQgdGhlIHJlcG9y
dCB0aGUgaiB2YWx1ZT8gVGhlIGNoYW5nZSBiZWxvdw0KPiB3aWxsIHByaW50IGl0IGxpa2UgdGhp
czoNCj4gDQo+IHJuYmQvMDAyIChTdGFydCBTdG9wIFJOQkQgcmVwZWF0bHkpICAgICAgICAgICAg
ICAgICAgICAgICAgICBbcGFzc2VkXQ0KPiAgICAgIHJ1bnRpbWUgICAgICAgICAgICAgICAgICAg
NTEuNjc0cyAgLi4uICA1Mi4xMTdzDQo+ICAgICAgc3RhcnQvc3RvcCBzdWNjZXNzIHJhdGlvICA5
LzEwMCAgICAuLi4gIDEwLzEwMA0KDQoNCldlbGwsIGl0IGxvb2tzIGdvb2QgdG8gbWUuIGkgd2ls
bCB1cGRhdGUgaXQuDQoNClRoYW5rcyBmb3IgeW91ciBjb2RlLg0KDQo+IA0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3JuYmQvMDAyIGIvdGVzdHMvcm5iZC8wMDINCj4gaW5kZXggOWViZWM5Mi4u
MWQwNTk4YyAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcm5iZC8wMDINCj4gKysrIGIvdGVzdHMvcm5i
ZC8wMDINCj4gQEAgLTM1LDEwICszNSw3IEBAIHRlc3Rfc3RhcnRfc3RvcCgpDQo+ICAgICAgICAg
ICAgICAgICAgX3N0b3Bfcm5iZF9jbGllbnQgJj4vZGV2L251bGwgJiYgKChqKyspKQ0KPiAgICAg
ICAgICBkb25lDQo+IA0KPiAtICAgICAgICMgV2UgZXhwZWN0IGF0IGxlYXN0IDEwJSBzdGFydC9z
dG9wIHN1Y2Nlc3NmdWxseQ0KPiAtICAgICAgIGlmIFtbICRqIC1sdCAxMCBdXTsgdGhlbg0KPiAt
ICAgICAgICAgICAgICAgZWNobyAiRmFpbGVkOiAkai8kaSINCj4gLSAgICAgICBmaQ0KPiArICAg
ICAgIFRFU1RfUlVOWyJzdGFydC9zdG9wIHN1Y2Nlc3MgcmF0aW8iXT0iJHtqfS8ke2l9Ig0KPiAN
Cj4gICAgICAgICAgX2NsZWFudXBfcm5iZA0KPiAgIH0NCj4gDQo+IA0KPiBbLi4uXQ0KPiANCj4+
IGRpZmYgLS1naXQgYS90ZXN0cy9ybmJkLzAwMiBiL3Rlc3RzL3JuYmQvMDAyDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDc1NQ0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi45ZWJlYzkyN2RiNzINCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL3JuYmQvMDAyDQo+PiBAQCAtMCwwICsxLDUwIEBA
DQo+PiArIyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4w
Kw0KPj4gKyMgQ29weXJpZ2h0IChjKSAyMDI0IEZVSklUU1UgTElNSVRFRC4gQWxsIFJpZ2h0cyBS
ZXNlcnZlZC4NCj4+ICsjDQo+PiArIyBDb21taXQgNjY3ZGI4NmJjYmU4ICgiUkRNQS9ydHJzOiBS
ZWdpc3RlciBpYiBldmVudCBoYW5kbGVyIikgaW50cm9kdWNlZCBhDQo+PiArIyBuZXcgZWxlbWVu
dCAuZGVpbml0IGJ1dCBuZXZlciB1c2VkIGl0IGF0IGFsbCB0aGF0IGxlYWQgdG8gYQ0KPj4gKyMg
J2xpc3RfYWRkIGNvcnJ1cHRpb24nIGtlcm5lbCB3YXJuaW5nLg0KPj4gKyMNCj4+ICsjIFRoaXMg
dGVzdCBpcyBpbnRlbmRlZCB0byBjaGVjayB3aGV0aGVyIHRoZSBjdXJyZW50IGtlcm5lbCBpcyBh
ZmZlY3RlZC4NCj4+ICsjIFRoZSBmb2xsb3dpbmcgcGF0Y2ggaXMgYWJsZSB0byBmaXggdGhpcyBp
c3N1ZS4NCj4+ICsjICBSRE1BL3J0cnM6IEFkZCBtaXNzaW5nIGRlaW5pdCgpIGNhbGwNCj4+ICsj
DQo+PiArLiB0ZXN0cy9ybmJkL3JjDQo+PiArDQo+PiArREVTQ1JJUFRJT049IlN0YXJ0IFN0b3Ag
Uk5CRCByZXBlYXRseSINCj4gDQo+IEkgdGhpbmsgeW91IG1lYW50IHMvcmVwZWF0bHkvcmVwZWF0
ZWRseS8NCg0KR29vZCBjYXRjaCENCg==


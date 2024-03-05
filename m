Return-Path: <linux-rdma+bounces-1288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DE872A7F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 23:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7269282483
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DA12D208;
	Tue,  5 Mar 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e03yz/5i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oiAJ81CS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBE43AD0;
	Tue,  5 Mar 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679570; cv=fail; b=RZimC5X0mJ9kLZjwYUAUSD0q32LOi4J8NX6UEBGbV1UkI6CTdLTAJVjlDcNswH4lDYGFsamAjyEeu+aR2YryzXp2wv52h3aCCSQDWQxGVvFLZFVgb9169sKMRi08xwWwylh3wikQQPO4ud7xYO8uRtTdG5RqmLBBqCIM6Y8v8gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679570; c=relaxed/simple;
	bh=IrZQ/X/T+n9JWpTPnPFbQ9pHjkOqcfR2OJaMHsa7XIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AExiZyVsBpq1Ahj2QZ67t76MBmIu536p74YurXs+3VMtXn/giC9QzFJdRarA78IqUNJ5yPvdxI9W3nPFgZpKCh6NG9YKjbzXyfAAm40jte/irkv5S36ffJhclHWMt+BOZqSXgSlvNX+ZZiw8yfrjEZrcFmmM+KlyJYZpMI05/1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e03yz/5i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oiAJ81CS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425Kqpfw005091;
	Tue, 5 Mar 2024 22:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AqpF4n/K6yZ/WOPeyf0Am/EDQMDeqH4Gl0FB59Jayy4=;
 b=e03yz/5ilAy+fxaY5WG0xThELbG/vvW+jeam7JbKAFhLmxBGkB5ZdHPJmgZmkkMGpRXQ
 +cz6U5DsuFj3GpwF++CDEx5HoVFMmZcRjsWzGgVjUZ8qmLuT0nUSOlFEPtIHHh1NfRrU
 uprwfJBbHsU+OXELxDnWBHRDvXHjp08HCH82f+ATLlz2Y8svRRfvkDJJTIfMpA4aXx+A
 TwpabxFFiRHBGmxbCe4+xvPywHnGddH+9NOpAfOqikLpqt4OWTURikfGg/PPEu3yHpUP
 o4Hg+WX4vZDKpbp9xRy6mctYvysllTBD3SGYZmvR+5l3mKTPF2BxtTMKkm0Qr1qjTkEG cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dfnse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 22:59:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425MjEe2031924;
	Tue, 5 Mar 2024 22:59:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj8nc42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 22:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq/pnMalX6hS4cyp+8sZ1UHJx4XnRB3uROLBClR3LkcHdbsof6LB8jp4FTTgio6Vj3cp8Cb8a4u1ObdjRsK2uJQHvTM7gGTlChkcRkBgVUO/6ew5OJAchc4FSUKqXHpvBfAk09dhGKIvDbfG9B9/VrHAcdkD+I8ZHfOGakszDGSD++2IIhTlIGfzcAoABrh5Cj48wYdrne5Q+u26ftz5s1HH7SCWR8LKLqq9C/mxirstnvCXczCNAKPjqch+6B20ZB5qDHUA3hSf3v6+NQB9LFwi3DM86Ol2HhKl0ZF/4fLyCHkVH6goWz8EvtGK/U20sNEKfcSmb0V0cn5EMlkm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqpF4n/K6yZ/WOPeyf0Am/EDQMDeqH4Gl0FB59Jayy4=;
 b=dSuaDRJsgGhUfT6mUKOa/sWUHe7mEdrfghOa7ud7waudDLZbuksEEB4FqfUkPnsszJYsy5RKxA7uox/kD41uLi7BT5x5/gZnGM5xFcogCTBHuk7iVdDlDsjjabzU8QmxNkng5z5y8fNsxabxQG/4kcZ74mOxp3/OKi+yOoWNz7pcKZWDfFKX39ur9UNRjfXtCnlf4xkeevSCpQApY63tI9bsAujaH3Vex/zrqFasha+/FGGXNHWmRlxoJVdrtOsVcxGVBPMyW+Gr8AQ4EfSerYgGGIc1QsI7N6aHEBt0164ar2jqUjE2c5ki9I+6jRlIonjDbAH/9CQ+DVunY/hFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqpF4n/K6yZ/WOPeyf0Am/EDQMDeqH4Gl0FB59Jayy4=;
 b=oiAJ81CSLE+IlVWbt3Evs+7NzadiLmPRkR16A79KVEyhcP/HoDnsDDc+8TSZL9nQMOjSm85LFangH80wdn+cGrvdBXsPRgWuc9iZopUok1f54Nk0g5JIJ2YDYAkvIDiXBAYX1d4Q7KwyarmKVhwedHeD1Zm2tpAOffYY/+GEK+c=
Received: from CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 22:59:13 +0000
Received: from CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75]) by CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 22:59:13 +0000
Message-ID: <8265fa8e-3de1-444e-8f58-ec60c79d6a9c@oracle.com>
Date: Tue, 5 Mar 2024 14:59:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] RDMA/cm: add timeout to cm_destroy_id wait
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
References: <20240227200017.308719-1-manjunath.b.patil@oracle.com>
 <20240303095810.GA112581@unreal>
From: Manjunath Patil <manjunath.b.patil@oracle.com>
In-Reply-To: <20240303095810.GA112581@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6216:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb28b51-c5c4-46e9-3fa4-08dc3d67e06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O590X4/mf2HjgmfU77PIChO3ymTfoXVympSuqSq5qKhQZ5gmTXBG1RVSMOA/xff7Ik4eInCCdJuvsy9zWPLaGrGz7gm+jrpg9OW/ujbBER3s4XGKE3HEspg/5pRX1YgHjHvk1J+Rkqs5Fg6xeEclvkV9Yo/FbNsCYHpSBiZN/Q6UGnj5c5Aa/9ezkoDXTDxLvUVhBexnPHNHH5va/IXVMyjHP1aZPsOamWzAM4GbNlaiUTHoYyNmo2eUiu7zeGLidNPHzCR5lom14I2SGCe+2TLzD1rIXuLggC910JQFPjUF4/a6kDz+R8eRWYonNg5b8WJOfoxDAgzJ99zUah7e7WLV/Gn3KVroxhG09iNwhyfK5NsgE1IeU6VWtloReJaZPQmlmspHEKpLE14EoYwds8V9JnkFv44g7d7wc6p/AUxfHA9cuJYRvoYPwVol5O0uJO/BVQxIm6ueoA47Nn/Y9M+0Nx0gpNZgTerr98issyKXr5mzPXmiw7TXadPZfaXRint9edVCIkKHYablt9vTltiQuVjDZLznhTQ7ZedvR1+7R2ff4vj0xtSGDlKJdrEs1xcGPNbd6aZhLmdv7iuU6wcy1gGV4T6MbWW4Vk6FiMzKk9Eaacy+mamYs8Yf9kzlnZ17UufBhtemd0gazc42aCAm3s4MxWI5wCUQIUTv614=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6216.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ditGS0dEU0pMRkNscjZLZGZvdWJnUWl4WmNIRDNzR3JsZjhGQWprdHhqUFdU?=
 =?utf-8?B?SThKMkkwS0FhWW1TTUhtbVZkVm1jcVRJNkpTK2JJNVpMTng4RGdzbk5EVjhU?=
 =?utf-8?B?RkZiZ3BEMXJTdU9rK1ZnM2hlU01QZjlvdDJBZnZqUHU2QWhKWmlvMEVPYjhy?=
 =?utf-8?B?Zm1CWUFiY0M1MHlHd3drZVdUQzF5eHNVTC9nNmd4SjFMS3JSTVVNQUNDUVdC?=
 =?utf-8?B?WEh1bmh1eU1pZjAzY2o2eVVQckhBSnRvWWRCb1BsYUFBN2I5aGRheVlYcE9Q?=
 =?utf-8?B?UEo2MWIvRHpvTEpNNnVIWHlkeGl5Z09CV3hBVjFxVWFnMFJUcFd0anYvSVdx?=
 =?utf-8?B?bHZmT0dXcEJ4eENMVENqRTlrbk1lODJYbkRiZ3FPaVFscjZWdWdFQXQ0dUlw?=
 =?utf-8?B?S2YrR0xoWUtra1ZvRlRKa3ZGRXdnWW04VWN5MHNOdFZpL29hSG5GYXN1RVcv?=
 =?utf-8?B?QlpFZHc4TDdVZ0JYVm9adDAxUnFmTCtHUkRGMVJtaHBjeGkzTSswSkRQV0di?=
 =?utf-8?B?bkxCOHYzYWYxWHhiK3NQTnhmMlVCeWJJRFNoOWpkTkJFdFRLcHJ6MTg5N2tv?=
 =?utf-8?B?T3RwM0JpdDM3cnZmQjlLV2ZtQ0tJY3ltWi9Eb0xjNU5MK05TbnNrWU9ha3hC?=
 =?utf-8?B?dkVPNHQrY1pNU3BWU1k3NXZ3WmNEVmFLQjZleWsvcUZ0SlFwRm9iZGV5ZVRB?=
 =?utf-8?B?NUZGRDJ0Rm5FN3AwRTA1U3JWNWo2RGFNMUdWYnlPY1RmRFVNbHFRZzkxTHVQ?=
 =?utf-8?B?RmhzYjJHUzFzQWJCcGtEb0w5ZGJzR0x4aUM5eEU2cmxUbkhpNWtHOE5qN3VS?=
 =?utf-8?B?Q1h6THZBR1BKd1pGUzFjSS91bjJ6S0hrdEpmUE4wbkxvSm0rQjRqQXVEbDBi?=
 =?utf-8?B?N2huMTdMd2huNE5iQkJsNk1nbUZka0twQlM5OWlkNkpwK1AxOUNKZ2xLU1o1?=
 =?utf-8?B?eGlONWt2WEtRb0JrdVBlZzJZNXFmVWxETmE2UFdiZE9zK3RjMjZPTmZ6TjZI?=
 =?utf-8?B?bmJNQjRTdzJ1eEZYeC84ZGJMcGdFbStWdngxbWowbGUzRnpvM2ttaGpPU0tu?=
 =?utf-8?B?NGUxZHdPcktGTHdhWVNtcjlHUHA2WXpuNHdKRFlibzFVL3FEMnZXcEtQTGxx?=
 =?utf-8?B?Wnlud0c3MVhWekpsZHl3dlV3T0JibUtZbFRZU1Y2S3R1TzRrVkxRVytxSVhv?=
 =?utf-8?B?U1NxcnlBOVFuQUlEeVZDYWZaZEVSTUg3dm1STHVQK21IRm9ES3ozZThIQUt4?=
 =?utf-8?B?QU04TmRMeWpMQUdhZVBjVEJJUC8zR1dwS0plQXZvOWFtaUQ4OWg0STQrWGpx?=
 =?utf-8?B?NWRzNGV6UkVwcVNkT3IvUHFtelVReWFoR2pOTDg3NWJZV1gxc1c1alJZU2l4?=
 =?utf-8?B?ODh3K1dLY0RNK2lFVWo0UHljOWEwSElHZmlVMmR5ME1LaHBheEJVV1JEOXJt?=
 =?utf-8?B?cFhMb0ZFa1d5U3J4OTg3NG9NNTBCOXV6bGpaZ1ZVRXZISW04THVUTGkyOXly?=
 =?utf-8?B?aVVsUEZTZzUvaEZRM3FpZTdaWEg5aWhiYUhRNlhudGZUdzk0dklBUkE2OXZI?=
 =?utf-8?B?VWRiM0JqZ1lUZ0NZTno1ZStScXl4bUlyQXZhNU1pV2xDaFpDczdDUkY2UU0y?=
 =?utf-8?B?RFlmc1ZxUEZzV0ZZMnJiR0ZNN3M5ZVhxUzVheVhvMndRMjRmTThWbitIK3F4?=
 =?utf-8?B?dVk4ZHNGRitiMjE4TmVpRmVIR0FRT2F0MzFidHlUMUpiZjFRc1RNUFRyRHNn?=
 =?utf-8?B?UXZkbjJhOUs4OWczRmtES3Y1ZXBxVW9tNGV6ejdpaXp6b2lEUGF0NDVIZ3hO?=
 =?utf-8?B?SnMzUVk5YnFRR0JvMy9iYXh5bDBXbDZ1cU9HWG1sWlFPKzc4Ri9STVZvQ1FE?=
 =?utf-8?B?bU8ySkgvY04xOWVEU3ZxS1hQTHVJU0NvMzZPQ2NTZWg1Z09IcXdRZllwQlFP?=
 =?utf-8?B?eWVNTkc0STIyQ2dwd09Ddzd5dE5BTjVFK3JJZW9NZkwyeGYxUXBWUUlDeUp6?=
 =?utf-8?B?ZDU4ZkdaNHFobTZ3ODFFMk5wZVpFNDR5Q0N6TGNxUkVLU0NVSXpZTWgwRHBa?=
 =?utf-8?B?QVBYbWpEU3JrWmZLMkZOUzJIRCswbFJQQ2t5VVRYOWRDdlVqdDA5OTJ5TkFS?=
 =?utf-8?B?MGR5TktIelV5VTVyVG5QaE5ta0U3SVYyQk5vUjhrSTQxeG5LRUdPbVdMRlpL?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zik2ObY4Se0PvWrQdevn5cI5o7vKQn5JBewzmLeK5vn4blZxWaxCfSc22ML7UTOJY9m6IQvGDwmCrMG7qe+ExVht9oqln8MWdcJ4vp1kCjrY4pRlxFGlwDSIVJJS0+4JSish+ES4IlsF8wNQVnBTGYJj/ppw4RrOQI6xV/6I20yHZM8OhJwTz8f1aRoL74EYT2Wvf2/YohLaFD8NH9rYrtNVFHncsdVdA2aSAbFIDKoqsSaoCcAmdoMobt1TyNWXYWslGYRs71B3M7gZ+5eKx1pU9IkY46cuz6uN6kAnmfftJXg3rkFenlePxLtyNlWY3gj4NXhmmC4w108ThlaqEQbDUpvmQ+N/QxUlgY0en/U2kPbz5rlu46mIAnijO64FMj+icOiXxitjpkBZJpnNcPHFtbsZhyDqwmxOspykmJdIHy591uwyEA9sdoXFyd9yCPCT4xUbBXbS2AUM/YBR8aON4X3VW3pR5HI3rQdNr5AxJFSijnVtUrlEIzxjP4kVAvWGrxf8YM3d53CGfGck9G710R98NPYzoWdT1+A7mhvu1oNfWSr6IITaNiSA1cCfHTXIiSI981FuNV09WUqueJMJi2sEhN1hySo983jkIOc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb28b51-c5c4-46e9-3fa4-08dc3d67e06e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6216.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:59:13.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7nlZxP+fA9MuN4Yyqa+7U7qE4OFoce8qwV4VyNgwjq0cd7rn0h8WxL9tu3pdFEtENMi+qCOKpFdTdT2UHVBC01z8Yi9X/XiQaeimnIjLXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050183
X-Proofpoint-GUID: VUAG7Mh6yMS398lqdJ5J8CAYwBsuW0T5
X-Proofpoint-ORIG-GUID: VUAG7Mh6yMS398lqdJ5J8CAYwBsuW0T5



On 3/3/24 1:58 AM, Leon Romanovsky wrote:
> On Tue, Feb 27, 2024 at 12:00:17PM -0800, Manjunath Patil wrote:
>> Add timeout to cm_destroy_id, so that userspace can trigger any data
>> collection that would help in analyzing the cause of delay in destroying
>> the cm_id.
> 
> Why doesn't rdmatool resource cm_id dump help to see stalled cm_ids?
Wouldn't this require us to know cm_id before hand?

I am unfamiliar with rdmatool. Can you explain how I use it to detect a stalled connection?
I wouldn't know cm_id before hand to track it to see if that is stalled.

My intention is to have a script monitor for stalled connections[Ex: one of my connections was stuck in destroying it's cm_id] and trigger things like firmware dumps, enable more logging in related modules, crash node if this takes longer than few minutes etc.

The current logic is to, have this timeout trigger a function(which is traceable with ebpf/dtrace) in error path, if more than expected time is spent is destroying the cm_id.

-Thank you,
Manjunath
> 
> Thanks
> 
>>
>> New noinline function helps dtrace/ebpf programs to hook on to it.
>> Existing functionality isn't changed except triggering a probe-able new
>> function at every timeout interval.
>>
>> We have seen cases where CM messages stuck with MAD layer (either due to
>> software bug or faulty HCA), leading to cm_id getting stuck in the
>> following call stack. This patch helps in resolving such issues faster.
>>
>> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
>> ...
>> 	Call Trace:
>> 	__schedule+0x2bc/0x895
>> 	schedule+0x36/0x7c
>> 	schedule_timeout+0x1f6/0x31f
>>   	? __slab_free+0x19c/0x2ba
>> 	wait_for_completion+0x12b/0x18a
>> 	? wake_up_q+0x80/0x73
>> 	cm_destroy_id+0x345/0x610 [ib_cm]
>> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
>> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
>> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
>> 	ucma_write+0xe0/0x160 [rdma_ucm]
>> 	__vfs_write+0x3a/0x16d
>> 	vfs_write+0xb2/0x1a1
>> 	? syscall_trace_enter+0x1ce/0x2b8
>> 	SyS_write+0x5c/0xd3
>> 	do_syscall_64+0x79/0x1b9
>> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
>>
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> ---
>>   drivers/infiniband/core/cm.c | 38 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index ff58058aeadc..03f7b80efa77 100644
>> --- a/drivers/infiniband/core/cm.c
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -34,6 +34,20 @@ MODULE_AUTHOR("Sean Hefty");
>>   MODULE_DESCRIPTION("InfiniBand CM");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   
>> +static unsigned long cm_destroy_id_wait_timeout_sec = 10;
>> +
>> +static struct ctl_table_header *cm_ctl_table_header;
>> +static struct ctl_table cm_ctl_table[] = {
>> +	{
>> +		.procname	= "destroy_id_wait_timeout_sec",
>> +		.data		= &cm_destroy_id_wait_timeout_sec,
>> +		.maxlen		= sizeof(cm_destroy_id_wait_timeout_sec),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_doulongvec_minmax,
>> +	},
>> +	{ }
>> +};
>> +
>>   static const char * const ibcm_rej_reason_strs[] = {
>>   	[IB_CM_REJ_NO_QP]			= "no QP",
>>   	[IB_CM_REJ_NO_EEC]			= "no EEC",
>> @@ -1025,10 +1039,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
>>   	}
>>   }
>>   
>> +static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
>> +{
>> +	struct cm_id_private *cm_id_priv;
>> +
>> +	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>> +	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
>> +	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
>> +}
>> +
>>   static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>>   {
>>   	struct cm_id_private *cm_id_priv;
>>   	struct cm_work *work;
>> +	int ret;
>>   
>>   	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>>   	spin_lock_irq(&cm_id_priv->lock);
>> @@ -1135,7 +1159,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>>   
>>   	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
>>   	cm_deref_id(cm_id_priv);
>> -	wait_for_completion(&cm_id_priv->comp);
>> +	do {
>> +		ret = wait_for_completion_timeout(&cm_id_priv->comp,
>> +						  msecs_to_jiffies(
>> +				cm_destroy_id_wait_timeout_sec * 1000));
>> +		if (!ret) /* timeout happened */
>> +			cm_destroy_id_wait_timeout(cm_id);
>> +	} while (!ret);
>> +
>>   	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
>>   		cm_free_work(work);
>>   
>> @@ -4505,6 +4536,10 @@ static int __init ib_cm_init(void)
>>   	ret = ib_register_client(&cm_client);
>>   	if (ret)
>>   		goto error3;
>> +	cm_ctl_table_header = register_net_sysctl(&init_net,
>> +						  "net/ib_cm", cm_ctl_table);
>> +	if (!cm_ctl_table_header)
>> +		pr_warn("ib_cm: couldn't register sysctl path, using default values\n");
>>   
>>   	return 0;
>>   error3:
>> @@ -4522,6 +4557,7 @@ static void __exit ib_cm_cleanup(void)
>>   		cancel_delayed_work(&timewait_info->work.work);
>>   	spin_unlock_irq(&cm.lock);
>>   
>> +	unregister_net_sysctl_table(cm_ctl_table_header);
>>   	ib_unregister_client(&cm_client);
>>   	destroy_workqueue(cm.wq);
>>   
>> -- 
>> 2.31.1
>>
>>


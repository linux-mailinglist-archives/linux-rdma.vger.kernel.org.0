Return-Path: <linux-rdma+bounces-16976-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNWoNA7wlGmOJAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16976-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:47:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2F1519BC
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A392C300D311
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7027B357;
	Tue, 17 Feb 2026 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QBD0/bgF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hrYDEq07"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4C1ADC7E;
	Tue, 17 Feb 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368452; cv=fail; b=LoOMkckAbQFVacdhAGdGZnUT3ALKqbwwTNqkYjBgq2PrYFbCQGqP4wi5EkMIlZjx5QFqizGXEYQde3EQFf72ovib2sDhJEpzCNKmHzbHbCwu+lF4XFjlC6asCFxV/CuBEGutykbpE6RqFXQIylgy3V3C0KUFi/7Ztx0RR7Sa8ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368452; c=relaxed/simple;
	bh=kne+kx9fi5F/3BHaKU33h9EwowdvliW1sC95SjUdTJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=faUrgWcox8Hu+erXs0GzNw802w0GLOGWTBa23b4pEs5St70m5oPWOzHA18fccOWEWRYMoGP+4E9jkOGFP3ypCTYRMO5MV187eQ5tsGjfKt8l+husBKYTJeQEWguaq69nZjZahB3xX5uVdW5qmSoVWUHo1WdDzJCugD5i/jSusT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QBD0/bgF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hrYDEq07; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNJIC026216;
	Tue, 17 Feb 2026 22:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XijWvIbJEBTo6OFrIHjxG0+modG0oP+1aaA6tBKchQ0=; b=
	QBD0/bgFZbGDRwp8nRk+uoK5cXFxMNuaVNgh7PYh1nIXrIuKF3qwH0T9OreHoR9w
	fnE/XOw4gTCzPdiryb3i8xq5yuJQAdjsYkb5V2FATcpsxLtbcCjC6K6x6nLBhZ9F
	fE5/FU9jitN+sTXXWev1eYU5GWsyd2osToII0LtOXxAeLdbJajYbAKzJEx2Zh2DX
	hmVBUz5wtiLCWcXialrl2jKwZTuMdgSjoFMwfPOcvKP4481escQRnMPEblJZag63
	QlQcD7Rt+k/uoeODwQbp+GhekLx5GeFntzs4tXRHY7f8ISolEjsK0NVuPCThcdui
	wqlDhlB27004C7J5RcDcIA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rcmbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 22:47:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HKPvnD015225;
	Tue, 17 Feb 2026 22:47:13 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb22km0v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 22:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta96sU6fQsBHVGcjZTpK6wbpN6I+THOb/9kAcvoNtvIpOaLIv59KIoKXjkLqgdSPAKfhUBEJ3mLy49N3m//75UJly3r+gVUvujlKVq8fAwOiY8OF0drY+TsSvoIDmpkd6WELPcRqqseHlEWeCqNb/MYR/H5iEEtvtOE8j/rwU9SZhRMydDXKxktk0mRx6clBclYleNyJCANShP2KCyS8M2RJ2VV305kHRMwZNFbPdxkukZHqD7moqvRireOdKFykNn6BaVCBZSXPus5Ooqfc8NKZuNi1R+CXg8xQNg9cJ4qwr7e5ZPm67EMdaBPLzNF9Uzk6eNTGKGiT8B1WQDYGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XijWvIbJEBTo6OFrIHjxG0+modG0oP+1aaA6tBKchQ0=;
 b=kiwM1o41rkjOrEzY0jHUPMD0cghz5wPCMPzE5OOuv+KGgvN1EktT6vsjE3GcRjkDekU+GpG4n/mCdtpKrLDbWg1f9baR2cSLSx7ulqVWwTMjuwvmOURH3ptsXxwjZm82CEzBeSG5/aHpP1woC69fCneVPXHJavS3Vum94gNSq0GgUUipKT2b/71HwTjhrUOZO/qRvzvY+91cIlB5IsFH4ij5ZL1XBxNhE28B9fXaBF4LLRlshs4ylvlgzpw4qhESEU0XBdUYDJzNoqNOP6IRwf4mJaHOI0Cyw9RlWQihCsN8UQV4KPBgU/Mxy/00NK+TSCFONZNC81C0DRdF2sel3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XijWvIbJEBTo6OFrIHjxG0+modG0oP+1aaA6tBKchQ0=;
 b=hrYDEq07F5i/nR1NARABJuC+z7Y7Izb89DXhN8C9HAjgUEB3H5jRxsz9ErxVvjt8R/kchCT9RKrNWLVTGQsR6uyeoDjJXJDz6yBGfVHt31GSsLR3RbH4QiR/pjROHltSuRtnuxbD9bsNs8K1hWmUzcaA/QZ9sT0dlsz3fOe0EgM=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by SJ0PR10MB5696.namprd10.prod.outlook.com (2603:10b6:a03:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 22:47:09 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 22:47:09 +0000
Message-ID: <170c3780-8d28-461d-b956-20f89dbf0811@oracle.com>
Date: Tue, 17 Feb 2026 14:47:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, horms@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, allison.henderson@oracle.com,
        syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
References: <20260217223802.21659-1-fmancera@suse.de>
From: Gerd Rausch <gerd.rausch@oracle.com>
In-Reply-To: <20260217223802.21659-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|SJ0PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: c00675bb-a1b5-4db0-927f-08de6e767b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1c1RDVEeDVLR0tuRWszcjJGUmhFTFd4SGs5ZTRMdUtsUStoTzUyNFZGWU5h?=
 =?utf-8?B?ZGx4dlRFVUFyS0diZXY2ZmlpeUszOWx0WUZNa0lzMVZkS0d2MmNreGZvWVhY?=
 =?utf-8?B?bG5HemdzcHVSeTk0VTNtVkMzTTlZQ0FwV1NSY0pLQXA0bS9kQlRSL051ZndE?=
 =?utf-8?B?cnhQSmlFWjFUVElXNTZJd3RqRytMTGRGbmxsSWhzV2xlZE5LSVZPdS9kNkhQ?=
 =?utf-8?B?VmtPdXdvQ2FvcjJiS0FGOUtLQTB6RXZKakJkZWdlRDNLVW1WZVdYUkcxVWNt?=
 =?utf-8?B?SjFKM3NnejZxUWhBSmluQkcrV09hQlM4R3BNczl6RU9WQjJjT0w2aXpRYkhp?=
 =?utf-8?B?b2g4c1NOM25LdG14eDE1R1kyR1NVaVprN1hlZkJHRFBwK1hySVZDaGNyR3d3?=
 =?utf-8?B?NmxhbFJRbm0rUndKQjJMZ2NQaGpqVDN2aVcyUG44Q3lSaXFId1Zpcnp6U2l5?=
 =?utf-8?B?WDU0VVd3WWprNUliOFVkTE1aL0JyeVEybDhwcG9ZUkIzMk9IYkgzSS8ya2tw?=
 =?utf-8?B?N0Jxb1BwSXFjSStJT2RhNUR4bFhNUkFUUVBiUmJCYmRteDV6bTdkWjQrbGpj?=
 =?utf-8?B?MDRLU1RNOUFER2RwVFdhWlRIR0ZDTXBDRG1mNFl4Ykx5Z0xRR044MXhidlpz?=
 =?utf-8?B?Nm1JUEJWVlIrdzVQelJrbnprYmxKWUMrY2Y4UDlsWFRqNnNNNDJESjMyNkZU?=
 =?utf-8?B?eE52cWpUbkJvRlc0aW9lbXRJcDc0cWk0QWFiWmgwc0p4dFcxSmZmdC9ESUFz?=
 =?utf-8?B?UUlnZUh5bmNhMUlsRlRuOGFQWTVMc0FBSmJHVTJaMVo4Nm1jKy9uZC9wbW55?=
 =?utf-8?B?WlRsQUhlSzZrU3VYTFpLT0NWWmVrN1NTVFhHZ010S3RVUitxRGVLMmtvcGg5?=
 =?utf-8?B?S3FtNlpOUkl3Ujh5SkVDQjc3TEQzTlZid2FLbXFNa0hnMUhRdVc5WTl4Tm8z?=
 =?utf-8?B?SWRkTDNSU0lLdHdmRWZtUXpybGh1aGY1ZXQvaENXRXdITUM5emxMWjZhcStu?=
 =?utf-8?B?Q2cwV1VFWWYvTjdDcTA2bmtWZHloK00vUXY5VWRXbzVKZlhkanRNc09Oenc1?=
 =?utf-8?B?NlhDNHFNd3BEZWNRZkdubURYUUFHcTk4Mnc2MWVQZ0JFV1hrNnpxaGd1U2RH?=
 =?utf-8?B?WE9IcDV4R0R2REhvdUxnd0FVcndwK1BqUVNRdEtwV2hEbjVxZjF5SDFJaEUx?=
 =?utf-8?B?eVQybjV0UEtIbFJ2OFpueGpIKzBVSE9PbUREbFQvc0FZNk9iQkVwb1J6MHRV?=
 =?utf-8?B?WXVSaS8zTU9pcEpHMFJCc0xpWTIyZzRRMmVxVUtuRlJmb1lYTmoxTXJpSmpG?=
 =?utf-8?B?VENhWEhSVnNUYTQ3dE9pand6ajdheS9kWHNnU2loNDl1bzhMWi9YNFk0VHZR?=
 =?utf-8?B?S3Y4ajFpL3NueVNuNFFvZ1VDelpzVzFPZDBiMW5Kc0UvR1ZINTlWMnZHS0RJ?=
 =?utf-8?B?RHpvL3FWSHJVNDdWM1RWZHJ6T3pvZkVlME9BMyt5WURTUDdVMFFteCt3RDc0?=
 =?utf-8?B?WXN3YnpLbXZEU2xiUFg0VzAvMC9rN2JNaHZKS1FLQjRwYy95V0tLdW1sbDhR?=
 =?utf-8?B?Z1NOWUxGcWNUdjUwTW9pMzV5aFh4VUhEY0hkeFB5c21kemRlTTJPTDlMREI2?=
 =?utf-8?B?QWpQbFVHNUg5RUZlODRid2lyUzRiazlCWGR4dm5hM0ZjWmRMYVFpSTNMZHlK?=
 =?utf-8?B?UDlLSkhPRURPRE1qcEpLUUVBaHhMMXM2NUp0OStxUnl3NEkxeXkxb0RIMWNR?=
 =?utf-8?B?a1FVUEZiV2tWK0pzVFcvZ3hPRXgyWENDWlJ4QnkyMVJRMnpoRW9ibkg0NVly?=
 =?utf-8?B?N1MxVGwrSloybXQzdjJ4NUtCZ0J6N2c3bzdTMGs1Y3dpNE5CcWgyazlsL05Y?=
 =?utf-8?B?cmoyQzV3TWhCQkFhd2sxMXQvMWd5OHltenVDTzNtT1ZBUnE5bkF6ZVUzRWsz?=
 =?utf-8?B?aEZBNksxQ1NJbHYwS3hhZ2JMTUpEcU9IVHgwVkpzZUZMMnZpcGpQMmNYWEZw?=
 =?utf-8?B?bVZBd0J5NGFxbE5zekxsa1ZIN1JUekJ3Z2NFQlkrdmVyUG9mdmduWTg3Vk1x?=
 =?utf-8?Q?9JnHdA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUYrTDlQT2dWaHRCcStYZ2hYb3Y5emhIbzNCcSt4M1Z0amg0WmFxVVRKOFhN?=
 =?utf-8?B?YWZLNSs0ZDBzWmxtVXBmVzRwV3dnQ2puK2dHeXNUZWNpVnE1anZlYUJhZytG?=
 =?utf-8?B?SzFtMmFqZVBzdkc2b08zZ3B3ZUk1cXFkdXB6ekVWUkQzTUhYMmtmcWZlT0tC?=
 =?utf-8?B?aHJoUWlSREh3WmFLdm5Scis4S1kzWDg3T1d3RXcxQmxnanYxS2Y1ZGg1ck1j?=
 =?utf-8?B?dElzMEFYaXpRV1ZhZDd6K0Y3T3lEV0hRY2ZCREl6Y1UvbjhtMElROFBwRjUx?=
 =?utf-8?B?bmJrekhqWjFtQTUyQ05WVGg3RHRnMWJmTWFWRE5sZmpkUW90aDROT0tTRWx3?=
 =?utf-8?B?b05RRDZtK2Y3RmM3a1Z5WG51VG5JY2JLRFBTNytLd2dLNE9BY0IyRWs2TjB3?=
 =?utf-8?B?cEt0c0FuSnFUZmo5bVY2RU13WHBvU2dBTWpFN1R4dlRtb2UrVGJpWlNoblFQ?=
 =?utf-8?B?RVpsd2graWNlendlNFhTZEpNTmVOZzUrL0NXV3BPY3prL1JsYU9uVWdVY3FW?=
 =?utf-8?B?WDh1bUlzd1BTUzlOUncxbGZoOERYZHFOZWhDS0sveFpPZEU1WFp6RkM1NE9D?=
 =?utf-8?B?amlFdFlDSFp0WTFyVTFhb1ptc29UbTZyNFFuc21MTWRiOHRVWUMyeFg3NCtE?=
 =?utf-8?B?UC94c3pQYU5RZGVlTFhPZFE3cE5WaTNwb2p0cUY4YmZFRWMrcHlRVXpqMzFn?=
 =?utf-8?B?NmcrUTFoaWw2NnFsU3BtVTFGenBLNWJGNHRDZnh2NUg4TklyOHdXdU5IbjdI?=
 =?utf-8?B?NzZtalFua2pBVmMxZ1lMQ1ROZkpEUEJhNjk4YTh6ZnBaOUNuaTRydVJPb3BZ?=
 =?utf-8?B?cnZveWxWOFViN1dvL1h0OEJab2xpZTk1S0xQS1ZlQngzK01KY0RaREw3UGZZ?=
 =?utf-8?B?eDBzaGhGcmZyVXY2YnRUVTJsc2VyNnhHRk5KQllRYXdlZ0hGS1hrYWRVbTJH?=
 =?utf-8?B?VERtQm03dzdWQk9mdWEzMDM0bExjMVVZdld6RkZhbkU3RVJnV0FOcnF0MWFQ?=
 =?utf-8?B?eTBCSi9qT3dIeit6aCtiZmkwaE5vZGJ5V055bTIyd01JczNlZGN1dEF1TEw3?=
 =?utf-8?B?Y3N4ek5XZzlyeUhsR2tQd2ZmUzQrN0xYb2gxVU5pVmFoeENBMzRoa0ozYVlJ?=
 =?utf-8?B?a25PbVE4NmpRdVYwWTJHSXY4aGdtVWhPQ01QY0hxRlExY0tZMzJQem5EVFor?=
 =?utf-8?B?aGJ4NXM0RWwrZktQa3Q1cTV6YkZzV1ZLYnRUTThUaHBnbGJVMk14Tzl0OUFK?=
 =?utf-8?B?VnU5dWpGSW4xSkJURS9melBRQUl5R0dsMW9Wb0FrOXV0bHErQ2hjem50aGx5?=
 =?utf-8?B?UDNnbnF1bjJCa3d2VjdQaDl2ZFVVak41M0tDYXVpTzhDMkM4QUhGUy9Ud005?=
 =?utf-8?B?eE9mcW5yTmRpMUl1aGRyMXBMV2czT3QxZnR2ODF3aE5ERDVzbXdBNXAyZ1ow?=
 =?utf-8?B?d1BvYTFONlRZN3ZKR3pwY2YxdnQ0MTJTbFY1Yk1vZC9QdWVVTFU5ZEtNVUc1?=
 =?utf-8?B?dlZTalRjcm9TL1ZtV3BrdjhqUEUrallyUVkyZ0pjR2N1aHdaRXk0TjJTaVNv?=
 =?utf-8?B?SFhXaTlSY1dkQk9oTFNVaHZBVUxXU3UyU09XQys3UDhXQk1rT1R6aEhrcXdl?=
 =?utf-8?B?OXo1d3lWTDcyVkJWeTVJYUxVMUVPaHA5Ry9rUkxXYkhmSllVUlVLbDRoSVpY?=
 =?utf-8?B?bVBPdisrelBmU1hwZXhidWtsZit0UWdpU2k0Ri8yc1R1NktYZWxpYmRmTGh0?=
 =?utf-8?B?UWJWb2FiOG5RbU9ETkRtZlJkQzFGUlNLMWpmOXVxcFEray9nNTd3QWVYMWY3?=
 =?utf-8?B?VFU4OEduY3FLOEJQeWVCeE1TeFMrOVh4Wm1wVUxETkxabGVFRUVoUCthTUp6?=
 =?utf-8?B?VFdRTFF3UDQ2RGhjMFZ0VUViOUU1b3R2UmxlYzFCWUVFMUttTVY4SStTRFFk?=
 =?utf-8?B?NmlBSGJkbEtQbFJnRWNPeVVJbE8wOWt1b2JjWUl0SnVVM1NOUUhidUFacXBL?=
 =?utf-8?B?NkM3clpGSmJGOE5WNWU3eUpscjk1LzEwbmUyODBDb1NzWkt1VFpONVZSTzM1?=
 =?utf-8?B?MHpLM0ZzVjlwOEE3TEI4Y0tRdzBQWDA1KzdPZDBPMVh6dGdQc0J6WSthZkhP?=
 =?utf-8?B?VVJXVUMyNTRMT21XcnE0ZXFKcnlXMXFhQlFwUGZ2Zm9TNE5Wa3o3aFV0Tjcv?=
 =?utf-8?B?MDVObUt4b21Lb3NBTDYxcmRtK21QYjZrVHd0OCtOZTY1SEJtQlVqRklvcnJ5?=
 =?utf-8?B?dUhraStPUjdQb2E1NjRFRklzVkM0N1NwZjh6NEE0K2ZmOVpzMU56K3EwOFNh?=
 =?utf-8?B?ZzBObjFyQXJ6YUVsYnR0TnN5N2diSzdRYmlJRXVjeWpqYTZBN2s4QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MxT3f3izNVad33UsGiH7CPfKNvXfA4H2qJeWeNVTb5++BavmFlqp9UfV9uRc9bkZix879yboML3GU1YqkIKWYbYCfbCY6sdxfUd1Z3RJpCWulCV56sBUanSZsrtLE2fEv8alflM+iTx8XRSoc/ma4VjBcdyIg2oKFP9jMck4lziLiTnSbTTvNO7+1J79lvdZ/7Fbzjb+434B6wbzWGP+Q6ABYhUaRZR0AiQuoFSRvrgpys9BJTQoA6c/x5Gw6h6drE9FRbxQUhjm6alq9HPBotwidmbVX5sT5FNM7vw8SneIPSX2TPpRTe90hSiyfeDFx9P4gMXcP16oss8ZdFUBbRPI1cgIh7k+B58XMSrrgt+Li5+l6uqbwJ/TymzA4iZ/JO7MQ2igDWrOR2kmA1r9rXRe2oLidlLxq3VPGfKA/kxyMt7p7UUFAIEOBgTeyukpLSVRxkwYzrcNksnMUzPHES0vz1aVFSa8YmB5+0HTYAghiO5wMa/YhG4PFHNcXQZwv/ISo1UCQHjtmAHm/fFhdnK542mrdwN2nSkiqSbVWoHdZtDp+ggQuFqlFp6bel2sKRtuVu9PQmXYdxHCcyHHcI4LGRmWE5l9u3Ek1DOrAIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00675bb-a1b5-4db0-927f-08de6e767b3d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 22:47:08.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhe4qYGJ384IE59EPY39YC3AIgZJ71tQOJwZ+5CZ6oabNqUQLkgLs5qhkWmNabfV7F98OX2cb1J4736qQDmLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602170188
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=6994eff2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=5oxWJP6zNvKkBt9ngwQA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: bUQ8TQPbVEhSs6HMJzP9MzFnF2MhCzyc
X-Proofpoint-GUID: bUQ8TQPbVEhSs6HMJzP9MzFnF2MhCzyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE4OCBTYWx0ZWRfX8PIlgClYG531
 DXn1p11DJjxMLB7E5Mv8nb/ATWwk2oPR93r+io9j/qBZk/Z8b4cG9OtHJSS7QC0eMPzBbbX9Yei
 qc+ORD5TthSdOJZE87CWkdoVyT7COCacUzbzBPapFPkWCsTbww/VL7lrgWB3mNcw52okeGv6ywo
 4BO5XSOAMP4SuYAUBJATyE7AlPIq4IAl/ybjRNXnUN+o+1EGg79KHdVZWPbpIY2VpNZZmb1usZ6
 jJwGFiTXOMCS90FMai0mqgcluYhYYi2eqEJmmNyq68p5x5TLCgL2oNGUWjIcKPR+1IMN5m3W4wH
 Ladj+IEkmvIj6nfw5BBLJMY8eFIX4iMGR1oUv67F52cFmbokgj/R3Hjgcuu2D3rb/DFZdOQB4br
 DLGV/Z/UlH5Ws4bPspLyKEBG38KipV1079jK67KlgDTM2tRtjwBC1qXosRZSpF5HvDDUQjro81O
 pk4F+4splJTqFM+PeQw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16976-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,suse.de:email,oracle.com:mid,oracle.com:dkim,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerd.rausch@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7EE2F1519BC
X-Rspamd-Action: no action

On 2026-02-17 14:38, Fernando Fernandez Mancera wrote:
> syzbot reported a recursive lock warning in rds_tcp_get_peer_sport() as
> it calls inet6_getname() which acquires the socket lock that was already
> held by __release_sock().
> 
>   kworker/u8:6/2985 is trying to acquire lock:
>   ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>   ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
> 
>   but task is already holding lock:
>   ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>   ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
>     lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>     lock_sock include/net/sock.h:1709 [inline]
>     inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>     rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>     rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>     rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>     rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>     rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>     __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>     rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>     rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>     tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>     tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>     sk_backlog_rcv include/net/sock.h:1185 [inline]
>     __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
> 
> Reading from the socket struct directly is safe from both possible
> paths. For rds_tcp_accept_one(), the socket was just accepted and no
> concurrent access is possible yet. For rds_tcp_conn_slots_available()
> the lock is already held because we are in the receiving path.
> 
> Note that it is also safe to call rds_tcp_conn_slots_available() from
> rds_conn_shutdown() because the fan-out is disabled.
> 
> Fixes: 9d27a0fb122f ("net/rds: Trigger rds_send_ping() more than once")
> Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: clarified commit message and add a comment around
> rds_conn_shutdown() path
> ---
>   net/rds/connection.c |  3 +++
>   net/rds/tcp_listen.c | 28 +++++-----------------------
>   2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index 185f73b01694..a542f94c0214 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -455,6 +455,9 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
>   		rcu_read_unlock();
>   	}
>   
> +	/* we do not hold the socket lock here but it is safe because
> +	 * fan-out is disabled when calling conn_slots_available()
> +	 */
>   	if (conn->c_trans->conn_slots_available)
>   		conn->c_trans->conn_slots_available(conn, false);
>   }
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 6fb5c928b8fd..a36e5dfd6c66 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
>   static int
>   rds_tcp_get_peer_sport(struct socket *sock)
>   {
> -	union {
> -		struct sockaddr_storage storage;
> -		struct sockaddr addr;
> -		struct sockaddr_in sin;
> -		struct sockaddr_in6 sin6;
> -	} saddr;
> -	int sport;
> -
> -	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
> -		switch (saddr.addr.sa_family) {
> -		case AF_INET:
> -			sport = ntohs(saddr.sin.sin_port);
> -			break;
> -		case AF_INET6:
> -			sport = ntohs(saddr.sin6.sin6_port);
> -			break;
> -		default:
> -			sport = -1;
> -		}
> -	} else {
> -		sport = -1;
> -	}
> +	struct sock *sk = sock->sk;
> +
> +	if (!sk)
> +		return -1;
>   
> -	return sport;
> +	return ntohs(inet_sk(sk)->inet_dport);
>   }
>   
>   /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the


Looks good to me.

Reviewed-by: Gerd Rausch <gerd.rausch@oracle.com>

Thanks,

   Gerd



Return-Path: <linux-rdma+bounces-9221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138FA7EE75
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E947A42E9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF81FF601;
	Mon,  7 Apr 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="fxHhRMj+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C52156C69;
	Mon,  7 Apr 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056433; cv=fail; b=J028X0gTqa9CQeUy1GbpCHjUCeTANizJsCUtJbViCbKImjyi8NahTtBBbfVk+rZR98S/PyVcXvvODFC80VXZeoAGqLW0qSuk2/+mz3KLjtG1ZYu8qmtpvLG/uoZZxKVXR7Uin5rmSa20DL2aOdc3bzvHXkDclQEZnd+L9xO9xPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056433; c=relaxed/simple;
	bh=W2yNVdDcHuQ+qNkyx4gXTIu8YhLVzed/lceIbZ3GmYA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUdcbZwVGu61yHkTrZNkUQLbMg2I3ofD+6c1qpWpoNflsK+w3CFdykG1F1RpS+11z0gd4WjFLx5xJDeyubymYnNJFaMD1wM86dyIDUv3Mxe3sxGRGjsz7Bg7jlzcMWsiUy7shiILcuaHbv537Obz/syFQDbfJ1GkWyCyQ5KyuG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=fxHhRMj+; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537I6fsV020751;
	Mon, 7 Apr 2025 19:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=SO
	xX6DD1oephlAR+IpCVTe2cP7269Y33Koauo5j3mzs=; b=fxHhRMj+zShaaCb9ao
	noHPBnpCWNy/g0J7s8uPcl8Qu8GM9VQvZGsuSwTziMAWdFTqCN6h+bT8A/5PL5Cu
	ef97HFHc2wXKxuMASYzDcZEW+Gglq21itSYt4cROaiO1AqPqLgrw8De+g9yQsTBZ
	dq/+SKsY+VSdFeII4qbqegrhvuBKbJVGR8bAhdLpOfMI5asL1W+GNANJX0wPEXEy
	QsbHo6rGfQDUzOWZGlAQgCMad+NREdPU/ZKWKktpRKtaMXuYnnkdMFaVYzNW1rcb
	sUEhraeUUnNTLYQdofdrQMPiLCU1tqMtqpxVObCiPFnHhKJ0+Dc69hje5Okf5b3a
	Cl+A==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 45twwkhunr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 19:33:03 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 2B20F808071;
	Mon,  7 Apr 2025 19:32:44 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 07:32:43 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 07:32:39 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Mon, 7 Apr 2025 07:32:39 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 19:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Feg2g8xZKo4QdQK7czZEgQw60zdAnUQ35zcbOUDjtgk9zGktN1QzXLNuc5tU4h5obSyq1KmC62Jx4QZqE/vrMAik+rLsXSM9GIUeAGFHQADJG/aLl/dn5Ti7/l1IP+mtlALfGMzKqns3Zin3JxgYy6PQVx9xPJnGxl60MxaBRr7j9lmDPVvsrswjuOximchM0VTr2l5GA6eq3gTwbyuCK2KGxUpc/1zguIdvKCfmrwBJi0NpNtstYzu3FmCwPrlqf1JKws4PFRKDIix3CRlpIOjewF1eJRmS2z6cr92fch37bh1qGL2SLjbQ5i4QvLsMBninJZfpbmNBXLsLNrencA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOxX6DD1oephlAR+IpCVTe2cP7269Y33Koauo5j3mzs=;
 b=IkPB3HLabUgZr5DgCtxjRdvlZWIzxKs9ZpK8/qV85R52CHX9qbpiqwOEvTSY+ALq2SIFr3/sNF8RAOA0JMCYVO6HF2uwyeAOkdb3e07lsjyE+6vOUlHBRf0Voq9brfY5fza/vz/p1PNFHwZElgQ+CO5QXTlQaUbvvzT3CeprJ2zbFdK4CIgDCebh6Jx09ITYCH3eelAENUPwwhakuXpisD/obTpFB//+1GXxoaVa3jfUo0YI3+86CuDrHSxSi7m2UG2WqR6R3CzcR3FOvGqHVcJkUj7ugfxdDZi7UFIB9Nt9YbhIPAn5fsXnrss9F9U8A0venmxL92fLeC7N+3tN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::16) by
 MW5PR84MB1690.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 19:32:37 +0000
Received: from DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6781:5ecc:8646:f06b]) by DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6781:5ecc:8646:f06b%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:32:37 +0000
Message-ID: <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
Date: Mon, 7 Apr 2025 14:32:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Sean Hefty <shefty@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>,
        Roland Dreier
	<roland@enfabrica.net>,
        Nikolay Aleksandrov <nikolay@enfabrica.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>,
        "alex.badea@keysight.com"
	<alex.badea@keysight.com>,
        "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>,
        "rip.sohan@amd.com" <rip.sohan@amd.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "winston.liu@keysight.com"
	<winston.liu@keysight.com>,
        "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>,
        Kamal Heib <kheib@redhat.com>,
        "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
        Dave Miller
	<davem@redhat.com>,
        "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>,
        "welch@hpe.com" <welch@hpe.com>,
        "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
        "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Ziemba, Ian" <ian.ziemba@hpe.com>
In-Reply-To: <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::7) To DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:4a::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB1447:EE_|MW5PR84MB1690:EE_
X-MS-Office365-Filtering-Correlation-Id: c4532f50-7350-4171-c1a5-08dd760af3cd
X-LD-Processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0xZKys0ZXUrUEx6SUNPUjlpT2ZPUVhyTlQwYUhDWHNuaFAvbndSNjlnNzUr?=
 =?utf-8?B?bjdtWFFaQ3gzOEd1eW9iUHhMdlhuZjNTL3FlVVdCYm5nQm44TTVwM1hUdW1G?=
 =?utf-8?B?M3dYQitHUXJ2eUN6cEhmamM0MTJWdGNOL2hMVmdwYjVIbG9xcm40RXdPL2dX?=
 =?utf-8?B?NXNEd1daTlh3VEwyZUZTeEs3RzFkampkK1M4VDMvOTVKczRKVnNydjFUak1Y?=
 =?utf-8?B?L0wwUEErazMrM056UXZKV2E0Zk9iRzhEV0pkMDc4alBhZitQdWlPZjFVcWRJ?=
 =?utf-8?B?SEdPYmNyVnFxeFRHN2RDRDQ3WDJ2R1Z4QjV6ZU1SYnJ4QVdLblZ0dG1LMktx?=
 =?utf-8?B?RXhMcmR5ZjU3YWVqWDRkYkJLRDBPM1FaMVQ1V0E2RUdhN2ZTcHh3bStqaFhl?=
 =?utf-8?B?UVZ5bU9vNW1qV25qV2ZHSDc1RVRrR1VUZ2RKRTB0L0xNNlV0TlBlVTh3QWsw?=
 =?utf-8?B?aWpGdXpOMHpCYVNNd1d2Y0ZyazdwT0ZZRk1HMHZHY205Q3hENW4rT2RiQk0x?=
 =?utf-8?B?Tzc1a3pnVXBJK0tIcHVaUWV6bzFPcml4QnI4OUNYckxLRVlsVHA0bTN1cUNY?=
 =?utf-8?B?RTA1bEtqMlp2VXhDeWJhdkliT3Q1TVB6cDNMVXUzc3E4dkJsVGlHSk0rbVlx?=
 =?utf-8?B?QlpBem1NSWpQRE10bnQ3VjRBUlZUZjBZcitzUTlmMWhKbHBkT0wzamJZSnda?=
 =?utf-8?B?ZzQxdXRKV2VNY2Q0dzZ2NlZ4TGVTRUtUU0hhc2V1d1Q4a0lUaHVVbUwzR1Fy?=
 =?utf-8?B?Y3Z5dElLRm1BUVAzRVdNTnp4bk9zd2dFNnMzNjNWZUcvWHNYK294eUh2N1RC?=
 =?utf-8?B?UmJzVnl3a0FtOTJxMyswN0tlSDJwNXl3eVFXbXlwWG40QUc1eFo1dUd2ZU5p?=
 =?utf-8?B?cVVpNGV1VCtjdWF2b3kzTGx2dzVrcFN3bFdvK2lVSGZieGFMMllJSkZDZW0v?=
 =?utf-8?B?eUFwWVo4Ukg1R2hFUEtyNEtMYU9LZWs5TkZTc2RocWtVUVRXNGRBeTV5dDhs?=
 =?utf-8?B?RlptRldLYlIzd0NwZlVqQ2F2bkcvNjMyZ0N6UlRGa3JONTVxc045azc1YmlQ?=
 =?utf-8?B?cjZuY0kvTThGSjVlUXNuR2FnZGIwNW1EdmxEemJ3dzE3blEyZ1g5QVhCMUd0?=
 =?utf-8?B?L0NkSjh4UklaaXp6SzlIWElqNjZQelFBYm9CN2tPdnU3dmZnV3M5RkJDY2V3?=
 =?utf-8?B?Y0pjbGVJdjZYUzJQcEdZV2xXenhqcVMvdUNKd1g0d29wbFRDZlh4KzFvd1JF?=
 =?utf-8?B?M2VLSmFrRVA1SnpwNDM5NUZoZFd2N3lWWGJzc1NhSU1wc0NacVltaTVJWUYy?=
 =?utf-8?B?dXZlc210UjFWVi9YeXEyTEx4ZXNnMnhrNUZKSVB2aGQxVXN3TVVOd1FDamhm?=
 =?utf-8?B?WkJjekozQTdQV0E5a2ZGY1Z0dDlQVWUzb3lSQkE3SXMwQ3BWOUVLQ24zenVk?=
 =?utf-8?B?Tit5cll5Z3BOSE1sYWxlQnora0RpRm5FNkVWTlFGY2JiWXg1WkY3VERmUEsr?=
 =?utf-8?B?a1BiTmdvNjc1ZFlwV0YrMmwrV3NXZVpiN2JVemJXV3B3ODZaQkNKb3VJSVpE?=
 =?utf-8?B?dWltZlU0YXhMQ3FoRzNVNjEwOFcvRVFCMmV0N0JYRmVSdWl3b001SStkUmJT?=
 =?utf-8?B?eWZxU3BqZWJ0U2phMFY0dkIya2wxMml1K0E0ZlFXN0x1Y1Zlc3IzV3h6SS9x?=
 =?utf-8?B?TEtOelVia1hZSFlCVGQ3NUIwUGpsTHRnd0NEN1pUMk5GOWRRekpzMlRlWC9h?=
 =?utf-8?B?NmEwZ0dSTUl1QlZoU25ZekNoMHFyNWk1RmNFQkJIbWo5cldCaEZzTzcxdXBH?=
 =?utf-8?B?L1JiMUJ1aHhhTnoxVmlXTHhTdGtpQmhzL0pqRkszRVF6cngxdTFobkhmTUlt?=
 =?utf-8?Q?A4AZ1LU7hGUaT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmoyRjMvc1pNS0NzallHaThValJVS1hGRitBRktSbW8yN1RBaExxaHo4R2dt?=
 =?utf-8?B?OXkwbW9JQjZ6VUU2ME8rTlhGdUIyZzNZUk1GRlpEdDhGSWUrZitHa2FSbCtt?=
 =?utf-8?B?eHlmN0tGUFk2MFIrNlZZajM0NnFXVFAzU05NbmxMcW5DK3ZRcmhYZTI0UDEv?=
 =?utf-8?B?YTJLVWUzUHlSS3VTaTJ4R29iMUlLaDhraGErN0xZMmJlbGhyTDZFZHd6K1M3?=
 =?utf-8?B?enpVMGt2N01KcXlSQUoxZWwzVVh4Q0thQnJlcXA1ZzJpTEg1VWNRSGhJeDln?=
 =?utf-8?B?THN4TmhzY1pSaiswOTlVa3Y4QW1kbDNXU0JoSUl0azdqb3Q3L0JwMDc0Smdl?=
 =?utf-8?B?cGRLdUI3dnF2Wkx0dFpuZFljWUYvY0lpNTNaelFVWFAzc3pEYjFnT3FsUUN3?=
 =?utf-8?B?YmpJK1pxRUdablZWS1JXS08zVEx6ZGR6WkdBSFoxVTFjTkwvUDB4dGFCVTdy?=
 =?utf-8?B?UUlyMEoycnZSNDVJZTdNbE02U1JZOXRGS3liVzRNQ2l4aERNanNINW9BMjA0?=
 =?utf-8?B?UTlvd3ZUWG1kODYwU0dHdUdOb2hBc0UrbTlXWktXV0FZeXBjMXBYRExtWXp0?=
 =?utf-8?B?cXJIUFY4cHpKbmtKM1JWOSsvQjBNTUkwakZWSUFkZ01HVWdKNURLQm5LQVNh?=
 =?utf-8?B?QVFkK0xidTlkY0lUczNwVlMrRjgrcWQ3S2dxRjBhcStEeWx0WE9EZFdvV3lu?=
 =?utf-8?B?bnJpZVcxdFF0YS96U2tIZUN0QnlKdE9EV1NRNkFWNkhtOGhtRU5CdHI0WHMx?=
 =?utf-8?B?UlREV0kzWjZ0Wm5LaGl1YXpObHBiRmlVZU9YR0VmdzcxZnVQdUtMbUpGdTBF?=
 =?utf-8?B?UlA2L1hOTG5NVTRlbndFbXdXUnhhd2ZrMDJpTStKSkQyQWdHSGUzcnZLRVJL?=
 =?utf-8?B?eUlGYkJ1NittY3kwMXBFYTNBQ3Nld1FBYnRacFdPZnZLQUk0VC9lQ1hSKy9G?=
 =?utf-8?B?VkoxSzRMNmQ5T2lITVJta3pud1EyK3Q0d0NDTkJxM2pXZ2VkVkIxMWNaZ3Q1?=
 =?utf-8?B?SU9sK3hwOEhWQ0RNWUVsOFQyWW01Y2d6RDFpV3VMKzJrQ0I2U1NlRkwxNEwx?=
 =?utf-8?B?cXBJNWljWE5EVmhTUW9ONXNJYnNFK1RlV2dWWFVBUHc0Y1NrUTExNnc0L3Mz?=
 =?utf-8?B?d3FyelpFMlBwL3ErOW9yR1FXT3pEUCtOUTNnRkNvOENhN0dnMDAvclNWTzlx?=
 =?utf-8?B?Nm9ScUg2NXl1WDVuemxnekplUThnUXo1SUtWUFhUL3lBb0swdHNHT0RrMk1O?=
 =?utf-8?B?L2hWVHdZNHNGSmdHc29vWW5ZdUlxQzBMVEw0dWhEY3Z4S0E4L1lubGl5NG1P?=
 =?utf-8?B?Uy9nOEY5U3h5M3hMNmpicm9NN0hUQUNoRzZRcGxLSmZveXdCMDdNU3lDZWl6?=
 =?utf-8?B?bi9pV1BGeWM1Uzc4WUM4bEtGcC9IKzZmNkFuL1BpWHpKK01XR2YrQ2F4eXFV?=
 =?utf-8?B?Y0N1VWdzRlN2NzdhUnpVNlM3bmNOVGJDT1pVK0dLNVl4dzExOHNwYURxL0ly?=
 =?utf-8?B?SE10SzFwZlpLOUVVVE90MFhoR0RnMmpFUktPTi94bFhpeXlrb0x6UkNaU0hN?=
 =?utf-8?B?Z2pqLzlsRlREZjVSN1h0NGtEY1k4RytKbWszTWhHNFJrT3JqdHBFTXNncy9o?=
 =?utf-8?B?QzNrVVh0UWM4V3dyK1VTOU5qMW8zWTVubVFwUVdWbXJPamVoZ2k3TG1iYWdN?=
 =?utf-8?B?Wmg1dnpvNUNpd1VZWG5iT1RkUFZyaTdldGJicEVHQ2dqQmxMVlRQdUJUMWJl?=
 =?utf-8?B?dHg5SmV5TWlqeEJCQ0hUaER3UzhiRExaL2lpZ3ZQNmZWcTh2bERiUXVKV1Fh?=
 =?utf-8?B?K0E4NStqb25lMVF4ZHp1NkI2aE1RT05hbVl0RXM1STdReFhvWU5hVklrT0x1?=
 =?utf-8?B?WW9TcVorczF3ajRRYVJIeTVFUHRLdDgwNDJENjNSbzZhaWhsOWRralhRNWVE?=
 =?utf-8?B?WG4xK1Z6OHVERUFkRzZyTWhlTGIrdzdSS3A4YU5XMFBkakRnTkpZTzg1TEFK?=
 =?utf-8?B?dEIvVVhlYU55Umo3UEhhTExDZHFLeXpVWkN5TUgzZmdybmdsOTZNWVU0V2hV?=
 =?utf-8?B?VlN3VERZZGVUVzFIZ01vWjVUVUJhdmdRWmFCNUlrSjlDQXRhMXlXODN2Sldl?=
 =?utf-8?Q?0I2xdIphy5Y6/Dopm/qp3S9I8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4532f50-7350-4171-c1a5-08dd760af3cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:32:37.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyRD/1HC/kZrpqTeepgrvsTRIGBocA1U3TQ3I8hfriRUcrnuKD3/AJ47fGFe0nXMaVYbARufD4/QtskCWcthSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1690
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: o6aAPPKEQvmvDVpTPOr40meuaQU96KJr
X-Proofpoint-GUID: o6aAPPKEQvmvDVpTPOr40meuaQU96KJr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=706 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070137

> There's also the MR relationship:
> 
> Job <- 1 --- 0..n -> MR <- 0..n --- 1 -> PD

Current UE memory registration is centered around the libfabric
FI_MR_ENDPOINT mode which states memory regions are associated with an
endpoint instead of libfabric domain. For remotely accessible UE MRs,
this translates to the following.

- Relative Addressing: {job ID, endpoint, RKEY} identifies the MR.

- Absolute Addressing: {endpoint, RKEY} identifies the MR with optional
  MR job-ID access control check.

In addition, UE memory registration supports user-defined RKEYs. This
enables programming model implementations the optimization to use
well-known per process endpoint RKEYs. For relative addressing, this
could result in the same RKEY value existing multiple times at the
{job ID} level, but only once at the {job ID, endpoint} level.

The UE remote MR relationship would look like:

Job <- 1 --- 0..n -> EP <- 0..n ---------------------- 1 -> PD
                      ^                                      ^
                      |--- 1 --- 0..n -> MR <- 0..n --- 1 ---|

> There's discussion on defining this relationship:
> 
> Job <- 0..n --- 1 -> PD
> 
> I can't think of a technical reason why that's needed.

From my UE perspective, I agree. UE needs to share job IDs across
processes while still having inter-process isolation for things like
local memory registrations.

Thanks,

Ian


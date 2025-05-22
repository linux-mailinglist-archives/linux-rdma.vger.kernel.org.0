Return-Path: <linux-rdma+bounces-10557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627ACAC11BE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DDBA23A5C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FD29AB19;
	Thu, 22 May 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="neXGmHKj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cpl0op+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969F18EAB
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932910; cv=fail; b=Fmfc7TslngKqbjB8Fa7x11kEgIQf9UIH1VA5bu2obj5sbiQ96mlGJWljxhGfhmtKlAyleAkTWHRFVieqdpiZFZsL/2JY2UVRIUOsYvKTDmBQKkIBpivadnBEgqEXy+iOXf2CtmIFck5O6dkMCL/9FaTLXPKwsRlpYSajAhz+YUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932910; c=relaxed/simple;
	bh=OJTqP0asoGtUrcmXLWtuT9O/qJ7CoeWRCI4kR740ecg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDjnNybffeaaMg1yx/JtZO4LThBMbrmpj6Oy+asqa4kV/QPixozUdjc4mgsdZzG8Cavhf1F8An2FC2aRGnsPW0BGdgV+4pSL+xGqzlCaap+fQ/PVCyipmiqYUVut+AOCnJUDwHcQh4UZZRDu2H49LEmDBGFT4Db9Ew7evaT2RlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=neXGmHKj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cpl0op+b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MGqZEe018090;
	Thu, 22 May 2025 16:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2GfQopKPKrTGGnAiO2tuMkSxACEpataUPYErgiFEM8Y=; b=
	neXGmHKj6nUosUDmg5Vz3cVAY6wiNzRxCI2vz4syWIqRFpKc77x4c4sXi9hXtyx2
	5F16esm5Bd9peMmBPgjAd6RZU/GnOb2iNRkYuNs+FwS5e277e5FncvPLM4wrN76V
	sKSz7BfYAFJoUMiGCi15VgmH0osod93uIlMFSjUKSPUBVWOZHkDhwkTLlR4ptvWA
	tOgCBmUQQZrcoxj8Os2V3yUfbMv2uDHjQ08rRqCHrIfd8eXC3I9eK1zW+j/m8cjE
	F1u2ITrAgjVEJSyuT3m/gRkkL3aI+XM9UlCsoyO/Xi/jby8Lk6yq7CSggXh2jGqj
	ZcYNxAadV1A9cWcxfyeBCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t7ts80a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:55:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFlGct032138;
	Thu, 22 May 2025 16:55:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwenx0uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 16:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmKIM2R+Cu93rdPy9cNViTImeDIhv4MH1vhp3jz0dffuT/Bt53CtkbH3U0xoqxH9MZVdB7R0aoa07cdk9axy/3S8AroKrds331TJxyU1WHxvBmzY+P6igSanP/RZxlSbzenemieBUByhw/jUOHXKQXS/0xacT3YqYZF+qa/PtYj4JhFJlt7VRyL5xnDH3sliER8L2eStXHwvnAUjTZjuTN8dmiFD6mGcjZvoF7LJZSMSEXXVNsttUU1k2toQ/eW/giLONNTzVB9/9d8OzCKjcyk2S0xoNqp7V6rpQdZOEeL08G8mI445CTPUxg1q6XFXCKSPUDdcu+bca0z2EUfjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GfQopKPKrTGGnAiO2tuMkSxACEpataUPYErgiFEM8Y=;
 b=lZ4pIepFRgYXFiEA15INoJuwfciL9ByNWwG9nCVJRYpxI4rAH2KFf2toHZDgnXEOTB5y92c7prH/9VysRCHd6Kw/fMzc0og2TlYyewEFNrfkFkQB13Oy88sw3/7sDRKmM3/vMjCYaddJEdKQylDf3x7My3SAW3sU1vl/dfIgjELYiPQg2IpDLRCNuBPXDAB96nUpGgcW0BlU7wpAH1h+fCQR9g8Ku6ykdnE4bNO1rZxATCbF6e70tsEEl9fDsfG+u+2vMzXW/+c7nazebI0otrNzMpafvf0gcVCGZKWZ3o+yQQ6uPzF0LajbQ1nRtbfK4+023VdqX6FXkqHEvMZj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GfQopKPKrTGGnAiO2tuMkSxACEpataUPYErgiFEM8Y=;
 b=cpl0op+bx0vmmxrExJ0/b3KbQJcYNvMVh2paBveUgzxYfE4PA34jjkFxzP7Q/P7NQdIEevJk98WMO3PcJ9ys8vo7Krh31ArcGSoZ7SLdOTt0abshzADXKnCwCKIy2D7akcKpnPG4rNLqjn98M46AsRqFzrwp71KS7j8PcUfVu+Y=
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 22 May
 2025 16:54:56 +0000
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb]) by SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 16:54:56 +0000
Message-ID: <163ed9ed-ec64-4669-bae6-509baed49422@oracle.com>
Date: Thu, 22 May 2025 09:54:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback
 fails to queue_work
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jack Morgenstein <jackm@nvidia.com>,
        Feng Liu <feliu@nvidia.com>,
        =?UTF-8?Q?H=C3=A5kon_Bugge?=
 <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>
References: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
 <0f005949-cf9b-403f-afcb-95be492a8e49@oracle.com>
 <20250522085838.GO7435@unreal>
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
In-Reply-To: <20250522085838.GO7435@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To SJ2PR10MB6962.namprd10.prod.outlook.com
 (2603:10b6:a03:4d1::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6962:EE_|SN4PR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: bc055e55-bd18-47dd-ae40-08dd9951615b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3lXR2RUSXhMQzVoZnYxL3grZXdPSzdCQVJRa3p0czZHWUlDSHkzN0dtcVdG?=
 =?utf-8?B?NUtIMlA5RXJ5aUVPdS9xUk1ra1hpQ2paa0FNc3R6bTNKUzlnUWVRSWhoMHY1?=
 =?utf-8?B?VnhINGdXYWVXeXQ4SWZiMm9xS2NSbHRaS3lrTzY5L25qbW84dVN6QmVLYys0?=
 =?utf-8?B?UmxSQkxmbUx6bys0bVRTdXJLYlphN3FXNU9Hc3ZjSDcrS2R0bFNIZlRkSnh5?=
 =?utf-8?B?cHp1T01aZXh1VHd6T2R1ZUVRVDJqZm9kQmxmOCs1TFBITCtCNDFaVzlkVzBk?=
 =?utf-8?B?NjYyaHd5RDNYWXo0dmplMU9DREhpbkFvMmxjRS8vOU9PTEozUitOeFh5MEd5?=
 =?utf-8?B?VWZZSGtjLytqSFo0ekwyT3pJb0h1UXZBMTFRYm01eXNRdmhhZWJVY2ozL1NP?=
 =?utf-8?B?MittS3J4eThlSDc4OW5JK1h5eXVoWDBQU3ZQQkM4aGk3b2puN3dWUEt6ODZo?=
 =?utf-8?B?TDJsc0w3ZDRuSldhcmZWQmFscytZbStsRkxVQTJ1djdLWW1LbEkxTWFtSUc5?=
 =?utf-8?B?akUySmxCbWEzTnRkR0NmZTZ5VlJsTTFqbFBDRU9nVUF3cFdMRlh2K1lmWTNU?=
 =?utf-8?B?ZjhFSmJrT1Q5dUhORWkvZ1VzRVVQRDZ1MVFFTytWWmhTRWtnWFZwekIzcGVk?=
 =?utf-8?B?S3lPYnl1RU9NSjN3V2t0c3BsME1SY3g0ZEJjaDdnMnppdDMyOCsrR0l1cjky?=
 =?utf-8?B?YmFiMmRlQ0tBRTQvUkRzMDNHWFlyU2VtVnhCQ1EwaVVFclhaZ25KNFpSM21K?=
 =?utf-8?B?TjA3LzJTVFcraGQzYzFLU1lqR2hrRGQvaVNUVXRaRW9vaFQ3Y3ZGQnM4cmRs?=
 =?utf-8?B?S0lBSlhQd1hwVlhGY21OUDJ4SnRZWDJGcEtwQTR4OG9iTWJ1TzFMcFk1SkJC?=
 =?utf-8?B?MTFhNGt4QllqZnFWakdXZXViUmlXMUZPRU1zcHZueTFPaXBQTmNXelBzWnhT?=
 =?utf-8?B?eUcyVktBMGczaXRsRklVSVdpWVkzdGt2ejZPRVE1aWs0bVJnL3VrYjdPWmcr?=
 =?utf-8?B?UGdKMHdLUzBNZmFtUUxaSU9vYlNLKzhWYXg2MzlVYWxRc2JSNHNRQ3Q1TEc3?=
 =?utf-8?B?bjcyOFdSR1JYWGw2RnBGUy9EL2pRblk4dWpPbTR1c3Nycy8wQ2RFb0d1Y29K?=
 =?utf-8?B?anE0RlNudlJrY3ZBckU3UnBnbUI0eXhRN2l2OXBkdUFnV2RKbWpZMnljS0Vp?=
 =?utf-8?B?cnJ3c1ZZaUhwOWNoZUhKVjA2RWFSdHY1VDZoV1lBOHFLZ1hpbDI3aENmRWth?=
 =?utf-8?B?aW5FQTFLK2ZFVitKaDd6TGRrZVU1NmNuZ05wNjU4eE9QMUZnZHZrVW1lSWk3?=
 =?utf-8?B?dVdpZERVSG9LYnlaQWpxMEZieklseVExSEdXKzEyeDNCbDFTQ254bUZ4MEZP?=
 =?utf-8?B?UlhGY1FNSVVvT3R5TkJ1R3EyUkQzTlpBM1RuK2dqdGw5dEpUcjhETGgxSVBh?=
 =?utf-8?B?Y0dyTC9GSTc4SitvVng4aTFEOGpNdmlvWGZ6enFza2VSQTFHMHFuUzVXQUt5?=
 =?utf-8?B?OUQrNG03TWV1bFdzYW8xbk9yQUtJbHJyVDlVTi9OaVF0K1VDVGJHd1F6alla?=
 =?utf-8?B?WDZGWTNEWG5zc2J6OXFJQjE3Tys0ek5nTWY2YkZSdTBVa3lIWTRmS2lkQWlw?=
 =?utf-8?B?L2ZKNDIyQ2kxVUs3cXJaYlg5TTg2REVpaEgrYmlSYlVXcGNOOTlpY1VwMWQv?=
 =?utf-8?B?OWhBTXhYT0U0YWRmYzRudlE0V1Nld1lnTkRKU1VUNHh0NFNadmJ5cGVBazZh?=
 =?utf-8?B?UjlVRnRXVVhXZmdhZzllS3NaaFUxRWM2bDBMQitoYkYxU2R3VHp6cHpla1NT?=
 =?utf-8?B?cVVKcGVpc2RrY0dYNFJHV2Nyb2JzNTBmRWhBYThSVlF1OFNkblYxRWM4YnhD?=
 =?utf-8?B?OFdKTlRiYjlZd1Z0R0V4bG1SR3orVmZveTVIdzlrdC9tYlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6962.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WURQbityMGRaMVhFMmk2MW1zWmR1QytKckhKa3VwV20rNENybzZjb1EvMGN3?=
 =?utf-8?B?a01FQWVsQXdIdE9zZUlyQXlZVjFScHp3TlV2NTU1cVAvSk0ydXp2cUNqMWxu?=
 =?utf-8?B?bXFkbHN5Rjd2amR6WUJtbEhIMGNXd2hqS1BhMFVxZmlZODBOKy9CTGUzbnVs?=
 =?utf-8?B?UDRoc3hBZmhZVGQ5aWNOUzg0TlVxbjRlTjBhWDdGSUI2clhnSkV0S3pQNWkv?=
 =?utf-8?B?eTAwVVVQUXZ0RkVxcFJ5MXBPMEVWOEU4NlI2OVE1Z1ZUME54SWJlUk5YcllD?=
 =?utf-8?B?VmpHVnRONjI5ZjJ4ZDFjSmRyUm84aDBLMkx4VEFEeGFwN2ZoUHBscmdHR2pJ?=
 =?utf-8?B?RHFXTnhEdUtpZmNLc0FCWmxtWkNGZXExajQrTkh6dGxuZC9LdSs4UmJ0VG1J?=
 =?utf-8?B?RnNWOEVzVjdNZFFqNmRNSEpKMmZWaVV0cUUrSUppaENhU05IclBKMWtwT0NB?=
 =?utf-8?B?M1JtZm1ZdVZmZ0xkc0tpRm9VYXd5Wmh1aTV4emdPV2g2dHF2QUZRdlpBOXBU?=
 =?utf-8?B?cTVhM2pSanBZd3RKb3hQL25LZzliTUVzb0FmOFRRelgxakMyQnE3ZU0yYU9J?=
 =?utf-8?B?akRXWCtLMFErcVgrRXdYNEdPYWlpYkVMVytLTmxjRW9QV0h0Zm42elVTTy9X?=
 =?utf-8?B?c1loM1lPYnZwWFhvdkIxMjdQdXpKMjFGajAyditTS3hrQzRJbXZ5TUxnUUhJ?=
 =?utf-8?B?ZUFxQWFRRXozdDdZd0FhYmhsd2xVd0dtLzU3RjMzTjFYK2tJcWsvc2lkRnVI?=
 =?utf-8?B?RnZ4bnVBWExkeGM1bzJCM3daRDRqanlEL1FmRWJJMVlVbmt2QkNveDBiSUFw?=
 =?utf-8?B?RElTZjdyTXJtZ1VsU2FTV3gyaHdna1BCSTA2U2NHZmRSdXNZS0VudzZvRzAr?=
 =?utf-8?B?WExBVUI2RXIwOUp3L3RkRC9NMGVmTXZuUDR3K0M2ZDRiNjQ4Zjl5RS91VHdW?=
 =?utf-8?B?U3owT0dKZWFPUVJPbERWdG41bDBteXhPY0FLemFRNjZpWFZMRnpaQmFlSmxy?=
 =?utf-8?B?bGJETGRmVWZSL0dBNnFPRkRBUnIwY0F1MHN4SGZIeHkvRzlaNVpGN3VwOVA0?=
 =?utf-8?B?U042Yy9iallPc2tsTm5uTVFrbDNwZWsycWU5enBvMFJhNjZCYk1zaXozYWRT?=
 =?utf-8?B?a0hic3NpZktTTUw1dHhYbTR4WDNJbXVDM2s4YWxqM1RBQTFrSGZtWURJUUxU?=
 =?utf-8?B?SC9mdCt5di9RQmdWdVM4YnYzZ2tZZ3M1UGprOGp3MDZPb2NqMkkxK1I0Vi9u?=
 =?utf-8?B?TERka1grOGlLdmlaaU4rVGppY01JT0s1SHhOcU1MWVBXa1RDWkFLeFc5M1k4?=
 =?utf-8?B?dFR5OFQwRFNqNmUzZUwrV050M0szVHdlTm85T05rb2dWT1dSckdENWhhaXpU?=
 =?utf-8?B?LzBQeXpMYXhNWXBaWVF0TS9GaXMzRklOdVMyV1ZqSkorSDAzSjc5c251OWhv?=
 =?utf-8?B?UE4xQityQTVkMEtJci9VbGJGR3JabWtlMkVERTdLdjBxN3lBcVFpNlFTMFVt?=
 =?utf-8?B?VTAreEhGZERKU1l1U2FUOTdINVFUajlZMGU3VkZtY1dXMWZhb0lmS0F0UFA0?=
 =?utf-8?B?OVJQR2JFM3JSVzlrSkF1SWVNcnJUbExpY1pNd0JrKy94eU5XT2VuMXU4bG5q?=
 =?utf-8?B?Ty9jWEpUUjdsOWJUd1EvclVyZzJJQXR4eXBoOUxPdFF1YTBMMGRXRUVLT245?=
 =?utf-8?B?R1AvZlRhSGVSMGRjb0dJUEJ0aXZPR3hucHBUYjIzVW9MUjFDTlhVeDlRRDVa?=
 =?utf-8?B?dXA5K3ZubTdKbXpGN1FxUEhmSlhsbFo2cXhybDU0d3doWXhOVXpHQkJXNGFG?=
 =?utf-8?B?WEMwdkllSzdBMENiWGpaSXBvekowR3doUkMxMFovZVRpK0Z3VjhwNDJubDFE?=
 =?utf-8?B?UWIxcTlTYjlJcy9hRy9nZE80dktvL0k4OHUwTjJlVDN0OHNZZXdnUTB2NzVm?=
 =?utf-8?B?aERUNjE4UjltUjFzQWFFNVlmVWdmY1dDWXJRVzArcTZxR0NEbVFlZTFyYlNU?=
 =?utf-8?B?U3ovYnJuK1hzTXFTZlo1SVBjWUdRM2dxUG5DaDFHN0JSUlQrMEE3Nkl6bW9N?=
 =?utf-8?B?ZTJwMUJXOTZ4M3k2K3ZaQk91TWRoalZBZGQ3NXBmbDI0M0liTUwyZ2ZjcWFs?=
 =?utf-8?B?YzZ5Q0JMRWRVV0prMGxEcG5XVW0wWVMvTE9PTDJNUXJTaVRxanJvZTh5Y2ky?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+peOS2JB1wM98ZF6uB+EmPnrsc+ordj3neCtshJu0+Er4GygQxNF8ODIpHE4BVWU/Ve7olmgim1cu2EGGOIeJY1DJbNKBr77InMyz0xbR7u9eKF9hBWgytJ01o5F/DpnJ6n79iFa42Jto+MVYrc4AiZCWayNwWOPYuDve3rOlvv7PBZ7LAjJpVfhHh/2omT8HhpHRL8Kh1RAIZ1UPLG+psL/55NRZdMLF+jnAnhKOS28hjuMjt+wOOuzaAZmbJXJO1ddRX4YfMxNhrCPNXrXn6tmh7k+gRn8w438RzIcmbMtbBHiNKD0ZYoEhK7dXdHVWd7kYCVN8SS39Sf2dcpYpULbOFH49iUIZc040hnDnFfdaL62FqvO15NAe1cOa6r+ZtW34ZyNvUC+32/JRjO6gaDn8i0nKK0UtqHnEFfvuDNv6ttjehw8xvZts2DQFDGzn8GcmfUNkILp6NfwoNIGi/b3JFYKvEkNMnrA00/PiCpDMDqT6I83DZltDesA4b2bDPqfLO6zY2p7Kk95zdER5EXn2H9zMBXk7/z+EXfBsCXpJPNarzBoygsHrAVWIY1RK7laMZtlyrU0ELXNbxd/JGGkLkF6I9Ng+XbVyPiDRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc055e55-bd18-47dd-ae40-08dd9951615b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6962.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 16:54:56.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6X0VR0Pi8AzlWaADdMlJh+xSgpjVlMuCXv2yW56+d4W7VUed4OQAPKPK5DrvsN+gs86HEE9Xkp4N7inM5BdAYafD8FY5u2VfsBxU00q4nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_08,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE3MiBTYWx0ZWRfX9qN/Puo1ECWE VoQlBDjp5Muht7MrgncHMQBdx/dLHFRXtYKpKzKnl5iPDUSYNkK4QGhSn6dfBaiQxK0VPKlR8uu 43tz21AhBtYesALiwfKo2dhMCNxHllGB9btSR8EbjaATGxa9n6llNx8nGEsnmkzAHYoYm3Zk2PX
 ojI4iLiIWrdU8XtxxIXCTmraSFD8K/d7UTrh4X2NKJcNLSIyt9S0jpua3V4VVFbcMWE9dpOpUcR Tzs4LTBLm4MWs+GjGfOstgwDFWTGKKDEo68/gLfO/uSSB3NuklThiJBnUQDmepjxRurSauiFb4a n898FKBxCh0p1kLuO9dnB4gMSS46xqaWm6645Yvhm/4ESvJ53ynOopx/9co0iLg8LkyRcTgKbag
 CZcd0C8n1TqNOfLmR5cjVBWyZ5CxnUWvEy0zttSoaVrfqXDIVybl4mdZvK42fhrphyax3afY
X-Authority-Analysis: v=2.4 cv=JvrxrN4C c=1 sm=1 tr=0 ts=682f56e6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=wuUyMCcgZeamHSX2BykA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _48k3UwUTlLJk76jtSkhqIoH4VJla2UK
X-Proofpoint-GUID: _48k3UwUTlLJk76jtSkhqIoH4VJla2UK



On 2025-05-22 1:58 a.m., Leon Romanovsky wrote:
> On Wed, May 21, 2025 at 11:59:22AM -0700, Sharath Srinivasan wrote:
>>
>> On 2025-05-21 4:36 a.m., Leon Romanovsky wrote:
>>> From: Jack Morgenstein <jackm@nvidia.com>
>>>
>>> The cited commit fixed a crash when cma_netevent_callback was called for
>>> a cma_id while work on that id from a previous call had not yet started.
>>> The work item was re-initialized in the second call, which corrupted the
>>> work item currently in the work queue.
>>>
>>> However, it left a problem when queue_work fails (because the item is
>>> still pending in the work queue from a previous call). In this case,
>>> cma_id_put (which is called in the work handler) is therefore not
>>> called. This results in a userspace process hang (zombie process).
>>>
>>> Fix this by calling cma_id_put() if queue_work fails.
>>>
>>> Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_handler")
>>
>> IMO the above Fixes: tag should point to the commit that introduced the line:
>> "queue_work(cma_wq, &current_id->id.net_work);"
>>
>> i.e. Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
>>
>> and not another bug fix (45f5dcdd0497) which did not introduce the problem being described in this patch (a missing cma_id_put() when queue_work() fails).
> 
> It is not, according to the queue_work() description and implementation,
> that function call can fail only if this work already exist. Before commit 45f5dcdd0497
> that cma_netevent_work was always new and hence can't fail. This is why queue_work()
> returned value is almost never checked in the kernel.
> 
> Thanks
> 

Thanks for clarifying. Makes sense to say "Fixes: 45f5dcdd0497".

Regards,
Sharath

>>
>> Otherwise the fix looks good to me:
>> Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
>>
>> Thanks,
>> Sharath
>>
>>> Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>>  drivers/infiniband/core/cma.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>> index ab31eefa916b3..274cfbd5aaba7 100644
>>> --- a/drivers/infiniband/core/cma.c
>>> +++ b/drivers/infiniband/core/cma.c
>>> @@ -5245,7 +5245,8 @@ static int cma_netevent_callback(struct notifier_block *self,
>>>  			   neigh->ha, ETH_ALEN))
>>>  			continue;
>>>  		cma_id_get(current_id);
>>> -		queue_work(cma_wq, &current_id->id.net_work);
>>> +		if (!queue_work(cma_wq, &current_id->id.net_work))
>>> +			cma_id_put(current_id);
>>>  	}
>>>  out:
>>>  	spin_unlock_irqrestore(&id_table_lock, flags);
>>



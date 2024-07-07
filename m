Return-Path: <linux-rdma+bounces-3686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83212929727
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26631F215A3
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38467F4EB;
	Sun,  7 Jul 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="dKwt1PsM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cluster-b.mailcontrol.com (cluster-b.mailcontrol.com [85.115.56.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD56AB6
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.115.56.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720341824; cv=fail; b=Bcai8u2haE7KA8zj+oTV1vsXr6ah4c4/EFAHn7HMxcPiN50digs457r9FoL5x8cxrc0YjcxJPDH9qMCFCrqGwfsEs+HFC+r+hajJYeEJsWpb2tyCOo/9X4NedBmidWfam9Usn3uo9ym8FsNHteQAPbMi3uiFyqxKD540otCVAic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720341824; c=relaxed/simple;
	bh=aerWLPPPq7CrDcsxmqFEjJo3zRjdGjNkeRl7I86aJGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcTYnRW0p1L5sYKVWiCQDq1XNgeyrFmcTVX+7aP0MaMegoGhA1+yn5viLu+6sOEhAVloa14XR8oldmOkfQtPE1hKGYz1XVjJdpGlH5jz/c47pV9JiTfy45gN0PB5jzxDYQUL6z2GyLPrbxtYx0FAEqVMLxRqrnqHHUkoh8vacgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=dKwt1PsM; arc=fail smtp.client-ip=85.115.56.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: from rly03b.srv.mailcontrol.com (localhost [127.0.0.1])
	by rly03b.srv.mailcontrol.com (MailControl) with ESMTP id 4678hOBI043115;
	Sun, 7 Jul 2024 09:43:24 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly03b.srv.mailcontrol.com (MailControl) id 4678h3QB038145;
	Sun, 7 Jul 2024 09:43:03 +0100
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
	by rly03b-eth0.srv.mailcontrol.com (envelope-sender oshpigelman@habana.ai) (MIMEDefang) with ESMTP id 4678h2Yb037853
	(TLS bits=256 verify=OK); Sun, 07 Jul 2024 09:43:03 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0eENhI3NbiO+1GjlToUkgAQ4+DONWi/qt5NEIpLBbGQANMYxG7/UYmwxrNlpiDD5xD6btTr/gGaO2hmEobqCDjo/8P16U7pOns3T4EkVLUrmmMEoREFbPihjpzlqRnMiI2oKSDZD59VhKyMdQj/lC3yfhbqISKUhx3tN1m1qP2KuJWW9ELP2weXx9L6nLl8bl39R6w1ov8bkXCP1mmOl774SgQ7hywPLKcGvqGfx5MGnn1m06pSXIIguTiIMpN1fqjYYz7FBim8NPhlya3QS8Kkmr53VeVqJYuOB8ESn1oe+ZYUs/L4IrhvHkbYRs3iFbO/V4R1n8687BYpHpH+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aerWLPPPq7CrDcsxmqFEjJo3zRjdGjNkeRl7I86aJGE=;
 b=aDtxYr69MPfpen3OOLsw1heE4/KLWwCNzkfVk9bwd4EDFQH4fQRMFvOd3BwEb5GkT9rK0TqJurMujGx+LS/9eAe52pPjvFN1Ab31emQt1MGG49fKG/jri99VaHTLb82WZ5elA0+fVV5ieJ9DTZs6DOhESh5zk9PjcT++TN62K6afPtSBjnkVM8YBvZaXnWixFpxiN83DUdwV5zfWLcetnQIQl9AxE4O9/WG9yt5HvEyoWOK25uyKYjEUTAiEWoAFU7iZKiSdCDJNAM84VP9P8hujjns6ZTmFVKtGZ6A5tm5/HrkFL7EixJAqH4UIaYBvzzGGEfxeMcBpcNpZevMgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aerWLPPPq7CrDcsxmqFEjJo3zRjdGjNkeRl7I86aJGE=;
 b=dKwt1PsM+Gx2wgTcV+wf7MVM44mYaID+yqR8/X5JQE37T/QT3wLW3b+D/qkUqrm0Dr8gvKpMeoheMvEBT76hABkjsDuxIPFnSjTaPEAkP78NBwbLFv4UfhA1OCJONOYAFdyMvRjy8siQzBuFq2Ys0H29UlUCYG+nRB4dO/SBg5pE+3P1T/nJOo12f7JReg5jh0xIZ3bauvDNyQaML32QmH3omRY3ESxr958opMelVtjw0ntKnVErW8W67FJTS0bazO4sLTlO6B/WwxUEggb9vViib9Qnjyrs9V26KEou6bp2/YJ2q6JDxHNcuJT3wHXg+8EC8t6r9scSXSftdeQHoQ==
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com (2603:10a6:102:33d::18)
 by GVXPR02MB11063.eurprd02.prod.outlook.com (2603:10a6:150:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 08:42:59 +0000
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9]) by PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9%3]) with mapi id 15.20.7741.031; Sun, 7 Jul 2024
 08:42:59 +0000
From: Omer Shpigelman <oshpigelman@habana.ai>
To: Leon Romanovsky <leon@kernel.org>
CC: "ogabbay@kernel.org" <ogabbay@kernel.org>,
        Zvika Yehudai
	<zyehudai@habana.ai>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Topic: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Index: AQHavWrPBqHPlb7SS0KqSAV7MpL0ALHmf8YAgASMFACAAAyngA==
Date: Sun, 7 Jul 2024 08:42:59 +0000
Message-ID: <e27efbb9-fdf5-4447-87ef-71e0fc34bbb4@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
 <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
 <20240707075742.GA6695@unreal>
In-Reply-To: <20240707075742.GA6695@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB9149:EE_|GVXPR02MB11063:EE_
x-ms-office365-filtering-correlation-id: 48afd934-9026-4018-2d12-08dc9e60ce2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TmwxNmlIVS9RME9kdDJ5TDBqNkEyWVFEUEM5elduWk5oVFY4TnVtemdrQzR4?=
 =?utf-8?B?RHVPTzMwZk1xL09sTG9LTWVucHR4djA1NW9ETFROMnhYSXhLdWVTWGJPcXVs?=
 =?utf-8?B?WmZrc2MvdkNrcEFXcFk1d1NJcVV4K254Z1g0VWZnVUxOMlY1NjBhMlltZnhr?=
 =?utf-8?B?VG90dmFCSVJ2THJrcWxndW5ScERWMWZza3B3czBHUWY0UFNzeGVFRWc0a0tE?=
 =?utf-8?B?MENFWUwvMGRINTRpOXAwczRSN1lsNU9DejBBS3ZKQ3JORUtpR25IK05TQlEr?=
 =?utf-8?B?OVA1ZVN2eGpYYTdqSlNGY1l0cVc4R29GajBpQXZmQ1VIR3JTMHRVQk9CK2p4?=
 =?utf-8?B?a09xK0YxMSs4QlRKOGRIWGtOc0t1dzZYNmoyemwxNGtucnc3ZnBPRmxGaGVM?=
 =?utf-8?B?T1podkVYN1hJazlnL2JRbjRZV2cxZXFlT1QycWNNWHU0ZldvbXpNREUxZGpt?=
 =?utf-8?B?TGRjR0U3d0g3NVhqNm92SFJEN2ZZSHB3YytReENablBOckZ5L1ZzRE5MUXVH?=
 =?utf-8?B?QzQ3bmN3UzZPTTJlRnVsVS93Rm1GOVduNDhBdUpPWkNSWDJVdHpSYWx5SWs4?=
 =?utf-8?B?RE91eDBLVFlQVTdzS29RYUVBaUdkUExRb0NJOGIwdERUUmNpMmE1ZXEzWkIx?=
 =?utf-8?B?ZHFXb2RzMTNxc2h3Y2h0UU5aeFpUZ0JuQjNtVFA2dVY4VUtLck1BNERiZEor?=
 =?utf-8?B?a0ZNT3pUVDJPMHdySUVic3dYa2I5ZHhMcXhqQkhMTnZ2NWxuUWh0TkN6UGZF?=
 =?utf-8?B?Q3ZpdGZ5b2VxdGllejgyTHBDYlJQa2hDa2VSV0ZkSTROcDJNTkRXVkl3QzVh?=
 =?utf-8?B?UTJFM090WnVSckEyWU5HcWJYQ0p6TGhVTWhNZGFUOW0xdkw2eUlsY3E5Umxl?=
 =?utf-8?B?KzlhUVRFY0VVY2pPNyt6UzBRTlM0NkZXRG8zc0dicExnaWJpUllNZjJwTWR0?=
 =?utf-8?B?RUVLMGhSQVR2UW1SYVNTeCtkYW5lNXZjVnA5U3RMU2ZJZ0x3aHlLbWJGTnNT?=
 =?utf-8?B?dEhjSm9zVVBPNjArZnhyaDRqY3lhUzR6YlpweXJkTlpISGNiNkdMMkxZZnBu?=
 =?utf-8?B?UkoraXhuVUpKaTY4dldYZU1ML0xCOUpMaFd2M2t5TUxFSXNaQnF0UHFUZjBZ?=
 =?utf-8?B?QnhyRTJIeUQ5dDBzYXlQQXlOKzhNbjRYNWVvaHMvMnllSmw0YnpCRGxwYkhs?=
 =?utf-8?B?Z1R0dEkzcGRMM1B4N1JKQ2VrczNBdXFDS0hSTThGWi94NmYrd25Wb1hsMUFH?=
 =?utf-8?B?eU5DdlVKaWJDclR3aWwwZWZxUHowd2pQWDI2MFphRmtwM2lXYk5BUmpKb0Vm?=
 =?utf-8?B?MnF5QXZsWWJGSm95Smxyc29Fajd6Nm1aRmYyV0dSZGxRVTdkajhReFM1OFQ1?=
 =?utf-8?B?R2FJc2ZQbTM2OTNYblBuTE1TdXN0eUVJbzAwSzRGQjVEM2d3RXhQNHduWitn?=
 =?utf-8?B?b0FOTlhGWnp6K1dmMVkzSW9OMDNDcURRa1NIV0FiNmpzWGkwYXFUd3JINWpM?=
 =?utf-8?B?dnVJVHpnNG01ZEd4UUM0alFxV0ZHdC9jT1NrbFRFRU56dlN5UDFLQ3RxblF3?=
 =?utf-8?B?Q3NBUStiR3FaV0tJSThXSG1tVzdoT3ovVUV3aFc5ODVlRk9MUFhVd2ljRXZT?=
 =?utf-8?B?eFg3VE9NNzU1N2FacU1DTWNWSXFxeTV0M3hQVTMvWUZnWUFEUVh5WHBRYXFl?=
 =?utf-8?B?eXNMeHgvVXcxcEJEOG1RT0ZYcUdLVHpERGpzTzk1RVA3MngwN3NVTGdPTHFw?=
 =?utf-8?B?T0dxeVprbmFZN3psUU5xSkdPTVJEcnMzZy81VXhOTEpSS0FkR0E2YW9MOGJp?=
 =?utf-8?B?eE1OSW5OcE9idndJaGZwTHNIeDRUWEJFOElyUjQ1NkpITHY3WWEybGh1SDYv?=
 =?utf-8?B?RkcyN0hBMHdDQ3FRK0NLSUVVcHFtV2MyRmJtdlVwc2pDckE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB9149.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WnZqMmdYbTVhRnBUbmdWV05LLzZWQnJjZkk0N3UxTDg5aEhTWE5Fa1lEZjFq?=
 =?utf-8?B?eWpyN3FEamtIaWZYaDRzUlB3d1FTTnVUQ3paS1oyT0ppaHlHL3l0RFRvZytX?=
 =?utf-8?B?ZWlvMnNjbElGeS9vV0NTTldBNFJjczNEL09VTld1ZHZMRGNzUkJHS0dXYXBh?=
 =?utf-8?B?UlZLQ1JiV3MvMDA4OWwwdHpWRms1Uzhud08wSnhMN0JZTGN6Z0xJM3loWUZp?=
 =?utf-8?B?Qk01TGlVSHNJQi9tYTNxNHYwZjVZZitxdFJLRCtGNWNaZytiRWRrWlgwQVlB?=
 =?utf-8?B?ZUpZa0owbU9rY2diVmdBcjcrd3hPY1B6eDdkR1JYcXh0NS9YV2RTNHU3ZlJ1?=
 =?utf-8?B?VDlLamI5dWpDckorYVhleDg0c1dTQUhUMWUrUWVGUE5CM2ptL1Nxc2FCOTVH?=
 =?utf-8?B?dXk1cmpMd3VrN2MvcmFweWdvaHoyb1BWY0hqbEwrSHkyeThUQWtDZUpDT3Fz?=
 =?utf-8?B?bHJMM2dCUGM3dW5QR21xcGZEZ0VKb0F3ZG5HRm9zZy92bmltWVc5WGxnT1Nh?=
 =?utf-8?B?VzUrOTJsdXBqaEZ0enhwZEd1WUdHeGJJUVkvUkNRVURuUG1pUG9lOFUzeDhD?=
 =?utf-8?B?NUR0clRpTENCa0F1RTZWMDF5dzJHdGs5b3VDbFY0RStJL3dUNmxMa2h5RVFF?=
 =?utf-8?B?Z0k3aFQ0ZHdTMVU0Z3gzc0grQXU3SWVSbVczSytGUkdCRXFzaktlazYrTmFv?=
 =?utf-8?B?cXpRMVFwZFhtS1lvWllycnRPWDFJQzVSazAyK3dNYjJGZUJIVmwyNC9HUVJW?=
 =?utf-8?B?dkQybjl4WWU4VGJZdVhUVVBhV3lvTzI3UjNxY095NjU5SVlLYWkwNjhtbkw2?=
 =?utf-8?B?WUhKTGxyQnZFdW5GbGlmYzQyY2RmSU02ZitQR3FKUjMzYWwya2VvbGZPOXNZ?=
 =?utf-8?B?a0ZYVkJjWHcxWEJ1cVlpejhjajNHYUFKNUYzdXdRVUlaZUQ3NXk4V3pjdG5H?=
 =?utf-8?B?OHlRZDBXRndyMkNJYTkyWTBOa1dGS0RPSUdmTHhUWkdzKzd5dTdTdjBHMVR5?=
 =?utf-8?B?cnBTN0ZCc3lpTS95WXJNMTR2bis0NzlJMy9LbWVnTXpmWEpJZjI0Y3Q5anRP?=
 =?utf-8?B?aGovWk4wSU9LYWFZSUhpeFdqSW9kemdGNEVRQ1FabmNTMVhhYWhOU2Y4Mzgx?=
 =?utf-8?B?Z1pFWnEwK2tGTWU2eUtiVDRGdHhOVWxJUG5zYVVNelpHUDdaTVdOY0F5NDRK?=
 =?utf-8?B?VWV4SUVXZ3dNTHdqS3ByczJmVHYwclBDNjVQandiR3RZdlMzZUhrSjJOYWxi?=
 =?utf-8?B?QVlNNnpoSzdidEVqM3F6K3ZSK0pPUXd5Mzc0VVJCa2c0OWdhRjNGcFF4QkZ2?=
 =?utf-8?B?MlRaenVGcTJEdjVqaVpQbHBJdVBVTFQ1UDVLakxWUmg0b3lxNGpQTXFkZTQz?=
 =?utf-8?B?WGVBTFFieEgzRzJHeU5XUllRVFZrV3VYQnl3bnRld2VuSXFsVWJOTll0aHZJ?=
 =?utf-8?B?M04yT3ZETkF3SWs1WUIza3RsdDIrSFdpSHY5emI4aWJmaDkyZzNaU1ljcm5V?=
 =?utf-8?B?S0xLQ1ovR3EyRDgyQVZYUXFveS81VmxBM1dBV2I2OWpCT3Y2Tk5Ldk9ITnZP?=
 =?utf-8?B?REpzMFR4RStiOXNMUEFOSDlVY0F6SmE0K2hnTUNUZEg3WERkZHgzcFRaSFQx?=
 =?utf-8?B?WEs3Tkk5eUQyWCtla09nU1pnQndERENpTGNGdzdwdElSZU9NZ3c0SDVBblhk?=
 =?utf-8?B?dDA3d1pNeks3SnBJdWNmQmUzZUlaeGk5VndPUUtxTU1lamlCZ09nTTYzb1R5?=
 =?utf-8?B?a01RdzEvNEtHWXh0cWhMdzlBMy9qRWNBVkdLZURhcVplaVFlcVZ4dmZqUE83?=
 =?utf-8?B?eWd6VDcrVEZITFZyd0VydFVnQ2lYU2dZQ0ZXeU1LTkh1VHlZZlpiQ0crMDlK?=
 =?utf-8?B?ZDgxS2MzOEQ0bVBtNUsvbk1veFBGY3J6SnFJVEVrK1NaT1dLNzh4MWp0ZVBF?=
 =?utf-8?B?UTdLdDNHN3JYZ0dZN0VDYklTYzhTR2U2VDlyUnBSaFErZzB4MDMwZFhoY1dE?=
 =?utf-8?B?Nk5DSW1BdUg0NWF5Wnc5VzU5RER2bElseGx0b2o4U0ppa2tlWm5oVWZNak1P?=
 =?utf-8?B?NkhJVHhOS1ZMbVY5K3RYVkhPOGxhbEpqeldiOXFhaHZTb1c1aWlPSDN2MEg5?=
 =?utf-8?Q?pW2K2nDet+pHNRNtmUTPUBrgv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35CADC5555023E4FA7C82E2C07A82971@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rBybDxWguT9OKZDwMczi+SYjTs6tDR4eUZYsAXG3dgX3DQeYuZEAQH3Q3Z9W0kOG9G2EjKs7NWbkuP3YEEKzw4921p1g1x5MPJ2hNYg1ygrKBCgBEzg4h1Ve41VvlEGDRFanG0gODK1Gu54jMuwmG43oBkXkVbB+25hy5n0oGPGWTG3XONjRp1ICs3H66dIYT2yFReAFMBG1uDpMNPDma8q9mTuMhLS1QNvju1edjUplJzesUg4+CwHDvErEmuoXbPtXamC27Y8ZbJ8HQBmgWiigTPRkN4vdlofxUvu9veyDMc0AAVIozAAy8CL3QJ04C92GwjH6HhBiEyDUmWO4FP2T6DO/LwInLxldYQneT6OY+G/LfYHyFwUekfd8zYriEV/vUaqLTmShz5vfUL4ZyeDOV7re2H7aMdnve3oEeC0FqyGBONWXPo5+oWlcgnB9bbaw3+pANbIhCOQD9tazd1pwUI3r6YnFODuYdTDpJZXVw7F6TfDr/Hd/IpKnahN+xCnIGTl04mgFFzWfrFYlRDpciLbZaW3mBtPIKMGTyPPGcG4KIfWu0paUyCOTB8P6B542iEAbTY6eQrk2gb0Y5NnEsI17dfYTR/9icFyRf4neg+6kmugv+XnMXtsdtySJ
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB9149.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48afd934-9026-4018-2d12-08dc9e60ce2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 08:42:59.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWH/jM9ZwiLYX44JxUYgJkSBtrvNjqFqVR7jQV1pnjCjsK8a/xOD+fXi+Sen/ra0cw2IcQjKedKxokHXIj5eSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11063
X-MailControlDKIMCheck: cGFzcyBoYWJhbmEuYWkgW3Bhc3Nd
X-MailControl-OutInfo: MTcyMDM0MTgwNTpGUEtleTEucHJpdjod8Caawa1CZ5z3lIiBwKkDvAzN+Nc8Lq49bFUr0KsILz5TAIaleG4cY0tVAGRmfa5BAhKnUXjYBL3QwNnmLFVY6S3BuIuu+5No+/vQ+aVIOCmfzU4LxW6LyYDIaY2cXJYckudz9yfjgeYYMpKA06nk4NZHSKQDnUrzTmld/37PAtZaW3T+vVS3pa7YO9Upfg7czNiVKf/hnophpcEAuCgVnUjNZ0jcG4yPtiGEBVKWoqETcsEyAxUBFFHOIr8JDFAo5NEFCgoko4N80awPga5O2SNC63rJ08fIB4SomikRJ2sk5NBjh1N+YHj+A69bTtY80eKuPQpmrSBP7E8CwCpT
X-Scanned-By: MailControl 44278.2145 (www.mailcontrol.com) on 10.66.1.113

T24gNy83LzI0IDEwOjU3LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIFRodSwgSnVsIDA0
LCAyMDI0IGF0IDEwOjMxOjE4QU0gKzAwMDAsIE9tZXIgU2hwaWdlbG1hbiB3cm90ZToNCj4+IE9u
IDYvMTMvMjQgMTE6MjIsIE9tZXIgU2hwaWdlbG1hbiB3cm90ZToNCj4+PiBBZGQgZGlyZWN0IHZl
cmJzIChEVikgdUFQSS4NCj4+PiBUaGUgYWRkZWQgb3BlcmF0aW9ucyBhcmU6DQo+Pj4gcXVlcnlf
cG9ydDogcXVlcnkgdmVuZG9yIHNwZWNpZmljIHBvcnQgYXR0cmlidXRlcy4NCj4+PiBzZXRfcG9y
dF9leDogc2V0IHBvcnQgZXh0ZW5kZWQgc2V0dGluZ3MuDQo+Pj4gdXNyX2ZpZm86IHNldCB1c2Vy
IEZJRk8gb2JqZWN0IGZvciB0cmlnZ2VyaW5nIEhXIGRvb3JiZWxscy4NCj4+PiBlbmNhcDogc2V0
IHBvcnQgZW5jYXBzdWxhdGlvbiAoVURQL0lQdjQpLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
T21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo+Pj4gQ28tZGV2ZWxvcGVk
LWJ5OiBBYmhpbGFzaCBLIFYgPGt2YWJoaWxhc2hAaGFiYW5hLmFpPg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IEFiaGlsYXNoIEsgViA8a3ZhYmhpbGFzaEBoYWJhbmEuYWk+DQo+Pj4gQ28tZGV2ZWxvcGVk
LWJ5OiBBbmRyZXkgQWdyYW5vdmljaCA8YWFncmFub3ZpY2hAaGFiYW5hLmFpPg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBBZ3Jhbm92aWNoIDxhYWdyYW5vdmljaEBoYWJhbmEuYWk+DQo+Pj4g
Q28tZGV2ZWxvcGVkLWJ5OiBCaGFyYXQgSmF1aGFyaSA8YmphdWhhcmlAaGFiYW5hLmFpPg0KPj4+
IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBKYXVoYXJpIDxiamF1aGFyaUBoYWJhbmEuYWk+DQo+Pj4g
Q28tZGV2ZWxvcGVkLWJ5OiBEYXZpZCBNZXJpaW4gPGRtZXJpaW5AaGFiYW5hLmFpPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIE1lcmlpbiA8ZG1lcmlpbkBoYWJhbmEuYWk+DQo+Pj4gQ28tZGV2
ZWxvcGVkLWJ5OiBTYWdpdiBPemVyaSA8c296ZXJpQGhhYmFuYS5haT4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBTYWdpdiBPemVyaSA8c296ZXJpQGhhYmFuYS5haT4NCj4+PiBDby1kZXZlbG9wZWQtYnk6
IFp2aWthIFllaHVkYWkgPHp5ZWh1ZGFpQGhhYmFuYS5haT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBa
dmlrYSBZZWh1ZGFpIDx6eWVodWRhaUBoYWJhbmEuYWk+DQo+Pj4gLS0tDQo+Pg0KPj4gPC4uPg0K
Pj4NCj4+IEhpIExlb24sDQo+PiAgDQo+PiBJJ2QgbGlrZSB0byBhc2sgaWYgaXQgd2lsbCBiZSBw
b3NzaWJsZSB0byBhZGQgYSBEViBmb3IgZHVtcGluZyBhIFFQLiBUaGUNCj4+IHN0YW5kYXJkIHdh
eSB0byBkdW1wIGEgUVAgaXMgd2l0aCByZG1hIHJlc291cmNlIHRvb2wgYnV0IGl0IG1pZ2h0IG5v
dCBiZQ0KPj4gYXZhaWxhYmxlIGZvciB1cyBvbiBhbGwgZW52aXJvbm1lbnRzLiBIZW5jZSBpdCB3
aWxsIGJlIGJlc3QgZm9yIHVzIHRvIGFkZA0KPj4gYSBkaXJlY3QgdUFQSSBmb3IgZXhwb3Npbmcg
dGhpcyBpbmZvLCBzaW1pbGFybHkgdG8gb3VyIHF1ZXJ5IHBvcnQgRFYuDQo+PiBXaWxsIHRoYXQg
YmUgYWNjZXB0YWJsZT8gb3IgbWF5YmUgaXMgdGhlcmUgYW55IG90aGVyIHdheSB3ZSBjYW4gYWNo
aWV2ZQ0KPj4gdGhpcyBhYmlsaXR5Pw0KPiANCj4gSSBkb24ndCBrbm93LCBuZXcgcmRtYS1jb3Jl
IGxpYnJhcnkgd2l0aCBuZXcgQVBJIHdpbGwgYmUgYXZhaWxhYmxlLA0KPiBidXQgc3RkbmFsb25l
IHRvb2wgd2hpY2ggY2FuIGJlIHN0YXRpY2FsbHkgbGlua2VkIHdvbid0LiBIb3cgaXMgaXQgcG9z
c2libGU/DQo+IA0KDQpJZiBpcHJvdXRlMiBwYWNrYWdlIHdhcyBtYW51YWxseSByZW1vdmVkIGZy
b20gc29tZSByZWFzb24uDQoNCj4gVGhhbmtzDQo+IA0KPj4gIA0KPj4gVGhhbmtzDQoNCg==


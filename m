Return-Path: <linux-rdma+bounces-22996-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nb0MINPDUGoB4wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22996-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 12:05:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E797396D2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 12:05:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SgpCF5VO;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22996-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22996-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5579D300D4F1
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1413FD97A;
	Fri, 10 Jul 2026 10:05:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD03CCFC0
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 10:05:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677903; cv=fail; b=M296zmuqy4/KlW+cxVuvGEw93rBftSYyWTxR9fkrZugut8a9ifav8Y6DjmPbl1FXvI5hCoY3Ko7TRisFdEiLcWXhiWIBztvciM2cike+WmPIOaXISMEQypqdupF0A0ouZoDyYE0AuaIpQTvkzOyWR8A1dnAAxhqjim2z3C2cYOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677903; c=relaxed/simple;
	bh=Q2bGXL2t9MDmntJpdUiYcC18HAkEn4nHGvjE3i5P6Gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNY+jcjLt9wcutOq5ipzSPpUb19LuMSQTUmeTFdXcb/rF70YIP7AClc32JOy1g1yACRbS0OSIOmwFx0emUR+Z5OSKaWvj+KJ/ImXd+SoZUL1lsUGXMiDjBl6JZXWkJkKfdKgZBY0zlbWmME+OdwzE/IR1U7kupYqbcylMuHUbMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgpCF5VO; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3JOSGiv0fPOSlife+KUpdaHDYVepAYTfAq0EPnWd7Uef2wcKlzLv2VejHibTE3xbrSfuVvzXQUsS/EVX+fMWAfhGkQu6ch2yeFeNezAaQrCPlsjMiESRdXBRGoqE1E9OhKbDHosUkUScP0uPV+eVomnMqbOYQA7cjzDFsvRnhSAYNEsulpYGFaO2b10febUyDdxyXkgzMHGZKrOs6PNSEPIW7JW3tZ5NiF+arTLXz2EYeiQ3VWlPhZ72/2DTGnvnuy6iyK8my8q74CH3GZdGEOO4ZQjE26Ee6GWupEOuDTw9MsBOlmKM8f1FoekVIII8LTXyBm9ZQEVO1mgWfqzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huuFv7VHKwWX2EaFKb6VwmtWKyzNTL/TvVYSUJsokL8=;
 b=yy442HQGzdInuon9OlhoDAHNfXO1t+Falp2P0lq2n//YyKqshEP8NNNhMSEhhXvdybTlh/kzxpKrHj031tdbek1GcvPTIqhWLquw4wlkEx2D8b2etnYBSo6dDhLEHqklh13G2yM3JBhJksjM18A1fdzQUS3I769u6x34jBAbJcV8dXkw1+1CJTEm3fZ38Byj37wMGyn7yPMtTtxEf/pj28IomzHleIPN7b79TjVjs+Qpv4TUzgdIybhrt8NSkAXR6vTQTNuswN1+G1oC/zggzhghXgck32jVSSUfc3jzQkLu7DO+qJeNeATvE9BizoRg6vFljGnQZ1QHgUXbzVWN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huuFv7VHKwWX2EaFKb6VwmtWKyzNTL/TvVYSUJsokL8=;
 b=SgpCF5VObCR1OUh/rOxhGRI/SlFHJVzawh0Pf0SkI3p6W/CEs2ThH7vD7fKeGHK9qck6nXYH4l6rywj/JXj3F7YqUOvX5uxXbrdZnvlWn4POVCHQpSFE30hLG0teGOnA7zli8q/uedFBbEQ3jDOArUQt1z/QVuzJMFLB5UR9UcUR2hZVWA0DlkUfzj5opg5PTCzY/mKDY0qNtlRWKW1YNnLywNWM2tPa/QLQ4ZCo8XhQAAYauQjsL660hP1gfj4PY6Z79WBVwbnxhWIWFJxRGYdMY9GdKJF/LHZZoXELWA/8sKyjfLzyOgIXT6GwQlP5zfo0SbU9SdeWmzITCw0xag==
Received: from DSWPR12MB999154.namprd12.prod.outlook.com (2603:10b6:8:36e::21)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 10:04:57 +0000
Received: from DSWPR12MB999154.namprd12.prod.outlook.com
 ([fe80::da86:3441:f63b:da8b]) by DSWPR12MB999154.namprd12.prod.outlook.com
 ([fe80::da86:3441:f63b:da8b%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:04:57 +0000
Message-ID: <0104f0d4-060f-4554-ac60-3db4bbb519c5@nvidia.com>
Date: Fri, 10 Jul 2026 18:04:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net/mlx5: Change TTC rules to match on undecrypted
 ESP packets
To: Dan Carpenter <error27@gmail.com>
Cc: linux-rdma@vger.kernel.org
References: <alC-NENMq3PjalQV@stanley.mountain>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <alC-NENMq3PjalQV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::17) To SAVPR12MB999143.namprd12.prod.outlook.com
 (2603:10b6:806:4e5::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSWPR12MB999154:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eca48f8-adaa-4354-772a-08dede6aaa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	e2AsLoukm1wwryd4Zzjq44Rc/IoYiD9CACXh4QJpsQ/i1W7/51JPVMFW5Cq976RCbr964dJPFg47qu0KS/1+jWPqd3Y+/j0OqZP8Tffu/vaiv+U4+8adLSFw53cSn8DXgfr+ug6k9SYQhl9UQbYkfMAVV0KlSgEdQPa28mV2XB7ih2F9EHPHA5HNQ5ker+e8oBy2w0c0pk6rR9LPa0Ew1Y3duYh/UAWE/LpWWT7osudSISqJWGXuAyxt0/Tx2fSRaJjk+b/26aN67ncQTz/28tLwP+0amhLsuJquU4q9yj3ng1zrJcjQ/ZH5hs5JEfPqr66GV8n9g6WT0fOBwpzn+LdqRJ8+/CTHph/hyv4ifbaHujw7vYagKaTW0UE6spJnE1uh/LtmL+PpIcK/laJvPYrNKG+PlzFF2ULkQtT2fTZBtHRKFS6q48UjwZQ8mJzbq2Ars6KFNymQQmXa4YSyTWeakkGFwQS1NKDMIdSBjbaIFahH2GjQn3s+Q+/ejUkmupHM1mwJKPrS30Xj60ccmDfk0aAK3znUK6hN08P5FWjZdCdSRIqXoNkzzvY4jciUo0ajhKO21Z4O/H7bj372oVu0siBaBLQHLO3ybB1TiS1dHtxyl43XDsV8qNJ+tMI6drsNa+SA5nwc5tEiH26aSXFaID+BYbHy4JdQ3BQq87M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR12MB999154.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZnTm1tSGI3K1NUemZwb0luV0pINm9pekhwVUhqTHNsUjY2VEVXdHhMbnZz?=
 =?utf-8?B?SXgwMmFXUDJwM2tCbTI1aG9lS3RZTUJjS0ZJV3Q2VFR4WkpGcnl1b1ZqN010?=
 =?utf-8?B?eU9sNWdjSnNDK0RoRExCZWdwRzNWMWhzV3R0RytobVVIVEtiY1RxNmV3dXhj?=
 =?utf-8?B?ZXdsSFFFb2tDVWlBbnNaZHZYNU9FYjIzK01rRjhrbk14dUdUNjdLQjNsNmlD?=
 =?utf-8?B?T2tnVVJvOHJ5NnJDeFVvVXBISE80MUF2VDFYTmg1UnVRUFBXQ2sxZnlTbE9X?=
 =?utf-8?B?VVBhRGpGWDcrMUZ0QWlWVWpjZndaT3haRGFqWUNJWDhQWFlUbkY1bDFDaWF2?=
 =?utf-8?B?RHFwV3lONFJEenIwK1N4WW5uV0ttM0VZYlhKdkpQQXV3blBuaWw5TnIrbm56?=
 =?utf-8?B?Lzd0SC9oVXYzdFIwaCtmVC9CdXNBbHdMYTZXU1gvSkg2a0p2MUgrYmQzRGxP?=
 =?utf-8?B?d3oxR0l6RjlWd3R6NFF3NUFKcFBGZ3ovWVgvVzd1SytwTkFrSHV2bUE5MXZO?=
 =?utf-8?B?eFNENVFPVVluV1NTemRLbUx0MnppNUtyT3RNRzRhRWsydnhBaCtrc3d2aXlN?=
 =?utf-8?B?c3FWdW9wdTB2cTVQMmhRTjBSVHJKakx0akd4aUxKa2NRUkhWTjBIVlBjR2ln?=
 =?utf-8?B?NHEvQkpMUU1xY1RlRUltNXRlZWg1aGdubjF3TXZKKzJMdU5GNTVTYmFnZ01r?=
 =?utf-8?B?Qkd0eHNORnJTalh2bVhCUUJWZ2pZRkNxblV0NXp6cy9iSVhWWXY2V284NDBO?=
 =?utf-8?B?SlNPNnI5NjBaRHEyUUtPSGJzdklDeE9UblpTbDBZd1k3SEllWkxrUDFxQ29N?=
 =?utf-8?B?SDJqWUY5dkhiZkkybGV5QXJxczUydTZTWXJZQWZQMDBFUmlxaitwdlBodE5O?=
 =?utf-8?B?WCs5VllRT0VsWFB0MFRtSGZrdVFTaUlmSUFaRmEyc0U4clJWTDdkdUx2Q2Vr?=
 =?utf-8?B?WFo0d3NBdTNveTFXVklDS0kwbU9IWXc4MlJsbTZ3K0tJRHlrdTFNMzVaV1NM?=
 =?utf-8?B?YU9OWUtVZ0hpeWkraWs0UGVUQ1pqOW1kUzk1a1dDM3JQdnVQdzVCeHJSWTdr?=
 =?utf-8?B?clZzRFZ0b2xRYU4wTXhIT29JMENvUkRTZlcxVkU4aU9Xdi9oRGhpZTA2emZz?=
 =?utf-8?B?dzc0VVdqaDhwQXFVaEt6NjdQbUt2Q0QrQXZoMWdyY21zN1dGaUYrZkh0d0h2?=
 =?utf-8?B?OW1HTEltYkdUQjZtd1BSTWo5QnZaYWlVcHRNejl4bDJZT0ZGZXZMWDh1VGhX?=
 =?utf-8?B?ajVKa3NjaDVlcE1CRXdlKyt4VEFqQTRBNWJTQ2d2bVVPTVRSMnJhc3Z2cXBZ?=
 =?utf-8?B?Y1pOU0xKcC9DZjUzQU9PRFMzVHYxWWxUb1VlMGZ3S3drUU9MSGFVOVVEdXRv?=
 =?utf-8?B?clFjZ2xSdG43QXMvanFxNzE5RDA0K0pTMWZnNjlNdG5DUWhpaUZZWW5tT2xr?=
 =?utf-8?B?Z1NxVGIraDI4d25TNzhNWHZLUTBXb3FTaUt4SXdQWVBsYmJSN0dlNnRZbEZ0?=
 =?utf-8?B?T3BGNDRyRW5udlptNjIzdDQxRVVoSnNHQ01UV0xYTk5hRUtoWmdpNFFoRGNI?=
 =?utf-8?B?STdMMzZaa1lHWEwvdUxQaGYyUlJFZjdWS3pMNVZwK21TTDIxcUV0VytQUzVD?=
 =?utf-8?B?c2owbGVDVXpqU0Y0anJuUXlIbHJVNmtKVmNKbVpwNkhGSGRyVExNWTF1aXk0?=
 =?utf-8?B?dGZKaS9qOVVPcjJ2bDRGVVVreVdmZXVjcW9KRXB2a3h2UHo4U2JudG5ROEFE?=
 =?utf-8?B?Z0xLUFdyUTZEaHRKNHZyb29wN0xoVlM2S3c3ZnEwV3E4eFJKMHFqMXZ4YXpv?=
 =?utf-8?B?YmE4VWxscXFYOXBQbDZKbTUzODZDNXVhVG8vTkdQR2I5MFp0QUhaOHZ1aE5V?=
 =?utf-8?B?MEJJcjNJMXVrSCtWTmxlTGYxY2U3cmgyL0NheXY1NDBNVk9CdzF4eld0SzFs?=
 =?utf-8?B?VU5pMXczWUdxMURsTXllM0Z1KzlIUWJsbUNqbEpKQTZPRjV5VElDS2pVbWE5?=
 =?utf-8?B?UjdtR0hHZzlHMkNzRy9kZU1zdlJzeTkxbldjVm5ZL2VrZ3IzR1FZU29oYlZr?=
 =?utf-8?B?QVg0ODlEVXFLa0FsU05ZbHVwbmI2akppNndLUWZuQkdBWDE0aS9jV1FMMDk1?=
 =?utf-8?B?MHlLcmZBSnF3MUdsZ2QxVy9qdExDTXllK2hQYUJaSGIzaGVOa1pibXBkeTEy?=
 =?utf-8?B?cG9hWnl0YXpjUnNsNjBSYlRoaFhsYzdWQ3FwQXlraTN5em0zZHlVMjBjSzRH?=
 =?utf-8?B?VjRCV0U5UnBFUDU0VnQ2RW94QXJGMGxaMElzN0xBaGxxNE9iRzdiOEpOa0dL?=
 =?utf-8?B?NFV2S3hzYXhibHNYNktaM2Ixd0Y4Sy9OcnpLbm5Vc0g1aVdUQzNnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eca48f8-adaa-4354-772a-08dede6aaa9a
X-MS-Exchange-CrossTenant-AuthSource: SAVPR12MB999143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:04:57.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjwehpoRPKRaGjevggyRW6S1ZHWOAQH3R1+fzf8HOgFccoMelYR2f+ln9s9ZTyZwTfXkbHWTKuCLPIbUgkf0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22996-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jianbol@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianbol@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13E797396D2

   Thanks for the report.

   This appears to be a false positive. On every failure path in
   mlx5_create_ttc_table_ipsec_groups(), mlx5_create_flow_group() stores an
   ERR_PTR in:

       ttc->g[ttc->num_groups]

   The helper increments ttc->num_groups only after successful group 
creation.
   Therefore, when the helper returns an error, ttc->num_groups still 
identifies
   the failed entry and that entry contains the same ERR_PTR. It remains
   unchanged before the shared error label calls PTR_ERR().

   Thanks,
   Jianbo

On 7/10/2026 5:41 PM, Dan Carpenter wrote:

> Hello Jianbo Liu,
>
> Commit 9f24f0c4d4dd ("net/mlx5: Change TTC rules to match on
> undecrypted ESP packets") from Sep 18, 2025 (linux-next), leads to
> the following Smatch static checker warning:
>
> 	drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c:614 mlx5_create_ttc_table_groups()
> 	warn: passing zero to 'PTR_ERR'
>
> drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
>      529 static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
>      530                                         bool use_ipv)
>      531 {
>      532         const struct mlx5_fs_ttc_groups *groups = ttc->groups;
>      533         int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
>      534         int ix = 0;
>      535         u32 *in;
>      536         int err;
>      537         u8 *mc;
>      538
>      539         ttc->g = kzalloc_objs(*ttc->g, groups->num_groups);
>      540         if (!ttc->g)
>      541                 return -ENOMEM;
>      542         in = kvzalloc(inlen, GFP_KERNEL);
>      543         if (!in) {
>      544                 kfree(ttc->g);
>      545                 ttc->g = NULL;
>      546                 return -ENOMEM;
>      547         }
>      548
>      549         mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
>      550         if (use_ipv)
>      551                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_version);
>      552         else
>      553                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ethertype);
>      554         MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
>      555
>      556         /* TCP UDP group */
>      557         if (groups->use_l4_type) {
>      558                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.l4_type);
>      559                 MLX5_SET_CFG(in, start_flow_index, ix);
>      560                 ix += groups->group_size[ttc->num_groups];
>      561                 MLX5_SET_CFG(in, end_flow_index, ix - 1);
>      562                 ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
>      563                 if (IS_ERR(ttc->g[ttc->num_groups]))
>      564                         goto err;
>      565                 ttc->num_groups++;
>      566
>      567                 MLX5_SET(fte_match_param, mc, outer_headers.l4_type, 0);
>      568         }
>      569
>      570         /* L4 Group */
>      571         MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_protocol);
>      572         MLX5_SET_CFG(in, start_flow_index, ix);
>      573         ix += groups->group_size[ttc->num_groups];
>      574         MLX5_SET_CFG(in, end_flow_index, ix - 1);
>      575         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
>      576         if (IS_ERR(ttc->g[ttc->num_groups]))
>      577                 goto err;
>      578         ttc->num_groups++;
>      579
>      580         if (mlx5_ttc_has_esp_flow_group(ttc)) {
>      581                 err = mlx5_create_ttc_table_ipsec_groups(ttc, use_ipv, in, &ix);
>      582                 if (err)
>      583                         goto err;
>
>
> The error code is supposed to stored in ttc->g[ttc->num_groups].
> (don't look at me, I didn't invent the rules).
>
>      584
>      585                 MLX5_SET(fte_match_param, mc,
>      586                          misc_parameters_2.ipsec_next_header, 0);
>      587         }
>      588
>      589         /* L3 Group */
>      590         MLX5_SET(fte_match_param, mc, outer_headers.ip_protocol, 0);
>      591         MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
>      592         MLX5_SET_CFG(in, start_flow_index, ix);
>      593         ix += groups->group_size[ttc->num_groups];
>      594         MLX5_SET_CFG(in, end_flow_index, ix - 1);
>      595         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
>      596         if (IS_ERR(ttc->g[ttc->num_groups]))
>      597                 goto err;
>      598         ttc->num_groups++;
>      599
>      600         /* Any Group */
>      601         memset(in, 0, inlen);
>      602         MLX5_SET_CFG(in, start_flow_index, ix);
>      603         ix += groups->group_size[ttc->num_groups];
>      604         MLX5_SET_CFG(in, end_flow_index, ix - 1);
>      605         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
>      606         if (IS_ERR(ttc->g[ttc->num_groups]))
>      607                 goto err;
>      608         ttc->num_groups++;
>      609
>      610         kvfree(in);
>      611         return 0;
>      612
>      613 err:
> --> 614         err = PTR_ERR(ttc->g[ttc->num_groups]);
>      615         ttc->g[ttc->num_groups] = NULL;
>      616         kvfree(in);
>      617
>      618         return err;
>      619 }
>
> This email is a free service from the Smatch-CI project [smatch.sf.net].
>
> regards,
> dan carpenter


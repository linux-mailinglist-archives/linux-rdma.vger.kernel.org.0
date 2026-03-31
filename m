Return-Path: <linux-rdma+bounces-18864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJklKbwqzGkmQgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 22:12:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E623710E8
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B99A3031A27
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974844D011;
	Tue, 31 Mar 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRg0Ceuq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AE3A382E;
	Tue, 31 Mar 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987958; cv=fail; b=pgCAVIU93Hhoft5JHG/X1JFgt4uttsZuxnepynBbg+UZCEChu1BCAqDIozhiIyBV70Xr4A8+oIza1ogy5/4s4Cwg8glVAwd60IHgpZFjxdz8/UEmewQYDBiNq2/BCVOROtZeWUrLmId7B5Muv84ZzKYWl7rhnE4USJ+/SO1WxoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987958; c=relaxed/simple;
	bh=6bTHluk1txhP9zCXzq4HoAw1yQ11YaGqDFIasMPfI5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DS6w8U2uiP7NKi33IpoFx+jo/nlx2h9d1iqWDMnzRdjWeIK62cJI/VCMMlIt1LK3Qirs0K1063jHf8UsRbch0zxVHRfJ2eXS8otMWRM+WLsjCHLMeuzlNHZQDqzeHS1hWVk933VF+w25jQZ93dTbmxEfIqMB0aHNB61i1v++gMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRg0Ceuq; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkKWwcX83FF/y2mBIqjOkjcBeLBIHIczryhfGvbpr60kGZHqQML+MAGWGfMXIVcN5opDr2s/ri4e9RKtjxsuv06109Up2vtNCta5Bvb1DYXrEj+zxjSBf715j1BnO2PgQt++7+YOz4gDDTAynS843WY2xp5edzEwA9yESSSFbqpYIbu+mdzwvCtsp5UjhEtRXu5HDabRNZHPHmtTg8/x03RovoFHaT7phugmXewCdgjpYekLKnUOZFk+DmOE65G6DNHIw4HCTa8k2YEve0OvvJsVTxzmLg7EP3g/fQ3JLYxKQH3soTFzKHnYtfTfouhEme1ApgJ/UR5W7LMv+240jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX39jnJhMQbloTQDqgFjFiloszNdeFEKDA5xfPiZtwg=;
 b=Fxv3I02hlPCW9QepgI9TG6W6Gil7rAv720U5goWCWACyfefWOWI+/qNRKirmz3M1ERudq9zz8UP3XH6mOAfzsMkMB5JViaThxvOv2nrwFaTVshusVS+D2Lp4v3tXWnD+tTFkDN0ePoHVP+ZgnGCYa34hMgi4otZ6N4QWSO00ZecnJgojN4QG4GMjr263jN06VSMhkgI629RuBWeVjKNYljwNcjQfUhFKyS3LhXvXeg642ydooEZk+pvVfCs6S4MW0/Vc2J8a25HFAdrMN+5LN+3SgQFHjILS8IyXxA9OH0HFuA+0i2jaE4GiN/g6kUdtSPNNMBrfbn9pS7oPaLSxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX39jnJhMQbloTQDqgFjFiloszNdeFEKDA5xfPiZtwg=;
 b=RRg0CeuqlZlzhLwH/lCBz1bIWrqrYpJAUcF1hkgi2xgGwFL/YGH9hFJws3oslPAROEeVVY/UwseGNqNqSytRObLy4p+PelO7/H3+XAme99XHknXPI3inqQ8Tvf/tqG0aSCiHqXDNtGdBC2zskLYGyhp8M29JEPWBEBeUZxJh9o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Tue, 31 Mar
 2026 20:12:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 20:12:31 +0000
Message-ID: <8dd22066-c0a1-4f63-b5b6-4606446a49fb@amd.com>
Date: Tue, 31 Mar 2026 16:12:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michal Kalderon <mkalderon@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alexander Schmidt
 <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260331190103.GA150932@bhelgaas>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260331190103.GA150932@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: f87f67d7-412f-44e4-775f-08de8f61d6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6m6d50EYGLFsRd54Cc5gFpSplRwNU8pOWndsbkloZA8pUIo+tS7FpUjyfztXsiKyB19Ip16bM0wojwXwOYTXLIZaLRw1Tv7rSxkB2FFeNv+QipYEb24/du5PJyyZd7zf6+SL5RRoEYQxOu/fCflSsZnFgy+DiLsNyPSL71LmS8xpZujKE8ce7cco8oVZqopEqDpPWfMyc1Ul2MR3+c1OaQIYQgJiJI/QueONlzjLwiEe51/s9seoleSHPGZWDGS6h5hlJKSO0RjJHgtmTjrT4CXvTCOy3/TPTAJOXKaPPT1jS1zAjYS1v0Cj+0rO452HgwsavYsZOeFpr3StvGhbI8/UUApeE/v9aPxonoVYOCUGm8VUokVlFuNlrAQPbv+8skEtyCtMsx4KNvMPXJYtlVSlOknVj1GLXM3prc+5lZn+QyEckSPHHyC9Fam0cpR7ROU222iyEWQ4hS1rdktsmE+mHMs074OfoLKM8uz1IxEFsk8ioc4aqV4c45c3GaENfG+PlFYOrO+LQEuz7naeXyaCNozMg0ra0PbEq7XGs/TPAYLvhQVugs1FLWdNQlcwwAH+b6oDTA3OZHqREjlH9wh4rrm7URQWedBPxr76WYBj9AysA1wrwcTMIp7vIT8FxdDSfrTFNZyiXMCXeyps8RoSfwn1o42BJOpaBLMggniV3nRUQkjOi503izsdVJEk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStrQXNSWDBwUmVtZDVkK0RiMTZHT1RGU2F0Q3pjRFVyREZaUXJaakd3TVhI?=
 =?utf-8?B?OFdROGFvdElacmJqaDhHK2dLOTBrTVhhZWQzSE1tOFdIVEw5Q3RuM0RhY0FE?=
 =?utf-8?B?NWpzRkc3VGVSZE11VFBwSHBsMkU3ZGdUSnVhbm1ZbklUOWhOM1IxYmpyQTJI?=
 =?utf-8?B?dHB0Q0pOVGNkS3JtQzhucXliSTZ1SjdSbm16VTB6dENCREtXMFNGNmtteVBB?=
 =?utf-8?B?YjBmcmJXMkwwRElKZkp4SDNzMk40c0lKMFRyQmovc04yR01sckRIdHNBSVVU?=
 =?utf-8?B?M25ITkhBWXM2WmFhdFpRdTRleVhUbHdSaGVuelNsVFpUWCtRaStNK2k0VkhN?=
 =?utf-8?B?dDdqRERienhMVThMNFZNRHY2U2E1V25DNStBNjU2MjJtOGVXK0tlSUxna2Iw?=
 =?utf-8?B?RXhSTWg4blcwL2xwS2ZTTVRXMTYxSGhneUVSbzdZckFPSkNVMWI1S0JaRkR6?=
 =?utf-8?B?Ym43OWZPMG1MVk1XaERMVVk2MzRZc3Q0NVQreU5wU0lYQmwweGVmREFmSGdn?=
 =?utf-8?B?UnZ2Z3EyNUYzSGpvdU8rc0hqUVJrUW1kU0ZrZVZuNHZISCtEbVh2YnNNSlYw?=
 =?utf-8?B?cHcyV3F1RFRLZWtVRC9JR3FQVlBvc2xWK1FmaU9IS2poMFA5NmtSWXhHRlp1?=
 =?utf-8?B?clJZNFF1YWE4RVdZNGk5OVRkWDNzL1hkTUw0WTlOM0pmalMxR2EzbDR0Qy83?=
 =?utf-8?B?Q051T3gzOCt0TVNGcmhOVWdEb2NNeXFhcFpPSEZvd0Z5SmJsQS9UT0hxUDdo?=
 =?utf-8?B?THNwbERITE9abGZOTm5rNkFrdnZQQmsxS1Q1UW9ZbnMvVTQ4TWJHdERvMXNl?=
 =?utf-8?B?U0ZGc1JrWHhTbytwbk9uVVBLUnJiVDhYckhvT3hjTFhXd2d2MHYzeU9aTEJv?=
 =?utf-8?B?S3VrREdKUDJsREpGbFIxdVhNNjZvbFFENEhDbkU4OVUzUm9TTFBrLzBSaXd1?=
 =?utf-8?B?RXZUS09Rb1FaWUZsUUREbnlNc2w0dXo2Q2EvdVoxRnRTZGpoVlVkWVJwRDFR?=
 =?utf-8?B?dVZLYVN4dmtxRk9oQ1UwMVB0OGdlMGhoTklFLzZSOFNwNlNkVWxGeFptTDBz?=
 =?utf-8?B?a0xOV3dNMzJvd00yZGcvQVlPVkM0UzhHOXhrUjlxc1J3UEQreFZCa2ZCUktQ?=
 =?utf-8?B?YWtDUUJhTTdGQkNueHViMGtoSUZBcHFxc3FCbENFUy80NUI3dUNodkRWR01v?=
 =?utf-8?B?OWthc0pqM1FITCs0clhkMTRWUC9qaXhqZktwYlQ1bFJNVmZnbDNZSWVveXlY?=
 =?utf-8?B?N3J0NHpKOGlDQTJzUXl2TFp0YTB6c2dFU2pXZWVWUFpJN2M3YUNSOERjSzk5?=
 =?utf-8?B?UjBXamFzdFdjZmVqM1NLQ2xmUU04Z1d1UEd2akx2YTdCK2N6TXBUSDV5UmxR?=
 =?utf-8?B?blZpUUgwL3llQzBrY0RmZnNFWG91UW9hTm5pdUZRbE5wSEsxZkVIcmg0Tms1?=
 =?utf-8?B?TE4xNFRqUlVGYzRkNGRoRGlkUWJKb0ZSR0xQRnhkaXVCay9VMVhBSmxZSjJO?=
 =?utf-8?B?UlJ5Y3pjS25yelBoM1dHN1B4TEdsWTd1NThFN0NqazVtMDZkQTJuSUR6WlNJ?=
 =?utf-8?B?bUFaN0l5VS96T0cyZ1JBMUthV1FDa2kvNnYrZWRLT0R2TWlCM21RazhjM3V0?=
 =?utf-8?B?Nm9tQzNFSGNvcFRRcU42UnpJbXc1R0hCRUJwTHlPd3NaYXpkbnBKcWpEVldv?=
 =?utf-8?B?dXpNc2NTWUZlZkNGQStPVUJvOTc4UmNVZ0R0NEo4NlFnWUtJWTdwTHR1Yzl3?=
 =?utf-8?B?SEZpR1VIT3NiYy9nSTE0UFo5c2h0TElNaXBXSTROYm9tZGhwSFJVTG81VkFx?=
 =?utf-8?B?MXVSRHhuVHNMTHdidFZzTlN1UndncjFzOUdzWDBLVDBuWmh1by90a1ZLYlJR?=
 =?utf-8?B?aVdUTldmSEtGMHhQM21FRlFQdzJPTG93UVhpYUFkQnB0VElNUWszTHdJeXNj?=
 =?utf-8?B?T3FwY201c3h6NFpjeUt3ZU1SU1FPRGU3YWQ5YWZEZGZzWktqc1JqOWZpb1Vy?=
 =?utf-8?B?a0I4ZG5sTDBTNytPM1oyeDBRcy90WWZGL3ZVZjFKS0JzL1RvdHdqV3pzOUM3?=
 =?utf-8?B?SU41enVmTDZrYytKOEwwMGlxUGlJQVNwKzBrSFo3Yjd6bzBnbXAyM201TkYr?=
 =?utf-8?B?ZE1ybDU5bHQ5Tit3Yk9teGs0K2xqWFg2SkttTDA1dENpOFNueFd6cjg4ZHN2?=
 =?utf-8?B?SkZIRFE0VzVQcG9FTEJsMFgrVGxNRE9aZ2NoKzB5NTJmS3VZbjNQN1M3Vmkx?=
 =?utf-8?B?OGQ1dkVmeldoYmNwWW1rVGZEUlV3d0tQQUhJK09tWjdsNHRGblZtOFJpanM5?=
 =?utf-8?B?ZE9KNy9WczhScEV3TVpQMGRIL01LcXJBbE1YM2cydUNFTE1xdE0xQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87f67d7-412f-44e4-775f-08de8f61d6c6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:12:31.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TELHeOJZHIQEs9417roMorkTw9YNjg9g86iNHUUndmk9q9mwxu4B7wYVWK1JvoyYl8l9LElbrvxB5hU/bMxWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18864-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: 40E623710E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-31 15:01, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2026 at 02:39:26PM -0400, Kuehling, Felix wrote:
>> On 2026-03-31 14:09, Bjorn Helgaas wrote:
>>> On Mon, Mar 30, 2026 at 08:01:57PM -0400, Kuehling, Felix wrote:
>>>> On 2026-03-30 17:42, Bjorn Helgaas wrote:
>>>>> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
>>>>>
>>>>> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
>>>>>> Since root complex integrated end points (RCiEPs) attach to a bus that
>>>>>> has no bridge device describing the root port, the capability to
>>>>>> complete AtomicOps requests cannot be determined with PCIe methods.
>>>>>>
>>>>>> Change default of pci_enable_atomic_ops_to_root() to not enable
>>>>>> AtomicOps requests on RCiEPs.
>>>>> I know I suggested this because there's nothing explicit that tells us
>>>>> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
>>>>> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
>>>>> implemented as RCiEPs and would be broken by this.
>>>> FWIW, on AMD APUs our driver doesn't call pci_enable_atomic_ops_to_root. It
>>>> just assumes that the GPU can do atomic accesses because it doesn't actually
>>>> go through PCIe: https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4785
>>> What does this mean for the other branch that *does* use
>>> pci_enable_atomic_ops_to_root()?  Can any of those devices be RCiEPs?
>> Most AMD GPUs are not integrated endpoints. APUs are integrated. There are
>> A+A GPUs where the GPUs are separate from the CPU but part of the same
>> coherent data fabric as the CPU (adev->gmc.xbmi.connected_to_cpu == true).
>> Those may also be considered RCiEPs. (I'm not sure about that, is there an
>> easy way to check with lspci?) We may need to include that in the same
>> branch as APUs.
> Yep, for RCiEPs, "lspci -v" should say something like this:
>
>    Capabilities: [64] Express Root Complex Integrated Endpoint
>
> Dmesg logs from recent kernels would also include it like this:
>
>    pci 0000:00:02.0: [8086:5916] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
>
> An RCiEP would be on the root bus; it would not be below a Root Port.

I'm getting this from lspci:
     Capabilities: [64] Express Endpoint, MSI 00

Regards,
   Felix


>
>> You can see that we did that for a new generation of A+A GPU here: https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c?ref_type=heads#L3920.
>> We'd need to confirm that the same works for MI200 A+A GPUs as well.
>>>>> These drivers use pci_enable_atomic_ops_to_root():
>>>>>
>>>>>      amdgpu
>>>>>      bnxt_re (infiniband)
>>>>>      mlx5 (infinband)
>>>>>      qedr (infiniband)
>>>>>      mlx5 (ethernet)
>>>>>
>>>>> Maybe we should assume that because RCiEPs are directly integrated
>>>>> into the RC, the RCiEP would only allow AtomicOp Requester Enable to
>>>>> be set if the RC supports atomic ops?
>>>>>
>>>>> I don't like making assumptions like that, but it'd be worse to break
>>>>> these devices.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20260326164002.GA1325368@bhelgaas
>>>>>
>>>>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>>>> ---
>>>>>>     drivers/pci/pci.c | 5 ++---
>>>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>> index 8479c2e1f74f1044416281aba11bf071ea89488a..135e5b591df405e87e7f520a618d7e2ccba55ce1 100644
>>>>>> --- a/drivers/pci/pci.c
>>>>>> +++ b/drivers/pci/pci.c
>>>>>> @@ -3692,15 +3692,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>>>>     	/*
>>>>>>     	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
>>>>>> -	 * AtomicOp requesters.  For now, we only support endpoints as
>>>>>> -	 * requesters and root ports as completers.  No endpoints as
>>>>>> +	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
>>>>>> +	 * as requesters and root ports as completers.  No endpoints as
>>>>>>     	 * completers, and no peer-to-peer.
>>>>>>     	 */
>>>>>>     	switch (pci_pcie_type(dev)) {
>>>>>>     	case PCI_EXP_TYPE_ENDPOINT:
>>>>>>     	case PCI_EXP_TYPE_LEG_END:
>>>>>> -	case PCI_EXP_TYPE_RC_END:
>>>>>>     		break;
>>>>>>     	default:
>>>>>>     		return -EINVAL;
>>>>>>
>>>>>> -- 
>>>>>> 2.51.0
>>>>>>


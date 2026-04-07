Return-Path: <linux-rdma+bounces-19076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOYVNtPL1GmtxgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:18:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75F3ABD4A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F280300598C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D7E39934E;
	Tue,  7 Apr 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWRYVqfL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691631353B;
	Tue,  7 Apr 2026 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553488; cv=fail; b=rxd8M3JekNu+yIef21Lpxj/8kS+JgW5x+L4/WHf8Uub8dTiNNTf2b1SQFln05m2tNxsVF8hZNhgDy20T62LDf/YW2W2bzxo871z1s4pDkPjy6NjEf6c/aXH5cy3QVTTVlk4yI+LKR+WJwjlyUOUfmVsugjHtgPuJDP4b87ZxJ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553488; c=relaxed/simple;
	bh=DlgrCtF5F9pIopYA2bIgiDCKI/zAwgzsDbtxif4RTkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWNGwVOM51bQmsaJj9AJOGiUcPIgLc/aqkOjbMmjKscDjW5eMZwQOBE8ZUqdVYRpP8WNgeMC5vVQhCbdxlav/eO0CROa25cE7sDueZqqJFirQij4M2uBQAcQZFl7lHPE3kTNI33FfhLO5tVAh+aSYU7F5zhI3fKRVdvXgXdJiQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWRYVqfL; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVwZrTupfpEQLiyFDk5CrDi8R63fmTG4WnWA5m8CkYObRUTJF3TFVTnYGdE61zvnNFfZPGpkxn9Ued+4JKE17X5cmTkuS79QX6rKs3hJlpRo601GJ6heKReiLlK3Fz5xowoQbDiizAeGTk8gJEfzTMOXuih2yMWJysVRVS3rbWJ7GH4qPQ69d1QqSlbdt+kvrYMjcIo96C3jTJe/VR0JnNhn4R4ObkRKwq94rgQ/CQrBkNLi4wG1dLCU+sT4xdN1xPYybKR6Fnl8Z3sqj51mhca5KruUHf/OoMhxdaOnBoBltbPDCnpeD60C4stqysuV72F/XkY5qh8l8705MwJRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sMCwa/DFoCCdmhocqyJylOfPf7sEK8Ks21s47y6Kko=;
 b=IB3dIESO0xjbRx1ozexr43sSTUF9qwA5/O9j4PEB+VQp0g95p7OdnLp7HAfqaCe1PHLjWP53OexvTpdjKDRP2twjolRH3GZRm/JSPD7CaB95SbWirVkKXB52DDv89c+1mNPwB3PIvGeep/+eSyFH8AJKYnSfmtwsPvTPFB8o4YTi8ygpM65anhgjc1tNCP9fMy8S2NqHnWyVy0lVmdkm8nZxg4wzwxBPJsYTBP5lRLiRfYWOl2JbVzs3QXmjjxgSdzADQjm/mJb7Z5qt08CHKXXu5eu9fwuimFCdx18xPxm+f4WobQU6RmWdOu6ZHmRNi02Rc+HbXd0KSnGs5e8O3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sMCwa/DFoCCdmhocqyJylOfPf7sEK8Ks21s47y6Kko=;
 b=VWRYVqfL0EMt5ioz7hU3vXlcoCZpCkZI3dj74sNzWuDFgBQM5OLiR181LCsHXUJyIuYu7CF5jwoCdVTQefKdHnqAP0v7JshKUXkf4qBBALj5YkDbS/Syp9p+3CJXyzsPfd7EiU6vP3kJ2W2FOzXqiSYCACyKaNuvr771ncZ2vVpc9m25TD/HAgOJ/Nk5b9dL2emdYGOMvsGa0eq5vLGpAQNEIQX6oWtsqC5wsa/zSBJ/mitlogL3elbmRR9JsrwFb6jkC59xWXNQ8sdxflGUVldPuTaAU2OscqcrUWy0zrs4zGtUbEyKYZR2pHF+ybWV9XG6INnSGI3cINLsabyEyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 09:18:04 +0000
Received: from PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4]) by PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4%4]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 09:18:04 +0000
Message-ID: <ba7fed73-44b2-4078-8715-06ad5e2270e9@nvidia.com>
Date: Tue, 7 Apr 2026 12:18:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v2 03/11] RDMA/core: Preserve restrack resource
 ID on reinsertion
To: Jason Gunthorpe <jgg@ziepe.ca>, Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Gal Pressman <galpress@amazon.com>, Mark Bloch <markb@mellanox.com>,
 Steve Wise <larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>,
 Neta Ostrovsky <netao@nvidia.com>, Doug Ledford <dledford@redhat.com>,
 Matan Barak <matanb@mellanox.com>, majd@mellanox.com,
 Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
 <20260406-security-bug-fixes-v2-3-ee8815fa81b7@nvidia.com>
 <20260406222356.GJ2551565@ziepe.ca>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20260406222356.GJ2551565@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH0PR12MB7095.namprd12.prod.outlook.com
 (2603:10b6:510:21d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7095:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: f8431312-22c0-4ca2-4011-08de9486926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O4xLD8lYg7m8t+zCzhznTW4adLnELVojLNkwEuE0D6kDwHuygLdnCQFlIWrJ7yePmnrrEjS2etlLlRzMLeOHZZk70ImrkLDHXidhd00NvezxgPKGqsh72YjbTrFJItIRDqp0hIG/hfRD3/sEbQ6GMlSIVCV7tptHvl+I6KOBrOgsSFUJUkEum8LbvFYX980vmpppiXIPhNdAWxLflCY43Kpozb3XUaYzatjeE7JsdkphSZbL0P0pSC5dp9xoR9iGSfQ080xcwnkH4N8zlwLnajycfLub8W8pVWBA4hkqfiScYwiWpbejIJVfj5OhJ9qfpjXHPvjLkls1hy79+ecjs1n/OhBmlzNIRo2x83ixyNYehH0IOqQHK5N/NEP+5Vqd65haCXeuM/MUDU4Mthrd4wa8UTYT6iR9IOW/Silq70DKz/esjgF8Vsuu8NFe0XlcRMYoKTxFnu1KGILzANnXdxZmQirN3xTfWbljy8sVwpLSLBDtHFe7VdOWvNISBBKLq3ilMXS9g3xBBBF6WIbMG+CjQCPyiQKmgZG8ISWWr16N3diSGJBVYAlOkO98SkiPJrkpTZ7Z8P86HzxB4QeG1Y5KWe1lM52Py1DsVbFm2BT9uB0SZEPmrY716h3zSSCZgOqe/g2HGiEtk8HJnegHMBOpRwNAXqz1MfdyE2aGUqjT8xbrpQrLyH2NbLFv5DR3G0BQ3KFBLtXFj7po5x7qnVGI44fKQ7gKPCd2SdnbxSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9EME9TQ2lmbUdUWS9iUFFUS014SFMzZHhYZlZjVGRDcTVTNVBHYzhSaG8w?=
 =?utf-8?B?UXpyN2V4VXcreVNSN0xkeG9zaUx6QUtlYzZXMGhHVlZ1TENRU0dUSDRNZnFi?=
 =?utf-8?B?ZERWZTlIVWxpelpVa2xwdWpRT3piN0d4TWprSW1rSlRTRTRCc01GNndSeThP?=
 =?utf-8?B?U2ZBN3dNY2RiQ3JqT3VPaGdIN2R2VmVneTZqSm90eTRDTEpvTExPeWw3SXVT?=
 =?utf-8?B?a2g4SVZweCt5R2psVjNqWk5vSEMxYUFSMm9xMmZzSk9SQTE5cm8zRzNkRTVw?=
 =?utf-8?B?dUJoeU5lK2htRXFRVTcyaENWcGF2akV0cDVjbVlKeGFGbyt2cjYvQlY4aFkr?=
 =?utf-8?B?cmo0VWhOQXhFdHkxa1JCT2pVb080Z2JaK05HSGxnQkpLTGhsT3M3SXc2QWpX?=
 =?utf-8?B?Tmg2a3JVNk5DUVZ3VkE2b1BYSGJwQ1NnTTBZc2h2SktiVjR5N2RVampVOTVa?=
 =?utf-8?B?ZCt4cXE0NzZHNFNuYWtWaVVWZUlSQmxYakE1aVR5L1F5b2JidkJmSGRxOGlZ?=
 =?utf-8?B?anVoZTJjckE5OFhLdE5JVDkrdG5uZ3lkRkRLNXpRVHQza0E0djFFVnY1VE5s?=
 =?utf-8?B?NzFxSjJ3WFR0MGp5VWZyM3EycjJ2Qm1ZOUtFYVh2MmM4SEQ4bkN0YUx6OWdx?=
 =?utf-8?B?TW9YZ2l5RElYcGpIWENPRkxUL0t6bkdpaHJaWU8rTUFpeUhBWDFscWE5SGNr?=
 =?utf-8?B?NXgyWWYvNjZVQVFzYjc1WmI2Y3pwT2w5S3ZMWmoxbXJ3VDVPRDRyNTZIV21Y?=
 =?utf-8?B?TWhyVXFzOUF5aXU1UzJrREQ4dk4xSlFLdXUrWVRtblMvSjlTL251VTJXNXk2?=
 =?utf-8?B?RG9UUzJmL21mOFltMW51S3ZtMlFGMXltK0NCR3dnQW9QQzV6dUdSUDhnY3dH?=
 =?utf-8?B?eTZ0ekVPZjdDbTRabEdxemd5KzcvNktVcXRkZkVFSjJJaGI2aS9KQnl2a2Vl?=
 =?utf-8?B?OS9rL04yMDdhTUs0RitRSkFqY0xVNzUyZ3NVUUx3S2YzQkZXdE15UlA0akF5?=
 =?utf-8?B?U0tnYVV3WjlneG5aUE5QTkgxQ0d6U3Q0STVURkRKZ2wxSHhYLzhwMDZFNVBR?=
 =?utf-8?B?S1dBa0tRdHlxd09RcVhNZVYwL1hiWnkwRkMwc1VwenpyZUpFY1VJNTZKejh4?=
 =?utf-8?B?eklXTVROajZ2a3h1U1FIYXNxcGRTSytDUmtwd1V1Vkw5ZXB1aUU3dllKS09L?=
 =?utf-8?B?dHhLRTNMR3hkcTZiR05xZ3RqRU1YdzhZcjhoSit5Vm8yNDFOQmphR0VHNm8x?=
 =?utf-8?B?dmlZTjlNZ2luRDVMNzUrZWtrMytja0VkUWkwNkJoMWhhMjB0SnZMRWRBbE9T?=
 =?utf-8?B?cm9MN2RUMTk4NVkxNkNnSi9qdmFNOXREbWVldW9hSXJoRFowZHNqaVpZOWo5?=
 =?utf-8?B?aHBpWGgzM3pQTWQ2RG1yQWh5eWFERjRDZ1E3N2hteFdsd0x6SWVuQ1RRa1Rq?=
 =?utf-8?B?c09vKzJ1ZHJKRlFvc1dDR2x6ZnRJZE9wbUliQW1RSlM1YlI3bjBpdmdQMXIx?=
 =?utf-8?B?b1dOR0ZrNmZmcHRua3BJNW8xSThITXU3WHJQOGx2NFIvdGY1VVdVcVZvdWR4?=
 =?utf-8?B?ZXoxN0oyTnhUS3pwMkxOOEVOTUtYZUVIMmhhQ1NwdEs4bGM3eURhQlZObThK?=
 =?utf-8?B?aU82RlZZV0JOaG1QM21lV3R6Rk13RnZMSXc1Um5VVWZDTmZwV3RKM3dYUWlw?=
 =?utf-8?B?bkw1aTF0U1Y3VTY3eGV1MXM4M1VJVTlpQ1ZlQjREa3hkbmIxMi9uRFFDYUIv?=
 =?utf-8?B?YmhEL3BDamVMWEkrZDVDMGExam5hKzJLbCtjcHVIbkpRcFIvQ2ZqR1BXTk5n?=
 =?utf-8?B?U1dJTGxIbTZmaXErcXVYZGl1eTRjWUxOdUxMRXpESlZlOGJnZFAzYTlYM3Av?=
 =?utf-8?B?dTIraWkwQzdaNGdFQVcwMzVJaStCWXdzYks4MGE0S1BmRWJMNlVwQW9QK2gr?=
 =?utf-8?B?QTMxZkdoTWV0akt6eHRFOWRjQzZ0TEhLRjkyVTI2NEtod2V5R2ZmUjEzVFZR?=
 =?utf-8?B?ME9KSnVaQllsV2VlY3pyL2JKZERERC9kUUEvMjRGYlVUZ2RmZ2N1dFdJTGVV?=
 =?utf-8?B?dVk5d2o5cXQxYU1ORGJPemJlU2g5cWlxSVhQM3UrblVvOG5RNVZIU1g4a1po?=
 =?utf-8?B?NDViZ2x3Q0dDSU0rQ2NsVUVLdFhDbGxNUGxVZnVJZlVPbTZPTjNTSkRWalNY?=
 =?utf-8?B?RXRUQWVCcXBZODdEcGZlVjJld0RPWDFVaXJOTDdweWQ4WmRCbU9kZUdiVkpM?=
 =?utf-8?B?WkF2RmdlZjREcExVcVpiWXU4QkwxS0lhbllFT1RMSjEwM3l4MkFGVmk1dEFa?=
 =?utf-8?B?Ti9GMDUvQlgwT0F0d3FRSzFsWlRTcXJMMDh0MlhaUVVPS0hGUjdEZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8431312-22c0-4ca2-4011-08de9486926e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:18:04.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDLs5kwXGaKmvN+m5pFE5C55Kty/F6RFUXejcW8SOkCyNckHxpTf2+wanDzrNNqEqeSuBnD/E7nHe69NlNnKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-19076-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phaddad@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7A75F3ABD4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/7/2026 1:23 AM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Apr 06, 2026 at 12:11:14PM +0300, Edward Srouji wrote:
>> From: Patrisious Haddad <phaddad@nvidia.com>
>>
>> rdma_restrack_add() currently always allocates a new ID via
>> xa_alloc_cyclic(), regardless of whether res->id is already set.
>> This change makes sure that the object’s ID remains the same across
>> removal and reinsertion to restrack.
> It would be better to somehow pre-delete it so it is still in the
> xarray but somehow blocked and then allow un pre-deleting. del/add
> pairs are not a good design.
Usually del/add pairs not good due to re-addition possibility of failure 
, here that cant happen ... so any reason why it is still considered bad ?

The problem with marking as deletion here is that it is not only the 
xarray that is being done at the delete operation (there is restrack_put 
and wait_for_completion inside the restrack del to sync with other 
threads that are ongoing).
I don't really see how to pre-delete it correctly without actually 
deleting in this case.

     - Patrisious
>
> Jason


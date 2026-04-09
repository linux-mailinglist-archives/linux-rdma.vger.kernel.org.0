Return-Path: <linux-rdma+bounces-19181-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDgqM33p12msUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19181-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:01:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E893CE654
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11F53300B2B4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775482EBBA4;
	Thu,  9 Apr 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGnIobnb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F318BE9;
	Thu,  9 Apr 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757687; cv=fail; b=rvCMZCv2qOL0jRdqZl8aKF0zai/SRErYE6eeQ4psgydcUE7L/vRf8U/kSqMjt8DIH59MzStpaZwVsG83ey1apukkcdRjesCCjYcMyagKG9b93CtjUHd71yGSNI40naziIVJi0tud76WthxwCLgf1ymVi4dcebbSzPHe/QkbXMUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757687; c=relaxed/simple;
	bh=VD0QTuEYlbMJoxOFpvxwU56KUAdRG0W3k85DOgf1bsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BgA0L3lZ6jRwqaOOC+p9682GwF2gc6iSzeH/Ex+683yTpzoKetp+jA+tXtJ+JZLpR2HpHwV1EjLVNx8tHU9R+hRaxzNR4/RxF6+BcstBEnCtOvKW8S1N3DdTxlRYT3KaX9XVK5eWcmZAgsPKFqvxj2r6TgX6nJbgL5QV54Lq0q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGnIobnb; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0J/NhIrA+crIjQVrh2enUEotTX1qFXJGZ2hXtF9KatSl2k3nrO21TY8wz68hwUIaXzdru/qKs+oTRJCz7f5BCIZCKqJd5J6vwOddQmTK89nfGpVJqh7WU6EwV9yxYpH7o5dx+uPPNvQO/1Rl7LyGvjjiLOqroiCk3YN8O1GRdgjYSEfzWsoP4FaS1hC9yvvi+rT2BHGsOjkmxLXL70BwaQ17OsXXCh1u2LD72/iNrt+y1ZuOCqCpy5YoquiuvEwbupbCZlgOgsQ0JFsMUOesAF6mhz5/GFoTt03wFjS6M47x+re/boIgKk8hcdRgt6yBCcgCMFOLtF2uoWgCaG1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsVXQN+/sQaQZBGLP6IQ53xUABee2qenHVGFrVZX9vA=;
 b=BxjUolsLa3GxvFDXmpxexhNb6Ynkyx2JmdL7231XwbQ+tX8C3fBhz9I47nZuNsRYmHdMWv4NFZqVl4q+iYOP4qHGMb1/0aQSxT+xhq9Wj6haiSD4HE3X1TjNomtudukwnjLH6wKGYd7lsaN68waJyvB+i3w6+YCXyrR6Ywgc7n2NYAotxp9wigx+FuVTKpH0FqLHxqjnw5F6poJYiuuPoXGNDDUG8kiF9sdzavDrGV1PjZShXwfXxaoc7TAhgg3CejEdQGvlRh9yBc5pW/W3Co1ZOPJ7Nz+tVQ/kg/BgRl/ORw8VUfblaEatLCuOC0q/ifpD7oOwEg637PfBj2poFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsVXQN+/sQaQZBGLP6IQ53xUABee2qenHVGFrVZX9vA=;
 b=KGnIobnb/LOWfmjgLMsezVpdp7eOx4w5yWtiP/9kHenaqvCGoLl6u3dfumx2FAW2xgho17I1m4dsgCcluGu+TvB5974b25xKWvty/lfVGVQMP+6SvR35LfznrjqF+bqL2KG+rpX47ydbKnTgGWnxzW5ZlZdLstIwhc8m2EGdJATpGiU3YKK0lEGUvw8wQOJ9KYR/wuqUfnH1AR1HfjlsXW4vzj/rfBMsfKui3BeSX01gCHEVrgsEObmx2oAjKMxoQHMM3qvuTJ9Qh9fPmklPsD05hrE89yEPohhvC4xKG5N0AzIaATowXKP0qYkKle4YNbC2fdjmCtP2yu7ulyFaDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 18:01:19 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:01:17 +0000
Message-ID: <42467041-f99c-4a17-9c6c-1b09c1d9a094@nvidia.com>
Date: Thu, 9 Apr 2026 21:01:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] net/mlx5: E-Switch, fix deadlock between
 devlink lock and esw->wq
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-5-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: edd6543c-39dc-48d4-9ee4-08de9661ff6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YZz6d8O/dnGroxqyI8tTSBfGv4Po62CALdcusugp2uEBxsllgZXu8WHNrSsJOmEdngGtEGRUoX1C4tbBmyGxdnGaM58TPmHCsEq15V8Ve/S+N8jY5m5E8JlgAK1c5BLSpB+jo3tV6HH/s+aqMNIP7LLvX2TjiBqQPWYhXNfN5kQExc2xJyjhVTocvO1yVfqmlGrG0ePmktZxZqt9ImaZursMUpQBrdEhndf+TxkTqgCuwg2ZpzAJr9jaHy4nctzM9nfo+357iwQkK2JbaFaCyJUq/dW1NVzgDu8cwbTMyoPIh5bvFDWmVdcI9LTHoUbQKHHfi+zPjGjN2SXcTa/zvVERb+26yAwCL/1dtJbHchLq72f3e9/oonUQbRAaPPCB1roxtELFeHd3JUb8pW0U26phuGWm+B8jaM2u448UfOv6qodqyk1aG/bbxFSvyM1ABEC+sdJ+z8WxbcOjWk45i5cuH63Z5/l83oEDFbT7aMUuoAllvQUHbGrEvg7C0A+qQGWHYUBS+1hs5c2myk0zSZOjLbxdLg8gsaJh4bfN5ge5ZEtseALd9nR586TiqAwT4e5J5u3f3vwRdBMVSCESuWb5CH+gsalo1G7ihjQ/LcP0BKLA5aAbBkHmMvWhK9ShOBc0GxYBxgHxWGQdiZf6vRj60MCqAckkhMrXBK9/+cN0sDc1vgbsduBNpGdjnedUVVEbLumy2inxzih9FzhmOMgQ4mRLcEKbgV0tFhrFVSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhUeEJWd3BpaHVDc0c3V0IvN2dadFgxVXI4STZVN0VpWGl6YkloTktKM2VX?=
 =?utf-8?B?RUxmRmIrVWlwTmhEVTBDL2pSNmFDT0pLT3dPV3dZTGUxd25Db1VaeWNFVVZa?=
 =?utf-8?B?NGxFeHlRUVJiUmZhUjRGMG55S0M4cDVhSStjQTYrUDhTYWFPU21aY1QrNTdL?=
 =?utf-8?B?YzFFcExjQlkzUTdlM0tEZDh6cXcvSzd4YUQvZG5ibnRHTS9xUkxpdjgybFc0?=
 =?utf-8?B?YkFDaXdSejhrQ3BER0NFM0NnVnA1NEY2bWQ5cUQxWjlaTWswR2ZOditINnM3?=
 =?utf-8?B?bUdWS0wyanlLb0d0MTUzLzhJRTFSWjlRTXJWc1EvamprdlNZeGVxWUF2L1Ny?=
 =?utf-8?B?RGhoMXRKM3NIZGN1TnRoYkJ6aWJtTTBuOHZBSU5WRG0rblJvcG9TblpJdUhP?=
 =?utf-8?B?UWdSbStuVUpUdmtFSDllc0lWWm1abFM3YmhOeHdQRFV5TndqZUpwUlFUUVZP?=
 =?utf-8?B?L0o2RGxCRGxTTEwrSUMvbDRSalA5OHRWd2plOGxjRHlzNjl6SnNwOEtNQ0R1?=
 =?utf-8?B?emVxMzZiN0Q3cjVUR2lsN0xGQ1hBYkFoNVVXTDBSNGZGMENYUEowTmZDS2NI?=
 =?utf-8?B?TVdtbTJtbEhvdGdhaEpyTEFXUEVBTDlSSktBSXBJektyN2ZVcFJNRW9EaCt1?=
 =?utf-8?B?aGNBSmFvNzh6N0dMaFlvaGx1K3lhVWluVmNZcWQ2WnJNcHdsM3pGblpaNFJK?=
 =?utf-8?B?d3FNN21QcjNxcDRBVU1GR1RuckJhdDUyY2tJZk8rR0QyVmFqN2kzOHFWWTRv?=
 =?utf-8?B?VFhUZWFtWjVsU01wQ0IxK2QveG5hN0I3V0FoYThOa2VyUzRyZzRpckR3dEU2?=
 =?utf-8?B?YmNDTVk2QjM2eExxL0VZR0VWLzR2Sk9aS1cxSCtQUnFHb0F1bWU2TWd1cXl6?=
 =?utf-8?B?QWtER09SZWMzaDBZZ1Y5L2ptQVV5S3hmZWNrZ05KaE5obnJjTWNYWjJHTE1O?=
 =?utf-8?B?UEtyMU1TQzlKS1I3ZTN1OXdXMEU2MkdUS0RDK2JsWlQ2NXg3dzlGdjQ4cGsr?=
 =?utf-8?B?YlhPckVvZHNQSnhwajd1aldiUklzbTFTNjhQVGVwTTJJN1RLVW5EcTJYRm5S?=
 =?utf-8?B?RnppL0MvRTh6T0tCS2NUS20yajRDbTg0aDY3Tnk2YTJyTzBtampScE0zQVRP?=
 =?utf-8?B?WEJNa3c4VzJYUVdlbEkvM005Mm94NnB3cjV0cUw4S0pnb0I4cXNaMHRLUjFU?=
 =?utf-8?B?elJBaFRhSTVmaFNTT24yVUg5eHRhU1lhaHJ4Rk5HU25rcUQ2aEtOSHFDYUJU?=
 =?utf-8?B?djdXOW9xVEVTci9zU3NwTm9vNmFyUWtQb1AwRFFNYWN4RnJFS3BXQ0xuTGZq?=
 =?utf-8?B?bmo4TENrTVRIOUxCdnM2M2lYRXBwL2ZoOGhlYjZ3R1dRUTdCb2I5Sk5tbHpr?=
 =?utf-8?B?cmREMVB3TUJwdVE4TU4yQ0tIN3o2TkpLN0hKWWE1RnZudlg4ZTNlSm4yZ0lK?=
 =?utf-8?B?K0xnWjBDT0pPV0NwUTlvSDZjb0t4Sjhjd2VKcEFFVmRHeTdHeHVXdHNaMTlI?=
 =?utf-8?B?bndESHp3NndHVDgzaW1STXZaSzNqeTdQZ3RxRElhK1F0NHhiRWhOd1RDMGlh?=
 =?utf-8?B?eGhmaWV4KzZKdmwzdnlhZzNpZEdheEtTTlgyckE5YnI1WERvNHNvQ1B3dnl5?=
 =?utf-8?B?VWhQSHJjcDNtSzg5N25GSlF0Wmk3cTFNeVFLUkRDT1RkWi9iKzAzS1l2Wmxl?=
 =?utf-8?B?akxKR3g3ZWhtQlI2TFFMVWM4STYrOHkvek5XZWt2ajRKbW9JT3ZzOXBLS05p?=
 =?utf-8?B?K0JraHZRNCt0NlVhL2NpY2Fqc1JpeE96VFJBK2RXc2dSVGJja1VIOW5ML1ZU?=
 =?utf-8?B?ZDdkNko4aUhuUXY5VVNDTXd4SHVWNjRCRyt0NzhVMmdKbVVOUHZwcGlBVnM3?=
 =?utf-8?B?UmlYMW1EakhpVDRvZ3htU203dU0rRW9XQnRCaDM5Tyt5NnN4UUk3azltelVZ?=
 =?utf-8?B?WC9hTFIxb2I4WFY0eHRybks1enJCcnlRaXhhek1CdTdoMFJheGpWME4vL1ZN?=
 =?utf-8?B?dHUyWkhmM1VpTHlqV3o0dXhFTmxQTjZrTVpjVFpMaVJWMUtjYVkwK3ZFMWRN?=
 =?utf-8?B?cHNaWWVGYVh0OENOWERLWkd1WVdpQjI0QkljYnd1QmthcTFCamE1Y05SbVQ3?=
 =?utf-8?B?RGhPdmFLQ3hiU24vSEJzVmhQZ2pzY2h2RTBUZlFVeVAvNjJQMUVKU2hVR0Y3?=
 =?utf-8?B?TUlzeEhBSVdOS0x4THo0WnR5RkQ1UjF6M1VqU2JGVlVUbFpFUHY4Ujh3am5u?=
 =?utf-8?B?Y1FPby9jVVZhcHM2RnN2dUVhN3FXNzRseGRFN3JkWU91RkZOckI3RVlaNHpp?=
 =?utf-8?B?bko5dXIwZnpaWW5VVkI4b21CeVZZMUF5NzVKYWh1Wk0vS3JIbmFldz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd6543c-39dc-48d4-9ee4-08de9661ff6b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:01:17.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEAhff9bMTscwdiEShvYmRrQU816XbC40aYFQBVh6BRX9b5nbFBNwSI6ZlS6gk2ZYcxcrPuU8iLDlPoZycajmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19181-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D0E893CE654
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> mlx5_eswitch_cleanup() calls destroy_workqueue() while holding the
> devlink lock (via mlx5_uninit_one()). Workers on the queue call
> devl_lock() before checking whether their work is stale, which
> deadlocks:
> 
>   mlx5_uninit_one (holds devlink lock)
>     mlx5_eswitch_cleanup()
>       destroy_workqueue()     <- waits for workers to finish
>                                  worker: devl_lock() <- blocked on
>                                          devlink lock held above
> 
> The same pattern affects mlx5_devlink_eswitch_mode_set(), which can
> drain the queue while holding devlink lock.
> 
> Fix by making esw_wq_handler() check the generation counter BEFORE
> acquiring the devlink lock, using devl_trylock() in a loop with
> cond_resched(). If the work is stale the handler exits immediately
> without ever contending for the lock.
> 
> To guarantee stale detection, increment the generation counter at
> every E-Switch operation boundary:
> 
> - mlx5_eswitch_cleanup(): increment before destroy_workqueue() so
>   any in-flight worker sees stale and drains without blocking. Also
>   move mlx5_esw_qos_cleanup() to after destroy_workqueue() so it
>   runs only once all workers have finished.
> - mlx5_devlink_eswitch_mode_set(): increment before starting the
>   mode change so workers from the previous mode are discarded.
> - mlx5_eswitch_disable(): increment so workers queued before the
>   disable see stale and exit.
> - mlx5_eswitch_enable() and mlx5_eswitch_disable_sriov(): increment
>   so in-flight work against an old VF count or mode is discarded
>   when these operations begin.
> 
> Remove the conditional atomic_inc() in
> mlx5_eswitch_event_handler_unregister(); the mlx5_eswitch_disable()
> increment now covers it unconditionally and earlier in the call chain.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Sashiko writes:

> This commit modifies the E-Switch workqueue handlers to use a generation
> counter and a trylock loop to avoid deadlocks when tearing down the
> workqueue while holding the devlink lock.
> Does the open-coded trylock retry loop in esw_wq_handler() violate the
> networking subsystem locking guidelines?
> The updated handler uses a loop that repeatedly calls devl_trylock() and
> cond_resched() to wait for the lock. The networking guidelines explicitly
> warn that using a trylock in a loop to avoid a lock ordering issue is a
> sign of incorrect locking design.
> Can this lead to a priority inversion livelock? If a thread holds the
> devlink lock for a long-running operation and is preempted, a worker thread
> with a higher scheduling priority could spin continuously in this loop,
> preventing the lock holder from ever completing its work and releasing the
> lock.

There is no such worker today, although in theory such a scenario is
possible. It is the driver’s responsibility to ensure that long-held
devlink locks are not combined with conditions that could lead to such
starvation.

> Does moving the atomic_inc() of esw->generation before unregistering the EQ
> notifier introduce a race condition?
> In mlx5_eswitch_disable() and mlx5_devlink_eswitch_mode_set(), the
> generation counter is now incremented before mlx5_eswitch_disable_locked()
> unregisters the asynchronous EQ notifier.
> If a hardware EQ event fires in the narrow window after the generation
> counter is incremented but before the notifier is unregistered:
> - The event handler queues a new work item tagged with the newly incremented
>   generation counter.
> - The teardown or mode change finishes and releases the devlink lock.
> - The worker thread executes, and because its host_work->work_gen matches
>   the new esw->generation, the stale check evaluates to false.
> - The worker then executes its payload on an E-Switch that has already been
>   transitioned to legacy mode or disabled.
> Could this sequence lead to state corruption by running offloads setup code
> on a torn-down E-Switch?

Good catch, this looks like a real issue don't know why our internal sashiko
didn't flag this :/

In both mlx5_devlink_eswitch_mode_set() and mlx5_eswitch_disable(),
the atomic_inc() should come after
mlx5_eswitch_disable_locked() to avoid the race described above.

Commit aed763abf0e905b4b8d747d1ba9e172961572f57 was intended to address
this class of problems. Some of the discussion around it can be found here:
https://lore.kernel.org/all/1769503961-124173-3-git-send-email-tariqt@nvidia.com/

However, Cosmin’s approach does not cover all deadlock scenarios.
Specifically, mlx5_eswitch_cleanup() is invoked under the devlink lock
and calls destroy_workqueue(esw->work_queue). If work was already queued,
this can still lead to a deadlock.

It’s also worth noting that mlx5_eswitch_cleanup() is only reached when
the driver is being torn down. At that point we must guarantee that all
resources are freed, so some form of synchronization / waiting is
unavoidable.

Mark


> ---
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c  | 11 +++++++----
>  .../mellanox/mlx5/core/eswitch_offloads.c      | 18 +++++++++++++++++-
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 1986d4d0e886..d315484390c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1073,10 +1073,8 @@ static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
>  static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
>  {
>  	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
> -	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
> +	    mlx5_eswitch_is_funcs_handler(esw->dev))
>  		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
> -		atomic_inc(&esw->generation);
> -	}
>  }
>  
>  static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
> @@ -1701,6 +1699,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
>  	if (toggle_lag)
>  		mlx5_lag_disable_change(esw->dev);
>  
> +	atomic_inc(&esw->generation);
> +
>  	if (!mlx5_esw_is_fdb_created(esw)) {
>  		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
>  	} else {
> @@ -1745,6 +1745,7 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
>  	esw_info(esw->dev, "Unload vfs: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
>  		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
>  		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
> +	atomic_inc(&esw->generation);
>  
>  	if (!mlx5_core_is_ecpf(esw->dev)) {
>  		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
> @@ -1809,6 +1810,7 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
>  		return;
>  
>  	devl_assert_locked(priv_to_devlink(esw->dev));
> +	atomic_inc(&esw->generation);
>  	mlx5_lag_disable_change(esw->dev);
>  	mlx5_eswitch_disable_locked(esw);
>  	esw->mode = MLX5_ESWITCH_LEGACY;
> @@ -2110,8 +2112,9 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
>  
>  	esw_info(esw->dev, "cleanup\n");
>  
> -	mlx5_esw_qos_cleanup(esw);
> +	atomic_inc(&esw->generation);
>  	destroy_workqueue(esw->work_queue);
> +	mlx5_esw_qos_cleanup(esw);
>  	WARN_ON(refcount_read(&esw->qos.refcnt));
>  	mutex_destroy(&esw->state_lock);
>  	WARN_ON(!xa_empty(&esw->offloads.vhca_map));
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 23af5a12dc07..988595e1b425 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3699,7 +3699,20 @@ static void esw_wq_handler(struct work_struct *work)
>  	esw = host_work->esw;
>  	devlink = priv_to_devlink(esw->dev);
>  
> -	devl_lock(devlink);
> +	/* Check for stale work BEFORE acquiring devlink lock.
> +	 * mlx5_eswitch_cleanup() increments the generation counter
> +	 * before destroy_workqueue() while holding devlink lock,
> +	 * so acquiring devlink lock here would deadlock.
> +	 */
> +	for (;;) {
> +		if (host_work->work_gen != atomic_read(&esw->generation))
> +			goto free;
> +
> +		if (devl_trylock(devlink))
> +			break;
> +
> +		cond_resched();
> +	}
>  
>  	/* Stale work from one or more mode changes ago. Bail out. */
>  	if (host_work->work_gen != atomic_read(&esw->generation))
> @@ -3709,6 +3722,7 @@ static void esw_wq_handler(struct work_struct *work)
>  
>  unlock:
>  	devl_unlock(devlink);
> +free:
>  	kfree(host_work);
>  }
>  
> @@ -4161,6 +4175,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		goto skip;
>  	}
>  
> +	atomic_inc(&esw->generation);
> +
>  	if (mlx5_mode == MLX5_ESWITCH_LEGACY)
>  		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
>  	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)



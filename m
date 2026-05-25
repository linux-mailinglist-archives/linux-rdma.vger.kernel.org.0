Return-Path: <linux-rdma+bounces-21228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM4mBMgpFGrfKAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 12:51:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05E5C9719
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4443016ED3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD441371870;
	Mon, 25 May 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoMRPXtb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE3348C73;
	Mon, 25 May 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706089; cv=fail; b=b4o5EzsbTvOyD7qNW8YpyCX1JflCOhBvRrskxSiGvh0uFOrgtQyUUPSDcFfsRWixUiW1OBq9gs5l0e6H21K55Tw4QMPkTnjvSb6QoG5f/2ASGJiYHc0+a7k534BXFFF7wkFuIWDello0zshKTVth7wHMFfe2/M3QNn1VwJmZPV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706089; c=relaxed/simple;
	bh=GNcbvn5H6Y0e5FvwW8wfUwzgfqXhohA8PD+BhE870K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNZtF2OCDaUyVv9qBVS6lm/zhvjzTZmGpasJuhAHa+tfxrF6b5GzqSVxKsxhtTW2BtMgj9jTAZr2ttMpKy84h+M3x3cFmltf74ePonrDFUgGNJeDd4MdItA9tNWurB3wSA468095VdIEEr268j12Qw7IvzL2vNVHlMSfKrKnAJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoMRPXtb; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpExXhBhACEcD/6f5vRW598qiHAddcM6RtW4jhDJtVbe0T/98bqnWpArTskRrDSu/jMtLwfx8nZdZnjFmHE788bacD5H0SHBP9rtbn/86xNAZ6MdqhWE9eu+qRibPP1dNDeIZDLL0K77tyYcBMZ/F75ypsqWkjpvmqLTyVzN3DCD6Clan/z+SyJNkJUiuwwZ8J7+t/a4PUGIYhczz0HthVed2g2TNd/zHqj+AVXD2gBpmIG2vddPP99DLueTYgkF0Eq6sDL4o35CI5UcPEPbYb6o8jba8sLpZt/oOJyhX1UYBa0AkXiXPtsyxrPFmXtYFugUfQmvHG232EyfbM3OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD3jqrO0oXyjnat9fx3bCjvM6fNUeceLh9afdQjEjmg=;
 b=FBip9IVZY/UF0qnE7MflBp+90XncDYFzdwR8RtLUFPHsxI6wvUATzDoSTxBKbeakFai38ja1r4KlAmomBfA8I5hGpppFS6eCHzizzIF8LjjPkE96iHMspCkM9eMrUdVUj0Zu8nRVvHmeeutNQH2uftnjG3blhAnOy1wQR+7MdrfyhwtGIj0Ldj4Ct6pzGLW13ykvc2Aerj9dIGSXxSvbv8HybbZvgnz/F8sGytZH1REalAJZ5KhosI3vicEDVGdjGPzZGZ0V3YB0kyccPccdBnouhSFPcqhb6fmtQZYGo4f0WDwmDo2P+OCeO9m0xz7Ya8tGhYJu8BOeZSPq0Y1ktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD3jqrO0oXyjnat9fx3bCjvM6fNUeceLh9afdQjEjmg=;
 b=qoMRPXtbTkGkQqOqDVEsjGKoLWJ/fO14ZkFFnbfI0WarFONOpdGsv63KPLfVNYC5LW6T8LJpX1O8xuyesBpwrWW6yJmx0A79jYN6l/MFCYMhh8vyr8D3yxnmTXZ82uiD1PrLSwigEoZFfqUKpA3okirNKgSFsD1/5cggj6XtM327PXDQ6lvcgc9t/Gk8g4CNd2PKdRLEsVISZGy938SKyblHH9hW5PzqK4Q8nyrupz2DGV9E4BbSfXmu1WKcPEDwM8RVEdLGSIV5y40dK7BJRgtykNpdI7m+Urv5afkidihn0iQoaDJrkFUK4UTus5VPtbcvgDuxGbeoIOahmWYvvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CHXPR12MB999246.namprd12.prod.outlook.com (2603:10b6:610:2fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 10:48:05 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 10:48:05 +0000
Message-ID: <31260e8f-15c3-4738-b5b6-67b0ea2d3b0e@nvidia.com>
Date: Mon, 25 May 2026 13:47:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
To: Yao Sang <sangyao@kylinos.cn>, Tariq Toukan <tariqt@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260520102130.423044-1-sangyao@kylinos.cn>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260520102130.423044-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CHXPR12MB999246:EE_
X-MS-Office365-Filtering-Correlation-Id: 593d3d6a-3aa8-4d02-abdd-08deba4b1999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ylr9UuTB68hbM10ufJKc0jht0LZNLWO8z/knTxJPP7D9JR8TGACL3ASqfL3GTc2AvG3iYBCaQQRxwBMpK6W9O/MF1RDvVYUVZyS0SmFUCv7dRLuArU77iUrpKgshN7w8OAei794gUwR7jlF2ZkTvfeJDXdXIZQ6YW/PaJGPLLJXd9p+venMFPFDn0n4/FqUP0boVYAjHvM3q1kXxj02oUPm84QTSdpNLY4vHAjRImptOxOH14pF3tlP/W0zroGLeslUILwtkn27i9zjBJ3sSIp7DMJHNRE3Mz1VdHPfZr79MpvBA+MHgon9gZntq8cyb+CUhfxJrk7Pq3tpXsUQ/Rl+J/hiRbsZNzOJAk2EIsDkEPjUqv1MHGGBlUGo9KcRTpkSgrAm4BwBTbYMw/obIXG3ji6JHtzcp5nsmp5WbUViq4gPeRxzJXMuCjAkNbVJ75lf8ySMUOo9RlBT7rrrVtq2FkRmL+ELA1uiSlKoaBj2Vum7jfJmVRR2MwfTXxl+iSNsgwkCnLwH1AWQnum5FHDv2V181rzgmg0lUzNMiPIrAHZrMgCT85I/zdYUNB1ckYpcRL3VWedrtmvQBK9IaqXSN8p5NwTaHvQVrgtiRWPVCb24KNzww7RWDOnIS2rDgU6WI5brmGh35EwruozTQV5GRuB9gLBnUJ/GjiqaCQhw8GowmCSqX+COumqUoi/M/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(6133799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2tza2VQMU9rakxkSGtoNHo3QkNDK0p6R0pZN3d2M3JkNlp6QnZXSWgwYVVL?=
 =?utf-8?B?MlRtblNLaTFXVkhxRldqVHVDT2F3QUR2eThhbUxqYnNWSm5kQWpvVm1TNkds?=
 =?utf-8?B?d2ZLY2VPQnpRUDhhN1VtQk96eVVjbzdpSmJCb0VVb2ZaaDY5bnBkRTFlYmN2?=
 =?utf-8?B?cFdMalBiaERNYThDYzhleWhYSm9XeVU2aVR5eG5qMGxYMUx3Um9XRUp0NmRJ?=
 =?utf-8?B?TmFVUTF2R1lPb3NIb0tvOVlZQVF4bnlNOWxURDNFMWRHVTF0dnRJMGl2eWNT?=
 =?utf-8?B?aEZVQzJCaHNQbEs4S0kzSjdHaWd0Wk9odVZTV2ZhSmZBL2pxOUV3OXRhODlx?=
 =?utf-8?B?SUhCbnJ2MXRiZzdJVWp2Tm1ReUgwVEdSVTFXNFI3ZWR2THJ1K0MxNXNTejcv?=
 =?utf-8?B?cmxlNzY5dnMrUzZNSzlCVmxlbkRLT05OYXBoZDhZaGd6THZxTGxCdmhMYVhU?=
 =?utf-8?B?WEIydzZJYnA3STBLcUpQNW9ST2RHUm9Zd2pnN2c0N05aelUvTjM4TUI0NXBU?=
 =?utf-8?B?cWhTWktmOUtiQ0hxYnYxY1czYXRpcHByT2h3NzhCRERTWGE3bEI3bEN4T0xL?=
 =?utf-8?B?U1JxdWRxdmRMK0FYK2xUYSsyazQzejZ6NHV3dERwQWs3MzVSUWtMN2dWWFFK?=
 =?utf-8?B?azFQNDJ3WTI4b1ZWREN5WjhLVGp3Ykk0aXBzYUpMWWM0ZVJYOC9YV25NZzBG?=
 =?utf-8?B?cWdHL1ZLRnI5M005aHRUMXZUcThCTC82aU03TFducmYrc2NCRUN3NEhRMVdl?=
 =?utf-8?B?b2x0d1V0OFE2S0piVnZBbHVRVVlnZjlJU1RKR3A4QVEweDVHWG5HVGM4WUg2?=
 =?utf-8?B?L0V3RTlpYzhDYWZLczIrSWw1aUdiY0ZUZ2hxY1ZaYnR6NjdGWUZqbktmYzc1?=
 =?utf-8?B?clBGZjJ5VVA1a0l3ZGZubUl2L2V1SkVGMkozYWhMaEdUQkhUTkdOSnREU252?=
 =?utf-8?B?dSswa3lJUkpIbFhLS3F6dENkRi9wNHZQS0JXajhBM3NEaU1GMnRpRjRjV0xs?=
 =?utf-8?B?UmtSSmk2OE5FTmdrMmxXT1hwL3Jza0dDUStzdHZtQjIvMVdyNFBjRVcrVE95?=
 =?utf-8?B?UDVTbGJLa2RyV2VUVnNra1ZJMG5LQnJXRDlCT2JBWDlyK0J0MFdtcDFQbUJw?=
 =?utf-8?B?ZzJGYmpGZ2dCZWM5Q1hBcDQ2Q3lzMCtNTnFzenQzSERtMGNSUkhBR3V1Wm5l?=
 =?utf-8?B?ZkgvSlFQWmlEdXRabUlNSTZPVVZ3SmRwWHA0Q1YzQ2NjTjdWbk0xbEcyMVg1?=
 =?utf-8?B?MnJLNWFWaTh4RzZOSmtaZTVVNzYraUxEdzlpV2VIVVJnNGxqSDJYQnF1U2FK?=
 =?utf-8?B?dlhoNWQvOE1tTmt6ME9MSmd2ZnFGR3lzc3dpbUE5V1U5S3ZRay93Vm9pNzN1?=
 =?utf-8?B?YjFUYzJpS25pdmZwdlJFSVMyakRJV1lLZVFiQ3NUMktUdjNkK2wvbzNOMXFI?=
 =?utf-8?B?Mi9oOGx3RUtUTGVkZUdRQUZTWWNITTZtTkVGQy9tQldrbHhtME5kMGFXWXlk?=
 =?utf-8?B?aWVoVFJSenhDKzZrQkhGQ0dpdW5DQ2JIb1J5SXVRbWNnVk5QODNWK3YyVlpE?=
 =?utf-8?B?cnI0YnBnT1o2VUMyNXF2NHVHa1NKbjVaWUFqYUNqdC9hZEJqZVlhcU5rbXI2?=
 =?utf-8?B?UUZMQ2plKzFWaUN0RzI5WVljbnVIWk04RGRDZWRhY2NhSlpxVi9TcEE2Z0tX?=
 =?utf-8?B?NlNDTG53bDdLNEhYSk1sV0Y5N2t2cnBsQmhVVW9VTnQ0TDZhQXdkcnl6QXlF?=
 =?utf-8?B?REFZZHhOUlV0U3Q2VTNrRTlDYkdMNVhwM1RFN1hYRER4R09KRlA4aUhTZHJJ?=
 =?utf-8?B?alBqdTE0RW5RZFBNZlJRUHVhVXJKLzF5ZWY3aDhrSFhMczZYMzJUMGxkR0VR?=
 =?utf-8?B?TXpSbTQrb0ZoTlBqMElnQVNTRXZkd3pyRnlhS1JkWDRtbG82VzlJbWRKb1pQ?=
 =?utf-8?B?dDc4QU5KZFVPeUxMUjAxcjI0REU2ejNUUnh5NTFoVnRNOFRodFpFVmNMWXpT?=
 =?utf-8?B?QXBwVVBZZ2xaQ1kzM0FjeWw3NElxeitKaFlSUTFIY3ZMYlpTTmlQSnVQTVBS?=
 =?utf-8?B?WHJMdTVWYWduTEhVekFwanlYL1JTRFE5OHB6a3A5RFNZYTVTc1BZOXdRNlJa?=
 =?utf-8?B?eW0yeGFuamNwMXJXUlJGVittRWU3VGNwdmhOT0FocGFKVnpMWEE5SXdEcml5?=
 =?utf-8?B?N0trQlZlYm9pcHc1V21aVWtiN0xqQ1VtZDZWK3huN1R5OHB5SE5EYllJbmp6?=
 =?utf-8?B?YUw1NHN0TzlQLzJ6eVl1eENwbTEvYXI0NWJya3hzelcybHFwZjhoTWx0V1BS?=
 =?utf-8?Q?GpGJN5+3D36Wyy/F3f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593d3d6a-3aa8-4d02-abdd-08deba4b1999
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 10:48:05.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p9wxliWJfyOuEVk2wIyXGqss0pStpb56xjhSy4hCiMQls4DIiakgNqDLEovEsoxAfXwrPAAzwL5JCUAfBLTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999246
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21228-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4E05E5C9719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20/05/2026 13:21, Yao Sang wrote:
> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
> with the CQE initialization pattern. When entries_per_copy >= entries,
> the function copies array_size(entries, cqe_size) bytes from that buffer
> to userspace.
> 
> That copy is actually bounded by PAGE_SIZE in the else branch because
> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
> However, GCC 10 does not derive that constraint and falsely triggers
> __bad_copy_from() in mlx4_init_user_cqes().
> 
> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
> explicit and avoid the GCC 10 false positive.
> 
> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index e130e7259275..7b024a5e13c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>   			buf += PAGE_SIZE;
>   		}
>   	} else {
> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
> +					 PAGE_SIZE);
> +
>   		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> +				   copy_bytes) ?
>   			-EFAULT : 0;
>   	}
>   

Thanks for your patch.

This is a compiler issue.
Did you try fixing it there first?


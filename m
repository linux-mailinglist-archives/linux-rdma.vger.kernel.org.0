Return-Path: <linux-rdma+bounces-18079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDHlOl+MsmkQNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:50:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19626FDF7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6FF4302B800
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D53B7775;
	Thu, 12 Mar 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1GwSwYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5E382F24;
	Thu, 12 Mar 2026 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308980; cv=fail; b=P0t3JGRo8LhFMyQid6v199p5Wx2weqDiVuCpr1JFqN8TKg2aVR7mbKpLv+DOfQfjbS2Zy/mcXCmRNLwTvy4QSxlkoTKusI3hsXTzZ/hxvgY9wbDOOkn92Q4Xn6recnZAcUaYPXYdDIth6X13Dd2k9Y4RYD2OThcBp2695ugJdTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308980; c=relaxed/simple;
	bh=vQkdP3TW9GzhDUGoRtWJNT0/K4k9YvxfVwLd8QTQ6Gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUx9iyA0es5KFKBRVzKrUEL/kbhRZyUsmyU7oqpcFjLLpD1kIUvMZW0GWlNMdeIrRA9GGGb9QLt/gA6XbV4HZL6h1KRBxcPUHo1ZCIQmlk57OW/y1IJGs4/QXYhEw2DDGLc5iq60f/Zggp58sMIkwsYn0xAGGMA1hfJRDLdPYW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1GwSwYs; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9FBy8oweRBybvi18oQgHsEqwgzsokIvSDeWYVLm9Iau9v6q946rbJ23H7wE85nx9eCoOqD4JlV/wVxgJXLWcyQsLRm5iNOKEQviwwsfIdrYLCXZ4fUy7UEUzEiJGUtXLBtPYc3ZOiiQOj/eDF9Y0uw1hxs5gzTOfbUrt+lVUpH5B+vQbTYwwmIz2061lq9RZCTFra50zZ2aZndzwVP68+VtdpUIooroDnChW2H5Ze3Bbi87J67JCKLaTnhQDY8XaHAuGCOQk7JEEK1XLWsxOPAqNcoP3xoLaLmS3S7QxU49VnP1z7pmCWuZAtcVX3hWrOJZrTRmGEOVvLdpgO4cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rluFyT3wDIS79wYqrThx339OHwXWUVTf3niKJoOJ8pk=;
 b=w18wgjmqSbt7X7vv2acpSMUDHEFQIYUHBQdOt4mwND1kr9q2NLiXvft/OYz8Ut9uTVAHcTGXcVUAiCicfTWt9T2/8zNB4Efs5tbeFl3CXST0hCv2f58XT2P5tn+xsEeOwR+EaqMCw4xXKSPtJC01hXPlJOFVrFaOnKhtGUAVWotOjH/Jzz1ywPvpsNHtFZ99b+PV4oUpGgqcuKWzZQOmEEun6tfiaMMT/Wuf2ICs0vfHhRXQ93a7c8MMqvR+hRKVfw1Ax++o2v8S3xhOpNcvX6DHI3TBzztf1CME3YzgUtmgHBhjyY43hIp/e0Zava7hldNvWy3VCTdKSajmJEGroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rluFyT3wDIS79wYqrThx339OHwXWUVTf3niKJoOJ8pk=;
 b=Z1GwSwYsJt1PmNzSBnwSjJppI9zWBzwsO+267DUD6sYE1xZkfl0fu3UEnE7Iv39WPiI8vPAzKiVQ1AhuiOtZPANZA1HQnuqtr9O2a1Qh5pekW235oWSU0l/HrZtLZd3ainN7sNg2x9KB1t6M6iIXVfV/H1sVs/oJST8I4GlG7eKNvHB0TQzlzjgUhoBBdg20BcvpRP8iloeebv0O6LNcsu0IKw/hWr1vCf8uL4stkC9HxbD7iPMDjbxNKmAYudSbGl0mjhQ5WkuR2XXfRfE7jRNONDe5mlss6uKy1rtphwY7amWQZxv6XbLH6dmsaE62x5Ros8NMDnuCokQPQkgskg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 09:49:31 +0000
Received: from CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd]) by CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd%3]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 09:49:31 +0000
Message-ID: <ce896283-1052-4c08-b223-4e0fd1af42c9@nvidia.com>
Date: Thu, 12 Mar 2026 11:49:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/5] net/mlx5e: Report hw_gso_packets and
 hw_gso_bytes netdev stats
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
 <20260309095519.1854805-2-tariqt@nvidia.com>
 <20260310201241.2f6e87c3@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260310201241.2f6e87c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To CH0PR12MB5236.namprd12.prod.outlook.com
 (2603:10b6:610:d3::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 78374a1b-3ae9-4faa-f830-08de801ca85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dX/zWEUhcWXb+LeGDHLmfoP/DY+7XDZMm7qIqLwI/U8H/ttb6sNIEVqqwxUBI8x13btql7QoH9C1BAyqy2U45237BtIHTvPuYEmOpjBIIkv71LkOT3H/9QQqkFS5m14IEmnFBuBLCx4vpSiT/cDBHpUVSDBSae6lNVxryEWDhw1e5/NYMoKf0JUp1S9pMNvqnJL8WtP2YsqHkgcXe5UBc6Wm22Z2CapID2lXDO61DHNSfauctNBDGkmeSRruEOwOxQzaRO6GQHKpFE54N8mns0dVZo5pgGmucci3etJoxfNZgWH/zV7fE30jB0xml8taBjSwirD/MVb8wEAy5pV6C5pHWEJprVNK4E2/oKldhKNeaG5MqkmcFj3HyMrM8C6ceXB9V27BTV1/Ca8QiYLihgzbiEVTGE5KsmOdbQ+yEbPsxOyFpCt5fUSpHN6lyFptXHEZ3I5Q20maCZbWPvqr2jVmZ+7cOcULaIVt70KWcpm9xXLt6N0FQ7bUcBIrfe64H9e5kpm0xPWOf2kbdKw89l7XAaAezio2oVFHtjj2eyjLflF4mRtSd8qaUYi43fzRlaRAKrJczbzHNfc/QIxKqRnYuW3aXvXUyComsQbpmGhhH2/zRQpiYIwNtHFuc95GcnPUQyltfytE3f2yjkcei8tuqh5vDnN8EtDSENDIrtFpUgWeeoP/Anqz/exsFLrHFqEz2bdivau6LvJgZCYI5jNX6Dpe5AxLjwFU/vOJ/bSEoWagS220KYRMaFZTxuRT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3lsak5rRlQwOXZZcUhnMkNqcFNCMWZ2VmRQZUliaVM5Tk5YWjk2a1BpYmRJ?=
 =?utf-8?B?aGRoZ2lTSEdENW4wMUExb2ZOMnIzWFJkVkRFZmZTZWRzNFc3bktqalJacEJ4?=
 =?utf-8?B?NTI3dDFIeGppeWcybTg5VVphZHFWSU9uWGQrWjBlVzIwOEFYQndPQTl5RVhv?=
 =?utf-8?B?M2tqTWFiS24yT1lZUUgzcmFKYXZsRzBVbUxjbTQyT2x0NlFxK3prT2QyMWtR?=
 =?utf-8?B?YnpSNDRGSUFHUWdwQ3hoczdKMzRPRGN5VHFQdHZMSFNEZWl0cjFMUFl2Ymgz?=
 =?utf-8?B?aTFkcTFPM0NEZlpmZks0WjJ0dXdHMTFvakNaSEFnWlp6aFRiNkdqZlJNVkll?=
 =?utf-8?B?TkIrUG0xTmt2Y1o2aGEwRXFWOHF6WS94TDNSdXR0dElJTVQ1MDRBWnRWaDhk?=
 =?utf-8?B?UTIrVWMvVUE0TXJnNDQ1a1V1c2IxK3FrRlhHUENaTUQ4dFFKdEdOeVpXUDdR?=
 =?utf-8?B?VENDMkNCTHRac2RERnhmaThjbmdSNEMxT0FYVGxNK1p5MVhicW00N3BQeUxw?=
 =?utf-8?B?bGFHOE93ZlBuZXlPODZqWGJJM2pUUXRGaE95UHRhdWp4MjRVeTRJVnpvaTNY?=
 =?utf-8?B?MERSdmNvWVRiZVVyUjRmREhsTDlSai9uNWtOekFBZU9VSkdvMzR5cFZIb3RV?=
 =?utf-8?B?bUFObXoxc1luQ2I3V294aTU4TytEcEZGSjZVN0lYL1JHcmduQm9xN3kwSEtM?=
 =?utf-8?B?cGpuU1kzVDRaMlZranl1cFpWOXg5ZUEwWko3TlJoMDNGbUZRZHc3Z2lzcCsv?=
 =?utf-8?B?YU56THY1S0hmOHJ0ckhHOG5mYlhqbWlEdVpFWUF2SEVGSHhxb3gwOXVrZzYy?=
 =?utf-8?B?djk4cUU5MHpKUjdJWG1KalBQbVdTUHY0QmxMcGRjWXBZeTVYUTJGWXRTWFNj?=
 =?utf-8?B?by9DMGtQbE9lQitvblMrb2JXMGxkd2EyM2hUK1U0VExLSjlhbzRYWVFpTGYv?=
 =?utf-8?B?ZEExNjFuTWFHTzZjb0RwQmpFdUVaaVZwT0wxdGdydmhOT1BVNXdBQ3JQeFJK?=
 =?utf-8?B?RXhOLzI1UW9jYXlqb2NvY01JeU4yRTdtSU0zVzdpbGpxajJsQk5MNjJwTUhS?=
 =?utf-8?B?STlHbTlsSUIrak5wdEJYZ0FjZnkybEhGT1Y2V1NHRkRwY3g3WERFdjZWRWxD?=
 =?utf-8?B?eDBVUG1FUDBRc3NURDF2a1pRcmJ5UFVxMkJuVStpWEZmYXAzU0JJZjZZbzNK?=
 =?utf-8?B?YjNwQTVvdTVnMk0xQUxWbTVBNXUySlBET0lzalpIcDNTeUxYTm9tUEwrdXNG?=
 =?utf-8?B?dGdza2QrckE3OUFiaHdRTGJsOFNlVGdtbFlTcFUyT1RsWnVjZkRPcGVBRGU0?=
 =?utf-8?B?c0kxbFdaUWk0eTR1THNSUVltV2xrcFM0S2ZxVXVjSkNCcFdOZlRrWUptbWJm?=
 =?utf-8?B?aFM3U3JZU0pXUm43ZWxPU0R2V1ErRXM3d3VqdnBIbFo0VDFpdUtiR0RlTzh6?=
 =?utf-8?B?YmpoSkdKeFN3RUpVRlBpeTR0YVRZaUFLa3I0UWF3N01FWVIyeUFlSGsrcjVv?=
 =?utf-8?B?cWZBUmVrYXA3TVd2T1RoVzI2SmY2ZnBFY1JVSjR4MkNSQmlNRVdtbG1xSm1l?=
 =?utf-8?B?RVJTbFl4QXdNQXNTSHJpd290RkxTeTlZczBRNkVrcFZTcjlVL0NGMERhSnVZ?=
 =?utf-8?B?YzRwYWk3clVRZjBCbHBYd1hsM3N3MnJ3Wjl5UjdybklWNlNwd0V5OTVEQkZ3?=
 =?utf-8?B?d0VzdXk1ci8zTjA0TWgxRkg1WW1UNmhSKzNKUjZlVlpkVFRhdnR5cUYyL3Uw?=
 =?utf-8?B?T2ZWUmdVVlZzeFhPR0pjUG1CWXZGZUxiNWdHMGNYMXBkVVUyQjNUbzk4MjB2?=
 =?utf-8?B?TXVhMjhLS3Q2R3liOUtuRFVWNXc2RDAwbHk0OGsvVGZnVmU4b1RGVWdVL0Mr?=
 =?utf-8?B?V09PcHRvWU5ZUnpSczdiY3o4cEJHbFkrK0UwYU5mMlFmaXVMWHhxQWFYSXZt?=
 =?utf-8?B?d2pJeEdFaGh5Nmt5RXZiVDBUenZ2ZlhCT3RSVC9MUTdZOVc0elN6VVZ1YUhW?=
 =?utf-8?B?Y1lWUUxpNDFZZUNLRmRzZmdSNVJhWTJTZzZnQXRibXBJNTd4eU82SldBOTRW?=
 =?utf-8?B?aytqSThhaUhkOGE4MzdXcXQwQmVEb2RyanRtTFVNTEJ6UXRWYjk1U0M5WVk5?=
 =?utf-8?B?ZmxTL1BkNXNzWS9zWVk0eGtuRTV0SGRvbjNMSFdQdEN3VG1rbUhaMzdrdi9J?=
 =?utf-8?B?ZCsranFJWEY3SUhheEx2V1plZmZKM2N6RmIwWnZhUG5HTDBVdVZNZVd0SUU0?=
 =?utf-8?B?YmZGOFgxZ1BVQzZSd1VQc1plRVlaL042b051azlaaG9iTFQzUzBuVXpTN1Qr?=
 =?utf-8?Q?2np/wB4Nxa99pksD5o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78374a1b-3ae9-4faa-f830-08de801ca85d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:49:30.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/m8bc6PDoELqe2PEX0N17rmSXky5nNgV+t7fsKYqSk8lQ8IfeBjl4gugqvxGZaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-18079-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9C19626FDF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review on the series Jakub!

On 11/03/2026 5:12, Jakub Kicinski wrote:
> On Mon, 9 Mar 2026 11:55:15 +0200 Tariq Toukan wrote:
>> From: Gal Pressman <gal@nvidia.com>
>>
>> Report hardware GSO statistics via the netdev queue stats API by mapping
>> the existing TSO counters to hw_gso_packets and hw_gso_bytes fields.
> 
> The docs on our stats are based on the virtio spec:
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> which is not very detailed, but to me "bytes of TSO packets"
> is a sum of skb->len of those packets. And mlx5 seems to only
> be counting payloads??

TBH, I'm surprised this is our behavior, not intuitive at all..

I'm inclined to just change it to account for the headers, hope it won't
break anything.


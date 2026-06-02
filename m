Return-Path: <linux-rdma+bounces-21636-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IudeLbgvH2r0iQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21636-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:32:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540786316B2
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:32:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hVW+L+fk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21636-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21636-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFA4A3049FB6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38217376A13;
	Tue,  2 Jun 2026 19:30:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C483546F7
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 19:30:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428656; cv=fail; b=rw95JB88qNNc4ezm2atVweTSEY6glNwi56NSYIZlmawnEgLOAGjxoVAp5y7PcheyZMOcmUpbn2735pcK0n6qPpOYGgqWkOUbzazUCyXSLBF0/DQQdgjaPzgOI0SPe2rRneyeeQd3F3AJMqLLfO5EwXf/UxBDUccIYaMn0bgtP+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428656; c=relaxed/simple;
	bh=+Ay+Bgwul+U5BekESrdE/mfsU30XSkrq3QTJWqk3w2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arkYW++EUpAM2s/UjH4iaWwWCg6pHFQ3gkVCrcmdGb4V5RvV+g1pMKGhwYHR3fpl6GgzZmkS9qAPaGSq33tAzBl8bhC8nipZ6rlNOe+wjiT3Bku4zT0Tj80P/ZPQmKosEpjT6psqw/Dm1ykIQGmjcM3Zf2OnY4T5KevavVarvlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVW+L+fk; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEn3oJQCnBD99eM60QuLzJPo2y4bAwPX0lrzMGaVVO76bb0ZDhASd/fLbGEsyeR5xq/0pyMf+SqgWami2/2IbDGUoWkQ8rDoujSSINdt65bLe2RbICXBEK86U+hEkl7Sb9Ohbbv9l1LNr36sGS5TOw0gbgZto1wJfZPaGxpkonSuVncYWwJuRy3LlEgbO8xO8OPcyyH5sVDwK0nKJU/6RCRrc2XMK7u5yKJTpE6IZIC1KZ4llhS3FDO+KDeSdUSmHrJhxeYf55NxziDczrTh/b2XiargUnoq/Y4k+evLedmUDzWJ5oR7ylLHxo5aJ5Zf8Ipt4L2ljeQCfOsahQjDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMNbXbYqT5gs0iXkkEoxximkhZiJGhjS1C1Yd4JJqAQ=;
 b=i3ddnt6YvwKGnMY7zcJS4rH+EpjHd9Lt+gLqwrl2sjZS6p+FbU63ff8c9B+f9O1rjJVDxHHXz1t7mxdjp7jg0qVPPNFe4/r3gdYqysXYYfVOYzkcKs+gWVHcN7RpLSz3xSBPfmlti8gn/lQ2Pui/RQb00CReHb9/aaEhLUHWEFhXil990UWqK5qlA4qHp5TWJYwyVg0n0GcOXgb7VtHFU4aX/3uI2I/Yam0aB9XlXa9uh0L1Zq1rwhyPZLuwMJeGbAW50+YsHW1/5fcDdfnTuHcjFWCslFCYsA154QA1sJPzU3NBfpD52OG/F26OrleFZGGkgA8aj3rm3qy+f0zsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMNbXbYqT5gs0iXkkEoxximkhZiJGhjS1C1Yd4JJqAQ=;
 b=hVW+L+fkiR+0Ty/ipx6Ai0XOGsZ+uA8QV9R5ndeeSRgLrW782amC1WLPZqeiBRj5IKVlsHx1eyJuJf03ukjUqI3Fpi+sh7yAzK9OBetgOAnfHjui/kKSF7jd6jszNGlIFWKP0PL/CKC4fdl/Mu0fWvZTmYlHEp5zfFGR+H5fFWCOOWlWIUt6x30YYV46J34x59ECgQZWb1XoxzFsky5zoZFa2obPznccUNh0nOBYnXGo6c3GJsWhr3WTyvW8WeO3pupyNf7cLnPfQOes8uSI/Ih7I1KHZS0XpoBFLzb2Mk3msLwxXTGC5pl/IJy4dM23Job97qEyQvlWEZ7DQA0bHg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:30:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 19:30:50 +0000
Date: Tue, 2 Jun 2026 16:30:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>,
	=?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	Kees Cook <kees@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cm: fix timewait leak and AV cleanup on
 ib_send_cm_req() errors
Message-ID: <20260602193049.GA1073194@nvidia.com>
References: <20260507094317.1018853-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507094317.1018853-1-zhaochenguang@kylinos.cn>
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6e86bc-4c31-4752-b8eb-08dec0dd743e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/OFT1BMDBP1FFs/2oi47Jn1bSDa/64RjwR4syKddf8fVBYixhrt/9mWlio1OMzSka8bQqqXnL5t28gtD2e0xmTdH2gPxWU6U8pjyzs91YNq94qKDFQOYbdDmkOUxOGxDCo1gEDypZw3sUdkENgqPy03cblhK47mAH+fzGXFv02wbb5JN+cLRQ43edR6laZ1HW9y6nu+v6lS/n9AP4yeC5yfA9+Rffrx5CwzxycTFqpfuMSPXxFpMEy6r9HgL8n8pDjBlmvlEX9wD87+n0QApMsQtU5Yt6ItMhglWZh9hfAm1U9crE2UkhYz6wAo6SS1lrp2Q/0lmWwh5MmQZn/oRK7oki6xCFVwA5zgJhRbggo2HUXhj0y6XSWZAVcOIhaHQSHAI/zC0PYSqbEwKqQ2nyIPeaATt/gKwtzEb+5d3ixP+XscYpvmTyyjOQ9wgck6SNBn/Fo4f9s+URmlVAHY6b19eBVOkrPiG2ontnxhpulRMFBZ7B0QdtxUy3ekkc8szR7L8qcAxQfifre1Ss9F68Njok1MKweLHXpQ1GCXW364bcC8+oj0365FBsMO+W5SUT/AsTaFfwQrcDxymLSy325A46KXA6/bgrmB4deecj8zu+kW6RPY0oaFJfeJK3cVc1rqeoXIN6RkoIvHtgkp3gpE57XlBI7gttDLVPXXRZDry9VG+iLBCxdAgEZxbwG8F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmoRQXjaLY2aFwwrPmsqt+H6D7R4l4VdPYSBMWrkkYz3djqydKCfWlUtXK2j?=
 =?us-ascii?Q?IAdwOo4Z1KGD8X6V1lxoTMGsnf+3nDDtvIUWOY8BDo/Hi8izr2mTuoiqxzGb?=
 =?us-ascii?Q?c4QReKenieBFWUKc9v0gL3WDQNOpm/C2viKr7WokvhM1WFsUvcukeN0Bzwh9?=
 =?us-ascii?Q?srRHFujjJMMA/Hq5BibAm79xVr/W7xaANBMNj06i/RcPV80iIrYEq3Ehhabe?=
 =?us-ascii?Q?MqlS/197J8VC4GbVjg/3BbR+snFmg6P8uTTOJnTEwtYxoouUO+uwyCfQKyN4?=
 =?us-ascii?Q?2yOI4S5oEvB8EVspOswrTKCTgdswHYjvB0NsJiwPF+vuzzNcokUB5BmkVpfv?=
 =?us-ascii?Q?LmopO4oxNyNr4rQ44DGF8EoMB9AeHSjj6tg6es/hayTNQFpN0dJCGsZaU7Dm?=
 =?us-ascii?Q?OM/f68jLgYm+BEmV1NYuo/Dty8Oz4IrE9RSM6gtzsMkU1yQk+NR3Rco0F/qY?=
 =?us-ascii?Q?3GBhVH9vNpmoNTllfbmwN2t5ZniUA1xrOiAwt9/aptCSiCsZMUIcFtL71Hrp?=
 =?us-ascii?Q?DFUjvimWscrvoCoPATJsVDeACO1/eKrOrMwTiOfniNfEZowlmdN4noTJaukA?=
 =?us-ascii?Q?cHw6xBscF/HWtBnAwL1UVe1xoVWH924bQwH0A4Nj8DX61rWYPVQ1s5Gagl8e?=
 =?us-ascii?Q?4fY/nAiXaiClGyLnKi8WHzUIvFYcrWbKKbiGCtX4ea5k5geMp1dkbx6EadKO?=
 =?us-ascii?Q?gDrEB1Ozjs8aCqzorPQmgv1RxQWV3yL/4G2hecsP7elK9OwLeH0xSJxA1ApF?=
 =?us-ascii?Q?K3TXOcGQ1xxNJ9e+SUVRW1diLx6VYXXhMkM7uoaXEbnxNafdb5UGtOHMWXKU?=
 =?us-ascii?Q?Og4xI2OXe0sHloTw3hKawVACx85IynbhUG/3T/pMkQ5IbqJS6rcZO4hiVIop?=
 =?us-ascii?Q?LicNS7W5PZgDPW9QacKA6gNIdKyA5j69Ler2m2BpgoE95NBHYY8h7QqGuhKI?=
 =?us-ascii?Q?OTDMWDXRfMirBoAw6gKIWplZSo99utstHv+gJcr1R9Th0hETdo95Y1WQstnb?=
 =?us-ascii?Q?ta2JKQ6vcz4XJON59fuTipcws9pk8CSFidSPli8O0ONcyr9BtTejT6zlUkli?=
 =?us-ascii?Q?eNNOb2SIUUbkgoT+VImX+lwM0aZ1alZgAkLjBj/HYkwCVlhrcsR+jTtlX02s?=
 =?us-ascii?Q?9FcDLhdFZtMLKXOm8EkvZisAqKm1aJEqSdjwN974TqAzD935+5JcH03KF64c?=
 =?us-ascii?Q?lJ4nV7ILmiWZQlVQlx6BMUfJ4cVrpiVayRd2wfmxAXh5Gmt+tj7MSRuJ14yu?=
 =?us-ascii?Q?pkU8u5JHjsw/bHARvrkvPnWZGYS8xvVjuxYG7FSinEtVBNS96eUIfzQtLxUn?=
 =?us-ascii?Q?FoKMqYIzTzvAfyb3cpImvBo7ZgQPj/pk7WOzD1Vo4fEnSPmexn0yyjRVe68q?=
 =?us-ascii?Q?WipZKh0zZ2D+6zLK9wne829I19Emuc1Dm0URKXdgavHgpFZQJ5WHopj/2Ymk?=
 =?us-ascii?Q?XEwXljlAxDIHVXkMRlWyjGDukw2y1j7sjzGMj/AyBb20dw/NX1mjpfq2F1u9?=
 =?us-ascii?Q?ZIfT9cgrnPG3HWdsbs55m5TZ0cbwGr3wN0hB32DUZicI5CLPWETW+BOYnZD5?=
 =?us-ascii?Q?phPrxhiQrgyOkIV8Xvm9Jrx46gyIxmgNHvg8WI/xUbTghYtZOaomECUiovyA?=
 =?us-ascii?Q?Oc1OBu9WCMesJRxpDmCWwzKFA7BCk015MU6byxubBPKzYhot5N2e3janpuq7?=
 =?us-ascii?Q?cY9Hww4c7MLTEciL2ELKGDYXcxDYX2LADYzrOEPP+/9svTmy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6e86bc-4c31-4752-b8eb-08dec0dd743e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:30:50.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI+m+grOCMMu7s8uJK3/4CN8MtHLTjmK41o+/XMZpFKlZTJx56oD5If+CGYSxiNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21636-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaochenguang@kylinos.cn,m:leon@kernel.org,m:vdumitrescu@nvidia.com,m:shefty@nvidia.com,m:haakon.bugge@oracle.com,m:kees@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 540786316B2

On Thu, May 07, 2026 at 05:43:17PM +0800, Chenguang Zhao wrote:
> cm_create_timewait_info() success was followed by error returns that
> never freed cm_id_priv->timewait_info, leaking it and tripping the
> WARN_ON(timewait_info) on a later ib_send_cm_req().

Yes, Leon is right, the ucma doesn't allow a ib_send_cm_req to be
called twice and it would be an error for any in-kernel caller to send
the same thing.

> -out_free:
> +err_free_msg:
>  	cm_free_priv_msg(msg);
> -out_unlock:
> +err_destroy_id_av:
> +	if (param->alternate_path)
> +		cm_destroy_av(&cm_id_priv->alt_av);
> +	cm_destroy_av(&cm_id_priv->av);

And this doesn't properly understand the lifetime model of the av, it
should not be freed here.

I did find a real leak on error path while looking at this though :\

Jason


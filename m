Return-Path: <linux-rdma+bounces-22556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wFznMz5zQmoM7gkAu9opvQ
	(envelope-from <linux-rdma+bounces-22556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 15:29:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D36DB375
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 15:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tpcqtSTn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22556-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22556-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D3D430F088C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0340BCB5;
	Mon, 29 Jun 2026 13:15:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8040B396
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 13:15:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738911; cv=fail; b=WXCnn+MQ/D/o2eFV4a1IJneHbfUkd08+2Rt30TEjp5/cmWEsPsirZpLVuNqbaEqztgDmZDdHYaY/cbraIqgXWGBkxPjVfrlNk9eK4Qc43ZMMvMP23iKu9qJgXl2+BglpIVQi/nk3gAmHoWoy/EBWCBVP48jHW9wo7VSCeXdAH1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738911; c=relaxed/simple;
	bh=dqufCpvMha3vHZE0rUTV2kAul3kwRX9CzkUa5WxgNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rDK2IBHtvM3SFo7GswfOxP7RKXGi3v1BEAfrVteTDqKoI0SKx7PixgB+JYA0+4fP73c5LLkrEr/omSlAsBc/76EEro5rOXrVcmwe1MU1prbH6sqlPJPFzIbgJ5GoVmQgdQ9vd2y8D/6JeNz84MLITz5KJwhFzQr/bpxuDQz9y98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpcqtSTn; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi6z4+GwiSTfAuYCblMyRwSSsfMmKvWFPIExKUQajuE73oA4ge0yhf1H8vimZpJNntEZS9MsbVJDHK+jNXA4ZGw1apklVXbA9/zYR2Lxl2Gd1rwKkfTkwAXGrCdlx7hKa1n+BFYVG7UdUnBrsB2YW+guu7dwSR7S5OrANQFT9mEwfGp6Q3oFwY/qC6iK1QQ7U4rFliwnQbfMhUw+H2GolEJOZARDCOU4SUh+bRQBDUXUT8iW0TUmOU7b4wRhLD0XAAQaJ9gCdr2kdlzzO2icLTFJO4GV8ZhNWDPfM0LcAi48kzsnIXXgAHOMPhc5RNRIOc6xsOAcGICKXlEoJ4ZnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj6saNU3db0rAWlZSKgN3aBX6dlN9dWsLUQrcwpskuY=;
 b=tpnbEIA1ulButfpEWduuzwDcOi8mY8pHFMIXM2Mqn3tk8dG3KTYPH++sJgrsM+E738KfymaWOoCZUGQRpFVPVd2UV/hfV/IcwoczvTX8Vc77FV8LyXWc6t9QVk/yg7/DnWmn7W+HObls3qoC+zg8X5vx21Gu6+iARu32ZSo+YuTwDacVJEOy/JgEr0wrK2OHjOSvXFID8bgOyx1B6gFh3JQ3f1NQtWQiP9msGnoaXccRWwS4z0FLsFbB9NOuyOaELrAH8g2yzYzAPFAdOrzj/gU8ZGVh1yqMKPpAIqI14PdFBcAVutdyPtOE7EuIzZLEVVsGAvz4d26tAdB0drqBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj6saNU3db0rAWlZSKgN3aBX6dlN9dWsLUQrcwpskuY=;
 b=tpcqtSTngJ6NtJzmz448eSQ6IbsCpHBdNrYhlUjANghhYNG8CQdHR+yGuyFk++6yJ5nkZSU8ncq/y4VBAdeIt3f06As78t05FBZZYwcl2eadrV3/d5LSpAAPit4U+GraQnLGa+lPq7kBmgatHDWgbNlWcDynEntPtot9N0HJEl2VClXJWdRgkytpsIvJFcranoWDMcV/hP/dqL1AxHhuKeRlJhF3YG+AMXFrskR3KC3yBvCy76nQOoPeW+ScAxUB+GOS47X9/1g9kKWyKea1l2ii2Juw3drLZuaiJMOui3z9S4VN1aAL5t2kTzQ8QZyJL2YGsBSuHndBo1y9sZw5qw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:15:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:15:08 +0000
Date: Mon, 29 Jun 2026 10:15:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/bnxt_re: Add uverbs object handle
 path for CQ/SRQ toggle page
Message-ID: <20260629131507.GB7481@nvidia.com>
References: <20260624223927.521882-1-selvin.xavier@broadcom.com>
 <20260624223927.521882-3-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624223927.521882-3-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BN9PR03CA0874.namprd03.prod.outlook.com
 (2603:10b6:408:13c::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eed9a9-7d67-456a-8046-08ded5e07124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wtd6pBLJYMPpyrBHUESM6v0m4zUkOolxkONlpuhb5NXOe8P+L2mEuUK1LYsuqzVgGWKh7tqBnPfPzdBeCZT38b+NGwTNeYJuGgTIf8iQnlLcZu18KV4A5of9CNDYdcz69CM4CEbf4ktZYDOqTxqDb7fcmC8MOR+yyEMeT4fcVp6JOMVUGiB44znBTULXvW847wIbBVd8NNfiFlUqDwXlVBiz9rGacsZlic10OAVsulL2xR/WjlZ3OXL3ExWaZSIMiNtmUMb6hjy0oawpE+g3BVVb6PdmqmccYwBzCT4JYVnLPtG1IAUuLfOFdAWSbNo8RXGYWPjVUIjz4zeaxMFzZmdFdb+2dtvFvT+aqeM5iSNCHCeQhwCOGn2puvrjlMcMV7JzmeNpZMX+Uw4hq2/D1U90HGD8wAWgB0JY/dlVMp8+flG/q6AdJxxQEhHbtrqanAd94WjJWxko8a2eVMKv5NBdbgLnUTaJeBM2KxL8stTans1w6tMBXAItHiPGvm91oyZ2ejLmiT/5UCS05RCfpXmC1zb3BWvjWqzes8ZKf+NVzKsiG+NdXcfyamfG7P+eHWvFM/XHyl9ucHkXcqhlP9XNIUmdjIMzIJwhS5k+HHVZxYynbaJvcvDh1qRba1ccLfUSUv1vAsGDc4OrkTC1nZyMzCEnRRPS/AnPDOi4/9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZmuURJJmZ+46ojGjNRO/L7Q5t8sjTM7Eubkt5mFJveo/iyw5sTHQzU6qmGh?=
 =?us-ascii?Q?2VLclrarvUsd4zOjTLtTfNm1/sQEZhKDAn9WeywrW7qTYgFNPbqvP/iIW12U?=
 =?us-ascii?Q?ryABNEyiUHjulSvP+9O3sNvefOOQXWeeq5lqgb0GGNFIViWHu7dGe3cFZvGG?=
 =?us-ascii?Q?aYWc4vx0l8Xl9CFYIKIYNECsBQ7Q5sR236i3ccLVIlZPaPrINRv9rncSaGk2?=
 =?us-ascii?Q?o/mpwMOnqfv7Nt4M20aRmwjULBVubBYw+MeMRFLjZKWN5p77OGG+/NHej1j7?=
 =?us-ascii?Q?e8/kGhnV6YgzShdmen7xNMWBiy1b56wn3vnC5rRvydOV6jvpbuEeYm2Rhe8q?=
 =?us-ascii?Q?rY3tP05SpeE11Heagv1dW9AZbcSi8t755HtJ4ugvhVVhw+z8PbJzZY5iZ0Hg?=
 =?us-ascii?Q?B49k2SdVcKU/Yhj9PLfGYSv2gNuMrjKbfMXCA3okVwzUx2jcBTPobNvYzOsj?=
 =?us-ascii?Q?G4PZLWa/N6uVLYTpekjD/Qg/MjoEUOrmENz1WU/1/36pQqygDkgwfeRhnRTp?=
 =?us-ascii?Q?3RBjufKOgro1kqlPlOqSgsGywzthBbZh1l4UCj3BjstboEJdXmpFjkrbp1YZ?=
 =?us-ascii?Q?3koCOh56fjLlEIAgKJzWCjUQlRuiw0p37WCdhjVg9gZJclh5ZDfqDI7drUkk?=
 =?us-ascii?Q?bYsvHLG4R16mo6K0AA7//HEuiNxlI3NqOg0A92vrNQArnDJWcbWS4MFzUcp9?=
 =?us-ascii?Q?QBDOW2R5sG9/knpdu2NMCAxhmADV/IlKolAanxfQuIbz8FpO1H460/Xr4mbM?=
 =?us-ascii?Q?XkG5Wgcvv2KNE+m8BHODhifYpj1YNr/BUpObFjL3cUJZe3n7EULqHJy0zAo9?=
 =?us-ascii?Q?qJOgEcP5kuuEDJ8Idmtj3t74qRtfU4hN35cHu6+9gYcM828XHzC8n9kVcPRi?=
 =?us-ascii?Q?sk57BXk+teo9sexJw6/5eXkTrdx4A1qb5b3m5nVg3XcT0yrqe2eHWMll37tm?=
 =?us-ascii?Q?ZUasVieR0md1kH7iem1kI0zSXfSoj8kx5CpyaAYhB/ldpkIVcDzAdzciBMzu?=
 =?us-ascii?Q?HfONNZHC0JB1/44G9lo3iMA3Ytu2GYSDwrwDRmUMOImbgqE/iY88NjIGqS+8?=
 =?us-ascii?Q?h7gPPoKM+tCErsvhL1EFG2nuUC9bU1niBoZZAV05Dax8gy3EWtbh7eCNMdKn?=
 =?us-ascii?Q?BwWlO+tGACwRk8ON8saVy5ZZR0ChE2OpKlyQ2pJPnV1Du/u4xYnP2uU/GkOV?=
 =?us-ascii?Q?wJQaojtfk1embNCxiYlPcU0yO94RY/7SCHoGqRGiZ2Tx6My9YgAmHrq+rhxi?=
 =?us-ascii?Q?BiceyPAhoI6nneoWj0BrJNeioRVxgp7GJdLr1TmgZSVXGqSYuP+zPtKxR+Ac?=
 =?us-ascii?Q?8018uYX+IFgZT6Qk9zlxuB07bcu4veszFw9k1rRnaMMkNZZYhAd4bkhPjOqr?=
 =?us-ascii?Q?U5BvPUJ22mTftqPaOQvC66AqoAya9yrJoVIzp6/ERkpD31c+IPtMPDtuucP3?=
 =?us-ascii?Q?XlwaU2UZvKA/ictrkwbW6GVNtaKG0XH41d2ExinkKIFUMOAt/pAdm26xcM/m?=
 =?us-ascii?Q?/eUwP0IHVMdSvAnQEV9RXIHOAhAheAoxatNeVbCfLlC4PTB/O1tQxzPLr+zy?=
 =?us-ascii?Q?rxn5uFPRb4uYACROiMvb75HhS1UpKU57/8QPmidNxoiflJTMCMmi34e1gTW2?=
 =?us-ascii?Q?uAAFh5HLQtTn0q55CI5HYAIAvg/88bXXQQk+04ojth4tDj2D0VgZDURI4U3F?=
 =?us-ascii?Q?M1mTJ/mbN6URAk2d1qqGC13Kwvq52MCuBXZdDUTWlCeWfnX+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eed9a9-7d67-456a-8046-08ded5e07124
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:15:08.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmlRoT+MQInRyhaeu/Z//pMfrrIxmXkHHjjEGwe1rCn9kk/bXMtcmpTqIH993YZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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
	TAGGED_FROM(0.00)[bounces-22556-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E0D36DB375

On Wed, Jun 24, 2026 at 03:39:27PM -0700, Selvin Xavier wrote:
> +		} else {
> +			/*
> +			 * Legacy path: old libbnxt_re sends TYPE + RES_ID.
> +			 * Look up the CQ or SRQ in the per-context XArray
> +			 */
> +			enum bnxt_re_get_toggle_mem_type res_type;
> +			u32 res_id;
> +
> +			err = uverbs_get_const(&res_type, attrs,
> +					       BNXT_RE_TOGGLE_MEM_TYPE);
> +			if (err)
> +				return err;
> +			err = uverbs_copy_from(&res_id, attrs,
> +					       BNXT_RE_TOGGLE_MEM_RES_ID);
> +			if (err)
> +				return err;
> +
> +			if (res_type == BNXT_RE_CQ_TOGGLE_MEM) {
> +				struct bnxt_re_cq *cq;
> +
> +				xa_lock(&uctx->cq_xa);
> +				cq = xa_load(&uctx->cq_xa, res_id);
> +				if (cq)
> +					addr = (u64)cq->uctx_cq_page;
> +				xa_unlock(&uctx->cq_xa);

Does this have the same basic UAF issue on addr?

Can you change this around so it tracks the uobject in the xarray an
uses proper uobject locking consistently in both legs?

If I understand this right it should also be holding onto a refcount
of the uobject while the toggle mem exists to ensure it doesn't free
in the wrong order?

Jason


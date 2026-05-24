Return-Path: <linux-rdma+bounces-21212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +pNbAvZdE2ri/AYAu9opvQ
	(envelope-from <linux-rdma+bounces-21212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:22:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE35C41CF
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F253F30094F3
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE52F7EE7;
	Sun, 24 May 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmMB4pMI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74388212566;
	Sun, 24 May 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779654127; cv=fail; b=BoQRBI/Xk5as7JRXynGKZO4SEhxrrJrMevd+EQDRt/Bxmk2ShtNJnp81r1i9nyDkWH+bGpTeuE46PAtMJyvL01hRfKohIiz11MlnVydUzk+/rG4BRYT2GnWPbNu12zxUa35NCZ035JGpSIczqvowA5mM4Z8A+m5T/4nJ3WuAAvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779654127; c=relaxed/simple;
	bh=NLbPHhd3g4rXAHQLQdj9xm2hxlLx+cWdrKoQa8elxRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SFytkaTKh4n3bdV+CeG+xvNmgeKUsg7CWOYG4eg5GoAoOXuvvW3Lg2rzKYmwQ73wiW8DT+usYhjFqxqudRMnJTEWpI+Srb2qS87rK1nOEHi3zweDNlBy8kHPu1ii55LEqXYmL12bei1iJ+czgnY0aFuMSDrb3qdCFI+ISV0rMds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmMB4pMI; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBpRpMvlTdLo2QeOEPsmJfTXoezBhprCoA9N+q7HsQ8iU9imSM6h735pgLKziDIo6fwwkqfIy4/TesQ+uJ5lLpqBTmsvbesjGbm7lnUHsST5Ak2s1WJicEhrjGik1iNg+Vh7V8jk1AxZo/w4OYdwqbi6VLVy1QaA7YDW26XpcL8+39JkV2Rs1J+Ahp/tABnVEcX0UV531X/J7h9BmlPor+7/NrHOXoruzCS/FpO/VVteOq35D3ClwiRFrygpbykcA1mSybOxLiQg9wajDbLMu9vjoDaDdDMblGy2WPVcU/U3Idi/xgyX4Y58r7CdyEnrtug6DdofQZRPzfOio8bD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsg+GjdNFgR0mZPemHYMKKAzu1ISuapJPqzhFGpzAbQ=;
 b=gTCRKZgmd9fFWTodojfcWJHHbAH/T/WG+qdtOCa8jxlUWn06EjRb0+HwnqCxhrRFBDP+mkjsJ2SFracVHBnJuq53uZisaweyd+dJOOQ/KI1cHQjy64H7PTq4MS76H8nX56kH5lArPFrwjKTzNl5rvjLKXz6snBUtj9KU6Ifw3IzYyaZFv1/74GBiPy+qBKkV75mP8ApERP3XLHnWkA9c+6Noeu9wv3GAr1NObFYpEHIBpRBl4EOofvpaM4SVElYFSJ9F3j2ZEoBYos696Cz0pyk7Pgi94gMQ+TSA9L65F967fOyZNbjhXtl49MoTdGU2Y1bnwhK0ji98FUd/MuE5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsg+GjdNFgR0mZPemHYMKKAzu1ISuapJPqzhFGpzAbQ=;
 b=AmMB4pMIw5ajDi/IZe8UN8N3drgi4iKBGCGNJQK/fgiH7REycrDGwiYGFyr2+7qaVb3A8WsTXP/G9vb9HHkDkzELod+S73pHZ3vzlM650Sfnqs/3PtnpW5ErScFq/53vpas3XH6RV3YGdFDtKp7Qt1PhpzQAfybIuBfoyrdrjBw5pHlS6yryQLx8a6sRr2tlxTrcArawZaob7jj33I9gF0XMh2XMlO8o8xLLjmTXDJrJXVwL1xrsu+kabmXRghjLR19Ziqefy12QSbSiQZYVkFvfC3lmB6D2VWArXhnHkTtWQOC398A6A42O9mrtlrmzZnJwqywygQPkQZhPrnSK0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:22:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:22:02 +0000
Date: Sun, 24 May 2026 17:22:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rtrs: Use flexible array for client path stats
Message-ID: <20260524202201.GA2101751@nvidia.com>
References: <20260511041812.378030-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511041812.378030-1-rosenp@gmail.com>
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 356bf60d-8497-4553-6feb-08deb9d21d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7QLn6qMEQk76wQzh22/ldPYMLc8onc4rmRUHz5Ze+bj+Lsvm3arW4cjIjl5kGYOs2GpTs0jY9QbeIrdSl/xI0aHgBi5+/e2mb3AbDhsMUh5J4kOXi73YRryA2ba/WBH74sCqPFfWoMyLKuNyj3dMe3cAouYZkzhWLEEwUDlQj6LA1TI8OsMMTXZEBPzgXxoc7KkwsaBEryaRprsrwovgM7s1ixlAHJgj4mRyZu5PKJ9sVh37pGzW2RRYLjusKXbP7/3uhr97WUD0Ac+LndNFsUmK5iEJp2Df84W4qyJ4qBTjNtnepNHeEL7WM3JtpUTcbVFshLSlX+5m4rqyXRRHct+PtHdmgIxtb14JgOyhZ/3jaqJzditM5XAqvq1IZEnzKmIZMUABkAFo8mYLsuciFuGWkromwJe4yDpDthEji/EwwvYsDynZruUiRUo3cWPRJ4/m4BkAsfMjif9ESok5hSXrtw6mfCj79rgzHYXrPY5Km6uDBQI3cJtZvE4vwZEEzn+5kdeSB/ItYEv6KRbP8Fs4/XU8tOK2/hfG8tBCjiKVkwjHvWLIEL2xc6POcfvBR86H2pB6ipieo5VdRnEotXazIklIqi+YWq5FLq9F6J9UZH1xxgBHG8sLhFkc68t7cMNr6JYlNcE1ztWxheaA3b9W9qYvRp6OqAwEjglE8Zr3nRuIv+EcUcvflQHMxbAv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mNvqbo9srzKzNmkEazARxju+kuswYmOxxKmfBct5u5eLjMCJ3gScdQRutK3X?=
 =?us-ascii?Q?5y+uLwXXSdZCGg8U5ZLUqbF4sSyav1JdVnu9xcvqIYGv4EDtF7F5nGQo1YV/?=
 =?us-ascii?Q?CvZv1vWMN5HDf6W5Dwt++O6qh7743vmeKsTdtslRqY19FGcQgou9uGzvzCmz?=
 =?us-ascii?Q?eUDeeZT5O3xQ+tu4vTTCgZgXKoZsuCx0DKYccZAGHh1Cb0FclY2ScQHifXH/?=
 =?us-ascii?Q?rziY9TiIqF8tK6JRiUXavRHg/Rlv3nTQo4Rk07IWbjVh6dwBhPcSba/llGp+?=
 =?us-ascii?Q?dwyWcf/tApMpQFXDKxQfrobpIhCnKgD24stoCjhEJrRZV63Tdgx1HLAqEpHG?=
 =?us-ascii?Q?Kh/FERH3LGhuLIiC94Mr/RSd6sLWnX6o3sh7iGpzMuXyxfyqEk5FYDaTnEoU?=
 =?us-ascii?Q?nf/H0mukTDg5ZPiUsYHSDjXeT2hMEbN7rfo9i/khDIdRuvwXnVsT6KPfHapF?=
 =?us-ascii?Q?qSRv7Ouqnz9TbAip+PmGf/b7YDRwE62yYJyhX/JtmnVOq54Mppw1d80V/rGN?=
 =?us-ascii?Q?AF8FViNiFDCDQZKXMXPC+snUbSxMqZrTeJjuxpKH6bfwXQl5+wK6m4nwLwdZ?=
 =?us-ascii?Q?XUh2AV9ld+BmjQWVYEQgTUahLxzYIGkf+FzaDqPS7JQIfcXQjacTFrVgJWbU?=
 =?us-ascii?Q?WiyV70MUdrpalu2Y4GSgl7ttnbudi07leaclRCL+ZlF05a6Bi8xw5lu4DNKm?=
 =?us-ascii?Q?52hlkL19jmD9rmVWhlgt0Aqc2wRPkaEFRND6O/QBQ8sq+lz/b51KbdMYjnH6?=
 =?us-ascii?Q?rP7ZZ5+1i/hc5ZKYDlkPwJLrJu39HBRVxxU6S3Sf/gy4hEyNOTptessOVLzw?=
 =?us-ascii?Q?Nz9GdsYurdWpov1xz6YZiX6DnaHIFhrQ5MMK+8kv+ndofH9/tYeaLrJNzNS0?=
 =?us-ascii?Q?CvTAxsorhZ3qELPWtKwlkPloY+IDB0n0carHU6nDLxkogYw8mbw+RvsjjjYV?=
 =?us-ascii?Q?0Sp2MOD33GxrXmw+Ebmi0+O57GD8moJ88Sl4XyoDXaIrp9IlfCZLuhi5elMi?=
 =?us-ascii?Q?qTTDvwogIJb1+LNYJAaclgGAwCZ4BoOhB2cbfWBE3q/pPR06AsIKl8IPFchZ?=
 =?us-ascii?Q?LgmEnh8Tdrj+BIgT1C6C404XPP27R/axrGGchRf3i7FVIpquZ53NEQ/ucqyG?=
 =?us-ascii?Q?kWjQCZlmjZ/PtlGn/KC+zc3fCkrpetNB2yghtu2NiRDYKXNg/Wap/xOLfFm+?=
 =?us-ascii?Q?+QFBQRqQVpLzQWhpLXNI102I+OOXfti25Y14dRsS6rpQyWxlhlqHUxecaHrI?=
 =?us-ascii?Q?RXpdP7o887vE9l+94QjhSN83ewGkL2KdMkf81kr7U12lJyDj/8kpfFGvLlQx?=
 =?us-ascii?Q?bcY/AV93vQrBzCLPFkeWCJbf7NE2S8t0WWNyHRN6AsFa0n86Ls1F1GVolhXk?=
 =?us-ascii?Q?UwpUJo+bpDwGyD3zKhvrYoQMJZQiGVRNFdJJQbWvK/tq5kREMfXA1DcJshxs?=
 =?us-ascii?Q?giLnz7IEiz3IRAFSrXYpapJmov7kXtOzy73kr2knxZMqXOWiugF09R5/pSfQ?=
 =?us-ascii?Q?SFXyBHHnKOBFpmJB4H9sPdH/qaIxrh3OlArYtKKOHwOLblSHyYkfckvTP+9i?=
 =?us-ascii?Q?M6rzrKWZOWQ7XO8iBog7qsUvQK3P5D7i1LOUf1JQFsraaYvn7b8BPIGerILA?=
 =?us-ascii?Q?K2l2QXEqLHo5/FTNyM7BOE4o2gWmt+phPMbFqoh658VijiFa7G0zcO+HEyZp?=
 =?us-ascii?Q?Dj477nES7O1QzWdEyPgHJgK/fHMUP36qkiqN6mS3rnftXm7R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356bf60d-8497-4553-6feb-08deb9d21d52
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:22:02.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1208lIObmJxXUmInJQdI1Gw3UQgJg40/kH2QOyAkSPu+dDVSMPsAoMhJARvOa8+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21212-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66AE35C41CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 09:18:12PM -0700, Rosen Penev wrote:
> Store the client path statistics in the RTRS client path allocation
> instead of allocating them separately.
> 
> This ties the stats lifetime directly to the path and removes a separate
> allocation failure path. Keep freeing the per-CPU stats data separately,
> but do not free the embedded stats object from error paths or the stats
> kobject release handler.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  2 --
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 13 ++-----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  2 +-
>  3 files changed, 3 insertions(+), 14 deletions(-)

Applied to for-next

Thanks,
Jason


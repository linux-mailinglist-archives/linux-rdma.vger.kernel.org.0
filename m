Return-Path: <linux-rdma+bounces-21699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9bjqNTBrIGq53AAAu9opvQ
	(envelope-from <linux-rdma+bounces-21699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:58:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CCA63A548
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="A/vi5H+Z";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21699-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21699-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F07E30358B8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BE3803DE;
	Wed,  3 Jun 2026 17:55:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550D37F75A;
	Wed,  3 Jun 2026 17:55:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509305; cv=fail; b=DTHSKubf3lMOtflCnkKzvvZUzmCJCQR0QREx3y5/A45BUqOwA9Z6U5pyHcBtE0C3Xbv+2EB8TxA+DeBxeohsG/p9K6b6OedvKqRU+z+ZaYf0ZM7rY9nRAAG/HNaPPS9I6JHGTc/F6Hh1xu8toNUe7HLpPyvFkZ99ncn1RXkX2GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509305; c=relaxed/simple;
	bh=xT2B++yd21FTc/FBUEtU7vsId3hbwEtCJa5XdKIKu8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mGA35tUZiBMwfg6+HUpqSYFWEYPjjymsLVJolBnUtrckTPY6mpFK9kqFDvSI4UHvvB/I7hr0Jly5LxlovTdxx+cRcVLXcfQm9T5l2pmuFyroNYFW5a9gFGSb9J96aem1oyvODljCQ5i/dVHffxGjvWnwCWHNIV9VyEm+rYBTIVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A/vi5H+Z; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9lqlWVV6PeW96l9AOUiyZS0Gga3oC2F5jhwPYQ9kLK/lCYWPIm0jsz3eUKkz7aoFBFKEVazvSqjMgbRp7nx7X3qzjkj0PEk8frexfZJSUaXkbjrsN9WzV4LzPHxi3EMqo+1BUezaV6ksmyLDCitUM2QsfKNJojCSd00x8e5aT2GRd04jtUTt1oeOFTFfYCqiBOGDPe4FnA0MUwWJXRIw0+kV9PMhBFh4f8paEGHdbhxY7QWtepaghlTYHdncBLc2lsHYjnzSPpZRpqganV8zqfeP7VjiYZ/XNncWxo6Ui9beUd1NiKnldRxfiGXb4nzIQSJKiXHdPiSJc4BVvF3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH4VGjEYlmZE/OJHl24D1EMKFIPtXy7SjRgQ7RheK6w=;
 b=qQPphA37A68JCSkY2RXK24rsdIj208/pJHzszbIA3oISfct5gNPNjugX+tcB9ZaISR9jTReQlMeV7OxEiv9FqbNE4+govDE9EM2EoXUNDuw3foek+X9WIlfh9i+NXu/JA1cVhJnb26hdHTjK81O0k3u0y0EeaySZo7M4mMxpk2ZHwcZ4n1EOsPa6onQ5DbpTGn67uLzkSuevK9KhS1liBZYtQwcej9ApNNvSYeDYouHDDgtqeXQJvfb1MWUFuppcJ/wUXw1fjeX1cyB+6ODlI1P3Aammi5u3YzIUHfGv+spFU8+VKhszHrIrIMsWXmk7kc5Zvq05S0Ia/i0Ku1Nqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH4VGjEYlmZE/OJHl24D1EMKFIPtXy7SjRgQ7RheK6w=;
 b=A/vi5H+ZhjK6yMPXVT7a8PlwHE7xC28JUL1AW87wRCT/rRweozPKzUJ9FUYmAXZXkfvmjyGGUl8OHsel2UU3m28Z0IBBGE3JWh+TBYTZ9d1gpHEpVKrl8lNbVMVF8lbSGXbqFAcI0jAMdhgDENM6HWbE22UEPuTwKlcCOvZNOUFEzFcpNWp+hcxIh+36F0MIpBsRayLWuAZfw1B5+EY0mVh4//xauJAMpiwaxpg4ULqLmhfYsb5R+/4yIg+SxthRUTIyIHXxmxI+Nto5U5K51i5VDEWze2DAXYvfj6p/jEsmkIxKb2eJvDrRIpYkBjY9Isv0LmmkJjj3Z9KT+HZqTw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 17:54:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:54:57 +0000
Date: Wed, 3 Jun 2026 14:54:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Bob Pearson <rpearsonhpe@gmail.com>, Sean Hefty <shefty@nvidia.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] IB/mad: cap RMPP reassembly window size
Message-ID: <20260603175455.GA1554392@nvidia.com>
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
 <20260520154715.1457495-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520154715.1457495-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: f9299b0a-a7ee-434d-f2c3-08dec199398f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|6133799003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	6v/lrlc2ud0OF3OS+cXQNuB7WcCL40I1dK4Wa0SseH9+CDD6hI6qka31MXZo4kRcS0hLLZZKShHttCdRV67fFu2DI/qL5ivLkrNobk7njj86Lqb0XQRdz04j4xwX974GDLJOL1YP3cKIaZNpTD2oqrfeYH0TqxaPbMF/eb1/ZgCH49+NYwp4nUMGZJ1lBKZk0X8p/s08LrhRMW/aocAtUuKRgb3Gfev/gW9tKQXDfPB3TsJBKvQUznzyC/eEzjvZZAHRB7U2nDB8NGpJtIVCb09e0cqsnAWNK3OmHLNDdyYz5+sgK5U8Iyjk3YMNhrFwp4eAweGES/6Al5wpZcUD2U95LE8TnqYbxvBUt10VumxuRkJUxjN/KglcSzCJKy38BwJiwa7KlCQTaNtrYQw6dc5MiRES3P5yTa+4rzgyt/9LMS7/x4o3HFri5gkS1IfEeFBHE6D7or3y8Qx5euOCVIxZgxRmGNjKX82Lh9LbGQ5Ta3MEjZfrACdidpel3rHSUsDz6ou3e2AfbRdg+BCYXHHIBVR1tKY0mS3Q51hninX4nvmNch+uL39jTN37JUy4Nh9j2MtutQwUA9U5QZK3sooWHOtNaTa1uPEmZVQqhTd4iRuxgcjA7ecn5lgsMN8l/nNcshcUmd3loXbSbqhkVLMjRuWlX9gFz3wtqctZ7+ILYZCbB5Wih8fHdvrSdXk7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQQJboC6mi/wMGaO/r6rQMbKBRLfbERCWGC+xxCiPwj6mqZ9F2zS/wvp7Bqf?=
 =?us-ascii?Q?q/ThEwJzIBmDZLbnrsoyONU/xMZuqDC9l/gmpeqNGOiwxFUojUfemWC7ayzR?=
 =?us-ascii?Q?R+UJ1bVQxRlpYZOhZFxTyt/dzAjzPeSYmCq4BW2HgL7ILPq5vaoW6yLt5v1g?=
 =?us-ascii?Q?rJ14iOr0XKSDWcQc3GHVgupv5Vunl6iACXJ4BykhBvfBvQVhfSSPk6LW2VSG?=
 =?us-ascii?Q?CKvKP9tIe7mSXgnpSUGs9rdXdS9hoiZOprxz4+2YJKft2lRcjfbbnaPIk7f/?=
 =?us-ascii?Q?HkH8cUtVAn3IbYqBac2vGwGLXbjtlVU/BLrt6RE0JMai1rm7VTjNKVcw1FQu?=
 =?us-ascii?Q?LhPd9bGeTTXqeUqW+m5Wwr6JWgublcUTuf1Fo/wqRIw8c2qTqO2Wf+4YEBCs?=
 =?us-ascii?Q?r7KH3OZ93509FZehZSVhctNQeRjnKu+HxwBf9zOIo3szL4aJFZ5vZFakS0gi?=
 =?us-ascii?Q?394rKi7rJZambdIsYUkyXA2HrZhMInDA9kAygrrMhd4AkznKG6nybkfgNblI?=
 =?us-ascii?Q?wGs07rkxGBxk/xdSOoZCI7DrW//qpOSa/kGbsWj9NccI583ADTknIgiwUXSa?=
 =?us-ascii?Q?peeBzhofuNkkQr1gyW+cx1hNhZ3YazBG6mOjMu4ICpYzyaPk38XnzJeRQvq0?=
 =?us-ascii?Q?yxfcprxrkWt5tdE3kVsFb7yJZgOKTkTRrsElCY44dA0FzKlOXT7oeWcSc68P?=
 =?us-ascii?Q?16KScEi6i3mTGZ+u058EcKrI70sm6tkfhaqkY5HbWbhjLpd4CPfKaqm/JG7d?=
 =?us-ascii?Q?Xs538TcznLyKvgb+XzZloKK3zd+ao6M9JIMxX5NQRCgz0AcqrFdkUb0ME+wE?=
 =?us-ascii?Q?KS6zHlCSiRwaHjcPnvPzxjElKu4DPNyZpWhUmGMVIi2kKGt4iE9SRbQRuVdW?=
 =?us-ascii?Q?0AQz7tCj5phth4+IM85BFjp5e+X9FnbUUz6hWOQSGCiXtgYhcO9ggxMSfkh6?=
 =?us-ascii?Q?gW3HBPBZ6XjXKhGB3XEZJCZ4Wl6scthYylaGAmWCiyXG3dYm9FbEbw9fRND4?=
 =?us-ascii?Q?tCEbC7cr5kuvsyfMBHfx5ZQtPZyK6NZD8zyGThqlwfO/s9byw3yr5rMUZfFZ?=
 =?us-ascii?Q?i2MsxbU+U5IVjT7UcKQtwjhAf1ff24T3bax+wBI+2n9yyyRWuLWPBBv3YKr2?=
 =?us-ascii?Q?/fQsgZBuBhWXsKgNPeVWBAVTMCDYG7/RXMEH0N8rhWVCO7OnetD2BlN6dLzO?=
 =?us-ascii?Q?s5qyoqwMG/225gNm4k3408zmhrDzf7LJTc3umPo2JqFeJKV4Lw0j2YOM7aoQ?=
 =?us-ascii?Q?5K+3Z0cChQgy0zNNpqahVYm0B5INy9Ba7W6DeOS/f/dhr5C/fF+NtfJYWjln?=
 =?us-ascii?Q?OvGpUykoj/ePglzsQdwa4eaVdDpEuh6WeQgoHducuyLxOgmuZl+Qtr4/2nEr?=
 =?us-ascii?Q?xbBldO7KjxYy5ixWi+xYqoDcwYIo8lZS3TlR/+wSWGbzuQ9ViHDx+SXa/3wj?=
 =?us-ascii?Q?e/0esxeYae8WhuHLswBFXaoJBqLt9YN/6aT5becWSdWaJQbcBy8Eorlhh2R3?=
 =?us-ascii?Q?/Qdw3uKrQSD38MidrPS+ngFzOOQJnr1oGUh1dCH0lXCwQTPtaiYCwLGVugk0?=
 =?us-ascii?Q?1D/JVQLHlFpipccSOKgH7QWOWV2t08YPDZJ6Nn7Z/EJqrnTb+7oPtjAscyVK?=
 =?us-ascii?Q?g8+83GgW3tqjtlKqWdTG1rk/xNJA52pEmfgnwLkk21CYopcb9UEFvhSZB40c?=
 =?us-ascii?Q?Lut56uJmd6OPL6kh3AH1ukNQwB2LqqIfLsWprCuUiOYYclB4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9299b0a-a7ee-434d-f2c3-08dec199398f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:54:57.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpaikLComGlsMyXGW5+DyFqED1rYBt9Oxt4QbOtXWhZ0p1Rt5EG6kg5mtX8P+JsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21699-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vdumitrescu@nvidia.com,m:ohartoov@nvidia.com,m:rpearsonhpe@gmail.com,m:shefty@nvidia.com,m:kees@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51CCA63A548

On Wed, May 20, 2026 at 11:47:15AM -0400, Michael Bommarito wrote:
> find_seg_location() inserts reordered RMPP DATA segments into a
> per-transaction list by walking that list in reverse. The walk runs
> under rmpp_recv->lock in the MAD receive worker, so a large receive
> window makes a reversed RMPP burst expensive.
> 
> The receive window comes from recv_queue.max_active. With the default
> recv_queue_size of 512, the window is 64. Larger tuned queues can raise
> the window to 1024, turning one reordered transaction into repeated
> long list walks and keeping the target port's MAD worker busy for
> milliseconds.
> 
> Cap the RMPP window at 64, matching the current default. This keeps
> existing behavior for default configurations and prevents larger receive
> queues from increasing the worst-case insertion walk.
> 
> Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Impact: a fabric peer that can send QP1 GMP RMPP DATA segments can keep
> the targeted port's MAD worker busy with reordered RMPP bursts, delaying
> other MAD processing on that port.
> 
> I tested this on v7.1-rc2 under x86_64 QEMU/KVM with rxe and raw RoCEv2
> packets carrying descending RMPP segment numbers. With
> recv_queue_size=8192, the unpatched kernel spent at least 1.5 ms per
> F=1024 burst in the insertion walk; the patched kernel dropped the same
> run to about 0.28 ms because segments outside the capped window are
> rejected before the list grows. A normal in-window F=32 RMPP exchange
> still completed; there are no in-tree selftests for QP1 GMP RMPP
> reassembly in tools/testing/selftests/drivers/net/rdma.

Why do you think it is OK to only search back 64? Where do these
numbers come from?

Is this a real issue?  It looks to me like all this code is gated by
IB_USER_MAD_USER_RMPP and no in-kernel user makes use of RMPP.

Use of RMPP in userspace is extremely rare and requires privilege to
activate. If userspace opts into it then and only then would there be
a performance issue.

So I don't see why we should be changing this and risking regressions
with the window reduction?

Jason


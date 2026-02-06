Return-Path: <linux-rdma+bounces-16614-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLGmKF5IhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16614-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B4CF90C5
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8722630210F8
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A78248873;
	Fri,  6 Feb 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlMRazfR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F247295
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342354; cv=fail; b=Jd4mCzaspoycpwj7kD8RkDexB4/IKARQ1QXBahJPQDY/mZNvnoogHpvw2wCUCQzy29tEAjeE3eHg9cpN6wY0FbkYR35Zh2nejvcyu/C4VV6nEfXrS51HAyr9eJWiOxnL0c45OHGjU0WTC35WsMMNEcRRKHOYN2GkAwxf8s8e/mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342354; c=relaxed/simple;
	bh=RoNh/1jirG+NKvettWryRoWGRx3ZhA++sog4NfCwmks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iww93B66YYvQZIP88VisVOLj73GEnEavx32ltPGo7lJOqbsmv4qrXHsoYPHqw3DxefrfDoZnkyRf/z92XmBtezFZHtHXcOD4mmtZD4Dnh2C7oVKcMclkMoydTGFackI21WqxPZMDhyvMedVoVVjAyLxubLKeiODTfGFwKbMNPkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlMRazfR; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G61dSu9KyQ/AUMaTclD/s1ja5u1tKdwb6b7sKAYAmceUI0TSILPbq2D4VWZNLxlhnXT2TH0pnPhtcq84j7PYtUuZ9D5hC/b5IZ9JNs3H2ikEg2imCMSCPqcTbiCw2GR45u6YKj2itPeRlX9C5VpXqZvOgDRvMuNZMD4/zQXuJitqKGOFrrX3biKFSPu45BK+m9nmITja8+cUo4Iz2UI85isJPxotieM15MNgV2hQ9YVq4GS4lGPL4/jFU5hkfYiCPFPgNpsPXzqeWVnGespBmj4FOYQon+bgASc3ncmK82R9mVh+scjhszi2C/ymQzMI/rQHPiXiSzmzrZQZmIbn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuMiEErw9hUpSwowg0lou0iC78YX6hphrAyIW8fw0tw=;
 b=bt1iH5gEBk82CX2r97cY5V0WPC2/LVLfdFED5EuuNNYaqzqMnPL+jD2dNhFp6I4Dq6NXp2KsgjRjQzT8g3aopunKA4jcTK3uI3ddbjIhAGNi5DNGH3MIoYJIbIXhUMR8jYCta4Gukz0Vo1fNf2TSBwnpRuIzBhRpUeDESPeDzupRetKlkiLUMoVgrx/dRx5xSpY4bkXlcrY5TfpqmJys5q2EiBWxN8g0OXDjuma31wXrm0n4lbJNjTFL8t589ErrsRMSCmjBLTkncreqtWaUEyhOYQJrLoFv7NQBcfy2Cez+/5/B+x6hzGIrcwYQpFck6jwAUw6Qqcd6K9cJtvZo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuMiEErw9hUpSwowg0lou0iC78YX6hphrAyIW8fw0tw=;
 b=rlMRazfRAdU2DETYriRa0asCB7mZlcMh2sJj6fvLmwB6rnkquLjljJ3nahK8pG3tVpZdrJO7BqdyRNboIkyEMFl5mf7TjMD7V1ZjlI17/4Dz+/VHZz8x35/ATEeX7M2rBbwd2QI41Ey7S/toO1FLakt46RZDibbM30EGRCnj3E46EbmNqKeJQ4vc2jkJgRbokR8QY7kpQRTwnAz34Ho9k4w2LwKssNwWWaDD8ue7H8z9j47dvYwvrfrM1MPsd3FK7X8/jzoB7JoPhR9IvP7O4uZMpDCkU4apTgpCwx8kX/DDBd1BkQ/9bkgxrg2AtfBd1UcmjoLK6fWRx2wtdE1/+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 09/10] RDMA/bnxt_re: Use ib_respond_udata()
Date: Thu,  5 Feb 2026 21:45:43 -0400
Message-ID: <9-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d5fb03-19a3-47e2-de42-08de65217272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Hdrb2uI24ervj3RXAltYZiSmhFfmgxmKASa2qcR2qxxVZ4Xs60CmzCUXs+E?=
 =?us-ascii?Q?CKIgDugSutuXlB3Gkhz1EyW46MdoBB/2RmL6BVBNusbQbong49vb0MszpN83?=
 =?us-ascii?Q?p5LDDMAbfZQTlyIYgAM59wNKE5wO44POpeKqrC24dP/1NytVyyVMaAiaWYY5?=
 =?us-ascii?Q?VmjGWVWL81Zsrq961zJBUEdpNMQNyA+Oz66uzxakZpeuC5AKD8m70UaLrA9S?=
 =?us-ascii?Q?E3SQUO2ryiAmrbdLLcwgHV3OOsmSxt/kHQJuWO3iSoopBWih2m7PVeSprQMZ?=
 =?us-ascii?Q?H1SUibLiU5ETRbdRg+/sLqWmaht1CdhyYcKmN3HFuK2B0+gEqjt0ozQLP0p+?=
 =?us-ascii?Q?Hcy80WUhb8B/WXpgH4RA6jMZkTkUkS2UiXnYSNAGU43DgUm7OqTVTnITIbDA?=
 =?us-ascii?Q?oi8ys7mBpoLr6BrYCgadMMaG9na+nSUdO+8KRjNjrLB3IeK59tty34c7o6FN?=
 =?us-ascii?Q?WBpjjTssV4Lq+2kfrPKuf+mWB/7INrHKjWxQmifxnJzWeazx4ep+sI7bJUq5?=
 =?us-ascii?Q?hwxI2oOl02dzkOzUsGVG08qY2K1J1J5vf8ZQ4djI684tbvJQsIvha6rKINGy?=
 =?us-ascii?Q?GvRXnK27eQ++zJFR1X1Wqa88TZEFsJJ1k5z3M8R6RXgv9EZvZp7FEG4sIKwb?=
 =?us-ascii?Q?CMA0kTqu8dK8X4FaIfD6+nC3+mTgfk9wmaY0Y1dltr1pzdmijjU51q0mmmyW?=
 =?us-ascii?Q?U0tGxwQxG7j7MrH5/CcCpojeiAoFyL+oTaA7Ivbg6JJB3dzMhcWRFFaCuhNa?=
 =?us-ascii?Q?GwQiB4ZgMHmyrl1y1FfN1E9UWGKZRFm92IBRvRWWxcU69qo6g27x4FWmFAKc?=
 =?us-ascii?Q?qZqq7SucvwsfHd2mf96+8tMPHkp2Fo7qr+nv04WnB3lGMSuDVKcoefCDxujq?=
 =?us-ascii?Q?8rL7+tspsHwbho6OIkZjYWI7bSp6CZLlXY9Yj4X+xFOuFjuJ0OKPDNNzE0Sb?=
 =?us-ascii?Q?M10wEYpObd+LeWIlJerxARseigwqHVjzfFtgyJNXuyHsUdQRfPDo1TfHO6vx?=
 =?us-ascii?Q?n0dgr5vucAXmBjtbzwBmzCoXoNrgDG/zn5NJLKO4YQ6q2F5O/ESxDOGQq5UC?=
 =?us-ascii?Q?2aMIbBLluHtYZSbhj/PYA5L2DsdtayDYxu13DslGq16EMPJqGQ33RQSw38mD?=
 =?us-ascii?Q?jx7R0vN3j77vQAHl0LCwgZo+yOR3XNuh3ZeIgGxHkbQc0fMSEOyDYBdn6uf8?=
 =?us-ascii?Q?nRBOBKPcGn7hAGSumP2YRWvizRAjl1CBFnVPzAQwDH6v5iW7RCEZyrYtsiVl?=
 =?us-ascii?Q?fk1gkg59zYI4ZmeBtq/IDsch24xV3jmlDfal4M4Ep/g3a2+4NRCVGUsRx1f5?=
 =?us-ascii?Q?LxjoTENfyXYSRpGCgFn9UXnXzcW/NmHxitDDNBU3Eq/XDvCUjqOZuWN+zlHr?=
 =?us-ascii?Q?IbH5Z7fb9AzrM90i3MdUVZ3HH9L2CFNNHJ6Q0tJkIyYIudKz4CmFwn9CCYzq?=
 =?us-ascii?Q?gIgqoCYNrqKAKznDlToooTXo1KAZRHxhkcxDUQmL1psJ15iqNx3n8dRcpJ6T?=
 =?us-ascii?Q?DrLb968PK7eRtQY2UriYECwmoX9Ap56iLflfp+HEEHRzCrS+/1Akl+znrSj/?=
 =?us-ascii?Q?ETxCmDd8i3Pr164bhkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?beRUwMQohCi+d930keW/ZNISfnvUhlutJO7WjrEogi0ezqHRKWsq45lBvLFr?=
 =?us-ascii?Q?GIJ0mqMOQ25896KCm+Bwhf865hfjxrRiF/g1D0v8UCYH/mdnAcYiwjTPaQ7v?=
 =?us-ascii?Q?1Gh1Lj+P/ChA+gyH+jZD21UeCJcDxUPoH5q/tgNMxfAsZpyrFjGZtsJtjMvt?=
 =?us-ascii?Q?cOOjnRqsKsThDhLEFQKsJuZu/gz2+/XKafU//p/CcMpdRoLOrZzjycgNKIne?=
 =?us-ascii?Q?tjSGvtzKcvbBrbqVAzR8jlddFnlCKVMnBg9kLLW828k7aiuiRTSd+8MPt9/a?=
 =?us-ascii?Q?CKqfuhFv/4aU+YwRT30usULAwFztEqWgmRcGoLiUxj3apnq2+3DvsFKn3rGv?=
 =?us-ascii?Q?ivaJk9R45IN2NJsIBqWV3L0Xv+YOoP5tCtVYpvpvMdVliSswYjamqWBVjxYh?=
 =?us-ascii?Q?hSazKg9ccRVBtYek/fws8G7UG8K3OBG3qrQgyWi73msI/b853Wx/y47p4Lde?=
 =?us-ascii?Q?S44tPSEiTv+5Cd1V0I7EsoXQ8WAZAhY/fLZnEWjElwmiuHa9vwGdZYaqVwQd?=
 =?us-ascii?Q?0HV7MCEYOwkkpqEE2OaojOATI7Z0VC5CJVGJ9tKpiw67AJ0coqzjYtkcBtZI?=
 =?us-ascii?Q?rQ4tbFAcRB/TkxFfczhiwGrgqcnyqN6vRlpG3TUlex2d09JuKfBP8gr9SJGK?=
 =?us-ascii?Q?tlamIsPTnMg1+XfOuuXLKSzFTPwTtBiPPGgBzG95WIwCJwjHNOIgqHhHuZwK?=
 =?us-ascii?Q?75TtFKna1WykoU7n/A+dUgFDbXZuxsTKzYJSDqNByDxN5N2EsQ+a9tjKzaFR?=
 =?us-ascii?Q?6OcHqi3+AunLA914aIVjje6NYzbqdxXYZ6XZ+VabhDEYzxvddrF90xYfoB9V?=
 =?us-ascii?Q?2OGV+JfrJKoj1pHFLxkmg0SkYm9GiW6H2leCa5mvKchSQOltG9be2UwmDHqS?=
 =?us-ascii?Q?OyCpZJHRvKXcIGRe2UjZpsAJ03Y7SM6WYYY/m7SIzl8aRNtNG1VE98vGWWIF?=
 =?us-ascii?Q?+VaB52YBSD9yzj2uaDDjPNRaoaVosx9/+hare9wapec+v4hUIFoM0Xs/V2IG?=
 =?us-ascii?Q?PUKk8bPWu+xhmTLxHKYRwtl0QT/UCVXTKa3eg4aoQI9sUFRC03XpWL0qhWoY?=
 =?us-ascii?Q?9UnoJI0oS38wBf9cRFqA2f0EEqvpTRFbZS9BpB40lruaNcGTuVZeVHT+62Bp?=
 =?us-ascii?Q?PH4s8ObftbNPpWZUhYgvNw/ddyw0c2vLixHZDQ5Vsex40LfSs/TggDq+3equ?=
 =?us-ascii?Q?Uj0ti9avfvXPFl+5gEG6HpvSxzqvLMjXfycs/Io9RR+/21DmEGYCs6UPQ1Rn?=
 =?us-ascii?Q?F4VKcpbGPHHwNimRDLpIY1B+jF9twA4qAnl846Inv1D6TAYD7CWSZKA39pTc?=
 =?us-ascii?Q?DgtNm4CceYhSH4V37Jwim7XZXcuYgQG0M9WgveZqOEz+eb1vdO5zm2AsTIpA?=
 =?us-ascii?Q?B6FLuCvyzJX9moUbMYqhXNVqvcW5++7NTrgpSryTy/KNkEZ/Qg6vH9hKYEeS?=
 =?us-ascii?Q?Di8B3CzWzxZEjRxwWDeQKkskKSo26xVX6FZtwIAdMOPEeqhCrC12fCJGMObd?=
 =?us-ascii?Q?3H2v6zQto60BrhjTBnFW1uFB7QQZIwnx2D/lyzouD+qf4Cy8/JOnZC4Q8aIa?=
 =?us-ascii?Q?4cuBjq/E1QwPx4wvg0XHZRICccezONFUgqHHHgv84aaGbtQAHhnDTsiH4W9B?=
 =?us-ascii?Q?/bOOJl2c+LWQQp6UoOgEdY58TbcXNVHqNLY6j3tMfvnqhHxKUqjvQPZv0Pa6?=
 =?us-ascii?Q?7LntpYS3Cv1X8UiY6HdQ7V3DBB281fFcwiUk2iOd8T4QxckOPogJ3O5Zj5AI?=
 =?us-ascii?Q?+W3hPSzjvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d5fb03-19a3-47e2-de42-08de65217272
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:46.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpqzfBLN6rLL9GJtVluvs3MInPywlVBXuYVUe0UlRCKzyn6ayEQWBG04yehc84vj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16614-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08B4CF90C5
X-Rspamd-Action: no action

All the calls to ib_copy_to_udata() can use this helper safely.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6ea03e1f6c23dd..9d1c31bb994218 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -748,7 +748,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 		pd->pd_db_mmap = &entry->rdma_entry;
 
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
 			rdma_user_mmap_entry_remove(pd->pd_db_mmap);
 			rc = -EFAULT;
@@ -1705,7 +1705,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
-			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+			rc = ib_respond_udata(udata, resp);
 			if (rc) {
 				ibdev_err(&rdev->ibdev, "Failed to copy QP udata");
 				goto qp_destroy;
@@ -1966,7 +1966,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
@@ -3248,7 +3248,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		resp.tail = cq->qplib_cq.hwq.cons;
 		resp.phase = cq->qplib_cq.period;
 		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
 			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
@@ -4449,7 +4449,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 	}
 
-	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
+	rc = ib_respond_udata(udata, resp);
 	if (rc) {
 		ibdev_err(ibdev, "Failed to copy user context");
 		rc = -EFAULT;
-- 
2.43.0



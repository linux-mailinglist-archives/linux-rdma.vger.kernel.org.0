Return-Path: <linux-rdma+bounces-17029-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOT1Adfkl2mZ9wIAu9opvQ
	(envelope-from <linux-rdma+bounces-17029-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 05:36:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19AD164AD9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 05:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CCD301E6E5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39932BF41;
	Fri, 20 Feb 2026 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p9ZpFu9d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQP9zw/r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818B1FCFFC;
	Fri, 20 Feb 2026 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771562193; cv=fail; b=cGCKEeHAfJNPy779JwI7lqjShAk9hajX7Gc+nnEgqFgTghs5skZN+EX63YMQ88rbSdNAZLzToEyDZgmXKytOBs5EJ3VE92A04WtZpxpFMtqFpoROG86KV+j2pBZZuaj6aWgdCivkc5PS027CG3ax2fNxEeaUuwA+UjHDRci7A5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771562193; c=relaxed/simple;
	bh=5WnsCl3AI75D/21kMCRaywXW3b79lRzrOj4zfL5+ayA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PNUANojHXZ2Cj5DV2gq2c7diW93FcSsbL1hhUXAUzaSr6ast529m1/ozWgBrR3dDLpE2Dc/yPJScHxuUZTkK3Vhe6iL0qpe0p7HU81Kmyu7Npq4lnhXwLzyxA+yXnV6tJPvnnJ2TgSZRe2hDw3+cb1ubV4fJPsei9ta/n6SEc7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p9ZpFu9d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQP9zw/r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K2iSYD2541884;
	Fri, 20 Feb 2026 04:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5WnsCl3AI75D/21kMCRaywXW3b79lRzrOj4zfL5+ayA=; b=
	p9ZpFu9dgK06zeBnDd6/yPBsL3bgTdArd/PhCkWvAPg6SuNMoV/jzb+MOaBhI8LD
	tYv3XkH0NUT8hFZAZ4AK19WPcfyII9TkuJh/eZKP4n4j1Cz8TqoLIY7KF1DIi5K/
	OkDmII5Q4ZfYlQYHaEWWt5S7TfL1dEsGVWn/MbFyVOd22PF75JV33PaZJkbszoMU
	pdHFpFCyUX4WdAMD3YquU3HSmrCsVdnGL4LmV3oHapcRqt4v/c1Hm7gdxfRa4/rb
	g4VH86VkgBbUPCI69dqW3nWvVyP2Wbo/Rj0G1sKquWZjpKJYU3rzb8GEse4zJxXE
	MvRvq+iUGohPfUjEgB3ZpQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6mgjvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 04:36:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61K29nuq037164;
	Fri, 20 Feb 2026 04:36:15 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2au0mh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 04:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuETehnEBnQChB7TmWkc11L/GO0XtBrdn8/4Jv/gRE00uEtl7l6QkKRWOjm4pIWUgSK9aEXC0WcAakVqJwKi7x0OOm/ajICA+BhefTkG0ahFqyEoadF5f0ZXVEUEIGxUh/GkmrF6jDXz3OEXbmYoW8A6k3AgCfznNcb9Y7JQiU3gtEH7QHOvzIsFfvA+QDUuqPjK1HRJ2gnK3bN0GIpN6w4BWiJgQFs8j/vmI0tPOmsruyVpEpzCwjudmx0uUzH2TamB1aimprD8NhfLWGxp7hjLz13c2QRNdSKZ/iJdayCpWiUUGo5yCroBnLivUccVcXMLw4xRLPIkZ2UASc9A5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WnsCl3AI75D/21kMCRaywXW3b79lRzrOj4zfL5+ayA=;
 b=VpQLWWD/JKfJJcKm24IArpbZtLbax95obdhmIuJB5UJz7YZrfeAxAXCJBY0LwQQ/mZE0ApNeZimMiQ1JzJqTOdsLpDYbp2jz9j7YhSGeZwrrsMkk//AXj4MP10zhM4Or4HWUI2Dnioi9qFF2KTFKGfsCO6Hzz6PJXdYusaT5ix2gjd1XvYVFzfRjciAxpx4QwvD+lSSdab71UKTk2IQUvvUKH+tb5RUNMSs8H/oXVj6qytS+XPKH+mI6wOLuMf6E32fzXbFzkBpr5390UWmDhO8InMtewxXSHSKBDqwbOl7SN64vT0EwUDTuEYXapRo3m9E990oFOQbC3iPOoQmrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WnsCl3AI75D/21kMCRaywXW3b79lRzrOj4zfL5+ayA=;
 b=KQP9zw/rK99tq3Klgd8xX8t2CJxnNr0weF6WwhUAeIUNt4sbW8vHS12WsXdZ+dc2orTO1xVCAF7ixPSjXNxy1KJM+/d9kKzeg2xe38eRwRMXH4QLBXh/8NV7PLr2ZmKjjEf286Hk5uUNmiVt+xsRjSWcgENSGELAEDrTCCa5nh0=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 04:36:11 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 04:36:11 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "fmancera@suse.de" <fmancera@suse.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com"
	<syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        Gerd Rausch
	<gerd.rausch@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net v3] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Thread-Topic: [PATCH net v3] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Thread-Index: AQHcoXWG2YBzKs3lzk25dGoaVG0XhLWLAfEA
Date: Fri, 20 Feb 2026 04:36:10 +0000
Message-ID: <3d26bb0b2152c09c43e903b620640bf15c6c1006.camel@oracle.com>
References: <20260219075738.4403-1-fmancera@suse.de>
In-Reply-To: <20260219075738.4403-1-fmancera@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CH3PR10MB7573:EE_
x-ms-office365-filtering-correlation-id: cd8522e9-b718-486b-5471-08de703992b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2RMbGtaVkwyR05HTzlSWjRmdldoTXdVUjkvcG5UV1Q5QXJVTktZU2tTKys3?=
 =?utf-8?B?WXU0RVZMS3JWSE82aW9oaTIvdWkwMnlQakhUcFR1U1lhNUZLaXVDOTYyN3Vz?=
 =?utf-8?B?cEdaaTlOZXdQTzdqeFBHemltbDFyaU4zSEp4aFBUcjFkMkgremRoK3Yzd2t5?=
 =?utf-8?B?UWI2Rm9tdTBuZ3FEVGNETVE2UGRGbWR6OXhuYlhNamxGUUUwZUVhYit0Zldl?=
 =?utf-8?B?RDUyRS9BZ25LQjBXSHduYnRSdGVNRnBIMnRaVEovcVNvS2Nia1MvQXJQWDEw?=
 =?utf-8?B?RlJKRThqUjh2dVNiWkFTTzl0cVJOYnhIbXNyYzMxb2p5VDQvbDlpOWhDNzVu?=
 =?utf-8?B?T1Q4RXFIZXJzQU9OVzRnQTdjUStuZXEzSHFlT0tWWkdRbStLSzlsWGIrNUNN?=
 =?utf-8?B?MXVUMXcydjJpcmI4QldSYnpzQmJBUis1dDd0OEw3WDZVcEdueEhFOC9STUFo?=
 =?utf-8?B?NEc3Y3BKZXM5ek02N2E0SzY0TTJlQ3hURFIwaVcxb1hENGNGa3hta0huSGtO?=
 =?utf-8?B?NjlaYjR4U21oZXMvYzlLTit2VkxHaU9RZUtlN0d6R2dsQlFjWTg4cFI0MWpW?=
 =?utf-8?B?U1J4YXZxUDFOWlREZEk1eE56Y3NicGdWaEp5TXZUd083cVl4eVlXL2xPUk1n?=
 =?utf-8?B?Z2ZUeEZzRlZuTjh5cWhzTEx5eTJ4WDU0emZTN3dMMzlrL0FXUExRZlAyYXVs?=
 =?utf-8?B?Snh2L2hMSGxuUk9PRDFRQTl6TGNmRStyT3d3dG1xeFJUaHJCZ2wyc3VqWDVh?=
 =?utf-8?B?cDVYSm8rckpnbFg2dzRFVFlRY21TenJkdnREUkJkWUw3Vkg1QlBLb2wzWERY?=
 =?utf-8?B?N1BKblBsTCsvSGUwT2ZvT0FQMUwrOXByUENVenlpQ2hISU40cHZpNTlBdWF6?=
 =?utf-8?B?K1QzUW40Z2RTaWwrUW9sY0UzNXNkd2JUbnQ3bkdtOTNSMG1ISVRiTTlNMzJI?=
 =?utf-8?B?WXhLc21kbUFLa0xhNmtWdG9JS3FwUmpQNmpySVprdHkzU09wNHkwR29CbC9x?=
 =?utf-8?B?TjlqWkNnOERiRlRZMk1WMHVNL080Vjh2RzU0YnRIOGc3di9obGR1UDRUMHRH?=
 =?utf-8?B?MVBGcStWVG5Dbm9ZNGNuaWtDSzJjMnM5QTlCNGZ2RzI1djN3VjI3eDZibjJo?=
 =?utf-8?B?ZkdJdXhNUUJNbUZGcXd2Skl2WDFUa3BsMkttS1h3MWxQS2tRUmh2c2ZUNHFJ?=
 =?utf-8?B?K29jYlNsWnQ1bVVBZld4c0gya05qVDBtbUx1RzBHcDNrdVBER1h5d3dDZHVa?=
 =?utf-8?B?eDNHUGlUMWtGV2o3dmlMY3BaRkViZWJWNHdqWks5d0RBdWNqNVhLS05lN1JB?=
 =?utf-8?B?U2NPR2FNSjRvS0xCTmJTRC8rbjFFaDRabDE1SXpKeUVUMTBiQkRoRHRyK0Z0?=
 =?utf-8?B?Y0VBVHRQWDRseitqV2NCQTBxTXZyNjBUcmZUMDNDUW9JVWhVREorUG1HSDBk?=
 =?utf-8?B?d0NmMGlBdldqZ05UVG5oVFNNOEIzWkIreGx3WHBlTHNsL2w0amlaV05rYll5?=
 =?utf-8?B?cGQzNzRjOWJuenRkSjQralVjdVlPNFk4T0gvWlJ4Q1k1STVIeDVmNGI3dGFW?=
 =?utf-8?B?Qmt5aXBIV01va0VtVWZsckYrTnJ3NmhhQTF2NnhwV3c2VVlpYTFjMUF0VUdC?=
 =?utf-8?B?Qmx1ek5tK3M3ZFU0RUNPdGQwa1RUNGhzN0RPRXYwclBFVzM2SmNxd0lyKzdl?=
 =?utf-8?B?NW4vYXB2U3RRZTdXMXdKdWFVMkxmUXlYTUJ2Tk82SkYrNTF5M2xNNlBqeWp5?=
 =?utf-8?B?MHNMbWdQdGhhME8vYUoxRnd1WjNPeVBwcVcva0xqbVlJampvOGdndjR2N2d5?=
 =?utf-8?B?Z2xmeXpwREVtdExpY3ZPUGRUQXJuUDltYjlwYUs3ZUZSTXNYNEd5R1VlTHZN?=
 =?utf-8?B?OFZOeXM4Z3RTK0RZaXpYS2ZhS2lzQ1pzZzEzM1F6L2xQcjltNGF4M0o2UUZE?=
 =?utf-8?B?NjhUd09wZVp0dVlVZndtQUpIbUJxbDlpL3doWlVsV1Jhd1FrV1E1Q1ZUZzZu?=
 =?utf-8?B?V1o5WFphaldJbWNOZEo4Z2hGOWZVaHBwN0hOSVpFK09tUm5HUktOWHEyZkFm?=
 =?utf-8?B?aU5ySVd6NmlhZjRYQXM5dWt6S09QWjZBNklabHpKK09tK0hUMHAreGtrU0F1?=
 =?utf-8?Q?9+9xnsnEWb+txK1BzwG2QbunW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3VBNjZSaUFyU0JGWkZzN0p1dklCMmR6SUtkY09Yc3d4cEg5SFRrMGNwTno5?=
 =?utf-8?B?UHVRSVR3d1lJTGlqb2N0T1FQa0JkUXV3UVV5NlRiRzhsZFdMa2pveVFxc05T?=
 =?utf-8?B?UElUc1RoWjFyN1BWRG9LZXVxbytrM3JLbFBGYXdhdEZTMEx3QVM3TzFyUGQy?=
 =?utf-8?B?QUg4VTdoaGxRRVhSNUluS3c3U1dIdWRBUFNjYzhYSEZ2c2hTdTRTa01MTTAz?=
 =?utf-8?B?MDVjNlkvVWVBeFpHOEh5cHVCTUJJZmdveHNEQlZFTlpuRWZJVjkzNTFBYnJX?=
 =?utf-8?B?UThjZmlhY0JPd1BHY3lUcHJhQ0tmZ3kxbzJUbG9NWGw0MktGNGNNTTBTS0xX?=
 =?utf-8?B?bk1ZWlh2Z2hGL1dZcG1RcVFBZThMSVV4UlErbFMwM2VRNWdqWWtZR3RlTUZv?=
 =?utf-8?B?eW91ak5Na0U5QUVrOEZXTmwyZmpWb0l4OFFVUVllY0doQ0p1OUV1NnNlTFE4?=
 =?utf-8?B?eDZDMVZ4NDNqTDhab2d1bTh4V0h6ZEF4c3RGdVJSTlhXZGU2SU5laDhNTk8x?=
 =?utf-8?B?WForYlVYWG9INWZzZlNjRFRYSGxoZE5FZG5DUnZxQklnWXhraGcvUUY0Mlh5?=
 =?utf-8?B?NURlU3F3ZENyN2RYMEFRckdvVVJzV2ZRM3Zia2hlaFVRamNteEsvaTRaWlhX?=
 =?utf-8?B?ODhvT1JudVMyVVdESllWdFFYTndxOStGcW1HM2NQem5aUVVvTzlDZnlCNkhJ?=
 =?utf-8?B?M0F2Y09DRTQ2bHVhNnplTWZySVZiMDFJdzlaWTNnSEYwWEJFa0d2TG1IUWJl?=
 =?utf-8?B?S2tZYmdxTFVycmpoa0d5NUJac3djL1AwOVB6bTdIVHV4cURXaUdQRkdoMFRO?=
 =?utf-8?B?ZjBzeTQxbURobUQ1SVU4cFJSZFkyNFg0aWNwZzVIcmY5b0VJZGpEUlhTcnNp?=
 =?utf-8?B?VGpSbS9MdDZJWnlVaTIraDFRdXFHZjdFWHZhZUpKZ3N2dFFqRzZ3L2Frckd4?=
 =?utf-8?B?b2hwdk1wTWhRMnFXZXpMNnlQdDJJWW94TlZ6dDlJbHFROU1XTlBVNS9SUXc2?=
 =?utf-8?B?VDZ4S0MxOHRuRkNEb2haYlgvUE5LRzE2L05zRFYyaE5lMkI4VlZoMVd6YlV2?=
 =?utf-8?B?RjFyRVd1N1ZlRHAxdW15L2htVGRyVkVsWEVsd0hSeWdkQmkyVkhaeEw5TlNG?=
 =?utf-8?B?cXFVM3lkejFsVlRUbDc0VnQvbCswU0FSSnZZbUtSNlVFQ0w3UDhRendoK0Y5?=
 =?utf-8?B?ZFJacTRzc3NMd0hhcnd5TnpCRU4wWTVEMm9hR2plbzlXSEdOVmRBd0V0ckJI?=
 =?utf-8?B?MEtWL2gxNHhFQS9vdlVodmdtMmNOVEJPbnpEY3h5bjRpM0dWQ0VjYWppeFVL?=
 =?utf-8?B?cWpVazhLbk1UaEpMb21ONWFvdTRDS1BpRTczNitsWDFLdHE1dG45QkYyTVZZ?=
 =?utf-8?B?eDd0WTFMMHVWbzI1UEw2NzlNOWRuWmZvVTJWNWdUSG9zYTlmVUJDSE4wbjJp?=
 =?utf-8?B?OEt0RktaeTJWU2JtVXlnN0xHOXpwZEJEUnhpMGpVaWVqWnlWeUQ0cFgvelNR?=
 =?utf-8?B?YTdYTVAzeGNudDZkNExiMzY4ZG96Vmd0d2Z0ekFIaXp4SU4xZUZLYklFeEpU?=
 =?utf-8?B?ZVUvSHJTemVZTWwrOFd2dDhJTTRiUk5zbTZyRXV3T29YRDZlQVNvUy9qczJS?=
 =?utf-8?B?UFJYSDRWbjAwNnRSNklSbFlyR0hicG9ud1dwQjJGWitPdUJRWk1Pa3Nmd1B6?=
 =?utf-8?B?aFBSMHRHMDRFL0RqWGFsN1dxSmJFN2U0U0piSHE1WHJ1bzNCeGZ1MzZReW83?=
 =?utf-8?B?bFJEWFFaNmE0TTZPT3F2MlpNNGxTVTBwTUhhTmpFbC8yOFZJMnZrbTkyK2pm?=
 =?utf-8?B?aFF3Y2p5RmVibUdibFNMR2pHV09vN0p6YW1BZXNSOXlZSWJkUUo2Y0dkQW1V?=
 =?utf-8?B?VVJTTTdlNy8yZmhUSm5sRldxbUo0NDdnaUE4ZVI1TnRWcVRlRTA3VkE2bnZO?=
 =?utf-8?B?by82U2tvcFg4UXFLUlVCT3RwaEd2SFV2cWx6bFFhbHh5K3g5MFU5NTBJSlFt?=
 =?utf-8?B?RE9PaEhUZE5IWndqZ09UVmNNQ3FKYUo2WG5zVFA1ZFd5UUxUb25CWExOZHJZ?=
 =?utf-8?B?QU9PL051bGVGUy9lYXBrK0xUZDVHWndBWHRLY0Q5OWZaaWtOV1BEUjBEZ2xm?=
 =?utf-8?B?ZFFHQk5kN0JIbk9KUlFUZm5yTkFOZDBjVHZkZk5hdnd5Y3RSSGduSFREL1hy?=
 =?utf-8?B?NmgvY2xTTUdOMllaWW9JUTBUb2kydWhUc0VnVVZQWUZoZ1BTUi9zbVgweklw?=
 =?utf-8?B?aHVLN1VyRjVMM3NQb3pOQWFvUFpia0syWEtKTGVPclJXWDBMY2tQNEt3Z0tv?=
 =?utf-8?B?UkUwdmJ2WkN4djBTVTNhcWJwd2VHcE5uWWpkOXlRaUF0QTBGNzgxM1JydmZQ?=
 =?utf-8?Q?xYtZpRA2AsUNo2ak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F13D5B0047833F429BFA470C2291F548@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ndODz2WAex2+yy7cNZ9HwbmdciP63F+cdeAQbvHM8Do8EqiUjq0BQrPVg52eO9sI47exoklTp+6SzaYD244h1jq83qTdcn+aJH7NbzEG/uPjmvpmHYjqWXHm6QRiw0MQfQwqszA9i8QV42PbU6cbMWjw16PqOAvZR/HeAR/mS7l6KqfmvhnxCG7ooNuzZ/C9Nx0EX8JDYa9qVXsYiBVPGmFRje+n0IY9p73/N3YQrDzCCtZoKBzxHI4eNE6q1xsNRUdyjdQjkNYV64zycWpnQkLGjbtzxJShhx83zWqUen4tVNAY/8aB6uE0x4CF25rF7g5BPN7O1ksWjc2FZkpZDr5bEc/dbzdNvIK3044u2xhj3lmuSS3azORl+T+rEklwx33Q0LDWzhq4sbX7WdPVuKxf5dfaVmmwOFcx3uik4YzPvKtf7aovzfXiR6p4iJ8NC2UyUtJEXDPW3+MhyT5wlLQLVBIYQHXVT2JUoCOQGgcpeYI9g9GkiTkE8YrMCgoOnMMIzs+3o42FuhRFehwzGug0rslBsBn/wl77yji2vSgFkl6SSttuih+4gZXlj9XA6VUwBjF7WqGAysLZ2J5AzFphdKe3yA3MdWHqI2TYV3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8522e9-b718-486b-5471-08de703992b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 04:36:10.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIl3rdK5+fDv4pt0xsWpULbC8bGlanEpv35woarQBNaZQeCg1P8+MZw99X18n8iJp3KfVj8gz5nEbs7RLDY2UUsGn2eRancIABkz8cGJRMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200037
X-Proofpoint-GUID: ZGx2nXX9PR0vvsGhv2AWEGWu7jDsPEOV
X-Proofpoint-ORIG-GUID: ZGx2nXX9PR0vvsGhv2AWEGWu7jDsPEOV
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=6997e4c0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=5oxWJP6zNvKkBt9ngwQA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 cc=ntf
 awl=host:12263
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDAzNyBTYWx0ZWRfX3524V+0jUEUP
 Bt5HMgOLFLirxw9faiFKDfZ7Et8+Zm4jfiXATL6d307QQ/5m9aHs84lND+Sm5lThS160nSTt5JK
 Qm4m/Sn/fb0t5fgDBDo13FY0q0MhKEIxBACILQGXy7EXtQG2AOuMMCpoebF0EExP17dWQLvZ7S1
 wDQAH8vW2W1nsgmKnOYsPjBVvxhITv1jxEqOx6yFx+5WVn8ETMJ6T6wXP+MvSwmTluPsOwlt40P
 tMpuRQhadsyjmhQ9yy7LT+OmSNf6MY8mODaqOR4K5vgdoUH+Zt8FiR2+TldI/HibYvvv2AX8odz
 Zby4DiCIvTngne2AxcmyFm0dQ7BGkYQ1xct41VHHthR8CmQA2S+4+NDfA8oeJDp8Uv5rNErP9Ex
 3mq7p4yzifPn6npiCaOoJkgTzJvo/D0AY85rGtnk3gXJlzzSODHjoD9/p+i0fFJ1WUCbHxI96CX
 /OKH93r/V0Ro92TK0sjh7fvXdNrcDVe5RvyPsMUo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17029-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A19AD164AD9
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTE5IGF0IDA4OjU3ICswMTAwLCBGZXJuYW5kbyBGZXJuYW5kZXogTWFu
Y2VyYSB3cm90ZToNCj4gc3l6Ym90IHJlcG9ydGVkIGEgcmVjdXJzaXZlIGxvY2sgd2FybmluZyBp
biByZHNfdGNwX2dldF9wZWVyX3Nwb3J0KCkgYXMNCj4gaXQgY2FsbHMgaW5ldDZfZ2V0bmFtZSgp
IHdoaWNoIGFjcXVpcmVzIHRoZSBzb2NrZXQgbG9jayB0aGF0IHdhcyBhbHJlYWR5DQo+IGhlbGQg
YnkgX19yZWxlYXNlX3NvY2soKS4NCj4gDQo+ICBrd29ya2VyL3U4OjYvMjk4NSBpcyB0cnlpbmcg
dG8gYWNxdWlyZSBsb2NrOg0KPiAgZmZmZjg4ODA3YTA3YWEyMCAoay1za19sb2NrLUFGX0lORVQ2
KXsrLisufS17MDowfSwgYXQ6IGxvY2tfc29jayBpbmNsdWRlL25ldC9zb2NrLmg6MTcwOSBbaW5s
aW5lXQ0KPiAgZmZmZjg4ODA3YTA3YWEyMCAoay1za19sb2NrLUFGX0lORVQ2KXsrLisufS17MDow
fSwgYXQ6IGluZXQ2X2dldG5hbWUrMHgxNWQvMHg2NTAgbmV0L2lwdjYvYWZfaW5ldDYuYzo1MzMN
Cj4gDQo+ICBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNCj4gIGZmZmY4ODgwN2Ew
N2FhMjAgKGstc2tfbG9jay1BRl9JTkVUNil7Ky4rLn0tezA6MH0sIGF0OiBsb2NrX3NvY2sgaW5j
bHVkZS9uZXQvc29jay5oOjE3MDkgW2lubGluZV0NCj4gIGZmZmY4ODgwN2EwN2FhMjAgKGstc2tf
bG9jay1BRl9JTkVUNil7Ky4rLn0tezA6MH0sIGF0OiB0Y3Bfc29ja19zZXRfY29yaysweDJjLzB4
MmUwIG5ldC9pcHY0L3RjcC5jOjM2OTQNCj4gICAgbG9ja19zb2NrX25lc3RlZCsweDQ4LzB4MTAw
IG5ldC9jb3JlL3NvY2suYzozNzgwDQo+ICAgIGxvY2tfc29jayBpbmNsdWRlL25ldC9zb2NrLmg6
MTcwOSBbaW5saW5lXQ0KPiAgICBpbmV0Nl9nZXRuYW1lKzB4MTVkLzB4NjUwIG5ldC9pcHY2L2Fm
X2luZXQ2LmM6NTMzDQo+ICAgIHJkc190Y3BfZ2V0X3BlZXJfc3BvcnQgbmV0L3Jkcy90Y3BfbGlz
dGVuLmM6NzAgW2lubGluZV0NCj4gICAgcmRzX3RjcF9jb25uX3Nsb3RzX2F2YWlsYWJsZSsweDI4
OC8weDQ3MCBuZXQvcmRzL3RjcF9saXN0ZW4uYzoxNDkNCj4gICAgcmRzX3JlY3ZfaHNfZXh0aGRy
cysweDYwZi8weDdjMCBuZXQvcmRzL3JlY3YuYzoyNjUNCj4gICAgcmRzX3JlY3ZfaW5jb21pbmcr
MHg5ZjYvMHgxMmQwIG5ldC9yZHMvcmVjdi5jOjM4OQ0KPiAgICByZHNfdGNwX2RhdGFfcmVjdisw
eDdmMS8weGE0MCBuZXQvcmRzL3RjcF9yZWN2LmM6MjQzDQo+ICAgIF9fdGNwX3JlYWRfc29jaysw
eDE5Ni8weDk3MCBuZXQvaXB2NC90Y3AuYzoxNzAyDQo+ICAgIHJkc190Y3BfcmVhZF9zb2NrIG5l
dC9yZHMvdGNwX3JlY3YuYzoyNzcgW2lubGluZV0NCj4gICAgcmRzX3RjcF9kYXRhX3JlYWR5KzB4
MzY5LzB4OTUwIG5ldC9yZHMvdGNwX3JlY3YuYzozMzENCj4gICAgdGNwX3Jjdl9lc3RhYmxpc2hl
ZCsweDE5ZTkvMHgyNjcwIG5ldC9pcHY0L3RjcF9pbnB1dC5jOjY2NzUNCj4gICAgdGNwX3Y2X2Rv
X3JjdisweDhlYi8weDFiYTAgbmV0L2lwdjYvdGNwX2lwdjYuYzoxNjA5DQo+ICAgIHNrX2JhY2ts
b2dfcmN2IGluY2x1ZGUvbmV0L3NvY2suaDoxMTg1IFtpbmxpbmVdDQo+ICAgIF9fcmVsZWFzZV9z
b2NrKzB4MWI4LzB4M2EwIG5ldC9jb3JlL3NvY2suYzozMjEzDQo+IA0KPiBSZWFkaW5nIGZyb20g
dGhlIHNvY2tldCBzdHJ1Y3QgZGlyZWN0bHkgaXMgc2FmZSBmcm9tIHBvc3NpYmxlIHBhdGhzLiBG
b3INCj4gcmRzX3RjcF9hY2NlcHRfb25lKCksIHRoZSBzb2NrZXQgaGFzIGp1c3QgYmVlbiBhY2Nl
cHRlZCBhbmQgaXMgbm90IHlldA0KPiBleHBvc2VkIHRvIGNvbmN1cnJlbnQgYWNjZXNzLiBGb3Ig
cmRzX3RjcF9jb25uX3Nsb3RzX2F2YWlsYWJsZSgpLCBkaXJlY3QNCj4gYWNjZXNzIGF2b2lkcyB0
aGUgcmVjdXJzaXZlIGRlYWRsb2NrIHNlZW4gZHVyaW5nIGJhY2tsb2cgcHJvY2Vzc2luZw0KPiB3
aGVyZSB0aGUgc29ja2V0IGxvY2sgaXMgYWxyZWFkeSBoZWxkIGZyb20gdGhlIF9fcmVsZWFzZV9z
b2NrKCkuDQo+IA0KPiBIb3dldmVyLCByZHNfdGNwX2Nvbm5fc2xvdHNfYXZhaWxhYmxlKCkgaXMg
YWxzbyBjYWxsZWQgZnJvbSB0aGUgbm9ybWFsDQo+IHNvZnRpcnEgcGF0aCB2aWEgdGNwX2RhdGFf
cmVhZHkoKSB3aGVyZSB0aGUgbG9jayBpcyBub3QgaGVsZC4gVGhpcyBpcw0KPiBhbHNvIHNhZmUg
YmVjYXVzZSBpbmV0X2Rwb3J0IGlzIGEgc3RhYmxlIDE2IGJpdHMgZmllbGQuIEEgUkVBRF9PTkNF
KCkNCj4gYW5ub3RhdGlvbiBhcyB0aGUgdmFsdWUgbWlnaHQgYmUgYWNjZXNzZWQgbG9ja2xlc3Mg
aW4gYSBjb25jdXJyZW50DQo+IGFjY2VzcyBjb250ZXh0Lg0KPiANCj4gTm90ZSB0aGF0IGl0IGlz
IGFsc28gc2FmZSB0byBjYWxsIHJkc190Y3BfY29ubl9zbG90c19hdmFpbGFibGUoKSBmcm9tDQo+
IHJkc19jb25uX3NodXRkb3duKCkgYmVjYXVzZSB0aGUgZmFuLW91dCBpcyBkaXNhYmxlZC4NCj4g
DQo+IEZpeGVzOiA5ZDI3YTBmYjEyMmYgKCJuZXQvcmRzOiBUcmlnZ2VyIHJkc19zZW5kX3Bpbmco
KSBtb3JlIHRoYW4gb25jZSIpDQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrNWVmYWU5MWY2MDkzMjgz
OWYwYTVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBDbG9zZXM6IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NWVm
YWU5MWY2MDkzMjgzOWYwYTVfXzshIUFDV1Y1TjlNMlJWOTloUSFKOERvY3plWUdTUFA2UXNCdndZ
UWF4akowaFZDVmM2cG9wUExrdzRETmFuclhPS0drOWlsZnFEM2RIUTB4d2dmd1plM0dhdG5wLThQ
bWlkd25XbGV6czAkIA0KPiBTaWduZWQtb2ZmLWJ5OiBGZXJuYW5kbyBGZXJuYW5kZXogTWFuY2Vy
YSA8Zm1hbmNlcmFAc3VzZS5kZT4NCg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLiAgVGhhbmsgeW91
IQ0KUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhY2hlbmRlckBrZXJuZWwub3JnPg0K
DQo+IC0tLQ0KPiB2MjogY2xhcmlmaWVkIGNvbW1pdCBtZXNzYWdlIGFuZCBhZGQgYSBjb21tZW50
IGFyb3VuZA0KPiByZHNfY29ubl9zaHV0ZG93bigpIHBhdGggDQo+IHYzOiB1c2VkIFJFQURfT05D
RSgpIGZvciBsb2NrbGVzcyByZWFkIGFuZCBhZGp1c3RlZCBjb21taXQgbWVzc2FnZQ0KPiAtLS0N
Cj4gIG5ldC9yZHMvY29ubmVjdGlvbi5jIHwgIDMgKysrDQo+ICBuZXQvcmRzL3RjcF9saXN0ZW4u
YyB8IDI4ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQv
cmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+IGluZGV4IDE4NWY3M2Iw
MTY5NC4uYTU0MmY5NGMwMjE0IDEwMDY0NA0KPiAtLS0gYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0K
PiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiBAQCAtNDU1LDYgKzQ1NSw5IEBAIHZvaWQg
cmRzX2Nvbm5fc2h1dGRvd24oc3RydWN0IHJkc19jb25uX3BhdGggKmNwKQ0KPiAgCQlyY3VfcmVh
ZF91bmxvY2soKTsNCj4gIAl9DQo+ICANCj4gKwkvKiB3ZSBkbyBub3QgaG9sZCB0aGUgc29ja2V0
IGxvY2sgaGVyZSBidXQgaXQgaXMgc2FmZSBiZWNhdXNlDQo+ICsJICogZmFuLW91dCBpcyBkaXNh
YmxlZCB3aGVuIGNhbGxpbmcgY29ubl9zbG90c19hdmFpbGFibGUoKQ0KPiArCSAqLw0KPiAgCWlm
IChjb25uLT5jX3RyYW5zLT5jb25uX3Nsb3RzX2F2YWlsYWJsZSkNCj4gIAkJY29ubi0+Y190cmFu
cy0+Y29ubl9zbG90c19hdmFpbGFibGUoY29ubiwgZmFsc2UpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0
IGEvbmV0L3Jkcy90Y3BfbGlzdGVuLmMgYi9uZXQvcmRzL3RjcF9saXN0ZW4uYw0KPiBpbmRleCA2
ZmI1YzkyOGI4ZmQuLmRjZTdhYzlkMzE5NyAxMDA2NDQNCj4gLS0tIGEvbmV0L3Jkcy90Y3BfbGlz
dGVuLmMNCj4gKysrIGIvbmV0L3Jkcy90Y3BfbGlzdGVuLmMNCj4gQEAgLTU5LDMwICs1OSwxMiBA
QCB2b2lkIHJkc190Y3Bfa2VlcGFsaXZlKHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+ICBzdGF0aWMg
aW50DQo+ICByZHNfdGNwX2dldF9wZWVyX3Nwb3J0KHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+ICB7
DQo+IC0JdW5pb24gew0KPiAtCQlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzdG9yYWdlOw0KPiAt
CQlzdHJ1Y3Qgc29ja2FkZHIgYWRkcjsNCj4gLQkJc3RydWN0IHNvY2thZGRyX2luIHNpbjsNCj4g
LQkJc3RydWN0IHNvY2thZGRyX2luNiBzaW42Ow0KPiAtCX0gc2FkZHI7DQo+IC0JaW50IHNwb3J0
Ow0KPiAtDQo+IC0JaWYgKGtlcm5lbF9nZXRwZWVybmFtZShzb2NrLCAmc2FkZHIuYWRkcikgPj0g
MCkgew0KPiAtCQlzd2l0Y2ggKHNhZGRyLmFkZHIuc2FfZmFtaWx5KSB7DQo+IC0JCWNhc2UgQUZf
SU5FVDoNCj4gLQkJCXNwb3J0ID0gbnRvaHMoc2FkZHIuc2luLnNpbl9wb3J0KTsNCj4gLQkJCWJy
ZWFrOw0KPiAtCQljYXNlIEFGX0lORVQ2Og0KPiAtCQkJc3BvcnQgPSBudG9ocyhzYWRkci5zaW42
LnNpbjZfcG9ydCk7DQo+IC0JCQlicmVhazsNCj4gLQkJZGVmYXVsdDoNCj4gLQkJCXNwb3J0ID0g
LTE7DQo+IC0JCX0NCj4gLQl9IGVsc2Ugew0KPiAtCQlzcG9ydCA9IC0xOw0KPiAtCX0NCj4gKwlz
dHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsNCj4gKw0KPiArCWlmICghc2spDQo+ICsJCXJldHVy
biAtMTsNCj4gIA0KPiAtCXJldHVybiBzcG9ydDsNCj4gKwlyZXR1cm4gbnRvaHMoUkVBRF9PTkNF
KGluZXRfc2soc2spLT5pbmV0X2Rwb3J0KSk7DQo+ICB9DQo+ICANCj4gIC8qIHJkc190Y3BfYWNj
ZXB0X29uZV9wYXRoKCk6IGlmIGFjY2VwdGluZyBvbiBjcF9pbmRleCA+IDAsIG1ha2Ugc3VyZSB0
aGUNCg0K


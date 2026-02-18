Return-Path: <linux-rdma+bounces-17002-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KALkD1IclmntaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17002-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 21:08:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F315959A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 21:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC51230221E4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6D34846A;
	Wed, 18 Feb 2026 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q4shNm/P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GH11qZX3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E5309EE9;
	Wed, 18 Feb 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445322; cv=fail; b=PHfAWf2lzRiD1wDn7WZH8GjyQTajfMm0ChYsb+QoDcnaaW30KLfMgvui4i0+DLeTi8k34x2HuYXBMLIqWkRmAE8L0sKDoA5BV5Ynp0BaSxrEfxRpTPmYKFSZyaOuBnzjeogg+eLuioEWaaYhH/K/R8uBexBAsYxvPmoQqcHwNqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445322; c=relaxed/simple;
	bh=cA0xrYgIaPQIMwCtLCtj4lgPnxyQJqOuCE/jsRa6qnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIipAWXz80EJa9/QlEiXC76i5wyvF6JpZSBHAiP5wrDCmgqWFscyuQ+vHdwG66Mq9TuZzAMW/oXzdZ1QJ2CVu2/eKnKHjwIuTSy/hGVMRlTD6TAK0iQztSj9GomSIWBHApENe6qd+ZOjKnx1Kwo0QJ9KPQx07G72ZbvwA7OKQ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q4shNm/P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GH11qZX3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IFqLF2591106;
	Wed, 18 Feb 2026 20:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cA0xrYgIaPQIMwCtLCtj4lgPnxyQJqOuCE/jsRa6qnY=; b=
	q4shNm/PrR9TZNFo5MucM86sMib5Gnc5jkeWRfu819F59d7X94c8G7/hGb464P5x
	Fwl0gpArUlbvO/b9t+1mNzc8gTwSjhKsFAClj3I1wq1G5pBMaNIwhBZfnKcIe7Eo
	AG0f/biLqakUN2Q3DNYXfT67Q4FyZhME3Dkle+RHT5X+HCWH6YcknwhoT34UPIp6
	Fs3TiTIw4H3edvKVvn8MoYfqmsQGqIc6qxwTqdsWcuxG1ISu4fIpkIKn34Yw4ysj
	CRTRJAdy7gn6dlNi1m+PNt+yxZVXOR8PMbTADkKFtOMIlKZuCVscyP/KfMmO2ITd
	RQRwJZmtNTiZhqIipSS2Lg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0ax9as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 20:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IJqIvT033223;
	Wed, 18 Feb 2026 20:08:28 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb21hmqs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 20:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tycSbqirBJqHD5ZsIhbwimFoGdWX+0oF85Ji6s6fKN6SvOx31vzk0rgUZLdu7cZ6zo41RNWpAhi45QaadCF8K9hNkjoG8iNIpbttT7ThongGECg8NVL9BL01dUVMNBXrMjjL1oM7xCSKPE70kBdlA9QSRzBOHmvuclanSpr8c+ONftNnfE8PgNwanT1Vjy/wC/ZxTSY090xcxX4SakhvYa8TXO/Kl7qj5T70Wvc+zzfoPvBkpPWeb5NE0SOWLiAKcrhTNMXIkb0Nvobt54cCZ67WuXXE6zEA7HwVSVSkzvgkcHeRn9cxYnw9UYbx+5IURkgMEwR5mKIPJ50WfjSvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA0xrYgIaPQIMwCtLCtj4lgPnxyQJqOuCE/jsRa6qnY=;
 b=yetl7jiHeS23hb+e5hgOK4DeL98kMi+YQBen//pcMb9S33BxGr3LON6vypgoRU14h0nxS8+MHV7KUcvfI2PFTkPpifFsJhUC2mlgNZrCNikr+NtyQTpQuEqERZ5tHNDF1zV0Ve/cGxRZiJa5tbE4mNoIz4ibXqjgaggg+XQnEtssSnzUmg7MAxyv3SLCBgWVIOIe36FkAvMBULCNzE6y0xkXv0DzLokDf8YIErgZE5+y0xagsx8UnXu1MbQPaVhQz+ODSKtc45BAGpgOf0SfAN6PXLrJmutXPnjC5MaW8z5wgZIctIEWw7HbVID469j/8NB9+REotZ0cfWBZagglcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA0xrYgIaPQIMwCtLCtj4lgPnxyQJqOuCE/jsRa6qnY=;
 b=GH11qZX3s8iIyvX7fOlvm7616f8mixivh2JU+I59H5Q/ePx1cKhX+PgrhteFHwXcTViwyXef4y0C1cc/4E8YhJOBaigWvIvpFuKfMmN6+nxvfHAtkcJaXLtAUYLs98LYT7aRtxnBL4DlUgAaW+fmE8+p2YHDmcY/CShItj17TXM=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SJ5PPF9A77B6E1F.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7bc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 20:08:10 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 20:08:04 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "fmancera@suse.de" <fmancera@suse.de>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com"
	<syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        Gerd Rausch
	<gerd.rausch@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net,v2] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Thread-Topic: [net,v2] net/rds: fix recursive lock in
 rds_tcp_conn_slots_available
Thread-Index: AQHcoL2woMGhpDhx5USAM/tRJYrc27WIsnEAgAAwpQA=
Date: Wed, 18 Feb 2026 20:08:04 +0000
Message-ID: <d06205dc4c9983eaf2cc79ed7e8283ee50be8eb2.camel@oracle.com>
References: <20260217223802.21659-1-fmancera@suse.de>
	 <20260218100206.88254-1-horms@kernel.org>
	 <59c133d4-9e5c-4eee-95c2-4a8877b052be@suse.de>
In-Reply-To: <59c133d4-9e5c-4eee-95c2-4a8877b052be@suse.de>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SJ5PPF9A77B6E1F:EE_
x-ms-office365-filtering-correlation-id: 3e1c8017-ab43-466a-fb55-08de6f296d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEhKK0h1WGpUSjdTdmhFNEJVNEc3OFlWNFJ1ZHU3Z1QyRUpDSEdzNHMvdVFL?=
 =?utf-8?B?enlqZmZoTG5QSlFMTVRyZE9MbUtWWUFkdUowbDNBSFhvUG8vNCtLSXBoQlpB?=
 =?utf-8?B?Y0YzSUI5aWd1Y1NXWGtsek9nRzdRZGN4RDdBQm9zRCtkTHlhQzZrY1lmM21Z?=
 =?utf-8?B?a2tKNXRKN0taQnVWT2VrODFWSUt5aC9DM3lhUE9mUnl2MnN1M29zY2lCMHF2?=
 =?utf-8?B?Zjc2ZnN2VFBURDdzbjM0cEpqN0toYkkzYlQ3QnVVNXN3c2M3YnBRSlNucVBu?=
 =?utf-8?B?SjJSQk1mdGdOQVdXc2RrdUNRUVFHUGFhcVpkV2ludmdCdjZwdFR5ZHlGdGxD?=
 =?utf-8?B?N0pjYlM3M2ZZVEp2bk9JbGN1NXRhWEVKNmtoNnN4WW9mdSt5Z1llaFZCQjBW?=
 =?utf-8?B?NEp1QzBTMDFlS3VmOFpQY2FsSk1oUXJVODNmQy9YUzJCWnhqa3NnQzc1S0NX?=
 =?utf-8?B?SmtFWUZ3dnhnV05nMnBieFMwS3dQZWUyL05BSXZXa0VaVzBzeVNJaXFuY0lK?=
 =?utf-8?B?ZllHTnU4Q3EwSC91WkQzSmUyRHN5T256VitjMmU1Vnl4OWRMRkJsb1hnR0tQ?=
 =?utf-8?B?blBmM2xTZnFNakppcy9lY0Z2S1ZCelhCMlN6dFE1M2ltaEtGMzFBS2lhRXQv?=
 =?utf-8?B?a0dybzJaR2ZxeFEreDJjNE90b3ZsVFF1bWRjSGc2cDdEK1UwTVA1aEJxZWlZ?=
 =?utf-8?B?c29EWi9TSTdjWURxb3M1SDZrcEM0QXFpWlFwQVFFN3UxSTV6OXBVQi82ZHRF?=
 =?utf-8?B?bytWWjVPbDZIQzhnNGl1QmhJUWhiazFqbmF6WWlLZHBCM0F1UXlSYyt5UUNO?=
 =?utf-8?B?VDhwRTJnWTBZc05YUVYwWUNRMXZCUFplNlpwelkvVkU1dHRBN24yczRvVUxr?=
 =?utf-8?B?Z0ZUL1R2NGVrYmwvNTNaeGl3L1UwdVhPSHc3RVhKU0hDUy8rQThna0hPRGdH?=
 =?utf-8?B?NFdxajJnR0lWRWR6bzZBM2JuTjlHeDI3RVkzSCtRd1FHK3pXdzA4UFFRajZF?=
 =?utf-8?B?ZDNGVTMybkUvbzdndGk5emp0NllPY1dCVE9WTzc1TndWRVk4UXVqQzVLT2hK?=
 =?utf-8?B?OVB4c25HL0NrK0UrSFlOM2VScXVKclY2WDRGT2xlb1AwMXB1UHFEN2hYd1Fs?=
 =?utf-8?B?cVdOMlhpOHdyMFNuM0VxY05VSXRNalp0cUFKRGc2Z0ZZV25WQlU3eXRLT0Z6?=
 =?utf-8?B?ajRNZkhhUmZLcE5KQytJRVlWUTEyRU16TUViNk5YWFhMampoTkxnY0RLUjBN?=
 =?utf-8?B?QUZtb0lRZWJWRno4VzVTOTUyWUFhRUx2WUVac0o5YXEwQyt3UGk2VFNvdXFC?=
 =?utf-8?B?NitJYVRXOTFNSUZXQmJGdnN2Rk8yalhVL0NybTl6U1NHYnJmL3FwakhQQ3Zp?=
 =?utf-8?B?ZHdlNVhoclFNNlA4dkxMakMrU2FKUzIwVENTZDZ6UUUrdFkrRFpsak5DNEJK?=
 =?utf-8?B?RXFaRmxSZEJOc2JmUm1LTkc4dEVxRDBtWmN3eVAvazR6aXZuY1ZyV0dWeFMy?=
 =?utf-8?B?SEJyRTgyc0NtZ2RIZE5zM05oVFp4REhkWUs3ckZCT3BmY3dtOGZuQk1lVDdC?=
 =?utf-8?B?T3pLU1FuWS9vZktqeStuQURyTmJCMkNYSDJXdVp5L2dvck9TYS9xUW1kQjMx?=
 =?utf-8?B?RFFQUGpHdVlFOTlxYms2MWpsamxuUVFSSXY2THFJYWh1VVRSRHZ5RHI5SnJo?=
 =?utf-8?B?NGNDSGZ3UHU0TkhYdndoN3JjY1NQVDV1djBJVzlKbmhmaWhWc0g1WkpjM2pH?=
 =?utf-8?B?NGVXSjZGdG1FKzlCRXovYTcxcUlyT2F1bmhIRkZVZWFLWEI3aVk5SUZTTUZC?=
 =?utf-8?B?d29xazhDL3k0eVovQkFpb1E0azRYVEFGZGlqTXhsN2N0eDliajFLZjV5NWpO?=
 =?utf-8?B?bmU2RFc0NkkwRDhMOFVzMnlxcHRPak8xUXVnZGJjTjJsZFcrTm96dkl1WEhm?=
 =?utf-8?B?Y0lITnM1aHBmeFJwanU0a2kxZ1JUNXp3S0dhK1N0ZXU2bndTZ0x0S0FKMkVo?=
 =?utf-8?B?NGpVcEw4TlVxOHNCTTh6eUxlSUgyd013SDZGRzhscjJUaUkwWFpiV3lLZVBI?=
 =?utf-8?B?TW5UNWl2SnE4RVFpWVpwNHFIeFJaSTNQbkVJNVFRdkQ5eXQ2Y1B2QnVmUHpa?=
 =?utf-8?Q?4McgJcLouevNKE/vEGNGNBkVw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWloVFRwUTh6K2d2QUZVSm91TnNleGhXeEhrWElOV2lIM2duRVR1K2xUTWU1?=
 =?utf-8?B?Sm5PYlpQOGYxUmUzcWJFaDVaQmlyWmRBckM4NTdaY3JDMk0xZkJ0RDYwNGhU?=
 =?utf-8?B?K2NMQTMwUnRIWFBHZnowZVNMSWxSMGtpRFljVGpYZng3ME13MFo4VXl0aklZ?=
 =?utf-8?B?dmpMREx4bWdxY0d1SWZ0ejRNeVc2SGdhMTlvRENBcksycVBrc0hOaVhWODJI?=
 =?utf-8?B?K0RCcFhuVE4zcG5lSFRPQTVKa0N5UjdVLzF6dGREM2pwbjhkZUNWSnQybDNK?=
 =?utf-8?B?aUtTcXVBR2d2RExIQVVwczBsZk13UDZYYjJjWVlCS3BvcUUrY1ZOY0srdU1z?=
 =?utf-8?B?djcwS0cwQTBTdFdqWU5Ka2hLdlEvQzJJYldQM0xqMU85cFNwVVh4UWpvdDNW?=
 =?utf-8?B?VWNhSXhPRzgwRks3ZHVnU1RTWWZaaCtxQlJoRDFuYVJnV3E1MnB6QXo5K0dT?=
 =?utf-8?B?dWtnMG9xOEkzU1RRL09PQ1FrZHRtK0VrbFFCdFVPS2JwakhkVUxEZkVQUmFZ?=
 =?utf-8?B?Q3l4VEsrVjlvSHVoTVk3S0hGa2toRFNBMkl5U0tSL3VJUXd5RmQzUk9rM3kz?=
 =?utf-8?B?YnpCRU5obzl5UTc5dTdOQzZhL01ITDN6dmZpNHN3eDBhUTFVa1p6ZExyZ0Zl?=
 =?utf-8?B?NXlkdm9aV0JKb0w4UnJSZHZERk1adSsxdEZRL2xiNUxOYXU0ZW1uUGR6Zkhn?=
 =?utf-8?B?ZWNNcmFCdjRncmN2ZFI4QktMVFNVdlBmVitjSmMxVis1WDVXTWtxSG1FN0Ro?=
 =?utf-8?B?UXI3Vll4cE91RVRud2VUcnRWMFpnWjI2b1Y1em1UTFo4RVM2MFFCd0J6R29O?=
 =?utf-8?B?amh4Q3Bvd3Bla2tuKzBwRW1KTTF2YysxSTV0SitvWDFzSktURmUvTkRQVklq?=
 =?utf-8?B?MG11ait6ZG9mUzE4dCsrSUtqM0dOY2trRnpRRTNwZzBLblJTMndqa1lFaS9I?=
 =?utf-8?B?TlgyNzB2U0szZmFXSUZmTDV4MGZ5Z2xxVzYwTUZzQWNVZ1dBazZ1NWdjbU1i?=
 =?utf-8?B?d0M2bS9rUkgvRGk2NWN3R3lKaGhaYWVVeW9scEZqYk45dXZtQS9Sc1VXZW5F?=
 =?utf-8?B?QzV1SUlIY05sV3V4RU01QUFBWXZaYXcybEE3TGY3SHdBUEhEalNrN0dpNlM0?=
 =?utf-8?B?VG5CMXM5NTh1L0x5b1V1OVRqY2FkNkNFQ1lQT0phU1dlMzdOaVdPcnZ3Z2s0?=
 =?utf-8?B?SXZPaktmbXc5NjZYRW95aUpIcWsvRWNoTWdSK01zYTA2OFd1N3BOOVNJTGJw?=
 =?utf-8?B?eWRMZFlyeG9PR2xpRnRSUnY5ZzVSSnVTZHBlR3cyTWYvWGNzb2tjZzltcFBD?=
 =?utf-8?B?NGxiWFh5WFJWdFQ5YTdTYzB4Y0ptRDYwQk5uMjRJSm1TZDJpUEdvK0d3V0ZT?=
 =?utf-8?B?djgxdjBvVnJ1bHU1eS96d3M2aDNKb1RUWEVHbWorbjBsa3Fpa2pxdHdicy82?=
 =?utf-8?B?amM4cEhOMTl1eTQ1M2VsYmhxcGtPNXhHdkphOXgreU4xVE5BVjZ6RUFpcCtI?=
 =?utf-8?B?UmNrcDFaeGpPdjU3aEVKdHU0WmFGQ2dmM3BweTVxTjhmUmhVaTRQUDFsVWhV?=
 =?utf-8?B?NWw2bW11NXk5dkZEaHk1M2hnZDJpQmMzT3NnMHlOUW1HK1RCcWFXb0dJazlD?=
 =?utf-8?B?OCtZL1ZwVjlzelE1a2N2NWpaTnlCWEhWN3BlODBpQXZFdFBweXdVZzFHbTA4?=
 =?utf-8?B?dlpOQUx5MWhVVkJvNjhsOXFnTU5WbnVaNmZlT3ppT0xWR3RqWjNLZ2lFMzBY?=
 =?utf-8?B?M2NQbkp3S3VTVk1yK1NHNEtxRzViZTdRM3FtNXFNRU1MWnQ2UFdZVHgwS3Nh?=
 =?utf-8?B?dUZhWDBhRTdyQko5b0lqa3NjSEJDYlF6YXBWVzZBdC9rYWl0K0I0ZEI4ODhw?=
 =?utf-8?B?SFRmTlBFYXBrckl2MFdMM1dhcWUrcnRjSVRES2RMV2NJT1BYMThXZmRoaUtx?=
 =?utf-8?B?L29sMmRvWFY0RGkrcVkyTnlKUU5SZGszUXUzSFV2M1VsTzB6Y0RSSEgvUG1u?=
 =?utf-8?B?dGxjVnUxQVBKK2tiYmhodU8rTS9DYnVMbHBVNHFURWYvcmQyMkUrbFpVam9z?=
 =?utf-8?B?RDgydWZ2Rk10K1JIeWQyZ05LQ3RJMnR1YThVdVZuMGJHcjJubHRNaWtkekxw?=
 =?utf-8?B?QWdyNGlMSHZaZUxFNmZ0U2oyUGNkVXlKOHhwdStHaDk3MmNXZkRRdWEra0hR?=
 =?utf-8?B?dERTb28zU3RldWYvazg0TTNvRFB1cEF1TFluOC9GRWkyNTlnaTF5SDZCQnRj?=
 =?utf-8?B?SlhQMnNxajl5aldtR09MWkVLaVVuSnpvSEdJbmFhMmtPY1BzVFc2OWJKWWNp?=
 =?utf-8?B?NGwrM3lKQnQvVXdSR0h1L0c1bThqd0ZNTi8rMDErSlQwSG92U29RSUpSdkpk?=
 =?utf-8?Q?9HWJqDz5uDj7nKGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <381934E260E20246A00B947065F72272@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qG5Ez/MK9bQ1jX0vwJhwY9U+vkYvsXxFbgU03QqBhRSxQLrwf7ynerP4swqRp864mWbx77ar0LT8/HJ/4FLRIfUiY2+nwuGay4hoJTr10ZLuNlsLZ6vDFqs22UKyY3FwC6QusBrqv22IQdnti2+GoqIjENlT8rmAezMT2a6zJE6UPeZubiqpSGDTNyoAABb59g9Bu/rRGNTclh5QvYbfZQWFz+KxyBNwUSHQxv43qY4An5Po6hdPu3X5haF/gxaMKNKyrNj4ycBkq6UIoQDNyqqSruywh23SimUSOL8x2qR7e4fDsZiB1Q5Eh8mou0fV8ryEZ/7wmd8gl5I1WamZ4JyJGcu7XfUBrM6a/uaFJqmoeSWbXt1OsquZepCXTzwymSH3GSFuXLVozazFH/tZ1aEmlVBUgIom2Z3eLbVrSmNCzDNVN4qFOvJ2zK3S2vikgSHhxsaQFs6CDPlPcGAE6TYxfIjMvdb+KKRGdsgFUnqm2Q8KrnqdSGa6ozYD0Zb26QCuFYEBNeKXhdc9ts/O4T7iYu8LXITgLJaY3R2bz2ykGXTl130oOOdKPuIY4Xks4fijYlkpvVMxmtA9TaMQlQ4nh3tvLIdo1ME9yyLbthE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c8017-ab43-466a-fb55-08de6f296d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 20:08:04.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HP5pJCImVFAXGs2OyfbP6ioFqQvOIDwKBKjG4753OUfMOBY0zrlhX5RNnZhVCJQRGFEYxE7sdT5yeVFnt8oeEagsz5DwL8sh/+Hgw+kAlow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF9A77B6E1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180172
X-Proofpoint-GUID: WoYma8MPV4vAk5sz4cEpDzwrMvD8HEF_
X-Proofpoint-ORIG-GUID: WoYma8MPV4vAk5sz4cEpDzwrMvD8HEF_
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=69961c3d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=9R54UkLUAAAA:8 a=edf1wS77AAAA:8 a=nHUEIjGSX6Q-IZq5SmEA:9 a=QEXdDO2ut3YA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3MiBTYWx0ZWRfX4soNmsvOW8Qt
 8+3B+DbX4k8Hu62kbRBu8cDCIvJa7iNw3eDAjbO0p/sUSdUUqmfuKnuj26Jc8IYQ1GZOUiCr20w
 16d9WPMyom1VqARNkOz+AcTtaS/1eFGyiNrqvjVj8S6QHYau45VGKdiMLWFFG37bpHh7ilRjBPw
 uYGo1KwZulfg3btvwyFgu1FrW6E+/PqvTfODIM6jb0eCdD4RSMXGPE/FUlTWDvtBDYg1AY7JH1h
 10edT7khDtdeT2nX8Gjt+nDFdtFvt2khQshOjiQh5Nzb/Ejud/p/Nlnz5LwL3BN4622kuM+KC7s
 JTWo7eiWe631yLfr3nU877/1bm7nPIljr7erBXYyWRin/dQeLOtE4ydXTeCt6spiKZFYQhBTgCe
 LAPHTp6g9Eifn3Bo1nlZyIsLMCbIfl0taum+X3VQaTvO+0wHc+KizUmUNb1eAPxXi9RAzrdY+Ce
 UnADC+MDHb3NgXWmDiQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17002-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,urldefense.com:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 917F315959A
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDE4OjEzICswMTAwLCBGZXJuYW5kbyBGZXJuYW5kZXogTWFu
Y2VyYSB3cm90ZToNCj4gT24gMi8xOC8yNiAxMTowMiBBTSwgU2ltb24gSG9ybWFuIHdyb3RlOg0K
PiA+IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVt
YW4gc2VuZGluZyB0aGlzDQo+ID4gZW1haWwgc2F5cyAiSSdtIHBhc3NpbmcgdGhpcyBvbiwgbm90
IGJlY3Vhc2Ugb2YgdGhlIGZpcnN0IGNvbWVudA0KPiA+IHJlZ2FyZGluZyBmYW4tb3V0LCB3aGlj
aCBJIHRoaW5rIHNlZW1zIHJlYXNvbmFibGUgaW4gaXQncyBjdXJyZW50DQo+ID4gZm9ybS4gQnV0
IGJlY2F1c2Ugb2YgdGhlIHNlY29uZCBjb21tZW50LCBhdCB0aGUgZW5kLCByZWdhcmRpbmcgdGhl
DQo+ID4gcmVjZWl2ZSBwYXRoLiBJJ20gbm90IHN1cmUgYWJvdXQgdGhhdCBvbmUgZWl0aGVyIHdh
eSwgYnV0IGl0IHNlZW1zDQo+ID4gd29ydGggcGFzc2luZyBvbiB0byB5b3UuIg0KPiA+IA0KPiA+
IEZvciBsb2NhbCByZXByb2R1Y3Rpb24gc3RlcHMgc2VlIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9haS1sb2NhbC5odG1sX187ISFB
Q1dWNU45TTJSVjk5aFEhT0Z4aWpYWHZTRTRveVZZbmhyX3p5cDYtcUFmZ3NTS2lNV1pUbkdkX0JH
dDEwNGZvWmhzVDc2dlZGSEhpTTNJQ0FfTTZtRWlzOHV1bEEtYUI3TE4zZ0ZRJCANCj4gPiAtLS0N
Cj4gPiBuZXQvcmRzOiBmaXggcmVjdXJzaXZlIGxvY2sgaW4gcmRzX3RjcF9jb25uX3Nsb3RzX2F2
YWlsYWJsZQ0KPiA+IA0KPiA+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyBhIHJlY3Vyc2l2ZSBsb2Nr
IHdhcm5pbmcgcmVwb3J0ZWQgYnkgc3l6Ym90IGluDQo+ID4gcmRzX3RjcF9nZXRfcGVlcl9zcG9y
dCgpIGJ5IHJlcGxhY2luZyBrZXJuZWxfZ2V0cGVlcm5hbWUoKSBjYWxscyB3aXRoDQo+ID4gZGly
ZWN0IHNvY2tldCBzdHJ1Y3QgYWNjZXNzIHRvIHJlYWQgdGhlIHBlZXIgcG9ydCBudW1iZXIuDQo+
ID4gDQo+ID4gQ2xvc2VzOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTVlZmFlOTFmNjA5MzI4MzlmMGE1X187ISFBQ1dW
NU45TTJSVjk5aFEhT0Z4aWpYWHZTRTRveVZZbmhyX3p5cDYtcUFmZ3NTS2lNV1pUbkdkX0JHdDEw
NGZvWmhzVDc2dlZGSEhpTTNJQ0FfTTZtRWlzOHV1bEEtYUJfTXkyZ2pZJCANCj4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlvbi5j
DQo+ID4gPiBpbmRleCAxODVmNzNiMDE2OTQuLmE1NDJmOTRjMDIxNCAxMDA2NDQNCj4gPiA+IC0t
LSBhL25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gPiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24u
Yw0KPiA+ID4gQEAgLTQ1NSw2ICs0NTUsOSBAQCB2b2lkIHJkc19jb25uX3NodXRkb3duKHN0cnVj
dCByZHNfY29ubl9wYXRoICpjcCkNCj4gPiA+ICAgCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiA+
ICAgCX0NCj4gPiA+IA0KPiA+ID4gKwkvKiB3ZSBkbyBub3QgaG9sZCB0aGUgc29ja2V0IGxvY2sg
aGVyZSBidXQgaXQgaXMgc2FmZSBiZWNhdXNlDQo+ID4gPiArCSAqIGZhbi1vdXQgaXMgZGlzYWJs
ZWQgd2hlbiBjYWxsaW5nIGNvbm5fc2xvdHNfYXZhaWxhYmxlKCkNCj4gPiA+ICsJICovDQo+ID4g
DQo+ID4gSXMgdGhpcyBjb21tZW50IHBvdGVudGlhbGx5IG1pc2xlYWRpbmcgYWJvdXQgdGhlIHNh
ZmV0eSByZWFzb25pbmc/DQo+ID4gDQo+ID4gVGhlIGNvbW1lbnQgc2F5cyAid2UgZG8gbm90IGhv
bGQgdGhlIHNvY2tldCBsb2NrIGhlcmUgYnV0IGl0IGlzIHNhZmUNCj4gPiBiZWNhdXNlIGZhbi1v
dXQgaXMgZGlzYWJsZWQuIiBUaGlzIGlzIGZhY3R1YWxseSBhY2N1cmF0ZSAtIHdpdGggZmFuX291
dA0KPiA+IHNldCB0byBmYWxzZSwgdGhlIGNvZGUgcGF0aCB0aGF0IHJlYWRzIGZyb20gdGhlIHNv
Y2tldCAodmlhDQo+ID4gcmRzX3RjcF9nZXRfcGVlcl9zcG9ydCkgaXMgbmV2ZXIgcmVhY2hlZC4N
Cj4gPiANCj4gPiBIb3dldmVyLCB0aGUgcGhyYXNpbmcgY291bGQgY29uZnVzZSByZWFkZXJzIGFi
b3V0IHdoYXQgaGFwcGVucyBpZiBmYW5fb3V0DQo+ID4gd2VyZSB0cnVlIGJ1dCB0aGUgbG9jayB3
ZXJlbid0IGhlbGQuIEluIHRoYXQgc2NlbmFyaW8sIHRoZSBuZXcgY29kZQ0KPiA+IChyZWFkaW5n
IGluZXRfZHBvcnQgZGlyZWN0bHkpIHdvdWxkIHN0aWxsIGJlIHNhZmUgYmVjYXVzZSBpbmV0X2Rw
b3J0IGlzIGFuDQo+ID4gYXRvbWljLXdpZHRoIHJlYWQgb2YgYSBzdGFibGUgZmllbGQuDQo+ID4g
DQo+ID4gVGhlIGNvbW1lbnQgY29uZmxhdGVzIHR3byBpbmRlcGVuZGVudCBzYWZldHkgcHJvcGVy
dGllczogKDEpIHRoZSBzb2NrZXQNCj4gPiBpc24ndCBhY2Nlc3NlZCBhdCBhbGwgd2hlbiBmYW5f
b3V0IGlzIGZhbHNlLCBhbmQgKDIpIGlmIGl0IHdlcmUgYWNjZXNzZWQsDQo+ID4gdGhlIG5ldyBp
bXBsZW1lbnRhdGlvbiB3b3VsZCBzdGlsbCBiZSBzYWZlIHdpdGhvdXQgdGhlIGxvY2suDQo+ID4g
DQo+ID4gQ291bGQgdGhlIGNvbW1lbnQgbW9yZSBwcmVjaXNlbHkgZXhwbGFpbiB0aGUgc2FmZXR5
IHJlYXNvbmluZz8NCj4gPiANCj4gPiA+ICAgCWlmIChjb25uLT5jX3RyYW5zLT5jb25uX3Nsb3Rz
X2F2YWlsYWJsZSkNCj4gPiA+ICAgCQljb25uLT5jX3RyYW5zLT5jb25uX3Nsb3RzX2F2YWlsYWJs
ZShjb25uLCBmYWxzZSk7DQo+ID4gPiAgIH0NCj4gPiANCj4gPiBbIC4uLiBdDQo+ID4gDQo+ID4g
PiBAQCAtNTksMzAgKzU5LDEyIEBAIHZvaWQgcmRzX3RjcF9rZWVwYWxpdmUoc3RydWN0IHNvY2tl
dCAqc29jaykNCj4gPiA+ICAgc3RhdGljIGludA0KPiA+ID4gICByZHNfdGNwX2dldF9wZWVyX3Nw
b3J0KHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+ID4gPiAgIHsNCj4gPiA+IC0JdW5pb24gew0KPiA+
ID4gLQkJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ugc3RvcmFnZTsNCj4gPiA+IC0JCXN0cnVjdCBz
b2NrYWRkciBhZGRyOw0KPiA+ID4gLQkJc3RydWN0IHNvY2thZGRyX2luIHNpbjsNCj4gPiA+IC0J
CXN0cnVjdCBzb2NrYWRkcl9pbjYgc2luNjsNCj4gPiA+IC0JfSBzYWRkcjsNCj4gPiA+IC0JaW50
IHNwb3J0Ow0KPiA+ID4gLQ0KPiA+ID4gLQlpZiAoa2VybmVsX2dldHBlZXJuYW1lKHNvY2ssICZz
YWRkci5hZGRyKSA+PSAwKSB7DQo+ID4gPiAtCQlzd2l0Y2ggKHNhZGRyLmFkZHIuc2FfZmFtaWx5
KSB7DQo+ID4gPiAtCQljYXNlIEFGX0lORVQ6DQo+ID4gPiAtCQkJc3BvcnQgPSBudG9ocyhzYWRk
ci5zaW4uc2luX3BvcnQpOw0KPiA+ID4gLQkJCWJyZWFrOw0KPiA+ID4gLQkJY2FzZSBBRl9JTkVU
NjoNCj4gPiA+IC0JCQlzcG9ydCA9IG50b2hzKHNhZGRyLnNpbjYuc2luNl9wb3J0KTsNCj4gPiA+
IC0JCQlicmVhazsNCj4gPiA+IC0JCWRlZmF1bHQ6DQo+ID4gPiAtCQkJc3BvcnQgPSAtMTsNCj4g
PiA+IC0JCX0NCj4gPiA+IC0JfSBlbHNlIHsNCj4gPiA+IC0JCXNwb3J0ID0gLTE7DQo+ID4gPiAt
CX0NCj4gPiA+ICsJc3RydWN0IHNvY2sgKnNrID0gc29jay0+c2s7DQo+ID4gPiArDQo+ID4gPiAr
CWlmICghc2spDQo+ID4gPiArCQlyZXR1cm4gLTE7DQo+ID4gPiANCj4gPiA+IC0JcmV0dXJuIHNw
b3J0Ow0KPiA+ID4gKwlyZXR1cm4gbnRvaHMoaW5ldF9zayhzayktPmluZXRfZHBvcnQpOw0KPiA+
ID4gICB9DQo+ID4gDQo+ID4gVGhlIGNvbW1pdCBtZXNzYWdlIHN0YXRlcyAiRm9yIHJkc190Y3Bf
Y29ubl9zbG90c19hdmFpbGFibGUoKSB0aGUgbG9jayBpcw0KPiA+IGFscmVhZHkgaGVsZCBiZWNh
dXNlIHdlIGFyZSBpbiB0aGUgcmVjZWl2aW5nIHBhdGguIiBJcyB0aGlzIGNsYWltIGFjY3VyYXRl
DQo+ID4gYWNyb3NzIGFsbCByZWNlaXZlIHBhdGhzPw0KPiA+IA0KPiA+IExvb2tpbmcgYXQgdGhl
IHR3byByZWNlaXZlIHN1Yi1wYXRoczoNCj4gPiANCj4gPiAxLiBJbiB0aGUgYmFja2xvZyBwcm9j
ZXNzaW5nIHBhdGggKHNob3duIGluIHRoZSBzeXpib3Qgc3RhY2sgdHJhY2UpLCB0aGUNCj4gPiBz
b2NrZXQgSVMgb3duZWQgYmVjYXVzZSBfX3JlbGVhc2Vfc29jaygpIHJ1bnMgd2hpbGUgdGhlIGxv
Y2tfc29jaw0KPiA+IG93bmVyc2hpcCBiaXQgaXMgc3RpbGwgc2V0Og0KPiA+IA0KPiA+IHRjcF9z
b2NrX3NldF9jb3JrKCkgLT4gbG9ja19zb2NrKCkgLT4gcmVsZWFzZV9zb2NrKCkgLT4gX19yZWxl
YXNlX3NvY2soKQ0KPiA+ICAgIC0+IHNrX2JhY2tsb2dfcmN2KCkgLT4gdGNwX3Y2X2RvX3Jjdigp
IC0+IHRjcF9yY3ZfZXN0YWJsaXNoZWQoKQ0KPiA+ICAgIC0+IHRjcF9kYXRhX3JlYWR5KCkgLT4g
c2stPnNrX2RhdGFfcmVhZHkoKSAtPiByZHNfdGNwX2RhdGFfcmVhZHkoKQ0KPiA+ICAgIC0+IHJk
c190Y3BfcmVhZF9zb2NrKCkNCj4gPiANCj4gPiAyLiBIb3dldmVyLCByZHNfdGNwX2RhdGFfcmVh
ZHkoKSBjYW4gYWxzbyBiZSBjYWxsZWQgZGlyZWN0bHkgZnJvbSB0aGUNCj4gPiBub3JtYWwgc29m
dGlycSByZWNlaXZlIHBhdGggdmlhIHRjcF9kYXRhX3JlYWR5KCkgLT4gc2stPnNrX2RhdGFfcmVh
ZHkoKSwNCj4gPiB3aGVyZSB0aGUgc29ja2V0IGxvY2sgaXMgTk9UIGhlbGQuIEluIHRoaXMgcGF0
aCwgcmRzX3RjcF9yZWFkX3NvY2soKQ0KPiA+IGNhbGxzIHRjcF9yZWFkX3NvY2soKSB3aXRob3V0
IGxvY2tfc29jay4NCj4gPiANCj4gPiBUaGUgZml4IGlzIHN0aWxsIGNvcnJlY3QgaW4gYm90aCBj
YXNlcyBiZWNhdXNlIGluZXRfZHBvcnQgaXMgYSBzdGFibGUNCj4gPiBhdG9taWMtd2lkdGggZmll
bGQsIGJ1dCB0aGUgY2xhaW0gInRoZSBsb2NrIGlzIGFscmVhZHkgaGVsZCIgaXMgbm90DQo+ID4g
dW5pdmVyc2FsbHkgdHJ1ZSBmb3IgYWxsIHJlY2VpdmluZyBwYXRocy4NCj4gPiANCj4gPiBTaG91
bGQgdGhlIGNvbW1pdCBtZXNzYWdlIGJlIG1vcmUgcHJlY2lzZSBhYm91dCB3aGVuIHRoZSBsb2Nr
IGlzIGhlbGQ/DQo+ID4gDQo+IA0KPiBXaGlsZSBJIHRoaW5rIHRoYXQgaXMgcmlnaHQsIHRoZSBy
ZWxldmFudCBwYXJ0IGlzIHRoZSBhdG9taWNpdHkuIFRoZSANCj4gb3BlcmF0aW9uIGlzIHNhZmUg
YnV0IGl0IHJlcXVpcmVzIGEgUkVBRF9PTkNFKCkgYW5ub3RhdGlvbiBwcm9iYWJseS4NCj4gDQoN
ClRoYXQgbWFrZXMgc2Vuc2UuICBDYW4geW91IHNlbmQgYSB2MyB3aXRoIHRoZSBSRUFEX09OQ0Ug
YXJvdW5kICJpbmV0X3NrKHNrKS0+aW5ldF9kcG9ydCIgYW5kIHVwZGF0ZSB0aGUgY29tbWl0IG1l
c3NhZ2U/DQpUaGFuayB5b3UuDQoNCkFsbGlzb24NCg0K


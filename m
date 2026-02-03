Return-Path: <linux-rdma+bounces-16406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMzRIzSbgWl/HAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 07:52:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DDD5791
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 07:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E2A93008628
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669537F74F;
	Tue,  3 Feb 2026 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EEmyoMWF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iWQ7vWOp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9B37F11B;
	Tue,  3 Feb 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100903; cv=fail; b=fwLEOqyS5cQ94Uae2iMKqLd6+EbjVOTRtlP0N6EExWZeKs90YfNdKBDi/09b/m1Du8at7DCxGKmPTfqS6uAKwY2NDQBuk/YERSulmpLJLlsxLBzhTW0mRc9UEdMz6MsqvHtOUD0NWItfNFbMYLVWJfVBrwhWPV3s2NV1PWIWJlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100903; c=relaxed/simple;
	bh=zkuycYIx1Pt6onHARC3C4JGAo9342Zn3YO8tXVH2F1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOXN2VOZ3QkMGnsjDtrJ97YSKuXcN/t3TvXsLs7F2XVvsXKUdpbhpBITZKwPntVkx8XmKhTEShZhUWMUF/qCpE1TEHfHgdapeZ5yIm4V46rQcKXodoJuA5V9lYMC9xSSvWSStfzbhOv45nOmP7a5HAbUFs08GXkHqxaFOTr74vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EEmyoMWF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iWQ7vWOp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612IsN2j1429829;
	Tue, 3 Feb 2026 06:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zkuycYIx1Pt6onHARC3C4JGAo9342Zn3YO8tXVH2F1o=; b=
	EEmyoMWFHjk8XGXrcKrAgSdeQVtFscrEpj/ckWIldOOvD3sy8oSap5SYaVZbCSgM
	Y9gCR4AWnnXMMxPRezVi9YF4WeTSxZ1qApAOxjYWvaCudH4r+BkTx7gYcLLGv3QC
	E6qXBAzqHqt/Fj6OHaFZMvssNdS7McYHnA5u0vx+Jj2TEDxIlWOY7FAQiRNzrtP7
	T+9wlOIy5M/+wCpyRHH/8ZnhQp1D4YtqeSr/mSxCy0CYOAuo/fFhmo2eZo/tF6HS
	1GPpZJkFrlgbcwlZO7abpOm/VrWiGS3wYTzf0NK07mQnKlNuROezkA8kGLUZqnGx
	9bkOJxGuEunRDPELZkH2aQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au63h4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 06:41:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6134oBan025817;
	Tue, 3 Feb 2026 06:41:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c25781wc3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 06:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIbsf1+in7vFMvZk6a0eAaLVyQ+lTPQ6mKfIeKaTncTW4EgVswW2OkVS/X3OiCGZINrlcp/Hr7GNtUSldTBNojuwPTydY8CBHgTejGVr+8MiDsXA3wnkfPGBf981jIhOiYDIUkTY5P34qlm8dbE3VDdsf5bhROaGDb5nItZJW7xdK2SxOFl13NoMo4gRqeDtBula5gIWpHNKY/lOkBvv+9MdRR3F8IdzrwsXc+dKYV0G32sISTOGsGnJTjhESuC4eT0dLnbwYJXNDuoOspb9FuwZpu7QRQTR8SGiz71n3UeqLIXJ83uxnbtQddvlwiCNbkNCk7ilinkls1lSOgkXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkuycYIx1Pt6onHARC3C4JGAo9342Zn3YO8tXVH2F1o=;
 b=sQoCuK1VSbtIuYKaiWK5RYIchkZmmTPNEjGttElCD6v3x7JqTJnH1lzf6BTrAyTGn80OM7CQe2w+KZvW3VjzCyvDK+vSEU0KtyT4iRnn4qobeUbqGLmNWXb5ab9TWTUnpqzMx439b/Pgf9MDDpamkCwlTN+sVAqbHjvgbuSkUfrkOgMk2uL8kzaAmn8uqyoyQ776hYpbPomDw4i9QWlh/J0rX6hc3xtdj9HjrfjSIbFIghrmESQVTzDt7Um+lcF9xhpSdhO+dYyAJuz/qkS6x6eTwjj3IDh+aCPaIweN7oHMSaHnSTGMH14SBqDXesp/Xn9FqI0AUJTZ/JyNZxIHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkuycYIx1Pt6onHARC3C4JGAo9342Zn3YO8tXVH2F1o=;
 b=iWQ7vWOpOimw80mWHhJfcY90JS3T1hPAYm42Jvf6gFT+ljla2wk0AmCVli0qRMrhfWjkUSrPXgFsOLRHgVED6ysNh0pBumYKNka/XTHahY8MgcMQuIXBQB7fI4vNAC1X0X2TCMIQ79f3njggPjKDmO5QOE0T4eDL/RQuCa1QIJI=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CH5PR10MB997741.namprd10.prod.outlook.com (2603:10b6:610:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:41:28 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9564.014; Tue, 3 Feb 2026
 06:41:28 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 8/8] net/rds: Trigger rds_send_ping() more
 than once
Thread-Topic: [PATCH net-next v4 8/8] net/rds: Trigger rds_send_ping() more
 than once
Thread-Index: AQHcklB33c8X+0iQskqAtPQRsqdl+LVwO6oAgABP7oA=
Date: Tue, 3 Feb 2026 06:41:27 +0000
Message-ID: <2ccba6fbafcb6dfc914c3b1458e964d62abb4ac2.camel@oracle.com>
References: <20260131012507.814119-1-achender@kernel.org>
	 <20260131012507.814119-9-achender@kernel.org>
	 <20260202175518.3b207c5e@kernel.org>
In-Reply-To: <20260202175518.3b207c5e@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CH5PR10MB997741:EE_
x-ms-office365-filtering-correlation-id: 46e2dd65-9d3b-419a-b540-08de62ef422c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzgwTnYzcjY4U1JqSXV0NmxDTkdUcWZOampCYVhWNlFyNVNGYzdqck9DZFpD?=
 =?utf-8?B?b21pdHFydlNpNm1iNDV4bXlzbEdqUDRKQ0tkMXNVUDdmcThXY3piNndCcTlR?=
 =?utf-8?B?WEJBZ1hxd21oUTFidjBlVXNjY09LUkM2RkdTaEM0OGMxdnUrS2duTURzUExa?=
 =?utf-8?B?N0ZIeDVIR0s1Vk44azI2WUFESzljKy8rT2U1YS96U2p1aThiSUkzVC9OUzFC?=
 =?utf-8?B?UGZHRmZOcGhGcERyS1BObG1wN1JaSVpXK1IrMFB0cVR1Ky9VLy82MGJ2L0Fy?=
 =?utf-8?B?Q3IwMHZjdCsyT1VLRXdDektMZGVCK0tzRTZxSzJocDVKQ3BDa2lIaEFZR2JR?=
 =?utf-8?B?OGlKV3Z1bzZreVRxdlR2aDRwQnVZaW1qQ3FiM1cvc29PemZYb2lJQ3UzOWdy?=
 =?utf-8?B?UUVjTVhtU2RBaEZXOEN3TjlqUXNUTFUrSjdLWDZqUkVmUE5OZk1wWnp5WEo5?=
 =?utf-8?B?WmJ1UWJzOEo3a2Z1NStnSE93NEdMQjIrbWg4UkpONXpZNGVhbnBqWmFRcDNh?=
 =?utf-8?B?N2VraHI3MkNPci9VTWxud3prVW1ZWWZ2QWV3M0hkb09SRlZxVllRUzEzakJS?=
 =?utf-8?B?RDRpRW44U2FNSGMxZEtmQ2lkeGN5MHZ4cHNTaEhZRXk5eW5rQ1hNdmtMK1BU?=
 =?utf-8?B?QVE5T0IvMmxZdnFEUVlhREdLZG0xN3pHR1NjeWxHZTVna2VzQ21oL2RzZTRQ?=
 =?utf-8?B?RmlSQnFVZUQxK0pyK2lyVk00a1owSk1uUHY3cTlCVkl3TmMyekRraVdFNmlS?=
 =?utf-8?B?bDB5djFuOVBnL1BicFkwTkwxZHJxZERNeXhhak9waFhlWDE3QkZnekduTXpK?=
 =?utf-8?B?cU9uY0ZLd0JXbzZKaVFiRmRVbUhpOWxpa21ZSSs2VUZkV054MElIK0V1NHli?=
 =?utf-8?B?cVFLT0FDRi9tZCtkVnBLRlhOMXFWdnJUelFwbXgwWDFRQ21KbXl4cWxoQVgr?=
 =?utf-8?B?OXV1YXRYdmR0R0MwZm9nOHE4SG9TSzhHQmlySWlqazBBVlZoUytVV1d5MGtu?=
 =?utf-8?B?U3BuNTdFL2ZvZkVRL3ZhK2tmVkhkd2ZaV2hMUndIR2l1V3JvdVRNS1BYOTJz?=
 =?utf-8?B?N3hLcW52Z3V2d2kzZk9NdUpIT3V0VnRSaWE0cWdkRGFoTi96ZU9jZEdCcE82?=
 =?utf-8?B?N0txdVFhbGw2bndLWGppTDJGa0xHTnVrbGV1d25nOEh5dWw3WnVYcVJCNmZn?=
 =?utf-8?B?UnI1M0UrVzFUdkRHZUdReDFmTDcwaEgwQm1BTU1ycTZSOHlvSUZMbGVpUUJR?=
 =?utf-8?B?a0JJWk4xZ0xaSGkwaTB3Q2MyU2t0S0ZNT1VmL0d3cW9GRlNsdmVvbUtDWFZI?=
 =?utf-8?B?dVlPbTVIRVhrZ0VQejhwa2lGQUZJZzd2WjVhdU1kYlVQYmRLRVlzVWFlV0lG?=
 =?utf-8?B?SnFXKzJLN1ZsZFlJQVFwODl3bFdvd29PUDhQbCtaMVRVWkptSzJPUUYzNXNR?=
 =?utf-8?B?VGNpVmllVUhtdU5xK0tiVC9yNHVRdC9hSEgvazlxc2lvVUxJMEFlWXRSQVhV?=
 =?utf-8?B?ME1qeTBkSVdyQ3NHZGVEZjQrTG5oUTFZeFlyaVFVMFZwc3B5MjM4bEp4ZkR0?=
 =?utf-8?B?bS9wWUx0U3VBOXhJUDZRZTcwWjQ4Ykp0cGw5T1M1VjVtUHRYZ3hKcXdXbjEw?=
 =?utf-8?B?QTRERzhRV3A5SUtWemdKYnduREsvdy9kRHRRbTg3aFExV2pvb2lsQUg5MkZw?=
 =?utf-8?B?RExZMFQvMW5teHdLNzZhcnkvbXdocDFYTkkwWDR1NC93TzBGbEdmLzNmVzk4?=
 =?utf-8?B?STNpZ2QyYzR6VVAwRW1IdTVKSlBMQkZMQUUwdnpqWVFabzJpUXZqVkp4enNv?=
 =?utf-8?B?bFVmTkxMZlJ0OWwwVDNoOC9HMC9VMjNkM1k4ZGVHcHdnTUZxRlNrblh3N01w?=
 =?utf-8?B?OVplRExoZzZGVGZHL3pnUDlmK3dQZWgzSDAxQ0dqZExjNFR3ZDk0T3I3ckdj?=
 =?utf-8?B?Rmt1T3ZvVUIyL0JZa0VWYXRFOFRLM1hRTkxMMVdBSllnenVCenk4SlU1dlBr?=
 =?utf-8?B?b3VFalQzZDZOT1p4TXJjQUFmOTZkQ3A4NHc2SFhKVE1vZzZ1OHVOaTJlcXgw?=
 =?utf-8?B?SElzZG85aTU5TWtGcVZVeTdJMSt2Q3U5c212d1hTTjdjRmlHVitGTnJKZXBx?=
 =?utf-8?B?cEpFdXlQYmdwTjBnNnovOWpkVnN5VE5mUHEyVWVibkZpdjhCaG9PY1hXV2Qr?=
 =?utf-8?Q?QBlYEpaEip1yFcdQGNMvYuo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkZveXFFMExkc1FtTHBoYStIYlBsUzJTUzRBR0hGYnlCZmRmTWlrUFNxWXJB?=
 =?utf-8?B?VGRqdjRRZnRUMVQxd2hYZFdFNFAxanIveUZkcnE2L21BME9NVVpsODZPUlJD?=
 =?utf-8?B?RGJadXp0VmZYU3ZQNG5tWThpWUxwK1l1T3RzdS9VTm9vdEVIRS9ibThkWFlW?=
 =?utf-8?B?MXlENG1GaVhtRXF1OFNMY1U5MnpXaG82VkJuN2ZqWG1wbTdzVmcybzNaenI1?=
 =?utf-8?B?YXZGdFp4QmhDWjZtSDJUQ2ljYVNhL0c0RURYd1ppLysyOXltMGpIN0VnVmJ4?=
 =?utf-8?B?SGNtL3JQWmpsV0pPRXJ1WG5aeDhxNTQ1UFgxRnZ3QUVQZXJrTG1Ga3BacjlP?=
 =?utf-8?B?Z3ZyUTF3T1p5ZUJIa2VXd1QwRnY1VUdRQ3N4Mzg1VHlpMFRabFRZdDdWeU5J?=
 =?utf-8?B?UVAyRWI5YmdpRWNXU0ZyWkdhWVRyL211S2trNzF4bFkvRVlvWnMwbjJRRzVD?=
 =?utf-8?B?c25GeHpyeUhwOXhXYjY0QW5HeVBrV3pIeXlwbEw3QjhSRmc3SUVIeG9WSWtj?=
 =?utf-8?B?YjUzUkxJV2pwb243T2d0eFM1bWIrb2VqakRTMnN5Z2tyengxZk1nWGMwQ2lx?=
 =?utf-8?B?eitzekFDeDUvQ1REbUQxcWpmaHRDV2ZwcmQrWTVuN0wzakNxS3VaZldwVldY?=
 =?utf-8?B?ZE4vcE1oVnBLWjNSRDNxOE5SNVc4bE52YTNacjBnNUM3cDVkWjlIRlh5bmdN?=
 =?utf-8?B?SURxeWdiVmVoR1Y0MitDK3BGRUpySFZvUyt2K0t3L3J3ZXFUa0M5bTNQb3RM?=
 =?utf-8?B?MW5pMk8yVnN0S09vT1VUc3JINWdyZnhIbHpjUnd6WDNzc2IyTVB0OG9laTk0?=
 =?utf-8?B?bGJ1bnB3VFJsbDNLM3NaRm84ZExqZEcyd1FxU0dyUVpuOGRGQkhpdzVSZGtQ?=
 =?utf-8?B?V012LzNWSUdvMXpYaUNrN25GWjB4NGY0ZGF5bzdBT1pHTDJrRy9zWmlQdStF?=
 =?utf-8?B?R3VTUWxiUVVKdVFVRTFkNC95aHY0aTVqOWduY1lOanpMOXJaV3lQTDdiT1NJ?=
 =?utf-8?B?emZiN1poR3Q1cGg1VERTTG42eXN1WVdZTGZuQjRaSUIrcXM5NE1hQkVQZkpT?=
 =?utf-8?B?d0ZMRzN3TkZjQXdFZS8va3VNZ3h4NlRTSGx5azZjcVYzSkU3UmhZM01oajQ3?=
 =?utf-8?B?SUhXRS96RFF0OTJTNXQvaFpIR25jTS9RRlhoeWllY1JLaUZpaC83QkVRR1pH?=
 =?utf-8?B?MTQrQTVsTGUwaFlBZ2VOMDBKYnNuQWRlUk0xTHFPSUtsd1NjeWRMREZMS0Ft?=
 =?utf-8?B?L3d3ZWFSd2l6cjVxcEVXMElya2Nwbnh3NldxQXJFT1hxcngweGJnaVUrT2JX?=
 =?utf-8?B?OW9BL040aW5kT2VrM0xjS2VpMEhiT1JLb016WFBSL0RhVTNlc1dyL3FDa2dZ?=
 =?utf-8?B?Uy96THdOQUE5U1NXVTJtNTJxYjZnNnZGWncyOThhWS9xODN3cWJyTnQ0NVBZ?=
 =?utf-8?B?WFZjWWJmN0xyMFJibkt0MEtacStlU1AyV1BLbWRFcXAzb3R6Nyt5cDFLb1FJ?=
 =?utf-8?B?cmJic3QyZEYrYU9HalhmMjV4Z3BNdjRHSVd4Q0dSbXVZZjhkM0R6U2g5d21W?=
 =?utf-8?B?UUs0YWF6cFBidURSazZrZ2J2SHBQOCsyTjB4MHgxd2VpcFluTnF3L1lWSWVN?=
 =?utf-8?B?c2xRSldXaEJkWmpBeDN2L0ZXbFFxdHV1cU5oY010ODVuUGhsOVIxNnNxSVl5?=
 =?utf-8?B?OUxmSGE5SGY2ZWdjVHZJYUNPaGMreStUWk5uYTQ3TUJmdDZSUWlrVEhFMDNS?=
 =?utf-8?B?ZzFpeVRBaXNPR2Rob2Qrd2tla1YzR3Z1MlFJdlg4UWM5R1ZHTStLcGZrSTkv?=
 =?utf-8?B?NytKQ0FSbHBOTWh3YkNudU03OHQyb0FNWDZ3MXJPNU5jckM1QVIzL2liRUNo?=
 =?utf-8?B?b0ZVU211Q3dnK1NEdWtLNm44SkZ1MGFqN0RWeUNpNCtsZmRVTTFNTXpuKytO?=
 =?utf-8?B?SDVLbEZ0TlFvdEIvVXc2Zk9iMDJreG5KbFNzVlVHL3pQenZuYitIN0Q1NXp1?=
 =?utf-8?B?TlRxc0VYdyswRDZxanJ2bVFiRVVUSFN4UjdCMFZHajVHeHlkVVJKTXlGY2V0?=
 =?utf-8?B?SHhselhoMkc3N1ZLQnhjamRxS2JUaWNhT0FxK2JoaDJBUVdXVWhZWGpDaGFX?=
 =?utf-8?B?cmgrNGY2TGZ1RGdQT1hHMjlUZ2FTUjRwSnMvWm1ydDh6NXhTVnF2dm1vcUNC?=
 =?utf-8?B?TzhKbzR5eEFLVlZaNGJHMHVsRkVqcGJyMlVBWW1zN2paaithRjBzeXdiNlpt?=
 =?utf-8?B?UXNNbWI1TnJVcUdhN2UwU051VUhRcDJ4alBQaDR4eklSZzRaS3Z4U29FV3lD?=
 =?utf-8?B?UGdwelRlVTV2dVpHZnc0MERndmtScFYvd1JKYlBaSUt6V3ZwcDE2ZkdaNE8x?=
 =?utf-8?Q?ieeLQEHaaq8lYxfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EFBEC0CD9E47246BE60A3F7A7672618@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DgeCefDh6Q2EH5z00KTW/u+4lByxJEITEtYjwf8ow2Vn8FfBWJ0g4dGO6pE2avFgaM4ZRnEJEzlttNN1GV+EEkhDfY1t8YyibOSexp4Ic12ZSXtptNEnz5lwSXHNjzro0LLMSGL1UyHELWU9ccXPvmiS7f83KfxSr+/hRCD7G2rrcd1Yl0iSijAAfX19iWUDj+TtLnWK97BbJ7T+p+cAZpyi5cbMPChG5mv2H8wgTaKliezlvDuu0PJEUV/cH0fTssJenZ9/4ULvQmTKK0i44WNZvzzRqef3CDHoD++swMKnWdCcBoy//NUvd3O3YGbMChwsAZbH6MQ0lUJPQbvLxh6J541W+2rBXwsD3lLN1rqaTCMOzPfov+z7hYiJ+/am6fbN8aSE2vqIdOeGxrH4NQwRbWxJdUbciyZaaTsthSp9U/pQrTLkKbBwp68bYQbzXvw+Gdy1PPqA5HgFdq/Cbg3/3+6IpGF9W4skTEEFqy+dR1KQ6W6ULqw/FeGAvD7a2SfzdLlwKPLdRPgMXc6jxTGOcwdlDzle/cv0hmbUKsBpc0V+0M+nvMsO9JcBHw6W5OEYxxddkcO5QJpUYD6WVsiOSAIDzdyOHPwB+cxMtqw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e2dd65-9d3b-419a-b540-08de62ef422c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 06:41:27.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPlrgKFP5H9PwZ6JxvSkWLou6pFqom++XQk9MDZmrrS+wR/1rbuLFSx1WlmfuzR3rC3k5ZyjwaYLwz6H5pE9uC9uMEGBI87IBaC+abyU4rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=982 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030051
X-Proofpoint-GUID: bGVq-4qMaoYLKVpE1U_m_CH_IWPkA7ic
X-Proofpoint-ORIG-GUID: bGVq-4qMaoYLKVpE1U_m_CH_IWPkA7ic
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=6981989b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=A1X0JdhQAAAA:8 a=-huMt_nOu3bUEjnZhaYA:9
 a=QEXdDO2ut3YA:10 a=9dSkalLr_iMA:10 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA1MiBTYWx0ZWRfXwS9vF4JAte1g
 1U0Eb7HWbzyBE66bRHQigyLUUIG0Hp2C3Tj/zHLp9uDiUEQJUbU2Xsm2vQ2gPji78KBPPJ9eH2a
 AyVnx0x54svWxYtSgO18zZr3Mx6HWHdgBcTHsdf4YsnOeMzCVuCQ43jb8w1tG5nfYQswu/qsDtj
 yabv1wQitcTscbltdPlz4QbCixwg9tLBgJukyLseHDKVtvpGAxJE4qqIhxS/bvijItUPdWZXrOc
 vIFTfwIdaFfu/p7FOmmJJW2lTtJLQo5raEfK8D9+tH2fEf3FOdXTzy16VXNTy3MC72iP2PwyQ/g
 LNzuR1iT3QQysII1f1w/lF6y1uHgj3PN0XfatZZE/fUgrhllQRzidfhNmpQgCNBBmKBvbVzNpMD
 4lCT/M83RCq3QQNb5wlk31M0t202QZJwkum6eGpgBEaLIyI12mYPzpILGTk9ygXdMH764k+7ibR
 yBjk5AK9o4SR762MvNJKGg6sY48jk+mHvUZTX5jI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16406-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B95DDD5791
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTAyIGF0IDE3OjU1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCAzMCBKYW4gMjAyNiAxODoyNTowNyAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBGcm9tOiBPcmlnaW5hbCBBdXRob3IgPGVtYWlsQGV4YW1wbGUuY29tPg0KPiAN
Cj4gSGkgQWxsaXNvbiwganVzdCBub3RpY2VkIHRoaXMgRnJvbSwgSSB0aGluayB5b3UnbGwgbmVl
ZCB0byByZXNwaW4uDQpUaGFua3MgZm9yIHRoZSBjYXRjaCwgSSd2ZSBzZW50IGFuIHVwZGF0ZS4g
wqANCg0KVGhhbmsgeW91IQ0KQWxsaXNvbg0KDQo=


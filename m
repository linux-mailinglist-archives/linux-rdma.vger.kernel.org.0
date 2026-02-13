Return-Path: <linux-rdma+bounces-16804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNNvMe/HjmlYEwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:42:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E313349A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3FD8300B445
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC0265629;
	Fri, 13 Feb 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8ti6R6D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HaP14jq8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CF2144D7;
	Fri, 13 Feb 2026 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964967; cv=fail; b=AO5vebrF25P6QosAtv3Epv6/hffv63BWk/vwHaHRvzXiPy43zUPHdZa0tMhU71BoL9RsPjDhIDqAWy/dxnHdVdxw/JcCpZQGZYCArv3t6+U4pQ4n3eEEuHxCd/AevVEAaSsYrbnGCVN4Se8TU+ODCTmQqpp635LWBlkaSHR8gy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964967; c=relaxed/simple;
	bh=C4YoxIX8MwXWt0uNFtShd4l8Ck0xXSbb7absM7Kp/Ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kVHCni/XXxh1JdfnifudThx4HcL4CSdnI4eIdAmj4XapGxGJLCCupON0j5qMSCzPYGxN5muHXra6FreQ/csy6+VhgPoY3JFlOIVQLt8Lxp/1KbrtYG3DX+TLAEZsxsWpPBb5XIGjMPIQNIWhACLZrTJabUhDeP9Auc113BsBRjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8ti6R6D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HaP14jq8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D6Iv2j591607;
	Fri, 13 Feb 2026 06:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C4YoxIX8MwXWt0uNFtShd4l8Ck0xXSbb7absM7Kp/Ts=; b=
	A8ti6R6DDbZdaoGZ9mxcYREJPSkkyY5kgMXOlGQ273vStfRH+d3QipjKx6pSqbOK
	fNRMA2ZPmgI/hJNZV5J/66dFFXli2+m40ENAXRxvE5ba3Fb7OKYzJdUC1DnFvZfB
	V0zT7pOinG+fuWo6quel5+tvQUHwOL2F5izjo5BI6XP9TSzIxw5D0rteN4bMcO9V
	1iXPqkbqfWgM98CI2vp5z8WROYXFFiNZu11H7EfSpuxVjqjZr55srhUK5rnfq+2c
	2ThWQh1XuvaBXfQzv5QY92gzW1rwJCKXpGZm/esD0oClcTojouDhumVKfTukuYMA
	OXam7HyzYk/buSHqOPV9OA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88qt4r4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 06:42:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61D6Dw1W012976;
	Fri, 13 Feb 2026 06:42:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c8272ydrf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 06:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoPuv0mJ5euj7RTqry9UFZvZI6NWwYPajmpMssYVBiKBoUMSfsscdoKaDpI6aG7COpR2t5Xlu7VG1MeEtyipjhPBLobORlZ4cNOSfwzVsdSfkbXnKZX/ufkP6OKK75cRa2gcckU2m0zfZUbNFNEstygM1MNGpnmuRN8zwzPQnMmTQO97O/ARx/ZZOaUSWFc7YE6HnOkNNrefIME62f9IvlDZdEyH9mwhECwXBq/W3SexJcH7YVFtGh9Sgd+1axaYrkgiUQE/FW3o3s4ZKppmhDrAC/+5UXlvIkX1lqnzOUrTo0Lia7PuRG7lf2DZI79i8jEofqpPUa2vXCC1R3Teww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4YoxIX8MwXWt0uNFtShd4l8Ck0xXSbb7absM7Kp/Ts=;
 b=wgrfICLaXy2K+H/5GsewO85qCyB9j9+SHOjGVNi9nD2tCMhlqMiUq4nGuDPtT8wdiwUuNWfTdijC1xeX6bq0Hl9FNkUN+3R4WElrhlgwZ0ye6Csz4o6MGLmqV36Oy0ExKkD3N/2zI6BhMxxNhVfXba7lbT5Zj4w8esZxDk+VyRs/r4cpjgdwrQDevSkdDtBbAJmWujibLpt+QOjX3dYpC8rr2ZgbtLpN0oilay0IGCTgASYaCFYgAD3PjMVemjWf4gazQ8TJA6c05o1+l0iWFyynBEl80BrYO1zlnNUds/pjvai56dgyQhctLyEd52ggA6BLNvXY+dkYHysJIGTo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4YoxIX8MwXWt0uNFtShd4l8Ck0xXSbb7absM7Kp/Ts=;
 b=HaP14jq8rDY7Uk6ChDMNyDb68d+3m6xUArOCKnI+yxhRHh++jHP4Me7VOvG4zKlWHIp3bUqB0YbcM63fpPbcO5Prsfor+VEHsY6Vsmw1N+aOz6TCHYtEEtSLsHesd3PkgFfFJ8wzsf0XA+RFVDGgSo7Qe518Og9ZgYoksxr+Log=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Fri, 13 Feb 2026 06:42:35 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 06:42:35 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/4] net/rds: RDS-TCP reconnect and fanout
 improvements
Thread-Topic: [PATCH net-next v4 0/4] net/rds: RDS-TCP reconnect and fanout
 improvements
Thread-Index: AQHcm+D/uXPHIt8m1UCb8f00QFiInrV++yGAgAE0+wA=
Date: Fri, 13 Feb 2026 06:42:35 +0000
Message-ID: <50959447f4f6601961ab79d6a097fd4e5365dc43.camel@oracle.com>
References: <20260212053230.1921241-1-achender@kernel.org>
	 <e52a10e2-b208-460c-a3e3-305b91433531@redhat.com>
In-Reply-To: <e52a10e2-b208-460c-a3e3-305b91433531@redhat.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|BN0PR10MB5192:EE_
x-ms-office365-filtering-correlation-id: fa67e999-fcac-45e8-797a-08de6acb1265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmVTUURyM0xmVml0RHQxajhnc1BiMGZtQ21QdENFYVhMUk9WSlg3Q1hISzUx?=
 =?utf-8?B?ZENwWGZOODhNZ0R6d0pQRms4eTIyMTREUGU5dXEzdStFVEVNR2F6bU9mZjg1?=
 =?utf-8?B?NnVGeUM1bTBnT01kNEF4WWlVZEQxcnhlbTlaM0l4bWxZeGgydThicWNQUjY0?=
 =?utf-8?B?ZmNoRndFZ1FPWXpQcUx0cEEzV2IzNlp0S25DaWtyZDFNVnV2N1FCTG1PZ1B2?=
 =?utf-8?B?T2tDUjNpYVVkdVhvK0lKNU5GMmVSWGd6em9mQ3BNeDRkdytoVVBXQnBnN2M1?=
 =?utf-8?B?eU9ZZkhqeWpsM1JWTkhhUFZsanpCZWNnR0g0bHFzRnVrUExOYStQY1g4aHd5?=
 =?utf-8?B?RnFMS3h5VnBWUWdVOUlqbU4xVzFLLzNWZzByWW94ZjZ1NGZHSGZoWHUycUZY?=
 =?utf-8?B?WnNaSzRDelR2MUhuUGNJM3FUWnZpZ01FZEtad2lhTnRBNGlDRnV0U3pYV3kw?=
 =?utf-8?B?N01RS3ZxTVZhY2hPZHBiUVI5ais4dUwvOXcvRDNpaHEzTHh0MWlreDd3czla?=
 =?utf-8?B?SUpSVkpGWGtmQ1hiT0JVMFFxWEtOMVhCL0g3NzhWRlhhOUVEY3VTNkZWUk5V?=
 =?utf-8?B?ajRpalFBbUhwakprLzE1cW9BYzBGTzdOWGdjVmlUc2xkeUFZSlJzMEZ6UmNi?=
 =?utf-8?B?WFlhY2xWS01FcXVVdGZSM3ljUS9WNGlNYkxxSHp3dTdhQjA3QkdSWHdjczE1?=
 =?utf-8?B?eGJ5MTRjYzJXSUlLMUJqS3V0MDlQQnBXbEhmRzdzbXVRWEdSUHI3Ry9LRVI4?=
 =?utf-8?B?S3ZkSW5GWmhtQ29Fek51WXV5c3VPK3UycDgzQ3NMQ3IwY2haZXNJNXNGWUtp?=
 =?utf-8?B?TFRFWGRiZGhDUU5NVUVocitFbVJRbEtQUEpvdEFldDY1SlpTQi9sYldmNHRZ?=
 =?utf-8?B?WitvYmJlSmRwRHlSc0psV3M5VFNVdTFtZ3d3VkhZTGxOR0E2Qnc0YXpjbS9Y?=
 =?utf-8?B?MWI1SmNlRGJmZXphb0hKcTdMcmM4clJJOHZEd08xTTI3RG95Y1NmT2xRU2w2?=
 =?utf-8?B?SGFVNUZpWjc0bmNpaWVlMnlpV1JOT2tSUGhqSEpsU0ZkQjU1d2p4MGRDQlBS?=
 =?utf-8?B?RElzamxhWUZ3RHFJZk11ZHdId1A0bzg5dmFMQWZ2dGQvbmx5dkxoZTdaZnlk?=
 =?utf-8?B?UEpZS04vbko0VDEvdEx3V2Q3dUlZOVZ0TTJiZk5ocTdhT1NZK0VsZ0Z0Vnpi?=
 =?utf-8?B?a0lSNVptTGZyQS8yYmwzekJkV0w2WG0vSU1vUThTNGtCOFh6Qytia2JTTGpp?=
 =?utf-8?B?K3BLbENOaXFkMXhWbXdwZlJWOGRHSysyZ0RyNmlZNkd3cTRHUFMxbTJoaVFB?=
 =?utf-8?B?RVZ0ejFYWm1HaVcxSUxaeU5SNWZVZ05UYXJveWdrWWJRbFRXakxnWExEaUFw?=
 =?utf-8?B?eHhuMExVbk5JZTFST3RaZm9TT2IvdXJOVEtSTlMxK1ZMTWkvcnFZUGMyU01X?=
 =?utf-8?B?VElEOFA3WFdpQjBNclNJN3luNUREeFlSTncwalJ0WGpiYW5VQ3JnNnBoVmxG?=
 =?utf-8?B?cGhYTFZpRHFudUdyci9xQTF3TmppK0NReS8vbFEzTklpQWl4MUNLalFXd0w3?=
 =?utf-8?B?MzdqL1ZLVUlzSkdXa2tYK0NGZDZuWlk4VTZobmF2ZmdON1pmWENUOU1OaVd6?=
 =?utf-8?B?TFhUck1ROGhBS1R4Z0c5TlNVa25hbkZGUWF1VlF0M0R0QTN2SFVZakpNQ3FB?=
 =?utf-8?B?NzNVeDM5dU9lb1dLL2RyVnlJL0wxamRmVjNkWXhLU1owZGIzdDlZb3daWnBh?=
 =?utf-8?B?LzBQQ2E3NERqRzJEK3FEUy8ydDF2RTJPY0IwSEFVamZMTXhBVDVwOUxRcXdT?=
 =?utf-8?B?QzRVcjM2YjdjZWE1SEpYakpTcFI0VzFIYTlocUZFekNCRmJRM1JCcmVIZzlh?=
 =?utf-8?B?aFhhYWFqWUs4K2JyYWMwd2hLa1E0Q0FiNjFteTBOdHpGVmhCeERtV0YrZnAx?=
 =?utf-8?B?dS8vT1EyalkyeEdWM1VPREo3SldrQU41UFF4V0QybERlMEJza2xGeDh6YU1X?=
 =?utf-8?B?UTJmZjdmbnh3RmFvdlV5Um5DWndMT21OTHZtU1VqRFJncUVyaDN1YnVXdEY5?=
 =?utf-8?B?STJBUjhPTjB6L3lHSkY5OWtIR1cvTWVwVGhhc2hCdkFvY28zaHhoU1U4MzI3?=
 =?utf-8?B?SC91TlgzazVvU3QrMlBBSk91eWpQWHJoN2lzdEkyUnVIZWNaMWpIcmlMUzU5?=
 =?utf-8?Q?qt7VBxa4GeoCnGEc0AS+MlUxwmXzkF5rHElw6M6j1puC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0JuWHdsZDBsdXE0ZXZ2N1RzYTd2ZS9zOCtveWtGMXRId1ZodVJhK1NuZkVD?=
 =?utf-8?B?YTQ1MVJySVNIZDR0UXpZMnA5d0RoUm9Mb2dPTzZHUmJ2eHJMREx5Y01JWWh5?=
 =?utf-8?B?MG9uTmcwZE1uZEQxSU4vMDZ3WVVpUk5aeFpWa3hCdzFzYjB1QUFnQUpzd2Nw?=
 =?utf-8?B?bnlIcUs1d1RNd1EwNENGTVFheHpXZGNRNDdtWWxsNFNLaWs2K0Y1ZFU0TkE0?=
 =?utf-8?B?ZXlLdlo4Wm1EVU13MkpuY1ZTblM0d21YV3JsR04xb1poTDZ5Tm9tMkt1SFFQ?=
 =?utf-8?B?eE5LMURyeCs4dEJINmxOcWxOYW1SNE9CanE5WnVlcE5lSTJybzBJQmdXMlZ4?=
 =?utf-8?B?RTBIQnIzUnNBSGZvdlg5RFcreUFpQjVGVlNIeXhxa1F0OWp1anhXL1BReWZ3?=
 =?utf-8?B?NmIwejlHdlNtNmEwVjlMNE1ZZHl1SVNZVlI5eGhrWnpucWNtbjhiLzFFckZD?=
 =?utf-8?B?OStTTENQV0toV2loZFlCNmZRZHNxVmdEVVlTWnVhMWxtbEk3NHR0S1lBL0pG?=
 =?utf-8?B?YzByZy9od1ZJU3ZscVY4cTAzK2FXSVJvR0pMcks5eml2QnkyQTFERHRtSWFm?=
 =?utf-8?B?RjNVTStsMnhjWFhHZFdnSklJRzdIM2dmZFZQZFk4RDZSVDNWaE9vZjdvOFEx?=
 =?utf-8?B?V05QWWFKYVl5RkMzRHNCS1ZxbWE1RWdZMVBxbTJrV2VKMnVENUVYU0UwWGNJ?=
 =?utf-8?B?QWNWUWx2bko0ejRMMzFzU3dBUzhocDVram84YXIrRlVrZDFBQm1QQUJXWGdS?=
 =?utf-8?B?dzBqRlJ3Z2NWZXphODE0VlJzcnA2WGYyZjdFZFpONzloV2N1N3N1dENGanMx?=
 =?utf-8?B?WnNuUVBNb0MyMEY1eUpTaG5PNDE2T3dGZzU2MFVhV0FPUFhwZFZRbnlXZnZ4?=
 =?utf-8?B?bzNvcDZuZW90RFpZdlZydElDaklkV3J0Y2Q4Qld0WWpUVHFLaGMzc1RDYVly?=
 =?utf-8?B?M1lrSFNhYkpJcXIwSDNoYVppQjZ6VkFDNlZFWmE2NmpUMUdZVGhyV2s3TUEy?=
 =?utf-8?B?K09WRmJGNFdOZXZlNDlBR1NFVFE5Wk4rRVFtMitHd1NudllQcmZsR3ZPZC9y?=
 =?utf-8?B?WHh6NkRTUkFuYlNqcVEvS2I4TkV5RGMzT3lZMjU0VGg1T0pqeFBhbVNKRStl?=
 =?utf-8?B?ZVpXRWsyMWZGUUo0dGRVRUZldHZzY1hET2F3VUhYeWZLUTZod0dWd0lYWGdM?=
 =?utf-8?B?MDdYTUFzYVdoOGxiNFI1UUo4MmhWdSs4TG95Qi9tY3BvTHFETXFmcE9iRW90?=
 =?utf-8?B?MzlBbFNkb0FFOVB2MDhFZ2sxS3FIWkE3SFhHbjAzVUZCWFY4cGRBMHZ6QlNP?=
 =?utf-8?B?dUd1TDFOUTdlQnNndWswM0NkcG5BK1prL2hFQ0FEcXZod0R0QW0zZld3QXha?=
 =?utf-8?B?enhKWTNsYlk1V2p5NUpucnBVWklwaVVZZkIxejdsdjdwQjArUGpPelZqZW9M?=
 =?utf-8?B?RlRnNTRkZTBKekxSaTVIM09YNW9sdXhSZkE0OXgxd2xUcTFDbGUwQ3RES1BI?=
 =?utf-8?B?c0NSZU83a1lMNUZ4RjBFeEo1UEhFR0xOSGt6NE5BdkdhMjNXM1BhbzN2eERG?=
 =?utf-8?B?TFFCZ3J5Uk5yTU5uNGpIRnVpQWdNWjhPODVkZ2txVGJ6ZDJ5SERoN3EzTGJL?=
 =?utf-8?B?VFlYUW10T2krWGdNbXpHeWdkbWp2ZlZkTFVQL0xTaXlGL0o0c1RTdkhFaWxy?=
 =?utf-8?B?L1hVL2J4ci8xMlVVTmFGbUtlTU80WFNhVzBsVGMxQXc4R0dCQ2FRbDBKMW9w?=
 =?utf-8?B?KzExdlgrSVJLWDRObFdzSkJNV2lCYlRzZGZ5MXdGNittdEtTVWo4RmVTU1BQ?=
 =?utf-8?B?OEFQM3VVTXJ6ckF6Tk9QNEkzbnp2T2o5WXgxMDBXbDAzOWx1MFBDSXVHQkJE?=
 =?utf-8?B?bVRsRWROMk02ZzJQa1NOVW9zLzdaUVRaOTdDRDBudVpRRXBmWlRXemxtYnJm?=
 =?utf-8?B?UVhxVFZUeTRKU1ZONm1uU3U1RG1xclB2d3RZVi9pbkdxQ2hZUGh4YlJCTmVI?=
 =?utf-8?B?aEdsNzc5cVlzSSt3Y2w4cXZ0clNpYklDeHkrdkdkbTA0bHRQWnFMdmJEZk9q?=
 =?utf-8?B?VDJzMjMwVWx2cTlNdUp4dVZ4WDd4VllTZ3ZhNGpMdU1ZYm44TGdKWHVKZXNW?=
 =?utf-8?B?d3FxcVhYNmlvK2psMGNuV3hRWkZxd0FBVTVkb0tJaURkWHFpa3ZROFh3Sjll?=
 =?utf-8?B?akFURXNraGFZL09Xc2o3c0hEak45UW9iMmxZMzlIKzZjVVovdFFHZUJ0cXBD?=
 =?utf-8?B?ZmNzNGlXSDNNanRLN095cXVHRHpTbmFCMkE3NVRrZlQ2UkFOTm5JL2lVNnB4?=
 =?utf-8?B?cXNvWmtiWWVLeE5oVjU5eDNFVm9GT0phVGpHUm5aNllMb0M3YVBXTlduZzFG?=
 =?utf-8?Q?P8/iD9cRNdicvqYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E60B18C75CE2849A1173571C735FE35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QhPGw8ziqH8TZ+W8upLLouXudUMxBTbyfbokk4z6vW+FsBCsJfvhHL9Db6sa+XNlEzF6QCcQThfnOWIY1xZ5yEUDNrtGRc6zQXmSCou/33bg+HoV7t/bAAquJ2E7sF4ptfVt0Z+RHj5p+d/sI90ky1MVJ9tM6s/ptz5OQFxqRZOb1Zh1B+mKkFlygNfyZ94XxglkBPyFZRrFf9RuTs+x9O/HHiIneAVQ2SmX7PaQwTcGXPuDM6uLvAUwUnmdxpv8hXSw1NpRDE8Kh/4+pwIN28oi7qBjzVoCA3p1Iuenguezf4js7Iy7mS6CMoKROS1a1Km2fbjnT2BcIWxd6Yn8ZvuvgoN9ulO1bw7bJB2Aph+QIlcVRNIVh0SmrSv3YHGdyuPCog/JiMjopLma/CdMaeOUVJ05FAjPJPhZ0Snxs0Ly4wiOXxpTG6zfFZQuHNqJy+LK9xhWhqyuB8aWHhSR66EK1oQOcyvjYc5eSU8yrJ0DLUlHUZWhhb92GxtfJwAIK+EgcLqeou7dXISncxXykJdaEzXzr9d/gcIZcI0s3VKpMoo90LyC+2W9S+zGxvHeiS7txl/qkKodw1ERdNWqNkcq02gLngwlsquryWhS80s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa67e999-fcac-45e8-797a-08de6acb1265
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:42:35.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkrWBXLJFn40DS56nERlyXO4hp8iXYN9+c8DI6jyo3QdAZuyzU1AshHW/tEBZ+UUhuRu0tNMjWM5X8SOWjY7hnUO4AcsPwPeshSyN5r2Akc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=658 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602130049
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0OSBTYWx0ZWRfXwPynrRFMcWn0
 UDIY9pMJcuQUC1D7wLK8bsbBKOYXxMB1EjW6jEMFhV5ds0B6zlifjLt7EiAczGAYbbxvIIkUyAQ
 WC70psCbXLtsKgoJPzeFCuzaRHoay7jyrhlcRmFp0neWOJtbcjKP6GYmxcIxwUn97lQFrJH0M6i
 GRtk4u17vy1GAuf1MUnvnZZQqSfiPKDC0mlmMS892biKVhyeuMez9Ggd1OfvXjAeiD3894J7iwL
 SlxfNZ3Q0FNp0Aum4R9cY/YJggnkPCKOIT6Ir9Dy3N06bOb5eKSMvF4JESEaE1AtEmdO1zPTZXe
 fwHBW7oYY+yxOnNN4UlZzU1ZY4R9hIE9Yo2sFGIsGwmZFWkOp8FoivL+QKdacVRtQ0KV7+IyxMf
 j97PtfbGncdJ9vSwX7c14DRPCPL8fWYZD/3nQGAeKFy/dN71wmzxRAmWJuE5FBnlJRXPb6iX+IK
 9VDfwuCuNXy6P7mWfT25ilXhyhy8LV4LIrXZUB0Q=
X-Proofpoint-GUID: v0OwG77a40sNslWtgihNnzgF0OV7qZhS
X-Authority-Analysis: v=2.4 cv=Mehhep/f c=1 sm=1 tr=0 ts=698ec7e0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=WlP09RVvnoWRVhKJJmsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13697
X-Proofpoint-ORIG-GUID: v0OwG77a40sNslWtgihNnzgF0OV7qZhS
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16804-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CC3E313349A
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDEzOjE2ICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gMi8xMi8yNiA2OjMyIEFNLCBBbGxpc29uIEhlbmRlcnNvbiB3cm90ZToNCj4gPiBUaGlzIGlz
IHN1YnNldCA0IG9mIHRoZSBsYXJnZXIgUkRTLVRDUCBwYXRjaCBzZXJpZXMgSSBwb3N0ZWQgbGFz
dA0KPiA+IE9jdC4gIFRoZSBncmVhdGVyIHNlcmllcyBhaW1zIHRvIGNvcnJlY3QgbXVsdGlwbGUg
cmRzLXRjcCBpc3N1ZXMgdGhhdA0KPiA+IGNhbiBjYXVzZSBkcm9wcGVkIG9yIG91dCBvZiBzZXF1
ZW5jZSBtZXNzYWdlcy4gIEkndmUgYnJva2VuIGl0IGRvd24gaW50bw0KPiA+IHNtYWxsZXIgc2V0
cyB0byBtYWtlIHJldmlld3MgbW9yZSBtYW5hZ2VhYmxlLg0KPiA+IA0KPiA+IEluIHRoaXMgc2V0
LCB3ZSBhZGRyZXNzIHNvbWUgcmVjb25uZWN0IGlzc3VlcyBvY2N1cnJpbmcgZHVyaW5nIGNvbm5l
Y3Rpb24NCj4gPiB0ZWFyZG93bnMsIGFuZCBhbHNvIG1vdmUgY29ubmVjdGlvbiBmYW5vdXQgb3Bl
cmF0aW9ucyB0byBhIGJhY2tncm91bmQNCj4gPiB3b3JrZXIuDQo+ID4gDQo+ID4gVGhlIGVudGly
ZSBzZXQgY2FuIGJlIHZpZXdlZCBpbiB0aGUgcmZjIGhlcmU6DQo+ID4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI1MTAyMjE5MTcx
NS4xNTc3NTUtMS1hY2hlbmRlckBrZXJuZWwub3JnL19fOyEhQUNXVjVOOU0yUlY5OWhRIU1TOFVI
NE50RXNPckRjWl93aU5XakhYWWlBRTZKalZCVEdPd3A1U0xTcjRSclZ6d0lFamloc1pETUkzbFU1
Z0QtaVZrY3JjdTBFS1ozTi1FNDFxeCQgDQo+ID4gDQo+ID4gUXVlc3Rpb25zLCBjb21tZW50cywg
ZmxhbWVzIGFwcHJlY2lhdGVkIQ0KPiANCj4gSSB0aGluayB5b3UgY291bGQgcmVzdWJtaXQgdGhl
IGZpcnN0IHBhdGNoIGZvciBuZXQgYWZ0ZXIgdGhhdCBMaW51cyBwdWxsDQo+IHRoZSBjdXJyZW50
bHkgcGVuZGluZyBNUi4NCg0KU3VyZSwgSSB3aWxsIGtlZXAgYW4gZXllIG91dCBmb3IgdGhlIHB1
bGwuDQoNClRoYW5rIHlvdSENCkFsbGlzb24NCg0KPiANCj4gLS0tDQo+ICMjIEZvcm0gbGV0dGVy
IC0gbmV0LW5leHQtY2xvc2VkDQo+IA0KPiBXZSBoYXZlIGFscmVhZHkgc3VibWl0dGVkIG91ciBw
dWxsIHJlcXVlc3Qgd2l0aCBuZXQtbmV4dCBtYXRlcmlhbCBmb3IgdjcuMCwNCj4gYW5kIHRoZXJl
Zm9yZSBuZXQtbmV4dCBpcyBjbG9zZWQgZm9yIG5ldyBkcml2ZXJzLCBmZWF0dXJlcywgY29kZSBy
ZWZhY3RvcmluZw0KPiBhbmQgb3B0aW1pemF0aW9ucy4gV2UgYXJlIGN1cnJlbnRseSBhY2NlcHRp
bmcgYnVnIGZpeGVzIG9ubHkuDQo+IA0KPiBQbGVhc2UgcmVwb3N0IHdoZW4gbmV0LW5leHQgcmVv
cGVucyBhZnRlciBGZWIgMjNyZC4NCj4gDQo+IFJGQyBwYXRjaGVzIHNlbnQgZm9yIHJldmlldyBv
bmx5IGFyZSBvYnZpb3VzbHkgd2VsY29tZSBhdCBhbnkgdGltZS4NCj4gDQo+IFNlZToNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bmV4dC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwqZGV2ZWxvcG1lbnQtY3ljbGVfXztJ
dyEhQUNXVjVOOU0yUlY5OWhRIU1TOFVINE50RXNPckRjWl93aU5XakhYWWlBRTZKalZCVEdPd3A1
U0xTcjRSclZ6d0lFamloc1pETUkzbFU1Z0QtaVZrY3JjdTBFS1ozTXBnd1MtViQgDQoNCg==


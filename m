Return-Path: <linux-rdma+bounces-18289-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMP9J8AtumlDSgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18289-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 05:44:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD312B5CCF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 05:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C20302D13D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3B355F2D;
	Wed, 18 Mar 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmAZgpi9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ML1iSiDF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFD1386DA;
	Wed, 18 Mar 2026 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773809083; cv=fail; b=iMIfovLULMs8YQxh2boiBu2Puf3L9ndJh9+HZFgdbGcL7qwomH+534ZTXTai39x/rbTuasfwH7mgapwVSRS6+iQ/ruW8Zllyal1djKlQ5eNyyUlzSMT5CzxEcR4j6iE1+PPAVw8boNseAzbnnnrijAJvEYxCdNjvqjLVYEVNE8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773809083; c=relaxed/simple;
	bh=uK7cXDh+JC31Gn3BnBG9uPBtrHmKdlb024OgxC7HUAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=egyb0hBwBw5To01MmbIQBWOCGIIsDn48xdTAEt5dp1swmx7CnCB1pcVSuNbQrttmP4/S5QWapHcpDyTnlVQNeDgMiguOH5p7Xz9N9f3McbSFY4hziZ5QQ6TQdMfMqmAoYyPn9y0U+NUOACjFcm4/zplBPfOZa0qDvORW9it1NQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GmAZgpi9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ML1iSiDF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2N2Vx2167326;
	Wed, 18 Mar 2026 04:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uK7cXDh+JC31Gn3BnBG9uPBtrHmKdlb024OgxC7HUAg=; b=
	GmAZgpi91+7wFQuBQZgFhRfhOAp2pafg5WmvKXLwIOKgYnWDnH0eUJht8sSlduyk
	TxAZC/Lwjkj/lbD7aYbO63lyZ/T8cc0ZRD59SvTNfoz/5q6eRiTKe9lyTMk5Koao
	/tjjT1SpxZfsEYjvIddcmXfrbGcjT6DBMErnVAs04UoOjYY+0+qlbXE0zrjHyZvR
	7ChlG/97W5M8kw2SOv5s1mK8CjnqaTeIFdwyK5baAK0ePSNgeayQgvD4LT6ov8qR
	k7vhuSdK/miEIN/z+hVk7yFi+eBED81QbXI4QOsVOlfNosIqtQRQaLuKfDJLwbEy
	hVkSwDQ7Laa2dbQBNPIuRQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b5b14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 04:44:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62I1aeZq021287;
	Wed, 18 Mar 2026 04:44:36 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4pd043-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 04:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA2TVgIUgqp2AnUILbNxpBLAmEKtHB03v5s785JKZ+KbKvwKenkzkaTs/BsmkKrojWehXcJll4g0QSYar53Y6unjija1Yy+JdADwVVW8ps8Um+tUBJ+uBO0a23UFrcsZUwnQ22inxAN75ziT4Fwb6q/0DczYdpPBbxoxCinUBTltwsY+RZjYZGMG1/RCZSfWM/E7F4nK8mHf/h1QE5eolda3FYNPlwtOen11iJg3NEJcLHU/1ZQU7mtrEGymooX3UD3+whS2e09CxPVm8/5GFtAgP5F0G8NYH7IRvBzgRntmA9SWNfd3q9CmpfgMQTjC3i8h5GRVnE9srRNmD63ebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK7cXDh+JC31Gn3BnBG9uPBtrHmKdlb024OgxC7HUAg=;
 b=qlsgY61QO0/fLUJCxACoDvrb2/JuT+Cxpk6bni0D6G/xys+x3/VOnbSj/YC9TeDOEumuc7R/I9wace29976fc7aXmJGZP4/Gqc/gRLKR/49LlOpX1GpkAzgOG8MHZ4f3FTT29I6yMkr0Z3PVnS/0qWmzOnw0uT/Sy+TsIbWSl0DdVz5nbNK7ShONKXFDhxjvnS4ASU9PsuLJ0e3Jaf+NEbAwRdgAjZNSv/50a0dfVIDVWGoW2hhRhvyXnJ8NCBwDPiWLm/BKJk1G0SNPeuT7Pjr7CLLFKvob7J6r3AoS7qyrRylxQxvOF1Rd+biaApgaFVLDA2wf/6dN4QsGScPegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK7cXDh+JC31Gn3BnBG9uPBtrHmKdlb024OgxC7HUAg=;
 b=ML1iSiDFmIA9s6dUdDc41ZCGJDq0jQlfQpGI1qtjVhKy54S8Hb2WRLHUGuW5MhvdX4PEYf34uIB1+jo3AZtkhMM0VoPOQoU1Zaa5W5GqSK1YQQ4JEWvmi7Gk1wQw60ia/3TtaiXPGFqiLtQ5UKyhxvgZIxRFWtR70xtMPgkS4iQ=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 04:44:32 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 04:44:31 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "achender@kernel.org" <achender@kernel.org>
Subject: Re: [PATCH net-next v1] selftest: rds: add
 tools/testing/selftests/net/rds/config
Thread-Topic: [PATCH net-next v1] selftest: rds: add
 tools/testing/selftests/net/rds/config
Thread-Index: AQHctaDatbWm6B16hkWSTSCqoeIRzbWyzOmAgAA+0YCAADosgIAAcqYA
Date: Wed, 18 Mar 2026 04:44:31 +0000
Message-ID: <8b81bc9dbe0b13addae73e7d75dd5d00214b2882.camel@oracle.com>
References: <20260316235848.2395654-1-achender@kernel.org>
	 <728fc0aa-4c07-4092-91bb-6b9f76c2f3eb@redhat.com>
	 <d33e764e33b5a4c6464a692371afc41d4a01c15d.camel@oracle.com>
	 <20260317145407.244ee071@kernel.org>
In-Reply-To: <20260317145407.244ee071@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|DS0PR10MB7224:EE_
x-ms-office365-filtering-correlation-id: 4edaf013-7556-41f7-7d5a-08de84a90c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 6OqIzQbjc9yf27f3GxkNiBmBbGG0uFiu0ux/1uy772WW304e9CNG65sBpl+stEvHi9tD0zmbIDYil77fVRFPoLd3J67o9kMKX5rD0+Klvdfzt0OSV5K4wz1OlvJ2zxG2hyd2Fs/wuVy1Z03tCirCq+mJmbZDJv3SvAUcm7t+WAPqi2Pzc9TQzDDrg+KauHzzoGKrQkwe6MJN6m8gMM5HHEMPzQPqQKZdMg2S+xt2iAyrG35foiZJKdpN5eHrcpEIABxHnbTCWHskN2nMLmn9BQuUze+HUmsQgd5u3CGiGP6MHXFXmYO0uWjlfKI+T9ZdvffW8GJwE5Xh4BNxcBgAsea0Q9FiCF9ynwFWCzKH5umO6aVQfoGYnQakPvpDcJvzLeNEabTQ5B/d809WvZ6CGnkspdOztMpQpCpuGmHqw8fvfNDngv5TqbuMlDQ0jlb79MJGfdQ7IvQaym5xj1xgPkZdhaTCFf5u/fLja3BxTuYeb2v5u8Dh6Zed6PWDcWvkMuqcMz+fY3lmPWHfIrlzz9wklLXI3VXtrVZd8+z8dic9SoSPPx1909rGCdpm/DhtYutvDy3SLCOL6za5ZvWNn4KJ8sS8dgRW6lCennwkyos6PBE17apyZJy9hjg+JTAcTYMQGFgQqAqsN/HJhpoQtX3XFp6k0EqE+L52j0Fm7jGJXPEMeOQOpYLywef2Uw3Z/isS+cB6aERmleqDK8LoleWSBBWmsZJavaaCgfw/qxeT5PKEfB+NSbnlvzqSThoYmCoEEknqzTUlEWkyZavP0KXsSVSS5PNan53ldoevUFU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WG5jL21RNFMyK3ZYQVlPUWpmOXRIY29FVmEyTVo2ekNhR1VHVjRxd0xRWVF1?=
 =?utf-8?B?Yk1lMUVzck1YUVZWekJFQlNidnJGSnhKR1pidkVCOVhqMGVrNHFVUzF5K1lC?=
 =?utf-8?B?TXpXaHlncVFKV1BWYmVnajZidDdVNnFZSVBhZmh0OTZrVDQwa0todXhzdEtK?=
 =?utf-8?B?VFBmQ2xsb2NZVUg4WCtKUDQvcmpsaWxHUVZaZmhPbWVtVHJ6Sk1xQ2tlUFlI?=
 =?utf-8?B?VXg3UjNrUHhRSitsZ3c0cGI3Z3gyMXNhc0N0dzQwNk0rdXluT1VGM3Z4VEZn?=
 =?utf-8?B?Sklyend0N2lOREx4ME5aRkRuR0wyay95RE9RcnRCdjNJRTVFc1h3WnNLUHh0?=
 =?utf-8?B?Q0VvREhPQjFFTDBSZTRuM2VlaHNlZW9uc2IyMkQ1TDVsb2tDMTNBSzh6Y3dZ?=
 =?utf-8?B?UC9wMFJWYzhualF6by92SE9UdUtaSGZBTEg0SFpIZG1FZ3k2TU5vQUZqbFRz?=
 =?utf-8?B?aGtscXFESzJkNnFpdnA0SDRpU0lyb29rMjA1ek9tQ2p0UUZseHVGbFN6d1BE?=
 =?utf-8?B?WWh2VXdteDl3MW9BbVdRQTI4OWorT0R1THJLY0RrazVCL1FpNnBXZTE1T05P?=
 =?utf-8?B?WXRzVFVkVCtENnV5NVZZUCtCNTNCMS9kWUFIN0NaL2ViOVNCWHd6M3NlK0Rt?=
 =?utf-8?B?QUYrSXh3cDBXL1YveElrcWJzUGhtcURSNVVNdGpHZXMxdVNjVjh5NWYxbGpT?=
 =?utf-8?B?aElVTjZqbnc2eHQ5UVRRNDZxRThnMjdyaGpBcHQ3ZVljbFY3MGEvUHBWWEk5?=
 =?utf-8?B?ZHowc1lTbjB0VmUwWkpia1VETkUrdWlUZEQvMXpRUFdkVktsTUJubGdwZU40?=
 =?utf-8?B?eVZSOGlzNlQ3bGZaNE94S3ZPWUhJMVZOcTNHcUJtczdNNmhwQ2pGdUQybUxJ?=
 =?utf-8?B?R3hDMkF6UTYwN1YrQmpSZndZM3AxYVBrMEFJTHp4aHJFT3FNbUhiVG9FbVFL?=
 =?utf-8?B?a3dDcGE5c0RTbjFtZEZDTmFxUkpVU00vMDhTNU13VHpsaVNISGhVSVBRaXgz?=
 =?utf-8?B?b0ZQRFdCazIwZnM2eFpFOGM2RzRnbGpvMWxHYmJtUDVLWHBKT2w1Rk5VSjZM?=
 =?utf-8?B?bkpGdHR6OUVnYXNVajdUZXVUVW5yU1hTSE9HNUFja3hMOGhkekdKbGF5aTBT?=
 =?utf-8?B?b3JJUnZyZGVpU2JLeDVPanJDUWV5YU8rRUJpSWZKQU8zbk9XWlpqbGFuRk93?=
 =?utf-8?B?bDFObGpieVY0K1dwMmV1V3JHMFJ6N1pnN1hlSHNkbVFqSTkvRElUbXZUeFFC?=
 =?utf-8?B?WlB4K0YzSmQrMDRiTVNGV2Zkbis0MmdENkdUTUZXWmU0NGxUVE5BdVVFTkgv?=
 =?utf-8?B?dG1FYmpTZFRnWSthRmYvNHltaEI0cnQ1QktzOExJS2I3dmtYMlRjNDdUekNj?=
 =?utf-8?B?MnlUbUlDT2lDQ0Fpa1BUaWdoRmI4YUxEVHlQMkYrZ2ZGRElJdndKd3FTN1c3?=
 =?utf-8?B?eHY2eStzZGVrL3lyUXd2ZndVMllKSFZZKzd4Mmx1UWgrMVBvVFFYSWhnRzZQ?=
 =?utf-8?B?T25LQ09rbzJWdk9xTFc5blRhSzROTThINU1KbjNtbGRma0JaeHZDc3diQVJn?=
 =?utf-8?B?SFdEWGN5b2NVbnB4R3k1c01INTE3TDZQME4wNjN5emQrZVBrU0UyNVpFYVFk?=
 =?utf-8?B?SkIxbnkzT3ZaL0ZTa2pmaE4rczQwWDF0ZlVKTG9lWDV6MzA5Q2YrM0p4TmZx?=
 =?utf-8?B?cENlTk1RM3BXb3VFRnNVbWNyVCtMd05LRXhoM3krUHJ2cjJwdFcvYTB6dTN2?=
 =?utf-8?B?VkFUSklUR2RkQTNNUUFuNEp4WllzY3l4U0d3dGdZaGJJZTBVRkdjU3QremNC?=
 =?utf-8?B?aHBJTmk4a3l5M1dKcXFEOG1SN3VxWTBhSytmWUdGWkx6amNCc29iYWJITkdo?=
 =?utf-8?B?V1o0RXI5Z2lkSEtmSEtjZldlRVQ3R3RURnREK0VoTjN4T0tRY2VPSzNZZjdx?=
 =?utf-8?B?emhXNnRNVjBTbGluUjhZdDhLVE1MdUdtSkt5STdncDRiTkZRVkdmSGV6K01Q?=
 =?utf-8?B?SEJOWGVkTHZQR1NUeE5FZ2FxVjVma2xDdFVDKzAwVElVdkdtU3RuME9KUnM1?=
 =?utf-8?B?TU5INHZJNXpHTHhYZjdkQ0kyTCtudE9JM0kzb0VpTGM5RE9yYmxFaDhTSGo0?=
 =?utf-8?B?Mk9KTUJLVDVxK2swbDBkRVZLMUFFWk9SbmhNL2xGRTBSY2FxeVNLNXVxMzh4?=
 =?utf-8?B?ZlYxVHBMWmovRFZUR05GTHBHTmgxUUNLYUV1NTdTb3V0VE1xZ1lYVHlCZWxJ?=
 =?utf-8?B?dTV6K2hxbFVTbHFVTnB4QTBKL2pxdjhhOVFtMGJ6ZXlmWEsvVm9Zd0pZZ212?=
 =?utf-8?B?TWlBUE50QzhYY1FsZnZ1anpjSU51b25VVzAvZGE4djBlM0V3bFUrM1M3QnJO?=
 =?utf-8?Q?h/kpWS2Phq4/hmTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B94C0DECAE9F243ABC1B465590F10CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BU7EWXzkATAxCn2McjXOlT8pYaLxkVN/IV0ZiyuQ6GJ77kG9Iy70iL/lV5ZJ9C5KOfVqLiDb5Yjg29B7HA0H9TgPs7WH7GryaKgGr2bHjcQgDQ6WaRiK6pYo+Bt0P1oOj4tkZGlFRtCRKrNHzieMuD5Ij0eNpP4z2Xx9NtPNL3JRssPXvVjIKWq8EPeuYaGyMyT4jZFEmJLrUrnzwl+CkZG1P1ZZt4pm60fVy5gd/jMLSloWX591nx7bu8c8Hc3QOPyizGiLdjcVDzPhxSAurhE7HflgBNrPgz+ur0q4owSGAMTfKPkLrSkdPa7PQxxpYRY1vmoyLIF4AtnNNgI5sg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AeCGye3NCNUxFZK06ICZX0gz+ydIT1Upi0RmHJYOyzKO05Di/XRFhQnobrvgSUy+94RO8mBV6k8ltvM0YPDRpqGpqRlYVLJjIxi+QPvyw8HUWfBJxNqoycFodsqeA66cZKJ6zj2aaDHmwxvFdYAIHK+0hRFgbPJ1pRz0i78Dx/s2zCPrFVrbaV2lKsHWJbut7SjJs3qFM7Iw782A46yHgfFfREY6NmvYh3/S6574xJsCh7A941vPJjsbM/LnFH73A8tvdavg7XQoAXKjmrBRWRc43MdMya6euFvFIYMpLkAQp+7wA0JOE4iQV27l/+kO312dMmZp22QXtdpZ8QO9ZXjERi500YfQGGovhspTAU4qRTO4GdfDbdtWCcA/jGTQ6Vs590+o/fbh7xjNaWeBhGQSymXj+6lAmQ5nj5YX9i35E2gzgBE8R5TiK4kEN+OYVNY3vC5kkZrb5BZ8BhUzCg5Bm5Ce3RBr43/SIS1Gg/cyN8JeA0RvdeHw7RrJjhl8lZ4fOgnb5wBgXQSrOybnRf3pZPwi+jCLAo22zFq7R5EZu6bmjGGCXoZluwSDzfGMXaToKsPYBKrNd5yHa3g6v5qt58069Bot9z3IPvlSe8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edaf013-7556-41f7-7d5a-08de84a90c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 04:44:31.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Rd6CN5KwNaXHPlzY3GUvp/+EZXU+bTH17itnIWz1dU8WDDXSwaETsCYbmKkkZN6GW4qkg0887WyYBzdmo4Ab7lyLmabIDw6JU4IAnLs5Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603180037
X-Proofpoint-GUID: L233r9WLcvLtw2aLIYB-woBwFBfbIqvx
X-Proofpoint-ORIG-GUID: L233r9WLcvLtw2aLIYB-woBwFBfbIqvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAzNyBTYWx0ZWRfX82bOx8bNmqPR
 K+yGmLqzrd0s7swvxpS51H72d5tYz1En2YL78MwhBSbjyJ14a/5OVbmryKDS49eAVL4uOFj3CxG
 NdLiDczsr5vXC+ewbEJp2nm8PHvg5R6v6ZLNrBO7+ko+xIdGAldDCNX6vp/cAQ0AG/hXqBx6NNU
 jgihNyIPy7oQvTqJ/kwhXMJmIvKM5pJtu7Q4o/gLHe1vyuGI5rJkO38AGvG4mHZjA421aYOux60
 nl/HsDYXyn8XS3l5WbPZqM0mZglj9SrRqw5QcebeIysi+0xB928LfNvt0agDyXncOSOn17DNHce
 HeAXoQkBt6cuPzs50kNp4vKpGcQ/2fKUABTKbeV1uMOiKWGaqP4VjzXBeTiUvTtLM3T/kGXBjfM
 Cztw/p1BJpY19n4f79C94yoI8AbbJVmzSNz1QrEEf2JLAtCr8X8Fs/844hUN4PrYY+oWfajeugO
 4zMbsxuII3UAfUpW9zuY72uSNWwQIY9X5GWhWHBY=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69ba2db4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=pKHraPMAlGpSlHMEaMcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13824
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,config.sh:url,oracle.com:dkim,oracle.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18289-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4AD312B5CCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE0OjU0IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxNyBNYXIgMjAyNiAxODoyNjoxMCArMDAwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBPbiBUdWUsIDIwMjYtMDMtMTcgYXQgMTU6NDEgKzAxMDAsIFBhb2xvIEFiZW5p
IHdyb3RlOg0KPiA+ID4gT24gMy8xNy8yNiAxMjo1OCBBTSwgQWxsaXNvbiBIZW5kZXJzb24gd3Jv
dGU6ICANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9y
ZHMvY29uZmlnLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcuc2gN
Cj4gPiA+ID4gaW5kZXggNzkxYzhkYmUxMDk1Li43Y2Y1NmVlODg4MmYgMTAwNzU1DQo+ID4gPiA+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnLnNoDQo+ID4gPiA+
ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnLnNoDQo+ID4gPiA+
IEBAIC0yNCw3ICsyNCw3IEBAIHdoaWxlIGdldG9wdHMgImciIG9wdDsgZG8NCj4gPiA+ID4gICAg
ZXNhYw0KPiA+ID4gPiAgZG9uZQ0KPiA+ID4gPiAgDQo+ID4gPiA+IC1DT05GX0ZJTEU9InRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9jb25maWciDQo+ID4gPiA+ICtDT05GX0ZJTEU9InRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnIg0KPiA+ID4gPiAgDQo+ID4gPiA+ICAj
IG5vIG1vZHVsZXMNCj4gPiA+ID4gIHNjcmlwdHMvY29uZmlnIC0tZmlsZSAiJENPTkZfRklMRSIg
LS1kaXNhYmxlIENPTkZJR19NT0RVTEVTICANCj4gPiA+IA0KPiA+ID4gVGhpcyBsb29rcyB3cm9u
Zz8hPyBUaGUgc2NyaXB0IGlzIGdvaW5nIHRvIHVwZGF0ZSB0aGUgY29uZmlnIGZpbGUgd2hpY2gN
Cj4gPiA+IGlzIHVuZGVyIGdpdCBjb250cm9sLiBZb3UgcHJvYmFibHkgd2FudCB0byBjb3B5IHRo
ZSBkZWZhdWx0IGNvbmZpZyBpbiBhDQo+ID4gPiB0bXAgZmlsZSBmaWxlLCBlZGl0IHRoZSBsYXR0
ZXIgYW5kIGFkZCBpdCB0byAuZ2l0aWdub3JlIGFuZCBFWFRSQV9DTEVBTi4NCj4gPiA+IA0KPiA+
ID4gVGhlIGlzc3VlIGxvb2tzIHByZS1leGlzdGVudCwgYnV0IHNpbmNlIHlvdSBhcmUgdG91Y2hp
bmcgdGhpcyBwYXJ0Li4uDQo+IA0KPiBXZWxsIHNwb3R0ZWQuDQo+IA0KPiA+IFN1cmUsIHNvIGNv
bmZpZy5zaCBpc250IGFjdHVhbGx5IGNhbGxlZCBieSBhbnl0aGluZyB3aXRoaW4gdGhlIHNlbGYN
Cj4gPiB0ZXN0cyBvciB0ZXN0aW5nIGhhcm5lc3MuICBJdCBtb3JlIGludGVuZGVkIHRvIGJlIGEg
c3RhbmQgYWxvbmUgdG9vbA0KPiA+IGZvciB3aGVuIGRldmVsb3BlcnMgd2FudCB0byBlbmFibGUv
ZGlzYWJsZSBnY292LiAgSWYgeW91IGxpa2Ugd2UgY2FuDQo+ID4gYWRqdXN0IHRoZSB0YXJnZXQg
dG8gYSByZHMvY29uZmlnLmxvY2FsIGFuZCBjb3B5IHJkcy9jb25maWcgdGhlcmUuICANCj4gPiAN
Cj4gPiBDT05GX0ZJTEU9InRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnLmxv
Y2FsIiAgDQo+ID4gY3AgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcgIiRD
T05GX0ZJTEUiDQo+ID4gDQo+ID4gQWx0ZXJuYXRlbHkgd2UgY291bGQgc2ltcGx5IGhhdmUgdGhl
IHNjcmlwdCBkZWZhdWx0IHRvIGNvbmZpZy5sb2NhbCwNCj4gPiBhbmQgYWRkIGEgcGFyYW1ldGVy
IHRoYXQgYWxsb3dzIHRoZSBjYWxsZXIgdG8gc3BlY2lmeSB0aGUgY29uZmlnDQo+ID4gcGF0aC4g
IExldCBtZSBrbm93IHdoYXQgeW91IHByZWZlci4NCj4gPiANCj4gPiBJIG1heSBzcGxpdCBvZmYg
dGhlIGNvbmZpZy5zaCBjaGFuZ2VzIGludG8gYSBzZXBhcmF0ZSBwYXRjaCBzbyB0aGF0DQo+ID4g
SmFrdWIgY2FuIHN0YXJ0IHVzaW5nIHRoZSBjb25maWcgdGhvdWdoLg0KPiANCj4gSG93IGRvIHlv
dSBhY3R1YWxseSB1c2UgaXQ/wqANCj4gDQpBcyBpdCBpcywgY2FsbGluZyBjb25maWcuc2ggZGly
ZWN0bHkgd291bGQgYWRkIFJEUyBjb25maWdzIHRvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25l
dC9jb25maWcswqANCmFuZCBwYXNzaW5nIHRoZSAtZyBmbGFnIHdvdWxkIGVuYWJsZSBnY292DQoN
Cj4gUHJlc3VtYWJseSB3ZSBzaG91bGQgYmUgbW9kaWZ5aW5nIHRoZSBjb25maWcNCj4gdXNlZCBm
b3IgYnVpbGQgZGlyZWN0bHkgbm90IGEgc25pcHBldC4NCj4gDQo+IEJ5IGRlZmF1bHQgc2NyaXB0
cy9jb25maWcgd2lsbCBhbHJlYWR5IHVzZSAuY29uZmlnIGluIGN1cnJlbnQgZGlyZWN0b3J5DQo+
IHdoaWNoIHNob3VsZCBiZSB3aGF0IHBlb3BsZSB3b3VsZCB3YW50IDk5JSBvZiB0aGUgdGltZT8N
Cj4gV2UgY2FuIGFkZCAtLWZpbGUgdG8gdGhlIHNjcmlwdCB0byBzZWxlY3QgdGhlIGNvbmZpZyB1
c2VyIHdhbnRzIHRvDQo+IGNoYW5nZSBidXQga2VlcCB0aGUgZGVmYXVsdCBvZiBub3Qgc3BlY2lm
eWluZyB0aGUgZmlsZSBoZW5jZSAuY29uZmlnPw0KDQpUaGF0IGRvZXMgc291bmQgY2xlYW5lci7C
oEknbGwgZHJvcCB0aGUgLS1maWxlIGZyb20gdGhlIHNjcmlwdHMvY29uZmlnIGNhbGxzIHNvIGl0
IGRlZmF1bHRzIHRvIC5jb25maWcsIGFuZCBhZGQgYW4NCm9wdGlvbmFsIGZsYWcgdG8gY29uZmln
LnNoIGZvciBhbnlvbmUgd2hvIHdhbnRzIHRvIHRhcmdldCBhIGRpZmZlcmVudCBmaWxlLg0KDQpU
aGFuayB5b3UgZm9yIHRoZSByZXZpZXdzIQ0KDQpBbGxpc29uICAgDQoNCg==


Return-Path: <linux-rdma+bounces-5570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B349B28AF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94988280C73
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA2190052;
	Mon, 28 Oct 2024 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jMzNhcwd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943C524C;
	Mon, 28 Oct 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100429; cv=fail; b=hySXU+ZxOENL9B/kF8BQCHpyRr7YdPX03mwaHMP51Nql1O+kvJmZrrjml33VyCg7GvAkb8UoLg4/BY3x8qGWBAeOz7EUT0VFwFkPl2yNJWR/haFdxm1oFMyjSattDlSwOulLdxKxHd8L+3VGbPv7oPlO+jyWkdPEtog3uvqjpr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100429; c=relaxed/simple;
	bh=zlaF3pRIDKfTeXmOEql/70Abbi7cgf6zbK+w3558NRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwzTAnduoroVKoI+U/zVkEEmKnGVA/WizC2POUz3LiF5Y+zN8UlIMAL6kZHq8DULipYT8mfy0BNPFuep58zt6aLbYWustQzDmH+P4BGPQXPW/Fnj4SPWl1ivf3u+vwmN326SLL+52EWZIMJuzdg7wgMHiG2T/yuKQqnzJnTFJXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jMzNhcwd; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730100426; x=1761636426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zlaF3pRIDKfTeXmOEql/70Abbi7cgf6zbK+w3558NRY=;
  b=jMzNhcwdOc3wg4lTS0nk6Gr15vt3TU8+IieZREvGTJ/H26IkrzCLALuS
   qkbTRinIDoY2v7Glta1yIhCuByt6HlmFxn7dvb/q5WMBHZDN8PmTjXYpb
   /4okfTRJbZ58s2njFP5RsSBmgukYsuBIrAlgKs4sA1Fz7mEiP8hmy+A2i
   FagAk0DhLgR+nrlhYvdJmlIMJrzVQrwLMMxj5S5iTiwe/sHtcasAMozMU
   /qbnxhMxSMiMA9J1CIW46EmSs5JPyFLUeUefG+Z0zVo1WFfOCYvYqWXA0
   wRiox31zSONOSekLcPQruRGuQ6fJmJWixGIw/v4qnspMD213EqMf96f7H
   Q==;
X-CSE-ConnectionGUID: yHGDq8fxTbyggZhzxissQg==
X-CSE-MsgGUID: jOtVRYRcRpOwZyIYj5pADQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="135012583"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="135012583"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:25:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmEF4F5icNWf4bkSPGnytPmY8UwSqhF5Wn5w8bYDlHL0m6LlrmyjLLbQvXVsCwRLo9ifx0jTy2qA3WgCwtwvCDjx8kCOO60KFEcXcjH6nXadvcZzkK0RXIS1F38LYn/rHbl8eDnVFWZ/F4XTTch2vDGbhV3GFBF/46Osx1zqjyozHrKPb2pW9LpliOKzoetfuUMJxU94heMy1UlSK814WI4lJISigGSSw9QG068JREO3F4S/oQULhwFdCpeVtmMXNsTPhF2XCa0HuTxioae9nXasob0QhsnYo3/7xPVH+hjFOzLCjfcXdzMIt9cB3DAMMQydzM9L2Ya7tP7W/76oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlaF3pRIDKfTeXmOEql/70Abbi7cgf6zbK+w3558NRY=;
 b=sEVc1oofXSvsz/1sExdc1IsWdcikCU4stAMIrH2ESjar8ViVBURSMSSYsUze9Vy2cjqqTuWTH2LDFpLhYEXazIrHfdFvBMK8jfjT5c8tpUrXNZJ0q3npCUE9mbolzk8OcCQ3+viINosouJMajHsc73XjDkSd+G23J8twunnsFZNHm26jn7dN0xoyb4zRiC8W5BaVyyJOp7s3zwLlHjCx1KvRfE6nm1DVd41582PAuJqSDEDSdhWFqL49brR8Q7uArFx6Ld3F2DOzmDZ4ej+YP4HlyFFMraE5s4u+bAM5FamuNjkzc0Ua1EwBvPvXFd52ko70h4n2jELE3ecyYErFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 07:25:50 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 07:25:50 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Topic: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Index: AQHbGe7gxkmvLoNIN0q2dVdbsLfwpbKEOsGAgBegpVA=
Date: Mon, 28 Oct 2024 07:25:50 +0000
Message-ID:
 <OS3PR01MB986527D371D3840D1534A555E54A2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
 <e4d71ae6-0a90-4fed-9ab2-6c0abec52756@linux.dev>
In-Reply-To: <e4d71ae6-0a90-4fed-9ab2-6c0abec52756@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MDA3ZmQ5ZmItY2NlMS00NmY4LWJjMjYtNzc3OGFmNWM2?=
 =?utf-8?B?ZWRkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTAtMjhUMDc6MDQ6MzBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OSZPR01MB7049:EE_
x-ms-office365-filtering-correlation-id: 33dcfdad-cfc2-4bb9-29cb-08dcf721bfb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDB4N2NFR1pEUHZCM3BNQUtGdnB2RU1QY0tvekYrM3FibEFsVmRaQnVZS0du?=
 =?utf-8?B?Y081SlVvTUkxMkFndFlSR3ZWcnFNVGFlU0ZFYWxDU1R6S3lvQ0s1UnZ4cGVQ?=
 =?utf-8?B?ckZVK2oxbGhUZy9mMFVnaXhVeWFDMG4ycFFyS002VGhhWFlJUEVPU1dYUHFp?=
 =?utf-8?B?V25qSFluYkFTcklXZ3NlNktyT1NyaTRiUExlWXNuVVNCWm5zbVR0NXlZam9K?=
 =?utf-8?B?QzFLOEczRFI2aWUrWE41SlNQRzFVTW0rc09uQjNoNEhOOUM5UzZvdzZOckFN?=
 =?utf-8?B?M2YvWXJndG41YUozQkNKR0ZjenQyM25uTG1CQnJuVHN1YnQ0VVNFYmlVMHZY?=
 =?utf-8?B?TzdjTytpeWNVZms3VFFJeWFkVml0R3JHLzBJTnAyVXRkK04zN2toMFVDZjRj?=
 =?utf-8?B?T2NoaUV3UG0rMnlTUXcxT2s3U2VFWVcyOFRRT3I1eHB5UC9HTFo1RERPUC83?=
 =?utf-8?B?NEhBQnlZL1NoeG1CbE5wTFoxMjlmSlViWnhWYzRPUHpUNW80Ukp0ckd3bEpB?=
 =?utf-8?B?cFZoOWxjaG5wZ2Z1TVVUelpYRmZWaHNRc0hkaTgrUTlIQVJtV2JpSVluYnNB?=
 =?utf-8?B?WE9tOWQzUXpwanlZbU9EOG1uUzVubzhBY2U4a1dxa2hyU091NUZ6Qk1DbW00?=
 =?utf-8?B?aXNDcGxXSHR6Z3V4elBMRkZFZkx6bWVNRnd5MWJCaCtMcDF5VFByOW5Kd1Vh?=
 =?utf-8?B?UFNTLzBPL01ZYitIZ1NmbUtnblJCWEh3M1pvSG5ybElPZExNYmVyQU96T2pR?=
 =?utf-8?B?elB0a3d6YTg0UFZrM1VZZVRuQ3lKd2lITXJwK1M1aWZpRDZYdmRrVGwreHEr?=
 =?utf-8?B?YStGcnZScVdZeFRkTU81czFiL082RDlqcUZVNVlBL296TGRPaTFDYWZOVksv?=
 =?utf-8?B?NnVwR1NETXVvN0JBTkRCNmczWDVQVStxT0pJZk9jK1ZQR3NOcUd5K2syZ1dz?=
 =?utf-8?B?OHBseGltWGd0aUJFVVV6YmZodTZtcWxvWldpRUlVR0txRWx5aTE3N3FTMFBG?=
 =?utf-8?B?V0lKQnVYdzY2Um1XbmtEZGE1MGRvWmx3T1pQaUMya0xiYW5iSjVRTHRPVW1M?=
 =?utf-8?B?aXpSNWJWditvUkU2MmpPcFRqZ0JZYjc2YTU0eFA0RGZZREVzQjR3NmFybVJI?=
 =?utf-8?B?QVJTeUJ2dy9jMTY3WHZvbWNhL2JtV1Y1QUhDenQ3OTVDVG41VHErVFE0VmJn?=
 =?utf-8?B?UzArWFEzNk5kN0xRK1lnVUVnVHd2Skkyc3k4WVI4dXQyVGZsUlVLOTN0dTVw?=
 =?utf-8?B?NUNIaFQyTm53VFA1a21CMGVKSzBHYlp5aENsMDdkd2NmTTlERGU5cXRzL1dE?=
 =?utf-8?B?NFF3dWdzL2VBcFdrdmpQY1daa0d6VzVGOVdJZW5VaDBZODhQUnRqNHlmSVdr?=
 =?utf-8?B?YmlCT0pZUEdKZW04NElXRzdjS0ZndGVGQmUvbzhubnByRVlUc0paenhVUW5n?=
 =?utf-8?B?VzEvbkFlM3JEeG1EZG0zTkJyUzl6TTgyK1dIc0dDQkhiYWs2emM4Z2tRZFVB?=
 =?utf-8?B?RXRkWUV4Y0tmenhoZGJFSjdma1lvNFl3c1Y5K0pzVTFnenpUMVkwMFFBL01S?=
 =?utf-8?B?WDhzUnhnZ2g2OXJoMU8zbUo1OEhObHQ4aDVFNFVCaGJydjdReit6S2ZQdzB3?=
 =?utf-8?B?ZndNZkFVWWxPRkYyWVljYWxEYXR3cjdyKzhDSlZ1bFNTOUNGa2VHK04wOEVK?=
 =?utf-8?B?b2N4cXJ6RTVMMDA2SW9qc1RjMzRBVDJBdUc3S0poL3JZUHJ1d2xuYWQ3ekox?=
 =?utf-8?B?UGlLSC9wdFlqalJJb1g5cVVCdHlDa3BpSUgwcCtWSzhGaVhCNHU4L3dEL1N1?=
 =?utf-8?B?UUlJeFVMYXJXSmJjSVg2Y2dKUDk2QTB2eE1BSVo0dFlQQnVjSXkxSjNmOEoz?=
 =?utf-8?B?bnRZaG1vVjNvZW5HN1lIMHNSUnFOem5mNEZmUTUwWm96Y3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1ErTTVQb3hURjhwSTZmam1PZzhDWDNYcStOQ0E4UXFCdVNlMkpnakc4ZTRr?=
 =?utf-8?B?dzdFYlRMWGl5U2pwWFV3K1FFRW9QR3pSczhXZUhhN3h2THMyZU9YMGozZWwz?=
 =?utf-8?B?TWMzTzVreTRTQVBnTzBMdEphRERMeHI1dmZMSWxrNkdnV2ErUkJCZ09OeE9N?=
 =?utf-8?B?cDF1Sit4dmpGT0FNM2U5NkN3ZDVBbWlNa0NHQlhXbWpMcWZtcjlaTjJIZ3Fp?=
 =?utf-8?B?N1VMdnhlRlNCQ0Y2VWVkTXUzY29SUkVwYnhjNVhNKzg0UHNpRDFKWGhiR2RM?=
 =?utf-8?B?bS95c1NWSzUrcUxFeVhvTS9KSDZIdVUzUllJTkY2QTl3NnBabUw3OGlSSUwy?=
 =?utf-8?B?ZTRkT1MvMWViU1pRMjBxK0hyQlJSY3o2dzNSZjF1bzNoR3NjcHJoV0tUdFlK?=
 =?utf-8?B?YnFLSVZ2Nm14bGh4R3QwbGIzZytpTFFDeEMxSGhjMEVGUTZ6NXFRVzYyNm1k?=
 =?utf-8?B?TzEzNnJaRXlSSkhtR3k1RHJ5SVpCcHpOdVMza3d5T1BzbHU2RmZhWWNBejQ4?=
 =?utf-8?B?RXpiZE1MZGxudEp5T3VDdjBzNTRKcWdra1UzRWtaOThCMml1SDNIZWtUa2FQ?=
 =?utf-8?B?TVMvS0VGc2VOb1JyVjJBTjR2YlRwL0F4TTQ0cFN6YVFsbk1rWDFqcmJXT0Ur?=
 =?utf-8?B?VmhTL3d6ZDY3N1huOHByaW1HZm9OdXdHeCtQbU96Z0lNYU5sWjNKTVY2blRT?=
 =?utf-8?B?QjUvMnQrOXVHd0ZJYlgza01MdTlLb3VTYjNoMmh5RVhqUUFjSy8vQWl5R2Zy?=
 =?utf-8?B?VlNHOGU3dWw5Q3RlL0lsbGxFNDVVUHpUVy92VnNWNzd1SGNMcUxIUExQU1I0?=
 =?utf-8?B?Njg0aFdaOEJCNzRuYnJaODhRUjdUTnpod3ByV3k3cjVCL0tHMEk1cHpVWVZJ?=
 =?utf-8?B?amVPcllJNE9HWXZ2ZGNiTGJnL2IweW4vZms2c2NhZjFRem1rODBpeXVWVTRk?=
 =?utf-8?B?emU2WjJnbVF6YjhHd2RqanpSRFRlN2o0TjRrMWdwL1RXYUVydVhSN1czRDEr?=
 =?utf-8?B?MHFGa1JTZDhpUHptcWtZdnFlalJTOVMzQk0zYk9LbnFYeWdzTDJpNENqS1NS?=
 =?utf-8?B?R29PVDQ4dG9JWnA1aVIySVhkbk9WUThzcFVpQUJhR2lMMGlBL3hnRHZFTTI0?=
 =?utf-8?B?M3MyWUxaekJBSUtIWURhaXBwS3VwWDBIZVNNRWJRbm1mTHVVcjU5YWFFWmpw?=
 =?utf-8?B?Y2ZBRlVrTXBBWnZ4c011YzBxd2pjUEQvZ3RkM0RTMUw3MllFdHpkT05QUTI1?=
 =?utf-8?B?VGhhODR2eHBpZWR6Vk9ZdmVBbWYzYWFQdG9WNDZSVmhVaXhGUXB5c1ByUDJO?=
 =?utf-8?B?ZWN4cnJETVJNTnpUb0R4NUtJVlJ5QmlLTXlvdC9DeGZUckx2MlRHcmVUSUVr?=
 =?utf-8?B?MXErYkhxby9PeTFnWEVyOGMxdnNlZThTckgxVEdKamEzZWROUE9qU1ViQ3FO?=
 =?utf-8?B?aHFSNzRmMDM2VC9LRmVtclhjaUloQTdSS2hNckNxVllma09hRUFYVVhkNjF2?=
 =?utf-8?B?d0g2dUk2dlI1NHNlamJyVGhiblpQdVBhTHNHZGRRT3lwVDVCdUcrVHdGT0Ir?=
 =?utf-8?B?RGdaaytCcGoyVEVNNmwzRWxRWUpFMjB2b3lsS0JNeUVNbjgxSnQ5U2x5dVNZ?=
 =?utf-8?B?ZC9sRXBqVnI2eUd4c1laakk3UlRJcWhNREhNVmNmMVRSUlVmV3NDU1o3czUv?=
 =?utf-8?B?QzZPYnZtOGd0YVVPaFdsUGM5a0gvZ1E0bEc3VDNkYTk0eVdkaHU4Nzc2eHp3?=
 =?utf-8?B?TUt5WHFnamhTUmZUWWk2QlpiNm5vdzBCcjRsNnp0NHZvcWN1WkVYOHdhUGdH?=
 =?utf-8?B?ZE8vWlVCSzVzWUxSeFRjRmFpV3U4eStibTR1ckJzV09LdzNsNzhiMWZLSXNO?=
 =?utf-8?B?VHZoM21Eb2JYMWhwVjJWbU9QelA2ZTArQXhYZmJvUWlwZlZQSGFBL2M4WDlL?=
 =?utf-8?B?d0hDa2kyU3Q2b2FTbU0yYUU0NmE2cUhZSnhoVjJZZEhFQ2ZRbXFNUEU5R0Nt?=
 =?utf-8?B?My9JWldxenAwZy9YeDUzYjFVU0YxdzZiTmYwb25JVE85MlZ6ZnN2TkhGRzFL?=
 =?utf-8?B?Y1M0Wkx1d2xLa2hYdWZBVks5QjdWWDN4M0UvUTVHeWRqR25RZnc2dlp0aEVG?=
 =?utf-8?B?endkaUptMkE2SDNFRlJDRGE0WWlTdUFjajhuWnZGSitRRVhrSEtHSjZXQXhX?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6IqacY9dCnMuDSB1LWP3fpDfCqSxz0iQgwo/q1ddslm3r86UInyZyB73IRMOl1+sF9+eJM483PloDbFUkE7+HCopMTo0O/eHoyp5oo+wV1pxNTlSccZO/uj3RNjfBNkEL0A6YZnDM7Ce+3sIOUU0SWALrVdWw7/ymRqScsJrUCa8KJbOSXTTi+0jpBXTnMh0+0xJb1RS2lpAqDZ0/JQ7IxXDcrkUf8EJJPk2xDCjXxX/c1yQVjA0aI6foHUkOTJy63yshhOUzzHDP9zR9rhXqB/ThgmayZqLD/fqnywVc4pcGLEBiBic0RXUuUCvDsbJA+nQodWTi/GVQUjmi0tL0R5pjGWxVDYLTDm/l/lUU9nlVefQ0DufF16htjGFdQhqxm4Qm3m3Zw82IcdMproZLLOASh2DXcQh0k5BZdYZovqVW+3can51Pt3Taid7fm5DDkDUimKs0JujRF9ntP7hgh4jqOqQ2ANhRzKPGOPgOo78r9gQfAvVmhsg2f9yXrguswMWV2eR1A6iqiYv3OaBj41BIJlU5h1mDP3uAha0/EtFQfx/9Dp0AB4eIcmq/lcHq8lHaHeoUyGY9WuTkIBldVYNMA7cpqsbBTvmOdhzoJ54KKLjNFL7IIxPoKUtfISp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dcfdad-cfc2-4bb9-29cb-08dcf721bfb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 07:25:50.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROheCTXI65wVyBAFTDPU2xqMQjuaVqD7rHipND0OX4cppYEJGFuRQg8fpfp/MyqshELrSEEp1Qwa8o7FgDf38ll3zjiSN2pnxFAX0I+hzjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

T24gU3VuLCBPY3QgMTMsIDIwMjQgMzoxNiBQTSBaaHUgWWFuanVuIHdyb3RlOg0KPiDlnKggMjAy
NC8xMC85IDk6NTksIERhaXN1a2UgTWF0c3VkYSDlhpnpgZM6DQo+ID4gT24gcGFnZSBpbnZhbGlk
YXRpb24sIGFuIE1NVSBub3RpZmllciBjYWxsYmFjayBpcyBpbnZva2VkIHRvIHVubWFwIERNQQ0K
PiA+IGFkZHJlc3NlcyBhbmQgdXBkYXRlIHRoZSBkcml2ZXIgcGFnZSB0YWJsZSh1bWVtX29kcC0+
ZG1hX2xpc3QpLiBJdCBhbHNvDQo+ID4gc2V0cyB0aGUgY29ycmVzcG9uZGluZyBlbnRyaWVzIGlu
IE1SIHhhcnJheSB0byBOVUxMIHRvIHByZXZlbnQgYW55IGFjY2Vzcy4NCj4gPiBUaGUgY2FsbGJh
Y2sgaXMgcmVnaXN0ZXJlZCB3aGVuIGFuIE9EUC1lbmFibGVkIE1SIGlzIGNyZWF0ZWQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWpp
dHN1LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZp
bGUgIHwgIDIgKw0KPiA+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmMgfCA1
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
OSBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfb2RwLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL01ha2VmaWxlIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9NYWtlZmls
ZQ0KPiA+IGluZGV4IDUzOTVhNTgxZjRiYi4uOTMxMzRmMWQxZDBjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL01ha2VmaWxlDQo+ID4gQEAgLTIzLDMgKzIzLDUgQEAgcmRtYV9yeGUt
eSA6PSBcDQo+ID4gICAJcnhlX3Rhc2subyBcDQo+ID4gICAJcnhlX25ldC5vIFwNCj4gPiAgIAly
eGVfaHdfY291bnRlcnMubw0KPiA+ICsNCj4gPiArcmRtYV9yeGUtJChDT05GSUdfSU5GSU5JQkFO
RF9PTl9ERU1BTkRfUEFHSU5HKSArPSByeGVfb2RwLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9vZHAuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi5lYTU1Yjc5YmUwYzYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmMNCj4gPiBAQCAtMCwwICsxLDU3IEBADQo+ID4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIExpbnV4LU9wZW5JQg0KPiA+ICsv
Kg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjItMjAyMyBGdWppdHN1IEx0ZC4gQWxsIHJpZ2h0
cyByZXNlcnZlZC4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvaG1tLmg+
DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8cmRtYS9pYl91bWVtX29kcC5oPg0KPiA+ICsNCj4gPiAr
I2luY2x1ZGUgInJ4ZS5oIg0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcnhlX21yX3Vuc2V0X3hh
cnJheShzdHJ1Y3QgcnhlX21yICptciwgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gPiArCQkJCXVu
c2lnbmVkIGxvbmcgZW5kKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHVwcGVyID0gcnhl
X21yX2lvdmFfdG9faW5kZXgobXIsIGVuZCAtIDEpOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBsb3dl
ciA9IHJ4ZV9tcl9pb3ZhX3RvX2luZGV4KG1yLCBzdGFydCk7DQo+ID4gKwl2b2lkICplbnRyeTsN
Cj4gPiArDQo+ID4gKwlYQV9TVEFURSh4YXMsICZtci0+cGFnZV9saXN0LCBsb3dlcik7DQo+ID4g
Kw0KPiA+ICsJLyogbWFrZSBlbGVtZW50cyBpbiB4YXJyYXkgTlVMTCAqLw0KPiA+ICsJeGFzX2xv
Y2soJnhhcyk7DQo+ID4gKwl4YXNfZm9yX2VhY2goJnhhcywgZW50cnksIHVwcGVyKQ0KPiA+ICsJ
CXhhc19zdG9yZSgmeGFzLCBOVUxMKTsNCj4gPiArCXhhc191bmxvY2soJnhhcyk7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyBib29sIHJ4ZV9pYl9pbnZhbGlkYXRlX3JhbmdlKHN0cnVjdCBt
bXVfaW50ZXJ2YWxfbm90aWZpZXIgKm1uaSwNCj4gPiArCQkJCSAgICBjb25zdCBzdHJ1Y3QgbW11
X25vdGlmaWVyX3JhbmdlICpyYW5nZSwNCj4gPiArCQkJCSAgICB1bnNpZ25lZCBsb25nIGN1cl9z
ZXEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9vZHAgPQ0KPiA+ICsJ
CWNvbnRhaW5lcl9vZihtbmksIHN0cnVjdCBpYl91bWVtX29kcCwgbm90aWZpZXIpOw0KPiA+ICsJ
c3RydWN0IHJ4ZV9tciAqbXIgPSB1bWVtX29kcC0+cHJpdmF0ZTsNCj4gPiArCXVuc2lnbmVkIGxv
bmcgc3RhcnQsIGVuZDsNCj4gPiArDQo+ID4gKwlpZiAoIW1tdV9ub3RpZmllcl9yYW5nZV9ibG9j
a2FibGUocmFuZ2UpKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwltdXRleF9s
b2NrKCZ1bWVtX29kcC0+dW1lbV9tdXRleCk7DQo+IA0KPiBndWFyZChtdXRleCkoJnVtZW1fb2Rw
LT51bWVtX211dGV4KTsNCj4gDQo+IEl0IHNlZW1zIHRoYXQgdGhlIGFib3ZlIGlzIG1vcmUgcG9w
dWxhci4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KSSBoYXZlIG5vIG9iamVjdGlvbiB0
byB5b3VyIHN1Z2dlc3Rpb24gc2luY2UgdGhlIGluY3JlYXNpbmcgbnVtYmVyIG9mDQprZXJuZWwg
Y29tcG9uZW50cyB1c2UgImd1YXJkKG11dGV4KSIgc3ludGF4IHRoZXNlIGRheXMsIGJ1dCBJIHdv
dWxkIHJhdGhlcg0Kc3VnZ2VzdCBtYWtpbmcgdGhlIGNoYW5nZSB0byB0aGUgd2hvbGUgaW5maW5p
YmFuZCBzdWJzeXN0ZW0gYXQgb25jZSBiZWNhdXNlDQp0aGVyZSBhcmUgbXVsdGlwbGUgbXV0ZXgg
bG9jay91bmxvY2sgcGFpcnMgdG8gYmUgY29udmVydGVkLg0KDQpSZWdhcmRzLA0KRGFpc3VrZSBN
YXRzdWRhDQoNCj4gDQo+IFpodSBZYW5qdW4NCj4gPiArCW1tdV9pbnRlcnZhbF9zZXRfc2VxKG1u
aSwgY3VyX3NlcSk7DQo+ID4gKw0KPiA+ICsJc3RhcnQgPSBtYXhfdCh1NjQsIGliX3VtZW1fc3Rh
cnQodW1lbV9vZHApLCByYW5nZS0+c3RhcnQpOw0KPiA+ICsJZW5kID0gbWluX3QodTY0LCBpYl91
bWVtX2VuZCh1bWVtX29kcCksIHJhbmdlLT5lbmQpOw0KPiA+ICsNCj4gPiArCXJ4ZV9tcl91bnNl
dF94YXJyYXkobXIsIHN0YXJ0LCBlbmQpOw0KPiA+ICsNCj4gPiArCS8qIHVwZGF0ZSB1bWVtX29k
cC0+ZG1hX2xpc3QgKi8NCj4gPiArCWliX3VtZW1fb2RwX3VubWFwX2RtYV9wYWdlcyh1bWVtX29k
cCwgc3RhcnQsIGVuZCk7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZ1bWVtX29kcC0+dW1l
bV9tdXRleCk7DQo+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArY29uc3Qg
c3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllcl9vcHMgcnhlX21uX29wcyA9IHsNCj4gPiArCS5p
bnZhbGlkYXRlID0gcnhlX2liX2ludmFsaWRhdGVfcmFuZ2UsDQo+ID4gK307DQoNCg==


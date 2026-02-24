Return-Path: <linux-rdma+bounces-17092-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBELLewvnWkDNQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17092-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 05:58:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F00181C1F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 05:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BEA3065F3A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 04:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9B27BF7C;
	Tue, 24 Feb 2026 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="uHNm7eR5";
	dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b="gvTuZiGZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0e-003ea501.gpphosted.com (mx0e-003ea501.gpphosted.com [66.159.227.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62B33EC;
	Tue, 24 Feb 2026 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.227.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771909096; cv=fail; b=HtFwFd3tKETEpwSQkAOKO9XpsDNDn8ZbDhOUU11EpxhXi2ZwvsZkd5kj5rFYnUtkuaq6aDrjY0nH3UHGrUEWMHMYp4j2P0Ni6NILHAiQCphCnTTQ5V4WzWKkiLgWKr1+ufBv1gRsXD9RVwj/kei/JQhgr0LZKlCNWYMOWSECuq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771909096; c=relaxed/simple;
	bh=j1vadhP6+Q0D64N/ZqkUK7ToELZ2Lh212NwbVH9DrWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hs6VJxgMOrV/zf5GItxY1puFIwqg2FwTdsqZGJnRBpcPJHnEnqmDxEouH52WptjaRHxmUVtoX62/XaiqIEt7b/dOuY9id0quLVvnMR6aK/QkiEpto+3LNy69evclhtB1FNScELxrBrySG5zuwklwRB+idDi64/gcMVHgI6EZGAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com; spf=pass smtp.mailfrom=spacex.com; dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b=uHNm7eR5; dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b=gvTuZiGZ; arc=fail smtp.client-ip=66.159.227.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacex.com
Received: from pps.filterd (m0418029.ppops.net [127.0.0.1])
	by mx0e-003ea501.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61O4BZVn014835;
	Tue, 24 Feb 2026 04:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=dkim-cloud1;
 bh=j1vadhP6+Q0D64N/ZqkUK7ToELZ2Lh212NwbVH9DrWM=;
 b=uHNm7eR57hMPkeu+o1bCniUXGdSCxDAUZz8er9zK/kneIxWshcGxrez9ED/7xRY6hdwA
 UsfmIqShK98Zvl4B/FezAca5AbUruxWfXKArtdbYuIeyoM7Yvms7WM8qJs0BaXTQkksx
 h/qhppW0X9t++xEEbcmQ+s+kZnD9J4mzVIz99xRzDY0+GHOFhPlLnA5wqlyW/X2lpJk4
 uS3tHcPwIRiPcG+rKkNAG5MAhILXPp4R4kpcO2PdI1ZNTxbpuUz+cQaWWXhx+E4u+fsY
 XwaDKAJjet87Yaq622YwzslixbsZXe5BM1vQRq2KMeyvqvVgJTHcWaFLAYmyZOV6vtdc FQ== 
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02on0051.outbound.protection.office365.us [23.103.208.51])
	by mx0e-003ea501.gpphosted.com (PPS) with ESMTPS id 4ch3m7g3up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 04:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Nemk8HR6cAc5GCi+tMV2VTKCW55mXRE1X3jETicw245tuc9wcuhhJi31zRt+qOq9RkZsw2nsZQyRuvQwTcS0rcbpyvhlCt7cL543HSb9DbWIX++V4VXpjKWp1G9Cfoah5gu4svBovCZnTGVfxM/mFc9W+8AmO3oKomV2kKjPZd0KQ7Cd4SQV3ZFyY3OKc+LswEcKA1J5lH6+U6/ehhKXtCW+URuDMNIkFx/IMLKEkGij8jAGyJPl1uOyeYUx4QrgJ5OzAwZ0Wqp4NqpjdQ11kzcSVPlsNq8yUeV7QS2YvUvfPG3zG21lsmiEFSYxveErWPx05iAEKskoWLilC1g4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1vadhP6+Q0D64N/ZqkUK7ToELZ2Lh212NwbVH9DrWM=;
 b=JkYza2pkxiEM/hTZ3AIdR8ym3Ycqs2Ja8cVFgcGlWWn2XJQRCLpksBBgsskzqK9gTZC7udIfpc0D/GdLLoValCDfZzRuETA1BZGsN0x8BcfLS8q3arNvVmw8PrdumjpWL5+F07ItrddExjaWEPWVQY1eLoUOUVG2p4ZU0vE1loion/bbiihBE5s8VI71oK5M4maPN2vH7ZIJ6FbirTp3htqy0masDhG91LioLdLmIBNxT1vhEjZSwWA15fr3vsJAoR+lOVAm87sa9nFUmnvdqH1YykbRu3AhrtkD0wooBAeCvUMbzE3v60S7Kynh1+Bqs1G7yu4/+anYdUw122QqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spacex.com; dmarc=pass action=none header.from=spacex.com;
 dkim=pass header.d=spacex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spacexgcchigh.onmicrosoft.us; s=selector1-spacexgcchigh-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1vadhP6+Q0D64N/ZqkUK7ToELZ2Lh212NwbVH9DrWM=;
 b=gvTuZiGZvALKyaZW/jgUE91sx7dzFBMkM9XhaVca2NtxyOu+q1Ws4L2FVyN7sih0bJqruzl1wR2QIab8g59iXMNjOLAUXb8j2FPMXWa/rHMaQZyCnQ4RPdRnp8WR+9mjOqBimGCmAvTI/8z2X55tcdUcR1QYrvu2Dpq9HV8yTMoX4Vlqr6OFdxznCD5s8FHf0TNQDY4X7HYQ+x5Rk7nlZoJkH9lkFDyZEVYAlihf0N0sHJ7HSYCctEQnVDfA2oobkK7AxSULRtIshSjbiTXHn5XqBA5vTrDgIhNhqU89uLDExaCO4iKot4yePsu0We2gPQD+xP0I0FDedwh3H+qP3Q==
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18d::6)
 by SA1P110MB2040.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 04:32:54 +0000
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d]) by PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d%4]) with mapi id 15.20.9611.013; Tue, 24 Feb 2026
 04:32:54 +0000
From: Finn Dayton <Finnius.Dayton@spacex.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Alexei Starovoitov ," <ast@kernel.org>,
        "Daniel Borkmann ,"
	<daniel@iogearbox.net>,
        "David S. Miller ," <davem@davemloft.net>,
        "Jakub
 Kicinski ," <kuba@kernel.org>,
        "Jesper Dangaard Brouer ," <hawk@kernel.org>,
        "John Fastabend ," <john.fastabend@gmail.com>,
        "Stanislav Fomichev ,"
	<sdf@fomichev.me>,
        "Saeed Mahameed ," <saeedm@nvidia.com>,
        "Leon Romanovsky
 ," <leon@kernel.org>,
        "Tariq Toukan ," <tariqt@nvidia.com>,
        "Mark Bloch ,"
	<mbloch@nvidia.com>,
        "Andrew Lunn ," <andrew+netdev@lunn.ch>,
        "Eric Dumazet
 ," <edumazet@google.com>,
        "Paolo Abeni ," <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Topic: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Index: AQHcpFgVNrGrdkK5lkuK7XP5p1ZbYbWQTN0AgABxnwA=
Date: Tue, 24 Feb 2026 04:32:54 +0000
Message-ID: <5D5DF105-22C6-42C5-A9B9-14C0DF9685EA@spacex.com>
References: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
 <e24b4a4f-b7e7-4e9e-ade0-cdda06f5765a@gmail.com>
In-Reply-To: <e24b4a4f-b7e7-4e9e-ade0-cdda06f5765a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1186:EE_|SA1P110MB2040:EE_
x-ms-office365-filtering-correlation-id: 2eaa7fd5-cd04-4023-355c-08de735dc72d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVFKdUo1K0pmWHdYblhZTFNxWGlaT3VwTnE0OWdNb2VQUEloZ1ZBa2lDVEh4?=
 =?utf-8?B?L3IvTjRHYWFMVzdQZ1Y4VFo5ajZBeFRuY2pscnk2bUpYUTBXZHBrYVJCN0Mx?=
 =?utf-8?B?SGttMUxucFY2Qm81YWhRN3d3WWlvT25JUkVtcG1sN1FxWTdyTi9oeHkyczl0?=
 =?utf-8?B?aXZmWG5mZmJFM3IwdlRHWUF6WlN4ajZRb0ZuYng0aHJUeW5VZ25LRGx3RGdr?=
 =?utf-8?B?Vjg4NC9teEd3eG9mSkp5dGZWUHlYMm5TRngrT1FyYzFCVlhxeFJtdCtuNGNQ?=
 =?utf-8?B?Vk5LRzlnRUpJcWY0S1dvaThHemFlK2NVYnFXbDFZZG5PMVZCN3ExSWx2Qmty?=
 =?utf-8?B?bG5BQ3JsT205ODMwdUFBN2tKK2l4bDFPU294QjlGc1RFdTB0eVpyK1V1LzFk?=
 =?utf-8?B?OER0cnNCdU1DZFFqOEVtSU1oSTVVSmt3UzBGd0JRRWZydENad1NTU0xCeVBU?=
 =?utf-8?B?NyszNUcyZFdVeGREYTRQUmxncCsvajhIRmF2TzNEMzdTWnViV1BudUtLYnNj?=
 =?utf-8?B?anlYbDI2NkEzTVgxVkdsVDVYeUhRWElTNDljbDBwS2lBa1pMZVVvM0hWNHJq?=
 =?utf-8?B?Ly9Sc3Brc3BvdUo2SkJaejk1SUxDTlBha3kwRmNLYTRaOUN1YnZITHVyWlFn?=
 =?utf-8?B?MTc4MTB4M3BhcG0zRkw0b2s1M0FRWm1PMWpZVTR5Ty9taHJtNURMYkM3TDVZ?=
 =?utf-8?B?ZS9nSWcrRUtLZitjUURFbnBTNloxSjN5ay9MZ0t6aVR4K3UxMjBWTHZiK09Z?=
 =?utf-8?B?Y29HMy95T1RlN0FDSXI2U2xuWjV0YmZQanhQakpDblBjOENQYjJMRW1tY0hq?=
 =?utf-8?B?eXp0czFWUUIxeVNjSTJvd1l6emkzZHJ6bmdwVzhFTXNZcGU5cnkxK1oxOWx2?=
 =?utf-8?B?Um1xTVllVVErSWwzVjdrdmQvVU9lb20vMk5zbThwNmVia25xWEZac3Vtd3pJ?=
 =?utf-8?B?Qlp1bU84elJiVW1JZXIrTi9YQUFIcmpZVWluTmc1MXpFSjdFU0tlbXVzYXhL?=
 =?utf-8?B?K2NEYjRCdmpZcDdyRXdXRk95aktHSXpValVNTy91N3N0UEUwR0I1S0NwcFZX?=
 =?utf-8?B?MnAxWGl2bURYaTg3SnM4Vzk5elNnaWI0akxleDFvK2R6dGlMUkpZSTNYQ280?=
 =?utf-8?B?TGdWcXFzVEhiM0hzUllrRW5FZEg5dWhwQlVtbkFTeVVheWNNVXdySDlhMmVE?=
 =?utf-8?B?dlZERXJOQzh4M203YTRnN2YrUXllQWdoeDhORGk5ZnZESkpnNVhPRU1TTkVG?=
 =?utf-8?B?RnJtMURTSG9sUlk4RTdhRzBlN0pocXUwaHlVdEd2a3VhTXFvZ0dxK0cyWmNG?=
 =?utf-8?B?eVRkRHUrSHZkNnlkSWdGVEp5QWk1SWVkVE83N2F4MEZlRGQ1cDUxUzdXM0FO?=
 =?utf-8?B?QUFCZ1pJd1pFbS93MW13WlV4cEExbUFVbmM5S3M2cStnTUlTNXR0cUJvQ3VV?=
 =?utf-8?B?RzR0b294SkdlbWNsOUVhK2ZuZ0h0SkIyTXdBcGhaMTg4R1dWRUo3RlhnakZU?=
 =?utf-8?B?MFhTZ2V4NGZxMnVmZytmK2hBVnRzY1crRkVhY3RTR1VuOCtMVU1MRlRQVVI0?=
 =?utf-8?B?SXc0dVVZY0tFWGxMQXI0Qisyb2hKUE5VTkhMS0RyWDdEWEJvbXVsTXNiZVcv?=
 =?utf-8?B?N3JZeWQzbXBPb1hBWWFPVGEwR1VjdVhWYkJhbDZxY2tlQlYvV2NqdFMweUZG?=
 =?utf-8?B?Z3hvQmhZVjJoWXlqeXI0Z3RRWWxheFNabXArM1E1bE1tWG9kRWtoVW5NV3E4?=
 =?utf-8?B?QUc0U0g3eXowdk9lY3hpVVVyT0tYeDVyMkxIVk14cFhqZmdCejN4YWJCOW1S?=
 =?utf-8?B?WURuZjhhZWE5RmhjazA2REhTeEZUbC9SVk1VYkdxVWprOHpDNCsySDBHaXI4?=
 =?utf-8?B?RXJmdWVwcDRZRmNCOExUaHkxUzF2ZUhFek5FREZHbWl6c1hXajBUNjcyVVlD?=
 =?utf-8?B?b0NSNkpod2VQaUpmWVZlUTAxUC80THhhV254aUZkYjRzV0RxQld4bllMbmRa?=
 =?utf-8?B?cXVtMmxLQmJvTnpZVkJ0RUhqYTZWSFNyM2FBUEovM085OWg0MlZ4djM4Skx1?=
 =?utf-8?B?M0JXOVpqRXowZC9TZ2pQUFZVRmlodXdWa1NYM1MwNHA1WTVJUmhBRUh1TnB3?=
 =?utf-8?Q?6ZuM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFlvWVBnK2d3L2wrdHMrZG10QzNnWk0zR3B5alVPSE1xS2NraWc3Y1Uxb0tk?=
 =?utf-8?B?cjR4dTlDZGdKL1pDb2Z4alhBS3phUEJVdkkycE4weWZTT2JZS3hHSnduUWt0?=
 =?utf-8?B?Zmk2d0MvcTVYNlpud25lVnRJMzgyRW1SM0xFL0ZyalQxVDhad3VrVlpmM1ln?=
 =?utf-8?B?Q3B2RURqZ3p0cGIxSThGZ2NvRDVRWXJBV0hmTjVmS21LOFNvc0hVMU9xQnhr?=
 =?utf-8?B?QlBGdm5oSTBPMTdteUpzTlhtN3FKcXFkQkJhbXlLTkZpajF2bzVvdUlwU1Ro?=
 =?utf-8?B?WmJ0WlFyL0pBamNCYVYyeGMyNncwc2FUM0k4QjBqYzBYYThXU1dJSDhCSVVG?=
 =?utf-8?B?RTg1Y2RWUGVTOXpOaXlab296U1NhM0pHUVcweWFOSTJ3NkVzTjVxTDA4RmQr?=
 =?utf-8?B?WG1SbnVjQ0NBWGdFckVjK1dHZExxYW9rcWZMQjJVQndvc0xKbTlYS1FBL1Nm?=
 =?utf-8?B?K28xV2ZpNHoyMXJXRVFCZTdZeW5LZEdLNzBtN0ZvcFJVY3pSK3lzTnNiRzgz?=
 =?utf-8?B?VXJWRlFrejMvYm5KWWl3QTl5UDJvdVZvSzFadUpPTHlIVFZXOVhaSXM4THZq?=
 =?utf-8?B?ejh2V1VMcHVDcmhJeFJBQWNaUCtWenpmbHpHeTNuN2FkcGJMY2RmeU5qOUh6?=
 =?utf-8?B?aGRRNGZ2cllCOE1Ibm5LRGM5QkJ1MTNwUzh4ZEozWlFJQ3dzMVQvUEZOWDlr?=
 =?utf-8?B?UmxQOVZCWWVmM0Nmak1mMGswaVk0M3EvTFhUankrVG16UGEwd0hjRis1OGx3?=
 =?utf-8?B?MmQ4WkxpQ0JaWkFrUjlOZm54WUljVkJobWVtSDZXR2xPK1d4dm1HczNZM3N4?=
 =?utf-8?B?THFadzZVQjVSbDhmblRHQ2dPV0xia3h3Kyszai9NUWl4N1c3S1RDL3ZyQkxk?=
 =?utf-8?B?ekQ1YkVYb2gwQitkaVNiTzNWVURWYjVjUVBDWXBzUDRaUHJOZDBPRFNzdUl5?=
 =?utf-8?B?aU9vZmFnVTBxMkpsWXRyY3J5WXloVW9LcjB1ZTZXMDRxaTJTRDZlTEpmOUZx?=
 =?utf-8?B?VlphenAwRlExeWFIMExkOUU2TkF2MjlkRkc0WE1KUkw2UFo4T296YWQxV1Nw?=
 =?utf-8?B?MmV1dHppdzMxL1F4clZJMk5JZDVzb2pER3BhQk4xK2Z1aUV0VFVGVW1Rd3lu?=
 =?utf-8?B?dE10d3NNSDc4TjFBbWVEMUlLQkFUUVdHWFZXcFlmbkNpdGl5UDhobkVBNzFK?=
 =?utf-8?B?QkxHYlphY3dVM0o3eHRzTS9HMW1tc3dXNEs3d2NEQTRzS3NXdWY0cUcwbitK?=
 =?utf-8?B?TllOdGFiaE44cTZuSVMvL29ieHBqbGR0ZzIzVCtZV01wMjhhRFNTeDRTVTRq?=
 =?utf-8?B?YmR3c2w1cmo2eXJFaXNjOWlPS1BCb1QxK1Y1YmxDQ2ZzbkZvNERZc1B4R2JZ?=
 =?utf-8?B?d2F1U0JiZU1ObC9hS0JSK3JOMlI1ZndBbTFpQm9BSU5nTTdmT0Nya3o3ZmVG?=
 =?utf-8?B?dllPL0FOQ0ZWNnBGak1aM1U4NG5CeG1rc3E5aDNPNFlmT21ZaG9SWDF1Nm5I?=
 =?utf-8?B?UHV5dXQ5aTJ4Y2ZFMU5EQldOVlBTL3NCQmJLaUZ0RUpjWllWYzBabGFibVhC?=
 =?utf-8?B?Y2dEOXJVUEh5ZjJXOXVPU0pjU1BESEtsYWsya2gzcGp1TS9BaHU2RTJ6ZnFp?=
 =?utf-8?B?aUZQRVRNUEhZcjhPcXpBenRYRVRmU3Ftdmc3TE9hUFJXdDhTZ2hPRGpxc0lO?=
 =?utf-8?B?bjZKRlVEdlNtMUpvenU0S3JKYlVjSlNKUjF0QS9rYmVBemVvQ3l5TzhyVThB?=
 =?utf-8?B?eFZsZlpNZDkyUC9QSnlBVWtIWHRsZFhUWHJ1aW9xZXhvUldJcUl1OU1hRXhq?=
 =?utf-8?B?NG10U1lVTWtaM2tkaEpGVFEvZEV3YW56K3o4MGJXOXA4cnVPSi84VmUyU1g1?=
 =?utf-8?B?c3lneG11VTJRQVRvdlhOM01TTDdQMHZ1OGM3dzE2allPUzhEQ1ZIZG9wZHNU?=
 =?utf-8?B?TVJMSHZWdHJTaEtacHpPU1VNZWh4TnM2NHpxcG9kYUliVHl5V2MxSWYwK01Y?=
 =?utf-8?B?Q2JsNld4d3FmRVowK3NGTjY2dkY0R1J4WThFWEVwK3VOcFkvTE1zUDNQZDhu?=
 =?utf-8?B?MjhpeW5Scm9JU3lLQVJUa3IyZWF6V0lxeHp0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E3289791D36234BBF96DACA28D5ADA4@NAMP110.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: spacex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaa7fd5-cd04-4023-355c-08de735dc72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 04:32:54.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70922d1c-6e01-4d95-82dd-55b449e38bd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB2040
X-Proofpoint-GUID: 7alENZ9Ycnt-53esCyEtfhSlFbKH_D25
X-Proofpoint-ORIG-GUID: 7alENZ9Ycnt-53esCyEtfhSlFbKH_D25
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAzNSBTYWx0ZWRfX2KmvTcBXQfD8 eqmjx5d0B7h6MBLFxA6xx2gPt0FzZb1bBwPyyblrQ1dPl7rFiVhnVqA64rpqudgueaAdpd7OWfw SzMpGL07LzG8m8ySIodUdZOGoVXPaLX0HjQbxU1InmpRkbg7ByRzouAQEX0tRv9I+KzKqN2xHl/
 Wrp58LsjQGqQyr9CNPj0Da8prOa+BW8HchVHGIpk7yYB0s7coPPWL2eLlHR66tTc5wQDdIvey+D FARcW/MUhV60967ksjNK2WhkB1m4VB4j6f7yhoIahpCzO04yxY850odoRfiEZr82JZkXGuer+id 58JlxD/+SvshCKNjKJWzB4RDXTjwKjKVCiA0t4OOVg/WMv+oKRy7eeQLwuTZJRIuRYCLWU5HCkW gVTRs491
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602240035
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[spacex.com,reject];
	R_DKIM_ALLOW(-0.20)[spacex.com:s=dkim-cloud1,spacexgcchigh.onmicrosoft.us:s=selector1-spacexgcchigh-onmicrosoft-us];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17092-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacex.com:mid,spacex.com:dkim,spacex.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.us:url,spacexgcchigh.onmicrosoft.us:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Finnius.Dayton@spacex.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[spacex.com:+,spacexgcchigh.onmicrosoft.us:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31F00181C1F
X-Rspamd-Action: no action

DQoNCu+7v09uIDIvMjMvMjYsIDU6NDYgQU0sICJUYXJpcSBUb3VrYW4iIDx0dG91a2FuLmxpbnV4
QGdtYWlsLmNvbSA8bWFpbHRvOnR0b3VrYW4ubGludXhAZ21haWwuY29tPj4gd3JvdGU6DQoNCg0K
DQoNCg0KDQpPbiAyMy8wMi8yMDI2IDI6MDUsIEZpbm4gRGF5dG9uIHdyb3RlOg0KPiBtbHg1ZV94
ZHBfeG1pdCgpIHNlbGVjdHMgYW4gWERQIFNRIChTZW5kIFF1ZXVlKSB1c2luZyBzbXBfcHJvY2Vz
c29yX2lkKCkNCj4gKENQVSBJRCkuIFdoZW4gZG9pbmcgWERQX1JFRElSRUNUIGZyb20gYSBDUFUg
d2hvc2UgSUQgaXMNCj4+ID0gcHJpdi0+Y2hhbm5lbHMubnVtLCBtbHg1ZV94ZHBfeG1pdCgpIHJl
dHVybnMgLUVOWElPIGFuZCB0aGUNCj4gcmVkaXJlY3QgZmFpbHMuDQo+IA0KPiBQcmV2aW91cyBk
aXNjdXNzaW9uIHByb3Bvc2VkIHVzaW5nIG1vZHVsbyBpbiBtbHg1ZV94ZHBfeG1pdCgpIHRvIG1h
cA0KPiBDUFUgSURzIGludG8gdGhlIGNoYW5uZWwgcmFuZ2UsIGJ1dCBtb2R1bG8vZGl2aXNpb24g
aXMgdG9vIGNvc3RseSBpbg0KPiB0aGUgaG90IHBhdGguDQo+IA0KDQoNClRoYXQgZGlzY3Vzc2lv
biByZWFjaGVkIHRvIGFuIGFncmVlbWVudCBvZiB1c2luZyBhIHdoaWxlIGxvb3Agd2l0aCANCnN1
YnRyYWN0aW9uLiBJdCdzIGV4cGVjdGVkIHRvIGJlIGZhc3QsIGFuZCBvcHRpbWl6ZXMgdGhlIGNv
bW1vbiBjYXNlLg0KDQoNCj4gSW5zdGVhZCwgdGhpcyBzb2x1dGlvbiBwcmVjb21wdXRlcyBwZXIt
Y3B1IHByaXYtPnhkcHNxIGFzc2lnbm1lbnRzIHdoZW4NCj4gY2hhbm5lbHMgYXJlIChyZSljb25m
aWd1cmVkIGFuZCBkb2VzIGEgc2luZ2xlIGxvb2t1cCBpbiBtbHg1ZV94ZHBfeG1pdCgpLg0KPiAN
Cj4gQmVjYXVzZSBtdWx0aXBsZSBDUFVzIG1hcCB0byB0aGUgc2FtZSB4ZHBzcSB3aGVuIENQVSBj
b3VudCBleGNlZWRzDQo+IGNoYW5uZWwgY291bnQsIHNlcmlhbGl6ZSB4ZHBfeG1pdCBvbiB0aGUg
cmluZyB3aXRoIHhkcF90eF9sb2NrLg0KPiANCg0KDQpXaGF0J3MgdGhlIGFkdmFudGFnZSBvZiB0
aGlzIHNvbHV0aW9uIG92ZXIgdGhlIG9uZSB3ZSBhbHJlYWR5IGFncmVlZCB0bz8NCg0KU3VidHJh
Y3Rpb24gaW4gYSB3aGlsZSBsb29wIGlzIGdyZWF0IGZvciB0aGUgY29tbW9uIGNhc2UgKGNwdV9p
ZCA8IGNoYW5uZWxzLm51bSkuDQpCdXQgaW4gd29yc3QgY2FzZSwgaS5lLiBDUFVzID4+IFhEUCBT
UXMsIHRoZSB3aGlsZS1zdWJ0cmFjdGlvbiBhcHByb2FjaA0KSXMgTyhjcHVfaWQgLyBjaGFubmVs
cy5udW0pIGl0ZXJhdGlvbnMuIFdpdGggMjU2IENQVXMgYW5kIDggY2hhbm5lbHMsIGNwdV9pZD0y
NTUgZG9lcw0KMzEgc3VidHJhY3Rpb25zOyB3aXRoIDIgY2hhbm5lbHMgaXQgY2FuIGJlIDEyNyBp
dGVyYXRpb25zIGluIHRoZSBtbHg1ZV94ZHBfeG1pdCgpIGhvdCBwYXRoLg0KUHJlY29tcHV0aW5n
IG1vdmVzIHRoZSBleHBlbnNpdmUgb3BlcmF0aW9uIG91dCBvZiB0aGUgaG90IHBhdGggaW50byAo
cmUpY29uZmlndXJhdGlvbg0KdGltZSBhbmQgbWFrZXMgcnVudGltZSBsb29rdXBzIGNvbnN0YW50
LiBUaGUgdHJhZGVvZmYgaXMgYWRkZWQgcGVyLWNwdSBzdGF0ZSB0aGF0IG5lZWRzIA0KdG8gYmUg
cmVidWlsdCB3aGVuZXZlciBjaGFubmVscyBhcmUgcmVjb25maWd1cmVkLiANCg0KR2l2ZW4gbW9k
ZXJuIHN5c3RlbXMgd2hlcmUgQ1BVIGNvdW50IGNhbiBncmVhdGx5IGV4Y2VlZCB0aGUgbnVtYmVy
IG9mIFhEUCBTUXMsIGNvbnN0YW50LQ0KdGltZSBsb29rdXBzIGF2b2lkIGEgbGFyZ2UvdmFyaWFi
bGUgbG9vcCBpbiB0aGUgaG90IHBhdGguIA0KDQpUaGFuayB5b3UsDQpGaW5uDQoNCj4gRml4ZXM6
IDU4Yjk5ZWUzZTNlYiAoIm5ldC9tbHg1ZTogQWRkIHN1cHBvcnQgZm9yIFhEUF9SRURJUkVDVCBp
biBkZXZpY2Utb3V0IHNpZGUiKQ0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UudXMvdjMvX19o
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTEwMzEyMzEwMzguMTA5MjY3My0xLXpp
amlhbnpoYW5nQGJ5dGVkYW5jZS5jb20gPG1haWx0bzoyMDI1MTAzMTIzMTAzOC4xMDkyNjczLTEt
emlqaWFuemhhbmdAYnl0ZWRhbmNlLmNvbT4vX187ISFGcWIwTkFCc2poRjBLaDhJIVk4M2NaWDdR
QkR0Ti1rV1FyZk1zT0xnMkdoVjViaXFLc1Q0RGtqMFprNjc3cm1fNzhwdTZfNGlqN1R0a1Z1aDg1
OUJfWVFmOG4weURpQk1BdEkwQ2FpZTBscGskIA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2Uu
dXMvdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvNDRmNjk5NTUtYjU2Ni00ZmIx
LTkwNGQtZjU1MTA0NmZmMmQ0QGdtYWlsLmNvbSA8bWFpbHRvOjQ0ZjY5OTU1LWI1NjYtNGZiMS05
MDRkLWY1NTEwNDZmZjJkNEBnbWFpbC5jb20+X187ISFGcWIwTkFCc2poRjBLaDhJIVk4M2NaWDdR
QkR0Ti1rV1FyZk1zT0xnMkdoVjViaXFLc1Q0RGtqMFprNjc3cm1fNzhwdTZfNGlqN1R0a1Z1aDg1
OUJfWVFmOG4weURpQk1BdEkwQ052QmNvVkEkIA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyA8bWFpbHRvOnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNi4xMisNCj4gU2lnbmVkLW9mZi1i
eTogRmlubiBEYXl0b24gPGZpbm5pdXMuZGF5dG9uQHNwYWNleC5jb20gPG1haWx0bzpmaW5uaXVz
LmRheXRvbkBzcGFjZXguY29tPj4NCj4gLS0tDQo+IFRlc3Rpbmc6DQo+IC0gWERQIGZvcndhcmRp
bmcgLyBYRFBfUkVESVJFQ1QgdmVyaWZpZWQgd2l0aCBib3RoIGxvdyBDUFUgaWRzIGFuZA0KPiBD
UFUgaWRzID4gdGhhbiBudW1iZXIgb2Ygc2VuZCBxdWV1ZXMuDQo+IC0gTm8gLUVOWElPIG9ic2Vy
dmVkLCBzdWNjZXNzZnVsIGZvcndhcmRpbmcuDQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvZW4uaCB8IDQgKysrDQo+IC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2VuL3hkcC5jIHwgMTYgKysrKysrKy0tLS0NCj4gLi4uL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jIHwgMjggKysrKysrKysrKysrKysrKysrKw0K
PiAzIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
LmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4uaA0KPiBpbmRl
eCBlYTJjZDFmNWQxZDAuLjM4Nzk1NDIwMTY0MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgNCj4gQEAgLTUxOSw2ICs1MTksOCBAQCBzdHJ1
Y3QgbWx4NWVfeGRwc3Egew0KPiAvKiBjb250cm9sIHBhdGggKi8NCj4gc3RydWN0IG1seDVfd3Ff
Y3RybCB3cV9jdHJsOw0KPiBzdHJ1Y3QgbWx4NWVfY2hhbm5lbCAqY2hhbm5lbDsNCj4gKyAvKiBz
ZXJpYWxpemUgd3JpdGVzIGJ5IG11bHRpcGxlIENQVXMgdG8gdGhpcyBzZW5kIHF1ZXVlICovDQo+
ICsgc3BpbmxvY2tfdCB4ZHBfdHhfbG9jazsNCj4gfSBfX19fY2FjaGVsaW5lX2FsaWduZWRfaW5f
c21wOw0KPiANCj4gc3RydWN0IG1seDVlX3hkcF9idWZmIHsNCj4gQEAgLTkwOSw2ICs5MTEsOCBA
QCBzdHJ1Y3QgbWx4NWVfcHJpdiB7DQo+IHN0cnVjdCBtbHg1ZV9ycSBkcm9wX3JxOw0KPiANCj4g
c3RydWN0IG1seDVlX2NoYW5uZWxzIGNoYW5uZWxzOw0KPiArIC8qIHNlbGVjdHMgdGhlIHhkcHNx
IGR1cmluZyBtbHg1ZV94ZHBfeG1pdCgpICovDQo+ICsgaW50IF9fcGVyY3B1ICpzZW5kX3F1ZXVl
X2lkeF9wdHI7DQo+IHN0cnVjdCBtbHg1ZV9yeF9yZXMgKnJ4X3JlczsNCj4gdTMyICp0eF9yYXRl
czsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW4veGRwLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW4veGRwLmMNCj4gaW5kZXggODBmOWZjMTA4NzdhLi4yZGQ0NGFkODczYTEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi94ZHAuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMNCj4g
QEAgLTg0NSw3ICs4NDUsNyBAQCBpbnQgbWx4NWVfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwgaW50IG4sIHN0cnVjdCB4ZHBfZnJhbWUgKipmcmFtZXMsDQo+IHN0cnVjdCBtbHg1ZV9w
cml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gc3RydWN0IG1seDVlX3hkcHNxICpzcTsN
Cj4gaW50IG54bWl0ID0gMDsNCj4gLSBpbnQgc3FfbnVtOw0KPiArIGludCBzZW5kX3F1ZXVlX2lk
eCA9IDA7DQo+IGludCBpOw0KPiANCj4gLyogdGhpcyBmbGFnIGlzIHN1ZmZpY2llbnQsIG5vIG5l
ZWQgdG8gdGVzdCBpbnRlcm5hbCBzcSBzdGF0ZSAqLw0KPiBAQCAtODU1LDEzICs4NTUsMTkgQEAg
aW50IG1seDVlX3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuLCBzdHJ1Y3Qg
eGRwX2ZyYW1lICoqZnJhbWVzLA0KPiBpZiAodW5saWtlbHkoZmxhZ3MgJiB+WERQX1hNSVRfRkxB
R1NfTUFTSykpDQo+IHJldHVybiAtRUlOVkFMOw0KPiANCj4gLSBzcV9udW0gPSBzbXBfcHJvY2Vz
c29yX2lkKCk7DQo+IA0KPiAtIGlmICh1bmxpa2VseShzcV9udW0gPj0gcHJpdi0+Y2hhbm5lbHMu
bnVtKSkNCj4gKyBpZiAodW5saWtlbHkoIXByaXYtPnNlbmRfcXVldWVfaWR4X3B0cikpDQo+IHJl
dHVybiAtRU5YSU87DQo+IA0KPiAtIHNxID0gcHJpdi0+Y2hhbm5lbHMuY1tzcV9udW1dLT54ZHBz
cTsNCj4gKyBzZW5kX3F1ZXVlX2lkeCA9ICp0aGlzX2NwdV9wdHIocHJpdi0+c2VuZF9xdWV1ZV9p
ZHhfcHRyKTsNCj4gKyBpZiAodW5saWtlbHkoc2VuZF9xdWV1ZV9pZHggPj0gcHJpdi0+Y2hhbm5l
bHMubnVtIHx8IHNlbmRfcXVldWVfaWR4IDwgMCkpDQo+ICsgcmV0dXJuIC1FTlhJTzsNCj4gDQo+
ICsgc3EgPSBwcml2LT5jaGFubmVscy5jW3NlbmRfcXVldWVfaWR4XS0+eGRwc3E7DQo+ICsgLyog
VGhlIG51bWJlciBvZiBxdWV1ZXMgY29uZmlndXJlZCBvbiBhIG5ldGRldiBtYXkgYmUgc21hbGxl
ciB0aGFuIHRoZQ0KPiArICogQ1BVIHBvb2wsIHNvIHR3byBDUFVzIG1pZ2h0IG1hcCB0byB0aGlz
IHF1ZXVlLiBXZSBtdXN0IHNlcmlhbGl6ZSB3cml0ZXMuDQo+ICsgKi8NCj4gKyBzcGluX2xvY2so
JnNxLT54ZHBfdHhfbG9jayk7DQo+IGZvciAoaSA9IDA7IGkgPCBuOyBpKyspIHsNCj4gc3RydWN0
IG1seDVlX3htaXRfZGF0YV9mcmFncyB4ZHB0eGRmID0ge307DQo+IHN0cnVjdCB4ZHBfZnJhbWUg
KnhkcGYgPSBmcmFtZXNbaV07DQo+IEBAIC05NDEsNyArOTQ3LDcgQEAgaW50IG1seDVlX3hkcF94
bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuLCBzdHJ1Y3QgeGRwX2ZyYW1lICoqZnJh
bWVzLA0KPiANCj4gaWYgKGZsYWdzICYgWERQX1hNSVRfRkxVU0gpDQo+IG1seDVlX3htaXRfeGRw
X2Rvb3JiZWxsKHNxKTsNCj4gLQ0KPiArIHNwaW5fdW5sb2NrKCZzcS0+eGRwX3R4X2xvY2spOw0K
PiByZXR1cm4gbnhtaXQ7DQo+IH0NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYw0KPiBpbmRleCA3ZWI2OTFjMmExYmQuLmFkZWYz
NWQwNmI4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvZW5fbWFpbi5jDQo+IEBAIC0xNDkyLDYgKzE0OTIsNyBAQCBzdGF0aWMgaW50IG1s
eDVlX2FsbG9jX3hkcHNxKHN0cnVjdCBtbHg1ZV9jaGFubmVsICpjLA0KPiBzcS0+cGRldiA9IGMt
PnBkZXY7DQo+IHNxLT5ta2V5X2JlID0gYy0+bWtleV9iZTsNCj4gc3EtPmNoYW5uZWwgPSBjOw0K
PiArIHNwaW5fbG9ja19pbml0KCZzcS0+eGRwX3R4X2xvY2spOw0KPiBzcS0+dWFyX21hcCA9IGMt
PmJmcmVnLT5tYXA7DQo+IHNxLT5taW5faW5saW5lX21vZGUgPSBwYXJhbXMtPnR4X21pbl9pbmxp
bmVfbW9kZTsNCj4gc3EtPmh3X210dSA9IE1MWDVFX1NXMkhXX01UVShwYXJhbXMsIHBhcmFtcy0+
c3dfbXR1KSAtIEVUSF9GQ1NfTEVOOw0KPiBAQCAtMzI4MywxMCArMzI4NCwzMCBAQCBzdGF0aWMg
dm9pZCBtbHg1ZV9idWlsZF90eHFfbWFwcyhzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikNCj4gc21w
X3dtYigpOw0KPiB9DQo+IA0KPiArc3RhdGljIHZvaWQgYnVpbGRfcHJpdl90b194ZHBzcV9hc3Nv
Y2lhdGlvbnMoc3RydWN0IG1seDVlX3ByaXYgKnByaXYpDQo+ICt7DQo+ICsgLyoNCj4gKyAqIEJ1
aWxkIHRoZSBtYXBwaW5nIGZyb20gQ1BVIHRvIFhEUCBzZW5kIHF1ZXVlIGluZGV4IGZvciBwcml2
Lg0KPiArICogVGhpcyBpcyB1c2VkIGJ5IG1seDVlX3hkcF94bWl0KCkgdG8gZGV0ZXJtaW5lIHdo
aWNoIHhkcHNxIChzZW5kIHF1ZXVlKQ0KPiArICogc2hvdWxkIGhhbmRsZSB0aGUgeGRwdHggZGF0
YSwgYmFzZWQgb24gdGhlIENQVSBydW5uaW5nIG1seDVlX3hkcF94bWl0KCkNCj4gKyAqIGFuZCB0
aGUgdGFyZ2V0IHByaXYgKG5ldGRldikuDQo+ICsgKi8NCj4gKyBpbnQgc2VuZF9xdWV1ZV9pZHgs
IGNwdTsNCj4gKw0KPiArIGlmICh1bmxpa2VseShwcml2LT5jaGFubmVscy5udW0gPT0gMCkpDQo+
ICsgcmV0dXJuOw0KPiArDQo+ICsgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgew0KPiArIHNl
bmRfcXVldWVfaWR4ID0gY3B1ICUgcHJpdi0+Y2hhbm5lbHMubnVtOw0KPiArICpwZXJfY3B1X3B0
cihwcml2LT5zZW5kX3F1ZXVlX2lkeF9wdHIsIGNwdSkgPSBzZW5kX3F1ZXVlX2lkeDsNCj4gKyB9
DQo+ICt9DQo+ICsNCj4gdm9pZCBtbHg1ZV9hY3RpdmF0ZV9wcml2X2NoYW5uZWxzKHN0cnVjdCBt
bHg1ZV9wcml2ICpwcml2KQ0KPiB7DQo+IG1seDVlX2J1aWxkX3R4cV9tYXBzKHByaXYpOw0KPiBt
bHg1ZV9hY3RpdmF0ZV9jaGFubmVscyhwcml2LCAmcHJpdi0+Y2hhbm5lbHMpOw0KPiArIGJ1aWxk
X3ByaXZfdG9feGRwc3FfYXNzb2NpYXRpb25zKHByaXYpOw0KPiBtbHg1ZV94ZHBfdHhfZW5hYmxl
KHByaXYpOw0KPiANCj4gLyogZGV2X3dhdGNoZG9nKCkgd2FudHMgYWxsIFRYIHF1ZXVlcyB0byBi
ZSBzdGFydGVkIHdoZW4gdGhlIGNhcnJpZXIgaXMNCj4gQEAgLTYyNjMsOCArNjI4NCwxNCBAQCBp
bnQgbWx4NWVfcHJpdl9pbml0KHN0cnVjdCBtbHg1ZV9wcml2ICpwcml2LA0KPiBpZiAoIXByaXYt
PmZlY19yYW5nZXMpDQo+IGdvdG8gZXJyX2ZyZWVfY2hhbm5lbF9zdGF0czsNCj4gDQo+ICsgcHJp
di0+c2VuZF9xdWV1ZV9pZHhfcHRyID0gYWxsb2NfcGVyY3B1KGludCk7DQo+ICsgaWYgKCFwcml2
LT5zZW5kX3F1ZXVlX2lkeF9wdHIpDQo+ICsgZ290byBlcnJfZnJlZV9mZWNfcmFuZ2VzOw0KPiAr
DQo+IHJldHVybiAwOw0KPiANCj4gK2Vycl9mcmVlX2ZlY19yYW5nZXM6DQo+ICsga2ZyZWUocHJp
di0+ZmVjX3Jhbmdlcyk7DQo+IGVycl9mcmVlX2NoYW5uZWxfc3RhdHM6DQo+IGtmcmVlKHByaXYt
PmNoYW5uZWxfc3RhdHMpOw0KPiBlcnJfZnJlZV90eF9yYXRlczoNCj4gQEAgLTYyOTUsNiArNjMy
Miw3IEBAIHZvaWQgbWx4NWVfcHJpdl9jbGVhbnVwKHN0cnVjdCBtbHg1ZV9wcml2ICpwcml2KQ0K
PiBmb3IgKGkgPSAwOyBpIDwgcHJpdi0+c3RhdHNfbmNoOyBpKyspDQo+IGt2ZnJlZShwcml2LT5j
aGFubmVsX3N0YXRzW2ldKTsNCj4ga2ZyZWUocHJpdi0+Y2hhbm5lbF9zdGF0cyk7DQo+ICsgZnJl
ZV9wZXJjcHUocHJpdi0+c2VuZF9xdWV1ZV9pZHhfcHRyKTsNCj4ga2ZyZWUocHJpdi0+dHhfcmF0
ZXMpOw0KPiBrZnJlZShwcml2LT50eHEyc3Ffc3RhdHMpOw0KPiBrZnJlZShwcml2LT50eHEyc3Ep
Ow0KDQoNCg0KDQoNCg==


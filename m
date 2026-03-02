Return-Path: <linux-rdma+bounces-17357-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD3ZM0cnpWm14AUAu9opvQ
	(envelope-from <linux-rdma+bounces-17357-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:59:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBA1D356C
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 06:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFE273024CA9
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90C31D362;
	Mon,  2 Mar 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="YD72bIX0";
	dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b="CMaCJt6x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0f-003ea501.gpphosted.com (mx0f-003ea501.gpphosted.com [66.159.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA137702B;
	Mon,  2 Mar 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431105; cv=fail; b=D5IS6430AtWB39CX1zm00xtXQXStUmUZvCW58gxnwGKgUBRtHwUN7dG0yRvkKu629ZGzgJltmmrtfWVEe7fvT5gi98SAVtnmYsANvjNh+iKSEeACG5rQMNfyyep5yEtngi2yoxTO0BZLBDQApkqlWb23VwisFoW1XpFJ2NHPHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431105; c=relaxed/simple;
	bh=OmDhQo3kPKINyiXyPJlwDyM8HrunX9DQoBsqxwBtFbk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jq9yBAfznVDSz/jAOez7QAhYg4TUBPqpOXwOLeG60/fyMiCAznT62Ukkofbn1DCq5iqn6u/L16rCKaAGU6b8DK7kQZfH7LSxNOyREq74EML7Wa9YXSFEMLp74NOkZuCe+FYruwMeLK6jN5Zsj09hnfnLZUBviv9+6wi6u3szN2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com; spf=pass smtp.mailfrom=spacex.com; dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b=YD72bIX0; dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b=CMaCJt6x; arc=fail smtp.client-ip=66.159.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacex.com
Received: from pps.filterd (m0418030.ppops.net [127.0.0.1])
	by mx0f-003ea501.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6225pfdg008858;
	Mon, 2 Mar 2026 05:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=dkim-cloud1;
 bh=OmDhQo3kPKINyiXyPJlwDyM8HrunX9DQoBsqxwBtFbk=;
 b=YD72bIX0SILNBymB/dUeBeTtG2W47isgMMIPLDg2+5HboOCH2cnISvpOaNqK2YrwDqGu
 f0CRtovGOuc7V26yhwAPQsY+v95IyISSc4v5OLeKBuj614gpqzg8wlFWEtyen3aU2DON
 +teh8ZU2tklKlmXhPwnXCmffyhWPtJ/LmDOggmk6QtX5PYSkbE4x8DCIXgbf67hiQZy1
 GuE4y3yckvW/EvywLsHyVW1IQvqGxmXeD8p0fFVkEerBSvAi6Cs56hHIfCLsGN0ejR9l
 T5olhgN+h0+N5yhhDUHW291ibu++lxDeq7YJhN6sr3xNLar4jgTBSjAEAMmprSd1EuTy 9g== 
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02on0058.outbound.protection.office365.us [23.103.208.58])
	by mx0f-003ea501.gpphosted.com (PPS) with ESMTPS id 4cn4s8800q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 05:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=QIpIlb33X8NahBmR7u+avt4PiPDEKO9+yPumgkZxQBIGcy5nmxmCuGDJb9lhOoJBeoBGRRjCwsk8qrI638gv+9YzAsrzaxWycjzgYII6MynsGHmrANAjMJxQatIziVcPgsCkzCgN2cQ0ztRZlKQR0A17vxk5mBR2CpajaPVQqCnbfaPOdlDEO7s9zrz2GXGGNQTx1TKp7PqrROO3zmWCZ6b10ZUbLY5ifoCev9ldjgZh8OZ5Sgo0QNjywxHZNLB5khy1fo1yElZQcZO5P82ga0oYFXQtji08z1tOItUI5jJvlr+JGQT9ONR8CanALzgB3URJCFPq5lo56Rz7Chd59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmDhQo3kPKINyiXyPJlwDyM8HrunX9DQoBsqxwBtFbk=;
 b=DETpnHPs1m+FKNBLjZFQoI/iTw0cRf6YK9VMbbr0FmP1cS7SvCY9fMZktaph4q3t0hPwKS/rlqRgHzSbsy2lYn2beJbF0UsLz/63hB2emK7ZHWID70YzlkjifQA0Ssd5bskdK94BoVKcMp6tciuh0A8G6QDa2LCwzziKxgcLv/WYT91QALuaeEM+WHH4zXcLFtled//o6+LJqKrK4yUCd9DCuEk1Sx+VWjqg7cg98wNndRGJCDUp7Icw//bPD8wrkBOxVPZ/wysEGnoUQ6xrABzLz1lDe96LeubLWI4BXI1SihCmODA3VRAWg/IPfiFjIImRm/e5eJqMMoXJ+4Ecug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spacex.com; dmarc=pass action=none header.from=spacex.com;
 dkim=pass header.d=spacex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spacexgcchigh.onmicrosoft.us; s=selector1-spacexgcchigh-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmDhQo3kPKINyiXyPJlwDyM8HrunX9DQoBsqxwBtFbk=;
 b=CMaCJt6x36nSE1zQjhls3tQQJwDYdKYWbTtVBeLivf/AQ3AiFvEYwicN/a8oI91nKiaPDqy17aIn+pVh4JuBoiG9cZsSfHA0Mi0mPktIlAOqHKKxODaoiB8/uC0dE0e+gReBTAfAtNXQCkgat3tmwG2UcBNS3p7SUTCRKaxpuMz2ycynGRfdC6HRCPQzMMzFxxmcrWNuTXUFc+/RszifgMIVMaj5QswIkwnZvLqb9NulZLgv5mJAuy5OYEcY7yjcDzquB/bHS2AB2W3l9VWtXsxSVJ3arWSrjWTMAiIT9af/BBGrUPC9WQqAMhuWCH1cdaHN/gcWW+yK77Ia3Nmijw==
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18d::6)
 by BN0P110MB1676.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 05:52:09 +0000
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d]) by PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d%4]) with mapi id 15.20.9611.013; Mon, 2 Mar 2026
 05:52:09 +0000
From: Finn Dayton <Finnius.Dayton@spacex.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "sdf@fomichev.me"
	<sdf@fomichev.me>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Finn Dayton <Finnius.Dayton@spacex.com>
Subject: [PATCH net-next v2] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Topic: [PATCH net-next v2] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Index: AQHcqgi1vSXu4N8FMU+ckU6VWHv+fg==
Date: Mon, 2 Mar 2026 05:52:09 +0000
Message-ID: <60E0EC79-4E2B-4874-9CEB-6558706A910A@spacex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1186:EE_|BN0P110MB1676:EE_
x-ms-office365-filtering-correlation-id: 813b954d-23e7-4851-a862-08de781fd7d5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 FIHsAEaY1L7kg3/rGVXvfonQxUEXRUAPFDD36PwEU3XxBrc8M6b6Ed4BhVVVlGhJ0ZPQ28kLRKDK/7Pw4RqY3ROFilPjrINaeqqDHNv4LmF/5KK/1V0ftxanSEIpO7+959nI1ARB56I95tqwEJB4smGClhpNTXR2NsD5e9E9b6bZccHJhFICGNKjg2G3whsdXF0sSIth678vMVM5/s6NaW/kpX9H0BcaJ5Jlf2uOaJM/WwtykD20DHqQaEnHLhV5YL04UsLv67hYmyXu3MfAV4uyRfsrYpDGy2zdiEt7ze/nFTK0phj6ZvU5tK4iZH5JcSQ7Xy4O4l3eg9Dwyb2CKairflbsmZ7vnG6VCrF5/NiBkwc7MBYrvMz1Uf/fUwzR7Dbw02ttqob4ZXIFWPq9fORfZATcx1bUlBygncbbgHMfKJdqJZQiaRjMy+OjX/xVhEqZZiK1u3jUS597zIJAXWf/6vtdHlAq92DpS9ZZW48YUyC+kVM6sGFPKQIxfrnzay4dqyNcL1rHcXWlBrtnkxRbgLALulQxQRazLt/sKshadKGkEcey+3QcY+x+Skc4TY37iQsgZY+OuxgjAH/MkUv8//v5GvQ5KgVyxBzJ2buXV3AgOe7/64482DD0kca+2u0QEzDiyjYMwwl/hjiwvWEnMRmrrlNwhA17HtSLbp2Jx6mImrbLZBbkSyTqILsgxatUmfxFZS7vNKVWt0wBdAa0XORIeqZur8dyYtoD8SCnKB+DZBl110G2hjbM2MklDpQOxEDxerSMXlI1kQNeF7f8zb8Ohy/eSrvwKIQN0WM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXJYWklLbmpMdnVCTmhlQlRTU3h1d2FxdDJiWkxycUhnRGl5elJyMWNBQjRh?=
 =?utf-8?B?UGQveWRpYVIvdkY0eXgrTzZjaThhYzhuZVh0TWo4YnhMS3F1VXpualAwaUZ6?=
 =?utf-8?B?T2wxU08yTEFXamVvL3g5dk55Vy9JRmx2QjJCS2cvb2RUcU9LbGsvZnpQVEtC?=
 =?utf-8?B?MThuWUVmanlaNVVkSkQvYTZWWDFHWWtqT1c5akZxZGtwdVZMSStBQTY3V3l2?=
 =?utf-8?B?MmZ6YU41UVFoVmZNZml2c0FoK3VtL0JVQ1BSdmp2S0pVOWZlSVZ1bWorTEZh?=
 =?utf-8?B?NTBjOTI5U0FDNkFNUzRyaC9rdXc3TUNHdWgrYmM5dnNyZ0haZUVxQ3JQZ08y?=
 =?utf-8?B?dytCU05YdUxQMjhtRmNvWXREQWxSbnk0cUNBTVhIWktXQzZEOHNIYTBiL0RP?=
 =?utf-8?B?bEY4eEU2VG1DOXVQVVdUVWdoTXVaUFc0SERkNk0zWXRJODdVNmY5bXBoU09N?=
 =?utf-8?B?MzhnNGM5aUxEaVZpOTUwUXN0Z280WGFXbzdhNFJJUjJhN3VaUHQxYk0reFpi?=
 =?utf-8?B?RVJ2eGdjYklKVTg4MFlnVFhUT283eEtEUFc5SHEvMnc3Qi8rVlFpUnRzUDdD?=
 =?utf-8?B?Z2pPK1k1NjRZM1psMm0vWTNTWHpGMjM5OXJvKzRVWUhWcElPV3U2bUhDVTYy?=
 =?utf-8?B?RDF0YmZJNm83anFuSVA3ZGp2RURwS3dqMXhQNmxkblJ4OHRvVmlaOGdsTmRF?=
 =?utf-8?B?VXcrY3FPcnBFcVNXYVM5WHpCMktoUjBsSkdoenYrWklsUTd6Um5HQ250MlJi?=
 =?utf-8?B?UW9TNDFvVjRRSVBLSnd3OUJwV2U1aXFUUG1EalVKaXF4eFBJQmRlVFMzQzJB?=
 =?utf-8?B?dFlJaUZtMnJTZG91MkZiRmU0OXJGaHZFU2dubzlRZURnRS9qdStaMWZjc09v?=
 =?utf-8?B?QjdaN1ZIY0Z6bDV6SU5SN1NTZnUydEt6NURFOHFFTmFzcUFMTnVqd1JmZVFK?=
 =?utf-8?B?QlZrUWlKa3pYTjludzJsZU11ZDVwRi9NelVjNGVaN3Z5WFFFSU50VmkycGxS?=
 =?utf-8?B?QVNSZVV4bkIvNFhIT2Y3RWZBNVlkMldCTG9Qa0ZkTE4rU1RxdWtZNmJRdThR?=
 =?utf-8?B?UHFRODFrVGsvaVB4Tk9QaFRJKzU4RnRBZnN4azBnUERkNGFlZnErSHV4MGYv?=
 =?utf-8?B?WW1MdVJGbXFqZ0hKWUdkME5CVE1XaHdkVEFVMXo2N09KcEN3YjJiTUR2RFQ2?=
 =?utf-8?B?TU5uK3ZveHZOSEI3bjNrRWErT0cxenRSdUJWOENHZnFnanFGcUFZNm9WQk9l?=
 =?utf-8?B?T3FnVGEvdnFwdUVNSzVPd3U2ZEF6QnVMcU9nT0U0Z3FMTGNrQWplK1VTQVRY?=
 =?utf-8?B?eDJvUXhKQllwQVZhYitJeUY5RGQ5YXdNeEFFSEtsdVlzdlV4S1lVS0hiVUhF?=
 =?utf-8?B?QjNNOWl1L2E3MUZFazRxcHJsdU9BQ3lMSUNZOS9raVk4ckJQS0Y0OGdoTHdE?=
 =?utf-8?B?NlJDeXRBamRrbUtaMW41MUxhQTBWbDhSRlVncU0xRG9saSttQ3lWUDlqVUJH?=
 =?utf-8?B?YWUvQXgrNno3RTFEZU53OFRRUERYU2FEcVBsUnl2dlpSTWorRUMvZ0ttZm0y?=
 =?utf-8?B?RFVFVE81Rk0raWx1NTNxOWwweXIzSGZUZ3Q4Qll1cEZPTFpYeDN6U2RMRzhT?=
 =?utf-8?B?YStBUWJCcVFheWFOeWpPa3ZkMlkzZENUc2JScmluVmsrR3VGZEJxaUJuNDgy?=
 =?utf-8?B?eTF6QmdYSlVkWWthZlp1M0FCQXdIOFpXQmhSR2k1UlFMSkIvSUhpNHBaSEFF?=
 =?utf-8?B?LysybTJ6dXVOQzRabnl4ZGQvclpydUdrUkZLR3VST3NXcG1BandablhUd2U4?=
 =?utf-8?B?NGxGNkZDN1dGV3RLaFFMVUlCR3NKUFkrQ25lelpjbEl5L2E1a3NFNXU5TTZT?=
 =?utf-8?B?ek9tWllOVmQzSVNOYjRZQVdESEFFOXRPUlZINkZpU3JHMWsrUVRrb3pMNVlT?=
 =?utf-8?B?UDlzRVlFQnppOW9neUphMTIyU29wcXhmTU1SR05IS3U0ejZHTDBVRmNMOTBl?=
 =?utf-8?B?SW9LTy9uM1NHWUh4ZEhIOWlreVcrSHNjMm1GT09zUkxQd2lhb2tRdTJJMFZx?=
 =?utf-8?B?bHdpUTQ3OUViUXVTMkt4N0JVQ1hVQ01XZUptZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D62355AA46D1D4BA6537013A578941B@NAMP110.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 813b954d-23e7-4851-a862-08de781fd7d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 05:52:09.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70922d1c-6e01-4d95-82dd-55b449e38bd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1676
X-Proofpoint-ORIG-GUID: XrGB2e3puRtxCzgPgmtw-4optKGCjtwX
X-Proofpoint-GUID: XrGB2e3puRtxCzgPgmtw-4optKGCjtwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA0OSBTYWx0ZWRfX7bu/up44es8P zxINi0MkxcDmLBPb7XZQOAJmVf9cGCPjp89UOXRJ+E7b5d71aBeyAzO7F92wiVtPZ+aKr+Dx/IU 6Es9+GEacUnbG758UdWMjdyIRzyNAEvquwQyr0dyEtMh2fKz41Zyc84blCS25sCz2NPQG0fexxH
 ZvvbKRsryciArzPt9NEbgwBAdwYsGYWH4mTuQgWhmG/RBQIHCkRETU0u5slVI8E54mhYTBGILeN pg/gtgdik/paDp2uXvCOrjiQncq/AQ0HS9D58H2EGXnHGnYTppde9FMZsQXs0vTQpSal5dtiX0X xfBXkaNHPbcndSNCKpWKlbugLbIcpfPxsVHByx5MjN2g4+q6tS8g99Yliaw+8t8UBLViTYr2s/0 laxPQB8t
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603020049
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[spacex.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[spacex.com:s=dkim-cloud1,spacexgcchigh.onmicrosoft.us:s=selector1-spacexgcchigh-onmicrosoft-us];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,vger.kernel.org,spacex.com];
	TAGGED_FROM(0.00)[bounces-17357-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacex.com:mid,spacex.com:dkim,spacex.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Finnius.Dayton@spacex.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[spacex.com:+,spacexgcchigh.onmicrosoft.us:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35EBA1D356C
X-Rspamd-Action: no action

bWx4NWVfeGRwX3htaXQoKSBjdXJyZW50bHkgc2VsZWN0cyB0aGUgeGRwc3EgKHNlbmQgcXVldWUp
IHVzaW5nDQpzbXBfcHJvY2Vzc29yX2lkKCkgKGkuZS4gY3B1IGlkKS4gV2hlbiBkb2luZyBYRFBf
UkVESVJFQ1QgZnJvbSBhIGNwdQ0Kd2l0aCBpZCA+PSBwcml2LT5jaGFubmVscy5udW0sIGhvd2V2
ZXIsIG1seDVlX3hkcF94bWl0KCkgcmV0dXJucyAtRU5YSU8NCmFuZCB0aGUgcmVkaXJlY3QgZmFp
bHMuDQoNClByZXZpb3VzIGRpc2N1c3Npb24gcHJvcG9zZWQgdXNpbmcgbW9kdWxvIG9yIHdoaWxl
IGxvb3Agc3VidHJhY3Rpb24NCmluIG1seDVlX3hkcF94bWl0KCkgdG8gbWFwIGNwdSBpZCB0byBz
ZW5kIHF1ZXVlLCBidXQgdGhlc2UgYXBwcm9hY2hlcw0KaW50cm9kdWNlIGhvdCBwYXRoIG92ZXJo
ZWFkIG9uIG1vZGVybiBzeXN0ZW1zIHdoZXJlIHRoZSBudW1iZXIgb2YNCmxvZ2ljYWwgY29yZXMg
Pj4gdGhlIG51bWJlciBvZiBYRFAgc2VuZCBxdWV1ZXMgKHhkcHNxKS4NCg0KVGhlIGJlbG93IGFw
cHJvYWNoIHByZWNvbXB1dGVzIHBlci1jcHUgcHJpdi0+eGRwc3EgYXNzaWdubWVudHMgd2hlbg0K
Y2hhbm5lbHMgYXJlIChyZSljb25maWd1cmVkIGFuZCBkb2VzIGEgY29uc3RhbnQtdGltZSBsb29r
dXAgaW4NCm1seDVlX3hkcF94bWl0KCkuDQoNCkJlY2F1c2UgbXVsdGlwbGUgQ1BVcyBtYXkgbm93
IG1hcCB0byB0aGUgc2FtZSB4ZHBzcSAod2hlbmV2ZXIgY3B1IGNvdW50DQpleGNlZWRzIGNoYW5u
ZWwgY291bnQpLCB3ZSBzZXJpYWxpemUgd3JpdGVzIGluIHhkcF94bWl0IHdpdGggYSB0eF9sb2Nr
Lg0KDQpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNjEwRDhGOUUtMDAzOC00NkQ5
LUFEOEEtMUQ1OTYyMzZCMUVGQHNwYWNleC5jb20vDQpMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvNDc0YzFmNzEtM2E1Yy00ZmU1LWEwMWUtODBmMmJhOTVmZDdlQGJ5dGVkYW5jZS5j
b20vDQpTaWduZWQtb2ZmLWJ5OiBGaW5uIERheXRvbiA8Zmlubml1cy5kYXl0b25Ac3BhY2V4LmNv
bT4NCi0tLQ0KdjI6DQotIFJlbW92ZWQgdW5uZWNlc3NhcnkgZ3VhcmRzDQotIEltcHJvdmVkIHZh
cmlhYmxlIG5hbWluZyBhbmQgcGxhY2VtZW50IA0KLSBDaGFuZ2UgbWFwcGluZyBmcm9tIGNwdSAt
PiBpbmRleCB0byBjcHUgLT4geGRwc3EgDQotIENhbGwgc21wX3dtYigpIGFmdGVyIHVwZGF0ZXMg
dG8gbWFwcGluZyANCg0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bi5oICB8ICA0ICsrKw0KIC4uLi9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3hk
cC5jICB8IDE3ICsrKysrKy0tLS0tLS0NCiAuLi4vbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9lbl9tYWluLmMgfCAyNSArKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi5oIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgNCmluZGV4IGVhMmNkMWY1ZDFkMC4uNzEzZGM3
ZjliYWUzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL2VuLmgNCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bi5oDQpAQCAtNDkzLDYgKzQ5Myw4IEBAIHN0cnVjdCBtbHg1ZV94ZHBzcSB7DQogCXUxNiAgICAg
ICAgICAgICAgICAgICAgICAgIHBjOw0KIAlzdHJ1Y3QgbWx4NV93cWVfY3RybF9zZWcgICAqZG9v
cmJlbGxfY3NlZzsNCiAJc3RydWN0IG1seDVlX3R4X21wd3FlICAgICAgbXB3cWU7DQorCS8qIHNl
cmlhbGl6ZSB3cml0ZXMgYnkgbXVsdGlwbGUgQ1BVcyB0byB0aGlzIHNlbmQgcXVldWUgKi8NCisJ
c3BpbmxvY2tfdCAgICAgICAgICAgICAgICAgdHhfbG9jazsNCiANCiAJc3RydWN0IG1seDVlX2Nx
ICAgICAgICAgICAgY3E7DQogDQpAQCAtODk4LDYgKzkwMCw4IEBAIHN0cnVjdCBtbHg1ZV9wcml2
IHsNCiAJc3RydWN0IG1seDVlX3NlbHEgc2VscTsNCiAJc3RydWN0IG1seDVlX3R4cXNxICoqdHhx
MnNxOw0KIAlzdHJ1Y3QgbWx4NWVfc3Ffc3RhdHMgKip0eHEyc3Ffc3RhdHM7DQorCS8qIHNlbGVj
dHMgdGhlIHhkcHNxIGR1cmluZyBtbHg1ZV94ZHBfeG1pdCgpICovDQorCXN0cnVjdCBtbHg1ZV94
ZHBzcSAqIF9fcGVyY3B1ICpzZW5kX3F1ZXVlX3B0cjsNCiANCiAjaWZkZWYgQ09ORklHX01MWDVf
Q09SRV9FTl9EQ0INCiAJc3RydWN0IG1seDVlX2RjYnhfZHAgICAgICAgZGNieF9kcDsNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMNCmluZGV4
IDgwZjlmYzEwODc3YS4uMWRiODNhNjkwNTVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3hkcC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMNCkBAIC04NDUsNyArODQ1LDYgQEAgaW50
IG1seDVlX3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuLCBzdHJ1Y3QgeGRw
X2ZyYW1lICoqZnJhbWVzLA0KIAlzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2
KGRldik7DQogCXN0cnVjdCBtbHg1ZV94ZHBzcSAqc3E7DQogCWludCBueG1pdCA9IDA7DQotCWlu
dCBzcV9udW07DQogCWludCBpOw0KIA0KIAkvKiB0aGlzIGZsYWcgaXMgc3VmZmljaWVudCwgbm8g
bmVlZCB0byB0ZXN0IGludGVybmFsIHNxIHN0YXRlICovDQpAQCAtODU0LDE0ICs4NTMsMTIgQEAg
aW50IG1seDVlX3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuLCBzdHJ1Y3Qg
eGRwX2ZyYW1lICoqZnJhbWVzLA0KIA0KIAlpZiAodW5saWtlbHkoZmxhZ3MgJiB+WERQX1hNSVRf
RkxBR1NfTUFTSykpDQogCQlyZXR1cm4gLUVJTlZBTDsNCi0NCi0Jc3FfbnVtID0gc21wX3Byb2Nl
c3Nvcl9pZCgpOw0KLQ0KLQlpZiAodW5saWtlbHkoc3FfbnVtID49IHByaXYtPmNoYW5uZWxzLm51
bSkpDQotCQlyZXR1cm4gLUVOWElPOw0KLQ0KLQlzcSA9IHByaXYtPmNoYW5uZWxzLmNbc3FfbnVt
XS0+eGRwc3E7DQotDQorCS8qIFBlci1DUFUgeGRwc3EgbWFwcGluZywgcmVidWlsdCBvbiBjaGFu
bmVsIChyZSljb25maWd1cmF0aW9uIHdoaWxlIFhEUCBUWCBpcyBkaXNhYmxlZCAqLw0KKwlzcSA9
ICp0aGlzX2NwdV9wdHIocHJpdi0+c2VuZF9xdWV1ZV9wdHIpOw0KKwkvKiBUaGUgbnVtYmVyIG9m
IHF1ZXVlcyBjb25maWd1cmVkIG9uIGEgbmV0ZGV2IG1heSBiZSBzbWFsbGVyIHRoYW4gdGhlDQor
CSAqIENQVSBwb29sLCBzbyB0d28gQ1BVcyBtaWdodCBtYXAgdG8gdGhpcyBxdWV1ZS4gV2UgbXVz
dCBzZXJpYWxpemUgd3JpdGVzLg0KKwkgKi8NCisJc3Bpbl9sb2NrKCZzcS0+dHhfbG9jayk7DQog
CWZvciAoaSA9IDA7IGkgPCBuOyBpKyspIHsNCiAJCXN0cnVjdCBtbHg1ZV94bWl0X2RhdGFfZnJh
Z3MgeGRwdHhkZiA9IHt9Ow0KIAkJc3RydWN0IHhkcF9mcmFtZSAqeGRwZiA9IGZyYW1lc1tpXTsN
CkBAIC05NDEsNyArOTM4LDcgQEAgaW50IG1seDVlX3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsIGludCBuLCBzdHJ1Y3QgeGRwX2ZyYW1lICoqZnJhbWVzLA0KIA0KIAlpZiAoZmxhZ3Mg
JiBYRFBfWE1JVF9GTFVTSCkNCiAJCW1seDVlX3htaXRfeGRwX2Rvb3JiZWxsKHNxKTsNCi0NCisJ
c3Bpbl91bmxvY2soJnNxLT50eF9sb2NrKTsNCiAJcmV0dXJuIG54bWl0Ow0KIH0NCiANCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5j
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYw0KaW5k
ZXggYjZjMTI0NjBiNTRhLi40MzRkYjc0ZjA5NmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jDQpAQCAtMTUwNSw2ICsxNTA1LDcg
QEAgc3RhdGljIGludCBtbHg1ZV9hbGxvY194ZHBzcShzdHJ1Y3QgbWx4NWVfY2hhbm5lbCAqYywN
CiAJc3EtPnN0b3Bfcm9vbSA9IHBhcmFtLT5pc19tcHcgPyBtbHg1ZV9zdG9wX3Jvb21fZm9yX21w
d3FlKG1kZXYpIDoNCiAJCQkJCW1seDVlX3N0b3Bfcm9vbV9mb3JfbWF4X3dxZShtZGV2KTsNCiAJ
c3EtPm1heF9zcV9tcHdfd3FlYmJzID0gbWx4NWVfZ2V0X21heF9zcV9hbGlnbmVkX3dxZWJicyht
ZGV2KTsNCisJc3Bpbl9sb2NrX2luaXQoJnNxLT50eF9sb2NrKTsNCiANCiAJcGFyYW0tPndxLmRi
X251bWFfbm9kZSA9IGNwdV90b19ub2RlKGMtPmNwdSk7DQogCWVyciA9IG1seDVfd3FfY3ljX2Ny
ZWF0ZShtZGV2LCAmcGFyYW0tPndxLCBzcWNfd3EsIHdxLCAmc3EtPndxX2N0cmwpOw0KQEAgLTMy
ODMsMTAgKzMyODQsMjcgQEAgc3RhdGljIHZvaWQgbWx4NWVfYnVpbGRfdHhxX21hcHMoc3RydWN0
IG1seDVlX3ByaXYgKnByaXYpDQogCXNtcF93bWIoKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbWx4
NWVfYnVpbGRfeGRwc3FfbWFwcyhzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikNCit7DQorCS8qIEJ1
aWxkIG1hcHBpbmcgZnJvbSBDUFUgaWQgdG8gWERQIHNlbmQgcXVldWUsIHVzZWQgYnkNCisJICog
bWx4NWVfeGRwX3htaXQoKSB0byBkZXRlcm1pbmUgd2hpY2ggc2VuZCBxdWV1ZSB0byB0cmFuc21p
dCBwYWNrZXQgb24uDQorCSAqLw0KKwlpbnQgY3B1Ow0KKw0KKwlmb3JfZWFjaF9wb3NzaWJsZV9j
cHUoY3B1KSB7DQorCQlpbnQgc2VuZF9xdWV1ZV9pZHggPSBjcHUgJSBwcml2LT5jaGFubmVscy5u
dW07DQorCQlzdHJ1Y3QgbWx4NWVfeGRwc3EgKnNxID0gcHJpdi0+Y2hhbm5lbHMuY1tzZW5kX3F1
ZXVlX2lkeF0tPnhkcHNxOw0KKwkJKnBlcl9jcHVfcHRyKHByaXYtPnNlbmRfcXVldWVfcHRyLCBj
cHUpID0gc3E7DQorCX0NCisJLyogUHVibGlzaCB0aGUgbmV3IENQVS0+eGRwc3EgbWFwIGJlZm9y
ZSByZS1lbmFibGluZyBYRFAgVFggKi8NCisJc21wX3dtYigpOw0KK30NCisNCiB2b2lkIG1seDVl
X2FjdGl2YXRlX3ByaXZfY2hhbm5lbHMoc3RydWN0IG1seDVlX3ByaXYgKnByaXYpDQogew0KIAlt
bHg1ZV9idWlsZF90eHFfbWFwcyhwcml2KTsNCiAJbWx4NWVfYWN0aXZhdGVfY2hhbm5lbHMocHJp
diwgJnByaXYtPmNoYW5uZWxzKTsNCisJbWx4NWVfYnVpbGRfeGRwc3FfbWFwcyhwcml2KTsNCiAJ
bWx4NWVfeGRwX3R4X2VuYWJsZShwcml2KTsNCiANCiAJLyogZGV2X3dhdGNoZG9nKCkgd2FudHMg
YWxsIFRYIHF1ZXVlcyB0byBiZSBzdGFydGVkIHdoZW4gdGhlIGNhcnJpZXIgaXMNCkBAIC02MjYy
LDggKzYyODAsMTQgQEAgaW50IG1seDVlX3ByaXZfaW5pdChzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJp
diwNCiAJaWYgKCFwcml2LT5mZWNfcmFuZ2VzKQ0KIAkJZ290byBlcnJfZnJlZV9jaGFubmVsX3N0
YXRzOw0KIA0KKwlwcml2LT5zZW5kX3F1ZXVlX3B0ciA9IGFsbG9jX3BlcmNwdShzdHJ1Y3QgbWx4
NWVfeGRwc3EgKik7DQorCWlmICghcHJpdi0+c2VuZF9xdWV1ZV9wdHIpDQorCQlnb3RvIGVycl9m
cmVlX2ZlY19yYW5nZXM7DQorDQogCXJldHVybiAwOw0KIA0KK2Vycl9mcmVlX2ZlY19yYW5nZXM6
DQorCWtmcmVlKHByaXYtPmZlY19yYW5nZXMpOw0KIGVycl9mcmVlX2NoYW5uZWxfc3RhdHM6DQog
CWtmcmVlKHByaXYtPmNoYW5uZWxfc3RhdHMpOw0KIGVycl9mcmVlX3R4X3JhdGVzOg0KQEAgLTYy
OTAsNiArNjMxNCw3IEBAIHZvaWQgbWx4NWVfcHJpdl9jbGVhbnVwKHN0cnVjdCBtbHg1ZV9wcml2
ICpwcml2KQ0KIAlpZiAoIXByaXYtPm1kZXYpDQogCQlyZXR1cm47DQogDQorCWZyZWVfcGVyY3B1
KHByaXYtPnNlbmRfcXVldWVfcHRyKTsNCiAJa2ZyZWUocHJpdi0+ZmVjX3Jhbmdlcyk7DQogCWZv
ciAoaSA9IDA7IGkgPCBwcml2LT5zdGF0c19uY2g7IGkrKykNCiAJCWt2ZnJlZShwcml2LT5jaGFu
bmVsX3N0YXRzW2ldKTsNCi0tIA0KMi40My4wDQoNCg0K


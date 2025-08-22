Return-Path: <linux-rdma+bounces-12866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E6B30A85
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 02:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A671CC4035
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4851684B4;
	Fri, 22 Aug 2025 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+otN6Yt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mbdcV2h0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327ED347C7;
	Fri, 22 Aug 2025 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824212; cv=fail; b=Dlrvtj0OK1W7O4qFUStTfHNX/ARXD7vVZh4lGvVxOVY6yp4fIkKnZZSmndx3gMex/Sj4tnOFlyWjCbbaLhY4vdqjCK7ZglnQOOU66DgPXYKistIx2dfgLrYl6reIo80F91r5bCNUUBS+YPQ0EsKK6x++dLARf1jQPgFUFVMeQ6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824212; c=relaxed/simple;
	bh=m12A/ENktGAPGW60UmIZQWdo4L9kBhYBamKILA47Jy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lprg19NbzRiv8oEn/FoEUHNoqvu8enqd1C0Y+wed/EjNTtPqRw3G0hLekSQ9GpWqRcXgLx1xxnqKuX+w34Ee8+JtYE7JKM8c+DxxtOShWJyABbNBBKQYz8G4tP0GMuzu28R60YTm9zSf7jQUAGmdLMNIKfTahD5fFS6X/Ub0J+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+otN6Yt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mbdcV2h0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LMRXme032284;
	Fri, 22 Aug 2025 00:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m12A/ENktGAPGW60UmIZQWdo4L9kBhYBamKILA47Jy0=; b=
	S+otN6YtM3vvlCRtVTiF0gwlK9oHnF96jTuF/Rc8gZ1EUGhrz6MLsVLGgHYBSFVy
	ha/RM5+oxx3CjVULJZ3xmIN8sZrrp8JQT2BMnckrxKEEEYj9Jw8wQvnAKuDU59Gj
	mcevLJ8553516slsZaWvbzPgXXeZQn96PzSHTTZtPppRysdSanHaLWZHG5mw4Pba
	1oP7vWXCwlsawwfJmCO3ZCjpRdx/eYINjQ/maeYFltK6IMLkDMgjVGD3n13gSiQc
	UN72Yjr6R6gxB/LHl82FJv/hHVXcvjIYOCjNPzysOTxBZLLjPvMADteYVbuj3yJu
	TzMIl1lzYFviKxygXilYew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tscpjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57M05dFl025286;
	Fri, 22 Aug 2025 00:56:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my43ajch-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBH06w6KuN9lhIUIzShwmbrSdUeteKHQUI3etKgS6QchMvwR4cBnlhcWRidNY6f7Ww2y7Lktm14dbxHUMaycYqYd0+5kl1BYqd/FgvOdCKKJm4d6hlA6kPUTjAdFniV7ZEYVFlT4d3mLHzEkVRlHHNGb9oVfn76StL75/CqxliiBVB6ZTJpthYbsqaBqnCLoYEKG8/6dQ8XsawMrn+hIn2hXq4+L9A8l1HSNV3wUFatuwlr2QxqK3SxMuPwpkaZ1AGnt29S3MaIquBzXC57Zn5mqFio+DTc2YaC05WUYSkotBwwJ1xMDo5UIsUpWJq4HgkAMF/NPsteRYAhCWm9UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m12A/ENktGAPGW60UmIZQWdo4L9kBhYBamKILA47Jy0=;
 b=lKD1YpukcMWw7s9HC7st7TOdxfnqve4pO5nPD1uYdAROmE+JMcatnaOjEs6KP3vBdrJiswpu9qzuzSQRE8lGEmSImN1nW8XFF5SM9ITQlOGsdJ7SdR2J2JMUjI//tmjFrpWmasDAaT4Fb7hb0aTbbUcFaGGxhTAZDVL4xcfpZbu2DlX8I8Ub4saaUIi/dAeVTlI+q3WXPhdNLstk4wk29uiF9VRKpgkyU5ctx+ZF2SjyNHQrc6JhMULBFvb5afLndsE/fJl+rvyI/nuBtCVmwxbMWohBsvk6qAggMyCIrg1SpyjMTMwI6w0GXyY8G49rsaoaJK2rlCdV4DY4Oxo/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m12A/ENktGAPGW60UmIZQWdo4L9kBhYBamKILA47Jy0=;
 b=mbdcV2h0xm8wUnD83M2XEzgLEZZgD2JyNrVudg3gnGEP/JkE3rPSbwKI1zNKyqs33nozxy8bKbOuK2n4cHLUz6e3xm+6iZF85vSb54smkIOGYiX5wGwN3NOz/rUlKCwi4/4qa93b0Ypm7EK197HgNECgJOpYMYFAQTe1fAu+gZ8=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 00:56:38 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 00:56:38 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "ujwal.kundur@gmail.com"
	<ujwal.kundur@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] rds: Fix endianness annotations for RDS
 extension headers
Thread-Topic: [PATCH net-next v2 4/4] rds: Fix endianness annotations for RDS
 extension headers
Thread-Index: AQHcEfvVKHOr/EPxjU63fTI5zMPVabRt20AA
Date: Fri, 22 Aug 2025 00:56:38 +0000
Message-ID: <4caa766680d4ea7ca745cedee6ce9c649a12f678.camel@oracle.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
	 <20250820175550.498-5-ujwal.kundur@gmail.com>
In-Reply-To: <20250820175550.498-5-ujwal.kundur@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA3PR10MB8613:EE_
x-ms-office365-filtering-correlation-id: 5e365ab3-75f8-4b32-9c5a-08dde116c034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejI4STR1YjV5aVNkY0VzMEROMzNHVEpzTEpuNUlUcjdiZElTdnR3R25wMWEv?=
 =?utf-8?B?WkxxTWs1bkQ0UXoxVUQ2NDRYbUtSVFpJTFhySTFOTiszVmxGaXU4Uk96NFpX?=
 =?utf-8?B?V2NKbDRBazBqRXhCQ084UGVrTEFORktlaE1sbGIxaDBZVmRGQkN3QThCNyts?=
 =?utf-8?B?MEFnMlJTYzdUMjRFWUxza0RTYXRJa1I4M2ZJL1Z5bTJVVTRHTUhzVHYwTVpv?=
 =?utf-8?B?bUx4dGZveHJva3pTUW42d3poakpSYjNIYXlVUzdtT3BHZzhBZ3kzRHA5eGN3?=
 =?utf-8?B?bk9lRnk2UjU2QVBSazJIZmpVa0EwYlNyYVV4NEZXTnNobFZvc2FZU3JoTVBq?=
 =?utf-8?B?WkVHSGNaSzlESlNlRUQ2RVZTcXBEcWtXSUN1Y0pQN09XSkJDckJ0cXJsU3RB?=
 =?utf-8?B?bTFac2plbFJmQTRjYmdGZ3lra1dnNkNuWnhJSXE4VG5PYk9Kc1d5K3h6d2tE?=
 =?utf-8?B?dU9CaHJsMFBkMEFvQmZ6WWJyTkR6UWNwbk1mWXRQNENjc29mRnZoaXgrNld3?=
 =?utf-8?B?NHoyTDhnV2hkanU2TXdEdFRTMGQ3empXWUdGQVMvS21uQjZaNy90NnJNR2dZ?=
 =?utf-8?B?MTZqbWRLcVZWSFFYTFZEN0QvVElnOU5pbXZycTBhZVM5SDNBY1Y5Ujl4NkFy?=
 =?utf-8?B?bXF2cGQ0TFZpc0FlM0wwTTgyYWVXSHdMdnl3RjEyTlFvb3kzWTNCWW50bGor?=
 =?utf-8?B?anFrbVE1MUQwT3B4UG4zR3hFSkd6VUY2aFlBNGh1dEIrbGFtWFVHdE9xa3NJ?=
 =?utf-8?B?N3J6c04remUyN2N0Q012QTNja0VYUnlZdmErS1dURHVTOW1Bb05jVktPODFZ?=
 =?utf-8?B?Tkx0VU0rN0tiNnU4MWtIQUFmTTFsRmtrcUJkUmp2TC9SL2FxZDNwQUFIYWxk?=
 =?utf-8?B?em5BZHNSYStlMUVpVjhCNTJXV3FIL0tOR21qazRPem5OMC9ZUDltZzVvb2I1?=
 =?utf-8?B?Qk04Q2pPWjQrRzBiVzR6ZVlEcUdDbUlqTnFLZktrUUpjbU1XeEtCQ25rK1Js?=
 =?utf-8?B?SWZDNlN3M1YwSFNHME5EVzM2OGw5TmxFRzJMUGhORmsxY0IwYjBleDhxQmEw?=
 =?utf-8?B?aXJHWC9NN1JLWkxlOXI1ZlNxYWNSTk00NzVhMWlVdUtiY3VTbWhvV2JoelRI?=
 =?utf-8?B?WWtxd3NzY01qYkcrTHZDWEdUb0R6MWFtdlJPWVRrNkErMEwvZTlxeGhEVE1i?=
 =?utf-8?B?UklmbVVMdGhiU0FPcEZnQnlaMXI2Uk9lL1dzc2hBdit1QnN5OTJ3R2FEM3RO?=
 =?utf-8?B?d0RwSXArL1NNdXFTUW9wcGxVUVhqdUdMaHoreXRwU0tFc1UrZTZjUGppbzlR?=
 =?utf-8?B?bUlXZmVRanhDSVBRZmtLRUE1c2dFQTMrNVRBL1pHU1R0ZTFiVnptZFovK0o3?=
 =?utf-8?B?aXZRQVd3V1lkclBWY1hzMkc1T2JFWERHc0NRWXZhNWViQ2JwK3hoVmloVGtk?=
 =?utf-8?B?ZFdVa0hrdEJ5aTJ3NlF4enpuWWsza0RuNGlPM3Avb2VPRFJKa2xjeFZvQktL?=
 =?utf-8?B?bERxZDJ0Z0w1eHJZMnJGYWFVQ0U1ODFQWTZnNU13OEtyNk1maGx2ZUJLOXZQ?=
 =?utf-8?B?TERUNXNUVFNLcVV2UFNiSTBLWGRhMFpOSHRBNGc4RVlQRk9peWdlc2gyTEpq?=
 =?utf-8?B?Mk9BSmNRYUErWHIzU1RZdno4U09XMFFrRTNFZHNPZkFxQ3k4dzNDOWpXNTMy?=
 =?utf-8?B?L0E0QjJEcnhoMDY2dS9sWHlBUURhNG9sUjhtWTFBTkprOGpsSUk2MHNwYkVh?=
 =?utf-8?B?U29WMFpPMVU0US81bUJWMmpsWE4wQUpuQ203UUxXNXBPSVFtUFZWL21CVENO?=
 =?utf-8?B?dmh5aXJvYU10OEt1dXd4YVZBK3dnd3poU1VnSXdPOGVzYzlLWjNVMis2TWlF?=
 =?utf-8?B?TDI1b1lDV0RHbmxackZwUlBHZU9Ob2pIQ3RlcmNKYUV6ZG5RcU5rYlVyeDBj?=
 =?utf-8?B?V1FHZTh1WUJaeG5oS1c0NFgwRjRiRHllckx4Um5HOTBBOHRBak5mNXJnUG5C?=
 =?utf-8?Q?+p7XC3qRqWwZRgl9e4XDbguDy7Keyo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDk3SjJKSHlaUk5DVDR3SkJGY2FOWGJtZzRjZ2RYQW8zNGhVZUFTQkdPdS9h?=
 =?utf-8?B?WVF1RVdpZ2R1NzI0Uk15Qml3cDc3UzgybFpEcHZFQWVsZkZQRW1tSXlJeTg1?=
 =?utf-8?B?T2syb09LSSthYmxpQnJ6UGppMnNwWGZZM2NGczVnUjBNbnFnd2ZBYnVCOVZL?=
 =?utf-8?B?MWUyRFRNcWtxOGtFZDRwc2F0TmRBbEN2TEcvNHV2c3dnZGpMN2crUS9MWU9u?=
 =?utf-8?B?YTdLLzBRa1AwSG16Y0xzYnYyOTRqOGFOck9TTWFtZUVSdWxTVS9zWUsybExq?=
 =?utf-8?B?RnNqZjZjdWVLcWpIQWpUL1BoMTlYQ2NTdVpJUWVGUkRyL0x5UFNvTk5oQURQ?=
 =?utf-8?B?QzhqN0NWQVlCUnpxSk5uNDRvVGNVM1Exc1F5RzhBSkF2Q2VzUkVMSzhWZUtv?=
 =?utf-8?B?aG1ENjVoUi96VFY1SzZQTzkwZEdIMVFOWGJKS2hGUWJPaHEraHcrK01SOU9o?=
 =?utf-8?B?WGZYRU1aN1FacFpaM0xINndvVXdxdnJHRlU2TmRwNm9iQzlFbDVSVmhlYm1l?=
 =?utf-8?B?cHQ3ektTQThJOFprVENDNG1iejBMN3hwbVQrVk1nMGs1R1pvRnZUVEU5SGdC?=
 =?utf-8?B?WjNtODREQUVGd0hrY1dTWHJzVEFNaXNHZENZdzB3MDZ5L0JZby9jUHBvMHlu?=
 =?utf-8?B?Qmx5Uy9yZ0NwVWZ1ZGpiTlZpaDI0Vy9pQVpGcytTU2FvQ2xUYkhpM051T3FS?=
 =?utf-8?B?Qzh0eUMzNWlQMUVLN3J0eTUrSHYyTURkNW85RTJFUzB6Yk9saXZCdStxS1cz?=
 =?utf-8?B?Y0tCemxCMWYvZ2NaYjlDaDErQzIrYVE3Y3VNRVhvbzZuMk5UK0syVmhCMTRi?=
 =?utf-8?B?Nzc1U29WVmM0RkFMVnhEakJTT0FsNG5yMkJvS3pvai95MDRkS01halo0OVMw?=
 =?utf-8?B?Mldoa2gvMGdEdGpOT2t0czB5WGRQbitPektvemIzQjNRa3JYV3JSUWpTRGV1?=
 =?utf-8?B?aUNub2tuS25HcENOWGM4ckZkeVNTN2kxaFB6WS9jMnJodm1uMzFua1VKR0E1?=
 =?utf-8?B?bWZqS0pyNjBpcnY4bm8rYUt5akdPQXBIQkY2amQrZno0MW1sUU00S3kreVFB?=
 =?utf-8?B?ZjFCZy81blVxSnN1OGVIZ2NKL1AyclpHZFg5VFFFTDh4dExvM3BJQ0RQZjVa?=
 =?utf-8?B?YkZiZEVicUNUdFlqZng4WFlNSTRxdCtKVDBNY0x0OWUxcFdxQkpYSGpKay9C?=
 =?utf-8?B?M1ZJeW0zRWxnMElENFErNVMyYmJSUUZEVTR2aVY5MjJKT0JhREZtSWJXU1Bv?=
 =?utf-8?B?eTkwTDY2SkluRlQvZ0IyZWh2c1MwU2Vsb0NPL3JUNXYzR2hvcjFMSzlWay9L?=
 =?utf-8?B?QVROQ05qOWdRMUpJMGVKOWJGOWU4MzlBdTNBUTlQU2NzT0s4OFFhODFaemty?=
 =?utf-8?B?QjJyWW5aeXAydnE2Q2xVSUJ6MGlURlVCamlhMDgrazRuRTk3UDhqZVByU3BZ?=
 =?utf-8?B?czR1QjRoRVpKM0pqRnVFeWJva3g0dWgxSmhXNUxzalF3L0swd1JJZzlMWnpU?=
 =?utf-8?B?aXc0dnRrbTRiZkZsNmZFcFphNXlyN1hZdThRTFAwc2tkb0ptTjRGaU12YUE1?=
 =?utf-8?B?Ym5kWXVDalY2RUFnNXprSDlvK2psdGhEVG1YUHBYblBLRDl4K2JOdDdzbkdC?=
 =?utf-8?B?M203Y2p5TmZRckZsTW1COGo1cWxncFNqemU3bWdTc2pvV2xrWTZpbG84SWg5?=
 =?utf-8?B?dDlicEs1enc1QSs2OEU4SWpJM1hTaUd1L3pHc3Y5MktZUFpSTDJrUGJBaHhK?=
 =?utf-8?B?OVRhb0VsTEIxOWw1ME5jVnIwQU02UHFpV3ZkbnVtdmxDNkZxWWpjOFlOUzQv?=
 =?utf-8?B?cFd1amd4cnRYb2F3OWFTK2NEMGxxQndTdTJjTllpbG16YTN2RExKemJvaDFv?=
 =?utf-8?B?ZFVjUlorbU9OQnRDMUtRTGtxZ2J0Vmk3QW5wUWl4ZFNlVGpLUkhucnBZN2JQ?=
 =?utf-8?B?bUwxWVdqdWVldVRlV1E2aU1ISzdqTkM4cFBuMkd4UkIzVUNVMTdZNml6bXVm?=
 =?utf-8?B?ZUlteEUvK3ZHb3JPdDhJSDYrdnR5azJkYTZuOVAyY09ZMlg4RkZzSFlqY2Va?=
 =?utf-8?B?SllLNE5JUDN2cGJnN1RaTlhhSjRiTWV2NTJidG96UXB0TXRub0xCdjNkVk9N?=
 =?utf-8?B?SnZ4M0FLYVVNVSs1UE5LRmVFVHNHQnVaVXNyWmVLWmlPa2JjSmtIU0ZUVHNS?=
 =?utf-8?Q?sW1wNJUH8LFgcWp3mDxoDfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2FB0DD1431324FBA52C87C864E98E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2aHsgoqkajRU1tz5MbIrchYdOGav47fuVoy6wy6MuAPxsUVVh3hL7lwTghrPJI/dQ+zH9/fR7fVP5SnCH/eR/fp6OfZLdqzuGZaFzFZwdPJ/tInnaUIyDfO62zCih99GMDb15sXLaMzM0lEJQv5jH97gzJ1XIBrSFlYvyXXWlCjJGndlON4NoG4lb77mkNTQBkSBChBjyqg+0YUQGme+YEwMMKqBiMtH+Nz4m/kvezaUh0jVmvxw71+cGG+2nItYl4VzMWbnQbdwSVX1a/KFEXfjIJprnnd4zub8fUG6oBc9+isTTsY/uuu/6dvK83lZ4/aiRA0bCRoBL8AQ32qQLst+AkEN7P5aOJ8MQ/LoGamItey2EtVAnOvxWByRuNp7AVItcB3zTicLtCFx0r2zfNOMOfI5fKu9V1JR7frIU+aykj2p3T4JIt967CTg1jXn3c3wzlsWqD+/alQUM/pxLzeg5Ho1v4UNr6F1GHgQnkjL/Sv2WOXk9L/PWyS0CPP+jQmj52ieaRGnf6ROtlewZx/1wzrtQhQWQpU0E7e507y7+G3g+10AbbdSpP9geKjVvllAAGBXbgpRrP1lkYkWsuQogFjSABDaMrbzu5po2HU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e365ab3-75f8-4b32-9c5a-08dde116c034
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 00:56:38.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPEkPScyFoDeYaDy7zbgZ2Dqu5mIfohGqe599/Qgv4Trt+SEM0inGJAN3tazzyHpqpqNr5+51cXp9fKbYRqrygjzUmxElA9HiW++mU2XjGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220007
X-Proofpoint-GUID: 3WGaCkO8oEQBR8uwFjifrYKKvogVUGug
X-Proofpoint-ORIG-GUID: 3WGaCkO8oEQBR8uwFjifrYKKvogVUGug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXzaNBlOLmEQcG
 cBnaj9NiBKlW2w2cjxLzrgn8tl7ZcDI0mifdLbjl922Sk0R/5eiTksZKt0bCvtE4Gsg46RIBEUa
 if6Lg2ZZRjwBNCFurlFNuSwiwPVPaxE27vdU/IgAj5gsU0/ddQekPc5VRiyfJmbT4sdwfSW3/xZ
 d+WZpPhubvriOpWEXoCS5oZpCLsEhCxAlE1BRq/PeWl22E0eUxCP2fWIUCY5qFUdNIq3FSKNKOn
 GtFXUoBinc4qmi9LXtiVhVm9qeWbt85q+ZLDpXaGMQLtP2D/RH68fyBk7k0CSLliatBHIYlVNKD
 nKm3XI/SkFS4UIeeYMS8DL7jebzzQehd5aa2Z679vOtrcGzrw0Xga1cD4FSH+ctN3HL1w/QhQXH
 K1Aq4l9SEoqh+D8ZNGlVDxZaIt99oKphqnI1kfsZq22HmL6lJXM=
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a7c04b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=2e6n7P65tlVTk3yOIUsA:9 a=QEXdDO2ut3YA:10
 a=oWZQ441pmSwA:10 cc=ntf awl=host:12070

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDIzOjI1ICswNTMwLCBVandhbCBLdW5kdXIgd3JvdGU6DQo+
IFBlciB0aGUgUkRTIDMuMSBzcGVjIFsxXSwgUkRTIGV4dGVuc2lvbiBoZWFkZXJzIEVYVEhEUl9O
UEFUSFMgYW5kDQo+IEVYVEhEUl9HRU5fTlVNIGFyZSBiZTE2IGFuZCBiZTMyIHZhbHVlcyByZXNw
ZWN0aXZlbHksIGV4Y2hhbmdlZCBkdXJpbmcNCj4gbm9ybWFsIG9wZXJhdGlvbnMgb3Zlci10aGUt
d2lyZSAoUkRTIFBpbmcvUG9uZykuIFRoaXMgY29udHJhc3RzIHRoZWlyDQo+IGRlY2xhcmF0aW9u
cyBhcyBob3N0IGVuZGlhbiB1bnNpZ25lZCBpbnRzLg0KPiANCj4gRml4IHRoZSBhbm5vdGF0aW9u
cyBhY3Jvc3Mgb2NjdXJyZW5jZXMuIEZsYWdnZWQgYnkgU3BhcnNlLg0KPiANCj4gWzFdIGh0dHBz
Oi8vb3NzLm9yYWNsZS5jb20vcHJvamVjdHMvcmRzL2Rpc3QvZG9jdW1lbnRhdGlvbi9yZHMtMy4x
LXNwZWMuaHRtbCANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFVqd2FsIEt1bmR1ciA8dWp3YWwua3Vu
ZHVyQGdtYWlsLmNvbT4NClRoaXMgbG9va3MgbXVjaCBiZXR0ZXIgbm93LiAgVGhhbmsgeW91IQ0K
UmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUu
Y29tPg0KPiAtLS0NCj4gIG5ldC9yZHMvbWVzc2FnZS5jIHwgNCArKy0tDQo+ICBuZXQvcmRzL3Jl
Y3YuYyAgICB8IDQgKystLQ0KPiAgbmV0L3Jkcy9zZW5kLmMgICAgfCA0ICsrLS0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL25ldC9yZHMvbWVzc2FnZS5jIGIvbmV0L3Jkcy9tZXNzYWdlLmMNCj4gaW5kZXggN2Fm
NTlkMjQ0M2U1Li4xOTlhODk5YTQzZTkgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvbWVzc2FnZS5j
DQo+ICsrKyBiL25ldC9yZHMvbWVzc2FnZS5jDQo+IEBAIC00NCw4ICs0NCw4IEBAIHN0YXRpYyB1
bnNpZ25lZCBpbnQJcmRzX2V4dGhkcl9zaXplW19fUkRTX0VYVEhEUl9NQVhdID0gew0KPiAgW1JE
U19FWFRIRFJfVkVSU0lPTl0JPSBzaXplb2Yoc3RydWN0IHJkc19leHRfaGVhZGVyX3ZlcnNpb24p
LA0KPiAgW1JEU19FWFRIRFJfUkRNQV0JPSBzaXplb2Yoc3RydWN0IHJkc19leHRfaGVhZGVyX3Jk
bWEpLA0KPiAgW1JEU19FWFRIRFJfUkRNQV9ERVNUXQk9IHNpemVvZihzdHJ1Y3QgcmRzX2V4dF9o
ZWFkZXJfcmRtYV9kZXN0KSwNCj4gLVtSRFNfRVhUSERSX05QQVRIU10JPSBzaXplb2YodTE2KSwN
Cj4gLVtSRFNfRVhUSERSX0dFTl9OVU1dCT0gc2l6ZW9mKHUzMiksDQo+ICtbUkRTX0VYVEhEUl9O
UEFUSFNdCT0gc2l6ZW9mKF9fYmUxNiksDQo+ICtbUkRTX0VYVEhEUl9HRU5fTlVNXQk9IHNpemVv
ZihfX2JlMzIpLA0KPiAgfTsNCj4gIA0KPiAgdm9pZCByZHNfbWVzc2FnZV9hZGRyZWYoc3RydWN0
IHJkc19tZXNzYWdlICpybSkNCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvcmVjdi5jIGIvbmV0L3Jk
cy9yZWN2LmMNCj4gaW5kZXggNTYyN2Y4MDAxM2Y4Li42NjIwNWQ2OTI0YmYgMTAwNjQ0DQo+IC0t
LSBhL25ldC9yZHMvcmVjdi5jDQo+ICsrKyBiL25ldC9yZHMvcmVjdi5jDQo+IEBAIC0yMDIsOCAr
MjAyLDggQEAgc3RhdGljIHZvaWQgcmRzX3JlY3ZfaHNfZXh0aGRycyhzdHJ1Y3QgcmRzX2hlYWRl
ciAqaGRyLA0KPiAgCXVuc2lnbmVkIGludCBwb3MgPSAwLCB0eXBlLCBsZW47DQo+ICAJdW5pb24g
ew0KPiAgCQlzdHJ1Y3QgcmRzX2V4dF9oZWFkZXJfdmVyc2lvbiB2ZXJzaW9uOw0KPiAtCQl1MTYg
cmRzX25wYXRoczsNCj4gLQkJdTMyIHJkc19nZW5fbnVtOw0KPiArCQlfX2JlMTYgcmRzX25wYXRo
czsNCj4gKwkJX19iZTMyIHJkc19nZW5fbnVtOw0KPiAgCX0gYnVmZmVyOw0KPiAgCXUzMiBuZXdf
cGVlcl9nZW5fbnVtID0gMDsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9zZW5kLmMgYi9u
ZXQvcmRzL3NlbmQuYw0KPiBpbmRleCA0MmQ5OTFiYzg1NDMuLjBiM2QwZWYyZjAwOCAxMDA2NDQN
Cj4gLS0tIGEvbmV0L3Jkcy9zZW5kLmMNCj4gKysrIGIvbmV0L3Jkcy9zZW5kLmMNCj4gQEAgLTE0
NTQsOCArMTQ1NCw4IEBAIHJkc19zZW5kX3Byb2JlKHN0cnVjdCByZHNfY29ubl9wYXRoICpjcCwg
X19iZTE2IHNwb3J0LA0KPiAgDQo+ICAJaWYgKFJEU19IU19QUk9CRShiZTE2X3RvX2NwdShzcG9y
dCksIGJlMTZfdG9fY3B1KGRwb3J0KSkgJiYNCj4gIAkgICAgY3AtPmNwX2Nvbm4tPmNfdHJhbnMt
PnRfbXBfY2FwYWJsZSkgew0KPiAtCQl1MTYgbnBhdGhzID0gY3B1X3RvX2JlMTYoUkRTX01QQVRI
X1dPUktFUlMpOw0KPiAtCQl1MzIgbXlfZ2VuX251bSA9IGNwdV90b19iZTMyKGNwLT5jcF9jb25u
LT5jX215X2dlbl9udW0pOw0KPiArCQlfX2JlMTYgbnBhdGhzID0gY3B1X3RvX2JlMTYoUkRTX01Q
QVRIX1dPUktFUlMpOw0KPiArCQlfX2JlMzIgbXlfZ2VuX251bSA9IGNwdV90b19iZTMyKGNwLT5j
cF9jb25uLT5jX215X2dlbl9udW0pOw0KPiAgDQo+ICAJCXJkc19tZXNzYWdlX2FkZF9leHRlbnNp
b24oJnJtLT5tX2luYy5pX2hkciwNCj4gIAkJCQkJICBSRFNfRVhUSERSX05QQVRIUywgJm5wYXRo
cywNCg0K


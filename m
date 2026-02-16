Return-Path: <linux-rdma+bounces-16930-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FzWOgqEk2k46AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16930-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 21:54:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654314797D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 21:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D778306816F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 20:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C63314DB;
	Mon, 16 Feb 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gX4RF0vG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZC48O1ko"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488B330B2C;
	Mon, 16 Feb 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771274992; cv=fail; b=S1sIuHklEIwZxybEpb96QZgLJ17PyO5zF78g6KT3Eh1w3tuE8syVSe5Pi2/lqX39vCEa+6khYOg9KtQox9m6V6nuruUkAKpYsk3KYl5k9rgtmzqAZVTMR30WKQYLZf8PBkDMgW49sJNrxFwaf4caR4qZQXz6RYpHFxjdjC03iwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771274992; c=relaxed/simple;
	bh=wCQaE7wZ01u7OVEB2960TGjmj37oA0KzqxSXpoKS0so=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gh/sJyRCE5hnVAkQ9mKHzrNNEbE5P6sks3FHlsDJior4RE1k95/l0Ezcwkneg8KrIBZP3/A9Abrj28TZgncs8y7//Rm/aM95lj3A954We3FwAm3mLdGEhwgUdaF2OD50nId1KD1c5ZsFp/k+8cKFawgJrVwKLe7P5AzA5BMZa5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gX4RF0vG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZC48O1ko; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFOLbT2242063;
	Mon, 16 Feb 2026 20:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wCQaE7wZ01u7OVEB2960TGjmj37oA0KzqxSXpoKS0so=; b=
	gX4RF0vGQY/sRtOdnxZSLyjQkmaP771FkUIFlYDZDzLAb7XYInA/QDASe4iI84gP
	MW2DcbAMjRBKMxphkuXt8eLublUGHybcjhKjZdXAiVaqWxiI4Oq/Qcsxgl3YclaR
	xdCRYkhN4zzdx/vVepKbpCENh94DhcU8BVg4eiMLP3ViKcaASVP15QIyjvNkJJI1
	ZN2VF6k+l62a3nANKovyyS0b5TpW2nXlkoTBUL8GZoK5XVDqTVCJUX1HsXBQnvRm
	dvqoiMkJOus1m8tT/hVoNYp8M8rfJwcOHViNkZjh5cD3+jCxXAmeY8z9+0EmEkgl
	LNmPHgvcrWunBafldr7e3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj6majst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 20:49:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61GHjP7M022870;
	Mon, 16 Feb 2026 20:49:38 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cafg8f532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 20:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq+HyWP7j4OowCGot99GDjRYpkxKcwoWnDExwW3ljXacQMUPgyMa6ZJGI08EGRzJPOX+D9XMt0bkILS3vxjL621BI6WtIS8MQDScY013Xh77aMF4PB1Ic2krF2gfLntqCvMBhU3wKFQvuauHeHUZNymM3HykNEt34Jj7StmIlO3yXJc/ePZzdNEo6UFuJCljgOfM5ia+Fd2IeZut90n4FVj0K46WDuX8nARBepzQTgVmGt0EEtl0NlooBJ16WugMYMe7vYzao0UB696bkeCvut007NMcPrANjrLUC9kXsGeukSgdBfaFcJ0fuOkXroky3b2amMecNqyNOLVonlO57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCQaE7wZ01u7OVEB2960TGjmj37oA0KzqxSXpoKS0so=;
 b=Kf96WxV3s2b6bQYUBttQqZ236qbD5gHLtvObigPhFWfU4LuuaSlrQE63ii5wPsXQEPd9itNrd8YGOsTVITZfEXb59ZH12f5HSD0sFXHfpnpu+srYB+k33EKCRNLxYG/nsLmrTI4mD1gfeiAn51Mc6bZoVKwDL+N3dsXccjs3MRwJIqfHVo3THtcVTrWYDK8NcMliWmWSR6J5gpwcQFMBDgA75PTUU4IW97BHLY4kmUl1wluUsjg1KH3Z1H2I3nxQ5JuYpvDvNVUpJxbzggF1LR/CJPuwa4DRincYGoloiJ60HyafZH9GwxLjLLhH5TIdH1nK7hO6RAo92ilHYh8fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCQaE7wZ01u7OVEB2960TGjmj37oA0KzqxSXpoKS0so=;
 b=ZC48O1koMexkCjDycbhNlqwv6pc0QqZhEPyF+2Y75pxDh+sW2ZNqr3WqSU5/t+Y+h8+fn0Pf3Vp9a9Dp5kJS5zOZwYHrDtp7sIp+Yp1a/gOyuLNyaecr78KtHXzkl0eVCnr4Xl2e3Apuk5vpwp5L2TAnQrbAbyUVhOFh0sWP1RM=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH0PR10MB997665.namprd10.prod.outlook.com (2603:10b6:510:384::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 20:49:35 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 20:49:34 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>,
        "tabreztalks@gmail.com"
	<tabreztalks@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com"
	<syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net] rds: tcp: fix uninit-value in __inet_bind
Thread-Topic: [PATCH net] rds: tcp: fix uninit-value in __inet_bind
Thread-Index: AQHcnkohcar5dJwqQE2PsDhDvlhwcbWECAIAgAHG5wA=
Date: Mon, 16 Feb 2026 20:49:34 +0000
Message-ID: <379797e71edae6d39bacb836310a27dc76c7aadd.camel@oracle.com>
References: <20260215070951.213341-1-tabreztalks@gmail.com>
	 <877bsdx5tt.fsf@posteo.net>
In-Reply-To: <877bsdx5tt.fsf@posteo.net>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH0PR10MB997665:EE_
x-ms-office365-filtering-correlation-id: c7a50d9a-0829-435e-b21b-08de6d9ce46f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWM0YTZUYUtmMmdXRWVqa0gvTXl0SjNWSnJ0TEM4UW9uUHJ2aGhZaUFMeVZx?=
 =?utf-8?B?Yjg3a1FCMEJiRzM1OTZBQUswZlRydmpZVVlWT1g3SDdXU3VnaHYwUHgraG5k?=
 =?utf-8?B?QVhwL3ZkbHlhVWE4TzNjRVgvUjV2a1pFZmRuSEw5VHRyTDBjbjdHQVl5Y0FR?=
 =?utf-8?B?Y3BZa2dveGx6bmZGZ0R4T2pOeXdMWC9kaXhQb3pTcjVnaHhkZWNnb21NbDJs?=
 =?utf-8?B?cWVvWlZyS2lTUUhEQW9iUStyajN2SlVyR2RtY091SzZ2TUR2ZjJhK1dpNE4x?=
 =?utf-8?B?cmd5UXljbGpyb2FiRUttb1R5SU4zVGYzT0JEcGE0N0ZYb2Q4bjd1eGgwZkdM?=
 =?utf-8?B?Nnk5dGhoRnZJWitkVDYrY1dWdnRIRDFXN1ZFQzlsTFVJV3NiMWE0a3JpbHJC?=
 =?utf-8?B?T0pLeVZjYnlNNjBEOEJrN2krUXBkZ3RkNzRFZCtFU1hyYld4OTVKdzVlOFhF?=
 =?utf-8?B?YlJZalVyUFQ0OTBsbDhSb3dhKzdCWFJMY3hFUWQ1aXRidHBWYkhhQ2hUa0ty?=
 =?utf-8?B?UWRDcndrNmM2c3lJM1gxM1BiUDdiWXQ0OFdxMW41U293ZzZDYUlEL1FEUEls?=
 =?utf-8?B?bGZZVzdqUVlBZnAwbm5aa1RDWGhiY21uSW9lTEdyL3JDOGltTlBsbnNLTlNy?=
 =?utf-8?B?bU5lN2VKZGtRRTFvU0xGRmp1R2tQcmZVelhEalFWOE9CNUkwL3kxUUxVOVFw?=
 =?utf-8?B?RzRnLzhIa1RjbW9pY05JWnYzNU40WUxBcXFXSDczVXRSMWMzamdDN3o0SWg0?=
 =?utf-8?B?Z0VvTjlrcC8vZWVtZkJoOVJ0NG45Qm5RdDhZNE5Ob0E1R09zOVhCdVNEU25l?=
 =?utf-8?B?YjFCL2RtMjRUNmhIMUtabjFRZFVOaW1CYWhkWGF1ZEVSSzVmR1E4MGkrLy80?=
 =?utf-8?B?NkkwZExmVlZqZkdLUk0yaVlQQ213M0Z5MXJWcHFrRFRHNEtEN3dCUEJnRUFJ?=
 =?utf-8?B?aWtuVllSRzRUT3NKNDJGYk9Vb1JRUW9YTC9xd0R4TTg3SEJYUjJxeWlES1FZ?=
 =?utf-8?B?NENjZ0cvOFY5bmFrVjUzUVM5b281bGhENnBubWpvdGlyRlZHWkVLUk9YTGhQ?=
 =?utf-8?B?cFV1UVVmaE9vejduK2V1MkJRSVhPa0pic3p4NW9SdzB3d25GRnRKOXAxbnEy?=
 =?utf-8?B?T0ZTcEFBcUd3b3F0TGt6dEU0RzgwOXB1d0RxV3ZxNExaaWV2Y3RwOFlTSEw0?=
 =?utf-8?B?bzNKeFdwUDk5Sjk1VGNteWRpOEdUTXV2c2tSeEFIcGtaTnNpdjlIRG5leWc4?=
 =?utf-8?B?dEhFL2V3c250aDBHNnU0WGZ5cU9oL1hGL0pYR2liNjZzdmFHakE0eUNBWXBH?=
 =?utf-8?B?N1VwcVdlUCtITzhSYWROV0lIU1JsODBUcDV1Q20wbEZGU2hmTGx2TjdrMERT?=
 =?utf-8?B?N3dtZnhaT3VUdm9TYkxWRHdRYjFzT0J2dUpMeEhnb0xDdWVpVjFGOTlKdXZG?=
 =?utf-8?B?UVhpOUtIR2gzcUdhdkZZN3Z2N3BJNDJNNkFRQVNkdnF3bUwrZmFCaG1xTUI0?=
 =?utf-8?B?VDJFNHRiVjNMSEdER05mdlNWRjhubDVCVk50WWkvbXpIb0VUTnB0VVZjUEs1?=
 =?utf-8?B?YTRJKzNWOFZ0aisxR2pOTGgybU5KTm5SSXVhNjJGMGFLbk9JYVJTeEd2R0Qy?=
 =?utf-8?B?TVZQRzFDVFdrQ2NNdWgrazFmeDhXdzF3Z2JSeTNVTmVlOXM1L1BXc1Vxdkpk?=
 =?utf-8?B?dEZMb1lwb0VUWEFZM1lYZ1I4MlNmUlQvYkNsZWdQdFpyRzJwYzlxbDFFbm00?=
 =?utf-8?B?T3FGZVEzWGM2YVVIRUdDalB2SFJ0QWVaamNjY1BOTFM5UEtxNWJjQ2J4REk5?=
 =?utf-8?B?TW5zT1Y4UGpHYVd3V2hYZzljNjRRSC9pbS9sOTl1NGdENVZFNlJKSkpTUjVh?=
 =?utf-8?B?VzdZUGZZS1FHaHhNckRBdENuQm9hNEJzVlo2MVU3VUwrN3UwcDByb1VXSjhy?=
 =?utf-8?B?NGFJNXppUmhsek1xVGdhcExDbWJnejAxWUtHdEp4R2d2SS83SHVSSS9QVjFi?=
 =?utf-8?B?bDJDdkplVW5uMkdBYmNEUWRueGQ3WjVwbzBlMDJlL2hLSmROc0dzSXVyNkU0?=
 =?utf-8?B?ZDlpYzE3a2ozQmE4eVF2Qm5KNmdkeElKNFNDQ1o1Y3pFUUZXeXpFdkV3SHBV?=
 =?utf-8?Q?ZvO9qk9TbgH1iFlvHe2wPqH6P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUxYay9Ld28wSlpPSnQveFVVMUw0RU1LblRiNmcrTWFUS3YrYmZ3ZGkvR3Bn?=
 =?utf-8?B?UlM5b3RhTldGKzBOUEQxbFlHbktuNkVEWjJFT0VYdWwwTm5LMVBpNWNMN2hs?=
 =?utf-8?B?VVBpYjZJSzhEWEZmQUlFVUpCdHA4dHhyc3ZvQjNOKzZObEhhUHNCN2N1dlI3?=
 =?utf-8?B?cDNHRFFXOXZzN0ovd1JiaXNDQVovRmE1Y1V4d1E5VlIzWlNBUXF3Z1NRVXdw?=
 =?utf-8?B?ZENnNWNLK2JDRkVqVG5MMm82UExUZGZpbFN6Wko2MjJZcCtTcjRSVGl4R05o?=
 =?utf-8?B?WWdmeGU4MmlLMUV5Rm11L1d4WXVCd0ZmbkdPQStueWx3U1BCOXBsd1BmaUJI?=
 =?utf-8?B?NHIwTEY0T0R2cFphakRlQTZQeDZhdGdVY3FHdjQ4VGw3YkFQY0RQWFhvWjg5?=
 =?utf-8?B?NEg0elFhVU1RaHkzUWo5M1BwL1c5TlFHdEgyWWF1ZjhkanV1RnRSQ1BHT0pi?=
 =?utf-8?B?TUpnR2d1VEV1QkVNU0taM1h4UFNhQTgzRFF5dWlacWlObVlzYXZ1bU0vdDVS?=
 =?utf-8?B?dGEvREllQmc3YmkxRUxmdnB0N2hwUWVFaGNyYUdaaFoxa2ZVTXRGaG9MUjRs?=
 =?utf-8?B?N2hNTlNNKzBMWkNiZ20zVEIvWUtabjUvbFdnR2pZZ3lwREpocUo3dVlUWlFR?=
 =?utf-8?B?V202cGQ1aHhBM1lSVmZvZFJBaS9wakZyNTd3QXhFQW8yYUJEM1lOcXFTWGI1?=
 =?utf-8?B?bWlieDI5aVlDZXgwZlE1UXFML3VIaWxkT3FVNXVSUGNWc1dsc0NQV2kxSThX?=
 =?utf-8?B?N29ZWWFvS3pxZ1lMc2VPSUxuNms0a2NyTzZjdStOcGtkZC9iV0F6Q2xlSk9a?=
 =?utf-8?B?dGg4Y0ZsTThRdjEvTHN1TXg2RWFnUkp4ck5hRHhPRm5nUnNCSm1vVEh3UTNV?=
 =?utf-8?B?dVdDNHhkcnN3MTV0eFBDUWxsUmxnekp2N0FobFY2a2NER0hxazZiYXFFY3dC?=
 =?utf-8?B?d0RVYVNsQzlLR0F6WmJYNFZLMHNaeTlYOTZjRlNjYkJ4cmQrSkQxQXoxZTZZ?=
 =?utf-8?B?QlN6V21pOEdLczgyeHg3UTZtUnkwTEVMNU8zRTNpWkpFMHFDV0h5c0h6TXlW?=
 =?utf-8?B?a1hndm4yUDZ2ZGg5aDJ5TnpOeG5saEFneXZqeGtiNFVIcWZmMmU3VDJIOHdo?=
 =?utf-8?B?RTZ4ajBDUmtWZkFDMHlkYUdRZlh4QWNoQ0tnVkcyMFBUUGNnZ2lwN0ZGRU1q?=
 =?utf-8?B?K0wvRWZqMmw0bnltd01URjBDTFQ2ejdDUEhIN0tjWUpFUFpXMFVBZ0ZkdDFS?=
 =?utf-8?B?dnY3N0ViUkpPUm55TXVqeS9rdktneFhiTEkzSkY0dUlUZ1dXNi9NUTEvMWpR?=
 =?utf-8?B?VEk3QUVTVndtUTZVOXorWVU2d2dHd3YveXVWWjFOeG53bUhrcm1mengrTGph?=
 =?utf-8?B?Q3NiV1NZcDJIclFZTk5MR3Jtb3pwWlJvZzd6d292RzdjZTdRcDljeVJHaVpB?=
 =?utf-8?B?bFRBU0hXTkg5OGNFbjRManVPdmpiRVFpWEF6dlY4Q3VXMDVpc3grM0x4RkVp?=
 =?utf-8?B?OHlVTFYzUnBFUzl1VFhaYUphQ0xRTXNmbFdNaVkyYjdvdWgrSVRsS2hya0hY?=
 =?utf-8?B?QklGL0U1SmYvTWI4a3o0anE5aXl4UEFxNWN0RXhEbkJGbFdyZW5lSFJWZmUx?=
 =?utf-8?B?NUplMVRPeXJ4Mk1lWm4xNmRSN3hidUhJWXdxK1B3c3lsQTRWc28rSyt2aU8x?=
 =?utf-8?B?Vy8yVEk3TFk5QmhkR3g2RFlpWld4MFpUU2NqODdyR1lsN3hJb3dqTTZWdWdI?=
 =?utf-8?B?UkZ4bmhXMHduc3hZMVNjZ3dmNS9UeFFjRlppS3R0VzVTM2xQNHQ0eTEwNDEz?=
 =?utf-8?B?T2RRbTJ2c0U2R0ZvNW9OenBaMTdHLzBVbkhBTW4xTzZVSVVFVTYzSkVDc1d4?=
 =?utf-8?B?cnh0WTJuYjVLY09CT1JsZWJZQkRvbG9KS2d0Tmh5Z3B1cHZGaFUrd2xldjRK?=
 =?utf-8?B?am1COU5BdldrTmdhTHdNQnUrT1pIV1BRYjJ5ZVdVZGx0Z0tvWkgrSmtZSU44?=
 =?utf-8?B?d2t5dXBkWHpNMnJSblUvVlNmTnNhVnFiOGVmVDJjL2l3azF5UlZrVE1FcEVK?=
 =?utf-8?B?aU5LZ1ZrY0RId0FGS01vQWtPTG95L3RidDl1dlpaVllwRUtjRDdyQysrY1pE?=
 =?utf-8?B?L2plZFNYaW5BS2o3czhFbWRFWUl1L3FLdjNlZDJKWDZmNmVFNmovYUdpR0hU?=
 =?utf-8?B?a1Z6MGxXYy9YTzJCMnlEcnJZUUJULzFLNWRmUnhzbzV0OHlSYm1rT3A5OHZE?=
 =?utf-8?B?ZjZRL284UTVtWC9rcnhpUm1WZGFXeTUrQVdicFFXMzJpTXQ5Tzg1ek84SVZi?=
 =?utf-8?B?YVRtZUVyUFVLZkhjYnVxQURWYk1tUG1adTZ6UUNwL1Uxc0t1bkFDNkRDZUZv?=
 =?utf-8?Q?KhDSYZeGK8D3+RDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA6D489FD316BA4EAF8F07A30CC496C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lmkXSHIAvp02rPn3LmqK9wl/5gh8O0AxtuBTiLMz93AR8IV3M1SDc/tm+64EDJinoYYgOOnuTGbTd4CnfizHrK+WEzQ/P5NTV24P9sPqSCU7XzcF33XUu51KR7E0mWLlbhOBJjSOGrFtg4Vh/ljdx+2Hl+QgOCslI+YeLP6IMFoDoLN8HBZzalrI+Q6uYZxJyfRZr1jTvEVo2+8Ny0Q0gFXYaTBsxUTDBJGrb7UWQFJxdkpa/inhc5ti1px4eFmOpduAbcEHBWo7eIngf6r7RypWEbd11yl92UXZGIXsFheMJ9MKkh+JqKPN7VL7GYdrJ8Z/6j7WDaKmzS7zQ98wB57ZJX6fbMXMXtNlWpHPA3vxoIryWQ1BIkscrbyGO/AeBQtBL5Jg5CuBoCbx9JlMmebCOYh6YOkLtEnj708amUW5Xq1fDs6SYIi+iSnrFBEh5Zodk+kFP648mNXXNPiGro7JFUR0UuZnPNEm2MHGiNiNAHur1OD35XassIjRvk+H2kPkCoBcG+zfxNJ76nvwfKVCk7vsp9xCvsxoNO1Njz5l+Up4yPY6pAbvqWklx5vmqcvK2vZsy4uZAGTVw/ki8NL96NCq4Ia0th00dCJfz6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a50d9a-0829-435e-b21b-08de6d9ce46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 20:49:34.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXH+kJc2wvO3Vf+Ph5SzYaXFoKepQU453AZsGcsdY11OKUtt7NpPKxFC8nA/2hRv0iI2dCZgg2NyH4jqybjm+EM4ePHy6ua275fO3RZVySc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_07,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602160178
X-Proofpoint-GUID: oSBbr7eXcJ13N5IDluuP-_NgiBalePbK
X-Proofpoint-ORIG-GUID: oSBbr7eXcJ13N5IDluuP-_NgiBalePbK
X-Authority-Analysis: v=2.4 cv=JO82csKb c=1 sm=1 tr=0 ts=699382e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=G7VsK3Utso4bu9asfPcA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE3OCBTYWx0ZWRfX4xFb7P7CWDtn
 mjRFcJc2UvZjj4ukNCrEj5UwmtvKp1bmIyk6tmY/fNzmEqZYe2mwRBz2yvX3Yec3QYKJp+hqQM/
 bFn6/Ovivuh+6aRpH12wAL95QAU5ZUY6I/MTvOnjLZk8woWhVvS50cq0B3ZWb9c/5quFePS23Jb
 AO21QLP5dogfeOiRewzn963e9bQTEHXneNoXVBm6/qN0KVUCVioAL1J0Sz4MenbgC6wTNW4vcWT
 CwaQyHkHTjd4taq8Fv9YUvxEeEla5C1WvXdP4cllEoCfklWu5573vZzVB+VtorysDypRiGZU1W0
 qOcuWm6b9A00rnMFTQ4q0i0mhEFabSnC0fsTfJIskRqlWFdEUdhQKlXRvAW7tLTDQ/kcCnzIQSz
 LHbUiCWry4V+C5d//tlvDPlnXH0FoE4lZVEBmG3Ua+aU3E3N2qtZHqrVypU5396xsxF2npl9DlU
 MIw/J1/2BHn5qfOFNGg==
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
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16930-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[posteo.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9654314797D
X-Rspamd-Action: no action

T24gU3VuLCAyMDI2LTAyLTE1IGF0IDE3OjQxICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBUYWJyZXogQWhtZWQgPHRhYnJlenRhbGtzQGdtYWlsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBLTVNBTiByZXBvcnRlZCBhbiB1bmluaXQtdmFsdWUgYWNjZXNzIGluIF9faW5ldF9i
aW5kKCkgd2hlbiBiaW5kaW5nIGFuIFJEUyBUQ1Agc29ja2V0Lg0KPiA+IFRoZSB1bmluaXRpYWxp
emVkIG1lbW9yeSBvcmlnaW5hdGVzIGZyb20gcmRzX3RjcF9jb25uX2FsbG9jKCksIHdoaWNoIHVz
ZXMga21lbV9jYWNoZV9hbGxvYygpIHRvIGFsbG9jYXRlIHRoZSByZHNfdGNwX2Nvbm5lY3Rpb24g
c3RydWN0dXJlLg0KPiA+IA0KPiA+IFRoZSBzdHJ1Y3R1cmUgaXMgbm90IHplcm8taW5pdGlhbGl6
ZWQsIGxlYXZpbmcgcmFuZG9tIGRhdGEgaW4gaXRzIGZpZWxkcy4NCj4gPiBXaGVuIHRoZSBuZXR3
b3JraW5nIHN0YWNrIGxhdGVyIHRyaWVzIHRvIGJpbmQgdGhlIHNvY2tldCB1c2luZyB0aGVzZSBk
aXJ0eSB2YWx1ZXMsIEtNU0FOIGZsYWdzIHRoZSB1bmluaXRpYWxpemVkIGFjY2Vzcy4NCj4gDQo+
IE1vc3QgZmllbGRzIGluIHJkc190Y3BfY29ubmVjdGlvbiBhcmUgZXhwbGljaXRseSBpbml0aWFs
aXplZCBhZnRlcg0KPiBhbGxvY2F0aW9uIHJpZ2h0PyBUaGUgb25seSBmaWVsZCBhY3R1YWxseSBy
ZWFkIGJlZm9yZSBiZWluZyB3cml0dGVuIGlzDQo+IHRfY2xpZW50X3BvcnRfZ3JvdXAuIENvdWxk
IHRoZSBkZXNjcmlwdGlvbiBiZSBtb3JlIHNwZWNpZmljIGFib3V0IHdoaWNoDQo+IGZpZWxkIGlz
IHByb2JsZW1hdGljPw0KPiANCj4gPiANCj4gPiBGaXggdGhpcyBieSB1c2luZyBrbWVtX2NhY2hl
X3phbGxvYygpIGluc3RlYWQgb2Yga21lbV9jYWNoZV9hbGxvYygpIHRvIGVuc3VyZSB0aGUgc3Ry
dWN0dXJlIGlzIHplcm9lZCBvdXQgdXBvbiBhbGxvY2F0aW9uLg0KPiA+IA0KPiA+IFJlcG9ydGVk
LWJ5OiBzeXpib3QrYWFlNjQ2ZjA5MTkyZjcyYTY4ZGNAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNv
bQ0KPiA+IENsb3NlczogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1hYWU2NDZmMDkxOTJmNzJhNjhkY19fOyEhQUNXVjVO
OU0yUlY5OWhRIUtvS0tZVU1GVV85b0FqcEhkc2E1cmRhWkQ0OXhONXNXQm5KV0IwbHRiWVNMdUFj
bmRmRDVHZzdrVkxjby1SVzNleF9NVXhacnRkX3lLMkw3VjlqUmJEOWokIA0KPiA+IFRlc3RlZC1i
eTogc3l6Ym90K2FhZTY0NmYwOTE5MmY3MmE2OGRjQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20N
Cj4gPiBGaXhlczogNzAwNDEwODhlM2I5ICgiUkRTOiBBZGQgVENQIHRyYW5zcG9ydCB0byBSRFMi
KQ0KPiANCj4gTm90IHN1cmUgYWJvdXQgdGhpcywgdGhlIGZpZWxkIHRyaWdnZXIgdGhpcyBidWcs
IHRfY2xpZW50X3BvcnRfZ3JvdXAsDQo+IGRpZCBub3QgZXhpc3QgaW4gNzAwNDEwODhlM2I5LiBJ
dCB3YXMgaW50cm9kdWNlZCBpbg0KPiANCj4gICBhMjBhNjk5MjU1OGYgKCJuZXQvcmRzOiBFbmNv
ZGUgY3BfaW5kZXggaW4gVENQIHNvdXJjZSBwb3J0IikNCj4gDQo+IHdoaWNoIGFkZGVkIGJvdGgg
dGhlIGZpZWxkIGFuZCB0aGUgY29kZSBpbiByZHNfdGNwX2Nvbm5fcGF0aF9jb25uZWN0KCkNCj4g
dGhhdCByZWFkcyBpdCB1bmluaXRpYWxpemVkOg0KPiANCj4gICAgICBpZiAoKyt0Yy0+dF9jbGll
bnRfcG9ydF9ncm91cCA+PSBwb3J0X2dyb3VwcykNCj4gDQo+IFNob3VsZCB0aGUgRml4ZXMgdGhh
dCByZWZlcmVuY2UgdGhhdCBpbnN0ZWFkPyBJZiBJJ20gY29ycmVjdCBvZmMuDQo+IA0KPiBBbHNv
LCBuaXQsIGNvbW1pdCBtZXNzYWdlIGJvZHkgc2hvdWxkIG5vdCBleGNlZWQgNzUgY2hhcmFjdGVy
cy4NCg0KSGkgVGFicmV6LA0KDQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuICBDaGFyYWxhbXBv
cyBpcyBjb3JyZWN0IGluIHRoYXQgdF9jbGllbnRfcG9ydF9ncm91cCBtZW1iZXIgd2FzIHJlY2Vu
dGx5IGFkZGVkIGluIENvbW1pdA0KYTIwYTY5OTI1NThmICgibmV0L3JkczogRW5jb2RlIGNwX2lu
ZGV4IGluIFRDUCBzb3VyY2UgcG9ydCIpLiBTbyB0aGF0IHdvdWxkIGJlIHRoZSBhcHByb3ByaWF0
ZSB0YWcuICBUaGUgdW5pbml0aWFsaXplZA0KcmVmZXJlbmNlIGluIHJkc190Y3BfY29ubl9wYXRo
X2Nvbm5lY3QgaXMgY29uc2lzdGVudCB3aXRoIHRoZSBzeXprYWxsZXIgYmFja3RyYWNlLiAgU28g
YSBxdWljayBtZW50aW9uIG9mIGl0IGluIHRoZQ0KY29tbWl0IG1lc3NhZ2Ugd291bGQgYmUgYXBw
cm9wcmlhdGUuICBUaGFuayB5b3UhDQoNCkFsbGlzb24NCg0KPiANCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBUYWJyZXogQWhtZWQgPHRhYnJlenRhbGtzQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4g
PiBUaGlzIGlzIG15IGZpcnN0IHBhdGNoLiBBbnkgZmVlZGJhY2sgaXMgYXBwcmVjaWF0ZWQhDQo+
IA0KPiBCZXN0IG9mIGx1Y2suDQo+IA0KPiA+IA0KPiA+ICBuZXQvcmRzL3RjcC5jIHwgMiArLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy90Y3AuYyBiL25ldC9yZHMvdGNwLmMNCj4gPiBpbmRl
eCA0NTQ4NGE5M2Q3NWYuLjA0ZjMxMDI1NTY5MiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvcmRzL3Rj
cC5jDQo+ID4gKysrIGIvbmV0L3Jkcy90Y3AuYw0KPiA+IEBAIC0zNzMsNyArMzczLDcgQEAgc3Rh
dGljIGludCByZHNfdGNwX2Nvbm5fYWxsb2Moc3RydWN0IHJkc19jb25uZWN0aW9uICpjb25uLCBn
ZnBfdCBnZnApDQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBp
IDwgUkRTX01QQVRIX1dPUktFUlM7IGkrKykgew0KPiA+IC0JCXRjID0ga21lbV9jYWNoZV9hbGxv
YyhyZHNfdGNwX2Nvbm5fc2xhYiwgZ2ZwKTsNCj4gPiArCQl0YyA9IGttZW1fY2FjaGVfemFsbG9j
KHJkc190Y3BfY29ubl9zbGFiLCBnZnApOw0KPiA+ICAJCWlmICghdGMpIHsNCj4gPiAgCQkJcmV0
ID0gLUVOT01FTTsNCj4gPiAgCQkJZ290byBmYWlsOw0KDQo=


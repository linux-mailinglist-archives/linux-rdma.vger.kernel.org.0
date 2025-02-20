Return-Path: <linux-rdma+bounces-7901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68576A3E363
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6D319C162C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB11214201;
	Thu, 20 Feb 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dCOG0CMq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IvgIfD6M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FA20485B;
	Thu, 20 Feb 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074881; cv=fail; b=ktudsIFHcH1I7aemhciepmSlEpzaxtMhohtyvdaYtuM72nvi5f8/aOASzDRdh5c6G8+Wa9+X8M2jJphjRtMzm99/4DvfJ0N3RYlupdxTlKkFfTtyu4FBvRpneFMfCApsL/pJd2VI1kqgm2NBG03AUfcBeHVnV44YqYgZyN312+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074881; c=relaxed/simple;
	bh=YeHkPx/7fmTZORg1OaWCjkoY7Lb1oDlefD21MivffRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OC3soE6xFhtnrXtKX4FTJ/xrUzPXTt6b5t5PS9EN4Kol+V3yKZUWMGcX+Cvqw3eQrvSxlYrjHu2gGd4qWC3UY8vGMV79RsJxI5eMk90ULRA4uyyJrKKamG5+WwuEx4WEYr0zHa2hMuiZLMfb/7xRD/rUYte1c40KBViVN6fJHqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dCOG0CMq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IvgIfD6M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMbbV017007;
	Thu, 20 Feb 2025 18:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YeHkPx/7fmTZORg1OaWCjkoY7Lb1oDlefD21MivffRE=; b=
	dCOG0CMqY/i672aRGas23ZPS7TFLgllBG1SdOq93IfnrJi9sfXQUFBeTvZE2LYSY
	IBv9XtsZ9qaklwjC3ICzhhv/XWpprz5Kqmy18CiChNMRVIoVYFU3fW0TvRDpQl0Z
	aSxsbROc1UKIeUYKyh0khRSJOBwdV+n8xqZm1ZSVRKw68FNwg6hS/rdOPnrZkCxa
	7nD+jLgIaWe065dNuWCxqh+SpGTGd4R+CU4YgM4bFWVX0Bm2iJP0hrz+Mj3UWlel
	ixTRN8WPgB0OOaklMwoHhLSHZVAeDCcUxSx5xWlbIypQbSjmPdke0zMsyBRB7qna
	7W8jEmpPp9SfDQHoI/Ciag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nmstp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:07:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KHsEwD010515;
	Thu, 20 Feb 2025 18:07:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07fav2k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9CzxkgSv0IQwO4GvPgc3s4DD058wLjQDwBETXrFlcYakouYoc23WNXfsasuLnmnPtsEm57qneosC183OauLF+lcYBuKtRGCVslE2ZL1EhCJG1qkvfUnYeWvodW15lPwGPiCbOf6gDzF2OFXjuB7kxy+cBFtgwOvwq7WqXJwsZWoWvVka34ylKc+ZQ6P928pyM2kx14I4+YbtxzIJVgNekXN/gSTTQzQmTRQqhCln669URluZ+/19KtREIubI+jWMaOBB2pMiDfpi46pbQ8ypsOfV5ga0D+6Eveof5syXaK3Dp6DIbOGsf02m68qrX3F9G0ZsBNkGPpr7z0VgKCaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeHkPx/7fmTZORg1OaWCjkoY7Lb1oDlefD21MivffRE=;
 b=oYVz6v7NRbIyddSio96VpV7tpS1BmTh+9jfDg1gsgY01HNFvWn2cj4+mvoKYQZ5cYAjMHREQL7+UsD0XMWDd1QNl4laHBvf+zP48LeIw4Yeh9kZMFAiCmqUcHKvTW3xECfW3arDysOnJ+vXMetbj/IlxHqCZYniOs28UjhvrHH10vwXmF2RYG9GcGFdpnBhy6gzyLsjcm1sCrVIto4c4Xremw4K9iE/EOisdL7rejLuRV+rIMMyKuvx/3t7SPGWsMfPK+6n0/8AbUlk46oYApqclYSy4M24fXk4Bq7Zo2HNC4IH3LP2iJ+b34LGZN2aucyKdM0J9/F8ZAZgN+418DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeHkPx/7fmTZORg1OaWCjkoY7Lb1oDlefD21MivffRE=;
 b=IvgIfD6MuzQJ3dpjHj13jLcoDXVYE7LLwO4eDdUeiw/gBCrHRuzkRJ2N6m8yhgeCUHYgED72wQNFttRk5wRBejYQJIxuQpVgqns7Taq+H9QVct3+cemzcjmeMtJ1cq0Fg8YwQ+HuHaCKUsMVWRVxfhgcsPE1d9Bc/i+ElXCkr70=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:07:46 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:07:46 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
Thread-Topic: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
Thread-Index: AQHbgyBo0OVtXvhkZkCSOVkY1YXPZLNQfm2A
Date: Thu, 20 Feb 2025 18:07:45 +0000
Message-ID: <ab3b748710ad7155df8477646706e8ae05c36321.camel@oracle.com>
References: <20250219224730.73093-2-thorsten.blum@linux.dev>
In-Reply-To: <20250219224730.73093-2-thorsten.blum@linux.dev>
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
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CY8PR10MB6730:EE_
x-ms-office365-filtering-correlation-id: faa9a814-e460-4c85-7b25-08dd51d97a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Um5tR3l0TTdVTGZvM0NNTm9JRHVOSHZsS0dXRyt4YUxzTGVkaDFiUjlRMCts?=
 =?utf-8?B?YW81SEJWbEJ1SHJaYm8yWS82Z3lwcnBoSmhuV0RSMjByUUNhY1hvL1NmK0JN?=
 =?utf-8?B?K1NvNFJ0ZzFnbTkvZUVQaTFZckorZG9ZMHE0Z0JmVVllenZsWlVlQldlOVp0?=
 =?utf-8?B?ODRyOVlHajhuOElWeTdmdGNTOEhubnBNVTJZaEJTK2EvMlA2ZmV3WHRsRDMv?=
 =?utf-8?B?Rk5qbXh2QzBHYWZHWXRrMGQ1cVNhUkV6OUdPZHV5UmxKNVZGWkNaYWVsZVBO?=
 =?utf-8?B?UTVpQ0FwSjY3UEdaSm1tN1ptdUp3YllOYk1lSCtOS2xvSkpLMGVLOFRSZmJE?=
 =?utf-8?B?M1czdXZYenVjVjFicTFyZUFlWVRLMjBOM2lweE4xdS9FbC9EVjBWamJkaXB1?=
 =?utf-8?B?Zm1Zb25nU29OVDhheVM0aHlSL0xsUE5ITlFTUjZKNXd4VXR4YjZ6amF1Q2VW?=
 =?utf-8?B?Y0tucEtvYk1ENUdDNmJjQ2piVzM4T29HZkZzUWY3WWU1VWNQak5LbWIzK1dK?=
 =?utf-8?B?YkJsMEpqcEhRL3dRbG9tSHA1cmo4b0dtREw5NHpzRW9MYjExVDMzQTBFMnln?=
 =?utf-8?B?MlZHVWduSEZMbC9yM21TdlZLdEo1TDhyald4Mm5BUUlCQzhNUEU2eGkyVjR5?=
 =?utf-8?B?d1hIVUlpTmlwNXdpdTlFaHZHdjdJbEEwaVM2S09Mb0J0Z2hLSGNrR3JFdUFT?=
 =?utf-8?B?YnpIR0duQ1NUTHl4bmRLMzcxOGxBbG5sbW96MHB3TDU4MDNzVzM0ZTJDdzRv?=
 =?utf-8?B?Q3dmQWRQckFRSlVKSTQ1dU9teU44aGIxRTM3RkFiZ0o4T3lndDJ6aXR4c2hD?=
 =?utf-8?B?cFlsMHdLTlhwdm9DZi9tdGdzSzF1WjJlcGpXOFd6UUJZckVpSklQL0VzVEYw?=
 =?utf-8?B?LzNzUkFWcklrYWdKbVRsNUQzejJkb0haQ21aamQ4d2lUYjR4SjA0NkFsajk4?=
 =?utf-8?B?MHhnZFp4SS9ZTmtaTU1kZlRpa2R5d0tvcVNDaGNjZGpjcmlUZjRiMHlJdFlt?=
 =?utf-8?B?UlBoYzZEK0xpY3NCbFZuUkhyTkFHN2FLZFU4RXByeXg4RWdOMjBpMWp6MWNi?=
 =?utf-8?B?NGNpaW05RVlCUUhxamxqOTRibHVwSGNPeTJiK2w3c2dIcGpoUUUwS1dFcXBS?=
 =?utf-8?B?RlpJZ1YvTU5TV1E0UTdJYzkrWkZFUkZQQWVKK1VaSlQwQmQ1L1oyZ1JWN2h1?=
 =?utf-8?B?S2ZFZlAwN3ZZUjY3SEd5YUNPc0RBSlZlWWRGZ3A1bmdsMklOME1COXdzTTBJ?=
 =?utf-8?B?d3dvY3dncEVWSWJzTW5tWHAwS29LMHVRTWxnUHp5eVYraXAyQXR4TkVHdks4?=
 =?utf-8?B?VGtObkZLNDQ5WDlxNDN4amU0dHNHOWVVUGNLVi9GUlFMeUt5eGx3SlZscnFJ?=
 =?utf-8?B?eCtQVnBQSC9PTXFoQXZDUHFJL0xReXBDdU11ZzMzKzhWSm50TTRGcTFoaThC?=
 =?utf-8?B?dkNoNlM2SWI4QUpBTnNjMVBFU3YrcU5mSXVZNzJSWHZ6MXZvWXYwdlBnWWFW?=
 =?utf-8?B?cGxuUnZaY1VQQzVNdm5WUUdXd1drMmxZWjNpKzA0dFBMNzQxY0JyY0VSbTRT?=
 =?utf-8?B?WEZhWDdKaWtkQUlWSHNXUXF5UlEwYVpHOEVmTCtpMnZ5ZXF1YlpEY3FpRERN?=
 =?utf-8?B?STloa3BiN09LNFV6a2owbUxqRHZvWlJId2RIc3RhUEgzemkzL1RBY0lBN1Rp?=
 =?utf-8?B?UnF4ZGx4eDdoQWZrSmdndnJ0SDhhMXN1S0ZKc1ZMK3ZqSGVhNVZ2b2xKNnRr?=
 =?utf-8?B?dU44S3NGc0NxUVJLMnlFdXNqazhkTzR3dXBQQTBuc3pnWGtsSnJWc3lTZDI3?=
 =?utf-8?B?OThkNWMva211eEJicFJ6RkpQbEtkUDZBTGRaT293dTMyTGlRNURkcERCOTlC?=
 =?utf-8?B?ZDA4cnh6VGlVZFkreUNWVVI1TGZRSXczaUxuR3hLNnpzV1dOa2lSMmxwem5i?=
 =?utf-8?Q?O4RCy5hfvylAyvVeHGJycXNvvuNr7FU+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2NxeDhncC92Q256U2s5VS81bjExNXhNNUJQTW9QcU1PTWRnZGtaVmtZdGpP?=
 =?utf-8?B?UThxVmRseEZiTmlsaGg2Vjd0anc0Q2QxcGNvSHp4bVljeG0rRS9qQjBWdWdk?=
 =?utf-8?B?NkR5NXlVRmFBK25yanpQRjBIazhTa1VBazJsUzZ6cDE1dU1ZUGFlZWxLNlpS?=
 =?utf-8?B?QWZ4QTBHTlluT0cwc1lYK29Yb2ZIb1BrR1cyb2RwTDY2TldlR2hXc0hIVkpw?=
 =?utf-8?B?SklMWDZGMWpFNElWVEg0TkNvcmEwRzl5d2l0aXY4ZVBXS3lOUGxtTU9nT1Q0?=
 =?utf-8?B?Q25oMWJFb3NjcHdHS0xkNGV4V0pENTJkZE1EMzJPVy9KcUk4T0VVTjJ3dHkr?=
 =?utf-8?B?ZHdqTTlkYWhvUFY0NkFNUHl3dWRWeUE2VTV5NXJmWnA1MUVKa1FmYzFEcmNn?=
 =?utf-8?B?MEFKVkFZOUhnZ3dJdGkyd3VVSEp1QndselpodWRrcVF5ckVnYlMxa3ZzZXAr?=
 =?utf-8?B?UDlHS1VHeHBrN3FHVlhQZEJ4cEZPa1l6R2hCaENRUVBMS0krdVdNeWNudjBu?=
 =?utf-8?B?cFQwL1M3M214L2NpQWFiTzd6YTZ3VmJrNk9QWW45d0xqdExEVG9oYXRrME5j?=
 =?utf-8?B?dCtVb3B3KzlaQTJRc3Y5ek9qUFFnbysyU1k2KzBkdmJ4TCs4Tm1XS0RESTF0?=
 =?utf-8?B?UmRXUmhJZDEvOUVwL2tPeFlZOWdtZG9xSHViU2lvSnNHaC9ZZjZUVU1IQjcx?=
 =?utf-8?B?OUdidjJhc0REbnpHNGoxV2NIK1NuR3huWWxhb0hoVnM0WWdiNXpxUzlPZ3dS?=
 =?utf-8?B?OGRPekI5eEpBckl5eVZObExOYldnWDF4ZkFHZ21JUzk1YWtSUlhRYzZiZFd3?=
 =?utf-8?B?RDI3TEs5YTVLUEpPR2dwbzNiVmxRZVJVOUNnbVZubUVZK081ejk4VHovRkR6?=
 =?utf-8?B?TVlvckZqUFBkbzJmOU5YUTJqZWJzK0MyOXVVLytrTk5ZN214TDV0RUVXOEox?=
 =?utf-8?B?TlRIS29DWFZMcHpScVllcEpwWFV2a3Q5TzJLc2xhVjdxaVhGWis0SnBmYXgw?=
 =?utf-8?B?UUxrZXJlYzdYNUhqRWhualIzK2JvcytKNlRxYXhIRUtRYW11QU1QUmdyaVhu?=
 =?utf-8?B?MXJtVjM4MDNIT01sL0VENWlqcUtOdjgxSlVoMjlBSWdwWXlUeDh5THJmRXUw?=
 =?utf-8?B?aElHbEFGeDhwOUhKUW1zVmI1SWphUXJJMEM0UXYwenpIOHJTTEgra0pSSm9M?=
 =?utf-8?B?RVpKTEI1ZmswOTlsY0FTSExQekhPOU9Xdy9ZMExab1hKM2ZSbGd6NmpTWjU1?=
 =?utf-8?B?YmxrRkZWWUhXVFErZVJLYTFiUlB3aHRyK1pJYmhPMThBRXExeWR5WXBVZDhk?=
 =?utf-8?B?QjZFb1JtTTZlNXo4d3JEQkhFelovUHpRZDkzMXdRYVo5SUpBRTgyNWl4b0dz?=
 =?utf-8?B?aEFqSFBSRitxeXpicXZ2RGVqazEyM2dEenBYNC9NVlNiTWEwOWs4WmZEb2Jm?=
 =?utf-8?B?aHkvdVg5R21vZ1g3bFlES0Ziam9RTnBzN0dhTzZJa0pLcmFEejFrdU8yMnlr?=
 =?utf-8?B?cGd2VUxxN3g0S2dwTGJBWjltNzVjdTV3NHJrSjBsaDlPZmRubXJSU2FvWjVx?=
 =?utf-8?B?L2hFTFBFcXpJcWYxT1hwZlU5a2QrdmVhNXBldURJNHBLYStJR2xlR1V5VHNL?=
 =?utf-8?B?V3lPNmVWMjVCZUtEUmUwcVZBM1U3RXRRT0YzbjUrYjdtYUF3TGV5S1plMFNT?=
 =?utf-8?B?QXp4ekMzQ09oRDNqMzdEOFp6T2hHRTdQSjV2dFVpOWpEVDh4bUZZbGVWQnJp?=
 =?utf-8?B?RWJJQVEzR0toQWtmRFVrV3Uya2NiMHNSTWRxYk9CUjNEUmxueCtuRi9MSXpE?=
 =?utf-8?B?bGU0QzVTTHlBalViQlVlSHRMYk4zVk5UMWlabXUvTUl5MzRQTlQ5VFpkSGFQ?=
 =?utf-8?B?NmNuTUF4NlU2Mk82MWs0VWE4MlVNYllmdVMvMVFxTm44RUxCY0VRRElHRnQr?=
 =?utf-8?B?YTMrVDBaQm14TElZbEN2MXFJaHR5VXdkSkxsTFo4QWJHTGxiQWdVWGVTbUk1?=
 =?utf-8?B?SjNOQ0ZuT0hCVDZhZ1pPZWVmVkVJajRocTlOVVpuVW82UEhObnEyQm5oT2Rk?=
 =?utf-8?B?a1hxQnZWTS9DOTJ1Z092aDMwcUhZcUIxNUJyYnpyQ09DaTJRUE9CUFF1RG16?=
 =?utf-8?B?LzYzSlZBVnplbjM3RmJMNTgyUTkyR3F2LzZ6b05mbm9sR3BiY016aXc5elhW?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <576A95EF4F016B448B722002F7D0AF34@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8n+NP0i3N3m/wn8gAzP2xvLne5s3EQQPK0POE2o3Ss+c8uXN5uwiCst0Ktg5S0RSXG7UfmkSDMYQU3InFPC757Qf+DpIg02cUqRSCYVzuJqT3I+RhTxz6IpG3Ck3ykIJV5Vv/4UMSKuAjhdG5aCpV4jBEGrZ3v44M1dToM27O+/5QaGm7CBud/6btKpQPLPFVwWs2fsuMbllGECfV42QwAIBRf6mRhdBwzbu02g8p14Lg+O1kNqAXNHYYXLwQHhWOBrVL0Xz5ELr5s2i9UE48XG2ArtWF2IqmpAeBf6umlSbtTaW0ANlA3kzusSzgIUAreae4U+vYghpf+e52NooxmT/H7+4oCnDe/k4r/UoQ1o2OsSfU6U0sq8kUTZGsaNhs90szpwnW5XqevFGS0pd8zVe0fMph/0jES5mWv1fd0q5h+giTePCjMQIgOre9gn1yMJcc4xjlYiKkjGwY4lldbtfnmVTGlPiIddX4Ja76Do/oRxi2Xf7RV/wQhanJVDLHUX43y6HosqaenzvoQUAfAbLkL5q8o/FjVfuOJj02Us9I1EKRgMnkqVOKRG9PTT4v6q7sJSbHzdVDzI8vM7B2TffC2V468srkfAysp4e5e0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa9a814-e460-4c85-7b25-08dd51d97a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 18:07:45.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zx3UV8HWXxujf8PMuhEZ03BtG0QNyZvcE64lYWOsn7u7pk0s4qSCycy2rYFaRI48EeewQsZ9OVu7G6/baBVRS5r4LU/FvRu09ww9qo0RflM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200126
X-Proofpoint-GUID: m0NBUSc1A0RY4oT_jXLKFLZHWp3W7rTM
X-Proofpoint-ORIG-GUID: m0NBUSc1A0RY4oT_jXLKFLZHWp3W7rTM

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDIzOjQ3ICswMTAwLCBUaG9yc3RlbiBCbHVtIHdyb3RlOg0K
PiBzdHJuY3B5KCkgaXMgZGVwcmVjYXRlZCBmb3IgTlVMLXRlcm1pbmF0ZWQgZGVzdGluYXRpb24g
YnVmZmVycy4gVXNlDQo+IHN0cnNjcHlfcGFkKCkgaW5zdGVhZCBhbmQgcmVtb3ZlIHRoZSBtYW51
YWwgTlVMLXRlcm1pbmF0aW9uLg0KPiANCj4gQ29tcGlsZS10ZXN0ZWQgb25seS4NCj4gDQo+IExp
bms6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vS1NQUC9s
aW51eC9pc3N1ZXMvOTBfXzshIUFDV1Y1TjlNMlJWOTloUSFNcHFNQW1qNklJeXU3Vmo0ZGRmRUdK
bEpZNHJWckpMX2c4ZXRPUXNIQzdwZGpaTzc3UDdhT3FKZThfSlRGd0J6WjZ0Y2lVRHJiYjJDalhX
Sk1qZEVNSkd0cG9lQmZIVThxdyQgDQo+IENjOiBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IFRob3JzdGVuIEJsdW0gPHRob3JzdGVuLmJsdW1AbGludXgu
ZGV2Pg0KPiAtLS0NCj4gIG5ldC9yZHMvc3RhdHMuYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0
L3Jkcy9zdGF0cy5jIGIvbmV0L3Jkcy9zdGF0cy5jDQo+IGluZGV4IDllODdkYTQzYzAwNC4uY2Iy
ZTNkMmNkZjczIDEwMDY0NA0KPiAtLS0gYS9uZXQvcmRzL3N0YXRzLmMNCj4gKysrIGIvbmV0L3Jk
cy9zdGF0cy5jDQo+IEBAIC04OSw4ICs4OSw3IEBAIHZvaWQgcmRzX3N0YXRzX2luZm9fY29weShz
dHJ1Y3QgcmRzX2luZm9faXRlcmF0b3IgKml0ZXIsDQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwg
bnI7IGkrKykgew0KPiAgCQlCVUdfT04oc3RybGVuKG5hbWVzW2ldKSA+PSBzaXplb2YoY3RyLm5h
bWUpKTsNCj4gLQkJc3RybmNweShjdHIubmFtZSwgbmFtZXNbaV0sIHNpemVvZihjdHIubmFtZSkg
LSAxKTsNCj4gLQkJY3RyLm5hbWVbc2l6ZW9mKGN0ci5uYW1lKSAtIDFdID0gJ1wwJzsNCj4gKwkJ
c3Ryc2NweV9wYWQoY3RyLm5hbWUsIG5hbWVzW2ldKTsNCj4gIAkJY3RyLnZhbHVlID0gdmFsdWVz
W2ldOw0KPiAgDQpMb29rcyBvayB0byBtZS4gIFRoYW5rcyBUaG9yc3RlbiENClJldmlld2VkLWJ5
OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4NCg0KPiAg
CQlyZHNfaW5mb19jb3B5KGl0ZXIsICZjdHIsIHNpemVvZihjdHIpKTsNCg0K


Return-Path: <linux-rdma+bounces-10498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40747ABFC18
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F87B0774
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD12701CF;
	Wed, 21 May 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgxQitm7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ct397r6e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF69281519;
	Wed, 21 May 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847713; cv=fail; b=IEnDva4hzyv2+BgyptVmJLFnz1mD07TacrL54vmfF1Tl50xcR35xi05Kg0ckEDwsnaP9vrkvW2mrVYdpTAN7LWSYrqgylcS0ptNGle9h2tccX19eveAe/gxqA7NAsXczGWhO3PSoGwjYs4tkA/mGRRSlrRGuX7gBebnnmcUGevQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847713; c=relaxed/simple;
	bh=sy/0QKmikzD9ks+CObL3qxRZZ8RCXMY6XdExNmqYu0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYy13okOIJpGBft6cBgtYHkt2HetQe0BuIkR1uWjVgA7tG2s6hwWmxotl1ovur0do9OuAC7XSsS2uvDgGjGPXMUdWNsj4pqOw4ErfK59Uiq7Q69/dzMKqgsbGkzREWN2i4JFI5HdrCWxz3t4QDC0KBVN6eTihTiSeoyGbDTdEKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TgxQitm7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ct397r6e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGussn012963;
	Wed, 21 May 2025 17:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sy/0QKmikzD9ks+CObL3qxRZZ8RCXMY6XdExNmqYu0A=; b=
	TgxQitm7cTRPDn51sxeOtUJvT7xF5ys/jTs0zzINfUZrSZLSsmUZsZsqVX5uGo46
	qvMexXo5F752TGpkDsjlDGwvqTOQ0tjii0KzbsjFmWWRaKY5sXa/6GL8luwn0imp
	rd46wJ3UBQoC7LXFi2VNAQC8BaC1dHPUpvC0fmRJiZFBzwA9lm733Ghj/vfg9PPD
	VT3o9ho3VZ/HggStiLZYQm8mSfCtrx7HpCphatW9aTU9l870kwtXEtILAmAtziKe
	97iutXW8pFTwUKB4k4WXxUCjrBZSjmf8YtvpS4O5L2aGvA7EH7R9Dz1h/E7RxkFX
	Bp8Tk+l6rrqDR3u6v4mAYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sh46rau9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:15:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LH4ahX001819;
	Wed, 21 May 2025 17:14:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwesmujj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7scDddaVhUkl1pRgpFor19s5gVrAimCSPyWUztUx1TBVcqkcVoUiC7H3GfaBVppvPRMRHcSin0d9UoP3TfD4DV1rmBicgpPewJwY0SyS+s1Y4o8bdVBZRm8Q3sk+4OqDTQ+2NA5DI5d7K15+a4WhW3lKX0Op7JEc9T/QJAc8mKjUoxF3znYOMFWEWZfK1AA+/6RYtG56CGFaJ7UZRnNsIgjC4mJOErULonwfEN81U7yJlXPnjxeQz80KK02xtNjWaxil82+7VWTZC54YbCwu1DovRDrYeJJkgGepZQ6nsyroixJ/xJDjReKKaXOOjEFWLYQ6cKKWZBl5Ohbr8c7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy/0QKmikzD9ks+CObL3qxRZZ8RCXMY6XdExNmqYu0A=;
 b=Ym1ps+qCUQ5d88trJVgpIjOU+WHngA3wNnoCzUMHOUOxzyOCIF4S4katzlVK9tHL2VlgPcLVcvLP23R+hCMgV8uJJ4IhE1Tc9xuOXJB7ZesENZdO0AZpjhnyBcg/Bb79SIbKVQXDwrl9vlY5N4kYwvZJA01mIBFArdLkSEQWX/6Oq/S6B+MNOQGT1omCBTsjYUISKQ1ivtCf6IcL4UKKRK9CJ8PSziJ9VNw1jGTlOkTiGsTuRMWiH6y5rs9j4Kt68p9MPsAcMks0eu9Ew8L2yxkmHoNv7FzELxqICiiGBaUTU52gh4ihPdJffj/FUB6nqLaEt3Eg7wgKSQkoahVBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy/0QKmikzD9ks+CObL3qxRZZ8RCXMY6XdExNmqYu0A=;
 b=Ct397r6eXCf+9ifWdNXc9uO0prFgSo7HpO+VCrtfgpZHzf/bNApuzs6Mmrate1WXVXWT65ZCR94RyZe7TZnWS4lpTg+THIEpPv5aQ3/MLx4XYUKZZT+/ODcEZMqbynW1HQpDOZIuHpx6Wh9vLrGCRMttyIMHRPKjAxb3LqSyEwI=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 17:14:57 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 17:14:57 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "goralbaris@gmail.com" <goralbaris@gmail.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
        "shankari.ak0208@gmail.com" <shankari.ak0208@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
Thread-Topic: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
Thread-Index: AQHbymr/8A1txDWK6ESHL8xdp2RZBbPdUukA
Date: Wed, 21 May 2025 17:14:57 +0000
Message-ID: <dac05a17837275f8224ae3d7bb11f41ed0400682.camel@oracle.com>
References: <20250521161036.14489-1-goralbaris@gmail.com>
In-Reply-To: <20250521161036.14489-1-goralbaris@gmail.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SA1PR10MB6341:EE_
x-ms-office365-filtering-correlation-id: 1f68ffcc-73d4-4ead-88da-08dd988b0303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk42ZGZsMmNzRytrcEN3eWNwQ2prSXl1by9pcU5YOStrSUlaY2tiRWYzdlFT?=
 =?utf-8?B?N0xPZVVBMGNWT1MzOTN6ZGhFQkxLN2pSU2x5WFR3Z3g1eWwzcXlyVXUwOTlv?=
 =?utf-8?B?cjYyazczMjZ2L2l4NTBxMUc1bWxsMnFvZzJLV1JuU000Z3Z6ZXkvc1U4Z1pE?=
 =?utf-8?B?cVRvZk5oUE5SbmwzK2ExWXdLT3FleGFPWkNvYmhPWVZHNHI5ZGEzRnoxWGlW?=
 =?utf-8?B?cTNkekZtM3JQYXIyT09CWmwyaWx2UlFqdWZsWnZvZU5UeDlZYXpaQ01yMCsr?=
 =?utf-8?B?cjNscTFFbWpIVVFSbUJCdU9GUi9HbXRYMlBSaGpueEhSeC9RMlRBK2ozb01h?=
 =?utf-8?B?eXh6QStjS0Rmb05Eb2RkSUxIZDYrdW9KYjhhdDJMM1V0RTFGSTVIM2N1Zndr?=
 =?utf-8?B?b1ZucHUwYW1OVFlCOWFERjBvajJJRDNhME0zeWwzQ0NNNG9hdUZLbm40bDR4?=
 =?utf-8?B?UDZjNDUyL2F1SFMxTFFhbm1CRGFoT3N5bkQ5anJpSGhPOU1lNVFteVFwajRL?=
 =?utf-8?B?S09PMGxGcUEyYllhUGo4TlpZUXg0Q3FHTGk0ekNhYXExTXRhRTUxLzRUdVk0?=
 =?utf-8?B?L1J1MmtpZG9DRVdjYUsrSXFVdUxBZFYvSHJ2ZTZQeHVkNmtMUzVTZ2tMa01H?=
 =?utf-8?B?b3BDZmFmcVlZbzZSRGFuK2E2bzZpSG1EV3NMUG5taExpQk1VSnZyU2ZvTG5y?=
 =?utf-8?B?b296YUo5NC9mYUMwTitSU0MvUXNvcTVmd3FPSkRxM3V0WDZpdUlpOW1TbFBh?=
 =?utf-8?B?ZUQ4VUVTd3hlcXI2diswZEpCK1JmOU1rVitvYVNDQ3VxNDBHc1ZmNjJUVm5v?=
 =?utf-8?B?RnhoampaZUhkNFNRWmhPNysrVFBPOWJib0Z3Z1M3b0VHYVlIQ0NvQmRkRk1l?=
 =?utf-8?B?TEl0UXBuL0RuZDBYUFhKZTRMbnZoTnNmaHRGZnlleW9abXE5bm5NVXVmZWZZ?=
 =?utf-8?B?T0M3SzJOcHpkSkk3WS8yRE5OS1k3Sng1RDVtOW9WbHg4dG5CdmdheG1FTEVX?=
 =?utf-8?B?cTQyVFIzZE5zUDZDTlRRSDNvR0RXVDgyQXNFcHlYVGZodVV0Yks1aVpDeEIv?=
 =?utf-8?B?V0JIakpTRTRpZWJSWld0UFpFemljS3NodUNhaGZyd2hwWSt0dnB0WDJ2ZjRw?=
 =?utf-8?B?NGhraVJEL0JLMjYxbHlxVE5zdGl5YmpvUzlkc2VTckg0WVhVVnI5aWZiKzd2?=
 =?utf-8?B?eE90cHBuQ3ozWEJIeEZyMEV2NUpzYitwYzkvN2R4V1BpWjU1VURBVmVuWlpu?=
 =?utf-8?B?NUNKZHphWm9UaXNLZFRUdmkyZEs3ZzMvZmhXTFpOY0ZEMnlFb2I1U2RiNmwr?=
 =?utf-8?B?SGIwbUE0MDNubTJOZ0NHeDEzNjE3MzlzNVAzK3RmVFZEK0s3WU5uVmlBQUps?=
 =?utf-8?B?MWZ0UFZtc3VDaXlvWGpDNWM2SGgrMFM2RjloRDYvZmhSY2szOTJGMWRSNWpS?=
 =?utf-8?B?VDBqd3NCYlBCcnVjaGl2UDkyMkFzSVFwQWF4V3NwaHN3OGk5RittU2trWVlN?=
 =?utf-8?B?U3lWSWp3d2JFYzUxbnZRNm1tSW5LM0NDWm1peXBtVldIeU5OemJvVTZrSnVR?=
 =?utf-8?B?MzRSSjVmMTFBVmNBY0tHY1plRUFlL1J2K2NuQlRWc29zN1diNkxsOGlUSFRp?=
 =?utf-8?B?c0w1VjF5VEhmV1hJTUNsWjM5cEFXa2l2RDdsMnkvYmlzYktOYjVGYnV1U3h3?=
 =?utf-8?B?eDFUUHNIVXBqckNaYmpBSTgydXF0azYzcXhxWTRMRFA3NktvQ09HN0VxUWFk?=
 =?utf-8?B?YmRkNEhqZXRWK215ZTJVeWdHc0NKdW9YMWdadEZ1SnQ2b1hNdGdaOXFudVQv?=
 =?utf-8?B?ZW4vME9UekJxbFlrbWkyYWh1Ykp6NEs4ejRnc2RpQ1FiZnJtVFNCS0ZJZS83?=
 =?utf-8?B?YVpMZHVSa0xobTVxZDgvWU9HdFJCcXFqSnBNMHZzK0txN01HQ2FIUW52L2tF?=
 =?utf-8?B?ZUNYaVI1c0I4aDlnTXBIbXhzK0MzRklaRjFaSVM5MzgxN3owQXBHWmRMRURr?=
 =?utf-8?Q?ZGicX0l4+4Cw0oEgc59t4gealV8xeQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGsrNytKaHJaTGw2TnZHWFg2dFN5Rjd2WWcxRUFXQkdTb1Z3Uy9nZDBiRXlS?=
 =?utf-8?B?cmRFZzFIdndqSGlaQndnRGFkUW92VjVISUxoUXRFR2VjY2VuQnlBZ25FZHg4?=
 =?utf-8?B?TWZibDh1dms4Zm5SbWxkelF6V2FJTkFkaHoweEVGckx2YmhOWWxHNkxWbDg5?=
 =?utf-8?B?dkZNZThQTUdwWjBzV1ZLK0g0dmFRY3VPTDFSYU9wTGpXTTY3RnZuS0JrUE1Q?=
 =?utf-8?B?RmgrUm1Rc1RXZHVSZTNtaGlZN21wODRzY0FoSzAybHp6OEoyTGFzbTdXUWpr?=
 =?utf-8?B?eUlQN0d6TVcrcnBuMHJtVEhZdFZzaXRSWHZOS3dEa0hJZlVTa3lUazc0bVNP?=
 =?utf-8?B?aWljN1k1ZVptb0hEL3RBOTdqTDY0ZUcwaXNKNTlwMkhrRW5XS28yQXE2OGdT?=
 =?utf-8?B?aEtGaEJMUVpwNTVQMkZ0bGVaajZBZnVXWFF2NXh6ZUJENXlOUHFkS2I5eDJQ?=
 =?utf-8?B?YVp1dlF3YXFobWtaK3VGR2Z4dHVETTI3NzEwRDcxSkF5eGREZVhTdGdXNlpR?=
 =?utf-8?B?QzFPSUhQSHhZb0N0aXpqSWQyczNFTGsybVhqakhhb1V0T0lGSnlUellqNW5v?=
 =?utf-8?B?YU1OdXlNMnF4dkpNdDd4ZGI3Rm0wOWpHeFJadzBuYjNXY0x5UGdnNjZwbEo0?=
 =?utf-8?B?ZTVaejlRZjFQd3BNRmNSNTNxTk5VcGlCbWF2a1NtNzdMaDFzbDRQeUczNTJO?=
 =?utf-8?B?TXpiV2pRUHVYR2M3UWxzdjNObFF3bDY1K01LU3hiTk1QQWVBRDhmM2srZHgx?=
 =?utf-8?B?dFRTMlBXRGtZNFNIMFJuOUFHZERLcVBVeEhuK3JlcWJJbEhISUQyVW5QVDll?=
 =?utf-8?B?NUxqbVNIMk9mRi8zTy9wdHRzWFpWUURIMHlrbTVWZDFqTFVJY1hqTWF2RGMy?=
 =?utf-8?B?ZkVaeS9pRnR3WFZyV1BPM0U0L1pNOWtqUEtZQ25QTDRzL1FJWWhBSm1yMExK?=
 =?utf-8?B?SmRtNXY2MnVxTkVHRWRxSU5VVjlSblh4S21YVCtPdDdyZ2FaN3VDMmRLZ2Zr?=
 =?utf-8?B?NTBZbE1OQVRPMWQzdjVLNWpubk0vSm0xTXVEaUlQTkVVZ0F4bzRGL21ST2Ew?=
 =?utf-8?B?SVc5dzBwL242aVZWVUpuTm01N3l2MjBQbnBWQTB2TjBPU0tIcGpKaWlLUWlR?=
 =?utf-8?B?NkZKRzc1TDVWS2p6UEpCSDZUS00vakczU3QrQUFuR2VVandFZXMzMFVxL3dL?=
 =?utf-8?B?Q256MGYzdWhCSmFLRTN1YWV0ZGs1ZDZIdFVsZDdudUJNczY3VlFickx1bGRH?=
 =?utf-8?B?UVNYRmlkYzZPcUNQOVljNmJ0R0RJOHpNeWJlbWJLR0FZSmRRUlVCc2VaK2J2?=
 =?utf-8?B?RDhDVnFUcU8rdmkvSjg2UW5tYi90RC90U2V5RVhPS0JPbXFyNnl4OEIxb0Za?=
 =?utf-8?B?MGxtajkwc3BUaUVReEJTazVHaWl0MmN4MzdrOFdEK3ZmRlh0VG9tcXJuTUYz?=
 =?utf-8?B?RzErVEg5Znd3dXpzWHV1N0ZGZ2hUTGdSZC9WMnhlMkpyS2FGZEVWMjhYYUtZ?=
 =?utf-8?B?bDVrcW9mWk83cm13TGRxRkRCZUd6RThyTkZNcjh4bzB2ZUZkQXdEdDkwbVcr?=
 =?utf-8?B?NVZ0M2FLM1BQVjFwNWV0T05nRzYySnJ6ZWF3VGxHMXRUK0FnODJwdEc5cFV2?=
 =?utf-8?B?QTlPTlY3eFp4aHhDWU5zZ1VBYWppYzlVVDR5WFVQSGJLWlBuemdSc2IwTG9H?=
 =?utf-8?B?Sk8wMC9ZZUcvUWpKZkZNR0kwM3hyRm5OWExOZmdNTUovdER4RHg0ekU0eVo5?=
 =?utf-8?B?cDZEYUoxb3VkRHBzMTAyamx4WFdBRzNucmNsNUVoeHZvV3o2L1Y5QVltVGNT?=
 =?utf-8?B?L243dUk0aWpTNU9DSTV6eEphRUFjdEFZRzFsZE9jZUw3T2phUUlnZW8rUkVk?=
 =?utf-8?B?dkxMRjJvb1UxaWVwMWo0UVU5U2d3WldGV043dkZOaTcwNDhJKzdQbDNkWW9E?=
 =?utf-8?B?VWR6Z0VMMkJuYktNb1VzcUVpNTRkQ1c1ME01LzZ3WGxzWmY2eVk2Zi8wMlFi?=
 =?utf-8?B?cE9UZ3hWVEZiV2VBV0hiSzdGbFZLdkE1LzhZVGdYdVh3REF3ZTluTlJ0YkhR?=
 =?utf-8?B?d2hvTm1OOWxsWXhud0JlYWNhYVp3VlVUM3A5VjFVTUxjODBlTlZZNnI2R0dm?=
 =?utf-8?B?c1dSa21lcDdhcXhFNTRtdDZMeEhCcVlKRUxaSTNqOXJOYVMxNXo4Wk9XelRJ?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B2B31B663B05439E5C16ECA3E4DECD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8l747VjUhfmrxbHfAdbDvJpmVLCpEpgC2YUQo1+itaWj6DTsMZzyTBRbjJBGqpFkGXKkWnAG4LYErL2JK4kLcTpt0+VPum1BPGb+76IwTFlX7l1Rwj6fxDVMHJMAhGA1tPivxe4q0iO+8w71ofFD0U9DxaygcJ8DyiVLSmgFZ/Mj/rqREV1uQr11zaOBvCpbwVYPQdv4K3ardqgzt52f1ZkD3d5LV5vsw5nOfn8WBjfGjIEgFVFQjmjUQDl36u7YFcEhbrOIXBfyr75Rk/7cacomXwQ21n0alK/s1VOlbd3IgCTczBEH5YBv1UvUF8skhqajnUZRNKUo4Pm/Km8T2yu62SNmqvarAKYsLRe4/vNUUtJhs71LBsu3C6E1NLSBF/p/ghYIVEdBOXOVphRSDj+Kw7xTMFZ5lRV9FL7cDQ9NVcBzQRAMJNsgTyt07ORt9WZX4YV55RLBtuFYKhbJUeWDvPW21/iQEMNB9D+xr+yElfW/j2UEY05XKcWpq05Ez3IwWjBsxeHiLJPgpstDvCHzreSiX4GzeUyZOEQRMjDpom4aW82JzreS/0yEtAifa3StontdR8jFsyXIN5/LTaN7Ab3sr/fp2FZem9Dl2Gc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f68ffcc-73d4-4ead-88da-08dd988b0303
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 17:14:57.4367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1EUlvw+BzpfCx2vHvanCV1Dk14IoSKel44wEXdCmbIGwmGNFAuVyMQycl2Z9ARomLFUaGzx1PmsNdX+wW7kHH+0hq/dgGK0p411OzV4xZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2OSBTYWx0ZWRfX5h/rz+/sOdFJ mnDz88s6MlepUPUSbfcLre/VMx1503VuNnm5C+pbITBwOLesaYlDyS8UK75QLptqKWy19dHk2rD y3tZatxuza7o2Iew2kF6p6jNvvhW0nla36xv0WVL8+J9OFbx30gj3reScUyBAHky6eKC7TcJUJ7
 vFKjkxVgjQFX3C+DP9j5RW19d7a/gA4ov0fJkAHfVETTFwd+g3HZ323JGg/0iAWPGdxRdyqZQ1/ ATr82mjcsw4wrGrXu+aEjhNk5vXYzrhvYK7yHMCK5g/u9q1rkevoFm9N+Ovl0gUJDTqL44GMLMw dY3W0YYoZFRp3zPKyODVtnOKPRUDTCr/SYXCvEz/gZeqbKZxCmy3t4R/f/9baVGxjm5eUprOiuH
 ivb2oYfUWK7UTj3IxDbwM6xr5+RWYZnxqpB9PiCeV6rG15UMJ6Vnhpgu8ae1QcTixnXxHpxe
X-Proofpoint-GUID: vZOOAgD6hL8SjtHjSK2lRjlS5jCe3eJH
X-Authority-Analysis: v=2.4 cv=POUP+eqC c=1 sm=1 tr=0 ts=682e0a14 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=jtA1FCoBBHDSyEzX1tAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vZOOAgD6hL8SjtHjSK2lRjlS5jCe3eJH

T24gV2VkLCAyMDI1LTA1LTIxIGF0IDE5OjEwICswMzAwLCBCYXJpcyBDYW4gR29yYWwgd3JvdGU6
DQo+IFRoZSBzdHJuY3B5KCkgZnVuY3Rpb24gaXMgYWN0aXZlbHkgZGFuZ2Vyb3VzIHRvIHVzZSBz
aW5jZSBpdCBtYXkgbm90DQo+IE5VTEwtdGVybWluYXRlIHRoZSBkZXN0aW5hdGlvbiBzdHJpbmcs
IHJlc3VsdGluZyBpbiBwb3RlbnRpYWwgbWVtb3J5DQo+IGNvbnRlbnQgZXhwb3N1cmVzLCB1bmJv
dW5kZWQgcmVhZHMsIG9yIGNyYXNoZXMuDQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvOTBfXzshIUFDV1Y1TjlN
MlJWOTloUSFQbkxVbUI5ZFVNVUdkQjBkREFFQk02SXlvUVZFdEdMVW43NTVxeFNLTlRCbkdkTXpQ
eUROMGNEQVM4cWlqellGS1huTXUzQXBMbk4wSmMzWUJCZkN0emg5JCANCj4gDQo+IEluIGFkZGl0
aW9uLCBzdHJzY3B5X3BhZCBpcyBtb3JlIGFwcHJvcHJpYXRlIGJlY2F1c2UgaXQgYWxzbyB6ZXJv
LWZpbGxzDQo+IGFueSByZW1haW5pbmcgc3BhY2UgaW4gdGhlIGRlc3RpbmF0aW9uIGlmIHRoZSBz
b3VyY2UgaXMgc2hvcnRlciB0aGFuDQo+IHRoZSBwcm92aWRlZCBidWZmZXIgc2l6ZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJhcmlzIENhbiBHb3JhbCA8Z29yYWxiYXJpc0BnbWFpbC5jb20+DQoN
ClRoYW5rcyBmb3IgdGhlIHVwZGF0ZXMsIEkgdGhpbmsgdGhpcyB2ZXJzaW9uIGxvb2tzIGNvcnJl
Y3Qgbm93Lg0KDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVy
c29uQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgbmV0L3Jkcy9jb25uZWN0aW9uLmMgfCA2ICsrLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMvY29ubmVjdGlv
bi5jDQo+IGluZGV4IGM3NDljNTUyNWI0MC4uZDYyZjQ4NmFiMjlmIDEwMDY0NA0KPiAtLS0gYS9u
ZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiBAQCAt
NzQ5LDggKzc0OSw3IEBAIHN0YXRpYyBpbnQgcmRzX2Nvbm5faW5mb192aXNpdG9yKHN0cnVjdCBy
ZHNfY29ubl9wYXRoICpjcCwgdm9pZCAqYnVmZmVyKQ0KPiAgCWNpbmZvLT5sYWRkciA9IGNvbm4t
PmNfbGFkZHIuczZfYWRkcjMyWzNdOw0KPiAgCWNpbmZvLT5mYWRkciA9IGNvbm4tPmNfZmFkZHIu
czZfYWRkcjMyWzNdOw0KPiAgCWNpbmZvLT50b3MgPSBjb25uLT5jX3RvczsNCj4gLQlzdHJuY3B5
KGNpbmZvLT50cmFuc3BvcnQsIGNvbm4tPmNfdHJhbnMtPnRfbmFtZSwNCj4gLQkJc2l6ZW9mKGNp
bmZvLT50cmFuc3BvcnQpKTsNCj4gKwlzdHJzY3B5X3BhZChjaW5mby0+dHJhbnNwb3J0LCBjb25u
LT5jX3RyYW5zLT50X25hbWUpOw0KPiAgCWNpbmZvLT5mbGFncyA9IDA7DQo+ICANCj4gIAlyZHNf
Y29ubl9pbmZvX3NldChjaW5mby0+ZmxhZ3MsIHRlc3RfYml0KFJEU19JTl9YTUlULCAmY3AtPmNw
X2ZsYWdzKSwNCj4gQEAgLTc3NSw4ICs3NzQsNyBAQCBzdGF0aWMgaW50IHJkczZfY29ubl9pbmZv
X3Zpc2l0b3Ioc3RydWN0IHJkc19jb25uX3BhdGggKmNwLCB2b2lkICpidWZmZXIpDQo+ICAJY2lu
Zm82LT5uZXh0X3J4X3NlcSA9IGNwLT5jcF9uZXh0X3J4X3NlcTsNCj4gIAljaW5mbzYtPmxhZGRy
ID0gY29ubi0+Y19sYWRkcjsNCj4gIAljaW5mbzYtPmZhZGRyID0gY29ubi0+Y19mYWRkcjsNCj4g
LQlzdHJuY3B5KGNpbmZvNi0+dHJhbnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUsDQo+IC0J
CXNpemVvZihjaW5mbzYtPnRyYW5zcG9ydCkpOw0KPiArCXN0cnNjcHlfcGFkKGNpbmZvNi0+dHJh
bnNwb3J0LCBjb25uLT5jX3RyYW5zLT50X25hbWUpOw0KPiAgCWNpbmZvNi0+ZmxhZ3MgPSAwOw0K
PiAgDQo+ICAJcmRzX2Nvbm5faW5mb19zZXQoY2luZm82LT5mbGFncywgdGVzdF9iaXQoUkRTX0lO
X1hNSVQsICZjcC0+Y3BfZmxhZ3MpLA0KDQo=


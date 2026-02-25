Return-Path: <linux-rdma+bounces-17141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPBHJ72PnmnTWAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 06:59:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFC192340
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 06:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C31C2303B941
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26FF2E88AE;
	Wed, 25 Feb 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wic3IO6f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iYW/qEMy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045F2E541F;
	Wed, 25 Feb 2026 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999162; cv=fail; b=MqYfNOssXZXyiGn47UGpOeb0r23Ppq1Pw2xS3r1T3bYGX2pknYZ0ZphRk+tPtOlK+qzlYleX0aKUVkVe/oUcwjxez+uuM1cHVGF5q1jO2f5ycIN8+IwgwUgmcTa5UOwQwiw/IB5Y4Dco39Lsp7fk+AS4rZCd8c2TED+fVQJuyL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999162; c=relaxed/simple;
	bh=nYHWJsbJNJ8KogTHHnREtNlsoy1yj5lwxe1hPY/wtvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3/uVlY8C3TzsXwJbhlUotqP7Osj8CZhnULw7quOEztE9lWt/lqE5L/ezqe4UX3E23idwctp89WF1COijpSBSRRobX3Od7MbhGS9/cjUQjHiHO8RSnBEh6K7kLm6+XaCIZeFHghE2TQI3pZgvBOWRD41qSVYz42fCHiFJulqzuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wic3IO6f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iYW/qEMy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIuAHr1959902;
	Wed, 25 Feb 2026 05:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nYHWJsbJNJ8KogTHHnREtNlsoy1yj5lwxe1hPY/wtvs=; b=
	Wic3IO6fQCrjCbUmOemFtl10ti/88qriwIpfduZSTp2D+YRjliuVdi+kE1t8RHch
	cQKkAgeonsGkCM5/GoSSrwbCXeCfmYiZ3UFJ84tllQiAsGnB2GKxLdNlg+A59osz
	t1K6meTYbdZAPpWcAhwdTwwbDAX6u91NhwC/e01FFFjUjJVzCdiiwn5RCvXuxMS7
	VErUr1PgEh3+iopJtzb3Sk2BMMxel+N2QDXhiY+w8xQozOV4Vq+ByndK4AMC/0Ir
	7sl9NJobGCPNA7PowbmKi8zbdEWJ/8saa2KVyaZOPlxmBqFtQ959zpNHKo1AfSJd
	5Z7ObeBelfghg1QXP3LFXw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4rbdk23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 05:58:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P5LH5B027810;
	Wed, 25 Feb 2026 05:58:53 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35fpmmy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 05:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkPxQZq27Uea0JJrNx+u5s+HZetD2y5ckXdcA5TIibMwfeI9sYoe5MusKqHyWUN9hVTdBUyFS998MGi7HHpqWBUY3WMcI+PpOHJWEgNlQVvTn90LHW6rJfeGQddOZ7hIPCPd6Pgyy/DtYSfB3eR4TWdvEcvm4wIxfNQSY+hsugplZcJaPLNtNZBlUO92HYYRPsFc0yykjgn4LJDV6HaxRhaJ5V0AU0I1XLd0AplSFUkbhs7FEWpO3xOwTxlZY5VvCB4yrq66HDpxOxOg3J42j548LFguwEcL3TLGbX5f90/k+TpHQ89NeNRPXTSiyowagxA5rI/Dw46uv2DxzoV45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYHWJsbJNJ8KogTHHnREtNlsoy1yj5lwxe1hPY/wtvs=;
 b=NWce0yS/G6jREavap/hLAIVD/ma8WxBKlTGMr6xcPIyoJEEMW3fjtecls08xegwX5Xq7YDR4L9HaoAlLQbptafI6pTywq4kkXimSyHh0cySjM2deulqFNKvE9t7RSz9DbpX7hSNIstQAj+q9DwVWLKe+Ta6IcRo9OFtVAznaDJ07FDr4UVUNCaHhAq10grVuPlHfxTqgTjTq8VEVcCZ1ezviYhUodr3p6WyKWoEF9wXKtoDUJWNj5nlSnSA//4WOVdpqobgFtoOlBzS31BwnnTqI4uqFP67gyHmeXf5g/Us+uAYPzPQl0gvfa7gHBoV6K7BK5QCB529hm5nOAnKGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYHWJsbJNJ8KogTHHnREtNlsoy1yj5lwxe1hPY/wtvs=;
 b=iYW/qEMynjg8kVwtSKxdSRpiHBPOdNUx4gJ34IpLRw7kRMiQPSWlG6yIsDfhIIfvx2NvmcmWPikY5E/IWi0LVbazHiEiU4SUDTJw2yt1uELeBsQ5M5vDK/HaZe+/kvjtITfxqIoSIJte4c+pudV+RVPMayqdgp9i6YqJvLLjzcU=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA1PR10MB7165.namprd10.prod.outlook.com (2603:10b6:208:3fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 05:58:49 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:58:49 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kexinsun@smail.nju.edu.cn" <kexinsun@smail.nju.edu.cn>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yunbolyu@smu.edu.sg" <yunbolyu@smu.edu.sg>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "ratnadiraw@smu.edu.sg" <ratnadiraw@smu.edu.sg>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "xutong.ma@inria.fr" <xutong.ma@inria.fr>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net/rds: update outdated comment in
 rds_send_xmit
Thread-Topic: [PATCH net-next v2] net/rds: update outdated comment in
 rds_send_xmit
Thread-Index: AQHcphi4Q+RrKZvBUUqTLtvZkBfA/rWS62uA
Date: Wed, 25 Feb 2026 05:58:48 +0000
Message-ID: <bcb9bb36fb4d2cd2dfeac514970b2f1c70493e08.camel@oracle.com>
References: <20260225053544.1971-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260225053544.1971-1-kexinsun@smail.nju.edu.cn>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA1PR10MB7165:EE_
x-ms-office365-filtering-correlation-id: 90bc7f29-8ee6-4ecb-a301-08de7432f207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K05XblRQNkE4aGJzazloemtBNzR3TzVhSXBGNFV5UnNRSUFMdUhXQjJiclY2?=
 =?utf-8?B?dTdGdFNaMUtpeTU5dnU5YzZ4Zm4rQlE1OHZFZzN6ZitYRkFiRGFoYXNqZ1Aw?=
 =?utf-8?B?SkRqN2ZGVzZBajVDV1ZMemNSeGtKemZLM3RianZGd0lHU0JsMWF5b044TGxE?=
 =?utf-8?B?bUx3bkZuQmdVaGp3Wm93YjltZGdVTmlPbU80LzRCT0FVeUxDMWwzeWNwZTht?=
 =?utf-8?B?WjJrZDgxeUE3ZFRkL3ltVm91RjlrbjdKZ2RHYzdMeEFrM3VoSFBVcDZNczVo?=
 =?utf-8?B?TGh2cVBvN3JIOUZON3d5LzZBaEtSeG9uT0I2OXJqRitpV3hzOTVCalRBWkll?=
 =?utf-8?B?Sk14bmIzMllpTmh2WTFhMWc0Y3lXVkhhSDVwdWZ2L2p2MjB4Yk5lWkdQWDhj?=
 =?utf-8?B?ak9EMkhUR2xBTXBEaVhRTGtaQVBtZXFtMTZjYkx5V1VtWVFmNExUOFBWNmp0?=
 =?utf-8?B?U3pMQ05LaWFNbDRLZGphZWZscFFjaFhITmhwSVl0ZHRhZlNZdWRBRFhmZ0FI?=
 =?utf-8?B?KytrQXJVSi9NMVkycWNJZHJsdmpXR2g1V043cWxZQm5SZlEyWWlnMEF3LzdP?=
 =?utf-8?B?Zm1UdEtqZHJSQk5PbG1tWnByaFlITVVKMXJCNllNMW5sVXZnbC8vQkZBaDl5?=
 =?utf-8?B?VE56enVNOEFSVERCY0dISnFINkN6bTNwek9WemFOMUg3VktSd1ZUL0g3enRh?=
 =?utf-8?B?a29NWENjYVQ3dzhWVnVnZU5HT1FsWk1WZks4bWNQSWVrQ1ZLaGhKaWJkc1Fu?=
 =?utf-8?B?aEtialkrYjZUaXJFLzNYRUtIMVl0b3V2K01wUGsvMlV2Q2R2M0ZMeFBvTnhv?=
 =?utf-8?B?ZG92REsvNVR2RG92V3lQQnZ3NmVrN3puOXk1OE15VTJLeUtUWUVDTGpycmpz?=
 =?utf-8?B?M3Bvc1AwemZZd3VxSmk2dXBJbzJQQ1lnMlo5QTg0alNJSkNxY0JPTGNTMytW?=
 =?utf-8?B?Z3hPNVdGTlMvSHFETnVOcmJneHhxKzZlcjQwR0tjb0tsN2xVazl4cjVJVkxV?=
 =?utf-8?B?Y2dxcmducldJRllHWjN2R3d4aUlueTZYWW1mZy9ET01jME92eHhDWmtQN2hk?=
 =?utf-8?B?YUJYeVQ1SnpRNTYzSWJtdGpnVG5SNFZiclpaMWx0OEJPdTFZM1M1dythS1ZI?=
 =?utf-8?B?NlBzMzRQS2swSzYzZ21RTGNJZlR5N3l3RCtyV2RsaloxdjVESlM3QndneFA0?=
 =?utf-8?B?TGJWMG9DcjVSWWlqcFBwcGNHdk1MR3c2bUYvL0YzRzA0RENGb3dOU0NaUG1W?=
 =?utf-8?B?TnByUWpqVGJGbjVNUjhJK3Y2eS8zMFFiN1FySVErNjJIQU8rODV6L3hxL25B?=
 =?utf-8?B?NTFTNmNjYS9qeUkvaHpQeWVSbHMwTXI3elU3VDlZQjJ3ZEQvZzZnVUdnNlA2?=
 =?utf-8?B?QU9RQWZoRUg3RFNTcVBjL2JhK3JXTmJkTGFFZ1pEQVBWRVYvdFV0RnV5QjEr?=
 =?utf-8?B?SVlnbWVVcW4vUVpnOEowSXVSdFdPK1Bld3NScklSdXhTNFMzSER2cnZOTWpS?=
 =?utf-8?B?WWw0dERCYk1TTU4xYWo0bkhzclN3MUZJY1VaVVlEd05NcU5tRTVVOXY3VGUw?=
 =?utf-8?B?WEtmTGpjQ2JJTG1IZzhaSllIUEV6b21oaHhoSHgxT0I1WUo3eUxKb3FoSktI?=
 =?utf-8?B?UFRDNlF5NVRNeGxkMnExb3kxMitONVl5RkhsOGdXNVRpRXpQZU02T0pVUFZn?=
 =?utf-8?B?QnRiYVljOENhTm8yRklucVk0ejJOcWg5WEFwa0VreDdJREUvaFZGaGptVkto?=
 =?utf-8?B?U3hJOW9ma1hVUFVQcVkxSjNSWGM5NHBCdzBaTllpVFJtWGMrQTVVMEMwd2lw?=
 =?utf-8?B?N1IyMkNibDRMWmVWR252L3BneEU2ZHJTRE9CeGYxZ3ErMnRhY1Y0ckM0Qkww?=
 =?utf-8?B?MDBQWEN0eGN6aFdjNDA4dVVQTjVoT3JkVzd4Z3Y3NlZLTE5UdmluRGQ5U1Bl?=
 =?utf-8?B?ZlYwOFNlbjBoMXBEbEJueWhmZ1M2Q0hWSzZMek94bXhqQWZNUUs2SnFRekN0?=
 =?utf-8?B?dG5LNnY4QytMMkp6R1EwZXZEY3Z0RzB3TUxZYVJjT3RxZTJ0Y2M0cnQ1MnFU?=
 =?utf-8?B?Qm4zQ2Y0bjk5OS9Yd1RnWFhGQ3Q2TDhlZTZsZ0pBc1R5Q2YyeVdWUEtaK0ww?=
 =?utf-8?B?UXROSlRhY3pTc3pUTE1nV0szN29IOThvVncwU2lvQ1ZwaGdFbjc5M1lWbWtz?=
 =?utf-8?Q?nbHbCA/osVlXU22rQDgSTEs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0puUUowaU1pb2EvQ1pONGMzZ2I5ZVp0dEdSNkNGZVlPWWFSMWtEd2dmNWdy?=
 =?utf-8?B?U2NTRDhVM0sxMDNhYWtEaHFvd0JvMTVOMVN1d2VNWGtraXdFSlA0c1Bnc0pC?=
 =?utf-8?B?dHRVa3MvZ2tDMHdsSEZlVCt1dUpYa1pKbG9rUVNIM2czQllZTXBNUWwzTEFm?=
 =?utf-8?B?V0ZSN0tWeWhydmV0VThYdnd6Vmp2UGUwWmJEK0Foc3N0Y0cyY0x6ZlE3SzJ4?=
 =?utf-8?B?a2s5Vi9GRGZiNGlWQlNsUWx3UjR3TXQ1Q3hLSk1FWUxiQjZZK3ZtT0UzN3RF?=
 =?utf-8?B?K3FZZEpzcFByRmRVWjhxY2ZiMWF0MnpQZHhmVmxkcmVIK011UXQxR3FoVEdr?=
 =?utf-8?B?RlNKOFRmb3praWhGT0hlR3JlYVk5dUQ1N1gxbDJhazNWNUU1UGNYbGpkdm9k?=
 =?utf-8?B?VWZxVTFGeGI4WjE2M0JEZnR2UTIvQTRUVXF5TklnOCtKeXNOVnJwNTZPR0F6?=
 =?utf-8?B?Z01QakczangzK3B5UldGMUxQQWhVL2lYUTl4VXBXWHJSM3hWeGxpZWpQWmc2?=
 =?utf-8?B?Mm53TE00eHdFOHhua1M5L1o4cGRuNWhkU0VselRvTVFVTHV0a3oxYkpIY1Rh?=
 =?utf-8?B?ZTJ6ZkU4TFpPM1VORnFnT0tjdUtqTlFJUVhYVXAvUjI4OXY1NE91WXFYZE5p?=
 =?utf-8?B?YlhSV21CbThBRTRqU3ZpN3FXYlNxL1RrL1MwbnZEQlRPOVdOTzhLOU85bXRz?=
 =?utf-8?B?NmFBN2ZaemFUTENOZ01SeUVCblV4L2NONFFIQmRqajZGUFhNRWNOTHFYSnZ2?=
 =?utf-8?B?eVJHUXZkdnhHUUI1OWdNNiswSnNhdDkzbjlZQ3hYS2VJNUZSLzJNaGNsaWdl?=
 =?utf-8?B?ZWxkcjVtd0FwTmlGb0xYSVowdXRRbzhDU3AwQW9QUWViM1MwRDFOYmFpdWMz?=
 =?utf-8?B?ZkJwU1VaUXlCT1RyUlQ1Rnk3Y1Bqc2xvVmMvRmlCMU9iZkFvVGJZZkpQK05N?=
 =?utf-8?B?VWNFZG5sYnBYWTUwaTZLc3VWU0xRVGdjWTEwN0lFRGNIWi9iZytJMDJVVVlj?=
 =?utf-8?B?U1BHdkRNMWRSakhRNjQ4T3Ayb1NhODRKMnE2aGlRRlMzT0lTNmZBTEZSUG9H?=
 =?utf-8?B?d3cvVjMzTjB6Tk5GSW5NVnJDYzc4TkhGdGVqSXdKRThqWTdJSmJYb2JwUWc1?=
 =?utf-8?B?TnNyZVZ0UmcwdWJJZ01sTEFTNXNXNTlUSnEzSGh6VFZsdzVGRG5aTHpEZEVn?=
 =?utf-8?B?cXZuVWJSQkpSUkVDR29XMVNSNkZrcWhCZHkwdithRkNMZ2dxUUFOcWQvSkR4?=
 =?utf-8?B?bnJCQTk1VFE5VkNDeDhkMHBWOXZuNzdWZjhBT3lFZ0FwU0dCQWtaWkRpMGlu?=
 =?utf-8?B?cWllUnJpWG5XamJ0VCtsYlhTK2hXMDBqKzh1UFJQaGFzcXNrbVZSR3JUeGtY?=
 =?utf-8?B?S3F6OFE2Q1JNM2xTcTlhSFkxUytob3phYXpyWjkrK2RZRVNNNVZLU3pqZW43?=
 =?utf-8?B?U0E4bC9hMm1EdVVOdWxzNkxrY2lhYTVMWHR3amlVSWcxNU9YUVZSNW0ybG44?=
 =?utf-8?B?bDJmOTZnZzdYNXFnTjZOQ2tydlpmMlp2aUc5aFp4cWN0VWRDZzgwSkRYRW1F?=
 =?utf-8?B?akl1YysyRERpQkhNZFU4dFNsemNZRTNqeXZZN2wyalRxM2NvQmdvUkN6UENN?=
 =?utf-8?B?OERDS3pLOU9XdWNQZDNJdGY0N0F0MTEzYkNKMmFWaHgwOGxJbFg5SGVsNWpT?=
 =?utf-8?B?VTNib0RmS2pPUWZ3QlR3RTJhOHNyYmRIU2NrdlpjWi9vZjhVYTdEMHg4cnUx?=
 =?utf-8?B?NUZ5ZEI3U1h4bmd6ckNMUzhLNUJTTm4rR0xqdm4xYm1mNHZhRFpyczhkcHNO?=
 =?utf-8?B?NzVxN1p0QW9GUmJqcDZNTVBkU3NBRk1nOWZLaEFRd1pFTnFUT0lNRXA0TFdt?=
 =?utf-8?B?eVhRTEFDMWsyVWIxWUt0a1dGRGVSS0lHM1d5T3hjRDRRR24zbythM0JBUGxP?=
 =?utf-8?B?MWdqR2U1YVJ4SXU2ZGZWWWlrNmxVUkV6eUR4MHFxajZBTUdtRENib0JjMVNp?=
 =?utf-8?B?WjF0aVU0dEJwWWFoTnJDa1haM2F4L1BnZUYvOVFvTVFJdmZCaXk0ellvUXFB?=
 =?utf-8?B?OEFyaThTK3dFMXBkOFVYK1pXdHhsRjJIMEd5V04rd1NhRmFjeXNBYWdXSmhh?=
 =?utf-8?B?U0xpcGMrQXdkZlVTU0ZZbEg3VVBYaUxrRUQrMlNkVTZTZDZESWVrZG8wVXRz?=
 =?utf-8?B?OTZZVFp5bmZXMWpLc3BSWm9CbTdGMmdvRjFxeVVGWmdORWp2Y2VFZjA4MVJT?=
 =?utf-8?B?NDZuR0NGRFZBb1BzclRGcjNwTitrZXJVeHJza2FSRFpIeGVaK2c2Vng2UTdE?=
 =?utf-8?B?Q3kvRzVuOURKQ1ZSWXJqK05HVzQwNDlRRnBwNWFUS3JEVTBDM2MrSmU3YVlT?=
 =?utf-8?Q?cRKw5MZUVFVjfQ2Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2069411E40B6D43BD680A4439A14A8C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sQ48K/z6Jro3P2B3OjSmdBk3aRXDZtumG4AnwS6xMdJbmb9TdEHYnc87rAeFlItFDp/5WX0MyiLEhIgfjG/eXVprpiaOynTEDEmdi8Wy1236gLi2l4XIuc2QGf3mBL7tpp+M++vOrpndyOQeDuCbw4YHDgrbfDbQiVftGiYAKXJw6qQcSTxdbc9tWwdtFcJwJOLiedzXl+GpaywyVwC5P/YNPlRSqbR9PUI1jRLsN0M2q0Jo80BFpdoxDhnHT1x9OwHtTaXNQGbiTF2tNVGBYZJXUiXQ5UvjvtAMS0e5UMMnO6zBui2P9Le9Q+HoKW8L0aow2Eze9fEqpmLHG/6+DSV9R1DsRP5HsYm9hvTJ1Cbp1O0e/bt+n8GbaMmvja2xX4jKKqa6OCRDQnLKpmWvX6nnueXZ202ETeMe0kErOW1H8Z30083iSBlYu7sAzejslvsrDyjs7lEZEuv9BTmmwcPCESSDtOfXvcVhrSSd6C9ShSmEw1FAvo1IkjsNGcKegZCYZj14AlRJSPYiVHYj7H2w05oxS3dI/yR9SNnfW6aHtHE3LllYT2gCZR5xOgAgR4Y0yLtvEJKbusIpXBCtZq8BpyqLLukMfO8VkbU1oO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bc7f29-8ee6-4ecb-a301-08de7432f207
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 05:58:49.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzvPaV4LtEThAtFMQTUxr6e6csZ3VsZdRVtrEcLNa5jRpPuJ2JhWb+M7w3lGpG3RILZ6aeiXIw3qFtu5EOFyyMY6Tf5aicK5UWmR1nNWpsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA1NiBTYWx0ZWRfX80+ZL3xBFc1I
 F1am3j+DFZpjqsnTaFplIULYLybDzWCKJXYLCkk+BUuhh5HeOYHrJOgITJtdyiJ4C+J3sa3m90A
 nWchscTYCzY4ZXZVPtzu89yg6lxoQ4yJcV+RNLBzXhB6gMG3IqJ7YX5mAruKlYxPOaQFxniAyc8
 dVM1bkhMzShI6+Lt67DPwmczQ300oAYyXAl10d3+2hlug9n8xrDZcQnewCl+uxGuDiZ3WNRT49j
 3hix/aQg4opWDeF5ceD9gCkh1MRYrOXF6Z1oCyIyvlK6EAGzN8FM4ZaB+9Srp2rN7vGAJOSpI3h
 A/paaLgREsY8cT4wXbpK2TbxqAKLMq3csYktarBAq7SU9HlSz/h6sUXyRft3I2THq2kUnJPJjah
 1hz/8ia3PIM1lCNASCLbXZyNJqOhjfiVQn9qNC058pnZ6YPC6ism0ZRzbRdGWIZBg/Zm1iMnzZX
 tsPJxOiNRbMMux5S8eFq7yLepC4v0wFQ3/Ifp55Y=
X-Authority-Analysis: v=2.4 cv=S/fUAYsP c=1 sm=1 tr=0 ts=699e8f9e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=OKwnVpIQ6xOkpRWaihsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12262
X-Proofpoint-ORIG-GUID: qT1mRNEflTXcDb-6Gv0IwL1zEJmoGfpz
X-Proofpoint-GUID: qT1mRNEflTXcDb-6Gv0IwL1zEJmoGfpz
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17141-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nju.edu.cn:email,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 11EFC192340
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDEzOjM1ICswODAwLCBLZXhpbiBTdW4gd3JvdGU6DQo+IFRo
ZSBmdW5jdGlvbiByZHNfc2VuZF9yZXNldCgpIHdhcyBzdWJzdW1lZCBieSByZHNfc2VuZF9wYXRo
X3Jlc2V0KCkNCj4gYnkgY29tbWl0IGQ3NjllZjgxZDViNSAoIlJEUzogVXBkYXRlIHJkc19jb25u
X3NodXRkb3duIHRvIHdvcmsgd2l0aA0KPiByZHNfY29ubl9wYXRoIikuICBVcGRhdGUgdGhlIGNv
bW1lbnQgYWNjb3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZXhpbiBTdW4gPGtleGlu
c3VuQHNtYWlsLm5qdS5lZHUuY24+DQpMb29rcyBnb29kLCB0aGFua3MgS2V4aW4uDQoNClJldmll
d2VkLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWNoZW5kZXJAa2VybmVsLm9yZz4NCg0KPiAtLS0N
Cj4gIG5ldC9yZHMvc2VuZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9zZW5kLmMgYi9u
ZXQvcmRzL3NlbmQuYw0KPiBpbmRleCBhMTAzOWU0MjJhMzguLmQ4YjE0ZmY5ZDM2NiAxMDA2NDQN
Cj4gLS0tIGEvbmV0L3Jkcy9zZW5kLmMNCj4gKysrIGIvbmV0L3Jkcy9zZW5kLmMNCj4gQEAgLTI4
NCw3ICsyODQsNyBAQCBpbnQgcmRzX3NlbmRfeG1pdChzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3Ap
DQo+ICAJCSAqDQo+ICAJCSAqIGNwX3htaXRfcm0gaG9sZHMgYSByZWYgd2hpbGUgd2UncmUgc2Vu
ZGluZyB0aGlzIG1lc3NhZ2UgZG93bg0KPiAgCQkgKiB0aGUgY29ubmVjdGlvbi4gIFdlIGNhbiB1
c2UgdGhpcyByZWYgd2hpbGUgaG9sZGluZyB0aGUNCj4gLQkJICogc2VuZF9zZW0uLiByZHNfc2Vu
ZF9yZXNldCgpIGlzIHNlcmlhbGl6ZWQgd2l0aCBpdC4NCj4gKwkJICogc2VuZF9zZW0uLiByZHNf
c2VuZF9wYXRoX3Jlc2V0KCkgaXMgc2VyaWFsaXplZCB3aXRoIGl0Lg0KPiAgCQkgKi8NCj4gIAkJ
aWYgKCFybSkgew0KPiAgCQkJdW5zaWduZWQgaW50IGxlbjsNCg0K


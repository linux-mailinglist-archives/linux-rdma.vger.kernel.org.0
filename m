Return-Path: <linux-rdma+bounces-11506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C719CAE25F1
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 01:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B01BC54CC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06423C507;
	Fri, 20 Jun 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BzrhiJ1O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pQE2hmhW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5030E840;
	Fri, 20 Jun 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461329; cv=fail; b=Xi4Iz1YYbdJWFbZjukd7AUBqhTQuxmg15Y7ms/gfBbtdT62aNEuxKCjnU2xaaI8b5kQGBLZ3gGhCbb9v0jSn0pY7XN5/FPu4eIDTxkb0zECF5iTxlrvbEP6OTC2uKyPpq+Pu4BSd/qGKMmMs8RfdJ8DPY+MzR2LtwOggxoeo0qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461329; c=relaxed/simple;
	bh=kxnUOqxQRW4OP/8oHVn4Xb8yC3s9fhUWGP0t+2v2T9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PqZjMk4rk1Tn7+MexxVmDJUaRfsXtoGwskA/JoLAStOmEVj3oNhnBP5iLk2cma/36tt0Icu4PZ3V82BgUur0VRFHLBsAKN6APfgySHIMek/Xjj9UAAoDp6K6o7FgADapTpw2A3jAn4B7fHVR+T4S03oXi53NQ/TwOA2df+u5oLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BzrhiJ1O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pQE2hmhW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBj7A019409;
	Fri, 20 Jun 2025 23:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kxnUOqxQRW4OP/8oHVn4Xb8yC3s9fhUWGP0t+2v2T9Q=; b=
	BzrhiJ1OuwZzjAnzMek13OwGSxvBruLfH+GbPuKPFYteYB3keS4RJCBYUzAoFBHN
	MmJ85gpo4CoFiMV0tESrOpTVEiQKbfytwcINuDa6iJ6y3porSfyksn2YiFuFetCU
	8X72zwsQG/pO4T8MCKKarv/Hp09p6uQ3YkX1b2X/+xhhgZORTlmUaxDjpAtxgh9A
	pFkao8aoQDVbtYs44sGFbQqDgYi3xpZtL9nPsWyICZBE/gwQ4qFnLpyluMglKBya
	hO34nAoms/iskYMOKfyLQhwB+MqKSb3lox7cJ/KF7rMrsec62w+dG/u2AR56jxRV
	osqQWHTx8YLBl8S3yiso9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvnby6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 23:15:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KLRnKt022764;
	Fri, 20 Jun 2025 23:15:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhkpca7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 23:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6dodFOVO/BC8TPMLJR/Nbe0EKlgKtkebffEKcbNIpB1KTyTtRvTGpm80DEaQBJ7BzrZrZdpayNy3oc6hsYa6kHY8XO5887YO6qG+qOsvAWMQD4RhuRh9w/21XHlmPML7ojPerlxJn1G+IOzCvtvpdpcBNvaQHJg8Ok67V+musk2bZal0wISA4f5UkeduEdnWmyQNVzFqmwHfVeHUA6Ilscq6sVbCFVfCIf7HQaZeQfU1NYo0J6D9MDdUaHJr7ssFgYb5QP2bzg8OFZo1Ek/ymeITzYdptwVjjzn1axaq/5z1V1XEVnwzOQxwlpfDLPDmMrsiyagFptYLsSBGUdbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxnUOqxQRW4OP/8oHVn4Xb8yC3s9fhUWGP0t+2v2T9Q=;
 b=FOSDlaCPsCIEIPnNYbnKWRg5706TWBRndJk15mcWjurFJzPWQdUF4Nql+wrQlmA4aa9rw+YNhwOHuGAJoZ+lGoEn8W2JPAnYl8id1W4CDkm02NQLBfqyZ+yJAYxYz0ntRfICuTbfCDlycXgzjh3KyJQZq0tQ1r+nqYx+LEuKspXQYtXAZsWDjRonzeWskucHJpoTzVyrhOhJaMX4e2gsbIKLTZlZUHccxnhNlVDaHZ4bjNR2gDtwzbEcZblup/IH/rXhA0iOMkKYK1tAOItAp1i3b+66F8OG2XrjNE9iJy7M9HRYJKdLtHd8TeyWaKnLwz4DcXJeErD9pMVOMPDJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxnUOqxQRW4OP/8oHVn4Xb8yC3s9fhUWGP0t+2v2T9Q=;
 b=pQE2hmhWNg+CNnILS56WM9p6vL5FIo5K4dL/np/roS60JOO3laNnOHxDWZVgEjddxwDI+8ji5+XOpF1aReChbzUn0xkgCJCRDTbaFLt3y8+kyy9zSD2WRVowIPT2oVjYvJsYrvlEe9Bt8Wx2h69T7NMu99s3K0Vp99I4ZrFcwt0=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 20 Jun
 2025 23:15:11 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%5]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 23:15:11 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] rds: Correct endian annotation of port and
 addr assignments
Thread-Topic: [PATCH net-next 1/2] rds: Correct endian annotation of port and
 addr assignments
Thread-Index: AQHb4SJKwEKBiKJ+x06BRKSOAGVQZ7QMsBEA
Date: Fri, 20 Jun 2025 23:15:11 +0000
Message-ID: <9a18d6ef5bf2c47cae42ec2ef96f3cc96a5507b9.camel@oracle.com>
References: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
	 <20250619-rds-minor-v1-1-86d2ee3a98b9@kernel.org>
In-Reply-To: <20250619-rds-minor-v1-1-86d2ee3a98b9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH7PR10MB7035:EE_
x-ms-office365-filtering-correlation-id: 20d78e01-d366-47bc-0096-08ddb0504e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmx3T3huK1UxN1dsRUwvNmlGODh4SEp0QTV5VmFiNFFQTU9pdVdjdGxsNGFp?=
 =?utf-8?B?TTFUQmI0UGRDbHhjZ1pBbGlLa0RBRHZTMzJ4emdxT2NOS0JuWmx4ZUNqby9D?=
 =?utf-8?B?ZThMbE1mT21rNHdQZGJaRjdmeVJ1bmZYZXdzZFE5bS9DYVltOWJiYWdMSjdi?=
 =?utf-8?B?bVpJUjQxVWFKcWJPSkJYMWtNT0dxNno1aHF3NWxydjZUR0liR2VEMElpNFhI?=
 =?utf-8?B?UEVja3NtL0lSV29RSlgvenJ0ZEpUNkhJTWJnaFZ0OFBZMGorTjVnU0R0VTUr?=
 =?utf-8?B?NHFqVHpoZ1g5cklDbnJ6UnM3QXVKVE5ZVitnc3BQanBHN3d6ZFcra1h1UWd4?=
 =?utf-8?B?eUhldnRqdlhBb1FOU29MNVN2TS9LV28ySlVaWmRFSDJyL3VzdDFGTDlFR2hy?=
 =?utf-8?B?cG9rNU1TYS9uK2R1d1RnQXVJSEtzZDR3VWZOUnJJUEtXREw2WVFhdEFyNkRW?=
 =?utf-8?B?SkROUmVXeDkzTllIendjODNmcWJWVnZXWWtHMDMxMlFnYW5BSGdiaDV1ZlEv?=
 =?utf-8?B?RWd4dGhjdkJFRS9JN0FETEl6bXVPK0pobTdwaEhXRFpwaGptbXBsNGppcnkr?=
 =?utf-8?B?bWcyOFQ0V0hwVlNZRndEL1pMM2ZsbDZKTmprMHRDWFFGT2VaMkRsbTZOekJn?=
 =?utf-8?B?QnFiSmUwTEtLYUw1RC83QWs3WEVQb0RndEZoNHdITEpFaDNibS9TZ2Q2Q2Ew?=
 =?utf-8?B?MW1iQzhNdk84UGpyc1hJSGcyRnVVRkpXRzZqK2gyWFVtWXJ2dlZEYThoZit1?=
 =?utf-8?B?bFF1THNzY0F6RktLUjlkdk9UbVBZbk90L0l3UnM2RitBN3dOelladzlaSFM1?=
 =?utf-8?B?TWR6cG50WllZZjYzWmpkTE85cG1qb3FHVElhL3RoZHpJUytHWnhodzdzZEtq?=
 =?utf-8?B?ekxKUnNXRGxwWnFtWklWTkk5Z1RvN1ZtL09pSmNpMlFzai94T2gzUVNuME1H?=
 =?utf-8?B?OXA5b3plTTd4dENlOHpWbkJWN2hRUGhkSHNBRHpoWUR1b0Z0VWdsamxHV3Zp?=
 =?utf-8?B?YnFycUVMZ2hVUmVLSHZ3dkJsSyt0Nk1wdCsvZnNqL0I1MFlXZUFLM2k5Zlpy?=
 =?utf-8?B?MlZCaVkxK0QySDlLNzZna2xWeUhOMHBxNVVFYnlRRk1naDRRZi9CbVNIU0VQ?=
 =?utf-8?B?TlJsYmhpNzlGcEFxcGMxWlVjN2I3SmdjT2plOVJWd3JvWjlNOWpLcWFvbU9v?=
 =?utf-8?B?RjB1NlFoVlVaVTBSaTRIa0FrZWZic3hEaC9kWTh3TURDOUo0VjdoYUNLMHN6?=
 =?utf-8?B?dUN1bkd6RWo5TWRabmxCbitnY3BpUXlUbTQ2ZmJEM0ZzMUxidDlvUnVBZ0R0?=
 =?utf-8?B?bTZlamFTZWNJVldxTGk2NEdaRU5IRDJacVhMSmswU29TMVR5eVJXZ0FNMjk1?=
 =?utf-8?B?UGhsQ3hjSGlubHgzdHlnMitaQXNwTUNaYTRSc3E0WWZ1RFZtVUJNaHZZbEZS?=
 =?utf-8?B?eWVFdGRVUmRGS1ZtVi9JMmgwWHJUUUVuL05HSUJ4VitJMm5vajQzVkdvcFpx?=
 =?utf-8?B?c1pOeERKckc2R3VYcUl3MDFPdVRhTmNxNDI1RVhZNEp3VWdDbkRvN0lEU2JW?=
 =?utf-8?B?THR0blNmRXZNWGkzd3hrNUVhbXZMbXkxUWJLQTJ0K3NscUNGQkVLMmhIUFB1?=
 =?utf-8?B?WUNHbThFbmpHMFkrZHVNWHpZODFXWDd5WFNkRWhIUXBFaEF6NmluK1RaRkhp?=
 =?utf-8?B?eC9OallNTmcwOFBybjJRaExKNnREcTFpMGVZbFUxa080djdBN08yenA1RXB1?=
 =?utf-8?B?d0RTNVZTTnFxRmVpcUthOWtBaTlZaG9KM2c3Z1hpcmZqT29mZEdQVTIwMWxz?=
 =?utf-8?B?dWc5OEtPZ3dSRFZPT256TExCOFg5SlU3bG1WdVovaDRPVDlxaEo0am1PcVYv?=
 =?utf-8?B?K2hqNnp2b2FnWVpON2VnN2JtRUREV1BUZXd6U2xXUk9wVlpyWjZHTDFNYW93?=
 =?utf-8?B?em94a0tNdG1EYVJXMTZnbXVaR2wzdlBuVWczeDBtaDRWOEdUN3lONDMxa0dY?=
 =?utf-8?Q?x4mHRRd2WzPUccdbPDMrmLCRDaA8tg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3FJb2hwMkxuV3lzMjRIREc5RTh4RkhyMjRxMXc0QVA0ajBybzBYWkhDY1VW?=
 =?utf-8?B?R0xNdlUvcjFtc2c3RXBnTktQdzh2M2NLUFNyM2k1bEZnZWNCbGFObW5EQWo0?=
 =?utf-8?B?eWF0dHk3cWhCZXc2QnFKVXdTZW5EbTRoYzlnalJhenMzT3RtbWs5dW9TUTh1?=
 =?utf-8?B?MDhjTytwZzhBS2RxRUhlZlBFbVBBZVdUWDhPWjl2eG5TQTdHQkhUT0lpQ2Rt?=
 =?utf-8?B?dGVEOHZZUWtaRWRBdGFTS3NnT2hoZW9nS2FvUmRRYko4ZkZ0MGZtOWhrRnFY?=
 =?utf-8?B?eTBsV054THlVUm84ZW93RDRJRUM1cFFNTkFOUC8xdWlzcXhnQ2Z0WVhBUVQ0?=
 =?utf-8?B?b0g1cEhJcmJ4YjE0MUVxUUJVUmZwUXJ4L1RXU2dySWlvY2h5NENVT3ZaZkQ4?=
 =?utf-8?B?aFBNemVQMWZDVjNVSkFycEFYalBraXA1dEZNTW81UjNUKzA3Nlhlb0hMaTJ0?=
 =?utf-8?B?blNWeFdjczVuU3BWUHNNVVVMR3ZtSWRpTVoyWUhRYyt6aXpKdjRmSm1oSzF4?=
 =?utf-8?B?RENqQmRCbktpdCs4T2Z6VGpsQzFnblNoSUJ2dUx4ekFnQ3lvRzY5ZW1IZEto?=
 =?utf-8?B?MVJVYXVvTEFqbnhmZTIzeEtWWVBNQ2FwV2NlK1JvRkt1dEN3a3A1V0lKSSt2?=
 =?utf-8?B?MFE2Z3k0RGR0MmF1SjlRUWhWQWJoczJFaGQxNTdiQ3BvQnpwY0tDRitzalVm?=
 =?utf-8?B?bE4yVzJGWlQ4OUQ1NVArRDE0TWxNSTcyRzVXOTcxa2cyNUZCQ1IwYmlQY0pz?=
 =?utf-8?B?ZHlXeS9qV25lZzdxN1ZaSVg2d3JDaitWeWxRTXlJQXB0YXNPK0F4UmlmRHd1?=
 =?utf-8?B?UWpIR3A0S29PZDVFL3RNcTVVMzBDSmFGZzhWTTgvTk5sUG10TnBSZ2VzOWZG?=
 =?utf-8?B?RG94Z09HZVJZazBZdkdIUzhsZUxCSVV1dkppK3Z6TEh5cnVTbUpKSlVGV1V2?=
 =?utf-8?B?VXdhdG9jTUNBQ29NUGJxUjE0eS9NTy9qMVgrQXRRM0tlQ3d4NG5IQUwwY1Jx?=
 =?utf-8?B?MXliSEgyRE9WRW5MZ080MFVyY2dJQUZwVXh5NEtKOFdWaXFVbS9DOGFqeGlH?=
 =?utf-8?B?L20wZTRkRFl6em94Sk13Q0ZBTCs1NzBDck1iRmUrL3YxVnJLeTBHVDZWK01D?=
 =?utf-8?B?NVJRY2pQNHRDT1gxMEZHenNtU3VVcXJsWndNM0JGSUVqZmRsaWRDbVJTUkRG?=
 =?utf-8?B?WmlkM2RiRzJlYmRHOXB3MnFIWDJ5Y05BTnY1NDZ3aFUxMmJTZXlKNVZ6bHda?=
 =?utf-8?B?YmFDRFhweVgveUljNE5vRzlLbHJOOWFmV01wOVRISzFZQ1dMRWw0TXRKclBz?=
 =?utf-8?B?M2R4N0NxbHVXbTR1QmF4YTFkNDdDTUhScmJUQmU0QU5kdnRhSWt2MkUzSEdE?=
 =?utf-8?B?dG9IMGFXc0c4eEZJVlpqTGpheEg5N2lWNHlia1BLUitYQktMNDQ5L250aVV2?=
 =?utf-8?B?cWFHT3c2SkNybkZQTU56dC9zUFJsTnpKOThLWm0zd1dDSFhkQmxsUGtnamNi?=
 =?utf-8?B?QmJQVno0WHBvc0hlcU5tcEFnYkdrU3NPUll6c3JNWFoxTlBrNUI4eHBnVzRY?=
 =?utf-8?B?RStIRlVSZmVKcjM4S1pvd3cvRitPMlFJOWF0U0dJaFFld2F3V09ZWkNSZjc0?=
 =?utf-8?B?ZEo2c0JWUEJmRE83cGFMd2toWEQzQlR3VlBqK1c1YXkvNStQR2pvRlprZDM4?=
 =?utf-8?B?OEo0R3lRZ3RMQVhIQlFDdHpCWFViRUh6MHlEblhLVjBFTlRkU0U4VjdUNXgw?=
 =?utf-8?B?S2tTeUk5SDlsOE91c0VFUUtHQW9reWYyM1RpS3RlOTlPOVNXTVRlbTFNMHhq?=
 =?utf-8?B?aThoODE5Z09OT2pMTzdzSTRtZWt6Szhia2tWeDI3bWRsdzM5TUJXTXErU0Jq?=
 =?utf-8?B?em9rR09leVFZLy81VzRodFU1MkpRS21FK1NQaWVPaWNKdmpieXpmMnlMTEl5?=
 =?utf-8?B?RElneHl2N3pPelpvTEZTaHNyK3ZlK1Q2aEhqSUk4NGJIWmhGY2RCWnozQzFS?=
 =?utf-8?B?MTlERndwdFg5SURzeHh2WXRVeFY2Vm9yM3hiZCt3OHdDc09MQ3hCa0owTkJN?=
 =?utf-8?B?OXVucUY0V09uZjdrQkRJc2kwMnF4d2lnbzZpQjhmelZIaERVRWthSFI3ZGg1?=
 =?utf-8?B?RWtJbjlReDdHSENGY3pIWXNaWS9DRGtMeVRtUGpiajNjc1NPQXRDcDFBMWhO?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B1D5F4D3AC0D047AEBD5BEA0722AF3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EOoN6d2oTl1Cz8ExVCU+8GCyst9agIMprik4jRPhRImg6Q+LtGFWY6RcRUs6eVXGCuYQGXz9AmqqeH3L9aU5AqJLQftyQXj1t9yy8EyE4YULha+YVaPDdT6OXh0OCgt2LbaQW6ORrHbdsTNyshGcyGtqrcF5JsxtyAxRojzKMbZgLPR43pH4tamL/GGiUx6tQhmi/q1OHhHdCuT83JdD/IXH4FuBmhrye1OLcz6/H6uEB5P0NX+hCCOLaf/B8MDWQcJ+2yuTRm8ldf6eUMUe2GZo/V86TGxI22N9m5hSzVVHYfqtTMUEf5vZf0sEU2aY19+mNJ3IHlr3v55ZeSR4ZdlHXwmi7jw8dngmdw4nUlPdC1+1GA2XBEm+qmROF0B89K87UDEQaaFTo4KCBoaTVKqEbhF5ppfVHYr78Py692hdDTv0wQp27dQj0NxpbKT0eV8oEXQbVWpwjZ3EdRCpNdF8BsWNtW5vITbR0id8tpPJXw8LN1tu388PTcAC29aqNF7OxXKmDmC5k32a4rlZwFhVzSAk1OWZBNKlJ91Ri88L3Xwmq+PNDQRBhLfb5cVSAZvca/6cCDsTPD4/6OeIiGv+4AM9feeidEdhkp1UQUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d78e01-d366-47bc-0096-08ddb0504e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 23:15:11.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdeUp2+R5z5qNbByDiUb/l84fSTXncTNmXHTI1dfyo0f9uAmNMOXf2fNi4p9gaqpmtQxjmshX/JiPuQCVAikzwgIWes2KzkNDaJ/sHoeqlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200159
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6855eb88 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=krm2j6icDtYJAUiGpfsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: X8sNzhojmrW910i9ORruTk5b0RhRorPA
X-Proofpoint-GUID: X8sNzhojmrW910i9ORruTk5b0RhRorPA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE2MCBTYWx0ZWRfXz9QLxkq6Z0Qd m0KeaqapaDZZOEVJwY2Ck3gNYF9xdCGwZN5RRlFrMYEZzsEZ7ULnclnW04LUiLxGze9dv7zHe0Z QqT4wSCbgm+VFVQS95Vv6owQH9X/sepZydf1kf+RQVkkd9B1L0t41Z8htWPEd+KaJ3fPvGGkr9P
 hqsYsQ++GFmEzheCwT7/ggrY6t5IM02cPH2+PQIWv8m5JZAOTyTwLbgVGEW+5puez8kaVVfKtTm 2xqVlScMX+6AshmWbnkN3HI5Q8PekT9KZrbbm/C9pSICBDSRWmt5eUGEojQJKeJQ2Gs7zfm2Ps/ gu8SQDoQkA7ot47LglEKrv1vLO2Bxd8oOIVKCybvVxbLaoScCrH5xulHBRYR0zf5boXXxKW4iN6
 xbiIrdo9Yi25YGIArGRTg+p7b93l3WPxrjyXtuHVstg6WpswZ1GASyMwrY33H3K9/WEtfHYT

T24gVGh1LCAyMDI1LTA2LTE5IGF0IDE0OjU4ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IENvcnJlY3QgdGhlIGVuZGlhbm5lc3MgYW5ub3RhdGlvbiBvZiBwb3J0IGFzc2lnbm1lbnRzOg0K
PiANCj4gICBBIGhvc3QgYnl0ZSBvcmRlciB2YWx1ZSAoUkRTX1RDUF9QT1JUKSBpcyBjb3JyZWN0
bHkgY29udmVydGVkIHRvDQo+ICAgbmV0d29yayBieXRlIG9yZGVyIChiaWcgZW5kaWFuKSB1c2lu
ZyBodG9ucy4gQnV0IGl0IGlzIHRoZW4gY2FzdCBiYWNrIHRvDQo+ICAgaG9zdCBieXRlIG9yZGVy
IGJlZm9yZSBhc3NpZ25pbmcgdG8gYSB2YXJpYWJsZSB0aGF0IGV4cGVjdHMgYSBiaWcgZW5kaWFu
DQo+ICAgdmFsdWUuICBBZGRyZXNzIHRoaXMgYnkgZHJvcHBpbmcgdGhlIGNhc3QuDQo+IA0KPiAg
IFRoaXMgaXMgbm90IGEgYnVnIGJlY2F1c2UsIHdoaWxlIHRoZSBlbmRpYW4gYW5ub3RhdGlvbiBp
cyBjaGFuZ2VkIGJ5DQo+ICAgdGhpcyBwYXRjaCwgdGhlIGFzc2lnbmVkIHZhbHVlIGlzIHVuY2hh
bmdlZC4NCj4gDQo+IEFsc28gY29ycmVjdCB0aGUgZW5kaWFubmVzcyBvZiBhZGRyZXNzIGFzc2ln
bm1lbnQuDQo+IA0KPiAgIEEgaG9zdCBieXRlIG9yZGVyIHZhbHVlIChJTkFERFJfQU5ZKSBpcyBp
bmNvcnJlY3RseSBhc3NpZ25lZCBhcy1pcyB0bw0KPiAgIGEgdmFyaWFibGUgdGhhdCBleHBlY3Rz
IGEgYmlnIGVuZGlhbiB2YWx1ZS4gQWRkcmVzcyB0aGlzIGJ5IGNvbnZlcnRpbmcNCj4gICB0aGUg
dmFsdWUgdG8gbmV0d29yayBieXRlIG9yZGVyIChiaWcgZW5kaWFuKS4NCj4gDQo+ICAgVGhpcyBp
cyBub3QgYSBidWcgYmVjYXVzZSBJTkFERFJfQU5ZIGlzIDAsIHdoaWNoIGlzIGlzb21vcnBoaWMN
Cj4gICB3aXRoIHJlZ2FyZHMgdG8gZW5kaWFuIGNvbnZlcnNpb25zLiBJT1csIHdoaWxlIHRoZSBl
bmRpYW4gYW5ub3RhdGlvbg0KPiAgIGlzIGNoYW5nZWQgYnkgdGhpcyBwYXRjaCwgdGhlIGFzc2ln
bmVkIHZhbHVlIGlzIHVuY2hhbmdlZC4NCj4gDQo+IEluY29ycmVjdCBlbmRpYW4gYW5ub3RhdGlv
bnMgYXBwZWFyIHRvIGRhdGUgYmFjayB0byBJUHY0LW9ubHkgY29kZSBhZGRlZA0KPiBieSBjb21t
aXQgNzAwNDEwODhlM2I5ICgiUkRTOiBBZGQgVENQIHRyYW5zcG9ydCB0byBSRFMiKS4NCj4gDQo+
IEZsYWdnZWQgYnkgU3BhcnNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KDQpUaGVzZSBjaGFuZ2VzIGxvb2sgZmluZSB0byBtZS4gIFRoYW5r
cyBmb3IgdGhlIGNhdGNoIQ0KUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29u
LmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQo+IC0tLQ0KPiAgbmV0L3Jkcy90Y3BfbGlzdGVuLmMg
fCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3RjcF9saXN0ZW4uYyBiL25ldC9yZHMv
dGNwX2xpc3Rlbi5jDQo+IGluZGV4IGQ4OWJkOGQwYzM1NC4uYjVjODAxYzYyOWE0IDEwMDY0NA0K
PiAtLS0gYS9uZXQvcmRzL3RjcF9saXN0ZW4uYw0KPiArKysgYi9uZXQvcmRzL3RjcF9saXN0ZW4u
Yw0KPiBAQCAtMjk4LDE1ICsyOTgsMTUgQEAgc3RydWN0IHNvY2tldCAqcmRzX3RjcF9saXN0ZW5f
aW5pdChzdHJ1Y3QgbmV0ICpuZXQsIGJvb2wgaXN2NikNCj4gIAkJc2luNiA9IChzdHJ1Y3Qgc29j
a2FkZHJfaW42ICopJnNzOw0KPiAgCQlzaW42LT5zaW42X2ZhbWlseSA9IFBGX0lORVQ2Ow0KPiAg
CQlzaW42LT5zaW42X2FkZHIgPSBpbjZhZGRyX2FueTsNCj4gLQkJc2luNi0+c2luNl9wb3J0ID0g
KF9fZm9yY2UgdTE2KWh0b25zKFJEU19UQ1BfUE9SVCk7DQo+ICsJCXNpbjYtPnNpbjZfcG9ydCA9
IGh0b25zKFJEU19UQ1BfUE9SVCk7DQo+ICAJCXNpbjYtPnNpbjZfc2NvcGVfaWQgPSAwOw0KPiAg
CQlzaW42LT5zaW42X2Zsb3dpbmZvID0gMDsNCj4gIAkJYWRkcl9sZW4gPSBzaXplb2YoKnNpbjYp
Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCXNpbiA9IChzdHJ1Y3Qgc29ja2FkZHJfaW4gKikmc3M7DQo+
ICAJCXNpbi0+c2luX2ZhbWlseSA9IFBGX0lORVQ7DQo+IC0JCXNpbi0+c2luX2FkZHIuc19hZGRy
ID0gSU5BRERSX0FOWTsNCj4gLQkJc2luLT5zaW5fcG9ydCA9IChfX2ZvcmNlIHUxNilodG9ucyhS
RFNfVENQX1BPUlQpOw0KPiArCQlzaW4tPnNpbl9hZGRyLnNfYWRkciA9IGh0b25sKElOQUREUl9B
TlkpOw0KPiArCQlzaW4tPnNpbl9wb3J0ID0gaHRvbnMoUkRTX1RDUF9QT1JUKTsNCj4gIAkJYWRk
cl9sZW4gPSBzaXplb2YoKnNpbik7DQo+ICAJfQ0KPiAgDQo+IA0KDQo=


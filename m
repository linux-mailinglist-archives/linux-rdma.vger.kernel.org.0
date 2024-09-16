Return-Path: <linux-rdma+bounces-4970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B297A305
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84851F217AC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4121154C0D;
	Mon, 16 Sep 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="kG7C6CuO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020141.outbound.protection.outlook.com [52.101.193.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71B14B094;
	Mon, 16 Sep 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493951; cv=fail; b=pOAEwxcBK8/MAXYKFyeKmMY1MRKNZFMi/w5R84nmzIkjyNMC/e/9YyrOecM/ii53xEJ7rTO1sfhTQ9czxf74sh4o7jk+S/pr6GYagBr0/Qiu1P66GP9nHfBVHeDl9ruFT4iiv1bN+lUJjD0RhkU0bOz2vJBb//mhdpPfysDEhwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493951; c=relaxed/simple;
	bh=GnaN+fmMbPZt1X7Gpq7xi30lzGQBJyjYPmOeqcXIgkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lja6rdSDXl17AHjWtYO5oHHyz3+ImLZKqToILrRh6DlMo4n6CLrRm+FvhRnDsyclkRXxXKamH2uvqJgIGNSR+ZCn6ohEmeeKiAFuyo368lxQKvgIuE5Ys5G/8d9WYv7hbSMqNw+Tkj/qQwO4kfLHI9gt4B6uT0EQZ0+0Z1SmYbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=kG7C6CuO; arc=fail smtp.client-ip=52.101.193.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfHKCtb9I11BbcQ/Ogvs8R5Iy7IAOEzVe4Dy+ZS1Bbki3t9DV/KJy4Hb8JwALTWu4UlbGwGVKKa3CP8w1DGc6FcCIvXhe7b8Z43OauVMkv7GQLKluTWPT4iOVyBXymtcg6rpE8ZrMDlbl9Kw1DVt2HfAhwJQ0X1bokO+RYdGFyrtGKWw17ksWOSugDkkiFbQ6PmlI076TkL5dCaluCdqzM1u7R9saBjmNN5EIpC7hqAqjcRXLG/Ab57Mpr/AB+yJaOOtZmj4k2mRRKB0GexxfLdprtFAfM4tWEqFwODa6uZdAmnQE5lhMz+Vdoz8IucZ4LjyYHGVXS80OWa5sSjiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNGwYOpq+UPZzICOYqXKRTFj0hHmE+Kbjj6Iz6xlZN0=;
 b=GjAVQ5l4kwAn1zgIwGFTOgxoiclWG+WUH+GWIXQ5ZXsu5CvtyyT30aoM8tIMWozD4B1znfvjjtjFOCuUlLRoQHDo4+lMF97hM31UG0V5O/lCoVHGnsxOV4Ugaq22R2/ohFOpWSC+V3FaInItJhj0rQ85WsN/zdGVPkOmAJf1iWhhHjtEDLttV4aaRE7l9N4LjrCtKN0CRMbELFWG1ln2xuPWtj9tyZ/U5Gj6u68rglyJK5WeUiAk/2/SZp/Y0M6XOTL2HOxlWNqAtIn+7r3Ir+n+vJIGuQ0XSBLvH56UCmrTqW4afxu1TkQKMAN+UGAIa2nmqs6SyDIzVcx8okhWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNGwYOpq+UPZzICOYqXKRTFj0hHmE+Kbjj6Iz6xlZN0=;
 b=kG7C6CuOfog4C4icFqOfBv6XYx2setRdcAX/Cy2Ocy3n4J9ib0poRMs3PBFJg23/LVjkpFiwcktY3zqfr9f68a8Y4A7K2uEUt+jmiSJqW+d3+iHtm39/evWH0z1HND9elgdyrNl5+IqhevuvYC1XNdeI+p18uA180Xubto67qWQpiIh3GbpPtIJrPY0muYvsc7ygjCYOO+ejxNNGbaZluZ8UOmgOXmw8lZF+V0+F4eDfAPoUcajeNwr/VBKeXS8cKaHj/CtDLqkaI4P7Bqoz/3Hsis+3zEcIajRNoWC/MmLQJfOMah5e8hWxriSh/y9fNyL1NYV8vVOwzIQ9wBCXMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 IA0PR01MB8256.prod.exchangelabs.com (2603:10b6:208:48f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Mon, 16 Sep 2024 13:39:05 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 13:39:04 +0000
Message-ID: <0dda0411-22a3-4805-807b-0471f10c6468@cornelisnetworks.com>
Date: Mon, 16 Sep 2024 08:38:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
 <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
 <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
 <20240915165800.GF869260@ziepe.ca>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <20240915165800.GF869260@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|IA0PR01MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd77256-b088-4f1f-bf2a-08dcd654ee36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V08yL0VaTHRiZXRQNmlZdkZCWmthUS9xcjVrVmFzNW9pbDc0Z21qejVWanhU?=
 =?utf-8?B?SmwyN0Rjd1pheG9hVjhRUUJxQmxWaVZFeDFSMEJJbFp6SXVzV0t1U1NXcURF?=
 =?utf-8?B?TStFNndJSVN6L25kMFFMQkJ4eFhXOTk1VkViLzdNeXVONGpuTnNhODJEV2FL?=
 =?utf-8?B?ejNPVnJvM1pOamVBV1RtUlJ0eWhYazRTUVFmK1dCOGJNK0ZkMWFKMXdtSWkz?=
 =?utf-8?B?di9lek1ZK0d0NkxpUVYzM0FNcGRoZVJDTFZoTzhzZVdHY3Rubm5McjZTMFFH?=
 =?utf-8?B?aXk2MnhXalFrY1VnaUxCR2tnNUEzREEwRTNGaTAxdmpLUlU2T2hsUit0dUZP?=
 =?utf-8?B?WGFvUWNZNjNUc2crTVM5UHJnMk9RTUpxeis5Q0d6MVZvN2FwM3dUNEhFNzZR?=
 =?utf-8?B?MnpIRUZnQVVEYVhCNDRtN0dIR3IvZHZEd05TUnJpV0pzalVoTSs0MnRJeEpx?=
 =?utf-8?B?SGk1d2VYK0t1VFVBYWJNZHZ2Q0N6T2dTaXdFb29aZmFTNmh5ZWN1cmpVUTVr?=
 =?utf-8?B?bWtOc3dJeVZQdEptcUk2UzR6UkZGdFNBM0tOb0drQlMvRFpObjN2V1pZTUN1?=
 =?utf-8?B?K3M0akY5a1NVOTRMbE9tMDhkSE9udGFmRkpQUitBOTRqUkgwU2YwaUZad0Z3?=
 =?utf-8?B?TlNCOTRYbUluekFJa29YNmM5RUFpWXFYbzNYZG5xV01ldkhXazRvb285REpN?=
 =?utf-8?B?UTJXb3B5WkRBeDNwYlB1MmF3b2E0VS9WSmpYNDM3UkRyVEF4bUJ5a284aEpk?=
 =?utf-8?B?SXFkK251S3ZuUUEzRjRSUGFoZ1VNaS9wWFNQN2QxYUt2VDlWZGZiaDVIUzBS?=
 =?utf-8?B?ekFZYWpVV1FEQjh4MHZsazRScGZLREQ1RXZjcnc1cVlTb2FobDFwT0RydHZM?=
 =?utf-8?B?NjZKU2dTdHN5SlBvc0treXpDTjVSM1dSSFdjbnh5STJOZ1owSUZFS3h3VmZL?=
 =?utf-8?B?K2FFN2MrelVLcG5LT0lFQ0RDUUVnVHpKU2NkM0R6RDFaTWtkZTVuQVI5Z25L?=
 =?utf-8?B?UmdMQXl0bTJWRkJqVndpWm0wYzJ4ZXRtbWVWZTdoT3FlZG1ST2dvVlZDWEhP?=
 =?utf-8?B?dVRQOTU4MGhwZVdVbkhtY0hlZG1oSTdYYzhkV0t2aHZtdUsrQTgybFZGM1dO?=
 =?utf-8?B?ZTBZSysyUGVlNjAxbEJaMlB1dHRkNmw1ZFlneGszWWVJbHN6TDRzQm4rK2NB?=
 =?utf-8?B?eks2WTg2ZkpYODZaWkpQRVg5NXk4emJUU1QvbklGMzhoY1hkYlpMd1NUdkpa?=
 =?utf-8?B?WnE1ZDEwTkp0cFYwVDEvUE9QMVRwQlhEMHhSVENlaEFmWTNxRDNBYjhMb2Vk?=
 =?utf-8?B?MVlmanZTQklreHkvd0dwSTRGUzVORG9ORG5TZlVuc1VheDRxR1lZak9xbHg4?=
 =?utf-8?B?M3MrYWJTbmRBSk1jN05MQVh1ZVY3eXhLTVZCY0QxSjg2cS9xNFJNZ1psb0FF?=
 =?utf-8?B?K1ZsUUtVUzR5Z0xuRi9tWnM2dlRxbW14NDFZMzBTbE1uR0FGdllGRWtKeVFC?=
 =?utf-8?B?MlJaTmt4L2s1elFOSjJBbnkxQS9rYUkvcnBJRDBjd2l5d1dxVnhjdmc3R2Jr?=
 =?utf-8?B?N2N3Rjk3dVdwZHZWdFl3TmtmNjJ2TmtzN3FjYnFGd21XNzE1dk0vSDRYeGpo?=
 =?utf-8?B?TmNKWFQrSHpPR1h0ZHFaa0E2TUFyMHZHQkdnamhQaHIzWnRxOVZOMm52aDUx?=
 =?utf-8?B?a2NYdDdNMUZmRFlXLzlJS0RpdTYvVFdaSUNSdjdhdHpJTUZWS0k5K0xyWDFO?=
 =?utf-8?B?WjNibUllTjB6R1pDb01GbUFHSWVxV0RjZk1KaVNQR1NjRnFCdEhGUEdHNmxw?=
 =?utf-8?B?cUVHSDlSNXJhaHJVY0o3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUs2dEg3R2FLbmZxdnJVSzcrMlhYMFo5ZVlxSllHdGZuQkJOOGtxeUlOaEdx?=
 =?utf-8?B?WW1NUUlobEFZQU5NN29WQzE1VU9NVHhrc3BsdkZCWmxJVk5qTEVZZWJVQVRZ?=
 =?utf-8?B?clNnUlE5V2ZBcUR4RTgzR3lHbUczQmhTUUdmVzFUckVZdC9TeGkvN095M2Fq?=
 =?utf-8?B?RkR6SytFWHA0TWtuc2ZUbXVLaUVXT3ZERWsrRHJINHoxbWZQNjdYTll4Z1Jp?=
 =?utf-8?B?K0JESCtqNVBSTzFzQkRuZzkrdERGTkdmUVBib29sd2duRmNnc1dXYmxsQkJK?=
 =?utf-8?B?Z1pBbW5zWDZ3UDIzU1VrM05XN0dhS1cyNXFqY3NIRk0rbms3TzFuREJMeHY2?=
 =?utf-8?B?ak9IOWN3dmhHYmJBMkhjUTdUWHdKQllKcHdYVCt6Yjhyb2MrNklPalVHaENt?=
 =?utf-8?B?dkhrc21VVFRTbEVkMlFyLzExMHZpTG9FOFRjRERrN2J2a1hNeHNIK0tCeEZi?=
 =?utf-8?B?ZTBLQUcwR0NtMnliZUFMR2JIYWwzaC8xeUI2bGlEN0Q4TUNSbHd4eFhHQTF4?=
 =?utf-8?B?UUp6Y3F1S0g5cFdsWUtzZDlPdU1mM0VPSzlCdi85ZmdGeTFBTi9qeXptUEJE?=
 =?utf-8?B?clV3SE5ySkxpU1A4UmMvcGQ0SzBNazNxbTkvMm1GejhZV3FGTm9tWC82R3h2?=
 =?utf-8?B?NHphZ1RZWlhFdGRya2x2aTdldExFeUFEaEpiTUxIdGNRUmxobHJIM2d4WEpZ?=
 =?utf-8?B?NHRsT3pzL0k4cy9qQnUySEVmK1RLRTR0UFBuN2oxaTNRaEk5MWZSRXEzL2FG?=
 =?utf-8?B?UFpDWjJOem80RUN1bXFKdnZQM0JWSUl4elV1Q1k3REFyN2hiT3drY0VZZEpQ?=
 =?utf-8?B?cmlQdm5vVTV3SUpWdTlhNUtlb2NyRmE2UnZ2ZjBIeVpublJZTnJtLzFoTWtM?=
 =?utf-8?B?bGt2T1lTaGNZSE91eVRFdUJRTC95YWNlanB1djdRbmZCWVc4T0oyNFFrVnho?=
 =?utf-8?B?cnhDN2hmNEcvckdzWnJYVHk3cTRPWnZqMlFqNmxJRHc0V2pyZlVnTjU4eHJ2?=
 =?utf-8?B?Y25YdGtjNmd4ckY0R2E4Rlg2eVlXaVhWV2RBZ3BwTm5NRFVBd2RKRW1McURW?=
 =?utf-8?B?VlpXWnlKOXlaNmdsK01vRllBSTl2ZE9zd1VWZW1yZFFKMUVYSjJHd2dHQ3Ro?=
 =?utf-8?B?VDBYUkhuMm9OYWlnOXBGVmptMURQcDM3bEEwRnY1MkYzSnRaQkE4Uk1GMHQ5?=
 =?utf-8?B?SkUwMVQ2REliN0I3NWVuejE5azNXR3lENjZXaWlaLzhOL3hTRkdLNDNLL1Iv?=
 =?utf-8?B?QVF3cTd3dVpYeTJ4ajBjSHBtVkpqeGYzSGl0Ym13ZmxGQ0d1N05qdHhISENi?=
 =?utf-8?B?ZmtIbmJoUjlGcU1va0VhM0NOZHJHeW5FZkt1YWpINmwyS09KNndiTmFXSnBQ?=
 =?utf-8?B?Rk4vR3RuOXFGU3lNTXZoZDJiQ05mbDVpbjNDYXhEUXl6UkxycWk1L2dDUzdD?=
 =?utf-8?B?STFYdldtczNmK0NqdmU3R0NrNlhjdXFVcGNyVUM0c1JoOTUwVmZWV2h2Q0Q3?=
 =?utf-8?B?ZEJseFArajNER1UrTzFLclBDRzY2ZU1zTTdNTytjTXc4bHdQMTdqZmhJREN0?=
 =?utf-8?B?SkN1Uk9wWEpxM1dTMzUxYTFVdHhVYXNBZjJ4cjZJL3VoU1JrVWxPMXA0c2hq?=
 =?utf-8?B?Y1NwUzNhNjFpbVd1eURoNnhmK25hVlJ3MENXYmR4UFBhYVRZZlZ4SjUrK081?=
 =?utf-8?B?U1VDTURSZS84R1I4Z1lTT3BZUFc4NkFaSWxDdmZ3cTBpUHRaOGx4ckUzbzhq?=
 =?utf-8?B?MjRmYURNQ1VlelB3L2NZVXNQcVpEZ2dqY1d5dXBkQ3pOT3YzSjBqOU13UEFC?=
 =?utf-8?B?MEJOb2dEOHlMdTc0UURERDRxcmNIZ3RkRTZYUnpCUXo4Ulppbk5jZi9JY0U3?=
 =?utf-8?B?U2FGYW0vcUxIWlZEWm85dGd6UUVYaUVpUG5tM0crekRyWGFXMGwrZTVlTmpj?=
 =?utf-8?B?OGM0WnBtaFFHYXg2STVqSXk0WTJ3MGlvZHNhazNZWkNNTUE5WFl2ejNHNlE4?=
 =?utf-8?B?NzR5YWw5YjZyOE5la3BwRk9RcTRac0NBYzBwM3d6WG53b2ZlbzNudmJHaHdP?=
 =?utf-8?B?Z29WTkZ2clVwSUF0ZHZLNEdkcHEwQzJiSzVrTmlFQlBxbnkvZjhtalpSNmMv?=
 =?utf-8?B?cFVxbmdJWVZKUytWUWVqZ1UrKzdTWjlsR2puSnhCU1l5RFNOVWlybFcycFdk?=
 =?utf-8?Q?o7Fbpwgnn5Z+T67gapRJDMY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd77256-b088-4f1f-bf2a-08dcd654ee36
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 13:39:04.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tOFDm6qW6tsQWbD/M0n9VSsIiYAuaJQmGW14qcdYmb0T/qvC1zDgQOhmLPCh6fwV/K9Aku7PYPfyrDRreM9Rd3lls49WADL1dy4v3HbVXpJvBR6/w7RH4rPe4X5dA0C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8256

On 9/15/2024 11:58 AM, Jason Gunthorpe wrote:
> On Fri, Sep 13, 2024 at 08:39:26AM -0600, Mathieu Poirier wrote:
>> KVM has nothing to do with this.  The life of a virtio device starts
>> in the VMM (Virtual Machine Manager) where a backend device is created
>> and a virtio MMIO entry for that device is added to the device tree
>> that is fed to the VM kernel.  When the VM kernel boots the virtio
>> MMIO entry in the DT is parsed as part of the normal device discovery
>> process and a virtio-device is instantiated, added to the virtio-bus
>> and a driver is probed.
>>
>> I suggest you start looking at that process using the kvmtool and a
>> simple virtio device such as virtio-rng.
> I would repeat again, I think trying to create a companion virtio
> device to go along with a real vPCI device and then logically
> associating both of them with a single driver is going to cause so
> much pain you should not do it.
>
> Find a way to send your RPCs through your own vPCI device.
>
> Jason

When you say "your own vPCI device", are you referring to the virtual
functions that are created by the adapter? Those are defined by the
hardware specification and we don't have the ability to extend them.
What we're investigating is using RPMSG-over-VIRTIO, not using virtio
devices directly. It appeared to me that rpmsg was intended to provide a
general-purpose "pipe" between two processors that otherwise don't have
a communication path. That sounds ideal for what we need.

- Doug

External recipient


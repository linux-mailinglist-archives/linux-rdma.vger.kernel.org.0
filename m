Return-Path: <linux-rdma+bounces-10309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A5AB4884
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 02:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DF019E80DE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410978F4A;
	Tue, 13 May 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pOY6ByQj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355A2AE68;
	Tue, 13 May 2025 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097035; cv=fail; b=unQ9WTX/VUQO0iREw7pvkvHhUHyizSKoxGnxNjA+6ajTo7seZzjzMCLm4yVckieXyqeBuNQZR9D4RV7q9x+SRc+dbtnix9IqmbxQuXzQ6jE5TsvdLeIzmdEKO8aDo3qIG4vqhOcwnAzAoLBcqxX8kINbqtbkCM2RLprzRQ401UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097035; c=relaxed/simple;
	bh=bQXWCT+8ZKx6cUlzik9TaZklkMyLzU+ddCEAGGKKY6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrHgBkn1e8NsemiHdrt7ipYjxB6bry1eQw765gu8c5BJyBzLU7ZWdBFgpoSW4h06F+XSH4kG51R64fEIt1nQGGe554ilALEkdqXylOC6XbM9vsufVtpSWiJRK8yOw3mvbMxLd4kh3XX+B+iYTrQxJF5XKr+8Jssn84DAEh2MOPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pOY6ByQj; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1747097033; x=1778633033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bQXWCT+8ZKx6cUlzik9TaZklkMyLzU+ddCEAGGKKY6k=;
  b=pOY6ByQji4wMMEvev0wu9yzwhTcw4/Najz3hdS/2+rlDYzyD3gtKBRdx
   3KAK0LTEJ+EipRuYgiT2GGt7vAixlXGFdJS0hX75OkI4xl76wTP1PyWZL
   Jrya/NOBaFHtZaxQmlDbZqAS8/X8malmlBvLi8lf3Nw7/g28wccEAh4mG
   8srKU+owzXJKmPiTl7CekLp71bTgFdjdG/2DuXiedCcX+RXKYcA/OuU4+
   NiFJDiJBeGKkW3+JDshZi1y2DXdq63rDLht9UmP3VcMuMsJrHnBpA/d3p
   nykO9oNU64yzyMeDFag/j4BnTuoRBVBCodNTDij+OwB8dD93sTzLq2GUF
   A==;
X-CSE-ConnectionGUID: WHLEut5iTrWFINN/yKqHXQ==
X-CSE-MsgGUID: VJRqjgvTR8iwLq0ECW6p0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66218204"
X-IronPort-AV: E=Sophos;i="6.15,283,1739804400"; 
   d="scan'208";a="66218204"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:42:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+bRQfJ4+j7OmBURDnvAJg24rB833Oi7xOo9IgbOcdSyoCRcoqUdmf5+7EyWT1Q2EbYrVRtgMalPbevI9gEMK0zQnVcLXhMiDuLqnnprX4QXMEHT0TEed0Oe/uROQLMcKbtpINhcoZWGYvbVN24PuZ++3ujHK7ec1wNHu5KLmgRr2lT7zLWDg486F/uh7UAa813NMseCNU3JKq3E/UG9dngMTrGQxxaIVfenZOoJb/sa2kDzwN1iAAl+H2b3mIr4uqUvVK1aT6pbKBZi5awCaNXOLa4noGQ9KnFSjl0AbfhzqCa50EZ2z1lizjclpAcSmrMS4nTqG4FLHWi+aHlBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQXWCT+8ZKx6cUlzik9TaZklkMyLzU+ddCEAGGKKY6k=;
 b=f+JIqFqDmEKB2FAk1oGb5a3MvMnoCgM4n88mcAPDV6GZ2YOLZZ1cmx8p2e9m3+MhMtErpX+lc6Wffqta1QTE4+gB34fVPv+zcMjFTpi2DPC/MDNP0+F/M1sk6d9oYe17cRceDBvFJOsi5pPRH1gtmYA1PDjGjjwmQ5Fy0CVghBlD6q12Mo/RzgyYqnzBdTVv1P9BhHiPlS3OkEi01XqwhSgxfip4TrDi3FVJ9PVzZgrHSRc83BiQu6/l/kP4mReNamIQu/JykoRxiqiRptHS0SCc0fmKuEgbHADsqIILUiUdmdU0BLm99MtZw+JFkWQL73FZJ2VtXlEBVZanb0clsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS7PR01MB13862.jpnprd01.prod.outlook.com (2603:1096:604:36b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 00:42:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 00:42:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/cm: Remove redundant WARN_ON in cm_free_priv_msg
Thread-Topic: [PATCH] IB/cm: Remove redundant WARN_ON in cm_free_priv_msg
Thread-Index: AQHbwLrF7ASX1TEY70GlZtsyMn+rCLPO1p0AgADnw4A=
Date: Tue, 13 May 2025 00:42:37 +0000
Message-ID: <f5650c6a-6d65-4bea-96ed-9827ea73309d@fujitsu.com>
References: <20250509081840.40628-1-lizhijian@fujitsu.com>
 <20250512105304.GC22843@unreal>
In-Reply-To: <20250512105304.GC22843@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS7PR01MB13862:EE_
x-ms-office365-filtering-correlation-id: 99c7396c-991a-4643-4371-08dd91b70ef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?enZrazI3c2lsSjNIQ2Faa2JvazFPbm1XemJRUGhLV1dKR3IwRkZBY2xqL1RL?=
 =?utf-8?B?WWozdWc0VUppY0paTTcxWkZ6RTVEWEsxMk9pdWU1QzBVUTgwMWFaazdLZXNK?=
 =?utf-8?B?NkRzVVVudC9IMTJSR2N5QlM2d0VHRWFpNHdhVGpNZXMyQWVzMWVjbk1tU0I0?=
 =?utf-8?B?VzU5aGZ0c1NPQ3FsRk9FQ0ljdkxsLzg5RUVMTlFmRjdwaVRBMUxrVWZvc1dG?=
 =?utf-8?B?VW1yY1JyRlpoSUgrL1B1NnpvTDFyd2l6d0MxTnhwUlAyS1l4cGZvWkRXUGl0?=
 =?utf-8?B?NmxMd0ZsTHM2NTlscWVPR0VLWHdFRVVnb2pOYSswZTBMdjlQOCtOLzRFTzJq?=
 =?utf-8?B?YW1mWmN3WjB6VlBYWUkzS0lrREg3V2hTamdQQml2VHREK3l0QSt6NERVRnZ1?=
 =?utf-8?B?QmhDbktwVEFqenV3R29VVnJ6SWxrRUc5amxOYWdXOFBzVDVQd3lCOUdwUmJ0?=
 =?utf-8?B?eGJNTCtXdnloeUpzTEYwVkdKcktxS2k3WVIwRE5uRWcwbEJFdXZsbGlzNHhZ?=
 =?utf-8?B?aFI4b3ZScHRrQzU3T0NkdVB0RlFmYTA2K1BVazBHZHExcnVNR2Z2MDBnZzQx?=
 =?utf-8?B?NHpzRzVSYzhEYjdVK245NkcycTVBL2U4TjY2bUVWN2RXckxjY0ZDUlJIbkhD?=
 =?utf-8?B?dzNZUUo4Unc4VkFVb2Yrc3ErWXNnS1FwN1dCaTdzSUc1ak9CdDVFSWJ1ZnVh?=
 =?utf-8?B?anhRWUFpL1JzNGJMNi9ORnQ1bCtKdDNacy9vSUM4WVhqTDFpZjM3NGUxMmJy?=
 =?utf-8?B?ZkloWXd5ekxzRjNSVnZSejM0bGxHV21UMVU0dzVpSzRYd2VSYm04SEVodmZX?=
 =?utf-8?B?UUQ4aEdjajdXMndSeHhBZmhRU2ZkQnNMb3Y0d2ZDbWRRcVdNME5PQ2w4WG4v?=
 =?utf-8?B?QmlOckpwQWNaWXlkQ283VWVVdXdncEpvL3VUUFF4UFF3QVYrdEFVSndaRHd2?=
 =?utf-8?B?ZUJwTW1WOUxsK2ROZXNicGFrdS92djJQOWdUZHgrbVpRYlR4elpsTEZDbDl3?=
 =?utf-8?B?VVZFTnRTQjFhdU92emlrVzllNUhZSXpOL0FuemlOanlGbUEwcXc3emdvNVhw?=
 =?utf-8?B?Z005eXFSeTRmem9DbmtYTHNlUUV2bVhYcEFjdUVmY0pFNjBDdUpGckYrc1Z3?=
 =?utf-8?B?UFdINnZLZFBxYkQyTWpZSFI3blEwb0Vyd3d6OWw5WVA0d1RwMHdObXkyclo0?=
 =?utf-8?B?N0tMVzlRZWdyRGFDQk9uZ3ZVWXByN3ZNN3hYZE5XVk5udmFqMXgvUWVyVXFW?=
 =?utf-8?B?ckNqMHJLK0U4U3pMNmFiQVpZcUI4eFVKMVhBcnI2TUYvSXh6bjZtbE4ybXU4?=
 =?utf-8?B?eXJVWE0rMkRlVCs1c1R5UDZNdWpDdjMyZmpTK3FmQVZqWFhXZmhTTVpaeDRm?=
 =?utf-8?B?UzBtOUdPUjd4SXhBbDBSSHlJTFdTVzhjTHU4MFE5bHNxSzU0dkVsb0VvcklR?=
 =?utf-8?B?aFk3ZEhMOVEyNGZLOVFZOGRKTVBYRzR2USsrYmdBZkNuZ0JHQ3d3ZDB0SGIw?=
 =?utf-8?B?TzRuNkdkcmQzL1lLaG83VkhiR3ZQcklSS1NqWjhkL2ZKMlVENnEvNEFyR2Y2?=
 =?utf-8?B?TFBFQk9TQ01NUDM3dEplSmZ4Zjh6UDc1MXpWcWhDbndrR2hDcWhlUWpBVGp5?=
 =?utf-8?B?VGpCVnZ2RzVuZ2xyU1k2bkh2VmhpeGorOFFOdXZPaVRGZHJxazJYZ0Z6ZkI1?=
 =?utf-8?B?d2hSU0dKbEZDdnJNYkQxa3poWEFhcjFlT2h0M05ZVUJVUWptVEpZdWlpTG84?=
 =?utf-8?B?QWZ5aTdrQkllU1lvc2FaY2tNWVRvSEUzZjRjdlRtK0NsU1VDTlM4WHVLb3Br?=
 =?utf-8?B?TjBIVUxCU20reTFnQmErZS9hekdOSzl3dzB4ODlyMU1pSklCWXFTRjh3UjRu?=
 =?utf-8?B?cENDdW5mZUI1MGZyZmFVTVFYRmZEVXNSTURvbEZJUmdTNXVXWUdtOFo5VkdK?=
 =?utf-8?B?aUI1cXhMczI2bmNhSy9PUHg4eHFaWitDZjFSSFJOUW9NRHJmY09JNnQ2R0xZ?=
 =?utf-8?B?aERINVQvNlBsZ1hsdXg0aWtZeWNKSVBNWVR1NFc3RXM5LzZ5NWhidjA4ZGd2?=
 =?utf-8?Q?dgo0h5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWQ1cnUzZmlxNkc1ZlJBTXRSZ0o3aGIzalF4bHNsWGpOajF1am9GdEZPdCt5?=
 =?utf-8?B?bngxT1A0Ri92V2tncFlnbFcycU1YalhyeXdVN2hHdWRwZG1ucnhUaHRuYlVm?=
 =?utf-8?B?TW9HUytxc25LaTdHalVCUDJMQWkyb2FXNVJ1QU1wVWJoUzltd1p6RzJwUU5a?=
 =?utf-8?B?ZnEvbzc0blZhOWtyK1BPSG1pbW5rUXBTRGhOdkxNSXBPczk3MEYwWkt1ZUdm?=
 =?utf-8?B?dUxvMExsOHdLRForTVNHK2JJSWJtekNPSjFxb2VmTzBuNEt4ek9mL1V4a25v?=
 =?utf-8?B?UVo1RFpva0d2NGdKUmRsS0RCOC9PYmJ2QVlSaVB6bG1rakpMays2OFdmY3Rr?=
 =?utf-8?B?VDdXekVuclRlWTA3S1dlZjZHci81Sk5BL3pIZ3NnL3FkQm5JZjhRZjZPem5y?=
 =?utf-8?B?TnFkVFRTNEFoN1U4QVUzZDZLNk9CNkZUVWNlTHQ2QU1pam5OMExHbEtuUWMv?=
 =?utf-8?B?bGFGWERleHVlRkVIV1BrUjh2elF3bHRLZTBtejZJeDQxVExxc0xpYVBtalgv?=
 =?utf-8?B?dTBiNmIzVXRZWDlIZUFCZGdHN3p6ZVE2VlZrdEFhWkNnbUhqUGFubWxsNDB2?=
 =?utf-8?B?V2laYmNEejdZaEt0bWJra3JZZ2Z4emtudWJJRFJWU0RGc0pGdlJwQitRWDU3?=
 =?utf-8?B?THc4Nm5FcTBRcm1yR2lseGMzS2tTdmUyM3Z6U0ROMGxIZHFnTlRTMHBkV0Rs?=
 =?utf-8?B?SkorMmlNR05qQk9qK2dKNGlnNEVHdXBjbi91dDhpc0NJNEtWUHNpRHdEVVJX?=
 =?utf-8?B?REhPclVuV25JNTR1TTBMb2cvc2NzbWhFOGhLZFBOdW1GNEpGQXNPMmlxYnN6?=
 =?utf-8?B?WGdUcWx6Qk5PN28yOGkwaG9OZFFrQ0NzUWRXYlJZSDYvSnhwa3Z1c2t1OWlM?=
 =?utf-8?B?aW11MFlnSEZ4eW8rUTIrRm9WL1A4R1ZEaHd3aGN3b044VzI2N2s3ZkhYQytM?=
 =?utf-8?B?eDdaNldzWFl2VmZtN2J5eWVueWI1VmY4UWtFa1N5T00xdWFHclBReTZoSkhN?=
 =?utf-8?B?SlkrMFJWSldSVmRwNnFvS3V0Q0RVV1RTZmdnWURubE5VWG5nTWN3RlhiRUlX?=
 =?utf-8?B?UWttamhSSjNBREU3V1IycFhyK3J4Y0ZVRXhLVmMrcHdEZFUrRk93enV5OVdN?=
 =?utf-8?B?WWtsNWtWSmFFOGh5UkdobEhpa2tDbDcyRHcwS25qeEhkM1FkWXNJZ2xWZTRp?=
 =?utf-8?B?NXpoUEFMVGVHWW9lUWQrVkQwZ2ZKQVdQazdJQkVZT0sza3JUdVpiYjFaNnp3?=
 =?utf-8?B?S042NUZUNkVNMGZCaUhHclp1K0tRZXZyYk5FeHFnUFlXR21MVkpnWVViMUtE?=
 =?utf-8?B?MUw0WGp1ZEdLd1ZkK01rdC9LZTQ4Rm5yb29WYlk3MlQwMUc5OEJIZFVWM3dF?=
 =?utf-8?B?ak9zWEFyUnZmeXpXWi9ObVplTThsSktQYndBS29PeTNMRUR5TVRyNERYUjJz?=
 =?utf-8?B?SUdBOXBVd2ltS2R1ZTk0L1hSZ1FCU01DTTdzSnZSUElUbytVb05kbkdvYXlG?=
 =?utf-8?B?UUt4bHl2Q1JmN2pPclJzT3RnWmtRRUVqT1k4Z1BqTndPSGI1TlNoYlJBZHdx?=
 =?utf-8?B?OHBOTFJyTGhRSFUvSVp5OCswTGhYWGZvV1pyWVl1V0dyMUlyNlYwT1FLcEN0?=
 =?utf-8?B?Y044RG92MWE3cVdDY1hsQkxXcklDajJtRDNYZ0FXNnkyWTNXTnJMMTA3Zno3?=
 =?utf-8?B?ZTBnSmg3bFZYNWliQ1hPTHJKSWJVMm1GS0h1UCtsZ3VIdzNZZmlzUVk4Tkli?=
 =?utf-8?B?eFkxL3M2ajk2T0Z4NzZOdHkrMElVUVZvV2RJSGM2dlVoMXQrdU16YnROYm9n?=
 =?utf-8?B?NXFaVGVCS1N1SlRMMnJoNFpLcjdBTkxtTDNQRm1IWGI4Z2tvVXVKaVIweGF6?=
 =?utf-8?B?Z002UGFuVkNtZGVVclJtajNUTHBnVnJoSHUrNi9zL0FFU1VhRWtVdXZsTEFx?=
 =?utf-8?B?NE5qZ0QyallkcDlWUENEK0l3L2wxNHZhU0hLY2JRRzFxMy9jZzlNUC9pOXVD?=
 =?utf-8?B?U1R6WW5kbERJR0JzT2FtUW9DZlEzTEFoVXJ2cFNySmNtb3lHa1lqVVBabUxV?=
 =?utf-8?B?ZytwdTZOMmhCWG13Z1BuTzMrRXovTmhQMHlYRldLdDhSaWpabmVObHZqUG1k?=
 =?utf-8?B?alJOYjdBMUVuZDU3UkFpTTJhdEk5amNKZmZIZjZJQzRjeWFFMHRLNzZpSDdP?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFAFCE8E91F6C34EBA71978511857F44@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I9YJWxHbOo5/L1JfT8sV0bh4TTAK9/Ym8oipjONgAP7Kf/VPe065lhILEG6hS5iouKFf/uPfZoJWnss4obEC4iCxJdgv1v/VTZrp+Lz0z3TjV6wkAv23PeHzvI5odNnKbeSL89EUPX2K5+uDreAOKbNfwp/9LluL0Fbh0zwR+loC55+uJxMMLHuBTWk8HePA3x0ypXAJiMI30nIV8L6GCiFcCcA+2gNBt9eMzgub0eMfeSInis35MN+kfiesAt0IUbBWZgzh9OSl4lspL31gIYS7vPuq3WFh2uLmk9pZEcu488jtvitv5z1nVBezVwa7dwt57LR51QN4OQFKZNToxqs5qslLamZMO1LZPZu7bhUFby91EvdTbUXUwHaa9JX6VteyrMqsR590a9L3HV3BLDWO+QyCorSXunCtngb4VToirftv6DgVquy9HUQHJCoDRlJitz1O9oPb6Rm7tq9OYY0APepu9c9epZXHhYSYtsT/PLCsuEJtLGChLGjcYALcPId+SsI9PHSBeVdzY5zaaj4EvlVRd3PaofFbuO2pBqkKtJeeZezfuTDy4r90SMzCCU67TlW9pOPl4JaG8WIV7lMgrRX3YVrH0YZtwESiu9hMhYkCBZS1XyCOxV4RKWta
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c7396c-991a-4643-4371-08dd91b70ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 00:42:37.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNgfAVV18t5rZ7D70c4IqW/jgp6aj/6/VHu/p/flmmyy8mLrG1qnRyd+M/6Z2vczI/C+22C+GAjnO1ZQDGdCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13862

DQoNCk9uIDEyLzA1LzIwMjUgMTg6NTMsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gRnJp
LCBNYXkgMDksIDIwMjUgYXQgMDQ6MTg6NDBQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IFNvbWV0aW1lcywgdGhlIGJsa3Rlc3RzIHRyaWdnZXJlZCB0aGlzIFdBUk5fT04oKToNCj4+ICAg
LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+PiAgIFdBUk5JTkc6IENQVTog
MyBQSUQ6IDEzMzA4ODkgYXQgY20uYzozNTMgY21fZnJlZV9wcml2X21zZysweGFhLzB4YzAgW2li
X2NtXQ0KPj4gLi4uDQo+PiAgIENQVTogMyBVSUQ6IDAgUElEOiAxMzMwODg5IENvbW06IGt3b3Jr
ZXIvdTE2OjEgVGFpbnRlZDogRyAgICAgICAgVyAgT0UgICAgICA2LjEzLjAtcmMzKyAjMw0KPj4g
ICBUYWludGVkOiBbV109V0FSTiwgW09dPU9PVF9NT0RVTEUsIFtFXT1VTlNJR05FRF9NT0RVTEUN
Cj4+ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSks
IEJJT1MgcmVsLTEuMTYuMy0wLWdhNmVkNmI3MDFmMGEtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEv
MjAxNA0KPj4gICBXb3JrcXVldWU6IGliX21hZDEgdGltZW91dF9zZW5kcyBbaWJfY29yZV0NCj4+
ICAgUklQOiAwMDEwOmNtX2ZyZWVfcHJpdl9tc2crMHhhYS8weGMwIFtpYl9jbV0NCj4+IC4uLg0K
Pj4gICBDYWxsIFRyYWNlOg0KPj4gICAgPFRBU0s+DQo+PiAgICA/IGNtX2ZyZWVfcHJpdl9tc2cr
MHhhYS8weGMwIFtpYl9jbV0NCj4+ICAgID8gX193YXJuLmNvbGQrMHg5My8weGZhDQo+PiAgICA/
IGNtX2ZyZWVfcHJpdl9tc2crMHhhYS8weGMwIFtpYl9jbV0NCj4+ICAgID8gcmVwb3J0X2J1Zysw
eGZmLzB4MTQwDQo+PiAgICA/IGhhbmRsZV9idWcrMHg1OC8weDkwDQo+PiAgICA/IGV4Y19pbnZh
bGlkX29wKzB4MTcvMHg3MA0KPj4gICAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwDQo+
PiAgICA/IGNtX2ZyZWVfcHJpdl9tc2crMHhhYS8weGMwIFtpYl9jbV0NCj4+ICAgIGNtX3Byb2Nl
c3Nfc2VuZF9lcnJvcisweDY0LzB4MWYwIFtpYl9jbV0NCj4+ICAgIHRpbWVvdXRfc2VuZHMrMHgx
ZTUvMHgyZDAgW2liX2NvcmVdDQo+PiAgICBwcm9jZXNzX29uZV93b3JrKzB4MTU2LzB4MzEwDQo+
PiAgICB3b3JrZXJfdGhyZWFkKzB4MjUyLzB4MzkwDQo+PiAgICA/IF9fcGZ4X3dvcmtlcl90aHJl
YWQrMHgxMC8weDEwDQo+PiAgICBrdGhyZWFkKzB4ZDIvMHgxMDANCj4+ICAgID8gX19wZnhfa3Ro
cmVhZCsweDEwLzB4MTANCj4+ICAgIHJldF9mcm9tX2ZvcmsrMHgzNC8weDUwDQo+PiAgICA/IF9f
cGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+PiAgICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAN
Cj4+ICAgIDwvVEFTSz4NCj4+ICAgLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0t
DQo+Pg0KPj4gSW4gY21fcHJvY2Vzc19zZW5kX2Vycm9yKCksIGNtX2ZyZWVfcHJpdl9tc2coKSB3
aWxsIGJlIGNhbGxlZA0KPj4gd2hlbiAobXNnICE9IGNtX2lkX3ByaXYtPm1zZykgaXMgdHJ1ZS4g
QW5kIGFsbCBvdGhlciBjYWxsaW5nIHRvDQo+PiBjbV9mcmVlX3ByaXZfbXNnKCkgY2FzZXMsIG1z
ZyBpcyBhbHdheXMgdGhlIHNhbWUgYXMgY21faWRfcHJpdi0+bXNnLg0KPj4NCj4+IFNvIGl0J3Mg
c2FmZSB0byByZW1vdmUgdGhpcyBXQVJOX09ODQo+IA0KPiBUaGlzIHBhdGNoIHNob3VsZCBmaXgg
dGhlIGlzc3VlLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMGMzNjRjMjkxNDJmNzJi
Nzg3NWZkZWJhNTFmM2M5YmQ2Y2E4NjNlZS4xNzQ1ODM5Nzg4LmdpdC5sZW9uQGtlcm5lbC5vcmcv
DQo+IDc1OTA2NDllZTdhZiAoIklCL2NtOiBEcm9wIGxvY2tkZXAgYXNzZXJ0IGFuZCBXQVJOIHdo
ZW4gZnJlZWluZyBvbGQgbXNnIikNCg0KDQpZZWFoLCB0aGFua3MgZm9yIHRoaXMgaW5mb3JtYXRp
b24uDQoNCg0KDQo+IA0KPiBUaGFua3M=


Return-Path: <linux-rdma+bounces-7346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0CA23DB1
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2025 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39AB1688F1
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2025 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89091C3F39;
	Fri, 31 Jan 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Px1u5C3T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC91B85EC;
	Fri, 31 Jan 2025 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738326285; cv=fail; b=WxeSpKrqi/HM2+VLqg6xDPJzG2rnaBfamT6gsZZay+fG4QfILTpaJkU7sjcnQyO1jMwEhh/ybnXeK4WA6RmCdG5bizL3dQ8XlPvTMLTwJRt95UeP3bAm8fjSSu83opgU0Za+49B1DpwXJoC2dHUcs4m1HlfJ+g7zC+4o1PBxrhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738326285; c=relaxed/simple;
	bh=Z+DTadwLFXf4ncIWbH8mEia/ZvGG0DCVFn2OGgQUgIk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DsmjXJegCcJLwPZzQ+lZksuzaMSaTkT8AW1XF9E8Ehgm5JiDJTstbM2R9/QiL3TwKI396Mb4V8yYqyTrr14kSmgl20qJrUCHOUln+Qxc/czVcoL9cWEmYgf8djbS5x6lCtcBG/VuVPpLy04I4E1/T3r7FTSruYguC3+DrOXtvq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Px1u5C3T; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OM6b021899;
	Fri, 31 Jan 2025 12:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z+DTad
	wLFXf4ncIWbH8mEia/ZvGG0DCVFn2OGgQUgIk=; b=Px1u5C3TJTFFXTkqZWZcQ9
	FCSy31iQb94YCMBIHNIgckYHBow4s9upxgEQrGhsQ7+CQQw86v5NW0bBkio+mDSY
	Ysuj8LhWrTeZ17MWsbJlCuJF4uzQOg9erimvgPMV/VuQovh2wSGOTPFzofPkwB5U
	/Z+/K8enaNb3Eki8lb2S2gX+3gGqrqdTmgBkUVMMkDnISoytGKe3Q4YZuxP3Rqgy
	OXbJuT5qn5nz+KmojInh9phpy0TMWs2+vH+EEbfPHLhNl3WBK8GmKiq6PI+/Jfqj
	75NJ8YVxb6WseRoC8+aIpboUiaUf21m37HmHUUJF5g1VELRRT3E/KR9rE8E+7sBQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnbya612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 12:24:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VCOJJL031991;
	Fri, 31 Jan 2025 12:24:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnbya60y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 12:24:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYUqM2cliYHGqomZXiP/U+cCOd6+J49up6HgcJETTSV66JKXIyPDybWUYhaVkoGM7AOhlwCno76ozNvWb2DYokdXAUecE9qDHuihIiWu2IpSBWBEw/jrjOq8E3VHdX6qa1F7OnQAwuWDet+YzdEI1zw+ZBxPfM0kdaiJTMT1FRuohEht0/3EbYRMVrbD2ShBOSyB6E5MsHsZ6/rJmJD6pxUA9ezl8oW+OMslI6e9B96cXhm+HDNIZQDENpSmSqdb1GElYbYRgAlKiitX7tpHH/1Cgo7J4ZC/Mc+7V5k9qJDydidH1lVnH/dFmuq1pFzKSDnbOcjIPUmwkJ21ta6vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+DTadwLFXf4ncIWbH8mEia/ZvGG0DCVFn2OGgQUgIk=;
 b=ZZyKIy4o0v63guIT9fUxW6sDW6SWWwZ6FW9gJoE7vqZtNSjX1h0HefZQx9PPh3hfnnjaZ9kPqM8lrPn56KNMY/VevLGJ9H7sAQMB/NPe/ChQr6FZqq1PDTQV35VilggaA3r/Zj9ZB8e7Kn4cWzSxKXZWq9er15RG9PluDocxzx6/nptrhyGvOkHy0XiabhzshNFyndOGQOCEAFDItL27mRqr5gT1xKpYxvS0m6inZEyUTDq8MPDAWZv30+NTfrZDGLJCAMRtj9EAAl+U+3z/3IX1DjV9nfUWcJITJargBTVDBiefh3kLKV2VQheQqhzKEZNUN1MUTcDdoV9cjpXfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by SJ2PR15MB6402.namprd15.prod.outlook.com (2603:10b6:a03:573::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 12:24:32 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%3]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 12:24:32 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun
	<zyjzyj2000@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 5/6] RDMA/siw: fix type of CRC field
Thread-Index: AQHbcQxHfCGWmp9MykC7z9YYyrT0tLMsQH4Q
Date: Fri, 31 Jan 2025 12:24:32 +0000
Message-ID:
 <BN8PR15MB251384CC8D55FE475B1F85C099E82@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-6-ebiggers@kernel.org>
In-Reply-To: <20250127223840.67280-6-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|SJ2PR15MB6402:EE_
x-ms-office365-filtering-correlation-id: abc744d6-f960-4a9d-ef51-08dd41f23763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkJNR28wam1icGJ6RWJjUUFlRTZGZ3NoRFpuQ1FGQXFwRHN1OVhXVGVuUEdu?=
 =?utf-8?B?Z29iQzIxWTUzcW9XZEpaWE5nT3M0SzlxbElVUFhtUnp1QTVrNTNDQ1pML3RV?=
 =?utf-8?B?OXNxNUJYK0tzRlRKUVQ3bmVsOS8vcExqL0hoY3hiRXFMTFI0SEVmbHNSUUtK?=
 =?utf-8?B?SjhEYlMydks1eU5CeHd2Yml2SWdOYjJ2NGk1M1RlN0p0QU12WDNjanpxdkJH?=
 =?utf-8?B?dURqWTgrUkpxSWEzOTVDbFJVM1NibThOakM1WkhvcFVjSlB0YitsaXRVYzgv?=
 =?utf-8?B?eExDbEdtWUZsa0lEVXYwVkJxMGRCNVJaMnRDVmlwZEFwTXh4a01SbGNrU0lC?=
 =?utf-8?B?andHNXUvN0p0bDlxTjlmV1RmY0VmcldkaDIvUldjdnNWcXlGYWxwbHgxZG1i?=
 =?utf-8?B?VFB1T0grT3NUdjRHZEsrUjZYSVFRKzBOYlZMQTNGU1l5aUl2Z3VRRUphY0RP?=
 =?utf-8?B?ZE93WXl2anZRTVROS2V4ejVXSEtRbk5TdEZRdmpwTzZ6M1h5bEFRcjBXUWU5?=
 =?utf-8?B?UzduYXNGQmk1SXBzK2J6Wk5XWmlBWmFWc2xsMjhDdllZZ1FML0NJSzN3UmhM?=
 =?utf-8?B?bHUybzE3SHMramJyeFB0KzZSTUZLVml0QnVlNXBWS3kzVER0WXg4Y0pLUlFH?=
 =?utf-8?B?eW4wQis5UVZVamtmSlIwNnp4MW4xak1neHpLSzJpSkljNmZsZWNUaThtMyt5?=
 =?utf-8?B?SlZQOHZkVUJtclFJUDVRNWk4VDRaQlc0WkYxOEhOcDR5VEQvQldQVlRycFho?=
 =?utf-8?B?NkxBSzdGbjlyMnJIZy85c0h0blI2ZVlWV3NmMkFBZFhDUE1uWGlVUEdrOVZ6?=
 =?utf-8?B?T0ZtQ0h3V1A4d09QNzlrZ3dLcENEYjQ3cUNIckdkSWJ2Mnp2NzNMVnMzc0Qy?=
 =?utf-8?B?cWRRa2Q0OW5CSEVVTW9zcjRJQysyN0RPaDQvRjdRVjhDRnU4ZnhaL3ZFb0ZU?=
 =?utf-8?B?QkNlUE0yUlNZem5JNlk0QUdWQkkxa0xod1VlN2FSSkpKTFo2ekVUcTBKOHF1?=
 =?utf-8?B?aEh6Y3lIRFdVVnJxcTAxRkNudzBqMExhZDJKVExiU0hSS0ZYWUdHRmVnS3du?=
 =?utf-8?B?TWtKVWZZUitiNG9OSkllcTZRVG0rUnhRcmdsVm9udThSNVR2Y3V3TXRVTlAv?=
 =?utf-8?B?QXQxMVdIbnlOdTFoYlI0emZGTHdsekVhK1pIY3dnUGllN3V5SkhNSFBIYS9y?=
 =?utf-8?B?djlOeitIRGtvTWtsNVY3cDRmWEdxQjFjcjRETEJBd3BnSU9kQ0grdmt4YVBi?=
 =?utf-8?B?Rm0wSzJmV0tESGhLYmZIZG9QTnNXNkNYMjBpMEVlZ1pEdUQycGZ1U2oxZCta?=
 =?utf-8?B?bzN2cndNVjdUdytjSGNMMHpxZWNRTURtdDUzNnpmQ2w3YW1POFlEUml4ZFBM?=
 =?utf-8?B?WFF1UVhiUzZmcG16TlNyZVBRVXRGZFVGdHJmRG84dVUxWmMzZmVEelBDWTV5?=
 =?utf-8?B?UTVseS92UUM5QkRiZStiUTBkcy9EZlFaSGRwK05lQVNFVzE4THNFSzFPYzQw?=
 =?utf-8?B?SWhMNmh1WWVkeS9xRXV5NWlSTWJGV05yaFFLTCtpQUlXVGVyZmQ5aGJkakpq?=
 =?utf-8?B?L0Q4UlNsK2ZRdlZva2JkUHY1SVhHaWYzVWFSdlJ2WENYWEtBYVJ4NjVxc3Y1?=
 =?utf-8?B?NmM1dlg1V2kxZ00vNEw1UTBXVzlsSU9pd3lRL1R3RmVKYWZBOFYwYTh5NUtQ?=
 =?utf-8?B?OVZKSkpJdUZJRWZicVhlTnFjbGpDVzVBelk2dmZlM24xSlZNaFBLV3dURUs1?=
 =?utf-8?B?VzcxOE5DTFlGdTFJVEtOOFVIR0lzeUlLc3E2SHBEVkRVY3NKc1lGZ0tTTnZE?=
 =?utf-8?B?R2FsMnpEaFMzN2Erc1RweTFpZ0FLK2FkVXJjb3J4aFFGclc1RExqQ0NBVlE1?=
 =?utf-8?B?SGxCMENSOElKblFncEY2Mi94WmJLb3NMWGoxVG5pR3kwWWdXQWFRQnp0SzFU?=
 =?utf-8?Q?IAypoHuGEj66SscK6C3zEK9QMqj28S+/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG1keTVVVGc2MmsvVVJJQ05CZEZQNlBnRlUyT0Urb01DNjdydXlWMjVYeFlu?=
 =?utf-8?B?Q29ob1dqYlZibFRxT3NQejNmU1d6cjk2WjQvWUp6bkhRdnVGdEt4WENiazEx?=
 =?utf-8?B?eks5ZFdPZWNyZmhMUWQ2YzBZOXNDK3VtNDUrcUFlNHBkdzFTQyt0MEloUEcv?=
 =?utf-8?B?OUxhMzJNWC9sK0kzYzdwd1ZRMTBkcDc0Sm5rR1BsYmlwS2RYdlBuWkZLVzNG?=
 =?utf-8?B?dzI0MGs3NVh6TWtDcUpyZytmL1daOU0rNU0wRnlKc0k3bDQyKzhZcUhnV29j?=
 =?utf-8?B?WGFvYVFqbmpOY1pBckZTU3JqZDNMTWZzcTZod2dQNmVwS1FnUXFOQzIxOEwr?=
 =?utf-8?B?SnVKU2N2SjhJTjFwakwwWld6U3BkVDdZWWsrdTNlZ1AwS2pNN1UzUkw2SFpL?=
 =?utf-8?B?bmZDTGNCcXRrWlM3T2NKbmdmYkdNZEljUEk3UUw5U0lndEw4bDlrSVBYTzRQ?=
 =?utf-8?B?SGN6d1BUY2RXLzFORXhCRjdQL0l2UHMrUVpPSkFuL0Vha0NNalR1NzdmZnRT?=
 =?utf-8?B?SldORzI0MU9LYmhFNEE4NzF1a3NlUGxkbkxlaHY3RE5XYWZWcURkV0Q5aUlU?=
 =?utf-8?B?TXVDVkhsUURGMkMvc2E3bFZkS05TRlduRkhLclNxak45c1VvRHF4MTJhTWNK?=
 =?utf-8?B?WWI1cTZJOVdqNTRjcWVxYlREdGw1YmphbWIyMHpGOVRtMUM2OTJnRjh5aUFM?=
 =?utf-8?B?R2xzNFM1TFBjQlhYbC9XQmpCdmxxV1E5UDBUN1g5bnJmOWVJdGdYNjI1b1dL?=
 =?utf-8?B?cmRCRlA2QnkyK2xTeW1zM2FSZ2YvM2E0K3J3bkh3K3k2WktqSFJTL2poUmg3?=
 =?utf-8?B?d3luLzlPZnUvZUVlQkhaTkI5bUtiRUZNK2V4MDlPMHdKYWxpQTJjK1VqWkc1?=
 =?utf-8?B?Znloc084QjdTN1RLbTMyQk9OREYzVFdMZG5obDlha1FEaXo2TEt6MkR2RU95?=
 =?utf-8?B?K1NrTlRWcGd0Y2NNSExSb2VmVHBuUmpaRFI4K2orVFFIdWVISis4Q3NWRElk?=
 =?utf-8?B?WnFVQUF0N0VvakpzOXVHS0lDZjNQTyt4V0xENHpyY2FsLzRqekdEY3h1RnNK?=
 =?utf-8?B?UDBwYnFaWndaRmxDMFVzam9hUStudllVeGUvWVpQazNFWENkNmpNN3ErdGdY?=
 =?utf-8?B?OGZCU1R5S2dMRFc2MTRqQTdrdFcrUWNpWmRNVkZXMUVpMkQyNXgxdThSTmgy?=
 =?utf-8?B?MFhLWVRDTmg5VVFxbFlTQklPM2szMjI4VndXL0huTTU0VHQrOFk1aTJiWHk4?=
 =?utf-8?B?USt2c0xXU3pRcFpNUi8xbDJRejVFRmtqc05wcmVRcG5aWXVVSHF1eWlUZnhk?=
 =?utf-8?B?VDZDUXRaNUNHYUdwdG9uOXI0TjladHVySzNVSTdjWFFsSUFzVUFlWXVGZlNi?=
 =?utf-8?B?RnpPTTE0eHR5OG02WUVpRmQyWHYwS29VVW9EdGQ1N2dKOHNDazhJZU9xWEll?=
 =?utf-8?B?b2llcnoxK05YcFU4VDhHSHcrRUh4QzFCM0t4T0hEOVR0OFNaQW9LMkRqYXJj?=
 =?utf-8?B?RWhwQ3N1b05YY21pVSs4d3B2YWRtekNEMC9HWUhTUGFJeExFOXI1S3MxU3Q5?=
 =?utf-8?B?RlZHUjk0eXZ6Z0kzR0RaY0h2S1BTOEEvNHhjZThNTWI1cTdFejNhak5aOUdP?=
 =?utf-8?B?ZGFJcVJvRTZFWDAzZUJ4V0VSaDMxZnZPK09pZU5EUUVrUitDUStjTVdXRDFr?=
 =?utf-8?B?b0VUVDdqT1FIVUcrSmtrODNoM0Y2UE5nRklLS1ZLL0RqS2FEL1I2OXVvTzEw?=
 =?utf-8?B?RStpV2IwMk1SWHNLd2c1VElERTR6dXE4c0hNeERQNzh2L290OUpkb1JzQ0lo?=
 =?utf-8?B?YStwNFFrWUdsSzUrM0FrRGh4djhqKzFqYTZHSUFTUnBpY1gzeW50Z2ZvblRi?=
 =?utf-8?B?KzdhSG9uNWcvT0x2RWNhYnl6ems1aCs3emtmLytQZnZDVVM5MU9hNTlWQUt5?=
 =?utf-8?B?TFU4QzFVb3B6V002QXJTRHlubm9waUJqbDY0V0ZSeHdUb09Kdmp5SWVxd0l5?=
 =?utf-8?B?WFRUZ2REeDFVR0tZbllsUXJkWjJtTzZ6ZG5hMnp0VkFsQkFxWEZ4SjJDVHV6?=
 =?utf-8?B?U0pWWG11R3ZERFRmdWo5TkQ2TEFxb0xMR0xGcUt1eXhaTWZoTlgxMW1PRDRQ?=
 =?utf-8?B?eFZOSzlYY0JoNGc2dC92L3Jqem0xa0w0TGJZY0U5ekdmUjIzcWZpOFJSZTdz?=
 =?utf-8?Q?2suwm0Ry6cf3ceXfvnYrSzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc744d6-f960-4a9d-ef51-08dd41f23763
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 12:24:32.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJ7RpDhjDDjs22WgctOVZwthvTn/h9QCQi5CJu+WASUwbddeavbKF41+JbIXvEsbIXnPiiK381U3Xb/ql8onEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6402
X-Proofpoint-ORIG-GUID: tQ5x3YV385aXs15JTZhYVLfb9uSnJrZF
X-Proofpoint-GUID: PDcBkFBfdPO4PrxvmyNjDHxsQ0U3aaOa
Subject: RE:  [PATCH 5/6] RDMA/siw: fix type of CRC field
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310091

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCaWdnZXJzIDxl
YmlnZ2Vyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjcsIDIwMjUgMTE6
MzkgUE0NCj4gVG86IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBNdXN0YWZhIElzbWFpbCA8
bXVzdGFmYS5pc21haWxAaW50ZWwuY29tPjsNCj4gVGF0eWFuYSBOaWtvbG92YSA8dGF0eWFuYS5l
Lm5pa29sb3ZhQGludGVsLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQHppZXBlLmNhPjsg
TGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBaaHUgWWFuanVuDQo+IDx6eWp6eWoy
MDAwQGdtYWlsLmNvbT47IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQ
QVRDSCA1LzZdIFJETUEvc2l3OiBmaXggdHlwZSBvZiBDUkMgZmllbGQNCj4gDQo+IEZyb206IEVy
aWMgQmlnZ2VycyA8ZWJpZ2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQoNCg0KTWFueSB0aGFua3MgZm9y
IG1ha2luZyB0aGUgY29ycmVjdCBDUkMzMmMgaGFuZGxpbmcgZXhwbGljaXQuDQoNCj4gVGhlIHVz
dWFsIGJpZyBlbmRpYW4gY29udmVudGlvbiBvZiBJbmZpbmlCYW5kIGRvZXMgbm90IGFwcGx5IHRv
IHRoZSBNUEENCg0KJ0luZmluaUJhbmQnIGlzIG1pc2xlYWRpbmcgaGVyZS4gVHJhbnNtaXR0aW5n
IHByb3RvY29sIGhlYWRlciBmaWVsZHMNCmluIGJpZyBlbmRpYW4gb3JkZXIgaXMgYSBuZXR3b3Jr
IHByb3RvY29sIGNvbnZlbnRpb24gaW4gZ2VuZXJhbCwgc28NCml0IGlzIG9mdGVuIGNhbGxlZCBu
ZXR3b3JrIGJ5dGUgb3JkZXIuIGlXYXJwIGlzIG5vdCBhbiBJbmZpbmlCYW5kDQpwcm90b2NvbCBi
dXQgYW4gSUVURiBwcm90b2NvbC4gU28gaW4gSU1PLCB0aGUgc3BlY2lmaWNzIG9mIENSQzMyYw0K
bmV0d29yayB0cmFuc21pc3Npb24gd291bGQgYmUgYmV0dGVyIGhpZ2hsaWdodGVkIHdoZW4gY29t
cGFyaW5nIHRvDQpOQk8gaW4gZ2VuZXJhbC4NCg0KPiBDUkMgZmllbGQsIHdob3NlIHRyYW5zbWlz
c2lvbiBpcyBzcGVjaWZpZWQgaW4gdGVybXMgb2YgdGhlIENSQzMyDQo+IHBvbHlub21pYWwgY29l
ZmZpY2llbnRzLiAgVGhlIGNvZWZmaWNpZW50cyBhcmUgdHJhbnNtaXR0ZWQgaW4gZGVzY2VuZGlu
Zw0KPiBvcmRlciBmcm9tIHRoZSB4XjMxIGNvZWZmaWNpZW50IHRvIHRoZSB4XjAgb25lLiAgV2hl
biB0aGUgcmVzdWx0IGlzDQo+IGludGVycHJldGVkIGFzIGEgMzItYml0IGludGVnZXIgdXNpbmcg
dGhlIHJlcXVpcmVkIHJldmVyc2UgbWFwcGluZw0KPiBiZXR3ZWVuIGJpdHMgYW5kIHBvbHlub21p
YWwgY29lZmZpY2llbnRzLCBpdCdzIGEgX19sZTMyLg0KPiANCj4gRml4IHRoZSBjb2RlIHRvIHVz
ZSB0aGUgY29ycmVjdCB0eXBlLg0KPiANCj4gVGhlIGVuZGlhbm5lc3MgY29udmVyc2lvbiB0byBs
aXR0bGUgZW5kaWFuIHdhcyBhY3R1YWxseSBhbHJlYWR5IGRvbmUgaW4NCj4gY3J5cHRvX3NoYXNo
X2ZpbmFsKCkuICBUaGVyZWZvcmUgdGhpcyBwYXRjaCBkb2VzIG5vdCBjaGFuZ2UgYW55DQo+IGJl
aGF2aW9yLCBleGNlcHQgZm9yIGFkZGluZyB0aGUgbWlzc2luZyBsZTMyX3RvX2NwdSgpIHRvIHRo
ZSBwcl93YXJuKCkNCj4gbWVzc2FnZSBpbiBzaXdfZ2V0X3RyYWlsZXIoKSB3aGljaCBtYWtlcyB0
aGUgY29ycmVjdCB2YWx1ZXMgYmUgcHJpbnRlZA0KPiBvbiBiaWcgZW5kaWFuIHN5c3RlbXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9pd2FycC5oICAgICB8ICAyICstDQo+
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oICAgICAgIHwgIDggKysrKy0tLS0NCj4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMgICAgfCAgMiArLQ0KPiAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYyB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCAgMiArLQ0KPiAgNSBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L2l3YXJwLmgNCj4gYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L2l3YXJwLmgNCj4gaW5kZXggOGNmNjkzMDk4MjdkNi4uYWZlYmI1ZDg2
NDNlMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9pd2FycC5oDQo+
ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvaXdhcnAuaA0KPiBAQCAtNzksMTEgKzc5
LDExIEBAIHN0cnVjdCBtcGFfbWFya2VyIHsNCj4gIC8qDQo+ICAgKiBtYXhpbXVtIE1QQSB0cmFp
bGVyDQo+ICAgKi8NCj4gIHN0cnVjdCBtcGFfdHJhaWxlciB7DQo+ICAJX191OCBwYWRbNF07DQo+
IC0JX19iZTMyIGNyYzsNCj4gKwlfX2xlMzIgY3JjOw0KPiAgfTsNCj4gDQo+ICAjZGVmaW5lIE1Q
QV9IRFJfU0laRSAyDQo+ICAjZGVmaW5lIE1QQV9DUkNfU0laRSA0DQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3LmgNCj4gaW5kZXggZWE1ZWVlNTBkYzM5ZC4uNTA2NDk5NzFmNjI1NCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IEBAIC0zMzYsMjYgKzMzNiwyNiBAQCBzdHJ1
Y3Qgc2l3X3J4X2ZwZHUgew0KPiAgICogU2hvcnRoYW5kcyBmb3Igc2hvcnQgcGFja2V0cyB3L28g
cGF5bG9hZA0KPiAgICogdG8gYmUgdHJhbnNtaXR0ZWQgbW9yZSBlZmZpY2llbnQuDQo+ICAgKi8N
Cj4gIHN0cnVjdCBzaXdfc2VuZF9wa3Qgew0KPiAgCXN0cnVjdCBpd2FycF9zZW5kIHNlbmQ7DQo+
IC0JX19iZTMyIGNyYzsNCj4gKwlfX2xlMzIgY3JjOw0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc2l3
X3dyaXRlX3BrdCB7DQo+ICAJc3RydWN0IGl3YXJwX3JkbWFfd3JpdGUgd3JpdGU7DQo+IC0JX19i
ZTMyIGNyYzsNCj4gKwlfX2xlMzIgY3JjOw0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc2l3X3JyZXFf
cGt0IHsNCj4gIAlzdHJ1Y3QgaXdhcnBfcmRtYV9ycmVxIHJyZXE7DQo+IC0JX19iZTMyIGNyYzsN
Cj4gKwlfX2xlMzIgY3JjOw0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc2l3X3JyZXNwX3BrdCB7DQo+
ICAJc3RydWN0IGl3YXJwX3JkbWFfcnJlc3AgcnJlc3A7DQo+IC0JX19iZTMyIGNyYzsNCj4gKwlf
X2xlMzIgY3JjOw0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3Qgc2l3X2l3YXJwX3R4IHsNCj4gIAl1bmlv
biB7DQo+ICAJCXVuaW9uIGl3YXJwX2hkciBoZHI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd19xcC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXAuYw0KPiBpbmRleCBkYTkyY2ZhMjA3M2Q3Li5lYTdkMmY1YzhiOGVlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcC5jDQo+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMNCj4gQEAgLTM5NCwxMSArMzk0LDExIEBAIHZvaWQg
c2l3X3NlbmRfdGVybWluYXRlKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCXN0cnVjdCBpd2FycF90
ZXJtaW5hdGUgKnRlcm0gPSBOVUxMOw0KPiAgCXVuaW9uIGl3YXJwX2hkciAqZXJyX2hkciA9IE5V
TEw7DQo+ICAJc3RydWN0IHNvY2tldCAqcyA9IHFwLT5hdHRycy5zazsNCj4gIAlzdHJ1Y3Qgc2l3
X3J4X3N0cmVhbSAqc3J4ID0gJnFwLT5yeF9zdHJlYW07DQo+ICAJdW5pb24gaXdhcnBfaGRyICpy
eF9oZHIgPSAmc3J4LT5oZHI7DQo+IC0JdTMyIGNyYyA9IDA7DQo+ICsJX19sZTMyIGNyYyA9IDA7
DQo+ICAJaW50IG51bV9mcmFncywgbGVuX3Rlcm1pbmF0ZSwgcnY7DQo+IA0KPiAgCWlmICghcXAt
PnRlcm1faW5mby52YWxpZCkNCj4gIAkJcmV0dXJuOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19xcF9yeC5jDQo+IGluZGV4IGVkNGZjMzk3MThiNDkuLjA5OGUzMmZiMzZmYjEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMNCj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiBAQCAtOTUxLDEx
ICs5NTEsMTEgQEAgaW50IHNpd19wcm9jX3Rlcm1pbmF0ZShzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4g
IHN0YXRpYyBpbnQgc2l3X2dldF90cmFpbGVyKHN0cnVjdCBzaXdfcXAgKnFwLCBzdHJ1Y3Qgc2l3
X3J4X3N0cmVhbSAqc3J4KQ0KPiAgew0KPiAgCXN0cnVjdCBza19idWZmICpza2IgPSBzcngtPnNr
YjsNCj4gIAlpbnQgYXZhaWwgPSBtaW4oc3J4LT5za2JfbmV3LCBzcngtPmZwZHVfcGFydF9yZW0p
Ow0KPiAgCXU4ICp0YnVmID0gKHU4ICopJnNyeC0+dHJhaWxlci5jcmMgLSBzcngtPnBhZDsNCj4g
LQlfX3dzdW0gY3JjX2luLCBjcmNfb3duID0gMDsNCj4gKwlfX2xlMzIgY3JjX2luLCBjcmNfb3du
ID0gMDsNCj4gDQo+ICAJc2l3X2RiZ19xcChxcCwgImV4cGVjdGVkICVkLCBhdmFpbGFibGUgJWQs
IHBhZCAldVxuIiwNCj4gIAkJICAgc3J4LT5mcGR1X3BhcnRfcmVtLCBzcngtPnNrYl9uZXcsIHNy
eC0+cGFkKTsNCj4gDQo+ICAJc2tiX2NvcHlfYml0cyhza2IsIHNyeC0+c2tiX29mZnNldCwgdGJ1
ZiwgYXZhaWwpOw0KPiBAQCAtOTY5LDIwICs5NjksMjYgQEAgc3RhdGljIGludCBzaXdfZ2V0X3Ry
YWlsZXIoc3RydWN0IHNpd19xcCAqcXAsIHN0cnVjdA0KPiBzaXdfcnhfc3RyZWFtICpzcngpDQo+
ICAJaWYgKCFzcngtPm1wYV9jcmNfaGQpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gIAlpZiAoc3J4
LT5wYWQpDQo+ICAJCWNyeXB0b19zaGFzaF91cGRhdGUoc3J4LT5tcGFfY3JjX2hkLCB0YnVmLCBz
cngtPnBhZCk7DQo+ICsNCj4gIAkvKg0KPiAtCSAqIENSQzMyIGlzIGNvbXB1dGVkLCB0cmFuc21p
dHRlZCBhbmQgcmVjZWl2ZWQgZGlyZWN0bHkgaW4gTkJPLA0KPiAtCSAqIHNvIHRoZXJlJ3MgbmV2
ZXIgYSByZWFzb24gdG8gY29udmVydCBieXRlIG9yZGVyLg0KPiArCSAqIFRoZSB1c3VhbCBiaWcg
ZW5kaWFuIGNvbnZlbnRpb24gb2YgSW5maW5pQmFuZCBkb2VzIG5vdCBhcHBseSB0bw0KPiB0aGUN
Cg0KQmV0dGVyIG5vdCBtZW50aW9uIEluZmluaUJhbmQgaGVyZSwgdGhpcyBpcyBhbiBJRVRGIHBy
b3RvY29sIG9uIHRvcA0Kb2YgVENQL1NDVFAuIEp1c3QgY29tcGFyZSB0byBOQk8gaW4gZ2VuZXJh
bC4NCg0KPiArCSAqIENSQyBmaWVsZCwgd2hvc2UgdHJhbnNtaXNzaW9uIGlzIHNwZWNpZmllZCBp
biB0ZXJtcyBvZiB0aGUgQ1JDMzINCj4gKwkgKiBwb2x5bm9taWFsIGNvZWZmaWNpZW50cy4gIFRo
ZSBjb2VmZmljaWVudHMgYXJlIHRyYW5zbWl0dGVkIGluDQo+ICsJICogZGVzY2VuZGluZyBvcmRl
ciBmcm9tIHRoZSB4XjMxIGNvZWZmaWNpZW50IHRvIHRoZSB4XjAgb25lLiAgV2hlbg0KPiB0aGUN
Cj4gKwkgKiByZXN1bHQgaXMgaW50ZXJwcmV0ZWQgYXMgYSAzMi1iaXQgaW50ZWdlciB1c2luZyB0
aGUgcmVxdWlyZWQNCj4gcmV2ZXJzZQ0KPiArCSAqIG1hcHBpbmcgYmV0d2VlbiBiaXRzIGFuZCBw
b2x5bm9taWFsIGNvZWZmaWNpZW50cywgaXQncyBhIF9fbGUzMi4NCj4gIAkgKi8NCj4gIAljcnlw
dG9fc2hhc2hfZmluYWwoc3J4LT5tcGFfY3JjX2hkLCAodTggKikmY3JjX293bik7DQo+IC0JY3Jj
X2luID0gKF9fZm9yY2UgX193c3VtKXNyeC0+dHJhaWxlci5jcmM7DQo+ICsJY3JjX2luID0gc3J4
LT50cmFpbGVyLmNyYzsNCj4gDQo+ICAJaWYgKHVubGlrZWx5KGNyY19pbiAhPSBjcmNfb3duKSkg
ew0KPiAgCQlwcl93YXJuKCJzaXc6IGNyYyBlcnJvci4gaW46ICUwOHgsIG93biAlMDh4LCBvcCAl
dVxuIiwNCj4gLQkJCWNyY19pbiwgY3JjX293biwgcXAtPnJ4X3N0cmVhbS5yZG1hcF9vcCk7DQo+
ICsJCQlsZTMyX3RvX2NwdShjcmNfaW4pLCBsZTMyX3RvX2NwdShjcmNfb3duKSwNCj4gKwkJCXFw
LT5yeF9zdHJlYW0ucmRtYXBfb3ApOw0KPiANCj4gIAkJc2l3X2luaXRfdGVybWluYXRlKHFwLCBU
RVJNX0VSUk9SX0xBWUVSX0xMUCwNCj4gIAkJCQkgICBMTFBfRVRZUEVfTVBBLA0KPiAgCQkJCSAg
IExMUF9FQ09ERV9SRUNFSVZFRF9DUkMsIDApOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IGluZGV4IGEwMzQyNjRjNTY2OTgu
LmY5ZGI2OWE4MmNkZDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHgu
Yw0KPiBAQCAtMjQyLDExICsyNDIsMTEgQEAgc3RhdGljIGludCBzaXdfcXBfcHJlcGFyZV90eChz
dHJ1Y3Qgc2l3X2l3YXJwX3R4DQo+ICpjX3R4KQ0KPiAgCQkJZWxzZQ0KPiAgCQkJCWNfdHgtPnBr
dC5jX3RhZ2dlZC5kZHBfdG8gPQ0KPiAgCQkJCQljcHVfdG9fYmU2NCh3cWUtPnNxZS5yYWRkcik7
DQo+ICAJCX0NCj4gDQo+IC0JCSoodTMyICopY3JjID0gMDsNCj4gKwkJKihfX2xlMzIgKiljcmMg
PSAwOw0KPiAgCQkvKg0KPiAgCQkgKiBEbyBjb21wbGV0ZSBDUkMgaWYgZW5hYmxlZCBhbmQgc2hv
cnQgcGFja2V0DQo+ICAJCSAqLw0KPiAgCQlpZiAoY190eC0+bXBhX2NyY19oZCAmJg0KPiAgCQkg
ICAgY3J5cHRvX3NoYXNoX2RpZ2VzdChjX3R4LT5tcGFfY3JjX2hkLCAodTggKikmY190eC0+cGt0
LA0KPiAtLQ0KPiAyLjQ4LjENCg0KDQpSZXZpZXdlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRA
enVyaWNoLmlibS5jb20+DQoNCg==


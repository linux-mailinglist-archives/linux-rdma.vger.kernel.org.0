Return-Path: <linux-rdma+bounces-10164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC01AAFCCB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABA31BA3071
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DE2528F9;
	Thu,  8 May 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gVOnoECx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A3223DD8
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714190; cv=fail; b=DwkXnZVGC9sKiaX5RVZv+Gyb9X/CvEBDzrlH5uONdnu7d/qTWeDPgGEbveUwNFsWZCGM0duIjlUiYCstxqmub3qjXpt7iNk/VJvezcYmCsy+Dj4AJQlJ+MeaZiZ/HC3PXqd9UUrhVNPrZAqmiokGML+KVn3NSi+HVtXgzPCer+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714190; c=relaxed/simple;
	bh=MG2Js1WKQTBgzPm8UjCWfTiCsDZ9bTRftNXqUIrEmDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftqxm2VtI8/ggys/WsgkW6V5J1bHu4DrxZpro2HYSHpmTOXMJRMtQNJPSCkApN+HhHDcs6b8gnuzWYe7Xb9OEnl+wZT81oHfanEjDKYciuCrR9uSpwWCiJOyJzt+ZC5GC4xn0sIUOhkJDFwjZYco4Lj9N4SMLoqFhwtpL/B2gYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gVOnoECx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548A7G2m000411;
	Thu, 8 May 2025 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MG2Js1
	WKQTBgzPm8UjCWfTiCsDZ9bTRftNXqUIrEmDc=; b=gVOnoECxQ10bCr3fAXIeLJ
	HBZDmiKKKwXJIS7h19p7dn4sMftfxqmWCH4JoCZ/8KpAyvNokfmY3M6kbzMjjZ5N
	2qpJyHxRy6aGyGNYHumuDr25NNIoGx3vOnji6yG4YtlHfN3fFG4nP4lR6UmznGUA
	wkxdvNdpnYtuwQEIj2HvZ66G1SITKxzPaQ3SA8fcB6Uc6Kelm7jkEdG1JsatUlyI
	ywAtUpgHEmOva9UpHGyEM4CIsG9UmmH9q4ZVVJf8cCVx4kdJWrQUgwW+A45MDWot
	19Ec4HdvPf1XtzAKzI8sj28yFE7X+zwEngq23TtAXMlOV+wDxhF7m2bBNujFiAvw
	==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gf3kv53p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:23:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+DXXTOtywb45VByiiMSkzJ0rT75L5QkYFA72BI6Va/ozmr46lGyiKKZ2nU+42ETRY0Qo5TsCUpt49544CiVlpLnJeLwQ/vlx3ByGv8u4IGq99koYW+URw2B6SCN3QXH33EC2kL6RoF0atB6vai2QcO+hkWz1iQMr6Q9ooiURZuiNYBiO4a8ey5v9UWG8kuQvSNwsOcuqAPlPRNLy+Bdxl4g7lxd5BFz8IeWCRIwPy2O8t3Fyskm4b5qxVTWsWCILdNrOFRWQTVnAE3yt5S+upHHgOPCtuv5Tkfp8wJcvTi5TXPqUOzFI8kcK/ESVg/48VE8BALspBWFP+Opl12L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG2Js1WKQTBgzPm8UjCWfTiCsDZ9bTRftNXqUIrEmDc=;
 b=wcRR77UxastfycMjtBBvsVV/0iSPmgwsDAbKmFE8rUJmOu8tehWiWAEYLsodfMmi35LXlNK61gHlggGMRnz3svggHNwzFsouk+Xp1CIxDam3lTrd2pBqem6pt1nLsSlNVsnKeXnWOpqhvB3JCCBlYKAwovw0kLJvuCgyeyz5otDMF4vbteSE9oReBeosxuPrw0m6el18d3k9nI67o+h+rWmAjln1GYJhqr2qH6IQnU3GbIFFnheHSalUmOXyK8r6ZXpD2Icqsg7Udjos9nk8R9qaOuN8JZvkjPMCcKj+BkHGgzvj/zHvrRZIpjxQIgKC3oG9c+tMq+f7a5s5m+4YFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0SPRMB0005.namprd15.prod.outlook.com (2603:10b6:806:152::20)
 by SJ2PR15MB6424.namprd15.prod.outlook.com (2603:10b6:a03:572::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 14:22:53 +0000
Received: from SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd]) by SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd%5]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 14:22:53 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daniel Wagner
	<wagi@kernel.org>
Subject: RE: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAIAAeDMw
Date: Thu, 8 May 2025 14:22:53 +0000
Message-ID:
 <SA0SPRMB0005DE8DA6908A422928304E998BA@SA0SPRMB0005.namprd15.prod.outlook.com>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0SPRMB0005:EE_|SJ2PR15MB6424:EE_
x-ms-office365-filtering-correlation-id: 5003d479-1cc1-422d-af3b-08dd8e3bd247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnZacHVSOFp4Um41UlZoVTRkVHU1TTFNWkEveTdYUkF5TjhrVVBaV2hLSnpT?=
 =?utf-8?B?UGZCVVdLL0YzQ3BvRkE3TzlPdmJpWkxVelJDR1gralpvYWVLNFdXcVpZMFFF?=
 =?utf-8?B?c2tuSkNMeGwyTmdoR0w3QmRFMUdhME1weWl3WkJWUjFGRGhBVU5TQjVOVVVI?=
 =?utf-8?B?ZHpRRlovSmdWRGxOZk1ia2ZJakRObUdzQWwvYitvMW8rdlh3ZzA5NTJYVGtG?=
 =?utf-8?B?RDFkdFJVaXpQb1lHc2VHMUIxMk56Yml1RzhhcC8zUWtrWUorWjN4QlRHcEl1?=
 =?utf-8?B?WWh6SDA2UHZDNm1oeEFnKzN6TGQ3WC9paHNoYmhHTjNEZS9vVHZNN2F3bTh0?=
 =?utf-8?B?KzhWS2todmdVTnlNb1BqSWRXamdLTkZDTzg2OFVqd1pBajNwTk9yeGtqMitJ?=
 =?utf-8?B?aDRkZ1hwUml0NkJRV0h3RHBwNzdEY0xiZzErd1pOcGx6VGZaR0FXYXdNZUZF?=
 =?utf-8?B?YVFIakJCcFFpMHY4bSs0RXkyWnJITGxGRWEzM3Q5QUY4enl0SUI3aVR1QkZY?=
 =?utf-8?B?djBGWk1lRkZTZDJpUHZ0WGtSVllhOTlwaExOWGVCdXpBNStlUXNlUjV0Z1BJ?=
 =?utf-8?B?NVgwSVVKcHBDK2NlNGg1SjZ1WGU4YUFmRmJNZXNvSjJqdFpEeUIwVWVCbGRN?=
 =?utf-8?B?WmRZS3VpSWgrUk5uMFJOVEZpcDJxVjVpcTRzY1hxcmNVOURnd1ZDSXhBYjRn?=
 =?utf-8?B?bGFZL3praXVMVW1nNnJGWXFGbjQrb0Q0MS9YOTczSjAycG4zK2RDTUlyd3hT?=
 =?utf-8?B?enpYTlQ2TTREZGJYUEtTc2k5UnhwTDU4MHlmbjBSa2t4TXdLc1VhcTRFNjhI?=
 =?utf-8?B?YkZCWkNZdVBVdTF1VEsycVZHUnhwYWtwcktwaU95c3M5S1hxTjNYNjdPM3FT?=
 =?utf-8?B?MHliczVDald2ZWQ1K1BYajlGemFtUkJVOTVpSWE2TmdrUDV3S0tpTTRFbHpa?=
 =?utf-8?B?dlpCeEpoYXRBQy9XWTRHL2FOcFMybDVBVUo1d1AzalQzdXB3eWJTQXNqZ2tk?=
 =?utf-8?B?WFhXTURrSy9pT2x1SUw3Znk3ME5CbzVzMnVoVEVUdTI4T2FMMzgzMzE2UHNW?=
 =?utf-8?B?MncxMGwveVRiYzM2cmpTYW9DQ2pqZzlUU2hsM0JLWHkzUzc5ZHpYMmxhTzFB?=
 =?utf-8?B?RUxCaWFEMDdRQ1pLcXdvTGdNeDJSNG0xRzhBa2RmeUR5MDViTTBGTUdkS0po?=
 =?utf-8?B?b0Z3ZkVPY25aMXRITkQ4UTZ1ZXRXY0lrbm9hL20zYjFIWGJjOHFqcnd4dGJD?=
 =?utf-8?B?cTVHOEQwb3JJQS9NUXZsRFp3K3B3RkNLT2NtMkJabHp3TkJNSWRnUmVqZVVO?=
 =?utf-8?B?NGFRVGhCc3JrRkZvam5WOVRtZGtxWXZuQUhQU2c2KzRkb0tBQ3lrRnpvUzcx?=
 =?utf-8?B?clgzUDlIc3dlSTk3cWd6UGJBbmhyL2RTaEVneVhCdHdGZWpzK1BrU05TcnFK?=
 =?utf-8?B?NGt1VEtLV3E2d3drd1VrQ0hVM1h5c3ltdGg3d2VJanNEYUNySUYxVDhBcjJG?=
 =?utf-8?B?eGtPNElzT0x6Uy85MkpkcTlkS0JXNVgzM0ZDd1ptQmJrOTRmdjZyM0RqcHVP?=
 =?utf-8?B?V3lWaFoxdDlETGNiaktTcEhNTElDMXVRV1N3ZDNtRmZYZ2lrbU9IZWJYOTND?=
 =?utf-8?B?b3dwRXl3dXlqVTF2Q2RCU0J1SmN1SUl0S2l3ZkNtMTVsT0E1a0VGNFk2UnBh?=
 =?utf-8?B?aE1EWnJPQmJWRlc5Mmx5Ky83Y3VCY3dQeDBucDhzRGoxUUgzdjRaQk1jUnA1?=
 =?utf-8?B?cGM0c1pFRUh6cWVqNk1HUWtkRno2M3RxRHJuS21iby8rR1RrVFdEdGhmd2w3?=
 =?utf-8?B?aXpybkFOL1RsNU5sb0Y1bFl0bFloUGN0U2ljeTJqNFN2WTViUkhxdnZHNUtP?=
 =?utf-8?B?S2lXUkNGTEpBbWhZb0RNZXkrcWd5RkRxL2xLRm90eDVlbU5aMThyMWw1Y1Zu?=
 =?utf-8?B?VjhTMDlCRVFDcUc1YlVRVDZLNGhQRDFOVllHZEtqdDhDMWFNZS9IYW5MZmxy?=
 =?utf-8?B?TXZ2SzJOYXZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0SPRMB0005.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGtHaTVyQjdkK1dnOFl5dG9IL3Z0Ry9CVnBRa0RRQSs5L2t2WXdBQm1qcGRa?=
 =?utf-8?B?VlZveWVOUURXUGVYNEZUaThjZWN3d2tKNkxndWNaaERzVzUwMW1GMmJsVnc2?=
 =?utf-8?B?dmpsdGZxWDA1d1VxaWFXK3VKV3dUc1dnZWFoK2pMand3dWx5MEszeDY5Y1ox?=
 =?utf-8?B?YU5SRWR5dU5Db2JjZjdmUlc3U051UkdpOWZmY0JseWdmVFpIdmhtbXBlNFBV?=
 =?utf-8?B?d1I5VlF4RmpGd3FUTEdIKzB2eUhFMzVXSVhNTmJRa2VJVFdzVHdNQ29PTzZJ?=
 =?utf-8?B?Nlg2QWR4MnYwM0ZPakJyakFvT3pNTnNkYXppZ3BzSUc3SlRNK2pSRGl4WDcz?=
 =?utf-8?B?QW1wNUFuT0VCUUZtYnYrZ3J4eVcrY3FiTWtPRXZoQVYzaGlrZjA4dXJpUWhF?=
 =?utf-8?B?VEIrVXdCbHJpT2xxLzU2cHBlK3VJeGpacW8zVC9vUW1LZzFQY1V2NlgvN1Zl?=
 =?utf-8?B?N21SbjYyWWQxWS9DU1pXU25oNE5QNHFRSGJ1N2ZGVURyR0YzcDBDMzhabkMr?=
 =?utf-8?B?dHpGVzZ2NlJWT0FhOGNid1pCZ2ZYdnhHUE93S0c2R1l0dTNXK3RJMnJsTUdX?=
 =?utf-8?B?OXdmZDNBRjhLWEpUbGJmTk5WTFBrM0ZWclFDZGFWbHJ5aDg3S3hSK3JTaS9E?=
 =?utf-8?B?SGYzbjd5aHFGeTF3U2lUdW9mVFFrbzlDeUlVZkxnMUM3TWFlRndLSGsxUVA2?=
 =?utf-8?B?UmtsZTBYL3VQUWcrN0hQWjNLTEI1YldyalVGemZRVEJsT1NiVVIybDJhcFlC?=
 =?utf-8?B?SEtLYS9HM1pGWW9Ja0pFdHhhZUZqemVDc0FKUThEMTN5R2JjUkFiU00wWTly?=
 =?utf-8?B?RUxiQk1CSlFGOHFiQXl3QzJnSWdGcTJGL1BCSThCYmJjalpBNW5rYWlsdnFQ?=
 =?utf-8?B?NFFTZGJBS0xFNkFTM3J3NG40aGtvQUhjNDhnbkpCY3Q4ajZrVndXTXMyeXdD?=
 =?utf-8?B?TUVlbzZxSm1yeXFtaE9nZng4Vi9VaU1VNHo2d1ZLUk1ieTV0YWJwTTdFN0hw?=
 =?utf-8?B?Qi8velMyK0tQTUUxZEZ3TFdJRHB4TFNhUHQvTUs4Zzc0akpoZktzRTJRZS9y?=
 =?utf-8?B?RFFEc1d5ZDlINTlXd3FlMjNzOENxYnI1WFZrMEFjajB4TlRzVWxkNlJMcmhv?=
 =?utf-8?B?LzRleDRJQU1uK3dONlM4UXk1eW5EZEszeUhRMVloTHJOSTNzYk00V0NqT3lC?=
 =?utf-8?B?cEp1TGlSSlA1SkFiQ1MyZGVJU2ZmZ1dOQzBKSERsWmhEUGVyMmFLL0NKKy95?=
 =?utf-8?B?KzVQaEdHeGlHaHI4ZUpzQ2J1NVRuWTk2YTR4M01IRWt6R3FOaDNHanlRcWdi?=
 =?utf-8?B?eGFMdDhaakZNaGw1MkZUd0hwS2NjZlcrdFBQaUh6RlEyQ0orTHpON0hJRUNE?=
 =?utf-8?B?ZU1tS3ZjTUtqWlNuUEJoTlJWSkloVU1TeGZuSVEvQnV5NGlQcTQyRDRlNmRm?=
 =?utf-8?B?R1dVbGlOSmwxa1RJK3R3aDYyMGtxazRtWWU1Z3pjQmswQjI5Y3Q5c3V6SE8x?=
 =?utf-8?B?U1lRelJHZUpadjNzcXlqL3RGVVYvQk8yMmJwZUwxUk9xbzJVaVhMNm9kalRy?=
 =?utf-8?B?aE5PcVlXN1BEOUZMOXJmdzBsUmZBVThlRWFBdEhYVHNpZ1VWN3drNlkzS1Zu?=
 =?utf-8?B?RkR2V29TSnI2MTBTU0xnclBOVTVlQW9JY2RBTnZ4ejJ6UjIvTzBCVXBoMjJ6?=
 =?utf-8?B?SWIzRjFwZHdlSmZldytyaHNQQnNrNG9mRjhTNVQ3NmpZdjYxS3ZZdXhyQkI3?=
 =?utf-8?B?WEJXWTRMYllDSHpJcWVRbWtQVlU5SUt0NlB0MnpjTUQ2eHNCS296RG5VZjhU?=
 =?utf-8?B?NkgxTW5YbWNSYkkvN2F0U0NvMTkvMzlNbCtBZWNiOEJoUzFDZFdNSFQxbGg1?=
 =?utf-8?B?R0xzcHNjZkNpVjZMWUlIdEdUZUtyYUNSRmVhV2hWMExxb2N5cTNXdWV4OEJR?=
 =?utf-8?B?c2lsK0NJWUtOWnRmQjJEZ0owNzNQZWZsTERrNFRVQkdVdzNtYmdHUTJyYnBP?=
 =?utf-8?B?RTMvZ3dvZUNCSldobGV5TXVybC9CSHBlVVRHNHJ4OW5CUjFlK212czc4U3d5?=
 =?utf-8?B?YytVelF2YXIxMlRSNFRTTUorWVFEcGFlOUU0THpaZVVoZUlFVVR2WFRqc0Mr?=
 =?utf-8?B?UjRyWW1uamt6TmlrRGdUWHVmUm1IUExLNGpLOUk2d2M1dE1mcTdHbHUyWjZo?=
 =?utf-8?Q?78v7yFuqJB9NtZMHUVk0G+A=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA0SPRMB0005.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003d479-1cc1-422d-af3b-08dd8e3bd247
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:22:53.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxfGhorb5C4PBwCwH6RxhGXf5gSNjq9A6UzDiC+RPd2pnpHQJRzD4+vmDutAdFGDfkFy46zMzNrZD7xG3aN7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6424
X-Proofpoint-ORIG-GUID: KeH_lqKceJQgMNAG8BCXlpkscX1qekrJ
X-Proofpoint-GUID: KeH_lqKceJQgMNAG8BCXlpkscX1qekrJ
X-Authority-Analysis: v=2.4 cv=S/rZwJsP c=1 sm=1 tr=0 ts=681cbe45 cx=c_pps a=NZTPE88KBhpz0z3fOSYQ1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=PhP7vW_cbrlxupudLLsA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=1CNFftbPRP8L7MoqJWF3:22 a=t8gNky6DTScCJD9b48VS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMCBTYWx0ZWRfXxDdwzgjvLwfG bgiPdwpMMxXHM7muUpDmnR+uDDghiPuvW70qZVgLLAkmkNKgqeidhawmNLjrFjvGzfNHTxefFRl VFK9xRuMNjQ8+go3P43n231MFhnw+TpqbkX273fF1JoCIqObXAenNXMhPDr5ADR8B9hU509x3sx
 Fv/u2PwHHOxUH+BSMLpmYZPb0L7cVgy3c8kQvX1gK2zDk/Cdfe6pApySJwTiXe0sI5vizMaAQh3 B3/2zaJYgQytvDlIG4imjVVBAJwq0xiG4FjhO/Z9QKQ3AEeRE3Mdtq5BoQRV+itRfsBmLqMizzO 3jk4pWVYAC9FBtKPJmXAwUWaXf1WgL7RswXgdqvD6l191XL6Mv2PoXybXRNV/HaZSGBUUIuRNVn
 iFmoqN4E4PxP4cTjGnxyQu/3wsd6emZ8LXAn+ABBDBi8ZZGBdbTON9abVFtbFIrAixbeqNJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080120

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hpbmljaGlybyBLYXdh
c2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5
IDgsIDIwMjUgOTowMyBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5j
b20+DQo+IENjOiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnOyBEYW5pZWwNCj4gV2FnbmVyIDx3YWdpQGtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFtFWFRFUk5BTF0gUmU6IFtidWcgcmVwb3J0XSBibGt0ZXN0cyBudm1lLzA2MSBoYW5nIHdp
dGggcmRtYQ0KPiB0cmFuc3BvcnQgYW5kIHNpdyBkcml2ZXINCj4gDQo+IE9uIEFwciAxNiwgMjAy
NSAvIDEyOjQyLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gPiBPbiBBcHIgMTUsIDIw
MjUgLyAxNToxOCwgQmVybmFyZCBNZXR6bGVyIHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gQXQgZmly
c3QgZ2xhbmNlLCB0byBtZSBpdCBsb29rcyBsaWtlIGEgcHJvYmxlbSBpbiB0aGUgaXdjbSBjb2Rl
LA0KPiA+ID4gd2hlcmUgYSBjbWlkJ3Mgd29yayBxdWV1ZSBoYW5kbGluZyBtaWdodCBiZSBicm9r
ZW4uDQo+IA0KDQpTaGluaWNoaXJvLCBtYW55IHRoYW5rcyBmb3IgdGFraW5nIGNhcmUgb2YgdGhp
cy4NCg0KDQo+IEkgYWdyZWUuIFRoZSBCVUcgc2xhYi11c2UtYWZ0ZXItZnJlZSBoYXBwZW5lZCBm
b3IgYSB3b3JrIG9iamVjdC4gVGhlIGNhbGwNCj4gdHJhY2UgaW5kaWNhdGVzIHRoYXQgaGFwcGVu
ZWQgZm9yIHRoZSB3b3JrIGhhbmRsZWQgYnkgaXdfY21fd3EsIG5vdA0KPiBzaXdfY21fd3EuDQo+
IA0KPiBJIHRvb2sgYSBjbG9zZSBsb29rcywgYW5kIEkgdGhpbmsgdGhlIHdvcmsgb2JqZWN0cyBh
bGxvY2F0ZWQgZm9yIGVhY2ggY21faWQNCj4gaXMgZnJlZWQgdG9vIGVhcmx5LiBUaGUgd29yayBv
YmplY3RzIGFyZSBmcmVlZCBpbiBkZWFsbG9jX3dvcmtfZW50cmllcygpDQo+IHdoZW4NCj4gYWxs
IHJlZmVyZW5jZXMgdG8gdGhlIGNtX2lkIGFyZSByZW1vdmVkLiBJSVVDLCB3aGVuIHRoZSBsYXN0
IHJlZmVyZW5jZSB0bw0KPiB0aGUNCj4gY21faWQgaXMgcmVtb3ZlZCBpbiB0aGUgd29yaywgdGhl
IHdvcmsgb2JqZWN0IGZvciB0aGUgd29yayBpdHNlbGYgZ2V0cw0KPiByZW1vdmVkLg0KPiBIZW5j
ZSB0aGUgdXNlLWFmdGVyLWZyZWUuDQo+IA0KPiBCYXNlZCBvbiB0aGlzIGd1ZXNzLCBJIGNyZWF0
ZWQgYSBmaXggdHJpYWwgcGF0Y2ggYmVsb3cuIEl0IGRlbGF5cyB0aGUNCj4gcmVmZXJlbmNlDQo+
IHJlbW92YWwgaW4gdGhlIGNtX2lkIGRlc3Ryb3kgY29udGV4dCwgdG8gZW5zdXJlIHRoYXQgdGhl
IHJlZmVyZW5jZSBjb3VudA0KPiBiZWNvbWVzDQo+IHplb3Igbm90IGluIHRoZSB3b3JrIGNvbnRl
eHRzIGJ1dCBpbiB0aGUgY21faWQgZGVzdHJveSBjb250ZXh0LiBJdCBtb3Zlcw0KPiBpd2NtX2Rl
cmVmX2lkKCkgY2FsbCBmcm9tIGRlc3Ryb3lfY21faWQoKSB0byBpdHMgY2FsbGVycy4gQWxzbyBj
YWxsDQo+IGl3Y21fZGVyZWZfaWQoKSBhZnRlciBmbHVzaGluZyB0aGUgcGVuZGluZyB3b3Jrcy4g
V2l0aCB0aGlzIHBhdGNoLCBJDQo+IG9ic2VydmVkDQo+IHVzZS1hZnRlci1mcmVlIGdvZXMgYXdh
eS4gQ29tbWVudHMgb24gdGhlIGZpeCB0cmlhbCBwYXRjaCB3aWxsIGJlIHdlbGNvbWVkLg0KPiAN
Cg0KSSBhZ3JlZSB3aXRoIHRoZSBvdXRjb21lIG9mIHlvdXIgaW52ZXN0aWdhdGlvbi4gVGhpcyBw
YXRjaCBsb29rcw0KZ29vZCB0byBtZS4NCg0KPiBPbmUgbGVmdCBxdWVzdGlvbiBpcyB3aHkgdGhl
IGZhaWx1cmUgd2FzIG5vdCBvYnNlcnZlZCB3aXRoIHJ4ZSBkcml2ZXIsIGJ1dA0KPiB3aXRoDQo+
IHNpdyBkcml2ZXIuIE15IG1lcmUgZ3Vlc3MgaXMgdGhhdCBpcyBiZWNhdXNlIHNpdyBkcml2ZXIg
Y2FsbHMgaWQtPmFkZF9yZWYoKQ0KPiBhbmQNCj4gY21faWQtPnJlbV9yZWYoKS4NCj4gDQoNClll
cywgc2l3IGNvbnNpc3RlbnRseSBidW1wcyB1cCB0aGUgcmVmZXJlbmNlIGNvdW50ZXIgb2YgdGhl
IGNtX2lkIGl0IGdldHMNCmluIHRoZSBsaXN0ZW4oKS9hY2NlcHQoKS9jb25uZWN0IENNIGRvd25j
YWxscywgc2luY2UgaXQgY3JlYXRlcyBhIGxvY2FsDQpyZWZlcmVuY2UgdG8gaXQgZnJvbSBpdHMg
Y29ubmVjdGlvbiBlbmRwb2ludC4gSXQgZ2V0cyBvbmx5IGRlY3JlbWVudGVkIHdoZW4NCnRoaXMg
cmVmZXJlbmNlIGdvZXMgYXdheS4NCg0KQmVybmFyZC4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9jb3JlL2l3Y20uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L2l3Y20uYw0KPiBpbmRleCBmNDQ4NmNiZDhmNDUuLjYwMGNmOGVhNmEzOSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdjbS5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2l3Y20uYw0KPiBAQCAtMzY4LDEyICszNjgsOSBAQCBFWFBPUlRfU1lNQk9MKGl3
X2NtX2Rpc2Nvbm5lY3QpOw0KPiAgLyoNCj4gICAqIENNX0lEIDwtLSBERVNUUk9ZSU5HDQo+ICAg
Kg0KPiAtICogQ2xlYW4gdXAgYWxsIHJlc291cmNlcyBhc3NvY2lhdGVkIHdpdGggdGhlIGNvbm5l
Y3Rpb24gYW5kIHJlbGVhc2UNCj4gLSAqIHRoZSBpbml0aWFsIHJlZmVyZW5jZSB0YWtlbiBieSBp
d19jcmVhdGVfY21faWQuDQo+IC0gKg0KPiAtICogUmV0dXJucyB0cnVlIGlmIGFuZCBvbmx5IGlm
IHRoZSBsYXN0IGNtX2lkX3ByaXYgcmVmZXJlbmNlIGhhcyBiZWVuDQo+IGRyb3BwZWQuDQo+ICsg
KiBDbGVhbiB1cCBhbGwgcmVzb3VyY2VzIGFzc29jaWF0ZWQgd2l0aCB0aGUgY29ubmVjdGlvbi4N
Cj4gICAqLw0KPiAtc3RhdGljIGJvb2wgZGVzdHJveV9jbV9pZChzdHJ1Y3QgaXdfY21faWQgKmNt
X2lkKQ0KPiArc3RhdGljIHZvaWQgZGVzdHJveV9jbV9pZChzdHJ1Y3QgaXdfY21faWQgKmNtX2lk
KQ0KPiAgew0KPiAgCXN0cnVjdCBpd2NtX2lkX3ByaXZhdGUgKmNtX2lkX3ByaXY7DQo+ICAJc3Ry
dWN0IGliX3FwICpxcDsNCj4gQEAgLTQ0MiwyMCArNDM5LDIyIEBAIHN0YXRpYyBib29sIGRlc3Ry
b3lfY21faWQoc3RydWN0IGl3X2NtX2lkICpjbV9pZCkNCj4gIAkJaXdwbV9yZW1vdmVfbWFwaW5m
bygmY21faWQtPmxvY2FsX2FkZHIsICZjbV9pZC0+bV9sb2NhbF9hZGRyKTsNCj4gIAkJaXdwbV9y
ZW1vdmVfbWFwcGluZygmY21faWQtPmxvY2FsX2FkZHIsIFJETUFfTkxfSVdDTSk7DQo+ICAJfQ0K
PiAtDQo+IC0JcmV0dXJuIGl3Y21fZGVyZWZfaWQoY21faWRfcHJpdik7DQo+ICB9DQo+IA0KPiAg
LyoNCj4gICAqIFRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgYnkgdGhlIGFwcGxpY2F0aW9u
IHRocmVhZCBhbmQgY2Fubm90DQo+ICAgKiBiZSBjYWxsZWQgYnkgdGhlIGV2ZW50IHRocmVhZC4g
VGhlIGZ1bmN0aW9uIHdpbGwgd2FpdCBmb3IgYWxsDQo+IC0gKiByZWZlcmVuY2VzIHRvIGJlIHJl
bGVhc2VkIG9uIHRoZSBjbV9pZCBhbmQgdGhlbiBrZnJlZSB0aGUgY21faWQNCj4gLSAqIG9iamVj
dC4NCj4gKyAqIHJlZmVyZW5jZXMgdG8gYmUgcmVsZWFzZWQgb24gdGhlIGNtX2lkIGFuZCB0aGVu
IHJlbGVhc2UgdGhlIGluaXRpYWwNCj4gKyAqIHJlZmVyZW5jZSB0YWtlbiBieSBpd19jcmVhdGVf
Y21faWQuDQo+ICAgKi8NCj4gIHZvaWQgaXdfZGVzdHJveV9jbV9pZChzdHJ1Y3QgaXdfY21faWQg
KmNtX2lkKQ0KPiAgew0KPiAtCWlmICghZGVzdHJveV9jbV9pZChjbV9pZCkpDQo+IC0JCWZsdXNo
X3dvcmtxdWV1ZShpd2NtX3dxKTsNCj4gKwlzdHJ1Y3QgaXdjbV9pZF9wcml2YXRlICpjbV9pZF9w
cml2Ow0KPiArDQo+ICsJY21faWRfcHJpdiA9IGNvbnRhaW5lcl9vZihjbV9pZCwgc3RydWN0IGl3
Y21faWRfcHJpdmF0ZSwgaWQpOw0KPiArCWRlc3Ryb3lfY21faWQoY21faWQpOw0KPiArCWZsdXNo
X3dvcmtxdWV1ZShpd2NtX3dxKTsNCj4gKwlpd2NtX2RlcmVmX2lkKGNtX2lkX3ByaXYpOw0KPiAg
fQ0KPiAgRVhQT1JUX1NZTUJPTChpd19kZXN0cm95X2NtX2lkKTsNCj4gDQo+IEBAIC0xMDM1LDgg
KzEwMzQsMTAgQEAgc3RhdGljIHZvaWQgY21fd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVj
dA0KPiAqX3dvcmspDQo+IA0KPiAgCQlpZiAoIXRlc3RfYml0KElXQ01fRl9EUk9QX0VWRU5UUywg
JmNtX2lkX3ByaXYtPmZsYWdzKSkgew0KPiAgCQkJcmV0ID0gcHJvY2Vzc19ldmVudChjbV9pZF9w
cml2LCAmbGV2ZW50KTsNCj4gLQkJCWlmIChyZXQpDQo+IC0JCQkJV0FSTl9PTl9PTkNFKGRlc3Ry
b3lfY21faWQoJmNtX2lkX3ByaXYtPmlkKSk7DQo+ICsJCQlpZiAocmV0KSB7DQo+ICsJCQkJZGVz
dHJveV9jbV9pZCgmY21faWRfcHJpdi0+aWQpOw0KPiArCQkJCVdBUk5fT05fT05DRShpd2NtX2Rl
cmVmX2lkKGNtX2lkX3ByaXYpKTsNCj4gKwkJCX0NCj4gIAkJfSBlbHNlDQo+ICAJCQlwcl9kZWJ1
ZygiZHJvcHBpbmcgZXZlbnQgJWRcbiIsIGxldmVudC5ldmVudCk7DQo+ICAJCWlmIChpd2NtX2Rl
cmVmX2lkKGNtX2lkX3ByaXYpKQ0K


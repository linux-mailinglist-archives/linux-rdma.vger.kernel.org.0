Return-Path: <linux-rdma+bounces-977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895B84DFD0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7EC285E76
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9A73162;
	Thu,  8 Feb 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GWOlnlC3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1078B59
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391981; cv=fail; b=YooQjSnNsLMV+rkR5QJN8Q2+jsrgyVAKEZ3LOuAQrncXoc3+QSNeh0irQzMUsSlB8ImSPFedvExwhiQbE/wA5nLtTzOxa/RJ5UNbO19w8t5oNIdK2ANDgH10cLGGnsNNTavWPXinieX7DMTAvFplLvn25P+O2lME61OVEhECgDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391981; c=relaxed/simple;
	bh=tJ2X8bualLkckV+2m3i6b9IhgAbbyZZQID0PFyxZeIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A8nwb/84Xkmsb8LU8+c9jFr+0VAL5T5JrTSC/HBLfdUMaMDsaoIf80MOyC1tAhVN8d3w8IJae+OZmXVgb6fdbqYNiKW3QTgsZr2Z/wguqZQk3YPUp2WGjnXS/j/90DN+Sn8UEvBoXclLTA3xpj4j2L8W7yqL8PbyHA5IP6Q03pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GWOlnlC3; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418ATv9k018492;
	Thu, 8 Feb 2024 11:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tJ2X8bualLkckV+2m3i6b9IhgAbbyZZQID0PFyxZeIs=;
 b=GWOlnlC3YHhfsQpjJCgCWSxNWK/dD8tnWI/bCeUHgO1BZeX038qQycVUMrwEcXQph8su
 t8gLiHLzGJXhPc73Qm3EpK3A1MEbXuHms46oYCdOcHZkvahRGyS6wYzn3kxKFuVvTtEY
 uR0HcP0XiFWhGFGKPS+Ip22Iec/rSYmb88FyXy6kKgGHGJ3WC31um3k76f35Ys2cC1gv
 3xt8tfTMiSTGeatlQuyNK2IdIMjU1lH8UQZS/R0p9VZ+95JxKdbTUcPGxUa+74epEttW
 a16h56TaFGv65E/Qtaq+FY1/W1QPOYCYxdr+AaKboXMiWTqL38K9R56oNTAoOomLHLSn Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4tncp4u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 11:32:40 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4189OdM1013262;
	Thu, 8 Feb 2024 11:32:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4tncp4t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 11:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcmWnibzEYGYZso9oz39qO/PGC3IjNryP4/VI7jnGZrjcWlkUnjQTqELgM8yxIv639hLVUbSGDugkPAjwdK7i1w9YK5nrFGWTz405UaVGPJvkN9IiwcZUyeKKaFMgBGH96yYOdM9lL5ATLvIBnV3ctGzNo7AiCO2j+OuAyw0TTSaWeQliT74YxdZA94KMVp/j1ux/cOfVNbUE0YJZOeaEYRMrCX1H718rEvPRzgSistohCulGBS8Y5RK/JEHXq3WZMxPRRZ0eeH0oqhM1rhibENSWvmq8YDDsndLZh/z5C7CqxBWGpsW8LDVtKyYNSCr0Np60RJYIdg1Mn3CwLsM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ2X8bualLkckV+2m3i6b9IhgAbbyZZQID0PFyxZeIs=;
 b=bpLg5/lIsXGURNC1tU3U7/4b274++A8MiCWYcLobWYm34ThGn8GnIYRYGZFfdDdOY8PmZh0J/aDl5tzLUJzKJVKlRxOPhbLzATiBnR9MZ3uo9C+lkJh3ZxlaZkdxM0mIBNQ05YWXKTmu2sjYhZcSCyvJOH9P1N8OxpKtsD1B4Z3C9vm7LIvZfyMMlvWIdmGalhpUq1muIsGmhm+KZaOEQqZwJCkzbCRYkbUUBF2rg/onrc7suTjC3h8SijEcguHS9oqURU+Vg1qQXcyUdI0iULsJ/D1C5r9KOYftOnownu3rBIKpPSKcUmWfaS7CAdA8Nv780EKSP0YoZgHY0Q/WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13)
 by SJ0PR15MB4504.namprd15.prod.outlook.com (2603:10b6:a03:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 11:32:37 +0000
Received: from BYAPR15MB3208.namprd15.prod.outlook.com
 ([fe80::73af:2b3a:6743:198a]) by BYAPR15MB3208.namprd15.prod.outlook.com
 ([fe80::73af:2b3a:6743:198a%5]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 11:32:37 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: RE: Re: Re: [PATCH] RDMA/siw: Trim size of page array to max size
 needed
Thread-Topic: Re: Re: [PATCH] RDMA/siw: Trim size of page array to max size
 needed
Thread-Index: AQHaWoKE9qjH3H/VqESY1dC4FLO+rQ==
Date: Thu, 8 Feb 2024 11:32:37 +0000
Message-ID: 
 <BYAPR15MB320873D5B2D4CD9A3C38A3FF99442@BYAPR15MB3208.namprd15.prod.outlook.com>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
 <BY5PR15MB36028A78D66BBEE55A54C67E997A2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <20240126110534.GE9841@unreal>
In-Reply-To: <20240126110534.GE9841@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB3208:EE_|SJ0PR15MB4504:EE_
x-ms-office365-filtering-correlation-id: f51b787c-4dc1-422d-6a01-08dc2899a6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HjXTXA0Aqm7jyxRi4syofgpM0Gvc3UfAhfkQ7jOI+0DG9Hfj9qab6gJ21RyqRSgsJ3W0NiYMH+I9KGIOqoTTl4RTEwJ5fcJpdieLpqI9ep+wAMfk94QZOh2n9Ph1OHx7pgAsqZfrzNdmIl6mOnh3yjrmLOXQfe8Ti8n6oImRZtMYvXsSds4u7BoyXCkrcjMYWTdt/EKzcudgV/+sAKcFraqEeCBFJVsXYlAcsGCTbsZhbnZW48KTiuvpXlSW3Qdhe9S4Wd0ajnlx1wz4cDnjeKuWDWx2pc1tc/eZjhMsA0EwQOeYsd5rnaG6+6OZ1JnGDWYt4KbuOdJINyXrMFOV1WwBThDU/wEy0gRQLLGRChdaB3DI/wegXBkG/ZptA9XXsvVfhLL2dNmMSykq7moerjJhr62sMCWMttPBnQPxKQYkvHieJ2GTHI7vFuc7sWyIOEYRhMeq+554E/GVoEAWJB+JSJPsSu6F5y7oUT8zhmKBJKG2JVVZl6J+7khQei/ijMp5ILv3bNDBknUXDtPs0hPDfkgmAZC9wjDHgw1R6A5sEnXC3TxyRM61o9NkbQtsn9hMDTf1pT1ScUsNBBTHJAmxX6CDOFKItAX1t0NurO55P1as/koB3IlCMMlg09c9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB3208.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(8936002)(8676002)(52536014)(41300700001)(2906002)(55016003)(5660300002)(83380400001)(86362001)(38070700009)(76116006)(66446008)(66556008)(66476007)(66946007)(64756008)(7696005)(71200400001)(53546011)(6506007)(122000001)(478600001)(38100700002)(54906003)(316002)(6916009)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bDl4UlYzY2l0VHBhZlBUOG9nSVhqd05WeDFaMXhpUCs1b0xxL2c2eXhqQ3l3?=
 =?utf-8?B?akJZMFNnVGpuWjd4dTB2L0l1clYwVVlaT3ZMU0d5Znk0c0NtL0gxbDU2ZHRv?=
 =?utf-8?B?aWlkVDNuUmJONU0zY0xJcndTeXVPN0NGQzNXUnA4b2drb1ZJcUdHMm5vTDNN?=
 =?utf-8?B?bDRuVTNVVDBhcmVHZGQ0aSswNklwb2UwS0k0VkNnOFpUdXdrNUpKTmY4U1BP?=
 =?utf-8?B?OVZEemVHcVV4Wld1WEtTT3pNbnF1Z2RFU0ltSDY2TDFpU29ENnlPQmpHSHFV?=
 =?utf-8?B?czJXY1I5VnlFd3RhRjh5YXM4NGtYRDAzY3hTZ0JIdG5iRlpqaEcwenpXVmw1?=
 =?utf-8?B?ak9QUTJ2Q2xBMmkxMWJRV2dteW1aem1pYUV6cGc5WWlFS3AzK0EwMUt3Z0FD?=
 =?utf-8?B?TmRyOUZGc2lkM0pIbEgxOVdkZkRHbUdtTll2WUJ6QWw1MjVqdWFKZ1lKaitl?=
 =?utf-8?B?M1N4Zmw3cU1XbVVqZXdGOXkrdllQYVZ1UEcwS3FBNyt6aXhqVzJEd2o1SzBm?=
 =?utf-8?B?ZXNYVXhpbXllRFRCdVUwcTNtREV6d01BTEp4Zjd1bTc4R21pd2hFaml2aFph?=
 =?utf-8?B?QVZBTk95QmZRUm5hNHA2VG5lbi9lV1U4T01hcS9zWllkZ3NuZEFYRTJDenR4?=
 =?utf-8?B?WnlMdFAwd2ZQS3RkR2QxOGdOQmx4dmYrMWFCbHRnbC9yMWFiekl4ZW1xeS94?=
 =?utf-8?B?d3V4eG5CQjMyQ2RKNFUzQTVvM1l0TTF6eFUrTmZiS1F6WnNGTmhMRnN6REtZ?=
 =?utf-8?B?eVFnYmNVVEFGdzFQYXRPOXg0VStCOXl5a1djMlZyM0FsMHJLLzNZcHp4U1lQ?=
 =?utf-8?B?TnZnSS9uaW1HUjU2WDFzK3ozdVljbFczY0NUOXVGem5BWm5HazBqZWJwS0Fa?=
 =?utf-8?B?cFlON0NtRDFuK0RxTVlxM2ZveUpFa1BXWWdMS0lGWjBEcE90RG9waWVwSDlP?=
 =?utf-8?B?dlUzMzJLeDVhU05HRDhoNWVQOFYwVkZlZEt0NDMzZzJSbDQ3UzBVc0JYV2hz?=
 =?utf-8?B?REFXK3QrVm9Td0NXc3Jndy9pYVRsK0dyNUJJTnFKMnRhRkN3MDk0amxLaFR0?=
 =?utf-8?B?ZE5FMjJ3Sk8rNjl4bU82Z1N2eHZRM0FwY2toTlQwbis3ZzVYWStjUjVvd3F6?=
 =?utf-8?B?eU1NaGNIdVk5YVBha1VmQWZjZmJmK3dydUxTWndpRmhTTDRXQStWNDdNYi9D?=
 =?utf-8?B?bjRiT25Pb0Jpc29oWmYrL0x4T1IxUkNWb1I2ZTdLbWQ3T21OY3h6L0ttamlJ?=
 =?utf-8?B?VXl3S0RrY2pDWGhOdHBWZ0lsNGtMVS9BZitOOEJmM2ZveGcwSU5RQSt2cWJO?=
 =?utf-8?B?UmNaRU9ZNVltdHNUNXlsTVBzQ01tdGlSeVJ6OXF6VGQvcFNjUytTMmR3TmNE?=
 =?utf-8?B?dE5mVjcwSTBPWmxXOHdZRnY5SzhJNGRsc0JhbmdiUU5md0dJSHR1c0g1MWJK?=
 =?utf-8?B?YnRlbXR0L3hvRDFNcHp2cUxWK3VUdkxIdmtjR292bVloVC8xaUJEK2ZtRU02?=
 =?utf-8?B?dVlzOExtOU04ejBLazc1T3VjOUV6eVFFaUNUZm9xdlJwRCtob3ltWE9XdWpw?=
 =?utf-8?B?S3EwNTh2WXEvQlowTWFZajREclY0T2RNa1dOeU9QRXIwMHAzR1RKNnBpSFVk?=
 =?utf-8?B?dVIyRy9sUFRNdjhjVU1vYVBzS3hyTTJmOEdaSVI0TCtodDFETzh3d29SVHAy?=
 =?utf-8?B?N3RadHd2Lzl6OFBzWlVVQ2NNMnFubDVuTmVCRXc4VURTSmFtM3VEUWdGT0pG?=
 =?utf-8?B?RWpQdnVaYWFZZ01GZHBIRWhxWk5CSHhKWnFhRXprR1owN2ZHeWlBcVNLWUZS?=
 =?utf-8?B?YjNIMENiUUpEVXBEU2h5UUZHYUNWekFWOHdkOU5wVEkzOE1GQmM4eGZvYUV0?=
 =?utf-8?B?WEZ5bHR3cEdNUk9KS3hKeEJsdkJ0NktkQy85bmV0SXBwZkRCUWVwbTZFbGdF?=
 =?utf-8?B?TGpTalJtT0xCaWl2Tis0UXpXbUIzZ05YbzBkb3drUENSbEVRVEpRdkhYL2Y5?=
 =?utf-8?B?NlZxUzV4R0ZWbGY2M2l4Z1Q3M1U0ek16TFBZQThkVVBOMWpoNWhOM1hyaXJ6?=
 =?utf-8?B?L28raWFlTW1aRzBZVnF1TlpRR3J4UjZob0o4VEo0V0pRUDNvMkw3QmNoaDVp?=
 =?utf-8?B?czBSN3J4L1hqYlRCYVNReUJubGRuLythWC9DSDdkRk8yc0pweUFjSDhsMUFz?=
 =?utf-8?Q?ZlA8GxWHrfznQO2eSLXPv+E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB3208.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51b787c-4dc1-422d-6a01-08dc2899a6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 11:32:37.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cXdLiUMB13b+a/iaov5WlqJGw2aqR84qvueGSOl86ufsqdj1qpnVNfNd74gMXugxCScmSAJY3jNy1AYm2SPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4504
X-Proofpoint-GUID: l1BOl39sh81Geq1aCOlPtKoiy37_vzqg
X-Proofpoint-ORIG-GUID: ifXRQEutBNPDbpDdgzZnXzszteyCcECb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_03,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402080060

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyNiwgMjAyNCAxMjow
NiBQTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBH
dW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj47IGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnOw0KPiBqZ2dAemllcGUuY2E7IGlvbnV0X24yMDAxQHlhaG9vLmNvbQ0KPiBTdWJq
ZWN0OiBbRVhURVJOQUxdIFJlOiBSZTogW1BBVENIXSBSRE1BL3NpdzogVHJpbSBzaXplIG9mIHBh
Z2UgYXJyYXkgdG8NCj4gbWF4IHNpemUgbmVlZGVkDQo+IA0KPiBPbiBUaHUsIEphbiAyNSwgMjAy
NCBhdCAwNToyNzo1MlBNICswMDAwLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4NCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEd1b3FpbmcgSmlh
bmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEphbnVh
cnkgMjUsIDIwMjQgMToxNSBBTQ0KPiA+ID4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmlj
aC5pYm0uY29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBqZ2dAemll
cGUuY2E7IGxlb25Aa2VybmVsLm9yZzsgaW9udXRfbjIwMDFAeWFob28uY29tDQo+ID4gPiBTdWJq
ZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIFJETUEvc2l3OiBUcmltIHNpemUgb2YgcGFnZSBh
cnJheSB0bw0KPiBtYXgNCj4gPiA+IHNpemUgbmVlZGVkDQo+ID4gPg0KPiA+ID4gSGkgQmVybmFy
ZCwNCj4gPiA+DQo+ID4gPiBPbiAxLzI1LzI0IDAzOjU5LCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6
DQo+ID4gPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPj4gRnJvbTogR3Vv
cWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+ID4gPiA+PiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDIzLCAyMDI0IDM6NDMgQU0NCj4gPiA+ID4+IFRvOiBCZXJuYXJkIE1ldHps
ZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiA+PiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGlvbnV0X24yMDAxQHlhaG9v
LmNvbQ0KPiA+ID4gPj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3Npdzog
VHJpbSBzaXplIG9mIHBhZ2UgYXJyYXkgdG8NCj4gPiA+IG1heA0KPiA+ID4gPj4gc2l6ZSBuZWVk
ZWQNCj4gPiA+ID4+DQo+ID4gPiA+PiBIaSBCZXJuYXJkLA0KPiA+ID4gPj4NCj4gPiA+ID4+IE9u
IDEvMTkvMjQgMjE6MDUsIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiA+ID4+PiBzaXcgdHJp
ZXMgc2VuZGluZyBhbGwgcGFydHMgb2YgYW4gaVdhcnAgd2lyZSBmcmFtZSBpbiBvbmUgc29ja2V0
DQo+ID4gPiA+Pj4gc2VuZCBvcGVyYXRpb24uIElmIHVzZXIgZGF0YSBjYW4gYmUgc2VuZCB3aXRo
b3V0IGNvcHksIHVzZXIgZGF0YQ0KPiA+ID4gPj4+IHBhZ2VzIGZvciBvbmUgd2lyZSBmcmFtZSBh
cmUgcmVmZXJlbmNlZCBpbiBhbiBmaXhlZCBzaXplIHBhZ2UNCj4gYXJyYXkuDQo+ID4gPiA+Pj4g
VGhlIHNpemUgb2YgdGhpcyBhcnJheSBjYW4gYmUgbWFkZSAyIGVsZW1lbnRzIHNtYWxsZXIsIHNp
bmNlIGl0DQo+ID4gPiA+Pj4gZG9lcyBub3QgcmVmZXJlbmNlIGlXYXJwIGhlYWRlciBhbmQgdHJh
aWxlciBjcmMuIFRyaW1taW5nDQo+ID4gPiA+Pj4gdGhlIHBhZ2UgYXJyYXkgcmVkdWNlcyB0aGUg
YWZmZWN0ZWQgc2l3X3R4X2hkdCgpIGZ1bmN0aW9ucyBmcmFtZQ0KPiA+ID4gPj4+IHNpemUsIHN0
YXlpbmcgYmVsb3cgMTAyNCBieXRlcy4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZw0KPiA+ID4g
Pj4+IGNvbXBpbGUtdGltZSB3YXJuaW5nOg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24gJ3Npd190eF9oZHQn
Og0KPiA+ID4gPj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6Njc3
OjE6IHdhcm5pbmc6IHRoZSBmcmFtZQ0KPiA+ID4gPj4+ICAgIHNpemUgb2YgMTA0MCBieXRlcyBp
cyBsYXJnZXIgdGhhbiAxMDI0IGJ5dGVzIFstV2ZyYW1lLWxhcmdlci0NCj4gPiA+IHRoYW49XQ0K
PiA+ID4gPj4gSSBzYXcgc2ltaWxhciB3YXJuaW5nIGluIG15IHVidW50dSAyMi4wNCBWTSB3aGlj
aCBoYXMgYmVsb3cgZ2NjLg0KPiA+ID4gPj4NCj4gPiA+ID4+IHJvb3RAYnVrOi9ob21lL2dqaWFu
Zy9saW51eC1taXJyb3IjIG1ha2UNCj4gTT1kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3Lw0KPiA+
ID4gPj4gLWoxNiBXPTENCj4gPiA+ID4+ICAgwqAgQ0MgW01dwqAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHgubw0KPiA+ID4gPj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYzogSW4gZnVuY3Rpb24g4oCYc2l3X3R4X2hkdOKAmToNCj4gPiA+ID4+IGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6NjY1OjE6IHdhcm5pbmc6IHRoZSBmcmFt
ZSBzaXplDQo+ID4gPiBvZg0KPiA+ID4gPj4gMTQ0MCBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0
IGJ5dGVzIFstV2ZyYW1lLWxhcmdlci10aGFuPV0NCj4gPiA+ID4+ICAgwqAgNjY1IHwgfQ0KPiA+
ID4gPj4gICDCoMKgwqDCoMKgIHwgXg0KPiA+ID4gPj4NCj4gPiA+ID4gV2hldy4uIHRoYXQgaXMg
cXVpdGUgc3Vic3RhbnRpYWxseSBvZmYgdGhlIHRhcmdldCENCj4gPiA+ID4gSG93IGNvbWUgZGlm
ZmVyZW50IGNvbXBpbGVycyBtYWtpbmcgc28gbXVjaCBvZiBhIGRpZmZlcmVuY2UuDQo+ID4gPiA+
IEd1b3FpbmcsIGNhbiB5b3UgY2hlY2sgaWYgdGhlIG1hY3JvIGNvbXB1dGluZyB0aGUgbWF4aW11
bSBudW1iZXINCj4gPiA+ID4gb2YgZnJhZ21lbnRzIGlzIGJyb2tlbiwgaS5lLiwgY29tcHV0ZXMg
ZGlmZmVyZW50IHZhbHVlcyBpbg0KPiA+ID4gPiB0aGUgY2FzZXMgeW91IHJlZmVyPw0KPiA+ID4N
Cj4gPiA+IFNvcnJ5LCBJIHdhcyB3cm9uZyDwn5iFLg0KPiA+ID4NCj4gPiA+IFRoZSB3YXJuaW5n
IGlzIG5vdCByZWxldmFudCB3aXRoIGNvbXBpbGVyLCBhbmQgaXQgYWxzbyBhcHBlYXJzIHdpdGgN
Cj4gZ2NjLQ0KPiA+ID4gMTMuMQ0KPiA+ID4gYWZ0ZXIgZW5hYmxlIEtBU0FOIHdoaWNoIGlzIHVz
ZWQgdG8gZmluZCBvdXQtb2YtYm91bmRzIGJ1Z3MuIEFsc28sDQo+IHRoZXJlDQo+ID4gPiBhcmUg
bG90cyBvZiAtV2ZyYW1lLWxhcmdlci10aGFuIHdhcm5pbmcgZnJvbSBvdGhlciBwbGFjZXMgYXMg
d2VsbC4NCj4gPiA+DQo+ID4gPiA+IFRoYW5rcyBhIGxvdCENCj4gPiA+ID4gQmVybmFyZA0KPiA+
ID4gPj4gIyBnY2MgLS12ZXJzaW9uDQo+ID4gPiA+PiBnY2MgKFVidW50dSAxMi4zLjAtMXVidW50
dTF+MjIuMDQpIDEyLjMuMA0KPiA+ID4gPj4NCj4gPiA+ID4+IEFuZCBpdCBzdGlsbCBhcHBlYXJz
IGFmdGVyIGFwcGx5IHRoaXMgcGF0Y2ggb24gdG9wIG9mIDYuOC1yYzEuDQo+ID4gPiA+Pg0KPiA+
ID4gPj4gcm9vdEBidWs6L2hvbWUvZ2ppYW5nL2xpbnV4LW1pcnJvciMgZ2l0IGFtDQo+ID4gPiA+
Pg0KPiA+ID4gLi8yMDI0MDExOV9ibXRfcmRtYV9zaXdfdHJpbV9zaXplX29mX3BhZ2VfYXJyYXlf
dG9fbWF4X3NpemVfbmVlZGVkLm1ieA0KPiA+ID4gPj4gQXBwbHlpbmc6IFJETUEvc2l3OiBUcmlt
IHNpemUgb2YgcGFnZSBhcnJheSB0byBtYXggc2l6ZSBuZWVkZWQNCj4gPiA+ID4+IHJvb3RAYnVr
Oi9ob21lL2dqaWFuZy9saW51eC1taXJyb3IjIG1ha2UNCj4gTT1kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3Lw0KPiA+ID4gPj4gLWoxNiBXPTENCj4gPiA+ID4+ICAgwqAgQ0MgW01dwqAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHgubw0KPiA+ID4gPj4gZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24g4oCYc2l3X3R4X2hkdOKAmToNCj4g
PiA+ID4+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6NjY4OjE6IHdhcm5p
bmc6IHRoZSBmcmFtZSBzaXplDQo+ID4gPiBvZg0KPiA+ID4gPj4gMTQwOCBieXRlcyBpcyBsYXJn
ZXIgdGhhbiAxMDI0IGJ5dGVzIFstV2ZyYW1lLWxhcmdlci10aGFuPV0NCj4gPiA+ID4+ICAgwqAg
NjY4IHwgfQ0KPiA+ID4gPj4gICDCoMKgwqDCoMKgIHwgXg0KPiA+ID4NCj4gPiA+IFRoZSBwYXRj
aCBhY3R1YWxseSByZWR1Y2VkIHRoZSBmcmFtZSBzaXplIGZyb20gMTQ0MCB0byAxNDA4IHRob3Vn
aCBpdA0KPiBpcw0KPiA+ID4gc3RpbGwgbGFyZ2VyIHRoYW4gMTAyNC4NCj4gPiA+DQo+ID4NCj4g
PiBTbyBpbiB5b3VyIG9waW5pb24sIGRvZXMgdGhpcyBwYXRjaCBmaXggdGhlIGlzc3VlIG9mIGhh
dmluZyBhDQo+ID4gZnJhbWUgc2l6ZSBsYXJnZXIgdGhhbiAxMDI0IGJ5dGVzIGZvciBhIHR5cGlj
YWwgYnVpbGQ/IEkgYW0gc3VyZQ0KPiA+IHdlIGRvIG5vdCB3YW50IHRvIG9wdGltaXplIHRoZSBk
cml2ZXIgZm9yIGJ1aWxkaW5nIHdpdGggS0FTQU4NCj4gPiBkZWJ1ZyBvcHRpb25zIGVuYWJsZWQu
DQo+IA0KPiBCdXQgdGhpcyBpcyBob3cgd2UgYXJlIHJ1bm5pbmcgb3Igc3VwcG9zZWQgdG8gcnVu
IGtlcm5lbHMuIEluIGFueQ0KPiBzYW5lIHJlZ3Jlc3Npb24gcnVuLCBLQVNBTiBpcyBlbmFibGVk
Lg0KPiANCj4gSSB3b3VsZCBzcGVjdWxhdGUgdGhhdCBtb3N0IHBlb3BsZSB3aG8gcnVuIFNJVywg
dXNlIGl0IHRvIHRlc3QgdGhlaXIgVUxQcy4NCj4gDQo+IFNvIEkgd291bGQgbGlrZSB0byBzZWUg
aXQgZml4ZWQgZm9yIHRoZW0gdG9vLg0KDQpVbmRlcnN0b29kLiBJIHByb3Bvc2UgdG8gdGFrZSB0
aGUgcGF0Y2ggYXMgSSBzZW50IGZvciBub3cgYXMgYSBmaXgNCm9mIHRoZSBwcm9ibGVtIHVuZGVy
IHRoZSBjb25kaXRpb25zIHJlcG9ydGVkLiBJJ2xsIGxvb2sgaW50bw0KcmVzdHJ1Y3R1cmluZyB0
aGUgdHJhbnNtaXQgcGF0aCB0byBzcXVlZXplIGl0cyBzaXplIGJlbG93IDEwMjQNCmV2ZW4gZm9y
IEtBU0FOIGJ1aWxkcy4gSXQgd2lsbCByZXF1aXJlIHNvbWUgdGltZS4NCg0KS2VybmVsIGJ1aWxk
cyB3aXRoIEtBU0FOIGVuYWJsZWQgZW1pdCBsb3RzIG9mIHNpbWlsYXIgY29tcGlsZQ0KdGltZSB3
YXJuaW5ncyByZXBvcnRpbmcgZnJhbWUgc2l6ZXMgYWJvdmUgMTAyNCBieXRlcy4gT3VyIGNvcmUv
bmxkZXYuYw0KYWxvbmUgc3BpbGxzIDEzIG9mIHRob3NlLiBBbnkgYWN0aW9uIG5lZWRlZD8gOykN
Cg0KQmVzdCwNCkJlcm5hcmQNCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+IFRoZSBvcmlnaW5h
bCBidWcgcmVwb3J0IGNsYWltZWQgYSBmcmFtZSBzaXplIG9mIDEwNDAgYnl0ZXMgZm9yIGENCj4g
PiBidWlsZCB3L28gS0FTQU4sIGJlaW5nIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgYnkgMTYgYnl0
ZXMuIEkNCj4gPiB0aGluayB0aGlzIHBhdGNoIGZpeGVzIHRoZSByZXBvcnRlZCBpc3N1ZS4NCj4g
Pg0KPiA+IFRoYW5rcyBhIGxvdCwNCj4gPiBCZXJuYXJkLg0KPiA+DQo+ID4NCj4gPiA+IFRoYW5r
cywNCj4gPiA+IEd1b3FpbmcNCj4gPg0K


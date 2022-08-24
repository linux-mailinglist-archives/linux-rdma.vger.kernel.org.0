Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8F59FD9D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiHXO43 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiHXO42 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 10:56:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AC86C15
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 07:56:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OEhjqe026958;
        Wed, 24 Aug 2022 14:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=RD7zdLBDktAwaZUHSKPrkl6y43YUpW3VTL76YW9k1JA=;
 b=E2w4/XgxeX/lgj71sypNKuLGeOndQTv0Q9+23GjMmMy1cg59fSqAa+qE4dZoGEtYu+68
 +siBoeEPXeS+IWTBY0OnxmWyQPyp0iXIJV8DlJbYGZgRdeh8OdWqNLP8a17O4q/Mo1wE
 6eC+D5mHd8btkYAr/wH+/OyJCag+rFMXltdG6hX+Zqm00HAKlG0C2orPLSBT0eg/kt75
 9qfaDg4L+8hdswdxuh+Aj8axAfAlZstT/XTEaca2TE2r0sIAhMRpbHLEC8RDhgq3jo3e
 02zt+Vqa4JrMPFoHU+0Ty+L1wgWaVm8yieVLudIsQgzd6sJU5N0HbKWB6GpRFgGvmJpU bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5p0jrd9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 14:56:17 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27OEqoA7031596;
        Wed, 24 Aug 2022 14:56:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5p0jrd8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 14:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEB6j+nxACnov2aPTOaOjPGmFSBQynEzFnNiTA/9c2Zc0GaDwrvp9BMUoBNAlL2AsywATbehkeDsFp1ECOaTSVdLHDhFXvDKEv/rXOe/MiKtJVY5wLgFmf4NqpwwqskuIO4rSrusYz/L75hFhjSyrzssKinFDQJ7OpEl4GRktlaeKjEhpax5cy3FOgNHC0Xb8ehvPOSyM9SNv0wD5AQizciXcDCmBzuiy0KKX6RxUlICIzuu/zpfYcog5sjMPGZBWKRy/Eo3ga/rqg/NFzzeF8z7gOT9qhPZc/cJH6B+il0J1KseKc/PMPIq7Qx/ca2X9BYr4cffUGyavdx3PY4gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD7zdLBDktAwaZUHSKPrkl6y43YUpW3VTL76YW9k1JA=;
 b=M2iPNy0XS72p/TrE8AIlHMg8OHk8L4cEPCoJJQcs3sV5Cr8AJAdIyqz4bvqd3TJ9C00SbeoVNNDCbogxRWvZNYQSNXzfcxAtmUFtgBQULWN/9vZRXfSjOCWDlpl+W5vxXpP7zsJmVz90jfCPfYXih+x6Rrus6J5PsnDG+0KrjVPJpspWON6zlAuY37iO8/YkILuqcr4djJRwZENgrI3DNqS2Y21Ol/qumQtfRhRQpC/O1bKxBN3gfQgZh8Ahnp4BxX9b15MYRGLISHVwnNhlKnnSK1VM9k9NAunLQmP9VOQHAWlQUDKzgsDSDxwut+Ccb3ay2sQPihmlGThxS6UTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BN7PR15MB2417.namprd15.prod.outlook.com (2603:10b6:406:8c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:56:15 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 14:56:15 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Tom Talpey <tom@talpey.com>, Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
Thread-Topic: [EXTERNAL] Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom
 implementation of drain_sq and drain_rq
Thread-Index: AQHYt8Mc7Y9AQ4vV/06XnlciZziMOa2+IjQw
Date:   Wed, 24 Aug 2022 14:56:14 +0000
Message-ID: <SA0PR15MB3919306B4B5F25BB93067BCF99739@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
In-Reply-To: <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdccb874-f5a0-4a66-8a28-08da85e0caef
x-ms-traffictypediagnostic: BN7PR15MB2417:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7dcC5fyV1/ClN2xUsD/e9tWZBKolpjV6GG69HBop/Cxsjs2hEI3Sk5K65lYPgOvTkWVAH5PlXS865L0/sTKinKFre7dwMlRORPYyNm7tHx3E3znXpte3i2OtZ2bufnxlhv/uWwmb/guU7/aGeYlWMuV+OY6mDuQjQ99OvwPzQdX7z9xksoa+e1dU2U18v07XGVnz8Yo1NX1sb3vYA+IA+TSqJw4UnPq0ag7pzCrcWDJy7U8D/xuvwVaCxKDat9PHdtMDQSV28BKrbeVCAx0Olh4chzSenlwxQnKUHnB/UC0wFcLpDtBgM0p3xGj9LSMxETChF4fj3/m6alXp25b5T+JKcpGoX+CGLva9wvO0NRjRBbsOwBhCGIjngbFh2ARfOLOYRTlq3Fppt+ekAALub5ZrfuoEAM3zVnPHos0sLcNc1E6WVETrsKlbRmy29WCEmRqKh04VMsn6RdvLt8PnebQ5eJBDApwe35q4hAkfYecZ5wLkFQVaHChdg4am/NgLwazdLXaLalGqgAIF9DmZ7LVC6GYvduySf9HVJfQfp250909zJ3CLHGPnKE8Wpd6IRqE2O0CPqWxHD+vQLPPm8bT/1nvQNgKySt5ZmryCxaPrxx7ipbj5exT+OCcgHsSR8AuECV3PW3Tzt9xGBdeIFslwxhKFdkXs5q60JQRXpX6DGdnr7rv/cTcr7FpvK1G3hmSxX64m2k86KsVJnrc8WTiydKksPnbmTtVVWAIszPF9Vc54+5zg9wJLKXZalPpegUe10378Y7Ap9lbegU9+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(83380400001)(33656002)(478600001)(53546011)(7696005)(6506007)(2906002)(9686003)(41300700001)(186003)(8936002)(52536014)(86362001)(5660300002)(38100700002)(66556008)(122000001)(110136005)(54906003)(316002)(38070700005)(55016003)(71200400001)(64756008)(66476007)(76116006)(4326008)(8676002)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODRHcE5SQmZWMnlvdzc5anNVNzJKVk5wYnRzWnlURFFpeVJPbS9hYVYrL0gy?=
 =?utf-8?B?emtodXU4ZTdTeldiT0oyYVpQc2gyZ3Uvb3ZNMHZYZm1EZjFmSElJT09ReGhr?=
 =?utf-8?B?anlLUXNQWm9qL1I2ODhpUmJTaUtTRkpWcnB2TkRVZG9rMWpOZTBONDltb0pJ?=
 =?utf-8?B?U0RmREpUcWZrZVRJWmo2Wm1McEY4V3FRVjB1aUZvN1dBQzE1R0JtaWl2UURX?=
 =?utf-8?B?M2tsY1N1bko1S1pmbWt3Z3loWHU0c3QwdktOSjhxTW1iTDdmSjgwdFJHMTky?=
 =?utf-8?B?YmZ4RlJzT09yeG5uY1A5d1V4K0prallpanVxamNjWHViVmtoSmZidnpwL0R0?=
 =?utf-8?B?S3RXZkZGT21MQUZGR0l4a2UxODVxYWx1N2FLZmdIUzdacmY0S204a1E1eTZX?=
 =?utf-8?B?aVJqb0NkVEdkS00wcFRRRzU3S3psZm5ocU15d0hXN2dqNTh0YTZub0grUnFn?=
 =?utf-8?B?THNwb0ZBSGdLR1dreXExeVpyU0hvWDdPRU1JbjBUTEpuNzhwcjM0RVp0d1oz?=
 =?utf-8?B?YXNTNi9pQ2xtV1ZIVksxT1ZTZXA4WnZVa1VhUzcwaHBRbnUySGszODJzNTRv?=
 =?utf-8?B?aHArYWpqZW9SaWFLTnBHMVB2NlBURXZObVFQZFFxY05CT3JTS3k1cWxOczAr?=
 =?utf-8?B?OVFXbEFHcW5kVThhYlNjL1c1S25KbjNPZ3ZhcWRVQlBDUlNSMUF6b2dDcU4v?=
 =?utf-8?B?ZEEwRXFsTU1WQ3ZTZUdqcmFDVEhCS1YrMHk5OVUvVU03NndRM0tnaHRrZDkz?=
 =?utf-8?B?WUFvbjhXT3pIKzQvemVHQ3Y0MmlZS1BpWmdta1ZucHFHSWwrKzhrZzZlRXdt?=
 =?utf-8?B?ZWhMMlZ1d3h2UUEzUllYYUFrSTQyYUNmR0xJQWMycGlRYVNpRHIwckFCUCto?=
 =?utf-8?B?M2g2alhOSVZ3YWNpb3VEQkdDRVlPeVNzbmtoVVlHek5wTU5WUVFkaHl0T3dN?=
 =?utf-8?B?YW5QeFJ3elRjcmpxaTdlQ3lBbUVTK0pIT0ZiMkRUY3A3d0dHWXNXMzdwbWNn?=
 =?utf-8?B?RWRMaHRnakdNVncrdTVvbzNWS0NWN2FTSTlMUHUyMFU5ME9OaDZDS3NhQ2lD?=
 =?utf-8?B?ZDZuSFRlRkdNZkZ2cVd4UXVEdHllc1kxVXMrcHM2c21jRWUybmwvTnhkeVBl?=
 =?utf-8?B?SmpXMWdTT3dWcUJEUkppdTQxNnJIUXlrNU9Cdmk2OUxnYTZqQStKOVlHSVVX?=
 =?utf-8?B?WW13R3owWVJQcEJ0aHRPMXhtUkVoVmE3Z1hIZHd2SXI2WlZtekxWUFVJdmk3?=
 =?utf-8?B?U1F1YmhXcG9iY1AyNmtBKzhsNmFWaXRYbkUzNU5MZSsxVXRRRmpxT1pRdk85?=
 =?utf-8?B?K1RiWHV4M2kvOGthQUwvOXFNaDIxd1JxZnViOVB3ZmhrYzh4UkRkdnYwUmVo?=
 =?utf-8?B?WXh3d0lJeDdERllDdUMrQ3l3a0FMaHl4djBuUk8vUWhnQUlhRGFuVFBaQnVa?=
 =?utf-8?B?bVpXOS90Um5RVzNKL3BZSFVQa0loRG1uMFdkSXhHNkJFZ0F3b2FNVUp1Zm1O?=
 =?utf-8?B?ZjlzVTI0KzFZWlM1UEt4T3BuNVRFczU5MExHTHVpeDg5MFBPUjZYU3pBbVVy?=
 =?utf-8?B?dmJMaXFERmFWbzlndlFUb0RFWDN1UmdUajB6SXJiSGJ2ODNxbHV3VmZ3Yjc4?=
 =?utf-8?B?UnZJVUVxektmVTMyMnpHdmI3Yncxc25EOVdGdW9aS3lzMkQ5eGpvSk5TL01R?=
 =?utf-8?B?OURyNktnN0swTE80YW5ySEtEVFVoUUpIRW9TTXp6MXpUU2NNekk4RnlWYThi?=
 =?utf-8?B?eXRNSmxJemY1TWc1SldBNGFkcDZCZzNHa0IyeGxjVHhuSTBvR0EvaDRhTWk1?=
 =?utf-8?B?U3BkcVh4d0hPc2tCakNSWUxJdUtMY2YxemxIWDA5blB6REIwMjRxZ1pNc0ZR?=
 =?utf-8?B?cUZyanVWQ1VFOWdSLzNlSWkxWURXZkVNVG9UUXFWaDEzOVYrNEJESlpjeDho?=
 =?utf-8?B?TTMxSW44ejBQZTVjRUlvQUZKTEtnTkF4cndyeG9oVTllV0c2dUJqS3N3Qnov?=
 =?utf-8?B?TC9NZTRUMG1EZE96QU9GSytkcUZ6QjVXL1YrSTdsUkVJOWFYSFB5U0MreUwy?=
 =?utf-8?B?bmovQzhhbW43ekE4Zzc5OW02dnE5R0dzbzU3TDY0bzM5WHh5WnFwQ09SZ05B?=
 =?utf-8?B?Z1FialZ5RXR5elp4L3JWdGtxNk8zbVh3UDUyTWcyOWRDQ3lnNmJqWWxacEds?=
 =?utf-8?Q?SBltqQpCzwV458j39ydIiEY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdccb874-f5a0-4a66-8a28-08da85e0caef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 14:56:14.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2Kiq1j8wObuLHhG4g4GnJVqQBAJloSb3GlyFQcuJ2EyJPp3H+hl2mWPVJcoCzBhU2QOTP2e077FroMX63crLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2417
X-Proofpoint-GUID: DcSs6KAyFE6knprWpVW5MAuFTZ2T1Mcj
X-Proofpoint-ORIG-GUID: iKpMwZE3FL9mbP9LETJTh8m1bIhaEE_H
Subject: RE: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation of
 drain_sq and drain_rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=830
 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb20gVGFscGV5IDx0b21AdGFs
cGV5LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAyNCBBdWd1c3QgMjAyMiAxNjowOQ0KPiBUbzog
Q2hlbmcgWHUgPGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tPjsgamdnQHppZXBlLmNhOyBsZW9u
QGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBLYWlTaGVuQGxp
bnV4LmFsaWJhYmEuY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBmb3ItbmV4
dCAwLzJdIFJETUEvZXJkbWE6IEludHJvZHVjZQ0KPiBjdXN0b20gaW1wbGVtZW50YXRpb24gb2Yg
ZHJhaW5fc3EgYW5kIGRyYWluX3JxDQo+IA0KPiBPbiA4LzI0LzIwMjIgNTo0MiBBTSwgQ2hlbmcg
WHUgd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIGVyZG1h
J3MgaW1wbGVtZW50YXRpb24gb2YgZHJhaW5fc3EgYW5kDQo+IGRyYWluX3JxLg0KPiA+IE91ciBo
YXJkd2FyZSB3aWxsIHN0b3AgcHJvY2Vzc2luZyBhbnkgbmV3IFdScyBpZiBRUCBzdGF0ZSBpcyBl
cnJvci4NCj4gDQo+IERvZXNuJ3QgdGhpcyB2aW9sYXRlIHRoZSBJQiBzcGVjaWZpY2F0aW9uPyBG
YWlsaW5nIG5ld2x5IHBvc3RlZCBXUnMNCj4gYmVmb3JlIG9sZGVyIFdScyBoYXZlIGZsdXNoZWQg
dG8gdGhlIENRIG1lYW5zIHRoYXQgb3JkZXJpbmcgaXMgbm90DQo+IHByZXNlcnZlZC4gTWFueSB1
cHBlciBsYXllcnMgZGVwZW5kIG9uIHRoaXMuDQo+IA0KDQpJdCB3b3VsZCBiZSBvayB0byBzeW5j
aHJvbm91c2x5IGZhaWwgdGhlIHBvc3Rfc2VuZCgpL3Bvc3RfcmVjdigpIGNhbGwNCmlmIHRoZSBR
UCBpcyBpbiBlcnJvciwgb3IgdGhlIFdSIGlzIG1hbGZvcm1lZC4gSW4gdGhhdCBjYXNlLCANCnRo
ZSBXUiBkb2VzIG5vdCB0cmFuc2xhdGUgaW50byBhIFdRRSBhbmQgd2lsbCBub3QgcHJvZHVjZSBh
DQp3b3JrIGNvbXBsZXRpb24uDQoNCkJlcm5hcmQuDQoNCg0KPiBUb20uDQo+IA0KPiA+IFNvIHRo
ZSBkZWZhdWx0IF9faWJfZHJhaW5fc3EgYW5kIF9faWJfZHJhaW5fcnEgaW4gY29yZSBjb2RlIGNh
biBub3QNCj4gd29yaw0KPiA+IGZvciBlcmRtYS4gRm9yIHRoaXMgcmVhc29uLCB3ZSBpbXBsZW1l
bnQgdGhlIGRyYWluX3NxIGFuZCBkcmFpbl9ycQ0KPiA+IGludGVyZmFjZXMuDQo+ID4NCj4gPiBJ
biBTUSBkcmFpbmluZyBvciBSUSBkcmFpbmluZywgd2UgcG9zdCBib3RoIGRyYWluIHNlbmQgd3Ig
YW5kIGRyYWluDQo+ID4gcmVjdiB3ciwgYW5kIHRoZW4gbW9kaWZ5X3FwIHRvIGVycm9yLiBBdCBs
YXN0LCB3ZSB3YWl0IHRoZQ0KPiBjb3JyZXNwb25kaW5nDQo+ID4gY29tcGxldGlvbiBpbiB0aGUg
c2VwYXJhdGVkIGludGVyZmFjZS4NCj4gPg0KPiA+IFRoZSBmaXJzdCBwYXRjaCBpbnRyb2R1Y2Vz
IGludGVybmFsIHBvc3Rfc2VuZC9wb3N0X3JlY3YgZm9yIHFwIGRyYWluLA0KPiBhbmQNCj4gPiB0
aGUgc2Vjb25kIHBhdGNoIGltcGxlbWVudHMgdGhlIGRyYWluX3NxIGFuZCBkcmFpbl9ycSBvZiBl
cmRtYS4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBDaGVuZyBYdQ0KPiA+DQo+ID4gQ2hlbmcgWHUg
KDIpOg0KPiA+ICAgIFJETUEvZXJkbWE6IEludHJvZHVjZSBpbnRlcm5hbCBwb3N0X3NlbmQvcG9z
dF9yZWN2IGZvciBxcCBkcmFpbg0KPiA+ICAgIFJETUEvZXJkbWE6IEFkZCBkcmFpbl9zcSBhbmQg
ZHJhaW5fcnEgc3VwcG9ydA0KPiA+DQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEv
ZXJkbWFfbWFpbi5jICB8ICAgNCArLQ0KPiA+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1h
L2VyZG1hX3FwLmMgICAgfCAxMTYNCj4gKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmggfCAgMjcgKysrKy0NCj4gPiAg
IDMgZmlsZXMgY2hhbmdlZCwgMTM2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+
DQo=

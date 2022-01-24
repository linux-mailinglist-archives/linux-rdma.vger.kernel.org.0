Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54816497F62
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiAXMZm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:25:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47038 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238940AbiAXMZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jan 2022 07:25:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OAKRrM007840;
        Mon, 24 Jan 2022 12:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xhBOUn+Ioe2JIktF6zG+jGJ1t/4a52FXwXBPP8PIJVc=;
 b=sp6YzHO207OphnB0a97XBZ54MaUDStbHfCtzfo4znyDSUSse8BJuwxcJR9d0eR0LGCj8
 3uR58r4U/PH4jioQvrUHxOUi3z00wl0Zl3BbLJfXWcRGUYV/ghg2UXYPvcKNWQeux9kP
 0QhwssG/pRPrAIBXYey4hXgL/RCO18GQ2iWj2jSfhrCsPl2r/drFFvO/RxIYi2REa+xv
 iQZ+uHjfjLNc5cmQTUEFfJS2ZWkCNqQZrmffj2ZuN5BXsflCtbAuSBx/L8LYnDaPg0kI
 +YnLP/vAKB1tAr284BpUaf9mXCxNRNScSh3xwKhUj2uzGJJzuJ13oQulvEgKqIMpXIrn SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr8bdkx6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:25:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OCGsRB040379;
        Mon, 24 Jan 2022 12:25:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3dr71va8tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS7aZ2/OsQ+OLYvNO3NEtIG7HdHNYvq2fGKO2g6ZiaMKFGyvRVSwtG8/Y+eJaEdd6TlTuTferQgYtb/QquyRufBB3wvFmzkUQ2VoQV2aaqukJyFKwGGa47KKty3yRzIycR3JzTWanKomqJlIJB2Hi4PtyShpaPh6sfVvOPQcykoMGAU3ga0s1CFBpJ63TLU+vYz9v558/DNeXRrhoQMtvcI2hDl9H83ZLwyrzc0zgPcDZRMZ/R7X09FN/5kO0GFayYVTrISnA8xsG60atkTuF1yIqWzvyI8qYrYZQTmDRwHZOVDAozOUGKD2V89Geocs6ig4iDahOUse09LHQr1Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhBOUn+Ioe2JIktF6zG+jGJ1t/4a52FXwXBPP8PIJVc=;
 b=LTnxCAj1RWiP8g7+1sXtu9oamg0PoWoXMz+zOYRyatV/zbEC90aCkHpINEvXdkTVhBil74GhLUbHZHwiH4dF3h070/g09vZSoVTM0Zycx0KuBs273+AGuvyM9k5RAylg4+fYzWvknH5AKNkHdCOPrzBcxOdRRpicnAQqI9ofcetFJ+WQRU8T/FAr1djfwmFGIFiGI5x3MLO0iNSiBo7DlWaYfP8Q0+XJfZ1/8c0B8pAWFUXaIglDpns0e5dgEfvnJEkc1uKBVSukgVBhCWJWQj4lMGe33ER1QKEyuMOw6In8VvpYRtd6aZWG9MDCdZ2K84RTvmTcf6ivcmUQDSgmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhBOUn+Ioe2JIktF6zG+jGJ1t/4a52FXwXBPP8PIJVc=;
 b=fKKf4XRsOY00eV5ytUnRjvYxadWeP6YjOtPr2e/A2OZKN4i+tT29ljBtFmGXLy3zm7jF+WrUBB8X0d0vVsJjpXjxB+N4PLS6ZD0SjfQVUodY+HbNvWg806nMpD6u5unazeCM4g1zO9oCW4XQek9ff2BJ8csHNnNhCbmcBjTNvJU=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by DM6PR10MB4329.namprd10.prod.outlook.com (2603:10b6:5:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 12:25:32 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 12:25:32 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "mike.marciniszyn@cornelisnetworks.com" 
        <mike.marciniszyn@cornelisnetworks.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Topic: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Index: AQHYDRbqy5Gwv8UplUmU/FE5niN4Zaxwb3QAgAGxUwA=
Date:   Mon, 24 Jan 2022 12:25:32 +0000
Message-ID: <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <Ye0vPMAF6NdF0pMu@unreal>
In-Reply-To: <Ye0vPMAF6NdF0pMu@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4db0bd73-9636-4f68-5ce0-08d9df349dd2
x-ms-traffictypediagnostic: DM6PR10MB4329:EE_
x-microsoft-antispam-prvs: <DM6PR10MB432938584805A6ABA5DCF2B7FD5E9@DM6PR10MB4329.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clIvY3z5D6mZtgIktSmlcxp+swJT98Woab8hAt1UtKSgMWW/LSY9vwv7d+fVZv2R7p3+4kUDUaqGrkFGRTp8YMQhV5W5RVsoULgzvigCceFryx7tYcSWv0Pn8HQ0AbA8uJqh7B7aNr0PSLX1OGHKgPGr0/n+Xf/qSAIW7tFH5xb72+QJ+NnwY2toUlRoFrXEr6yAmKCA+zCtqpIsreIjokol/feP6GEE4ztfx6fGhaARjTueNaRWttJgjjQUTZ3lpXCVQ6iU+ur4XcBRcrjuuRAVgZqJbhuvtEjYNsGbz1apAC2z5X4Huw1kUzH7eZTDZcOFl0u19hK5StIW4+YwYlwCw3cU9Fwy4X7J1/DfNdZ13WIVAugQyatjGnxvd9C4BbZsEnLTH6k9yX9A1nDdeRA9prM2NG0CVZrSEsuGmukoOXJJC2ZOVwEOeanrI3gaUZ1CdQvq2AGcxMFtzTHyq1WsvQ07YFwYVZCmwitrg0QaUeDvFUmYJ74IB18oF3QCAYPojHpEy4ccU7M9v/WQFNxB7cCyhOW4ls/DV+mPudlgkHgWMMiBpJv4xzyvC11jVu2t+T2GqxPCqg0x00iT3Zg1OGM3Oi0WB17UM3rX7RejGIDbFAI6guEvTboLj6iB/ivnxET/fpDp4cTZBzktt3vNLDMEGbL0OU39xZwhZDmLBEOOrI79aKzor+dcUM8SIm5P2B2FCNBDMCnzuzJF0yF6ATx/rAVumjS4acumS+Ps4pwQ2bux0Ghsx7I51psz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(54906003)(316002)(53546011)(66446008)(8676002)(86362001)(36756003)(8936002)(186003)(122000001)(38100700002)(44832011)(2906002)(6512007)(6506007)(5660300002)(2616005)(83380400001)(6486002)(33656002)(64756008)(71200400001)(38070700005)(66476007)(66556008)(6916009)(66946007)(91956017)(4326008)(15650500001)(76116006)(66574015)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1doNEhIbnpMSHlzbWhlcWRqcnJEWDF4NnBWS2hxL2NwZGdGV3p3aEFYbCtK?=
 =?utf-8?B?Q1gzUEZ5QTNMUHZFRHA2WFpLZmNCVUNsOW1hWDlxbTZaa3plWnZMMGQ5NFVw?=
 =?utf-8?B?YlpteUNzSWpvSmlRaGhJb2pLTXEzZU51WE55QXBmeXVwTUhDeWlzNm9tM241?=
 =?utf-8?B?NTUyS1FpdnJSbGwwc1d4SERmeWh0eWFhTzkzV0lZZGRiV2ZFd0tjNnQ0SUF0?=
 =?utf-8?B?Y2U4cXk5eWVxODFBTDJucXBHb0VrNGs1ai9BcndSWFpZTnRpeExtdS8vOUt0?=
 =?utf-8?B?eHAva2dwS3VjWURNOTZiZ2s2cjdmYkZwL2U5THRBQVpycXFKKzRwS3BsOWJp?=
 =?utf-8?B?UjJvaWtRdDRUSlBJWWlGMVltellINTF2YjRxaTR1N2RXTDMyV3FUMEljQld5?=
 =?utf-8?B?Vmh4U2FkV3hSR2xza0tsaXRIbHhJdEVUaGhDaEpmeWVkeklCdFNueG5wNTEz?=
 =?utf-8?B?NmwxTElxK01sT1E3cUdCL0NpRGNIRlFzUWs5YlpONnAyTVlXc0RwUG5CZHlY?=
 =?utf-8?B?VFJKb3E1QUVHdXZjTm5uZllINWM3bE52NGVCak9rT20wNFR6dVd0a3A1OUNK?=
 =?utf-8?B?dEpERFhzWTc4M3VaZWd5RzhtdkVSUVlHaExqLzE1V3lpNWg0RTI0aTNBMWxk?=
 =?utf-8?B?OGFVVEk4R1pjUGtFSnliS3g0T0Z2TklDMDF2cGI4dmEvS241VFpBOHFBSnVB?=
 =?utf-8?B?Yk5QcXpBeDhrb3lQSjZUTnRuVVQ3WDlZekR6UnJaSDNyUXNvUVJoMlo1VHBO?=
 =?utf-8?B?bHRIQnN5L0xrRFY2TEVaSWhnK2J4eTYrakVDWnI5Mk51aTh5d2tVTGdLQ3NO?=
 =?utf-8?B?a2ZLL01NS3ppTndxaUViK3NVT0xLdldmbjdmOVE5TTNLbzBGSzNIUXFPS2Rx?=
 =?utf-8?B?RklubGRCRWlncjJJQ0NJS21MbjFmZTJwRWtvQ0RCaHBwWXNvZllVV3hQZFJj?=
 =?utf-8?B?TGlLYW5VZUd1ZlhLQkd0czN0Q25hdURLVDlEZUlzV1NvUWtpSGJBUmlQaU1Z?=
 =?utf-8?B?dDNGWXRLTStpWnlVOVhMS2pXRVByZFdzSzREZWFZdkVGd3hrdkJ4OFR2NWlU?=
 =?utf-8?B?NkVFeGpzbVcwU0hkRU41c0FrQkhNTUg5VzlJV3JhYVBBL291Yk9nRWY1NXZB?=
 =?utf-8?B?TGNKUGtNWjFVbk03VTM4SzFBekh0eDN4dXpzcmhTd3N5WXQxTnFIZXhFSEc4?=
 =?utf-8?B?bVdGU3lhMWdLVXRuOE5uVlVsS3hJOGtVWjFhQWZsdmFrdC9KMWZUaTRDYXlX?=
 =?utf-8?B?dS9QMzdWcHNmektHQVc1QWtOSGJkL1loQVFiaXl2VnM5YzJoUUpGV1FvdDBQ?=
 =?utf-8?B?cHpvNW5lRCtuQXNFb1BwRmxuN3VDbWxuaEU1OWp1Y1hPYU1aNmNJaysxMVpt?=
 =?utf-8?B?bENKVkh6cVdVL2xSekFCcmxRL0NjQTdSVDhMdGREOHBuUitXaklyY0ErckJD?=
 =?utf-8?B?VHIxRGlNNlFvR2Z4VzlIbVREWjdiajE1N2Q0bDdTVml6QTB3OU5TZWRWbzZM?=
 =?utf-8?B?c1NCUkE0RlMrK2ZVWmhKdWh4VzBuMVNPUGpodjJGZjB5Ym5pOGJqc3RUNVZy?=
 =?utf-8?B?ZHVGR0NmRFdBZTk4TGltOUM2Q0lHY2JpVFAwamxaUmtyK2dCQUJ3QUdKemhl?=
 =?utf-8?B?L28yS3htc1dJQnBFaWUrYlY3bUorRVowZjR4R3RUUXh2YUtOL3k5K044ZHhi?=
 =?utf-8?B?dXZJdzMyaDFxbzdPT0JHVmpVeWZHcWNHSm15dWlQMWJFNllRNU5neUo1dGZr?=
 =?utf-8?B?U0xYYjNRdVRTazByQnhhUUFORTNacFdOSFp5Z0VvamlrV0tya00rSTM0bEZ5?=
 =?utf-8?B?WW4xYUlvYVFsajRNb2dmdWQrckZiNDFRREpTYWFoODVRZnI4eEVabDB3dkNh?=
 =?utf-8?B?SDBCRHU4QlkwOVB4S1ROcDFYMFlGbFUxcGVoRHdCM0duRjNaYnk3K1VQcUtY?=
 =?utf-8?B?RVlBd0REM0JvWXVMYWV3a0hzd1NUekE1cDkzVXAwa05oNzR0OGxOejBSb3Uy?=
 =?utf-8?B?MjNrV1NsZEJlbVNiSHFlUjdJVEtKNk8weWZ0QVFFSDJWSlpHd0JsejJ5eDdw?=
 =?utf-8?B?MVY5azFZeHQ5T3VMWWlIMTZGVWNwRU1kaFRDdmFnd3pqUnQ1dXBQNnR1NDNk?=
 =?utf-8?B?bW1NWjNSRDBTazJYMG4wWm9BanJ3QXdzUW54QlVPVGR2eWszTFF4ZElIS3ps?=
 =?utf-8?Q?3zjxmDD9xrDF4hCUQYnR7mk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DB17DE90703114DBE65DA693C8D994D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db0bd73-9636-4f68-5ce0-08d9df349dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 12:25:32.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrfaN9aySeNPaoLGmIpSxTrO2zZE8dDXgHIQN9wLgyCXGKVue2wL9iAZJMtgATZKVQ3SZchTAzoP1wbKFS3tag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4329
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240082
X-Proofpoint-ORIG-GUID: VitskbbHij66BmZUvuikzL5SQSLi63gF
X-Proofpoint-GUID: VitskbbHij66BmZUvuikzL5SQSLi63gF
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjMgSmFuIDIwMjIsIGF0IDExOjM0LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEphbiAxOSwgMjAyMiBhdCAwNDoyODowOUFN
IC0wNTAwLCBtaWtlLm1hcmNpbmlzenluQGNvcm5lbGlzbmV0d29ya3MuY29tIHdyb3RlOg0KPj4g
RnJvbTogTWlrZSBNYXJjaW5pc3p5biA8bWlrZS5tYXJjaW5pc3p5bkBjb3JuZWxpc25ldHdvcmtz
LmNvbT4NCj4+IA0KPj4gVGhlIHJkbWEtY29yZSB0ZXN0IHN1aXRlIHNlbmRzIGFuIHVuYWxpZ25l
ZCByZW1vdGUgYWRkcmVzcw0KPj4gYW5kIGV4cGVjdHMgYSBmYWlsdXJlLg0KPj4gDQo+PiBFUlJP
UjogdGVzdF9hdG9taWNfbm9uX2FsaWduZWRfYWRkciAodGVzdHMudGVzdF9hdG9taWMuQXRvbWlj
VGVzdCkNCj4+IA0KPj4gVGhlIHFpYi9oZmkxIHJjIGhhbmRsaW5nIHZhbGlkYXRlcyBwcm9wZXJs
eSwgYnV0IHRoZSB0ZXN0IGhhcyB0aGUNCj4+IGNsaWVudCBhbmQgc2VydmVyIG9uIHRoZSBzYW1l
IHN5c3RlbS4NCj4+IA0KPj4gVGhlIGxvb3BiYWNrIG9mIHRoZXNlIG9wZXJhdGlvbnMgaXMgYSBk
aXN0aW5jdCBjb2RlIHBhdGguDQo+PiANCj4+IEZpeCBieSBzeW50YXhpbmcgdGhlIHByb3Bvc2Vk
IHJlbW90ZSBhZGRyZXNzIGluIHRoZSBsb29wYmFjaw0KPj4gY29kZSBwYXRoLg0KPj4gDQo+PiBG
aXhlczogMTU3MDM0NjE1MzNhICgiSUIve2hmaTEsIHFpYiwgcmRtYXZ0fTogTW92ZSBydWNfbG9v
cGJhY2sgdG8gcmRtYXZ0IikNCj4+IFJldmlld2VkLWJ5OiBEZW5uaXMgRGFsZXNzYW5kcm8gPGRl
bm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IE1pa2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AY29ybmVsaXNuZXR3b3Jrcy5jb20+
DQo+PiAtLS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYyB8IDIgKysNCj4+
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
ZG1hdnQvcXAuYw0KPj4gaW5kZXggMzMwNWYyNy4uYWU1MGI1NiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3JkbWF2dC9xcC5jDQo+PiBAQCAtMzA3Myw2ICszMDczLDggQEAgdm9pZCBydnRfcnVj
X2xvb3BiYWNrKHN0cnVjdCBydnRfcXAgKnNxcCkNCj4+IAljYXNlIElCX1dSX0FUT01JQ19GRVRD
SF9BTkRfQUREOg0KPj4gCQlpZiAodW5saWtlbHkoIShxcC0+cXBfYWNjZXNzX2ZsYWdzICYgSUJf
QUNDRVNTX1JFTU9URV9BVE9NSUMpKSkNCj4+IAkJCWdvdG8gaW52X2VycjsNCj4+ICsJCWlmICh1
bmxpa2VseSh3cWUtPmF0b21pY193ci5yZW1vdGVfYWRkciAmIChzaXplb2YodTY0KSAtIDEpKSkN
Cj4gDQo+IElzbid0IHRoaXMgIiFQQUdFX0FMSUdORUQod3FlLT5hdG9taWNfd3IucmVtb3RlX2Fk
ZHIpIiBjaGVjaz8NCg0KTm8sIGl0IGNoZWNrcyB0aGF0IHRoZSBhZGRyZXNzIGlzIG5hdHVyYWwg
YWxpZ25lZCwgaW4gdGhpcyBjYXNlIHRoZSB0aHJlZSBMU0JzIG11c3QgYmUgemVyby4gQXMgcGVy
IElCVEE6DQoNCjxxdW90ZT4NClRoZSB2aXJ0dWFsIGFkZHJlc3MgaW4gdGhlIEFUT01JQyBDb21t
YW5kIFJlcXVlc3QgcGFja2V0IHNoYWxsIGJlIG5hdHVyYWxseSBhbGlnbmVkIHRvIGFuIDggYnl0
ZSBib3VuZGFyeS4NCjwvcXVvdGU+DQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+IFRoYW5rcw0K
PiANCj4+ICsJCQlnb3RvIGludl9lcnI7DQo+PiAJCWlmICh1bmxpa2VseSghcnZ0X3JrZXlfb2so
cXAsICZxcC0+cl9zZ2Uuc2dlLCBzaXplb2YodTY0KSwNCj4+IAkJCQkJICB3cWUtPmF0b21pY193
ci5yZW1vdGVfYWRkciwNCj4+IAkJCQkJICB3cWUtPmF0b21pY193ci5ya2V5LA0KPj4gLS0gDQo+
PiAxLjguMy4xDQoNCg==

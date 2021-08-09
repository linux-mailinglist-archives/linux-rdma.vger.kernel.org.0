Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7580C3E4580
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHIMVO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 08:21:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233632AbhHIMVM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Aug 2021 08:21:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179CH06T004562;
        Mon, 9 Aug 2021 12:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8/INsz9c9vtIPMFCJigVy/5BSksYpXGUXHjIQflRwWQ=;
 b=U1wMjg5Wthua5LGGVM0DYuo46pamdbMaWqK8j18V/dJ8N52SGwfixj/CrXRocKpaFdO4
 tMgLHXRyY+CfFPo8OYtraR+Wcdwf7mqUBkLwv0RsS3jyU3Qunefq6xRdPsbIO9NBh0dT
 UxU03upqL2uBiSpiadsZpsN/h84nE7EI77vw6GMuWd7CaAg9ot5AL55S1+D2+J5ZP/pl
 tbCiTWaovCDDl44RVOqWqq3Dbdstj9QzfEsgrDtRjXnHibJMneosPynueQ/MXp+Vsa/o
 7YlpaXmpnADoOA5FyKGM7yNWTIc8sI0BrX6F5zc0kuXVFvzpug1F2qbZFkcnEZq+WA5W Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8/INsz9c9vtIPMFCJigVy/5BSksYpXGUXHjIQflRwWQ=;
 b=wZi8KQTsBjqS3R3AFWCWxkSsL+OAbjGcE3FjQyaEAF1NsbCBcM47WbbBs5T0aWclT3+2
 Y9Xr5dmz6LbbnwC73DYOkYdyPeqBr1z9c/CCrA3DwMozaL0BUg4VZDyuyZx4jvVI5N35
 s9nVRNCs7DiHJs3z9whTD/rDIUjyVqV3+AxhXeILyh6dgHLHYginIB5z32p/7Hyhz5la
 hA6nJc8aQxKHOhzV9CqI+eiKKx3HGqDiwkWNgAORJxODITbFV2JLq2LYOof2/2P6mnYc
 +8qPOdE/+fOY1dDNiKVGDGqycYeo0ATbxHZFWjNqnJc/gjqTNr08z7MZXW2i+704ZMPm Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17drcmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 12:20:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179CGQVh162463;
        Mon, 9 Aug 2021 12:20:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3aa8qr93at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 12:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKOyKYpDeLTU/Idk6Ho8DLDd6igsvn3US2ElFhjmyckrM6OcYL2VIDqPANDKolg8QYy5MTBYz9G/ZGSeCwaL5bMaVoKmwBu2PSWrKI7gk0Apa4SxSpMt5nzREsmpBKFMJFmi1ytlMe9dNweJ3RUOt1sAmhKAhzViXasHLlH26HCxzeaqBAJ8kd3QANfY/lK5RtDBFA3TqE4VL2deE5fJzyFfXjufLGs2wab2wRE4eCSzPhC9e7+2YlB9JLmrK0PY44eSb0dqMi5/bEMmFuTbre6SLSENbXkp2BaW350ykay1asQzy91ZXLRuSrF5RvYCJBdoQflCJh4Dwk5WCXjHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/INsz9c9vtIPMFCJigVy/5BSksYpXGUXHjIQflRwWQ=;
 b=RsK1FDvh0OFXKC+KgXTGL8AR8L/fxrOuDwgH3IMCAJ1p+55VHO8DOpk8IziHaFnO/ScOBDCMnCjnaR/F0UGqxPTr42mH88MznEzKey/gzy3qwPaRnJfeqThzQza29OuHK8DtxKK4f+WXKQscPgkCYK/5yeriTvKFX8wvu6BIgOw16/F62rOiQGiyrF2HW69hnSN3qYcGQrU1FiW0ErRWOo4xkX0rIk8owSpSjk0QaA6jyhXGYZypHywrq5i3haiV5t1pf01KR/F0IRanJ1UaSbL746u2231TfMp6VAONr2cJKamHVvdg9hPAIfxCoTKk1R1e/WX0KjHsyGIJcLHtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/INsz9c9vtIPMFCJigVy/5BSksYpXGUXHjIQflRwWQ=;
 b=WD7FKL7EokGJ5N5Xg6fmH/yc9wnTPj+HnQgbf3d3rgR3iceFe+a+rSO8YPaYesE1Ra0+F++FuPf4xuUVQTdvsyzXILqpLWWJ3kIGfWNTqcZ3RmrNIQDUIPSlyKA5BCmdrS5VcS3DgOZVmDnSgND72qezRF+xrKTsY9JWnGt9aRs=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 12:20:46 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 12:20:46 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: Revert INIT-INIT patch
Thread-Topic: [PATCH for-rc] RDMA/cma: Revert INIT-INIT patch
Thread-Index: AQHXhKdPFFABWH24b02vuVNm4vFW7qtrKKaA
Date:   Mon, 9 Aug 2021 12:20:46 +0000
Message-ID: <E12A0213-3B6B-4A65-A6F8-008B99B9A6F5@oracle.com>
References: <1627583182-81330-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
In-Reply-To: <1627583182-81330-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1dd075b-cd15-4687-0960-08d95b301df9
x-ms-traffictypediagnostic: DM6PR10MB3977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3977FAC6C95F65C445EAE5D2FDF69@DM6PR10MB3977.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:272;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9HxGCoSObhKG34atx7It4dYS6mIfjD13gLDJrdm1i906AW7pJXjxAPCWXhgGT+ku+/rRSko46Nk1eGD6uYzNIKN2zu9rgW65KI2gvC+MmAQBQrNfkUQ90N5gHyPqIdXwJanZ3tRMCKPgNEHV8g9nEJYehONRoqS73QxA3g0CCLrZ9IGLoF82NUJc3XNOneHjNFed1UO/gW6MS5LDIDediZgTEclbcfDJGHdisXk29C9aj0dAV21Mn390z0PVQxIBJWJXkxq4AdNws6Fx4nueRo+dvWghlf9t0BkKBYrl/vn1T791yo/YospdhFK3oLt3a/yT+bKA3la6Yv1E0HgHpYxzNSKyl2r8WcV4ju/hzN1tzefp4MizW3gg/V4JXTtvJAIcQ0+pc9nmfi41sPGdk3XpM13tad5IGrC9p6JBhzBK6fV/MqfwewxYbVHv2E++Y6YzjaRurNvVb/H14+XneV7JhQfwmjP+uRtnBKBkgY/Dp1MQSNy/9Bcl3qFeOXSneB/sMYqGRNBikkiOK+t+cVXMogp05qM4zaGPzvkti2bqsbvH0ePj3xV+2H4kixsm1C/2lS5RQ6o6qfQF+ja4zynAfmmAFGbVp7BUtGv/C8/VFBAR1zE44magl3tPLyispO2QAis9hD+aeNBvUWPrCyGr76M70dbJBnu+vg6BKr3kGD2QvYWXjBUwIPMYPyM/PwnpVdcsG0YywuxWgIY9QBz/OpwmuAmELxSUTgl6pGpwmUe/usKfxrssO/hYmnU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(66476007)(66446008)(64756008)(66556008)(6486002)(2906002)(66946007)(38070700005)(86362001)(8936002)(316002)(71200400001)(54906003)(6916009)(44832011)(91956017)(8676002)(36756003)(76116006)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(478600001)(4326008)(38100700002)(66574015)(122000001)(53546011)(107886003)(33656002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5LSjN2dEV5MXVwM0pKUXZaK3BsSU0zdWlZS2ovNXYvV2Z1TUhRVllXYWdn?=
 =?utf-8?B?RytnVkFTOFo1MWg4c00wbU9Kd01vWFRFT29kYjJjYUZqUXJGTnM5RVNtVUhO?=
 =?utf-8?B?NGVRR0NRVUh4M1R6ZCt2b0dFU2NtenB5am1mdTBnZ0xpZHB0WTZMVmVUekVr?=
 =?utf-8?B?TnR6dUdMTk1ZNXVsRXI4a1o0UG8vL0Zmbi9xV2JTWU90ZEVnMEVwa0tNZEFN?=
 =?utf-8?B?UUp6TUxuaU5YMmsxNGtYdW1JZlNJamhuRkRNSlhoOGVycm4xTHBBdERieGNU?=
 =?utf-8?B?U3Zkc3lTNmJUZFMvMGdnRGJEMGxrOC85dmFuSzBldDAzamFESmVvMGNWUDRT?=
 =?utf-8?B?bEVNS0lTU01Lb2FNTXliSGMvYmpVbjZMc2VPWGNUUW9IdC9SZ0cwQU9YZnI2?=
 =?utf-8?B?bkllSzJRZXlRTGE3Vzluc2VzSFJzeHlYUDhQaTdkY28yWVhyMWlmQy95S1BF?=
 =?utf-8?B?OUVodTU2clJiMzFGWktaOTdWOXh6SFFDRVpUdnpDamdiT1lnMlUwVjZIaFY2?=
 =?utf-8?B?V3NjMk95VGo0K3poQWlVbWpXcyt4S3JJRUp6WTM4WFFjcjdYZHhKTDcvdWhy?=
 =?utf-8?B?aEQxanBLcW00S1lJRDZ5dHNDRVNuc2R6UWxEcTNVYndrT1lOczZ3M2FaRXR1?=
 =?utf-8?B?enZDY3dSLytBTFFib0ZMSHR2YXRMeDQvYnVuWDdOaG9TQnFHTFNkdFlWWEE2?=
 =?utf-8?B?VXhBZXV0MDZKcVloL0taVlNwUGxFNXBFT3JWdWx1elV2OVNZV05pb1plOFVk?=
 =?utf-8?B?K29BanlrbkhBR3dZeHVzV0RUWk9LSnJEeHFpV0F0ZnJXNXJoVEZWRVdQYkpZ?=
 =?utf-8?B?N1hGMERoSTUydGc3SmpWdzRkczdTdkFra0VrL1lSSjJpUVdmcjZSV0oyRmRR?=
 =?utf-8?B?RGhtVVUzSml6RkhHU2wwYzhLQnJueXZ5SEwrdFUrNmhlcWozbjVjZ0g1THp3?=
 =?utf-8?B?dHB0V2xzazgvR2JZZ3FXNDltUXA2ZWJuRkdjcjYxcHJXZWhqRG41cDFocldw?=
 =?utf-8?B?c0R0QzdIVmZraWtKMCs4QmZodUx1UWw2WnZMT21KNlgxSDZzek9MU01TRlhw?=
 =?utf-8?B?aDF6TnBYNGI4SnlDcHk2TnVjRlhhdlBoWkExRVhyVmQ2dk5NOFJheS9IR3d1?=
 =?utf-8?B?SGxTY3haUnQrdXpiOG9KbDdmREZIUmhOcjRxOWlQNXVCTjA3dVdtdjNtL1M5?=
 =?utf-8?B?Mzl0ZGl0RERuLzZ6Yll4N0tsZ2hrMDJpakpTYUdoaGNtSzFGMnVEVk8ycGl2?=
 =?utf-8?B?M2tVdlpBdkI5R2lTdUlobFRZaWNhcVF0dU5tckM2NHBuSkVEMUJxdzJCR0VM?=
 =?utf-8?B?cnVIUXgxQ1N1VTkzQmx5aFVuNzlheUZndzltVG5MaHdGWnNsZzltUWR2WUJr?=
 =?utf-8?B?ckgwby84dWcvYys3V0Z4ejJDTjIvYjZMQjF6ZlZTWXpaV2FnbTRYZTM3SGdX?=
 =?utf-8?B?MnBGTzI2MWVLdDJwSXpkSlRVY2NlMktjZ2tTVEF1clpaQng0QWc5RnZXNkwx?=
 =?utf-8?B?Vm9JbTd3Y1YyeDBpS0l5Sld2a0NWQjJQN1E2d25GV2NmaFVmT1FZQmdPSDUw?=
 =?utf-8?B?M2xhZHUvLzNkdlpsLzcyNlpZQVVFSXg0eTJVN1ZPT2JlQU00SjVpYkwyREtv?=
 =?utf-8?B?ODBUWEFJZWQ5MEl5WW1YTks4SmdJOWNyU0czZ3MrYnhLTWkvR1pmbkIrTVBZ?=
 =?utf-8?B?eGNicXAxRHFjaTFNL2ErekFwSC9VVEtpS1FWSWU5NGpYQW5scG10V1dGUHpi?=
 =?utf-8?Q?f81jePLk9AUeSRKkrNB3fUh1GHI8pJ0GHxVi4tH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B478E5D6C9A4F64290B73709DFC5C696@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dd075b-cd15-4687-0960-08d95b301df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 12:20:46.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxFXw9Pre+IcJsO0AFzVVJyA36kaxJ8bX1EeO9xHmBDDqipbgwZQE8HahY/nZRCaYEcU5LLuPZBkDnA9DDA2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3977
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090094
X-Proofpoint-GUID: GMB-9OnT4qsu7vGn2bw7s2LcrikHtw42
X-Proofpoint-ORIG-GUID: GMB-9OnT4qsu7vGn2bw7s2LcrikHtw42
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjkgSnVsIDIwMjEsIGF0IDIwOjI2LCBtaWtlLm1hcmNpbmlzenluQGNvcm5lbGlz
bmV0d29ya3MuY29tIHdyb3RlOg0KPiANCj4gRnJvbTogTWlrZSBNYXJjaW5pc3p5biA8bWlrZS5t
YXJjaW5pc3p5bkBjb3JuZWxpc25ldHdvcmtzLmNvbT4NCj4gDQo+IFRoZSBuZXQvc3VucnBjL3hw
cnRyZG1hIG1vZHVsZSBjcmVhdGVzIGl0cyBRUCB1c2luZyByZG1hX2NyZWF0ZV9xcCgpIGFuZA0K
PiBpbW1lZGlhdGVseSBwb3N0IHJlY2VpdmVzLCBpbXBsaWNpdGx5IGFzc3VtaW5nIHRoZSBRUCBp
cyBpbiB0aGUgSU5JVA0KPiBzdGF0ZSBhbmQgdGh1cyB2YWxpZCBmb3IgaWJfcG9zdF9yZWN2KCku
DQo+IA0KPiBUaGUgcGF0Y2ggbm90ZWQgaW4gRml4ZXM6IHJlbW92ZWQgdGhlIFJFU0VULT5JTklU
IG1vZGlmaXkgZnJvbQ0KPiByZG1hX2NyZWF0ZV9xcCgpLCBicmVha2luZyBORlMgcmRtYSBmb3Ig
dmVyYnMgcHJvdmlkZXJzIHRoYXQgZmFpbCB0aGUNCj4gaWJfcG9zdF9yZWN2KCkgZm9yIGEgYmFk
IHN0YXRlLg0KPiANCj4gVGhpcyBzaXR1YXRpb24gd2FzIHByb3ZlbiB1c2luZyBrcHJvYmVzIGlu
IHJ2dF9wb3N0X3JlY3YoKSBhbmQNCj4gcnZ0X21vZGlmeV9xcCgpLiBUaGUgdHJhY2VzIHNob3dl
ZCB0aGF0IHRoZSBydnRfcG9zdF9yZWN2KCkgZmFpbGVkIGJlZm9yZQ0KPiBBTlkgbW9kaWZ5IFFQ
IGFuZCB0aGF0IHRoZSBjdXJyZW50IHN0YXRlIHdhcyBSRVNFVC4NCj4gDQo+IEZpeCBieSByZXZl
cnRpbmcgdGhlIHBhdGNoIGJlbG93Lg0KPiANCj4gRml4ZXM6IGRjNzBmN2MzZWQzNCAoIlJETUEv
Y21hOiBSZW1vdmUgdW5uZWNlc3NhcnkgSU5JVC0+SU5JVCB0cmFuc2l0aW9uIikNCj4gQ2M6IEhh
YWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+IENjOiBDaHVjayBMZXZlciBJ
SUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgTWFyY2lu
aXN6eW4gPG1pa2UubWFyY2luaXN6eW5AY29ybmVsaXNuZXR3b3Jrcy5jb20+DQoNClJldmlld2Vk
LWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQoNClRoeHMsIEjD
pWtvbg0KDQo+IC0tLQ0KPiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyB8IDE3ICsrKysr
KysrKysrKysrKystDQo+IDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiBpbmRleCA1MTVhN2U5Li41ZDNiOGI4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiBAQCAtOTI2LDEyICs5MjYsMjUgQEAgc3Rh
dGljIGludCBjbWFfaW5pdF91ZF9xcChzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LCBz
dHJ1Y3QgaWJfcXAgKnFwKQ0KPiAJcmV0dXJuIHJldDsNCj4gfQ0KPiANCj4gK3N0YXRpYyBpbnQg
Y21hX2luaXRfY29ubl9xcChzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LCBzdHJ1Y3Qg
aWJfcXAgKnFwKQ0KPiArew0KPiArCXN0cnVjdCBpYl9xcF9hdHRyIHFwX2F0dHI7DQo+ICsJaW50
IHFwX2F0dHJfbWFzaywgcmV0Ow0KPiArDQo+ICsJcXBfYXR0ci5xcF9zdGF0ZSA9IElCX1FQU19J
TklUOw0KPiArCXJldCA9IHJkbWFfaW5pdF9xcF9hdHRyKCZpZF9wcml2LT5pZCwgJnFwX2F0dHIs
ICZxcF9hdHRyX21hc2spOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwlyZXR1cm4gaWJfbW9kaWZ5X3FwKHFwLCAmcXBfYXR0ciwgcXBfYXR0cl9tYXNrKTsNCj4gK30N
Cj4gKw0KPiBpbnQgcmRtYV9jcmVhdGVfcXAoc3RydWN0IHJkbWFfY21faWQgKmlkLCBzdHJ1Y3Qg
aWJfcGQgKnBkLA0KPiAJCSAgIHN0cnVjdCBpYl9xcF9pbml0X2F0dHIgKnFwX2luaXRfYXR0cikN
Cj4gew0KPiAJc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAqaWRfcHJpdjsNCj4gCXN0cnVjdCBpYl9x
cCAqcXA7DQo+IC0JaW50IHJldCA9IDA7DQo+ICsJaW50IHJldDsNCj4gDQo+IAlpZF9wcml2ID0g
Y29udGFpbmVyX29mKGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+IAlpZiAoaWQt
PmRldmljZSAhPSBwZC0+ZGV2aWNlKSB7DQo+IEBAIC05NDgsNiArOTYxLDggQEAgaW50IHJkbWFf
Y3JlYXRlX3FwKHN0cnVjdCByZG1hX2NtX2lkICppZCwgc3RydWN0IGliX3BkICpwZCwNCj4gDQo+
IAlpZiAoaWQtPnFwX3R5cGUgPT0gSUJfUVBUX1VEKQ0KPiAJCXJldCA9IGNtYV9pbml0X3VkX3Fw
KGlkX3ByaXYsIHFwKTsNCj4gKwllbHNlDQo+ICsJCXJldCA9IGNtYV9pbml0X2Nvbm5fcXAoaWRf
cHJpdiwgcXApOw0KPiAJaWYgKHJldCkNCj4gCQlnb3RvIG91dF9kZXN0cm95Ow0KPiANCj4gLS0g
DQo+IDEuOC4zLjENCj4gDQoNCg==

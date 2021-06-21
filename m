Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225FF3AEC95
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUPjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:39:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15404 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFUPjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:39:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFW6xQ008851;
        Mon, 21 Jun 2021 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gWT3SxH566KLiz0xiLXpGysckFnkmpqLuJALl7NzLK4=;
 b=kEjRbJyqotyNTwkob/AuYUTQIr3TTpDnsk6IbtQxyBS6961xbDlY++lM4B+KwMAN+xHU
 CsYpBujy549LzEz8sEnX2WJ1xaPqqAvPEsiTpJZCkTq5yof/iuAf+UMeplQ1PSaK5UHv
 4WsRTDrmJa/UdBo58AvBkoP2s6lIMmRLH4/QP/8D+wppIZsc/1RPmJEu6Q8ZGD+6wCQD
 tBGvdZkvC/GOKaKYeOhvL9XtGZWS0RxkD9ve46J8BzrUCXF795tYy3Oy6XnkBt+bwzY4
 2XsVAZ8+/bweg1/eUC3Wo/FYHvfDmQam33BbPi+eN2ukfl2SS60s/lzJkbySwn06EKrM kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39a68y1yp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:37:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LFZNtD078628;
        Mon, 21 Jun 2021 15:37:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3998d61bat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya0IGZXRkjEThxGlKMCPNSTy5++Z/yTu7BuH46Me0sLYycAO9Xn1zeo/1Lder82Yrw/q4j+kW8lsiq/QmeBTRHG3zZe8vwOtE21Pklk02CPWPvnZGad9k12uhh1wZS8ZEUWDB+Yph3q0Ia1/ujLoqJMqoztd2OHP881gMezPbluDOkZb5CMfulcZuhPR3i8Sy6D3L9Gwqg5h6Y+fMFdDnpmMv7NLEspgkwvLtySy9dARk166trWf0dXrB5cklgLN9o670dum4vlF7tHCGiYVbSh/hF6+8x3hIfDubUIdCil53AqgO/wFYUu21kBLRNPG7m8lgSeC8cgTJe6tz3X/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWT3SxH566KLiz0xiLXpGysckFnkmpqLuJALl7NzLK4=;
 b=EEglDt/oOmkay39/G0FXhsyjcH5bBUB5F50eiHJk/o3dPHKtYFamD7TfU4CstbG3uvpPLurCjvWlY3qTWnqjVfCfNYq+7LnNhU+eA7fiZqAlsWquCKOPTeSeXXfORbnlbd/neKaVcqxH8oVN4qr9DQB+fxslMftzha2ICR+bnDuTwZEa8YHxCc3SykHOI/4ZYyB64XIrc/oX6ImZMuPTgTS48juqdJlaY5fba/3dDULxdCl3PLN/yMFjmotFBXGowgSd/B6hfFBzyQxbO5dnK46I0bhp9g+dh9p69T0a7VK0MvUuAaGTcipP6GdVYdQKbUS69SdG2IkQmzdEu6G06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWT3SxH566KLiz0xiLXpGysckFnkmpqLuJALl7NzLK4=;
 b=rddp75bUnd1KOb2R0HK3zevbfl/KRDpovMvmOZvw2tWYcTdgU30PjhDUxjSwD7zPBE5dXn+FpX7YbD0fn/xemCfx2lcCTuLyi7Kkl/tFrX3USi6oCz47dl40ueDMSroHXroIhJBQHsLOn9uOcdd0c2sY8zpd6E958T5WDO6yDFs=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1350.namprd10.prod.outlook.com (2603:10b6:903:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 15:37:10 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:37:10 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsej9MAgAAPW4CAAADBgIAAAS6A
Date:   Mon, 21 Jun 2021 15:37:10 +0000
Message-ID: <E45662B9-4E10-4620-9718-F11BBE36AAE2@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
 <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
 <20210621153255.GR1002214@nvidia.com>
In-Reply-To: <20210621153255.GR1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c77a522-d5b6-4463-b6b3-08d934ca6f71
x-ms-traffictypediagnostic: CY4PR10MB1350:
x-microsoft-antispam-prvs: <CY4PR10MB13503FDE1C7F70D31D973589FD0A9@CY4PR10MB1350.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsEAZwcRZHJOd5dADe8Cf/7fs1YIHSk5kvL88US243VUcTtJtgCJ4t9oqN1pJqHmf3m/6v1iyzrphWE/yVZQ9nhm60iOl7MVYAPGSSZp5LC/fpj0i9Ab5oc90LtRe1Ha8+kW5A/hIF6iBU1YSK1xI6pyFgOqXIpLOwhNUWuRsmMDt6UrzAyIWiolAQbV+VPUhdkaCoWBbgrECMH81znfKjZQJryrt6EH/MUh31SCsaMG8Zvq+lfUuW4dHkRiMSzduRklmWUljwQGEFyUvUB+w+rC1J7kp1/LyGQv/2bZHm/Y29TK3GXqQCIsOrNRSh0fITq9mKUPgvl2wioNZa+WNwvmHU1aypeDpCiibLdLpBSO8nKwlxhF1anxw/jsVDfrGK+TkooOjEWW3qTBymfD5Gd5PFC68fhK3F2zuL+dsPAR+NkEVcuiq6H3VLAIkWEaDIxuGieXbhHn7KkOsxZFUurSZW6gXi1N1CCPj45D1Aj4sKt4EpxPOm89cQERiPp6MszUImmB/YzZxMYMNpsmoQaXkCvVT+6c5q4EwygAuL5lJXzYa4ZkNToOzieO1N3qAgwwV7NK3L4kuBnQwLkCBs3jQQtwYkcGtGB0z3T4YktVKZZ1Owiid3AuGaYtgAfJT9Qv6o6kGy36ldYCx9kc/0vKI94IhCrFw9uCpSGe3XE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(91956017)(66446008)(76116006)(44832011)(64756008)(36756003)(66476007)(122000001)(66574015)(38100700002)(6916009)(71200400001)(2906002)(8936002)(6506007)(66946007)(186003)(66556008)(4326008)(316002)(5660300002)(6512007)(6486002)(8676002)(33656002)(53546011)(2616005)(54906003)(86362001)(83380400001)(478600001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZSbmpsRjZMSDBQN2l5R0lRVFdzZGdtMERHQmluWXlsdDM2ZlV1ZUJkQlox?=
 =?utf-8?B?K3pMMVZYeDkzMHlIVnlSdkZrRjJELzJFUHgxMXhDWk9raU1MRDBWSUJTVUpL?=
 =?utf-8?B?SnBqNy9KZ2RodjdxQjZHUGlTNjk0TlpxUVFsQTIxaFBkcEV5NFdYUGptOXAx?=
 =?utf-8?B?N2FSbW9vK29Xamd5aUREZXpnVXgwYkhrNUV2bjYzbDdQbWRkVUYvQWR6bytQ?=
 =?utf-8?B?bHJGd3VNZXFTMkZEcUJ5NCtiUzgxanlIN1ZWWEdsQUpOWVQ2ZDlmZ3hudXUz?=
 =?utf-8?B?QjU3U2N6dStadnFjUTl4ay9nK1VxZ2xLRUJMNXZLaVBSOC90OUFQb1FFRFg0?=
 =?utf-8?B?L1Nyekxucjg1SmQyS3lYa1QzYkJZY3dtYllIRGxPV09yT1ZGVHdSWFhWalha?=
 =?utf-8?B?M0ZVd1JiMFNWazBNZHBNcHJ3aVluWXdkSVYxRzI1ZUZRQlgrOFVzMGgzRTBa?=
 =?utf-8?B?K2NpQkN5M0d6bnB4NXFYREZ1eFhTQlR1bWpGYXU3RUg0cmxFbXpKS0FXZjZD?=
 =?utf-8?B?L2dsbld5K2RyWlpiQ09jdG5qdGZvMmkwZS9EaGpRdEhvTDVYMUl2cjJDUVIx?=
 =?utf-8?B?cFVFVnV1UU1iZytCY2V5SWNnOXFrMXRsdTVnaWlab1dZOC9lendtNUlmUU5Q?=
 =?utf-8?B?NlFEQkFlRzJPaUprL1FXZmtNajNybm1OMFVLTkdmRGI5ekVhalFlTldRS1ZI?=
 =?utf-8?B?SFMwUk9tM1grVUs5SSszWGZ2SElVbTFMZXlQT1hTMDFidGZBem5OYjlKaVZr?=
 =?utf-8?B?T0c3OW9BZHFwc2J3UkRVcjdVZkliRkVld1I4YWpqdTYrNFRLaUVDSVpRT1lM?=
 =?utf-8?B?QTBlbC83SGZIcjlwTVNGenNIYWJ4NGdLWUs5SHdMbUhCbFcvQ29UMXpyZFYr?=
 =?utf-8?B?MUxGUmJMelU3UW5JMGh3eVBuTzJkWm9uQVdDTHpxUkwzU2hBNzRVSm9UNDlJ?=
 =?utf-8?B?WWNYS2hLZmpqUEJwR0pEUUZZUGs5bGl0Y3R0WkxRNXpNcElCb0srR29LQmpG?=
 =?utf-8?B?NmZ3Q0ZZLzJyb3paUmZUS1FqYzdHRHUvWXRVYjNJMmFrdFlTYjIrQXl3UUpk?=
 =?utf-8?B?VVB6c2pwemp4Wk9ZKzZ3ZldPVFhXZnhKclpMNVA1MnRtYVlZM1BTblo1aFgw?=
 =?utf-8?B?ZEZtM1RBQnN6QUdNUjNzR01vUDRzVkJ1OGUwVHVHdTI5bnlkVFNDM1ZRU2xE?=
 =?utf-8?B?NmhiTWx0WXQrdWxCbWd1QzVVQTVOdmpPQm1id1BidlJPamdFRU5qS3VNSE40?=
 =?utf-8?B?ZDZrNlZ2OWJWR3JRb0R3c0oyVHFmZXN2ZnJ2NytLVmhyZTBMRXZWZFhpUWhL?=
 =?utf-8?B?cmJpMU5jdWFCZm9TelVHcWx3NzNrUFFwSGtTb09GUm5TNlRUTUpSTTkvR0Ju?=
 =?utf-8?B?aUp2dW1SVXl3UHEzYXZkZzhVK0tGYmprUFlWcVlPZy9RRzBVNzR5OTNqb0xI?=
 =?utf-8?B?Q1pteHhoVHJ1NnMvZVFPemczbUtjOTZVbDFvMnBFQ2RxcFFOSmJzaXN2dCtY?=
 =?utf-8?B?S1FXbTM4YnlPQ2pJK3A0MXM0aUJ3MHZHV1pkbldOK1hYSWFLa3JkeEdoQzYv?=
 =?utf-8?B?MDdCblAxQUgydnZHRFlHVm84NWZjR1o5WXIzWmYzUzU3eU44VU5yL1NLNzlE?=
 =?utf-8?B?RWVWeTBUd3VlR291dXdlSGNYS2FiSktTUE1XRkpUeVduM0gxYS9VQnVWNndP?=
 =?utf-8?B?cmpxYWZLMitPWHpnMTg1U0JXV0xHL3NDNjVtU3lxck83c004VnVzRTJFZ1Zh?=
 =?utf-8?B?YjdjZFh6aUR4WWlGZ1B2SnBFUXdnNHlaa0Z4OHdJLzh4WmtpRUZVVTFBUzZl?=
 =?utf-8?B?ZnhzNlhPYnZLUHJkbTZkUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8434F1E47587B64BBE58EE094BA52B51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c77a522-d5b6-4463-b6b3-08d934ca6f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 15:37:10.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yB3c3aWLfFsBkGXrAX2hT1AL6+seFH1cm4Id6NKIYkleL3z4C7qOkGwknrnUYFG2Aybd9LkThY7JKIoWc00kfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1350
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=993 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210092
X-Proofpoint-ORIG-GUID: I9JCclPHfEzBBpYWx3FglGzdIlnSn2dw
X-Proofpoint-GUID: I9JCclPHfEzBBpYWx3FglGzdIlnSn2dw
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDE3OjMyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDAzOjMwOjE0UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMjEgSnVuIDIwMjEs
IGF0IDE2OjM1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIEp1biAxNiwgMjAyMSBhdCAwNDozNTo1M1BNICswMjAwLCBIw6Vrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+ICsjZGVmaW5lIEJJVF9BQ0NFU1NfRlVOQ1RJT05TKGIpCQkJCQkJCVwN
Cj4+Pj4gKwlzdGF0aWMgaW5saW5lIHZvaWQgc2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdzKQkJ
CQlcDQo+Pj4+ICsJewkJCQkJCQkJCVwNCj4+Pj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGlt
cGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8JCQlcDQo+Pj4+ICsJCXNtcF9tYl9fYmVmb3JlX2F0b21p
YygpOwkJCQkJXA0KPj4+PiArCQlzZXRfYml0KGIsICZmbGFncyk7CQkJCQkJXA0KPj4+PiArCQkv
KiBzZXRfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBtZW1vcnkgYmFycmllciAqLwkJCVwNCj4+Pj4g
KwkJc21wX21iX19hZnRlcl9hdG9taWMoKTsJCQkJCQlcDQo+Pj4+ICsJfQ0KPj4+IA0KPj4+IFRo
aXMgaXNuJ3QgbmVlZGVkLCBzZXRfYml0L3Rlc3RfYml0IGFyZSBhbHJlYWR5IGF0b21pYyB3aXRo
DQo+Pj4gdGhlbXNlbHZlcywgd2Ugc2hvdWxkIG5vdCBuZWVkIHRvIGludHJvZHVjZSByZWxlYXNl
IHNlbWFudGljcy4NCj4+IA0KPj4gVGhleSBhcmUgYXRvbWljLCB5ZXMuIEJ1dCBzZXRfYml0KCkg
ZG9lcyBub3QgcHJvdmlkZSBhIG1lbW9yeSBiYXJyaWVyIChvbiB4ODZfNjQsIHllcywgYnV0IG5v
dCBhcyBwZXIgdGhlIExpbnV4IGRlZmluaXRpb24gb2Ygc2V0X2JpdCgpKS4NCj4+IA0KPj4gV2Ug
aGF2ZSAocGFyYXBocmFzZWQpOg0KPj4gDQo+PiAJaWRfcHJpdi0+bWluX3Jucl90aW1lciA9IG1p
bl9ybnJfdGltZXI7DQo+PiAJc2V0X2JpdChNSU5fUk5SX1RJTUVSX1NFVCwgJmlkX3ByaXYtPmZs
YWdzKTsNCj4+IA0KPj4gU2luY2Ugc2V0X2JpdCgpIGRvZXMgbm90IHByb3ZpZGUgYSBtZW1vcnkg
YmFycmllciwgYW5vdGhlciB0aHJlYWQNCj4+IG1heSBvYnNlcnZlIHRoZSBNSU5fUk5SX1RJTUVS
X1NFVCBiaXQgaW4gaWRfcHJpdi0+ZmxhZ3MsIGJ1dCB0aGUNCj4+IGlkX3ByaXYtPm1pbl9ybnJf
dGltZXIgdmFsdWUgaXMgbm90IHlldCBnbG9iYWxseSB2aXNpYmxlLiBIZW5jZSwNCj4+IElNSE8s
IHdlIG5lZWQgdGhlIG1lbW9yeSBiYXJyaWVycy4NCj4gDQo+IE5vLCB5b3UgbmVlZCBwcm9wZXIg
bG9ja3MuDQoNCkVpdGhlciB3aWxsIHdvcmsgaW4gbXkgb3Bpbmlvbi4gSWYgeW91IHByZWZlciBs
b2NraW5nLCBJIGNhbiBkbyB0aGF0LiBUaGlzIGlzIG5vdCBwZXJmb3JtYW5jZSBjcml0aWNhbC4N
Cg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gSmFzb24NCg0K

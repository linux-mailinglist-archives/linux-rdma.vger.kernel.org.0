Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C585C3AEC66
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFUPci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:32:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhFUPch (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:32:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFG9pp020941;
        Mon, 21 Jun 2021 15:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uidA3vVgyOUXiZnSd6TRj8AC0QDZLhRbKv28MqcZxz8=;
 b=EFuxvM0XM4oFyEjJOO0VXXoy4TIcnzQmmSyTXpJxzhdhsmTb0fWzbbVBqKrkA0dk8k8m
 jydgXWz3L0wbkCpf7YP1UrGKlV+aGNbxoPH5769wBtgOxW4oYK70oyq/izevqH9LGY0a
 ySv1arlQGFwv86PHlaP3VvM288tc+7v91JzyINhFAtNWviv7uB0do9f0nA9phOfxeL7N
 MotiYlB9L8jAS3Wk6ibif2g3wqLUm1BQosTzGeXTYRZcTNSsr4Dz6G7O5yXTcVmXnEi1
 ysy79fdbrhYe4zjHzkQcaOgX7HHBvHEoMQkuB+NoO5A3iSxvZFmPotkOae6r4fQy0u6L qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyq9p4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:30:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LFFpEg139368;
        Mon, 21 Jun 2021 15:30:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 399tbr5hne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6D1Ysm1jxiWMpKxJ272gpViS4eGX0Vdoocj5NjZ8cdWy5AZWTEZJLHguf+/sl8G2LvqrZ5U4bHsbD53nMv4M2GqS9Oi8PAtgkGFXeLqgJEDNHFoPzajmxCDUbDQp3ss/pq6we3JjAOZUaaJeWG4XNXwkpTNDKIwEM1igpoW6BwmhsQySYeJEGoO+o3RIHHQh1tH2IgQMpLLUUgTKv/85SQkx8sIk0n/Xp4/y/t8ZmOnQsiWe4ZEDRMt0oo7YKFMucfOiuqsv6xVQl3JZ8IZEnZA2XOXLCB7lwLn1r8eaMYW+JObPEDQK/nYsPGwvAgSwN6uODumuebwRqzjfjbxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uidA3vVgyOUXiZnSd6TRj8AC0QDZLhRbKv28MqcZxz8=;
 b=j8j+6PCK73mKt8TD5WV1jWkgydTrBoAA0wnhaTwQcen9/o6i5loTJF/2BzZ7hFA6POb4WVHlccVn06cgnwSExpGWHuGyr5o7BCuGgvzVL9q3OjWlkAmU779cRsz5sjVm+1sbpHD8qzkTA3vgSYGsJ7H5uypCAvxJwwh/RvFRqaalLE2BQTKJiI7QwB8ZgHYXzQ3hUgTg8s3iWLT4HToP0zD4gDb+FfC64jjZGp+43GbF24hT2o1MNo0CTu20JMS+y4rVq2bxSmWzMFRfaCrt0ineQcNiWqK2uFqmO9TJlUMMdJOGqux/pDNtcWZQ7KBY7TGP1tQ+T4QTH/iXySkK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uidA3vVgyOUXiZnSd6TRj8AC0QDZLhRbKv28MqcZxz8=;
 b=H1m08nNotejBBPhuBhmo/5PRM2KgZwWYVJhJzkLijPgMkoSvPCLC+xldAnUf3g2T3RtrN6SuRU4IMnY9wxZZS6iAqgF34B71UbVhllINbnUI6I3qJ5CDtx0bSpLtvUUmLRHgqFtszEnoe6nOsE7788iBDs4wS0zbahX3+3KYABw=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB2006.namprd10.prod.outlook.com (2603:10b6:903:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 15:30:14 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:30:14 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsej9MAgAAPW4A=
Date:   Mon, 21 Jun 2021 15:30:14 +0000
Message-ID: <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
In-Reply-To: <20210621143516.GO1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee918a73-3531-45b5-1448-08d934c97792
x-ms-traffictypediagnostic: CY4PR10MB2006:
x-microsoft-antispam-prvs: <CY4PR10MB20060C4608A9230815038D44FD0A9@CY4PR10MB2006.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zy3AwUEuQGg9BGVYOrc4JAWB2CbwSNdLYg4FpPnIWv0nur8K1bblZ16WWndpzdtAdyOUztm1MObF/AlBlfnUf6K7HOpHE1T8l4nMB6ulHEiupDVxlM3Gr/FydFJR+ZXljlpanVIFA9HgVil0btneLg/UQt2NKl6q0Z7hB84QlZ6nRFCi8HEKPx3pq1rMt+HaQJTvwMJa2DlK0TdAC4mFYjVsSMGvA9c3s+4kL9BwFmY+HO7SH7ZNJbirUQOLbXwA9b2KjV11FdijzyOxRRXYhefzroR018lmVyOLQq2VCyBOxE5hgJhkrzMShvCDOEF/hYYiTgNBuK8JLVJQnZ+XRclBpxwX6L7QqL1Nvp+bZFFz5aL0nvjSH5dEPk0nmrv40GbIwrr7sEbDL+5XW9e68VY7clvsnWuSZmcKKwk4JtA9JaEGYqU3+coZUpoAvUUgmrhIOncQueEl59YMblhqSsOJgmQtmjRWCs6Xadf23RSunH6tHIPxTCQVaYpg9AuEtsxmJpvI7UJ7uIAg61WJFUqXqCEinGe3YdDr0VcrWWIolTLsE56qSvqbyJM+G928KEOSGQiaMTrFaULRZJn41qcJlFs2hGNaiOgLAaOYTAxRbE9w50Y6L9q9HjLj8MxUR+XMNjbK8Bcz62mjRErZzB2Hxl5sJ3VP+8SBXajS0z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(71200400001)(6486002)(86362001)(76116006)(66946007)(122000001)(64756008)(66556008)(44832011)(54906003)(66446008)(36756003)(66476007)(4326008)(2616005)(91956017)(38100700002)(478600001)(5660300002)(26005)(8936002)(53546011)(6506007)(8676002)(66574015)(316002)(6916009)(6512007)(186003)(83380400001)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dER5elJtSGw0dzE2M2NzZXg3U1RSMDdsbXVWMkdpOWhLSmYza29BZHVWaHlV?=
 =?utf-8?B?ckxMZVF3ZFBkL0dTbVA5eVRTek5kZzRqSzdvNW16RGwvZ29LVHZpeGdoZWd4?=
 =?utf-8?B?SWUydk5VZTBGa3NzRWsxSExiYS9jRHRKRk13UytnWUM3Nlg1NlRKbUFReFB6?=
 =?utf-8?B?QnJpd0xtbHozdUJuS2ZhYUhLVExYN09PNXVtSVgwLy9JQ1BrNUJqL0VVUVkv?=
 =?utf-8?B?aENzRGQ4S0VERkEvZTg2RHNobkozaE1RZnlldlY3OXU5SlZRQWlsUnh4N0Np?=
 =?utf-8?B?NFBjZDBtZGx4akZUNVVwOGVtRjI3Y2Y0c29CU2NiYlp0MkhmejRvaEJYNy9U?=
 =?utf-8?B?bFRjbElReWVsdEFNdUtodkk1RGRuTjRmUklGSkVCNk4yM2lkOVU5eGd6Rnhu?=
 =?utf-8?B?MnEvYnVwQk9rYkp3R3ZOc01OMFcrYU94WGdudEkveGZHMW4xT2ljdWZWQ1Zm?=
 =?utf-8?B?M0lROFpwcmZuNkVmZXNXNnB0ZVFtRHdSYjNIbzFLaEpyRUFWdkZ3M2VJTkcw?=
 =?utf-8?B?YS9LNGxMUDRmYnlidG9ENmpEcUZwYlVxZ2s3S0RVUkdFWlBzMnpKakhoN3Yv?=
 =?utf-8?B?K0hqSER3Z3NrUDFYSFcyTlViazh3SER4U01OQUxRRmVTM3RHaUMvdnZhRUc3?=
 =?utf-8?B?anlLVE5ISFBoVis5YVROMHpaV3NDVTBmaGN3TnZDVjhYRldURXd0aGg4aVlm?=
 =?utf-8?B?SzFTN2Q4YWlqUlBaKy9XWFU0ajNYNm8rUVpkNExYbWU1dEUxL1NDMWVWMGE0?=
 =?utf-8?B?Z09NZEE1bitHUDBFOWt6Sm0yRVdIanZsdUVPTDRRRE1BZjkwNkNxbWJNMWl2?=
 =?utf-8?B?bUpZQVZYL3NtMnB1Vm1mbFltQWR6bkQzQkhCU3NGUzdxME5lc3pzemNUODlp?=
 =?utf-8?B?dkZYcG1sbkFYODlqMW1HNUhScTl5dnIreEtzelk4b1FHSitVNmk2aDBDcmxI?=
 =?utf-8?B?NGNnMTVsaFEvS1JnUEF3MEV4alhDbHZKUXd1cjBydjV5T2NwUzBBTnhvQnpk?=
 =?utf-8?B?ZGM3c09BaHo4YXpDTUd4RWo1YXkzVS9jSkZmQmFTNjFWdm1ZRVl5MGUzTTY2?=
 =?utf-8?B?Y1lLdUszUUJFVkIxWVlTaVZHL2VVZGdMaUZMR25GZDBlbnN4cC9GdGJtNjR4?=
 =?utf-8?B?R0xrbXFVdnpoSjJCRldwemM0a0ZpTkdqYnN3WERFbHl3aVpsMk1FaTlVemlR?=
 =?utf-8?B?OUhhYVlkekN1aFZkc0w2aUtLYzVYQ0tzTjFjNmRWWjRBbWRzSmtGYjNQUVJ6?=
 =?utf-8?B?cVVkTWdEdEFSd3ZkN2s0U3BUdFlTQU5Jcms0VnJLaUtVR3FybUhoN09NdFdu?=
 =?utf-8?B?c0NLeUJsZnhFUGh0bWkvdDhpVWpmSEtnT3FsMUErNXVoVUVteWNqbk9IMDFi?=
 =?utf-8?B?V09nYmdZOGdQSHZHckNQQW5xMzJIY0hxRW1tWU9jU2lQZmE0UXpVTm12WnRD?=
 =?utf-8?B?ZnFNN1QwOG9hNlB4UnByMU5xVzlORkxsY1Uxa3ZRK3BoV25lRkxqQmg3U3hl?=
 =?utf-8?B?bjNiVTMrelFrVGtJOUhxMzN3YmlzelhWN0JMT28xWjI5Ymx1b0VSM2FvdXlk?=
 =?utf-8?B?d2VjVEpZY2VIZXIxaUVoSXEwcmhqRW5JZmhRYzVlUGdYQkxsaUpyRmxVWnYw?=
 =?utf-8?B?b2lUT01ETDIzL0xQNUE4RE1HazZJRzhBR1JiSE9hT3pqeXNnQis0dXBzbG5o?=
 =?utf-8?B?UFhtSU1KMXgvTzJIWWxyRXl2c0JIY1loZDBJU2JQZ1hQblN6RUlsVktpRW9R?=
 =?utf-8?B?RkVUc0JNaU5aem9lN0Zqem8xZktTQ0ZsNU5iKzN6ZzVYNVVQd1FhK0pUWVd1?=
 =?utf-8?B?a2VtWVRBd0tFeXdBMmFnUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA4EB279911A534AAE39B9F006357A04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee918a73-3531-45b5-1448-08d934c97792
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 15:30:14.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z31jOXWQmkvpOaCBeoowz6ytJiL9NJk7MZ5xDSgUY7wYRHWkI5BhPczEV2URm1CsJiK+7imcHXZREXTUv9x7qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210091
X-Proofpoint-GUID: EYlMFD-YC1LTkYCV-jDdX_HZuqs_TVKw
X-Proofpoint-ORIG-GUID: EYlMFD-YC1LTkYCV-jDdX_HZuqs_TVKw
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDE2OjM1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDA0OjM1OjUzUE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+ICsjZGVmaW5lIEJJVF9BQ0NFU1NfRlVOQ1RJ
T05TKGIpCQkJCQkJCVwNCj4+ICsJc3RhdGljIGlubGluZSB2b2lkIHNldF8jI2IodW5zaWduZWQg
bG9uZyBmbGFncykJCQkJXA0KPj4gKwl7CQkJCQkJCQkJXA0KPj4gKwkJLyogc2V0X2JpdCgpIGRv
ZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8JCQlcDQo+PiArCQlzbXBfbWJfX2JlZm9y
ZV9hdG9taWMoKTsJCQkJCVwNCj4+ICsJCXNldF9iaXQoYiwgJmZsYWdzKTsJCQkJCQlcDQo+PiAr
CQkvKiBzZXRfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBtZW1vcnkgYmFycmllciAqLwkJCVwNCj4+
ICsJCXNtcF9tYl9fYWZ0ZXJfYXRvbWljKCk7CQkJCQkJXA0KPj4gKwl9DQo+IA0KPiBUaGlzIGlz
bid0IG5lZWRlZCwgc2V0X2JpdC90ZXN0X2JpdCBhcmUgYWxyZWFkeSBhdG9taWMgd2l0aA0KPiB0
aGVtc2VsdmVzLCB3ZSBzaG91bGQgbm90IG5lZWQgdG8gaW50cm9kdWNlIHJlbGVhc2Ugc2VtYW50
aWNzLg0KDQpUaGV5IGFyZSBhdG9taWMsIHllcy4gQnV0IHNldF9iaXQoKSBkb2VzIG5vdCBwcm92
aWRlIGEgbWVtb3J5IGJhcnJpZXIgKG9uIHg4Nl82NCwgeWVzLCBidXQgbm90IGFzIHBlciB0aGUg
TGludXggZGVmaW5pdGlvbiBvZiBzZXRfYml0KCkpLg0KDQpXZSBoYXZlIChwYXJhcGhyYXNlZCk6
DQoNCglpZF9wcml2LT5taW5fcm5yX3RpbWVyID0gbWluX3Jucl90aW1lcjsNCglzZXRfYml0KE1J
Tl9STlJfVElNRVJfU0VULCAmaWRfcHJpdi0+ZmxhZ3MpOw0KDQpTaW5jZSBzZXRfYml0KCkgZG9l
cyBub3QgcHJvdmlkZSBhIG1lbW9yeSBiYXJyaWVyLCBhbm90aGVyIHRocmVhZCBtYXkgb2JzZXJ2
ZSB0aGUgTUlOX1JOUl9USU1FUl9TRVQgYml0IGluIGlkX3ByaXYtPmZsYWdzLCBidXQgdGhlIGlk
X3ByaXYtPm1pbl9ybnJfdGltZXIgdmFsdWUgaXMgbm90IHlldCBnbG9iYWxseSB2aXNpYmxlLiBI
ZW5jZSwgSU1ITywgd2UgbmVlZCB0aGUgbWVtb3J5IGJhcnJpZXJzLg0KDQo+IFBsZWFzZSBzcGxp
dCB0aGlzIHRvIG9uZSBwYXRjaCBwZXIgdmFyaWFibGUNCj4gDQo+IEV2ZXJ5IHZhcmlhYmxlIHNo
b3VsZCBiZSBldmFsdWxhdGVkIHRvIGRlY2lkZSBpZiB3ZSBzaG91bGQgaG9sZCB0aGUNCj4gc3Bp
bmxvY2sgaW5zdGVhZCBvZiByZWx5aW5nIG9uIGF0b21pY3MuDQoNCk9LLiBXaWxsIGRvLg0KDQoN
ClRoeHMsIEjDpWtvbg0KDQo=

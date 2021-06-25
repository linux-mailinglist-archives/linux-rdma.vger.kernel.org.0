Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429EC3B3E4E
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFYISK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 04:18:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4974 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhFYISH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 04:18:07 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P87SIw001725;
        Fri, 25 Jun 2021 08:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XbgT5skYhJOCmEdHJB2h0CZB3uiLC2PruEG1NaS23+o=;
 b=tWgLHvJcLlwgikJ+1VWbC5bOM5IkpsHwPbQfi2xWYjDtPNRXT4QN8OETfjBDO6cFg9an
 /CmIR1+KmEhOuaANJhdxQrqngPMlsS4zt7anE+Xunt+yOAVkAKo1HTycIoOKZzHw0+nH
 BkCOuyw735Y6Y/X6WSGippxUC3QATMHVhP6G5Jihe2T3/eiTIP0ZLcQlho0tXIFBSmSB
 f7zeHh5ZKx5oGrWd+iPWdtODiBilP7ypdemcFynuGIWDsrG4Ww6RIX9FBY/N8zAlNM46
 n6RsuZUlcInJs+vNpfpJW6rYfC0JthqYVFmrF74f2vgsu2pfFLwcKWjEGTRJIxB2ZlSD Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24m0rwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:15:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P8FYYr004852;
        Fri, 25 Jun 2021 08:15:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 39d2435b0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syi9HQT9VIUIFuYWH3XpaiaivvBNg6JB+zF//cw46GGUSfVlMhnETUg8/GFWCK4otv+//NZK/yCaODdWfQe8aThTRgNymDloa0NpBfR9B7kICORDw+bPUrnb8lwDWSRaJG0/g3H2Y9eyRaB1KC1Cp2YzUhVm1/SRQ7IVtRWqGMUWMCJqPQNQSwBaIPF4NYM4dxARO3XkWwKOKAx7ivp0GSJTS+9SqtoQ+q/pq78HnPBWfrHmbY8/3qLh6uCh6YCSlYzqBymWA53zppHzQ9Uo/9xsd+e92/1pB/vI/a/GUfaJwnutoKhYdzkkI0so8OtAATLpZM0J0f1x4zXOjzaf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbgT5skYhJOCmEdHJB2h0CZB3uiLC2PruEG1NaS23+o=;
 b=JlBF7a9dzPwcDhPGD6NrcFy7Cc6j/F2x6giAHdPHkt5B7zTYOwoy5gM4of+s2HtZA5xoqZ0e8LCGQrmSOYOTtqqUlQELHMzQKVnn3qWt5KMGfOXbfZRbboeWmkrkQbYvZDy0lrt39Z7FMyrXTimwQNLrcwsnI+pNV1W2YfHdoCCMcGPCuGwJyzXAPpuguNigrPrqPR+C3wpgG3nSTaPdRjIgHGQfOf9RQRpGJ2+UUTRwPzFbA24vugAKgOA7+R+pMpfam6tmhCA+fTsoWciQg6jWBL6AiTMrZQPNngT8wa+BLOt/18wuXkwRlC4VSzxEpsRdz74onLGVKLq8+hsSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbgT5skYhJOCmEdHJB2h0CZB3uiLC2PruEG1NaS23+o=;
 b=L3jAGQL2M1wbHTcwfUNfFnklFyj+gkNc3NdzTb1PNpkxjBrxxw5LZRjBHHKm0DdbBrYOZLeksmdiiJISUxk8gP/UVvMxSqTWZpL2eA3BIbwtt8LFtPm8objcyPrLdrN3CP0CpXicBtYm07rqIMzNX4HVkM3D+JmdgbCtv1xf58g=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2376.namprd10.prod.outlook.com (2603:10b6:910:48::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Fri, 25 Jun
 2021 08:15:38 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 08:15:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     Gerd Rausch <gerd.rausch@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
Thread-Topic: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
Thread-Index: AQHXaSqatidV+FsmHEOA4sulf8nOG6skOU+AgAAo54A=
Date:   Fri, 25 Jun 2021 08:15:37 +0000
Message-ID: <01308789-6709-44A5-B876-088B0FBFCB7D@oracle.com>
References: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
 <27a35a75-813d-ef1e-c9ca-d4ecbc5a95d2@nvidia.com>
In-Reply-To: <27a35a75-813d-ef1e-c9ca-d4ecbc5a95d2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b5bd7ea-d1f5-4ccf-663b-08d937b16a42
x-ms-traffictypediagnostic: CY4PR1001MB2376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB23765B306308D572595ECDBCFD069@CY4PR1001MB2376.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2L08E8hq6uIoErpwtkVMbNJQT3CFsDjiVX8gUPq/aioPCt+tOpZKm4U1eKM3ASm/P6r9dBH/tu2lR5jxLSBdh4U1XXp79VmpNBxB7b9u/UjmhoNEYR0OQb1Cu/I580WTCvbdjUfQIWbHLGS6thBw/YCB+uninJ3uAVIlpfpL5Waj33X+zWFYM0s7dIOp+gwKQpykANpNDG004XHemJ7HLiqPjKu2BPvGnnu9UwJJUGpVtLNitbWqDLlTIjr1F3Lb4aNwgAHDs9CYmeQpFCsy07XI2FCmvXu1Rf/1UTfUDXj/6DhhvciEoFQx+EMmMRldFlttYvTsTdy3sok76Z98H1AYdsnxs7l4olPTqkfBDUq8oX6Y5Gfn3bc8QlkvciV20ppp1q9VpLkLWNBVWrGc8BQjG9ypedo0CikGpVYtBUoDAdg9JgEXGlQM9a/du8UqDzI2MMJe8cejVmn427jMGRZHSUCcsAKhTmQ8biw8pmoU0crV5tWSIYiZRp5EP10QJdbgFQSf14Tjem+3MbKlYLzyZtPuwgZhmbrNXr6s6QH2KQF1bPL7OES41WixHHIKkbLnjKDDUNehWIWbVbT7V1CqhURUhG2N8pybt40tHEugtD3OpK+ue/tDFRo80Z8WK0bUShvM9aigA17cK7T1kAkA6gWJD7hdYyhIzqmzz5QTup6O51BsbhYxzjoyKyhyVQ3BKl3hRhXQqIson8QQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(186003)(26005)(83380400001)(33656002)(6486002)(122000001)(38100700002)(53546011)(6506007)(4326008)(86362001)(66574015)(478600001)(66946007)(8936002)(91956017)(76116006)(66446008)(66476007)(66556008)(6512007)(64756008)(44832011)(8676002)(2906002)(71200400001)(6916009)(36756003)(54906003)(2616005)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1hkSTlHdUdkdlhQWmhEWjhtM0hyTG9FS1NaQ1I0SndVRTcvZVFwVEpEZDlF?=
 =?utf-8?B?RHBERzk1Um9PVTFKdjd1VVVSWDY0STc0bXowenVIajltVkt0cC8rRWY0Q2Nu?=
 =?utf-8?B?YkZmWTB4ZGNndU1kblZpR3htNUJUcklXYjdzNWdoOGRUM1UrOENWY2MvSEYv?=
 =?utf-8?B?eVo4dUNyYTE2WjhVR2ZweEdJYnl1ZzdacGlZVUd5T3dsYmJlODZXZzhmYWkv?=
 =?utf-8?B?TTRuWmUzRnl2Wk0zamZrcG5BZThQNDJZTjNmOGxNSkZtdGliZGxjdnBqZ2py?=
 =?utf-8?B?amoxell6MmNhbXNLUGpVdEQ4eUV5emUvYVlxOUp6SHRmWmJKc1hiaDRDS1dJ?=
 =?utf-8?B?L3Y4MkViQlJ6S0VYMzN1M1BWb052QlpiTzFGdlRYNnlXUWJtL0RJVU1ZNnF6?=
 =?utf-8?B?aGVjclRtK0hhUkhjemt4eGdEOTR0cmF4bFpVa0NQcUdvajVkRkhPSHdFMmM1?=
 =?utf-8?B?Ky9Tem01TzhrK2JMLzd6Qit5d3lCdWMxRjRna0s4Wi9YdU5ZaEE5T3BiZ2R5?=
 =?utf-8?B?QzlWeW13MkFNWEMwaVNQYW1aa3Q0WkVuK3BWcGVURjZmTlp4SmF1eDlUNnlm?=
 =?utf-8?B?OEFzeW1rUmh5dHNGa0x3bjZOQks2VFpqSDc3RDhzQjJWV0c5YXJSL0IrV29s?=
 =?utf-8?B?cUpQR0IrNHlNS3FSVXlQSElTbFk4ZmRIZ1E2WjlTK0MyRkhIcUkvTVh1UWR6?=
 =?utf-8?B?LzVCWTVLcUc3ME1LUDBQLzY3bm42dlVTSTY1UjNuSWQ4ckcrTDJEajhHQzhX?=
 =?utf-8?B?MkN4ODZtZjc1YzhMMThkVGh3NnRTUmhPT3dUa3NiL1AvV3U4bU5UYUZ0WGQ2?=
 =?utf-8?B?QTl3MXNmUVhtMEpwd05sRnhLcVJqNVVkcFVSa09vS3R5MHRoUlM2SSswenh5?=
 =?utf-8?B?aElSZEh6RHd5MGZCUC8vcG9rbmN1YnZwK1NBMkRST3R0ejY4WHpiOHBGcWN5?=
 =?utf-8?B?aCtZand6Z04weXA2ZS8zZkdTektrUzVEeC9EdzNqYWlpU3R2b24zNm9kRk51?=
 =?utf-8?B?WGc4YXpPUTkwb1hyN0FzZ0RtVXR4Y3V4dCtzRStsWXkwK2hTWGtnenc5S1BI?=
 =?utf-8?B?d2pHaW1JRW5qS0lwNUlOc1hCS2ZSY2gvYTBFSjVJa3lJNFJGUTdDWkJadEpK?=
 =?utf-8?B?bzJ0dkt5WVFUSkZGTXg2ZTVLMXBlUmxQK0k4TDlERUhLL1NaSDl1WlZXNFgv?=
 =?utf-8?B?TUZ6dE1oQkpJMjVUQjQ4dHVSTFZEUUZxVk5ualYwbjE0cTZscEhxVGlNYzVN?=
 =?utf-8?B?RitmL2MwMHMrcWNNV2xIeGFyZTZVSGFUVitDaGx6QjgzcDg0RHJxRHZOTFJy?=
 =?utf-8?B?T1hPdlJ4M0g4N0ZrdWQ1T0VlczF4WDlCR2J4dW10azd0Q2pCOGhRRGtOUGN1?=
 =?utf-8?B?MWZWTyt5Zk5RZGNHbjZOREE4R3hXNWgvV1I1QnAydVZ4TStWY3VIaXorNlBO?=
 =?utf-8?B?VHdjS2ZkL3pQVzBSNlZmWTdsUmFjRmdKaStnM3Fpc3grQzZqVC9rRjRZc0Qy?=
 =?utf-8?B?Yms3S3FKTk9sbHQ2c0s4WlljUXJXa3BTVENrdVIrckE2Qm51dFQwT2piWEg4?=
 =?utf-8?B?VkVQRkZZKzFqUXJRZkgxMUJmUlVGUXJ1Q3NLMTZJWkJqY2lzOGswTkswMkI1?=
 =?utf-8?B?K08vVlhLdC9LRTBmdzN2TzJuektsZE5uVnZWM1NLRUsrc1hKVVhLUFh4Rm5j?=
 =?utf-8?B?NzJpUjFpUGZQVjdjeG1vUnJkZzdETmZqLzU1ZDArTE5ad0JoTTBNMmV3Tm1R?=
 =?utf-8?B?RDR3bHVQZDQxLy9ETHBkVVQ0UEdYd0M1RytRUm5iVXB2YjNHUkxpV3NBOTZG?=
 =?utf-8?B?NlB5RDh1MXNnbUVDT2tPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <297FC2A3E9FF6747AB63C68ECE66BBAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5bd7ea-d1f5-4ccf-663b-08d937b16a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 08:15:37.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0le7osX+Yk86tEbcR0Li/F95qI1I/I2mZ7f+LNlJFhXFOUMbsan8m0kuaV3NIgVGKkmBOMxhKQU+wInk5fO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2376
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250048
X-Proofpoint-ORIG-GUID: Z0GGMAsRNpV3LDNUrqI-lZXQMum7AEF6
X-Proofpoint-GUID: Z0GGMAsRNpV3LDNUrqI-lZXQMum7AEF6
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjUgSnVuIDIwMjEsIGF0IDA3OjQ5LCBNYXJrIFpoYW5nIDxtYXJremhhbmdAbnZp
ZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA2LzI1LzIwMjEgMjo1NSBBTSwgR2VyZCBSYXVzY2gg
d3JvdGU6DQo+PiBGaXggYSBtZW1vcnkgbGVhayB3aGVuICJybWRhX3Jlc29sdmVfcm91dGUiIGlz
IGNhbGxlZA0KPj4gbW9yZSB0aGFuIG9uY2Ugb24gdGhlIHNhbWUgInJkbWFfY21faWQiLg0KPj4g
U2lnbmVkLW9mZi1ieTogR2VyZCBSYXVzY2ggPGdlcmQucmF1c2NoQG9yYWNsZS5jb20+DQo+PiAt
LS0NCj4+ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyB8IDMgKystDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y21hLmMNCj4+IGluZGV4IGFiMTQ4YTY5NmMwYy4uNGE3NmQ1YjQxNjNlIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5jDQo+PiBAQCAtMjgxOSw3ICsyODE5LDggQEAgc3RhdGljIGludCBjbWFf
cmVzb2x2ZV9pYl9yb3V0ZShzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LA0KPj4gICAg
CWNtYV9pbml0X3Jlc29sdmVfcm91dGVfd29yayh3b3JrLCBpZF9wcml2KTsNCj4+ICAtCXJvdXRl
LT5wYXRoX3JlYyA9IGttYWxsb2Moc2l6ZW9mICpyb3V0ZS0+cGF0aF9yZWMsIEdGUF9LRVJORUwp
Ow0KPj4gKwlpZiAoIXJvdXRlLT5wYXRoX3JlYykNCj4+ICsJCXJvdXRlLT5wYXRoX3JlYyA9IGtt
YWxsb2Moc2l6ZW9mICpyb3V0ZS0+cGF0aF9yZWMsIEdGUF9LRVJORUwpOw0KPj4gIAlpZiAoIXJv
dXRlLT5wYXRoX3JlYykgew0KPj4gIAkJcmV0ID0gLUVOT01FTTsNCj4+ICAJCWdvdG8gZXJyMTsN
Cj4gDQo+IElmIHJvdXRlLT5wYXRoX3JlYyBkb2VzIGV4aXN0IChtZWFuaW5nIHRoaXMgaXMgbm90
IHRoZSBmaXJzdCB0aW1lIGNhbGxlZCksIHRoZW4gaXQgd291bGQgYmUgZnJlZWQgaWYgY21hX3F1
ZXJ5X2liX3JvdXRlKCkgYmVsb3cgaXMgZmFpbGVkLCBpcyBpdCBnb29kPw0KDQpUaGlzIG1heSBo
YXBwZW4gaWYgcmRtYV9yZXNvbHZlX3JvdXRlKCkgaXMgY2FsbGVkIGFmdGVyIGEgcm91dGUgZXJy
b3IgZXZlbnQgaGFzIGJlZW4gcmVjZWl2ZWQuIEluIHRoYXQgY2FzZSwgdGhlIHN0YXRlIGlzIHNl
dCBiYWNrIHRvIFJETUFfQ01fQUREUl9SRVNPTFZFRCwgc28gaXQgc2VlbXMgdGhlIEFQSSBhbGxv
d3MgcmRtYV9yZXNvbHZlX3JvdXRlKCkgdG8gYmUgY2FsbGVkIGFnYWluIHdpdGhvdXQgcmVuZXdp
bmcgdGhlIGNtX2lkIGluIHRoaXMgY2FzZS4NCg0KQW5vdGhlciB0aGluZywgaWYgdGhpcyBmaXgg
aXMgZWxpZ2libGUsIGl0IHNob3VsZCBwcm9iYWJseSBhbHNvIGdvIGludG8gY21hX3Jlc29sdmVf
aWJvZV9yb3V0ZSgpIGFzIHdlbGwuDQoNCg0KVGh4cywgSMOla29uDQoNCg0K

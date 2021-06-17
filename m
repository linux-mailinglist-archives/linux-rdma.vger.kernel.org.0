Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0063AACCB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhFQG6b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 02:58:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10324 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhFQG6a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 02:58:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H6trGj019344;
        Thu, 17 Jun 2021 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=V+3Kuh4WyKkymabQDTFmHa+th5ToBOy/Hjh648qnShY=;
 b=CGBvEByKmnRVnIitNX4SYurMk+lpMJk6tEWbt6L42BPrM4+ECfTyH7qnuB9bYvwoW/Mq
 rJZPcgxSXGHJGT01teFRGIZudY+rsZU7wGtCaNo0Iag2IwN7jC5UxrvZ/br0oLfHd+y8
 +AODsZDLmOTzSY88mcc3DnKZR97XLRFd6Usk7DK767hh43rIoGlXvVGuDguCn3t6cBei
 T2p917sGHZTN3XThUW2n1z3JTioXWHMJFNaTvhOtK5eKueRYAi4JrI0mkR6KBt3JrZ2C
 LPBLaXQvX6ZN68ub5kV+DWON99F0cCXlFKw79JRzPZoHOIhoTbGucluaekVF6atx9Vkd 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqsdn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 06:56:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15H6tLBU167690;
        Thu, 17 Jun 2021 06:56:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 396wav8j55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 06:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7lhqEIc8JggTDB3zUCylVs0GySTFo8qi1FOg59asUStSeVK2WZpAfxTMCC8faTVriG50RucbZR2ZpILpCWIftGb5Cs7rhvX6il4hYYaWYSGs9OXiWZxSbZ09Rr65+M0QT6mlDbsZOpk2VkVvaiDir9cbhVfAJHw7CXu1iSQxK03HLt6ToLIxNBzPv0j1YW2GtZ5KdmTPf5ecU5Ba25BKVNlruGxqfWde0LTSr7vK6R6PlHa5rJjx8iRpndh9dflT28uKNzzZO02R/QnXYXwtT9guKNiL9YuojVHYI0LqutY+8HuGZMCCvLsUMCiHL6qNqyFsM/mErLEcrnWMmXBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+3Kuh4WyKkymabQDTFmHa+th5ToBOy/Hjh648qnShY=;
 b=akE5ZN5tmAvNpxwV+xYdY8qilhv+7fry6wlQ0dgxUaqLis/scWF1sc10F33b2oQgyIbXjeY3c1l/27yQOYfNzQGibFwP4WHCG1KzbgKluX1cM7R8y+s6TaXCWiqd8nyVfHkpM346rKNDftBNV6FCb0mI/SLtIxVjIzdjyi+R8wUJuNXtci6N9joWjf6Fh8Fbi3Yib0F4GM4Y4NbibD+ZVSL9Q6KaIHqcoDH+EMFkbD6zc4NAmexKAVcqG4l5KDpglR0AsC5m9WpVkuDNe3/zHNSX7ddhjwxhoJXQdM/+dsheCLIeYvY3YQT84wwzy49t6xUb9omesqJxrX6sVRSP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+3Kuh4WyKkymabQDTFmHa+th5ToBOy/Hjh648qnShY=;
 b=UzMi7+pafJkO9KytUf3Gavkd1oeVcpvChZk7fvkMhZGC8fZDM/5hfq5MO+oYsMqVJNBsKdKvmcTP+AijgVOsddpJigw4amfu5lHgTBaB0BdEAYWmaLN2oHqhjefL4m3V/CedTXtMXDPcGa7Nq7YQO+EtJq9Mow5wBfFkZoeezJ4=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1880.namprd10.prod.outlook.com (2603:10b6:903:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 06:56:15 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 06:56:15 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsXxQ4AgAABMIA=
Date:   Thu, 17 Jun 2021 06:56:15 +0000
Message-ID: <E69C3CB3-AE31-4139-816A-11467729ABDC@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <YMrxDtudALQkYuXP@unreal>
In-Reply-To: <YMrxDtudALQkYuXP@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86da7db0-d445-4e19-e48a-08d9315d004b
x-ms-traffictypediagnostic: CY4PR10MB1880:
x-microsoft-antispam-prvs: <CY4PR10MB1880262765CD45E7997B1B93FD0E9@CY4PR10MB1880.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJ79U/3fSai+GwudkhAc7rLTttkwnxpkbFywEnC8W+zAW0PDFKnR/f0MyKoqGF76/QoPcRnIiGFue0m1WUu7gKKxVFvWEtJlqAf0rLSkFK9nCB9K0o8DLka+pYx6SgLOHnOvy02GROvYf6R/4CDo2GUTCF+XdDmsyaY7e83JBYSq5E9s7Ri1J01K3H5TFrsE7+ZdUQyvGyFz6fVwjsDr6Amd9G5yxB1ynTaiVh960m1MyZfKA5KEkRyJ/MDJNHb0g/WqRPFdymJQSHOIqIsXIPlXslG0iyBbjXx52JHTHTwIMj47DfxtZJfx18LL9aEpgJkI9U+st4SNCntH8o3U0QgcIWGhcK54FCHl5hro03QDFMyMy23quNuqr/uZpEbSH5exfcDPTlTiQNRBsfC1O/p55TNui4dN/ntJ22GZ65qzBKKfcxYq6YSqxyevjP1UmPUHb0BY1HZH98M7nndA3oHwWrlRXwfPo7invrLH+l2Pt00HN0IdFNF4XuIeyqkwgSBzQW7GVA2LXGMDgcUsg0PqscEBVDFJKD+C+WmIkSmmCok7JaUkoTzuOLmMECiBngf4W1at86J3DmxlGNriJT+NJaf4GCwqW9Huqq+Q5PBHhYyjVGofTiIKHo+uRcjciK2W8nEkr7wd8m9BdyYU7lZyBAl6SEEmWI3sicPEiM89PK+pMkR69kOVC8Dfp0TS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(44832011)(33656002)(8936002)(8676002)(316002)(6916009)(122000001)(186003)(66556008)(66574015)(2906002)(76116006)(66476007)(4326008)(6512007)(478600001)(71200400001)(54906003)(26005)(83380400001)(36756003)(91956017)(66946007)(5660300002)(86362001)(6506007)(38100700002)(53546011)(66446008)(2616005)(64756008)(6486002)(290074003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXpBSUhXbmtaUTlENXdXdkl0YS9Yb3NubGlKd04zcEwvVGFnTFg2SkRnNEQx?=
 =?utf-8?B?UFB2Q09NaWF3TXdBVkRhU0wvSGZhRmg3Q0FCWkp1L3BoREMvNmkzSHZFMDdN?=
 =?utf-8?B?akhTNzcwSUZZTGF0Nzd1OFZIWkRVdkk5TjVrUGxhZWpuZzlmWEVTeW8xMHJU?=
 =?utf-8?B?U2hoL1VyRGFMMXVaQ2VVSEZQUDVnMWc0UmhFVmdsMkc0TDhxdCtOMzJ3cFJD?=
 =?utf-8?B?T0hkcENvSFNhSFFyKzdYaGIwZkdhZHdRWEo3WnFQMEFtYXBtbnNYaHJSeUox?=
 =?utf-8?B?R0gxT1gycG44Sm9YRnhSNWZUOHBudnJLMzNvdzJSaDEzb1R5UWxwWlZYbSsz?=
 =?utf-8?B?Y1ZwL1FzMGFiZEtOUmhjMzN5TWxIWXJSK1V2KzVTd1ZmQXlDUzUyRjNNVk1C?=
 =?utf-8?B?Q0QvdFQxTTNEY2RHaWhja1JDOTFabTUrOHZxY3MxRmRVZTBGb3JvczJaeVZ2?=
 =?utf-8?B?R0Vyck4rMmF0YkgrSjl0Wm4wVDJTdjlQVE9aZERvd2RlM3M3c1lzSmx5czZ3?=
 =?utf-8?B?Y0RobTVCV2p0SWJMSWx3Q0Z2YzZrVDlyYVNRQ0JvbjZ2K1hvUnlOTHlXa1A2?=
 =?utf-8?B?VjAyUzh0QU1HVHlHTURCQ09xY0paRENGNmRjbGlLcXBrQmMwTGlFc01DRmVW?=
 =?utf-8?B?SStvbi8weGQxZjBpUzZRUDNwZkc5R1FDOXdmTXg4VDBTY01EYnF4NEc4dTdk?=
 =?utf-8?B?ZGc2K0xiNWswc0tzaHNBZmlZYnVUQkczNzE3OVU4UXlBRjZrdXNIbVVYV1Z3?=
 =?utf-8?B?dnZlRnFYdmF0UkVCVkVnd2xMUWdHRFRRV2dELzFQZ09SbXJMc0hFL0JCZmov?=
 =?utf-8?B?MUZPVEhwaUpKbldqdXEzamgwM05kSkZLeDRhVE9mUE9SQ2EvMTlkbVB6bGxI?=
 =?utf-8?B?QkxhM1FjQ2ZyVDYzTW02N2NqelFIUXdwNlhEZFgrQVNWL243U1FJQXk4ZUZj?=
 =?utf-8?B?Mmp5TElvalp6N3BNVlE1WFFVQ0pBdnFqWkw3UURkUnVhTzlEQlJIdVJYK0lP?=
 =?utf-8?B?QjFqVjliVFR3VmtzWXR1Q0JjaFNLTzlkdlVoU0h0K0RGU2VMU3Q1SkUwSjZX?=
 =?utf-8?B?WVN2Vk9weVI4S0NZZmttMVp0ajd4dXYzcVhHVW1UK3prNWh6aE9NWUJ2WWg2?=
 =?utf-8?B?MjNZQUgvZVFTZVVpeWtSd1ZKdGY0Z05QU2I3QnppVFUya0xxYUE3eGZ5WU1x?=
 =?utf-8?B?SmVaY1BEMWszMm02Qng1cGxVdS8xMHVweGlzeCtCVlI4VitiU1BEQlVpMW9B?=
 =?utf-8?B?RXdxbG1LUG5hUytSN0o1NHBNeWlPQzc2QUEvclJxQ0t3WEpQTnE5eGNxOVh3?=
 =?utf-8?B?SjlGQTZBV0F1V3p3ZC82dFkzclZTWFNIaksxcjRrTnlCZ05IOHhHRWswSUxs?=
 =?utf-8?B?VHpjblJMYkdiNmc1ZzlZS3dJV0huaS9YQmh3ZzVkdVdpRDRKZEFCUFlyV21F?=
 =?utf-8?B?UlozV3o2RHd0ajJHMHEzTFJYNmhkc1JOdU5ERTV5QkRkODlCS1RHaDRXdXk5?=
 =?utf-8?B?N3podW10SVJVaDJ4SmF1aU00U2RqRzF6TzhKZERpa0RMY09DVkMyalRralJG?=
 =?utf-8?B?ZzRYTWxLVjJ1eFd3a0FjS25sUWZ3OWZiaUhTa3ZSeWpOYS9WcFhWNUZOdUVw?=
 =?utf-8?B?cmdaT2h1NWh3UEY5SFV0dkdaOEozYkJkMlJtWmhDMFNqem5aNlNpRmdHZU14?=
 =?utf-8?B?dml5WUUxN2F4ZHZMUzkwcDFBYW82WmFvN28yMnV5Rm1HRDlCWHJweS9lMTk0?=
 =?utf-8?B?Yy9MSUdCalhzL3dlTHE5NnVyVTVnbkNZQmViRWo0RlcwWnB6QXVwUnlCNFVo?=
 =?utf-8?B?aklHRnFZek1oSGw3WGhGZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC12B1828263A4409F105E766CFF1CA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86da7db0-d445-4e19-e48a-08d9315d004b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 06:56:15.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZz7BT6eMdwe0wLX1M4aJfaUalzLXENTQkwXlPk+GEOHZKCxDtUAWQmp861Rju/y24loaf9b7DzPO+EGFMVVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1880
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10017 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170048
X-Proofpoint-GUID: KvIEUjHkc16bgCJBR8i4145ZxwAajcZY
X-Proofpoint-ORIG-GUID: KvIEUjHkc16bgCJBR8i4145ZxwAajcZY
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTcgSnVuIDIwMjEsIGF0IDA4OjUxLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAxNiwgMjAyMSBhdCAwNDozNTo1M1BN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBUaGUgc3RydWN0IHJkbWFfaWRfcHJpdmF0
ZSBjb250YWlucyB0aHJlZSBiaXQtZmllbGRzLCB0b3Nfc2V0LA0KPj4gdGltZW91dF9zZXQsIGFu
ZCBtaW5fcm5yX3RpbWVyX3NldC4gVGhlc2UgYXJlIHNldCBieSBhY2Nlc3Nvcg0KPj4gZnVuY3Rp
b25zIHdpdGhvdXQgYW55IHN5bmNocm9uaXphdGlvbi4gSWYgdHdvIG9yIGFsbCBhY2Nlc3Nvcg0K
Pj4gZnVuY3Rpb25zIGFyZSBpbnZva2VkIGluIGNsb3NlIHByb3hpbWl0eSBpbiB0aW1lLCB0aGVy
ZSB3aWxsIGJlDQo+PiBSZWFkLU1vZGlmeS1Xcml0ZSBmcm9tIHNldmVyYWwgY29udGV4dHMgdG8g
dGhlIHNhbWUgdmFyaWFibGUsIGFuZCB0aGUNCj4+IHJlc3VsdCB3aWxsIGJlIGludGVybWl0dGVu
dC4NCj4+IA0KPj4gUmVwbGFjZSB3aXRoIGEgZmxhZyB2YXJpYWJsZSBhbmQgaW5saW5lIGZ1bmN0
aW9ucyBmb3Igc2V0IGFuZCBnZXQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdn
ZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIFdlc3Rn
YWFyZCBSeTxoYW5zLndlc3RnYWFyZC5yeUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbWEuYyAgICAgIHwgMjQgKysrKysrKysrKystLS0tLS0tLS0tLS0t
DQo+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIHwgMjggKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQ0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+IGluZGV4IDJiOWZm
YzIuLmZlNjA5ZTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEu
Yw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+IEBAIC04NDQsOSAr
ODQ0LDcgQEAgc3RhdGljIHZvaWQgY21hX2lkX3B1dChzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICpp
ZF9wcml2KQ0KPj4gCWlkX3ByaXYtPmlkLmV2ZW50X2hhbmRsZXIgPSBldmVudF9oYW5kbGVyOw0K
Pj4gCWlkX3ByaXYtPmlkLnBzID0gcHM7DQo+PiAJaWRfcHJpdi0+aWQucXBfdHlwZSA9IHFwX3R5
cGU7DQo+PiAtCWlkX3ByaXYtPnRvc19zZXQgPSBmYWxzZTsNCj4+IC0JaWRfcHJpdi0+dGltZW91
dF9zZXQgPSBmYWxzZTsNCj4+IC0JaWRfcHJpdi0+bWluX3Jucl90aW1lcl9zZXQgPSBmYWxzZTsN
Cj4+ICsJaWRfcHJpdi0+ZmxhZ3MgPSAwOw0KPiANCj4gSXQgaXMgbm90IG5lZWRlZCwgaWRfcHJp
diBpcyBhbGxvY2F0ZWQgd2l0aCBremFsbG9jLg0KDQpJIGFncmVlLiBEaWQgcHV0IGl0IGluIGR1
ZSB0aGUgZm9vID0gZmFsc2UuDQo+IA0KPj4gCWlkX3ByaXYtPmdpZF90eXBlID0gSUJfR0lEX1RZ
UEVfSUI7DQo+PiAJc3Bpbl9sb2NrX2luaXQoJmlkX3ByaXYtPmxvY2spOw0KPj4gCW11dGV4X2lu
aXQoJmlkX3ByaXYtPnFwX211dGV4KTsNCj4+IEBAIC0xMTM0LDEwICsxMTMyLDEwIEBAIGludCBy
ZG1hX2luaXRfcXBfYXR0cihzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHN0cnVjdCBpYl9xcF9hdHRy
ICpxcF9hdHRyLA0KPj4gCQlyZXQgPSAtRU5PU1lTOw0KPj4gCX0NCj4+IA0KPj4gLQlpZiAoKCpx
cF9hdHRyX21hc2sgJiBJQl9RUF9USU1FT1VUKSAmJiBpZF9wcml2LT50aW1lb3V0X3NldCkNCj4+
ICsJaWYgKCgqcXBfYXR0cl9tYXNrICYgSUJfUVBfVElNRU9VVCkgJiYgZ2V0X1RJTUVPVVRfU0VU
KGlkX3ByaXYtPmZsYWdzKSkNCj4+IAkJcXBfYXR0ci0+dGltZW91dCA9IGlkX3ByaXYtPnRpbWVv
dXQ7DQo+PiANCj4+IC0JaWYgKCgqcXBfYXR0cl9tYXNrICYgSUJfUVBfTUlOX1JOUl9USU1FUikg
JiYgaWRfcHJpdi0+bWluX3Jucl90aW1lcl9zZXQpDQo+PiArCWlmICgoKnFwX2F0dHJfbWFzayAm
IElCX1FQX01JTl9STlJfVElNRVIpICYmIGdldF9NSU5fUk5SX1RJTUVSX1NFVChpZF9wcml2LT5m
bGFncykpDQo+PiAJCXFwX2F0dHItPm1pbl9ybnJfdGltZXIgPSBpZF9wcml2LT5taW5fcm5yX3Rp
bWVyOw0KPj4gDQo+PiAJcmV0dXJuIHJldDsNCj4+IEBAIC0yNDcyLDcgKzI0NzAsNyBAQCBzdGF0
aWMgaW50IGNtYV9pd19saXN0ZW4oc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAqaWRfcHJpdiwgaW50
IGJhY2tsb2cpDQo+PiAJCXJldHVybiBQVFJfRVJSKGlkKTsNCj4+IA0KPj4gCWlkLT50b3MgPSBp
ZF9wcml2LT50b3M7DQo+PiAtCWlkLT50b3Nfc2V0ID0gaWRfcHJpdi0+dG9zX3NldDsNCj4+ICsJ
aWQtPnRvc19zZXQgPSBnZXRfVE9TX1NFVChpZF9wcml2LT5mbGFncyk7DQo+PiAJaWQtPmFmb25s
eSA9IGlkX3ByaXYtPmFmb25seTsNCj4+IAlpZF9wcml2LT5jbV9pZC5pdyA9IGlkOw0KPj4gDQo+
PiBAQCAtMjUzMyw3ICsyNTMxLDcgQEAgc3RhdGljIGludCBjbWFfbGlzdGVuX29uX2RldihzdHJ1
Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2LA0KPj4gCWNtYV9pZF9nZXQoaWRfcHJpdik7DQo+
PiAJZGV2X2lkX3ByaXYtPmludGVybmFsX2lkID0gMTsNCj4+IAlkZXZfaWRfcHJpdi0+YWZvbmx5
ID0gaWRfcHJpdi0+YWZvbmx5Ow0KPj4gLQlkZXZfaWRfcHJpdi0+dG9zX3NldCA9IGlkX3ByaXYt
PnRvc19zZXQ7DQo+PiArCWRldl9pZF9wcml2LT5mbGFncyA9IGlkX3ByaXYtPmZsYWdzOw0KPj4g
CWRldl9pZF9wcml2LT50b3MgPSBpZF9wcml2LT50b3M7DQo+PiANCj4+IAlyZXQgPSByZG1hX2xp
c3RlbigmZGV2X2lkX3ByaXYtPmlkLCBpZF9wcml2LT5iYWNrbG9nKTsNCj4+IEBAIC0yNTgyLDcg
KzI1ODAsNyBAQCB2b2lkIHJkbWFfc2V0X3NlcnZpY2VfdHlwZShzdHJ1Y3QgcmRtYV9jbV9pZCAq
aWQsIGludCB0b3MpDQo+PiANCj4+IAlpZF9wcml2ID0gY29udGFpbmVyX29mKGlkLCBzdHJ1Y3Qg
cmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+PiAJaWRfcHJpdi0+dG9zID0gKHU4KSB0b3M7DQo+PiAt
CWlkX3ByaXYtPnRvc19zZXQgPSB0cnVlOw0KPj4gKwlzZXRfVE9TX1NFVChpZF9wcml2LT5mbGFn
cyk7DQo+PiB9DQo+PiBFWFBPUlRfU1lNQk9MKHJkbWFfc2V0X3NlcnZpY2VfdHlwZSk7DQo+PiAN
Cj4+IEBAIC0yNjEwLDcgKzI2MDgsNyBAQCBpbnQgcmRtYV9zZXRfYWNrX3RpbWVvdXQoc3RydWN0
IHJkbWFfY21faWQgKmlkLCB1OCB0aW1lb3V0KQ0KPj4gDQo+PiAJaWRfcHJpdiA9IGNvbnRhaW5l
cl9vZihpZCwgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSwgaWQpOw0KPj4gCWlkX3ByaXYtPnRpbWVv
dXQgPSB0aW1lb3V0Ow0KPj4gLQlpZF9wcml2LT50aW1lb3V0X3NldCA9IHRydWU7DQo+PiArCXNl
dF9USU1FT1VUX1NFVChpZF9wcml2LT5mbGFncyk7DQo+PiANCj4+IAlyZXR1cm4gMDsNCj4+IH0N
Cj4+IEBAIC0yNjQ3LDcgKzI2NDUsNyBAQCBpbnQgcmRtYV9zZXRfbWluX3Jucl90aW1lcihzdHJ1
Y3QgcmRtYV9jbV9pZCAqaWQsIHU4IG1pbl9ybnJfdGltZXIpDQo+PiANCj4+IAlpZF9wcml2ID0g
Y29udGFpbmVyX29mKGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+PiAJaWRfcHJp
di0+bWluX3Jucl90aW1lciA9IG1pbl9ybnJfdGltZXI7DQo+PiAtCWlkX3ByaXYtPm1pbl9ybnJf
dGltZXJfc2V0ID0gdHJ1ZTsNCj4+ICsJc2V0X01JTl9STlJfVElNRVJfU0VUKGlkX3ByaXYtPmZs
YWdzKTsNCj4+IA0KPj4gCXJldHVybiAwOw0KPj4gfQ0KPj4gQEAgLTMwMzMsNyArMzAzMSw3IEBA
IHN0YXRpYyBpbnQgY21hX3Jlc29sdmVfaWJvZV9yb3V0ZShzdHJ1Y3QgcmRtYV9pZF9wcml2YXRl
ICppZF9wcml2KQ0KPj4gDQo+PiAJdTggZGVmYXVsdF9yb2NlX3RvcyA9IGlkX3ByaXYtPmNtYV9k
ZXYtPmRlZmF1bHRfcm9jZV90b3NbaWRfcHJpdi0+aWQucG9ydF9udW0gLQ0KPj4gCQkJCQlyZG1h
X3N0YXJ0X3BvcnQoaWRfcHJpdi0+Y21hX2Rldi0+ZGV2aWNlKV07DQo+PiAtCXU4IHRvcyA9IGlk
X3ByaXYtPnRvc19zZXQgPyBpZF9wcml2LT50b3MgOiBkZWZhdWx0X3JvY2VfdG9zOw0KPj4gKwl1
OCB0b3MgPSBnZXRfVE9TX1NFVChpZF9wcml2LT5mbGFncykgPyBpZF9wcml2LT50b3MgOiBkZWZh
dWx0X3JvY2VfdG9zOw0KPj4gDQo+PiANCj4+IAl3b3JrID0ga3phbGxvYyhzaXplb2YgKndvcmss
IEdGUF9LRVJORUwpOw0KPj4gQEAgLTMwODEsNyArMzA3OSw3IEBAIHN0YXRpYyBpbnQgY21hX3Jl
c29sdmVfaWJvZV9yb3V0ZShzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2KQ0KPj4gCSAq
IFBhY2tldExpZmVUaW1lID0gbG9jYWwgQUNLIHRpbWVvdXQvMg0KPj4gCSAqIGFzIGEgcmVhc29u
YWJsZSBhcHByb3hpbWF0aW9uIGZvciBSb0NFIG5ldHdvcmtzLg0KPj4gCSAqLw0KPj4gLQlyb3V0
ZS0+cGF0aF9yZWMtPnBhY2tldF9saWZlX3RpbWUgPSBpZF9wcml2LT50aW1lb3V0X3NldCA/DQo+
PiArCXJvdXRlLT5wYXRoX3JlYy0+cGFja2V0X2xpZmVfdGltZSA9IGdldF9USU1FT1VUX1NFVChp
ZF9wcml2LT5mbGFncykgPw0KPj4gCQlpZF9wcml2LT50aW1lb3V0IC0gMSA6IENNQV9JQk9FX1BB
Q0tFVF9MSUZFVElNRTsNCj4+IA0KPj4gCWlmICghcm91dGUtPnBhdGhfcmVjLT5tdHUpIHsNCj4+
IEBAIC00MTA3LDcgKzQxMDUsNyBAQCBzdGF0aWMgaW50IGNtYV9jb25uZWN0X2l3KHN0cnVjdCBy
ZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXYsDQo+PiAJCXJldHVybiBQVFJfRVJSKGNtX2lkKTsNCj4+
IA0KPj4gCWNtX2lkLT50b3MgPSBpZF9wcml2LT50b3M7DQo+PiAtCWNtX2lkLT50b3Nfc2V0ID0g
aWRfcHJpdi0+dG9zX3NldDsNCj4+ICsJY21faWQtPnRvc19zZXQgPSBnZXRfVE9TX1NFVChpZF9w
cml2LT5mbGFncyk7DQo+PiAJaWRfcHJpdi0+Y21faWQuaXcgPSBjbV9pZDsNCj4+IA0KPj4gCW1l
bWNweSgmY21faWQtPmxvY2FsX2FkZHIsIGNtYV9zcmNfYWRkcihpZF9wcml2KSwNCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIGIvZHJpdmVycy9pbmZp
bmliYW5kL2NvcmUvY21hX3ByaXYuaA0KPj4gaW5kZXggNWM0NjNkYS4uMmMxNjk0ZiAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmgNCj4+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmgNCj4+IEBAIC04MiwxMSArODIsOSBAQCBz
dHJ1Y3QgcmRtYV9pZF9wcml2YXRlIHsNCj4+IAl1MzIJCQlxa2V5Ow0KPj4gCXUzMgkJCXFwX251
bTsNCj4+IAl1MzIJCQlvcHRpb25zOw0KPj4gKwl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4+IAl1
OAkJCXNycTsNCj4+IAl1OAkJCXRvczsNCj4+IC0JdTgJCQl0b3Nfc2V0OjE7DQo+PiAtCXU4ICAg
ICAgICAgICAgICAgICAgICAgIHRpbWVvdXRfc2V0OjE7DQo+PiAtCXU4CQkJbWluX3Jucl90aW1l
cl9zZXQ6MTsNCj4+IAl1OAkJCXJldXNlYWRkcjsNCj4+IAl1OAkJCWFmb25seTsNCj4+IAl1OAkJ
CXRpbWVvdXQ7DQo+PiBAQCAtMTI3LDQgKzEyNSwyOCBAQCBpbnQgY21hX3NldF9kZWZhdWx0X3Jv
Y2VfdG9zKHN0cnVjdCBjbWFfZGV2aWNlICpkZXYsIHUzMiBwb3J0LA0KPj4gCQkJICAgICB1OCBk
ZWZhdWx0X3JvY2VfdG9zKTsNCj4+IHN0cnVjdCBpYl9kZXZpY2UgKmNtYV9nZXRfaWJfZGV2KHN0
cnVjdCBjbWFfZGV2aWNlICpkZXYpOw0KPj4gDQo+PiArI2RlZmluZSBCSVRfQUNDRVNTX0ZVTkNU
SU9OUyhiKQkJCQkJCQlcDQo+PiArCXN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfIyNiKHVuc2lnbmVk
IGxvbmcgZmxhZ3MpCQkJCVwNCj4+ICsJewkJCQkJCQkJCVwNCj4+ICsJCS8qIHNldF9iaXQoKSBk
b2VzIG5vdCBpbXBseSBhIG1lbW9yeSBiYXJyaWVyICovCQkJXA0KPj4gKwkJc21wX21iX19iZWZv
cmVfYXRvbWljKCk7CQkJCQlcDQo+PiArCQlzZXRfYml0KGIsICZmbGFncyk7CQkJCQkJXA0KPj4g
KwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8JCQlcDQo+
PiArCQlzbXBfbWJfX2FmdGVyX2F0b21pYygpOwkJCQkJCVwNCj4+ICsJfQkJCQkJCQkJCVwNCj4+
ICsJc3RhdGljIGlubGluZSBib29sIGdldF8jI2IodW5zaWduZWQgbG9uZyBmbGFncykJCQkJXA0K
Pj4gKwl7CQkJCQkJCQkJXA0KPj4gKwkJcmV0dXJuIHRlc3RfYml0KGIsICZmbGFncyk7CQkJCQlc
DQo+PiArCX0NCj4+ICsNCj4+ICtlbnVtIGNtX2lkX2ZsYWdfYml0cyB7DQoNClRoaXMgc2hvdWxk
IGJlIGNhbGxlZCBjbV9pZF9wcml2X2ZsYWdzX2JpdHMuDQoNCj4+ICsJVE9TX1NFVCwNCj4+ICsJ
VElNRU9VVF9TRVQsDQo+PiArCU1JTl9STlJfVElNRVJfU0VULA0KPj4gK307DQo+PiArDQo+PiAr
QklUX0FDQ0VTU19GVU5DVElPTlMoVElNRU9VVF9TRVQpOw0KPj4gK0JJVF9BQ0NFU1NfRlVOQ1RJ
T05TKFRPU19TRVQpOw0KPj4gK0JJVF9BQ0NFU1NfRlVOQ1RJT05TKE1JTl9STlJfVElNRVJfU0VU
KTsNCj4gDQo+IEkgd291bGQgcHJlZmVyIG9uZSBmdW5jdGlvbiB0aGF0IGhhcyBzYW1lIHN5bnRh
eCBhcyBzZXRfYml0KCkgaW5zdGVhZCBvZg0KPiBpbnRyb2R1Y2luZyB0d28gbmV3IHRoYXQgYnVp
bHQgd2l0aCBtYWNyb3MuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KPiBzdGF0aWMgaW5s
aW5lIHNldF9iaXRfbWIobG9uZyBuciwgdW5zaWduZWQgbG9uZyAqZmxhZ3MpDQo+IHsNCj4gICBz
bXBfbWJfX2JlZm9yZV9hdG9taWMoKTsNCj4gICBzZXRfYml0KG5yLCBmbGFncyk7IA0KPiAgIHNt
cF9tYl9fYWZ0ZXJfYXRvbWljKCk7DQo+IH0NCg0KT0suIEkgc2hvdWxkIGFsc28gcHJvYmFibHkg
bW92ZSB0aGlzIHRvIGNtYS5jLCBzaW5jZSBpdCBpcyBub3QgdXNlZCBvdXRzaWRlIGNtYS5jPw0K
DQpBbHNvLCBkbyB5b3Ugd2FudCBpdCBjaGVja3BhdGNoIGNsZWFuPyBUaGVuIEkgbmVlZCB0aGUg
Lyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8gY29tbWVudHMu
DQoNClRoYW5rcyBmb3IgeW91IHJldmlldywgTGVvbi4NCg0KDQpIw6Vrb24NCg0KPiANCj4+ICsN
Cj4+ICNlbmRpZiAvKiBfQ01BX1BSSVZfSCAqLw0KPj4gLS0gDQo+PiAxLjguMy4xDQoNCg==

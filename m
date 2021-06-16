Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB48C3AA0C8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhFPQG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 12:06:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233226AbhFPQGX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 12:06:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFugP6020266;
        Wed, 16 Jun 2021 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IYvDMxFPQtBqm6Au9dxie9evDuBqMmWXY3q1qQ9lYWI=;
 b=t85H21FsqWIX1g8Wrj1sGe1kNXltlOwUHDfdZBO4j1tClp2FEoE7G/3S8XF7IFxZKfwK
 oXyCal3n1a1yIv4T5giSCACBfwk8G73aN8KnG8RTP4r1P2HhcrhJ5EX/eSNA0SMbyZKP
 kbmQ32BUcgVBaAZ1UEHb2GM96Nqlg1wowJQ2jMBx9yX0mjPhG3lw0GBZYx2NeqyhwWc4
 55cocSrFUw/Y/AAz3hTqMwSiHvFPoSF1sPVQ3VwxB5EDG2nJExTomkODs61E/nlR5l3i
 LQqpfWbWYKR4jiKae3Jgzg/bFOGRdsqn9i5SukstyZo+ORZtlh81ENZ5qx3eUXooeg2H Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 395y1ku708-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:04:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GFtUZR141067;
        Wed, 16 Jun 2021 16:03:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3020.oracle.com with ESMTP id 396wawg8dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myj7ZNmLd5FEnU8FnsCdby1DRkBK+xzZtbCGnotrwb+NvkkOlLMf5kvfN3CypG//vlKquxxk0q8NyzZEa67TeIM3JhAtUpwzIK/snbeVe8bdK52hsAnohGPtVFR+x5ZMZZXLg7422609RH8jWvVCGDlpr4pT7cOoLT7V24eNj0eIQ7c/4+nfRD31hheyn81vAYlzer9UIhz6bgiyBSLA873pp9uZDT+/Ti2mVaeMSbE9V9eAQ9HmJYntWFQS+TQ0cYBZJFbgmpabZgUmb9l17ntOVWnbRXwVlTKt+V3rEfYGyTtTGwCGOyLtukTXgSRMaB6fLrVR45HCOplkyA1a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvDMxFPQtBqm6Au9dxie9evDuBqMmWXY3q1qQ9lYWI=;
 b=eoY31y6DSAXsU/yHLQTXhv9kzTATiADvjnLradVXAEmTshJ3TbKQ73An7vR3DIFqPOx5I9ZGJzQYUMTSBaFb9BHmpyC8Cmc7zJxZZTqvu4SpmG4Y1zyc+xXjpL0yPU569A11CX+/jx9aDLzd4KTd1x4OPymNKWMhLF4Qg816BZH7FaLwFll2OopiEwx7Wn/P5wDB+QJU2oZHaKnoMPFSEwgWdsrxH1OwinH0MXvpnqKThucNWoyE4sC0eAu8GpUrz7PImh9VVnJ8wcUVwKlVrXZ1CFp6OK8iTsgE6noLYeia0yVo2hOKQjtp0ESyHUWbOiAtz5GaQSGtUL/9fz2frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvDMxFPQtBqm6Au9dxie9evDuBqMmWXY3q1qQ9lYWI=;
 b=uVRIwkT/zMhStaFf4onYkg/htIIBp86CF/UUJ2FJTq4lk4C2IxG5hU8Vfad6V/VueHTaDVZ4+Ljdkh1RRjhnjvC82H0kbjnI/MTXeRpGwoKHQWxaE8zf+O7krC+/yNv5ygsse5l33ReLvO2CITg4laiJHEfioy1WS7uhDqbzJ74=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1991.namprd10.prod.outlook.com (2603:10b6:903:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 16 Jun
 2021 16:03:56 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 16:03:56 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Stefan Metzmacher <metze@samba.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsWu+eAgAARCAA=
Date:   Wed, 16 Jun 2021 16:03:55 +0000
Message-ID: <BB9A2F8B-C806-4678-858A-E5354D4B5232@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <70403927-7cd3-a9e2-6e97-d1bb35571db6@samba.org>
In-Reply-To: <70403927-7cd3-a9e2-6e97-d1bb35571db6@samba.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: samba.org; dkim=none (message not signed)
 header.d=none;samba.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cbbfbd8-667d-4153-c408-08d930e05830
x-ms-traffictypediagnostic: CY4PR10MB1991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB19910E3B696CCBD6F0302982FD0F9@CY4PR10MB1991.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEqMf4umEKf8Gj9k2gwGoYxY+kg7rgi4hMgRYADP2OqjEVi8aO7Oo3tSDrO008jsqbFU9QaBFOCd7c3rNXOEN9ryFmMzNmnT1A+Sygm55AaZzul4R1lejSe/FeARI8xy5ZZNuBMJtCe2qGABvZ+4NBInV8y8+PwGJeDQvcSpLojNK28V1CjhtM1An4shbNz+/7nyVQD/m6xUpB3OXPVJKLaiEVIP+XFoKUURb0dA6YgO5CGeDL4BbfZhDElgt8IhZfbIudDAVJblfn5JNqds5VxkqmhhZDSikr6UZ2EkF//dsbwa4qIbMU4EpUJqah86fxsicNcmSVdlwabq5KVWXyXkyyk4xAJPcqD3GBKZF3uuAC9gFVkgJqHw6/gWWKhzbceW5s+YQj51LFIa9do8z/ay91yTH4sdzuUBngWpAwCYoEPgtI7pO/8JXieVfVL68z5jmD2Z4FGCJENy6Govh8qg+j1MccP6ZlWCN3qfocvu9GPRGi2MrTyH8K4PNA5alrJASzc+OTD75mWjFSlmx54nwrGrUy4U8KP07MOjVvM2wC5lEd2h9Ph9ipJfGPB/1S0R8z/dNKgJlcnOvcnbJFUTZvbwJ0aG80ASF6Vc4klaChYWRNp1aT/U+plokLNjTTJKZOxG+jZ8UfriOknxeFd1zTkMO91eWClws5Z7DW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(186003)(44832011)(4326008)(6486002)(26005)(5660300002)(66556008)(66946007)(64756008)(66476007)(66446008)(76116006)(91956017)(66574015)(86362001)(83380400001)(6916009)(2616005)(2906002)(107886003)(53546011)(71200400001)(38100700002)(122000001)(498600001)(8676002)(33656002)(54906003)(6512007)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFTUm5Uc2VQYlpkbFFBRlJDWHlLRnJWMUt2ZjFUT0tDU0JvVW1iNEhCcVgw?=
 =?utf-8?B?OTUwanVCQnFsbk00aGpSOGhob2YvNW1wZHBHVzBLekpJcE5RMkxEMVgwVjBv?=
 =?utf-8?B?NG9weU5ocExMUmwrSjBPYnMrMDFnM3BJTzk1ak5uUlRlVGNNSXEvdDN6R09v?=
 =?utf-8?B?bUYwU0J0Y0ZNRDQvaGMyNlZBUC9weDFOU1dHbE9Za1hLTjFkRzdMcm52dFpk?=
 =?utf-8?B?WjNDaFBCS0dZc25CWW1DV1Fobnl0L3RlcWx5dzNObU5PWnhYTU5RTk1XQWl1?=
 =?utf-8?B?S0VNaXNxaFRHRFNnMXR5V05OdzN5blhrR25mWGJpSzFlREZTK2JxODNxZ29F?=
 =?utf-8?B?RzlKUjh3Y2JlUTljaHAwdG1VOVNnMkFIeVBFMlhpSXlTK1QyYko5SGNaczRW?=
 =?utf-8?B?eHlaTmxPOUNmMzhDcHpOamlRQ3JGMjhZZWlvUXREKzhuS2FhWTZLZDlzdEp6?=
 =?utf-8?B?dU5qeXZ1UVRvMFRKN3ZWcWtSYXoxL01vL3lsNUh3eGZCb3REUU42dWdNeGtN?=
 =?utf-8?B?WnppUzNIZmJlWmdJWExia1hpcG82a3paVDkzRUdqSzJlcW9sZUs5RWlXcFBU?=
 =?utf-8?B?aWxubzNZRVhLV2xFUSs0ak1NenJ2bTlwN3Z3cG9vUlYrSTVGYW9waDNxUEt3?=
 =?utf-8?B?MHlXcVZWaEVtMzFGMWJLRFBuSFRzRzRGdTRJU3kwbjdrMUZMZlJMb0NJUG9l?=
 =?utf-8?B?aHVvSGlUanhIbWpXVW5vOWh0enVCNVA0SElKeGR2WWZkNWhPZEpVUDI2TnRp?=
 =?utf-8?B?Um1Ha0pHVTUvWkRlVWFxcExva2pkNHdlSnV4WnQxVlJaUi9Bdm9UcHZERXZQ?=
 =?utf-8?B?elVzK0ZJNzRQYnJZOExuWkNIWkREYmhYNW9nM1FDME9VNE93cnFNNlAzQnFB?=
 =?utf-8?B?R1VnUmdmYkZZWGxkQzdlN0hxRm5uZy9ENks1bmw4M3V1M1Z5eUpkRUdDTVZS?=
 =?utf-8?B?TkV0MDBmUldYYUdLSEJmbzFXR1BHb3I5VFhDTXVBL1doY2hZcWFTaDhIcW5G?=
 =?utf-8?B?TFRIck1uQ0JiczJpUGoyUXBiWU12NVZjRVRVbHJHbTJsM3BCSFh4ZjYzZFI2?=
 =?utf-8?B?bjZmd0pVUjlIY0JuNXU4VGN5OVRhZkhDc3A3SE4rWkdJMkJackd2TU1tSHcz?=
 =?utf-8?B?QmpMQ05Ja2NCWm5UZjlSL2JqK2hDdmczVXB4TUZtTDduS1NHZGlhalhqcWJ6?=
 =?utf-8?B?YU5lSTBIcGZkSzVrWTZkR08zQ0k2SDZMenhuTUVjVENJbEFKT25kdzc1R244?=
 =?utf-8?B?K1JUK1MzR3RnamZCTllSMHMvNjVzT1pTUzU4blVJV2JTZWMvUFhmbGtFVmtG?=
 =?utf-8?B?UzFIdTVvYTkvUmwwYkdpSWJRMGhrK2tIay94OHE2NlBHaU1BNGlZMm11QmRU?=
 =?utf-8?B?aWh4V3hqdktVTmxHOW9KdTlQTzlDZHg1SnV5ZG9lMElYblljNXV0WFFjaEdr?=
 =?utf-8?B?NlNSVzNDQmpFblRjdmdVYnhxVklUMmRnRWNtT2czaVBxZFRXZU12ZmtMbWx2?=
 =?utf-8?B?ZmlDamNlNDB6ekkxczR5THFFdk52TE9ibHRlNTdEUzJVaVlhUVk2NTZuc0tz?=
 =?utf-8?B?eWIzR0NCNUZ3WjRReml4aWFGODBJYVZ4dXRvRHIvR0xOdHpqaVN5c09RY0tU?=
 =?utf-8?B?NWxCcTA4cFRUSnVjN2hrRmFFV29qS1FTOFVyWUwrbnVONmMyUlUyMWJYTnZH?=
 =?utf-8?B?ZXRqSXRYb1FvS0taNkdZenVzQzJUMWVSYk56aXk5RkFaWlR3OGxJaEFqbUZx?=
 =?utf-8?B?azVPS3R1ZEtRaHFWSG9FZCtxakplT2swZUx5ZEtIdXNWT2p6RmJON0Eydjh3?=
 =?utf-8?B?VVVWdWkvVS9NeFl3UjJMZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C95215570BB854EAB7F336CDDCCB52B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbbfbd8-667d-4153-c408-08d930e05830
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 16:03:55.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Co3O0xdfqU9OTdzLKK4gKeL9Su0ZqcEgyKYA71F4PeOEZjxXa51DeaFJnS3AyLC81HWakqI5HJ6YcLaWWI0d0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1991
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160092
X-Proofpoint-ORIG-GUID: O22S15_07xE7BTk5eJKa2GV7SyDLsZVZ
X-Proofpoint-GUID: O22S15_07xE7BTk5eJKa2GV7SyDLsZVZ
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTYgSnVuIDIwMjEsIGF0IDE3OjAyLCBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVA
c2FtYmEub3JnPiB3cm90ZToNCj4gDQo+IEhpIEjDpWtvbiwNCj4gDQo+PiArI2RlZmluZSBCSVRf
QUNDRVNTX0ZVTkNUSU9OUyhiKQkJCQkJCQlcDQo+PiArCXN0YXRpYyBpbmxpbmUgdm9pZCBzZXRf
IyNiKHVuc2lnbmVkIGxvbmcgZmxhZ3MpCQkJCVwNCj4+ICsJewkJCQkJCQkJCVwNCj4+ICsJCS8q
IHNldF9iaXQoKSBkb2VzIG5vdCBpbXBseSBhIG1lbW9yeSBiYXJyaWVyICovCQkJXA0KPj4gKwkJ
c21wX21iX19iZWZvcmVfYXRvbWljKCk7CQkJCQlcDQo+PiArCQlzZXRfYml0KGIsICZmbGFncyk7
CQkJCQkJXA0KPj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJp
ZXIgKi8JCQlcDQo+PiArCQlzbXBfbWJfX2FmdGVyX2F0b21pYygpOwkJCQkJCVwNCj4+ICsJfQkJ
CQkJCQkJCVwNCj4gDQo+IERvbid0IHlvdSBuZWVkIHRvIHBhc3MgZmxhZ3MgYnkgcmVmZXJlbmNl
IHRvIHRoZSBpbmxpbmUgZnVuY3Rpb24/DQo+IEFzIGZhciBhcyBJIGNhbiBzZWUgc2V0X2JpdCgp
IG9wZXJhdGVzIG9uIGEgdGVtcG9yYXJ5IHZhcmlhYmxlLg0KDQpHb29kIGNhdGNoIFN0ZWZhbiEg
SXQgc3RhcnRlZCBvZmYgYXMgYSBkZWZpbmUsIHRoZW4gaXQgd29ya2VkLCBidXQgYXMgeW91IHNh
eSwgdGhpcyBkb2Vzbid0IHdvcmsgd2hlbiB3ZSBwYXNzIGZsYWdzIGJ5IHZhbHVlIHRvIHRoZSBp
bmxpbmUgZnVuY3Rpb24uIEJ1bW1lciENCg0KSSdsbCBzZW5kIGEgdjIgdG9tb3Jyb3cgYW5kIHNl
ZSBpZiBJIGNhbiBpbmNsdWRlIG90aGVyIHJldmlldyBjb21tZW50cyBhcyB3ZWxsLg0KDQpBZ2Fp
biwgdGhhbmtzIGZvciB0aGUgcmV2aWV3ICENCg0KDQpIw6Vrb24NCg0KPiANCj4gSW4gb3JkZXIg
dG8gY2hlY2sgaWYgaW5saW5lIGZ1bmN0aW9ucyBhcmUgc3BlY2lhbCBJIHdyb3RlIHRoaXMgbGl0
dGxlIGNoZWNrOg0KPiANCj4gJCBjYXQgaW5saW5lX2FyZy5jDQo+ICNpbmNsdWRlIDxzdGRpby5o
Pg0KPiANCj4gc3RhdGljIGlubGluZSB2b2lkIGZ1bmModW5zaWduZWQgcywgdW5zaWduZWQgKnAp
DQo+IHsNCj4gICAgICAgIHByaW50ZigiJnM9JXAgcD0lcFxuIiwgJnMsIHApOw0KPiB9DQo+IA0K
PiBpbnQgbWFpbih2b2lkKQ0KPiB7DQo+ICAgICAgICB1bnNpZ25lZCBmbGFncyA9IDA7DQo+IA0K
PiAgICAgICAgZnVuYyhmbGFncywgJmZsYWdzKTsNCj4gICAgICAgIHJldHVybiAwOw0KPiB9DQo+
IA0KPiAkIGdjYyAtTzAgLW8gaW5saW5lX2FyZyBpbmxpbmVfYXJnLmMNCj4gJCAuL2lubGluZV9h
cmcNCj4gJnM9MHg3ZmZkM2E3MTYxNmMgcD0weDdmZmQzYTcxNjE4NA0KPiANCj4gJCBnY2MgLU82
IC1vIGlubGluZV9hcmcgaW5saW5lX2FyZy5jDQo+ICQgLi9pbmxpbmVfYXJnDQo+ICZzPTB4N2Zm
ZDg3NzgxMDY0IHA9MHg3ZmZkODc3ODEwNjANCj4gDQo+IEl0IG1lYW5zIHMgZG9lc24ndCBtYWdp
Y2FsbHkgYmVjb21lICdmbGFncycgb2YgdGhlIGNhbGxlci4uLg0KPiANCj4gSSdtIEkgbWlzc2lu
ZyBzb21ldGhpbmc/DQo+IA0KPiBtZXR6ZQ0KDQo=

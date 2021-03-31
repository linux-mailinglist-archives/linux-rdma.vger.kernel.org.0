Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49E3503B8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhCaPmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 11:42:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhCaPlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 11:41:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VFOa2R133700;
        Wed, 31 Mar 2021 15:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4X0OBmTTPuz6CbHEol0MvXSYaNFH/rOiHh0bYZwtGCE=;
 b=aEq5lN2TNjshVwU/PKVwC8WUFzCyJoABh6pP8XxfcRM5ARa1SkmsnOgi834ZKTOBwaSQ
 o74k67Y1xX4iQWBlgWovFOevaKtjV0TCWhBvTlcXj8lxtcuto5ev7Ly1QBR9XM8iHQJD
 AL+upZZ/UjhqJUFIC/L1UyxnMc4xBVQ2E6/cM3ioWjv0cj9utMhQopNWfWLUX9LXtTt2
 J3mUbYQhJtOVZBf3srkJpUnTY1p0NtDesXJo0xc3AjKhis+oo1lDnJuw+9p+ZEuwQxPu
 7+X60EwoyGQdUuG/cTpHfueXgYc0jB561wpFqc35LlkgpXa4Qm4Y4iycqWijSjfKxASG fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37mp06s60n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 15:41:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VFQhOI080493;
        Wed, 31 Mar 2021 15:41:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 37mac5nb74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 15:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZm65UQvW4A8imjguck23hBeN1QpOpCep5oU2mCCBUqWSuJdIn2hb6JT477nu8DRYomTgb/dhWxOxzHqFp1EjhwO5cueJrDXyeQrnvi3zuyL92GjBMeDa0B9MmUDpOme43WJCEf0n84UrLP9hbJrZCF7HD97d0oHfVKmqfmnVal49NsPyZzSS80Xq6AWJ1bgjYX/vxbyZ+q76A4vXP3cWqxhDPheatOhq2B8L2GTPqb8GgHOAyabi8uIwBWAcPxjuTigNnL8O4fXjbiD9OCWQqjcK6lvhQIfKGdEh0QvNTarrVuQCVu4Qd51xw+iDl63Ykx7FV0iT+GWnnPj+jsYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X0OBmTTPuz6CbHEol0MvXSYaNFH/rOiHh0bYZwtGCE=;
 b=XxtFvgSOqSnIydSVhNEOwUNvgG1skSgwLqZbDw5HBGlY1LAgLtoizPfgxOXHWY4b9ugJ8T25vQFfQ5i5dvwNpvDkmVg3go6jIyZDp/+dY5I/5N0BrqgNOJWPff3mAk8bW37kdK8/DIAXBFTGTvPdhdXsAHUEl8mVmtRP4IiyJV3CmVZ6qlrylGjJQVJ0MA0cV2X4rqTBX8rvI9Xzmi0hzqNth0f6TYFrII0QfNa+G4AmMWeJWBGsLfiPt0ZIP6Igm0uv0SMTHYgx0FNssn/SI5nEowgzoR7v5pCAP2Rv+OlBKOA/jdP8TlPoZwnVFRFT8FQc4Hn9yBv9GHyOWEKXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X0OBmTTPuz6CbHEol0MvXSYaNFH/rOiHh0bYZwtGCE=;
 b=m3ZQCVNDkYxf1YyzjD8xug77EYFULAGzpQ1gUMCuktf8PNz8Nyyk2Bs+xtH4a8A9J5eaoxe/qs8CzUKkgxpYBsi7AZLPiUb89PLeUioZiKDXLfHJjY76jA0K1d8TJaBBI+IJ1il6xrp9Zaw569jLi+zoRZ5abL4+m2VFsk8emy0=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1832.namprd10.prod.outlook.com (2603:10b6:903:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 15:41:47 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 15:41:47 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Topic: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Index: AQHXHyBjcp8TyH1SzUWnxbuZ1f1Dr6qR/BUAgAE7LgCACxMzgA==
Date:   Wed, 31 Mar 2021 15:41:47 +0000
Message-ID: <5407B095-963F-4723-A796-CCF3879B8F17@oracle.com>
References: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
 <20210323194608.GO2356281@nvidia.com>
 <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
In-Reply-To: <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dcf6514-8844-4d53-979e-08d8f45b7ebc
x-ms-traffictypediagnostic: CY4PR10MB1832:
x-microsoft-antispam-prvs: <CY4PR10MB18329DE207CF58A218BF7D63FD7C9@CY4PR10MB1832.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3ClK3ubyW+iaqL8q2XHnxfa2Wy0jsgKrhC87NFU0e3qgTgQuR9pJI+8g2abIRIQJp6YhfIp1jAfasQEDcuwITOtqBy4lKaEiq0TOB9j34ilYCWVZnMtmPFSpcMGe735aWL6Vq53YoHniPicnHdQgTey/ZCBMjK2Fx35yPRxGT3KzR+rsW7d6EIwzAY5Md0CkaKLLIm2XHDw6Lhhbbmy5IUL1t91Cy8civXrEZnTIblNBY+8EZfE8q+MR6m8I0RRXDNEuwQVFoVEeqQNxFINmA9Q98AJeVoIdJVnv7Sj5ahVvRbxtYkSuBDheMvivSe5xNdQRJGWJt5zKiDZUyxkPbp/aU7JGuw5AYyggX8XeaPY+KjKIdRELHC+c6zq9Jgseu2cWshOcwMw4Dj5vyc0YC/3ST2iKQatZN6Fp5jRkWNF1FrDjCuTIWHzJo40y/Qm/ZnsRdHFhYubIE0ZixVqB+bK5S6cdH+4UeR07MtVnQmRP+0/BT76zhV8vDIO57Tq0QNw5gXrj+0gBFWy+aut+IRGYiAF23gXWv1/yDCOOBQUZE0e1EsmJtiRT4oIiTXIwl5HjyB6eoWlFD7RFUqT2run4oLrIER+BY/j5j77hbcbUQ4zjxMOAflE5XmJWbKQUMqgqgwtny7XrZ+DES2XkQse4xGtDxALTWIoKsio/o7CwsxGRDdVvRhf8+rhpN/D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(38100700001)(44832011)(26005)(36756003)(478600001)(8676002)(66446008)(64756008)(66556008)(66476007)(186003)(4326008)(66946007)(6506007)(2906002)(33656002)(76116006)(91956017)(6916009)(2616005)(6486002)(316002)(71200400001)(66574015)(54906003)(53546011)(83380400001)(6512007)(5660300002)(86362001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NzJvY0NLendoWFhXaGdYZ3VnMGY2RW52bi9Id2RyL09lMkljVW56Qm1BWDR5?=
 =?utf-8?B?VmJReTcva0I5Z3hsOUwwMVllaWlHOFc1RTlsTnNYZUtMUHJZaW1xZlNtV1NP?=
 =?utf-8?B?bHg3R1BjU1pjQVY3NlNHOEtSeExZNTJoeHA5M0hYSVVPU0NrcVNOcXZuN2RP?=
 =?utf-8?B?U1ZXODdCcERGaUtpYUxZYXdSb09nbEUxOVVXcDZDMllKaFAzYUxHZGV3Vnho?=
 =?utf-8?B?SFJEY0M5TEtrRWpjRjR0dWY0ckFJeHhvdTJBWlp2c3Y1eGVlOHBPNFE2ZVRw?=
 =?utf-8?B?bnpSNktSU1FjdzUvR3hMdm9rbThFM0pyK0hnL3M0SFFRUVBYK0V3WGIxLyt5?=
 =?utf-8?B?UUFobDJIQllzTy8xMmVpWEd6aXYzclpOMXBXTFA5TkgxK2ZKWkdpQUpudEtw?=
 =?utf-8?B?NXpsNzdIQWNRSjBOcDZXMWFLd09sQS9kbnlWNDJHbzcwdHhYN2tEd1RMcElN?=
 =?utf-8?B?UXJNWGUyaDdRRVV0RWxPMzVuM2JRSUR1RjFzc1NaczZ2eDd4bytyYjlCcjVm?=
 =?utf-8?B?cE9yTkpBU3RwcldiMk1pek1Mc3ZXNEVSVXFPK0hCWFJYdHRmWk1CZ0gwbUd2?=
 =?utf-8?B?SlR6L2VSMEpJcmFyRkFkb3M4eTJMU3dlQnNyMEljajh1NDcwV1o0aGZsRTNo?=
 =?utf-8?B?L0FjaEp2VUJXYTdZbGRySkltWXdFc25aa0ZaSDBxdmdFbFIramk3Y3J3ZHRw?=
 =?utf-8?B?aERhNFJGeTE4cS9xYkRwcXhRVE1tejVJL2Evc1NNUEQxYzdvOXdpaWUwUXBs?=
 =?utf-8?B?cHRPZ211VDlkYVlDNVVFWU84aU81OXRlNG5yYVVvWHRhcnhISUlIdmRydko1?=
 =?utf-8?B?SUVQdnZBam5VYWZqckN6MXJxQXRQSVZSSENGUmNBUGV3M1Y3MExxZy93clRZ?=
 =?utf-8?B?UzRNWDlZZzVFRjIrT1pseCtNeFJsM3BGaGVqZmV2TDIvVVBuSWkrUEYxR1pJ?=
 =?utf-8?B?aDArWlRFMEg4SUF6U2U5Y1orakwvY2JKb3k2UTJLMHg4R2FWeTdVNzNPL1Q0?=
 =?utf-8?B?UWFVblQvYkZYdzlHTTBzVy9JaEJVRFMyeE1aeFpNL1g4SEx2YnpWcEZqODhp?=
 =?utf-8?B?YWJaTkdRb2pVTlN2dnJ4eVByR0lkbnhNbWZGRnd0RlVSZFpzT0M5Vlk0Rlc3?=
 =?utf-8?B?V3RuYnJUaFY4aUhUaUU2TTZ4OHl1Tnd0NFJvcXBLanJiU3dkdGd2bWxiS09X?=
 =?utf-8?B?NXYzQXEyUWdya1o5clVRTTBSMlB5R1JscTFOdDlQV3FRNzJDU2NtemE4NzlI?=
 =?utf-8?B?WUE0anNVNzhKQ25YT215eHJMYTV6a3RaUlNWdk54UjQvM09LOXQra0NpWm1G?=
 =?utf-8?B?QXgxWWVySzJ1M0VqMlFDbmZGeDF0UGpKdzBpUjIrRHR1a3NKeVhTRnhVSU94?=
 =?utf-8?B?dDltN1VyUWhxTEFsclhjd29OU0FpeWE2bUdETVNoVEREYktaQUwrcjM1ZURh?=
 =?utf-8?B?eTIyazlVYjNETGR2bDg4NlNjdVBWTlFQZUk2OUxjZ3FER0hYVWNFeFZaQ2R2?=
 =?utf-8?B?TCsrb3BCcWJXempvYTE1cEN6MDdzd2JheEFyT0NZS3RmeHl6L0VEMHpXaFMx?=
 =?utf-8?B?MW0wM2VXMSt3cXA5SGVqdzFVN3EwUmZtcTFRRWkwZFZLdVlaY2I1b09qZnZy?=
 =?utf-8?B?OVFHUGV2Wm0wd1U1YS91ZXVtK0pzTjJVVjBUVjVVbVVsdnY4ajFpWDRad083?=
 =?utf-8?B?QUYwLzFaU1dlNWc5b2FPRExRbVJLbHNOK0F1dlFaQitsaStqa1BOckk2bjVB?=
 =?utf-8?B?TkVBSmxFOFVMc3YzbnBjMzcrckc5eGlJbVlQdm92NisrMC9LMHdTUUVVOEl5?=
 =?utf-8?B?M1VLMHNIQUdycXBxVDhtQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <182E6EE4BBF1FE409C7D79DA21736154@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcf6514-8844-4d53-979e-08d8f45b7ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 15:41:47.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io7hy09UevpcDYKQWlCJkRjWUhpNkFGfYobbv0kh3VlZSW1+ZRst1VYeM91ANr08c9t3QWQbWW6JSF1U5+FwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1832
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310108
X-Proofpoint-ORIG-GUID: C5hD-8EAKTctwli9CaeXLSBsUPJ97tbD
X-Proofpoint-GUID: C5hD-8EAKTctwli9CaeXLSBsUPJ97tbD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310108
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBPbiAyNCBNYXIgMjAyMSwgYXQgMTU6MzQsIEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9y
YWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMjMgTWFyIDIwMjEsIGF0IDIwOjQ2
LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+IA0KPj4gT24gTW9u
LCBNYXIgMjIsIDIwMjEgYXQgMDI6MzU6MzJQTSArMDEwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0K
Pj4+IE9uIFJvQ0Ugc3lzdGVtcywgYSBDTSBSRVEgY29udGFpbnMgYSBQcmltYXJ5IEhvcCBMaW1p
dCA+IDEgYW5kIFByaW1hcnkNCj4+PiBTdWJuZXQgTG9jYWwgaXMgemVyby4NCj4+PiANCj4+PiBJ
biBjbV9yZXFfaGFuZGxlcigpLCB0aGUgY21fcHJvY2Vzc19yb3V0ZWRfcmVxKCkgZnVuY3Rpb24g
aXMNCj4+PiBjYWxsZWQuIFNpbmNlIHRoZSBQcmltYXJ5IFN1Ym5ldCBMb2NhbCB2YWx1ZSBpcyB6
ZXJvIGluIHRoZSByZXF1ZXN0LA0KPj4+IGFuZCBzaW5jZSB0aGlzIGlzIFJvQ0UgKFByaW1hcnkg
TG9jYWwgTElEIGlzIHBlcm1pc3NpdmUpLCB0aGUNCj4+PiBmb2xsb3dpbmcgc3RhdGVtZW50IHdp
bGwgYmUgZXhlY3V0ZWQ6DQo+Pj4gDQo+Pj4gICAgIElCQV9TRVQoQ01fUkVRX1BSSU1BUllfU0ws
IHJlcV9tc2csIHdjLT5zbCk7DQo+Pj4gDQo+Pj4gVGhpcyBjb3JydXB0cyBTTCBpbiByZXFfbXNn
IGlmIGl0IHdhcyBkaWZmZXJlbnQgZnJvbSB6ZXJvLiBJbiBvdGhlcg0KPj4+IHdvcmRzLCBhIHJl
cXVlc3QgdG8gc2V0dXAgYSBjb25uZWN0aW9uIHVzaW5nIGFuIFNMICE9IHplcm8sIHdpbGwgbm90
DQo+Pj4gYmUgaG9ub3JlZCwgYW5kIGEgY29ubmVjdGlvbiB1c2luZyBTTCB6ZXJvIHdpbGwgYmUg
Y3JlYXRlZCBpbnN0ZWFkLg0KPj4+IA0KPj4+IEZpeGVkIGJ5IG5vdCBjYWxsaW5nIGNtX3Byb2Nl
c3Nfcm91dGVkX3JlcSgpIG9uIFJvQ0Ugc3lzdGVtcy4NCj4+PiANCj4+PiBGaXhlczogMzk3MWM5
ZjZkYmYyICgiSUIvY206IEFkZCBpbnRlcmltIHN1cHBvcnQgZm9yIHJvdXRlZCBwYXRocyIpDQo+
Pj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4N
Cj4+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIHwgMyArKy0NCj4+PiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29y
ZS9jbS5jDQo+Pj4gaW5kZXggM2QxOTRiYi4uNmFkYmFlYSAxMDA2NDQNCj4+PiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jDQo+Pj4gQEAgLTIxMzgsNyArMjEzOCw4IEBAIHN0YXRp
YyBpbnQgY21fcmVxX2hhbmRsZXIoc3RydWN0IGNtX3dvcmsgKndvcmspDQo+Pj4gCQlnb3RvIGRl
c3Ryb3k7DQo+Pj4gCX0NCj4+PiANCj4+PiAtCWNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFfbXNn
LCB3b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0KPj4+ICsJaWYgKGNtX2lkX3ByaXYtPmF2LmFoX2F0
dHIudHlwZSAhPSBSRE1BX0FIX0FUVFJfVFlQRV9ST0NFKQ0KPj4+ICsJCWNtX3Byb2Nlc3Nfcm91
dGVkX3JlcShyZXFfbXNnLCB3b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0KPj4gDQo+PiB3aHkgdXNl
IGFoX2F0dHIudHlwZSB3aGVuIGEgZmV3IGxpbmVzIGJlbG93IHdlIGhhdmU6DQo+PiANCj4+IAlp
ZiAoZ2lkX2F0dHIgJiYNCj4+IAkgICAgcmRtYV9wcm90b2NvbF9yb2NlKHdvcmstPnBvcnQtPmNt
X2Rldi0+aWJfZGV2aWNlLA0KPj4gCQkJICAgICAgIHdvcmstPnBvcnQtPnBvcnRfbnVtKSkgew0K
Pj4gDQo+PiA/DQo+PiANCj4+IEkgc3VzcGVjdCB5b3UgY2FuIGp1c3QgbW92ZSB0aGlzIGludG8g
dGhlIGVsc2U/DQo+IA0KPiBJIGNhbiBjb3VudGVyIHRoYXQgYnkgc2F5aW5nIGFoX2F0dHIudHlw
ZSBpcyB1c2VkIH4xMCBsaW5lcyBmdXJ0aGVyIGRvd24gaW4gdGhlIGNvbmRpdGlvbmFsIGNhbGwg
dG8gc2FfcGF0aF9zZXRfZG1hYygpIDstKQ0KPiANCj4gDQo+IEZ1cnRoZXIsIGluDQo+IA0KPj4g
CWlmIChnaWRfYXR0ciAmJg0KPj4gCSAgICByZG1hX3Byb3RvY29sX3JvY2Uod29yay0+cG9ydC0+
Y21fZGV2LT5pYl9kZXZpY2UsDQo+PiAJCQkgICAgICAgd29yay0+cG9ydC0+cG9ydF9udW0pKSB7
DQo+IA0KPiBJIGNhbm5vdCByZWFsbHkgc2VlIGhvdyBnaWRfYXR0ciBjb3VsZCBiZSBudWxsLiBJ
ZiBpYl9pbml0X2FoX2F0dHJfZnJvbV93YygpIHN1Y2NlZWRzLCBpdCBpcyBzZXQgYWZ0ZXIgdGhl
IGNhbGwgdG8gY21faW5pdF9hdl9mb3JfcmVzcG9uc2UoKSBhYm92ZS4gTWF5IGJlIHVzaW5nIGFo
X2F0dHIudHlwZSBpbiB0aGlzIHRlc3QgaW5zdGVhZCwgZm9yIHVuaWZvcm1pdHkgYW5kIHJlYWRh
YmlsaXR5Pw0KPiANCj4gSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uLg0KPiANCj4gTGV0IG1lIGtu
b3cgeW91ciBwcmVmZXJlbmNlLg0KDQpBIGdlbnRsZSBwaW5nLg0KDQpUaHhzLCBIw6Vrb24NCg0K
DQo+IA0KPiANCj4gVGh4cywgSMOla29uDQoNCg==

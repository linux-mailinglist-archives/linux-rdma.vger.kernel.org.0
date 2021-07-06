Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47F53BC919
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 06:13:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57216 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhGFKNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 06:13:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166A4BbD005024;
        Tue, 6 Jul 2021 10:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AQi5wHiSP4bO2AJqPsqPFfxLhFAY55jN2oHcPcF6JLg=;
 b=gpHfmV2NEv04tTh/DX6M++Oq2bqpoAzEx30ST8rbHMrHPdpaYY0B2GuXiTInaynXTka3
 fX9qKXhRH9/uEDCNJwbZl0lZSbrQtK33fS8us1OnmDBJhORHH1dqVXetNxaYu/LHkVQT
 v1cwgGMk1S5LYv2YxJHfRE+50cgB6bClE/932xtzlnBbA1gWvra3jDFZll0txyj4MYwe
 utHy2b2NIqeJSWckxsL0wU3eI9Qk13xEWeTGbrEB7ErN+LwnTeNgSBO2yTJpPLHJUXGO
 Xw6Rn+6+tCYRlWhowo0F6hwoRiTsw8EZiLA4QuKHcV6Gw+Vcz+nFC/vUwOp/SLVkxRuK Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27h9htj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 10:10:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 166AAGG5116724;
        Tue, 6 Jul 2021 10:10:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 39jfq8a47a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 10:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj3SQ0FHQ1b0nQibg3hMVAXTZRNHJP8PeVK0qQpxXuqMMwqRcDmgDtOUd6y50K3weCku9ZVXl7xJlHleXY2A0n4myqWP1Dg4qQTnERQhDm6KxQ1DtqePiD3Bs/UwqMCq6Rh3/MQincLST9txG9+vwmNDlyohCLY+fnrDZppZwFdDp/irUyK65a64NjnmWHYuOOv7N0+VjgOQpDLNXfRz/eEaJxGBRvVvR7Axh9epa7BOQYy+UfuYFjxJYidxXJvMCKSsDncbs/3mCPgvWcB1GH4Prs/UQmYAb0+RavYcJVy0yj5c8lm5k1hkegUBkvMdjuXskIlpFthoms71A1F8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQi5wHiSP4bO2AJqPsqPFfxLhFAY55jN2oHcPcF6JLg=;
 b=MqhYkcZAOetqfmTNIqwur+Ksw5iq8JD99y9bEbF/Xu3vH0kvCtvPLPY3wZNrLhNRKqo2CZ0BM2BhFsCS6dSvf3VbPoh9b4lVRQnQlha2w7cuaUKGACBYA//AOAiDtjGbztGT7NYR4+0mysO/826BCrgT6kH3jnLd62eqI/Y/1BTUdzDbcSAdY34gEUGs4nTb/z3pYfRaH8uasKGa7Wc2S0IcpfPK7ANotMorTbrQ0EZ+GvxxVSPSHm74KVQVQSYPYbFyZZ14MitzBPagqLP8mIxdkahypE/am6PmOvoo2Jg/gLA22pjfGP3PCwDjfDVJyt4xXwyni/DgTKYTc+2dCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQi5wHiSP4bO2AJqPsqPFfxLhFAY55jN2oHcPcF6JLg=;
 b=e18kr7VWWZkb/I2QKuJQxiMJ5lZGyoWMUQ3alypiaslO6tqiDFtfJVOsULfeYEmIqNqrjs7SBzRBmRFXDDkhz6YHbZSwhKpsLz/gEa2T1K75zm8HXG1zcses7oWiN4nTA7hG1JlEX8VecmJ2GG/7Tf402msykZr0Jx5ikmTe1jQ=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Tue, 6 Jul
 2021 10:10:01 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 10:10:01 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "yang.jy@fujitsu.com" <yang.jy@fujitsu.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix memory leak in error path code
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Fix memory leak in error path code
Thread-Index: AQHXcby7SeWFOYBkKkSsUbZnibUPO6s1cb+AgABI8AA=
Date:   Tue, 6 Jul 2021 10:10:01 +0000
Message-ID: <3FC1883A-0B39-42A0-814D-04B39F270AA5@oracle.com>
References: <20210705164153.17652-1-rpearsonhpe@gmail.com>
 <CAD=hENd3cggRC6R1r19d=+ustA8gwHinPAzg0UnmyteuA24OhA@mail.gmail.com>
In-Reply-To: <CAD=hENd3cggRC6R1r19d=+ustA8gwHinPAzg0UnmyteuA24OhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d56e0561-ac6f-4663-d284-08d9406637de
x-ms-traffictypediagnostic: DS7PR10MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR10MB532766D04831E05C28B4D000FD1B9@DS7PR10MB5327.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XR5IB4HFcFe2aLq2HhVcZVI3qFsEK33tiH5VxWR5RfFlUtwGRgoNBTskCpEEOsjr1pY4wbMPsE6k9M8Mn/12x6Md+VMm9CWVjehUTUp0149+S9YnDJjJprrfCekqcyp9C2BtrEbRvkTn4pZq6G3RlXztIspD1C/rvZCYQzJ4xqU1r+LxQOvffrSQjBNmYTAnNc8l1aXC7jHCNBaceRxpd1ZL2oYlpKbAXCASACX3H7NCy+ar69ipdFlywAnehMQlRo3xlk4Dw2v8N9OkkWpzTzaidLUttsS3wD6wlB6yN82q0MS6+dHZ3zXyuBaHP3uq/uvvt7hkur14kHjRDyApehESaAevbsMy4NeGm1nvqvpF3qRQ49xCSEqwouASdP8CNwefsVW6q2mrLP+SR2/1EKSyUf6W4DNv7h18QFXoZT+QrxgF0VOWkUz/VE4BMan2QNW3jky6fa29G6REl2oy/WTK/AqqfCPCgHEzJ8QS5uXuWEB4vX3vA1Nm9qlsYFack9wToo9ei0U1/1wIWOxygkmxPElD7Q7ETxuJtNXbZD8/hkbMCwvcY2AUqE40//+srbI6R25boFZm/E5Os0r4+NY0miBi4fwslJAY8h3vb4wi5g5jc1i1LNaqqohw4RtH3C6ICfmfolr1jhCj2YT5lhCyTTjnGC/PpxIw5/4hSY3GIohXEpBfOcF+n9tNdaeSRamwonOouvtJXqN7NYmDiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(83380400001)(66574015)(54906003)(66446008)(71200400001)(186003)(64756008)(5660300002)(6916009)(26005)(66476007)(6486002)(44832011)(8936002)(4326008)(122000001)(36756003)(2906002)(38100700002)(33656002)(6512007)(6506007)(2616005)(86362001)(316002)(8676002)(66946007)(478600001)(76116006)(53546011)(91956017)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZ4dTdISVY2cjU2YUl6T00zaUh1aGJRUDdTNzJoYU5wQjdnNE1KUTJmbjl0?=
 =?utf-8?B?RnJhVTBPMktyQmJvbjdXUldrUXZyRU9SSGhoZHY5djRzUWRIVnBEMVZrUFdq?=
 =?utf-8?B?blg2YVh4Wm1qVlpob1VYTWYvalQ5MG1qR3B5YVU0NWoyR2ZyMmJMQlNLL2RC?=
 =?utf-8?B?a3FaejZkWTdDcEhJS05teWpoeGIvZVhMOEpnYmQyWHdkR1VhSU1HQnd6Y1p2?=
 =?utf-8?B?TEhnd3NoK2V1YXpkeXdSR2IwZFNDcVlKUW52bldXWHB3UjY5dkU0MVlKaEZX?=
 =?utf-8?B?Qk1mNkEzcjMwV3NQSU02NnRmdGJpWEViYmFYR1NNTmpJbGd2ZytOaUFHL2Y1?=
 =?utf-8?B?bDVlbVRTL2dxZFM5Z1hBenlGTUl6ak0zZWxsQUlmemt0bUFyWFpaanZ2SDB4?=
 =?utf-8?B?QmRQUTZDM1NTK3Vuam1SdEtSWVU4bGdGc05iR05jcDRMUjRVNmN5N3RFYUZy?=
 =?utf-8?B?SlNYQmNHQ2JnQTY1RGxWbHA2Ukp3UmRzTGR1SGE3NmR1SFFmZ3J0V09xZnQ1?=
 =?utf-8?B?WjBVY1VFdDlpempVZngwQXlydDI0WFc5K3JGSDBtdmhYd3BTcy9Oekd2dTI4?=
 =?utf-8?B?RnpCeFJnbmdHanAvV3FjSzBYQUI1aUFPNWNwOTZSQnErdEtFa3NydTlsUHNB?=
 =?utf-8?B?akRWNVcwU2ZNWmVYV2V6cTJVb2p0Vk1iZCtOTHpHYWE1bFlzemxmRktKT3FG?=
 =?utf-8?B?RktVMFpKQWZsTW9CcFQ1Z2ZHS3dlTW5pT0VnQkMyaWk1My9qY2VZMTk4Sm84?=
 =?utf-8?B?ZnNOcHZMZ01GN3Zvc2tadkpmaUw4UzNocHc4V2V4azdtT09IQmNVWCtuVkJQ?=
 =?utf-8?B?cnh3b1h3VDk1Qy84Q2x4dWJvY0hERGxOcUNUdU5QYjM1QkdYR2xHanhyNUxn?=
 =?utf-8?B?Si9YeWJNRkNCbnQ4eE1RbnFSY0V5T0JkS3VMZTJsSDM2UDc4WDFoRnpweHI2?=
 =?utf-8?B?NXZYSFhOWWtPVGNEK0FldFJBbU9YaVI0UkYzbTVvWStibnQxTjczSG5Eb3Jh?=
 =?utf-8?B?dXdRUE1SalZ5Qkh6eWVNcWxJVlBkazQ1aTU0ZkRjd3k0NlRFVEIxeWdacmVj?=
 =?utf-8?B?akhPRW1QQ3J5S0ZDZmxJMWlydU90NjNYY0pBV3ZpL3RhSDRkVm5Bbkc1Uklj?=
 =?utf-8?B?YkRjeGloUUJXT2JZdHlqVE5GdUdGeDdQWUJlSkovNHl6UnpGM3YweENaQWtO?=
 =?utf-8?B?WEN2TkxsbkFUREVQQTB5Zk4wbDRDeVQrUU5ydkFYY1c5MndRbXYrRTJYbEpL?=
 =?utf-8?B?UERhUXhvNTJuZFB2ZzRDek5RN042ZDVodUo5d1dQVEcyN1ptNW5MVDlxYVp1?=
 =?utf-8?B?VmEvWExXZlpTaElFeTdYa0kvcXdrZ2o5Yi9jWkpWQ25qM2FFRWtwWmxJdk92?=
 =?utf-8?B?bTR0cDkrZVNReHpvYi9XdVpBenA4M0VseWZ5RXNFZFFidVIxdk5qT2cyZ28r?=
 =?utf-8?B?SktoNmxOZjBta0tVZTVJRittc2VpZTN5Vmd3cWV4WUs0ak5ZUTYzNTc2WnpS?=
 =?utf-8?B?OWhyaUhPZFlCU0VucjhKMzNiZnJDeUN6V2JMWWVVTC9TdlNHZkQ4b3luMDZ3?=
 =?utf-8?B?dXNSTDhucXMxTEphbndkQ3E1bnM2RkRzemdmZlpmNVhBWmIzamFGcnFyYlRH?=
 =?utf-8?B?Si9MRWc5ZGFtZSt4U2dNNVhTVElYV3VPNWdmMnBwTDRNSzFYbGhjVy95L1RV?=
 =?utf-8?B?ZmVhenVSdWc4SUpXdTRyQk41YkpHbDRPNk9HQ3JNU3FZRVFGL3I1M0IyeGRH?=
 =?utf-8?B?cDZhZG9oOGN0SGx4bWczbVJ1VEFabWRGL0pMaTljcklyOHB2blVSVzA1UmI1?=
 =?utf-8?B?TExHd1JLMWJPUy9hWnNldz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <702D71EB159BBA4B9F514462CB34FF26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56e0561-ac6f-4663-d284-08d9406637de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 10:10:01.6493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gLsxsfEEtCKavi04ZYl0ORFMxU8ibrKYjuAU9f9GgARrJsQ/+yYxWu5qvGVRYXYeTVSfStGWUh7w9VhbAJhNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060050
X-Proofpoint-ORIG-GUID: wd47yutQ5M9VU2xMkXMAuagu2v_iHQyf
X-Proofpoint-GUID: wd47yutQ5M9VU2xMkXMAuagu2v_iHQyf
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNiBKdWwgMjAyMSwgYXQgMDc6NDgsIFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21h
aWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVsIDYsIDIwMjEgYXQgMTI6NDIgQU0gQm9i
IFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiANCj4+IEluIHJ4ZV9t
cl9pbml0X3VzZXIoKSBpbiByeGVfbXIuYyBhdCB0aGUgdGhpcmQgZXJyb3IgdGhlIGRyaXZlciBm
YWlscyB0bw0KPj4gZnJlZSB0aGUgbWVtb3J5IGF0IG1yLT5tYXAuIFRoaXMgcGF0Y2ggYWRkcyBj
b2RlIHRvIGRvIHRoYXQuDQo+PiBUaGlzIGVycm9yIG9ubHkgb2NjdXJzIGlmIHBhZ2VfYWRkcmVz
cygpIGZhaWxzIHRvIHJldHVybiBhIG5vbiB6ZXJvIGFkZHJlc3MNCj4+IHdoaWNoIHNob3VsZCBu
ZXZlciBoYXBwZW4gZm9yIDY0IGJpdCBhcmNoaXRlY3R1cmVzLg0KPj4gDQo+PiBGaXhlczogODcw
MGUzZTdjNDg1ICgiU29mdCBSb0NFIGRyaXZlciIpDQo+PiBSZXBvcnRlZCBieTogSGFha29uIEJ1
Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFy
c29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+IA0KPiBUaGFua3MgYSBsb3QuDQo+IA0KPiBS
ZXZpZXdlZC1ieTogWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+DQoNClJldmlld2Vk
LWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQoNClRoeHMsIEjD
pWtvbg0KDQo+IFpodSBZYW5qdW4NCj4gDQo+PiAtLS0NCj4+IHYyOg0KPj4gIExlZnQgb3V0IHdo
aXRlIHNwYWNlIGNoYW5nZXMuDQo+PiANCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X21yLmMgfCAyNyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9tci5jDQo+PiBpbmRleCA2YWFiY2I0ZGUyMzUuLmJlNGJjYjQyMGZhYiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IEBAIC0xMTMsMTMgKzExMywx
NCBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1
NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+ICAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBu
dW1fYnVmOw0KPj4gICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICp2YWRkcjsNCj4+ICAg
ICAgICBpbnQgZXJyOw0KPj4gKyAgICAgICBpbnQgaTsNCj4gDQo+IFRoYW5rcy4NCj4gDQo+PiAN
Cj4+ICAgICAgICB1bWVtID0gaWJfdW1lbV9nZXQocGQtPmlicGQuZGV2aWNlLCBzdGFydCwgbGVu
Z3RoLCBhY2Nlc3MpOw0KPj4gICAgICAgIGlmIChJU19FUlIodW1lbSkpIHsNCj4+IC0gICAgICAg
ICAgICAgICBwcl93YXJuKCJlcnIgJWQgZnJvbSByeGVfdW1lbV9nZXRcbiIsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAoaW50KVBUUl9FUlIodW1lbSkpOw0KPj4gKyAgICAgICAgICAgICAg
IHByX3dhcm4oIiVzOiBVbmFibGUgdG8gcGluIG1lbW9yeSByZWdpb24gZXJyID0gJWRcbiIsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKGludClQVFJfRVJSKHVtZW0pKTsN
Cj4+ICAgICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIodW1lbSk7DQo+PiAtICAgICAgICAgICAg
ICAgZ290byBlcnIxOw0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX291dDsNCj4+ICAgICAg
ICB9DQo+PiANCj4+ICAgICAgICBtci0+dW1lbSA9IHVtZW07DQo+PiBAQCAtMTI5LDkgKzEzMCw5
IEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3RhcnQsIHU2
NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPj4gDQo+PiAgICAgICAgZXJyID0gcnhlX21yX2FsbG9jKG1y
LCBudW1fYnVmKTsNCj4+ICAgICAgICBpZiAoZXJyKSB7DQo+PiAtICAgICAgICAgICAgICAgcHJf
d2FybigiZXJyICVkIGZyb20gcnhlX21yX2FsbG9jXG4iLCBlcnIpOw0KPj4gLSAgICAgICAgICAg
ICAgIGliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjE7
DQo+PiArICAgICAgICAgICAgICAgcHJfd2FybigiJXM6IFVuYWJsZSB0byBhbGxvY2F0ZSBtZW1v
cnkgZm9yIG1hcFxuIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5j
X18pOw0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3JlbGVhc2VfdW1lbTsNCj4+ICAgICAg
ICB9DQo+PiANCj4+ICAgICAgICBtci0+cGFnZV9zaGlmdCA9IFBBR0VfU0hJRlQ7DQo+PiBAQCAt
MTUxLDEwICsxNTIsMTAgQEAgaW50IHJ4ZV9tcl9pbml0X3VzZXIoc3RydWN0IHJ4ZV9wZCAqcGQs
IHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+PiANCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgdmFkZHIgPSBwYWdlX2FkZHJlc3Moc2dfcGFnZV9pdGVyX3BhZ2UoJnNnX2l0ZXIp
KTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCF2YWRkcikgew0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuKCJudWxsIHZhZGRyXG4iKTsNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWJfdW1lbV9yZWxlYXNlKHVtZW0pOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuKCIlczogVW5hYmxlIHRvIGdldCB2
aXJ0dWFsIGFkZHJlc3NcbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBfX2Z1bmNfXyk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZXJyID0gLUVOT01FTTsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBlcnIxOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9jbGVh
bnVwX21hcDsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgIGJ1Zi0+YWRkciA9ICh1aW50cHRyX3QpdmFkZHI7DQo+PiBAQCAtMTc3LDcg
KzE3OCwxMyBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0
YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+IA0KPj4gICAgICAgIHJldHVybiAwOw0KPj4g
DQo+PiAtZXJyMToNCj4+ICtlcnJfY2xlYW51cF9tYXA6DQo+PiArICAgICAgIGZvciAoaSA9IDA7
IGkgPCBtci0+bnVtX21hcDsgaSsrKQ0KPj4gKyAgICAgICAgICAgICAgIGtmcmVlKG1yLT5tYXBb
aV0pOw0KPj4gKyAgICAgICBrZnJlZShtci0+bWFwKTsNCj4+ICtlcnJfcmVsZWFzZV91bWVtOg0K
Pj4gKyAgICAgICBpYl91bWVtX3JlbGVhc2UodW1lbSk7DQo+PiArZXJyX291dDoNCj4+ICAgICAg
ICByZXR1cm4gZXJyOw0KPj4gfQ0KPj4gDQo+PiAtLQ0KPj4gMi4zMC4yDQoNCg==

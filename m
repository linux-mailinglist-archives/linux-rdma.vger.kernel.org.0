Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305E53AE784
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFUKss (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 06:48:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26412 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFUKss (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 06:48:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LAgX89027751;
        Mon, 21 Jun 2021 10:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pqXqCjqUvWgx9rmNaoLjjjnVTmEQE/RKTtcmKLFOfeU=;
 b=sxPYTBpL5fC0PWbirQJMINd2BE/juViasCioDA11P333oDT/PL0H1VTwxmOSKLx4bsRY
 4IwjhWSqLpfJS4hQmJGqhqTGkAPiHQnB/DjlXcOtjiRhw8a7eU35dyDHSSswVf7V2tcG
 OhMh8owLx9kxPYL7h8XpTKuVxPdifApH42D8QUacCfhEVQNcmxW1UUsWz9UcGZsvxRs5
 kqRsnnF9pFtAH7hYHxL8zwc59Cuqg8TPRolkhIVBFEZLc+xZGLCTI+OxnkL6rOnnPtCr
 xTUGiLjuFyxIJRV/ThloWQ6ETs0a/4ub/yGYMj09EHh8XNQi88CZO5pPe3SXXieDGrUg qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39anpurgpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 10:46:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LAjYHU178932;
        Mon, 21 Jun 2021 10:46:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3030.oracle.com with ESMTP id 3996mbrp36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 10:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGnhtJ529BRrf7BhcoIm121sMCEiN287cWvCOXdNPzbkoeWEl5elhotIYIuBYN+Wwu3Lq86Kzuwi4zjp9LjcdCDfE1WzAkTeYGQgLE11z9jURsz/5SOMMQaLmLqOAiK+GpJZ0uoGzBSWcpfbf2f4l4LNxxBPmKiwO5TBdpZOoqGryNav5ggy6NTsDjV28Al1y4iddVe0+ujSqrpJDE3DFgo7+su85+5xAKZ261wWJ4qkf+2tGk6DHHDIKvWRJ9BUqwpPa6/RW7yKf6BED/zX7dv288/O/QmYtEvB7sVZ6I6Q6r76ebLaubx0KTzGlJp2JgE1fik9HOT8SPmP7QtyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXqCjqUvWgx9rmNaoLjjjnVTmEQE/RKTtcmKLFOfeU=;
 b=MVAQjldw+jZlTaEYfJlh6EUZKi4W6L1Smi70gzTJXs4D/AdHPzLOGh/7GrRkCd9Hf0a7+d742T9BVNxzHHDvTaOWz/uLor6Jq+JAx3pO51NcI2UiPBwRHccFUUf20rN5spx+dIcvnpidT++fFaQpBUpWXEywpaVTwhfeHCK9+whA/Nf0t0ZKV8zPMUyzroBaEvyrsfGUugjuQtFYA52r5WUa8MyxOou4E8YvNYEw1d27Y5BAHKb1+fTwBtJUAECWnvFTx8vunBU8HOlEcxu4bZBSHlVu5Jg2Gm5x0vfqn8vcGGgYZWlZxt1n66lEEuelbotRCHFSFehz4T7SK/lNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXqCjqUvWgx9rmNaoLjjjnVTmEQE/RKTtcmKLFOfeU=;
 b=kM4cwkRxiZoTFHCRzrEy6tHdAysf7jXlewkzTji/QFBmSCuXUNmmwlEzAbuxQKhhXj2DoG96A05TPcbZkJ2m5CJY0xmWyvQlNnLlUxzrNAdaXz4r2RIEvp7/N6GsBkAL6h8fN5G9Hti9hTZSIfg95FDAATUB+keUbfj07WEDaZ0=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2215.namprd10.prod.outlook.com (2603:10b6:910:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 21 Jun
 2021 10:46:27 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 10:46:26 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXY3iqQ+lwecvXsUKE5x7HSp6gYKseEhgAgAAToQCAABoOgIAADqSA
Date:   Mon, 21 Jun 2021 10:46:26 +0000
Message-ID: <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal> <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal>
In-Reply-To: <YNBhuZNjGvUsJHUy@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c5010c-eb80-458c-dd3d-08d934a1d1e7
x-ms-traffictypediagnostic: CY4PR1001MB2215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB2215DE67086D3EF1FBB7BB58FD0A9@CY4PR1001MB2215.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55E9xSk2fQ651vHVSgcmo/T6idYw9dbqNM427e1j/XoBsp+hjbQa1rQy3l0q8psDS//iaKCHamQwDAruu2bX+XtzYS3ViLQ3DlR3RPm5SLpBXegLFkwuoMaorf1BhV0ZSoXvbvESJIHfCfHOXnqcXh2kZXrFAWTyO3uDxG7pWWrRv0XOhLUM9tGtKMlziF2N3LfnkxLzRNpvR1z6RuZmzsp1cLL7UNfbVg1q5BYXj3Ld7nUPVy8wBuZb8D/sr6GdsFuuz/X3N1r7lCBEij+4w/1rOXXJxqeX0JTtgZYFDnJ88nzDfmgkESLcyFUvEcSSjetdGpu21XkBpR2Uj9Oy5U2xZAZswc8MuYy/Oglfz5+FhpStWqmmMJz8qEijGz6wUW3VeVANfxBeo7TCNUk+65m6MozY+Voi6c1q4GegQCGWAqXCkhRDMFxbDbBscLRkrPnEJzGzgFAuReycMZfSw7LsFWMbcB8RkMy4A8b9nHLEodvs4raX+UwkT76Ci1JpE+sTQWVDUjHh6U3GneGU5XZN2FeInTO5GOGcaDtSufqrTJzdlTEvLKKAqoEs/BmyWRX4XBRzb6UfDVDTgGSc9Q6iwjPX9jEpwepyhceFG3xqQpFaN4jTKG1GVaV20M/8kOFQpuZIX2820pRaLxKOZNlHG9U9w3UanizDP4UrmJQ3P3Lt9Ef/9guo1ArWgY1B+scGHqOJFw4YclpH/7hBrPuFshdMX2BKyRrh3uNBNr+2e4HK4/tpvuXBodBpNpjSHAHyr4rW7Azbc+gcAGGRtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(4326008)(71200400001)(6486002)(966005)(478600001)(86362001)(64756008)(66556008)(66446008)(91956017)(76116006)(66946007)(36756003)(8676002)(6506007)(8936002)(186003)(38100700002)(26005)(53546011)(122000001)(66476007)(33656002)(6512007)(44832011)(2616005)(6916009)(316002)(5660300002)(54906003)(107886003)(2906002)(66574015)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0RIVERoTEs2cU4zbVFZWEp5ZHNxdTV1T2ZRWmFJblJ1T0JyME91SG11S09m?=
 =?utf-8?B?Qk1LdWRKRXIvN1BpNkVlTVJXVUk5N1RSU3ZaUnhJSm5OQm5jR1dMWWVTVEU4?=
 =?utf-8?B?QlcvbGFtOGY1Ky81WE9KZlZqQkIyZjhxd2U0WE9NTDljTnFLZEtXZkFyNklO?=
 =?utf-8?B?UHFHQUVYQ3U3R2k0cVNXUFZXZnh0T1JSYjU0TmVKQkpNNHZNb1Y0N2I0a2NH?=
 =?utf-8?B?TTZ0VFpyT1IyeEhLTVhDQ1BXd0pObkZ3SG5udmNiSC9YRisvNDMxTlV4UEV4?=
 =?utf-8?B?TFlNWU1Id1Y2bnQxa25CUko4dWFBcUtkYnZpODJidzJFRnk1MTBlTlZzOE5h?=
 =?utf-8?B?ejd3UHdWK1BZbjduSnBxUUlzKy9kUyswVDUzWkF0K2dkaUoxRURIMHU2VTUw?=
 =?utf-8?B?WndGZDdqQ3QzeUd5K0Q0cXZWK0t5WElwWUtkbzdGbkNadXB0MHdyWkxCZVIr?=
 =?utf-8?B?QitZLzlFY0NtMW5qMk5GUHdHTkN1a2swNDQzOGNjSFpWWFQvUFNVWmprcFlp?=
 =?utf-8?B?eUlITW1uYzEwTmZNbFlmbjBRYUVNM013UFY3bnBRNTBpZjR2YjhNK0dxLzUz?=
 =?utf-8?B?SDJ0R2FhN1MxMjNka3hEaWppekJwanowcXpQdFdpU2FYRmNBaEZHdVc3QlVz?=
 =?utf-8?B?dWtwa21lS3RpYytaSXl1ai84cjB0NTROWjlGdkFyMVhweW1YZG9WZ2cvbXlW?=
 =?utf-8?B?MHpoWjE4a3ZDeUgrcFc0MjVFYWtIRFY1RHpGL1Y5RXBBMXdPRU8vUlEvb2NN?=
 =?utf-8?B?VVdJMmFrSVFMY0hJK2g1UDdiSW5BQUcrUm9yMSt6eGQ0bXg3N09TMlA0UUdD?=
 =?utf-8?B?bHZrazlEYXBuNk1VcFJVSzByMWhwSFc1QWREVkUvWG43RGFEWUx0YTJHM2E5?=
 =?utf-8?B?NDdQZ1hjdGRLUVV4WEFQOVRaa1E0K2lrcVlNTEVscFpiM1FlOFVkTk1PWEtW?=
 =?utf-8?B?cVVmOGpzTnBIS1JXY2xscWJlQk1yN1diZjd3K0ROTFVaN0ZVNFVxSEtQa1Ax?=
 =?utf-8?B?OGtacDh3M2hMajQyMXZ5MUtqZHBFMkZ1RkVUZ1NJeWNyVDIwUXlVb2FQZU5n?=
 =?utf-8?B?MkdRMFNhR0ZjdUhyNlJScE1LL2FNL2hYZkpkSkJ5ZVdIaHA2TkdmcjZ1TWRw?=
 =?utf-8?B?VTFsZ2R5UWZrRFB2U295MFJqcWpqRU9BUTI2aHphOFA1MzBFWnpZRkZrMlNW?=
 =?utf-8?B?ZGluTmd6bXpQc3NiaFNUS1liNVJac0xGbXVmMlp6R0UrS1l2MUV0Tzl3Sy9L?=
 =?utf-8?B?WGNuWjJCSTRzVmpBV0M5N3VLdGpIN3RlYzhkOGxFWkdGdnYyeHU3a3hQU3Fs?=
 =?utf-8?B?OGZQZnppQ2FLQ2ZNQ3FwbXhuSkpwbUo3Wjk2c2ZhVjRNdWhQd1FFd0psWU1Z?=
 =?utf-8?B?Z0tOaVlXOUlOTTNpSDJRUlZPR1cxL1R3TkRjamIwdjVHc0JwYVBrcy9HOHJV?=
 =?utf-8?B?dDdMMVJMd1lRU21NZ05DeEx2VmFBQTRheFVGaitVSHNzbmUyZm9WVVk1WHkr?=
 =?utf-8?B?OEg0U1NlVlo1UHRULzIxN052T09veTlrdy9WTk1JSm1oQ0VQM2xudzVsY0xn?=
 =?utf-8?B?c1lXOTlJU05pMXlIRHJLY0I0VkF6NkhtUXZqd05pNkwvN05LRFlGaW80dThX?=
 =?utf-8?B?dzZTMHRBbUp4b0cwYVhFUVU4RlhEZnI3K3hUNTdoMlIvTWU4cmNrNitUQnJq?=
 =?utf-8?B?WHZJOTlxVHN0WTJ6QUs1aWdrVWRld2FkS0lKcER1R0NBdzY5cHRKbkhnQW8r?=
 =?utf-8?B?TVcxZnlMRHRTSnhnaGR6WVN3dlVhMnJKOVZKQnhSWDBhVXpvcWt3cWxXeDJH?=
 =?utf-8?B?dnhVenBHTytPcHF6WUVWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18512AA5CC01945BFBC45E7BD8A7FE6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c5010c-eb80-458c-dd3d-08d934a1d1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 10:46:26.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Lr/X8xwlehLbyNvqU70sK0xqWITCTzVUIIuGn7sC4tiSONCkq5CCYH27c09xqPxHczMcOmlD4UkDs87wQMEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2215
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10021 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210063
X-Proofpoint-GUID: wIblgyywZ8El0w6bhT2z-DDMkeuROyoW
X-Proofpoint-ORIG-GUID: wIblgyywZ8El0w6bhT2z-DDMkeuROyoW
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDExOjU0LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAwODoyMDo0N0FN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDIxIEp1biAyMDIx
LCBhdCAwOToxMCwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDAyOjU5OjI1UE0gKzAyMDAsIEjDpWtvbiBC
dWdnZSB3cm90ZToNCj4+Pj4gVGhlIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgY29udGFpbnMgdGhy
ZWUgYml0LWZpZWxkcywgdG9zX3NldCwNCj4+Pj4gdGltZW91dF9zZXQsIGFuZCBtaW5fcm5yX3Rp
bWVyX3NldC4gVGhlc2UgYXJlIHNldCBieSBhY2Nlc3Nvcg0KPj4+PiBmdW5jdGlvbnMgd2l0aG91
dCBhbnkgc3luY2hyb25pemF0aW9uLiBJZiB0d28gb3IgYWxsIGFjY2Vzc29yDQo+Pj4+IGZ1bmN0
aW9ucyBhcmUgaW52b2tlZCBpbiBjbG9zZSBwcm94aW1pdHkgaW4gdGltZSwgdGhlcmUgd2lsbCBi
ZQ0KPj4+PiBSZWFkLU1vZGlmeS1Xcml0ZSBmcm9tIHNldmVyYWwgY29udGV4dHMgdG8gdGhlIHNh
bWUgdmFyaWFibGUsIGFuZCB0aGUNCj4+Pj4gcmVzdWx0IHdpbGwgYmUgaW50ZXJtaXR0ZW50Lg0K
Pj4+PiANCj4+Pj4gUmVwbGFjZSB3aXRoIGEgZmxhZyB2YXJpYWJsZSBhbmQgYW4gaW5saW5lIGZ1
bmN0aW9uIGZvciBzZXQgd2l0aA0KPj4+PiBhcHByb3ByaWF0ZSBtZW1vcnkgYmFycmllcnMgYW5k
IHRoZSB1c2Ugb2YgdGVzdF9iaXQoKS4NCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtv
biBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEhh
bnMgV2VzdGdhYXJkIFJ5PGhhbnMud2VzdGdhYXJkLnJ5QG9yYWNsZS5jb20+DQo+Pj4+IA0KPj4+
PiAtLS0NCj4+Pj4gCXYxIC0+IHYyOg0KPj4+PiAJICAgKiBSZW1vdmVkIGRlZmluZSB3aXphcmRy
eSBhbmQgcmVwbGFjZWQgd2l0aCBhIHNldCBmdW5jdGlvbg0KPj4+PiAgICAgICAgICAgIHdpdGgg
bWVtb3J5IGJhcnJpZXJzLiBTdWdnZXN0ZWQgYnkgTGVvbi4NCj4+Pj4gCSAgICogUmVtb3ZlZCB6
ZXJvLWluaXRpYWxpemF0aW9uIG9mIGZsYWdzLCBkdWUgdG8ga3phbGxvYygpLA0KPj4+PiAgICAg
ICAgICAgIGFzIHN1Z2dlc3RlZCBieSBMZW9uDQo+Pj4+IAkgICAqIFJldmlldyBjb21tZW50cyBm
cm9tIFN0ZWZhbiBpbXBsaWNpdGx5IGFkYXB0ZWQgZHVlIHRvDQo+Pj4+ICAgICAgICAgICAgZmly
c3QgYnVsbGV0IGFib3ZlDQo+Pj4+IAkgICAqIE1vdmVkIGRlZmluZXMgYW5kIGlubGluZSBmdW5j
dGlvbiBmcm9tIGhlYWRlciBmaWxlIHRvDQo+Pj4+ICAgICAgICAgICAgY21hLmMsIGFzIHN1Z2dl
c3RlZCBieSB0aGUgdW5kZXJzaWduZWQNCj4+Pj4gCSAgICogUmVuYW1lZCBlbnVtIHRvIGNtX2lk
X3ByaXZfZmxhZ19iaXRzIGFzIHN1Z2dlc3RlZCBieSB0aGUNCj4+Pj4gICAgICAgICAgICB1bmRl
cnNpZ25lZA0KPj4+PiAtLS0NCj4+Pj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgICAg
ICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+Pj4+IGRyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmggfCAgNCArLS0tDQo+Pj4+IDIgZmlsZXMgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gVGhpcyBw
YXRjaCBnZW5lcmF0ZXMgY2hlY2twYXRjaCB3YXJuaW5ncy4NCj4+PiANCj4+PiDinpwgIGtlcm5l
bCBnaXQ6KHJkbWEtbmV4dCkgZ2l0IGNoZWNrcGF0Y2gNCj4+PiBXQVJOSU5HOiBsaW5lIGxlbmd0
aCBvZiA4NiBleGNlZWRzIDgwIGNvbHVtbnMNCj4+PiAjNjk6IEZJTEU6IGRyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5jOjExNDk6DQo+Pj4gKwlpZiAoKCpxcF9hdHRyX21hc2sgJiBJQl9RUF9U
SU1FT1VUKSAmJiB0ZXN0X2JpdChUSU1FT1VUX1NFVCwgJmlkX3ByaXYtPmZsYWdzKSkNCj4+PiAN
Cj4+PiBXQVJOSU5HOiBsaW5lIGxlbmd0aCBvZiA5OCBleGNlZWRzIDgwIGNvbHVtbnMNCj4+PiAj
NzM6IEZJTEU6IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jOjExNTI6DQo+Pj4gKwlpZiAo
KCpxcF9hdHRyX21hc2sgJiBJQl9RUF9NSU5fUk5SX1RJTUVSKSAmJiB0ZXN0X2JpdChNSU5fUk5S
X1RJTUVSX1NFVCwgJmlkX3ByaXYtPmZsYWdzKSkNCj4+PiANCj4+PiBXQVJOSU5HOiBsaW5lIGxl
bmd0aCBvZiA4NiBleGNlZWRzIDgwIGNvbHVtbnMNCj4+PiAjMTI3OiBGSUxFOiBkcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9jbWEuYzozMDQ4Og0KPj4+ICsJdTggdG9zID0gdGVzdF9iaXQoVE9TX1NF
VCwgJmlkX3ByaXYtPmZsYWdzKSA/IGlkX3ByaXYtPnRvcyA6IGRlZmF1bHRfcm9jZV90b3M7DQo+
Pj4gDQo+Pj4gV0FSTklORzogbGluZSBsZW5ndGggb2YgODQgZXhjZWVkcyA4MCBjb2x1bW5zDQo+
Pj4gIzEzNjogRklMRTogZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmM6MzA5NjoNCj4+PiAr
CXJvdXRlLT5wYXRoX3JlYy0+cGFja2V0X2xpZmVfdGltZSA9IHRlc3RfYml0KFRJTUVPVVRfU0VU
LCAmaWRfcHJpdi0+ZmxhZ3MpID8NCj4+PiANCj4+PiAwMDAxLVJETUEtY21hLVJlcGxhY2UtUk1X
LXdpdGgtYXRvbWljLWJpdC1vcHMucGF0Y2ggdG90YWw6IDAgZXJyb3JzLCA0IHdhcm5pbmdzLCAx
MTggbGluZXMgY2hlY2tlZA0KPj4gDQo+PiBZb3UncmUgcnVubmluZyBhbiBvbGQgY2hlY2twYXRj
aC4gU2luY2UgY29tbWl0IGJkYzQ4ZmExMWU0NiAoImNoZWNrcGF0Y2gvY29kaW5nLXN0eWxlOiBk
ZXByZWNhdGUgODAtY29sdW1uIHdhcm5pbmciKSwgdGhlIGRlZmF1bHQgbGluZS1sZW5ndGggaXMg
MTAwLiBBcyBMaW51cyBzdGF0ZXMgaW46DQo+PiANCj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDA5LzEyLzE3LzIyOQ0KPj4gDQo+PiAiLi4uIEJ1dCA4MCBjaGFyYWN0ZXJzIGlzIGNhdXNpbmcg
dG9vIG1hbnkgaWRpb3RpYyBjaGFuZ2VzLiINCj4gDQo+IEknbSBhd2FyZSBvZiB0aGF0IHRocmVh
ZCwgYnV0IFJETUEgc3Vic3lzdGVtIGNvbnRpbnVlcyB0byB1c2UgODAgc3ltYm9scyBsaW1pdC4N
Cg0KSSB3YXNuJ3QgYXdhcmUuIFdoZXJlIGlzIHRoYXQgZG9jdW1lbnRlZD8gRnVydGhlciwgaXQg
bXVzdCBiZSBhIGxpbWl0IHRoYXQgaXMgbm90IGVuZm9yY2VkLiBPZiB0aGUgbGFzdCAxMDAgY29t
bWl0cyBpbiBkcml2ZXJzL2luZmluaWJhbmQsIHRoZXJlIGFyZSA2MzAgbGluZXMgbG9uZ2VyIHRo
YW4gODAuDQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+IFRoYW5rcw0KDQo=

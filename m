Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3758B4906F2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiAQLMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 06:12:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14012 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233906AbiAQLMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 06:12:21 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20H9T93c013661;
        Mon, 17 Jan 2022 11:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JZLdd7RdIwGWy2ntFN1CxmQA+Y/fMSwiUcyfX+wJBFI=;
 b=G9SJoyqVE+sG6TnnOioCdT+W63hTBZ9kS1qQFzBJepgmy4QbEu2S2TdymY4S9PcnGean
 UsqqhaCBetRE9q0efIvnk0jjjqisfNVSQyB076FOLSQce2F/EVEjyxRKXejPzdthZwTX
 Of4fuEEl2a8mhp0dYvVxo1vrumS6x2AqnKZcGtSmVxX79O2LuPYmEW/JsDWIG2vOnkZf
 lIqllal+b7NmAn0e+PW4Bl1zG8qgYyhDZVhvADULHiX+A3wlHh/kx4kL/lQqA+CXLdb+
 XXad6R3jvTlNPVk/fijTalAt2abejRBR88olOm0Z8CUan5gNSgvfQlnd/etZnJ0htJGp WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dkpttk34f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 11:12:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20HBAK9T145262;
        Mon, 17 Jan 2022 11:12:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 3dkp32qwkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 11:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnShROyMBF//nqux1uP219AWURRLzzCFlJ3bP78MtUr58sTqmuqdnKpOkWBccccwg/IvUYDsfIc1Qyow1WEOtCYo380bHpXBlM/qAXhVI79WYIofPEXR/HGuV7j2+9oI866lij7Dc/C8u+TGALqm86e4ZZlo4zkvoIVCOpzuVSV+N4tVJAZ0iRjzMzwLW90XFFTpw3q5bVQw/7UN4fvbozjF7SmAoEKr2sCgvZ2lkgyYjw9xY85Rpeu0dBWDrpXi+FS5cWZy+9bzIF4HWqdvfXsNLRasKRRNWxhmjKqO5FXUJkCyGmjg4uDN+g22s876yYf+rKH60WAj7gQfZSwh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZLdd7RdIwGWy2ntFN1CxmQA+Y/fMSwiUcyfX+wJBFI=;
 b=WC7H8zag99fndyZj3P1LNysFLjapRTmJ5QwOUe0XJ5DU9JQi3XPc7DdgFwZ47y4zTQh4yAoqn+QbnHr5coPBTSXGYrvpa47iT7WVZf7MuPAjEzciJKFaLR8d5TTYfl+qi6Frkq4ToGaXKUUQsDBdFXqrsleaa+XQ6Cfz9PEuGjYSK12HwpEQqyaOBM42EV1LaZJTAGtTSjadFcVhKXG/q9COwmC2D1Yj09yh/rg7SlGNt8ejbvvPSdPMBf7Wk5YRl6cT/ucGpBcXQx3hk9AIkEeWDFdwONwdsRgA2scZfulZVnd3Kket+vdIaPcRgLATrcqyfW/g+EFo199S8t3p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZLdd7RdIwGWy2ntFN1CxmQA+Y/fMSwiUcyfX+wJBFI=;
 b=zhAuyN4pTORgPaJV3NkZYr6vWGuJbS4Ia1GND8pvTYLw/Hjxlyu1gG292Q/weGpmBWC76zk7KIxdhUSQlwdn1Fq0qjj5bR9tAXrAJld5k+7lt6e42Dwhw8hqxLfbj0/0W1twSKqTxQN1RWX6suoKkbEzfQug6pVwM1Ff3yxw+N4=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2656.namprd10.prod.outlook.com (2603:10b6:805:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 11:12:12 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%4]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 11:12:12 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBoyMt+p3JCa+2kO6ZZ6hvuqxcaxdFzIAgARahACABadWgA==
Date:   Mon, 17 Jan 2022 11:12:12 +0000
Message-ID: <5A111A92-427C-4FE1-BDA1-6E8877350D20@oracle.com>
References: <20220111014145.2374669-1-yangx.jy@fujitsu.com>
 <61DCEA00.1030002@fujitsu.com>
 <326487d9-74cc-185e-1790-90730425057a@gmail.com>
In-Reply-To: <326487d9-74cc-185e-1790-90730425057a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0577136f-1c0d-49ab-6fd0-08d9d9aa35e1
x-ms-traffictypediagnostic: SN6PR10MB2656:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26563B29F499BBFF13F2D59AFD579@SN6PR10MB2656.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZAbo8pHWFcxl1dB86q8ir+h4NPMjNJTLqQ+QppWzEW374Y/+b5IgaRr/uxZj6QZXC6csa5qAzCqIx18TaJXpvaAYs2PJtKEEQ9asOwdmTUW19Yb72gY7fIf/zWLbFq/IQbogQkWe/RwOFNlJbAszTTffUb6rPX9F23NJPVNcPHeQ/yba7+nFzaNywKFiuS064OYfz4sLFx8G/cPEJayPskW72+xdU+1v+AqtuxamsIJh8A+xcu7+sNLtW5Snxypz0cPgqmQs+BjbzdUmz3K5L8o/2uPDnff2tznd17en4q5qRCvhUDJsBZ62+NlkD+htbQJRZ+NKlI14VU8ptIvE8YSr0VFKclJAXO29tXDREOd7F19JdvLZL2tB7j+IM3yVkqXJwEMDM/8Udcx9UIzvOGE/0OtJ6PoFqynb0hFGncFk6EeJdgJnkQH1d4/gXkRlDw67XPfGfWhkTlB3aXNWBxd+D3euzhf9N5VGkvh7T6awdiCi6XXp/ebIIl663Scx60n1WqlGl45gSKzK6yEfT4AO2nktjt4lalZQhb6dnIEsCVGQly+Q8Z92jegUg9DoJjli990Yw+N3lZ4C6ezB6qx6keLglm/1OniWsMQly7rIGmaJWdz2pfWfrLMUAEP1nqNHFNtVkqZWviQpIcazO42OhQ9bx/ZABFuzazbuYWOWKfWbEZ5dTGq80wlQj57ZM+WkuFMB+4v2CJqzb/sXeAfKJvdWRgVwBMDlYnH+lFsO/aqt803+rrK2icRwC3A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6486002)(66946007)(66476007)(8936002)(122000001)(91956017)(33656002)(508600001)(2616005)(64756008)(186003)(8676002)(76116006)(2906002)(66446008)(26005)(4326008)(66556008)(6916009)(38070700005)(6506007)(53546011)(86362001)(66574015)(5660300002)(71200400001)(54906003)(316002)(38100700002)(83380400001)(6512007)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STR3cW4rSEw2OFZKa1hYTC9QRm5ycVIrWnpSVkNETWdiZ3dWcmJHcWtUQm95?=
 =?utf-8?B?L2xXSzAzZ2h6MEhGNU1jKzdzZjlMa1h0Y2RSY1d5eFVub040VUxpVDdoWVNY?=
 =?utf-8?B?Wkc2S2VURE5EZW9ZTUZaMGdRQnpSeVFodWlTSklieGNoMVBUSXd3Y3FpUTN3?=
 =?utf-8?B?eHNHOFFUVnZlNkNZYU1iZnB6N284MFdqdlpUY0FsNlozR1pPMEc3YzZtUHAx?=
 =?utf-8?B?R041a0pyK0Q2OC9OczB3d0VlenFhSHR2OVJDaFFrV0NyZXlxcE1QSnp4ZTdB?=
 =?utf-8?B?VFBiTEhCSXRBdnlnaVVDdTVEUzgwY240L0taUkVEblp2S0U4QkUwQnRERWpW?=
 =?utf-8?B?dlA3R0Q0bzlpVHZjL0h5NTNURXRiczVRVFVkdmtMcEYweDhDcy9pOXFiaURU?=
 =?utf-8?B?NnpZU1hsMVNZQ2dtWFN5c09vWlh3Q3lheEdOYkZ4aCtaNXlHdjlyQWgrZDJB?=
 =?utf-8?B?QWVzb3M3ZzdsQ3BGaFo5Y1NQOVlQdXRFMUZBMEZSWG1RMTJnVnFQZnU2Vkcr?=
 =?utf-8?B?enFRa0JBWWxNcS85U2luUGY0eStlSEdJVWFmWDBnUjZmWXdUeFkvYURSWDhs?=
 =?utf-8?B?TmRUUHZDNStZck1iMjF0UVYzYXlmYnFoWHdlVzJsKzNCeXI0S241OVJpUWtn?=
 =?utf-8?B?aHpjZFFHVGlybmVJRWVGSlg5dEorTERmRTNZd0NvWEdnUjVwT0ZXeDBLL3hK?=
 =?utf-8?B?ellVcEZNTUhEdFNianVMeGNNWlMxLzgzeVFWYmd2R1FlMmV6WGxTejZ1QzZ2?=
 =?utf-8?B?MWV1YTVDZUs1cmw5MTUrVHg3SDFwY1ZhWDhoMVY4Y1BSNmp3VHFRQk1LVFNQ?=
 =?utf-8?B?eEd2OTBqNUxsNTc0RTF1ZlVnUVJLYnhXNWsrcEZHeGJEY0Z0NzRVOVh4a1pS?=
 =?utf-8?B?UFpteXp4L0xqQy8rb0R6S255ZmZRNDdpRUorVWxINGQ3WkM5eHZJaGNhL00z?=
 =?utf-8?B?K3BQVjR1YlRJVEhuMWpkNTUzaTdiWGxrQjZnbnAzeWdmZEVWMnpkNmdmU0Jq?=
 =?utf-8?B?ZzQzNjljOXc4V3JFTlMwaXNQZUZWbjhzNnNaTmg5MXRFSEhManpsQzM4dXll?=
 =?utf-8?B?WUlyWlRzcUFLVXhqUlJaY2xIekswV3o5b1V6R0dzOFFYOHVCQUhzSVdNOUUr?=
 =?utf-8?B?TVBXS0MxTC9kZmh5eHJPRHNCMHh2dGlORld2bHhNeVpkcUlJNjArVzU4YmI0?=
 =?utf-8?B?MW81YTBCZ3FlZXE5MWFQZnQrZFBCZE5BVWJOZ2l5TlphNTAzNENkbk15UmFz?=
 =?utf-8?B?T004SjBEL1FmbXo0WnhFU0pSd1R6TVQ2UU9keDNmdWtpNVRFdER6Tnd0RWRR?=
 =?utf-8?B?VGZDOVRHQ3RNUnluV3lDMXNXSUg0MTlRRmNYRkhnNUNxc2dFalVJR2ZFRDVs?=
 =?utf-8?B?VlNDQTRTTkpDQWJ5UTRIbjIzVE4vOU9ibE93RTFGcStORDY2Z0ZLeHhjOUtV?=
 =?utf-8?B?eXNOZWJmOGVHb3dxdG5IYnlaMzRMMWVUbno5STQ3am5KV1MzdEs0UDNuVE41?=
 =?utf-8?B?MnpCdktCL0ViclMxa2NCdjlheEJoNVBxM3VXSzNqRWRhNmQ2bmpzYWp5c2RQ?=
 =?utf-8?B?VHlWcUFPeDl3WWkzYVE0d2dNZi83ZEo0SDVWQjZCNzh4cXAzbndVOVQ1dG9o?=
 =?utf-8?B?ckgwV0hGSDRtM3NoR0pWZkVqcmYzMEdkWW82RXF6SE5xWExNalg2VldwU2hZ?=
 =?utf-8?B?WlR4bmJ1MTZQTDMzdmIrbERlTGpxUW9RUUZLQzl1V0R0WTdkVDROeUdSSUhB?=
 =?utf-8?B?VzlUUzh1aFJYK1l5b1JVbTVoSXFSRWZJUS9DK2UxaU9pUmxKdVoxK1lvRlg0?=
 =?utf-8?B?V0FOVFJ5ZGJ6UFRNcWd5UlZWaW1TWXlNZEhRMVhBNENhbXVISllzKzJXazFG?=
 =?utf-8?B?c3NFWU9jL2R1aVFud0hGR0FtZzNHMy9FdHRheWNHcUZmd2VGcHErK0JWVFRq?=
 =?utf-8?B?a1FNemt6OEluZWVJN0JUMGxyQU12RGxMZ3Y5MzlpZ2FOSWJLWWNwTENhN2FW?=
 =?utf-8?B?Yms4dEVyaEZ2N2llcVhuL0ZydmVycnJ3Wk9hcEZVV1Zjem91V2I1NDVaOEZs?=
 =?utf-8?B?ZkpDeCtVeW80K0N0K0RWM0p3dS9BZjJVeE1HWGxOMmRoaWVMcEgwcUFNNVRn?=
 =?utf-8?B?RU05THFqcTJTcjYyV1A4RkwvMTVaUWJtbVRmYTBGSDJmZVRkUTduV3RNUk5J?=
 =?utf-8?Q?eTdLiR1HhOgjszKryHUoxm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14CE5BF2B5944D44A4BF255DB979CDA5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0577136f-1c0d-49ab-6fd0-08d9d9aa35e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 11:12:12.0177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNzzlBrY5y8z8YZW6iG9B6UV/XWJ5rTRvw4GRnpPVTNbukL+TccTCRt76EyXf1dEPpqWvslHPLz98cde7aMk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2656
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10229 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170072
X-Proofpoint-ORIG-GUID: sQm14ZLbwSM3n2XImdBtQWgcMqHdK1Eo
X-Proofpoint-GUID: sQm14ZLbwSM3n2XImdBtQWgcMqHdK1Eo
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgSmFuIDIwMjIsIGF0IDIxOjUxLCBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEvMTAvMjIgMjA6MjIsIHlhbmd4Lmp5QGZ1aml0
c3UuY29tIHdyb3RlOg0KPj4gT24gMjAyMi8xLzExIDk6NDEsIFhpYW8gWWFuZyB3cm90ZToNCj4+
PiBUaGUgZXhwcmVzc2lvbiAiY29ucyA9PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmluZGV4
X21hc2spIiBtaXN0YWtlbmx5DQo+Pj4gYXNzdW1lcyB0aGUgcXVldWUgaXMgZnVsbCB3aGVuIHFw
LT5jdXJfaW5kZXggaXMgZXF1YWwgdG8gIm1heGltdW0gLSAxIg0KPj4+IChtYXhpbXVtIGlzIGNv
cnJlY3QpLg0KPj4gSGkgQWxsLA0KPj4gDQo+PiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2VlbXMgaW5h
cHByb3ByaWF0ZSBzbyBJIHdpbGwgcmVzZW5kIHRoaXMgcGF0Y2guDQo+PiANCj4+IEJlc3QgUmVn
YXJkcywNCj4+IFhpYW8gWWFuZw0KPj4+IEZvciBleGFtcGxlOg0KPj4+IElmIGNvbnMgYW5kIHFw
LT5jdXJfaW5kZXggYXJlIDAgYW5kIHEtPmluZGV4X21hc2sgaXMgMSwgY2hlY2tfcXBfcXVldWVf
ZnVsbCgpDQo+Pj4gcmVwb3J0cyBFTk9TUEMuDQo+Pj4gDQo+Pj4gRml4ZXM6IDFhODk0Y2ExMDEw
NSAoIlByb3ZpZGVycy9yeGU6IEltcGxlbWVudCBpYnZfY3JlYXRlX3FwX2V4IHZlcmIiKQ0KPj4+
IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+Pj4gLS0t
DQo+Pj4gcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaCB8IDIgKy0NCj4+PiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEv
cHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaCBiL3Byb3ZpZGVycy9yeGUvcnhlX3F1ZXVlLmgNCj4+
PiBpbmRleCA2ZGU4MTQwYy4uNzA4ZTc2YWMgMTAwNjQ0DQo+Pj4gLS0tIGEvcHJvdmlkZXJzL3J4
ZS9yeGVfcXVldWUuaA0KPj4+ICsrKyBiL3Byb3ZpZGVycy9yeGUvcnhlX3F1ZXVlLmgNCj4+PiBA
QCAtMjA1LDcgKzIwNSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNoZWNrX3FwX3F1ZXVlX2Z1bGwo
c3RydWN0IHJ4ZV9xcCAqcXApDQo+Pj4gCWlmIChxcC0+ZXJyKQ0KPj4+IAkJZ290byBlcnI7DQo+
Pj4gDQo+Pj4gLQlpZiAoY29ucyA9PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmluZGV4X21h
c2spKQ0KPj4+ICsJaWYgKGNvbnMgPT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJiBxLT5pbmRleF9t
YXNrKSkNCj4+PiAJCXFwLT5lcnIgPSBFTk9TUEM7DQo+Pj4gZXJyOg0KPj4+IAlyZXR1cm4gcXAt
PmVycjsNCj4gDQo+IFRoZSB3YXkgdGhlc2UgcXVldWVzIHdvcmsgdGhleSBjYW4gb25seSBob2xk
IDJebiAtIDEgZW50cmllcy4gVGhlIHJlYXNvbiBmb3IgdGhpcyBpcw0KPiB0byBkaXN0aW5ndWlz
aCBlbXB0eSBhbmQgZnVsbC4NCg0KWW91IGNhbiBzaW1wbHkgbWl0aWdhdGUgdGhhdCBieSBoYXZp
bmcgZnJlZS1ydW5uaW5nIGNvdW50ZXJzLCByaWdodD8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiBJ
ZiB5b3UgbGV0IHRoZSBsYXN0IGVudHJ5IGJlIHdyaXR0ZW4gdGhlbiBwcm9kdWNlciB3b3VsZCBh
ZHZhbmNlIHRvIGVxdWFsIGNvbnN1bWVyIHdoaWNoIGlzIHRoZSBpbml0aWFsIGVtcHR5IGNvbmRp
dGlvbi4gU28gYSBxdWV1ZSB3aGljaCBjYW4gaG9sZCAxIGVudHJ5IGhhcyB0byBoYXZlIHR3byBz
bG90cyAobj0xKSBidXQgY2FuIG9ubHkgaG9sZCBvbmUgZW50cnkuIEl0IGJlZ2lucyB3aXRoDQo+
IA0KPiBwcm9kID0gY29ucyA9IDAgYW5kIGlzIGVtcHR5IGFuZCBpcyAqbm90KiBmdWxsDQo+IA0K
PiBBZGRpbmcgb25lIGVudHJ5IGdpdmVzDQo+IA0KPiBzbG90WzBdID0gdmFsdWUsIHByb2QgPSAx
LCBjb25zID0gMCBhbmQgaXMgZnVsbCBhbmQgbm90IGVtcHR5DQo+IA0KPiBBZnRlciByZWFkaW5n
IHRoaXMgdmFsdWUNCj4gDQo+IHNsb3RbMF0gPSBvbGQgdmFsdWUsIHByb2QgPSBjb25zID0gMSBh
bmQgcXVldWUgaXMgZW1wdHkgYWdhaW4uDQo+IA0KPiBXcml0aW5nIGEgbmV3IHZhbHVlDQo+IA0K
PiBzbG90WzFdID0gbmV3IHZhbHVlLCBzbG90WzBdID0gb2xkIHZhbHVlLCBwcm9kID0gMCBhbmQg
Y29ucyA9IDEgYW5kIHF1ZXVlIGlzIGZ1bGwgYWdhaW4uDQo+IA0KPiBUaGUgZXhwcmVzc2lvbiBm
dWxsID0gKGNvbnMgPT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSkgaXMg
Y29ycmVjdC4NCj4gDQo+IFBsZWFzZSBkbyBub3QgbWFrZSB0aGlzIGNoYW5nZS4NCj4gDQo+IEJv
Yg0KDQo=

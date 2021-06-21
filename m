Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD13AECDE
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 17:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFUP6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:58:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1060 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhFUP6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:58:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LFqCUF015300;
        Mon, 21 Jun 2021 15:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=G0RfyIOPK8HuMKbvOeCvU3iryII/1CmY1l8w1hptnbQ=;
 b=UYW0I2uPJHI8DGhEjNH6RkHGGGYc59e+awV3KviyVlPLe+cKuF6dFnHYJO5h0tSKTZ47
 +dh/CSBnJgvCImMguYplwO0HdwhiMc0N0xnV5MR+UkJRVits86EDpQUaEYZlzXoDaVfz
 g7mfc/bg3ULZjikK8Krpt9dxxgAoK1sN/a0MADeZqeogpJZh/zWzrEejea5lx1uSBYNc
 4MefNJoGSi5RYIr8GTZi0Ou6VsNdWGx5qQ7WZLhfgyGf5BjPZGRejGCdf8pBYwrDKd4Q
 SDGfC9acyMhEbpXcuSB2gQ8jVAZLHV42JA9o5/STnaeNtloZ6TwjZVQi4oD6e73t4nEp DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyq9r5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:55:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LFpNeP129709;
        Mon, 21 Jun 2021 15:55:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3998d621hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 15:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMo8xceHJg4KE9DDiv/qa7FKsPoG5XNk5Crf4KbwPyIE4ewMd6yhSJKmg8yVGY626zaC+F1FAGONbMBxI6XzW5LA+cUZULsXUAMtJbG+qaR/EZyls76ThoSdx3oHfdNadQYHQhTFguND7VJMx+x/xVwNTAcfIQn1X8PEuQnNUR8ej3Ps6TDpN6C2692QHmxzX1/14KK0x7m+dJZ+VwVhAbJWxIVPfTJbWdX0jodnrUu9vrVjNwfEri+3voXaFUKGqOuH9oZv29Jggf30oz/oUTs5mVKbgNIX1kmPUgYB0xIA2RRPYduTd/OqOryxBtV2jgXAjyYPG4VavPhyfzJ5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0RfyIOPK8HuMKbvOeCvU3iryII/1CmY1l8w1hptnbQ=;
 b=KGhHWYPajFdoPbTnDt9F2Sxf83uXuIpQboS5on8YpdPM4Pdu3xI0bfycl3bXJs6oRMQC8FRBjWhj6QAUMQPgDJyCHzJxmPuF5TvuqgfyI/izqkI0FFHyP9kw+rG4YG/ORvd78c0MA1C40pQ1GuR9XFxC4P0Uj0+f78uKUNrYTl1tcyU4uCNj6Nff7gjAHvyg1SsH16y+VTtvTMhN2W8Ln3oFdt3SFEy4B+77WU5YVrAapTbqblEtV0iW7QhDBzeR1nAbSDJ+45kVedtRPS97cRC4S0vc+xlT82ZBTxE0LS/0QMXHhk5UG1H8YxgEi1ABIwNCPzjLW1+GYhNPSni7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0RfyIOPK8HuMKbvOeCvU3iryII/1CmY1l8w1hptnbQ=;
 b=qIB6UjM2o2MbgsjTZv45kO/SzQKaxayM8eK/BWjItcUyClgzZ6bFOo5JZzomYtRTs0lv11K9zbKGbKH+APiSCN+qTgWnzaax1bE2LK4pTzIebguKGWzYeCTLvpI/pIe6tfCOSwkhxL8KQPr1L8TbGNYuCfLOHls6HQeTgdtkDrA=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1383.namprd10.prod.outlook.com (2603:10b6:903:2d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 15:55:40 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:55:40 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXY3iqQ+lwecvXsUKE5x7HSp6gYKseEhgAgAAToQCAABoOgIAADqSAgABAsgCAAAXOgIAAA+QAgAAMAoA=
Date:   Mon, 21 Jun 2021 15:55:40 +0000
Message-ID: <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal> <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal> <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
 <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
 <20210621151240.GQ1002214@nvidia.com>
In-Reply-To: <20210621151240.GQ1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75931d46-74ae-44c6-defb-08d934cd04f5
x-ms-traffictypediagnostic: CY4PR10MB1383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB13831AE84B35FFBE9328207AFD0A9@CY4PR10MB1383.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mW5zob/XSsD2HUN/ikCgw+UmIDt4xR1lIsQYhR1eEue1krtTarMG1sYGh08FLD64UaWh1ypM9SVc6oM7AZTT49p/2zYj0dIgUvJksLXE7PJz44UamKE9394eqPQA2tS6GzUCVNPS75iW+c969mfPlRvoEdTioCI9VNAR7dwvdl3Kk5PlAD5zfJWbbU0O++LR2ZgZIQRishbtsES+MSm0u1Uo6ej7VyhmwNbunly2xpATvogXkwJF2ITyKPWJ0C7RRupNj7Vbfuki+bNbgVy9frtF5sHUnO32FWZZXHEVOijXn8QwykNFAlFmSnRZZ6eP4ZwcAzqA+j3UoFWv5dQHpWBQuKDq1SNnmyVV6IM7mkPfs+q0Mda+QaOETNwwsOuxhDH+4IPpdMvk9V+FsNVW3Ghon5fLdENYy80SjccM/Zcw1NDWsTKKj6Gry1/kCoKr49rboyORtW2Oq8edVTtx9Xk6xYqwn00rZJSIFPMlVcTSLLm57yr6vUsEBzhXy9On7RsWQw85oHexuu+qWxgtPlTOCnu79mduC4O1DIHzVodjqD+ujr4/F5KO6Ah8nWDZ21h9wXTwU7xRWnejRDcrzcniBljQc1fo0njf/5zMMAVfOlbYGUAcQmLw36Fn0DXeWe2WV95QdYuTDZ3vTz/zeO5N4Enf5BULzTYGDlq2me6GKpTbM/8U0UiBw6FR+B+/SB9QRiTJdRBf/aMdfhCGcIoRkpi6fSPTNZ9xcl43oLZP0Y1F9zPB2Ikyrsk9nmAM9NldSBEDPJNk6OT1IUruaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(83380400001)(4326008)(6486002)(36756003)(186003)(26005)(478600001)(8936002)(966005)(53546011)(6506007)(2906002)(316002)(2616005)(66574015)(44832011)(107886003)(54906003)(33656002)(5660300002)(71200400001)(66556008)(91956017)(76116006)(6512007)(8676002)(64756008)(122000001)(6916009)(66946007)(66476007)(66446008)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejA2YTJlVGFKVWV4K1VZVEVXb2Z3TFZzaXdtd2p2VkFxeEZvd2xnbHBEdlMr?=
 =?utf-8?B?VFRpRExpUHp5NE9CNU54UU1RREwrWnpzVzhzcVBnSVpGV1VzbGVySENFbnhh?=
 =?utf-8?B?MEdtckRJeUJjK00zS0JqOVFnTmw4TDFjZWcwbTZwMlBXSXdEbllOYVVkem1B?=
 =?utf-8?B?NFdJR1FKU2ZLS2FZeWZ3ZDgzTDNhcjlVVkdleEVJOTlCSjdlT2FwRXVvbFdV?=
 =?utf-8?B?S3UvVFhOaGlGcldGdklZYWNGL1ViaWNOdkV5NXdMVm9NamxibmYrUmRZUlR5?=
 =?utf-8?B?ak41eDhoSDRjbk10RlZ4VmRkdDFXQ29rOTFvczcydVV5c2l2ZmFlZFl0MlpY?=
 =?utf-8?B?Y1pmRHcrSGJNZnkzbHoxZHMvMlVMdWJlc2I0L1FBbXN1MHZ5VGk4TnFUT3Zm?=
 =?utf-8?B?eWRFVk5NZ2VGYXpJOEJaUktGZkJvandFVVBLNEtVRks0dnpmUDRseXVyOTdQ?=
 =?utf-8?B?QjJwd3ZnMy8rUHE2cXdIMFRndFBVUU5uQ3hoaC8rTjdGdENreHpYL3RMbzly?=
 =?utf-8?B?dWZ6Y2lDVmFRRlNxZUJxSDhMd1VDT3ZqT2tPZU1nN2ZKTzRRbjUwZWcrUkMr?=
 =?utf-8?B?RU4yOUZDdHg4UmQyOHZmMEs0aWpTWm4yZXdxdHN0VG1HUVhpNnZaYUIrM3Zs?=
 =?utf-8?B?eGRiQkQ1WFA0Q0lIeG9ieWZZODRtWFNZQ2IzQXdmL0w1TzNSMVRGR3FveUx4?=
 =?utf-8?B?azFnbUZobEFMUXZmTDRuWkpDYmY2ZWRMVmgrS3U1S3ZWVHE3cFBiUWxlMFhx?=
 =?utf-8?B?SkwvMTJsUWlHMDV5cnNQRlAvMkpVeDRMN2owTXBLSFpTSU92QVplQTFsRHpE?=
 =?utf-8?B?UWRXSmkxVWlDK3BEdGovNk1GZXI1Z1ZjaG44SEs4Wkx6SlE2VzB2YTl4MkpI?=
 =?utf-8?B?eXhoS1ZIcmJEd0ZnL2FUc2wxdnlsOXJ0cURpbUU1Y3E2MXBkMXpVS2tBVklI?=
 =?utf-8?B?VVBiUWlOMm5xTXpPNnU0VFRUTTBhK0ZVbnM4K2xCVS9yU2EwT0tXYXh1Ny9B?=
 =?utf-8?B?NTAwa21heFVuT1dmSlViclZxNE1abm4yZTJUWW5OUGg1K3FRZmk4Z2syQ1BD?=
 =?utf-8?B?bFE0Q0MvUXpQMDhGRit6anROSkxCYk5IVms0TnlGZFZvR2ZJNE1PRzRtTlVX?=
 =?utf-8?B?YnV2clZqYXFjQldDQjAzTzFPSFljQlgySWtzUW5EYTZDZnoyV05zZmpUMzhK?=
 =?utf-8?B?d3VmOS9NWWdENDRFSG9Ga0pOQnJBc2dMcG9FNlVwaXFFdWJOTWRoUTQ3VUNT?=
 =?utf-8?B?dmpockRnVmpqTkYwV2FhZ2pKbkYrUmI2SmRSUDVGMHJZcnFhK1NMTHg3STlJ?=
 =?utf-8?B?MjQzVEdjczJsOVpOVklBOUFuVURQcWIwOThVb0VPTXVBalBtWTE0bmV0SWtQ?=
 =?utf-8?B?VDBzSVNkMlNaOU1aaEprZFREZGdUN1NhZmJheFhrcjFMTWVmS2VZWWdQaGcx?=
 =?utf-8?B?K3RmRU1PL1dOQk40MDQ5UTNPV2JQNUpJdUNBWTlpMUpTeGk0RjYwbWROL3VV?=
 =?utf-8?B?Zk1HNmNKZFpNaFQ5b091b1AvOGkxV1hpZ083M1ZNSnBtR2lIV1c4eHpaZlMw?=
 =?utf-8?B?eVJDR3hxVTZ2OER2VUgvS3J4UDh1U3FWck02ZDJOTDJQZ1U0blhOcWYwMUNX?=
 =?utf-8?B?OW9FeVdxZ0JreEZOS2V6aVdpQ2JTZDlnU1kybU9wVDcvdy8rVTcyZmsyeFY4?=
 =?utf-8?B?cVN5Q1orcDBCckFaN2t6TS84bkxZNTFIc0VPdEZCUjNQbE5RNFQwS3U5SDE5?=
 =?utf-8?B?bWIwd1kzNkJuOHJjR1R1a3JOWDZUa3NrTEhTVlAzSjU5eGZTMHhXVGlMZENt?=
 =?utf-8?B?QWVsOTNKcFdoL0liMkRxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE68234B517E44AB3E870ED34150C38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75931d46-74ae-44c6-defb-08d934cd04f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 15:55:40.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eysXV/05HyVb0bDZ6lJbftM0AcpyaVGJuA94WAa3d7rOgPJP33C5fk28DKqGSSeNDy2Mvu/Kqsy2TacVuaX3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1383
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210094
X-Proofpoint-GUID: lCN2f9r_0eXH97kLwS59sbEq9Iz1POyN
X-Proofpoint-ORIG-GUID: lCN2f9r_0eXH97kLwS59sbEq9Iz1POyN
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDE3OjEyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDAyOjU4OjQ2UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMjEgSnVuIDIwMjEs
IGF0IDE2OjM3LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAxMDo0NjoyNkFNICswMDAwLCBIYWFrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4gDQo+Pj4+Pj4gWW91J3JlIHJ1bm5pbmcgYW4gb2xkIGNoZWNrcGF0Y2gu
IFNpbmNlIGNvbW1pdCBiZGM0OGZhMTFlNDYgKCJjaGVja3BhdGNoL2NvZGluZy1zdHlsZTogZGVw
cmVjYXRlIDgwLWNvbHVtbiB3YXJuaW5nIiksIHRoZSBkZWZhdWx0IGxpbmUtbGVuZ3RoIGlzIDEw
MC4gQXMgTGludXMgc3RhdGVzIGluOg0KPj4+Pj4+IA0KPj4+Pj4+IGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDA5LzEyLzE3LzIyOQ0KPj4+Pj4+IA0KPj4+Pj4+ICIuLi4gQnV0IDgwIGNoYXJhY3Rl
cnMgaXMgY2F1c2luZyB0b28gbWFueSBpZGlvdGljIGNoYW5nZXMuIg0KPj4+Pj4gDQo+Pj4+PiBJ
J20gYXdhcmUgb2YgdGhhdCB0aHJlYWQsIGJ1dCBSRE1BIHN1YnN5c3RlbSBjb250aW51ZXMgdG8g
dXNlIDgwIHN5bWJvbHMgbGltaXQuDQo+Pj4+IA0KPj4+PiBJIHdhc24ndCBhd2FyZS4gV2hlcmUg
aXMgdGhhdCBkb2N1bWVudGVkPyBGdXJ0aGVyLCBpdCBtdXN0IGJlIGENCj4+Pj4gbGltaXQgdGhh
dCBpcyBub3QgZW5mb3JjZWQuIE9mIHRoZSBsYXN0IDEwMCBjb21taXRzIGluDQo+Pj4+IGRyaXZl
cnMvaW5maW5pYmFuZCwgdGhlcmUgYXJlIDYzMCBsaW5lcyBsb25nZXIgdGhhbiA4MC4NCj4+PiAN
Cj4+PiBMaW51cyBzYWlkIHN0aWNrIHRvIDgwIGJ1dCB1c2UgeW91ciBiZXN0IGp1ZGdlbWVudCBp
ZiBnb2luZyBwYXN0DQo+Pj4gDQo+Pj4gSXQgd2FzIG5vdCBhIGJsYW5rZXQgYWxsb3dhbmNlIHRv
IG5lZWRsZXNzIGxvbmcgbGluZXMgYWxsIG92ZXIgdGhlDQo+Pj4gcGxhY2UuDQo+PiANCj4+IFRo
YXQgaXMgbm90IGhvdyBJIGludGVycHJldGVkIGhpbToNCj4gDQo+IFRoZXJlIHdhcyBhIG11Y2gg
bmV3ZXIgdGhyZWFkIG9uIHRoaXMgZnJvbSBMaW51cywgMjAwOSBpcyByZWFsbHkgb2xkDQoNClll
cywgZnJvbSBsYXN0IHllYXIsIGxrbWwub3JnL2xrbWwvMjAyMC81LzI5LzEwMzgNCg0KPHF1b3Rl
Pg0KRXhjZXNzaXZlIGxpbmUgYnJlYWtzIGFyZSBCQUQuIFRoZXkgY2F1c2UgcmVhbCBhbmQgZXZl
cnktZGF5IHByb2JsZW1zLg0KDQpUaGV5IGNhdXNlIHByb2JsZW1zIGZvciB0aGluZ3MgbGlrZSAi
Z3JlcCIgYm90aCBpbiB0aGUgcGF0dGVybnMgYW5kIGluDQp0aGUgb3V0cHV0LCBzaW5jZSBncmVw
IChhbmQgYSBsb3Qgb2Ygb3RoZXIgdmVyeSBiYXNpYyB1bml4IHV0aWxpdGllcykNCmlzIGZ1bmRh
bWVudGFsbHkgbGluZS1iYXNlZC4NCg0KU28gdGhlIGZhY3QgaXMsIG1hbnkgb2YgdXMgaGF2ZSBs
b25nIGxvbmcgc2luY2Ugc2tpcHBlZCB0aGUgd2hvbGUNCiI4MC1jb2x1bW4gdGVybWluYWwiIG1v
ZGVsLCBmb3IgdGhlIHNhbWUgcmVhc29uIHRoYXQgd2UgaGF2ZSBtYW55IG1vcmUNCmxpbmVzIHRo
YW4gMjUgbGluZXMgdmlzaWJsZSBhdCBhIHRpbWUuDQoNCkFuZCBob25lc3RseSwgSSBkb24ndCB3
YW50IHRvIHNlZSBwYXRjaGVzIHRoYXQgbWFrZSB0aGUga2VybmVsIHJlYWRpbmcNCmV4cGVyaWVu
Y2Ugd29yc2UgZm9yIG1lIGFuZCBsaWtlbHkgZm9yIHRoZSB2YXN0IG1ham9yaXR5IG9mIHBlb3Bs
ZSwNCmJhc2VkIG9uIHRoZSBhcmd1bWVudCB0aGF0IHNvbWUgb2RkIHBlb3BsZSBoYXZlIHNtYWxs
IHRlcm1pbmFsDQp3aW5kb3dzLg0KPC9xdW90ZT4NCg0KT2NjYXNpb25hbGx5IGVuZm9yY2luZyA4
MC1jaGFycyBsaW5lIGxlbmd0aHMgaW4gdGhlIFJETUEgc3Vic3lzdGVtIHNlZW1zIGxpa2UgYSBz
dHJhbmdlIHBvbGljeSB0byBtZSA6LSkNCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+IA0KPiBKYXNv
bg0KDQo=

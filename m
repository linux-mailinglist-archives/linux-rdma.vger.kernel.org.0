Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6A3A98FF
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFPLWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 07:22:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhFPLWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 07:22:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GBCVCk001736;
        Wed, 16 Jun 2021 11:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Zd7oI5lIbGi0dskCI7MA3u/FJ5G9IjwBNjE/E1ENOTQ=;
 b=yCfk+7W1OxEPRJbV5DjF6JskqFXE1OlBDFEvoMqXHiKqD0hXR646nAmE3QuBiqXg7/L6
 KNMV4IdZzU4a9dXsE3Ra87ITLjtlL+aGIhqlATrvXiNwmir1YgIs+I4wN1gn4L8hS1x2
 nw8sAywRebMMIc0AtNBab0wRzyVdGTPgsFPnJO//gd6jBvBHwyTm2zLieXr9MywD8BMB
 t7+GeycW+dCf7FX2ZaEwiI5+Dk/RycPStiKd5v4MT/qeu1kvlF5mrIz9A573lrtXclMj
 jzCDzBopCyA8GK51jjQr4LpmsBDmq9Pf+663QX6G5FHd2KAMQebKtWyevMj4TfH2bk34 Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770h8uka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 11:20:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GBB2sI145465;
        Wed, 16 Jun 2021 11:20:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 396wasxdc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 11:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlD7HiAIPRStz2tKWX/PUjbpR0v+a7NqvHMpQ5ZNt0tRlZpKp3x+AeiTNDvX1WKrTvXNi9Ui4S6n+fWfm6aK3yn73Br+AmudsMg4xw3UN82ltIGKpU7Kb6TdcKQFlKmrGeB/EFjBwECQxNvjmAYoDz4h52fcz2qJKTNZp+nQUoktoPNURFulgEHLhy7gxMas5rYUHSf+PTMmLgm8wI9iKUDsbJUbkhxuLvdItNX2JuNHtEN3iBedcMCPVfg434yhadHQbkjlJ5g+8xOpm7tltl+2xUGPqvmxEZeTXlBWBTCfezrWA9rq4/1VvLInE+oEdNB/ms3G0Omw5EsA7dYuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd7oI5lIbGi0dskCI7MA3u/FJ5G9IjwBNjE/E1ENOTQ=;
 b=PLgvUAqvSEKT6IYCobtX4WDESxIAc+mpxbCeaJ9FNdibLab243If9EMrZZAkg8U9MjMZgoWCIDWH45+8f+UOJBnWjwKCBWJguCmhhQ70bt+8fseUpSZXOgJ29v+JuioGhPZXIoBjf/hM8ssWMSv368aH35kL5FDbFTZLFH6yz3+6fhyR6LYscEx+LVUn4gw2vhvVxg4Mn0A7l2fsW13/UkWMqn6yW4MiLvq54hVyTeA9VKXrQtAWkHtDyeBBaBwr2lsIrTmnxIVvdJRAsyS3QuDsIB7q9S71RI3v3nEF2cc2xIA8zPbp/RCyN5gDegCTTqMzKSxRSOnbbLIcqFcJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd7oI5lIbGi0dskCI7MA3u/FJ5G9IjwBNjE/E1ENOTQ=;
 b=PAXQDcyHLvmdAu/AFq2Qtquk9XdiF4Aul0mBL4wijt7dGNjhjZmc8XpATOp8Y0zmceAGsVxjQR9Azm1jpu/3Ln1vP3tqQpq5C0P4WGqFACd3bwCqDgOOBsLI5b6h3UWeTRaBM0WbkUzlBWyUiacNmthrgx82vJwdZ0jJtToO0/U=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1415.namprd10.prod.outlook.com (2603:10b6:903:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Wed, 16 Jun
 2021 11:20:01 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 11:20:01 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Topic: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Index: AQHXXPQdh88l+xVVXkWdtTnBVCg426sLWyGAgAAN5YCAABS+gIAHZCwAgABBEgCAAJfiAIAA1DSAgAC5roCAAUBngA==
Date:   Wed, 16 Jun 2021 11:20:01 +0000
Message-ID: <76766414-4D50-4E60-B3FC-1989026562D9@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com> <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal> <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
 <YMcEbBrDyDgmYEPu@unreal> <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
 <YMg111mLzwqu8P0o@unreal> <427FB96F-2550-4106-B8AD-EC589C1FD82B@oracle.com>
In-Reply-To: <427FB96F-2550-4106-B8AD-EC589C1FD82B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98694f31-eb2b-4b5f-c768-08d930b8aef0
x-ms-traffictypediagnostic: CY4PR10MB1415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB141511D724AFFA0202C54636FD0F9@CY4PR10MB1415.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1R3CThIvKb8lAQMR4XG5OhR4iMrifkXfZ82EoGjPU6ptIKpFCTE2TmkrkNAauNSTN8RXRV1zSC4ujyLdBOb4yz1JIQBnuhcMsH358nYcQ6zuGS+a84r83SBCcBrVWafXt5BZ8GWDC1sbbDNgjKbE81XvmG4LLAmyUTQNMWAVB1TGIj3XMf8T9yIsmPtW5x/EbhhXp25JhPl5y/Rxp9MmwGKIV35AI+/rbcXW5JOEV/eWp6sKFGO9aEjw5cooq5mjafGkxDKQ4iyhPfvsZpGtMEHXB5P2H8hq5UepjU27gBqSuSm+G22He7zkc21SLpmQ/qFkMGzpL4mcbBYv5a6R9ohiXLkHDFuks6nwXQ6mgBhu0hYXfzPv3hJvCu3gfsE1kLj2Iz/hFOqRgW0orB5svt/IijseOtjQFcc/7cHyPs0RRaiTeeoFoq9sT3vgFGj3eLziOjHSCLBcJ8Wjvox8vbFX+zvIevzvcm/4q75az3Pm7X6wvxR9yXrCdXvptVG7tzeiaDno/K32+/5iHttlkuBKaNvkLk++xLqaYvXgfDxTVox2dpSTD0dfHhmctyYVb9D58ZQk5d/2ogMVRZU21Bb/qAAQIwEuMy7FKhNMlg0iveiId0GXKXogzfV1CZ6W7JHNRScHEWXXpys3isW5tJgCdw3zSi4ziTyLw/gHvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(136003)(376002)(66574015)(38100700002)(36756003)(6916009)(122000001)(8936002)(54906003)(478600001)(6486002)(33656002)(71200400001)(316002)(2906002)(4326008)(86362001)(6512007)(91956017)(66946007)(26005)(8676002)(2616005)(64756008)(66446008)(66556008)(44832011)(83380400001)(5660300002)(66476007)(6506007)(186003)(53546011)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czNMbUJQSHRiNFFKdFJxeVpKbWlKMXl1cTVveitxY1BPRFpLNHdzUDNWVUxa?=
 =?utf-8?B?QjZDZ09lc1dhOXpteWdRQmpYUlhBcW9qYUV2VFRucmFaM3RyWGRHVXRQV1ZD?=
 =?utf-8?B?c1ZQMllWLy9rWldrWXFrTHo4ZnA4dCtCZ2dKbDhQOVJUaFNHWWg4WmhtYkpl?=
 =?utf-8?B?Y01zN2pWczFXSStYRWgxM0R0VlY5Z0dUb0tjc1NYbWdnTGVDNytteWI3N0ZS?=
 =?utf-8?B?NkxQWm1XTFRQNWRIYnRGMnY1ZHE2cHRJSVhjeGNlYVU2cEYxNGdFRU9lN2ov?=
 =?utf-8?B?QlM2WFM0dEhKZTZBRk1velZZL1Vsc25MczkwaHloTzh0UmE4RmtyeXovQ2t1?=
 =?utf-8?B?WEFYNGN6bUZqNTVqTFE2cG9YWi95aEZwdlNIOW0waXhnL1BpSS81bWdqUFp0?=
 =?utf-8?B?WW11QTVmQ1NhaWZnVnUzOUFOcjhYZVRlTW5nWW05UGRZbWUyZ094THdqQ1V5?=
 =?utf-8?B?VkhjRnFPMktPYW5rYXdaOXR3WUtoaEZSbVJoMzZTZVpWT21vSmZhc2swNjgx?=
 =?utf-8?B?ZWkyYmVKQmp5bytaQU9LN09WQUM0dnFOMzNXT3RpdGl6U2MrL2hBYXVkaFYr?=
 =?utf-8?B?VVM1YTlIOXFOWHd1NnZIeFZVQldFeXBYOG5waGUrMzJmZEo3bDB6QzBLUVdx?=
 =?utf-8?B?b1BRV1N0Ykd1UmtFTG82UzdnSzJDWXZBOTZURko5UVJxMUVFUlhFOXRpT1Fz?=
 =?utf-8?B?aHlHSThQTGpFeGNQSjBVWDhOUUI3MXNOOWNQemVRRDgxVDhGZVVZSG9qMWsw?=
 =?utf-8?B?aUN4R0JuZVYyck55Lzg2TlhFVUN0OUZOMXAzSGNON1VHS3lFSXdFUlNLeHF4?=
 =?utf-8?B?L2lJcGdhZTk5MjJ1b3FGQzc1dDZ6Y3ZMdnpvbFdxTGM4WEhlS1JBLzEzQ20z?=
 =?utf-8?B?Yk5TaGhldTI2eExKSEo5Yi9aVmVzSS9MQVdWdmFQU21ZRUFFTzZHd0owTEQ5?=
 =?utf-8?B?Y1VBWU5GckpCbHZhSnUzZTJ6aVhCNzBNMXBIZkZ1TVdPamtJTE8vbDQrekly?=
 =?utf-8?B?b09tUWM5Rlhob0xycHphZWtaZnBlWUp1VUxqYUVuVE5XTTZrVFVtN3VQQ1hz?=
 =?utf-8?B?OG5lU0k4VDUzZmxOalRYNVJpeE9QdktuYkNTSHlnQmdBUmJ1ekFhTUxZQWE3?=
 =?utf-8?B?NXRwd1QyM3Z1OFdCcitpRkNTUjJLNWZHMElYeEVrMllsUCsrc21vanRaT253?=
 =?utf-8?B?b3Q1R0dMMlc3RktLVUxYSVdXaUFIZkNQamM5eHRUZ2ovM01TQ1VRRmZYZGNV?=
 =?utf-8?B?UHp3ZXNyRzZ2cWhLZnU5ZG1nQkhRaVBPWVF6emVHYUhFaUloUjdkT0NsUkhZ?=
 =?utf-8?B?ZHRlaVpjdTlRMlBlUTcwSldpclVzbDkvOTd5L3ArcFhDWXpySjFvMzlRbjB4?=
 =?utf-8?B?RUZ4VmsrN1ZjNmRFY1l5Y3BDUGk1YXdWV3lyOVRrRmExTjZLS0dIQW5tVXMy?=
 =?utf-8?B?OWFNcTRLSXJyUjRwdzlxRG12T1ZRSzR6WWducFlWY1dMR1NTWVBhMytTUjJ4?=
 =?utf-8?B?ekpBaFl2TWIzbEtHb0ZGNWR3TElMNGIxdVdmZGc0UXVMclVGRC8vS0VZd0R3?=
 =?utf-8?B?cXhLYm8ycEE5R1J1TFQrMDZKbzFtMGNaR2VDcUtJK2dSQUcvai9hU1g4M1dE?=
 =?utf-8?B?dE1JZVZaMlM0Q3pxVU1pLzhtdE5uejBidm93cXh6UllWVkk5cFNHTndCNE1y?=
 =?utf-8?B?bXNpNUk2Y1ZqOVMvVnc3UVNDTFhsYlBaRkxaVkhLTGVmMWp5SkZad1BTZ3cw?=
 =?utf-8?B?UTJ0TjkvT3kyQUFIU2VIUis3aHh2TVdDNXVEZmVvUkJoU1FtcVBnTWNoMStu?=
 =?utf-8?B?dnpVOTdGM1l1N0xlenNLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D714E6BD9FE9854E83AFC95F63E3F372@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98694f31-eb2b-4b5f-c768-08d930b8aef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 11:20:01.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofw+gs/0XLzRyO88cisergSgKp+XKT7imSGu7wWXS/JhO8l6aH9RvvJmuCELaKGVsq65du7CV2xopaGUJUwUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1415
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160064
X-Proofpoint-GUID: vv96IdLxXvtAV-HFU49ZqW0B6MJRrxTi
X-Proofpoint-ORIG-GUID: vv96IdLxXvtAV-HFU49ZqW0B6MJRrxTi
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTUgSnVuIDIwMjEsIGF0IDE4OjEzLCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDE1IEp1biAyMDIxLCBhdCAw
NzowOCwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBP
biBNb24sIEp1biAxNCwgMjAyMSBhdCAwNDoyOTowOVBNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3Jv
dGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIDE0IEp1biAyMDIxLCBhdCAwOToyNSwgTGVvbiBSb21h
bm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gT24gTW9uLCBKdW4g
MTQsIDIwMjEgYXQgMDM6MzI6MzlBTSArMDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0KPj4+Pj4g
DQo+Pj4+PiANCj4+Pj4+PiBPbiA5IEp1biAyMDIxLCBhdCAxMjo0MCwgTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFdlZCwgSnVuIDA5
LCAyMDIxIGF0IDA5OjI2OjAzQU0gKzAwMDAsIEFuYW5kIEtob2plIHdyb3RlOg0KPj4+Pj4+PiBI
aSBMZW9uLA0KPj4+Pj4+IA0KPj4+Pj4+IFBsZWFzZSBkb24ndCBkbyB0b3AtcG9zdGluZy4NCj4+
Pj4+PiANCj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSBzZXRfYml0KCkvY2xlYXJfYml0
KCkgYW5kIGVudW0gaWJfcG9ydF9kYXRhX2ZsYWdzICBoYXMgYmVlbiBhZGRlZCBhcyBhIGRldmlj
ZSB0aGF0IGNhbiBiZSB1c2VkIGZvciBmdXR1cmUgZW5oYW5jZW1lbnRzLiANCj4+Pj4+Pj4gQWxz
bywgdXNhZ2Ugb2Ygc2V0X2JpdCgpL2NsZWFyX2JpdCgpIGVuc3VyZXMgdGhlIG9wZXJhdGlvbnMg
b24gdGhpcyBiaXQgaXMgYXRvbWljLg0KPj4+Pj4+IA0KPj4+Pj4+IFRoZSBiaXRmaWVsZCB2YXJp
YWJsZXMgYXJlIGJldHRlciBzdWl0IHRoaXMgdXNlIGNhc2UuDQo+Pj4+Pj4gTGV0J3MgZG9uJ3Qg
b3ZlcmNvbXBsaWNhdGUgY29kZSB3aXRob3V0IHRoZSByZWFzb24uDQo+Pj4+PiANCj4+Pj4+IFRo
ZSBwcm9ibGVtIGlzIGFsd2F5cyB0aGF0IHBlb3BsZSB0ZW5kIHRvIGJ1aWxkIG9uIHdoYXQncyBp
biB0aGVyZS4gRm9yIGV4YW1wbGUsIGxvb2sgYXQgdGhlIGJpdGZpZWxkcyBpbiByZG1hX2lkX3By
aXZhdGUsIHRvc19zZXQsICB0aW1lb3V0X3NldCwgYW5kIG1pbl9ybnJfdGltZXJfc2V0Lg0KPj4+
Pj4gDQo+Pj4+PiBXaGF0IGRvIHlvdSB0aGluayB3aWxsIGhhcHBlbiB3aGVuLCBsZXQncyBzYXks
IHJkbWFfc2V0X3NlcnZpY2VfdHlwZSgpIGFuZCByZG1hX3NldF9hY2tfdGltZW91dCgpIGFyZSBj
YWxsZWQgaW4gY2xvc2UgcHJveGltaXR5IGluIHRpbWU/IFRoZXJlIGlzIG5vIGxvY2tpbmcsIGFu
ZCB0aGUgUk1XIHdpbGwgZmFpbCBpbnRlcm1pdHRlbnRseS4NCj4+Pj4gDQo+Pj4+IFdlIGFyZSB0
YWxraW5nIGFib3V0IGRldmljZSBpbml0aWFsaXphdGlvbiBmbG93IHRoYXQgc2hvdWxkbid0IGJl
DQo+Pj4+IHBlcmZvcm1lZCBpbiBwYXJhbGxlbCB0byBhbm90aGVyIGluaXRpYWxpemF0aW9uIG9m
IHNhbWUgZGV2aWNlLCBzbyB0aGUNCj4+Pj4gY29tcGFyaXNvbiB0byByZG1hLWNtIGlzIG5vdCB2
YWxpZCBoZXJlLg0KPj4+IA0KPj4+IEkgY2FuIGFncmVlIHRvIHRoYXQuIEFuZCBpdCBpcyBwcm9i
YWJseSBub3Qgd29ydGh3aGlsZSB0byBmaXggdGhlIGJpdC1maWVsZHMgaW4gcmRtYV9pZF9wcml2
YXRlPw0KPj4gDQo+PiBCZWZvcmUgdGhpcyBhcnRpY2xlIFsxXSwgSSB3b3VsZCBzYXkgbm8sIHdl
IGRvbid0IG5lZWQgdG8gZml4Lg0KPj4gTm93LCBJJ20gbm90IHN1cmUgYWJvdXQgdGhhdC4NCj4+
IA0KPj4gIkhlIGFsc28gbm90ZXMgdGhhdCBldmVuIHRob3VnaCB0aGUgZGVzaWduIGZsYXdzIGFy
ZSBkaWZmaWN1bHQgdG8gZXhwbG9pdA0KPj4gb24gdGhlaXIgb3duLCB0aGV5IGNhbiBiZSBjb21i
aW5lZCB3aXRoIHRoZSBvdGhlciBmbGF3cyBmb3VuZCB0byBtYWtlIGZvcg0KPj4gYSBtdWNoIG1v
cmUgc2VyaW91cyBwcm9ibGVtLiINCj4+IA0KPj4gYW5kIA0KPj4gDQo+PiAiSW4gb3RoZXIgd29y
ZHMsIHBlb3BsZSBkaWQgbm90aWNlIHRoaXMgdnVsbmVyYWJpbGl0eSBhbmQgYSBkZWZlbnNlIHdh
cyBzdGFuZGFyZGl6ZWQsDQo+PiBidXQgaW4gcHJhY3RpY2UgdGhlIGRlZmVuc2Ugd2FzIG5ldmVy
IGFkb3B0ZWQuIFRoaXMgaXMgYSBnb29kIGV4YW1wbGUgdGhhdCBzZWN1cml0eQ0KPj4gZGVmZW5z
ZXMgbXVzdCBiZSBhZG9wdGVkIGJlZm9yZSBhdHRhY2tzIGJlY29tZSBwcmFjdGljYWwuIg0KPiAN
Cj4gTGV0IG1lIHNlbmQgeW91IGEgY29tbWl0IHRvbW9ycm93LiBUaGUgbGFzdCBzZW50ZW5jZSB5
b3UgcXVvdGVkIGFib3ZlIGlzIGFtYmlndW91cyBhcyBmYXIgYXMgSSBjYW4gdW5kZXJzdGFuZC4g
QnV0IHRoZSBpbnRlbnRpb24gaXMgY2xlYXIgdGhvdWdoIDotKQ0KDQpEbyB5b3UgcHJlZmVyIGZv
ci1uZXh0IG9yIGZvci1yYyBmb3IgdGhpcz8NCg0KVGh4cywgSMOla29uDQoNCg==

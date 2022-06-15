Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA354CF0F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiFOQv0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiFOQvZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 12:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3841F92
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 09:51:23 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FFrY0q012419;
        Wed, 15 Jun 2022 16:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=hd4Oz8sCRvtPeaG2qAITlGcuqciN6f4iNzqPZgy6yms=;
 b=aDcA6yR9RtKUg3LASqxTkz5nPOj8fh5N4zky8S5FbMxIuCjPcJVT3IVm9GSGBZJFTkBL
 RiN1kLb7H1LeyrIte/QqRYLFucOBlY3O7ILEd8JzCIfXHGx7GbK/II9zGW2nj7w2Xunm
 FYuO86LycCMBs0hV4OzCj5oSbOdbQr9S8rKTJ1FZ2xJ3z1eb58RT476fZm1Ip/MVzMDz
 f42HiqukJtENOBKf1R/IukLK8iQJHavFSiOGVO3r9UDWjt9zXQrjfwOmr5golwRFYUkZ
 v0VkGTJ/sEoWG5ZgpKvhYJOU4BIj7ENhn7QCCX7s+2xbFMSeOCdko7oFKhqbD1s4nXMl Bg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqjfc1gg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 16:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaB3+92PDv/HvcTf2g/dq3VfYhMlDvgpupprDUrZSzcLDoJs7R40cX31odCtBwy8g/dNx2lYHfu4qM+hyTXYhmvjsN3plVXqIriWtdwnvpWamZBl7Vi3UN4WNCwJwm7q5+5UcQWwv+typJGRK8sNokBMdusE758FLlbwW+JDGrA5kkxpHXGuYVcQ/GA5gBNyWZGAPNcUjLGVlkDvBXOIz0TLJvzjbtcdX3514m3e5ev0oX6nk+tcuMH3cNRLdCmkvxaXWnRuO2zXkp86aGI2oyLoHgxkM/hOD7QdCNiN+HV8Z1XdCCXsdwfUhWCDvkPTecJGaJ2f+p/92wngiYpsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd4Oz8sCRvtPeaG2qAITlGcuqciN6f4iNzqPZgy6yms=;
 b=ApixZXjLesON/Z5CmRLijfgEQa4gF25jow50cOefJ785ecIrOqYNTPfV1E3nhH2BIaL2axN4Vft9KI9Viq4AoMMtSZ6nHrqOG80Ib+bLfHSgmH8F4qp+bz6GiZSxC1HBeGKsNoM1tkDP1CZrwtpvhrCrX5cXkHXW2XkE1yBb/tcan6oNLK4VLYExaiiFnEJL0tOreKkXNN49+cEmKREcqoNN8q81bqXMugooaMw+aWgEvDKX6wGZ8jAEtntwLd4oJIat8jCyMqgw0wvE8jKERjfcyfyZQP7Q2xEgdcznNQUjcCOHFdQ6aNLEo44OnCIuCupHpvo+B6R6D1V13gYlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by SJ0PR15MB5129.namprd15.prod.outlook.com (2603:10b6:a03:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 16:51:13 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 16:51:13 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Stefan Metzmacher <metze@samba.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 00/14] rdma/siw: implement non-blocking connect
Thread-Topic: [PATCH v2 00/14] rdma/siw: implement non-blocking connect
Thread-Index: AdiA2BtRvvPkUE5JQ/euUlo5K1BIow==
Date:   Wed, 15 Jun 2022 16:51:13 +0000
Message-ID: <BYAPR15MB2631B0C5E27454FE2ECBAC2799AD9@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b7f91cd-18d6-4f25-7923-08da4eef41fd
x-ms-traffictypediagnostic: SJ0PR15MB5129:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB5129A013D83EE60CAA14C95D99AD9@SJ0PR15MB5129.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQSOul/3OMkhYFlXLiQHUKhTkjheVYA3Zp2KH4aQ1LX1/ZwQxOnqj04cGqlbHl4Mj23TXEqdd9pyW5+i19SQKZlk9JsFa9gN+yOHe5dcYhbuK0dyEnSL4stkjnTQACkcJBFaC+aQ8ALWKBCFhvI47jRtuG4oY2pXXNiO+CvMXVD/xuwzsiTzADYjIudYH10suxPHU3untfLzC71Ki1zg8lgFig+9TfDr5ueq9em4dfSURlZdn9tX+u9lium2NeYnWS2d54Eegw18ea3tP/YslVGOXfcKryTMtHPrDu2TDr8QlrkVA1+ksAD/TNNa43gIQqz3NyNXksEwoyS20XBOp9PCzj27NH/kgScvjIt5xYdS4joAigPz3gldqI3IbWLe0Bi8Xcock1u+kTyz2OpaJ+jndDOZuTXVQZevsYnH0L62P/NRzM3oVlnVkzmMdzTKiciaCiNt3EEdDumJ7RQRiD+PHcqFZkF9kKuKNbqBQxdbnM2HCyCog1k25FVYsXTHNR7OCQoVSGrvar0AGkudeRjEVApZORhWf58Pm6/w2rwlsX5Bi3PO/qVENL7/IFOhsi6IwpLJmYGLPL4p2mnEZNgepbw1hTtAffgKPgy9B2kqShHNJflUrPn5bRWFlcKKhonAJ7O14oyuKi+feVOWAkwchgrT9ChxXWeUsWpAJsA8bBQhORrlSu+6vIOw7wUS5RNJynE1bme1UMA1rs25NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(55016003)(83380400001)(316002)(122000001)(508600001)(9686003)(86362001)(4326008)(66446008)(66556008)(66476007)(8676002)(53546011)(7696005)(66946007)(64756008)(76116006)(6506007)(6916009)(38100700002)(52536014)(5660300002)(8936002)(38070700005)(33656002)(71200400001)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU5Ud0VjeGtXcWVITHlaVmg5RFk1WDNEMERVN3hnejA2OFd1RjR2dTRGUVdn?=
 =?utf-8?B?NzEwOVBqbnVUazVMWGsyYVlacEhMUzk4Z05iNDVnWGRXcWFPYlp2MFRWSDNn?=
 =?utf-8?B?c3hyNFAzUHJXRzNlM2J2azVYbVY5cXQ0S2gzSVR4Q093Qkt2SktoN0VxZG5V?=
 =?utf-8?B?dFY2TUJYUUVIekFodW53eUxENE1HZnl3MXFjb2RGRTlPREVldlhmVUNJWnVw?=
 =?utf-8?B?MEN5eFBRU1Nmb2s3WUNXSlZQS3VGUzhxdEhHcHdnZDQva2l0b2tWNTExaHRQ?=
 =?utf-8?B?TGtHRHpRZmR6cGtleWZkU0IzRmpuSVlCTTF5L0JpODFUWWVZejFrUlgySjBT?=
 =?utf-8?B?VGE3Y3QzK2owMlBJdmJqZ3JqYzhYN2hPdHFWY0c5MjJyMFlDcTV4c1Nqdnl4?=
 =?utf-8?B?bnJRcEQyQ1Z1QnA0V2FDbUpsbkIxUDBVZFdQdm5vNjF3RWszd2JOSkZSSkJX?=
 =?utf-8?B?RW41SEFLS3haRG9CRzBWeEY1MlJUaXo5ajRSekVXNXl4ZTRpM01zTWthUStn?=
 =?utf-8?B?alVVY1BoTmpaWk5MSnppblZSQkF1MGJPb0pGRzJxcjRHZW1UK3d1RFArTXBW?=
 =?utf-8?B?OGZQT1FBZks3aEVOUnhZVU8vYjdHWTVnWXRveFNiUU13MzhLaHVRUzArN0tB?=
 =?utf-8?B?KzhyUmxmSnIvNzc2N0FkNHN2UVhTT3hTTzJkYzY3WXgyYzk2ak5kemVIV2lM?=
 =?utf-8?B?RTFQeW55emdNZE5tMkVsblptdmJ5NWtUWHVHR1A1UTBMbFQ2SnE0L3RrN0pU?=
 =?utf-8?B?UjRzc1BOblVhZTBUZDVmYUM5RWQvdUVOVEVoTkErKzB3emhOTlJ2N2VqaXFk?=
 =?utf-8?B?clpEeTd2aUhmclJXblFwV0IxblV5eUxyK2I4NmFkck1rakhIZS9XZGs2VUs1?=
 =?utf-8?B?cVl0c2pzZi8wVk5TS2RqOUVqcitvQnF5Wlgxbyt6bnhZMDhSUUtIdUwvR2xP?=
 =?utf-8?B?YllTZlM0WnFDSkdIRzJBVjZTQ3ZaUmdKci9MWWw4OXM4eWEvQWc0dlh2dG8y?=
 =?utf-8?B?dm5aS1c3L0ZTQUlHeHRMV25kdHlaVDFuc0tRMEgrdXc1dHdwTE5MMUhRTDg2?=
 =?utf-8?B?U3JkOFBtdnZGSVAvclVENTUvN2piOTlwNzNYY2ViNnNnZjFOZ3JJT1I0UnFi?=
 =?utf-8?B?ZC9EMFhmdWVkMDhBUzVyWkJPUUFvL29MM201UVVyVzRwNDdCc2s4bSsvdlB0?=
 =?utf-8?B?R1pCNFQzS3dmMzNQUTQ5NjZRbjNiS3ZFZHRqZ0JxM09PMllRSHBVWFFGYjlE?=
 =?utf-8?B?OVBXZDJ2QjVkZWJnbFVMM20xVE8wQU8wa2tiTUc4M2lYSXV5VVB1Tml3ME0y?=
 =?utf-8?B?VUdWbkRJbzFBMTkza0M0b2NkbHptT2pQZXAyWno4UFdKSm44dENBS1dlZVVJ?=
 =?utf-8?B?cS9wRERnYnlGbVUrUVB6MVFhQmhyNS8vOGJYVzdsbFlidVZKRGZuMk16OVZm?=
 =?utf-8?B?RVcwVFUzVytRaG12b3R5Q3hFSGdUQ1ErZGdHYlU1UXR1cGlZblVqRCtVTDQ4?=
 =?utf-8?B?dnZtMGdUZXY3b1paN1I2T0JXbjJnbzdFVDlFNGt0ZDV1c0MyYjZ1UUljSEJO?=
 =?utf-8?B?TXcrRzdNSktSc0VhUmEvMXJyeDNvUEYrNzlIMmorVEFERFZVQTVIbC9aRG5Y?=
 =?utf-8?B?REt0d01aVXNGVmZWdW5QRDJoeFdPcU1XTmpBSXZ1bzR6Y1JpZWVaUTN2THNa?=
 =?utf-8?B?Y3BiVFJadnprSHV0cWRvTWNBdElQTlFQWWpMVkF2azFQejdjT1Q2UWIxR0Vo?=
 =?utf-8?B?cytzL25BTXh3Z3hUemNzbDFmOStHQXorclMzbmcyT3kvbW9iTHFuam1jdjZu?=
 =?utf-8?B?LzB3UTRUOVZYN3VybUJRMlpTRFNXOUdJNzBQRHJlcERPd3Y0OG5CalN4WTkx?=
 =?utf-8?B?aldPeDErcEx6NWpkc3p5NmVJZTFrbGFHc2VWY1BtSkxyYjgycEszejA2Y29C?=
 =?utf-8?B?SXh4RWc1SWhiL05WdDhId0NaTEJVRFp2YjNBOVlWZ1FETTBDcjhDdHJjZmpB?=
 =?utf-8?B?SkE0UytDY1lhd3VrUkNnZEk1VjBRUzlleW94a3ZsTUlicVdpT1BWdU85c2ZD?=
 =?utf-8?B?KytEcHJydFpZQ1g4YmxTTzRiSG8wVk1UejhwMGNEVDQzcnI1aVViQnpXYzBG?=
 =?utf-8?B?L0NFZGJxUDZXbEhrVWlza3RkeU9hbFJ4dHRucHd2ZllnTVFjQzdGYmJiWnh6?=
 =?utf-8?B?RGo1UkdaeFAxaXgwbW1oTG9Xa0NkV2ZDaWtodlpuUGFQYnNrMkEwNlZLSXh0?=
 =?utf-8?B?MjN0M0ZkNHkvQlZrb0dhb3ZaN2xzZENUd2lzakxHNVFGNlZmOFM5THl1eFRV?=
 =?utf-8?B?RFdDOFQvSWo4RDU2M25qZ25PbERlaTJrZkVoNmZvM0JabkxCMGlscjM4TFNZ?=
 =?utf-8?Q?KjvtXIHLxfG9HBGXsEr5Y295LAzoNG/2n3AqDZg+nSzGv?=
x-ms-exchange-antispam-messagedata-1: NUxS0iY/5t0NYg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7f91cd-18d6-4f25-7923-08da4eef41fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 16:51:13.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDTSUIigvM8j5/CNB4d/Y35lgGQEYdsKZB+O9K4ZhAgqj6vMD+Q+9iup19a2lrIIXT5D8oyD/Tm9QF47h614yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5129
X-Proofpoint-GUID: -NjgD-g5X04VAWigfrntaoeVgjr5psBg
X-Proofpoint-ORIG-GUID: -NjgD-g5X04VAWigfrntaoeVgjr5psBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_14,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=716 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIE1ldHptYWNo
ZXIgPG1ldHplQHNhbWJhLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCAxNSBKdW5lIDIwMjIgMTc6
MjcNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogU3Rl
ZmFuIE1ldHptYWNoZXIgPG1ldHplQHNhbWJhLm9yZz47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIHYyIDAwLzE0XSByZG1hL3NpdzogaW1w
bGVtZW50IG5vbi1ibG9ja2luZw0KPiBjb25uZWN0DQo+IA0KPiBIaSBCZXJuYXJkLA0KPiANCj4g
YXMgd3JpdHRlbiBhIGZldyBtb250aCBhZ28sIEkgaGF2ZSBhIHBhdGNoc2V0IHdpdGggYSBsb3QN
Cj4gb2YgZml4ZXMgZm9yIHNpdy5rby4NCj4gDQoNCkhpIFN0ZWZhbiwgbXVjaCBhcHByZWNpYXRl
ZCEgSSB0aGluayB0aGUgZXJkbWEgZHJpdmVyDQpkaWQgYSBnb29kIGpvYiBpbXBsZW1lbnRpbmcg
c29tZXRoaW5nIHNpbWlsYXIsIGJ1dCB3L28NCnRoZSBuZWVkIHRvIGxvb2sgaW50byBNUEEgdjIg
c3BlY2lmaWNzLCBlc3BlY2lhbGx5IHRoZQ0KZXh0cmEgaGFuZHNoYWtlIGluIFJETUEgbW9kZS4N
CkRpZCB5b3UgdGFrZSBjYXJlIG9mIHRoZSBNUEEgdjIgZXh0ZW5kZWQgY29ubmVjdGlvbg0KZXN0
YWJsaXNobWVudCBzdHVmZj8NCg0KSSdsbCBoYXZlIGEgbG9vayBhc2FwLCBJIGFtIGp1c3QgZG93
biB3aXRoIGEgbmljZQ0KQ09WSUQgaW5mZWN0LiBUaGlzIHRvIGxldCB5b3Uga25vdyBJIGFtIG5v
dCBpZ25vcmluZywNCmJ1dCBoYXZlIGFub3RoZXIgaW50ZXJlc3RpbmcgZXhwZXJpZW5jZSB3aGlj
aCB0YWtlcw0KbW9zdCBvZiBteSB0aW1lIPCfmIkuIFdpbGwgY29tZSBiYWNrIHRvIGl0IGFzYXAh
DQoNCkJlcm5hcmQuDQoNCg0KPiBBcyByZXF1ZXN0ZWQgSSdtIG9ubHkgc2VuZCBpc29sYXRlZCBj
aHVua3MgZm9yIGVhc2llciByZXZpZXcuDQo+IA0KPiBUaGlzIGlzIHRoZSBmaXJzdCBjaHVuayBh
ZHJlc3NpbmcgZGVhZGxvY2tzIGluIHNpd19jb25uZWN0KCkNCj4gDQo+IFRoZSBSRE1BIGFwcGxp
Y2F0aW9uIGxheWVyIGV4cGVjdHMgcmRtYV9jb25uZWN0KCkgdG8gYmUgbm9uLWJsb2NraW5nDQo+
IGFzIHRoZSBjb21wbGV0aW9uIGlzIGhhbmRsZWQgdmlhIFJETUFfQ01fRVZFTlRfRVNUQUJMSVNI
RUQgYW5kDQo+IG90aGVyIGFzeW5jIGV2ZW50cy4gSXQncyBub3QgdW5saWtlbHkgdG8gaG9sZCBh
IGxvY2sgZHVyaW5nDQo+IHRoZSByZG1hX2Nvbm5lY3QoKSBjYWxsLg0KPiANCj4gV2l0aG91dCBv
dXQgdGhpcyBhIGNvbm5lY3Rpb24gYXR0ZW1wdCB0byBhIG5vbi1leGlzdGluZy9yZWFjaGFibGUN
Cj4gc2VydmVyIGJsb2NrIHVudGlsIHRoZSB2ZXJ5IGxvbmcgdGNwIHRpbWVvdXQgaGl0cy4NCj4g
VGhlIGFwcGxpY2F0aW9uIGxheWVyIGhhZCBubyBjaGFuY2UgdG8gaGF2ZSBpdHMgb3duIHRpbWVv
dXQgaGFuZGxlcg0KPiBhcyB0aGF0IHdvdWxkIGp1c3QgZGVhZGxvY2sgd2l0aCB0aGUgYWxyZWFk
eSBibG9ja2luZyByZG1hX2Nvbm5lY3QoKS4NCj4gDQo+IEZpcnN0IHJkbWFfY29ubmVjdCgpIGhv
bGRzIGlkX3ByaXYtPmhhbmRsZXJfbXV0ZXggYW5kIGRlYWRsb2Nrcw0KPiByZG1hX2Rlc3Ryb3lf
aWQoKS4NCj4gDQo+IEFuZCBpd19jbV9jb25uZWN0KCkgY2FsbGVkIGZyb20gd2l0aGluIHJkbWFf
Y29ubmVjdCgpIHNldHMNCj4gSVdDTV9GX0NPTk5FQ1RfV0FJVCBkdXJpbmcgdGhlIGNhbGwgdG8g
Y21faWQtPmRldmljZS0+b3BzLml3X2Nvbm5lY3QoKSwNCj4gc2l3X2Nvbm5lY3QoKSBpbiB0aGlz
IGNhc2UuIEl0IG1lYW5zIHRoYXQgaXdfY21fZGlzY29ubmVjdCgpDQo+IGFuZCBpd19kZXN0cm95
X2NtX2lkKCkgd2lsbCBib3RoIGRlYWRsb2NrIHdhaXRpbmcgZm9yDQo+IElXQ01fRl9DT05ORUNU
X1dBSVQgYmVpbmcgY2xlYXJlZC4NCj4gDQo+IFBhdGNoIDE6IEZpeGVzIGEgcmVmY291bnRpbmcg
cHJvYmxlbQ0KPiANCj4gUGF0Y2hlcyAyLTc6IEludHJ1ZHVjZXMgX19zaXdfY2VwX3Rlcm1pbmF0
ZV91cGNhbGwoKQ0KPiBtYWtpbmcgaGUgdXBjYWxsIGhhbmRsaW5nIG11Y2ggbW9yZSBjb25zaXN0
ZW50IGhhbmRsaW5nDQo+IG1vcmUgc3RhdGUgY29tYmluYXRpb25zLg0KPiANCj4gUGF0Y2hlcyA4
LTEzIGFyZSBwcmVwYXJhdGlvbiBwYXRjaGVzIHRvIHNpd19jb25uZWN0KCkNCj4gaW4gb3JkZXIg
dG8gZG8gdGhlIHJlYWwgbm9uLWJsb2NraW5nIHNwbGl0IGluIFBhdGNoIDE0Lg0KPiANCj4gUGxl
YXNlIGhhdmUgYSBsb29rLg0KPiANCj4gVGhhbmtzIQ0KPiBtZXR6ZQ0KPiANCj4gRml4ZWQgaXNz
dWVzIGluIHYyOg0KPiAtIEluY2x1ZGUgbW9yZSBwcmVwYXJhdGlvbiBwYXRjaGVzIHJlbGF0ZWQg
dG8gX19zaXdfY2VwX3Rlcm1pbmF0ZV91cGNhbGwoKQ0KPiAgIGJhc2VzIG9uIHJldmlldyBmcm9t
IENoZW5nIFh1IDxjaGVuZ3lvdUBsaW51eC5hbGliYWJhLmNvbT4NCj4gDQo+IFN0ZWZhbiBNZXR6
bWFjaGVyICgxNCk6DQo+ICAgcmRtYS9zaXc6IHJlbW92ZSBzdXBlcmZsdW91cyBzaXdfY2VwX3B1
dCgpIGZyb20gc2l3X2Nvbm5lY3QoKSBlcnJvcg0KPiAgICAgcGF0aA0KPiAgIHJkbWEvc2l3OiBt
YWtlIHNpd19jbV91cGNhbGwoKSBhIG5vb3Agd2l0aG91dCB2YWxpZCAnaWQnDQo+ICAgcmRtYS9z
aXc6IHNwbGl0IG91dCBhIF9fc2l3X2NlcF90ZXJtaW5hdGVfdXBjYWxsKCkgZnVuY3Rpb24NCj4g
ICByZG1hL3NpdzogdXNlIF9fc2l3X2NlcF90ZXJtaW5hdGVfdXBjYWxsKCkgZm9yIGluZGlyZWN0
DQo+ICAgICBTSVdfQ01fV09SS19DTE9TRV9MTFANCj4gICByZG1hL3NpdzogdXNlIF9fc2l3X2Nl
cF90ZXJtaW5hdGVfdXBjYWxsKCkgZm9yIFNJV19DTV9XT1JLX1BFRVJfQ0xPU0UNCj4gICByZG1h
L3NpdzogdXNlIF9fc2l3X2NlcF90ZXJtaW5hdGVfdXBjYWxsKCkgZm9yIFNJV19DTV9XT1JLX01Q
QVRJTUVPVVQNCj4gICByZG1hL3NpdzogaGFuZGxlIFNJV19FUFNUQVRFX0NPTk5FQ1RJTkcgaW4N
Cj4gICAgIF9fc2l3X2NlcF90ZXJtaW5hdGVfdXBjYWxsKCkNCj4gICByZG1hL3NpdzogbWFrZSB1
c2Ugb2Yga2VybmVsX3tiaW5kLGNvbm5lY3QsbGlzdGVufSgpDQo+ICAgcmRtYS9zaXc6IGxldCBz
aXdfY29ubmVjdCgpIHNldCBBV0FJVF9NUEFSRVAgYmVmb3JlDQo+ICAgICBzaXdfc2VuZF9tcGFy
ZXFyZXAoKQ0KPiAgIHJkbWEvc2l3OiBjcmVhdGUgYSB0ZW1wb3JhcnkgY29weSBvZiBwcml2YXRl
IGRhdGENCj4gICByZG1hL3NpdzogdXNlIGVycm9yIGFuZCBvdXQgbG9naWMgYXQgdGhlIGVuZCBv
ZiBzaXdfY29ubmVjdCgpDQo+ICAgcmRtYS9zaXc6IHN0YXJ0IG1wYSB0aW1lciBiZWZvcmUgY2Fs
bGluZyBzaXdfc2VuZF9tcGFyZXFyZXAoKQ0KPiAgIHJkbWEvc2l3OiBjYWxsIHRoZSBibG9ja2lu
ZyBrZXJuZWxfYmluZGNvbm5lY3QoKSBqdXN0IGJlZm9yZQ0KPiAgICAgc2l3X3NlbmRfbXBhcmVx
cmVwKCkNCj4gICByZG1hL3NpdzogaW1wbGVtZW50IG5vbi1ibG9ja2luZyBjb25uZWN0Lg0KPiAN
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMgfCAzNDcgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmgg
fCAgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMjQgaW5zZXJ0aW9ucygrKSwgMTI0IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

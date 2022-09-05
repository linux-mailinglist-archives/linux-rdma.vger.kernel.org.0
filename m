Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB45AD2E1
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiIEMgB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiIEMfp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:35:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389A24BFA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:29:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285BvKCk010306;
        Mon, 5 Sep 2022 12:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=z67tsBo5HT42XtECnAaFvloe/Q4kxwASjKP7nX6+r6U=;
 b=YJiAj16apIx3cC52DQ+vVI63nYmkC0j90hiwsWNqM0pEEqvrbiA4jFbmFnZMm9hwbWhD
 ao5B+zmtwfOKMOv+sE/m9OYqrCGoRZfNtOS4v6e9q4MUr6qE7G4MbzSwbimO7a1vJP3d
 P19i9DI0zHUQN3Hf3+XYTgPVUAnKrx+V2uh/zAKTJjVeyTYLxB0pt5FomSB/RRh0xE6w
 w5unZYL+XJ5hlYP9wEIMQnqwxRPUtQVrYJnJVoWtG7LN4MCTzG4hW3kKVX+sScuyUwOS
 UG/jxe1Mwl+sKtVZhD3OMlUBZIHmVccHOWnSskTF+u0rjN/PZtWlagpKtCXDLzKzqCqR 5w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdgpn107q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 12:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZd9iKJVq0tWJ1NeEIOafz402Zr3plbYIgV0ZJV85QQsOkc/zdd9gu0qJU9+OkgVRL8uXFX16wQj0LJypolDShu6aJfZkZiU0+cN3gJooSIvAmJIIFI5vsja8A5Ki63FUARgNsINmMLmFrIEBaRw2l0wy4sJdAiyOy96MOnpGYB7U8d1JxKKUzZdudMgdI26elmeYLXGufmQS5ZUtjJOWyP2v1HXr6wRu3n4qN09PFy289WrA2Y0QJGzhbdwX9mB4uRt4v2ddsvjFa1wYpXDU+/5po5hPwuRB1RjoM8r/uJcU2LTY5UnLvIzm4ZSga82/erWiV1vA/KPts2RcbdCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z67tsBo5HT42XtECnAaFvloe/Q4kxwASjKP7nX6+r6U=;
 b=l9jJfUCTUMdXrbgTGaDApOO+sAjhZF1li0Xxf4JytsEPu/cVKa5ntUkgCnuqyZiI1wGOkyU1/EZwmhrLKFLxoMmyyDwzqHdBtY5oQPySEqEOU32mzEx8XqPMWBFsCCQ16BHQc1tco3mjup3gnOY/dKnWkpToU27wT0BheLZFh/cBgQuVjdj9hc5HJcNKohuMw4qRn1y7sbiS6Tbn686mY1fkz3muhpmhjEWcISu0WJbDe7QmYqVUvECkizkZDoyF4KSYyLM+IofaByLHdyp7kNpNnZV4206Cew8/MABxT+AjY1cN2O46228dBu4+sEdK8E/FTdlvrMw1/hnW5P4aLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DM5PR15MB1499.namprd15.prod.outlook.com (2603:10b6:3:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 12:29:04 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Mon, 5 Sep 2022
 12:29:04 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Re: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Topic: Re: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Index: AdjBIwL8gmt41KXSSL6dcYdX+ZWEBA==
Date:   Mon, 5 Sep 2022 12:29:04 +0000
Message-ID: <SA0PR15MB3919EC317FA7AF4FBA7F6091997F9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631b3a67-30c5-4651-ff00-08da8f3a387a
x-ms-traffictypediagnostic: DM5PR15MB1499:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MgsdmbloUBGvsJOK4rJDjkpxVdHH1qxQbUGjqUKl6rpGWHiVpI8Gm3Cu9sYiVt5M8HhMn69nwNqEdwvW9A/oW9UkmaFZ4Yl1Rm036I/6p19PQYz9xJjVAp6409Uolz10F7Htu68bvWvCCWcwIwPSVNjgUUhPpUHkqkQXy1gkvLhyrUBmfV4kBvoPYDivsQRhkE6teJDxJGi75ZhnL5w5aPB75szneMntR3xTjIFY/bkGV1dGcMpHPIDcMw4bpzWgG6e9vjYiYltPTWIEt3Dht1a/QVJvSJM++junX4BMbeaMMXnx7mC6PC2loAbV8a2/R6VE+4gXMjK88g7BcXQ3dIeC9uEnrWer7LAWnRjhuNMr5dI/096nQC/BhGDAqPBQpbFXOuEdqOPeaUiWbCKIcAvJtxyhy9YlvtF+zCzOT1/FPFtbDwS4+8Oez7V6d0S/F1Q7cMWapG0pFlze87RB3C4EqImU3e0qoURjpLd+Kcwa9pRsFQZJ3lD/tcxNAZoYodvC9AosMbGWEvq/yYl1Ll8HUZqBbnaouDO6qgSoL84JK04vpdi/yO3qST0r6Sk1+wGFwUcHu/8tTLms/WvRDjdUcU8QfNFS8aOLQpmymwK2BonxR6OR+BXvc6QVS//oiZJ7zVvY0En4J5nfbb0R7HUnR187nGrT7FRIJZOoJPa3mVFxhDs24QVGnTYHliqfu+Dq2+Q3OQB+kHIWtbTHecTwBi5FTKnz+Rso50A0bVZS5Jkbiwfjfv5mR0a4/QH7v6B88eNA4SbLJSVlKCv/Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(376002)(396003)(122000001)(38100700002)(54906003)(186003)(71200400001)(6916009)(316002)(7696005)(52536014)(66946007)(6506007)(64756008)(478600001)(66556008)(8676002)(4326008)(76116006)(55016003)(66476007)(66446008)(86362001)(53546011)(38070700005)(33656002)(5660300002)(83380400001)(8936002)(9686003)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJmbHpQTXNYZmt3aWtUamJsb21Ya2U3NkpmOXM1QUtTYXBNdDAzMHc5dEdE?=
 =?utf-8?B?S3FnNmdBME1Rd0d5QWlzSkEycmhWbHc3VXE5ZERBQ2ZJanlrM2NTb0QwWGpw?=
 =?utf-8?B?WjFlL3Zna05laGgzaU5QT0FzT3kwUjJBWmVER2UrRWM2dmlzSXZDbzJZcktE?=
 =?utf-8?B?eW5YczVOQjBoUTFnYUdlZ2tqSFFVUWlQZ3lvWVFCVTFzdHRjSVdUb2FwbWNG?=
 =?utf-8?B?dVBiejZySDZrNU1tK09DeHJ2d1c2WVduOTVBSjNCZlpTTGxJaDdRVDlzcG9j?=
 =?utf-8?B?WmtmcVpUVE5PckNFUDJCUk8yT05pVWFUMUk2YVBxd2JJazFIcGZFZi9EcEta?=
 =?utf-8?B?MERyaXdCd2Qybzl0VUk2cXZlc3owWnNKczM1d1FWaTE2NkNDRWtvaWtNVVRa?=
 =?utf-8?B?RWxaTmVIbTlKY1hGdWQ2NkFnSlB6Znh4NHRyaWdFeXhibzdGb3BUemgvU21W?=
 =?utf-8?B?VmJ2S0xPOW13MEFsWldtRndnTmROaE9Sd25lbFp3Z0F5YjZOaEViRmVvR1ZK?=
 =?utf-8?B?Tmx3azlBVUloMFN4bFM4VzJXeHUvQUZEVmVHbDdFTlhFZEN4Ujk4VytsVzkr?=
 =?utf-8?B?NXdJN1lpYmMwQTQrZFM0R3FtV3VBbzdoSW8xZ2c3eXJPRzRJTzVTTEluSUxG?=
 =?utf-8?B?YjllYUlDeEFHWEVKOWV3ZS9icjVQc3JHUER2NlJiZmhSN05kVGtBZ1c3UEJU?=
 =?utf-8?B?SnlqVzZ0ZVRXYTlvaWtSelhhblZMWHhEaEJKa2lPdVhOM3dYV2NyVE1FNHJC?=
 =?utf-8?B?SEZ0RVdORk9Db3c2OFM4eVZaWHdFc1VrRHE1QWVrY0tyR1FFVko5WkRpS21p?=
 =?utf-8?B?MGdTTGNoa3FXNTJPYVlFdW5aakxZalJvRmRVclhjUFJzL093ZzhsYXNNWTFx?=
 =?utf-8?B?ejdZdjVRQmRFK0JSQW1HNGdaNTlJT1FORUorRzRWSjFiM0pnQUpVM213aTcx?=
 =?utf-8?B?L1AyeUc0eXlQZWpuU0FiY0N2UnNMTVZvYlk5RUE0aE5NYW91WUZCa0ltWUE1?=
 =?utf-8?B?eWpheXRiTFJsamUwNDZuRWE5b1dLM2VHb3k1SzVGRGYxcEZuNityak91N0t5?=
 =?utf-8?B?ZGY4UlMvcWcrWXRzVyt3TlpadjVLNXdRdnlsOEV6SExrSkFpN2o1b001YlFZ?=
 =?utf-8?B?QnplV1U2UHp2OWFWZDJaOVlsZlVkNHlsN1NNdFgvNXhRYmRzK2d6VVkyT0Rs?=
 =?utf-8?B?Uk5lcEorL3I1c0ROSHpXaDZXYVJYWXd3NUplQ3ZoVU1hL1ZUamVGTXp4ODBV?=
 =?utf-8?B?TDBKSlhuN2hMd1g1S2R2dmcrdkRFR2JNSFd5eHpqSGVkOVhFQzhicTJjWkVj?=
 =?utf-8?B?alAranlRWWluT09DRmh1bk5nNE5LenpBRmpwWjFIM3V5RGN3ZHhleGV3QnV5?=
 =?utf-8?B?WnBhNzBXMjhDdmNOZkVSSENmN0ZPeE1tYmk5NVNvNmdKRW5waGUvMEE5aEVU?=
 =?utf-8?B?ZmhmV1hGbk5YWmVZTmxTVjVxM29lbFh2WUxNcU85U1o1TzNYOVBiZXd3Njdl?=
 =?utf-8?B?YUdjRWFzUVZBcjQxZ0xmZkt6dHpFRGZWUExhK0tEY1lDL1RIR2lDRU9zUTRN?=
 =?utf-8?B?SHlYVUEvOUZMb0xQSkhoVWNRRFFCdFQzVUVxekhjcW5oc014MkxWTnVaQys0?=
 =?utf-8?B?aGxlUDUvZWhMcjNxWDI3ZzFyNFV0clIxdkxQc25rallKRUtxeEdIU1pYQlBj?=
 =?utf-8?B?VVdqZ3dSTXBhUFg2dXU2Um9CNDNUTktVMmZaRFpYREM5dE1GOVFrR1J1TkpX?=
 =?utf-8?B?eW96dnh2YnVLTjk5b0pQL05UZmxETHRqcXJ0dFRiOFEzUGR5WDdsV1Z2TzFz?=
 =?utf-8?B?N1JNVVpzRkIyc2grbnlxdFdpaDhTQ3Z1akxrQTBXUDFFaE0wTVNRVU1PbGhP?=
 =?utf-8?B?VG5aYURneldRcy9UMlZoNmxlMUtZU0RZRmt6NHQ3ZC8wOW90OVJJeTZKZUlC?=
 =?utf-8?B?V2tURmdFZXVYQWNNTCtRYkxqai9CYXdVbmJOZFdWZjZLY3psekkwSWFrY0RY?=
 =?utf-8?B?bkpDcnMvcGZITVREUk8xclhDemUzRVZQRGc2S0w1dkZMaEx4RisvNENkanZy?=
 =?utf-8?B?L3IyN0I2YzhieXpYOTFCNW80dWVBVzFmM0JycnpKd0ZwMmx2SGRuZnI3QUpv?=
 =?utf-8?B?UjRSK1Nha1ZCTDdGZytMNGplTG0rMDMzQTFkQ0tRancyYTlTL2FKMi9JRzRJ?=
 =?utf-8?Q?oOKj7dmxN33mGQtc5jMBzq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b3a67-30c5-4651-ff00-08da8f3a387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:29:04.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: devnqEhlDU/rMSLnRkieYy4E7IWO05iM5Jyx9kFWDMPPa0ZR7Wo8ymE9X0aU5otoj8jjG1aPRY9hCH0yek4Wcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1499
X-Proofpoint-GUID: s9asxs30WScrJRlct_IeJH_h_vyrffl8
X-Proofpoint-ORIG-GUID: s9asxs30WScrJRlct_IeJH_h_vyrffl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_08,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIDUgU2VwdGVtYmVyIDIw
MjIgMTQ6MDgNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBD
YzogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0K
PiA8amdnQG52aWRpYS5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJlOiBSZTogW1BBVENIIHYzXSBSRE1BL3NpdzogUGFzcyBhIHBvaW50ZXIg
dG8NCj4gdmlydF90b19wYWdlKCkNCj4gDQo+IE9uIE1vbiwgU2VwIDUsIDIwMjIgYXQgMjowMiBQ
TSBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+
IENhbiB3ZSBlYXNpbHkgZml4IHRoZSB0d28gbGluZSB3cmFwcyBpbnRyb2R1Y2VkIGJ5IHRoaXMN
Cj4gPiBwYXRjaD8gV2l0aG91dCBzZW5kaW5nIGFuIGV4cGxpY2l0IHBhdGNoIG9uIHRvcCAtLQ0K
PiANCj4gWWVhaCBMZWFuIGNhbiBqdXN0IGF1Z21lbnQgaXQgd2hlbiBhcHBseWluZy4NCj4gDQo+
ID4gSSdkDQo+ID4gc3VnZ2VzdCBhZGRpbmcganVzdCB0d28gbGluZSBicmVha3MgdG8gaXQuIEkn
ZCBiZSBoYXBweQ0KPiA+IHRvIHNlZSBzaXcgY29kZSBjb250aW51ZXMgdG8gYWRoZXJlIHRvIHRo
ZSA4MCBjaGFyJ3MNCj4gPiBwZXIgbGluZSBzdHlsZS4NCj4gDQo+IFlvdSB3aWxsIGJlIGZpZ2h0
aW5nIGFuIHVwaGlsbCBiYXR0bGUgc2luY2UgY2hlY2twYXRjaCAod2hpY2ggaXMNCj4gd2hhdCB3
ZSB1c2UgdG8gY2hlY2sgc3ludGF4KSBub3cgYWNjZXB0cyAxMDAgY2hhcnMvbGluZS4NCj4gY29t
bWl0IGJkYzQ4ZmExMWU0NmY4NjdlYTRkNzVmYTU5ZWU4N2E3ZjQ4YmUxNDQNCj4gImNoZWNrcGF0
Y2gvY29kaW5nLXN0eWxlOiBkZXByZWNhdGUgODAtY29sdW1uIHdhcm5pbmciDQo+IA0KPiBJZiB0
aGVyZSBpcyBpbmZpbmliYW5kIGNvbnNlbnN1cyB0byBzdGF5IHdpdGggODAgY2hhcnMgcGVyDQo+
IGxpbmUsIHlvdSBzaG91bGQgc2VuZCBhIHBhdGNoIHRvIGNoZWNrcGF0Y2ggc28gdGhhdCBpdA0K
PiB3YXJucyBmb3IgdGhpcyBmb3IgcGF0Y2hlcyB0byBkcml2ZXJzL3JkbWEuDQo+IA0KDQoNClJp
Z2h0LCB3ZSBkaXNjdXNzZWQgdGhhdCBhdCB0aGUgbGlzdCBiZWZvcmUuDQpTbyBmYXIsIHdlIGhh
dmUgdGhhdCByZG1hIHN1YnN5c3RlbSBpbnRlcm5hbCBjb25zZW5zdXMgdG8NCnN0YXkgYmVsb3cg
ODAgY2hhcnMuIEFza2luZyBmb3IgYW4gZXhjZXB0aW9uIGZvciBjaGVja3BhdGNoDQptYXkgYmUg
ZXZlbiB3b3JzZSBvZiBhbiB1cGhpbGwgYmF0dGxlLg0KDQpDaGVlcnMsDQpCZXJuYXJkLg0KDQo+
IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQo=

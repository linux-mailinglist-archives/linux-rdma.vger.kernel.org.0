Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9D7DBAE7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 14:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjJ3NgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJ3NgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 09:36:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160DDC6
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 06:36:04 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDZeAB031464;
        Mon, 30 Oct 2023 13:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fD/vWDIItIBQACiBfUf4fz7M2gqU2nyM1uG1J6EGhg0=;
 b=Awz4hWa2cZlk9NHAtpqX2R04+vjlGQLDMsAkhu8Iauk4LnjcrOHATLdAZtNgFIwI9Olr
 3oayTidlydlbqJfIU1VEFcwnX/bCLmS/+rAzcN5EFWM1mkXjg1qlA9MvKFrVJe6RIdPC
 +Ef1FfD7gaxldbj8mNOSJCPIfzNf9k8y9JvG9OsGmUDOQzQgO29pne2t87mTOJvxOSn9
 IshteKBjj4v3l+px6lob9X5i6BWgtrrz8QUc1SQn2sE7Kx2iPiKK4j8wWG/WWaS4c09n
 mRrDCjKHed9RnC9BX5R+3Qmwl0dIpFEC0vFwB3G/KXEI28sxgKAR6uiopA8Lh5vkBVtb XQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2dgq80be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+HoEtKO01n+hrLAU/RjIoyhftRos7rqxdS/e0ig9nBsHhgtLxr+nIOEWvslo9aB4PfCXe6+4CKCx5ExsShvv1NVrxVLubQlbknSjxiShI3xGWGdMCDyxlpcye/zlRw+80diITnu1BJ3fBuE71gwRiQRiKrq3vYtuUxO75wNYlxtlTyHXGqRzHgkTDGuTa8bnePcopBqYdGAAvx2M01fEvcUnTp1R8x3gd88wqGhqjC8Tvi9HabuZqm1KTgqmd/gPFDhbAhfKXtcM5QxIhyTED48/+FruXYuhSV+Ndg6liK9IqfhtYbDP3N1vQ1od8Sx/+uUxB44/5POSuzNfxZ9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfeBgNmYuTen91tL+4HE6wSXhDegjYDzIbu2dzZFaPk=;
 b=bwR57PZa6SalZxAG5ky4zVTSuyrkmL+uWPwaI0FFEjo2pMypiIQmDASjU+zRq4azGuOGPrPg6fskaB4yLltymkTtVTU0UEuDJX/NTVMe74+/KWr9+9/09C4zpdBibAibyU9+ynrdWKnJvCsehzORLFzM48yVXn83pXfBWoeYo18BYLRKYlyPcieIjcvczk9KfpTfFF1khocOxU9ll/hgnmvM4Hmf8z1y+RHbsfwJFmIEMG1b+ec2bkdem6c1Z43SFqUCztv+/DY7HFOYvn3hEXEzp+l3Q0MOqAGfkntQmsL7rpIlzTdYppLK5+/sLoUG5eZPYDJbV8wejAndMnYctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA3PR15MB6145.namprd15.prod.outlook.com (2603:10b6:806:2fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Mon, 30 Oct
 2023 13:35:51 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 13:35:51 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V4 12/18] RDMA/siw: Introduce siw_free_cm_id
Thread-Topic: [PATCH V4 12/18] RDMA/siw: Introduce siw_free_cm_id
Thread-Index: AQHaCzX/hPcj7/fuZ0uUsmTel58Ptw==
Date:   Mon, 30 Oct 2023 13:35:51 +0000
Message-ID: <SN7PR15MB5755EE90FA4E218C1FFADEEF99A1A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231027132644.29347-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-13-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA3PR15MB6145:EE_
x-ms-office365-filtering-correlation-id: 33532417-3dd4-47cc-3a01-08dbd94d224b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvQOx4CgynjiNa+bIPBH/8k46XiPTKGSOcwwYzLjMbOqZ5ITQd4X/7ZqnOFvP6De95GSw3Lw4vw9bKNPGE5HOFOJ229gw4RKIIFkC31w/F2hsiQQALhlERWq+kkhsW+VFnht6elEUWeVkNZu43FXtCeI4DZ6WUqWItvmYgxI5lCQQKoYwq5Q5rA5tgcwou9aRcZT0gwTDVGrMBudiR3sdKgLEEgmu/5RFeXGEUG1/Di02phVrwVGG4rLyDBosCti5NkaWPpMCzNLTEB7znYpaDmwdkxgJFJW9ar3gGu9/6yNwc2bavJx7dku729wX5VbTx8OutpTRTeOqMvlbjBebbGNM2xySQ6T7bvHH9+fXjs5+jI/5fmcEpRH9Jw9Cwlk9QXPjdE90jjPDZYezEkcZZ+yN/XgPYTh2Ujh2n+s34ralZO+HN0RK34bFAploryiOCu1HyIp1AqAVbYimpCVFMGpFIlMrvH75Q85mC4/3S7pDYSTMg1Fqc/vOSxS6AU/wIXzkuPa3a/+k+k9PiIuVtqUYKtpcoM9fm2LxM7gMdnGPXDRLPnQYhn5+j2q+afrK2kTFbacDP8wBwHEaq61E/hb7SEPHwH8Tx/oz09So6GYzy9gJSuk9gJ0exiZi0yKR6AMxSy5ciSZv9w1K2w6Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(83380400001)(41300700001)(76116006)(110136005)(2906002)(33656002)(26005)(5660300002)(86362001)(55016003)(122000001)(38100700002)(6506007)(7696005)(9686003)(53546011)(966005)(478600001)(66476007)(66446008)(64756008)(66556008)(52536014)(66946007)(316002)(8676002)(4326008)(8936002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T294MzZtcHpUMmxkY1ExelJwcHQyaUNPcGJRdWRocC92di9CUS9aVzlYMWN3?=
 =?utf-8?B?S2kyYlJlNFowTHY1cHVRYXR6V0FyaUtFWm00L1huT0FEZUtNZ2QwTUpQYjRO?=
 =?utf-8?B?cGNLRXI0a29FbHI5UGlUK3YycTFuTlZobkRZeHFkMjhJemZIeEpwd3pQQXBT?=
 =?utf-8?B?T2tCeEw1V2NocEFzeGYvZGZmUDVSaHVYN2NLTEFvWjlvcUZlU2FIZEswRHBz?=
 =?utf-8?B?RlJSTUxocVpKTmZsRmxrR2M0c1czaFZnM2pjYWtiTFRCVkhLOFRYclJtSE9Y?=
 =?utf-8?B?YTYwdnd1MXhwT1lLU3A4aW1WMS9qU2xUeS9JWFlnV2ZCZS9OTEh5dmpROWZI?=
 =?utf-8?B?ellGQjA1aitGM3dyelF6QmhkdXdCZS9QS1QxSEVtcDU2Vk9nNDJSUVRrYm1x?=
 =?utf-8?B?b0VKV2FDdm10TjlyMWI0TXhUb1poSEtYb1B0amtDSjA3MFFKZE1VRFNQZmZO?=
 =?utf-8?B?UUk3ZXFKRlYzRS9jeDM1MStQWnN0VjY1MThyS2pCdnB4TjVSZVk1T3V3cS82?=
 =?utf-8?B?a09CWW5NZjJmWGpYUXVtM2xnYWZGS3NHZ0p3NUpraXVSeFY5ZHN1ek5NTUlH?=
 =?utf-8?B?Z2FxSGdzVWx4bWphVnhrQkROamExUnU5ejd5QU93THI3MnFUdmt4cC9DN0hC?=
 =?utf-8?B?M3VDRjYwa004WDJteFYxWjFqcUxlSmpxR2x4bG1seldaNEZlWEJuQi9CNTlq?=
 =?utf-8?B?YlVRL2dxRUM2enZla1NIMG1XNDVzdW1DSXpNSGcxeTIxUEFrdEdTbUZKNkxq?=
 =?utf-8?B?NWl3V3haand1ZS96eEtrQkYxL05zT1Z3aWE5UWhEU1FFSWVDSGd2S1owK1dF?=
 =?utf-8?B?VjAveUQvUmFuYmJ0TXBITHZCcS82R3BHL0Z3ZngzUURjbW91anFXSFZ6bGVS?=
 =?utf-8?B?SlUxcG5kTi84MnJlck8vVHIxcFl0VTQ1d1ZXQ045Qk05RlZ2REFrRk1WbjR3?=
 =?utf-8?B?N2l3YlZwb0lyM3ZwcFB6YmJVVVhmODR3dDJmKzhLWWE2Ym1sVkI5VVl4d3pC?=
 =?utf-8?B?M0lFYmhTRzIzNFVQVllNWkpWR0ZUSzQ4Tnl3dXZ2bWU5SjV3K3FUWjdSaUFO?=
 =?utf-8?B?Uy9YajdPN1pNZmtzRmdjWDZtRExMU2Jad3hsWUtIMHRqeWVXeGVWQ0tWQzdE?=
 =?utf-8?B?SThMSmNRMEltVXZwRG1HYktjR24vcnVVVVZkckZPaTRqNzZUTklLRlRVNmNH?=
 =?utf-8?B?d1JReEptQ1hXKzJHZU54cXRjNzRnNmFqTk14eXNqelNzK3JjUEt0czl5bkU2?=
 =?utf-8?B?UUxEVC9JMFMxNVp4ZGF0K0x5ZjFzZW0vOG5FM2owb1RPRHVQaGlYN1JBa1Yz?=
 =?utf-8?B?K1RyUFFJQ3NzL2FQMkRVM3hoMVhLMHQxY09QRmFyVDczemdRUm45MGl2OEVz?=
 =?utf-8?B?NnhLa09CUFJBbnFvMnh2TGMxOHpObTBwa2V3UThlUW1zWjhWL016ZUlxanFv?=
 =?utf-8?B?bzY0bDIvNnV4a2RvRDF1MnlvUnJKUGFta28xQS9SMkYvNXVPaGl1K2xWYUR4?=
 =?utf-8?B?WlV5Z3JMMDROSTBKZXZwRCtvOTY2Tzk2UG1HWlBnQmRDWFhQS1lMemVhQnVY?=
 =?utf-8?B?KzZWcGhLOFFEMDhVZ2h6NFpsRlQzVHpVVU8rL3lLeUk5RVJJQjI0WmVUcU5F?=
 =?utf-8?B?TElYMTYwdS9PQ3RQU3MrVjBWZGVxdTVlTlFaMURxaDVHbFBYdlpNZG14TnZV?=
 =?utf-8?B?RGdMTG1YaDUvUTIveEVNV1Z3YUhtMDNzNS9IRHNNU3ZOOVQrcVJKWFduNnU0?=
 =?utf-8?B?WnI3dVhtaVI2anMyU29EUHFPWFBPV1c3czhrSmFxV3NtWlJRdnVEZGV3UmpC?=
 =?utf-8?B?YjZPdDdUYUhLUHA3Qi83djlXMzFEYzh2d0owcTJEc0YraFZiZHZnVld4RlB2?=
 =?utf-8?B?eWRpUjBjSGhXdXc5ek1KUHI1SEZFSXBRdXlqMXpheERPOFJiNUpGS3FBUm5y?=
 =?utf-8?B?UkkzWnJNK0x3czROS2J3WGJIS056RmhxZTY0T05nSms3VHNYeXg2VG9LZ1JK?=
 =?utf-8?B?eitlQ0VIaEt0dkRLM0FUYzBTbUc3OVdsSXh2UFEydTlORUo5N2w1d2hHODlP?=
 =?utf-8?B?eERuenNhNWo2SG8wYnIrVEpoRnlJMmRpV3gybkJneW5UdTNKWW05UFd3dldl?=
 =?utf-8?Q?lmYg=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33532417-3dd4-47cc-3a01-08dbd94d224b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:35:51.4107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktx2hI1Y9LrJ9YRI2hMdh8syaqYEN0CQtuLbGY6B71tOMZm0eGQ7bZQWKZsFNkp9YkR9G6N6gdOUzGkoDn0uGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6145
X-Proofpoint-GUID: EQSsdSXUMghmojQuPDO_o9o6w7lGE2Ac
X-Proofpoint-ORIG-GUID: EQSsdSXUMghmojQuPDO_o9o6w7lGE2Ac
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=920 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyAzOjI3IFBNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWNCAxMi8xOF0gUkRNQS9zaXc6IElu
dHJvZHVjZSBzaXdfZnJlZV9jbV9pZA0KPiANCj4gRmFjdG9yIG91dCBhIGhlbHBlciB0byBzaW1w
bGlmeSBjb2RlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiBDbG9zZXM6IElOVkFMSUQgVVJJIFJFTU9WRUQNCj4gM0FfX2xvcmUua2VybmVs
Lm9yZ19vZS0yRGtidWlsZC0yRGFsbF8yMDIzMTAwOTE2NTYuSmxybWNOWEItMkRsa3AtDQo+IDQw
aW50ZWwuY29tXyZkPUR3SURBZyZjPWpmX2lhU0h2Sk9iVGJ4LXNpQTFaT2cmcj0yVGFZWFEwVC0N
Cj4gcjhaTzFQUDFhbE53VV9RSmNSUkxmbVlUQWdkM1FDdnFTYyZtPWFENGdMN3UwblJPV0lpRmsw
Y2g4ek5YNnZZV0tNVU9vcllFV1BZDQo+IGI5YW1TcW5RVEgwcU5NY0xpakhSTm43cl9zJnM9a21H
R016dHVPVU1lanl4SVNwZlc5NFZ0YkhLRGl2UzlETXVuRWFPeDV1YyZlPQ0KPiBTaWduZWQtb2Zm
LWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+IENo
YW5nZXMgc2luY2UgbGFzdCB2ZXJzaW9uOg0KPiAxLiBhZGQgbWlzc2VkIGNoZWNrIG9mIGNlcC0+
Y21faWQNCj4gDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jIHwgMzAgKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X2NtLmMNCj4gaW5kZXggMmYzMzhiYjNhMjRjLi45Yzc5ZDNlYTViNjYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBAQCAtMzY0LDYgKzM2NCwxNSBAQCBzdGF0aWMgaW50
IHNpd19jbV91cGNhbGwoc3RydWN0IHNpd19jZXAgKmNlcCwgZW51bQ0KPiBpd19jbV9ldmVudF90
eXBlIHJlYXNvbiwNCj4gIAlyZXR1cm4gaWQtPmV2ZW50X2hhbmRsZXIoaWQsICZldmVudCk7DQo+
ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgc2l3X2ZyZWVfY21faWQoc3RydWN0IHNpd19jZXAgKmNl
cCkNCj4gK3sNCj4gKwlpZiAoIWNlcC0+Y21faWQpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWNl
cC0+Y21faWQtPnJlbV9yZWYoY2VwLT5jbV9pZCk7DQo+ICsJY2VwLT5jbV9pZCA9IE5VTEw7DQo+
ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBzaXdfcXBfY21fZHJvcCgpDQo+ICAgKg0KPiBAQCAtNDE1
LDggKzQyNCw3IEBAIHZvaWQgc2l3X3FwX2NtX2Ryb3Aoc3RydWN0IHNpd19xcCAqcXAsIGludCBz
Y2hlZHVsZSkNCj4gIAkJCWRlZmF1bHQ6DQo+ICAJCQkJYnJlYWs7DQo+ICAJCQl9DQo+IC0JCQlj
ZXAtPmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0KPiAtCQkJY2VwLT5jbV9pZCA9IE5VTEw7
DQo+ICsJCQlzaXdfZnJlZV9jbV9pZChjZXApOw0KPiAgCQkJc2l3X2NlcF9wdXQoY2VwKTsNCj4g
IAkJfQ0KPiAgCQljZXAtPnN0YXRlID0gU0lXX0VQU1RBVEVfQ0xPU0VEOw0KPiBAQCAtMTE3Niw4
ICsxMTg0LDcgQEAgc3RhdGljIHZvaWQgc2l3X2NtX3dvcmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19z
dHJ1Y3QNCj4gKncpDQo+ICAJCQljZXAtPnNvY2sgPSBOVUxMOw0KPiAgCQl9DQo+ICAJCWlmIChj
ZXAtPmNtX2lkKSB7DQo+IC0JCQljZXAtPmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0KPiAt
CQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+ICsJCQlzaXdfZnJlZV9jbV9pZChjZXApOw0KPiAgCQkJ
c2l3X2NlcF9wdXQoY2VwKTsNCj4gIAkJfQ0KPiAgCX0NCj4gQEAgLTE3MDIsMTAgKzE3MDksNyBA
QCBpbnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29u
bl9wYXJhbSAqcGFyYW1zKQ0KPiANCj4gIAljZXAtPnN0YXRlID0gU0lXX0VQU1RBVEVfQ0xPU0VE
Ow0KPiANCj4gLQlpZiAoY2VwLT5jbV9pZCkgew0KPiAtCQljZXAtPmNtX2lkLT5yZW1fcmVmKGlk
KTsNCj4gLQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+IC0JfQ0KPiArCXNpd19mcmVlX2NtX2lkKGNl
cCk7DQo+ICAJaWYgKHFwLT5jZXApIHsNCj4gIAkJc2l3X2NlcF9wdXQoY2VwKTsNCj4gIAkJcXAt
PmNlcCA9IE5VTEw7DQo+IEBAIC0xODgwLDEwICsxODg0LDcgQEAgaW50IHNpd19jcmVhdGVfbGlz
dGVuKHN0cnVjdCBpd19jbV9pZCAqaWQsIGludA0KPiBiYWNrbG9nKQ0KPiAgCWlmIChjZXApIHsN
Cj4gIAkJc2l3X2NlcF9zZXRfaW51c2UoY2VwKTsNCj4gDQo+IC0JCWlmIChjZXAtPmNtX2lkKSB7
DQo+IC0JCQljZXAtPmNtX2lkLT5yZW1fcmVmKGNlcC0+Y21faWQpOw0KPiAtCQkJY2VwLT5jbV9p
ZCA9IE5VTEw7DQo+IC0JCX0NCj4gKwkJc2l3X2ZyZWVfY21faWQoY2VwKTsNCj4gIAkJY2VwLT5z
b2NrID0gTlVMTDsNCj4gIAkJc2l3X3NvY2tldF9kaXNhc3NvYyhzKTsNCj4gIAkJY2VwLT5zdGF0
ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gQEAgLTE5MTIsMTAgKzE5MTMsNyBAQCBzdGF0aWMg
dm9pZCBzaXdfZHJvcF9saXN0ZW5lcnMoc3RydWN0IGl3X2NtX2lkICppZCkNCj4gDQo+ICAJCXNp
d19jZXBfc2V0X2ludXNlKGNlcCk7DQo+IA0KPiAtCQlpZiAoY2VwLT5jbV9pZCkgew0KPiAtCQkJ
Y2VwLT5jbV9pZC0+cmVtX3JlZihjZXAtPmNtX2lkKTsNCj4gLQkJCWNlcC0+Y21faWQgPSBOVUxM
Ow0KPiAtCQl9DQo+ICsJCXNpd19mcmVlX2NtX2lkKGNlcCk7DQo+ICAJCWlmIChjZXAtPnNvY2sp
IHsNCj4gIAkJCXNpd19zb2NrZXRfZGlzYXNzb2MoY2VwLT5zb2NrKTsNCj4gIAkJCXNvY2tfcmVs
ZWFzZShjZXAtPnNvY2spOw0KPiAtLQ0KPiAyLjM1LjMNCg0KTG9va3MgZ29vZC4NCg0KQWNrZWQt
Ynk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K

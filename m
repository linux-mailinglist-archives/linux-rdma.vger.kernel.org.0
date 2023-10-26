Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44727D83E9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJZNxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNxq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 09:53:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72DBD
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:53:44 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QDqE2G024299;
        Thu, 26 Oct 2023 13:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=MPX+N9PLDuW/18B5WQ4WMw6HAqZy/axroQcdKRpvDis=;
 b=MWB4qJ8zIrC5vWpsxe5QvyqLGLAujQ/aKoVIclOA56fB9WtkfEgE1QyTsrVed23gQkPv
 aEvYLu4ygK2c3dq/caydSRlI1J7Hg46WrFbdG66gHoKg88tGr8c5bx2E0ekLbZ1ap84w
 Ablsdmm/OUSSnU149YjzAbXdMfqNOjKSPBtMZ7yXntyqKEvWVLELShWI4XAiB00iCv4G
 bd9cBXpwoStL2BGs2b3bOeDuJYw/G5jtEvbQ9IyMKAmtYZtkJTBJfsMJZvmgGDW/y6E/
 4bidpT7ADpcWuq2LMKj3H8Iggqt2tofgyx88dyMOFoX8bIN7rexubwl0K48kuZS1OJo1 kQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyschr1gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 13:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us15GUJBDNT4rYGs7bqsdkbc1YsTBVkfLrRiwOdKbsc9OUI1BY5r0sHKN73bK3H0Dmmncds3xboeYydUtqlrvQEVuaCLr92M5APkpR+fXoChUSgL2fuLnlUbv92h2O2TGddI50GtX77EycmfXctGhFdJBc7kG2EIoUblW2eHmdQ6jabu79VP/eIAg+nFIkcpmiFVRbwf+hfJ4BUzhYflvaWe5SmUS6C4O4GsCC5XUlPm27ArTx8M7eAHxahrMT80eKQGO84Xi1/NW3s9RI+aW7RT9J5Q0xha4G1TZcSEJ83iggOhHVs6sXFHmm0op9/FqEWxCkJCM27c99pnj0VDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPX+N9PLDuW/18B5WQ4WMw6HAqZy/axroQcdKRpvDis=;
 b=es+F4COcMfJqWlzWv8zQ5QAh668RSR+AmQhcdmtcrfAoZbr5T2ub0yqDBquOsNhYuBMPgbBTbtND/gj+5aqMtXr+JHSDTBTEDYW2E1UFzHe5OgyMUEYfXoWBAy4rlkdPTkeuAPucpHUpZV+tAuUH3Um4Hh+hisi/mcEi0Wbt2DNzJOSuksrTk7wEVI9BYoW/EMXAa8otWrB6nABWahcYErwjn1/DBRd399X41a1AxFzaMXpKAs5gX9k7bXEVoY+ZU8xnMoCJPqaSWzX70R9iVtMI54Lnfuqun+1ceF7BpXqDC3huqt2EkEQV/GiZNy+EQq9Vkp6Ua4kGbdAPaXdkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by IA1PR15MB6055.namprd15.prod.outlook.com (2603:10b6:208:44a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Thu, 26 Oct
 2023 13:52:36 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:52:36 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 16/19] RDMA/siw: Remove
 siw_sk_assign_cm_upcalls
Thread-Index: AQHaB0XUA1ZDAo9ne0qoGOWR4Pzm0LBboYmAgABveoA=
Date:   Thu, 26 Oct 2023 13:52:36 +0000
Message-ID: <SN7PR15MB57559D8C1E3BEAC706BD38A399DDA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-17-guoqing.jiang@linux.dev>
 <SN7PR15MB5755801084BA9B601315A31699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
 <88297e58-6da5-3dfd-549d-0c36f4e014bc@linux.dev>
In-Reply-To: <88297e58-6da5-3dfd-549d-0c36f4e014bc@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|IA1PR15MB6055:EE_
x-ms-office365-filtering-correlation-id: 7ebd86ee-e040-4870-d26e-08dbd62acfc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2XMdUJvRRg3srqQA8di9Tm0o9hD3psGUgsVCeqfl0AF69gNM6mbZL/yWom48LxXImfspW93hjD9L9zAy0+2uNuiYDe129x3hFTZwPr0FIy7ACVKZ95bk5SK2yH8sJWKj+sFR8UtMbOmMYBk02wgqM2NHDA+4bwIcj39WhEA+NmNTN8lp+IHxwvovOAS9nX1pbjy2ihdJRfN8KlNY7614DOictiSdplqF5ZeH4laU3B8dmvdJoWhBxI+OrG8Jsp6lIBPA98YS5OTeDMy5dfcwtQCzPy0TsggwOHB1RgIY5eVzcYvPxKtCAKlJi3kJ/vnl7js7jQHD20d60u8BwAzm8OMQY0YnHhUm8wsbBCwOezAZPlaJpeWmCSsg0uUD0mkWMGFQ0JXZuYkw3Y7fJjrbMH3xMVRfB1aTKLwTKTYOVEGSFGj2+eGMgBqi51DYURU05rv3Ip2hn6Gi8w5VDVYDRC+mYKo3jQ2rWhgoGmUDUeRstZNgysGgRVEiagCTjDGyyS5txKZp9FtpIk8EUHwXu6hfbpgoKeEhR+/dcH1XSNA0E2TTaBSf+WIsidHJV2mm9Qg1kI1dQD8TnKGgBqzDejf3xxkVtw3bWczXLeEuYd3BCX3BHfnDOMCZlX0MwFO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(55016003)(122000001)(38100700002)(38070700009)(478600001)(2906002)(8676002)(8936002)(4326008)(66476007)(66446008)(64756008)(66556008)(66946007)(316002)(52536014)(33656002)(5660300002)(76116006)(110136005)(41300700001)(86362001)(71200400001)(7696005)(9686003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3djT2JqT2p3bUtzZFY1cGZHR3BCQ3RsVjBBeGx6Mkptd0JjVUpLd2pzQU8r?=
 =?utf-8?B?ZU8xRlZ6dTdORTdpbnZGU2ZGNHNJbU9qdHhtSm1yMHFlTjVJUmZKT09yOEVZ?=
 =?utf-8?B?MDF6U1NvNGRSS1ZWZzc2Q05yeTJBZ1N2dlgveVB0b0VjaUpHRllaOU1FdXVZ?=
 =?utf-8?B?TXpDNVU3NWdjNFZYWDAzTG9lNE9McVYwTmVNd0NWUzBCamcweHdDRnptMkZr?=
 =?utf-8?B?ank3WlFpUlVzK25tV0hSWVk5NnpiVFpFb1E3ZUsxUDZRaHloYlJkN0JhMTdH?=
 =?utf-8?B?U0RhK2h5SC9vMFV3ZGFMV3AySm1FRG8zWjNpSTZQWFkxandYTERKdWdZYUtN?=
 =?utf-8?B?RkhZaWE5c1haZHllK1h5SjM0N0dIRE0xVHByaHB4Q3RkK2pGNENCUlI1SkRJ?=
 =?utf-8?B?aGpLVGdZbm10UUh5bFhYWXYvYXpXVWxHWDdDaGIrb0QyRTV6MG5xTmxtZmZk?=
 =?utf-8?B?YUl0OE1tWHFYRU1yQmFNOVNsQTlUL1Z0T0M1NHY5Y0Jta05xc1l1K25iTjQw?=
 =?utf-8?B?RlR3L0VFZkc5TDNSRTQvSU9CYk9KZzcyZGFwZWNLVmZobGFuS3dkaThTVlBR?=
 =?utf-8?B?dWtYMzhSY0lzRjc0Q3FrbS81YnVBV3RlajA1dkhQNDcvV0w2WkhRTWxRKzIy?=
 =?utf-8?B?NCtPV0R1TlFHc0ZBd0VHdXRrdmVvVm4wc0tMR05BYXBMREhzdEYrNXhyYzhM?=
 =?utf-8?B?SHFQT2pPczZrYmc0SU1jUHlSbnhIcWlURThydnFyUTZvbGVEdzk2aTRMR3Nh?=
 =?utf-8?B?aTk1Y0x0UVNxUjZhMi9iU0xyR1JIMWJHdVU1bVV5ekZrWituRkZ1VzhHUThk?=
 =?utf-8?B?dmI4dGNaWTZ0eXQrYVl6bUxKeWhnUnFlaENSUkIxUHBkVXlYTVQ2TmVscm1H?=
 =?utf-8?B?VG9DQUZTdk9LZnBTWXl2ZnRONExETVI1VndIZVNac3Q3aG9LOXAxVTh0WGxZ?=
 =?utf-8?B?dXdBZS9udEpDZHhTVEpHK0kycEpMYlBvYkFCd29kb1dBMVZ1MERORTQ4ZGVR?=
 =?utf-8?B?cGIvdFBuenNxZCsrS0hBb0VsWHlYZ0JPVEIrTmVRRDY2akNHZi9lLzJBMDU3?=
 =?utf-8?B?ajdic1hLZGMrUkFPcTNRbnNZbU1XdXZLNExSRS90a3BMemVjRUM1MjJBNGVQ?=
 =?utf-8?B?NFVqekJQdzhHb2RlMFNoNjRTQ0M4RzRlREEzM2JmOHNSTmdPRnNEVmtVM2hv?=
 =?utf-8?B?WEJvYi9sZDNCTzlrT3k0Mkw2b20vNHdPNlhCbWFkRGlYYVZNVTNzbmRWcThC?=
 =?utf-8?B?WE9NNFB3eTJXU3hObFNTZWpwQlFHYmYzRGpIMzEzZDREdXlGWjdYZkUxT2F4?=
 =?utf-8?B?NWxTRURLMWFXWTR2NjcxTElRa2VmNlRQd2VaQVNaN3FlSW1xVzlVbVp5TjNI?=
 =?utf-8?B?ai9SS0xNYUJRWWc2azI4bUZQV3dFUjVGTFdPVS8yM2lDZk11T0dzbnJrdFB6?=
 =?utf-8?B?V0lzSGdyTitNcm9KN0h2ay9vNlE5YUErVUY3U0o4WTB2OGRISUhEeGVWYzhI?=
 =?utf-8?B?TFg5T2FwQjlFbENzNUlZYys5ckhxb05yakZiY1RQVE9XbHVya2hWZG9QVnhJ?=
 =?utf-8?B?KzNIbUxUcVNvZU4xVFRnb2dTQ3VOMTFGb25CWXRjcUdoS1pEbmNLNUlZd040?=
 =?utf-8?B?dlVYRG80Y0E3YnFUVWY5eGtaRXdzdHVQWkh2K0Z0R0RueHNVcFFLcURpc3Fo?=
 =?utf-8?B?RzQwS2ZkNUFuYzFxTmgvQytGRlpjNVFSOUJnVlBOeUZFUmN2SG8ydE1yZHY2?=
 =?utf-8?B?MWlFTitUa2pibUJDY0E1cG13MUJBY2ZCV2h6cWtMeEpJMTFyQXdMZUJsL1BN?=
 =?utf-8?B?YXNIcVZMbkt1TWw4QzdoWUcvNXhoSTJZdHd2QWZ6SlkwbXFENVZ3bGJvNGF2?=
 =?utf-8?B?bHJBay9VZWpMdHdDajh2ZDczRHJEaEdIbno3Y0RPM295S0tncUpZT1lSc2dy?=
 =?utf-8?B?cW5KOUJQLzZnTml4OUpVSEM2UERQUjZjUFlNVGM1b2podzRFcUxHYmpyZG95?=
 =?utf-8?B?UFFtSnNEamJPKzV0S3pZdUsvdDlueEJNTFA0YnNUYzNlcW41T0Y0TzdYa3RV?=
 =?utf-8?B?RDlEVGgybVgwT0VSVExuQXBQSXJmZzdxNGJ4ak1WUmMxRzh4dHErbTVSNXM5?=
 =?utf-8?B?YnBrTHcza3BGMTRMeE5ickE2eVErZHc3UHdsdG9KdVBwRzVMdGVNTmdVQWpa?=
 =?utf-8?Q?dzIqes6bXvbpr/uvnMIsx94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebd86ee-e040-4870-d26e-08dbd62acfc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 13:52:36.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOotI6+wMsXGcd25vg7FaXQOF7xklN+ZGhgPIfpfI0gvsjsyVnQY0Ms1ft6kFVK82TXMVABB2jjT9IbV5qREjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6055
X-Proofpoint-ORIG-GUID: UbaQIL8RvLpyedBwxCGlxoteWEhhukHQ
X-Proofpoint-GUID: UbaQIL8RvLpyedBwxCGlxoteWEhhukHQ
Subject: RE: [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_12,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI2LCAy
MDIzIDg6NDYgQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsg
amdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCAxNi8xOV0gUkRNQS9zaXc6
IFJlbW92ZQ0KPiBzaXdfc2tfYXNzaWduX2NtX3VwY2FsbHMNCj4gDQo+IA0KPiANCj4gT24gMTAv
MjUvMjMgMjE6MTksIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogR3VvcWluZyBKaWFuZzxndW9xaW5nLmppYW5nQGxpbnV4
LmRldj4NCj4gPj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDksIDIwMjMgOToxOCBBTQ0KPiA+PiBU
bzogQmVybmFyZCBNZXR6bGVyPEJNVEB6dXJpY2guaWJtLmNvbT47amdnQHppZXBlLmNhO2xlb25A
a2VybmVsLm9yZw0KPiA+PiBDYzpsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJq
ZWN0OiBbRVhURVJOQUxdIFtQQVRDSCAxNi8xOV0gUkRNQS9zaXc6IFJlbW92ZQ0KPiBzaXdfc2tf
YXNzaWduX2NtX3VwY2FsbHMNCj4gPj4NCj4gPj4gTGV0J3MgbW92ZSBpdCBpbnRvIHNpd19za19z
YXZlX3VwY2FsbHMsIHRoZW4gd2Ugb25seSBuZWVkIHRvDQo+ID4+IGdldCBza19jYWxsYmFja19s
b2NrIG9uY2UuIEFsc28gcmVuYW1lIHNpd19za19zYXZlX3VwY2FsbHMNCj4gPj4gdG8gYmV0dGVy
IGFsaWduIHdpdGggdGhlIG5ldyBjb2RlLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBHdW9x
aW5nIEppYW5nPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiA+PiAtLS0NCj4gPj4gICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jIHwgMTkgKysrKysrLS0tLS0tLS0tLS0tLQ0K
PiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
Yw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gPj4gaW5kZXgg
YzNhYTU1MzNlNzVkLi42ODY2ZWM4MDQ3M2MgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfY20uYw0KPiA+PiBAQCAtMzksMTcgKzM5LDcgQEAgc3RhdGljIHZvaWQgc2l3X2Nt
X2xscF9lcnJvcl9yZXBvcnQoc3RydWN0IHNvY2sgKnMpOw0KPiA+PiAgIHN0YXRpYyBpbnQgc2l3
X2NtX3VwY2FsbChzdHJ1Y3Qgc2l3X2NlcCAqY2VwLCBlbnVtIGl3X2NtX2V2ZW50X3R5cGUNCj4g
Pj4gcmVhc29uLA0KPiA+PiAgIAkJCSBpbnQgc3RhdHVzKTsNCj4gPj4NCj4gPj4gLXN0YXRpYyB2
b2lkIHNpd19za19hc3NpZ25fY21fdXBjYWxscyhzdHJ1Y3Qgc29jayAqc2spDQo+ID4+IC17DQo+
ID4+IC0Jd3JpdGVfbG9ja19iaCgmc2stPnNrX2NhbGxiYWNrX2xvY2spOw0KPiA+PiAtCXNrLT5z
a19zdGF0ZV9jaGFuZ2UgPSBzaXdfY21fbGxwX3N0YXRlX2NoYW5nZTsNCj4gPj4gLQlzay0+c2tf
ZGF0YV9yZWFkeSA9IHNpd19jbV9sbHBfZGF0YV9yZWFkeTsNCj4gPj4gLQlzay0+c2tfd3JpdGVf
c3BhY2UgPSBzaXdfY21fbGxwX3dyaXRlX3NwYWNlOw0KPiA+PiAtCXNrLT5za19lcnJvcl9yZXBv
cnQgPSBzaXdfY21fbGxwX2Vycm9yX3JlcG9ydDsNCj4gPj4gLQl3cml0ZV91bmxvY2tfYmgoJnNr
LT5za19jYWxsYmFja19sb2NrKTsNCj4gPj4gLX0NCj4gPj4gLQ0KPiA+PiAtc3RhdGljIHZvaWQg
c2l3X3NrX3NhdmVfdXBjYWxscyhzdHJ1Y3Qgc29jayAqc2spDQo+ID4gVG8gc2ltcGxpZnksIEkn
ZCBzdWdnZXN0IGRvaW5nIGl0IHRoZSBvdGhlciB3YXkgYXJvdW5kLA0KPiA+IHNvIGhhdmluZyBz
aXdfc2tfYXNzaWduX2NtX3VwY2FsbHMoKSBpbmNsdWRpbmcgdGhlDQo+ID4gZnVuY3Rpb25hbGl0
eSBvZiBzaXdfc2tfc2F2ZV91cGNhbGxzKCkgZmlyc3QuDQo+IA0KPiBJIGd1ZXNzIHlvdSBtZWFu
IGJlbG93LiBJZiBzbywgSSB3aWxsIHVwZGF0ZSBpdCBpbiB2My4NCg0KcmlnaHQuIGFzc2lnbmlu
ZyB0aGUgY20gdXBjYWxscyBpcyB0aGUgZmlyc3Qgc3RlcCBhbmQNCm5lZWRzIHRoZSBvcmlnaW5h
bCBzb2NrZXQgY2FsbGJhY2tzIHNhdmVkLiBMYXRlciwgbWF5YmUNCndlIGhhdmUgdG8gcmVhc3Np
Z24gdGhlIHVwY2FsbHMgdG8gZXhlY3V0ZSB0aGUgYWRkaXRpb25hbA0KUlRTIGhhbmRzaGFrZS4g
DQo+IA0KPiAgwqBzdGF0aWMgdm9pZCBzaXdfc2tfYXNzaWduX2NtX3VwY2FsbHMoc3RydWN0IHNv
Y2sgKnNrKQ0KPiAtew0KPiAtwqDCoMKgwqDCoMKgIHdyaXRlX2xvY2tfYmgoJnNrLT5za19jYWxs
YmFja19sb2NrKTsNCj4gLcKgwqDCoMKgwqDCoCBzay0+c2tfc3RhdGVfY2hhbmdlID0gc2l3X2Nt
X2xscF9zdGF0ZV9jaGFuZ2U7DQo+IC3CoMKgwqDCoMKgwqAgc2stPnNrX2RhdGFfcmVhZHkgPSBz
aXdfY21fbGxwX2RhdGFfcmVhZHk7DQo+IC3CoMKgwqDCoMKgwqAgc2stPnNrX3dyaXRlX3NwYWNl
ID0gc2l3X2NtX2xscF93cml0ZV9zcGFjZTsNCj4gLcKgwqDCoMKgwqDCoCBzay0+c2tfZXJyb3Jf
cmVwb3J0ID0gc2l3X2NtX2xscF9lcnJvcl9yZXBvcnQ7DQo+IC3CoMKgwqDCoMKgwqAgd3JpdGVf
dW5sb2NrX2JoKCZzay0+c2tfY2FsbGJhY2tfbG9jayk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2
b2lkIHNpd19za19zYXZlX3VwY2FsbHMoc3RydWN0IHNvY2sgKnNrKQ0KPiAgwqB7DQo+ICDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3Qgc2l3X2NlcCAqY2VwID0gc2tfdG9fY2VwKHNrKTsNCj4gDQo+IEBA
IC01OCw2ICs0OCwxMSBAQCBzdGF0aWMgdm9pZCBzaXdfc2tfc2F2ZV91cGNhbGxzKHN0cnVjdCBz
b2NrICpzaykNCj4gIMKgwqDCoMKgwqDCoMKgIGNlcC0+c2tfZGF0YV9yZWFkeSA9IHNrLT5za19k
YXRhX3JlYWR5Ow0KPiAgwqDCoMKgwqDCoMKgwqAgY2VwLT5za193cml0ZV9zcGFjZSA9IHNrLT5z
a193cml0ZV9zcGFjZTsNCj4gIMKgwqDCoMKgwqDCoMKgIGNlcC0+c2tfZXJyb3JfcmVwb3J0ID0g
c2stPnNrX2Vycm9yX3JlcG9ydDsNCj4gKw0KPiArwqDCoMKgwqDCoMKgIHNrLT5za19zdGF0ZV9j
aGFuZ2UgPSBzaXdfY21fbGxwX3N0YXRlX2NoYW5nZTsNCj4gK8KgwqDCoMKgwqDCoCBzay0+c2tf
ZGF0YV9yZWFkeSA9IHNpd19jbV9sbHBfZGF0YV9yZWFkeTsNCj4gK8KgwqDCoMKgwqDCoCBzay0+
c2tfd3JpdGVfc3BhY2UgPSBzaXdfY21fbGxwX3dyaXRlX3NwYWNlOw0KPiArwqDCoMKgwqDCoMKg
IHNrLT5za19lcnJvcl9yZXBvcnQgPSBzaXdfY21fbGxwX2Vycm9yX3JlcG9ydDsNCj4gIMKgwqDC
oMKgwqDCoMKgIHdyaXRlX3VubG9ja19iaCgmc2stPnNrX2NhbGxiYWNrX2xvY2spOw0KPiAgwqB9
DQo+IA0KPiA+IFRoZXJlIGlzIGFub3RoZXIgZnVuY3Rpb24gc2l3X3NrX2Fzc2lnbl9ydHJfdXBj
YWxscygpLA0KPiA+IHdoaWNoIHJlLWFzc2lnbnMgdGhlIHVwY2FsbHMgZm9yIHNwZWNpYWwgaGFu
ZGxpbmcgb2YNCj4gPiBhbiBleHBsaWNpdCBSVFItPlJUUyBoYW5kc2hha2UgaWYgcmVxdWVzdGVk
IGxhdGVyIGR1cmluZw0KPiA+IGNvbm5lY3Rpb24gc2V0dXAuDQo+IA0KPiBBaCwgb25lIGlzIGFz
c2lnbiBydHIgdXBjYWxsIGFuZCBhbm90aGVyIGlzIGFzc2lnbiBjbSB1cGNhbGwuDQo+IFRoYW5r
cyBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KPiANCj4gR3VvcWluZw0K

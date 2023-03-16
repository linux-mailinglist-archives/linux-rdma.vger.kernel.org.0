Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E46BD811
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCPSTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCPSTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 14:19:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E166E1FE1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 11:18:32 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GHVjIj019076;
        Thu, 16 Mar 2023 18:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=4OVTKRQXEHp5BTGEu6OuG3Gqk9xkx83i7rFiOg0khvU=;
 b=rVc1Qvqw8PH1ZdzDXEBY87G2tdup5u3pkezyVfYEUYvbU8mN/zLipHc/Vlp+6O1hHf8i
 eiR7RwKa0QNTq3ESWMXecd470O3DFtf5tmpVa3VI+RYK+c5do+oAHZ6sRAdRGO4MLC7x
 Kn1pjyAfOF1+R3m3zJBev3Y5+iMRakNNO2CInceLIn75VRqTRdLH7vdfFzC5d5gyJuUY
 9H6M0rimRgdu2BwycOFUbxSS6SZvlMWzEiGO6qiATwwirl138qwGAhgH1AiTCVC2Xt+g
 NcAxEJNV+OP+6TUhb6BsT7q/Idr0GB8la7f8CW/dBVSAXFH58FdU4FMZxcKF6Wd26ZeZ yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pc7kf17rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 18:18:25 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32GHtSUx018594;
        Thu, 16 Mar 2023 18:18:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pc7kf17r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 18:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7NtLcSUjooA2QJNAQ/jAibGSIPNYXJRYjxnAeT51ZRWvku2VLJ/SkcNgRh8P5KBIOowOxikhvWTsoaukDFMR1MVXU/lpR24GYZ/O7NN9q6anAKUqGFgT7gZHZh8df4s//HlI9VaEvokxD2YRayeuZI5sowtHg7nAOGGGLKboDL1ZiNnyoxSVIsaLtECX/61hZpRlNbpIDr1N0GdwkuIlJ8SgR7QEl8q72BG7BXnHCE6uIJQ4Sc4yv77jzI7HVJ9XD+oHPBjqBWwvvRDLJITxGOScOUEAc5k2rWVd42zI+IkvEb3AppO140FzezTBo2ggXaMDZ43mpYnkZJP4cgbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OVTKRQXEHp5BTGEu6OuG3Gqk9xkx83i7rFiOg0khvU=;
 b=lVJf0n+7Fq12LM40z0ZYqYp3SFiNkvUsIrdN2StkaVs/HhwD5RaDm7NjJ3h0WHSrFDhptkHUt7epWwHSC1fLr+Yp9fVM08oau5hIVbLjUH5iSVFoC88GdGQ76xRjGtisj1J+J9ZZNS+LzpbEnrfQm4qN7pPIe3xPedYJlXANrRrbli/6ZDnD7j2AOJl0JZXxPkZYwkG5QjNEmNkU4+XKgQImsG3jU9TBDUH667DEvkjEZco/JE5KdWYv+updML5mzWtWj4sp+gV/Yc/XmvOfw8ouL6CmzjmE1n/gyDm7eLRZM0INI2kDUUNTah4fS+ZYL88vvP4ugCFuDOT+JVOAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA1PR15MB4903.namprd15.prod.outlook.com (2603:10b6:806:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 18:18:23 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%4]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 18:18:23 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: question about the completion tasklet in the rxe
 driver
Thread-Index: AQHZWCrIVo0XeU6nOEGDdzgdn9tD/K79tvBA
Date:   Thu, 16 Mar 2023 18:18:23 +0000
Message-ID: <SA0PR15MB391950769375378B992A7E7199BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
 <SA0PR15MB3919EAF4C949E82D2887C1AA99BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <3d8576fc-eab5-c962-95bb-badadd18c85f@gmail.com>
In-Reply-To: <3d8576fc-eab5-c962-95bb-badadd18c85f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SA1PR15MB4903:EE_
x-ms-office365-filtering-correlation-id: 7680c97a-23f8-4572-58da-08db264ad427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVqTlGVNzJ0RyTKHXC7Vy7hhTjOhoMLkvq8OWyB28nXjFpoA+khcTOSHobhIF2RJyitSBxstwzoBflr63b3YYhqYaIMEv4/V3SEdAZpwPfpm+uNabFT2rPyxZx9JDgMuwi0/1azge+G00e4kbg1XpVMVCuce1hcPfsoc8EGB/MSuHopcWhx1wizT8WoUP0Svx2i6Q+IGh7oqHOqrENy+llHE75DUXPiIuGLUVSVCLmwecWMh3E2OLdt5xX6igJSfvb5M/0Lt6kIjAZdqWtJbEkxStCDL/wllkTQKmk3dr7Uwx3CMt4GTqYiscbgrFOpWjkqPFolqt7nl0Bcw6ERBiq491dNgCO1EIzczmSr8oBja5/yt4DoF9ntNk4wz8m7zvWtJMKVPPln1Kbtd7IrUqSaCrXx220tuc6WIzL0Ox8Vy4Jf+aTJTWTvDGC0gWBSzNduqVUJPedaKXyjDm8ALQ93CTD4jymfI+uAqv1J3HPRrJb+R5irszp9EY4YlsOCV4uDnR/fM9+hDCGgLgovDr6H4onf0Ny5CIvciQlE5eVN+OqYIF51hZAq0dV1Gs21odTm8d1Q4XJC4LdRuhSDRsTmu7GARCgL9xsB/fIXYHS1qjUCeyPylmuEHk8kRg5NAkwSiUCCqelAmEf7/OTEgeNQunJTjy9LBl0wkzcBbg9n1dwV6AXW5DKzUfGD/c2DoW3/iqE7f9ZXkodB8hyhQpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(71200400001)(7696005)(478600001)(55016003)(2906002)(9686003)(6506007)(33656002)(186003)(53546011)(5660300002)(86362001)(41300700001)(122000001)(38100700002)(316002)(64756008)(66446008)(8676002)(76116006)(38070700005)(66556008)(8936002)(66946007)(52536014)(66476007)(83380400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNSSW1SWnZ3dTEwN1NvOEpySUJlc0NSYVl1VVdZVnVla2YrRVhlcHBHNnNB?=
 =?utf-8?B?TURLZFVUenUzNTBBTEV6b0ZUdlphZVdEQVJncHZEN1RMK2tYZ0FvcVh4cGZo?=
 =?utf-8?B?ZmlLamtvVTJ0QnExSFBiV3RoVXR4QjFnTXJGdmpYUkNmQlplMWZiM2N5cFhu?=
 =?utf-8?B?T2tnY0NxdGRQZlNqbkFhR1J2RmVDRCtvdllYY1BwbStaSWlDN0JibXdBVSt6?=
 =?utf-8?B?UjM4NkFFbk13bmlGK1RXK1kxSlJZMkZsd3dIRE5CMStpMy9iNDNadldOeWdP?=
 =?utf-8?B?dE9tK0RTM3NEWloxNDVZWWY0TmN6L1JmZ0lIaTVWYnZsbUJ6NXFrRlA2eTAv?=
 =?utf-8?B?Z08rUVZRZDYzQlNOdEZLNkthWlNzTDY3bUI4OGpWcmwzNTltenRUVTVyVFhx?=
 =?utf-8?B?T3RKY090Y0lBWm9UNSswcnVjOVh6aWhtTzFlTDRVaElKd3BSR2hOT2JYVzVF?=
 =?utf-8?B?cHZMVzdDYU5lRUh2SmZ1dGlXVWVXZTAvdUJneXB5dkFIMjJVWlowdlVqSW53?=
 =?utf-8?B?SXV6K0diZGxXU3l2U2hyZkROTi9uTHRVRXdOTjZBYWdyRGJzVXg2NWh2dXFV?=
 =?utf-8?B?SVpmZHUvdC9mcEVrYkkxaGxjTGh6VisxVWNuVzJkNjlmWGJaaWpCN2N0WFNz?=
 =?utf-8?B?WGhSRUdjSnE5SUs0UTZKbWtOdzczQ0Vja2dkcFNCS2xVUEdNbW1xeno0U0l2?=
 =?utf-8?B?SGNjUFBHc3lUanB2YlFQN1RBc1YvT3VzbUpHOTNXb3AvS0M1TENGMm9yeUFQ?=
 =?utf-8?B?NHZlV1c5bGdTOGJZQzVQYUpXaUk2b3JaSTJWRGUxdUFnaFRtTzhxVDVreEQ2?=
 =?utf-8?B?U2U5NEJkQ2VUa1BTQ1FNTGw4VUY4V0x2ZzZPSHVUb1BqT2MzTkVMeDV2bXkx?=
 =?utf-8?B?WTZsOVNNcEp1VFVBZ0JkUkh4eFhNRkdMcHk2NEFUQUZMVFhyay8walVDNzJQ?=
 =?utf-8?B?bGpvcm9tSTdXZVB6Y2syYlI0WURQajcwWGtPSXhRUWM3VGoyazc1dytCV1Br?=
 =?utf-8?B?djNpcVJiSkNOcTFPcmtTUDhwZWpkNzdPWDgrOGJRTnBTOXo2SWFQUFBVVTQz?=
 =?utf-8?B?V1RKb0I1SHlweEp2dXlqamUvd3dRbkNja05yOGU0bWJHeXhIcFNRUnNhMHl2?=
 =?utf-8?B?RTU2RkRzeEZ4Y20zSlNPYTNISUljWnZ2V1gyUWwrTm8xaGpyUGdMWVN5ZC8y?=
 =?utf-8?B?SXVBck5qVFY5ODFoMWFVL21zTDB2ZDRzNTFFWEc5UTM3bVh4b0Q2aFRzdjM1?=
 =?utf-8?B?NHhaQ0FPRTl5U1VwZnlLdWtQeUZDZVVGOWF6aFZsRlhrdE5LaU4zQ1h2Zzda?=
 =?utf-8?B?TEovNHFEbjIxZks1OVAwTXJjVStJWUY3S3M4aXRWTTlJQUZmbm83N3VaRnM0?=
 =?utf-8?B?QXpiV3ZZN0NtVmFQNHdmQnhWTUhROU1SeHV0TjNUQ0o1VWU0dHRoZFVoS0o1?=
 =?utf-8?B?U2tGMmhOb0NHUW9WM2ZZYXFiUGhNQWNFMkRYM3FZWTd2Y0JlaUZIZEtMRS9N?=
 =?utf-8?B?RmF2bHlxY2Z2ekxNQjk1L1NFRm9VRk9VR1JCdUw3Y1JOK0dHWmF4WkZpc3pD?=
 =?utf-8?B?L1djRGlvdCs5N3RkUmZVM3JzV0piNHJVOFQ0bUlmYXIreHpVVUpmSkpiR3Rp?=
 =?utf-8?B?MVpwOVVrN2JuSHFaQmY0aE54aHFGNEliVHd4eWJtbmJzdkpaam5CLzJ5enB4?=
 =?utf-8?B?aXdpeGF0ZlZ3OWVDS2RQcTJJK2NmVXliODY0S1c5SlFLQi9NV0JKL3Z1RXFJ?=
 =?utf-8?B?bkZPSllEajNSSmxqaWlmNjdLYVpIeHY0QWdQeWEyaXBidis0QkZ0V1lZQ28y?=
 =?utf-8?B?N0srMkZ2M1cxTlg1YU5JQ01WM2lwZGFOLzhpTmFReTVnNnpvVGNJQlpiamU5?=
 =?utf-8?B?NzExRDZTckxWZUY0M2ExYkhxNkxxMXBWVWVFQys1SVNtZHZlcDJzdTFabWgv?=
 =?utf-8?B?Z0gvRi9XOFg0Y0dFdnYvY3doSWd0OGlIZ0djRHRSSlJ0MDFuL3FpRGdJTFVz?=
 =?utf-8?B?U0VGdjA4d1F6Rm9LVDluRWp2UURSMXNyOGdEb0JHTTBydUJabVJwTWFUYWx0?=
 =?utf-8?B?QkhzUFliV2hOVlozZkZZaEhka0lRVEtRM2VYVXd0UkZselZ4NjJOckVsUzZS?=
 =?utf-8?B?T3c4aytkRjgrdlo0MWhid2lubk5qVW9yZldzZ3pRUGlhMU83eFQrbFJ1QVB3?=
 =?utf-8?Q?cghV9afca3wm83AN7zZp9DooS5ZMgcLCiUQeGRHfDTDS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7680c97a-23f8-4572-58da-08db264ad427
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 18:18:23.1216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdcW0vhKembtxwJ8GZfBWpJgk6BmQLA9Sl9rcTX3nP4EYHFEWJBXD4la4TzUU+ggoDxPjTelbKKpABMyHY7FJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4903
X-Proofpoint-ORIG-GUID: RkFzDs-jAPDYhs_U3S9rKORxUCPUr3ZW
X-Proofpoint-GUID: HXUobF4KrWA4A9lV_Z98OLDmPGPCRGYJ
Subject: RE: question about the completion tasklet in the rxe driver
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9iIFBlYXJzb24gPHJw
ZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE2IE1hcmNoIDIwMjMgMTg6
MTUNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47DQo+IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwu
Y29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogcXVlc3Rpb24gYWJvdXQgdGhlIGNvbXBsZXRpb24gdGFza2xldCBpbiB0aGUgcnhlDQo+IGRy
aXZlcg0KPiANCj4gT24gMy8xNi8yMyAwNDo0MCwgQmVybmFyZCBNZXR6bGVyIHdyb3RlOg0KPiA+
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQm9iIFBl
YXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCAxNSBN
YXJjaCAyMDIzIDIyOjU2DQo+ID4+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
PjsgWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+Ow0KPiA+PiBsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZzsgQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+ID4+
IFN1YmplY3Q6IFtFWFRFUk5BTF0gcXVlc3Rpb24gYWJvdXQgdGhlIGNvbXBsZXRpb24gdGFza2xl
dCBpbiB0aGUgcnhlDQo+IGRyaXZlcg0KPiA+Pg0KPiA+PiBJIGhhdmUgYSBnb2FsIG9mIHRyeWlu
ZyB0byBnZXQgcmlkIG9mIGFsbCB0aGUgdGFza2xldHMgaW4gdGhlIHJ4ZSBkcml2ZXINCj4gPj4g
YW5kIHdpdGggdGhlIHJlcGxhY2VtZW50IG9mIHRoZQ0KPiA+PiB0aHJlZSBRUCB0YXNrbGV0cyBi
eSB3b3JrcXVldWVzIHRoZSBvbmx5IHJlbWFpbmluZyBvbmUgaXMgdGhlIHRhc2tsZXQNCj4gdGhh
dA0KPiA+PiBkZWZlcnMgdGhlIENRIGNvbXBsZXRpb24NCj4gPj4gaGFuZGxlci4gVGhpcyBoYXMg
YmVlbiBpbiB0aGVyZSBzaW5jZSB0aGUgZHJpdmVyIHdlbnQgdXBzdHJlYW0gc28gdGhlDQo+ID4+
IGhpc3Rvcnkgb2Ygd2h5IGl0IGlzIHRoZXJlIGlzIGxvc3QuDQo+ID4+DQo+ID4+IEkgbm90aWNl
IHRoYXQgdGhlIG1seDUgZHJpdmVyIGRvZXMgaGF2ZSBhIGRlZmVycmFsIG1lY2hhbmlzbSBmb3Ig
dGhlDQo+ID4+IGNvbXBsZXRpb24gaGFuZGxlciBidXQgdGhlIHNpdyBkcml2ZXINCj4gPj4gZG9l
cyBub3QuIEkgcmVhbGx5IGRvIG5vdCBzZWUgd2hhdCBhZHZhbnRhZ2UsIGlmIGFueSwgdGhpcyBo
YXMgZm9yIHRoZQ0KPiByeGUNCj4gPj4gZHJpdmVyLiBQZXJoYXBzIHRoZXJlIGlzIHNvbWUNCj4g
Pj4gcmVhc29uIGl0IHNob3VsZG4ndCBydW4gaW4gaGFyZCBpbnRlcnJ1cHQgY29udGV4dCBidXQg
dGhlIENRIHRhc2tsZXQgaXMNCj4gYQ0KPiA+PiBzb2Z0IGludGVycnVwdCBzbyB0aGUgY29tcGxl
dGlvbg0KPiA+PiBoYW5kbGVyIGNhbid0IHNsZWVwIGFueXdheS4NCj4gPj4NCj4gPj4gQXMgYW4g
ZXhwZXJpbWVudCBJIHJlbW92ZWQgdGhlIENRIHRhc2tsZXQgaW4gdGhlIHJ4ZSBkcml2ZXIgYW5k
IGl0IHJ1bnMNCj4gPj4gZmluZS4gSW4gZmFjdCB0aGUgcGVyZm9ybWFuY2UgaXMNCj4gPj4gc2xp
Z2h0bHkgYmV0dGVyIHdpdGggdGhlIGNvbXBsZXRpb24gaGFuZGxlciBjYWxsZWQgaW5saW5lIHJh
dGhlciB0aGFuDQo+ID4+IGRlZmVycmVkIHRvIGFub3RoZXIgdGFza2xldC4NCj4gPg0KPiA+IFRo
YXQgaXMgd2hhdCBJIHdvdWxkIHN1Z2dlc3QgdG8gZG8uIFdoeSB3b3VsZCB5b3UgbGVhdmUgcmVj
ZWl2ZQ0KPiA+IHByb2Nlc3Npbmcgb3IgZmFpbGluZyBzZW5kIHByb2Nlc3Npbmcgdy9vIGNyZWF0
aW5nIHRoZSBDUUUgYW5kDQo+ID4ga2lja2luZyB0aGUgQ1EgaGFuZGxlciwgaWYgeW91IGFyZSBp
biBhIGNvbnRleHQgd2l0aA0KPiA+IGFsbCBpbmZvcm1hdGlvbiBhdmFpbGFibGUgdG8gYnVpbGQg
YSBDUUUsIHNpZ25hbCBpdHMgYXZhaWxhYmlsaXR5DQo+ID4gdG8gdGhlIGNvbnN1bWVyIGFuZCBr
aWNrIGEgdXNlciBoYW5kbGVyIGlmIHJlZ2lzdGVyZWQgYW5kIGFybWVkPw0KPiA+DQo+ID4gT25s
eSBleGNlcHRpb24gSSBzZWU6IElmIHlvdSBwcm9jZXNzIHRoZSBTUSBpbiBwb3N0X3NlbmQoKSB1
c2VyIGNvbnRleHQNCj4gPiBhbmQgYSBmYWlsdXJlIHJlc3VsdHMgaW4gaW1tZWRpYXRlIENRRSBj
cmVhdGlvbiwgZGlyZWN0IENRIGhhbmRsZXINCj4gY2FsbGluZw0KPiA+IGlzIG5vdCBhbGxvd2Vk
IC0gc2VlIERvY3VtZW50YXRpb24vaW5maW5pYmFuZC9jb3JlX2xvY2tpbmcucnN0DQo+ID4gTm90
IHN1cmUgdGhvdWdoLCBpZiByeGUgYWxsb3dzIGZvciBkaXJlY3QgU1EgcHJvY2Vzc2luZyBvdXQg
b2YgdXNlcg0KPiA+IGNvbnRleHQuDQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4gQmVybmFyZC4NCj4g
DQo+IEFuZCB5b3UgZGlkLiBJIGFtIG5vdCBzdXJlIHdoeSB0aGUgbWx4NSBkcml2ZXIgZGVmZXJz
IHRoZSBjb21wbGV0aW9uDQo+IGhhbmRsZXIgY2FsbA0KPiB0byBhIHRhc2tsZXQuIEkgY291bGQg
YmUgdGhhdCBpdCBnZXRzIGNhbGxlZCBpbiBhIGhhcmQgaW50ZXJydXB0IGFuZA0KPiBjb21wbGV0
aW9uDQo+IGhhbmRsaW5nIGlzIGRlZmVycmVkIHRvIGEgc29mdCBpbnRlcnJ1cHQgY29udGV4dC4g
QnV0IGZvciByeGUgdGhlDQo+IGNvbXBsZXRpb24NCj4gaXMgYWx3YXlzIGFscmVhZHkgaW4gYSBz
b2Z0IGludGVycnVwdCBjb250ZXh0IG9yIGEgcHJvY2VzcyBjb250ZXh0Lg0KPiANCnJpZ2h0LCBn
byBmb3IgaXQgOykNCg0KDQo+IEJvYg0KPiANCj4gPg0KPiA+PiBJZiB3ZSBjYW4gZWxpbWluYXRl
IHRoaXMgdGhlcmUgd29uJ3QgYmUgYW55bW9yZSB0YXNrbGV0cyBpbiB0aGUgcnhlDQo+IGRyaXZl
ci4NCj4gPj4NCj4gPj4gRG9lcyBhbnlvbmUga25vdyB3aHkgdGhlIHRhc2tsZXQgd2FzIHB1dCBp
biBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4NCj4gPj4gQm9i
DQoNCg==

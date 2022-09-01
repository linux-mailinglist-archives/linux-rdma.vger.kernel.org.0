Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24825A8E99
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiIAGrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 02:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiIAGrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 02:47:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8BD1208F8
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 23:47:47 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28165wu6021612;
        Thu, 1 Sep 2022 06:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=sq+9cWCw/ThcMr6Xq1fNgsXAFY770KpNjhw5BpbI23M=;
 b=tdw/1yJqn4ut5gO/QYzh+yvaaglv/9mpzQJ3FemU0O9H6fPIw5YQonHVztpwZN//xt+m
 VLt3fPLZg1A1ynJ6k/pWgSWoNTByPe3sfuOVYwqB9/SXNDkqOjt1+UUlAglb4AIsRx6s
 8newJdsjslwhzRdgAateljwDDg8XM4kSO5wJMoc1Br0QLtOzCr8Yp7iGXP5huyaPrQUP
 7gmj5hwPVz+BZJnznp+uEGQHtN6Xeoo6HIQhaHX8zlSkVyGJ+6Fe9ZZuyIteKvsPxSw2
 foA7tdF1BLZ822/T+uNAVlDb9l9ajuM+T7FsYc09dLLhgaXx2AXMtquxXFqiwjyoTnyS CQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaq5x1c0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 06:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOYjoK+RuGzKpn7vnfRO6PWgrFjBtkBbQDfyw6reP9CdPR7s08V/ZWY/hLvDHEyOEnAxxF4DwpSZMwRUBcaFX+7ePpKJ56cUO83pVQM4yjDiNQmkna0dBnoJhDvgxBsrGMOEFP1V+2uCMd4IIj5gW7pHf5NA3bSlnKeZ/5C3VfcQ+RW69nFz6mLgIjFlxYXlQgvKStEBsXYLvHsyCuWb8uxv3Rwzal5GL7DweDbbB+y7TxpswPLIPKR6TAK64EwfPnk2uUA9RhFvU8Ec1NSo3jesJC3JW3MIQ4Bhh65xwovznjTW444FtKIbDO2cIJ822yZJ3zfTGWov6f/GKDGafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sq+9cWCw/ThcMr6Xq1fNgsXAFY770KpNjhw5BpbI23M=;
 b=mifKEs7QytRC+QjOdAmFyhQEerZSRxFsO51MY7SoHUmoE8MeKu2p+zQgeF9t0oGqDCorvR73VBDJcprbY+YGQOjFyahwlnRgpkcCggGqaJX3Remgdd6dfwlzbMZ95dU3q9MEWrbGMep9UQ5BryoqkTaqvlu5zjcxNdmljNLyMMJMtcKIBx1f9BF/2iBRbPi1rd72e52Q5BmwseOWCtFwLTll3Wmgw2XjxC5Ss9ONU2KIz40iPD3WwXk8fs/cmznVyjyXclqMhUPnQuk6b+m08oeDy+2phzzQTTClFrKUNJyAGwzZ/BLUSs+KGlModHxelvdWludtWw1i+51+PUuQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CY4PR15MB1542.namprd15.prod.outlook.com (2603:10b6:903:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 06:47:40 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 06:47:40 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: Add missing Kconfig selections
Thread-Index: AQHYvVcRU317wqI2dUyXE8SEwVSAfK3KIFrA
Date:   Thu, 1 Sep 2022 06:47:39 +0000
Message-ID: <SA0PR15MB3919233B6357424C610D292A997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
In-Reply-To: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b95bf2a-3b7c-402d-764d-08da8be5dd23
x-ms-traffictypediagnostic: CY4PR15MB1542:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsyL2XSuHCx1be9ul00H6VMwek+89IIin+expFb0eDmQofzPpzSgQuNspGU8apvIbnHztk3X7eV/ESme6ZdQm1QgOYyuHPS6N2jp79vJEPtRkkR/E4Z0TeHOAOCX79xy+b22tEn/QdfWqreTo8ioMVstqyTUoVOMga/dOnnsyGkpcBAw8PclMtF0ceS5x8ZeUb1UqWdc3C/RVsPmk9PUdcMYLGJe7rFarixxjlJ8GOyvaPFUxr7OCGTW35ZFx4dOh8NqYaN5o8F6ZWQi1CerJYJ07gp68HPhKYxfssU7Os+m8EQOqqTnnDws2qwA3KvhQX/Ti+1XJl5gX6PEs5bKcC2PBH+eXt8Eoqrk7LugfmAXLUOeb0n2zd7sbvLHBd12S808cpfrqQF1I00++BtfsDhzk1XJyG3bXA07Ezb5miYPlNDIL4zftD42yocuWyuHPdA4rHEnRoUTtHnLjGvQi3woCSY/2h235N5GUGqjHRH0rRDjzILIBEbF7C4bj4sBux1cnJpOk1c0wKL3dV/i3767y0ct3cCtF3HqWVa86HrakWjPx7m8u3UdFmLQjyGwK+eh4R2AIpKyCrz+qPlcJNHQEr0MBpzt17sxIkrKbVld97vKwmBS+4Yonsq48hGYahiVzTBohnLiXyqCGXxm72zGpZ3LSHdLJdzhxEia588yaw2d0udhPUJ5xg6luAnfYHbmcNggpkO2T+SKmY6/9QCqXNjI5O6Ra4fMVCs8Tr8c5PPZMr9xlabBdwcsOltw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(39860400002)(346002)(6506007)(7696005)(53546011)(33656002)(64756008)(66946007)(8676002)(55016003)(110136005)(66476007)(76116006)(66556008)(66446008)(2906002)(41300700001)(71200400001)(316002)(478600001)(186003)(9686003)(83380400001)(38070700005)(8936002)(52536014)(5660300002)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1JRbjczWTR5SjlQam0vZk1MZGNKbkk2aDRCUzR1NUc5Q251OU5zWlpTVndu?=
 =?utf-8?B?bW10QzVJOUw4c05sVHQ0enJuQU5GQkJraTFyRGNEUDdNMTZxS1U0K1VXOVE2?=
 =?utf-8?B?ZE9JRlRLajM4MjVKNWRSNjR2RUxWYU1XTUxIY0U3dFVpbVN3citPZVNicTQ1?=
 =?utf-8?B?c09KSVZJeGZjUVNhaWdTYUNQSEpiblZ3MEk3c3ZrNDQvT3JKN2g4eVA3M3JT?=
 =?utf-8?B?WGs4YTlVd3pzSlZpYlVaWkVkV3FCK3NocXZIaFMvRUM3Qk92ZTBKTGt5VTNW?=
 =?utf-8?B?ZTl3TjY5RWZ3Vzc1QUpsRU8wTzY1MTZ0dUExVTBlQ0Z0bmJ1SUVvelI0cS9l?=
 =?utf-8?B?VUNrN3luN0lHZm1VZjFRbVZlZFU0d2h5TXlhVkFEaitzTDRtUmNTNkk3YXJN?=
 =?utf-8?B?anhTQUJUeisvaCtyME1PMDVkSjZuVVlyemwzNEI5QmZFMDQ4eFZVdE1GZjNn?=
 =?utf-8?B?eTRBSkRnWWlIMjVYa21GSk5jWS95c25UNG5sMGRxc1B4M1dVU2FlcVpCdHp4?=
 =?utf-8?B?Y3BGc1JGWW9kTHppNTQ3THROWnNIdmlKRzdjTVZMTWFWaUdKYW42OXZuOEV1?=
 =?utf-8?B?djNtd1VrZjhMejRWVkpIODBqMDhWSmQvZkdMRU1Ca3VuSVNGY2dJMzlnOWhW?=
 =?utf-8?B?ek1OcHRxOFhiMy9Mdjc1NlRLM2xQWXJsR2h3b2V2NUpYaXpFYktwM3NReGxM?=
 =?utf-8?B?UzJzejZRbmNhUTBmYjNNcURlVkNLb2EzUkhBR3cyQ1hnelowamtlQ09ibnA2?=
 =?utf-8?B?NWJhTDFTSlVjSCtST0dCSG5ITGVWdnpLU2RWUkt1dHdQV0ZZcW54Ykt1bTRC?=
 =?utf-8?B?VTR3TTY3VXdub1d5NWhiZHNWTDlwdUtyMFRoT0ZBRm5IVHl2V3lhbk5HNGd4?=
 =?utf-8?B?YUZVVEJERVAzZGMyekdjY2lnYjJ5cndYc0M1SnF4Z0NaeFI5bkRueVVlSkRs?=
 =?utf-8?B?K3FqODBYd1NkTXB3NlFJN0lGSk1COVZBbUFCNDZEZDd3OStXYUEwVk43VUVu?=
 =?utf-8?B?VGZFU0prOEpQMjZxMGo2R1VFcmlqMEVDcHdwakFoUUxBbzFDWFIyLzMxY0Jz?=
 =?utf-8?B?M1pVeTB2N3p1dmoxMjRwbjQ3TGJTRDhUYVRQa2NvL05mU3N3U2tWY0NHY1VJ?=
 =?utf-8?B?YlVRK3lzQjVJRjMxdUhSaUxnT3doMi9nZmlQazlyV0J0M2kyZmgyL1RPTFY4?=
 =?utf-8?B?eVlRWHMwN09kVFFsa2k4RjVnZlJVd2ZyTzVqcm1GSmVLcGlBaDdndUtuRHdG?=
 =?utf-8?B?Mkl3dUtUdlhXVytWemFNK1I3NXo2T0xDKzRkRDJ5SDk1YzE3VnpXc1dZZ2tE?=
 =?utf-8?B?US9TZVJCL2FsZnJrdkVtUWZxOWgxYkV3WFhBblV0UXliaFpmbU5VeGlJS2Zr?=
 =?utf-8?B?dGszUU1ldXVQYUNnS1pXREJQVXJ6WUo1aTM4NVpzOVZJZE1JR2FUcnM4MG92?=
 =?utf-8?B?WXlVSGlUWDYzWkNacHppbkFkalZodWIxUyt3U1JKT2RGbXZQUkg4VGw2dW51?=
 =?utf-8?B?WnRzWGZsaVZqWW9DMHdFdlpBWjBDN0gwVUNGbHJKNkdHbm9GcnVjUEtTNnQx?=
 =?utf-8?B?SnB4V29nNnVYZGdUa3AwYUJXL3ZKYTJiOUROTkRDSWdwQTlqTm1hd2xGNERq?=
 =?utf-8?B?S2x4bDAxc2JOVDVkT2w4ZEhjR2UrN08zVWJYbFJEaHBMcGsxYnhwS3RnYlgv?=
 =?utf-8?B?YkVEaFRQZVdYU0JlbDRuQmx3V2g5VzNkTC9pQmlQMW5TRHNHcmc1TEpwTzJW?=
 =?utf-8?B?M3pLVTZtbGo2dlFFcEJsZGZFbUVkSkdnWGJPM1BaM25iaVF4alBEc3ZlaHNa?=
 =?utf-8?B?MHpGMng1aEtUcDVlVmQ3OUlFWTNnSDB3dS84SnBIdCtISm83dW9xRm9XUlVT?=
 =?utf-8?B?MU8rbGpvaXNGTDcwOWY1eXdqekxublFaOFpSRlZlc0c1L3l5TFJkMkgwa2dw?=
 =?utf-8?B?L1UwNThqN05PQUdRK0NremYxZWxrWFh4cWtXdzNKa2xadDJldjZyeUhtcDJy?=
 =?utf-8?B?R1ZsVUpMY3AwMU1saHZUSFdZSWJHcGRQRitSL0pFenZMZ0VlUkVmbm1lR2RH?=
 =?utf-8?B?MlBKTldzRmI0S1QvVExEZytzR244ZnYxN3Z1a09FM01IY1NBYXhVNFFvN3Vq?=
 =?utf-8?B?T3IrQytoMXVWL1JJWnBiYXprZUQ2K1RZaVlvcG5SclpQNy9USDhCM3QxQ2Vj?=
 =?utf-8?Q?tD5ajMilOQ0sVIClFiKySkCqbKB/np3bg+tWCvMmWtN8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b95bf2a-3b7c-402d-764d-08da8be5dd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 06:47:39.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyBwkQHFNm50gm76Kos68nxzOyt2J541wXZ5MRKOR7iTUEzxXyfq86f3tMb38GNFIqxCkmuQ3fGlp7cdK2GtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1542
X-Proofpoint-ORIG-GUID: rnjlxYvfdO5p_GkGdrTg085pUa3L0yxE
X-Proofpoint-GUID: rnjlxYvfdO5p_GkGdrTg085pUa3L0yxE
Subject: RE:  [PATCH] RDMA/siw: Add missing Kconfig selections
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFRhbHBleSA8dG9t
QHRhbHBleS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMzEgQXVndXN0IDIwMjIgMTg6MzENCj4g
VG86IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBMZW9uIFJvbWFub3Zza3kgPGxl
b25yb0BudmlkaWEuY29tPjsNCj4gbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IEJlcm5hcmQg
TWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRD
SF0gUkRNQS9zaXc6IEFkZCBtaXNzaW5nIEtjb25maWcgc2VsZWN0aW9ucw0KPiANCj4gVGhlIFNv
ZnRpV0FSUCBLY29uZmlnIGlzIG1pc3NpbmcgInNlbGVjdCIgZm9yIENSWVBUTyBhbmQgQ1JZUFRP
X0NSQzMyQy4NCj4gDQo+IEluIGFkZGl0aW9uLCBpdCBpbXByb3Blcmx5ICJkZXBlbmRzIG9uIiBM
SUJDUkMzMkMsIHRoaXMgc2hvdWxkIGJlIGENCj4gInNlbGVjdCIsIHNpbWlsYXIgdG8gbmV0L3Nj
dHAgYW5kIG90aGVycy4gQXMgYSBkZXBlbmRlbmN5LCBTSVcgZmFpbHMNCj4gdG8gYXBwZWFyIGlu
IGdlbmVyaWMgY29uZmlndXJhdGlvbnMuDQo+IA0KDQpNYW55IHRoYW5rcyBmb3IgdGFraW5nIGNh
cmUsIFRvbS4gSW5kZWVkLCBzaXcgY3VycmVudGx5DQpvbmx5ICdhY2NpZGVudGFsbHknIGJlbmVm
aXRzIGZyb20gaGF2aW5nIHRoZSB0d28gQ1JZUFRPDQpkZXBlbmRlbmNpZXMgc2VsZWN0ZWQgYnkg
b3RoZXIgY29kZS4NCkFuZCAnZGVwZW5kcycgd2FzIG5vdCBjb3JyZWN0IGVpdGhlciwgc2luY2Ug
aXQgbGltaXRzDQpzaXcgdmlzaWJpbGl0eSBpbiBrZXJuZWwgY29uZmlndXJhdGlvbnMuDQoNCg0K
VGhhbmsgeW91IQ0KDQoNCkFja2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJt
LmNvbT4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L0tjb25maWcgfCA1ICsrKystDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvS2NvbmZpZw0KPiBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvS2NvbmZpZw0KPiBpbmRleCAxYjUxMDVjYmFiYWUuLjgxYjcw
YTNlZWI4NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9LY29uZmln
DQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvS2NvbmZpZw0KPiBAQCAtMSw3ICsx
LDEwIEBADQo+ICAgY29uZmlnIFJETUFfU0lXDQo+ICAgICAgICAgIHRyaXN0YXRlICJTb2Z0d2Fy
ZSBSRE1BIG92ZXIgVENQL0lQIChpV0FSUCkgZHJpdmVyIg0KPiAtICAgICAgIGRlcGVuZHMgb24g
SU5FVCAmJiBJTkZJTklCQU5EICYmIExJQkNSQzMyQw0KPiArICAgICAgIGRlcGVuZHMgb24gSU5F
VCAmJiBJTkZJTklCQU5EDQo+ICAgICAgICAgIGRlcGVuZHMgb24gSU5GSU5JQkFORF9WSVJUX0RN
QQ0KPiArICAgICAgIHNlbGVjdCBMSUJDUkMzMkMNCj4gKyAgICAgICBzZWxlY3QgQ1JZUFRPDQo+
ICsgICAgICAgc2VsZWN0IENSWVBUT19DUkMzMkMNCj4gICAgICAgICAgaGVscA0KPiAgICAgICAg
ICBUaGlzIGRyaXZlciBpbXBsZW1lbnRzIHRoZSBpV0FSUCBSRE1BIHRyYW5zcG9ydCBvdmVyDQo+
ICAgICAgICAgIHRoZSBMaW51eCBUQ1AvSVAgbmV0d29yayBzdGFjay4gSXQgZW5hYmxlcyBhIHN5
c3RlbSB3aXRoIGENCg==

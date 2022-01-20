Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD9495044
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350059AbiATOeL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 09:34:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34178 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351202AbiATOeK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 09:34:10 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KEAVck033249;
        Thu, 20 Jan 2022 14:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8c7uzrrtsps3d3fyMq53kud6ZE4TFJhbtNhTA2n5GKk=;
 b=noXoW8Cuoh6ndGbsyzmB+ZLRw3ojr6EL9hUQlp1X+3lANstrzvxWj3Pu86faY6TIR4Io
 ADmZIaC0cuEVDXAm8WAdCz81vTltN1cCOfXCYMg6RWg7DR2KtxgiS8CvOdMLfKP3zblm
 CIfYKhgqinUVv5z9emrR8Vowt+EQg22j5PqzPQVmP+qH13eMh8gajYfSdl5iad7FPugS
 aD6I1mMLnuZxWX1neOL2Tk8c0LRYwquGpsFxtm/L2QGteOsOZ0nzRh0wYSpVNfU1O2UG
 +Ec7fidaa8CwL4vQiGufdbeAjSpg1CHiQM1gO9KEV4ttxEjvfw98sBsu/hW59ldurtOx mA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq6f34asa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 14:34:07 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KEW2as024458;
        Thu, 20 Jan 2022 14:34:06 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3dknwc0x0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 14:34:06 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KEY5fX7013112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 14:34:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E151136059;
        Thu, 20 Jan 2022 14:34:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1A2136051;
        Thu, 20 Jan 2022 14:34:04 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.244.199])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Jan 2022 14:34:04 +0000 (GMT)
Received: from m01ex006.gmx.ibm.com (10.183.153.187) by m01ex006.gmx.ibm.com
 (10.183.153.187) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 20 Jan
 2022 09:34:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (9.221.46.12) by
 m01ex006.gmx.ibm.com (10.183.153.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 20 Jan 2022 09:34:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDUQy8p/ohJaHM2UX4501Of6u0z4g1p0uNms/QwJlsn5kfXmblKpz7hFRz2XGZ2P6yC1b89M5Ngr29CtoFJP8d5xAiH5/xsst0zUnaVezA9FUwoN+kiSEBcgPGMAjNS+n8UzTCAxZUEBOD4hMV15qEKDjYpHINkijsQJruEOLyECzPukftHkvE4fcDE+PyfYekdiN0r1EMGyyCW3d784YY/M8c/UYmbxToqDcK2IFq5EPVnR9z1LQwSBIaGdVpjMuZ31ZeUM3RQLdpydt5m5o69U23sCsYGIS6sGqJdIWiEh8W0Stx7FHLJB0BdQDc29ImHYVGJXc0sMddDsz5igQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c7uzrrtsps3d3fyMq53kud6ZE4TFJhbtNhTA2n5GKk=;
 b=HuptR+o4rqSyJestNqBTpZPws2UhFtIEPY0OUX1DOOo+ERkV8ILdWZbhJZe5rzRoVYioIH8CB31U1y6IGl/xD2EKAFllKhq56LhQRkORMyit/Bs91hOz6444gUa+h45Gw21me7spe3olhMPj6/lzRFzaVl07TlnbaTUbivFZNOO7h3sW81qLTED4s9LuSFLzZ0MDyR1+LMEW6xAG2GoKYflBF0COAfSVqbYkOWMGwJO3bvI/arkYGru9j2fgdle53xVoZg9DGldwSAy21U06UNzGXEbmYeTJaxQ82vmoDKub5iInf7tlN+KVGdOt8d5hQKGraLrHCvzR1Q+v66pegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 14:34:01 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::31b8:a1ab:2121:fba3%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 14:34:01 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "jared.holzman@excelero.com" <jared.holzman@excelero.com>
Subject: RE: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Thread-Topic: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Thread-Index: AQHYDgc+odZkvXxP3UGmXHrbuGFLbaxr+Oww
Date:   Thu, 20 Jan 2022 14:34:01 +0000
Message-ID: <BYAPR15MB26313297295E97604A1C1822995A9@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <20220120140812.2280-1-bmt@zurich.ibm.com>
In-Reply-To: <20220120140812.2280-1-bmt@zurich.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9007e3-2d1d-479a-8ab8-08d9dc21e6fc
x-ms-traffictypediagnostic: BYAPR15MB3285:EE_
x-microsoft-antispam-prvs: <BYAPR15MB32858581A60BDC99448A2D5B995A9@BYAPR15MB3285.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8O7xJzvdg8ymCecC8/NzzQpNayt+4LjYkMfKO14hLvvqT6Tp62X/SDQHpW+iEYoNSXh65DE7yzeIDxEL0D72tAH8MOSAxwcowt3QWkSNQoIO5KhA8xmQuWQ5PZ8/BkVw0XUHNyjT8RwAYPRGS3tHP4xCasKPdv+E7Q6Im3QUnOBYFSdO1Wcwxr1FVQBkHI3lqOlbHYF42/YR8VEZglGqBUUJJk5DzL8lGhFck4F20p/dWytSR1dkf/oiLt+HdQMCNOXqZdNP1PDlJSDf25+VNLFIYl3aQI+gWiTRqj3tl6cElV/EsUbTWEl5N/PagoOKMPT2c9C43sI3S7v21yynpIeKOMtjtRwm9axsr76ggtiagKgOgoFjOg6FimKsb0MVbUt0PsciQECwLbmwdUKGtEXUk5upi77ZFg/qZU/HM6VibpwTW5EbdJlIhqjK8LlAK64s8k77M/KyiNL0cEqcVj8wEo/QXGMTfO4h5BggI1AGtW8z2akABRhVlPSxZL4lkAwDAnGNNFe1P1WUqDrqWPYOGyJJUSnT/tQrgzkDLmhZSn/pZViApfzZL6MnH5fqZI1H+CBaK+SHXMWX+v1LwriIb3FvaOEZrdZohnUtuZb0PpyVYb7NyHfb2I/0aVIbujELIOWPaIUAPt6IRpPAngJLeWN9dBkNrRH/YLnnrCsFJ5F8GBJqGChWt0LYuPnzC2JolmVrCWskbtaXO4/2Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(508600001)(55016003)(38070700005)(33656002)(558084003)(2906002)(9686003)(316002)(186003)(6506007)(86362001)(8936002)(8676002)(110136005)(54906003)(71200400001)(66946007)(66476007)(66556008)(4326008)(76116006)(66446008)(5660300002)(38100700002)(122000001)(52536014)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlVvMkxhUnU4b0hTWjgyWTNFYk1kbTVrQ3NaWk9LdjBKeEtPOEtlaHAvRGt4?=
 =?utf-8?B?Vjl6UHg0cXNJVFhWdnRCajhnWjlBY2JXekR6aVdzNXArQUpZZjM5Q3NaUWgz?=
 =?utf-8?B?TFBMWTNQb09ZY3cvaVJXelVkMXRkTXlUOUZlamVqemRPckpTNUdUa2Fzb1Fv?=
 =?utf-8?B?WjRoaTFwM0N4UkhIUjVvRTl4cXZHeUdrUFFpUXllTzB5Q3Y4dGgzQ3Vrb2V4?=
 =?utf-8?B?MTI5N1dUK3NucVBuem41VTlnSmw5VTh3THBuelh5OFRQNSt4b05FMGtaRTQy?=
 =?utf-8?B?WVUwUExHLzVGRVE0WjdIeWVaaktZSjBmS3pGOUpWWVRKcnpsYUJyU1ZGYUpF?=
 =?utf-8?B?WGZDWlVFNzRHbVRvODRpZGkwbWhiTkVCNW1ybzhvUVZad0E4NFQ2OEk5bnI0?=
 =?utf-8?B?S3diZ1lTRDFHd0taZFdIU3RqWW4vR1J0aWduME1vd0M1Z1pYQ21lRzYraUhz?=
 =?utf-8?B?cUFTWTVoazQ3MGhUL2FFZDFwRmQ2eHlwT0dCQ0F3OWpMTFB4TmpBM3BLMk1o?=
 =?utf-8?B?T0VRV3VhQnd3VEhOTWRVMHdXalVHakk4SDhxS1FCclNzeXBaenljeWhINlpZ?=
 =?utf-8?B?NVJKakQxOXloN3M0M0VUY1dqOTkwcDVQQVJtaCtUZkdXaFoxMVp4cG1MS0Jv?=
 =?utf-8?B?cDJhVG1JL2JSbTc5bFFGWCtQaVdWRFVFTFhHNzNWSmlEakdDT1BWUVU0a0ly?=
 =?utf-8?B?UHhqcFpxUlBxVVBFbWhwWTMyRlRKMm5oTkM3QkVaTzNDaFlkcHE0U1ZjVXRX?=
 =?utf-8?B?NXNrQVBJdGNoK08zSkp4dmpncHFQV3Q2TjRsdklWS1JNMHB0TEtNN05hZSs3?=
 =?utf-8?B?dEJwNERIOFR5dVVhcE1XbHRCZE5ocXQ1RmZ2Ymx1OHZkZWpFclNWL2h6UVFG?=
 =?utf-8?B?aVJtSnR0QURNUnZrWnNkanF3dEFSa2liOUp5bjZGWStMSHlpd3RPbmpSbUNa?=
 =?utf-8?B?T0F4Q1FCekRraGZYWjVZRHpNbFRLY1lBR2dmNktzNmdLemIxV0c4V1NHTDVI?=
 =?utf-8?B?WnNqMVcrSTFDYUpvWFU1YTRPZUllNllyTzVtRlIzUlpWU0RIYitRWkdMYXU5?=
 =?utf-8?B?b1FpZktXbWtYRGZVM3pGSVQ1M2RzeG82THJmYXZvMzQ2QkxIWlVvQmJrMkVG?=
 =?utf-8?B?NkQwbjZjOUg4cHg4M2tVMlRoTjNJN3ZucWRNbmFycC9RcG9VT295SWZhVnZr?=
 =?utf-8?B?amhwUmsrTWdqVHYyTEc1Tm1TbHo4YUYwYm5wL0k3aXdmUFpSLzQ3SzFpL21R?=
 =?utf-8?B?NDN0NVd6S252SFZXdG5jVFhtQjRVSUM0TW9qbWNRSnpIQXBGWWtQL3d5SXZp?=
 =?utf-8?B?L2g2VFh3K2Z6Z2tBaGNxQUEraTEvL3RUTGdYalBMaVA2b0RsQXhMbWlHY3Zj?=
 =?utf-8?B?bFpWZnIra09SNnlsR0xnK1ducTR5SDlUaWlYU1E1OEFjWGM4b2xoZi9GR01V?=
 =?utf-8?B?MUVodHVsN21neXJOQkozbHJDSnpCandTVmUrWWhWaHlncnA0WlFsQ01VOEQw?=
 =?utf-8?B?aTU5cFpxWWtkNDNrbnFhd2tjaWJqTjloVE1VTTFON080Qm8xb1FxZjdRL1R5?=
 =?utf-8?B?d1JLeUo3MGYzQzJrREVLK0JGbndoT3RFUGtPbktSWlQ5STVPbXdFSXFWTWEx?=
 =?utf-8?B?V0czZ21MNnplL3NNd2p6WjBOeW5paWMxVEhzWkxtMXJuczZwNlNiSDArL2U2?=
 =?utf-8?B?MjN2MEpYTHpTcHhHRW5pTXRMR2txdGFOdnM1Z1QxRkFCb0N5NWYyNFpSS3Vm?=
 =?utf-8?B?SVJ6UFNWaTVEdWVrYUZDWVVjR28wUmhTbjBObTY4dG1Ba0twR08xT1lPa2Za?=
 =?utf-8?B?VXpVZ1RGbWtMSmJpa1N4eEFnTEdWVHJmTzVjQnpTS3p4amVpbFJiZjBBTW9I?=
 =?utf-8?B?OHZwNFVKWW04T3B2WVE2T0dQL2FudGU4YXpwMG1nRUlEbUdUWko5ZURFQVNh?=
 =?utf-8?B?MHJQMlh5dGdtYS9tc3Q0ZEVCVE9Nc0wyRVkvSGxvU0tBdXFLVThMd0x6Z1VD?=
 =?utf-8?B?WTU2SkhmWnplMDRzc1NhNU9ySS8rRzByQ2tKOEM4aUpqMzBaSW5vMll3RWps?=
 =?utf-8?B?bFl1ZGNLeEMzTVcvc2lORjFZOHQ2Njk4SzZPb3VlQ3plc1BQQ2JSdFZOQ0dz?=
 =?utf-8?B?MEU1N1BRZmQ1YWxSU2JjQkdjQit1OElyVEN5Nk9lZ0ZtZW5aeFViRTIwZTRY?=
 =?utf-8?B?RFFObWZPYVF5S1VEVk5mOWRzTXg0MTZVcTh5MUE0eUVuRHBwM2tLQnJUN285?=
 =?utf-8?Q?ne+oBIXdileGLUEGXa1v1dNzoGdS2pFjNBFEGtR0ME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9007e3-2d1d-479a-8ab8-08d9dc21e6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 14:34:01.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcHcHiLCS1GQV+nzqdiCyV9f00o3cAmEH/oTV2jlgiZ0L/U+2K0mC8lNQTcKq2jC3VPv0s47a6h6h5qKe8gSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hVVxXIrZzuwt7ccpwlv6b9wqqPrJQPjg
X-Proofpoint-GUID: hVVxXIrZzuwt7ccpwlv6b9wqqPrJQPjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_04,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=956 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGUgcGF0Y2ggSSBqdXN0IHNlbnQsIGl0IGNvbnRhaW5zIGEgc3RyYXkg
Jy8nIA0Kd2l0aGluIGNvbW1lbnRzLiBJJ2xsIHJlc2VuZCB3aXRoIGZpeGVkIGxpbmUuIFNvcnJ5
IGZvciB0aGUgbm9pc2UuDQoNCkJlcm5hcmQuDQo=

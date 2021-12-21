Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17AF47C2AE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 16:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhLUPUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 10:20:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239157AbhLUPUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 10:20:41 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLE4j1l022922;
        Tue, 21 Dec 2021 15:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=NUQqtnyKejo9rt1mVvtXausO4kaRjS8sdm5aQSP8Jok=;
 b=cPRzv9OPSpUwc2Dc0q2L3lgpM5X5+DBXVdPRokxBDMJMURRvTEMkRkhLyyNLXIkbSABY
 w+BPBWwRkX+PRyWvC8FH1hgJ1/Jwr+niU414MyI3C1+nTgYeiIQ2u0PzN0Y51SADrsG6
 C9e4NIXR1jLPSYZw5F0EqUWNw+xC0vmcvLmPEBRJo+aqxzMtkSlDs6qQIHO0prqT2DSm
 5WW/qCXVXaoD+u66LZ3ExDmUfwLPIQ2nXDxwk4D62+ejBcml3cckT9MSYOCjxL8ndtbq
 cmEf63OjALIUmmJrTCu7fdjlXeMZy701o78OqvZdO7F5+/Pb4NYfahpegaKxoIPM0F5k Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3asvrqpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:20:32 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLDxO62021615;
        Tue, 21 Dec 2021 15:20:31 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3asvrqpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:20:31 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLFGf3v017792;
        Tue, 21 Dec 2021 15:20:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3d179abpp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:20:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLFKTwd30933318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 15:20:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91C92112070;
        Tue, 21 Dec 2021 15:20:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61C8B112062;
        Tue, 21 Dec 2021 15:20:29 +0000 (GMT)
Received: from mail.gmx.ibm.com (unknown [9.209.252.214])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Dec 2021 15:20:29 +0000 (GMT)
Received: from m01ex005-1.gmx.ibm.com (10.65.236.121) by m01ex009.gmx.ibm.com
 (10.65.151.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:20:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (9.221.46.12) by
 m01ex005-1.gmx.ibm.com (10.65.236.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 21 Dec 2021 10:20:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbd6bsOer/jhnw3R5lNmB7qADBXcM5Ebz/iNCUJh/NjrOG+hLTvYQu6RyKk0P9kmv/kwGePLuHkySGh1vGvJlrqA6WAtTFKyIoCsPDmgOAAS9UXSZAsIQPyq8ISAMmEOGBeePvECvPQEa+1CPZkKtmS2nb8mBkKZgkmdW1NVn8YFRzH3jrEcJliS7PzXZfac0Rxw0u+OtmlrSXE8Ytz81lBF7ObK6LdsVprDpZlMoZStkvveQWI16+a5Rw4txxEW4oyHut2JN1+PymyCn4pEDR/a9iNA+3UHnldY5+zcc4GKa/aC/ExWZ6X/R7shWxC1qvpdPTeuh8HfnJFg+Ekgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUQqtnyKejo9rt1mVvtXausO4kaRjS8sdm5aQSP8Jok=;
 b=J1urUX6Nk/43OiXftxZ1IZzwbxp8P2Il7j7Xv3GrQquA7189d1hmWIjNhq/aNcfm6zu5/5l0tbN1z+iHt/2RYhSayO4eF9mGn7bEnWKHLU74F5eQnAichuwpmKOtYgR+UuVVfbTbOyoaK1gWJ7eRlPdSAWRqoW7W8IKup0AKWYMCV0ml317a5EipPfQiVPZu/ALsXh1q9lF//hUVl04z5cS8eZWhyAgX2PoegE+vGyauO81zDBkyzv32jKVIzOoZZiwZiItkHbZNmVe9hMEh6zV1WblU7ML2rnRGr+lX/Vp7rWKqUHLXps3e8aK94Wn61zDhgeYAwdapPzBvB+i3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by SJ0PR15MB4156.namprd15.prod.outlook.com (2603:10b6:a03:2e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 15:20:26 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::299f:1ddd:dec0:db9]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::299f:1ddd:dec0:db9%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:20:26 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs
 implementation
Thread-Index: AQHX9m84pwBFvFOk7EOQ2iwr7NGAKKw9DSOw
Date:   Tue, 21 Dec 2021 15:20:26 +0000
Message-ID: <BYAPR15MB2631D125013B5C4E06C87167997C9@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-8-chengyou@linux.alibaba.com> <YcHXWCJyhIYldpfr@unreal>
In-Reply-To: <YcHXWCJyhIYldpfr@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61415dd-c32f-4bf4-089a-08d9c4956a61
x-ms-traffictypediagnostic: SJ0PR15MB4156:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4156D30954495AE1611882C3997C9@SJ0PR15MB4156.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggS3OqCeZladCv+AnaFoZ4XipeyPzSBzP0WFGmbLKZRCedazDKjNbWXADLQaGqkHn4TNvNHwj2faVGlBvC9+qDtHFyqdkFMVqSo9L7hJ98wy6+loRuQaqibi9IzL+SwHy2F9byKrclHO6aBMS5oBkl1VnEymZfBo0hEGcnI3RxNzEICFVKYDskFROBRLdXo3iBclUbqbtnOlwbp2Fh96sv66g2gK49yePd1TUkm9x3tXoVDLv8APGMR6pYgSLd/CnHvyDRAYOH3wGqeU3EcpAslCUfQ/yE9QjVVIP76v+8Z6VOxDVDBBFI8JEKEFQBwlZ4dlsKnAAdgD3lx6sJbj5Xht/nFPJhbBmE+OUam6F2fzeWSyU06GQlLWJfuh0bT6Fbd+cEdizVmH0XlJdAo++M3CIHMmmJGWU0ZuElWThNuAJBu5Npan+Chh9jSGRJfrcGRk+GLeImmWbq1DE1jNlge8bZtMrON3uY5xhVGaWCLSI//GMXjMh/WhqpZ3/LkMhfOdKL059XV7ipJmdPgAj7Ep4dl+Nr0P4zpROldBrKnetjsziBVc/ApsHCwtGAAVGIZBMIthDNkoROdSLHvGnngfQXf9bCBCF5yw2NdaOrwQtfz679mkSvs1lfgn40ZFSP5w5TIRcYRnByGnaDBpPqUSt1h28o9nLxjeLYK5+UaJs+9ECVH4yFI3mLbExv1t7pv/jQjLVp4bUhBfdgXBew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(64756008)(66446008)(71200400001)(66476007)(38100700002)(76116006)(66556008)(122000001)(6506007)(2906002)(508600001)(5660300002)(8936002)(83380400001)(4326008)(33656002)(9686003)(316002)(53546011)(110136005)(54906003)(86362001)(26005)(186003)(52536014)(7696005)(38070700005)(55016003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzJQZnBncnVMUTFMMWtqNVcrQ1NmaUxFajVPSHMrby95eXdRRzJua1RSb0R6?=
 =?utf-8?B?VFZPMVd3NE1aVENWbHAzdGxMKzd4OTZoZnZydWFhZHloRmVsajdaS1hLeWZG?=
 =?utf-8?B?eHZyL3RWc2pLd2I4c3JkWjdIb0lIRm9LK21EZlk2QVNFK2pyWCtHMWhMTFRD?=
 =?utf-8?B?cEZUMXNEYzVHVWhrY3JWdFdJbWJLeTl4VndOWlE1N3B2c0lpVzN5ZTFZQndx?=
 =?utf-8?B?SzF0ZW5ZRW44bUJQVkVTTnpib0NOTUZMdVVBeGtLUy9Lam9pbE1sVkV4ei9w?=
 =?utf-8?B?UW5GSE5oKzg1Z01rNHFNKzVtUFE1ckJTUFVxbml2TG1ubHlqOWpaWEdBalgr?=
 =?utf-8?B?N0tEK0lrd2xsdXZoVDNiSDlvbzg3Z2hvK3ZoZkxkaS9uWTFmZ2lsb0x1ODZz?=
 =?utf-8?B?OVB0V1dnVHI0bndZczhDbC9RZUtGSjU4OFVETDRtSkE5WTcyNzg0TU44OE1w?=
 =?utf-8?B?a1hzMEtGUlFybE42QVhFOHBRTlNQbEhHdmFmTVRVRDhmdm0xWFFKeWNhTmhp?=
 =?utf-8?B?VDNERjJYdm8xcFBFbzhOZTZLRi9tZmFNZ3NtdXJIR2VBdEkyZndQNHU3YjQ5?=
 =?utf-8?B?VXdVOUQ2NHRWOU10NXdqR2hKK01nREF1R1lXanpxV0ozYzBIb24vdFNyQ2VH?=
 =?utf-8?B?M2JJSWIrK2FVaFJnNnBEVitDbnJmUVdKbmN5cHlsZzJEaWdaS3dUVkFQNHp0?=
 =?utf-8?B?eVpvbk9nVnNOSCtORWtzOUdUQ01ENU0yTnlqS09vQW1UUTZWbXJFZlk2anJa?=
 =?utf-8?B?OEZjcWdxb2tzd0I3dlhEaXZFSTdEbks4Ym1YbWw0aUVXbVBRWDNHcGYrRW9V?=
 =?utf-8?B?clNwMXgxR2NBYmJtZEZ1cEwyb2NzaUNhOHVDcndTTmJKaVhpdWR1YXFzL1Ar?=
 =?utf-8?B?NGdiVFBBZ3ZTckw2K3pDUmdyRCtuT1FjOFhlOHVqalRmUmliQTczUjJ6Q1NO?=
 =?utf-8?B?MjgyUzl1RTBwVkVTSTBBaXV6bEhqaHluR0VZVDNZbFdTZHBTMUhOWWhaVXpw?=
 =?utf-8?B?RmdPNGNjelIybGhyNXcyUkE0RHlKNmRCOFJtVmRyaU5ic0l5aWEwZmpPMmFP?=
 =?utf-8?B?ME9YcWhCZXZyT0M5SHhPVmYrRkhEWU5EUVF6V1RFWnA5YVBjQVIrSHc4OE1P?=
 =?utf-8?B?SHBMMzg4eVlTQUhzQk5UYUZjbU5QVnBDTVlTZnV4TEhTM2t5L1dOdmFxUll5?=
 =?utf-8?B?RGFGNGtoWi9NRERPSThHTDNEeDBIRVRaUEZjTlA4dllaY25YaUxkUkNFYWdq?=
 =?utf-8?B?MXljeVpnRDkxY0dxMEJ4RkRUNVliMjBCS0syL2FSeFgwWW5ZOU02UFAxdEda?=
 =?utf-8?B?Um5YYkM4bUdXVDE1TWNlZGdzTXpTdnZraUdidTRCbTBDL0xSb05JY0Y3NW5V?=
 =?utf-8?B?cCs3bzlEajZUSUxhaHZIZ3NaejFBc29iaWIwTHRlbWM0andNem50alNjV3Az?=
 =?utf-8?B?TUlnOWhQeXJHSk1xeUhoYWs4ZGVibHVJclZFT0psMEJudkJEcWtoVGJaMC9u?=
 =?utf-8?B?YXU3M0pyUllVbWdNbzdDMzdSbWp0aU81blVXd2NkL0lHWWczQWRaQW0zRHdI?=
 =?utf-8?B?V3RrMjl5UFY0TzJkelRCdkZudWlMWW40U0ZWblJteS9GeVhyWW9MQzV1Tlpz?=
 =?utf-8?B?Wmp1WTRrdXE2aTRCdHNra2dxc0tBTzVjUm42Y2xKVlhwTjE4V2VMeW9lT25r?=
 =?utf-8?B?SWxFNjBsOFhMK3NFK3RRRmxXTnpzMnNRRmRETDFNbzBVWkRSTFlYbXMvUHZn?=
 =?utf-8?B?elBPSEN0ZDc5dGY0Y1Y4bXJ4Nm9qamszMTZWbUNaMi8vR2pLdWJ2U0VMVVVY?=
 =?utf-8?B?Mnp3OGViZGZrR04vZjB2bWFaV29TWlVwS2ZlR044MVVKczI5RzZMOFhDTi9w?=
 =?utf-8?B?cTJoOTVrQm9TUkhYeGVCYWNHZzJNeDg4MHBKTHEzQm5EcXlCNEVjUG5lbm5Y?=
 =?utf-8?B?bDBEMUJQUGZyWVJFallCUTdSVHlyOGp1bEhLSzEzcERQL1M3Tmp6bHJvd2po?=
 =?utf-8?B?NWtDSkM0V2tqRldQNzVnd2FGRy9zanlwRGRLczZSQzB0KzYxUjZDN0lvVkpN?=
 =?utf-8?B?V3RXdlRVc1BpRUtkVG9KeE1qZkhBK0FJckFFdFU2WHFiRVdBYU8xeHR1YVZm?=
 =?utf-8?B?U2lMU1grcXNpUlJzNFdWd1ZYUmVES2J2eDdOMHVETXBXVVZaK01sdWxlOEdr?=
 =?utf-8?Q?KdU06qsr1goHnYsmlKtbthI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61415dd-c32f-4bf4-089a-08d9c4956a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 15:20:26.1988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQwHK2FkvQVM2yVbk4kp3xceV84SGg1uWQurUduS9KLEuuMCcghqs4vZDFxXb9OreZ3O+5YSWN85rXd8LoRMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4156
X-OriginatorOrg: Zurich.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FV_K_8ugG8IbaAMRiyAGkc4QAcx8hCSY
X-Proofpoint-GUID: hsclib_DklIoffVjyMvFxYR9qfkfi19v
Subject: RE: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs implementation
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgMjEgRGVjZW1iZXIgMjAyMSAxNDozMg0K
PiBUbzogQ2hlbmcgWHUgPGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBDYzogamdnQHpp
ZXBlLmNhOyBkbGVkZm9yZEByZWRoYXQuY29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsN
Cj4gS2FpU2hlbkBsaW51eC5hbGliYWJhLmNvbTsgdG9ueWx1QGxpbnV4LmFsaWJhYmEuY29tDQo+
IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCByZG1hLW5leHQgMDcvMTFdIFJETUEvZXJk
bWE6IEFkZCB2ZXJicw0KPiBpbXBsZW1lbnRhdGlvbg0KPiANCj4gT24gVHVlLCBEZWMgMjEsIDIw
MjEgYXQgMTA6NDg6NTRBTSArMDgwMCwgQ2hlbmcgWHUgd3JvdGU6DQo+ID4gVGhlIFJETUEgdmVy
YnMgaW1wbGVtZW50YXRpb24gb2YgZXJkbWEgaXMgZGl2aWRlZCBpbnRvIHRocmVlIGZpbGVzOg0K
PiA+IGVyZG1hX3FwLmMsIGVyZG1hX2NxLmMsIGFuZCBlcmRtYV92ZXJicy5jLiBJbnRlcm5hbCB1
c2VkIGZ1bmN0aW9ucyBhbmQNCj4gPiBkYXRhcGF0aCBmdW5jdGlvbnMgb2YgUVAvQ1EgYXJlIHB1
dCBpbiBlcmRtYV9xcC5jIGFuZCBlcmRtYV9jcS5jLCB0aGUNCj4gcmVzZXQNCj4gPiBpcyBpbiBl
cmRtYV92ZXJicy5jLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbmcgWHUgPGNoZW5neW91
QGxpbnV4LmFsaWJhYmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcv
ZXJkbWEvZXJkbWFfY3EuYyAgICB8ICAyMDEgKysrDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9lcmRtYS9lcmRtYV9xcC5jICAgIHwgIDYyNCArKysrKysrKysNCj4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmMgfCAxNDc3ICsrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIzMDIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2NxLmMNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9xcC5j
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJk
bWFfdmVyYnMuYw0KPiANCj4gDQo+IFBsZWFzZSBubyBpbmxpbmUgZnVuY3Rpb25zIGluIC5jIGZp
bGVzIGFuZCBubyB2b2lkIGNhc3RpbmcgZm9yIHRoZQ0KPiByZXR1cm4gdmFsdWVzIG9mIGZ1bmN0
aW9ucy4NCj4gDQo+IDwuLi4+DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvaHcvZXJkbWEvZXJkbWFfcXAuYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9l
cmRtYV9xcC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjhjMDIyMTVjZWUwNA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfcXAuYw0KPiA+IEBAIC0wLDAgKzEsNjI0IEBADQo+ID4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIEF1
dGhvcnM6IENoZW5nIFh1IDxjaGVuZ3lvdUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPiArICogICAg
ICAgICAgS2FpIFNoZW4gPGthaXNoZW5AbGludXguYWxpYmFiYS5jb20+DQo+ID4gKyAqIENvcHly
aWdodCAoYykgMjAyMC0yMDIxLCBBbGliYWJhIEdyb3VwLg0KPiA+ICsgKg0KPiA+ICsgKiBBdXRo
b3JzOiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gPiArICogICAgICAg
ICAgRnJlZHkgTmVlc2VyIDxuZmRAenVyaWNoLmlibS5jb20+DQo+ID4gKyAqIENvcHlyaWdodCAo
YykgMjAwOC0yMDE2LCBJQk0gQ29ycG9yYXRpb24NCj4gDQo+IFdoYXQgZG9lcyBpdCBtZWFuPw0K
PiANCg0KU2lnbmlmaWNhbnQgcGFydHMgb2YgdGhlIGRyaXZlciBoYXZlIGJlZW4gdGFrZW4gZnJv
bSBzaXcgaXQgc2VlbXMuDQpQcm9iYWJseSByZWFsbHkgZnJvbSBhbiBvbGQgdmVyc2lvbiBvZiBp
dC4NCkluIHRoYXQgY2FzZSBJIHdvdWxkIGhhdmUgcmVjb21tZW5kZWQgdG8gdGFrZSB0aGUgdXBz
dHJlYW0gc2l3DQpjb2RlLCB3aGljaCBoYXMgYmVlbiBjbGVhbmVkIGZyb20gdGhvc2UgaXNzdWVz
IHdlIG5vdyBzZWUgYWdhaW4NCihpbmNsdWRpbmcgZGVidWdmcyBjb2RlLCBleHRlcm4gZGVmaW5p
dGlvbnMsIGlubGluZSBpbiAuYyBjb2RlLA0KY2FzdGluZyBpc3N1ZXMsIGV0YyBldGMuKS4gV2h5
IHN0YXJ0aW5nIGluIDIwMjAgd2l0aA0KY29kZSBmcm9tIDIwMTYsIGlmIGJldHRlciBjb2RlIGlz
IGF2YWlsYWJsZT8NCg0KQmVybmFyZC4NCg==

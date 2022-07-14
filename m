Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A0574E7A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiGNM7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiGNM7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 08:59:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251C5A2DB
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 05:59:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ECr2Zi024908;
        Thu, 14 Jul 2022 12:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=uQ+YP9OOV+dV+lN9iGMAarVrCBoxe04gnCFv7qWfa/E=;
 b=JBnytT6FOJkUt9L1wQLhpXN2FbD3+9/PVBNv0g1romrbaVoFQkL4ObMsNxqNZWJYZL7w
 Zns/QwplpZTFqC4UnT4zKJ5Yg0gTCFzbaKTOuyL9+/OaiaOYRhjgw+E9FHJsg7Xpr1Bz
 0Hgo2858Q4PdTTbhg563bZFPr/daZ6QxAByuPHLKh6ccnCpjCPw3qqdHIogWagfM191U
 ATIgdwQCp9UTq3dqqFIxDlWO/zZJAYVjDasKgJ0WYV3SJfIvg2ny4l26uQGiXfm8QGBm
 bmW3RLQ2uRCpA0VKpeOysgDGqXPjQuWqyIEZ2+roPsNYanro+SMI2IDeTi3Y5o7snzPJ Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hakhfg3q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 12:59:13 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26ECuKbl012127;
        Thu, 14 Jul 2022 12:59:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hakhfg3pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 12:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjSyljtaC7lgVIGh69L8vX+zK6M48ZYLeYFIhh0xaVngkswGp05bTR1crLIbWMxtgYaefeyXC8IEaKxXdLFMhZF9HOUZCtuSbHqka/HqdhSYp1Og23ztk/Sr+qgz6Pie0sczXWZhxQV+wUtNpmwrz81IQlQ/Wq9Me2xK0iAFUPVxaquJaf6Hx4z+dn6acbWDivA28/X19o+Dd9SeHuKaAOp+gdNNc4pAce5ghfWC3eIONOGEX2HSIBuFB4FDzwgpsEMsrFsX96Wes8UIQ84WpW0SecaytneWIQlr8WE+yFv3+8YbkRD+633WVIhI302Eq8QKaqwPuxM7OjefkAI8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ+YP9OOV+dV+lN9iGMAarVrCBoxe04gnCFv7qWfa/E=;
 b=XKT96JmkWsAQGcID7UALmrMIIefdClVgVQT57edOqZh9opxW31Iz37/X40H2YAJY4/s63Ajfc+eEA0B7wn91QFKGW5ccftqxE+xLvmMb5AAuO4Xsr/DsSB7QU0vsygXLyhLt9+FiJBaxp5aM1dn+hQVzsqInnGWRIb3cTmgv3btWSGXuIO6ZZSnC3on2mukH724LRTTNLqE4uDSeYF55pkbmXRkWL9dr6yyRgRbfWLC1Av3SdtnMaQH3BllNEWWQOaPfNwp5rkdf5qDvrqKcYjlZjs4Ds8ZY3e3Tq/LfBNudC6rLDvQWBjjWhDlWq4X5osgyMNd8UD1hwvsXD+COZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by SA1PR15MB5257.namprd15.prod.outlook.com (2603:10b6:806:229::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 12:59:11 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 12:59:10 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/siw: Fix duplicated reported
 IW_CM_EVENT_CONNECT_REPLY event
Thread-Topic: [PATCH for-next] RDMA/siw: Fix duplicated reported
 IW_CM_EVENT_CONNECT_REPLY event
Thread-Index: AdiXgYIQYSBV8VTKSG6mDviRFNpoKQ==
Date:   Thu, 14 Jul 2022 12:59:10 +0000
Message-ID: <BYAPR15MB2631D5F21C907B6145DABE4C99889@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b739184-9a78-4747-4eed-08da6598a537
x-ms-traffictypediagnostic: SA1PR15MB5257:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZ21UtcTh96Mp+K5W/0INjWhAjBTIcXfhCCcNttV0Zt5+nOr8FSBWYfAJvkFZcvl7wk4Ced9Uf2yFltQyLVWaiILHHiLURJWcWjZaCjzl8XsOzbzCD+eyPVPVdnlf1YVzDTEt8I39qrC/CTXDUG3SeVT23dh+8uE/ZlneCxLp0JgGh9kfHPFOahT16rl4v+SSsWrC46aUR9HgDePRUJ3qfbnlW/g3kk8Ne4kg7DPZEyvVimK1gkFMnXr4kkyTlGhOkObKnml/YlNL+ManP3QORXUm0s1QenW6GUeFpj0/NpcKGgIBnI4eCsb5TGDzYI2UJOtiJeBxHZlITCmXqTm9m72EUoHDOTOsGO3XBcmB2jKIG2ALQR87ykL6vVSTvlbv6yeKLbRmVybV+G+hB5v/EqHusg1S+IFdufwyUiZa2cbSR/ssa+rmox71nqPGISdN3r9c+RGw02aqvcfFiTNUcAuwOQNgtz7LsGwHTWygWrqGBVJxwLkddCBU92ZPUhoFBb4aVEDfIHb4i6CWA1rTTnp0gL1NeuMP0wLQt4U6KDZ9vrwY4y0kSUlHVAYNsBqqCdWOJO1xujypgG7UWaVoCMUPJPmiEjxqj/HHZhW8f73wYOOE3sexXT18MPuE1zoDQdRUp4LlZJOkjb/G1AGioZ1J9kIZojszSCzP+moHLFZ7av1lE9SLY7csKrdy1SVrJCb6Nj4c8FBpFqTCpExoF6UMWJvTNL9CrP6GWss641a6FJgn3PwG30k1XeRK9CNnetyhnyopl2HomK5SQE28oLKkLwJrWw4gHP+iYAUSZ13vcpL4uEYVwprpDnZLTBm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(376002)(136003)(5660300002)(71200400001)(8936002)(52536014)(33656002)(86362001)(66476007)(6506007)(64756008)(66556008)(478600001)(76116006)(316002)(9686003)(66946007)(83380400001)(8676002)(4326008)(7696005)(53546011)(38070700005)(186003)(38100700002)(122000001)(55016003)(66446008)(2906002)(110136005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkFPTVB1cDN6Yjg0WFdPZ1gxZFlZRzZmZm5zY3hHU01wSzR6aThYVGMzUHM4?=
 =?utf-8?B?QVpQUVlJQ0dzeUVJQ0Qxem1rb0k3NmhiRHFLTXFtdkhzRzJmU1RvR0hvcUN1?=
 =?utf-8?B?UnRYWUNyMmdBZUpZbGlJOGluVXJnL3FmdkFLcWkrRDM2NUoyM2xVbmExQ0kv?=
 =?utf-8?B?Znk3UUthYnptd1BvVm1abm5QTWRYYktuZDRHZ2FONVp1WWhvZE1VcEFObWFJ?=
 =?utf-8?B?a0V4WGtMQTE3akRpZVN2Y2Fjdms1djlTZkFmMC9ZeU5HZ09vbWdyNFdtalIy?=
 =?utf-8?B?SVVmeGRzVkxvSmRCejJOdXJnRW5uS1BKMVFqOXpwY010dzlsMTBPWXlGZExE?=
 =?utf-8?B?eG5qRDJsYjV2cDU1eUZvTzN2M3dZY3p5eFk5dEd6U2t2bUNrMEdLS1pqNFZa?=
 =?utf-8?B?M3l6WHRDMFRTSEZ0a0VqOXNTaU9KTnpCWi9GeW1zMmUxUERYcDlOejl1dVk5?=
 =?utf-8?B?TmVndXc1NjBTNnNmdm1FWnhOTmQxaXR5NkZmUWNQU1R1UmpIczhSRkNlbFM0?=
 =?utf-8?B?ZFIyOVc4V3R5Z2cvUng1VG9Ca1NIeHhHMVhMUmdXU2pZVW9LdFRYQVRjSjZx?=
 =?utf-8?B?VkpRQ2JKZSttS09GUHlZQ0d2THdncE14a0l0dTJldm9JempnWGNqcG1iU3lU?=
 =?utf-8?B?dlErbk9aU1hySGIySTVjejJ0NDdTWTd0NlEwYzdPZUltazkwOG9hcUFxR05V?=
 =?utf-8?B?Y3V6VDRIN0ZpMmV6N1phYWlXTzVaYUVYK2s0VklZOXRYVjdhcWpNUWxlbWVE?=
 =?utf-8?B?aXk1ejRwdVBvTGwreEdCN2Zud2l5UllweElZclVtNGM3aVRLVmtjQnU0RHpa?=
 =?utf-8?B?eDNFZE90Mk9NK000RS9HTHh5UUZwVXk3NzJWN1pkektkeWZCSWl6VnV4NzZo?=
 =?utf-8?B?d0xocGx1UFRoMnFObzlJeHVXUXRUZWdVaFBiZFFWWXczQ0ZzdkcweXdaTlND?=
 =?utf-8?B?UjFYdVM4eXpPSTZ3MkJYK0ZNUm53T0xLRnRUYVlvWG1VdFMreFlxT0YvRXZa?=
 =?utf-8?B?aTVYbjUzemNLNjZaRGhJdUtqNkVZdFdLOTZPaU5YVDB3MDRNU0FESEFEbWJJ?=
 =?utf-8?B?c3cyWEZ4YjJHNUN3NWh4azd4cmlpbGd5Q090UlRGdnUrNzhIcU9kVlN5QVRN?=
 =?utf-8?B?SzhTYzl4TWNFdnFvSThtRFlTWE42SWZIZnB6MFBmZVVuOWZRSUpwYTJMWHBQ?=
 =?utf-8?B?c2xHVUI1VklZWDAveUlWZERLRnBVTXJjZzE5eDBtaHZNeVNkeGtSak9yWW5V?=
 =?utf-8?B?UlZPdzl4eGlIb0tWdEFZZ0hYREN0cEIyTXNPVUNXYURmeHB6Ym81UCtqMzd6?=
 =?utf-8?B?MUdtNjlrWGZMM2d3Z2F2bnVWU0RBUTFxdGRUVnBjZ3pPcUpXdHhhaGJPNzNZ?=
 =?utf-8?B?ZkE0bUlFMlN3dHBXZ0phUjR4b1NLQVBDZXJReCtzR0NEQ1owakp1LzF6b09y?=
 =?utf-8?B?c1RjTEQrTVlYWDBhc1NKY2Qwdkc0cmlISG4xK0hSZnY1ZTJGN2JRclRWWFlJ?=
 =?utf-8?B?TE1iSDdoSzZob1E0MkNGSWxIZEpRYTI5UmdwZWNmS0Q1cE5zMGU4MmVGZzRs?=
 =?utf-8?B?dnUrV0xBWStyYncvK0RDMHNTb1B0VUppdWlHMkhnL3FRR3hMeUZubVJtbDFn?=
 =?utf-8?B?TzRWV09paGllNCs1YVdWY29PT3o1RXRrZDA3UXlvY0RFRmt5cVc5NmsxSTd0?=
 =?utf-8?B?MUQxSXRnUFQ0WVMzYjZhUnNvbytiM2hQUWRzWVFHcW5sb1BNSzhCQkZndjdu?=
 =?utf-8?B?czE3Z3hid3owd2szZUdvWDJvajhSRmdqWmJqTktqV2p1RTZrUFZxSzhXaE9E?=
 =?utf-8?B?ZlVvRm0vY1NKSDN2QzZ0ak9UcTVXemVYK0JJeFlVK2E0L1ZtZU1IZmtnam1Y?=
 =?utf-8?B?ZnVJUklBTHAzZm9IS2lCNSttZWdhU1dpdkY2NThYbWxFOGZwejdrL3RMMVEw?=
 =?utf-8?B?NG5zMzdQVmJab2I2Q2c5eUkyM1JidUFSaWZmZ0xicWQ0eG5BbkNkWVh4eG9T?=
 =?utf-8?B?UUsxR2lOV3laTktmMWRDaHgrWWg4L0FQRUp1S3VvcmZrUVU2NGh2clJITEFK?=
 =?utf-8?B?THhZS2h2L0JFam9QQ3V5K0ZYT1E2aS84SXN5VzdOQ2hFb0ZlcWhPTnFLNjJ1?=
 =?utf-8?B?a3FjWlp1YkdHaDJKanFua3lIdTlKeVVrYkZubXZwZGtpM0tjQ1daSVk3QlA3?=
 =?utf-8?Q?tnd9V+XsZOJCUsUyMM2g93O6rJWW++oSyVpRE3b2Os+s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b739184-9a78-4747-4eed-08da6598a537
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 12:59:10.7021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiIuu2D/6QWvat2cOJ9X9tPYWR4ZCMorJ/xxD+B8qlEip/2ePpwt1260c3MMe7n8U5Q0yqiT7pHl2DbVREGkbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5257
X-Proofpoint-GUID: kXTjmUUGZpsHvLp1RM2hVClnWdQS3w-h
X-Proofpoint-ORIG-GUID: 73EvRO2YptqDQi1_aRMnXMInamCTVxgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuZyBYdSA8Y2hlbmd5b3VA
bGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNCBKdWx5IDIwMjIgMDM6MzEN
Cj4gVG86IGpnZ0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnOyBCZXJuYXJkIE1ldHpsZXIgPEJN
VEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBjaGVu
Z3lvdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBmb3It
bmV4dF0gUkRNQS9zaXc6IEZpeCBkdXBsaWNhdGVkIHJlcG9ydGVkDQo+IElXX0NNX0VWRU5UX0NP
Tk5FQ1RfUkVQTFkgZXZlbnQNCj4gDQo+IElmIHNpd19yZWN2X21wYV9yciByZXR1cm5zIC1FQUdB
SU4sIGl0IG1lYW5zIHRoYXQgdGhlIE1QQSByZXBseSBoYXNuJ3QNCj4gYmVlbiByZWNlaXZlZCBj
b21wbGV0ZWx5LCBhbmQgc2hvdWxkIG5vdCByZXBvcnQgSVdfQ01fRVZFTlRfQ09OTkVDVF9SRVBM
WQ0KPiBpbiB0aGlzIGNhc2UuIFRoaXMgbWF5IHRyaWdnZXIgYSBjYWxsIHRyYWNlIGluIGl3X2Nt
LiBBIHNpbXBsZSB3YXkgdG8NCj4gdHJpZ2dlciB0aGlzOg0KDQpHcmVhdCwgdGhhbmtzISBJIG9i
dmlvdXNseSBkaWQgbmV2ZXIgaGl0IGFuIGluY29tcGxldGUNCk1QQSBoZHIuIFBsZWFzZSBtYWtl
IGFub3RoZXIgY2hhbmdlIHRvIGZpeCBpdCBjb3JyZWN0bHksDQphcyBzdWdnZXN0ZWQgYmVsb3cu
DQoNCg0KY2FzZSBvZiBhbiBpbmNvbXBsZXRlIA0KPiAgc2VydmVyOiBpYl9zZW5kX2xhdA0KPiAg
Y2xpZW50OiBpYl9zZW5kX2xhdCAtUiA8c2VydmVyX2lwPg0KPiANCj4gVGhlIGNhbGwgdHJhY2Ug
bG9va3MgbGlrZSB0aGlzOg0KPiANCj4gIGtlcm5lbCBCVUcgYXQgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvaXdjbS5jOjg5NCENCj4gIGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1QVCBT
TVAgTk9QVEkNCj4gIDwuLi4+DQo+ICBXb3JrcXVldWU6IGl3X2NtX3dxIGNtX3dvcmtfaGFuZGxl
ciBbaXdfY21dDQo+ICBDYWxsIFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAgIGNtX3dvcmtfaGFuZGxl
cisweDFkZC8weDM3MCBbaXdfY21dDQo+ICAgcHJvY2Vzc19vbmVfd29yaysweDFlMi8weDNiMA0K
PiAgIHdvcmtlcl90aHJlYWQrMHg0OS8weDJlMA0KPiAgID8gcmVzY3Vlcl90aHJlYWQrMHgzNzAv
MHgzNzANCj4gICBrdGhyZWFkKzB4ZTUvMHgxMTANCj4gICA/IGt0aHJlYWRfY29tcGxldGVfYW5k
X2V4aXQrMHgyMC8weDIwDQo+ICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gICA8L1RBU0s+
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZyBYdSA8Y2hlbmd5b3VAbGludXguYWxpYmFiYS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYyB8IDcgKysr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+
IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBpbmRleCAxN2YzNGQ1ODRj
ZDkuLmY4OGQyOTcxYzJjNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfY20uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+
IEBAIC03MjUsMTEgKzcyNSwxMSBAQCBzdGF0aWMgaW50IHNpd19wcm9jX21wYXJlcGx5KHN0cnVj
dCBzaXdfY2VwICpjZXApDQo+ICAJZW51bSBtcGFfdjJfY3RybCBtcGFfcDJwX21vZGUgPSBNUEFf
VjJfUkRNQV9OT19SVFI7DQo+IA0KPiAgCXJ2ID0gc2l3X3JlY3ZfbXBhX3JyKGNlcCk7DQo+IC0J
aWYgKHJ2ICE9IC1FQUdBSU4pDQo+IC0JCXNpd19jYW5jZWxfbXBhdGltZXIoY2VwKTsNCj4gIAlp
ZiAocnYpDQo+ICAJCWdvdG8gb3V0X2VycjsNCj4gDQo+ICsJc2l3X2NhbmNlbF9tcGF0aW1lcihj
ZXApOw0KPiArDQoNCkNhbmNlbCB0aGUgTVBBIHRpbWVyIG9ubHkgaWYgd2UgaGF2ZSBhDQpyZWFs
IGVycm9yLiAtRUFHQUlOIHRyYW5zbGF0ZXMgdG8ganVzdA0KZnVydGhlciB3YWl0aW5nLiBTbyBi
ZXN0IHRvIGFkZCB0aGUgdGltZXINCmNhbmNlbGxhdGlvbiB0byB0aGUgZXJyb3IgYmFpbG91dCBz
ZWN0aW9uLg0KDQo+ICAJcmVwID0gJmNlcC0+bXBhLmhkcjsNCj4gDQo+ICAJaWYgKF9fbXBhX3Jy
X3JldmlzaW9uKHJlcC0+cGFyYW1zLmJpdHMpID4gTVBBX1JFVklTSU9OXzIpIHsNCj4gQEAgLTg5
NSw3ICs4OTUsOCBAQCBzdGF0aWMgaW50IHNpd19wcm9jX21wYXJlcGx5KHN0cnVjdCBzaXdfY2Vw
ICpjZXApDQo+ICAJfQ0KPiANCj4gIG91dF9lcnI6DQo+IC0Jc2l3X2NtX3VwY2FsbChjZXAsIElX
X0NNX0VWRU5UX0NPTk5FQ1RfUkVQTFksIC1FSU5WQUwpOw0KPiArCWlmIChydiAhPSAtRUFHQUlO
KQ0Kew0KY2FuY2VsIE1QQSB0aW1lciBoZXJlLg0KCQlzaXdfY2FuY2VsX21wYXRpbWVyKGNlcCk7
DQo+ICsJCXNpd19jbV91cGNhbGwoY2VwLCBJV19DTV9FVkVOVF9DT05ORUNUX1JFUExZLCAtRUlO
VkFMKTsNCn0NCj4gDQo+ICAJcmV0dXJuIHJ2Ow0KPiAgfQ0KPiAtLQ0KPiAyLjM3LjANCg0K

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401477659D8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjG0RSF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjG0RSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 13:18:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E097
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 10:17:58 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RH9LMv018393;
        Thu, 27 Jul 2023 17:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bwo9/aV1QHAzqC+8nrYwP329m5j/MiUDsKIqihgk7Cw=;
 b=MzQ2ReGRyiU5BX7gXrX8y1cpFRhLX+xuHPDUb9TjZ7MjgUngSH/YqPzcUDcNz8m8UOrf
 DgeHxwOm9dMj44xb8qObOWeOUfD/om60RDHyMrUEQxy7jtOeFHdT5dgqi5MNbXU1Oab7
 1400vRCWBU9BxFS1RRm+ii5BNrAjjfKm3bv61lkYwuc/MTWz9q/blqTAJTYLyuk7NWOb
 e/aTKmDRGSCudyLZpiQKwSfsA0XMF8XJCOF/scGios3wu+I+VQhTGex6SJ/oW7NnihjV
 9a0sHYMsZe/MWHLld+KS6o5WVCBzfsufiWtrz9cJMxeHGeJ0JpSx5kkbxbIrtaQYwHWR BQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3vqpg8yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9OpTd3j+Cu521XW9khCrDO86Ppz5eVTT4pnHFX4j3pnCDYk21XfP0wn70BqRNMGfFP2BmMmUZLq3nRndfSBlLMHEgjRLUSzyXfYBY5YTY56gNvHuga1B6Tpr4p6ChzyCEAKxKYqISxUBkfWMDYSG+rlQTRUAdmsDgAHOecIFS9UO4ESZeDi5IesKdUwtZX+7rK6OJrynbExZ3LOJajEbJxuSF/ltm33Vy4N2+Pl5XOaqGjOly2WSxHDxHYIZK1TyA8BEjd5tBipXrQ0f9VY2Wqi1PZOJivrgxpRcSrz9IydHqpCQ3LkOYApmr6o4DAIrSUf06ESj0gzPy0nIryiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwo9/aV1QHAzqC+8nrYwP329m5j/MiUDsKIqihgk7Cw=;
 b=Xlfhza3pHT43KaZcrhUX3tBCpBgJ4plfkJbX1lACbFOn7B8BaYeAEPCcSUPLGQZPaXWk+eT/F1GCEItOeCtu9EtkGJHJg8RcBk5icF/6Kb7kdGkTiGSUSB1F17cM6MtIkE48ZhG1TBB7Tl3eE7vO82htVn/IdKnztJ8Ofbl/fBR/hv04tlYTODPji06K1YS9xKQ6+z5v+Jhti74X4RVetOFb5EesxPOAM3w2BEaHFQxKcX1Y2nwiVtbrB2mh04iqGL1HfbbA7gOcCQAXxsIQh1HXTBgM38kpp6MSMx9ZMwB/VXYKBoMIJai56ZYLxgLB4QDux10mGptv3hJG/eXpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA1PR15MB5284.namprd15.prod.outlook.com (2603:10b6:806:23c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 17:17:40 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011%4]) with mapi id 15.20.6609.024; Thu, 27 Jul 2023
 17:17:40 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/5] Fix potential issues for siw
Thread-Topic: [PATCH 0/5] Fix potential issues for siw
Thread-Index: AQHZwK4/o6ZrLeh//E+K+kLVHm/vsA==
Date:   Thu, 27 Jul 2023 17:17:40 +0000
Message-ID: <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
In-Reply-To: <20230727140349.25369-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA1PR15MB5284:EE_
x-ms-office365-filtering-correlation-id: 3b3cb1d3-7bf1-43a6-bb83-08db8ec561f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oj0cGS7IRNEN47h+YPv93IImHf7KG8Qg3vlya49GULaiFNNHxFURl4n3+b6F6uoB0kDQU5yWLpzt25Dso3yEKY6/A+SvUdtL12b4rm6F2q/IkGxcvsvILknVYwlsaYHKQFqqtFzd4ND+6meqTxVW/mhXhZj+RPx5mpaWCW8zWiH91p81YB/NnX+pi+BoMhk/kAtPLdoETAQBVhwPNCk3m0lU5LQm7jYzYzzKNZwWp9TozxeWUpjNdbsUh4lAzpSByw6mOfSJ4pRA9vaTUu2g2DTe06d2MdEH2Z+DF6wHYl+zQ/06f/ckhtKndQE6q0hZkaKyig2jxH4IxrdEe9uauhewooJEBt3n9+NpDr1t+PJg2IdOR1Rg8S8zW+1zJRmvX035GMCrwifp9IscSMdx4gnDhukkf4ZXfFd0zsV6cg9ydTE0zGz73bgKq28cUmOnlcyBj+1mFx++LD9gp0PI+rwrbGOK9/HwkF1PvOD3kItjmUQkFvOWS2pEZjb6+aIDgkeyJkbXF9yQDDfNNAfWtb1daDHzP/g4wDIqtouoHGYHe5FP8+dTnh3Q8aTQtAkR9TGUCBmvl39tnttd4LHdlVGawPolhVWYag+UM7hRl3kAJVfEfisChFqRGh48ZCl7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(64756008)(316002)(6506007)(186003)(53546011)(55016003)(122000001)(83380400001)(478600001)(86362001)(71200400001)(110136005)(66446008)(33656002)(76116006)(66476007)(41300700001)(7696005)(2906002)(38100700002)(4326008)(8936002)(8676002)(38070700005)(52536014)(66946007)(66556008)(5660300002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjlnZUNtWWhnTXBlMDYzSHJ4dUdlek8vMldNQlRURGNoWDRaNFo0REhRTjlz?=
 =?utf-8?B?Yjc1My9lOVJwUXZMZTlBOHdVaEFyWUV1MnRXWE1BTVFrKysyblRoN0RFalNT?=
 =?utf-8?B?OWhqalAxK0dlazhWblBLZFpEeDZQalVVRkNtTE0vdXdmb1BDNTA4S3FMck56?=
 =?utf-8?B?WEwvcXhmUzhkSE9DU1ZYbVZJWEIraVl0dUxwa0pmTG1CYmtnSGR0OGxaK3o5?=
 =?utf-8?B?SHQwUnhZTHM1YmM0VlIyeDhwVVlmbzJSOHJzMGZCOHQrTzZpWk8yTU41cmh2?=
 =?utf-8?B?d2FLY2NScjRWNEFHK3RoUFBpS0NWYmFPRFAwMTF0TFpwbFRWdmpFSnlsdkJ4?=
 =?utf-8?B?VW40V2NHWUNZbEdNSWxWY0FJV1A2YzdaRFF1TytSKzUycGZqMFY1ZFRvcCs3?=
 =?utf-8?B?N2NJcS9Iem5ScGtRN0YzVUdWN1VtNGFodktKMnhVMmRBaHV2UXNXQzRmWURL?=
 =?utf-8?B?QnZibmRXbVAxMmFMWENCcnZ0VnliYnl3UlJFdjhkdGNMcnU1ZncveXQxQkZr?=
 =?utf-8?B?ZHpUTTFhaGo1RnIxQVJYaGN0UWFROHNpdUM5L3VkYXVNUUptM0lvQlpVZnJH?=
 =?utf-8?B?THlJS1NnWUFNaXBHb242RnpWWFh5Y3luTEVTUDFvSGV3eXdKbk9VT1gyTkwz?=
 =?utf-8?B?MmdnSHBHUGZJa1I3MXI5N1pBZ1ptbjUyZWsveGRodE5oaTNwUFBRY0UzSzE0?=
 =?utf-8?B?UGk1aGFITlNka1pLUDRqcm1VQVlZQ1F4bTJJcjJuWWt5U3BPYW5IcUVsV2xJ?=
 =?utf-8?B?d1V2K0wzNDloVGtPOFljQTd3M1hDcGt0V0FpZkUrekZUV2xTRjB4d2dBOUtU?=
 =?utf-8?B?bUxqQXpnSmYzL0ZXb0xHQ2FJbHJYaHhZdkk4SUFMTkZod3VxSnBxNWRHQml1?=
 =?utf-8?B?ZnhONmNXRFduYUdxVW02SWp5SE9uMTg4UnhoRFFxbmVmcXIyUXZVY2k1R0Mv?=
 =?utf-8?B?Q1lQYzdDUnFhVHRHR1IwMHpvemNWZkpGQ0s3cDZGV2d1TXdIZVRtQUt6akxP?=
 =?utf-8?B?ZmxJVFBNbzZDbmdDTEpsaFhPYS8xN3BpR0xEM1NGQ01lS2txb1kvRDNwaUQx?=
 =?utf-8?B?RE5lVzVCQStvVlpqVy9PSGFCY0VWMExrYkgxZGRvVEFWcGJ4cHVkaUpHVFJK?=
 =?utf-8?B?RUdCcTRCdnd1VUtYQWp4eThjMFhnVERZUFBDT1lJVFVEajc4QjJvdGo3VEwz?=
 =?utf-8?B?ZE9TS0ZVY29lbmFkQzBudnZyUVNJc3NYa201S3lMN0dpa0Q5aDlRSlREelli?=
 =?utf-8?B?dGUvSkltOU9FZWQ0ZER6U3dMZGpub09Pc3BmVEtJWm9wRjlNaVR4NnVzUlRv?=
 =?utf-8?B?WTZpcGdWU0YyTW1ONzloUlZ5UTFvU0Y2Y1NNSDkxMXRwZWkrN0wwSk5nNVNM?=
 =?utf-8?B?aVBvamtCQ2c5SFV5cU5PVUNJT2NIM0o0ZlB2VFZRQmQ0enZiQmwyOXE5RGxn?=
 =?utf-8?B?ZXVPekZOdGErcTVpb1lRYjFSSk5Fd2U4YnhtUDhVbDYxUzNUNXBLT2E2VTFW?=
 =?utf-8?B?TTNUeVltdmZHNHI3cHJjT0JMS293TkdKbEN1NEVQdURNa2ZGSllWR0xsRTlJ?=
 =?utf-8?B?S0h6RHhwRFRlalVtUkNSSXNiVVNISXpzMzk5U0hCRmlHbS9GWmJUdm9WdnRS?=
 =?utf-8?B?cHRUcStBRUNtNFFoeDNMaElaYWZSczdpZERJSzJzQTJ6d2l1UHI3WEZocEhY?=
 =?utf-8?B?dHdwZGkyakQ2anVOU1daWkpUSGtaa3U1dkczcDArL0tmMWJGbEtvcTNhKzho?=
 =?utf-8?B?dVFmbGhudE5Ud0wrL3hPcEVpOHBYdFE1bFZEbGVzZ2NkcmV1dEhhY0xxcEFR?=
 =?utf-8?B?QXBMaDlONnBJTU9kM1hFZVAzRzI3N3JyZ0RpaU81cmMxNjRqRU5sdTFZdGhK?=
 =?utf-8?B?dEFHSU1tbVFuYTJpc2FKdFl4L3k3a2dpSlNRMC80SE56L1MvMWx1Ukh5NzRl?=
 =?utf-8?B?SENkL3Q5Qmxjd0xxTFhNb1g3dUp1a3NvUFVzZWJ1UEp2UW1YK0tDWmRFZ3dU?=
 =?utf-8?B?U0tWa2hlTWROSzNibVlocXFEWjZmRFZaMGRTNmZFU051bDBrZFdzajFObUd5?=
 =?utf-8?B?alEzNjFwT0krWkp6MG5adHd1S1ovdW5pT25oQ2ttVzhCY2ZvK0EwMkJCTnNF?=
 =?utf-8?B?di9tQUdoU2JpcnJ6QXJsZUpZL3pReWtBR1dGOU5HUTNlYzY0WTN1OEZoZmxy?=
 =?utf-8?Q?3DCEbciiylybvHYfLZafByg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3cb1d3-7bf1-43a6-bb83-08db8ec561f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 17:17:40.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQXJazD5Lu05tcfe5pyKEIbvC2Hj9q3jS6UKlMKbICakczf/rkPtQ6ZUY1GJjd+WovFfWMLxd48lbyutvVpEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5284
X-Proofpoint-ORIG-GUID: lzsNYvZDvm6fk-g_FGTO55wrZRQLtuBu
X-Proofpoint-GUID: lzsNYvZDvm6fk-g_FGTO55wrZRQLtuBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=926 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCAyNyBKdWx5IDIwMjMg
MTY6MDQNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdnQHpp
ZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDAvNV0gRml4IHBvdGVudGlhbCBpc3N1ZXMg
Zm9yIHNpdw0KPiANCj4gSGksDQo+IA0KPiBTZXZlcmFsIGlzc3VlcyBhcHBlYXJlZCBpZiB3ZSBy
bW1vZCBzaXcgbW9kdWxlIGFmdGVyIGZhaWxlZCB0byBpbnNlcnQNCj4gdGhlIG1vZHVsZSAod2l0
aCBtYW51YWwgY2hhbmdlIGxpa2UgYmVsb3cpLg0KPiANCj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X21haW4uYw0KPiBAQCAtNTc3LDYgKzU3Nyw3IEBAIHN0YXRpYyBfX2luaXQgaW50IHNpd19p
bml0X21vZHVsZSh2b2lkKQ0KPiAgICAgICAgIGlmIChydikNCj4gICAgICAgICAgICAgICAgIGdv
dG8gb3V0X2Vycm9yOw0KPiANCj4gKyAgICAgICBnb3RvIG91dF9lcnJvcjsNCj4gICAgICAgICBy
ZG1hX2xpbmtfcmVnaXN0ZXIoJnNpd19saW5rX29wcyk7DQo+IA0KPiBCYXNpY2FsbHksIHRoZXNl
IGlzc3VlcyBhcmUgZG91YmxlIGZyZWUsIHVzZSBiZWZvcmUgaW5pdGFsaXphdGlvbiBvcg0KPiBu
dWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuIEZvciBtb3JlIGRldGFpbHMsIHBscyByZXZpZXcgdGhl
IGluZGl2aWR1YWwNCj4gcGF0Y2guDQo+IA0KPiBUaGFua3MsDQo+IEd1b3FpbmcNCg0KSGkgR3Vv
cWluZywNCg0KdmVyeSBnb29kIGNhdGNoLCB0aGFuayB5b3UuIEkgd2FzIHVuZGVyIHRoZSB3cm9u
ZyBhc3N1bXB0aW9uIGENCm1vZHVsZSBpcyBub3QgbG9hZGVkIGlmIHRoZSBpbml0X21vZHVsZSgp
IHJldHVybnMgYSB2YWx1ZS4NCg0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVy
aWNoLmlibS5jb20+DQo+IA0KPiBHdW9xaW5nIEppYW5nICg1KToNCj4gICBSRE1BL3NpdzogU2V0
IHNpd19jbV93cSB0byBOVUxMIGFmdGVyIGl0IGlzIGRlc3Ryb3llZA0KPiAgIFJETUEvc2l3OiBF
bnN1cmUgc2l3X2Rlc3Ryb3lfY3B1bGlzdCBjYW4gYmUgY2FsbGVkIG1vcmUgdGhhbiBvbmNlDQo+
ICAgUkRNQS9zaXc6IEluaXRpYWxpemUgc2l3X2xpbmtfb3BzLmxpc3QNCj4gICBSRE1BL3Npdzog
U2V0IHNpd19jcnlwdG9fc2hhc2ggdG8gTlVMTCBhZnRlciBpdCBpcyBmcmVlZA0KPiAgIFJETUEv
c2l3OiBEb24ndCBjYWxsIHdha2VfdXAgdW5jb25kaXRpb25hbGx5IGluIHNpd19zdG9wX3R4X3Ro
cmVhZA0KPiANCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMgICAgfCA0ICsr
Ky0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYyAgfCA3ICsrKysrKy0N
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCA3ICsrKysrKy0NCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IC0tDQo+IDIuMzQuMQ0KDQo=

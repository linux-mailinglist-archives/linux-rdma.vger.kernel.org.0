Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3317D59A6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjJXRXL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 13:23:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3A122
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 10:23:08 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OHA8tF009889;
        Tue, 24 Oct 2023 17:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=+QBaXPL+f83z+Bhs9IVZESn6Awvy/zWnVPBLjAUGd2g=;
 b=OQIeAgHG/OXi3UcrXDBTs8+k99CrLWticSJTtxYwW0IARfTOCUT4MtxRk4ZM9lEEnRrz
 9QNBPxRt9W5nE4cps1hrIPMdxWCY0kPilhr7naxR3zezWdMJ1HEz9+vnGkCzavPM/iD+
 Oqyls0jtCkT5QiSJBaA/lH/egs6aW7YOQsCv8WnwWF768rKwBdHP/Gk8IC6zSqIMxUUH
 TsRTefjN2qYFw5Nq4gcefRziUGgCO/LpOfoLBhsp40jw53Rc8xNt7wVrlbvVG0Vg3ITX
 w2XEw42p0/j/9lP5+N6mc5v6CbhBqVkyzmZidELqoGskMONm9jL7SGfMT9qO2Lkd2kpy 4w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txj34rd75-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 17:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7XtCCsvWrVlfGpYD6xawpMCIZyFqriT9M9KW/oXqfck6+N+9uEWq78rCCjZjsK4+kD03JKiCQC3/2fPC28WtHGgujNeV2C411HCFpIeywEnVlDN8NExhEt4zmdAwf0kUMT+TSFD7DCtutNit57wj3EEGMS0uax8mfcl8SG60eKcWktuJbXOuSiQYBIL8ADGJmfUbUAbIq6rjC0e9SOumJ5hJd/enAAwymI9NRwYHLisvwY4IHQt+09iuXkVpq9Z6oH08bIz7FftGTjB0g73Qt5kfd9VpGjeCPI+JKqrsRIh2c6Ess/SUvQJQTLWkILqnu75Hss8mw4ZkrRoCrTBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QBaXPL+f83z+Bhs9IVZESn6Awvy/zWnVPBLjAUGd2g=;
 b=dWKDt56cKTYXFNMaIvYka3BvYGPZTPtQlb/2wM5wPksdTSuQZKkXqC+1vIRu9YjgtKCGgfFu5fHP0OaqS41tZFAkNmLWglCZH+tc5HMepDV3lUEuAzqTvtS7iu9NXvyKuF6D3kQ+vBlZlilWe78KBmkJmCOHJ+Occo4cZMFhXy8D1TN0ZOr3RJVg//s+ATlRYyPsbrJwJWnJhw/j3EqFo9PZI35oaI1Fd6CWzD7A0lk/nmphkYszpcYKrVIJbt+w26wjiwqPqhpVZvU1/+K0MbGtFLDTKwnT1fAc5QdLG7uUGp76482UaY1PatsGc08Mnd/dE/1OYnWP5SrxgC9CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CO6PR15MB4194.namprd15.prod.outlook.com (2603:10b6:5:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Tue, 24 Oct
 2023 17:22:38 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::22c9:19b7:db90:c653]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::22c9:19b7:db90:c653%2]) with mapi id 15.20.6863.032; Tue, 24 Oct 2023
 17:22:38 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH V2 00/20] Cleanup for siw
Thread-Index: AQHaBoR+f0jHGF4F30KymeEUgto1lrBZL/pw
Date:   Tue, 24 Oct 2023 17:22:38 +0000
Message-ID: <SN7PR15MB5755962D628D7026A95D968999DFA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231024140959.GA1939579@unreal>
In-Reply-To: <20231024140959.GA1939579@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CO6PR15MB4194:EE_
x-ms-office365-filtering-correlation-id: 3eae087e-1694-4aba-8bd5-08dbd4b5d21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbYhQbrs7e3i2+jFxt7MzyLED2jmLzrvfcaK07coqrGf9aN4ZrSAw42QQEWye8pB3sCvHgJlR6vQfwJKzIGiPtc2KUyQacQFO8hecjk6giXx7Er9gLch1QiQ0MBt7lpjv7lI03AihQ03x3rhUcfuEIGgrwEijcoWYA1GpM9tQpKU8sI97WQj/iXN4xTJFPN6VYauhjFwQ8rjRPfCrCLg0DNretlglada8kTQ5f/WJjL8q3iXeQY2Z2WpL7Ct5M1jaRPOnN6AdI0GtVoCZz89sfagDrQs77DHCaTuVslV2Xp3aSmiBZLu27qzFbAg1+jbw7noMKYpfkj975nANaB1qprrpMqNOGw3zIyCmxntFP0WNdU2kar8y3VJ/xrFxYMapaDbH2G8/i1ri8KKgiSI/AYmtlMLe0Wxsf/tPgNfLIWS3grj5oeqr7FRBPeMeio0kj8lEE8Vy/kB83qLBXAWENI+xaPds2AQgcK2hY/3IfgZwXqShpcs4BE0PLFHfSx89kdRh61sivsUMhV5R+DpWjWVccL5tKwa97TkGQkW3Dtn8InG5tj+fnwl+YwNOYfA1kh7fVeb6q+APUbBzH9lSdX9v2P/Y0py93ZY7liX1NTngjp4uUFkpQBl65NZC0Is
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(8676002)(4326008)(8936002)(9686003)(7696005)(6506007)(52536014)(71200400001)(5660300002)(38100700002)(2906002)(4744005)(86362001)(53546011)(110136005)(316002)(66446008)(76116006)(66946007)(54906003)(64756008)(66556008)(66476007)(33656002)(38070700009)(83380400001)(41300700001)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE9XazE5MGpBdXp0UXZiR0o3Q00zNDFRVm56YXcvcWpFeTNWeWhaUnE3VVdh?=
 =?utf-8?B?cmU3OXJMMnJNSmxFeENhbDlmTjFFWnpTN0dqRjFLZE0xMCs1VlJmN3AreWU3?=
 =?utf-8?B?QlJOc1oyN0p6ckszc3kyMW42elNiaytYNC9IUnZvMllkbXhLTkpCZW43bGw1?=
 =?utf-8?B?dmZFRFNZd0xlakFaTUpoTFZmOEgvL2dnbktEMVJVanFYOUlndlBjdUJjZ1pS?=
 =?utf-8?B?NC9GMCtocG9GMEszdnhwbkJyS2MyczVGcVB1cGlCZjRHZmorcmFqWTlpYXA3?=
 =?utf-8?B?WWsxV2dZcUFkL1hDQ0xFY3NjZlgvRGRiU29WNjZOaG1oTDZHUnJpVUVRN251?=
 =?utf-8?B?dHpMRndNS211TkNEeDNhUVdPS1E1WXJCNFhGSXJHZGhFSWs4ZTVaekl3NVB5?=
 =?utf-8?B?bmFkbGUzaStVeUNpS1Ywc3NkQ25ROGNnY3RyUmZ6aDRvcDhqcHNieENRNVhD?=
 =?utf-8?B?M1BLRFYwVUlSNCtVMGhKbW9ndjRoYkJDbUpLOG9VSzVkaTdFY3k3cEU2MklN?=
 =?utf-8?B?VEUvUUR6Sk5nSVNxdndJUjRSbU9TeTdEWWFCekNpTE5Tb3N4SlNZRW1pdE4x?=
 =?utf-8?B?YXFXYTlQV0dqenhYYk1GNlJEUndWMElpdEN4dDNHUjhFVDdTWmtoK0VzK0hs?=
 =?utf-8?B?cjdrNkJLUWFZbXFOMzlnYmJsaTUrV1JFY3JvSnpvd2tOa0VqUHFjTXQ1bXB2?=
 =?utf-8?B?ZGlRdllBQnhIdE5LaGFMeWphVXVEYm5FRlUyUkdOYjU3ZkovVVd1ZlgvbU9W?=
 =?utf-8?B?S1phcDl4NERoQlpTNktKRTNJd01sY0IvcnFsTW5yNll5TUw2ZlM2OStXN3NT?=
 =?utf-8?B?a0pLS3Bpdm5zYWMvOXR0UC9yc3lMQnNnanE0Tk1sRG1YSUdEbmJ6Wm9IUTZW?=
 =?utf-8?B?QlNpSjFVU0R3OHRlMitkYWZOZHVRMFE0ZmlNc2FWUHZlSnNQeTIxbk1Jai9l?=
 =?utf-8?B?a0E2VmxVdDhsTzVlS3c2OWtRcXhhVVN5RDUxMXBvdVZIeUc3MVJOcnp3ZjZW?=
 =?utf-8?B?Q0EzOVpob0IyWFhCRHdtVFhaUmVqL1owK0JQSzhtUEdNKzJ1RCtJNnBlTlll?=
 =?utf-8?B?eDRtOXVzTHo5WlBIeUZKNVczRXZ5bkVUVHlFK0RGYXlqZklBRVVuYXdCclYz?=
 =?utf-8?B?dVFtN1NQZzZkOEhoZ25RQWJreEZCcjhxMkVpUnpaUXAyU3lqZHhBb2RIL0dt?=
 =?utf-8?B?R3IwR1cwWHlaUGZwWEgvUWhoOHVxSnVqZEtpblpQd3JxNnJNNnVIcVI5OFNv?=
 =?utf-8?B?aiswb01NUGRhbm9KaFkvdXVudlZnUkxxZW1DYllTMk1kSUpRd0IxQk8vVHUy?=
 =?utf-8?B?enpGLzJocjVyL2F4WUQxN0IvUXY4bjZLMzZ6bGNmL1lYTHQ5ekRLbWZKU25m?=
 =?utf-8?B?M25ac1p5aEZZYVR4SGpUN0VJQVZGYjZlZEJwdGtKeW9PK1NSSXBlb01NRURD?=
 =?utf-8?B?MWN4UXhKdytRd2NLTjZmZEcrK09KNXZ3MHVlUXgydWpzOStYVEdMelFMWHNK?=
 =?utf-8?B?aEN1M2Z6alM3dkd4QXp1UW91amJzdFdEd2lHcUdpYi9EeWJXR3dvc2kzWFZK?=
 =?utf-8?B?OU5JNWE3dXlITGJ6N0wxTW0xajVpTUM5cGFrN20xdHlpY2FUaVNISTQ3dnVm?=
 =?utf-8?B?NzRjVnl4Z3BjbjN3ZnhBM3hxTmdGaC9Va2oyeXFha1lXZmxUWVpvaHJqbzAw?=
 =?utf-8?B?SU1mRUM5M283WW84NVNvZ1N3cHBMaGNIakV0MmRUU3RXaU1Cd25yNHlTS25Q?=
 =?utf-8?B?WUxYdVVMcXl4OXRtWEJWdTQrVm5YeTgrUVlDa1FMVHdXN3l6cU9yZEJERTE1?=
 =?utf-8?B?akpxOWJPalJVMFBWem5UQlJVWnlzZWg5N2RKNnR4UmF4aXVEVWljUU5oM0tL?=
 =?utf-8?B?Nkt0SE96M1YzS3hXSFBxSXlCK1ZrRnRkLzVQYTdnbFNYU0szL2JwcmtYOFNM?=
 =?utf-8?B?MXp4dkdGS1pXc3ZHNmY2R1RjdHVpNWw1Y2pPemNtWTg3N3o4WURGNFpCdDBr?=
 =?utf-8?B?aTdwUUlSQmNQZGJPUDVtY3FoODBMOEd4MDk1ZDJCaXB1aVBud0RxMzdPSDJT?=
 =?utf-8?B?d09uY0cxdnBlWEpUMXZBbW93c05Kdk0zN1U4MjQrYW00LzJlcmh5SU5vc01z?=
 =?utf-8?B?Q3N1WTh0cEZzbGF4eDVrOFF5Vmd2MlorMjdSZlZ2cjRVMklIWEhPcHF3TWkr?=
 =?utf-8?Q?sdSQIax528arDAgVEJxQB1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eae087e-1694-4aba-8bd5-08dbd4b5d21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 17:22:38.1881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7gewY+WjWWC6T4a8tytqlztLMJNVhrf6FwUI1OkU85m06dGRy2YSxNHaH+UXVco8dBQ1kiKPMOHfIZI5ew0jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4194
X-Proofpoint-GUID: DfWqK_NuNpqbY9ZfNeL0Mu4855Wp57A1
X-Proofpoint-ORIG-GUID: DfWqK_NuNpqbY9ZfNeL0Mu4855Wp57A1
Subject: RE: [PATCH V2 00/20] Cleanup for siw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=514 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQsIDIwMjMgNDox
MCBQTQ0KPiBUbzogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+OyBCZXJu
YXJkIE1ldHpsZXINCj4gPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGpnZ0B6aWVwZS5jYTsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BB
VENIIFYyIDAwLzIwXSBDbGVhbnVwIGZvciBzaXcNCj4gDQo+IE9uIEZyaSwgT2N0IDEzLCAyMDIz
IGF0IDEwOjAwOjMzQU0gKzA4MDAsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+ID4gVjIgY2hhbmdl
czoNCj4gPiAxLiBhZGRyZXNzIFc9MSB3YXJuaW5nIGluIHBhdGNoIDEyIGFuZCAxOSBwZXIgdGhl
IHJlcG9ydCBmcm9tIGxrcC4NCj4gPiAyLiBhZGQgb25lIG1vcmUgcGF0Y2ggKDIwdGgpLg0KPiA+
DQo+ID4gSGksDQo+ID4NCj4gPiBUaGlzIHNlcmllcyBhaW0gdG8gY2xlYW51cCBzaXcgY29kZSwg
cGxlYXNlIHJldmlldyBhbmQgY29tbWVudCENCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBHdW9xaW5n
DQo+ID4NCj4gPiBHdW9xaW5nIEppYW5nICgyMCk6DQo+IA0KPiBCZXJuYXJkLCBkaWQgeW91IHJl
dHVybiBmcm9tIHRoZSB2YWNhdGlvbj8NCj4gDQoNCkhpIExlb24sIHllcy4gSSBoYXZlIGl0IG9u
IG15IGxpc3QuIEkgaG9wZSB0byBnZXQgdG8gaXQgdG9tb3Jyb3cuIA0KU29ycnkgZm9yIHRoZSBk
ZWxheSENCg0KQmVybmFyZC4NCg==

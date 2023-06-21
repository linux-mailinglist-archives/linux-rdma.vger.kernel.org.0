Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E441A737E4B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjFUI7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjFUI67 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 04:58:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C52107;
        Wed, 21 Jun 2023 01:58:21 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L8kfeC029256;
        Wed, 21 Jun 2023 08:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=vT89wnUhe0glvEmaUOxIWc+oYNahEK3BqnQ9MYVNGy0=;
 b=crmGxUYzsq86eVBaEy7qf/UO3NJRGrOh1Wttm2QNtya05OZjl9/QoJj2JVYFTMJc18XJ
 S1PeUaQtROudXOr3Xjaa6Ml4GnUnwKlrfbGPVQfK6KhJGtJ2Q9VlxXYpil2mBxpyjmnJ
 NgJk2Uv82vhlzuTQ8N5hW62QV6tu7qJIqZQhFvYsuqj0z5Yr1RA6V2qpHkczx7QCYS+H
 oE35x7W3vVML/SRwC/YN44SB2xvFv/hkEGVTwHZRZS0JWW8UcvUjKm6fWnoslK8KTZ0g
 1WtXAwkM+WYDoUhP6XjJj3KxfgIJea4wYicpGaVb8AA93brhK/TyFOd3UN7BbI9eTE/I QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbx0b87fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:57:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L8lNk4000703;
        Wed, 21 Jun 2023 08:57:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbx0b87et-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAwldrF+3dzYv2swPC06VhFC9WiWDo2CJKZnc5Zf/4rJMrcBhKzrqAvF2+w1rSUWtv3aTCpNtARffzDdQpNQiya/c6MoxiEK/06d/ePRtCrl30wU44457F685npUmvwXMa50bkLMTYjCwUdygRJ881EvHGuIaIpfVMYKsCoSTHjSn9Phdobo/Z1f7PTsGHsHa8kjC3XMIvIG0H/5++Q5spf2v49+ubjVh+fSXrvGfTTHUCaQswCeSedvzq4onRPuyZuDxiUpaCZUbyLd12ET9MLc4N0ku0pOYB9sliWYjhHr2dQn2ubfMdaw+uTO6c35ZQO/0KZmWmWTLOkjIvJWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT89wnUhe0glvEmaUOxIWc+oYNahEK3BqnQ9MYVNGy0=;
 b=B+wnBm+bdW2c+ZLVLFu4yRg/KIBYPt6QEHjGmRdd4ZNZzcow1WYBdz+6NPHfWraIgmKu0kl9TtJjD84Hn+yrJ0fyX5b63hLuJdsXzkfbYfyl4TYI4lxBuF0NzVanJnMWjjRud5x7qNqpyUTLSTIAgrUwLkvzs0gBvku3taRmcIkqjTWTUtC+GopblslXn9otFyD5JnyH902H/ud1Bt1GM1Hyx1QmRnzM/ldcqRWOlU7ckxNQpYITpINhhUi9Tneb7jQpg1gDrRHc9VDv6w9W11qagZg0AE0yNmlYqWBOl+ds7JXQvO0yaHJbRNsQDCwa9fAXplKSq9UcK8BKL9sEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CO1PR15MB4826.namprd15.prod.outlook.com (2603:10b6:303:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 08:57:49 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ec1f:2ff1:71d2:3f5a]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ec1f:2ff1:71d2:3f5a%6]) with mapi id 15.20.6477.037; Wed, 21 Jun 2023
 08:57:49 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     David Howells <dhowells@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH net-next v3 04/18] siw: Use
 sendmsg(MSG_SPLICE_PAGES) rather than sendpage to transmit
Thread-Index: AQHZo4djpSpGCOj8S0ObFoJwAXYcNa+U8vAw
Date:   Wed, 21 Jun 2023 08:57:49 +0000
Message-ID: <SN7PR15MB5755AC0B56FDBE597F586695995DA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-5-dhowells@redhat.com>
In-Reply-To: <20230620145338.1300897-5-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CO1PR15MB4826:EE_
x-ms-office365-filtering-correlation-id: 38b36a0c-ed32-4b4c-5a03-08db72359708
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ivgr0VdVTJc+w0gK7Yi3epInKIoWYUk1uc8CCh/oC3s/KS5gMZD3yfazaMcmYmY8jU2Y+4hM65Z5IzqGkOPlak7HXCJNv63PiteLD41YkJvFiaqeMNrWkWXlJTj7GLpN+V/rAnyQJoiFrHmL8h0D21c3dV1cjK+Y2eea9SxsqeJcHNBYni9R//5QOVsbtElfUZgmLJrAfd6SWt29PuWLHh+OKg6W1wywzomGBwqnI39KT1NE0/sdU8KZFdUM9k/mIl3zMhMnY0aZsKp112za4U/Ata1NcAbKuYl1uLOv5hkmrp3GlpfSGUGfKWJERxWXRkHnKd9PnquLC1w75McwE8JUszef2B5KkXr28uF0ikpKUtpNk1Al2L4wJJVdbK5IrmhDt7l7hxRJrxlFrySpMZ1DhcG9Fb1PfF3ZiqWZTCDZ3kMkukMLTb98JAFlayOP4KKtHduITibiYgz4Fa6+TGcny3z9UDNXZy5C28SBClascN7+V3ELliCH1+fPRxNRaQoAsemVxRs+2Okbwy8UzNoeTSv59KiKegTHsL2ZpgncFCdhvlCUpid378/prKjAYQlYf5bz2fwIyJnmU9OXu4GPZVHMqHLJTpBLOS3cCbyPBSvFZ4xHHJ5qSZeFeeAt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(2906002)(186003)(66476007)(66556008)(64756008)(71200400001)(66446008)(9686003)(66946007)(7696005)(4326008)(76116006)(316002)(54906003)(110136005)(5660300002)(6506007)(8936002)(53546011)(7416002)(41300700001)(8676002)(52536014)(478600001)(55016003)(38100700002)(122000001)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzY4WFhKc3h2b2pHRm9GR1U3elgyWmlJWDZ3ckZ6Y0UwZytrRVF6UHlobzdu?=
 =?utf-8?B?ak4xdXRDaHpocFduV0JzcVgycGF1TFRhcnllU0JXekxwZjhsNU1mV2d6OSti?=
 =?utf-8?B?YXh3Mi9QdjFzTzNnNXhVVHFmNHZEeTloYWlPOCtObklncFZrMUs1b2FWdmRy?=
 =?utf-8?B?WGh1RjRNUEtsZ2lDZ2pUbW5ObEk2T2llQzBMQVdCV2JPWjhNdHphTHpZb2Q5?=
 =?utf-8?B?SGhZcmp4R1hWVW9IQTQ5MkFZYmZtZmkzR2NyQ1ljYmdxMnlvdWZkalJWbHRW?=
 =?utf-8?B?QXo3bzhhaDF5NkoxM3p3Z2J2YkRadlpXUFBESVpSNS90clh1dHJwQW9FUDlG?=
 =?utf-8?B?eTBMR3lBUlZtOVN5UWxxeDdoeTVDSVlFSGYvTWpWOTZJV3VTMWRBMElxZWlY?=
 =?utf-8?B?UnVkZW8reVFOa0JzSjRneVV2djZsdXYwZm5sVFFwQWhMVWFnWlFLTUw0MkUy?=
 =?utf-8?B?L1JyK2RMYm5iYi80ZDN3NEZHOGMxTmxHTjlUMk1GRXMwRFJMWC9IanVYc3NR?=
 =?utf-8?B?RFkrcUswL0IxeGQ2N1FvNzh4bHRaeGMyOFJLU0E0UXFZUVpuTS9iVnRyUU8w?=
 =?utf-8?B?ZFRQamFIZEkwQStQZGxWb2U1cFJ4ZTR6QmRwQzk2blRleHJFRktMSnhFVUlr?=
 =?utf-8?B?OCttWDNZUEhzNkpIUEV5dTY4UWFMazh4WHdrYTV5U00rOG5vYjRLSWRFWHZY?=
 =?utf-8?B?YmJBd2RjV21vZ3ZGVFFUZ0czWlB0UmYwdjE2SFFVMUJJTitRSGRZeEJUc1NP?=
 =?utf-8?B?bkhPaWVBcDhsaVlUNDVBSlcwek5hQ25rS1Z4Mmk2d2lMbEsvVllUR0ZTSTFz?=
 =?utf-8?B?ZHZEeVdodHFzc2U2YjhGbFdsaHNBOGtDQ2ZYN084S3N2QSthc1l5U09zMmFZ?=
 =?utf-8?B?Uk1EdWVEL2lLRGp5T1B3bVlxOFkxNDIxcFhPR0p6a2tQUkcvTE5TdGk2WFRN?=
 =?utf-8?B?dGZsKy9ZdUNjN0d3bjd5cklYdUhSVkc2UW5WT1cxNDdESDJtU1N6NVlqRFBI?=
 =?utf-8?B?U0JFVUlzYjFFWkc2Q2I1dnk4TnlJR2VHVzk1Yk55ZENTSi9DeCtOeHRuM0xH?=
 =?utf-8?B?bmNNbWc2TmxLZFVrRkdGSElua2pSWDkzZTJacmgzSTFZckhHdDlWMVE2UXdu?=
 =?utf-8?B?enhMWHhTZEtrQ1FBdFpPMjBEVms0TGtEL1BlQlZtcUhBS0VyRnFKZmFBZzZn?=
 =?utf-8?B?N2c0bWIxajAraStkd0xFUDNzU044cm5FZ3ZBVG1IZkozbG5VR1lMbHpIanNG?=
 =?utf-8?B?OThlV1Fqbk5qd3NYS1ZjUjdTRGx1ZHJhd1N6WWg0MmNPNHpaalBCVEdUR21j?=
 =?utf-8?B?ei9nUVA0WXBwQmhWYXBBaE11bUlwQ0VZUlRleDNFME5CZ3l6a296TUw4SUZq?=
 =?utf-8?B?RTFXeGdUVXN3KzJCZWtiZkdIOGFUNzRaTkxXakJTeUNYenU2cDRFeDZKQlRI?=
 =?utf-8?B?YmNLYTBlNXBEdlVXZkNjcEtCMGRkN2wyRWJiNHlicTB4VC84UmJEVWExaS9N?=
 =?utf-8?B?cXZYbG9ha0MzOTY0VVVPV2QxNXNEd3Y2by92a3Q1VTVKSE91VTVzNzlhN3FY?=
 =?utf-8?B?dldSSE9MWmFITkNqVTNnb2JQRDExNkhYbEtadVB0R1c1RytjT09odkZ1aDRJ?=
 =?utf-8?B?L1Z4VGJ4bHF0c2JyN2xmNUpuK0tSVVg0NGpVTDQ1WlhjTXVubHlqa3JST2Iz?=
 =?utf-8?B?aXJnK21sTG1sdzFtN3o0WElSZjdpdWF3eFRtb09RZzQ2cXU3eGFpNjVWZlkw?=
 =?utf-8?B?cWJ5cHJITjUySkRkVGV3dUFPRVhMamdXa1o5U1dxekt5YnlJRENXUHlNcFUv?=
 =?utf-8?B?aThGcEJ2VFRGNVY1dnd3TUpRVDExeG9vRGo2Z2YzVVVBVWRkMlRwK1ZOeDdu?=
 =?utf-8?B?M3VrOTRTWlYySTJ2cHNnUWdnanZRSS8zY2J2N29NcTZzclZoUDgyU0cxbURa?=
 =?utf-8?B?U2pqRUNXaGpERWRIaTNkb0tFT1daMnJHc0VyaS9UeEt5RlhuNmo0TDNvbnZm?=
 =?utf-8?B?d3gvK3p5aC9uN3JENitGRzQ1THZuTFJ3bzIrd0lzS3llOERjY2lmQkE2WFhu?=
 =?utf-8?B?ejZWRDNYcmhVOEs3a0dmZklPV24wV2ZNdCswREVOZVZnZmFhUlpTVkJVdGR2?=
 =?utf-8?B?N1FFN1o5UHBpWXcrK0NBemcrc2RpYktocFMzQkVmNHZEUFBaRzhGcHlnbWEw?=
 =?utf-8?Q?igxKbS57Bae45rd3GGyPW70=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b36a0c-ed32-4b4c-5a03-08db72359708
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:57:49.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EP5khv7Lj5AzVb/TTwSm0ha8BzCu456YKqiVIRbkWHFmm4CEaGoFkQHX9IViJrhRUyhyAuF8TPK8WjeS7S5CCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4826
X-Proofpoint-GUID: P7eYf-8jZzPkPVef1SWjZc7jc4hinmRj
X-Proofpoint-ORIG-GUID: l_OQxiGIfWt_XvPcm-ySmaaMC1R9-KYC
Subject: RE:  [PATCH net-next v3 04/18] siw: Use sendmsg(MSG_SPLICE_PAGES) rather
 than sendpage to transmit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSG93ZWxscyA8
ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgMjAgSnVuZSAyMDIzIDE2OjUz
DQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYXZpZCBIb3dlbGxzIDxkaG93
ZWxsc0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIER1eWNrDQo+IDxhbGV4YW5kZXIuZHV5Y2tAZ21h
aWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFdpbGxlbSBkZSBCcnVp
am4NCj4gPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+OyBEYXZpZCBBaGVybiA8ZHNh
aGVybkBrZXJuZWwub3JnPjsNCj4gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+
OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+OyBsaW51eC0NCj4gbW1Aa3ZhY2sub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCZXJuYXJkIE1ldHpsZXINCj4gPEJNVEB6dXJp
Y2guaWJtLmNvbT47IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPjsgSmFzb24gR3VudGhvcnBl
DQo+IDxqZ2dAemllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IGxp
bnV4LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQg
djMgMDQvMThdIHNpdzogVXNlDQo+IHNlbmRtc2coTVNHX1NQTElDRV9QQUdFUykgcmF0aGVyIHRo
YW4gc2VuZHBhZ2UgdG8gdHJhbnNtaXQNCj4gDQo+IFdoZW4gdHJhbnNtaXR0aW5nIGRhdGEsIGNh
bGwgZG93biBpbnRvIFRDUCB1c2luZyBhIHNpbmdsZSBzZW5kbXNnIHdpdGgNCj4gTVNHX1NQTElD
RV9QQUdFUyB0byBpbmRpY2F0ZSB0aGF0IGNvbnRlbnQgc2hvdWxkIGJlIHNwbGljZWQgcmF0aGVy
IHRoYW4NCj4gcGVyZm9ybWluZyBzZXZlcmFsIHNlbmRtc2cgYW5kIHNlbmRwYWdlIGNhbGxzIHRv
IHRyYW5zbWl0IGhlYWRlciwgZGF0YQ0KPiBwYWdlcyBhbmQgdHJhaWxlci4NCj4gDQo+IFRvIG1h
a2UgdGhpcyB3b3JrLCB0aGUgZGF0YSBpcyBhc3NlbWJsZWQgaW4gYSBiaW9fdmVjIGFycmF5IGFu
ZCBhdHRhY2hlZCB0bw0KPiBhIEJWRUMtdHlwZSBpdGVyYXRvci4gIFRoZSBoZWFkZXIgYW5kIHRy
YWlsZXIgKGlmIHByZXNlbnQpIGFyZSBjb3BpZWQgaW50bw0KPiBwYWdlIGZyYWdtZW50cyB0aGF0
IGNhbiBiZSBmcmVlZCB3aXRoIHB1dF9wYWdlKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiBjYzogQmVybmFyZCBNZXR6bGVyIDxi
bXRAenVyaWNoLmlibS5jb20+DQo+IGNjOiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4g
Y2M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiBjYzogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IGNjOiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD4NCj4gY2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gY2M6
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IGNjOiBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+DQo+IGNjOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IGNj
OiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gY2M6IGxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnDQo+IGNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAN
Cj4gTm90ZXM6DQo+ICAgICB2ZXIgIzIpDQo+ICAgICAgLSBXcmFwIGxpbmVzIGF0IDgwLg0KPiAN
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCAyMzEgKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAx
OTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4
LmMNCj4gaW5kZXggZmZiMTZiZWI2YzMwLi4yNTg0ZjlkYTBkZDggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBAQCAtMzExLDExNCArMzExLDggQEAgc3RhdGlj
IGludCBzaXdfdHhfY3RybChzdHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LA0KPiBzdHJ1Y3Qgc29j
a2V0ICpzLA0KPiAgCXJldHVybiBydjsNCj4gIH0NCj4gDQo+IC0vKg0KPiAtICogMGNvcHkgVENQ
IHRyYW5zbWl0IGludGVyZmFjZTogVXNlIE1TR19TUExJQ0VfUEFHRVMuDQo+IC0gKg0KPiAtICog
VXNpbmcgc2VuZHBhZ2UgdG8gcHVzaCBwYWdlIGJ5IHBhZ2UgYXBwZWFycyB0byBiZSBsZXNzIGVm
ZmljaWVudA0KPiAtICogdGhhbiB1c2luZyBzZW5kbXNnLCBldmVuIGlmIGRhdGEgYXJlIGNvcGll
ZC4NCj4gLSAqDQo+IC0gKiBBIGdlbmVyYWwgcGVyZm9ybWFuY2UgbGltaXRhdGlvbiBtaWdodCBi
ZSB0aGUgZXh0cmEgZm91ciBieXRlcw0KPiAtICogdHJhaWxlciBjaGVja3N1bSBzZWdtZW50IHRv
IGJlIHB1c2hlZCBhZnRlciB1c2VyIGRhdGEuDQo+IC0gKi8NCj4gLXN0YXRpYyBpbnQgc2l3X3Rj
cF9zZW5kcGFnZXMoc3RydWN0IHNvY2tldCAqcywgc3RydWN0IHBhZ2UgKipwYWdlLCBpbnQNCj4g
b2Zmc2V0LA0KPiAtCQkJICAgICBzaXplX3Qgc2l6ZSkNCj4gLXsNCj4gLQlzdHJ1Y3QgYmlvX3Zl
YyBidmVjOw0KPiAtCXN0cnVjdCBtc2doZHIgbXNnID0gew0KPiAtCQkubXNnX2ZsYWdzID0gKE1T
R19NT1JFIHwgTVNHX0RPTlRXQUlUIHwgTVNHX1NFTkRQQUdFX05PVExBU1QgfA0KPiAtCQkJICAg
ICAgTVNHX1NQTElDRV9QQUdFUyksDQo+IC0JfTsNCj4gLQlzdHJ1Y3Qgc29jayAqc2sgPSBzLT5z
azsNCj4gLQlpbnQgaSA9IDAsIHJ2ID0gMCwgc2VudCA9IDA7DQo+IC0NCj4gLQl3aGlsZSAoc2l6
ZSkgew0KPiAtCQlzaXplX3QgYnl0ZXMgPSBtaW5fdChzaXplX3QsIFBBR0VfU0laRSAtIG9mZnNl
dCwgc2l6ZSk7DQo+IC0NCj4gLQkJaWYgKHNpemUgKyBvZmZzZXQgPD0gUEFHRV9TSVpFKQ0KPiAt
CQkJbXNnLm1zZ19mbGFncyAmPSB+TVNHX1NFTkRQQUdFX05PVExBU1Q7DQo+IC0NCj4gLQkJdGNw
X3JhdGVfY2hlY2tfYXBwX2xpbWl0ZWQoc2spOw0KPiAtCQlidmVjX3NldF9wYWdlKCZidmVjLCBw
YWdlW2ldLCBieXRlcywgb2Zmc2V0KTsNCj4gLQkJaW92X2l0ZXJfYnZlYygmbXNnLm1zZ19pdGVy
LCBJVEVSX1NPVVJDRSwgJmJ2ZWMsIDEsIHNpemUpOw0KPiAtDQo+IC10cnlfcGFnZV9hZ2FpbjoN
Cj4gLQkJbG9ja19zb2NrKHNrKTsNCj4gLQkJcnYgPSB0Y3Bfc2VuZG1zZ19sb2NrZWQoc2ssICZt
c2csIHNpemUpOw0KPiAtCQlyZWxlYXNlX3NvY2soc2spOw0KPiAtDQo+IC0JCWlmIChydiA+IDAp
IHsNCj4gLQkJCXNpemUgLT0gcnY7DQo+IC0JCQlzZW50ICs9IHJ2Ow0KPiAtCQkJaWYgKHJ2ICE9
IGJ5dGVzKSB7DQo+IC0JCQkJb2Zmc2V0ICs9IHJ2Ow0KPiAtCQkJCWJ5dGVzIC09IHJ2Ow0KPiAt
CQkJCWdvdG8gdHJ5X3BhZ2VfYWdhaW47DQo+IC0JCQl9DQo+IC0JCQlvZmZzZXQgPSAwOw0KPiAt
CQl9IGVsc2Ugew0KPiAtCQkJaWYgKHJ2ID09IC1FQUdBSU4gfHwgcnYgPT0gMCkNCj4gLQkJCQli
cmVhazsNCj4gLQkJCXJldHVybiBydjsNCj4gLQkJfQ0KPiAtCQlpKys7DQo+IC0JfQ0KPiAtCXJl
dHVybiBzZW50Ow0KPiAtfQ0KPiAtDQo+IC0vKg0KPiAtICogc2l3XzBjb3B5X3R4KCkNCj4gLSAq
DQo+IC0gKiBQdXNoZXMgbGlzdCBvZiBwYWdlcyB0byBUQ1Agc29ja2V0LiBJZiBwYWdlcyBmcm9t
IG11bHRpcGxlDQo+IC0gKiBTR0UncywgYWxsIHJlZmVyZW5jZWQgcGFnZXMgb2YgZWFjaCBTR0Ug
YXJlIHB1c2hlZCBpbiBvbmUNCj4gLSAqIHNob3QuDQo+IC0gKi8NCj4gLXN0YXRpYyBpbnQgc2l3
XzBjb3B5X3R4KHN0cnVjdCBzb2NrZXQgKnMsIHN0cnVjdCBwYWdlICoqcGFnZSwNCj4gLQkJCXN0
cnVjdCBzaXdfc2dlICpzZ2UsIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+IC0JCQl1bnNpZ25lZCBp
bnQgc2l6ZSkNCj4gLXsNCj4gLQlpbnQgaSA9IDAsIHNlbnQgPSAwLCBydjsNCj4gLQlpbnQgc2dl
X2J5dGVzID0gbWluKHNnZS0+bGVuZ3RoIC0gb2Zmc2V0LCBzaXplKTsNCj4gLQ0KPiAtCW9mZnNl
dCA9IChzZ2UtPmxhZGRyICsgb2Zmc2V0KSAmIH5QQUdFX01BU0s7DQo+IC0NCj4gLQl3aGlsZSAo
c2VudCAhPSBzaXplKSB7DQo+IC0JCXJ2ID0gc2l3X3RjcF9zZW5kcGFnZXMocywgJnBhZ2VbaV0s
IG9mZnNldCwgc2dlX2J5dGVzKTsNCj4gLQkJaWYgKHJ2ID49IDApIHsNCj4gLQkJCXNlbnQgKz0g
cnY7DQo+IC0JCQlpZiAoc2l6ZSA9PSBzZW50IHx8IHNnZV9ieXRlcyA+IHJ2KQ0KPiAtCQkJCWJy
ZWFrOw0KPiAtDQo+IC0JCQlpICs9IFBBR0VfQUxJR04oc2dlX2J5dGVzICsgb2Zmc2V0KSA+PiBQ
QUdFX1NISUZUOw0KPiAtCQkJc2dlKys7DQo+IC0JCQlzZ2VfYnl0ZXMgPSBtaW4oc2dlLT5sZW5n
dGgsIHNpemUgLSBzZW50KTsNCj4gLQkJCW9mZnNldCA9IHNnZS0+bGFkZHIgJiB+UEFHRV9NQVNL
Ow0KPiAtCQl9IGVsc2Ugew0KPiAtCQkJc2VudCA9IHJ2Ow0KPiAtCQkJYnJlYWs7DQo+IC0JCX0N
Cj4gLQl9DQo+IC0JcmV0dXJuIHNlbnQ7DQo+IC19DQo+IC0NCj4gICNkZWZpbmUgTUFYX1RSQUlM
RVIgKE1QQV9DUkNfU0laRSArIDQpDQo+IA0KPiAtc3RhdGljIHZvaWQgc2l3X3VubWFwX3BhZ2Vz
KHN0cnVjdCBrdmVjICppb3YsIHVuc2lnbmVkIGxvbmcga21hcF9tYXNrLCBpbnQNCj4gbGVuKQ0K
PiAtew0KPiAtCWludCBpOw0KPiAtDQo+IC0JLyoNCj4gLQkgKiBXb3JrIGJhY2t3YXJkcyB0aHJv
dWdoIHRoZSBhcnJheSB0byBob25vciB0aGUga21hcF9sb2NhbF9wYWdlKCkNCj4gLQkgKiBvcmRl
cmluZyByZXF1aXJlbWVudHMuDQo+IC0JICovDQo+IC0JZm9yIChpID0gKGxlbi0xKTsgaSA+PSAw
OyBpLS0pIHsNCj4gLQkJaWYgKGttYXBfbWFzayAmIEJJVChpKSkgew0KPiAtCQkJdW5zaWduZWQg
bG9uZyBhZGRyID0gKHVuc2lnbmVkIGxvbmcpaW92W2ldLmlvdl9iYXNlOw0KPiAtDQo+IC0JCQlr
dW5tYXBfbG9jYWwoKHZvaWQgKikoYWRkciAmIFBBR0VfTUFTSykpOw0KPiAtCQl9DQo+IC0JfQ0K
PiAtfQ0KPiAtDQo+ICAvKg0KPiAgICogc2l3X3R4X2hkdCgpIHRyaWVzIHRvIHB1c2ggYSBjb21w
bGV0ZSBwYWNrZXQgdG8gVENQIHdoZXJlIGFsbA0KPiAgICogcGFja2V0IGZyYWdtZW50cyBhcmUg
cmVmZXJlbmNlZCBieSB0aGUgZWxlbWVudHMgb2Ygb25lIGlvdmVjLg0KDQpKdXN0IGEgbml0IC0g
bWF5YmUgY2hhbmdlICdpb3ZlYycgLT4gJ2Jpb192ZWMnIGluIHRoaXMgY29tbWVudD8NCg0KSSBz
dWNjZXNzZnVsbHkgdGVzdGVkIHdpdGggbnZtZW9mIGNsaWVudCBhbmQgaWJfcmVhZF9idy9pYl93
cml0ZV9idy4NCkxvb2tzIGdvb2QsIEkgdmVyeSBtdWNoIGFwcHJlY2lhdGUgdGhlIHJlc3VsdGFu
dCBjb2RlDQpzaW1wbGlmaWNhdGlvbnMgaW4gdGhlIHR4IHBhdGghDQoNClJldmlld2VkLWJ5OiBC
ZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg0K

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84F7D6C89
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjJYM67 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344332AbjJYM6v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:58:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9A9F
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:58:48 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCJChG010363;
        Wed, 25 Oct 2023 12:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uX1HuUx6XHumEKTiT+IUxdHMqkSF9yyRWGlT9NLuEuM=;
 b=O20aGlKDLZjuJfeZ39CthlGqmHDAvuPYBQnZWkSZfUlv1mLAQgaBf8HbFWD3d4jWu6EH
 sSa6KmbLLPMtca8skv0AJEbAxhLaSePdOro6liglz3aVwH86LUmXZW/uh2jC8MxblS/p
 044qQtibdYLupFeS9dK1J/S7MFKG0Gr5QxDYZPUCmGNtErDOyZ2H47t9TGplOT0uiOmm
 UOD9s6tbdFKucwMecACj/rLTvVdcuiTPAuwQO1EvzR8tXkDhRHiXMfGad549qoJcm18S
 PYoJKhghO9beVPazEhstVJ6COnrseQKixcXuuldQmmJvUad7iCXXqt/Go9WLZo4XvYoN YA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2wv9r75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz80wCcLbig0LCMHhxm0WGaN/3fu7gpiOnrZG/OLVCOcohTRV3MAPGRC6zzo6rOo3ZivW112VeE0VWTdvQg8Nw046wBwce1TNQUzfvklezjF0tL8hjXcpEiNpmhi94QTY37vKrNb+HHL5piXx3zeJye6y0db+Q55O3rqbZyAvrekgzAlZjaF6HYUP8zQw+SnvIbWlccOCXkwUcMgdV3jl8U5r7fgSxgvg0iSTKuYSKDWsOL5BKXWjwuZxEimwfCtgvlGHmNcCWgqhL9DefmcYnqvDHRdlkDqm/vdERb1vzNPDYx52Zv40R2SYZITdM18J0bN5Ma8uB9pZE4jZAGxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX1HuUx6XHumEKTiT+IUxdHMqkSF9yyRWGlT9NLuEuM=;
 b=hqmTk4LRcPcIRqo5vt+RB6c2Xp7JqCsYCjhtKSyBE8sdcrj4+RLpDWSEpGPDvtGBHBD5rIHqKthKwsS/OECHOVyjBQNnA+LDDmMRIoi7k09+lepGrUn/bGeWc78FO5gSJktAnUbuLZ6nJL6xQHJfrUnOLTe9qDwDaNv/QWzMg0eqWWLzp8hMth9EEyx92s78cnPOah1msRJOlJc75+AQGeqUUUQLulQ06UB8BcyD/8/8Oj0lxb7dL2ITDqfpIO8yvcVmZOBBH7TwtBasv/abtV/12TEYtKHZdHwYXzglXc7Ok2eopiZarrrRGgTLxdJL0EOfiZI5qdKDxrfrKAF/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by IA1PR15MB6222.namprd15.prod.outlook.com (2603:10b6:208:453::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:57:45 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:57:45 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 11/19] RDMA/siw: Introduce siw_cep_set_free_and_put
Thread-Topic: [PATCH 11/19] RDMA/siw: Introduce siw_cep_set_free_and_put
Thread-Index: AQHaB0LYr4ZtYKyFck2xqL+49goj+Q==
Date:   Wed, 25 Oct 2023 12:57:44 +0000
Message-ID: <SN7PR15MB5755278C4DE19C26638AB8FF99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-12-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-12-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|IA1PR15MB6222:EE_
x-ms-office365-filtering-correlation-id: 6b9c3f44-662f-479e-c394-08dbd559fb5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Rv1waO3if1ZrAdlIByH9u6NY9WlpFYxB6l0Y7iiftR6NqpVOPS6Z6SDNkbYiMTQ8LE+GjfY6Ewp5FzLqq5BRcTSZFH3B77UbY1YSIYDBWnf5/qIYVFeC4ehuAmZvrNEduP6P4A1CTeeFYCRr6rbhJYQHbAFxNElUW/bXOoJAMQx/Dhg9uHMv8+xwajZsEIY2TrMdz4snWlcAjqYCasO74+G71zSBBxrzjjBbgoC2N8z7qUZRiH2r+xCOglgMTDOmfuDKIkXJoyATt/mAX29VYFgga0tZ8gS32+XCDlPfN7346bZSwI0c4ksqX/dDdUcZjMJR+daOz5dqU0DwK0/G8JnnMyc4uGYaAm57879HY6NeIvZUlzWZBwbUY5twxRWs3Jb4pn/g7BiBsgDlKDW6PD8CMKqf7OXSAXMgnqhtxqoqicLLuVxuUSjjx6Q1LK9l8Ku/ph1Fiymrhac6iSJZlX/C1E/gqIyP6JAaWsF2CB6/4x2d4GPkI3tiBhqmK0doaOE7gL0N+SaUbPZFSuNEtrr7H1QKomka3/xrY4LnISjieXSIYznTuQBsXcu4ngBR+RF3FgNAgUNCgi0XpkHNQNi/Vb5qe5zm9M1oXwJpit0SrbD+0OaEVM/z41dTm8z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(55016003)(66899024)(71200400001)(2906002)(38100700002)(7696005)(4326008)(6506007)(53546011)(52536014)(9686003)(8676002)(41300700001)(110136005)(83380400001)(5660300002)(86362001)(66556008)(33656002)(8936002)(76116006)(66446008)(316002)(122000001)(66946007)(478600001)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRiRTZHUnpXZ0Q0RUxxdlBZSWJTQm56R3liVzVjMElpeUVBVVMwODk4MWZZ?=
 =?utf-8?B?dWF1SnJHVXppb2p2Ymx5R0UxMFZzSXdTbE1XMDBEY1VhMURwc0srVUhoUjRV?=
 =?utf-8?B?dUd5cXVZZDQ3M0xnTG01WitPY2JPdmRjRVFWU1M4WmhndXpqMDk5L3lUNXha?=
 =?utf-8?B?TWJJK3BLKzNSSFZQWS9BajdOTUpRTTFWSVBGZDVSc0Rkb0tvM3FCblZnMnc1?=
 =?utf-8?B?YkxOZzJLZm9TV2RQNEhZeDFiN1hUeDFBVmtjYjJYN1NNMHYrLzdrTGNLTkR0?=
 =?utf-8?B?bkNyVVVLbnpjQXVqdXl0MzNYblF2MDk5aVNzbHh1V2ZLeXlGWFI3bEdVUVFX?=
 =?utf-8?B?bUpzaStETTdNTWovWGIybmtaZE5PaDZIcEJjQURsb0dOcFRmQk5UM01DNkpG?=
 =?utf-8?B?b1k3RHYvdWZLcHRFVEVPejdLZzdZcVdIamE2Mm4rRENHTHVUWXdYbmhINExT?=
 =?utf-8?B?U0VrV3NQWVVFZ3hNd3c3TkUxdzdKSm5VU01hSmdaNnhYTUc4aG53OWFjSTZK?=
 =?utf-8?B?V3QvSWg2SE85cEdiREQ3bmlXRVNxeU51a2Npd0pJUUlGSll3MmEwUEZmOWlG?=
 =?utf-8?B?N2dmYWxkYlhlbDlRd0s3R3NRSUdaRjFaeFJreDB2K0dYTnlaUG5tcjZUVW5z?=
 =?utf-8?B?bTZFbGYwbmpmNHBmWGdBMVVCQmV2VGhwS3lJa2o1SGpUZytLeDVtMlc4MEVH?=
 =?utf-8?B?clVkbGJkSGFPb0RKbERBRStiYzA5KzN5aE9BR0txSVhxL2dFd1c2ZlozWG1S?=
 =?utf-8?B?SW4weWRUQm5ORDQrMVc1cjJDcFArZVNjUDZwMVlFVFc2bTkrZlhhTGhmdGcr?=
 =?utf-8?B?cTBjR3BQcXpJd3RLWkVLNkJCZzhxbGx4RkI0UVlnMWhrSnl6S0NsWE92THRS?=
 =?utf-8?B?S0RyV0lxQ1NmOGN6V3UxSk8ycUh4bnBOeFh1UFVXWjVQTVZDSGU1d1dtVjVB?=
 =?utf-8?B?L0UwT2J3Nk1CanVUL3lxb1hyZVlFZTVsbStBY3d0MVlSZnVlVkpibE4xTkJi?=
 =?utf-8?B?MUlyRVQ1UitHaEJuOTBmSzdjYUJJck9WZlpPMFRzWmdwMXpTNWFZVmJvYm5l?=
 =?utf-8?B?ZVMvdHR2MzVONy80MUkyYkhCVWVUa01zUkFjblRNY2hmZmFjSTBGbFhaejlG?=
 =?utf-8?B?bFAyOFFYeG1xblB2WG1qTVY0SUwrWEU5ZktzUTFaMGxLVFlHcFZGWmZTWVZt?=
 =?utf-8?B?OTdwUm5FUUgxR1ZseHVob3hHOG5NWkhReEs2SHNWNllkV3RTMTBEVzQ2cEdD?=
 =?utf-8?B?Yk9BdCtVRkR5eXFnVmVsamc5NGluQjMraEhVVVFpblpIbmUrc3lQREtFZUZH?=
 =?utf-8?B?VC9mclBzd1Bvc1FOdmZ6dEN6WXEweDlWY2tMR2VrT0NhaFhDMG5WSzdHZGRH?=
 =?utf-8?B?cC84eVJ6VktmUEcyS0ZtTjd1dFVOcGp0eW1UeGtUZFRETmtsOExjT1VkS3d4?=
 =?utf-8?B?NkpVTjNNQjVTK2xqcTFoNVcvWEZFWm9wSnFhTzJ6NkxCVTRhbG5FUnQ4M05D?=
 =?utf-8?B?QmdvQk9tZjg0eHBsQThMZkpTajhCUkpieTRET2t2OG9qWHZzTnhISHQ4TW5H?=
 =?utf-8?B?bzZRc2dEc3ZYZXVmZ2JoNnZHT0pTZzlGODFsUjYwTks0MFY3dlR3NVBqOUFi?=
 =?utf-8?B?NTVGVEM5S2VJTzI2S2IrNndMTGUzNjlVTTY1TDNHd1Rkc2VQcHpzUm1melpQ?=
 =?utf-8?B?TmhLV0RzdXNtTU52V0JlUGhuN1p4SlYzODh0ZGhpSjRHR0pBb3doSUE0MUVW?=
 =?utf-8?B?UGw0Vyt2TjAybElMbGRjT0ZJY2kxNlNHU1ZWUkFhNys0b3pRVkFuVFZOaFJD?=
 =?utf-8?B?QWhOQmlsMmxrQjQyaTBWNFl0K0tvL3JmTG9QTklSaWxlbnBDclk3OGdxK2Vh?=
 =?utf-8?B?MHYzdWJnNDMyOWlNTFg3WXozbWluWjduUTgrNm9vWkkrc05vQkhqTlNIUUsw?=
 =?utf-8?B?N2Y3NmVrMmVDcUZEczNQdVYxeUZ6Ti9NSUR3cUlLbnAwdEpWNHcyd2RudDhZ?=
 =?utf-8?B?dFdqL2lPRkZmZEhmUkFNWTl6TDZrM2RraE8ySmVUTEhkVXZRK1VmMitJM0ZP?=
 =?utf-8?B?bUR1Z0Z3Z2kyY2Y4ZXdlT3FoQThFRi9Kd2V0Yll0RGZ1T2NFaDZqUlN1NGxm?=
 =?utf-8?B?L3FvclNwcG5lakNab09XVE5UWnZwUDZiZGVpV3oyTGk2alpGN0tWVjZrNjd4?=
 =?utf-8?Q?BsjusAk4YbtAL2i+OHOgpYU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9c3f44-662f-479e-c394-08dbd559fb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:57:44.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoqKwbSpAKMDUjHHnJYWpvRr/a02tDIbtHDmScohC8LnzxSSSBZs8z5yCHbKpeMF+jlwNt2rHqTnYbT/FRhwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6222
X-Proofpoint-GUID: HBqP9X2U2NFT1T9lYL6zRcTcEYLb80bE
X-Proofpoint-ORIG-GUID: HBqP9X2U2NFT1T9lYL6zRcTcEYLb80bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDk6MTggQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdn
QHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDExLzE5XSBSRE1BL3NpdzogSW50cm9k
dWNlDQo+IHNpd19jZXBfc2V0X2ZyZWVfYW5kX3B1dA0KPiANCj4gQWRkIHRoZSBoZWxwZXIgd2hp
Y2ggY2FuIGJlIHVzZWQgaW4gc29tZSBwbGFjZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9x
aW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jIHwgMzEgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0K
PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gaW5kZXggYzhhOTExODY3
N2Q3Li4yZjMzOGJiM2EyNGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0K
PiBAQCAtNDQ0LDYgKzQ0NCwxMiBAQCB2b2lkIHNpd19jZXBfcHV0KHN0cnVjdCBzaXdfY2VwICpj
ZXApDQo+ICAJa3JlZl9wdXQoJmNlcC0+cmVmLCBfX3Npd19jZXBfZGVhbGxvYyk7DQo+ICB9DQo+
IA0KPiArc3RhdGljIHZvaWQgc2l3X2NlcF9zZXRfZnJlZV9hbmRfcHV0KHN0cnVjdCBzaXdfY2Vw
ICpjZXApDQo+ICt7DQo+ICsJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiArCXNpd19jZXBfcHV0
KGNlcCk7DQo+ICt9DQo+ICsNCj4gIHZvaWQgc2l3X2NlcF9nZXQoc3RydWN0IHNpd19jZXAgKmNl
cCkNCj4gIHsNCj4gIAlrcmVmX2dldCgmY2VwLT5yZWYpOw0KPiBAQCAtMTUwNiw5ICsxNTEyLDcg
QEAgaW50IHNpd19jb25uZWN0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVjdA0KPiBpd19jbV9j
b25uX3BhcmFtICpwYXJhbXMpDQo+IA0KPiAgCQljZXAtPnN0YXRlID0gU0lXX0VQU1RBVEVfQ0xP
U0VEOw0KPiANCj4gLQkJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAtDQo+IC0JCXNpd19jZXBf
cHV0KGNlcCk7DQo+ICsJCXNpd19jZXBfc2V0X2ZyZWVfYW5kX3B1dChjZXApOw0KPiANCj4gIAl9
IGVsc2UgaWYgKHMpIHsNCj4gIAkJc29ja19yZWxlYXNlKHMpOw0KPiBAQCAtMTU1NiwxNiArMTU2
MCwxNCBAQCBpbnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdf
Y21fY29ubl9wYXJhbSAqcGFyYW1zKQ0KPiAgCWlmIChjZXAtPnN0YXRlICE9IFNJV19FUFNUQVRF
X1JFQ1ZEX01QQVJFUSkgew0KPiAgCQlzaXdfZGJnX2NlcChjZXAsICJvdXQgb2Ygc3RhdGVcbiIp
Ow0KPiANCj4gLQkJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAtCQlzaXdfY2VwX3B1dChjZXAp
Ow0KPiArCQlzaXdfY2VwX3NldF9mcmVlX2FuZF9wdXQoY2VwKTsNCj4gDQo+ICAJCXJldHVybiAt
RUNPTk5SRVNFVDsNCj4gIAl9DQo+ICAJcXAgPSBzaXdfcXBfaWQyb2JqKHNkZXYsIHBhcmFtcy0+
cXBuKTsNCj4gIAlpZiAoIXFwKSB7DQo+ICAJCVdBUk4oMSwgIltRUCAlZF0gZG9lcyBub3QgZXhp
c3RcbiIsIHBhcmFtcy0+cXBuKTsNCj4gLQkJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAtCQlz
aXdfY2VwX3B1dChjZXApOw0KPiArCQlzaXdfY2VwX3NldF9mcmVlX2FuZF9wdXQoY2VwKTsNCj4g
DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gQEAgLTE3MTEsOCArMTcxMyw3IEBAIGlu
dCBzaXdfYWNjZXB0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVjdA0KPiBpd19jbV9jb25uX3Bh
cmFtICpwYXJhbXMpDQo+ICAJY2VwLT5xcCA9IE5VTEw7DQo+ICAJc2l3X3FwX3B1dChxcCk7DQo+
IA0KPiAtCXNpd19jZXBfc2V0X2ZyZWUoY2VwKTsNCj4gLQlzaXdfY2VwX3B1dChjZXApOw0KPiAr
CXNpd19jZXBfc2V0X2ZyZWVfYW5kX3B1dChjZXApOw0KPiANCj4gIAlyZXR1cm4gcnY7DQo+ICB9
DQo+IEBAIC0xNzM1LDggKzE3MzYsNyBAQCBpbnQgc2l3X3JlamVjdChzdHJ1Y3QgaXdfY21faWQg
KmlkLCBjb25zdCB2b2lkDQo+ICpwZGF0YSwgdTggcGRfbGVuKQ0KPiAgCWlmIChjZXAtPnN0YXRl
ICE9IFNJV19FUFNUQVRFX1JFQ1ZEX01QQVJFUSkgew0KPiAgCQlzaXdfZGJnX2NlcChjZXAsICJv
dXQgb2Ygc3RhdGVcbiIpOw0KPiANCj4gLQkJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAtCQlz
aXdfY2VwX3B1dChjZXApOyAvKiBwdXQgbGFzdCByZWZlcmVuY2UgKi8NCj4gKwkJc2l3X2NlcF9z
ZXRfZnJlZV9hbmRfcHV0KGNlcCk7IC8qIHB1dCBsYXN0IHJlZmVyZW5jZSAqLw0KPiANCj4gIAkJ
cmV0dXJuIC1FQ09OTlJFU0VUOw0KPiAgCX0NCj4gQEAgLTE3NTMsOCArMTc1Myw3IEBAIGludCBz
aXdfcmVqZWN0KHN0cnVjdCBpd19jbV9pZCAqaWQsIGNvbnN0IHZvaWQNCj4gKnBkYXRhLCB1OCBw
ZF9sZW4pDQo+IA0KPiAgCWNlcC0+c3RhdGUgPSBTSVdfRVBTVEFURV9DTE9TRUQ7DQo+IA0KPiAt
CXNpd19jZXBfc2V0X2ZyZWUoY2VwKTsNCj4gLQlzaXdfY2VwX3B1dChjZXApOw0KPiArCXNpd19j
ZXBfc2V0X2ZyZWVfYW5kX3B1dChjZXApOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAg
LTE4ODksOCArMTg4OCw3IEBAIGludCBzaXdfY3JlYXRlX2xpc3RlbihzdHJ1Y3QgaXdfY21faWQg
KmlkLCBpbnQNCj4gYmFja2xvZykNCj4gIAkJc2l3X3NvY2tldF9kaXNhc3NvYyhzKTsNCj4gIAkJ
Y2VwLT5zdGF0ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gDQo+IC0JCXNpd19jZXBfc2V0X2Zy
ZWUoY2VwKTsNCj4gLQkJc2l3X2NlcF9wdXQoY2VwKTsNCj4gKwkJc2l3X2NlcF9zZXRfZnJlZV9h
bmRfcHV0KGNlcCk7DQo+ICAJfQ0KPiAgCXNvY2tfcmVsZWFzZShzKTsNCj4gDQo+IEBAIC0xOTI0
LDggKzE5MjIsNyBAQCBzdGF0aWMgdm9pZCBzaXdfZHJvcF9saXN0ZW5lcnMoc3RydWN0IGl3X2Nt
X2lkICppZCkNCj4gIAkJCWNlcC0+c29jayA9IE5VTEw7DQo+ICAJCX0NCj4gIAkJY2VwLT5zdGF0
ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gLQkJc2l3X2NlcF9zZXRfZnJlZShjZXApOw0KPiAt
CQlzaXdfY2VwX3B1dChjZXApOw0KPiArCQlzaXdfY2VwX3NldF9mcmVlX2FuZF9wdXQoY2VwKTsN
Cj4gIAl9DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjM1LjMNCg0KT2theS4NCg0KQWNrZWQtYnk6IEJl
cm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K

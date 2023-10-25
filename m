Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9059B7D6C65
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjJYMvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJYMvj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:51:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE166AC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:51:37 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClFtF030391;
        Wed, 25 Oct 2023 12:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ig3fcFyuS8k46WahLeeXir7YcvsXjhgMq5sUxi3MCmU=;
 b=cYeVxJFxDSbq4Pe7CFS34gAS4hdMC0Mr9RGzZs9dBuY03j80eZMrc21X5B3I/LiWbNuL
 VkDd6Vhm4cyMWFid4racxtpIgf+WVzwTqQ2TxX/nU7Nh3FM1+EM69nVDJEACbkntoXlP
 wATmPWd1s0Ijp72n5dlhJEE0WjkX3uFRpylcD3YxpJETmOMoF9viAI+W1djDDcUmwyaR
 7PE/L+Jcy7pNEwa/uLbr0XNYPbjxcxWUxShsoSerzT6fyEbmBzkvq0QS7/zjJrEWy9BR
 Q0kQfphwZGyQ1Sz/r4vYqfSAFVxXpsZ2Pa6LVb/hAfkX7pQw78vyH78cmXtMkrG8q5Cb 2Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b206y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8qt+bMNgFWHE9VtHKaue2Vhr79nHqP9kJD1/gLk6K1jUmD72hYy+zeL+oRvpVMt0wFlFpI8me0hufhjxKGrPPh8B6LwlCmq6d0RlAmuozP87IkaX+0f+HDn/LVj4z+wJseUuYqXJXa3s+rd8ydDalfOkzTsOf7Jrj3trA0RUBIob4jKCtDmPgZ9tcsYesJy+/37h6JLr17aFEih2zegJv3X6oI5q5M60V6vB5yBqPbSw/25lozR+UAHV4Etr4KGGnmK8uPlhQyNFcPdA+/AFReCyqOcp5Q7Af3DKD/C1/ud/LwUXdvZ99t3jy/fjtnF4kC75q+y1QzuVifua8cekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig3fcFyuS8k46WahLeeXir7YcvsXjhgMq5sUxi3MCmU=;
 b=NnKBfi19SEdIfahbVJPImcsEZyCs1lXXKjnKROwwDN6RUckZ5G4iFGCdb6UVoGGnZNyz+4XKlWZp4jDtjbsixNLE8WO+D8WjllsHK3QNMOhG9BZXVCHSc3UyPmfRninStVpg+xOPTtCqUrnlDcZ8oPjh15IQX431xjLes1IpkuX3naedwA1WIhir2Vrf/MkwGYQpjZG/lzx1g4eMjp3QqYzNWT2v2O061rlAXwZuAoD9Oipxz3PR47fR6oKLV/XocSG68wYtAHaYUyp5ACX3Bx7mOjqv2E65aMSA94E3xnxsOZhurncVO9hvtZQIu109BEZ9DLH7sxpaBkCTjHwvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by BL3PR15MB5457.namprd15.prod.outlook.com (2603:10b6:208:3b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Wed, 25 Oct
 2023 12:51:29 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:51:29 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: RE: [PATCH 07/19] RDMA/siw: Also goto out_sem_up if pin_user_pages
 returns 0
Thread-Topic: [PATCH 07/19] RDMA/siw: Also goto out_sem_up if pin_user_pages
 returns 0
Thread-Index: AQHaB0H4DwgpBznGukyxR32jVI27xQ==
Date:   Wed, 25 Oct 2023 12:51:28 +0000
Message-ID: <SN7PR15MB5755A61717BCC2EEF8AABAE799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-8-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-8-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|BL3PR15MB5457:EE_
x-ms-office365-filtering-correlation-id: 20024988-55f3-4d8b-73d9-08dbd5591b53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sB4q228GijAr9anZOUpGdwYna/YvTkC3V3y08552V9rhZjriV5rjcr+YIGFHgbbpM/WGXnkUVrqoeDe0vKjC5HaJygKTNQkBb5KdZj/cj60qniUlFPEbrtumuoIecng13jGxiaw9rvSkhu175H+Zqhx0yxHgH5h7/Fe5wCR6C/+Ol3lHnGaAEImA05PD6+XCGilVIAphYcQOVP8SkKvSMJVYZlMjypdtBP9Wit6bpE0oaZfW+L600TCov2+4Pw/dCCjpsRAenpf2HngKfDThiPQpHPb3SvduaAEll3Ntrh4cOYkjQbe/BYX6ReeJ7akoRV1vwpf3WDLov9x3aU3xxtvkVrVLcfvo1WO9PUOSbnUUaWf3G1GF+0+S3MouPIt9KZ5hiQhFcq/k4PDmE0EVwr7qY+Rjg/z6ZIV3etCofc9j0Jz4Ny55AcFm0OZvX1lkaADsXjwVQ1IhLWHBvT8OIeEvuP3YtsLWXIDQV1HqFmqKO42/wGjUjK/SwgDlHmSRjUoA2agfA95EIuNxEFB3z28GxlMJrlUrP8VN6x4LiCP3eYefJ4gtaD2S3CEUqNrKnTIRzE4YsndLUA+PduSD9BHpNa5DHMHWJWqpNs9y0PrWFZIEkDPNepBijaIu5iS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(122000001)(6506007)(7696005)(9686003)(53546011)(2906002)(38070700009)(33656002)(83380400001)(71200400001)(38100700002)(76116006)(110136005)(4326008)(86362001)(8936002)(8676002)(66446008)(52536014)(66476007)(66946007)(54906003)(66556008)(64756008)(316002)(5660300002)(478600001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjB4TDdudk9VT2lVS085TjVtMDViWWNTVjFZbTlPeURBYitEZktYMENMcmNM?=
 =?utf-8?B?QmFJTk5rbDhyYVVLSndsNEcwYTExWm9nTmJFMnhqYWxWQ1pvUWQzeWRrbDNy?=
 =?utf-8?B?Z05RbXM5ZVlGc2tTRlN2NkNkeFEzWXl6cGVKbUpaY2ZnajFNMkdWSzJsWWJy?=
 =?utf-8?B?RDBpd2xORTdZalNwc0IxUVY1TC9qOXhvNWhEcGVTSUxhZktFZnNoLzRST3pI?=
 =?utf-8?B?bUxMbmxtKzlMTEw4dWJEcTA4bFNvT29EcjhjRzJSa1dRK3Q1NWpyQjVuMkRR?=
 =?utf-8?B?NkhrRTc0UjJKUjZHcnZuM0U5b3RtWS9UUXlWZml4aGFMMVpMcXJoSnJpcURa?=
 =?utf-8?B?Z1BLWTNIMXh0bXNONlVtbURpSzNWVk53ZEg3WnlBdWpZcGR6YnBwd3hZYlRD?=
 =?utf-8?B?OUhzVTFNRzd2Zkx1S3VkQ3BpeDdXWWlaL1lWWCt0V1h6RVB2cFRWakNaeEhF?=
 =?utf-8?B?RzVnS1dQMEhySmNGbnhEZmdPMmFNT0M1WE0vM2dMYjN1cTAxalZXZFE1azlP?=
 =?utf-8?B?Q0Fzd1YzOEFKU3RDeHNxZEh2NVdCNjY2NUJnSWN0cFJyM2E2Zmo3ZkRvSHVX?=
 =?utf-8?B?TGhqY3N2eCt5WHhJc0ZRaUpsU2dHUHFVWnRKN1ZWbTNzMWplaEFmaWxsTnpG?=
 =?utf-8?B?N2Z6NXc2a2pJYVFlQ2wxYnVieStqZGh5WW5jVDVoaHUvV0VGeUNmYVk2S2pE?=
 =?utf-8?B?RU9DNVVwalhQaURxeXB1YWVxb1RIMzIxc1d0VW1NV1QyVmkrc2Y5VHFEWFdv?=
 =?utf-8?B?a21IOUY2NUwxNi9VeUNkamtYanRWMWFSMHluQ1gvYlBTKzFaSTZQcFg4RmpZ?=
 =?utf-8?B?MHo0M1FkWWE2bTRObHphRWxTMlQ2WnpLMGRFelFYcDA3VE9TVzVNaDVSRWdX?=
 =?utf-8?B?TTBxeVF5RVBaUjlWNHdPODFpZHcvdW90M21NY0MyVlJJK1hQb2RSSUhGNHVk?=
 =?utf-8?B?TTFvc0pBeWtKRTVQVVRlTkxVdHkwbTlRcVZpRk8wamdQU2tiTnlWTTQ2ZWZp?=
 =?utf-8?B?TWJ0U0lOc1BVRjRlTWRndFZndDVRakpuaVpkME5uUENpckE2SmFPREFPd01T?=
 =?utf-8?B?UzFSOWRVTTRCZmI5TktmOThVQVZpZVh0RkM3ZHlBdzRVdGZIWEMyT0t4ZHBr?=
 =?utf-8?B?Z3RqbFdXMEpZdWNjK0ZSWXVUV2N6VitlS2JLeEh4MjF1a1FJTTczSkpDK2tF?=
 =?utf-8?B?ZnRPTXR4SUpUMG5jVWpjT0Y4UzVSVFd5QUpibU1uSWcwSENRajdnd2piQXJr?=
 =?utf-8?B?Q2w5dUpmbE5rcmZUMVIyNC9RL3M0bWM4N3IwY0l3OXZQbzhObnB1WnRUWGNa?=
 =?utf-8?B?TGlsRHlrTFc5RTF1SWVmaXFodzIwZVdFV05yVjVpKzFoZ1BZSzZUSW1JaW5w?=
 =?utf-8?B?a2R5YWIrdElyNnlBanFLWjM5TDFxb3VhS0ZUQXFaQ2FKMmVVdncySW1LTEMw?=
 =?utf-8?B?K2Z0Vjc1Nm9odGVCS1YzdDVEUXpnN3VrY3MrMVpxOTdhTitVTm9jOEFIMzA2?=
 =?utf-8?B?eU1RcVlxMjNPUm9yUkQ3REJKUGxzMWgra1ZGZUZJSXd5SUNsRUJMWVZrV04y?=
 =?utf-8?B?aCsra0RORzhERVJGWHhJKzJNL0Eyd21haWUvYTlNWFl5Skp5Z25JZG9xU2s0?=
 =?utf-8?B?QWFaN2VsTzh3bHRpUWhOVElIdlY3YlVwdXh4VG1NU2tlVDJVWDRuMGR2aE1F?=
 =?utf-8?B?UGZ0ODlpeUZxNEVhNlpEYjhMYjJ5Q0l6QXNPSWxhMG5KOGVrTHlldk9za2Jo?=
 =?utf-8?B?QzJROGcxcndwTDBmdzJPcGczZU8zd2xsRUtZVExZdmUyalpHSDdTU2ZpbTAv?=
 =?utf-8?B?ZHd5UEtpeE5DcHdQemF3N1ZxN0FsWUlHdisvNElBQjN2NE9tOGhWTUMrOWxZ?=
 =?utf-8?B?WXFYRGM4a01lcTU3NTBhVXV0TjNDeFRKUjVqVGFIenBac3JlV0xMdlF1MGZB?=
 =?utf-8?B?azB0c2o2T3dYbDFXek9CdWt0cFdoS0NKY1pIcllpRjA2dzNUcS9TcWE5aXpR?=
 =?utf-8?B?Y2l5U2svS2lkSWwra3lzeGJVNWJ2c2JFOVlYU3VwQ3NuYWppc29iOFJ1cWxW?=
 =?utf-8?B?NnAvRnZDMVZ4YnQvUitZdUZzRmszUmd1ZExVdkxQajNzSHZPTHVFMmJxU1ZE?=
 =?utf-8?B?dWpINGtYT1UvSVVuWTRNeDh2NnB4K21VM0piUW1tRmgwZ3BiTU1VVDE4RitH?=
 =?utf-8?Q?Ipg4AQqZZScF0tCqj8VuVoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20024988-55f3-4d8b-73d9-08dbd5591b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:51:29.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30XsmUpZJkj6TxvUeXM7NKJzw3gfsdPFq7/o6ELt5xQ4sQ89E4j0pSthZfwLz5tGBNZePu3wHkTFv5QZgvkcoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5457
X-Proofpoint-ORIG-GUID: A34_IjpSD87_99eupF1hKk-X3V54nl6D
X-Proofpoint-GUID: A34_IjpSD87_99eupF1hKk-X3V54nl6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=423 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250111
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDA3LzE5XSBSRE1BL3NpdzogQWxzbyBn
b3RvIG91dF9zZW1fdXAgaWYNCj4gcGluX3VzZXJfcGFnZXMgcmV0dXJucyAwDQo+IA0KPiBTaW5j
ZSBpdCBpcyBsZWdpdGltYXRlIGZvciBwaW5fdXNlcl9wYWdlcyByZXR1cm5zIDAsIHdoaWNoDQo+
IG1lYW5zIGl0IG1pZ2h0IGJlIGRlYWQgbG9vcCBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
R3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X21lbS5jDQo+IGluZGV4IGM1ZjdmMTY2OWQwOS4uOTJjNTc3NmE5ZWVkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBAQCAtNDIzLDcgKzQyMyw3IEBAIHN0
cnVjdCBzaXdfdW1lbSAqc2l3X3VtZW1fZ2V0KHU2NCBzdGFydCwgdTY0IGxlbiwgYm9vbA0KPiB3
cml0YWJsZSkNCj4gIAkJd2hpbGUgKG5lbnRzKSB7DQo+ICAJCQlydiA9IHBpbl91c2VyX3BhZ2Vz
KGZpcnN0X3BhZ2VfdmEsIG5lbnRzLCBmb2xsX2ZsYWdzLA0KPiAgCQkJCQkgICAgcGxpc3QpOw0K
PiAtCQkJaWYgKHJ2IDwgMCkNCj4gKwkJCWlmIChydiA8PSAwKQ0KPiAgCQkJCWdvdG8gb3V0X3Nl
bV91cDsNCj4gDQo+ICAJCQl1bWVtLT5udW1fcGFnZXMgKz0gcnY7DQo+IC0tDQo+IDIuMzUuMw0K
T2theSwgbG9va3MgcmlnaHQuDQoNCmh3L3FpYi9xaWJfdXNlcl9wYWdlcy5jIGFuZCBody91c25p
Yy91c25pY191aW9tLmMNCnNob3VsZCBiZSBjaGVja2VkIGluIHRoYXQgcmVzcGVjdCBhcyB3ZWxs
LiBBZGRpbmcNCkRlbm5pcyBhbmQgQ2hyaXN0aWFuIGFzIG1haW50YWluZXJzIG9mIHRob3NlLg0K
DQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=

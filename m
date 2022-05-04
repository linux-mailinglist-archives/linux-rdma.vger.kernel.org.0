Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5151A270
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbiEDOqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbiEDOqU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 10:46:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66011260D
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 07:42:43 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EenfB014452;
        Wed, 4 May 2022 14:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=xOvIWCjSbpIUqqdsua+acXwXIm81YpXBh/v6AiR+JOM=;
 b=qKyG6+qBCPxquiXDaIY4STQanEIB0NdfDEPefDTv7Ay7y+vlErgv/Du2lZAlg0kgy7gv
 PQ0EkgRBuuNsNjI55YkVU4+5rofuepbshrdrUm6pjLn1i43IX1JIg9MNFGwPl41rnNkc
 rRhPFOCgKLwaN/mR1FrNpOhrm+BGBhlL3eJapUOaMoGzZ1Ek+Cd5kMDCIPx4BvXUcMpn
 TblKlMGJqxtKY7j3DClkO+8zH2j7fTHoNswLD0hXb2LujnUWd2tKlujrON/QIP/2q2O/
 99m2s3xz2J/yCGga1OD2kwPcBZIRBW/hrFHgZM+9vfwqYr52GxDWBOoL73+z2AdLZLJw 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3futneh61f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 14:42:39 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 244EgcH6022271;
        Wed, 4 May 2022 14:42:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3futneh61b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 14:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oChJd1fK90bhEynE5F7MJ/rHkmxBlVm+SmKKfHXYs6/E6Ir8HoXXAOCXvbpsdUv5FFAkp+YlX+ga5OGCZBfimbaE9o8lFo9PQLVVZWD9yLwjZRvIo8wxFkW74WC5YJLP4VuulOwmyonwiRExmbM2sE8zXIxKrAw5NS0+4TRtj90rz4OQxHxJ5QjKx9EcKxb4pdzQHafKfDCISXa+9YMiUo2Z8DGQYX/bxuTfiIpfKv8TQzVJ2JlE0On4YC9ftPFDbN1WYfpdJBOyOxaA1zwmybVxroBRpKyK0lxw/qPZiGfK1ce/4IVlJC+rBgSQhEDqpjRqU8a6Kt5UOy+gkiuQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahoe41iVRKzzj8w/rS//BdqpjG8Zh9wySkk65vDob0M=;
 b=YxHN0EeQM0WW8az54SFcLuwx+Lh32l1RSym7y3sLLIbJzvhdnA+qSVRkd2nfMpcvZPEhHrlRhHnkr114DMjbfvuGhS07tCxP2XJh9OFBO6I1sbuq34Rn3+KmwVYt/ND5XjXbFylOqc9TLGcBhgt9SWp+MlxTOasZBPSP4n9Xp3BdV/+TC1KJbfhMI3JZMbLDA5Js+32NqGehlGAckNjZ4R5HbPWXEvpCrZdTP+GHryeG/LcF+0nOeJJk20wEvyjH4o2+we6Gs652g9aJGblnv6bQb5FgdngSSUZcutPWTZU/jPMifNHaFHJliCVjbtpydB6UTUs5ih3cKSjNj2w4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BN6PR15MB1729.namprd15.prod.outlook.com (2603:10b6:405:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 14:42:37 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 14:42:37 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Fix a condition race issue in MPA request
 processing
Thread-Topic: [PATCH] RDMA/siw: Fix a condition race issue in MPA request
 processing
Thread-Index: AdhfxSyzCLm9LmpHRg6M0U2VrVHvfg==
Date:   Wed, 4 May 2022 14:42:37 +0000
Message-ID: <BYAPR15MB2631BAFC4CA45510B933ACCF99C39@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db4892ec-8418-42dc-839b-08da2ddc5548
x-ms-traffictypediagnostic: BN6PR15MB1729:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1729AED7E5A08B17A117482E99C39@BN6PR15MB1729.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1nXF1lCAiWDA+e6C/xLUL2J7xGHOL+2tsJ/CXVVU1Ym8ooRIqjvMW2ay4yV7V0noYX/obKnVgo7dZwkb0pfvU2M5fjTw358Sto98utAefyGFJ6VjaxXkXdMtCBzrmfNI8ix9XI5rCiUe3rRfh4Gb2wLN9p8z5+4PbdHzKKubYPC4eNaMpwy1CAQAgUJR7KomAMNyFoYzNRo963Pi+CkA5z/KZRTUnprSQIOHlbL1RHnPJ2kl8qaOjeoZSbGVKxGkSbHzn45+Sif2Blo4trcdmtaS5bGRijFGFZ6QOz9fa+FZ0P5FHrWvGjEmZlDWRYF9jpXy75X6BJBAqWu34MVOAAcebe5sBqtTDFdjkUl0PSCXgAm0GolW7DPav8I7CYsP6tBwPootDJrap6CxY03z2pwbCFc9EZVRMp9Wp9w0bDcWGWUc7RBouCIlME+xgvxWgHL5U4sgbaC9ZmemPPAOvc0/83ROrMzZtW6cPa/ZgqswAA3b5a/P6vJ1eM+rdd/5B9kwf08ceXufk1+PQK7ccpowMmrqg5X3uvGrCMhjfriz2QmVfh4W23h8FtGAxNj7JKeAXK6H1JEFy0O1q5kCXailSDihS/ibBkG3o/5k2jpMTOqYFQg1mrIA2u7WrZROhn89wtugzHPrd6MnldB+IIh0fFVjbc8Zz8fMWWPnxaICxWtw/dfwDNRrUZHBAelKTqERL1fQUnnrn39BoFxg45gIEuISHylPJqF3nFOAbvFgLI30ApL/wjmbb8I39Jan94nu7BS/kk0RJEQiAbi97OfPeVeBmZHaPoemTMjdmMsuZHEydsrV5gBsS4GI2pcf9prjJL2aRGEKeOFETXPig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(71200400001)(86362001)(38100700002)(38070700005)(966005)(186003)(9686003)(4326008)(508600001)(64756008)(122000001)(66476007)(66446008)(66556008)(8676002)(76116006)(66946007)(6506007)(33656002)(55016003)(7696005)(8936002)(5660300002)(316002)(52536014)(110136005)(19627235002)(53546011)(46800400005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU1PMlBESTVubnlFekhYbEVnSGY2bHB3cTVOdTlEbGZHTVQyazlWWXRwUzRy?=
 =?utf-8?B?RTdGV0RWbkw1dk5jeit0cUNKOVNhblR1cEhaQVh6aE9xRFd2ZTIyTEtiSVpi?=
 =?utf-8?B?Sm5BY2hWQXlyZzNjTzIrZGlUVC85d29md1Y0SkVuS3BVdFVEdThZRG8zbEEz?=
 =?utf-8?B?SDBRbVZaWHBGbXlHdFpQdHhpeEtncG1SbFVsdlVlSmErMTVVcHQrc1BMT3gy?=
 =?utf-8?B?aTB2dzk0bk03anZ2SE1IMTdQV3NFb1hCVmFlRmVpbkQ5eDlHc212Sk55VmVE?=
 =?utf-8?B?V1lQQ0ZUNmFNVjluRnNhR0thWjZTSnpQUm9ZaUg0TS8xd080MUw0Sk9LY0VD?=
 =?utf-8?B?YnlDZFQrWEFHOER6QjYyaXBFOGV1MHhpb0txNXF1VlZjVmEydUdEeG5HcGpZ?=
 =?utf-8?B?Zy9YYVV1VXhFNmk1QkdtRXFYZ0xIMFljLzIxVVFFcVZTM1NXdDFzODRSeGlS?=
 =?utf-8?B?WjdwL0NUbkJhRHNDeFI4aDJ3RU9xUG1TOHNQMVNBSWpJZE5IaTcxTXd5R2Iy?=
 =?utf-8?B?SjA2R29SaFB4ckNwYVhKZFdKa3Y1VVBUM3hIZFNkZnRQWDFYZGRadnk3Qmtj?=
 =?utf-8?B?Z2h2UC9Ya3pzMEt1eVkxVjViQnozcndIaVVXTXlWMlB4dW84S3dHWjJRNGkv?=
 =?utf-8?B?M1NIeUdtdS84djZwNTAyQ01lRVEwY0gxYm5oS01mbzZJNitUdXFrblJNdmln?=
 =?utf-8?B?RjI2WHppeDI3WVBWMXZXSC9NaHlCY2E4eFQyWDRLVTZRVUNRQjRySFJhczhB?=
 =?utf-8?B?SEd3TGJPeFhQMFNYblVHOXBhWFQvYXZiK3dERzZuZnFKY3N1MmJRZHJmemd2?=
 =?utf-8?B?U3RyZHI5TkJHL2t2SnRqNEkyeEdBaXUwQy9NTEhjc3RTVXRwV3ZHdTc1TUNq?=
 =?utf-8?B?RThFVmZ3TmdSMVNBaUNHMnVLTVBES0VsSFVhVDZTUHM2b1l4QlNWeHVET29u?=
 =?utf-8?B?RlNOemxhU0ZqQzhURkxCRmtJazhqWTRlNFlRTytYMCt4aVZENU1QNzdPL3kz?=
 =?utf-8?B?L0FBdzdNb005RzNYd3JDWVc1SEQ5Z0hyaWkwYTluTEFJN1NQQmo4Ty9QMitH?=
 =?utf-8?B?TUtsbFkydTViS0RwTTJvSU53T3Y0aFBKc0pmbDVWQzhuWU1OaE4rVDY4dVVE?=
 =?utf-8?B?WEVSSjd6dEgyK1ErZzZSZ1NlZFQ1WURteWdua2Z4OEFxei9KSDQ5cm01c1FH?=
 =?utf-8?B?U29nZEI5M1c3UUFnMmNmN3BZcmVRTU92Y05IU1RFcWo1dlQvTmw4MTd4WWtq?=
 =?utf-8?B?eHEzemNwc2I5ZEozQXJZNWxZM0RpQTRrSDcyVVU3bWxBSS9OamtsVTVCYXls?=
 =?utf-8?B?emtacDRBOWZNN3JrM005L24razZaa25yakJadGdHUi84ZG9YVkw4dnQxaGpv?=
 =?utf-8?B?aEV5K29jMDlQNXlycnhBS3hKUm5OOEJFeFY2NERITVBVTW0xOVdDZFdVc3V4?=
 =?utf-8?B?TFMySjZrWGw5RDhsVTNZdkt3RXhVQzMvYmxjVVhlbi84SlFLY2ZmazQvRzNT?=
 =?utf-8?B?NlJwUGZCdGtuRDRSSjlMNThaTDd5M0hybG03SFdoNTc2TlBjSWliSlRNZWx1?=
 =?utf-8?B?eGJWRkhiNTA2T3U5MEMrNTROaDQ2cCtna3o5eFdmOE5NaytETW9udlhaUm5n?=
 =?utf-8?B?Um1UYVBCNlYycjVFRGtROVlkKzg5aGRRcDZtYzNIWk1KT0p1a3RMb3JnM3ND?=
 =?utf-8?B?N0NLaVFFRVpKQ3RFWGo3SWoyYlEzbklYWXlUclJVd2dpTmE2YVBXVm1mcGZz?=
 =?utf-8?B?dk9lYk82OTVuOTFiV052em1BNlhWSW9OU1hUZmEyMWk0QTgrKzhPcE8xMG9K?=
 =?utf-8?B?WXdQL1AyaW1mUTA5bCtHNFlsa3Vjbjgzc3I5dWhqZ2xISXo3NlFjeTlHMEhu?=
 =?utf-8?B?TnpYTG1FTjNyZHNsT1JUc1BlRXk3NWVnQ05rZnUzVUNOSFgxemRwTWRBK29j?=
 =?utf-8?B?aHlmZzI3RFR6VzU1L0Nvdnc3TVBuVnJSekhReFlGY2Uxc3VNSU9ObzhXa2E3?=
 =?utf-8?B?dW8vbWdTVXFHYjZWWkFtUWlsQ2x5d0U1TmhEN1dFM1NQY3J1MllDN1hyYzQ4?=
 =?utf-8?B?RWdUVDhtb1JSdm56UlQ3NGJXUWlOYWxaSE5IVHVEM2pGNXRQdzVVSE5MS2ZK?=
 =?utf-8?B?OTFINXVpY1pXaXZmRUN3ck9XelVyQjZYV2thVmh5SkJxTGR3S2xXTUlrcEdU?=
 =?utf-8?B?QjZRVkVyYmtXeTdGYy9MRDJGM2szQWtTQWhScmJHd24yZjVvRVNmUE1weUVo?=
 =?utf-8?B?c0oyRE5HenhKZ2tjaFhOUVRYQXFiR2dJOHhxR1BnbG92dXpDbm45YUxaWExK?=
 =?utf-8?B?S1paSUN6OFNER0FVM3V5ckVtWDdKTDNpcUg0ZkNGZkxUbmVMSG0zRDczQlZM?=
 =?utf-8?Q?2j4Dmeb8FxkW9jlCmcSuThwjulKyfm3PQyjYb?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4892ec-8418-42dc-839b-08da2ddc5548
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 14:42:37.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do7ielFhHlPRkFoHtL85LWNdWWJKhW4eyc4XrMmJoJQOlLKGFGR7oquspztndUCuIZ+/ACQjwXgBwK2ByicOOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1729
X-Proofpoint-ORIG-GUID: lf6MVUecLprVjMaz20VCQlliPhCcYhr2
X-Proofpoint-GUID: 0LjdT1jNA-tupc_I9l7JdIU3_fan7nJr
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW5nIFh1IDxjaGVuZ3lv
dUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogU3VuZGF5LCAyNCBBcHJpbCAyMDIyIDEwOjAx
DQo+IFRvOiBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZzsgQmVybmFyZCBNZXR6bGVyIDxC
TVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgY2hl
bmd5b3VAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIFJE
TUEvc2l3OiBGaXggYSBjb25kaXRpb24gcmFjZSBpc3N1ZSBpbiBNUEENCj4gcmVxdWVzdCBwcm9j
ZXNzaW5nDQo+IA0KPiBUaGUgY2FsbGluZyBvZiBzaXdfY21fdXBjYWxsIGFuZCBkZXRhY2hpbmcg
bmV3X2NlcCB3aXRoIGl0cw0KPiBsaXN0ZW5fY2VwIHNob3VsZCBiZSBhdG9taXN0aWMgc2VtYW50
aWNzLiBPdGhlcndpc2Ugc2l3X3JlamVjdA0KPiBtYXkgYmUgY2FsbGVkIGluIGEgdGVtcG9yYXJ5
IHN0YXRlLCBlLGcsIHNpd19jbV91cGNhbGwgaXMgY2FsbGVkDQo+IGJ1dCB0aGUgbmV3X2NlcC0+
bGlzdGVuX2NlcCBoYXMgbm90IGJlaW5nIGNsZWFyZWQuDQo+IA0KPiBUaGlzIHdpbGwgZ2VuZXJh
dGUgYSBXQVJOIGluIGRtZXNnLCB3aGljaCByZXBvcnRlZCBpbjoNCj4gSU5WQUxJRCBVUkkgUkVN
T1ZFRA0KPiAzQV9fbG9yZS5rZXJuZWwub3JnX2FsbF9ZbGl1MlJPSWgwbkxrNWwwLQ0KPiA0MGJv
bWJhZGlsLmluZnJhZGVhZC5vcmdfJmQ9RHdJREFnJmM9amZfaWFTSHZKT2JUYngtc2lBMVpPZyZy
PTJUYVlYUTBULQ0KPiByOFpPMVBQMWFsTndVX1FKY1JSTGZtWVRBZ2QzUUN2cVNjJm09UXNQZ3lm
d2JUTkFpNVpvVnppX05LQi0NCj4gTDNSYk1TZGdqRDYyR1BkcVBrdV95UXhlSUJZT2NCUVVjYk9M
QmtiXzEmcz1wR2JfakdXMG1yR0hqWFpDdmFnN2RSZEhUMFJBDQo+IFVhcXVUMTVBeWVBeTRyZyZl
PQ0KPiANCj4gUmVwb3J0ZWQtYnk6IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3Jn
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZyBYdSA8Y2hlbmd5b3VAbGludXguYWxpYmFiYS5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYyB8IDcgKysrKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBpbmRleCA3YWNkZDNjM2E1OTku
LjE3ZjM0ZDU4NGNkOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfY20uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IEBA
IC05NjgsMTQgKzk2OCwxNSBAQCBzdGF0aWMgdm9pZCBzaXdfYWNjZXB0X25ld2Nvbm4oc3RydWN0
IHNpd19jZXANCj4gKmNlcCkNCj4gDQo+ICAJCXNpd19jZXBfc2V0X2ludXNlKG5ld19jZXApOw0K
PiAgCQlydiA9IHNpd19wcm9jX21wYXJlcShuZXdfY2VwKTsNCj4gLQkJc2l3X2NlcF9zZXRfZnJl
ZShuZXdfY2VwKTsNCj4gLQ0KPiAgCQlpZiAocnYgIT0gLUVBR0FJTikgew0KPiAgCQkJc2l3X2Nl
cF9wdXQoY2VwKTsNCj4gIAkJCW5ld19jZXAtPmxpc3Rlbl9jZXAgPSBOVUxMOw0KPiAtCQkJaWYg
KHJ2KQ0KPiArCQkJaWYgKHJ2KSB7DQo+ICsJCQkJc2l3X2NlcF9zZXRfZnJlZShuZXdfY2VwKTsN
Cj4gIAkJCQlnb3RvIGVycm9yOw0KPiArCQkJfQ0KPiAgCQl9DQo+ICsJCXNpd19jZXBfc2V0X2Zy
ZWUobmV3X2NlcCk7DQo+ICAJfQ0KPiAgCXJldHVybjsNCj4gDQo+IC0tDQo+IDIuMzIuMCAoQXBw
bGUgR2l0LTEzMikNCg0KDQpXaGlsZSBJIHdhcyBzbyBmYXIgdW5hYmxlIHRvIHJlcHJvZHVjZSBp
dCwgdGhlIHBhdGNoIG1ha2VzDQpzZW5zZSB0byBtZS4gSXQgZml4ZXMgYSBwb3RlbnRpYWwgcmFj
ZSBjb25kaXRpb24uIFRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10
QHp1cmljaC5pYm0uY29tPg0KDQo=

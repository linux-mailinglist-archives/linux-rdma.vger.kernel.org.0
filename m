Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1987D6F58
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjJYOcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjJYOcP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 10:32:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD599
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 07:32:13 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEFBnA016044;
        Wed, 25 Oct 2023 14:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=d9POsOY9K/kE0I+ib71gNteYpD256y+hPcL3lZbKmGw=;
 b=jom0fs0KdEMg4QDvCZKMSSeXBgegYGgqoH3yvwsmrXywy7pF2necyGOLXHWh3W8UhuV5
 /AU13ZanTNfvhSn0rFnYFCEIt/cXXmPFnh5W7A4wvSlNnDDiU4l1QCS8YvgeTYzlkI50
 3Wndx7WrXtT93cAv0FAX+csbQV9d/EP6zozUiHF8Cpap3kG4Q9X6/hP5rIo6El7q3rdU
 Tlip0lUyppDaVbNxF997gqkfYwAwh5PBTN7c+LXJ8Evr9ubQnDJkK0byqM88jyOO8Tu6
 XZaFzP8N7xAFOGLDLZQEhEGsZnytOBLYUEvoCiMuynqHFKPxxeRJlT+mxAztFictm+Bw 7w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty4m70k9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 14:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWGC4RLeezveWtdsv3z12r2seMiwPdJKNTN2lEVq44loO4aDhqCqxD+DVmfrOg5y/x1ka2rkGcTY7emmvpFcSvlD1W1ta4Fu5+a/ZW/MZzIfM/0GFtndyZf75bbgT5QphTRHkjMtNLcPvYf6QYxsnSB1HNSuKYmUQUS9YXiqC9m7HOrAdq1D21NLTKtGLlRQAj+mtenJivvRnNeia/gNlLt/0rkp7Z/9sa5/LR1oqmgdlqoAzL+wSqhK9VRQaXwjavWdfeN1qaX0qkVMBHhXaE0VxGkJ39t3wOQiEkirG0ctt7hnuSJAu6AEr+opE/YQazykhtUHfwMEH4BIsvomqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9POsOY9K/kE0I+ib71gNteYpD256y+hPcL3lZbKmGw=;
 b=ktbi5nqqMtzo/b3yIAxQzdyTLavy5uAnqPaopP+/yfiT8mdz/FWAp4hX5jUWG9RVdj9ZNWurGntRBkPRyoU3egbS/ytd3N5368oJcO4OZ0l3fJBQgAjVgGdOLTtgH/60D2W81LEHxrFCHbA4LGy6sEYwauafyISWysgK68wvK63MrpszeHwzH1fmqCQ0BAe2vDUPNBWkn3ePq1WHbd74oJK4HVKbwz7TvUjOOknUvIlb4o6TzOFP+lOsiqp1817aZ3f0jiMQSOg0/fKlol36OZwyrnsdYzOYUyTJvmE0NWSXySwxOohTNpW5YdNPysKiVkkr8vyz/o4JIFJelqG6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA1PR15MB6448.namprd15.prod.outlook.com (2603:10b6:806:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Wed, 25 Oct
 2023 14:31:08 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 14:31:08 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [bug report] rdma/siw: connection management
Thread-Topic: [bug report] rdma/siw: connection management
Thread-Index: AQHaB0/lhi8cR2sfaEiHIV7ckKpDZQ==
Date:   Wed, 25 Oct 2023 14:31:08 +0000
Message-ID: <SN7PR15MB5755E7EC735931F3EA1DAD2699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <e2ef5057-fe85-4fa4-bcbc-2e7c34680fb1@moroto.mountain>
In-Reply-To: <e2ef5057-fe85-4fa4-bcbc-2e7c34680fb1@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA1PR15MB6448:EE_
x-ms-office365-filtering-correlation-id: 09c48a35-a7fc-4d45-1c99-08dbd567077f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODXj+P4zSQjT8SyJw/qBfF+QdGuf4ZQ99+Y2/zEhVcumzgUPV7one6G82RzsqCFN287PjUSyLiRk6GEDmQBm2ZK/jmA4GIfOsF8HhRZR8gXz5jBv4fXQt8dO2ZDTbdzj0+Ma1UncFUQ76TPpQjTt1QEB0n3weqocGp0foU1UkAO3Z6ZWKE9mpTStF4haJOA4HabDpBjcVD7Wv5GpgRrOw/ocwDadG2Og32vPhU+rNuwp/PDEYw7SS8I02LMzpO73aV6UtHvUsrB/DajhmIyqj5uKAxCYUnKShp5uCcXxR53hw+GZenLYWEmekGpggdZ3rjv1qwIjlgpv8pSEhP1K/GTnsuLX1rZUkhB+DKnlyIpryjycd4B3kNHA44cMU19d7wcEiOsBvNc2KdzTlMlWHFPROHtO7uJX4ybnT+Apfv1fNcD1Ra01K3kT8u6AFOE2IjXrBcULeDjZHhzw5e8IIr7gXTaesmZ0LJNb2pHH862WIrvdR2B6Mn6wXkyILAu7j3iOta7Skoi9rtnWPQWeqspNrTpoLuLu1XS77iPjpgkpheqlTfH+zzJsHoHbTGqZZoXF5wVpBJBOzFQUnVaT9z+DiaIIAxiYNiOQCB+FMuLsOVCC483Pa3tCq4CTirNH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(316002)(53546011)(55016003)(66899024)(66476007)(71200400001)(64756008)(66946007)(76116006)(478600001)(38070700009)(7696005)(6916009)(66556008)(66446008)(122000001)(38100700002)(52536014)(8936002)(9686003)(83380400001)(6506007)(4326008)(86362001)(41300700001)(5660300002)(2906002)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGlSSTI4aHpUQ0UzQm9qa0FNVk51M0tQVDgvRXhRQXhyK011cU5EdWdYVHZu?=
 =?utf-8?B?akRjcVNkOWEzTjBNVWZ5Qnl4cnRHbmlERnFNSHdSL0hRNzYvVHV4Ukd0TXg0?=
 =?utf-8?B?ODB1bTJTSmRPSGM2QjE2LzZkcnplaExNWUhGeGdmQ2lJblhnYWtILzNRMzhq?=
 =?utf-8?B?STR5NEo5aVpPTVIwbDI4aDhpZWJCQW9sL0wvTE56RjQ4dVRaU0pHYnBWS1hD?=
 =?utf-8?B?OXhLRE5oSW1vSDBqTG1PbVVIcUNRYmNZYndaa3FGUExzTEFRaTJ1cmg3V0w5?=
 =?utf-8?B?T05jTmFLVm1Ob1ltYmhyUllBOVJLT1RlSjBkMklVTW9SZUJWUzR2RlhuZE5t?=
 =?utf-8?B?d3prS084NjgwVGtabWhBM1lHbGVTSTVzOUROZUhDSUFScUpGbFdMd1NNNlF0?=
 =?utf-8?B?ek53NElPLzhCUTBDdWlKcksvbHR3V3VIaWkvdk5UZnFiVnErdDBUclEvMkg0?=
 =?utf-8?B?WU41QmZYSk5oUWVCSHRVS3JKMWEwOEowMXJobTFGSEEwRldFd2VPMVEvMUph?=
 =?utf-8?B?N2ZEUU9MYkNITVNYK1p6c3ErUXJLVnVadEpYM2piUUlWV3dXRDFCaytjNisz?=
 =?utf-8?B?b1lhTFl1YU9NM29vOHVvL01ZL0N2M1hLVmZBTkVUSTY0RUZ5WDQ5b0dGQjBt?=
 =?utf-8?B?OXBjOFpKbzlPdU1oNmdnUG0wajBaNjd3UXZPczFQczdEdjU0amtwd2ZkV2Vp?=
 =?utf-8?B?MXprTTc1R0RtSkZ4YlBNSEQvcTZtLzQ1VXNrVGZ6cnZRN3ovbjFwWXNXWXI2?=
 =?utf-8?B?aWtpSExlRm5BWmVUSGpmdU8rbzdWeEEvcnRmYzhVaTZQcTJBRncrVDR1VEpE?=
 =?utf-8?B?T2pOYXhmVVZHVThzR051N3VzYTZTb1M3ay9scHVtQ2d0cUxkTnVhUTBkM3hi?=
 =?utf-8?B?VFZ1Y2d0a00rSURMQklua3RFbzdtSGEwL05LcVhsZnQvZHY2V2tvdDNJbUoz?=
 =?utf-8?B?emhhN2VMMUEybm01SkhKRUNNdFpEYlVkYjhZbHQ5M1NvTkpKbnZPdkk0M05N?=
 =?utf-8?B?QktSYWlSQTJZWWxlZmFib1kxRXY4U3VEcDRXeHJMSWlzeGpQdktrNlJGYTZO?=
 =?utf-8?B?cmh4enBKL1p1Q29PckxMaUlzSVlyNEtkWEpydlArOFRGcTlMQmV6NlhvcVh0?=
 =?utf-8?B?S3ZrYXFOa2ZEQ0pkRDhWaCtqRUdXalUzWkhMaVlnQmFwSWMvTU1ZOVQ1elQv?=
 =?utf-8?B?dElGMjZuMmdzWlJqVEpZWStlR1Jmdlg4RStvYWh3SXhEblBvTWpTYVljb3BR?=
 =?utf-8?B?bDVnME9uOFZ2S3Q3dEZGWnNTdm1wQUNZRWdhTWNwVkNtNVZGTGtKbEhUcnZT?=
 =?utf-8?B?OHY4VEZ3WER3bFEycHVkY2pVZUx4RDJicFcwSmtQYW93VW9JZkpYczFFb0xM?=
 =?utf-8?B?OU9xUDdTbHZyWnd1YXBWOGw0M1lOWW1DSCtCUDNJbUwrNEEzeXYrWHFOTk91?=
 =?utf-8?B?VHVqMXg3aDQxMWNLUCtYWW1OeGs3ajhZWGZyUENLbUhXeUVRZ0JWTllscmxu?=
 =?utf-8?B?cVE5ZGlMNlpFMHB2UEZRbTJnMnZyeVdlc253QUUreDdmd1ZpUUI1enlOd1d0?=
 =?utf-8?B?ZHJ3R0UwZ0tCb2FEOWZXY3krT0xCa3p2ODQ4WkprbzZ0ekhKcndFYVpkcVJs?=
 =?utf-8?B?dnphaFBjTjYzdm1NaGdML2wwcVBzVjk2bHFqWGZha1IweHVDR2Q2dlNpdkxQ?=
 =?utf-8?B?UzRJSC8yb2xWMUE0eWhZK0IyWTlYZXJ6OXhTWXhxN2wyK3JEcGtIMWtHRnVo?=
 =?utf-8?B?UTFFcFltOEZKenFOWU9TOXRUem5EbUZNRW9nVHdhVFVUNDBMWGY5Mk56dnkx?=
 =?utf-8?B?aUhhR3BXWkw5c1FoODNjdnpxSytrVlZNcHlCMXBZQmFBdkZLV0VWYU54ZVVi?=
 =?utf-8?B?MzFMUW1peS9Rai91ZjhNbTFGcm0rR0VCbXBUTkpoTmRiMmk3TFc2NFFmV1BH?=
 =?utf-8?B?VVVWVWxoWTVjREJ3UVVIc0xkYWJnaXM0dkdWMnpOSkNuYzRuVVpyK3dCUkZV?=
 =?utf-8?B?RVN3QnRCYkxCeStQdi9xSkNEYXVxSTVablFaMWI1bk9QUitzbDRvajdtYm5L?=
 =?utf-8?B?YXJVRU5jcUJvL2o4UVhKUEJ1aHZPdERRelk2Si8zSmZCZHZhVzhBY3YyWWd5?=
 =?utf-8?B?QTBYdGdHOU5hMG9lbVNKZXBlYythMDZYRGZQTWRLM284OW9SSGRJRFpqeEUv?=
 =?utf-8?Q?H8hAryKanNVgD58wvxpPvAk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c48a35-a7fc-4d45-1c99-08dbd567077f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 14:31:08.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP1sKVwHWvaUzxff1c4E20Ok16ajPuNtj8EC0luCQpLXHcO8U3vNX+D13tXwDuYBJxCRBbXTSmGkT2m3f37cpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6448
X-Proofpoint-GUID: szSLjzRqK9HJHR4HG0QI4HIE4Z10nD0r
X-Proofpoint-ORIG-GUID: szSLjzRqK9HJHR4HG0QI4HIE4Z10nD0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=688 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjUs
IDIwMjMgMTo1NyBQTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFtidWcgcmVwb3J0XSByZG1hL3NpdzogY29ubmVjdGlvbiBtYW5hZ2VtZW50DQo+IA0KPiBIZWxs
byBCZXJuYXJkIE1ldHpsZXIsDQo+IA0KPiBUaGUgcGF0Y2ggNmM1MmZkYzI0NGI1OiAicmRtYS9z
aXc6IGNvbm5lY3Rpb24gbWFuYWdlbWVudCIgZnJvbSBKdW4NCj4gMjAsIDIwMTkgKGxpbnV4LW5l
eHQpLCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIFNtYXRjaCBzdGF0aWMgY2hlY2tlcg0KPiB3YXJu
aW5nOg0KPiANCj4gCWRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmM6MTU2MCBzaXdf
YWNjZXB0KCkNCj4gCWVycm9yOiBkb3VibGUgZnJlZSBvZiAnY2VwLT5tcGEucGRhdGEnDQo+IA0K
PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+ICAgICAxNTQ1IGludCBzaXdf
YWNjZXB0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVjdCBpd19jbV9jb25uX3BhcmFtDQo+ICpw
YXJhbXMpDQo+ICAgICAxNTQ2IHsNCj4gICAgIDE1NDcgICAgICAgICBzdHJ1Y3Qgc2l3X2Rldmlj
ZSAqc2RldiA9IHRvX3Npd19kZXYoaWQtPmRldmljZSk7DQo+ICAgICAxNTQ4ICAgICAgICAgc3Ry
dWN0IHNpd19jZXAgKmNlcCA9IChzdHJ1Y3Qgc2l3X2NlcCAqKWlkLT5wcm92aWRlcl9kYXRhOw0K
PiAgICAgMTU0OSAgICAgICAgIHN0cnVjdCBzaXdfcXAgKnFwOw0KPiAgICAgMTU1MCAgICAgICAg
IHN0cnVjdCBzaXdfcXBfYXR0cnMgcXBfYXR0cnM7DQo+ICAgICAxNTUxICAgICAgICAgaW50IHJ2
LCBtYXhfcHJpdl9kYXRhID0gTVBBX01BWF9QUklWREFUQTsNCj4gICAgIDE1NTIgICAgICAgICBi
b29sIHdhaXRfZm9yX3BlZXJfcnRzID0gZmFsc2U7DQo+ICAgICAxNTUzDQo+ICAgICAxNTU0ICAg
ICAgICAgc2l3X2NlcF9zZXRfaW51c2UoY2VwKTsNCj4gICAgIDE1NTUgICAgICAgICBzaXdfY2Vw
X3B1dChjZXApOw0KPiAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eDQo+IA0KPiBU
aGlzIHBvdGVudGlhbGx5IGNhbGxzIF9fc2l3X2NlcF9kZWFsbG9jKCkgd2hpY2ggZnJlZXMgY2Vw
LT5tcGEucGRhdGEuDQo+IA0KPiAgICAgMTU1Ng0KPiAgICAgMTU1NyAgICAgICAgIC8qIEZyZWUg
bGluZ2VyaW5nIGluYm91bmQgcHJpdmF0ZSBkYXRhICovDQo+ICAgICAxNTU4ICAgICAgICAgaWYg
KGNlcC0+bXBhLmhkci5wYXJhbXMucGRfbGVuKSB7DQo+ICAgICAxNTU5ICAgICAgICAgICAgICAg
ICBjZXAtPm1wYS5oZHIucGFyYW1zLnBkX2xlbiA9IDA7DQo+IC0tPiAxNTYwICAgICAgICAgICAg
ICAgICBrZnJlZShjZXAtPm1wYS5wZGF0YSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeXl5eXl5eXl5eXl5eXg0KPiBEb3VibGUgZnJlZT8NCj4gDQo+ICAgICAxNTYxICAgICAg
ICAgICAgICAgICBjZXAtPm1wYS5wZGF0YSA9IE5VTEw7DQo+ICAgICAxNTYyICAgICAgICAgfQ0K
PiAgICAgMTU2MyAgICAgICAgIHNpd19jYW5jZWxfbXBhdGltZXIoY2VwKTsNCj4gDQo+IFNlZSBh
bHNvOg0KPiBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfY20uYzoxMTQxIGVyZG1h
X2FjY2VwdCgpIGVycm9yOiBkb3VibGUNCj4gZnJlZSBvZiAnY2VwLT5tcGEucGRhdGEnDQo+IA0K
PiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQoNClRoYW5rcyBEYW4uDQpzaXdfY2VwX3B1dCgp
IG9ubHkgY2FsbHMga2ZyZWUoKSBvbiBjZXAtPm1wYS5wZGF0YQ0KaWYgY2VwIHdhcyBvbiBpdHMg
bGFzdCByZWZlcmVuY2UuIEl0IHRoZW4gZnJlZXMgY2VwIGFzIHdlbGwgYW5kDQpubyBmdXJ0aGVy
IHJlZmVyZW5jZSB0byBjZXAgaXMgYWxsb3dlZC4gVGhpcyBjYW5ub3QgYmUgdGhlIGNhc2UgaGVy
ZS4NCg0KVG8gc2F0aXNmeSBTbWF0Y2gsIHdpdGhvdXQgY2hhbmdpbmcgZnVuY3Rpb25hbGl0eSB3
ZSBjYW4NCnJlb3JkZXIgYW5kIGZpcnN0IGV4cGxpY2l0bHkgZnJlZSBhbnkgbXBhLnBkYXRhIGFu
ZCBwdXQgaXQgTlVMTA0KYmVmb3JlIGNhbGxpbmcgc2l3X2NlcF9wdXQoKS4gSSBkb24ndCBsaWtl
IGl0IHRob3VnaCwgYmVjYXVzZQ0KaXQganVzdCBzYXRpc2ZpZXMgU21hdGNoIGJ1dCBzYWNyaWZp
ZXMgcmVhZGFiaWxpdHkuDQoNCkJlcm5hcmQuDQo=

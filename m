Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52357D9886
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjJ0Mk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbjJ0Mk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:40:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4201B9
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:40:23 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCbxh0017101;
        Fri, 27 Oct 2023 12:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WRo8BGtlG/0zgzVRdLgRADvlF31j0pGrap3QdLofNAQ=;
 b=ZcdoN/pQMq11WYD0zhHfTpmy70WqJEXd2HtRWcaN5hE4L/3/SCx7upLaRRu6JAg2Sd4h
 GwB4bA8YtvxRCoXJ6jbIxf/aILNOkt0i4SnfwxCI/m+tq+Rs743YVexe5gvSIOSWYTgS
 Mkf1U0CO2QC35XJhIg/7JYvjv0S/QOTA5ncLg+W92wUeIupEUKyxw3kHPYuNd2rrOkRn
 gMGb7MNcxyL1LdHa1MmeSznLxUxgiz6YKlNWCvhWx2sKBJpcPT+htfRVvzQoz98cnswb
 CbSLrjjjiPB54JhlNwtCVXFJnfghqUIh3IagE3h85uCTlqJCNgK3Q9JFXZ+igFX68TXQ tQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0dcf02d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/ouCAGGbaeXGkOtweDOL98H35jfmJeBgDGM9rGU5WkG7flhTbTDHiyszNP9ZG+mEW6g9U+Uul0ZhTlzM3RQ51LO+SaAiVZp3o4nXcnPsKLgKt5o1WBG5H3UUPBdVRuD0ugwl2rDga1vq/9NYk4IV3wUXQVP2x/RPOiYTYc4ZOVf0jpp3s97zRvLPzkhnrgE8bJeLCl06khn5PlJRN6diUz1CNldMmY75u+k3apFkOZqAI7d4AY2aAaaL4b8A9XTB95QjJ5paU37GoGzpIC9k5xVFg+obiM6cNzjbPEwQ94APaQPNdb2eTtBS/DmrkTCbsKQKzXEv8UAle+5XcNBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRo8BGtlG/0zgzVRdLgRADvlF31j0pGrap3QdLofNAQ=;
 b=Dzil4JByBf8uiPc33pZE6+ASeQ3DJp0DP+3mLSbfhkbo936QglLprxNbOwYflxw3WDgftL2vRSz+0TfyOW/pZSmTlcseKEPcM4YKWYmgZ1V1+quhnYChQ9xRcnQizZat0rrCsoQqZWfKNuNUUMlP2uE2rp32BIm4vTBBrgBK6RNjnjy10x5HBAZtCtKb7ZmMtwT9vDfOgnR/uX4TcWW7Dkw1HcKxLtQow7yjn3rTcubtc6xJ0uHNAyL6UR973S70e7FcS140LTOCkQ5x9G0WQUWCdOKxkz66qLKuDCSCEDsvMy0xw5Vpye5nNBjpc6CjG9K9j8QuERVlf38qajGd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6117.namprd15.prod.outlook.com (2603:10b6:610:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 27 Oct
 2023 12:39:50 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:39:50 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 13/18] RDMA/siw: Cleanup siw_accept
Thread-Topic: [PATCH V3 13/18] RDMA/siw: Cleanup siw_accept
Thread-Index: AQHaCNKt/NyxUWwqHkGppTe/WeHNaw==
Date:   Fri, 27 Oct 2023 12:39:50 +0000
Message-ID: <SN7PR15MB57550D5E5FA9B6CDD8644E0599DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-14-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-14-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6117:EE_
x-ms-office365-filtering-correlation-id: fda7710b-cf5d-4012-6d13-08dbd6e9cfa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaDk5d/aSG3AmP9HawFJMfaqCqgHavQYi2IAwS7pooeVo9RWNiAWtY2vc/E4gQD7wOr7w35y4q0X11O2BKh+NNENiku2ZAZSzYR8wXV0slf1BIgXDO42cYn2CA7B8j5WzJEgav1AeHaqBBGhN5ggNO0cSvzecMKUa+JHx5OMNLAxHWpzi/zOlxW++dtefzB3AisJPMRQxhD53Bhi4BVJIK2W23gzYlNBug3JySPafmwKfWo9cIAFQG3568bI2Q40dwB/d9GkQ0ywcJKBiRp8Q0dqKuIw7jpxxCtc8gWvDhRSrSEnjv1GYKsqNI/KCUxazmQdEhokgX9MDt5xrhmVfFEMcaIVn4ASCfTa2hvsqSkpUHuSNEttO/yKkKuOl08J2jKyTKAmxW55jcy/pF/2W/vEzjbHA4bcaGLm8TmRciU7qynmHZEmbCeDtZXDjqRt2sLdq4KdBliv3GffC1vEDjgdr0xueEb6EuPzW6QSZ4P6az0cHU5TpEHLmyqVmakkNJive+r27j9/9t5hsZe+HDApVtVlrxwdHlUuXlAqxSdx2OJwbML0lRANmIr/s06K62P3UZZQ0SqwjDxCSO/EQ9wyaO7T58M+boXpigb0AaUfncYo9IjFBbfjKQJu/a7SDsoj7sLMWoRrbWlENlTAvjB/dwvD6GjU/ij1qS+Bjmw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(64756008)(8676002)(66946007)(66476007)(316002)(110136005)(41300700001)(66556008)(66446008)(83380400001)(76116006)(9686003)(2906002)(7696005)(53546011)(6506007)(71200400001)(5660300002)(52536014)(478600001)(33656002)(38100700002)(38070700009)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW5Tdko1TW5IMWpBWDVocjFTOVNSaWlsVWRzdzBiODRMbDQxaGtCenRzeCtP?=
 =?utf-8?B?ay9ub1JnMUFSblpiNStyQWJ5M0hVd2ZHcGRvQktCeWd2ZXFNc2ZZcisycER5?=
 =?utf-8?B?bkc0MEYwbmo1VTlsMlo3NVdqU1M5UGZ0eC9QZzRjdHBiNEtsTWR1L0t1ei85?=
 =?utf-8?B?RFFUV2RJaHBxbHJYd1pnU2VtUFErZWlGakRoZThpTHUyUzNFWDVTWlRFM2h6?=
 =?utf-8?B?N09WZlRYT0Z3cmJaeDcvTzgvVEgxYjArd0F4MnpSNU1uenljZjNHY25mcHg5?=
 =?utf-8?B?UWg4eGk2SlZPc1oyUE11cm1iNHBWd09iYXZTOTM1eVZoQjJyUENtNW9DaG8z?=
 =?utf-8?B?VjNDQUVQUVQ3MTdxbTkrTmlaWWtyWmtIMGxhL1FGWEp1MFUzYXdMMW1aeWtn?=
 =?utf-8?B?TStrR3lGZWthNVRxWExleDhRNE9TRXZwRGovSkRXSWxwa1dEZ3FuaWRLbmts?=
 =?utf-8?B?RUsra0pZRUxmNHo0VjVLbUdwcStBU0IrODhnQWNFTTZ4a0lVSDhZcWVIa0pT?=
 =?utf-8?B?TUE5dWwxd25VRm9ZU0F6VkdmWEpvZ2YrejRMRGU0Z3NFbmN6TWFEV2x6Ny9p?=
 =?utf-8?B?VjE0SXdOOFpvMUFxN25FNnZ6dm1UWEVmcVRselVvZjk1QjJWbDljMVV0MWxs?=
 =?utf-8?B?OTVSR0wxRFFTNENpTi9KaURmbFJlelhuUzVxT1M1UXhla1I5WmNRcjRyeEpM?=
 =?utf-8?B?RWlrWnZNcUNuUzA5cVBsSW9LcXc1aHYwMkc4Umg1ZmVJTTJzYzZEOXhCVUhS?=
 =?utf-8?B?RHBXNUtDNkF0NmFIYXRBNUhCekp6VXlvNUt5S21PNjNJZlNhUERKKzlud2RB?=
 =?utf-8?B?L1JLdVpWYU1uSnBQUW9nVitMZGg3UnF3enI4bm1pdlhmY28wNkd6NE1uZDgv?=
 =?utf-8?B?aFQ3dzhWRnNQSUR0TWJETWtoZHV2eUFSd2o1bzduVU9EMUo0S1ZiTW1XMUtD?=
 =?utf-8?B?RXZBT1VPeXBMck15ZmoxazZJOTRaT3diTWpCelIxN3I0NmoraGlIdzVLd3pX?=
 =?utf-8?B?ckRoemFNaG04OUM5YTBXcERFaUpSSWdZY3YxY0NTTTJBa1lBNG5WdnVUMExt?=
 =?utf-8?B?c3JEd0lFc0pQOUxiSTFjMk9Kc3ZDa01tNkVFTmdZUW5mU1lNNnZVUnVqbS9j?=
 =?utf-8?B?SS9sRk5FREFVQU9TVmJwSm9RZEpXYkhIZ252bnd1QkVzMTd1cENlSzd5Nk1r?=
 =?utf-8?B?RDFmbTBFUWFWbVJhWFEwOTVsdzkvT0Y4ck9kQ1ZBVVNmbDRMdTdIZmhZWUE2?=
 =?utf-8?B?a3B0OGZmQXBCM3ZqMzRrdFk0Wm9QU1hBVFhjUUxjVEVJWGk1Sld3aThSWmtV?=
 =?utf-8?B?LzBDdURmS1kwZnNEOFF5eHFWTUQvNldGUFAwd3ZBYkxrVldKUEVDL3VqUElJ?=
 =?utf-8?B?TGZUbjZYS3JXSDc3OFhISEdSY1hpSUljREJnR0oxTkxld1VlZVFSeVA4Wlhq?=
 =?utf-8?B?VlJTNURQL1JXa1lLNUxCR3haeUZjRndMOGU1ZTlTOUVXb2k4bDZaVGhuaWFz?=
 =?utf-8?B?ZWlFdm5xMmliRSt0NTU4RHhXdDA2RlJVN1NxZnFuZGZhOVVVcU5uckJzUkVi?=
 =?utf-8?B?UmJzRmd3Rmhhblk3TG54L1l3RHRBSzE5ejVCdFQ0M0NyYzVJUHZPOWh2RWMy?=
 =?utf-8?B?eTBHSFRBVDczdFRMOHdwNXFvSnlIaStBcVNaSzErV0hOOTRYRmhGbXZWbFVt?=
 =?utf-8?B?a0dPcUZsRG84TzhyQUd4cTBTZDZsR0VEMXpBUFgwQnNONkVLSGJsL3Q0ZWZI?=
 =?utf-8?B?bkFOVjFZMGRXMy9ISmRpMVB5Ri9qYWhraHFlNkt4Mlh0UTVEdWhnU01QdXA3?=
 =?utf-8?B?MVF1SGNic0ZHRmNzZnhOZzhsNSsrTGwvdVRRbWlRb0NJUFhMSXNWOEpRZzFN?=
 =?utf-8?B?cU1FcDNNZ2hibzJrQ0FrZWJ2dGVib1QvNnZraC9yaU54RkQyQ2o0bmsvUkRZ?=
 =?utf-8?B?cjkvdVpNeTBmZ09tb3hpQWVCWG9pbVN0OGVxdTNnS1NNeHhocEgrbURzL1lC?=
 =?utf-8?B?L3plUDV4QWtNOGYya0dXMHovS0lNN0xTTGc4L3ZCR25IVmpXZWF3ZU9BZzcv?=
 =?utf-8?B?d3gyanZQYVY2aHFOUHRuNFJNc0lvZk9ZMDlqL0I2UThhTTFMNXY3TmpsMnBr?=
 =?utf-8?B?dkkzbjRPTlN2WGpieEVyL0s5NDM5LzgyRnpCck1UbWJIdllCVWh6R3VyR0Vq?=
 =?utf-8?Q?3XfPZonffWUCaWiytV0GsWXaTG3vF2W2JmpqJmERHFUl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda7710b-cf5d-4012-6d13-08dbd6e9cfa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:39:50.2386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiwxDB/QkKNhHR6kilQfQyY+apLaEocOQ3ZgfELh800Zg5AnX7h17edToc2nlWgcMxTieUpiWDaP38hkG+uUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6117
X-Proofpoint-GUID: YRh_xRLq249ykneRjD2e_bcdl2NrLjjn
X-Proofpoint-ORIG-GUID: YRh_xRLq249ykneRjD2e_bcdl2NrLjjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=977
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyA0OjMzIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAxMy8xOF0gUkRNQS9zaXc6IENs
ZWFudXAgc2l3X2FjY2VwdA0KPiANCj4gV2l0aCB0aGUgaW5pdGlhbGl6YXRpb24gb2YgcnYgYW5k
IHRoZSB0d28gYWRkZWQgbGFiZWwsIHdlIGNhbg0KPiBzaW1wbGlmaXkgY29kZSBhIGJpdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEd1b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMgfCA0MSArKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
Y20uYw0KPiBpbmRleCAxZDI0MzhmYmY3YzcuLmNmZjBmZDdjZWVlNiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IEBAIC0xNTQ4LDcgKzE1NDgsNyBAQCBpbnQgc2l3X2Fj
Y2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29ubl9wYXJhbSAqcGFy
YW1zKQ0KPiAgCXN0cnVjdCBzaXdfY2VwICpjZXAgPSAoc3RydWN0IHNpd19jZXAgKilpZC0+cHJv
dmlkZXJfZGF0YTsNCj4gIAlzdHJ1Y3Qgc2l3X3FwICpxcDsNCj4gIAlzdHJ1Y3Qgc2l3X3FwX2F0
dHJzIHFwX2F0dHJzOw0KPiAtCWludCBydiwgbWF4X3ByaXZfZGF0YSA9IE1QQV9NQVhfUFJJVkRB
VEE7DQo+ICsJaW50IHJ2ID0gLUVJTlZBTCwgbWF4X3ByaXZfZGF0YSA9IE1QQV9NQVhfUFJJVkRB
VEE7DQo+ICAJYm9vbCB3YWl0X2Zvcl9wZWVyX3J0cyA9IGZhbHNlOw0KPiANCj4gIAlzaXdfY2Vw
X3NldF9pbnVzZShjZXApOw0KPiBAQCAtMTU2NCwyNCArMTU2NCwxNyBAQCBpbnQgc2l3X2FjY2Vw
dChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29ubl9wYXJhbSAqcGFyYW1z
KQ0KPiANCj4gIAlpZiAoY2VwLT5zdGF0ZSAhPSBTSVdfRVBTVEFURV9SRUNWRF9NUEFSRVEpIHsN
Cj4gIAkJc2l3X2RiZ19jZXAoY2VwLCAib3V0IG9mIHN0YXRlXG4iKTsNCj4gLQ0KPiAtCQlzaXdf
Y2VwX3NldF9mcmVlX2FuZF9wdXQoY2VwKTsNCj4gLQ0KPiAtCQlyZXR1cm4gLUVDT05OUkVTRVQ7
DQo+ICsJCXJ2ID0gLUVDT05OUkVTRVQ7DQo+ICsJCWdvdG8gZnJlZV9jZXA7DQo+ICAJfQ0KPiAg
CXFwID0gc2l3X3FwX2lkMm9iaihzZGV2LCBwYXJhbXMtPnFwbik7DQo+ICAJaWYgKCFxcCkgew0K
PiAgCQlXQVJOKDEsICJbUVAgJWRdIGRvZXMgbm90IGV4aXN0XG4iLCBwYXJhbXMtPnFwbik7DQo+
IC0JCXNpd19jZXBfc2V0X2ZyZWVfYW5kX3B1dChjZXApOw0KPiAtDQo+IC0JCXJldHVybiAtRUlO
VkFMOw0KPiArCQlnb3RvIGZyZWVfY2VwOw0KPiAgCX0NCj4gIAlkb3duX3dyaXRlKCZxcC0+c3Rh
dGVfbG9jayk7DQo+IC0JaWYgKHFwLT5hdHRycy5zdGF0ZSA+IFNJV19RUF9TVEFURV9SVFIpIHsN
Cj4gLQkJcnYgPSAtRUlOVkFMOw0KPiAtCQl1cF93cml0ZSgmcXAtPnN0YXRlX2xvY2spOw0KPiAt
CQlnb3RvIGVycm9yOw0KPiAtCX0NCj4gKwlpZiAocXAtPmF0dHJzLnN0YXRlID4gU0lXX1FQX1NU
QVRFX1JUUikNCj4gKwkJZ290byBlcnJvcl91bmxvY2s7DQo+ICAJc2l3X2RiZ19jZXAoY2VwLCAi
W1FQICVkXVxuIiwgcGFyYW1zLT5xcG4pOw0KPiANCj4gIAlpZiAodHJ5X2dzbyAmJiBjZXAtPm1w
YS5oZHIucGFyYW1zLmJpdHMgJiBNUEFfUlJfRkxBR19HU09fRVhQKSB7DQo+IEBAIC0xNTk1LDkg
KzE1ODgsNyBAQCBpbnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4g
aXdfY21fY29ubl9wYXJhbSAqcGFyYW1zKQ0KPiAgCQkJIltRUCAldV06IG9yZCAlZCAobWF4ICVk
KSwgaXJkICVkIChtYXggJWQpXG4iLA0KPiAgCQkJcXBfaWQocXApLCBwYXJhbXMtPm9yZCwgc2Rl
di0+YXR0cnMubWF4X29yZCwNCj4gIAkJCXBhcmFtcy0+aXJkLCBzZGV2LT5hdHRycy5tYXhfaXJk
KTsNCj4gLQkJcnYgPSAtRUlOVkFMOw0KPiAtCQl1cF93cml0ZSgmcXAtPnN0YXRlX2xvY2spOw0K
PiAtCQlnb3RvIGVycm9yOw0KPiArCQlnb3RvIGVycm9yX3VubG9jazsNCj4gIAl9DQo+ICAJaWYg
KGNlcC0+ZW5oYW5jZWRfcmRtYV9jb25uX2VzdCkNCj4gIAkJbWF4X3ByaXZfZGF0YSAtPSBzaXpl
b2Yoc3RydWN0IG1wYV92Ml9kYXRhKTsNCj4gQEAgLTE2MDcsOSArMTU5OCw3IEBAIGludCBzaXdf
YWNjZXB0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVjdA0KPiBpd19jbV9jb25uX3BhcmFtICpw
YXJhbXMpDQo+ICAJCQljZXAsDQo+ICAJCQkiW1FQICV1XTogcHJpdmF0ZSBkYXRhIGxlbmd0aDog
JWQgKG1heCAlZClcbiIsDQo+ICAJCQlxcF9pZChxcCksIHBhcmFtcy0+cHJpdmF0ZV9kYXRhX2xl
biwgbWF4X3ByaXZfZGF0YSk7DQo+IC0JCXJ2ID0gLUVJTlZBTDsNCj4gLQkJdXBfd3JpdGUoJnFw
LT5zdGF0ZV9sb2NrKTsNCj4gLQkJZ290byBlcnJvcjsNCj4gKwkJZ290byBlcnJvcl91bmxvY2s7
DQo+ICAJfQ0KPiAgCWlmIChjZXAtPmVuaGFuY2VkX3JkbWFfY29ubl9lc3QpIHsNCj4gIAkJaWYg
KHBhcmFtcy0+b3JkID4gY2VwLT5vcmQpIHsNCj4gQEAgLTE2MTgsOSArMTYwNyw3IEBAIGludCBz
aXdfYWNjZXB0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVjdA0KPiBpd19jbV9jb25uX3BhcmFt
ICpwYXJhbXMpDQo+ICAJCQl9IGVsc2Ugew0KPiAgCQkJCWNlcC0+aXJkID0gcGFyYW1zLT5pcmQ7
DQo+ICAJCQkJY2VwLT5vcmQgPSBwYXJhbXMtPm9yZDsNCj4gLQkJCQlydiA9IC1FSU5WQUw7DQo+
IC0JCQkJdXBfd3JpdGUoJnFwLT5zdGF0ZV9sb2NrKTsNCj4gLQkJCQlnb3RvIGVycm9yOw0KPiAr
CQkJCWdvdG8gZXJyb3JfdW5sb2NrOw0KPiAgCQkJfQ0KPiAgCQl9DQo+ICAJCWlmIChwYXJhbXMt
PmlyZCA8IGNlcC0+aXJkKSB7DQo+IEBAIC0xNjI5LDggKzE2MTYsNyBAQCBpbnQgc2l3X2FjY2Vw
dChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29ubl9wYXJhbSAqcGFyYW1z
KQ0KPiAgCQkJCXBhcmFtcy0+aXJkID0gY2VwLT5pcmQ7DQo+ICAJCQllbHNlIHsNCj4gIAkJCQly
diA9IC1FTk9NRU07DQo+IC0JCQkJdXBfd3JpdGUoJnFwLT5zdGF0ZV9sb2NrKTsNCj4gLQkJCQln
b3RvIGVycm9yOw0KPiArCQkJCWdvdG8gZXJyb3JfdW5sb2NrOw0KPiAgCQkJfQ0KPiAgCQl9DQo+
ICAJCWlmIChjZXAtPm1wYS52Ml9jdHJsLm9yZCAmDQo+IEBAIC0xNjc3LDcgKzE2NjMsNiBAQCBp
bnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdfY21fY29ubl9w
YXJhbSAqcGFyYW1zKQ0KPiAgCQkJCSAgIFNJV19RUF9BVFRSX09SRCB8IFNJV19RUF9BVFRSX0lS
RCB8DQo+ICAJCQkJICAgU0lXX1FQX0FUVFJfTVBBKTsNCj4gIAl1cF93cml0ZSgmcXAtPnN0YXRl
X2xvY2spOw0KPiAtDQo+ICAJaWYgKHJ2KQ0KPiAgCQlnb3RvIGVycm9yOw0KPiANCj4gQEAgLTE3
MDAsNiArMTY4NSw5IEBAIGludCBzaXdfYWNjZXB0KHN0cnVjdCBpd19jbV9pZCAqaWQsIHN0cnVj
dA0KPiBpd19jbV9jb25uX3BhcmFtICpwYXJhbXMpDQo+ICAJc2l3X2NlcF9zZXRfZnJlZShjZXAp
Ow0KPiANCj4gIAlyZXR1cm4gMDsNCj4gKw0KPiArZXJyb3JfdW5sb2NrOg0KPiArCXVwX3dyaXRl
KCZxcC0+c3RhdGVfbG9jayk7DQo+ICBlcnJvcjoNCj4gIAlzaXdfc29ja2V0X2Rpc2Fzc29jKGNl
cC0+c29jayk7DQo+ICAJc29ja19yZWxlYXNlKGNlcC0+c29jayk7DQo+IEBAIC0xNzE0LDkgKzE3
MDIsOCBAQCBpbnQgc2l3X2FjY2VwdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBzdHJ1Y3QNCj4gaXdf
Y21fY29ubl9wYXJhbSAqcGFyYW1zKQ0KPiAgCX0NCj4gIAljZXAtPnFwID0gTlVMTDsNCj4gIAlz
aXdfcXBfcHV0KHFwKTsNCj4gLQ0KPiArZnJlZV9jZXA6DQo+ICAJc2l3X2NlcF9zZXRfZnJlZV9h
bmRfcHV0KGNlcCk7DQo+IC0NCj4gIAlyZXR1cm4gcnY7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjM1
LjMNCg0KTG9va3MgZ29vZC4NCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmlj
aC5pYm0uY29tPg0K

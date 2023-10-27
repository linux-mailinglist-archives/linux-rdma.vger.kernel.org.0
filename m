Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D57D9881
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjJ0Mjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0Mjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E56121
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:39:42 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCWr15014907;
        Fri, 27 Oct 2023 12:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OHevz9LOtf9azAqV9qGhAalgNenJbin7XoI0L9tXf3o=;
 b=jPuT7G84O7lEovqUbPdoWygBE3zVk55KtDBxdNTuBihrK69o/sYp/1Dw/Er+oBPO5bAG
 M+WlaLE9B7rr247LJ+hn2O3gxex6URKblwoBVTgnrdTxwy2wYqCIrjA0OYRwhSxYiYOL
 s4cl21K2usV56EQYxh2Gv6X1NMHo+5l1zVhriytREVX7/vopaM2EtEvpBERR1DGfQvqA
 o+HYkNn44zsntKbhDirNfeKCN9NrQwBwfCV8iB8J1jPAivyRpWkyHy4YWsE5TsXHUeCf
 YnuNHn5hsHOamU9q6swJhAapaPnPXhyurY76ZCI/4imVEC+OR9mqXSB2C2OJ6n/2vDgQ yg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0da5g9hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 12:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0Q9B+2WFKalY2MWaM9QztKgzG2IUciWDhx9ASN56+fUwRrLbAS+QjDoZLJRc3mDzDARGZzTqCa9UKANqP9SNEIrICRSj082RlSZrPcd4pDa8vQuQdkD5+PI5LKinle6h3sW/X14FM/VyHdpBxyU9LT8+h+EwvU/ddnCuNgyZy5pnJQwiDgjGpySNrcwgkmguVTOk8NFOt/YfBzKrj7yMrMtnpGwArhPfXz0EZqyzAdJAED77/MOgJBohfDtiMfMKnvU/LxpVNgycmpo8yxjER4DYUBoFl5Lw7Uy3DxJu/QUOXuqS6qk1aAS76m8UBGEEBiDzl1tV7nUrSF/cyW6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHevz9LOtf9azAqV9qGhAalgNenJbin7XoI0L9tXf3o=;
 b=CFns7BdstvCtEKHH2zc39sU6oAaItV8eSlaT0uyghA2pq0iaLXmHddTzCJFoAz/fUtnsk2nZgbSbQadMIrQ/HEyx+zJKwiFDOW82dD15Y/hzdX8DLRBRzOpuf+KXhdSNiccYwmgO38SsyF0TfeLH7ndySpGSYTAJ6gzplmr+usW5DALLLLewpgfqX36yho1wZBB81EnZ27rzWw1fUI5l+8vlL0xd6Y7BtE9eQLBghoE/JwzMCv+b91+AoqKE1ULr/Vlf09UjMDtoeNYk8AuRLs2R2OsoEeFjNErugW7Yuaih2F0qitMiCPuIdnKuXqQ8YO7jdpGyNatgsZK7FaZ9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6117.namprd15.prod.outlook.com (2603:10b6:610:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 27 Oct
 2023 12:39:04 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 12:39:02 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V3 16/18] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
Thread-Topic: [PATCH V3 16/18] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
Thread-Index: AQHaCNKQhKODRI+Fd02TaMnJH4dFvA==
Date:   Fri, 27 Oct 2023 12:39:02 +0000
Message-ID: <SN7PR15MB5755E707AECB39B6FED6FB0899DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-17-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-17-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6117:EE_
x-ms-office365-filtering-correlation-id: f4105e21-f6db-4ac1-5913-08dbd6e9b335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLqpiicOPeRUQEw1g2CnqP9kzFCnptv+jX3y7r0nxy0qZI7fSVqpWBiuPysPQKV/+ASgErAQzh8AgVkdlzUKcHAAqj/AcaZgbc5ik/S+FDRI+9QpkV8aIIs/yEt3XCORsIb9XRV8Rb69lcAyVsXtca+VeeEouqBX4UqIKve2Szt/v/3zrQzn1TbXw9kzwjJk+soAxShX10JWieguOcmxLMAXebbUgND+mkS9SxeyJj7QrBavvk2L1u0MQUzRhf4J2/akVoFD2Y5SGsrZwFA5lV48+Y3PlL4vJwKH0+8hDXZ8S/VTAgR++azc546C+HJCHwSCvCJl+AEnP4U5s4F5mK0QsJP8SDgS2w4vIhcBu/akR7UnoEocWCecevS5XsP6jDAQe2BD+QhYro2OQ382lWFs76DkwEKiRU5kgckUwqDB6Nppl2wABU1zQ1JRj4akt9ThimHpWCw2nCn8aGGwurtSofuiMsceWexH56Rd/rdKJH1/vQHdSCS54CxnBZThkMWbOpdik3yoi4rWQKZFj/W694Cs4ZnfLHyhNK+rDRkSWwmNeHxMqvlfD20Sn0H3+3RH2UHjuIxHM6247RoqkveiIjMYVP4sbi8QdrZAX4VYzlolp74JN5E0YpH1OYXNGabyZDR6mtiAvF1i3ErJLSkJWx5PZXZT7YX7wDzJHPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(64756008)(8676002)(66946007)(66476007)(316002)(110136005)(41300700001)(66556008)(66446008)(83380400001)(76116006)(9686003)(2906002)(7696005)(53546011)(6506007)(71200400001)(5660300002)(52536014)(478600001)(33656002)(38100700002)(38070700009)(122000001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZlSkVxWlY5Sm5VdU9CaTRtZzljOXpyY3Y3cnBLZUo2U2JWYVNYMkl0aUxS?=
 =?utf-8?B?MWliVlhrSWhkeXF6b1JDanJmQUxGaWdjQ0NEaDU0a1NwU1BlWDFNT1cvWjQ2?=
 =?utf-8?B?WDVjOG1NMzdhckFabWE2T3hHWUhhd1BvNXU2UUpDTVhDV25Zc294aDIzSTIz?=
 =?utf-8?B?TzArOXQvY2hDRmZib1ZWeEF1Z3dZY0E5QU1ROTdkR1NwNTUxV2gvLzNhZ1FI?=
 =?utf-8?B?QjlGMXQvV3Y1YXBRdmxmSHVPb2p3Ykh1Nk9yQ0ZRT09RMjR0T1NJajdDTUl5?=
 =?utf-8?B?UnBOeFkwS3NqTXpmSnhJSGRlZ25JT1RMR1gyeG56K24zeHI0TkZuZ3kwN0Ur?=
 =?utf-8?B?dFlveE5Vb0VYOXk4MlAwQTlMOG9QMFpSY3k0NW9iMU1hVk16OTI0TGt3dzJr?=
 =?utf-8?B?TWE4RTFFSHUrYmNBYUFZVXhhQ1NsMmlEbWM5NjBnVlN4cGdEODZmM2F5K29Y?=
 =?utf-8?B?UHhQN3I3R2p1OGpJZ1l4S2hoUXZpSjNTL1JIekpNTGs5WURteklQSnQ1aGtP?=
 =?utf-8?B?eTJiMkNxTlhBL3RxK3AzTTBCc2pTOFpHbWV6YnVCdGVZb3FGeEdVL0dmT3l4?=
 =?utf-8?B?ak94S2kzSllaUzdva3dhdFpTMzhOd1IzS3BuK0hsSDdLZjl0aEtUQTlQaWdn?=
 =?utf-8?B?cVB6MjVkT0dTbmtJbTFmSzIxeEh2dnFRMlVpU0NkcDJoS3o5Y1cwUitsRVhQ?=
 =?utf-8?B?MWdZdmRhSHJWUWZTbTRrb0FhYU5UdnI3QjFVUHpNc2pBK29iRW8yTUx4N1Fa?=
 =?utf-8?B?MEpVVlpKM3lINFB0UDdMdDh2ZEt2bEJ5ekdEenhmVHBOaG8rVmRFQWt2QVFu?=
 =?utf-8?B?WWlmWTd3ZEF0dUJsTGpJMHBNWitTMEMxNVNyRmVOSzFBOWxGMWFjVTdGa0Jp?=
 =?utf-8?B?V3UyT1VBcE5QQjdkVmZnU2h4a3pYR0liK1M2Rjk5NGJMWmtqeXJiQXJPYm5a?=
 =?utf-8?B?Q3V5YTBUYmZtUjZieHBwS0IwRlV0cWRLSEFOM1BHWU9DekEvNGFRejZwT3Q5?=
 =?utf-8?B?RElTVzFzeFZlM3pHOUNJVkNGY1NiSVNZNlRSc252YWFRdEJJbVRQUXk2WXF0?=
 =?utf-8?B?T0xka1lPYmdBZEx2TFhXMGd0amMvYnJxSTZaZmtGM1pWS09uTFE1YTB2MWlh?=
 =?utf-8?B?eWs2V2Yrb0V5N1BEUHVMTmVmZUFLUnVReGV5UUtWSnVHZytqYTNZWjlsRERq?=
 =?utf-8?B?VUpsVndTVEpsSkRWSUJSeGZZZ3ZwbEFJR3F4cFE4VnA1VWd6ZE9Ud2d1Mmow?=
 =?utf-8?B?MHFLUW9yQW1RN3l1UEVlSktUWlRDRzNZVDllYkp4QWhRbjVOWEtCcDBqb2tq?=
 =?utf-8?B?ZmxrMjFHZW4xU2c5THIzTmZmejlpcVYzeCtzOXVOb0crU21hT0tMTWpva0Ny?=
 =?utf-8?B?MnhHZ0ZWMC9yQUhnek1ldjMxTldRWjdqSEFvLzB4Q2phTm8zM0tXWGtYNUJJ?=
 =?utf-8?B?Zzl1YTZwYjJpQXVPUjVnb21MUXJxVklaS1ZPNXFmVmZPa2ZXVkU5NnVkNWVG?=
 =?utf-8?B?cnh6RStkUCtEeXh5Zk5seGt1ZEJzM3E4dVNXcTlyR3pCelBWbXlKbVFQR1di?=
 =?utf-8?B?WjZhK1BrQXluT3Zka0lTb0x4OFhNOUsyc01pUlZKWnNjeEp1U2Z3K1I1SVJk?=
 =?utf-8?B?Um9pSFlyQU5iUlB5amt1UTRmUFpzUkU0VmhpL3dQQnBjSkplOWpsS2k2SG9U?=
 =?utf-8?B?VUE1b1NwbmZUeWZMbExQeklrQzgzcnJCc0tpR0IvK2xpbE5Oa096VlBtRGRz?=
 =?utf-8?B?bERrSkozemZ1YW1XNmxQMDVVSVY5bGpRQ2hIa2NiNU1RTnlzaE9ucEl5SDJE?=
 =?utf-8?B?eXBHNDRyUUNWdk9mSkdMWkdPdndLMlpaNEwwUTZrRXVzR1gwQUFFUklReFlj?=
 =?utf-8?B?TmVBcUlmeU8yd3pobUFxRkpSSVd0aEowc1RsY1JwOHNlckVZY1FGOFA1TU11?=
 =?utf-8?B?QkZQNkppSitvZ3luMG0yRUpTOGZWb0dtRFFBYmY3MnJBTjYvZk1QSmZVYjZs?=
 =?utf-8?B?Q2RVSG1uSTMzWFVJb2d1VENOSnBQUUFBRlJPSmM1OFFjaHhaRGpZU0tUWGdr?=
 =?utf-8?B?MlEvbzdFY3RVTDBualN5S0phd3F6ams1ZFRNLzdNMHBRM0JuOHlLNHRpMVl3?=
 =?utf-8?B?YmJpMzVxUHQzTmxGL0dWMEMxaThFbFVRNEZBR3FqaEozdUIxSDBqbFMxWFl3?=
 =?utf-8?Q?/CWDUU05/P95BuSiCF7JxGsFNoU4QgbcfJ9icmHaP0nB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4105e21-f6db-4ac1-5913-08dbd6e9b335
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:39:02.4974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu/RS5ohGUq0pLSSi7KvkVljXmafYp+/bYd4+MJTVrwPLC3+UGiKk/wC4oOThurxK+NkZO45RRsrblJZ4Y8ZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6117
X-Proofpoint-GUID: O3d4VCJ2kINXbVPd4AdPdB8cK5EKuN63
X-Proofpoint-ORIG-GUID: O3d4VCJ2kINXbVPd4AdPdB8cK5EKuN63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=982 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMyAxNi8xOF0gUkRNQS9zaXc6IE9u
bHkgY2hlY2sgYXR0cnMtDQo+ID5jYXAubWF4X3NlbmRfd3IgaW4gc2l3X2NyZWF0ZV9xcA0KPiAN
Cj4gV2UgY2FuIGp1c3QgY2hlY2sgbWF4X3NlbmRfd3IgaGVyZSBnaXZlbiBib3RoIG1heF9zZW5k
X3dyIGFuZA0KPiBtYXhfcmVjdl93ciBhcmUgZGVmaW5lZCBhcyB1MzIgdHlwZSwgYW5kIHdlIGFs
c28gbmVlZCB0byBlbnN1cmUNCj4gbnVtX3NxZSAoZGVyaXZlZCBmcm9tIG1heF9zZW5kX3dyKSBz
aG91bGRuJ3QgYmUgemVyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1b3FpbmcgSmlhbmcgPGd1
b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X3ZlcmJzLmMgfCAxOCArKysrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IGluZGV4IGRjZDY5ZmMwMTE3Ni4uZWYxNDllZDk4OTQ2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+
ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTMzMywx
MSArMzMzLDEwIEBAIGludCBzaXdfY3JlYXRlX3FwKHN0cnVjdCBpYl9xcCAqaWJxcCwgc3RydWN0
DQo+IGliX3FwX2luaXRfYXR0ciAqYXR0cnMsDQo+ICAJCWdvdG8gZXJyX2F0b21pYzsNCj4gIAl9
DQo+ICAJLyoNCj4gLQkgKiBOT1RFOiB3ZSBhbGxvdyBmb3IgemVybyBlbGVtZW50IFNRIGFuZCBS
USBXUUUncyBTR0wncw0KPiAtCSAqIGJ1dCBub3QgZm9yIGEgUVAgdW5hYmxlIHRvIGhvbGQgYW55
IFdRRSAoU1EgKyBSUSkNCj4gKwkgKiBOT1RFOiB3ZSBkb24ndCBhbGxvdyBmb3IgYSBRUCB1bmFi
bGUgdG8gaG9sZCBhbnkgU1EgV1FFDQo+ICAJICovDQo+IC0JaWYgKGF0dHJzLT5jYXAubWF4X3Nl
bmRfd3IgKyBhdHRycy0+Y2FwLm1heF9yZWN2X3dyID09IDApIHsNCj4gLQkJc2l3X2RiZyhiYXNl
X2RldiwgIlFQIG11c3QgaGF2ZSBzZW5kIG9yIHJlY2VpdmUgcXVldWVcbiIpOw0KPiArCWlmIChh
dHRycy0+Y2FwLm1heF9zZW5kX3dyID09IDApIHsNCj4gKwkJc2l3X2RiZyhiYXNlX2RldiwgIlFQ
IG11c3QgaGF2ZSBzZW5kIHF1ZXVlXG4iKTsNCj4gIAkJcnYgPSAtRUlOVkFMOw0KPiAgCQlnb3Rv
IGVycl9hdG9taWM7DQo+ICAJfQ0KPiBAQCAtMzU3LDIxICszNTYsMTQgQEAgaW50IHNpd19jcmVh
dGVfcXAoc3RydWN0IGliX3FwICppYnFwLCBzdHJ1Y3QNCj4gaWJfcXBfaW5pdF9hdHRyICphdHRy
cywNCj4gIAlpZiAocnYpDQo+ICAJCWdvdG8gZXJyX2F0b21pYzsNCj4gDQo+IC0JbnVtX3NxZSA9
IGF0dHJzLT5jYXAubWF4X3NlbmRfd3I7DQo+IC0JbnVtX3JxZSA9IGF0dHJzLT5jYXAubWF4X3Jl
Y3Zfd3I7DQo+IA0KPiAgCS8qIEFsbCBxdWV1ZSBpbmRpY2VzIGFyZSBkZXJpdmVkIGZyb20gbW9k
dWxvIG9wZXJhdGlvbnMNCj4gIAkgKiBvbiBhIGZyZWUgcnVubmluZyAnZ2V0JyAoY29uc3VtZXIp
IGFuZCAncHV0JyAocHJvZHVjZXIpDQo+ICAJICogdW5zaWduZWQgY291bnRlci4gSGF2aW5nIHF1
ZXVlIHNpemVzIGF0IHBvd2VyIG9mIHR3bw0KPiAgCSAqIGF2b2lkcyBoYW5kbGluZyBjb3VudGVy
IHdyYXAgYXJvdW5kLg0KPiAgCSAqLw0KPiAtCWlmIChudW1fc3FlKQ0KPiAtCQludW1fc3FlID0g
cm91bmR1cF9wb3dfb2ZfdHdvKG51bV9zcWUpOw0KPiAtCWVsc2Ugew0KPiAtCQkvKiBaZXJvIHNp
emVkIFNRIGlzIG5vdCBzdXBwb3J0ZWQgKi8NCj4gLQkJcnYgPSAtRUlOVkFMOw0KPiAtCQlnb3Rv
IGVycl9vdXRfeGE7DQo+IC0JfQ0KPiArCW51bV9zcWUgPSByb3VuZHVwX3Bvd19vZl90d28oYXR0
cnMtPmNhcC5tYXhfc2VuZF93cik7DQo+ICsJbnVtX3JxZSA9IGF0dHJzLT5jYXAubWF4X3JlY3Zf
d3I7DQo+ICAJaWYgKG51bV9ycWUpDQo+ICAJCW51bV9ycWUgPSByb3VuZHVwX3Bvd19vZl90d28o
bnVtX3JxZSk7DQo+IA0KPiAtLQ0KPiAyLjM1LjMNCkxvb2tzIGdvb2QuDQoNCkFja2VkLWJ5OiBC
ZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==

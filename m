Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4757DF40F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 14:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjKBNlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjKBNlN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 09:41:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFEB13E
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 06:41:03 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2DeVfv016981;
        Thu, 2 Nov 2023 13:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jBO9UndAs4yqI+PdtP72/ojUID39oGxNawFQrrj6Lf0=;
 b=H1NDP8dCB7tQO6RD9jEt1Ti7nVOh5lhh1ML53v1Vn9cddIA0bFBXAv4RWi39KruzKfng
 ftRvENe2Pv+igGVQvc06pdXi7T78ImaJl2jhrtiJX4zfIOugHpG3THxt3P/FAKsnVKO6
 QazVg9pwo2jwE1IeSYBJn1p/IvIdRx6KPl090wQjBdVbC+hSwc4krAoJ4/B6SK9Z9qDU
 KYVVqVQ+bmmeLLvQN+ATWzfjU02+KsbZPhjef2hSM3N4JqszuDlo1Ar60NzwBjERmMPf
 Gmg+k+5+7wP14sxttOCF+v41uYHCuhMIZqG+nxTaHNPc+S2t2PArGNxJYFSjQYm9OscV xg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4cuw80fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 13:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sotuwm7s7mDUhjn8GwpI6fl6uKkSlcsoG/V47wvlE3a+KmTvzCFXUCTEOUc77V/EAkwiZZTvNkb6Jgl5iVJqGmcxlgvrlgeiDNB6OhlNdqcTuVVgrRMV9oCrmYVh9biidzQjVnx95n0zX9/ML12XY4HCc9NFHBDul+qd/q5K1un75kbXR8aPHMKdo81FJwXn7Lvgs3es+c9PluQ55u1qS1U+N9lC49bhcxTcemMMlEtNEQuEhaGHdSKs18TjeRHyC0oJgueHQd1q8KNP7fVHHdwuYSUsYV/5CQXCfT1Digr8yjf7lZJYIrV99Key0YdHcBeWr5hgd792co7T/SbNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBO9UndAs4yqI+PdtP72/ojUID39oGxNawFQrrj6Lf0=;
 b=cqd2HuvahXuIFishfSCskKo65DDaYbaeeZexFivsJ/DeEhjOOttz5DGdH2MFQ7EUMR1/4Tu3w772JQqnjyxTfvTw1XrcVUOgyaNqAan6CiBEs30fvN28pmvw/Bal+mPQf32DKADBmfTFCMbJs4o2b8Ycg2A2kZ0JMPzKiegmzD4ipyMdRtEMtIEyRNLmYsa8HzYBfMIb+/CN3O4C8gU9ED95pjcjw3yYwTHS1imJRTwcr3uEaoon+UGLMKH6FYmH5kJwKK7dLw3e40WqZcpUzevrMeXS/e6nFlQ/su6l7mjVv31vBKGhKoqrjWtUltv8NlurEK1FQlQxEC3ylWOlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DM6PR15MB3797.namprd15.prod.outlook.com (2603:10b6:5:2b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 13:40:43 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Thu, 2 Nov 2023
 13:40:43 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Maxim Samoylov <max7255@meta.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: RE: Re: [PATCH v2] IB: rework memlock limit handling code
Thread-Topic: Re: [PATCH v2] IB: rework memlock limit handling code
Thread-Index: AQHaDZIsVzb/o7ftxU+QTlY8Ef0SRg==
Date:   Thu, 2 Nov 2023 13:40:43 +0000
Message-ID: <SN7PR15MB5755D39BAFA9A91584F1415099A6A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
 <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
 <20231102123216.GF5885@unreal>
In-Reply-To: <20231102123216.GF5885@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DM6PR15MB3797:EE_
x-ms-office365-filtering-correlation-id: 2c687f23-23ad-46cd-30c6-08dbdba94f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USEz+EBx3XRcdg+nMh1Xy6q/+5KhBj9TsuQlpu7LynaMLeADty9nFx0yI8lhyHLPmH80JErYIvkfo59sKxmtuf8KFzWacOSR2e5vjdSDEXbIMd/AUUXan/dtxwMdivZ84TTe1cF88Yo6DU7h9JHQg6aKXB9keAEo4igFC5u+wdl0TcJh+Mu/RM2hkeAor4FqP7yTizBr03zp0SHTg87R5JHUKamnXux/lgUEUiX7CYj12+ZUPcXxAjuAV/QoeNyZ5OabmLY0Obac2BrBXJISKCpeP8y1NH8mZEjSujW8MtmQlEd4L79tdTgia3SqxUuhipgHiluPcGMgVBRHsjdmf5NGwVtJuMbCLRLyTul4WK6UPmhjDWCob3GFlDQ0Vs4BOEq7Y4AShotawF2iR6RsRg9mDMr7NrAcuWSLjEldVBXWjdZBvb4brvJYUsOinMuCd7xoE6Rw0txusNjcTwQuSWNZGHA7Hdn8O2reLM39vVPlu+IlmkkGSiirAN3V3rnuFvoL73iNCb5qbRo/9eUmpyhr1hB11HA7dRp2Pm4BrUQmCrtN02ofzRhIqFLHYkoHJ5rEOIK6syzg+xrDfvcl05u4en+UoB/VLworAvGvFRUGtDzfIfFE6NH3rXUV/Tgw6v/njFxkNQmnJEVdiv7PHay689TVt20FVASGm174LPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799009)(64100799003)(186009)(451199024)(38070700009)(33656002)(55016003)(66556008)(8676002)(66476007)(8936002)(83380400001)(4326008)(64756008)(66446008)(110136005)(66946007)(5660300002)(76116006)(316002)(71200400001)(2906002)(54906003)(52536014)(41300700001)(478600001)(7696005)(6506007)(53546011)(122000001)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b29JSGJDN3c1cGl3b1hqSVpvZXBjM0FZaVlrVDNud1FxblZsUjZPSWdMMDBS?=
 =?utf-8?B?aGJON3hMaTZaZy83Rkl1SkFyZlJkdEVDSlhSUFIrU3ZEdWtnbnJlQXlpUkxv?=
 =?utf-8?B?T1JOYUlnSjdHNG9sUFZoS1J2ckM3eURNOXN5RmJkNEhocEdkK1h2OVlVK0ZV?=
 =?utf-8?B?TXpXZm4vRG1XWkxQTkcrdE1weUlhWXc3WTc2Um1remZUWXREUU5mMmEzTk8w?=
 =?utf-8?B?V05rNXZiTUc0TVZNOEpOaDFKTUZiS0s5ekFCQ3lIMkhHM3V6MFo1K01FZU8w?=
 =?utf-8?B?UDBCUmQ1TVJybUluSmNaSDZGYnlaUVoraUFUWmUzSDhEcWowNUtMZVgweWpz?=
 =?utf-8?B?dW45eGdmaDFqYXN6Zm5CWkFaaXZPdnl5R0RQK1FwUVVhTU1DTEdYWXFVNHEx?=
 =?utf-8?B?a3Bac1EvS2hvRUJUai9vQjZhWHhlc1dheERUbDE3S0lpYVZJUXgzeVRzSnA1?=
 =?utf-8?B?RTJ4Tm43UHlXdVEwdEJtaUtoaVRWcEF0ODZLMWc0UHplbTFTaXJ4ejVxNGIz?=
 =?utf-8?B?NXBJWW05dU1FbUFxZHpCQmhjdWFnWkU1VkVEZ1U2MG9oTStWWjIzMVdjNTlW?=
 =?utf-8?B?aGdkRVVNWEp5ajAvUC91REorVnpmd0VkZ2twUUNEQmMwSG5GYWZZVG5mOXha?=
 =?utf-8?B?OFZ3TGZUL3Nlc09wZUxhWFRjOW1DRGZDV2djbmVvdGhSczhrSnVPeDVmWWQy?=
 =?utf-8?B?dTlEQUJQaGxwN0tZUGFJRHFoR2pUS1JaemhJaXd2c1hxaDIxMlMwbzJkckZh?=
 =?utf-8?B?bVU1YTFWSkQ1S0pQbVk0bUxLYUdIVHFuaWJabHRrZGEwRFMway8yUGxCdFBF?=
 =?utf-8?B?WmM0L1VRb3BoTytkaU1xS2lndU1adXBRMTlUdTBQKzN0L3RxR0JkMTQyMEhl?=
 =?utf-8?B?a1NjazYwL3pKa1ZraEx3b29OdkJtZU5CREoyMmJwU3hLTGRXN25TV0ZzY0s4?=
 =?utf-8?B?c3ZPRzVsekRPcHFxdkdvajZLOHVPSit2Q1Q5dDQvQTdEdXRtVHdsUVhidGJY?=
 =?utf-8?B?VTFOZmU2M3JqUXpWVVRUSGpHeHFlamY4N1JGeTBrQU5QTjlBY1FUdFVCdjFo?=
 =?utf-8?B?OXp5K3QrY09mZDAyRXBIcVdxN1l3NG9VUVdidGhGbFRiVnRXUmd3eHFTTU50?=
 =?utf-8?B?aDZUZGRxUTRQellYU0NXTllMaVpqVjU1TExDNDNGVTg0V3dWWW03bEJjL3dW?=
 =?utf-8?B?VFQ4emliUkFiUmZJN3o3WEJEdzVJRXp5UFRhMGp1QWJIOHNPdXhPMXJ3bGlq?=
 =?utf-8?B?cXlYcHF4YzlDMWh3MlRsYVRML0xhay9KM1RaL2tQODU0UEovejBKcEpuKzY2?=
 =?utf-8?B?Sm1VT1JvbkM5MU5SVnN1MkMvWmZjRFF6Z2svc05PZnV6QUREYTV3czNkRlNZ?=
 =?utf-8?B?MVhweGF2T3gzWDVnN0NORlkyZUhuUytONnBRWWFuYytEY3FtSDV2cWlsMmI5?=
 =?utf-8?B?eEVsMGxtcTA1WkpwVSsySk1qaHlLdEorVWZSWmk4NEJUK2NZajJmM05iNHdn?=
 =?utf-8?B?ZEYzQzBvYzU4VzZDMytYZUEzZzh6MkxXYkwvQ00vQm90K1kzcUdCTyswOEZ2?=
 =?utf-8?B?N2xOdHQxVDBjWmlNdzZJVnRQcWEwT3pEdXZ1OVdVUUVzOVQvNGRpdDhxUmRM?=
 =?utf-8?B?RGhiaVVONzVacFA3Y0JDOVFCM1ZLQkg0VWEyQjhQbFV1dnVYQ0NjanU2d3Vn?=
 =?utf-8?B?MTRGYlFjRGI2YVg1Ny9TRDgvNlc3VEV3ek0vQWhnaDM2N05GNnRHWi80V2pn?=
 =?utf-8?B?Slg5UXdQNjhsL3VwajZyd2NydXQ5Z2pkeWJlMlorYjRHeWhLRWswc0NIY3dK?=
 =?utf-8?B?TDlxWDRBUm5Fa2dubEIydld5dEU2a09FMVgySFplS2VUcitYYkZSVDhJRXZo?=
 =?utf-8?B?cTc0SzhlZXh4MG1LSldGdGNmMFdIOEZ0VTJ0UVU2aWtUcSt4TUQ1T1RUTlVx?=
 =?utf-8?B?UDV1L0pnRkRwdkNtZnN4SXFQdzN0T3ByNnk4aFRVSGxJZkxjWEIxbCtNYk5Y?=
 =?utf-8?B?bVhOVElydDVQY1U2UVludzJnN2lsUllMWGttMDdqZVRFc0h0c1V4Mzh1SWdk?=
 =?utf-8?B?bjZIRXdFQld6Y2FoRllxUjlCRktSdDlsNkdHUmFEQXdoN1JMV25wWndERkQ2?=
 =?utf-8?B?cVkzcVFkSkVpWXg2Y1JvY0pwNzdzTUowbEMvZW1mcGRVWkZOVGsrRWxwNmhs?=
 =?utf-8?Q?5mNgZvz41CbbsJtHT6972+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c687f23-23ad-46cd-30c6-08dbdba94f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:40:43.1070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/oZvj7VxZj17nPJc7IDJSKb1G0BnE4xzzCJBztkv1LryaIQmCUMqIulpDAKcEW37RQVUzbOBFa4EYb27xmGtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3797
X-Proofpoint-GUID: ovOGo5et3XV17-CvYL0_du95ak8uvYTc
X-Proofpoint-ORIG-GUID: ovOGo5et3XV17-CvYL0_du95ak8uvYTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_03,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 mlxlogscore=652 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyLCAyMDIzIDE6
MzIgUE0NCj4gVG86IE1heGltIFNhbW95bG92IDxtYXg3MjU1QG1ldGEuY29tPjsgQmVybmFyZCBN
ZXR6bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+OyBEZW5uaXMgRGFsZXNzYW5kcm8NCj4gPGRl
bm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4NCj4gQ2M6IEd1b3FpbmcgSmlh
bmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2PjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgQ2hyaXN0aWFuIEJlbnZlbnV0aSA8
YmVudmVAY2lzY28uY29tPjsNCj4gVmFkaW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGlu
dXguZGV2Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjJdIElCOiByZXdvcmsg
bWVtbG9jayBsaW1pdCBoYW5kbGluZyBjb2RlDQo+IA0KPiBPbiBUdWUsIE9jdCAzMSwgMjAyMyBh
dCAwMTozMDoyN1BNICswMDAwLCBNYXhpbSBTYW1veWxvdiB3cm90ZToNCj4gPiBPbiAyMy8xMC8y
MDIzIDA3OjUyLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE9jdCAyMywg
MjAyMyBhdCAwOTo0MDoxNkFNICswODAwLCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiA+ID4+DQo+
ID4gPj4NCj4gPiA+PiBPbiAxMC8xNS8yMyAxNzoxOSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0K
PiA+ID4+PiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAwMToyOToyMUFNIC0wNzAwLCBNYXhpbSBT
YW1veWxvdiB3cm90ZToNCj4gPiA+Pj4+IFRoaXMgcGF0Y2ggcHJvdmlkZXMgdGhlIHVuaWZvcm0g
aGFuZGxpbmcgZm9yIFJMSU1fSU5GSU5JVFkgdmFsdWUNCj4gPiA+Pj4+IGFjcm9zcyB0aGUgaW5m
aW5pYmFuZC9yZG1hIHN1YnN5c3RlbS4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBDdXJyZW50bHkgaW4g
c29tZSBjYXNlcyB0aGUgaW5maW5pdHkgY29uc3RhbnQgaXMgdHJlYXRlZA0KPiA+ID4+Pj4gYXMg
YW4gYWN0dWFsIGxpbWl0IHZhbHVlLCB3aGljaCBjb3VsZCBiZSBtaXNsZWFkaW5nLg0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IExldCdzIGFsc28gcHJvdmlkZSB0aGUgc2luZ2xlIGhlbHBlciB0byBjaGVj
ayBhZ2FpbnN0IHByb2Nlc3MNCj4gPiA+Pj4+IE1FTUxPQ0sgbGltaXQgd2hpbGUgcmVnaXN0ZXJp
bmcgdXNlciBtZW1vcnkgcmVnaW9uIG1hcHBpbmdzLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IE1heGltIFNhbW95bG92PG1heDcyNTVAbWV0YS5jb20+DQo+ID4gPj4+PiAtLS0N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiB2MSAtPiB2MjogcmV3cml0dGVuIGNvbW1pdCBtZXNzYWdlLCBy
ZWJhc2VkIG9uIHJlY2VudCB1cHN0cmVhbQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+ICAgIGRyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL3VtZW0uYyAgICAgICAgICAgICB8ICA3ICsrLS0tLS0NCj4gPiA+Pj4+
ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3VzZXJfcGFnZXMuYyB8ICA3ICsrKy0t
LS0NCj4gPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY191aW9tLmMg
ICB8ICA2ICsrLS0tLQ0KPiA+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
bWVtLmMgICAgICAgIHwgIDYgKysrLS0tDQo+ID4gPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd192ZXJicy5jICAgICAgfCAyMyArKysrKysrKysrLS0tLS0tLQ0KPiAtLS0tLQ0K
PiA+ID4+Pj4gICAgaW5jbHVkZS9yZG1hL2liX3VtZW0uaCAgICAgICAgICAgICAgICAgICAgIHwg
MTEgKysrKysrKysrKysNCj4gPiA+Pj4+ICAgIDYgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9u
cygrKSwgMjkgZGVsZXRpb25zKC0pDQo+ID4gPj4+IDwuLi4+DQo+ID4gPj4+DQo+ID4gPj4+PiBA
QCAtMTMyMSw4ICsxMzIyLDggQEAgc3RydWN0IGliX21yICpzaXdfcmVnX3VzZXJfbXIoc3RydWN0
IGliX3BkDQo+ICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiA+ID4+Pj4gICAgCXN0cnVjdCBz
aXdfdW1lbSAqdW1lbSA9IE5VTEw7DQo+ID4gPj4+PiAgICAJc3RydWN0IHNpd191cmVxX3JlZ19t
ciB1cmVxOw0KPiA+ID4+Pj4gICAgCXN0cnVjdCBzaXdfZGV2aWNlICpzZGV2ID0gdG9fc2l3X2Rl
dihwZC0+ZGV2aWNlKTsNCj4gPiA+Pj4+IC0NCj4gPiA+Pj4+IC0JdW5zaWduZWQgbG9uZyBtZW1f
bGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spOw0KPiA+ID4+Pj4gKwl1bnNpZ25lZCBsb25n
IG51bV9wYWdlcyA9DQo+ID4gPj4+PiArCQkoUEFHRV9BTElHTihsZW4gKyAoc3RhcnQgJiB+UEFH
RV9NQVNLKSkpID4+IFBBR0VfU0hJRlQ7DQo+ID4gPj4+PiAgICAJaW50IHJ2Ow0KPiA+ID4+Pj4g
ICAgCXNpd19kYmdfcGQocGQsICJzdGFydDogMHglcEssIHZhOiAweCVwSywgbGVuOiAlbGx1XG4i
LA0KPiA+ID4+Pj4gQEAgLTEzMzgsMTkgKzEzMzksMTUgQEAgc3RydWN0IGliX21yICpzaXdfcmVn
X3VzZXJfbXIoc3RydWN0IGliX3BkDQo+ICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiA+ID4+
Pj4gICAgCQlydiA9IC1FSU5WQUw7DQo+ID4gPj4+PiAgICAJCWdvdG8gZXJyX291dDsNCj4gPiA+
Pj4+ICAgIAl9DQo+ID4gPj4+PiAtCWlmIChtZW1fbGltaXQgIT0gUkxJTV9JTkZJTklUWSkgew0K
PiA+ID4+Pj4gLQkJdW5zaWduZWQgbG9uZyBudW1fcGFnZXMgPQ0KPiA+ID4+Pj4gLQkJCShQQUdF
X0FMSUdOKGxlbiArIChzdGFydCAmIH5QQUdFX01BU0spKSkgPj4NCj4gUEFHRV9TSElGVDsNCj4g
PiA+Pj4+IC0JCW1lbV9saW1pdCA+Pj0gUEFHRV9TSElGVDsNCj4gPiA+Pj4+IC0JCWlmIChudW1f
cGFnZXMgPiBtZW1fbGltaXQgLSBjdXJyZW50LT5tbS0+bG9ja2VkX3ZtKSB7DQo+ID4gPj4+PiAt
CQkJc2l3X2RiZ19wZChwZCwgInBhZ2VzIHJlcSAlbHUsIG1heCAlbHUsIGxvY2sgJWx1XG4iLA0K
PiA+ID4+Pj4gLQkJCQkgICBudW1fcGFnZXMsIG1lbV9saW1pdCwNCj4gPiA+Pj4+IC0JCQkJICAg
Y3VycmVudC0+bW0tPmxvY2tlZF92bSk7DQo+ID4gPj4+PiAtCQkJcnYgPSAtRU5PTUVNOw0KPiA+
ID4+Pj4gLQkJCWdvdG8gZXJyX291dDsNCj4gPiA+Pj4+IC0JCX0NCj4gPiA+Pj4+ICsJaWYgKCFp
Yl91bWVtX2NoZWNrX3JsaW1pdF9tZW1sb2NrKG51bV9wYWdlcyArIGN1cnJlbnQtPm1tLQ0KPiA+
bG9ja2VkX3ZtKSkgew0KPiA+ID4+Pj4gKwkJc2l3X2RiZ19wZChwZCwgInBhZ2VzIHJlcSAlbHUs
IG1heCAlbHUsIGxvY2sgJWx1XG4iLA0KPiA+ID4+Pj4gKwkJCQludW1fcGFnZXMsIHJsaW1pdChS
TElNSVRfTUVNTE9DSyksDQo+ID4gPj4+PiArCQkJCWN1cnJlbnQtPm1tLT5sb2NrZWRfdm0pOw0K
PiA+ID4+Pj4gKwkJcnYgPSAtRU5PTUVNOw0KPiA+ID4+Pj4gKwkJZ290byBlcnJfb3V0Ow0KPiA+
ID4+Pj4gICAgCX0NCj4gPiA+Pj4gU29ycnkgZm9yIGxhdGUgcmVzcG9uc2UsIGJ1dCB3aHkgZG9l
cyB0aGlzIGh1bmsgZXhpc3QgaW4gZmlyc3QgcGxhY2U/DQo+ID4gPj4+DQo+ID4NCj4gPiBUcmFp
bGluZyBuZXdsaW5lLCB3aWxsIGRlZmluaXRlbHkgZHJvcCBpdC4NCj4gPg0KPiA+ID4+Pj4gKw0K
PiA+ID4+Pj4gICAgCXVtZW0gPSBzaXdfdW1lbV9nZXQoc3RhcnQsIGxlbiwgaWJfYWNjZXNzX3dy
aXRhYmxlKHJpZ2h0cykpOw0KPiA+ID4+PiBUaGlzIHNob3VsZCBiZSBpYl91bWVtX2dldCgpLg0K
PiA+ID4+DQo+ID4gPj4gSU1PLCBpdCBkZXNlcnZlcyBhIHNlcGFyYXRlIHBhdGNoLCBhbmQgcmVw
bGFjZSBzaXdfdW1lbV9nZXQgd2l0aA0KPiBpYl91bWVtX2dldA0KPiA+ID4+IGlzIG5vdCBzdHJh
aWdodGZvcndhcmQgZ2l2ZW4gc2l3X21lbSBoYXMgdHdvIHR5cGVzIG9mIG1lbW9yeSAocGJsIGFu
ZA0KPiB1bWVtKS4NCj4gPiA+DQo+ID4gPiBUaGUgdGhpbmcgaXMgdGhhdCBvbmNlIHlvdSBjb252
aW5jZSB5b3Vyc2VsZiB0aGF0IFNJVyBzaG91bGQgdXNlDQo+IGliX3VtZW1fZ2V0KCksDQo+ID4g
PiB0aGUgc2FtZSBxdWVzdGlvbiB3aWxsIGFyaXNlIGZvciBvdGhlciBwYXJ0cyBvZiB0aGlzIHBh
dGNoIHdoZXJlDQo+ID4gPiBpYl91bWVtX2NoZWNrX3JsaW1pdF9tZW1sb2NrKCkgaXMgdXNlZC4N
Cj4gPiA+DQo+ID4gPiBBbmQgaWYgd2UgZWxpbWluYXRlIHRoZW0gYWxsLCB0aGVyZSB3b24ndCBi
ZSBhIG5lZWQgZm9yIHRoaXMgbmV3IEFQSQ0KPiBjYWxsIGF0IGFsbC4NCj4gPiA+DQo+ID4gPiBU
aGFua3MNCj4gPiA+DQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+IFNvLCBhcyBmb3IgMzEuMTAuMjAy
MyBJIHN0aWxsIHNlZSBzaXdfdW1lbV9nZXQoKSBjYWxsIHVzZWQgaW4NCj4gPiBsaW51eC1yZG1h
IHJlcG8gaW4gImZvci1uZXh0IiBicmFuY2guDQo+IA0KPiBJIGhvcGVkIHRvIGhlYXIgc29tZSBm
ZWVkYmFjayBmcm9tIEJlcm5hcmQgYW5kIERlbm5pcy4NCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJl
cGx5Lg0KDQpOb3QgdXNpbmcgaWJfdW1lbV9nZXQoKSwgc2l3IGludGVudGlvbmFsbHkgaW1wbGVt
ZW50cyBhIHNpbXBsZXIgcm91dGluZQ0KdG8gZ2V0IGl0cyB1c2VyIHBhZ2VzIHBpbm5lZCBhbmQg
b3JnYW5pemVkIGFzIGEgdHdvIGRpbWVuc2lvbmFsDQpsaXN0LiBJdCBub3Qgb25seSBzYXZlcyBt
ZW1vcnkgZm9yIHRoZSBzdHJ1Y3R1cmUgaG9sZGluZyB0aGUgcGFnZXMsDQpidXQgYWxzbyBtYWtl
cyBpdCB2ZXJ5IGVhc3kgdG8gcmVzdW1lIHNlbmRpbmcgb3IgcmVjZWl2aW5nIGRhdGEgYXQNCmFu
eSBhZGRyZXNzIHdpdGhvdXQgdHJhdmVyc2luZyBpYl91bWVtIGxpbmVhcmx5Lg0KV2hhdCB3ZSBj
b3VsZCBkbyBpcyB1c2luZyBpYl91bWVtX2dldCgpIHRvIGdldCB0aGUgcGFnZSBsaXN0IGFuZCB1
c2UNCnRoYXQgbGlzdCB0byBvcmdhbml6ZSBwYWdlcyBtb3JlIGVmZmljaWVudGx5IGZvciBhIHNv
ZnR3YXJlIHJkbWENCmRyaXZlci4gSSB0aGluayB0aGlzIGlzIHdoYXQgcnhlIGltcGxlbWVudHMg
dG9kYXkuDQpJdCBjb21lcyB3aXRoIHRoZSBwZW5hbHR5IG9mIGV4dHJhIGRhdGEgc3RydWN0dXJl
cyBiZWluZyBhbGxvY2F0ZWQNCmEgc29mdHdhcmUgcmRtYSBkcml2ZXIgZG9lcyBub3QgY2FyZSBh
Ym91dC4NCg0KDQo+IA0KPiA+DQo+ID4gQUZBSVUgdGhpcyBoZWxwZXIgY2FsbCBpcyB1c2VkIG9u
bHkgaW4gYSBzaW5nbGUgcGxhY2UgYW5kIGNvdWxkDQo+ID4gcG90ZW50aWFsbHkgYmUgcmVwbGFj
ZWQgd2l0aCBpYl91bWVtX2dldCgpIGFzIExlb24gc3VnZ2VzdHMuDQo+ID4NCj4gPiBCdXQgc2hv
dWxkIHdlIHBlcmZvcm0gaXQgcmlnaHQgaW5zaWRlIHRoaXMgbWVtbG9jayBoZWxwZXIgcGF0Y2g/
DQo+ID4NCj4gPiBJIGNhbiBzdWJtaXQgbGF0ZXIgYW5vdGhlciBwYXRjaCB3aXRoIHNpd191bWVt
X2dldCgpIHJlcGxhY2VkDQo+ID4gaWYgbmVjZXNzYXJ5Lg0KPiA+DQo+ID4NCj4gPiA+Pg0KPiA+
ID4+IFRoYW5rcywNCj4gPiA+PiBHdW9xaW5nDQo+ID4NCg==

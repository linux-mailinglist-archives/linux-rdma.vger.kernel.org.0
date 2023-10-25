Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6D7D6D18
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJYN2B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJYN2A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:28:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173D115
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:27:58 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDKBcW026038;
        Wed, 25 Oct 2023 13:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RjtX/5hh8/DkOUbCyjrxLYo75DC1z1LsJLuGMSfLtmU=;
 b=H6hUAq50KSdVQoTSHhVFsQ4/58QnaeKAJcnSVVr8ZYyq+//vMWsjz53OPFX/mpcLKMu+
 sH2Y4cvMSeXw0OQ6V+5l4bMJ7/nOVRzusCT3v0IvX2+KVmEdzfdDnaceTIg/AuM3JTQX
 vd3eXdk3FF1+oJcTZemNhRSN76wI5hlNO9HD8C2RrDwf2KpU88cKQxd6BDstCiqsMROK
 7j0B3+mkurzE+FcUS5ay6GwdVvzkEh8a1Rj74cq0SVEAypwl37oKCRHztqrovr14GjQA
 8lYRl7VLdRS3bXWDPWeuSmJr/GH1ENkpwUNG2Blqm2BXzJc8/mocw1sLgnVxUG+hy2FX Mw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3t9rabk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2rFZd7DZm5ItMVYmbJaCJ030p0nmfgGNtmq4X4a83yrnG5nGJAjluf7l7DTwvxwjbZG/NW5Ja1QP2r8FzDdg9Pb/siwTA97KoNu5Rf19mFx7+zEbw0ULBPihLMfJNC4abQciHXdIIPIQ6kHxT1vTTW+jidcOlP4n8BkvZBQMcLV//pJi2kUA4n/Fsc+RJIUUFySEJ2nKt+ttmYcrvaHZ1PA49vJNlZX52NhOcaUnHNHVVRHuMCruY8jQSj1Xk8863Jyv0x4L5neMkO5dZrjOOyj19mLaNfEIv9Ey3T9S4lNXpjGwo/Y4KjPKcWwIuqeHQQ8pJNl1dzUcavJ0EoGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjtX/5hh8/DkOUbCyjrxLYo75DC1z1LsJLuGMSfLtmU=;
 b=Dr88JL0U8qPzZtKzchVtGby7tsCTLMyVRCXqV1T4ybUPY5hWHtNO4mnjAChmT5fugkYCReJIhQHyQVhnXc1GFja4ouLs6NKHQE2+mLAsBnVr4NiszZfwL+nBTR3IsHYzl5/Ig/OMcVcr6wi7kjNf/+CSUQ51RqP7KagjQE2sL4x0kqTB+f1lx/AUo/4jTdFNvhcKxMwJGF7T8X8U4IDa6ZUf+1E08sSkkJ/HnJjfd2hyivXn0eOqO9CYBcw1U7i4WBD1yK6+UDz9BO0XNxpRPDeoD4wJwHi4zgzGeVRV8ej36Zz65S/JyMAE1UGhE/n61b+rlbokY4N3CuCimd8m7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CO6PR15MB4211.namprd15.prod.outlook.com (2603:10b6:5:344::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 13:27:50 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:27:50 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 18/20] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
Thread-Topic: [PATCH V2 18/20] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
Thread-Index: AQHaB0cN3eN/mrepR0WFiGT5pkdXPg==
Date:   Wed, 25 Oct 2023 13:27:50 +0000
Message-ID: <SN7PR15MB57558847D886D3A0F1882B7099DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-19-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-19-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CO6PR15MB4211:EE_
x-ms-office365-filtering-correlation-id: 884b590d-42d1-4e6d-160e-08dbd55e2f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvvxEURWGEQ2RhoMaFTwFZi4/nv0WG3s/7fdF50qo4wLVrY+rhSBsWKBvfNS8ub9Sz2I/IX7b9XsBjNuKeq0DUImj7MQ6jq6M56eohUljKVNWKyhwdEbOIkoJYe/I8nrF26vynJoTqxR1Fy6GRJpolMuoqg6Y+ve0xGWxoLNr9+1s43h1AWUIgM7OqQE+HpRCfA/uUsBOUBFExhoC+ub8QBSoGOGT838lL+Loaj/JqcGz6Va6x/Ht6NoKYwHA08a1oTaR1D8pK7iCzzL85v6QVzU8FcRDwdWXZDqvQHmbqhuarg+gM5yA+t9nsZvm2lZCfP4In4qbkg8eAiGW5t95Px6dckzwWMspDhVCrdidai2tCIOMGL3EL0X0T9QjW9DqiVWEGgyLmVgXO0v6fCoirIbwoRGh5HtGLPydjVT0J1nrHrTO7H9TTbVZgt/iSDRx9zux7QRRIaogOtVPSsHWXVl2GJGDbBKnl1hZGaF2fCNcPph2PDIJucfxD0YUG3l+B4FAHKU/c2qIJHMQ/BWi+6QbqLkeGtZJFgLo6isxF+M7UqKBgFx/mi2I9cIRREbXPCwr/4xcKtJwQ8KuDD1l3jEuTPWfYF271c/FZtRtRW4hl7LvT6FC3ILWvj33DkJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(478600001)(66556008)(66476007)(66446008)(66946007)(316002)(64756008)(76116006)(122000001)(110136005)(8936002)(4326008)(9686003)(2906002)(8676002)(33656002)(7696005)(38100700002)(6506007)(41300700001)(52536014)(71200400001)(5660300002)(53546011)(83380400001)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vlc4QWtDTkxScU80eGNkOTBEc3RUL2VjbkR5WDZBUVdlNmxQRGJTRldxNjJr?=
 =?utf-8?B?NjQrT01uTnVZUXFVQlMwM290ZS8rUjVzdUVNQk9vODlIVk1Mc1BOV2t3OGlT?=
 =?utf-8?B?YWIydThrZDBUVS9sNXF6dmgyUUQ4SmR5aDdCN0dTSVhMMkMxK0tvdHVpaHI1?=
 =?utf-8?B?VU9QTEVFVjdEK3NpelMvb21nYU5jY09xU0JrK0FnTWVhR3pMK1BBZkZGNEhR?=
 =?utf-8?B?dWpSWnQ2WTJ0SEVlWm8rUTByb3RqYlVIRnJuTVdFSkZ3RGI1N3NFL0E0eXlW?=
 =?utf-8?B?c2treWcyMWl5VzlUYVh0S3EyOEJJcnJwNlUxdndGZ1IwV2Z3elZ5eEJFL2Yx?=
 =?utf-8?B?TWZlekZzTnRXeWRsSzY2WmEwd1pkL3ZNeENXVkJDZ0NYZGhHcm9zYVZHUTY0?=
 =?utf-8?B?QnZUZGdOa3FRT0UvTXA1Rjc3Q1pVb2ZxRTFEVTFITkNicGJXKzVUUUQzcktm?=
 =?utf-8?B?ejh6aFlVMVJid3ZXYVpFRUIvZjJIL2wvazRUaU82L2FmVFhsd3pNQUMvK3gv?=
 =?utf-8?B?bDAzcjhTb0R3SC9HMkZZZ1YxZkMzek13V0hjQVkyclZUUHRZVmxGSjhGSmp4?=
 =?utf-8?B?enNoeFZ0a2Y5dkVWeGc4ajRWUm5sVU53bUN5WlFzejJrRkNRck5MaXlTbktj?=
 =?utf-8?B?bDlXVHpqTXp2ZE1rUEErV0hQcjBnazhSeEQvVEpQalVZdWdMME1MbU1IWkNW?=
 =?utf-8?B?YjlyazR1MUdqRm0wY2pUblppZjYvQ0hldFhqb1R6K2VCSTdxT3kxSzJxMTBp?=
 =?utf-8?B?aTNIRGFueVFHRUV2K0UrbWJrbEpVcU90MERxWjNwUjBlSGJzYk1yTlMvd0g5?=
 =?utf-8?B?RUlIMmpvMGN4dC91TmdTRE8raWpTeDFzRnJmSFlHcUVwb3JDVXQvMW9xYXVq?=
 =?utf-8?B?NmQ5YW1MOGFLL0lUMXJJb1c5THJ5M3AvbngxbjhmRlNIeldlYkwzRFMyOWNw?=
 =?utf-8?B?a25oaDU5NG43SisxMEg0ZlRoQlV6MjFzbWpEMCtMbU1NclliR2pQWmxma040?=
 =?utf-8?B?aXMvMk1MTWZ0ZTBXQ0Y0TitJcnA2cFNWOTZsZTNYL2syanRGWmVwSkpMZld5?=
 =?utf-8?B?KzZOcVpUNlNYOU02RlZXT0g5LzZNN2V2ZldEY3NXMUlqaHlBaExXeFNvdDNL?=
 =?utf-8?B?MS8vbHhxU2h4NWRnMEp3Q2h1djMwNEJvQ2FWL1k3N3RtWk9vamNwaGwxM3FP?=
 =?utf-8?B?VzNmNDNNa0FKdzg2K3l2dGx0ZG1NajJWVGNJOHRtNHRtTWoreUJ6dC9LMUdr?=
 =?utf-8?B?TG9rNGx3WjdOVDdVZG11KzVBb0N0bktBcnlGbVlLSjAvd2xMbTNma240OUVY?=
 =?utf-8?B?TEIrN1p6azdYYTVHTzJvZU1oNlY2Z1lKcERUVnhtVHJIR2ppZEZZYlN2U2NY?=
 =?utf-8?B?NGlsU1BVNkFHTHNRc3FtZEMxc1JhYTI0ek5rR3hBZmJDTVBFREpxRTh5MUoz?=
 =?utf-8?B?L25URGtZTnNnNm5oT0VGK2pyMFNEREd0N2xkOW9iVDFTM0RsYWxVUk01TEpT?=
 =?utf-8?B?c2R0M0IyS0FkRGVGVXBTK3NZRlNUWVVZZy92eXRhaVRXVmRCY0Y2YXpDNTVq?=
 =?utf-8?B?OUE3WHNMMlh3TnE3THBvNFYxa2I4Tlk0QjlBOUVORnJUR0NDUG04VTNKUy9B?=
 =?utf-8?B?QnpYdnpERE1Ed09TLy9KS3ZibStBeFNQSk1Ed1EyOVRPeVkvTit2VlhKSlJp?=
 =?utf-8?B?TXV6dklLeU9rdkJvTjhwa1o0OWI1YVRHOTFhRjdaQlJuTHZEZGREYlROcmtk?=
 =?utf-8?B?RFdReWYvcTRvdnZiYnFVR2kyU0JMbk92UmNkcEhST2JkbnR0cUZpT1J4REIw?=
 =?utf-8?B?RE1GZVhMZS9URUlOZnlKTjdvL2NJYkZITFdlS0tHVUZjRktXS3dJTm9wSENo?=
 =?utf-8?B?Qlh6cFB5MGRCaU9uaGo1TDBQZ2ZYV1oxa1lWS0Y3TnlzK3A4aHYrQnczcjhx?=
 =?utf-8?B?VDdvbCtDalNpWnh2cGpwUTNRR3ljZ2Y4NkFJQVNaWTZxbTJaL3hITjhrSC96?=
 =?utf-8?B?M2M1QW4rdGw5dDl3bFRQbGliNFJZeW5IUmVRU0RyNENjbmxOUDNad0RLOFpn?=
 =?utf-8?B?N3JPQ1RBc2J2aWNtTHJlSzFOanVaWCt1VnBEdHplNFBWbVYvWGlVM0pyZTA2?=
 =?utf-8?B?TW0zMkpvK3hsbVE3dEd4b0xXR05XSjBobnJCKy9uOWVtYnhqdXhRWHc3dFNx?=
 =?utf-8?Q?r3duHcfzDGnCX+KjDyWCN8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884b590d-42d1-4e6d-160e-08dbd55e2f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:27:50.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRyI5xptWu4QQ2zTeG3IQMoKf2eQOeBBieMNrHzX55JDJMomZlAiICkVqfhBFRc2UGnF/Nc6lj3Tk3tzHnlnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4211
X-Proofpoint-GUID: l849pMppf3VMgglzl1AU1Ro9OstZmz9G
X-Proofpoint-ORIG-GUID: l849pMppf3VMgglzl1AU1Ro9OstZmz9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyA0OjAxIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAxOC8yMF0gUkRNQS9zaXc6IE9u
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
bnVtX3JxZSk7DQo+IA0KPiAtLQ0KPiAyLjM1LjMNCg0KTm8gdGhlIG9yaWdpbmFsIGNvZGUgYWxs
b3dzIGZvciBhIFFQIHdoaWNoIGNhbm5vdCBzZW5kIGJ1dA0KanVzdCByZWNlaXZlIG9yIHZpY2Ug
dmVyc2EuIEEgUVAgd2hpY2ggY2Fubm90IHNlbmQgc2hvdWxkIGJlIGFsbG93ZWQuDQpPbmx5IGEg
UVAgd2hpY2ggY2Fubm90IGRvIGFueXRoaW5nIHNob3VsZCBiZSByZWZ1c2VkIHRvIGJlIGNyZWF0
ZWQuDQpLZWVwIGl0IGFzIGlzLg0K

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB05535D3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jun 2022 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiFUPVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350448AbiFUPVr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 11:21:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617928705
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 08:21:46 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LF4SMc017590;
        Tue, 21 Jun 2022 15:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=8jMDtfiNVeSvsnhoheuK5bzVBR5JUpNG16s5/5S6GZY=;
 b=mrGV4LUz2/EMm/by0gIwGPK6PodjAoX3a6nyRJ/71VaC2LvbaW1JiBNl9h2GfP6sbnKx
 C2HGxs4ppSlG1VJfOwnO1oocCT/Z9ushuBp/W9wSyfe/Z7CrBfYuveyi7e1X8vqBR/hg
 y+S/QybiZZix9TbrrkHz/UlYkXZJf7yZ8itR81FaD5v3hQzg/gub12StsI+DZUmfDioj
 4t5I/Y2xRYSVKeCMddK3rDvd9CXt/hzX2q8bZq0haYWAiRn8mwC4EEOGkfEQFgiOtiCr
 u2AGtRdPGVxFj4qzU+wvwHxw1OxILsDpdGk+okb7Ch+Q7kNH49k3/QYKCp1jLNjLIkeP TQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gugaerket-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 15:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs5XQj+F+6u58Qnu4O87JHx4ItngzlhPVGx5N5LD1aYJXezbiudWJwpW2x6uwAO1fWc7AE8Hjq4jdjPy1mFZvus8WrL1EPCck0rzyokumQLrtIXNkvCLxKz5BBHwYAXavZ8jvZ7jRpmKXa+Rxxu6Dq+y3NSXqG3xFk2UWFLwoJmLztHBwm1u1orG2TvFDpFTNtJ+0FWk8PZMpu5cg1T2cTwEV2/5D6DhAA8Vv1pC9vX+PQlMs7Sopfz9Qb/sxs73xgedys9vPlXl1VLx6MVJ6XGRK+dG5wTfR05mg/TpMEd0XmpKR93jnmE2HcYMogR3ZNdwFW8U2bMvDXmNS6fyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jMDtfiNVeSvsnhoheuK5bzVBR5JUpNG16s5/5S6GZY=;
 b=ll25/zY2i2TfBIbMsGcfioXC+lCeJ1icQruTQEJtke8eAfjneZ0Ez/QkvNnok81qPrl/N/gJHE0EqPnzHfVhu00F9hIrB60eiNUvNEtUJYpEIirMpVqGtX43vVtnyIrWKm93njapNkg03wX3t8z+ExRL+XUTUiin1HfK24hwQH8iHMmxbfJJ4FDuGQKjoVA2ZU8o3evOVAW79KagkIYXk6jFZHJucXZ9ROUe+WsJfkDh0IP4zX381Loxu6iLVlT0+cX2LFJRRzCihlWnnw7u6dOS1CLx1jWOLfGfqaIgvQRgo/9lN7H6hkkwiLSK7OKzi1YkDjOlpmDsgLogyKUIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2261.namprd15.prod.outlook.com (2603:10b6:a02:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 15:21:35 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:21:35 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Stefan Metzmacher <metze@samba.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 03/14] rdma/siw: split out a
 __siw_cep_terminate_upcall() function
Thread-Topic: [PATCH v2 03/14] rdma/siw: split out a
 __siw_cep_terminate_upcall() function
Thread-Index: AdiFeqNKf3BqT2AuSS23gzsR5UL6Ww==
Date:   Tue, 21 Jun 2022 15:21:35 +0000
Message-ID: <BYAPR15MB2631B6A8A95D157FFEC27F1A99B39@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34973f10-5914-4e2b-790e-08da5399bae3
x-ms-traffictypediagnostic: BYAPR15MB2261:EE_
x-microsoft-antispam-prvs: <BYAPR15MB226183287021969AD163575399B39@BYAPR15MB2261.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJnH3cmGGTBIW9HgfJpv+rAkjk893ksZiq05gVV3C4ge3Wd05zkzawjkLh7SqvWCNEDnpfqhrs8JTG9Jy+pe7gG1Zby28CfFEaqt9GUt3CfjIIpcZq4ebnETw4NIbJToaWEoqpd7paigM4x5dOIKxAT8d43z3PkTndiIoK6unVxcjHWb2bNYPUDBLn9UUIRDmh4RA9UuDEI8zG3/I9idJp7uPyMRnIZX862llcWXDkkMCUXLttFZ9oEROJnBlGqzwsTjYQ+sccCyjUJ0yLpf2ATyc7JzFhTmcLZiXJTyQogNiFna+3a/4izsUuuWxRtt70smfdtIfdgYH2Ll02zmZEzx6WHpQZj3u+iRM1H4d9Z74teMVU1mtslDOwxdaMU4fDuMM9cxsHDdPvXLIwOOP7DFOSPjSDd9uaY2vWjJnYFI3gaN26tQDXb9ytVhc6tKCDJKLST440HhgGN98MUztqlEwdiuBSc9GwkijlkSEBl1H+MW1F8jK1fbZxEcpHU92hgVFwdS5VY++TOe4rIkqQ4XsrGxFF1AYchNRIjIffejDA8SGY+mvqwzqQPiLYmpHWFj3cM6zwt6o1vNyKatAOpnm6inYGQEVRGm3IdGZTBCsfnbJxZgreMXpka4CqN/53PnWBrpZfbIUFgjUClDqcgHYUbExepKBKZjC+GlgBPkQ5w5gQru5NBAZtM0yRMuswXYctEeawr1W1UE7BNPTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(396003)(366004)(8676002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(33656002)(52536014)(8936002)(5660300002)(2906002)(55016003)(9686003)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(7696005)(6506007)(53546011)(76116006)(71200400001)(316002)(478600001)(86362001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDBHa3dvWVFmdmlnU1V6cTc3N0NQa1V5cFBGZWl0RnZvWStCNmdBbEYwQXBP?=
 =?utf-8?B?MTBYRFhtWDl0ejcxOEdxN0tpdGZkWk4wbWZYSklSZ3poRFMwL04wdEVoZ05Q?=
 =?utf-8?B?UmFuWWFjbnlHMGtxMEM1anpCbVJ4UEJ0SmtPTzNiNzBuNUV3WlRxN2tOWHF2?=
 =?utf-8?B?UWhLN0JpVWIxWVJQZXlrQlNtR0Qvc244OTVLbkx2N0M1TkRDWmtxRFF3eDNP?=
 =?utf-8?B?OHduNjlzcW90Z0Y3TDVEOTBTbEQ2RTBhTlZNbDZ6V0l1dG11MUh6MFBqaWVQ?=
 =?utf-8?B?d3E5bGU4aEFDVzE4dGFiRUdTdk1mNUlYVzVnV1VWZ2pubC91SzlnRjBwWits?=
 =?utf-8?B?YVNzVW5uYm5iRmhTZ0ZFbUpSYWx1RVoyV1ZUQm9uNTBLb0k0M0Z2aUZrdWkz?=
 =?utf-8?B?dUVaMkltUjN2TEhIa0ZwL1BoM0ZHbThUTlN3TGY2ZmtaRUI4eXVBTkMvZ09K?=
 =?utf-8?B?R21VMXRBY0w1QXRQRkhWSnRsRWhwTnF6Qzc2ZSt2eUlQUnA3bFVwNlVLNzhF?=
 =?utf-8?B?YzBjZmpPWlJJQnF3bEFsQ1RESTVGSy9QZDZMRnJJSGZxUCt2Q01vbnhFODZS?=
 =?utf-8?B?N1hiaXQ3alhHUjZSbXhSNmJiMllRUm11Rjdad0JnWWlRSUwxMVc3NlpGVnQy?=
 =?utf-8?B?NXFpcGovbk1xRksxTWRxSm9Jdmt3TE1vemVyR2JvdWptS2dxRDU4SEVGTG1V?=
 =?utf-8?B?eHpPY0RZZThmTk1tYmNuNmRRUkhwek4rT2crRG11TG9SVkhMTUl4d09iL0Rh?=
 =?utf-8?B?UkZBNFBkeGxsRFhtTzJxOTU4alhIemtDMGNtTGVhWUlNcGxYclUwMFhvZVlW?=
 =?utf-8?B?REJhUThKOGl4UEh0NEE1bmVpNVBEL0t0MEtLNHdwdGw4YUpRY0U1RzVGUito?=
 =?utf-8?B?emJzVHE2bTNiNWx4NXYzK0JqZ0NhOEJXS2VtSVRaY2JOelZ0N1UyTkw2WmtL?=
 =?utf-8?B?blIrSms2NzNCMFFjMkRranB2aUZ2WnE1NVkwR1J4TXdrcmpJYXFzK3pRendU?=
 =?utf-8?B?a2NYVGRxVkt3cmZhbzZsRTliZUp4NFp3K0NVVGxVMGJOREk4WmUzOWp2WjM1?=
 =?utf-8?B?UkF6OENJek9mdUZzUXhUZTNYWE9VS3FnTHF5eitET3pyWTNxeTA1SC9hR2t6?=
 =?utf-8?B?clRjU2xxTGpvS2V3WGtqL1FISHFxM2c4cXoxQ2xiVmF5clFpQXRTNkF4YWRj?=
 =?utf-8?B?T3liWXJRR1l2Vld2ZUJQdmt3azRtZ0NNRldMaTdnZHk3czM0UFdSenNjQlh3?=
 =?utf-8?B?eW5ENmdwMDY3UHNsY3o3UGZ3dFR3LzhXcWlIWXZtVU84WkhkeXdldDFlZ2hT?=
 =?utf-8?B?Yml3N3I4cWxWVVR4M0NOTFpjM3M3UGg5VkdJdk4xMDNWczRZKzh0Vi9ub0Ns?=
 =?utf-8?B?bmR1QTJ4Y0pxaWZGZ3dEcU50NVErczIzSUIza202eTRpejJ3OUdDQUFIbnRZ?=
 =?utf-8?B?TkVtVXFLc1hIbjI4T0ZVYnRka2pydXJtYXpCSWtVTW05eS9ndWhhRldEYmpw?=
 =?utf-8?B?dmNFOTdCUC9QYTNERmpOZDdSWXM1eUgyWkNWT0c2dHJ6Y0RMamQxZkNESG5Y?=
 =?utf-8?B?cFdPTnN1MnFYc2FUVDRuZzd5ZUY5TkQyakExNWFFbkRrU0VOZS9Ka0JRSmND?=
 =?utf-8?B?ZUp1MzNQTms4eFA2Mk50ZkRmN1NjcDJ0My9zZTZmSnNLYlRvZjdXTnVWcnNz?=
 =?utf-8?B?RVh6Tkwxdk5hUmQyd2hSVXFkSTlxOU9WazI5T2hBZ3NHaEdORU9VM0VBZFVO?=
 =?utf-8?B?N0ZzRCtCUFFWbTh1UFhIU2orUkRBWEZCWUc4NytoSmdNKzNUendkbENtT0Np?=
 =?utf-8?B?Skh5S0Z6Y1JlaElmQzRSenZYM2ZheVVTbjlPWW13M3BqR1hWQXBJZzVmbHZo?=
 =?utf-8?B?cFlYcWVSWGFFVzMrN0F1MHRUdFB1dGkrTkJmUFpNaXFsQXpPdkxjYzNXWVZt?=
 =?utf-8?B?TVFNelNudkhYSlQ0VHlWT3lOcHVVdlIxaExCeGkwa2p1MXhWUE1KNkhwVmh2?=
 =?utf-8?B?SW9ubGZtSW9wOUllVzBlRnlDT0N1aVhtS2pkcFJ1djhRQ2QvVGFGdkxFajNB?=
 =?utf-8?B?NHEwRnZwUzdsa0JuN3NHQ3ZQQWN1MGt2cDNVWmMxaDBxME9YSWhUVE5KcGdI?=
 =?utf-8?B?ZjRQbnI5NVBGQnp1S0dPT3l0eHFFK0FOdCs3bHN2V0wzQkxLMjd5Q2F0K1pn?=
 =?utf-8?B?eWhnT0ptN1VrSjVZRndkR3Z0Yzk4QzYwYjRmMTBuR3FVcmRJaHpRS1FJOEk1?=
 =?utf-8?B?eS9lM1IwY0JGM3VDME5MQ1FKRU1FSU1jNWFmWWc0MEV2Y1RtT0owOEtTZzlP?=
 =?utf-8?B?THRFWjltakhKeFcrQ2tPRk4zb1YxODlRcEplWGVqdVFWaGJtTXorSkNSSU1L?=
 =?utf-8?Q?LkKTIuMzSs4QyntZ1QAFWI097ULAYPwSRrgF2t5Gc2iDy?=
x-ms-exchange-antispam-messagedata-1: /qidR8oXuVhgZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34973f10-5914-4e2b-790e-08da5399bae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:21:35.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RDsQGpbpV9wk1wV832FNE8oU2jSvL37aBwvPVkDZF1+c99kXxtR9FqEIQDwB2XoRSw4JrztcoGjGbOCRaI0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2261
X-Proofpoint-ORIG-GUID: TQoV01bceqNRD5tMAvKN1H1I5ey6zqUl
X-Proofpoint-GUID: TQoV01bceqNRD5tMAvKN1H1I5ey6zqUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_07,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=926 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbiBNZXR6bWFjaGVy
IDxtZXR6ZUBzYW1iYS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMTUgSnVuZSAyMDIyIDE3OjI3
DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnDQo+IENjOiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3Jn
Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCB2MiAwMy8xNF0gcmRtYS9zaXc6IHNwbGl0
IG91dCBhDQo+IF9fc2l3X2NlcF90ZXJtaW5hdGVfdXBjYWxsKCkgZnVuY3Rpb24NCj4gDQo+IFRo
ZXJlIGFyZSBtdWx0aXBsZSBwbGFjZXMgd2hlcmUgc2hvdWxkIGhhdmUgdGhlIHNhbWUgbG9naWMu
DQo+IEhhdmluZyBvbmUgaGVscGVyIGZ1bmN0aW9uIHRvIGJlIHVzZWQgaW4gYWxsIHBsYWNlcw0K
PiBtYWtlcyBpdCBlYXNpZXIgdG8gZXh0ZW5kZWQgdGhlIGxvZ2ljLg0KPiANCj4gRml4ZXM6IDZj
NTJmZGMyNDRiNSAoInJkbWEvc2l3OiBjb25uZWN0aW9uIG1hbmFnZW1lbnQiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPg0KPiBDYzogQmVybmFy
ZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2Vy
bmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMgfCA1
MyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBp
bnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfY20uYw0KPiBpbmRleCBlZWIzNjZlZGJhMmEuLmM1ZWY1ZGU3ZTg0YyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+IEBAIC0xMDMsNiArMTAzLDM3IEBAIHN0YXRp
YyB2b2lkIHNpd19zb2NrZXRfZGlzYXNzb2Moc3RydWN0IHNvY2tldCAqcykNCj4gIAl9DQo+ICB9
DQo+IA0KPiArLyoNCj4gKyAqIFRoZSBjYWxsZXIgbmVlZHMgdG8gZGVhbCB3aXRoIHNpd19jZXBf
c2V0X2ludXNlKCkNCj4gKyAqIGFuZCBzaXdfY2VwX3NldF9mcmVlKCkNCj4gKyAqLw0KPiArc3Rh
dGljIHZvaWQgX19zaXdfY2VwX3Rlcm1pbmF0ZV91cGNhbGwoc3RydWN0IHNpd19jZXAgKmNlcCwN
Cj4gKwkJCQkgICAgICAgaW50IHJlcGx5X3N0YXR1cykNCg0KDQpGb2xsb3dpbmcgY3VycmVudCBu
YW1pbmcgY29udmVudGlvbnMsIGRvbid0IHVzZQ0KJ19fJyBpbiB0aGUgbmFtZSBvZiB0aGF0IHR5
cGUgb2YgZnVuY3Rpb24uDQoNCj4gK3sNCj4gKwlpZiAoY2VwLT5xcCAmJiBjZXAtPnFwLT50ZXJt
X2luZm8udmFsaWQpDQo+ICsJCXNpd19zZW5kX3Rlcm1pbmF0ZShjZXAtPnFwKTsNCj4gKw0KPiAr
CXN3aXRjaCAoY2VwLT5zdGF0ZSkgew0KPiArCWNhc2UgU0lXX0VQU1RBVEVfQVdBSVRfTVBBUkVQ
Og0KPiArCQlzaXdfY21fdXBjYWxsKGNlcCwgSVdfQ01fRVZFTlRfQ09OTkVDVF9SRVBMWSwNCj4g
KwkJCSAgICAgIHJlcGx5X3N0YXR1cyk7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2FzZSBTSVdf
RVBTVEFURV9SRE1BX01PREU6DQo+ICsJCXNpd19jbV91cGNhbGwoY2VwLCBJV19DTV9FVkVOVF9D
TE9TRSwgMCk7DQo+ICsJCWJyZWFrOw0KPiArDQo+ICsJY2FzZSBTSVdfRVBTVEFURV9JRExFOg0K
PiArCWNhc2UgU0lXX0VQU1RBVEVfTElTVEVOSU5HOg0KPiArCWNhc2UgU0lXX0VQU1RBVEVfQ09O
TkVDVElORzoNCj4gKwljYXNlIFNJV19FUFNUQVRFX0FXQUlUX01QQVJFUToNCj4gKwljYXNlIFNJ
V19FUFNUQVRFX1JFQ1ZEX01QQVJFUToNCj4gKwljYXNlIFNJV19FUFNUQVRFX0NMT1NFRDoNCj4g
KwlkZWZhdWx0Og0KPiArCQlicmVhazsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lk
IHNpd19ydHJfZGF0YV9yZWFkeShzdHJ1Y3Qgc29jayAqc2spDQo+ICB7DQo+ICAJc3RydWN0IHNp
d19jZXAgKmNlcDsNCj4gQEAgLTM5MywyOSArNDI0LDkgQEAgdm9pZCBzaXdfcXBfY21fZHJvcChz
dHJ1Y3Qgc2l3X3FwICpxcCwgaW50IHNjaGVkdWxlKQ0KPiAgCQl9DQo+ICAJCXNpd19kYmdfY2Vw
KGNlcCwgImltbWVkaWF0ZSBjbG9zZSwgc3RhdGUgJWRcbiIsIGNlcC0+c3RhdGUpOw0KPiANCj4g
LQkJaWYgKHFwLT50ZXJtX2luZm8udmFsaWQpDQo+IC0JCQlzaXdfc2VuZF90ZXJtaW5hdGUocXAp
Ow0KPiArCQlfX3Npd19jZXBfdGVybWluYXRlX3VwY2FsbChjZXAsIC1FSU5WQUwpOw0KPiANCj4g
IAkJaWYgKGNlcC0+Y21faWQpIHsNCj4gLQkJCXN3aXRjaCAoY2VwLT5zdGF0ZSkgew0KPiAtCQkJ
Y2FzZSBTSVdfRVBTVEFURV9BV0FJVF9NUEFSRVA6DQo+IC0JCQkJc2l3X2NtX3VwY2FsbChjZXAs
IElXX0NNX0VWRU5UX0NPTk5FQ1RfUkVQTFksDQo+IC0JCQkJCSAgICAgIC1FSU5WQUwpOw0KPiAt
CQkJCWJyZWFrOw0KPiAtDQo+IC0JCQljYXNlIFNJV19FUFNUQVRFX1JETUFfTU9ERToNCj4gLQkJ
CQlzaXdfY21fdXBjYWxsKGNlcCwgSVdfQ01fRVZFTlRfQ0xPU0UsIDApOw0KPiAtCQkJCWJyZWFr
Ow0KPiAtDQo+IC0JCQljYXNlIFNJV19FUFNUQVRFX0lETEU6DQo+IC0JCQljYXNlIFNJV19FUFNU
QVRFX0xJU1RFTklORzoNCj4gLQkJCWNhc2UgU0lXX0VQU1RBVEVfQ09OTkVDVElORzoNCj4gLQkJ
CWNhc2UgU0lXX0VQU1RBVEVfQVdBSVRfTVBBUkVROg0KPiAtCQkJY2FzZSBTSVdfRVBTVEFURV9S
RUNWRF9NUEFSRVE6DQo+IC0JCQljYXNlIFNJV19FUFNUQVRFX0NMT1NFRDoNCj4gLQkJCWRlZmF1
bHQ6DQo+IC0JCQkJYnJlYWs7DQo+IC0JCQl9DQo+ICAJCQljZXAtPmNtX2lkLT5yZW1fcmVmKGNl
cC0+Y21faWQpOw0KPiAgCQkJY2VwLT5jbV9pZCA9IE5VTEw7DQo+ICAJCQlzaXdfY2VwX3B1dChj
ZXApOw0KPiAtLQ0KPiAyLjM0LjENCg0K

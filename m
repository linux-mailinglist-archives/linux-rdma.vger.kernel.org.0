Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF86A564A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1KFy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 05:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjB1KFs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 05:05:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17E2D162;
        Tue, 28 Feb 2023 02:05:45 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S8jQoU021744;
        Tue, 28 Feb 2023 10:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=P/1rJnMaradjfHLVwjpSMklU5Jy5NaaGVr1INxHKuNM=;
 b=auHiDG/Qx3HOVp0VvItx2UgVzbUXVc69Ou9uRTINUGwjmtI6YmjmMz3Ny/yoZ4ucs745
 NWmrAyA2+NHYCi6NC4zjAKy6SlJS/kTJZW6f9IxsLqrSeKOkFywIJvav0RyQqsCtZSKx
 /uHFRIRdXyA/1DU6VUmfStSSdNVGSBc/TpKZk4fjvqnYnUUxgItktDj335iayY8tAOVy
 kYYSQHUpg20x+87+xo14JBJ5JdK7HM/ziqgPrw7o4bDz9fuDrZMoZWNGPZfoAxphqky9
 QGO8IdlryEzwU63JKTzp7juKAz1Mbf6uPFLYWL5mQxhsFzf8fvY/dSEx21IkHxW4zhSc rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1ecs1y5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 10:05:32 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31SA0b5n012934;
        Tue, 28 Feb 2023 10:05:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1ecs1y54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 10:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJLkVR4/ArDYzSU8ie3DdINiPCH0nWHVT7SGCHuzm2SYejhhsj5iqFSGuE6+ISO6S04fHA7gpIMWItIi9DD3JLF0CzwYHPwNwn4hpDOfmwNWQ6c9IJCX+WmtgTCd75yTKx3Ii4kUbSh60vgqbBz6hNy+VVEk1WkX1aP40ETHmq7+0Zhr/kLbAOP1poF4eVPbfRl3gYQ9rjMQv/DHVdKPTXKCb3rUQk9ToIAGHA/bl6CSCdbIKdgaylOOtAQS+DREAyKs15CDcUd7j5Oa1d2MaxRwYyNwVu1LgNCEJN4FUXc1FDVv/IIiu5tcBSC55L6Q67mKmNi9Hz+tP7uDhowLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/1rJnMaradjfHLVwjpSMklU5Jy5NaaGVr1INxHKuNM=;
 b=n1eyWQDumLA4fH/TqvSIHxHOLgfCGE7kixJ92CTye5m2JBvchxCNyet+tL+Zm8Y4kytXMlTtu6GHYEc22o3AxYUWtviVi85+6IKaWNWnhHNV5pJvTULlPBLKWCKRrDeePncRHTYIqCnX/HZGuSSXS6OuTWZxGi0h1q1gIUj/uP8D2DdKhubQe7FdITXNWLFyRWD7nK042Z0GF8F4mzWJHclTOz09QUiYkpVvC82nu9Uc5P3tKhrIktbkC0IzSr6YqwS40G7xnSlb7Exb7X/QX+l1b1QPVfj0lz6ZSeZLgoENrezCfotUY8eQkaVKgDi63yo7Y1aGbwKWgeQsgjB/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SN7PR15MB5731.namprd15.prod.outlook.com (2603:10b6:806:34f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 10:05:29 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%5]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 10:05:29 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Daniil Dulov <d.dulov@aladdin.ru>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: Fix potential page_array out of
 range access
Thread-Index: AQHZSoxwTqfI0qCJq0u8FLWy0dCSsq7kIpTQ
Date:   Tue, 28 Feb 2023 10:05:29 +0000
Message-ID: <SA0PR15MB39195D9A37167945185F819F99AC9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20230227091751.589612-1-d.dulov@aladdin.ru>
In-Reply-To: <20230227091751.589612-1-d.dulov@aladdin.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SN7PR15MB5731:EE_
x-ms-office365-filtering-correlation-id: ecb0e5be-49ca-4ae8-58cf-08db19735229
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYCTmKB+JqfyAfw0tKyMoJobKrkcN/QOi7LmCYM0wdCoV0yM5G6pEJOh8ozA1G1cKr/mc0e07NsJl34zn0z1xl3+HgJBIQE1oq6WaYDruSNmwkkuMnX46FNmwkij3X5vTlZkf1FiJounuOnFMp6XcawtZc9d/W3G7g6LgN/CXpj87aJkdWxKTvKn16EvNE7FLP7A5J6zBmvTgqs7Qu+Ik86QuE8uBeGPpYUxNV2R6RsF85/CsfNpEx9c35gjQJB0MOr5BFcbUVDtD4jxYQPAIJyZJhp5K5GnVbH6buB7ZVHKLU7Mvm2aWPaka3EMgwnAOa/EhxpiJH8xZPW8cbl+3kVroa0qxaV4tExOM0HKeG/yrzbYy2StAnDbxPD93Bx3hXgTjpKERSAIAtvRfGDI/sj67K+n81SNB6jVfC0n9TFPKTPE6DJbtoM6+VmQemLEGAt7iWMWfk7cAJK9nPal6U01F4UTxHfgtq4Wg/FbZvQ6JqAfoJWSk2TWsTdFmWmL8aL+LXp+LhePXiFxSPKtMH5qYP90yzpZqXjVb6piH8mdEdTNMY9ZoHSq+SGLOHpeqe3NnYy5pgutdml8INe83dNFbRVPGznIRnom8XTk1xkBP38AQSjxBU1ljS5LexL/aTFAR1cybafN/UBY6oiAgvnt1DdwOGjzwQORf3soUdhtbR2YNM1KBJij/GeuXMayMuJj6ANdbE1XdX8AGr//mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(83380400001)(316002)(54906003)(33656002)(4326008)(122000001)(38100700002)(66446008)(6916009)(55016003)(64756008)(8676002)(6506007)(186003)(9686003)(7696005)(71200400001)(66556008)(76116006)(86362001)(66946007)(478600001)(66476007)(41300700001)(5660300002)(38070700005)(53546011)(8936002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTk0QW1OTHR2eHdYekVJNFVkVFc4ZGxwem4wWTRhbmRTUWdOb3Z5QzFUTXBK?=
 =?utf-8?B?UEhlSDRMZXNSUW94VzdhNVZhT1lxQWw0elBGSkNkVDREYXRBU011UytiZ1I4?=
 =?utf-8?B?c282eml2TzdFaGVYSk54Mm9KMEg5NjZETVArNG5iZDlCMlN3NEhCRk5ST0dB?=
 =?utf-8?B?UzlMVzdxMzBrSjBicUZhVCtvTmg5WE0xcG1RMkJXMEVrbWRtSVp5bkgwNlQw?=
 =?utf-8?B?ckVzTHV6V0ZENmg3UkdNVER4azh4NEhBOHVlRjVic3NxRlU2SmVXL0VvZzZG?=
 =?utf-8?B?OGFoem9DTmYvMmVFOGFuSjMzZ0NHaXRSNi9oUnd0eWRCdDR5Z0ViVW83RkYv?=
 =?utf-8?B?NXhiMzI2VkdoMUIvTncxSEhSVDJpSFRaYnJsMjNrQXQ4a0liSCtuTjZwdlV2?=
 =?utf-8?B?YjNYNHRzd3BHSVQ3bVNvRDRBSlhXNUIvU0xlTGw1YTU1empVVkFsczZ6b29x?=
 =?utf-8?B?WlZZMlJNNDBQdCtISTkzaEJ5TS91OW9nQnhpUkZmYVhEeUZSditJcjdtODRE?=
 =?utf-8?B?aWorYmRuSUR0WHNtcExCMGpDOXkyQjdTamRIRm85ZW9zV2RoeGpvdjFsaG5Z?=
 =?utf-8?B?bFRwOHZtSDF4OXE5VDhJZGxsVjc3NzZ5OEhWQmtrTlhIS1pQdDVIOGlzWG53?=
 =?utf-8?B?MnpoK0dkajVhWHRQazdCbXVoMUUzZ3gya3hFcEgrOW9HTnBmQ0FnR3dXVUxj?=
 =?utf-8?B?TThyRHgyZ056VFhHaHZqSzZOQzBPZ0tiUCtmcGtaOTBIMEo2L1UrTEhJUTdO?=
 =?utf-8?B?SHJEUWF4U1Fpamlkc0kxQjhjNWlLTmNaTDdPSFNQdElnUkx0TmRJcTYrY3hJ?=
 =?utf-8?B?SXZGNENtWk0zZWFoQmtaaVBXbkp4ZUhGSHhVMUZJQ2JTZ2FiK2RDZStqbEcw?=
 =?utf-8?B?Nlg4WGZWWS8wd0dkcEZkdmhENjZLU0ptL01lTDBKVkYrNmN0R1UrQ3Z3b0t4?=
 =?utf-8?B?SDZMNWFWV2dtZGxiUVAyb3kvbTRrbVVYODRWWEtNN0QxOGlGM3NZUkVrb1dj?=
 =?utf-8?B?YnF2Z1UxRURzVG16em1sdFo4eXN2d28wbmNEaFlHQ0d1SkVNTThyUXJlT1Vm?=
 =?utf-8?B?NjZDajhVRk8wSDY5RzRVeHM1eEY5RUd1WVArUlcrWmUvSUl6SVhuVFByM2RR?=
 =?utf-8?B?NkZNS3lidUdqNDBMMExXZytOK0dpblBpbWdoeS8wRzl6TUlBbkdxVlk0TldH?=
 =?utf-8?B?WnhnejlTYzdPek5zK1Z6OUZBRjU0WElXcnNMNm9DR1BnSzZQbThkVlZia0tn?=
 =?utf-8?B?NENEYi9KemhMRVBId1krWmRrWUxyWUF3dEZMNVpCMGdWOGRwK085MEowaXd2?=
 =?utf-8?B?enl4Tnc0RXJMUDNWcXREdHNZVE5XNWFVOWd0MGc4WVJLYldUMkJjRjB4UytI?=
 =?utf-8?B?cGdULysrOHBwaG5kQmQ3UjlMbm8rNTN3Yml3ZFB2WmgxVXpobnBhMWRjdHdO?=
 =?utf-8?B?bHY2bHU1Skw1RksyQUszMzFFUnpvcmpXakYzeENtNS9aaldKNThJRW1uOWll?=
 =?utf-8?B?UWUyUTRxSUk5ZUViOWpPeEVNM28xMzNIS3BIWmdKdlRxdUpINUtzZmtYQXlU?=
 =?utf-8?B?N0twUHJKRDNEeEY5S3pjUGNmbC9PVmNjamdNM1lrN3FVS0F3eUcxZFBoWHJk?=
 =?utf-8?B?M0VkT0wyUVRjWm5HZXJaM1YxclhPOWFoNWZBdEh2SU5nTXVXSGIwclRKbDMv?=
 =?utf-8?B?MUdKVHhtamFsYU0yTFUweHB0Y09QZ1gzckNycnVnQnpaQlpac3pQMmlFSEZp?=
 =?utf-8?B?K3A4ZVlLaG1CbGpvWnhRQUFBOVhZaUtTdEdLbVJwbVpuZHAxYzJXbFR4U1Rh?=
 =?utf-8?B?RUlNWkIxbWRLdmhCWmNJdnVmMHdFYnNBWVU3MGcyOVFpaWg2eGVZa0cvZDRy?=
 =?utf-8?B?Qm5iSEt1ZU15VXlGeGlza2hHcHFNV3dXL0pZNEpVeUYvV016MjZOYjR5S3Rm?=
 =?utf-8?B?eis1T1lqNmhoTHVIUkJKZ2ZSNTZHekkxVlY3NTZmYUY2VHNKL1U4Z2NINDc5?=
 =?utf-8?B?TlU5Y3VpMEVMVzc1SmR2cVd5a0V6TVZZQ2pPUG9EMEhIUzhTYXNzcHhDVFZC?=
 =?utf-8?B?azI1Q1BiQ3BPSzlvMjhvN3UraWdFcWFHV3oxUHQxeFp0N1ovS2x2d1c2dkt6?=
 =?utf-8?B?R3RvTllBMEdRSEp1ei9KQXFETmx4S0tJOXpZY0pFQnpodTEvc0pTYjFqaHN1?=
 =?utf-8?Q?29qCsf4uD58Gm1frXn5p/Mo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb0e5be-49ca-4ae8-58cf-08db19735229
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 10:05:29.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgfeA2KP89yh88oNfeCHuu79nY28q00/Zy2m60siqnwUXtxmgt6y1FueastGPIpfUV4xd47ZwANjiS9CLNWOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5731
X-Proofpoint-GUID: cjnwM1qNmpFhabqLUBo35AjVzbJ0-no-
X-Proofpoint-ORIG-GUID: CunBswya_EWIcKCxwVSLRKS13TwePvZw
Subject: RE:  [PATCH] RDMA/siw: Fix potential page_array out of range access
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWlsIER1bG92IDxk
LmR1bG92QGFsYWRkaW4ucnU+DQo+IFNlbnQ6IE1vbmRheSwgMjcgRmVicnVhcnkgMjAyMyAxMDox
OA0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBEYW5p
aWwgRHVsb3YgPGQuZHVsb3ZAYWxhZGRpbi5ydT47IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRAcmVk
aGF0LmNvbT47DQo+IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsdmMtcHJv
amVjdEBsaW51eHRlc3Rpbmcub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIXSBSRE1B
L3NpdzogRml4IHBvdGVudGlhbCBwYWdlX2FycmF5IG91dCBvZiByYW5nZQ0KPiBhY2Nlc3MNCj4g
DQo+IFdoZW4gc2VnIGlzIGVxdWFsIHRvIE1BWF9BUlJBWSwgdGhlIGxvb3Agc2hvdWxkIGJyZWFr
LCBvdGhlcndpc2UNCj4gaXQgd2lsbCByZXN1bHQgaW4gb3V0IG9mIHJhbmdlIGFjY2Vzcy4NCj4g
DQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcp
IHdpdGggU1ZBQ0UuDQo+IA0KPiBGaXhlczogYjliZTZmMThjZjllICgicmRtYS9zaXc6IHRyYW5z
bWl0IHBhdGgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5paWwgRHVsb3YgPGQuZHVsb3ZAYWxhZGRp
bi5ydT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0K
PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gaW5kZXggM2MzYWU1
ZWYyOTQyLi5mOWViMzE0YzZlMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9zaXcvc2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
cXBfdHguYw0KPiBAQCAtNTQ4LDcgKzU0OCw3IEBAIHN0YXRpYyBpbnQgc2l3X3R4X2hkdChzdHJ1
Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LCBzdHJ1Y3QNCj4gc29ja2V0ICpzKQ0KPiAgCQkJZGF0YV9s
ZW4gLT0gcGxlbjsNCj4gIAkJCWZwX29mZiA9IDA7DQo+IA0KPiAtCQkJaWYgKCsrc2VnID4gKGlu
dClNQVhfQVJSQVkpIHsNCj4gKwkJCWlmICgrK3NlZyA9PSAoaW50KU1BWF9BUlJBWSkgew0KDQpB
YnNvbHV0ZWx5ISBGb3Igc3VwZXJzdGl0aW91cyBwZW9wbGUgbGlrZSBtZSwNCm1heWJlIGV2ZW4g
d3JpdGUgJz49JyBoZXJlLiBUaGFuayB5b3UhDQoNCj4gIAkJCQlzaXdfZGJnX3FwKHR4X3FwKGNf
dHgpLCAidG8gbWFueSBmcmFnbWVudHNcbiIpOw0KPiAgCQkJCXNpd191bm1hcF9wYWdlcyhwYWdl
X2FycmF5LCBrbWFwX21hc2spOw0KPiAgCQkJCXdxZS0+cHJvY2Vzc2VkIC09IGNfdHgtPmJ5dGVz
X3Vuc2VudDsNCj4gLS0NCj4gMi4yNS4xDQoNCg==

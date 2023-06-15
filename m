Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD297311F0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbjFOISb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbjFOISa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 04:18:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC371FE4
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 01:18:28 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8Gmtx015507;
        Thu, 15 Jun 2023 08:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=j6/Ixx5XTc9/O70PyIB6t0rqYEEBnywO/zEehfnLcUU=;
 b=mDlQms6pxCv/eL0omVCdchdw29DUMNNTJqWU8zZxHBf7lN8Cd+f+/wafHzPMkvSTQ/Pr
 9q2yOnGhtRvC8rNm/qfmWqM+yNw7MkGsj1KTBdN7EYCq+oOwAdXOdk14h7axyP9ThCwv
 zAkOy+kM8rP0MlBhbsHlde4CvIEjvj4iQ09MKAQqYcfzyO0cfcyqKjpBNzmZc8WU24Li
 736js4hvS6rjBt/HkfZlitJI7APTwtbm41iqGYD/ji5D/xon0OhdG4bV+LTsQWrXTyc9
 TD+Z5C6lmFzFHuiys8eZOXbluLRPtCP3OVQei8AcFqZ5itIHgnbipaqMdcyuJR208W4F rQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7y0bg0xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 08:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhXYKt4yZ5ortKKW6sFQ7jK6avJqyaBlaUJIM98OWEk4gFj4iFJ9pkJKW/R5ZR8pMbcxg+KJtKJdK1/iK4vqBrg+D/kyyDkXEyq4ST14R0+ASPb/zko8296F8UD8W1a/glbIKX+eMHS1inXXnFa9q0+ZdW2P+HKd1WmjSWcdqzGRpRSV0YmazigRPvQpfoIbWQR9JeucGxwwmUXZHdj80HyvU2OtWZBtuGnBL2oWdMWBjzERH/tNqoNfCT8Iboy9bTQhSb+K6bOKfPAySvX0/Z67/V+Dd15HEV18ma7GNs/kqu/zvl5rMQrzQl/Zmgy/XtJzfy2u9ayN74NoEm9BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftotMXhIKbI/1Xlts3n63Gni5gLBl8mQ85tFegzRXfc=;
 b=dKhP+cypdKQBmWZgkRlCFNWAhF8s9CQdgZ1z8MS9MsY0SxetB6C9zywofanhiKHlAeM8Fx5tJNYkjt6Lc7C6M+gvjddCvobVhgh7m2+tU02DcVGPYoTx+F1a7+z/xITcxNtFolQLEQ1KgZfRDf96vAZV3txyOL9I/D1xSltURbLKLfowr5lCd9qTPa2KdYpmdqtsiHQ6D8IT3RwpwS4pVIWba3WUJDh1e5H3tqdX1InDfd5NyPYUriQqSU1T37vk2O4wkVg/txUiFUq20qbrKBauVenplctRhEJX+mA1gNFupuUAqjG1yc1YTfD44p4qRzvDdhUAloGTfDjgjSsg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DM4PR15MB5429.namprd15.prod.outlook.com (2603:10b6:8:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 08:18:16 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::4f3d:f859:e527:bc9c]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::4f3d:f859:e527:bc9c%3]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 08:18:16 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>
Subject: RE: [PATCH v3 1/4] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Thread-Topic: [PATCH v3 1/4] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Thread-Index: AQHZn2HveL3n6YBA80WDj9MUyESKqg==
Date:   Thu, 15 Jun 2023 08:18:16 +0000
Message-ID: <SA0PR15MB3919C08C57C9415B6F914EFF995BA@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675124033.2279.4244453854641171409.stgit@manet.1015granger.net>
In-Reply-To: <168675124033.2279.4244453854641171409.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|DM4PR15MB5429:EE_
x-ms-office365-filtering-correlation-id: bb79c149-ecd7-43f4-f9bc-08db6d791201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhgAx00NKFaYAfuyOmrMB3rJGMOdXGwGS9u/LVyjjFkNNv08zmtcH8j/6ImlFz3QbGwAVZVebUuY9Yzdah+6HMR7NwgqWUICpUo0E8ereh05CikVXW19XZFVfHrOKDXDOOW5oH23b6ZBlEm396n8jWWqxsjkxC/GLVkkRrsSS38vbvZ/5tZzy/E/+1WLJ1UTvL5W8Rgw/MMPG9gc1aW1c/HzKdjsGEQ50JkKqm0lsf0szH24Hwz/zRxgTCGpZtqbU1V15H0q8neyJaaAh9hjQcmdbkT5dwOdjL5ssuFRRPIi1s0RKDLVfKNbFlgkVuWxzDON5w8FiXSp9syVTC+pJISFqZ11PJwtQ5SEBgpZrlyU/zm7FRovHb3g5b4Upfbkb3lcFn8XrAit1a5vvbx7VicSAhXfS6T/E43WtjDoltmX3TZjXJ+1fR2VykQQdVU0j2MHoMR8UR4CoTgFyoP1GhLuPxjJgm4sIsAWnU3hXtNee/kKLCA/7pv8kmGahVqMHhas0cvbUmc31DP0cGuzk+3bIafBjJQWpqMPN3H1sQHyrQkh0x7KpadRFr6QUAyZj35vlQC86hkagYBAxd5fgfcVXfKW3pANWCAq1aQ/Nms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(55016003)(83380400001)(122000001)(33656002)(41300700001)(316002)(38070700005)(38100700002)(71200400001)(7696005)(6506007)(26005)(966005)(9686003)(4326008)(19627235002)(66476007)(66446008)(64756008)(66556008)(53546011)(66946007)(76116006)(8936002)(86362001)(52536014)(5660300002)(8676002)(2906002)(54906003)(45080400002)(478600001)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHA0UWJtandub1V5NGZqeW13Qk12MWZzc1NmZXpHOS9Oc1RXa1FROTloc1pM?=
 =?utf-8?B?SGhJaC9QbE1rK3pyVWw0b2lIZEFET2gwVEZmTzB3R3YxWERlYTNmZjZnc1Zx?=
 =?utf-8?B?OHd3WXIzWlhrT0dhaG00WFB2SVVuR0tTZm56aFl0VlVyU2pXejVUSEk2eG01?=
 =?utf-8?B?RDN1UVo0TDVyZElyM1ZPSTNFcnlpU2hBS3Q5WmtEdEtnZW91UFBTYXB1YmNi?=
 =?utf-8?B?NVIrSVN3Y2FpU1ptbEZONjRvTjhyMDNwemhGalUzdU0rRis1MFA4dVk1cGcw?=
 =?utf-8?B?c1dWRE5nZzRscXlUU3c3akMyQm9TNlZDREVxQU1WNTJ3aU9EVW1pODhTdDJN?=
 =?utf-8?B?d0ZpZitaUFN1Uk5OU1RYL1Npdy84aEcySi9Cc3VMdFJWd1VTUXN0ekpodXJp?=
 =?utf-8?B?TEdGTEp3RTVySEp2T1dPSFhGRHZXTDhnVm5lSVZZbnNib2NKVDBHMU9SSmdq?=
 =?utf-8?B?WGZqUUExUmh6RVpXMUVFOVhlNU9VbUlGWTgyOXhRQTNIVFhFQVhkdWRSNlJG?=
 =?utf-8?B?VUQ1c1BZTnROa3lvaGNZRUEvVXNMOXcrSVB4d1lhRFBPK1VrZHRCeUpFb0c5?=
 =?utf-8?B?Rk9NbEREZHNSeTY4YnY0NkRIY1hGQUtlTXh2cUhrUWtaV3ZPNExUWlI4YXBY?=
 =?utf-8?B?OHIvWEs1VzIyL0JVVmFsZWNmNUlvb2N6dlo0eTZsZlcrTzkvd3JVOVAzYklM?=
 =?utf-8?B?MjVyUXdONkIwSzRtYUQ3bnJOZ24xcEM5UFdLTmswaWI0VlRhMGxreHhQNDFJ?=
 =?utf-8?B?MDhPbWw2aEFJd2hCejVtQzlZUkkyUEhySk5hT0VZSmRwemFJdHhvbDlOS0hH?=
 =?utf-8?B?aGlvZkJBd3dpZlE3QmRKT3V2S3pieUNzZHAwNXljeldocVVBUzdZNHEraGpo?=
 =?utf-8?B?R3J4UGhDaEtHL0VuVUNKN3BaTDRQVnRmekxtVGZkdFAvRldyUkxyMG5YZHh3?=
 =?utf-8?B?b0xCZVN1ZWxmK0xIeWRJbFM4VVo4UWNYZXVHTTQwbnhuVnRYSFFBeEpEcDdl?=
 =?utf-8?B?amhQa2V4M3M4S0JnQWt2bUllYzgyNkNZU1VqcTMxQWxza05kSmoxejhJTVdY?=
 =?utf-8?B?U1ZzNHZlVS9mSzZqQTlFWWJXNmVMamVoZVJyeUN3T2N4eFM2cDVGTWt1NGdN?=
 =?utf-8?B?UGNHZlhJSzRSam1vaUk3Z3dKRkhoUDV6VFRmNFFYQi91bmk5TGdzTjBzemJ3?=
 =?utf-8?B?MVYzMFZ0ZTl0Q2lteTNTcE5ZT3ZpdlM1RkFmT3NjRVBHK2ZqSitJYWh4RFNy?=
 =?utf-8?B?bzR4RTh6TENFcGc2Y0xBVU9iTWxHREVjOXI4ZDR6Z1FReXRVMVBrNjZLNzlw?=
 =?utf-8?B?TENidE1wV0lONUtuWFkrWS93ckJpZGkxa2RrZEV6VUk5OHVPQzZMcmhQdWsr?=
 =?utf-8?B?VTNQSTdlTTFTN0UySk8zVmRKTEdVekhpZjhtZjd6b2poQkhOQm5vdEpyTHMw?=
 =?utf-8?B?RUowY1cyRXA3WDV0RUwxcHQ0QkllUEJHTW9UWDlHTGFHSXhvMVI2VnZFVk5l?=
 =?utf-8?B?RnluZnFvWjRhUUJSMnBlSFJSR0V6QUY5amd6SGhVdDBvUjJlV2drOVlRVzVX?=
 =?utf-8?B?NFUzSWhESmIvQ0QvU29hZXJTNnZUZGJ0czRWWi9IMW8zQVpCcEhPU1BEZWxD?=
 =?utf-8?B?dDJTdDh3aDdrcHlzSnFQOU0xeWNMbkwxdExmVlkvV0RkejFZL3dDcjRNdXFX?=
 =?utf-8?B?bkU1VTd0MUpWTFVyY2pRd3RYUllNZWRIK3VONXd2TTdrb1JZM0RHdHU4RXZN?=
 =?utf-8?B?dVFLNEhkTTVNUFVFU1U0TnlrUXB4dGZGdWExVkJtNHZjeXh1NEt0VzNYRE9h?=
 =?utf-8?B?eWdWdThta0E2RWd1SzZZbmVFNUtIblV0eFdUSytHaUJFc0M1UzdhVVF0SkV6?=
 =?utf-8?B?V2ZlY2J4YW9WWHAwQlYxYmdvRzFYdUMwc1ZzQkJScFpjSjdWMDZtVngwTG9r?=
 =?utf-8?B?T3IyaXpwUUpXSnJPNTNncVJZamhNNGZtZGNNNitiK1hhM3FldmZ3ZHZydmNF?=
 =?utf-8?B?UVMwWXpBUVVqQUhoRlFnSVE1VlpuQU9oUW5rQlZ2cUtvb0VpSjdBanFLRUdN?=
 =?utf-8?B?NFJTYUovWTNzZ0tNa1RISEZ6RWVETmxvdEpBc1hWci8wWmNDRkhjakQyeWxL?=
 =?utf-8?Q?M2S0=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79c149-ecd7-43f4-f9bc-08db6d791201
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 08:18:16.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwCBBGVgvTyypSSzSBMlmQvns7C6Y/CDGBnslb3X7KEVq+SDoL+pFewLp34kPGmRONDdi5EwM4Ts/53CRHGlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5429
X-Proofpoint-GUID: bWbA4QJFpjcUxZnZiIBEdc_XZFkIrwNU
X-Proofpoint-ORIG-GUID: bWbA4QJFpjcUxZnZiIBEdc_XZFkIrwNU
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNl
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDE0IEp1bmUgMjAyMyAxNjowMQ0KPiBU
bzogamdnQG52aWRpYS5jb20NCj4gQ2M6IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPjsgQ2h1
Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+Ow0KPiBsaW51eC1yZG1hQHZnZXIua2Vy
bmVsLm9yZzsgdG9tQHRhbHBleS5jb207IEJlcm5hcmQgTWV0emxlcg0KPiA8Qk1UQHp1cmljaC5p
Ym0uY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCB2MyAxLzRdIFJETUEvc2l3OiBG
YWJyaWNhdGUgYSBHSUQgb24gdHVuIGFuZA0KPiBsb29wYmFjayBkZXZpY2VzDQo+IA0KPiBGcm9t
OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gDQo+IExPT1BCQUNLIGFu
ZCBOT05FICh0dW5uZWwpIGRldmljZXMgaGF2ZSBhbGwtemVybyBNQUMgYWRkcmVzc2VzLg0KPiBD
dXJyZW50bHksIHNpd19kZXZpY2VfY3JlYXRlKCkgZmFsbHMgYmFjayB0byBjb3B5aW5nIHRoZSBJ
QiBkZXZpY2Uncw0KPiBuYW1lIGluIHRob3NlIGNhc2VzLCBiZWNhdXNlIGFuIGFsbC16ZXJvIE1B
QyBhZGRyZXNzIGJyZWFrcyB0aGUgUkRNQQ0KPiBjb3JlIGFkZHJlc3MgcmVzb2x1dGlvbiBtZWNo
YW5pc20uDQo+IA0KPiBIb3dldmVyLCBhdCB0aGUgcG9pbnQgd2hlbiBzaXdfZGV2aWNlX2NyZWF0
ZSgpIGNvbnN0cnVjdHMgYSBHSUQsIHRoZQ0KPiBpYl9kZXZpY2U6Om5hbWUgZmllbGQgaXMgdW5p
bml0aWFsaXplZCwgbGVhdmluZyB0aGUgTUFDIGFkZHJlc3MgdG8NCj4gcmVtYWluIGluIGFuIGFs
bC16ZXJvIHN0YXRlLg0KPiANCj4gRmFicmljYXRlIGEgcmFuZG9tIGFydGlmaWNpYWwgR0lEIGZv
ciBzdWNoIGRldmljZXMsIGFuZCBlbnN1cmUgdGhhdA0KPiBhcnRpZmljaWFsIEdJRCBpcyByZXR1
cm5lZCBmb3IgYWxsIGRldmljZSBxdWVyeSBvcGVyYXRpb25zLg0KPiANCj4gUmVwb3J0ZWQtYnk6
IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPg0KPiBMaW5rOiBJTlZBTElEIFVSSSBSRU1PVkVE
DQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfbGludXgtDQo+IDJEcmRtYV9TQTBQUjE1TUIzOTE5ODZD
MDdDNEQ0MUUxMDdFNzk2NTk5OTRGQS0NCj4gNDBTQTBQUjE1TUIzOTE5Lm5hbXByZDE1LnByb2Qu
b3V0bG9vay5jb21fVF8tDQo+IDIzdCZkPUR3SUNhUSZjPWpmX2lhU0h2Sk9iVGJ4LXNpQTFaT2cm
cj0yVGFZWFEwVC0NCj4gcjhaTzFQUDFhbE53VV9RSmNSUkxmbVlUQWdkM1FDdnFTYyZtPXc3bVFO
RnpBYVRTT3lkMzRWRkhxS3ENCj4gTGtrQ2dBYXpaUDJONEFBSWh2WVNlR3AxWXFsNnpGbDVzUlNJ
NW1lNFpQJnM9aDRvVUR3cE1FQ3BJTUdtbw0KPiBudVhUY3BxcERSSXZXQlFXcTMyQUxWUFNRamsm
ZT0NCj4gRml4ZXM6IGEyZDM2YjAyYzE1ZCAoIlJETUEvc2l3OiBFbmFibGUgc2l3IG9uIHR1bm5l
bCBkZXZpY2VzIikNCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCAgICAg
ICB8ICAgIDEgKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jICB8ICAg
MjIgKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfdmVyYnMuYyB8ICAgIDQgKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npdy5oDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiBp
bmRleCAyZjNhOWNkYTM4NTAuLjhiNGE3MTBiODJiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npdy5oDQo+IEBAIC03NCw2ICs3NCw3IEBAIHN0cnVjdCBzaXdfZGV2aWNlIHsNCj4gDQo+ICAJ
dTMyIHZlbmRvcl9wYXJ0X2lkOw0KPiAgCWludCBudW1hX25vZGU7DQo+ICsJY2hhciByYXdfZ2lk
W0VUSF9BTEVOXTsNCj4gDQo+ICAJLyogcGh5c2ljYWwgcG9ydCBzdGF0ZSAob25seSBvbmUgcG9y
dCBwZXIgZGV2aWNlKSAqLw0KPiAgCWVudW0gaWJfcG9ydF9zdGF0ZSBzdGF0ZTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiBpbmRleCA2NWI1Y2RhNTQ1N2IuLmY0NTYw
MGQxNjlhZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiBAQCAt
NzUsOCArNzUsNyBAQCBzdGF0aWMgaW50IHNpd19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IHNpd19k
ZXZpY2UgKnNkZXYsDQo+IGNvbnN0IGNoYXIgKm5hbWUpDQo+ICAJCXJldHVybiBydjsNCj4gIAl9
DQo+IA0KPiAtCXNpd19kYmcoYmFzZV9kZXYsICJIV2FkZHI9JXBNXG4iLCBzZGV2LT5uZXRkZXYt
PmRldl9hZGRyKTsNCj4gLQ0KPiArCXNpd19kYmcoYmFzZV9kZXYsICJIV2FkZHI9JXBNXG4iLCBz
ZGV2LT5yYXdfZ2lkKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC0zMTMsMjQgKzMx
MiwxOSBAQCBzdGF0aWMgc3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3JlYXRlKHN0cnVj
dA0KPiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ICAJCXJldHVybiBOVUxMOw0KPiANCj4gIAliYXNl
X2RldiA9ICZzZGV2LT5iYXNlX2RldjsNCj4gLQ0KPiAgCXNkZXYtPm5ldGRldiA9IG5ldGRldjsN
Cj4gDQo+IC0JaWYgKG5ldGRldi0+dHlwZSAhPSBBUlBIUkRfTE9PUEJBQ0sgJiYgbmV0ZGV2LT50
eXBlICE9DQo+IEFSUEhSRF9OT05FKSB7DQo+IC0JCWFkZHJjb25mX2FkZHJfZXVpNDgoKHVuc2ln
bmVkIGNoYXIgKikmYmFzZV9kZXYtDQo+ID5ub2RlX2d1aWQsDQo+IC0JCQkJICAgIG5ldGRldi0+
ZGV2X2FkZHIpOw0KPiArCWlmIChuZXRkZXYtPmFkZHJfbGVuKSB7DQo+ICsJCW1lbWNweShzZGV2
LT5yYXdfZ2lkLCBuZXRkZXYtPmRldl9hZGRyLA0KPiArCQkgICAgICAgbWluX3QodW5zaWduZWQg
aW50LCBuZXRkZXYtPmFkZHJfbGVuLCBFVEhfQUxFTikpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCS8q
DQo+IC0JCSAqIFRoaXMgZGV2aWNlIGRvZXMgbm90IGhhdmUgYSBIVyBhZGRyZXNzLA0KPiAtCQkg
KiBidXQgY29ubmVjdGlvbiBtYW5nYWdlbWVudCBsaWIgZXhwZWN0cyBnaWQgIT0gMA0KPiArCQkg
KiBUaGlzIGRldmljZSBkb2VzIG5vdCBoYXZlIGEgSFcgYWRkcmVzcywgYnV0DQo+ICsJCSAqIGNv
bm5lY3Rpb24gbWFuZ2FnZW1lbnQgcmVxdWlyZXMgYSB1bmlxdWUgZ2lkLg0KPiAgCQkgKi8NCj4g
LQkJc2l6ZV90IGxlbiA9IG1pbl90KHNpemVfdCwgc3RybGVuKGJhc2VfZGV2LT5uYW1lKSwgNik7
DQo+IC0JCWNoYXIgYWRkcls2XSA9IHsgfTsNCj4gLQ0KPiAtCQltZW1jcHkoYWRkciwgYmFzZV9k
ZXYtPm5hbWUsIGxlbik7DQo+IC0JCWFkZHJjb25mX2FkZHJfZXVpNDgoKHVuc2lnbmVkIGNoYXIg
KikmYmFzZV9kZXYtDQo+ID5ub2RlX2d1aWQsDQo+IC0JCQkJICAgIGFkZHIpOw0KPiArCQlldGhf
cmFuZG9tX2FkZHIoc2Rldi0+cmF3X2dpZCk7DQo+ICAJfQ0KPiArCWFkZHJjb25mX2FkZHJfZXVp
NDgoKHU4ICopJmJhc2VfZGV2LT5ub2RlX2d1aWQsIHNkZXYtPnJhd19naWQpOw0KPiANCj4gIAli
YXNlX2Rldi0+dXZlcmJzX2NtZF9tYXNrIHw9DQo+IEJJVF9VTEwoSUJfVVNFUl9WRVJCU19DTURf
UE9TVF9TRU5EKTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd192ZXJicy5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0K
PiBpbmRleCAzOThlYzEzZGI2MjQuLjMyYjBiZWZkMjVlMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IEBAIC0xNTcsNyArMTU3LDcgQEAgaW50IHNpd19xdWVy
eV9kZXZpY2Uoc3RydWN0IGliX2RldmljZSAqYmFzZV9kZXYsDQo+IHN0cnVjdCBpYl9kZXZpY2Vf
YXR0ciAqYXR0ciwNCj4gIAlhdHRyLT52ZW5kb3JfcGFydF9pZCA9IHNkZXYtPnZlbmRvcl9wYXJ0
X2lkOw0KPiANCj4gIAlhZGRyY29uZl9hZGRyX2V1aTQ4KCh1OCAqKSZhdHRyLT5zeXNfaW1hZ2Vf
Z3VpZCwNCj4gLQkJCSAgICBzZGV2LT5uZXRkZXYtPmRldl9hZGRyKTsNCj4gKwkJCSAgICBzZGV2
LT5yYXdfZ2lkKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IEBAIC0yMTgsNyArMjE4LDcg
QEAgaW50IHNpd19xdWVyeV9naWQoc3RydWN0IGliX2RldmljZSAqYmFzZV9kZXYsIHUzMg0KPiBw
b3J0LCBpbnQgaWR4LA0KPiANCj4gIAkvKiBzdWJuZXRfcHJlZml4ID09IGludGVyZmFjZV9pZCA9
PSAwOyAqLw0KPiAgCW1lbXNldChnaWQsIDAsIHNpemVvZigqZ2lkKSk7DQo+IC0JbWVtY3B5KCZn
aWQtPnJhd1swXSwgc2Rldi0+bmV0ZGV2LT5kZXZfYWRkciwgNik7DQo+ICsJbWVtY3B5KGdpZC0+
cmF3LCBzZGV2LT5yYXdfZ2lkLCBFVEhfQUxFTik7DQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiANCg0KVGhhbmsgeW91IENodWNrLiBMb29rcyBnb29kIHRvIG1lIQ0KDQpSZXZpZXdlZC1ieTog
QmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=

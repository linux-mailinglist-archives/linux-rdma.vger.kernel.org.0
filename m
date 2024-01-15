Return-Path: <linux-rdma+bounces-631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967882D916
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8791F21FA7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jan 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8211CA0;
	Mon, 15 Jan 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H8zlDlD+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C9168A4
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jan 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FArksj014165;
	Mon, 15 Jan 2024 12:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=6Km7mWQEW9PO4cP3pwMzJiTmgoad+wOy9KyOJRzLsBE=;
 b=H8zlDlD+u0cP99h/hX8Whjxz1uRlPQMemgOQ41C0B0nEBbyzI7c4xM2fkpA99lBzBu9D
 2I4pWSO2kueiu7A2bO2Esj/TnTvIbtBddUWBli1Y9wZcf4gsLe0rO9EJD72fnuQVt845
 6spTAz8Uwyso0FJ8Mk+001XeRAtk8vHIxnmONC6t8M32W+EyCTFLZKDzUqDOY90QvagR
 CyTTmDlUGNp/RK4vAHZjYIQ00lWK090OjorA2N+7fW9FZKQnah7vVZjwbij1Cu/181Y8
 SXqsxRmC6K2fIIxIAB206gNVX7UJmcOi6fqLQFjP9rZkGNWsOieDOEgdjKedqL6D9Wp5 DA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vmtsdw41y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 12:52:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Huu+gy+o7lDL3xv5ggB8dF4oty3n6oR33Rvg64b3Ge8fzxQ+XtIjO1rIpOxzO/1Ur4J0T7ulzZPrvYd1leXGOClGUALqHjfQ4BQi9rOGyd5mGK6ONqLDGlS+ktGi5wiFw+FPG0coV4sRK6H3fNQQXPQc6sKSo3n1zU/B0xhZpIwI7JxMrZ6k61rvLCLNstz9dduWj9UPiVjqX9cnKAiPrfV3ubiG9LqkUdh5fcr0hB3rrp43CO6wHqimEuSGOqTgWzQXKEyWygDGm2QwEDfdd4aemNyzSadmr5SwDVA8GgB2ugmqfuL3vcIFdLY07j5597JJAlrw8zUC1FdMvIgaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvxYoWt3EcK43LO3pYdmje457pAkMrPdGPrYCQOg6S8=;
 b=Y2Tx4slreKS8tSPPROUFFnQdN14+yArxlv54s1kXCW0COTUFkBn1RG0TDxx35HzeE6UHsFSZZDFfbLn8j/1FeXbr2WYs+4qNhU1nOXspUYYXnPKFrF0krgK0BrfiGVnhvSwh73C39m0im0KpDfDhcQBLns4CxWVahs6pBz5En971qvFzxltPPcMAz497QHPln2PY5pv3V2JOstlHWSQEhLNuYv5Dpq6huj43Ys8fVIYqQuwWbg3SLSZPgjDtxQDDohd0srHkl5Sq4Rs95hgg5lPHqg4WlIS2okyuiptUW6ZzzBhAP9XjGpi+is99S9B782upNZ6x9V5VR4sA/YJzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SJ2PR15MB5764.namprd15.prod.outlook.com (2603:10b6:a03:4d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 12:51:32 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::50ab:bebe:ec96:195b]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::50ab:bebe:ec96:195b%4]) with mapi id 15.20.7181.015; Mon, 15 Jan 2024
 12:51:32 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Leon Romanovsky <leon@kernel.org>,
        "bugzilla-daemon@kernel.org"
	<bugzilla-daemon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [Bug 218375] New: warning compiling siw_tx_hdt:
  the frame size of 1040 bytes is larger than 1024 bytes
Thread-Index: AQHaR44ED2QdmIc0W0GbA4JbWUDzLLDa0Fbg
Date: Mon, 15 Jan 2024 12:51:32 +0000
Message-ID: 
 <BY5PR15MB3602973D49F95B2F96787B1D996C2@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <bug-218375-11804@https.bugzilla.kernel.org/>
 <20240115083655.GA8117@unreal>
In-Reply-To: <20240115083655.GA8117@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SJ2PR15MB5764:EE_
x-ms-office365-filtering-correlation-id: 0727f09e-7fcf-4460-9877-08dc15c8b33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cjddZdYOlBAvCaw57/HRjDCmrSfncX8eY7LV/sq6NB+4/OAkdHQNWtu83IxzfSxRhWRgVbEBm8aRZSkHUSiNJkoMY2Fq8Z6hBkoVbjyft1RwQahxI6dOTnfuwSPRCRTwPVIasyUV+v07zaW4HIv7hQXyscBMjLLCyi2pdMTI85WYqhyq7px5Fuhb+l2NDylYZkuaE3tgzuGJuMnb5YCeBh2HyvSRgUG4C/0zU9HQ+V0a2r21x2PuYV+BI51kFDcQN6Wam59QuEuLsQaoRKoYZqiATZwpn9e2lHisrJ8MMP7UgZbDcQpP6uCk27Yu2kCbIyPGUYlaUEuU0yWH1pikGxqDAiBUkJ5Nk1sgCSutKbQ+eGAOw4NkUzWaAlNVLCrNrU/tNETo0YeuwU31ykYeAtlx2sdGRsH51Bv4Uxp95Lf0+ApGdvVNAVtSgt1NybibXpFktwpPwdYUxEe8NWHGLTT70DWFi2leSvhrRXF5+sEEkkfDQ7HefInLBSS8S8qnwK4vzlqoqTWfUa5eo5TXmfxMUH3ErSGNGeK4xhAzeefR7HOLGspE0dSoPD+yU/neoylBVCzlIRFnbzDwCARplsKhqUZVxkDLrfrvS34DUq+yP/48lDWTuFDGxycRiVY6skINZTvQzmM2gq3PH4cJeg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(478600001)(33656002)(19627235002)(71200400001)(53546011)(7696005)(9686003)(38100700002)(6506007)(966005)(8676002)(8936002)(66556008)(66946007)(76116006)(316002)(64756008)(4326008)(86362001)(66446008)(66476007)(52536014)(110136005)(55016003)(122000001)(5660300002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VDVidVVOdDlzRlVEMm9EZmlQOW5RVG1zMmVwSTlDRlBMMDFWd0lnc0I1c0d4?=
 =?utf-8?B?eEhmWlAzYW1Sbk04V0dKZ25ZdnRranNCdjQ2dE5leWxaRDlBZkZWTVRWb3VY?=
 =?utf-8?B?WUF3emVhLzFhU1BKRHE4UjgzZmptdnpBbUJwSTNKelhoMjMwa3lBQmZsb1dB?=
 =?utf-8?B?Q2pYd3BxaVNXZHlSTUVCY2V1Y1FCZGxqcGpGK0RrejVRaXdKRUZtcnd6clpQ?=
 =?utf-8?B?aEJPdExHaGdSZ3V0aDNkUHFIYlF5NCswTHpVc0J0amxCL2o4U0pMSXFyblc2?=
 =?utf-8?B?YVJDc1hjdWtqWHpPQWNLajBDU3U1eE5MKzlSQlFvVHdVYXpEeWoyM2JUdmNR?=
 =?utf-8?B?ZkxqYituQkx5ZjBudllkSDhkb1JDb2tNa09kalNlbElWMW9sNGpQWnRCcDU4?=
 =?utf-8?B?V240bjBDOGVDQjA3TXIwNzVReE9JbEJKZkNMbmRaOG0rczByM0RTb3RVbnJ5?=
 =?utf-8?B?bG81VDRmR2hQemExLzFoT2w1dW5odXhxREtVblJuN2JYSTJEOEE0QVJNaUhP?=
 =?utf-8?B?cWF6ckIzdE1leUFtVHJsNGZtKzd5TFNEK2YyL051a0FRdzRwZ2JwNHFlVUtU?=
 =?utf-8?B?dWVTVElQcDFJbnVhbWp2TFo2S3YwMmcxMUVtRWdjM1M4SjdwcUdrUHlZeDlj?=
 =?utf-8?B?eUZDc3VtWko1Z3BwZ1I3ZEZJN2U2Q1I5MCs0QkIzOFRBQU0wcUZhU21rMzN4?=
 =?utf-8?B?YnErRmZORU1GTEpiaFkyeGo2blNvdHBWeE9OU2lDV3ZsbFFkaXN6QTE0ZEgz?=
 =?utf-8?B?TlY3Mk9TZ01oMTBHam9vWDdJRGZmQnowenpNeWV3VzNNTzZkL1dkR0hOMk9Y?=
 =?utf-8?B?U0oxcFlWNG54MXJreTF6Ym1HUXdYZC95ZUwvS3huMlhidVVDR2xsbnpxTFp6?=
 =?utf-8?B?bCsvVjhBc0M5RzN2UjdKTEdkeko5bkNPU2hraEFucjBqenNEYlVOb1lWSFkw?=
 =?utf-8?B?YUVvaURwaEN3OGpQSVdFTnNBcWdkZWxjcHRscXVDaTFUaktjUy92QWZJUTZh?=
 =?utf-8?B?aGRpTC9XL2hNNllvdldyR3dCVm9CSXk1UkxScnJndU84MVRoU0wybEpyZDMz?=
 =?utf-8?B?UWtYbkZhM2g2NGxUQ2RRS1FiZDJlZldqTlVmdUREWWs4aVR0a0Y3cGIzQzJD?=
 =?utf-8?B?NTVONFV0VlcwWG1QNFBKdURZZGZReEtncVNWdGFnYlFCVHd2VTVFV21jOVJi?=
 =?utf-8?B?eDhuZ0owYlpQNTRGSUFtOHAvTVY0NjlxUFVrOENTSDkxWUhkVTA4ZkxjZ2Qw?=
 =?utf-8?B?NXR0VElKRzd4VVJHRGVVdGZUcVpwNTdXQWVDRDRySUMyVytnMVZVQ2ljaSsr?=
 =?utf-8?B?WkhuWVVUVzE2Sk1IdHh6OFQvNzhxSkErY3E0TERQUEFnVjRab1p5a21MY2I4?=
 =?utf-8?B?RE1kLzVHSzBSVld1MVhINi9qeTFPMFVSc2ZNdDQ5ZlZrOU9UZ29hdWlBaG1o?=
 =?utf-8?B?YnBYRU52UUdtOWk0UDlFWDU5TEI2UzJyUEROWkszMmlPWkg5ODl4U3drYlhB?=
 =?utf-8?B?WVhZbGZwanluYlVVb1g5eXdoSzNKYzRpS3hZRVp0ZWRBMWhjeGFSV05rdWV2?=
 =?utf-8?B?ZjVKVkduQUpNZWlhbFRRQUlxeGdacjNxWnhJL2RvWUJxZlB3TDJQNlE2REVq?=
 =?utf-8?B?ZDNSV2tTTnRYOHBrRU9zU2ZoNE8wMXJCb1BpUUprQWFGNlo4ZmJ2K0p2SWZJ?=
 =?utf-8?B?N0xtRUQ5T3pCM002VncxVWVWaGJQcFcrMFVoYzNuSHErRnlDaEkrVDQ1ZFJB?=
 =?utf-8?B?Uy9tdyt1OFQ4M0EwNDl4Z1pUOVIxUEJWeCtjdHpVeFdLSGRZNklwbkhuQ2VZ?=
 =?utf-8?B?Wk5WWUNNanFsM21hdWNHVDgxcVc2dHVOLzBBTkhSRlBoaUJVYUlEcGJIa3lU?=
 =?utf-8?B?YXNsbGlzSHRtS3NjV2hRU2xZaFNJU0pQbTd2c0xIck51dXZFZmRPakFaNWpM?=
 =?utf-8?B?czhFUEhZUGIydkhyOWtPNWNXL0R0SHNsdDN4cXZ0T2I2ZSsyRmFNbFBBMUFR?=
 =?utf-8?B?Qkg0eHRQTC8wdGFsYnpZc3NzZzh3VWx4V3N3RGIyZHR4V2ZvaEN5Y05jcHdZ?=
 =?utf-8?B?UUJGRWlMNTJIYVBYb3dad1ViSFpsOWphdHlXZGQxMTROMUVxdGFHaGx4WFRM?=
 =?utf-8?B?Tlk5eXRhU0JEdjQvWkVJVEtSVTlvSDFvaVVrTnBpYVRqdWZkazRxMlQ0SkZv?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0727f09e-7fcf-4460-9877-08dc15c8b33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 12:51:32.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+2hh/gu1FyVJJhuYxuctVsPFbhvl2m58jvuIO5V8M3ufIsdyJ7pmn21CTdE253G5vWOOV9HG5h7WDfMY7NCxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5764
X-Proofpoint-ORIG-GUID: UqX2RElaSBxfZUj67ajve9oetB7u5uFd
X-Proofpoint-GUID: UqX2RElaSBxfZUj67ajve9oetB7u5uFd
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [Bug 218375] New: warning compiling siw_tx_hdt:  the frame size of 1040
 bytes is larger than 1024 bytes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_07,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=928 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150093

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCA5OjM3
IEFNDQo+IFRvOiBidWd6aWxsYS1kYWVtb25Aa2VybmVsLm9yZzsgQmVybmFyZCBNZXR6bGVyIDxC
TVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbQnVnIDIxODM3NV0gTmV3OiB3YXJuaW5nIGNvbXBpbGlu
ZyBzaXdfdHhfaGR0OiB0aGUNCj4gZnJhbWUgc2l6ZSBvZiAxMDQwIGJ5dGVzIGlzIGxhcmdlciB0
aGFuIDEwMjQgYnl0ZXMNCj4gDQo+ICsgQmVybmFyZA0KPiANCj4gT24gU3VuLCBKYW4gMTQsIDIw
MjQgYXQgMDQ6MTA6MjNQTSArMDAwMCwgYnVnemlsbGEtZGFlbW9uQGtlcm5lbC5vcmcgd3JvdGU6
DQo+ID4gSU5WQUxJRCBVUkkgUkVNT1ZFRA0KPiAzQV9fYnVnemlsbGEua2VybmVsLm9yZ19zaG93
LTVGYnVnLmNnaS0zRmlkLQ0KPiAzRDIxODM3NSZkPUR3SUJBZyZjPWpmX2lhU0h2Sk9iVGJ4LXNp
QTFaT2cmcj0yVGFZWFEwVC0NCj4gcjhaTzFQUDFhbE53VV9RSmNSUkxmbVlUQWdkM1FDdnFTYyZt
PThyVTZNeEFzZ0g2NFNJTVE5cnRiVEtUclQ5NHF6QjR3cU9UYldYDQo+IHIwQkdVN2VvZVRqUDMw
ZVR3N3VtYUJTTjJSJnM9R3hMOHNWVkpkVW0tbEVSbHR1REFrOTRYaTNYVHZMdHZqZ2NwdU9SQ2Fq
ZyZlPQ0KPiA+DQo+ID4gICAgICAgICAgICAgQnVnIElEOiAyMTgzNzUNCj4gPiAgICAgICAgICAg
IFN1bW1hcnk6IHdhcm5pbmcgY29tcGlsaW5nIHNpd190eF9oZHQ6ICB0aGUgZnJhbWUgc2l6ZSBv
ZiAxMDQwDQo+ID4gICAgICAgICAgICAgICAgICAgICBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0
IGJ5dGVzDQo+ID4gICAgICAgICAgICBQcm9kdWN0OiBEcml2ZXJzDQo+ID4gICAgICAgICAgICBW
ZXJzaW9uOiAyLjUNCj4gPiAgICAgICAgICAgSGFyZHdhcmU6IEFsbA0KPiA+ICAgICAgICAgICAg
ICAgICBPUzogTGludXgNCj4gPiAgICAgICAgICAgICBTdGF0dXM6IE5FVw0KPiA+ICAgICAgICAg
ICBTZXZlcml0eTogbm9ybWFsDQo+ID4gICAgICAgICAgIFByaW9yaXR5OiBQMw0KPiA+ICAgICAg
ICAgIENvbXBvbmVudDogSW5maW5pYmFuZC9SRE1BDQo+ID4gICAgICAgICAgIEFzc2lnbmVlOiBk
cml2ZXJzX2luZmluaWJhbmQtcmRtYUBrZXJuZWwtYnVncy5vc2RsLm9yZw0KPiA+ICAgICAgICAg
ICBSZXBvcnRlcjogaW9udXRfbjIwMDFAeWFob28uY29tDQo+ID4gICAgICAgICBSZWdyZXNzaW9u
OiBObw0KPiA+DQo+ID4gSGkgS2VybmVsIFRlYW0sDQo+ID4NCj4gPiBJIG5vdGljZSB0b2RheSB0
aGlzOg0KPiA+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6IEluIGZ1bmN0
aW9uICdzaXdfdHhfaGR0JzoNCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90
eC5jOjY3NzoxOiB3YXJuaW5nOiB0aGUgZnJhbWUgc2l6ZSBvZg0KPiAxMDQwDQo+ID4gYnl0ZXMg
aXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhhbj1dDQo+ID4gIDY3
NyB8IH0NCj4gPiAgICAgIHwNCj4gPg0KPiA+IEkgdXNlIGxhdGVzdCBrZXJuZWwgNi43IGFuZCB0
aGlzIGlzIGhhcHBlbmVkIHdoZW4gY29tcGlsaW5nIGtlcm5lbCB3aXRoDQo+IEdDQyAtDQo+ID4g
Z2NjIChEZWJpYW4gMTMuMi4wLTkpIDEzLjIuMC4NCj4gPg0KPiA+IC0tDQo+ID4gWW91IG1heSBy
ZXBseSB0byB0aGlzIGVtYWlsIHRvIGFkZCBhIGNvbW1lbnQuDQo+ID4NCj4gPiBZb3UgYXJlIHJl
Y2VpdmluZyB0aGlzIG1haWwgYmVjYXVzZToNCj4gPiBZb3UgYXJlIHdhdGNoaW5nIHRoZSBhc3Np
Z25lZSBvZiB0aGUgYnVnLg0KDQpUaGFua3MgTGVvbiwgT0sgSSdsbCBmaXggdGhhdC4NCg0KQmVy
bmFyZA0K


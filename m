Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7D72107E
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFCOjT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Jun 2023 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjFCOjS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Jun 2023 10:39:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097A18C
        for <linux-rdma@vger.kernel.org>; Sat,  3 Jun 2023 07:39:17 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 353EMkQI001475;
        Sat, 3 Jun 2023 14:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CfZyTQd10PNoHknrkAksBnfF9HYBgDQtGCv8KloEGm0=;
 b=J5r4rNc/4f7r22VVACIVp1+x+fkexpzhy4gmV8MWwnm7BmSogEdzD1qd27rKpyvFGyP0
 lnahAncYj+7Jf6dhDXL7A9aeXVz3S6HsulbkZII3JRZeA+DTukWjHPzjKRPDJsE0DL5z
 LJD2ibZ4rO9JM3pBM9fAcRwrGz4L/Y7qv4AVUJ+dBUGR+kv8BDJKAWKsp+cYiRLPNKw3
 2avBh9WWOD5rBHlHFfCtRYvOsGx8DzLDA8wizUxkZaPYQ14sfBsFzZHulk0Tds9bGysH
 fDOQDcudmlsOjJfnoWTjK2xa7fZGy+46tD0u9NBwDJcFXuXlC2KoEYAZ4I2bda6ZiZz4 HA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r077j06vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Jun 2023 14:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSd3vG6xHcsFLb/0AADJqVN79IdFExUSLRD2UCLFyoiqsBOyuuvhnO2ONWoWBa8nxzxHtmZrHF1iLw4kwHF7lO3ZoQfCpL88ZlgaVrbirdFLo9fSOShn6grxsS6RjPVeXKDzWXVgdj+yYpAl6kqzPnzk85tCgMRD0r+ixD3bLf+q/iT/Lpg2+vNFb3GB1m8tTFcZNk5QfRGJf7V92WDhvq9mNsO5cgckELGboRiff6YfYPaiMYISOGoACtctcxARfOwclIyYdHcXm0B+KSNnWnzNmlzkuf8Pb08rgVN3uWuz4MPLJhD5EwpLwYOiTtAe7Q6LQjJoZPUOSFNEZEANWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfZyTQd10PNoHknrkAksBnfF9HYBgDQtGCv8KloEGm0=;
 b=nFfPkz+2HA/u8FQtNLmq8kY3mXUMkl7F/Ezp6bqqucJSIrSqL1fMnB7rHJL+hpWL0I1TWsxs5/RHzUdAbRg+pp0IWLx8hBqmFcLdZBGsAQVmoBk/KRtHVGZoZQviFkfGR+QHIFVkzjDGKpiItgvern5g0sW/msWzJA/S3lk65/9922yYmXvSSEIM63mXuviiRj1WBjBt29wLdfM/+8sjlIKWjBTnQWsGXb6yajaFkTLJoOCfn3MqzxWe0533Vd9SCuxUkQCdoGt9Ma+asK4d906DPYaY9rutOh4mK++/GtfL17cj113rbEa23UklQTgaSHduUJVmwrY0ZMTK3t8/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CO6PR15MB4147.namprd15.prod.outlook.com (2603:10b6:5:353::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Sat, 3 Jun
 2023 14:39:05 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::9643:3b56:2d46:eb26]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::9643:3b56:2d46:eb26%2]) with mapi id 15.20.6455.028; Sat, 3 Jun 2023
 14:39:05 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Chuck Lever <cel@kernel.org>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback devices
Thread-Topic: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback
 devices
Thread-Index: AQHZliRQUJ9AlHUkpU6AaG2xD567ha95JY9w
Date:   Sat, 3 Jun 2023 14:39:04 +0000
Message-ID: <SA0PR15MB391953A7D6B68E48F92C2DBB994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
 <D9A02961-BE4A-4B71-8FB5-6A0662853BBB@oracle.com>
In-Reply-To: <D9A02961-BE4A-4B71-8FB5-6A0662853BBB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|CO6PR15MB4147:EE_
x-ms-office365-filtering-correlation-id: 6b8fbec5-94b7-4af9-e01b-08db644047d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoARsMr6K9tl/rocJERbWOi4Xi0+xKSjqhycA5KOtNc6IXj1YIWQV9YV10+o96cLWyRjcR+U+DB5kwsVmrUx/RB2jwlVH80z/SVP3PoX8oyrITURZWEcFOgk0eo1kOnW/pPyic8l5E3bel+BPX4oVDyNbLjhOQu/iw1N9ylBuN8BxXelS63+jNCeZwDyRn7DJKjly0vHxxGgXDp9Qka6TWKI1LO8gcFsrTYxVFJ6bGyk3JfgZgdP2oC8nsvcv0fCuzKdH2O97b2py9/b9WWlgtAQwFN7L8/IDNjJPm9CPVTykpZ7Vbm4tlepQQZuUqDUpJjO5fXUJ0palUpmlz77VFhmkebFQrf21atGYlqKWhtuZihTyWxHhi4SvLI6mTEee/L0U1rSRGO7c1PTvn63nzRMyGeDtekGGKbq0DnhpeY5bFwjGiI/kwjKj0NdrzsNvbMQ4/XmLe6EFas8ZjbkN/J4xUa/Ty80khGU2gOFhV40a4f7aovxLuS7kn0MkNVIziw7YCUXqTnV0g5ZUTRmFTmfYoNdmkFTLLNnn+5jhwYp9pZdWMTSbHuSCxB5R+7WURphp6omK8GM0j0ftoOPUDJ+g2TolPW4tNOPA+crBJ+1o/guFpkjuwlqOY6wOVQ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(186003)(6506007)(9686003)(53546011)(2906002)(55016003)(38070700005)(83380400001)(4326008)(316002)(6916009)(7696005)(71200400001)(76116006)(66946007)(64756008)(38100700002)(66476007)(66446008)(66556008)(41300700001)(33656002)(122000001)(478600001)(54906003)(86362001)(8676002)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWNpSHpTbklzblVWWktUUDMyWmtsbHRFMVVjbjdLdm1POWhVUGEyRzZSc3hO?=
 =?utf-8?B?bjBJU1VGL2hjdkZGek5MQUtmeVRlK3huWG1rMHVlRzJJWVdSZGlVbnZEbzZp?=
 =?utf-8?B?UWVrbytNRXRQWkFmS0s0aWlJUGErVjNCbEZzUXdCOWp3aHJVWThGV0hENGNn?=
 =?utf-8?B?TGE3R0xMQnA5WVpockRLWDZxeVp4V3FKTTNLT0Urd0xFVkcwQWxYSnFEakps?=
 =?utf-8?B?MjZob1FSQThaQUlwbUhWcnRYR0hZMUNoMmhFem1NVk9WM3NncFU0UDhUR1RQ?=
 =?utf-8?B?SmZUVndSczA3YkNHclZMQ1pKM3BYbU5DU0szemdaWEYvSjhDTzRraWhrdGEw?=
 =?utf-8?B?eElDb0tmeDFBMEJqSXluam80NklzUjkxUmFtNDBqQW5TelI2SnU5NFM5QjhZ?=
 =?utf-8?B?UGRJSWtHQVJtUzY0ZThMSFVJRnpZNlJpQTBwdXU3bEszM0paSTV6eE0zaDh2?=
 =?utf-8?B?Z3R4VHc0S1JENW5Da2I1dXVSMDZWK01RcWxEbjRocElVYmNWdCtnYitWRTIr?=
 =?utf-8?B?YUZOVDkvRGxJT2NkU3RhR0N1UmJsYXZ0UStvNmxrWC9QLy9yWUJVcStGdkk0?=
 =?utf-8?B?OVhYMXZaVWI4S1M3eC8zQkVtcXpRVVh3Nyt3UmxxYzY0VDR4RjRJTlFmNEVK?=
 =?utf-8?B?eGxrRjhCRlZnRVh1MUpVSXo2bU9DakVxY3FVUzZnR0R4cTFVTjdyREMxZzVm?=
 =?utf-8?B?eDk1YkE3WHFCUEY2WGdtS3krUkVhUkRJQ3pGNWkvRFM4Ty96cmUvSiszUUgw?=
 =?utf-8?B?RTlCeVQxYk15a3NmVUo2ZHNpVEZ5WGhlZ3VIa2RLOUNCY1JWbThaQnBTQ2R3?=
 =?utf-8?B?ak9vbWJaQjVmajJ0OFhXY0JlNnVvc0tLaDdjTmUzRmw1S3pBWCtvcVhSRWwx?=
 =?utf-8?B?VDlXZE4yQmZHMTY1bmRuc2YzWUNHbnRwbmJ0eXV0czJNR1ltTkwxNjVrNjNH?=
 =?utf-8?B?ZjdtMldITDY2NURFQXBtMFQwNkVEZStRUUcyUXBSSzM1N1Q1TFVkTUZrOG9o?=
 =?utf-8?B?VDdXNVhJV0VpR1B2dVdzeHVCd0tBQi9NZFZtaXlDdjdpbmdLSEx3aUl5ZU1l?=
 =?utf-8?B?UE9FMEFyckx5LzBHWlZKYlFRb1UxWUVGTllvbTI1cGI5RVI0amVzNERqUUpU?=
 =?utf-8?B?VnZMNlZnQTI2ZXBjRzk2R05YYzd4OWVtZTFMRDRLYmFpcGduc2ZodmJNMWdo?=
 =?utf-8?B?YTFTV1RpdWZLRzlXVHNmdUh5VXN4eW03SHJ0TC9tbEJvaGt1QkdYWDE3WG1W?=
 =?utf-8?B?MjVYdFRGSGdkVFVOUk9kV0wrRXE4Q21GZWtpN0o2T3AybVc4blM4dXpsRE0z?=
 =?utf-8?B?eE5IK00wdmIrd3Fyc0tkZ1lHZVNtQVZtV2FVbDFCYmxxL3BDeWlYWGNxbXc0?=
 =?utf-8?B?YVBVekN0cnkzS3ZzQnQ0djVlNTVILzFJb1EybFc1dytvQWNPRitRV21JOXk1?=
 =?utf-8?B?c3pyNzZhSk5qekloTUt6RWdNMGRsbmcrdXFzSlRRU1lWY2JxQnk3SzJ6SDY2?=
 =?utf-8?B?Z2lTajJrYXA5eXMrVVF2b21FMVcwMC96MGRGbjBGNFRvNkI0VjduVmNUSEFB?=
 =?utf-8?B?WkdhMWE4WmkyYS84YzhlcVVFM3NnVEdiKzNuMFYyaDlIdVlsQnN1K0RrSGZR?=
 =?utf-8?B?RUN1N1BCK3kyblBxWEpkaGJhbVBSaWliallLT1Qwb05IOWlhc1VnLzBNRGtn?=
 =?utf-8?B?ODdtZllsVDh3L2NvRk8rUThnQjVseFh2T3BPc1BXR3JlbVBtK3d4bEhFYXho?=
 =?utf-8?B?Uy83NnZscjh0cDVFalNuaytWVkpySXZJWlhWSjVaeHZlLzNhNlN5ZmNONWdr?=
 =?utf-8?B?VWREbis1cVNBY1hJRUlNcVlFWHdRWFBsYVZ0YW4rT2tSN2Q0UmxOR1NtVkQ3?=
 =?utf-8?B?TXpaaEEwRjUrcVd4WUxldVlDR0wyblZDWjN1OTdVVmQ3akszZDVyK2FUblpH?=
 =?utf-8?B?MzY3d3hmWndQT1VDWjcrc1pPSDdLbFk4a1pieERYVzZPNjErUzRUVFRab043?=
 =?utf-8?B?L2xDbnQ2eHZqd3JRMDVPQWx6V2ZVNGdjelZiM1hVSTQ2V1lyZ3kzemplYjhS?=
 =?utf-8?B?NXhKSzNQZFNvdXlsOFNKeThoandIbm52alFkZTRQUW9CUW9Ya1NPajFSZUh1?=
 =?utf-8?B?V2UweCtoSzhmN2J3cWZBRVNiUHl0YnlHSmVqWllSNUlEQXVHUlgxU0FWUWhX?=
 =?utf-8?Q?WVX/UFxejlQXcAI8Bd0Qt4sR9TS/wIplJBQaFOT+av7U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8fbec5-94b7-4af9-e01b-08db644047d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2023 14:39:04.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9ej+R1KUVAjTy2ieRj/hXFvvie6kFgP34guzjFgzIbtq9GTey9mwpnzg64VD1iDuaCn/QFgVXIpouyLTNOd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4147
X-Proofpoint-GUID: Ve1jLvcPT-DbuJSOUTcrjY3cy9c0UlNZ
X-Proofpoint-ORIG-GUID: Ve1jLvcPT-DbuJSOUTcrjY3cy9c0UlNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306030133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgSUlJ
IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgMyBKdW5lIDIwMjMg
MTY6MDQNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzog
Q2h1Y2sgTGV2ZXIgPGNlbEBrZXJuZWwub3JnPjsgVG9tIFRhbHBleSA8dG9tQHRhbHBleS5jb20+
OyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIFJGQ10gUkRNQS9zaXc6IEZhYnJpY2F0ZSBhIEdJRCBvbiB0dW4gYW5kDQo+IGxv
b3BiYWNrIGRldmljZXMNCj4gDQo+IA0KPiANCj4gPiBPbiBKdW4gMywgMjAyMywgYXQgMTA6MDEg
QU0sIEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPiB3cm90ZToNCj4gPg0KPiA+
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2h1Y2sg
TGV2ZXIgPGNlbEBrZXJuZWwub3JnPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgMyBKdW5lIDIwMjMg
MTU6NTYNCj4gPj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+
PiBDYzogVG9tIFRhbHBleSA8dG9tQHRhbHBleS5jb20+OyBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT47DQo+ID4+IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyB0b21AdGFs
cGV5LmNvbQ0KPiA+PiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBSRkNdIFJETUEvc2l3OiBG
YWJyaWNhdGUgYSBHSUQgb24gdHVuIGFuZA0KPiA+PiBsb29wYmFjayBkZXZpY2VzDQo+ID4+DQo+
ID4+IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+Pg0KPiA+
PiBMT09QQkFDSyBhbmQgTk9ORSAodHVubmVsKSBkZXZpY2VzIGhhdmUgYWxsLXplcm8gTUFDIGFk
ZHJlc3Nlcy4NCj4gPj4gQ3VycmVudGx5LCBzaXdfZGV2aWNlX2NyZWF0ZSgpIGZhbGxzIGJhY2sg
dG8gY29weWluZyB0aGUgSUIgZGV2aWNlJ3MNCj4gPj4gbmFtZSBpbiB0aG9zZSBjYXNlcywgYmVj
YXVzZSBhbiBhbGwtemVybyBNQUMgYWRkcmVzcyBicmVha3MgdGhlIFJETUENCj4gPj4gY29yZSBh
ZGRyZXNzIHJlc29sdXRpb24gbWVjaGFuaXNtLg0KPiA+Pg0KPiA+PiBIb3dldmVyLCBhdCB0aGUg
cG9pbnQgd2hlbiBzaXdfZGV2aWNlX2NyZWF0ZSgpIGNvbnN0cnVjdHMgYSBHSUQsIHRoZQ0KPiA+
PiBpYl9kZXZpY2U6Om5hbWUgZmllbGQgaXMgdW5pbml0aWFsaXplZCwgbGVhdmluZyB0aGUgTUFD
IGFkZHJlc3MgdG8NCj4gPj4gcmVtYWluIGluIGFuIGFsbC16ZXJvIHN0YXRlLg0KPiA+Pg0KPiA+
PiBGYWJyaWNhdGUgYSByYW5kb20gYXJ0aWZpY2lhbCBHSUQgZm9yIHN1Y2ggZGV2aWNlcywgYW5k
IGVuc3VyZSB0aGF0DQo+ID4+IGFydGlmaWNpYWwgR0lEIGlzIHJldHVybmVkIGZvciBhbGwgZGV2
aWNlIHF1ZXJ5IG9wZXJhdGlvbnMuDQo+ID4+DQo+ID4+IFJlcG9ydGVkLWJ5OiBUb20gVGFscGV5
IDx0b21AdGFscGV5LmNvbT4NCj4gPj4gRml4ZXM6IGEyZDM2YjAyYzE1ZCAoIlJETUEvc2l3OiBF
bmFibGUgc2l3IG9uIHR1bm5lbCBkZXZpY2VzIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sg
TGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4+IC0tLQ0KPiA+PiBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npdy5oICAgICAgIHwgICAgMSArDQo+ID4+IGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X21haW4uYyAgfCAgIDI2ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
DQo+ID4+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAgICA0ICsrLS0N
Cj4gPj4gMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgN
Cj4gPj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ID4+IGluZGV4IGQ3ZjVi
MmE4NjY5ZC4uNDFmYjg5NzZhYmM2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npdy5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
LmgNCj4gPj4gQEAgLTc0LDYgKzc0LDcgQEAgc3RydWN0IHNpd19kZXZpY2Ugew0KPiA+Pg0KPiA+
PiB1MzIgdmVuZG9yX3BhcnRfaWQ7DQo+ID4+IGludCBudW1hX25vZGU7DQo+ID4+ICsgY2hhciBy
YXdfZ2lkW0VUSF9BTEVOXTsNCj4gPj4NCj4gPj4gLyogcGh5c2ljYWwgcG9ydCBzdGF0ZSAob25s
eSBvbmUgcG9ydCBwZXIgZGV2aWNlKSAqLw0KPiA+PiBlbnVtIGliX3BvcnRfc3RhdGUgc3RhdGU7
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMN
Cj4gPj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gPj4gaW5kZXgg
MTIyNWNhNjEzZjUwLi5lZmM4NjU2NWFjNWQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiA+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19tYWluLmMNCj4gPj4gQEAgLTc1LDggKzc1LDcgQEAgc3RhdGljIGludCBzaXdf
ZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBzaXdfZGV2aWNlDQo+ICpzZGV2LA0KPiA+PiBjb25zdCBj
aGFyICpuYW1lKQ0KPiA+PiByZXR1cm4gcnY7DQo+ID4+IH0NCj4gPj4NCj4gPj4gLSBzaXdfZGJn
KGJhc2VfZGV2LCAiSFdhZGRyPSVwTVxuIiwgc2Rldi0+bmV0ZGV2LT5kZXZfYWRkcik7DQo+ID4+
IC0NCj4gPj4gKyBzaXdfZGJnKGJhc2VfZGV2LCAiSFdhZGRyPSVwTVxuIiwgc2Rldi0+cmF3X2dp
ZCk7DQo+ID4+IHJldHVybiAwOw0KPiA+PiB9DQo+ID4+DQo+ID4+IEBAIC0zMTQsMjQgKzMxMywy
MSBAQCBzdGF0aWMgc3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3JlYXRlKHN0cnVjdA0K
PiA+PiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ID4+IHJldHVybiBOVUxMOw0KPiA+Pg0KPiA+PiBi
YXNlX2RldiA9ICZzZGV2LT5iYXNlX2RldjsNCj4gPj4gLQ0KPiA+PiBzZGV2LT5uZXRkZXYgPSBu
ZXRkZXY7DQo+ID4+DQo+ID4+IC0gaWYgKG5ldGRldi0+dHlwZSAhPSBBUlBIUkRfTE9PUEJBQ0sg
JiYgbmV0ZGV2LT50eXBlICE9IEFSUEhSRF9OT05FKSB7DQo+ID4+IC0gYWRkcmNvbmZfYWRkcl9l
dWk0OCgodW5zaWduZWQgY2hhciAqKSZiYXNlX2Rldi0+bm9kZV9ndWlkLA0KPiA+PiAtICAgIG5l
dGRldi0+ZGV2X2FkZHIpOw0KPiA+PiAtIH0gZWxzZSB7DQo+ID4+ICsgc3dpdGNoIChuZXRkZXYt
PnR5cGUpIHsNCj4gPj4gKyBjYXNlIEFSUEhSRF9MT09QQkFDSzoNCj4gPj4gKyBjYXNlIEFSUEhS
RF9OT05FOg0KPiANCj4gT25lIHRoaW5nIEknbSB3b25kZXJpbmcgaXMgaWYgdGhlcmUgYXJlIG90
aGVyIGNhc2VzIHdoZXJlDQo+IHRoZXJlIGlzIG5vIEwyIGFkZHJlc3MgYmVzaWRlcyBBUlBIUkRf
Tk9ORSBhbmQgTE9PUEJBQ0suDQo+IFNob3VsZCB3ZSBpbnN0ZWFkIGNoZWNrIG5ldGRldidzIGFk
ZHJsZW4gaW5zdGVhZCBvZiBjaGVja2luZw0KPiB0aGUgQVJQIHR5cGU/DQo+IA0KSSB0aGluayBz
by4gSW4gZmFjdCBpdCBpcyBhIHBvdGVudGlhbCBpbmNvbXBsZXRlDQpjb2xsZWN0aW9uIG9mIGNh
c2VzIHdoZXJlIG5vIEwyIGFkZHJlc3MgaXMgYXZhaWxhYmxlLg0KTGV0J3MgbWFrZSBpdCBleHBs
aWNpdC4NCg0KPiANCj4gPj4gLyoNCj4gPj4gLSAqIFRoaXMgZGV2aWNlIGRvZXMgbm90IGhhdmUg
YSBIVyBhZGRyZXNzLA0KPiA+PiAtICogYnV0IGNvbm5lY3Rpb24gbWFuZ2FnZW1lbnQgbGliIGV4
cGVjdHMgZ2lkICE9IDANCj4gPj4gKyAqIFRoaXMgZGV2aWNlIGRvZXMgbm90IGhhdmUgYSBIVyBh
ZGRyZXNzLCBidXQNCj4gPj4gKyAqIGNvbm5lY3Rpb24gbWFuZ2FnZW1lbnQgcmVxdWlyZXMgYSB1
bmlxdWUgZ2lkLg0KPiA+PiAqLw0KPiA+PiAtIHNpemVfdCBsZW4gPSBtaW5fdChzaXplX3QsIHN0
cmxlbihiYXNlX2Rldi0+bmFtZSksIDYpOw0KPiA+PiAtIGNoYXIgYWRkcls2XSA9IHsgfTsNCj4g
Pj4gLQ0KPiA+PiAtIG1lbWNweShhZGRyLCBiYXNlX2Rldi0+bmFtZSwgbGVuKTsNCj4gPj4gLSBh
ZGRyY29uZl9hZGRyX2V1aTQ4KCh1bnNpZ25lZCBjaGFyICopJmJhc2VfZGV2LT5ub2RlX2d1aWQs
DQo+ID4+IC0gICAgYWRkcik7DQo+ID4+ICsgZXRoX3JhbmRvbV9hZGRyKHNkZXYtPnJhd19naWQp
Ow0KPiA+PiArIGJyZWFrOw0KPiA+PiArIGRlZmF1bHQ6DQo+ID4+ICsgbWVtY3B5KHNkZXYtPnJh
d19naWQsIG5ldGRldi0+ZGV2X2FkZHIsIEVUSF9BTEVOKTsNCj4gPj4gfQ0KPiA+PiArIGFkZHJj
b25mX2FkZHJfZXVpNDgoKHU4ICopJmJhc2VfZGV2LT5ub2RlX2d1aWQsIHNkZXYtPnJhd19naWQp
Ow0KPiA+Pg0KPiA+PiBiYXNlX2Rldi0+dXZlcmJzX2NtZF9tYXNrIHw9IEJJVF9VTEwoSUJfVVNF
Ul9WRVJCU19DTURfUE9TVF9TRU5EKTsNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gPj4gYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd192ZXJicy5jDQo+ID4+IGluZGV4IDM5OGVjMTNkYjYyNC4uMzJiMGJlZmQyNWUy
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gPj4g
QEAgLTE1Nyw3ICsxNTcsNyBAQCBpbnQgc2l3X3F1ZXJ5X2RldmljZShzdHJ1Y3QgaWJfZGV2aWNl
ICpiYXNlX2RldiwNCj4gc3RydWN0DQo+ID4+IGliX2RldmljZV9hdHRyICphdHRyLA0KPiA+PiBh
dHRyLT52ZW5kb3JfcGFydF9pZCA9IHNkZXYtPnZlbmRvcl9wYXJ0X2lkOw0KPiA+Pg0KPiA+PiBh
ZGRyY29uZl9hZGRyX2V1aTQ4KCh1OCAqKSZhdHRyLT5zeXNfaW1hZ2VfZ3VpZCwNCj4gPj4gLSAg
ICBzZGV2LT5uZXRkZXYtPmRldl9hZGRyKTsNCj4gPj4gKyAgICBzZGV2LT5yYXdfZ2lkKTsNCj4g
Pj4NCj4gPj4gcmV0dXJuIDA7DQo+ID4+IH0NCj4gPj4gQEAgLTIxOCw3ICsyMTgsNyBAQCBpbnQg
c2l3X3F1ZXJ5X2dpZChzdHJ1Y3QgaWJfZGV2aWNlICpiYXNlX2RldiwgdTMyDQo+IHBvcnQsDQo+
ID4+IGludCBpZHgsDQo+ID4+DQo+ID4+IC8qIHN1Ym5ldF9wcmVmaXggPT0gaW50ZXJmYWNlX2lk
ID09IDA7ICovDQo+ID4+IG1lbXNldChnaWQsIDAsIHNpemVvZigqZ2lkKSk7DQo+ID4+IC0gbWVt
Y3B5KCZnaWQtPnJhd1swXSwgc2Rldi0+bmV0ZGV2LT5kZXZfYWRkciwgNik7DQo+ID4+ICsgbWVt
Y3B5KGdpZC0+cmF3LCBzZGV2LT5yYXdfZ2lkLCBFVEhfQUxFTik7DQo+ID4+DQo+ID4+IHJldHVy
biAwOw0KPiA+PiB9DQo+ID4+DQo+ID4gVGhhdCBsb29rcyBnb29kIHRvIG1lLCB0aGFua3MhDQo+
IA0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQoNCg==

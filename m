Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B8721050
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFCOCD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Jun 2023 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFCOCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Jun 2023 10:02:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF073197
        for <linux-rdma@vger.kernel.org>; Sat,  3 Jun 2023 07:02:01 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 353Cqh2U028288;
        Sat, 3 Jun 2023 14:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=s1EOPd8xg45DyuEzQSx/jHIJVvBEfra5ExT98OOySj4=;
 b=VvcTgVK8tCJFxxiyyO33jJ2zhvoZqNfRrqTSdQZ2iA55+2NaDiu/fro0vsE0YvGrdgVL
 Lp5abCB3YpneN+Cc9sug+J1u2BQZPxunSgYAHl0koH9BkOZIY76wZQtCK7rcbYWb+EyC
 e0u8A8hewTmXhkccByBZlNXkou5XHmk2nRnMoxLu2OQ8ZtT1rR9TwO1Ly4ojopqxRGUJ
 4bCg2LQrtaixDk8ysO9u5bGT/eir+fOfC+8tEtOM44zC7zTk9S3mCo91YbUcFY81Sxdr
 VH01FmQrMO3wW6pi0jt/3iInh5plGZL+XaK91m33Hv9nE3M6bdadmEiClxzyLMSZokXe OA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r05we0xag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Jun 2023 14:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy61UmWqjXqcGiJYhfiGRibU3vEWOj0yxDKAeGv0xi7SNPwt+VHtAOA6UyGMwGAUdGR0w/8KXHd8XClQ6ytvrR0/UvyGXN5xTodjMahLmOKgH0O/I3/KcG1R6BttKROYxCOtYalUhn5427J2zwgusi6h7hMwlzDgasd071pstM6qUIaWoDgtiy/djAAzBY7OJf9gz7S/dBGIj8rZoPBg6MEDLzak7gBE2AdFstq8hIlnBhe1VvHpmElsJtcR95SfoCaiNyIrhoXGZZLrVYAoiiiYSg+073Z0lgos8U9ljHKmah7K2pb27vwwHgQ4ZFsJI8fNWSHq3z2x4jDRvJ0wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1EOPd8xg45DyuEzQSx/jHIJVvBEfra5ExT98OOySj4=;
 b=VvuKoXPnJpVfGwknxsXoAjbhvu5siW+W7eIrHVcaMbr5lR2/syRPmNvvcgqZwQoF/p0r6UMabJ6QDHPzAbwE/qtHGX71wPSHBRih0DeAYgwbRuSbUfWP0sAq/OmJ3yr8R9XEbIHNrxjDvBazntoU7wZZKZcEiIZQNTfhXkgplBYGZjG4Uiqz8rtVKg5gvSFR28LwSdZWJsFeI9YXiJjUdZB/dGvHhXAgBa2p8mP03E0ssBnwaOBUzbrueozkWAplOAYz9QTyzIuuvujmX9YTPkwzCEw6jK0ji+6KrCvcmOJm84VVyhZ+hrPCu64sPZSjlRHA12clgHKuqMZ7vHiV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH0PR15MB4384.namprd15.prod.outlook.com (2603:10b6:510:81::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 14:01:52 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::9643:3b56:2d46:eb26]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::9643:3b56:2d46:eb26%2]) with mapi id 15.20.6455.028; Sat, 3 Jun 2023
 14:01:52 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever <cel@kernel.org>
CC:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>
Thread-Topic: [EXTERNAL] [PATCH RFC] RDMA/siw: Fabricate a GID on tun and
 loopback devices
Thread-Index: AQHZliMY9RJh59tqOEm1/dy00W93FK95G4ig
Date:   Sat, 3 Jun 2023 14:01:52 +0000
Message-ID: <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|PH0PR15MB4384:EE_
x-ms-office365-filtering-correlation-id: 211c930f-82ef-4b6a-c335-08db643b1541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzOCYP3ZXHkqXS7D/DWN8z5RvoiRJI+mYOR0hXbaawVW/Xs/Vt5Nrq/LfBDpUaFENZIeeDx96qQxWZIwIwYSqWm5jArSjgQAveZe3OR7K5jxzpYIY1BFO/cvchMUhmUOikwxRgeITK6BrxpS/ZcMGeRWuc71CrMTjJq9+ozuKwZL00GIupAlIf8FGUTEc5+OU1cWW378cJbD9cTqnRhT4nXa+NuxCr6TJYXjTJ82nBMXEFNXnNWA8XZgE+ZY6Bcw8dHz+XmtRD5zcuMaZNx50fqz/vuyU7NxHF+g7HfvUTfZrwKplgnu4H3a2ADT39Rz1U/lLMJ8MKJtPqADPpF6OGUaxwwMv2ceTlYW9E26XGrN4m5YFEF5eKvmgHiITDYCiRpIuloB5XH1kTodBXOHYyLpPra6jCF+v77jvY45PDKoRAWE/3O4GRTVjyTcDvHxBvm+dek/DFroiooj5FaIgbW/h0wjmDDRAkoeN2lJlO4HGtW+0rwvp6XJyifexAiiro2uX7Yfbl24bKLRq2NrMk/mi3p0/a1qnZXHcTxYk5g0ZCKcgggvqjhXoYqK9H8IUjcLmuyUotmiR8T8izfYjbKDE5HY60EA05UyQVPZtxnd+IeyEEsNmaEBTDDW3clB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(7696005)(38070700005)(71200400001)(53546011)(9686003)(55016003)(6506007)(83380400001)(33656002)(186003)(86362001)(38100700002)(122000001)(54906003)(5660300002)(52536014)(316002)(41300700001)(8936002)(8676002)(66446008)(64756008)(76116006)(6916009)(66556008)(66946007)(4326008)(66476007)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFdjN01RVWIyNFo3L3ZBQnRDUldxMGdoalRabFQrY09tTExFOFBmYWJDN0RI?=
 =?utf-8?B?b01NNnNCRGJ6WEFlbHk1dnUvNWFhNHFRbEpBeERaZWRqZ3ZlSUgrUS84K1lH?=
 =?utf-8?B?Vy9MS1Nzb3Z0UzYwUkxDcjlVTTN3b0VKMkthS1FIMDN2dFI4VDJ5cVJvbzM0?=
 =?utf-8?B?RG5zdTJoeFRVUk50L0xhUmZhWGFiQzJCOW10VVdJQ0ZZWjBoRmFDNlRVcGZa?=
 =?utf-8?B?TjVHN1dxOXVHTS9pbWVQWDVoZXRBUkROV3h4cEpWb0VicncwckJPWFNzem1t?=
 =?utf-8?B?SmZyMW81cnQyaFFkMW4yRmxIUmtYTnU1V1FiQnFuWjQyYk9ONldxQTBjbDZE?=
 =?utf-8?B?elhETDgySDlzd25DbFBkQmpBeVl1bU9Ya0VSLzdhLzFzaEpETVBzWDB5ZGdV?=
 =?utf-8?B?MXB2cjdVZ0xMWVBSWjJDMjRKbzRxSndjOGg3T2tkUWhHeGxIM1J6QnA5dkpT?=
 =?utf-8?B?K0g2RVVORFV2M0xqNWtTQk80S1NtSi9ndVNBWEVvMTQwZmsyYWZ4TXY0d0l2?=
 =?utf-8?B?dFhPaVNJYUdQdUF4YnVRT2w2MWU1SnBTQytOK3RoRkUyZXZVV1Bvalk1VVc1?=
 =?utf-8?B?L29iZ0x2UnpYUktsa3MvQThqc3Y2dmNqVm1CTE80MWRKRFdNNDVZUVhick1k?=
 =?utf-8?B?aFUrajloK3FHNlVoTktWZmg0akNRTnR5ZmtDMVozTEtXTGU1TXZtdm1nMEJq?=
 =?utf-8?B?aElJV2svdVpqbm9MNWFMWnBuWXg1WWZ4dm9JY0tSd2U3cTBXdzM1R0hCc3d6?=
 =?utf-8?B?NUZNRnVYTmZGOERaRjlOQklJT0ZZNDBTV3JwR01CMGYzWlorQ2xBUTFEdTMx?=
 =?utf-8?B?UHV1VmErUEtMVXdrQXBsZUk0dkZCVUxHRk8wZ05LSHJIbjUzRWFjb1hacTMw?=
 =?utf-8?B?WHRlQ3BXdXFIMU1WN3VlYmxqcHdOSTNDZE0xb1V6VC8wY3VKNTdhbUQ5aE1r?=
 =?utf-8?B?RDBpVXczYnlJTVlYNFVuYzRNWFlGWnAzaWRoZ3dkOEVWaGdVNjJ0SWZZYnl4?=
 =?utf-8?B?MDlTNDdYL0l3UzlvcEJXSEpCZ3ZScDRyRXF5TzRncFpzMGdZdy91dXRzQ3BJ?=
 =?utf-8?B?RkJSRlV2YklkakNSWTBqM2pQcFNVd3hTcFZzei9tdTJHSUpyNmZFWkh4YllE?=
 =?utf-8?B?OWVkcVZpYnhBWlp3a204Wi9XSW9UZmJjL3RTNmhvWjNJSkhXVlBiQ0tsMHpk?=
 =?utf-8?B?aVdVWElDNlRIYW0veWx2VisrMThIOVIrUGUxbTZlTHQrRERFbkhOMkNPdm9s?=
 =?utf-8?B?U1ZwQTF5MG9POGI0akY4K3RVNmFTUm5MMThIaEVlaXdya2l1NnBXbHFwSGkz?=
 =?utf-8?B?b01wTVNxcjMza3ZlSWdybHZBby9CRVV6SzBHeHFPY250OTRsR290WlhPcFhE?=
 =?utf-8?B?L2NzOXlTT1ZjbDdwVnpyU3hBN0pud2ppT2xWcjdPSnpWTDkxV0loTThscStH?=
 =?utf-8?B?TXdsb1lvM0lTR3Z2cXBzUHpiNXJuVGZIckNKekk3Z3kxRytPSWVXV0U2Mnlq?=
 =?utf-8?B?VHFuL1pvUWFjOUpjV1d6QXkzc21GVzVpWVpaNzhmd290M1V2SWZLbkE3OTJC?=
 =?utf-8?B?RHhWYU9tMVN2UGV5Z3BLN3ZHWnZYNVdoV2hDTFBvWERqTVN2V2hnUHRPY1k2?=
 =?utf-8?B?dWdIVXBITUF2RVdKQTJ3K3FBWlVjOHQ5V09wZDlqbzgvaGdiV0RBRnVaNnRB?=
 =?utf-8?B?aW9UbEl2OFFiK3g0Y3RvRENxTTB4UkwwWGYwZEhpK2Z0dkNrNFkxRVM3QlYv?=
 =?utf-8?B?eE1Jdm9aV3dCcmgzK2Q0aHJLVkZTaDlQZHRFaDRQRWt3MEdjNDZENDNoMkN5?=
 =?utf-8?B?dVBPdS9kRXNOQm9KV09pWHJybWFtR3l6akhvUW93NytHMGlHeThkWXRPbWRW?=
 =?utf-8?B?c1YvNjF5Q2JzMThuNzAybUJzNmNQYkJ4UlhBS2JHRzdpejhPaHY1TmVOMVJp?=
 =?utf-8?B?LzFQUk5WTFd4UFhMWGFPL0VuSVR4NDNzTU5qWFFubWZSdlAyVUVOdDc4YlQz?=
 =?utf-8?B?QjZ4bEVORWtTWnd0TFZLbko5dDdQZEJ0OEsyVWtsTXA3YkRHcnY1MG55bWNR?=
 =?utf-8?B?MzhkTVlKaXZmZzhWQkk0YWJXVi9JOTRaUDZuZmt2QUgvRjlzWXlWd1hIOSt3?=
 =?utf-8?B?MEN3TEZnUEdiY3UzMzVBNjVXSzFhRnFzNTZxNHcwWHJqdUlWQUp6eWl3SWh6?=
 =?utf-8?Q?PK0pjiVu5e3TARj0KtJ94Jma0mtlUFToH6FBd3KGjkt3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211c930f-82ef-4b6a-c335-08db643b1541
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2023 14:01:52.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKhK5ZEubc0ggwVCGZqKDbyUSmHGLZl/ed0wzDkM1dF0Rhj5iKiIvayYewAEpo5M9aAwYjGsmpm1CcgkqJp1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4384
X-Proofpoint-ORIG-GUID: irsezHSHkgP_pPtReVih0Ie8GyKOA5GJ
X-Proofpoint-GUID: irsezHSHkgP_pPtReVih0Ie8GyKOA5GJ
Subject: RE:  [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback devices
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306030124
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
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMyBKdW5lIDIwMjMgMTU6NTYNCj4gVG86
IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogVG9tIFRhbHBleSA8
dG9tQHRhbHBleS5jb20+OyBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT47DQo+
IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyB0b21AdGFscGV5LmNvbQ0KPiBTdWJqZWN0OiBb
RVhURVJOQUxdIFtQQVRDSCBSRkNdIFJETUEvc2l3OiBGYWJyaWNhdGUgYSBHSUQgb24gdHVuIGFu
ZA0KPiBsb29wYmFjayBkZXZpY2VzDQo+IA0KPiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4NCj4gDQo+IExPT1BCQUNLIGFuZCBOT05FICh0dW5uZWwpIGRldmljZXMg
aGF2ZSBhbGwtemVybyBNQUMgYWRkcmVzc2VzLg0KPiBDdXJyZW50bHksIHNpd19kZXZpY2VfY3Jl
YXRlKCkgZmFsbHMgYmFjayB0byBjb3B5aW5nIHRoZSBJQiBkZXZpY2Uncw0KPiBuYW1lIGluIHRo
b3NlIGNhc2VzLCBiZWNhdXNlIGFuIGFsbC16ZXJvIE1BQyBhZGRyZXNzIGJyZWFrcyB0aGUgUkRN
QQ0KPiBjb3JlIGFkZHJlc3MgcmVzb2x1dGlvbiBtZWNoYW5pc20uDQo+IA0KPiBIb3dldmVyLCBh
dCB0aGUgcG9pbnQgd2hlbiBzaXdfZGV2aWNlX2NyZWF0ZSgpIGNvbnN0cnVjdHMgYSBHSUQsIHRo
ZQ0KPiBpYl9kZXZpY2U6Om5hbWUgZmllbGQgaXMgdW5pbml0aWFsaXplZCwgbGVhdmluZyB0aGUg
TUFDIGFkZHJlc3MgdG8NCj4gcmVtYWluIGluIGFuIGFsbC16ZXJvIHN0YXRlLg0KPiANCj4gRmFi
cmljYXRlIGEgcmFuZG9tIGFydGlmaWNpYWwgR0lEIGZvciBzdWNoIGRldmljZXMsIGFuZCBlbnN1
cmUgdGhhdA0KPiBhcnRpZmljaWFsIEdJRCBpcyByZXR1cm5lZCBmb3IgYWxsIGRldmljZSBxdWVy
eSBvcGVyYXRpb25zLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXku
Y29tPg0KPiBGaXhlczogYTJkMzZiMDJjMTVkICgiUkRNQS9zaXc6IEVuYWJsZSBzaXcgb24gdHVu
bmVsIGRldmljZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJA
b3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oICAg
ICAgIHwgICAgMSArDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMgIHwg
ICAyNiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfdmVyYnMuYyB8ICAgIDQgKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcu
aA0KPiBpbmRleCBkN2Y1YjJhODY2OWQuLjQxZmI4OTc2YWJjNiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npdy5oDQo+IEBAIC03NCw2ICs3NCw3IEBAIHN0cnVjdCBzaXdfZGV2aWNlIHsNCj4g
DQo+ICAJdTMyIHZlbmRvcl9wYXJ0X2lkOw0KPiAgCWludCBudW1hX25vZGU7DQo+ICsJY2hhciBy
YXdfZ2lkW0VUSF9BTEVOXTsNCj4gDQo+ICAJLyogcGh5c2ljYWwgcG9ydCBzdGF0ZSAob25seSBv
bmUgcG9ydCBwZXIgZGV2aWNlKSAqLw0KPiAgCWVudW0gaWJfcG9ydF9zdGF0ZSBzdGF0ZTsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiBpbmRleCAxMjI1Y2E2MTNmNTAu
LmVmYzg2NTY1YWM1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0K
PiBAQCAtNzUsOCArNzUsNyBAQCBzdGF0aWMgaW50IHNpd19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0
IHNpd19kZXZpY2UgKnNkZXYsDQo+IGNvbnN0IGNoYXIgKm5hbWUpDQo+ICAJCXJldHVybiBydjsN
Cj4gIAl9DQo+IA0KPiAtCXNpd19kYmcoYmFzZV9kZXYsICJIV2FkZHI9JXBNXG4iLCBzZGV2LT5u
ZXRkZXYtPmRldl9hZGRyKTsNCj4gLQ0KPiArCXNpd19kYmcoYmFzZV9kZXYsICJIV2FkZHI9JXBN
XG4iLCBzZGV2LT5yYXdfZ2lkKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC0zMTQs
MjQgKzMxMywyMSBAQCBzdGF0aWMgc3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3JlYXRl
KHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ICAJCXJldHVybiBOVUxMOw0KPiANCj4g
IAliYXNlX2RldiA9ICZzZGV2LT5iYXNlX2RldjsNCj4gLQ0KPiAgCXNkZXYtPm5ldGRldiA9IG5l
dGRldjsNCj4gDQo+IC0JaWYgKG5ldGRldi0+dHlwZSAhPSBBUlBIUkRfTE9PUEJBQ0sgJiYgbmV0
ZGV2LT50eXBlICE9IEFSUEhSRF9OT05FKSB7DQo+IC0JCWFkZHJjb25mX2FkZHJfZXVpNDgoKHVu
c2lnbmVkIGNoYXIgKikmYmFzZV9kZXYtPm5vZGVfZ3VpZCwNCj4gLQkJCQkgICAgbmV0ZGV2LT5k
ZXZfYWRkcik7DQo+IC0JfSBlbHNlIHsNCj4gKwlzd2l0Y2ggKG5ldGRldi0+dHlwZSkgew0KPiAr
CWNhc2UgQVJQSFJEX0xPT1BCQUNLOg0KPiArCWNhc2UgQVJQSFJEX05PTkU6DQo+ICAJCS8qDQo+
IC0JCSAqIFRoaXMgZGV2aWNlIGRvZXMgbm90IGhhdmUgYSBIVyBhZGRyZXNzLA0KPiAtCQkgKiBi
dXQgY29ubmVjdGlvbiBtYW5nYWdlbWVudCBsaWIgZXhwZWN0cyBnaWQgIT0gMA0KPiArCQkgKiBU
aGlzIGRldmljZSBkb2VzIG5vdCBoYXZlIGEgSFcgYWRkcmVzcywgYnV0DQo+ICsJCSAqIGNvbm5l
Y3Rpb24gbWFuZ2FnZW1lbnQgcmVxdWlyZXMgYSB1bmlxdWUgZ2lkLg0KPiAgCQkgKi8NCj4gLQkJ
c2l6ZV90IGxlbiA9IG1pbl90KHNpemVfdCwgc3RybGVuKGJhc2VfZGV2LT5uYW1lKSwgNik7DQo+
IC0JCWNoYXIgYWRkcls2XSA9IHsgfTsNCj4gLQ0KPiAtCQltZW1jcHkoYWRkciwgYmFzZV9kZXYt
Pm5hbWUsIGxlbik7DQo+IC0JCWFkZHJjb25mX2FkZHJfZXVpNDgoKHVuc2lnbmVkIGNoYXIgKikm
YmFzZV9kZXYtPm5vZGVfZ3VpZCwNCj4gLQkJCQkgICAgYWRkcik7DQo+ICsJCWV0aF9yYW5kb21f
YWRkcihzZGV2LT5yYXdfZ2lkKTsNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJbWVt
Y3B5KHNkZXYtPnJhd19naWQsIG5ldGRldi0+ZGV2X2FkZHIsIEVUSF9BTEVOKTsNCj4gIAl9DQo+
ICsJYWRkcmNvbmZfYWRkcl9ldWk0OCgodTggKikmYmFzZV9kZXYtPm5vZGVfZ3VpZCwgc2Rldi0+
cmF3X2dpZCk7DQo+IA0KPiAgCWJhc2VfZGV2LT51dmVyYnNfY21kX21hc2sgfD0gQklUX1VMTChJ
Ql9VU0VSX1ZFUkJTX0NNRF9QT1NUX1NFTkQpOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd192ZXJicy5jDQo+IGluZGV4IDM5OGVjMTNkYjYyNC4uMzJiMGJlZmQyNWUyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTE1Nyw3ICsxNTcs
NyBAQCBpbnQgc2l3X3F1ZXJ5X2RldmljZShzdHJ1Y3QgaWJfZGV2aWNlICpiYXNlX2Rldiwgc3Ry
dWN0DQo+IGliX2RldmljZV9hdHRyICphdHRyLA0KPiAgCWF0dHItPnZlbmRvcl9wYXJ0X2lkID0g
c2Rldi0+dmVuZG9yX3BhcnRfaWQ7DQo+IA0KPiAgCWFkZHJjb25mX2FkZHJfZXVpNDgoKHU4ICop
JmF0dHItPnN5c19pbWFnZV9ndWlkLA0KPiAtCQkJICAgIHNkZXYtPm5ldGRldi0+ZGV2X2FkZHIp
Ow0KPiArCQkJICAgIHNkZXYtPnJhd19naWQpOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
QEAgLTIxOCw3ICsyMTgsNyBAQCBpbnQgc2l3X3F1ZXJ5X2dpZChzdHJ1Y3QgaWJfZGV2aWNlICpi
YXNlX2RldiwgdTMyIHBvcnQsDQo+IGludCBpZHgsDQo+IA0KPiAgCS8qIHN1Ym5ldF9wcmVmaXgg
PT0gaW50ZXJmYWNlX2lkID09IDA7ICovDQo+ICAJbWVtc2V0KGdpZCwgMCwgc2l6ZW9mKCpnaWQp
KTsNCj4gLQltZW1jcHkoJmdpZC0+cmF3WzBdLCBzZGV2LT5uZXRkZXYtPmRldl9hZGRyLCA2KTsN
Cj4gKwltZW1jcHkoZ2lkLT5yYXcsIHNkZXYtPnJhd19naWQsIEVUSF9BTEVOKTsNCj4gDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IA0KVGhhdCBsb29rcyBnb29kIHRvIG1lLCB0aGFua3MhDQoNCg==

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D86BCB2D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 10:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCPJkp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCPJko (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 05:40:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1CA5FD
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 02:40:42 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G86fTc027878;
        Thu, 16 Mar 2023 09:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=oUHBSTQ2D37rDG+fvCnyeGJn34lxUa6kAehBkNl2IxQ=;
 b=SpDkTkcDA4Ok/CPpirLJFt9rkqhMV6BWcatD9FmB9EjtK9dSzfYfm52HYgQxH6T2jbUw
 HzPirBYzRybdf4sMZQwZRg79GWxOzh0EFyvcdaSikC63cyCbfaHQVCdTCc0I8tui7nNV
 ctyohg6tV5+6Zmepu41frxTWWBthB8SLeeT8/WuH5SWIiXuBGchuWQn2wYDWWuTdjUIG
 P83WonAQcjESj68/MaJRqUJx6/pE/8mQhpw5bImkC7Jzya84aB67FPSIdaBreuAJUbGh
 Riy79v7bD179GcBuFLznuEXD5Pqb07iBOfi2Q6NtCuajpDrSxqrJmHzHNfI6Zma7cF+E IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbpwb5ffj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 09:40:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G8eHSM010491;
        Thu, 16 Mar 2023 09:40:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbpwb5ff8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 09:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT+gk+p36Phcnfu6UInrWgdDzs09Q1/ZhmG3H7HsCItC/ll/jcKxdak1eyeyaGLd3pwNsVv8Sy+bpy075+SAFIzsK11fj0bgbvC5TVoaGlOQxA+TelUMB3HPH05vaMVfK9Tem5IT5imYeP8WmtJ5Kq6SDpKAVbWuMZHTYVDdi0xVrUbwaYSpN8Nmom3tI9n1gAprihxWEAuCdo7lBZ/joMQ+phPbnd2ji0CI+mZWflfWjYj2IQaBXQECW4zG0LhGvTn5OGz/KcrGRk1c3DgC76KAkyJC4GEH3MR9fKIfyLrqGUERCDQWZ0UDYrJw8cSorbL5ju+JYhLa8hKvwlW52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUHBSTQ2D37rDG+fvCnyeGJn34lxUa6kAehBkNl2IxQ=;
 b=dSTMiRV48FG7w3Cutq0Mr72k1aeUsJFFFLfOEeG17wQi9CoJlEUHv9XrqLJiWOgS5trcYfTtWTv2zOFQspySNzi0Ofu5RNwNff5HpimoHyCgJ8DjdSTYCGNBnaodMXM1BAbE3nKTLVthNJTiC/lt59W5LZo4JJtXZS9yXuyK+D52W/jGQE2EoQlf7zYwlx2ySztGf3umzPZgpxABSlRzF4ynh4cLCom2f+vggB3mF9NyvKxbFJKB+zoCnKda+ryForYvGYQFBgzbfcnoZ2u3Yk0R8yyJTlcctpTRTKq8hnwJLsLqffkLMBRQen8SWzB7hH6DJvtqa3UHkXh45MZw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH7PR15MB5253.namprd15.prod.outlook.com (2603:10b6:510:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 09:40:37 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%4]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 09:40:37 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] question about the completion tasklet in the rxe
 driver
Thread-Index: AQHZV4j3WSWhx7SfbEurFmBiQxMrSa79Ihsg
Date:   Thu, 16 Mar 2023 09:40:37 +0000
Message-ID: <SA0PR15MB3919EAF4C949E82D2887C1AA99BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
In-Reply-To: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|PH7PR15MB5253:EE_
x-ms-office365-filtering-correlation-id: 286001c8-043e-4a58-3e2a-08db26027fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNWjsiGQHPObkrB1Y/PdN1xbhXN5w968SaqM5p9j1H+WR47QHHHGfkl6OYybt86790lfTX9mEhUhreW1OriaQTweAWlQkxQKWdooj01Uzq63CtmpfZjVPGAobAPrvUqph2FPhufaCu03JV70E+hI4y4Lm4ItfFyk4ZJdUgWHUp8K+PdfrIU2RNrKdaWUBimQwE/FeVg7VvWom1chKuIFX0SEBixmiAQAfaRZ73ScogMbaICGpQb11rw/L+sEKgYohgi0lE03INyo4EGam0Ou+pxeHm0irqVnfsavlvNsV4X1XqLs7ulGezEvC8CyoKgTzXqpa1ku1Z/cQEEmSs7Dkti0R7VQX+AZm+6HSg+AmelrrQT8CBkA/UBx/Kv2pPqkHkDtaNVy6bRZsIbiCpuc0UYdGsoxDwCDygmvKvdHH/AU5ktkvyt/s+AFVQwcPZj0zjIwTpu/F7BOAQI2wsSNsvxQdhR2QA5iQeqFLG77xyes2jRGQVVkwdqMSQUl7OIBLWjz4JoDvobIISf6pSWazH4nX4zXUlSi2k0nXov8YmwOx3zYVP8zmnDtZuMW4lKO55ik25o5ZOuP8PKe2LSCuWiU43iNnlPx8RnDSaX0pd6gzPt2srvPpvzc7lnZ9WBEvLmrchmAa0xVb7hNZjDx/au7SOaQvSv4rdqiyN815cR/mgoYiy6OyKkHOs7CgUwS1bKv0EivD9YMtuh4X9Y1ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(38070700005)(33656002)(38100700002)(122000001)(2906002)(8936002)(52536014)(41300700001)(86362001)(5660300002)(55016003)(6506007)(83380400001)(9686003)(53546011)(316002)(110136005)(186003)(66476007)(66946007)(66446008)(71200400001)(478600001)(7696005)(76116006)(8676002)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U09aNlkrNVNGSmNzTUN0NUE5OTBYSDlaTk5pcXVESThjU0FPZ0cvMGc0ODd2?=
 =?utf-8?B?SFJTUUVCVnM2MDJFSFFBTkZrZGs4cnFNWEFLY0ZFWG1UdVNpNUVQWjVoT21n?=
 =?utf-8?B?K1RBUHRub0JIdUJObXZIT3pzckpNVDJYV1o2QkY4STRXQUV2Tkl1OUFNWjhQ?=
 =?utf-8?B?U2JBaGlaUHMxbDhpRUE2OE1BNmw4b3drVGlXRnpJY1U0ZmJncE5CZHNQbWZN?=
 =?utf-8?B?QUI0ejdsYWFta2ppUmttM2gzcElLNDJNalpJbk1IbFJ3Q3oxa2FpQ2xBTmln?=
 =?utf-8?B?NXhDSk54UEFkWXkyeTZNTmlYTHZnVngwOEVuTFVDbTFrYkZUSlo4MmJobHAw?=
 =?utf-8?B?eWNhRnJodWVLQWYyU1VhdDRLaFBrUmFSSlJ5ZGlTWmExQTBhb1dqOUlyRW9h?=
 =?utf-8?B?OXVPOVZGRVRIZzJQTlUxTDNCdHFsM1IwOVRLYUwyOEVxbEpXWkNSVnVVSnp5?=
 =?utf-8?B?NnJYYnZ6REVMeForSXhQZXd1bzBKRGhpUUQ4ZnJ0QlUyTXNOY04wZEo2ZDZv?=
 =?utf-8?B?cjgrQXZ3TjFBYkU3S3RDR1B6aXYvakRVb0Fnc1pDZk9ieUh2RmJTdGRURHZH?=
 =?utf-8?B?UnRhcDVNV0dUYzc2TlpzcGJHZGpxbm9LYlhKaWFaMkg2dEJLRjNCT1g2eC83?=
 =?utf-8?B?cWEvdUlqWHRtTU5jbXVON3g1K2QyY0d4ZEZISmJ5bFdKZUtVUVhyRGo4YU9h?=
 =?utf-8?B?RlErSUdxZWszb01pd0YxZElLZ0pkcEpQWDJPTklTclJDTEdRME9mN0RHMWhp?=
 =?utf-8?B?QzZ2RW1iYVc0NHlqb3lNMG94U1hkaG5HbEdiQ1R0TmRLT3JWLzBnVkdRM0ND?=
 =?utf-8?B?Y09SRjVNN3puQTJQRGVDeFFEb1FDRmxGOTVHOVRMeVYxVWdSd1JPa1liU21Y?=
 =?utf-8?B?V1Y5WGE3UFFxN3I2TXUyYzBLSm5xaUswVXI0eFRyRXd6MVNUb0JIWlhZVDVh?=
 =?utf-8?B?QWhLNVRxdFdJZFNFcmRiSC9NZDhzRU9FaGpGUGhyc0NVR2NHMlBmMHZzSDRx?=
 =?utf-8?B?Z0dCdGNQVG1OdTNFcFBBOU44STFiWjBEbWhuaU5NRDF6cS9nU2syWlBLOTdF?=
 =?utf-8?B?ZHBSUHNEOUxiNFNNaGNDenlvdUozTS9qam9WNVpwV3JUU1dKMXBYcHlQTnY5?=
 =?utf-8?B?NitSczNQTjZXazdrZDBhU2Nqa1FMNVQyZjJmNnh1N0wzRUVMOTM3VVR6YVNQ?=
 =?utf-8?B?S0hXNEhCMFd4c3hhZnhWbks0UUV0RmI1WURMNGxIVXRxZ2lsaHlEbFgxVk1a?=
 =?utf-8?B?amZoSFlXbDFUaHVZYTNTQVJFMnpNdDQ4d09jdUE1WVp3NUZFK0VpcmllS2hD?=
 =?utf-8?B?MmkrL2RyMkw2NndxQVBjVEE0Zm1ReVk2V24xVW1sK0U2aEE0NHp4OURzRnVo?=
 =?utf-8?B?OVRkUExFUFViT3RRRzhacXRVbHZZeUVVSEZMTTRXQnZ1TytrOWJFbmY0UCtN?=
 =?utf-8?B?SWEwMjdrc2JJZjVmVEw1MmRVTTd3bGFVTkI2ZWd6dnViTWpHQlRNSm81Q1JP?=
 =?utf-8?B?emxXeVpHZWJjTjgrUUpDL1Z2S3JDcUR6ZjUrT1JoQ0hPOWZld0t2VVU2QUpk?=
 =?utf-8?B?QXpCQXBxK0d3OWpUdXBKa0ZXRTFEQWM1MDVnN3NXOE9pc2s4czBMMzd6cUs1?=
 =?utf-8?B?NmZSNVVUL2Q5R1Z2VVBsREg5ekRnZUlNYUZmQ2ptek9uVlc3cXZJd0xXUDZw?=
 =?utf-8?B?eWVrcXdVb2l2NXB2K1dNcWw5V2gxQVd6bXRyWUgybGdtb21zUkJPVXdCdTJX?=
 =?utf-8?B?bWkyZVJTTHpQenVxOFVxcFZneVhSdnB3NjhFbnk3MlZyMGM4Z1lxQllUbnRp?=
 =?utf-8?B?WFFYWlEvUlFodW0xWU9FOUZxQXRTUi96VWg0VG9DL2JMbjRZTGZhREQzUFQv?=
 =?utf-8?B?SVdPNFNPbTFxZFJXOWlIK2NkNkwxR1lIbUtVUnd2QzBIZ3JrcFVaaHlCSUQ4?=
 =?utf-8?B?clJIYzVSTitSbjdna0ZUREVhQzdxR2lSRDJkTG1XQ3VEM04xMGdNeDl3L2V6?=
 =?utf-8?B?bDUvUW4rNFhVcFhoM2RqbjNUTlkvZmdvMk1MYnVnQmtpNnZjemE1dEY4ODdy?=
 =?utf-8?B?Wkc5SEx2c1FRL1dIaUJIYUp6bTFlNFhoa0svaUszUkd6Ukh4bnc3QTgyVENO?=
 =?utf-8?B?cWlicUNxd1R5NjEvcTF4bGVXd2E1ZU9mclVWME1MZEdnREtNMHpvZEUvN1U0?=
 =?utf-8?Q?CFkG/NJnBoiKNzVtgj6aif0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286001c8-043e-4a58-3e2a-08db26027fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 09:40:37.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNdnrKgf7cy4zVLNAn70qk6MoHsWM5NL2dRNlEMxgpJgjlhXk7U8Hsmai7ZddeYiM4Tmgn5ixyFkI3JMUXP85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5253
X-Proofpoint-GUID: ArdSF3DQ0hhUWUOZOPpc6Ao_FbnS3T9_
X-Proofpoint-ORIG-GUID: Wl16oXJVR6TXsxvm_WJ4cubRs_OIWkut
Subject: RE:  question about the completion tasklet in the rxe driver
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9iIFBlYXJzb24gPHJw
ZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxNSBNYXJjaCAyMDIzIDIy
OjU2DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgWmh1IFlhbmp1biA8
enlqenlqMjAwMEBnbWFpbC5jb20+Ow0KPiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgQmVy
bmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
cXVlc3Rpb24gYWJvdXQgdGhlIGNvbXBsZXRpb24gdGFza2xldCBpbiB0aGUgcnhlIGRyaXZlcg0K
PiANCj4gSSBoYXZlIGEgZ29hbCBvZiB0cnlpbmcgdG8gZ2V0IHJpZCBvZiBhbGwgdGhlIHRhc2ts
ZXRzIGluIHRoZSByeGUgZHJpdmVyDQo+IGFuZCB3aXRoIHRoZSByZXBsYWNlbWVudCBvZiB0aGUN
Cj4gdGhyZWUgUVAgdGFza2xldHMgYnkgd29ya3F1ZXVlcyB0aGUgb25seSByZW1haW5pbmcgb25l
IGlzIHRoZSB0YXNrbGV0IHRoYXQNCj4gZGVmZXJzIHRoZSBDUSBjb21wbGV0aW9uDQo+IGhhbmRs
ZXIuIFRoaXMgaGFzIGJlZW4gaW4gdGhlcmUgc2luY2UgdGhlIGRyaXZlciB3ZW50IHVwc3RyZWFt
IHNvIHRoZQ0KPiBoaXN0b3J5IG9mIHdoeSBpdCBpcyB0aGVyZSBpcyBsb3N0Lg0KPiANCj4gSSBu
b3RpY2UgdGhhdCB0aGUgbWx4NSBkcml2ZXIgZG9lcyBoYXZlIGEgZGVmZXJyYWwgbWVjaGFuaXNt
IGZvciB0aGUNCj4gY29tcGxldGlvbiBoYW5kbGVyIGJ1dCB0aGUgc2l3IGRyaXZlcg0KPiBkb2Vz
IG5vdC4gSSByZWFsbHkgZG8gbm90IHNlZSB3aGF0IGFkdmFudGFnZSwgaWYgYW55LCB0aGlzIGhh
cyBmb3IgdGhlIHJ4ZQ0KPiBkcml2ZXIuIFBlcmhhcHMgdGhlcmUgaXMgc29tZQ0KPiByZWFzb24g
aXQgc2hvdWxkbid0IHJ1biBpbiBoYXJkIGludGVycnVwdCBjb250ZXh0IGJ1dCB0aGUgQ1EgdGFz
a2xldCBpcyBhDQo+IHNvZnQgaW50ZXJydXB0IHNvIHRoZSBjb21wbGV0aW9uDQo+IGhhbmRsZXIg
Y2FuJ3Qgc2xlZXAgYW55d2F5Lg0KPiANCj4gQXMgYW4gZXhwZXJpbWVudCBJIHJlbW92ZWQgdGhl
IENRIHRhc2tsZXQgaW4gdGhlIHJ4ZSBkcml2ZXIgYW5kIGl0IHJ1bnMNCj4gZmluZS4gSW4gZmFj
dCB0aGUgcGVyZm9ybWFuY2UgaXMNCj4gc2xpZ2h0bHkgYmV0dGVyIHdpdGggdGhlIGNvbXBsZXRp
b24gaGFuZGxlciBjYWxsZWQgaW5saW5lIHJhdGhlciB0aGFuDQo+IGRlZmVycmVkIHRvIGFub3Ro
ZXIgdGFza2xldC4NCg0KVGhhdCBpcyB3aGF0IEkgd291bGQgc3VnZ2VzdCB0byBkby4gV2h5IHdv
dWxkIHlvdSBsZWF2ZSByZWNlaXZlDQpwcm9jZXNzaW5nIG9yIGZhaWxpbmcgc2VuZCBwcm9jZXNz
aW5nIHcvbyBjcmVhdGluZyB0aGUgQ1FFIGFuZA0Ka2lja2luZyB0aGUgQ1EgaGFuZGxlciwgaWYg
eW91IGFyZSBpbiBhIGNvbnRleHQgd2l0aA0KYWxsIGluZm9ybWF0aW9uIGF2YWlsYWJsZSB0byBi
dWlsZCBhIENRRSwgc2lnbmFsIGl0cyBhdmFpbGFiaWxpdHkNCnRvIHRoZSBjb25zdW1lciBhbmQg
a2ljayBhIHVzZXIgaGFuZGxlciBpZiByZWdpc3RlcmVkIGFuZCBhcm1lZD8NCg0KT25seSBleGNl
cHRpb24gSSBzZWU6IElmIHlvdSBwcm9jZXNzIHRoZSBTUSBpbiBwb3N0X3NlbmQoKSB1c2VyIGNv
bnRleHQNCmFuZCBhIGZhaWx1cmUgcmVzdWx0cyBpbiBpbW1lZGlhdGUgQ1FFIGNyZWF0aW9uLCBk
aXJlY3QgQ1EgaGFuZGxlciBjYWxsaW5nDQppcyBub3QgYWxsb3dlZCAtIHNlZSBEb2N1bWVudGF0
aW9uL2luZmluaWJhbmQvY29yZV9sb2NraW5nLnJzdA0KTm90IHN1cmUgdGhvdWdoLCBpZiByeGUg
YWxsb3dzIGZvciBkaXJlY3QgU1EgcHJvY2Vzc2luZyBvdXQgb2YgdXNlcg0KY29udGV4dC4NCg0K
Q2hlZXJzLA0KQmVybmFyZC4NCg0KPiBJZiB3ZSBjYW4gZWxpbWluYXRlIHRoaXMgdGhlcmUgd29u
J3QgYmUgYW55bW9yZSB0YXNrbGV0cyBpbiB0aGUgcnhlIGRyaXZlci4NCj4gDQo+IERvZXMgYW55
b25lIGtub3cgd2h5IHRoZSB0YXNrbGV0IHdhcyBwdXQgaW4gaW4gdGhlIGZpcnN0IHBsYWNlPw0K
PiANCj4gVGhhbmtzLA0KPiANCj4gQm9iDQo=

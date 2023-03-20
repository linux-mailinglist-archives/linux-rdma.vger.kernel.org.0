Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B36C11DC
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCTM1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCTM1Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 08:27:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660C10273
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 05:27:15 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBHhx5001353
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 12:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=RmTehZ2KsbK6zwOdgx4Y9AnUKCXMz4HqO/P+GU+AB5k=;
 b=Djd+YEi+FvFFrHEUCG406NjZD2jjiPnjP9CwNCTn6e76VtvpJ6FQ/IOAKpaCTvcD+pZ+
 coIhv66vc7WTuh09gX3rbW8Qk55MNQbSmIkq+exxYJ/beCPq8uI9XzgmK0z72nDp9wq5
 bZDA1vwunTuZkE3YSnfgT5OmfQuCoY7vm9tDgGiR2Tf+yPwCr8lvqRtHILWBT0PxtCkd
 vYIk6+9WYcICOZeh//SNNkm6vhsXzoIblpI/FpKCzos5u2gTzQ+d1E6HxOOwbd7G+QsW
 ZddrOLIKDfrLpxCSanO4trCvILlt6sCLdw9o7c26vIGSvoPUUt70qyKbA9vglCkIEebw 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pepfwhw5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 12:27:14 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KC0CBd014850
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 12:27:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pepfwhw5c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 12:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ankqb0Ei9fSM8ZvQfqbsN2Zwngf+kHA0af5mNgcj1srv8kC651wSBZNdj1bl+gTmPB9m6NoBIuP0UCtcIf6bkIxf5kLd5OWXZdSunVIdyCp68uLrS/4IOBoql2GHZUNrIOERaHT3Za2+bhTIV1E8sRj4CViC9A0voaZayRWhXaRIuzC8d03+pvCZ1/UgIqHhJpuEmA9meqW4/qU9jzvYZtoZEB6nqxOK+dZ7TBIHlxfu+rRSqrTlvJ4D5qJ+7Zob9Ckw1XyfQSv1DGuolj3qh8kruuCO8J8PU3MGKYleKvuWsN8UDq7Bh3W04cVRrwUon3QiNxzveuIpl4/nSEmj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmTehZ2KsbK6zwOdgx4Y9AnUKCXMz4HqO/P+GU+AB5k=;
 b=IKiNVPwkTV9jmPE5QFmuZqqeHWrDWook0gVR+YvY/DyiV577CKVn0WNtoCbbqPP9OeMegscGDMPo1RfcySa5VFkjJOZUIpf5GitFD0y99UMqsSX5jkz/jWRo36uM1xd+m/49MFdguOpKmA/5+/XxXKo6E10MEr9MEeW2dcGa5uPZ6f8A2PCIpg5mmDVqCR9f2AHPlJIwXrO/nx56BqLt+iMLeJss100EYjixCT2pEKf89WMuuM9CaAWsTr8a400fyBGTqDHkj/beTP3WCsU+9MJa9/yZFz9fWc9k/SrlZ0R/2mXP8Wy+Vfcs7JkGMwRw6FOhljwdSQYJqD7gtXAG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by IA1PR15MB5852.namprd15.prod.outlook.com (2603:10b6:208:3f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:27:08 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:27:08 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     David Howells <dhowells@redhat.com>
CC:     David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
Thread-Index: AQHZWxxfewgZ8p+FCUuQ0QJVgyZJH68Dl2NA
Date:   Mon, 20 Mar 2023 12:27:08 +0000
Message-ID: <SA0PR15MB3919CF7A2996702BEB68E3F799809@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com>
 <20230316152618.711970-1-dhowells@redhat.com>
 <20230316152618.711970-9-dhowells@redhat.com>
 <1716675.1679310535@warthog.procyon.org.uk>
In-Reply-To: <1716675.1679310535@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|IA1PR15MB5852:EE_
x-ms-office365-filtering-correlation-id: b037cca3-ff19-4a15-ff97-08db293e6c12
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lD1Hifm26CsHQouBEBg4TkaiQvne8UZfSNatpx7S70Vb6mHLTrgX2X1QYEzZoBneKkU5e/hpwo72A48a3vkVcBebC2KpQ1BXZJ2Kc6iKZiaL32LGgq8UOhvx6EiUmf98Nvfak2a2kTcTSibiIQz2rJvwXzufT/6Xt+XKkbWTnit9pBwUOH2RAgpDF9jIdybAhfWPyyXnTTGKXhTEVaDGuN22myOPYaRVhhgmc+u6WP2XKEHZSbXw0h3+azHmSVFplIBDvaY+hn+aHi23zz7epy2/vVam0k39qd3gEa6QFi4nTW2UCfWXqBFVPLUD7ZIeet0NEDGF3EPBePpZhV5WDnGZRaXDR2y6GpEFa8ARl+LLUv6h6gng+wSJjqP2miPxqniaF9aMjPlLGC5SC03XTelTf6Nqm8YsKa6MTXQxBDs8DD+640+IhkrIroOZQfiL2vdj4b+WKB19y/ee8bsCkTUT9cF/kdGnQ3jxGt36SLrW4AP/Q0mPyS5I7IvroU5Uw/15p2fFHsTkwk52cznMH/hgmMrifeBgZKWww/K39YN/G1dOvQ8a57Qrue2biBPXeBO1MU3qXQ7Lw28qrB2tOLkPYrXPzq7ZiremWNvDhh6NI0nZPKw1W66G/0CEhZaczqFjVWPGODDvzjfP6H1/TMxfFf8irUVC9wUlC6URfcDlNzGrMfbtGxlcyVkgqgCGBDr1pOWZlOaAtY/b3MWeqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(38070700005)(7696005)(33656002)(5660300002)(6506007)(71200400001)(53546011)(478600001)(316002)(54906003)(9686003)(186003)(86362001)(83380400001)(8676002)(6916009)(4326008)(76116006)(38100700002)(66446008)(66476007)(64756008)(66556008)(66946007)(41300700001)(122000001)(8936002)(55016003)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGJvU3JiS2NtZWxhZEVMb0FFNFoxUmdJeG81ZFU0bHhlYm5xWmVjaXM2M2Rk?=
 =?utf-8?B?ejBuaVpwMEtUYWd4czE0Qno2Q2FvUDd2T0JTaGQ2Zzh3cFhkYWZSVjNMM2ZR?=
 =?utf-8?B?TWJRYkdQSFMyU0k2dXNqcFRBcW45dUZRdnpUWmwyN090NFE3bk12VUI1Znkv?=
 =?utf-8?B?b3NSSEFRcnRDQUxET2RQR1c1SFNlbmRHM3VKZWVyaEdpSzFoNTZYbjJJeGIz?=
 =?utf-8?B?amNFdHZicm1NM2RDVDhQQXZBeGVpak9ZUU5jZmxPNVRrMFl1YUVIc1l6bzdT?=
 =?utf-8?B?MXhvU2pjZXI3Ry8yd1VkdC9oRmdodlpYc2dQTFVENjQyVlcxb0FuU29MbHl6?=
 =?utf-8?B?MkRxRDROQUE4cENXbkgxU2hEYzZET244VXpVS3dCcUMzeEN3M1BNa3ZTOFJB?=
 =?utf-8?B?cmFHeFA2T1p2dk5KVGFreE82b1JjdndVMlBLYng3NDducG80NUdhVEFpNUI0?=
 =?utf-8?B?QmpTRzJVUEpXWlF5Q3Nub2FOMHZWRXVXeDlHMHJuZWVSYklkSTJnV2toUW8y?=
 =?utf-8?B?b2xDb2llVkJDSnJNQU9ldG1Ib3Y2d2R5Vlh6b0hyYU5YYmNKUGNYNkFnd1Rv?=
 =?utf-8?B?VlBlZjdXRjFLWjdsZENxclQrNzNOVEJSQXpPZDNyRkt3WmVSSHBQOTQ1Y2F1?=
 =?utf-8?B?dDJqaGVEZ1M4eXk0UXV4MWt4dDhjRVZWWjE0VTdkbmdNUS9sTmNtZ1g3RkVs?=
 =?utf-8?B?ZGJrK0Q5R2huYWljQlFMSGZDUFlRWXlacmlYVFVza0I5Q3hRc0VLc0xQNTJT?=
 =?utf-8?B?V1BEdE5WcWI1T1hPeHRpZnBxL1dZY05wRFBJcFVrYzA2WHBKOUp1MXZkY05Q?=
 =?utf-8?B?QUIvWFE5bmFQVjlTMWtJZHdmVTBtQyt1akhXSm41M3h4SytnWkVpREVtYWU2?=
 =?utf-8?B?ZEFTMThlUU9lMysrYTFKd1VtMGhBTUVBdUpIOS8xakVpbXE5QjJYTmV2MXVk?=
 =?utf-8?B?aVY2ZW5tVTh2czRnTHovYVg5MUxpaWtKVHRZRG0vUFBqeTdmTTB4T2RwOWtz?=
 =?utf-8?B?bEhveTIvdjJsM3NDbHNBRjNMYkZYQy9sUUczTGp3Sm1IN0NuTnMyWTdKOE1E?=
 =?utf-8?B?aDZBSGFaTk8xOUMzemdRazhwL1IvVnpkdkpIOVpiWmNMSm1YVGs5RStHanNU?=
 =?utf-8?B?WWhOUHpkZEQ2Uk5CT0Zabk5sRUJxS0o0TGVzM1hKUkh3bjRaVEl3WHNmYSt2?=
 =?utf-8?B?aVFlUTQ2aWgzYlQzNWlnM1FHWit5Tmx0RUZJd2ZOSjFIRFZwV1ZIMURLU09t?=
 =?utf-8?B?VUxYRGYzTTVROUtiNE56eUJTUUl2eXRrbCtmV1JHa2NVUjIxUGhwbDh6Q1dE?=
 =?utf-8?B?czNHSzBaNTdqTXBkbW9JcHBTV2tJaXRyTXpMdGNTZ00vcmZFWndMMHkwVlhE?=
 =?utf-8?B?ZVMza3JzME85YUEvbXdHaGdSSEFMOC9nTlRwK01pZU1LTU0xNUxuQzJoZXFk?=
 =?utf-8?B?NkdvRkg4Z0JmenZUUlRVb2x0Vnd4dlZFY3ZkSEF1WUp1ait2TWpjdVYxT1BL?=
 =?utf-8?B?RDg4dzFMQ0JibzAvSEVjRzgxamROaDIwd3d5dFVRSDNzWmY2MDRsUWYvcDM4?=
 =?utf-8?B?SEZlNkgrbmQwTGU3akdOSXNTa1Y0N2ZYa3drbHB6ay9MK1ZUV0wxM25WU1Zt?=
 =?utf-8?B?ck01MkdvcVEwdXJrUnpFR0kzZkZlbWtETUxZWCtCd1FaWklLVnJYTUViM2dz?=
 =?utf-8?B?cDdVRWt3YW1XSmluS1E1NDBZRXdrU2FQbU83dXN5bDltSGhndTFNS0Ivb0Vv?=
 =?utf-8?B?ZEhWQmZCWXcvb2IzemRDdm9QMlEzeUlyRjRBam11LzlzVFNBODh5NGF1SFhN?=
 =?utf-8?B?Qlgrc3FpL29uWitKQzh0U1JwZ2psc05yNEs0NVZlbXJteW9SRGtESlVQV3ZC?=
 =?utf-8?B?M1BZRjZvUzlvNHdCcU12QmcxWWpIcTRid0VTTC9HRjVhMDNta0FGQ2NpOVh1?=
 =?utf-8?B?aDZ5VW5Dd3NJTXVUYjBWYkN3alJwVXRKbEdZaXY3WlBBYVIrTHdXM0VmZkE4?=
 =?utf-8?B?RVBxd1ZKemlYeGxUUmVYM2N1dmZLWUl5MGdoYTdwWTB5UDVhZ0RNWWptTXdQ?=
 =?utf-8?B?d0lyUXBVZ2kvUUp5MTBKQW96djdOZDJvM0NFYkZodHNZOEF0RjVqblBCSG0z?=
 =?utf-8?B?dHd2ZWhjTkNyOUJBZG1IdEVDVkVjSzhxSkdMQ2lMYVdOYW5kaXlMRjdTMjRo?=
 =?utf-8?Q?Dv9td5nRkCFcUVeKW4wBorc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b037cca3-ff19-4a15-ff97-08db293e6c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 12:27:08.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqJMEYoey0NlVjS+tzHOyWWYG4xdjdWsrdJ+SYRZOVo9ne3apxK2YEBxucOYFvCUY3q0yNLqjFcRUesTE1u2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5852
X-Proofpoint-GUID: dDTsFydBqp87FnC4nCK-hBvyFKaxPelm
X-Proofpoint-ORIG-GUID: Gvv1C5KPZrlF_p3vioPb33y_7jmtnKeS
Subject: RE: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_08,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=352
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSG93ZWxscyA8
ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCAyMCBNYXJjaCAyMDIzIDEyOjA5
DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IERhdmlk
IEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+OyBUb20gVGFscGV5IDx0b21AdGFscGV5LmNv
bT47DQo+IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtSRkMgUEFUQ0ggMDgvMjhdIHNpdzogSW5saW5lIGRvX3RjcF9zZW5kcGFnZXMoKQ0KPiAN
Cj4gQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+IHdyb3RlOg0KPiANCj4gPiA+
ICAvKg0KPiA+ID4gLSAqIDBjb3B5IFRDUCB0cmFuc21pdCBpbnRlcmZhY2U6IFVzZSBkb190Y3Bf
c2VuZHBhZ2VzLg0KPiA+ID4gKyAqIDBjb3B5IFRDUCB0cmFuc21pdCBpbnRlcmZhY2U6IFVzZSBN
U0dfU1BMSUNFX1BBR0VTLg0KPiA+ID4gICAqDQo+ID4gPiAgICogVXNpbmcgc2VuZHBhZ2UgdG8g
cHVzaCBwYWdlIGJ5IHBhZ2UgYXBwZWFycyB0byBiZSBsZXNzIGVmZmljaWVudA0KPiA+ID4gICAq
IHRoYW4gdXNpbmcgc2VuZG1zZywgZXZlbiBpZiBkYXRhIGFyZSBjb3BpZWQuDQo+ID4NCj4gPiBU
aGF0IGlzIGFuIGludGVyZXN0aW5nIG9ic2VydmF0aW9uLiBJcyBlZmZpY2llbmN5IHRvIGJlIHJl
YWQgYXMNCj4gPiBDUFUgbG9hZCwgb3IgdGhyb3VnaHB1dCBvbiB0aGUgd2lyZSwgb3IgYm90aD8N
Cj4gDQo+IFVtLiAgVGhlIG9ic2VydmF0aW9uIGluIHRoZSBjb21tZW50IGlzIG9uZSB5b3UgbWFk
ZSwgbm90IG1lIGFjY29yZGluZyB0bw0KPiBnaXQNCg0KSGFoYSwgeWVzLiBTbyBzb3JyeSBmb3Ig
dGhhdC4gSSBhbSBnZXR0aW5nIG9sZGVyIDspIEkgbmVlZA0KdG8gcHV0IG9uIHNvbWUgbW9yZSBz
YW5pdHkgY2hlY2tzIGJlZm9yZSBwb3N0aW5nIGhlcmUhDQoNCg0KPiBibGFtZS4gIEkgbWVyZWx5
IGNoYW5nZWQgImRvX3RjcF9zZW5kcGFnZXMiIHRvICJNU0dfU1BMSUNFX1BBR0VTIiBpbiB0aGUN
Cj4gZmlyc3QNCj4gbGluZSBvZiB0aGUgY29tbWVudC4NCj4gDQo+ID4gQmFjayBpbiB0aGUgZGF5
cywgSSBpbnRyb2R1Y2VkIHRoYXQgemNvcHkgcGF0aCBmb3IgZWZmaWNpZW5jeQ0KPiA+IHJlYXNv
bnMgLSBnZXR0aW5nIGJvdGggYmV0dGVyIHRocm91Z2hwdXQgYW5kIGxlc3MgQ1BVIGxvYWQuDQo+
ID4gSSBsb29rZWQgYXQgYm90aCBXUklURSBhbmQgUkVBRCBwZXJmb3JtYW5jZS4gVXNpbmcNCj4g
PiBkb190Y3Bfc2VuZHBhZ2VzKCkgaXMgY3VycmVudGx5IGxpbWl0ZWQgdG8gcHJvY2Vzc2luZyB3
b3JrDQo+ID4gd2hpY2ggaXMgbm90IHJlZ2lzdGVyZWQgd2l0aCBsb2NhbCBjb21wbGV0aW9uIGdl
bmVyYXRpb24uDQo+ID4gUmVwbHlpbmcgdG8gYSByZW1vdGUgUkVBRCByZXF1ZXN0IGlzIGEgdHlw
aWNhbCBjYXNlLiBEaWQNCj4gPiB5b3UgY2hlY2sgd2l0aCBSRUFEPw0KPiANCj4gQWggLSB5b3Un
cmUgdGFsa2luZyBhYm91dCBrc21iZCB0aGVyZT8gIEkgaGF2ZW4ndCB0ZXN0ZWQgdGhlIHBhdGNo
IHdpdGgNCj4gdGhhdC4NCg0KRGlkIHlvdSB0ZXN0IHdpdGggYm90aCBrZXJuZWwgVUxQcyBhbmQg
dXNlciBsZXZlbCBhcHBsaWNhdGlvbnM/DQoNCj4gDQo+ID4gPiAtCQlydiA9IGRvX3RjcF9zZW5k
cGFnZXMoc2ssIHBhZ2VbaV0sIG9mZnNldCwgYnl0ZXMsIGZsYWdzKTsNCj4gPiA+ICsJCXJ2ID0g
dGNwX3NlbmRtc2dfbG9ja2VkKHNrLCAmbXNnLCBzaXplKTsNCj4gPg0KPiA+IFdvdWxkIHRoYXQg
dGNwX3NlbmRtc2dfbG9ja2VkKCkgd2l0aCBhIG1zZyBmbGFnZ2VkDQo+ID4gTVNHX1NQTElDRV9Q
QUdFUyBzdGlsbCBoYXZlIHplcm8gY29weSBzZW1hbnRpY3M/DQo+IA0KPiBZZXMgLSB0aG91Z2gg
SSBhbSBjb25zaWRlcmluZyBtYWtpbmcgaXQgY29uZGl0aW9uYWwgb24gd2hldGhlciB0aGUgcGFn
ZXMgaW4NCj4gdGhlIGl0ZXJhdG9yIGJlbG9uZyB0byB0aGUgc2xhYiBhbGxvY2F0b3IgKGluIHdo
aWNoIGNhc2UgdGhleSBnZXQgY29waWVkKQ0KPiBvcg0KPiBub3QuDQoNClNvdW5kcyBnb29kIHRv
IG1lIQ0KPiANCj4gRGF2aWQNCg0K

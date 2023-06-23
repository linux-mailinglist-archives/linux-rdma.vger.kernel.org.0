Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB573BD52
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFWRCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFWRCm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 13:02:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448526AF
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 10:02:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NGrued022785;
        Fri, 23 Jun 2023 17:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HmnoRCNBSnGQBy+Ava+m8aUHdbVLf3i7aWo+useQJlY=;
 b=3BmE2aeeuBHwUP1HB/koKlqDf/2l+5lFdxgZX23XFrBuffd7CTxcnVK7fHjbQXHw4FES
 xyoADoy/snRbLpxSKiYycG5Iy5We7cwoitb487HumOQqx4DOb5P6FRfJUOn2WNU2yKpr
 WGfr7kQ0sGLUYsdGmU+Rq96wDFEvBh2pCzhcgT3MpDDRMP0YytoE2nsafsGY7h0MwqJq
 P3TFvVGL6ub8F4QqJHKzP9pIu2lznwgTRQtZ8yvaXPA+f76MhubcF2GAOgGyR3YCL+0c
 Bar8y9XtjYZpIJS3hjzOJfbyvuETHjSwVH9O/XNR+YfKp8YbKcVKPEj9dlYqYs0DfQ+3 zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dvcg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 17:02:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NGSGx3005872;
        Fri, 23 Jun 2023 17:02:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93995dk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 17:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADI96BTy4sajOvEwVMbOoFYX//PY/W6RHQ3miBjFyWe9S/e/Nut9wkmQA6CcHFs795lOuLlcCmKDSyyxgeCDUKnzCkT2MSVDPX47X9DZaMh6vhRGELTdXYGyDLqKJLI9p+EsNUCaVyd8FdPhHXhG3Y5DYLHPdnHGpUXvS8WwTJZftgwiKrFDIrg9WiAw9WdTilVY15dR+Ksj5lWhHmXHWvLnyUxIYqVJh00Q9YUuzeQVDoXw7G1hpIrIfWKI3g+THZb6oJLhjjuC886DrZGv3dqoEVL/Fx6VWzyCMrJ3rqIGWRPbUc6Wy0PH9uxGY0qYfdeh3SNRPLoEoIZofQYxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmnoRCNBSnGQBy+Ava+m8aUHdbVLf3i7aWo+useQJlY=;
 b=mQHz6y1soIdaxSaBbfs/ouJe3QzhJ06FVwEvkbEQ8/jUWWAQyPGGL7ZtCJXVwbXCuqCKzhxXDTrSkhY5sGDUc8konpD3L/UwsMIWqQtvWpq/EqdpjVufnaEZgV2cFNy9OyAXafrHsQO1i73OqFB89wwI64rGsR/ZmjkMnXgGzD1B3Cj6tWVkKjfk/qqkiVffhwe9Et+Kv4TNOlYPQ7Wu3bY/Tuhjxp6mWkKvSUffgrK//Zplth6p4Yz1UHMTJMX4N8t31AATL1DkjR/jbFpFu8GgfzZT8rFdoeJvXH0KBT41R8/Zk5TYjURtWzR890WxUaKd2xVGIPf0v0FxZvWvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmnoRCNBSnGQBy+Ava+m8aUHdbVLf3i7aWo+useQJlY=;
 b=cVgGM2uNbPozPLmS2PpPRu4M5tpGau8w78S6+rx2u0MUEX49wPBrFpw9JJemh45F8L6pGvuWKAqYhGfg1tVMpr10X5PKUIO67e1bJUpOM92sNYMwBgyI2L2fxO6BI3tjOUtA0wLdCguO3hHOw+SxXES55xDgpiW8B3ZJxuPJOEo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 17:02:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 17:02:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Chuck Lever <cel@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>
Subject: Re: [PATCH v3 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Topic: [PATCH v3 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Index: AQHZnsjFCga6eMZnP0KzBfMwLZKpuq+W+oSAgAGw0gA=
Date:   Fri, 23 Jun 2023 17:02:23 +0000
Message-ID: <F9569E5B-A89B-4683-9A51-CF9C53686358@oracle.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675125998.2279.7297073638926155456.stgit@manet.1015granger.net>
 <ZJRlATrJxBtpMb5L@nvidia.com>
In-Reply-To: <ZJRlATrJxBtpMb5L@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7501:EE_
x-ms-office365-filtering-correlation-id: 2b3cffb8-1b9a-4745-699e-08db740b9d75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1zXJmc3Sxrxs8TojNoKPL3OQWEEjkGQKrb/9sYPvdCJAGW/4FovaQqmJKbjVauog1cpWPeOwgn56fZ7YkWxeuK/x3urceXUit8KKR/3we09xnHUbFvUlL9meKRxuT2GZSAuyZbw2VGS8qCMLBNbh5G85LK2UXUGqF+4UWikP/Vnw5eS9SJKE1WaAqb1AleWfjb1bFTVVrxOe6LlLJ7IcoZ3I6DQMqVQi60KBrogSiTeL6A0Ps7MwVNxx7oyU+y5n6T9runN+NBRT8zKV8mMcv2GqBC8ya9FUkNbE7YzMA5qreu7r/aiirT1ggkggL8ky25S42d05QaE7OfnzyJN3/sCXmBPlHozjUevOBCpRsSesuFqYfazwNUHVFTD80LhT7AXbFSBqsOOGdIZHqcK7JLoNGpxWqnE/Hpk+uVJ1L5Ylagpu/jO1v2KzC7G1j5y4HKgwOzOZAUXKTcU1VKs8IhVY02kkt3zDkoQXx1Y9bWNVk23r320yGdg51Ww08r4J5I+wnwUu4r7xrAulAA4LYEn/J2PNY4sNEB+BnbQRubVTC+479D052MxIumIlaKZsQzClvrOMvfOAt/I6LldYNTZCdBJJknxyaJzhR5cMjhpXOtvSmAENbUFhtpiQHI65VWlcp14DCPo4Pd8BbDpOKYfH3U5F7f/KWlsNzWwD/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(2906002)(6486002)(26005)(71200400001)(83380400001)(38100700002)(122000001)(2616005)(6512007)(6506007)(53546011)(186003)(41300700001)(86362001)(54906003)(316002)(478600001)(38070700005)(76116006)(66946007)(66556008)(66476007)(66446008)(91956017)(64756008)(4326008)(6916009)(33656002)(36756003)(5660300002)(8676002)(8936002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GR9GsjRGbY//QSuECLjKY9PcJjdOiYaSjholHrl8UlH7SMrRg8k+u66VwJiZ?=
 =?us-ascii?Q?/Ax/8BPxhNwNcz8d9I7FeI66+nienpd5/B7pGfggcOc6ZiO/iH1hrII8Arbs?=
 =?us-ascii?Q?dL06NotHBgEoFAqgPNrOmtawii5TUdHx18J9I9LJpmsA9KnmwmbKWU7V9WuP?=
 =?us-ascii?Q?aZkirx8zpO1BbJoEi6yLMWuQmqm9VbgQHTyUg75+LYcuSmvE2iMtAxyWDkgk?=
 =?us-ascii?Q?UuP5q9VP3qrsF8EZZy69HYtY/BkrlLeI3Xudu3jN2Yr8C18QA2n+CJcywaAV?=
 =?us-ascii?Q?t369yo+o9CB6KpfRGJQB+6xL++x9I/vszU0+AnxEzf2biGoSMtreBJ7xLExq?=
 =?us-ascii?Q?SRUSlwPXPtfm42zIJyrXmQc1WFYpMMZ7zcdMtYguS9SNq05zVDAYlFhXsCBs?=
 =?us-ascii?Q?HlnLMcT8RC4KfCNPGN1wfRorOlUP/RrUwonhvZNmWmhX9hn6wTFE0cbwqyhX?=
 =?us-ascii?Q?nGmafjieKzBNxrpREZGgcu8pyTc1gGqgyyzYDXytZbY9BDd0GuvPTuv/9M/o?=
 =?us-ascii?Q?o6B+ApZfTqwtn9mPfaV5Fgpbt+bTe77nQY7PZMyiD7d7Dm2HFOHtTaXhu1Ot?=
 =?us-ascii?Q?TAdygqJFUuAmWR2N4CNrrjcAlr594wQZ8nlxxYNj/xA5CvC+iHF91wt/UY1c?=
 =?us-ascii?Q?afyAHsrCqfesJFDy+O7mp35eM4k5BbY5MIQgiteHVaHvNU86YcBvBkmMyNoz?=
 =?us-ascii?Q?vNIMUQnnXD2Klx9D1+Fi7MHpnz0rzREjZUiH025wKntMLBcsamAZBTWqq3BX?=
 =?us-ascii?Q?I0xS4ye8vxp9yAP7FMDESyaEP3+85L6S7ssB18yA/MBmvmobg0KFKIE5ZhuZ?=
 =?us-ascii?Q?GBSlSNT2Y3eDfLYRvGgisyX35OK3fmEhh9PsoTiaWWxYXGLd802OZtE9udpR?=
 =?us-ascii?Q?WkgXduXabEQFAbu8cyNUTju4Vm13lgtPWyjSsDSqgu9fcVy390M/x0Yu345p?=
 =?us-ascii?Q?u8c3RScUoVRdkHm+C4+H0VPcqCvuvMldnuw4WiyH8bDHW4uj+k2zy2PHGp40?=
 =?us-ascii?Q?J6CyW570QKPDVsNq/aCJSgsyUuNocMeo/XyySvnRfihAt3J814gR0Bhj8oam?=
 =?us-ascii?Q?Op5d68EhLKdR0I1DC4oWule7XDpvHLoUK79v+cnPtgxoTkRlkCX/PSOcWikh?=
 =?us-ascii?Q?IEzz1vYUKtsRlU8RFtQNbg2sxsgPj+7CNroOAM5bK1kWdPasHst9WT3KZnMw?=
 =?us-ascii?Q?VKbBIbyTwq8VaLxX4LbYPVJoOasrfuUDuEXzRA2NzcwXZQj0OR50zsUEzLym?=
 =?us-ascii?Q?pBpFLER7P/tGp7IUvbfYUk0ntumESg8hcDNXBmJ0T0p0049QGgCXkTpKz2Os?=
 =?us-ascii?Q?VmSsBDkly4mNx3PIhI5jf65Z49YtbZMJuJOAgNz+mLEvX18yIVHYyIp9j+yi?=
 =?us-ascii?Q?HlPgYDbmQ5DUA3kna3715BJOtLhrKzVnja+CW2q4fen/v9639Pe/apdbWtTu?=
 =?us-ascii?Q?E3mVdZj++9cPFMDqIg+eUkFWNbiFn6gRW7b3aElre8J5OaRp59l7A35DGOPD?=
 =?us-ascii?Q?qzwn3swtRs0YMYOIqbsUsPAkD1p6T/eZ+KLl3fTSIv4Qg3ZCk6epcqGl3BjE?=
 =?us-ascii?Q?lohJ6Zq11WNOk99HKUNOPsRGWOuWMzuev5ahkXzAy1QnA6atMtVi2TJGPgNM?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADDAD9AD6D64284DAA13C19A4B7EBFFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ELp6BCLgx1H2n1A42ArUB6zbMVTghwApaWQ6DH/s4xhUFi5VqPujWP13TdI961CjVNJqs9n8PfUPSxwCScsQGkTR6zO/J0sC5r/jvjbfAvi43SyufaiDBNXjpOas1lY4h3fdpFkSM+n4Syq+QZQgdo58RQxOkti14wOUx/8Ftg31oYO9bdkCRpluOnqERLpfQ9WD3I7Dz7f7awwzKOb9rZce7u/e1qv7fbq9gxncd18Rl1ssiCET0FdJ7C6Zz2O5smeetZniJtOKQEmovz0pG+id7FpbjE6Bqh7V4YmVGva8Z8j70fKT7W08N8swIHMRSJokHMxcsnbHhCwD7YlmVnla/2l+cTHvt0cVKKsyX/p7BOay5EXwvv/KuRwy8GeEL0EhTrV+bxvq560V5RYxOtOoe6GjxqruZPyN4w1+dFZtf8Nb6hucIqHJVhkxFt0qTlSo+phlYGFWVLkNazmxt6vvnnWbwvjg8BGZOjtHaSjmvjCHPnXhFsxEayOXlbx9CU/m69TrZJCFFweSoavsDFAYUBlRKNrFwwABezXqrUJh1a95eoGSP2RAXTSMV+DOx1jidMwSqhFT7VYg1UGWgNFwrOgjT6WveXC/iXYoPBnEFnQbAAT570M+n6QOS7gmRFHnv0kx/kN7t7WgANG/5DVev54FE+yKOfXQsq1XvtjUqyHwhxKrYLDTxSt6d4mgOF6vO0A5USF+lFpN51xoYmjB+vqk20rFRcrK0SuH5xvfqP253xqEiGLdSBxSm/7T1teaLTr0AysMYRyCFWvEHZXsIe1i9tjzjxTqN7V7+bkfiqstpLJ5GA57wg1z6RK0NuM9bVcRiMciuHXoGVJ0cEPnMVGGR+G7cU3SyECqcds5BBtzVufCZnthacM5UmOMctt8TSBQefgERHcg76Ys7w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3cffb8-1b9a-4745-699e-08db740b9d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 17:02:23.8086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGyeo2UwbDl9evcTbDSerMPVKiEGLsuJ7Kb5Lk15EjwWBOU3vIDV/aNM9fveW5C8Cd6MBOlOws4lnW4Relyf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_09,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230152
X-Proofpoint-GUID: dHUL01ymCfdNqZZNAsXVPa7aBJ7x7wC4
X-Proofpoint-ORIG-GUID: dHUL01ymCfdNqZZNAsXVPa7aBJ7x7wC4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 22, 2023, at 11:13 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Wed, Jun 14, 2023 at 10:00:59AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> We would like to enable the use of siw on top of a VPN that is
>> constructed and managed via a tun device. That hasn't worked up
>> until now because ARPHRD_NONE devices (such as tun devices) have
>> no GID for the RDMA/core to look up.
>>=20
>> But it turns out that the egress device has already been picked for
>> us -- no GID is necessary. addr_handler() just has to do the right
>> thing with it.
>>=20
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/cma.c |   13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>=20
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma=
.c
>> index a1756ed1faa1..50b8da2c4720 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -700,6 +700,19 @@ cma_validate_port(struct ib_device *device, u32 por=
t,
>> if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
>> goto out;
>>=20
>> + if (rdma_protocol_iwarp(device, port)) {
>> + sgid_attr =3D rdma_get_gid_attr(device, port, 0);
>> + if (IS_ERR(sgid_attr))
>> + goto out;
>> +
>> + /* XXX: I don't think this is RCU-safe, but does it need to be? */
>=20
> Maybe for subtle reasons related to iwarp it is safe, but it should
> make a lockdep splat since you are not holding rcu?
>=20
> Remove the comment and do a rcu_lock/unlock around this and the deref

Done, v4 posted.

The reason I was unsure:

  CC      drivers/infiniband/core/roce_gid_mgmt.o
  CHECK   /home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23: w=
arning: incorrect type in assignment (different address spaces)
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23:  =
  expected struct net_device [noderef] __rcu *[addressable] ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:292:23:  =
  got struct net_device *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48: w=
arning: incorrect type in initializer (different address spaces)
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48:  =
  expected struct net_device [noderef] __rcu *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:386:48:  =
  got struct net_device *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48: w=
arning: incorrect type in argument 2 (different address spaces)
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48:  =
  expected void *filter_cookie
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:811:48:  =
  got struct net_device [noderef] __rcu *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31: w=
arning: incorrect type in argument 1 (different address spaces)
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31:  =
  expected struct net_device *dev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:814:31:  =
  got struct net_device [noderef] __rcu *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31: w=
arning: incorrect type in assignment (different address spaces)
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31:  =
  expected struct net_device [noderef] __rcu *ndev
/home/cel/src/linux/linux/drivers/infiniband/core/roce_gid_mgmt.c:851:31:  =
  got struct net_device *ndev


--
Chuck Lever



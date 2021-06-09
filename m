Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F061E3A1776
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhFIOj1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 10:39:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbhFIOjY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 10:39:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 159EYUJ2005894;
        Wed, 9 Jun 2021 14:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fmf3C5N8xsKp8YC1B2PpBNK8I/Riz47mSqzHAWFCTq4=;
 b=F0DWs3XWNHAImPUSodu+9ZW0NcK4xH2qpoOl7FS1/8r7dYyDyvHppQ9ld1wdYSdMe/Pq
 1KO671K3OYw2zuBUAzV4nyG5Yts0B+f1seERAc/SUNht3LT0i71cFngjda+SI3TU8bnj
 fqaTQ/Du2nJZga0lPShiek4VJlkxCHMUreLavmBmw67SXyc5YKaXS5s1csQup00vPLSl
 cEquCoKzNyudud2K1KXLenc1qQRqZn5oK1kLsdCCwACOIM8xnko1huIkVvO3U4/5urXp
 scVd+N/klqpq8l9KC+jQYC+ZeE6MzjhP9ugfqxngt+HwCyEH99yvKWDrjfvAI52WopAG FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900ps9aue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 14:37:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 159Eb9cn021849;
        Wed, 9 Jun 2021 14:37:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 38yyabskkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 14:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKsQnpDSk0960OLhbZIDy5+ISc0etDAbHKZPshnRaWg4Jm/FtPwlpMqkMvJs1gjgPASDDPXmu0wZLKvrL8OIsupUMnYt+VXQibQEm1FIEtfa0SNqX0GLDSu1inqkg34Ug31xbC50+jzCq4sR5Gx8aqfvVVzjagFhQRkDmalMhOpkr2AoPdf+BJQ/UnDv1gAkxmtT4MEwP2cdhU4ETZIso964PKwPltuquweyU7zWRwcUSS/x/BrcfWP/YuEoLmBAJ9BFwlsBNAJnoNpCEZpvur19gfvku8PmMCnFHeqBx2nIWj9oasVsmEdR8V8ZKzsX2CC3g8RRp9v/f7tvdX/CJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmf3C5N8xsKp8YC1B2PpBNK8I/Riz47mSqzHAWFCTq4=;
 b=PzjFpEBcgrnpaYiEnDyWvb9uT2VUVMYAtrgKgJII+UTAAVhhMv3+uwizduCRovcYBTp5bHD1+yffjq3Bz/fQhEO61p5RXlPQJuJhk4N38qNSLUZxMfDsDfQldjtdlL5fZ0BoyycFKmB+hHR+qY+Wn1YZ8V9qZlbFgeNDQYqDXSpoaEqmKlqTeX98OkdKP2BvInQ9TGFJXHwFGC42q+05WTPzsTtxirtbxHCfP/8teS+SBgUrvJ3Zut1/zw5PlxFMQ/dNM9wfTOGjTFu3dxKdXCEVlj351p8bCgiHD83mlivZK1c8Vo7HT937s3uqLw0OCzqKMgDSY3o2OdK5yAedwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmf3C5N8xsKp8YC1B2PpBNK8I/Riz47mSqzHAWFCTq4=;
 b=lc9mYgV/x97naDjdDjxsC6e72U2K4xhK2FQ6F3R3ccsm6lgHX4NynjRwpKKVBL7RbCwHtKrPu5gwi+iHM8o+Lc5QOyvrdBxnMmkyB8o8PVLoIZyJpk/jBb5TaelvK1UtmZ/vgK5ket+K56x3rxQvPawvarWEAHuPKs87DC/z87s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 14:37:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 14:37:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Topic: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Index: AQHXXR9SJXcVofQXUEeZTSw8Z06ns6sLomuAgAAVzoCAAAdegA==
Date:   Wed, 9 Jun 2021 14:37:06 +0000
Message-ID: <ACCBE9AD-9A59-4300-A872-69EDBB4D4203@oracle.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
 <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
In-Reply-To: <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a504db18-3e2f-4f45-f9df-08d92b540e6a
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB46878FA404760F0E3FA8AE1293369@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+owLm+7h16RdQdHLkn6My4nlYtal/S3rXKoikSPfNOtYdgRkHvFW4FE6tO/HD9wC80suQgB1tM8bpay3sw9U0q7JjxAdt772T3oATdbl6nFo+24mgvLFgs1Lu3FR02+VzpKxyilOOnLVNW2bTLQDq+0NOoiEeVa2+bW30yQXWtflon1cG5a4wjTU4TqHVgs3YpDVcAWn1TuEZ7svWdODR/glANzMTuvM0Agb17sFxbEipy8k43hOaNbHlvp94Z3Yr9s78RxUCXexs27oHLHKcqUJd/CDmKGB/SWBJz1k/wSJcBuWwZD86bgild5Ly3npRIoiLuTZeeImyON6Kfuh0NxJn7VlxW63HjQ+eqif9XI/roAL7x77GEH2hhW28nPQhuj2G20TVS2X7SamNrmuEzP0G93PJ+6mBViahZiJ1PbWDIVQGC6a45xDNM9rAtYLQ2LmTFDbgOFuDclDq854vK/ihiL4G2nJXs8CbyWWsZhwHxjmJp/kJXO5n22qN3mGqfT3ZDirkY/nih9OGZvKqzSCvzSgfDZTBu/5m2amBtobZh6kaWQJMHJO2HOXHocv9yMkgsYitsV+64wG4QtlVTH+XQ3uuGKS2RWsiJ170K7J2j7sLFlUTVZG+zpeRTpZGQ5GS80XHRPK4e8/lOm3znf/wpson+MyX0I1nhLVnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(186003)(2616005)(8676002)(6506007)(76116006)(91956017)(53546011)(316002)(6512007)(2906002)(8936002)(54906003)(4326008)(64756008)(122000001)(66556008)(66476007)(66446008)(36756003)(66946007)(5660300002)(86362001)(558084003)(478600001)(71200400001)(33656002)(7416002)(6486002)(38100700002)(6916009)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a17VOwkbfnTep01PJFdZiz898nSFLZ27QTnFYB6MD28ixtZ98jmVzGHa/x4b?=
 =?us-ascii?Q?ZOEgeXA6nyAR3Oh0L79neHNtjuhLavLE0AXHREee6Fz3faNVt6H310EccLNe?=
 =?us-ascii?Q?Kxz+9+0I++1EfjHg+c/Kq75yfzTQDc7oDOhnG+4tsUFaf4vG8ph+dOaOMQXn?=
 =?us-ascii?Q?U5VKCm3rXuemw7lQOqz+sSnl/AraGO6Vy94lNluY3TUzReSfuv1kqkSdBk4p?=
 =?us-ascii?Q?QUDbDi22CrNb7n8ja/lZyrlqk6z8OHmaeXgsv7JfqzkxJVwvPk3dvi3UtfbX?=
 =?us-ascii?Q?o5XpGLu5wEsbzytkPAhUZnQnTyXMu5EssdsgjTFJMYceyFsc5VlOYvzgCZVo?=
 =?us-ascii?Q?YOwABfCizFi9XRsgg7hQQcDQapqsUpfzU6d47KUGpmGjkEUcRLWPYiFLo5Z1?=
 =?us-ascii?Q?NhK8eN8l5tZzPLrxxufimZr4d+xUln0eYtZ1Ea62lxphrnNdhGz7epG9E+mI?=
 =?us-ascii?Q?CiHBZJH09otc6pGAMcTNuGp9IfFm71TD5uwPwrDMnEWJ9c9/evjAR547oXek?=
 =?us-ascii?Q?n2J9J/Cll77ir1/0yNUfOzP0feLB95BUjA5SmGgbf2O2ZJOX6qD0QEKLHZJ3?=
 =?us-ascii?Q?q2Ht4TQC7ccqwp4+brJAIoM6gz9tf85Sjh1RqruKRn1hsyhJRZOCNzGlRrz8?=
 =?us-ascii?Q?i2huDH4sdBVpxn/U1L6qk3dXHJQ1qTA8ZA7C/a74vuAYRIsHGGE8N2bCeyA6?=
 =?us-ascii?Q?wTIWWba3bCsCF4XZPS/AwJqbeI80rrG+Cd/Aa/pep+ej3C7ofIk0AX/TCB0J?=
 =?us-ascii?Q?2JCwJKZjrPdE1XANq9s2qVh9s9Hz0O5sg2dsR/0y1l9sjZ30+3tkJ07HT39o?=
 =?us-ascii?Q?jYQlEpm+wyJm2rx05bHJwwW5JFhf91sO4bgskaPgIYfs9v+eJvBLYUvHf/cw?=
 =?us-ascii?Q?9GsG8yKmKYo0ztJYRaL50L8BzjrPYB7NEeW07QZ13XAhakBqbINDIz5mmxBj?=
 =?us-ascii?Q?+14OMd///Ec1qG22LuRmaCuEwpXCJHhHOy0iKQ5/F63uTcwvy0Xtieqbrh+6?=
 =?us-ascii?Q?S+dV8POz5oIB90aHqpql+Y1CqsHgellakZ36cd9t1KuV2Oe0BUJmZqe2YSHy?=
 =?us-ascii?Q?lPRvPCE2vk2lOzXJwupe8Wh+/RMG5FtjEWDTKUntzvxNiwkp57gfaugCKN16?=
 =?us-ascii?Q?TXxBRYnoB0TClJgT3ao598eyC0z+hwbRgq+l7dFuiYfsCghIKA028+3/zmPV?=
 =?us-ascii?Q?FGrExgMXBm206OBJsTgyq64wnkmanx4/mkqsxr1elTBajN8eTB1Q7Upt5Rlk?=
 =?us-ascii?Q?vMtByqv09xq9ISqeSx5+Q3zVyelprUk8Io81x+4tcGK67P8Xx21afsY3o08e?=
 =?us-ascii?Q?AlLJHW9NRFeXtksRg6nG+OKt?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FCB10B3B44D334887691E0CF408AA64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a504db18-3e2f-4f45-f9df-08d92b540e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 14:37:06.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfBghhaj/tmbVkVSfaD0FoDIPtsUztFFGy4TjL/HMlo8tFrqLZK/ZMT72T7/Ys1mdtFR+Ne7qu2v+3orDWDs6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=902 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090072
X-Proofpoint-GUID: LB-eqinsjBtHp_ygL1dCeUeDwuVev5Yx
X-Proofpoint-ORIG-GUID: LB-eqinsjBtHp_ygL1dCeUeDwuVev5Yx
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi David-

> On Jun 9, 2021, at 10:10 AM, David Laight <David.Laight@ACULAB.COM> wrote=
:
>=20
> And I still don't know what a ULP is.

Upper Layer Protocol.

That's a generic term for an RDMA verbs consumer, like NVMe or
RPC-over-RDMA.


--
Chuck Lever




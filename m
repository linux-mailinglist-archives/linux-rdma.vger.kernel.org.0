Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58588744A8C
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jul 2023 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGAQ1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Jul 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAQ1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Jul 2023 12:27:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35B135
        for <linux-rdma@vger.kernel.org>; Sat,  1 Jul 2023 09:27:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3619oK2O030234;
        Sat, 1 Jul 2023 16:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KfW5g+cFd9NkgzEMyqgMKLkAWZHroZjuz6M3If8ojLI=;
 b=FJJEQ19MG8efL2CijeK7Bhc6RKAL6KzsI4OWOX9aLdBSx6ii6zX2lmuJO4JyKEL7nrus
 QPCpj6RW90FF+JAbo47mVkkbx5ItWH0/CFcR9X32e1LQgMIVUdw43TqYPyO0jscEvRRF
 qVn6+IyZSITR1altW4JocQmpqj7KfQGexA2JQYUMwxTCgLu2mp5Pp5G3gmireWzXtggE
 Zy/0kqqpS354tGXf7k37Jn+CUEy4pBRZa75Yu1c6TFx5Wvw9ir6zULIunX1zA7Ha7orZ
 /aFM3c5tBVLXIIcMKvoY9Z7Um4F37lJM9G+hbs443kP97wWm/tvmv8S8ogB0BH1o//0i 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpu8h52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Jul 2023 16:27:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 361Em6NI040257;
        Sat, 1 Jul 2023 16:27:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7a8pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Jul 2023 16:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIF92VctIoBGb0yURbnIeRDPbLKojfBUSKkI8UsP1mCUs8EQylVf+M1Mo5LNP2B/6yKC/n+hBnM0sJA6Xovg37JSYUd5p9tFze7FYE/fP2EkevTcLukHuFBtyXr/gbDwNrjJJ1S8kfOqG3xPrzM+BCw3VPgQ8ZJV8B50G/sMRGlDNgJMBNdC4BJ7F+zGHSZKm9tfm3EOD3ypmLv372YCvfUXNHe4Ook30YMGmPfQhU4NPpjcryNQeCpqlaEN1EOrlRJdrRQ5i+ETpe9Zisw7ElRnEhLGm29cpAOF5+MbP8aE2VBp/BAMGJLdjwXBqyejCaWRJ/BiorD6gf8XXYH09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfW5g+cFd9NkgzEMyqgMKLkAWZHroZjuz6M3If8ojLI=;
 b=bwpSD4izI+eqjDh1e8zhxlT2k4x2nBzF3bEsM5cdrzEKq/pouR96NGUOpc0onYA5RxcMFBhkXVFbtxCW2wKLjWinxvlo7CHcqY1jNF7c1AxXuUK2c+vRQVYAo4R2nSOVTVGpwOSN1Oh4tDD2nhZZFQjTFu2j9vVMsUVgcLZJbVLxV8b79Un+OUtuchbgdeAdV3syLlYvM7jeERqM2TRbU8ssZvVCrk4Z9oO8zRx6XefWjkzIFwVNfFaoAFrTQUDr/Z5254z8KdMrmt60l2dQ+DwGHgNLvsW+QCXXGUqFU4VxZTm+Ri/2ZvwmHD+Y+/hSf15M+qwREkPw76hioOBmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfW5g+cFd9NkgzEMyqgMKLkAWZHroZjuz6M3If8ojLI=;
 b=yeJCWczEPbbjEJxh9BV1BkCGR8nmEw6orlYutQ5BCRogsZhaToxFROfAMdXZRVGZRH1SeB+OjF8ZOJBQqXJcDdN579i2Bwoj9dKkPHe7fuDHQxcMeIPFgcrTxKFRLTw7RzHhQe65WHham4ymza1bkzvce926I7JdDQiM08hO2WU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 16:27:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 16:27:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Topic: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Thread-Index: AQHZqpy/MPzrGTHOK0uAvlJLASL21K+lG7GAgAAA3AA=
Date:   Sat, 1 Jul 2023 16:27:23 +0000
Message-ID: <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
In-Reply-To: <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4519:EE_
x-ms-office365-filtering-correlation-id: 171a7991-dbc8-44ea-8a15-08db7a500cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrCztSI7WH+UU5hys/gflYEFdcLbDiasW2usqVprgqNi4rmZ4pAocpna/43QyrkUjuxmzcW/lvFuEgl6wR8hW+xwrLVGFQXO65TRf4qwmTitdpOIZeGp3pT7BeRyQyOnYznZpDbmFO7dchX/uznC5acu1pz98YO+ETBcYW1P0NfQFO1G14/Y8mwPdOWsUoAZRj88OAzgCkV23e0rnLmTL1hFsJpWwQbCnsQh/gziTGWF99qj3mpZGne1Qn5fBS9it0Fq7XvtASAt5baPD/gn8RMIo8RX9TeT+o0gU0iXoDNry/kXGxe17aYfD41d7/CpTJz9Jj5dGxeydkaOthTZVZHr4rj+0hGuTNOXfHIc7k7vnrnDybeSS4gj2kfGhPGV+4xsZBVpYtMEZJVprcDh01FWKiLrTT7/GxR5PDzkBTJ51MY6md3x6uFIappw3pIq9gpueI5ZjsicGmDgcSj2p6kyp8nyWe4i+jLpGX4UZa0Uv615JTMvdRfNspaCfmhS4a15klPNzFxgVnWGr6w4erdy+XOh/GunjQ8L5nd3MVY8vLyQH/bAtd4Y83Zv0Ow2kh2N8EP0ga/eKTPKs7AyRunNobgex5CSWrBRUkX+06uhNAjc1CVrQ2eoSLbgFcBMi0RZZJdFSpSCRSlZbOPwWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(66446008)(76116006)(64756008)(91956017)(4326008)(2906002)(316002)(41300700001)(54906003)(110136005)(478600001)(71200400001)(6486002)(53546011)(36756003)(2616005)(83380400001)(33656002)(186003)(26005)(6512007)(6506007)(122000001)(38100700002)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?goAg5dpxELJ2vk7oeCb5pNCPKtHLIbGu+JZAVpcG+fto9lC6WXD1L2bIV47D?=
 =?us-ascii?Q?cNth68g7eX455jOqrH7FTrnBNwRtq6rNP4foU/tP4u3MH9Em8n+vfDKoO07s?=
 =?us-ascii?Q?f/RUYGaPNfDRvUi6Vkoi52iSX0zTOJGG2EhLJy0tA7IOEkKSpeidrd4eYs4S?=
 =?us-ascii?Q?J9+2qTtwW5gmqBirE/r1rSfTA3s4KnQlVmHYprQs0/Vn7FrrIKnuwO2jaDej?=
 =?us-ascii?Q?Td0eL0ZkGZCv/A7S+LCv4WwGevlTc3tgPbi14/3tlMwey9f03U8Xi6AB/PBS?=
 =?us-ascii?Q?GtQe0Gs8rf50wAeVq382POclingOeShzc8rTNwEkj6cZClh34wwensItq2Is?=
 =?us-ascii?Q?/osAiTWZ/e6YdKnThD0hjXGP1gd7MJNL4PJ0WIIqwSpdSaOgSAnKRMnmgJVm?=
 =?us-ascii?Q?Vgwz3Q77Q1X6q0UIUVHVugFW7BOVNOSGOG5vK7LVu+FgevyK6OftaoS+YEmO?=
 =?us-ascii?Q?l4zhRufQTybHktu3VHdF88U1hb9quobuFcZjSR9aRYuWRRdffRaCmaAA9dB2?=
 =?us-ascii?Q?ZIu3CM9yUPops5C2iKqTm6EaB6WgJMZFmHSSlWhEigNOTsL0o5zPb/HFREyS?=
 =?us-ascii?Q?8kJhakjiCRsTq7zR8VuTgqdFDnI/oYr6/XqP9nTqm+yV3uDRfjAZAZ8tt031?=
 =?us-ascii?Q?YbGxZH/tbz8u82fBYYwmMcZkTMwDvZYSFufbLHlB1ZJuUueseZulDMfkQINP?=
 =?us-ascii?Q?6qlPtSduKrrWz6Jy1sm/zFeKcTay/EpwXMWmTgaoS++uAC7QT0x5H9NGuivu?=
 =?us-ascii?Q?RviSamliwzbry5Yv/Q0NpI1MVq/OKclp0UXPCP04zcV0MCvQVFR6qbdxnNFe?=
 =?us-ascii?Q?jo38rHHnx9aOllHelS12NRtnpeM+8sNmDRM0YYrZF6K3fWqjppSMXt/atY2n?=
 =?us-ascii?Q?Ob/QtLtrw/WQZUYsGDb1DSi+sVdAJ/tyF/54HPReOhJ0gdvHOX7spsxrVIiZ?=
 =?us-ascii?Q?ykPOByIkKscXKOJeYlCVnZNqyhWhI9UguEq1WMbAKZN3489IxkSnW9PlUkZi?=
 =?us-ascii?Q?mAZcWy6ZQk9epNYbSO8pBktnf1OntqfXSyLwMRT/SMoIdLWRNRBkRj1fmLWK?=
 =?us-ascii?Q?w0Wt5oMZLOgESS7QjclJ5CtA9YJiP/y9l4lQDsC/ZjbwMjICSqUU4cdaZ+eB?=
 =?us-ascii?Q?sb0dlE2JidfoYjbCwKHH7+ZeswntG2eN3AcCMEU+vFg/FYhF6viKTL8pHeyd?=
 =?us-ascii?Q?YenMk6HObbEOmtp9NtRcEYoqb3qKIGIEcytB9B9IozkTe8OwopzigjEctrE4?=
 =?us-ascii?Q?lRGE0WFVsH8ZBUqg+jbty6tyJ9uGrtFa/diMWFXtEVoHuLt3iYjBL5/TJKjS?=
 =?us-ascii?Q?DKhtfJVKZyOLXiQyopBeSeiIAxWeuZUg2U2lFDKnTlCxzask6//EEkmUfx6e?=
 =?us-ascii?Q?B3iXagAWZYmhn8bJtWQgGJdhbXi+b7+AsuZv1z0J+XLjYYIt4IiwDq7vUBB+?=
 =?us-ascii?Q?T20Icp8vGjmcxH4r7z2tWpboZILAEDPE9D+IQL46/2DY0nZmlg0h1KzQpVDB?=
 =?us-ascii?Q?RPD/XEvuMjSuTivO0Xq1bCvpZxdwYYPUL1JmvRnSOAJMyY/Yei6hzWaDp+uG?=
 =?us-ascii?Q?0h6TMa/55XyABUoEAFj8eWqJxSDYdcvzwmYL2Gm7p9nMxEHs5/D30NhhiNZW?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B50CD10340300546901DB0E1CC1DF1C3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rCssVEVSYPy7FcGPX8DYYGrmfreKNhPRh3VKA7tnYBTXz/7YxiwGc2fxL24iq1OYedsAyVzZHE2f90sgZ/MCW5dvCoO1mNNoZoU5F3bQ9+EcvBkNam3DG9bqLeANJZdp+3pGfGhiRUbncI71YXr2ZJmRIUF0oArpbRugi+/VRKRVIUw+FEd4qtAztI0//ZjFLIvtV7o8mwiBE2qXOftzq8jcQDs80u1NZKsacXSi0BobU/yE77KNkWvuWccXW3CnUqKFe1njXPQhYdVTnZx5rmARdhQfKlH6+S7w+JrS+m84xgjU05wTGXASR5KhU5oTXXQ6bAz6fJrn0mMovEJ9zWAkoiHkUmnMkT4VQuBOiBqevUPObWU+RK2+qOqUuKAfMetKSuDNcI0+jhWIMDIGHIgiSHM3EY1uuR6OJDl/VwACSvJswHp5tphRrGmfNtJKh28csQmMScoX2JwpTuSywNvusiJXjlWkycfFAemRcGjVZXwPiqoVmdZ+YyC6wkaH+2FdXzyAzF8OXfp4e77t4s/oMgpRrBKq/QFr3dkDS1xljZMTKVaWQ+NFyPkmuF8ag4hOwoeUo6pHavtboPuGRmb45Ek4sKqOkm0husk6bcJAAknfJ0fs+lMlxlMo6sLAqgTugjpLg43FlKR6rglwkwMhbwhAknJM3v09l/bTmCkfJQxziQSqIjljflaA30vZFcaiyQBSXVlN0phk4ke+tjUz07SMzwMzGSV4JHHq65THGI2TPo8OywZKrf3lZMqCBA0j4u4cBOVGiofIzflfyiLkfDAiDCBGc+Rv12Yr1HIAi4FitDI7fyiYLv6kMVuKcvjqOHe79AnzciDnZSarWGNo7FgfH56N8OTdbwyKHVofEwrltJ5UzQSE7or0O4tueOkbjuoIx+ooNW9xxvpxLM6pVchj++dMKbrJ/p5n53k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a7991-dbc8-44ea-8a15-08db7a500cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2023 16:27:23.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSQol569dYiAjypk48t7lvYHwXrPQ69lfQM9RNKHo2v8WmQvoPObdLQPsz71z+K4vrIozMZwhUJMqbs20eEDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307010157
X-Proofpoint-ORIG-GUID: TDrFZUVDISqmtHPOD0EurQVj6iOLj6O9
X-Proofpoint-GUID: TDrFZUVDISqmtHPOD0EurQVj6iOLj6O9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/29/2023 11:16 AM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> We would like to enable the use of siw on top of a VPN that is
>> constructed and managed via a tun device. That hasn't worked up
>> until now because ARPHRD_NONE devices (such as tun devices) have
>> no GID for the RDMA/core to look up.
>> But it turns out that the egress device has already been picked for
>> us -- no GID is necessary. addr_handler() just has to do the right
>> thing with it.
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  drivers/infiniband/core/cma.c |   15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma=
.c
>> index 889b3e4ea980..07bb5ac4019d 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 por=
t,
>>   if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port=
))
>>   goto out;
>>  + /* Linux iWARP devices have but one port */
>=20
> I don't believe this comment is correct, or necessary. In-tree drivers
> exist for several multi-port iWARP devices, and the port bnumber passed
> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?

Then I must have misunderstood what Jason said about the reason
for the rdma_protocol_iwarp() check. He said that we are able to
do this kind of GID lookup because iWARP devices have only a
single port.

Jason?


> The code looks correct otherwise...
>=20
> Tom.
>=20
>> + if (rdma_protocol_iwarp(device, port)) {
>> + sgid_attr =3D rdma_get_gid_attr(device, port, 0);
>> + if (IS_ERR(sgid_attr))
>> + goto out;
>> +
>> + rcu_read_lock();
>> + ndev =3D rcu_dereference(sgid_attr->ndev);
>> + if (!net_eq(dev_net(ndev), dev_addr->net) ||
>> +     ndev->ifindex !=3D bound_if_index)
>> + sgid_attr =3D ERR_PTR(-ENODEV);
>> + rcu_read_unlock();
>> + goto out;
>> + }
>> +
>>   if (dev_type =3D=3D ARPHRD_ETHER && rdma_protocol_roce(device, port)) =
{
>>   ndev =3D dev_get_by_index(dev_addr->net, bound_if_index);
>>   if (!ndev)


--
Chuck Lever



Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D372C8E3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjFLOpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjFLOpk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 10:45:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4CA8
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 07:45:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CET6jR010520;
        Mon, 12 Jun 2023 14:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Uy0Lb0XW5eEmDXaolheFQ6vppwYNiRCHSsLi67s0m98=;
 b=jEeo7O10Y5oA8eJ3O2/o8qGROLfKm/BVCkN40ubrY+lRhhbYjFOlu2MkQNUc2c9CXblI
 icW2UnsdzHyZjjy651uMKUDFBIVX6q3Z4fi4GraZLbcQgC6ly/1fbzfdFt+PrpV4zDP2
 lKOzWY2/981u1f46+bczg7jFNkr/N3BpGMbw9Mpm1vbtkUjVcWIwThYUhLw9gX9/5Bm7
 XhquLPach1PlSMO9D3MJem54F4h3+Zb8y2iHRiygIPtYy/XoGnPoBaVk3heGdhcm6ltI
 ye+9hPoh3DJmhDoqxuGMUMfbJQaeY6LDj1UFu6KaQ3OUsPM1Ft8pqB43F+QVWjt/dTjJ nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1u65n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 14:45:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CEdZ4D021725;
        Mon, 12 Jun 2023 14:45:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm2vdf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 14:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQExkLde4TcaUOPhzu5UMtuRASrjeKj3VFQo0U8hGi/ZQqqf2A+wazZv8cJxIFQwR07emPU/ipcv82F7ZoEalTDVTxHaV2+X65ZZfKaAIAEoY3bjBqlWcV9+hDKsnmyxmMBRsWduKM445jVh1MsKHDkHYjQpTU1wpHBaSlKKnmBNxS7zdSu1NW7s5WXOH2p08vJmLJ7f1eD9hS+hzIvviDHJbCuZ6JMhWcl+i9RGAlwEK3F8mGc+ABerU2RLfkyElkopE1umeKNFr89thRnoKQ4tGaIcStr8ygRTLRL0YeJjBDbO5e00Xq60CnGqIu7G/orPvBpYP5IQGwpdRWDQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy0Lb0XW5eEmDXaolheFQ6vppwYNiRCHSsLi67s0m98=;
 b=acAd+z3ydaI2ZlYUIj41h0DYi4RnA/yfNfldfq6yucyfY/XIn4eUWrPWejblduI9vESPG+uAIKjQCwxH7QBWGyaOWbO40zqMtNyJ+YLygOlvGTjzGekmwzv7+zWcAclFd+c4Jl2lwe+pMeweC+FmMMf/0CU0AGiCw0tzK+dEX4aRcS+bPMvk2mvEdZyy2mqRVS0iPDnkaVa6PURxuUAwC64uaCcoIYUuNiBwvWDfBs+4D9IU7zm3z3k6JAOaiinQ4Lm0a7h5E7GjEUXHYe3H7oFyu6QZrZwTmJ/2nfE3v1Dn7tXIuBCcoM/M/MTDUyRTif7QpYTc2FZ4mb33YAxaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy0Lb0XW5eEmDXaolheFQ6vppwYNiRCHSsLi67s0m98=;
 b=nB6WJFBpbJ3qTqHGiOBzRi6MXLvFDMjfuJqkfQkqV0LeVcJr5eEwWWICLv4zlz4/1mqITKsc2Qq3OhLaqXXFmrS5O79kJ56wpa4bLhV8XhLtjel2cOHii3CffxnZd6p2joUNJN1nHy6GH17qGl02s2gj6wxmgH3H0C9Gky0JcU4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4842.namprd10.prod.outlook.com (2603:10b6:610:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 14:45:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 14:45:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Chuck Lever <cel@kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: Handle ARPHRD_NONE devices for iWARP
Thread-Topic: [PATCH v2] RDMA/cma: Handle ARPHRD_NONE devices for iWARP
Thread-Index: AQHZmkSsFPTwNkkmw0i35uqtBy85eK+HQxyAgAABXwA=
Date:   Mon, 12 Jun 2023 14:45:31 +0000
Message-ID: <187728AC-D878-41C6-8112-244F7B00377F@oracle.com>
References: <168625464167.6526.1226449785871036437.stgit@oracle-102.nfsv4bat.org>
 <ZIcuWT/Ap0YnbsX1@nvidia.com>
In-Reply-To: <ZIcuWT/Ap0YnbsX1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4842:EE_
x-ms-office365-filtering-correlation-id: 593cad8c-eaf5-4cc1-e231-08db6b53abbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyttoIdPiBvyjZmf8tBiERA4zSWrDpbgB3Zmd6Ndmunzw9sBdPYwFefy+sBOvGwYW0qNf7H5Ib2CJXH0ErGPwYs76ze2qlRt+bradeix6sMFUfJ6P23MiP3xrlRMkkvW/i94f+g39E4R97GqnUn8H/mpHrVAWgsColWzs2WxzCuj3Jf0VUS5KzsVwk41/E5/4WQCnNdnLNUfx+lVwjy3WZNAeZ3hz+EpLkk6pELkXwUKELyGZfJ1XRSgEQnzcUCZN8v/b4Cr8eUUL157E6QYV4C2TNwOOOJPwcxijiA1ipkPRJDlnT2pDNziiu2T/3Pp0SSg8wkyggMzPSdCModLIQBc8h3CELWJFocXm/QhPNBxSDl9W4suYgmF/cGA0Jd7nhxS8M55c6/3YjprT/jXiaNrxMupbyOudTDYhrOtMoLESrVMJoFIho9rKgDwh6Yjx990oy3Eo6Nv61iiIrV8F/fSI5TUcEBl7bDBTLCPs1Em86nrjptPIsSazK6EujV5MONF4lyXJLSwUtF8OJ0eZr6lA84DYBuDT75pDN4s8zcGHponsc7OkfwoPHqjiFyeUOexWPyDB3cJkCmrMct8zwuhRaEBP+Tx5ZBP8f4SsPsrtDQa+pDL6a1ZZHKlHuiBy1GC63iZQStPSjg+WpDO3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(38070700005)(86362001)(122000001)(33656002)(6506007)(53546011)(6512007)(26005)(186003)(2906002)(54906003)(66446008)(6916009)(316002)(66556008)(4326008)(91956017)(64756008)(66476007)(76116006)(41300700001)(5660300002)(71200400001)(478600001)(66946007)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzN+Vnm1PlJ+0hfsFAjkZpbWp1fUQF5AOI3hrkaLOzhFqEDdL2HEBU/foJlD?=
 =?us-ascii?Q?HYJPRcqVk8BOs+9O5VrMRocKD3ELRmdDdEVgGAflPrwjOqtE8WHI6oBkJ3bj?=
 =?us-ascii?Q?vQSq9WbNRYprPxeiaqEiChrnwQmkWq5dzj7BEp40t2iQz8opXTBnbXYHfjKy?=
 =?us-ascii?Q?Gegcw1CNq8E9ll6z2AKgnSkM+RsSazDt0vgW/YX7QqjxzXWzhqffZZHwxw9n?=
 =?us-ascii?Q?8ee3g3crsvdvQdOP4Hp9tVpkLo0CYILjgGVucE1Cmok/Sr/AcRrlcsaVHnTO?=
 =?us-ascii?Q?YM39iGW3pWxFiAa5BDLfHCQSllwrzjn04QG5MR5PY0f7zyP9HX8OqxxhpoDC?=
 =?us-ascii?Q?neworZiH6sfykGlxfszDfY2IKgVxQQyM3zGh/IzpQJ6Q96cn2VcTLf9DQOkL?=
 =?us-ascii?Q?YHum6e0MoFoL9rJ/0c9WK0ckOU8X3dJih23aTG01Lm163HiJglXZolRCsLaC?=
 =?us-ascii?Q?3gAUbjoCeLyXt7E/4Lz1mhbcBVZfQe4A6cHngiO6YY4r/DTz2V2PKOYqs27A?=
 =?us-ascii?Q?zobctRlen11rTG0/vWZQKLVlaNmxIxCvuwXJIBlOGLMmw5E1Ryd9LU+avclt?=
 =?us-ascii?Q?WZB40655N72gxvJcyCQfBDfJqfDNgIqn8+ZxOjG5Ic/QxmIxcWUzscK8WcjD?=
 =?us-ascii?Q?xAo51/Cj20Dko71xDCkpYx4cthR+Hgw6PYrcflrnUGo20UOECGDUlLVTrpjf?=
 =?us-ascii?Q?X0izi+swC1JxZRucVSa//ggtRj2FaIPkHTyUIM/ltFQ7GodKlDMmdJo1k+Fc?=
 =?us-ascii?Q?o5Iz6pdWC0Os5ZC7KRNBU0W+dS6ZnFDkmxp8rERiAjD+bMTM0bqiNezhE1rk?=
 =?us-ascii?Q?o23sMEnNTTRJSkz1VNBgVkmYGbxQ+2NfiJ680yLYp+Mo16rzJ6V7FNvVCtrV?=
 =?us-ascii?Q?lwlJjNSEOmiSBT9clbs3yBxg2fAjENh0fO5lvm4okYij0zTxj5IpV2aYzQOG?=
 =?us-ascii?Q?4ttv1YYP2MnYwuXV3qIZMA+i2kFfBxWsf+sMIgveIUPnUppn5tKv0WcQPmT6?=
 =?us-ascii?Q?qleXoHmGXOecrSXJ+H58sfb6bxiN1Dfrtcj9Pg9MlkIyqi9kALhYQaohnAWE?=
 =?us-ascii?Q?/mvgvlFxlU2evOONQk1Bx5qa+wwr2+jwRskI8p7UfsSwc6OuLnjJMaarbpPd?=
 =?us-ascii?Q?dlS34V6YjrEcHygscLgMBIJWbjfShCG4x4TWvTKWc+czCy1AayZb7C+f1fJP?=
 =?us-ascii?Q?M22+FD4XPz27+YinDZBYDH3+BkJVEqMsKSf3VA7PSRh+hA7ir05S7BmOZElx?=
 =?us-ascii?Q?6kQFYWnbPNYQBHVxSyWETxMjnFI9mXFN7gYleeJx23alfBXCgCZh9Tm7uCkJ?=
 =?us-ascii?Q?8yvS+1w9qnG1hnv6dGMxoK59YYjFGQLX7UBgNiKv41ap7mr07YtT2dkCauCA?=
 =?us-ascii?Q?bL4mk6ebb/Wh4agKB2W0hRawNKv+UHFfJbcVsV+QkteuI+xUTXPzN6zCctic?=
 =?us-ascii?Q?zr8NpCany/s+sikP+U+I6z+sJ87cAj3l2ZysQdS+HzH+44yuz3zLP+8l4YE0?=
 =?us-ascii?Q?uAWRqZApDJ/OwxtHoXmgIaZU1RcaaJ89UMekVERAao1dco2zHLqaOsZLI8Ao?=
 =?us-ascii?Q?lPZ8ankbZqJm0/BkhMtMBZEgv7t8m0zi7DhyS1VN79On4cLUUg0dKLWckXWU?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA3D0C814DB3814EB6AC9DD506DEF937@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XyhMqH2vSUDsOIvd/TqA8bYxrdXNPD2/2x7JATJDWqdB0gvdmKh3O157KzQ5pcYnnqUFzIkVLYcGFuwfn+57X4GF8MfpT6x9KBCZ/9fZ18YUPo4/4khMuPKsTMfQR+8AG/70m2uXTSx/LqH5BPFCHQrZzlXUWeo6RII1TjMeGTSlTqRbUurzL+c2jQzi6L8+NjGCXXJqTjVkrtqwhZFfMZstwoh9QoPceG9122fTXsu47l6UXyQULqCyEiAXHEy4QWq9t8pZZQGb1OAdEh79XMEHGUcDHUfNP34oe9uxgSYPiQzp3K6IZTSkL3o+v88KSU/OJ56h1pIx3kGXEAF9SnAv6Pnm3fgpssVeyKBj1sqtjza8EiBTWu9EDEtwjBiVYoYE4WMgoYkZZUBm1hBnB6nDqXepublHEReqYkB8l1RJ/Dz15O8MpZmMrsWNWWJmvB5wWyXbtKzDIZ56y6aBwFAuRGm55zq8gEBc9nl87DweDguVyIqDNbM0Dt43agPVMm/K8owk60iRwPILXoFZwAKcxOME0B1mRZz9n0hf4d4wdb/0ruVY1x+Xs3nOcl/ieTlf4E8tMzyhQr1nphnSCO+C7yI+suJJy2KXNgkv4TwwjhD7dKNl2wHD/eeKosVZ1wPNfZ++iFPOhwHs/j4XAMLgSck2euXavZ+5m7jZDh0x2d0lyrT5FGGJK6RPLj8YmYNstq2Ff4qBIOuB+fbeYU1PtCAEIThyaxmHk/4omDB1EC4PV2ZcqaWUVkmluKxDiCq3h76ZKRBs4dKjVIudjq2BfayriF4xVWsXoLlSIQG58doKXxvf+2aaR92gnhJHrnUo0oFGCzIsdWCQgf6VKqFddvTPKKugbxiIppQlndJHgee1WvjxepeCATW5or6FHKWZP1b0+zjHawmdlBgkLQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593cad8c-eaf5-4cc1-e231-08db6b53abbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 14:45:31.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfXbdrJYbZIKFM2kHNR7FNMbtVU9UQnlX2ByHac7OxOD6RY/o9+bZp9pxARpl1a1h1Dtx5UAogJ8yaX4TNYMmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120126
X-Proofpoint-GUID: 0MwgKxjlYcM2YTMN4tEGOYykbzlkE1UT
X-Proofpoint-ORIG-GUID: 0MwgKxjlYcM2YTMN4tEGOYykbzlkE1UT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 12, 2023, at 10:40 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Thu, Jun 08, 2023 at 04:05:54PM -0400, Chuck Lever wrote:
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
>> drivers/infiniband/core/cma.c |   27 ++++++++++++++++++++++-----
>> 1 file changed, 22 insertions(+), 5 deletions(-)
>>=20
>> Further testing convinced me of the necessity of confirming that
>> the ndev and ib_device are properly related. This version works
>> on systems with multiple RDMA devices present.
>>=20
>>=20
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma=
.c
>> index 56e568fcd32b..44ef0539957a 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -686,30 +686,47 @@ cma_validate_port(struct ib_device *device, u32 po=
rt,
>>  struct rdma_id_private *id_priv)
>> {
>> struct rdma_dev_addr *dev_addr =3D &id_priv->id.route.addr.dev_addr;
>> + const struct ib_gid_attr *sgid_attr =3D ERR_PTR(-ENODEV);
>> int bound_if_index =3D dev_addr->bound_dev_if;
>> - const struct ib_gid_attr *sgid_attr;
>> int dev_type =3D dev_addr->dev_type;
>> struct net_device *ndev =3D NULL;
>>=20
>> if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>> - return ERR_PTR(-ENODEV);
>> + goto out;
>> +
>> + if (rdma_protocol_iwarp(device, port)) {
>> + struct ib_device *base_dev;
>> +
>> + ndev =3D dev_get_by_index(dev_addr->net, bound_if_index);
>> + if (!ndev)
>> + goto out;
>> + base_dev =3D ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
>> + if (base_dev)
>> + ib_device_put(base_dev);
>> + dev_put(ndev);
>> +
>> + if (device =3D=3D base_dev)
>> + sgid_attr =3D rdma_get_gid_attr(device, port, 0);
>> + goto out;
>> + }
>=20
> Oy, this is kind of ugly -

Yeah, not 100% elegant.


> did you look at having the iwarp side
> properly set the ndev in the sgid_attrs instead?

Interesting. I'll have a look.


> Then you can just check the sgid_attrs->ndev->'net && bound_if_indx' =3D=
=3D dev_addr


--
Chuck Lever



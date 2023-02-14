Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E76957D4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 05:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBNERQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 23:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBNERP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 23:17:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94AB1727
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 20:17:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMNswR001436;
        Tue, 14 Feb 2023 04:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TxejgTwWhKPiOBqt0RUt9RI28/dgISESh+wMiEp+bwc=;
 b=rcY1qppeEv3q2Jytvd5XLACsmVbO9UODLDsW7pd5zJScoS/7g2TULdmT7ZiplCxuWUUg
 G1sp16KRIVYubV4lvOo0RxJAj/TiKxB8jH7kNbIHSD6MA6PDtvSR1NJfKH5+M7nGtjud
 tPV5PhSa47//ncK9na9kljB6v2Q/OUfIUES9yP5r4kJO2TsuFWdqZlMtg7pqjl6Vcoks
 tkAoz1I3ss/vHY+OtedJ1cEvPFeQB1HEKUPzqLQzENnPQ2zZUAohs5xWbCWDj44uTZ7J
 JLXDU2uDG2O20nR1EZa3n0WKoZAKTUrCjn9tiJIYKv7k9bNJFwfH06vfopTJcaYZc2Z2 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9vdhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 04:17:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31E1nsD5032493;
        Tue, 14 Feb 2023 04:17:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f507v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 04:17:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9GX8xNV6mdXrBGSBZCSgvy7HWbDgTZPYjc81nr1ui7zdmfvjY6jhpFtt5zd9AnHinnAMA6yWG7OWP7mS7T/QMg/ZQH4+47+i358CmrjOlMEot2+vw5NOivsU3OaMN6QpVTKxy2FG+N0cYCjyA5b7/XjLn8CttvRSlvABhYAnhCKyuO9sKPlrA+5bo+FM6eSLsPG1RiIgzclgdPlDgfRtqJdWtB6nVcM1W7FxH4wUgPj+TyxiJ/eYHX2EfUMIk98RBHBBvZubyPwuFNQtV7V2qmWiyExdhKzo8Bvhpmzdmrye2sd1aoXPflvdyrPXZW/wCStmZbtnB9bL/7NAfcR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxejgTwWhKPiOBqt0RUt9RI28/dgISESh+wMiEp+bwc=;
 b=NupC0SMu7Ns/K2JHGXO3c7NzjBJGmRRn3qv9H+xPCejjXHj/iG7rqz42HFi/KeyXb1gWy7ESqwJzCs29fdWgXPzdCS9W4ujuEWI3kAOsWWvIpI8qVHgasTXOshZ0v8QHxxXw8fumZtrhrt/iGdghLvrGgP4+lbUvYvS7aV1Qx/LBn6WsZU86g4lbvbsO5SChU+kZ8fVALplmTIdAKuCwGQ810raewJ3uk2yi3e/wd4VxoXoF5Wmse88m8E3c11OQ2Q0LflkK7jwALUzImen7rqtT0e7mOP8RWqI5vXNBXvtSQyJUVQHGgZP3H19YMdeSrjShWcnVNyNF5ayxH0OYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxejgTwWhKPiOBqt0RUt9RI28/dgISESh+wMiEp+bwc=;
 b=YoimS3n4Wp7U7oQuocHA9HVYMnEt6fL70jQ1vN9kP2476veo6u315vEgQuNlQgINBc3K5bRk55VPVfbFIPqoxpxQV0i0cifooOWJebTjXMac0/tdYLewcnjbxFw2B1N2Y6pCPpUbZwYfneuQYFMKOgI7aDDijkdxt/bZqiJrOdw=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by BLAPR10MB5249.namprd10.prod.outlook.com (2603:10b6:208:327::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 04:17:00 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 04:17:00 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Aharon Landau <aharonl@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: RE: [PATCH] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
Thread-Topic: [PATCH] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
Thread-Index: AQHZP9cAxdAFjNkEg06mSHnKpvttma7N1mJg
Date:   Tue, 14 Feb 2023 04:17:00 +0000
Message-ID: <CO6PR10MB5635AF77EED755B4F91B4E9FDDA29@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <0-v1-c13a5b88359b+556d0-mlx5_umem_block_jgg@nvidia.com>
In-Reply-To: <0-v1-c13a5b88359b+556d0-mlx5_umem_block_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5635:EE_|BLAPR10MB5249:EE_
x-ms-office365-filtering-correlation-id: 65d943a8-74bf-4302-c752-08db0e4251dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/WqIPeZfZ83e9hMnQsIi80O/2bqMtPTl9l3TqWe9PR/3QndGMctuiyLGUudrfdXv03g2O9Xci1y1UTa7Yak2xrIv5UwiAuCRHyuhpLTJFj4Gh//NOfE2Cd/LiJ6y/Co67Yb31XA6znnuMGvFkZoi0QUVbkg75VcGoJ3PKBMXTrQceCbOjPUh9C7N7KfzAQANTM51tvoe9GJKzKQxpHLtp1LNacoIEwED/Sw0Fpg9mZQXurUQi98ey7tZNYXQmL4BuzriS9AMVjCWT2sHKS37HjU8nGLCZL2SPvA5Ptd31n2DWDIWOSNMqy6C71deUxp0gnmVbhQGMvZLDaUfgwPEtIFoTPER7iApP81JHQa78MintOhy91qJv5LeGKQkJPs1US/1Go3jHqUNZCmFK4akPFsHXJrgC9OtLsStVaR3BxUnLdwx8OOkhcdeqeoBMJwo2UvDuO+dGYqAbQQmJvVvuoaViyNoH0v6hvQ4sgx6gg+9vrRWJy0CcR52rOBPvHZTGqzY651og7qdcMlkhTr/WJdxnERwalbBYGVKwR8BHJ8/oG4wOOpBlPMaFvCwKF6tH3I/5pBayLYLj8hdCpRTBBof8Tc2qYqxQS+dprmjBk8P1WsbuA5clzTjh9DqCyugdZzx2LT8Va1/atSJSqJU2TlprEOVgknIG37howkXTYZ6jEz0YyZTetMkFIgX/vq5k3LZ04XLuTvsFojvnwSBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(110136005)(316002)(54906003)(66556008)(66446008)(8676002)(66946007)(4326008)(66476007)(76116006)(64756008)(41300700001)(52536014)(8936002)(5660300002)(6506007)(2906002)(71200400001)(478600001)(55236004)(122000001)(9686003)(7696005)(186003)(26005)(53546011)(55016003)(83380400001)(33656002)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6y6Qbw4TfqtwFAuEOVdTTBljzSyHAjvoLiXg5Pi7RnDYiHKT9UdwcEM0bNgn?=
 =?us-ascii?Q?JQ1/WCcDaxJ+HyFETJQx4axOC+55kmPJl8DzAV8cpYyup9n7O9aFAv8IN0E1?=
 =?us-ascii?Q?bEpfqW0LNhEnwi6oc+UcQep5ExIDukgV+2Gr0D3fhJjB7EltSZY2NXNIbXBG?=
 =?us-ascii?Q?VmamE2hYIH2ZyNms05DT+DipqWiZgZRubaNwsXqBK2YaD3mpCupedKWD53Og?=
 =?us-ascii?Q?QZ+sdDvLUr3FqBhgLzKFYIdEyf54gS0Rh5ZAJGRVsTGQI2pUHtjv0X3vlvkS?=
 =?us-ascii?Q?6N9cu1b1J0Th0pKM0RVC7NHJw/Vjw+TRN3YjwpvL9fJkebhS+Wz22dpU58Bm?=
 =?us-ascii?Q?QRmuHJhix8gl63aEXzXksMvIL5+f39UGalXajglXSiGy2twnbGnP70wls4qU?=
 =?us-ascii?Q?mS6jX6sVxsG2qeYXHdzssO2DAVUo1BiDkYwAStbbIjkdd3Vs0OBZLoO2QGPZ?=
 =?us-ascii?Q?SP8JBTiOJXSQP2T9EKq3Mct1+GYvNjyPJteLvQUF+y7u6fop/w47yQpiUyrE?=
 =?us-ascii?Q?V2nkqdErbnNdcMcPLzDl+DKucs/NymvTgGEMnHBd7Xz7TK5DhkYYppMRFSKb?=
 =?us-ascii?Q?ZZPd2VP6bZngY1bp6OVSyAhVOdsReUMcJjvdpdsHIw4p7smUmsLVxn5CVLYs?=
 =?us-ascii?Q?BxJoXtpyClnz96paMnSouYn3o303GFk81XNlgadAUVuRMBSSQGBYkYmtNIg+?=
 =?us-ascii?Q?+eKhfGR9CVUaaMIZMHET+XYnHhtHQaIRLdM9LxDPPFqy5dAF1PpEQueSSoA8?=
 =?us-ascii?Q?wyXGOdvT+q7VVaxeAG+93vorZg4D24OOvxdLUtBQfU2vwz25eOcSaBR4nx/W?=
 =?us-ascii?Q?9GkZcDd3c2BxSzJO4I/YwAmcZUN8bNy/XUpSuk5sXLImxCinN9LvSfxnHLDQ?=
 =?us-ascii?Q?8Rcc5omLN5I+yEDT6lennUgnbS+VEF66ACg645N8zqA3XXw1PuBVEDaGtfHe?=
 =?us-ascii?Q?XDe1dz8eQNP2s3ZQxrrj9AjsiM4OuANOPkvTSW0VHnuB3+toioesDb4aUJ3o?=
 =?us-ascii?Q?vI34npun56tpnzfoXUzAcs2VpXaeMvo+88/eOJjItOB8UYOGo6p3l04l1Geh?=
 =?us-ascii?Q?sd4uUvDi/rmLb1EgchNKa6vIzFWFR4HfOrAdbu4KcdZsaJ+akFRevflarNoR?=
 =?us-ascii?Q?Hb1+tT3U3iFWFW/azZ50WRpHXUw3ML3FF56aegoJDl26Nh3Va006Is+ByXp7?=
 =?us-ascii?Q?A69MrI5I554DCV5OcuTaOWXgPetYjoo8h68+zSYTDXVJgTmpuf70bERX2VpD?=
 =?us-ascii?Q?pqsSLaRz0YNbsZUAnbUZzbRi8cLQ4h8ZADHvwi0mKqSOJtEzgNCNjf3SCm2a?=
 =?us-ascii?Q?Vc5+0zUfkHQdR4vKMDekzFM+HCjBE1lzbLYtq7vc1JfAnsIaHDCcj6oQhBwx?=
 =?us-ascii?Q?TNW+a4DQLiCXdNMnFUx6DXyYhtOemQz6lCXphwflnyhh0vWTwHx/vVm2zmJy?=
 =?us-ascii?Q?iwK90JKcy2Mp6hVnk5T+rD7/iMKgZuncV1mtiPdaOWHLo3j4FD3zxo1+W5uU?=
 =?us-ascii?Q?i28qRaCaD0/QdkwkqTEWYK+0bkScp6/rJAYZslpxNozyUo60wQCMqgfuGaV1?=
 =?us-ascii?Q?OOPloRxpmTWky+bczCZVa/jiQQCC35FMotN50CfgLOoizs12T0nQrIpcR/Uj?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3AHT920BurPCN6VNGWltZGn7paZ1y574VEpzLjmrTzHsnETWqdy2vmwuDlxumPU5vDb4Sz9QnQ9hcsamVjjaqwGJvABsfaNzORf4nTw+rSqag698HdfIG+e7tkJD9L3B+GurF1YwAO7mfc1LZaYlZneWgFuyDNEgpg/YHjudrFU5DJOOJTnU+pLqEPGkxFhENaonFQK5Qu98YRNSo1BUgWa3x4QX0PTxwn1kVDqeIcr/SbT68n9ynLnzOqf831+VqaJamLSBdrIOugYMMOPVwgPjoT/tkzZb82YifvPEcPjelaBqu/dnG/G98/qK2OlwEQG8Ddv+E9C29/h6DgXqcYYTx7Eey3Wo+PMs49E+2vXOdNQ9qucDEvdoWbJn0yWyVhLCwgzenOkYbWAeLLZoktgsUJPAe26dgWahzjC6HqimGFilRY4f68MGR2t08rrtNVFOfeBpPvOptbRH4s4t6a2gLv2ZrrgurgXVZAFirHBhXJHvyMd2fQ2k4mEoPhcP7h2AnOD1ZGCvxv/hDstph5+7H3befiUYiZKk2OKtCrAtb6Df2HgWJdzgNY3gANX9nwC7wtPbkWgSNnOeHY50sbhrnx8kIkL6tZfwaha+QoZ5SvR0cxzkJzol9DKvvg6HUnR3M1UtRQJytCncnxdpXy6n2F6zualzEqVf1K6WwuDlZ4edzx4Q0xp9i+2Mc9HBS5rmz36XuB+Qb5usVQ19Z4KcQlfDCTCTFnVXMcJyvnGBZJX61NmGq8LRR3C1koIGrRL6NiizrgOlkWTxCPqPVIWnDKp+K21OIFTBlNpFNASXkitqYYiY1V3Gx7MvEevC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d943a8-74bf-4302-c752-08db0e4251dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 04:17:00.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuVueV46v/asMvYcvw7/GAO/VAy7zuYunk8CYxB/UXEb8IXcgwbIkpQgRBgpZNL5lEN3KnsSvzsaAa+MLssEEyLOqCuOzMoCv6wvRmdoYso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_02,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140033
X-Proofpoint-GUID: iWP5iNd_5dd1zbLEtzor8eezR5DgfV8m
X-Proofpoint-ORIG-GUID: iWP5iNd_5dd1zbLEtzor8eezR5DgfV8m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 13, 2023 11:44 PM
> To: Leon Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org
> Cc: Aharon Landau <aharonl@nvidia.com>; Leon Romanovsky
> <leonro@nvidia.com>; Michael Guralnik <michaelgur@nvidia.com>
> Subject: [PATCH] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
>=20
> Replace an open coding of rdma_umem_for_each_dma_block() with the
> proper function.
>=20
> Fixes: b3d47ebd4908 ("RDMA/mlx5: Use mlx5_umr_post_send_wait() to
> update MR pas")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/umr.c
> b/drivers/infiniband/hw/mlx5/umr.c
> index 029e9536ec28f2..55f4e048d94743 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -636,9 +636,7 @@ int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr
> *mr, unsigned int flags)
>  	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
>=20
>  	cur_mtt =3D mtt;
> -	rdma_for_each_block(mr->umem->sgt_append.sgt.sgl, &biter,
> -			    mr->umem->sgt_append.sgt.nents,
> -			    BIT(mr->page_shift)) {
> +	rdma_umem_for_each_dma_block(mr->umem, &biter, BIT(mr-
> >page_shift)) {
>  		if (cur_mtt =3D=3D (void *)mtt + sg.length) {
>  			dma_sync_single_for_device(ddev, sg.addr,
> sg.length,
>  						   DMA_TO_DEVICE);
>=20

Looks good!

Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>

> base-commit: 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7
> --
> 2.39.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDEC2FF3E4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbhAUTK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 14:10:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38726 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbhAUTKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 14:10:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LIxaJp117870;
        Thu, 21 Jan 2021 19:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=N7wmNik261C8r/HAgwq58TfM2kvXWYkXbwVVr4v/3Yw=;
 b=JoFDsCmiobubFpoWk5dB3eRg74RwkicZY61b134mFMmTeKbzQJ9OeaefRKZ1VQTtd9dy
 hiGQvFJOTxa7MAF7r5TcjDWmtRIT6xF0txeOu8waUiPIkpAHUO6POfTslyXFNgN8runG
 f9hird9P4C6fEL38EcnlXBXQS7BWbLeGBvgfpAMftrB3o79txZ0APPJhN8Ukxs9SrScQ
 m/8rzK7wzIPQLz5KspXjaKVNJ3lOU0ELgXt3bVtwmgmszB523PgSLeHtJlwrWvNXYNHc
 2VTBwowOoGRTGGTdvrQibxZsdW8+KYiK3khwV23twL8X3bDi5TLbhfP05CHnXsM6Alsq 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qagxgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:09:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LJ5o9g039522;
        Thu, 21 Jan 2021 19:09:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3668rfgp5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn70Dfg+aXtFAfvQNSYetD6S9bjXm7JQ87qUuRAf4pr6Wre1D+zLwoMShNkXdXESrHnABl0RAMgpxLFMTwfE/MWnDzff3yctNFzWTuhCKC1mciJDkQjpVn09sN/VBbN1PO09vUvZ/CXOjIgvMudlleRoGk5CAksLTbFEurqoG1jofHyXQc6c9ThSSirGlBYfV2g7BjYwtBhoIu9sTk+0HSRrq+49hzIQ4hjORM1JxqeytuNBiWpDjlQsJ+6rC/yPP9+VMYUdgGgdzXJ0cJfAoTC0zB4RWpPfHACpXEUbMaI9kYujIGsS2Yhnkq2sSV8hZQ8Se1ymIRqt59DqeMjdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7wmNik261C8r/HAgwq58TfM2kvXWYkXbwVVr4v/3Yw=;
 b=mHbFCmmuyEU6xGbOLitC5FZj6b+tsJl94eQo/L3GnMa01589wtDzWZv1FxOq51+2LZjsjMGyGgIgp7NZ92dbG6YX052r933QaymaMzwE2dyXYfzJZ/lKeVvubkBc1HNxHSh/HLr47tdsIV2JJ4QnhvdU4llTKGSvn87Wms+p+PiETMBbaYbBm2Hurhlj2i/GE3hifmzEKrnW/Grl1cpHD8JBqbqg6+F5Tocwygkynya8JoUdpUTysJWl0jSmp2vLZL8BuK8Jp4fxfCUqGCCxKdeJe2grPhpwjrd4QnwGNQKDCbAD32pbHZ6AGqajHZkClIkrHGhbtWp/Bs1TWnQIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7wmNik261C8r/HAgwq58TfM2kvXWYkXbwVVr4v/3Yw=;
 b=mtFORiYljJK28t8n8S00vSAdQ1IDJHNBTq0xB/48vSju8xPXoROGPfWoXACSh9bJaoSWNveO45TvGpThiygQ0azVGToLY0HYV2FEUucrJ58A3KzhibG3SC0ZcnyIgh/qwg2v5B5DYFPpEMnNS8W2U+m0lrK7G+7wqoVB0v3E/ZU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 19:09:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 19:09:23 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "murphyt7@tcd.ie" <murphyt7@tcd.ie>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Thread-Topic: performance regression noted in v5.11-rc after c062db039f40
Thread-Index: AQHW8CjtBQQTuiJM7EWdlhiEV8dliA==
Date:   Thu, 21 Jan 2021 19:09:23 +0000
Message-ID: <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
In-Reply-To: <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f4e5ed-3ec4-4bbf-61b2-08d8be40106e
x-ms-traffictypediagnostic: BY5PR10MB4321:
x-microsoft-antispam-prvs: <BY5PR10MB4321C2279AC9A66B823E4C9493A10@BY5PR10MB4321.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utiUt+7NtwhBG0/KM0qS8c46m37P1UeEeyZI/zdWioC+BYvsl+aSqt8KvYkhOTMbO6AnWYnGwBQ4vejcp6QP08Bm+wPxSdHXOZKroaSalLRI7cEJXfRQZONakvRHDkoFQMqqDCWpWKM73uZhibGWC/Xr3VDCndRb1n49ih3vkP+JRylZDlAbo7AiRRq2JhDQZpoNEOw1VaEtFL+6Zdcfc25t8ow/8LawZuL5BA70IXejecXPIA7gz+OvxmvehdldglE4E4WtDIhJvb/pNxOtMTwTJLtSVM48oyatbn0VgLTBYg489pgGrLAa5ggkueIw/zTJkcBDlWakVRHUa8kgpIu4QbfEC/W7UY/ACMOHh2OvMZRv82k3jVSjIjwKqtVfbHU6NlvhlmL0lMeGIvjtMSfqfFR+i5qjs3jbUjFuL/htQsz4SSaZ1mhLUIt7xG+B77ZhIsON6E8X+gL6KV41gfuKSDw5jD2zL75hGLO6pi+FreJWvINiZUOwHAWSN6bPPFzrMnxlHpKxqWSB61//n4toc/oH3VZnuCrBW+TEVTFRZvXGQEcwXU7QpJKUT2LNtOK2psZsZw8nnQ2S6xxEsYMMow5WLjUjWmv0/gscGR8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(64756008)(6486002)(53546011)(316002)(54906003)(6512007)(33656002)(30864003)(86362001)(66946007)(8676002)(6506007)(8936002)(66476007)(508600001)(2616005)(186003)(4326008)(6916009)(83380400001)(71200400001)(36756003)(76116006)(91956017)(44832011)(26005)(2906002)(66556008)(5660300002)(66446008)(98903001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?En1Y7ihk07cnWEqA1/MTsIcHrGGytVSd1dedcg1Df7ODEmeJ7amiJLkEIvlg?=
 =?us-ascii?Q?bFiCviH+oQaRzleLUoXPAUyItXEniLqMuWwKmH3NJkhFF0y2yCqlva2h3tIW?=
 =?us-ascii?Q?MO9L6/c421Kl2UdGk4xumUF0b08lePOxHSRbl65/zoYgxdBZxpPEh41a9byF?=
 =?us-ascii?Q?ehFrcuSaYOuEaenNKouRsq6uTiggMWbyXylFwzLTMD4ZezmDM2n9WmlK0jug?=
 =?us-ascii?Q?LIp+DMG9dn5IZpd6XiBJuLvqHk5Sy8dyfiPzzJOXlcCxacUVNpcgGSYVj6zF?=
 =?us-ascii?Q?QotwKNwoSdFf4AI4qKcrKMdlr8UcrhIn4/tw5Ku1EEN+bLENJ41ZMcezfeZn?=
 =?us-ascii?Q?1cGSk7BbpGlynbLvPqYIA+T8SxQuzshaPD0PFOVR0xdCUFsKZTtpxnvc+oFv?=
 =?us-ascii?Q?t8NX6aNyZX6BExZrVP4CzS4HeOuU1zOIJ+DdnY94XK0tBWNPWqDXInBMpvFc?=
 =?us-ascii?Q?p/Loq/NRx5DiIDtxsUe213vrk/tMsxmCXsye53q/IRdGOyGs8QhKvHbzllxt?=
 =?us-ascii?Q?8k10eDq5dbzOgwwuxAeokEypdBpGMRTuLKpPBCmvMV5fDRT1Sfq+UyYyVtKS?=
 =?us-ascii?Q?Fvsq1cntgpQAZhdLrPAdmc+tWnyQzSnvaCLKy4/TvUg+h2B07qew6HwrVsFG?=
 =?us-ascii?Q?OfOelL5iAulvtyv0jVfxBODGwiJjx0Z1pp54lXq/IB2cnbk7C96uI1XiJyPV?=
 =?us-ascii?Q?IdE8QjtRBexnp9r/9qWM73qluzID4OY5sX5EjFETjyjLrmX/9EhIXxt7vKEE?=
 =?us-ascii?Q?Qkc9ikaL/R7hMifSTi2LNRqD7j2uscqQAcVWbTsA9aSA2gORopjHAgGNPxIm?=
 =?us-ascii?Q?FPPuX3uhdwHvx7VzVzhNIHkKiiprXeLDlm3V1j/soyQHpHCSPRq/ieO7J+GN?=
 =?us-ascii?Q?+PM/AtPZu4DIjnXFTN10gtxjN9RlmFsDbMxfuimVVkdyJX50n+QVXgquVDzF?=
 =?us-ascii?Q?ux3rVMu4Bf+dseAjRS7M+QroOuu/XXyaqGJcqBkFFkfTnEyYbc2fcB62Fa++?=
 =?us-ascii?Q?cJG1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C63F3CA9FFFE6946A7D1D84E8FE2A8C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f4e5ed-3ec4-4bbf-61b2-08d8be40106e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 19:09:23.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLOwcyVrK/p3O0wlO45VP2YsE9iQ060mXMoSpRld/Fuxb1UCHEef46b48d0+4dHW1tAl1fn4fTazHKwMBBn1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210096
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 18, 2021, at 1:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> On 2021-01-18 16:18, Chuck Lever wrote:
>>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>>=20
>>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>>> Hi-
>>>>=20
>>>> [ Please cc: me on replies, I'm not currently subscribed to
>>>> iommu@lists ].
>>>>=20
>>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>>=20
>>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>>=20
>>>> For those not familiar with the way storage protocols use RDMA, The
>>>> initiator/client sets up memory regions and the target/server uses
>>>> RDMA Read and Write to move data out of and into those regions. The
>>>> initiator/client uses only RDMA memory registration and invalidation
>>>> operations, and the target/server uses RDMA Read and Write.
>>>>=20
>>>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>>>> enabled using the kernel command line options "intel_iommu=3Don
>>>> iommu=3Dstrict".
>>>>=20
>>>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>>>> I was able to bisect on my client to the following commits.
>>>>=20
>>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>>> map_sg"). This is about normal for this test.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 4732581.09 kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 4646810.21 kB/sec
>>>> 	Min throughput per process 			=3D  387764.34 kB/sec
>>>> 	Max throughput per process 			=3D  399655.47 kB/sec
>>>> 	Avg throughput per process 			=3D  394381.76 kB/sec
>>>> 	Min xfer 					=3D 1017344.00 kB
>>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utili=
zation  73.89 %
>>>> 	Children see throughput for 12 rewriters 	=3D 4837741.94 kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 4833509.35 kB/sec
>>>> 	Min throughput per process 			=3D  398983.72 kB/sec
>>>> 	Max throughput per process 			=3D  406199.66 kB/sec
>>>> 	Avg throughput per process 			=3D  403145.16 kB/sec
>>>> 	Min xfer 					=3D 1030656.00 kB
>>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utili=
zation  75.82 %
>>>> 	Children see throughput for 12 readers 		=3D 5921370.94 kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 5914106.69 kB/sec
>>>> 	Min throughput per process 			=3D  491812.38 kB/sec
>>>> 	Max throughput per process 			=3D  494777.28 kB/sec
>>>> 	Avg throughput per process 			=3D  493447.58 kB/sec
>>>> 	Min xfer 					=3D 1042688.00 kB
>>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utili=
zation  92.75 %
>>>> 	Children see throughput for 12 re-readers 	=3D 5947985.69 kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 5941348.51 kB/sec
>>>> 	Min throughput per process 			=3D  492805.81 kB/sec
>>>> 	Max throughput per process 			=3D  497280.19 kB/sec
>>>> 	Avg throughput per process 			=3D  495665.47 kB/sec
>>>> 	Min xfer 					=3D 1039360.00 kB
>>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utili=
zation  93.22 %
>>>>=20
>>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 4342419.12 kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 4310612.79 kB/sec
>>>> 	Min throughput per process 			=3D  359299.06 kB/sec
>>>> 	Max throughput per process 			=3D  363866.16 kB/sec
>>>> 	Avg throughput per process 			=3D  361868.26 kB/sec
>>>> 	Min xfer 					=3D 1035520.00 kB
>>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utili=
zation  67.22 %
>>>> 	Children see throughput for 12 rewriters 	=3D 4408576.66 kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 4404280.87 kB/sec
>>>> 	Min throughput per process 			=3D  364553.88 kB/sec
>>>> 	Max throughput per process 			=3D  370029.28 kB/sec
>>>> 	Avg throughput per process 			=3D  367381.39 kB/sec
>>>> 	Min xfer 					=3D 1033216.00 kB
>>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utili=
zation  68.97 %
>>>> 	Children see throughput for 12 readers 		=3D 5406879.47 kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 5401862.78 kB/sec
>>>> 	Min throughput per process 			=3D  449583.03 kB/sec
>>>> 	Max throughput per process 			=3D  451761.69 kB/sec
>>>> 	Avg throughput per process 			=3D  450573.29 kB/sec
>>>> 	Min xfer 					=3D 1044224.00 kB
>>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utili=
zation  85.12 %
>>>> 	Children see throughput for 12 re-readers 	=3D 5410601.12 kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 5403504.40 kB/sec
>>>> 	Min throughput per process 			=3D  449918.12 kB/sec
>>>> 	Max throughput per process 			=3D  452489.28 kB/sec
>>>> 	Avg throughput per process 			=3D  450883.43 kB/sec
>>>> 	Min xfer 					=3D 1043456.00 kB
>>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utili=
zation  85.21 %
>>>>=20
>>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>>> the iommu ops"). Significant throughput loss.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 3812036.91 kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 3753683.40 kB/sec
>>>> 	Min throughput per process 			=3D  313672.25 kB/sec
>>>> 	Max throughput per process 			=3D  321719.44 kB/sec
>>>> 	Avg throughput per process 			=3D  317669.74 kB/sec
>>>> 	Min xfer 					=3D 1022464.00 kB
>>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utili=
zation  60.02 %
>>>> 	Children see throughput for 12 rewriters 	=3D 3786831.94 kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 3783205.58 kB/sec
>>>> 	Min throughput per process 			=3D  313654.44 kB/sec
>>>> 	Max throughput per process 			=3D  317844.50 kB/sec
>>>> 	Avg throughput per process 			=3D  315569.33 kB/sec
>>>> 	Min xfer 					=3D 1035520.00 kB
>>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utili=
zation  58.90 %
>>>> 	Children see throughput for 12 readers 		=3D 4265828.28 kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 4261844.88 kB/sec
>>>> 	Min throughput per process 			=3D  352305.00 kB/sec
>>>> 	Max throughput per process 			=3D  357726.22 kB/sec
>>>> 	Avg throughput per process 			=3D  355485.69 kB/sec
>>>> 	Min xfer 					=3D 1032960.00 kB
>>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utili=
zation  66.20 %
>>>> 	Children see throughput for 12 re-readers 	=3D 4220651.19 kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 4216096.04 kB/sec
>>>> 	Min throughput per process 			=3D  348677.16 kB/sec
>>>> 	Max throughput per process 			=3D  353467.44 kB/sec
>>>> 	Avg throughput per process 			=3D  351720.93 kB/sec
>>>> 	Min xfer 					=3D 1035264.00 kB
>>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utili=
zation  65.74 %
>>>>=20
>>>> The regression appears to be 100% reproducible.
>> Any thoughts?
>> How about some tools to try or debugging advice? I don't know where to s=
tart.
>=20
> I'm not familiar enough with VT-D internals or Infiniband to have a clue =
why the middle commit makes any difference (the calculation itself is not o=
n a fast path, so AFAICS the worst it could do is change your maximum DMA a=
ddress size from 48/57 bits to 47/56, and that seems relatively benign).
>=20
> With the last commit, though, at least part of it is likely to be the unf=
ortunate inevitable overhead of the internal indirection through the IOMMU =
API. There's a coincidental performance-related thread where we've already =
started pondering some ideas in that area[1] (note that Intel is the last o=
ne to the party here; AMD has been using this path for a while, and it's al=
l that arm64 systems have ever known). I'm not sure if there's any differen=
ce in the strict invalidation behaviour between the IOMMU API calls and the=
 old intel_dma_ops, but I suppose that might be worth quickly double-checki=
ng as well. I guess the main thing would be to do some profiling to see whe=
re time is being spent in iommu-dma and intel-iommu vs. just different part=
s of intel-iommu before, and whether anything in particular stands out beyo=
nd the extra call overhead currently incurred by iommu_{map,unmap}.

I did a function_graph trace of the above iozone test on a v5.10 NFS
client and again on v5.11-rc. There is a substantial timing difference
in dma_map_sg_attrs. Each excerpt below is for DMA-mapping a 120KB set
of pages that are part of an NFS/RDMA WRITE operation.

v5.10:

1072.028308: funcgraph_entry:                   |  dma_map_sg_attrs() {
1072.028308: funcgraph_entry:                   |    intel_map_sg() {
1072.028309: funcgraph_entry:                   |      find_domain() {
1072.028309: funcgraph_entry:        0.280 us   |        get_domain_info();
1072.028310: funcgraph_exit:         0.930 us   |      }
1072.028310: funcgraph_entry:        0.360 us   |      domain_get_iommu();
1072.028311: funcgraph_entry:                   |      intel_alloc_iova() {
1072.028311: funcgraph_entry:                   |        alloc_iova_fast() =
{
1072.028311: funcgraph_entry:        0.375 us   |          _raw_spin_lock_i=
rqsave();
1072.028312: funcgraph_entry:        0.285 us   |          __lock_text_star=
t();
1072.028313: funcgraph_exit:         1.500 us   |        }
1072.028313: funcgraph_exit:         2.052 us   |      }
1072.028313: funcgraph_entry:                   |      domain_mapping() {
1072.028313: funcgraph_entry:                   |        __domain_mapping()=
 {
1072.028314: funcgraph_entry:        0.350 us   |          pfn_to_dma_pte()=
;
1072.028315: funcgraph_entry:        0.942 us   |          domain_flush_cac=
he();
1072.028316: funcgraph_exit:         2.852 us   |        }
1072.028316: funcgraph_entry:        0.275 us   |        iommu_flush_write_=
buffer();
1072.028317: funcgraph_exit:         4.213 us   |      }
1072.028318: funcgraph_exit:         9.392 us   |    }
1072.028318: funcgraph_exit:       + 10.073 us  |  }
1072.028323: xprtrdma_mr_map:      mr.id=3D115 nents=3D30 122880@0xe476ca03=
f1180000:0x18011105 (TO_DEVICE)
1072.028323: xprtrdma_chunk_read:  task:63879@5 pos=3D148 122880@0xe476ca03=
f1180000:0x18011105 (more)


v5.11-rc:

57.602990: funcgraph_entry:                   |  dma_map_sg_attrs() {
57.602990: funcgraph_entry:                   |    iommu_dma_map_sg() {
57.602990: funcgraph_entry:        0.285 us   |      iommu_get_dma_domain()=
;
57.602991: funcgraph_entry:        0.270 us   |      iommu_dma_deferred_att=
ach();
57.602991: funcgraph_entry:                   |      iommu_dma_sync_sg_for_=
device() {
57.602992: funcgraph_entry:        0.268 us   |        dev_is_untrusted();
57.602992: funcgraph_exit:         0.815 us   |      }
57.602993: funcgraph_entry:        0.267 us   |      dev_is_untrusted();
57.602993: funcgraph_entry:                   |      iommu_dma_alloc_iova()=
 {
57.602994: funcgraph_entry:                   |        alloc_iova_fast() {
57.602994: funcgraph_entry:        0.260 us   |          _raw_spin_lock_irq=
save();
57.602995: funcgraph_entry:        0.293 us   |          _raw_spin_lock();
57.602995: funcgraph_entry:        0.273 us   |          _raw_spin_unlock_i=
rqrestore();
57.602996: funcgraph_entry:        1.147 us   |          alloc_iova();
57.602997: funcgraph_exit:         3.370 us   |        }
57.602997: funcgraph_exit:         3.945 us   |      }
57.602998: funcgraph_entry:        0.272 us   |      dma_info_to_prot();
57.602998: funcgraph_entry:                   |      iommu_map_sg_atomic() =
{
57.602998: funcgraph_entry:                   |        __iommu_map_sg() {
57.602999: funcgraph_entry:        1.733 us   |          __iommu_map();
57.603001: funcgraph_entry:        1.642 us   |          __iommu_map();
57.603003: funcgraph_entry:        1.638 us   |          __iommu_map();
57.603005: funcgraph_entry:        1.645 us   |          __iommu_map();
57.603007: funcgraph_entry:        1.630 us   |          __iommu_map();
57.603009: funcgraph_entry:        1.770 us   |          __iommu_map();
57.603011: funcgraph_entry:        1.730 us   |          __iommu_map();
57.603013: funcgraph_entry:        1.633 us   |          __iommu_map();
57.603015: funcgraph_entry:        1.605 us   |          __iommu_map();
57.603017: funcgraph_entry:        2.847 us   |          __iommu_map();
57.603020: funcgraph_entry:        2.847 us   |          __iommu_map();
57.603024: funcgraph_entry:        2.955 us   |          __iommu_map();
57.603027: funcgraph_entry:        2.928 us   |          __iommu_map();
57.603030: funcgraph_entry:        2.933 us   |          __iommu_map();
57.603034: funcgraph_entry:        2.943 us   |          __iommu_map();
57.603037: funcgraph_entry:        2.928 us   |          __iommu_map();
57.603040: funcgraph_entry:        2.857 us   |          __iommu_map();
57.603044: funcgraph_entry:        2.953 us   |          __iommu_map();
57.603047: funcgraph_entry:        3.023 us   |          __iommu_map();
57.603050: funcgraph_entry:        1.645 us   |          __iommu_map();
57.603052: funcgraph_exit:       + 53.648 us  |        }
57.603052: funcgraph_exit:       + 54.178 us  |      }
57.603053: funcgraph_exit:       + 62.953 us  |    }
57.603053: funcgraph_exit:       + 63.567 us  |  }
57.603059: xprtrdma_mr_map:      task:60@5 mr.id=3D4 nents=3D30 122880@0xd7=
9cc0e2f18c0000:0x00010501 (TO_DEVICE)
57.603060: xprtrdma_chunk_read:  task:60@5 pos=3D148 122880@0xd79cc0e2f18c0=
000:0x00010501 (more)


--
Chuck Lever




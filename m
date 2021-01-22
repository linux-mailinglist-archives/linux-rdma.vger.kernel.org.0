Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098F300C67
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbhAVTWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:22:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbhAVSld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 13:41:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MIOhl2070494;
        Fri, 22 Jan 2021 18:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=erC76eaYdFPB6rpzqCjwB8J+OFAw1qHhM9SEUDfcvJw=;
 b=x5USPR/AkNSDcT6KYhFIFbhx4gUyNQxKivGaUhkwMorOxpau+UKg97EoB7w/hxP6BFUl
 SLoOI+4MtNyEQt13xyUI0GaUmrxiXW3G0BB1tkQJwCMgDu1dp67TJ1s4DKNeUk7TWwDe
 39l88//LAm1eeO8pHIehKoGSb75xfkg+N0tQr1SOSP5a5/mVCE/nAxyrQF99Nr0f1D1/
 9sPYeIQDLbbptegxOfK/ocYh1DiFDTZ2O4EH4czH2niML+B3wghrQIUx0gn423s4sVqe
 My7JqOZw6aMOegBj/WwRvib4uYST9pXU+DkF6mMTyUffgZ6eZgLy4SopuKiQ96KA20WE UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qn5hdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 18:40:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MIOwYr024013;
        Fri, 22 Jan 2021 18:38:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3668r1empg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 18:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuTwonxsWCiHlprEO6mZbwa/PJ/Tx/WDUXGSHsVf6PgjXmVpP3Wx0+T0ZwP8vkxvaNauceFWoj6nt9c9Lgz6C8s/jUVnT1/eLqyjSfeNosxv+OB5sfxpgfBiTRFVJcCrSk/2Kqpp1Btf4GggNdcvmFSN9U6WYfJyR8CsGK4lM65NWTlUNuRT27ufneKynlkoAx6hEKl6gbwmUMkm1KgH4NM1+xWR18PS7J4lNwZpdwws3ck3pvLTUyHW3uwd8iCxgAmkrMUfPBiiKkICULQZOEH03ZVS2tnrNZF0ywT+JLga91suXUQ4mN/ITrEyzs1uVpaYNdIFywx125/Rh+E8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erC76eaYdFPB6rpzqCjwB8J+OFAw1qHhM9SEUDfcvJw=;
 b=FmMmjo9/zIVWJ+99avHNV4KVV/HHC+z7hECcUMsxbVr33vPLRotLlNF8sP0nntt6sR3F9b/aeCzG2pCIn/3XySHAFhtxSwVKqgxGc9vB4+HQWRVZJf9u1MFZeM587WLyjLnM6K4OsDprLU3w9Zv8inlmFJpzjo/7hzbUOxYA1HK+6/nfBsn4O7Hr3LkC85du8nqx0iUuo8rgImBIlGy4/7ApnAIcgqGWobHcm4KFY9pRaKwFpC5EAeoAPaYRO07hIA8LM0FSKB63XLMTohBoT7YZhE9hfOtXJWL10mF9Oy9LmRgdH5pA6Yy8Q63OzCT8YcOd027VWK3J5AMQ2skmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erC76eaYdFPB6rpzqCjwB8J+OFAw1qHhM9SEUDfcvJw=;
 b=yJvRDG1z2W055WC3/UV71Rj6aRBW0mdd1wsCE7eRzXW5pD2ZDn/897/clZGt/8E2YfDOrcqTPdzs/byXflyU14BKSL19OKX7MzgrJp51FFn3MJy/L1QhPXG/1wp2njBIOVUdP6fJb9uvkVqr8mrGzMrQOjN0d/SMBESJrbuXDL0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3413.namprd10.prod.outlook.com (2603:10b6:a03:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Fri, 22 Jan
 2021 18:38:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 18:38:25 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "murphyt7@tcd.ie" <murphyt7@tcd.ie>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Thread-Topic: performance regression noted in v5.11-rc after c062db039f40
Thread-Index: AQHW8CjtBQQTuiJM7EWdlhiEV8dliKoy9RQAgADe/wCAABaIAIAAEJyA
Date:   Fri, 22 Jan 2021 18:38:25 +0000
Message-ID: <A2EAC08C-75D3-47A0-9BED-720A49551AE9@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
 <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
 <3A4451BB-41BD-429B-BE0C-12AE7D03A99B@oracle.com>
 <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
In-Reply-To: <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f94a3a60-b8b4-4388-a2c1-08d8bf04e786
x-ms-traffictypediagnostic: BYAPR10MB3413:
x-microsoft-antispam-prvs: <BYAPR10MB3413C236CAD228CE41BB59F293A09@BYAPR10MB3413.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZdBEeZ3uz3BPbvGN48BmqmCu+NUP8f0d3HYLxGGkABlog4xpcdRgmNpKHWFkECiFGETkcQ5TOhLv+Fc0ib6fku/b7Y2wVEeHobJiXWxvHPlfQq1CqpJVJZMbF+QVnqMT/maYJDdOb1egjwdxkH3C1vyWZKp8NDL6S9+t4sx2YGFa4cr9M1cwEjltllyQtSq1Da5ijHZ7qaxcBnZc78hxnjwhPUbFU+mcTSQ/ancX8lP0oeUQqCHOE7tPW5s1sSbRmq3Z+xNJhCHhIQ/bUgmM0fmBzf4M+5nJJAVgegDXEGh8kzPfYwEEpnBT22Gu7GJGUrFCVyHss4kh+RMhDbfnCHrmYzEOfvX9YzdKt5mjHwpVob8/wPOH3h0Y+7b5SU4tw76H6efNTPb/7Vg5Nu8USQ08EzXrmNt1eFvtCSpFMCwATLz3j1eXAaiAE20xJRsCVI7Pzr+/RedyYgGTSgX9fmtWb+GsCQqklXF0PGo7yB7GOd07r/OtN5UAZUm65Z1ZfGg5CM+ob6Kom82euk7TumxDW+vPEei5FpXoSLI9Bo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(44832011)(6506007)(83380400001)(8936002)(6486002)(53546011)(2906002)(186003)(86362001)(6916009)(91956017)(4326008)(36756003)(66446008)(2616005)(64756008)(66476007)(5660300002)(26005)(6512007)(54906003)(498600001)(76116006)(33656002)(30864003)(66556008)(8676002)(966005)(66946007)(98903001)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rSHDYpEJmsE1EKgfsnl6B1/YKNDltm7tAHsw2q2fuQkKplZO+0oPTOTO7aMR?=
 =?us-ascii?Q?cVxTotbp10eA2RBRij7imkweebTAYK9VbRo5BiOq9iKZY/u17aDOSikV9GSF?=
 =?us-ascii?Q?FOmIuiceYU4RQTWaKKKOxFedD7dSXntpNSsbWja/cKGfrPA2drQsZP0D+++G?=
 =?us-ascii?Q?ww6MsPVos6zKbqN7lGF3FbuRRq2WuoghaCj62iCyon15BblFOmVGSKZgSewd?=
 =?us-ascii?Q?pkQU/MoQHS9VVaKR8RnPKFptZGhBC0u8bup+BBRW0QUILFN8TYKkW0qEMlrs?=
 =?us-ascii?Q?R+4aB2Li9D8ZmSJj+68dMRfLf+6w8DnYfgKThw1DGK0fNu6BYmkpUsJdUHyI?=
 =?us-ascii?Q?fpjdPD97FMl1FH5nGM1GQJ+ZWZhVs4NOpibrSz1lc3R2eR63Eu8Q87kvmtTm?=
 =?us-ascii?Q?dbQHJMEbk+n0Sgh00gvQSYky5WQj3TH6BjHjl1RLHap1KdnHlr33lEv6RbeS?=
 =?us-ascii?Q?jxbo9VsOWYHPHB9IbB9yKBXvCMmZv6Iw90Vp+KtDQPAn/OeZW1xYRhqncZny?=
 =?us-ascii?Q?BWBoZwDTocCfm32ei6j/pMAX/eqeAn3d7aNOcO5qWo0neFVko69QE5p/ZCKa?=
 =?us-ascii?Q?g4xIuMzB45DQvOqTtfALhyQEznIAWJudM1kWkNhrV+kTt6r7EKmTWuUoebxu?=
 =?us-ascii?Q?HIVq25TBiGwp4fgR84akUejhfnG8H3zPgkH8gDmgOronXMqgiF1ORqfp28ku?=
 =?us-ascii?Q?Dzrl0mbGtWkQztYGWn60e5218G+moO6muaJz4/R13dQPhs4VfNC3Ma++52DI?=
 =?us-ascii?Q?SdYk1GPmbORIh8y5eYYqj2sKAnBO6HLQ3XHIhEIkfURiAnFGEuS78UmwF4Zj?=
 =?us-ascii?Q?MfV/n9vwvNo68CIl2fILb9hjLWBfacP3o2JaFCg9CjZ/UdX4RvVpuSnaPSSJ?=
 =?us-ascii?Q?kbbwOBZLgfrK93MvINDOXjAK/9OJjqTMZajQPJQiz4U2gik+ZV699jQ/NwCz?=
 =?us-ascii?Q?OKoU+eG7X+oRuUaPy8xy/HXho2/LSfbxnM13j4IN1/amGL3hiwaXsU/Y6jM/?=
 =?us-ascii?Q?9xqB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <904AC15F8BA8374AB93D396021C710CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94a3a60-b8b4-4388-a2c1-08d8bf04e786
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 18:38:25.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 440J0Ua6/pDF8duYcun94O/2D9O3CAtdGnOWjht/MFI0AmVkadzncG394St6uc2puOJKeSfxtcDuZ+Ufjj4J5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 22, 2021, at 12:38 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> On 2021-01-22 16:18, Chuck Lever wrote:
>>> On Jan 21, 2021, at 10:00 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote=
:
>>>=20
>>> +Isaac
>>>=20
>>> On 1/22/21 3:09 AM, Chuck Lever wrote:
>>>>> On Jan 18, 2021, at 1:00 PM, Robin Murphy <robin.murphy@arm.com> wrot=
e:
>>>>>=20
>>>>> On 2021-01-18 16:18, Chuck Lever wrote:
>>>>>>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>>>>>>=20
>>>>>>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>>>>>>=20
>>>>>>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>>>>>>> Hi-
>>>>>>>>=20
>>>>>>>> [ Please cc: me on replies, I'm not currently subscribed to
>>>>>>>> iommu@lists ].
>>>>>>>>=20
>>>>>>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro car=
ds
>>>>>>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>>>>>>=20
>>>>>>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>>>>>>=20
>>>>>>>> For those not familiar with the way storage protocols use RDMA, Th=
e
>>>>>>>> initiator/client sets up memory regions and the target/server uses
>>>>>>>> RDMA Read and Write to move data out of and into those regions. Th=
e
>>>>>>>> initiator/client uses only RDMA memory registration and invalidati=
on
>>>>>>>> operations, and the target/server uses RDMA Read and Write.
>>>>>>>>=20
>>>>>>>> My NFS client is a two-socket 12-core x86_64 system with its I/O M=
MU
>>>>>>>> enabled using the kernel command line options "intel_iommu=3Don
>>>>>>>> iommu=3Dstrict".
>>>>>>>>=20
>>>>>>>> Recently I've noticed a significant (25-30%) loss in NFS throughpu=
t.
>>>>>>>> I was able to bisect on my client to the following commits.
>>>>>>>>=20
>>>>>>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices i=
n
>>>>>>>> map_sg"). This is about normal for this test.
>>>>>>>>=20
>>>>>>>> 	Children see throughput for 12 initial writers 	=3D 4732581.09 kB=
/sec
>>>>>>>> 	Parent sees throughput for 12 initial writers 	=3D 4646810.21 kB/=
sec
>>>>>>>> 	Min throughput per process 			=3D  387764.34 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  399655.47 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  394381.76 kB/sec
>>>>>>>> 	Min xfer 					=3D 1017344.00 kB
>>>>>>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU u=
tilization  73.89 %
>>>>>>>> 	Children see throughput for 12 rewriters 	=3D 4837741.94 kB/sec
>>>>>>>> 	Parent sees throughput for 12 rewriters 	=3D 4833509.35 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  398983.72 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  406199.66 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  403145.16 kB/sec
>>>>>>>> 	Min xfer 					=3D 1030656.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU u=
tilization  75.82 %
>>>>>>>> 	Children see throughput for 12 readers 		=3D 5921370.94 kB/sec
>>>>>>>> 	Parent sees throughput for 12 readers 		=3D 5914106.69 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  491812.38 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  494777.28 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  493447.58 kB/sec
>>>>>>>> 	Min xfer 					=3D 1042688.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU u=
tilization  92.75 %
>>>>>>>> 	Children see throughput for 12 re-readers 	=3D 5947985.69 kB/sec
>>>>>>>> 	Parent sees throughput for 12 re-readers 	=3D 5941348.51 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  492805.81 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  497280.19 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  495665.47 kB/sec
>>>>>>>> 	Min xfer 					=3D 1039360.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU u=
tilization  93.22 %
>>>>>>>>=20
>>>>>>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>>>>>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>>>>>>=20
>>>>>>>> 	Children see throughput for 12 initial writers 	=3D 4342419.12 kB=
/sec
>>>>>>>> 	Parent sees throughput for 12 initial writers 	=3D 4310612.79 kB/=
sec
>>>>>>>> 	Min throughput per process 			=3D  359299.06 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  363866.16 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  361868.26 kB/sec
>>>>>>>> 	Min xfer 					=3D 1035520.00 kB
>>>>>>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU u=
tilization  67.22 %
>>>>>>>> 	Children see throughput for 12 rewriters 	=3D 4408576.66 kB/sec
>>>>>>>> 	Parent sees throughput for 12 rewriters 	=3D 4404280.87 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  364553.88 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  370029.28 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  367381.39 kB/sec
>>>>>>>> 	Min xfer 					=3D 1033216.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU u=
tilization  68.97 %
>>>>>>>> 	Children see throughput for 12 readers 		=3D 5406879.47 kB/sec
>>>>>>>> 	Parent sees throughput for 12 readers 		=3D 5401862.78 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  449583.03 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  451761.69 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  450573.29 kB/sec
>>>>>>>> 	Min xfer 					=3D 1044224.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU u=
tilization  85.12 %
>>>>>>>> 	Children see throughput for 12 re-readers 	=3D 5410601.12 kB/sec
>>>>>>>> 	Parent sees throughput for 12 re-readers 	=3D 5403504.40 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  449918.12 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  452489.28 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  450883.43 kB/sec
>>>>>>>> 	Min xfer 					=3D 1043456.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU u=
tilization  85.21 %
>>>>>>>>=20
>>>>>>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver t=
o
>>>>>>>> the iommu ops"). Significant throughput loss.
>>>>>>>>=20
>>>>>>>> 	Children see throughput for 12 initial writers 	=3D 3812036.91 kB=
/sec
>>>>>>>> 	Parent sees throughput for 12 initial writers 	=3D 3753683.40 kB/=
sec
>>>>>>>> 	Min throughput per process 			=3D  313672.25 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  321719.44 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  317669.74 kB/sec
>>>>>>>> 	Min xfer 					=3D 1022464.00 kB
>>>>>>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU u=
tilization  60.02 %
>>>>>>>> 	Children see throughput for 12 rewriters 	=3D 3786831.94 kB/sec
>>>>>>>> 	Parent sees throughput for 12 rewriters 	=3D 3783205.58 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  313654.44 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  317844.50 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  315569.33 kB/sec
>>>>>>>> 	Min xfer 					=3D 1035520.00 kB
>>>>>>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU u=
tilization  58.90 %
>>>>>>>> 	Children see throughput for 12 readers 		=3D 4265828.28 kB/sec
>>>>>>>> 	Parent sees throughput for 12 readers 		=3D 4261844.88 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  352305.00 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  357726.22 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  355485.69 kB/sec
>>>>>>>> 	Min xfer 					=3D 1032960.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU u=
tilization  66.20 %
>>>>>>>> 	Children see throughput for 12 re-readers 	=3D 4220651.19 kB/sec
>>>>>>>> 	Parent sees throughput for 12 re-readers 	=3D 4216096.04 kB/sec
>>>>>>>> 	Min throughput per process 			=3D  348677.16 kB/sec
>>>>>>>> 	Max throughput per process 			=3D  353467.44 kB/sec
>>>>>>>> 	Avg throughput per process 			=3D  351720.93 kB/sec
>>>>>>>> 	Min xfer 					=3D 1035264.00 kB
>>>>>>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU u=
tilization  65.74 %
>>>>>>>>=20
>>>>>>>> The regression appears to be 100% reproducible.
>>>>>> Any thoughts?
>>>>>> How about some tools to try or debugging advice? I don't know where =
to start.
>>>>>=20
>>>>> I'm not familiar enough with VT-D internals or Infiniband to have a c=
lue why the middle commit makes any difference (the calculation itself is n=
ot on a fast path, so AFAICS the worst it could do is change your maximum D=
MA address size from 48/57 bits to 47/56, and that seems relatively benign)=
.
>>>>>=20
>>>>> With the last commit, though, at least part of it is likely to be the=
 unfortunate inevitable overhead of the internal indirection through the IO=
MMU API. There's a coincidental performance-related thread where we've alre=
ady started pondering some ideas in that area[1] (note that Intel is the la=
st one to the party here; AMD has been using this path for a while, and it'=
s all that arm64 systems have ever known). I'm not sure if there's any diff=
erence in the strict invalidation behaviour between the IOMMU API calls and=
 the old intel_dma_ops, but I suppose that might be worth quickly double-ch=
ecking as well. I guess the main thing would be to do some profiling to see=
 where time is being spent in iommu-dma and intel-iommu vs. just different =
parts of intel-iommu before, and whether anything in particular stands out =
beyond the extra call overhead currently incurred by iommu_{map,unmap}.
>>>> I did a function_graph trace of the above iozone test on a v5.10 NFS
>>>> client and again on v5.11-rc. There is a substantial timing difference
>>>> in dma_map_sg_attrs. Each excerpt below is for DMA-mapping a 120KB set
>>>> of pages that are part of an NFS/RDMA WRITE operation.
>>>> v5.10:
>>>> 1072.028308: funcgraph_entry:                   |  dma_map_sg_attrs() =
{
>>>> 1072.028308: funcgraph_entry:                   |    intel_map_sg() {
>>>> 1072.028309: funcgraph_entry:                   |      find_domain() {
>>>> 1072.028309: funcgraph_entry:        0.280 us   |        get_domain_in=
fo();
>>>> 1072.028310: funcgraph_exit:         0.930 us   |      }
>>>> 1072.028310: funcgraph_entry:        0.360 us   |      domain_get_iomm=
u();
>>>> 1072.028311: funcgraph_entry:                   |      intel_alloc_iov=
a() {
>>>> 1072.028311: funcgraph_entry:                   |        alloc_iova_fa=
st() {
>>>> 1072.028311: funcgraph_entry:        0.375 us   |          _raw_spin_l=
ock_irqsave();
>>>> 1072.028312: funcgraph_entry:        0.285 us   |          __lock_text=
_start();
>>>> 1072.028313: funcgraph_exit:         1.500 us   |        }
>>>> 1072.028313: funcgraph_exit:         2.052 us   |      }
>>>> 1072.028313: funcgraph_entry:                   |      domain_mapping(=
) {
>>>> 1072.028313: funcgraph_entry:                   |        __domain_mapp=
ing() {
>>>> 1072.028314: funcgraph_entry:        0.350 us   |          pfn_to_dma_=
pte();
>>>> 1072.028315: funcgraph_entry:        0.942 us   |          domain_flus=
h_cache();
>>>> 1072.028316: funcgraph_exit:         2.852 us   |        }
>>>> 1072.028316: funcgraph_entry:        0.275 us   |        iommu_flush_w=
rite_buffer();
>>>> 1072.028317: funcgraph_exit:         4.213 us   |      }
>>>> 1072.028318: funcgraph_exit:         9.392 us   |    }
>>>> 1072.028318: funcgraph_exit:       + 10.073 us  |  }
>>>> 1072.028323: xprtrdma_mr_map:      mr.id=3D115 nents=3D30 122880@0xe47=
6ca03f1180000:0x18011105 (TO_DEVICE)
>>>> 1072.028323: xprtrdma_chunk_read:  task:63879@5 pos=3D148 122880@0xe47=
6ca03f1180000:0x18011105 (more)
>>>> v5.11-rc:
>>>> 57.602990: funcgraph_entry:                   |  dma_map_sg_attrs() {
>>>> 57.602990: funcgraph_entry:                   |    iommu_dma_map_sg() =
{
>>>> 57.602990: funcgraph_entry:        0.285 us   |      iommu_get_dma_dom=
ain();
>>>> 57.602991: funcgraph_entry:        0.270 us   |      iommu_dma_deferre=
d_attach();
>>>> 57.602991: funcgraph_entry:                   |      iommu_dma_sync_sg=
_for_device() {
>>>> 57.602992: funcgraph_entry:        0.268 us   |        dev_is_untruste=
d();
>>>> 57.602992: funcgraph_exit:         0.815 us   |      }
>>>> 57.602993: funcgraph_entry:        0.267 us   |      dev_is_untrusted(=
);
>>>> 57.602993: funcgraph_entry:                   |      iommu_dma_alloc_i=
ova() {
>>>> 57.602994: funcgraph_entry:                   |        alloc_iova_fast=
() {
>>>> 57.602994: funcgraph_entry:        0.260 us   |          _raw_spin_loc=
k_irqsave();
>>>> 57.602995: funcgraph_entry:        0.293 us   |          _raw_spin_loc=
k();
>>>> 57.602995: funcgraph_entry:        0.273 us   |          _raw_spin_unl=
ock_irqrestore();
>>>> 57.602996: funcgraph_entry:        1.147 us   |          alloc_iova();
>>>> 57.602997: funcgraph_exit:         3.370 us   |        }
>>>> 57.602997: funcgraph_exit:         3.945 us   |      }
>>>> 57.602998: funcgraph_entry:        0.272 us   |      dma_info_to_prot(=
);
>>>> 57.602998: funcgraph_entry:                   |      iommu_map_sg_atom=
ic() {
>>>> 57.602998: funcgraph_entry:                   |        __iommu_map_sg(=
) {
>>>> 57.602999: funcgraph_entry:        1.733 us   |          __iommu_map()=
;
>>>> 57.603001: funcgraph_entry:        1.642 us   |          __iommu_map()=
;
>>>> 57.603003: funcgraph_entry:        1.638 us   |          __iommu_map()=
;
>>>> 57.603005: funcgraph_entry:        1.645 us   |          __iommu_map()=
;
>>>> 57.603007: funcgraph_entry:        1.630 us   |          __iommu_map()=
;
>>>> 57.603009: funcgraph_entry:        1.770 us   |          __iommu_map()=
;
>>>> 57.603011: funcgraph_entry:        1.730 us   |          __iommu_map()=
;
>>>> 57.603013: funcgraph_entry:        1.633 us   |          __iommu_map()=
;
>>>> 57.603015: funcgraph_entry:        1.605 us   |          __iommu_map()=
;
>>>> 57.603017: funcgraph_entry:        2.847 us   |          __iommu_map()=
;
>>>> 57.603020: funcgraph_entry:        2.847 us   |          __iommu_map()=
;
>>>> 57.603024: funcgraph_entry:        2.955 us   |          __iommu_map()=
;
>>>> 57.603027: funcgraph_entry:        2.928 us   |          __iommu_map()=
;
>>>> 57.603030: funcgraph_entry:        2.933 us   |          __iommu_map()=
;
>>>> 57.603034: funcgraph_entry:        2.943 us   |          __iommu_map()=
;
>>>> 57.603037: funcgraph_entry:        2.928 us   |          __iommu_map()=
;
>>>> 57.603040: funcgraph_entry:        2.857 us   |          __iommu_map()=
;
>>>> 57.603044: funcgraph_entry:        2.953 us   |          __iommu_map()=
;
>>>> 57.603047: funcgraph_entry:        3.023 us   |          __iommu_map()=
;
>>>> 57.603050: funcgraph_entry:        1.645 us   |          __iommu_map()=
;
>>>> 57.603052: funcgraph_exit:       + 53.648 us  |        }
>>>> 57.603052: funcgraph_exit:       + 54.178 us  |      }
>>>> 57.603053: funcgraph_exit:       + 62.953 us  |    }
>>>> 57.603053: funcgraph_exit:       + 63.567 us  |  }
>>>> 57.603059: xprtrdma_mr_map:      task:60@5 mr.id=3D4 nents=3D30 122880=
@0xd79cc0e2f18c0000:0x00010501 (TO_DEVICE)
>>>> 57.603060: xprtrdma_chunk_read:  task:60@5 pos=3D148 122880@0xd79cc0e2=
f18c0000:0x00010501 (more)
>>>=20
>>> I kind of believe it's due to the indirect calls. This is also reported
>>> on ARM.
>>>=20
>>> https://lore.kernel.org/linux-iommu/1610376862-927-1-git-send-email-isa=
acm@codeaurora.org/
>>>=20
>>> Maybe we can try changing indirect calls to static ones to verify this
>>> problem.
>> I liked the idea of map_sg() enough to try my hand at building a PoC for
>> Intel, based on Isaac's patch series. It's just a cut-and-paste of the
>> generic iommu.c code with the indirect calls to ops->map() replaced.
>> The indirect calls do not seem to be the problem. Calling intel_iommu_ma=
p
>> directly appears to be as costly as calling it indirectly.
>> However, perhaps there are other ways map_sg() can be beneficial. In
>> v5.10, __domain_mapping and iommu_flush_write_buffer() appear to be
>> invoked just once for each large map operation, for example.
>=20
> Oh, if the driver needs to do maintenance beyond just installing PTEs, th=
at should probably be devolved to iotlb_sync_map anyway.

My naive observation is that the expensive part for intel_iommu_map()
seems to be clflush_cache_range.


> There's a patch series here generalising that to be more useful, which is=
 hopefully just waiting to be merged now:
>=20
> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediat=
ek.com/

The Intel IOMMU driver would have to grow an iotlb_sync_map callback,
if that's an appropriate place to handle a clflush.

My concern is that none of these deeper changes seem appropriate for
5.11-rc. What is to be done to address the rather noticeable
regression in performance before v5.11 final?


> Robin.
>=20
>> Here's a trace of my prototype in operation:
>> 380.620150: funcgraph_entry:                   |  iommu_dma_map_sg() {
>> 380.620150: funcgraph_entry:        0.285 us   |    iommu_get_dma_domain=
();
>> 380.620150: funcgraph_entry:        0.265 us   |    iommu_dma_deferred_a=
ttach();
>> 380.620151: funcgraph_entry:                   |    iommu_dma_sync_sg_fo=
r_device() {
>> 380.620151: funcgraph_entry:        0.285 us   |      dev_is_untrusted()=
;
>> 380.620152: funcgraph_exit:         0.860 us   |    }
>> 380.620152: funcgraph_entry:        0.263 us   |    dev_is_untrusted();
>> 380.620153: funcgraph_entry:                   |    iommu_dma_alloc_iova=
() {
>> 380.620153: funcgraph_entry:                   |      alloc_iova_fast() =
{
>> 380.620153: funcgraph_entry:        0.268 us   |        _raw_spin_lock_i=
rqsave();
>> 380.620154: funcgraph_entry:        0.275 us   |        _raw_spin_unlock=
_irqrestore();
>> 380.620155: funcgraph_exit:         1.402 us   |      }
>> 380.620155: funcgraph_exit:         1.955 us   |    }
>> 380.620155: funcgraph_entry:        0.265 us   |    dma_info_to_prot();
>> 380.620156: funcgraph_entry:                   |    iommu_map_sg_atomic(=
) {
>> 380.620156: funcgraph_entry:                   |      __iommu_map_sg() {
>> 380.620156: funcgraph_entry:                   |        intel_iommu_map_=
sg() {
>> 380.620157: funcgraph_entry:        0.270 us   |          iommu_pgsize()=
;
>> 380.620157: funcgraph_entry:                   |          intel_iommu_ma=
p() {
>> 380.620157: funcgraph_entry:        0.970 us   |            __domain_map=
ping();
>> 380.620159: funcgraph_entry:        0.265 us   |            iommu_flush_=
write_buffer();
>> 380.620159: funcgraph_exit:         2.322 us   |          }
>> 380.620160: funcgraph_entry:        0.270 us   |          iommu_pgsize()=
;
>> 380.620160: funcgraph_entry:                   |          intel_iommu_ma=
p() {
>> 380.620161: funcgraph_entry:        0.957 us   |            __domain_map=
ping();
>> 380.620162: funcgraph_entry:        0.275 us   |            iommu_flush_=
write_buffer();
>> 380.620163: funcgraph_exit:         2.315 us   |          }
>> 380.620163: funcgraph_entry:        0.265 us   |          iommu_pgsize()=
;
>> 380.620163: funcgraph_entry:                   |          intel_iommu_ma=
p() {
>> 380.620164: funcgraph_entry:        0.940 us   |            __domain_map=
ping();
>> 380.620165: funcgraph_entry:        0.270 us   |            iommu_flush_=
write_buffer();
>> 380.620166: funcgraph_exit:         2.295 us   |          }
>>  ....
>> 380.620247: funcgraph_entry:        0.262 us   |          iommu_pgsize()=
;
>> 380.620248: funcgraph_entry:                   |          intel_iommu_ma=
p() {
>> 380.620248: funcgraph_entry:        0.935 us   |            __domain_map=
ping();
>> 380.620249: funcgraph_entry:        0.305 us   |            iommu_flush_=
write_buffer();
>> 380.620250: funcgraph_exit:         2.315 us   |          }
>> 380.620250: funcgraph_entry:        0.273 us   |          iommu_pgsize()=
;
>> 380.620251: funcgraph_entry:                   |          intel_iommu_ma=
p() {
>> 380.620251: funcgraph_entry:        0.967 us   |            __domain_map=
ping();
>> 380.620253: funcgraph_entry:        0.265 us   |            iommu_flush_=
write_buffer();
>> 380.620253: funcgraph_exit:         2.310 us   |          }
>> 380.620254: funcgraph_exit:       + 97.388 us  |        }
>> 380.620254: funcgraph_exit:       + 97.960 us  |      }
>> 380.620254: funcgraph_exit:       + 98.482 us  |    }
>> 380.620255: funcgraph_exit:       ! 105.175 us |  }
>> 380.620260: xprtrdma_mr_map:      task:1607@5 mr.id=3D126 nents=3D30 122=
880@0xf06ee5bbf1920000:0x70011104 (TO_DEVICE)
>> 380.620261: xprtrdma_chunk_read:  task:1607@5 pos=3D148 122880@0xf06ee5b=
bf1920000:0x70011104 (more)
>> --
>> Chuck Lever

--
Chuck Lever




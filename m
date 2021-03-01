Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE4328ACE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhCASX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 13:23:28 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:21772 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCASU4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 13:20:56 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121ICnMZ028285;
        Mon, 1 Mar 2021 18:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3qAabyQXXKp6G6gb4JtxEGHAGAwsmpp1s+smbaPDMbU=;
 b=SjCKbMEbGGQqRkOV5LubRJ7AJI235hmhh/0vmur1drNc3xIE1tn7OckK0dabodnkTikL
 5JBBiatSVxHmJ5hPoboAuuJvid+fkMDH/91u1vZOBb/qkGs3IXtIuQ3GglwIn8QvRcJJ
 UBPqSUM269fWKgpV+2p+wWHvPwoSuyE4AGa/B8IEDoM2P956q1H48C4/Mn2QK4wsZxUu
 VY0Au1q3QrR/4jboKXk1n69ujpHF+Fs2fnwXFtuec0PJlk+HyY/G8KKoo8IB8g08HTtP
 tF8pHijwAhiE0KjeaZGw7sFtzTf/1ywOt2xo5x/RFJk2UEcz2u50v1q0mHXVK05zy255 cg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 36yyf1cnu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 18:20:08 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id E90D391;
        Mon,  1 Mar 2021 18:20:07 +0000 (UTC)
Received: from G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 1 Mar 2021 18:20:07 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8455.americas.hpqcorp.net (16.216.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 18:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7S/4TvIrvjOovM5913bUzfFMOILF27QjTNIgNTUQ8E8EgN1EVHsnUpt5urZ++oLPfU6ezWI8iECMVK3QdW/yKv3paPEWN6gxomdIX3OZe7X0V9UVzZhOVXHd+sAJzizSX+Gq6vk4/6bUX/BEi5dVfDMHgWreJiTa7tXbIC8TuEC8Npvey8E2Dgx3kpfJ/HW21XlBYDbVeWaXcfcAE0SRbJqx05jrTmM53dvSD3nDoIiJLZ1mYgtTf7Mq5M1YEVko/svXzgFVdYjejuidEO8N7ez3IErJi8HxUE1M9yF5noKkw1xJzEs8F2MzAatsMDH2RHvejefDBeLCZ0OvBFEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qAabyQXXKp6G6gb4JtxEGHAGAwsmpp1s+smbaPDMbU=;
 b=JhO2OGdzEInUy5R/n7eetQZroWhZvPoYEbwMgtFKqenVcxQ85bJV8O3doDVUkad+aBZF5LMw0afX98wsJCKNV1buTyfZTV245iHn4DBhQiOykBVsb2XvcbIJV4Kka04NoCbOxCLkYgxDD7dMfnpFM1m/Qldm4riwRScF3xz4Hx1rvdhvhQkIjXG4vHU7rTegh/AV6JBv5DPn+WoqLkFcZ0gb1Z6NVV8c1MzAy8Jsk8WPRYxtd5NBl2CrdWLGQKz/MbtBxJvG4WMXUClfoB2Bnv7B7WFOvxdLxUXDatZgcIdPYmAXNx/GeNrLWLGCih9YWXm7+N5NXouSAwTfWrXX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0824.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 18:20:06 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 18:20:06 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Zago, Frank" <frank.zago@hpe.com>
Subject: RE: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Thread-Index: AQHXAyCaF7Pnm22S8ki5cQxTAbkE8aprJ/qAgAABNoCAAAhHgIAAkXYAgAIeRQCAAPBbAIAAnz6AgAALjACAAAej0A==
Date:   Mon, 1 Mar 2021 18:20:06 +0000
Message-ID: <CS1PR8401MB08218976C89D1C7B20394B4DBC9A9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com> <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com> <YDyWqLuRw33mU63D@unreal>
 <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
 <20210301173540.GN4247@nvidia.com>
In-Reply-To: <20210301173540.GN4247@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:10:422b:a738:be34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2537fcb-f3a8-42ff-8952-08d8dcdea441
x-ms-traffictypediagnostic: CS1PR8401MB0824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CS1PR8401MB0824F6CF42CD6E0EF8D2B8EABC9A9@CS1PR8401MB0824.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mL73r4uxOOeHXlkORyf0VX9/XjOK4oFuoXdp2YDCBcNZBmSD6loTl2r+WKUI65UEDrgEeKVO8peDk/70AMjZlPaH0k/zkRzJ1n65NOlqz4mEXUb6XMDi16JoS88QZ1IkP7AIYx8mfUWcn7KG2uBDY+RBMWNOgDnALvm2eL0pLIJERHMKsHxWdy5L8LDPKUp5D0Ffkt+tQk8MzeHHIZllHaIXfGsQeJv0M2M1sQhw5mA8JFc8TQb4sRiLSA7CMDWRTMRoFedHN/IAtB6vV5P1h9KXNbC7/wOVAZ5ra/foAKtxd1q1GjIVEujfwwVSjk4n+1ZABqf9ccxK1QZd0Fl5VawFsZ+hHYUEWz4/ORMAPmQzJtyBeBq7oKj05X3FfzIDZIJ9nMhqRt1/FROoa6ohFBG246K2sv9N+8swD0y/zbZavLOvxY/UC6URnx8nh4PrjcpQ5mgpXp07mBfwJ7wOXaF5AWS8Fm66V11v+jbNG8LII79dnQ3ibZoZtmyVfhzfvgqwkr8iqjydqZuHrT6zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(86362001)(83380400001)(55016002)(71200400001)(478600001)(33656002)(52536014)(8936002)(8676002)(54906003)(316002)(5660300002)(9686003)(110136005)(66556008)(186003)(66946007)(66476007)(66446008)(7696005)(6506007)(76116006)(2906002)(53546011)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bxa6R49sQqYIDuEy51CPQZ+7Forn3cPxaEx+GeRlb7zHMEcumLrw3m4aEmOL?=
 =?us-ascii?Q?f84SCMu9vXxaGXDfzNoIy20HpuAmZGIcimffWGcJ5reF7LV6flK2yZxP8/2w?=
 =?us-ascii?Q?0AN7chVtlqc1U9ooUw+fu+QeVoLgU11jL8EnqvWrAmm+XT1dTA4oyLkAPKhl?=
 =?us-ascii?Q?Czbtii9rdad8wB61kSr4mSypyvR0TLCTXMPHlErfOD936Wk2lY46quXJTLZj?=
 =?us-ascii?Q?XkmMEMWo32mTxw5XUsFVYPV07uyjNtcXghlWICHXkXB7E2nScmZtjSvifVYJ?=
 =?us-ascii?Q?FteDHQmla8Pt7Oely72FRqJsY9HPHU2De+tM3PhA4FqbKxI0edj82QJVjLeN?=
 =?us-ascii?Q?z9jzjhOUFTKyhheIMS3G9/S+PwPNwiwiYGUZzFb5ZHgTwbott9c0SasfNgOb?=
 =?us-ascii?Q?sBenXl5R6gIOcrfSXk8u/gRIK2pzPPOGlxIGWY2TFjuOCmig6hV9RevQp2Gv?=
 =?us-ascii?Q?c3XzzG7mz61vZz7RYSXG/ml1+WzRN+SMVKUrGZcEyo75xDq1aPot2KgD2OYN?=
 =?us-ascii?Q?E8DnDdT1+dhmlh3Lf4Wx2hq7nXuBPg+JammnCr5hipLZ74niXUBpRaaOqyHA?=
 =?us-ascii?Q?jEH3CCn3ZPI4Z/TMgsmgxsCUYx1jXU2AZYnx/UQIfd04AnLa2RER/3kNHBvV?=
 =?us-ascii?Q?CdZDUfej8NLSIaEXlVUUbEdzeDCmKfKFq/nId/rnXzoveGEaUIfPD54Ysjtf?=
 =?us-ascii?Q?HpMfBw23EYyiqletiuT8J41++TYcB52wkGRAyuj/8e78QrwYh+Q8Cm6QR74f?=
 =?us-ascii?Q?uRxxNFGFIVm35PZnWAg4MMxogRMduHUAW4vIzMbogJXy43er3fmNjdECtKKV?=
 =?us-ascii?Q?GmUL8xQMu/rwHVdO8PeV1Bw+AyZineTmfycPzZ61nYBp8ij6kVe51qj4HBLO?=
 =?us-ascii?Q?f9yf238JgRJtVpfWtDbOvxNXaXtLsny1/B2yLCeB/P4M0e5yt7QUrBN6Up2U?=
 =?us-ascii?Q?GpYDv2XCT1w2+RpLWuDurYLl3Y2+TqwR5Zkllq5nSYRj55++LdBvz5Amo11q?=
 =?us-ascii?Q?iLfn4AMmD/Lv0qO+k6NRyE4wgLzLlw8qC87adGVq30/FEDANZTBruOrVC2Gj?=
 =?us-ascii?Q?AfY98PSFa1xDNGRouJ86Ddl0AzhG9wGZcLAljcqw9n1yucut5gLivf15P9HD?=
 =?us-ascii?Q?xe+JWjqED43ZsttObBFaWUjarod2yHuc3ySTY0Sn4sYjGnhTDD1YwV7jebT4?=
 =?us-ascii?Q?KXAIy7DzvY0AzLla5PcdC4ZrDbBgrpXaz6BdvywgXy/vG9ZoFDJynvp9e7RU?=
 =?us-ascii?Q?6vcRM2CCIo3R3KaRN+GWDIxhMeYUeaBe9mIMl+QRv69tdeYo38sDSUOKIf5N?=
 =?us-ascii?Q?8xplSFEsnNx3eHPzyXqa4o9YPy40FqvEixshBs+uKD3Tl3fslS37DVmxhd2M?=
 =?us-ascii?Q?9Y21qbkLu8/yXQj6sfWPTFMY/r5L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2537fcb-f3a8-42ff-8952-08d8dcdea441
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 18:20:06.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu9ORIHB1Eif5wDJpRpQHrPR0AohSdVmGctCXzG26Vl4oQzB9Qe885jgKEi9XUB/Gr1obgApuc/mUAgmHX8l0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0824
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_12:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=965 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010147
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> From: Jason Gunthorpe <jgg@nvidia.com>=20
> Sent: Monday, March 1, 2021 11:36 AM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Leon Romanovsky <leon@kernel.org>; zyjzyj2000@gmail.com; linux-rdma@v=
ger.kernel.org; Zago, Frank <frank.zago@hpe.com>
> Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting =
(again)

> On Mon, Mar 01, 2021 at 10:54:21AM -0600, Bob Pearson wrote:

>> I agree that ib_device_get/put is attempting to solve a problem that=20
>> it not really very critical since ib_device is very unlikely to be=20
>> shut down in the middle of a data transfer. The driver never worried abo=
ut this for years.
>> But now that it's been put on the table it should be done right. A=20
>> data packet arriving is completely independent of the verbs API which=20
>> *could* delete all the QPs and shut down the HCA while it was=20
>> wondering around the universe or worse yet while the packet is being pro=
cessed.

> If driver shutdown can guarentee that all pointers involved in multicast =
are revoked before shutdown can finish then you don't need this
> refcounting.

> It was only brought up because the API that returns the ib_device from th=
e netdev requires the refcounts as it is general purpose

> Jason
Unfortunately what you ask for is exactly what the refcounting code accompl=
ishes and I don't see a simpler way to get there.
This also applies to the non-multicast packets as well but all the debate h=
as been about the code in rxe_rcv_mcast_pkt()
because it is more blatant there or because I haven't been able to explain =
how it works well enough.

Bob

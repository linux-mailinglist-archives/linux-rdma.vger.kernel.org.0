Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD25579FFE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiGSNsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiGSNsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 09:48:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82867E307;
        Tue, 19 Jul 2022 06:01:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JBB9km032511;
        Tue, 19 Jul 2022 13:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Tz4Phtc02C5x7X3qkO3iDTgA1dK20pGbSFpnYXi+J6Q=;
 b=e/QL42NGI+1f2Yqbhd3ASBao6Q9hf9GlJJ/oeD4eizPd+OwhzJEjKsc3v4KC0zlTfn3F
 q91GoN9mhOzbGlvVn95o4lG1CLVbmDhC079Jic5O1Wd9MGGErFK3rfEMtNbC1VnupxUB
 b8VzovXaPEXTAjp3RfVUk9xzG/BMOdpZ5/6mlMBdQQlJxyp1XFwm7n5CwDbe+aux7sY1
 RIkME4tnhy6B0CuX0g4eyiWkLLtyUwpWX8K9oOG3cHAHOpKJO/PffDTMPLQvDOXinAKw
 P8/UEqAjuQKvNXBhbpGlU/cctBh0rUbnPNTSXCRa7CdC3XQSjTM9bLKdUgpZsPQ558Po Ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0x9tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:01:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JBBGhA022260;
        Tue, 19 Jul 2022 13:01:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hrvas0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 13:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iID0DA1z2gnljcEgN58Ar5Bw3RTNe3JQQpd3bXCYFSm9ElOaO8mWbrIer1E38egb67yBDdSAnBAv58u+R8zza0gEXYDdOPrabzsUXUxJ73VTHmpgheWn2BH/HdegEWQHO40mBYOtHnAs010hoSONA7Fjg+L3gOYwZHntA+IqO6W7OCoN07rWJzKaYO49gyRJmslQ5AKGZBzysb9Re0cUEo0qoFSR88Is0aLsYjtIBLBzyldemNuCWnJkhrx9iuBaLOh2AbKshyKwEY4cdEXuxLEjZiARYPXJkfBAjiWYtpTXQMmvcus0Il2s/2CbqOdcGNlJ3RV6RkXXoqPPIlk5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz4Phtc02C5x7X3qkO3iDTgA1dK20pGbSFpnYXi+J6Q=;
 b=QcVTfhoOAxCNQT1Xf2SG7k47Dld6h9Q+Bs3lc2LWzo7owToqYXCzE06zvmyOhbULECLeCYn2LI0imEgAc6ykzip/oozHze4l4Uzc6d9xgx/lt6LUqAFEXMKuDOWDg0sVxvWpuGJuyvwlm60+8Cc52CVqZulbj13P5QE6TdTl1iaRoxSKkivI951uGX0Wob9COLpz+Fmukmh+Jd6SoMlqrtQkce2byVM9nVMx7XXww7caSknUitQYITtxn7uFBx4rZzmrrwvQxg3YHWZX2e0sXdoiFFp+51jPEarDGhOxvR3CAq8/W6kWg6pT1MCFh1LOZBU8+maw42eLUTDyCrh6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz4Phtc02C5x7X3qkO3iDTgA1dK20pGbSFpnYXi+J6Q=;
 b=FfkOrTHtVhjaoDI9mgmJxHTy0uba1NIvxTL3klvHJZyWwKISnp59/IVwZC7lwNiksaS/Xs0bZSlEVjjWdonyd2ZV1xQRzK8feeIE2b3sPegmckfXLQxD5Gz8BcU34sExIksyUsgfmpkNfZwG3LT2bmSQiCuLgufZXKxwJwv2DMY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB6278.namprd10.prod.outlook.com
 (2603:10b6:8:b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 13:01:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 13:01:36 +0000
Date:   Tue, 19 Jul 2022 16:01:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Message-ID: <20220719130125.GB2316@kadam>
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam>
 <20220719125434.GG5049@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719125434.GG5049@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a42e2bb2-f396-42bc-b8af-08da6986cfb8
X-MS-TrafficTypeDiagnostic: DM4PR10MB6278:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4BLnrrdUOKf5L8uqPV4E1iP4Mao0ZIyIVr1Mh6xnPBQyw5HlZktZifTGRWTB/WK6b1ZZCm8aCVhiscoTHd5ojZwV50GlKDnV6GifOvGg/xvEo85l+nKpHcpvH2r/k6wIjv5q3Gzjy4F8Tmgrsk4FVTSPqSnT9yM0PQbPM+t27+vrGWhf01jxMsz/T8IlTJzRZJeCru/o46eLwsBw87lF5A7an4sTd10nh6rA2k0vnFJy502suV6oQtwYRAYB/+rubPZ+pxBo/PAauxVhWGLANt147qm6mR8jsuv7i2RiCC3e5MNEa//HSLH+dJjAefDUEhxKjldtnfroyatduLAftVAphX2at3CRqZREqhH4X4OENiw6cE1OtfN+Y9g3EyrxlqljWR7O/nk6BXsBkSKzk14s7kMtgsRHyL2EbIxEEYxYgV8dA6cAmPYa7/BxM2B2L9aDWlhxE5TmzZ7ANnNTcMBehFttVztheMRPuZIuzXaJOCXh45oXblDdU5tIfosJmu6K9oG2PHWJcAap7AgctAfUiuhCFY3fqkjpUQpy69KnS1xWJ3WqEMn9rsY4hhTjr9cB8Tv3sKlaaQ8zz3fmJIyoqPy/k42Gs9bhNqUWWfowpbiaFyurOUDhOKaRxOUppOC9051xzBN5+crYEH17251OASoDY12ibwdNPeq3Xvq8HUvH60MOWAfVgu3YyU3+sdOggJrAln3IxkEaSmvRVMmuLcyZHHhjCrKmtti+tCHS8V9KfNg7OEcmmbOBqTXys00k417Y++mEpHJ9VPRUFSdDhLH0N08xrDWUtIsgqoKJOYhg4Vnkop1FfgY1bWQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(136003)(366004)(346002)(39860400002)(2906002)(316002)(44832011)(8936002)(5660300002)(66556008)(86362001)(4326008)(66946007)(186003)(8676002)(66476007)(4744005)(33656002)(9686003)(54906003)(478600001)(41300700001)(33716001)(6916009)(26005)(6506007)(1076003)(6486002)(52116002)(6512007)(38100700002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4PHoOzhdN0zZnGjlFSFjBUzw7n+jIW6CAQNGdg8MU/E+IfNnYFHUxbpCtyv?=
 =?us-ascii?Q?D1G+4vdq2sv1j6XRKS8HaA6ewLC4Ph6JUjiIqp0zTfhdf0793mP00yShb+ie?=
 =?us-ascii?Q?vpVIpecpVnOfEqG/dmZnY4QGmxUgB1hu17WaTTNyswtEWarfkCuBqSnnaCpR?=
 =?us-ascii?Q?/cCmvLYfdp+pCli8WeeyCKLNs9M8qzrx+jnbJkCttjl4ecB3GESQJzdO+XxM?=
 =?us-ascii?Q?B+WznrUA+x2FMJXJBlIzFmy0ozACFAzs4zYzT/sDalNgQ0UWcYd3e9VLWne+?=
 =?us-ascii?Q?ynshBShcv8aCwk2JFtooIxls2FOjVLvcY1qfYsFsUC67lC2fPBwbjnI8Howp?=
 =?us-ascii?Q?dLwPLNGQOdMUfxzIc1x76Kc/bohNZmJ7iP8mCsKGkmME4ENfFPX+0ltElT1x?=
 =?us-ascii?Q?bSRk8Fk8zqpyQOVtR1YbM1IOwYcDlNucsJwaq1+G7andPHUYlb0p6kfAbDzj?=
 =?us-ascii?Q?1jGDa7b8UK7Ks6VqEj8RDQi7MwNWkSpCZWBhkAszXw5jT5f/3q8GiOQmM6o5?=
 =?us-ascii?Q?ZrVXUJdtvOzGWd+KozLlG/gJSgASD3GSQRldTDPOkTUNNsxhhimOwa1xo+/M?=
 =?us-ascii?Q?w4Jw0NRxpix+RkEUmfZHL1VByFQJvFCOab/wHMsPlGBZrHulEJULVECPVzjj?=
 =?us-ascii?Q?ED+ul2HOCuBoGHnNHkv0gfWTc9DD6JjGj5Gtb5KWEWLdc3+bkTEm+k/KFHje?=
 =?us-ascii?Q?PUwGysEMl1vWYZSfzOr0Px6ajuIbvFvgp+eunzOWi/zmAzZ5SOHB5/71Twik?=
 =?us-ascii?Q?lFCPojM9DCs4UFwsFk3ZYL/rSJrZRVGan++ZmOSD/Z3XY8WuVyBJAN5Duy9c?=
 =?us-ascii?Q?QLkXIOQ3KdbBRqn9PE9EjV+CKV9FdYdzhFvJQgMhMqDiVJxSuuZzWznZmIHV?=
 =?us-ascii?Q?BRFAWRX4fY2qrEqS29bJqxfLskCzKJdP/zlXOzMoDdMIf4rHDEids7Ce7Ms3?=
 =?us-ascii?Q?YItuHV47mLh7jIuYouQ9s6XWPvH2P+jY/E7GjHmxDdlX9iMt4SzEWSoDrZVK?=
 =?us-ascii?Q?KJy9NIYMBWtM3V/tfkqocECSOZL5VIEAVdUQbHK7F/gTBCe55zbDZ1y+u/rt?=
 =?us-ascii?Q?nhqMMDK2vepUuBMCIsJPdCmhO0twHrwryK4D8P1doeshWtqvW20jOyrCFw8s?=
 =?us-ascii?Q?G+PmEWHnTzMxbI3oASfPtqd+b4caf4ZbseACgNtSU7g8f4MGAXT9hz7r54ce?=
 =?us-ascii?Q?ZG1vPDVeR7xNUFlnbLL7w0xweUC/c98VrQfo2t28D4YiSR2rTx2CdKk1VrUX?=
 =?us-ascii?Q?e6K4RuX2vuMtL9GequJc//k8VyJXOqdxNjFdHl0u6GYOWXnpXJ6Z3lMU5bXU?=
 =?us-ascii?Q?MDXsiHpck8ZEyWO/m1gu8g6+mFAOO4ouYdshmM35ubCEDgaonN1skZMH4AV5?=
 =?us-ascii?Q?sILFEQFifKTuwYZqulw2QQi0tPgTBrYWV8O1wkudJFScK64GK+5213Hvxwov?=
 =?us-ascii?Q?kotyjQsv1vndkaAeRaIRbQDS7nuIZOfD+iMGgrY9qQhgwSFgV4FIFzPyKCUp?=
 =?us-ascii?Q?H9EGxgbLKT8loqDfguGuPFhnlthG0gfA5sEeNyKR1KX1dB+LlOMJcLKuAjnE?=
 =?us-ascii?Q?4id3tmYExLasY6CDQTeEKPDdrepLzgrrubSNsXoZD1JLVv5tUyVPxVOzHDMK?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42e2bb2-f396-42bc-b8af-08da6986cfb8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:01:35.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8wc/4+EfYlqKaIlEUwwO0To68FZW7vhNUAaIav+IEIv+hHyxk5d8ajvYT6QAnAAjEZPXWNS++symvrzLOHEjcBflJ7c1TMJOPpVFq4San8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_02,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=746 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190055
X-Proofpoint-GUID: z4W_vfBI9idlnc4ZlDxGdBoLsG8LPx7v
X-Proofpoint-ORIG-GUID: z4W_vfBI9idlnc4ZlDxGdBoLsG8LPx7v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
> 
> > Best not to use any auto-formatting tools.  They are all bad.
> 
> Have you tried clang-format? I wouldn't call it bad..

I prefered Christophe's formatting to clang's.  ;)

regards,
dan carpenter


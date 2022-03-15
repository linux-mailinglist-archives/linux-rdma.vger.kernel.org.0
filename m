Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66554DA62E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbiCOXVb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiCOXVa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 19:21:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DB5D669
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 16:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMzar17qBC2s0bEC3nw2mxA779C1hDSEbgdQYKRFvdPyaL/O+PCyxEHfBCHAWxT8WIZKjLL+NVAizE2R12hYgdiDB+ZACQ6tpgSEtJFTq3TVyp7um1YB7CIYG1tZx7eq9VE7d8/AfB/6UR/rOuY69KKkNG20VpeHH/6fYLOw2ZvCwR5K4lnV5W0+G+TzCcDEzxChrEqcs7Ji3FvwR/SO2fg6AuQFHQBp/P3pomlMYeM4Y4fWTC6kob8M/mqA4LB5m/mdEKLV+rg1t6I2NSUKNdEblB2LHLVNUrIa+kggjUX2HQHGxg82fVW4NmIonRZUgPk/3vQwepH+rHgFlTCF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzrOCbAr8d0JRMrO+uh8oC+V0co4H/ZSCKy0il2bOIk=;
 b=kz0tmuT+OOLcyHewgB0wkHHjLgCvbRYMFbFds57GkKNgsDLWorapbIvqkxoV+q+r8lum50RAA2Rq3Q12Vt8iUHYCcrK9O/owFoqJM3a6crfVjuwAJ9hLwfAxrutML6/7qtWaw/wf7E+0WL1ANrFS6FIzh8oUr/iepkI5hMLmzKpv+k8fSWdRzfL46lPqtaHYKqXzHBQ/3+MaFHTxt5L4JQiKaQEMQSD3MrdZAloJ10W0KXSB8Ozy6r7QcRg0kvlUnQICBzgN/AezekC2C9mEgBWHWciFrtE/Gjn1qiMJWp1mkQTf8OOrVPpoZ5deQciBVku58jyOoDVtAyr1Yy/cCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzrOCbAr8d0JRMrO+uh8oC+V0co4H/ZSCKy0il2bOIk=;
 b=Yav5Gctmev/JN6LKAKDMF01fwgMMTdCTExrG3ihOteahw3A1A+tyM2X2i5Etsf18OlFcUhESuiy1K2TbVW3ML+7NsPdw0W0UJT6yAMIz5jE7GXRKZ2ngQTRWcN5Kr78MwZQShkaTlD9Rf1NcS9yjPPb3vbeVIlz12ymKoKhjEiXsUeUfWVAIruIH2wbTks9yc+dA6+sF+mosBC91Orz/p903n73VyGlf48tjPZgiO1hhqPWOJQ7UYDFkFB6GG7tmHXQA3pbk21HI8AX8w4h3NnoFURn4yYjXtltEXFN7dynAlLYINodz6vBBat+XUYBKBpLbjJBa5Y5Uj2Qsti7bhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 23:20:16 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:20:15 +0000
Date:   Tue, 15 Mar 2022 20:20:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [Resend][PATCH v2 for-next] RDMA/hns: Use the reserved loopback
 QPs to free MR before destroying MPT
Message-ID: <20220315232014.GA263532@nvidia.com>
References: <20220310042835.38634-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310042835.38634-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef5fb0d-db98-4736-df24-08da06da5ce1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1843:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1843091C009ED88CF3507DA5C2109@BN6PR12MB1843.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShfNNz3FfTlMiKHTOCruU4C0/XMaODhTdP98jtOzJzqUjPo8lUsZBOrWLjju2+tO89xrnB+xm8Z7LkxgpdJqNwhJGD0eMMdJ1Vm2FwfJ6mdx0vXdzGkQ4l+V62UovaQkTQqPy9GIS52ow6lQBk4J6kMkSCvRIpjJ81A024cR+zAmwN8F9TiN47gUcmPRbug+RpGlTIMmM2pKGu3n23PH/sdvSdnOI7uWkdsVyJwIDAIhuecpdzBP0faVOPGr8qFj2Mii2edQ8dC9ASf4ONEPQmEi9DZXe+SRt7ku+jZxTc5PKxmkoKoqP5GDCYNZwRga3Y+xpQ9WEQciBT20Fy01k+TqRIXOvj/6W9gBSRxecrV+YD1L+LBuszP4UT9Oi9PHzC5dB2rAy8IISnBj1tuIfLch/2VC1jaq5M7Cvzyylu9nbkcC8elZV/e29Nrh+YeC5R2rIkoZzW+MDxWDKDILAM4SSDjMQCMUNxeoGURrW32hwuP6qKIEX5fuvaVgqPEc/7pZH5a2OVLjOwda0yl2oYavIcdqiLeCo15mdG1fKvuFRGtWkFvmSZdQtfQdfeYbzIh/vlT63NjZK0ITVkjw3rRU6D6rIdusTSW+G5petUMLeLyqpL3Vc1HFxkGCfsLO5W/IDvX0daujHHpHNf1PsDF8f7QWagv15QoyNccsrA8diM51AmK2kqQ9cW/MUD2DRxLeiaWGl7Z91m93HHVYNov5dcwnwyerHFPiRmTgC4U9I0n7SPpjcWCJKSgnIKaNjX3DTgZ8emBRRA74yZEtHiM2QqOVgaQ9llG0oeknQhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(2616005)(26005)(186003)(6506007)(6512007)(2906002)(83380400001)(4744005)(5660300002)(8936002)(508600001)(966005)(6486002)(66946007)(66476007)(6916009)(66556008)(4326008)(8676002)(316002)(38100700002)(86362001)(33656002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBL1KQHofCVulsptiSmg8wl3qwZQsg0uRIzZEliYQ7maULY4pHBI0PLGY3d8?=
 =?us-ascii?Q?rxxKGnPUs3jTheOBpU33xz/NKyMFwyL3P8CwpCvpv7hbpCWc9rKM5EjQ9Jsf?=
 =?us-ascii?Q?eNQ2SEKWt8g+fUlnbxYmRu/eRywSCSR0e85uI6SnubQcXgX+sjZCthJZeuBo?=
 =?us-ascii?Q?rkihDSX7SHNl4uxdvyviI/9jdOSPHI6XB9MvKf1Jaoo8p51yhuEJlj+jopue?=
 =?us-ascii?Q?s5G5I4C82W5Ouzxe7jaWl4L+3arK1td0vLmv8TuM621s1E5CMEbBz5lHGIdv?=
 =?us-ascii?Q?c+cEHDan3JfZzwvEsw0Qsh648VM+pkUXTDJ2oM9cge6kWLPCGbw8c3gccGlh?=
 =?us-ascii?Q?x+N7gdyEN+l5i6smIb2GQZsRiIQaf3e//X/kNpX5s0I98y6h0/TgSN2I+pTt?=
 =?us-ascii?Q?DUyPJma63+qfbLaF1nbCqYSvK3CrKxfgYTKpQ67KRaeVmjdcTPKwI9VhQXq6?=
 =?us-ascii?Q?vBLb3zVjWeh6a2vKeQmWPLBEtVJlb5Y1HXoEgMrH6hjjV8kLoO6Geo+9B7mb?=
 =?us-ascii?Q?O3NX91xIWypxnzOHRrJThd1jz0PMbf7+4SoajeVbWiA7A4YdKhg22NwDJfbz?=
 =?us-ascii?Q?Hw94Cr2vSAVRHB/CB8lVTDx1HwT44eU6HQ00t8di5trK2S0MXoeqKtFX5jNd?=
 =?us-ascii?Q?TLc6oNgxTGL68wKFL48i5t9csqGS4MaiMwvR/AyPC2r+1jnEiQXYFfp/vGye?=
 =?us-ascii?Q?U2lL9d3qI7lRVSQL/VeO12R/8r/beM6Au2EmQ+5UkjnE+wqblpU8hbNbgcG5?=
 =?us-ascii?Q?rTjmDDQr4g85cMBUv6nMnyh/my3Q34WoeC2KvPxM6AyWcVEpVVt+2/EmaOGA?=
 =?us-ascii?Q?mG3UnEbue6YZK44HEcKJfI/hXhocDKE/T6bXdEmhzOxAXAO1Ek246bgThawi?=
 =?us-ascii?Q?GZs1eoeXGl44P4Ehxoeyd04SXS8DwPEJL56Uk3pz+SU/EbASOOGgXlAELyB9?=
 =?us-ascii?Q?+LTRhcY4rXc2nYfZjhkUOPRHikhCLiXD0mr+L+7U3Adx78Vpzg7gJcL2u26I?=
 =?us-ascii?Q?N1FltbQ8HlmIanBH8mdRCpyk9BuxVUnCCsPGErvOuS0IdHDcdEa+gwn4qIRq?=
 =?us-ascii?Q?lAwkZOexd/tWfownrbh8nlR8V5Il1JOIEMDhHIcCP3ymRG5lm81BjYDXQQV0?=
 =?us-ascii?Q?uf2pNAUUBViWmJfAXmw0tPC+SRaLAjJrxBl0DEh6OLsGmvFxv2Pbaqxxoyu3?=
 =?us-ascii?Q?2WrgxbCIhLDSCv4e2VmKfJtal7s0cYdSrO/+CeNRX1WHCJVeqMyMogcBX8Dx?=
 =?us-ascii?Q?I/f6rb7II3TIsu1UCl/9d0CNeh+JZdOKN1mSvKKgQ4xeyYRA3iGdpNcLDHrW?=
 =?us-ascii?Q?PILM6vbNDUVGTuVjmg/hhmAeEzO6yR9ANoKJw4cAhYffHN8ZsmqKgbxi3Enf?=
 =?us-ascii?Q?6DwMxlnccVrVVuUpTEa0AA6McYEDVBTP2n2lHPG+5BMfyL+eC86ek5uUcSN4?=
 =?us-ascii?Q?38faW16Ip+mtX5I96O7K0N7N8Jc2bm+U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef5fb0d-db98-4736-df24-08da06da5ce1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 23:20:15.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGXw1JxJopDbTqNIZcjnweVDHcHkWomaVWG6H6UnyXhbFC/dlk+0Bpnx8JsBejA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1843
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 10, 2022 at 12:28:35PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
> write operation per SL). Completing these loopback IOs represents that
> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
> 
> Changes since v1:
> * Allocate all reserved resources in one function.
> * Clean up encoding issues.
> * v1 Link: https://patchwork.kernel.org/project/linux-rdma/patch/20220225095654.24684-1-liangwenpeng@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 311 +++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
>  4 files changed, 335 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason

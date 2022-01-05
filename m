Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555514857C0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbiAERyq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 12:54:46 -0500
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:37856
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242596AbiAERyk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 12:54:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIFQv7wJWI6Znnsn7PcASTK1WUC0171nXaWYPJ4WZrHmYWcEWxPy/a6sd2fvERh+5LTUCj/682OmRAn0RvTUphgM0GK5Cfdx4WhSYjm9ky21pu10DIlYY8UexaLctlsK2LnZpUnOIhpDQa+8EMCv5VA2dbUOwC5r3/KFlihliXS5OI1n/Ve4YUPH4wg3RWETW7RSvOI1EWqULPaBY64TrLckBo0kLMzKHG1kJq1ix3KeZAf41hDUsJBll4+i0fKjrS1cIVWyrILyRMeBKHdkEmpOIqVeMvnSvhv9e/77kStwdUR+tw1Q5WTcDjdOWdcWE1QptXt5Ag2sK+fm3ifcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTE0zJLepjNx0tId+Tpxddmk8tT+tUbN0axQWmBrtTE=;
 b=ildZ/OgUQIg088aMNk+iPe09UE2cSzqavYCaoyIHLSMh0pVwjlla9+4oWCOfmxN15LoTwgxU0/8FuAPuJxU+1w3UUAshlgXqOV8HObosfH4BE6l2ErXIzRczryejP2onXGM96MepWX0Q1yAYYrxUBHMD8IyvMAUSdcoF8d8f3z0/ebzesayoQVmGqatUNHdREO3pnIBBr/47xbnqheq/PFcmOTMHbUh09WcrucPpWofc5TFdWSwjTrPZF/EZMJp63xinBcLloIEn80AwV60S/968Kwb8sTrJeRuxD5ItbtNv0uWon3pIr+EptVAxZW9u9Rrfbc74p71sK/GaY9zPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTE0zJLepjNx0tId+Tpxddmk8tT+tUbN0axQWmBrtTE=;
 b=KacWi1d0pskKEMv0XtbAlcEHjDNp2p/fh9QrbJrAhVYnRK2XaOZdd1+bFefedeIxtnxTYc/S/qtTj5jQhMl6duy9FTyX2TAYMMiVexgDc/LPN3dqINqeF4nTU8N2AYS0qJz6OkIbVUceEA8AZyBn2lMzSOsDGkERJuZk1t9GxMJjNeChZrFDhRQKvEoLINkqedWdHwOKJmHXfGAgAU72PuMC+JEE8PqsTKS3ROvpNwpR8Msw1GiSqB/H5dcrCZVQDdJcg03BZMST1oiPuEe4C/m+d8qmk2MnF2nrzTlzOQ8pIofW/LioM2ddSG/qrvtRSqAVZ/hGzdKBGaSFVv9BqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 17:54:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 17:54:39 +0000
Date:   Wed, 5 Jan 2022 13:54:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     cgel.zte@gmail.com
Cc:     devesh.s.sharma@oracle.com, chi.minghao@zte.com.cn,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, zealci@zte.com.cn, zyjzyj2000@gmail.com
Subject: Re: [PATCH for-next v2] RDMA/rxe: remove redundant err variable
Message-ID: <20220105175432.GA2844657@nvidia.com>
References: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211215075258.442930-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215075258.442930-1-chi.minghao@zte.com.cn>
X-ClientProxiedBy: YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6653dce-aabc-4fa5-a097-08d9d07471b9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50647E9EB64568A36785BCE5C24B9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yTxVhgpFB/NKAz/y/XEPCRk6raEArCtTo31lYyjTIoVEAOu+W4+4r+Vss860HZEq/E+X468Ibsdsj3pEEl6uEftxdtZ/mnwrXrV5vtYZ3pEdDycYXD71sS6n/mkIiZXkmkHaH5/yTo9+C6T3mt/HwNNkbW6PDcdKqIpMl7IFb5Hh0X8VqTz2lsIucov3EaKrh362eL/2wL59G2dQWbKglTatL7G5dvMfDGZV4UcSBy/r/F/dTRppbt/L4SZUQvPfPemcMkW/O8igjRR6J35qkUOplKQ4ZenjpWja4AkTJxIyOSRpxj/5oA5RdWb311jbsbSu7Lcg6NWmmUKaugxZTJKsVVYPZoVJx0tRVqr5KyPxvY72UHIwjErr+h3gwRUL+6wWKxeOHytPf7w4IFn/dQbdeH4lxdzjEs9CdNnK2r6uKc93Zyyc9Gh05bKbBpLNKSymoB4PfDFzC2iBt5YVf6kft7LPSYInk54ajB1+EuxUhIMh3P7SlVp5Q5MbfLvmOYPcTs/oACxqlnFcCqclpsMmKd+pvY/uGZTaGSyveo/SnZ4+qfqwPZyq01uWMAmT46ry7/kmDXexvgzm0k7Bbe93Ql9RQkYyVdVDjIH4VOqTXFbX30XKSAxDWaLMWpIOHr6/ihqzUx7052W/0zWMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(2616005)(83380400001)(8936002)(33656002)(8676002)(5660300002)(6512007)(6506007)(4744005)(66946007)(1076003)(26005)(66556008)(66476007)(6486002)(2906002)(6666004)(508600001)(4326008)(38100700002)(6916009)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9/y5x1HY/lQl0gc5hai4aGlvfmm1v5VtUVThjlb/a3WTpqHJbMCmgY7PTrm?=
 =?us-ascii?Q?WwuM5V3pbLy6nMuc8l6TtYtMdyuLEd90ZOuYGw6rQfDl8ZgOmCVLe4aVDoYE?=
 =?us-ascii?Q?kdMdcvsgslWzkaar1pmyQK4nurSp8gQLWetbxfJDJFf3+e1GofMcG0rvIdMo?=
 =?us-ascii?Q?dUp/2xP1ywiVwHNhzJchgSGM4PKy7/hMfICv6Rulfc2HKZXl262DlabEwshs?=
 =?us-ascii?Q?hoZ0N+YGgIvC6tqpfYw0TF41z1uqK86Wmu9hWHj6K2eisstfh2NW6gh/8ovM?=
 =?us-ascii?Q?A2Iezj6UM3MOZjbuHTEdDsEkHdpYIKHcsYtlfXhjqHbg5l7Eh5zUPiTeVRzz?=
 =?us-ascii?Q?myjl/0iJLgCSonJznlY0avgsI9WxqhzLn2TxkNl7MadUmrf3DlD42Z+WQIot?=
 =?us-ascii?Q?3h0ecFiJtmBUXreBhbM8mhp7xL3U4pd6LiGavV+LcassEG/NoCu3cDX2dmvZ?=
 =?us-ascii?Q?ESFh3HmjyQBrzKqDFKatioGtwzqNmX6CU0d97ImzLS501GElAhmSuYI4XxTM?=
 =?us-ascii?Q?w8MI8rUMWKsbznuBNvV6avkBSR4okgulWsqabJP34UZtjg7ZFJUIiC5CONLG?=
 =?us-ascii?Q?ffvvyrOFnMkgoh6OBUwQRQ0mH+wjK8a2/voXmw+KE0YFAS3GR+Xim4StnRb1?=
 =?us-ascii?Q?6aAkw56kDgPHpiGDFOoUu8Lv+S7NxNxaF5g2uq23uVt0YjNFLmdwSVU9zHF0?=
 =?us-ascii?Q?RqnsRQtLkVJqbNwMpt/U6l9dWcYpRfA+Gw4Yfjl1cyqYfNI08A4yZacpaFju?=
 =?us-ascii?Q?3X/J/lZWK9l6fp8svRa8cMNfcel0SSQOFUz/xN7pVbeucFmOfhObeISgw7GJ?=
 =?us-ascii?Q?9IvjSLj9hpR9Xw0tChGPmoVGjq3whZ7IkQOf6qfvViIprYtwE5BQBE+o/XXl?=
 =?us-ascii?Q?2mEtVYuxpVkfdjgSCXVfesUR4rNVQZTUPkJtWO1U3kyAFyBszPo56Y9RS+rn?=
 =?us-ascii?Q?PdQgNpqRlc2XLmXt8odKDAwWcZT4npah/7Bw3tWNmzOYGIKSNKNBDAqrDXnn?=
 =?us-ascii?Q?jqPmAPUGwlkbxlCGCOTuyAb2/PhqiYactgB960rQJPwXZwstSVGDjrvGshb4?=
 =?us-ascii?Q?GU5Xfew1N+b+HxSaj2LCZGq60pcSMliejX2UHyC9Z5wI9CRHkekRdVNvnjAl?=
 =?us-ascii?Q?KmVmrOrcZZ6Yv4JwOua5egVBzcF8TmfFwfkaonbCapCUgEzMh0tYPOBjL/ur?=
 =?us-ascii?Q?+GZsL3UWsWc6IW0wYERbD54GZlwkWk6hW9QVcG/8wZjrrWw2n6prjyu3mfzS?=
 =?us-ascii?Q?UmnsSc/Pp9sOtvwhnEuO95tjR09NdYfS4tYBZwdm+UfvQumogZLP6EjnO+2d?=
 =?us-ascii?Q?fgeuoFkuHUqGsqOwklFEkzdge9+Wr13TO2D+d6NUVhni78wtGT/iE4ypa3XQ?=
 =?us-ascii?Q?gctmexQ6U1/Znu2xOC3XcfP2zhsmFfVH4up/dRu3RC3sjEFftrpHTFyMrAv+?=
 =?us-ascii?Q?C6kUNMafRTk3JK6wdr0GtJ1A1vzLZAwcFFtyj2Xy33Ks4Gp6zJkC6O79+HFG?=
 =?us-ascii?Q?eP6Au/Hw2EZeG3Kvh/XVw+EwGVQI8LGi2bIOIr4Njgc1UEo+cw+c/6lWYUGT?=
 =?us-ascii?Q?eB0vCwx9n9Tyn9Scamc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6653dce-aabc-4fa5-a097-08d9d07471b9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:54:39.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVQ6cH5jzWGzK7G1gjaXvBMt3w+DXxflIe2EOAhtD1HIoAyVLqucL2kL1cmkAlds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 07:52:58AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value directly instead of taking this
> in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason

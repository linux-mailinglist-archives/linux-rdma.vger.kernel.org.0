Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525B630832
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiKSBAi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 20:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiKSBAS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 20:00:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDFC68BE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 15:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0SAcOiZqp1e7ouhxMMxLrytwUWEgEd8nbf8bp1vorrIoXo2G9m3J/yAojwbs8Ugx/KvVNoqQnmQXdmrRACfVubTZq1TE7urgjQE4KGSzibdrX2NDsM+x/s34uoZ2vDEfU7K48EfhwYguXe5nb7GOTf+LJMRR5NaFJF+uXuZ5z9wcKS44BoRcHNU+dGfPPHLc0pW3bnH+fQpR5kMF8HLnvAvuV3lPNHV/5vTKwZTJtrmIqWAUsA1CygCdGjL+QYJl74PNVxyuHpkJNDRppKKZte+Bp7v1+AfMQkiqhvvbM+aK78aQYTvbze1TsLVf9cwic7P5u42cEEvxthA5NrG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSI6PHLkkNBlUWhYbcH51wMzueQCyDPXAmboqWnNWak=;
 b=dqJp8hVHQ8qt4zAWQMoHfixzso2cKUPjWjN10HmlwvEQ7ol0aYLDBxyqLBncewpdHISTRzvBoCOuakInDEqDfM1GDhlYsGNE3VdYHipGhrqnXtozRNOFsuzPZJubBqnLk5utWrCdgHb/gjwmMklY9tKFz92PT+qsR7Jfp/WCMgVGZwetJApSyiLOQHmGKQxsAOt2sDlIeH8M4sulOqjvUd0hHOgw9Yzge7ytEDS01AplNbIJ+PRzSjPU6yAawCO7CqmcTQ1N2S4Y/kZ0FrXvQ4ifcmnC+4MbQfvjhWpCLObTXCYxjgomB/oirydXEBuxmRTicfbNBT2WeCnk/pY4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSI6PHLkkNBlUWhYbcH51wMzueQCyDPXAmboqWnNWak=;
 b=gcl3r2fPiz3dBIdZJYslUX/BygmF1ChkVZLquXLp0d7GejaoSoN/0F6juEufGaDOFlrFoOjM7TVx6HTJ4Xdelh7PVRtyW6MvDZqjDhUZdQfjcbwWgWyx/o8orrtO+E8CgZy6JTUwbkTElZSmtBtvD42cIc1E7w5UGQA+EK8q/kXOkdQXwV4Zz2S+dfuXSBrahVsvjBNko2UwfiMzkMWNwCyCBuBtcRh1JRyz2IMr46zU6wGgEuacwIVWa0C1oVDJ3WMp8lV1UTvPBqYWksCzb9xbj2tDTk7YOxbdZuxE40YuA3Di7OHvX751fv7vlvFuTHdLHooDiHZ/5CVEn/e+hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 23:58:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 23:58:07 +0000
Date:   Fri, 18 Nov 2022 19:58:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove reliable datagram support
Message-ID: <Y3gcDpsv4uS9NOzT@nvidia.com>
References: <20221112023537.432912-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112023537.432912-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: d754ac03-dfc1-4237-ce8b-08dac9c0bd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: si5ONNoLv8aWeW1MW5Sk+HCF2nro1oZM8/sbRakoZlT4KqjgNsEEhq6BPh4IpVpv8zMpMDyDMwrrkxVHiKKjtwHAg5Y+7nEGda5fBimli57kuS0yWFmhP8F2KDzHBSavc8Jq4l4HbxK25yHl0Hs875VSQSmYJdFi19XXmKByyVXJzXrusNqpiCnEyDlWX11swlHKuafK6hOoiQ94sGDRDv1V1a+52dpxxpd1R1XMOLLU8xZvo7Csvfl6xI7MOQ+S/r5r+wwv+Tl0qNjDvG3nKn7ngwVDxn+H2tZ5Gidrcy+u89pNeALAUGa3qGjGKKmoavij9PM/DVlCSHBdyGYGTv+cNxH59R/mzUyv03d5fysXz0XNR8naDvmAsKC1g9UZmq1BNdbaWLhyCx07iBxlE2RcMH6IZnXuBctnTKvfeXzVD6gdUVzV+HEs+r2Qz8IP2rHJ0S7XRg3NEbT0rNW/KUKWP0TSQaQ2tKxSzX5qHhPKx2MR8B4ngGAozXgoHeP7HW4MgUSHAWxctzXLPjk40T6fGfLMBpRswNk2ymMeGuO+UtoUWwgYZ3uyTrSlzrzQO58rE9OdfV+0HR3ts/r1WN2NR3us0jkij/d++s/oqgMOUFFTidPgLX4PXePDI5l6AB+M9b1JAefUjXwSUDCgkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(2616005)(6506007)(186003)(6486002)(478600001)(8676002)(66556008)(36756003)(83380400001)(66946007)(66476007)(5660300002)(86362001)(38100700002)(6916009)(316002)(41300700001)(4326008)(8936002)(4744005)(2906002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5hnfnCD5/ug7sXfLWAJekbp5LDd+qCVT4KLVqMN2rZEwb7TxXHsO7QYh2ye?=
 =?us-ascii?Q?SSnDtjAFhbaspdhRRwVLKgE7JR8q7ldVvS5nACd4Ho+xmb1CCmp+RMkPMqo7?=
 =?us-ascii?Q?BK6EGJbjeEzgrR9OqcMQKTP+9g6Rk115toATnPzg6RdBeNCoUYOdObfMEsnm?=
 =?us-ascii?Q?nrTQn4H6bqVY44070WT7Mz5OSZLL9r/Zt8hEhffo9LkGCkdgOjCfAqSNIgI4?=
 =?us-ascii?Q?Yg+hZVdGR/704+4P76WuxB11o+O9bt5/Io6YAeiwDhcU7kMYyvEpyzCYSXq9?=
 =?us-ascii?Q?hHLzwMhbr8NeZ8WIIRJRLeo51izEON4otrXF1SkEk9mz9KilWiTqmyEV+LN0?=
 =?us-ascii?Q?MZ0t00YvkcK83ml2YzIvN9Zj47/C5vf440HYUxnZ9OlRrwvRqmfvfUYj6ev7?=
 =?us-ascii?Q?Wton3i0qL5SEOeD17QBF02pDQcw1RE36DwDf17/snZiJTGhg4yp2/GJI7UmP?=
 =?us-ascii?Q?BqlMkCF1v74CsfQf7rs6dciLdY+9Bt3CyuFy7rm7vCEW9dooEfleyl9KvILV?=
 =?us-ascii?Q?sx2kO5erX1bSbQQrVqgMf74QF6p2YKIr1aTsIcSVY1oyHs4xepgs/JCNFH5G?=
 =?us-ascii?Q?xWMNaQEmhgcsDAe696HSispLagc42AG5p1N8sRErDOl3iwokVnxBluP5ovwo?=
 =?us-ascii?Q?U3Pb14fqq/wWKcQi7fG7oeBhTRR43TVCsclOmpB8fnEEjNSWtqRo0FFtzuhf?=
 =?us-ascii?Q?3WpTW28VU8X/Gu7O/P6NxDtQqUQXVvKStVOu4C64aKiPtK1m6FET6r4fym+L?=
 =?us-ascii?Q?QgxwedMBfoPuiHkjvoivmjbwJnDhXWFTIZdHwPECWYY0Ks/EuYeB4rLab4aJ?=
 =?us-ascii?Q?RmUWiAhlN0SPMSt+3kS4NkMrwX7uS3hD2mdkTm4O1GPKjI5iYe9vR3lwGAE6?=
 =?us-ascii?Q?Ihrp51Hclb+tk9SvfbF1fogFdV0O4g4Fpd58cAfKhNh1/Ovek9QKrJXoHBvU?=
 =?us-ascii?Q?F0xSaeYA3q4SSFnLjcg9PHpOsVrSKdzNwIpJZZiUuhZXallWQEWZtLH1QKZG?=
 =?us-ascii?Q?A/rfp3VDPzI71NLur2uuFILxDdncyStuTWkGMH5Vvbt3Y3rlDtMfIfSUJg+Z?=
 =?us-ascii?Q?odbE/UVVlxOMo3PDasfdhjbSZu54GcARztzdlRiCnzWC7Xz+IqSr74xUb3En?=
 =?us-ascii?Q?FH3xormfHKejkVaEeiM+LmMEWvibX/9ksqSfkVbQGTOE7DxWh1wQ69uRf8T2?=
 =?us-ascii?Q?yhzUeJQqAW34OraFaNdIc+1EDpVfa9gPpk66MkGbJFLB6ZhlNyf7rI7oB1ic?=
 =?us-ascii?Q?u7ph+HJOPpW2xaDbMYDLb9/eECBowNzv3mNy/ij5/YUeWTSh60nnqdsaUqx8?=
 =?us-ascii?Q?oOQke6CHwd8wwd1VhQyn95peAmjw7yMXyakbsqnYBvRV3ZcdwuB7SOPFNX9U?=
 =?us-ascii?Q?8+RrWqr8Lxb8ZnmkIGPkN0+goPN+ipDCsMG8EYwnti7RSa+i2ilu0uG8nUfi?=
 =?us-ascii?Q?ImLOmRCZDgYOMVhEYeIvZQJIHj9EEJ8qEiFJQCWvZyiSPW4GbsiLriG21K1I?=
 =?us-ascii?Q?7oFlHwpfYCtHpgkYIUev1P3kJ2LaE5/kM+Lz4lqTaArR7irNOVaVDjwTL6gl?=
 =?us-ascii?Q?n/6om4o7AKE6Tf1pueE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d754ac03-dfc1-4237-ce8b-08dac9c0bd63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 23:58:07.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRZDCT0KrP5EVtLXFpG5t9LVYBrb3Er8FCVh2v/Ygtj+QWhJAG2t+E1FHcbCpzTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 09:35:37PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The rdma_rxe driver does not actually support the reliable datagram
> transport but contains a variable with RD opcodes in driver code.
> And this variable is never used. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_hdr.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F019651B4F0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiEEBEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiEEBED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 21:04:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09B18E37
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 18:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUqPnEBNu8vOeMUuf/+Z971fVKmtAPk54nExEOTz7Qj2chzQGi3I6YnFyritSMXZUs67mlk4xI1HeojEVWW265FjOspGArlzrp0VgkvtUwUmoialoH3NeUzAcSXi3nWeV5afBASwEJJu/n0tgWD5MyYtrm8idboJMMtqoCC1EFNMl2PErU840QZ22bYgIHqWjzS4wvnzPcS2UONt4CbdC4BUOYF0dBaEexF4FiPm+1I8CW4yIGIYYGQgMbVmmFFkrv8ZFcWWMj/AhP2f7WVzpfQKHIUyoh6hXrzVIPlkRjhzieGwRyzCe/RFWx2iZQs3j72iyITDXaDwUs/ORgNuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/ARy7b2auC04HEiZxqFTD4fE2wlAGEJeAinxrJ785E=;
 b=aDWp25sLR9TLzgMNSWJH32yWs4cX7tTIDR7QMzbn6Afza+Gjm0GLXKp7WcT1xOu2qRHc1C5oOOysFfhbHfupZDTOrUq4CNTIr+jK8DR61VhJPAXA/0C5AOyv6q0VCrouxj5RMTb4+FTCe2t2GLT8+X8NnUguRfp/DkRq+466gk+ADkUZpnKU8sexojZRWSc9uzkaOeHBzIcf7MIWwDfosyuXWxmXyWm8GgTHEE39K79QZxsBbfCBaDdoT5uHBbQCFgQ4qVJeZNOqM+2D2eCrCFFF59HZ2jmy78H3rG1L3oUc+5osy1e5GS1GhgYrc9fzUz7tJVCc1lZQCJ25UedHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/ARy7b2auC04HEiZxqFTD4fE2wlAGEJeAinxrJ785E=;
 b=JRfn2FDIBiuKJBXxezmyNgnv65B571RG8ZcwPBZ+MaqQodzU5zF5JoZaXF+GOJlui48KjIX/NwbM78oEgYmp8u6jwMbbPWG43c3nggWEWTX3+y7JXy1x2FHajU3gcrTMJ0pHsEVFeRjnrMpKbesI/HRpbP8YfhvOBIIGh9/7qb5HTrj/hKV+iaFxPQr21ZuCZ6P84lDlfXCCixTGYmj1w6orvaomDttIOQLMyvEjN7eTdyuCiQ4qJ+X2JNnKVbWoAdMlwrLSLQpIDkn0LR0C6tX21XfQs6eNBCW01CKXUCcsiraddMZ0pHdWaOCdJXB+RUN7qNUPSxNr/dUNf/VyFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2733.namprd12.prod.outlook.com (2603:10b6:805:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 01:00:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 01:00:24 +0000
Date:   Wed, 4 May 2022 22:00:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add the detection for CMDQ status in
 the device initialization process
Message-ID: <20220505010023.GB220614@nvidia.com>
References: <20220429093104.26687-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429093104.26687-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22348fac-57ba-41db-7215-08da2e32a2c0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2733DD53A888BAC2FF973F11C2C29@SN6PR12MB2733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrDF5k7Lo7ExFHIhmQcLDsG3E+Ix86sJdVoJSGflBjz00pC6SfvUyudHY7kCQWLDorMxZX3MFOYaFmjUAKCXgRDktCRGzvQJF790Ct22mU4nkjZVmqkAWgUKGf72dotx0aI28tXYtTLgPORpQo4xYGaybg9c+MWUN4pfRMa8ILaN05T+NlhrKH2utm9s0q2jVTn1bqcw4tYR8VxxydjXx1gkHrlrMbTFVpv5cQxzFNhlHuHmBHuLMtkjIL9L0EC03Xp01yvB6iJhjTLXyfYtkaOP1sPU1kUgEVxVnAnS8iDcJCFAZLrnia6KeSJz+fSdhtPlF5/CumRNENYXBmLNQeDtASHSsHqytN5P53HYOuyxeythk2Jia5DTP9k9xXax+bhCX7ObNF3PZB1QYEji0z+OT+rz/Zz29jMJqM8PtnebGzwl6ZtCmuP9zEr6nik16nci0/8scZJ4CLP9/dOlwunEDs0+KBnX3oRupWJsI600g0Y5VVDvWbpQ8Mei5hC261pW94TuDqTvn32JEo6yT3LU32DzcVNqQ3dKbvFX/JLe3ErnqlHe23tNPeKdDpVx7Jx6DEKln6eRyQkeQAzvXmnInV7OzTg7DyXugbfw+usEnuT1S4J/qPVwlnQC5yta9+0S+xaI5d/yRr0S3tevbG2EH8bH0rLXBGXfaq50UJM8XR3Ern0MzxFWJcSTa8Gf+JY4ZY0ngzldJnHerwcCAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(2616005)(1076003)(66946007)(36756003)(83380400001)(26005)(8936002)(6512007)(5660300002)(6506007)(66476007)(508600001)(33656002)(86362001)(8676002)(4326008)(66556008)(6916009)(316002)(38100700002)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ggt9pP/7waNjHl3jExKOKWQD/W6MOo9TWscrDgr7IuOjm1Tw5+AwcNNpylIe?=
 =?us-ascii?Q?1zQsoetKj0Jfo0CMkNB+R534iqhA3UCLAtPnlMvvPBbCgjOKlKXCKBDUh+lL?=
 =?us-ascii?Q?Yf5zuMGEYnoyKMF15pyJ7Ty4LJqzVSbWKmsiCoehZQI4ug/uQ/UzZfHTt59G?=
 =?us-ascii?Q?hX4BB5Rp3xvO5mFdYIDU6fQDH0LpNIxV+2cuVyuu3t5g1EnN3cK99L1Kn7Cf?=
 =?us-ascii?Q?F02CU+o/Wg10iiGEjObab48gzdtL0q3TB9sD0q9r+BqlisvatMYVQ4gmum8j?=
 =?us-ascii?Q?hj4ZdWrmn6BZvMZcEaVAjUamqfEpV51FoBcIVh03VLbJarHRtG8e3dC9rMOl?=
 =?us-ascii?Q?a+OF+zVxc/ns3MCMz4Y7/njEjzV6Dq0EGFGtPmxU8hP3DvxhFlhjKOhSvH8c?=
 =?us-ascii?Q?jtOg0ZAUW37n9G78FmkqdllLFoNZ2Yjt9HkLSuhx2j+EYeJhvjYXPWXaA1+i?=
 =?us-ascii?Q?bBTtiiRFrj3eSEMKuRQ1c75ZuSCpf0Ko25zlIOfAkA3bsdKEAy8PpEBGZiTI?=
 =?us-ascii?Q?k/YMfQP0zauq/TzCH1fQKSZFFPgg/u6OBsgvKaC8Ft01WcQqT1oxzfwcQCTT?=
 =?us-ascii?Q?C4xrBz0E9efYwSGO/1wBcbMA0siqksoyxa5Mz5LcW5VIiaIFivypDp+67UY+?=
 =?us-ascii?Q?b9EFyojoWK4aKRzeDIHF5yG2hr0vr5zyzGtgCpNyklOvBYeAVP6dUZPBIq9R?=
 =?us-ascii?Q?DyTXUPitcOGUxyCjRjkPDPdkGQcUoJJYjZxp3xOCaH93Imwujgne2iL4hU9V?=
 =?us-ascii?Q?nkF3J1RbaNs5Ei6kuNh+qRtMWCRGPGpMccTpjSlWC7YCPQiG2egqJxoWARSy?=
 =?us-ascii?Q?Ki1yeJ9xLS2hAE4sHIt55tbrFh9IWBSLcc3jeWJpmRin+biNsdeRsfkN1Owm?=
 =?us-ascii?Q?rYsmcAT92Z7XHYH4ueMIdlQg9amHyr7bcU9dcAUUyHdyLMghzU+4VkUyZkB2?=
 =?us-ascii?Q?GAZS5X/D0hPZM2NWHD7xFcq7pAxFvBNIxJLTM5UVH3whCLOewl2D9Wxy9f6t?=
 =?us-ascii?Q?wtyboc92O9M/L/RmEuDlRytwbjte8TNvYiZ/noJPw+F4rZh6T4iDHaIIToWw?=
 =?us-ascii?Q?sn6fm59D/8ujvJ34KSBDapomTowbMCRzK88d1MTWucasT4xXjR7ixRIFopMS?=
 =?us-ascii?Q?qd9I/vwqpjhgKAmp34UGiAQp45zkjRlA0FjyHL+4apH165iSCRwic5l1Mrew?=
 =?us-ascii?Q?tTdNIdyjZnkCMw8SMDkYd+FK65WkbfnckoESEed/l1jaGWlKfgufL+KnyevN?=
 =?us-ascii?Q?DaFTPWA4vT5hRySNa00vn9tLzmIzhCQElhSa2LWTQVAhjR1JmiFgTPx6uTaJ?=
 =?us-ascii?Q?P5VvaQahMj5EEQX8r9X8vZDnVCh6Py0x8RhqG7I2X2RdntqZ9fhcLqydZuHm?=
 =?us-ascii?Q?rsoTLR0WBLhfu/1Q2nX2dEgUpYwXQCIMEH8i02jZMXBMLd6Qog7S3OvFXyi9?=
 =?us-ascii?Q?uObZpfju7DnH74DBgY5eVhxl23/lCRsY/fx8dQ+aGzc9QkkGanlkdxU56epv?=
 =?us-ascii?Q?4rZAH9pjQZDv+dL61MItjn4aLY518hW24OKoIH1Egsa/NzepJ4EzJlk6tPip?=
 =?us-ascii?Q?GhHbDsFr/ZhReiPn7j2TOcJF73uvn6dqRLn+kQbCm1r+RYKYhEunSk/GJNED?=
 =?us-ascii?Q?5PQaRzQRQnYfDIQNL84bRMT68gV1t6/CCTUji9Jj8vaj3J0zvKo12/Pcymje?=
 =?us-ascii?Q?XyRRSt9Qmlo2CaqMQ31s96WheCqUriPQvtW1O7H0k4cEYqL0y4A6MGUqpVJV?=
 =?us-ascii?Q?Eev+ExmHjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22348fac-57ba-41db-7215-08da2e32a2c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 01:00:24.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSKPirUw1xQ8GTr600Ev0Qioxl+78fZSTaqazlBUYnFyK279rapErlS1UJE0TKfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 29, 2022 at 05:31:04PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> CMDQ may fail during HNS ROCEE initialization. The following is the log
> when the execution fails:
> 
> [ 481.424373] hns3 0000:bd:00.2: In reset process RoCE client reinit.
> [ 482.120830] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
> [ 482.129220] hns3 0000:bd:00.2 hns_2: failed to set gid, ret = -11!
> [ 482.184702] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
> <...>
> [ 485.540909] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
> [ 485.579958] hns3 0000:bd:00.2: CMDQ move tail from 840 to 0
> [ 495.694616] hns3 0000:bd:00.2: [cmd]token 14e mailbox 20 timeout.
> [ 495.700689] hns3 0000:bd:00.2 hns_2: set HEM step 0 failed!
> [ 495.706242] hns3 0000:bd:00.2 hns_2: set HEM address to HW failed!
> [ 495.712412] hns3 0000:bd:00.2 hns_2: failed to alloc mtpt, ret = -16.
> [ 495.718836] infiniband hns_2: Couldn't create ib_mad PD
> [ 495.724046] infiniband hns_2: Couldn't open port 1
> [ 495.729375] hns3 0000:bd:00.2: Reset done, RoCE client reinit finished.
> 
> However, even if ib_mad client registration failed, ib_register_device()
> still returns success to the driver.
> 
> In the device initialization process, CMDQ execution fails because HW/FW
> is abnormal. Therefore, if CMDQ fails, the initialization function should
> set CMDQ to a fatal error state and return a failure to the caller.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 21 +++++++++++++++++++++
>  2 files changed, 27 insertions(+)

Applied to for-next, thanks

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20DC45DFB9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhKYRdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:33:11 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:5056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235569AbhKYRbK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:31:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMwBNG6iFbBLclkhXba6QWdVIgkNIZNCY4BuPBKQtXLOpCGVFq1VsC8FG/9j1m/PxgTb2TIzUAlKUKQwsjhopyiZpUXDGUhDur9UjS+/+wgFPjFB8Pod3cujkMGT32Eto6TONm7Q2JMn8dr9OVbNsY7Grz2gO0d+6Q/ftpGZhBSlsR6eAa3lO1zPFz1uF6DnhhMWtubPUBcZYXUmBFxTymv08mdNmKUys6AH8BO3qbP02/z/w53c44D30QimLFSWvKlwRP37FoESDMLc1Rx1e9Zsn/X8GsckTROj1V1cuCqTNNbgZcueYD2lVDIo1crxWXEQcFwYv2+4earbHYQj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b7JM1VwYKSskmVnBzBo4mE12J79x97Fh5Jd0/w6eXg=;
 b=BKvb4bq2WdcUYs80LoUfnDwmDjAJ92BNh077kSbW1TocRh39+Ce3YARwwdxSd2z66LKYWl5y0+FeWuZKAiMRI9XMEBlUeW2amI6nAKkeTvZO5bJifzbFUKmnijfBzFXusQzPB/cOL7nId1ci6AAu76iZIPXMvtp/4UDR4sZ4piOiq/OY+1+GOYPgGZBNClrBp6aKWZGGwviAhWDWO1SogbRqO6DIbmKZxWyqx7Nw86wXEvU67AAba1z4k++Ik83JoWt+ga5Jcip1sgf3lyXnRx+YK37MuMJrrGPp3xL0+s04+gY3DFPLCxgDW+fbgypsmdD5DKXxOAT178yXF2j7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b7JM1VwYKSskmVnBzBo4mE12J79x97Fh5Jd0/w6eXg=;
 b=EisWI53frvQNC7mDkmz4ltASTaOJ7aWo1mvriDRCD8YA3aZ393bOFSHOCGiuTGalrgDEU79N0jdDV+XcP6W38gyS9pWgJa7H0SSzsbfyna8/nvZRQB5uReusxFPBCSFzcXtAQ39WPK9tm2oLq019Tsg+H+YyBBB/mh9Klc311ChbtRNeNzaOhdiNEgCyBiTF4IKau1DdBQzCZPndR4SYqwtneUbqXsbG3uczk6dYXZ458r5UN2jwX1RUN1pSAXM3sYXHqKjSqFGazRrPvaO/4abclm6Lj3sLTh87pcsYMVSGouWRsWSApEMGACzSkNHebZuhsLHbbb4EdIl2ifUJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 17:26:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:26:54 +0000
Date:   Thu, 25 Nov 2021 13:26:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the error of destroying resources
 in hw reseting phase
Message-ID: <20211125172653.GE490586@nvidia.com>
References: <20211123142402.26936-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123142402.26936-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0034.prod.exchangelabs.com
 (2603:10b6:207:18::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0034.prod.exchangelabs.com (2603:10b6:207:18::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 25 Nov 2021 17:26:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIWL-0023fN-Ey; Thu, 25 Nov 2021 13:26:53 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd57986-46a4-469f-1fa1-08d9b038c673
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128E938A630D882A4577F15C2629@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1tjf7rwqEB9yjLCQoDzNsIxIan8XnesFq/Itj17T9dR/JGvJCWLtRFjP31GhI/laPQoPTVfAe3BQUAf8yQlqhkoVLGRjRc5qNaeuFE/kbyFPI0o1nS0cXhJoEoam38El/QE2FNgjLktfMstZBpMBI+wRrvfvmXb9mb0dNP4Q2OhitaA4cWOdEEObrWHyZgO42RK9cPAx3yA2vDMMtCU0RB84W5x3V20KVU0OowmlmD/nAEKiwbzzXc2BeTG4itLfJRTMjQSB0IRZs8qlb9cT86QmiFZEOa+baPWydqgNb67z4d+SdIuPAEH3uKOVwh3kDNbPatHE7zkvF8uyp8DYcu0bx7HP/0BAXXB0OtbkRZ6jnmKuerWXC7NijrwkmAQyPyB+Q2mnQYP+Ar6hnmhRuPBoHzN0EsUwJdW0E8+19Gjh4BgQtW5nuXMe/LMXB3K8wlu0HA8smjQIfbZJmS9TQk1H0+u5T7P9Ow9HY7756c/Xi/s3jn2c7M4ecJSBXNLwu1Uj9aSnUAForebS4C7oMu13R85azhZWkK3SVk4Xaao8sE1omYQJgMD+8hPjWg7nTpP/5UJke5/MOzkjiPMgcvKbdbEbQeVHFOqGGXsRYGNtpHwh5dU+k9yqJICYMISktvhByo0sf+sZgT9S+8f+74LLv5Cr6qCdw7ugNehO0pgp9i557f6jq2Mec+3Yf527oJRRxLiokrPKJVg7I+k1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(9786002)(2906002)(8676002)(38100700002)(5660300002)(186003)(8936002)(508600001)(4326008)(426003)(33656002)(6916009)(83380400001)(1076003)(9746002)(26005)(36756003)(2616005)(66946007)(316002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BgFoWk+DSG1L4yN0uC8eUbuTpOncXBwGeHVLPTXWTX/XzpWKOy/31vaRzLpd?=
 =?us-ascii?Q?OLTjZCAEPfCgLpdIkGByJgX6CQmYwWkp0w6iNULNIV+hxkyjtZj57cIx04xS?=
 =?us-ascii?Q?NM7HBQNeSfQMD/0tcrlg7nBNTfYk6SK8+DFKnyITVtZzw3sVx36FeQ//iDlZ?=
 =?us-ascii?Q?6nY2JKduWWCqtbcNMtQQgDhgDpLUgp+YpAytJZoW9nqEk3StorWQF4+NeXIA?=
 =?us-ascii?Q?+imaAgiL8i9ub0NDoXvTGzsjR1YzIB5XefysY07AGrDBIotrZtncRKAPBN8N?=
 =?us-ascii?Q?RmiJWtxJUkKmY6eS0fquxdCW2YAEuL7e4/S6/slCyeYJ6BFK0MEQ8pyurpHN?=
 =?us-ascii?Q?NVSt2pLElHPT9jpT7iM3PI0reeEFm4qFCmO9IQO+vv9YD0oSrmJpw8c44UCU?=
 =?us-ascii?Q?EkHSnD9jnguSnA4PBulIR8Xh/s2T727KVNFdJgUxcbi7jgvvQZicCkhIguA1?=
 =?us-ascii?Q?9rQ72s+iKKWbNkXobbB1NdmUSdD29kwFjJVsNxIm05bFPa+kpsN8oIo1Cdzq?=
 =?us-ascii?Q?FYxXZKI6Tn+T+7egwyfkamzatcPPoWZuVnlBBrQOXjlahpqUvwfmhtmEXfeG?=
 =?us-ascii?Q?c2c8iKskznfBd3ec5SXKS1LIuWiwYzyHuFTEzy9JS4aLAM9kyn5aSZzLOekT?=
 =?us-ascii?Q?FvYGtcJAfVAM3VbsqQrlqPhtkPfHuxjvPjm1N/ZjVWaprBgshz4KqG/iVvNe?=
 =?us-ascii?Q?0tXZZRm1dA9tTJqavacXSzyDINbFZqAPJ+90sQcSX5AzFwWfTKZMZbtu4Hiq?=
 =?us-ascii?Q?hvvG7xZxxFG8LqpBrPUzts7wTO8Nm3pq/JDh8BS1fOg0RC6E5PrAPqbchE8I?=
 =?us-ascii?Q?jvbfKBbZyiHrYz+rUZpLRRuhyUXEwpdZqxn0wlyPq/Zff3/5V4Cjw1b68idD?=
 =?us-ascii?Q?4CXctTDoNLAtYO6URyr6D7q98eWf9bPVwAfG3XsYn6jrqS41Lt7aZzsajcFS?=
 =?us-ascii?Q?pJRM8K2575vgoGYtuOZLFdvqk/fkPWIqIcBQnFjvaUqzMVIu0NEb5r7Y6fGp?=
 =?us-ascii?Q?W8WVT7ETzTxuqoiUsrM3+o4eI707zxhZQpxI2yiIMoclUJmG43F0JemSDBNM?=
 =?us-ascii?Q?vqADKQ547CoihJr5+z3JvZfll6trjdpbNEujpsKn6XkWx3XT/u9Jr1f2OniH?=
 =?us-ascii?Q?fuG1n7NCmYbszSYFrmi4b2xAnLSGuU3eGGftFJayKlBfPv2nRAzTxAWN/wvB?=
 =?us-ascii?Q?OQIG00jkjGZ5drbGMhQMpWRRgnQBtb8M3ioMCBAO50kfILsr73Op8Le0ROWl?=
 =?us-ascii?Q?cWE+lpZaPlp1RrTej6bT1SwEwuJVzrehIUNt8k1xnyvCAC8jARJQxMfASI45?=
 =?us-ascii?Q?sMbS4TI6KNmdRfMSWMN+diaDe7SrOv/TvIXDuMEWetZ8NL9dRhYJJ08HZ3Qk?=
 =?us-ascii?Q?Do2uXkQsaNWqWrD1xaFmxthc303CUjtYoASHSMg1sILWmK5D4wRmVWzglby9?=
 =?us-ascii?Q?j2djCSw4Tf/PwdBD6Hr47wZquRSxghRIvOsvW8RI83By8PNJ0vAHMKf8R0CY?=
 =?us-ascii?Q?GwdTRDSkaLendfCjW0gbMwfynLaM3JMDau3LOKFBGHXwVmzuLEmO2Ro+RCjE?=
 =?us-ascii?Q?RF821SEfHxhx++Z9voU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd57986-46a4-469f-1fa1-08d9b038c673
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:26:54.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoXOVe9QpFkwfI4SRHsdwE/87bq26sSn0RGFuyB+IunQ08cJBbox43TiKCAnyA/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 23, 2021 at 10:24:02PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> When hns_roce_v2_destroy_qp() is called, the brief calling process of the
> driver is as follows:
> 
> ......
> hns_roce_v2_destroy_qp
> hns_roce_v2_qp_modify
> 	   hns_roce_cmd_mbox
> hns_roce_qp_destroy
> 
> If hns_roce_cmd_mbox() detects that the hardware is being reset during
> the execution of the hns_roce_cmd_mbox(), the driver will not be able
> to get the return value from the hardware (the firmware cannot respond
> to the driver's mailbox during the hardware reset phase). The driver
> needs to wait for the hardware reset to complete before continuing to
> execute hns_roce_qp_destroy(), otherwise it may happen that the driver
> releases the resources but the hardware is still accessing. In order to
> fix this problem, HNS RoCE needs to add a piece of code to wait for the
> hardware reset to complete.
> 
> The original interface get_hw_reset_stat() is the instantaneous state
> of the hardware reset, which cannot accurately reflect whether the
> hardware reset is completed, so it needs to be replaced with the
> ae_dev_reset_cnt interface.
> 
> The sign that the hardware reset is complete is that the return value
> of the ae_dev_reset_cnt interface is greater than the original value
> reset_cnt recorded by the driver.
> 
> Fixes: 6a04aed6afae ("RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during reset")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason

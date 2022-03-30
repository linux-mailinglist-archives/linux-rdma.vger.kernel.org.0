Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621AE4EBC0D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiC3Hrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiC3Hro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 03:47:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73560289
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 00:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD310vPOfydfB1eKVMPKXHY4drueASGff1fFqf7auFRu4M4e2vuML9qxtsQj8gCAu1LLHS5fyQianO/+c5m5GICBYbLNVAFLkBvUwzvEtGifyhpfpalg5xSuicRZhCEzdHXjmDAf89QhTJ1+ZtXcFDvmPoqrxYbTTJDpZ47EN7mEqjnY9EwQKljTMWEfOOM+HYGfCTC2FUV3VSM8ZDos+GcIzvvuQoQVs1eE1MvCPANkO70AGbQ2vefaph2qyF7uRRleC2h8M/fydhsbELYXim3E3MvqNLFsuKXoNAIZyCd6q/nr0q/lvnksBJzMOKHB+QBRyiRwtzgJ4I7Iw4vN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujhCW7fGgLGi1CMVJFczjbHRM8wMwqJBA1W0gEw4W8s=;
 b=NsjTU8+8nJWkSUcCXtmvn3SsHD9vxcZJIbSqFJGBU+IJQ3V6wf7UX54rrTXgBNv0JEIqrrWahXHd8gXWGRZFdirvhx9DGTzAvB0yIMh3vuRYgolmcVCRy+5gH+usb7km1CnEFlUCy3oz6TjMn6E6wjAgxB6hnSZWrdd5BDsk8f7miDcLT28BfUc7Yf+omlHKaxvc7uIuP3vivcYR7688525afK7KKIknVUMb24GqAdB0xfJNQ+2O6mAp0q/DVUjhqwtV3jeLH9YcaSN/g+1mCDF9jPOz/FMrY+OofSUFhSYJl8JejfSwinziMmaBx6jari03HJzA8C1gsSdX8gyVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujhCW7fGgLGi1CMVJFczjbHRM8wMwqJBA1W0gEw4W8s=;
 b=th/AAhpxGL98x5X3r0NV5/Y5zuaiKCepP576tn8GPdhW5RIzTBkNHiwfS6QU8qXU0JCnOVbHL/h3J5F9MDS+1xHOgwKnAFSpf08mECyHPWA7ch04qlfWRcC4cBLlHfofl1Gg3Mjc0unjjKnQHnwDgPbsjpvH5ey1Z+kukwcSUHgbNzscorebYiP1btRtQ9t9GMicV59qcLeWevbXTATFnNax2X0JOD8iF5eToNuNbff5vAnVKtX7KWYZyXSDyTcGw/Ln9eVVuGvPspbT28tSSCzXGxPdx4sNrWzhVlqYKJM8+iM14boQQg06181sHIKFIqFqNAuu1RRQzqAdG8t25Q==
Received: from DM5PR2201CA0015.namprd22.prod.outlook.com (2603:10b6:4:14::25)
 by BN6PR1201MB0180.namprd12.prod.outlook.com (2603:10b6:405:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 07:45:58 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::37) by DM5PR2201CA0015.outlook.office365.com
 (2603:10b6:4:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 07:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 07:45:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 07:45:55 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 00:45:53 -0700
Date:   Wed, 30 Mar 2022 10:45:50 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] MAINTAINERS: Update qib and hfi1 related drivers
Message-ID: <YkQKrn2T+NNCt9xX@unreal>
References: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2288128-d2fd-4b4d-efac-08da122153fd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0180:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0180D8FD00C12279A0C6602CBD1F9@BN6PR1201MB0180.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toITWwWuSXQkTpg9BWLfIh5eTpDQx1xGGkBVBcKZqiJJk8MTEuoCLTTjFMcyo4PTBw4bprAX4zdDiFxtgAPSwC0hEGnAIrTjvnvudmMnDXFzGKQHqvJ2IxVbJ7Gz6R4jMn70OitG6oob5/1G4uaQY6EXoKsTMHjv2fRIOnmHUINmE3kp9LC5PtP71QkcdODZk7LunfKlDdQED+CyJODbbDxKN0oFWAvnBQ7fa96CfUMmVTUZFHfiFm27/8AqAcbKwXT46yec3A04otAmivwkpBZgZZFCR0J2BiIb2oU50DlsTccHo03hgQcLnXKpx1XeVJlNHJsn2kiATc2rEk3pI229E7Nn9FoMiVchNOAUfLDhxksWedmmg89hlkaoifXV63f1vUOs4bnmplchCFkcAABaaYu/Bl93YAMujSQsUT4mh9ClT871AUdvEKJcyPXdnaDRM2VAlfJRB/nWFlSRt8xmYqmtuNkcwYas7jPsIJeG5Y2T3yTpdkOPRDrt2Gu9WHHK6ORhjjnaFnhYQTP89VBUqpZQILgb3b+TGBwkp/wOe1LhqHD0MFTyPc7FMhx57nhOdU3dY8uuzfW5iF8xcIYkwhvm/G/0LkKvaqwUkfTiEvIF4Bxm5dw9+KD4XK7XItzikCmdwlkECFcS1y1jL77QMxi3VZNAc+wXuxx380rKN2BxYaPIrLYIxgaw08P6eKidfQPqWf4c9Tm8BaltNUPbdSyEJGW968uPkjHQVQU=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(36840700001)(46966006)(40470700004)(54906003)(4326008)(40460700003)(336012)(426003)(9686003)(316002)(5660300002)(47076005)(6916009)(82310400004)(33716001)(8936002)(16526019)(8676002)(86362001)(36860700001)(81166007)(70586007)(186003)(26005)(70206006)(356005)(508600001)(83380400001)(2906002)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 07:45:57.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2288128-d2fd-4b4d-efac-08da122153fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 29, 2022 at 02:42:21PM -0400, Dennis Dalessandro wrote:
> Remove Mike's contact from maintainers file.
> 
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  MAINTAINERS |    4 ----
>  1 file changed, 4 deletions(-)

What about rdma-core?

Thanks

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c9..9dc04be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8506,7 +8506,6 @@ F:	include/linux/cciss*.h
>  F:	include/uapi/linux/cciss*.h
>  
>  HFI1 DRIVER
> -M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>  M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
> @@ -14358,7 +14357,6 @@ F:	drivers/char/hw_random/optee-rng.c
>  
>  OPA-VNIC DRIVER
>  M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> -M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/ulp/opa_vnic
> @@ -15756,7 +15754,6 @@ F:	include/uapi/linux/qemu_fw_cfg.h
>  
>  QIB DRIVER
>  M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> -M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/hw/qib/
> @@ -16271,7 +16268,6 @@ F:	drivers/net/ethernet/rdc/r6040.c
>  
>  RDMAVT - RDMA verbs software
>  M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> -M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/sw/rdmavt
> 

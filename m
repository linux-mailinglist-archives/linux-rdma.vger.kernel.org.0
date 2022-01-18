Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D5492360
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiARJ4Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:56:16 -0500
Received: from mail-sn1anam02on2047.outbound.protection.outlook.com ([40.107.96.47]:6068
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233523AbiARJ4P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 04:56:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTlGKI+7zDhFaQ5aq03j15VQ1tdg3C45OifTU5w4dVnxVdJ+Ws244tuUPWFiuuMSUi//kpU5+KJoHq1KXE800eZM9Co3KNWxMmu+tb8mntk0zxpzUUQZez97R3voqXoU5oPQKt5G2On9svaSs4yd27fiS1gRmk+ILHg5p1xnmAL5RBPAJkbDJanh1mI0uGM0CrCgrvy7YkeSQraKaTRv5Ru6CdDH6DbG7RJ5MOXXA2Efk6ZVESSJ3BQfmlbvFaEO/wgttTDlviR5uaZX+HnF66Zl+9TLm6NugbdlQMAFz9oQ8yJjq62X+zMtCHQGhABRvzNo/K0XXuWUYmTp2VRNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ0tZD6BGRDiXC/rTy/Iz8zXfNIhQAoTKvieMJagXCY=;
 b=jsw3C/ztRPNtoAdzEUMT1cIl5tgCmByfi/rQTnBglBYk6o4ih7+QjNU6hmf6bzYV/JxczPbZhWENiPEjN7GvZsM4a4lb+lj1nVeBv++oqJApU4tGUs+M3OGqF1ooNUWWiOdoUgS6j68w3Tsi++RxIADneqPnidaCfEkgmWrQG+d0UOSjvhvy0Rtlf23ZEdTinHlnf3krhxFV1PJO+qVD+9/Scd+ZUdSzfKF2uOXtCpY0hQZczFE58V6lvKTywN7NxJEoyWZBkYNT0z8ukUifGo5HrYRMQZFxggnALl0QxdfN6zLk2SJFN6F45uoSIrJfq3YhpyoLiQRivj2OV/q4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=cornelisnetworks.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ0tZD6BGRDiXC/rTy/Iz8zXfNIhQAoTKvieMJagXCY=;
 b=Tw8CNtndaaIkT+0/+DyHd+fQzyMVXWpyBXzdSl+2MHB8sM0Oqg1B2KvbowKWpOyrgA/G5NRT1Db6V/gPRF5L7seZf+PhaB5lfSSGbquXqnec/R9sWt4c/PNHvm7KdCFb5KqOGJy52/7RMwBUmqmaIzSJXAJwJO3R5OzXxgzC9Eg430AkKLVt35frvngCfUiENgvyygjlgHv4HWx79qOGOwJ7t5USXl0gfF4peZUc4kDUFxBVGO1CIFwHnDP0LWxvj/XLKLrywqguvNMZt8Nz4zczvZHcIrAVnRo9hOjSCm80ZJXS+k5v1ENDQP6hOgUITAM7waPEGfE7xlfodbx8LQ==
Received: from BN0PR04CA0169.namprd04.prod.outlook.com (2603:10b6:408:eb::24)
 by BN6PR12MB1169.namprd12.prod.outlook.com (2603:10b6:404:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 09:56:13 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::e3) by BN0PR04CA0169.outlook.office365.com
 (2603:10b6:408:eb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 09:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 09:56:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 09:56:12 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 01:56:11 -0800
Date:   Tue, 18 Jan 2022 11:56:08 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gal Pressman" <galpress@amazon.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: fix refcounting leak in siw_create_qp()
Message-ID: <YeaOuE+qJNV82Tjk@unreal>
References: <20220118091104.GA11671@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220118091104.GA11671@kili>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3116833-ea26-404f-e64e-08d9da68c2f8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1169:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1169C84660F1D9BA4436AF1CBD589@BN6PR12MB1169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyXcGDYhi6fKDjzNxTs/aCMkjZcSJd2GFX5kK1BhIZlUSTaaZ7FoGrGFkgINbHdfXk9l5W1P2MgQIR07majpx+I5298SR+Nzd909ihI9OTSRAXYmVLqn/qKQS4RN4G/HouYscS7nt2539NmSrng6lMkK8QUIkbSbu+vGTyDETSyry3VXPZGjQvkmZ+kT56V/gbkpQ6D1Bi3FiinFeevoX4N7rWBA/0oMWUlxdl8gsOG5p65vZWLC7cQKvy/0n9fkDZQqzWeRAHQW8/KJP3H0PxQa3JVkP0ASoQxqktnca6ALKCWU287cKVERHi8EFI9DDNiETvXkhC+NWbeIgt8iEHrW8weIaLQ99lxOB2bU+ZKqqLE+UukxVz0Yp4CZZyhliOvUoOjwGriGpHhsVzDCr2WPRsB1YD7R6W1f2gavXttpsfqzxWvG0xTFB8YkC3h3cmow2VazTJXZsVn6io6n+W+mNMyGBphr6l1ba6FzMn/aSlg/36iXqaraY740b5ajWDhma4V01UTFKoDINy/bG75hQGesRCQc4n19qR0jlZXaCCF8okEp+iuKjGHvJJhp7cjo5pAOrFgAsiidTBk5AaHKrmgVqPJFWJn24ACzVfr42g7poRH9g3JBaGLCBd2+yneu3lytdu6E3VgF6lAsLSk5P380PlgCcBcAf2Q+BDL8br7Ba+YS6OAPNljuO0pZ1T+rJiRO+02AurgcnrlAnjijFjr8cCyKs4RTYzway/rmOqUWarzrJEIawu/aVBB6bVtjpv99LBwXKpCDG+nnkxNrBXBJFMykXigVvqsdyvLcgBAgPZNSB9NvesWtXvcg/Twab50opVr7n4mNuyGDeg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(7916004)(40470700002)(36840700001)(46966006)(82310400004)(8676002)(36860700001)(336012)(86362001)(316002)(40460700001)(9686003)(5660300002)(426003)(508600001)(81166007)(54906003)(4326008)(16526019)(356005)(47076005)(26005)(4744005)(186003)(83380400001)(33716001)(6666004)(8936002)(6916009)(2906002)(70586007)(70206006)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 09:56:13.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3116833-ea26-404f-e64e-08d9da68c2f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1169
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 12:11:04PM +0300, Dan Carpenter wrote:
> The atomic_inc() needs to be paired with an atomic_dec() on the error
> path.
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

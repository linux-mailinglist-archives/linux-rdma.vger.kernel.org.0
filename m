Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03162726AC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUOKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 10:10:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11154 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgIUOKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 10:10:45 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68b4580000>; Mon, 21 Sep 2020 07:10:32 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 14:10:44 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 14:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9KfqHhSPPP9zOiZ4Dutli24Au0cL5TRjjwcaHMuPeNi4+M1F60n29gGlBwmZmY5mfpBXxaRbsNEMc7zZBOb0uLHf/7oHnvP3ZgOVuaoVgtcfS6JBRI2/gd3agFMDBPR+lzvDc9GZniYBHS306PYrbWE9MzWk+ljV6zOCq5NkNjywr99BT4emw5bwI2HjnEnWG4IM9bFqJLu0LpQW2roXVvmO4hcruVcqoM1LOwvWYxLzwHGC+E6zY/qmPkEVk1CNjP/cDpivGPu0b9FwL0uIFqrMJAE+o1e0oouyUCCYPAulPUwNZr73VZ0n5BSZY3quM3aZimCl1yyuZdGmPyPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QV3jIXequvUvJjw7AIyyKenqvOkhpBJrFsZi6NsGtM=;
 b=jTp67IXsDicDVxZ4SF7WQPmdaTBlMdYzE4L2dU6oUnlbphVFdc3BU2kv3UT8xaM/X0lweTk0MSX27niRpMXMvVZIJG9VcC7g+B9fDu36VmonYXw8phsU9lP7K4CQRalDOssMGYf4GrxrRk4d7Fz8as3B0rjNz2J+p4QSrZtBz9bniCX55m4zwM7LT9ApKoBeD5oesKGtzZvQtufL4gTUj/o7mmgISiCdeqOk4BTHUSFFSXGpSxbTizesBeGLvN0vEfZ1ihwtTarTpyv5bhvMuwMgxa80GHCzUYLJE9N4ChbFCb37PVOYNm6pL2/rdLw96aH1lpmSvCTXExXs6Gxbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 14:10:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 14:10:43 +0000
Date:   Mon, 21 Sep 2020 11:10:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 00/12] rdma_rxe: API extensions
Message-ID: <20200921141042.GR3699@nvidia.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918235117.GK3699@nvidia.com>
 <ec3bf0ed-8dde-5f36-656f-3cf6d64bd7a2@gmail.com>
 <088207e0-bdaf-0d0c-62b9-612941825ca8@gmail.com>
 <f6803def-13b8-04f0-5fd0-cbad702f1837@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6803def-13b8-04f0-5fd0-cbad702f1837@gmail.com>
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Mon, 21 Sep 2020 14:10:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKMWg-002dJU-AC; Mon, 21 Sep 2020 11:10:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f55da001-3f19-4075-2bf4-08d85e3820c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4340364E4A2FDB4F305E4768C23A0@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5uN33EmxLQS+xoNJBx6YG1/fEaNxVs4Ab29lo/6C+Z1fnC6COAkKWfRO6HFVJJYcE8GaXhfwGcCHPvYmzCK8/cGsLOxSf/c2kZ2c462vUud6aF8TcsnT6OFhawY5bitnfntgD6hv5Qc/O5HQO2pqzcLxxh9332EwaVOFMBmPUbQQT/AzlAF23lZAR2b+BBqT7RZ34wg/9ik86+Wl/rbAj29PrBxFHKnY3ewsNz6GTBGV9eS1Scw7AH+x6ZJag6QeiT3cYd+0Q6ky30miOUhzW2MY/tcYoD1XJzz1ONeSyhv/pHlfxAcOmia1iFuHuoD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(66556008)(316002)(4326008)(66476007)(8936002)(9786002)(66946007)(9746002)(558084003)(6916009)(186003)(5660300002)(8676002)(36756003)(54906003)(83380400001)(2616005)(426003)(26005)(478600001)(33656002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3l2FTBiYjm4hx8uleRL+sSXi0ottA8JOafU/eUZ2Kv4ei8AdTq59sAadp3HfFgw0hmC306M49jHofJKZmiHhEC473qKlAtV85fiDE+P5fwPRuvkxMQLiR0tAWQIuC7pZgLtHD/TmxGpCy7LZQmjGnZ2BSXJokTQK29GLaDJ8L/LtSV66vmuWTeLBPYv/mux1H9naiEdZrHWp3EQvUWvynIY7DWNO6AwFVcjwes98xRZ5C/H/DYXd8Hwvov1F00shVmBxVzvau8z6axdeB3UcHZRSAa466LIrRzYUMcE92YmFK8P+Q0+W8osDkeoqJT85dpJAiTufm9AseMEOA9vJZF5iC5rs1WWT2wuvi242URCnHuYr6P105L0wNCJ7gGEdp59EtbiR84z0YnEzoOyieVvFDa6th+2gY1P/7xlmdMkYK2mmEtYN2SDWXyxGowWGvlSmk0nsOResjXprZP1m7k8/qTOnJ+DYlw1DKITxaStSQMFbHnIi28EjZ9J4C/+ADxcLHkHmtXLc0p0hbUXqjCYa96tQdMgwUzbtThprt6hGayvqCBJTLGV4zRMwOD/D1stTOa4lS12Mv1hm6T56fqiR/Idw6hD12uyPLxg/A+Bu7civ+zlMx5qXq43JGuYG+Yj/eVpRzHFE8nuWTv2ZWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f55da001-3f19-4075-2bf4-08d85e3820c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:10:43.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAukUfqUWq54gR+44pDEX7h9k6RYOJy9gVkwBL8aITJYuRNWb6U07rz5wRa6s1jG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600697432; bh=2QV3jIXequvUvJjw7AIyyKenqvOkhpBJrFsZi6NsGtM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=dOLfXPhQ3DuR3PSxV/8sNaGR5hlDW39Fx4WMXvOHR/UoyYZS4CMJK0Ue83lgWae9Q
         2vEx3u9qqIprQW6kHyNGD1jTz/+FqIixRtgImVg/fNHMYRYamrF8t5tnT5PnK1icPa
         5plUzALJq7Sz/zP8ONBbqOpHaNPRb1zRt5Fi8/cczmiNLO1Dn5SZGKp1c5b+uTYWEl
         xRTJAeot+44SDoaJSwnlXRH/0H6TsorqD/WJjgks625KSe1b0pBP0YULcim/fiXfd1
         /bymlJTs2rdmddDF79UNKhMNIdMjW5lIpdcYpFJ0BDcUE1MNDr+Zl9seThSLEvxp0D
         q9UJCvpXAPNxg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 20, 2020 at 04:13:29PM -0500, Bob Pearson wrote:

> The missing prototype was a good catch. (That is resolved now.) But
> I can't figure out the null pointer arithmetic warnings. They are
> all in obscure distant header files. Do you have any insight about
> those?

Just ignore thouse

Jason

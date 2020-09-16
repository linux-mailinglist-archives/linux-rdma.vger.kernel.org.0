Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7926CC8C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgIPUqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:46:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8352 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgIPRC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 13:02:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6241520002>; Wed, 16 Sep 2020 09:46:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 09:46:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 09:46:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 16:46:52 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 16:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caYGveoIGTqvY7tiwBlW4m8FWc18I2D4rDhewrOieY8kdSfX6mKY6Fb3HHW2xBBbahLFQmsXmQc03PZxGpEsn+4uJvZR3jv8PmcsQIoq8ieB7njZ2WKnV/LRd+68Bo285VrwcNMzQU0Ev++zo9CApNHOyWfvT0q0iZ1ZFFnKV6tNUtDPZmRH1R9iaQAv4vvQ+T7d/smT7np08pV/Ai4JQkUEwmPqpsZ6Qyxgb4OP/JLk7sXTnP4LPlBWlFjuQ3CQV7Xf0SbF3Y/wu55xg3jl9eSpF9xENqJsbCmIQC4fpKiFwmhYQVOhXKy+t1ww2SOC33FuumSwOiQ54OTJwqPL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcwpLTsZnqxfIQmMsm45lh6mQfVBPUc3olThvYIG9kU=;
 b=DW4Yj7qF/G5ieCnq4hYFsH38UKoqbkK6ByXLwFAA7o+wIET3iOFzam7ZMXX+++cyGE7ONRc/YObr5D7FrQ7x4uY3l3+SDFQtcChqN0K31sBsNbEf+xCwg87qBQtu1/fc1aTHQxuyc7s8UhEZKsS1kp5XmIRh6WTbsvhFP03JSkgKb5rtilrfyi2ESTGpkNpne+fncfyv0gEgRVl5/ZRnJwoP1S3+f3qWgaTcnpEw0v2Q+FYoSxNV/3heKK8Pz5Ez4cuBm75LXr/brGvVqryeJszwsivjiP8Tt090YaG0dm38LaUWng0l/L0XPmvAEkhwO9YOaFAq3dLJkEFcOklU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 16:46:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 16:46:45 +0000
Date:   Wed, 16 Sep 2020 13:46:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] infiniband: ipoib: convert to use
 DEFINE_SEQ_ATTRIBUTE macro
Message-ID: <20200916164644.GA19901@nvidia.com>
References: <20200916025022.3992627-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916025022.3992627-1-liushixin2@huawei.com>
X-ClientProxiedBy: MN2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:208:1b4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 16:46:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIaZw-0005Bb-6Q; Wed, 16 Sep 2020 13:46:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c951c68-8ea5-4d5e-5335-08d85a6018bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351374A15E75488ABE1E3619C2210@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7m3pF/Agi/oTUvNtWOrkY8M9y00AwzG8sp6ibSZKzLqBxNLp4lZkOc+9quLyiqZNooulunmlJq/aZo0221763xggaF7t/BXDh6M7C96FrpIlIVLFyTEtQvd3vfXpUr2MH5sqQBX4gOSW9+U0PeeAwCL5AcWTyb+asnFwXMjpV3hDbvwZlKnlBqPpGRyB2X+H+b+pcMnxHIveErksakbEOhTvo9lLkWyfQUbDFG6PfltGqeuBaP+CVUDNNc2MxbVdLD0y76oZP/IREY01f/iiTnwqpVGiFlkzwRQdTZBbmY4OARYsM1/AvFGqbqWhOka7+1Tx8DWplDX5wfm7F/iizg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(6916009)(186003)(66476007)(66556008)(36756003)(5660300002)(86362001)(66946007)(1076003)(8676002)(33656002)(2906002)(4744005)(26005)(4326008)(478600001)(83380400001)(2616005)(316002)(8936002)(9786002)(9746002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4tglq2CQHrOijbk18gLcWVkSOEFOA1cEsZQjQDXMjum4ojU4bFogmOlrDwy7oITkaiapcSz8kIXQ11Jq+H2gkFQIKu0vpJaLlxnsO6t/jHsQhxkK5wSxWyCfu6gE5E3eeKwQrQHFVjMWOwuRMyA9RblQrvJ5CZVigRtSCf9cMPWUxPYcoyJDVGqkMv3E+rict7HScMt2WeVb/1ZmtLGTMj3h8gRwau/WeBRhwrIeCG4V1L2wfN4QezK+wZL2IfhW3U6dkuACt3zfDIZKMQFuRyTb1YRAroXuLaGdk2dSubRTntH8esDtVPnOtHHAi/h1tsuO90fY4ErqEGAgq8ZfCiEX2Wf1e7Uv5YgT1MC3d6U2eEvBcza1EDa1Rn5ia4s3taeIF+C9dKX+HPhGUnQB5PzMsymC1EdroCc7qkeKLIhHp9VUe2KPhEKzsg78JD8zCjaoT3dbu3knHvsyk1PQOu6Ixi6xRmkHbJx2Sul4rJpkkMxliG7H7S8l8xzdJHAHlU64FbIhhX9BihpqX2ji/uSwaYj1IbVY7EeCVDIpYtfH5TIMpBMbVdPwXRoc2p6JoyDqJI4FJGr0ciih3SumM6+85752MO1uqkAU44WgK2RGuszU239KURGNtMaufcHUJBiKouK9TZ+sl8jVJ2FowQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c951c68-8ea5-4d5e-5335-08d85a6018bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:46:45.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GceimPVn2Bq7RvtQWz8WGiqzLvYEf8UGbEo8ZqX4LgG/+rz1oojIcXns5qmeVg9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600274770; bh=BcwpLTsZnqxfIQmMsm45lh6mQfVBPUc3olThvYIG9kU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
        b=Pi5i81ryij1NFpL7pVZ2JXZtTiUlKuhtKfsH4z/S6Wv6WUu8MwZ1WCFS1bdt1J8rl
         Ofw+dRQJKLlFZKMa/8MgibF4Ix1yksCAfDdn2kOjrmqwfVfwkns+XxuqcT6uuCiCPk
         Z9DZ0aXNhNsLw/ldBJrO/HWLCy5G08aUq+byPnhY5VUOCs9K3hqZ1wmJzT+XY64uiW
         Waov/M2hReVIrICxEToDU9HOxcBERexcc++Jxzvq+sUrXAzxkqy5fqgW+3lLmtoJQE
         nouaZLpt4cZK3FUbx/dVYldKK5QWG+P5fA+TAu5PgMr19rY0CVGE1svMRdQwYythix
         +gt8OERxr8fhQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 10:50:22AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_fs.c | 50 ++-----------------------
>  1 file changed, 4 insertions(+), 46 deletions(-)

Applied to for-next, thanks

Jason

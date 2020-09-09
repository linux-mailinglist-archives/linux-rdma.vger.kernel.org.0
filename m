Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D996026363C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgIISpM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 14:45:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10822 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgIISpK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 14:45:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5922a80003>; Wed, 09 Sep 2020 11:44:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 11:45:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 11:45:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 18:45:09 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 18:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKPIr2k/mET1USImWXgMGw6LSxjstyJ7emWjPKCBdLCGxEBaYVffN2Vuf8D0c/NYJoLoz9wmT3C+ohYtQAn8WTlAd3AQNx31s9bR/HZAA95Db+4M9ZF3oiEOykSqH4PmZOchJ7+WM/ioce/s7tw15qJehDTSWbUwghUnwlMn2jZdjUkTyk7Dwt/Gy66yRQ6e/dYxHLH9695AhTPgjNZFlLLwKa8mkqgNXnuMuFp6+wr91kLTI6gcBK7MOnBEs3kOKwbPAFnU8Hfy+ZmzUJ3qsG7htY5uDf0WTQm9Rgko0xO2TEzO9eoZVngJpkwx/lKqNe2oL/jtsQ1yr3er7tHQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olg6x6gIBRCX3XRAJwskDZxQfvsgopW0/q7GuEM3rIY=;
 b=PSggnLyFTZTLnS2InpmKbrAyz1MzBg2SsREAKKw7sEkHU5YcgTFk1tEbV/xRVoDNKiC/FttGvpA9n1NaSZ32heuJpqopjnFovoOFjGT2PjuxSfm6jDSjZnh3N0uazO4v7GD1haJ+/KDNEyBHXxGYQwKUBxQ8k7ZZmUq+Df4HyzyxBTLZwjvhJPkUMFiyM7ZP9zgafbb3x27l4Yujy74HWsdtfNtDVbbx1P2rpkvOvmqJIGSpxojJZ0TQqKwawBvBneKjz90wy4DsEcbhdtvARLzz0tjuZwsAMw5aYhIVdLpx3HLqge/yMP1T78LwIKia955/+SzLK0Xn35gv8H1V9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Wed, 9 Sep
 2020 18:45:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 18:45:08 +0000
Date:   Wed, 9 Sep 2020 15:45:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v4 for-next 1/7] ib_user_verbs.h: Added missing WR and WC
 opcodes
Message-ID: <20200909184506.GA963109@nvidia.com>
References: <20200903224039.437391-1-rpearson@hpe.com>
 <20200903224039.437391-2-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903224039.437391-2-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 18:45:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG55e-0042Yy-G1; Wed, 09 Sep 2020 15:45:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60649dc8-63bd-4dbb-7b90-08d854f07941
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44835C6C4A1E9D428A71E59DC2260@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uvbcZqyY0piMguTY4sJ1yXOAELfs5/LEMeSx1gZKGYBlRZSekKCzACRvaUX9Lg246hGHvf051sdweVVR1AGGm1GpLQ7KYFDlV9pT14ol6B0wwXHlvNNeIfa7yXPfh6/ChzzLPxFKrHw7qfd7M283MAa6ey3FvvkvLiUB7oQ5yvkxHb9DZfQUJvbya62Iqp3StzgM6dAUVRgpenPsoaq+4hv6XP/Ang+OpQYTW8cMDPa+iuUS+KptQjfdQiwRXfwrtU07GvVQLSDCoQMZkTGdFNFI0wQUn+1sS+H8ZtCloUFbZ0/rMQnI1Z9Qz6o2U35FdvpQEdgIGLhr1OtriuNSEsBc0t1l3ene875xT545BhqfosmATH0TrTo5ZG2YfIaMHA4fowrQv5lJxBnyOS9Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(6916009)(2906002)(83380400001)(8676002)(4326008)(86362001)(36756003)(8936002)(5660300002)(1076003)(4744005)(33656002)(9786002)(26005)(66946007)(2616005)(478600001)(316002)(66476007)(426003)(186003)(9746002)(66556008)(27376004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LPZiMHFQnSXDNw27AORb5MyFQQ2ooAoatUcCB2/vHZHzkXnxG9XMAzksBRxp4kKpPMk/j6arvecOLJjEFehOcP7Bf4D3GFggloOAke9YPrwf9ir1L875RFbO0WW0cJFyJGTsrbLsyKAYlAlnWASVLWtWUM9axPtNfiOg/2UTyUpZ02tEMhw2g024Baipr01amrBQO0EfxHgUooTeC9D0TcddgimYbGmWRhk4gXgPILBDnbPB3o09YmHUwbTineQb0qu+w1jKcrTQYmi7pa8g1RN881BJW2ljQFgxyWVIT/pNaiA2mm4Ttio9zSe/0A6kDzgAYihefzyHjvwHhdx4coIxiAXf9P2Sh+Z0iLD/1couY0cB//xmnrrVXApfY7mljLatQNF4o+/lZ+2p5kt6cdRyGEgmqlbCXyYLd9uij7CL8xLE3vQ4rMSFsOqm799KvtBR+zfNNWVGMrU9HZiMM95Eg6EGQBgotWALvpwDV0FXxvU8l3/AEQX59i/12lOARz0JzfXx3V1eWQWcD39Pz6LTDkC4MshLcWR54B9KsiwSZFPEAAcyYSNruzJqHMrf3QHlAhXqunO/sprb8h2U5uWb5bi37cmYMTnWhlUJZ1p1ht44yLpns/u9R3drsJxNLUObZWZYCzHD3fqgazU3EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60649dc8-63bd-4dbb-7b90-08d854f07941
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:45:07.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /61nTgm0kgRk3Cvam37SirYtB6a0dg/z2ly9SD952xXqTybpfp8mY7xj2fgIU5uG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599677096; bh=Olg6x6gIBRCX3XRAJwskDZxQfvsgopW0/q7GuEM3rIY=;
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
        b=fahAX5rgTs1Y4cdT0jHnERw2YDWTQKZmBvrfZsqyaxyvulnU3ArBBfHztiqCfmdST
         2CfhxT+f5mXO/97FWMDzD8ls9J5CvC+IVIWSNu+oes6PovZNs4pk2EkK1RQW86eZvR
         IrJ2KP8gVpqjU9T4QMjio3ldWXTP4HNvO92wGG35ZIkx5oRSpIpR12wFVnf3Ynx8Mq
         zdqGeEscHgQZyB+obVwt6nFwcSX5FJCC2crlNryq1gWpmU37fG7CpWuDJYnUzjR/SX
         N6/8v5IL689OxmMg3ZuxctalZs30z6+3orhg3eUtM+ELrFPVnfMa6rkIqo2jSIJYwe
         HOl21Goo5shDA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 05:40:34PM -0500, Bob Pearson wrote:
> Added work completion opcodes to a new ib_uverbs_wc_opcode enum in
> ib_user_verbs.h. This plays the same role as ib_uverbs_wr_opcode
> documenting the opcodes in the user space API.
> 
> Assigned the IB_WC_XXX opcodes in ib_verbs.h to the IB_UVERBS_WC_XXX
> where they are defined. This follows the same pattern as the IB_WR_XXX
> opcodes. This fixes an incorrect value for LSO that had crept in but
> is not currently being used.
> 
> Added a missing IB_WR_BIND_MW opcode in ib_verbs.h.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  include/rdma/ib_verbs.h           | 16 +++++++++-------
>  include/uapi/rdma/ib_user_verbs.h | 11 +++++++++++
>  2 files changed, 20 insertions(+), 7 deletions(-)

Applied to for-next

Thanks,
Jason

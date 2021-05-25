Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2439068B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhEYQYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 12:24:20 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:64427
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233070AbhEYQYI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 12:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4wuccrCj56Mc42DzF2BE+UyAmMM4ZkEJwHvcrI59Se7FuBwMGa0gw6a0kuTR8IIP8aoVBtlyAykOkUniriOipB2KM+lf0FYeVuFDJ5/te80F3s5hD9bRxwQwsfUvAPcVbTjxoa/rspO5w8eDdXf2gR3hU0gz/KbGfNBSr73lg2YkXVQkXbmHd1kPjepUiuDoKMpwB9CxYaoEudaNp38guaJrNjHd+qNBP623DrqVBbsuK+eL+JZIHHH8sI/UM94klqu2rJBQqLruIEs7NmWjoB1PPH+2scSE0AlEy0Pu/yJNWoM/PV12Lg7qJ9YUyi+f/uij5QWsxqF23jQ9zwy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THqJFN1eE4C/6b7kK0kv1xPl8QmQi8khWx/KFK5OxMc=;
 b=O2ogZvuI6TjeboDWRaXJ6KC8pM6bnyc7Hh+l2hpuZ1GUlCNAjuKI1a9Tnt2tZKRFp+84E+GWYiDFkvN+vySeRxvFjUoM8+d72NIt8HjnY3PWWpi5x5Sn5A+Ne955perQdmqnMl5TGM4/b5994/FhLKfrblQa6GLnMRKr41SeocTKXIVXwkI82ZzeCsE7dtce1o8NQdmYsx/RCUOHZPpgo3Ak4BDowoBZ8cY0hZFIUpT59qP+Bo3iza/lnY6L7aApJFV77hiN3g6e8O3aww0hl0Vq/KlgyrAyuPn0VvTmKY2lQXFyyHqhKsK6GO6g62kCpXgRnAhJSOiXaJApWE7HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THqJFN1eE4C/6b7kK0kv1xPl8QmQi8khWx/KFK5OxMc=;
 b=Ki8urFcdZoCzo7OV79jj2C5ww162hzGG+P0n4socBj4fED0Rj5WAeJy7XnMNMuY1cAFZH9EQwNGStFSIlXgALorVqF98PO3UMTq0ulkwpNf7t/UuhdcdSK11KVCCOz0eiOtbnOJjdxk8NyAkfXsffgbrL5Hv4VHldJax2COvfU6mUZWzzOeubwd4G+tFkOX5l6TTg+ooHgVBinTPjFHumwnY9N8BAl35BV1vdxfpt7ztdY9g8RNWUfZ6C7siPgq2+oysDY92yjikM5gfAwL6LZoJkPQ4BZafH40/uiS5KEiYjq3i3d8WUB7+chrENDI2Zw0tQo0BQD4h1bVP6bEDrQ==
Received: from BN6PR19CA0050.namprd19.prod.outlook.com (2603:10b6:404:e3::12)
 by MN2PR12MB3501.namprd12.prod.outlook.com (2603:10b6:208:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 16:22:36 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::bb) by BN6PR19CA0050.outlook.office365.com
 (2603:10b6:404:e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 16:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 16:22:36 +0000
Received: from [10.222.163.37] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 16:22:34 +0000
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
Date:   Tue, 25 May 2021 19:22:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4bc4c36-5b41-4d9c-5174-08d91f994f0d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3501:
X-Microsoft-Antispam-PRVS: <MN2PR12MB350100FA69A311F3CCCB5438DE259@MN2PR12MB3501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UowabxNrR/rOIlu87MF01ZsAUoLcFEivhXohRDJnPYRfBoTti+b6MoIK6fxf6lpGXyvwwAjYDu7d5qMeLEfVljbmCNo9/bg2Ccy1CShqKv/fZPCUJkGzo/KeSNiLEGOgxNckhPbBxg7NfVhGSY5c+HJwgzI4xyP+By40W8/dj05xSAMT/ejVYA5hXmZxV/pBRzesQO7HSCRFJdEa5rL2nKBPzihT09JpnYEQr3nFteUNppbpgx36V0Sq2PFGRi2ss0Ol0CwcPVy13qf0INv+c5EiD2l7ssl5RBFMZ1dJ3sHeDklKFOzSwiC5T+JC18Wbt3FMAG6YjE5G0m7DTLop6oQ1Gf7wlcAA+hyuGBnciqYhkinNhBDGyIORPluYe9nd8fZzF1g3HOUhNIN3L5HSIaRW6yjHDFw7+RgDmpu6YUIt9j4LYzgQnBfPZFkF8tPdMWHERsl59d8agXRcrVuyLzVDhU9ry83Hcz9UXGGvD9UUopZYIAdR+VOHymLAGYEe5M/1pkG494YMWuzGkGed3hq7UrjZ9C59r/9ZgXXBPSTwBGfXa8LhiKKuYLeaD5sy0uCfTGCADsRLdC8D6Nk17oDno+5IKntOduRf2Qf9ZkJ450MWt05CQ3lOVdi0F+rDWJ9mACsrkkRwnD/k+EKJMp5oFUVcnfWzqzVVkuGIHzUdFYkcNenRh9KK1o6r8rL/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(86362001)(70206006)(8676002)(82740400003)(186003)(6666004)(336012)(356005)(8936002)(478600001)(426003)(16526019)(4744005)(53546011)(36906005)(7636003)(26005)(36756003)(2906002)(82310400003)(5660300002)(4326008)(316002)(54906003)(6636002)(47076005)(36860700001)(31696002)(31686004)(110136005)(2616005)(16576012)(107886003)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 16:22:36.4467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bc4c36-5b41-4d9c-5174-08d91f994f0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>> Since the Linux iser initiator default max I/O size set to 512KB and
>> since there is no handshake procedure for this size in iser protocol,
>> set the default max IO size of the target to 512KB as well.
>>
>> For changing the default values, there is a module parameter for both
>> drivers.
>
> Is this solving a bug?

No. Only OOB for some old connect-IB devices.

I think it's reasonable to align initiator and target defaults anyway.



Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAB3FAC09
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Aug 2021 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhH2Nrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Aug 2021 09:47:52 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:26977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhH2Nrv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Aug 2021 09:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9nhWyf3EgKh+D2hkdyoCvdME/FWPMQoyt7SzBWB3GkI2HvI74tYBxdtsbMmH9ALgLH8dGeoqqTDaA6+80D/EBig8w1gecO97Dg+Mr9bq2MtWCXG6arkxXNuDBLd2jl2gWkGIDdMSaCudH8C+hctPw7rMbLaCZt0Yy7u+qlPAk9bdzKZaqrnallN/SZoZqHBd2eZuLbdRt2ay9DG/3/jqRJbOhSppL1vwRUEL0HKeYbom+ZgdcFOU/E2KCX0jX+PhkI+pzvTNJnxvrOIosDZRb259n7qAA1S1PbsAXd3Hpnl/hHnwN4NdH3n4YFu6k26KUbhGMYSorLf/NVlt22iQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTyf+bfqwW6aFDu5vDhCZp3JHOiEdH/KVultPMGLbqw=;
 b=ilzM6neJCVK4zg+hM6ZCV7CoHEe7xTUPqeUSrbCrRCIQ6lqBSH3fQk9wUCi8scpNGooKyDvNdSU+odRY15J/me/oxPwpBJXm/kEZsmJcVc6GIIyDOxROwnAMeR7Dzx39WjiPAl+2thCK9HTgz+Jy+zLFHTkHrbP2apnMw4g9TDU25RyRVBntOQD9mjFIr40x+FoPPkg/QV0zdyeNsp5ZYhvr8fmPwaN+IxYopQ163sLVEILJvZ+iGNjOXBhZ9SOUQoF8zSFqAXi+b4qS6icP/mwFWTuFhxDU1ctV3SuzVKGPXrNqwXz5wyqLOg82mW+5bJoiSZGCnlw5PSVa9Fq36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=netapp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTyf+bfqwW6aFDu5vDhCZp3JHOiEdH/KVultPMGLbqw=;
 b=rSKsyWJ2UQURjwx9HXrJ41Iz1nUSqlQhm9bq1Y3IjXR8t5A7CxNn2porj26ZdZK56AScD/VNh7n3yt9xbkWszcizo2aJpxVeUN+glJX2+MQ8qvF4rXLgg7IyDUN+Jk4gq/VmExcENVd3eKtfkZPgLcV+EU4/Wp57kMsKKk1XGbrsHH/QAURC2jeURqbH1IGTHNshRF5El1CP/leXvfN3hlgW4R+/hSGlIjPH2gXl+JQLdKdTwyTZ7YvN28ssvnAQEnDKMOeLB9dywV3MNq/UJKTJt26NQa+LZ8nmyf2lVl+Xs/c5n8P86a/yq4jyU8xB+4ESnYbhVDqhJ7WkgwpF9w==
Received: from BN6PR20CA0052.namprd20.prod.outlook.com (2603:10b6:404:151::14)
 by MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Sun, 29 Aug
 2021 13:46:58 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::ea) by BN6PR20CA0052.outlook.office365.com
 (2603:10b6:404:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Sun, 29 Aug 2021 13:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Sun, 29 Aug 2021 13:46:57 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 29 Aug
 2021 13:46:56 +0000
Received: from [172.27.11.223] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 29 Aug
 2021 13:46:55 +0000
Subject: Re: IB_MR_TYPE_SG_GAPS support
To:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
References: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
 <YSiF6iER1CXmjit1@infradead.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <e271256b-0276-eba0-ede9-ecebf8bb56ce@nvidia.com>
Date:   Sun, 29 Aug 2021 16:46:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSiF6iER1CXmjit1@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a151513b-be33-44ac-7f45-08d96af3783d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4585:
X-Microsoft-Antispam-PRVS: <MW3PR12MB45851D741E4E85AB75215013DECA9@MW3PR12MB4585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWNOR3k7pMGFFz9KCxF0VjS5AIKzUZpZKOSSj0AOuV63LeoCLokTnnGV8gnQdgbXcWmeCo0mgAk4FAkEMbiiw3XhNI9xx74mFEmrDV3612QExRwhNUnkFhL5X02kKcgFXR63knBvBARuVvRP1vlxCYQ3Zyo3wJr5s53Uwr1iHXUEUalpYb4tjCC+lQoFDXWQ/OTxXzgjFSGCGNvW401SSzyEt9EqI7SZVZ3/7UazubU9SqiWBVpkacKYmAWAz4j/vdkpHZLSxI5hETwDBmA2OTurYR/jFScbGxVPZ1FuTPKcK1Fn7kwIYPw0dFag8Ermqx98BmTkMwnHVIC2xzmo9hPgfvKEO1nGtcdfZy8jatvmsySsq7v/8fUYfOEijv8nLd90TPck/KhD4XSMbKwR6Xmds0dLIZPSU5ObKcwZWEcJ/wooaSqrN9mYEX129FHKAvANWAQBnnWsrm0MO3hT3/xgsXNZbqNUuMNNm0tL7M31Vx/ijXrbh3cJ6NFTFmlpQxDRwbM90o+x7B4clm6f8FzVzykFH5hMmlnfTuVKUpYohoLt+lHHsAicifebzjteuuqBxGY+3XOJH8J3HkQl0HR6qv7k/liSSpoz8bKvUcN+CjWjbIlGbB1Sax2UqXpYGO7ccU0nTxqaDlk/sW0Bh13whk+v94u5x2STL+vrwe78iGLkfPKIF/Iui3yPQ3WyQcBni476hckxN/T+m5QSH6XaL7opk+qml4mlgcN9ey8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(356005)(426003)(31696002)(8676002)(82310400003)(336012)(7116003)(70586007)(2906002)(82740400003)(316002)(53546011)(5660300002)(6666004)(36906005)(478600001)(70206006)(16526019)(36756003)(2616005)(31686004)(7636003)(26005)(86362001)(110136005)(54906003)(186003)(47076005)(8936002)(36860700001)(4744005)(4326008)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 13:46:57.4860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a151513b-be33-44ac-7f45-08d96af3783d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/27/2021 9:27 AM, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 05:26:11PM +0000, Chuck Lever III wrote:
>> Hi-
>>
>> I have a report that net/sunrpc/xprtrdma/frwr_ops.c::frwr_map()
>> is attempting to register a mix of GPU and CPU pages with a
>> single MR during an NFSv4 READ.
> What GPU pages?

I guess it's GPU device memory.

But as Jason mentioned, This is still not supported in RDMA. So there 
should be a bounce buffer in the IO path between GPU and CPU memory 
subsystems.


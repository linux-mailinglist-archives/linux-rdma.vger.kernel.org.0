Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF8390E6C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 04:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEZCs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 22:48:26 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:49376
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230312AbhEZCsZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 22:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBZBJj73n7XjUPdFZeyLkf0hgK5K9dJeRqclCtieO2/MXE+k4p1P/9gTEBv7IcNfvYCmI1u/hxJq6DStoKSnPgpm4xE+TMjAHY94Eg1QgcxmUphLFif7vvl30T5fFNmM6TgEj8EHT8NKmBDrvGSFPZW6YD3lJm8G6+JqAzSA6ESy4VToDcDuoY1qk0viWpp/W93rfYRc4SW4gjtLna/+vVt1k6aBzB947ib26dke3LPf/LOxbMSfodWHeD6oIg+xBm8H/LkGRtmphUzwNOvWsxtei+ddfr3glPYA7TPzbu64yCWweyciiaGlP0pO3Mztls88oG7XICv6uKFaqGn9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bua1nJkJgwbTE7hpam0755B0oAglaYeIhZHDqjWkJ2g=;
 b=lN3sBKudaxBS5aTAl3zQhEtTEP3uhP1l5H/FUgLME8B3mupeyKK8saaIzihvZDsFwen9IuPlpVF1Zw1iEce72LmOnlCIJNM80nDkRMrVyvL/5/zW4JElPZax7PpugpAWkpDlRbbGwQuZ35IUfApQhfA+VB7cHFNE6qjf/gE4j5NQ1J3ZnaCihBr/4CAzGhNkSmNBtR6bTltGiYtDf17Z86wNg75o4I32vh7nnTDNow9+38iZFtIGrIuSShdp2dEN2bVyUTRHXnZ/sOiBv1z7gWgCwA8mEERjri/Gxl8DWUqvCJ1Vztx+4hf0+UN33+WpsUfRDpdJCOb0qsMXQzt4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bua1nJkJgwbTE7hpam0755B0oAglaYeIhZHDqjWkJ2g=;
 b=TcYbq7tF/MJVlp80OIiJFdPU32zTeIGifxSe9o1o5Bfr2l76pkLzPBgUZcG8qUgDJUlPuMc0n1VQcW/vqRQOli9Z/L6NlRsNviORsS0seZbubaQEUbSHs32nQTDSuHZNQbC1PdMzrIHyh4M/CIWHcFpWGIxBrVV424DQPBOejCftEaao4O2DLkqntk8lIiDlbTZ0d9zt0cWhdsaTzQV5kcFN7loWN3htj6hh5dXNUXueti0aFmer47vwEHOJ60ignbtpNBQTvqzJVJ/f1i438BwOumiUGJ4fjvWcnU5cC3Ac3aZdY3+S3CZCbEDNWLGYiUR7uc+1tLT8ozYjz9HGBQ==
Received: from MWHPR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:301:4a::16) by BN8PR12MB2930.namprd12.prod.outlook.com
 (2603:10b6:408:69::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 02:46:53 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::1e) by MWHPR1201CA0006.outlook.office365.com
 (2603:10b6:301:4a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Wed, 26 May 2021 02:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 02:46:52 +0000
Received: from [172.27.4.141] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 02:46:50 +0000
Subject: Re: [PATCH rdma-next v3 8/8] IB/cm: Protect cm_dev, cm_ports and
 mad_agent with kref and lock
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>
References: <cover.1620720467.git.leonro@nvidia.com>
 <7ca9e316890a3755abadefdd7fe3fc1dc4a1e79f.1620720467.git.leonro@nvidia.com>
 <20210525200057.GA3469742@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <3bea531d-ab6d-3990-2014-02c7a4a1679c@nvidia.com>
Date:   Wed, 26 May 2021 10:46:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525200057.GA3469742@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56d9278-0f99-4135-bb8c-08d91ff084ac
X-MS-TrafficTypeDiagnostic: BN8PR12MB2930:
X-Microsoft-Antispam-PRVS: <BN8PR12MB29301FACA7805BC7E640DE8FC7249@BN8PR12MB2930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP19+TP+rW/bAEV7cY8OG7+aev51YeMaTuQEOiN/ystY+fcZMS6G9+s7U/ao/DUsNNj7A7k5p3m2Y2+G5plrX3mm1uq+MPSdFZlwVGh9E2mm9BLo9D++DKHa6uvEB8PwMnzZB5iyv10i1K59o/2CR9UHGYLwJql0kWYOUkSxrolTjatBVvtstZE3DG/6gGDesK0gJ1YkCT4Zu6IPpZS4S6ck6xhKPnMSvWJd3lLVmb1RJzCNnfyZOJFygaf6InNVUV7kCP4gWVFGJI3Wzmr3EEndlA5cNrm46bMzBnx2A34XeKEaKB8f79uQLZ5iR5WwAsMpbnf0Sv3Iu9bdz0qbDN01fthkgVbz9+CCCB25Uulzyc8zR/4uf/v4lgiuXYLQNnZV0KoN4zrXWgnC+/gbvp5AS0EFajFlwSVt7sfsKXIZ0qVCNf4ikcZ6sQ05/CZoecTV/b0nm7j2h5HU55q2Y0RZrtqgAhDjln9/nHqXq02wbHyL7zYx2fSQDSHLnd3afJ6qkiON+/qi34hw2BSBttu/tPCXtmuGLKXvx6zhPQL4JESR78erjmMfJAs0708Rmx/tWz97Uza9Kql3W30RuSVy5bFeqPMt1sF8aOih24KIO2JhLAb1bFcbwzQ7wQVH1cjgX11Zjy6Xc40d9mnYmO+Iif2WOIsGMtIZYOf4QIaYWE0xR8uapZ52WE4xgEMx
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(82310400003)(356005)(36860700001)(4326008)(82740400003)(70586007)(2906002)(2616005)(83380400001)(7636003)(47076005)(336012)(8936002)(31686004)(186003)(16526019)(426003)(110136005)(6666004)(54906003)(53546011)(70206006)(4744005)(26005)(31696002)(36906005)(316002)(5660300002)(16576012)(86362001)(8676002)(36756003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 02:46:52.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56d9278-0f99-4135-bb8c-08d91ff084ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/26/2021 4:00 AM, Jason Gunthorpe wrote:
> On Tue, May 11, 2021 at 11:22:12AM +0300, Leon Romanovsky wrote:
>> @@ -2139,6 +2197,8 @@ static int cm_req_handler(struct cm_work *work)
>>   		sa_path_set_dmac(&work->path[0],
>>   				 cm_id_priv->av.ah_attr.roce.dmac);
>>   	work->path[0].hop_limit = grh->hop_limit;
>> +
>> +	cm_destroy_av(&cm_id_priv->av);
>>   	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
>>   	if (ret) {
>>   		int err;
> 
> Why add cm_destroy_av() here? The cm_id_priv was freshly created at
> the top of this function and hasn't left the stack frame yet?
> 
Because it was initialized by cm_init_av_for_response() previously, so 
destroy it here as cm_init_av_by_path() will re-initialize it.



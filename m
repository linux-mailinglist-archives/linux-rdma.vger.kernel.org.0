Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066A323D488
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHFAVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 20:21:35 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14588 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHFAVd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 20:21:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2b4ca90000>; Wed, 05 Aug 2020 17:19:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Aug 2020 17:21:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Aug 2020 17:21:33 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 00:21:33 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 6 Aug 2020 00:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM6gHuAJRtvmxFa2UiTmeymojscYIccL8G5OCWPuV8Uv4rNlwwUBaDTsKGs03HmABW8G5uEvg//cc/zDCqKsax7TTsZU5tGTWLfXcsgoz1EHQi0eAXx5P+ilvPSK4m7avMUpFdOuNxAQA+fjXmbSQWI0XKqAGU9o4ooU/sPV6ooI3kyZguy0QIA00Lge6AC7PpEIkDe/lXrn/d91LV9ZglHLbgYmtuRFPZRcxQjf4PL5lTiqECMvJUFJB538fHg3lQzi8sZDqwjdefCh1J+jAyvrFENhbbbpP+hscfBySDRk4vGNMV4FTkdVWmjz05qCih+k1APIQbdqI3XOk+xsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhkuTq4MbR5ahtjumYSeS/k+GSm7iGHC7AOPZXZ/6J4=;
 b=CwKVUmRJhd97dBU2j5B6nHvHfanP2ugWX5W/lsn/HjB6VqFQXR/CuKKZnLARTXA8o8JVBVnEyzi2NFnnp+dQd70CBRmxusx1jEFtFcEMFhpgDBlPvWyyszGKgsrUCTPoFvZnfCUZQx/+BKiz9U4v8dN79bIWUNznDrXFudY6j1rCwg0XKoA0u90bq41eXr/qq40TDlQ+Y3al9JxKpHOKL4aiNrYO/GBCiS9JNFnT/HkNZcmKTceKtyEsTqEUmsycB/6gbz62JiBV6rKC01wD2KOFP7H98W9jbfaeMslGMUxgjvfmw+j0UwCryhfxhENWQYIo5iICcuRlraH74DQejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 00:21:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 00:21:31 +0000
Date:   Wed, 5 Aug 2020 21:21:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix flow destination setting for RDMA
 TX flow table
Message-ID: <20200806002130.GA958775@nvidia.com>
References: <20200803055849.14947-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200803055849.14947-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:208:178::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 00:21:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k3Tf0-0041Rq-5S; Wed, 05 Aug 2020 21:21:30 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb35e84-b7c5-4533-cf15-08d8399eab43
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4012324E48854870680ED61EC2480@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CI4hi1nA+7kAjURgzZkr64HZTrAgZwfy9MiS4WninHWISBa5Y220HHAIvmmo/2d5Gz4qU9O9vUgGrhzpATfCbOyfG3TWrCzuM9O/mgAz2tiZs47IkB+t+mARIJ5c6k3zESjwN8LSUNQgO58Z7X7ymJ2EqzAdmGeI3Hs/CJgUiruvxiURIIq9BwLRhHHSAXWmPk+xtAwAeSkUUOzS8xnHFuFhD/8dIA8XVWSAeXt0K40n2LLxMa3EolkSuSHN8WeOhCNAzGRG43gFC5iN8WMHfvf1U96DKO4WMcUxfcc8eJ+FqhVHOKtYOGmFPknEld7K3yeanR7/TPBoCoR6kn2h0Jwot3Ju0eALRfJ9GjbezCemu8n05OpV6PT5O76pqAuq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(9786002)(66476007)(4326008)(9746002)(66556008)(66946007)(4744005)(1076003)(107886003)(36756003)(33656002)(83380400001)(86362001)(6916009)(5660300002)(2616005)(26005)(478600001)(426003)(316002)(2906002)(8936002)(54906003)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3KSGnn8cqHfhgwHrT0ALx061IKSsOpaNF3NOU+opknAku8UoBKXwQ1zxkz4VT/jfSGMGjRAXXoFvnfk9z0kzspkgk23w39RKamSnpjhsjt8sXLEhrEfUG9DIn/n6nf+c9yaZNWM8Gizj6Tisy6p1jT5ePD+3Kcung2V/Y5J3qlMjlkyuWNK9570rt9VmKI72WG/5jgTgeVc8NJEMxPJRaoge2sqrDSpp23OUZAKF750Vcd1tF8JJu73jvACFVcX6+Negi4Lz5gNTgeJq1Pq5NmikzTlGuQTtrZBk4Rr5PSDvca+JY/sXTBe5xxUjdEXfyU8n/pChbX/bpuKAV7bG3QkgSa6A7O7IQ+qUaK4dD8E38dBHjJWBfVb7ka1A+2Wht7hzF703mjncsykZcfqGle4ZLGFLQwWTJL8zu4fCY1ACCbj7nXXV6MaUGNsXyjo4K9h5Adpptg8HAJXOL7BaqNfeIEvGey50u7AHUM7HyPuZ/W1S0+J9WYB212+g/hGQbRfqFRG9b8PdKVwzplLhiYLHMYht961EG0tmJCcOhiatInDbu64AnlXWfv8+R9QbOpc1aSmjUvTcyfIQAz6LG+GPzoHtnDRdgg1pjoc1GJuSRJu99pJm663kfXk3atHfV4d88WsRzKfb9QfZraaiiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb35e84-b7c5-4533-cf15-08d8399eab43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 00:21:31.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6xZbOhT9cBoKcIeNWIw3R2/hXBFaUS3Kbsg0YToLZOpQT9hKh4sKaNei2hhn8wp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596673193; bh=nhkuTq4MbR5ahtjumYSeS/k+GSm7iGHC7AOPZXZ/6J4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=FFXu/nnM7nqynxikDfdTmldCTg9mMF3sWkgSagdu/oQU4iV1WWVKssPdls2BsEPoV
         v/VwgQxwEG1Tv02IDWFQTFK2aTXo3o4sT+bdzg7HM0eJd/grFL9tVrv4kZsok6uTOX
         31fCl0eEYOIf+5VzkZCUIKF719yjEYdHzMGV3/Ubdd/vsg8Uc/5QR9Zy5qf1sYAyKK
         X/7tOf0xp/XyefEQ7gr4QRzZcap6NuTxU0qfvU18E/lD20DUMLCOERcLQSYFyn0sNk
         NGV1+34Lxlkzv05OJ6Q2g2tozEZVsKOh9+rMNdDTrQ/1N+QBmsOwwgAFyZqFYjBkNS
         Xx14YhDmh8EdQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 03, 2020 at 08:58:49AM +0300, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@mellanox.com>
> 
> For RDMA TX flow table, set destination type to be 'port' and prevent
> creation of flows with TIR destination.
> 
> As RDMA TX is an egress flow table the rules on this flow table should
> not forward traffic back to the NIC and should set the destination to be
> the port.
> 
> Without the setting of this destination type flow rules on the RDMA TX
> flow tables are not created as FW invokes a syndrome for undefined
> destination for the rule.
> 
> Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-next for this merge window, thanks

Jason

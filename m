Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741582504D1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHXRH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:07:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16855 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHXRHk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:07:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43f3640000>; Mon, 24 Aug 2020 10:05:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:07:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:07:39 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:07:38 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyIImBLjLLHG8E5EesZlsWH5D1g4TxLYdyB4oABn1o0UXImO6tLkYN1ofY5CSNTVcy1YVarQh/e1J9WfZMLcKdZuRDtFw0olPuamE8LxOqFLF49++yWSSOxr160vs+7JQW4SfuWwYfKZfa8N3ZPWU2NOK0Pn18vBLi4GavFetA5PLGAuQqYcC7b4a842J34rvFRsd6cROE53esk+timmjDqaNsd3HO978ugf6A+NY3R5Bw86NHT2Gd/H60kmaIgLr4HS2iTc7O635RX+jBUA57p9me3mxGGuikzLcR+9UeqhCmsLrZaywvtE7OLZX3b+RQ8Zhe1RYPg55S0eI5tl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEdQA7oYvFCqahgnuL5F1B8NlokziAiUICVJoUyopwo=;
 b=c3GH1vztEv3UcIAHia8JAQzsS4IHJjlD4vfsh66eE5AgJ+X0cgaxrxAAk+yh4JhKQRYSkjjlIFRxyku0VVpni+OwffU6zrxVxwcBXqV62D7eU+jPUl8N9zr6+OhX589s7DdlibBv0jXdbryXYnPOIldP5z8kx4tNFRI9qZS+v7g2fcVNwL7PmU9kVGBzBjTkzSIDwJXsilVj6PyifjR0On5zCPYfnFJdZQJ2qbxRoIEJ0Eqknh8mzLj3j+YLN0nQI5JG0h0B9UU5k4qhh08SSbMfCQoblQUXJ5lvh54+eyNvO3hDHPiukBH/xBuhXya+gBEvKvdLSKqhuIEEU2qkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 17:07:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:07:37 +0000
Date:   Mon, 24 Aug 2020 14:07:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <kamalheib1@gmail.com>, <yanjunz@mellanox.com>
Subject: Re: [PATCH v2] RDMA/rxe: fix the parent sysfs read when the
 interface has 15 chars
Message-ID: <20200824170735.GA3209509@nvidia.com>
References: <20200820153646.31316-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200820153646.31316-1-yi.zhang@redhat.com>
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 17:07:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAFwV-00DSxI-Jp; Mon, 24 Aug 2020 14:07:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a5982d-8be9-414d-84f6-08d84850333d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32102959EF2E142F0A70D32AC2560@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3vZhSDlZx5HbkrBsuIy1p+0HuHxRuYbGPogc3D3DxXo4ugJjTuDSSiDOBM0DBhuPatZkKKHpaTTYpcFEd1n3gJ6B8Jk3atBmK3wZK/onXW2a9h+tbIllKPll8WbwBD8YY9EOhb6vfLsOS8G5wCO7YnIx2+zAbIM0Q9iEj6P2SVLFT4gEfQo5xUgdHyZJPIkJTx/k8X1w5emqxHF69/i7gjFAB4jHMuTehToHJ5hRW6+uzFFQp5asv0LG2B2nx/GbSHdem2hMnVPsdIBvSGdLMvw8lPLZfJfne0wLVFcR2HIJJ2I+LrmVkwZVtUHvyBKlC7zcQRWENxB9qbo3biDuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(8676002)(478600001)(83380400001)(6916009)(426003)(86362001)(36756003)(316002)(2616005)(5660300002)(107886003)(186003)(9746002)(8936002)(2906002)(9786002)(66556008)(66946007)(66476007)(26005)(33656002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A+J9TiKxDvmgsWTOaSkU8//UVk36C60nd2sPRWD9Yqur4HlCvHPuMecpi+i9DhYXcjvPZ8+uRI0ek9Eimib6U9l5edgyuD8t4j8n/GLeR8iPo6mGxJwOuxnfOiVIopXkxamZjKs6y30wxrf0UNfk3xbfUwTcoXVWzl9hUI0eyoszyCjVjq1r+FgvYWHvPqKTcQaXNxa08iYV6xVUEx4nFijEkDas5/oS2t5SYpuJffVfjkG/9ESm3LNNLgPi3BQsfGCkxYe6/tPO7PtsfZU6oPCETYAOxLC4HgRwv0KAtg9CcRxaxYViwIZDutTBPj2jz+YC2OlgAialdCRKPm1piADsgszzcKKI7E8gL09zgqrCehEjbR4KUCcBRrBuAh4ZM4zO2u9c9+2wOmadRwHEdUP+T+bshcRqpLf4c+9pXT1HhXit2sQhrbvQdXtEnPY8loF/kSsTfhPbCRggv7gd7NxCrF1v8G723XvNKT1epcZl0BKMTY0fBK1EWn6EAoBe1v/KoBjPK2L0fkh9PCA6Qc9OP1krMWVzsy7gAAcX+CnaCRM/9uKQoranAZ4eSsVW+KkaY8DZu9Sc+PokAPUSUmmm/bV8XtDbgqqyUUqXYgIge3zKGA7EzNMgUPJT6/Ycw6Byusxa8BK3UQI2EkZZiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a5982d-8be9-414d-84f6-08d84850333d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:07:36.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1mPtAXaRgZq4+biQmxtd6Eblck8r4VzDTwH9OVmUtXCeJMFlIVOJ5sso1rftY2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598288740; bh=LEdQA7oYvFCqahgnuL5F1B8NlokziAiUICVJoUyopwo=;
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
        b=Ih8gphFU//bsBbiLupGeuvGMaVJIBq8Yxse/xz7ZTjFUWsLKZNneh3l9RjM5M0F6/
         ahl0u08dBrb16HBzByaSXtBWt7lGEQSW2aW7f6mJ3n5DWo3V6ouSdiAeU4xxjFKUrT
         ffMrk1IP8lqaxqEmKfbJZ4AKOzY6oDBtR6P0P54CcRqJQM1G7j7MhWtaRYqSNf1lAb
         0yu+yqp7cQhK7GfMLkGLPz8quVf3169fKbieskMpPOYYQEr7UjsLascH5izJke0FDC
         ZRiMiggh3BZYkt1QJL4VRzHlujz8MnD+SciJ0ARY4/TtXgBApVic7O4SE0m4G85xXU
         GH9nmtcQJl6zg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 11:36:46PM +0800, Yi Zhang wrote:
> parent sysfs reads will yield '\0' bytes when the interface name
> has 15 chars, and there will no "\n" output.
> 
> reproducer:
> Create one interface with 15 chars
> [root@test ~]# ip a s enp0s29u1u7u3c2
> 2: enp0s29u1u7u3c2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>     link/ether 02:21:28:57:47:17 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::ac41:338f:5bcd:c222/64 scope link noprefixroute
>        valid_lft forever preferred_lft forever
> [root@test ~]# modprobe rdma_rxe
> [root@test ~]# echo enp0s29u1u7u3c2 > /sys/module/rdma_rxe/parameters/add
> [root@test ~]# cat /sys/class/infiniband/rxe0/parent
> enp0s29u1u7u3c2[root@test ~]#
> [root@test ~]# f="/sys/class/infiniband/rxe0/parent"
> [root@test ~]# echo "$(<"$f")"
> -bash: warning: command substitution: ignored null byte in input
> enp0s29u1u7u3c2
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc with a Fixes and cc stable line

Thanks,
Jason

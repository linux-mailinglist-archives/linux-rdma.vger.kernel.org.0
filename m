Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBE248DA1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRSAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:00:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18752 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRSAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:00:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c17160005>; Tue, 18 Aug 2020 10:59:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:00:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Aug 2020 11:00:48 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:00:48 +0000
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2+TL8uN79lTznuNO+eQKHfNTYwq8pJlxOzSMnJ55MHfjqF5SFoe9MlsXxXsMFURau71NY5B47dICvBeERhU7GxVyZ0oUMoALfDiESbFG8w+HavDV4pkZgYd2YHZkkbnIogA8RQ9y1KIZvVf70VcL73w66Z/C2BI/nbPA2+C5ybPQhnms5xHA1NNvo7W3iyEF1UHoOH08ZNEOOZNUtwvtBRtf3VX08Q8z9mVLmwA84Zid3nDRw6yCjGkgjqgGmnm6cnoSEtcH6HJ4/qsjodcqJq30eHO3mz/17o6MQVuo/RP1kk4yuNVTeq+WNcDbBTHIY0nMtG/1kTYm775dLYYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FLXyImUU+rB2RApiDTEtwhdTGcZzmAUKR0iXms77rg=;
 b=RX0amNuHmeZN/ioPxQ8XBOVlbXNcaZe+nfmi2MuNfB/0RbgIDPTmXg0yqydChJoZgJEirYfzqU7Ek+hcAx8XKfHtpaRP+5NOBJrMcOVTvhPLk5AguLMc+4H/zFzMSqWANIJ81o77hAyjOSvlfWcBTnx0BCw+qAh6LP9NhM+sgz/QPwE2sVf4FO6sMSFDprIkxQnC2cy/Cfvq/TjHzc2nNNKW9hSerhCJ+/0r8tzOAH3NFU+p3n8g2Jc8WmTiYrJHMh8tCvrGYSge2iVtTaddqVehJGBWe6x3h0fJXdQJbKgpm2BRdwZA1Z3ZltPKCrj918cLVEHBK9RJ0pfPq2+nmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 18:00:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:00:46 +0000
Date:   Tue, 18 Aug 2020 15:00:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/4] SRD RNR retry counter
Message-ID: <20200818180045.GB2056204@nvidia.com>
References: <20200731060420.17053-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731060420.17053-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:c0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:c0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend Transport; Tue, 18 Aug 2020 18:00:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k85uf-008cy0-3C; Tue, 18 Aug 2020 15:00:45 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94cae423-3fcc-4d76-ed3a-08d843a0a1ed
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0204165FC4A9EB04A0C02C95C25C0@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9gzajReXIOTNmL65VUDKW6RaH47lHspPvQ6RqMyzjm17w6EOW/nxN94uHx4imzL59nd7Ab9euA642zoWBa3YbAWwl+r12Btw/lfX+XdNM63UC+8E58rIurV2w7ry4RCXZ8ehBDodaOSw+ebnD473g7AoRzdW3dfE1nyt4GIPrS8aqDJJyDU8AmFeBFQegIDHxjs+U81cTKYNzSvB8gkd0akREi1OFfyfZcXfIz7fgprXP1HkXOftL5UfhHZ4SVYEtvDTlqzif0iii2app39DMmLmCRuq4GxwMT0/dgh2hJZ7C10LCCc04NcI94iAWxMv0hjpiunwm2UE+C1g7ksJ84lOpD61uryPfk3HQhA1zE4eDwjIK06rZl7D/3cq9xwpvCweUVdYUO2Hx8IFd+Ktw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(2906002)(33656002)(8676002)(4326008)(8936002)(6916009)(9746002)(9786002)(54906003)(478600001)(426003)(966005)(2616005)(26005)(1076003)(4744005)(5660300002)(316002)(186003)(66556008)(66476007)(36756003)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: a5esmvekfxLivRO9usu7BB+Parh5uFFLCJr62J3xmabvvk2tAbRUFusC6pFd0SgsElY9jSYBvP4IHKADLcmrUsFTgAyn7ilZiNSa+NVzK+OCo2Z4SMjmHkYbc9wGGjbWAa/N2905qYlWcQ9TebpokSXaP+eRlRG5ioOvX4RB7SQ/5MWgLa2jEobJyvl+XwJ27rIlmvuMIyJ5PStt4nRo0hUdAViGoy9Ocsiiw1yfkPpkLd3bAF2VULwi6W9X7dHVWTZQrNWc0btyuFV9OadmOL4pXHnqiwrZX4KEqfLRG4TLYIHyLh0Juglnuco2eAjYLWpqZTW3PB7g9XGvVDf/8jYvlWx+MXmiDFNXI0t3Lqq+Vqkw1T7Y1KvImO/fjDw1bGKa+3KvbcFw5Afa5Y/ynKwDHWpWjEFBvOhn3CDg9kOt+hY9leouZaOufNad2KBDonVL3Y1xLTKEknkjlPxUh+KUOtbPkDj86iAWZ1dxoKQ5C0ZTJPc0eX683oH52HTCTq6QoPUVvvvhjBT7pzXl/tASGJ5dx4a8Hycr4d7oH/VZSNIas0W6mz9wUYDDmIONCZkS//580S6puGuo2U3Q4avuy/6M4CKco+MVlfTQPmr5y4NOJncHj1wDC52B7dtcfH+gYwKpkyGcqYxXIR60lw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cae423-3fcc-4d76-ed3a-08d843a0a1ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:00:46.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8a44Sa0hptHYM2EDji8Flc28CDNxGU1P7ZbSnbZvR6NoTkn6hJ6hgmHPTYLTp5q7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597773590; bh=7FLXyImUU+rB2RApiDTEtwhdTGcZzmAUKR0iXms77rg=;
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
        b=czhuCiF9wBpraiLlbjMH+TRcljkRTc6tgzqw3zcbuNNYrFD2iNGyY3/wZrq8nrrI5
         LHCu1xj+TZR745zf8qI9vwU/aXsqaarAHbwieZf3316dR3YCTw5zYSd5xxADgDl/KV
         NQzLf7LCS+kVLSSS9MEkoBt1Uv3dvJZpmMI0oRkaY6VhzGZfaAQxEpv9iROKV8bzAV
         F759d9DmlKIQ2T+6TpM1SPEU5UOH/xxtQdD3R/hDT/VG6AszfPkewc7Y0xvER72fDD
         rlbtQieofPfXz/P8lGSIVhG/YnpY8NHB21DFBisyvNKl1RjZNvufxSBF3u7kM+lP7/
         m2hAkDCmNmKzg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 31, 2020 at 09:04:16AM +0300, Gal Pressman wrote:
> This series adds support for RNR retry counter on SRD QPs through the
> modify QP verb.
> 
> As the SRD QP state machine is no longer identical to the one of UD QPs,
> an SRD state machine is added to the driver.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/799
> 
> Regards,
> Gal

Applied to for-next thanks

Jason

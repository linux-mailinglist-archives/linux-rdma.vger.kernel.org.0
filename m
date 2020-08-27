Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493CA25446D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgH0Ljj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 07:39:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50815 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgH0Lit (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 07:38:49 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4796170001>; Thu, 27 Aug 2020 19:16:39 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 04:16:39 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 27 Aug 2020 04:16:39 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 11:16:39 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 11:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJKCUrBE9pAKyaaGILJK5x12XyhekbxwAqfotsr12gt9opYgfbkwrQ1iwSKS+/qfBoZPNru6pX9sKQB5Uo6bgFIAYtXFtk0sHyR1vX6i+J+i2965lUWEyZyw57dOuLFfmsYvVzc7naXwA0XlohO7UJvSm1++1ibzkshjcppLSxlbfp4vjfkEPgwWp2hd/Rh0sdaj7pYUniNBJIt57M7h4E2awUW5nsSC7pgoqY9Uz8T+ttkJc0XoSpnTtxdNoo29SzAJ4M1Eiy7gx+znnAxFN+FlN6L096XWyU+l5j9dbm/s5PDuhXV2GHMCLeWZrv/+J71FYqYhgdqf2WycNtSNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s133JkfVDR0cg/+mEYo4jegQ7mBOZp2TfgSTUlEP44Y=;
 b=DImuK+r4RhhOuWvukVhnQ8YOpcQZT115vTQSkfbuJJIfvIcnVlYhxo47a5G6FUaBFGb8HxF/idlKgCP7e36LTsBHh8AAO8kkO7+Dftb4hLj2bnvuCrNWgnzb0fgtl9ACsMgUixUrJLZXHuBns5P68Fx8MDU4E41Izffk4GkZhbdgm8td0yA43iXEyRoJudbnPggRmW2LjZoFQhOPR8pWUPZXLK8UFR+rXbPor/y7Y+5oA3oaG06+nlIgLGzGlqfsXcjIDErrq6CCzvErzW46FSvm43dqIEBdbh3enXUMpr++XwvTLga4DtNnvQcsMzmjLwVle5nTGLjn1Dz9d/ioRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 11:16:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:16:36 +0000
Date:   Thu, 27 Aug 2020 08:16:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: git repo changes
Message-ID: <20200827111635.GF1152540@nvidia.com>
References: <2748fbb3-f443-f6e7-bb8e-92ac33bcc19b@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2748fbb3-f443-f6e7-bb8e-92ac33bcc19b@gmail.com>
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 11:16:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBFtT-00GeMQ-5i; Thu, 27 Aug 2020 08:16:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c6be19-df89-4e2f-0243-08d84a7aa96c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940D6CCC1D1DDEAA45DCD0EC2550@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVgNVBcQlt/FaznafXNVQAIiDjO5YpwRl0yt9mO5Cnf4w4wkSBYbx2ue7jC9wv2abHufw0aLA0s+K6ZfUtuyBPX+K+iE62RESCmmFR5XkmCMRiD4QWWsMKxk5NlNtPzvx9P1YV3jIsb/iMShH3TVux6bAuvANdNrRvejwSfJPxh4asuY07/kCBGWdOk9MR/q30ZFgDQFpILf7koh07eYMCX3TPZ8M1lEJAdqW7mpQ6WrmKyz7rSCZLR+qbEffD25uxjQm5xJrti2KUR/FIMRD3xsIwz/qOEJ2uMSgpBgE/yz4jR/hCBidX6IOl73XHbDJEZAt/UbSj9osUfkj5zPmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(9746002)(9786002)(33656002)(8936002)(36756003)(478600001)(6916009)(186003)(86362001)(426003)(1076003)(26005)(558084003)(3480700007)(316002)(66476007)(2906002)(5660300002)(7116003)(2616005)(4326008)(66946007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zkuLkDUmvM8pYlk+Yf5VFG+LcV4zdikxiFcLXGsxk5IC3vSH5PSNqwl8w8aoSK51ceKIlvE9I4Qsf+KBkhTHpR+3CV2FM9FHF8/kY5753APhp99L8OR/cwlXuu9ADtIOZjnFXjLJSedV9cynM4RyGQhi5jVsL0vDSrOWoIzgU7ySFpydh5kXGiS9x/zM+Us5XKcOiwJmML9Yd0xhDbAqLU9nx6/GGn6gyq7LzLEDm4xjeCNdiYUaHMpEXrhL33VzMNvA2fL+Y1k9Mh/yi+RNscB3pQ/Ln+tiHRu73PpeIIVYpcQLHKc/4UAOJf6VsEiClPp+tuDaBZybdP5owAWySoKRv6aCOibgmOgHlU9ZllmmdZCW8+gL8JBwF7KUMw4RqZMwIFlCcfH9F9ucC9BfI7cQ4z8VK8IcWg3x93n6Puu/uNquN7vwUZ2jbClNuHY8JXkXXz3AJuFSMdhBEo8qZYY7sqoQeAHEIL1blV/PNe+JUv/HQT17Gym5eOl/Wyvc/GrGovsyM01Pt699mARv1Cj4SQibyzEdkiobSQQnESHYXZimUg5i/8UkPWW/4N7ni94uz0/9cXnS9LbvxW9dmKl7vZEaGMqYFJ1jrKbKwrlkvcmFErracfTP0Owh31pPbzlwC6IWsJfkCW7kV7f7nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c6be19-df89-4e2f-0243-08d84a7aa96c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 11:16:36.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uit6H2kQBFEfQMZVezq/EJJZHMj3vtZOAvEg3Dzj36LuEZTOlYd803Dz7CGK2FAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598526999; bh=s133JkfVDR0cg/+mEYo4jegQ7mBOZp2TfgSTUlEP44Y=;
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
        b=d6wBdoqxl8N7WulXFUvNXTOH0iAkvXVF0FPPRVDLGCFtD4cABzzXKGcGCPPrMzIzt
         yijU6ZC5sCjMUX+9TcRM4eQyf+2ajnCSIRixk5tNVoNNeucgzinxw5X4lyC+XmZYfH
         u+klzKbHiHE0r0ILp9/Apq/9E3jFrBgOi0P3XBRwhjjnQyA3LJhe1AAZ5nKwWd/CQv
         x8Vkliv5zRUbEOCMihis6exdBwLRnBXE+OIqGijn86tqnBdeZvGjW5MccH6oLh61pn
         jef98Kch5iIqNRaMxaPkKTkTm7pwJdyu1LEq3DwsXT/KH8MfOXoW5XX9NlfRB/jM+t
         FY2w+hojrRZvQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 09:51:40PM -0500, Bob Pearson wrote:

> The git master branch has vanished since a day or two ago. Should I
> be tracking for_next now or will master reappear?

for-next is the right thing

Jason

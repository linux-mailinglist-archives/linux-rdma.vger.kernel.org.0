Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303F849FCFA
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiA1PkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 10:40:09 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:43744
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231320AbiA1PkI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 10:40:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFZgZcl0jw5ZhZyVo805AQ/t2VLOh1US3II0RSabSA8oVaAcBnAp5maihPQvP5S0OGcShJVNbS4V3MOULKG2KazBtjOuxeiLjRDSyNsGkPNKCBIN6wF4IBGUoPEny/YE+d1vefByp96pWxDFkVUCOqCBb6QOhNv/YVS6XhqlEZpxG4MJxPSiQiGPnUHbEY1en62AEdaEV6tupc/UtWTGv18Vn3SVZ0t04npPWYHvkUdQVWwnX1xQS5opaEa1TgKNiY5Ux4eZcE9TQqjuazdwBdHqfRYSGKS5NKZFdq7Bb4bKSGb0x9CfeiE1I6tU5JH4Y31EXxTVi+yqLC3pdK5i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTRL6TxSJWtuY4IVIMtqTEUtIYuRMtCOJZTkcB680CM=;
 b=IDmGqy3k4rn1WKeG4GFM1No0NBrLeP4ZFEEnpcBBRNnaCaQhwvvsPzrm22SQm+tcDoS0w9U7Sh56EnXh8P13YCph5xD1zMBwKfLE43cqXDamjg9EhyViaSsX2aCXt6iQlxqMIZ9aJycajbuDUUk/p7+QFv7Egf+CEQ9qbIYamQEme1DzJMK0zrKjs3Q2q1L6WdLb80rwuRtQz8NwZ8eIyeLBrFYML/cMByw/4yaOs+Gc3DMoBK5RhAMWBbPu79UzjPq5eAuX07akqBV0a5W0c2WOjxEw1en0ohwI/ZLrqlEGpURkcHy51Av0AH/EIGRKkhcncFtC+qVFtDRFCFeXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTRL6TxSJWtuY4IVIMtqTEUtIYuRMtCOJZTkcB680CM=;
 b=UsDS/9AARL71d4Pg3vlH0+f8j6ohod+3ipMcgTqG4vf4OGkilT/4d58DZGMKvS8RxgwLNo4nOq+shBF/vNA5E1WRLpuWtX5/F7UdW4YXIZILwcSqiLv9ntQgNFJJKGxbtzQd4yEhREhRQxRm6XQU+lYrUCbg3vSG1A6jT1z2Ji2kGXXH50G55m1N2oI9WxSU8kEs2+fYemp4YD5aP6FAerwRU5inK7m/30QKkBIrALdUeanKcyDpTQ58TP0MpD92lTPk+15VjOssm8m85T3SKD0dNZW/oSXCpjbjtYS/UFDAGZbBwHW/jfW0uSS/DyjjFaqAHeGjMyJcixKwrMZo9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 15:40:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 15:40:07 +0000
Date:   Fri, 28 Jan 2022 11:40:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next 0/3] Various fixes in RDMA/core
Message-ID: <20220128154005.GA1857277@nvidia.com>
References: <cover.1642491047.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642491047.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e97aaca-0d86-4038-7f83-08d9e27475a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4848BA64964CA688A87C3AF6C2229@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8ghk0R3tPuk3N1Gqc4AEoZ1Eb9YouJ2n20GxXbJdZkDpOgBNY7seHg4P/MWaY/PH6leMMLfZb/0AUyuBd8MqTdgTPGlSVJazXiPNx00GLbRT1x9/IxMwsSKemR0171KVFMhq5LWeriQzT0Pn0LSyhpQp1BeiYpjgbXrVQQSkocH5f2fJ+WST3LgzjisAX5UHJv3uXJzFAUa57pZFRqfyFUlmd7buNbOtPxl7jFgccamwLSeXMj22iYy7OwExL7ZlXfhs3vFzwNVoONnZE+7LPyFQ9doLttpVZWLwgzpP18MUTnmTh84yKluonKpVsAtLswy8Fk0d62/2SU9y1m9rLG5XuZGHYJACj+zHSlAvsEciajFnKvrqSA0u2FjhCwsLtWHUZvI4hDo3DElkO+/A79mhOKI0nv2qGz+I5C8I+Y9YYvLB0V/hI/zeA4oE10JgzTcfqqWdN1oaTX39FDUwMIemwiFrb8s0rD9kpORXzbOHCQGvdzlEZLY2cMfdqWeYLXFX9lC26hk2ITUOmr9HxgexyoRrGPEoVYw8H//d5SThUofloFnKBeX0JviQkS49LqUNE5XrZ2bpv7lHTaY7SAaS7ueClZIFfd2rwX7R87OIa/CajMx9Y0FkdH/ppgRlYWpIu1FZNKx5Qz3Koao5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(33656002)(26005)(107886003)(186003)(38100700002)(86362001)(4326008)(66476007)(54906003)(6916009)(8676002)(1076003)(8936002)(2616005)(2906002)(6486002)(6506007)(5660300002)(66946007)(4744005)(6512007)(66556008)(36756003)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hf3r15DATP0T7m6KW5S0xxzrbBpasWow7/njySWCXG9Ia2SruxFgmXO7VHG0?=
 =?us-ascii?Q?IBgVYryIgzsFWdE10BL183dIyH6T6CC3yV3ZQasXhbmh9d6h80kmk6vUNfcR?=
 =?us-ascii?Q?7GNuo8g/8rHdmZYK0EGPjZM+frPLloJpLHN9pKkgBIo/gpGdAoPDCxt6PmqC?=
 =?us-ascii?Q?LtzHetRePN1hfVwUcN3qNOoww0iIOq7mOrh2PwBLvza7ln4o7QjzqbTRo3Tq?=
 =?us-ascii?Q?PDnhiJRXa6jV8UEFzigIIZDF1XNIxkeSfz2ex3wqtkYiPZMNEVBzT1E49PXT?=
 =?us-ascii?Q?2YwDfMRGuokKMuZ0S74qpP1E+Is0dhYZi6rG0o5Yjqsuru50f3vHcgmEzXsk?=
 =?us-ascii?Q?C89BeN8FP67HKZGaqmRGg/nvKk4xJVz3Hq8Zrd4URaVIm5VwCTO4lg4t0qiK?=
 =?us-ascii?Q?l/L7FHs0oH6qDTgG7ZAq+pyuR92dNUlrRB/YjmS89kS8Nv5pxai1RZKWaDJ5?=
 =?us-ascii?Q?82/DMLG3DlfyLz8dEHlzs67JPxPP3Zhx8z9vYXyeK03qAjum8mTZ3sASqOfq?=
 =?us-ascii?Q?5sa6B6Y1BmKsKVYTqLsLyNxywXI85EkQSjiLtaXEPFxmWE8daUyiXRilRrId?=
 =?us-ascii?Q?KF6cNn+sw2qT+n6kep/Ef1f4uWfsRhtfLMXv+3vxmgN9fkiZSU+S88wrwCCq?=
 =?us-ascii?Q?W5rEunt8zs4ztN/qpOW+r4mJ7IIifS/+aAE/OtqQCc5uTLKPbIcGW1XG4ZBG?=
 =?us-ascii?Q?xyJuNip42LfXBFKU8RdfQRHY2JWMZz+hX1wL3kFGZuwqKQ1U1lnWJokl81uG?=
 =?us-ascii?Q?htULOKT8iGuziiQ7vwBNFRLdQ8n9pKFLviAqULY/or4uYLI2Pq/lAAXiPncS?=
 =?us-ascii?Q?HLpSd8B1nORFDFN7OTM25LtlA5Sj7xdKUGjIrhTogy91q7w1/VSDMwEiJUUT?=
 =?us-ascii?Q?CZyA81mLlvziYsjL0jBpdXuk8fDJHKrCm5S/3aOFbu6wNSji1bumN3UypuLU?=
 =?us-ascii?Q?6YVeteUni1TTNzSBKGulnVTXo6Y/CZZwwhSxp3rNe3mdKvqwRqjq7MfkwBML?=
 =?us-ascii?Q?e/dgur86lI5P92kF+uuybpj7zTi4S2XelTJBVPziQ8ZlIAq0q47nxlv3LHxM?=
 =?us-ascii?Q?IIkUrX/SKAUILTu4izVlL8H9Yaam8db14Lo1TfAI2VAI5FIlPhgfZSnsSbp6?=
 =?us-ascii?Q?W7IwDx4lW+ahuwTXdMyv4wWffXWqzIQjZ1TB/oGNjbTZrhIRkXi7CL8VbnWS?=
 =?us-ascii?Q?ATsZ8rUBaG8PQNH46kxWRUwQJ421Nj9iVfzz/k8XeHe4HAMLMl6pmKr+9vQw?=
 =?us-ascii?Q?38Ut1wTBq5BihYmcKkq1N11GeE6hS4jj/wDZ6gQd5z4v5eKtrfvghZ+2DGhZ?=
 =?us-ascii?Q?J1zZe+4zj0cMLLHyYQrsFm415BD8gPUJQso1RDmnhu8TVGk+pZerohW4qlVc?=
 =?us-ascii?Q?I2UOEdlVbtePvKioUGrYpB9Hd2fmlHIqcTS2QjcmKKvIxa0VDt7AwSIPi407?=
 =?us-ascii?Q?Z0xCnbWpxegRI0HBnG1qEJCSe7JrbsmhuaWl4Sisn/6uIO3yMZw6nspg/LI8?=
 =?us-ascii?Q?26zx1jBU5CACCJm9yUWdBXW8TNt0ijNNVAGfJw/gQFk+7dtTL0cu7W+wZtPD?=
 =?us-ascii?Q?fO5uwAFhM87MqAUlce4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e97aaca-0d86-4038-7f83-08d9e27475a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:40:06.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BYW5uQ4LQ831+/1kS88oBE1hBmIW5USL5y9gMfqP34AYq6IiBQU8qmXvhxH7tnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 09:34:59AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is compilation of unrelated fixes, one is an outcome of syzkaller
> report and other two were found in our regression.
> 
> Thanks
> 
> Leon Romanovsky (1):
>   RDMA/ucma: Protect mc during concurrent multicast leaves
> 
> Maor Gottlieb (2):
>   RDMA/cma: Use correct address when leaving multicast group

Applied to for-rc

>   RDMA/core: Set MR type in ib_reg_user_mr

Applied to for-next

Thanks,
Jason

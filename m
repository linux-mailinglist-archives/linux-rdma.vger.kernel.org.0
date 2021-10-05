Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C35422F4F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJERiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 13:38:50 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:58721
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhJERit (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Oct 2021 13:38:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWVPQgJfhAaXRp5+OB4QeS+gXZkWLykO6/4A1EwCLDJ5r7h0bdf8LiRb3AQ0W2GflpoLmJx1/lyz1AMADNwqYs0qOM6/Cv0KYvPz6N6V/F1WqCF+t0BXmLC71oTw1xUrQXtpXoOtk/1cMGUi7F7XHtXqzPbQxgU0C65HN8oKvUAVvBoOrjSwzRYsV5f5KFdZAuxZbB1qPe0Y54u3Y9KcNF0Q+yg8NlVVPioc2sAMEeDE6ISeNXekCTURGfn3Y9csOscpXfg9jcOIuSNEwiHwJaTGEBCQpCbwTNoJ3/b1AUMhIpf2R2EmiHgJVx5UD2XeKn6+mQ/OSghe7uwMtp428g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p01qd0MA+Kr5ToYqnpTicpkxcfGxwenrFh87MZLpiFA=;
 b=E19FBtwq7LZIzmbUON/irYx3PeQhxAwYYcWHyom6gZuOu6eyftyoQwXaz2XG//4T7z+D6t6b5nWoSsiTXHK0mCPqx8lA1XrRDYjZdXg39a8rjTH/7sFZFNoFPP3hq2F4jElPjU3jH4b+QBnQFRx0hEflGe1RDI+ryYMOGZSoEjuah0sx9/uqqcwSYcasDWWWpIr/QRFtTpFZr8lZJjHbnLH/pVxC1kSbV5lMnM81dT5KEal3/G+agO0hVy+JbzpVAcJx6KhXkBy/0Dm/83PuW4og4PgvJzCJsfBpVvFtLOR1k+QFZsnTdZo7ekoeFukI6tq/cIEWceI9U8anZKV3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p01qd0MA+Kr5ToYqnpTicpkxcfGxwenrFh87MZLpiFA=;
 b=VXV0yBFk7xMnMzaoLs5ohrBEVy6dFJHI+pSBscqWvfdZFgXNbTlMaaqTngH23FWQzjpZgeMwbgTVZ+rtHKMJRi2eFduZs8WMmGY02/dBmh4SKPt9VTep6AYFbJI20W9gk0bAepdOpVf1Vw5Zol7+nMDzvTnJRheVG7xIDfkeHZuPYd0pUVjA/3w/ROBX+jSc1HAWXZqaIUdXooCa/oEfv0udsa+gwVFeMp5tbTp8OuoOajzw/jsliKPQcpvR63p5nHteMINu9/0OrDS+Hw6SdDBWAmxFtbyYE+y1DxH1KqbrBd7K/TBnBZ9rW+Jhe73f4WiDk/Kgm/oQXOBh3mvMLg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 17:36:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 17:36:57 +0000
Date:   Tue, 5 Oct 2021 14:36:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 0/6] Replace AV by AH in UD sends
Message-ID: <20211005173656.GA2664024@nvidia.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 17:36:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXoN6-00BB3E-Jp; Tue, 05 Oct 2021 14:36:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d1af03-674c-447d-03c2-08d98826badb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52873A7EFF44ED3F27E322EFC2AF9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSjFYDgYGn+P5XjF2wiL3i7KjPkBgl4ewJ/YHNGXXp0O6ffidso6X0d7n2nDqZHMCsLxe0IDIPm0m2Pc1/a5yocOpmFfful4L87NKr8/olUkcAkGY/nHZHrX4sEAjdNKIwI57iboGTcQWZD9Q6f0xwtW614Qr3LGNJQx8tL6zZ+iEEHFrm0G1HgzHIgWthqhnRJMqNRILKple5ADHl5EUFPGpWYODXUnA3EwFVG3G4ohuVZxF6k9UL2oERWXekTzmrF8nQ2cwTQJ2erBgTLIg5aQfIWVbztUrMnUfW3S4bxFAOaqP9dbovn8/vdurxVh7tcfY/uAn6rHgx8ZEdtZHK9rQlYFbGyWcm6KvmEwFf9lfldYa/gALPJi1MHukNwgNHC9F/o+wIkrBUesbs0gP1jvcMzfhCU1qb6L00MjrQt9ly2YJjg2Wdu7dGGkqDyADthcAuvT7+OUz3qu7Zc+QGbfpiLbACMOaadjurJjvAR0WCgkIt+WtpwZicRqdkOsY9OON69ZYgl9gCqbzWKxifRHYArpSyouVnzhrwXSNYDQXm1Zr1VGRE0k4lrjkoKZQp33dFxlr/Qhs8NjnKBlO81tEX8UsXakjISIfQvpSZk/b+lHAkD7P5667Wy3YRkcgtmLrt24GFNw4lXnND83n6Hf2P13C+TD923PJ/mupR+p2ioohujlLLNfpEYclACCVWKmt/9f7N6gWrWBgtcXyz24RgQmQh1Agwzk4s1fF3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(5660300002)(426003)(33656002)(6916009)(316002)(8676002)(26005)(9746002)(66946007)(66476007)(9786002)(966005)(38100700002)(83380400001)(66556008)(508600001)(36756003)(86362001)(2616005)(4326008)(1076003)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ca8INGp0iGBt7wV0eg7wChMjK9VgBN8Y5zdGhYSh0ILRTuIkgGEXgxYiAkMu?=
 =?us-ascii?Q?yGQ3FrvokhbVYm2eF9PwtOO5ljuxvLqUmRM7OEe+UoncBOS9gFspwn2Lbn3n?=
 =?us-ascii?Q?wiKwSwPUwnPKVyWzK5Anc2yI2JNFd8MSoivdZzVRcJpKfxnp/h7w2yBncmIz?=
 =?us-ascii?Q?tRA5hXmswlzfDXRU8/XYw5x9yukigN/dUDVf2W5Q/P7biEnwcqq3x7Q0BfkJ?=
 =?us-ascii?Q?juAXkw3Ot8x4gHH6cFEhxO7J+f0TYihnDk7FXNxKd26MKk0OfVVjx40yQwrt?=
 =?us-ascii?Q?4lXk9BmNGwxzWpJ1hpuJQEBbpjMZZO050lfGaVoTozpzJs3V4TvaVSA4xP6M?=
 =?us-ascii?Q?vDtlIDobZuAp2usRbCutFBz1NRQTlH2zWCeIIaZwLz/aqNJQp+Q6TZMboOSQ?=
 =?us-ascii?Q?IwDorLgoFANDYuKxQHc4j0AC/Qe/IfxeiWqm+7v85zRrNKs1KpJdY0QztZeY?=
 =?us-ascii?Q?mk0btGY6Cc8HipVA/9uxJy0E0+WBRD8mTB09aj608hO+ZhCdE5ZUSXsuROYN?=
 =?us-ascii?Q?NYQJWG7s5KbhZqz7BysRUoyGXY+TbbP0IPnKW89SfNj0H1bUsyzbpGw6OU3C?=
 =?us-ascii?Q?C07a/4a+qL1RvIGkFTu5KoSpJowBjWYgQLgDFFGE7Lv+elmE7ZoFWagSivLc?=
 =?us-ascii?Q?tCPcUun26OYRu3xnjxMNTR3qB4GxZp8O6CS/JgceYw7vbAdyv9LxpLf2EWjC?=
 =?us-ascii?Q?JQ60CmfeNXAkmN/P0netVXxOGgFSvfj2BMyyUI92TSANI83qsi0FJ+HcaVPL?=
 =?us-ascii?Q?8sIVlTcKkCeGsUOnsLxChYzZsEPw+mZA29SfSnr3mRIifKDtoHcC5s8RhaM6?=
 =?us-ascii?Q?RegXkRzGqLzke4+sZ9ilXgreFfZYlnVheB2h579V6iCuWzOB+pGvTXXV3MkF?=
 =?us-ascii?Q?ZztHkh1UoOyicj5h/a+RpiWrK2iFsHe6OIt2Zw/NjBrSZZYLlC7Tuz5U5U1K?=
 =?us-ascii?Q?R8D8s3WGv1l5PLH62Px74XObeNnzYUdvSj17cZukcDD7Pj8mP2aeMKxhrGn4?=
 =?us-ascii?Q?LYitGEKYuCWYo959grQxRSAMYgABmpaXwuInHuVvnKU7CSjIKoth+s61Zc2g?=
 =?us-ascii?Q?AEXnKetzJwlKowmnrpEE7NIF7oCLK4iRJUCowImM1dMg50SX9az5BKh3/eFY?=
 =?us-ascii?Q?GVebgMSFB1dmXPEl59ne3cVGyzlXMdkGpk4gQveOAqVFexH0OdqwpU7Yrfon?=
 =?us-ascii?Q?c9f+MzbvAOlOuxGPe1Zd3hIfSwI9XqelmVu7fMrlW1+9r6PSssHY0DXsu3y1?=
 =?us-ascii?Q?VTZ3UsjfyADKVr+vW9Ae75uH4Vu1MAV3qwvUXYH74NritIAe8a0OzOm+DVGK?=
 =?us-ascii?Q?IffSLLPaxun0Me5/Bd1SBDPe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1af03-674c-447d-03c2-08d98826badb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:36:57.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUsBOl+qFtQd+ajvHpQJsByAIQuuueh0M+8+QUABXabuqxVLGyF1wrhgc6u8Si/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 11:25:58PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver and its user space provider exchange
> addressing information for UD sends by having the provider compute an
> address vector (AV) and send it with each WQE. This is not the way
> that the RDMA verbs API was intended to operate.
> 
> This series of patches modifies the way UD send WQEs work by exchanging
> an index identifying the AH replacing the 88 byte AV by a 4 byte AH
> index. In order to not break compatibility with the existing API the
> rdma_rxe driver will recognise when an older version of the provider
> is not sending an index (i.e. it is 0) and will use the AV instead.
> 
> This series of patches is almost identical to an earlier version
> but rebased to 5.15.0-rc1+. It applies cleanly to
> 
>     450f4f6aa1a369cc3ffadc1c7e27dfab3e90199f (for-next)

It looks OK, but please rebase/resend it across Rao's patch to here:

commit 0994a1bcd5f7c0bf7ca3b4938d4f0f6928ac7886
Author: Rao Shoaib <Rao.Shoaib@oracle.com>
Date:   Tue Sep 14 18:12:20 2021 -0700

    RDMA/rxe: Bump up default maximum values used via uverbs
    
    In our internal testing we have found that default maximum values are too
    small.  Ideally there should be no limits, but since maximum values are
    reported via ibv_query_device, we have to return some value. So, the
    default maximums have been changed to large values.
    
    Link: https://lore.kernel.org/r/20210915011220.307585-1-Rao.Shoaib@oracle.com
    Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

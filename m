Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E64167C7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 23:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhIWV7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 17:59:21 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:57312
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243393AbhIWV7V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 17:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLcZSUcJHL5ZhCC99TAZDFTm+rfkMzNPGZEko7Z6oZ5KRmShiQBh3GXGAe0zxcf39uYRP+lw6gmYvqUtt9mxGD7WwjTIz3xfBp6mKn6ArBzpbklIp5DBmpcXWuv/pFuS+SqdSrz04K3CtMkOjKKdKK6QfobBpcTa66fUdMfjggjZQi+rnIzdghGLI3bIFsaw55da6/sTa3t3FQlzrtY+AtU3qHsS8SwnSBbjExjNJfTkNfzL5rVekbZcuU6oNz+dP47+e0Jcqt1qawDhZfobCb+0YulqV1pCzOjlnYyfmgfYddG9k9s79eHZWX+fV5OX1GTWusi6uOm3i8XWAtxGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aa/Vo6ttzvKAQCxEewILg+ZVQEs+ybR1aAhRd51bfIU=;
 b=I3dm/Js6+Rfil+4Tc3MFjKTVieSQiRrSd0e+5IjGQ6gyVNphfNB+HyBqS7G+Ol33a3aNo09NhPkSDXLbTxsp9x+pcAWnR37AL3PuzghIn+bf7THtalaqeW10/lc7i8ZT1AnRe9jNe0IA78VwgWaKwycKl6DX+XgXbOl5IFfn28ABODJ4kB2mGPYbNqNS4eGU3GspIbjLX8LEROl5GMOLx084pY/mSHjLJ2jSqbtfNRVEjqe0XSP6aFFIybryLAoVnQuJmc+//eyLMk10m3KFDiriCOCw+h/J8ojimYhKXz/iTFEQm38P/FQ5KAcbZvPECfliGGztXFGvOxtw5dHKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa/Vo6ttzvKAQCxEewILg+ZVQEs+ybR1aAhRd51bfIU=;
 b=gOBIlFs2HG4Xo2rhkW4Ya1M09ikinnYLRca4X+VvnEkmTjI4fa7v2JBHB1enmJgHSZjCGMt3B2oXOah2kl6KV3S/p8Vnpa/Iv2T3q664WIIynQONoySdxhM3sF8ysgMY9s9ICTbBTDYrG+2cCemKdH7mpg5Zp7JFgDZ8JSYHVhBBKUchj7GLu3HKcRWog9SDqHY5Y6XA+fzJpxa/4YCxLeQXhn+NoNwTUMVd1ZOlE0Bwo3QbN0CCPhWzrTqvL9DcSehXZIgTs6y0RGqBG7rKe7PEYk6yxJv35eH1uqdMnfv3A+CYvwRjW5gs1RTL7GhGZtJd+TgbLBot0Ts+zosPbA==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 21:57:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 21:57:48 +0000
Date:   Thu, 23 Sep 2021 18:57:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        linux-rdma@vger.kernel.org
Subject: rdma-core and travis CI
Message-ID: <20210923215746.GS964074@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 21:57:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTWiw-004Yso-Ai; Thu, 23 Sep 2021 18:57:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c3f8ea-22f1-404e-2f9a-08d97edd2e3c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB535237988FF34F789598F9E2C2A39@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lTl4vNv2snW11QPqXiJID3DYCeITze1XEAYqNS/i6+YuXbHgxlL0QgH555CkQIgHvjid+MVwI3/0EamInV2hT/5OxzBn6ErSl9QyP/sVYwGfvHsPs3QGjtL0Cz8AEVEY6NF2UwZ0cXZ0FwNoQUrp2cA4hYJTN0ZJoKmjAZMytlm5bdJ9o0DFUkl65tdC7szXwpjc4WRnEovfQpCL1Phx8S1S41zha6plD9oUhtoJMsKXuH/qX8mJXbrxltVPpflvkKQ4tffd6iCqfO0ATXP08KB0NocOMhPl10C5geG6cD9JJ96/+3RWt5I80mIu98rjBWzuoPPedDa04ZZJKKWoaGa2wlOchRPPfsNpCInzE6KSZiEGK9eUcJFvB8El+5ujyfpxWIC5HcHCGGoVV72+rqnMUsg0h55FGWHm4zkO+JWTMzg/7DxQJhcotMz3I4Dnky8gnegeTkcl52X/g8kjjVvxeYuYZIVW0QRcrcCnjpXOfzzHMgZklpPympUArqRhPIaz6B0tf1PLq0yaR45uskSMXR7oVTGEPQ6X/0Ntc3zvN/77NkSUzbjNRDe3J0RAGROAKmBa1eoJfTxksHqDaTJ3302Kqr6tvsAJr28GSGo5v5jIMxo5ketPV7YQe8P2h2I5Oso1MLDcsx6p8WucD4JalhMKP5WLKnWz2mXFXizNZ1vxehQs2ClBQCdmQDS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(9786002)(36756003)(9746002)(186003)(1076003)(426003)(5660300002)(38100700002)(26005)(8936002)(316002)(8676002)(66946007)(3480700007)(110136005)(2616005)(4744005)(2906002)(83380400001)(33656002)(66556008)(86362001)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDT1RZCGN+iku4yf5R2nYrloiC1kATaD9cSU5H0wbyeOc+15MqhZU3R0criB?=
 =?us-ascii?Q?b2jEoN+QjqRDELlvLhc774TauV6g7vdFhNteuSS4I/VpVWd+HDh2ugGYaH+S?=
 =?us-ascii?Q?wbt/5UhM5/F8ouE1n6ZIeib7kF+K/DqOFYoa2AQT3EqTTM3LudcN/oN2BCqL?=
 =?us-ascii?Q?GC/IuqzwIvLJ7yOoRwuesLLCljBBRz6y4mTw4yz4meaA9PrXEYxGjT1Jeukd?=
 =?us-ascii?Q?kazN1evWUgEe2ytA0zGibxSFvIXNkly+UEWfKbAN2ntAFgjdrtHSJo6cqEKI?=
 =?us-ascii?Q?MNAsdHfjzVQtKUl4mghUAgFw3HRIgOops0EaCUg5g3NR7sPgzAQc3uAepdlQ?=
 =?us-ascii?Q?15RkOcAGAcpGYi4Eop/vku8LigjetRje6P5HOOZIvO4VIu5sI7kk11kVOISn?=
 =?us-ascii?Q?EKzVPizWcZ3sxf47hrudc8xLchF7kf9TmvLZ+jIr6YdY8MbZVxQQYaJxORVH?=
 =?us-ascii?Q?THWWhoHB5KA6bYN1zOlz6shSmKsrQexXaAUawtdcplzDeAB1eJFV+jnk3eNW?=
 =?us-ascii?Q?/wyB5XweI7VhARJusi+ALnPXjF/Fu9u4XVv38vNpbj+nL2F2ai93K90ykVCe?=
 =?us-ascii?Q?RaAUFMJZlbGXTv0CyA4YD064eRm3SySxz8VjY25H+TJty9VMSCYGlVoqQP1x?=
 =?us-ascii?Q?G+1ETdxQT2Uh5YjfjbLH6vtmjAtD/y0RXBXwTcpykScLJDEr2ng/j54qm9M8?=
 =?us-ascii?Q?jNxUy1JKdvQOeLmqnmdaHb90lwRvNT+TbsY/RkhgAL1n1YDPV9cfF6cdR4LC?=
 =?us-ascii?Q?N55XJAGeLR85hANrhVY3yMnywu66qdk2EWPvz/8hP+BF8TirkWPrJgxTEuyN?=
 =?us-ascii?Q?ovtmTA8RdvRvPHcNS/P6ljEkusaj9nxB61T7968P5JBG6b7FKu/3f3+sk/ka?=
 =?us-ascii?Q?PN346X2gzw1fqeJnMfw9fuXFkPkXf2lRQ4WS/ZmsbjOPYT5Gt23NQi+TPYpy?=
 =?us-ascii?Q?wJelAeZJK6KMNes2e/84HFU/XVB9ijp/L6R2oCQK1CWFnFIMZQmdAt5+A8wk?=
 =?us-ascii?Q?ExzpmYWpxhzoC7421o8P4EvnMD3oiffQR9vzi211qMIf5BWuyTvRf/B3pHAj?=
 =?us-ascii?Q?CNAt4tXfkluVsbIv7GTk2x6YYjm1p43fRBUR02xjsiliSAE0U59R0RK5P7/+?=
 =?us-ascii?Q?D/S3GkniUPAtfGvXp824dPeJGJBhe4dq6Zil67C0yxY2JvvSeYdFztIf42Qm?=
 =?us-ascii?Q?TmiTs6e7se2b5XQOAu+ydBKj+hB2LdkclCrN6Iz3ntLi/V1DfGGacH5LO6cl?=
 =?us-ascii?Q?FOgLTO0G4yb12BEOzodrSwY/gI6UWrokLeirN9GfRC58+BoBhYka7if+0KMe?=
 =?us-ascii?Q?ZrJJqEEL3mhDqItJH8DW0+Vu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3f8ea-22f1-404e-2f9a-08d97edd2e3c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 21:57:47.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WFNuED0rCtI2hhjBtaESJe3RB83Iij09Sffl0EdQl4guAPk0WjN7OU7SR7zYzY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Due to the security issue with travis, and the general fact I no
longer have any idea what we had/have configured there, I would like
to permanently switch travis off and revoke all its tokens for
github/etc

The only thing still using it is the CI for stable branches
v17,v16,v15 this all all 2018 vintange stuff and I think it is
probably OK to let them go at this point.

Everthing else is using Azure Pipelines already.

OK?

Thanks,
Jason

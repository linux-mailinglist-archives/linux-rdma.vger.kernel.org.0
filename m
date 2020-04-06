Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9019FC92
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDFSKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 14:10:41 -0400
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:26431
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgDFSKk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 14:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIjy1sS/rSYIw6NoJEfKhMO5wSfV4kBZoQ4B+JdElRwmcPHk+Pxlf2YpG5BKXT6hH6V6dY+7EUgXrTlfVAlDWpj6sHDRXLywTD4/514e9hXdWTD3cthuaIOZSshaC3y7cSFgGQb22C5Qdyo5MlHruLBLVQLULmfUru0H0zONF/AnNvdNVe3tMDAmHAEHw9tMReuUvkzftJnlaH7ZiDRe/Xj6hvKeZrpIoIFR0GG8dgX83bdWPcjKRBLxBAZfyAhJ2ElDDkSqjeJqNt1AewbwzOV6zLr7JlMXVUUIhfc8TKxktlvpgq+MC21JoloWsoslfwRKTi3Cn0wt+u1/pb5hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4cnvJrxUuCJapg7mtSb8epke1vkHDahfT9Qj/JzB/w=;
 b=SPk24DSQVVTzSsksDqGb7I6RVIVGbRiUX6gL8AZPWoQIbGsRRvbz2qIX9peqlpr5+snIzfWD7oVq6yD3dReAp7hLT61aZe3ojvB7kQYWYD7j0UIIX4KoEqWeOsZReg0gNfODd00kgbhuUjNzmtII6GY3IA760GJxvlVEFa8qFslm8EB/gWSupEXEUDE8RVimknzX+arg5knmfTD284qH7tmaCstJgj+DpCM4hHvfawYlKOT3PWmwyI7xuN3o/nwzLGR61xhpSxwzoi5r5B2uQtFLHw+5e5YwJ7SjTkbdjgH0uQHmHHrc9SMZHAndxOBt+6rL1MjrIpc+uXXOfj0Ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4cnvJrxUuCJapg7mtSb8epke1vkHDahfT9Qj/JzB/w=;
 b=IAccwdnnp6Zsm7IRqCOevKtzrqK+eyi5576o+FdfBYUchqLqMKvd0zzgVAnF5x78cvDeWZfhoe+0F/VSwSpjqUcX/GJofOGQ/N3I45ycIhvQ2ONn+JQkdIMiTLC7Nzg4zHtCmctwAS4cdgW9NUhDM+cXCT0tYGuvBjlE1N8DA5Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6991.eurprd05.prod.outlook.com (2603:10a6:800:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Mon, 6 Apr
 2020 18:10:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 18:10:36 +0000
Date:   Mon, 6 Apr 2020 15:10:32 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200406181032.GI11616@mellanox.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Mon, 6 Apr 2020 18:10:36 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jLWCe-0000bZ-5n; Mon, 06 Apr 2020 15:10:32 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a0ba7a5-16ee-4501-c503-08d7da55ce33
X-MS-TrafficTypeDiagnostic: VI1PR05MB6991:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6991664D1B60292BCDE3F6AACFC20@VI1PR05MB6991.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(2906002)(186003)(6916009)(26005)(4326008)(2616005)(54906003)(52116002)(5660300002)(316002)(36756003)(4744005)(9786002)(9746002)(478600001)(66476007)(33656002)(1076003)(86362001)(8936002)(66556008)(66946007)(8676002)(81166006)(81156014)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcgrkQQe6k026R4gAxiH+/wUjcAl2EjVtxUchXlkfx7uyaKNXK8sKzL6gbPt4nYlwpD+Gv8ICPaMMKtk3o2+7wGx+P0tBs+CWBPueFbZ0WAhU/VlT/eXcVqcwEo6rEcTa5kmg0FUttOT4zo50+58Oj+SthCfiGQJ39iSrMZx0wPiylcH4KUqQkln41K9yhOjNWap7ZyFHI/a1MOj1pOrwYlv6UIFLydGYu880PIKbUp5vHXdvALlyqyNrpmPcE3TBgu3Q/x9KPSke5FUFIXhzrEa7wWKrKf+lI0+CENwdr+4hUQLlFJzJWsswMsa3CtsgkRJk4Fg8FN7rrrYk3FhRe821OK1KtDaUd2d/RU0w514jQ4okwxF3I5WFRWtsrLTqx3DN3H/TcluxdTbPSlnuQIM6afqxVcaMa2Kmte48dI/lJswwxvm0JdVfPkUpN0Lm4aqq+8GGMjmWU0Ui2+99FVWu34Yg2PF/rXK1zM3WhveUlVCSPwH9DH9V4NrpM2t
X-MS-Exchange-AntiSpam-MessageData: iWXOWHnivS1tNd6AL888dUZ1UpJekS8kQ2NPHA98ouDQm7gNXWQIGcQl0hSSB2QIOpXwqxwE7UjcLsfko1oK9oWjxeWqKHRiYb6yJcDm8yarW/tdj2Qmm70oh87ReE5HRQdFXXvGBiZm4KtdB9YcTA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ba7a5-16ee-4501-c503-08d7da55ce33
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 18:10:36.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs8pVEKXWDe1dEZE0ZtmAlK7yyU0pR3w5p+a+iK/TrCsotnOIEens7CQxodYX9bh36qNwb+SJNcdc+wpU2AiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6991
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:02:41PM +0200, Håkon Bugge wrote:

> > However, I'm not sure what the state machine is supposed to look
> > like..
> 
> The neat state machines in Figure 13{5,6} in IBTA version 1.3. If you do not have it handy, I can send you the PDF off list.

That is the IB CM state machine

The RDMA CM I thought had extra things like this defered addr_resolve
business
 
> >> Shall I make a v2 base on next based on this idea, or do you have
> >> something coming?
> > 
> > Sure, I have nothing :)
> > 
> > Also that rdma_destroy_id in addr_handler looks wrong.. ie we still
> > retain pointers to the rdma_cm_id it destroys inside the struct
> > ucma_context, don't we?
> 
> On entry from user-space, we use the u32 id and looks it up in the
> XArray. But if rdma_destoy_id() is called asynchronously called
> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
> are toast.

Is that what happens on the addr_handler path?

Jason

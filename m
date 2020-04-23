Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D993D1B5B34
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDWMRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 08:17:52 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:46862
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbgDWMRw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 08:17:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZyzi8DbZ/lmaXK6ktO1nN31p9AIqehJgUcTlnkqXuYzyNh6GrrA+qA/bqrpeyIwl7zfsXsYdbBZoMneAWlYxiLJMlZMr/YDeKXMQp2gW48TaM71aRJ4l3gnOSrEuBCXaZoooa01M1RhCKrtjr1Vh17ovdtFfuLVNAAaMg8kyC1O0KPlTAxfCpHMsSyxZGk1fr7VzRRmwnIfIGDDBNxOszEErJ96U1/+oIRcZpF2okeIfzO1AoqeqtJASSZfLXWF9n+ATyeybG7oPTPgCapKZZzj8JkR5hGUK7s7K/86yRo25D9UKOSXakeL2lJL/pSlA1o8B49lDEL2xF8CAT4GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn9F7R44nUz7GwWrSJ44IU/Wi0zqqn0xJLxFv3gGq58=;
 b=KsKopDRx2w/e2Zywc7tn/nJj/zYDILciyTba9RYCG1ibyzfUoZ25ou02BZLBD8JV/4SLyOa4V7RDGIpYYBX+tV9t/A2Oy69/5+l/4E+gzr9DAy81YEpyDZM7DLBaH4BvW0t+lLe4cCSMB8KKxVslgdqxYIkulHg5ijQYzdCSwxoSOYZqB2UURbt6qEAIn0oqRP0cpX9iCKZVP2z3nzD7V10wvNFXPGqqm/Fe0OQPmyT52xfWs0WPQtyx1BYCPdu89VC6ec6kMzAOEHcufMQNfE1gSMSVtffqTjlzLDbABWFc5gZWYSrMFYwpZUkKMne+e272oA8ZN/cusvGVRTUZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn9F7R44nUz7GwWrSJ44IU/Wi0zqqn0xJLxFv3gGq58=;
 b=iV19hIxO+ni/ri6/2+HJwDF9t2E3G6hsbGFL4AIs7IflQ3rr0sVIOoZrwF5PYinOkiM67rJJG1f0ehKymIuSOSP8XHMs2nXCuj6qDkibhytZXwS2xvJhZqkTf6r31MI+E5jNqvzuyq9dBdvLsUL6KuARvypMN7354yv650jJJrY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5309.eurprd05.prod.outlook.com (2603:10a6:803:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 12:17:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 12:17:48 +0000
Date:   Thu, 23 Apr 2020 09:17:44 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau/hmm: fix nouveau_dmem_chunk allocations
Message-ID: <20200423121744.GY11945@mellanox.com>
References: <20200421231107.30958-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421231107.30958-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:236::9) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Thu, 23 Apr 2020 12:17:48 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jRanY-0000Yz-Mh; Thu, 23 Apr 2020 09:17:44 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eeadbf96-dc79-4c79-8fe0-08d7e780561d
X-MS-TrafficTypeDiagnostic: VI1PR05MB5309:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5309B847A35EA2EEC76F2366CFD30@VI1PR05MB5309.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(478600001)(2616005)(36756003)(26005)(6916009)(54906003)(316002)(9746002)(8936002)(52116002)(33656002)(9786002)(1076003)(4326008)(186003)(8676002)(2906002)(86362001)(66556008)(66946007)(81156014)(4744005)(66476007)(5660300002)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKcP5yubRMascTm+4jBG2c1VCBne/enCht7uTYQn5/Sv029hAR12RbpL93sx6qRxjdItreNysQW1MfkUsSatUfKSP+PWMgeNTXuc7YQ6oe5cLWHx5twxvEGAKARpeG2rHTPqeulMO6/N/jNShCpo9vgeYcvEyXZEFiUD6oB0ImqmeGvY7s3wT/gBtKMjTQ+ap6+YARkyyNT8cmEmosanmJfD6dv1BjJnni/iJXliAzmzV/2Bz8IpA/DuMJ5KlvnQNRyS2KuFdWbPPij+0hb/qjso6trEnQDLCwI+vAO1cfy0fMALVaCuazdgYXaNdn5xGcPIQanUTMu4qj/Bh0tn5kb/tiiNthpx6E1dCSAdNTJGFUBb9YnfUVXF/xmRbuVkAOPWsnbVhFbj/L6aDXLSlXN61UZ/vQ4PiEHDydsQPc31fehPn5GUAooEJx9+10r0fcazIhjEI/bKEfAjbagPmHUalgj8yAw2ujm+yQZKN/JvH7JA3gOt0qHUXGTdsG6h
X-MS-Exchange-AntiSpam-MessageData: lvOkdB4WXtBGXgfBQVAHdAWyjTKJed3l/FQfOnEGDwXrjbkx+KtG4e+gxLO91YuSM08pmM/EoZ+2anRmdof74fN0ygvsZ8bQyOp/3ZxngIUiqdLvKqAaa7vmGiX/h6qJdLcEgGcUvNjuxxwxmUR9SA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeadbf96-dc79-4c79-8fe0-08d7e780561d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 12:17:48.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKL/A2P4WVUBu71hpNLnkmFrKlUM36EzPzX/hP3/YA5tuTlTYnQtFRLIn6GL7cp/mavcWkWj3bycvUguVQGeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5309
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 21, 2020 at 04:11:07PM -0700, Ralph Campbell wrote:
> In nouveau_dmem_init(), a number of struct nouveau_dmem_chunk are allocated
> and put on the dmem->chunk_empty list. Then in nouveau_dmem_pages_alloc(),
> a nouveau_dmem_chunk is removed from the list and GPU memory is allocated.
> However, the nouveau_dmem_chunk is never removed from the chunk_empty
> list nor placed on the chunk_free or chunk_full lists. This results
> in only one chunk ever being actually used (2MB) and quickly leads to
> migration to device private memory failures.
> 
> Fix this by having just one list of free device private pages and if no
> pages are free, allocate a chunk of device private pages and GPU memory.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 304 +++++++++----------------
>  1 file changed, 112 insertions(+), 192 deletions(-)

Does this generate any conflicts with my series to rework
hmm_range_fault?

Jason

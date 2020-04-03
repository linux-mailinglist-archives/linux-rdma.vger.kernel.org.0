Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53DF19DE99
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2020 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgDCThE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Apr 2020 15:37:04 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:19425
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgDCThE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Apr 2020 15:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaokbCSBKns7f7dgPqaEN1X+TZe7fWx47HEKKsSjK2sQi/9yMj+GfNW3p7e7SJwkO6TTfAUittbXp9EYhz8Dz9QyR2st4qsPUHGWRo1tCyBmx2MORaRVEyRvi7CZdD/FgcTqmt+tGz1WCbt5lGlvI7/4FSaEfpqu9qRXqqzhNaeEtZWsUWm3YAHzc5AVQwpBbWEH2MVZtbqrRxvxOXdbp0av+P2MqZVy2e+Wg+IY1RJz1fw3d/BIy5Ld6nJhBI7afhF0WaJNAQPZpry9+RpsrEaa+Q4e6oqM7O2v9UWTl7OslBKbtuVvCaqDJM+h0FjgGFGbawRPsuV4v7z6UBvzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1uRo9eXym7jMihQicA/TCob/pke5UClyKeqiMKl2jU=;
 b=di0qVGPy6UM8EHYOToaKpoAXf2BG1VhJh/Am72r6PoUIVufLGi570ZJYjUdEOdaKJ9QFjsA6V2V/2OSwMm3TET7qzR4SPJ83EPuLJlqxGhimtyTQlgqpbwgN5CN2hr1YdzidCBTQYYDN3drcbdeU6MzO9NQ3QxSu2ZCuEYVkgQrmkppZct4UGDM9np9tkV48dmLtisMwDQUq3fyWuB2ggRt9OmibYrbBLZjiupAD1hGfAjakNhEgous/+skj3QnZo2Fauj1JRRAKi9QaS2M7D1Y5NYHLM5XxC72KOLdhr/UyAHhi7V7u1PbuXJ1ahPoLOx/UuT5gK6Sog3VBw4ab/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1uRo9eXym7jMihQicA/TCob/pke5UClyKeqiMKl2jU=;
 b=r86hFTGq3NDXGSDf3oRRhAjKytQY1y2s2eNhYvqVqa2DSUlWvGQES2CvroL8ZFCzQGr/cMxLz0aKEVQ/Jwq9UvzbEgvGy3E83sWBIlqayevlMTZIhdfftM8UeiB/ELcywY77bnwavz5y7A7+bOCeC+IZJGDxxjAXzBpZrNJOKrU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6077.eurprd05.prod.outlook.com (2603:10a6:803:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 19:36:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 19:36:59 +0000
Date:   Fri, 3 Apr 2020 16:36:56 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200403193656.GF8514@mellanox.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Fri, 3 Apr 2020 19:36:59 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jKS7c-0001Xv-5P; Fri, 03 Apr 2020 16:36:56 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57c9c3df-7d21-4b13-b6bd-08d7d8066054
X-MS-TrafficTypeDiagnostic: VI1PR05MB6077:
X-Microsoft-Antispam-PRVS: <VI1PR05MB60776F9481CB7B653D04ED6ECFC70@VI1PR05MB6077.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(316002)(4326008)(6916009)(5660300002)(52116002)(9746002)(9786002)(478600001)(54906003)(66574012)(1076003)(2906002)(86362001)(36756003)(66556008)(66476007)(66946007)(26005)(186003)(81156014)(81166006)(8676002)(2616005)(33656002)(8936002)(53546011)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs6gzxeSMv9FJWcc+s8YgUid2TQ91hV2i4gGkZZnGyRM2QE5DiC3uZgYhIYKEADscjmgb5wem7/S0tTixeI0Kv6/ge0DbUD7S1a/cd2QP/yS1+tnBRuXIquje/3og7AdPVKFk2XHuR2VRkCvhgE0OAnItxTMxhDhx8oyRNMOf0UsaekYAdk4ScRpti+/9g55DAPJicuRQLIF72rxELn+qwxxFx8qry1f1lgvboHVjV2EmRgtP7Fjr4AvTf0R4LaoHipabCgrpEnQ+JgvGHUSlLrbfGC+V5VDxhU/pC/uWq4+StGBk8p1ydjvi5/sosptUc6rchL1O2emQUBORdTExnc3xsEcNBx/yawimzqGtqylyqFf0DDvizjmyelfGehmzXpjhbR5jk8CpFuWFTyU1gi2AwtEVg6sUgzcndvNg/JKHKU8KUJFXh7EWzHIpJOs/P3APVD5oz99VK80hpKV/DLzAlguyA2UCqU3e6vF5UfyMC+MWju3M0kPpap7A9+V
X-MS-Exchange-AntiSpam-MessageData: q55ZleaoPu6uR40qe1Jsedh6w2+WD+OkvuHWdPlaFwasOe1SN77VlUbKxoK7EhMkSy8LyaEy9rFZ6463yutpB9LUjASEiNdE4C5yfiJ7/cRvesefmecchqbFhVBn7zm6YoMR4qBZTLDP2NRHlaFfdw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c9c3df-7d21-4b13-b6bd-08d7d8066054
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 19:36:59.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH0NyIlFaXjXPcT0uAUN/NwMHtU/mdDIKi2YeVKuoF1ZQLMhTnGDpu6Olx2F9l2IGsKHjrwG0REJRLx+Fx65dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6077
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 03, 2020 at 09:07:10PM +0200, Håkon Bugge wrote:
> 
> 
> > On 3 Apr 2020, at 20:57, Jason Gunthorpe <jgg@mellanox.com> wrote:
> > 
> > On Fri, Apr 03, 2020 at 08:43:28PM +0200, Håkon Bugge wrote:
> >> A syzkaller test hits a NULL pointer dereference in
> >> rdma_resolve_route():
> > 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> > 
> > This commit in 5.7 probably fixes this:
> 
> I think it will not. The mutex in 7c11910783a1 ("RDMA/ucma: Put a
> lock around every call to the rdma_cm layer") will not prevent
> addr_handler() to run concurrently with rdma_resolve_route(), right?

Hmm. Perhaps so. But your patch isn't nearly enough if that is the
case, you've only considered resolve_route, but it could run
concurrently with *anything*, with the usual problems.

Plus addr_handler calls rdma_destroy_id().. Oh wow is that ever
completely screwed up. Sigh.

Probably the simplest answer is to have ucma fail operations that are
not permitted while an async_handler is pending. I'm guessing the only
operation that would be valid is rdma_destroy_id?

> And, I also suspect 7c11910783a1 to have major performance
> impact. But, that's a different story.

*shrug* I no longer care. The work to fix this in a performant way is
enormous and nobody wants to do it. 

Until that time we are taking a 'Big Lock' approach to all concurrancy
problems with rdma_cm as this code is *completely* broken for
concurrency.

Which is why I'm not taking this patch..

Jason

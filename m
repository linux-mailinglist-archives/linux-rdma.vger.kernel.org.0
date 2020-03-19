Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEF18B2CB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 12:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSL5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 07:57:02 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:25326
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSL5C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 07:57:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpKYKMQ9+Chf0DS3HF9LPChRsE91MEwq/aj2s3ry9MUPqG2dC3gHdYHjjMZY8T5vRbYMg1Mfe8kgRFUrIkD1/Cg2dcJAsTyooe/PGKhpTOIIgEtVbP1n9nfq65kqLpOjMHPs3s5nUUtapFI47MeH9L/XNMfZ3UEH8DxniV1YCq5thAna4rTz2q8Chl51Zasfn6Kr/jUFxl3rpJQ/qGurnEAH54WGu0uUrOusMRlijNRruxKqL4Y7sepF4Udhg7E3h58HyeiSkX+vlNmq5jZoZDlIqtzhwt3/WJvZRssvQ0KvHAU20yxS9omCD0vtD4gc/5CJ2yyPQI+tqoQ+4wBINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQYtatzcg30/WKB/z+jMu+PMq1IGVprp4BOfzD1f2CA=;
 b=MU0oF20bbvMRO3gE9oVei2Oq+nlssk2xpXtGQ7aZGsSnJVUV0gATxCbhfLqHb8n9zAGApMVvd4QQWLhecxxDlxukdkJ9shUlUnlgP9f/UjKFXUtSAfbaF9BUog72kxzR4pgSdxkVdsm+FB5L/TRhB3ZOfPjETWxgetOjtOn+XRBabHdBn93r1QIp78LJJ0WrE+lTElcNpbbFRpO6RBbgfnV6MIP4wWCrUORVr3kxjqj0EeFbfHV+2Voym/+2ypOosZ3pdQJWrZ16l6MVYc2lZHSOmfPadp/n95DVwygQvIkITR4x1syHzyFHJnObutVvb/qrT/UL9cAtGZTvs3RORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQYtatzcg30/WKB/z+jMu+PMq1IGVprp4BOfzD1f2CA=;
 b=kWhk48xTTMhhuxk6MEUDbW8CGKL3IbaKwm+6BfeTtVW8SuWdg+m/H3jisHD3SIdt1cQELm/oYbGEF02IrNFuBWbMIaaKxlaVFXByph/1o4PIQOW9BrYzcdA7Hr+8zJLoBdsIweOvWTJus3bMbySx2TGSMbtOypT8Ah8AGShzXu0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6783.eurprd05.prod.outlook.com (10.186.161.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 11:56:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 11:56:58 +0000
Date:   Thu, 19 Mar 2020 08:56:54 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        rgirase@redhat.com
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
Message-ID: <20200319115654.GV13183@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR0102CA0035.prod.exchangelabs.com
 (2603:10b6:207:18::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Thu, 19 Mar 2020 11:56:58 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEtnC-0004rN-Ik; Thu, 19 Mar 2020 08:56:54 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad5f945d-247f-4775-7eb2-08d7cbfca0be
X-MS-TrafficTypeDiagnostic: VI1PR05MB6783:|VI1PR05MB6783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6783AF447C3406213ED34D98CFF40@VI1PR05MB6783.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(9786002)(6636002)(186003)(6862004)(9746002)(316002)(2906002)(4326008)(2616005)(37006003)(81166006)(26005)(33656002)(66556008)(36756003)(8936002)(86362001)(8676002)(66476007)(66946007)(5660300002)(478600001)(53546011)(1076003)(81156014)(52116002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6783;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0YpIrrroHCqjIfY8XRN0AyfLMquqAkU8lQR7by7z9T0YzXd/71zyofQvtSiO8DGLWPW2VGYdYzqpn7xkj0PXcsE5v6cHDH6mfZJTGgPUPm+8HGwLCjvPjSv8H/RY8o8LjT15V7ubZzNuYeqe7LwJ/DXEndqoiUkJfGKLf5iHPPF7sHSEpBzc94G59vOrEWmiLTiX3IwGsFyneHRzlfhz+JzIufQGcjj40ClG6TymoOZYsORako2dOQf/7lO7wqdKzDFzAlQcpQ/WGrBs294/1CfeOUIKHlbQHvgJf20Y+KBMBKgELcTnBmwpMvL2LYQT4w9yxv0neYtd2VahkYrEE34ujYCaOnmnpH7w6DAQeKv5lj8BnIKDTd6Xh/crirYEESL17QLbsF2RzEwjS++tvVWB/U7nydw2l8w8XlkCaqNWnYkb3zZ0ZvkYqcMgSut3SwDxG7PKOl9WbZuZNAkcY+udABtcHfjemMmKVFnrEfOHGgt2vl1Y8v0simtVTC6
X-MS-Exchange-AntiSpam-MessageData: 0OUQHUyxVVI9EYhebEPeza00fKv7RJlZ/XCmDmF24911iYJFlgEJutI2IZGet/BCjDBPD9O+/4qezDXiuGP44/7m94LYNX/ZK+xx6pIAOT4ZxGcVg/KpRh+zcONL23iSsf9K8wg0jE/CSMlIBUAoqA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5f945d-247f-4775-7eb2-08d7cbfca0be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 11:56:58.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MVdRKkMYScAVdtDmfJKTzNG1jbSk3GztgV/NuBe+izY3AbTgOSbX7GoVn70/Q3el+oVMyfQIniZw8BHH4ke5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6783
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 11:15:50AM +0200, Max Gurtovoy wrote:
> 
> On 3/19/2020 6:09 AM, Bart Van Assche wrote:
> > On 2020-03-18 08:02, Max Gurtovoy wrote:
> > > In order to save resource allocation and utilize the completion
> >                     ^^^^^^^^^^^^^^^^^^^
> >                     resources?
> 
> thanks.
> 
> 
> > 
> > > +static int nvmet_rdma_srq_size = 1024;
> > > +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
> > > +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
> > Is an SRQ overflow fatal? Isn't the SRQ size something that should be
> > computed by the nvmet_rdma driver such that SRQ overflows do not happen?
> 
> I've added the following code to make sure that the size is not greater than
> device capability:
> 
> +ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
> +                            nvmet_rdma_srq_size);
> 
> In case the SRQ doesn't have enough credits it will send rnr to the
> initiator and the initiator will retry later on.

This is a pretty big change, in bad cases we could significantly
overflow the srq space available...

A big part of most verbs protocols to ensure that the RQ does not
overflow.

Are we sure it is OK? With all initiator/targets out there?

Jason

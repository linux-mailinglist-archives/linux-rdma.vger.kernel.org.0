Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAD3D7C53
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG0Ri7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:38:59 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:1173
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhG0Ri7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBQXEEK1iBanVhqEywehomLWMpVowjrZ2BliFdgYS7tYmf0oXzCofOAihhvVwScvdXvbtNgJ7pt0pJ4DP81C6bW9etAdjZuaZ0u8r1UqlaUQqGZibTEdvjmMuQPlkshnM2rWrwPwknzbXduvLUl5t7/mnQ1xYqS8otnVhC+CCOa71hPahOkx33+i2akhgiw6a3C6QPokuqAaSDHqLeiri03P1tM/2fq65xslrxRK0NU42W6wKckLRsnzdLC5AZwuPvOepw5U7tVIX97XyNENJimU5q3W0uKwBRc3AUWJLhQOj82y9PlSx8znQ25liit6Bgob2tpEJqAVj0WWsAUt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyyGkP7yd/ITc6A0kJ8MAcx4qJckJWNx9Vf7LJc7N8E=;
 b=WAeydCyW/zxhPsuan4wuGe/27nTeD8SwPvgxuPsAJSeP/cc7iC6P4qHozrYPwv5q+EDSdecEl653H2RKpTz+XHfE6Xky9R8n7ouMPaG0xV3EPSplPtMXHMwm3Pp3t2+lsBkZD09ksfh6wjSWNmVX7dOxYdI8bHHxI6XXraU3W5eg0qUKZM5XcQbex7IV7PDQFc5EZrjdo9e/envBi6iYCxuW5MRdS3diibg0tlGuc3cbwkk1STM9uF9zez8nD8BGBO/N98SawrjaZdgYGmhr1Pbe7Z/2t0yJkDWPhslaUULOtxj0Iq39DuNH7ceblUrJNzufuQblq5t9xSNv/KwOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyyGkP7yd/ITc6A0kJ8MAcx4qJckJWNx9Vf7LJc7N8E=;
 b=TVHGzSoleueNS6cIk7CThIDOOuIVylEln791nQQ/6o5EBmxw/qntliW8vX4pfuzbcBKqaBgt6jfyIOvGu/cFExyGXEyuqTau00ClcztJ/TXUv1ZK3blmedjjS7QgcCl7juIGbW4nATatDEjFxAJNDhTvfR/Ngiy1mbvUDUXcDt6dKp3CDogZi5fqGDdYJVxmbV7T8QAk9P23UHvBPop7sZuwHTaKNpqoVjoAtOD/LNlENXCh13X58uhqldi2hnc9fYjrrfroNLkCe0G0PC/YqDbx8pmlBQZ20bTYZtMwvgaETquuoYmjkT5hAxDYdl42hhx4XMJh9QaD3hJ6gE9qhA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 17:38:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:38:58 +0000
Date:   Tue, 27 Jul 2021 14:38:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Message-ID: <20210727173857.GI1721383@nvidia.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:c0::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.9 via Frontend Transport; Tue, 27 Jul 2021 17:38:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m8R2f-00964F-8y; Tue, 27 Jul 2021 14:38:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8964e660-a9ac-4c32-3812-08d9512569bc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50793BFD7EC1FAB3928890AEC2E99@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPTpwzPL1VVuMbX5A5hq9mAxMtDIf3uG8tEAatDiqlAypDum5zVrXN8qrFJqhzERnjYImjFUGpS1b0wsjTzEbg+IZRFumX3AGmOHY9O6Epi0D+GDlHhCl9FXvMnFVl0KVUc3/6LY5oEgGgRyQZNiJYqi69twEjcBVbMDuH7jHrQWpsFTiLW0rfIywW27/9hXEpdLv9GAEdSaipTAk7RKVts9zD74VGApDg/ayWNKVKUO9s8BpR+SR2hxm0FhOAzKU0rOxqrJr9srwT6i62dLEgOOXYxNNebrM8j47bx4EN3wIJKWV0mMY/uxpIPozbCoyVf6VRt01NYZhkIU2OwhU+igls6BKzmmqaAZkOy5IkDE/Rr/tq+lmW5SWpHJKGnh0cfDhqK+kGqMDndCPirPAiFvFL52UJphrogHW1V5cheqySeiqhl/PgpBJ7Ljb4at1SfsFU3ApnJpkYiITenbvG+6PtFP0RiqL23E231bX94893DJOzai+WGhFg9KTqUthL7OexHWtl+BOQ5vabB0g5vChl7SlJeVzDXy73A/nte6NcQiW7Aj4siCY93HVLaKHrj1ntpDJ2MotDijLuHeCvCezS/jZhD7rDcHkwlHkUfl65SQRogdkj2Afnw265WxahCc8JeKIL//CZ/5i0zgKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(9786002)(9746002)(8676002)(6916009)(36756003)(54906003)(5660300002)(2906002)(316002)(66946007)(86362001)(66556008)(508600001)(4326008)(53546011)(426003)(66476007)(2616005)(8936002)(26005)(186003)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkBZvfxk+tgpRYOzLkhW4p04l12gtpA2rFDLlaTP96eBJUAddMOpRk+ohrB+?=
 =?us-ascii?Q?MvLkhEgKfE7aDLPAkoqKTBfMdiRTQEQuO4Uppl75EIKbEMMJBP0K44KPH8Gj?=
 =?us-ascii?Q?tWHpy8+QHKG8ZNcbc75YO9NCZt75IvJz0NNxh8Hl9paZQdmjpjiRSEyzDFbN?=
 =?us-ascii?Q?lWFQgns04hEGEs+KSX6l7O1B763dxbxd629FqOhzWH/0Jj9xEKC4uc+amuRy?=
 =?us-ascii?Q?1iaJBmGV4DG76QG77YTxshpuR7KjORz/vwYMH07aQMf1gwZVwx58oyLxQV/5?=
 =?us-ascii?Q?jZ9fdXq6XO3I4ehB/0wLfX041VcngVTpKejHf5W8GNIWDxxvOOnNI+8d35XB?=
 =?us-ascii?Q?Jq0F0P8NK0KSR2csgAFvV8didPxuFqMBVHyIvO/GvyPDC3+xbc3nqxwOZIcF?=
 =?us-ascii?Q?slE6GWaZG/PRK5+b9nq8Gdlz+4cN8+de+AnRwEzTBpmFn4VqDBul5HKprvZB?=
 =?us-ascii?Q?CEKr0bDL4geIuXrGIn3SumAya0MsQL/filkag0F7hIf82z1fWhY6Sw3hqWMD?=
 =?us-ascii?Q?CsGyISvfE1TiThN8Cbrgj6fJZymp0c+Wzi+eB7riU8TaSXxOpr80CJRip5+o?=
 =?us-ascii?Q?0Ca7CtbYb8WANMnRzsC0S8AXQgyIFk9AhlScgYdsHodKVLsHUC32lg1kUDB1?=
 =?us-ascii?Q?YkSj2PUqgZW/PNUibe33YK+OjyLmm5CVpgrVPHBDRswhSv3CDuLzljwUGukR?=
 =?us-ascii?Q?EI/fchSq1in3AZQIslIfQIidfgBqOfB5+cI5dC7rM7DyiQrjZ2SVu24R2gyf?=
 =?us-ascii?Q?hwMnAFdKbEGPaFl7GSQEgA6RHKP8iTlANXaEBIKm9JgAVaDbPjbjRRP3OW8V?=
 =?us-ascii?Q?FdONOm8QpiSckTepmBmrITrGg1gfuwWHzgBsD9+bBZKpOXp74Eb5BE0x3r94?=
 =?us-ascii?Q?V5UT5jMatK3DX8bnftqXSmn84+D9yEV66OEljmOo0z+gFvAUWm/Na56988b7?=
 =?us-ascii?Q?TbKj0Cnfjg9YSG3GG2D3ThEbEQwtX9OFsbKO3R5uh+b8+s2QGiulsl7h/6Sh?=
 =?us-ascii?Q?Nb5nQu0TD9W7XPc0lrkNCXfEpRt5PNRDBHIX/j5vQ0tO+EsLcdyzcuFedGEq?=
 =?us-ascii?Q?CQS4fo/BC4bGXR6lvYZbginkrhmyfIjTyho37/HeRU6itiQ+kAbfaHF1m47r?=
 =?us-ascii?Q?nr7K+zyuNwWb6dczFAXgfTtwk/4GAzGXK2ioJht0B1btQeDlZsbYQ7tpJSaS?=
 =?us-ascii?Q?jqUUI1zdQb/G0eYr7n/VPyun2p7AdyRTQ9+97Wk7e1bRCfONKKgrI7fsfm3M?=
 =?us-ascii?Q?VkEY/rQd1EDl6r4dvA1rQym1uZXAjXfdwMXqIy/9x/CadGjFBQbrlRzOCs/v?=
 =?us-ascii?Q?uWScRshroos8FmNpx5hs7wfA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8964e660-a9ac-4c32-3812-08d9512569bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 17:38:58.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHW6JTQWCL4vIxhdBAampg8thBB0loXW5gQDxfbwsuZiCJ0DCBig1aPMd+TcrnIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 05:35:46PM +0000, Marciniszyn, Mike wrote:
> > > On Jul 27, 2021, at 1:14 PM, Marciniszyn, Mike
> > <mike.marciniszyn@cornelisnetworks.com> wrote:
> > >
> > >> I suspect the patch needs to be reverted or NFS RDMA needs to handle
> > >> the transition to INIT?
> > 
> > If I'm reading nvmet_rdma_create_queue_ib() correctly, it invokes
> > rdma_create_qp() then posts Receives. No
> > ib_modify_qp() there.
> > 
> > So some ULPs assume that rdma_create_qp() returns a new QP in the
> > IB_QPS_INIT state.
> > 
> > I can't say whether that is spec compliant or even internally documented.
> > 
> 
> This from the spec:
> 
> C10-20: A newly created QP/EE shall be placed in the Reset state.

rdma_create_qp() is a CM function, it is not covered by the spec.

The question is if there is any reasonable basis for ULPs to require
that the QP be in the INIT state after the CM creates it, or if the
ULPs should wait to post their recvs until later on in the process.

Haakon's original analysis said that this was an INIT->INIT
transition, so I'm a bit confused why we lost a RESET->INIT transition
in the end?

Jason

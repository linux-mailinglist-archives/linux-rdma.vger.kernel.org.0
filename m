Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C33DF223
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhHCQJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 12:09:42 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:36480
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232223AbhHCQJa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 12:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERMFlvFkAy2RAc11H69GB5u+W3Ezc7ymbBqEmFHjdnukJkIZzVnjEiy8mMTlScr1QrqIGtSZznoZ6yLveQFHzvASadgUO7qVTJ4xipsATiM1ZoNBr84FM7wXU5H4nHdp4MovZhMrGbs+yLmSLKq7fAl+zc1sZtsC0T8N0uDkog1KbooamqBp2h+hsauwE0vbIgHq8z84TDuX8EQUSNLPMGX0253TisyokD0vC6OfPCZgPxdeN7KCi10OQZZWPnnJ/eaN+CTESmQud38E4sP2baDwMy6c06f1MIPBfmLPOSUEdjGXB3P9qxXG7tc8L8d0oir9AK9J+kDtT0zqEKtXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobkxce+623m1dlZBWTJ8CUsxnzQZcopnTADfBx2Z4I=;
 b=GsSo6YOFRquo18xFDs+Sx/6YnLj/WDlNCr2dIj4Si7mKm/eRmFif3rWsPG56fI5t4b+9BgkBRgkioifOYY9IjAETYxL4ZGPjhmdizAXJll3NVbilvmsFvO369gBSXEtJZC1IIPQMvNJDtheNAGVnz8BYXdtoOOwV04JBtF6j4IFvLQEynpMhuw85DaMJKr9jrwlEASD9R4s3omOGmBBBF1ni1XfqKf2TAsInXy2Vy6qGan9lTzNQXReHI+3pnbu7eylls66p0TUGYFjUGpOca35pxZS5AJysPdL8xatqHTKawiQ8vYmLVt19YeFDyac65uMQj2oMyQ1g1IEjr1/SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobkxce+623m1dlZBWTJ8CUsxnzQZcopnTADfBx2Z4I=;
 b=HGo8pW0cJHEON2rv6sJoxQdnELMR/Rcm1SLJRxfB9O5My7Ctj7XsXMMFyS7gTEn7WC4vFLeIo3oEI5MTVAuKAOYGRgDAQCyaMqMdqWQy0FTbX/BA7i1pjTbSJClIeo8s9zZV6cp6CSThlkAbTJxdq/GLubiwaGfQG20mGRyA2+Uv/ErxipXxRAzB0sc8vwbcTDn3Ek7+Zl5KnW5En61oQ9tYKEDbKB29WNgrhMjlOvZ77X4XSJp5YLn+te/FWuFFnLkCm9M0t7SVoDfFA6ijItiNNw1/xJ2WNz3fi13GPA88ix/kG7i5Im4figyWFGg6KRcz3QvdTEPiZky2jeUQcQ==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 16:09:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 16:09:18 +0000
Date:   Tue, 3 Aug 2021 13:09:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>
Cc:     Leon Romanovsky <leon@kernel.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <20210803160917.GB1721383@nvidia.com>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
 <YPlrQ1Uu+OXxRJBF@unreal>
 <20210722130231.GI1117491@nvidia.com>
 <YPl6Oh5Gm0uQPiiZ@unreal>
 <20210722140231.GK1117491@nvidia.com>
 <20210803155919.GB11439@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803155919.GB11439@chelsio.com>
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 16:09:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAwyj-00C7qh-MO; Tue, 03 Aug 2021 13:09:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c36a51c7-8b5b-4f2b-e665-08d956990c50
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5304285B7CA3555400175EE4C2F09@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmsObIWXLjeF6XvZwAdcQ8c5WTpPKmk3T+alekEtlKa9zCbjL+kms7H6Tf/2804EpgN+kqvlSX438YuGrC8WU3tjK1rB6GUs8cwyHcw4hdvY/REiYI497u9I8JEjf/Y8n8zno5hSNsMSwxdTLHeONvEJaiv4JbRoXehQA639Np5csqbLhZWO4ya+N6ZhPdvYBNMt5Dc7x88YXIHw7lD8NGea6TyBdP95jSDiRcMu2dh62zvfCEg+3mRV7jjH5QFEZ8BLlsqQ9k8NwgmBq2Qyo3QYUzqfJ+yAeH43O21Sd39TvOlgo5iJVSVJDriTdUxlsP3ALbIECcczI8ycqo9IfNDsDYtP9WUsvaCBa7IwENhhNMbASQHL3zo8pI46B21rQgs6NVX7OouGc6o3N3BunRXIUIJRlK6DL6m2YroQ0aaGpsPgXB4Z72FJY4Wbjf2jUYajjeaYYP8M6GhzSKI8MVOzIJR33AG94s8QXNPHZy6YWhaHX+FK458wB4TOS8GYoieLEGXXHfUmKABG74oP633Y3XfWJFYQKvjb8V84rtGaqP1l6Oio987DZT4RSJ/lYbdFu+brTn/fOIEVpVGhNaaBTuWfGXIJ/u/QW1q2LK6ZfVCmnD14UICJnJVZQTGHny4TeKolrYo+TSHyDszW7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(478600001)(316002)(186003)(66556008)(66476007)(66946007)(1076003)(38100700002)(9746002)(9786002)(8936002)(5660300002)(4326008)(8676002)(36756003)(4744005)(2616005)(86362001)(26005)(54906003)(33656002)(2906002)(426003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3iPM4RPT2zBbA0Ph0cA/h60Zo4xsclYpurB/DZ8fwletjR7OC+u+3sJ0vylU?=
 =?us-ascii?Q?iSaJH2iyPraWitTl/4t9Ej6bW3Fe/9h5FHYe0RTPC/oC2TOe4vqyyopmK/KP?=
 =?us-ascii?Q?hyqZUFKR18aUruBzYpHkpUCfdZhRWjpsrOTr5/bW1/xAJFJT8BmMEPdh/mWG?=
 =?us-ascii?Q?5JGFv7udd4qlPs0qkXshzGhKpU8vQYcD0hoSiNT1F6SrYiu8/RMuE+2zpfrF?=
 =?us-ascii?Q?DpGT0mWLsYi9TPGvJy7zV2y8ADSgf1dbFGYutNd+UFBHcD/5c+kc4bz01QrJ?=
 =?us-ascii?Q?9fPR7zLzlcLOteUWY8wUkT1uowRnR4k8P0tFixJ5mtDiScGLiFsQsvZ4WrdG?=
 =?us-ascii?Q?d+e73VedVjZY0spDUcUkJBiHfCl1CDXfsmGBNd9sotjmYs9Mhv3X7vlb/yIU?=
 =?us-ascii?Q?2f/L7QtkAuArY+mJlHUf1GLbKGig7hhpyq2BD0Y6QBq/BNUpbh3LoLnfs8y2?=
 =?us-ascii?Q?UXtN4cPnkIpDx9nJfBx0hPLgP4x6fCROSF0FlEv+YYR5SO1WdSNUqXmMjDG4?=
 =?us-ascii?Q?Ar5TIH5WYG2A4esQedhpr4v0KKIcxJhrIZoUMuSIKyKrmHkp29FhiX8GgSwv?=
 =?us-ascii?Q?Uv0yuYE8q5CGyjuJ7vuvswp/oYx8MK3zY93cxFj/ZgfcBXbUUwFXpTdap5Py?=
 =?us-ascii?Q?h3hSjeqze52mMEGC8ndr8Kw0Qbpcew0UPnjf7hfDCXSMXG2ix5cX+uzz2EME?=
 =?us-ascii?Q?oUTpy16p3HPmStBXY97XkE+foTaz7rSSmZU5RDmzmMN1P9u87HFdnpr5+NYx?=
 =?us-ascii?Q?wyYFhMDQ8YdLlDlaGtmOaqRTTPLQWCd2/FgCCuWsOES6zFhP/OJa1LFUcJu8?=
 =?us-ascii?Q?c9PbT7qW0fE/esxnQ3m86vLGeVRTyHfcAx7gX1GSw7anFJKZcN+Isen0micN?=
 =?us-ascii?Q?KOkwrY4OJYvP1aI0aYRIHp1oaKsAn9QZ02feu/EQc7ubZyBaFSQiQ86lj32J?=
 =?us-ascii?Q?rjPg0aCy4vorZPopoITFqZqhRgVS0xiOWa2gvwTbZTcUYydVWT7rrPeLsKhT?=
 =?us-ascii?Q?lk+s1sAuLykpeGFYYI+pOniZXSD0bkNSh0Scbo66u+qemTzbXRy0lyZJX7el?=
 =?us-ascii?Q?XoxK8pWYjS/67E7lnNVZY1dZ3zT4h8fDfxZ20B8WwaQ7tYSK+mYaVpsjIpTd?=
 =?us-ascii?Q?lI6z4t546/4Stq+R6hPS1s8MvXipSITy+Pqf0RTBr4xOrsARmctXZGFDxyPw?=
 =?us-ascii?Q?wJ7+SLyJC+2QDCzM4O2vN41kS8VWHz4LM2Gcgke4kUIwqLN1PXNHzWMh3kpj?=
 =?us-ascii?Q?KxTwMcVv7CRVGXy4MoE5dCIgrYhMjz2c51ATMTAM5YkgcqnxLjJX3hVMEA2T?=
 =?us-ascii?Q?Tv5xfNK0rR72kH30uS+ZSVxu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36a51c7-8b5b-4f2b-e665-08d956990c50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:09:18.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSxdIeecaMcD4qQ08+o9xiLhkreiAyqLWB7EEp7ByVqA51XhR/QWpxVoyr18+XVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 09:29:20PM +0530, Dakshaja Uppalapati wrote:
> Hi Jason,
> 
> Gentle ping.
> 
> I think the current patch for cxgb4 is legit. I am expecting 
> this to be pulled for next rc. Please let me know if I am missing
> something here.

As I said, you need to rework this to use a proper completion pattern
not hacky like this.

Jason

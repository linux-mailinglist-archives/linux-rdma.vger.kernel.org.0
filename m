Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209AD42E15E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhJNSen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 14:34:43 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:54464
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232374AbhJNSen (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Oct 2021 14:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F49JjBeGtW4Wx/dViAhQhLkq5nhBk1ydxPOGKLU/ZD9xlp3kg8IsWV9Oa9HlCVnfoFLBag64+zs7GSblv9NrXKaYtnXo0ev1st4pyeld1ZD/lANwvEZSRDY/6rYXSwvGW1aNuBm+ygbPCGisTctbCnK/5FBrG0KrwfVEVDFh/lMSYyX2aIeN550xoGg2w9otbhV/dGoHnhFlXbnnkwPo7+mXvKzS+pT81c/YmKHjv/gFQx5AEOGXb/6tK9peUvgIIbGJM0aiWjKG7iX/3zQiZ6na33P7eQ2qF3kycxdEq13kyXhJSE227evJeEnPDLIJiHhhNWQ1GUbrxJlx+fKI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/RWTE9/BjGzjMXDT47rcV5+wHF2juASo6Ouh+xg7vc=;
 b=oflSnyJaH/eXHZCpXJJPHfhmkkbwCW3wGrWlRK9Ttf/0JkvlUS6qrG90LZmlzAH3YigWPNgnPUDBLtwRCDnu3OSWsECu8hR5QqqhiN3B0lwv5oPaZyQHO7sUh2c5Y20R2WCHbIl83a8Ht89/Tmry+qOdOH57qCttTys+TU4nmse8Dktii7/k005K9XlUEVaMl8eJ30Hbih92X57RNS0aGiwGKEx3I/yI5EOUxkVw0J2C4bpJ2gVDPcpseZqOD+lGH8En3WOyQziVWv655WRZKMF3Aq/BT0odXTBQ/qIqy72+aAqlLgJH6Ho8ihtvur11cCO68FQKgNbhaMJpmMw8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/RWTE9/BjGzjMXDT47rcV5+wHF2juASo6Ouh+xg7vc=;
 b=K4AGnVhdA/AM0OUBiFxPL8j/eb0Rx75K65UyosiuivYbCRYYtdJY6ZGYPGH9oE0LgfIj/aB6giwGgcGQDzNPTSKOOSccDiRsKzEdPweAP9xOIlWLLCWuGlBqTaRnT6qGVbhJ9FSpmWjA9F1s6Qj7ctaMzwvFS/TG1KWhgLmFUR7SQkhenYs7JnkRzZRw4DO17DAUifVYWs6WCAAfS9zH4Ik4pIRVoEYdFNW3W8iU1l/lE72VrABmMF9ja65GHMmL0SvTIW3D6Rv1LEIWCfayoBlrWS8OfzuFLLui1XYNFrN4sXxQq+4IbkVliU2j08fk0g+Wlp5sIhxwz6epGKFNFw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Thu, 14 Oct
 2021 18:32:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.017; Thu, 14 Oct 2021
 18:32:37 +0000
Date:   Thu, 14 Oct 2021 15:32:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Bad behavior by rdma-core ?
Message-ID: <20211014183235.GX2744544@nvidia.com>
References: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
 <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
X-ClientProxiedBy: MN2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:208:15e::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:208:15e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 18:32:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mb5Wt-00F0jH-Ui; Thu, 14 Oct 2021 15:32:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c114ed4-dcd6-4f64-dae5-08d98f40ff0e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53177C9329862AFB65B5E3C9C2B89@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUMYIR5cC2o3kYaljlB4JvbsQkTlsGNXq9FMuBta0lng4+rgHgHvN0q6Vbwo03i9e+3QeAqbRkfxqfnl37dXLpYtmYE9Nnotm7rjnNd/lrOpeJYJUfxYgCZ1MrhreQBOPDofWYLbzFyJxa/X4iIJzKT7K/I1M0RbZHFCB1fftTwhVsmetuq4KCSb7KcvJr5RTOSstjlzpO9qGMayUCPAh4IHY8rXa8rZO5+MFLlah8HbiIiRjS0TXwm3UmBZQ9mfBhESNO+gPI8gIley6Y3P+sy8MWOM391hF8PebXhi/tRlJ22M6FpTAAwEDbTpHFjDYA0fHwYQn6lXCbmdefK7SUTVHjLF7W1UruNiZ6cD6gcaiZvi4R6xNMX3krvHuvol+JMdpppjxgDNynDAcczCyPtMF7X1eirr4MAlX6vX+VBhTwML5u2rTVAz1TJYDE/yjyLwRwgJoLvsYc1cdqwBFGUXgZ68hdtU8h2J/EStJzjTeixfIPIdAaJCZk+IRYqysS8xbQBztq5Y85johNvRjf0X5W5r+0rwcjszLomY8GtDMwbnmhj6IhUTv9GTyZAykF0OQz2/jCtTMq8cWBcHia4DyCAp4nPb4XwRL/rIi5F18BpsTkC+VL49sMjhK4AQhRG7pOQfIihx22zUkkkiMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6916009)(26005)(5660300002)(66556008)(1076003)(66476007)(86362001)(4326008)(83380400001)(54906003)(186003)(2616005)(316002)(9746002)(9786002)(426003)(36756003)(8936002)(66946007)(4744005)(33656002)(508600001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cql1WZlZaM5gOlNSjdzNJmXmvr8CSBI1dvG2UJPV0uo8IIP8MeA80k0VgIgD?=
 =?us-ascii?Q?alSz1VWWOpFaNGO2ZNUsfYAOgsW0N+F2X/BYeihpwTIRVTyCKrKlPan0EhLa?=
 =?us-ascii?Q?tQ8uh5w19+5ZjmT5pyKNv8KKPzRsHcxJESg+Wop1CjJsr67plkZJNaFD1Ius?=
 =?us-ascii?Q?vQt5PyAOPjSjeZr0TMGVcmuvjglroeGj9dm/OWpdapCZMd2pe9lVEbeGAC3/?=
 =?us-ascii?Q?jTt/NKUoqIhEp2DM8TL9JQmGaGfuMWAsSwZMam8WcdJ1vMpfXVgiw9pclSDj?=
 =?us-ascii?Q?JUISoS1QxkUtdcJjuf65SWgdvVBTCBmBzo18yoowXadBQNQS7GFLGWgfR93a?=
 =?us-ascii?Q?2odjs6wOnS6GldfRz/brJCS0mB2cDyQjY2DBjLOnUnk6XKA4IUon4ud2AXVZ?=
 =?us-ascii?Q?LrMheIIaxttnotUTAEfmQcD3FwCgssbCrIgYTvIE8mjWHtSMvpyTyOoreJEi?=
 =?us-ascii?Q?L46yHLWOVgtclF1GbhRfxJAxpNjCKsozoeHV70ytOuIYF0NI1oT2iI/JBHja?=
 =?us-ascii?Q?17eO5vfznbA5a8yeeAZKyxZ/GHixoXSawAxaL5cpqj4d5Ao4zKcIrP2DwbS/?=
 =?us-ascii?Q?LTPaoJLBusYi/5iJ/gDhUi/zlfcR92EKgtgzrl5xilQTHFeZz9ALWwzanepm?=
 =?us-ascii?Q?eoAKzB8Ti3Vs1xNfjrfRUYS6MDIUSFgdYPPLdhS68aWep8nWW8KJtevDU1d/?=
 =?us-ascii?Q?bbEc1yRmqO0BS9OaPI6Qkim4s4ygBNcwbMfD8lKhAYi0Yht76jMt/OMvbeG5?=
 =?us-ascii?Q?Wmhs7MfuBhlTttz+U1hJ5pVCAxXm1ddJ46pF5Do5PiiCM2cWQHRTvgQbXmNe?=
 =?us-ascii?Q?EXJC2/EeCCcNHn9r2FHf7Xbx0Ja6MYuW4xoqpRviNLAsM3i96hb5E9TwJusT?=
 =?us-ascii?Q?zIlYMha4PTcGLN6CEzZfPbP9owGEGLIQyzKSRKpJ/q5Qsk03TE+mdOU+3LkJ?=
 =?us-ascii?Q?59/1OnI1Td4vtRJxSDiK1YZlwFIANvRCNEhy/vywbqZZTqCskajStiLut/bP?=
 =?us-ascii?Q?60buyjZLA5TYpSnXsRZl/Ft2n47GqaKdvqjakTl036SQOFB83h7OeJiuJrpv?=
 =?us-ascii?Q?M3ctBE26ygnDNKLFtD2i1rgZIRxdQiafRTwMJiZ+xMXpAhCSMIT90qp89OLN?=
 =?us-ascii?Q?qFCli4Q8YLi8e6YJpvOQ1ygDjdIJZCGULrVacaP/DpY2ogUtOCFmIJdfC6wm?=
 =?us-ascii?Q?S/Jg+5csMMuOx64gKpla4SvBhZVqdXQhXNMvIoTyxA8gs2ZCJCpXJRf2mseo?=
 =?us-ascii?Q?y+Y7QHbFTsigPWQMumTyTR/ocT79LY50QzYgN2+dMthKkQJ1on0oNbbaqed9?=
 =?us-ascii?Q?M2vOuA5O4IraMqG6Bd9T4Dbid4QedL7TgJnE67BN5maMvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c114ed4-dcd6-4f64-dae5-08d98f40ff0e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:32:37.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmz+8eA/fLFVnQNUjCkr2szd1iMrQM8NhJFVOc7YHwtxWgcffyGqK0L9BR28YawD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 14, 2021 at 11:14:57AM -0500, Bob Pearson wrote:

> But ib_uverbs_destroy_ah does *not* call rdma_uverbs_destroy_ah() it just
> deletes the object.

ib_uverbs_destroy_ah
 uobj_perform_destroy
  __uobj_perform_destroy
   __uobj_get_destroy
    uobj_destroy
     uverbs_destroy_uobject:

    	} else if (uobj->object) {
		ret = uobj->uapi_object->type_class->destroy_hw(uobj, reason,
								attrs);

Which calls 

destroy_hw_idr_uobject
  	int ret = idr_type->destroy_object(uobj, why, attrs);

Which links to this:

DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_AH,
			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_ah),
			    &UVERBS_METHOD(UVERBS_METHOD_AH_DESTROY));

And thus calls

static int uverbs_free_ah(struct ib_uobject *uobject,
			  enum rdma_remove_reason why,
			  struct uverbs_attr_bundle *attrs)
{
	return rdma_destroy_ah_user((struct ib_ah *)uobject->object,
				    RDMA_DESTROY_AH_SLEEPABLE,
				    &attrs->driver_udata);
}

So, look along that path and find out where it goes wrong?

Jason

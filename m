Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5650C368111
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhDVNC7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 09:02:59 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:38646
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236078AbhDVNC5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 09:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS3FMbwNx71UWcYae6jaEl9x0Mn3Z4I7fa6au8ORUKRxCPRZX4VNgicQqxFr2D95PTEJE2j89qRSyK0Nclo2xfNZDWIA1F1CQimVl5YjNN188uscWVJfOghZYRUVIgh0ou/wVTpraOrEMEdsx8xyBLjgohI84BvSq14vh7AGS1p+4TIiIT7UL44NvFTVq+6dzuO4Nd8YeAToNb3UUcz5EatpqOluTTuBE7g1fg2bQGsYd19khrKLvbzKTYd+taSiOa+ZSAUMQsf/JG7AytcGNOroclqKGGNE7M8kffmwyoIn9qJzTmDKvC7xZRcZMzibTwV8X6ATLo/Els+5jE3Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e90uoo7vz7uXbP6uwJ3r//qe4B/+e+KXg8hxztAHrg4=;
 b=boUtkQPfL6Vz9TPSuvWknqGEhKOZtf1DMwUyM+WbxnQ4Z76Oy/zPmVk4C36xENBYKpVlIDYoTf9mWND6gmORkwEwIRCoPvwERTF9bKkfVLMrvCXjBjSVDyFhcF8b5qkN7SqqS3Y6/q76pbjJVNqWe9SciKjhxB9OiHPd6f5+chUVr5AUkxYl60JUo2J3bKCZ8yY+mEMziKcGG890+L9/7NYheG//Wilk0MRP/wRk/oGyWiMlfBFtCAkmEJ+apjT07RjUNo1gXOv8Xcd+duFPJ7HQ8Qmd3nMkAPVk8N2sIgF8jNOlcXxVzNVb1MAQXBG9q8EWNGvR+A9E5n5Gq24rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e90uoo7vz7uXbP6uwJ3r//qe4B/+e+KXg8hxztAHrg4=;
 b=FyznmCrdlK0TICwQ/lRbpktepcy1lGjaQSYBvVchYwH7afiuBxtq4TA2pvepUrUgtqZ8nB3X3t7Cd1o+OwghotcvViU8uFTKesHBdOE3K3YOsWKL9mGcBpYx7LkZV2BUPK/sffjEYP2XxBkk7MH9XoHPMb5W4UggSaEVruxfEaSlPjdcxsNY/rgzdoGLdsnG8gqo5ithVwzRHmqJSLD9QdKka2Dk4m9jOTL2b/xWrW7xWzMCA6CuT5soENRv54AwJzoUfXb7MBX0jF1fCaRBK89BQBz3hdfj7xA/7xJQkGFVz1SWINfKG3RZ+Ls866sUCUtNLEjudnY4Nep5ylToAg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 13:02:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 13:02:19 +0000
Date:   Thu, 22 Apr 2021 10:02:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <20210422130218.GW1370958@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
 <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
 <20210422125135.GV1370958@nvidia.com>
 <YIFzoJOVvZPPJwwy@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFzoJOVvZPPJwwy@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 13:02:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZYyI-009xuq-J6; Thu, 22 Apr 2021 10:02:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc1a741-497b-4411-25e8-08d9058edcbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4500F0C5BBED04AC35748C9CC2469@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BE2HvqfGjVQU9sZt9FyQEb73ORT69xzU8MrY9Sv3Ax5t3tDZp0enydIbONTaEDnrc0qzxPJf8F0jTkJWDU+GQ/899PikxdKYcEfhGtQ/vLWdH/fVRsOACTzbRHs4R580I1nSdroKeVC1Ll0NbM4zEcD86s8WChT1SCVyn6/FEZ1eEeIbZl7mz/gttr0py0XY1sNICB7eWpOf2i/YOzuO4hpKx1qi05zqg6HZFy9uPEKZnYKmyOOqirIzHY4YSpAEi7UftOopFWpn9th3GJBGfmjdo6lDAJUseZVPQLCOEfpM19Cwsu+dfj0+lsPPFAO9epADAb0E0D6vvSJaj0S9S5j0X815iNpWF5cNPPaiM5oLBj87rlHoDQkKu3IWse9Nq1qYBMBOehNe6yLVby6N4hepbyE1QQXGZzx2zJ1hmTNQfv6b32AIUzR3UsiTVl1mNixBfF5OgJ9Li0/1eN31btv0T9OO0P0Vqo4R4SBE/OOqCgqNVsRoDM23tkZf2Qoisu8t70tn3xCx8/Bqk77z8ayfqki+dZqmx5/bMGTxql3B9bMy/Y5UhKgMQiuuQOn/BlfO3KgqPo2IfQkfuDUW02cqdKFbVEJbaMAx5BE39LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(366004)(396003)(346002)(4326008)(9786002)(9746002)(66476007)(66946007)(66556008)(8936002)(33656002)(2616005)(478600001)(2906002)(6916009)(26005)(38100700002)(53546011)(426003)(316002)(83380400001)(86362001)(186003)(1076003)(8676002)(36756003)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4t5tjZqzMNbEO5khD3UWvGIa/6aWlYKuUIOogl558EfxcUtE1YKTq55DEHPt?=
 =?us-ascii?Q?RDRhudPYSFBEiMqzyk2JswnAYIkOf7Qg/gIAhbUQiFco4oVxCPZJo8f5bD2b?=
 =?us-ascii?Q?DG2ebgstz7BTBuvpfhMX2bSvjYiPs7S4QgY3dmkT8oYxaUnzxeum4kaHfxbi?=
 =?us-ascii?Q?X7i8aM9SfHJMNcT+qd7vWAjJnvl6QFJieloSY4bP1LLElyJuqMONZIiIsGN9?=
 =?us-ascii?Q?lzf8U9xzy8GlfDbyyS7oQJ8Mq3X7rCqm+N6WR8joAPJWPdnsuNBYIfDShzMo?=
 =?us-ascii?Q?tiaW8EK/OAiVFVKeug/ZnAzalnh3LNS1bW4tPyKEf82hVQLKf/UGffX+qVX7?=
 =?us-ascii?Q?T11NX+oHb73A2crEUyQsAByR++4puB7oCIN4GoDVANME/yVZqWrjliUTcjSP?=
 =?us-ascii?Q?4ifPVmoE07TOPXqQSpNJL4UNXGEepV0tLln/JxZNcPyFyPxRF5Z8NLhQE5EQ?=
 =?us-ascii?Q?Y2Op1VJsUcEdHuXK3IxVyylpeOibws1GVjJk2pN9CCaUENmarkBguFS7ovN3?=
 =?us-ascii?Q?PDo0fjlY/xA5RCqYBa8ezcKq7Qxxq1L7F5atpAF0gUMfq3yhhkkz0vQ4AX0v?=
 =?us-ascii?Q?noNntcUVfrLbau+WEu92RretjH+PcLyhxBiUvHXQIXpLYh+hLFlM6riLrYdh?=
 =?us-ascii?Q?24LYcACeGpO9k/CR0lUKgK4LymLQnMkwKco4iN1GHso3jNHokaba1IWrF2XB?=
 =?us-ascii?Q?PGekDXcnVjUn1yGagdAU96VICAuAAmYBPKeyLiODBdYgJ3RkcoXz9mjbOzyF?=
 =?us-ascii?Q?G+Lr51XJ/f3ak65c0ozCDhEKSSjEbjrBzAM0kMU6SHGJ08h5i7qZ/dAJEDlg?=
 =?us-ascii?Q?GwoTewSNdr+xzCMrvJxWh/MEotPOxbNaxAPuwuxRthofHfo7IiS5WK1rwWkz?=
 =?us-ascii?Q?dMEM6jrV3szZ+QcXsnEoHDRF1MHn/dPY55p0br4s5gD1JGCrYIIOWImNzZDJ?=
 =?us-ascii?Q?Mq4Tnq2ebJZQOl5UzS8lXu+khlGWEYhnJMXi3Pg2vFW/0udggQcrIPJvt98/?=
 =?us-ascii?Q?9cd/rDfJ+NUEe97lPOKcoXDR7Q+TxyffX5cl06RDNmucVVoPf4NBgINt8SQ7?=
 =?us-ascii?Q?vrCgg6prIckcyJ4XbLrkQW0m8QpRlJgqIpfgDe3o9diUv1Aayi++cjlqhybe?=
 =?us-ascii?Q?T4398vEADH8A7tFAKzzOHojLn1p2LbXDgj6JB2Uzg42GVLG4JWxW9yiVytvD?=
 =?us-ascii?Q?7+2PiEEm5Z/EdECBub57KT4q6orbF/4wh+HSzDtFGcrBLaHyNl5dg55XhJME?=
 =?us-ascii?Q?Gd+9zIeR9QeGldB5gd+1yrVWvd2umnPLPNxYviARfaWO6iY3AS9xuRJvlEsn?=
 =?us-ascii?Q?FYxPGedUA1n6HIATVcDi5XQM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1a741-497b-4411-25e8-08d9058edcbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:02:19.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0AIS/BO5GPByF+OAYQhzg61FewwTyrOyaKB/ZmcmHpaNMQpBVERvYJ0HrvNwrtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 04:01:20PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 09:51:35AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 22, 2021 at 03:44:55PM +0300, Shay Drory wrote:
> > > On 4/22/2021 14:28, Jason Gunthorpe wrote:
> > > 
> > > > On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> > > > > From: Shay Drory <shayd@nvidia.com>
> > > > > 
> > > > > rdma_listen() checks if device already attached to rdma_id_priv,
> > > > > based on the response the its decide to what to listen, however
> > > > > this is different when the listeners are canceled.
> > > > > 
> > > > > This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> > > > > and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> > > > > according to the cma_cancel_operation().
> > > > So this is happening because the error unwind in rdma_bind_addr() is
> > > > taking the exit path and calling cma_release_dev()?
> > > > 
> > > > This allows rdma_listen() to be called with a bogus device pointer
> > > > which precipitates this UAF during destroy.
> > > > 
> > > > However, I think rdma_bind_addr() should not allow the bogus device
> > > > pointer to leak out at all, since the ULP could see it. It really is
> > > > invalid to have it present no matter what.
> > > > 
> > > > This would make cma_release_dev() and _cma_attach_to_dev()
> > > > symmetrical - what do you think?
> > > > 
> > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > index 2dc302a83014ae..91f6d968b46f65 100644
> > > > +++ b/drivers/infiniband/core/cma.c
> > > > @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
> > > >   	list_del(&id_priv->list);
> > > >   	cma_dev_put(id_priv->cma_dev);
> > > >   	id_priv->cma_dev = NULL;
> > > > +	id_priv->id.device = NULL;
> > > >   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
> > > >   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> > > >   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
> > > 
> > > I try that. this will break restrack_del() since restrack_del() is
> > > using id_priv->id.device and is being called before restrack_del():
> > 
> > Oh that is another bug, once cma_release_dev() is called there is no
> > refcount protecting the id.device and any access to it is invalid.
> > 
> > The order of rdma_restrack_del should be moved to be ahead of the
> > cma_release_dev, and we also can't have a restrack without a cma_dev
> > in the first place
> 
> We have restrack per-cmd_id and not per-cma_dev.

No, restrack has this:

	dev = res_to_dev(res);
	if (WARN_ON(!dev))

And here dev will be NULL if cma_dev isn't set

Jasno

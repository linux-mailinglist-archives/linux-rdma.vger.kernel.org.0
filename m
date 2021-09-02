Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC93FF063
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbhIBPmZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 11:42:25 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:45248
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345909AbhIBPmZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 11:42:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHrCdDC0XxxXa3NdCUGp/cMByAJOwBUvKgIfAuGHTsrF7sY8oXOSj9vfGWCnvfdsW7l4KiIPgpwhc9+3gA1gjYbzHK3tquM6feGOI9uxuHitzC4PAaueR86gMQCfjgiAlZLkjw2lF5vLFCFeIE9Tzfvc6JAeMoi7VBTp7Xe4NgGGRZvkVPXfKj0oSuDq24RuYKImTZjpliCqxrVR8rWs5y/SThuGYYV5Cd+4BVt2m8hTtR0HLeO5feyUosRdBkjzGf5+hvmWAbtclweuRJTpHug7CXeaM7DRYTSH2y9C2NPJJaS4HIdvL3Q4/E2WOTR5TNbDhG1kJjuhmfcjGOAYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zbCPjEKd4bngPSIEynpmcRgAT++4V2aAIpKUnyk5yBc=;
 b=VdEovrnMXm7ATSjENpXq2YLdjLy06lECiU3bjTcgivKUueXh/C9zMRLdiq4f+U6771v49ieiaQMRY7uihF/FYAnOOqAmK6kRGwj4xuGgkXNlaRBQ1KkaKyg0qFI99dmlh7EetsRePhdKH/BK8EpXBfCXc9L/9k0Yv0NjpwBWEkQGZ6nv4agmCeoT468kGsz4esGf+tUxrtxz8q+cOGQtgQbZQwpFnTF6z4Ymm6tm1TYVRE+rtnlrO0y8eN/gBWRwte9zPRWcwSyi9a14hxgf6za7j0SRLCyDjOrEx6BKQtGwe7H76FQV+o87niBrOrpmARhlxUtITaFL72O7RsYwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbCPjEKd4bngPSIEynpmcRgAT++4V2aAIpKUnyk5yBc=;
 b=k+ypTPyr7kmLdJ2zsuN1jOc8TtUpr/C4z1VkFl7vM14q27gAiWpVzkPciAm052G9aoXow9+iISrli9OXQmCcr0vM7yIG6wdnRFd1PHz7UQQx5QAdnDmwsWRnFxXuslkP7Aipb7ki42LGEwe/inF8EDCKNVBbDb5eUkY5VHli75eEWenlEQC6aENWOpYcOtD/ahdIShRkQ2VkY8iCZPYqqK9kgXGqw9Qc1SZHZ02Xk61h5Y+eoHPIodSeTmNoRKhXxu1FGs+O7EXBR245hDk7und51wpJAAITU+/DEI0THDi0G4z2/GIQ3Cxxz+ovY0vmD7K9dWSJVhKeDhMo/4cFNg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 2 Sep
 2021 15:41:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 15:41:25 +0000
Date:   Thu, 2 Sep 2021 12:41:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210902154124.GX1721383@nvidia.com>
References: <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
 <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
 <20210902130255.GR1721383@nvidia.com>
 <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
 <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
X-ClientProxiedBy: BL0PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:207:17::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR1501CA0002.namprd15.prod.outlook.com (2603:10b6:207:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 15:41:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLoqC-00AMOZ-JD; Thu, 02 Sep 2021 12:41:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 764c4404-9beb-4875-0432-08d96e281f71
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143D61C7C42844C8F6009F9C2CE9@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8TWXm/5j3gbgL3Bysu5v6VVwLOGQN9PH0/SR3HnUVBhG5hxYKPWuR8b8YDrkJAHmaE6GuSrTBJ8rA/4fnvgzg8573EedqtAJ4hr3nVEtQfwoaRsuOvBAhXumys/xQmu+vSQoXHPRAlXclAQ5Ak87xkAl+hglZIZz4ujcK84+Es+agkWb1/ONY0cxA1QiTTT81IklyKpkwSSvNJatxG4oVTrcvFsUF3KGI1kGexFDxn698d7Fu3ElJhv5NGsOt9FZnu9/uVcyY/G2kazmsqDPMsFkmQJ1Or71Zvu/yKVeNtW4VLxzQCxGr7t25hM9KWQIycOf5t3Te64oLxyI7EiG45FuNu7w3iefqBMflbsIiXov8R7W4/E+Z7eE6rxcopQCdb8p8Yjf8y+GJVkgkx4ZI3U5KwVYvmFSY3hbfEUSVZNFk+3mQkYA/Ow6KpPwTjrEWIpwnRw87u6KXISRep/tHlSRGlZueyrkQFBQ/HslU9zaZqWKQcufFvVKQEl1P3PKTG34KdqO8q8M4zFgDF4mbXwpzcgzcKZ7oztoqgzudPtcnte6mjnkrK4X4HO46j9+3KppnJgKJXa9koX/k7JXH2GbrcqHvhHXyEMqKvmJzUf5NvSTO40D4qLjenikqh5TkKV2YmDTdFu/YhlI7ZOLMqNplWh+QEbB5OqHmV6qGNmM37zpAuK024CWazeQbb2UzLs/KV6KnPgmWsyaSUtpeVNr/wWHHV6EgW0LNp+166uzrnpe3MjdWjIHAzQqsrX7bYAU9aD5drinG10M4Wl4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(33656002)(54906003)(2616005)(26005)(86362001)(316002)(9786002)(8936002)(4326008)(6916009)(9746002)(966005)(38100700002)(2906002)(1076003)(478600001)(8676002)(5660300002)(66946007)(66556008)(66476007)(53546011)(426003)(186003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P8rbn925msw1rslR2kSO55dEoBQbDk3ixVJue4gi/OXRfw3YyRnwT6aONnY3QArWAwUxh6fKA71q2oIith6HGXKcSDNa/s8YktI3rs42fLBf9+a8rdSUtm50JdIiIMTdoe9BlZiGyySPBERkBvxMVsLF0D5Gub7A7H03yY1Xy6Yp08VYXXDIfQ06AFxP+JYgsWKmlo5fTpEaVlNy5OyDA3drE+WPbV+/EM8YqEWJp43yK2ehbfFvWOBNq6OuwC99IJz8b1dftguaWwGDUK4GHPpY2s7qqZAkIO9FLL6qUBx40jLZSxJHJsfVv+OgcZsB9CXo8i5c/LDJ3GI/GD2sEoo3flj1sz5znZYYELm8w9qd3cPl+iss/9pXimSETUbq4zPKV9RXWmgjHeEzfsFJ2MTAJfdqdrUwxBydjO2M+VN9pspQtNPT3iuEZt/npMeGIef/9pNrvo7r/wYYOQU5KfJXnkjOHEfEiVLlJql87ZAIoqLRBHREYErz2GyE84SYaPAMCUN13xTKBmJHz1PqMJ+7W777bInX9ncd344C8uFFIlHxThyuVSRVIcd23Nv50FrlKmHPdfcn5H9nRk87HQrA9K1tby7sPN3eg2VhkZ4x508QrIldF9vjsOplhG4MuPOiEmgHqZvQXEN8DLy0ZosgC3QPNMsScwN+5PSeHmG3VVa3qWInjQsl+b9jHRyrEf4sr33QtHnZXaRkgHSXVXHBYWZOeXvgpwKU9pdAQ71yaxgB9oA7BK1Cb4hf1yh3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764c4404-9beb-4875-0432-08d96e281f71
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:41:25.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4CeE9iYon04cqjP7mCFHvsDA2XCnJJorlvHAmaAG26SeP9eSSpCfwpT2oqjWALW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 06:17:45PM +0300, Gal Pressman wrote:
> On 02/09/2021 18:10, Jason Gunthorpe wrote:
> > On Thu, Sep 02, 2021 at 06:09:39PM +0300, Gal Pressman wrote:
> >> On 02/09/2021 16:02, Jason Gunthorpe wrote:
> >>> On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
> >>>> On 01/09/2021 18:36, Jason Gunthorpe wrote:
> >>>>> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
> >>>>>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
> >>>>>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> >>>>>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> >>>>>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >>>>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>>>> index 417dea5f90cf..29db4dec02f0 100644
> >>>>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >>>>>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>>>>>>>>>      pci_release_selected_regions(pdev, release_bars);
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >>>>>>>>>> +{
> >>>>>>>>>> +    u16 cqn = eqe->u.comp_event.cqn;
> >>>>>>>>>> +    struct efa_cq *cq;
> >>>>>>>>>> +
> >>>>>>>>>> +    cq = xa_load(&dev->cqs_xa, cqn);
> >>>>>>>>>> +    if (unlikely(!cq)) {
> >>>>>>>>>
> >>>>>>>>> This seems unlikely to be correct, what prevents cq from being
> >>>>>>>>> destroyed concurrently?
> >>>>>>>>>
> >>>>>>>>> A comp_handler cannot be running after cq destroy completes.
> >>>>>>>>
> >>>>>>>> Sorry for the long turnaround, was OOO.
> >>>>>>>>
> >>>>>>>> The CQ cannot be destroyed until all completion events are acked.
> >>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> >>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
> >>>>>>>
> >>>>>>> That is something quite different, and in userspace.
> >>>>>>>
> >>>>>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
> >>>>>>
> >>>>>> Good point.
> >>>>>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
> >>>>>> have a synchronize_rcu() after removing it from the xarray in
> >>>>>> destroy_cq.
> >>>>>
> >>>>> Try to avoid synchronize_rcu()
> >>>>
> >>>> I don't see how that's possible?
> >>>
> >>> Usually people use call_rcu() instead
> >>
> >> Oh nice, thanks.
> >>
> >> I think the code would be much simpler using synchronize_rcu(), and the
> >> destroy_cq flow is usually on the cold path anyway. I also prefer to be certain
> >> that the CQ is freed once the destroy verb returns and not rely on the callback
> >> scheduling.
> > 
> > I would not be happy to see synchronize_rcu on uverbs destroy
> > functions, it is too easy to DOS the kernel with that.
> 
> OK, but isn't the fact that the uverb can return before the CQ is actually
> destroyed problematic?

Yes, you can't allow that, something other than RCU needs to prevent
that

> Maybe it's an extreme corner case, but if I created max_cq CQs, destroyed one,
> and try to create another one, it is not guaranteed that the create operation
> would succeed - even though the destroy has finished.

More importantly a driver cannot call completion callbacks once
destroy cq has returned.

Jason

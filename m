Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9430230A02
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgG1M21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 08:28:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11315 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M20 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 08:28:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2019bd0000>; Tue, 28 Jul 2020 05:27:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jul 2020 05:28:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jul 2020 05:28:26 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul
 2020 12:28:26 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 28 Jul 2020 12:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfE0C19lGVKp9pANTKilAKu4fF8hqqY5TRt2//7RLj6gsWljTjOPex9BhP1FLF0A9dyhJqQp80ue5Is3TvRdqirOjt6U+BaxQTYR1sq0p6WsqMjRtFaZbkKwU6FmANoLz/lHxMAooNEg57cvHQARIiXGxwpz3kN+EYSZ6+oBrxH5fW3b3L/z2re2mM1TE9EUMkWdtvcF9tXxntzFwPBeFpPzPESx5GcqhpEwfHDYOzMOC1pK10gTpR8MoSibJqrOxixbLu2vGgOqH8fLDu5ybwU4rogl93MuNxPvHZC7v8vmcLxQsmlsGMnGqLPF1prD+PLn5Wex6+jPLCM8P38wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66MvD2TCJniLWXey6wVdUNlDGzxQTAx3Z3Vr6KjlwIY=;
 b=ObdVXWv/p724VZzE4X7ISqnjoQKSbabJ0UX2JHsuS8Mo/3ZHPXSTE2SOyMSJOfoP0C23Psq/jS+z8dqMK+7voBTbQdWA3qzl9vPwncssqZPGTuysQWJqeqZzoCn1wFv1/usHwZhzNvY3gq7Ej/vreJ9Co37Oe14BmkpqPH91MdvHjItdFhbxUCHrL8tq2TUVbuX+6ggQxU7LohXBsYu13oLIusFdd8mfoAMcQkWbqVhVfEC9emz1fJ+WkW65hxzOyLqYYFhGqPzELL84ZiZ0+muTZ2ZqKKpO4h3fHQKsCR30o154+m88/3UxE/Tlj6bAVbHaHKL6AI3zJT04kFIAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 12:28:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:28:24 +0000
Date:   Tue, 28 Jul 2020 09:28:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v4 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200728122823.GA16789@nvidia.com>
References: <20200722140312.3651-1-galpress@amazon.com>
 <20200722140312.3651-4-galpress@amazon.com>
 <20200727185633.GA70218@nvidia.com>
 <1efd7d21-2e4d-46b8-fbdf-47c4bb5553fe@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1efd7d21-2e4d-46b8-fbdf-47c4bb5553fe@amazon.com>
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0041.namprd19.prod.outlook.com (2603:10b6:208:19b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend Transport; Tue, 28 Jul 2020 12:28:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0OiV-000UqN-Gk; Tue, 28 Jul 2020 09:28:23 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad357a7-46c4-401b-d621-08d832f1b904
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:
X-Microsoft-Antispam-PRVS: <DM6PR12MB413745D34F598ED8546A9A45C2730@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pmz1Y8qhdU8N/8+qBhu5t1Px0TunKTnRKSddfwWxZZhk/+B0mKU8LbvidYvUNPKcEQSiKTfoiobFCx++Q8VkTndM3ZZnVaMqFDJGFOqVhxbifmx1cElZthrpRYevY6OGtm4CEdI5MGy+BDhwF9uR3tG+nNzfq+w+Oh8Ugtr1vV3t1tEmTnZ8E4XljeNtv7yA2splJOTe03RxxT6KMQGe9SMMMmOZt0hUKNRhdq8XNu4dflhXkmnj2CWDbnE2xRXzXAJcakISslXnLjLBQGoHul0AHtsx/lZXMEPyarqRy0ln5Mn2+I1eDu8jQWH/Nb+yVik4OAX+WwSjs1Cc9fuUoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(26005)(53546011)(86362001)(5660300002)(478600001)(4326008)(36756003)(1076003)(83380400001)(316002)(2616005)(9746002)(54906003)(8936002)(33656002)(9786002)(426003)(6916009)(2906002)(8676002)(66946007)(186003)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /D10WttEL7O0VDbusDzqLCkPbxItP3PsLmR1xIyFee/p4yBqjYOtNCKLQa2+eMMm/wwTrCO/luoUlzUvlxAfIeRw2B940qb+vdJSnnuxeTk8e/wKoVO7I7ysU9E3WvKar3aNQmAk9bF5ZLYtOG1jd0OqB3OA5vxNinYkjavKfd3VMqkodEuvJN/Py0Tp7JEXPAyjBWRfgtQKxFeiK5F2qdKlcfrjuTPuNbtN/DFh5AhpohMYJhb8zEazYzRA3ywpT592Hv28g+MZA+fuhJ+NqjpM7kcx9GJtByH5diSFUzyu+1Ol2hqzoDVNNe9LRVo75h9zE0zWL6xU5JVyZqx0la0CjMZCtTH8fsBO9d/RUO5glZXCD81T6i4DfHwKYrj7bZWxRAlkN7rK/lvsqAcpcySGaCsCt6FJXWGKaYytSajDMMA3sgDyTJnLfkaEFhZUpQ2Vr4Bj5hrExoLuWgqb0x/8MQ+A2Nnxf0n4ULlCPsY=
X-MS-Exchange-CrossTenant-Network-Message-Id: dad357a7-46c4-401b-d621-08d832f1b904
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 12:28:24.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oM4v2EMYWf/0xtuYa2WY5EowsQl94TbZ5giwGGiXmYMsojYw4yoFyosfE9gnPdfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595939261; bh=66MvD2TCJniLWXey6wVdUNlDGzxQTAx3Z3Vr6KjlwIY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Y4A0GAIg6avjdnBp3zT6sesxi8UUB/gIrLxP4XOLnfmCEwiDmaSUpbl8ayOYel0FJ
         6C534r2kHsmgLXtZqYMcZe2zSEEB91A4avJJc473weFRon25WvJ6GKnNGHAElA4HQp
         xqltHnVlSI0y5/Buv5GwSABzD+EkmOzxL24igOzwKDZwSVG8zSQSv7qzea3c9mDLHA
         hoD5wRLcjf3AqvvaO6pBWykS5kygyvVHCfDVA0DOM05Y0qWIrMXa4o8VRHwyHUGPFf
         qJxLtOXM5viK3uCHQF/4rPmUKE3xnOeV4tG4mNrDWK7QJkbo6LgtkMbotaaT150SRZ
         xvN04mTINavDA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 02:50:18PM +0300, Gal Pressman wrote:
> On 27/07/2020 21:56, Jason Gunthorpe wrote:
> > On Wed, Jul 22, 2020 at 05:03:11PM +0300, Gal Pressman wrote:
> >> Introduce a mechanism that performs an handshake between the userspace
> >> provider and kernel driver which verifies that the user supports all
> >> required features in order to operate correctly.
> >>
> >> The handshake verifies the needed functionality by comparing the
> >> reported device caps and the provider caps. If the device reports a
> >> non-zero capability the appropriate comp mask is required from the
> >> userspace provider in order to allocate the context.
> >>
> >> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
> >> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>  drivers/infiniband/hw/efa/efa_verbs.c | 40 +++++++++++++++++++++++++++
> >>  include/uapi/rdma/efa-abi.h           | 10 +++++++
> >>  2 files changed, 50 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >> index 26102ab333b2..fda175836fb6 100644
> >> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >> @@ -1501,11 +1501,39 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
> >>  	return efa_com_dealloc_uar(&dev->edev, &params);
> >>  }
> >>  
> >> +#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
> >> +	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
> >> +		     NULL : #_attr)
> >> +
> >> +static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
> >> +				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
> >> +{
> >> +	struct efa_dev *dev = to_edev(ibucontext->device);
> >> +	char *attr_str;
> >> +
> >> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
> >> +				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
> >> +		goto err;
> >> +
> >> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
> >> +				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
> >> +				attr_str))
> >> +		goto err;
> > 
> > But this patch should be first, the kernel should never return a
> > non-zero value unless these input bits are set
> 
> But that's exactly what this patch does, it can only fail in case
> max_tx_batch/min_sq_depth is turned on by the device.

My point is the series is out of order, the introduction of the two
uapi parts should be in the same patch

> Anyway, the order doesn't matter as long as the pciid patch is last.

Oh?

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE738F5FD
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhEXXCM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 19:02:12 -0400
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:27522
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhEXXCK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 May 2021 19:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpTRgXaFUvVut6A+UgJyTvBdT9iKyR9BHP2YlvsAiLv/8MF8i+4Xe+Lcp5GRv3qF9G1i+yS0McaTx+hvmZT1RvzF5FiY0qv7+7Gey+vnCYOKlPnEAsVR+BGKDfWxtQ6PDURkzuSFp4LpimZtBR82gIKQiBDd4slScwSKOYMyAnYAEZEC1K0Zq8VC9x5bjZZPSYDZ8A8ZjIVzDNFqda2oUJmXKFVZgOrMWDEEF8LufHTOM6yBTFMzfwno2k0CN4l7kwgLRs6f3Qjkx60+9STHDZr8oG/wn6n70tl2D8CrB0c48EJMgwAFnVZhScRsO4qjZCycQPKCsRmAVbx5WI+16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/sXDYMczqJiZKiVzbcLWC4f7E1IArKpIroJEu0zucA=;
 b=h4yhTfTc7dk2rKDyaeFSEUMLYaMTSAwynVF05Hnp+s9nwFbwUoTAWYWfvT8D5Wit4cwcAjK+lqhze5x1CTOOR2BesAtmfgTlGXtOwRiG7vJVnbZqRyEQa/qzB9bIzLcbkM/vT+RYQAxCRzTU0rb4vas9IcevPFUEk3rrbl5MWb+JY/prXj38yGikzwM55iMnvA6Je5fzZbqox8K+w8OMyqN06uvNQRvc12AK9XCtsPS0NnZX/hAo4nrpYmVeQWWro9TEPpUwU4vu+o8+4aNNPWDtaD55cFkV04jPuTSqvqLEoKO6Bfe5ukDtOZhLyrhQReooCE6hOrkGUCKTIy5Iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/sXDYMczqJiZKiVzbcLWC4f7E1IArKpIroJEu0zucA=;
 b=XYZ8CowqvG7MAX99Satb+yG/gGl8ULOqL/h1C1p+Tc6pf+3JEI4q8t1yGc7NMpLZsYqEa1NrY9wg0T6MKHF+u5B1WiKsPZOjhftX5bQN4tW3QBwxtdaP7ISe4q7c5guQZUnvap5BMuGxtv2ihcYJ2D1DOPI1C8ygSeHkJiOQlTjxXxY13b26uE/auxJR2f/AFYiZGLwy07pcJFC21rVbCN4OLfxNSP03CnwEJnDpZx3fXfzQZK3P9y1fi3USqW7zIo5BBksSbo5V71iKtCBndniYduR4kBXMau1vxIBzNVUdY7yWLr/NsvTOQRiF8RDNDIkXNg9EjDynMkg8eoEMsA==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 23:00:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 23:00:40 +0000
Date:   Mon, 24 May 2021 20:00:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH 3/5] RDMA/srp: Apply the __packed attribute to members
 instead of structures
Message-ID: <20210524230038.GP1002214@nvidia.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-4-bvanassche@acm.org>
 <20210520144856.GA2720258@nvidia.com>
 <7a77c2ed-5336-11ea-162e-539b593a1ce7@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a77c2ed-5336-11ea-162e-539b593a1ce7@acm.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Mon, 24 May 2021 23:00:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llJYs-00DocE-Nm; Mon, 24 May 2021 20:00:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ea5f66-5a9c-4c3b-5294-08d91f07c098
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB524078D726F100B10883D252C2269@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iYpo+XDOCrhNhkr4DaHCvSKWW6ZhAavmt9tiz6Cyab/2hTUfIxwlBEGBJlpaDihZJJydUsaQpV2Pys3zTmHikH0/mU+0p6xo7aX3p9/Jz+JeZVO8LSzj5GbycOj02EixufGxOrmy33A2nGFuK1dKdfG1XoydzJJV7iGMRXsmmSoiXy7Q2HbpdPrEsvKoX+FZXUkEF2nhOLbUq34IjtfeRv/6bYu/IIM22w6itctAmqA0eUbGrh07XrIf6iCk1g1bL0+aH3EDwr6hQdbDQqbKLLJiRCX0+SPH44Quof04uh8cIC22Hv6D6bsBos6NH3LiVLqkW1nzCqFMd1FyuY6y0LOMmtRVPaSFm/E5EIW1cqPTln7FqoOgcIQHtX+MFyQSiNJYyMzwv98XDaEpmFXjvMgKb0Uxy4ze5ZcYv4bLcOfmVeEj/i+JDwLcZ3VglX5fHkEhhL8zR5h86SIPblTvOoDCcFOI+zAMVKrCP5ckB5L2SzTozCq6TYofAzpVLrGK9M/EL6FEE89sUGQIIHSTk1uuGDaBhvV1Z/BfA4utTde/whsVnU8MgtxN334kP0kSXNrC3gBlLF9a3hIOUXbQp1cjrySMoTVtHYQhF0wK54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(8676002)(83380400001)(8936002)(316002)(1076003)(86362001)(36756003)(33656002)(2616005)(26005)(5660300002)(4326008)(186003)(66476007)(6916009)(9786002)(38100700002)(2906002)(426003)(66946007)(9746002)(66556008)(478600001)(54906003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?//S0aLWVWq4l4A+WQzKzmyq81x0F96Q9MxICt/YUHcVJ7zyc1cbemI77vZa9?=
 =?us-ascii?Q?+ZoWYXge4eHcYL2hnIb6Z2dtMih9cEp1R4bbryxH0vN3R2tHEX6xgoucLxJU?=
 =?us-ascii?Q?YPlDvYKkooB6YHFpIiZvApqyFhWeYP5hberJaLhTG+Gx+rppPjgXpubpuj+a?=
 =?us-ascii?Q?5AL+8uQv5gbqpCAkRYEmnmVYb43sKRLlZ+Aiwf0fvBws02L/wwfquxq8EqkI?=
 =?us-ascii?Q?gjJ2p/lZcDuiF1PtgW3TrlybdDqtZAGZ8/j8WxWbIoAml4usW9Lt1Zq0co1p?=
 =?us-ascii?Q?3EHRzrtOfxHR+iP/wfqbuyC0sp0VgXJ2PULsAJZYc+TgwkDfYzK2J2n76ecZ?=
 =?us-ascii?Q?Sn4Z/H6VaARNLBrxyLhCNcJa9boobiVauzu5aPeYR3bLnMchdWBOW7wafSzz?=
 =?us-ascii?Q?wRmJq38JNmp8FcV8vgdKpu7eW/7zWV6UcIzLMmPtSJX6zGr4X0yDE74mXYat?=
 =?us-ascii?Q?HhboXnFoOqWTw0b8Wsoh7OhkVy7hGYmqSW4fffmuzaLLhPBMQygbEgmCKRay?=
 =?us-ascii?Q?OvzEaXKPaELz4ViPcgp8zMbgiPvyGLeAzrHES7O+CTZ2AxVab0/voQyXoqQr?=
 =?us-ascii?Q?sI1cs/taUST0UfV4RviCr90D67GUFGciz8iajh3dldaqwV3s+1cN/mexl3vS?=
 =?us-ascii?Q?j3MHRYWotMONt9BYfdwgFNCEZKp7Y36PCjWh7PsVdyn8r+nK2W6j2EWPe6Fe?=
 =?us-ascii?Q?dqc0OytjNeB1goTwFZlG6/jJzGJ/Qt2Xn2Az1Benv4C8dJevH5AkUs5yDM11?=
 =?us-ascii?Q?mkj4umNcMXRi67VF9i0Pgp45rtvRBQvobI1dHKfn4qzb4uZ1v71MoIPJIGEI?=
 =?us-ascii?Q?LSXPN4Rpb56VNBYmDBrEjLzpltvkCsp92RfnmjCa+W2SklRXXAD4aaEEkjhk?=
 =?us-ascii?Q?SjcqA3f//6gKZ1JFMjZ2hz5+Eod9xeAXB4vwkCbAM3RLaKIS+I0FHBp/8WSy?=
 =?us-ascii?Q?P2uJyUmxKcg4ZrVMaA7BFVMMhUqHs2hrxXGzOx9h3cQQAuOB5i8SWVjqyieo?=
 =?us-ascii?Q?SmvnqNyiAy8QNh+9GBGEfySh3vHF//OHozPJZPbJ9dW9haL3Gu/1PHb1Wg9d?=
 =?us-ascii?Q?/A2El7k2Fl/NlSdlfYNB/iH1Y0oHjTpmsXFre5PFuvY2O4xqBeet+q+kMu5i?=
 =?us-ascii?Q?lhifXLVwY32FFE+inHrc8QMuM6aBIPIF7WS0N6czePVQkNxsnnapK9f+4m+H?=
 =?us-ascii?Q?teu0VPgKacJi8eoNhrHSnapq8fEI/dbMm/edeuj/JkviZaCg0CCdhxqZ9rVO?=
 =?us-ascii?Q?WtpanWbI/wgwjIj37dpq2OHwH+dKER4qF0IiyyFSPIhNqrAqwrOqq/2NTaxz?=
 =?us-ascii?Q?PSF1uZ31Kbq+k2PpZihbtgE8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ea5f66-5a9c-4c3b-5294-08d91f07c098
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 23:00:40.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bi0Fi7o3WVGihj0SwddhIgGw+DUV5MqzG7JP6+u26MQouQdiPifOFF9e2GAp5x9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 23, 2021 at 08:41:25PM -0700, Bart Van Assche wrote:
> On 5/20/21 7:48 AM, Jason Gunthorpe wrote:
> > On Tue, May 11, 2021 at 08:27:50PM -0700, Bart Van Assche wrote:
> >> @@ -107,10 +107,10 @@ struct srp_direct_buf {
> >>   * having the 20-byte structure padded to 24 bytes on 64-bit architectures.
> >>   */
> >>  struct srp_indirect_buf {
> >> -	struct srp_direct_buf	table_desc;
> >> +	struct srp_direct_buf	table_desc __packed;
> >>  	__be32			len;
> >> -	struct srp_direct_buf	desc_list[];
> >> -} __attribute__((packed));
> >> +	struct srp_direct_buf	desc_list[] __packed;
> >> +};
> >>  
> >>  /* Immediate data buffer descriptor as defined in SRP2. */
> >>  struct srp_imm_buf {
> >> @@ -175,13 +175,13 @@ struct srp_login_rsp {
> >>  	u8	opcode;
> >>  	u8	reserved1[3];
> >>  	__be32	req_lim_delta;
> >> -	u64	tag;
> >> +	u64	tag __packed;
> > 
> > What you really want is just something like this:
> > 
> > typedef u64 __attribute__((aligned(4))) compat_u64;
> > 
> > And then use that every place you have the u64 and forget about packed
> > entirely.
> 
> Really? My understanding is that the aligned attribute can be used to
> increase alignment of a structure member but not to decrease it. 

I didn't test it, but that is pre-existing code in Linux.. Maybe it
doesn't work and/or needs packed too

> Additionally, there is a recommendation in
> Documentation/process/coding-style.rst not to introduce new typedefs.

That we tend to selective ignore <shrug>

> > Except for a couple exceptions IBA mads are always aligned to 4 bytes,
> > only the 64 bit quantities are unaligned.
> > 
> > But really this whole thing should be replaced with the IBA_FIELD
> > macros like include/rdma/ibta_vol1_c12.h demos.
> > 
> > Then it would be sparse safe and obviously endian correct as well.
> 
> I prefer a structure over the IBA_FIELD macros so I will change __packed
> into __packed __aligned(4).

IMHO the struct is alot worse due to lack of endian safety and
complexity in establishing the layout.

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8E350107
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhCaNPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 09:15:50 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:63616
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235140AbhCaNP3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 09:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVTlRZkNK8SyV/QWKCmAVy6oIZhcAU3Sk1b3MGAnsXWNvCLGUteGomhtgfjSC7qBcUVISAhN341tRGKHa/or3u5htt7FlHh0mMGmByQ/WpRekxysVXvFd6JwrvZ5Qm1OI8RJaYH0f4ljbNWMQfO//K6LW1f8pDM5B0Dc47JSUz9cwLldgZazJ0FQ65KBmMpV/S9Mkig+QwiVdgDZVuCrFyj3ey2v3OUjoiAste0/tnsaN7wJqNgWkRF/EQrH3TpKMgWybZMPLp3NYVT/wRTVwswREsT1Sn8Mtd0tKtHcZwhLN+PSrFlKfk0LBO4dfg+EUuHxww5j3d2BLQ/B+E6hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f231sXpSZrhf8sNOXnwwdVyrctsNvtJSOPuaffgMKnQ=;
 b=ecjzr5LNMDmhOjRcA7dZe9ACrQPtqecUMkUC2LUIjgoKd2955rlizKfHUNQ3JUvRMBI0WVhM7IX/6EyGqWkPHlAdZMmjgb85qrTd3RGITjdapswa5I/gLXHMYSRuuWr44MrruVZlkUf8KPHH/byqwreZ0gLsbvJxmkYjA18V56dX0Q/lEPzEA1m/B6yRmaFhpB7Ryn+mRggqkf4C0NAZQDPNmxrGDOwfhyhQ0Veq2l5z932fuCtVfYNqXGQdDgurEwb/35zdNxvWFeTpUi4ueEwHIyqAdKkbBRavAZYfaiWEVuILjt4Sd4qxP/JmXoEiIcz0UARFzTgzFXl7lcPq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f231sXpSZrhf8sNOXnwwdVyrctsNvtJSOPuaffgMKnQ=;
 b=J/x/gzkdbaYgRI1244TzRPICqPGLGK/xPVn/gvXqW13E8JHHdfosky6FXeCbf/eGkXtpTsPjoFWeCyVfVazuc8PvsQSg2yUrUL3+8vFEtTSyhNnrJg/2AAfKqDyFj9onAPUFs5mnKfUQQ/1Tuv5j7PIV7bVLKtZPOpups/UnZ4E/wr6KDQLKUX3kq9xG9rOP3NSrmgdBx5rG9C7ufvN2BKKOlpf6S1m8tGtFJ5fXSzfRTmPxwKPyHR9aPKli4bmNCppcuCf+Dvq+YJRSeQ6CsQrtGFqbJ7MmU8IXxxK6Aj8UevdYBUqUrmcx5XhfSJ2tnM//Ey6lpsqkYWLeP4BnIg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2629.namprd12.prod.outlook.com (2603:10b6:a03:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 31 Mar
 2021 13:15:27 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:15:27 +0000
Date:   Wed, 31 Mar 2021 10:15:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331131525.GH1463678@nvidia.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0033.namprd15.prod.outlook.com (2603:10b6:207:17::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 31 Mar 2021 13:15:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRagv-006L1L-Hy; Wed, 31 Mar 2021 10:15:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c94c2d6-c725-4fc8-5849-08d8f4470d4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2629:
X-Microsoft-Antispam-PRVS: <BYAPR12MB262966FEADAD6EA6BAD0E24FC27C9@BYAPR12MB2629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDXR4uSKBh9s24rw1WCizcb7134tR8mUzOlIzh8P2IYyThxaMtdgPThFS2EkFJKBVkFKOGeCXetUQPV1FRaXaWPhDr4WK9BB1DBX4jaFYWwRwSVE1E2PCkXYIjdpUNBlubvs4MXY0w2sFxs3RQycuaz7hHXqIkSx6Ph13cOfbIOIZRNLMHPSpSsSVl3DvRLHMR9KO6+VhY51tCNaNy9RnEUv/0xdtzF4pYaC6ynEeLXxr0yertECwtxMnR9nAR92P8IOXuAbOzbMNpZ75aTMWP/DhTiY9ekNqIfKytS+TedN5A6yyUttf8Dhi6sffdqSaLKQ8PSlYcGzJyWO8hHVmcO+vVZ2krDG/dbJoyBhR+pm/MrYXCXzxdaLlxDO+4nE1dodCCQhZuM+LDC6cTx5Sqo9PfbDJfCzMk0b+L5EPr5utkF4im7P8X7cFI90lfEI7hLurj+uzCYiw/QtfTVp9fAl0V1LkQbjOT/f3qpCrLeITRt9wbrTf774in03+lt8MNHbhAVqZItASiXg25OxmaiDM68RKkVbVFuwa/KIWBJRpql9VFsZiaPMokSrGKJNsSCN3Z0dNWXkPc6UVBniWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(54906003)(2906002)(26005)(38100700001)(5660300002)(1076003)(478600001)(33656002)(86362001)(9746002)(9786002)(316002)(66946007)(6916009)(66556008)(2616005)(66476007)(426003)(36756003)(8936002)(53546011)(4326008)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkVpWFNHVStpYTNVdENJMFhqbW5venc0dWtlQjdBeGJMR3NGRkNHcmpZcWgv?=
 =?utf-8?B?S1dPR0F2bzhQY3ppL1QxeVFDdUIwZnMrcEs2YnpRQ0dhLzFLZVhISWZ3NWE1?=
 =?utf-8?B?MngxLzF4a3FqWlQvQkdKcHg0SjRiS3IrMzQ5ejAzdGtTSllrTW5ZOWNMVElm?=
 =?utf-8?B?bC9JdHpYb2R4RTF1NTRCNnRBMTQyZE9YeUFYOXBTZ2JkbHVVMjhPZFlQMTlG?=
 =?utf-8?B?TDcwRmlwQXFPdzlBY1N0N05jVUlhdVZOTXRKWDFKQmpvRlhEeEE0dDBuaENr?=
 =?utf-8?B?K0lCWkxOdzdpaEFHcDVFY2ZtUGdmSWorcFQ3aFhwbnN5VVZmbTBvTjZML1pq?=
 =?utf-8?B?YmFXTjlUbktpUFIxWWUxYUMrVEhBYlB0VjlzR3cxU2JWM2hET1Fsa0VrQktq?=
 =?utf-8?B?TE9XUE53ZVdTNFAwZzlCaklOdVNwR3VXdExWeHZJb0MwZ1RmZTFpdGlMQndL?=
 =?utf-8?B?clVoNzFodWRGQ0FWZ2hjQmh1SWtQVEdJMElCK0F1aG5nSENmdXhUajZpTm1S?=
 =?utf-8?B?VVMvb05zOGxwNU1EeURZT0I1cmQwOTJTbERtY0tCVzcxMERZT2JLQ0tYLytk?=
 =?utf-8?B?dnZrVlprdmVlT25LSEd0REc4b3BXSGxYRDZybzJ2NjJQZ1FvN0FHWHZCQW1W?=
 =?utf-8?B?eVpaNDF1YWVXMmt5V0M0a3hRU0VqN3BEMnFmYlFVWFN3aWZvUW5nUWdUSUdL?=
 =?utf-8?B?U25oaVkzS2ZEZk1yeWtWSG84V3JZUnJRNVh1WTVNTkl2VUtnRTJMakhQd3Jl?=
 =?utf-8?B?dHJsNlhyYlR1a2l2bG02cE5qbkpBQUk3MVRoYXJvSytSNThZeXlSZnZneTZz?=
 =?utf-8?B?SFArWkJVNkNFblhmakZnUFdNeCszVWNJQ00xakFVMG8zTkdlRG5HYmlCd3hN?=
 =?utf-8?B?cFdjV1o4Z0E4NkpLY0J0N3BhT3NuT1ZZeCtsM09rblcwbE9hZHMxajlLNEty?=
 =?utf-8?B?bHZiWGJoaXhCVEhtOEFWemk2LzFkeXpad0QweGRxeXRNZXJFL0hYRTdwZUVo?=
 =?utf-8?B?S255alN0ZDVXM0VqOUVPY25XTk1JSEN5bG9RUVFvc2JadHVZU2xJTFJiRklE?=
 =?utf-8?B?em1qSTVia042YzlDQlNUY3lma01Ncmsxa3AzYVpnWHE4NnRLYjluSkFIaVp6?=
 =?utf-8?B?WHlhR0N5RnFmY0hqd3BySldYTWRBN05jMmI2dnJMZHBHSzFzTkFOUE14bDh5?=
 =?utf-8?B?cHVxaWdhL216YzVxRnp4NjMzLzlYK3M4cFhJN3ZITTRhRUVtTm5ZWkhOMEFF?=
 =?utf-8?B?MmtWSjV4MjZsc09BOHJlT0VFMThyeWRiQUVDVTVHUE8vbHJQdzJHK0ZmYkNa?=
 =?utf-8?B?eklGNnk0Zy9hUmI2THZTNnNGOTdmbUFnVXRyMVMrYWZkNGlCd2c3Ny8vTFU1?=
 =?utf-8?B?S0piZGc2SSszWVJlN3FXc1ZlaWluWDdNcVh3NUY4aWZ6YXZPZkhNbWFTNE54?=
 =?utf-8?B?N2p2aGExZmVDYnYrTTVmZDRoOUdhTVF0V1ZUMm1ZTUtUOFF1RnVrWXRwMkk0?=
 =?utf-8?B?VjNRYm40TktmTnFNMWo0ZXZoNVI0eWltb0ppWGpCMW5qakhZci9Ob0h1RnRT?=
 =?utf-8?B?RmJoQkkyKzR1K3NNZVdLYVkyS0cvSXBXWE53NVkxVWtwdVJkUFhWVElJQlYw?=
 =?utf-8?B?ZlhqWlYrTW5ESGk3bTR0aUNzNlQyZkJjc0NkL1NuaTdSZ2x4TjFZLzBrSm5m?=
 =?utf-8?B?Wll2WG1Ca3VLN2w0b2h3QW9wUDNEY0Z2Z3p6TFEwSG0wdWw4M2pRK0hSMVRh?=
 =?utf-8?B?NElzSmdpZ2czMHBJOWlvYUE3cDF0aGtkVExRcnlCYSt0N3MwZTFSeXVGbHhu?=
 =?utf-8?B?Y1V5YnNrYlZrWkNmZ1J3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c94c2d6-c725-4fc8-5849-08d8f4470d4d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 13:15:27.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jBnDNCTlJ3EPbKoIWWvPZu2pW0mM5I8yK/S/s2E7FLOUJcGmjgrNcVrJOlszWgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2629
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 12:58:41PM +0000, Haakon Bugge wrote:
> 
> 
> > On 31 Mar 2021, at 14:00, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Wed, Mar 31, 2021 at 10:38:02AM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 31 Mar 2021, at 01:12, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Thu, Mar 25, 2021 at 02:05:47PM +0100, Håkon Bugge wrote:
> >>>> Introduce the ability for both user-space and kernel ULPs to adjust
> >>>> the minimum RNR Retry timer. The INIT -> RTR transition executed by
> >>>> RDMA CM will be used for this adjustment. This avoids an additional
> >>>> ib_modify_qp() call.
> >>> 
> >>> Can't userspace override the ibv_modify_qp() call the librdmacm wants
> >>> to make to do this?
> >> 
> >> Not sure I understand. The point is, that user-land which intends to
> >> set said timer, can do so without an additional ibv_modify_qp()
> >> call. May be I should have added:
> > 
> > IIRC in userspace the application has the option to call
> > ibv_modify_qp() so it can just change it before it makes the call?
> 
> User-space can call ibv_modify_qp, but that call is inherently
> expensive on some HCA implementations running virtualized.

you are not following.

In rdmacm userspace *always* calls the ibv_modify_qp

rdmacm has a 'helper' mode where it hides the call inside its logic in
librdmacm.

But, IIRC, a ULP can get some event and do the ibv_modify_qp in its
logic instead of using the hidden version inside rdma cm. Though that
may only be possible if you eliminate the entire librdmacm hidden logic

It just seems wrong to send data to the kernel just to have the kernel
copy that same data out to another system call and never use it at
all.

Actually I bet you could do this same thing entirely in userspace by
adjusting rdma_init_qp_attr() to copy the data that would be stored in
the cm_id.. ??

Jason

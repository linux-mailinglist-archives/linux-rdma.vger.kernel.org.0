Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223743C196C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGHSzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 14:55:04 -0400
Received: from mail-bn1nam07on2060.outbound.protection.outlook.com ([40.107.212.60]:62343
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhGHSzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Jul 2021 14:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAACyLILernbdygWjQxpnLdGlQsTY7JUKPBu+2pqVPR2NXKIUYu8IyO2RBtQ7ZPt79mFMT6l5ztlkN5GqRcdDvlAmHgcVXHgrxtr4ciJ7Df5eJl2A7e1QBM4nFy7+DQKvi7v/is97CPv6QqqojigHZ05pGKKRzSZLsorEbPIiKgV5vYX5XBTZmhBLMEuqjrTJuEqnqPnO9GaubEwO20g9zywoPe0oCiCV9fnFA4iDeGHsQGXH41ZQfxdIJxzvrSQPexKdnXeScdSdcg9J2f0mY7tG7qkmdtwnwsT7BBMDwzqQH8QT21NQFbr4YwGn7rEtLaN/YNEuYhPUyazvocCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRJXfo59OswHVfTTR9U7I01FAR5zpKLR3LbZ+KqGCSs=;
 b=MxTk8LTxJWqII4qVKim+CVRzqmjbkjClVChq6hNUxj8dGE5arq/3fstl/iIkaSNKJ+dvNw/P6govv2K5h3nMoqyZpdH7kQnv85c45ucgP+acb9KOzZ7LUYY9VNVOMwzVGlAYcZTr3rn7Fq0zYPy5VWEQGjCmgNCDuWw7xAc/povbb7m0hfWpyS6AGG998DhRR9nqSQfVoKIX2ardKUlObjRaHpzue/tOoZ0DzPnjAyIdIDPzJhg4e2cnPlH2dmbxARzdWKhezAjXdDPwoSVlcMzMQ/zPY85q12ob+hDZNYHARTJv2ROD1IAgCr6Rp5BHjPh8nk6aFNZKBjyznC7WVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRJXfo59OswHVfTTR9U7I01FAR5zpKLR3LbZ+KqGCSs=;
 b=K/1vRctrPBDYpmHIg2/WjOLCR721EiWQuF/j8KZ0CGygCV4vifc06Qyh3q4LeJOLLU0+IRMqHr5vsCiPhhk5kzNwfWdOjbo7+jmX7xjCfGw4dkeap2TmDVG9U8aoSioEaGiuCCgHfpBAs5ZgRGthCpXoo2f4xhaMplasq2XJPOeYXi22FjZxD6HNLge2nVTubg0GyfeRbTpXG/wHjW4mUUPUqzT4Qq5S62+CQI4uiSQjsUauFcwWLnF4e4H0HmDz8oBXGzFLcXh7g7/BTuY79kKsUcltJ8DKm/3gaSlSso8dcGPjInpQv8FbHIfxs3vDhGvq/pkH0roVs/Bmdsjg8w==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Thu, 8 Jul
 2021 18:52:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 18:52:21 +0000
Date:   Thu, 8 Jul 2021 15:52:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Message-ID: <20210708185219.GA1541340@nvidia.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
 <20210705162628.GT4459@nvidia.com>
 <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
 <106645E4-DF2C-4DCB-A82F-ADECEBD242CA@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106645E4-DF2C-4DCB-A82F-ADECEBD242CA@oracle.com>
X-ClientProxiedBy: BL1PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:256::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Thu, 8 Jul 2021 18:52:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m1Z8F-006dta-UB; Thu, 08 Jul 2021 15:52:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b665d0-b9f0-4d9d-d393-08d94241842c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52071A4713410E94A52235ECC2199@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdLP8SnEZxUSHB2C0vV+3p1th6k8V/6+b9GGndIrTOVjYUALtDs0v5EWsDZL3UhNlFg0Yy57J4unQD5ns9rCDdrIOCxABZtSeQS7pqAr04Y0v2Cg7/yWDxT3TwuZj5NXCnmGTwdPFdKuRzxY21KYFrFdWSLHBVVohFwogZSaNKb6rIvB4SZ+vnUElBX5NheTzQQmVs5EgAjjExUcHrkg+atvVe8tWXdkLNvwPkzIZPG6imaB0qV7z+qLTmBU2HTvZti5uHl/OIG1S3fhnPI1GGsLC9+hb6Vv0nb9YIuAS33E1zW7iO9I0ESSQlb2IgsoLy7k5dz1sjYo0dfZy1s2w2UW2jCX5gbMnNuFRAmMsM7Ly9TUkakWL87Dxu3UONLDtAM8jEDt0UqlaDglpCVRuwWJadTTo6qwO6HfbKV2iUYQHt38LL+UJ9tInygARdlcAh0kM0w18l5pkMgJzBEpySkz0pExZB+EEEhDAJVOZ0t/Ia/QX/p3d0+6HLQq/oUh1vdibIC08qUjZ85koQb77csWvzf7Ep6LfMayPctvoYNdTnVuO5w28uLdtdthKOyQ9w03N8Ygowzt54hhnWxq/cjMLvLFpsa0HeNTDxkhqXqeE1/hTXcgDS0keDfG6EpYJApdiXvev9hn3JgyrXyKHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(6916009)(33656002)(8676002)(38100700002)(1076003)(5660300002)(426003)(66556008)(66946007)(2616005)(66476007)(53546011)(9746002)(9786002)(186003)(86362001)(26005)(316002)(83380400001)(54906003)(15650500001)(2906002)(4326008)(8936002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKyNvZ4pgape4zEltcUTnyr/vUPq8/EWym1jlSqweo2C2FN9Ny6ietgs0ubK?=
 =?us-ascii?Q?8WSAoxZzGpqbQSBZiGBdHhVrBzXzyNl/Wir7GS4xx7kysh7epXjR3MNicSxi?=
 =?us-ascii?Q?H+au8SC4QRGtqvG5M4lggQQRkK8o31soOJV1phr1k+AFBO/ohOkn0kzm+SzF?=
 =?us-ascii?Q?0HFmGtfI8heaymkMbkJ1d6M3HEMnjZ2W3I7SefiXKz/Zs1IWacN2+LsQdzrB?=
 =?us-ascii?Q?LMVkRRxM801sZRydTaGLvqI9/NLONKqEpqToJEinXOS7f3kIVJd4gdNIrZJP?=
 =?us-ascii?Q?eBo/n9c6qxgjJR9foUMm+ZOPuQFVQ7qWrKRFQJvq+r0PVVoe+K0EzMQxMPTw?=
 =?us-ascii?Q?Ui21QI6Ia3RMRuQsbVhW9KXlMrPSRRX2AnMwfjHyQTChoF7xoU3SU892SNs6?=
 =?us-ascii?Q?f/fQnjQcCHvDd4/srNK9pSca+qb80M1yW9r0FVmu0jzYevuFI6hssXRTaHT5?=
 =?us-ascii?Q?sqgmHCHV7L2xvmcKRP043wd1qbicvpawHyYiPGcQP0+Tkq1EC7+gnd/gOV06?=
 =?us-ascii?Q?3Bvgr1Sh6O0h0oAblhBOX1rpB1FDlG4JvpPcke263ugMV98XzQqNWlArZjAs?=
 =?us-ascii?Q?IFiehNH8Y05CdYrOX5eKYWYI6pmnVACjOe3FX/IMtKqnO4ZruOFoJ9BmckxY?=
 =?us-ascii?Q?VY/tkm8Pucs+N8cF7Fkp4AVctOYXlcdQfS+H3ZJ4izC6mz6mxeZc7XoNImQK?=
 =?us-ascii?Q?3rBL+Ue8eBrD3xujLBhzEWfVwNPRMD0Xs6wSFgCQAoe8m+gTzytXgTNK7kOi?=
 =?us-ascii?Q?tLa7IvDmNhnN+R90tOucetS2CLIFHEhK2Ce53YAkFNoN8vQYNwzJCHLE/rEo?=
 =?us-ascii?Q?6PSjSfyUruWHTEdaLebL1EwmM6fk5uMUfnqRDXUoD5EVxEeirTJb4ndukhXv?=
 =?us-ascii?Q?dEWG2sXEDA3xPoZ3QgL1qgHbPVmZzA/mPknIdJR0eHFtLA22BjjHUUEwRBcl?=
 =?us-ascii?Q?xSfiIFynuD45kCGoeXIFnCge2BRmfqFSgKpknyOy4Nzd/pOoELatw2pKJvjA?=
 =?us-ascii?Q?g8pGi9Y+8gtwDHSWiNn4GhQS+FTNJ0kHCFioHc7vTNvl6JL1Stc7JJynVUgj?=
 =?us-ascii?Q?nK1dsuaMNT1mVQxuVFnntnTiVQbavG6CfijHmiNnKT132KZkUlKlG2Nipjlq?=
 =?us-ascii?Q?GycEyzJrbuwrXuImNppvylq1n9j6qZuc4djy0YXkOis/ycHZJWVeN6zBrMMd?=
 =?us-ascii?Q?7AwvArJARGI8ZUqEdwxInPiqkhOoarbU23JBK70PcJkLOemOKsjkIUQEnQB/?=
 =?us-ascii?Q?mnGz5qvq9uZRgtZ7c8e/im6CGB+mreFtHqkpymRfc5pyZg090qygjCRnEFMJ?=
 =?us-ascii?Q?NxvJaBANsvivgM8qfNjz+Do0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b665d0-b9f0-4d9d-d393-08d94241842c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 18:52:21.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au6eAPpM9mlqbn51J+VV3laD0HvqOmoDK58/9Hup+sT8R6XzOn1G8/d+Vl6kJO5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 08, 2021 at 03:59:25PM +0000, Haakon Bugge wrote:
> 
> 
> > On 5 Jul 2021, at 18:59, Haakon Bugge <haakon.bugge@oracle.com> wrote:
> > 
> > 
> > 
> >> On 5 Jul 2021, at 18:26, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >> 
> >> On Tue, Jun 29, 2021 at 01:45:35PM +0000, Haakon Bugge wrote:
> >> 
> >>>>>> IMHO it is a bug on the sender side to send GMPs to use a pkey that
> >>>>>> doesn't exactly match the data path pkey.
> >>>>> 
> >>>>> The active connector calls ib_addr_get_pkey(). This function
> >>>>> extracts the pkey from byte 8/9 in the device's bcast
> >>>>> address. However, RFC 4391 explicitly states:
> >>>> 
> >>>> pkeys in CM come only from path records that the SM returns, the above
> >>>> should only be used to feed into a path record query which could then
> >>>> return back a limited pkey.
> >>>> 
> >>>> Everything thereafter should use the SM's version of the pkey.
> >>> 
> >>> Revisiting this. I think I mis-interpreted the scenario that led to
> >>> the P_Key mismatch messages.
> >>> 
> >>> The CM retrieves the pkey_index that matched the P_Key in the BTH
> >>> (cm_get_bth_pkey()) and thereafter calls ib_get_cached_pkey() to get
> >>> the P_Key value of the particular pkey_index.
> >>> 
> >>> Assume a full-member sends a REQ. In that case, both P_Keys (BTH and
> >>> primary path_rec) are full. Further, assume the recipient is only a
> >>> limited member. Since full and limited members of the same partition
> >>> are eligible to communicate, the P_Key retrieved by
> >>> cm_get_bth_pkey() will be the limited one.
> >> 
> >> It is incorrect for the issuer of the REQ to put a full pkey in the
> >> REQ message when the target is a limited member.
> > 
> > Sorry, I mis-interpreted the spec. I though the PKey in the Path record should be that of the initiator, not the target's. OK. Will come up with a fix.
> 
> On the systems I have access to (running Oracle flavour OpenSM in
> our NM2 switches), the behaviour is exactly the opposite of what you
> say.

Check with saquery what is happening, if you request a reversible path
from the CM target (limited pkey) to the CM client (full) you should
get the limited pkey or the SM is broken.

If the SM is working then probably something in the stack is using a
reversed src/dest when doing the PR query.

It is not intuitive but the PR query should have SGID as the CM Target
even though it is running on the CM Client.

This is because the REQ is supposed to contain a path that is relative
to the target.

Everything will be the same except for this small detail about
full/limited pkeys.

The client can figure out what to do with its own pkey table locally.

> "the P_Key table entry (0x1234) matching incoming BTH.P_Key differs from primary path P_Key (0x9234)"

"The REQ contains a PKey (0x1234) that is not found in this device's
PKey table. Using alternative limited Pkey (0x9234) instead. This is a
client bug"
 
Jason

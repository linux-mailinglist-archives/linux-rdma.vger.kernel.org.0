Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C880493A83
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 13:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiASMhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 07:37:07 -0500
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:17441
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354525AbiASMgi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 07:36:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1uG3uDnsbBSWMBsDE079qK3J7aTaTy+QxLOHloyhGDSea0LNipy8n7PPbsbGm+TI2N0E4T3/upXbfmW9j/XrepzPzBxmigUq1XscFCkmHhRm0Aim2LtGCqrcq6EY6YCG6X3q/E0OHdD3h9schpc+cpTcKSfOovIgo+E4BFX3/Nw0Jq1SS6u14r9Je58r+WnTZSRj01GRd6Od86ConIs7Nyd/5gpQLCaNf9khL8S6mgc8ol4zkjblLcYyMXSrEAsV92IjBrJmHXAkEoN+1LvMMXW14XfIkumA1nKMsjVei6xyR5NNmLjL6nwm5vz0spVHqBFIEZbUvdez2qYLgZftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBX0vWQekoHeqU3QgGAlQAbqeYpO45J9N9Uza8O41uk=;
 b=SBjT48bCqr1IXt2eMQIsBkzZPu76eOtidDwSHApcoGldw1v+MlXjG6yVUhkjLt/vyf7yYa9u/bqJbcLupS6xpqnU+I1WyHoRoQvZsAMVELrUG8/1MxH9q9ixflvyN8W6SIeUnja80udq96KzdYym3Sl1qybnrejOtZ/pIC1Hkkkuc8BaE3EEkXE9C2GjW8lUwD+NCMWHyQpaNy0aSi1x8+y27kUlCn0WRx7ykmhnx/YWUSFde9RI4r8GQAEyvUWCykQW/xuLmbvQIQf0bhWeTjqMEigfYwyWyBAY35RcPTrF7ZHcr0s62V0ih5+hCsQaHqWR5rKUEXf446T1XIzuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBX0vWQekoHeqU3QgGAlQAbqeYpO45J9N9Uza8O41uk=;
 b=nEjB9XOoB0TmGt57Ph7bGlCMW+1kHKDvqz45s94KC9wZzY9Nf7+DMLF+aWkZs1UNGbA22kFBbTu0qHrSgDB6SWCU3yyqlC94Vcdw6BNUWQMSPuZZThp1+Dd9dhdJ16mXIE6/eDB6pYQxR/OsYrAsII4Q2Lx03p6SF8y8wXtiq/cvSYrnUCuNf5OU9Prq+loSpMBdwRS+QgqsAlwITeko7LntBawLyDYMatKZEOwDxzFWaHOANw1Bd3FGOd3gSgQy4Wk0SwB75csc6CjbXVZk8Ps/T/QFmmFGwDI+EFPRJWF7zDeK441Iuh86JwoqagDxZ5SPR6mZcZ7LzbR12hjfoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 12:36:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 12:36:36 +0000
Date:   Wed, 19 Jan 2022 08:36:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220119123635.GH84788@nvidia.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
X-ClientProxiedBy: BL0PR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:207:3d::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b7a4da-c7eb-4661-e8fe-08d9db485562
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340D8DCC8CCEA05757B48C0C2599@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pH6NS6t7hR8u3ZIYHEeIHuQcmP9jAwoFHrNPkd9GlZ1NDsczz/qYrCooCMnKzyVHW0lNHqF/ZfzF9bU0Xx0FDb/dOrIpwajZQa93DNwXtRX6KTdd0EJ6GPBIuo4bKtCsdgerlek+OshzY3japagvMkWvGMmtj26A99QO4bzx18ALdMaY+qBTkKVvreboRHd7t+OMdVREbiRMDfQO3/oev4Bd11S35kCbGA6bzi/BvaMEe1xq/lkNkvp1NeY++Q7iYQ3PKmCakc9MYNA3y9GTPkZtus/gv50PHwh64yW3NcppNVsIOzWyC+KIJHDEe0jXdT4vI/zaRF8xvj2dEG6D4wVYYO+mqk8GdDeivalu2y0N2C9+MrUBpg1eNZwyJhYGm5tPFTH9pxC269Z1vbY6Gm+bCf5yM3wefr8yckRC28HsRQHX5jSl9cYhYPJgsFtgu9JSTZDx+le5U+w9BVe/RNKbqnhdcNEEtkSDipg5Eap+Z509Fhr4GYN20wgOF2HeHDGVeXeMlqQDSGaKqE0GCAmp8DcA8/zbNiFJUeIFbDtbnAAJS0tKJxyGKa30O9om8BQEwRw5g5EO64yUBPzVbaBqE/8AYalvrkxwRuyt1wkPQUPqlgiUVfax4AtYMAih2sTW7VgIIL1wY/+jiu/tlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(2616005)(66946007)(8936002)(508600001)(8676002)(6916009)(1076003)(36756003)(66556008)(66476007)(33656002)(6506007)(53546011)(54906003)(6486002)(5660300002)(38100700002)(26005)(316002)(6512007)(186003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DndMa8fZyvJrFUXBszfuK4nrXQxIIXxQaLR/iCwjJjZ8hzQ8o796E5YDRvV9?=
 =?us-ascii?Q?fptraHPOUlFhSwtwLoeOzTYSZFet28QvasssHbH75kGdZxEKmeOdWjcCJ+Gq?=
 =?us-ascii?Q?+BHED3qImzWtowKJTljUFtlQH47/morKS+Rt4IQkp4/tTj272cceLPZqXCNu?=
 =?us-ascii?Q?BFs5pmoEKYw/yLsZgArP6hUJZLCqUwtuPOdApC6xM7PkqUVuG7tOE3DmTYK3?=
 =?us-ascii?Q?LwB84Qq4QQ24WztGR9IiRY6DnQiy7EaHD5SNi8fV0XMTShTNzwPq6GIhlipI?=
 =?us-ascii?Q?Sc/cIi0BDvvTk7B44c9QClzS65fx1W20qyv4lG4IYyvWrilfLls2Gs30kFzQ?=
 =?us-ascii?Q?JgDclRpnsMdAYiNoxINn607Hu5No1kNPTESozFLWSCVaNDhr1Rn1xdK6xt4D?=
 =?us-ascii?Q?I6YUnNHBnV7MudxtM9WWpTnMi+TO2UfcjO7ZUhbR2UH7g5eHnTA/oYOlYOOR?=
 =?us-ascii?Q?62GkfBwDTfpPiFwBhZvD6ZDWGMkayyMACHPx7dM93fGW2sWqM1CCJ14jafku?=
 =?us-ascii?Q?38/yoQ4380pqcIVrZybhA0csMcguvVGRI1GIn8C4zFtK1HjibNnFlewGIGTK?=
 =?us-ascii?Q?+MFZ/HYuMYVYBIUjS7els1fQXNzZ3cSU8pW+eQQqIS5rrKzEUd2j6R+ZorEf?=
 =?us-ascii?Q?bdhNMVfjyPjiZtIYwF29J+QbWj7qCQpOUuR2aYHFEpP0HGIFwh+2+TC+6MrG?=
 =?us-ascii?Q?1C3j6FtWeQJiUr3B9BPwinu1RP28zI/uQ5Esaed5JIMZIn1dT3U7LnMCQSSE?=
 =?us-ascii?Q?4SW8US26k+fHUQ86hgk7IKH4f3nYDfvF3w89XfAG3z/8tNUdk26N6w1vlWNr?=
 =?us-ascii?Q?m6UjsscPIRfSWPb16fs2faAkrsBUTjVn3NcoW3Nth9on/aO+0JGB4kQW3dPC?=
 =?us-ascii?Q?cI/j17wLOmf4HmoHKC+eUslMD4Y/PZ7opDD7bL30HK+3/DK2ENT/icixZSR1?=
 =?us-ascii?Q?DTncnGGT04UjWZ+KZNm39OV1/uiuuhQtmPkE/oAI4BCiXVJ3hU1K40SIYbxE?=
 =?us-ascii?Q?Z9yFy8HjWKm3sDkEe//DXd6woGKIYw49zRkMGI4ardAU+oxgbLKEwPay5MVe?=
 =?us-ascii?Q?Dw7ioqP9Gx74fyUHsZbKvpWjq73OQnJm20Gz1wlleiYNkrtxpfvvMSPII9vo?=
 =?us-ascii?Q?BXU7kxPV4gn4U+KZdBMfh4s1lweURhT6aRZcGJMFj+f+CoNxxUdtN9XZfpRn?=
 =?us-ascii?Q?MCVs/LoVfN0FWelbhnGuubTfh1VcvsNSOH4HdenFIOJBUE5dOIouPeDPBh7P?=
 =?us-ascii?Q?jXDrZXrTMgMP0H5/FfAKO0VB/MDHG3Qze9W0sp0vcnaFO0ydv2GeGu/DTvZV?=
 =?us-ascii?Q?KuSJkRG1Grkj3EuOtmla2C1GFZgXbTDsNmwBFo9SRoNSLoMexGQuMvaNNlTg?=
 =?us-ascii?Q?6qR/MhXpFkq05l0K6m7kTBjhlkV4odQNsVNOY2gVMniDkYambF83kJN9mVtr?=
 =?us-ascii?Q?ZRhLdnoh+tHh4blL7xpF0rcBUQ6vE7xOJiEMBvgudqk3LfsyfyqxpyT1l9fH?=
 =?us-ascii?Q?T5BU1UnLUU7IvWu5F3RCDkv+WUzQiugfD4CmjqhPWNP26YgyTWXVZ3KPUbVx?=
 =?us-ascii?Q?gIeuN6h5vl89k9s6PeI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b7a4da-c7eb-4661-e8fe-08d9db485562
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 12:36:36.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3JulHK/99aC0lUhI1Xo61NxlkEecpSyzh8qv8Z2xsjHZdWuIuTWxRHEZysC5uHR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 01:54:32AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 18/01/2022 20:35, Jason Gunthorpe wrote:
> > On Tue, Jan 18, 2022 at 08:01:59AM +0000, yangx.jy@fujitsu.com wrote:
> >> On 2022/1/17 21:16, Jason Gunthorpe wrote:
> >>> On Thu, Jan 13, 2022 at 11:03:50AM +0800, Xiao Yang wrote:
> >>>> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
> >>>> +					     struct rxe_pkt_info *pkt)
> >>>> +{
> >>>> +	struct rxe_mr *mr = qp->resp.mr;
> >>>> +
> >>>> +	u64 *src = payload_addr(pkt);
> >>>> +
> >>>> +	u64 *dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
> >>>> +	if (!dst || (uintptr_t)dst&  7)
> >>>> +		return RESPST_ERR_MISALIGNED_ATOMIC;
> >>> It looks to me like iova_to_vaddr is completely broken, where is the
> >>> kmap on that flow?
> >> Hi Jason,
> >>
> >> I think rxe_mr_init_user() maps the user addr space to the kernel addr
> >> space during memory region registration, the mapping records are saved
> >> into mr->cur_map_set->map[x].
> > There is no way to touch user memory from the CPU in the kernel
> That's absolutely right, but I don't think it references that user memory directly.
> 
> > without calling one of the kmap's, so I don't know what this thinks it
> > is doing.
> >
> > Jason
> 
> IMHO, for the rxe, rxe_mr_init_user() will call get_user_page() to pin iova first, and then
> the page address will be recorded into mr->cur_map_set->map[x]. So that when we want
> to reference iova's kernel address, we can call iova_to_vaddr() where it will retrieve its kernel
> address by travel the mr->cur_map_set->map[x].

That flow needs a kmap

> Do you mean we should retrieve iova's page first, and the reference the kernel address by
> kmap(), sorry for my stupid question ?

Going from struct page to something the kernel can can touch requires
kmap

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A03F235B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhHSWos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 18:44:48 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:16887
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233391AbhHSWor (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 18:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPTFjKn6FK4CKNK7DmauV2f5b4uYUM2gtF2/T5UVPjPVR+c9RpXHaMJ2G/irqh81nFzKm7b7tieqFojwUWfciiEEwjHfIaFrp/DoFQNKFKnTNkn2bvSStND/vJJvEFgKSSJSSJEJJftwULQHuYm3xMt8oB81QVWAq47EbtyGjLXgrCYDYLFyo3BV82dStctZ1hAuhBZivUYLS8eA359L9pWfswS00fOTONGYoP/7KYAA7Utiud76kCU8GXivkB+68AwxS5aFYLH74ZCT5ihG9ODRyO0cygTFqF/pYA15JfLMs7WHVZE/6+Ewr2be+WwzsAXBEkDrU7xAVrx42GguRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcpoL06H6kfOWgDhwbULZ2aqdqzKQX2gfHw5DlL1mxY=;
 b=jfPrcT68mYxVVh7zqOaiLQ4DNdEp2ReyMDrD87bLh9JO6zT9anfHDJUf+89A1nAwQx5iCjdsCFO+zgXSj1/kWdd7t+2B2BJEn+HAQ9lhKwNTBZebWezyEdIWBdknK1FrUltUBI+7OPhLGxkHih+i8SV//1he1RHRUxV3/2HKYAzY+wtbC7eEW4gGg2SfzOqzIVuEWPM1WC26lTrrNJWgExva2V3VR6cJC+ExhqVTZ26ZUjfFhkEnn56NxLHJw77MxKLhMigjEZJaSwcY1jGZAGPIWgt/WLO+ww7AJuRxQH6I8WOSMUaYoa+XYpEQWBEnT08/r55dVOMNMsTjZIYOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcpoL06H6kfOWgDhwbULZ2aqdqzKQX2gfHw5DlL1mxY=;
 b=tAvegMpGe10x64A75329PrHa6FuvTnNKOHGSHDvKLO87JhKqwgL/S7lCglhJDTPeLcvFj5s3bG2KClF0lEajOBMIPiIToYrUlWzQLq9vP/jr4JFG2h7oe/QqYQ2GQtIaRD8ztdrGOJRLIK8d3OgGdo/cfEtFkMgJhhJVl1XkpN7ujmmlp4KTVJYASX6KrFL7/LpsywZKO/hm3OvX6fqoYX2th2Ek6MrsMrlmUxJb6Xj+a/n3i8VEdwyH9cc6mJzhMoe0EGW4Sj/dYVU66jUoc3f7Mgkn3seniWzV+VuLFIlxkjVgTrjEiY+Lacc7x8r6RoMmwPtu7xZ9TIVgZzxPGA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 22:44:09 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 22:44:09 +0000
Date:   Thu, 19 Aug 2021 19:44:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Message-ID: <20210819224408.GE1721383@nvidia.com>
References: <20210810115933.GB5158@nvidia.com>
 <20210813222549.739-1-tatyana.e.nikolova@intel.com>
 <20210818164931.GC5673@nvidia.com>
 <DM6PR11MB4692DCA80480234AAD298313CBC09@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692DCA80480234AAD298313CBC09@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:208:a8::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:208:a8::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 22:44:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGqlc-001d2U-EJ; Thu, 19 Aug 2021 19:44:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd4af41-f536-403a-4c8b-08d96362dba0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-Microsoft-Antispam-PRVS: <BL1PR12MB502943A1F5C7CB93D5664CF6C2C09@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llJJWDaTx8i+5tt5Nf0BM+4exJ56AhQhT2CwMb9bzLMKbZf6e2z6PDwJtF6nl5LvYvjUZ3keklS6nfw82kkKoriOugHDsAPRWNyZth7vluWJpNyqa0+EccA7DxZ8UJyGG9nkeA3jO7bwM2uW8UR+lK/s6B6CYs0CxbhvB0UKfEEG8FuX7W26A39+MYY6WZNASUy/SWxqVtpHwFiR+Jb7KsW8tqLTevkWAmfuJiJurH9vJDdp050TW87apj4K+DiD8NE/tRKFLSLgsOru2XDO2O220bL4lEgD+1vJLrxtRfzakhLwaHcflDR3heIyOXxvc5ztnk33QSK37OIx8FbMKDqjOSVdXoUkMPcb9sUoMr/MMZr+6uhHevjFC1KSy9xmeHrjx8nrYqBTqy6Uw39n+J8tOkrmi83bOwNDOkfFXia1ulenq8tZT+0/lfZuQRtGHpq0AAhdlQ8ZCaxGv+LKDAvrjlCxZW/0LIkwuUSucMFvV41O1roTw/IhnQyxVY/yMhEUYrCl61VltmYUlS5z41xiWb3qBjD1gS2cuNYIlpTWogMPSnn74m2r2WkzlQVw4OpEzQntsGboGZrkmrHrhEGZRMUseS/eiQtAEOksqJm1cyIW+0BV4rKT7vvqdoVnST8wWMdmGiKkVBiug/2mLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(54906003)(1076003)(66476007)(83380400001)(316002)(4326008)(9746002)(33656002)(26005)(9786002)(8676002)(2616005)(36756003)(86362001)(6916009)(8936002)(2906002)(66556008)(508600001)(66946007)(186003)(38100700002)(426003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocF6ZQ8se1JqjtJBlZwO+xjMreRpJwWWFl1N6emCI1ANtHXVdGYqTmTvw2iB?=
 =?us-ascii?Q?rMinwPoUPObVPl8ch/a5Ak5YaJkcgKBkhjS31JIn0NaGI/xBsG9fd+bKpbIe?=
 =?us-ascii?Q?O4z7cNlW/seJow5Gf+COUK5ZxpTWKGknkNTOj07OmwfRkv7cvWYiFXOFnTUo?=
 =?us-ascii?Q?gHp6o7FZSlnr3VHo8CkuFkIDfFCEGvhIPe+7u2+V3uy6q89wc/c6Nc69ECYc?=
 =?us-ascii?Q?NtIwUZfDyYjf9bV5njRiNrgvXpvG4OVPnBwe3lIvXYl83qyTPu3ofXOnhkT3?=
 =?us-ascii?Q?umbvxtj94imP9WuwB5PI2HD5Os64bJqxnJ6mjSj04dYfTJMTcgyqbVPjYd0o?=
 =?us-ascii?Q?h/RYkaObxTpTVQ1mHWepi1vB9FiPUzdrseYgo/kD21URpHXNIb7Cy+LTiwqX?=
 =?us-ascii?Q?ByYJv934EEx3KISQPzAz+AgVNXsNPJQbuedDKn+QfdCWMw4cwd5nMhQRvgIG?=
 =?us-ascii?Q?dDyfnBNrpO9ywLyUdUBfkkJfU3DeQYoRCYer/0zYalE/VQzt2lFYkiI8D6+k?=
 =?us-ascii?Q?ksrjF9nekJKVZdjqYtPD1Q/RHcCrNXrbAgYnEcErcP5D40di3m3l+CIGPw6M?=
 =?us-ascii?Q?MdqR7BiAJMqrexB9CDglY+H1uVnWZ6pkeqmXtk0BdotOX52KT54qzT0DpIva?=
 =?us-ascii?Q?2pLeDfDlGN73PJQZR2jjOSmIPZ6C/eif8y+EaghTpD/9+CedWntGAe7UOrZb?=
 =?us-ascii?Q?lpk2Zrjif2lhKPN0RHof9sn03GLpqgV5lV9rcF/eYQUMtSzA0edqm1EQ4YHt?=
 =?us-ascii?Q?t9bdj3j4sBceLub61L7KwzC8H5+03TYgBpXCHVjmZjvVLKVfmXSt70QQag9G?=
 =?us-ascii?Q?WO/WLjwsITWdo4czBFxE/C9I625kfleJ9k0kuL3qiOoN5mDRAkJvRmw1QsXl?=
 =?us-ascii?Q?GxibqAdfbCLQf+JvAiIk1J3NNrAVgTtM+XzuCSVQyfFAZGbdiI6KnIraLICQ?=
 =?us-ascii?Q?74vKD8f3Xv70fNB/kbn7dKm+7F4idLYQYmH8jjv4PRp+L4FoJTij5ed1a9nX?=
 =?us-ascii?Q?epj0m+EdqYNX3BDG+aVYSDRq5nfe/Z4iVAUzcMqfExCBMsMcd6wVEaHIeV8g?=
 =?us-ascii?Q?ki9QMa6/GRWJTB6YJ2o71jVbsO245OdeoW0x7Vh1xFLvZZLYUA8zgoeKetuY?=
 =?us-ascii?Q?D9MEkHtgd+F50YxIVqxTjAclHctPaZiEcf+iSapay9CR4R9VLM+guRODiSFD?=
 =?us-ascii?Q?P6AzbOyeW6FfjZyLdMhQrTAq8MbdSmdkwmaanx5BqWwSjgo4VgzXQAQUxwte?=
 =?us-ascii?Q?AN9wgRlcsZ2a1ooF3CJWDffjPZbMbVDa+FLP5npNgIaBwE4R4YxreYqhxysY?=
 =?us-ascii?Q?rW1I7R1dIrsRCUvQfOP7pjxo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd4af41-f536-403a-4c8b-08d96362dba0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 22:44:09.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUgCeA4JQmIQeiiCww+RZ02IrwD/NUP84hgJYhs8xo/Msd1JXkBCEUjadA5tVRoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 10:01:50PM +0000, Nikolova, Tatyana E wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, August 18, 2021 11:50 AM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
> > doorbell optimization
> > 
> > On Fri, Aug 13, 2021 at 05:25:49PM -0500, Tatyana Nikolova wrote:
> > > >> 1.	Software writing the valid bit in the WQE.
> > > >> 2.	Software reading shadow memory (hw_tail) value.
> > >
> > > > You are missing an ordered atomic on this read it looks like
> > >
> > > Hi Jason,
> > >
> > > Why do you think we need atomic ops in this case? We aren't trying to
> > > protect from multiple threads but CPU re-ordering of a write and a
> > > read.
> > 
> > Which is what the atomics will do.
> > 
> > Barriers are only appropriate when you can't add atomic markers to the
> > actual data that needs ordering.
> 
> Hi Jason,
> 
> We aren't sure what you mean by atomic markers. We ran a few
> experiments with atomics, but none of the barriers we tried
> smp_mb__{before,after}_atomic(), smp_load_acquire() and
> smp_store_release() translates to a full memory barrier on X86.

Huh? Those are kernel primitives, this is a userspace patch.

Userspace follows the C11 atomics memory model.

So I'd expect 

  atomic_store_explicit(tail, memory_order_release)
  atomic_load_explicit(tail, memory_order_acquire)

To be the atomics you need. This will ensure that the read/writes to
valid before the atomics are sequenced correctly, eg no CPU thread can
observe an updated tail without also observing the set valid.

Jason

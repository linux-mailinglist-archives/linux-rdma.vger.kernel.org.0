Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17D434212C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSPsS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 11:48:18 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:64737
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230186AbhCSPsJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 11:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIigL2dkLOJRk4v8V4PDHlMJMY3JKIXJbvsQTPcnvOAkfYbn3jRJi1/whI6SChnh3jSiJYPIgQQTKmu1nlS2GLLXSICgJRqS9T2K7PgEvx/nT8ks9dD18PYvKC1s/i6js/XKqPFyLbg40HNHELANYCKmazMK+LLkplLQsQqeh3zJvcZIOotTG73+AVw4/1PDnaRvXFqCSVxPH/csvOKAhtgTjBgkmIqyh5+g481PbClIcKTl3h7rDkxBZqN/pmWOhrRjcpopGGLMvR0ZRUjoaqtrJUeg4V+je4JHIlLhy+LXgMShIiwFqekoAUpDLEOMZdIf2BMOOkUWhOsZZl+6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q38YOuJCMfBFsDvi8WzqRDMTy5f1iX2yHNFPMg94Xck=;
 b=MG25dPDKyfNKH3YAh5Pt2oPsd62cWmDZPP2ybPSExud97eDICBuZcEvsjA4VxBW1PARGkIzI18M81cG6Sqwy0PUDCTw/USsc+tJxm9MMfqE5BNE7XduqoeQShZgJLVCMhurakcMbxefAcPJzpmhH203qGyVDj9WJXwlV67eCrj2ZYTxQjkEMF7qzjFqn1jLt4C8vAdv+TDfrkqFhBy72NZViWjQwnyaRM588R/Cjj+sl6FCl4+0eiYj3oYaRefQyx8bhsa42N3PQ9fNOKXu6GXqe6E7bSXu3peKkJywoCg8ExV/jXkSM375aU/IVFDBm5h9bg4UAK0Wv/zX4RymI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q38YOuJCMfBFsDvi8WzqRDMTy5f1iX2yHNFPMg94Xck=;
 b=PGezOtoC8kyVUOYsztpNpZ33ji0Yqn5qGjjMDOYJ9EyEvs4LWjjEeMKlO9+ykjJm9WyPvO1OHOKHgwROVfj08+PmjSpM0nH9Xm+OWOmpFztiuu8DDNzs25BvUFDjG2vJmCp4GhibdgAH1dzni4mKU+jLJfLNtt6sRDgo76a8Eccgh25R4BEzNDvvb4rzrimaydm0fdrs7s+o7bOmAdND0X+spY2WlQeidceoKuUCUSMYweje1FaNT3Vy0Me0cV3n8nkKj18neImV7ePnZ2yyo6j6ze6zeGzMv78697jAfKhvtVNJqMkWfA2YeusQMrTA0mUg+ppzIxEQdHtXCa995g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Fri, 19 Mar
 2021 15:48:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 15:48:07 +0000
Date:   Fri, 19 Mar 2021 12:48:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319154805.GV2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Fri, 19 Mar 2021 15:48:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNHM5-00HLYX-5B; Fri, 19 Mar 2021 12:48:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312148a8-a9f0-49ea-f150-08d8eaee6362
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR12MB393035680386B16B352BA591C2689@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exk+jAEP3AFtPPpiD7Kjzie2Ol3+ouRlKgP7z06fFr9HTVJlzo7Z2qUKWQPsV5iV/D3RxkXk1Xp5OPGZgdDFqES0DgWs8cLa6OPxZG5ljnOeU9jXFJB+jD69k/lnNdU8ZUjdm/2SZOCxI6TwYdEDwSvEKVt8Wi9oIR6UR5XAxunTv5i/RSl4IDWviybBcTvnuccnNzF68pdQouFHaF6FiTTeNA70lZJEJX9LYJ4AMzWrRetMNC1RKZAnTMMJXLNNkK7nJQch+c1rNT2rK044mvW6B5i2P7OWsuqGdz70OifoQNcgoNscJ7gcQUIZRw1Qc1AcleU1EDUskmHjGENrVIZIp0iap/W9CcD317Dp1TTx/llDegdeJG3P9Ynbb4LQL2olPxcJvV2Td4TP79fpF+GGeCUIM06QfrDVQZxmvBFnpeaPY6/UoipAKnS43rhJWAZA6SbdnTJaRlpazSh5HcDb+XUucrAA3LrQ69D4KAfMUrDjRbhqU3+uoKlhMY3vT7fsffgVeGXl2Xt8siG6rvPaHU0mD559jjWBRj3jIb85vJ9rmBCjkZbzAKg/gGrXMrbVgv7Na0ARvTVq4dKA8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(9786002)(8936002)(2906002)(1076003)(8676002)(4326008)(53546011)(86362001)(5660300002)(38100700001)(33656002)(426003)(478600001)(9746002)(66476007)(54906003)(186003)(36756003)(66946007)(26005)(2616005)(316002)(66556008)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?osgsqSEMRDvvaSjNSd4Pa+bNvxOy2f7GIcIFLv6AbkhvzOyHfCTzRCVNPsxe?=
 =?us-ascii?Q?UAFAX9m5/zO/EwFI8H6X1hi8HD5IYGfx+nnAmfFtX5N4fA3+wYOPbEbexinm?=
 =?us-ascii?Q?/6sMnNh3x0h+U4qOS0KOUUI+zs6oyXDA/mEngO4LjDhapP/qmz/AjaIlCamg?=
 =?us-ascii?Q?eddWJDFj14+sjzM74qZmFbk3uD/cd4dk3reSeyozihM4W43qOByHkSlF+L+u?=
 =?us-ascii?Q?DhJBWhkuRlmhUnkPzJZp6qkWmLFsvurscUOyEqK5R2+Prl5im1tc7TlFE85P?=
 =?us-ascii?Q?VlodGP3OmxnPrf/2MaNiRUI5naXkfAV4jKVjrPSddZsiPqO61NfzGeXxumxB?=
 =?us-ascii?Q?xBs6bqAURJCfDXtSmy4M+Plyb9iN+03wL/66rGQnTYSZyyF5P/EZB3ojyI/l?=
 =?us-ascii?Q?OeIUVOO/in8VFdkQ+mKQrl2Sxt2BVUBt+q7xBV0jeksEgnl8kDwEEhQ8KTuM?=
 =?us-ascii?Q?cFn/OqtxaMou+Hn+yFq7AKSBfxbryAR4nNNvM2RaCWuSdRi7sFLzxjfFdZcJ?=
 =?us-ascii?Q?1hSV4eV0bo8cu8A3gAuDl1kj6j35eNtVoT6r4hYRuFvv3F3e53sOsyUxgiAV?=
 =?us-ascii?Q?5WZIRi2gP5ujNqtBOsb0RHDl2SyX767uo5hdt4S0QS7Y+kXTkz9OAtNrJHBR?=
 =?us-ascii?Q?AD196m6v0kSVzzDG7Hq4wQ879E9kaptU/f6tASKV/Y5InQo27m5Wyjh/17a/?=
 =?us-ascii?Q?nCUpQSiZGUAGoVZZ2owI+51bJ8yL67XqG+wGyLyFf7TU3Y1+eiI1IO3Z+OTo?=
 =?us-ascii?Q?W47+TwgxHwhtKnPG2QVv4S+QALTrrQFaBeWhN41l4gmGhE9ti1XTZwYBQgam?=
 =?us-ascii?Q?sdkUlmtrVe5pAHn4zNB8GgLJN2ur/00s64lZxLS347UZ/TLj6F4bszsmdchj?=
 =?us-ascii?Q?BeGxg9JPSzjT02tye3L1n/Ms3PBh6VwZ/9/aGCiJp/5nLfAHi4yOkMyeNk7J?=
 =?us-ascii?Q?/9CU1DqFbs0P9UL9LMTXLnj46uKbyNq9bw5Q9xNQLA6MsMiCTQ8N4xa650ay?=
 =?us-ascii?Q?Pt1znExKWhSvgaYfZz8OAAVMvxwv0wN57dWdPPwB/VqY9TNMCmUdbGpwH8Nt?=
 =?us-ascii?Q?kmQYyAXWPr/P1arWYjmWJ+Q0hng5x3+UGIEHQ5xfVSutBLNSOCi+mrQNhn+f?=
 =?us-ascii?Q?8QY1vLu9B0pA20/FEnCnEbRmtSy3cy9+QkH9/XzucbW/fAE3xn4Gu9ku57kk?=
 =?us-ascii?Q?wMtQZWUameQF0BGHagnyBgBkfL2n+2ZSMJH0xwDJf3dozN1iunUDU1hFZWIm?=
 =?us-ascii?Q?SxeIhzjeIpMibWij3sc6bpjFNkJXAHvv+kYLb9H5tSocTgCPoT9olHZXMZWP?=
 =?us-ascii?Q?+uk9Cy1DWGzmZ2SVvJQeL2+Y3meRVEaiJNqwoKdUJga7kQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312148a8-a9f0-49ea-f150-08d8eaee6362
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 15:48:07.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jloKEJP6poI96DhqANGwi1JdB6noFq8qwE6deQbQXU08KPsB0Q56YfaqXbab8lkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 02:49:29PM +0000, Wan, Kaike wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, March 19, 2021 9:53 AM
> > To: Wan, Kaike <kaike.wan@intel.com>
> > Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Rimmer, Todd
> > <todd.rimmer@intel.com>
> > Subject: Re: [PATCH RFC 0/9] A rendezvous module
> > 
> > On Fri, Mar 19, 2021 at 08:56:26AM -0400, kaike.wan@intel.com wrote:
> > 
> > > - Basic mode of operations (PSM3 is used as an example for user
> > >   applications):
> > >   - A middleware (like MPI) has out-of-band communication channels
> > >     between any two nodes, which are used to establish high performance
> > >     communications for providers such as PSM3.
> > 
> > Huh? Doesn't PSM3 already use it's own special non-verbs char devices that
> > already have memory caches and other stuff? Now you want to throw that
> > all away and do yet another char dev just for HFI? Why?

> [Wan, Kaike] I think that you are referring to PSM2, which uses the
> OPA hfi1 driver that is specific to the OPA hardware.  PSM3 uses
> standard verbs drivers and supports standard RoCE.  

Uhhh.. "PSM" has always been about the ipath special char device, and
if I recall properly the library was semi-discontinued and merged into
libfabric.

So here you are talking about a libfabric verbs provider that doesn't
use the ipath style char interface but uses verbs and this rv thing so
we call it a libfabric PSM3 provider because thats not confusing to
anyone at all..

> A focus is the Intel RDMA Ethernet NICs. As such it cannot use the
> hfi1 driver through the special PSM2 interface. 

These are the drivers that aren't merged yet, I see. So why are you
sending this now? I'm not interested to look at even more Intel code
when their driver saga is still ongoing for years.

> Rather it works with the hfi1 driver through standard verbs
> interface.

But nobody would do that right? You'd get better results using the
hif1 native interfaces instead of their slow fake verbs stuff.

> > I also don't know why you picked the name rv, this looks like it has little to do
> > with the usual MPI rendezvous protocol. This is all about bulk transfers. It is
> > actually a lot like RDS. Maybe you should be using RDS?

> [Wan, Kaike] While there are similarities in concepts, details are
> different.  

You should list these differences.

> Quite frankly this could be viewed as an application accelerator
> much like RDS served that purpose for Oracle, which continues to be
> its main use case.

Obviously, except it seems to be doing the same basic acceleration
technique as RDS.

> The name "rv" is chosen simply because this module is designed to
> enable the rendezvous protocol of the MPI/OFI/PSM3 application stack
> for large messages. Short messages are handled by eager transfer
> through UDP in PSM3.

A bad name seems like it will further limit potential re-use of this
code.

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041037977D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhEJTN5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 15:13:57 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:19776
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbhEJTN5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 15:13:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC25svrJsMUO3+u8Fa4RAje9IGU38MBRriRA+f5yT/5XxAvHu00CAL6CT/3J01GszQ2e+zTc1Gsst/aCkuKZlRqe3MWJJlgPSyOb/3wfGmbFD1LONYNvFTOY/Lg8OfVnfZIdPvKAWJHJd/VEfygVWoV8FyJHJBjONusk1iVBOIqV0Gz73uo4lydw2gMF0vKRsf3E47KHSjOF/o+EaUR3uz4FK78xsVlpm4pye9pJqHyZcAnFM8vHZ6ZFNgbfaO/7eIdOgpdmt7XYYSRmeRvRnv8yzF8TnA5Agqvy8jXWF8K9IbowTfMwJPeJgW2TggF1yO5gnH2Y6Pxnv8D/J9tZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlA5GuqZTjdjzLEf8MWY/o0oaYt8/W+OxctOuq0lNG4=;
 b=YrCL9TCtsgJFiLxx7s7C7NcqPwAk93H462aqc57vS/n6wUlXH+PtMk1RqcXRwHREeeNJ3bW/gaq1JIGZItAP02EhszFQQn/WI+0d/Xhm6AbS6mqkFptjvUiSxVvZiLmuTOvWMKjrSFX7cxPzWYtEVIIctFWMiJCNWVjRqxORTwAinjuxZlOJVtYHQRhVQ6U1OJuCzOBIMjM6vcagKRFTCLUXpNYpfbu6A9x5RPXO2LYbleTOX7AestabDrAeUk6GNGixf+Kjh3UWM44tQs76uSDmdZs9+K38yWtiOqPABfx/sFoKJ5de0gPxDyQzXkdnNHSNdqKPadqZUq+xMwkmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlA5GuqZTjdjzLEf8MWY/o0oaYt8/W+OxctOuq0lNG4=;
 b=VLbR7YKttfJ+nqQY4lNJc+Z1SrsEWYzxJJZ7Juew+T2xwfUqlEJ2UBltUL+48wxqH9zQoqlUlRHQrJWhJtbWRgPhpXRcWEktdD2Ugh4BLSyEAQUm4g7DDw90RhXxW5uy5gYjRRY4i4eo3w/2Ofhnsk9ITX1RjtKc1RiRDxhssvN3zr7WqgulRtXfz4ZsrReY92CcrKBbSStr81qlWnSMWRgKSnxvUiZRXKbUvjS5o6gLWIKRXNKzzkHIzdbLLm2LmxLYgK4+GHlY0VBab3MwigDEE7P//FurMpm5C32hGPCdTv6XZBjJO6THuvpWasfgeBXalnt3DIzhQMWX9+Dxkw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 19:12:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:12:50 +0000
Date:   Mon, 10 May 2021 16:12:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Message-ID: <20210510191249.GF1002214@nvidia.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:208:257::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0052.namprd13.prod.outlook.com (2603:10b6:208:257::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Mon, 10 May 2021 19:12:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgBKj-004hcT-2A; Mon, 10 May 2021 16:12:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4e02d5-d3d4-4811-42ac-08d913e79abb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883CC1D263371C8CEA3946AC2549@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnxfRqnKlPQ+Rck6BxN1yWcXGDZPsQ/nMiulgTbPZ0ZX5dbpBICaVvo1gk0CqouPX1Jx1/++/BZ2XPqKr/Lo6JIMky9j7QNP7l8RXXOLe2Nd8aq2VsGQk2YqAmdMRXonpNypGLft/aw59N2QpGGHQ/7taDgnd1ZYlRKMAogxRNp0xFu7Vxd+K4M41Pq/hJRsbCkIV+i6kHQUmJrkWJDaWSHGLpT/ClXOlHb16/Oei/dE5d+FJN1lPYrMxsX9/usICr1PDEFES/Ba5C49J0lhIjSwmQWW81NOV2Un7AjnFF+evZj82VikIzI4nM/EG1RXrHhUkWA2Qifmqvu5T29oBQRgqoeV8JFuRI3wxFPxeYiKb43z0q2SfFJGRfCtjc0r8lb8aqXX27Sz5cI8Q+kUHo+FzkOEVP0ohshOR9u6rb6gGMkx0Oo9gt8dyyOIFSkSmk1QeUV11820ZDQxEdIFvFwgKG7Z3XE2BJRY8zcUhJo/6lVY31OPIkYBCvl8r5ELzUV6tDM+4gAoQqcK/ydvq/lMWgyqFmN0pOST9HX923KJQk5YUlqfGTmgsAguN29v1WpwRgaptGDtX3Eqbbr/xOCPyMpnND/mxy3X/YrL2sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(66946007)(2616005)(38100700002)(86362001)(478600001)(9786002)(186003)(6916009)(9746002)(4326008)(5660300002)(36756003)(66556008)(8936002)(66476007)(2906002)(8676002)(15650500001)(66574015)(1076003)(33656002)(426003)(54906003)(53546011)(316002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXN3ajhWWTJjTS84NHJwamtLYTI1Mkx5aEVvSW5GeEpDVUpnRS9lNWw2c21y?=
 =?utf-8?B?RWZsSTNTY1VMc1gyMXlvdmZtdVlFeHB3ekNTeGI0ZTRpZzBJVkxMS09MS2Zn?=
 =?utf-8?B?S2hVbnB1ajF3K2xVTGNxTlg5NGJsakpIMDdINEZOaXhZend3WlllVFEvb1Bw?=
 =?utf-8?B?aUhVaDZoNld5YlptTElOR0ZwQ291QTVJVG1lYmdiNHdaclFvYWQzWkIzM3NF?=
 =?utf-8?B?YmptMVhFcXhTTGJqajF5bUpJOGVYWlI4ejJqRG9lWTJWTDNCOVlTeUNQL2FF?=
 =?utf-8?B?Y1E1NmtndDZxSWhOOEFrTit5SDBpWFBqYWt6WFJVMHRGZ3JVM0QyWEhJbTJY?=
 =?utf-8?B?REpTcVFkTnJyRlA3TWpzVHVJdnhqaHUrTnFzVXdVM2hPRFpidmI2VWxBQkVP?=
 =?utf-8?B?WnRaYk9nTXdJVGJ1c1dvaENXQ3lKRFZHQ0RVaXdjWktNeDBQeVppeWwwU3do?=
 =?utf-8?B?NzRwdWtGdUF0WVpFWExtbURzNHNVdGR3Uy9pMWova2RrYjViL0dwSlZVUnMz?=
 =?utf-8?B?eGcrQVNpdjJoaFZHbWxMWWZjU3piNHRQc21telZSVERpSUNlaXVSK2VtUXVZ?=
 =?utf-8?B?aXllSDlabHBuYVhrQlZNdFhtUTdycjhwSkZ6bHJLOGxjQ1ZuWVdaczR3Uk1F?=
 =?utf-8?B?cGM5V2lObWdzblRaYzd2d21ydktIVUtBVzdMMTBkL3B4c01nS2FDd1lPOC80?=
 =?utf-8?B?RWlYMVBobGU5ZDdoZXdLa2d2cHg0RjRtNzZhTW90VGEzd2NGRkQ1UGY4WnF4?=
 =?utf-8?B?SVppaDNaTWtvNlM5UlgvalFhMXZPR1FzZTNya3dxSWM3U1FaOUdiS2EvNCty?=
 =?utf-8?B?dEZBMXNXNVExNlovOGN0WVBpdFcwMEJGajN6VzIwZ0ZhcFQ5TzJqYThqUVUx?=
 =?utf-8?B?MkhwK1A4YjZ0d21YRUVINHl4bTBOOGJWUldDcTBuTVhHM1JQSDUvSWU2SFNI?=
 =?utf-8?B?aWRHVGVCRHBFQmNaTXVIQjNuMnc3ckM3Z1V3dlQvanN6MHhNcmRGbzhuQ25h?=
 =?utf-8?B?Rk1VYUpuZVFYb2JsbWxySi9mOE1pdWtaRGhpcTFEdHJza2xNYjBENHVqczMy?=
 =?utf-8?B?elZZMkwzL1pvZk9YS2hKYTYzQlNkb0QvUWx3Z25oVXlSWDdhRW16bWRtT3pN?=
 =?utf-8?B?UTVSbkdZWFJBbXlpZ2tOVkUvUlQ3N2hta29JQjc0djJ6THBZUmpENTg5MWNk?=
 =?utf-8?B?VlBWNVlXVm41NmlOMWkyakhvR1dqeUsxY3NLdUszZElhRnI0UVVJdXMyby9p?=
 =?utf-8?B?d1Rpd1orNnFwQm1heVg5WklJYkJPSW82K2pGWFVaT3pnRU9pNlJIL3VlaTFT?=
 =?utf-8?B?SmJ4NmZtUEhNK0NQdFpyNmpqVGJLSmgzcWk3RlViTlMyd0wvSndyK2VScUd3?=
 =?utf-8?B?b0dGbllBVnR1YlUwTEY1ZGdJS1ZhdDJaK1d2aStHMnU1aStWWTlENlp6YW50?=
 =?utf-8?B?UUx1YWJMTktpZXllSHJQZGNwUlloVXkrenA2eHFqZEcyUzVNckRHQm44SGpC?=
 =?utf-8?B?emhzbDhDbXJtUk9SUEkvcE5BaHR0UDJnb21DcGdqWmFTQzFISmxzbE4zVlpi?=
 =?utf-8?B?RmMyRHdCc3hSa0VkeVpyd3hMZmppSTJpSU80S1ZaeG53Znl3bG15ZVgrVmZu?=
 =?utf-8?B?QjZ3dzFEY0lDVjVTeG5sdU55ZlpHNTFzc2JJUzdSVjg4aE0vbHhKNlEzc09H?=
 =?utf-8?B?TnQrTDZYNG5mUlV0ZlJwbDBqNlRhYmlCeHhudDZXbWg1U3I1VzR6ZjYrbVUz?=
 =?utf-8?Q?60hcqu71plHK9c4l2R1msivbOwQNL4yYkfAAj4O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e02d5-d3d4-4811-42ac-08d913e79abb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 19:12:50.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlxsumKqdahwOrh/7hzh7BW8quKjgem2fn5xo6Jue+7Zv99he/Qbo7vejhmH1J2f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 06:52:54PM +0000, Haakon Bugge wrote:
> 
> 
> > On 10 May 2021, at 19:04, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Wed, May 05, 2021 at 02:54:01PM +0200, Håkon Bugge wrote:
> >> There are three conditions that must be fulfilled in order to consider
> >> a partition match. Those are:
> >> 
> >>      1. Both P_Keys must valid
> >>      2. At least one must be a full member
> >>      3. The partitions (lower 15 bits) must match
> >> 
> >> In system employing both limited and full membership ports, we see
> >> these false warning messages:
> >> 
> >> RDMA CMA: got different BTH P_Key (0x2a00) and primary path P_Key (0xaa00)
> >> RDMA CMA: in the future this may cause the request to be dropped
> >> 
> >> even though the partition is the same.
> >> 
> >> See IBTA 10.9.1.2 Special P_Keys and 10.9.3 Partition Key Matching for
> >> a reference.
> >> 
> >> Fixes: 84424a7fc793 ("IB/cma: Print warning on different inner and header P_Keys")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> drivers/infiniband/core/cma.c | 22 ++++++++++++++++++++--
> >> 1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > What is this trying to fix?
> 
> The false warning messages. The wrong way though:-)
> 
> > IMHO it is a bug on the sender side to send GMPs to use a pkey that
> > doesn't exactly match the data path pkey.
> 
> The active connector calls ib_addr_get_pkey(). This function
> extracts the pkey from byte 8/9 in the device's bcast
> address. However, RFC 4391 explicitly states:

pkeys in CM come only from path records that the SM returns, the above
should only be used to feed into a path record query which could then
return back a limited pkey.

Everything thereafter should use the SM's version of the pkey.

Jason

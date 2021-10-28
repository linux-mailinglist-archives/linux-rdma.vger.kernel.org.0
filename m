Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD84E43E20E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJ1N22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 09:28:28 -0400
Received: from mail-bn7nam10on2132.outbound.protection.outlook.com ([40.107.92.132]:17953
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229981AbhJ1N21 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 09:28:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5EnsO9+4YzRx+oLjkKSCyowfq5yGSMS9rLGaMfS3UrwXrj0FAmU2wsX0qRqPLlI5Fn0v4M/C2orClfGP97u49zq0XopCZFrzk6QxRdOIjyFjnSzh+mG2dg1ZbXlAt/Kzq4wQUq7UyEiiWecRDfEEnc93PUyEPan1b395WC3UyX4aHQt/OuMAHBMTu3pgxg679NC3pWlh2eA0qrp8jetzSdnDCVplH5a3HYYNTJ8Xn4dPnjQbWpjWpSV37a4IB1JOMBeYv10nwZcP6QdL9VeG5XyTQYuqTyqsITAfn7xE7bYWBX6t+Jgui8fFMxG8FJlfaRKwYyCmtFF5a5BvjWZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kq7VUU4eMWFnRv7SQyRmxPGp3sh4q8bj6SYriz3aIM=;
 b=krYhCPMFWMcj6XgE6cbM7e0IR9884RTykM4HqgYsQEGPe1AGjC+IOcNzD59UeWXOhRrEcI2P3AVV7MfTgFCQnszNln56a+FmUlHUXsqolkyQLdfzfzuEZBew62/1FGJm51U5XZPx4lB8AdExHr8NVgpXCm5esqdSmilH0IOjElAd3XFp/WBQQ78PLML492fgFyQ/CCBAIut1lS9+AqrOV9SLQRCGprtsBLDaTQtvhcKOO8wvqSX3cd9g+LTDet3R9Xw2+3OzipNJcr4PPGBX3muYbgMPlZEPt5Zz/1WWkYahURToPnF4eif0swSs8G0Bzu8uL36k8mtGRS7m0OkDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Kq7VUU4eMWFnRv7SQyRmxPGp3sh4q8bj6SYriz3aIM=;
 b=BZAG2/+z1Qgdd4wL8Tcb2603epv13iqK9GRWjnpQf42+LGEFocyHEcUUpwhRg9gbBY0MtSkwBFHVir/ecv+eATosbmiy9B+PRcHGJWQF4xdfvO+2FIDT3L4dHSa52b9N80yxeEc+Y3UTJgk6cqEpclb/0cMAkXnZXznSJhIZpuCV8bhT6eWtc0YjZpI4FK0vzfH38PVYLnI8ct+J8Eb1ZgLuiHjUaTeHgRpWWUjq0yTy7xwOMoh00iiA/3sHH5CjNetqIlK/APT7t30NlCKog/Hd6xH9Ya76ebMZz8qPuZfhxb9p7gASjFgQLEGmL4DENpK8NMyXE7IN4CD+rkqdNA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6587.prod.exchangelabs.com (2603:10b6:510:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Thu, 28 Oct 2021 13:25:57 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 13:25:56 +0000
Message-ID: <111e9799-0319-59b6-0920-1a3349f4523f@cornelisnetworks.com>
Date:   Thu, 28 Oct 2021 09:25:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH for-next 2/3] IB/qib: Rebranding of qib driver to Cornelis
 Networks
Content-Language: en-US
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
 <20211028124606.26694.71567.stgit@awfm-01.cornelisnetworks.com>
 <CAGbH50to=YUHUsaVZAvw_+_AWNnNVaJtEmMFco417jqVGNg5_Q@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <CAGbH50to=YUHUsaVZAvw_+_AWNnNVaJtEmMFco417jqVGNg5_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0047.namprd19.prod.outlook.com
 (2603:10b6:208:19b::24) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from [192.168.40.173] (24.154.216.5) by MN2PR19CA0047.namprd19.prod.outlook.com (2603:10b6:208:19b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 13:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 238ff780-41c5-4bee-dc09-08d99a167926
X-MS-TrafficTypeDiagnostic: PH0PR01MB6587:
X-Microsoft-Antispam-PRVS: <PH0PR01MB658743D36A3DC2E1B22A7287F4869@PH0PR01MB6587.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZeHzMkhsC6M2qfQxf4nkvrbNHQDrG+/eCPfl1qiK9QI9bOlFZR+t/+aKlduhUNnA9ZC0tOtEoR2CEmFGj0hHusa0qhxsuIsabYdU/82khfxgxZwBwnzthgK0jsXmnUHzH+xw1IO9d9tapKlRghYbkgj/6rKO60PO6azxXIPLSEDyUgpQhG38SRZD4JlWKMYJHmp3XlMsp/BFknZ+Jno8rQWYzVegC5jC6w8N7iThNHxmLwUtJDSx/Cj1qLSXV0I7Il3Ys3MeAGV0NM/BPRqkFwfGDvupY/1/5VuWnv2QlgOMZZ2fV9Tjf3+BbtHsUunOdBswKIIXciLFWjlZefHG/5VG7IE36Lz2EljFPJi2NBezJKwidUU3TxMKsVJzPa9xSQlZuzyrfuiE5fZ64zLvGD6BBfUUn2y+RkSc9itNLAD4heu8MxWPhU405Et5EuAYoXQuBb1AraaB7iXm+GmS5dtIXzEAmfL4VYBfwq69mLZvfAx/m80kOwFnBpWugxPqy0qH1OJmsLH8rKm025WX6im34AlOxAsh0Re2OJuR1PokqmRL9pf/XcFAqc2wS0YUuSOic/GhTh/teTnsgn7VQDpif4HtJVxuxYt7xJwpQLmGXEaBBWg3+QSG0jknYZn5zXN+zYjCozGeuSOSbebk9241FC5xIuwdIuB54DX/Hn2qd4I0K/4EvJ3prPXRzF3oT9Zm+R172xz3hEPmuBIzxVbNz5Enf9FmDIyEH+XMhfaHuh3l3BIt2rg/xLSV+Z3CW+x/0nfObYvGz/wO5ePWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(376002)(346002)(366004)(136003)(38350700002)(38100700002)(31686004)(36756003)(6916009)(31696002)(86362001)(2616005)(107886003)(54906003)(6486002)(4744005)(956004)(186003)(53546011)(6666004)(5660300002)(4326008)(8676002)(66476007)(66556008)(52116002)(316002)(26005)(8936002)(508600001)(2906002)(44832011)(66946007)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFh1aTdRSnhldFJML3VMRnp3emNKZEtoTWVCcVViWmt1RmMyZllObkQ2MllM?=
 =?utf-8?B?RngzZm8zZXhJQjB0MG5JUG5uTzQwQXJaa1UwMEx6ZmhvdG1hQmhmMVR0dmVm?=
 =?utf-8?B?YTlKL3ZwcDlqeER6NDRzQkZQWGNBNzdaNm9XU0ZpVnJSL0dML3d5Y0daOFJC?=
 =?utf-8?B?blRETS9rZ1FxRnY0MVBrMEFSdU03SnF2Nkp2bTVJZitNRTNaa2hycUtBTzIx?=
 =?utf-8?B?T2tRZ3A5ZGxXb29qdWZJbTRreFRiL2cxV3FCekU1dFhmNzNuT1owQXA4M056?=
 =?utf-8?B?enBMZHZpMEVSY3QyQThCVEJSZUtiV0kzRWNCY3d1bC9HQ2Q5VzlWVTV1S0U5?=
 =?utf-8?B?NGg4WU5LdnFQUkZkUktyYWp5VDNWWVNvOGVCVmZBYWVrSmpuQ3JJYjg1T3ZH?=
 =?utf-8?B?R0FSVHpoNGtZWUNpUXBrTEpCclp1bWp4WTdtMjIrSXpNUnFQOUlrY0lSKzFz?=
 =?utf-8?B?Q04vZldQdnA1RlJ0Y05vcU5UK1hxbTdEWVozOFYrMGZ6OGhXK2ZJRUl3T0tQ?=
 =?utf-8?B?UVJDclpCYjZTWXR2Mk5nZ1hCT0pUaFAwZVBZUFgzNmR3MUk3Y0tnd0lFK2Fz?=
 =?utf-8?B?d2dybHdIMlkxS0dLMkl1ZGlsejdiMFpqbDVaWlM5cnFNYXYwY0sxSWN6c0VH?=
 =?utf-8?B?NTk0TG55RHFxdDFjZGcvSlZPWCtiaEowTGplSTZyYktVNTBsYjlEZC9hQkdD?=
 =?utf-8?B?ZTRZSHNlejZzcnNVNFJIK2hlR21RNzJrM1BQc0NDTXR2RFp0SjNjY3lkVnRj?=
 =?utf-8?B?eUdQaW4vaE1MV25iM00ra21RZFpyeEJMV1V3ZzlFWWd2dFhJc2g3U2tod1RY?=
 =?utf-8?B?MHpraC9WOFlUMFIyRVY3Smh0V1FzNEkwdlZaalVBWTk2d2dHZ2dadXYyUUoz?=
 =?utf-8?B?algrZmFDNlFVMCtZWVN1Qk5sZElIakZYVlM0ZmhoZDd1WXJudVFBSVdlczNR?=
 =?utf-8?B?THZ3U1J5aGk3NDEyNGtsemJuY3NhUTE0Nm9GUk4wNUo4OXhlYUpmVEE0MmZD?=
 =?utf-8?B?a2xCNnA1LzNHamdFY3A5eVU5czlTczkvZmxsOWhFZk5WY215RzRnK1JJVVA1?=
 =?utf-8?B?TzVTYnpiNlJCdXhsZ3ZsU0NYOHJiQzhUdlRZUlNNZmpxWXY0L2JJS1pRaFpq?=
 =?utf-8?B?UnBOVjl0anB5eEpya2tyNHJHaFJlMko4MVBPaWxVYmJJaFAwTUNhUU1kNHN4?=
 =?utf-8?B?QzZqb0pvcGpINjVwSkh1dFFpNmVnbGxCU2tYMlY1Y2ZNcXU4UnM1OUFLajJY?=
 =?utf-8?B?ZGlyQ3QzMFVYMzJONkhNTWk4dUl6MlRpWGM5SWVFaDVIQmFLN0J3TjBnbW1J?=
 =?utf-8?B?aFduNGlMQkU2RkVic244NUFubjIyTisxbE9xWGRReG0za2hPMnk3NTBxeVVx?=
 =?utf-8?B?cWlScmlFa2tJQmphWnlZdzFCUFJYYVoxSktiTk9RdzJqbXNJNHh1NXlXcjY2?=
 =?utf-8?B?emRIb3pEQ0pVQzN6TUtiL09XM2twMlN5aVJVemV0cXFBb2gvWVNQYnFobzRU?=
 =?utf-8?B?eFNvM3J1UkF4WGhqYWVWNjlZRExYNUhJTjNzS0xVQXY0bm80T0VSZDQ1UjVm?=
 =?utf-8?B?WElPUG5zMFJzNGV1b2hTL3dNcE0wMlBWZG9wUzJWYTFGSG5tNkxrQ2p4eFgy?=
 =?utf-8?B?Y3lWNnVRZHNWWE1aWUt0alpaSkJVeHMvMzNadTVWZ01LNXhnQWI4MVdtWWsx?=
 =?utf-8?B?VXVCaWl4bFVwSkNlb3JOdTljQ1k1QUt6SkpBYjcxMFlpWkkvaXk5RGRENDI0?=
 =?utf-8?B?c1BuODJpb0lyOTFhdkNYMlJqbWpxeVVnWnN1RmY5cmQwK1hhajg1NmdJbVJG?=
 =?utf-8?B?eld2M3JReEhIbXNPTjhRU1VCamFxd1l6TnpjNXg3YytXZnMwajJRUHlub3pz?=
 =?utf-8?B?MWFPWkRBMEFROW9hU3FrRG1HTHNVSFI0SUdOajhtR1FrSkU4L3QrYm5PQVdZ?=
 =?utf-8?B?VDZka1NlejNtRU9peWpSMUdQdndaQmprQVlmajkrOXZmZFJsUjdzNXdQWHhk?=
 =?utf-8?B?Nm1pWUMyZVoza01xTU1sVDA3MG1ublpSejM3dUN3R2FCNVRQQnB1bXo3d2Zx?=
 =?utf-8?B?T3ordnA5cEJxay9wVndZQzJoMWdIalk3L2F3dS9hTnVzOWcxa3luQ3hoMXU4?=
 =?utf-8?B?Q3FCckNvdWY3aVdwL1J6SnQ5OUZVN3M2Q0pSNUoyMndORFh4VEpKMnZKRjdW?=
 =?utf-8?B?anYwbXJTWkFVeXpWTjNrVFBMa0xCeGthaFV3L0svWisveU9IcUY4dHlLQVlX?=
 =?utf-8?B?ME1BQlJQdE1BTGRhOVZCUGNvWHRPQnZ3emFuWHgvNUhLSUphMk5xMlNGdWRm?=
 =?utf-8?B?V09DaVppTzI3MHZFYVNBVWJwaFpuQVJ4cjAxY05HQk00T29NbXRXQT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ff780-41c5-4bee-dc09-08d99a167926
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:25:56.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmAWWVJSIX9XrwYVT8trNzPpRkdHdacmsX//6qp8/gS95G0IXamSIAz3v7vwyEK0NoMRZrl9SD6R9t5bO9RU+H4PRlCJAPNOTeVbMVV2nvMAL/9nKUKoBa9XLj9XKI0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6587
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/21 8:53 AM, Doug Ledford wrote:
> Do you guys actually still support the qib driver and/or hardware?
> That's old 40gig stuff. Is it still in use?

As long as it's in the kernel we support it from an open source perspective.
Meaning we'll make sure it keeps on building and fix problems that people
encounter. There actually are people out there still using it.

-Denny

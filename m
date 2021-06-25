Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC273B4605
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYOr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 10:47:29 -0400
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:17437
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhFYOr3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 10:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNAZLh4oSCHVYWCIfgY1ow+4oF/if6BMRm3fYXguS2rtnEmwVQ+tgL4y44Cl7si+MBfaW25uvZQ2kW6eGGPElWLLHiMKpKIda9PXvwmfg/nTkP1R+y9sxnRlEz+ZxERf3JJG0/bTVYhmnQJu2MXkCkYK96hFzrgC/tFDFVPq6HudB5VMW9Dkwfj5mFe3YSf68V4LzrVx+5aRE0BEnwLkKrefffFE5oN4ZeogqP76yUoHtDZjG4b7xHhlbQdCQ2StMpZ6A8PwaFdPeMGcamqvjSZyuWzxPMspZgmmYxp30Hd4/GWJHp0uGDAFqPIWnLWhfeRFIn5lswoin2rOpRNKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzhSjZR3ssEa+kzgWvael9VZ/HBN1Hm4LjCR8k1mbLw=;
 b=Aw91oP9uZ4CmFeh6ExKp2tD/+3ZtnmhFcmHoo07k63VGAeyVZKk384pi4keBGz2IkmzifDEe83J133UmtsZyZOqICF2EEovBc6RGzhWh8rI6J8qKHKQ3XERmiTQRS+FFWIgQ/CthKTN84pvHVLOvdZzhbz3AD/1dZo9DUWEM4t6MRGZfdpGfJIDtjUFqJgSQettib+sXSU4ORWYo7kcEWdBKEP2Es3dkB4KUglsY1TCOnSQ6Vga14NbT9uww2lkUaPOsBXwOAsQ9beL+Ibg/OOU6zVltQ1Pep7FrQVGWD0az0AdN0hOSHf9l1owGdcR8jf+p7D7mHsCEEOdcf84kYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzhSjZR3ssEa+kzgWvael9VZ/HBN1Hm4LjCR8k1mbLw=;
 b=YIaloYfNtOUPDRCstld2pocdjtNhTqjGH+iUOVHfDVeDRJ9bvJ1t3od115OcsImWzi4F1vHjKzHoSzMswpMvlo6zMz7fI9Y9AreRSRw93HaalkZ5mTfKkUisQnFjZ1JVGuEn+VSuGb82IC7ql1IJTXidUztapi4q6L9ruS7hIfelsrL9sx0mxfjbBd9kYFw5NYexbNTs7lzbzxrbsHfCO8f3xyC7a9PXjqsBG0q6Hkkvy+m81MFGO2ecC2e96GA+M4bAB7viawcj5q7ehVR7LOa8/x1rFVDn4tNwFpAKOe0PXhCmlaCnMUqLaqrGgnWaA43R6UQIIA4UVkYCJUy5hg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 14:45:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 14:45:07 +0000
Date:   Fri, 25 Jun 2021 11:45:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/core/sa_query: Remove unused argument
Message-ID: <20210625144506.GB3001725@nvidia.com>
References: <1624624257-3677-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624624257-3677-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:208:23b::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 14:45:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwn4s-00CauV-7h; Fri, 25 Jun 2021 11:45:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cf0d6d-3e09-4cb9-4d52-08d937e7d34f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5318C4993D04A2CE6FFAD189C2069@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP7oheAjZgSuWdBg1JfkF4Q3IAbwDiwDgE1fUoquC7f/8Pj5h3/lU1oOxc8pgmVodWjR0pPhrgHzg8GP6ubeHvkhNUqUurobQ6wMUy9f6pR3lH9soLfn9+QiDStoD5uYGLtTZqZGxyH/EhOBKCo6voE12oUCOh80DCzNjZDRSxPZO3oOOX/5n2ZXuKupldMSihDhrAlhDhqJWY5Kw4jjRBJDb3x8Np7qsjV1jQ8DEN/FfJ2L/rGAumyj2j0YVtXrdFZXlYSZSv+Z6oGrXufAi2V+F4ACZOWzd9JKsFSrOWGn54wN+4wI651P8HFgDp7BSzmZy9G90uwJjp36U5ygIJ1+NtTWONbT8aMogOAAlUPtw0Vaa+BAAKfjOsfkN7Ra4ygYtdx5iHrnhtDwc/v2dN6PIoh/DVLjQ8IuCqwChU9t/oYhQmFKZHWomz5f4cEBgh/c28ikr8nuuHTpqLB1USE04Fyg4vzYsKUW3Ua2vuWVTdomNXnovKYQm5zsjXjnP1Wcez52mOd7by+RWy7ibXGCUHwvuMRCmpqgEYIRTMu3Gj/cDa2z7X6uOov0BnUSsQ4RiaxC3L6WKCDsOdA82NjMnideSrs3GE7ZmkakR3kKHMEGFQmAwttz4m5dJdlKC5CeGW3pUWewORwjeYwk7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(86362001)(83380400001)(26005)(4326008)(54906003)(38100700002)(186003)(316002)(1076003)(426003)(2616005)(66946007)(66476007)(4744005)(5660300002)(36756003)(9786002)(2906002)(9746002)(6916009)(8936002)(8676002)(33656002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hJRHc0UUFnVVRuNEM5UzhGekozWVNZWXRzaUd0dXBsalJIUlRKMGhJa1Ur?=
 =?utf-8?B?N1VTZk1nVDBhRDRDUzBabXFpR21lV2F2NURYblN2bHV5Vnlrbk80OHZ3NnYw?=
 =?utf-8?B?czBuR09EcVBXYUk2ampvQXdTS3BOS1ZiNDZFWHU3VFpVeGYwL2hQUFV2c0w1?=
 =?utf-8?B?UGpEMm96QjdoVXlsamNZOThuMGk2STRiNUdtSXYvYklYVGRsamY1WEl6bEg4?=
 =?utf-8?B?amtlVmhIZXNaWjZKZG1nZEJoTVRlNlRUQlljamlhOG5BOHNCSGFPQTYvaTZ3?=
 =?utf-8?B?V0trZEdCa1NsT083RUk1OUJFWk9lZ003Qm9vUzFiUlhBQXBDbTVHb2tDM1VF?=
 =?utf-8?B?cHp4RHcvN0ZpQ3I2dnp0TjFVNnNuOWh1NWFISEhzWW5mZTVqKzNCZ0JldExx?=
 =?utf-8?B?aE9NOW1QZ1FWWUE1SFN1NFZoZDUwRE1kNlY3NTFlMjFmR21sbTVyZFhyT2h1?=
 =?utf-8?B?V2FyQkNoSkhDczZPWExraTBETDdHeGZYckRtNVZwSlVSYkM3R20zUjNUeWZV?=
 =?utf-8?B?OVp6MnRmZ1lreUVodDdLbEoyQzgzcElGVkNCZ01weEY1RUI1RTI2ZVpwNlpt?=
 =?utf-8?B?M1cxbzZwZ3hqNjhFSGgxV1dNdVdTcWRGcFdCRHpiM1dGU1VRdzhwcFZ1dWNH?=
 =?utf-8?B?RW9jeEo1SCs2MGF5ektNUVZQaEFSODVUcUpKRUhPVWpYLzBHdGI5TnpsSDBn?=
 =?utf-8?B?Wnh5bFBqYWFLMXJPbDVCeUxaSGs4Z0hyTHgzU2NqOVpNam5TVVpzQThMQ3FQ?=
 =?utf-8?B?b01admFaYlphb2JQd21KL0orRlNZSkJiQnpCeFBGejhvUVR1Wjc0aHVzNTNj?=
 =?utf-8?B?R0hRdTFLbndTeW1tY3pzK3lDNk1Ybkc1UG5peGFuRDZjY0l0QzlJSWhiQnlw?=
 =?utf-8?B?d09mMTBoVllGc1JaRGJ5MWV6Mm5LbE5SQXV3NmEyNzBOL3JiUkpaYUdtZ3Jl?=
 =?utf-8?B?WGs5dXFkbFRQZDdMYU9ycVVQVUFBV3gxclhJT3ZrYWVmT3daRUxxU2gzVmkx?=
 =?utf-8?B?Z1R2NjB0N29xWEs5UFVhQTlCWklWckFJZE1oaUgzeEFSQTdGM3F2Q1Ruc2xN?=
 =?utf-8?B?SnFZc3F5WllmVk1BOG1ra3JubGR6UzR0U3dlWkR1MlA5OUlFWnlEWXVJR0Yr?=
 =?utf-8?B?b0F6aGlNeWc3OXNCZ0J4aHNadWJEMlh2ODh3Um9ncnpndGNOR0VHYlRGR1hU?=
 =?utf-8?B?M0F1QkdOVGt1TTJWVkhkR1VRYVpvQkJXYWtZdE9mOUFDMzRWaElVemRPc3ps?=
 =?utf-8?B?ZVhvTHZjR1NTVldEc2N1UTNyYWJUWi91aWdoTCs0enJQQ2tmdjlOMitUeWJC?=
 =?utf-8?B?MWhWZ25oZW5PcmE5clFURzlzcjU0Zy9yOHE3RThqM2pCK2U4bW5xanEwNDVH?=
 =?utf-8?B?T0t5SStSV2ExeldhK3JSZGZOOURlRk9Sb2Z4dVBwTWtoRGdiRXVSSTlJWFZ0?=
 =?utf-8?B?ZHJJOTlWQ1BGVEZadVU0T2RTdlNvUDZyQktkM2FjRVFOY1gvS1pvQlpTUXB6?=
 =?utf-8?B?RHY3dis0S0ZlYWd0dU0xYmFXcDJZWGlqdnJ1K21sVGZFOUFONHFod3VYYlNt?=
 =?utf-8?B?eHdteWVMaStWQjFTZzVmVHBLNlZFVzVuTUxaNm9Nd3ZycTdUTzFUWUozL0Mw?=
 =?utf-8?B?YVFDSjBoaDR1OEFPQkxHdWNkN05rWmlDcjVqTWRqb3JNaEhDMnBpUWNRbExw?=
 =?utf-8?B?OWVMVC9KNE1IL3JLNFQyUFI2Z01jZmk5UndCb0RFYXUwWllJWE45Vmg2ZzFw?=
 =?utf-8?Q?LyGEyzAqRj7ksuQMBGSzYigAdy6nioSaiLHs94l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf0d6d-3e09-4cb9-4d52-08d937e7d34f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 14:45:07.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt45w1mkhCZ3UDzOivsrPWKArgI/D1QieRFYKuNuE6NT3t1WrgVEkmV0zKMBHX0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 02:30:57PM +0200, Håkon Bugge wrote:
> Fixes:4c33bd1926cc ("IB/SA: Add support to query OPA path records")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
> 
> 	v1 -> v2:
> 	   * Fixed missing semicolon, as:
> 	     Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/infiniband/core/sa_query.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7340635045F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhCaQU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 12:20:59 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:12576
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232301AbhCaQUq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 12:20:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlItTggdT2venWUqIqD8SmMoiL03emOQ/vsT+IZGccrgNfvZ/19WhtqfXMszXmM73G7MHOJgZP4bSOpXVGzKo+sfj37D+JtAF0pnXZ0LAD21Osnl7juFZ+I2K5mF2sA2hxRxBYQFyRicpS2hF/jpSfMAYzDA9kJXOtMMZMKoN6RVffZy2qQ7kDg+YE0S0B3ScG1p6CoSoqJ4kL2UojJbV5SoubpOIKax9CW5X9BtqLKxuffhkZj3PUFhD46XOIXQS5jHOhfUjf96Sb6fmYEtrHMqe6G+yMWobDfQyqRjtkdiqxPwM+y9W8yCvHXJ6C4mAPNqnYnMmwzckqDAsHuwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzN3kDhApIWgbX4tHLb5bYtp3mypOZSptj5XS7fdVJA=;
 b=mF2CUlF34woNVeoAiTloHAAqSu0zspU3gNfaFir1+80Auw2vKGP4koEx/zGqmwArR/JyzF+zNPX7Gac/GRaZCGPIIjW/CVH7xAOOCIpnI6qwoWZEsJyn5W9JfPOfGb+y7I+LVheXLfgJN/a1JWkhi/0rtJDKJQ/kAL56GCd3boM1Don4b5lxjXmqPlaDYZ08Mp1o/3IBUoN/03ISlXt3woPG2j7RjoX0DQKla2t1m3T3FYGrR7UNuYwBlTdqveh7sz5h2yQbttutwrdp0IsLtvnkzLJasjbybBrlmnEuA0Hr48D4o+WFpI3Gvf7NN36LgUYfolmJvmZYegMqXitzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzN3kDhApIWgbX4tHLb5bYtp3mypOZSptj5XS7fdVJA=;
 b=Y/Yk3Br/ZiDh1JBARQUZN4zYI0mIbAc21p12WL2Zyi/aTErvm8hkaJJMaf/erENxD/0Yz8bR8+djVmK8GY0PVJdlCspohczERVv3jFG5QxuZ5qP7MchBNKAMPtCrDsw5bv6G4Ctmbh/ZKliTRx0UEhod8IOQvTaEn3MibccDqKutkq8bxCahbcMLhVMDoumrezgfLGdh6RTjoIlBmNme5iuUwFHMtElpY0/C5hXhXts08/HG09t5FpVvkFlFouvmylqGG0zma3Sy6jou9iVn4Y2y5MPiednqrdhgng5hdTQguHWEH+6ZugeiLihydrpmxWsYZCrk5vBAylodNL9dJw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3013.namprd12.prod.outlook.com (2603:10b6:a03:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 16:20:44 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 16:20:44 +0000
Date:   Wed, 31 Mar 2021 13:20:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331162042.GM1463678@nvidia.com>
References: <1617206973-1044-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617206973-1044-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0376.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::21) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Wed, 31 Mar 2021 16:20:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRdaE-006Noq-TR; Wed, 31 Mar 2021 13:20:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f686a79-c873-4774-4e3d-08d8f460ef7c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3013:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3013081A288E73527EB69587C27C9@BYAPR12MB3013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tQ2L+3i1//v3uPG5UVpukS3ZeELFAn+b/DOSbPVfdLVq8VvAwEiF+OGnEXRRC8P4fWj8UUdUEQSaWc0+V31mrc/rUFdb2ha9h4c0T7dSlJFEaJK5M4+2kKkcqaI3AE5uQuhPXXM6SuOJxI/TaDQcoMOwx9Fa3IVFLGH6+LdoAgLG9ka73dc+rzmUmdoHlp3f/EteUkR7N3pu084aeIwrLlgca4CXLlnoKIBUvFTxxJyLO8Bl59J9vcdM6d+EMCTBg5PFKtAwZApceoZUDqJba7u6JxEyVOYpnxdHGUpuzoiU5zWF+SPypmIGr6ksMbAJYq1K+yWhOtEuzbH328lb+flOiB8PYQQZXcKc+dugXQJojCrfvLDL+bwq5Ge4PXuk/aesoXgM+6ovg4cZF1YkKQyLyqe+iB6CmFCi0niqK0y/b8Se6sSh6xr5DsmAURKsnRcuNkLwzB+ZDyin90OpXAY4ecw4KJSLBhaLUdyWe0blKPerObaUuCSIEP0D1fCM3/YkccXfT6+oh/zXbSQqVoldk0eqeKHo7YjOd4s1AQIfv0TjD2uSiWxknX+hPK0gDLnv3z/x9Nm4grT6DuzFrfEy3vA8ylyLK0faY21K4/gGj4fErSOcs4QYLgnBKNXDTN0V2JDUl9WAQLwUZF784vCA6EzbImCKyCR1Qs899s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(5660300002)(1076003)(478600001)(4326008)(426003)(2616005)(4744005)(86362001)(2906002)(8676002)(38100700001)(186003)(8936002)(9746002)(9786002)(66946007)(36756003)(66476007)(66556008)(6916009)(316002)(33656002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVlCd0d4OGVKQjJFYVdOT3VpMzVYNmlWMHgyek1xMWE0S1hHRnBLRHVmeWFC?=
 =?utf-8?B?bW4zNnZkVHJncmdxaTVUREJxSXFMNmwyVFRLNjcxNXBNY2ZqTElyWW9ENTc4?=
 =?utf-8?B?eWNKM3oyNDc1b001M25VSWRiYWNYQjVSSTN5dkNOVHhrVjFPZTFzTkd2bEE1?=
 =?utf-8?B?dU56MmtpOCtTaVlySW1XQklhUHVnODBSVmQ2QkI1aEkzQXVHNCtIRHMzLy9B?=
 =?utf-8?B?ZkkrVm1BYUFnWFVVNUF5Y0RJZTF2VlpibVgyMksybFVCQ0RPd0VnRCt2RkVh?=
 =?utf-8?B?ZWRxamt2QUhDTGtJUzVzbDY4NysrWjRtNjJIeENyNmdoK1BuNUJkQUcrR1c5?=
 =?utf-8?B?QlZFUURYcHV0QkFQUUk3UmgrclRwS3RMQVlzWkxhNGpNR3NZYkVzbjNMcEF2?=
 =?utf-8?B?SVhJckFITVJ1NmV3QXI3eFlFTE1FOEpoRCsyNUZic0FDcGZnTDU5UkJiKyta?=
 =?utf-8?B?aERlYkhUNlFFMFhINVI3WnpFck1uQm5mNENOWW1JN3J6bFBVWU9rUTFtalZW?=
 =?utf-8?B?SThTeVV6WmxnaXR5VU5QdkxOOERBczFTTlJhZElUNVl3SlBMSWJrNTVEMDZN?=
 =?utf-8?B?aFBycitscnkzREtidTN4dVhKQ3JUajg1VTF1SlVtblgvaHlBWnp2KzFHWHN3?=
 =?utf-8?B?UFRMNm14WXBueHdEMDRTR0ZuT29YQWlBTGIvY3hjZXJWeU9WRjN6Q21LZ2d1?=
 =?utf-8?B?WjRVRG1UcXlLK0xrcGV1aHQ3dkdVUzFzWWdxNi9XLzdGYU51V3N5TmZEK2FV?=
 =?utf-8?B?aHJwdUQzK281QUdvejBZWDhsWjV3SUlKQkNFSVhUeXZyME1ZblJPc09wQi9X?=
 =?utf-8?B?dXJzWjV6NVl3T0pKOHZDZlRPOGp3TmF0Ry9ITkU1aGlsMk1ObzhIaEllcXF6?=
 =?utf-8?B?NXVldU9uOGxPTmdHcjZLVEQvK09tRXRGOUhUNjkwd2s5cDFLUTM4OS9OUnh5?=
 =?utf-8?B?Z1MrV0EwU0gxbk94K0RXQ1FzQndGbzgxYnlMMGZPWSt5aFZoRnR6MXUxb09E?=
 =?utf-8?B?eWg5dGVCcGxOMDFabkhtMEhSZEQ2dmdmQ1FOdnE2b3RmZWVuOWMyelhqTHlr?=
 =?utf-8?B?akdpMzIyTjdIejh0V3Q2QndFbzFXcS9ZMFJrR1U4S2hYTDJIaXNBTkNJNnRy?=
 =?utf-8?B?RE9NSk50WDcwakNSbnRQNndCVTN0dms5ZzJMU3dtQklOd0MvaTRWOEJGanZv?=
 =?utf-8?B?ZVQ5YlJSdFZIVW5xRE5zdms4ODB2WGg5dUNrcjR2eEwycEYrYUN6b0N4bDhI?=
 =?utf-8?B?ZklCRFRFQ25ucGE3VmVzL0RZTExvYmdDOTVCZlVESUNQcE1BMUNqdTIzVC95?=
 =?utf-8?B?M0t5bDJjSlN3M3pTNDZxc3lXWXdGN2o2eDdSTlhHZW9MNnV2T0VRc202YjF5?=
 =?utf-8?B?b1B3M1AxNDBYSTFaUksrK09OMCtkd2RQQVh0NVFIWmdybWNUSFRIOFBhYkJo?=
 =?utf-8?B?QlZPV3FXMkFQdGovRWRMRHlJQ3pSSlp1THM4NVBnK29HTzkzaXNKQUxmRi9B?=
 =?utf-8?B?RFBURUN6ZUc1TGlPT3JXdENaYWZxY0Z6T09YWEZmT0xyN0dpOFIxRzl6ODFx?=
 =?utf-8?B?QTFiQzhNNTVkTU4yNFJlazhQRS90K3lBWmpWWENOV0xOOGhrZ0FtaWgxNHBj?=
 =?utf-8?B?akc2UFdFb1JzMVBmVVhMK0kwYWRuTlQvWEFRenM0UkNCUU56aXUxSjhneEY1?=
 =?utf-8?B?eUtoKzIvYThXM3FZeThwQ2pNVDcxaWRUdnFzbEorNXpnSGN2QVE0eXZ2aGdh?=
 =?utf-8?B?Mk5PRm14TUdzRTFtZHoyMGYrS2lPdUF3VlRzckxiZENUZTV5dXhLMTZDYzFJ?=
 =?utf-8?B?bXF1MVpONFZUeFVqSEZvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f686a79-c873-4774-4e3d-08d8f460ef7c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 16:20:44.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhfDx5sS8dNT9ToshkG8Oz8K+KMsLCStQG2rrEVjPkt6dW6ZL6GSB7rdl1KTdG9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3013
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 06:09:33PM +0200, Håkon Bugge wrote:
> Introduce the ability for kernel ULPs to adjust the minimum RNR Retry
> timer. The INIT -> RTR transition executed by RDMA CM will be used for
> this adjustment. This avoids an additional ib_modify_qp() call.
> 
> rdma_set_min_rnr_timer() must be called before the call to
> rdma_connect() on the active side and before the call to rdma_accept()
> on the passive side.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c      | 23 +++++++++++++++++++++++
>  drivers/infiniband/core/cma_priv.h |  2 ++
>  include/rdma/rdma_cm.h             |  2 ++
>  3 files changed, 27 insertions(+)

Okay, but this needs to go with a RDS patch, I can't take it alone

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

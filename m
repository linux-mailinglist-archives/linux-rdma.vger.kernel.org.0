Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873B139A439
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFCPRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 11:17:38 -0400
Received: from mail-dm6nam10on2131.outbound.protection.outlook.com ([40.107.93.131]:51361
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231558AbhFCPRh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 11:17:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC/FRYStfBtZOZXIGjtM06atQWhtG8Erhu4eZfIBL0Stb/QnSNqK70QJiqg1MUbBbhCJ/klWsHAE3CcWr2YVubQdS+VTY/sEXIwvT8lwazycx1tp4/kyzGI5dwL2xt0Ejgq+k1nxDiYXR9uKp12lY121jkQ6BjuuVZGTIMTgE3zyNTI5aRSKuNi5fIiWA0cVWv/Ng/48EH53K+FakSRNGQ2DW220dfISoravCoUs1t9Ya0TJq+Im7x+lDlK7IVRf6zo6S8jqFQgyVr0bklDj0CZWYhcRlXzEtJILfbLyVL9YiFPxVId+DLpN0j70dMXyNkxnQMTemCbX0kscp/HysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxxuzkwZNnwDHFACwb+r2dLayp0qq2je0jFZAc0vCA=;
 b=ZM/NibYHPGqwV2oQzToEqJPefgc0AuhEIwQbZk0tsIue39lHYR6v5N2XIB4R5yG4qUAh1cJlUFJ1/hlVYH+n2uu2nx2AoJRAvg+62YlbyPQaexh8JFYseI8vLIGsOescT9vaBLAPMqGSC9BbTGhj3FUj0EeUqeA5fJoVnvfaJ8lSAJ4/Vn97ayrrKftjvK0ZrvvzdP8DTo4SNVLsioWeRpd7nPMSMbDp2s26KNLLxz7eFPSSzEXhl5pNjJTtH0QwGPtFMVS85WARJ2xoa23/uFTMY5Ha/Vk2QbgdQg147pl41IgFXInf0bR4vyfa4XPWDzDRqfsesHsGopI46J9Gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XxxuzkwZNnwDHFACwb+r2dLayp0qq2je0jFZAc0vCA=;
 b=I3KA4wTmOky35evLDT1CLhRdjdcicYeGW8kLplprEG8BtMUqyVxJ8UpDxLkjee8qhgUGdJhu/RZxdwQxmahYd/pouEvSaDKxbvbjEbSCx3DnMN961rDPwglpWUT2/3/4S8kGsNYFjuIt1gRaYcklZjT7fTDQjGgo0zFtb3Q5xsR3DPrmw16S11os2Xw3djGcyRakxS0PbFI1lniDfxociPZ1MApJJN+jeWu7nwZ+DME2cKJr6SgMW2KyA0RUwFbHbtQnuRIP2ZzJiwrwZIDg0GZhobZuCPMGK0/FOIbyRmZnK+N2rirtDLmqCN7LplQNWMmNGGM0/UCoe0t10KGM3A==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6486.prod.exchangelabs.com (2603:10b6:510:8::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Thu, 3 Jun 2021 15:15:49 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 15:15:49 +0000
Subject: Re: [PATCH rdma-next v1] RDMA: Fix kernel-doc warnings about wrong
 comment
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Sagi Grimberg <sagi@grimberg.me>, target-devel@vger.kernel.org
References: <8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <bf541aa7-db6a-e553-5a9d-a95d19440520@cornelisnetworks.com>
Date:   Thu, 3 Jun 2021 11:15:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BLAPR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:208:32d::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:15:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eafd12e-e1ff-4076-c759-08d926a27823
X-MS-TrafficTypeDiagnostic: PH0PR01MB6486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6486AC904AAED2EADCD06306F43C9@PH0PR01MB6486.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMrYCF5hYANIcCbGTq3EXBTzpi9UmuGxnqbZr9KOmvAFxNbi71GIkY0MVtONvjj0JNq3QHkmeILuVmAyvijWgn4/4Yu1SpbmDUXaxDm8NbZ/Yc3OXTJ5GQ4v4OfGshQqgb5lnFND7troZzdimqh0yc7b0UB3ojFPdVn+2rRmaRyjA0d5p4TtnCk3RwZCHzRDbADlA2Jzvz12fVQhOgMr8rjCBm30VcL6LnngVwflOSgjo1+zPnko5OVQ0gHL9mWf0pz4W6uCJGhxdDJ1lFK3ePo/ZTRYF58D9a2RBQJJHypZACE+BdPXbqeXat+PBfcCS3osDK30YI4JVE3acZkaIQqBfTDrPbFwe1BP+3zzmFNmDskJRuqVhWDhleDwZQtHyS5l+Xy5b55DOiALxPATuEdD9rmI/d8gY+9qsf3ZsxyoUeRomJKhd3e3uBrGb465QcPod3HpfBoHXvdHArAonitlGp/0NU43IyTAqxAZNeawjw5tM/8JQMwCQ/d9qPayJfMbU5ts9YkN0dCTtIzUOCtF9jOwbEOh9NcmPv/O7Y6P9nQdeBQ1S38WOy3fTxvQwTssgYfE/FANxh67eWRUpxmmwRc+KdIjcT1ubQBrhjAi4DquPWBPfG9aPxesOwEzLGab+Z9pt178AlFAz71qb8+7heXgB2qti1Ri/HwBpMQaJeat3Q3IT/7XTKzRtf5h9wvTR4it9lKLqD5ujgYtTCsDFoak3Wbm3PKqD2e9gwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39830400003)(186003)(16526019)(7416002)(86362001)(6486002)(6506007)(8676002)(44832011)(53546011)(4326008)(478600001)(2616005)(956004)(38350700002)(38100700002)(31696002)(8936002)(26005)(316002)(66476007)(5660300002)(36756003)(2906002)(83380400001)(110136005)(54906003)(4744005)(52116002)(66946007)(6512007)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnpnY3hSb2k2S2RKcytkVVFlUmk4T3dHQ2pOSmRJbGswSzh4VG5sVzJ5eFZQ?=
 =?utf-8?B?RVZ4ekhuYk5IUEJGTUR0ZS91RjBCQ2dMYXVEYmllb0lVNzZsRWhxemloVjFE?=
 =?utf-8?B?NC9EQnlTZkJwckV1RHhhODdGcmE0WEJOSnJqOVpMTEd2cTU1Mnp1WStIOUJD?=
 =?utf-8?B?ZnRHOTZBNVoyekdwUWtZeU10T1d0djRuZTdxL1k3S2tYanNRRDd4ZE16bkpo?=
 =?utf-8?B?cXhpcTFPVWNTRDB6alRTTE1jWExVT2JOLzZHTVd0SVREV0hlbGcweTYzLzJt?=
 =?utf-8?B?eU83UXhCK1dvRGdQYlRlcFdqekhLS2cxRWhyd0tNMklIQXF4OXNrQ1huN2x4?=
 =?utf-8?B?ZGFNQ3RLUHprTk1KTEJyRldZVEdOR3AzREllcE03RFZvNFJpQVdhTkxqaStN?=
 =?utf-8?B?QTJMYUxNN0Q1bnBsOXZ0TVdMNDVUZ2lzQThpVDY3QlJuT2l6WHRyOXR0V2Rx?=
 =?utf-8?B?bFRPVkZ6N2J2T0RTYnBoWUZoeVg4UUVDbkhLdE92bk04Z3NtdFZWMThyUGdo?=
 =?utf-8?B?V0J2RDFuK3o4WXBKTythYXZlTy9xdEVMdFhnSWVUTk8zSldkODduVDFxaVFz?=
 =?utf-8?B?R0x0eldNY2U3N21jeEd3bE9NRW9ySmgyMUMrUFFjOW5CVG85WnprZ3ZMQUdX?=
 =?utf-8?B?Rms1anRsOCt3RjhQRVVUemI1eFVKdXBXSjcvWEhhM2taSHBORUs4WURxNVp1?=
 =?utf-8?B?a3c3Rk9naHBudi9iZWprdXJDYWxHRFZyb3FGQ0hrbDZraTl6dTRxeGhhQ25w?=
 =?utf-8?B?dWd1cGpPQU8vL0MzQWJIbGt0UzI0d2RhNzJwV3NuWHFKZFc1NWNmYmRmemxq?=
 =?utf-8?B?b1kvTXpPbU9wNWlRcDRpSG9lSVR2Y2xaSXd6bms0K0ZyMHFkOGhDTk1WOHhE?=
 =?utf-8?B?S040R05SRXdqWjFsbWlTTlkvTHRNMUhlUXY0em1XRW1YN0tFRkU5a2lLOXVx?=
 =?utf-8?B?NmJnVGlXQ1FRaUpicy8zTGRLb1NuOXNNQ3NHcngyUnV4aEVycHFhUGJ0RGJQ?=
 =?utf-8?B?aStlb1MvODZsV3RsTnE1ZnM1M2N0TmlWalJaUjQvWGkrcjBKRFZSZUlGcEo2?=
 =?utf-8?B?VVdhazFJQVFWTzNMc1FLNlM2UjhiMW52UGdPbEVGbnE3ajZUVXY1SXBvaG5F?=
 =?utf-8?B?NmhjZm4vem53U2NtbnE0dldXNHArVk1WNjNHWERDdXZPT2NoOWZ6ZUNPOHk0?=
 =?utf-8?B?K3h4Y0JlekRNWVFDTndjRUhEVnQ3d0p6Nm15Tis2bkJXYzgyKzEyK0ExVzF2?=
 =?utf-8?B?bVFUeWdqRG9PV0ZTOW40S3BtYzJGMUE5N1ZNbmxrYlBYMFVmK21JaDNzT2h4?=
 =?utf-8?B?Ymgxa0p4Q1JMdnhoSklEbXRIdit2KzN5UmpCWGxpVU4rZ3p2MXFZWWM1dktH?=
 =?utf-8?B?VWNyRjh2ZHlBTWRnRldLRmJ3Mk5IcnV3ZnlONlE2dFpmVnFtL203RHREVi8r?=
 =?utf-8?B?MGhramhoQmt4Q2IwWWJ5Ui9iKzZxcENxdEZ6NTB1ZmdTcVJ1ZVdqanZMU1RM?=
 =?utf-8?B?ZE1vQnZZUFBHaVVBRC9jTnFKemJVMnRuL1F4Wmw3K2ljeXFpcVkzNGt1aXlr?=
 =?utf-8?B?dWxuSHZsdDBNaWd6QjVJMTEzSWdKZDNPZ0c0RVlvckJLZkYxME5NbURxWUFN?=
 =?utf-8?B?VEF1SzZmZDlYRkVFZWUyUVNTVkoxOTgzUmk0MDdzWjV0eTRSaE80WEVKMDZr?=
 =?utf-8?B?YW83Vzd1cllFY3BlOStSSVhzeFhzWUNZaU0wRlhqWVR3azJFalp0dWE4UFlq?=
 =?utf-8?Q?f0Lahz3RK48gzq40Cha0NvqPNt2p8OI5qR/mbhw?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eafd12e-e1ff-4076-c759-08d926a27823
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:15:49.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud3wsw/WmV2je5BZsGSM9i7Mr/nOx7T35CVRpj6EnO+9eVI8bCNdS/Z4UFwp+r7druK1RU2yTd9iMvrEcXAGWLW4Xct43ZGZwQsLzEDYCe7KmPOMmwBPKVBufgH6MAzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6486
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/3/21 9:16 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Compilation with W=1 produces warnings similar to the below.
> 
>   drivers/infiniband/ulp/ipoib/ipoib_main.c:320: warning: This comment
> 	starts with '/**', but isn't a kernel-doc comment. Refer
> 	Documentation/doc-guide/kernel-doc.rst
> 
> All such occurrences were found with the following one line
>  git grep -A 1 "\/\*\*" drivers/infiniband/
> 
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com> #rtrs
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks for doing this.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>




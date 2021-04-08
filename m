Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A1358351
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhDHMbd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:31:33 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:35296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhDHMbc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfZ5eY9oIxkgPYiqiJJGSS2VaXbVVdLyN+U9cDBCGilYlX6PJWdmlLkHy++WGONwj+tVMD995SNVGA6HyA6cpgelIsnCI669rUp0L//TJffWEYwRNwbEvmU1aUchpjt3ZMkEmHt+MzpJGxQJAmv6GTzS4qs8nTc6SoIAHs1p2HK+wxhbzxK36m1ki+aMqgnC5Pc0Gj3TPLhLVCNr9qSe5qzWpdOAZRiCN8NMRaBskzpWByBbVnMVs8vZNDevTxvZ90PqovqK0b7MKDmH8mjwNNJrqxmRct+1QraB9LhDe8hdC7GasoTzWXExNiBO6L1+pwdeOyjmAfngf1BfbW2s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D62p/NFyLmEGJXdusQ4V2gaymhrb0WBGXVd2tijX8Ss=;
 b=cncrZDDmtELvo/zFsxCM6Lugy9BIlB4y8jd72S1KbBzq1/BeIK4vt6TADngxa3VCIS2fWWoU0IDmiSp3VIa1II+rksxs4wOK+/L/AGnRmFDZGo22tHZjrcHrNLVzeXIafqSsgw5sVxkoMICVEWwQVaXBI4z6nrcr1jvkMJkPC770nPv1NN4uSn1RT+aTsJleiwTurxSm64Ghp5QBaicTvEaw2Y8es1NiXD37Et48x35aRbbOWT3RunQ9tdEtZrgsWHuGidMsGrUVLNycpm+E6gcjPCAJUtw58+rltEG3Avndc6yqz7Ail5IZEdiaSRfVrilDbSiP41PNi4X+47rOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D62p/NFyLmEGJXdusQ4V2gaymhrb0WBGXVd2tijX8Ss=;
 b=lr6vNips/Eyti95t5rOoFs8K23iVj/w8SYPNEul9fiIH2N0ZQka8NN2/ron615qnLYvIkzhPOKPTTHP8bCsHIu7UdTIHPzxQyFJwQcppyohh6H5oH1UrkXjzyuPWMzXITlcwGPKFp49l9C9/cyhVQE4khtyy9GS/f+jFNv190tRc0p1a8+I2BoTkrbIJOH4xIGHRku2pb/qmCQUsPAgmwTrVC9XEVk0STkMSEOgGIQcrmyG4vKlysE5NTs10GP+lepQ+1shdR5vF/RmHmgj5EKxDTzj+ZDMMfJwoE9ceESg8LTBNmiVykGPJ3lhsSZFV/VFPongW7Nj0NCQkgIevSA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6636.prod.exchangelabs.com (2603:10b6:510:99::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Thu, 8 Apr 2021 12:31:19 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:31:19 +0000
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
Date:   Thu, 8 Apr 2021 08:31:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <YG7ztT81z8BZDkUj@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 12:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18de1426-b2e0-440a-6b87-08d8fa8a35d7
X-MS-TrafficTypeDiagnostic: PH0PR01MB6636:
X-Microsoft-Antispam-PRVS: <PH0PR01MB6636B0524BCED06176B20E2BF4749@PH0PR01MB6636.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptho8rGj68quSWNGtuFd0syS3BtESjq14A9ZkTpF2gAwqR1AArDzegibzn6VPWYGEWBNEt3VbfFWTYl1uFxYY0tZ7WSMupXpGA+S+1DFbAn5X8lyBi1a1qXuL2/V9NxcjoC6erNm/wnlH6acOqJQ7v+ii1DkRKk9Es1uLovBg+hEM5scCKL7wPNCUby77G3dfKPVCN5kEoVjmm5gsdn4rgoGuUEfsySnKxvl9+bmt6HKZXeKmEld3z3noBVcas1xFBCr3ZdTPrgZn0ATLEMTyFpUE9M3hI96SbEAVFPeVhKQeVtoFW0Etxml++WO1WYhphVR6SoM7Fy2WbNkjqUpXDqcT5yt6cwc3nR3lsbC8Ip0foaEPVrfFUiDsycXYB/lhpdoetuppegP4NHUe5mqERkWtfBpeQ7YlZFuG/8y/bH5ctcnVd49Ktt2odZ6eqGIwPPyqz0cd5icldDAZ3OEgBIriy+LA7KUFfDzor0ALCgwvD3Z7iVMlKbbEC72YaDVAEwpnY5vCVQ+z6ZZUpZSfPgFwUumQFkKgSuJweYFUUel9UV3MTX9AmlcPvmcbJNrU95I1AB/ElHklFZqCyO7X+FvK5n9VidDepqmhQ6zLfYzfbsPy7ZigL1w+rXMD4MKG+35+ee0j4oTZGVbCfs36I7NgdtQPGz0Ma0EHSfnejBq9VDMKpAJpm8swQy+gjvVK4oDBzIOz0XQn5gJErdKXQWXWsvR9PisNhTifsa0M1ugwtYteVUvG4+AjOVtSxAj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39840400004)(366004)(376002)(136003)(31696002)(66946007)(66556008)(6916009)(44832011)(2616005)(52116002)(478600001)(66476007)(956004)(86362001)(31686004)(38350700001)(53546011)(16526019)(6486002)(4326008)(83380400001)(6666004)(8676002)(2906002)(26005)(38100700001)(316002)(5660300002)(36756003)(186003)(16576012)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2RWQmo3V1dyZVI5R2toQUh3aEhnS0ZGaHhudWV2WmJ4eFpwZE5hSHVXZU1q?=
 =?utf-8?B?V2NaK1lWR0dMT21FVnJ0L1ZycmRvQlBNSlZjZHlNWFovMUtQVzdFeHM0aW1u?=
 =?utf-8?B?bVRKVUZPeElyeVRDcmk2cTdkenM5a3RWZ2dhTXYreTg3SU1JdWY0ZkQvWTJC?=
 =?utf-8?B?SGlpYWcwZXA4Vlk3dGFheTdGWGo4cktjN2xDdGRHdkxNTzRGNVRpRGVxeis3?=
 =?utf-8?B?eHJGQjV0U25GTjE1QS9uSEtINXdlcFh5YVBEMmJwK3RWQzlRYUZGb3VML3lv?=
 =?utf-8?B?cWxhL2VhMFZkZ2EvOCs1d1p6NVBadkk5dzU2RFhpek5rSlY2RDJZTzFxTVRy?=
 =?utf-8?B?SXVZSlM4ZkdIUHA4Q0dGU0ZjUjhISnh0azFVV3hubjJrcU90RUxnNHpUOVVR?=
 =?utf-8?B?MWVUZEEyODNQczFsM1VHck5qSXk1U3creWJrdGJZR3ZBSHZkY3dwdnMzMkJN?=
 =?utf-8?B?WWFNUTMvMVpRaG03ZDRPNklFUWJ5WWxmRzUwd20wTmFtczB2SUZGTi9ZZEc2?=
 =?utf-8?B?K0ZZYzZjMVBhdGEzSjJlVDNDcWNxc0F0bm9qcUFUYUVaRExlZmVKOUVoS0FM?=
 =?utf-8?B?UWRVV01lYVhOSnluOStyN2hvb2FJMS9UMnFFc05LN09Ma2ZRK0t1cjJvRDNI?=
 =?utf-8?B?VmRQRmpzdFBmUTZZSG1YT3d2cmQ2U3JGVUViSWhKeE9MUS9QWkRaNlNkQ3R1?=
 =?utf-8?B?QTloblJLUXhNbTN4blFDb2tUSmprbVIwbTJWNFBlQjRwZndQd0Q1YVZXSkhL?=
 =?utf-8?B?QklkZ2t4WUIwbkpXU2ErTTBWSWVVVWRScnAzajdFdW9KQkUvelRoajAzdFcr?=
 =?utf-8?B?MnlXMVQ1YTZGVUx0V0xvUGhVa0VDdmo0M3o3WkszLzVkTmljNkRaeWR4bGdB?=
 =?utf-8?B?MXREd0p4THUyS1VUQVpaMUs3NWNWN3VLWXFLcnIxTUhjNmsxdUo3UnRMUk9h?=
 =?utf-8?B?QVZhZThRSnc5ZE5JRjh4Z3lYL3c4ZWY1NTJkb1F3VEFZT1drUEtieW5LZTZD?=
 =?utf-8?B?NjU0WWhvYkxlZEpOUEkwc1o5WlFNQkZrSnljcnpuV2NmYkVuSzNmNDZkbmln?=
 =?utf-8?B?empUUGdJMVVscWZTeUZaSldTODlYNjB1dWk2SVhBUVplelNyVWo4dndtVk9v?=
 =?utf-8?B?dDNKRDJXTXlaTTRCV2JYUW1xSVlxbHRUblZFaVNTQzJvTU14T3JVZy9TQWdM?=
 =?utf-8?B?MGZXVDJZYnpJZFB4WXprUmc2aWhqc1BaV01vV1BJVmZWMWVmbGFIU1ZIbWZI?=
 =?utf-8?B?VXc1U0tyaGVqTFMyNDk0WnNsU2d3Q0VHbHNlZEF4Wlgzc2dzUUhXSmxUZ3BD?=
 =?utf-8?B?aFlwL0VleGNOQjFuQ3QyYlZyWE9LQ1A3UWNZUzB3VmcwUElQMFZEYnIxLzJI?=
 =?utf-8?B?dFVxcDBSaWJNNW91ME5jcFAzQUNMTzE0MzMzSEg3Q08wbzM4alJ6THIzOFpI?=
 =?utf-8?B?UVZqOGVQMUYya216YiswdmNRWmFmUHkvWDZpd1VTaEliUnJUSlBFOGFaYVhI?=
 =?utf-8?B?MjBHaEFleFRPZGFtZWhEUWlYWXZmVmhCY1NzcEs3N25nRkhTcFpYZm9mcUpF?=
 =?utf-8?B?Smx1a2FETmlGN0NITVdWaVlVVzZmazU4dFJGaTlSME5PMGtydHdadXp3WTRw?=
 =?utf-8?B?dS8yZTdUOGs0bXcvRWMwbXpoQXh4VnM1NHQyM2tEWWV4VVEwbFFTaG1PUGRG?=
 =?utf-8?B?bjk2Y0g5ckV4NEpRbkp1YU9uQ1BaVUp4WmpFOVE1b3J2WHpTeFpPckRRZDVQ?=
 =?utf-8?Q?+Mc7cSXcc411RjC71P1+mDCa6W9DnG9WxR83HrS?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de1426-b2e0-440a-6b87-08d8fa8a35d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:31:19.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB+MELIsUvz2TjOzwn7BhgxI+wfm5AJflczuG6tM1ELResVX1DNZLbCPs7bS0TcBO/krgWKq8FBD6KWOLJhMbQs1KfanDeKEmTBuhEPlRZ4efXP4vNFWOuefdb+p1u1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6636
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
> On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
>> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
>>> On Mon, Mar 29, 2021 at 09:54:12AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
>>>> From: Kaike Wan <kaike.wan@intel.com>
>>>>
>>>> This is a follow on patch to add a phys_mtu field to the
>>>> ib_port_attr structure to indicate the maximum physical MTU
>>>> the underlying device supports.
>>>>
>>>> Extends the following:
>>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
>>>>
>>>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>>>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>>> ---
>>>>    drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>>>>    drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>>>>    drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>>>>    drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>>>>    drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>>>>    drivers/infiniband/hw/mlx4/main.c               |  1 +
>>>>    drivers/infiniband/hw/mlx5/mad.c                |  1 +
>>>>    drivers/infiniband/hw/mlx5/main.c               |  2 ++
>>>>    drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>>>>    drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>>>>    drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>>>>    drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>>>>    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>>>>    drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>>>>    drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>>>>    include/rdma/ib_verbs.h                         | 17 -----------------
>>>>    16 files changed, 16 insertions(+), 18 deletions(-)
>>>
>>> But why? What will it give us that almost all drivers have same
>>> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
>>>
>>
>> Almost is not all. Alternative idea to convey this? Seemed like a sensible
>> thing to at least have support for but open to other approaches.
> 
> What about leave it as is?
> 
> I'm struggling to get the rationale behind this patch., the code already works
> and set the phys_mtu correctly, isn't it?

I see what you are saying now. Kaike, correct me if I'm wrong, but the 
intent of this patch is just to make everything behave the same in the 
sense that a device could have a different physical MTU. The field got 
added to the ib_port_attr previously so this is giving it an initial 
value vs leaving it unset.

-Denny


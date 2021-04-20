Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525CA365900
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhDTMfD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 08:35:03 -0400
Received: from mail-dm6nam12on2114.outbound.protection.outlook.com ([40.107.243.114]:49921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhDTMfC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 08:35:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYwqBAQOqDURk1C8NJtv897yq7Iszs3+cMYxvruCW8PFtuXiHB4oqf5bHUKN5mde+WtfzVVRpPrbCOlSmmMOEWFZGagk4UnrMftd4tBEsNKIhd3V1FRd/COuYK//02LWm3TaZPFdtPRcSgbJigUG+V+/9vzeMCbuOIZY9+rwxTknIe/8pPhiHYtb4Jk4tD//g4axTwItMwXNfh7uoWymC8kKbe+dYZTfpMqqQaXFxM6r4iTyrHn/9j1rGccfkSf22f1pV7c5netTqSiIMjhcTE07Wm/0mcro1gJ+SiQcFhAsD1FvDLu06PnI5cxyqRppVNdBIU5ec0J+8obqnjtF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw1Zllor/s+fTe+gpXfz+xqxy1bmt/oGtT2mYyOn4CE=;
 b=Tj29nWhNXXWJ44AV7Esylk9Cmin7wjAQEgiOA1JKegE0E7MoJuXehc76IgR2G1/gWoiL21Q3nmDuzoaWuCNr4iJD84d653nJGd78OdZdCItODnubgV6l7c763+ss8kk3y/W3XZR0Bj4udDPQuFA95mKtBVPz9GAO7wUunD/dgqf7QQpBKXfjlp2QTCwWlaHoFuykwpXeB7HeYq39DuaJEPmpshUL7uQnT1UC0oMWTXCOXbtRn6axB9RSkfBZTH2UCaQmLTAHjiN2cDLj260BdhFp88EfOiAflAM8kZDmfhlxuAGG1UvCKfVzn2cS4Qw0/B7OwoVUnBS95xIefE+I8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw1Zllor/s+fTe+gpXfz+xqxy1bmt/oGtT2mYyOn4CE=;
 b=DrshsRAzYVqXW6M8tYK7spHnFmD5UIr4f54ZKwjjoAps8EteHGi6VtRn+7KYVvjA5l/qLtdOsk76vjgIUPi/+ZnaN2u5fRHiylPdZjYJmP2l6ULBi59jAHlJP4/kfqlVpD7/PR+g19+Dw/ObHhuqQnxLA9HHXahRlPz5ynigG11mt7Yok4CDIGKEcXVbd5kvq6pmzDX3Kzar613yWhTD6reN6s3mKa61VQlLmDF/a+h+33tqcrGXVfFa6e2DWm/KwpvzlSLuyc9x50zQa0bLATddj4Jm3VOnwJdvxHM0+qqjX6VQHBBuL8USv7xeocpBbbbMYU/nJumIojpKD2ouyA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6374.prod.exchangelabs.com (2603:10b6:510:1f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 12:34:28 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 12:34:28 +0000
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
 <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
 <YH13p0zRz+M9Tmzz@unreal>
 <49397542-7015-5e8f-b473-49a124dd4341@cornelisnetworks.com>
 <YH5ilM02U4cuYK3x@unreal>
 <0bd262f3-0eaa-b508-2a01-5ad89147538e@cornelisnetworks.com>
 <YH7Jm2mME5brV/uv@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <2056c69b-9a85-6488-9abe-edecdadf2071@cornelisnetworks.com>
Date:   Tue, 20 Apr 2021 08:34:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <YH7Jm2mME5brV/uv@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:208:15e::35) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by MN2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:208:15e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 12:34:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd79abf-0b9d-4750-f36b-08d903f8a3dc
X-MS-TrafficTypeDiagnostic: PH0PR01MB6374:
X-Microsoft-Antispam-PRVS: <PH0PR01MB637408E2F2469A7EABA2AC91F4489@PH0PR01MB6374.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNPcZ1y5lGVHnm0gzBJ7y1hMNyxGzGWeNT203Ypugk+h/Uro5h5Vbjzknmq2zVR3A7LczrCiZPKT30TLXXdsidNVLGapilTHiRfX+nFKVaruOByr/joYkdXh5lMHRkNf39nHvQN2gJA6QNipeFGXB1HoRovzCaazKn4PvupIZacUk3fz+slpgs+8fLsQm7Xy30OCC4lLa0Cx3WtPtNXZopHSainZi3KlNwOIzHFo3bgNZ/V0VAfJZHKMCS1dJJF0abUNJveV6A4HDW1N8QP8hUQUqeKrnk9fzEfStcQv0VhrWW6MlUvuNJLOxSo8ZEz1LHMTYnJ7Ngtx0+dYJYxTst7+PBrOJyyHz76uyysU5V5RJoSeUqlBkHGcJKK19oGGrdXsh2W3GUs08f9WGYaDQFk3MGDjN9e8qTstlFUfmDnpmGXa08zSUe2tT3va6gNZpedbda9Ks3doU623LKcZvtOPzh/QN6L78z9sGLA2xTIR8G1y8o/RlKxs8CvdUEIt2SxQbjRAdWJwqf1JedlyG4F99QathxLvgGZYpx7UYOX5iCn/yeQEqCJfTarGQ7vyWIVzVfZFtI5+szKDZunCdIjL4DmAPoyX1DsBig7uqibUMin0/NskcauJJjbvfspS7o7HGzJpFtgLqY/9JIkmMVP4kmjVv3TM7DHYuc8sTbVXsRyidp9HZpYQHK9UU8NUCSlqQ14pmeE5rlglhdJH2Rv6hLqRcYQKdVzB3AaGVRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(66476007)(4326008)(66556008)(8936002)(186003)(316002)(2616005)(26005)(86362001)(54906003)(16526019)(44832011)(16576012)(956004)(38100700002)(6486002)(53546011)(52116002)(6916009)(66946007)(2906002)(38350700002)(31696002)(36756003)(8676002)(5660300002)(478600001)(31686004)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFRPcjd0OXJmd25kNHlvNTBDYkVEVkZQUGl5c2tQc2tvZkU1T2RQd3lXQmlK?=
 =?utf-8?B?VXQ2aytxNm43bC9zOFFMY1F2RE41NGRsSG9Td2Q4OXkwL2EvMXkwZGtsQmRw?=
 =?utf-8?B?elhLNUNFMWZubEVYNjU3TWNYYWxPR3Z4cjVGaWlFNHI1UGNIWVBBQ21md1pH?=
 =?utf-8?B?RjdONkpKbnFFd3hhWElaQVQ3MlFlZisxTWx6Tk05ZGNzOEcxdWlXM1R6WGIw?=
 =?utf-8?B?a2FEdnhCd1lTL3dYdC9rdmVZNU1pNm85Um5BNjJWR043Rk9kRGZJenVHVURa?=
 =?utf-8?B?U0g0Ymg1S2FJK3lvRUxaOEVhOEtCVXh5RHA4aUxMWUhQSndwRVZwbU1vSXdO?=
 =?utf-8?B?YWt2T2RsR3EvQ0hyMk41cUhYcTFHS3loV0RQMlBpL2E1SEYvN1FJQk9SaitC?=
 =?utf-8?B?dXZ0NVUyU0NPYkJycm80L2NkQUU5QmdoQnFIeHNwaVAzL0M1UkJ6eEx4cDly?=
 =?utf-8?B?Z29VbU5PZ1gxZWJ5VkYvNGNYMjV2a1lrWU8wdlZyYldWT21RWXlROTg2Z28v?=
 =?utf-8?B?UG5iNE9nRy9QNklTRnNEZzMzd3ZBMVk0emZRaXJKTjdwSkM2ZXM5bk9KYm0v?=
 =?utf-8?B?ZUFLc3VaNzdpN20zMjB2ZU9PdUhuN1lvRXBwNWlNbDVpckR3TUVvLzUwWk9P?=
 =?utf-8?B?TVRJMVVKeFBFblBZNjNtdnB0TnVhMVBmWm16K3dYeHJ6NElYdG9RMVJLODBs?=
 =?utf-8?B?eUUvV3BwN3JyWDJScUhYd2F3dlhpRGpOS2s5UWZHMTRqV3BUckdCZzlGbEkr?=
 =?utf-8?B?WmJzaXE3ZEcvelV1UXZTYTd3cG1FYWpQa1R0Rk51N0M4WDBqbWs1eDZpVDNL?=
 =?utf-8?B?TzNHdS84R2dsa1BxMmsybUlIMFJNU2hOZTQzMnRhTnVnM0tRVlliTEtZcjRQ?=
 =?utf-8?B?VVNZRWZzVEhibGFaZ3BkMkJKY2p3NWtaeStZdi9jR09oTWp4alpFdVBHYkVu?=
 =?utf-8?B?c1c1V211dDRjZ2ZSeGpsZ0RlQ3ZyV1NteHdyNmVUQkNRcUhla004ZWlBOFVS?=
 =?utf-8?B?Ny9IMDQyLzFraU0xbWVRMm0wcWcyTnpNWWpNc2luUEtRTFh6UitaVUorRzhm?=
 =?utf-8?B?aVdxb3pqV25KdHdyMlRHVmZ4K2RrbzQxbnpNY3dDcS9TY0xHZW5EbmVFZWRY?=
 =?utf-8?B?c3pYTTNJTEZIaTlQTm1jMTFoYW9vSHhBMzhrWFFlVlVZZGxVNHQwZk5YWndW?=
 =?utf-8?B?aDFDcnQ3WTJ3Zldtd2hzdndzTm90VU1CYXNRS1BMWVFPVW9YbHNITzdLZXhK?=
 =?utf-8?B?ZGt6SGJtSG5LUmoxZFJzMitON05oaFUrL2JSdXF3Vjg4WURrbVdVT0NtUXpz?=
 =?utf-8?B?RUIxQnBZVUxJUTIyRGlTNVBNbW1JaDJsbnlIbE94TkwwQjZ3U1ZKbkJyRFN5?=
 =?utf-8?B?SUQ1UzRMUkN1QTRqbGtVdEg1bDBtaGEzV0xYTVJRd0ZlOS9EOUQ5K0ZGR0I4?=
 =?utf-8?B?ekVwc00rSjhhYU9uNXlQM2EyVlp6blRJL0NJR2VIYXRrVDZETkN0NTdHY3VK?=
 =?utf-8?B?TmNmdW1zL0NNN0JYNUxWUjJ1ZVAyY1ljamNQZmg5L2hKbDkzZHZUd3BCQitx?=
 =?utf-8?B?bTBBKzlHUVBLdytuKzhFTVowQjgvRTh0MzJHRGpHZVQwM3RiR0E1ZTlqNTd1?=
 =?utf-8?B?WHY3Z0MrMFVDMWRFY0FVM1ZNN1lSckc1aysySXRBcERKeG5ZSmlyZlJFN2Mw?=
 =?utf-8?B?N2QwazFSdmg5MHNKenFTcFFlWkw4ZndpYXJRby8yWk44T2VaV2FadFdmbEN4?=
 =?utf-8?Q?wlgoeQCXLnMgLa/Ou1PJphnHKMkq3kV/Y2i2Byn?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd79abf-0b9d-4750-f36b-08d903f8a3dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:34:28.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b02XMqN3fCFYfNHHUOQ+XQB92FiWMA+U2Ttgsv+XVPu3IMYvW2tiY3t/KnzTtJ68vkg/07SXtEuIildm7mof3314DkTIMZZje5AwxKmE5PSgPZhkH8p96Jn/vlBlZwqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6374
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/20/2021 8:31 AM, Leon Romanovsky wrote:
> On Tue, Apr 20, 2021 at 08:17:00AM -0400, Dennis Dalessandro wrote:
>> On 4/20/2021 1:11 AM, Leon Romanovsky wrote:
>>> On Mon, Apr 19, 2021 at 09:08:55AM -0400, Dennis Dalessandro wrote:
>>>> On 4/19/2021 8:29 AM, Leon Romanovsky wrote:
>>>>> On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>>>>>> Sent: Thursday, April 08, 2021 8:31 AM
>>>>>>> To: Leon Romanovsky <leon@kernel.org>
>>>>>>> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; Wan,
>>>>>>> Kaike <kaike.wan@intel.com>
>>>>>>> Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
>>>>>>> function
>>>>>>>
>>>>>>> On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
>>>>>>>> On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
>>>>>>>>> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
>>>>>>>>>> On Mon, Mar 29, 2021 at 09:54:12AM -0400,
>>>>>>> dennis.dalessandro@cornelisnetworks.com wrote:
>>>>>>>>>>> From: Kaike Wan <kaike.wan@intel.com>
>>>>>>>>>>>
>>>>>>>>>>> This is a follow on patch to add a phys_mtu field to the
>>>>>>>>>>> ib_port_attr structure to indicate the maximum physical MTU the
>>>>>>>>>>> underlying device supports.
>>>>>>>>>>>
>>>>>>>>>>> Extends the following:
>>>>>>>>>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's
>>>>>>>>>>> upper limit")
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: Mike Marciniszyn
>>>>>>>>>>> <mike.marciniszyn@cornelisnetworks.com>
>>>>>>>>>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>>>>>>>>>>> Signed-off-by: Dennis Dalessandro
>>>>>>>>>>> <dennis.dalessandro@cornelisnetworks.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/mlx4/main.c               |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/mlx5/mad.c                |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/mlx5/main.c               |  2 ++
>>>>>>>>>>>       drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>>>>>>>>>>>       drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>>>>>>>>>>>       drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>>>>>>>>>>>       drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>>>>>>>>>>>       include/rdma/ib_verbs.h                         | 17 -----------------
>>>>>>>>>>>       16 files changed, 16 insertions(+), 18 deletions(-)
>>>>>>>>>>
>>>>>>>>>> But why? What will it give us that almost all drivers have same
>>>>>>>>>> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Almost is not all. Alternative idea to convey this? Seemed like a
>>>>>>>>> sensible thing to at least have support for but open to other approaches.
>>>>>>>>
>>>>>>>> What about leave it as is?
>>>>>>>>
>>>>>>>> I'm struggling to get the rationale behind this patch., the code
>>>>>>>> already works and set the phys_mtu correctly, isn't it?
>>>>>>>
>>>>>>> I see what you are saying now. Kaike, correct me if I'm wrong, but the intent
>>>>>>> of this patch is just to make everything behave the same in the sense that a
>>>>>>> device could have a different physical MTU. The field got added to the
>>>>>>> ib_port_attr previously so this is giving it an initial value vs leaving it unset.
>>>>>> [Wan, Kaike]  Correct.
>>>>>
>>>>> No one is using this "phys_mtu" field, except one place in ipoib.
>>>>
>>>> Today. I think it would be better to formalize the idea though and have a
>>>> cleaner interface. Does this cause some problem?
>>>
>>> Not directly, but yes.
>>>
>>> Before your change, drivers don't need to care about this field because
>>> it is not in use at all, after your change all drivers need to carry same
>>> line. This is prone to errors.
>>
>> Perhaps a more common place to set this in the core is appropriate.
> 
> This is basically what I suggested to Kaike.

Yep, just seen that after I hit send.

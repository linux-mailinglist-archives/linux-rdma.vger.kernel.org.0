Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE133427C3
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSV25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 17:28:57 -0400
Received: from mail-bn8nam12on2104.outbound.protection.outlook.com ([40.107.237.104]:2449
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230273AbhCSV2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF/EoXCUxG8UK4AQ9F7MD1XMEaDI/66sBubhm+2af7f2FlSfN0aDv02rvGUFUp9O6OkTHMfJinM7giJHxk7eYMiLuIKbgEIYxhIxvU1oPXk5p26r2aT1YjZ4BEjn5MgxjAJlSnuvxjvk4Va7mccg4Xvr60Q6MAUuiyyqXZr6bL+3J7CgsJUwUxYO5Kb/RqTOjSEytao2dzSEFI8CQkezKZu4hD7dAmG6UnrOguxjrfYDSEl9eVsaJv159Ble+LSso3jJoMMQdsEYEtE90F+ulCvpLDRYO3/5YmnnK3NBk9euxcy0id7ieyxaZjWtwvlKc68DJIeGHCMeri563fN6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBpmV0hxaBbVjdSVV00FT97ZCrsvY2ZHI28m4MwuePc=;
 b=L2dG6+/MmwIkB/Y8yawY1FXVWjJsEodXVNvurtG39w43MWUyCZk61xvjxKkHppHigKMWB+ysa526P/yNdHN9jWqxT1frtv8707tc5IWnPWSEPhKSX793EAn3FvC9iwAMJ1Aho7TwOChwa4JoHayMFA+EyYqNYXTT8sARC6csnjSnPX7FUqpWlB5xC98TVQWVyzjB6ONk0NL5crAo95Lud8R8tzLrLsghs1CnXAkrniy58p2vdAVXK4CPkuztCkRnOmOa7jXyLT/UafZZiIk7JDmDMjlyYXgVibuch2/CFx0MoS2wXdYnr2/YDTgEzRTbkds/mWXVevGcElyoQhw35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBpmV0hxaBbVjdSVV00FT97ZCrsvY2ZHI28m4MwuePc=;
 b=boYyWgIHGZgDGqmhPYR+ejIfh3o9Wvql5UJAc3InsJYeY/b7AyswifBqTifkA0T1wiCMdhnkHX71hj3MN/OcTrLM+YvciTA1f8FQv21VBeP8Mz4H5h6IVaHGA8lB/NzpPtymXr8romNEnXwNcBqJbXS+I4tDIeeXofsAmUWQZJrjPUo+jKSgI1SSaeQX+dUw5Cj8kjZu9O3uDhRatPNmqwTXqxROaYpfjaRfndfhmuRt6IwpqCseRXSg74C8pXJBT59m2+UU8t9VvKynKVDp/EqL/GfafB9tW9EQQRVUKGW/SVqMuK+O0JK95V9dy/uIzJ88hLk/8kpJR90HeEZnrQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6181.prod.exchangelabs.com (2603:10b6:510:8::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 21:28:22 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 21:28:22 +0000
Subject: Re: [PATCH RFC 0/9] A rendezvous module
To:     "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
Date:   Fri, 19 Mar 2021 17:28:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BN0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:408:e6::15) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 21:28:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fce673b-1a76-4655-9973-08d8eb1debfc
X-MS-TrafficTypeDiagnostic: PH0PR01MB6181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB618160DF706B33D96CD7EE34F4689@PH0PR01MB6181.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P993fxCpfJeCotSZ+XAmRFGMW2Vr9PT3G17vT4H6ZAbvwtrUNBQEXL11hGAOokknjifmWpjOwYKPmUwxgGx0R8EYdmERmzcBYs7cfQi6jllqAsFaMgY+2dx9aH+3U+fhu79B3TCxX9kKfKswcYEgHO26j4G871ceIM6akDkJM3ST8OgtrBw9HW5qi2TNwQztPfgoxZOKzr7GqG2rqjJQ6NNbNEpmaYF3AE0AbzzDwKzX5YjyMFO6i3wX2ISqwnnZMNR/d0b1Enpw882vdhl/+qmvSl/gCkV6uofyN1320w7/f8c7XF1mP1UhFqISAUIVfMrdjM8pKEm/PsJtnvreA3sIMLbreEQJLu5sgauLgz6skeHcWj1KEtrMcyiMSbJY3ya9r4U8ASZSxPX/BwiiP3tA/FCeNI2GH42qbQefxMS1sznJiBgdhUj8LkHZwHTbhIWPFP1SzGe6Hu+u+de6z59YdADmJ9DP+UnX9JkfzNk1RXNT1rKXnOwtxlVykthRDYDVCsytuuSVf7l5LIx0T5weuw0LEdvtq95Eiy4zQZfP9y+IMw7o2Pma9n7884JAjSvAO+vHx6lyKntfsKKUYQUYRrQRYEk4gN/T4faYhbjdL3dCiApwPTV7R2mUDPNKDP0jj1upKvaQTr7Z913pXC80pICJ2CyThf9wV/S431ZvfmwaA+qaPGl1BtZ+s4tFU8FAEE4TWmfkha+hvESMl7MeJwKG3H3HbVr13KRjMZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39840400004)(376002)(366004)(396003)(31696002)(5660300002)(36756003)(66476007)(66556008)(52116002)(2906002)(110136005)(316002)(66946007)(26005)(54906003)(186003)(478600001)(8936002)(6486002)(53546011)(8676002)(44832011)(86362001)(2616005)(6666004)(956004)(31686004)(4326008)(83380400001)(38100700001)(16526019)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VStkcUxmRlRVaFBUU1JOVHRWV2l4RHE2dlM1RHdZTUJ2blpMODA5bUtFazFB?=
 =?utf-8?B?b0U2blliMTAvS05jM3pWbGd0cEN5TjBqY0Nlc2JybFEzUnE5RWk4MVFrb0Zz?=
 =?utf-8?B?blY3L3kyZ3V6OE1lY2R3MHoxSlMyMjA1RzdpaldvVm93MUJwWU5yZ2Q1YVR5?=
 =?utf-8?B?RDlDVnMzUGNGN1FITjgxdDc1QnJ4eHkvVmd2Zzh5cHBLcUsvZjJWOGxBOU0r?=
 =?utf-8?B?OUZOYi9ySUYxU2lhZXViN0ZEQ05OUFNOL1BqTGdDcUZJZWZpWW9BdzdSUlBy?=
 =?utf-8?B?bnIrNks1RFA1ZXhJM0NQTlE1WFpnNktIM3E3TzloWnBkN3d0MnNTN0FGdmls?=
 =?utf-8?B?a2p5aEFMQmJPWnlncytiWXgxdWI1azlKc1prTW82dll6RVM1cTZjSUVuMGQ1?=
 =?utf-8?B?YXBPQ0hlSXRtcUE4QVEyeW41alJzOHhvNHlCb0ZDUEJ4Q0ovTUUxRzFkM3JR?=
 =?utf-8?B?bkFBVnBUclMzK01pVGEwUHJUeFYrSk92TGpwZmRadUlVcVpwZGRZV0Z5UnR0?=
 =?utf-8?B?dGw4ZUpKVlhGN3VLL3J4SkY4QXh2K3hYRDNvb3RBZHo5QjdQeEZ0b1BGY3Nw?=
 =?utf-8?B?K1h0TDlkVHFJREx5dVBQYnQ3UzByQktiMkh3WFVYRnBYT1FMczVXckszVE5u?=
 =?utf-8?B?dm5YbHZwVFRBME5GRDZPUGFDNE55NnBPdWZrak9GSjJtQmdpSlJHM2FKbzI1?=
 =?utf-8?B?M2U2aWkvcVAzNXlQelFFSDUrNmpJemorc2loR0Z5SHFDQVl3N3pWN2xaL0Z5?=
 =?utf-8?B?U3JXZy84SW5ObFlBNmRDVkJQNjhPa3drQzE5U1dOaVNkclRWWDBUdkJaNG1W?=
 =?utf-8?B?SDBjbU9vb0oxQ3RraThzQkRUam5ZUTk1VGNTR0M1cVpEeHlITmhKd2xRSUc4?=
 =?utf-8?B?SXg5QmN3cnhFVlFSdXMrR1VEZ1JCcmJFZXptSDRmOTJOZXczWVcvQ2RDMFBJ?=
 =?utf-8?B?Mk82VGVjNGFlSnNxVEZkMGZCd1VlTmdTU0h2WTdHU21XWnBRSFNKREtIeVRO?=
 =?utf-8?B?UDZ3OGlrZGlEcGJVWGZjN1dZL0RJRHlGaTdOcVB6R084aTN5SUVCR2hOVklZ?=
 =?utf-8?B?aFk5RjJiekZkek1zZ25icHVUT2VKN3JCQ0tFL1RyTi8xV0R2SXR1N08rZk9h?=
 =?utf-8?B?OWgyaHAvOTNRS0FNL3pSbEl5MWNWZGo3T2l1ZmNBV0dnVUNzTDBDd2FOcld2?=
 =?utf-8?B?N3dDVkhSR3p4OFBqM3ZaKzJzWFlvTUNGZ0RpVlNhVjM0UE9xNTR1N2lwUE14?=
 =?utf-8?B?WlBRcGpMTXl4RE16MXk1QkVPU1V5N3h4eE1SUUk4OXZleEFhT256ZEM5UEI2?=
 =?utf-8?B?aG8yT29LcWYwU2tTTmNVTmtZMUNsU1piUjhtVndHTDc0ZXI0SEcxQkJNRzN5?=
 =?utf-8?B?M2w5UU5JY05iRUlNWkJyVGtnOXRvS05uV1RwTkNHeW1KZXlVNEhrcjljbzh0?=
 =?utf-8?B?N3BmZ0FsUDJ5MTlGZWgyVFJTNVlialg2TjE1cHBReXJlanQva3pqN3hlTkpY?=
 =?utf-8?B?QWZPZ0xUZDY2OVJFOE9xa1UyWU0xZTRpTW5mU0dEeWJDenArRXF3NXRTTi9M?=
 =?utf-8?B?S2lxTjluRllEbkk0MnV1bUZjaTVlc20vZkhIMWdFZmpTZ3Q4d3hIWGZvd1By?=
 =?utf-8?B?bmgvcmxreVdWU1NrQlVGN2JWdmY2dUozdU5WSFZRTHFVQ3VwTnhtT3FaNSsr?=
 =?utf-8?B?Zit1ZmVoU0Y4ZXhqZHQ5Nm93czZjWGt1UlU4UFN0N3l6Ui9KMmJzZld6MHdC?=
 =?utf-8?Q?kv/6Fa11cDTCeTiwMJK6r5QueEdA9u0NFNNFq7+?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce673b-1a76-4655-9973-08d8eb1debfc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 21:28:21.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p96fp95JW7bAGzw5QZEe8pVRi8NBhmF4UWTGOLpa4r5QuAHt4lZKzPFbrYI9vlXtGCTd5E1uKGf0KgAkQZ9wptG9mNVeEUykkYvD6l/2fCfVflSsDIWqMJ30ct5JBn2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6181
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/19/2021 4:59 PM, Wan, Kaike wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, March 19, 2021 4:55 PM
>> To: Rimmer, Todd <todd.rimmer@intel.com>
>> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>; Wan,
>> Oh, there is lots of stuff in UCX, I'm not surprised you similarities to what
>> PSM did since psm/libfabric/ucx are all solving the same problems.
>>
>>>> rv seems to completely destroy alot of the HPC performance offloads
>>>> that vendors are layering on RC QPs
>>
>>> Different vendors have different approaches to performance and chose
>>> different design trade-offs.
>>
>> That isn't my point, by limiting the usability you also restrict the drivers where
>> this would meaningfully be useful.
>>
>> So far we now know that it is not useful for mlx5 or hfi1, that leaves only hns
>> unknown and still in the HPC arena.
> [Wan, Kaike] Incorrect. The rv module works with hfi1.

Interesting. I was thinking the opposite. So what's the benefit? When 
would someone want to do that?

-Denny

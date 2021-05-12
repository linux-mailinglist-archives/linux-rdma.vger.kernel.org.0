Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638EA37BCC3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhELMrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:47:00 -0400
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:16480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233264AbhELMrA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+192ipXv6Ary/FEnUZ2AiUecP+5rdCAE0iQQZkO7ExGYwqj2ykVoJxUhTgsqn9wlMYHKL1biHQmc3m6b5BiqBSdbHLUV36FbdHLBUEtIePP79u/HjBXQnuhUB0dZ3uipwBaaIJmuxjdFTlO/Fuq5WLBlZ5MbbjgHwUVL7PWHpe+7IFlHx1ypN+VJH/+cY47pxyFnxFbbA/uvClRJLJiZiFXzBLf5U40re7541bV92EXy6GJ4txvI1pLjHlszk9khe6Wm91zyzjkOcIp+rSAgYP4ojhrI/VgHwIeGaA5vyFblMbLt0Qv9QiNH5zGO6rtNpqykfaSGNdSCqA8wty+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbFgfu+qqqeco5uxJ7GfvJF0uDyvdONB4scQw+I13Gs=;
 b=SHrA43gotPP/GDCX/8aziPt/exqRD5DMypujfY+6Qxj6xRtCyVhr1ngpGumhp5qEVeTTSqfl9zpJlgvqoHHB7ZWM+NIrjODSNFTm+pA/uW4PdVKctktl5aadurnIoSzVU8RGoSb+Vw+ejNetbED+pKRNfEkIo67RE1Wjt6rRnFHH5lfh5Nvav15nJbue3RN4qQ46eUe9xRg8x+K3jZMVn58H9FJT6iIdJsI9g9lTSIHNQcL951kOS0MLR4dTBPHdkLTUVzewxA3NbUDoeHaCD4enH5vBtoL6pZiiDd+UBXtDJyWb2I8b9UsVKAr0j5OQsDN+wfADc6ZZVjYfuYIT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbFgfu+qqqeco5uxJ7GfvJF0uDyvdONB4scQw+I13Gs=;
 b=ak+RgPIP3kjSCZJ6cGLuurW2IlsyfNDpDRZj4sVe9opKZDIxfdjNAZYFbXJ1Fz+hL6E3k0UtaYhFI8JmIrzSO3A9f2oKWQTl33Kup4mgxw7Odo9P5ik+6gx6guZaZBopvzxq/aYNn61tKqd4/pnBgIsCu1WZOsWKDwNCLHEUBhsYZLr2Xczb2OPdnpyYbPNTTnX3o9GkvCmlPqHY34UVZ+briqI7z8H8QgTb5S0SynhT06PvxA7p+PHtCMfZ2u/rPJEJKCAoOYeVMgrNFmQum/x21Z1dhXKqWojH/6C82lWy+upjHKSYmaxhVOookaobE+HAT1OFMxsqbrRiVjx0sQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6471.prod.exchangelabs.com (2603:10b6:510:b::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Wed, 12 May 2021 12:45:49 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 12:45:49 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com> <YJp50nw6JD3ptVDp@unreal>
 <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
 <YJrasoIGHQCq7QBD@unreal>
 <6e45f8ca-59d3-354c-bddc-ad7ff449b58c@cornelisnetworks.com>
 <YJvGWPimIFbptgdC@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <7284da8c-9993-76c4-b495-32c814607a4b@cornelisnetworks.com>
Date:   Wed, 12 May 2021 08:45:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <YJvGWPimIFbptgdC@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Wed, 12 May 2021 12:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6adc3c85-d478-4fa3-b480-08d91543de77
X-MS-TrafficTypeDiagnostic: PH0PR01MB6471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6471DAFBD3DB2A9E166BCDFBF4529@PH0PR01MB6471.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fzu5A4Va2kgYy3Eh+QvIzqRcsbX1yVLK9OQSoCOo3wdwLSYYoSTr+Wg0nwzVKG2WCyu/9G8yA78UP0lQFZ1sl3dIW2I6NrrHntsiyvAkFgf9W7x1ZNMxp5SmjkjVjMn32D20+oN5CkNFHD/JzIF62aqzVTGNwRBZpPXGd6a9zBU0ITaBO8hu2f8k+XoJSuSpMzsQsDJXpEdnrq3HdEyh8fKfaL7xFDN0Y330vRmefQYFgklvLpuaKjeKaBxuRjA5Ext19ChZIHqKRBK7wtpq6wyIf18TfNFzOLECvaGTXIe41oXbRvJ7pNuA9GIZU5suvfdW0jEGAtuuLQOy1t4HRpI3NoUwaVhbvFEj/iQqbBzmOhzlTpFfS7OT8mHK7HiXGm/uxUQUsVnCjt6/nAofPwLXKRPpW7igfs943lxArMwK4fOKU+oTp20+WKXs9CgTR6llI3LpdrhYpBifnDAm9EbzDIlL5EnWZxP8LyiBjhChd/DeOgoFpnhI1qmiYqdCeo1GoNqCxU4WBysHmbuCPnrClDJsZDb2CHtVUSPgLBXT6XQj6zCSdTCjyVMlNLVBUTLwF1A06AHidlANYhcdeNTX2pcDomqDe9ymhXpAs3NvPA/+wiK9ziHS18g+sQPdABIqxMqspMyRo82stxQQKiHSQdafCYcykhL5xQUZm7xoV2tEl73HaGe3jX+oyo19jgmPZJU8JOkCGS23OAeQEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39830400003)(956004)(2616005)(52116002)(86362001)(4326008)(6506007)(16526019)(53546011)(44832011)(31686004)(26005)(36756003)(6916009)(31696002)(6512007)(478600001)(8936002)(8676002)(6486002)(5660300002)(2906002)(316002)(38350700002)(38100700002)(54906003)(186003)(83380400001)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Uit0MWJHeEErUDVwRElqM0M4eDNHTzBueUd4UkhncjM0QWgvREovMlh5dURz?=
 =?utf-8?B?cTVYaU5DU0c1Mng3WmZsQmtkZjRya1ZRMnh4Z2pxWGZQSE5xWjR6Y21JSnVn?=
 =?utf-8?B?RFRhd3VLb2I5UHNUYTBmQno2ZVVzRjFIblg4K0k5VjBwYnFoNGZVbU1WRUUw?=
 =?utf-8?B?TGp2d25XSDBCc1R2SzZKTTZoWlZiRmdvdGtLZmZtMkFSYlZ5KzVHUk0rbVZT?=
 =?utf-8?B?QWxkMzhZWGRFU1RGeGN5YmtrRTVwbzlXQWNqTlh6UUdzbXJRekxqREJLSVMv?=
 =?utf-8?B?R1ZtMG9wUDdZUlRoVThacjR6UXlwaFlsRnJlSTRtbFJMcGgwRzQvRG52Q2pJ?=
 =?utf-8?B?NHBSQlE0S2hsMDF5VEVuK05zWUdkRkpQb3dlcmZmUVJpYXFOR2dqR2xZNkdE?=
 =?utf-8?B?Z0lKQWtFSVFnSSt4WVNtSitXTW9hRmlheGlWK2R4bDBMNVd3eXhRQmQydXB0?=
 =?utf-8?B?MU1nYzA4a1BVWVovcDczblJuRFJpV1BYVTQyRnFrdGUwU1BodlV1TDhCUzRB?=
 =?utf-8?B?aGV5NTROSjBTRk1pZGhBODdnTlBnUXlkRUxTZ2ZuQ0hNeXN2YXZKKzVTU0gy?=
 =?utf-8?B?K3V3eXJXbjN2eGF3djFacXVnVElmTXBmdU1YR1dHV2d3SHI4cnBmNG5MUDM5?=
 =?utf-8?B?NFU5bWZDSU5qY2NDNmRJVnFsemptYlBqMkRxS2EvL1FqTjkyWjlJRHM4eGJl?=
 =?utf-8?B?Y0ZMR3ZyZlg0aDRKSjRpK0wvUFVpb0dFVTBpaHZRNjhIU0hac2E0SGRaaGxm?=
 =?utf-8?B?WXRFNjJHREtqcjg5Ry9BKzlHR010QmpDRHlmV0pxckp4eXFoNlRGQ0tneThk?=
 =?utf-8?B?YXVWd0pZdEZTeHMrNHR1YkFXazhzNXJjYktYWTFHcUUrNVBhNE5yaVRYVzZT?=
 =?utf-8?B?NVdLRkpadFlYWkcwQlp5Wks2NHZ0aU84RzM4VlRvQzVyM0VIckkya291T21a?=
 =?utf-8?B?YWtuS3lnS1V6TFpxYW1vR0pTS0NnSFUzQWVhdS9Kc1VTV2xpazMzRStwYkN0?=
 =?utf-8?B?UVlXRWdZWGs3U3c4KzFnc1o2VUxtS2NkVmxhbUI5bjJnTzJyWWxmQWFDMEJ5?=
 =?utf-8?B?ejdFVlhpL01iWkkrWlNxajVHeitsVE5hc0tFOXhpRUFaempMN2JqdTlZWGl2?=
 =?utf-8?B?bDR2YndMZ2lTd1BGY0ZwbHE4ZE96L3ltTFI0VHZQN0hwVnFwbmxxWGtiL0d6?=
 =?utf-8?B?bTlxQ2ljc3o1MW9nZHZZTk5EK2Y0dEd0bkp2WUJJODhIT3RORFBoUzJiS2RK?=
 =?utf-8?B?L2F6YkNiYmhFL2pnVHNWcEg5bEd2KzM5dVJuNVVsTFBxVlh5dUVJTDZON3M0?=
 =?utf-8?B?OEp6Y1EzQVMxVVlLNERQaHJFd3JYalB2aHFDMVBqU2pHS2pxbW4vckx3ZnJQ?=
 =?utf-8?B?L1VDLzcxVlNCNTFyYkRSTFBZZVhvcHFBUlpicUxvVHdBT1EwQU43cENHZ2Ro?=
 =?utf-8?B?cmhGbERVSUY1Rld1Wm5sZVhyc3BwajlCYUdIaTJwUVh3bW4yYlE2NDBXRnI5?=
 =?utf-8?B?dTcyb09rNGFyTmlsc2lMekVXdnIwK0lFUnhLT0xBbE5uSzF4clVpaGpoTUFX?=
 =?utf-8?B?aThEUUJ6SEk0ekpVckVvTU5XU2cvdmU1NUhvNGFLZzlka0ZCTGUxNGhNb0pH?=
 =?utf-8?B?b3huMGJzdXY4NStTZU0rbkl2bCsvZHlaSjJ5T21jT09JTkV0UWN4OTMzejQz?=
 =?utf-8?B?eXdTL0h2d25rMm5Rd0lURnhDbXpURGdKT2J6YStFWGNzRzl3T1pCK1NjTmVR?=
 =?utf-8?Q?MB5CVfhIl0SPXccO0zBDlnW+eXm7eipvGCMR/qU?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc3c85-d478-4fa3-b480-08d91543de77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:45:49.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjEiHtsPPkIWGlvCeGysN6zcUEheJgbXVN5y17uml8Jeg4LkkzAjb8tx11J8PXzcwGtRgPi1W3PLnhxDNm91HfhXfUJhtzxrvaanMN++t61gkgMm/se2Xyb0IvB868Wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6471
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/21 8:13 AM, Leon Romanovsky wrote:
> On Wed, May 12, 2021 at 12:08:59AM -0400, Dennis Dalessandro wrote:
>>
>> On 5/11/21 3:27 PM, Leon Romanovsky wrote:
>>> On Tue, May 11, 2021 at 07:15:09PM +0000, Marciniszyn, Mike wrote:
>>>>>>
>>>>>> Why not kzalloc_node() here?
>>>>
>>>> I agree here.
>>>>
>>>> Other allocations that have been promoted to the core have lost the node attribute in the allocation.
>>>
>>> Did you notice any performance degradation?
>>>
>>
>> So what's the motivation to change it from the way it was originally
>> designed? It seems to me if the original implementation went to the trouble
>> to allocate the memory on the local node, refactoring the code should
>> respect that.
> 
> I have no problem to make rdma_zalloc_*() node aware, but would like to get
> real performance justification. My assumption is that rdmavt use kzalloc_node
> for the control plane based on some internal performance testing and we finally
> can see the difference between kzalloc and kzalloc_node, am I right?
> 
> Is the claim of performance degradation backed by data?

Yes, in the past. I don't have access anymore now that I'm not with 
Intel. It probably would not have been publishable anyway.

> The main reason (maybe I'm wrong here) is to avoid _node() allocators
> because they increase chances of memory allocation failure due to not
> doing fallback in case node memory is depleted.

Agreed. It's a trade-off that was deemed acceptable.

> Again, I'm suggesting to do plain kzalloc() for control part of QP.

Now I don't recall data for that specifically, but to be on the safe 
side I would not want to risk a performance regression.

-Denny

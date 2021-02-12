Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69C31A766
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 23:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLWR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 17:17:57 -0500
Received: from mail-bn8nam11on2107.outbound.protection.outlook.com ([40.107.236.107]:48481
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229718AbhBLWRp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 17:17:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuRRVvLUtVW9dpmER6ughNqUFQ3ZgCEkn9gLtCX9RqfxlwUT1GT0QQ+BedyBLwIzeXVLMACMS7RxdbY9WcjCPB0e31CQZXzbqrPivDp4aDwHIaypvXP37eKSPgalooqFM13LCGKHECwcOGkJxvTOhGGd25n4NLjHq5bVtpHGq0vNi6sy71uxXZD2Yhi7UbkHi13MmBAqg7JuGGm4lBQMX4+yawyDS0X/CPLxPI76Xdp9Fv1InVnXLqbCjHbMQ6yEBM+1LnpYTbPVb4/7XRk6LV+sg5+TKzuaG9M3BjTVw6Zk46gZvgMyoqCEFGuA99CBZXEDn7j4mt6Bo/wpfBE64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WeCmlImUrEkINOwNmCNCsovIjOkXLd7LDTDLSksRQo=;
 b=BCg/F0GLhtBxeO4n/KDSmzm3nlRzQlbOaeCasti8y2pcrX/stx10UBAzPUE1LU1bXD2GZ+S4DsPRGQflQflV4hu7nd48q/xA/s3ORVxIVgLOndBcqx/564a2eYe6DFEbbPfTi15+Q0SA/dGGZGBhek6UFDXOoczyEHlCL45RyVIHDMpBqaUZAL86SdffgV3l8JNSdI6M0zBDYSTH7XAcqqNJ65SWbIZAgoCVysLUZO7WNIhJKLHeyZ5LwY4wzINsEuCwsZUp2ZzCPYzm3NVG7lVbQunk/KynzJeyfL1nYLzkpkEdWLdlmies/e08P/ejYNDjKFzW23nrCd+poioCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WeCmlImUrEkINOwNmCNCsovIjOkXLd7LDTDLSksRQo=;
 b=Sezak5O0AQ+OHQTJb5KVArIxNa/ctdCYkN8q+8f6rXbq6FIxvg6j1l1F4lgDyoKDSWAx80vXnjPiRCW2UfGwrguzSUM36AevTqUdKL3mGLo7RKeVP2rU2W22GSSr3vmG753luhnf7Uv3eLduOsIfK6qRISrTFBZOwLhukW7ke98PKUQsQwWpmi1XzcsakXOzYtxburVSAEsps798g5VtYm9lXNvWTKgtmq2+u2JHACW9BiUFAaeyfvhcbCj87RWAvfNeTuD75fbV2dCs0bFRaJb0EMSo5gmNhQMJ/20GNWcbyxBmfXfaG7r5kywBq7pXvkCIYqJmY+yArBi+4RTOeg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.34; Fri, 12 Feb 2021 22:16:50 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::3dd8:bb32:87f3:7e4e]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::3dd8:bb32:87f3:7e4e%6]) with mapi id 15.20.3846.037; Fri, 12 Feb 2021
 22:16:50 +0000
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
To:     Christoph Lameter <cl@linux.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
References: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com>
 <20210209191517.GQ4247@nvidia.com>
 <alpine.DEB.2.22.394.2102100925200.172831@www.lameter.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <15fa038a-8fee-05b4-4c5c-0e4c3a5d1aec@cornelisnetworks.com>
Date:   Fri, 12 Feb 2021 17:16:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <alpine.DEB.2.22.394.2102100925200.172831@www.lameter.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Fri, 12 Feb 2021 22:16:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f7f585-f793-4998-5422-08d8cfa3e509
X-MS-TrafficTypeDiagnostic: PH0PR01MB6501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB650139BEFB9C55927082DB34F48B9@PH0PR01MB6501.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2haeCwZYK6EUX5V+oNTTTVUE2SYuTBDwkxfTKzMdf4B+EcPTUd048X/6A7vCW0Yw/yQVqs4XfDeyJgKhKUh9CO3WPclTPWfSavvhNQVOSibnR8Go9AzmfPtMu6bMXVw3dJgUN/vlPqD/EiC36xiXE79pUaWwR6iAkrRgudLsm+l1Lr05SSruJ9K8br6moROift3SPgHtBIPsjUNMeFidj/S4O4C8+GcSSJOgCZM+uf1L267vJKXropEmqKjUs5oaRMrrXphIlM43MRjoHUfDsw4jSPAswV4ZPEyuy6f47VfAi6EEbMTw04mWCVxmc5ouJvXBGxkdzBBJrX0mefZLkzp6PG6OWfeIBIOjQ5QBVDpIjeEXSdMowK6j3oOAXpp4zYqvh1nZZQ+PvWMEH6eFDYbdSXXv2Rel1/B6pR72U3rBtcQNlqLwRh8HRjdayHrNVF4I0WRhnyJpTn2EhS4GqQNDudqpIu7+o7Rif8gHnKUMekccRFvfwoIxdBmZrh7XWtD2wb7cr1YHhjRGjeqxaO8A4uMflak3OsPGvy7NcIoALyaIITIbEVNyqvze4FYiW2iokPnLBu1yKj5Bwdk3lNl8a6LZuYw09NbJYaae1J4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39830400003)(366004)(376002)(396003)(44832011)(316002)(36756003)(2906002)(16576012)(66946007)(6486002)(86362001)(66476007)(66556008)(83380400001)(31686004)(31696002)(6666004)(186003)(2616005)(26005)(8676002)(478600001)(956004)(4326008)(52116002)(53546011)(8936002)(110136005)(5660300002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEhiYVg0V1gyLzFzY0d0V3Y2ZzJuR1Qva0l2K2ZRNlNVdVF2YmhONnNqcTVw?=
 =?utf-8?B?bUpPYitFZ3hMOVkrbWZ6LzVvYUdmcHkydVphV3JCVUpUVWxucnJOTzRUZDFs?=
 =?utf-8?B?bURlSUFpRWE4UGFqTko3Qm5uREZuRGFFaGpiZ2RzalUrc1ZHZmZaSi9oUTNG?=
 =?utf-8?B?UDduUjdldEQxMGU5N2RlZ3NSOGZ4U0VGSVJJR2NoV0E3V3J4WjJYMk9rRkkr?=
 =?utf-8?B?bmZtNXZORnF4ZXpDRVNzVFEyQXpyMGxydUZ4cEQ3WVFrMUllbWFldk4wL3R3?=
 =?utf-8?B?VjRvVjdXV0k4OXVSd2tlTDNOclk1V3U1YnM5Z0xoQ3JIbWVsUUVHbDVSc29w?=
 =?utf-8?B?ZGxUSlA0VDU3eW9qNkpvbHZtV24vbWpNYmhrNlpIdWIrcUxOK25yejVXeVNu?=
 =?utf-8?B?WlNmcFlRUXlkdyt0Vi9XbFNEaHNLcDdKdWZiam00SDJ6b3VrR1h0TEFKeFB6?=
 =?utf-8?B?aUU2ZnNvSlFlTFN6QUFCV1ZXbnZ6YjN2ZzNBTDN4a0pndFlZbjVFc3VxN25S?=
 =?utf-8?B?Ty92d2Roakc1a1Y2am5HaVRINXRadVBKV1FtYkw3UENaVTdISnZ1YXQrOFBP?=
 =?utf-8?B?RlZWaGlrQTNMcXhSTnJkOFdWanljYUc3NFlIYmc0a0lab2FXWUN0UElObkZl?=
 =?utf-8?B?OHR4eUhFWjdtVGhGTTFiRW9zOGVGV0x4Mks3ajhLanR0MmVremI4NmJTajBW?=
 =?utf-8?B?VkN0bjZTZWRaOExXN2k4Kzc5K2Y1Sy80K0JNZFAremdLSWtvRDQ2MUNNTmUw?=
 =?utf-8?B?MGtvaWVnNkp5MjdIckl1TEJuUjRBN0M4VWswNWJ6Mkh3bzl2Z0lNaHlkNGlP?=
 =?utf-8?B?MUxFZEdEZmRyZmFKYW1pUnpQV3BQUDYrUklkQ2hlUDlCT0tMakNWa1RyZE1G?=
 =?utf-8?B?RDlybDlneDFWU1ZROE5IQXFXYlVKajdVYjBuSDF3WWFJOE1OeTZaakRoanp6?=
 =?utf-8?B?MGhVeVMwd1pNYkUwMHNIQytBNkRlcnZncEtrRjdJVDB3R2kvczlGUVd2Z0Z5?=
 =?utf-8?B?ajdlTzF3UVZpREVWZ3NhTFBXQ1BRaDJlU3NGQURUbHpEaFNjaGJ5YXVSSFYx?=
 =?utf-8?B?QUk2L3hwYmhzMzVRWmhuNFhHT2ZDdXhudnVpUnNnd2NobnVsN1R3cFhvNU43?=
 =?utf-8?B?ZnZray9mSEYvRU1NclRPWCtkWDNwNlZKVlByNFhxODZlZkJmWHFyOXBCKzFZ?=
 =?utf-8?B?U1lFQXlqc1JnOUNrRFVJanhJeHZ2NkxxWE5Eam85bVpYRzBQNEpYVUhuYm9t?=
 =?utf-8?B?VUlCMFpaeU9GNWJqR0hJWk4ybDhaR2J5Q2tqZHozUEwrYThmQ2pRY0FZWnZj?=
 =?utf-8?B?SzhJKzR4WkJKOFZGaUIxWUF2QmZhWStKOWRJZjluaUdqYmxRTStRK2JwQ3Jv?=
 =?utf-8?B?RnM3OE1kRlpIZkdXcHBrQTlPbklYUHBTMXJQRFJiKzBoSUZGWXk4WElkMFJ3?=
 =?utf-8?B?OHRrMjBBUWtHaTNNQk5ldG1uRGJ3M1RpTlZCM011bVFabmNWVEFrN3Z3NDN5?=
 =?utf-8?B?dlJzckJzanpFZTVMUHRxaGtBM0RhS0Zod2tmeFBjQytuSStMQ012eWFSR09a?=
 =?utf-8?B?OVB6QUZaZTc2a2Z6S3hETHdSWlZhNmsvTW03MVA4NXViajhxTHhMVFRkK0Vk?=
 =?utf-8?B?UTF3Ky9oS1dsY2paM25oSmtjbnROZkpxWDhjVDQ1SFYzN2NMaWxWcWl1d0dY?=
 =?utf-8?B?alhRdVV3YWpFNGZBbFhXMXg5RjJWdnJ2ZTNvRUM0SVpIZnJmUk1JTTl2aUlX?=
 =?utf-8?Q?SZsJvPjv9vAvg/9U3kFxsoWFdGjHm1+tCVI8Nly?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f7f585-f793-4998-5422-08d8cfa3e509
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 22:16:50.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3oy6UwDqhA5CoWsmSdbgRsBu4kvkwGHHPwDRaV/os5jCEnCK+m+jLIzVwxG+1tjiYVnae6ILIKdMPlwcpaBebgXKQOM4Jpj8WDd7CAvVuz39NPoRYPjhocXLU2wf0nB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/10/2021 4:31 AM, Christoph Lameter wrote:
> On Tue, 9 Feb 2021, Jason Gunthorpe wrote:
> 
>> This one got spam filtered and didn't make it to the list:
>>
>> Received-SPF: SoftFail (hqemgatev14.nvidia.com: domain of
>>          cl@linux.com is inclined to not designate 3.19.106.255 as
>>          permitted sender) identity=mailfrom; client-ip=3.19.106.255;
>>          receiver=hqemgatev14.nvidia.com;
>>          envelope-from="cl@linux.com"; x-sender="cl@linux.com";
>>          x-conformance=spf_only; x-record-type="v=spf1"
>>
>> Also the extra From/Date/Subject ended up in the commit message
> 
> Yes the Linux Foundation guys are not willing to address this issue in any
> way. I may have to give up my linux.com email address.
> 
>> I fixed it all up, applied to for-next
> 
> Thank you.
> 
>> It looks like OPA will also suffer this race (opa_pr_query_possible),
>> maybe it is a little less likely since it will be driven by PR queries
>> not broadcast joins.
>>
>> But the same logic is likely true there, I'd be surprised if OPA
>> fabrics are not running a capable OPA SM at this point.
> 
> There is also another potentially racy check in there for OPA in regards
> to the support of path records?
> 
> static bool ib_sa_opa_pathrecord_support(struct ib_sa_client *client,
>                                           struct ib_sa_device *sa_dev,
>                                           u8 port_num)
> {
>          struct ib_sa_port *port;
>          unsigned long flags;
>          bool ret = false;
> 
>          port = &sa_dev->port[port_num - sa_dev->start_port];
>          spin_lock_irqsave(&port->classport_lock, flags);
>          if (!port->classport_info.valid)
>                  goto ret;
> 
>          if (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_OPA)
>                  ret = opa_get_cpi_capmask2(&port->classport_info.data.opa)
> &
>                          OPA_CLASS_PORT_INFO_PR_SUPPORT;
> ret:
>          spin_unlock_irqrestore(&port->classport_lock, flags);
>          return ret;
> }
> 

Thanks for pointing this out. We'll look into it.

-Denny

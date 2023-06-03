Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855272109D
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFCOwv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Jun 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFCOwu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Jun 2023 10:52:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C619A2
        for <linux-rdma@vger.kernel.org>; Sat,  3 Jun 2023 07:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUB4MkQ08bW7ISKVehbr8MpqSHXhXx78lkOLenLrJ8F8rfn1TPiHOecpvv+A9yB21mmK2KtGhxe37rNPhykTQR3LU8G4XVQYxIfTsAO9EYxx6291/fcNmaULqduKCRxVcsRUPBUWad3NKgHuYOzoP3MGHM4R5kJmx3Usm7rhMFp2ZwYpLzEFit0KPvVe0KJeTjmEeXtx1icTqiBQ9QlNd3wT0WVzewnrL60ymfCaUoIjAuvBqDDPZMz1Y774oMX0ho9ql7hNwjkyrO54kjEuehQc/FBVSp0Ivq6gfKI9oB3albGZXaLH5eaDcIabizWCNdZPneehrXTiferYyZU3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOQVis9BhXr6nHpT9kg2nnjViUi8eHyCJWIUOEFWI5U=;
 b=GkQ5YuR8Rg0rkXD8/N/gEDKoVeABlaPWKkwY6Wfum/2407LM7SY/Jtmfrg+gMU0aamMKLW2J2Tz10KYjuz3JrDxFi3hhmkVe0F99KrhdsdFSTzhwPx0fMkAFf/0nbOZhdWWsxcK26H9Vp6yKj6WChvMjW7NzHh+dttaGTzIaLSLGWTvV9C5WOlvuN+rDzTadCi9MSyKPhZ5A4Y96VzWjU4rlPlHblF76IrFoHI+cou9UzYsy9JwbpaxcIYNcfU3hIKqQB7PXAVxYbQ2i0grf2y5hGHb0awF9Ls8Jpb/EddFgiDkETTPIq8WvzXRL62FA2RMG8V4VvzuyCUxInVkICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA1PR01MB8110.prod.exchangelabs.com (2603:10b6:806:33e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Sat, 3 Jun 2023 14:52:45 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.028; Sat, 3 Jun 2023
 14:52:45 +0000
Message-ID: <7b88e221-3cb1-aa50-f346-0a7fe9349956@talpey.com>
Date:   Sat, 3 Jun 2023 10:52:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and loopback devices
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <168580052064.6320.4273961644261511156.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39194A46F4CAD3322221CE19994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
 <D9A02961-BE4A-4B71-8FB5-6A0662853BBB@oracle.com>
 <SA0PR15MB391953A7D6B68E48F92C2DBB994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <SA0PR15MB391953A7D6B68E48F92C2DBB994FA@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:208:32a::21) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA1PR01MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a675752-8c2e-4aa0-eeb2-08db6442308f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tR7oWaU31/eHZm2hFy8iBAN3bRQ7EoP0eIB1kg2u+xO7mKFpc7M9aLEPTHpE6oYyHX1wm+kDVLiOBVeTPXdYI5RMVxKF+JYd/5/AjcVB5VXOwwpT91SiypJ7hYsw/Iu+lKvkCKC3XwpBqcuGbVusabjjkx8IV3hhDMCjuNZOQ4TG4C+FeZp+aTIEK1mkSZ83s9JpuGvRqb+vkLCLtblx2j/yb+BbLJLZNOjstSU+V8q5KzgvQIFQu1jHZDM26plbGU67yW8keReAWClrhxCJi++2Ik919A2PXIuBG1tMCLePZTJ4tqxDBfn8kbsdsAiwn3phs8sUfjx0xu/Xi6Tyq2DceaMtUaaTki8oOp7EcosWagtYjghPzj+ESIZjJAXSF41N3YVEndfZ7NoL3q7rwe3FKuEp9zYyfa/BauoIltyr4ad1L9PQpEXi8m5PrZppVnY5NCsCM1CPch7/SARRDUksUle7rHZE/ugfgTi5yBp7ObcdGVmuNFbFRvR/8QqDt8gbGn6sWLb0rTPtI6qVq0FVig4XNsBaUl9kfRZ7fwiaQ4jD3ViY4oOLQJ+4QM/VZiN2z0RZKKyLRY20fKqaFis3V7BA8Ca7Nycd8lYYw18GzLqNKMQk2114bnSHHL8Bc1NEz4cTdCbx6fn+z7tXiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39830400003)(376002)(396003)(366004)(451199021)(186003)(5660300002)(2906002)(2616005)(478600001)(4326008)(316002)(31696002)(6486002)(52116002)(6666004)(31686004)(38350700002)(41300700001)(86362001)(38100700002)(53546011)(110136005)(54906003)(8936002)(8676002)(6512007)(36756003)(26005)(6506007)(66946007)(66556008)(66476007)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJISHhQRXlPNkRQS28rNmhMdmRRd3JObElVWUZmYS9YK2VFbFkvaGhsRDNW?=
 =?utf-8?B?czM5YU1Ea2NielUyVHliNnJjL1hENDFHZWIyM05Ya0RSV1Q2VDdEWlBTRnBz?=
 =?utf-8?B?Z2tWNVJCTDFYK0tMb2oxSVU0K205Y2UrUTFVVlU4SnZvRE9zOGxzdTNPOWt3?=
 =?utf-8?B?SS9jYldvcVhxVDFOSWZ6MmZXeGd5SU9GYmh4R3p3WUhFWEpzTTFwWm5hWHZO?=
 =?utf-8?B?c1VYUzFYcUNVbHJ4VXVlYjh6R2NCRnptMUwvR0pYUkZrQm1qZlpncWFoemQx?=
 =?utf-8?B?WkFYY3hVM1g1N0NxTnRDZVZaQUhoV0NjYkRKWXlBSWk3K3FGci9qdllOdGNx?=
 =?utf-8?B?Nmg1YVNaQ1Uzb2hCbTJaNHRRM0RCcStXQWl4R2p3YVhPQ2tXRVdpOFVsSTRC?=
 =?utf-8?B?UUc2Y3dSd0RUemRpYTR2aHVBOGdHZVZ5Z21QanplNUtkb2k5VzRzNURjN3Z2?=
 =?utf-8?B?Z1FBS3dQN0ttUVZrTHp1ZWd5WFkzL1JLaWZCZkk4TFdTUkRMcHNUTjhOWEhz?=
 =?utf-8?B?cnNaRUVLZk1kY1hPU0JiR0N1NkxIUlp2dy9pNUMyck9IZXRJVS8zVHcwTkNZ?=
 =?utf-8?B?WlZKckZjcjJ3d2RWTnBUQ0RydXNHamJ0RzFQblNPemV6VEFJV25DRG5vWEFw?=
 =?utf-8?B?WGxodVA5eWVZQVVLRUtVNnRjL3k1K282UVNGemVqWFdWWnRGTUI4K3NuVDF4?=
 =?utf-8?B?OVg0ZkJrUW1FMTZpUHVkdjdSZjRGeDVJdHNUczJnQWdSc1RSSUFsNUZsblFW?=
 =?utf-8?B?M2NjY2EvZ1NERll5Ni9hQ2YzYTRZazRYeXp4WnNJdmpscjV6SjFqZjdzQlJm?=
 =?utf-8?B?czJsZ2RLYUg2YXN2WkN3OHg1NkVyYmhnMWxXMVFDSjNMNlYyQWMvVkYzd2Er?=
 =?utf-8?B?RUhUUlhoWVpXRUhqMXY0UnFIQkN5S3oyUlhlRWlNemNLeTY2M1lJYmFpa0hF?=
 =?utf-8?B?ZVdSRld0cEdhTlZoVmR0bkU2cGhpNksxSlI0d21odkpONWgzeUtCZHRPYmE3?=
 =?utf-8?B?blhtQTZPYkxzekZqSk1jNUYybklRN0F3OThVYlFCbEtkOFpzdjNoL1FGRk1t?=
 =?utf-8?B?MlpHSDZwKy9salVtWFpwa1duVmdZaDFxWVd1ZVZSWmU0eGVIS2ZhcDFhNlZH?=
 =?utf-8?B?ZGlBd0R4dEx3QmpSeDd2Ly9WeG9vSHRTMU0xVHZSUkJJT1dzN3ljazd6aGJq?=
 =?utf-8?B?dGdsTEtNYkNTaHlMM1ZhZXNXay9zKzZuME5DR0NpZXNoSzFuQkpmR0UzN0F0?=
 =?utf-8?B?ZE5TTitiQlVPL2JCQnVRdWUyM1dxRFpsckI3b21qSGl6ZXFPcEZWMG9ybTlH?=
 =?utf-8?B?NHJOOGZZeUF0NlFqdVppZ2Y3WVZOQzkxdmNrc3RZRGh0aHd3Yy9ocjlWeEZp?=
 =?utf-8?B?ZWZLVXdoMXMxN201Wmo4OVFVTGowNFc3UVlxV0JpV3dZOWczTVNvT0pGV0VY?=
 =?utf-8?B?cDJsTTZuemg4UU00MDlwVDB5Qm5PYSt1WWFpVTNZcFF1YXJkd2x2dFhTME4r?=
 =?utf-8?B?R1VTa0pUY2RpL2sxRnVocW9QcWh1T3ExSXoxa2RhcDJTQWE2MXozd0lDUU82?=
 =?utf-8?B?dkpxTW9IYjlqb042UndOSjRQajJ6TVc4cnRVbDJGRGV2eFhRRVIrQlRmMmVP?=
 =?utf-8?B?STJhdWhBQzdxNlVNZFk2T0tlbDhRUG9YM3pHYlZXYjZhL2xQVldGY1J1WFBZ?=
 =?utf-8?B?a0M5Z3VCN2pXQUF0VlRhRnRHSk1LTlhGMDMycEFHWHozT1J0U1gwb0NRaEtx?=
 =?utf-8?B?WjNESnQ1a2I1MzNBZHFONE1sTG1ybnh2VEdEdlg4Q21Nc1FTVmdzbUZoYS9K?=
 =?utf-8?B?M1ZERFlTdThOSkpvb0xyOWwzeUIxUEk0WTFWZ3RibUtrSDhoR2N3RTIxR0NY?=
 =?utf-8?B?Y0FudWlzZmhvVnFDV0h6c05LbnZEUzlSa0pHNXhNMjNTazgzY2tkamZGMU9Y?=
 =?utf-8?B?TXVuRndnOGs4VC81Z2lHRnNBS0Z6Y1dhZVJKdWp1TlZmVDU0RlRHTFMwQm5H?=
 =?utf-8?B?SllJZWJnYzYvTER1SytYWjFtSVRhZnhvK05wdGN0T2ZlVUtpdVI2aUg4REJI?=
 =?utf-8?B?RzhseWN1bHRFcUNHa0gzdm5Vbzc1d2xrVUd4RytUYjF4RERBSmpIZUlsM2lX?=
 =?utf-8?Q?VUv1BCnCxKVT+blp6ef/HfD0F?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a675752-8c2e-4aa0-eeb2-08db6442308f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 14:52:44.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3FqxQLpOog6GKK5g6MhGqAZHu5H3ZIwT4jdvze5+ERhG/sGYoEtGt2ZucBxuvtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/3/2023 10:39 AM, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: Chuck Lever III <chuck.lever@oracle.com>
>> Sent: Saturday, 3 June 2023 16:04
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: Chuck Lever <cel@kernel.org>; Tom Talpey <tom@talpey.com>; linux-
>> rdma@vger.kernel.org
>> Subject: [EXTERNAL] Re: [PATCH RFC] RDMA/siw: Fabricate a GID on tun and
>> loopback devices
>>
>>
>>
>>> On Jun 3, 2023, at 10:01 AM, Bernard Metzler <BMT@zurich.ibm.com> wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Chuck Lever <cel@kernel.org>
>>>> Sent: Saturday, 3 June 2023 15:56
>>>> To: Bernard Metzler <BMT@zurich.ibm.com>
>>>> Cc: Tom Talpey <tom@talpey.com>; Chuck Lever <chuck.lever@oracle.com>;
>>>> linux-rdma@vger.kernel.org; tom@talpey.com
>>>> Subject: [EXTERNAL] [PATCH RFC] RDMA/siw: Fabricate a GID on tun and
>>>> loopback devices
>>>>
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> LOOPBACK and NONE (tunnel) devices have all-zero MAC addresses.
>>>> Currently, siw_device_create() falls back to copying the IB device's
>>>> name in those cases, because an all-zero MAC address breaks the RDMA
>>>> core address resolution mechanism.
>>>>
>>>> However, at the point when siw_device_create() constructs a GID, the
>>>> ib_device::name field is uninitialized, leaving the MAC address to
>>>> remain in an all-zero state.
>>>>
>>>> Fabricate a random artificial GID for such devices, and ensure that
>>>> artificial GID is returned for all device query operations.
>>>>
>>>> Reported-by: Tom Talpey <tom@talpey.com>
>>>> Fixes: a2d36b02c15d ("RDMA/siw: Enable siw on tunnel devices")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> drivers/infiniband/sw/siw/siw.h       |    1 +
>>>> drivers/infiniband/sw/siw/siw_main.c  |   26 +++++++++++---------------
>>>> drivers/infiniband/sw/siw/siw_verbs.c |    4 ++--
>>>> 3 files changed, 14 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/siw/siw.h
>>>> b/drivers/infiniband/sw/siw/siw.h
>>>> index d7f5b2a8669d..41fb8976abc6 100644
>>>> --- a/drivers/infiniband/sw/siw/siw.h
>>>> +++ b/drivers/infiniband/sw/siw/siw.h
>>>> @@ -74,6 +74,7 @@ struct siw_device {
>>>>
>>>> u32 vendor_part_id;
>>>> int numa_node;
>>>> + char raw_gid[ETH_ALEN];
>>>>
>>>> /* physical port state (only one port per device) */
>>>> enum ib_port_state state;
>>>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>>>> b/drivers/infiniband/sw/siw/siw_main.c
>>>> index 1225ca613f50..efc86565ac5d 100644
>>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>>> @@ -75,8 +75,7 @@ static int siw_device_register(struct siw_device
>> *sdev,
>>>> const char *name)
>>>> return rv;
>>>> }
>>>>
>>>> - siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
>>>> -
>>>> + siw_dbg(base_dev, "HWaddr=%pM\n", sdev->raw_gid);
>>>> return 0;
>>>> }
>>>>
>>>> @@ -314,24 +313,21 @@ static struct siw_device *siw_device_create(struct
>>>> net_device *netdev)
>>>> return NULL;
>>>>
>>>> base_dev = &sdev->base_dev;
>>>> -
>>>> sdev->netdev = netdev;
>>>>
>>>> - if (netdev->type != ARPHRD_LOOPBACK && netdev->type != ARPHRD_NONE) {
>>>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>>>> -    netdev->dev_addr);
>>>> - } else {
>>>> + switch (netdev->type) {
>>>> + case ARPHRD_LOOPBACK:
>>>> + case ARPHRD_NONE:
>>
>> One thing I'm wondering is if there are other cases where
>> there is no L2 address besides ARPHRD_NONE and LOOPBACK.
>> Should we instead check netdev's addrlen instead of checking
>> the ARP type?
>>
> I think so. In fact it is a potential incomplete
> collection of cases where no L2 address is available.
> Let's make it explicit.

Yes, absolutely. IFF_POINTTOPOINT devices (e.g. ppp) come to mind.
There are a bunch of others.

I'm not sure the ARPHRD types are the best indicator. Support for
ARP is only part of the hardware address picture. In any case there
are dozens of ARPHRD types, which seems a fragile thing to depend
on here.

I'd say dev->addr_len == 0 is a definite indicator. I bet there are
others though. Volatile addresses? Sounds like netdev may need to
weigh in here.

Tom.

>>>> /*
>>>> - * This device does not have a HW address,
>>>> - * but connection mangagement lib expects gid != 0
>>>> + * This device does not have a HW address, but
>>>> + * connection mangagement requires a unique gid.
>>>> */
>>>> - size_t len = min_t(size_t, strlen(base_dev->name), 6);
>>>> - char addr[6] = { };
>>>> -
>>>> - memcpy(addr, base_dev->name, len);
>>>> - addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
>>>> -    addr);
>>>> + eth_random_addr(sdev->raw_gid);
>>>> + break;
>>>> + default:
>>>> + memcpy(sdev->raw_gid, netdev->dev_addr, ETH_ALEN);
>>>> }
>>>> + addrconf_addr_eui48((u8 *)&base_dev->node_guid, sdev->raw_gid);
>>>>
>>>> base_dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
>>>>
>>>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>>>> b/drivers/infiniband/sw/siw/siw_verbs.c
>>>> index 398ec13db624..32b0befd25e2 100644
>>>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>>>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>>>> @@ -157,7 +157,7 @@ int siw_query_device(struct ib_device *base_dev,
>> struct
>>>> ib_device_attr *attr,
>>>> attr->vendor_part_id = sdev->vendor_part_id;
>>>>
>>>> addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
>>>> -    sdev->netdev->dev_addr);
>>>> +    sdev->raw_gid);
>>>>
>>>> return 0;
>>>> }
>>>> @@ -218,7 +218,7 @@ int siw_query_gid(struct ib_device *base_dev, u32
>> port,
>>>> int idx,
>>>>
>>>> /* subnet_prefix == interface_id == 0; */
>>>> memset(gid, 0, sizeof(*gid));
>>>> - memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
>>>> + memcpy(gid->raw, sdev->raw_gid, ETH_ALEN);
>>>>
>>>> return 0;
>>>> }
>>>>
>>> That looks good to me, thanks!
>>
>>
>> --
>> Chuck Lever
>>
> 

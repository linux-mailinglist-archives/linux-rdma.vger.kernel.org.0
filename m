Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B691072AD75
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFJQjY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFJQjU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 12:39:20 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62E420A
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 09:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cafrxWeyrOHc5syCG2kdb7KPbqfCEdm8t/oiumpLJ6FwBVEOfZETUZbw7r0yye+WX/ToanZDriYWAbS5o4EgKq812zWDnsEjJJGKNzyxhfQ6foPCy5EsThf/jcILgpHT/G7iH+VU2DNtuHqK3AGTX/Sja6PMITmc6QCkKLEVozKylO6sRKenpuIqkAhlCwyxJkx8CvU9DwWjwRol/POKP1zxfanVgBxnTjfz4hcQTcGIJXA2VPlQGuGKUQi9SNXSNn/DcnSjAzfbjHBBWlxKq1TGT8s2PQ9ceXdx1yPk9+xxwifBi3KjT6w5Sa9fkTG5GJCIfd/9+1Kr3DbTnviypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5wJ9eO1PB42L3vAd89lg5v3vF9anTmKFaEkR4KSd9o=;
 b=L4ial/CW7/V4PIkHMGv8WnzSIUHYlQoTwzm+/Y/UTOJyccfcDEBY2ebVGSLLTQnPAteRc7+fwkps6cKzeR/z7OomM2vezvzQ5Mx9O0aPX3QhYWdnMyaDMVLCM2IrZNWRlImRSVaK/DemdCPkXCbrY5tVSToepXmS1/UWezN5xdTCJdt4MX0dPwaxQri2h6ml+qrU/AJoMxpQrFGaOQi0ggzbM5NlpP0Nw+rndeoNjxYMqnoo3u3Wbs6/C/RHrv2WKLmcbY9qH9QsBMHp22Nij66NVNsnQ8EK5D8jHtufkciakUlI/fy2+cZaANy3Jf+5mtMeRo1yMZDYITxx6DD4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA0PR01MB6106.prod.exchangelabs.com (2603:10b6:806:ec::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Sat, 10 Jun 2023 16:38:55 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Sat, 10 Jun 2023
 16:38:55 +0000
Message-ID: <b7e3081d-51b2-b74e-5e22-cfcab88dcc51@talpey.com>
Date:   Sat, 10 Jun 2023 12:38:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Chuck Lever <cel@kernel.org>, BMT@zurich.ibm.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <ZIRm9s9xjq3ioKtQ@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <ZIRm9s9xjq3ioKtQ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:208:32a::32) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA0PR01MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af926c-3f7d-406c-8d50-08db69d12e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6W4aw3snuokR2ZL0DKVCVpePqSeH3PFrFnUrWZEC0lOKxbgzezBqjqSEXXbX75bNtsw3PH75wLKX8bh0ZPbw29wO841q2lWYQZm0nOOPyRbuIKugvg3u4oDJdKz9a/4U3ol7xUWInsIG8oG9+N+yjpNUulV+QA4F3gDSJ1WEenIiIwgtBrUtxjWBeyeEafRCxGu0RZLEYLGMDyFXJgPxZqHfrzyPdASTJzPo8RVxuM+4sT9ef+ctpJrIPC4G/HJRoRCX5CgxyLoekSs+9u2TvtSAczRjFVdoWpS20toRpwS6JO6OmnXK+j4G872r8HPJGFjrS86l3XR9g3Ah9lg8qmI8dgBrnZSj+WIjiA7wIsVhQoGi3FaZE7v4szhwh/WPr4vUgCnYicckouGEu21wIcTgZa3CFRIdMoWpqyDCj5uoqWB/yiew29/R+i0aL6FixSpUdg2avAo5aAqawqwq6ZmWCN4dy9M8fcTQDbMLpsJJRd8LgQp+edsdoSkYdLFEIb9DvPejPzp+PYgu5+NY+UFMxR8exEWU/MxUno64DNYfT+FzfuCaOJSl5Xw7OXs28a+lEUkBlYQUhCawvnATJwTW7VqN8488e3+wpzrAqRKhLP9wbkbZa0B7lNgb5T0qE6ws4H0LgYv24VbKnUF4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39830400003)(136003)(396003)(376002)(451199021)(86362001)(52116002)(31696002)(6486002)(316002)(8676002)(41300700001)(83380400001)(5660300002)(26005)(38350700002)(38100700002)(6512007)(53546011)(6506007)(8936002)(36756003)(66476007)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(31686004)(54906003)(2906002)(66899021)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFEU29Kb2tVZnRtSElybWkzSWtiZmsvKzNKU1ZiTzdtV01zWEU0bmxLblcz?=
 =?utf-8?B?VHRseHAwS2JzZ1ZhUFZNK09GTExZK0F0VUpSV0VIR05lT29xOExHOENQaFBC?=
 =?utf-8?B?b09RbitUbTJUOFhKcjVKQkJOdW9KMFlkSS9jc25YcUtkMnNnTnYya1F4TXRq?=
 =?utf-8?B?WEdDaUhpVlN2cGdwOERYalBFZmtYb3dpZHg4K2s4alRUbDhKeE1wczQvcTIx?=
 =?utf-8?B?S05rd1k5RmxWc1ZiZVJuVHBvM1NWb3crYjJlVXVXVmk3NytrZnp3Zi9xQk43?=
 =?utf-8?B?S0FvUlM0VG5IMWpTcUFlN2t1c082NStvUmVKcFVobzlTeVZ5dTBrenQ4ZHF5?=
 =?utf-8?B?dHZsZDdKcHZjMmx3NFNDaHdtLzJFdmxvVC9NaE9RTjhESmpETHBrT0VDSGhw?=
 =?utf-8?B?ZGtIRjBJU0JRSTBqcElQVzdHUElWOThZWW5lenBEek01djdGQVdqV1p4MnNC?=
 =?utf-8?B?ZWZaMXdTeDVGVHdZV2hxcGNQalZhY1NHODUvbnA4SUxHQm90NGx6bDIvdmN3?=
 =?utf-8?B?R3dncmM0YTl6YncyQ25TSXE3cHRGalRZaHBWL0NMRjBaSHZNVGNGNXJ5RVBm?=
 =?utf-8?B?aGFWNjRQSFdMOUlvMWQ2aWc5T1R1REx6ZlM0elQ4Z0VVRmZoWGpXWGsyazZu?=
 =?utf-8?B?endEbnBKRVdhc1RvYXh2azR6Y1Zld1ZQczJNYk5yUDJOczZObExJWXpPZ2Rs?=
 =?utf-8?B?S1lLZFhXTU80dTlPZXltdmdZeXFYU2syZEl4TThOL1lTdWZRbUtJTjdyY2VR?=
 =?utf-8?B?cXdLVTUxRnFVTGtWV25DM0ZsZ0NhSnJGWTJZWFlEOUJkK1pONk0zTWEwcG1K?=
 =?utf-8?B?cXdLS2ZUOEFMVWx0ak9oOHBha3dYeUZoMC9WQU5yak5uUGg5dkhrci9MTGlU?=
 =?utf-8?B?U2I2SW5TZ0VhbWFPM0FJYmJ1WEk0OXBUakhWVlJndE1tWmsrdFZmbkVGbWc2?=
 =?utf-8?B?ZGFKK0x2b1lZZUpMUms5RzNuYzJJWEFCeDBHZjlpc04xYkljUFNZTmVUVzZJ?=
 =?utf-8?B?Ky9JYmhPUVZzM3NSVlZWSkVzSTVKZm9DeU5qQVVXYkd0VEdIM1BoV0k2TkNC?=
 =?utf-8?B?K1V2T3dnNDl0T1ZESnlSbTVPN3RvWmlIWldKck13QXFaQno5bUpFQWpTWGM5?=
 =?utf-8?B?YUtEQ21QUldyWHFOQjdzaWRVeklYei9ZNVUxSWVibFpVYm9VM3JzRHdMYVNN?=
 =?utf-8?B?OHdYVkVBRE1yMmRlQ0RxbjNZZmFhdUdUR2JKMG9pVllNS0RLSG9KVEdzRDln?=
 =?utf-8?B?R0FJaGxEUWMySXJ6b200TnVVWlY4VlZTZVNYaWFPQzI3MDdPVjFkNmQ1cndN?=
 =?utf-8?B?c1ZGWU5tUDI2RUtKR041K0pxR0Zick92VWdWVG1KVi92TzQydGlZcy9nb3or?=
 =?utf-8?B?MGFITEo4WC9CMmVvODRvL3dvVXJCTXh0cXMydk1UQ3BKYWE5U21HZlVSTjBY?=
 =?utf-8?B?aU5kUnZZRnlPUnUrT0FtcG9rTThsTHlWNEJZTWl3V3N1T0hlenBQdzVKVTE3?=
 =?utf-8?B?SU9wbmNIRjN2ckdvYmhmV3N6eEt4MEN3WUp1S0pidXlhL2lLS1k5S2Nmd2pM?=
 =?utf-8?B?bkxlTTVRZ29JNGxPQ0VpR21RZWR1T2JZVXRTS3Y5RGpFaEt1RWZkWG10L0VY?=
 =?utf-8?B?NVo4WWR0c21XRFZLS2VYTnducWRDdzRVRVVNeDJCcFloZldXSE9tRFR0bUl3?=
 =?utf-8?B?cFdhV3dsZVN5OC9qTG1OWmRzLzlPMjNVa053ZlVsbzcvVk1TOXhRU1FyUzdX?=
 =?utf-8?B?ZkNKZXR3RXZjZHVpSmQ0Q2ZuY0UwMG9YbEpFWnp1WkwzdlY2b09KdUR0UnFV?=
 =?utf-8?B?UE8zTFBUZHhFQ3ZOazhneEE5SzJSZml2dUJMOG51Rm9CL0xkZ0pGbG0xb3JV?=
 =?utf-8?B?WHpVbTdNc2ZQRnJ5bTZjWU11NW1leHNSL0dpQXVlZm5JcHQ5d3VKRkUzQXhT?=
 =?utf-8?B?Wm45amlTbjZZNllROHJEeWJMMEFtOHo4Vk43a0FZaHNJSlNXUlk4NVNxSVhh?=
 =?utf-8?B?R0RsMWRxVm5BdUw5OGdCaWhJOG1vNFZNTzZXR3NUQW0vOFh4d1lUblMvYVcy?=
 =?utf-8?B?T0YrR290ck4zSkNlOFJHMnpWZEZwc2hsZjhrNi9EU3NrcnRsWEdRZ0ZHdG45?=
 =?utf-8?Q?C1d2oaE4q3/tYkyCg44nyUaAs?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af926c-3f7d-406c-8d50-08db69d12e95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 16:38:55.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAO84+Ts96VTmJsJreX3mxm9ZfuOO8gaflQZjT2Hqnnqfg19jR8+pw1UzkX7TVW6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/10/2023 8:05 AM, Jason Gunthorpe wrote:
> On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
>> On 6/7/2023 3:43 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> We would like to enable the use of siw on top of a VPN that is
>>> constructed and managed via a tun device. That hasn't worked up
>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>> no GID for the RDMA/core to look up.
>>>
>>> But it turns out that the egress device has already been picked for
>>> us. addr_handler() just has to do the right thing with it.
>>>
>>> Tested with siw and qedr, both initiator and target.
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    drivers/infiniband/core/cma.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> This of course needs broader testing, but it seems to work, and it's
>>> a little nicer than "if (dev_type == ARPHRD_NONE)".
>>>
>>> One thing I discovered is that the NFS/RDMA server implementation
>>> does not deal at all with more than one RDMA device on the system.
>>> I will address that with an ib_client; SunRPC patches forthcoming.
>>>
>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>> index 56e568fcd32b..c9a2bdb49e3c 100644
>>> --- a/drivers/infiniband/core/cma.c
>>> +++ b/drivers/infiniband/core/cma.c
>>> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
>>>    	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>>>    		return ERR_PTR(-ENODEV);
>>> +	if (rdma_protocol_iwarp(device, port))
>>> +		return rdma_get_gid_attr(device, port, 0);
>>
>> This might work, but I'm skeptical of the conditional. There's nothing
>> special about iWARP that says a GID should come from the outgoing device
>> mac. And, other protocols without IB GID addressing won't benefit.
> 
> The GID represents the source address, so it better come from the
> outgoing device or something is really wrong.
> 
> iWARP gets a conditional because iwarp always has a single GID, other
> devices do not work that way.

Not sure I follow. TCP is routable so it can use multiple egress ports.
That same routing means an incoming packet bearing an appropriate local
address will be accepted on any port.

So still, I don't think this an iWARP property per se. It's coming from
the transport and its addressing. I'd hope that this can be gleaned from
something other than "it's iWARP, cma needs to do ...".

Tom.

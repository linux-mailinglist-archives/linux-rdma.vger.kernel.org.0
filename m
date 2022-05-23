Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39BC5313AC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiEWNZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiEWNZg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 09:25:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD234C78E
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 06:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvHaHc6r10z2lyqQ1mmkRi2jKQpTFXoEEDPv15jE49YAmLeV8aRaZmuhxDFVbS6oCT2URmf2V7mczwRN3aZGPzPXUPo6VmRiaUHBgCUjLCtM/Uz3HOwXC5+WsAh/0irSVD3E3eVc4cka2oHzz9EKRCoiLnr6V+pQs0bqpqqS48e683piq7NqO4taylBnSaQ83FckRG9VeStVCh8tsmVCDob3UfVL9aaA5PR79iKT+x43GvJWLePjhqJu9a3/7lu0xbClAPrhb064lS4rpa5vTl5Moq7b/4KIqtAItl4jKyf1RhbRSR9I6pDPlVrteRST8h88ELiYcDNft9Avsb/ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/BmKCjs7PazFF8w6XwOY3MaEIHmrfh8675GIhfXB7M=;
 b=P+PXkPQKHfMihXbrNJgMdi/P6Lcd9M6QsIqUEZJfOSfjvxmD+Ov29H5yBC7RBV079bp1Vc/DCf+Btbu00zXuuv83XI/e267st3s7mjNXAOBLQ+8hX23aYGM28Xn0PZS+Vq5UX9l49S9f3vM0bWEgdvm5WUdca2aXe1pE28g3ORGoHMPU+/4gfW42oD8hhOUsmvPraALbodYNcwthr6xPml5gSTMtpT2ieTksPsSWAp9doRMeR+9ZJqvTNVDWYjWwaLPLr74vNfLSdd7jJshO9/sYRsVgvitEUfKXe8vpvQB3x5F2Hws6QQFHyhT0EnWvDHKlQKNrs2wCJ6Rb5+FAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BYAPR01MB3782.prod.exchangelabs.com (2603:10b6:a02:82::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Mon, 23 May 2022 13:25:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21%3]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 13:25:24 +0000
Message-ID: <434eaddc-6419-bf89-9053-932906bce6e9@talpey.com>
Date:   Mon, 23 May 2022 09:25:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB263173D47513D1B16E1B00C199D39@BYAPR15MB2631.namprd15.prod.outlook.com>
 <27ce4b52-89cf-26a0-9452-f77ae59d9e7b@linux.alibaba.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <27ce4b52-89cf-26a0-9452-f77ae59d9e7b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb26046-1897-46fc-9a06-08da3cbfb182
X-MS-TrafficTypeDiagnostic: BYAPR01MB3782:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB3782635366D8460F9C5C6230D6D49@BYAPR01MB3782.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/lyibZ48aGi7CfSkH3MBcpRWuK155C+CVIhSdqFb+N40oNPi2uOqNgLJ8bdv6Is62rYPg8CvqWKzwajRA5jlc9H8NfUAXAfuoLgzNvDouj/iLVdEl25mz6CmCiiRfJ6siDi+r5FkB8r8ToOt208UjbpjulrYKBRON5TMvbGmrFpvhHjgr+1acn9c3AdayV19/5yF2dmtYLmB873+CktVcUEB04Srr0hyn5eT3/XoZxK0OeUQDDGLUgGyIZyZ+EB4KoaJpDXAP/nfVed7jqvD0byP3EB0crWyDuRFdzwSfLiISeKEafxjuOMwiY8SYNAjhjM3FgI1gcHZEAX2MnzwUXubiclurWGbZq7IESpfi+FMm0pGuBRAiZq2ksV5VNV+bXynv8FivlWM+ox2E8KQ5F8FP3gaNAkls4Cmtupm0u5ezrmENWdu/6o6TMw4/vJNyKgf7fX7AOlHNjSQ5HjcLn1kqdCGoWChm/uYyVPeIKy/SJiRdbvyDRQoiskHXYTP/KEJVvVsPF6xTx1ChOFq8XzBFNR8PUvr/qEhJgv4r5B7l/Mghi3sHmAYlS8OaXL6QDL0V5pJ5bxzPttCyXgZkypLLkVxyS4uuFIvU+oMt9ikay6ekXqeZVfT2A6GkoWsJXLmI2Ae09m3CtJSU2m2UAKlzR+Wfgp7zDPL1S57VkEk/+StlDDizROWYV1TxLNuJE8Yg2AGUUe+huQAt8O7cqXw9F4osuGFbAB2iu/ZzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(39830400003)(376002)(346002)(86362001)(6506007)(5660300002)(38100700002)(83380400001)(2906002)(6486002)(31696002)(8936002)(38350700002)(508600001)(316002)(52116002)(6512007)(54906003)(26005)(2616005)(110136005)(41300700001)(186003)(31686004)(53546011)(8676002)(4326008)(66556008)(66946007)(66476007)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVGV0F4aExMNytaNzMwZ3ZCMnAvOWlYMTYvREZMVHNub3doM3FiVnVVOG12?=
 =?utf-8?B?L1puT2JENEFxNVpJdHVCTXJXV1JxRjZySmFTeE5KWVE1RHllbkNJWUxxOU5R?=
 =?utf-8?B?NzhjaFFwWVBFUVFsMk4reGxCZTJhUW1udktuUEFmbVRMcTlEODdyV2t0RTFX?=
 =?utf-8?B?QkZpMXBpRE91ZmtDVHVqL0pSb01MVGtrTFFRVjMrcklBeVMxUUkrc1QwL0wy?=
 =?utf-8?B?ZktzZU5aYjBFbm1MUEpDWS9pYTc0Q0VTZGFaWFJBd2VXd1ozYk5CeXVxSXBE?=
 =?utf-8?B?V3BzZWFwdUpyOGFUdkZZSG9TSEFYbUpER2FIZ2ZIOWVLMXFnb1RuczE5VEY4?=
 =?utf-8?B?K3FZaVZzRnZYWmhDMVE5QU5qaFhyWW05MEFXR3RGZ0lPUDFkSzU1VjRFSitZ?=
 =?utf-8?B?Wjc1TGRpQ25VQUVZM3RPeXdvRDQ1QUUxYVVCSE9KaGNIWFV5RE16Wjl0SVcy?=
 =?utf-8?B?bEFiMGJleTNGWXhmRklQQS9vQVcrRHcxNXpuTk9Od2M0bm1TRjE3V0o5Q1VU?=
 =?utf-8?B?SFFYb3psN21pdTN6alBweW01azRTckFqSGtpdmhHV1ZUZ1JGTnlPbEZrMjl3?=
 =?utf-8?B?TkxKVVlucEQweUYvekZKUGxyYkdKL3dZUHdUQkdiQzRXS2QxR0JIeHZQVms2?=
 =?utf-8?B?SHRjOHBDbERhcENOOHo5TnZQUXJ1VzFqK0lOSldTbnRCOWVUcC9TY3p0eHhH?=
 =?utf-8?B?Q0hOeFpqS2pnWnFBeXc3bUhhVDVCZUwyd0N0OGF2elpKbElKODl4bituNk0z?=
 =?utf-8?B?bHVCLzdUY1RTSmxvdE4rWFk3MVI3TFh3Sk5lRGd3VGFDS1hCQmlVaDJLMVhp?=
 =?utf-8?B?ZEttUGNPNUF6eDBGVmw5NEdkUVBnN21JS09mNS9XSVdJRTdqbnV3NGJIVTJ1?=
 =?utf-8?B?bDNCRlBIMFJxYlBBRnBwM1FpbzNNL01ybURmelZWWS9kMHkwbXkyKzBOOHpx?=
 =?utf-8?B?dzVyUkJLVlZ3TU1FWkVucHJSWjQrNXYweGJ5ZW1xdnRmSzUrUm1ERzJnYUs0?=
 =?utf-8?B?TmcvNnR4ZUhRcDB6UEhWQmpEYjJXME9NL3M3ODFHa2N4NERHb3N6L2JZVkdV?=
 =?utf-8?B?TUtWLzdCMitaRVI4Yk9uWHZvNU9OdVRCUHNjTkIrb2N5L2ltcEdKOG5zRGJO?=
 =?utf-8?B?WWFiMVJyU3JmeFpxVFdVYkpycjVIQ1YvbHhRcFN1V0VSQytOTmFJcjZyK1d0?=
 =?utf-8?B?QmlSa3lWWWpXMTFaSUUrWlpTVXp6VTFpdkF5S2V5MUc5K3hJc2ZwaSt1djZt?=
 =?utf-8?B?ZTAzdmhiY0J1V0ozRThiazI5NXhzQ2ptemdMcWZ0Mk1TV1BjM3JXZFI4SENT?=
 =?utf-8?B?Z1UyRExmK0NudHM0alBjdEYxcU9GZjdMODgySlNacVNBT1NDci9JMEpUQ2xG?=
 =?utf-8?B?MU5ZZ1g0bDd2OGo5WlhiWHpHcWRVQ3ZvbjJjNGxJYXk5Q1oxazMzbVNPazdJ?=
 =?utf-8?B?eUtlTlJNNGNnellLNEt1aWsrcnFyc3Y2cWZqeExNYXFGWnd4Ym42ZFF2aUE1?=
 =?utf-8?B?WnZNY1o3djFIVVpVdUltUllDbTFMTlpsWGlSa3FIQy9BSjUwVGYwR3FJbjEr?=
 =?utf-8?B?R1ZNbTJ2ai9aS3hwcWlTSDhUY3htbDF6Qk4yeXIvS1JCUm4vU3FsaXRtakk1?=
 =?utf-8?B?bnZSaVZYYzByRCt0RHMrSDlneVNOK3RPYWp5ajd3QXg5TEYxb1BDOWpLRHBC?=
 =?utf-8?B?b3U0QUViaWc4NkQ3UTlGMVZBRkxxd3d2eFBwYVVSN1VCd0dXbFRiNEgxd0hi?=
 =?utf-8?B?R3B6ZW9pQTkxaS9BU0Y1N0g4bVU5c2k4TmZaRjhBem44U1ZjQzIrNEJIQ3E4?=
 =?utf-8?B?Ny9kalJGaGxKYUNKMUhzb1k0dmVqNlQxdFVFaWNSdVZ2RWlMUkwra1B5eHVu?=
 =?utf-8?B?dEJrYlpVLzRiaWxUdHN0ZkRLN3ZPM2FZblhhMWJidXJ3UGN0eUxiTnVHTEFD?=
 =?utf-8?B?b3dUemd0WHRVaGxkN3VpT1p2bHdmR1VDdHVseFdBdE4vTE9ONG5SemxDb1NT?=
 =?utf-8?B?ektueDFLSFc4Um41UjdWNlFDSGJhVjJUTjRQamlIYVNBMFFUaDZPWlE3VTli?=
 =?utf-8?B?UC9MWUNBQ21VRXFaSkJiTExlUk9peU16cFVJSlFJUmxHYU01MytZaG12Z1Fz?=
 =?utf-8?B?OHkyVE5LZ29sbnV3NnpjUXZSUWM0dVl2MElEMjRYOGVjdmJpZWhFaFh6MzZI?=
 =?utf-8?B?NkxtREpYSW1tV2QrTEI1V0NKM3ZNUDVBVytNOVFjSHVZUFVXTjBPL05lQzVD?=
 =?utf-8?B?WGczMU1ES2haeFN3Z2YzWkJVTmM3M0FzMnRxSU9wYkNhL3I0V1NsYmxTTDlQ?=
 =?utf-8?Q?EbhDCbdXgddEVDiZhH?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb26046-1897-46fc-9a06-08da3cbfb182
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:25:24.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7ENUEExfG8gljy71nwDGY/PERVNU1MDVUx26CyVIH/ZOXmvL5pHocWcvCotLozG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3782
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/22/2022 9:39 PM, Cheng Xu wrote:
> 
> 
> On 5/20/22 11:13 PM, Bernard Metzler wrote:
>>
>>> -----Original Message-----
>>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>> Sent: Friday, 20 May 2022 09:04
>>> To: Bernard Metzler <BMT@zurich.ibm.com>; Jason Gunthorpe
>>> <jgg@nvidia.com>; Tom Talpey <tom@talpey.com>
>>> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org;
>>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>>> Subject: [EXTERNAL] Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the
>>> erdma module
>>>
>>>
>>>
>>> On 5/20/22 12:20 AM, Bernard Metzler wrote:
>>>>
>>>>
>>>
>>> <...>
>>>
>>>>>> As far as I know, iWarp device only has one GID entry which
>>> generated
>>>>>> from MAC address.
>>>>>>
>>>>>> For iWarp, The CM part in core code resolves address, finds
>>>>>> route with the help of kernel's net subsystem, and then obtains the
>>>>> correct
>>>>>> ibdev by GID matching. The GID matching in iWarp is indeed MAC
>>> address
>>>>>> matching.
>>>>>>
>>>>>> In another words, for iWarp devices, the core code doesn't handle IP
>>>>>> addressing related stuff directly, it is finished by calling net
>>> APIs.
>>>>>> The netdev set by ib_device_set_netdev does not used in iWarp's CM
>>>>>> process.
>>>>>>
>>>>>> The binded netdev in iWarp devices, mainly have two purposes:
>>>>>>     1). generated GID0, using the netdev's mac address.
>>>>>>     2). get the port state and attributes.
>>>>>>
>>>>>> For 1), erdma device binded to net device also by mac address, which
>>> can
>>>>>> be obtained from our PCIe bar registers.
>>>>>> For 2), erdma can also get the information, and may be more
>>> accurately.
>>>>>> For example, erdma can have different MTU with virtio-net in our
>>> cloud.
>>>>>>
>>>>>> For RoCEv2, I know that it has many GIDs, some of them are generated
>>>>>> from IP addresses, and handing IP addressing in core code.
>>>>>
>>>>> Bernard, Tom what do you think?
>>>>>
>>>>> Jason
>>>>
>>>> I think iWarp (and now RoCEv2 with its UDP dependency) drivers
>>>> produce GIDs mostly to satisfy the current RDMA CM infrastructure,
>>>> which depends on this type of unique identifier, inherited from IB.
>>>> Imo, more natural would be to implement IP based RDMA protocols
>>>> connection management by relying on IP addresses.
>>>>
>>>> Sorry for asking again - why erdma does not need to link with netdev?
>>>> Can erdma exist without using a netdev?
>>>
>>> Actually erdma also need a net device binded to, and so does it.
>>>
>>> These days I’m trying to find out acceptable ways to get the reference
>>> of the binded netdev, e,g, the 'struct net_device' pointer. Unlike other
>>> RDMA drivers can get the reference of their binded netdevs' reference
>>> easily (most RDMA devices are based on the extended aux devices), it is
>>> a little more complex for erdma, because erdma and its binded net device
>>> are two separated PCIe devices.
>>>
>>> Then I find that the netdev reference hold in ibdev is rarely used
>>> in core code for iWarp deivces, GID0 is the key attribute (As you and
>>> Tom mentioned, it appears with the historical need for compatibility,
>>> but I think this is another story).
>>>
>>
>> Yes, I think this is right.
>>
>> If you are saying you can go away with a NULL netdev at CM core, then
>> I think that's fine?
>> Of course the erdma driver must somehow keep track of the state of
>> its associated network device - like catching up with link status -
>> and must provide related information/events to the RDMA core.
>>
> 
> All right, and get it. I'd like to hold the binded netdev reference in
> our probe routine, and send v9 patches.

Cheng Xu, by this do you mean you'll drop the reference after the probe?
In addition to watching for link status changes, I'd expect you also
will want to monitor ARP/ND changes, maybe even perform those in the
netdev stack rather than your firmware. Does your adapter not also
function as a normal NIC?

Tom.

> Thanks your time for looking at this, Jason, Bernard and Tom.
> 
> Cheng Xu
> 
> 

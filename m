Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCC71F8D1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 05:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjFBDQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 23:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjFBDQG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 23:16:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2105.outbound.protection.outlook.com [40.107.101.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4931B0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 20:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtvHLAt0lJg3ZgIvbYLrkKcfOmgUvDa5QqVVBPVAyB76wJTiRdEDBrkjb2fuy4QZ9EC7N1wZi+ARh+ymA+GOtPXO+AHQaMQJ/aP5oA2CrhPi8hxTrq/WDKcrp/CE+NtoztkLW6AMwNrWelloawJVZmuQR5lFLEWo8oMNraMmoWeb+36C3IxSdiqtt6IIZkNSiqroJ4DsIRKIOqaUeIQzjTACsWWK+BrYkAatG7SxUOafbpjN2UnY7sRZVIFaeCIHJLKEVLqRG1y9tkcvYF3E8zbxD3PeMMgM7kbYOnQGnOndYtiwCo4fTiTDEmzLDQaAKNa94IvZ7nlCr3D7Sru/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoGDdBCykY3E/gzC7EZkKMfT8JDPEmVPf7gbkdOry3Q=;
 b=gzVDKJO8bbgDNT9EiTPa/MxHXteNhR0z22BokbT/Tl6PlkuxoNXHTbfb7nuvCkEY3dP73/dlxku4P2sjYJRmFGE5mVClyeMxbmyr/dNBamrtTWXLw5IRME6dIqPbxtY8bJVq8q5PElGpteCUB/YoqNPpOKpAY0YlG/ls80zbXAEuXzewqUvWq7OgskAnXmrB/gq2mAlvKsHRdV4cNLKnmDtTbX0ebsvq1TpOOmpfKRMM1zWkL/WZuL309IT4cQ0+cmtvUEozNJPevh1OlD8UBIZhWcac9JZTNSY9m3s2M1CqEscrNJieGfCeWcEFEZ4Iiw3OjUpRyJgX/1kYV1R9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoGDdBCykY3E/gzC7EZkKMfT8JDPEmVPf7gbkdOry3Q=;
 b=ERb76k1lKEr+Ws2JKa1Vy79twkRW9fsNOlm5ATSVdmqrZ80PcgAclXvMdXOzEeLyCRGvpxyMutpwqxF7wJqX5d4yT6MAjvEcbkJ4psbaRCqjEhculvZcOgJY+0VZICNy9YTdfM710wYejlk4k/HjrP9pUGbaIZHnmMjACpjDqmOgT9nf9E2HN2e4Ty0DPrbcIW1ofZfJZnjm9RHqU7lJQzlxJUDr9MDDD4paDcue4F7f1/jXKyNTqQTZmrjQzuiYtGlk06guDHjqsUtNepCFxDiEq3x2u+4XhfYo2n7AoowiSmxXcHo+3iHw3R/9vwho8QcAeQA1pDJbtycUi6ZXFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 LV3PR01MB8510.prod.exchangelabs.com (2603:10b6:408:1a4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 03:15:59 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%5]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 03:15:59 +0000
Message-ID: <bf7ef2b8-26a4-39a6-5be1-bbd25d5c0d7c@cornelisnetworks.com>
Date:   Thu, 1 Jun 2023 23:15:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
 <ZHjZQOYgNW9tllNx@nvidia.com>
 <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
 <ZHjqacc3eKiJ0Kt0@nvidia.com>
 <5f17fa1c-57ec-2d0a-a14f-507c656d5828@cornelisnetworks.com>
 <ZHkfqWWzaaUhMbZP@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHkfqWWzaaUhMbZP@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|LV3PR01MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4a7751-cb83-4e31-ab77-08db6317afe1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qU9bjsp5rsVQVlpbKOxZeGFfPrhaDUXPhtcWegot90+shMsgXe1r3Ev0GnLwuSdHlDAYHJq51NbOeP+A7TGowoRUXxvxoGqShzP2JKJ3h5nojTcFk5Q5HmI/36rY/17btVGXcKPkQOtDABB6t+TUO9iQwFGAQKHhLTPFHZwX3kK31i/GkfMhTl9n+wggBbHt7oPaSj53u0oocwPT2HXDiSiTkiJ+1lyLj9pAtPgKEtHBXnK1nN/KYsWDwR0R0yGMtGL8qxAxqBJSo1cIORNThRVYfE2qp+U23VQ+XnU47oJegc2uz0O8i4ZIYqAtEr0JOwjHfo8RVPezWkS26nzDwrGpiuBrAdkvPe2Wx69W2ATpGZ+xfNGYyxBqLBsgRdmhn0gY/Tv4uEvyKBnrpJDm2wuE9TpDmSNn9gwiJYRy9Rp4YP9I22xi/OtYGB+CXc4MJzifMfLZZXCfLrfXiuoylrVDLoRFrlmH+lXEs74BdpOYgc8OyNPEul6N6M4fLUlEHDRQoXSC7chJthgTml6e2YpB9Di+Z+1ufTcXYaK5d/M6RrMZUtfyhRlgDTp7f0tYyFrzirxBmHnZQBsnoExACzhIGW7ROKA1omqNu+quycV3OvEV4x9Fxe0zCpCtrFm5qPotX2UcI928Ye6x7dJdfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39840400004)(136003)(396003)(451199021)(6512007)(26005)(6506007)(53546011)(186003)(4326008)(6666004)(6486002)(52116002)(2616005)(83380400001)(41300700001)(316002)(2906002)(5660300002)(44832011)(8936002)(8676002)(478600001)(66556008)(6916009)(66476007)(66946007)(86362001)(36756003)(31696002)(38350700002)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURVVGQ1YXUzTUJjQTBKOUxicTlZOUwvQmViTEoyV3hTRnJ5dzN5Z1lmZjlO?=
 =?utf-8?B?QmdGRXJLYWdwOGlSM25nTTBvQXNJRDM1VFVvbm1UVEFHZ05ZN3ZRMXBBZ0NS?=
 =?utf-8?B?Y004OFFLQnFWTEhlaEc5VXNjZno3M2N4VUUvVENpYXVDaUpuQ1NTUjdlSFZP?=
 =?utf-8?B?c0l3TDg0b21XSldma0FLU2kwT0NEMmM1TlBucE9uZ1hZRjNoUlh6Q1pvS0Fu?=
 =?utf-8?B?ejdDd1paaVZkUjdtTXB0aEpSenovZENGT1EyUHp0dDczRFBNV1hhMEJYc1dU?=
 =?utf-8?B?OVg4YXQzUGVFRzVBQllOaWxZSmJMQ2FmTHRmT0NEQjAvdHlKc3NXUk0wejY3?=
 =?utf-8?B?VHkrVUJpTEJlMk1odzVMT28wOEg2eGR3VzNvZjBpb1ZhUTg0c1lObGI3L2pC?=
 =?utf-8?B?T2xsa3dDdlZSYVlJMnNDWmpEdE9KQVNWdE9CK1c5QUdRVGY3WUtJQ3JCUWdp?=
 =?utf-8?B?WkRKaUNlY3lyWmt1MkE1ZVNTaG9sYnhDeE56SDVYV2tRZ0VJV3N0ZS83Q0dF?=
 =?utf-8?B?Y1Zqa3BXZkNWaGJjb2NvcHdtaWgwOWpPU1F2ZFduMDFYMGhlNWlzVXpKMGNJ?=
 =?utf-8?B?MThoejF0Mld6YWw1M0Z3OTZWSElKb0FLSzlYUnl6RzFJa3hpMU9rK1dOT3ow?=
 =?utf-8?B?NXU5V3Z1R1FNWUVkWW1hQUNUZFdFQTR4UUtCOFQrV0pjSmNpQ1o4VXZIeWJz?=
 =?utf-8?B?RzRMc3p3b1NWcHBtNlpLSnE0SnJ5LzdacWhzVFhCY0UvNGlLZHdBNSt2MkpC?=
 =?utf-8?B?a2srM3N2Q0pkUVo2M0M1UWVIZmVBazNrcjE1dktORXpDdm5zck1nZkNmRVJa?=
 =?utf-8?B?aXY1TENYWjFWYUZuM1NsSDcvNzlVaWoxVW1OVExmV1NtaXB0dTJBSWl1aVJm?=
 =?utf-8?B?ck9HeG5nSHVOckllMFlQT2hDMWJUSFp4V1dWOE0ycUdBTTAzbHdYRkd0T2c4?=
 =?utf-8?B?dDR0a1VzbUpMSWhIanpQN0VrUXRNQmV2NHc2bGNrQWN2OGM4RUJPOXQ5VkNS?=
 =?utf-8?B?Nmo4NStaTDJIRkRIdlpKOHhZcU1kUUtTWFNCbjYvYmxHUXRnSmRyQU9RNFRl?=
 =?utf-8?B?MlBGUTBIaDAwOCs4YU51VEhXNk1ieGZhRHZkNjJmQXFzYjBXbU5XQ3RsVWxt?=
 =?utf-8?B?NmZNeUdPYlU2ZnlSMnRibTZPaHpvQnc0bERWZDVRTTA3ZEpkVHlpMWNPWmw1?=
 =?utf-8?B?bHRyUlYwOXJiaWN5bm5NVTVxRjEzMlhWRUJFeU9QcFkzMFN6YVFHR1VPSmZO?=
 =?utf-8?B?YWRXRXNhNzFBYnRXYkRKc3U4OSs0NWFJZHJzUThKeGo3V3pKRzdEU0oya3Bj?=
 =?utf-8?B?MEwxM3Fxby9qMWJtam5EQ1NWOElsQXRGc2Z0VEUvQ1VWVmI2eVNjWnpBTVky?=
 =?utf-8?B?bDZXU2lKZHcxa1dWcEcvZHJPajdFSEZnUmNHWGxZN0h5THdNVVhrTTh5UnpV?=
 =?utf-8?B?cHNxQnhWU0hydSt3b1Qyak9WRnFwS3djY2NuSUVxZEtvY0V2QmNiTnkwKzBO?=
 =?utf-8?B?SVV2WmVQc014MTI0NGxlS2ZXVWZ6L0Z0dVRtMDh3T0lFOGxTYVp1dEkzQmd0?=
 =?utf-8?B?Z1A3T3JPb1oreWlZZXdzWkFNSC9wU1N4TWJhYXgvTWVGVElPK0dROVo0WDVn?=
 =?utf-8?B?MTNTclZwaVo3Zll5VzNGNW53U0grb2lBK2YxQmVHQ0dQbkRmYkEvYkkrZjJy?=
 =?utf-8?B?dEJVQ1JMSVl3TUhhRU9qUEx5ajdRNTJadlErazQ5VktZQVd3STJDRVZmSXRy?=
 =?utf-8?B?NmhYYUU0M2s5VEltQ3FscDJDeVQyQkZMOXB4b1NORVVjM1U5OUpVekNoMFox?=
 =?utf-8?B?NEdRbVcvV1R0TnVsbW43MCtoSUpHaFVwTnZaUHpxSXhJSjRQTWdZdmZnVEdz?=
 =?utf-8?B?Tk1TSGJUdzlOQ3RZVk5rcmxoZGRLdHl3cFh0VFM4TjM4emk2dGFETGdIaCt2?=
 =?utf-8?B?Yk9uL0pwNWhqV1pUS1Frc3Jsem9qdzRNSy9UVUpGenNnSFo1eTZ3WTd1L3FC?=
 =?utf-8?B?RjF2NG9qVXFTQ1JNTHZLMjM2L1NoSnVkZWVjQ09LTWRDaWNmYkM2K1FGRVJ4?=
 =?utf-8?B?TDRJY3ZYSjRPNmkxcHhOU2x1UDMzZzVraHQ4NXFCaWF2MjQvNThoOHZ4cTg1?=
 =?utf-8?B?SG51ZFlzZU9hNzNHSXV4ZlRNTUFOZDh4WE16WlExMFN2WEpQZmZHc0plTEhj?=
 =?utf-8?Q?kYUXzoYM0SJPWHH750fKx3o=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4a7751-cb83-4e31-ab77-08db6317afe1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 03:15:59.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOvysfTO7Mlp3YiUwodflPvlgVfAO9zVxSAZWpD1yVYLI2+0vBx7n4KWmqa33KrWeD6+gI5hMD6pW8Q9Bj6mn47RHdgJ1QXoroZjkxQA9+46u4BmnlOzbzZKpUkI0Xs0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8510
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/23 6:46 PM, Jason Gunthorpe wrote:
> On Thu, Jun 01, 2023 at 03:11:44PM -0400, Dennis Dalessandro wrote:
>> On 6/1/23 2:58 PM, Jason Gunthorpe wrote:
>>> On Thu, Jun 01, 2023 at 02:15:59PM -0400, Dennis Dalessandro wrote:
>>>> On 6/1/23 1:45 PM, Jason Gunthorpe wrote:
>>>>> On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
>>>>>> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>>>>>>
>>>>>> In order to handle user SDMA requests where the packet payload is to be
>>>>>> constructed from memory other than system memory, do user SDMA
>>>>>> page-pinning through the page-pinning interface. The page-pinning
>>>>>> interface lets the user SDMA code operate on user_sdma_iovec objects
>>>>>> without caring which type of memory that iovec's iov.iov_base points to.
>>>>>
>>>>> What is "other than system memory" memory??
>>>>
>>>> For instance dmabuff, or something new in the future. This is pre-req work to
>>>> make it more abstract and general purpose and design it in a way it probably
>>>> should have been in the first place.
>>>
>>> But why is there uapi components to this?
>>
>> We added a new sdma req opcode and associated meminfo structure for the sdma
>> request.
>>
>>> And HFI doesn't support DMABUF?
>>
>> It will through the psm2/libfabric interface soon.
> 
> I don't want to add uapi stuff that has no use..

It has a use, psm2 and libfabric both use this interface. I don't see what the
issue is.

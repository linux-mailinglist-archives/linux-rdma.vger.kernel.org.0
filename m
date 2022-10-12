Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2B5FCA05
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLRoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJLRoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 13:44:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C2FBCE3
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 10:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2S9JJs0KNEj/Hch9O7YhFYEGgalM9lLWYJsETdZGUYprYYwDBwGotoBR+xWOBJ384JagzvvreM4ruqCy77w+8BPV6ar8hSJ8Y+Ld82iErlmRIoFo+kvHL3kPR0AKe2wiTYsa0wC2dfOV0uNHvQgE3vSeZOxW4M23Da/Y1ChlyQOEulKRarH3za4iYPsTm2oKBGmhAnJbUZYmjlGdNtlA6dLuGKxVCvuE1UTsLLn2QCdhPvHt8GiuLgKxjiik1L+hfVGO2fP2OTPkWgYRstdwkG276DozBubQu1bJzgsksJXYhwzYnlllUjmCPP8cQroVpayViFHJ2J5Ts/b6ySavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b7Xq1VbZQVl89e3qRwanN2cCeRgJVQWCrq1pqO9ugA=;
 b=D6g+aMtE0QDrFlaHXu11t1OjOkGxM85vKuFeoRtg7lZOKkCGcmM6z6RZTpC9UITvzdVn4GFGShya8l2zX9JF4huvzyCFR2KD75jN66r9rs8kIMmWDAVjsbXnn6ws2jFj5y6PqS2NpGvpArVhjZkjB/5m9R8KmG1Ynb+oxThfzu4ozeppWg11csacWk73STJ/faBFahQtkWNsr2XU5RmIuNBV4RXiPua4DOnazRcuiuBcJ3O7xzeDc2/8IS0sSdMhWG8bmgPpEqX+ZuQjwukNwJaFGrZU0/uhVpW6aVB1JX/8p68LpSVFcjfafk5HMxHL+I42oJyFG6SGK47YCpcpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BN3PR01MB2162.prod.exchangelabs.com (2a01:111:e400:7bbe::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Wed, 12 Oct 2022 17:44:07 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef%5]) with mapi id 15.20.5676.028; Wed, 12 Oct 2022
 17:44:07 +0000
Message-ID: <529db79f-bf8f-2bf5-7377-b37a3d9af7b8@talpey.com>
Date:   Wed, 12 Oct 2022 13:44:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: RDMA/rxe: Receive wqe flush error completions on qp error
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <3867f7a8-80ab-f3ee-e631-63756fefb82e@gmail.com>
 <BAF00661-DBC5-4B74-9BA7-FC17BBDEDC59@oracle.com>
 <ec131623-075c-f94f-3051-4a2c28cd5902@gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <ec131623-075c-f94f-3051-4a2c28cd5902@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:fc::18) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|BN3PR01MB2162:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ce19f7-be17-4d9e-c17d-08daac795c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j66MxEQTgmT5aLpRjlx7jJOEqRsNZDfOQd3C5nkTO+ZMgk3lChS3cZSH6JIRceDxfnUQJezLAKBtqH5AXPfLPEpprqQH/q7gHKNkP/N9Adwdw6QzuJ/cJNPUfubfQpmpXkze7qhB7t+B8IA1t0Ch2EpU/aM/vtvDx+u7Uxstsp7QLCd2rroZy3oa0S+jE7W3371nHcRimS7tSesjuEIr9IxiTpj4UY0FWpjF06wY2P3gXE15+Kqvln32/I+SX3EDUgk+45u6gVntGtrZJEbJTk6UmjEKkRI+1fVFZqrj7wkYMRqRUo96BsejCpvXXBITyo6dtraxMjTcIXWG2JpCnvmP1H7Pqc7ohiVkI8OQZToM7A0KcPNFv58vFoQu3qggFMdBMGVHfBhlWnl1HF2U6nMgbH7hoBSdBiUaT3+58VR7OuYQ7lwmpIUCckEGhxaW2Awp6cYDBoJOV079Hievy4wY3BlDIQY0wLAd92+EpZc3fwzO97JoYxSQWphN4MtUkC0Pq4eDwLUwQ9NYoI2b7hLRcpJ/gV8+QzTuT4Zydvz+g/k27nsh2j8RHoYW1/pZsXrh0ZhomEsMbytesLzhg5AdmHi55Txhz7IuduuEFbhvDLrW5STBMGqy2ISYTS1Uqcuk24nHArmq7AreNrkkZGJwEhksMmx461Yb0rKO1Y7KpzEF/UvA33bDtbX6MOX9h3Ys2yH4gnewF9MerW3GyiytSX61zFiYnndE6CcYLNislGPpuXBAbZ+jESUsvbn0yC/9f4IucZu72AuWZjpDQNWW7lAlXr2tIhz4R84IMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(366004)(396003)(346002)(136003)(376002)(451199015)(31696002)(38100700002)(26005)(2906002)(6512007)(66946007)(66556008)(4326008)(41300700001)(8676002)(86362001)(36756003)(66476007)(2616005)(66574015)(4744005)(5660300002)(8936002)(478600001)(53546011)(186003)(38350700002)(6506007)(52116002)(6486002)(316002)(54906003)(31686004)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlSOVhUTXFWYjNVL3BTeldkSDdmM2Z0OHdTR3lFNGtZdnFnOTk4bjJEYkVT?=
 =?utf-8?B?dkl2aTFOVEVBTU1aU1FadnBSS1UyQjUzd1BWWFErNHYvanEySTRWU2pRdysy?=
 =?utf-8?B?dkxsSUJLMnhXR2plUmNLZTZ3K0tBNTFYclBxRnRFUnlwOGlublNyeFEramFK?=
 =?utf-8?B?c0hSWUpWdU1pbXVHTVJNdjdjb2tpUENoMTRjcERQdFdxMGx3MlU1MEFJSW8z?=
 =?utf-8?B?dm9jMHAzc01FNVhoYllIVTJYTC94WE1ZbGNkSkpaWGU0WFVVbDRHSWNyakRa?=
 =?utf-8?B?SFFmMjdxaVFHODArdEZwMzkwb2tvZHZzUk9MZXRiVFNodDJmV0NRdmR2YXJV?=
 =?utf-8?B?TlczUU1JbHVPaFRrWFcrVm1oZ1ZmeUlHOUhvTVlNYnAvRUIwVWVDY1F1QlFX?=
 =?utf-8?B?bDNYRXlpNUpXbEljK2REOUdEOHd3YUROcnZFTUNsMjhyQmZ6SWlXNE5sTzg3?=
 =?utf-8?B?L2phOE5oUjhzb2JQZzk5TWl1TmZPNjVTa2x6YTFYMDhacWxIWFZkbHpUYW9o?=
 =?utf-8?B?OHhjaGQvWHN3TllCZWFRdGpTUGFCejZycnZiUGllbkJjQXFuYkZMSE1qTXV0?=
 =?utf-8?B?aUxRRkF0bHRhN3Fob1R5ZHZ3WEdDQzk4bTB1OTFwa3h0bitrRlBpanVwYmJB?=
 =?utf-8?B?Y2FpK3dqdnBpRmZ3VEtPZndJVlE2bDhQZU5PV0FFVFozanNBbE8vS0JHMHFy?=
 =?utf-8?B?bWx3bmxUUmZBOVJYaytVMWVWaEVjTkZEUGptRzJDQnYwSXZKV2tsYnBKZnJo?=
 =?utf-8?B?YlR3bnBmazdRTkRZTjE4eGRzcEJGVi9Xbk81c0pqSTVna21ZTW9KNEhEVy9O?=
 =?utf-8?B?SERtWFY4bTNNcWNtZmVGaFB5U2JOVVhleGcwZWFGZWp0UnJMZlo3YVlZTjVP?=
 =?utf-8?B?V250V0JIY0M3MEpzbFFERFFFejZ2alNlZWxhRnFvVmFsVjRKSlJaTWFNaW14?=
 =?utf-8?B?QUR0WE1ReWFxWi9zT0hYTDFxbDY1VEVlYnlGc2V4bUNveDdxMFYrdXdXamFx?=
 =?utf-8?B?cUZRYXBDL2NJUytncDVlbGdKNUkxZDQ2VHdiRGRCYWNoMnE4cTdKeTJQVVBY?=
 =?utf-8?B?LzQwOGNNUjZJWXhPTFovY3UwbEwyS3pLT25ZV0dNNTBJZWFOY0NIbEpOQnM4?=
 =?utf-8?B?YndVS1lNbjQ3ZmM1aXo0Z2VUeHozZDRhekVPQmlRb2ZVT2VHMUpPODVjSzRK?=
 =?utf-8?B?ZVdhWGg2c1kva1VsQ1BJdkh3VzluNmxKNXNQdjh2V1dPalByWGpOSUg0NzRD?=
 =?utf-8?B?blZaL2FOY0ZyRU1KNnpRalRMZDhscVVkSkdWanBLMzdpbmpnY01DNWVVYllN?=
 =?utf-8?B?UWl1ZjBMT1FENnlUaE11Qm0zQnU5RDFpUVluRHhEWWxDRkJ5ZmdHYjd1QkVE?=
 =?utf-8?B?WmlwY1FDNzlBckMxS3BBaGZrVDUvb1hwc2hoVDJsRHU2NzVib2l3RENLeFBF?=
 =?utf-8?B?MTcxd3pVQ1JMOVlWU0pSd1Y3N3kvNVMxZWdjdjlPcmNhUnNSOWlJSmxOWHFz?=
 =?utf-8?B?T0hGUlNiS2IvaEpVN3Y2aFUzdEdXSVB2dTAyZytBeXdkV3ZnM0ttL1lhdG5M?=
 =?utf-8?B?STVnK0Zza3Bkc3FTbW1NWnNPMERWdDZlWU1WVnRtMHdLU2g4U1JmVE9uNWMr?=
 =?utf-8?B?L0o5QTNCL0FxaVIrRkU3a1dXc2h3S3NtTTRpNElBb1BTSHdKQitJSWNJZ1h1?=
 =?utf-8?B?ZTVBNkNDM1JwQnNiU1hzaFBmWXBnTjE3bWJZZ0lXNDE5c1hJeHE3VFVHUnRW?=
 =?utf-8?B?dlpjdkRVc21ZeElPMWRhWUVJcDRqRFpEMWdsa0JIdDVFbjBuR3V3MmsxTW03?=
 =?utf-8?B?ckhEYjBSUHlDelJRNWtnSVYvcVI5OXhXZWFXY2wyaTMrdUhBQ1ZnZDdzeFZT?=
 =?utf-8?B?VlAxVnM1VE1zUmJSYVVkVDFFVFFydXpaVjl3R1BvZjVlQkhvNnhoVXdZU1ZI?=
 =?utf-8?B?RUhoSFpOOXpVSXhhQmluMHZzK050VWhrYUo2OFZwQmNWWGJYSHFNUmpGMDZh?=
 =?utf-8?B?TndoY1E0QThadURwbFlFeXpmYy9LN0E5T0IwdG5VVUM1V0piZmxlVVBuNi9a?=
 =?utf-8?B?Z3p6OGl5T1drTU9nVzFnQWtWNGRwTFFkelkrN21VQXgyWGZLQWo1bzdBdUJS?=
 =?utf-8?Q?5XjalOSort0Qc77zjPjwU9jNx?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce19f7-be17-4d9e-c17d-08daac795c8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 17:44:07.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfWNatrptzBgFr5IIU08FlLvsOtEnif/VsQtOkpX5VLoUWbfqP++fsnxkR/kBqs/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB2162
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/12/2022 12:28 PM, Bob Pearson wrote:
> On 10/12/22 11:26, Haakon Bugge wrote:
>>
>>
>>> On 12 Oct 2022, at 18:17, Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> Currently the rxe driver flushes the send queue on a transition of the qp to the error state and completes these wqes with flush errors but does not do this for the receive queue. The IBA spec requires that this happens. Is there a reason why this wasn't done or does it just not come up in practice?
>>
>> It does of course happen in practise using HW HCAs. The ULP or user-space process need to free the resources used by the recv WRs. And it does so by receiving the work-completions (which in this case is FLUSHED_IN_ERROR).
>>
>>
>> Thxs, Håkon
>>
> 
> That is what I expected. I will try to fix this.

That's definitely a bug to not flush the RQ. I'm a bit surprised
the ULPs haven't been impacted by this.

Tom.

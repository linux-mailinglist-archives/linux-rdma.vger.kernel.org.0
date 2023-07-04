Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6D747408
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGDOYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDOYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 10:24:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB819E59
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 07:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBloLJb8ZCsGYZsq94K36PGEjLUIPpuA0zUEXhlfaqVHDX4O/llQiiCpiKBgUMBzYvBzFpqVU41BzL1eYdOQDjadbfnFPpXndNaSATcHOw8fOEXQFTbAbrqaywavLmjDB+cwqrdZey32xq1BdewaNkITiCFWP0jvblHLIWemV7/9jYkCDfh27TqGCpr0U7ja72SLdP6zYYuEKh+W0x/iTgyTBRD9onzT4xDzk1X9HwQ2v432pkVrMJQ1EcMax8F2LB0xa96b+VRJvE2sB/O/ssMyDQ1gBiLuj28/VMYXMhvE3lyzA9hM5r2DmwXO94uoxsD2KpUoOUQJjhnrN/u7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccq+q+mCa5bSv7LzrP7jwWQhD0TA16GIQ248zqn+qGk=;
 b=E5rOd7dQ88q/0KCdLDEFVmsTNaWXEXsUdFBen28DLpjtawP6NH4vZNsRNK3m43opRNLzCfcLByimFIzWg5zG73BSng8g7Gg+MNbtPwbwPJTN2p+mQOv7huAn0o/Y20zge1NxD0Tqylzg9SGYwPn+FY8i+RiHsobh5ubgeTpA4nZ0zAFApcZnnrJ9zSusQtpsaahIrugXQJiVd5jZVoWN6b45dL25XdMdi83D+MqP3w0gMweqsckbAGDc2ypbVd97G84h/aogJ27aXBj9EVPQkLK3DylUqqyyVoYJ83hTFbiC7yCnde+1qNdXyX9RWPIF/Uwt+vuWH+2SlmlFfHBPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 LV2PR01MB7815.prod.exchangelabs.com (2603:10b6:408:14f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 14:23:59 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:23:59 +0000
Message-ID: <a8f54410-f680-190a-5e00-3226f186b2d6@talpey.com>
Date:   Tue, 4 Jul 2023 10:23:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
 <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
 <7F4E0CAA-A06B-4F43-B019-4E471B10DDE7@oracle.com>
 <ZKM4jM6Ve5PUhHFk@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <ZKM4jM6Ve5PUhHFk@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:208:134::44) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|LV2PR01MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: a312a8ba-b7b0-400f-5734-08db7c9a4ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tKPlKqSw9uarMlz1Qe/lojWtIZ2xDLd9+7g6gWQCNTAH1S68ii9+W47dvekUs4Qay0FaSJEGZDFSJquArpXDS0187rAnCAAfSxJeQiN0PqUeH/50Zgg2uf2nlqZzA2Ui4EPRclfYHZuqP53OoH1Ue1yPqzYcSjEqgpjnMmDgvYT+EDAwDb4a/3UAcgoYyTkx4XmdPaM4hdwduw2cYEwTIZkYOL82lrtIc376S8RzqCPt8G8HB7RC9PLlj8RKybB71fjscopwWyFP50X6wYRoPQrTZDypTLCoP50tNKbUkKsD7XABlyogpwTpEmVJ3yvymInE7rX3Fr4W2cG6Jv1akxBf2ZXxQRscao5/0yi0zGsluLvKBlKpDpKmSg7V9Pljz5heiuZv+swm8iqnemfTcsBUgK5pZo6Plp02OdJoldWy0908iX6pqv3JDsVTIokGzY01k2uGDsueaJ+hEv5I4keFmLELVbxuRRux5fXTsPf83oXxrTO6urMXvAXSzGxl2A4OZOUmLqSt5aziQKiYcChPSnLn8R631sscUw/C0RhNXaSENJf29HPSEdu3YnvYF+C+wV85a2LPTK14qj+V7SZuOvIZuGu99ItvVpp9D20TI4Es1etULem4Q4e7BX5mH7mX0RwZT61Jgh8WhvGgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39830400003)(136003)(396003)(366004)(451199021)(26005)(31686004)(478600001)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(53546011)(38350700002)(38100700002)(54906003)(66476007)(66556008)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(41300700001)(2906002)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sndwb2VmM1lJeE9CTXZuYzVRNnhZMGFIVzZtcHF0aERibnVZajZ2cUdQOURD?=
 =?utf-8?B?NGpXUDk0Qm00QmFIa3E2d3VuREkzUWVmaXlwTlVaK0ZEcUVBNnBmMnpBYXBw?=
 =?utf-8?B?bDl0SFZQNE96ckZOUmJLS0dHYjRpb3ZtTThjc3lxMUN6K2NDK3ZHMEJ1T01n?=
 =?utf-8?B?aDZzeUxHQ2tYY1IvT1RJWnFnNzVFbVpaRlVLWWtIZjVOeG5kMnBvZTJCRVBB?=
 =?utf-8?B?M0J2RzJIODloUmZhWHZUdDFwV3RONmpiWW1Bb1RMUC9MOU55TUJsZ054b08w?=
 =?utf-8?B?N3pCMU9VTVZrRWhqUnF3VjcvMFMzNDMxN0QwWjczVGJpK2RlNzBWQ2xoTnRW?=
 =?utf-8?B?VkdOWFdNdkVlMy9GejFiYlhnL2FBSHdoWjVsUGtkcmkyNWhXelVpUzhwT2tz?=
 =?utf-8?B?ZjVZcHlCNDF5c2EwVWNVMk8xbmVXck1YMG9iSS9aTURoWjYya2txUTlDVjF1?=
 =?utf-8?B?RDhLTlNpQUJMVDVaWk51NXQvM0ozeEJJV0tkRG1PZXNhbWpVa2xaRGo1M2Nr?=
 =?utf-8?B?bkxad0lyeS9pR24xRlFqRmxYdXhIbUdXQ1lTQ1BwdmpmUWtxYlNWb1Qzc29Z?=
 =?utf-8?B?djYwZWhBU09KelB4N3pKSzE0NW5GdGNjZ090SzZ4NnBUcFRHS0tmUWM0SWlT?=
 =?utf-8?B?UDYxRnl0NmJkTTYycXFTZ0hVUTBWTUpuSDVDaGFzSW5ocXk3Qko0RGxzVXZS?=
 =?utf-8?B?MVNIaUdrS3F4bjZlQTBaSWNMLytkb216cDBDS05LSUJWenNFSHlTbUZYa25q?=
 =?utf-8?B?NzBQUm5DWWhGSmpQYm8vRVFjSkJHdTJnUVBEaUlFUGhLd09MOWgwb1F0L01Q?=
 =?utf-8?B?SGE1VFFGd3lmVm5wYThGK1NGNVA2OVZzR0hxcmFuakx4blVGN1F2ZSt0ajkw?=
 =?utf-8?B?ZmZSb2diS2RYUEt0U1grald4a2EvSUVGVmYycjR0eTA2SG9nNG9rZzJ3bzBu?=
 =?utf-8?B?Mm1MUDRET0FjSjY1djdoM0tyWmkrSUQ5Zjc0Z3BhSTF2c3QxbjYzeFcvT1Fs?=
 =?utf-8?B?bXVaeGN3dFVIeEdIZ1F1Tk9LRm9OVUNjR0RXUFdaWXpETCt5ZTJQd0hFU1lU?=
 =?utf-8?B?bUJOeFZ2dFR5cTJmNzU0aXhNWFlWSWY2a2VJRXk0VmpWNWhQZnBpOTZHYjQy?=
 =?utf-8?B?T21wSDV2YWptMnU0S3czZUNBdUVacnVCeWp5Z09lRThBZ0xXRHltQWFseFI0?=
 =?utf-8?B?Z1lHRVRTREsyWkRHWDkxaUNHbitVVU5OUE4zclhGY2lLRFozMFhudFpMVVV5?=
 =?utf-8?B?dkNnTVpZeTQrMmJtMU1KOFp3S2xDNUk2RDI3b1VVdTB2dnZDVi9QNEdCV0tH?=
 =?utf-8?B?TGM0RVZ2SzB3Q2FBWGFMOWhnUWJDaUJsOU8vVzJZVE5JZnlxUmszZ1NNY2JV?=
 =?utf-8?B?RG14TDVmdzFXOFNPQlV4VmdEK0c5K3NkeGZhUnQvaFZMMzY4ajVSczNCNnBn?=
 =?utf-8?B?VStjNVZkbFJ2a2I2cG05Um1Cd2pGeUxYTHM0eUpBYmhJckUwVVlXeW93Y2w1?=
 =?utf-8?B?T3pFSHhvblBTcmI3R2hybHRlNmVNTGlPZU1rK2o3bkdWWDJxV3Z6WEhpaVg3?=
 =?utf-8?B?amVrY1RSQm5Hc1NNL3ZrMUFPRUU3UHM2VVliU2RjK3pZRmhzdWJaWVRiUlBW?=
 =?utf-8?B?U3U1MjFlL2p5dVdHUlJ3Vkl4SDAya3hGRkMvWU9pVjRQSUFjTU1BaHpBN3Fm?=
 =?utf-8?B?dDEySVJpRy94R0xzc2RWN3N5K0pJLzVKdHFocEhqV1duOUxsT1N3WFlELzd3?=
 =?utf-8?B?WTlMNWdzS3ZYTVkrRGlwREpOdFd0U3FrV3luM1p5WkJtNmx6cUVFSXF1ZUh6?=
 =?utf-8?B?TEVXRjRTNUlid08xOXdlWnlvQk5jV1lzdVRPQWtQcFpoY1VaY0dkSHVLYmUy?=
 =?utf-8?B?WHdwaFZ4Mmc3QzhsTFdKWmUycDhFamhCY2hlZDU1dGMzK2VpY2k2cXlQRUNJ?=
 =?utf-8?B?TVMzZnhTZUEyZlRWVUdUSWVyczFRTUlDSGRaQ3JnMzRid0MxTjBwZi9qWHFE?=
 =?utf-8?B?RzZPMlE0RTY2QUZOU05IRWYwWS9sSDMzeTIzc2hraW5mam5wUW1uZmk3eXNG?=
 =?utf-8?B?SG12RDlkbDJzVHpSajZEWmF2SVdkaXZZR0pRdWdjTlJlOEZERURkUXJUUmho?=
 =?utf-8?Q?ktYN7c3f+MfOMw5lcfR2jTRpk?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a312a8ba-b7b0-400f-5734-08db7c9a4ebb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:23:59.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvb50qMO65NP95XKlt8XFdLCF79Cxs6kN+dw573+wbmTlkzRCZzNry5F/rp0c2gW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7815
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/3/2023 5:07 PM, Jason Gunthorpe wrote:
> On Sat, Jul 01, 2023 at 04:27:23PM +0000, Chuck Lever III wrote:
>>
>>
>>> On Jul 1, 2023, at 12:24 PM, Tom Talpey <tom@talpey.com> wrote:
>>>
>>> On 6/29/2023 11:16 AM, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>> We would like to enable the use of siw on top of a VPN that is
>>>> constructed and managed via a tun device. That hasn't worked up
>>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>>> no GID for the RDMA/core to look up.
>>>> But it turns out that the egress device has already been picked for
>>>> us -- no GID is necessary. addr_handler() just has to do the right
>>>> thing with it.
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>   drivers/infiniband/core/cma.c |   15 +++++++++++++++
>>>>   1 file changed, 15 insertions(+)
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>>> index 889b3e4ea980..07bb5ac4019d 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 port,
>>>>    if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
>>>>    goto out;
>>>>   + /* Linux iWARP devices have but one port */
>>>
>>> I don't believe this comment is correct, or necessary. In-tree drivers
>>> exist for several multi-port iWARP devices, and the port bnumber passed
>>> to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?
>>
>> Then I must have misunderstood what Jason said about the reason
>> for the rdma_protocol_iwarp() check. He said that we are able to
>> do this kind of GID lookup because iWARP devices have only a
>> single port.
>>
>> Jason?
> 
> I don't know alot about iwarp - tom does iwarp really have multiported
> *struct ib_device* models? This is different from multiport hw.

I don't see how the iWARP protocol impacts this, but I believe the
cxgb4 provider implements multiport. It sets the ibdev.phys_port_cnt
anyway. Perhaps this is incorrect.

> If it is multiport how do the gid tables work across the ports?

Again, not sure how to respond. iWARP doesn't express the gid as a
protocol element. And the iw_cm really doesn't either, although it
does implement a gid-type API I guess. That's local behavior though,
not something that goes on the wire directly.

Maybe I should ask... what does the "Linux iWARP devices have but one
port" actually mean in the comment? Would the code below it not work
if that were not the case? All I'm saying is that the comment seems
to be unnecessary, and confusing.

Tom.

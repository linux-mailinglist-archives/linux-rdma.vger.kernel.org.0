Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAAB5781C8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiGRMMI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiGRMMH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 08:12:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2114.outbound.protection.outlook.com [40.107.220.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0D248CC;
        Mon, 18 Jul 2022 05:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1a7YeWZ1l/7XdZNq58zuWi9bC65+u1+n/kIkdfgo3F3M2P9cT//+LhyCOMAyIEqOFwjGlEXUdYh1DkK45v0Fx7Y9nkCYvsEAUUwTCWYpEZeE3iohAJS6QtU7vJIg+gvVenV4UUqNY6HK2dLa6m7KZ4lzy6I5sP8jUoqE7BOtns2a/EeT/0Htz7Nnr6Am+NvK+1aTxgd0fGvGlHiIxoPc1hjqvC0pxXTd+rDSjSunIymrlFgcGe7JamznYE6DGTt/U2M4PNTGtjJK0x3iqDcyqy0sqMXlFKXTPFE/zwzsLKxzBlFRHs+mNQ+77zIA/plkbAx2c0nQPR9dO0wzKGAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WnRURhbprDrqCtwUwuN9nOOaYwwaCE8PIzYskBdYv4=;
 b=dLLYRD6B/mnuE2funG7xwF+QjqGqbqat66T2hJbfZwW7surlhwhV9TmrJIAWrssf4EWX9MpgYDhDqefKnKgzdtBuboZXzjlWEIRPxDospZ3RoA1R9J97cnwk0he3aoFgn3LpPJzi2eWxefsQv56ivAafSTLhaS1Au0Z7R6ZK1zSOnOop41ivmvJFrlSe/0gSITImMjuuebxl2DlxncsRFMzKPD5HoaF0bVUnNgEc3EjDrACaaI7dMZOvRWjCFWZ5tFy4Uiwgv3a0BL6dgAfjKpQ96RKrDGgOdjLjJyTJzEESd5qA2MqHgBlEcX37jK0VNoW+JNc1ichJ9Kl/0S/xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WnRURhbprDrqCtwUwuN9nOOaYwwaCE8PIzYskBdYv4=;
 b=VuSiOJ/Ap7hgmfXR+bDZ42iQspb5pUx+zMy+snPS8O0WIad8GeupBpP6ar4EV28kk3E4fMa+Er9nR3/7KZdFedORK+1Rbu1OMn3sirIUKCixIErKLKWfzyV9aMKXOMhUBWuWt3MsFEn5VYBiyZ5lvSa3gQZkazv04EfA+nMRtKLL4on4EOV5ieIHLjqVjZKNEm/E7iPttmezgyxqLrRKI8YaQSlnUtg1aZ2ap9oiML51h0qSDsalB2KX8s/+W1RfyqMxnElPHEgcVLac2wZGtwW3i4snsR5dQKsaiB6NoMndUHO9sSVKM76fDTN4wbabMub58A7YeX7LqLcNEh/1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 DM6PR01MB4361.prod.exchangelabs.com (2603:10b6:5:7a::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Mon, 18 Jul 2022 12:12:04 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 12:12:03 +0000
Message-ID: <be437471-0080-8e9c-978a-6029c7826335@cornelisnetworks.com>
Date:   Mon, 18 Jul 2022 08:11:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711070718.2318320-1-niejianglei2021@163.com>
 <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
 <YtU4eXQCVEPGnh9b@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <YtU4eXQCVEPGnh9b@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f2ee37-f93a-4a06-1a6c-08da68b6b9af
X-MS-TrafficTypeDiagnostic: DM6PR01MB4361:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4BHqQ//vYreHj4l2KaxOcDy8TD/Z4nMbJASDnIG+hGWA2pD/M+Vd01SfnTwTT/yPRDbi9nGgjfoRZEcj8AIs2f9C1voSK26RczoAtZdPyeUpN/Hjkg4oHuG+So0sfwulgu7Ix8hsAlDJ3S9DeXxPcNVULJsXOwiKTx9SyrwmmmuZ4tIyPZAjj0nUWrCyPhP2Hn0QhJjvwpBI8UckSPtnsczWOXd+aTVU8JGYhka1Y+BtMrytFSh6OCIeIHV2xla8EwtOCMD/J2AiufvfinJjtO3X79Zi3bFCILeTdUMHoDbmN9woenHeXFaTSR2bXZa4sN65TBFGLfkXbxewkwloII38QicXvZfrfEVOEUmXG8T40L0HRLo1S2+iGicCbiNeRzytf5pikHseINeCohudLwrIRS+ja++2x+ZE/Ovhq+uP7SsNmBTP8ZoYfGFFYYgs6Wl9GIGt6IN1NeZl1VIOKKcccSioALzZIc+yHTLwhzFlYwix0nPnQWpKYKKWeWuREvKVR8LKIwGuD6K0zZwYSC3PjU24Dk2cnlpFcLEhKj70VwClPi8W5aSB0yGFBF69+sX2QTDZgs2InWPtRH0bISOg+zgOVSG9SCJ0IwNohHYTAx4WxkRW9hAkaYYKG4Rbr5ReILlimv4SmVixys/RWUOkigf5XxBxC1qOiGGbTq60oVwL79s07b9WKhWDBfKxMo5XcrS5nxfIIXdRPW6X/+kScMtbFLEAAqllVILBeMOD2PwK4br0qfRw1Mdahw0QTm1HaRtnFa7bavePFyS3BLSC++PhJYSgGj2N2n/eBH8Y/AWdPNvhtX46eYGjy5zERoBLRwf7NHvfPygvP3zdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(39830400003)(396003)(83380400001)(6512007)(186003)(44832011)(26005)(2906002)(41300700001)(6666004)(86362001)(6506007)(52116002)(53546011)(478600001)(6486002)(5660300002)(2616005)(8936002)(31696002)(38100700002)(6916009)(316002)(31686004)(36756003)(8676002)(66556008)(38350700002)(66946007)(4326008)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFN4YnFsYVlGeGFsZURPOWtHK0VGRHZ0ZFdEeVhXMkdHL2pvQTdsK0dnb0hN?=
 =?utf-8?B?T3VQbUhScWRKUHZSYVRvUEJmazJVQ2xLdU5LQUgzY2ErSm1YTWM5N3RWUHVH?=
 =?utf-8?B?S25lYnEvU1k2dlRueUJpZkdqZjdlWXpHZU1WZTJnR0hJc2pZZWFMajkzUi8v?=
 =?utf-8?B?Vzloc2JoNm1nVDlBaXB0K3lsU0s5SWlHMit4U3pCZkRTZFNoczhvbWZkajRM?=
 =?utf-8?B?eFVHNGkzTjltZ0FSU2tXZTBaWG41WVA0L1dOMm1rL3NuYVYyeFlDTzliaUYr?=
 =?utf-8?B?QmxMZmQ0TkY3VEx2M3g1TkJKc2hFVDJrbjM2MVo2UVBZV1RibW9nR0NGSFdK?=
 =?utf-8?B?cThnMDU1VGdPUHYzYi85bWs1R1YycGJhUjdPcUJ1aWhXVzdzaWVGdmZ0ODBR?=
 =?utf-8?B?dFpLazNOazZBMVJTQ25vd0hwU29mb3diOG5vQXpGMlBadTRlUUt4YThienhs?=
 =?utf-8?B?L1poOEtTSkNxajlMa1d5V01lREpldnNOdENrR0Rqb01Kemt6Wjg5UWlNaWpv?=
 =?utf-8?B?Rk5oZ0MybjZMWTZWZnlIUVNaUm5BUGtzdXBQSHh2NkpqYmVwU2hSU1lwUjE5?=
 =?utf-8?B?OE5HVVlDWHZZSXJ2VVp6aTZaZ01Scy9OMmVZb3l0eWxLTjh3Z1ZDUFdINkF6?=
 =?utf-8?B?ekU2VTQ4UjV5a29RQXlEelFyTzV4SGJLazk5YzlwVHdteWVzUnFkWmJDSFA5?=
 =?utf-8?B?d1dqMzlKbmtySlRPTzVGR3hRZ2V0K29CZDRXOWhvZzZna0p1dWlIUnY1SEJ6?=
 =?utf-8?B?RmlBRVJFUHdEZFlhc2Z2bnlOZWloNFlwZ2FoWDRjd3pHUGJoREVpSUdMQjB2?=
 =?utf-8?B?SkQzYlhySWhzWmhYeTc2NkFmWUYwMTBGNUl0eXZCM2RHallwWlcvZWxmdFJa?=
 =?utf-8?B?T3gwY1Y3UG9tS0toL1FESnEwdDI3MS83WEtrOGtKMUI0Z3lSL2hoTXNRbnl1?=
 =?utf-8?B?bG1CbzVaWDBTczV6YW1UWXZzOW9DR0VmNDBqWmRZYWJiRGgrLzNCNkUzNDdI?=
 =?utf-8?B?MlBsRUxqZ1lFb2haWlE4RjFPbXlOWHJFSU0yMFh3c1VWb1RZV2FESTY1bUwz?=
 =?utf-8?B?UmVONHlROVhsalRXWkNjYnpzbytlUUVhUFU5bjY0NjZlZjJ0b1lNNmVyTjdp?=
 =?utf-8?B?YWFXbHF0NlBHNkxhOW01TjRNMU9CY3QrK0RubGl6UWJZQ2tWeGJyYXBzbDJN?=
 =?utf-8?B?RGs2dE5SeDNoRE00cUNYODJxei9MVk5LcjlWQjJDT3RMbktzc1d2ZVlmK3JH?=
 =?utf-8?B?V0RDR2tWTHZ6aTBWempVVUpoN3JFVldVQVRNNmt0cWJXc3ZEbEJuQnl0eWpm?=
 =?utf-8?B?aWdTWHRldUVKYUdqVzFrcmM0TjJySHRLYjlBWW5kNm8yQXRUanEwb3AwL2dq?=
 =?utf-8?B?SVJ3NnRiTEN2ZG8rU1RZNFNTMUc5bUJ4blF4MFh6akZkcm1VL1BnbG4rM3Fw?=
 =?utf-8?B?akZDZWc1VG1WdEkzZXRqL0ZsN09PcXhlSWVWTmcyTklHaEhzOUIwTDY1d3l2?=
 =?utf-8?B?bStVU3NaSzVaMTVCVmVaalhCOEJhdjJrS0g3bDd2a2dPN1pvZnVVSERkVzlt?=
 =?utf-8?B?MEJ0ZEtLVko0V2JoRzVHVGNVakJxUW5TTlRBYXVhOUI4QWtOQm5rdHVybDlT?=
 =?utf-8?B?WXEyU2xnTjcxcTFTZkZya1JzcCtBb0N0dTU2UnJzYlBRQjV1VnFmVnBnQVFJ?=
 =?utf-8?B?V2drblREODMzenNRVXRpTUppSFRTQUxtU2V0a3dyUnd1YzlDZjVPNHozM25H?=
 =?utf-8?B?SGxiWCs0RXY5dERHbDlTK0wxZ05DV3VrblBlRGxhSG50eVo0S3JuM1oxTmR2?=
 =?utf-8?B?aUZlTjh5aTNta29hMlZySlVoVFMrWGhHMitPSk4zTXJWVWtvS3JGaGpNNnY5?=
 =?utf-8?B?Uy96ZDZmcG0zeXZQL0VYNG1vSXZXMisxQWxFanhxdEdLU1dyY0kySlVpOWtl?=
 =?utf-8?B?T1RxZS91QjZTY0J1U3ppOXBHYmgzeFhOUFdjZFYvSDJKT1kxbmNEejJtRDI2?=
 =?utf-8?B?d0VMc1VCSEhvS2Y0V0Jab1Ywa0VjQWFMRWxCSjdhS3QyYTlxU3dLYkxEVWZR?=
 =?utf-8?B?TXhpS1JLZ0IxekJZdmxuQTROSVZiZ1g3cWlROWJMNlp4cFh2QnUrWVdHcVV3?=
 =?utf-8?B?c0tzeEhKR090K2JkcjZYbkVkN29uVWZaTGFMMVFTOHRKQ1RDQkgxUkxiYVNm?=
 =?utf-8?Q?cmmPHQqezh3OP8Xb12jTQgA=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f2ee37-f93a-4a06-1a6c-08da68b6b9af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 12:12:03.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyjUQx0/zEOF1nnxF8n+8sTF/dfywqohRGmryuQMA9Ha1iZXT2qNpLv+ZKkwVMS31qLAz4KPdjd+yCihDMK2FbD4xU1g44B/+0DPiA1QgMFMdgOWfUo1VCYk5K/bwfhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/18/22 6:39 AM, Leon Romanovsky wrote:
> On Mon, Jul 11, 2022 at 07:52:25AM -0400, Dennis Dalessandro wrote:
>> On 7/11/22 3:07 AM, Jianglei Nie wrote:
>>> setup_base_ctxt() allocates a memory chunk for uctxt->groups with
>>> hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
>>> is not released, which will lead to a memory leak.
>>>
>>> We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
>>> when init_user_ctxt() fails.
>>>
>>> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
>>> ---
>>>  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
>>> index 2e4cf2b11653..629beff053ad 100644
>>> --- a/drivers/infiniband/hw/hfi1/file_ops.c
>>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
>>> @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
>>>  		goto done;
>>>  
>>>  	ret = init_user_ctxt(fd, uctxt);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		hfi1_free_ctxt_rcv_groups(uctxt);
>>>  		goto done;
>>> +	}
>>>  
>>>  	user_init(uctxt);
>>>  
>>
>> Doesn't seem like this patch is correct. The free is done when the file is
>> closed, along with other clean up stuff. See hfi1_file_close().
> 
> Can setup_base_ctxt() be called twice for same uctxt?
> You are allocating rcd->groups and not releasing.

The first thing assign_ctxt() does is a check of the fd->uctxt and it bails with
-EINVAL. So effectively only once.

-Denny



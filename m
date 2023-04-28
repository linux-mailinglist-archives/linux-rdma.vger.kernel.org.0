Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B56F1955
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbjD1NYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbjD1NYe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 09:24:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D35BB7
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 06:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCq4kV5WaQh6kloPigupDEd6dfr2FgT0fskCdUFHl3TKTd8UgNukViPZV2q0/Rw7p7iGEoFgyh/7cGsDcO4OV4IDB2Bgh+XY6Wq6h55NnxxBXeZXIMYKYDe/sgZGzlqTAy5PB+geP53MmaoWpU/m3DDwY8PfE7BprlUM8Xi+DcRq2kwX3WVrjxNCkLRP9GeNYaOt9jDHy/y7LDajzn/OzCqCDO5M+mvQJ83YcBgUYFgXd/nGx+F0WrKLCO505XvINiPV7ChGfQhLjGq/qOG0xPTcPgfaleLCwu8b69ychjDUS5Kq9k+SJQsXLfEMMwOCDRHkyaAQPHD1p+o4bpJPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUSODO6e2DIOT3SCElNqGylDGASiNbupCLMJVFWKkxc=;
 b=MILOtA0HErnrAedBxJKHfIvwQapP/9Ut1179v7aHEl+0e3AJjS9mMvQ3X4jZTg1Rf52lx2vcA1PoswNG7UdEc4JMt1dW16wJuLBBJxdWl7GlijlaJCE0dSsCewpqLYA2y9xJbXo4UvHNScxnYpzkbs6NdRu/ow+2S4QGPhJj6WoG6VhnK7kZAUSnOWrRnmOnie2es+uUVqpbJdwMZAw1Bm2N2PdBXf00/ZANw4UwQ13gAI64KtJ0DopWfrBR0ikbxDjxoJBzOwBPpOSikY0JXKcy8Ko+REDpzgKRUXjxkAAJ+zYb+XC89+d1R9pnvyKdE4KeItKA2ZE7VrEAiJSMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUSODO6e2DIOT3SCElNqGylDGASiNbupCLMJVFWKkxc=;
 b=q76Mc6V96fmrPOiG2/AKU6g2+oMpHFc45pP1TAlrx+jx1oA8brqOPx4QYNso6rRwLHgP8K+edTqNQKVVPbyf8cI5zwYzcEB3Nw4y12ZIsZofCkdLLuwco9gK6Dov6do4hadH655SI4oMSbzoURi/bWqcQEoawd70hl3+T31YDczHiire316YFyZ/G6/1pxPo67XaevjYI1qibxyjJoKCUcu/xffk7sPgFiWQ67fc88NoRCpCSxQbPWIFvJv3p4RlDK90M7nqOWuAeu+Ci04TLgJc/Cbzfpgbz0Tzcwmqh8RZB53oLztPZ3GUqPdyTqTY1Fe/L4I78nzdTNkHSbD9vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 13:24:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 13:24:23 +0000
Date:   Fri, 28 Apr 2023 10:24:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
Message-ID: <ZEvJBk70YPvO1QDI@nvidia.com>
References: <20230418122611.1436836-1-yanjun.zhu@intel.com>
 <ZEKraDHuNAltduzU@nvidia.com>
 <1fbd5b6f-ba04-95b3-d37c-35fc12e81303@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fbd5b6f-ba04-95b3-d37c-35fc12e81303@linux.dev>
X-ClientProxiedBy: BL6PEPF00013DF8.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:b) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c6f0c7-e48c-4559-85b7-08db47ebe1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx9v1eH/B5o5dpcNnIhYYsdB8LAhv7WvX8whEs/qoAjVFowdfK3EJK8RLdo/hdBsZgyznObjUX5AqEtanDaNCyqwvm0QnQZLOLTEVcSrlNq5+bvn57cHPSeR0ETIEFzC1KgXCMyR4SwPjR4mNFjo23fvZOnf4bmUW9JCo6OShRGW6P7LnTeAVmdEQGU4OMIeWfEdCg9zFw2eZTiSjYs0Ac5qrLIxraAbJQ60hQum9TTcp+YMl9XRGCUPMP1x3/griNZbYhrxYnNkdRLZoBQOMCVLs1RX59FawPoRhIU/CJL93NP6Q3IsaAtyO8SBFl6MCnGTqKzbtHITniSK/0/ZPObBY6VSrxB6rGRmw5hthBlIYvvvxKKCtxHMmBCtNocYumviEvfp0Kvt9VYnA3bEuVargUXKzQmH0eejUqLg+0mBeFB2HFOf0CnlvPkdm8pyVmxziMkgtuVs/U70iZCACYH3vA2wTRAhXGVg8ZDKTk01cclS/4TxJYcE7Siq8bJ6PWQWuJT1Gb74MYbuOtifd/jXauV1ZrTVZPq7n9UtLqrIOpEOqGCoe/W3P+6xYi75s03sigyqac45w5aano3Nf2EcdcT4zfA8pG9JU0HTbsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(478600001)(83380400001)(6486002)(186003)(38100700002)(316002)(2616005)(66946007)(66556008)(66476007)(6916009)(4326008)(41300700001)(6512007)(26005)(6506007)(86362001)(8676002)(36756003)(8936002)(2906002)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlZZmI4eW54WjRhbDRtbUFFVVlrd2JFZmlodU9NOGg4S0tBNEx3R3dHVWZm?=
 =?utf-8?B?ZFBvR1BDSUhCZFJzcnJiRlBrN0tscEhmLzJpbHg0MUhZRklYcTVIN3I0Tm5N?=
 =?utf-8?B?ckJaWVNWQWR4MEJkdkNiV3hJQm5qTFg2SVhtSW53TC9OazJuTlEyS3V6NEpT?=
 =?utf-8?B?MXdDMitMN2VrUWJFbmF4NDl5SHdRZWVyU2V1VkpSTktmZDZ3N3lteFAyeTc2?=
 =?utf-8?B?THRoSVYvRHN3YXhFVE0yUGs5ZER0NVFyZWpQeXpyUUlBblN1azdQeFZ1K1dX?=
 =?utf-8?B?QVgvRytuMXlwU0cvdklpMnUzMndPaTVXYU9kVG5RWHV1VHN6RU9FTmF5WHlX?=
 =?utf-8?B?Y1U5SE5UZVEvcmY2RVBGRE1kWW5aR2k0ZWlvckFHNDhnRGxFOXU2UzlrT0h4?=
 =?utf-8?B?cXN3Y3FtTmgrY0lFYkFhT3YwcXhhZ3pYQmxReThtVTBqSi82SGRCZ01Cc3M5?=
 =?utf-8?B?RlNiWnV2bDlJZG56aC9UU2pvU0t5SEVYNnRFZjMycFUxc2dxZU5GUkw0K2J2?=
 =?utf-8?B?SVpyVWdxOVpGZk1XMVJQbVh5N2xWQXpXbUZDamdPakg4NHk1cmpnWnplV05E?=
 =?utf-8?B?MHl3dmY4NWVKVGtETlhEU2xwK2ZLQ1draHM2Zm5VMExHcjRkVlEwdjYrUVQ2?=
 =?utf-8?B?RzJnQVZkSGlEUVZaYjhVVFViVElQVFNXc3cwWW1CazVZcEdTTTJ0OEpESEdJ?=
 =?utf-8?B?OGdOQ3lkNEtIR0R5SG0yWnkxYnZFS3JCZGFzb2d2QmRBVWlRMCs5RzF0WEhI?=
 =?utf-8?B?ZUd2aXNSUUVsVmNnbHA0SGZncFJ0enp0SFg5VktxeDdFYzlZY21sMVpGTjU0?=
 =?utf-8?B?djluZS9VTlhmV3R4QW9hcm1SRzduaUhkSXk0TW1NakcrazhrWWh1T0lrbENk?=
 =?utf-8?B?NlF5a1crTGNvV0RZYXgzRW5FM3FDSGpTczFrNThhMWRBeU5CSERTa2thelJW?=
 =?utf-8?B?WHNnVEFtU2ZlMTc4MFNUMUJyWXJCM3h1cFovOEEybyswdjhhMzNkNFhYMVYy?=
 =?utf-8?B?SUl3WmxmcDVTVDdzWG1hVzdGUDdyUXZjdE01bzFCSlloR1FYTU5LSmpjUUVh?=
 =?utf-8?B?eUdpdldybFNnSnZIa3d3SThZdy9rOXR1MnpPLzFmVnpHekVZanN0clJmbTVN?=
 =?utf-8?B?d3ViY3JoVDFqVkFXZWoveDMyRzA2MEwxblZkQi82a0lYMnp3cktEdkFJU1BJ?=
 =?utf-8?B?dmpQOHVqR0NXVzhBMzhjV3dkdUN1VCs1YXpRQ0hHSnhTam5wR2ZCMHRRMlR0?=
 =?utf-8?B?QmJKcTJaZzQyaW15WkpuMlg1aEdEWkU4dk12bWQzNWplZzBXTVRucTVubkNa?=
 =?utf-8?B?a3V2cFhxa1JXZUFlanRzT2xFSnA1Mm9JNW53WnVXc3F1RG9yREJzTGxkTXZi?=
 =?utf-8?B?enZPOGVyTVFSdGRpdWpTU3FPdi9wdVRQQytjTk5aZWZIMXhTMFZQTy9iOFJ4?=
 =?utf-8?B?VkRpSEpJRWc3bU9Ic3V1Qy9yV2xFdFpIREN4Y3FNc29pbC96TG1ybTBsMEd4?=
 =?utf-8?B?UFg1VWF6TS9zNTFEQ2s4TWxDZm00Z0VJZ0xsWkhHVGNPSWFIUVBVMzIydlFY?=
 =?utf-8?B?VjBCSG1vUHdHeGMwM1BDbzJoU3YyeDF6VTRIOCtiY1FndFY3cEo4QjE0cE1W?=
 =?utf-8?B?NEh6dGt1ME5veW5vWXcwN09rdWh2VUVJbXNOQmFHMm5Ybm43bkl5Mmp6dDV6?=
 =?utf-8?B?ekJHWkpNTGY0dXZFdUhrVFdGSEVLczFXTFJMMWZmb2tOcTNnd0JRR3k0OFN0?=
 =?utf-8?B?Y2JoUVg5UW9Ub0pQc0s1d1RqUGtWMURjVU1uajIzYkpvL20rbE1BR2gxZHpn?=
 =?utf-8?B?RldWQnVKZXBwUnpTYWt5UDlOOUFIVWZCRTE3UHdpRU5Tcy9VYWRULzNsNWVI?=
 =?utf-8?B?ZzNwYnJiYXZxYWZESUthSmwyblRZZEMxMzR6SHArbVMxb1FzUThwQkIxekJr?=
 =?utf-8?B?alVVL1NNTHhlU3pUT3BtcTR3eTU4d0xWOEdqbDk3WDEyTnFsRHU3T1pTYy90?=
 =?utf-8?B?WGtzRlJvQ244dGdhcWtpZVVQZWg1M01ZSXlBSnBWL1F3U1VmTEtEeGswbHhr?=
 =?utf-8?B?SHJaaHp2bkRvNXA4enFURWRwU21NM2c2TjdtV1B6Q2g3Rm44Ni9BZjc4dmd5?=
 =?utf-8?Q?xffzXQa/RHYrK8lP+rLbOvxmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c6f0c7-e48c-4559-85b7-08db47ebe1a9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 13:24:23.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xV9GwBsRHsFrwUqqWhCDmqNvWCp9eMK9PqMV7y7p1CWMhxaP1+xrfd7I9tkq3km
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 21, 2023 at 11:51:34PM +0800, Zhu Yanjun wrote:
> 
> 在 2023/4/21 23:27, Jason Gunthorpe 写道:
> > On Tue, Apr 18, 2023 at 08:26:11PM +0800, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > Add the function names to the pr_ logs. As such, if some bugs occur,
> > > with function names, it is easy to locate the bugs.
> > > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe.h       |  2 +-
> > >   drivers/infiniband/sw/rxe/rxe_queue.h | 16 ++++------------
> > >   2 files changed, 5 insertions(+), 13 deletions(-)
> > After you delete the warn_on's there is very little left:
> > 
> > rivers/infiniband/sw/rxe/rxe.c:                pr_err("rxe creation allowed on top of a real device only\n");
> > drivers/infiniband/sw/rxe/rxe.c:        pr_info("loaded\n");
> > drivers/infiniband/sw/rxe/rxe.c:        pr_info("unloaded\n");
> > drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv4 UDP tunnel\n");
> > drivers/infiniband/sw/rxe/rxe_net.c:            pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> > drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv6 UDP tunnel\n");
> > drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to register netdev notifier\n");
> > 
> > It is not exactly mysterious where these come from?
> 
> If I got you correctly, you mean that we can easily locate the above pr_xxx
> logs. As such, it is not necessary to add function names.
> 
> From this perspective, I agree with you.
> 
> Why I make this commit is that we can directly use this pr_info("xxxxx")
> when some bug occurs. But in the logs, the function names appear.
> 
> With this commit, we can decrease some work loads with some bug occurs.

That doesn't seem like a good reason to merge something so abnormal
for pr_* functions

Jason

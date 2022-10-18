Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC9602E61
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiJROYb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJROY3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 10:24:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E792710F;
        Tue, 18 Oct 2022 07:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWcCDGnvIDw1xBoJ3JJE+mC0rJMXTTjaT9T1R2mqv6wmjaSaEIeZX7TJKBmjrYSNBSHo5xhSjkHWEGDiqAwfCZLe/flsUzwGx/8IIrAl1RgQ2KROTxdA5G/CaYuK0phsqa6b1U46Uvk84+tIX+x0SrRbmmoTOXeYcnOD8Dn2cegLlZr3IoZ/AH3GJ968f4QHv5wAouu/xC9AtYmw19coCmnKzXNWF0lVCsy+SZyqBzYA7GI49au2THQX/g/ptQuO3fjiVEWVmhxmzQz6DWp8CwG6AmSLyVdk/6YS1Ckyx4uSOI8A+GF+qFFtA5qC8Yn4jG5d0w9JjHFhpkUEqlqpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3J+a+ZexnN9T7s5ef//gTkeJhrZOLMV0mlh18VTeqY=;
 b=QFvRX0IcKgzvrnSoYO8JNkbacqi/QM6go9GT6j66iPwPYYY30aJ6dwjVxw4Zpl/KPrnbZob0yqddG6A5v+bGcBEa7BHFaRPlgxRqntOtL2z9RUFHGwXb5noRgrSG7gIQ8owQmQM/4N6WYDTJbQYTIucoreyT4Eo6+rz+3YRspzfT92/t60CscUtG/nIu4H/0Z3+uOfEbQ8oAM+G0DGnAAcMHOTmNrVgJzzgrKd+wiUn2/3/16AGf457JJjxewr4C205p1x3IaSwD0D9OhTsY4YJ11Mh01EWBCeLS3Dtrg9uTQOpTirNXZ5rskieFHJ17XNPGV5z+WNS+2bHtGM/n8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3J+a+ZexnN9T7s5ef//gTkeJhrZOLMV0mlh18VTeqY=;
 b=iNJqQLgAA9PFoQj20dBP8SUFt/YngfaaTzbrDcojbSskri+Sos3gFWT7mQUkcF31XG94xVssHxz4OzCLmpvMx+tbK0WGGBUiE12dvLdi7fWNp8uPlPbwRJFKKf1eMYOdC8+V+5u/1T5X9nqv/cjYLouKnIGsFfHm8T0k7sPMrKC5U021JPzEZo/KxG56MEZj+OEhqapXJ2GSvKtEt5P2X3Y2EfNgaQ8Xk9uS3+BpayCV9f5XoyY1I9chz8FqY3E5z0fiV5GyWX3bbeMhV3x9L7V69F0Us3NH8McwbKfBTkapSs9hkZQm/CsVgHLxX7Mpqof16dgkILKQ4qbVLiZByw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 CY1PR01MB2154.prod.exchangelabs.com (2a01:111:e400:c615::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Tue, 18 Oct 2022 14:24:21 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::6c3a:f804:5889:b2ad]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::6c3a:f804:5889:b2ad%10]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 14:24:21 +0000
Message-ID: <4c6939b5-05b9-1346-5376-82011b4cc093@cornelisnetworks.com>
Date:   Tue, 18 Oct 2022 10:24:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] rdmavt: avoid NULL pointer dereference in rvt_qp_exit()
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Natalia Petrova <n.petrova@fintech.ru>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20221017142652.13906-1-n.petrova@fintech.ru>
 <Y05msUNgnQTWmXyh@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y05msUNgnQTWmXyh@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|CY1PR01MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e14b6d4-af0d-41de-9d7e-08dab11472b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QY8GaSoarCjsY+mDt8XBcoq70HJZOzQfakKffDBj1qCOEuGHcflCJ4mzplQlTUOlZoLgCYaKnHmR/Qye7sCnVoTuRJsMCcyQOMG32hw4V5c6ib4aVwpM7ivffDXU7xglIt3w4OHte5p5Tf+UlpCrcZXBdYTBEPKWeHpi6qtfk5siZRUXqnkFp1s8NIzSph3AJyYCcderZHAzJjCnv2DS8lmpCdvPiKTDYeI6v2T2sAAG3AhNbLdKnWrRQNYso5HTPagMrUck7aZ5/ki3JJJqvG7PiaPy5YiPXy2IrrhwkH/WZjt/tu1SCkZiANNHY/jdtmmxWCl58Th2SYEntvabNTE/Cga4RI3WZlDRf2TkASQWtY0nw6jRXrXlV3N7uV3JKrZ9tY5pcbWYfFuAUPlLjIkOpSy3Wy497pJfrrvCR72piVnO5M5VPFyhY+vjhEIYlyvOzrSnwJvISD53K35lj3LNnWqYI8bDrndqMLr1AXhNZ0cJbt8f+E65x6VNWimt/tCdfgLizDWa0L2gg4RrovZzwFTJMgweL7q1/ht41jqPK8Ij8zmIUIXxgQ/VZg7icBGaTi+YfNAxBXWLy0EQtPNtJWaGrUih2t04AxG70t7oz3tTE9zYBJt30bHtePpToE9y0v+ktE3zJaQI4CFvjMCp/ZYL81tEj9p6CGGrfDpbcD9+w86FMnbrOI50j/LZAnroa0/RddeCCZ7OEm9JCOjK9Y6rO1Q3sPs9vQZY8wvaZ9lDGBAwl8asYFC5vFzZfiYSz2KF2ScHM6NezKdNROsE5LC1ymJ0kqAhyYokbgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39840400004)(376002)(136003)(366004)(396003)(451199015)(31686004)(38350700002)(6486002)(478600001)(38100700002)(54906003)(8936002)(6512007)(110136005)(83380400001)(316002)(31696002)(41300700001)(53546011)(52116002)(186003)(36756003)(6506007)(26005)(4326008)(6666004)(2616005)(2906002)(5660300002)(66476007)(66556008)(66946007)(8676002)(86362001)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkV5ZDRQKzg5Y24rd3NKNDRhN1p3dHhnRVh1TGxJbFZwT0xoQ0lldHpQWEVm?=
 =?utf-8?B?RVh4TlUvWFhDRXdEUGVPMUJoVXN5ajkxTDAvS3VDMk8zWUdlYy9Dblk0Smd5?=
 =?utf-8?B?TGFNYUx2b0R1bFVlNmNOdGtYcmVBeHZLTFFxUG1KY3lnWDZoSWdYUmJlZUxM?=
 =?utf-8?B?eTc5VUNwYXFaRktKWW9LZjBJcHRHRDVLYUN1Z1gva2l3TVZoSFpoTmhLdUxj?=
 =?utf-8?B?WDByZlBDb3k5Wkw1bXg3NDlmL1ZMdXM0cmhXQjBFMUVsOFRlRHRINE9FZngr?=
 =?utf-8?B?WUtkTFhTNHpZajJTMmRXanlyOGp1R2QzMitxS3dhbEVuUzM4VDh4RVo1ZFl2?=
 =?utf-8?B?Mng0QWxwWEgyTGpFSTVpWjVyUXBrWXFjWDNPTGQvUUFmYi95dDVHYy9vb0Nm?=
 =?utf-8?B?Nm5hemlmc0Y1ZEZTWGpwTXB0aDYvQXBXZGk1TmMxaXEvK2JSQkdqOEFRTjNI?=
 =?utf-8?B?VFg4c093dm01cFpXQ241WXZwNEVPKzZrOFpPdmExMGUwdzh3TkMraExEcjEr?=
 =?utf-8?B?RGNhZ1dtZEtpQlNSOHZiMnhYTVhXSXdKeHBkN0dYRGxoSDFMMHlVU1c3ay90?=
 =?utf-8?B?R0VpOFR6QnkwbHIxYmhGaVNENUMwZFpHNW02U25WQUx3cGpCdkdaV1lDMUox?=
 =?utf-8?B?WGZ6bEYzcmRFRkgxK2xGd2NiQXgxRnBTSDJkdkNzTmNsajB1MGZPTEJqUlV2?=
 =?utf-8?B?bHdLeURqV2tZTStpREtKUk5MWVNJSW9KdDVsL3V4bktYVmxJU0lkeU5TNEc5?=
 =?utf-8?B?WXdJYThMNloxZ3ZvSUV6a3BPZ1FPWjVtTzQwOTg0STlwMnpFZXVFTTh3SjI0?=
 =?utf-8?B?K0M0M1N2SEF0SGt4Qk5aU1F3Sy9sQU9yTEhpOGthZlpYMmw2OFh6SThHeHZU?=
 =?utf-8?B?VlhWU3pFc3hyWGMyd3BsUUtzUFVIeEVaQzVTNGpnYUxPMC9VMHJZQ3dFU2Qv?=
 =?utf-8?B?MExRc0lCMnNvNWZYa1I1MTNzdktEamY3WVBxTk9WQytjWlVDeXkwaVdkUFQ0?=
 =?utf-8?B?OVArZHRVOEQrVkYzTmZ2NENzRHQyNWpLTElRNnp6TkZ0RWl2M2FwamR1N2xF?=
 =?utf-8?B?bFJrRTJZcGVBRGZ0Ykdpd2tNK0FwZHIzSHBJbWd3ZnBZMW1IeVUweGtmZjBn?=
 =?utf-8?B?MFJ0Qk5QcEo2cG1GSU9YemVpVHBLWVJaaDROUGdjZys4Mkl4MjRVNkNKc1RP?=
 =?utf-8?B?d0xlWGU4MDJDVytYN0Y4dUZHZTFBSHVuNHpjRTV1OXliOHFhNFZyMndvRjZq?=
 =?utf-8?B?dUlTN1FhSzZBVFQwd09HZHcwNEpiRmUzeDVUK05CblpDdUlIWWhGbnVHNm81?=
 =?utf-8?B?RlhjcTNoKzJzd0o1NU5GaUQ4SVdKekxqMlBUQnFoZkkySkJtck1QZDUxVzZo?=
 =?utf-8?B?aE5selJmNXlWNytsQjYzaldJYXVjUldJUmpReVZ3N3Z2cmQ2TzFtcDEvYXJ1?=
 =?utf-8?B?ckhNRkZkUWZGVElJWWdia29hdzdaNlYxNUdsT1U1dzVGQ1ZJL0J0MFVadHJ1?=
 =?utf-8?B?L0E0Ry9FWUhSOTJMZlJsSEJVcVpTUG5zVWFVU05PalJ0WkJmNnllTHJ4Vk8z?=
 =?utf-8?B?cTQwR1JqVHpVY2w2NHJnK2xUTllsNXAwYUFwOHIzQXJISERpVGN0ZXFoL3pi?=
 =?utf-8?B?aW9FTERDcmNSQ1hibG02NEVkQ0lvUVdPRmw1bW9yQWhoekpQeitPUkw3Lyt4?=
 =?utf-8?B?SDZ0ZzV5U0l5T1RYQnRtUE5XV3gyWnlTam1NcHNrWGp0dHlaVFYvTnpNd3Nx?=
 =?utf-8?B?d0RUMmRtREJkckRIaDdhNnNoa1Z2NzZtblBOcmVKRFhNcy9nTjhUTFdMZ2xC?=
 =?utf-8?B?Z1BGY01TVGhVSkovZkdGNmR2UGptZ3hZb0dnYUhLb25YUWJHL2FRTHQ3ZVVm?=
 =?utf-8?B?aU9yS00ya3NhakJ4SUx6enRSU3NQZGQySWtyQjBKQW9jazV6dWdsbTQ3blpJ?=
 =?utf-8?B?SW90NS8wMFZpVjhrdSsrU3V5SDRKdVJCOW1OVzVmcGhjWWR3eTJyWElIMmd2?=
 =?utf-8?B?aFEwRTJNRWljbERTTm51anlNdDd1Tlg0RmQvL0xPY2Rld0NuRFZMU3pUNk9i?=
 =?utf-8?B?VW9KeDNIZVdpbnRwUGRFOGptczBuUHcyK3RhRHA3ZUdzKzVLTDBHdVM1cnI1?=
 =?utf-8?B?SURqYWMyNnVSR1NLZ2g2N3RFTlhBbktxM21GKzhQbGZUSmZ3TTVlWG1wUHcz?=
 =?utf-8?Q?pGFm1X2n5WQVyqzUfou3LO8=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14b6d4-af0d-41de-9d7e-08dab11472b5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 14:24:21.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhmnzzaYZTpVVXho+sf/chgOnxxwDZBZk8Lqr1ZAsWqUmmzO8b0jeiEhefNeQr26XmOOA7ccHCU0sl6nagG+PZ2RP0LLATd4QpHiZ86Lcq4R3CPLDOPO/AsyiU82ezcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB2154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/22 4:41 AM, Leon Romanovsky wrote:
> On Mon, Oct 17, 2022 at 05:26:52PM +0300, Natalia Petrova wrote:
>> rvt_qp_exit() checks 'rdi->qp_dev' for NULL, but the pointer is
>> dereferenced before that in rvt_free_all_qps().
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: f92e48718889 ("IB/rdmavt: Reset all QPs when the device is shut
>> down")
> 
> Please never break fixes line.
> 
>> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>  drivers/infiniband/sw/rdmavt/qp.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
>> index 3acab569fbb9..06e755975f61 100644
>> --- a/drivers/infiniband/sw/rdmavt/qp.c
>> +++ b/drivers/infiniband/sw/rdmavt/qp.c
>> @@ -459,13 +459,16 @@ static unsigned rvt_free_all_qps(struct rvt_dev_info *rdi)
>>   */
>>  void rvt_qp_exit(struct rvt_dev_info *rdi)
>>  {
>> -	u32 qps_inuse = rvt_free_all_qps(rdi);
>> +	u32 qps_inuse = 0;
>> +
>> +	if (!rdi->qp_dev)
>> +		return;
>> +
>> +	qps_inuse = rvt_free_all_qps(rdi);
> 
> These lines are not needed.
> 
>>  
>>  	if (qps_inuse)
>>  		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
>>  			   qps_inuse);
>> -	if (!rdi->qp_dev)
>> -		return;
> 
> It is enough to delete these two lines. At this stage, rdi->qp_dev always
> exists as it was created in rvt_register_device().
> 

Agree with Leon here. qp_dev is created in rvt_register_device which will fail
if the qp dev allocation fails in rvt_driver_qp_init().

-Denny

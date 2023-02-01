Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C58686A7D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBAPiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 10:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBAPiP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 10:38:15 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628BEEF8E
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 07:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mabh9wsP3eknh4NCunghM9wofHuOvSxDLBpn3xMrcGgiZHFkSqbqjSCHiIdZ/ly6wVGhgQJpDh+UhnHQsQw+AR4wXDafpebQQs3Nuwcd1otm803gvvFiq5nZFCmn7r/MsEz6qN4dgc87iEmJJaDFHXjTrM18uzw7jWFk88TyfzCdhzlYJdh+Hmsuhd/0xHCuDpScUS0914KxTsMK3+Qz/d298h8z9xfIgnWkOoaH5530EH4rOiETDkp2fmfEVvPuSnGGAsTAMNv5anDebwsHj0rtkLhjoSGOFHh4ApLDhcMW8g3rubmtfyvIM46yV5qNOt8sqGP1f8oRvvl2RenY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCwzn0KYM18B/B52yiyxmKyChGPPp0cV3hsnCz5bJZU=;
 b=ekqeyI0xuWDzZvDo3oScURNsg05HmO//eOHoCMBo4qYlBCzfdrpNqaQ5WptdFvuCIAe1C5b1G1fxZMGfjSIdy1jVx8ShHDDUsLBtEf64UobEgfWHOvZZiCQXKcetZEOCRA/loVIfrQic/lJAoRKv3WBikUg41RfjwnNp86xheStbdkbuXiYuOE6cnD5gbbUhpDkBXOj0OOsAhHeRWjzd/SRChp1AOoSUCFuhwp+P8kyP98FdGfidVDsAM++Tz4V8O+RuG1XtVZbA2baDkh3xDH91BGHOC/DkB5NDonIA9IoEDVwb5yh6eFHfyI2UGe829sGzn/3yFnkeTf0CG1D1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DS7PR01MB7782.prod.exchangelabs.com (2603:10b6:8:7d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Wed, 1 Feb 2023 15:38:07 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d8d6:449f:967:ccb5%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 15:38:07 +0000
Message-ID: <24a30a4b-ab51-b24a-7976-eeefabb99619@talpey.com>
Date:   Wed, 1 Feb 2023 10:38:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230127210938.30051-1-rpearsonhpe@gmail.com>
 <TYCPR01MB845509B0DBC0BBCF1CC8DB73E5D19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <TYCPR01MB845509B0DBC0BBCF1CC8DB73E5D19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|DS7PR01MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: a9761245-a843-4512-d656-08db046a50fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOa7L32gqSq8RFjF7YiTAyo3BbtflrLR8rPLSKhnN95C2uXZTTj4HPPQ/anU0PVsdxcJUOIyNRNv9kDQnhaVQXfyNIRyLjImWo2yj/biSwrQlQqu3X5qlNvws8PyR6PCVH9KXAG90NsF8L1UC2huCVse5x5EJSe5jG7FXkCrj5z4Q18EXFcnyQoxPKQ+wNkQlC+OeIVIfIBIaLY7bg2WuGo9YwQJbL5XnYU52X2Zc2G8ipGRKMhQglINKLc0n/bXEyYwKyWfVsGHdPYyYnQyScvA0N2TzkTOuup7WqED2HojA/KZzaQ1Lek/qvh9u0VRRdHDaIVxd9Ok5+HQJxgsc21pf+tGA4a9aKy5jJJVZvlctwwqzcf7kyrK5jDbKtK+L9CH7941aa7+gUfkVDXzb0buKTaZ0hXLc31iAQfUEnNMCDjhHLTCkiidwRHYtmMeN5V2pGugrwl2YV3/jEuRZm7F79DzRAsFG96hvWEtfE2Z1QbMunmqzKl0KuuYHsBpq/GY2Pfea4yHpstSH9hGwlZGVAybrHiBKDnF7Ul3Iw7ZLEAP0eFEisut99AyUgyXiPteeWqx+dowu+NczDSzDvermMs3/gRXkyi1QHdE0H24ErkbFuuxc3MiAToQ8ai2RF0pQeeYrgVBCNYFbWEe8GIQOCNj3A1AIzgZCHQcrOGkn8dHPOWrrg+t5wPckvdkJvxvPVxIC7CWN/LbiIWTFQTRa0JtFK75dHGOmWuVJdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39830400003)(366004)(346002)(396003)(136003)(451199018)(53546011)(5660300002)(31696002)(26005)(186003)(110136005)(6512007)(6486002)(2906002)(36756003)(52116002)(478600001)(6506007)(2616005)(86362001)(38350700002)(38100700002)(66556008)(66476007)(66946007)(8676002)(316002)(8936002)(31686004)(41300700001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdFTzdCOVY4WEI4VG9vYWtsTWdZWEdTaTZ2RDNmYTRFdDREd3dRb0hVT3dw?=
 =?utf-8?B?Sjd6aHUrdU0zc2o5Yks4cy92ZllxK09QMDdUc1luTlNwUDgxeWhUYTYzOU4w?=
 =?utf-8?B?STFiVTdqSThjYnU5V3Z5bHY0MWV6NG0vWEM3amV6OGowQUdYbUd1dEN0cXJY?=
 =?utf-8?B?UlhMZWN5eTRHZVQzaUkzdy9YZ2ZQbmZ4WUxISkhMWHpnbDZ2aTdnR0czdkp0?=
 =?utf-8?B?eDdIcmJWRndHejJ5N0ZEYkN5TURXVkZqQkxhemx1NS9GWmJPR2had3M1MHpQ?=
 =?utf-8?B?YjY3eHcyRnZGR21zWHQ0Vm41ZEZRQk1XVnpQNXpCbUY1N1hRYTJ2R1dXc2RZ?=
 =?utf-8?B?NDVIcitwdFdwS2FzL1BHeXQ5UXNTNk5ud2JNbE0wY21ubSt3SldTeE5sWjBK?=
 =?utf-8?B?ZDZldnBaaHVkaEFzTElyczQ5cUJYYlF3TTFEKzFCbHBadjRUUmw1eXRZelln?=
 =?utf-8?B?M3FSVlllMEc1ODNjWG5iTFVJUGRtTnBNaUVjRFR3M3kvbTZQNnNTZEl4c0pO?=
 =?utf-8?B?VFRYNEVadGJJVXFudG9PL01uWnlQUC8yV3pocWxjbkd5OEZua291TGZlY1Jm?=
 =?utf-8?B?M1A1UjVsQWtEZ0FEZHFRRVdjbXltZ1k5c1ByS2ExTnhMcURDa0liNTFaNnl2?=
 =?utf-8?B?QllqUTd5Y3p6QThtb0swRlRrTTZnRnR2eHBJMm13RFg3TTFBelovcVN2VVBM?=
 =?utf-8?B?dSs5Y25rVHRQLytPS1RqaU1DTXFsNVlBUGhZYnpHUTd2ZndnbjY4THlnK3V1?=
 =?utf-8?B?czROa0lnS0hhemEvZnRQd0o3ZGR1ZFJRTXJSNjUzenJ4WWU4VzVoOE1lN0Fs?=
 =?utf-8?B?TkRSYU82eTBlZmNqbGRkbWp2ZC9ibW1qVU1lWmdwc2orQjRsdzJHRG13aW5u?=
 =?utf-8?B?KzhWWjEyVGcvbEwwQWU3UjZKcHJaUGV4SlRwbWM5Nm5VeHVmUU16WldIbVJm?=
 =?utf-8?B?VzNhcUd4Unk0TjFBZTVTMmM1emFTUXhnK1dVNmR5eGFNQ1I5QkhuQUFQSXJZ?=
 =?utf-8?B?YVNoeEM1bFpqQ1hTRmhEMXlCWVZFV2pFa0VoUzVIUlArWVdEOXNoYWJHWVJy?=
 =?utf-8?B?NUFNOXZjOWlFTTZSTG5tQXZpai9oYmhYdzNRVGpLYURUejRkVlA3ekFkSFRn?=
 =?utf-8?B?QXZJVVFlcW0vSjdrRllyR292NlJWNVAvcDhJNjQrVkR0aGdoM1JncXlBUzUz?=
 =?utf-8?B?UnU4MjY0ZERqcGtEZ1EzVzhaZ2lPbmVjRmVXWG1EbUo1aG1CUFlmMVhndDg5?=
 =?utf-8?B?Q1lLblo1aEttT1dyNjNWVW5oVHYzT28xaUF5VkU3M1FuRDR2OFY4ZFdaOXhV?=
 =?utf-8?B?MVp4RHZkSWZIWWp4Q3lDZlRsSVNhN2drMkl5M1J4TVlBUGFlT0RJYmJ4ZDVN?=
 =?utf-8?B?Q3NNbklWeHJYTWR6S1dHeVRMT1pOMXh5UU81RHJ2VDNCY3dtRzk1NVlPNjNn?=
 =?utf-8?B?bk5DamVDYmxpaTc0OWZSYnIzV2dvWVJFSFRESDhXRDJxVE81NlAzRkhzSXFN?=
 =?utf-8?B?UTBhd0hRSVJqdGtyenBXbm94TldTSDRQOWZtSWJST2hSM09Za2xmRUVGdlY2?=
 =?utf-8?B?a0FtcThSRXdRc1F4VGdRUjI2Q04xNkFhUExMazg2MEFnSDVOdkw1V0pFUjha?=
 =?utf-8?B?TDVZelJDUkFzRmozbU02cXFHN080MEZVeTRVd25qZ2NQYytuS1hXU3JKYUp0?=
 =?utf-8?B?Mjh0YWdwSXk1S0lZL3hiZ1d4dEJKUEJVc2xoeVBMMnVvajF5ZzBHVk9pdFB3?=
 =?utf-8?B?bmVMNDdRMkRaaWZLb2t3eHIzRDFtUEdFT1U0RGVEOElYRW1SQ2tQcWRPeGtT?=
 =?utf-8?B?V2lFUWlFWC9lZVo3MDhsNWVzUGphQ3lhN3JXN3ZybCtyK0F4VERCZnZoeVEx?=
 =?utf-8?B?bFZNa2dGMGJiTXAzdHQ1c1Npc3Vha0ZTajlIb0kvZGl4c3BFOWhaZ0N1RUJ6?=
 =?utf-8?B?K1VqQlFNUFdtbnpjSTZ3U2pDVWpJQWJBS1BGamJlMEFvNzJmbjFIUERXalFZ?=
 =?utf-8?B?WjdzSkxuNUdUZWFuM2E3bEZMU3lMOHl5Tk5RNjJZb1FNT3c4OXBWSkphSTJ0?=
 =?utf-8?B?UWU3cXh3aXRIT3hkcDQ3KzdNZ3ZUdUF1N0dZaUtsVVFzZVJQM1Evdm9zeFhD?=
 =?utf-8?Q?FCgA=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9761245-a843-4512-d656-08db046a50fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:38:07.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BQOvB0kWkdKu5Oq/RYKYfjGBf1nzLPeJXSbPsQsvANCSBEYoV0Kn7xvaI4oidFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7782
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/2023 6:06 AM, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, Jan 28, 2023 6:10 AM Bob Pearson wrote:
>>
>> Currently the rxe driver does not handle all cases of zero length
>> rdma operations correctly. The client does not have to provide an
>> rkey for zero length RDMA operations so the rkey provided may be
>> invalid and should not be used to lookup an mr.
>>
>> This patch corrects the driver to ignore the provided rkey if the
>> reth length is zero and make sure to set the mr to NULL. In read_reply()
>> if length is zero rxe_recheck_mr() is not called. Warnings are added in
>> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
> 
> When I applied this change, a testcase in rdma-core failed as shown below:
> ======================================================================
> ERROR: test_qp_ex_rc_flush (tests.test_qpex.QpExTestCase)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/root/rdma-core/tests/test_qpex.py", line 258, in test_qp_ex_rc_flush
>      raise PyverbsError(f'Unexpected {wc_status_to_str(wcs[0].status)}')
> pyverbs.pyverbs_error.PyverbsError: Unexpected Remote access error
> 
> ----------------------------------------------------------------------
> 
> In my opinion, your change makes sense within the range of traditional
> RDMA operations, but conflicts with the new RDMA FLUSH operation.
> Responder cannot access the target MR because of invalid rkey. The
> root cause is written in IBA Annex A19, especially 'oA19-2'.
> We thus cannot set qp->resp.rkey to 0 in qp_resp_from_reth().
> 
> Do you have anything to say about this? > Li Zhijian
> 
> Thanks,
> Daisuke Matsuda

I'm confused too, Bob can you point to the section of the spec
that allows the rkey to be zero? It's my understanding that
a zero-length RDMA Read must always check for access, even
though no data is actually fetched. That would not be possible
without an rkey.

Tom.

>> v3:
>>    Fixed my fat finger typing on v2. Mangled the patch.
>>
>> v2:
>>    Rebased to current for-next.
>>    Cleaned up description to be a little more accurate.
>> ---
>>   drivers/infiniband/sw/rxe/rxe_mr.c   |  6 +++
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 55 +++++++++++++++++++++-------
>>   2 files changed, 47 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index c80458634962..5b7ede1d2b08 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -314,6 +314,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>>   	if (length == 0)
>>   		return 0;
>>
>> +	if (WARN_ON(!mr))
>> +		return -EINVAL;
>> +
>>   	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>>   		rxe_mr_copy_dma(mr, iova, addr, length, dir);
>>   		return 0;
>> @@ -435,6 +438,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
>>   	if (length == 0)
>>   		return 0;
>>
>> +	if (WARN_ON(!mr))
>> +		return -EINVAL;
>> +
>>   	if (mr->ibmr.type == IB_MR_TYPE_DMA)
>>   		return -EFAULT;
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index cd2d88de287c..b13ae98400c1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -420,13 +420,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>>   	return RESPST_CHK_RKEY;
>>   }
>>
>> +/* if the reth length field is zero we can assume nothing
>> + * about the rkey value and should not validate or use it.
>> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
>> + * value since the minimum index part is 1.
>> + */
>>   static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>   {
>> +	unsigned int length = reth_len(pkt);
>> +
>>   	qp->resp.va = reth_va(pkt);
>>   	qp->resp.offset = 0;
>> -	qp->resp.rkey = reth_rkey(pkt);
>> -	qp->resp.resid = reth_len(pkt);
>> -	qp->resp.length = reth_len(pkt);
>> +	qp->resp.resid = length;
>> +	qp->resp.length = length;
>> +	if (length)
>> +		qp->resp.rkey = reth_rkey(pkt);
>> +	else
>> +		qp->resp.rkey = 0;
>>   }
>>
>>   static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>> @@ -437,6 +447,10 @@ static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>   	qp->resp.resid = sizeof(u64);
>>   }
>>
>> +/* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
>> + * if an invalid rkey is received or the rdma length is zero. For middle
>> + * or last packets use the stored value of mr.
>> + */
>>   static enum resp_states check_rkey(struct rxe_qp *qp,
>>   				   struct rxe_pkt_info *pkt)
>>   {
>> @@ -475,8 +489,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>
>>   	/* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>>   	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>> -	    (pkt->mask & RXE_RETH_MASK) &&
>> -	    reth_len(pkt) == 0) {
>> +	    (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
>> +		qp->resp.mr = NULL;
>>   		return RESPST_EXECUTE;
>>   	}
>>
>> @@ -555,6 +569,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>   	return RESPST_EXECUTE;
>>
>>   err:
>> +	qp->resp.mr = NULL;
>>   	if (mr)
>>   		rxe_put(mr);
>>   	if (mw)
>> @@ -885,7 +900,11 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   	}
>>
>>   	if (res->state == rdatm_res_state_new) {
>> -		if (!res->replay) {
>> +		if (!res->replay || qp->resp.length == 0) {
>> +			/* if length == 0 mr will be NULL (is ok)
>> +			 * otherwise qp->resp.mr holds a ref on mr
>> +			 * which we transfer to mr and drop below.
>> +			 */
>>   			mr = qp->resp.mr;
>>   			qp->resp.mr = NULL;
>>   		} else {
>> @@ -899,6 +918,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   		else
>>   			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
>>   	} else {
>> +		/* re-lookup mr from rkey on all later packets.
>> +		 * length will be non-zero. This can fail if someone
>> +		 * modifies or destroys the mr since the first packet.
>> +		 */
>>   		mr = rxe_recheck_mr(qp, res->read.rkey);
>>   		if (!mr)
>>   			return RESPST_ERR_RKEY_VIOLATION;
>> @@ -916,18 +939,16 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
>>   				 res->cur_psn, AETH_ACK_UNLIMITED);
>>   	if (!skb) {
>> -		if (mr)
>> -			rxe_put(mr);
>> -		return RESPST_ERR_RNR;
>> +		state = RESPST_ERR_RNR;
>> +		goto err_out;
>>   	}
>>
>>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>   			  payload, RXE_FROM_MR_OBJ);
>> -	if (mr)
>> -		rxe_put(mr);
>>   	if (err) {
>>   		kfree_skb(skb);
>> -		return RESPST_ERR_RKEY_VIOLATION;
>> +		state = RESPST_ERR_RKEY_VIOLATION;
>> +		goto err_out;
>>   	}
>>
>>   	if (bth_pad(&ack_pkt)) {
>> @@ -936,9 +957,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   		memset(pad, 0, bth_pad(&ack_pkt));
>>   	}
>>
>> +	/* rxe_xmit_packet always consumes the skb */
>>   	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>> -	if (err)
>> -		return RESPST_ERR_RNR;
>> +	if (err) {
>> +		state = RESPST_ERR_RNR;
>> +		goto err_out;
>> +	}
>>
>>   	res->read.va += payload;
>>   	res->read.resid -= payload;
>> @@ -955,6 +979,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>   		state = RESPST_CLEANUP;
>>   	}
>>
>> +err_out:
>> +	if (mr)
>> +		rxe_put(mr);
>>   	return state;
>>   }
>>
>> --
>> 2.37.2
> 

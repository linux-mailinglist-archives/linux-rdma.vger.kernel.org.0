Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47953673E1D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjASQA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 11:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjASQAt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 11:00:49 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2123.outbound.protection.outlook.com [40.107.100.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACD6CCEA
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 08:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li7X/QCHdjKINlSe9U3lZpv9Z9v8aULR8xxRFikmtAYYs4hV36luuTN6vbpQ3YOOYioyEVokiIXH+4JNDoZcUPJGGLxF3TKpOBOF0kuWKJqwAeMmCujevB2hzrloVkgBPXBQXTmkXJrtVYMZrHItP9U9LaE2n/TlO1SVMJrMW0Np639SmLqQ9E3BDUTiZ5KjzI4qo6iK0GwLOWVxKK7NNbvubgFkKDg7LLH1KcO7GmORFaEm/5qCyW7dZGSqMi8QijwbhBs/Ze6W0N+p1a9wYb5Tmn4d3sISfOetaH1mxULborfQ5XyWa6vKCy60MvLP+Ur0AAwsbihACmUHhVayRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvaoHEIq4XQH+GXaqQz9FaFvKnWv1teTYiQXp8ZCh8k=;
 b=ctp15mJBxrAO9+lTYqfgiVak4S2mgUzwEAiLjSnq9FRnj60fuZ0yn91VFhwYXC675b7m4RMTAcidQZk+DwVyfpty/5DkZ7iaxkj2Sf9skjaE93Mu6TeswhdeVCaSsBUnLIv3yOqPyLSYqy3wQ8gZBC/sNcvuMYaPbJJtW0gggDLDMpZJEfEwCMaMXehdw1duH67dpjHtWBXMkDOlv/ha3QP6BW6SsM0MeDyvEnbQgN34VfezexoqSaOEwh3V/l+iHs8bk4mxb5xzjOnS1p6ODQbLn7bAeus15k6zJsQSRnQv+jGgPA4C09P8TJ4xXnl+tn142Cw4rwfY8ZANx9ViVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvaoHEIq4XQH+GXaqQz9FaFvKnWv1teTYiQXp8ZCh8k=;
 b=YSd7mOsMydfXDUxO0MfVwEqZKR6Ow517cjxCjNyTFPH259x5PdDXnlO2G714QUedGf/6uRT7+xtJacJ3fieX53viX+EM+gAFPvP7CNJso9CkF6VJxr6DBKzeXEKVzPpyt/K12m+V49rhxku0/KiJ3J8KTSlVDEVlqX73auTD7gUtNw3ENEKcpinbbzFWlVPZEUtAlijZRUIIkH67z0AYcWPtRIYrXTPQgJaiMI7l67pSZENnBEMKs7mIi9E9M67WQB+SzJioB1P/1xDCvGaUvXl8dfHQOvOcu+QnLa2x3bm9S8iKSFq/w2rY5WFqIDrt+exVHhURZZTwVgR3J7va+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 BYAPR01MB4039.prod.exchangelabs.com (2603:10b6:a03:15::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Thu, 19 Jan 2023 16:00:42 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3%7]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 16:00:41 +0000
Message-ID: <90652c2d-a874-fb24-3356-55c9b7003feb@cornelisnetworks.com>
Date:   Thu, 19 Jan 2023 10:00:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        leonro@nvidia.com, linux-rdma@vger.kernel.org
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
 <Y8VwHYPYlV459T1j@nvidia.com>
 <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
 <Y8fpNLbRuT3UMhJK@nvidia.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <Y8fpNLbRuT3UMhJK@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:610:74::34) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|BYAPR01MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 550ebe90-0c25-469b-4999-08dafa3650a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JvVUbUoOnoAXj06EGvG2PHjgzFVZ6bsxgWSLOlfYE3JMXQfeT9jpGH1i5c3Kv+O0jp7DlNJEZej104sqegpVUxUOymIn2AI+L+tPbQicH4+fV9GIGS1Sc+bHRNoxrTgTNCzoti/x5GvrUPbeIlBgdi7U5z+J6rWl/oix5C3bX/XhnnQtZm+8e2HPWOEvLGxDlGDSce+Cae8KoPcnO4fCwXsloQ3M4RREQg7GD44Yn1JwHoNyIIg4VMdivzO9ePUSzdfgTyz4eDDisqB5MvG2IZdmW4X2TSHFVaFNYLoh2LnpoCJYoHkWv8OUc0AzVBIjE//hI83a4Bbz7oKNABq8yLbl7e+/vvJbGq1Q2tnOQVK+snmWuhA07pulLiHAnKT5vfTbUZtp9zHYMC46VIgA0ir0/Az4Aw6BFgBfLLlvzYdbKkPwFeYUO/Dj6f9dmu+Kucn8FrVpSKFR/6e8gASMGUXxb5SPY1heDDHTXK8j0I0GCLSsdr3o4VnQfVuoivXVhfuy17S/gcUA1wp5X85HJ6NmY7Tj9ODzV/oa2rO+JsJJm7fq288/YlkCEPKMlNCyoohUtxibIwsBxny3bc2uA31ZOaU/PPEQp3sUCMZeuhZL8B71sFSRh2jbRs51k1sd7JGKbajqusIq1Ht+TmMirEmmvi0vmsNRvV4vAiasyW/EkEY09Bx38anrOkjXUvU833bHQ/p/p/rdasT6kMI/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39840400004)(346002)(136003)(376002)(451199015)(8936002)(44832011)(5660300002)(31686004)(6486002)(478600001)(6916009)(26005)(53546011)(8676002)(4326008)(36756003)(66476007)(66946007)(41300700001)(2906002)(316002)(31696002)(86362001)(66556008)(38100700002)(186003)(6506007)(6512007)(2616005)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnh6cU1GTlk4RzVrcFltc0JzTHgvbmltKzZoZ1JyNHQ5d2Z4aThJdEhqdlFp?=
 =?utf-8?B?ZGpzL0xwSjc3cmZ1QWVkQ1R6NDM0ZW1PREtybVprYzRKU2ZZVHVSMFpyM3dW?=
 =?utf-8?B?Yld5WlFMcmlFODc2b1hwbjR5YnZBR0pZYUZ4QlZFQkczT2k5TkpsVElPdHBV?=
 =?utf-8?B?dVpJWlVaMzFOR2ZqQU9aMVM2ZGErM25ZQ3ZkYVBqYy9hMmhlQXJOSUUzUklH?=
 =?utf-8?B?d0lncW5OWTVWV2lWelNmelpCY0pQTE9XdHJ6RUJ5eSs0MWNoMWxHeXRxcVhm?=
 =?utf-8?B?ckhVbjI5MUlqSkxKMnh1c21IcThvZlJabGtwYWM2UkFWRllsbUdrR0QycG9v?=
 =?utf-8?B?UkV3OEpWVCtQdmVRS2FpWkVYTWRpZ1RBTEx4RlF3c09uZ3JKb1Fkdk93MGJq?=
 =?utf-8?B?b3lxQTg0YzRrbVBDUnVsdHpQc2pHbjQ4a1MxWFRsaTh4b29JSW5FMlFJSnZy?=
 =?utf-8?B?SUxNT1Nmc2hrd3NCeW1lMDczVEZqbi92VytzTTBTOWJMM0hscnNkWkhuemFF?=
 =?utf-8?B?bzZMdjB4ejNOVHZnTUkyMWpIWUltcXRNSkkxTThEUEZPdFNWemh0MW1zRy9n?=
 =?utf-8?B?emVrdTRFVWRWbHhJNVhINDVCanlVclJ3Sm1YclF2ajVZVWc0ZENxVEUvZGU3?=
 =?utf-8?B?TlYwNDBzM0s5ZzVLTENOcENRYXRGMUhZRkdpOHdlbHpLeDd1RHFpNmFWTEFQ?=
 =?utf-8?B?WVhIekF2aVZGcDZ2K08zSHBnNmRVZVFXZ1hNUVFFSnI5dk1PLzdjUUZSVGJU?=
 =?utf-8?B?REE2WTE1Q2RCTlNCNUNwbks4cHZGOWxNenVpRzY1N0FHcEZqTHF2M2pRd3c0?=
 =?utf-8?B?NUc5dmRRbW1pQUhDcmpDbnkycXMvS0lsRWNIUzltR1F3WUJTTW1HQnVzT3Bq?=
 =?utf-8?B?bFR4ZnRtakFibTRyeHB6U0ltNitRek9YbVFBYlRrZVJ2MTEyd2NUayt1MXpP?=
 =?utf-8?B?TktBWTlKenhpTTdVRDVFeXI4ckMvS1E2am1tdXFEK3FSS2p4Y3lLdWJ0cU1i?=
 =?utf-8?B?dW05ZEJTRDRJTVh5TnN6YXJXcUxTTFhDNDdJaWI2RTQzSFNOcUlnbVhEUUxQ?=
 =?utf-8?B?dlZqai9xaFN6dVNidU1hV05jbUxwT1BqMm1abTEzV3dUdTNCcUFxeXRTbzM3?=
 =?utf-8?B?d3RNTWFsSXE1R2Jpanhyc1pwZlF5WG10SkZ3YWtBejBxNUFOMkU4QUJ6eXNL?=
 =?utf-8?B?WXVDQTIrTmdVVTRTL29scFVWR2IrYXEwUkxxaHpVKzdVZ08yNzNLZUk3QTds?=
 =?utf-8?B?eHNOQ0srRVNhVTI1U1VaQzVNaVlqZHVhVDBTK3YrL1NBdnA0SVNOdEl5c1ds?=
 =?utf-8?B?bS9xcG1FQzdxRlltQkhwVXNHcVdnSEI2OUE2WE9sOXZ6c0NDeUF1YkZqQUFG?=
 =?utf-8?B?UDg0YS9hQ21yQUFxdW56ZytnUlMvdjY2cXZLbm1CcVdicGErRTVCdUhKdTJG?=
 =?utf-8?B?cFUvU2ZDNjY2Vko2eFRXSHNHNmUxMjJodmlQRzVQbnBmQVRRcXo5RG9GZlhT?=
 =?utf-8?B?d3hXUTVJR01GbTlsVkNmbGVpN0JSWmtJNjE0MkZXZERJdDUxRVZwQncwMUZw?=
 =?utf-8?B?Sm5xNng2OUZJcjJHMHozaWVaK0pOY2s2UC9uWE9yZG9TZXpybjYzR1RPem1J?=
 =?utf-8?B?S09JZHU2b1hKdUxnY1lEUTd0UEdOcnE1TEZEMEhyaEI5eHdxU05UYUM2SEFa?=
 =?utf-8?B?elgwaDNFelRXeHp6NjVPRHVHZHRhVGpkQVNTQVVxK1BkTzJqeHlrTlRRaGlt?=
 =?utf-8?B?ZUpwWWlzVmk2MTE5NnV4K29QNDhiVlVwd0VYTVZuTjU4cFE0anA2T3JRMHNs?=
 =?utf-8?B?Nk41WEwvRmhXSFN3YUZtRCtWaFJkRE1PNm1JTjV5WjRncHFxZHhuU0dqT0cy?=
 =?utf-8?B?MmEra05HcnROa0Q2YTlweDhXRHR6cHlQNlZxN0NsRzB3L1RPcGpFSUppczZV?=
 =?utf-8?B?S29zdXQ0VEFiOUVVSGhwNXNjajhiODVReTNPZzN4VEUrZlhVd0tmY2szQXIv?=
 =?utf-8?B?OHgvRWdDSUpuaHFNc1J4QTNSMmdxSmRuRElhV2VtQzk3cUpXZ0lXdGIwQWRj?=
 =?utf-8?B?MC9PaHJLNjlGVHFwQUNreTdXd2NpMUZCVHJmdVc0TnR0UFlVZ0JqT3NIU1Y4?=
 =?utf-8?B?bXpGZHFUWkpuMVlEZUYzRElrYWlyckIxN05hVytXUzF4b0pBaFFXQTZEYWp6?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550ebe90-0c25-469b-4999-08dafa3650a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:00:41.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDfQQox+pcuSi/G7UVBMCjnreQFMK4z5WKb8thR+Fz91RAcLslfYXHsoi9O3J4E5Nica7XXLPuQB5fqp0pj3AtWnUD1QOLQQTfWWdVSvJEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4039
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/18/2023 6:42 AM, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 01:19:14PM -0600, Dean Luick wrote:
>> On 1/16/2023 9:41 AM, Jason Gunthorpe wrote:
>>> On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:
>>>
>>>> +    if (fd->use_mn) {
>>>> +            ret =3D mmu_interval_notifier_insert(
>>>> +                    &tidbuf->notifier, current->mm,
>>>> +                    tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
>>>> +                    &tid_cover_ops);
>>>
>>> This is still not the right way to use these notifiers, you should be
>>> removing the calls to mmu_notifier_register()
>>
>> I am confused by your comment.  This is the user expected receive
>> code.  There are no calls to mmu_notifier_register() here.  You
>> removed those calls when you added the FIXME.  The Send DMA side
>> still has calls to mmu_notifier_register().  This series is all
>> about user expected receive.
>
> Then something else seems wrong because you shouldn't be removing the
> notifiers in the same function you add them

The add-then-remove is intentional.  The purpose is to make sure there are =
no invalidates while we pin pages and set up the "permanent" notifiers that=
 cover exact ranges based on sequential pages and how the DMA hardware is p=
rogrammed.  Once the programmed hardware range notifiers are in place, the =
covering range serves no purpose and can be removed.


-Dean

External recipient

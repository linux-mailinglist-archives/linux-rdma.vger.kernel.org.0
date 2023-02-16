Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006F66999BD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPQTB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 11:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPQTA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 11:19:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2139.outbound.protection.outlook.com [40.107.94.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84083DD
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 08:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L04fi20SJeHNevyWbrLTxDX7/bIeeWcSbUVIyxQI9lKbh9HErGh+LgLSCQtEsS+6OZAfHIeJAzbkWgwTlJr2Yqxru+Mg5TL+Z/eOpp0pXyCsbFs5vkeyzMmD25mLwzXI921nNWBRrsGgaHwZEsexw1rhIFMbKy2Oxg1lDRTTTqki3cea0RyArwvBvN0nLuHanjISvLY5CbEQmvXT638s/ruGHWVxsk31Bd8+GnLpSEPlNuy/O9965QkEMN52PTwK2gV1qbJ+AoAiOtYeZfbhZhHffrf+HrMhpSAx/5/wlJHvLgMTrTExNTlrRJ3efjE9ABqWvpsEnfbf7x8Grcyj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQzHPDmVo/Xbybt9qVg1PrGj33unKcopMqJ63Htk8+E=;
 b=TgySqfpnviIgDrA0oBiSR2Soj8Zz2BfymqHmkfx53cJY56BRsV599jKNBRUbwTr/GBA6hHqSGqnEXq6d2n3TSt1wJXGmWCopa/I/ph8iuqM4drofun2isTk8xJAmgRkybrDoZ4G8FZi8+z33bSbJDkU2Vdp584+oyJwvCDZ5jiT+AEDjRULx0oqlW1FS4sileizeqpu9ZEcvY2CRe/xCXDPNWF7ywKKBweq2mCJxeJ3vwg4KB5rGIFZfpPoZELutfY+AegRdAHuCUQDu78Fg5d5LoD1kVmzqMoVdGbGi0hzvjzlCZOpkhJmJ15i38yJga40veRvsUJp6p5gjdwBRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQzHPDmVo/Xbybt9qVg1PrGj33unKcopMqJ63Htk8+E=;
 b=Vqw4M26xwo3TpQmoFBxeG+xMv7VhIcjACAqvpM0ZIc2o6gjpGNMY1afJLlNpZD83ipITNOvbYcLuA27S0G8QTK0Jue6DeUJSzoptZ3taa9kIc08E6+hTzoTDsifUkXgEklfdMgLSOne5Wq4OtM66h0DCkKmA43l08cwvaJFJGmNQAjyRwwctrHvnBgIc6mT/R9GPDaC9vu2CMrrY+tGhaJdAm3eOP65kqyBDM59yxIwYIVzPyzxvgWKg89Fo3dtYYMgCeHMSRumJS3veVFgulNBhtRPQBMUGaGcOfWrB1si9BUsYpM+m419Faamf1QdeekH8LflAwOxN+8ZlPhyniA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 CO1PR01MB6776.prod.exchangelabs.com (2603:10b6:303:f4::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 16:18:51 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 16:18:51 +0000
Message-ID: <c95b844a-7354-bbb3-0404-7e4040c7484c@cornelisnetworks.com>
Date:   Thu, 16 Feb 2023 11:18:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH for-next v2 1/3] IB/hfi1: Fix math bugs in
 hfi1_can_pin_pages()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
 <167467689891.3649436.5979603883827786631.stgit@awfm-02.cornelisnetworks.com>
 <Y+5H1nw0Kyse8xyi@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y+5H1nw0Kyse8xyi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:208:32e::13) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|CO1PR01MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 07151f0f-0edf-4544-ccd5-08db10397de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdkYq4Da2GIgx0GEpA8CPtWig8NA+cpmyvWUNwfQ390/kyBi0CNft74DuCkQ4OV7QcbKEAWD9rQKtWzMp5RmynEYtWKE7xUCO6weJN2sAFcKfQ1qLt/pfnn2HT+xcj/aH+xb4ejD+002c/bkyyiX48Hi9p75W7XUActpN1qu5vpyslWOxhbhpx6sjdyEo2LNAxfqYdkgfmsQWi7jgWOWgJxEUIjuU0s6+SDPCpHyH0OGsmBWvPdcL/r6A24HLD52Z72YSkfCaXQA4hN2rREhOv3APumBE2bHXTOhzu9LcHWVkiT46bUnRa6NW7aToXRklah7kVKyYu1VH3dFrSKmuTnqEH8g/Jfp9fOG28pGyEatSz1qoLX/r1Sqk46bqPAJFSvTfKJ5ZOvoiKtn0cNQH8RdSjE+W32/wCDVQQDHtoyEuJT9C5bK1CHbysRgFVY7p9FR+Ha+Nj7aRSOMW7oyARFhe+UzrUgdTldPK1eGt43sxAIcmQz4AqctFv64lIIo4775lnwLL7jZfcqZwEj8ZofTsy+jEyIcLT/4m8wvFsi2FswGtKjuyb3vSv5gDyoPxqLm/ZdMOEjcnPPJNlyO+85sDglKdpYcehqguEJApWDm6VmyFQQJn5BjNXbQYLk+3jO748vXwRnS3lvkD7QPEcO/HQkWtoKjkb8yGFC1vk6Z/Yj8MgDgGhklDp664TEz/BIiuMxIJ3tkc0f4fqNE3NuImF2zUvqzYJ2/4uU2Rso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(52116002)(4744005)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(38350700002)(2616005)(38100700002)(83380400001)(31696002)(6486002)(6506007)(26005)(6512007)(186003)(53546011)(6666004)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05OZnpBNUNXUHpBSUdXYWVHZTVLTWhZTGZFc1g4TWcxazVCUno3M3crbjgw?=
 =?utf-8?B?SjAzT0lTQUpVdUFobU5MQmhTZEJrVng5dzVnR2hLUHB6L0FISTluRG16M1k0?=
 =?utf-8?B?NmVYWitDQ2VqUkE3eFV1OXF1TEJxVlZSa0xtdFdwcTByaU12NDdQM2M1ZDd5?=
 =?utf-8?B?dm5jRVB1VlJBZU1zdTFFbFkzYm90MHlEd1RYWnJpdEJLYXRZRTE3QjZBVGpE?=
 =?utf-8?B?VzZpbGk3TFlseGhlU0JzaG5qQ0ZiZkp0WDR5QzkrZGtUVVpKb0x6ZmUrbUpG?=
 =?utf-8?B?eVE5a2JER0FXNXJOVGRJT0l6bVpuUjhOVjJnOHh3d3BlbzNkYURUc01ENHNv?=
 =?utf-8?B?UmNVWWNtc0NyTG5Qc2xHTXZ5bHc1TTRXdUNEVU45Zm5zaUhXMExPd2lDTHFi?=
 =?utf-8?B?M24vWVY0Qnp2c0F3d2g3aS93VkZIdFZHcFU0eXpNYUQ1M3lFRldaTUV3UThH?=
 =?utf-8?B?alZwelcrQXlXV2NxNzRUOTNEZmdhTHNDcXh1aWV5THdRM0syb1RCYmJjRWtH?=
 =?utf-8?B?WGljZFhDRFhZdDEzWXhhdndiWTZ0ekxPR2VnamJtVlpmT3VMWFJ0Q2JOcm5X?=
 =?utf-8?B?aTJVYVZ0ZzExZTVSdGtacExJak1rZkZmVk5iS3g2MjJUMmYrNm9RU3QwMDdq?=
 =?utf-8?B?UmVEa3l1cFdtckhMRVE1SWUzdGtiVVR5VTAvS2RKc053K20wei8vaG1PU0ti?=
 =?utf-8?B?R0VEMWo5elRFNmFndEtkWWU3MmxWRVZ2T3RlR2w1cXJuTzQrNEsybitxbTF4?=
 =?utf-8?B?U3liVjllbEJkbHZhU1RPUnZ0aVRIRW55dGZFalQxM081eUVoSUhBOVRORTZX?=
 =?utf-8?B?Z1FjbXJCbE5MSjN5M09XQUo5QkxBcVRJU2tnRitJajdlOVFqbFFKTFpPdlhN?=
 =?utf-8?B?WWhZYmdvb21lais1ZzdXMTVaaTBlMnRoRDZ4S3E2dWQ5VEpCZkdxTG5HUnNN?=
 =?utf-8?B?YVRPTTF6U000VnZSbHFlbFlUTHljcWFkQ1ZqYm9nSEN2d0VHWXNPNko4YnJJ?=
 =?utf-8?B?YVorbWRQZjVvQytHdnpSTDFnbHZpMXVzd1lveXp2YUZhbWJNc1ZaUDZ5M3Jq?=
 =?utf-8?B?Y1JVR3YzUHRoNGpNNXB3bW9CWWxlNXJXcDNkWitUWmFPV3Q0NktWa0ZOOXZy?=
 =?utf-8?B?Y0ZQN2RNRyt1ZjNnRWRsQkpGTGJZOWVzTE1WRUFVakRSaFNuYWM1NVF2WlZW?=
 =?utf-8?B?WjNCUWhJQnZrS1hCczNNbDc5dE91MU5MdmhnRlJzalFSYVB2SkhXbThXcERX?=
 =?utf-8?B?S2IraWZ0em5BOWppOTNTQnBITjlQN0Q1d25reE1hT0VuU0s3bW44RWlNZHA0?=
 =?utf-8?B?dk5LSnc5L2dEQ1NKMHFtMktvTnNUbG1OTEZZTVVjc2VtZmRqaHA3cXBaM1RG?=
 =?utf-8?B?bTdtV3NTQVBoUlhicGYrZmsrQUt6Vmx1a09GQzJMU2xVOE1TR3RiT0hENG9L?=
 =?utf-8?B?WWVhYWplYXZTUUhDLzRVM29XODYxRE5RQ0VYKzJQZVBWRi92dFZEVWpzemRN?=
 =?utf-8?B?eFJ5bzhoTzFVZmJIb2JvL3g2bmZpc0dYVXVMWVJvS281Y2JSK2tiL2lCSER3?=
 =?utf-8?B?aFZVRDNDYjhSUjNmWUFsMjRLSXZJcFRWYVhEQlB6cmx2eDU1TXQyM3RkK1Nq?=
 =?utf-8?B?VEpQSVpiTTdVQlNiOS92NUZHaUtQU1NVNit2azBuNHphY0VmUGlod04wV3do?=
 =?utf-8?B?MVF0S0dBUXFPeW9GZGlxVmlzQnU1c25jNnlFRDVnMWNWS0RISms3RGZhalJt?=
 =?utf-8?B?enN2bm84KzBKMmlWRDh4TEZ6VE03eXlQaU4yL3pObEd5YXo2cTJFRWJoRUdZ?=
 =?utf-8?B?ZVZQVXNKb05sTHVhazR3UzRoeDN6NnJlVGRXdVphbU9GZDB4Y1VCZXdhTEdV?=
 =?utf-8?B?YWcwSEc2eXYrSU5vdEhJaFhxWFIxU0JZVHF0dTUyZDlualdFL1dOT3BFRm1p?=
 =?utf-8?B?QnZPQS92ZTJ2MDRuVWMvQXhTbTJSaThwMlJJYzhMKy9FWFdTR0Iwa2FDTXMv?=
 =?utf-8?B?blVSMklEckpxNjBSSEdPUmRFeVBkVnNHVDdTc0pyN1AzZXQyTmRpenY0WXZv?=
 =?utf-8?B?eGkwQTdxTGtNbitjbHlxakMvaFJ4VnIzSHBDUGZiQ2xNcDU5M2E4N05lOXV4?=
 =?utf-8?B?VXdEcUd4YUY1UTVJTlNnQ2ZvR0pHeStLZEdMM1FIem9YLzZmOUZkOGlDVVRZ?=
 =?utf-8?Q?X/Lnpdfbe743W3qIZ4RefYo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07151f0f-0edf-4544-ccd5-08db10397de1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:18:51.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG0cebhBUWiEyDWNymSWfnfvl1tegDBZ+fgZDy4mIkgXHvIkMKuiBdkXYWp1Tpw+lVCfMPeLx7FbQd0iSWDciwM+JfASZ+WmSVhzrQcxGh00+yAgcZqFAuCxLALopcU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6776
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/16/23 10:12 AM, Jason Gunthorpe wrote:
> On Wed, Jan 25, 2023 at 03:01:38PM -0500, Dennis Dalessandro wrote:
>> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>>
>> Fix arithmetic and logic errors in hfi1_can_pin_pages() that  would allow
>> hfi1 to attempt pinning pages in cases where it should not because of
>> resource limits or lack of required capability.
>>
>> Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
>> Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>  drivers/infiniband/hw/hfi1/user_pages.c |   61 ++++++++++++++++++++-----------
>>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> I was going to take these first two patches, but where are the fixes
> lines for things that are clearly bug fixes?

Let me resubmit the entire series. I think the patches cleared 0-day builds already.

-Denny

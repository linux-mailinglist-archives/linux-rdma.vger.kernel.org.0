Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37486C4F0B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCVPJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCVPJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 11:09:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E971317CF0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 08:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zaz6wFyyID72l5qjoguXljian5hKcLLZun1elK9Pm2miUfLvhD9AxSg9rfAzD4Xi4EJIuPZcTgMq+2KM7Jc7grvKesXBdhjp12Cq35WxKLw2b8nuvK9qn8zfmwjDzFY38UA4dUQM+5/7jyr1ZSQg1OPdiPWoYRfU+Ykw7o35j4UA2lb7bjP9XDlmNMRJNpZZSe+vGlGnFLWeF4OxvLgjHx+5WYBZIqCtqTjeij6JXRDePHVPURHpDzPehmk0evv4CdRqovkRSKS15CWFPAQZBP4/gBY1uWtbmRvtX/7VLqrM0m9bGDzdwAyFEHO7IoR9m+y6rhwX1vOJEQ9tc8ptTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzoO6djBneByJWcxHiPdw8NrH1+W7h/PJzuEt3Ci80M=;
 b=c4tHbCgWacxFjPeYNhFw2aOOYCZ7y5kAu43azmpqQ/7oM1zIVeSUaOw5lq/m4I7Gj8JU3gGXC1pwLw78EXek2RanN9sWzPd7tAmEi3ecRXq5mkYQ9FRJasTpcq0nKXzhlpgwRSDUP5h0wLUNSFJIMLl72iPxnfMeAnez/bGKZyQ1O+VpCyO+o7eWL9VV+hg8v8Vvi2Q+Ort78DdE4Je5ICXIkaOxmFvyON+vIhNeR8fka1QENFPIYyruPeAYBkUJJh6GBfW/r6CC+RqUwea8PdaWbbspHn2XUmV1u2OIWPAjx7CSwAJM7qqFhhnMs2bC5FCjGSrmIErjq4A6LFz8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzoO6djBneByJWcxHiPdw8NrH1+W7h/PJzuEt3Ci80M=;
 b=iLCFUTTQqxyIK5niZCKVqrHmx6EkBgeFAM6IQ0gy5f/8IV6ERKjGV1fjMNL+iZH8jWXG+tBVJwJxQdJmx5M55loKbomiGknrXcYQbEjpar1CQahUhzB9f8917UzUKCwve/N8spZ4CWbDBZXKwzCAJFI8t/YOgo4BBzWoLJ7A5B8JOKtzOssZi2DFrgyyZAa0ESkUeW54NeMCTJSgvj5AXymgum0YjFWKT3w5UYB8QPoSuLVRX3OPeDs5WvAoXAYI7ayLk0Kv1AYlyKMVgudg3Qtz7wMm03MA8xsHjsmT4RS5tbbCPKFMs96gMsQQaJOnDLL69YNvR6Qv+GzQTBx3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:09:45 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::c707:d96c:a864:28a2]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::c707:d96c:a864:28a2%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:09:44 +0000
Message-ID: <7caa7037-4145-274a-f91d-76d30a8397f1@nvidia.com>
Date:   Wed, 22 Mar 2023 17:09:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>
References: <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal> <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <ZBsKHBN2NIFA6/YD@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 334905a5-5e2c-4a88-d143-08db2ae77828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NNc9Ku0BPvKo8Vovw9r0lLx7VSpGQ3q8Wm1D54P8kwL/JZjVwJsmIy0Ph9lpoFh4mbvzohX26TZq8ugolDXgZqScWFrWIMncnKoBKX4emLauwJTMsVpTHTd+s0kKtJwFs4An0iuRDIhA797lUr/GaE/agUEQjVO07gvz74K5pv9fNCzXOZp/dib+ZBENemC8U6h8a58zaMJ8yjcH16vYk6U5rtx2HyxcwCN1K3jPX3v0YDwYsDPYf9dXawsARJHkML24xCd4F5D5CaQD5+nEZ7Vkmvr3ExIEHIDt0XeiRNIzaR62yovfbOusn1HHOcHMmgMTbx+HzDmn07YnFDnk20hk0CMfvveZiLaT0zl/CTKu7azXEmNaL2eHzG4EnSJrYNuYO9ockzDU2AmG2VsXnwK0Xg1w1asNzVBj9wPHjT7cMNCWfrJR3uWH31jxumuhhq0kHZX7JTcLIIaF8PU2ckxklaNwjYt3pyz0egoxvv9tlcyux8UZl51mmz57PRLXUOKSIki5nCzW465CMEaF/vZ6AGep9/uEHl5/bt4Lsz+wOux6Kdr3RXX+OqzSvWQ+suHqrsIwcDw+1UxAAD7OJBYDKCYCuIDl1TOrD/4AKf36hhE1HHgXN4ejaIlKyd+6WhL+sEl9jr7FQA3IJMdh1O+YqM+vYw7RN/lKEX07GYC3s+WgWQV9HoxZYhZrZRinBopL3qI98my6yBAx+NQADdwoAVW0EKecCSzXJRwFBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(6486002)(2906002)(83380400001)(31696002)(6512007)(6506007)(8936002)(4744005)(5660300002)(36756003)(53546011)(26005)(2616005)(41300700001)(186003)(86362001)(6666004)(316002)(54906003)(66556008)(110136005)(478600001)(66476007)(66946007)(4326008)(38100700002)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpNMmVsUmd0YTc3OUZ0bmF1S0hmL21UQ3pTWXUrOTFMRjJLUHFqTStLcVl1?=
 =?utf-8?B?Q09DNkRoWjgxR3g3dXJpQzAyN245KzNLYnZsdGl6OS9ZbTE1U09TOUw1NHFD?=
 =?utf-8?B?RGRPcUNJYk5vOGg5cEJKaTJGSFZ6WUdwd0Zsdy95SGhmSnRlQ2gyU3ZtbDRY?=
 =?utf-8?B?a0ZRWHVUQnlXbEd6TkxmYXY4K0xNc3M1ZFFJMXJDWnJleXp4dlg1Y0tGV2Ix?=
 =?utf-8?B?d3VNeS9za3dITGJEY2dNbVhUbGhoeHRTbzhueWtmb3plcnBUYi9RcFYzU2RV?=
 =?utf-8?B?a2pVbXR6Yzk0WDVVYVhuRXF1Tm5TMllXT3A4N1JrUVNOdkdKMEFnTGJ0VjVO?=
 =?utf-8?B?bTUzSllWNDlRUXBUV0dZQUZrQStERi9FQTAwQ1JhR284VC8wdHlGRDNqUUhN?=
 =?utf-8?B?bGdKSnNMNm80UHUzQjRIdGVMRHZrRFI1LzhNb1BvQWFSL2dYbGtvTTRnL0xh?=
 =?utf-8?B?dDh2SHh3RFVkTFRuZ2FMYm9tRlNMak1vejBPWnVCd2lHZER0dnkyUkNBUC8w?=
 =?utf-8?B?NFB4MGVPRVlrYXFnQmVvL2tuMi9OamlWYjllR0xQQVNOd0tJRUFwdTRIeHdC?=
 =?utf-8?B?b0tUS0I4Znp5R1ZwcWNoT1c1ZUhsTGRIVnB0Z3R0QlJmdkpHbDRUQSt0ai9j?=
 =?utf-8?B?YkRia1dYUXNUWldndSs5cjhFZ2w4UThlRHJIU0xJWGIyVXJhQzE5R2ZYM2hx?=
 =?utf-8?B?S1FaTU5FVTVqODQ0NWVUNkJrTW5wYU5nSlh3MjRqUWlRcGVwS2RaNjAxMlFH?=
 =?utf-8?B?WDcvQzVNVG9Wa0RmWERqb3JuUW5kTTNwNWdLY3VGaTBYK2tXa2xBMmxlKytz?=
 =?utf-8?B?NnZHVHVQZEhHbVRVWDE0MUowTDIwN2FkUFJRT3NrUHk1c1hISDhUOFNZZFds?=
 =?utf-8?B?S3lEWDZiWFE3L3F0WWxwT3B3dGxyTG9Ib1g1dHpNbHBxVGs0bk5MQmxSbmRm?=
 =?utf-8?B?WTZ5YXdTMHpBOFNlZm5Hc3ArZkQyeGl3WEVxcHlEZC9PSDZQaWM1THNCb29r?=
 =?utf-8?B?U2RualhvZndjaFdaVVl6ZDNmd1k1Z3RzYStaaVZPWVErS1Q1enlaOTZCcFVq?=
 =?utf-8?B?UkdSOXhKWlJHMlZ6NE80TnFkdXVTWHkvREdHMUtvSWFvcE50MWpNaWp2WllD?=
 =?utf-8?B?U1lLeVRPZkRVN1oyRzBMNHBmOHZRTEprMkhyRmpBZkRhbjVOTmRaRUFNclZh?=
 =?utf-8?B?RkswL1Y0NEVnYkxVVmNrdkRJTUZ1dFRxclNHNnk1OUNIZE9tb3pGZjRyYWVt?=
 =?utf-8?B?K0M0T1RwekE1Qm5CVGIyYVVMRnJOc3NSd1p0NWJ3SDl2MERCSDNYR1VaRkpW?=
 =?utf-8?B?dGFiWmdCUi9JOXhWUVlLOHY4S2dSQkYxOVZydCtNRCtUd0hCVUVkSzAxNm5q?=
 =?utf-8?B?Q2E3RmNuVzBLYWRpNGtMSUFBL0dWM0JxVll0UnFsRm50SGJYdmxRTm5SK0VR?=
 =?utf-8?B?OXEzWGdRY0VobHFBazFGeDJWTElrdjM1ajkrcVIwYm5HKzFJeEsveFcrYnRu?=
 =?utf-8?B?STJENTNjNEdjM29IRkd3K0UrWnk4VXhSNUx2Vm1PRStLMVd6RVRWMFJPUXZs?=
 =?utf-8?B?cGhnK1dwZWoyS3pOUjZ4ZGtyTDJoSkVtMTJkTkIva0lwOTlKVSsyRnJiMHRh?=
 =?utf-8?B?RlE5R2ZLajRVNXVFS2FHUWY1ajVQS0g4cXFJenl0OHQ3aksyaDYraFUvN1NP?=
 =?utf-8?B?aXoyaDdyaStyQUpiNE1IRTFEOXpqanNUT2w1dUxka0FGSzRrSnBTcUxUU1dQ?=
 =?utf-8?B?OTNxd0pnRVBvYUd2eE1JWHBrWjVRNnVKYk5mNXpoaUllYW1iZkdRajlPZG9J?=
 =?utf-8?B?QkV0OEsxd2VIZWtBQzdBYWVLK3JGRE56T3RTcFJKZFlFWk8zUXBKbmpOUnhh?=
 =?utf-8?B?aXZuSm9OaVlnTmtWOHhJUWNIMEFaeVpoVmQ1YjFrKytmSlB1UUg1SXBIWmpT?=
 =?utf-8?B?elAzQ2N5bnNoblRUZC9mdko3UWFoRzRkSzZSSHVzY0w2d251cksyZEdWVDdM?=
 =?utf-8?B?NzBwT0ZyaTBaK1l1WTZiWVRrcWEzT0ZXUUswUEJDV1ZaczcxaUMwclRmL3dr?=
 =?utf-8?B?ZStpbG1lL1Q2bU1sTThEaHErdG9IZzJweEJHUW9qYlB0cE5XVUhjVVAyaSsw?=
 =?utf-8?Q?ze8SDhOtsIcrAjeMs/7GXtymq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334905a5-5e2c-4a88-d143-08db2ae77828
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:09:44.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffaq5WOGVYIzHwmMyfchIMauXONBGoU0RxuZVL0XVc1DsI11IRkQOKhR5byt5Ax0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/03/2023 16:01, Jason Gunthorpe wrote:
>> It seems that EFA uses shared MMIO pages with hardware security assurance.
> 
> I'm not sure how EFA works, it writes this:
> 
>         EFA_SET(&db, EFA_IO_REGS_CQ_DB_CONSUMER_INDEX, cq->cc);
>         EFA_SET(&db, EFA_IO_REGS_CQ_DB_CMD_SN, cq->cmd_sn & 0x3);
>         EFA_SET(&db, EFA_IO_REGS_CQ_DB_ARM, arm);
> 
> But interestingly there is no CQN value, so I have no idea how it
> associates the doorbell register with the CQ to load the data into.
> 
> If it is using a DB register offset to learn the CQN then obviously it
> cannot share the same doorbell page (or associated CQNs) across verbs
> FD contexts, that would be a security bug. EFA folks?

The doorbell's BAR address is dictated by the device, and the CQN is
derived from the address. Each doorbell resides in a separate page,
there is no sharing of doorbells pages between different UARs.

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2585FDB6A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJMNsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJMNsk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 09:48:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14DD12FF9E
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 06:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGoA3QII2oNZFFeRX+WFkAdXoaN0UshP4r592MBx4UgwEkCvtpOuaK4IYu3OAzR1kDljDx5qpS2Ngwi9iBhWZIqfwI8o6IIdw3MjIxa0QChRhI9F8ABbyuNkNS2KfO6AuYlEnoBhDFHa0WoCvQFjz7ZZav1qdgWvTxZMWxscRmPK4B1g2UDe9XTPVpv7BUs9J/mX4IA8BQdtjd5CT1ACJaXLUtC2Vy/8iC0cCMMJssOFGsfcVxYz55PtuarYZ4h4l9oF1dSI+k4qz/tKX8cvA4RRg0/TtKKoQ8CIC7ktrpdO7vzspX9LH6YzPg+JHXIezYoOCN0MVw3lXDCsjPxm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix29P5wkCu4I4C1hIBtoNWphl9w+XrnLfrJwdpVOLfw=;
 b=LF7jBNM4lm71l356Iy0WI8WXbTrTi6wa7PfFmNEwjU2PjQ/3qqEMjq0Tvah7QutI0n/vfB3yTc1kcPbWptp8Hje5JFixRaHo0cY0ltC0UNCpFSxvilP5xEerH3Jd+nXwFpZMZIvkdazMwokjkSaqXQs5eR8bhMSb+HDJzFb4/f8+2PNdui5Kl9FRNd7c2ftvDH1MlRj6AYoMB1CbnVhLdzgs1hxq6pEr29+7zMeO4t2abR8kGf1eE+E1msxTjJ7tC2W4qs01duUpUFUBVzp1pOQrdJo6JWuXouWld78dvhSMTfKKq8amT9+nbNdYIJZc26gtR7p68bu/OP3TkHTztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix29P5wkCu4I4C1hIBtoNWphl9w+XrnLfrJwdpVOLfw=;
 b=OHsRRUaa0e+7H+x+Wl+3nLVwmNNB0w/WK9eLktE53LL1giAQOoZeRM8nyRs6vBQ8aCcFr5taS6ht8lspW89OiTDU+p2i4leVnJyUPcQGLySMtqWzLxWAwogMw4e0GjoNUcgDMRIkAjO9t8CtaxuTOmRz0/p7XDH1TH6XXlbPvLhJCa+jcwj29kNPrY/iILGAvdcBIIrFT4FQSaybdP+mE4qu9mtB3KgHFAizzI7niRIJEXzJh76io9k7u5yJlsufz5Mc7bDBOk3WahCaMUZu9lMXXgqtKn6xNoRZwHqEbsCoG+qRck9l6q3RwbnKCQ3XFK1DuUepbhuZQstfc1W+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 PH0PR01MB6681.prod.exchangelabs.com (2603:10b6:510:99::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Thu, 13 Oct 2022 13:48:32 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com ([fe80::1b2:f2e5:3b8:77d3])
 by BN6PR01MB2610.prod.exchangelabs.com ([fe80::1b2:f2e5:3b8:77d3%11]) with
 mapi id 15.20.5709.015; Thu, 13 Oct 2022 13:48:31 +0000
Message-ID: <b2274301-bf82-f3cf-20ff-0fc19b2014fd@cornelisnetworks.com>
Date:   Thu, 13 Oct 2022 09:48:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: FIXME in hfi1/user_exp_rcv.c
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
References: <c56dbce1-7d63-df20-fd2c-577ca103d8de@cornelisnetworks.com>
 <Y0gQwwaHGq2Uj5f/@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y0gQwwaHGq2Uj5f/@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::13) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|PH0PR01MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf15c71-0c8a-4232-3a64-08daad219d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2daertmbiir23C0ATAIPEpRI9c/TnO6NE0h55CyiB/BLiavwhAJKOu2HBFfjdeewlsAvEU8oUVxkdYiB+dRF5kB4H7qcPW+N2SzLTyPnZNb3e06fbVX7+vy6b1cWO+RMtczr1+Ax/kCoUybR6BxghyNQPAu2gbHS1zqjj4hFDMEH7wj6ep4uZ2VIzC1lfb/OlgV+1yHUiQQDGcCLWeTh3VEl+VpfluQOeV0PDxvrsADZehLLUYFLR9/jfHM+ONdYMcR0o7xdsdFllvyLc40zThUTIj25hVVPSMh7+8CLjUwiZB/iurGJx8I9TcdH9Uduf6SatLGabgJk1pV4HU41Wvz2mxK6/eSXgDNTgBV0zXwlv6bPGF8xtyDVS8xQj6UHsn8tq2syrRdG2iDGJr2c7j9v8A1YcbIOpQKtinTER5RDfunB4N2iDujUf7eInPG1u+BkyeQ9VJgC5qQTbwr/Ip8S8AuDUDPllHX0FLUSSlGHF/uH1GgP059hvQK5xIOtp7iCiu4S1oYLBE+EymaDlYep/Uj9wU90SJ64EEm9DH2sKZksmnc2siadoWS4hlWUHskvVeL39Td48C2STVUaRiQYgxJdr2zJu8gnWPHo//6RaEsn+6x8jDbh5sMlaUL3/9ZKTZcwa14ySSk5CpEYi/ANzsXeL4IvnFp6hOR3xOuMWJv2s7TrWK+PYYjvZwSPJn+gtS2sYGYIYkFTTua8GZnq++i3Nv8Dw5u743HuoLDqYb1vgmeruLMaTPdWUfkv76fwuBj09LlRwTzKHNsoWK8TIK88Ooh2t6PZV303cTnAGEhqWa0ajtk/X03WbloJFxIICjeMbUbNNqP0mYuJ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39840400004)(376002)(366004)(396003)(451199015)(2616005)(186003)(83380400001)(31696002)(86362001)(38350700002)(38100700002)(4744005)(44832011)(5660300002)(2906002)(41300700001)(4326008)(8936002)(8676002)(478600001)(6636002)(6512007)(26005)(6506007)(52116002)(6486002)(53546011)(316002)(66476007)(66556008)(66946007)(966005)(110136005)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5zR2x1eXQvMGREamtjL1NqNkwralIyT1ZDK0RYYmpLbEZmZWJhRzVhRjJr?=
 =?utf-8?B?Vk1vTnZ2SHU0YTR0aWhrWTRIZFdDMjZRZWFNNXg0aHZNS29rM2k4QjJOdUR1?=
 =?utf-8?B?a09Pd2xqanVaMVA3a2xIVXBPbC8yUlFScEZEdHMvR2VYZjU4bTNMMVRGTjJl?=
 =?utf-8?B?cFE3enpRazVZRGFXNWpRdW9JVTBGZkEyekZ2VmdOcDdoRSs0Ymk5WFVzc3Zu?=
 =?utf-8?B?ZmRYbWVIQThKazY0am0xeW9sYmNyTDdqdXNid215WE94MEZOWGNhZkdWbFNq?=
 =?utf-8?B?cGVlZ1NZT1Z4VEtHeFdrTnV2T1YxNllOYXVYaWkyMk5DbVFCRUdMUUo3S0x4?=
 =?utf-8?B?aUQxU1kxR0owcDRtQm9ndEd6eDRqcE1uK2dXSDRxcGlPaTlCVWdUemRKQzBr?=
 =?utf-8?B?aVVCOHd3cU52TC9WNjlDVnNUUnNkR0gzT3NNallRRnphbGFPQjQvRE91MTk3?=
 =?utf-8?B?VjRJZ0VPU1ZnNTkwSWhhbVNZQ3JGaXNJallLMENHS3hoWWl2QUhrQVF4ZCtw?=
 =?utf-8?B?ZHZUMjUwOHFrZ0E1YmU2RTE5eDFLSkxWRkNKYW1Wemx5aTVCNFlZU2FoQVUv?=
 =?utf-8?B?Q0hhcURwSG5XVk0rOEZlSDVHS1hJRXJrKzVTME5Yam5DSzdoNUY4aCsxVVds?=
 =?utf-8?B?dWJROEZlRUdCaXZXekRzQ3AvTXV2bE9UY3piTm9xNzBKSnpnWWxlMGM0Y0JN?=
 =?utf-8?B?RDB3dWlyNVNzQXJBNW9DbkRHTE56OEsxTS9oU3VVcXdWTE5mQUx6d2dvUG1S?=
 =?utf-8?B?V01oWmVuaXd2VU5wU0YzcnBlbjFRd3oxemdsU3lucVFjbnVSaUI4bGpNOW83?=
 =?utf-8?B?YWVMQnlRTlM4M0hmY2dlU3NNVCt3UkVZNlg3bW16czhLUW1FNkpMbEtaQm40?=
 =?utf-8?B?T093Q3ZUakRDd1Z2Q0VRbXcxOHhEb2cwRkZpaFZQZWZ3cHFDYXNpbzdEVHlQ?=
 =?utf-8?B?MHgzV2U4SDJRZktaN3F2MXdKNEVQREdFbkxMWEM5b29JY2s5elNzWTRQY0Zn?=
 =?utf-8?B?U1NhVjQzUXA5L2JFTGJTNkw5YTVKSzNVODBqSitrVS85L3dSRC92T3JBdGZD?=
 =?utf-8?B?YzNDWURKMGxRU0Uyd2JFN05BSzBibm1CRFEzek95bUdnd0pVcjN6bG5lSExu?=
 =?utf-8?B?Ynh2YXRtSTZNMDF3UUZ1SEd5YWRQYlNCbTJBTFB2UTcrZnJlNkg4ZGl5b2kx?=
 =?utf-8?B?TDVBc09xMitMUlNNSStlTXhvTDRQd1BMaVd3VW1HLzQ4NUtjSzlERHNXUDBu?=
 =?utf-8?B?ZnlRU0hieTZGeHVEOEV4ZUZYOU9SSGl4a3hNSHRZMzh1TDhXRjhZZno1alI0?=
 =?utf-8?B?Mnk4dW1OM0NNLzZTcm54UjgyL2dmUTA2cnpKMmMweDVSTFRpQi9KZ3RxY0tw?=
 =?utf-8?B?M1RNNmJQRTdrZWZ1QVlGT3BmTVc4RWR1akYvV2lHMUh1K2V0Y3pQVFVCaTZh?=
 =?utf-8?B?Z3JHem5CVkZXKzJHT3crYzNhMkwyVzRFRTZ0WFlLM3FYRHgyZTM4eGRmM0dN?=
 =?utf-8?B?THhNaVRuSG1XdGI4ZEp5cytWeFRBUlVzTmhvS2tEcTFJQVlWNE9odGM5Ryt3?=
 =?utf-8?B?YndteW1Wd0ZLbUxhMUd5OXZ2dEZua0tHL0UveUtPR3Z3YS8yR0s3N2p3NS9I?=
 =?utf-8?B?N3czYTNibHRkWGFPemQvU1dQQ0ZBL082VUhlWk9iQ2JJR1VOSEY2dHNWVTlR?=
 =?utf-8?B?UkFQNk0wYTZjeDZZTEc3VElZYUFDUkhjQjZzcHJqYjNtV0dLeFYvaTlHeW5L?=
 =?utf-8?B?cjQzdWdUcWpyZEJwVk5LdmJEMGZiTndqU0JsQUFPMkU2TStTVmh5YmZubjVz?=
 =?utf-8?B?UjFITHFhU0VFVTBhMUZtSU52N1F4ZHZlTGVFMmh2MWJwNkNiSmJ4RzZwWEFH?=
 =?utf-8?B?T2RqYWh4RThvTE5oM1hRQS85UEc3d0puUHUweFpSM2RJSC8rdnBTOENUMEN5?=
 =?utf-8?B?SlZwUzg5eHQ3c3Y1Q2xiOC9qNXRwMzl0Z1Q0QTIxczBMTEFGUUtMTDArNklY?=
 =?utf-8?B?MWl5UmJPeGxNUTAxWCthTlpUelJVRlcvUUF0MkhyQ0dvRWRpajQrdnBlSlBk?=
 =?utf-8?B?ZG15NURhdXU3RVFLNmNOd2MxNmFjVFJWbGsvQVdJU0Y4cmxqYm42c0p6K1hx?=
 =?utf-8?B?WlB6WW05V3JDMUpnaHpVK0ZGMUJwUTl1NlU1WnlWUktrbFREL1NlQmJUNU4y?=
 =?utf-8?Q?GM6p/5X9gwyFWDHjDjT6/EY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf15c71-0c8a-4232-3a64-08daad219d76
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:48:31.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XqCoIyHIgiJZEKu3Kmlu0D9gwGCFeVwLjlGwhZVyq0IFUSnjwMZDC50l3DvkD3FdZJVmJw5RoqvTEsOkq05bAPxIERRdq1BCjvb82krtgIRk9Ti321FdxXe6Uv+fw6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6681
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/22 9:21 AM, Jason Gunthorpe wrote:
> On Thu, Oct 13, 2022 at 07:59:52AM -0500, Dean Luick wrote:
>> Hi Jason,
>>
>> I am looking at the FIXME you left in hfi1/user_exp_rcv.c with git commit 3889551db212
>>
>> Link: https://lore.kernel.org/r/20191112202231.3856-7-jgg@ziepe.ca
>>
>> Can you please explain in more detail what made you add the FIXME and what may be "racy"?
> 
> The comment seems self explanatory, the ordering is upposed to have
> mmu_interval_read_begin() done before the page tables are read, not
> after - since we already have a page list at this point it can't be
> right.

Is the race you are worried about here when a user proc tries to free the memory
before we get done handling the IOCTL to set up the recvs?

-Denny

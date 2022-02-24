Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749124C2D4E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiBXNjB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiBXNjA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:39:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC0192E25;
        Thu, 24 Feb 2022 05:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWoT03PR7f7U7uVr7H2g5baOrN9bTnMMDQCltGWn8wHsebXjOqMmEWQ8tBzlol7KPLId5iVp+GeyptmOy3u27MpF9LxiIbgdvT/xSYNfYlxeDsvp/PbvQ+BN+XxSJ0fjpAy8U3Gn2ZZs3CNc2H5xMXS7wfgzG7ait4cWSSUlPu6+tBHXx+rG1FMMP36EaVa9Ow53DUbPDwwbF3EyVlY0+0LPaTsCQXtPPuBntmiDJMAZk5K2Q4Gyt6XOODf8A6FlewdtVQMUmanQdiji2uS2iRjkFLadBsxf3DqKZxRZ/EJ9UEOoOV177M3dMThN81iIxVKm/HG/zMvvH+B9aqVdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BZC8xvUHnirJXrSKvYAgPMjEl+CyjHKccWWIv0ghSg=;
 b=mWMJEAaMMuUsuhQ/tVkBdK2Ofdl+AuIsq9luwqYNVkn72Pb/2uXIfnXZCjKnHyRiwU+XlUMP48ue2haiwnHPv7Ut0zBBzisQ9Z50rc9QUhWbVfrJSR4i+vAjBUWjxmCOplcoATi+MZBPiM3oWkdBZR25rCbmR8+8sQKxmau9+niZcglmvdxLSmDYNSsjOIHZpK9ndBSRM0bYpgcSHvBFhrbceOCD/8KsQajVlyxy7Na8fMUPMl6bXPdyK376OIEPGF7blqFat10D3Nai2PDhLx/i+uTAJ9pYDDRbFnZeOTuC1PyRPGs7Ux2PE5IcmnN0eAzkbi6fxxZ/KPCyHQomaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BZC8xvUHnirJXrSKvYAgPMjEl+CyjHKccWWIv0ghSg=;
 b=FrQWapBle8rNGuWETfzL5Gxr0xoZutIdhUCGE7POjPFcHvOW5VXf8ZQYo6zIH+Ya5e5U4jbIIUl7AaFAqF/8i7aj0YJl9pZWd6/7Fhaeq5xYn6sO5J9BfRwmb35lRZvtDHkCqcOiq/hxPoBYTE+C3u1PldKgK95JpeEDSVu/WAIFWSCkrmJ8Edod2A+ySRKvbba6zbPZPgXYpCAMc7nzf2FSIqLYecJSbhvNC3GkUgrhMIru+2BOp0XYylJMzirv6EXDCBoujq52tR9fL3ddkol0XuoAIm19VZIjuFohBfk7FALwU3nnv07K2EcPVB3QnVHuEfy99k3rBh4jno5BSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BN7PR01MB3778.prod.exchangelabs.com (2603:10b6:406:88::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Thu, 24 Feb 2022 13:38:28 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa%7]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:38:28 +0000
Message-ID: <646319a0-4297-edcc-db82-e4f3670cc84c@cornelisnetworks.com>
Date:   Thu, 24 Feb 2022 08:38:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
 <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49ee834a-a786-4928-94cd-08d9f79af07b
X-MS-TrafficTypeDiagnostic: BN7PR01MB3778:EE_
X-Microsoft-Antispam-PRVS: <BN7PR01MB3778B8486CAF68DDD3B363EFF43D9@BN7PR01MB3778.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e+jVJR3pzGjQU5Jy/y22Q79EAo9Wto44w//xwZM8l0yeby4euj/45KX4bAQiOxgd4HaH5AByT/wbNgJPH4sNJ5JKQNWYLYK1jZ4cUwhyapysJ3c6IZWUBg0ExAHEB8r6nc0m2rh6zypu1afBQG01rGLVVqVZIg1uN3m3oQHRcfDIdVqPyQnBeDE/fIXfXk0CpplJ5YwG4HID4Rv3rOO1hp1pKUvvGTBIx1EHHqWAwJ3WuvLgfEvANqTXxUjSxB4nJDvYY3bTNoJmFHIfA4eC84gkBn+linxjBs+d7G4JQZA5fpgqUBMkZ2ou17TElz2rS6q0KBY7eGq9VMqVMudKOmUhqhg5lpqFhTIm5XeDGD3Rd8O6b5+MbBKqfKX7kyhpmKgWW6IMuzNw3tu4zwuKvM5ukkK9KXTUPgY2MQ90Nxa75o2ROEe+1spg7xaWnxO4UNYtbinVs68TRJFLEntdXEub+C3xQQyyq9TLfPSG1rEZ36zm0NqqWQ8Ik/qTI9/odKsit9yu9b4QhV4pXE30yc3BC7uOZ1Nv6aBBuqUn2D5RfKjDlRwxFXuLclkJfLBQqiMPMQxNPZ2/u1TIQUoeTCWppFR9ukCSgJQDEAzUxUkA3A2vzsOx5Hca9OdJNvKWiAvQ1aTU7Zn/Jc4XcwXTFEfEO62L9t8Uj+bUIY4xX2dm/XyzbPuXiQaMHuSxbeXNAVK8Nz2NmQAx798PfTxF9DDXMmPsw3+Zbs+fvInXT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(346002)(376002)(366004)(39840400004)(396003)(2906002)(36756003)(86362001)(6512007)(5660300002)(44832011)(31696002)(31686004)(4744005)(110136005)(38350700002)(38100700002)(8936002)(66946007)(66556008)(66476007)(4326008)(316002)(508600001)(6486002)(8676002)(53546011)(52116002)(6506007)(186003)(26005)(107886003)(6666004)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxaamoxekUyYTNmaFRNSFJVbHYyYkpsazNEcUhmUlE2SkFBMlY2SlQ5VDJq?=
 =?utf-8?B?enhteWZRQ3ZpaEJqVzIrWTA2MmtHV3lzQkdwaXFqaWVLYkRaNWMweFVTenlj?=
 =?utf-8?B?S2FlbCswb1lSZkUvNFdnbjdXbThBTVVDQ2o1T0RTVFRjM0xqQzBVQWt6UzhY?=
 =?utf-8?B?bERDbUxITHJraGNObXZsSXhFK25mMXZXVDFLL2FtS21yZmhqOWhiZUJlYjRM?=
 =?utf-8?B?bDZWb2xHNXY1aTYvZEgzOCsrUGoxT1RoZHpLZzFwTGZsUzlqci9aWXZad2dM?=
 =?utf-8?B?eTNuNEtYUU1hZDVPL3l4ZnNiU0M5VE9QRms2dUVmRVhxa01hdXl6ckxTVWxM?=
 =?utf-8?B?bC9Ma0hSSmtDOFdJUDJvWGFOMWR0N09KdjB3MnVVd2VqWUMwclRRelZhL1ht?=
 =?utf-8?B?T1NIYllnNVF0ZzdHTlpncWo5QmZPRmIrL00vWEhoMi9KQytLaXZoRER4Ulg2?=
 =?utf-8?B?WkxLd2M3ZmczdjdYRWE4eDU2Nk5DaGk4UWM4aWphc2RuVHJwWlhZVjYrYjN2?=
 =?utf-8?B?dENJLzNZVGVPUHhINXQ0YU9JMGxldTh2WXFHWUFIMUcrN2pucytHUlg5U2ln?=
 =?utf-8?B?N3dNTEM3bXNReVRoejk0YWtGMGY0MHFBaTVRREJSRUczd2s3K3llTWpBVGFI?=
 =?utf-8?B?a1RMQXNpUytMWmtjV25RNWQ4TEpBZ2xzRjRzYWxKa3cvdTdkcWZyOHcySEVW?=
 =?utf-8?B?SzBrQWZ5K1p2MUJjMG5hUy8yU2s5N3Y4M1YxMWZqcGhvTisxcldyeUpqNGNY?=
 =?utf-8?B?NlR4Z1V4NHBFSzQ2S2J5SGZiRmt4T1d4d0M5d002N0lwWVJ3YnBvSlNrMW0v?=
 =?utf-8?B?TnVYZW5wWnZ6ZTJudi9rdnF0Q21qK0U4enVmNWdHTGtsRlZ1TzNXZ3lwVFIr?=
 =?utf-8?B?ZFlhOExtcTVNMng1dGdYaWRCc3RYbTFJeGFCa0dOVDhTc2M4YTQrNnUwRWpI?=
 =?utf-8?B?Z3pyZDFaNGNjM3dFeHBSZVV1L3o2cHhSdUl4ampWeXBUVGZxZjJpSFllSzJi?=
 =?utf-8?B?VVZwU0ozdnVnUUZnQ3IvQlN5YVN1SW9KalNuQWVhUlJsKzVBcHd4d0dxN2Er?=
 =?utf-8?B?bTJ2dld3VTNEeHlhMW1hTW1sOCt2ODQ4bklDRTNKL3NRZVBkRVFoNVdrOVFj?=
 =?utf-8?B?bForR3J6RGYxVnhYRk5rTkJmdlZiay9lZFVzVlpyMUY0c3krTXBDZndwLzJS?=
 =?utf-8?B?dUxzZ2V2NGE1VVZaYmZHcW5HZjVMK2M5SXNHZHp6T1l1aGM1MnlSMVNMdm5V?=
 =?utf-8?B?TUdjZ0xUSkFob2dpTnhpWC9ob3E1QnMydWJJbEFHR1JjRjdFM0ZQMzJ1SXpV?=
 =?utf-8?B?TlJ6ZU9wOGcvK3JJbFVmbzdJLzhEck1HdHJrMGVmSW4xSDJCTk12T1cyYk1F?=
 =?utf-8?B?UGlyM2ZMa293dW9OY3NsUjVBU2toYXB2dnZKbVFWT2NYa05ybXJGUUxaZC96?=
 =?utf-8?B?dXNkd3c2c252LzVYSWRONDN2bDJQam9YTHBJb3ZOTERvMTEzejFHNmRYbUZY?=
 =?utf-8?B?YXlSN0FyYnVlaHJwOVlxeDFXcjVoNy9mZ2lVa05UczhveVFKeTVoUXJudmQ4?=
 =?utf-8?B?UTRQanMvQUJuZyttclErdVF1VHU2QzEzeDh4S3owYmp6T2VWN3JUdkZ2VUVn?=
 =?utf-8?B?eDRjc1pBbmFVbEpETzFFT2ZEVHIwSDVsejZGYy9JT3JDZUZBT2R3OVdMeWF6?=
 =?utf-8?B?UTdnc0NBKzJzbkllbHhUMkR2NldOVTJwOXJZMzNHN2g2RE8vd1lrVEJhQ3Q3?=
 =?utf-8?B?NG0xbFZickY0N1FIMkpFYTVCemliUlZiTUhrUThQUkhsOHUwMFRUczlHQUto?=
 =?utf-8?B?cWJqbEVTWVdMYmh3QWdPOEIwOE96Tk0vbGVvM1FIQzlrWHdEbUlVbWlMbzEz?=
 =?utf-8?B?ZVRrR1VBbnduam1JRmUxUm1wZW40clFhaHlTNUkzWCt5K3JjNFg0UXA0Qitk?=
 =?utf-8?B?WG5sSGJUQ3FXa2YrbGhhVlY4am9aSFQxWjFMdTlBNXF6MFpuZ283a1dDaFY3?=
 =?utf-8?B?ZE9tc2xQc0xDNUwzT3dVdXkvbjE5a2lIMXBpQjJjeVpaRWhWelFpN0FZMjdF?=
 =?utf-8?B?L2lEV2FaSGxMaUJuaE0wVTNNTGl4N0M4ck1ubGJrRGxEdS81SFpOS3VPWE4y?=
 =?utf-8?B?Sys2Z2p4SGVxa2VkSTNZZE91Y0xwblZMRllOblBuamFMZGtQT1hWOEpTcFZS?=
 =?utf-8?B?M0g1c1NBbXZkWUYzYm1BcVczM1pQQWNzRm01cXlQS2JKVmFJS2syN2JqdVZ6?=
 =?utf-8?B?eGFVbUhBaXhYVzV0UExrb05nWGFCZCtRSE9TYmVhWXZ4aHVYNG9ScmcxcW1L?=
 =?utf-8?B?VHpaN0Q4SzhXUGRGYm51NDFTNW1TQ0diZ0o4OGZTK2VzVlVPcnJSQT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ee834a-a786-4928-94cd-08d9f79af07b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:38:28.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDu58uAXMOcQnkRRSH04hgKztVhk0x6YkGypylKbhwJpXVbpLo+SPMF6e3YT6nUZvXe3bVKVDrbH/Ls2Pith3T4150VRvTWU7whPbOASFu9FJt3OiONEy/VUATP6d6B9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3778
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/23/22 4:44 PM, David Laight wrote:
> From: Andy Shevchenko
>> Sent: 23 February 2022 18:54
>>
>> While in this particular case it would not be a (critical) issue,
>> the pattern itself is bad and error prone in case somebody blindly
>> copies to their code.
> 
> It is horribly wrong on BE systems.

Note that this driver has in Kconfig: depends on X86_64.
However it's a good point about not wanting anyone to blindly copy.

-Denny

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120844D1823
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 13:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiCHMod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 07:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiCHMoc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 07:44:32 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADCD3C487
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 04:43:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByZvw8qwXHntFQafa+sg10YpuePgBH58kiiXiiWiixTXevOS2kNEm2J9kpsQyQCBrW0IYSnlea0VFMYy+Fn9y8m9xB1rviQUd17h1fXDfX/ylnlehz04ZUl4MREoAbbs36SKiHZiV+datbdTkLiHQ5GTetJgJpc2SsFUsF99gYPYCYyNcbFH00qy5hFtGTMt3NROG7k2wAMp5AZo/IusuVoySTZdcH8IYGvYYR8KN53MX2jvh8dQ8Y5zDHbmx6WWe7QfXiepVOJOY7bDpX6Kww71t1uh49p49txbymTRnqcqSJe/JqTlE3UuCVbORwwUaxEA7kevTTfvrWF2hnaniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS+SlrDkVPLhf6AitTLD3VcMqvowmYdd88G5nOBx0xw=;
 b=ATBgjjGgQ2PZ9wdn5VDPFsO0WhVPLcfHcX9uwCk9qO3J+HPVdatTRWj9qprjZR33GW8iJFwLpnSnjeeYFcMK9RfIot666OYkq1GG2own4w2q7VlcjhXNtCPd7FjDXdM6PbuQ8YBgn1HmmvNEo77NEzuO31LEWIDKFbR/gqx8DnEOrM1RaS2BDXaW2C+EoM95l6oWrwZIECj7m6tqpGPkJ+/3PF0GduHVDi4mdgvjl/S6hc/z8mvoov0S5hNGLbCqru3x+3RA5xwrwMGSrivXQWknEU9kEvm+n3UbRICtk4DCX4kQGm8yyuBEZq2aGPuZ4DWzVw1SSqnBf5F7TWX6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS+SlrDkVPLhf6AitTLD3VcMqvowmYdd88G5nOBx0xw=;
 b=p723XUENMyhf/gTCMUoTaAKWdrBXdM2adwLXWg59LKBLsafEi6ZGQniSBUlzk2s8depsiX+R27ChkCY/bwJXdN6Hehix1nl7WZfYMQ0SOUxcTtA7pcZznsn6r1Bo9nZ3m/6+8+QLDy0zSfIPpwLSHoDsQMfghiFPjboXpdWS4UQ1H+SZwMW5B4ulkypqnwCfCC5MUmyy8icV6nI70JhytsDHdOLyGJiyfRLw2b/6bov1r8ZlD+ACCJd/72Z32yduZ0NGH9psI/bb6Fxo/Ems0eghX8oIjT2B/W0gqg1DUcSfw88WgGRs0oEgY5VKlRQKFZnhuBAXnjNllVPUhx3vOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 12:43:33 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 12:43:33 +0000
Message-ID: <4e6e1640-92be-20a3-758a-9f069146de0d@nvidia.com>
Date:   Tue, 8 Mar 2022 20:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] Is address format "gid" supported by RDMACM with RoCE?
Content-Language: en-US
To:     Sylvain Didelot <didelot.sylvain@gmail.com>
Cc:     linux-rdma@vger.kernel.org
References: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
 <b612cd5a-b3ad-c8fb-cb01-32aeafbb9e7a@nvidia.com>
 <CAOrWFD_6dwzfjRJg7fh20B8K7_vbw7xQ+Lg7cGsAPwcOcevyoQ@mail.gmail.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <CAOrWFD_6dwzfjRJg7fh20B8K7_vbw7xQ+Lg7cGsAPwcOcevyoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f262530-3384-4517-badd-08da0101417f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4367F47AB2FCC4E517D57586C7099@SA0PR12MB4367.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hSj3z9Y8RksYWPGnNR2jJ7g2K9ODQQ1viCipgM3nxEuOyIG8kBX0OcKFyvwVF4+NPo26nDttWGNNg33FSG7VPTQry+qIw3tzjtz8Lnqlx/QDZ0f76fZK2O7LTQJUoaje1ONpwboab7eW8dC3n1zzuOZd2/BGItMp+i+2MxyRu1rkUcw7VJ4DdgNstYlf1ZU8O6ht/WhLj0ECquNiyzoZ5diM0fVrX8gbSwo0Gk9UZ5iq5vA3YF8TVu/b15GSU4ipb89viD+rP+uDp4NEtOPm0nfv4bqpv/66yLq4/iWXQfuZQV8rf/DTZF7y3f9M9ruWlMj8WUj54oTcImLJchuQO0YS4ZgMtKpSYugyIBL1Ke+Wp5H4eAUXFLcKIWEnGn5D4EKl9UBLrkXUiS1ViZRtwG8t3+iXWAeAd9ovCuzwVx/l8NXGfoveVDiqaWGgXwj+Ye1ZHE+DFWfO8B+aA1EnSj9D5G7kWJik/NxocGuP4c1QRhqOh3t9NoYj+VDgkLHWK21wh80NrvvAkIEygvrNAUgqZDfPE7gTtbEU9A9k6CReFMcy9c3jKmydhwsAARhOaEwBUhaRgbFxmzM0PVcpDqk7q4PPLJFdvpYk6dbZ9LLIQeMHxCUe57wpU7M/4UFmtJmnLGt40dNXEz/qgMxea9I123yv65AmvXHgeE5zSDPofZ1VJfgWXlVncxsUgU8X0+XUuoFpRyLbOzXRnZsgnBd108FxhAPB5dWQe07uASc4umE3zdX6mQL9Ge237Vb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(31686004)(8676002)(4326008)(66556008)(66476007)(86362001)(66946007)(8936002)(6916009)(6506007)(316002)(36756003)(2906002)(38100700002)(186003)(2616005)(31696002)(26005)(53546011)(6512007)(6486002)(6666004)(508600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlYL2NzWlg3NkJVZnJPb2lPd0JiVkhoZThrZDBoOXVpWE92S3JrWWlIVG8y?=
 =?utf-8?B?N2NpVlUwMU54TzY0VGdkY282UHJYTTg3bllza096aFZDZTVFSmZlODlSNkNR?=
 =?utf-8?B?UzI1OXFvcktrUlc4QThOMmNjWG9tczc5OEVxK2pwa0JVSHBuellGWnpNcVM0?=
 =?utf-8?B?a3NKWEpOYi9yWHE4VE9iVnM4bnNQVDNSOWpqb0hIUHBTQlM3Tk9XMnZ4dXlE?=
 =?utf-8?B?QU51R2U5TnpnR1cvSk5pRWJ4Y2pLZGlWM1NLNC80MVFRdzgvdEhSb0VUbHBH?=
 =?utf-8?B?NjNYMGwrbDh2Vkwyd3cwd24rZ0p2Y3hMcFFBWi9RaXNJd0JzU1JOSkJpb3dH?=
 =?utf-8?B?TzJDOXY1b1ZrbU9KTWh0bmx3QjZUN3NMbDhLeGhQSXRycGwwSjI5Q05wWTM5?=
 =?utf-8?B?aHZobFQ4aDd5UmRGaWpyekY5YjRIRkRDV2dRa01zTWNYOEtCaW84ZFVMTDky?=
 =?utf-8?B?QUhvYzBZUmNRYmtnaWpScWUyaVprci9KVUQ2dTB0cmx6YWRyck5TQ2dkRXhR?=
 =?utf-8?B?U3k3R0s3TTQyVDJrUG5LRkUwN3p1UEdCd2VUWjNyUXVtMms4ME12ZVpaK0pF?=
 =?utf-8?B?YmZNNXhmM1RsTjJIQ2hPYmlpK3JodjRUWUo5OE5LVmlkNklSZ09jdzA2THhZ?=
 =?utf-8?B?TlVjOWlEZzNDSUxMVkhBWTVHVjBtdmZFS2JlOWo2S1VXQ1FrTFpVRnpSTlZi?=
 =?utf-8?B?OUlOajZGd3B4clo5OVhjQVd3K2NmNG9tOUh0Wm1XUlRoUCt3ZmdoaHNMc0p3?=
 =?utf-8?B?UzY0TUFsaklqL01KakFhYTNHdjVEMHZ6dHZRazNnY1M4OXpsaGhmWUswcldi?=
 =?utf-8?B?N0ZjNStXeEQyM3dVMFlNL0cwYWdxc0N2MHRZbHBpT0V4dFVXTE5ubGRhTzNm?=
 =?utf-8?B?T0ovcG5CSVlKTi96S1JaS1NjbmpZVnh5M1dnYjI0b3hRMlQ1VG5WSGVaUjcr?=
 =?utf-8?B?WTNEdnVKMS95V0NxanF2WW9ZUmdpUDkyQkJJR3FRak9uL3dQWTN0Z3J1cnQz?=
 =?utf-8?B?RjA0TFNSODdwWmlFcDI5ZmpTODI4aUZyTk9kaDJ5L2pFajg4aXRxK3RzVlRo?=
 =?utf-8?B?eU9WOTVRNEN1eUlGN1E3M0xSMmFiakxkTVBJU0d5UFlJOERXc3IvK0N6eStz?=
 =?utf-8?B?aE9FOXR4ai9Rb0htWWd3NzJmQXdWVlZYUTZlRjd5RFNLK1VkMU1MdlpZY2xs?=
 =?utf-8?B?SGFYOVY3dHE4dUc2OUtlN1IxMS9qcXdTU0hCdU1WZlV4enNiYkhEWmdSeEQ4?=
 =?utf-8?B?VHpHQ1dNNHE2b2hUNFY4SmNYTTJYRlJxWGxLbi9FS2RHcnFHcGtrSFpWdm9t?=
 =?utf-8?B?TFB5NWVoZGNpQVJ5UzlabXBMTGRsVldYNW93Yld5V3FLY0laVUk5QVVmS2Y4?=
 =?utf-8?B?SktFS1V2Q0tCdkJCc3FCMkpMK1RmdG9kNTREMWxyN29sKzF2VlZxZjZUQm5x?=
 =?utf-8?B?SWNSV1UvV0RyaWRXKzlLS0k2N1dzcytkU0Y0a0cwbStkUEVRU2x1KzFUT2g0?=
 =?utf-8?B?bmI1SDFZZ1Z3R3g5Z0NGYWlJdjAvcVlUakZmWC9IVm1pbHk1Smh1RCtCWnc4?=
 =?utf-8?B?Yzdib2xWR085ZnQ2T2FLNnRFUVc5amVLZElhVC9OcEZST1E2Q053LytVUTBF?=
 =?utf-8?B?SkRyVU9qNFBkSmJFYXFEQ1EvNlFlTUdHdHl1eHk1QzZDVkhQUnVzQVFQZWZk?=
 =?utf-8?B?RVZVOFBoSkFpZjBNNFRQRi8wR2kxRlRrckNWVWZZYytrSzJJTkxoTFV5NEQ3?=
 =?utf-8?B?amdsT3JJa1l0NVBOcFdKdGkxZE16WnNHeS9tcDFJWlFndHdVSmZlY1Nnd2RM?=
 =?utf-8?B?RjVQTVZQa3RFSGs0QXRiVkQ3MVk5R01Kbk9jdWV2WE51c3JIdEpsMm9XeDZk?=
 =?utf-8?B?V2hxMUZOMHNwQ1k1YWRFM0JJYmc4amxyaTJuUktFVkdSVndHMnRUQ0VrbEpl?=
 =?utf-8?B?QTVjNDlNOGQ4eXFtVzJlcTFCT24yYnlWSUJsTmJmL0dWU2NhUEN6d0VBaGMz?=
 =?utf-8?B?U2h3OTZmUnpXWGVYMGZCYjFpYy94OVNzWUVLWmQ2Z1JkRHRKTFdlNndENktE?=
 =?utf-8?B?OUE1U2YvOGQrb1UwTDZkRzNHUlFueFRGZzlWbVM5R203dEExR3p0ajRPQ2Vo?=
 =?utf-8?B?MjFVbjAyV05UYkdWdndRMmp6MFgrclpjOEVPRlQ0ZkhMVnVjTi9YYmJIcy9j?=
 =?utf-8?Q?TbkP95dYGziHLcHG+H0h8gQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f262530-3384-4517-badd-08da0101417f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 12:43:33.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFBbjS3G7TeaQq8a1mR+eyBsJNDwDRlVHiAgF0YP7vbceNqSdENTumEbdnL0BZPfkL8UQzuKyKv37CDYli19hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/8/2022 6:54 PM, Sylvain Didelot wrote:
> External email: Use caution opening links or attachments
> 
> 
> Does it mean that RoCE always requires the network interface to have
> an IP address as it cannot use the GID to establish connections?
> 

I think it's just a ucmatose limitation..

> On Tue, Mar 8, 2022 at 11:49 AM Mark Zhang <markzhang@nvidia.com> wrote:
>>
>> On 3/7/2022 9:57 PM, Sylvain Didelot wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi,
>>>
>>> I have configured one of my Mellanox network adapters for RoCE:
>>> ---
>>> CA 'roceP1p1s0f1'
>>>       CA type: MT4123
>>>       Number of ports: 1
>>>       Firmware version: 20.32.1010
>>>       Hardware version: 0
>>>       Node GUID: 0xb8cef603002d1707
>>>       System image GUID: 0xb8cef603002d1706
>>>       Port 1:
>>>           State: Active
>>>           Physical state: LinkUp
>>>           Rate: 100
>>>           Base lid: 0
>>>           LMC: 0
>>>           SM lid: 0
>>>           Capability mask: 0x00010000
>>>           Port GUID: 0xbacef6fffe2d1707
>>>           Link layer: Ethernet
>>> ---
>>>
>>> The Infiniband stack was installed from the official Ubuntu repository
>>> (20.04.4 LTS):
>>> ---
>>> $ apt search ibverbs
>>> Sorting... Done
>>> Full Text Search... Done
>>> ibverbs-providers/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     User space provider drivers for libibverbs
>>>
>>> ibverbs-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Examples for the libibverbs library
>>>
>>> libibverbs-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Development files for the libibverbs library
>>>
>>> libibverbs1/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Library for direct userspace use of RDMA (InfiniBand/iWARP)
>>>
>>> librdmacm-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Development files for the librdmacm library
>>>
>>> librdmacm1/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Library for managing RDMA connections
>>>
>>> rdmacm-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
>>>     Examples for the librdmacm library
>>> ---
>>>
>>> When I start the ucmatose server with the address format "gid", the
>>> tool fails binding with the error "No such device"
>>>
>>> Here is an example of the output:
>>> ---
>>> $ cat /sys/class/infiniband/roceP1p1s0f1/ports/1/gids/0
>>> fe80:0000:0000:0000:bace:f6ff:fe2d:1707
>>>
>>> $ ucmatose -b fe80:0000:0000:0000:bace:f6ff:fe2d:1707 -P ib -f gid
>>> cmatose: starting server
>>> cmatose: bind address failed: No such device
>>> test complete
>>> return status -1
>>> ---
>>>
>>> Does rdmacm support connection establishment using GID with RoCE? Or
>>> Is it a known limitation for RoCE?
>>> FYI, the same experiment without RoCE (Link layer: Infiniband) works perfectly.
>>>
>>> Thanks for your help and your feedback.
>>>
>>> Sylvain Didelot
>>
>> I think ucmatose doesn't support RoCE when using "-f gid", as in this
>> case ai_family is set to AF_IB.


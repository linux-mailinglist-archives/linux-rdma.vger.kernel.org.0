Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228D4E1B1F
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Mar 2022 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCTKw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Mar 2022 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiCTKw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Mar 2022 06:52:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992FF2315F
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 03:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0lOr5j3jBJ2qcIDnW1LZdJ9+aPDDdIv9xPm0VejT8PvHFHqeH05bWCrLqASaMh+owBOsNqh9U0ARtBushso1f7OtraDaQdElxM8lIXhhFwqy7u5u+wOXFq2oIESQvgKNbMmxZC1iJ9prD7p+cIh6K+w4/OiOA5r4v5B/XDDVmwVlKDiP3K9lnzGhmvvKKeJKKsAgR3d29cTW0c0ND2e6r7cDg+vv6hFxvV5L6MlSRL/kzGISVNNj9KKA4k0xve7yZ/8eODbbQMTMq6NG7QLYjRjDO2lLomXQ/U8CtCTlYKVB3+hCsDjeiKS3NQhu+WXxkm1xwMR4y4GuGekP6+Wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8tUg64Mt/W3xrbyI4GnqjnjDiV52m53EQc6uGe1UBw=;
 b=RGsAiDqIjjO947cuGnTjaqrXna39uQebj6paVY5DyvxwcmFNlYNe5h6Kubb56Rr9crDAS/fPdCgjw7oTlksExJHAMZdxBIfVOzhd7B+tOqmkM74Uu1NfauPGufCIBgOyz3S8QzVkcQRVENfvCkEk4800YItxg4VUSVH6rDVXhi9gah9rbKaKq8okGfi+zCZRQZ85/93TYRmBNd4ytMeUN88Xaxr3MSKw0iL6EHUx3kHo9/kmEwrcRAD2iywRs9GRKatQR2fHt8gBLlg/IQXCjC/UE6u6KSSw7E8ejItl2SxEEJam1zSY+99bwpOhvosnUM0nU904NIbevooPmf7WZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8tUg64Mt/W3xrbyI4GnqjnjDiV52m53EQc6uGe1UBw=;
 b=iVE1cg+wpdnVELaDXTxscDxJ22eM2SmYDiURr7ABx/gFPNqgRK8PKXZYcZki8vnYmpxOQjpbIRDahOeAfbF5MsedcrrxFSWDrkklJSGm2Y2nrhZXwU0U2mXVsSg8639vx8cl4b/JgKeSwCXm17yOeLgrVm+UDL+R4hdHbGN2VOEc+HCfKW2X2VqeZ20GdNvDjNq1Kx1xjNrFK8TAV+kqiYcQlj5z/dW7Hgen28dnJRsmIPf8l1+a3Kg+87fwysHepbpxDdCGh+oUeNePldOOvHvqu6As9d6jXHMK2N33aTskaP7d/RB7j5y7/Ncuc9t6Dk7YXwt4mWQ62uuHemAg4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN8PR12MB3617.namprd12.prod.outlook.com (2603:10b6:408:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Sun, 20 Mar
 2022 10:50:58 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.018; Sun, 20 Mar 2022
 10:50:58 +0000
Message-ID: <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
Date:   Sun, 20 Mar 2022 12:50:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
 <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0156.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e9904c2-c46e-4846-f033-08da0a5f841e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3617:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3617C07AE4C19D04DE83A207DE159@BN8PR12MB3617.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28V68hYtthNjvNppGhb4qP8wpiRH3JtDHla2ACS83bAfju507R+L1j4LeP3QNXNw4HdnpXjiuxqjHDVKRwOpc//yfHyVcgPHAWect78Joqqf6tqrggzIgTP4ywMPbcfY4bboNYS2KcgQosv9QnicITWoT9WYJq5tIFcl754CNz9MU5HXSvz/2WeCDpXOWl+7OLPN51jLCdc3Crf9V9WLWRglDlu81DfAPwpBTtXz2dA0mq1mKfc+UBDYb3pLCTsrPvDG1/zpjdIwEHbVoILeQF36ktbo0KOOYrqNSbO44AI0mVidWBcej3k/hFSO4jgSTyQ23JT7HKosAJR8U+lcAxwfYBdsPysSDjk/dRv44NfshGEvD7U5Vno6U4L/DYgRxo1T4o89dtdpGmvQ+SI7wmNrSM23v97GXW0Jqhs6FlskwwZZ+6vzFrSWs5aUdPipmZpuY1ZdrWAOCKIbnN67QJe8j/ggmMkrgrUpwgaikB8ADRApMZquWoYL52kyQJoJ9D6vj4uEIRNmuPE0tNG2sbz23zxZaJMrcqJyFz8FY8PSG8JRwovaAgQZ2TzSbWDjwXsBt0+Mzc2PkUtnsecuBhRB7GcjI6UZQ1Ebc/Kl6ZU3QixJlVqxZ9VjfTBfN+noE8n+Seuj7jKa2luJ8MT+eqqD3M5/3JV2lUXpHfKtzzItNxA6ry/FwQj+9yVQFhXscVgJSbd+HHJYSePJNQG4MCjfpDK9oHJKIC7xivcxjgPi7nToZIgI0Ams/He/r6h335G1bZns2dxz3mIulB1kS5dpD9zfNRNTdqiUvUHT4QnvBLSxfpr08V0s/qAuncCY3CDLw+BDk6ZFBqk4GOWC5UhPIsQ0y7jE1HLaB9NjaI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(31686004)(8676002)(110136005)(66476007)(66556008)(4326008)(66946007)(966005)(6486002)(54906003)(316002)(36756003)(86362001)(6666004)(2906002)(6512007)(2616005)(45080400002)(8936002)(31696002)(38100700002)(5660300002)(6506007)(53546011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitZQ3JFcHdJcVdIOXhlRkJKS2FuZGkvYkU0OUVtUE9QVlVPa1QreEcwSXht?=
 =?utf-8?B?RGRJSVRIQzF5bEFPYVRxNHV5Wnc2Y1gxUUNuUlhXRTdTejZzVzJ1dWVITi81?=
 =?utf-8?B?NWxNY1hPRGdYY1QxUWF0ZGVXMkNPMm5CZ3UvbHFkSnZzY3AyT2p1aFEvZzV4?=
 =?utf-8?B?aHlmT3R0MG1vTUhOY21iNTdvMkhnTXVadjVwQ2tXK3hVYmEzb211ay9hOWc0?=
 =?utf-8?B?MHUzSlE3L1ZlMmNBR3Y5cytDRzdid0ljTzRnVVNEdjRlM1FKc2JaZWtLM1Av?=
 =?utf-8?B?cHNIRWZ6cFZ2MkEvVzNNdi9adGtKY2dHWEdJNy9DRXp6MGNOR0wzUnBsQ2NU?=
 =?utf-8?B?NktFbzNWZDJsMnZUZThGcEFoRHJQNkk1Wk42TExGcklWRUZHRlJwVitHUkx1?=
 =?utf-8?B?K0l5b0VaVVVXdGZMM2xFVzc1VTFaRCs4cTBzZU4zZjZpTHY2cHR4clpDZmhH?=
 =?utf-8?B?VVNSUjBCL2JzeCswazVqZUhodHlLbERnU01FZThLK3ZEYmphdllTclRPeHRM?=
 =?utf-8?B?ZElHTmJUVWREREpjTXlRM3BaVDJOVWxwMG5neThnZURBOGNocVdMUHV5SmZ6?=
 =?utf-8?B?TzNKZlNoSXJpSU1US0NLNVA0NXNxQXpML0tvam1KRTVyL3dEUGd6UUVySEpx?=
 =?utf-8?B?NVNTQThCQmFlblAzTElGeWRBR3JlWUtYbjJDZ1V5RlkvWFh3VGIxOWkreS9B?=
 =?utf-8?B?MEQ1QmRhWGYzcGo5cnJxSHJURWMwY29LNXluWDdpZEorOW5SREV5clhKTlcw?=
 =?utf-8?B?YTYzaVZvcDZQYi82b3pUdDdDckFmdmdwbTY3aDB4MG5MakhqZ0hMdEtQZFZ5?=
 =?utf-8?B?QUxtR29tS09ybmsvTzNnWEovSTZSdnN2NGp1SGtNbDJUdWx4QUora1Y3Wldv?=
 =?utf-8?B?RE9yOVdZd0FsM2wyWWQwUkV0WERDeWNrRWtYNGRLSlNxSmJneURnbElSU0Vq?=
 =?utf-8?B?L0JPS0ZhcmEwZzRiT1dVek01ZUFkRzR1a0Y5UEpwOGlHdnIxRS9FVlZjdWJE?=
 =?utf-8?B?V01NcW1UcUwzbG44ZDNyZmFyRlA3ZGoxZUU4cVhiYW5YSWtFcjdWTGFSb3NJ?=
 =?utf-8?B?UkovczNaNkROZEIrZkVDL05iU1NUUmVtTjFRazhoVk1TcUFrL0tGWmxxZ1Bk?=
 =?utf-8?B?dFZrc1YvMUhNbkF3QVFtUzl4RlpMOXZ4enJFTWlFNk9iT1RjK2VPdFRza3ZL?=
 =?utf-8?B?Z21SenU1bUNQKzgzUi9CU3lObXV4SE5aU1oyVWRNMWNjU1llMUFNdmM2aG9T?=
 =?utf-8?B?d0tOR3A5V2RIVDlLQlNGV1cvL3FRbGxSZmFlVW1mV1MySTN4OGRRUjZiSG9i?=
 =?utf-8?B?UXZFc0RrUXZzUEI5L2srUnNWZ3NCcGZVa2lvUHhNWGNtSGZTVzljamViRU1T?=
 =?utf-8?B?K0hLNEthakJYQkhNNmdadzdydjFvTUdiN0FuWFljRi9tT3p0Z1BUYUdsWnNq?=
 =?utf-8?B?K3B6VVlkb3lCMU9xUkhnazc4QXcvTWRxdWFHMStUTHZhc0t4VjhGeUNaUU56?=
 =?utf-8?B?aHp2b01aalp6YjZZbmR4OTRlbFRENXpMUnJUMnpXYU9ucklJM00zMlJ6YkFR?=
 =?utf-8?B?cDZPZXBIMGhidEFEWm1LUlV2TXI0Vm5QMU5JTUNWL3YrdkYwVUg4aU0xN3dI?=
 =?utf-8?B?MXVrQy80RlZVMFUxbks1UmVwck9mMGxTNEs1b0pCcW9POWRlRHBZeVhQcGRq?=
 =?utf-8?B?M2Q3alBXQnlXM2hGYnN2bU5iMk1aUmVoTXpRdHkxYjhhNUdSK3VuN3FidzFV?=
 =?utf-8?B?elFvWTNiYzhzS3pMeWM3M3FDWm1pZVVMcnd6Q21hSTNJaEV5VTBjMUE1ZW9F?=
 =?utf-8?B?TWEwWHB5TDhuNmRHelA3YUdMNGxmd3RoRTZRZXAzVTdPOW1LdFdRQW9xQWN4?=
 =?utf-8?B?ZjAwM3M0cHBvYWgzL2xJRnBkZUpGSDRzcGdqZCtnZ2Y2c2UwSkVVUGpRNkh5?=
 =?utf-8?B?d2o3a3pxTG5WV3dIWjdIeTZTUXRNUTNXWjNHSUc1L1ZJcXVkSGpsOTVDd2dN?=
 =?utf-8?B?VUI3d0RYMXNRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9904c2-c46e-4846-f033-08da0a5f841e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 10:50:58.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRDIdAcK5oxpGA4vfJibSLxYklWrPBuMFKCXJrqlu5RV4O7Jp04nr8I5et4e2dh4knz3clwyDzbn9xTetaep4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3617
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/19/2022 9:29 AM, Yi Zhang wrote:
> On Wed, Mar 16, 2022 at 11:16 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>>> Hi Yi Zhang,
>>>>
>>>> thanks for testing the patches.
>>>>
>>>> Can you provide more info on the time it took with both kernels ?
>>> Hi Max
>>> Sorry for the late response, here are the test results/dmesg on
>>> debug/non-debug kernel with your patch:
>>> debug kernel: timeout
>>> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
>>> real    0m16.956s
>>> user    0m0.000s
>>> sys     0m0.237s
>>> # time nvme reset /dev/nvme0
>>> real    1m33.623s
>>> user    0m0.000s
>>> sys     0m0.024s
>>> # time nvme disconnect-all
>>> real    1m26.640s
>>> user    0m0.000s
>>> sys     0m9.969s
>>>
>>> host dmesg:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2F8T3Lqtkn&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Cc89cc47d8acf4ef3256408da097a3305%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637832717692265478%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=qtZ8E6cvHlSu8LbUkBa0ehhguyQRfP%2B%2BC8BEonDNj9Y%3D&amp;reserved=0
>>> target dmesg:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FKpFP7xG2&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7Cc89cc47d8acf4ef3256408da097a3305%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637832717692265478%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=DerGWqQmWm9C30FFGbb5AcU%2B%2BrBErKClXzFlqSJT7jw%3D&amp;reserved=0
>>>
>>> non-debug kernel: no timeout issue, but still 12s for reset, and 8s
>>> for disconnect
>>> host:
>>> # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
>>>
>>> real    0m4.579s
>>> user    0m0.000s
>>> sys     0m0.004s
>>> # time nvme reset /dev/nvme0
>>>
>>> real    0m12.778s
>>> user    0m0.000s
>>> sys     0m0.006s
>>> # time nvme reset /dev/nvme0
>>>
>>> real    0m12.793s
>>> user    0m0.000s
>>> sys     0m0.006s
>>> # time nvme reset /dev/nvme0
>>>
>>> real    0m12.808s
>>> user    0m0.000s
>>> sys     0m0.006s
>>> # time nvme disconnect-all
>>>
>>> real    0m8.348s
>>> user    0m0.000s
>>> sys     0m0.189s
>> These are very long times for a non-debug kernel...
>> Max, do you see the root cause for this?
>>
>> Yi, does this happen with rxe/siw as well?
> Hi Sagi
>
> rxe/siw will take less than 1s
> with rdma_rxe
> # time nvme reset /dev/nvme0
> real 0m0.094s
> user 0m0.000s
> sys 0m0.006s
>
> with siw
> # time nvme reset /dev/nvme0
> real 0m0.097s
> user 0m0.000s
> sys 0m0.006s
>
> This is only reproducible with mlx IB card, as I mentioned before, the
> reset operation time changed from 3s to 12s after the below commit,
> could you check this commit?
>
> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc
> Author: Max Gurtovoy <maxg@mellanox.com>
> Date:   Tue May 19 17:05:56 2020 +0300
>
>      nvme-rdma: add metadata/T10-PI support
>
I couldn't repro these long reset times.

Nevertheless, the above commit added T10-PI offloads.

In this commit, for supported devices we create extra resources in HW 
(more memory keys per task).

I suggested doing this configuration as part of the "nvme connect" 
command and save this resource allocation by default but during the 
review I was asked to make it the default behavior.

Sagi/Christoph,

WDYT ? should we reconsider the "nvme connect --with_metadata" option ?

>

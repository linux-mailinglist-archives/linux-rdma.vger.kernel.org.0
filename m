Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2148AD9D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 13:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiAKM3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 07:29:00 -0500
Received: from mail-os0jpn01on2091.outbound.protection.outlook.com ([40.107.113.91]:10039
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239959AbiAKM27 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 07:28:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub1pcPFZtCWZyCvR7njJ0v4XOM7GMVV6io9Oxm6kk6lXYgz4unJiKezYT+Q5fwhj2KED5/yKbftANqaex4B9QMce7JdtbKvUbwUsWZgLALamapfXLMNqb5tbMPXiQ6dxJ8v6DbBXqs4srWGYhNNdwYce0tD8L4KRnCV/gtV/OVPdL+sN/L7p/ciUopVzYHEFJMiXBvn9tT8vb/wAPK1lrG8dzVfKSu8exlp2Swu9dqFqgn8lTqeAa1lUKXq7OK1KYOS5PUtogTL0K8LJ5G6jMJJT1ykOkAuCrWko763qbcJd69XnU1RVElw8yxLstaolePNe3pzRzYGLNOKmRggkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7QVZ6qqFWeo9jkfw/oTW+0iaUe+euYJcyPwbCkVH7Y=;
 b=he1k9/P8aTW1DaJPtzbCfkqbtKqfnK5flVyTbD4oXIE7HoU46akQEm20sxtBM/7mQY8zLy4xNPI9CqxI6z+tOsV+yRcK6/w299OuzDxdOxMx2QP9pwZXZvocq0GSniqdaDNUEqk74ZDIEHRUXCeaqY2tRvTifuimzQ3kGdiYlTyoxKbXjilY9PduYoYap1JZdJj0XOKp1Oof3L6fSUOjPqdtRe3TP4/xzQ+wB06T/hHz78P18EYt9RULIl4LO3myoNy3jcVkwBFz4Z2XwlDuizpoXTGQl+wfIrrUPviYWtiaoyjcbrV6KUzGsxMABDMREr+0Fr88lEPdSu8SrYln0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=riken.jp; dmarc=pass action=none header.from=riken.jp;
 dkim=pass header.d=riken.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riken.jp; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7QVZ6qqFWeo9jkfw/oTW+0iaUe+euYJcyPwbCkVH7Y=;
 b=RbiGejKPYVXeWdbCCa++9AJEXG/2gwNxBdEXO+osUZKyMQSrzq6/7tFVHOckBZRp6ji3j04okJHcOjDkTmIZfV4/3R41kJuO/FY4xHlvUuE6mORpWDlYw6Ix+G+y+Eiz4IYGFPwv45wohFUnjmF5nChj0GI+JgQwu7Q98k2V8K29YCrR5i/DhWbcAX3tEtnO539JLdV95YTh/0Q5Yh0tXAVNeKVKFxaYbPMvthoGMhjaAVebX81/L7B/XDTuhCJcwVkNoDyaosXvAqKy4j2e4/Ol/txPX6KORrK33XUe902EE9wh+k5gC3rzHonFO2vh05uYCKdVMjf86qsZoKznsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=riken.jp;
Received: from TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:cb::9) by
 TYCP286MB0896.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:7d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Tue, 11 Jan 2022 12:28:58 +0000
Received: from TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM
 ([fe80::180b:1f90:ddf5:f5b1]) by TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM
 ([fe80::180b:1f90:ddf5:f5b1%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 12:28:58 +0000
Message-ID: <26829838-99b2-c2d7-68a6-ecb53085fde6@riken.jp>
Date:   Tue, 11 Jan 2022 21:28:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: iblinkinfo for Python
Content-Language: en-US
To:     Benjamin Drung <benjamin.drung@ionos.com>
References: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
Cc:     linux-rdma@vger.kernel.org
From:   Jens Domke <jens.domke@riken.jp>
In-Reply-To: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY1PR01CA0190.jpnprd01.prod.outlook.com (2603:1096:403::20)
 To TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:cb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d65dac-8a42-45ae-03bf-08d9d4fdf0b2
X-MS-TrafficTypeDiagnostic: TYCP286MB0896:EE_
X-Microsoft-Antispam-PRVS: <TYCP286MB0896EE7ACA85705ED36CF5B0E1519@TYCP286MB0896.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cmI3tmHx1Ibnut9PYqlql9QIcx761P8B3Db/x5ThIr/B8lQV1FkDMUWNIoDbBH7kv+/E2x+FMHK5TkFIBXR6vsVaSh90evipyyg5d+AS+yBqWRNvw2jTZPWkvqFZxojG82ObwgDB5AEFGc+T5zw2CxWve1VWZYeb7r63wNeWn4Ed7pQEzlhEaFmlLctpQ3hYY76g8FUnTXmQDtpxiHGMKUjGuxx8CoxjzpJGgngKAQW+3mSmiUeCHml3XVna5a/C3+43p4VSqd3rmCIS7XBKCfb/WpZSlNehB9C8uuLsZ7qtiMw85KA5mWRB1D8aMXoRqj/h1qg4+McluHETb/3cpDdwyVujgI6fHX1ZicvOESXqlwjc5JCF7wIArBt2ry9KCyCDR8vwSRATphJNlizI58G7W6KQceDGm/nYTHK2asoQjBGZrKYeIMIVfuw3VqBQI7Fl327Dq9MX99JiRAZtAcbiweQO6rT/tpSv9bNBTsZweA5M9m8M7I9fxk+2SjnqTNpUe6Hiw3gWknFyX/K5R6c9mT11e3mx3+5bJXuQiSnJOSQSoRr73L62BGF1OkL2nneV6scZjIkBx3F1rw3bT5Juw7MnArO+aoPYZGETfyiSM5h9tqqBx7syz5HLN1ivtE7fYNyq/t4p5csn7TN4Wo2IiNi0CRgIIxq/FmOp6+Vmj7l7p3OoxNBHISWNt6bTPX/zEKbZ9giq+c2XpTCGRg3f4l/iyhC0ow8TEg2dt1UPb53gQvD9PfA9hCZhdgQAxx+R96f6gg2Y6fuuc/5s8x+TIoG1pL8UqLRyDs7D3JDWlkcKpCy1zAt3QGriLG0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(186003)(8676002)(3480700007)(38100700002)(6486002)(31696002)(8936002)(5660300002)(316002)(7116003)(31686004)(6916009)(86362001)(6512007)(66946007)(66556008)(2906002)(2616005)(6506007)(26005)(53546011)(36756003)(66476007)(44832011)(4326008)(966005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25Oc2d4VWJRb0RBUFFBVlhRWkV2d0xtU3NYS3VrcldxaHAxUTNxOWVUd2t0?=
 =?utf-8?B?ZnBmUXp3MllLa2o5YllSdkdoNXVkWEluSEo1bnRpYkphbGNncy9tRnloRXdx?=
 =?utf-8?B?MUsxdW5zeVV0a2ZSeVJUSGhkd0VQUFBxSVcxK2NHcUdCb21NY0RLcEZuK0Z5?=
 =?utf-8?B?Ty9uQ2RXUDlpTTVEQm03UWJSdDhENEU4MTBVazJIZTgvd2NmRFNsTER4QTA3?=
 =?utf-8?B?T2hMQi9IMVJGVElBMHRYYlBsQWV3VmNXRzV4ZW9FQUlFdDBDNkZqd3liYk14?=
 =?utf-8?B?UVdxUUdVNlZhdjRWamhuNnZKc2lBNzNDZktMR0NYSkdDRkVxNDhER0VKZ0p6?=
 =?utf-8?B?RVFTNFA3Y0lmZWVpY3BnbjlvdFlOYlcyL3A3MGd3a1RMeVdhT3QvMmIxc1Ax?=
 =?utf-8?B?cmMrVUtEZUxRdysrMDFFQmU1S2UwUkhoTWtQSFJON0ZBNldSdXloU0hsSm5H?=
 =?utf-8?B?MHorUzJ1WlZOT0ZpeTltdW9nSnpoVlBWU1FvV1U1ck9vTHlCYk10Q2Q5ektU?=
 =?utf-8?B?RmlUOW1Lc2pkOEFJb2dkdnNSMmdjSXR4akcwek9HblU5UEhwUkVoYW04cWVx?=
 =?utf-8?B?cCtSTWllOGUxRkpTYzZRWms4OXo2SFFxNXY3akNTYjdna0wvRWt3cjlzalpL?=
 =?utf-8?B?RTBjeVdXMUk0WUpEMXNOelNwdFFjREJKYjhTV1F1WnhLZDBRbXNNYklLR3NX?=
 =?utf-8?B?bGR3NVdPekhHbXBwS0padmJLTXB1TENtK2cxMVlUODEyZ0NGSVlpN3Q4NWhZ?=
 =?utf-8?B?TkRQTWhBVkZqdDcycWM5ZGsyaE9zMzFpZEJzTWdEcE5wK25aY3lKbHp2MktZ?=
 =?utf-8?B?WVcrUzZpdHpZOUNlZnFnZDY0dGxjZHhLR0FKMElFQnRVczA5RUxXZURWY21T?=
 =?utf-8?B?Y3VHYkp1ZWRBRDBtWUYzaDFJaGFRYkMzWXJLVDRjekZiSGlYTWQ1M2JQa2c0?=
 =?utf-8?B?SHFlVEZuYUlCQUlCL3ZNbjNMekJmQkVMZ0dPR2dPUVpWMHpzWVVzTzRWbVBT?=
 =?utf-8?B?d3lvNCt5LzRUWTJYN0dqY0Z6OWh2dFNhZ056ZUVaOENPckNpU3dRL2JqQnU1?=
 =?utf-8?B?dFNCcWJRSXRtZE9iNnZVVVJwY3JVTXFrS29lUVJSM1BRbi9jUC9FdTdyWkF4?=
 =?utf-8?B?Y2ZYWFZra2VqRUk1bHFveVp5eWtSUzNpdzlVUnAvZzRNMkhGWU82VzNJSG1u?=
 =?utf-8?B?OThzM01qMzNUTHBvU0FIM0NKRHlEOWdQTFN6aDFZUDFGNk9RVlVhVHJHemVp?=
 =?utf-8?B?cmxDWHczZHN4ZGZPaEN5ZG9UNDJoTlgzS0R5NTlDMkU5VTJFVkUzZXRIMTl3?=
 =?utf-8?B?N3d0MUZtaC8xQm9kK0EwRE0wZmEzeVJ0SmFJemcxZjE1ejl2SkJyZXUvZlJt?=
 =?utf-8?B?cjhNYnBCMEtpTW9BdlNtZDN4V2p0MU4wVWtKWUI2aUMvODZlMGJoblVCVklt?=
 =?utf-8?B?UUc0WHJpbUMvcVRsOFVZdC94UXNYMG4wMGZZU0xReERKekxqSTQvSXlQcGNw?=
 =?utf-8?B?R3MycVVzU3dCQk85bjRLdWtJK0treUFqbWpQaDhJYXE2UVJNYndEMVJRUENW?=
 =?utf-8?B?dlU4WFQxU3puelhGU0t2NlNNZVV6Mkx6VnRncGNibFBjbWNBOEJPSmc2UHJz?=
 =?utf-8?B?eFlseHdYK09RU09aUkczVXBNSUhyc2hsQXR4KzVyclZ5YVRLWmh4MWRFN2RF?=
 =?utf-8?B?NG1Mc2RROVBsMFRyYi9wOEpnYVlRYnNwTVRlRWdZNFhBak1WMWY0L01ieCtK?=
 =?utf-8?B?djh4OVdBempvcUM2S3p6aG1WM0RZeXkwZGlLL2Z3eGZxRWI5M3hRZkpERnZS?=
 =?utf-8?B?YjhOOXZ1VE90dmRURWEwQml6UVNUd05zUVZlZmFNOTIyei9SVjJpTmhland6?=
 =?utf-8?B?M3hheUZGNmlnMWRTQXRWS2hhL0NqOUkzajhkMkpHdXB4amN3T3VhRTVWWFBw?=
 =?utf-8?B?UjVXd1N4VjQ0cDlEenpoR3NqSThPb3JhRU5zYkREYzNpcHd2UmFJbE84akxD?=
 =?utf-8?B?WkRDdWhWUHpRaTQ1bVVnM2NtcmZTNUQ1Tk1hYmhoL2F1K2E4T056NVN5NEsw?=
 =?utf-8?B?L3E2czVaQnIvU2IwTmFTd3F5L2tVRkp1OGtTYk1uN0kvckx6RHByU09oQ21t?=
 =?utf-8?B?VEZZN1NwdzN0Rk1GWkdyTE9BMWdsVEhoNktNcStUSXNDeDRBcXFtWEFXUFNm?=
 =?utf-8?Q?5woKI12aIWJY5/WAOGZzASs=3D?=
X-OriginatorOrg: riken.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d65dac-8a42-45ae-03bf-08d9d4fdf0b2
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1066.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 12:28:58.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fce8b959-27d5-4b4e-a4e9-1014a2f95c90
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoTs8oI/6bis4emYG9CwlzphBWzPcM8f7EQoMCD9t7gdR47xHTyMfXu8R+2937Wr5ERT7E8cUD3O04p69PZeng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0896
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Benjamin,

I have written some simple parser for output of certain IB commands:
https://gitlab.com/domke/ParseInfiniband

Maybe it will help you, since it includes iblinkinfo and is in py3.

Best,
  Jens

On 1/5/22 19:32, Benjamin Drung wrote:
> Hi,
> 
> we have an in-house Shell script that uses iblinkinfo to check if the
> InfiniBand cabling is correct. This information can be derived from the
> node names that can be seen for the HCA port. I want to improve that
> check and rewrite it in Python, but I failed to find an easy and robust
> way to retrieve the node names for a HCA port:
> 
> 1) Call "iblinkinfo --line" and parse the output. Parsing the output
> could probably be done with a complex regular expression. This solution
> is too ugly IMO.
> 
> 2) Extend iblinkinfo to provide a JSON output. Then let the Python
> script call "iblinkinfo --json" and simply use json.load for parsing.
> This solution requires some C coding and probably a good json library
> should be used to avoid generating bogus JSON.
> 
> 3) Use https://github.com/jgunthorpe/python-rdma but this library has
> not been touched for five years and needs porting to Python 3. So that
> is probably a lot of work as well.
> 
> 4) Use pyverbs provided by rdma-core, but I found neither a single API
> call to query similar data to iblinkinfo, nor an example for that use
> case.
> 
> What should I do?
> 

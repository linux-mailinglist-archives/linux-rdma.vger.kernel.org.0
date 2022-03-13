Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA594D7424
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Mar 2022 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiCMKA0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Mar 2022 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCMKAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Mar 2022 06:00:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC31887A7;
        Sun, 13 Mar 2022 01:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4S4BLU2bdHn3y+YtrUWnF683hV+BIm9tiLykpIOJ2C3UWPEnr/R/Z371bAlx58uk6QeWU7C5J+PrGPDiBsHvXYuIB79ghvtIxpTSAbbTs1OYYZo26lUaOl4YrgltZXzB9demFcZ5jucUSMj5MTQ1moArMmNrJkRqlvoINwJIOyab5045BJVBHqZncOoUONDKra98GA9Hy1SjKu2BCy6Rcuh3c1v598MOlmlGwQtxWmGDunvByGrySw8KKgfw8tCa9jEGArkZIaceGKF5LFsJ+6ZkYI62ZgUcBcV1fhgSEXyJ738vVGizLey0Sqh65S6JCsALkcmI0OC8iLKuCpCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhOSsK78u6/e0vX7Kr1Yblt+j3WL7qwp0LhQmhCOtk4=;
 b=Z0lKxSQtNNxQa8zK6Eq3opgUaAoQh7XmRTQGp28IWTL5Ux6H76uuOu6sslVSmJmKAiuNNT0YY1+6uuNCdy+gp4yoRpM4Q01RiyguwK3/VM5J+HHjASsL+CjUdWnLIAas5ISNPS76yeCx1WE+hK6BJhaDDlLKq1Auc9psZfMHqo4f9Ii8Njgl/23jRZrFDQuE3YoF+Wk3iPzC/TUZIRiAHGrOzzIw5e6nAcR9jye9GsRrPH3m4uXeHpSETs/6ObWZjoKV4FrCYq620XIa9A3yQF58f2yoo4d6HvrxldfOlQ0MioL1gvxhmKBHjmd1Y2UDEny9vraXgyNUT/yaGpW5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhOSsK78u6/e0vX7Kr1Yblt+j3WL7qwp0LhQmhCOtk4=;
 b=bUxPB4a2jSEEsuWrGvqxvNWOYhKhT4Em5HYE7u7URYQAA91LVv/c8OztNs9dnTLhu7qSwV8acs5KUyOvN+slkQ27V+8lkIezpACuScgXt1upbIWDGVgyJAritHs9JROmtdQ3Ln6tlINuwZaw9v07CE9aLqdajT0Y/NMWkPHJLgoKmLbNCEk4qy76XN7IEVdLz7f5CZdfRU0l2fUhARRFpGNt26BJR1mugGsTAlv9uv93BNVNlG9RqTom5L+590vnCLqqwLzY+WDd6qcYLK4Xb/BgtdcxsTz2REt9wmyp46j3ohtlFqTI5My/gOFTCxYuMHdszZOZvlH5qyQ7/uOtzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 09:59:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 09:59:16 +0000
Message-ID: <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
Date:   Sun, 13 Mar 2022 11:59:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
Content-Language: en-US
To:     David Jeffery <djeffery@redhat.com>, linux-rdma@vger.kernel.org
Cc:     target-devel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Laurence Oberman <loberman@redhat.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220311175713.2344960-1-djeffery@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3eeded9-bf0e-402b-ff52-08da04d8220b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB285970FF6BDA459163AC04BADE0E9@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6Svl3JxfrhjPcRoiKjw5GGHBNKWRuBaOcxcvCHbUMSajTcWrq3AdVfOL/GDbZhCNxZ2YwMEuMJsFrciqiq1xUl4jqTKTIGMe3A5dG79RadU5Zios03fKVfNNuTb1RM3elzRa71IzF5pCrUmvvQWlFwAuHv65y+OA8ed8FPzyMlg1CuCQAbF0s96afPt/IBkgxv0LcGF8OvdUCpg/XfLqO2h+GwUjwUh4uZFycB8wUIeXsTEIJszF42GkAdMIwKauYwAdKETQpwZhohzDFsjVmn/lrrNmKMnZNKQWYJMkRR2xcc+FAhqXQ8EkUsxqg9XPFIgkqJ0GOBLhHnLPsXjYRz1cNFGgnjxQCezDdkdaDJMsBrql6OL6BkLQZ/o3ycyR8A+jmBZjflb2TsHxkqMMOgMUPQBPBnDWgE2zIJyfnIWJdDKF+iPtq2auC2DBuvMns2ZlgnYvomBQACIqe1o9WQuEFwVzdZdvtgonWDHWavBlVzUeWtVlP3EDFCyT3yjEFq2bN0sDK2M0Orrzsj4hlvRiGU6XK2hBZeVxDJ17NaLWjKiu+LN9yRqlqX6bzRZ5tY5lrglwWJuH+lIOb4ZPn1IKLK4LgHJcV5zQj8IljE7I3I9TpOri2Au28JJR1yzuOfUz46RFjoEaJ6VSZOOl9aApZFp2lz3YuvVDex1lDnR4RnwI4IuwSLzXw0MErG+IpTWfV+RIAy/vOV22IH/klwnAr3hxWyPgxNpJ2lGDhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(6666004)(5660300002)(38100700002)(8936002)(186003)(2616005)(31686004)(36756003)(316002)(26005)(54906003)(508600001)(6512007)(86362001)(83380400001)(8676002)(66476007)(66946007)(4326008)(66556008)(6506007)(53546011)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tES2kwRFQrZm85dHFwZEhIQmhzQ0tzcFJ3SXlVdEVyNW90bDRFNGFWUklJ?=
 =?utf-8?B?M1NUdzZ5OWhiVnVlWkFlSkFVWmJScG5pNzQyb0Q5Y3kvWFd2T0k0aGV2Sjh0?=
 =?utf-8?B?NmIrM3ZVelZMbzh1K3M3bHNmTmNBVkNEenAxN0hKaEFNUTZheTloc3JWSERG?=
 =?utf-8?B?WVgzV1d4SVArYUI2WWswVE5kUy9kMVZxV2paUHRFdlRpeml0UTZBL1ZValBm?=
 =?utf-8?B?VDhqSjBRRXZzeUZiWmtMQ1pLRk5mQ0FrVFZJRkp1ajB0NW5zM2wxZVp1dWto?=
 =?utf-8?B?UU1hKzE4cjA5cjNUNHpuNVgrZUVhY0hEOXdVMWwzV3VhbDFpMXBGS0NaSjJx?=
 =?utf-8?B?S01JYUhCeVdLeWVyUExkMnEralByeS9IeVNxdjVSMlBGdS9iT1FrekpWbFM3?=
 =?utf-8?B?Wm5OR1Q1ZVJlTVF3eFJmbE5BdkdDQVp5d1R4OTI2RjI4ZTNWMkJHa3dOSWFz?=
 =?utf-8?B?OGMvVnc5aHc1Z2lxWllnRnVYK0xCaHpXWm54eW5vMlZKeVA5ektwYTd3ZTlI?=
 =?utf-8?B?WEJGT2FnLzdTcVlrSkhqQ2hqb3NhOVlFWnFWaGNqcUJKS0JtRTZJbklpRHFl?=
 =?utf-8?B?eUswZFo2UVYzZUlqcEpVUXRoQzkrOGM4L3dwWXgyZEFFQm9wTWkvVG5tVHNy?=
 =?utf-8?B?SWJGaytUdmtDS3M0Ry8xUVNoZ2ZwUUkxOGV5VjhNS2c0WWppbHpaaWpRd1ZH?=
 =?utf-8?B?QzU4QlYzSDhSREFTNWVHeGl6Q0l5MUFVWEk3YVNreklYSUM4S1pPYU5uN1cv?=
 =?utf-8?B?NTBqaHNabnZsN0ZMRjRhcUJUZWZGdHdBdE44eU9xS1YrSm9rQ3dSZUhpbDYr?=
 =?utf-8?B?ZEsvQ0tWQjhrOVRadUVybmd2MUhwMlpCZjBrVTZ1R2FicmdteWhJcDVIUncz?=
 =?utf-8?B?QXpNalJPMlhBNUlYeDFYNU1uM3plbGlPK3hsK1JOWHhYOStLc0tZbExqeWJw?=
 =?utf-8?B?eVZRVnpDczYrT21nQVk0amhQKzdiM0FLY3d5b1RaNlk4YnJ4TWdCcUtnTEdV?=
 =?utf-8?B?ZzMzMGtrN3QrOXhsZGFMZFpqZDl4S3NCU24zbzZqamk4OFR6dlVLOTNKSG5I?=
 =?utf-8?B?dkdUZ3dqeG1oczNFSGtaV0hnWDlENncrZG5aTmNTcXdSWXdqNWdpRXU3bUR3?=
 =?utf-8?B?K0FsWTdxRXRpRUVuZTBTUjRLRlZ4OS9HSW1TTk1NZktRWlcwYnpLdUt1dWl4?=
 =?utf-8?B?bjU2d2xIMjhuTXo2RWFVOENWODRWT1FBRXpCcVBqSlA3SHpJUkRKMXJSZnY4?=
 =?utf-8?B?Tk1meVZVUllrMWJuczRDbDRubDRSR3c1WEpMT0JIR083VW5PYVJ2d2dwRU5Q?=
 =?utf-8?B?QmNrZXVtUHJrY3I5ZWVMOTdrUmxpTjNDYmt1NXQ2MG96NzNQMXd5TTBTR2ZE?=
 =?utf-8?B?TEV6V0g5SHYzNDRSVzNuSlhaalFvaGROczlLcVJDQ1hlTmFQOEo5TDBzY2to?=
 =?utf-8?B?Sk1TU0IxQ2J3bEoxVkM1SnBOZlYyUXhWbmNyV1VNdE9JSnp0eFBDZnlZZ0U5?=
 =?utf-8?B?a29qYnVZTkYwK0VTZ09EZTNqK1VueS9UZWpiSkdMMXNLU09pWmxSc25iR1Ir?=
 =?utf-8?B?R2dXeFJtSkg2VitBL2lFTEtCVjZabU0vMkJUdU4zTmtnZ1luMi9GTkJwYWVw?=
 =?utf-8?B?eUgxVVlMbGdlOFVwUU1QV3VhZTY3U1l5T3Vzd3liTVpRa3RvOXFZcUZlMnY3?=
 =?utf-8?B?TjJLZjRqUVp4dENuVk9HYnp5Y3lvTk5kU2g2UDgzVVhRSlgzKzVIeENQQTdw?=
 =?utf-8?B?RXhHUTR0cTYweCtCU2VwcEtTWS91NlpCMkJ3SnN2cy9XSG14cExkWlU2VzRr?=
 =?utf-8?B?Y3Mya2g0eEdKeGF6UHF2UkEvUmdlZHpxb2dMZFlFa3dNTXJ0OHEzSkc0Qkh3?=
 =?utf-8?B?bnU1NUZLdnlqVWJTTUxqOVQ1ZUg1czM5dkVyeHpCVVdaK3JwUlNBa1BtVDZK?=
 =?utf-8?Q?zBUG9+8MUJNjORVfBPQQ+akTbRHiNsEU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eeded9-bf0e-402b-ff52-08da04d8220b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 09:59:15.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6kUtrtSjcYAoPqoztnFJcHVZ1ymoouGJV0/80Rfo1saM90CNvn5sjnIdPdWdX6MWK2k138SPk/+LD0z+7Yu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi David,

thanks for the report.

On 3/11/2022 7:57 PM, David Jeffery wrote:
> With fast infiniband networks and rdma through isert, the isert version of
> an iSCSI target can get itself into a deadlock condition from when
> max_cmd_sn updates are pushed to the client versus when commands are fully
> released after rdma completes.
>
> iscsit preallocates a limited number of iscsi_cmd structs used for any
> commands from the initiator. While the iscsi window would normally be
> expected to limit the number used by normal SCSI commands, isert can exceed
> this limit with commands waiting finally completion. max_cmd_sn gets
> incremented and pushed to the client on sending the target's final
> response, but the iscsi_cmd won't be freed for reuse until after all rdma
> is acknowledged as complete.

Please check how we fixed that in NVMf in Sagi's commit:

nvmet-rdma: fix possible bogus dereference under heavy load (commit: 
8407879c4e0d77)

Maybe this can be done in isert and will solve this problem in a simpler 
way.

is it necessary to change max_cmd_sn ?


>
> This allows more new commands to come in even as older commands are not yet
> released. With enough commands on the initiator wanting to be sent, this can
> result in all iscsi_cmd structs being allocated and used for SCSI commands.
>
> And once all are allocated, isert can deadlock when another new command is
> received. Its receive processing waits for an iscsi_cmd to become available.
> But this also stalls processing of the completions which would result in
> releasing an iscsi_cmd, resulting in a deadlock.
>
> This small patch series prevents this issue by altering when and how
> max_cmd_sn changes are reported to the initiator for isert. It gets delayed
> until iscsi_cmd release instead of when sending a final response.
>
> To prevent failure or large delays for informing the initiator of changes to
> max_cmd_sn, NOPIN is used as a method to inform the initiator should the
> difference between internal max_cmd_sn and what has been passed to the
> initiator grow too large.
>
> David Jeffery (2):
>    isert: support for unsolicited NOPIN with no response.
>    iscsit: increment max_cmd_sn for isert on command release
>
>   drivers/infiniband/ulp/isert/ib_isert.c    | 11 ++++++-
>   drivers/target/iscsi/iscsi_target.c        | 18 +++++------
>   drivers/target/iscsi/iscsi_target_device.c | 35 +++++++++++++++++++++-
>   drivers/target/iscsi/iscsi_target_login.c  |  1 +
>   drivers/target/iscsi/iscsi_target_util.c   |  5 +++-
>   drivers/target/iscsi/iscsi_target_util.h   |  1 +
>   include/target/iscsi/iscsi_target_core.h   |  8 +++++
>   include/target/iscsi/iscsi_transport.h     |  1 +
>   8 files changed, 68 insertions(+), 12 deletions(-)
>

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE36A9079
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 06:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCCFfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Mar 2023 00:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCCFfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Mar 2023 00:35:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE72976B
        for <linux-rdma@vger.kernel.org>; Thu,  2 Mar 2023 21:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naKAAbKArc5oGiX42NWYuLCX5Oiz0/JD2jt4gy90H/fhseDDzSjhQExQOoW9hiC4VaoULIZumAevJnWYjxLBQm6EJi5yWPozbpmOVQQNF0lt55k/d3H8wqHl2hjFAZtwS/8D9zkXKAfBeG/D33E0L9ucMckU6rjaFdzHr8qEBgWRVIODR09o9GhDhTqQxfasCFCsRAtEipXP2hxTJIzPFEHImnInrmmBr02pVHgBAvocMXCLHiW8E5lKYqMy2gjWnzrp4sW2/4oj0r+L4FoWVSCYTRzIG5GprPrdmbWmqz3EgsFCKxivOs+AuYyOhlBhlHbvnhdARaJtHXOswUJfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhwO06mid47j9X7CCBFrUktbOQ3E7s8mLBKVzEX/occ=;
 b=N6234/N0IkeJFN1TbgA5N5LzEJU78rnjKKh1i3KvHqVpgEGj3AxQ0OA61KaFndRS/KNcrilv2UNkivfV1rjifKa4VXClHu30G1eQ/HSrKX2rX93F2bMS3crlUvanxPpupXOIip1kTV0rkkSPJTqxt9zDe/dYgSd6TjSDjTOI7v/bzGc0rVNmv0J7gMcWbJnVnQhiXXETzu3Z5nnb+SQi21x52OJY8YNn6/puEkRUlF319ZjbOgA+i0z6UmW569Qm888+S2C0Dkb3dXv7LEs1MHVuYZxA4py8jFUV7F/FXXeQywvSsBcobWEKFPSb6SkU3+yafPhoflri18SOkA0gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhwO06mid47j9X7CCBFrUktbOQ3E7s8mLBKVzEX/occ=;
 b=VridnSMIN3GnVvA0U4C3E+OTNuTuMWTUX+QmGZkjLhopjiGsJLh19CnuFRkj9LDiKFigQ75affj2Dtc9PpkRPoI1t9BFnyDL8ZosrGu9b6mmCE08zn01AUMp3P6a7oHIDDX4ra2v+mlTFoG/rOTPeNw1B1G27STdbwqZkCKIfQAAFBOqH48UitF1nKYT3w3itm/v91rBjHvLsHtvgROwuWU3/DmFD9mwzZ1d6XrM+OEH2J1xpeRfdyD0nV7QOKc+ZUmVwfC9LArLeLTo3GZyfPgsyAo45gLi9Oe01bwGs65vIk/syY5fYW81lN8G4zj9p5RHWlo0JmrUyPFBWxR2fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 05:35:02 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::75a7:9c68:f95f:9fff]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::75a7:9c68:f95f:9fff%8]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 05:35:01 +0000
Message-ID: <502cfabb-c83c-08c9-eb6d-c1d7320249e7@nvidia.com>
Date:   Fri, 3 Mar 2023 07:34:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: A question about FAILOVER event in RoCE LAG
Content-Language: en-US
To:     Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <26b0d23202814f60b994ce123830353d@hisilicon.com>
 <Y/tWPpJNz3EHtMgB@unreal> <afd9c082-db31-da9e-8cc9-44410d110ccf@nvidia.com>
 <9befbceb-a493-652b-bd51-97f3f632eefb@hisilicon.com>
From:   Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <9befbceb-a493-652b-bd51-97f3f632eefb@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0302CA0013.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::23) To BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4f2072-8e97-4b09-aae1-08db1ba908d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmQzGx7i+Rd/uRFuKULVN/mxyvlYxdpqp7h24OT5WNAs1OCjiNk+wQtbXSSeKlibkSrdmP9gutD+JnvJtpExtai3u91FU3PELBRbSb5W9EAYEH7eJ8gRYT+od6c39lMvHasLqvrODFVktSmyzyPmQeW5eMhuACJ1fCDHvWFQSPbtljwBWDrjx1R1Y+1l93oEqjsNalMAviJBjEkXZ3VJyDGo/No1LR4mPytYvVhpqRkKpuClBkKI7PM+jRcyiFpPLVe+efUqpvDJLHyR+jeQ5V1y9T1mJywq6LYkDVfGOZvMcaaM5Z+88/jCHML4lM3PIYELKbBMKcq0eyHgTz6a5sFsGH/t/cER0rbyrRrsVL0BzRPU/oLSDwMM6jM+i5+oWpywmLns4nyn02pnmYgHClIEMMUb1MWv7RLfPwTArCAfjXbcGCASOOzk9/nmXz9awafO7DQjdJOAR+9iEgPyWYm4Hjr1WWwa1wHzbOpQk6q7zWEQBoPYZl56SowZOwiDIPlCiahe6e+YsYG+OthnDws04C6j2jfnXJHREa/lOkhILMxClou35VsB3mu/eExtbvaLNcKXspPMesHxaJfrZ0KFgcFSR9+PlRjEn8IhL11YVZSHoBtFAW50gl2RF4g6UsXyzY5oFyuM4XPSwMCrAVAIqEqcy4vcVB+FJ6GMcX5/fJ0quzb3YupjGLuLMgnhqWPoQjF/ObbWq7dHbQFTpagr5jxdqkjqNaMOAsb54BiksktXpJtXP7jwzIo5pt9EMmHH4IVhOsKY29Mspp0aow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199018)(8676002)(38100700002)(41300700001)(31696002)(36756003)(86362001)(66476007)(2906002)(8936002)(4326008)(66556008)(66946007)(5660300002)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(110136005)(83380400001)(6666004)(316002)(478600001)(54906003)(966005)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNPRjhQTjlYVDdZR2RkMTR1blVBeW1yblRhOEhkbDJKVjhTNFF6YndlSWl4?=
 =?utf-8?B?Qi9SMmFGaXBXWVJBa29zSUR4elFPV3VuTlhWSzNVcGJTQmVkeDJPQVhkN2Jw?=
 =?utf-8?B?aDRpY3h5S2o3VERqSzhjVUp5ckovRUovQ3h0UEJSU2VLTWpDM1Q1SUVNR24x?=
 =?utf-8?B?WUhGdk5oVTBJS2xwN0lsd3VIUG9tUlVyeFNMdlN3dWgweXJnYjJ0OVQrVEx5?=
 =?utf-8?B?d3FuS1U5NGJHdnpPdHRPeUMzajdvemJYL0VsU1NjaE1xN2FSdFpxdGE4aG1p?=
 =?utf-8?B?ZjhFODA2VzR1M1oxYUJMNXd6eG9LOE83NGtPdmZ1M2RWVjFnNENyakZDazNS?=
 =?utf-8?B?RG1aK1VBdFFJQ0plempKNmlBS3hhT0RqNWJyYXpPM3B2dk5NYWZ3c3FJUU4z?=
 =?utf-8?B?VUtwNkNHcEFiMnFqVU9NWklrcmZQRCtDelJZZ054K2pER2xPVDNWeWR5Slo2?=
 =?utf-8?B?cFRrMmJDTGZaWlRsWndpdnhXcG9uN2NYaWkvM1o3YTFkaS9IcWloMnBOc0ZB?=
 =?utf-8?B?dzAxNnpEOFFFWmpFTTFPSm5CMWk3SC81UXIwbmV4bS9idlhYODRDbDRtZXZZ?=
 =?utf-8?B?bG9NSG55SUN0NXUrRVladXc0d011c3d3c0NYeVdtamNvMVoxZHRsanJML0ZK?=
 =?utf-8?B?OGdibDZxZTdXWVVNSDhpOEREcUFNL2U3QVVYQUVQOGk2OVlnVC9LNlRmaTkz?=
 =?utf-8?B?S3diT1F0SmY4NzY1QjBYNUQwK2w1enJDYmtsSzNlcDNHSjV5SGhRWCtkblpq?=
 =?utf-8?B?cW1uZm1qOVJXVTVqamIxTE4zVkFwU0JlWksrR2p5cHA4Wm9WMUFtenBUQ29v?=
 =?utf-8?B?SUVxYTAvM21IN0o3ZkN3b000MVBvdHU5aGh4c1hiV1RYZ21nRUhkZ1Zzd3dn?=
 =?utf-8?B?dUZkTVJMa00zdFBDcFdKTTA2bGNkSGZPUU53d1JRRHYvTWQzQW83VW5iY0Rz?=
 =?utf-8?B?T3lzRTgreHNYVGQ3ekg0bXUxT0hhcGdVT1BhdXlJV2JHYStrTVR1SkJKZDN6?=
 =?utf-8?B?VWhZVEJ6QVE3QkEvR0dmYkNBSXIvQ01zZVNhamE1UGpqVFdldHFqY1MxMEkv?=
 =?utf-8?B?NUxsWGpVUjFoQlVQWmVmUXVlbk1oVEQ2QlVWRStGSDlEMFUwdXorcW00TUxp?=
 =?utf-8?B?Ny94KytWdUZ1Y3hkdmJWS3Y2clJGZWlMaG4rVTc1ZEFNdWl6OHBnKzJsMXIy?=
 =?utf-8?B?V0MyaHBpYlFCZ1hmdWxiL0VLNlZKWkgzcjZYN3g5YWlDaVdVTUFMZzFEZTdC?=
 =?utf-8?B?MTFvcnJSV2FQTUxLYVlZcE54SEpvbS9mVUVjYmRhTG1TSkhGUk1EVHdJZy9r?=
 =?utf-8?B?d3l0TzJzSVVSOG4yVkZoUFp4VVhlS3FoVkl3Uk9kWXUvckxVd2lvYWlYdk5M?=
 =?utf-8?B?Sm9EU3hiWkNPdllkdFVtWDVIOFFPeWFPMWdMNHpGS3FBWEpRUUxSdE00UWxy?=
 =?utf-8?B?VG9VRVQvcWh6LzVBU1dheXVzNlh1Tm5kWWVHODBEeWZtL1pYTWFUNlJ2R1cr?=
 =?utf-8?B?Tjg1d2xLR1JlS2djdDRaUHh0RDhTZC9tQysrYXZzdDllbTJYeTBlbDEwNmF5?=
 =?utf-8?B?bHBraTQrSGhQSUpaOFVCSm5UY29RZGZXdEE5ek1WdEYzVFQvUklwRjJuY0Y3?=
 =?utf-8?B?US9DT2JYU2M5ejlrSmpYbW1zeEVrcHJ3WDNZNEhNdUJ4d3ZKYjlreTMxc2ZY?=
 =?utf-8?B?ZUVCa21TQUtET1NsTEQ5NldIeFI4TUhqYTc1SWpzYzhONmlvRkJnOS96YklQ?=
 =?utf-8?B?U3dsLythZjkremRNT0FuT1UxTkZOeFVTYXNDcTh3enhJRXNHVWN2QzBCK3RM?=
 =?utf-8?B?M0R1UHZLYm5vNWtqL3R0cUhobS9GUW5rWUtZZ2s2SFQxYTVDbUNDQjRSSkhB?=
 =?utf-8?B?R0I0OVc1Nk9BSkRjVXdjVVl6OUQxZFJKaEFTNW9mczRObzU5UUEzZFlKWVFR?=
 =?utf-8?B?LzlYYjlPWUd1SU5VeGszSStjcWg3SURrTGRPL3Y4RDRvbVhKZzV3RUN6UTlP?=
 =?utf-8?B?a1ZrSG40bTNJbmRsVkd0VjNCTmpHdWxydTlyenUxak1ScHpKYzVOK2laOTNP?=
 =?utf-8?B?K3ovOXJ2ZXJtbXBod0pBQ2RyeW9sYnZROHFLTzNSRXZMRE8xOUJ5WW0vb0lt?=
 =?utf-8?Q?4d4LEXJf+OHlwl/IxjkaG9ak4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f2072-8e97-4b09-aae1-08db1ba908d9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 05:35:01.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urMBy5VCTytUnG9RNzmWe4lPsNZ5KYiKbM4NmfMhgIofQcyD4A0rjvd6WDIl4l/AbPMHYBxS6rbp3i9vPX6S5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 03/03/2023 4:36, Junxian Huang wrote:
> 
> 
> On 2023/2/26 21:57, Mark Bloch wrote:
>>
>>
>> On 26/02/2023 14:53, Leon Romanovsky wrote:
>>> +Mark
>>>
>>> On Fri, Feb 24, 2023 at 11:14:47AM +0000, huangjunxian (C) wrote:
>>>> Hi folks!
>>>>
>>>> We've been working on LAG in hns RoCE driver, and we notice that when a FAILOVER event
>>>> occurs in active-backup mode, all GIDs of the RDMA bond device are deleted and new GIDs
>>>> are added, triggered by the event handler listed below.
>>>>
>>>> So, when a FAILOVER event occurs on a RDMA bond device with running traffic, does it make
>>>> sense that the traffic is terminated since its GIDs are deleted?
>>
>> Yep, please read the original commit message:
>>
>> commit 238fdf48f2b54a01cedb5774c3a1e81c94e1a3a0
>> Author: Matan Barak <matanb@mellanox.com>
>> Date:   Thu Jul 30 18:33:27 2015 +0300
>>
>>     IB/core: Add RoCE table bonding support
>>
>>     Handling bonding and other devices require us to all all GIDs of the
>>     net-devices which are upper-devices of the RoCE port related
>>     net-device.
>>
>>     Active-backup configurations imposes even more challenges as the
>>     default GID should only be set on the active devices (this is
>>     necessary as otherwise the same MAC could be used for several
>>     slaves and thus several slaves will have identical GIDs).
>>
>>     Managing these configurations are done by listening to:
>>     (a) NETDEV_CHANGEUPPER event
>>             (1) if a related net-device is linked, delete all inactive
>>                 slaves default GIDs and add the upper device GIDs.
>>             (2) if a related net-device is unlinked, delete all upper GIDs
>>                 and add the default GIDs.
>>     (b) NETDEV_BONDING_FAILOVER:
>>             (1) delete the bond GIDs from inactive slaves
>>             (2) delete the inactive slave's default GIDs
>>             (3) Add the bond GIDs to the active slave.
>>
>>     Signed-off-by: Matan Barak <matanb@mellanox.com>
>>     Signed-off-by: Doug Ledford <dledford@redhat.com>
>>
>> and please read: https://wiki.linuxfoundation.org/networking/bonding
>> especially the section that explains some of the restrictions of
>> active-backup mode.
>>
>> Mark
>>
>>>>
>>>> The FAILOVER event handler mentioned above:
>>>> static int netdevice_event(struct notifier_block *this, unsigned long event, void *ptr)
>>>> {
>>>>          ......
>>>>          static const struct netdev_event_work_cmd bonding_event_ips_del_cmd = {
>>>>                   .cb = del_netdev_upper_ips, .filter = upper_device_filter};
>>>>          ......
>>>>          switch (event) {
>>>>          ......
>>>>          case NETDEV_BONDING_FAILOVER:
>>>>                   cmds[0] = bonding_event_ips_del_cmd;
>>>>                   /* Add default GIDs of the bond device */
>>>>                   cmds[1] = bonding_default_add_cmd;
>>>>                   /* Add IP based GIDs of the bond device */
>>>>                   cmds[2] = add_cmd_upper_ips;
>>>>                   break;
>>>>          ......
>>>>          }
>>>>          ......
>>>> }
>>>>
>>>> Thanks,
>>>> Junxian
> 
> Thanks for replying. I'd like to explain my question more specifically.
> 
> When a GID is deleted, the GID index is not reusable until all references
> are dropped, according to this commit message:
> 
> commit be5914c124bc3179536e5c4598f59aeb4b880517
> Author: Parav Pandit <parav@mellanox.com>
> Date:   Tue Dec 18 14:16:00 2018 +0200
> 
>     RDMA/core: Delete RoCE GID in hw when corresponding IP is deleted
> 
>     Currently a RoCE GID entry is removed from the hardware when all
>     references to the GID entry drop to zero. This is a change in behavior
>     from before the fixed patch. The GID entry should be removed from the
>     hardware when GID entry deletion is requested. This allows the driver
>     terminate ongoing traffic through the RoCE GID.
> 
>     While a GID is deleted from the hardware, GID slot in the software GID
>     cache is not freed. GID slot is freed once all references of such GID are
>     dropped. This continue to ensure that such GID slot of hardware is not
>     allocated to new GID entry allocation request. It is allocated once all
>     references to GID entry drop.
> 
>     This approach allows drivers to put a tombestone of some kind on the HW
>     GID index to block the traffic.
> 
>     Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
>     Signed-off-by: Parav Pandit <parav@mellanox.com>
>     Reviewed-by: Mark Bloch <markb@mellanox.com>
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Assume that a RoCE bond device is running RoCE traffic with a GID in index 3.
> 
> When a FAILOVER event occurs, the original GIDs in index 0-3 are deleted
> and new GIDs are added. As the QP is still holding a reference to index 3,
> the new GIDs are not added to index 0-3 but to index 0-2 and index 4.
> 
> Due to the deletion of the original GID in index 3, the RoCE traffic is
> terminated. Although a backup slave becomes active, the traffic will
> not recover anymore as the new GID is not added to index 3 and there is no
> valid GID in index 3. This means the active-backup mode in RoCE LAG cannot
> maintain ongoing RoCE traffic when a FAILOVER event happens.

If you want fault tolerance and keep the traffic going you should use LACP.

> 
> Are the phenomenon and conclusion here correct? This seems odd to me because
> as far as I know, there is no such restriction on the active-backup mode in
> NIC Bonding.

You are talking about netdev bonding I assume. With netdev traffic you can
control which netdev is used so traffic won't egress from multiple physical
ports (this is what the bond is for). With RDMA we can't control that as the
QP is used by a user (kernel / userspace) so if the traffic won't be stopped
the switch will see the same source MAC address from two different ports.

Of course there can be other solutions, for example you can make sure only 1
physical port is used for egress (with steering or with
blocking traffic going via the slave port). If your hardware can do something
like that it should be possible to support that.

Mark

> 
> Junxian
> 
> 
> 
> 
> 
> 
> 
> 
> 
